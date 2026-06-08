-- Metric views for domain: flight | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:49:14

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_acars_message`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Acars Message business metrics"
  source: "`airlines_ecm`.`flight`.`acars_message`"
  dimensions:
    - name: "Acknowledgement Required Flag"
      expr: acknowledgement_required_flag
    - name: "Acknowledgement Timestamp"
      expr: acknowledgement_timestamp
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Altitude Feet"
      expr: altitude_feet
    - name: "Arrival Airport Code"
      expr: arrival_airport_code
    - name: "Block Number"
      expr: block_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Link Service Provider"
      expr: data_link_service_provider
    - name: "Departure Airport Code"
      expr: departure_airport_code
    - name: "Error Code"
      expr: error_code
    - name: "Flight Phase"
      expr: flight_phase
    - name: "Ground Speed Knots"
      expr: ground_speed_knots
    - name: "Message Content"
      expr: message_content
    - name: "Message Direction"
      expr: message_direction
    - name: "Message Label"
      expr: message_label
    - name: "Message Sequence Number"
      expr: message_sequence_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Acars Message"
      expr: COUNT(DISTINCT acars_message_id)
    - name: "Total Position Latitude"
      expr: SUM(position_latitude)
    - name: "Average Position Latitude"
      expr: AVG(position_latitude)
    - name: "Total Position Longitude"
      expr: SUM(position_longitude)
    - name: "Average Position Longitude"
      expr: AVG(position_longitude)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_booking_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Segment business metrics"
  source: "`airlines_ecm`.`flight`.`booking_segment`"
  dimensions:
    - name: "Baggage Allowance"
      expr: baggage_allowance
    - name: "Boarding Sequence"
      expr: boarding_sequence
    - name: "Boarding Timestamp"
      expr: boarding_timestamp
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Check In Timestamp"
      expr: check_in_timestamp
    - name: "Fare Basis"
      expr: fare_basis
    - name: "Seat Assignment"
      expr: seat_assignment
    - name: "Segment Created Timestamp"
      expr: segment_created_timestamp
    - name: "Segment Status"
      expr: segment_status
    - name: "Segment Updated Timestamp"
      expr: segment_updated_timestamp
    - name: "Special Service Requests"
      expr: special_service_requests
    - name: "Standby Priority"
      expr: standby_priority
    - name: "Ticket Number"
      expr: ticket_number
    - name: "Upgrade Status"
      expr: upgrade_status
    - name: "Boarding Timestamp Month"
      expr: DATE_TRUNC('MONTH', boarding_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Segment"
      expr: COUNT(DISTINCT booking_segment_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation business metrics"
  source: "`airlines_ecm`.`flight`.`cancellation`"
  dimensions:
    - name: "Affected Passenger Count"
      expr: affected_passenger_count
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Atc Restriction Type"
      expr: atc_restriction_type
    - name: "Cancellation Type"
      expr: cancellation_type
    - name: "Compensation Eligibility Status"
      expr: compensation_eligibility_status
    - name: "Crew Legality Issue"
      expr: crew_legality_issue
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Effective Timestamp"
      expr: effective_timestamp
    - name: "First Notification Timestamp"
      expr: first_notification_timestamp
    - name: "Is Controllable"
      expr: is_controllable
    - name: "Is Dot Reportable"
      expr: is_dot_reportable
    - name: "Maintenance Defect Code"
      expr: maintenance_defect_code
    - name: "Network Optimization Flag"
      expr: network_optimization_flag
    - name: "Notification Method"
      expr: notification_method
    - name: "Occ Remarks"
      expr: occ_remarks
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cancellation"
      expr: COUNT(DISTINCT cancellation_id)
    - name: "Total Advance Notice Hours"
      expr: SUM(advance_notice_hours)
    - name: "Average Advance Notice Hours"
      expr: AVG(advance_notice_hours)
    - name: "Total Compensation Amount Per Passenger"
      expr: SUM(compensation_amount_per_passenger)
    - name: "Average Compensation Amount Per Passenger"
      expr: AVG(compensation_amount_per_passenger)
    - name: "Total Estimated Revenue Impact Amount"
      expr: SUM(estimated_revenue_impact_amount)
    - name: "Average Estimated Revenue Impact Amount"
      expr: AVG(estimated_revenue_impact_amount)
    - name: "Total Passenger Care Cost Amount"
      expr: SUM(passenger_care_cost_amount)
    - name: "Average Passenger Care Cost Amount"
      expr: AVG(passenger_care_cost_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_cargo_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo Segment business metrics"
  source: "`airlines_ecm`.`flight`.`cargo_segment`"
  dimensions:
    - name: "Compartment Code"
      expr: compartment_code
    - name: "Handling Station Code"
      expr: handling_station_code
    - name: "Loaded Timestamp"
      expr: loaded_timestamp
    - name: "Loading Priority"
      expr: loading_priority
    - name: "Manifested Timestamp"
      expr: manifested_timestamp
    - name: "Offloaded Timestamp"
      expr: offloaded_timestamp
    - name: "Segment Sequence"
      expr: segment_sequence
    - name: "Segment Status"
      expr: segment_status
    - name: "Transfer Timestamp"
      expr: transfer_timestamp
    - name: "Uld Number"
      expr: uld_number
    - name: "Loaded Timestamp Month"
      expr: DATE_TRUNC('MONTH', loaded_timestamp)
    - name: "Manifested Timestamp Month"
      expr: DATE_TRUNC('MONTH', manifested_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cargo Segment"
      expr: COUNT(DISTINCT cargo_segment_id)
    - name: "Total Proration Factor"
      expr: SUM(proration_factor)
    - name: "Average Proration Factor"
      expr: AVG(proration_factor)
    - name: "Total Segment Chargeable Weight Kg"
      expr: SUM(segment_chargeable_weight_kg)
    - name: "Average Segment Chargeable Weight Kg"
      expr: AVG(segment_chargeable_weight_kg)
    - name: "Total Segment Weight Kg"
      expr: SUM(segment_weight_kg)
    - name: "Average Segment Weight Kg"
      expr: AVG(segment_weight_kg)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_codeshare_flight_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Codeshare Flight Execution business metrics"
  source: "`airlines_ecm`.`flight`.`codeshare_flight_execution`"
  dimensions:
    - name: "Codeshare Flight Number Used"
      expr: codeshare_flight_number_used
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Execution Status"
      expr: execution_status
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Partner Notification Timestamp"
      expr: partner_notification_timestamp
    - name: "Passenger Count"
      expr: passenger_count
    - name: "Prorate Calculation Basis"
      expr: prorate_calculation_basis
    - name: "Seat Allocation Count"
      expr: seat_allocation_count
    - name: "Settlement Status"
      expr: settlement_status
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Codeshare Flight Execution"
      expr: COUNT(DISTINCT codeshare_flight_execution_id)
    - name: "Total Revenue Share Amount"
      expr: SUM(revenue_share_amount)
    - name: "Average Revenue Share Amount"
      expr: AVG(revenue_share_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_delay_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delay Record business metrics"
  source: "`airlines_ecm`.`flight`.`delay_record`"
  dimensions:
    - name: "Affected Passenger Count"
      expr: affected_passenger_count
    - name: "Compensation Issued Flag"
      expr: compensation_issued_flag
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Data Source System"
      expr: data_source_system
    - name: "Delay Category"
      expr: delay_category
    - name: "Delay Description"
      expr: delay_description
    - name: "Delay Duration Minutes"
      expr: delay_duration_minutes
    - name: "Delay End Timestamp"
      expr: delay_end_timestamp
    - name: "Delay Notification Sent Timestamp"
      expr: delay_notification_sent_timestamp
    - name: "Delay Sequence Number"
      expr: delay_sequence_number
    - name: "Delay Start Timestamp"
      expr: delay_start_timestamp
    - name: "Delay Status"
      expr: delay_status
    - name: "Delay Verification Timestamp"
      expr: delay_verification_timestamp
    - name: "Is Controllable Delay"
      expr: is_controllable_delay
    - name: "Is Reactionary Delay"
      expr: is_reactionary_delay
    - name: "Is Reportable To Dot"
      expr: is_reportable_to_dot
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delay Record"
      expr: COUNT(DISTINCT delay_record_id)
    - name: "Total Delay Cost Estimate Usd"
      expr: SUM(delay_cost_estimate_usd)
    - name: "Average Delay Cost Estimate Usd"
      expr: AVG(delay_cost_estimate_usd)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_dispatch_exemption_invocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch Exemption Invocation business metrics"
  source: "`airlines_ecm`.`flight`.`dispatch_exemption_invocation`"
  dimensions:
    - name: "Applicability Justification"
      expr: applicability_justification
    - name: "Application Timestamp"
      expr: application_timestamp
    - name: "Approval Status"
      expr: approval_status
    - name: "Condition Compliance Notes"
      expr: condition_compliance_notes
    - name: "Conditions Accepted Flag"
      expr: conditions_accepted_flag
    - name: "Dispatcher Acknowledgment"
      expr: dispatcher_acknowledgment
    - name: "Expiry Verification Timestamp"
      expr: expiry_verification_timestamp
    - name: "Invocation Sequence Number"
      expr: invocation_sequence_number
    - name: "Application Timestamp Month"
      expr: DATE_TRUNC('MONTH', application_timestamp)
    - name: "Expiry Verification Timestamp Month"
      expr: DATE_TRUNC('MONTH', expiry_verification_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispatch Exemption Invocation"
      expr: COUNT(DISTINCT dispatch_exemption_invocation_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_dispatch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch Release business metrics"
  source: "`airlines_ecm`.`flight`.`dispatch_release`"
  dimensions:
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Aircraft Type"
      expr: aircraft_type
    - name: "Alternate Airport 1 Icao"
      expr: alternate_airport_1_icao
    - name: "Alternate Airport 2 Icao"
      expr: alternate_airport_2_icao
    - name: "Captain Name"
      expr: captain_name
    - name: "Captain Signoff Timestamp"
      expr: captain_signoff_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Departure Airport Icao"
      expr: departure_airport_icao
    - name: "Departure Metar"
      expr: departure_metar
    - name: "Destination Airport Icao"
      expr: destination_airport_icao
    - name: "Destination Metar"
      expr: destination_metar
    - name: "Destination Taf"
      expr: destination_taf
    - name: "Dispatcher License Number"
      expr: dispatcher_license_number
    - name: "Dispatcher Name"
      expr: dispatcher_name
    - name: "Dispatcher Signoff Timestamp"
      expr: dispatcher_signoff_timestamp
    - name: "Estimated Block Time Minutes"
      expr: estimated_block_time_minutes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispatch Release"
      expr: COUNT(DISTINCT dispatch_release_id)
    - name: "Total Additional Fuel Kg"
      expr: SUM(additional_fuel_kg)
    - name: "Average Additional Fuel Kg"
      expr: AVG(additional_fuel_kg)
    - name: "Total Alternate Fuel Kg"
      expr: SUM(alternate_fuel_kg)
    - name: "Average Alternate Fuel Kg"
      expr: AVG(alternate_fuel_kg)
    - name: "Total Cargo Weight Kg"
      expr: SUM(cargo_weight_kg)
    - name: "Average Cargo Weight Kg"
      expr: AVG(cargo_weight_kg)
    - name: "Total Contingency Fuel Kg"
      expr: SUM(contingency_fuel_kg)
    - name: "Average Contingency Fuel Kg"
      expr: AVG(contingency_fuel_kg)
    - name: "Total Final Reserve Fuel Kg"
      expr: SUM(final_reserve_fuel_kg)
    - name: "Average Final Reserve Fuel Kg"
      expr: AVG(final_reserve_fuel_kg)
    - name: "Total Landing Weight Kg"
      expr: SUM(landing_weight_kg)
    - name: "Average Landing Weight Kg"
      expr: AVG(landing_weight_kg)
    - name: "Total Minimum Fuel Kg"
      expr: SUM(minimum_fuel_kg)
    - name: "Average Minimum Fuel Kg"
      expr: AVG(minimum_fuel_kg)
    - name: "Total Planned Fuel Uplift Kg"
      expr: SUM(planned_fuel_uplift_kg)
    - name: "Average Planned Fuel Uplift Kg"
      expr: AVG(planned_fuel_uplift_kg)
    - name: "Total Takeoff Weight Kg"
      expr: SUM(takeoff_weight_kg)
    - name: "Average Takeoff Weight Kg"
      expr: AVG(takeoff_weight_kg)
    - name: "Total Trip Fuel Kg"
      expr: SUM(trip_fuel_kg)
    - name: "Average Trip Fuel Kg"
      expr: AVG(trip_fuel_kg)
    - name: "Total Zero Fuel Weight Kg"
      expr: SUM(zero_fuel_weight_kg)
    - name: "Average Zero Fuel Weight Kg"
      expr: AVG(zero_fuel_weight_kg)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_diversion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diversion business metrics"
  source: "`airlines_ecm`.`flight`.`diversion`"
  dimensions:
    - name: "Actual Gate Arrival Timestamp"
      expr: actual_gate_arrival_timestamp
    - name: "Actual Landing Timestamp"
      expr: actual_landing_timestamp
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Airport Icao Code"
      expr: airport_icao_code
    - name: "Atc Coordination Reference"
      expr: atc_coordination_reference
    - name: "Compensation Eligibility Flag"
      expr: compensation_eligibility_flag
    - name: "Continuation Departure Timestamp"
      expr: continuation_departure_timestamp
    - name: "Continuation Flight Number"
      expr: continuation_flight_number
    - name: "Cost Impact Currency Code"
      expr: cost_impact_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Duty Time Impact Flag"
      expr: crew_duty_time_impact_flag
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Dispatch Release Updated Flag"
      expr: dispatch_release_updated_flag
    - name: "Disposition Action"
      expr: disposition_action
    - name: "Diversion Number"
      expr: diversion_number
    - name: "Diversion Status"
      expr: diversion_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Diversion"
      expr: COUNT(DISTINCT diversion_id)
    - name: "Total Estimated Cost Impact Amount"
      expr: SUM(estimated_cost_impact_amount)
    - name: "Average Estimated Cost Impact Amount"
      expr: AVG(estimated_cost_impact_amount)
    - name: "Total Fuel Uplift At Diversion Kg"
      expr: SUM(fuel_uplift_at_diversion_kg)
    - name: "Average Fuel Uplift At Diversion Kg"
      expr: AVG(fuel_uplift_at_diversion_kg)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_flight_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Allotment business metrics"
  source: "`airlines_ecm`.`flight`.`flight_allotment`"
  dimensions:
    - name: "Allotment Status"
      expr: allotment_status
    - name: "Created Date"
      expr: created_date
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Priority Level"
      expr: priority_level
    - name: "Rate Class"
      expr: rate_class
    - name: "Validity End Date"
      expr: validity_end_date
    - name: "Validity Start Date"
      expr: validity_start_date
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Last Modified Date Month"
      expr: DATE_TRUNC('MONTH', last_modified_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Allotment"
      expr: COUNT(DISTINCT flight_allotment_id)
    - name: "Total Allocated Volume Cbm"
      expr: SUM(allocated_volume_cbm)
    - name: "Average Allocated Volume Cbm"
      expr: AVG(allocated_volume_cbm)
    - name: "Total Allocated Weight Kg"
      expr: SUM(allocated_weight_kg)
    - name: "Average Allocated Weight Kg"
      expr: AVG(allocated_weight_kg)
    - name: "Total Minimum Utilization Threshold Pct"
      expr: SUM(minimum_utilization_threshold_pct)
    - name: "Average Minimum Utilization Threshold Pct"
      expr: AVG(minimum_utilization_threshold_pct)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_flight_irop_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Irop Event business metrics"
  source: "`airlines_ecm`.`flight`.`flight_irop_event`"
  dimensions:
    - name: "Actual Passengers Affected"
      expr: actual_passengers_affected
    - name: "Actual Total Delay Minutes"
      expr: actual_total_delay_minutes
    - name: "Additional Affected Stations"
      expr: additional_affected_stations
    - name: "Atc Coordination Notes"
      expr: atc_coordination_notes
    - name: "Cdm Session Reference"
      expr: cdm_session_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Estimated Passengers Affected"
      expr: estimated_passengers_affected
    - name: "Estimated Total Delay Minutes"
      expr: estimated_total_delay_minutes
    - name: "Event Code"
      expr: event_code
    - name: "Event Description"
      expr: event_description
    - name: "Event End Timestamp"
      expr: event_end_timestamp
    - name: "Event Start Timestamp"
      expr: event_start_timestamp
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Flights Cancelled Count"
      expr: flights_cancelled_count
    - name: "Flights Delayed Count"
      expr: flights_delayed_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Irop Event"
      expr: COUNT(DISTINCT flight_irop_event_id)
    - name: "Total Estimated Financial Impact Amount"
      expr: SUM(estimated_financial_impact_amount)
    - name: "Average Estimated Financial Impact Amount"
      expr: AVG(estimated_financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_flight_leg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Leg business metrics"
  source: "`airlines_ecm`.`flight`.`flight_leg`"
  dimensions:
    - name: "Actual Arrival Time"
      expr: actual_arrival_time
    - name: "Actual Departure Time"
      expr: actual_departure_time
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Arrival Terminal"
      expr: arrival_terminal
    - name: "Cabin Configuration Code"
      expr: cabin_configuration_code
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Delay Code"
      expr: delay_code
    - name: "Delay Minutes"
      expr: delay_minutes
    - name: "Departure Terminal"
      expr: departure_terminal
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Dispatch Release Number"
      expr: dispatch_release_number
    - name: "Diversion Airport Code"
      expr: diversion_airport_code
    - name: "Estimated Arrival Time"
      expr: estimated_arrival_time
    - name: "Estimated Departure Time"
      expr: estimated_departure_time
    - name: "Flight Number"
      expr: flight_number
    - name: "Flight Status"
      expr: flight_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Leg"
      expr: COUNT(DISTINCT flight_leg_id)
    - name: "Total Airborne Time Hours"
      expr: SUM(airborne_time_hours)
    - name: "Average Airborne Time Hours"
      expr: AVG(airborne_time_hours)
    - name: "Total Block Hours"
      expr: SUM(block_hours)
    - name: "Average Block Hours"
      expr: AVG(block_hours)
    - name: "Total Fuel Uplift Kg"
      expr: SUM(fuel_uplift_kg)
    - name: "Average Fuel Uplift Kg"
      expr: AVG(fuel_uplift_kg)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_flight_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Performance business metrics"
  source: "`airlines_ecm`.`flight`.`flight_performance`"
  dimensions:
    - name: "Actual Block Time Minutes"
      expr: actual_block_time_minutes
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Anomaly Description"
      expr: anomaly_description
    - name: "Anomaly Flag"
      expr: anomaly_flag
    - name: "Atc Delay Minutes"
      expr: atc_delay_minutes
    - name: "Average Ground Speed Knots"
      expr: average_ground_speed_knots
    - name: "Block Time Variance Minutes"
      expr: block_time_variance_minutes
    - name: "Corsia Eligible Flag"
      expr: corsia_eligible_flag
    - name: "Cruise Altitude Feet"
      expr: cruise_altitude_feet
    - name: "Data Source"
      expr: data_source
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Flight Number"
      expr: flight_number
    - name: "Flight Phase Coverage"
      expr: flight_phase_coverage
    - name: "Operating Date"
      expr: operating_date
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Performance Category"
      expr: performance_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Performance"
      expr: COUNT(DISTINCT flight_performance_id)
    - name: "Total Actual Fuel Burn Kg"
      expr: SUM(actual_fuel_burn_kg)
    - name: "Average Actual Fuel Burn Kg"
      expr: AVG(actual_fuel_burn_kg)
    - name: "Total Average Cruise Speed Mach"
      expr: SUM(average_cruise_speed_mach)
    - name: "Average Average Cruise Speed Mach"
      expr: AVG(average_cruise_speed_mach)
    - name: "Total Co2 Emissions Kg"
      expr: SUM(co2_emissions_kg)
    - name: "Average Co2 Emissions Kg"
      expr: AVG(co2_emissions_kg)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Engine 1 Avg Egt Celsius"
      expr: SUM(engine_1_avg_egt_celsius)
    - name: "Average Engine 1 Avg Egt Celsius"
      expr: AVG(engine_1_avg_egt_celsius)
    - name: "Total Engine 1 Avg Fuel Flow Kg Per Hour"
      expr: SUM(engine_1_avg_fuel_flow_kg_per_hour)
    - name: "Average Engine 1 Avg Fuel Flow Kg Per Hour"
      expr: AVG(engine_1_avg_fuel_flow_kg_per_hour)
    - name: "Total Engine 1 Avg N1 Percent"
      expr: SUM(engine_1_avg_n1_percent)
    - name: "Average Engine 1 Avg N1 Percent"
      expr: AVG(engine_1_avg_n1_percent)
    - name: "Total Engine 2 Avg Egt Celsius"
      expr: SUM(engine_2_avg_egt_celsius)
    - name: "Average Engine 2 Avg Egt Celsius"
      expr: AVG(engine_2_avg_egt_celsius)
    - name: "Total Engine 2 Avg Fuel Flow Kg Per Hour"
      expr: SUM(engine_2_avg_fuel_flow_kg_per_hour)
    - name: "Average Engine 2 Avg Fuel Flow Kg Per Hour"
      expr: AVG(engine_2_avg_fuel_flow_kg_per_hour)
    - name: "Total Engine 2 Avg N1 Percent"
      expr: SUM(engine_2_avg_n1_percent)
    - name: "Average Engine 2 Avg N1 Percent"
      expr: AVG(engine_2_avg_n1_percent)
    - name: "Total Fuel Efficiency Index"
      expr: SUM(fuel_efficiency_index)
    - name: "Average Fuel Efficiency Index"
      expr: AVG(fuel_efficiency_index)
    - name: "Total Fuel Variance Kg"
      expr: SUM(fuel_variance_kg)
    - name: "Average Fuel Variance Kg"
      expr: AVG(fuel_variance_kg)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_flight_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Plan business metrics"
  source: "`airlines_ecm`.`flight`.`flight_plan`"
  dimensions:
    - name: "Additional Fuel Kg"
      expr: additional_fuel_kg
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Alternate Airport 1 Icao"
      expr: alternate_airport_1_icao
    - name: "Alternate Airport 2 Icao"
      expr: alternate_airport_2_icao
    - name: "Alternate Fuel Kg"
      expr: alternate_fuel_kg
    - name: "Arrival Airport Icao"
      expr: arrival_airport_icao
    - name: "Contingency Fuel Kg"
      expr: contingency_fuel_kg
    - name: "Cost Index"
      expr: cost_index
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cruise Altitude Ft"
      expr: cruise_altitude_ft
    - name: "Cruise Speed Kts"
      expr: cruise_speed_kts
    - name: "Departure Airport Icao"
      expr: departure_airport_icao
    - name: "Etops Entry Point"
      expr: etops_entry_point
    - name: "Etops Exit Point"
      expr: etops_exit_point
    - name: "Etops Qualified Flag"
      expr: etops_qualified_flag
    - name: "Filed Timestamp"
      expr: filed_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Plan"
      expr: COUNT(DISTINCT flight_plan_id)
    - name: "Total Planned Block Hours"
      expr: SUM(planned_block_hours)
    - name: "Average Planned Block Hours"
      expr: AVG(planned_block_hours)
    - name: "Total Planned Flight Time Hours"
      expr: SUM(planned_flight_time_hours)
    - name: "Average Planned Flight Time Hours"
      expr: AVG(planned_flight_time_hours)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_fuel_uplift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel Uplift business metrics"
  source: "`airlines_ecm`.`flight`.`fuel_uplift`"
  dimensions:
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fuel Batch Number"
      expr: fuel_batch_number
    - name: "Fuel Price Currency"
      expr: fuel_price_currency
    - name: "Fuel Quality Certificate Number"
      expr: fuel_quality_certificate_number
    - name: "Fuel Ticket Number"
      expr: fuel_ticket_number
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Fuel Uplift Status"
      expr: fuel_uplift_status
    - name: "Fueling Duration Minutes"
      expr: fueling_duration_minutes
    - name: "Fueling Start Timestamp"
      expr: fueling_start_timestamp
    - name: "Fueling Timestamp"
      expr: fueling_timestamp
    - name: "Into Plane Agent"
      expr: into_plane_agent
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Payment Method"
      expr: payment_method
    - name: "Remarks"
      expr: remarks
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fuel Uplift"
      expr: COUNT(DISTINCT fuel_uplift_id)
    - name: "Total Carbon Emission Kg"
      expr: SUM(carbon_emission_kg)
    - name: "Average Carbon Emission Kg"
      expr: AVG(carbon_emission_kg)
    - name: "Total Fuel Density"
      expr: SUM(fuel_density)
    - name: "Average Fuel Density"
      expr: AVG(fuel_density)
    - name: "Total Fuel Price Per Unit"
      expr: SUM(fuel_price_per_unit)
    - name: "Average Fuel Price Per Unit"
      expr: AVG(fuel_price_per_unit)
    - name: "Total Fuel Quantity Kg"
      expr: SUM(fuel_quantity_kg)
    - name: "Average Fuel Quantity Kg"
      expr: AVG(fuel_quantity_kg)
    - name: "Total Fuel Quantity Lbs"
      expr: SUM(fuel_quantity_lbs)
    - name: "Average Fuel Quantity Lbs"
      expr: AVG(fuel_quantity_lbs)
    - name: "Total Fuel Quantity Litres"
      expr: SUM(fuel_quantity_litres)
    - name: "Average Fuel Quantity Litres"
      expr: AVG(fuel_quantity_litres)
    - name: "Total Fuel Surcharge Amount"
      expr: SUM(fuel_surcharge_amount)
    - name: "Average Fuel Surcharge Amount"
      expr: AVG(fuel_surcharge_amount)
    - name: "Total Fuel Temperature Celsius"
      expr: SUM(fuel_temperature_celsius)
    - name: "Average Fuel Temperature Celsius"
      expr: AVG(fuel_temperature_celsius)
    - name: "Total Post Fueling Quantity Kg"
      expr: SUM(post_fueling_quantity_kg)
    - name: "Average Post Fueling Quantity Kg"
      expr: AVG(post_fueling_quantity_kg)
    - name: "Total Pre Fueling Quantity Kg"
      expr: SUM(pre_fueling_quantity_kg)
    - name: "Average Pre Fueling Quantity Kg"
      expr: AVG(pre_fueling_quantity_kg)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Fuel Cost"
      expr: SUM(total_fuel_cost)
    - name: "Average Total Fuel Cost"
      expr: AVG(total_fuel_cost)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_oooi_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Oooi Event business metrics"
  source: "`airlines_ecm`.`flight`.`oooi_event`"
  dimensions:
    - name: "Acars Message Label"
      expr: acars_message_label
    - name: "Acars Message Number"
      expr: acars_message_number
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Airport Code"
      expr: airport_code
    - name: "Altitude Feet"
      expr: altitude_feet
    - name: "Correction Reason"
      expr: correction_reason
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Data Source"
      expr: data_source
    - name: "Delay Code"
      expr: delay_code
    - name: "Delay Minutes"
      expr: delay_minutes
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Timestamp Local"
      expr: event_timestamp_local
    - name: "Event Type"
      expr: event_type
    - name: "Flight Number"
      expr: flight_number
    - name: "Gate Stand"
      expr: gate_stand
    - name: "Ground Speed Knots"
      expr: ground_speed_knots
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Oooi Event"
      expr: COUNT(DISTINCT oooi_event_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_operational_flight_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational Flight Plan business metrics"
  source: "`airlines_ecm`.`flight`.`operational_flight_plan`"
  dimensions:
    - name: "Alternate Airport 1 Code"
      expr: alternate_airport_1_code
    - name: "Alternate Airport 2 Code"
      expr: alternate_airport_2_code
    - name: "Cost Index"
      expr: cost_index
    - name: "Crew Accepted Timestamp"
      expr: crew_accepted_timestamp
    - name: "Estimated Block Time Minutes"
      expr: estimated_block_time_minutes
    - name: "Estimated Time Enroute Minutes"
      expr: estimated_time_enroute_minutes
    - name: "Etops Alternate Code"
      expr: etops_alternate_code
    - name: "Etops Approval Indicator"
      expr: etops_approval_indicator
    - name: "Etops Rule Time Minutes"
      expr: etops_rule_time_minutes
    - name: "Flight Planning System Code"
      expr: flight_planning_system_code
    - name: "Minimum Equipment List Items"
      expr: minimum_equipment_list_items
    - name: "Notam Summary"
      expr: notam_summary
    - name: "Ofp Version Number"
      expr: ofp_version_number
    - name: "Plan Generated Timestamp"
      expr: plan_generated_timestamp
    - name: "Plan Status"
      expr: plan_status
    - name: "Planned Cruise Altitude Ft"
      expr: planned_cruise_altitude_ft
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Operational Flight Plan"
      expr: COUNT(DISTINCT operational_flight_plan_id)
    - name: "Total Additional Fuel Kg"
      expr: SUM(additional_fuel_kg)
    - name: "Average Additional Fuel Kg"
      expr: AVG(additional_fuel_kg)
    - name: "Total Alternate Fuel Kg"
      expr: SUM(alternate_fuel_kg)
    - name: "Average Alternate Fuel Kg"
      expr: AVG(alternate_fuel_kg)
    - name: "Total Contingency Fuel Kg"
      expr: SUM(contingency_fuel_kg)
    - name: "Average Contingency Fuel Kg"
      expr: AVG(contingency_fuel_kg)
    - name: "Total Final Reserve Fuel Kg"
      expr: SUM(final_reserve_fuel_kg)
    - name: "Average Final Reserve Fuel Kg"
      expr: AVG(final_reserve_fuel_kg)
    - name: "Total Planned Cruise Speed Mach"
      expr: SUM(planned_cruise_speed_mach)
    - name: "Average Planned Cruise Speed Mach"
      expr: AVG(planned_cruise_speed_mach)
    - name: "Total Planned Landing Weight Kg"
      expr: SUM(planned_landing_weight_kg)
    - name: "Average Planned Landing Weight Kg"
      expr: AVG(planned_landing_weight_kg)
    - name: "Total Planned Takeoff Weight Kg"
      expr: SUM(planned_takeoff_weight_kg)
    - name: "Average Planned Takeoff Weight Kg"
      expr: AVG(planned_takeoff_weight_kg)
    - name: "Total Taxi Fuel Kg"
      expr: SUM(taxi_fuel_kg)
    - name: "Average Taxi Fuel Kg"
      expr: AVG(taxi_fuel_kg)
    - name: "Total Total Fuel Required Kg"
      expr: SUM(total_fuel_required_kg)
    - name: "Average Total Fuel Required Kg"
      expr: AVG(total_fuel_required_kg)
    - name: "Total Trip Fuel Kg"
      expr: SUM(trip_fuel_kg)
    - name: "Average Trip Fuel Kg"
      expr: AVG(trip_fuel_kg)
    - name: "Total Zero Fuel Weight Kg"
      expr: SUM(zero_fuel_weight_kg)
    - name: "Average Zero Fuel Weight Kg"
      expr: AVG(zero_fuel_weight_kg)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_scheduled_flight`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduled Flight business metrics"
  source: "`airlines_ecm`.`flight`.`scheduled_flight`"
  dimensions:
    - name: "Aircraft Configuration Code"
      expr: aircraft_configuration_code
    - name: "Arrival Airport Code"
      expr: arrival_airport_code
    - name: "Arrival Terminal"
      expr: arrival_terminal
    - name: "Block Time Minutes"
      expr: block_time_minutes
    - name: "Codeshare Indicator"
      expr: codeshare_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week Pattern"
      expr: day_of_week_pattern
    - name: "Departure Airport Code"
      expr: departure_airport_code
    - name: "Departure Terminal"
      expr: departure_terminal
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective Until Date"
      expr: effective_until_date
    - name: "Etops Approval Indicator"
      expr: etops_approval_indicator
    - name: "Flight Number"
      expr: flight_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Marketing Carrier Code"
      expr: marketing_carrier_code
    - name: "Meal Service Code"
      expr: meal_service_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Scheduled Flight"
      expr: COUNT(DISTINCT scheduled_flight_id)
    - name: "Total Flight Distance Km"
      expr: SUM(flight_distance_km)
    - name: "Average Flight Distance Km"
      expr: AVG(flight_distance_km)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Status business metrics"
  source: "`airlines_ecm`.`flight`.`status`"
  dimensions:
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Altitude Feet"
      expr: altitude_feet
    - name: "Arrival Gate"
      expr: arrival_gate
    - name: "Atc Slot Time"
      expr: atc_slot_time
    - name: "Boarding Start Time"
      expr: boarding_start_time
    - name: "Boarding Status"
      expr: boarding_status
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Delay Minutes"
      expr: delay_minutes
    - name: "Delay Reason Code"
      expr: delay_reason_code
    - name: "Departure Gate"
      expr: departure_gate
    - name: "Diversion Airport Code"
      expr: diversion_airport_code
    - name: "Estimated Arrival Time"
      expr: estimated_arrival_time
    - name: "Estimated Departure Time"
      expr: estimated_departure_time
    - name: "Fids Published Flag"
      expr: fids_published_flag
    - name: "Flight Phase"
      expr: flight_phase
    - name: "Gate Closure Time"
      expr: gate_closure_time
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Status"
      expr: COUNT(DISTINCT status_id)
    - name: "Total Position Latitude"
      expr: SUM(position_latitude)
    - name: "Average Position Latitude"
      expr: AVG(position_latitude)
    - name: "Total Position Longitude"
      expr: SUM(position_longitude)
    - name: "Average Position Longitude"
      expr: AVG(position_longitude)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`flight_weight_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weight Balance business metrics"
  source: "`airlines_ecm`.`flight`.`weight_balance`"
  dimensions:
    - name: "Aircraft Registration"
      expr: aircraft_registration
    - name: "Aircraft Type Code"
      expr: aircraft_type_code
    - name: "Captain Acceptance Signature"
      expr: captain_acceptance_signature
    - name: "Captain Acceptance Timestamp"
      expr: captain_acceptance_timestamp
    - name: "Dispatcher License Number"
      expr: dispatcher_license_number
    - name: "Dispatcher Name"
      expr: dispatcher_name
    - name: "Finalized Timestamp"
      expr: finalized_timestamp
    - name: "Load Distribution Compliant"
      expr: load_distribution_compliant
    - name: "Loadmaster License Number"
      expr: loadmaster_license_number
    - name: "Loadmaster Name"
      expr: loadmaster_name
    - name: "Loadsheet Number"
      expr: loadsheet_number
    - name: "Loadsheet Status"
      expr: loadsheet_status
    - name: "Loadsheet Version"
      expr: loadsheet_version
    - name: "Passenger Count Business"
      expr: passenger_count_business
    - name: "Passenger Count Economy"
      expr: passenger_count_economy
    - name: "Passenger Count First"
      expr: passenger_count_first
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Weight Balance"
      expr: COUNT(DISTINCT weight_balance_id)
    - name: "Total Baggage Weight Kg"
      expr: SUM(baggage_weight_kg)
    - name: "Average Baggage Weight Kg"
      expr: AVG(baggage_weight_kg)
    - name: "Total Cargo Weight Kg"
      expr: SUM(cargo_weight_kg)
    - name: "Average Cargo Weight Kg"
      expr: AVG(cargo_weight_kg)
    - name: "Total Cg Aft Limit Percent Mac"
      expr: SUM(cg_aft_limit_percent_mac)
    - name: "Average Cg Aft Limit Percent Mac"
      expr: AVG(cg_aft_limit_percent_mac)
    - name: "Total Cg Forward Limit Percent Mac"
      expr: SUM(cg_forward_limit_percent_mac)
    - name: "Average Cg Forward Limit Percent Mac"
      expr: AVG(cg_forward_limit_percent_mac)
    - name: "Total Cg Landing Percent Mac"
      expr: SUM(cg_landing_percent_mac)
    - name: "Average Cg Landing Percent Mac"
      expr: AVG(cg_landing_percent_mac)
    - name: "Total Cg Takeoff Percent Mac"
      expr: SUM(cg_takeoff_percent_mac)
    - name: "Average Cg Takeoff Percent Mac"
      expr: AVG(cg_takeoff_percent_mac)
    - name: "Total Dry Operating Weight Kg"
      expr: SUM(dry_operating_weight_kg)
    - name: "Average Dry Operating Weight Kg"
      expr: AVG(dry_operating_weight_kg)
    - name: "Total Hold Aft Weight Kg"
      expr: SUM(hold_aft_weight_kg)
    - name: "Average Hold Aft Weight Kg"
      expr: AVG(hold_aft_weight_kg)
    - name: "Total Hold Bulk Weight Kg"
      expr: SUM(hold_bulk_weight_kg)
    - name: "Average Hold Bulk Weight Kg"
      expr: AVG(hold_bulk_weight_kg)
    - name: "Total Hold Forward Weight Kg"
      expr: SUM(hold_forward_weight_kg)
    - name: "Average Hold Forward Weight Kg"
      expr: AVG(hold_forward_weight_kg)
    - name: "Total Landing Weight Kg"
      expr: SUM(landing_weight_kg)
    - name: "Average Landing Weight Kg"
      expr: AVG(landing_weight_kg)
    - name: "Total Mail Weight Kg"
      expr: SUM(mail_weight_kg)
    - name: "Average Mail Weight Kg"
      expr: AVG(mail_weight_kg)
$$;