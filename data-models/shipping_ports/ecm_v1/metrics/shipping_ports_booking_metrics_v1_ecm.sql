-- Metric views for domain: booking | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:38:30

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amendment business metrics"
  source: "`shipping_ports_ecm`.`booking`.`amendment`"
  dimensions:
    - name: "Amendment Number"
      expr: amendment_number
    - name: "Amendment Status"
      expr: amendment_status
    - name: "Amendment Type"
      expr: amendment_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Booking Entity Type"
      expr: booking_entity_type
    - name: "Cancellation Fee Applicable"
      expr: cancellation_fee_applicable
    - name: "Cancellation Fee Currency"
      expr: cancellation_fee_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Demurrage Impact Flag"
      expr: demurrage_impact_flag
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reference Number"
      expr: dispute_reference_number
    - name: "Edi Message Type"
      expr: edi_message_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Field Name Amended"
      expr: field_name_amended
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
    - name: "Notification Timestamp"
      expr: notification_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Amendment"
      expr: COUNT(DISTINCT amendment_id)
    - name: "Total Cancellation Fee Amount"
      expr: SUM(cancellation_fee_amount)
    - name: "Average Cancellation Fee Amount"
      expr: AVG(cancellation_fee_amount)
    - name: "Total Original Value"
      expr: SUM(original_value)
    - name: "Average Original Value"
      expr: AVG(original_value)
    - name: "Total Revised Value"
      expr: SUM(revised_value)
    - name: "Average Revised Value"
      expr: AVG(revised_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_booking_anchorage_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Anchorage Booking business metrics"
  source: "`shipping_ports_ecm`.`booking`.`booking_anchorage_booking`"
  dimensions:
    - name: "Actual Anchor Drop Time"
      expr: actual_anchor_drop_time
    - name: "Actual Weigh Anchor Time"
      expr: actual_weigh_anchor_time
    - name: "Anchorage Charge Currency"
      expr: anchorage_charge_currency
    - name: "Anchorage Reason Code"
      expr: anchorage_reason_code
    - name: "Anchorage Reason Description"
      expr: anchorage_reason_description
    - name: "Booking Cancelled Timestamp"
      expr: booking_cancelled_timestamp
    - name: "Booking Confirmed Timestamp"
      expr: booking_confirmed_timestamp
    - name: "Booking Reference Number"
      expr: booking_reference_number
    - name: "Booking Requested Timestamp"
      expr: booking_requested_timestamp
    - name: "Booking Status"
      expr: booking_status
    - name: "Buoy Number"
      expr: buoy_number
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Confirmed Anchor Drop Time"
      expr: confirmed_anchor_drop_time
    - name: "Confirmed Weigh Anchor Time"
      expr: confirmed_weigh_anchor_time
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Hazmat Cargo Flag"
      expr: hazmat_cargo_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Anchorage Booking"
      expr: COUNT(DISTINCT booking_anchorage_booking_id)
    - name: "Total Actual Anchorage Duration Hours"
      expr: SUM(actual_anchorage_duration_hours)
    - name: "Average Actual Anchorage Duration Hours"
      expr: AVG(actual_anchorage_duration_hours)
    - name: "Total Anchorage Charge Amount"
      expr: SUM(anchorage_charge_amount)
    - name: "Average Anchorage Charge Amount"
      expr: AVG(anchorage_charge_amount)
    - name: "Total Planned Anchorage Duration Hours"
      expr: SUM(planned_anchorage_duration_hours)
    - name: "Average Planned Anchorage Duration Hours"
      expr: AVG(planned_anchorage_duration_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_booking_berth_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Berth Reservation business metrics"
  source: "`shipping_ports_ecm`.`booking`.`booking_berth_reservation`"
  dimensions:
    - name: "Atb"
      expr: atb
    - name: "Atd"
      expr: atd
    - name: "Berth Side"
      expr: berth_side
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Confirmed Timestamp"
      expr: confirmed_timestamp
    - name: "Dangerous Goods Flag"
      expr: dangerous_goods_flag
    - name: "Etb"
      expr: etb
    - name: "Etd"
      expr: etd
    - name: "Expected Teu Volume"
      expr: expected_teu_volume
    - name: "High Tide Time"
      expr: high_tide_time
    - name: "Imdg Class"
      expr: imdg_class
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Low Tide Time"
      expr: low_tide_time
    - name: "Mooring Gang Size"
      expr: mooring_gang_size
    - name: "Number Of Tugs"
      expr: number_of_tugs
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Berth Reservation"
      expr: COUNT(DISTINCT booking_berth_reservation_id)
    - name: "Total Beam Meters"
      expr: SUM(beam_meters)
    - name: "Average Beam Meters"
      expr: AVG(beam_meters)
    - name: "Total Berth Utilization Hours"
      expr: SUM(berth_utilization_hours)
    - name: "Average Berth Utilization Hours"
      expr: AVG(berth_utilization_hours)
    - name: "Total Draft Meters"
      expr: SUM(draft_meters)
    - name: "Average Draft Meters"
      expr: AVG(draft_meters)
    - name: "Total Dwt Tonnes"
      expr: SUM(dwt_tonnes)
    - name: "Average Dwt Tonnes"
      expr: AVG(dwt_tonnes)
    - name: "Total Loa Meters"
      expr: SUM(loa_meters)
    - name: "Average Loa Meters"
      expr: AVG(loa_meters)
    - name: "Total Under Keel Clearance Meters"
      expr: SUM(under_keel_clearance_meters)
    - name: "Average Under Keel Clearance Meters"
      expr: AVG(under_keel_clearance_meters)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_booking_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Service Order business metrics"
  source: "`shipping_ports_ecm`.`booking`.`booking_service_order`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Assigned Crew Count"
      expr: assigned_crew_count
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Confirmed End Timestamp"
      expr: confirmed_end_timestamp
    - name: "Confirmed Start Timestamp"
      expr: confirmed_start_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Edi Message Reference"
      expr: edi_message_reference
    - name: "Environmental Compliance Flag"
      expr: environmental_compliance_flag
    - name: "Hazardous Cargo Flag"
      expr: hazardous_cargo_flag
    - name: "Imdg Class"
      expr: imdg_class
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Service Order"
      expr: COUNT(DISTINCT booking_service_order_id)
    - name: "Total Actual Cost Amount"
      expr: SUM(actual_cost_amount)
    - name: "Average Actual Cost Amount"
      expr: AVG(actual_cost_amount)
    - name: "Total Estimated Cost Amount"
      expr: SUM(estimated_cost_amount)
    - name: "Average Estimated Cost Amount"
      expr: AVG(estimated_cost_amount)
    - name: "Total Service Quantity"
      expr: SUM(service_quantity)
    - name: "Average Service Quantity"
      expr: AVG(service_quantity)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_call_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Call Booking business metrics"
  source: "`shipping_ports_ecm`.`booking`.`call_booking`"
  dimensions:
    - name: "Ata"
      expr: ata
    - name: "Atb"
      expr: atb
    - name: "Atd"
      expr: atd
    - name: "Booking Cancelled Timestamp"
      expr: booking_cancelled_timestamp
    - name: "Booking Confirmed Timestamp"
      expr: booking_confirmed_timestamp
    - name: "Booking Reference Number"
      expr: booking_reference_number
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Submitted Timestamp"
      expr: booking_submitted_timestamp
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Clearance Status"
      expr: customs_clearance_status
    - name: "Dangerous Goods Flag"
      expr: dangerous_goods_flag
    - name: "Eta"
      expr: eta
    - name: "Etb"
      expr: etb
    - name: "Etd"
      expr: etd
    - name: "Expected Container Moves"
      expr: expected_container_moves
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Call Booking"
      expr: COUNT(DISTINCT call_booking_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_cargo_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo Booking business metrics"
  source: "`shipping_ports_ecm`.`booking`.`cargo_booking`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Booking Confirmed Timestamp"
      expr: booking_confirmed_timestamp
    - name: "Booking Date"
      expr: booking_date
    - name: "Booking Number"
      expr: booking_number
    - name: "Booking Status"
      expr: booking_status
    - name: "Cargo Type"
      expr: cargo_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Order Number"
      expr: delivery_order_number
    - name: "Estimated Arrival Date"
      expr: estimated_arrival_date
    - name: "Handling Instructions"
      expr: handling_instructions
    - name: "Is Dangerous Goods"
      expr: is_dangerous_goods
    - name: "Is Oversized"
      expr: is_oversized
    - name: "Is Overweight"
      expr: is_overweight
    - name: "Is Temperature Controlled"
      expr: is_temperature_controlled
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Payment Terms"
      expr: payment_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cargo Booking"
      expr: COUNT(DISTINCT cargo_booking_id)
    - name: "Total Feu Count"
      expr: SUM(feu_count)
    - name: "Average Feu Count"
      expr: AVG(feu_count)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Temperature Setpoint Celsius"
      expr: SUM(temperature_setpoint_celsius)
    - name: "Average Temperature Setpoint Celsius"
      expr: AVG(temperature_setpoint_celsius)
    - name: "Total Teu Count"
      expr: SUM(teu_count)
    - name: "Average Teu Count"
      expr: AVG(teu_count)
    - name: "Total Volume Cbm"
      expr: SUM(volume_cbm)
    - name: "Average Volume Cbm"
      expr: AVG(volume_cbm)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Confirmation business metrics"
  source: "`shipping_ports_ecm`.`booking`.`confirmation`"
  dimensions:
    - name: "Acknowledged Timestamp"
      expr: acknowledged_timestamp
    - name: "Amendment Allowed Flag"
      expr: amendment_allowed_flag
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cancellation Policy"
      expr: cancellation_policy
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Charges Currency Code"
      expr: charges_currency_code
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Confirmation Type"
      expr: confirmation_type
    - name: "Confirmed Berth Code"
      expr: confirmed_berth_code
    - name: "Confirmed Eta"
      expr: confirmed_eta
    - name: "Confirmed Etb"
      expr: confirmed_etb
    - name: "Confirmed Etd"
      expr: confirmed_etd
    - name: "Confirmed Terminal Code"
      expr: confirmed_terminal_code
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Confirmation"
      expr: COUNT(DISTINCT confirmation_id)
    - name: "Total Estimated Total Charges Amount"
      expr: SUM(estimated_total_charges_amount)
    - name: "Average Estimated Total Charges Amount"
      expr: AVG(estimated_total_charges_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_pre_arrival`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre Arrival business metrics"
  source: "`shipping_ports_ecm`.`booking`.`pre_arrival`"
  dimensions:
    - name: "Acknowledgement Timestamp"
      expr: acknowledgement_timestamp
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Bunker Fuel Required"
      expr: bunker_fuel_required
    - name: "Cargo Manifest Summary"
      expr: cargo_manifest_summary
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Count"
      expr: crew_count
    - name: "Dangerous Goods Declaration"
      expr: dangerous_goods_declaration
    - name: "Dangerous Goods Onboard"
      expr: dangerous_goods_onboard
    - name: "Eta"
      expr: eta
    - name: "Etb"
      expr: etb
    - name: "Etd"
      expr: etd
    - name: "Fresh Water Required"
      expr: fresh_water_required
    - name: "Health Declaration Remarks"
      expr: health_declaration_remarks
    - name: "Health Declaration Status"
      expr: health_declaration_status
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pre Arrival"
      expr: COUNT(DISTINCT pre_arrival_id)
    - name: "Total Total Cargo Weight Tonnes"
      expr: SUM(total_cargo_weight_tonnes)
    - name: "Average Total Cargo Weight Tonnes"
      expr: AVG(total_cargo_weight_tonnes)
    - name: "Total Total Teu"
      expr: SUM(total_teu)
    - name: "Average Total Teu"
      expr: AVG(total_teu)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_resource_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource Allocation business metrics"
  source: "`shipping_ports_ecm`.`booking`.`resource_allocation`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Allocated Quantity"
      expr: allocated_quantity
    - name: "Allocation Number"
      expr: allocation_number
    - name: "Allocation Source"
      expr: allocation_source
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Unit"
      expr: allocation_unit
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Billing Reference"
      expr: billing_reference
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Confirmed End Timestamp"
      expr: confirmed_end_timestamp
    - name: "Confirmed Start Timestamp"
      expr: confirmed_start_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Size"
      expr: crew_size
    - name: "Currency Code"
      expr: currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Resource Allocation"
      expr: COUNT(DISTINCT resource_allocation_id)
    - name: "Total Actual Cost Amount"
      expr: SUM(actual_cost_amount)
    - name: "Average Actual Cost Amount"
      expr: AVG(actual_cost_amount)
    - name: "Total Actual Duration Hours"
      expr: SUM(actual_duration_hours)
    - name: "Average Actual Duration Hours"
      expr: AVG(actual_duration_hours)
    - name: "Total Estimated Cost Amount"
      expr: SUM(estimated_cost_amount)
    - name: "Average Estimated Cost Amount"
      expr: AVG(estimated_cost_amount)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_service_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Requirement business metrics"
  source: "`shipping_ports_ecm`.`booking`.`service_requirement`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Billing Reference"
      expr: billing_reference
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Equipment Type Required"
      expr: equipment_type_required
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Imdg Class"
      expr: imdg_class
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Oog Cargo Flag"
      expr: oog_cargo_flag
    - name: "Oog Dimensions"
      expr: oog_dimensions
    - name: "Priority Level"
      expr: priority_level
    - name: "Quantity Unit"
      expr: quantity_unit
    - name: "Rejection Reason"
      expr: rejection_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Requirement"
      expr: COUNT(DISTINCT service_requirement_id)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
    - name: "Total Reefer Humidity Required"
      expr: SUM(reefer_humidity_required)
    - name: "Average Reefer Humidity Required"
      expr: AVG(reefer_humidity_required)
    - name: "Total Reefer Temperature Required"
      expr: SUM(reefer_temperature_required)
    - name: "Average Reefer Temperature Required"
      expr: AVG(reefer_temperature_required)
    - name: "Total Service Quantity"
      expr: SUM(service_quantity)
    - name: "Average Service Quantity"
      expr: AVG(service_quantity)
    - name: "Total Vessel Dwt"
      expr: SUM(vessel_dwt)
    - name: "Average Vessel Dwt"
      expr: AVG(vessel_dwt)
    - name: "Total Vessel Loa"
      expr: SUM(vessel_loa)
    - name: "Average Vessel Loa"
      expr: AVG(vessel_loa)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_slot_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Slot Reservation business metrics"
  source: "`shipping_ports_ecm`.`booking`.`slot_reservation`"
  dimensions:
    - name: "Allocation Priority"
      expr: allocation_priority
    - name: "Allocation Source"
      expr: allocation_source
    - name: "Bay Position"
      expr: bay_position
    - name: "Cancelled At"
      expr: cancelled_at
    - name: "Confirmed At"
      expr: confirmed_at
    - name: "Created By User"
      expr: created_by_user
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Final Destination"
      expr: final_destination
    - name: "Oversize Indicator"
      expr: oversize_indicator
    - name: "Port Of Discharge"
      expr: port_of_discharge
    - name: "Port Of Loading"
      expr: port_of_loading
    - name: "Reefer Required"
      expr: reefer_required
    - name: "Reservation Number"
      expr: reservation_number
    - name: "Reservation Status"
      expr: reservation_status
    - name: "Reserved At"
      expr: reserved_at
    - name: "Restow Indicator"
      expr: restow_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Slot Reservation"
      expr: COUNT(DISTINCT slot_reservation_id)
    - name: "Total Reefer Temperature Celsius"
      expr: SUM(reefer_temperature_celsius)
    - name: "Average Reefer Temperature Celsius"
      expr: AVG(reefer_temperature_celsius)
    - name: "Total Slot Rate Amount"
      expr: SUM(slot_rate_amount)
    - name: "Average Slot Rate Amount"
      expr: AVG(slot_rate_amount)
    - name: "Total Teu Count"
      expr: SUM(teu_count)
    - name: "Average Teu Count"
      expr: AVG(teu_count)
    - name: "Total Verified Gross Mass Kg"
      expr: SUM(verified_gross_mass_kg)
    - name: "Average Verified Gross Mass Kg"
      expr: AVG(verified_gross_mass_kg)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_truck_gate_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Truck Gate Booking business metrics"
  source: "`shipping_ports_ecm`.`booking`.`truck_gate_booking`"
  dimensions:
    - name: "Actual Arrival Timestamp"
      expr: actual_arrival_timestamp
    - name: "Appointment Date"
      expr: appointment_date
    - name: "Appointment Status"
      expr: appointment_status
    - name: "Appointment Time Slot End"
      expr: appointment_time_slot_end
    - name: "Appointment Time Slot Start"
      expr: appointment_time_slot_start
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Booking Reference Number"
      expr: booking_reference_number
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Check In Timestamp"
      expr: check_in_timestamp
    - name: "Container Condition"
      expr: container_condition
    - name: "Container Size Type"
      expr: container_size_type
    - name: "Coparn Message Reference"
      expr: coparn_message_reference
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Driver License Number"
      expr: driver_license_number
    - name: "Driver Name"
      expr: driver_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Truck Gate Booking"
      expr: COUNT(DISTINCT truck_gate_booking_id)
    - name: "Total Cargo Weight Kg"
      expr: SUM(cargo_weight_kg)
    - name: "Average Cargo Weight Kg"
      expr: AVG(cargo_weight_kg)
    - name: "Total Reefer Temperature Celsius"
      expr: SUM(reefer_temperature_celsius)
    - name: "Average Reefer Temperature Celsius"
      expr: AVG(reefer_temperature_celsius)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_vessel_call_security_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel Call Security Assignment business metrics"
  source: "`shipping_ports_ecm`.`booking`.`vessel_call_security_assignment`"
  dimensions:
    - name: "Assignment End Timestamp"
      expr: assignment_end_timestamp
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Start Timestamp"
      expr: assignment_start_timestamp
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Incident Count"
      expr: incident_count
    - name: "Primary Zone Assigned"
      expr: primary_zone_assigned
    - name: "Role Type"
      expr: role_type
    - name: "Security Clearance Level Required"
      expr: security_clearance_level_required
    - name: "Shift Assignment"
      expr: shift_assignment
    - name: "Assignment End Timestamp Month"
      expr: DATE_TRUNC('MONTH', assignment_end_timestamp)
    - name: "Assignment Start Timestamp Month"
      expr: DATE_TRUNC('MONTH', assignment_start_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vessel Call Security Assignment"
      expr: COUNT(DISTINCT vessel_call_security_assignment_id)
    - name: "Total Created By User Code"
      expr: SUM(created_by_user_code)
    - name: "Average Created By User Code"
      expr: AVG(created_by_user_code)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`booking_voyage_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voyage Nomination business metrics"
  source: "`shipping_ports_ecm`.`booking`.`voyage_nomination`"
  dimensions:
    - name: "Acceptance Timestamp"
      expr: acceptance_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Empty Count"
      expr: empty_count
    - name: "Hazmat Count"
      expr: hazmat_count
    - name: "Next Port Of Call"
      expr: next_port_of_call
    - name: "Nominated Eta"
      expr: nominated_eta
    - name: "Nominated Etb"
      expr: nominated_etb
    - name: "Nominated Etd"
      expr: nominated_etd
    - name: "Nomination Number"
      expr: nomination_number
    - name: "Nomination Received Timestamp"
      expr: nomination_received_timestamp
    - name: "Nomination Source"
      expr: nomination_source
    - name: "Nomination Status"
      expr: nomination_status
    - name: "Oversized Count"
      expr: oversized_count
    - name: "Pilotage Required"
      expr: pilotage_required
    - name: "Reefer Count"
      expr: reefer_count
    - name: "Rejection Reason"
      expr: rejection_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Voyage Nomination"
      expr: COUNT(DISTINCT voyage_nomination_id)
    - name: "Total Export Teu"
      expr: SUM(export_teu)
    - name: "Average Export Teu"
      expr: AVG(export_teu)
    - name: "Total Import Teu"
      expr: SUM(import_teu)
    - name: "Average Import Teu"
      expr: AVG(import_teu)
    - name: "Total Restow Teu"
      expr: SUM(restow_teu)
    - name: "Average Restow Teu"
      expr: AVG(restow_teu)
    - name: "Total Transhipment Teu"
      expr: SUM(transhipment_teu)
    - name: "Average Transhipment Teu"
      expr: AVG(transhipment_teu)
$$;