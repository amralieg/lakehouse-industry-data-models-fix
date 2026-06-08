-- Metric views for domain: equipment | Business: Construction | Version: 1 | Generated on: 2026-05-07 07:27:43

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_asset_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of equipment assets"
  source: "`construction_ecm`.`equipment`.`asset_valuation`"
  dimensions:
    - name: "valuation_currency"
      expr: valuation_currency_code
      comment: "Currency of the valuation"
    - name: "valuation_month"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of valuation"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the asset"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of assets in the valuation period"
    - name: "total_current_book_value"
      expr: SUM(CAST(current_book_value AS DOUBLE))
      comment: "Aggregate current book value of assets"
    - name: "total_fair_market_value"
      expr: SUM(CAST(fair_market_value AS DOUBLE))
      comment: "Sum of fair market values for assets"
    - name: "average_depreciation_rate_percent"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate percent across assets"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment loss recorded"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_asset_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and usage of equipment"
  source: "`construction_ecm`.`equipment`.`hours`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Unique identifier of the equipment asset"
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project associated with the hours"
    - name: "shift_month"
      expr: DATE_TRUNC('month', shift_date)
      comment: "Month of the shift"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., day, night)"
  measures:
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Cumulative operating hours for assets"
    - name: "average_utilization_rate"
      expr: AVG(CAST(equipment_utilization_rate AS DOUBLE))
      comment: "Average utilization rate across assets"
    - name: "average_availability_rate"
      expr: AVG(CAST(equipment_availability_rate AS DOUBLE))
      comment: "Average availability rate across assets"
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed (liters) by assets"
    - name: "total_idle_hours"
      expr: SUM(CAST(idle_hours AS DOUBLE))
      comment: "Total idle hours recorded"
    - name: "total_equipment_cost"
      expr: SUM(CAST(total_equipment_cost AS DOUBLE))
      comment: "Aggregate equipment cost for the period"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_fuel_spending`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption cost and environmental impact"
  source: "`construction_ecm`.`equipment`.`fuel_transaction`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset linked to the fuel transaction"
    - name: "fuel_point_id"
      expr: fuel_point_id
      comment: "Fuel point (tank) identifier"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Month of the fuel transaction"
    - name: "currency"
      expr: currency_code
      comment: "Currency used for the transaction"
    - name: "is_emergency_refuel"
      expr: is_emergency_refuel
      comment: "Flag indicating emergency refuel"
  measures:
    - name: "total_fuel_spent"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total monetary spend on fuel"
    - name: "total_quantity_issued_liters"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total volume of fuel issued (liters)"
    - name: "average_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per unit of fuel"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions associated with fuel transactions"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_maintenance_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational impact of equipment maintenance"
  source: "`construction_ecm`.`equipment`.`maintenance_order`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset under maintenance"
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project associated with the maintenance"
    - name: "maintenance_priority"
      expr: priority
      comment: "Priority level of the maintenance order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the maintenance order"
  measures:
    - name: "total_maintenance_spend"
      expr: SUM(CAST(total_maintenance_cost AS DOUBLE))
      comment: "Total cost incurred for maintenance orders"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Aggregate labor cost across maintenance orders"
    - name: "total_parts_cost"
      expr: SUM(CAST(parts_cost AS DOUBLE))
      comment: "Aggregate parts cost across maintenance orders"
    - name: "total_external_services_cost"
      expr: SUM(CAST(external_services_cost AS DOUBLE))
      comment: "Cost of external services used in maintenance"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total equipment downtime hours due to maintenance"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_inspection_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and cost of equipment inspections"
  source: "`construction_ecm`.`equipment`.`inspection_record`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset inspected"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type/category of inspection"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month when the inspection occurred"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Number of inspection records captured"
    - name: "average_inspection_cost"
      expr: AVG(CAST(inspection_cost AS DOUBLE))
      comment: "Average cost per inspection"
    - name: "failed_inspections"
      expr: SUM(CASE WHEN inspection_outcome = 'Failed' THEN 1 ELSE 0 END)
      comment: "Count of inspections that resulted in a failure outcome"
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`equipment_mobilization_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and efficiency of equipment mobilization activities"
  source: "`construction_ecm`.`equipment`.`equipment_mobilization`"
  dimensions:
    - name: "asset_id"
      expr: asset_id
      comment: "Equipment asset being mobilized"
    - name: "project_id"
      expr: construction_project_id
      comment: "Construction project associated with mobilization"
    - name: "mobilization_status"
      expr: mobilization_status
      comment: "Current status of the mobilization"
    - name: "transport_method"
      expr: transport_method
      comment: "Method used for transport (e.g., truck, rail)"
    - name: "planned_dispatch_month"
      expr: DATE_TRUNC('month', planned_dispatch_date)
      comment: "Planned month of dispatch"
  measures:
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost AS DOUBLE))
      comment: "Total cost incurred for transporting equipment"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Aggregate distance covered during mobilizations"
    - name: "average_transit_hours"
      expr: AVG(CAST(actual_transit_hours AS DOUBLE))
      comment: "Average actual transit time in hours"
$$;