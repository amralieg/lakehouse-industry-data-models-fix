-- Metric views for domain: order | Business: Grocery | Version: 1 | Generated on: 2026-05-04 18:32:13

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`order_catalog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for product assortment and digital pricing"
  source: "`grocery_ecm`.`order`.`catalog_item`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand identifier for the catalog item"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier where the item is sold"
    - name: "category_path"
      expr: category_path
      comment: "Hierarchical category path of the item"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone requirement for the item"
    - name: "digital_availability_status"
      expr: digital_availability_status
      comment: "Digital availability status (e.g., available, discontinued)"
    - name: "price_currency_code"
      expr: price_currency_code
      comment: "Currency code for the digital price"
  measures:
    - name: "total_items"
      expr: COUNT(1)
      comment: "Total number of catalog items"
    - name: "average_digital_price"
      expr: AVG(CAST(digital_display_price AS DOUBLE))
      comment: "Average digital display price across catalog items"
    - name: "average_customer_rating"
      expr: AVG(CAST(average_customer_rating AS DOUBLE))
      comment: "Average customer rating for catalog items"
    - name: "total_organic_items"
      expr: SUM(CASE WHEN organic_certified_flag THEN 1 ELSE 0 END)
      comment: "Count of catalog items that are organic certified"
    - name: "total_ebt_eligible_items"
      expr: SUM(CASE WHEN ebt_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of catalog items eligible for EBT"
    - name: "total_private_label_items"
      expr: SUM(CASE WHEN private_label_flag THEN 1 ELSE 0 END)
      comment: "Count of private label catalog items"
    - name: "total_age_restricted_items"
      expr: SUM(CASE WHEN age_restricted_flag THEN 1 ELSE 0 END)
      comment: "Count of age‑restricted catalog items"
    - name: "total_loyalty_points_multiplier"
      expr: SUM(CAST(loyalty_points_multiplier AS DOUBLE))
      comment: "Sum of loyalty points multipliers across catalog items"
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`order_delivery_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery efficiency and cost metrics for order fulfillment routes"
  source: "`grocery_ecm`.`order`.`order_delivery_route`"
  dimensions:
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier handling the route"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (e.g., third‑party, in‑house)"
    - name: "route_status"
      expr: route_status
      comment: "Current status of the delivery route"
    - name: "route_type"
      expr: route_type
      comment: "Classification of the route (e.g., standard, express)"
    - name: "service_level"
      expr: service_level
      comment: "Service level agreement for the route"
    - name: "temperature_zone"
      expr: temperature_zone
      comment: "Temperature zone required for the shipment"
    - name: "dispatch_date"
      expr: DATE_TRUNC('day', dispatch_date)
      comment: "Date the route was dispatched"
  measures:
    - name: "total_routes"
      expr: COUNT(1)
      comment: "Total number of delivery routes"
    - name: "total_estimated_fuel_cost"
      expr: SUM(CAST(estimated_fuel_cost AS DOUBLE))
      comment: "Sum of estimated fuel cost for all routes"
    - name: "total_estimated_labor_cost"
      expr: SUM(CAST(estimated_labor_cost AS DOUBLE))
      comment: "Sum of estimated labor cost for all routes"
    - name: "total_actual_miles"
      expr: SUM(CAST(total_actual_miles AS DOUBLE))
      comment: "Total actual miles driven across routes"
    - name: "total_planned_miles"
      expr: SUM(CAST(total_planned_miles AS DOUBLE))
      comment: "Total planned miles for all routes"
    - name: "total_weight_lbs"
      expr: SUM(CAST(total_weight_lbs AS DOUBLE))
      comment: "Total weight (lbs) of shipments across routes"
    - name: "total_volume_cubic_feet"
      expr: SUM(CAST(total_volume_cubic_feet AS DOUBLE))
      comment: "Total volume (cubic feet) of shipments across routes"
$$;