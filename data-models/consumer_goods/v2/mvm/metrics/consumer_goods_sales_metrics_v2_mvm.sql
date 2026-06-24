-- Metric views for domain: sales | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core sales order performance metrics. Tracks order volume, revenue, and order mix by key business dimensions to support pipeline management, territory performance, and revenue forecasting."
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current lifecycle status of the order (e.g. Open, Fulfilled, Cancelled). Used to segment pipeline vs. closed revenue."
    - name: "order_type"
      expr: order_type
      comment: "Classification of the order type (e.g. Standard, Dropship, Sample). Drives channel and fulfillment analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the order. Required for multi-currency revenue normalization."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms on the order (e.g. Net30, Net60). Informs cash flow and credit risk analysis."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Order date truncated to month. Enables monthly trend and seasonality analysis."
    - name: "order_date_year"
      expr: DATE_TRUNC('YEAR', order_date)
      comment: "Order date truncated to year. Enables year-over-year revenue comparison."
    - name: "requested_delivery_date_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Requested delivery month. Used to align demand signals with supply planning."
  measures:
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from all orders. Primary top-line revenue KPI used in QBRs and board reporting."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value (AOV). A key commercial health indicator — declining AOV signals pricing pressure or mix shift toward smaller orders."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of orders placed. Measures sales volume and activity throughput across territories and reps."
    - name: "distinct_trade_account_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts placing orders. Measures customer breadth and identifies concentration risk."
    - name: "distinct_rep_count"
      expr: COUNT(DISTINCT rep_id)
      comment: "Number of distinct sales reps generating orders. Used to assess rep productivity and coverage."
    - name: "dropship_order_count"
      expr: COUNT(CASE WHEN dropship_supplier_id IS NOT NULL THEN 1 END)
      comment: "Number of orders fulfilled via dropship suppliers. Tracks dropship channel volume for supplier management and margin analysis."
    - name: "total_dropship_revenue"
      expr: SUM(CASE WHEN dropship_supplier_id IS NOT NULL THEN CAST(total_amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from dropship orders. Enables margin comparison between owned-inventory and dropship fulfillment channels."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable and invoicing performance metrics. Tracks billed revenue, outstanding balances, tax exposure, and collection efficiency to support finance and credit management decisions."
  source: "`vibe_consumer_goods_v1`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g. Open, Paid, Overdue, Cancelled). Core dimension for AR aging and collection analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the invoice. Required for multi-currency AR reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month. Enables monthly billing cycle and revenue recognition analysis."
    - name: "invoice_date_year"
      expr: DATE_TRUNC('YEAR', invoice_date)
      comment: "Invoice date truncated to year. Supports annual revenue recognition and audit reporting."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Invoice due date truncated to month. Used for cash flow forecasting and AR aging bucket analysis."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross invoiced revenue. Represents billed revenue and is the primary AR top-line metric for finance reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across all invoices. Required for tax compliance reporting and regulatory submissions."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average invoice value. Tracks deal size trends and flags anomalies in billing patterns."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Measures billing activity volume and supports workload and process efficiency analysis."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Paid' THEN 1 END)
      comment: "Number of invoices with Paid status. Numerator for collection rate calculation and AR health monitoring."
    - name: "open_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'Open' THEN 1 END)
      comment: "Number of invoices still open (unpaid). Key AR risk indicator used by credit and collections teams."
    - name: "total_open_ar_amount"
      expr: SUM(CASE WHEN invoice_status = 'Open' THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total outstanding AR balance on open invoices. Critical cash flow and credit risk metric reviewed at every finance steering meeting."
    - name: "distinct_trade_account_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts invoiced. Measures billing reach and identifies customer concentration in AR exposure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_return_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales return and reverse logistics performance metrics. Tracks return volume, return value, and return reasons to support quality management, customer satisfaction, and margin protection decisions."
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_return_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total monetary value of returned goods. Directly measures revenue reversal impact and is a key margin protection KPI."
    - name: "return_order_count"
      expr: COUNT(1)
      comment: "Total number of return orders. Measures return volume and is the denominator for return rate calculations."
    - name: "avg_return_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per return order. Identifies whether high-value or low-value products are driving return exposure."
    - name: "distinct_trade_account_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts submitting returns. Identifies accounts with disproportionate return activity for targeted account management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_trade_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade account portfolio health and segmentation metrics. Tracks account base size, credit exposure, revenue potential, and account mix to support sales strategy, credit risk, and territory planning."
  source: "`vibe_consumer_goods_v1`.`sales`.`trade_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the trade account (e.g. Active, Inactive, Suspended). Used to segment the active customer base from churned or at-risk accounts."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Distributor, Retailer, Wholesaler). Drives channel strategy and go-to-market segmentation."
    - name: "industry_code"
      expr: industry_code
      comment: "Industry classification of the trade account. Enables vertical market analysis and industry-specific sales strategy."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms agreed with the account. Used for cash flow forecasting and credit risk segmentation."
    - name: "country_code"
      expr: CASE WHEN parent_trade_account_id IS NULL THEN 'Parent' ELSE 'Child' END
      comment: "Derived flag indicating whether the account is a parent (no parent_trade_account_id) or child account. Supports account hierarchy analysis."
    - name: "created_year"
      expr: DATE_TRUNC('YEAR', created_timestamp)
      comment: "Year the trade account was created. Used for cohort analysis and new account acquisition trend reporting."
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of trade accounts in the portfolio. Measures customer base size and is the foundation for market penetration analysis."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of currently active trade accounts. Key indicator of the productive customer base size used in sales capacity planning."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit extended across all trade accounts. Measures aggregate credit risk exposure for the finance and credit management function."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per trade account. Benchmarks credit policy consistency and identifies outlier accounts with unusually high or low credit."
    - name: "total_annual_revenue_potential"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of reported annual revenue across all trade accounts. Proxy for total addressable wallet size within the account portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per trade account. Used to segment high-value vs. low-value accounts and prioritize sales resource allocation."
    - name: "parent_account_count"
      expr: COUNT(CASE WHEN parent_trade_account_id IS NULL THEN 1 END)
      comment: "Number of top-level (parent) trade accounts with no parent relationship. Measures the number of independent customer entities in the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_pricing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing agreement coverage and discount management metrics. Tracks the breadth, depth, and status of commercial pricing agreements to support margin management, contract compliance, and pricing strategy decisions."
  source: "`vibe_consumer_goods_v1`.`sales`.`pricing_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the pricing agreement (e.g. Active, Expired, Pending). Used to monitor contract coverage and identify gaps requiring renewal."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (e.g. Volume, Promotional, Strategic). Enables analysis of discount strategy by agreement category."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the pricing agreement became effective. Used to track new agreement activation cadence."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the pricing agreement expires. Critical for contract renewal pipeline management and revenue risk forecasting."
  measures:
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Number of currently active pricing agreements. Measures commercial contract coverage across the customer base."
    - name: "total_agreement_count"
      expr: COUNT(1)
      comment: "Total number of pricing agreements across all statuses. Baseline for agreement portfolio size and renewal pipeline analysis."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across all pricing agreements. Key margin management metric — rising average discount signals pricing discipline erosion."
    - name: "max_discount_percentage"
      expr: MAX(CAST(discount_percentage AS DOUBLE))
      comment: "Maximum discount percentage granted in any single agreement. Identifies outlier deals that may require executive approval or margin review."
    - name: "distinct_trade_account_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts covered by pricing agreements. Measures commercial agreement penetration across the customer portfolio."
    - name: "expiring_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' AND expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of active agreements expiring within the next 90 days. Drives contract renewal urgency and revenue risk management actions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_rep`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales representative workforce and coverage metrics. Tracks rep headcount, tenure, and territory coverage to support sales force planning, productivity benchmarking, and talent management decisions."
  source: "`vibe_consumer_goods_v1`.`sales`.`rep`"
  dimensions:
    - name: "rep_status"
      expr: rep_status
      comment: "Current employment/activity status of the sales rep (e.g. Active, Inactive, On Leave). Used to measure active selling capacity."
    - name: "rep_type"
      expr: rep_type
      comment: "Classification of the rep role (e.g. Field, Inside, Key Account). Enables productivity benchmarking by rep type and channel."
    - name: "hire_date_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year the rep was hired. Used for tenure cohort analysis and attrition trend reporting."
  measures:
    - name: "total_rep_count"
      expr: COUNT(1)
      comment: "Total number of sales reps in the organization. Baseline headcount metric for sales capacity planning and quota allocation."
    - name: "active_rep_count"
      expr: COUNT(CASE WHEN rep_status = 'Active' THEN 1 END)
      comment: "Number of currently active sales reps. Measures productive selling capacity and is used to calculate revenue-per-rep productivity ratios."
    - name: "distinct_territory_count"
      expr: COUNT(DISTINCT territory_id)
      comment: "Number of distinct territories covered by reps. Identifies territory coverage gaps and informs territory design decisions."
    - name: "avg_tenure_days"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), hire_date) AS DOUBLE))
      comment: "Average tenure in days across all reps. Measures workforce experience depth — low average tenure signals high attrition risk and ramp-up cost exposure."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_retail_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail store network footprint and capacity metrics. Tracks store count, format mix, geographic distribution, and physical capacity to support retail expansion, format strategy, and distribution planning decisions."
  source: "`vibe_consumer_goods_v1`.`sales`.`retail_store`"
  dimensions:
    - name: "store_status"
      expr: store_status
      comment: "Current operational status of the retail store (e.g. Open, Closed, Under Renovation). Used to measure active retail network size."
    - name: "store_format"
      expr: store_format
      comment: "Format classification of the store (e.g. Flagship, Express, Outlet). Drives format-level performance benchmarking and expansion strategy."
    - name: "country_code"
      expr: country_code
      comment: "Country where the retail store is located. Enables geographic retail network analysis and international expansion tracking."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the retail store. Supports regional retail density and coverage analysis."
    - name: "opening_date_year"
      expr: DATE_TRUNC('YEAR', opening_date)
      comment: "Year the store opened. Used for store vintage cohort analysis and network maturity assessment."
  measures:
    - name: "total_store_count"
      expr: COUNT(1)
      comment: "Total number of retail stores in the network. Primary retail footprint KPI used in investor reporting and expansion planning."
    - name: "active_store_count"
      expr: COUNT(CASE WHEN store_status = 'Open' THEN 1 END)
      comment: "Number of currently open and operational stores. Measures productive retail capacity and is used to normalize revenue-per-store metrics."
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total retail square footage across all stores. Measures physical retail capacity and is used to compute revenue-per-square-foot productivity."
    - name: "avg_square_footage_per_store"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average store size in square feet. Benchmarks store format sizing and informs real estate strategy for new store openings."
    - name: "distinct_trade_account_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of distinct trade accounts operating retail stores. Measures retail channel partner breadth and concentration."
$$;