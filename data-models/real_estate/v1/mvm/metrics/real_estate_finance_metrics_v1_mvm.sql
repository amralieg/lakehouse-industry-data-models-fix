-- Metric views for domain: finance | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking vendor spend, outstanding liabilities, discount capture, and payment performance across properties, cost centers, and expense categories. Supports cash flow management, vendor payment compliance, and operating expense governance."
  source: "`real_estate_ecm`.`finance`.`ap_invoice`"
  filter: is_void = FALSE
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Operating expense category (e.g., utilities, maintenance, management fees) enabling spend analysis by category."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., open, paid, overdue) for aging and workflow analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status indicating whether the invoice has been reviewed and authorized."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the invoice (e.g., ACH, wire, check) for treasury and payment mix analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g., Net 30, Net 60) for cash flow forecasting and discount opportunity analysis."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the invoice is a recurring obligation, supporting fixed vs. variable cost analysis."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for trend analysis of payables volume and spend."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month in which payment is due, enabling cash outflow forecasting by period."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Accounting period month in which the invoice was posted to the general ledger."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all non-voided AP invoices. Primary measure of vendor spend and payables liability."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments. Reflects actual cash obligation to vendors."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount already paid against invoices. Used to measure payment execution and outstanding liability."
    - name: "total_outstanding_payable"
      expr: SUM(CAST(net_amount AS DOUBLE) - CAST(paid_amount AS DOUBLE))
      comment: "Total unpaid balance across all open invoices (net amount minus paid amount). Key liquidity and payables aging metric."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured. Measures treasury efficiency in leveraging vendor discount terms."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on AP invoices. Supports tax liability reporting and compliance monitoring."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of non-voided AP invoices. Baseline volume metric for payables workload and vendor activity."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value. Benchmarks typical vendor transaction size and detects anomalous invoices."
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net invoice value that has been paid. Measures payables settlement efficiency and cash deployment."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount amount as a percentage of gross invoice value. Measures how effectively the organization captures early-payment discounts."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution metrics covering payment volumes, withholding, discount utilization, and 1099 reportable spend. Supports treasury operations, vendor compliance, and cash management reporting."
  source: "`real_estate_ecm`.`finance`.`ap_payment`"
  filter: is_voided = FALSE
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (ACH, wire, check) for treasury mix analysis and bank fee optimization."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment type (e.g., standard, prepayment, refund) for cash flow categorization."
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., cleared, pending, failed) for reconciliation and exception management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the payment for internal controls and audit compliance."
    - name: "expense_category"
      expr: expense_category
      comment: "Expense category associated with the payment for operating cost analysis."
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Flag indicating whether the payment is reportable on IRS Form 1099. Critical for tax compliance and year-end reporting."
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Indicates whether the payment partially settles an invoice, supporting payables aging and dispute tracking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal accounting period of the payment for period-over-period cash outflow analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment execution for cash outflow trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount disbursed. Primary measure of cash outflow to vendors."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts and withholding. Reflects actual cash leaving the organization."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early-payment discounts taken at time of payment. Measures realized savings from vendor discount programs."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total tax withholding applied to payments. Supports tax compliance and regulatory reporting obligations."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount translated to functional currency. Enables multi-currency portfolio consolidation and FX exposure analysis."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of non-voided payments executed. Baseline volume metric for AP operations throughput."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Benchmarks typical disbursement size and flags outliers."
    - name: "discount_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_taken_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Discount taken as a percentage of total payment amount. Measures treasury efficiency in capturing vendor discount opportunities."
    - name: "withholding_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(withholding_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Withholding as a percentage of total payments. Monitors effective tax withholding rate for compliance benchmarking."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics covering tenant billing, collections performance, write-offs, and revenue recognition. Core KPI layer for property revenue management, tenant credit risk, and lease compliance monitoring."
  source: "`real_estate_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g., open, paid, disputed, written-off) for collections pipeline analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Receivables aging classification (e.g., current, 30-60, 60-90, 90+ days) for credit risk and collections prioritization."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal accounting period for period-over-period revenue and collections trend analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the tenant for collections mix and treasury analysis."
    - name: "nsf_flag"
      expr: nsf_flag
      comment: "Non-sufficient funds flag indicating a returned payment. Tracks tenant payment reliability and credit risk."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance for revenue billing trend analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month in which tenant payment is due for cash inflow forecasting."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Start month of the billing period for revenue period alignment and lease compliance analysis."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to tenants. Primary revenue recognition measure for property income reporting."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after adjustments. Reflects recognized revenue net of credits and concessions."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied from tenant receipts against invoices. Measures collections effectiveness."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied balance on AR invoices. Highlights unmatched receipts requiring reconciliation."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible. Key credit loss metric for bad debt provisioning and tenant risk assessment."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed on AR invoices. Supports sales tax compliance and remittance reporting."
    - name: "total_cam_recovery_billed"
      expr: SUM(CAST(breakpoint_amount AS DOUBLE))
      comment: "Total CAM/percentage rent breakpoint amounts billed. Tracks recovery billing performance against lease terms."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline billing volume metric for revenue operations."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross billed amount collected. Core collections efficiency KPI for property revenue management."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Write-off amount as a percentage of gross billings. Measures credit loss severity and tenant default risk."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value per billing record. Benchmarks typical tenant billing size and detects anomalies."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_ar_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenant cash receipt metrics covering collections volume, unapplied cash, security deposits, prepayments, and NSF events. Supports treasury cash positioning, collections performance, and tenant credit risk monitoring."
  source: "`real_estate_ecm`.`finance`.`ar_receipt`"
  filter: reversal_flag = FALSE
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the receipt (e.g., posted, unposted, reversed) for cash application workflow management."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Classification of receipt (e.g., rent, security deposit, CAM reconciliation) for income categorization."
    - name: "income_category"
      expr: income_category
      comment: "Income category of the receipt for NOI component analysis and revenue stream reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the tenant (ACH, check, wire) for collections channel analysis."
    - name: "is_security_deposit"
      expr: is_security_deposit
      comment: "Flag identifying security deposit receipts for liability tracking and regulatory compliance."
    - name: "is_prepayment"
      expr: is_prepayment
      comment: "Flag identifying prepaid rent receipts for deferred revenue recognition and cash flow analysis."
    - name: "is_nsf"
      expr: is_nsf
      comment: "Non-sufficient funds flag for returned payments. Tracks tenant payment reliability and collections risk."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of receipt for cash inflow trend analysis and period-over-period collections comparison."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Accounting period month of receipt posting for revenue recognition alignment."
  measures:
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Total cash received from tenants. Primary collections volume metric for property revenue management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to open AR invoices. Measures cash application efficiency and receivables clearance."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash balance. Highlights unmatched receipts requiring cash application and reconciliation."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off at receipt level. Supports bad debt analysis and credit loss provisioning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted at receipt. Measures concession impact on collected revenue."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total receipts translated to functional currency. Enables multi-currency portfolio consolidation."
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Total number of non-reversed receipts. Baseline collections activity volume metric."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(received_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash that has been applied to invoices. Measures cash application efficiency and AR operations quality."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(received_amount AS DOUBLE)), 0), 2)
      comment: "Unapplied cash as a percentage of total receipts. Flags cash application backlog and reconciliation risk."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property and portfolio budget metrics covering budgeted spend, variance to actuals, and prior year comparisons. Supports annual planning, financial performance management, and capital allocation decisions."
  source: "`real_estate_ecm`.`finance`.`budget`"
  filter: is_locked = TRUE
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital, reforecast) for planning cycle and scenario analysis."
    - name: "account_category"
      expr: account_category
      comment: "GL account category associated with the budget line for income vs. expense analysis."
    - name: "noi_category"
      expr: noi_category
      comment: "NOI component category (e.g., revenue, operating expense) for net operating income budget analysis."
    - name: "capex_category"
      expr: capex_category
      comment: "Capital expenditure category for CapEx budget tracking and approval governance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for year-over-year planning comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget vs. actual variance analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status for governance and authorization workflow tracking."
    - name: "period_type"
      expr: period_type
      comment: "Budget period type (monthly, quarterly, annual) for aggregation and reporting alignment."
    - name: "budget_period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Start month of the budget period for time-series budget trend analysis."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total approved budget amount. Primary planning baseline for financial performance management."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget). Measures financial performance against plan across properties and cost centers."
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual spend. Enables year-over-year growth and trend analysis for budget benchmarking."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across budget lines. Measures overall planning accuracy and financial discipline."
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Total number of approved budget records. Baseline metric for planning coverage and budget completeness."
    - name: "yoy_budget_growth_pct"
      expr: ROUND(100.0 * (SUM(CAST(budgeted_amount AS DOUBLE)) - SUM(CAST(prior_year_actual_amount AS DOUBLE))) / NULLIF(SUM(CAST(prior_year_actual_amount AS DOUBLE)), 0), 2)
      comment: "Year-over-year budget growth rate versus prior year actuals. Measures investment growth trajectory and planning ambition."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_budget_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular budget line metrics for variance analysis, CapEx vs. OpEx tracking, and CAM recoverability assessment. Enables property-level financial performance management and lease cost recovery optimization."
  source: "`real_estate_ecm`.`finance`.`budget_line`"
  filter: line_status = 'ACTIVE'
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category classification for income vs. expense and NOI component analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of budget line (e.g., revenue, operating expense, capital) for financial statement alignment."
    - name: "noi_component"
      expr: noi_component
      comment: "NOI component designation for net operating income build-up and property performance analysis."
    - name: "is_capex"
      expr: is_capex
      comment: "Flag identifying capital expenditure lines for CapEx budget tracking and approval governance."
    - name: "is_cam_recoverable"
      expr: is_cam_recoverable
      comment: "Flag indicating whether the expense is recoverable from tenants via CAM. Supports lease recovery optimization."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget line for annual planning and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly budget vs. actual variance tracking."
    - name: "budget_scenario"
      expr: budget_scenario
      comment: "Budget scenario (e.g., base case, upside, downside) for scenario planning and sensitivity analysis."
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version label for tracking reforecasts and plan revisions over the fiscal year."
  measures:
    - name: "total_budgeted_amount"
      expr: SUM(CAST(budgeted_amount AS DOUBLE))
      comment: "Total budgeted amount at line level. Granular planning baseline for property and cost center financial management."
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual spend recorded against budget lines. Core measure for budget vs. actual performance reporting."
    - name: "total_revised_budget_amount"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised (reforecast) budget amount. Tracks in-year budget adjustments and reforecast accuracy."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between actual and budgeted amounts. Primary financial performance gap metric."
    - name: "total_prior_year_actual"
      expr: SUM(CAST(prior_year_actual_amount AS DOUBLE))
      comment: "Total prior year actual for year-over-year cost trend analysis."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across budget lines. Measures planning accuracy and financial discipline at line level."
    - name: "budget_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Actual spend as a percentage of budgeted amount. Measures budget consumption rate and spending pace."
    - name: "reforecast_vs_original_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(revised_budget_amount AS DOUBLE)) - SUM(CAST(budgeted_amount AS DOUBLE))) / NULLIF(SUM(CAST(budgeted_amount AS DOUBLE)), 0), 2)
      comment: "Percentage change from original budget to revised forecast. Measures in-year planning volatility and forecast reliability."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_debt_instrument`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt portfolio metrics covering outstanding principal, interest rates, LTV ratios, and covenant thresholds. Supports capital structure management, lender compliance, and refinancing strategy for real estate portfolios."
  source: "`real_estate_ecm`.`finance`.`debt_instrument`"
  filter: instrument_status = 'ACTIVE'
  dimensions:
    - name: "instrument_type"
      expr: instrument_type
      comment: "Type of debt instrument (e.g., mortgage, construction loan, mezzanine) for capital structure analysis."
    - name: "rate_type"
      expr: rate_type
      comment: "Interest rate type (fixed vs. floating) for interest rate risk exposure analysis."
    - name: "rate_index"
      expr: rate_index
      comment: "Benchmark rate index (e.g., SOFR, Prime) for floating rate exposure and hedging analysis."
    - name: "amortization_type"
      expr: amortization_type
      comment: "Amortization structure (e.g., interest-only, fully amortizing) for cash flow and refinancing risk analysis."
    - name: "recourse_type"
      expr: recourse_type
      comment: "Recourse classification (full, partial, non-recourse) for lender liability and risk exposure analysis."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Debt service payment frequency (monthly, quarterly) for cash flow planning."
    - name: "maturity_year"
      expr: DATE_TRUNC('YEAR', maturity_date)
      comment: "Year of loan maturity for refinancing pipeline and debt maturity wall analysis."
    - name: "origination_year"
      expr: DATE_TRUNC('YEAR', origination_date)
      comment: "Year of loan origination for vintage analysis and portfolio seasoning assessment."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding principal balance across all active debt instruments. Primary measure of total debt exposure."
    - name: "total_original_principal"
      expr: SUM(CAST(original_principal AS DOUBLE))
      comment: "Total original principal at origination. Baseline for measuring principal paydown and amortization progress."
    - name: "total_debt_issuance_costs"
      expr: SUM(CAST(debt_issuance_costs AS DOUBLE))
      comment: "Total capitalized debt issuance costs. Supports effective interest rate calculation and balance sheet presentation."
    - name: "total_scheduled_payment_amount"
      expr: SUM(CAST(scheduled_payment_amount AS DOUBLE))
      comment: "Total scheduled periodic debt service payments. Key input for cash flow forecasting and DSCR analysis."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across active debt instruments. Measures weighted cost of debt for capital structure optimization."
    - name: "avg_ltv_ratio"
      expr: AVG(CAST(ltv_ratio AS DOUBLE))
      comment: "Average loan-to-value ratio across the debt portfolio. Core leverage metric for lender covenant compliance and refinancing risk."
    - name: "avg_dscr_covenant_threshold"
      expr: AVG(CAST(dscr_covenant_threshold AS DOUBLE))
      comment: "Average DSCR covenant threshold across debt instruments. Benchmarks minimum coverage requirements for covenant compliance monitoring."
    - name: "principal_paydown_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(original_principal AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(original_principal AS DOUBLE)), 0), 2)
      comment: "Percentage of original principal that has been repaid. Measures amortization progress and equity build-up across the debt portfolio."
    - name: "instrument_count"
      expr: COUNT(1)
      comment: "Total number of active debt instruments. Baseline metric for debt portfolio complexity and lender relationship management."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_debt_service_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debt service payment execution metrics covering principal, interest, escrow, late fees, and covenant breach events. Supports lender compliance, cash flow management, and debt covenant monitoring for real estate portfolios."
  source: "`real_estate_ecm`.`finance`.`debt_service_payment`"
  filter: payment_status = 'COMPLETED'
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the debt service payment (completed, late, missed) for compliance and lender relationship management."
    - name: "rate_type"
      expr: rate_type
      comment: "Interest rate type applied to the payment period for fixed vs. floating rate cost analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to remit debt service (wire, ACH) for treasury operations analysis."
    - name: "is_covenant_breach"
      expr: is_covenant_breach
      comment: "Flag indicating a covenant breach event associated with this payment period. Critical for lender compliance and risk management."
    - name: "covenant_breach_type"
      expr: covenant_breach_type
      comment: "Type of covenant breached (e.g., DSCR, LTV) for targeted remediation and lender negotiation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the debt service payment for period-over-period debt cost analysis."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', actual_payment_date)
      comment: "Month of actual payment for cash outflow trend analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(total_payment_amount AS DOUBLE))
      comment: "Total debt service payments made. Primary measure of debt cost cash outflow for the portfolio."
    - name: "total_principal_paid"
      expr: SUM(CAST(actual_principal_paid AS DOUBLE))
      comment: "Total principal repaid. Measures equity build-up and amortization progress across the debt portfolio."
    - name: "total_interest_paid"
      expr: SUM(CAST(actual_interest_paid AS DOUBLE))
      comment: "Total interest expense paid. Core cost of debt metric for NOI and FFO analysis."
    - name: "total_escrow_paid"
      expr: SUM(CAST(actual_escrow_paid AS DOUBLE))
      comment: "Total escrow amounts paid (taxes, insurance). Supports cash flow planning and lender escrow compliance."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees incurred on debt service payments. Measures payment discipline and lender relationship risk."
    - name: "total_prepayment_penalty"
      expr: SUM(CAST(prepayment_penalty_amount AS DOUBLE))
      comment: "Total prepayment penalties paid. Supports refinancing cost analysis and early payoff decision-making."
    - name: "avg_outstanding_balance_after"
      expr: AVG(CAST(outstanding_balance_after AS DOUBLE))
      comment: "Average outstanding balance after payment. Tracks debt reduction trajectory across the portfolio."
    - name: "interest_to_total_payment_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_interest_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_payment_amount AS DOUBLE)), 0), 2)
      comment: "Interest as a percentage of total debt service. Measures the interest burden within total debt service cost."
    - name: "scheduled_vs_actual_variance"
      expr: SUM(CAST(total_payment_amount AS DOUBLE) - CAST(scheduled_principal_amount AS DOUBLE) - CAST(scheduled_interest_amount AS DOUBLE))
      comment: "Variance between actual total payment and scheduled principal plus interest. Identifies over/under-payments and escrow adjustments."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering acquisition cost, depreciation, net book value, impairment, and disposal performance. Supports CapEx governance, asset lifecycle management, and balance sheet accuracy for real estate portfolios."
  source: "`real_estate_ecm`.`finance`.`fixed_asset`"
  filter: asset_status = 'ACTIVE'
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (e.g., building, land, equipment, tenant improvements) for CapEx categorization and depreciation policy analysis."
    - name: "asset_sub_class"
      expr: asset_sub_class
      comment: "Asset sub-class for granular CapEx tracking and maintenance planning."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the fixed asset (active, disposed, impaired) for asset register management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance) for book value and tax analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of asset disposal (sale, write-off, trade-in) for gain/loss on disposal analysis."
    - name: "acquisition_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and CapEx investment trend reporting."
    - name: "in_service_year"
      expr: DATE_TRUNC('YEAR', in_service_date)
      comment: "Year asset was placed in service for depreciation start and useful life tracking."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of active fixed assets. Primary CapEx investment measure for asset portfolio valuation."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the fixed asset portfolio. Measures asset aging and book value erosion."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Core balance sheet metric for asset carrying value and impairment assessment."
    - name: "total_ytd_depreciation"
      expr: SUM(CAST(ytd_depreciation AS DOUBLE))
      comment: "Total year-to-date depreciation expense. Supports P&L depreciation charge reporting and tax planning."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognized. Measures asset value deterioration and triggers balance sheet write-down analysis."
    - name: "total_insured_value"
      expr: SUM(CAST(insured_value AS DOUBLE))
      comment: "Total insured value of fixed assets. Supports insurance adequacy analysis and risk management."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of active fixed assets. Baseline metric for asset register completeness and CapEx portfolio size."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of fixed assets. Benchmarks asset longevity and informs depreciation policy and replacement planning."
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost. Measures overall asset age and remaining useful life across the portfolio."
    - name: "book_tax_difference_total"
      expr: SUM(CAST(book_tax_difference AS DOUBLE))
      comment: "Total book-tax depreciation difference. Supports deferred tax liability calculation and tax planning for real estate assets."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, intercompany activity, reversal rates, and debit/credit balances. Supports financial close quality, audit readiness, and GL integrity monitoring."
  source: "`real_estate_ecm`.`finance`.`journal_entry`"
  filter: is_balanced = TRUE
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual financial reporting and year-over-year GL activity analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close activity and period-over-period GL volume analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the journal entry for financial close governance and SOX compliance monitoring."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag identifying intercompany journal entries for elimination and consolidation analysis."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag identifying reversal entries for close quality and accrual management analysis."
    - name: "noi_category"
      expr: noi_category
      comment: "NOI component category for net operating income build-up and property performance analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting for financial close timeline and period activity analysis."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency of the journal entry for multi-currency consolidation analysis."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount across all balanced journal entries. Measures GL posting volume and financial activity scale."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount across all balanced journal entries. Paired with total debits for GL balance verification."
    - name: "total_functional_debit_amount"
      expr: SUM(CAST(functional_debit_amount AS DOUBLE))
      comment: "Total debit amount in functional currency. Supports multi-currency consolidation and FX translation analysis."
    - name: "total_functional_credit_amount"
      expr: SUM(CAST(functional_credit_amount AS DOUBLE))
      comment: "Total credit amount in functional currency. Supports multi-currency consolidation and FX translation analysis."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of balanced journal entries. Baseline GL activity volume metric for close workload and audit scope."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_reversal = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. Measures accrual management quality and close process efficiency."
    - name: "intercompany_entry_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_intercompany = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are intercompany. Measures consolidation complexity and elimination workload."
    - name: "avg_entry_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average debit amount per journal entry. Benchmarks typical transaction size and flags unusually large entries for review."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_noi_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Operating Income statement metrics covering NOI, EGI, PGI, vacancy, operating expenses, DSCR, and cap rate analysis. The most critical financial performance layer for real estate asset valuation, investment decisions, and portfolio management."
  source: "`real_estate_ecm`.`finance`.`noi_statement`"
  filter: statement_status = 'FINAL'
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the NOI statement for annual performance reporting and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly NOI trend analysis and budget vs. actual performance management."
    - name: "statement_type"
      expr: statement_type
      comment: "Type of NOI statement (actual, budget, reforecast) for scenario comparison and variance analysis."
    - name: "period_frequency"
      expr: period_frequency
      comment: "Reporting frequency (monthly, quarterly, annual) for aggregation and investor reporting alignment."
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Flag indicating whether the statement is a consolidated portfolio view or individual asset view."
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Start month of the reporting period for time-series NOI trend analysis."
    - name: "reporting_period_end_month"
      expr: DATE_TRUNC('MONTH', reporting_period_end)
      comment: "End month of the reporting period for period boundary analysis."
  measures:
    - name: "total_noi"
      expr: SUM(CAST(noi AS DOUBLE))
      comment: "Total Net Operating Income. The single most important real estate financial metric — drives asset valuation, cap rate analysis, and investment returns."
    - name: "total_pgi"
      expr: SUM(CAST(pgi AS DOUBLE))
      comment: "Total Potential Gross Income. Measures maximum revenue capacity before vacancy and credit losses."
    - name: "total_egi"
      expr: SUM(CAST(egi AS DOUBLE))
      comment: "Total Effective Gross Income after vacancy and credit loss deductions. Measures actual revenue available to cover operating expenses."
    - name: "total_vacancy_loss"
      expr: SUM(CAST(vacancy_loss AS DOUBLE))
      comment: "Total revenue lost to vacancy. Measures leasing performance gap and income at risk from unoccupied space."
    - name: "total_credit_loss"
      expr: SUM(CAST(credit_loss AS DOUBLE))
      comment: "Total credit loss (bad debt) deducted from gross income. Measures tenant default impact on property revenue."
    - name: "total_operating_expenses"
      expr: SUM(CAST(total_operating_expenses AS DOUBLE))
      comment: "Total operating expenses. Core cost efficiency metric for expense ratio analysis and NOI margin management."
    - name: "total_cam_recovery"
      expr: SUM(CAST(cam_recovery AS DOUBLE))
      comment: "Total CAM expense recoveries from tenants. Measures lease recovery effectiveness and net operating cost reduction."
    - name: "total_debt_service"
      expr: SUM(CAST(debt_service AS DOUBLE))
      comment: "Total debt service obligations. Key input for DSCR analysis and cash-on-cash return calculations."
    - name: "avg_noi_psf"
      expr: AVG(CAST(noi_psf AS DOUBLE))
      comment: "Average NOI per square foot. Normalizes property performance for cross-asset comparison and market benchmarking."
    - name: "avg_occupancy_rate"
      expr: AVG(CAST(occupancy_rate AS DOUBLE))
      comment: "Average occupancy rate across properties. Directly drives revenue and is the primary leasing performance indicator."
    - name: "avg_vacancy_rate"
      expr: AVG(CAST(vacancy_rate AS DOUBLE))
      comment: "Average vacancy rate. Inverse of occupancy — measures income at risk and leasing urgency."
    - name: "avg_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average Debt Service Coverage Ratio. Measures ability to service debt from NOI — critical for lender compliance and refinancing eligibility."
    - name: "avg_cap_rate_applied"
      expr: AVG(CAST(cap_rate_applied AS DOUBLE))
      comment: "Average capitalization rate applied. Benchmarks market pricing and implied asset valuation assumptions."
    - name: "total_implied_property_value"
      expr: SUM(CAST(implied_property_value AS DOUBLE))
      comment: "Total implied property value derived from NOI and cap rate. Measures portfolio valuation and tracks asset appreciation."
    - name: "expense_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(total_operating_expenses AS DOUBLE)) / NULLIF(SUM(CAST(egi AS DOUBLE)), 0), 2)
      comment: "Operating expenses as a percentage of EGI. Measures operational efficiency — lower ratios indicate better cost management and higher NOI margins."
    - name: "noi_margin_pct"
      expr: ROUND(100.0 * SUM(CAST(noi AS DOUBLE)) / NULLIF(SUM(CAST(egi AS DOUBLE)), 0), 2)
      comment: "NOI as a percentage of EGI. Core profitability margin for real estate assets — directly impacts valuation and investor returns."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`finance_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order metrics covering procurement spend, CapEx vs. OpEx classification, discount capture, and vendor payment terms. Supports procurement governance, CapEx budget control, and vendor management."
  source: "`real_estate_ecm`.`finance`.`purchase_order`"
  filter: po_status != 'CANCELLED'
  dimensions:
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (standard, blanket, emergency) for procurement process analysis."
    - name: "po_status"
      expr: po_status
      comment: "Current status of the PO (open, received, closed) for procurement pipeline and commitment tracking."
    - name: "is_capital_expenditure"
      expr: is_capital_expenditure
      comment: "Flag identifying capital expenditure POs for CapEx budget tracking and approval governance."
    - name: "is_urgent"
      expr: is_urgent
      comment: "Flag identifying urgent POs for procurement exception analysis and vendor responsiveness tracking."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the PO for cash flow planning and discount opportunity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order for multi-currency procurement and FX exposure analysis."
    - name: "po_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of PO issuance for procurement volume trend analysis."
  measures:
    - name: "total_po_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed purchase order value. Primary procurement spend commitment metric for budget control."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total PO subtotal before tax and shipping. Measures net goods and services spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on purchase orders. Supports input tax recovery and procurement tax compliance."
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping costs on purchase orders. Measures logistics spend and vendor delivery cost efficiency."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts negotiated on purchase orders. Measures procurement savings and vendor negotiation effectiveness."
    - name: "po_count"
      expr: COUNT(1)
      comment: "Total number of active purchase orders. Baseline procurement activity volume metric."
    - name: "avg_po_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Benchmarks typical procurement transaction size and flags outliers."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal. Measures procurement negotiation effectiveness and vendor discount capture."
$$;