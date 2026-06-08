-- Metric views for domain: finance | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable metrics tracking vendor payment obligations, invoice processing efficiency, and working capital management"
  source: "`airlines_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the accounts payable transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor (fuel, maintenance, catering, etc.)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the payable"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match between PO, goods receipt, and invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for time-series analysis"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment date for cash flow analysis"
    - name: "ifrs16_lease_flag"
      expr: ifrs16_lease_flag
      comment: "Indicates if transaction is related to IFRS 16 lease accounting"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured, indicating working capital efficiency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured, key working capital efficiency metric"
    - name: "avg_days_to_payment"
      expr: AVG(DATEDIFF(payment_date, invoice_date))
      comment: "Average days from invoice to payment, measures payment cycle efficiency"
    - name: "total_fuel_volume_liters"
      expr: SUM(CAST(fuel_uplift_volume_liters AS DOUBLE))
      comment: "Total fuel volume purchased in liters for fuel cost analysis"
    - name: "invoice_count"
      expr: COUNT(DISTINCT invoice_number)
      comment: "Number of unique invoices processed"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with payables"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics tracking customer payment collection, credit risk, and revenue realization efficiency"
  source: "`airlines_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the receivable"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "ar_status"
      expr: ar_status
      comment: "Current status of the accounts receivable"
    - name: "ageing_bucket"
      expr: ageing_bucket
      comment: "Ageing category of the receivable (current, 30-60 days, 60-90 days, 90+ days)"
    - name: "receivable_type"
      expr: receivable_type
      comment: "Type of receivable (ticket sales, cargo, interline, etc.)"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level indicating collection escalation stage"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status with bank statements"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for time-series analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment received"
  measures:
    - name: "total_gross_receivable"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross accounts receivable amount"
    - name: "total_net_receivable"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after adjustments"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding receivable amount not yet collected, key liquidity metric"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible, indicates credit risk"
    - name: "collection_rate"
      expr: ROUND(100.0 * (SUM(CAST(gross_amount AS DOUBLE)) - SUM(CAST(open_amount AS DOUBLE))) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of receivables collected, key cash collection efficiency metric"
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of receivables written off, measures credit risk and bad debt exposure"
    - name: "avg_days_sales_outstanding"
      expr: AVG(DATEDIFF(COALESCE(clearing_date, CURRENT_DATE()), invoice_date))
      comment: "Average days sales outstanding (DSO), measures collection efficiency"
    - name: "customer_count"
      expr: COUNT(DISTINCT customer_account_number)
      comment: "Number of unique customers with receivables"
    - name: "invoice_count"
      expr: COUNT(DISTINCT document_number)
      comment: "Number of unique receivable documents"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics tracking financial targets, forecasts, and budget utilization across cost centers and categories"
  source: "`airlines_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan (annual budget, rolling forecast, strategic plan)"
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the plan (draft, approved, locked)"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of budget (revenue, opex, capex, fuel, etc.)"
    - name: "forecast_cycle"
      expr: forecast_cycle
      comment: "Forecast cycle identifier"
    - name: "consolidation_level"
      expr: consolidation_level
      comment: "Level of budget consolidation (entity, division, group)"
    - name: "is_rolling_forecast"
      expr: is_rolling_forecast
      comment: "Indicates if this is a rolling forecast"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all categories"
    - name: "total_revenue_budget"
      expr: SUM(CAST(revenue_budget_amount AS DOUBLE))
      comment: "Total revenue budget, key top-line target"
    - name: "total_opex_budget"
      expr: SUM(CAST(opex_budget_amount AS DOUBLE))
      comment: "Total operating expense budget, key cost management target"
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total capital expenditure budget, key investment planning metric"
    - name: "total_fuel_cost_budget"
      expr: SUM(CAST(fuel_cost_budget_amount AS DOUBLE))
      comment: "Total fuel cost budget, critical airline operating cost"
    - name: "total_lease_liability_budget"
      expr: SUM(CAST(lease_liability_budget_amount AS DOUBLE))
      comment: "Total lease liability budget for IFRS 16 compliance"
    - name: "avg_load_factor_budget"
      expr: AVG(CAST(load_factor_budget_pct AS DOUBLE))
      comment: "Average budgeted load factor percentage, key capacity utilization target"
    - name: "avg_rask_budget"
      expr: AVG(CAST(rask_budget AS DOUBLE))
      comment: "Average revenue per available seat kilometer budget, key unit revenue metric"
    - name: "avg_cask_budget"
      expr: AVG(CAST(cask_budget AS DOUBLE))
      comment: "Average cost per available seat kilometer budget, key unit cost metric"
    - name: "budget_plan_count"
      expr: COUNT(DISTINCT plan_number)
      comment: "Number of unique budget plans"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_fuel_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel cost transaction metrics tracking fuel consumption, pricing, hedging effectiveness, and carbon emissions for airline operations"
  source: "`airlines_ecm`.`finance`.`fuel_cost_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the fuel transaction"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the transaction"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel (Jet A1, Jet A, SAF blend, etc.)"
    - name: "airport_iata_code"
      expr: airport_iata_code
      comment: "Airport where fuel was uplifted"
    - name: "fuel_supplier_name"
      expr: fuel_supplier_name
      comment: "Name of the fuel supplier"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the fuel transaction"
    - name: "uplift_source_type"
      expr: uplift_source_type
      comment: "Source type of the fuel uplift (contract, spot, emergency)"
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Currency of the fuel transaction"
    - name: "uplift_month"
      expr: DATE_TRUNC('MONTH', uplift_timestamp)
      comment: "Month of fuel uplift for time-series analysis"
  measures:
    - name: "total_fuel_cost"
      expr: SUM(CAST(net_cost_amount AS DOUBLE))
      comment: "Total net fuel cost, critical airline operating expense"
    - name: "total_fuel_volume_kg"
      expr: SUM(CAST(quantity_kg AS DOUBLE))
      comment: "Total fuel volume in kilograms"
    - name: "total_fuel_volume_litres"
      expr: SUM(CAST(quantity_litres AS DOUBLE))
      comment: "Total fuel volume in litres"
    - name: "total_carbon_emissions_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kilograms, key sustainability metric"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average fuel unit price, key cost driver metric"
    - name: "total_hedge_gain_loss"
      expr: SUM(CAST(hedge_gain_loss_amount AS DOUBLE))
      comment: "Total hedge gain or loss, measures fuel hedging effectiveness"
    - name: "avg_saf_blend_percentage"
      expr: AVG(CAST(saf_blend_percentage AS DOUBLE))
      comment: "Average sustainable aviation fuel blend percentage, key decarbonization metric"
    - name: "fuel_cost_per_kg"
      expr: ROUND(SUM(CAST(net_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(quantity_kg AS DOUBLE)), 0), 4)
      comment: "Average fuel cost per kilogram, key unit economics metric"
    - name: "carbon_intensity"
      expr: ROUND(SUM(CAST(carbon_emission_kg AS DOUBLE)) / NULLIF(SUM(CAST(quantity_kg AS DOUBLE)), 0), 4)
      comment: "Carbon emissions per kilogram of fuel, sustainability efficiency metric"
    - name: "transaction_count"
      expr: COUNT(DISTINCT transaction_number)
      comment: "Number of unique fuel transactions"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger metrics providing comprehensive financial position and performance tracking across all accounts and business units"
  source: "`airlines_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the GL entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period within the year"
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code"
    - name: "gl_account_name"
      expr: gl_account_name
      comment: "General ledger account name"
    - name: "document_type"
      expr: document_type
      comment: "Type of accounting document"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Indicates if entry is debit or credit"
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the posting"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area of the business"
    - name: "profit_centre"
      expr: profit_centre
      comment: "Profit center responsible for the transaction"
    - name: "accounting_principle"
      expr: accounting_principle
      comment: "Accounting principle applied (IFRS, local GAAP)"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates if transaction is intercompany"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for time-series analysis"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total amount in transaction currency"
    - name: "total_company_currency_amount"
      expr: SUM(CAST(amount_company_currency AS DOUBLE))
      comment: "Total amount in company currency for local reporting"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total amount in group currency for consolidated reporting"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all transactions"
    - name: "net_position"
      expr: SUM(CASE WHEN debit_credit_indicator = 'D' THEN CAST(amount_company_currency AS DOUBLE) ELSE -CAST(amount_company_currency AS DOUBLE) END)
      comment: "Net position (debits minus credits) in company currency, key balance sheet metric"
    - name: "document_count"
      expr: COUNT(DISTINCT document_number)
      comment: "Number of unique accounting documents"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reversal entries, indicates correction activity"
    - name: "intercompany_transaction_value"
      expr: SUM(CASE WHEN intercompany_indicator = TRUE THEN CAST(amount_group_currency AS DOUBLE) ELSE 0 END)
      comment: "Total value of intercompany transactions for elimination analysis"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_lease_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease contract metrics tracking IFRS 16 lease obligations, right-of-use assets, and lease portfolio management for aircraft and facilities"
  source: "`airlines_ecm`.`finance`.`lease_contract`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (operating, finance, short-term, low-value)"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the lease contract"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of leased asset (aircraft, engine, facility, equipment)"
    - name: "lessor_country_code"
      expr: lessor_country_code
      comment: "Country code of the lessor"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Frequency of lease payments"
    - name: "ifrs16_exemption_type"
      expr: ifrs16_exemption_type
      comment: "Type of IFRS 16 exemption if applicable"
    - name: "purchase_option_flag"
      expr: purchase_option_flag
      comment: "Indicates if lease has a purchase option"
    - name: "renewal_option_flag"
      expr: renewal_option_flag
      comment: "Indicates if lease has a renewal option"
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the lease contract"
    - name: "commencement_year"
      expr: YEAR(commencement_date)
      comment: "Year of lease commencement"
  measures:
    - name: "total_rou_asset_value"
      expr: SUM(CAST(rou_asset_value AS DOUBLE))
      comment: "Total right-of-use asset value, key IFRS 16 balance sheet metric"
    - name: "total_lease_liability"
      expr: SUM(CAST(lease_liability_opening AS DOUBLE))
      comment: "Total opening lease liability, key IFRS 16 obligation metric"
    - name: "total_periodic_payment"
      expr: SUM(CAST(periodic_lease_payment AS DOUBLE))
      comment: "Total periodic lease payment amount"
    - name: "total_security_deposit"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held by lessors"
    - name: "total_residual_value_guarantee"
      expr: SUM(CAST(residual_value_guarantee AS DOUBLE))
      comment: "Total residual value guarantees, potential future obligation"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate used for lease liability calculation"
    - name: "avg_lease_term_months"
      expr: AVG(CAST(lease_term_months AS DOUBLE))
      comment: "Average lease term in months"
    - name: "lease_contract_count"
      expr: COUNT(DISTINCT contract_number)
      comment: "Number of unique lease contracts"
    - name: "contracts_with_purchase_option"
      expr: SUM(CASE WHEN purchase_option_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with purchase options"
    - name: "total_purchase_option_value"
      expr: SUM(CAST(purchase_option_price AS DOUBLE))
      comment: "Total value of purchase options, potential future capital requirement"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_lease_liability_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease liability schedule metrics tracking periodic lease payments, interest expense, and liability amortization for IFRS 16 compliance"
  source: "`airlines_ecm`.`finance`.`lease_liability_schedule`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the lease schedule period"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the lease schedule"
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease"
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease"
    - name: "lessor_name"
      expr: lessor_name
      comment: "Name of the lessor"
    - name: "asset_registration"
      expr: asset_registration
      comment: "Registration number of the leased asset"
    - name: "short_term_lease_flag"
      expr: short_term_lease_flag
      comment: "Indicates if lease is short-term (IFRS 16 exemption)"
    - name: "low_value_asset_flag"
      expr: low_value_asset_flag
      comment: "Indicates if asset is low-value (IFRS 16 exemption)"
    - name: "remeasurement_reason"
      expr: remeasurement_reason
      comment: "Reason for lease remeasurement if applicable"
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the lease schedule period"
  measures:
    - name: "total_lease_payment"
      expr: SUM(CAST(lease_payment AS DOUBLE))
      comment: "Total lease payments made in the period"
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on lease liabilities, key P&L impact"
    - name: "total_principal_repayment"
      expr: SUM(CAST(principal_repayment AS DOUBLE))
      comment: "Total principal repayment reducing lease liability"
    - name: "total_variable_payment"
      expr: SUM(CAST(variable_lease_payment AS DOUBLE))
      comment: "Total variable lease payments not included in liability measurement"
    - name: "total_remeasurement_amount"
      expr: SUM(CAST(remeasurement_amount AS DOUBLE))
      comment: "Total remeasurement adjustments to lease liability"
    - name: "avg_opening_balance"
      expr: AVG(CAST(opening_balance AS DOUBLE))
      comment: "Average opening lease liability balance"
    - name: "avg_closing_balance"
      expr: AVG(CAST(closing_balance AS DOUBLE))
      comment: "Average closing lease liability balance"
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied to lease liabilities"
    - name: "schedule_period_count"
      expr: COUNT(DISTINCT period_sequence)
      comment: "Number of unique schedule periods"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_treasury_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Treasury position metrics tracking cash balances, liquidity, facility utilization, and foreign exchange exposure for working capital management"
  source: "`airlines_ecm`.`finance`.`treasury_position`"
  dimensions:
    - name: "balance_type"
      expr: balance_type
      comment: "Type of balance (cash, investment, facility, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the treasury position"
    - name: "liquidity_category"
      expr: liquidity_category
      comment: "Liquidity category (immediate, short-term, long-term)"
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of financial instrument"
    - name: "position_status"
      expr: position_status
      comment: "Status of the treasury position"
    - name: "country_code"
      expr: country_code
      comment: "Country where the position is held"
    - name: "hedge_designation"
      expr: hedge_designation
      comment: "Hedge accounting designation if applicable"
    - name: "covenant_breach_flag"
      expr: covenant_breach_flag
      comment: "Indicates if position is in covenant breach"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status with bank statements"
    - name: "position_month"
      expr: DATE_TRUNC('MONTH', position_date)
      comment: "Month of the treasury position"
  measures:
    - name: "total_balance_local"
      expr: SUM(CAST(balance_amount AS DOUBLE))
      comment: "Total balance in local currency"
    - name: "total_balance_usd"
      expr: SUM(CAST(balance_amount_usd AS DOUBLE))
      comment: "Total balance in USD for consolidated liquidity view"
    - name: "total_facility_limit"
      expr: SUM(CAST(facility_limit_amount AS DOUBLE))
      comment: "Total credit facility limits available"
    - name: "total_facility_utilised"
      expr: SUM(CAST(facility_utilised_amount AS DOUBLE))
      comment: "Total credit facility amount utilized"
    - name: "facility_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(facility_utilised_amount AS DOUBLE)) / NULLIF(SUM(CAST(facility_limit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of credit facilities utilized, key liquidity risk metric"
    - name: "available_liquidity"
      expr: SUM(CAST(balance_amount_usd AS DOUBLE)) + (SUM(CAST(facility_limit_amount AS DOUBLE)) - SUM(CAST(facility_utilised_amount AS DOUBLE)))
      comment: "Total available liquidity (cash plus undrawn facilities), critical solvency metric"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate on treasury positions"
    - name: "covenant_breach_count"
      expr: SUM(CASE WHEN covenant_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of positions in covenant breach, key risk indicator"
    - name: "position_count"
      expr: COUNT(DISTINCT position_reference)
      comment: "Number of unique treasury positions"
    - name: "currency_count"
      expr: COUNT(DISTINCT currency_code)
      comment: "Number of currencies held, indicates FX exposure diversity"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_hedge_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hedge contract metrics tracking fuel and currency hedging effectiveness, fair value movements, and risk mitigation performance"
  source: "`airlines_ecm`.`finance`.`hedge_contract`"
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of hedging instrument (swap, option, forward, collar)"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the hedge contract"
    - name: "hedge_designation"
      expr: hedge_designation
      comment: "Hedge accounting designation (cash flow, fair value, net investment)"
    - name: "underlying_type"
      expr: underlying_type
      comment: "Type of underlying exposure (fuel, FX, interest rate)"
    - name: "underlying_commodity_code"
      expr: underlying_commodity_code
      comment: "Commodity code for commodity hedges"
    - name: "currency_pair"
      expr: currency_pair
      comment: "Currency pair for FX hedges"
    - name: "counterparty_name"
      expr: counterparty_name
      comment: "Name of the hedge counterparty"
    - name: "hedge_effectiveness_test_result"
      expr: hedge_effectiveness_test_result
      comment: "Result of hedge effectiveness testing"
    - name: "trade_year"
      expr: YEAR(trade_date)
      comment: "Year the hedge was traded"
    - name: "maturity_year"
      expr: YEAR(maturity_date)
      comment: "Year the hedge matures"
  measures:
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Total notional amount of hedge contracts"
    - name: "total_fair_value"
      expr: SUM(CAST(fair_value_amount AS DOUBLE))
      comment: "Total fair value of hedge portfolio, key mark-to-market metric"
    - name: "total_cumulative_gain_loss"
      expr: SUM(CAST(cumulative_gain_loss AS DOUBLE))
      comment: "Total cumulative gain or loss on hedges, measures hedging effectiveness"
    - name: "total_premium_paid"
      expr: SUM(CAST(premium_paid AS DOUBLE))
      comment: "Total premium paid for option contracts"
    - name: "total_collateral_posted"
      expr: SUM(CAST(collateral_posted_amount AS DOUBLE))
      comment: "Total collateral posted to counterparties"
    - name: "avg_hedge_ratio"
      expr: AVG(CAST(hedge_ratio AS DOUBLE))
      comment: "Average hedge ratio, indicates hedging coverage level"
    - name: "avg_strike_price"
      expr: AVG(CAST(strike_price AS DOUBLE))
      comment: "Average strike price for option contracts"
    - name: "hedge_contract_count"
      expr: COUNT(DISTINCT contract_number)
      comment: "Number of unique hedge contracts"
    - name: "effective_hedge_count"
      expr: SUM(CASE WHEN hedge_effectiveness_test_result = 'Effective' THEN 1 ELSE 0 END)
      comment: "Count of hedges passing effectiveness testing"
    - name: "hedge_effectiveness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hedge_effectiveness_test_result = 'Effective' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2)
      comment: "Percentage of hedges passing effectiveness testing, key hedge accounting compliance metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_interline_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline billing metrics tracking revenue and cost settlements with partner airlines for codeshare and interline operations"
  source: "`airlines_ecm`.`finance`.`interline_billing`"
  dimensions:
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the interline billing"
    - name: "billing_type"
      expr: billing_type
      comment: "Type of interline billing (prorate, SPA, codeshare)"
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing"
    - name: "partner_airline_iata_code"
      expr: partner_airline_iata_code
      comment: "IATA code of the partner airline"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (receivable, payable)"
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method of settlement (ICH, bilateral, BSP)"
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of the ticket"
    - name: "origin_airport_iata_code"
      expr: origin_airport_iata_code
      comment: "Origin airport IATA code"
    - name: "destination_airport_iata_code"
      expr: destination_airport_iata_code
      comment: "Destination airport IATA code"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for billing disputes"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period"
  measures:
    - name: "total_gross_billing"
      expr: SUM(CAST(gross_billing_amount AS DOUBLE))
      comment: "Total gross interline billing amount"
    - name: "total_net_settlement"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount after proration and commissions"
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration amount allocated to partner airlines"
    - name: "total_commission"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission on interline sales"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on interline transactions"
    - name: "proration_rate"
      expr: ROUND(100.0 * SUM(CAST(proration_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_billing_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross billing prorated to partners, key revenue share metric"
    - name: "commission_rate"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_billing_amount AS DOUBLE)), 0), 2)
      comment: "Commission rate on interline sales"
    - name: "billing_document_count"
      expr: COUNT(DISTINCT billing_document_number)
      comment: "Number of unique billing documents"
    - name: "partner_airline_count"
      expr: COUNT(DISTINCT partner_airline_iata_code)
      comment: "Number of unique partner airlines"
    - name: "disputed_billing_count"
      expr: SUM(CASE WHEN dispute_reason_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of disputed billing items, indicates settlement quality issues"
$$;