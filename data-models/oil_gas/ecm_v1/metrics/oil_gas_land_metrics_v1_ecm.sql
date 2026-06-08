-- Metric views for domain: land | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key lease financial and acreage metrics for strategic land portfolio management."
  source: "`oil_gas_ecm`.`land`.`lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (e.g., active, terminated)."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease agreement."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the lease is located."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the lease location."
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date the lease was acquired."
  measures:
    - name: "total_leases"
      expr: COUNT(1)
      comment: "Total number of lease records."
    - name: "total_gross_acres"
      expr: SUM(CAST(gross_acres AS DOUBLE))
      comment: "Sum of gross acres across leases."
    - name: "total_net_acres"
      expr: SUM(CAST(net_acres AS DOUBLE))
      comment: "Sum of net acres across leases."
    - name: "avg_gross_acres"
      expr: AVG(CAST(gross_acres AS DOUBLE))
      comment: "Average gross acres per lease."
    - name: "total_delay_rental_amount"
      expr: SUM(CAST(delay_rental_amount AS DOUBLE))
      comment: "Total delay rental amount associated with leases."
    - name: "total_bonus_consideration_amount"
      expr: SUM(CAST(bonus_consideration_amount AS DOUBLE))
      comment: "Total bonus consideration amount across leases."
    - name: "avg_working_interest_percent"
      expr: AVG(CAST(working_interest_percent AS DOUBLE))
      comment: "Average working interest percent across leases."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_royalty_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty disbursement KPIs that reflect cash outflows and owner exposure."
  source: "`oil_gas_ecm`.`land`.`royalty_disbursement`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date of royalty payment."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for royalty payment."
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Identifier of the petroleum product associated with the royalty."
    - name: "lease_id"
      expr: lease_id
      comment: "Lease identifier linked to the royalty."
    - name: "royalty_owner_id"
      expr: royalty_owner_id
      comment: "Royalty owner identifier."
  measures:
    - name: "total_royalty_payments"
      expr: COUNT(1)
      comment: "Total number of royalty disbursement records."
    - name: "total_gross_revenue_amount"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue amount associated with royalties."
    - name: "total_net_royalty_amount"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty amount paid."
    - name: "total_interest_paid_amount"
      expr: SUM(CAST(interest_paid_amount AS DOUBLE))
      comment: "Total interest paid amount on royalties."
    - name: "distinct_royalty_owners"
      expr: COUNT(DISTINCT royalty_owner_id)
      comment: "Count of distinct royalty owners receiving payments."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_division_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Division order metrics to monitor acreage allocation and financial thresholds."
  source: "`oil_gas_ecm`.`land`.`division_order`"
  dimensions:
    - name: "division_order_status"
      expr: division_order_status
      comment: "Current status of the division order."
    - name: "effective_date"
      expr: effective_date
      comment: "Effective date of the division order."
    - name: "statutory_payment_date"
      expr: statutory_payment_date
      comment: "Statutory payment date for the division order."
  measures:
    - name: "total_division_orders"
      expr: COUNT(1)
      comment: "Total number of division order records."
    - name: "total_gross_acres"
      expr: SUM(CAST(gross_acres AS DOUBLE))
      comment: "Sum of gross acres in division orders."
    - name: "total_net_acres"
      expr: SUM(CAST(net_acres AS DOUBLE))
      comment: "Sum of net acres in division orders."
    - name: "avg_percentage_interest"
      expr: AVG(CAST(percentage_interest AS DOUBLE))
      comment: "Average percentage interest across division orders."
    - name: "total_minimum_payment_threshold"
      expr: SUM(CAST(minimum_payment_threshold AS DOUBLE))
      comment: "Sum of minimum payment thresholds across division orders."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_curative_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and impact metrics for curative actions addressing land defects."
  source: "`oil_gas_ecm`.`land`.`curative_action`"
  dimensions:
    - name: "curative_status"
      expr: curative_status
      comment: "Status of the curative action."
    - name: "curative_type"
      expr: curative_type
      comment: "Type/category of curative action."
    - name: "approval_date"
      expr: approval_date
      comment: "Date the curative action was approved."
    - name: "lease_id"
      expr: lease_id
      comment: "Lease associated with the curative action."
    - name: "country_code"
      expr: country_code
      comment: "Country code where the curative action applies."
  measures:
    - name: "total_curative_actions"
      expr: COUNT(1)
      comment: "Total number of curative action records."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred for curative actions."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs for curative actions."
    - name: "total_affected_acreage"
      expr: SUM(CAST(affected_acreage AS DOUBLE))
      comment: "Total acreage affected by curative actions."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_delay_rental`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay rental financial metrics to monitor penalty exposure and rental cash flow."
  source: "`oil_gas_ecm`.`land`.`delay_rental`"
  dimensions:
    - name: "rental_status"
      expr: rental_status
      comment: "Current status of the rental payment."
    - name: "approval_date"
      expr: approval_date
      comment: "Date the delay rental was approved."
    - name: "lease_id"
      expr: lease_id
      comment: "Lease associated with the delay rental."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for rental payment."
  measures:
    - name: "total_delay_rentals"
      expr: COUNT(1)
      comment: "Total number of delay rental records."
    - name: "total_late_payment_penalty_amount"
      expr: SUM(CAST(late_payment_penalty_amount AS DOUBLE))
      comment: "Sum of late payment penalties."
    - name: "total_rental_amount"
      expr: SUM(CAST(rental_amount AS DOUBLE))
      comment: "Sum of rental amounts."
    - name: "total_rental_rate_per_acre"
      expr: SUM(CAST(rental_rate_per_acre AS DOUBLE))
      comment: "Sum of rental rate per acre."
$$;