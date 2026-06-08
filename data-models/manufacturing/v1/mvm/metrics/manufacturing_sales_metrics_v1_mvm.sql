-- Metric views for domain: sales | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sales pipeline and conversion metrics derived from the opportunity entity. Covers pipeline value, win/loss performance, discount behaviour, and forecast accuracy — core KPIs for sales leadership and revenue operations."
  source: "`manufacturing_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current pipeline stage of the opportunity (e.g. Prospecting, Proposal, Negotiation, Closed Won). Used to analyse stage-gate conversion and pipeline health."
    - name: "forecast_category"
      expr: forecast_category
      comment: "Sales forecast category (e.g. Commit, Best Case, Pipeline, Omitted). Drives revenue forecast accuracy analysis."
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Classification of the opportunity (e.g. New Business, Renewal, Upsell, Cross-sell). Supports mix analysis and growth strategy decisions."
    - name: "lead_source"
      expr: lead_source
      comment: "Channel or campaign that originated the opportunity (e.g. Web, Partner, Event). Used to evaluate marketing and channel ROI."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the target account (e.g. Automotive, Energy, Building Automation). Enables vertical-level pipeline and win-rate analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the opportunity. Supports regional pipeline and quota attainment reporting."
    - name: "product_line"
      expr: product_line
      comment: "Product line associated with the opportunity. Enables product-mix analysis within the pipeline."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year label for the opportunity. Used for year-over-year pipeline and bookings comparisons."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter label for the opportunity. Supports quarterly pipeline reviews and forecast cadence."
    - name: "is_won"
      expr: is_won
      comment: "Boolean flag indicating whether the opportunity was won. Used as a filter dimension for won-vs-lost analysis."
    - name: "is_closed"
      expr: is_closed
      comment: "Boolean flag indicating whether the opportunity is closed (won or lost). Used to separate active pipeline from closed business."
    - name: "close_date_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month-level bucket of the expected close date. Enables monthly pipeline and bookings trend analysis."
    - name: "close_date_quarter"
      expr: DATE_TRUNC('QUARTER', close_date)
      comment: "Quarter-level bucket of the expected close date. Supports quarterly forecast and pipeline reviews."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason recorded when an opportunity is lost (e.g. Price, Competitor, No Decision). Drives win/loss analysis and competitive intelligence."
    - name: "competitor_name"
      expr: competitor_name
      comment: "Primary competitor identified on the opportunity. Used for competitive win-rate and displacement analysis."
  measures:
    - name: "total_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total value of all opportunities in the pipeline (open and closed). The primary pipeline health KPI used in every sales review and forecast meeting."
    - name: "total_won_amount"
      expr: SUM(CASE WHEN is_won = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of won opportunities. Represents realised bookings and is the primary revenue-attainment metric for sales leadership."
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_revenue AS DOUBLE))
      comment: "Sum of probability-weighted expected revenue across all opportunities. Used for statistical revenue forecasting and resource planning."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of opportunities. Baseline volume metric used to contextualise conversion rates and average deal sizes."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN is_won = TRUE THEN 1 END)
      comment: "Count of won opportunities. Numerator for win-rate calculation and a direct measure of sales effectiveness."
    - name: "closed_opportunity_count"
      expr: COUNT(CASE WHEN is_closed = TRUE THEN 1 END)
      comment: "Count of closed opportunities (won + lost). Denominator for win-rate calculation; measures total decision volume."
    - name: "avg_deal_size"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average opportunity value. A key indicator of deal quality and market positioning; tracked by sales leadership to detect mix shifts."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average win probability across open opportunities. Reflects pipeline quality and rep confidence; used in weighted forecast models."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage applied to opportunities. Monitors pricing discipline; excessive discounting erodes margin and signals competitive pressure."
    - name: "total_discounted_value"
      expr: SUM(CAST(amount AS DOUBLE) * CAST(discount_percent AS DOUBLE) / 100.0)
      comment: "Total monetary value surrendered through discounts across all opportunities. Quantifies the revenue impact of discounting decisions for finance and sales ops."
    - name: "open_pipeline_amount"
      expr: SUM(CASE WHEN is_closed = FALSE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total value of currently open (not yet closed) opportunities. The active pipeline coverage metric used to assess whether sufficient pipeline exists to meet quota."
    - name: "weighted_pipeline_amount"
      expr: SUM(CAST(amount AS DOUBLE) * CAST(probability_percent AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value. The standard statistical forecast measure used in commit calls and board-level revenue projections."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_order_intake`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order intake (bookings) metrics covering order volume, value, currency mix, and operational fulfilment signals. These are the primary demand-capture KPIs for manufacturing sales operations and supply chain planning."
  source: "`manufacturing_ecm`.`sales`.`order_intake`"
  dimensions:
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order (e.g. Standard, Frame, Project, Service). Drives mix analysis and fulfilment planning."
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level assigned to the order (e.g. Critical, High, Normal). Used to monitor expedite rates and operational load."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the ordering customer. Enables vertical-level bookings analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the ordered items. Supports product-mix bookings analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the order. Used for multi-currency bookings analysis and FX exposure monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year label for the order. Supports year-over-year bookings comparisons."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter label for the order. Supports quarterly bookings reviews."
    - name: "intake_date_month"
      expr: DATE_TRUNC('MONTH', intake_date)
      comment: "Month-level bucket of the order intake date. Enables monthly bookings trend and seasonality analysis."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method selected for the order (e.g. Air, Sea, Road). Used to analyse logistics cost and lead-time trade-offs."
    - name: "incoterms"
      expr: incoterms
      comment: "International commercial terms governing delivery responsibility. Used for trade compliance and logistics cost analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed for the order (e.g. Net 30, Net 60). Drives working capital and cash-flow forecasting."
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Credit approval status of the order. Used to monitor credit risk exposure and order-hold rates."
    - name: "handoff_status"
      expr: handoff_status
      comment: "Status of the order handoff from sales to operations. Tracks the sales-to-delivery transition efficiency."
    - name: "booking_recognized_flag"
      expr: booking_recognized_flag
      comment: "Boolean flag indicating whether the booking has been formally recognised. Used to reconcile bookings vs. recognised revenue."
    - name: "committed_delivery_date_month"
      expr: DATE_TRUNC('MONTH', committed_delivery_date)
      comment: "Month-level bucket of the committed delivery date. Enables delivery schedule load analysis and capacity planning."
  measures:
    - name: "total_order_value"
      expr: SUM(CAST(order_value AS DOUBLE))
      comment: "Total bookings value in transaction currency. The primary order intake KPI used in sales and operations planning (S&OP) reviews."
    - name: "total_order_value_base_currency"
      expr: SUM(CAST(order_value_base_currency AS DOUBLE))
      comment: "Total bookings value converted to base (reporting) currency. Enables consistent cross-currency bookings comparison for finance and executive reporting."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of orders received. Baseline volume metric for demand analysis and operational capacity planning."
    - name: "avg_order_value"
      expr: AVG(CAST(order_value AS DOUBLE))
      comment: "Average order value in transaction currency. Tracks deal-size trends and is used to detect mix shifts between large project orders and standard product orders."
    - name: "avg_order_value_base_currency"
      expr: AVG(CAST(order_value_base_currency AS DOUBLE))
      comment: "Average order value in base currency. Used for normalised deal-size benchmarking across regions and currencies."
    - name: "recognised_bookings_value"
      expr: SUM(CASE WHEN booking_recognized_flag = TRUE THEN CAST(order_value_base_currency AS DOUBLE) ELSE 0 END)
      comment: "Total base-currency value of formally recognised bookings. Used to reconcile sales bookings against finance revenue recognition records."
    - name: "unrecognised_bookings_value"
      expr: SUM(CASE WHEN booking_recognized_flag = FALSE THEN CAST(order_value_base_currency AS DOUBLE) ELSE 0 END)
      comment: "Total base-currency value of orders not yet recognised as bookings. Highlights backlog requiring finance review or credit clearance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across orders. Used by treasury and finance to monitor FX translation risk in the order book."
    - name: "high_priority_order_count"
      expr: COUNT(CASE WHEN order_priority = 'Critical' OR order_priority = 'High' THEN 1 END)
      comment: "Count of critical or high-priority orders. Monitors expedite load on manufacturing and logistics operations; high rates signal capacity or supply risk."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quoting performance and commercial quality metrics. Covers quote volume, value, discount levels, win probability, and cycle-time signals — essential for sales effectiveness and pricing governance."
  source: "`manufacturing_ecm`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote (e.g. Draft, Presented, Accepted, Rejected). Used to track quote pipeline and conversion funnel."
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote (e.g. Standard, Custom, Framework). Supports mix analysis of quoting activity."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the quote (e.g. Pending, Approved, Rejected). Used to monitor pricing governance and approval cycle times."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the quote. Enables multi-currency quoting analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms applied to the quote. Used for trade and logistics compliance analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the quote. Supports working capital and cash-flow impact analysis."
    - name: "non_standard_discount_flag"
      expr: non_standard_discount_flag
      comment: "Boolean flag indicating a non-standard (exception) discount was applied. Used to monitor pricing policy compliance and exception rates."
    - name: "quote_date_month"
      expr: DATE_TRUNC('MONTH', quote_date)
      comment: "Month-level bucket of the quote creation date. Enables monthly quoting activity trend analysis."
    - name: "quote_date_quarter"
      expr: DATE_TRUNC('QUARTER', quote_date)
      comment: "Quarter-level bucket of the quote creation date. Supports quarterly quoting volume and conversion reviews."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method specified on the quote. Used for logistics cost and lead-time analysis."
  measures:
    - name: "total_quote_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes issued. Measures the commercial pipeline generated by the quoting process; a leading indicator of future bookings."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-shipping subtotal across all quotes. Used to analyse net product revenue potential before adjustments."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary discount granted across all quotes. Quantifies the revenue impact of discounting decisions; a key pricing governance metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all quotes. Used for tax liability estimation and compliance reporting."
    - name: "quote_count"
      expr: COUNT(1)
      comment: "Total number of quotes created. Baseline quoting activity metric used to assess sales team productivity and pipeline generation."
    - name: "accepted_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Accepted' THEN 1 END)
      comment: "Count of accepted quotes. Numerator for quote-to-order conversion rate; a direct measure of quoting effectiveness."
    - name: "rejected_quote_count"
      expr: COUNT(CASE WHEN quote_status = 'Rejected' THEN 1 END)
      comment: "Count of rejected quotes. Used to analyse rejection rates and identify pricing or commercial terms issues."
    - name: "avg_quote_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total quote value. Tracks deal-size trends in the quoting pipeline and informs pricing strategy."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across quotes. Monitors pricing discipline; a critical metric for pricing governance and margin protection."
    - name: "avg_win_probability_percentage"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability assigned to quotes. Reflects commercial confidence in the quoting pipeline; used in weighted revenue forecasting."
    - name: "non_standard_discount_count"
      expr: COUNT(CASE WHEN non_standard_discount_flag = TRUE THEN 1 END)
      comment: "Count of quotes with non-standard (exception) discounts. Measures pricing policy exception rate; high counts signal governance risk and margin leakage."
    - name: "total_non_standard_discount_amount"
      expr: SUM(CASE WHEN non_standard_discount_flag = TRUE THEN CAST(discount_amount AS DOUBLE) ELSE 0 END)
      comment: "Total discount value granted under non-standard (exception) approvals. Quantifies the financial exposure from pricing policy exceptions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level quoting metrics covering product mix, margin, discount, and cost performance. Provides the granular commercial intelligence needed for product pricing reviews, margin management, and sales mix analysis."
  source: "`manufacturing_ecm`.`sales`.`quote_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the quote line (e.g. Active, Cancelled, Won, Lost). Used to filter and segment line-level analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of quote line (e.g. Product, Service, Spare Part). Enables product vs. service mix analysis."
    - name: "product_family"
      expr: product_family
      comment: "Product family of the quoted item. Supports product-family-level margin and pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the quote line. Enables multi-currency line-level analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the quoted quantity. Used for volume and pricing normalisation."
    - name: "is_optional"
      expr: is_optional
      comment: "Boolean flag indicating whether the line is an optional item. Used to separate core vs. optional scope in deal analysis."
    - name: "is_bundle_parent"
      expr: is_bundle_parent
      comment: "Boolean flag indicating whether the line is the parent of a product bundle. Used to analyse bundle vs. standalone product quoting."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval level required for the quote line (e.g. Manager, Director, VP). Used to monitor pricing governance and escalation rates."
    - name: "created_date_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month-level bucket of the quote line creation date. Enables monthly quoting activity and margin trend analysis."
    - name: "committed_delivery_date_month"
      expr: DATE_TRUNC('MONTH', committed_delivery_date)
      comment: "Month-level bucket of the committed delivery date on the line. Used for delivery load and backlog analysis."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quote lines. Measures the gross commercial value in the quoting pipeline at line level."
    - name: "total_margin_amount"
      expr: SUM(CAST(margin_amount AS DOUBLE))
      comment: "Total gross margin amount across all quote lines. The primary profitability metric for the quoting pipeline; used in deal review and pricing approval processes."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of goods across all quote lines. Used to assess cost exposure and validate margin calculations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted at line level. Measures the revenue impact of line-level discounting decisions."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity quoted across all lines. Used for volume analysis and demand forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across all quote lines. Tracks pricing level trends and is used to detect price erosion or mix shifts."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across all quote lines. Provides the baseline for measuring discount depth relative to standard pricing."
    - name: "avg_margin_percent"
      expr: AVG(CAST(margin_percent AS DOUBLE))
      comment: "Average margin percentage across all quote lines. The key profitability rate metric used in pricing reviews and deal approval workflows."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at line level. Monitors pricing discipline at the most granular level; used to identify high-discount product lines."
    - name: "avg_commission_percent"
      expr: AVG(CAST(commission_percent AS DOUBLE))
      comment: "Average commission percentage across quote lines. Used by sales compensation and finance to estimate commission liability in the pipeline."
    - name: "quote_line_count"
      expr: COUNT(1)
      comment: "Total number of quote lines. Baseline volume metric for quoting complexity and workload analysis."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio metrics covering contracted value, liability exposure, SLA commitments, and contract lifecycle status. Essential for revenue recognition, risk management, and commercial governance."
  source: "`manufacturing_ecm`.`sales`.`contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current lifecycle status of the contract (e.g. Active, Expired, Terminated, Pending). Used to segment the active contract portfolio from historical records."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g. Framework, Project, Service, Supply). Enables contract-mix analysis and risk segmentation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified in the contract (e.g. Bank Transfer, Letter of Credit). Used for cash-flow and treasury analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms in the contract (e.g. Net 30, Milestone). Drives working capital and cash-flow forecasting."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility. Used for trade compliance and logistics cost analysis."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the contract. Used for legal risk and compliance analysis."
    - name: "value_currency"
      expr: value_currency
      comment: "Currency of the contract value. Enables multi-currency contract portfolio analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month-level bucket of the contract effective date. Used for contract inception trend analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month-level bucket of the contract expiration date. Used for contract renewal pipeline and expiry risk analysis."
    - name: "approval_date_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month-level bucket of the contract approval date. Used to track approval cycle times and governance throughput."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(value_amount AS DOUBLE))
      comment: "Total face value of all contracts. The primary contracted revenue metric used in revenue recognition planning and executive portfolio reviews."
    - name: "total_net_contract_value"
      expr: SUM(CAST(net_contract_value AS DOUBLE))
      comment: "Total net contract value after adjustments. Used for accurate revenue backlog and recognised revenue calculations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all contracts. Used for tax liability estimation and compliance reporting."
    - name: "total_liability_cap_amount"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total contractual liability cap exposure across the portfolio. A critical risk metric for legal and finance teams managing commercial risk."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of contracts. Baseline portfolio size metric used to contextualise average values and risk exposure."
    - name: "avg_contract_value"
      expr: AVG(CAST(value_amount AS DOUBLE))
      comment: "Average contract value. Tracks deal-size trends in the contracted portfolio and informs commercial strategy."
    - name: "avg_net_contract_value"
      expr: AVG(CAST(net_contract_value AS DOUBLE))
      comment: "Average net contract value. Used to benchmark contract quality and detect value erosion from adjustments."
    - name: "avg_sla_uptime_percentage"
      expr: AVG(CAST(sla_uptime_percentage AS DOUBLE))
      comment: "Average contracted SLA uptime percentage across the portfolio. Measures the aggregate service commitment level; high averages indicate premium service obligations and associated delivery risk."
    - name: "avg_liability_cap_amount"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average contractual liability cap per contract. Used by legal and risk teams to benchmark liability exposure relative to contract value."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative performance and capacity metrics. Covers quota attainment potential, book-of-business value, and workforce composition — used by sales leadership for territory planning, coaching, and incentive management."
  source: "`manufacturing_ecm`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Employment/activity status of the sales rep (e.g. Active, On Leave, Terminated). Used to filter active vs. inactive rep populations."
    - name: "sales_role"
      expr: sales_role
      comment: "Role of the sales rep (e.g. Account Executive, Inside Sales, Channel Manager). Enables role-based performance benchmarking."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel the rep operates in (e.g. Direct, Indirect, Digital). Used for channel-level productivity and cost analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rep is assigned to (e.g. Enterprise, Mid-Market, SMB). Enables segment-level quota and performance analysis."
    - name: "industry_vertical_focus"
      expr: industry_vertical_focus
      comment: "Industry vertical the rep specialises in. Used for vertical-level coverage and performance analysis."
    - name: "performance_rating"
      expr: performance_rating
      comment: "Latest performance rating of the rep (e.g. Exceeds, Meets, Below). Used for talent management and coaching prioritisation."
    - name: "is_key_account_manager"
      expr: is_key_account_manager
      comment: "Boolean flag indicating whether the rep manages key/strategic accounts. Used to segment KAM vs. standard rep performance."
    - name: "quota_currency_code"
      expr: quota_currency_code
      comment: "Currency in which the rep's quota is denominated. Used for multi-currency quota and attainment analysis."
    - name: "hire_date_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year-level bucket of the rep's hire date. Used for tenure cohort analysis and ramp-time benchmarking."
    - name: "product_line_specialization"
      expr: product_line_specialization
      comment: "Product line the rep specialises in. Enables product-line coverage gap analysis."
  measures:
    - name: "total_annual_quota"
      expr: SUM(CAST(annual_quota_amount AS DOUBLE))
      comment: "Total annual quota across all sales reps. The aggregate revenue target for the sales organisation; used in quota-setting and attainment tracking."
    - name: "total_book_of_business_value"
      expr: SUM(CAST(book_of_business_value AS DOUBLE))
      comment: "Total book-of-business value managed by all reps. Measures the aggregate revenue responsibility of the sales force; used for territory sizing and capacity planning."
    - name: "avg_annual_quota"
      expr: AVG(CAST(annual_quota_amount AS DOUBLE))
      comment: "Average annual quota per sales rep. Used to benchmark quota levels across roles, segments, and regions; informs quota-setting fairness and competitiveness."
    - name: "avg_book_of_business_value"
      expr: AVG(CAST(book_of_business_value AS DOUBLE))
      comment: "Average book-of-business value per rep. Measures rep capacity utilisation; used to identify over- or under-loaded reps and optimise territory assignments."
    - name: "active_rep_count"
      expr: COUNT(CASE WHEN rep_status = 'Active' THEN 1 END)
      comment: "Count of currently active sales reps. Baseline headcount metric for sales capacity planning and cost-per-rep analysis."
    - name: "key_account_manager_count"
      expr: COUNT(CASE WHEN is_key_account_manager = TRUE THEN 1 END)
      comment: "Count of reps designated as Key Account Managers. Used to assess KAM coverage relative to the strategic account portfolio."
    - name: "total_rep_count"
      expr: COUNT(1)
      comment: "Total number of sales rep records. Used as the denominator for per-rep averages and coverage ratio calculations."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales territory design and quota metrics. Covers revenue quota allocation, territory coverage, and organisational structure — used by sales operations and leadership for territory planning, quota fairness analysis, and go-to-market design."
  source: "`manufacturing_ecm`.`sales`.`territory`"
  dimensions:
    - name: "territory_status"
      expr: territory_status
      comment: "Current status of the territory (e.g. Active, Inactive, Pending). Used to filter the active territory portfolio."
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory (e.g. Geographic, Named Account, Overlay). Enables territory-type mix analysis."
    - name: "region_level"
      expr: region_level
      comment: "Hierarchical region level of the territory (e.g. Global, Regional, Country). Used for multi-level geographic analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment covered by the territory (e.g. Enterprise, Mid-Market). Enables segment-level quota and coverage analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical focus of the territory. Used for vertical-level coverage and quota analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel model for the territory (e.g. Direct, Partner). Supports channel strategy and coverage analysis."
    - name: "coverage_model"
      expr: coverage_model
      comment: "Coverage model applied to the territory (e.g. Named Account, Geographic, Hybrid). Used to analyse go-to-market design effectiveness."
    - name: "is_overlay_territory"
      expr: is_overlay_territory
      comment: "Boolean flag indicating whether the territory is an overlay (specialist) territory. Used to separate overlay from primary territory quota and coverage analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for which the territory and quota are defined. Enables year-over-year territory and quota comparison."
    - name: "quota_currency_code"
      expr: quota_currency_code
      comment: "Currency in which the territory quota is denominated. Used for multi-currency quota analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the territory design (e.g. Approved, Pending, Rejected). Used to track territory planning governance."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year-level bucket of the territory effective start date. Used for territory lifecycle and redesign trend analysis."
  measures:
    - name: "total_annual_revenue_quota"
      expr: SUM(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Total annual revenue quota across all territories. The aggregate revenue target for the go-to-market organisation; used in quota-setting, attainment tracking, and territory design reviews."
    - name: "avg_annual_revenue_quota"
      expr: AVG(CAST(annual_revenue_quota AS DOUBLE))
      comment: "Average annual revenue quota per territory. Used to benchmark quota levels across territory types, regions, and segments; informs quota fairness and territory sizing decisions."
    - name: "territory_count"
      expr: COUNT(1)
      comment: "Total number of territory records. Baseline metric for go-to-market coverage analysis and sales capacity planning."
    - name: "active_territory_count"
      expr: COUNT(CASE WHEN territory_status = 'Active' THEN 1 END)
      comment: "Count of currently active territories. Used to assess active go-to-market coverage and identify gaps or overlaps in territory design."
    - name: "overlay_territory_count"
      expr: COUNT(CASE WHEN is_overlay_territory = TRUE THEN 1 END)
      comment: "Count of overlay (specialist) territories. Used to assess the scale of specialist coverage investment relative to primary territory coverage."
    - name: "total_overlay_quota"
      expr: SUM(CASE WHEN is_overlay_territory = TRUE THEN CAST(annual_revenue_quota AS DOUBLE) ELSE 0 END)
      comment: "Total quota allocated to overlay territories. Used to quantify the revenue responsibility of specialist overlay roles and assess their ROI."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`sales_price_book_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product pricing and margin metrics at the price book entry level. Covers list price levels, cost-to-price ratios, discount policy limits, and pricing mix — essential for pricing strategy, margin management, and commercial governance."
  source: "`manufacturing_ecm`.`sales`.`price_book_entry`"
  dimensions:
    - name: "price_type"
      expr: price_type
      comment: "Type of price entry (e.g. List, Contract, Promotional). Used to segment pricing analysis by price type."
    - name: "pricing_method"
      expr: pricing_method
      comment: "Pricing methodology applied (e.g. Cost-Plus, Market-Based, Value-Based). Used to analyse pricing strategy mix."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price book entry. Enables multi-currency pricing analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for which the price applies. Enables segment-level pricing and margin analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for which the price applies. Used for market-level pricing strategy analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel for which the price applies (e.g. Direct, Distributor). Enables channel-level pricing analysis."
    - name: "product_line"
      expr: product_line
      comment: "Product line of the price book entry. Supports product-line-level pricing and margin analysis."
    - name: "geography_code"
      expr: geography_code
      comment: "Geographic code for which the price applies. Used for regional pricing analysis and compliance."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the price book entry is currently active. Used to filter active vs. historical pricing records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the price book entry (e.g. Approved, Pending, Rejected). Used to monitor pricing governance and approval cycle times."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month-level bucket of the price effective start date. Used for pricing change trend analysis."
  measures:
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across all price book entries. Tracks the overall pricing level in the catalogue; used to monitor price inflation/deflation trends."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit (net) price across all price book entries. Measures the effective price level after standard adjustments; used for pricing strategy benchmarking."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price across all price book entries. Used to assess cost levels and validate margin calculations in the pricing catalogue."
    - name: "avg_minimum_price"
      expr: AVG(CAST(minimum_price AS DOUBLE))
      comment: "Average minimum (floor) price across all price book entries. Used to assess the adequacy of price floors in protecting margin."
    - name: "avg_maximum_discount_percent"
      expr: AVG(CAST(maximum_discount_percent AS DOUBLE))
      comment: "Average maximum allowable discount percentage across all price book entries. Measures the aggregate discount policy latitude; used in pricing governance reviews."
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Sum of list prices across all price book entries. Used as a baseline for calculating aggregate price-to-cost ratios and discount exposure."
    - name: "total_cost_price"
      expr: SUM(CAST(cost_price AS DOUBLE))
      comment: "Sum of cost prices across all price book entries. Used as the denominator for portfolio-level margin analysis."
    - name: "price_book_entry_count"
      expr: COUNT(1)
      comment: "Total number of price book entries. Measures the breadth of the pricing catalogue; used for pricing governance and catalogue management."
    - name: "active_price_book_entry_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active price book entries. Measures the size of the live pricing catalogue; used to assess catalogue health and coverage."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across price book entries. Used to assess order size requirements and their impact on customer accessibility and logistics efficiency."
$$;