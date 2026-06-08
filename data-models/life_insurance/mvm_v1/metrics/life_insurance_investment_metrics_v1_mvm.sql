-- Metric views for domain: investment | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 06:54:29

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_asset_holding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core investment portfolio holdings metrics tracking fair market value, book value, unrealized gains/losses, yield, duration, and credit quality composition. Used by CIO, portfolio managers, and risk officers to monitor asset allocation, valuation, and risk-adjusted positioning across the general account."
  source: "`life_insurance_ecm`.`investment`.`asset_holding`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Broad asset class (e.g., Fixed Income, Equity, Alternatives) for portfolio composition analysis."
    - name: "asset_subtype"
      expr: asset_subtype
      comment: "Granular asset subtype within the asset class for detailed allocation reporting."
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC credit quality designation (1-6) used for RBC charge calculation and regulatory reporting."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External credit rating (e.g., AAA, BBB) for credit quality distribution analysis."
    - name: "issuer_sector"
      expr: issuer_sector
      comment: "Issuer industry sector for concentration risk and sector allocation monitoring."
    - name: "issuer_country_code"
      expr: issuer_country_code
      comment: "Country of issuer for geographic concentration and sovereign risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency denomination of the holding for FX exposure reporting."
    - name: "holding_status"
      expr: holding_status
      comment: "Current status of the holding (e.g., Active, Sold, Matured) for active portfolio filtering."
    - name: "liquidity_classification"
      expr: liquidity_classification
      comment: "Liquidity tier classification for liquidity risk management and stress testing."
    - name: "naic_schedule_code"
      expr: naic_schedule_code
      comment: "NAIC Schedule (D, B, BA, etc.) for statutory filing categorization."
    - name: "impairment_flag"
      expr: impairment_flag
      comment: "Indicates whether the holding has been impaired, used to isolate credit-impaired positions."
    - name: "as_of_date"
      expr: as_of_date
      comment: "Valuation date of the holding snapshot for time-series trend analysis."
  measures:
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Total fair market value of all holdings. Primary AUM metric used by CIO and CFO to track invested asset base and portfolio size."
    - name: "total_book_value"
      expr: SUM(CAST(book_value AS DOUBLE))
      comment: "Total book (carrying) value of holdings. Used alongside FMV to assess unrealized gain/loss exposure at the portfolio level."
    - name: "total_amortized_cost"
      expr: SUM(CAST(amortized_cost AS DOUBLE))
      comment: "Total amortized cost basis of fixed income holdings. Key for GAAP/SAP income recognition and impairment testing."
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Net unrealized gain or loss across all holdings. Directly impacts AOCI, surplus, and RBC ratios — a critical risk and capital metric."
    - name: "total_par_value"
      expr: SUM(CAST(par_value AS DOUBLE))
      comment: "Total par (face) value of fixed income holdings. Used for maturity profile and cash flow projection analysis."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest AS DOUBLE))
      comment: "Total accrued interest receivable across holdings. Impacts net investment income and cash flow forecasting."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total credit impairment charges recognized on holdings. Directly affects P&L and capital adequacy — monitored by CFO and credit risk committee."
    - name: "total_rbc_charge"
      expr: SUM(CAST(naic_rbc_factor AS DOUBLE) * CAST(fair_market_value AS DOUBLE))
      comment: "Estimated total RBC C-1 asset risk charge across holdings (factor × FMV). Critical for capital adequacy monitoring and regulatory compliance."
    - name: "avg_yield_to_maturity"
      expr: AVG(CAST(yield_to_maturity AS DOUBLE))
      comment: "Average yield to maturity across holdings. Key portfolio income metric used by portfolio managers to assess return generation capacity."
    - name: "avg_duration_years"
      expr: AVG(CAST(duration_years AS DOUBLE))
      comment: "Average modified duration of holdings in years. Core ALM metric used to assess interest rate sensitivity and liability matching."
    - name: "avg_coupon_rate"
      expr: AVG(CAST(coupon_rate AS DOUBLE))
      comment: "Average coupon rate across fixed income holdings. Indicates the contractual income yield of the bond portfolio."
    - name: "impaired_holding_count"
      expr: COUNT(CASE WHEN impairment_flag = TRUE THEN asset_holding_id END)
      comment: "Number of holdings with recognized impairments. Tracks credit deterioration breadth across the portfolio for risk committee review."
    - name: "total_holding_count"
      expr: COUNT(1)
      comment: "Total number of holding positions. Used for diversification analysis and operational capacity planning."
    - name: "distinct_issuer_count"
      expr: COUNT(DISTINCT issuer_sector)
      comment: "Number of distinct issuer sectors represented in the portfolio. Proxy for sector diversification — low counts signal concentration risk."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio-level strategic performance and compliance metrics covering actual vs. target allocation, duration positioning, YTD performance, and compliance status. Used by the Investment Committee, CIO, and ALM team to govern portfolio strategy and mandate adherence."
  source: "`life_insurance_ecm`.`investment`.`portfolio`"
  dimensions:
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Portfolio type (e.g., General Account, Separate Account, Pension) for segment-level performance comparison."
    - name: "portfolio_status"
      expr: portfolio_status
      comment: "Operational status of the portfolio (Active, Closed, Pending) for filtering live portfolios."
    - name: "alm_classification"
      expr: alm_classification
      comment: "ALM segment classification for liability-matching analysis and duration gap monitoring."
    - name: "asset_class"
      expr: asset_class
      comment: "Primary asset class mandate of the portfolio for allocation strategy reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Base currency of the portfolio for multi-currency exposure analysis."
    - name: "risk_tolerance_tier"
      expr: risk_tolerance_tier
      comment: "Risk tolerance classification (Conservative, Moderate, Aggressive) for risk-stratified performance analysis."
    - name: "investment_mandate"
      expr: investment_mandate
      comment: "Investment mandate description for mandate compliance and strategy alignment reporting."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean compliance flag indicating whether the portfolio is within all investment guidelines."
    - name: "rebalancing_frequency"
      expr: rebalancing_frequency
      comment: "Scheduled rebalancing frequency (Monthly, Quarterly, etc.) for operational governance tracking."
    - name: "naic_schedule_classification"
      expr: naic_schedule_classification
      comment: "NAIC schedule classification for statutory reporting categorization."
    - name: "rbc_charge_category"
      expr: rbc_charge_category
      comment: "RBC charge category for capital requirement segmentation and regulatory capital planning."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Most recent valuation date for the portfolio, used for point-in-time performance snapshots."
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(actual_market_value AS DOUBLE))
      comment: "Total actual market value across all portfolios. Primary AUM measure used by CIO and CFO for enterprise asset base reporting."
    - name: "avg_performance_ytd_pct"
      expr: AVG(CAST(performance_ytd_pct AS DOUBLE))
      comment: "Average year-to-date portfolio return percentage. Core investment performance KPI reviewed at every Investment Committee meeting."
    - name: "avg_benchmark_ytd_pct"
      expr: AVG(CAST(benchmark_ytd_pct AS DOUBLE))
      comment: "Average year-to-date benchmark return percentage. Used alongside actual YTD return to compute active return (alpha) vs. benchmark."
    - name: "avg_actual_duration_years"
      expr: AVG(CAST(actual_duration_years AS DOUBLE))
      comment: "Average actual portfolio duration in years. Core ALM metric — deviation from target duration signals interest rate risk exposure."
    - name: "avg_target_duration_years"
      expr: AVG(CAST(target_duration_years AS DOUBLE))
      comment: "Average target duration in years as set by the ALM strategy. Paired with actual duration to compute duration gap."
    - name: "avg_duration_gap"
      expr: AVG(CAST(actual_duration_years AS DOUBLE) - CAST(target_duration_years AS DOUBLE))
      comment: "Average duration gap (actual minus target) across portfolios. Negative gap signals asset duration shortfall vs. liabilities — triggers ALM rebalancing action."
    - name: "non_compliant_portfolio_count"
      expr: COUNT(CASE WHEN is_compliant = FALSE THEN portfolio_id END)
      comment: "Number of portfolios currently out of compliance with investment guidelines. Directly triggers Investment Committee review and remediation action."
    - name: "total_portfolio_count"
      expr: COUNT(1)
      comment: "Total number of active portfolios. Used for operational capacity and governance coverage analysis."
    - name: "avg_strategic_fixed_income_target_pct"
      expr: AVG(CAST(strategic_fixed_income_target_pct AS DOUBLE))
      comment: "Average strategic fixed income target allocation percentage. Reflects the long-term asset allocation strategy for liability matching."
    - name: "avg_tactical_equity_weight_pct"
      expr: AVG(CAST(tactical_equity_weight_pct AS DOUBLE))
      comment: "Average current tactical equity weight. Compared to strategic target to assess tactical tilt and risk-on/risk-off positioning."
    - name: "avg_max_single_issuer_concentration_pct"
      expr: AVG(CAST(max_single_issuer_concentration_pct AS DOUBLE))
      comment: "Average maximum single-issuer concentration limit across portfolios. Monitors concentration risk governance thresholds."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_alm_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset-Liability Management (ALM) analytics metrics covering duration gap, convexity gap, DV01 sensitivity, interest rate scenario impacts, and RBC C-3 charges. Used by the ALM Committee, CRO, and CFO to manage interest rate risk, ensure liability matching, and satisfy ORSA/RBC regulatory requirements."
  source: "`life_insurance_ecm`.`investment`.`alm_analysis`"
  dimensions:
    - name: "alm_strategy_type"
      expr: alm_strategy_type
      comment: "ALM strategy type (e.g., Cash Flow Matching, Duration Matching, Immunization) for strategy-level risk analysis."
    - name: "gap_status"
      expr: gap_status
      comment: "Duration gap status (e.g., Within Tolerance, Breach, Warning) for ALM exception monitoring and escalation."
    - name: "alm_committee_decision"
      expr: alm_committee_decision
      comment: "ALM Committee decision outcome (e.g., Approved, Remediation Required) for governance tracking."
    - name: "orsa_interest_rate_risk_scenario"
      expr: orsa_interest_rate_risk_scenario
      comment: "ORSA interest rate stress scenario applied (e.g., +200bp, -100bp) for regulatory scenario analysis."
    - name: "alm_committee_review_date"
      expr: alm_committee_review_date
      comment: "Date of ALM Committee review for governance cadence and timeliness monitoring."
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the ALM measurement snapshot for time-series trend analysis of duration and gap metrics."
  measures:
    - name: "avg_duration_gap"
      expr: AVG(CAST(duration_gap AS DOUBLE))
      comment: "Average duration gap (asset duration minus liability duration) across ALM analyses. The primary ALM risk metric — a large positive or negative gap signals material interest rate risk requiring immediate action."
    - name: "avg_asset_duration"
      expr: AVG(CAST(asset_duration AS DOUBLE))
      comment: "Average asset portfolio duration in years. Compared to liability duration to assess ALM positioning."
    - name: "avg_liability_duration"
      expr: AVG(CAST(liability_duration AS DOUBLE))
      comment: "Average liability duration in years. Core input to duration gap calculation and ALM strategy design."
    - name: "avg_convexity_gap"
      expr: AVG(CAST(convexity_gap AS DOUBLE))
      comment: "Average convexity gap between assets and liabilities. Convexity mismatches amplify duration gap risk in large rate moves — monitored by the ALM Committee."
    - name: "total_dv01"
      expr: SUM(CAST(dv01 AS DOUBLE))
      comment: "Total DV01 (dollar value of a 1 basis point rate move) across all ALM segments. Quantifies aggregate interest rate sensitivity in dollar terms — key for hedging program sizing."
    - name: "total_rbc_c3_charge"
      expr: SUM(CAST(rbc_c3_interest_rate_risk_charge AS DOUBLE))
      comment: "Total RBC C-3 interest rate risk charge across all ALM analyses. Directly impacts required capital and RBC ratio — monitored by CFO and actuarial team."
    - name: "avg_ir_sensitivity_up_100bp"
      expr: AVG(CAST(interest_rate_sensitivity_parallel_shift_up_100bp AS DOUBLE))
      comment: "Average portfolio value change under a parallel +100bp rate shock. Quantifies upside rate risk for stress testing and ORSA reporting."
    - name: "avg_ir_sensitivity_down_100bp"
      expr: AVG(CAST(interest_rate_sensitivity_parallel_shift_down_100bp AS DOUBLE))
      comment: "Average portfolio value change under a parallel -100bp rate shock. Quantifies downside rate risk — critical in low-rate environments for annuity and life reserve adequacy."
    - name: "avg_dollar_duration"
      expr: AVG(CAST(dollar_duration AS DOUBLE))
      comment: "Average dollar duration (modified duration × market value) across ALM segments. Used to size interest rate hedges and rebalancing trades."
    - name: "gap_breach_count"
      expr: COUNT(CASE WHEN gap_status = 'Breach' THEN alm_analysis_id END)
      comment: "Number of ALM analyses where the duration gap exceeds tolerance thresholds. Triggers mandatory ALM Committee review and remediation planning."
    - name: "avg_key_rate_duration_10yr"
      expr: AVG(CAST(key_rate_duration_10yr AS DOUBLE))
      comment: "Average 10-year key rate duration. The 10yr point is the most critical for life insurance liability matching — used to target hedging at the dominant liability cash flow bucket."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment valuation metrics covering fair market value, unrealized gains/losses, RBC charges, derivative Greeks, and pricing quality. Used by portfolio managers, risk officers, and finance teams for daily mark-to-market monitoring, derivative risk management, and statutory/GAAP reporting."
  source: "`life_insurance_ecm`.`investment`.`valuation`"
  dimensions:
    - name: "fair_value_hierarchy_level"
      expr: fair_value_hierarchy_level
      comment: "ASC 820 fair value hierarchy level (Level 1, 2, 3) for valuation transparency and audit risk assessment."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Valuation methodology (e.g., Market Quote, Model, Matrix Pricing) for pricing quality and model risk monitoring."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of pricing data (e.g., Bloomberg, ICE, Internal Model) for data quality and vendor dependency analysis."
    - name: "naic_valuation_method"
      expr: naic_valuation_method
      comment: "NAIC statutory valuation method for SAP reporting compliance."
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation record (e.g., Approved, Pending, Stale) for operational completeness monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the valuation for multi-currency portfolio reporting."
    - name: "valuation_date"
      expr: valuation_date
      comment: "Date of the valuation for time-series fair value trend analysis."
  measures:
    - name: "total_fmv"
      expr: SUM(CAST(total_fmv AS DOUBLE))
      comment: "Total fair market value across all valued positions. Primary mark-to-market AUM metric used by CFO and portfolio managers for daily NAV and balance sheet reporting."
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Net unrealized gain or loss across all positions. Directly impacts AOCI, surplus, and RBC ratios — a critical capital and risk metric reviewed daily."
    - name: "total_amortized_cost"
      expr: SUM(CAST(amortized_cost AS DOUBLE))
      comment: "Total amortized cost basis of valued positions. Used to compute the unrealized gain/loss ratio and assess the magnitude of mark-to-market exposure."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest AS DOUBLE))
      comment: "Total accrued interest across valued positions. Impacts net investment income recognition and cash flow projections."
    - name: "total_rbc_charge"
      expr: SUM(CAST(rbc_charge AS DOUBLE))
      comment: "Total RBC risk charge across all valued positions. Directly determines required regulatory capital — monitored by CFO and actuarial team for RBC ratio management."
    - name: "total_dv01"
      expr: SUM(CAST(dv01 AS DOUBLE))
      comment: "Total DV01 across all valued positions. Aggregate interest rate sensitivity in dollar terms — used to size and validate the interest rate hedging program."
    - name: "total_variation_margin_call"
      expr: SUM(CAST(variation_margin_call AS DOUBLE))
      comment: "Total variation margin calls outstanding across derivative positions. Liquidity risk indicator — large margin calls can stress short-term cash management."
    - name: "total_collateral_balance"
      expr: SUM(CAST(collateral_balance AS DOUBLE))
      comment: "Total collateral balance posted or held across derivative positions. Monitors counterparty credit risk mitigation and liquidity usage."
    - name: "avg_delta"
      expr: AVG(CAST(delta AS DOUBLE))
      comment: "Average delta across derivative positions. Measures aggregate directional equity/rate exposure of the derivatives book — used by the hedging desk to maintain delta-neutral positions."
    - name: "avg_fmv_per_unit"
      expr: AVG(CAST(fmv_per_unit AS DOUBLE))
      comment: "Average fair market value per unit across positions. Used for unit value pricing validation and separate account NAV calculation."
    - name: "level3_position_count"
      expr: COUNT(CASE WHEN fair_value_hierarchy_level = 'Level 3' THEN valuation_id END)
      comment: "Number of Level 3 (model-valued, illiquid) positions. High Level 3 counts signal valuation uncertainty and model risk — triggers enhanced audit scrutiny and disclosure requirements."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_trade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade activity and execution quality metrics covering transaction volumes, costs, compliance status, and ALM impact. Used by portfolio managers, traders, compliance officers, and the Investment Committee to monitor trading activity, execution quality, and pre/post-trade compliance."
  source: "`life_insurance_ecm`.`investment`.`trade`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of trade order (e.g., Market, Limit, Stop) for execution strategy analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current order status (e.g., Filled, Pending, Cancelled) for trade lifecycle monitoring."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status (e.g., Settled, Failed, Pending) for settlement risk and operational efficiency monitoring."
    - name: "pre_trade_compliance_status"
      expr: pre_trade_compliance_status
      comment: "Pre-trade compliance check result (Pass/Fail) for investment guideline enforcement monitoring."
    - name: "post_trade_compliance_status"
      expr: post_trade_compliance_status
      comment: "Post-trade compliance check result (Pass/Fail) for regulatory and guideline breach detection."
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC designation of the traded security for RBC impact analysis by asset quality tier."
    - name: "execution_venue"
      expr: execution_venue
      comment: "Venue where the trade was executed (e.g., NYSE, OTC, Dark Pool) for best execution analysis."
    - name: "securities_lending_flag"
      expr: securities_lending_flag
      comment: "Indicates whether the trade is a securities lending transaction for income and risk segregation."
    - name: "execution_date"
      expr: execution_date
      comment: "Date the trade was executed for time-series trading activity and volume trend analysis."
  measures:
    - name: "total_transaction_cost"
      expr: SUM(CAST(total_transaction_cost AS DOUBLE))
      comment: "Total transaction costs (commissions + fees) across all trades. Directly impacts net investment return — monitored by portfolio managers and CFO for cost efficiency."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total broker commissions paid. Used for broker performance evaluation and best execution compliance."
    - name: "total_transaction_fee_amount"
      expr: SUM(CAST(transaction_fee_amount AS DOUBLE))
      comment: "Total transaction fees (exchange, clearing, regulatory) paid. Operational cost metric for trading desk efficiency."
    - name: "total_executed_notional"
      expr: SUM(CAST(executed_price AS DOUBLE) * CAST(executed_quantity AS DOUBLE))
      comment: "Total executed notional value (price × quantity) across all trades. Primary trading volume metric used by the Investment Committee to monitor portfolio turnover and activity."
    - name: "total_alm_duration_impact"
      expr: SUM(CAST(alm_duration_impact AS DOUBLE))
      comment: "Cumulative ALM duration impact of all trades. Measures how trading activity is shifting the portfolio duration toward or away from the ALM target — critical for ALM governance."
    - name: "total_rbc_investment_risk_charge"
      expr: SUM(CAST(rbc_investment_risk_charge AS DOUBLE))
      comment: "Total RBC investment risk charge generated by trades. Monitors the capital cost of new investment activity — used by CFO to manage RBC ratio impact of trading decisions."
    - name: "pre_trade_compliance_fail_count"
      expr: COUNT(CASE WHEN pre_trade_compliance_status = 'Fail' THEN trade_id END)
      comment: "Number of trades that failed pre-trade compliance checks. Compliance KPI — high counts indicate investment guideline violations requiring immediate investigation."
    - name: "post_trade_compliance_fail_count"
      expr: COUNT(CASE WHEN post_trade_compliance_status = 'Fail' THEN trade_id END)
      comment: "Number of trades that failed post-trade compliance checks. Regulatory risk indicator — post-trade failures may require regulatory reporting and remediation."
    - name: "settlement_fail_count"
      expr: COUNT(CASE WHEN settlement_status = 'Failed' THEN trade_id END)
      comment: "Number of trades with failed settlement. Operational risk metric — settlement failures incur penalties and counterparty risk exposure."
    - name: "total_trade_count"
      expr: COUNT(1)
      comment: "Total number of trades executed. Used for portfolio turnover analysis and trading desk capacity monitoring."
    - name: "avg_executed_price"
      expr: AVG(CAST(executed_price AS DOUBLE))
      comment: "Average executed price across trades. Used for execution quality benchmarking against limit and order prices."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_compliance_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment compliance breach metrics tracking breach frequency, severity, financial impact, RBC charges, and resolution timeliness. Used by the Chief Compliance Officer, Investment Committee, and regulators to monitor guideline adherence, escalate material breaches, and satisfy NAIC/state regulatory reporting requirements."
  source: "`life_insurance_ecm`.`investment`.`compliance_breach`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of compliance breach (e.g., Concentration Limit, Duration Constraint, Credit Quality) for root cause categorization."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification (Critical, High, Medium, Low) for risk-tiered escalation and prioritization."
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (Open, Remediated, Waived, Escalated) for lifecycle and resolution tracking."
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class associated with the breach for identifying which asset types generate the most compliance risk."
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC designation of the breaching asset for credit quality and RBC impact analysis."
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category of the breach for capital impact segmentation."
    - name: "detection_method"
      expr: detection_method
      comment: "How the breach was detected (Pre-Trade, Post-Trade, Periodic Review) for control effectiveness assessment."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Indicates whether the breach was escalated to regulators — critical for regulatory relationship management."
    - name: "alm_impact_flag"
      expr: alm_impact_flag
      comment: "Indicates whether the breach has ALM implications for cross-functional risk escalation."
    - name: "breach_date"
      expr: breach_date
      comment: "Date the breach occurred for trend analysis and regulatory reporting timelines."
  measures:
    - name: "total_breach_amount"
      expr: SUM(CAST(breach_amount AS DOUBLE))
      comment: "Total dollar amount of compliance breaches (excess over limit). Quantifies the financial magnitude of guideline violations — primary metric for Investment Committee and regulatory reporting."
    - name: "total_rbc_charge_impact"
      expr: SUM(CAST(rbc_charge_impact AS DOUBLE))
      comment: "Total RBC capital charge impact from compliance breaches. Directly affects required capital and RBC ratio — monitored by CFO and actuarial team."
    - name: "avg_breach_percentage"
      expr: AVG(CAST(breach_percentage AS DOUBLE))
      comment: "Average breach percentage (excess as % of limit) across all breaches. Indicates the typical severity of limit violations — high averages signal systemic guideline calibration issues."
    - name: "open_breach_count"
      expr: COUNT(CASE WHEN breach_status = 'Open' THEN compliance_breach_id END)
      comment: "Number of currently open (unresolved) compliance breaches. Primary compliance health KPI — high open counts trigger regulatory scrutiny and Investment Committee action."
    - name: "critical_breach_count"
      expr: COUNT(CASE WHEN breach_severity = 'Critical' THEN compliance_breach_id END)
      comment: "Number of critical severity breaches. Triggers mandatory escalation to senior management and potentially regulators — zero tolerance target."
    - name: "regulatory_escalation_count"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN compliance_breach_id END)
      comment: "Number of breaches escalated to regulators. Tracks regulatory relationship risk — each escalation requires formal response and remediation documentation."
    - name: "waiver_approved_count"
      expr: COUNT(CASE WHEN waiver_approved_flag = TRUE THEN compliance_breach_id END)
      comment: "Number of breaches resolved via approved waiver. High waiver counts may indicate overly restrictive guidelines or systemic portfolio management issues."
    - name: "total_breach_count"
      expr: COUNT(1)
      comment: "Total number of compliance breaches recorded. Baseline compliance activity metric for trend analysis and regulatory reporting."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value at time of breach. Compared to limit threshold to assess how far positions exceeded guidelines."
    - name: "avg_limit_threshold"
      expr: AVG(CAST(limit_threshold AS DOUBLE))
      comment: "Average compliance limit threshold across breaches. Used to assess whether limits are appropriately calibrated relative to actual portfolio positioning."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_derivative_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Derivative portfolio metrics covering notional exposure, fair value, collateral, RBC charges, and hedge program coverage. Used by the ALM team, risk officers, and CFO to manage interest rate and equity hedging programs, monitor counterparty credit risk, and satisfy NAIC Schedule DB and ISDA reporting requirements."
  source: "`life_insurance_ecm`.`investment`.`derivative_contract`"
  dimensions:
    - name: "derivative_type"
      expr: derivative_type
      comment: "Type of derivative instrument (e.g., Interest Rate Swap, Swaption, Equity Option) for risk type segmentation."
    - name: "derivative_subtype"
      expr: derivative_subtype
      comment: "Subtype of derivative for granular instrument-level risk analysis."
    - name: "hedge_designation"
      expr: hedge_designation
      comment: "Hedge accounting designation (Fair Value Hedge, Cash Flow Hedge, Economic Hedge) for accounting treatment and effectiveness monitoring."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (Active, Terminated, Matured) for active exposure monitoring."
    - name: "alm_segment"
      expr: alm_segment
      comment: "ALM segment the derivative is assigned to for liability-matching hedge program analysis."
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category for capital charge segmentation of the derivatives book."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the derivative contract for FX exposure analysis."
    - name: "gmdb_hedge_flag"
      expr: gmdb_hedge_flag
      comment: "Indicates whether the derivative hedges GMDB (Guaranteed Minimum Death Benefit) — critical for variable annuity guarantee risk management."
    - name: "gmwb_hedge_flag"
      expr: gmwb_hedge_flag
      comment: "Indicates whether the derivative hedges GMWB (Guaranteed Minimum Withdrawal Benefit) — key for living benefit hedge program monitoring."
    - name: "fair_value_hierarchy_level"
      expr: fair_value_hierarchy_level
      comment: "ASC 820 fair value hierarchy level for valuation transparency and audit risk."
    - name: "trade_date"
      expr: trade_date
      comment: "Trade date of the derivative contract for vintage analysis and hedge program timeline tracking."
  measures:
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Total notional amount of all derivative contracts. Primary measure of gross derivative exposure — used by CRO and ALM team to size the hedging program relative to liability exposure."
    - name: "total_current_fmv"
      expr: SUM(CAST(current_fmv AS DOUBLE))
      comment: "Total current fair market value of all derivative positions. Net derivative asset/liability position — impacts balance sheet, surplus, and RBC ratios."
    - name: "total_collateral_posted"
      expr: SUM(CAST(collateral_posted AS DOUBLE))
      comment: "Total collateral posted to counterparties. Liquidity usage metric — large collateral postings under stress scenarios can strain cash management."
    - name: "total_collateral_received"
      expr: SUM(CAST(collateral_received AS DOUBLE))
      comment: "Total collateral received from counterparties. Reduces net counterparty credit exposure — monitored for adequacy relative to positive FMV positions."
    - name: "total_rbc_charge"
      expr: SUM(CAST(rbc_charge AS DOUBLE))
      comment: "Total RBC charge across all derivative contracts. Capital cost of the derivatives book — monitored by CFO for RBC ratio management."
    - name: "gmdb_hedge_notional"
      expr: SUM(CASE WHEN gmdb_hedge_flag = TRUE THEN CAST(notional_amount AS DOUBLE) ELSE 0 END)
      comment: "Total notional of GMDB hedge derivatives. Measures the size of the guaranteed minimum death benefit hedging program relative to in-force GMDB exposure."
    - name: "gmwb_hedge_notional"
      expr: SUM(CASE WHEN gmwb_hedge_flag = TRUE THEN CAST(notional_amount AS DOUBLE) ELSE 0 END)
      comment: "Total notional of GMWB hedge derivatives. Measures the size of the guaranteed minimum withdrawal benefit hedging program — critical for variable annuity risk management."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'Active' THEN derivative_contract_id END)
      comment: "Number of active derivative contracts. Operational metric for derivatives desk capacity and counterparty relationship management."
    - name: "avg_strike_rate"
      expr: AVG(CAST(strike_rate AS DOUBLE))
      comment: "Average strike rate across derivative contracts. Used to assess the average cost of rate protection relative to current market rates."
    - name: "net_collateral_position"
      expr: SUM(CAST(collateral_received AS DOUBLE) - CAST(collateral_posted AS DOUBLE))
      comment: "Net collateral position (received minus posted) across all derivative contracts. Positive value indicates net collateral inflow; negative indicates net liquidity usage from derivatives."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_income_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment income allocation metrics tracking gross and net income, withholding taxes, amortization, and income distribution by type and product line. Used by the CFO, investment accounting team, and actuaries to monitor net investment income, validate income recognition, and support GAAP/SAP financial reporting."
  source: "`life_insurance_ecm`.`investment`.`income_allocation`"
  dimensions:
    - name: "income_type"
      expr: income_type
      comment: "Primary income type (e.g., Interest, Dividend, Rental, Capital Gain) for income source analysis."
    - name: "income_subtype"
      expr: income_subtype
      comment: "Granular income subtype for detailed income classification and reporting."
    - name: "income_status"
      expr: income_status
      comment: "Status of the income record (e.g., Accrued, Received, Reversed) for income recognition completeness monitoring."
    - name: "gaap_income_classification"
      expr: gaap_income_classification
      comment: "GAAP income classification for financial statement line item mapping."
    - name: "sap_income_classification"
      expr: sap_income_classification
      comment: "SAP (Statutory Accounting Principles) income classification for regulatory financial reporting."
    - name: "product_line"
      expr: product_line
      comment: "Product line (e.g., Term Life, Whole Life, Annuity) for income attribution by business segment."
    - name: "alm_segment"
      expr: alm_segment
      comment: "ALM segment for income attribution to liability segments — supports crediting rate and spread analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the income allocation for multi-currency income reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the record is a reversal entry — used to isolate original vs. corrected income amounts."
    - name: "payment_date"
      expr: payment_date
      comment: "Date income was received/paid for cash flow timing analysis."
  measures:
    - name: "total_gross_income_amount"
      expr: SUM(CAST(gross_income_amount AS DOUBLE))
      comment: "Total gross investment income before taxes and deductions. Primary net investment income (NII) input — a key driver of life insurance profitability and policyholder crediting rates."
    - name: "total_net_income_amount"
      expr: SUM(CAST(net_income_amount AS DOUBLE))
      comment: "Total net investment income after withholding taxes and deductions. The bottom-line NII figure used in GAAP/SAP income statements and spread analysis."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total income allocated to specific portfolios, products, or policyholders. Used to validate income distribution completeness and support policyholder crediting calculations."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from investment income. Tax efficiency metric — monitored by tax and finance teams to optimize after-tax yield."
    - name: "total_amortization_amount"
      expr: SUM(CAST(amortization_amount AS DOUBLE))
      comment: "Total premium/discount amortization on fixed income holdings. Impacts book yield and GAAP income recognition — monitored by investment accounting."
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest AS DOUBLE))
      comment: "Total accrued interest income receivable. Cash flow timing metric — large accrued balances relative to received income may signal collection risk."
    - name: "total_investment_income_due"
      expr: SUM(CAST(investment_income_due AS DOUBLE))
      comment: "Total investment income due but not yet received. Monitors income receivable aging — overdue amounts may indicate issuer credit stress."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average income allocation percentage across records. Used to validate that income allocation methodologies are distributing income proportionally across portfolios and products."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied to investment income. Monitors effective tax drag on investment returns — used by tax team to identify treaty optimization opportunities."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_separate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Separate account fund performance and risk metrics covering NAV, unit values, expense ratios, daily returns, and RBC charges. Used by product managers, variable annuity portfolio managers, and compliance officers to monitor fund performance, policyholder value, and SEC/FINRA regulatory compliance."
  source: "`life_insurance_ecm`.`investment`.`separate_account`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Fund type (e.g., Equity, Fixed Income, Balanced, Money Market) for fund category performance comparison."
    - name: "separate_account_status"
      expr: separate_account_status
      comment: "Operational status of the separate account (Active, Closed, Suspended) for active fund filtering."
    - name: "investment_objective"
      expr: investment_objective
      comment: "Fund investment objective (e.g., Growth, Income, Capital Preservation) for objective-aligned performance analysis."
    - name: "naic_investment_category"
      expr: naic_investment_category
      comment: "NAIC investment category for statutory reporting and RBC charge classification."
    - name: "guaranteed_benefit_flag"
      expr: guaranteed_benefit_flag
      comment: "Indicates whether the fund supports guaranteed benefits (GMDB/GMWB) — critical for hedging program alignment."
    - name: "sec_registered_flag"
      expr: sec_registered_flag
      comment: "Indicates whether the fund is SEC-registered — determines regulatory reporting obligations."
    - name: "finra_oversight_flag"
      expr: finra_oversight_flag
      comment: "Indicates whether the fund is subject to FINRA oversight for compliance monitoring."
    - name: "pricing_source"
      expr: pricing_source
      comment: "Source of fund pricing data for pricing quality and vendor dependency analysis."
    - name: "pricing_date"
      expr: pricing_date
      comment: "Most recent pricing date for fund NAV timeliness monitoring."
  measures:
    - name: "total_nav"
      expr: SUM(CAST(total_nav AS DOUBLE))
      comment: "Total net asset value across all separate account funds. Primary AUM metric for variable annuity and separate account business — directly impacts policyholder account values and company fee income."
    - name: "total_units_outstanding"
      expr: SUM(CAST(units_outstanding AS DOUBLE))
      comment: "Total units outstanding across all separate account funds. Measures the scale of policyholder participation — used for unit value calculation and fund capacity management."
    - name: "avg_accumulation_unit_value"
      expr: AVG(CAST(accumulation_unit_value AS DOUBLE))
      comment: "Average accumulation unit value across funds. Tracks policyholder account value growth — a key metric for variable annuity product performance reporting."
    - name: "avg_daily_return_rate"
      expr: AVG(CAST(daily_return_rate AS DOUBLE))
      comment: "Average daily return rate across separate account funds. Short-term performance indicator used for daily fund monitoring and anomaly detection."
    - name: "avg_expense_ratio"
      expr: AVG(CAST(expense_ratio AS DOUBLE))
      comment: "Average total expense ratio across funds. Directly impacts policyholder net returns and product competitiveness — monitored by product management and compliance."
    - name: "avg_mortality_and_expense_charge"
      expr: AVG(CAST(mortality_and_expense_charge AS DOUBLE))
      comment: "Average M&E charge across separate account funds. Key revenue and cost metric for variable annuity products — impacts policyholder net return and product pricing."
    - name: "total_rbc_investment_risk_charge"
      expr: SUM(CAST(rbc_investment_risk_charge AS DOUBLE))
      comment: "Total RBC investment risk charge across separate accounts. Regulatory capital requirement for the separate account business — monitored by CFO for RBC ratio management."
    - name: "avg_assumed_investment_return"
      expr: AVG(CAST(assumed_investment_return AS DOUBLE))
      comment: "Average assumed investment return (AIR) across annuity funds. The AIR determines annuity unit value changes — deviations from actual returns affect annuity payment amounts."
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN separate_account_status = 'Active' THEN separate_account_id END)
      comment: "Number of active separate account funds. Operational metric for fund lineup management and product shelf rationalization."
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_mortgage_loan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial mortgage loan portfolio metrics covering loan balances, LTV ratios, DSCR, credit quality, and impairment status. Used by portfolio managers, credit analysts, and the Investment Committee to monitor commercial real estate credit risk, loan performance, and NAIC Schedule B regulatory reporting."
  source: "`life_insurance_ecm`.`investment`.`mortgage_loan`"
  dimensions:
    - name: "loan_status"
      expr: loan_status
      comment: "Current loan status (Current, Delinquent, Default, Foreclosure) for credit quality monitoring and loss provisioning."
    - name: "property_type"
      expr: property_type
      comment: "Property type (Office, Retail, Industrial, Multifamily, Hotel) for real estate sector concentration analysis."
    - name: "property_state"
      expr: property_state
      comment: "State of the mortgaged property for geographic concentration risk monitoring."
    - name: "interest_rate_type"
      expr: interest_rate_type
      comment: "Interest rate type (Fixed, Floating) for interest rate risk and repricing analysis."
    - name: "amortization_type"
      expr: amortization_type
      comment: "Amortization type (Fully Amortizing, Interest Only, Balloon) for cash flow and refinancing risk analysis."
    - name: "impairment_status"
      expr: impairment_status
      comment: "Impairment status (Not Impaired, Impaired, Watch List) for credit loss provisioning and CECL compliance."
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC designation for the mortgage loan for RBC charge and statutory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the loan for multi-currency portfolio reporting."
    - name: "origination_date"
      expr: origination_date
      comment: "Loan origination date for vintage analysis and cohort-based credit performance monitoring."
  measures:
    - name: "total_outstanding_principal_balance"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Total outstanding principal balance across all mortgage loans. Primary mortgage portfolio size metric — used by CIO and credit committee to monitor CRE exposure."
    - name: "total_book_value"
      expr: SUM(CAST(book_value AS DOUBLE))
      comment: "Total book value of mortgage loans. Used for balance sheet reporting and comparison to outstanding principal to assess net premium/discount."
    - name: "total_allowance_for_credit_losses"
      expr: SUM(CAST(allowance_for_credit_losses AS DOUBLE))
      comment: "Total allowance for credit losses (CECL reserve) across the mortgage portfolio. Directly impacts P&L and capital — monitored by CFO and credit risk committee."
    - name: "total_rbc_c1_charge"
      expr: SUM(CAST(rbc_c1_charge AS DOUBLE))
      comment: "Total RBC C-1 asset risk charge for the mortgage loan portfolio. Capital cost of CRE exposure — monitored for RBC ratio management."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across the mortgage portfolio. Primary credit risk metric for CRE loans — high LTV signals elevated loss severity risk in default scenarios."
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average debt service coverage ratio across the mortgage portfolio. Primary cash flow credit metric — DSCR below 1.0x indicates the property cannot service its debt from operations."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across mortgage loans. Portfolio yield metric — compared to market rates to assess reinvestment risk and portfolio income generation."
    - name: "impaired_loan_count"
      expr: COUNT(CASE WHEN impairment_status = 'Impaired' THEN mortgage_loan_id END)
      comment: "Number of impaired mortgage loans. Credit quality KPI — triggers enhanced monitoring, loss provisioning, and potential regulatory disclosure."
    - name: "total_loan_count"
      expr: COUNT(1)
      comment: "Total number of mortgage loans in the portfolio. Used for concentration analysis and portfolio granularity assessment."
    - name: "total_original_loan_amount"
      expr: SUM(CAST(original_loan_amount AS DOUBLE))
      comment: "Total original loan amount at origination. Used to compute paydown rates and assess portfolio seasoning relative to current outstanding balances."
$$;