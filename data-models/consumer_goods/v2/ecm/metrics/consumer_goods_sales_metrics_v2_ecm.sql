-- Metric views for domain: sales | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_trade_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics including account counts, revenue potential, and credit exposure segmented by account characteristics"
  source: "`vibe_consumer_goods_v1`.`sales`.`trade_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the trade account (active, inactive, suspended)"
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (distributor, retailer, wholesaler)"
    - name: "account_segment"
      expr: account_segment_id
      comment: "Account segment identifier for cohort analysis"
    - name: "territory"
      expr: territory_id
      comment: "Sales territory identifier"
    - name: "industry_code"
      expr: industry_code
      comment: "Industry classification code for vertical analysis"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms for the account"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Total number of unique trade accounts"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across all accounts"
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales order performance metrics including order volume, value, and fulfillment timing"
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (pending, confirmed, shipped, cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (standard, rush, drop-ship)"
    - name: "order_date"
      expr: order_date
      comment: "Date the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for time-series analysis"
    - name: "order_quarter"
      expr: DATE_TRUNC('QUARTER', order_date)
      comment: "Quarter of order placement for seasonal analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order was placed"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the order"
    - name: "trade_account"
      expr: trade_account_id
      comment: "Customer account identifier"
  measures:
    - name: "total_orders"
      expr: COUNT(DISTINCT order_id)
      comment: "Total number of unique orders"
    - name: "total_order_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross merchandise value across all orders"
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average order value per order"
    - name: "unique_customers"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique customers placing orders"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice and accounts receivable metrics including billing value, payment performance, and aging"
  source: "`vibe_consumer_goods_v1`.`sales`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (open, paid, overdue, disputed)"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice"
    - name: "trade_account"
      expr: trade_account_id
      comment: "Customer account identifier"
  measures:
    - name: "total_invoices"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Total number of invoices issued"
    - name: "total_invoice_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total invoiced amount before tax"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average invoice amount per invoice"
    - name: "unique_invoiced_customers"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique customers invoiced"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale transaction metrics including retail sell-through, velocity, and promotional effectiveness"
  source: "`vibe_consumer_goods_v1`.`sales`.`pos_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the POS transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for time-series analysis"
    - name: "transaction_quarter"
      expr: DATE_TRUNC('QUARTER', transaction_date)
      comment: "Quarter of transaction for seasonal analysis"
    - name: "retail_store"
      expr: retail_store_id
      comment: "Store identifier where transaction occurred"
    - name: "sku"
      expr: sku_id
      comment: "Product SKU sold"
  measures:
    - name: "total_transactions"
      expr: COUNT(DISTINCT pos_transaction_id)
      comment: "Total number of POS transactions"
    - name: "total_units_sold"
      expr: SUM(CAST(quantity_sold AS DOUBLE))
      comment: "Total units sold across all transactions"
    - name: "total_sales_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total sales revenue at retail"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given"
    - name: "avg_transaction_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average transaction value per POS transaction"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per item sold"
    - name: "unique_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores with transactions"
    - name: "unique_skus_sold"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs sold"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_quota`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales quota and attainment metrics for performance management and compensation"
  source: "`vibe_consumer_goods_v1`.`sales`.`quota`"
  dimensions:
    - name: "quota_type"
      expr: quota_type
      comment: "Type of quota (revenue, volume, new accounts)"
    - name: "period"
      expr: period
      comment: "Quota period (monthly, quarterly, annual)"
    - name: "start_date"
      expr: start_date
      comment: "Start date of the quota period"
    - name: "end_date"
      expr: end_date
      comment: "End date of the quota period"
    - name: "rep"
      expr: rep_id
      comment: "Sales representative identifier"
  measures:
    - name: "total_quota_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total quota target amount"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual achievement amount"
    - name: "avg_quota_per_rep"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average quota amount per sales rep"
    - name: "avg_actual_per_rep"
      expr: AVG(CAST(actual_amount AS DOUBLE))
      comment: "Average actual achievement per sales rep"
    - name: "unique_reps_with_quota"
      expr: COUNT(DISTINCT rep_id)
      comment: "Number of unique sales reps with assigned quotas"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and opportunity metrics for forecasting and pipeline management"
  source: "`vibe_consumer_goods_v1`.`sales`.`opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the opportunity (open, won, lost)"
    - name: "stage"
      expr: stage
      comment: "Sales stage of the opportunity (prospecting, qualification, proposal, negotiation)"
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Expected close date of the opportunity"
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Expected close month for pipeline forecasting"
    - name: "expected_close_quarter"
      expr: DATE_TRUNC('QUARTER', expected_close_date)
      comment: "Expected close quarter for pipeline forecasting"
    - name: "trade_account"
      expr: trade_account_id
      comment: "Customer account identifier"
    - name: "rep"
      expr: rep_id
      comment: "Sales representative identifier"
  measures:
    - name: "total_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Total number of opportunities in pipeline"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all opportunities"
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per opportunity"
    - name: "avg_win_probability"
      expr: AVG(CAST(probability_pct AS DOUBLE))
      comment: "Average win probability across all opportunities"
    - name: "unique_accounts_in_pipeline"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique accounts with open opportunities"
    - name: "unique_reps_with_opportunities"
      expr: COUNT(DISTINCT rep_id)
      comment: "Number of unique sales reps with opportunities"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit risk and payment performance metrics for credit management and risk mitigation"
  source: "`vibe_consumer_goods_v1`.`sales`.`account_credit_profile`"
  dimensions:
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification (A, B, C, D)"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicator if account is on credit hold"
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Standard payment terms in days"
    - name: "last_credit_review_date"
      expr: last_credit_review_date
      comment: "Date of last credit review"
    - name: "trade_account"
      expr: trade_account_id
      comment: "Customer account identifier"
  measures:
    - name: "total_accounts_with_credit"
      expr: COUNT(DISTINCT account_credit_profile_id)
      comment: "Total number of accounts with credit profiles"
    - name: "total_credit_limit_extended"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "avg_days_sales_outstanding"
      expr: AVG(CAST(days_sales_outstanding AS DOUBLE))
      comment: "Average DSO across all accounts - key working capital metric"
    - name: "unique_accounts_on_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = true THEN trade_account_id END)
      comment: "Number of unique accounts currently on credit hold"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_return_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product return metrics for quality monitoring and customer satisfaction analysis"
  source: "`vibe_consumer_goods_v1`.`sales`.`order`"
  dimensions:
    - name: "trade_account"
      expr: trade_account_id
      comment: "Customer account identifier"
    - name: "original_order"
      expr: order_id
      comment: "Original order identifier"
  measures:
    - name: "total_return_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of returned goods"
    - name: "avg_return_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per return order"
    - name: "unique_customers_with_returns"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique customers who initiated returns"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trade deduction and chargeback metrics for revenue leakage analysis and dispute management"
  source: "`vibe_consumer_goods_v1`.`sales`.`sales_deduction`"
  dimensions:
    - name: "deduction_status"
      expr: deduction_status
      comment: "Current status of the deduction (open, approved, denied, disputed)"
    - name: "deduction_type"
      expr: deduction_type
      comment: "Type of deduction (promotional, shortage, pricing, damage)"
    - name: "deduction_reason"
      expr: deduction_reason
      comment: "Reason code for the deduction"
    - name: "deduction_date"
      expr: deduction_date
      comment: "Date the deduction was taken"
    - name: "deduction_month"
      expr: DATE_TRUNC('MONTH', deduction_date)
      comment: "Month of deduction for trend analysis"
    - name: "trade_account"
      expr: trade_account_id
      comment: "Customer account identifier"
    - name: "invoice"
      expr: invoice_id
      comment: "Related invoice identifier"
  measures:
    - name: "total_deductions"
      expr: COUNT(DISTINCT sales_deduction_id)
      comment: "Total number of deduction claims"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total amount deducted - key revenue leakage metric"
    - name: "avg_deduction_amount"
      expr: AVG(CAST(deduction_amount AS DOUBLE))
      comment: "Average deduction amount per claim"
    - name: "unique_customers_with_deductions"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique customers taking deductions"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_retail_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail store footprint and distribution metrics for market coverage and expansion planning"
  source: "`vibe_consumer_goods_v1`.`sales`.`retail_store`"
  dimensions:
    - name: "store_status"
      expr: store_status
      comment: "Current status of the store (active, closed, planned)"
    - name: "store_format"
      expr: store_format
      comment: "Store format type (supermarket, convenience, club, specialty)"
    - name: "country_code"
      expr: country_code
      comment: "Country where store is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province of store location"
    - name: "city"
      expr: city
      comment: "City of store location"
    - name: "trade_account"
      expr: trade_account_id
      comment: "Parent customer account identifier"
    - name: "opening_date"
      expr: opening_date
      comment: "Date the store opened"
  measures:
    - name: "total_stores"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Total number of retail stores"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total retail square footage across all stores"
    - name: "avg_square_footage_per_store"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per store"
    - name: "unique_parent_accounts"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique parent retail accounts"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sales_planogram_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail execution and planogram compliance metrics for in-store merchandising effectiveness"
  source: "`vibe_consumer_goods_v1`.`sales`.`planogram_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status (compliant, non-compliant, partial)"
    - name: "out_of_stock_flag"
      expr: out_of_stock_flag
      comment: "Indicator if SKU was out of stock during audit"
    - name: "audit_date"
      expr: audit_date
      comment: "Date of the planogram audit"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit for trend analysis"
    - name: "retail_store"
      expr: retail_store_id
      comment: "Store identifier"
    - name: "sku"
      expr: sku_id
      comment: "Product SKU audited"
  measures:
    - name: "total_audits"
      expr: COUNT(DISTINCT planogram_compliance_id)
      comment: "Total number of planogram audits conducted"
    - name: "unique_stores_audited"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of unique stores audited"
    - name: "unique_skus_audited"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs audited"
    - name: "total_out_of_stock_instances"
      expr: COUNT(DISTINCT CASE WHEN out_of_stock_flag = true THEN planogram_compliance_id END)
      comment: "Total number of out-of-stock instances detected"
$$;