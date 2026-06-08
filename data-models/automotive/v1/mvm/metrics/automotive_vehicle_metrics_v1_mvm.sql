-- Metric views for domain: vehicle | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle configuration KPIs tracking pricing, fuel economy, and market distribution across body styles, drivetrains, and regions"
  source: "`automotive_ecm`.`vehicle`.`configuration`"
  dimensions:
    - name: "body_style"
      expr: body_style
      comment: "Vehicle body style (sedan, SUV, truck, coupe, etc.)"
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration (AWD, FWD, RWD, 4WD)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (gasoline, diesel, electric, hybrid, plug-in hybrid)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (automatic, manual, CVT, dual-clutch)"
    - name: "market_region"
      expr: market_region
      comment: "Target market region for the configuration"
    - name: "market_country_code"
      expr: market_country_code
      comment: "ISO country code for target market"
    - name: "emissions_cert_status"
      expr: emissions_cert_status
      comment: "Emissions certification status"
    - name: "build_feasibility_status"
      expr: build_feasibility_status
      comment: "Manufacturing feasibility status for the configuration"
    - name: "record_status"
      expr: record_status
      comment: "Configuration record lifecycle status"
    - name: "production_year"
      expr: YEAR(start_of_production_date)
      comment: "Year production started for the configuration"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', start_of_production_date)
      comment: "Month production started for the configuration"
  measures:
    - name: "total_configurations"
      expr: COUNT(1)
      comment: "Total number of vehicle configurations"
    - name: "total_msrp_amount"
      expr: SUM(CAST(msrp_amount AS DOUBLE))
      comment: "Total MSRP across all configurations"
    - name: "avg_msrp_amount"
      expr: AVG(CAST(msrp_amount AS DOUBLE))
      comment: "Average MSRP per configuration"
    - name: "total_destination_charge"
      expr: SUM(CAST(destination_charge AS DOUBLE))
      comment: "Total destination charges across configurations"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy in MPG across configurations"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE))
      comment: "Average highway fuel economy in MPG across configurations"
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price including options and charges"
    - name: "distinct_body_styles"
      expr: COUNT(DISTINCT body_style)
      comment: "Number of unique body styles offered"
    - name: "distinct_fuel_types"
      expr: COUNT(DISTINCT fuel_type)
      comment: "Number of unique fuel types offered"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_build_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle build specification KPIs tracking production quality, emissions compliance, and warranty coverage by plant and production line"
  source: "`automotive_ecm`.`vehicle`.`build_spec`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where vehicle was built"
    - name: "production_line"
      expr: production_line
      comment: "Production line identifier within the plant"
    - name: "build_spec_status"
      expr: build_spec_status
      comment: "Build specification status (active, completed, cancelled)"
    - name: "emissions_rating"
      expr: emissions_rating
      comment: "Emissions rating classification"
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status for the build"
    - name: "ncap_rating"
      expr: ncap_rating
      comment: "NCAP safety rating"
    - name: "ota_updatable_flag"
      expr: ota_updatable_flag
      comment: "Whether vehicle supports over-the-air software updates"
    - name: "v2x_enabled_flag"
      expr: v2x_enabled_flag
      comment: "Whether vehicle has vehicle-to-everything communication enabled"
    - name: "fleet_spec_flag"
      expr: fleet_spec_flag
      comment: "Whether build is for fleet/commercial use"
    - name: "special_order_flag"
      expr: special_order_flag
      comment: "Whether build is a special customer order"
    - name: "build_year"
      expr: YEAR(build_date)
      comment: "Year the vehicle was built"
    - name: "build_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month the vehicle was built"
  measures:
    - name: "total_vehicles_built"
      expr: COUNT(1)
      comment: "Total number of vehicles built"
    - name: "avg_fuel_efficiency"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency in MPG across built vehicles"
    - name: "avg_vehicle_weight"
      expr: AVG(CAST(vehicle_weight_kg AS DOUBLE))
      comment: "Average vehicle weight in kilograms"
    - name: "ota_capable_vehicles"
      expr: SUM(CASE WHEN ota_updatable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicles with OTA update capability"
    - name: "v2x_enabled_vehicles"
      expr: SUM(CASE WHEN v2x_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicles with V2X communication enabled"
    - name: "fleet_vehicles"
      expr: SUM(CASE WHEN fleet_spec_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicles built for fleet use"
    - name: "special_order_vehicles"
      expr: SUM(CASE WHEN special_order_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of special order vehicles"
    - name: "distinct_plants"
      expr: COUNT(DISTINCT plant_code)
      comment: "Number of distinct manufacturing plants"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle model portfolio KPIs tracking pricing strategy, fuel economy performance, emissions compliance, and market positioning across segments and powertrains"
  source: "`automotive_ecm`.`vehicle`.`model`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Vehicle brand name"
    - name: "model_name"
      expr: model_name
      comment: "Vehicle model name"
    - name: "body_style"
      expr: body_style
      comment: "Body style (sedan, SUV, truck, coupe, etc.)"
    - name: "segment"
      expr: segment
      comment: "Market segment (luxury, economy, mid-size, etc.)"
    - name: "vehicle_class"
      expr: vehicle_class
      comment: "Vehicle classification"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, hybrid, electric, PHEV)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (gasoline, diesel, electric, hydrogen)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type"
    - name: "drive_configuration"
      expr: drive_configuration
      comment: "Drive configuration (AWD, FWD, RWD, 4WD)"
    - name: "model_status"
      expr: model_status
      comment: "Model lifecycle status (active, discontinued, planned)"
    - name: "primary_market"
      expr: primary_market
      comment: "Primary target market for the model"
    - name: "emissions_standard"
      expr: emissions_standard
      comment: "Emissions standard compliance (Euro 6, EPA Tier 3, etc.)"
    - name: "ncap_safety_rating"
      expr: ncap_safety_rating
      comment: "NCAP safety rating"
    - name: "launch_year"
      expr: launch_model_year
      comment: "Model year when model was launched"
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of vehicle models"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp_usd AS DOUBLE))
      comment: "Average manufacturer suggested retail price in USD"
    - name: "total_msrp"
      expr: SUM(CAST(msrp_usd AS DOUBLE))
      comment: "Total MSRP across all models"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy in MPG"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE))
      comment: "Average highway fuel economy in MPG"
    - name: "avg_co2_emissions"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions in grams per kilometer"
    - name: "avg_electric_range"
      expr: AVG(CAST(electric_range_miles AS DOUBLE))
      comment: "Average electric range in miles for electric/hybrid models"
    - name: "avg_battery_capacity"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kWh for electric/hybrid models"
    - name: "avg_curb_weight"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight in kilograms"
    - name: "avg_cargo_capacity"
      expr: AVG(CAST(cargo_capacity_liters AS DOUBLE))
      comment: "Average cargo capacity in liters"
    - name: "distinct_brands"
      expr: COUNT(DISTINCT brand_name)
      comment: "Number of distinct brands in portfolio"
    - name: "distinct_segments"
      expr: COUNT(DISTINCT segment)
      comment: "Number of distinct market segments covered"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_vin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VIN registry KPIs tracking production volume, market distribution, emissions compliance, and recall exposure across destination markets and lifecycle stages"
  source: "`automotive_ecm`.`vehicle`.`vin_registry`"
  dimensions:
    - name: "destination_market"
      expr: destination_market
      comment: "Destination market for the vehicle"
    - name: "homologation_market"
      expr: homologation_market
      comment: "Market where vehicle is homologated"
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code"
    - name: "model_year_decoded"
      expr: model_year_decoded
      comment: "Decoded model year from VIN"
    - name: "vehicle_lifecycle_status"
      expr: vehicle_lifecycle_status
      comment: "Current lifecycle status of the vehicle"
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emissions standard compliance"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating"
    - name: "recall_flag"
      expr: recall_flag
      comment: "Whether vehicle is subject to recall"
    - name: "telematics_enabled_flag"
      expr: telematics_enabled_flag
      comment: "Whether vehicle has telematics enabled"
    - name: "wmi"
      expr: wmi
      comment: "World Manufacturer Identifier (first 3 characters of VIN)"
    - name: "build_year"
      expr: YEAR(build_date)
      comment: "Year the vehicle was built"
    - name: "build_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month the vehicle was built"
  measures:
    - name: "total_vins"
      expr: COUNT(1)
      comment: "Total number of VINs registered"
    - name: "distinct_vins"
      expr: COUNT(DISTINCT vin)
      comment: "Count of unique VINs"
    - name: "avg_battery_capacity"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kWh"
    - name: "avg_curb_weight"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight in kilograms"
    - name: "avg_gvwr"
      expr: AVG(CAST(gvwr_kg AS DOUBLE))
      comment: "Average gross vehicle weight rating in kilograms"
    - name: "avg_fuel_tank_capacity"
      expr: AVG(CAST(fuel_tank_capacity_liters AS DOUBLE))
      comment: "Average fuel tank capacity in liters"
    - name: "avg_epa_combined_mpg"
      expr: AVG(CAST(epa_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy in MPG"
    - name: "avg_wltp_consumption"
      expr: AVG(CAST(wltp_combined_consumption AS DOUBLE))
      comment: "Average WLTP combined fuel consumption"
    - name: "recall_vehicles"
      expr: SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicles subject to recall"
    - name: "telematics_enabled_vehicles"
      expr: SUM(CASE WHEN telematics_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vehicles with telematics enabled"
    - name: "distinct_destination_markets"
      expr: COUNT(DISTINCT destination_market)
      comment: "Number of distinct destination markets"
    - name: "distinct_plants"
      expr: COUNT(DISTINCT plant_code)
      comment: "Number of distinct manufacturing plants"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle lifecycle event KPIs tracking event volume, criticality, and odometer progression across event types, categories, and geographic regions"
  source: "`automotive_ecm`.`vehicle`.`lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (sale, service, recall, accident, etc.)"
    - name: "event_category"
      expr: event_category
      comment: "Category of lifecycle event"
    - name: "event_subtype"
      expr: event_subtype
      comment: "Subtype of lifecycle event"
    - name: "event_status"
      expr: event_status
      comment: "Status of the event (open, closed, pending, etc.)"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the event is flagged as critical"
    - name: "event_location_country"
      expr: event_location_country
      comment: "Country where event occurred"
    - name: "event_location_state"
      expr: event_location_state
      comment: "State/province where event occurred"
    - name: "event_location_city"
      expr: event_location_city
      comment: "City where event occurred"
    - name: "event_source_system"
      expr: event_source_system
      comment: "Source system that generated the event"
    - name: "triggering_system"
      expr: triggering_system
      comment: "System that triggered the event"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the event occurred"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of lifecycle events"
    - name: "critical_events"
      expr: SUM(CASE WHEN is_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of critical lifecycle events"
    - name: "avg_odometer_reading"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading in kilometers at event time"
    - name: "max_odometer_reading"
      expr: MAX(CAST(odometer_reading_km AS DOUBLE))
      comment: "Maximum odometer reading in kilometers"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles with lifecycle events"
    - name: "distinct_event_types"
      expr: COUNT(DISTINCT event_type)
      comment: "Number of distinct event types"
    - name: "distinct_locations"
      expr: COUNT(DISTINCT event_location_country)
      comment: "Number of distinct countries where events occurred"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle platform KPIs tracking development investment, production lifecycle, and technology capability across platform families and architectures"
  source: "`automotive_ecm`.`vehicle`.`platform`"
  dimensions:
    - name: "platform_name"
      expr: platform_name
      comment: "Name of the vehicle platform"
    - name: "platform_code"
      expr: platform_code
      comment: "Platform code identifier"
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform (modular, dedicated, flexible, etc.)"
    - name: "platform_status"
      expr: platform_status
      comment: "Platform lifecycle status (active, development, retired)"
    - name: "family"
      expr: family
      comment: "Platform family grouping"
    - name: "generation"
      expr: generation
      comment: "Platform generation"
    - name: "architecture"
      expr: architecture
      comment: "Platform architecture type"
    - name: "emissions_class"
      expr: emissions_class
      comment: "Emissions class supported by platform"
    - name: "ota_capability"
      expr: ota_capability
      comment: "Whether platform supports over-the-air updates"
    - name: "adaptive_cruise_control"
      expr: adaptive_cruise_control
      comment: "Whether platform supports adaptive cruise control"
    - name: "owner_business_unit"
      expr: owner_business_unit
      comment: "Business unit that owns the platform"
    - name: "release_year"
      expr: release_year
      comment: "Year the platform was released"
  measures:
    - name: "total_platforms"
      expr: COUNT(1)
      comment: "Total number of vehicle platforms"
    - name: "total_development_cost"
      expr: SUM(CAST(development_cost_usd AS DOUBLE))
      comment: "Total platform development cost in USD"
    - name: "avg_development_cost"
      expr: AVG(CAST(development_cost_usd AS DOUBLE))
      comment: "Average platform development cost in USD"
    - name: "ota_capable_platforms"
      expr: SUM(CASE WHEN ota_capability = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms with OTA capability"
    - name: "acc_capable_platforms"
      expr: SUM(CASE WHEN adaptive_cruise_control = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms with adaptive cruise control"
    - name: "distinct_families"
      expr: COUNT(DISTINCT family)
      comment: "Number of distinct platform families"
    - name: "distinct_architectures"
      expr: COUNT(DISTINCT architecture)
      comment: "Number of distinct platform architectures"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_powertrain_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain variant KPIs tracking fuel economy performance, emissions output, electric range capability, and power output across powertrain types and drive configurations"
  source: "`automotive_ecm`.`vehicle`.`powertrain_variant`"
  dimensions:
    - name: "variant_name"
      expr: variant_name
      comment: "Powertrain variant name"
    - name: "variant_code"
      expr: variant_code
      comment: "Powertrain variant code"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (ICE, hybrid, electric, PHEV, FCEV)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (gasoline, diesel, electric, hydrogen)"
    - name: "drive_type"
      expr: drive_type
      comment: "Drive type (AWD, FWD, RWD, 4WD)"
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type"
    - name: "cylinder_count"
      expr: cylinder_count
      comment: "Number of cylinders in engine"
    - name: "charging_standard"
      expr: charging_standard
      comment: "Charging standard for electric vehicles (CCS, CHAdeMO, Tesla, etc.)"
    - name: "powertrain_variant_status"
      expr: powertrain_variant_status
      comment: "Variant lifecycle status"
    - name: "model_year"
      expr: model_year
      comment: "Model year for the powertrain variant"
  measures:
    - name: "total_variants"
      expr: COUNT(1)
      comment: "Total number of powertrain variants"
    - name: "avg_battery_capacity"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kWh for electric/hybrid variants"
    - name: "avg_combined_system_power"
      expr: AVG(CAST(combined_system_power_kw AS DOUBLE))
      comment: "Average combined system power in kilowatts"
    - name: "avg_electric_motor_power"
      expr: AVG(CAST(electric_motor_power_kw AS DOUBLE))
      comment: "Average electric motor power in kilowatts"
    - name: "avg_fuel_economy_city"
      expr: AVG(CAST(fuel_economy_city_mpg AS DOUBLE))
      comment: "Average city fuel economy in MPG"
    - name: "avg_fuel_economy_highway"
      expr: AVG(CAST(fuel_economy_highway_mpg AS DOUBLE))
      comment: "Average highway fuel economy in MPG"
    - name: "avg_fuel_economy_combined"
      expr: AVG(CAST(fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average combined fuel economy in MPG"
    - name: "avg_epa_fuel_economy_combined"
      expr: AVG(CAST(epa_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy in MPG"
    - name: "avg_wltp_fuel_economy_combined"
      expr: AVG(CAST(wltp_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average WLTP combined fuel economy in MPG"
    - name: "distinct_powertrain_types"
      expr: COUNT(DISTINCT powertrain_type)
      comment: "Number of distinct powertrain types"
    - name: "distinct_fuel_types"
      expr: COUNT(DISTINCT fuel_type)
      comment: "Number of distinct fuel types"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_msrp_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MSRP pricing KPIs tracking price positioning, tax incentives, destination charges, and price uplifts across markets, powertrains, and option packages"
  source: "`automotive_ecm`.`vehicle`.`msrp_pricing`"
  dimensions:
    - name: "market_region"
      expr: market_region
      comment: "Market region for pricing"
    - name: "market_country_code"
      expr: market_country_code
      comment: "ISO country code for market"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for pricing"
    - name: "price_type"
      expr: price_type
      comment: "Type of price (base, option, package, total)"
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type"
    - name: "msrp_pricing_status"
      expr: msrp_pricing_status
      comment: "Pricing record status"
    - name: "ev_tax_credit_eligibility_flag"
      expr: ev_tax_credit_eligibility_flag
      comment: "Whether eligible for EV tax credit"
    - name: "gas_guzzler_tax_flag"
      expr: gas_guzzler_tax_flag
      comment: "Whether subject to gas guzzler tax"
    - name: "destination_charge_flag"
      expr: destination_charge_flag
      comment: "Whether destination charge applies"
    - name: "price_uplift_reason"
      expr: price_uplift_reason
      comment: "Reason for price uplift"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year pricing became effective"
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of pricing records"
    - name: "avg_price_amount"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average price amount"
    - name: "total_price_amount"
      expr: SUM(CAST(price_amount AS DOUBLE))
      comment: "Total price amount across all records"
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge_amount AS DOUBLE))
      comment: "Average destination charge amount"
    - name: "total_destination_charge"
      expr: SUM(CAST(destination_charge_amount AS DOUBLE))
      comment: "Total destination charges"
    - name: "avg_ev_tax_credit"
      expr: AVG(CAST(ev_tax_credit_amount AS DOUBLE))
      comment: "Average EV tax credit amount"
    - name: "total_ev_tax_credit"
      expr: SUM(CAST(ev_tax_credit_amount AS DOUBLE))
      comment: "Total EV tax credit amounts"
    - name: "avg_gas_guzzler_tax"
      expr: AVG(CAST(gas_guzzler_tax_amount AS DOUBLE))
      comment: "Average gas guzzler tax amount"
    - name: "total_gas_guzzler_tax"
      expr: SUM(CAST(gas_guzzler_tax_amount AS DOUBLE))
      comment: "Total gas guzzler tax amounts"
    - name: "avg_price_uplift"
      expr: AVG(CAST(price_uplift_amount AS DOUBLE))
      comment: "Average price uplift amount"
    - name: "ev_tax_credit_eligible_count"
      expr: SUM(CASE WHEN ev_tax_credit_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of pricing records eligible for EV tax credit"
    - name: "distinct_markets"
      expr: COUNT(DISTINCT market_country_code)
      comment: "Number of distinct markets with pricing"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`vehicle_homologation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Homologation KPIs tracking regulatory approval status, certification lifecycle, and compliance coverage across jurisdictions and regulatory frameworks"
  source: "`automotive_ecm`.`vehicle`.`homologation`"
  dimensions:
    - name: "homologation_category"
      expr: homologation_category
      comment: "Category of homologation (type approval, emissions, safety, etc.)"
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval granted"
    - name: "authority_name"
      expr: authority_name
      comment: "Name of regulatory authority"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework (UNECE, EPA, CARB, etc.)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of homologation"
    - name: "is_active"
      expr: is_active
      comment: "Whether homologation is currently active"
    - name: "is_ota_updatable"
      expr: is_ota_updatable
      comment: "Whether homologation supports OTA updates"
    - name: "homologation_scope"
      expr: homologation_scope
      comment: "Scope of homologation"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year approval was granted"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year homologation expires"
  measures:
    - name: "total_homologations"
      expr: COUNT(1)
      comment: "Total number of homologation records"
    - name: "active_homologations"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of active homologations"
    - name: "ota_updatable_homologations"
      expr: SUM(CASE WHEN is_ota_updatable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of homologations supporting OTA updates"
    - name: "distinct_authorities"
      expr: COUNT(DISTINCT authority_name)
      comment: "Number of distinct regulatory authorities"
    - name: "distinct_frameworks"
      expr: COUNT(DISTINCT regulatory_framework)
      comment: "Number of distinct regulatory frameworks"
    - name: "distinct_jurisdictions"
      expr: COUNT(DISTINCT jurisdiction_id)
      comment: "Number of distinct jurisdictions with homologations"
    - name: "distinct_vehicles"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles with homologations"
$$;