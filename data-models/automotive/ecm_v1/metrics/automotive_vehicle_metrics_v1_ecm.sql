-- Metric views for domain: vehicle | Business: Automotive | Version: 1 | Generated on: 2026-05-07 00:10:14

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_build_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production build metrics for vehicles."
  source: "`automotive_ecm`.`vehicle`.`build_spec`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code."
    - name: "production_line"
      expr: production_line
      comment: "Production line identifier."
    - name: "build_month"
      expr: DATE_TRUNC('month', build_date)
      comment: "Build month."
    - name: "configuration_id"
      expr: configuration_id
      comment: "Configuration identifier."
  measures:
    - name: "total_builds"
      expr: COUNT(1)
      comment: "Total number of vehicle builds."
    - name: "avg_fuel_efficiency_mpg"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency (mpg) across builds."
    - name: "avg_vehicle_weight_kg"
      expr: AVG(CAST(vehicle_weight_kg AS DOUBLE))
      comment: "Average vehicle weight (kg)."
    - name: "special_order_count"
      expr: SUM(CASE WHEN special_order_flag THEN 1 ELSE 0 END)
      comment: "Count of special order builds."
    - name: "ota_updatable_count"
      expr: SUM(CASE WHEN ota_updatable_flag THEN 1 ELSE 0 END)
      comment: "Count of builds with OTA updatable capability."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_msrp_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing and incentive metrics for vehicle models."
  source: "`automotive_ecm`.`vehicle`.`msrp_pricing`"
  dimensions:
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country of market."
    - name: "market_region"
      expr: market_region
      comment: "Region of market."
    - name: "model_year"
      expr: model_year
      comment: "Model year."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (e.g., ICE, EV)."
    - name: "price_type"
      expr: price_type
      comment: "Price type (e.g., base, optional)."
    - name: "price_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Pricing effective month."
  measures:
    - name: "pricing_record_count"
      expr: COUNT(1)
      comment: "Number of pricing records."
    - name: "avg_price_amount"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average price amount."
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total price amount."
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge_amount AS DOUBLE))
      comment: "Average destination charge."
    - name: "total_ev_tax_credit"
      expr: SUM(CAST(ev_tax_credit_amount AS DOUBLE))
      comment: "Total EV tax credit amount."
    - name: "total_gas_guzzler_tax"
      expr: SUM(CAST(gas_guzzler_tax_amount AS DOUBLE))
      comment: "Total gas guzzler tax amount."
    - name: "avg_price_uplift"
      expr: AVG(CAST(price_uplift_amount AS DOUBLE))
      comment: "Average price uplift amount."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lifecycle event metrics for vehicles."
  source: "`automotive_ecm`.`vehicle`.`lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event."
    - name: "event_category"
      expr: event_category
      comment: "Event category."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of event occurrence."
    - name: "dealership_id"
      expr: dealership_id
      comment: "Dealership identifier."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of lifecycle events."
    - name: "critical_event_count"
      expr: SUM(CASE WHEN is_critical THEN 1 ELSE 0 END)
      comment: "Count of critical events."
    - name: "avg_odometer_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at event (km)."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_powertrain_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain variant performance metrics."
  source: "`automotive_ecm`.`vehicle`.`powertrain_variant`"
  dimensions:
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (e.g., EV, Hybrid, ICE)."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type."
    - name: "drive_type"
      expr: drive_type
      comment: "Drive configuration."
    - name: "model_year"
      expr: model_year
      comment: "Model year."
    - name: "variant_code"
      expr: variant_code
      comment: "Variant code."
  measures:
    - name: "variant_count"
      expr: COUNT(1)
      comment: "Number of powertrain variant records."
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity (kWh)."
    - name: "avg_combined_power_kw"
      expr: AVG(CAST(combined_system_power_kw AS DOUBLE))
      comment: "Average combined system power (kW)."
    - name: "avg_electric_motor_power_kw"
      expr: AVG(CAST(electric_motor_power_kw AS DOUBLE))
      comment: "Average electric motor power (kW)."
    - name: "avg_epa_fuel_economy_mpg"
      expr: AVG(CAST(epa_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy (mpg)."
    - name: "avg_wltp_fuel_economy_mpg"
      expr: AVG(CAST(wltp_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average WLTP combined fuel economy (mpg)."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_vin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle registration and warranty metrics."
  source: "`automotive_ecm`.`vehicle`.`vin_registry`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code."
    - name: "model_year_decoded"
      expr: model_year_decoded
      comment: "Decoded model year."
    - name: "vehicle_lifecycle_status"
      expr: vehicle_lifecycle_status
      comment: "Lifecycle status of vehicle."
    - name: "warranty_start_month"
      expr: DATE_TRUNC('month', warranty_start_date)
      comment: "Warranty start month."
    - name: "warranty_end_month"
      expr: DATE_TRUNC('month', warranty_end_date)
      comment: "Warranty end month."
  measures:
    - name: "total_vehicles"
      expr: COUNT(1)
      comment: "Total number of registered vehicles."
    - name: "recall_count"
      expr: SUM(CASE WHEN recall_flag THEN 1 ELSE 0 END)
      comment: "Count of vehicles with recall flag."
    - name: "avg_gvwr_kg"
      expr: AVG(CAST(gvwr_kg AS DOUBLE))
      comment: "Average gross vehicle weight rating (kg)."
    - name: "avg_curb_weight_kg"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight (kg)."
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Configuration pricing and feature metrics."
  source: "`automotive_ecm`.`vehicle`.`configuration`"
  dimensions:
    - name: "model_id"
      expr: model_id
      comment: "Model identifier."
    - name: "platform_id"
      expr: platform_id
      comment: "Platform identifier."
    - name: "body_style"
      expr: body_style
      comment: "Body style."
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain type."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type."
    - name: "market_region"
      expr: market_region
      comment: "Market region."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Market country code."
    - name: "production_start_month"
      expr: DATE_TRUNC('month', start_of_production_date)
      comment: "Start of production month."
  measures:
    - name: "configuration_count"
      expr: COUNT(1)
      comment: "Number of configurations."
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price of configuration."
    - name: "avg_msrp_amount"
      expr: AVG(CAST(msrp_amount AS DOUBLE))
      comment: "Average MSRP amount."
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge AS DOUBLE))
      comment: "Average destination charge."
    - name: "avg_optional_package_price"
      expr: AVG(total_price - msrp_amount - destination_charge)
      comment: "Average price contribution of optional packages."
$$;