-- Metric views for domain: investment | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core portfolio performance and allocation metrics for investment management and ALM oversight"
  source: "`life_insurance_ecm`.`investment`.`portfolio`"
  dimensions:
    - name: "portfolio_code"
      expr: portfolio_code
      comment: "Unique portfolio identifier for grouping and filtering"
    - name: "portfolio_type"
      expr: portfolio_type
      comment: "Classification of portfolio (e.g., general account, separate account)"
    - name: "portfolio_status"
      expr: portfolio_status
      comment: "Current operational status of the portfolio"
    - name: "asset_class"
      expr: asset_class
      comment: "Primary asset class of the portfolio"
    - name: "alm_classification"
      expr: alm_classification
      comment: "Asset-liability management segment classification"
    - name: "investment_mandate"
      expr: investment_mandate
      comment: "Investment strategy or mandate governing the portfolio"
    - name: "risk_tolerance_tier"
      expr: risk_tolerance_tier
      comment: "Risk tolerance classification for portfolio management"
    - name: "rbc_charge_category"
      expr: rbc_charge_category
      comment: "Risk-based capital charge category for regulatory reporting"
    - name: "valuation_year"
      expr: YEAR(valuation_date)
      comment: "Year of portfolio valuation for time-series analysis"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(valuation_date), '-', YEAR(valuation_date))
      comment: "Quarter and year of portfolio valuation"
  measures:
    - name: "total_portfolio_count"
      expr: COUNT(1)
      comment: "Total number of portfolios"
    - name: "total_market_value"
      expr: SUM(CAST(actual_market_value AS DOUBLE))
      comment: "Total market value across all portfolios"
    - name: "avg_market_value_per_portfolio"
      expr: AVG(CAST(actual_market_value AS DOUBLE))
      comment: "Average market value per portfolio"
    - name: "weighted_avg_duration"
      expr: AVG(CAST(actual_duration_years AS DOUBLE))
      comment: "Average duration in years across portfolios"
    - name: "total_ytd_performance"
      expr: SUM(CAST(performance_ytd_pct AS DOUBLE))
      comment: "Sum of year-to-date performance percentages"
    - name: "avg_ytd_performance"
      expr: AVG(CAST(performance_ytd_pct AS DOUBLE))
      comment: "Average year-to-date performance percentage across portfolios"
    - name: "total_benchmark_ytd"
      expr: SUM(CAST(benchmark_ytd_pct AS DOUBLE))
      comment: "Sum of benchmark year-to-date performance percentages"
    - name: "avg_benchmark_ytd"
      expr: AVG(CAST(benchmark_ytd_pct AS DOUBLE))
      comment: "Average benchmark year-to-date performance percentage"
    - name: "compliant_portfolio_count"
      expr: SUM(CASE WHEN is_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of portfolios currently in compliance with investment guidelines"
    - name: "non_compliant_portfolio_count"
      expr: SUM(CASE WHEN is_compliant = FALSE THEN 1 ELSE 0 END)
      comment: "Count of portfolios with compliance breaches"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_asset_holding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset-level valuation, risk, and performance metrics for investment portfolio management and regulatory reporting"
  source: "`life_insurance_ecm`.`investment`.`asset_holding`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Primary asset class classification"
    - name: "asset_subtype"
      expr: asset_subtype
      comment: "Detailed asset subtype classification"
    - name: "holding_status"
      expr: holding_status
      comment: "Current status of the asset holding"
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC credit quality designation for regulatory capital"
    - name: "credit_rating"
      expr: credit_rating
      comment: "External credit rating of the asset"
    - name: "rating_agency"
      expr: rating_agency
      comment: "Rating agency providing the credit rating"
    - name: "liquidity_classification"
      expr: liquidity_classification
      comment: "Liquidity tier classification for ALM and stress testing"
    - name: "issuer_sector"
      expr: issuer_sector
      comment: "Economic sector of the issuer"
    - name: "issuer_country_code"
      expr: issuer_country_code
      comment: "Country code of the issuer for geographic exposure analysis"
    - name: "naic_schedule_code"
      expr: naic_schedule_code
      comment: "NAIC statutory schedule code for regulatory reporting"
    - name: "account_type"
      expr: account_type
      comment: "Account type classification (general, separate, etc.)"
    - name: "impairment_flag"
      expr: impairment_flag
      comment: "Indicator of whether the asset is impaired"
    - name: "valuation_year"
      expr: YEAR(as_of_date)
      comment: "Year of asset valuation"
    - name: "valuation_quarter"
      expr: CONCAT('Q', QUARTER(as_of_date), '-', YEAR(as_of_date))
      comment: "Quarter and year of asset valuation"
  measures:
    - name: "total_holding_count"
      expr: COUNT(1)
      comment: "Total number of asset holdings"
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Total fair market value of all holdings"
    - name: "total_book_value"
      expr: SUM(CAST(book_value AS DOUBLE))
      comment: "Total book value of all holdings"
    - name: "total_amortized_cost"
      expr: SUM(CAST(amortized_cost AS DOUBLE))
      comment: "Total amortized cost basis of all holdings"
    - name: "total_unrealized_gain_loss"
      expr: SUM(CAST(unrealized_gain_loss AS DOUBLE))
      comment: "Total unrealized gains or losses across all holdings"
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest AS DOUBLE))
      comment: "Total accrued interest receivable"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recognized"
    - name: "avg_duration_years"
      expr: AVG(CAST(duration_years AS DOUBLE))
      comment: "Average duration in years across holdings"
    - name: "avg_yield_to_maturity"
      expr: AVG(CAST(yield_to_maturity AS DOUBLE))
      comment: "Average yield to maturity across fixed income holdings"
    - name: "avg_coupon_rate"
      expr: AVG(CAST(coupon_rate AS DOUBLE))
      comment: "Average coupon rate across fixed income holdings"
    - name: "impaired_holding_count"
      expr: SUM(CASE WHEN impairment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of holdings with impairment flags"
    - name: "distinct_issuer_count"
      expr: COUNT(DISTINCT issuer_sector)
      comment: "Count of distinct issuer sectors for diversification analysis"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_trade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade execution and compliance metrics for investment operations and best-execution oversight"
  source: "`life_insurance_ecm`.`investment`.`trade`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Type of trade order (market, limit, stop, etc.)"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the trade order"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the trade"
    - name: "pre_trade_compliance_status"
      expr: pre_trade_compliance_status
      comment: "Pre-trade compliance check result"
    - name: "post_trade_compliance_status"
      expr: post_trade_compliance_status
      comment: "Post-trade compliance check result"
    - name: "execution_venue"
      expr: execution_venue
      comment: "Venue where the trade was executed"
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC designation of the traded security"
    - name: "securities_lending_flag"
      expr: securities_lending_flag
      comment: "Indicator of whether the trade is a securities lending transaction"
    - name: "execution_year"
      expr: YEAR(execution_date)
      comment: "Year of trade execution"
    - name: "execution_quarter"
      expr: CONCAT('Q', QUARTER(execution_date), '-', YEAR(execution_date))
      comment: "Quarter and year of trade execution"
    - name: "execution_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month of trade execution for time-series analysis"
  measures:
    - name: "total_trade_count"
      expr: COUNT(1)
      comment: "Total number of trades executed"
    - name: "total_executed_quantity"
      expr: SUM(CAST(executed_quantity AS DOUBLE))
      comment: "Total quantity of securities traded"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission costs incurred"
    - name: "total_transaction_cost"
      expr: SUM(CAST(total_transaction_cost AS DOUBLE))
      comment: "Total transaction costs including commissions and fees"
    - name: "avg_executed_price"
      expr: AVG(CAST(executed_price AS DOUBLE))
      comment: "Average execution price per trade"
    - name: "avg_commission_per_trade"
      expr: AVG(CAST(commission_amount AS DOUBLE))
      comment: "Average commission cost per trade"
    - name: "total_collateral_value"
      expr: SUM(CAST(collateral_value AS DOUBLE))
      comment: "Total collateral value for securities lending trades"
    - name: "pre_trade_compliant_count"
      expr: SUM(CASE WHEN pre_trade_compliance_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of trades passing pre-trade compliance checks"
    - name: "post_trade_compliant_count"
      expr: SUM(CASE WHEN post_trade_compliance_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of trades passing post-trade compliance checks"
    - name: "securities_lending_trade_count"
      expr: SUM(CASE WHEN securities_lending_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of securities lending transactions"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_alm_gap_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset-liability management gap metrics for duration matching, interest rate risk, and regulatory capital oversight"
  source: "`life_insurance_ecm`.`investment`.`alm_gap_measurement`"
  dimensions:
    - name: "gap_status"
      expr: gap_status
      comment: "Status of the ALM gap (within tolerance, breach, etc.)"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of ALM measurement (duration, convexity, DV01, etc.)"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used for gap measurement"
    - name: "base_yield_curve"
      expr: base_yield_curve
      comment: "Base yield curve used for measurement"
    - name: "alm_committee_decision"
      expr: alm_committee_decision
      comment: "Decision made by the ALM committee regarding the gap"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the ALM measurement"
    - name: "measurement_year"
      expr: YEAR(measurement_date)
      comment: "Year of ALM gap measurement"
    - name: "measurement_quarter"
      expr: CONCAT('Q', QUARTER(measurement_date), '-', YEAR(measurement_date))
      comment: "Quarter and year of ALM gap measurement"
  measures:
    - name: "total_measurement_count"
      expr: COUNT(1)
      comment: "Total number of ALM gap measurements"
    - name: "total_asset_market_value"
      expr: SUM(CAST(asset_market_value AS DOUBLE))
      comment: "Total market value of assets in ALM analysis"
    - name: "total_liability_market_value"
      expr: SUM(CAST(liability_market_value AS DOUBLE))
      comment: "Total market value of liabilities in ALM analysis"
    - name: "avg_duration_gap"
      expr: AVG(CAST(duration_gap AS DOUBLE))
      comment: "Average duration gap between assets and liabilities"
    - name: "avg_convexity_gap"
      expr: AVG(CAST(convexity_gap AS DOUBLE))
      comment: "Average convexity gap between assets and liabilities"
    - name: "avg_dollar_duration_gap"
      expr: AVG(CAST(dollar_duration_gap AS DOUBLE))
      comment: "Average dollar duration gap"
    - name: "total_dv01_gap"
      expr: SUM(CAST(dv01_gap AS DOUBLE))
      comment: "Total DV01 gap (dollar value of a basis point change)"
    - name: "total_rbc_c3_charge"
      expr: SUM(CAST(rbc_c3_charge AS DOUBLE))
      comment: "Total RBC C3 interest rate risk charge"
    - name: "avg_hedge_ratio"
      expr: AVG(CAST(hedge_ratio AS DOUBLE))
      comment: "Average hedge ratio for interest rate risk management"
    - name: "total_surplus_at_risk"
      expr: SUM(CAST(surplus_at_risk AS DOUBLE))
      comment: "Total surplus at risk from interest rate movements"
    - name: "breach_count"
      expr: SUM(CASE WHEN gap_status = 'Breach' THEN 1 ELSE 0 END)
      comment: "Count of ALM gap measurements in breach status"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_compliance_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment compliance breach metrics for regulatory oversight, risk management, and remediation tracking"
  source: "`life_insurance_ecm`.`investment`.`compliance_breach`"
  dimensions:
    - name: "breach_type"
      expr: breach_type
      comment: "Type of compliance breach"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (open, remediated, waived, etc.)"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the breach"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class involved in the breach"
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC designation of the security involved"
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category affected by the breach"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the breach was detected"
    - name: "investment_committee_decision"
      expr: investment_committee_decision
      comment: "Decision made by the investment committee regarding the breach"
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Indicator of whether the breach was escalated to regulators"
    - name: "waiver_approved_flag"
      expr: waiver_approved_flag
      comment: "Indicator of whether a waiver was approved for the breach"
    - name: "breach_year"
      expr: YEAR(breach_date)
      comment: "Year the breach occurred"
    - name: "breach_quarter"
      expr: CONCAT('Q', QUARTER(breach_date), '-', YEAR(breach_date))
      comment: "Quarter and year the breach occurred"
  measures:
    - name: "total_breach_count"
      expr: COUNT(1)
      comment: "Total number of compliance breaches"
    - name: "total_breach_amount"
      expr: SUM(CAST(breach_amount AS DOUBLE))
      comment: "Total dollar amount of compliance breaches"
    - name: "avg_breach_amount"
      expr: AVG(CAST(breach_amount AS DOUBLE))
      comment: "Average dollar amount per breach"
    - name: "total_rbc_charge_impact"
      expr: SUM(CAST(rbc_charge_impact AS DOUBLE))
      comment: "Total impact on risk-based capital charges from breaches"
    - name: "avg_breach_percentage"
      expr: AVG(CAST(breach_percentage AS DOUBLE))
      comment: "Average percentage breach of limit thresholds"
    - name: "open_breach_count"
      expr: SUM(CASE WHEN breach_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of breaches currently open and unresolved"
    - name: "remediated_breach_count"
      expr: SUM(CASE WHEN breach_status = 'Remediated' THEN 1 ELSE 0 END)
      comment: "Count of breaches that have been remediated"
    - name: "regulatory_escalation_count"
      expr: SUM(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches escalated to regulatory authorities"
    - name: "waiver_approved_count"
      expr: SUM(CASE WHEN waiver_approved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of breaches with approved waivers"
    - name: "high_severity_breach_count"
      expr: SUM(CASE WHEN breach_severity = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-severity compliance breaches"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_gain_loss_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Realized and unrealized gain/loss metrics for investment performance, tax reporting, and financial statement preparation"
  source: "`life_insurance_ecm`.`investment`.`gain_loss_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of gain/loss event (sale, maturity, impairment, etc.)"
    - name: "event_subtype"
      expr: event_subtype
      comment: "Detailed subtype of the gain/loss event"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the gain/loss event"
    - name: "gaap_classification"
      expr: gaap_classification
      comment: "GAAP accounting classification of the gain/loss"
    - name: "sap_classification"
      expr: sap_classification
      comment: "Statutory accounting classification of the gain/loss"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (sale, maturity, exchange, etc.)"
    - name: "holding_period_classification"
      expr: holding_period_classification
      comment: "Holding period classification for tax purposes (short-term, long-term)"
    - name: "naic_designation_before"
      expr: naic_designation_before
      comment: "NAIC designation before the event"
    - name: "naic_designation_after"
      expr: naic_designation_after
      comment: "NAIC designation after the event"
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category for capital charge calculation"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicator of whether the event is a reversal"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the gain/loss event occurred"
    - name: "event_quarter"
      expr: CONCAT('Q', QUARTER(event_date), '-', YEAR(event_date))
      comment: "Quarter and year the gain/loss event occurred"
  measures:
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total number of gain/loss events"
    - name: "total_gain_loss_amount"
      expr: SUM(CAST(gain_loss_amount AS DOUBLE))
      comment: "Total realized gain or loss amount"
    - name: "total_proceeds_amount"
      expr: SUM(CAST(proceeds_amount AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds AS DOUBLE))
      comment: "Total net proceeds after transaction costs"
    - name: "total_book_value"
      expr: SUM(CAST(book_value AS DOUBLE))
      comment: "Total book value of assets disposed"
    - name: "total_amortized_cost"
      expr: SUM(CAST(amortized_cost AS DOUBLE))
      comment: "Total amortized cost basis of assets disposed"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recognized"
    - name: "total_credit_loss_component"
      expr: SUM(CAST(credit_loss_component AS DOUBLE))
      comment: "Total credit loss component of impairments"
    - name: "total_transaction_cost"
      expr: SUM(CAST(transaction_cost AS DOUBLE))
      comment: "Total transaction costs incurred"
    - name: "total_rbc_impact"
      expr: SUM(CAST(rbc_impact AS DOUBLE))
      comment: "Total impact on risk-based capital from gain/loss events"
    - name: "avg_gain_loss_per_event"
      expr: AVG(CAST(gain_loss_amount AS DOUBLE))
      comment: "Average gain or loss per event"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_income_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment income allocation metrics for product line profitability, unit value calculation, and financial reporting"
  source: "`life_insurance_ecm`.`investment`.`income_allocation`"
  dimensions:
    - name: "income_type"
      expr: income_type
      comment: "Type of investment income (interest, dividend, rental, etc.)"
    - name: "income_subtype"
      expr: income_subtype
      comment: "Detailed subtype of investment income"
    - name: "income_status"
      expr: income_status
      comment: "Current status of the income allocation"
    - name: "gaap_income_classification"
      expr: gaap_income_classification
      comment: "GAAP classification of the income"
    - name: "sap_income_classification"
      expr: sap_income_classification
      comment: "Statutory accounting classification of the income"
    - name: "allocation_basis"
      expr: allocation_basis
      comment: "Basis for allocating income across products or segments"
    - name: "income_recognition_method"
      expr: income_recognition_method
      comment: "Method used for recognizing income (accrual, cash, etc.)"
    - name: "amortization_method"
      expr: amortization_method
      comment: "Method used for amortizing premium or discount"
    - name: "product_line"
      expr: product_line
      comment: "Product line to which income is allocated"
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category for capital charge purposes"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicator of whether the allocation is a reversal"
    - name: "accrual_year"
      expr: YEAR(accrual_date)
      comment: "Year of income accrual"
    - name: "accrual_quarter"
      expr: CONCAT('Q', QUARTER(accrual_date), '-', YEAR(accrual_date))
      comment: "Quarter and year of income accrual"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of income allocation records"
    - name: "total_gross_income"
      expr: SUM(CAST(gross_income_amount AS DOUBLE))
      comment: "Total gross investment income before deductions"
    - name: "total_net_income"
      expr: SUM(CAST(net_income_amount AS DOUBLE))
      comment: "Total net investment income after deductions"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total income allocated to products or segments"
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest AS DOUBLE))
      comment: "Total accrued interest income"
    - name: "total_amortization_amount"
      expr: SUM(CAST(amortization_amount AS DOUBLE))
      comment: "Total premium amortization or discount accretion"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from income"
    - name: "total_investment_income_due"
      expr: SUM(CAST(investment_income_due AS DOUBLE))
      comment: "Total investment income due but not yet received"
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across records"
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_risk_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk-based capital charge metrics for regulatory capital adequacy, ORSA stress testing, and solvency oversight"
  source: "`life_insurance_ecm`.`investment`.`risk_charge`"
  dimensions:
    - name: "rbc_component"
      expr: rbc_component
      comment: "RBC component category (C1, C3, etc.)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for which the risk charge is calculated"
    - name: "naic_designation"
      expr: naic_designation
      comment: "NAIC designation used for risk charge calculation"
    - name: "naic_schedule_category"
      expr: naic_schedule_category
      comment: "NAIC statutory schedule category"
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the risk charge"
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the RBC filing"
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the risk charge"
    - name: "alm_segment"
      expr: alm_segment
      comment: "ALM segment classification"
    - name: "orsa_stress_scenario"
      expr: orsa_stress_scenario
      comment: "ORSA stress scenario applied"
    - name: "override_flag"
      expr: override_flag
      comment: "Indicator of whether the risk charge was manually overridden"
    - name: "separate_account_flag"
      expr: separate_account_flag
      comment: "Indicator of whether the charge applies to separate accounts"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year of risk charge calculation"
    - name: "calculation_quarter"
      expr: CONCAT('Q', QUARTER(calculation_date), '-', YEAR(calculation_date))
      comment: "Quarter and year of risk charge calculation"
  measures:
    - name: "total_charge_count"
      expr: COUNT(1)
      comment: "Total number of risk charge records"
    - name: "total_base_rbc_charge"
      expr: SUM(CAST(base_rbc_charge AS DOUBLE))
      comment: "Total base risk-based capital charge before adjustments"
    - name: "total_adjusted_rbc_charge"
      expr: SUM(CAST(adjusted_rbc_charge AS DOUBLE))
      comment: "Total adjusted risk-based capital charge after covariance and hedges"
    - name: "total_c1_asset_default_charge"
      expr: SUM(CAST(c1_asset_default_charge AS DOUBLE))
      comment: "Total C1 asset default risk charge"
    - name: "total_c3_interest_rate_charge"
      expr: SUM(CAST(c3_interest_rate_charge AS DOUBLE))
      comment: "Total C3 interest rate risk charge"
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Total fair market value of assets subject to risk charges"
    - name: "total_statement_value"
      expr: SUM(CAST(statement_value AS DOUBLE))
      comment: "Total statutory statement value of assets"
    - name: "total_hedge_adjustment"
      expr: SUM(CAST(hedge_adjustment AS DOUBLE))
      comment: "Total hedge adjustment reducing risk charges"
    - name: "avg_rbc_factor"
      expr: AVG(CAST(rbc_factor AS DOUBLE))
      comment: "Average RBC factor applied across charges"
    - name: "avg_concentration_factor"
      expr: AVG(CAST(concentration_factor AS DOUBLE))
      comment: "Average concentration factor applied"
    - name: "avg_hedge_effectiveness"
      expr: AVG(CAST(hedge_effectiveness_percentage AS DOUBLE))
      comment: "Average hedge effectiveness percentage"
    - name: "override_count"
      expr: SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk charges with manual overrides"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`investment_performance_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio performance attribution metrics for investment committee reporting, manager evaluation, and strategic asset allocation decisions"
  source: "`life_insurance_ecm`.`investment`.`performance_attribution`"
  dimensions:
    - name: "attribution_methodology"
      expr: attribution_methodology
      comment: "Methodology used for performance attribution analysis"
    - name: "attribution_status"
      expr: attribution_status
      comment: "Status of the attribution analysis"
    - name: "attribution_frequency"
      expr: attribution_frequency
      comment: "Frequency of attribution analysis (monthly, quarterly, annual)"
    - name: "alm_segment"
      expr: alm_segment
      comment: "ALM segment classification"
    - name: "rbc_category"
      expr: rbc_category
      comment: "RBC category for capital charge purposes"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the attribution analysis"
    - name: "investment_committee_decision"
      expr: investment_committee_decision
      comment: "Decision made by the investment committee based on attribution results"
    - name: "separate_account_flag"
      expr: separate_account_flag
      comment: "Indicator of whether the attribution applies to separate accounts"
    - name: "attribution_year"
      expr: YEAR(attribution_period_end_date)
      comment: "Year of the attribution period end"
    - name: "attribution_quarter"
      expr: CONCAT('Q', QUARTER(attribution_period_end_date), '-', YEAR(attribution_period_end_date))
      comment: "Quarter and year of the attribution period end"
  measures:
    - name: "total_attribution_count"
      expr: COUNT(1)
      comment: "Total number of performance attribution analyses"
    - name: "avg_total_return"
      expr: AVG(CAST(total_return AS DOUBLE))
      comment: "Average total return across portfolios"
    - name: "avg_benchmark_return"
      expr: AVG(CAST(benchmark_return AS DOUBLE))
      comment: "Average benchmark return"
    - name: "avg_active_return"
      expr: AVG(CAST(active_return AS DOUBLE))
      comment: "Average active return (portfolio return minus benchmark return)"
    - name: "total_allocation_effect"
      expr: SUM(CAST(allocation_effect AS DOUBLE))
      comment: "Total allocation effect from asset class positioning"
    - name: "total_selection_effect"
      expr: SUM(CAST(selection_effect AS DOUBLE))
      comment: "Total selection effect from security selection within asset classes"
    - name: "total_interaction_effect"
      expr: SUM(CAST(interaction_effect AS DOUBLE))
      comment: "Total interaction effect between allocation and selection"
    - name: "total_income_contribution"
      expr: SUM(CAST(income_contribution AS DOUBLE))
      comment: "Total contribution from investment income"
    - name: "total_capital_gain_contribution"
      expr: SUM(CAST(capital_gain_contribution AS DOUBLE))
      comment: "Total contribution from capital gains"
    - name: "total_currency_effect"
      expr: SUM(CAST(currency_effect AS DOUBLE))
      comment: "Total effect from currency movements"
    - name: "avg_portfolio_beginning_value"
      expr: AVG(CAST(portfolio_beginning_market_value AS DOUBLE))
      comment: "Average portfolio market value at period start"
    - name: "avg_portfolio_ending_value"
      expr: AVG(CAST(portfolio_ending_market_value AS DOUBLE))
      comment: "Average portfolio market value at period end"
$$;