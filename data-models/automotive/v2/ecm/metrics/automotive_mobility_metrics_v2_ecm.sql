-- Metric views for domain: mobility | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_connected_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet-level KPIs for connected vehicle activation, subscription health, battery state, and data consumption — core operational dashboard for the Connected Vehicle Operations team."
  source: "`vibe_automotive_v1`.`mobility`.`connected_vehicle`"
  dimensions:
    - name: "activation_status"
      expr: activation_status
      comment: "Current activation status of the connected vehicle (e.g. Active, Inactive, Suspended) — primary segmentation for fleet health reporting."
    - name: "connectivity_tier"
      expr: connectivity_tier
      comment: "Connectivity service tier assigned to the vehicle (e.g. Basic, Standard, Premium) — used to analyse tier mix and upsell opportunities."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain classification (BEV, PHEV, ICE, HEV) — enables segmentation of telemetry and subscription KPIs by drivetrain."
    - name: "subscription_plan"
      expr: subscription_plan
      comment: "Active subscription plan name — used to track plan distribution and revenue mix across the connected fleet."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the vehicle — supports regional performance and compliance reporting."
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Vehicle body/class type — enables segmentation of KPIs by vehicle category."
    - name: "registration_date_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of vehicle registration — used for cohort and trend analysis of fleet growth."
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current warranty status of the vehicle — relevant for aftersales and service eligibility analysis."
  measures:
    - name: "total_connected_vehicles"
      expr: COUNT(1)
      comment: "Total number of connected vehicle records — baseline fleet size KPI used in all connected vehicle dashboards."
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_active_flag = TRUE THEN 1 END)
      comment: "Count of vehicles with an active subscription — primary revenue-linked fleet health indicator."
    - name: "subscription_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_active_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of connected vehicles with an active subscription — key monetisation KPI; a decline signals churn risk."
    - name: "avg_battery_state_of_charge_pct"
      expr: ROUND(AVG(CAST(battery_state_of_charge_percent AS DOUBLE)), 2)
      comment: "Average battery state of charge across the fleet — operational health indicator for EV/PHEV fleet management and range anxiety monitoring."
    - name: "avg_battery_health_pct"
      expr: ROUND(AVG(CAST(battery_health_percent AS DOUBLE)), 2)
      comment: "Average battery health percentage across the fleet — degradation KPI that informs warranty, residual value, and proactive service decisions."
    - name: "total_data_usage_gb"
      expr: SUM(CAST(data_usage_gb AS DOUBLE))
      comment: "Total cellular data consumed by the connected fleet — drives data plan cost management and capacity planning decisions."
    - name: "avg_mileage_km"
      expr: ROUND(AVG(CAST(mileage_km AS DOUBLE)), 2)
      comment: "Average odometer reading across the fleet — proxy for vehicle utilisation and service interval planning."
    - name: "ota_capable_vehicles"
      expr: COUNT(CASE WHEN ota_capability = TRUE THEN 1 END)
      comment: "Count of vehicles capable of receiving OTA software updates — critical for software deployment planning and cybersecurity patch coverage."
    - name: "v2x_capable_vehicles"
      expr: COUNT(CASE WHEN v2x_capability = TRUE THEN 1 END)
      comment: "Count of vehicles with V2X (vehicle-to-everything) capability — strategic KPI for smart mobility and infrastructure investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription revenue, churn, and lifecycle KPIs for connected mobility services — primary financial and retention dashboard for the Mobility Services business unit."
  source: "`vibe_automotive_v1`.`mobility`.`service_subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current lifecycle status of the subscription (Active, Cancelled, Suspended, Trial) — primary dimension for churn and retention analysis."
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g. Connected Services, ADAS, EV Charging) — used to analyse revenue mix by service category."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (Monthly, Annual, Pay-per-use) — used to segment recurring revenue and cash flow forecasting."
    - name: "entitlement_tier"
      expr: entitlement_tier
      comment: "Service entitlement tier assigned to the subscription — used to track tier distribution and upsell performance."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (Credit Card, Invoice, Direct Debit) — relevant for payment failure analysis and collections."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the subscription started — used for cohort-based retention and revenue ramp analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for subscription cancellation — key input for churn root-cause analysis and product improvement."
    - name: "trial_flag"
      expr: trial_flag
      comment: "Indicates whether the subscription is in a trial period — used to track trial-to-paid conversion rates."
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of service subscriptions — baseline volume KPI for the connected services portfolio."
    - name: "active_subscriptions"
      expr: COUNT(CASE WHEN subscription_status = 'Active' THEN 1 END)
      comment: "Count of currently active subscriptions — primary recurring revenue base indicator."
    - name: "total_billing_revenue"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total billed subscription revenue — top-line revenue KPI for the Mobility Services P&L."
    - name: "avg_billing_amount"
      expr: ROUND(AVG(CAST(billing_amount AS DOUBLE)), 2)
      comment: "Average billing amount per subscription — used to track ARPU (Average Revenue Per User) trends and pricing effectiveness."
    - name: "total_promo_discount_amount"
      expr: SUM(CAST(promo_discount_amount AS DOUBLE))
      comment: "Total promotional discounts applied across subscriptions — measures cost of acquisition promotions and their impact on net revenue."
    - name: "total_overage_revenue"
      expr: SUM(CAST(overage_amount AS DOUBLE))
      comment: "Total overage charges billed — indicates usage beyond plan limits and potential upsell or plan-right-sizing opportunities."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN subscription_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that have been cancelled — primary churn KPI; an increase triggers retention intervention."
    - name: "trial_conversion_count"
      expr: COUNT(CASE WHEN trial_flag = FALSE AND subscription_status = 'Active' THEN 1 END)
      comment: "Count of subscriptions that are active and not in trial — proxy for trial-to-paid conversion volume, a key growth metric."
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions with auto-renewal enabled — leading indicator of future recurring revenue retention."
    - name: "total_usage_consumed"
      expr: SUM(CAST(usage_used AS DOUBLE))
      comment: "Total service usage consumed across all subscriptions — operational capacity and plan utilisation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ev_charging_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EV charging network utilisation, revenue, and energy delivery KPIs — operational and financial dashboard for the EV Charging Infrastructure team."
  source: "`vibe_automotive_v1`.`mobility`.`ev_charging_session`"
  dimensions:
    - name: "charger_type"
      expr: charger_type
      comment: "Type of charger used (AC Level 2, DC Fast Charge, etc.) — used to analyse utilisation and revenue by charger technology."
    - name: "ev_charging_session_status"
      expr: ev_charging_session_status
      comment: "Outcome status of the charging session (Completed, Failed, Interrupted) — used to track session success rates and reliability."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the session — relevant for payment processing analysis and preferred payment channel insights."
    - name: "location_type"
      expr: location_type
      comment: "Type of charging location (Public, Workplace, Home, Dealer) — used to segment utilisation and revenue by location category."
    - name: "station_country"
      expr: station_country
      comment: "Country where the charging station is located — enables geographic revenue and utilisation analysis."
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month the charging session started — used for trend analysis of charging demand and revenue over time."
    - name: "termination_reason"
      expr: termination_reason
      comment: "Reason the session ended (User Stop, Timeout, Error, Full Charge) — used for reliability and customer experience analysis."
  measures:
    - name: "total_charging_sessions"
      expr: COUNT(1)
      comment: "Total number of EV charging sessions — baseline utilisation KPI for the charging network."
    - name: "total_energy_delivered_kwh"
      expr: SUM(CAST(energy_delivered_kwh AS DOUBLE))
      comment: "Total energy delivered across all charging sessions in kWh — primary throughput KPI for the charging network; drives infrastructure investment decisions."
    - name: "total_charge_revenue"
      expr: SUM(CAST(charge_cost_amount AS DOUBLE))
      comment: "Total revenue generated from charging sessions — top-line revenue KPI for the EV charging business."
    - name: "avg_energy_per_session_kwh"
      expr: ROUND(AVG(CAST(energy_delivered_kwh AS DOUBLE)), 2)
      comment: "Average energy delivered per charging session — used to assess typical session depth and charger sizing adequacy."
    - name: "avg_session_duration_seconds"
      expr: ROUND(AVG(CAST(session_duration_seconds AS DOUBLE)), 0)
      comment: "Average charging session duration in seconds — key utilisation metric; longer sessions reduce charger throughput capacity."
    - name: "avg_peak_power_kw"
      expr: ROUND(AVG(CAST(peak_power_kw AS DOUBLE)), 2)
      comment: "Average peak power delivered per session in kW — indicates whether chargers are being used at rated capacity."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across charging sessions — measures promotional cost and its impact on net charging revenue."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts from charging sessions — true bottom-line revenue KPI for the charging network P&L."
    - name: "session_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ev_charging_session_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charging sessions that completed successfully — reliability KPI; a decline signals infrastructure or software issues requiring intervention."
    - name: "ota_update_sessions"
      expr: COUNT(CASE WHEN is_ota_update_performed = TRUE THEN 1 END)
      comment: "Count of charging sessions during which an OTA software update was performed — measures OTA delivery efficiency via charging events."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_trip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle trip analytics covering distance, energy efficiency, driver behaviour, and emissions — operational and sustainability KPIs for fleet managers and mobility service operators."
  source: "`vibe_automotive_v1`.`mobility`.`trip`"
  dimensions:
    - name: "trip_status"
      expr: trip_status
      comment: "Status of the trip record (Completed, In Progress, Cancelled) — used to filter analysis to completed trips."
    - name: "trip_type"
      expr: trip_type
      comment: "Classification of the trip (Business, Personal, Delivery, Commute) — used to segment utilisation and cost allocation."
    - name: "road_type"
      expr: road_type
      comment: "Type of road driven (Highway, Urban, Rural) — used to analyse energy consumption and driver behaviour by road context."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the trip — used to contextualise energy consumption and safety metrics."
    - name: "trip_date_month"
      expr: DATE_TRUNC('MONTH', trip_date)
      comment: "Month of the trip — used for trend analysis of fleet utilisation, emissions, and energy consumption."
    - name: "traffic_level"
      expr: traffic_level
      comment: "Traffic congestion level during the trip — used to analyse idle time and fuel/energy waste due to congestion."
  measures:
    - name: "total_trips"
      expr: COUNT(1)
      comment: "Total number of trips recorded — baseline fleet utilisation KPI."
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance driven across all trips in km — primary fleet utilisation and mileage KPI used for maintenance scheduling and cost allocation."
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions across all trips in kg — ESG and sustainability KPI; directly linked to corporate carbon reduction targets and regulatory reporting."
    - name: "total_energy_consumed_kwh"
      expr: SUM(CAST(energy_consumed_kwh AS DOUBLE))
      comment: "Total energy consumed across all trips in kWh — fleet energy cost and efficiency KPI for EV/PHEV fleets."
    - name: "total_fuel_consumed_liters"
      expr: SUM(CAST(fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed across all trips in litres — fleet fuel cost KPI for ICE and hybrid vehicles."
    - name: "avg_driver_behaviour_score"
      expr: ROUND(AVG(CAST(driver_behavior_score AS DOUBLE)), 2)
      comment: "Average driver behaviour score across trips — safety and insurance KPI; low scores trigger driver coaching interventions."
    - name: "avg_distance_per_trip_km"
      expr: ROUND(AVG(CAST(distance_km AS DOUBLE)), 2)
      comment: "Average trip distance in km — used to assess typical journey length for route optimisation and charging infrastructure planning."
    - name: "total_idle_time_seconds"
      expr: SUM(CAST(idle_time_seconds AS DOUBLE))
      comment: "Total idle time across all trips in seconds — operational efficiency KPI; high idle time indicates fuel/energy waste and driver behaviour issues."
    - name: "avg_max_speed_kph"
      expr: ROUND(AVG(CAST(max_speed_kph AS DOUBLE)), 2)
      comment: "Average maximum speed recorded per trip — safety compliance KPI; used to identify speeding patterns and policy violations."
    - name: "total_toll_amount"
      expr: SUM(CAST(toll_amount_usd AS DOUBLE))
      comment: "Total toll charges incurred across all trips — fleet operating cost KPI used for expense management and route optimisation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ota_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA software campaign planning and deployment KPIs — strategic dashboard for the Software-Defined Vehicle team tracking rollout coverage, compliance, and campaign health."
  source: "`vibe_automotive_v1`.`mobility`.`ota_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the OTA campaign (Planned, Active, Completed, Paused, Failed) — primary dimension for campaign pipeline management."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of OTA campaign (Security Patch, Feature Update, Bug Fix, Regulatory) — used to prioritise and track campaign categories."
    - name: "approval_status"
      expr: approval_status
      comment: "Regulatory/internal approval status of the campaign — compliance gate KPI; unapproved campaigns cannot be deployed."
    - name: "rollout_strategy"
      expr: rollout_strategy
      comment: "Deployment strategy (Phased, Full Fleet, Targeted) — used to analyse rollout approach effectiveness and risk."
    - name: "target_market"
      expr: target_market
      comment: "Target market for the campaign — used for regional compliance and deployment coverage analysis."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started — used for trend analysis of OTA deployment cadence."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the campaign — critical for type-approval and homologation tracking."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of OTA campaigns — baseline KPI for software deployment pipeline volume."
    - name: "total_target_vehicles"
      expr: SUM(CAST(total_target_vehicles AS DOUBLE))
      comment: "Total number of vehicles targeted across all OTA campaigns — measures software update reach and fleet coverage."
    - name: "avg_target_percentage"
      expr: ROUND(AVG(CAST(target_percentage AS DOUBLE)), 2)
      comment: "Average percentage of eligible fleet targeted per campaign — used to assess rollout breadth and phased deployment strategy."
    - name: "avg_firmware_size_mb"
      expr: ROUND(AVG(CAST(firmware_size_mb AS DOUBLE)), 2)
      comment: "Average firmware package size in MB — used for bandwidth planning and data cost estimation for OTA deployments."
    - name: "rollback_enabled_campaigns"
      expr: COUNT(CASE WHEN rollback_enabled = TRUE THEN 1 END)
      comment: "Count of campaigns with rollback capability enabled — safety and risk management KPI; campaigns without rollback carry higher deployment risk."
    - name: "approved_campaigns"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Count of campaigns with regulatory/internal approval — compliance readiness KPI for the OTA deployment pipeline."
    - name: "avg_estimated_impact_pct"
      expr: ROUND(AVG(CAST(estimated_impact_percentage AS DOUBLE)), 2)
      comment: "Average estimated fleet impact percentage per campaign — used to prioritise high-impact campaigns and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ota_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA deployment execution KPIs tracking success rates, download performance, and data consumption at the individual vehicle level — operational dashboard for the OTA Operations team."
  source: "`vibe_automotive_v1`.`mobility`.`mobility_ota_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Execution status of the OTA deployment (Success, Failed, In Progress, Pending) — primary dimension for deployment health monitoring."
    - name: "connection_type"
      expr: connection_type
      comment: "Network connection type used for the deployment (4G, 5G, WiFi) — used to analyse deployment success rates by connectivity type."
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Reason code for deployment failure — used for root-cause analysis of OTA failures and remediation prioritisation."
    - name: "deployment_timestamp_month"
      expr: DATE_TRUNC('MONTH', deployment_timestamp)
      comment: "Month of the deployment — used for trend analysis of OTA deployment volume and success rates."
    - name: "consent_given"
      expr: consent_given
      comment: "Whether the vehicle owner consented to the OTA update — compliance and GDPR-relevant dimension for consent-gated deployments."
  measures:
    - name: "total_deployments"
      expr: COUNT(1)
      comment: "Total number of OTA deployment attempts — baseline volume KPI for the OTA operations pipeline."
    - name: "successful_deployments"
      expr: COUNT(CASE WHEN deployment_status = 'Success' THEN 1 END)
      comment: "Count of successfully completed OTA deployments — primary success KPI for the OTA programme."
    - name: "deployment_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN deployment_status = 'Success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA deployments that succeeded — critical quality KPI; a decline triggers investigation of network, firmware, or vehicle compatibility issues."
    - name: "total_bandwidth_consumed_mb"
      expr: SUM(CAST(bandwidth_consumed_mb AS DOUBLE))
      comment: "Total bandwidth consumed by OTA deployments in MB — network cost and capacity planning KPI."
    - name: "avg_data_package_size_mb"
      expr: ROUND(AVG(CAST(data_package_size_mb AS DOUBLE)), 2)
      comment: "Average OTA data package size in MB — used to forecast bandwidth requirements for future campaigns."
    - name: "consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_given = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA deployments where owner consent was obtained — regulatory compliance KPI for GDPR and type-approval requirements."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_predictive_maintenance_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Predictive maintenance alert volume, severity, and resolution KPIs — strategic dashboard for the Connected Services and Aftersales teams to drive proactive service interventions."
  source: "`vibe_automotive_v1`.`mobility`.`predictive_maintenance_alert`"
  dimensions:
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the predictive maintenance alert (Open, Resolved, Escalated, Dismissed) — primary dimension for alert pipeline management."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of predictive maintenance alert (Battery, Brake, Tyre, Engine, etc.) — used to identify the most frequent failure modes."
    - name: "alert_category"
      expr: alert_category
      comment: "Category of the alert (Safety-Critical, Maintenance, Advisory) — used to prioritise response and resource allocation."
    - name: "severity"
      expr: severity
      comment: "Severity level of the alert (Critical, High, Medium, Low) — used to triage and escalate high-risk alerts."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Predicted failure mode — used for root-cause analysis and parts pre-positioning at service centres."
    - name: "alert_timestamp_month"
      expr: DATE_TRUNC('MONTH', alert_timestamp)
      comment: "Month the alert was generated — used for trend analysis of predictive maintenance alert volume."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of predictive maintenance alerts generated — baseline volume KPI for the predictive maintenance programme."
    - name: "open_alerts"
      expr: COUNT(CASE WHEN alert_status = 'Open' THEN 1 END)
      comment: "Count of unresolved predictive maintenance alerts — operational backlog KPI; high open counts indicate service capacity constraints."
    - name: "critical_alerts"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical severity alerts — safety KPI; requires immediate escalation and intervention to prevent vehicle failures."
    - name: "avg_confidence_pct"
      expr: ROUND(AVG(CAST(confidence_percentage AS DOUBLE)), 2)
      comment: "Average model confidence percentage for predictive alerts — AI/ML model quality KPI; low confidence indicates model retraining may be needed."
    - name: "avg_mileage_at_alert"
      expr: ROUND(AVG(CAST(mileage_at_alert AS DOUBLE)), 0)
      comment: "Average vehicle mileage at the time of alert generation — used to calibrate predictive maintenance thresholds and service interval planning."
    - name: "alert_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_status = 'Resolved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of predictive maintenance alerts that have been resolved — service effectiveness KPI; low rates indicate follow-through gaps in the service workflow."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_dtc_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diagnostic Trouble Code (DTC) event analytics — quality and reliability KPIs for the Vehicle Quality and Engineering teams to identify systemic fault patterns across the connected fleet."
  source: "`vibe_automotive_v1`.`mobility`.`mobility_dtc_event`"
  dimensions:
    - name: "dtc_code"
      expr: dtc_code
      comment: "OBD-II Diagnostic Trouble Code — primary dimension for fault pattern analysis and engineering escalation."
    - name: "system_affected"
      expr: system_affected
      comment: "Vehicle system affected by the DTC (Engine, Transmission, Battery, ADAS, etc.) — used to identify systemic quality issues by system."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the DTC event — used to prioritise engineering and field service responses."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the DTC event (Active, Cleared, Pending) — used to track open vs resolved fault populations."
    - name: "ecu_source"
      expr: ecu_source
      comment: "ECU that generated the DTC — used to identify problematic ECUs and target software fix campaigns."
    - name: "detected_timestamp_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month the DTC was detected — used for trend analysis of fault emergence rates."
    - name: "mil_illuminated_flag"
      expr: mil_illuminated_flag
      comment: "Whether the Malfunction Indicator Lamp was illuminated — used to segment customer-visible faults from background codes."
  measures:
    - name: "total_dtc_events"
      expr: COUNT(1)
      comment: "Total number of DTC events recorded — baseline fleet quality KPI; rising counts signal emerging quality issues."
    - name: "active_dtc_events"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active (uncleared) DTC events — real-time fleet health KPI; high active counts indicate unresolved quality issues."
    - name: "mil_illuminated_events"
      expr: COUNT(CASE WHEN mil_illuminated_flag = TRUE THEN 1 END)
      comment: "Count of DTC events where the MIL was illuminated — customer-visible fault KPI; directly impacts customer satisfaction and dealer service demand."
    - name: "dtc_clearance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cleared_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DTC events that have been cleared — service resolution effectiveness KPI."
    - name: "distinct_dtc_codes"
      expr: COUNT(DISTINCT dtc_code)
      comment: "Number of distinct DTC codes observed across the fleet — breadth-of-fault KPI; a high count indicates diverse quality issues requiring broad engineering attention."
    - name: "distinct_affected_vehicles"
      expr: COUNT(DISTINCT connected_vehicle_id)
      comment: "Number of distinct connected vehicles that have generated at least one DTC event — fleet exposure KPI used to assess recall or field action scope."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_geofence_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geofence violation and compliance KPIs for fleet management — operational dashboard for fleet operators tracking boundary compliance, speed violations, and vehicle movement patterns."
  source: "`vibe_automotive_v1`.`mobility`.`geofence_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of geofence event (Entry, Exit, Dwell, Violation) — primary dimension for geofence compliance analysis."
    - name: "triggered_action"
      expr: triggered_action
      comment: "Action triggered by the geofence event (Alert, Lock, Notify) — used to assess automated response effectiveness."
    - name: "processing_status"
      expr: processing_status
      comment: "Processing status of the event record — used to identify data pipeline quality issues."
    - name: "event_timestamp_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the geofence event — used for trend analysis of geofence activity and compliance."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the event record — used to filter high-quality events for compliance reporting."
  measures:
    - name: "total_geofence_events"
      expr: COUNT(1)
      comment: "Total number of geofence events recorded — baseline fleet boundary activity KPI."
    - name: "distinct_vehicles_with_events"
      expr: COUNT(DISTINCT connected_vehicle_id)
      comment: "Number of distinct vehicles that triggered geofence events — used to assess fleet-wide boundary compliance exposure."
    - name: "avg_speed_at_event_kph"
      expr: ROUND(AVG(CAST(speed_kph AS DOUBLE)), 2)
      comment: "Average vehicle speed at the time of geofence events — used to identify speeding patterns at geofence boundaries."
    - name: "total_odometer_at_event_km"
      expr: SUM(CAST(odometer_km AS DOUBLE))
      comment: "Total odometer reading at geofence events — used as a proxy for fleet mileage exposure within monitored zones."
    - name: "high_quality_event_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of geofence events passing data quality checks — data pipeline health KPI; low rates indicate telemetry or processing issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_ev_charger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EV charging infrastructure asset KPIs covering network capacity, energy delivery, operational costs, and utilisation — strategic dashboard for the EV Infrastructure team."
  source: "`vibe_automotive_v1`.`mobility`.`ev_charger`"
  dimensions:
    - name: "ev_charger_status"
      expr: ev_charger_status
      comment: "Current operational status of the charger (Online, Offline, Maintenance, Fault) — primary dimension for network availability analysis."
    - name: "ev_charger_type"
      expr: ev_charger_type
      comment: "Charger technology type (AC Level 2, DC Fast Charge, Ultra-Fast) — used to analyse capacity and investment by charger type."
    - name: "connector_type"
      expr: connector_type
      comment: "Connector standard (CCS, CHAdeMO, Type 2, NACS) — used to assess compatibility coverage across the vehicle fleet."
    - name: "country_code"
      expr: country_code
      comment: "Country where the charger is installed — used for geographic network coverage and regulatory compliance analysis."
    - name: "network_provider"
      expr: network_provider
      comment: "Charging network operator — used to analyse performance and revenue by network partner."
    - name: "is_public_access"
      expr: is_public_access
      comment: "Whether the charger is publicly accessible — used to segment public vs private charging infrastructure KPIs."
    - name: "commissioning_date_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month the charger was commissioned — used for network growth trend analysis."
  measures:
    - name: "total_chargers"
      expr: COUNT(1)
      comment: "Total number of EV chargers in the network — baseline infrastructure capacity KPI."
    - name: "active_chargers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active chargers — network availability KPI; low active counts indicate maintenance or reliability issues."
    - name: "charger_availability_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of chargers that are currently active — network uptime KPI; a decline triggers maintenance escalation."
    - name: "total_energy_delivered_kwh"
      expr: SUM(CAST(total_energy_delivered_kwh AS DOUBLE))
      comment: "Total cumulative energy delivered across all chargers in kWh — primary throughput KPI for the charging network."
    - name: "total_charging_sessions"
      expr: SUM(CAST(total_sessions AS DOUBLE))
      comment: "Total number of charging sessions completed across all chargers — utilisation volume KPI."
    - name: "avg_max_power_kw"
      expr: ROUND(AVG(CAST(max_power_kw AS DOUBLE)), 2)
      comment: "Average maximum power rating across the charger network in kW — capacity planning KPI for infrastructure investment decisions."
    - name: "total_installation_cost"
      expr: SUM(CAST(installation_cost AS DOUBLE))
      comment: "Total capital investment in charger installations — CapEx KPI for the EV infrastructure programme."
    - name: "total_operational_cost"
      expr: SUM(CAST(operational_cost AS DOUBLE))
      comment: "Total operational cost across the charger network — OpEx KPI used to assess cost-per-kWh and network profitability."
    - name: "total_carbon_reduction_kg"
      expr: SUM(CAST(carbon_emission_reduction_kg AS DOUBLE))
      comment: "Total estimated CO2 emission reduction attributable to EV charging vs ICE equivalent — ESG KPI for sustainability reporting and CSRD compliance."
    - name: "avg_sessions_per_charger"
      expr: ROUND(AVG(CAST(total_sessions AS DOUBLE)), 2)
      comment: "Average number of charging sessions per charger — utilisation efficiency KPI; low values indicate underutilised assets."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_service_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service tier portfolio KPIs covering pricing, data allowances, and tier availability — product management dashboard for the Mobility Services team to optimise tier structure and pricing."
  source: "`vibe_automotive_v1`.`mobility`.`service_tier`"
  dimensions:
    - name: "tier_status"
      expr: tier_status
      comment: "Current status of the service tier (Active, Deprecated, Planned) — used to track the active tier portfolio."
    - name: "tier_level"
      expr: tier_level
      comment: "Tier level classification (Entry, Standard, Premium, Elite) — used to analyse pricing and feature distribution across tiers."
    - name: "dealer_sellable_flag"
      expr: dealer_sellable_flag
      comment: "Whether the tier is available for dealer-initiated sales — used to assess dealer channel coverage of the tier portfolio."
    - name: "sales_eligible_flag"
      expr: sales_eligible_flag
      comment: "Whether the tier is eligible for direct sales — used to track the sellable tier portfolio."
  measures:
    - name: "total_service_tiers"
      expr: COUNT(1)
      comment: "Total number of service tiers defined — portfolio breadth KPI for the connected services product team."
    - name: "active_tiers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active service tiers — active portfolio size KPI."
    - name: "avg_monthly_price"
      expr: ROUND(AVG(CAST(monthly_price AS DOUBLE)), 2)
      comment: "Average monthly price across all service tiers — pricing benchmark KPI used for competitive positioning and revenue modelling."
    - name: "avg_annual_price"
      expr: ROUND(AVG(CAST(annual_price AS DOUBLE)), 2)
      comment: "Average annual price across all service tiers — used to assess annual contract value and pricing strategy."
    - name: "avg_data_allowance_gb"
      expr: ROUND(AVG(CAST(data_allowance_gb AS DOUBLE)), 2)
      comment: "Average data allowance in GB across service tiers — used to assess data value proposition and network cost planning."
    - name: "dealer_sellable_tier_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN dealer_sellable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service tiers available through the dealer channel — channel coverage KPI for the dealer sales programme."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_usage_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service usage consumption and billing KPIs — financial operations dashboard for the Mobility Billing team tracking usage volumes, revenue, and rating completeness."
  source: "`vibe_automotive_v1`.`mobility`.`usage_record`"
  dimensions:
    - name: "usage_type"
      expr: usage_type
      comment: "Type of usage being recorded (Data, Mileage, Charging, API Calls) — used to analyse consumption by service category."
    - name: "usage_metric_type"
      expr: usage_metric_type
      comment: "Metric type for the usage record (GB, km, kWh, Sessions) — used to segment usage analysis by unit of measure."
    - name: "usage_record_status"
      expr: usage_record_status
      comment: "Processing status of the usage record (Pending, Rated, Billed, Error) — used to track billing pipeline completeness."
    - name: "rated_flag"
      expr: rated_flag
      comment: "Whether the usage record has been rated (priced) — used to identify unrated usage that has not yet been billed."
    - name: "usage_start_month"
      expr: DATE_TRUNC('MONTH', usage_start_timestamp)
      comment: "Month the usage period started — used for monthly revenue and consumption trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the usage charge — used for multi-currency revenue reporting."
  measures:
    - name: "total_usage_records"
      expr: COUNT(1)
      comment: "Total number of usage records — baseline billing pipeline volume KPI."
    - name: "total_usage_quantity"
      expr: SUM(CAST(usage_quantity AS DOUBLE))
      comment: "Total usage quantity consumed across all records — primary consumption volume KPI for capacity and cost management."
    - name: "total_rating_amount"
      expr: SUM(CAST(rating_amount AS DOUBLE))
      comment: "Total rated (priced) amount across all usage records — revenue recognition KPI for the mobility services billing cycle."
    - name: "avg_rating_amount"
      expr: ROUND(AVG(CAST(rating_amount AS DOUBLE)), 2)
      comment: "Average rated amount per usage record — used to track average revenue per usage event and pricing effectiveness."
    - name: "rated_record_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of usage records that have been rated — billing completeness KPI; low rates indicate revenue leakage from unrated usage."
    - name: "unrated_usage_quantity"
      expr: SUM(CASE WHEN rated_flag = FALSE THEN usage_quantity ELSE 0 END)
      comment: "Total usage quantity that has not yet been rated — revenue leakage risk KPI; high values indicate billing pipeline backlogs."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_remote_diagnostic_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote diagnostic session effectiveness and throughput KPIs — operational dashboard for the Connected Services and Technical Assistance Centre teams."
  source: "`vibe_automotive_v1`.`mobility`.`remote_diagnostic_session`"
  dimensions:
    - name: "remote_diagnostic_session_status"
      expr: remote_diagnostic_session_status
      comment: "Status of the remote diagnostic session (Completed, Failed, In Progress, Escalated) — primary dimension for session outcome analysis."
    - name: "diagnostic_scope"
      expr: diagnostic_scope
      comment: "Scope of the diagnostic session (Full Vehicle, Powertrain, ADAS, Battery) — used to analyse diagnostic coverage by system."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the diagnostic session (Issue Found, No Fault, Escalated to Dealer) — used to measure remote resolution effectiveness."
    - name: "network_type"
      expr: network_type
      comment: "Network type used for the session (4G, 5G, WiFi) — used to analyse session quality and success rates by connectivity."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Event type that triggered the diagnostic session (DTC Alert, Customer Request, Predictive Alert) — used to analyse session demand drivers."
    - name: "session_start_month"
      expr: DATE_TRUNC('MONTH', session_start_timestamp)
      comment: "Month the diagnostic session started — used for trend analysis of remote diagnostic demand."
  measures:
    - name: "total_diagnostic_sessions"
      expr: COUNT(1)
      comment: "Total number of remote diagnostic sessions — baseline volume KPI for the remote services operation."
    - name: "completed_sessions"
      expr: COUNT(CASE WHEN remote_diagnostic_session_status = 'Completed' THEN 1 END)
      comment: "Count of successfully completed remote diagnostic sessions — service delivery KPI."
    - name: "session_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remote_diagnostic_session_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remote diagnostic sessions that completed successfully — service quality KPI; low rates indicate connectivity or tooling issues."
    - name: "escalated_sessions"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of sessions escalated to dealer or field service — measures remote resolution limitations and dealer referral volume."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remote diagnostic sessions requiring escalation — efficiency KPI; high escalation rates indicate remote tooling gaps or complex fault patterns."
    - name: "total_data_volume_mb"
      expr: SUM(CAST(data_volume_mb AS DOUBLE))
      comment: "Total data volume transferred during remote diagnostic sessions in MB — network cost and capacity planning KPI."
    - name: "avg_data_volume_per_session_mb"
      expr: ROUND(AVG(CAST(data_volume_mb AS DOUBLE)), 2)
      comment: "Average data volume per remote diagnostic session in MB — used to estimate bandwidth requirements for scaling the remote diagnostics service."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_vehicle_service_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle-level service subscription revenue, data consumption, and lifecycle KPIs — financial and product dashboard for the Vehicle Connectivity monetisation team."
  source: "`vibe_automotive_v1`.`mobility`.`service_subscription`"
  dimensions:
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of vehicle service subscription (Connected Services, ADAS, EV, Safety) — used to analyse revenue mix by service type."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing frequency (Monthly, Annual) — used to segment recurring revenue and cash flow forecasting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the subscription started — used for cohort-based retention and revenue ramp analysis."
  measures:
    - name: "total_vehicle_subscriptions"
      expr: COUNT(1)
      comment: "Total number of vehicle service subscriptions — baseline portfolio size KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_fleet_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet account portfolio KPIs covering account health, revenue, and fleet size — strategic dashboard for the Fleet Sales and Mobility B2B team."
  source: "`vibe_automotive_v1`.`mobility`.`mobility_fleet_account`"
  dimensions:
    - name: "fleet_account_status"
      expr: fleet_account_status
      comment: "Current status of the fleet account (Active, Inactive, Suspended, Prospect) — primary dimension for account health analysis."
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Subscription tier of the fleet account (Basic, Standard, Premium) — used to analyse revenue mix and upsell opportunities."
    - name: "subscription_sales_channel"
      expr: subscription_sales_channel
      comment: "Sales channel through which the fleet account was acquired — used to measure channel effectiveness for B2B fleet sales."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Billing currency for the fleet account — used for multi-currency revenue reporting."
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month the fleet contract started — used for cohort analysis of fleet account acquisition and retention."
  measures:
    - name: "total_fleet_accounts"
      expr: COUNT(1)
      comment: "Total number of fleet accounts — baseline B2B portfolio size KPI."
    - name: "active_fleet_accounts"
      expr: COUNT(CASE WHEN fleet_account_status = 'Active' THEN 1 END)
      comment: "Count of currently active fleet accounts — primary B2B revenue base KPI."
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee_amount AS DOUBLE))
      comment: "Total monthly fee revenue across all fleet accounts — top-line B2B recurring revenue KPI."
    - name: "avg_monthly_fee"
      expr: ROUND(AVG(CAST(monthly_fee_amount AS DOUBLE)), 2)
      comment: "Average monthly fee per fleet account — ARPA (Average Revenue Per Account) KPI for B2B pricing analysis."
    - name: "fleet_account_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN fleet_account_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fleet accounts that are currently active — portfolio health KPI; a decline signals B2B churn risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`mobility_adas_feature_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monetization and adoption of ADAS features"
  source: "`vibe_automotive_v1`.`mobility`.`adas_feature_entitlement`"
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