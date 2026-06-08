-- Metric views for domain: mobility | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`mobility_connected_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vehicle inventory and health metrics"
  source: "`automotive_ecm`.`mobility`.`connected_vehicle`"
  dimensions:
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where the vehicle is registered"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Vehicle manufacturer"
    - name: "model_name"
      expr: model_name
      comment: "Vehicle model name"
    - name: "model_year"
      expr: model_year
      comment: "Model year of the vehicle"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Vehicle type (e.g., car, truck, SUV)"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (e.g., ICE, Hybrid, EV)"
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current warranty status"
    - name: "v2x_capability"
      expr: v2x_capability
      comment: "Whether V2X communication is enabled"
    - name: "ota_capability"
      expr: ota_capability
      comment: "Whether OTA updates are supported"
    - name: "connectivity_tier"
      expr: connectivity_tier
      comment: "Connectivity tier of the vehicle"
  measures:
    - name: "total_vehicle_count"
      expr: COUNT(1)
      comment: "Total number of vehicles in the fleet"
    - name: "active_vehicle_count"
      expr: COUNT(CASE WHEN activation_status = 'Active' THEN 1 END)
      comment: "Number of vehicles with active status"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`mobility_ev_charging_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for EV charging operations"
  source: "`automotive_ecm`.`mobility`.`ev_charging_session`"
  dimensions:
    - name: "charger_id"
      expr: charger_id
      comment: "Identifier of the EV charger used"
    - name: "station_city"
      expr: station_city
      comment: "City where the charging station is located"
    - name: "station_country"
      expr: station_country
      comment: "Country of the charging station"
    - name: "station_state"
      expr: station_state
      comment: "State/region of the charging station"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the session"
    - name: "session_status"
      expr: ev_charging_session_status
      comment: "Current status of the charging session"
    - name: "session_date"
      expr: DATE_TRUNC('day', start_timestamp)
      comment: "Date of the charging session"
  measures:
    - name: "total_charging_sessions"
      expr: COUNT(1)
      comment: "Total number of EV charging sessions"
    - name: "total_energy_delivered_kwh"
      expr: SUM(CAST(energy_delivered_kwh AS DOUBLE))
      comment: "Total energy delivered across all sessions (kWh)"
    - name: "average_session_duration_minutes"
      expr: AVG(CAST(session_duration_seconds AS DOUBLE)) / 60
      comment: "Average charging session duration in minutes"
    - name: "average_peak_power_kw"
      expr: AVG(CAST(peak_power_kw AS DOUBLE))
      comment: "Average peak power observed during sessions (kW)"
    - name: "total_charging_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for charging sessions"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`mobility_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and usage metrics for mobility services"
  source: "`automotive_ecm`.`mobility`.`service_subscription`"
  dimensions:
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g., monthly, annual)"
    - name: "subscription_status"
      expr: service_subscription_status
      comment: "Current status of the subscription"
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership associated with the subscription"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the subscription"
    - name: "subscription_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month when the subscription started"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of service subscriptions"
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN service_subscription_status = 'Active' THEN 1 END)
      comment: "Number of subscriptions currently active"
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Aggregate billing amount across all subscriptions"
    - name: "average_billing_amount"
      expr: AVG(CAST(billing_amount AS DOUBLE))
      comment: "Average billing amount per subscription"
    - name: "total_overage_amount"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage fees charged"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`mobility_predictive_maintenance_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Proactive maintenance health indicators"
  source: "`automotive_ecm`.`mobility`.`predictive_maintenance_alert`"
  dimensions:
    - name: "alert_category"
      expr: alert_category
      comment: "Category of the maintenance alert"
    - name: "severity"
      expr: severity
      comment: "Severity level of the alert"
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert"
    - name: "component"
      expr: component
      comment: "Vehicle component associated with the alert"
    - name: "alert_date"
      expr: DATE_TRUNC('day', generation_timestamp)
      comment: "Date the alert was generated"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total predictive maintenance alerts generated"
    - name: "high_severity_alerts"
      expr: COUNT(CASE WHEN severity = 'High' THEN 1 END)
      comment: "Number of high‑severity alerts"
    - name: "average_confidence_percentage"
      expr: AVG(CAST(confidence_percentage AS DOUBLE))
      comment: "Average confidence level of alerts"
    - name: "average_mileage_at_alert"
      expr: AVG(CAST(mileage_at_alert AS DOUBLE))
      comment: "Average vehicle mileage at time of alert"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`mobility_adas_feature_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monetization and adoption of ADAS features"
  source: "`automotive_ecm`.`mobility`.`adas_feature_entitlement`"
  dimensions:
    - name: "feature_name"
      expr: feature_name
      comment: "Name of the ADAS feature"
    - name: "feature_code"
      expr: feature_code
      comment: "Code identifier for the ADAS feature"
    - name: "subscription_plan"
      expr: subscription_plan
      comment: "Subscription plan linked to the entitlement"
    - name: "data_plan_type"
      expr: data_plan_type
      comment: "Type of data plan associated"
    - name: "is_trial"
      expr: is_trial
      comment: "Whether the entitlement is a trial"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month when the entitlement became active"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total ADAS feature entitlements issued"
    - name: "active_entitlements"
      expr: COUNT(CASE WHEN adas_feature_entitlement_status = 'Active' THEN 1 END)
      comment: "Number of currently active entitlements"
    - name: "total_entitlement_revenue"
      expr: SUM(CAST(entitlement_price AS DOUBLE))
      comment: "Total revenue from ADAS feature entitlements"
    - name: "average_entitlement_price"
      expr: AVG(CAST(entitlement_price AS DOUBLE))
      comment: "Average price per ADAS entitlement"
    - name: "trial_entitlement_count"
      expr: COUNT(CASE WHEN is_trial THEN 1 END)
      comment: "Number of trial (free) entitlements"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`mobility_trip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and environmental impact of vehicle trips"
  source: "`automotive_ecm`.`mobility`.`trip`"
  dimensions:
    - name: "trip_type"
      expr: trip_type
      comment: "Classification of the trip (e.g., business, personal)"
    - name: "trip_status"
      expr: trip_status
      comment: "Current status of the trip"
    - name: "road_type"
      expr: road_type
      comment: "Road type category for the trip"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during the trip"
    - name: "trip_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month when the trip started"
  measures:
    - name: "total_trips"
      expr: COUNT(1)
      comment: "Total number of trips recorded"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Cumulative distance traveled across all trips (km)"
    - name: "average_speed_kph"
      expr: AVG(CAST(average_speed_kph AS DOUBLE))
      comment: "Average speed across trips (km/h)"
    - name: "total_emission_co2_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions generated (kg)"
    - name: "total_fuel_consumed_liters"
      expr: SUM(CAST(fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed across trips (liters)"
    - name: "total_toll_amount_usd"
      expr: SUM(CAST(toll_amount_usd AS DOUBLE))
      comment: "Aggregate toll costs incurred (USD)"
    - name: "average_trip_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average trip duration in seconds"
$$;