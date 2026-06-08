-- Metric views for domain: sales | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core opportunity pipeline health and value metrics"
  source: "`telecommunication_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current stage of the opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type/category of the opportunity"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the opportunity originated"
    - name: "product_category"
      expr: product_category
      comment: "Product category associated with the opportunity"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Segment of the customer account"
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the opportunity record was created"
  measures:
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across opportunities"
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity"
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Number of opportunity records"
    - name: "won_opportunity_count"
      expr: SUM(CASE WHEN sales_stage = 'Closed Won' THEN 1 ELSE 0 END)
      comment: "Count of opportunities that reached Closed Won stage"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance and efficiency metrics"
  source: "`telecommunication_ecm`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., brand, product)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign"
    - name: "channel"
      expr: channel
      comment: "Primary channel used for the campaign"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the campaign started"
    - name: "end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the campaign ended"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to campaigns"
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend incurred by campaigns"
    - name: "average_roi_percent"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average ROI percent across campaigns"
    - name: "average_cpa"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost per acquisition across campaigns"
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Number of campaign records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue impact of signed sales contracts"
  source: "`telecommunication_ecm`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., new, renewal)"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the contract was sold"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the contract became effective"
  measures:
    - name: "total_tcv_amount"
      expr: SUM(CAST(tcv_amount AS DOUBLE))
      comment: "Total contract value (TCV) across all sales contracts"
    - name: "total_mrr_amount"
      expr: SUM(CAST(mrr_amount AS DOUBLE))
      comment: "Total monthly recurring revenue (MRR) from contracts"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of sales contract records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_commission_txn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission payout performance metrics"
  source: "`telecommunication_ecm`.`sales`.`commission_txn`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Employee receiving the commission"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel associated with the commission"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction generating commission"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of the commission transaction"
  measures:
    - name: "total_earned_commission"
      expr: SUM(CAST(earned_amount AS DOUBLE))
      comment: "Total earned commission amount"
    - name: "total_net_payable_commission"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable commission amount"
    - name: "average_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate applied"
    - name: "commission_txn_count"
      expr: COUNT(1)
      comment: "Number of commission transaction records"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial forecast revenue scenarios"
  source: "`telecommunication_ecm`.`sales`.`forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., quarterly, annual)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope covered by the forecast"
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month the forecast period starts"
  measures:
    - name: "total_commit_revenue"
      expr: SUM(CAST(commit_revenue_amount AS DOUBLE))
      comment: "Total committed revenue amount in forecasts"
    - name: "total_best_case_revenue"
      expr: SUM(CAST(best_case_revenue_amount AS DOUBLE))
      comment: "Total best‑case revenue amount in forecasts"
    - name: "total_worst_case_revenue"
      expr: SUM(CAST(worst_case_revenue_amount AS DOUBLE))
      comment: "Total worst‑case revenue amount in forecasts"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;