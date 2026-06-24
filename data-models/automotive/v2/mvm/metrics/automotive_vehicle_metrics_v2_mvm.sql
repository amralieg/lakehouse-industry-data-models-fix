-- Metric views for domain: vehicle | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_vin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the VIN Registry — the authoritative record of every manufactured vehicle. Covers production volume, warranty exposure, telematics adoption, recall risk, and emissions compliance across the active fleet."
  source: "`vibe_automotive_v1`.`vehicle`.`vin_registry`"
  dimensions:
    - name: "vehicle_lifecycle_status"
      expr: vehicle_lifecycle_status
      comment: "Current lifecycle stage of the vehicle (e.g. In Production, In Service, End-of-Life). Primary segmentation for fleet health analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant where the vehicle was produced. Used to benchmark plant-level output and quality."
    - name: "model_year_decoded"
      expr: model_year_decoded
      comment: "Decoded model year from the VIN. Enables year-over-year fleet composition and aging analysis."
    - name: "destination_market"
      expr: destination_market
      comment: "Target market or region for the vehicle. Supports regional fleet distribution and regulatory compliance reporting."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emissions standard the vehicle is certified to (e.g. Euro 6, EPA Tier 3). Critical for regulatory compliance tracking."
    - name: "obd_protocol"
      expr: obd_protocol
      comment: "On-board diagnostics protocol version. Used to assess diagnostic readiness and service capability across the fleet."
    - name: "build_date_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month of vehicle build date. Enables monthly production trend analysis."
    - name: "warranty_end_date_year"
      expr: YEAR(warranty_end_date)
      comment: "Year the vehicle warranty expires. Used to forecast warranty cost exposure and CPO eligibility windows."
  measures:
    - name: "total_vehicles_produced"
      expr: COUNT(1)
      comment: "Total number of VINs registered — represents total vehicles manufactured. Core production volume KPI for executive reporting."
    - name: "telematics_enabled_vehicles"
      expr: COUNT(CASE WHEN telematics_enabled_flag = TRUE THEN 1 END)
      comment: "Count of vehicles with telematics enabled. Tracks connected-vehicle adoption rate, a key digital revenue and service KPI."
    - name: "telematics_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telematics_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the fleet with telematics enabled. Directly informs connected-services revenue potential and OTA update reach."
    - name: "recall_flagged_vehicles"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of VINs flagged for an active recall. Critical safety and regulatory compliance KPI monitored by executives and regulators."
    - name: "recall_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the fleet under active recall. Drives urgency of recall remediation campaigns and regulatory reporting."
    - name: "extended_warranty_active_vehicles"
      expr: COUNT(CASE WHEN extended_warranty_active_flag = TRUE THEN 1 END)
      comment: "Count of vehicles with an active extended warranty. Measures extended warranty penetration, a key aftersales revenue stream."
    - name: "connected_diagnostics_enabled_vehicles"
      expr: COUNT(CASE WHEN connected_diagnostics_enabled_flag = TRUE THEN 1 END)
      comment: "Count of vehicles with connected diagnostics enabled. Supports proactive service and predictive maintenance program sizing."
    - name: "self_service_portal_registered_vehicles"
      expr: COUNT(CASE WHEN self_service_portal_registered_flag = TRUE THEN 1 END)
      comment: "Count of vehicles registered on the self-service portal. Measures digital engagement and reduces dealer service cost."
    - name: "avg_epa_combined_mpg"
      expr: ROUND(AVG(CAST(epa_combined_mpg AS DOUBLE)), 2)
      comment: "Average EPA combined fuel economy across the fleet. Tracks fleet-wide emissions and efficiency compliance with regulatory targets."
    - name: "avg_battery_capacity_kwh"
      expr: ROUND(AVG(CAST(battery_capacity_kwh AS DOUBLE)), 2)
      comment: "Average battery capacity (kWh) across the fleet. Monitors EV fleet capability and informs charging infrastructure planning."
    - name: "avg_curb_weight_kg"
      expr: ROUND(AVG(CAST(curb_weight_kg AS DOUBLE)), 2)
      comment: "Average curb weight of vehicles in the fleet. Used in emissions modelling and regulatory weight-class compliance."
    - name: "total_fuel_tank_capacity_liters"
      expr: SUM(CAST(fuel_tank_capacity_liters AS DOUBLE))
      comment: "Total fuel tank capacity across the fleet in liters. Supports fuel supply chain and logistics planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_build_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production build quality and compliance KPIs derived from build specifications. Covers CPO eligibility, OTA readiness, regulatory approval, warranty coverage, and vehicle weight/efficiency at the build level."
  source: "`vibe_automotive_v1`.`vehicle`.`build_spec`"
  dimensions:
    - name: "build_spec_status"
      expr: build_spec_status
      comment: "Current status of the build specification (e.g. Active, Superseded, Cancelled). Primary filter for valid production builds."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code associated with the build. Enables plant-level quality and compliance benchmarking."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the build (e.g. Approved, Pending, Rejected). Critical for market launch readiness."
    - name: "emissions_rating"
      expr: emissions_rating
      comment: "Emissions rating assigned to the build. Used for regulatory compliance and green fleet reporting."
    - name: "ncap_rating"
      expr: ncap_rating
      comment: "NCAP safety rating of the build. Key safety KPI for consumer and regulatory reporting."
    - name: "build_date_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month of the build date. Enables monthly production volume and quality trend analysis."
    - name: "software_version"
      expr: software_version
      comment: "Software version installed at build time. Tracks software currency across the production fleet."
  measures:
    - name: "total_builds"
      expr: COUNT(1)
      comment: "Total number of build specifications. Baseline production volume measure for manufacturing throughput reporting."
    - name: "cpo_eligible_builds"
      expr: COUNT(CASE WHEN cpo_eligible_flag = TRUE THEN 1 END)
      comment: "Count of builds eligible for Certified Pre-Owned programs. Directly drives CPO inventory and aftersales revenue planning."
    - name: "cpo_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cpo_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds eligible for CPO. Measures CPO program reach and aftersales revenue potential."
    - name: "ota_updatable_builds"
      expr: COUNT(CASE WHEN ota_updatable_flag = TRUE THEN 1 END)
      comment: "Count of builds capable of receiving OTA software updates. Tracks digital service delivery reach and reduces physical recall costs."
    - name: "ota_readiness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_updatable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of builds OTA-updatable. Strategic KPI for software-defined vehicle transformation progress."
    - name: "v2x_enabled_builds"
      expr: COUNT(CASE WHEN v2x_enabled_flag = TRUE THEN 1 END)
      comment: "Count of builds with Vehicle-to-Everything (V2X) connectivity. Tracks advanced connectivity adoption for smart mobility strategy."
    - name: "fleet_spec_builds"
      expr: COUNT(CASE WHEN fleet_spec_flag = TRUE THEN 1 END)
      comment: "Count of builds produced to fleet specifications. Supports fleet sales channel volume and revenue reporting."
    - name: "special_order_builds"
      expr: COUNT(CASE WHEN special_order_flag = TRUE THEN 1 END)
      comment: "Count of special-order builds. Measures bespoke production volume and its impact on manufacturing scheduling."
    - name: "avg_vehicle_weight_kg"
      expr: ROUND(AVG(CAST(vehicle_weight_kg AS DOUBLE)), 2)
      comment: "Average vehicle weight (kg) across builds. Used in emissions compliance modelling and regulatory weight-class reporting."
    - name: "avg_fuel_efficiency_mpg"
      expr: ROUND(AVG(CAST(fuel_efficiency_mpg AS DOUBLE)), 2)
      comment: "Average fuel efficiency (MPG) across builds. Core fleet efficiency KPI for regulatory and sustainability reporting."
    - name: "regulatory_approved_builds"
      expr: COUNT(CASE WHEN regulatory_approval_status = 'Approved' THEN 1 END)
      comment: "Count of builds with confirmed regulatory approval. Measures market launch readiness and compliance throughput."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle configuration portfolio KPIs covering pricing, market coverage, EV/fuel mix, production feasibility, and subscription eligibility. Supports product planning, pricing strategy, and market expansion decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`configuration`"
  dimensions:
    - name: "body_style"
      expr: body_style
      comment: "Body style of the configuration (e.g. SUV, Sedan, Pickup). Primary product portfolio segmentation dimension."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (e.g. BEV, PHEV, ICE, Hybrid). Critical for EV transition tracking and regulatory compliance."
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain configuration (e.g. AWD, FWD, RWD). Used in product mix and customer preference analysis."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (e.g. Automatic, Manual, CVT). Supports product specification and market preference analysis."
    - name: "market_region"
      expr: market_region
      comment: "Market region for the configuration. Enables regional product portfolio and pricing analysis."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country code for the target market. Supports country-level regulatory and pricing compliance."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the configuration. Enables year-over-year product portfolio comparison."
    - name: "record_status"
      expr: record_status
      comment: "Record status of the configuration (e.g. Active, Inactive). Used to filter to live configurations."
    - name: "emissions_cert_status"
      expr: emissions_cert_status
      comment: "Emissions certification status. Tracks regulatory compliance readiness for market launch."
    - name: "build_feasibility_status"
      expr: build_feasibility_status
      comment: "Build feasibility assessment status. Identifies configurations ready for production scheduling."
  measures:
    - name: "total_configurations"
      expr: COUNT(1)
      comment: "Total number of vehicle configurations in the portfolio. Baseline measure for product breadth and complexity management."
    - name: "avg_msrp_amount"
      expr: ROUND(AVG(CAST(msrp_amount AS DOUBLE)), 2)
      comment: "Average MSRP across configurations. Core pricing KPI for product positioning and competitive benchmarking."
    - name: "total_msrp_portfolio_value"
      expr: ROUND(SUM(CAST(msrp_amount AS DOUBLE)), 2)
      comment: "Total MSRP value of the configuration portfolio. Measures addressable revenue potential of the product lineup."
    - name: "avg_total_price"
      expr: ROUND(AVG(CAST(total_price AS DOUBLE)), 2)
      comment: "Average total price (including options and charges) across configurations. Reflects real customer price point for revenue planning."
    - name: "avg_destination_charge"
      expr: ROUND(AVG(CAST(destination_charge AS DOUBLE)), 2)
      comment: "Average destination charge across configurations. Monitors logistics cost pass-through and pricing transparency."
    - name: "subscription_eligible_configurations"
      expr: COUNT(CASE WHEN subscription_eligible_flag = TRUE THEN 1 END)
      comment: "Count of configurations eligible for subscription services. Measures recurring revenue model reach across the product portfolio."
    - name: "subscription_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of configurations eligible for subscription. Tracks progress of subscription business model adoption."
    - name: "extended_warranty_eligible_configurations"
      expr: COUNT(CASE WHEN extended_warranty_eligible_flag = TRUE THEN 1 END)
      comment: "Count of configurations eligible for extended warranty. Supports aftersales revenue forecasting and warranty program design."
    - name: "avg_fuel_economy_city_mpg"
      expr: ROUND(AVG(CAST(fuel_economy_city_mpg AS DOUBLE)), 2)
      comment: "Average city fuel economy (MPG) across configurations. Tracks portfolio-level efficiency for regulatory and sustainability reporting."
    - name: "avg_fuel_economy_hwy_mpg"
      expr: ROUND(AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE)), 2)
      comment: "Average highway fuel economy (MPG) across configurations. Complements city MPG for full regulatory compliance picture."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle lifecycle event KPIs tracking the frequency, type, and criticality of events across the vehicle journey — from production through ownership, service, and end-of-life. Supports quality, safety, and customer experience decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "High-level type of lifecycle event (e.g. Sale, Service, Recall, Defect). Primary segmentation for event analysis."
    - name: "event_category"
      expr: event_category
      comment: "Category of the lifecycle event. Enables drill-down from event type to specific operational categories."
    - name: "event_subtype"
      expr: event_subtype
      comment: "Sub-type of the lifecycle event. Supports granular root-cause analysis of quality and service events."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (e.g. Open, Closed, Pending). Used to track event resolution rates."
    - name: "event_location_country"
      expr: event_location_country
      comment: "Country where the event occurred. Enables geographic quality and service distribution analysis."
    - name: "event_location_state"
      expr: event_location_state
      comment: "State/province where the event occurred. Supports regional service network capacity planning."
    - name: "event_source_system"
      expr: event_source_system
      comment: "Source system that generated the event (e.g. Dealer DMS, OBD, Telematics). Tracks data provenance and system integration health."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the event timestamp. Enables monthly event volume and trend analysis."
    - name: "triggering_system"
      expr: triggering_system
      comment: "System that triggered the event. Distinguishes proactive (telematics/OBD) from reactive (dealer/customer) event sources."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total number of lifecycle events recorded. Baseline volume KPI for fleet activity and operational load monitoring."
    - name: "critical_events"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Count of events flagged as critical. Directly drives safety escalation, recall decisions, and executive risk reporting."
    - name: "critical_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events that are critical. Key quality and safety KPI for executive and regulatory reporting."
    - name: "obd_triggered_events"
      expr: COUNT(CASE WHEN obd_triggered_flag = TRUE THEN 1 END)
      comment: "Count of events triggered by OBD diagnostics. Measures proactive diagnostic coverage and predictive maintenance effectiveness."
    - name: "ota_related_events"
      expr: COUNT(CASE WHEN ota_related_flag = TRUE THEN 1 END)
      comment: "Count of events related to OTA software updates. Tracks OTA deployment impact and potential software-induced issues."
    - name: "digital_channel_events"
      expr: COUNT(CASE WHEN digital_channel_flag = TRUE THEN 1 END)
      comment: "Count of events initiated through digital channels. Measures digital engagement and self-service adoption across the fleet."
    - name: "self_service_initiated_events"
      expr: COUNT(CASE WHEN self_service_initiated_flag = TRUE THEN 1 END)
      comment: "Count of events initiated by customers via self-service. Tracks self-service adoption rate and dealer cost deflection."
    - name: "unique_vehicles_with_events"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Count of distinct vehicles that have at least one lifecycle event. Measures active fleet engagement and service coverage breadth."
    - name: "avg_odometer_reading_km"
      expr: ROUND(AVG(CAST(odometer_reading_km AS DOUBLE)), 2)
      comment: "Average odometer reading (km) at time of event. Tracks fleet mileage accumulation and informs service interval planning."
    - name: "max_odometer_reading_km"
      expr: MAX(odometer_reading_km)
      comment: "Maximum odometer reading recorded across all events. Identifies high-mileage vehicles for targeted service and warranty risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership KPIs covering fleet composition, ownership type, connected services adoption, and digital engagement. Supports customer retention, aftersales revenue, and connected-vehicle strategy decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`ownership`"
  dimensions:
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (e.g. Retail, Fleet, Lease, CPO). Primary segmentation for ownership portfolio analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the vehicle was acquired (e.g. Dealer, Online, Fleet Direct). Tracks channel mix and digital sales penetration."
    - name: "disposition_reason"
      expr: disposition_reason
      comment: "Reason for vehicle disposition (e.g. Trade-in, Sale, Total Loss). Informs retention strategy and residual value management."
    - name: "title_state"
      expr: title_state
      comment: "State where the vehicle title is held. Supports geographic fleet distribution and regulatory compliance reporting."
    - name: "acquisition_date_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of vehicle acquisition. Enables monthly sales volume and ownership trend analysis."
    - name: "is_current_owner"
      expr: is_current_owner
      comment: "Flag indicating whether this is the current active owner. Used to filter to the live ownership base."
  measures:
    - name: "total_ownership_records"
      expr: COUNT(1)
      comment: "Total ownership records. Baseline measure for fleet size and ownership history volume."
    - name: "current_active_owners"
      expr: COUNT(CASE WHEN is_current_owner = TRUE THEN 1 END)
      comment: "Count of current active vehicle owners. Core fleet size KPI for market share, aftersales, and connected-services revenue planning."
    - name: "connected_services_active_owners"
      expr: COUNT(CASE WHEN connected_services_active_flag = TRUE THEN 1 END)
      comment: "Count of owners with active connected services subscriptions. Directly measures recurring digital revenue base."
    - name: "connected_services_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN connected_services_active_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_current_owner = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of current owners with active connected services. Strategic KPI for digital revenue growth and retention programs."
    - name: "self_service_portal_enrolled_owners"
      expr: COUNT(CASE WHEN self_service_portal_enrolled_flag = TRUE THEN 1 END)
      comment: "Count of owners enrolled in the self-service portal. Measures digital engagement and dealer cost deflection potential."
    - name: "self_service_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN self_service_portal_enrolled_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_current_owner = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of current owners enrolled in self-service portal. Tracks digital adoption and customer experience investment ROI."
    - name: "unique_vehicles_owned"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Count of distinct vehicles with ownership records. Measures breadth of the owned fleet for market share analysis."
    - name: "unique_owners"
      expr: COUNT(DISTINCT party_id)
      comment: "Count of distinct owners (parties). Measures customer base size for CRM, loyalty, and retention program targeting."
    - name: "avg_ownership_duration_days"
      expr: ROUND(AVG(CAST(DATEDIFF(COALESCE(disposition_date, CURRENT_DATE()), acquisition_date) AS DOUBLE)), 1)
      comment: "Average vehicle ownership duration in days. Measures customer loyalty and informs lease/finance product design."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_msrp_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MSRP pricing KPIs covering base price levels, EV tax credit exposure, destination charges, extended warranty pricing, and connected services pricing across the vehicle portfolio. Supports pricing strategy and revenue planning."
  source: "`vibe_automotive_v1`.`vehicle`.`msrp_pricing`"
  dimensions:
    - name: "market_region"
      expr: market_region
      comment: "Market region for the pricing record. Enables regional pricing strategy and competitive benchmarking."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country code for the pricing record. Supports country-level pricing compliance and localization analysis."
    - name: "model_year"
      expr: model_year
      comment: "Model year associated with the pricing record. Enables year-over-year pricing trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record. Required for multi-currency pricing portfolio analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the pricing became effective. Tracks pricing change cadence and promotional period analysis."
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of MSRP pricing records. Baseline measure for pricing portfolio breadth and version management."
    - name: "avg_base_price_amount"
      expr: ROUND(AVG(CAST(price_amount AS DOUBLE)), 2)
      comment: "Average base MSRP price across pricing records. Core pricing KPI for competitive positioning and revenue planning."
    - name: "total_price_portfolio_value"
      expr: ROUND(SUM(CAST(price_amount AS DOUBLE)), 2)
      comment: "Total MSRP price value across all active pricing records. Measures total addressable revenue of the priced portfolio."
    - name: "avg_ev_tax_credit_amount"
      expr: ROUND(AVG(CAST(ev_tax_credit_amount AS DOUBLE)), 2)
      comment: "Average EV tax credit amount across pricing records. Tracks government incentive exposure and effective customer price impact."
    - name: "total_ev_tax_credit_exposure"
      expr: ROUND(SUM(CAST(ev_tax_credit_amount AS DOUBLE)), 2)
      comment: "Total EV tax credit value across the portfolio. Measures total government incentive leverage for EV sales strategy."
    - name: "avg_destination_charge_amount"
      expr: ROUND(AVG(CAST(destination_charge_amount AS DOUBLE)), 2)
      comment: "Average destination charge across pricing records. Monitors logistics cost pass-through and pricing transparency to customers."
    - name: "avg_extended_warranty_price"
      expr: ROUND(AVG(CAST(extended_warranty_price_amount AS DOUBLE)), 2)
      comment: "Average extended warranty price across pricing records. Supports aftersales warranty revenue forecasting and pricing optimization."
    - name: "avg_connected_services_price"
      expr: ROUND(AVG(CAST(connected_services_price_amount AS DOUBLE)), 2)
      comment: "Average connected services price across pricing records. Tracks recurring digital revenue pricing and subscription ARPU benchmarking."
    - name: "avg_price_uplift_amount"
      expr: ROUND(AVG(CAST(price_uplift_amount AS DOUBLE)), 2)
      comment: "Average price uplift applied above base MSRP. Measures premium pricing effectiveness and option/package revenue contribution."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle model portfolio KPIs covering product breadth, fuel economy, EV range, safety ratings, pricing, and digital capability. Supports product strategy, R&D investment, and regulatory compliance decisions at the model level."
  source: "`vibe_automotive_v1`.`vehicle`.`model`"
  dimensions:
    - name: "brand_name"
      expr: brand_name
      comment: "Brand name of the vehicle model. Primary segmentation for brand-level portfolio and performance analysis."
    - name: "body_style"
      expr: body_style
      comment: "Body style of the model (e.g. SUV, Sedan, Truck). Supports product mix and market segment analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the model (e.g. BEV, PHEV, ICE). Critical for EV transition portfolio tracking."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type of the model. Enables powertrain mix analysis for technology investment decisions."
    - name: "vehicle_class"
      expr: vehicle_class
      comment: "Vehicle class (e.g. Compact, Midsize, Full-size). Supports regulatory class-based compliance and market segment reporting."
    - name: "segment"
      expr: segment
      comment: "Market segment of the model (e.g. Luxury, Mass Market, Commercial). Drives segment-level revenue and margin analysis."
    - name: "model_status"
      expr: model_status
      comment: "Current status of the model (e.g. Active, Discontinued, Planned). Filters to live production models."
    - name: "primary_market"
      expr: primary_market
      comment: "Primary market for the model. Enables market-level product portfolio and revenue analysis."
    - name: "homologation_status"
      expr: homologation_status
      comment: "Homologation/regulatory approval status of the model. Tracks market launch readiness across regions."
    - name: "sop_date_year"
      expr: YEAR(sop_date)
      comment: "Year of start-of-production. Enables model launch cohort analysis and production ramp tracking."
  measures:
    - name: "total_models"
      expr: COUNT(1)
      comment: "Total number of vehicle models in the portfolio. Measures product breadth and portfolio complexity."
    - name: "ota_capable_models"
      expr: COUNT(CASE WHEN ota_update_capable_flag = TRUE THEN 1 END)
      comment: "Count of models capable of OTA software updates. Tracks software-defined vehicle transformation progress at the model level."
    - name: "ota_capability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_update_capable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of models with OTA capability. Strategic KPI for software-defined vehicle roadmap and digital revenue readiness."
    - name: "avg_msrp_usd"
      expr: ROUND(AVG(CAST(msrp_usd AS DOUBLE)), 2)
      comment: "Average MSRP (USD) across models. Core pricing KPI for portfolio positioning and competitive benchmarking."
    - name: "avg_fuel_economy_city_mpg"
      expr: ROUND(AVG(CAST(fuel_economy_city_mpg AS DOUBLE)), 2)
      comment: "Average city fuel economy (MPG) across models. Tracks portfolio efficiency for regulatory and sustainability reporting."
    - name: "avg_fuel_economy_hwy_mpg"
      expr: ROUND(AVG(CAST(fuel_economy_hwy_mpg AS DOUBLE)), 2)
      comment: "Average highway fuel economy (MPG) across models. Complements city MPG for full regulatory compliance picture."
    - name: "avg_electric_range_miles"
      expr: ROUND(AVG(CAST(electric_range_miles AS DOUBLE)), 2)
      comment: "Average electric range (miles) across EV/PHEV models. Key EV competitiveness KPI for product planning and consumer marketing."
    - name: "avg_co2_emissions_g_per_km"
      expr: ROUND(AVG(CAST(co2_emissions_g_per_km AS DOUBLE)), 2)
      comment: "Average CO2 emissions (g/km) across models. Core regulatory compliance KPI for fleet emissions targets (e.g. EU CAFE/CO2 standards)."
    - name: "avg_battery_capacity_kwh"
      expr: ROUND(AVG(CAST(battery_capacity_kwh AS DOUBLE)), 2)
      comment: "Average battery capacity (kWh) across models. Tracks EV portfolio energy capability for range and charging infrastructure planning."
    - name: "extended_warranty_eligible_models"
      expr: COUNT(CASE WHEN extended_warranty_eligible_flag = TRUE THEN 1 END)
      comment: "Count of models eligible for extended warranty programs. Supports aftersales revenue portfolio planning."
    - name: "self_service_portal_eligible_models"
      expr: COUNT(CASE WHEN self_service_portal_eligible_flag = TRUE THEN 1 END)
      comment: "Count of models eligible for the self-service portal. Measures digital customer experience reach across the model portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_powertrain_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain variant KPIs covering fuel economy, EV range, battery capacity, emissions, and subscription availability. Supports powertrain technology investment, regulatory compliance, and electrification strategy decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`powertrain_variant`"
  dimensions:
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Type of powertrain (e.g. BEV, PHEV, ICE, HEV). Primary segmentation for electrification portfolio analysis."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the powertrain variant. Supports fuel mix and emissions compliance analysis."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type of the powertrain variant. Enables transmission mix analysis for product planning."
    - name: "drive_type"
      expr: drive_type
      comment: "Drive type (e.g. AWD, FWD, RWD). Supports drivetrain mix and customer preference analysis."
    - name: "powertrain_variant_status"
      expr: powertrain_variant_status
      comment: "Current status of the powertrain variant (e.g. Active, Discontinued). Filters to live production variants."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the powertrain variant. Enables year-over-year powertrain technology evolution analysis."
    - name: "charging_standard"
      expr: charging_standard
      comment: "EV charging standard (e.g. CCS, CHAdeMO, NACS). Tracks charging ecosystem compatibility across the EV portfolio."
  measures:
    - name: "total_powertrain_variants"
      expr: COUNT(1)
      comment: "Total number of powertrain variants. Measures powertrain portfolio breadth and engineering complexity."
    - name: "subscription_available_variants"
      expr: COUNT(CASE WHEN subscription_available_flag = TRUE THEN 1 END)
      comment: "Count of powertrain variants with subscription services available. Tracks recurring revenue model reach at the powertrain level."
    - name: "subscription_availability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_available_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of powertrain variants with subscription availability. Strategic KPI for connected-services revenue expansion."
    - name: "avg_epa_fuel_economy_combined_mpg"
      expr: ROUND(AVG(CAST(epa_fuel_economy_combined_mpg AS DOUBLE)), 2)
      comment: "Average EPA combined fuel economy (MPG) across powertrain variants. Core regulatory compliance and fleet efficiency KPI."
    - name: "avg_fuel_economy_city_mpg"
      expr: ROUND(AVG(CAST(fuel_economy_city_mpg AS DOUBLE)), 2)
      comment: "Average city fuel economy (MPG) across powertrain variants. Supports regulatory reporting and consumer-facing efficiency claims."
    - name: "avg_fuel_economy_highway_mpg"
      expr: ROUND(AVG(CAST(fuel_economy_highway_mpg AS DOUBLE)), 2)
      comment: "Average highway fuel economy (MPG) across powertrain variants. Complements city MPG for full EPA compliance picture."
    - name: "avg_battery_capacity_kwh"
      expr: ROUND(AVG(CAST(battery_capacity_kwh AS DOUBLE)), 2)
      comment: "Average battery capacity (kWh) across EV/PHEV powertrain variants. Tracks EV energy capability for range and charging planning."
    - name: "avg_combined_system_power_kw"
      expr: ROUND(AVG(CAST(combined_system_power_kw AS DOUBLE)), 2)
      comment: "Average combined system power (kW) across powertrain variants. Measures performance capability of the powertrain portfolio."
    - name: "avg_electric_motor_power_kw"
      expr: ROUND(AVG(CAST(electric_motor_power_kw AS DOUBLE)), 2)
      comment: "Average electric motor power (kW) across electrified variants. Tracks EV performance capability for product competitiveness analysis."
    - name: "avg_wltp_fuel_economy_combined_mpg"
      expr: ROUND(AVG(CAST(wltp_fuel_economy_combined_mpg AS DOUBLE)), 2)
      comment: "Average WLTP combined fuel economy (MPG) across variants. Required for European regulatory compliance and emissions reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_trim_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trim level KPIs covering pricing tiers, active trim availability, connected services tier distribution, and warranty coverage. Supports product line pricing strategy, trim rationalization, and aftersales revenue decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`trim_level`"
  dimensions:
    - name: "trim_tier"
      expr: trim_tier
      comment: "Tier of the trim level (e.g. Base, Mid, Premium, Sport). Primary segmentation for pricing and feature tier analysis."
    - name: "trim_name"
      expr: trim_name
      comment: "Name of the trim level. Enables trim-level granular analysis for product planning and sales mix reporting."
    - name: "connected_services_tier"
      expr: connected_services_tier
      comment: "Connected services tier bundled with the trim. Tracks digital service tier distribution across the product lineup."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the trim level is currently active. Used to filter to live production trims."
    - name: "effective_start_date_year"
      expr: YEAR(effective_start_date)
      comment: "Year the trim level became effective. Enables trim lifecycle and product refresh cadence analysis."
  measures:
    - name: "total_trim_levels"
      expr: COUNT(1)
      comment: "Total number of trim levels in the portfolio. Measures product line complexity and trim rationalization opportunities."
    - name: "active_trim_levels"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active trim levels. Measures live product line breadth for sales and marketing planning."
    - name: "avg_base_msrp_usd"
      expr: ROUND(AVG(CAST(base_msrp_usd AS DOUBLE)), 2)
      comment: "Average base MSRP (USD) across trim levels. Core pricing KPI for trim tier positioning and competitive benchmarking."
    - name: "avg_base_msrp_amount"
      expr: ROUND(AVG(CAST(base_msrp_amount AS DOUBLE)), 2)
      comment: "Average base MSRP amount (local currency) across trim levels. Supports multi-currency pricing analysis and regional pricing strategy."
    - name: "total_base_msrp_portfolio_value"
      expr: ROUND(SUM(CAST(base_msrp_usd AS DOUBLE)), 2)
      comment: "Total base MSRP value (USD) across all trim levels. Measures total addressable revenue of the trim portfolio."
    - name: "price_spread_usd"
      expr: COUNT(1)
      comment: "Difference between highest and lowest trim MSRP (USD). Measures pricing range breadth for market segmentation and upsell opportunity analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_option_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Option package KPIs covering package pricing, availability, connected service inclusion, and OTA feature unlock capability. Supports aftersales revenue, upsell strategy, and digital feature monetization decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`option_package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of option package (e.g. Technology, Safety, Appearance). Primary segmentation for package portfolio analysis."
    - name: "package_name"
      expr: package_name
      comment: "Name of the option package. Enables package-level revenue and adoption analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the package is currently active. Filters to live packages for current portfolio analysis."
    - name: "is_available"
      expr: is_available
      comment: "Flag indicating whether the package is currently available for order. Tracks package availability for sales and order management."
    - name: "ota_feature_unlock_flag"
      expr: ota_feature_unlock_flag
      comment: "Flag indicating whether the package includes OTA feature unlock capability. Tracks digital feature monetization reach."
    - name: "connected_service_included_flag"
      expr: connected_service_included_flag
      comment: "Flag indicating whether the package includes connected services. Measures connected-services bundling across the option portfolio."
    - name: "effective_start_date_year"
      expr: YEAR(effective_start_date)
      comment: "Year the package became effective. Enables package lifecycle and refresh cadence analysis."
  measures:
    - name: "total_option_packages"
      expr: COUNT(1)
      comment: "Total number of option packages. Measures option portfolio breadth and complexity."
    - name: "active_available_packages"
      expr: COUNT(CASE WHEN is_active = TRUE AND is_available = TRUE THEN 1 END)
      comment: "Count of packages that are both active and available for order. Measures live orderable option portfolio size."
    - name: "ota_unlock_packages"
      expr: COUNT(CASE WHEN ota_feature_unlock_flag = TRUE THEN 1 END)
      comment: "Count of packages with OTA feature unlock capability. Tracks digital feature monetization portfolio breadth."
    - name: "ota_unlock_package_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_feature_unlock_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of packages with OTA feature unlock. Strategic KPI for software-defined vehicle revenue model adoption."
    - name: "connected_service_bundled_packages"
      expr: COUNT(CASE WHEN connected_service_included_flag = TRUE THEN 1 END)
      comment: "Count of packages that bundle connected services. Measures connected-services distribution through option packages."
    - name: "avg_package_price_usd"
      expr: ROUND(AVG(CAST(package_price_usd AS DOUBLE)), 2)
      comment: "Average option package price (USD). Core pricing KPI for option revenue planning and competitive benchmarking."
    - name: "avg_msrp_amount"
      expr: ROUND(AVG(CAST(msrp_amount AS DOUBLE)), 2)
      comment: "Average MSRP contribution of option packages. Measures average option value add to vehicle transaction price."
    - name: "total_option_portfolio_value_usd"
      expr: ROUND(SUM(CAST(package_price_usd AS DOUBLE)), 2)
      comment: "Total price value of all option packages. Measures total addressable option revenue across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle platform KPIs covering development investment, modular reuse, OTA capability, and production lifecycle. Supports platform strategy, R&D investment allocation, and architecture rationalization decisions."
  source: "`vibe_automotive_v1`.`vehicle`.`platform`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Type of vehicle platform (e.g. EV-native, ICE, Multi-energy). Primary segmentation for platform architecture analysis."
    - name: "platform_status"
      expr: platform_status
      comment: "Current status of the platform (e.g. Active, Sunset, Development). Filters to live production platforms."
    - name: "architecture"
      expr: architecture
      comment: "Platform architecture type. Enables architecture-level investment and capability analysis."
    - name: "family"
      expr: family
      comment: "Platform family grouping. Supports platform family-level reuse and investment analysis."
    - name: "owner_business_unit"
      expr: owner_business_unit
      comment: "Business unit responsible for the platform. Enables BU-level R&D investment and platform ownership analysis."
    - name: "emissions_class"
      expr: emissions_class
      comment: "Emissions class of the platform. Tracks regulatory compliance capability at the platform architecture level."
    - name: "sop_date_year"
      expr: YEAR(start_of_production_date)
      comment: "Year of platform start-of-production. Enables platform generation and lifecycle analysis."
  measures:
    - name: "total_platforms"
      expr: COUNT(1)
      comment: "Total number of vehicle platforms. Measures platform portfolio breadth and architecture complexity."
    - name: "ota_capable_platforms"
      expr: COUNT(CASE WHEN ota_capability = TRUE THEN 1 END)
      comment: "Count of platforms with OTA update capability. Tracks software-defined vehicle architecture readiness at the platform level."
    - name: "ota_platform_capability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_capability = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of platforms with OTA capability. Strategic KPI for software-defined vehicle transformation investment decisions."
    - name: "adaptive_cruise_control_platforms"
      expr: COUNT(CASE WHEN adaptive_cruise_control = TRUE THEN 1 END)
      comment: "Count of platforms with adaptive cruise control (ADAS baseline). Tracks ADAS capability penetration across the platform portfolio."
    - name: "total_development_cost_usd"
      expr: ROUND(SUM(CAST(development_cost_usd AS DOUBLE)), 2)
      comment: "Total R&D development cost (USD) across platforms. Core investment KPI for platform portfolio ROI and capital allocation decisions."
    - name: "avg_development_cost_usd"
      expr: ROUND(AVG(CAST(development_cost_usd AS DOUBLE)), 2)
      comment: "Average development cost (USD) per platform. Benchmarks platform investment efficiency and informs future R&D budgeting."
    - name: "avg_modular_score"
      expr: ROUND(AVG(CAST(modular_score AS DOUBLE)), 2)
      comment: "Average modularity score across platforms. Measures platform reuse efficiency — higher scores indicate greater economies of scale."
$$;