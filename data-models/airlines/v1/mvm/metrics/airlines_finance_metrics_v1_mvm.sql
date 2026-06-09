-- Metric views for domain: finance | Business: Airlines | Version: 1 | Generated on: 2026-05-07 15:08:57

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governs payables performance KPIs covering invoice liability exposure, payment efficiency, tax obligations, fuel procurement spend, and discount capture — enabling CFO-level cash management and working-capital steering."
  source: "`airlines_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "vendor_category"
      expr: vendor_category
      comment: "Vendor category (e.g. fuel supplier, MRO, ground handler, lessor) enabling spend analysis by supplier type."
    - name: "invoice_currency"
      expr: invoice_currency
      comment: "Currency of the invoice, used to analyse FX exposure across payables."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the invoice (e.g. open, paid, disputed) for payables ageing and workflow monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the payable, used to identify bottlenecks in the invoice-to-pay cycle."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the payable (e.g. SWIFT, SEPA, cheque), relevant for treasury and bank reconciliation."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Agreed payment terms code (e.g. Net30, Net60) driving due-date and discount-capture analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable for period-over-period financial reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) of the payable for intra-year trend analysis."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code to which the payable is posted, enabling cost-category drill-down."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice, used for VAT/GST compliance reporting."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of the three-way match (PO / GR / invoice) — a key control indicator for procurement compliance."
    - name: "ifrs16_lease_flag"
      expr: CASE WHEN ifrs16_lease_flag = TRUE THEN 'IFRS16 Lease' ELSE 'Non-Lease' END
      comment: "Flags whether the payable relates to an IFRS 16 lease obligation, separating lease from non-lease spend."
    - name: "posting_date"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date, used for monthly accrual and cash-flow trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month in which the payable is due, enabling forward-looking cash-outflow forecasting."
  measures:
    - name: "total_gross_payables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount across all payables — primary measure of total vendor liability exposure."
    - name: "total_net_payables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments — reflects actual cash obligation to vendors."
    - name: "total_tax_payable"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on payables — critical for VAT/GST filing and tax liability management."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from vendor payments — required for regulatory tax remittance reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts captured — measures treasury efficiency in exploiting vendor discount terms."
    - name: "total_fuel_uplift_volume_liters"
      expr: SUM(CAST(fuel_uplift_volume_liters AS DOUBLE))
      comment: "Total fuel volume (litres) invoiced through accounts payable — key input for fuel cost-per-litre and hedging analysis."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payable amount in local functional currency — used for entity-level P&L and FX translation reporting."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across payables — monitors FX rate consistency and hedging effectiveness."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of payable invoices — baseline volume metric for AP workload and vendor activity tracking."
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_category)
      comment: "Count of distinct vendor categories with active payables — measures supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks receivables health KPIs including outstanding balances, overdue exposure, write-off risk, and collection efficiency — enabling credit risk management and working-capital optimisation decisions."
  source: "`airlines_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "ar_status"
      expr: ar_status
      comment: "Current status of the receivable (e.g. open, cleared, disputed) for pipeline and collection tracking."
    - name: "ageing_bucket"
      expr: ageing_bucket
      comment: "Ageing bucket (e.g. 0-30, 31-60, 61-90, 90+ days) — primary dimension for credit risk and collection prioritisation."
    - name: "receivable_type"
      expr: receivable_type
      comment: "Type of receivable (e.g. passenger revenue, cargo, interline, ancillary) for revenue stream analysis."
    - name: "document_type"
      expr: document_type
      comment: "Document type (e.g. invoice, credit note, debit note) for AR composition analysis."
    - name: "document_currency"
      expr: document_currency
      comment: "Currency of the receivable document — used for FX exposure and multi-currency AR reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency code for entity-level AR reporting and FX translation."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level applied to the receivable — indicates collection urgency and credit risk severity."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the receivable — flags unreconciled items requiring finance team intervention."
    - name: "interline_carrier_code"
      expr: interline_carrier_code
      comment: "IATA code of the interline partner carrier — enables interline settlement performance analysis by partner."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the receivable for annual financial close and period comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the receivable for monthly revenue recognition and AR ageing reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date — used for monthly billing volume and revenue trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month in which the receivable is due — enables forward cash-inflow forecasting."
  measures:
    - name: "total_gross_receivables"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross receivable amount — primary measure of total revenue billed and outstanding."
    - name: "total_net_receivables"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net receivable amount after adjustments — reflects actual expected cash inflow."
    - name: "total_open_receivables"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open (uncollected) receivable balance — the most critical measure of collection exposure and liquidity risk."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectable — measures credit loss and bad-debt provisioning requirements."
    - name: "total_tax_receivable"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of receivables — used for VAT reclaim and tax compliance reporting."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all customer accounts — measures credit risk appetite and exposure ceiling."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total receivable amount in local functional currency — used for entity-level revenue and FX reporting."
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Total number of receivable line items — baseline volume metric for billing activity and AR workload."
    - name: "avg_open_receivable_amount"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open receivable amount per document — used to benchmark collection performance and identify outliers."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_fuel_cost_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivers fuel cost and efficiency KPIs covering total spend, unit economics, hedging performance, SAF adoption, and carbon emissions — enabling fuel strategy, procurement, and sustainability decisions."
  source: "`airlines_ecm`.`finance`.`fuel_cost_transaction`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel uplifted (e.g. Jet-A, SAF, Avgas) — primary dimension for fuel mix and sustainability analysis."
    - name: "fuel_supplier_name"
      expr: fuel_supplier_name
      comment: "Name of the fuel supplier — enables supplier performance, pricing, and concentration risk analysis."
    - name: "airport_iata_code"
      expr: airport_iata_code
      comment: "IATA code of the airport where fuel was uplifted — used for station-level fuel cost benchmarking."
    - name: "into_plane_agent_name"
      expr: into_plane_agent_name
      comment: "Name of the into-plane fuelling agent — relevant for agent performance and cost comparison."
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Currency of the fuel transaction — used for FX exposure and hedging analysis."
    - name: "uplift_source_type"
      expr: uplift_source_type
      comment: "Source type of the fuel uplift (e.g. contract, spot, into-plane) — drives procurement strategy decisions."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the fuel cost transaction — used to filter confirmed vs. disputed transactions."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the fuel transaction for annual cost reporting and budget variance analysis."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the fuel transaction for monthly cost accrual and period-close reporting."
    - name: "ifrs16_lease_flag"
      expr: CASE WHEN ifrs16_lease_flag = TRUE THEN 'IFRS16 Lease' ELSE 'Non-Lease' END
      comment: "Flags whether the fuel transaction is associated with an IFRS 16 lease arrangement."
    - name: "uplift_month"
      expr: DATE_TRUNC('MONTH', uplift_timestamp)
      comment: "Month of fuel uplift — used for monthly fuel volume and cost trend analysis."
  measures:
    - name: "total_gross_fuel_cost"
      expr: SUM(CAST(gross_cost_amount AS DOUBLE))
      comment: "Total gross fuel cost before hedging adjustments — primary measure of fuel procurement spend."
    - name: "total_net_fuel_cost"
      expr: SUM(CAST(net_cost_amount AS DOUBLE))
      comment: "Total net fuel cost after hedging gains/losses and adjustments — the true economic cost of fuel."
    - name: "total_hedge_gain_loss"
      expr: SUM(CAST(hedge_gain_loss_amount AS DOUBLE))
      comment: "Total hedging gain or loss on fuel transactions — measures the financial effectiveness of the fuel hedging programme."
    - name: "total_fuel_volume_litres"
      expr: SUM(CAST(quantity_litres AS DOUBLE))
      comment: "Total fuel volume uplifted in litres — key operational volume metric for fleet fuel planning."
    - name: "total_fuel_volume_kg"
      expr: SUM(CAST(quantity_kg AS DOUBLE))
      comment: "Total fuel mass uplifted in kilograms — used for weight-based fuel efficiency and emissions calculations."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions (kg CO2e) from fuel transactions — primary sustainability KPI for CORSIA and ESG reporting."
    - name: "total_tax_and_surcharge"
      expr: SUM(CAST(tax_and_surcharge_amount AS DOUBLE))
      comment: "Total fuel taxes and surcharges paid — used for cost decomposition and regulatory cost tracking."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total fuel cost in functional currency — used for entity-level P&L reporting and FX-neutral cost analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average fuel unit price per transaction — benchmarks procurement pricing against market and contract rates."
    - name: "avg_hedged_unit_price"
      expr: AVG(CAST(hedged_unit_price AS DOUBLE))
      comment: "Average hedged unit price per transaction — measures the effective price achieved through the hedging programme."
    - name: "avg_saf_blend_percentage"
      expr: AVG(CAST(saf_blend_percentage AS DOUBLE))
      comment: "Average SAF (Sustainable Aviation Fuel) blend percentage across uplifts — tracks SAF adoption progress against sustainability targets."
    - name: "avg_fuel_density"
      expr: AVG(CAST(fuel_density AS DOUBLE))
      comment: "Average fuel density across uplifts — used for quality control and volume-to-mass conversion accuracy."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of fuel cost transactions — baseline volume metric for procurement activity and supplier invoice frequency."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides core GL financial KPIs covering posted amounts by account, cost element, and period — the authoritative source for P&L, balance sheet, and management accounting reporting."
  source: "`airlines_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "GL account code — primary dimension for chart-of-accounts-level financial analysis."
    - name: "gl_account_name"
      expr: gl_account_name
      comment: "Descriptive GL account name — provides human-readable context for financial reporting."
    - name: "document_type"
      expr: document_type
      comment: "Type of GL document (e.g. vendor invoice, customer invoice, journal entry) for transaction classification."
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Debit or credit indicator — fundamental for double-entry bookkeeping validation and balance analysis."
    - name: "cost_element"
      expr: cost_element
      comment: "Cost element code — enables management accounting cost-category analysis (e.g. fuel, labour, maintenance)."
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area (e.g. flight operations, ground handling, sales) for departmental P&L reporting."
    - name: "profit_centre"
      expr: profit_centre
      comment: "Profit centre code — enables profitability analysis by business unit or route group."
    - name: "ledger_code"
      expr: ledger_code
      comment: "Ledger code (e.g. leading ledger, IFRS ledger) — used to separate statutory from management reporting."
    - name: "accounting_principle"
      expr: accounting_principle
      comment: "Accounting principle applied (e.g. IFRS, local GAAP) — critical for multi-GAAP consolidated reporting."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the GL posting (e.g. posted, reversed, parked) — used to filter confirmed financial data."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the GL posting for annual financial close and year-over-year comparison."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the GL posting for monthly management accounts and period-close reporting."
    - name: "intercompany_indicator"
      expr: CASE WHEN intercompany_indicator = TRUE THEN 'Intercompany' ELSE 'Third Party' END
      comment: "Flags intercompany transactions — essential for group consolidation and intercompany elimination."
    - name: "reversal_indicator"
      expr: CASE WHEN reversal_indicator = TRUE THEN 'Reversal' ELSE 'Original' END
      comment: "Flags reversal postings — used to exclude reversals from net financial position calculations."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of GL posting date — used for monthly financial trend and accrual analysis."
  measures:
    - name: "total_amount_company_currency"
      expr: SUM(CAST(amount_company_currency AS DOUBLE))
      comment: "Total GL posted amount in company (local) currency — primary measure for entity-level P&L and balance sheet."
    - name: "total_amount_group_currency"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total GL posted amount in group reporting currency — used for consolidated group financial statements."
    - name: "total_amount_transaction_currency"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total GL posted amount in original transaction currency — used for FX exposure and multi-currency analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted to the GL — used for tax liability reconciliation and VAT/GST compliance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to GL postings — monitors FX translation consistency across periods."
    - name: "posting_count"
      expr: COUNT(1)
      comment: "Total number of GL line items posted — measures accounting activity volume and period-close completeness."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_code)
      comment: "Count of distinct GL accounts with postings — used to assess chart-of-accounts utilisation and complexity."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_interline_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures interline settlement performance KPIs including gross billing, net settlement, proration, commissions, and dispute exposure — enabling interline revenue management and partner settlement governance."
  source: "`airlines_ecm`.`finance`.`interline_billing`"
  dimensions:
    - name: "partner_airline_iata_code"
      expr: partner_airline_iata_code
      comment: "IATA code of the interline partner airline — primary dimension for partner-level settlement analysis."
    - name: "billing_type"
      expr: billing_type
      comment: "Type of interline billing (e.g. passenger, cargo, excess baggage) for revenue stream decomposition."
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing document (e.g. submitted, settled, disputed) for settlement pipeline monitoring."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Settlement method used (e.g. BSP, ARC, bilateral) — relevant for settlement channel performance analysis."
    - name: "settlement_currency_code"
      expr: settlement_currency_code
      comment: "Currency in which the interline settlement is made — used for FX exposure and multi-currency settlement reporting."
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of the interlined passenger (e.g. First, Business, Economy) for yield analysis by class."
    - name: "origin_airport_iata_code"
      expr: origin_airport_iata_code
      comment: "IATA code of the origin airport on the interlined segment — enables route-level interline revenue analysis."
    - name: "destination_airport_iata_code"
      expr: destination_airport_iata_code
      comment: "IATA code of the destination airport on the interlined segment — used for O&D interline revenue mapping."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type (e.g. debit memo, credit memo, invoice) for interline billing composition analysis."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the interline billing for monthly settlement reconciliation and accrual reporting."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period start date — used for period-aligned interline revenue trend analysis."
    - name: "settlement_date_month"
      expr: DATE_TRUNC('MONTH', settlement_date)
      comment: "Month of actual settlement — used to track settlement timeliness and cash-flow from interline partners."
  measures:
    - name: "total_gross_billing_amount"
      expr: SUM(CAST(gross_billing_amount AS DOUBLE))
      comment: "Total gross interline billing amount — primary measure of interline revenue billed to/from partner airlines."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net interline settlement amount after proration and commissions — the actual cash exchanged with partners."
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration amount applied to interline billings — measures revenue share allocated to each carrier's segment."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid or received on interline transactions — used for agent and partner commission cost management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of interline billings — used for tax compliance and settlement reconciliation."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to interline billings — monitors currency translation consistency."
    - name: "billing_document_count"
      expr: COUNT(1)
      comment: "Total number of interline billing documents — measures interline activity volume and settlement workload."
    - name: "distinct_partner_count"
      expr: COUNT(DISTINCT partner_airline_iata_code)
      comment: "Count of distinct interline partner airlines with active billing — measures interline network breadth."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_lease_liability_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks IFRS 16 lease liability KPIs including opening/closing balances, interest expense, principal repayments, and remeasurements — enabling compliance reporting and lease portfolio financial management."
  source: "`airlines_ecm`.`finance`.`lease_liability_schedule`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease (e.g. aircraft operating, finance, property) — primary dimension for lease portfolio composition analysis."
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (e.g. active, terminated, modified) for portfolio lifecycle management."
    - name: "lessor_name"
      expr: lessor_name
      comment: "Name of the lessor — enables lessor concentration risk and counterparty exposure analysis."
    - name: "asset_registration"
      expr: asset_registration
      comment: "Aircraft or asset registration number — enables asset-level lease liability tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease liability schedule — used for multi-currency lease portfolio reporting."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency code for entity-level IFRS 16 reporting and FX translation."
    - name: "short_term_lease_flag"
      expr: CASE WHEN short_term_lease_flag = TRUE THEN 'Short-Term' ELSE 'Long-Term' END
      comment: "Flags short-term leases (≤12 months) exempt from IFRS 16 full recognition — used for exemption reporting."
    - name: "low_value_asset_flag"
      expr: CASE WHEN low_value_asset_flag = TRUE THEN 'Low Value' ELSE 'Standard' END
      comment: "Flags low-value asset leases exempt from IFRS 16 full recognition — used for exemption reporting."
    - name: "extension_option_flag"
      expr: CASE WHEN extension_option_flag = TRUE THEN 'Extension Option' ELSE 'No Extension' END
      comment: "Flags leases with extension options — relevant for lease term reassessment and liability remeasurement triggers."
    - name: "journal_entry_posted_flag"
      expr: CASE WHEN journal_entry_posted_flag = TRUE THEN 'Posted' ELSE 'Unposted' END
      comment: "Flags whether the period journal entry has been posted — used for period-close completeness monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the lease schedule period for annual IFRS 16 disclosure and balance sheet reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the lease schedule for monthly IFRS 16 accrual and interest expense reporting."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the schedule period start — used for monthly lease liability movement analysis."
  measures:
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening lease liability balance for the period — baseline for IFRS 16 liability movement reconciliation."
    - name: "total_closing_balance"
      expr: SUM(CAST(closing_balance AS DOUBLE))
      comment: "Total closing lease liability balance for the period — primary IFRS 16 balance sheet measure."
    - name: "total_interest_expense"
      expr: SUM(CAST(interest_expense AS DOUBLE))
      comment: "Total interest expense on lease liabilities — key IFRS 16 P&L charge replacing operating lease rental expense."
    - name: "total_principal_repayment"
      expr: SUM(CAST(principal_repayment AS DOUBLE))
      comment: "Total principal repayment on lease liabilities — represents the financing cash outflow under IFRS 16."
    - name: "total_lease_payment"
      expr: SUM(CAST(lease_payment AS DOUBLE))
      comment: "Total lease payments made in the period — used for cash flow statement and liquidity analysis."
    - name: "total_variable_lease_payment"
      expr: SUM(CAST(variable_lease_payment AS DOUBLE))
      comment: "Total variable lease payments not included in the liability measurement — disclosed separately under IFRS 16."
    - name: "total_remeasurement_amount"
      expr: SUM(CAST(remeasurement_amount AS DOUBLE))
      comment: "Total remeasurement adjustments to lease liabilities — tracks the financial impact of lease modifications and reassessments."
    - name: "total_initial_recognition_amount"
      expr: SUM(CAST(initial_recognition_amount AS DOUBLE))
      comment: "Total initial recognition amount for new leases commenced in the period — measures new lease liability additions."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average incremental borrowing rate applied to lease liabilities — monitors rate assumptions used in IFRS 16 valuations."
    - name: "lease_schedule_count"
      expr: COUNT(1)
      comment: "Total number of lease schedule records — measures the size and complexity of the lease portfolio."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivers budget planning KPIs covering approved budgets, forecast cycles, capex/opex allocations, and key aviation unit-cost metrics (CASK, RASK) — enabling financial planning, variance management, and strategic resource allocation."
  source: "`airlines_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of budget plan (e.g. annual budget, rolling forecast, strategic plan) — primary dimension for planning cycle analysis."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the budget plan (e.g. draft, approved, locked) — used to filter active vs. historical plans."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category (e.g. flight operations, commercial, corporate) for departmental budget allocation analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan — primary time dimension for annual budget cycle management."
    - name: "forecast_cycle"
      expr: forecast_cycle
      comment: "Forecast cycle identifier (e.g. Q1 reforecast, mid-year) — used to track forecast evolution through the year."
    - name: "plan_version"
      expr: plan_version
      comment: "Version of the budget plan — enables version comparison and audit trail for planning governance."
    - name: "consolidation_level"
      expr: consolidation_level
      comment: "Consolidation level of the plan (e.g. entity, group, segment) — used for hierarchical budget roll-up analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget plan — used for multi-currency budget consolidation and FX sensitivity analysis."
    - name: "is_rolling_forecast"
      expr: CASE WHEN is_rolling_forecast = TRUE THEN 'Rolling Forecast' ELSE 'Static Budget' END
      comment: "Distinguishes rolling forecasts from static annual budgets — relevant for planning methodology governance."
    - name: "controlling_area_code"
      expr: controlling_area_code
      comment: "Controlling area code — used for management accounting budget allocation and cost centre hierarchy reporting."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month of budget approval — used to track planning cycle timeliness and governance compliance."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(total_budget_amount AS DOUBLE))
      comment: "Total approved budget amount — primary measure of overall financial resource allocation for the planning period."
    - name: "total_revenue_budget"
      expr: SUM(CAST(revenue_budget_amount AS DOUBLE))
      comment: "Total budgeted revenue — used for revenue target-setting and variance analysis against actuals."
    - name: "total_opex_budget"
      expr: SUM(CAST(opex_budget_amount AS DOUBLE))
      comment: "Total budgeted operating expenditure — primary cost budget measure for operational efficiency management."
    - name: "total_capex_budget"
      expr: SUM(CAST(capex_budget_amount AS DOUBLE))
      comment: "Total budgeted capital expenditure — used for fleet investment, infrastructure, and asset acquisition planning."
    - name: "total_fuel_cost_budget"
      expr: SUM(CAST(fuel_cost_budget_amount AS DOUBLE))
      comment: "Total budgeted fuel cost — the largest single cost line for most airlines, critical for P&L sensitivity analysis."
    - name: "total_lease_liability_budget"
      expr: SUM(CAST(lease_liability_budget_amount AS DOUBLE))
      comment: "Total budgeted lease liability — used for IFRS 16 balance sheet planning and debt covenant monitoring."
    - name: "total_interline_settlement_budget"
      expr: SUM(CAST(interline_settlement_budget_amount AS DOUBLE))
      comment: "Total budgeted interline settlement amount — used for partner revenue and cost planning."
    - name: "avg_cask_budget"
      expr: AVG(CAST(cask_budget AS DOUBLE))
      comment: "Average budgeted Cost per Available Seat Kilometre (CASK) — the primary airline unit-cost efficiency KPI."
    - name: "avg_rask_budget"
      expr: AVG(CAST(rask_budget AS DOUBLE))
      comment: "Average budgeted Revenue per Available Seat Kilometre (RASK) — the primary airline unit-revenue KPI."
    - name: "avg_load_factor_budget_pct"
      expr: AVG(CAST(load_factor_budget_pct AS DOUBLE))
      comment: "Average budgeted load factor percentage — measures capacity utilisation target set in the financial plan."
    - name: "avg_ask_budget"
      expr: AVG(CAST(ask_budget AS DOUBLE))
      comment: "Average budgeted Available Seat Kilometres (ASK) — measures planned capacity output for the period."
    - name: "avg_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_pct AS DOUBLE))
      comment: "Average variance threshold percentage set in budget plans — used to calibrate financial control and exception reporting."
    - name: "budget_plan_count"
      expr: COUNT(1)
      comment: "Total number of budget plan records — measures planning activity volume and version proliferation."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks fixed asset financial KPIs including net book value, accumulated depreciation, acquisition cost, impairment, and disposal proceeds — enabling fleet asset management, capital allocation, and IFRS compliance decisions."
  source: "`airlines_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of fixed asset (e.g. aircraft, engine, ground equipment, property) — primary dimension for asset portfolio analysis."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code from the chart of depreciation — used for depreciation policy and asset category reporting."
    - name: "asset_class_name"
      expr: asset_class_name
      comment: "Descriptive name of the asset class — provides human-readable context for asset portfolio reporting."
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset (e.g. active, disposed, under construction) — used for active fleet asset tracking."
    - name: "depreciation_method_code"
      expr: depreciation_method_code
      comment: "Depreciation method applied (e.g. straight-line, declining balance) — relevant for accounting policy consistency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the asset is recorded — used for multi-currency asset portfolio reporting."
    - name: "is_ifrs16_rou_asset"
      expr: CASE WHEN is_ifrs16_rou_asset = TRUE THEN 'IFRS16 ROU Asset' ELSE 'Owned Asset' END
      comment: "Distinguishes IFRS 16 Right-of-Use assets from owned assets — critical for balance sheet classification and disclosure."
    - name: "asset_location_code"
      expr: asset_location_code
      comment: "Location code of the asset — used for geographic asset distribution and maintenance base analysis."
    - name: "depreciation_area"
      expr: depreciation_area
      comment: "Depreciation area (e.g. book, tax, IFRS) — used for multi-GAAP depreciation reporting."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition — used for fleet vintage analysis and capital expenditure cohort tracking."
    - name: "capitalisation_date_month"
      expr: DATE_TRUNC('MONTH', capitalisation_date)
      comment: "Month of asset capitalisation — used for capex activation timing and depreciation commencement analysis."
  measures:
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets — primary balance sheet measure of the airline's asset base."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets — measures total capital invested in the asset portfolio."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation — measures the consumed economic value of the asset portfolio over time."
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment losses recognised — a critical indicator of asset value deterioration requiring executive attention."
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value AS DOUBLE))
      comment: "Total estimated residual value of assets — used for depreciation calculation and fleet disposal planning."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals — measures fleet monetisation and capital recycling performance."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments to fixed assets — tracks fair-value uplifts and their balance sheet impact."
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total insured value of fixed assets — used for insurance adequacy review and risk management."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed asset records — measures the size and complexity of the asset portfolio."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset — used to benchmark asset age and depreciation profile across the fleet."
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`finance_tax_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Governs tax compliance KPIs covering total tax liabilities, recoverable tax, taxable base, and remittance performance — enabling tax risk management, regulatory filing, and cash tax optimisation decisions."
  source: "`airlines_ecm`.`finance`.`tax_transaction`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g. VAT, GST, withholding tax, airport tax) — primary dimension for tax liability decomposition."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the transaction — used for tax rate and jurisdiction-level compliance reporting."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction code — enables country/state-level tax liability and remittance analysis."
    - name: "tax_jurisdiction_name"
      expr: tax_jurisdiction_name
      comment: "Descriptive name of the tax jurisdiction — provides human-readable context for regulatory reporting."
    - name: "tax_authority_name"
      expr: tax_authority_name
      comment: "Name of the tax authority — used for authority-level remittance tracking and audit management."
    - name: "tax_direction"
      expr: tax_direction
      comment: "Direction of the tax (input/output) — fundamental for VAT/GST net position calculation."
    - name: "source_document_type"
      expr: source_document_type
      comment: "Type of source document generating the tax (e.g. invoice, credit note, refund) for tax audit trail."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Processing status of the tax transaction (e.g. posted, reversed, filed) for compliance pipeline monitoring."
    - name: "is_recoverable"
      expr: CASE WHEN is_recoverable = TRUE THEN 'Recoverable' ELSE 'Non-Recoverable' END
      comment: "Flags recoverable vs. non-recoverable tax — critical for input tax reclaim and cash tax cost analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax transaction for annual tax provision and filing analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax transaction for monthly tax accrual and period-close reporting."
    - name: "airport_code"
      expr: airport_code
      comment: "Airport code associated with the tax transaction — used for airport tax and passenger duty analysis by station."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of tax posting date — used for monthly tax liability trend and remittance scheduling."
    - name: "remittance_date_month"
      expr: DATE_TRUNC('MONTH', remittance_date)
      comment: "Month of tax remittance — used to track payment timeliness against filing deadlines."
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all transactions — primary measure of gross tax liability for compliance reporting."
    - name: "total_local_currency_tax_amount"
      expr: SUM(CAST(local_currency_tax_amount AS DOUBLE))
      comment: "Total tax amount in local functional currency — used for entity-level tax provision and cash tax forecasting."
    - name: "total_taxable_base_amount"
      expr: SUM(CAST(taxable_base_amount AS DOUBLE))
      comment: "Total taxable base amount — used to validate effective tax rates and identify tax base erosion risks."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount (excluding tax) on tax transactions — used for revenue and cost base reconciliation."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across transactions — used to monitor rate consistency and identify anomalies."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to tax transactions — monitors currency translation for multi-jurisdiction tax reporting."
    - name: "tax_transaction_count"
      expr: COUNT(1)
      comment: "Total number of tax transactions — measures tax compliance activity volume and filing workload."
    - name: "distinct_jurisdiction_count"
      expr: COUNT(DISTINCT tax_jurisdiction_code)
      comment: "Count of distinct tax jurisdictions with active transactions — measures multi-jurisdiction tax complexity and compliance footprint."
$$;