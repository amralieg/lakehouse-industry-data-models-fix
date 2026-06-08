-- Metric views for domain: route | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:33:55

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_carrier_lane_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Lane Allocation business metrics"
  source: "`transport_shipping_ecm`.`route`.`carrier_lane_allocation`"
  dimensions:
    - name: "Allocation Code"
      expr: allocation_code
    - name: "Allocation Notes"
      expr: allocation_notes
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Api Integration Enabled"
      expr: api_integration_enabled
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Carrier Certification Level"
      expr: carrier_certification_level
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Bonded"
      expr: customs_bonded
    - name: "Cutoff Time"
      expr: cutoff_time
    - name: "Edi Enabled"
      expr: edi_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Lane Allocation"
      expr: COUNT(DISTINCT carrier_lane_allocation_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Carbon Emission Factor Kg Co2e"
      expr: SUM(carbon_emission_factor_kg_co2e)
    - name: "Average Carbon Emission Factor Kg Co2e"
      expr: AVG(carbon_emission_factor_kg_co2e)
    - name: "Total Contracted Capacity Teu"
      expr: SUM(contracted_capacity_teu)
    - name: "Average Contracted Capacity Teu"
      expr: AVG(contracted_capacity_teu)
    - name: "Total Contracted Capacity Volume Cbm"
      expr: SUM(contracted_capacity_volume_cbm)
    - name: "Average Contracted Capacity Volume Cbm"
      expr: AVG(contracted_capacity_volume_cbm)
    - name: "Total Contracted Capacity Weight Kg"
      expr: SUM(contracted_capacity_weight_kg)
    - name: "Average Contracted Capacity Weight Kg"
      expr: AVG(contracted_capacity_weight_kg)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
    - name: "Total Maximum Volume Limit"
      expr: SUM(maximum_volume_limit)
    - name: "Average Maximum Volume Limit"
      expr: AVG(maximum_volume_limit)
    - name: "Total Minimum Volume Commitment"
      expr: SUM(minimum_volume_commitment)
    - name: "Average Minimum Volume Commitment"
      expr: AVG(minimum_volume_commitment)
    - name: "Total Performance Score"
      expr: SUM(performance_score)
    - name: "Average Performance Score"
      expr: AVG(performance_score)
    - name: "Total Sla On Time Delivery Pct"
      expr: SUM(sla_on_time_delivery_pct)
    - name: "Average Sla On Time Delivery Pct"
      expr: AVG(sla_on_time_delivery_pct)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_carrier_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier Schedule business metrics"
  source: "`transport_shipping_ecm`.`route`.`carrier_schedule`"
  dimensions:
    - name: "Alliance Code"
      expr: alliance_code
    - name: "Arrival Days Of Week"
      expr: arrival_days_of_week
    - name: "Arrival Time"
      expr: arrival_time
    - name: "Arrival Timezone"
      expr: arrival_timezone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dangerous Goods Accepted"
      expr: dangerous_goods_accepted
    - name: "Departure Days Of Week"
      expr: departure_days_of_week
    - name: "Departure Time"
      expr: departure_time
    - name: "Departure Timezone"
      expr: departure_timezone
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Port Code"
      expr: destination_port_code
    - name: "Edi Source Code"
      expr: edi_source_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Frequency Per Week"
      expr: frequency_per_week
    - name: "Fuel Type"
      expr: fuel_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier Schedule"
      expr: COUNT(DISTINCT carrier_schedule_id)
    - name: "Total Capacity Teu"
      expr: SUM(capacity_teu)
    - name: "Average Capacity Teu"
      expr: AVG(capacity_teu)
    - name: "Total Capacity Volume Cbm"
      expr: SUM(capacity_volume_cbm)
    - name: "Average Capacity Volume Cbm"
      expr: AVG(capacity_volume_cbm)
    - name: "Total Capacity Weight Kg"
      expr: SUM(capacity_weight_kg)
    - name: "Average Capacity Weight Kg"
      expr: AVG(capacity_weight_kg)
    - name: "Total Co2e Emission Factor"
      expr: SUM(co2e_emission_factor)
    - name: "Average Co2e Emission Factor"
      expr: AVG(co2e_emission_factor)
    - name: "Total Cutoff Hours Before Departure"
      expr: SUM(cutoff_hours_before_departure)
    - name: "Average Cutoff Hours Before Departure"
      expr: AVG(cutoff_hours_before_departure)
    - name: "Total Doc Cutoff Hours Before Departure"
      expr: SUM(doc_cutoff_hours_before_departure)
    - name: "Average Doc Cutoff Hours Before Departure"
      expr: AVG(doc_cutoff_hours_before_departure)
    - name: "Total Transit Time Hours"
      expr: SUM(transit_time_hours)
    - name: "Average Transit Time Hours"
      expr: AVG(transit_time_hours)
    - name: "Total Vgm Cutoff Hours Before Departure"
      expr: SUM(vgm_cutoff_hours_before_departure)
    - name: "Average Vgm Cutoff Hours Before Departure"
      expr: AVG(vgm_cutoff_hours_before_departure)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_corridor_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corridor Leg business metrics"
  source: "`transport_shipping_ecm`.`route`.`corridor_leg`"
  dimensions:
    - name: "Carrier Type"
      expr: carrier_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cutoff Time"
      expr: cutoff_time
    - name: "Departure Days Mask"
      expr: departure_days_mask
    - name: "Departure Frequency"
      expr: departure_frequency
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Location Code"
      expr: destination_location_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Fourtites Tracking Enabled"
      expr: fourtites_tracking_enabled
    - name: "Incoterms Applicability"
      expr: incoterms_applicability
    - name: "Is Cross Border"
      expr: is_cross_border
    - name: "Is Dangerous Goods Permitted"
      expr: is_dangerous_goods_permitted
    - name: "Is Temperature Controlled"
      expr: is_temperature_controlled
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Leg Code"
      expr: leg_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corridor Leg"
      expr: COUNT(DISTINCT corridor_leg_id)
    - name: "Total Co2e Emission Factor"
      expr: SUM(co2e_emission_factor)
    - name: "Average Co2e Emission Factor"
      expr: AVG(co2e_emission_factor)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Max Volume Capacity Cbm"
      expr: SUM(max_volume_capacity_cbm)
    - name: "Average Max Volume Capacity Cbm"
      expr: AVG(max_volume_capacity_cbm)
    - name: "Total Max Weight Capacity Kg"
      expr: SUM(max_weight_capacity_kg)
    - name: "Average Max Weight Capacity Kg"
      expr: AVG(max_weight_capacity_kg)
    - name: "Total Sla On Time Threshold Hours"
      expr: SUM(sla_on_time_threshold_hours)
    - name: "Average Sla On Time Threshold Hours"
      expr: AVG(sla_on_time_threshold_hours)
    - name: "Total Standard Transit Hours"
      expr: SUM(standard_transit_hours)
    - name: "Average Standard Transit Hours"
      expr: AVG(standard_transit_hours)
    - name: "Total Temperature Max Celsius"
      expr: SUM(temperature_max_celsius)
    - name: "Average Temperature Max Celsius"
      expr: AVG(temperature_max_celsius)
    - name: "Total Temperature Min Celsius"
      expr: SUM(temperature_min_celsius)
    - name: "Average Temperature Min Celsius"
      expr: AVG(temperature_min_celsius)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_eta_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eta Event business metrics"
  source: "`transport_shipping_ecm`.`route`.`eta_event`"
  dimensions:
    - name: "Actual Etd"
      expr: actual_etd
    - name: "Awb Number"
      expr: awb_number
    - name: "Bol Number"
      expr: bol_number
    - name: "Container Number"
      expr: container_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Predicted Eta"
      expr: current_predicted_eta
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Customs Clearance Status"
      expr: customs_clearance_status
    - name: "Delay Reason Code"
      expr: delay_reason_code
    - name: "Delay Reason Description"
      expr: delay_reason_description
    - name: "Event Source"
      expr: event_source
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Exception Severity"
      expr: exception_severity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eta Event"
      expr: COUNT(DISTINCT eta_event_id)
    - name: "Total Actual Transit Time Hours"
      expr: SUM(actual_transit_time_hours)
    - name: "Average Actual Transit Time Hours"
      expr: AVG(actual_transit_time_hours)
    - name: "Total Eta Variance Hours"
      expr: SUM(eta_variance_hours)
    - name: "Average Eta Variance Hours"
      expr: AVG(eta_variance_hours)
    - name: "Total Etd Variance Hours"
      expr: SUM(etd_variance_hours)
    - name: "Average Etd Variance Hours"
      expr: AVG(etd_variance_hours)
    - name: "Total Location Latitude"
      expr: SUM(location_latitude)
    - name: "Average Location Latitude"
      expr: AVG(location_latitude)
    - name: "Total Location Longitude"
      expr: SUM(location_longitude)
    - name: "Average Location Longitude"
      expr: AVG(location_longitude)
    - name: "Total Planned Transit Time Hours"
      expr: SUM(planned_transit_time_hours)
    - name: "Average Planned Transit Time Hours"
      expr: AVG(planned_transit_time_hours)
    - name: "Total Prediction Confidence Score"
      expr: SUM(prediction_confidence_score)
    - name: "Average Prediction Confidence Score"
      expr: AVG(prediction_confidence_score)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_hub_spoke_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hub Spoke Config business metrics"
  source: "`transport_shipping_ecm`.`route`.`hub_spoke_config`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Carrier Allocation Strategy"
      expr: carrier_allocation_strategy
    - name: "Config Code"
      expr: config_code
    - name: "Config Name"
      expr: config_name
    - name: "Config Status"
      expr: config_status
    - name: "Config Version"
      expr: config_version
    - name: "Consolidation Cutoff Time"
      expr: consolidation_cutoff_time
    - name: "Consolidation Frequency"
      expr: consolidation_frequency
    - name: "Country Scope"
      expr: country_scope
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Required"
      expr: customs_clearance_required
    - name: "Direct Lane Bypass Enabled"
      expr: direct_lane_bypass_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hub Spoke Config"
      expr: COUNT(DISTINCT hub_spoke_config_id)
    - name: "Total Hub Capacity Teu"
      expr: SUM(hub_capacity_teu)
    - name: "Average Hub Capacity Teu"
      expr: AVG(hub_capacity_teu)
    - name: "Total Max Hub To Spoke Transit Hours"
      expr: SUM(max_hub_to_spoke_transit_hours)
    - name: "Average Max Hub To Spoke Transit Hours"
      expr: AVG(max_hub_to_spoke_transit_hours)
    - name: "Total Max Spoke To Hub Transit Hours"
      expr: SUM(max_spoke_to_hub_transit_hours)
    - name: "Average Max Spoke To Hub Transit Hours"
      expr: AVG(max_spoke_to_hub_transit_hours)
    - name: "Total Min Volume Threshold Cbm"
      expr: SUM(min_volume_threshold_cbm)
    - name: "Average Min Volume Threshold Cbm"
      expr: AVG(min_volume_threshold_cbm)
    - name: "Total Min Weight Threshold Kg"
      expr: SUM(min_weight_threshold_kg)
    - name: "Average Min Weight Threshold Kg"
      expr: AVG(min_weight_threshold_kg)
    - name: "Total Sla Target Otd Percent"
      expr: SUM(sla_target_otd_percent)
    - name: "Average Sla Target Otd Percent"
      expr: AVG(sla_target_otd_percent)
    - name: "Total Sla Target Otif Percent"
      expr: SUM(sla_target_otif_percent)
    - name: "Average Sla Target Otif Percent"
      expr: AVG(sla_target_otif_percent)
    - name: "Total Sustainability Target Co2e Kg Per Shipment"
      expr: SUM(sustainability_target_co2e_kg_per_shipment)
    - name: "Average Sustainability Target Co2e Kg Per Shipment"
      expr: AVG(sustainability_target_co2e_kg_per_shipment)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lane business metrics"
  source: "`transport_shipping_ecm`.`route`.`lane`"
  dimensions:
    - name: "Aeo Required"
      expr: aeo_required
    - name: "Blue Yonder Lane Code"
      expr: blue_yonder_lane_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Unlocode"
      expr: destination_unlocode
    - name: "Edi Lane Code"
      expr: edi_lane_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Frequency Per Week"
      expr: frequency_per_week
    - name: "Ftz Applicable"
      expr: ftz_applicable
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Is Capacity Freeze"
      expr: is_capacity_freeze
    - name: "Is Cross Border"
      expr: is_cross_border
    - name: "Is Dg Permitted"
      expr: is_dg_permitted
    - name: "Is Embargo Active"
      expr: is_embargo_active
    - name: "Is Seasonal Closure"
      expr: is_seasonal_closure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lane"
      expr: COUNT(DISTINCT lane_id)
    - name: "Total Co2e Emission Factor"
      expr: SUM(co2e_emission_factor)
    - name: "Average Co2e Emission Factor"
      expr: AVG(co2e_emission_factor)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Distance Miles"
      expr: SUM(distance_miles)
    - name: "Average Distance Miles"
      expr: AVG(distance_miles)
    - name: "Total Max Volume Cbm"
      expr: SUM(max_volume_cbm)
    - name: "Average Max Volume Cbm"
      expr: AVG(max_volume_cbm)
    - name: "Total Max Weight Kg"
      expr: SUM(max_weight_kg)
    - name: "Average Max Weight Kg"
      expr: AVG(max_weight_kg)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_lane_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lane Performance business metrics"
  source: "`transport_shipping_ecm`.`route`.`lane_performance`"
  dimensions:
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Location Code"
      expr: destination_location_code
    - name: "Exception Count"
      expr: exception_count
    - name: "Folio Source"
      expr: folio_source
    - name: "Measurement Period End Date"
      expr: measurement_period_end_date
    - name: "Measurement Period Start Date"
      expr: measurement_period_start_date
    - name: "Measurement Status"
      expr: measurement_status
    - name: "Network Optimization Trigger"
      expr: network_optimization_trigger
    - name: "On Time Shipment Count"
      expr: on_time_shipment_count
    - name: "Origin Country Code"
      expr: origin_country_code
    - name: "Origin Location Code"
      expr: origin_location_code
    - name: "Period Type"
      expr: period_type
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Shipment Count"
      expr: shipment_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lane Performance"
      expr: COUNT(DISTINCT lane_performance_id)
    - name: "Total Actual Transit Hours"
      expr: SUM(actual_transit_hours)
    - name: "Average Actual Transit Hours"
      expr: AVG(actual_transit_hours)
    - name: "Total Avg Delay Hours"
      expr: SUM(avg_delay_hours)
    - name: "Average Avg Delay Hours"
      expr: AVG(avg_delay_hours)
    - name: "Total Avg Dim Weight Kg"
      expr: SUM(avg_dim_weight_kg)
    - name: "Average Avg Dim Weight Kg"
      expr: AVG(avg_dim_weight_kg)
    - name: "Total Avg Freight Cost"
      expr: SUM(avg_freight_cost)
    - name: "Average Avg Freight Cost"
      expr: AVG(avg_freight_cost)
    - name: "Total Avg Shipment Weight Kg"
      expr: SUM(avg_shipment_weight_kg)
    - name: "Average Avg Shipment Weight Kg"
      expr: AVG(avg_shipment_weight_kg)
    - name: "Total Carrier Invoice Accuracy Rate"
      expr: SUM(carrier_invoice_accuracy_rate)
    - name: "Average Carrier Invoice Accuracy Rate"
      expr: AVG(carrier_invoice_accuracy_rate)
    - name: "Total Carrier Performance Score"
      expr: SUM(carrier_performance_score)
    - name: "Average Carrier Performance Score"
      expr: AVG(carrier_performance_score)
    - name: "Total Co2e Per Shipment Kg"
      expr: SUM(co2e_per_shipment_kg)
    - name: "Average Co2e Per Shipment Kg"
      expr: AVG(co2e_per_shipment_kg)
    - name: "Total Customs Clearance Delay Hours"
      expr: SUM(customs_clearance_delay_hours)
    - name: "Average Customs Clearance Delay Hours"
      expr: AVG(customs_clearance_delay_hours)
    - name: "Total Damage Rate"
      expr: SUM(damage_rate)
    - name: "Average Damage Rate"
      expr: AVG(damage_rate)
    - name: "Total Exception Rate"
      expr: SUM(exception_rate)
    - name: "Average Exception Rate"
      expr: AVG(exception_rate)
    - name: "Total Foukites Tracking Coverage Rate"
      expr: SUM(foukites_tracking_coverage_rate)
    - name: "Average Foukites Tracking Coverage Rate"
      expr: AVG(foukites_tracking_coverage_rate)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_network_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network Node business metrics"
  source: "`transport_shipping_ecm`.`route`.`network_node`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Aeo Certified"
      expr: aeo_certified
    - name: "Blue Yonder Node Code"
      expr: blue_yonder_node_code
    - name: "City Name"
      expr: city_name
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ctpat Certified"
      expr: ctpat_certified
    - name: "Customs Bonded"
      expr: customs_bonded
    - name: "Dg Handling Enabled"
      expr: dg_handling_enabled
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Folio Visibility Code"
      expr: folio_visibility_code
    - name: "Ftz Designation"
      expr: ftz_designation
    - name: "Hub Tier"
      expr: hub_tier
    - name: "Iata Code"
      expr: iata_code
    - name: "Icao Airport Code"
      expr: icao_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Network Node"
      expr: COUNT(DISTINCT network_node_id)
    - name: "Total Co2e Emission Factor"
      expr: SUM(co2e_emission_factor)
    - name: "Average Co2e Emission Factor"
      expr: AVG(co2e_emission_factor)
    - name: "Total Handling Capacity Cbm"
      expr: SUM(handling_capacity_cbm)
    - name: "Average Handling Capacity Cbm"
      expr: AVG(handling_capacity_cbm)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Weight Capacity Kg"
      expr: SUM(max_weight_capacity_kg)
    - name: "Average Max Weight Capacity Kg"
      expr: AVG(max_weight_capacity_kg)
    - name: "Total Storage Capacity Cbm"
      expr: SUM(storage_capacity_cbm)
    - name: "Average Storage Capacity Cbm"
      expr: AVG(storage_capacity_cbm)
    - name: "Total Temp Range Max Celsius"
      expr: SUM(temp_range_max_celsius)
    - name: "Average Temp Range Max Celsius"
      expr: AVG(temp_range_max_celsius)
    - name: "Total Temp Range Min Celsius"
      expr: SUM(temp_range_min_celsius)
    - name: "Average Temp Range Min Celsius"
      expr: AVG(temp_range_min_celsius)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan business metrics"
  source: "`transport_shipping_ecm`.`route`.`plan`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Confirmed Timestamp"
      expr: confirmed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Address"
      expr: destination_address
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Execution Start Timestamp"
      expr: execution_start_timestamp
    - name: "Incoterm"
      expr: incoterm
    - name: "Is Cross Border"
      expr: is_cross_border
    - name: "Is Hazmat"
      expr: is_hazmat
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Number Of Legs"
      expr: number_of_legs
    - name: "Number Of Stops"
      expr: number_of_stops
    - name: "Optimization Objective"
      expr: optimization_objective
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plan"
      expr: COUNT(DISTINCT plan_id)
    - name: "Total Planned Co2e Emissions Kg"
      expr: SUM(planned_co2e_emissions_kg)
    - name: "Average Planned Co2e Emissions Kg"
      expr: AVG(planned_co2e_emissions_kg)
    - name: "Total Planned Cost Amount"
      expr: SUM(planned_cost_amount)
    - name: "Average Planned Cost Amount"
      expr: AVG(planned_cost_amount)
    - name: "Total Total Planned Distance Km"
      expr: SUM(total_planned_distance_km)
    - name: "Average Total Planned Distance Km"
      expr: AVG(total_planned_distance_km)
    - name: "Total Total Planned Transit Time Hours"
      expr: SUM(total_planned_transit_time_hours)
    - name: "Average Total Planned Transit Time Hours"
      expr: AVG(total_planned_transit_time_hours)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_plan_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan Leg business metrics"
  source: "`transport_shipping_ecm`.`route`.`plan_leg`"
  dimensions:
    - name: "Actual Arrival Datetime"
      expr: actual_arrival_datetime
    - name: "Actual Departure Datetime"
      expr: actual_departure_datetime
    - name: "Booking Reference Number"
      expr: booking_reference_number
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Required Flag"
      expr: customs_clearance_required_flag
    - name: "Customs Clearance Status"
      expr: customs_clearance_status
    - name: "Delay Minutes"
      expr: delay_minutes
    - name: "Delay Reason Code"
      expr: delay_reason_code
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Flight Number"
      expr: flight_number
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Leg Sequence Number"
      expr: leg_sequence_number
    - name: "Leg Status"
      expr: leg_status
    - name: "Load Type"
      expr: load_type
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plan Leg"
      expr: COUNT(DISTINCT plan_leg_id)
    - name: "Total Actual Transit Hours"
      expr: SUM(actual_transit_hours)
    - name: "Average Actual Transit Hours"
      expr: AVG(actual_transit_hours)
    - name: "Total Carbon Emissions Kg"
      expr: SUM(carbon_emissions_kg)
    - name: "Average Carbon Emissions Kg"
      expr: AVG(carbon_emissions_kg)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Planned Transit Hours"
      expr: SUM(planned_transit_hours)
    - name: "Average Planned Transit Hours"
      expr: AVG(planned_transit_hours)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_route_delivery_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route Delivery Zone business metrics"
  source: "`transport_shipping_ecm`.`route`.`route_delivery_zone`"
  dimensions:
    - name: "Aeo Required"
      expr: aeo_required
    - name: "Applicable Service Products"
      expr: applicable_service_products
    - name: "Carrier Code"
      expr: carrier_code
    - name: "City Name"
      expr: city_name
    - name: "Cod Restricted"
      expr: cod_restricted
    - name: "Country Code"
      expr: country_code
    - name: "Coverage Geojson"
      expr: coverage_geojson
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Zone Type"
      expr: customs_zone_type
    - name: "Dg Restricted"
      expr: dg_restricted
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Hub Node Code"
      expr: hub_node_code
    - name: "Isf Required"
      expr: isf_required
    - name: "Oversized Restricted"
      expr: oversized_restricted
    - name: "Peak Surcharge"
      expr: peak_surcharge
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Route Delivery Zone"
      expr: COUNT(DISTINCT route_delivery_zone_id)
    - name: "Total Area Sqkm"
      expr: SUM(area_sqkm)
    - name: "Average Area Sqkm"
      expr: AVG(area_sqkm)
    - name: "Total Co2e Factor Kg Per Shipment"
      expr: SUM(co2e_factor_kg_per_shipment)
    - name: "Average Co2e Factor Kg Per Shipment"
      expr: AVG(co2e_factor_kg_per_shipment)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Dim Weight Kg"
      expr: SUM(max_dim_weight_kg)
    - name: "Average Max Dim Weight Kg"
      expr: AVG(max_dim_weight_kg)
    - name: "Total Max Length Cm"
      expr: SUM(max_length_cm)
    - name: "Average Max Length Cm"
      expr: AVG(max_length_cm)
    - name: "Total Max Weight Kg"
      expr: SUM(max_weight_kg)
    - name: "Average Max Weight Kg"
      expr: AVG(max_weight_kg)
    - name: "Total Otd Target Pct"
      expr: SUM(otd_target_pct)
    - name: "Average Otd Target Pct"
      expr: AVG(otd_target_pct)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_service_corridor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Corridor business metrics"
  source: "`transport_shipping_ecm`.`route`.`service_corridor`"
  dimensions:
    - name: "Awb Prefix"
      expr: awb_prefix
    - name: "Carrier Scac Codes"
      expr: carrier_scac_codes
    - name: "Corridor Code"
      expr: corridor_code
    - name: "Corridor Name"
      expr: corridor_name
    - name: "Corridor Status"
      expr: corridor_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Required"
      expr: customs_clearance_required
    - name: "Dangerous Goods Permitted"
      expr: dangerous_goods_permitted
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Hub Code"
      expr: destination_hub_code
    - name: "Destination Region"
      expr: destination_region
    - name: "Direction Type"
      expr: direction_type
    - name: "Edi Enabled"
      expr: edi_enabled
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Freight Product"
      expr: freight_product
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Corridor"
      expr: COUNT(DISTINCT service_corridor_id)
    - name: "Total Capacity Teu"
      expr: SUM(capacity_teu)
    - name: "Average Capacity Teu"
      expr: AVG(capacity_teu)
    - name: "Total Co2e Emission Factor"
      expr: SUM(co2e_emission_factor)
    - name: "Average Co2e Emission Factor"
      expr: AVG(co2e_emission_factor)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Max Volume Cbm"
      expr: SUM(max_volume_cbm)
    - name: "Average Max Volume Cbm"
      expr: AVG(max_volume_cbm)
    - name: "Total Max Weight Kg"
      expr: SUM(max_weight_kg)
    - name: "Average Max Weight Kg"
      expr: AVG(max_weight_kg)
    - name: "Total Network Design Code"
      expr: SUM(network_design_code)
    - name: "Average Network Design Code"
      expr: AVG(network_design_code)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`route_transit_time_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transit Time Standard business metrics"
  source: "`transport_shipping_ecm`.`route`.`transit_time_standard`"
  dimensions:
    - name: "Blue Yonder Standard Code"
      expr: blue_yonder_standard_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Days"
      expr: customs_clearance_days
    - name: "Cutoff Time"
      expr: cutoff_time
    - name: "Cutoff Timezone"
      expr: cutoff_timezone
    - name: "Delivery Timezone"
      expr: delivery_timezone
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Node Code"
      expr: destination_node_code
    - name: "Destination Node Type"
      expr: destination_node_type
    - name: "Destination Zone Code"
      expr: destination_zone_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "First Available Delivery Time"
      expr: first_available_delivery_time
    - name: "Frequency Type"
      expr: frequency_type
    - name: "Hazmat Applicable"
      expr: hazmat_applicable
    - name: "Hub Routing Required"
      expr: hub_routing_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transit Time Standard"
      expr: COUNT(DISTINCT transit_time_standard_id)
    - name: "Total Max Volume Cbm"
      expr: SUM(max_volume_cbm)
    - name: "Average Max Volume Cbm"
      expr: AVG(max_volume_cbm)
    - name: "Total Max Weight Kg"
      expr: SUM(max_weight_kg)
    - name: "Average Max Weight Kg"
      expr: AVG(max_weight_kg)
$$;