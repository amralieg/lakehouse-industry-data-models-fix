-- Metric views for domain: fuel | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fuel sales performance metrics"
  source: "`grocery_ecm`.`fuel`.`fuel_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the fuel transaction"
    - name: "store_location_id"
      expr: store_location_id
      comment: "Identifier of the store location where transaction occurred"
    - name: "fuel_grade_id"
      expr: grade_id
      comment: "Fuel grade identifier (foreign key to fuel.grade)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the transaction"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Number of fuel transactions recorded"
    - name: "total_gallons_dispensed"
      expr: SUM(CAST(gallons_dispensed AS DOUBLE))
      comment: "Total gallons of fuel dispensed"
    - name: "total_gross_sale_amount"
      expr: SUM(CAST(gross_sale_amount AS DOUBLE))
      comment: "Total gross sales amount for fuel transactions"
    - name: "total_net_amount_charged"
      expr: SUM(CAST(net_amount_charged AS DOUBLE))
      comment: "Total net amount charged after discounts and taxes"
    - name: "average_price_per_gallon"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per gallon across transactions"
    - name: "average_fuel_discount_cents_per_gallon"
      expr: AVG(CAST(fuel_discount_cents_per_gallon AS DOUBLE))
      comment: "Average discount applied per gallon"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fuel_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery efficiency and cost metrics for fuel logistics"
  source: "`grocery_ecm`.`fuel`.`delivery`"
  dimensions:
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('day', scheduled_delivery_date)
      comment: "Scheduled delivery date"
    - name: "center_id"
      expr: center_id
      comment: "Fuel center identifier"
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier identifier"
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Fuel grade delivered"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery"
  measures:
    - name: "total_deliveries"
      expr: COUNT(1)
      comment: "Number of fuel deliveries recorded"
    - name: "on_time_deliveries"
      expr: SUM(CASE WHEN actual_delivery_date <= scheduled_delivery_date THEN 1 ELSE 0 END)
      comment: "Count of deliveries that arrived on or before the scheduled date"
    - name: "total_gallons_delivered"
      expr: SUM(CAST(gross_gallons_delivered AS DOUBLE))
      comment: "Total gallons delivered (gross) across all deliveries"
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for fuel deliveries"
    - name: "average_cost_per_gallon"
      expr: AVG(CAST(cost_per_gallon AS DOUBLE))
      comment: "Average cost per gallon for deliveries"
    - name: "average_delivery_variance_gallons"
      expr: AVG(CAST(variance_gallons AS DOUBLE))
      comment: "Average variance in gallons between ordered and delivered"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fuel_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory accuracy and shrink metrics for fuel tanks"
  source: "`grocery_ecm`.`fuel`.`inventory_reconciliation`"
  dimensions:
    - name: "reconciliation_period_start_date"
      expr: DATE_TRUNC('day', reconciliation_period_start_date)
      comment: "Start date of the reconciliation period"
    - name: "tank_id"
      expr: tank_id
      comment: "Tank identifier"
  measures:
    - name: "total_reconciliations"
      expr: COUNT(1)
      comment: "Number of inventory reconciliation events"
    - name: "total_shrink_volume_gallons"
      expr: SUM(CAST(variance_volume_gallons AS DOUBLE))
      comment: "Total volume shrink (negative variance) across reconciliations"
    - name: "average_shrink_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average shrink percentage across reconciliations"
    - name: "total_dispensed_volume_gallons"
      expr: SUM(CAST(total_dispensed_volume_gallons AS DOUBLE))
      comment: "Total volume of fuel dispensed as recorded in reconciliations"
    - name: "total_delivered_volume_gallons"
      expr: SUM(CAST(total_deliveries_volume_gallons AS DOUBLE))
      comment: "Total volume of fuel delivered as recorded in reconciliations"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fuel_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and margin metrics for fuel grades"
  source: "`grocery_ecm`.`fuel`.`price`"
  dimensions:
    - name: "effective_date"
      expr: DATE_TRUNC('day', effective_timestamp)
      comment: "Effective date of the price"
    - name: "center_id"
      expr: center_id
      comment: "Fuel center identifier"
    - name: "grade_id"
      expr: grade_id
      comment: "Fuel grade identifier"
    - name: "price_zone_id"
      expr: price_zone_id
      comment: "Price zone identifier"
    - name: "promo_offer_id"
      expr: promo_offer_id
      comment: "Promotional offer identifier (if applicable)"
  measures:
    - name: "price_record_count"
      expr: COUNT(1)
      comment: "Number of price records captured"
    - name: "average_street_price"
      expr: AVG(CAST(street_price AS DOUBLE))
      comment: "Average street price per gallon"
    - name: "average_margin_per_gallon"
      expr: AVG(CAST(margin_per_gallon AS DOUBLE))
      comment: "Average margin per gallon"
    - name: "promotional_price_flag_count"
      expr: SUM(CASE WHEN promotional_price_flag THEN 1 ELSE 0 END)
      comment: "Count of price records flagged as promotional"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fuel_tank_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tank capacity and utilization metrics"
  source: "`grocery_ecm`.`fuel`.`tank`"
  dimensions:
    - name: "center_id"
      expr: center_id
      comment: "Fuel center identifier"
    - name: "fuel_grade"
      expr: fuel_grade
      comment: "Fuel grade stored in the tank"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the tank"
  measures:
    - name: "total_capacity_gallons"
      expr: SUM(CAST(capacity_gallons AS DOUBLE))
      comment: "Aggregate storage capacity across tanks"
    - name: "total_current_volume_gallons"
      expr: SUM(CAST(current_volume_gallons AS DOUBLE))
      comment: "Aggregate current fuel volume across tanks"
    - name: "average_utilization_percent"
      expr: AVG(current_volume_gallons / NULLIF(capacity_gallons, 0) * 100)
      comment: "Average utilization percentage of tank capacity"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`fuel_environmental_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and incident impact metrics"
  source: "`grocery_ecm`.`fuel`.`environmental_incident`"
  dimensions:
    - name: "incident_date"
      expr: DATE_TRUNC('day', incident_timestamp)
      comment: "Date of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Category of environmental incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, closed, etc.)"
    - name: "center_id"
      expr: center_id
      comment: "Fuel center where incident occurred"
  measures:
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Total number of environmental incidents reported"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Aggregate monetary penalties assessed"
    - name: "incidents_with_regulatory_penalty"
      expr: SUM(CASE WHEN regulatory_penalty_assessed THEN 1 ELSE 0 END)
      comment: "Count of incidents that resulted in regulatory penalties"
    - name: "average_remediation_cost"
      expr: AVG(CAST(total_remediation_cost AS DOUBLE))
      comment: "Average cost incurred for remediation"
$$;