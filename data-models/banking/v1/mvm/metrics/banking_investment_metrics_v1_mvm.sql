-- Metric views for domain: investment | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_deal_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for investment deals, used by senior leadership to monitor pipeline health and fee expectations."
  source: "`banking_ecm`.`investment`.`deal`"
  dimensions:
    - name: "deal_status"
      expr: deal_status
      comment: "Current status of the deal (e.g., Open, Closed, Lost)"
    - name: "deal_type"
      expr: deal_type
      comment: "Classification of the deal (e.g., M&A, Equity, Debt)"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code for the deal"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for monetary amounts"
    - name: "is_cross_border"
      expr: is_cross_border
      comment: "Flag indicating if the deal involves cross‑border parties"
    - name: "is_public_company"
      expr: is_public_company
      comment: "Flag indicating if the target is a public company"
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Whether regulatory approval is required for the deal"
  measures:
    - name: "total_deals"
      expr: COUNT(1)
      comment: "Count of deal records"
    - name: "total_expected_fee_amount"
      expr: SUM(CAST(expected_fee_amount AS DOUBLE))
      comment: "Sum of expected fee amount across deals"
    - name: "avg_pipeline_probability_pct"
      expr: AVG(CAST(pipeline_probability_pct AS DOUBLE))
      comment: "Average pipeline probability percentage"
    - name: "avg_deal_size"
      expr: AVG(CAST(size AS DOUBLE))
      comment: "Average deal size (notional)"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_investor_order_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI view for investor order activity, supporting trading desk performance monitoring."
  source: "`banking_ecm`.`investment`.`investor_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (e.g., Pending, Executed, Cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of order (e.g., Market, Limit, Stop)"
    - name: "order_channel"
      expr: order_channel
      comment: "Channel through which the order was placed"
    - name: "investor_type"
      expr: investor_type
      comment: "Investor classification (e.g., Institutional, Retail)"
    - name: "is_anchor_investor"
      expr: is_anchor_investor
      comment: "Flag indicating if the investor is an anchor investor"
    - name: "greenshoe_eligible"
      expr: greenshoe_eligible
      comment: "Whether the order is eligible for a greenshoe option"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order date for time‑based analysis"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Count of investor order records"
    - name: "total_order_size"
      expr: SUM(CAST(order_size AS DOUBLE))
      comment: "Sum of order sizes (notional) across all orders"
    - name: "avg_allocation_price"
      expr: AVG(CAST(allocation_price AS DOUBLE))
      comment: "Average price at which allocations were made"
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total allocated monetary amount"
    - name: "avg_price_limit"
      expr: AVG(CAST(price_limit AS DOUBLE))
      comment: "Average price limit set on orders"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation KPI view used by portfolio managers and risk committees to assess valuation ranges and cost of capital."
  source: "`banking_ecm`.`investment`.`investment_valuation`"
  dimensions:
    - name: "valuation_status"
      expr: valuation_status
      comment: "Status of the valuation (e.g., Draft, Final, Approved)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction being valued"
    - name: "target_company_name"
      expr: target_company_name
      comment: "Name of the target company"
    - name: "valuation_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of the valuation date"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for valuation amounts"
  measures:
    - name: "total_valuations"
      expr: COUNT(1)
      comment: "Count of valuation records"
    - name: "avg_enterprise_value_high"
      expr: AVG(CAST(enterprise_value_high AS DOUBLE))
      comment: "Average high range of enterprise value"
    - name: "avg_enterprise_value_low"
      expr: AVG(CAST(enterprise_value_low AS DOUBLE))
      comment: "Average low range of enterprise value"
    - name: "avg_ev_ebitda_multiple_high"
      expr: AVG(CAST(ev_ebitda_multiple_high AS DOUBLE))
      comment: "Average high EV/EBITDA multiple"
    - name: "avg_pe_multiple_high"
      expr: AVG(CAST(pe_multiple_high AS DOUBLE))
      comment: "Average high P/E multiple"
    - name: "avg_wacc"
      expr: AVG(CAST(wacc AS DOUBLE))
      comment: "Average weighted average cost of capital"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`investment_fee_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI view for fee arrangements, supporting revenue forecasting and fee‑structure analysis."
  source: "`banking_ecm`.`investment`.`fee_arrangement`"
  dimensions:
    - name: "arrangement_status"
      expr: arrangement_status
      comment: "Current status of the fee arrangement (e.g., Active, Inactive)"
    - name: "fee_type"
      expr: fee_type
      comment: "Classification of the fee (e.g., Advisory, Underwriting)"
    - name: "lob_code"
      expr: lob_code
      comment: "Line of business code associated with the fee arrangement"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for fee amounts"
  measures:
    - name: "total_fee_arrangements"
      expr: COUNT(1)
      comment: "Count of fee arrangement records"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount across arrangements"
    - name: "avg_fee_rate_bps"
      expr: AVG(CAST(fee_rate_bps AS DOUBLE))
      comment: "Average fee rate in basis points"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Sum of invoiced amounts"
    - name: "total_received_amount"
      expr: SUM(CAST(received_amount AS DOUBLE))
      comment: "Sum of amounts actually received"
    - name: "avg_retainer_amount"
      expr: AVG(CAST(retainer_amount AS DOUBLE))
      comment: "Average retainer amount"
$$;