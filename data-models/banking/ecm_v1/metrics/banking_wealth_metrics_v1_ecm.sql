-- Metric views for domain: wealth | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_managed_portfolio`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core portfolio performance and size metrics for wealth management"
  source: "`banking_ecm`.`wealth`.`managed_portfolio`"
  dimensions:
    - name: "portfolio_name"
      expr: portfolio_name
      comment: "Human‑readable portfolio name"
    - name: "portfolio_status"
      expr: managed_portfolio_status
      comment: "Current status of the portfolio (e.g., active, closed)"
    - name: "portfolio_strategy"
      expr: portfolio_strategy
      comment: "Strategic classification of the portfolio"
    - name: "inception_date"
      expr: inception_date
      comment: "Date the portfolio was launched"
    - name: "base_currency"
      expr: base_currency
      comment: "Currency in which the portfolio is denominated"
    - name: "risk_profile"
      expr: risk_profile
      comment: "Risk profile assigned to the portfolio"
    - name: "mandate_type"
      expr: mandate_type
      comment: "Mandate type governing the portfolio"
  measures:
    - name: "total_aum"
      expr: SUM(CAST(aum_amount AS DOUBLE))
      comment: "Total assets under management across all portfolios"
    - name: "average_management_fee_rate"
      expr: AVG(CAST(management_fee_rate AS DOUBLE))
      comment: "Average management fee rate applied to portfolios"
    - name: "portfolio_count"
      expr: COUNT(1)
      comment: "Number of managed portfolios"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_performance_return`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance return KPIs for portfolios and composites"
  source: "`banking_ecm`.`wealth`.`performance_return`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Classification of the return period (e.g., YTD, 1Y)"
  measures:
    - name: "total_active_return"
      expr: SUM(CAST(active_return AS DOUBLE))
      comment: "Sum of active returns for the period"
    - name: "average_annualized_return"
      expr: AVG(CAST(annualized_return AS DOUBLE))
      comment: "Average annualized return across records"
    - name: "average_sharpe_ratio"
      expr: AVG(CAST(sharpe_ratio AS DOUBLE))
      comment: "Average Sharpe ratio indicating risk‑adjusted performance"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_fee_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fee billing and revenue recognition metrics"
  source: "`banking_ecm`.`wealth`.`fee_billing`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing record"
    - name: "fee_currency"
      expr: fee_currency_code
      comment: "Currency of the fee amounts"
    - name: "billing_period_start"
      expr: billing_period_start_date
      comment: "Start date of the billing period"
    - name: "billing_period_end"
      expr: billing_period_end_date
      comment: "End date of the billing period"
  measures:
    - name: "total_gross_fee"
      expr: SUM(CAST(gross_fee_amount AS DOUBLE))
      comment: "Total gross fees billed"
    - name: "total_net_fee"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net fees after discounts and waivers"
    - name: "total_fee_discount"
      expr: SUM(CAST(fee_discount_amount AS DOUBLE))
      comment: "Aggregate fee discounts granted"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_alternative_investment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key valuation and performance metrics for alternative investments"
  source: "`banking_ecm`.`wealth`.`alternative_investment`"
  dimensions:
    - name: "investment_type"
      expr: investment_type
      comment: "Type of alternative investment (e.g., private equity, hedge fund)"
    - name: "investment_status"
      expr: investment_status
      comment: "Current status of the investment"
    - name: "fund_manager_name"
      expr: fund_manager_name
      comment: "Name of the fund manager overseeing the investment"
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used to value the investment"
    - name: "nav_as_of_date"
      expr: nav_as_of_date
      comment: "Date of the NAV snapshot"
  measures:
    - name: "total_fair_value"
      expr: SUM(CAST(fair_value_amount AS DOUBLE))
      comment: "Aggregate fair value of alternative investments"
    - name: "total_commitment"
      expr: SUM(CAST(commitment_amount AS DOUBLE))
      comment: "Total committed capital for alternative investments"
    - name: "average_irr_percent"
      expr: AVG(CAST(irr_percent AS DOUBLE))
      comment: "Average internal rate of return across investments"
    - name: "average_dpi_multiple"
      expr: AVG(CAST(dpi_multiple AS DOUBLE))
      comment: "Average Distributed to Paid‑In multiple"
    - name: "average_moic_multiple"
      expr: AVG(CAST(moic_multiple AS DOUBLE))
      comment: "Average Multiple on Invested Capital"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`wealth_asset_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allocation effectiveness and risk metrics"
  source: "`banking_ecm`.`wealth`.`asset_allocation`"
  dimensions:
    - name: "allocation_type"
      expr: allocation_type
      comment: "Classification of the allocation (e.g., strategic, tactical)"
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation"
    - name: "asset_class"
      expr: asset_class
      comment: "Broad asset class (e.g., equity, fixed income)"
    - name: "asset_subclass"
      expr: asset_subclass
      comment: "More granular asset subclass"
    - name: "geographic_allocation"
      expr: geographic_allocation
      comment: "Geographic focus of the allocation"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the allocation became effective"
  measures:
    - name: "total_actual_weight_percent"
      expr: SUM(CAST(actual_weight_percent AS DOUBLE))
      comment: "Sum of actual allocation weights"
    - name: "average_expected_return_percent"
      expr: AVG(CAST(expected_return_percent AS DOUBLE))
      comment: "Average expected return across allocations"
    - name: "average_expected_volatility_percent"
      expr: AVG(CAST(expected_volatility_percent AS DOUBLE))
      comment: "Average expected volatility"
    - name: "total_drift_percent"
      expr: SUM(CAST(drift_percent AS DOUBLE))
      comment: "Cumulative drift from target allocations"
$$;