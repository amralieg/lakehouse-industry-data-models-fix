-- Metric views for domain: customer | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Support case performance metrics."
  source: "`automotive_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case."
    - name: "case_type"
      expr: case_type
      comment: "Type of the case."
    - name: "case_category"
      expr: case_category
      comment: "Category of the case."
    - name: "priority"
      expr: priority
      comment: "Priority level of the case."
    - name: "opened_date"
      expr: DATE_TRUNC('day', opened_timestamp)
      comment: "Date the case was opened."
    - name: "dealer_code"
      expr: dealer_code
      comment: "Dealer code associated with the case."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the case originated."
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of cases."
    - name: "resolved_cases"
      expr: SUM(CASE WHEN case_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Number of cases with status Closed."
    - name: "avg_resolution_time_days"
      expr: AVG(CAST(DATEDIFF(closed_timestamp, opened_timestamp) AS DOUBLE))
      comment: "Average resolution time in days for closed cases."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_cltv`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Lifetime Value (CLTV) metrics."
  source: "`automotive_ecm`.`customer`.`cltv_record`"
  dimensions:
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date of CLTV calculation."
    - name: "segment_at_calculation"
      expr: segment_at_calculation
      comment: "Customer segment at time of CLTV calculation."
    - name: "model_version"
      expr: model_version
      comment: "Version of the CLTV model used."
  measures:
    - name: "total_cltv_amount"
      expr: SUM(CAST(cltv_amount AS DOUBLE))
      comment: "Sum of CLTV amount across customers."
    - name: "avg_cltv_amount"
      expr: AVG(CAST(cltv_amount AS DOUBLE))
      comment: "Average CLTV amount."
    - name: "avg_churn_probability"
      expr: AVG(CAST(churn_probability AS DOUBLE))
      comment: "Average churn probability."
    - name: "avg_retention_probability"
      expr: AVG(CAST(retention_probability AS DOUBLE))
      comment: "Average retention probability."
    - name: "total_revenue_to_date"
      expr: SUM(CAST(revenue_to_date AS DOUBLE))
      comment: "Total revenue to date from CLTV records."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership and purchase metrics."
  source: "`automotive_ecm`.`customer`.`vehicle_ownership`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the vehicle was acquired."
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date of vehicle acquisition."
    - name: "vehicle_program_id"
      expr: vehicle_program_id
      comment: "Vehicle program identifier."
    - name: "dealer_code"
      expr: acquisition_dealer_code
      comment: "Dealer code associated with acquisition."
    - name: "is_primary_vehicle"
      expr: is_primary_vehicle
      comment: "Flag indicating if the vehicle is the primary vehicle for the owner."
  measures:
    - name: "total_vehicles"
      expr: COUNT(1)
      comment: "Total number of vehicle ownership records."
    - name: "total_purchase_value"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price of vehicles."
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per vehicle."
    - name: "primary_vehicle_count"
      expr: SUM(CASE WHEN is_primary_vehicle THEN 1 ELSE 0 END)
      comment: "Number of primary vehicles."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion effectiveness and financial impact metrics."
  source: "`automotive_ecm`.`customer`.`promotion`"
  dimensions:
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion (e.g., discount, rebate)."
    - name: "status"
      expr: status
      comment: "Current status of the promotion."
    - name: "channel"
      expr: channel
      comment: "Marketing channel used for the promotion."
    - name: "start_date"
      expr: start_date
      comment: "Promotion start date."
    - name: "end_date"
      expr: end_date
      comment: "Promotion end date."
  measures:
    - name: "total_promotions"
      expr: COUNT(1)
      comment: "Total number of promotion records."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to promotions."
    - name: "avg_cltv_impact"
      expr: AVG(CAST(cltv_impact_estimate AS DOUBLE))
      comment: "Average estimated CLTV impact per promotion."
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value offered."
$$;