-- Metric views for domain: invoice | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics covering revenue recognition, collection efficiency, discount leakage, and invoice lifecycle KPIs for executive and AR management dashboards."
  source: "`agriculture_ecm`.`invoice`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Open, Paid, Disputed, Cancelled) — primary segmentation for AR aging and collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. Standard, Credit Memo, Intercompany, Lease) — used to segment revenue streams and identify non-standard billing."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice — essential for multi-currency revenue reporting and FX exposure analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month — enables monthly revenue trend analysis and period-over-period comparisons."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month — used to bucket expected cash inflows and forecast collection timelines."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Billing period start truncated to month — aligns invoices to the service/delivery period for accrual-based revenue reporting."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Indicates whether the invoice is an intercompany transaction — used to exclude or isolate intercompany flows in external revenue reporting."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the invoice is tax-exempt — used for tax compliance reporting and exemption rate analysis."
    - name: "invoice_date_year"
      expr: YEAR(invoice_date)
      comment: "Year of invoice date — supports annual revenue aggregation and year-over-year comparisons."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level for overdue invoices — indicates severity of collection effort required."
    - name: "shipping_terms"
      expr: shipping_terms
      comment: "Shipping terms on the invoice (e.g. FOB, CIF) — used to analyze revenue recognition timing and logistics cost allocation."
    - name: "source_system"
      expr: source_system
      comment: "Originating ERP or operational system — used for data lineage, reconciliation, and system migration analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount across all invoices before discounts and taxes — primary top-line revenue KPI for executive dashboards and period-end close."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts — represents actual recognized revenue obligation and is the primary AR balance driver."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across invoices — required for tax liability reporting and regulatory compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across invoices — measures commercial discount leakage and effectiveness of pricing discipline."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected against invoices — measures cash collection performance and is the primary input to DSO calculations."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(net_amount AS DOUBLE) - CAST(paid_amount AS DOUBLE))
      comment: "Total unpaid balance (net amount minus paid amount) — represents open AR exposure and drives collection prioritization."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices — baseline volume metric used to compute averages and track billing throughput."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value — indicates deal size trends and is used to benchmark billing efficiency and customer segment value."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross invoice amount — measures commercial discount leakage; high values signal pricing discipline issues requiring executive intervention."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net invoiced amount that has been collected — primary cash collection efficiency KPI; declining rate triggers AR escalation and credit policy review."
    - name: "tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate as a percentage of net invoice amount — used for tax provision validation and compliance monitoring."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL AND dispute_reason <> '' THEN 1 END)
      comment: "Number of invoices with an active dispute reason — measures billing quality and customer satisfaction; high counts indicate systemic invoicing or delivery issues."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across invoices — used to monitor FX exposure and validate currency conversion consistency in multi-currency operations."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level commodity and product revenue metrics covering unit economics, quality deductions, volume, and pricing analysis for commodity trading and agricultural product billing."
  source: "`agriculture_ecm`.`invoice`.`line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g. Active, Cancelled, Disputed) — used to filter billable lines and track line-level disputes."
    - name: "line_type"
      expr: line_type
      comment: "Classification of the invoice line (e.g. Commodity, Service, Freight, Storage) — enables revenue stream decomposition by billing category."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category assigned to the line — maps billing lines to P&L revenue buckets for financial reporting and margin analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice line — required for multi-currency revenue analysis."
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the billed quantity (e.g. BU, MT, LB) — used to normalize volume metrics across commodity types."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin for the commodity on the line — used for trade compliance, tariff analysis, and geographic revenue reporting."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates whether the commodity on the line is GMO — used to segment revenue between GMO and non-GMO product streams."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Indicates whether the line item is subject to tax — used for tax compliance and exemption analysis."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Delivery date truncated to month — aligns revenue to physical delivery period for accrual and logistics analysis."
    - name: "delivery_date_year"
      expr: YEAR(delivery_date)
      comment: "Year of delivery — supports annual commodity volume and revenue trend analysis."
  measures:
    - name: "total_line_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue across all invoice lines — primary commodity revenue KPI before deductions and discounts."
    - name: "total_line_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue across invoice lines after discounts — represents actual recognized commodity revenue."
    - name: "total_line_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across invoice lines — used for tax liability reconciliation at the line level."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at the line level — measures pricing concession impact on commodity revenue."
    - name: "total_billed_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total billed commodity quantity — primary volume KPI for throughput analysis and capacity planning."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines — tracks realized price trends versus market benchmarks and contract prices."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture percentage across billed commodity lines — high moisture drives quality deductions and affects net settlement; monitored for grading compliance."
    - name: "avg_dockage_pct"
      expr: AVG(CAST(dockage_pct AS DOUBLE))
      comment: "Average dockage percentage across invoice lines — measures foreign material deduction rate; high values indicate quality issues in the supply chain."
    - name: "total_basis_amount"
      expr: SUM(CAST(basis_amount AS DOUBLE))
      comment: "Total basis amount across commodity invoice lines — represents the price differential from futures contract reference; critical for commodity trading P&L analysis."
    - name: "line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines — baseline volume metric for billing throughput and average line value calculations."
    - name: "avg_line_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per invoice line — measures average transaction size and is used to benchmark line-level pricing efficiency."
    - name: "line_discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Line-level discount as a percentage of gross amount — identifies commodity categories or customers with excessive discount leakage."
    - name: "avg_test_weight"
      expr: AVG(CAST(test_weight AS DOUBLE))
      comment: "Average test weight (lbs/bu) across billed commodity lines — quality indicator directly affecting price adjustments and grading outcomes."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection performance metrics covering cash application efficiency, payment method mix, discount capture, and unapplied cash management for treasury and AR operations."
  source: "`agriculture_ecm`.`invoice`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Applied, Unapplied, Returned, Voided) — primary dimension for cash application efficiency analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the payment (e.g. Advance, Final Settlement, Partial) — used to segment cash flows by payment lifecycle stage."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (e.g. ACH, Wire, Check) — used to analyze payment channel mix and associated processing costs."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the payment — required for multi-currency cash collection reporting."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month — enables monthly cash collection trend analysis and period-end cash forecasting."
    - name: "payment_date_year"
      expr: YEAR(payment_date)
      comment: "Year of payment — supports annual cash collection performance and year-over-year comparisons."
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Indicates whether the payment is a partial payment — high partial payment rates signal customer liquidity stress or billing disputes."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Indicates whether the payment is an intercompany transaction — used to exclude intercompany flows from external cash collection KPIs."
    - name: "channel"
      expr: channel
      comment: "Payment channel (e.g. Online, Branch, EDI) — used to analyze channel adoption and optimize payment processing infrastructure."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount received — primary cash collection KPI for treasury and AR management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to invoices — measures cash application throughput and AR clearance efficiency."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices — represents unallocated cash risk; high balances indicate cash application backlog requiring operational intervention."
    - name: "total_discount_taken_amount"
      expr: SUM(CAST(discount_taken_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers — measures cost of early payment incentives and validates discount term compliance."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payment amount in functional (reporting) currency — used for consolidated financial reporting and FX translation analysis."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received — baseline volume metric for payment processing throughput and staffing analysis."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount — tracks customer payment behavior trends and is used to identify unusually small or large payments for fraud screening."
    - name: "cash_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received payment amount that has been applied to invoices — primary cash application efficiency KPI; low rates indicate AR operations bottlenecks."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash that remains unapplied — operational risk metric; high rates trigger AR team escalation and process review."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to payments — used to monitor FX conversion consistency and validate treasury hedging effectiveness."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute management metrics covering dispute volume, financial exposure, resolution efficiency, and escalation rates — critical for billing quality, customer satisfaction, and credit risk management."
  source: "`agriculture_ecm`.`invoice`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. Open, Resolved, Escalated, Withdrawn) — primary dimension for dispute pipeline management."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Classification of the dispute (e.g. Pricing, Quality, Quantity, Delivery) — identifies root cause categories driving billing disputes."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g. Credit Issued, Price Adjusted, Rejected) — used to analyze resolution patterns and credit exposure."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation tier of the dispute — high escalation levels indicate systemic issues requiring executive attention."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the dispute — used to triage high-value or time-sensitive disputes for expedited resolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the disputed invoice — required for multi-currency dispute exposure reporting."
    - name: "dispute_date_month"
      expr: DATE_TRUNC('MONTH', dispute_date)
      comment: "Dispute creation date truncated to month — enables monthly dispute trend analysis and seasonality detection."
    - name: "dispute_date_year"
      expr: YEAR(dispute_date)
      comment: "Year of dispute creation — supports annual dispute rate trending and year-over-year quality comparisons."
    - name: "is_partial_dispute"
      expr: is_partial_dispute
      comment: "Indicates whether only part of the invoice is disputed — used to distinguish full vs. partial billing disagreements."
    - name: "is_regulatory_dispute"
      expr: is_regulatory_dispute
      comment: "Indicates whether the dispute has a regulatory dimension — regulatory disputes require expedited handling and compliance reporting."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the dispute record — used for data lineage and cross-system reconciliation."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute — primary dispute exposure KPI; large balances represent revenue at risk and require executive escalation."
    - name: "total_customer_claim_amount"
      expr: SUM(CAST(customer_claim_amount AS DOUBLE))
      comment: "Total amount claimed by customers in disputes — measures customer-side financial exposure and is compared to settled amounts to assess negotiation outcomes."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled in resolved disputes — measures actual financial concession made to resolve billing disagreements."
    - name: "total_invoice_amount_in_dispute"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoice value associated with disputed records — provides context for dispute materiality relative to total billing volume."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes — baseline volume metric for dispute pipeline management and billing quality benchmarking."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute — tracks dispute severity trends and helps prioritize high-value dispute resolution."
    - name: "settlement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Settlement amount as a percentage of total disputed amount — measures concession rate in dispute resolution; high rates indicate systemic billing errors or weak negotiation posture."
    - name: "customer_claim_vs_invoice_pct"
      expr: ROUND(100.0 * SUM(CAST(customer_claim_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoice_amount AS DOUBLE)), 0), 2)
      comment: "Customer claim amount as a percentage of invoiced amount — measures the magnitude of customer pushback relative to billed value; high rates signal pricing or quality issues."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_date IS NOT NULL THEN 1 END)
      comment: "Number of disputes that have been escalated — measures dispute management effectiveness; high escalation counts indicate resolution process failures."
    - name: "regulatory_dispute_count"
      expr: COUNT(CASE WHEN is_regulatory_dispute = TRUE THEN 1 END)
      comment: "Number of disputes with a regulatory dimension — compliance risk metric; any increase requires immediate legal and compliance team notification."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer billing account health and credit risk metrics covering AR aging, credit utilization, payment behavior, and account portfolio quality for credit management and collections strategy."
  source: "`agriculture_ecm`.`invoice`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g. Active, Closed, Suspended) — primary dimension for portfolio health segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g. Commercial, Cooperative, Government) — used to segment credit risk and payment behavior by customer category."
    - name: "credit_risk_category"
      expr: credit_risk_category
      comment: "Credit risk tier assigned to the account (e.g. Low, Medium, High) — primary dimension for credit portfolio risk management."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates whether the account is on credit hold — accounts on hold represent blocked revenue and require immediate collections action."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method for the account — used to analyze payment channel mix and associated collection risk."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address — used for geographic credit risk analysis and regulatory compliance segmentation."
    - name: "billing_state_province"
      expr: billing_state_province
      comment: "State or province of the billing address — enables regional AR and credit risk analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Functional currency of the billing account — required for multi-currency AR portfolio reporting."
    - name: "seasonal_terms_flag"
      expr: seasonal_terms_flag
      comment: "Indicates whether the account has seasonal payment terms — seasonal accounts require adjusted collection timing and cash flow forecasting."
    - name: "collateral_type"
      expr: collateral_type
      comment: "Type of collateral securing the account — used to assess credit risk mitigation and recovery options for high-risk accounts."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all billing accounts — primary AR portfolio size KPI for executive and treasury reporting."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across the billing account portfolio — measures total credit exposure and is used to assess portfolio concentration risk."
    - name: "total_dispute_balance"
      expr: SUM(CAST(dispute_balance AS DOUBLE))
      comment: "Total AR balance currently under dispute — represents revenue at risk; high balances require escalation to credit and collections management."
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current_amount AS DOUBLE))
      comment: "Total AR balance in the current (not yet due) aging bucket — baseline for healthy AR portfolio assessment."
    - name: "total_aging_1_30"
      expr: SUM(CAST(aging_1_30_amount AS DOUBLE))
      comment: "Total AR balance 1-30 days past due — early-stage delinquency indicator; rising balances trigger proactive collection outreach."
    - name: "total_aging_31_60"
      expr: SUM(CAST(aging_31_60_amount AS DOUBLE))
      comment: "Total AR balance 31-60 days past due — moderate delinquency bucket; accounts here are candidates for payment plan negotiation."
    - name: "total_aging_61_90"
      expr: SUM(CAST(aging_61_90_amount AS DOUBLE))
      comment: "Total AR balance 61-90 days past due — serious delinquency indicator; typically triggers formal collections escalation."
    - name: "total_aging_91_120"
      expr: SUM(CAST(aging_91_120_amount AS DOUBLE))
      comment: "Total AR balance 91-120 days past due — high-risk delinquency bucket; accounts here may require legal action or write-off provisioning."
    - name: "total_aging_over_120"
      expr: SUM(CAST(aging_over_120_amount AS DOUBLE))
      comment: "Total AR balance over 120 days past due — represents highest credit loss risk; primary input to bad debt reserve calculations."
    - name: "avg_days_to_pay"
      expr: AVG(CAST(avg_days_to_pay AS DOUBLE))
      comment: "Average days to pay across billing accounts — key DSO proxy metric; rising values indicate deteriorating payment behavior and increased collection risk."
    - name: "credit_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit_amount AS DOUBLE)), 0), 2)
      comment: "Current AR balance as a percentage of total credit limit — measures credit portfolio utilization; high rates indicate elevated credit concentration risk and may trigger limit reviews."
    - name: "overdue_ar_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(aging_1_30_amount AS DOUBLE) + CAST(aging_31_60_amount AS DOUBLE) + CAST(aging_61_90_amount AS DOUBLE) + CAST(aging_91_120_amount AS DOUBLE) + CAST(aging_over_120_amount AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Overdue AR (all past-due buckets) as a percentage of total current balance — portfolio delinquency rate; rising values are a leading indicator of bad debt and require credit policy intervention."
    - name: "credit_hold_account_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of billing accounts currently on credit hold — measures blocked revenue risk; high counts indicate systemic credit quality deterioration."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts — baseline portfolio size metric used to compute per-account averages and concentration ratios."
    - name: "avg_collateral_value"
      expr: AVG(CAST(collateral_value AS DOUBLE))
      comment: "Average collateral value per billing account — measures credit risk mitigation coverage; declining values indicate weakening security for outstanding AR balances."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_settlement_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grain and commodity settlement statement metrics covering net settlement performance, deduction analysis, patronage dividends, and period-end financial reconciliation for agricultural cooperative and grain elevator operations."
  source: "`agriculture_ecm`.`invoice`.`settlement_statement`"
  dimensions:
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the settlement statement (e.g. Draft, Final, Disputed, Paid) — primary dimension for settlement pipeline management."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g. Grain Purchase, Lease, Service) — used to segment settlement flows by business activity."
    - name: "period_type"
      expr: period_type
      comment: "Period classification (e.g. Monthly, Quarterly, Annual) — used to align settlement reporting to financial close cycles."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the settlement — required for multi-currency settlement reporting."
    - name: "crop_year"
      expr: crop_year
      comment: "Crop year associated with the settlement — critical agricultural dimension for aligning settlements to growing seasons and harvest cycles."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of commodity delivery (e.g. Truck, Rail, Barge) — used to analyze logistics cost deductions by delivery channel."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the settlement statement is under dispute — used to flag and quarantine disputed settlements from final financial reporting."
    - name: "statement_date_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Statement date truncated to month — enables monthly settlement volume and value trend analysis."
    - name: "statement_date_year"
      expr: YEAR(statement_date)
      comment: "Year of statement date — supports annual settlement performance and crop year comparisons."
    - name: "quantity_uom"
      expr: quantity_uom
      comment: "Unit of measure for settlement quantity (e.g. BU, MT) — used to normalize volume metrics across commodity types."
  measures:
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net amount paid to producers/counterparties after all deductions — primary settlement payout KPI for cooperative and grain elevator financial management."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total gross invoiced amount on settlement statements — represents pre-deduction commodity value and is the baseline for deduction rate analysis."
    - name: "total_payments_received"
      expr: SUM(CAST(payments_received_amount AS DOUBLE))
      comment: "Total payments received against settlement statements — measures cash collection against settlement obligations."
    - name: "total_drying_deductions"
      expr: SUM(CAST(drying_deduction_amount AS DOUBLE))
      comment: "Total drying deductions applied across settlements — measures cost of moisture reduction services; high values indicate wet harvest conditions affecting producer net returns."
    - name: "total_storage_deductions"
      expr: SUM(CAST(storage_deduction_amount AS DOUBLE))
      comment: "Total storage deductions applied across settlements — measures storage cost recovery; used to evaluate storage pricing adequacy and facility utilization economics."
    - name: "total_handling_deductions"
      expr: SUM(CAST(handling_deduction_amount AS DOUBLE))
      comment: "Total handling deductions applied across settlements — measures handling cost recovery and is used to benchmark facility operational efficiency."
    - name: "total_credits_issued"
      expr: SUM(CAST(credits_issued_amount AS DOUBLE))
      comment: "Total credits issued on settlement statements — measures adjustments and corrections made to producer settlements; high values indicate data quality or grading issues."
    - name: "total_patronage_dividends"
      expr: SUM(CAST(patronage_dividend_amount AS DOUBLE))
      comment: "Total patronage dividends distributed through settlements — measures cooperative profit-sharing obligations and is a key metric for cooperative governance reporting."
    - name: "total_settlement_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total commodity quantity settled — primary volume throughput KPI for grain elevator and cooperative operations."
    - name: "statement_count"
      expr: COUNT(1)
      comment: "Total number of settlement statements — baseline volume metric for settlement processing throughput."
    - name: "avg_net_settlement_amount"
      expr: AVG(CAST(net_settlement_amount AS DOUBLE))
      comment: "Average net settlement amount per statement — tracks per-transaction settlement value trends and is used to benchmark producer payment levels."
    - name: "total_deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(drying_deduction_amount AS DOUBLE) + CAST(storage_deduction_amount AS DOUBLE) + CAST(handling_deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoiced_amount AS DOUBLE)), 0), 2)
      comment: "Total deductions (drying + storage + handling) as a percentage of invoiced amount — measures overall deduction burden on producer settlements; high rates signal cost recovery issues or quality problems."
    - name: "settlement_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(payments_received_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_settlement_amount AS DOUBLE)), 0), 2)
      comment: "Payments received as a percentage of net settlement amount — measures settlement obligation fulfillment rate; low rates indicate payment delays or disputes requiring collections action."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_weight_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grain receiving and weight ticket quality metrics covering commodity volume, moisture and dockage deductions, test weight, and settlement value — operational KPIs for grain elevator intake and quality management."
  source: "`agriculture_ecm`.`invoice`.`weight_ticket`"
  dimensions:
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the weight ticket (e.g. Open, Settled, Voided) — used to filter active vs. settled grain receipts."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity received (e.g. Corn, Soybeans, Wheat) — primary dimension for commodity-level volume and quality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for the weight ticket settlement — required for multi-currency grain purchase reporting."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates whether the received commodity is GMO — used to segregate GMO and non-GMO grain flows for identity preservation and pricing."
    - name: "is_organic"
      expr: is_organic
      comment: "Indicates whether the received commodity is certified organic — organic grain commands premium pricing and requires separate tracking."
    - name: "is_split_load"
      expr: is_split_load
      comment: "Indicates whether the load was split across multiple tickets — used to identify complex receiving transactions requiring additional reconciliation."
    - name: "price_unit_of_measure"
      expr: price_unit_of_measure
      comment: "Unit of measure used for pricing (e.g. BU, MT) — used to normalize price-per-unit analysis across commodity types."
    - name: "scale_datetime_date"
      expr: DATE_TRUNC('DAY', scale_datetime)
      comment: "Scale date truncated to day — enables daily grain receiving volume and quality trend analysis."
    - name: "scale_datetime_month"
      expr: DATE_TRUNC('MONTH', scale_datetime)
      comment: "Scale date truncated to month — supports monthly intake volume and harvest season analysis."
  measures:
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight received across all weight tickets — primary intake volume KPI for grain elevator capacity and throughput management."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight after tare deduction — represents actual commodity weight received and is the basis for settlement quantity calculations."
    - name: "total_net_weight_bu"
      expr: SUM(CAST(net_weight_bu AS DOUBLE))
      comment: "Total net weight in bushels — standard commodity volume metric for grain trading and settlement; primary volume KPI for US grain operations."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement value across weight tickets — represents total grain purchase obligation and is the primary financial KPI for grain procurement."
    - name: "ticket_count"
      expr: COUNT(1)
      comment: "Total number of weight tickets — measures grain receiving throughput and is used to assess scale and receiving facility utilization."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture percentage across received grain — quality KPI directly affecting drying costs and net settlement; high averages during harvest indicate elevated drying cost exposure."
    - name: "avg_dockage_pct"
      expr: AVG(CAST(dockage_pct AS DOUBLE))
      comment: "Average dockage percentage across weight tickets — measures foreign material contamination rate; high values indicate field or handling quality issues affecting net settlement."
    - name: "avg_test_weight_lbs_per_bu"
      expr: AVG(CAST(test_weight_lbs_per_bu AS DOUBLE))
      comment: "Average test weight in lbs per bushel — key grain quality indicator affecting price; below-standard test weights trigger price discounts and grading adjustments."
    - name: "avg_damage_pct"
      expr: AVG(CAST(damage_pct AS DOUBLE))
      comment: "Average damage percentage across received grain — quality risk metric; high damage rates indicate storage or transit issues and trigger price deductions."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit across weight tickets — tracks realized grain purchase price trends versus market benchmarks."
    - name: "tare_weight_total_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight (vehicle/container weight) across tickets — used to validate scale accuracy and detect tare weight manipulation in grain receiving."
    - name: "avg_broken_kernels_pct"
      expr: AVG(CAST(broken_kernels_pct AS DOUBLE))
      comment: "Average broken kernels percentage — grain quality indicator affecting grade and price; high rates indicate mechanical damage during harvest or transport."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment allocation and cash application quality metrics covering allocation efficiency, write-off exposure, deduction management, and early payment discount capture for AR operations and financial close."
  source: "`agriculture_ecm`.`invoice`.`payment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the payment allocation (e.g. Posted, Pending, Reversed) — primary dimension for cash application pipeline management."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g. Standard, Deduction, Write-off, Netting) — used to segment cash application by resolution method."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the allocation — unreconciled allocations represent financial close risk and require AR team resolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the allocation — required for multi-currency cash application reporting."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Indicates whether the allocation is an intercompany transaction — used to exclude intercompany flows from external AR metrics."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Allocation date truncated to month — enables monthly cash application volume and efficiency trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "GL posting date truncated to month — used to align cash application to financial close periods."
    - name: "deduction_code"
      expr: deduction_code
      comment: "Code identifying the type of deduction applied — used to analyze deduction patterns and identify systemic billing or quality issues."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated from payments to invoices — primary cash application volume KPI measuring AR clearance throughput."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off through payment allocations — measures bad debt realization; rising write-offs signal credit quality deterioration requiring policy intervention."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions applied during payment allocation — measures customer-side deduction claims; high values indicate billing disputes or trade promotion compliance issues."
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured through allocations — measures cost of early payment incentive programs and validates discount term compliance."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amounts in payment allocations — measures short-payment and over-payment exceptions; high variances indicate invoicing accuracy issues."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total allocation amount in base (functional) currency — used for consolidated financial reporting and FX translation reconciliation."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of payment allocations — baseline throughput metric for AR operations staffing and automation benchmarking."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Write-off amount as a percentage of total allocated amount — measures bad debt rate within the cash application process; rising rates are a leading indicator of credit portfolio deterioration."
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Deduction amount as a percentage of total allocated amount — measures customer deduction claim rate; high rates indicate systemic billing or trade promotion compliance issues."
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average amount per payment allocation — tracks transaction size trends in cash application and is used to benchmark automation ROI."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_price_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity price adjustment metrics covering adjustment volume, financial impact, quality-driven price changes, and approval workflow efficiency — critical for commodity trading P&L accuracy and grading compliance."
  source: "`agriculture_ecm`.`invoice`.`price_adjustment`"
  dimensions:
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the price adjustment (e.g. Pending, Approved, Posted, Reversed) — primary dimension for adjustment pipeline management."
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of price adjustment (e.g. Quality, Moisture, Dockage, Futures) — identifies the root cause of price changes for commodity trading analysis."
    - name: "adjustment_direction"
      expr: adjustment_direction
      comment: "Direction of the adjustment (e.g. Increase, Decrease) — used to separately analyze upward and downward price corrections."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the adjustment — unapproved adjustments represent financial risk and require management attention."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the price adjustment — required for multi-currency adjustment reporting."
    - name: "quality_factor_code"
      expr: quality_factor_code
      comment: "Quality factor driving the price adjustment (e.g. Moisture, Test Weight, Damage) — used to analyze which quality attributes most frequently trigger price changes."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective date of the adjustment truncated to month — enables monthly adjustment trend analysis and period-end accrual validation."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year of the adjustment effective date — supports annual price adjustment impact analysis and crop year comparisons."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Originating system of the price adjustment — used for data lineage and cross-system reconciliation."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total financial impact of all price adjustments — measures aggregate P&L impact of post-invoice price corrections; large values indicate pricing or quality control issues."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total adjustment amount in functional currency — used for consolidated P&L impact reporting and FX translation reconciliation."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total commodity quantity affected by price adjustments — measures the volume scope of pricing corrections and quality-driven adjustments."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of price adjustments — baseline volume metric for adjustment frequency analysis and process efficiency benchmarking."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average price adjustment amount — tracks adjustment severity trends; rising averages indicate increasing pricing volatility or quality deterioration."
    - name: "avg_adjusted_unit_price"
      expr: AVG(CAST(adjusted_unit_price AS DOUBLE))
      comment: "Average adjusted unit price after corrections — measures realized price after quality and market adjustments; compared to original price to assess adjustment magnitude."
    - name: "avg_original_unit_price"
      expr: AVG(CAST(original_unit_price AS DOUBLE))
      comment: "Average original unit price before adjustments — baseline price metric used to calculate price adjustment impact and validate pricing accuracy."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture percentage on adjusted transactions — identifies moisture as a driver of price adjustments; high averages confirm wet grain quality issues."
    - name: "avg_dockage_pct"
      expr: AVG(CAST(dockage_pct AS DOUBLE))
      comment: "Average dockage percentage on adjusted transactions — measures foreign material contamination driving price deductions."
    - name: "price_adjustment_impact_pct"
      expr: ROUND(100.0 * SUM(CAST(adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_unit_price AS DOUBLE) * CAST(quantity_affected AS DOUBLE)), 0), 2)
      comment: "Total adjustment amount as a percentage of original invoice value (original price × quantity) — measures the relative magnitude of price corrections; high rates indicate systemic pricing or quality issues requiring executive review."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recurring billing schedule performance metrics covering scheduled revenue, billing frequency, discount management, and schedule execution efficiency for contract and subscription billing operations."
  source: "`agriculture_ecm`.`invoice`.`billing_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the billing schedule (e.g. Active, Completed, Suspended, Cancelled) — primary dimension for recurring revenue pipeline management."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of billing schedule (e.g. Recurring, Milestone, Usage-Based) — used to segment recurring revenue by billing model."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing (e.g. Monthly, Quarterly, Annual) — used to analyze recurring revenue cadence and cash flow predictability."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the billing schedule — required for multi-currency recurring revenue reporting."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "Revenue recognition method applied to the schedule — used to align billing schedules to accounting policy and ASC 606 compliance."
    - name: "auto_invoice_flag"
      expr: auto_invoice_flag
      comment: "Indicates whether invoices are generated automatically — used to measure automation adoption and identify manual billing bottlenecks."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Indicates whether billing requires approval before invoicing — used to identify schedules with approval workflow dependencies that may delay cash collection."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Schedule start date truncated to month — used to analyze cohort-based recurring revenue trends."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Schedule end date truncated to month — used to forecast recurring revenue churn and contract renewal timing."
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total scheduled billing amount across all active schedules — measures contracted recurring revenue pipeline and is the primary KPI for subscription and contract billing management."
    - name: "avg_billing_amount"
      expr: AVG(CAST(billing_amount AS DOUBLE))
      comment: "Average billing amount per schedule — tracks average contract value trends and is used to benchmark pricing and upsell effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_percent AS DOUBLE))
      comment: "Sum of discount percentages across billing schedules — measures aggregate commercial discount exposure in the recurring billing portfolio."
    - name: "avg_discount_pct"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across billing schedules — measures pricing discipline in recurring contracts; high averages indicate excessive commercial concessions."
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Total number of billing schedules — measures recurring billing portfolio size and is used to track contract growth and churn."
    - name: "auto_invoice_schedule_count"
      expr: COUNT(CASE WHEN auto_invoice_flag = TRUE THEN 1 END)
      comment: "Number of billing schedules with automatic invoice generation — measures billing automation adoption; low counts indicate manual processing burden."
    - name: "auto_invoice_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_invoice_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of billing schedules using automatic invoice generation — primary billing automation KPI; low rates indicate operational inefficiency and manual error risk."
$$;