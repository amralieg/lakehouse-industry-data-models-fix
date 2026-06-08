-- Metric views for domain: land | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key lease financial and acreage performance metrics."
  source: "`oil_gas_ecm`.`land`.`lease`"
  dimensions:
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease"
    - name: "lease_type"
      expr: lease_type
      comment: "Type/category of lease"
    - name: "state_province"
      expr: state_province
      comment: "Geographic state/province"
    - name: "country_code"
      expr: country_code
      comment: "Country code of lease location"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year lease was acquired"
    - name: "operator_id"
      expr: operator_id
      comment: "Identifier of operating company"
  measures:
    - name: "lease_count"
      expr: COUNT(1)
      comment: "Number of lease records"
    - name: "total_delay_rental_amount"
      expr: SUM(CAST(delay_rental_amount AS DOUBLE))
      comment: "Total delay rental amount"
    - name: "average_working_interest_percent"
      expr: AVG(CAST(working_interest_percent AS DOUBLE))
      comment: "Average working interest percent"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_royalty_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Royalty disbursement financial and production metrics."
  source: "`oil_gas_ecm`.`land`.`royalty_disbursement`"
  dimensions:
    - name: "lease_id"
      expr: lease_id
      comment: "Lease associated with royalty"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Petroleum product identifier"
    - name: "production_month"
      expr: production_month
      comment: "Month of production"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of payment"
  measures:
    - name: "disbursement_count"
      expr: COUNT(1)
      comment: "Number of royalty disbursement records"
    - name: "total_net_royalty_amount"
      expr: SUM(CAST(net_royalty_amount AS DOUBLE))
      comment: "Total net royalty paid"
    - name: "total_gross_revenue_amount"
      expr: SUM(CAST(gross_revenue_amount AS DOUBLE))
      comment: "Total gross revenue associated with royalties"
    - name: "total_production_volume"
      expr: SUM(CAST(production_volume AS DOUBLE))
      comment: "Total production volume (units)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_division_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Division order acreage and interest metrics."
  source: "`oil_gas_ecm`.`land`.`division_order`"
  dimensions:
    - name: "division_order_status"
      expr: division_order_status
      comment: "Current status of division order"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the division order became effective"
    - name: "lease_id"
      expr: lease_id
      comment: "Associated lease identifier"
    - name: "royalty_owner_id"
      expr: royalty_owner_id
      comment: "Royalty owner identifier"
  measures:
    - name: "division_order_count"
      expr: COUNT(1)
      comment: "Number of division orders"
    - name: "total_gross_acres"
      expr: SUM(CAST(gross_acres AS DOUBLE))
      comment: "Total gross acres across division orders"
    - name: "total_net_acres"
      expr: SUM(CAST(net_acres AS DOUBLE))
      comment: "Total net acres"
    - name: "average_percentage_interest"
      expr: AVG(CAST(percentage_interest AS DOUBLE))
      comment: "Average percentage interest"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_mineral_right`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mineral right acquisition and reserve metrics."
  source: "`oil_gas_ecm`.`land`.`mineral_right`"
  dimensions:
    - name: "state_province"
      expr: state_province
      comment: "State or province of the mineral right"
    - name: "county"
      expr: county
      comment: "County of the mineral right"
    - name: "mineral_interest_type"
      expr: mineral_interest_type
      comment: "Type of mineral interest"
    - name: "acquisition_method"
      expr: acquisition_method
      comment: "Method used to acquire the mineral right"
    - name: "lease_id"
      expr: lease_id
      comment: "Associated lease identifier"
  measures:
    - name: "mineral_right_count"
      expr: COUNT(1)
      comment: "Number of mineral rights"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost"
    - name: "total_estimated_ultimate_recovery_boe"
      expr: SUM(CAST(estimated_ultimate_recovery_boe AS DOUBLE))
      comment: "Total estimated ultimate recovery (BOE)"
    - name: "total_net_mineral_acres"
      expr: SUM(CAST(net_mineral_acres AS DOUBLE))
      comment: "Total net mineral acres"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_pooling_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pooling unit production and interest metrics."
  source: "`oil_gas_ecm`.`land`.`pooling_unit`"
  dimensions:
    - name: "state_code"
      expr: state_code
      comment: "State code of pooling unit"
    - name: "county_name"
      expr: county_name
      comment: "County name"
    - name: "unit_type"
      expr: unit_type
      comment: "Type of unit"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year unit became effective"
    - name: "operator_id"
      expr: operator_id
      comment: "Operator identifier"
  measures:
    - name: "pooling_unit_count"
      expr: COUNT(1)
      comment: "Number of pooling units"
    - name: "total_gross_unit_acres"
      expr: SUM(CAST(gross_unit_acres AS DOUBLE))
      comment: "Total gross unit acres"
    - name: "total_net_unit_acres"
      expr: SUM(CAST(net_unit_acres AS DOUBLE))
      comment: "Total net unit acres"
    - name: "average_working_interest_percent"
      expr: AVG(CAST(working_interest_percent AS DOUBLE))
      comment: "Average working interest percent"
    - name: "average_net_revenue_interest_percent"
      expr: AVG(CAST(net_revenue_interest_percent AS DOUBLE))
      comment: "Average net revenue interest percent"
    - name: "average_royalty_burden_percent"
      expr: AVG(CAST(royalty_burden_percent AS DOUBLE))
      comment: "Average royalty burden percent"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`land_lease_expiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease expiry risk and financial exposure metrics."
  source: "`oil_gas_ecm`.`land`.`lease_expiry`"
  dimensions:
    - name: "expiry_event_type"
      expr: expiry_event_type
      comment: "Type of expiry event"
    - name: "primary_term_expiry_year"
      expr: YEAR(primary_term_expiry_date)
      comment: "Year of primary term expiry"
    - name: "lease_id"
      expr: lease_id
      comment: "Associated lease identifier"
  measures:
    - name: "lease_expiry_count"
      expr: COUNT(1)
      comment: "Number of lease expiry records"
    - name: "total_delay_rental_amount"
      expr: SUM(CAST(delay_rental_amount AS DOUBLE))
      comment: "Total delay rental amount at expiry"
    - name: "average_net_revenue_interest_at_risk"
      expr: AVG(CAST(net_revenue_interest_at_risk AS DOUBLE))
      comment: "Average net revenue interest at risk"
$$;