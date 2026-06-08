-- Metric views for domain: fleet | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:32:47

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_asset_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Assignment business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`asset_assignment`"
  dimensions:
    - name: "Actual End Datetime"
      expr: actual_end_datetime
    - name: "Actual Start Datetime"
      expr: actual_start_datetime
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Compliance Check Status"
      expr: compliance_check_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Border Indicator"
      expr: cross_border_indicator
    - name: "Currency Code"
      expr: currency_code
    - name: "Delay Duration Minutes"
      expr: delay_duration_minutes
    - name: "Delay Reason Code"
      expr: delay_reason_code
    - name: "Gps Tracking Enabled"
      expr: gps_tracking_enabled
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Incident Reported Indicator"
      expr: incident_reported_indicator
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Assignment"
      expr: COUNT(DISTINCT asset_assignment_id)
    - name: "Total Assignment Cost Amount"
      expr: SUM(assignment_cost_amount)
    - name: "Average Assignment Cost Amount"
      expr: AVG(assignment_cost_amount)
    - name: "Total Assignment Duration Hours"
      expr: SUM(assignment_duration_hours)
    - name: "Average Assignment Duration Hours"
      expr: AVG(assignment_duration_hours)
    - name: "Total Cargo Volume Cbm"
      expr: SUM(cargo_volume_cbm)
    - name: "Average Cargo Volume Cbm"
      expr: AVG(cargo_volume_cbm)
    - name: "Total Cargo Weight Kg"
      expr: SUM(cargo_weight_kg)
    - name: "Average Cargo Weight Kg"
      expr: AVG(cargo_weight_kg)
    - name: "Total Co2 Emissions Kg"
      expr: SUM(co2_emissions_kg)
    - name: "Average Co2 Emissions Kg"
      expr: AVG(co2_emissions_kg)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Fuel Consumed Liters"
      expr: SUM(fuel_consumed_liters)
    - name: "Average Fuel Consumed Liters"
      expr: AVG(fuel_consumed_liters)
    - name: "Total Load Utilization Percentage"
      expr: SUM(load_utilization_percentage)
    - name: "Average Load Utilization Percentage"
      expr: AVG(load_utilization_percentage)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_asset_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Inspection business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`asset_inspection`"
  dimensions:
    - name: "Certificate Expiry Date"
      expr: certificate_expiry_date
    - name: "Certificate Issue Date"
      expr: certificate_issue_date
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Corrective Action Deadline"
      expr: corrective_action_deadline
    - name: "Corrective Actions Required"
      expr: corrective_actions_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Defects Count"
      expr: critical_defects_count
    - name: "Defects Description"
      expr: defects_description
    - name: "Defects Identified Count"
      expr: defects_identified_count
    - name: "Inspection Checklist Reference"
      expr: inspection_checklist_reference
    - name: "Inspection Cost Currency"
      expr: inspection_cost_currency
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Document Url"
      expr: inspection_document_url
    - name: "Inspection End Time"
      expr: inspection_end_time
    - name: "Inspection Location Country"
      expr: inspection_location_country
    - name: "Inspection Notes"
      expr: inspection_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Inspection"
      expr: COUNT(DISTINCT asset_inspection_id)
    - name: "Total Inspection Cost"
      expr: SUM(inspection_cost)
    - name: "Average Inspection Cost"
      expr: AVG(inspection_cost)
    - name: "Total Odometer Reading At Inspection"
      expr: SUM(odometer_reading_at_inspection)
    - name: "Average Odometer Reading At Inspection"
      expr: AVG(odometer_reading_at_inspection)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_asset_licence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Licence business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`asset_licence`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference"
      expr: document_reference
    - name: "Effective Date"
      expr: effective_date
    - name: "Endorsements"
      expr: endorsements
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Inspection Authority"
      expr: inspection_authority
    - name: "Inspection Required Flag"
      expr: inspection_required_flag
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Issuing Country"
      expr: issuing_country
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Licence Category"
      expr: licence_category
    - name: "Licence Class"
      expr: licence_class
    - name: "Licence Fee Currency"
      expr: licence_fee_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Licence"
      expr: COUNT(DISTINCT asset_licence_id)
    - name: "Total Licence Fee Amount"
      expr: SUM(licence_fee_amount)
    - name: "Average Licence Fee Amount"
      expr: AVG(licence_fee_amount)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_asset_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Type business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`asset_type`"
  dimensions:
    - name: "Asset Category"
      expr: asset_category
    - name: "Asset Subcategory"
      expr: asset_subcategory
    - name: "Asset Type Code"
      expr: asset_type_code
    - name: "Asset Type Description"
      expr: asset_type_description
    - name: "Asset Type Name"
      expr: asset_type_name
    - name: "Asset Type Status"
      expr: asset_type_status
    - name: "Certification Interval Months"
      expr: certification_interval_months
    - name: "Certification Required Flag"
      expr: certification_required_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Dot Classification Code"
      expr: dot_classification_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Emission Standard"
      expr: emission_standard
    - name: "End Date"
      expr: end_date
    - name: "Fuel Type Standard"
      expr: fuel_type_standard
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Type"
      expr: COUNT(DISTINCT asset_type_id)
    - name: "Total Average Acquisition Cost"
      expr: SUM(average_acquisition_cost)
    - name: "Average Average Acquisition Cost"
      expr: AVG(average_acquisition_cost)
    - name: "Total Standard Height M"
      expr: SUM(standard_height_m)
    - name: "Average Standard Height M"
      expr: AVG(standard_height_m)
    - name: "Total Standard Length M"
      expr: SUM(standard_length_m)
    - name: "Average Standard Length M"
      expr: AVG(standard_length_m)
    - name: "Total Standard Payload Capacity Kg"
      expr: SUM(standard_payload_capacity_kg)
    - name: "Average Standard Payload Capacity Kg"
      expr: AVG(standard_payload_capacity_kg)
    - name: "Total Standard Temperature Range Max C"
      expr: SUM(standard_temperature_range_max_c)
    - name: "Average Standard Temperature Range Max C"
      expr: AVG(standard_temperature_range_max_c)
    - name: "Total Standard Temperature Range Min C"
      expr: SUM(standard_temperature_range_min_c)
    - name: "Average Standard Temperature Range Min C"
      expr: AVG(standard_temperature_range_min_c)
    - name: "Total Standard Teu Capacity"
      expr: SUM(standard_teu_capacity)
    - name: "Average Standard Teu Capacity"
      expr: AVG(standard_teu_capacity)
    - name: "Total Standard Volume Capacity Cbm"
      expr: SUM(standard_volume_capacity_cbm)
    - name: "Average Standard Volume Capacity Cbm"
      expr: AVG(standard_volume_capacity_cbm)
    - name: "Total Standard Width M"
      expr: SUM(standard_width_m)
    - name: "Average Standard Width M"
      expr: AVG(standard_width_m)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_asset_utilisation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Utilisation business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`asset_utilisation`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Notes"
      expr: notes
    - name: "Number Of Trips"
      expr: number_of_trips
    - name: "Operational Status"
      expr: operational_status
    - name: "Period Type"
      expr: period_type
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Reporting Period Date"
      expr: reporting_period_date
    - name: "Safety Incidents Count"
      expr: safety_incidents_count
    - name: "Record Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', record_created_timestamp)
    - name: "Record Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', record_updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Utilisation"
      expr: COUNT(DISTINCT asset_utilisation_id)
    - name: "Total Actual Payload Kg"
      expr: SUM(actual_payload_kg)
    - name: "Average Actual Payload Kg"
      expr: AVG(actual_payload_kg)
    - name: "Total Co2 Emissions Kg"
      expr: SUM(co2_emissions_kg)
    - name: "Average Co2 Emissions Kg"
      expr: AVG(co2_emissions_kg)
    - name: "Total Distance Travelled Km"
      expr: SUM(distance_travelled_km)
    - name: "Average Distance Travelled Km"
      expr: AVG(distance_travelled_km)
    - name: "Total Distance Travelled Miles"
      expr: SUM(distance_travelled_miles)
    - name: "Average Distance Travelled Miles"
      expr: AVG(distance_travelled_miles)
    - name: "Total Fuel Consumed Liters"
      expr: SUM(fuel_consumed_liters)
    - name: "Average Fuel Consumed Liters"
      expr: AVG(fuel_consumed_liters)
    - name: "Total Fuel Efficiency Liters Per 100km"
      expr: SUM(fuel_efficiency_liters_per_100km)
    - name: "Average Fuel Efficiency Liters Per 100km"
      expr: AVG(fuel_efficiency_liters_per_100km)
    - name: "Total Fuel Efficiency Mpg"
      expr: SUM(fuel_efficiency_mpg)
    - name: "Average Fuel Efficiency Mpg"
      expr: AVG(fuel_efficiency_mpg)
    - name: "Total Load Factor Percent"
      expr: SUM(load_factor_percent)
    - name: "Average Load Factor Percent"
      expr: AVG(load_factor_percent)
    - name: "Total On Time Delivery Rate Percent"
      expr: SUM(on_time_delivery_rate_percent)
    - name: "Average On Time Delivery Rate Percent"
      expr: AVG(on_time_delivery_rate_percent)
    - name: "Total Operating Cost"
      expr: SUM(operating_cost)
    - name: "Average Operating Cost"
      expr: AVG(operating_cost)
    - name: "Total Payload Capacity Kg"
      expr: SUM(payload_capacity_kg)
    - name: "Average Payload Capacity Kg"
      expr: AVG(payload_capacity_kg)
    - name: "Total Revenue Generated"
      expr: SUM(revenue_generated)
    - name: "Average Revenue Generated"
      expr: AVG(revenue_generated)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_container_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container Unit business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`container_unit`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Availability Status"
      expr: availability_status
    - name: "Condition Grade"
      expr: condition_grade
    - name: "Container Number"
      expr: container_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csc Certification Date"
      expr: csc_certification_date
    - name: "Csc Certification Number"
      expr: csc_certification_number
    - name: "Csc Expiry Date"
      expr: csc_expiry_date
    - name: "Current Location Country"
      expr: current_location_country
    - name: "Current Location Type"
      expr: current_location_type
    - name: "Disposal Date"
      expr: disposal_date
    - name: "Food Grade Certified"
      expr: food_grade_certified
    - name: "Gps Enabled"
      expr: gps_enabled
    - name: "Hazmat Certified"
      expr: hazmat_certified
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Container Unit"
      expr: COUNT(DISTINCT container_unit_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Current Book Value"
      expr: SUM(current_book_value)
    - name: "Average Current Book Value"
      expr: AVG(current_book_value)
    - name: "Total Height Ft"
      expr: SUM(height_ft)
    - name: "Average Height Ft"
      expr: AVG(height_ft)
    - name: "Total Internal Volume Cbm"
      expr: SUM(internal_volume_cbm)
    - name: "Average Internal Volume Cbm"
      expr: AVG(internal_volume_cbm)
    - name: "Total Max Gross Weight Kg"
      expr: SUM(max_gross_weight_kg)
    - name: "Average Max Gross Weight Kg"
      expr: AVG(max_gross_weight_kg)
    - name: "Total Max Payload Kg"
      expr: SUM(max_payload_kg)
    - name: "Average Max Payload Kg"
      expr: AVG(max_payload_kg)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
    - name: "Total Temperature Range Max C"
      expr: SUM(temperature_range_max_c)
    - name: "Average Temperature Range Max C"
      expr: AVG(temperature_range_max_c)
    - name: "Total Temperature Range Min C"
      expr: SUM(temperature_range_min_c)
    - name: "Average Temperature Range Min C"
      expr: AVG(temperature_range_min_c)
    - name: "Total Teu Size"
      expr: SUM(teu_size)
    - name: "Average Teu Size"
      expr: AVG(teu_size)
    - name: "Total Total Distance Km"
      expr: SUM(total_distance_km)
    - name: "Average Total Distance Km"
      expr: AVG(total_distance_km)
    - name: "Total Width Ft"
      expr: SUM(width_ft)
    - name: "Average Width Ft"
      expr: AVG(width_ft)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_depot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depot business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`depot`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Container Capacity Teu"
      expr: container_capacity_teu
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Bonded Facility Flag"
      expr: customs_bonded_facility_flag
    - name: "Decommissioning Date"
      expr: decommissioning_date
    - name: "Depot Code"
      expr: depot_code
    - name: "Depot Name"
      expr: depot_name
    - name: "Depot Type"
      expr: depot_type
    - name: "Electric Charging Stations"
      expr: electric_charging_stations
    - name: "Environmental Certification"
      expr: environmental_certification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Depot"
      expr: COUNT(DISTINCT depot_id)
    - name: "Total Covered Area Sqm"
      expr: SUM(covered_area_sqm)
    - name: "Average Covered Area Sqm"
      expr: AVG(covered_area_sqm)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Total Area Sqm"
      expr: SUM(total_area_sqm)
    - name: "Average Total Area Sqm"
      expr: AVG(total_area_sqm)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_driver_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Driver Assignment business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`driver_assignment`"
  dimensions:
    - name: "Actual Departure Datetime"
      expr: actual_departure_datetime
    - name: "Actual Return Datetime"
      expr: actual_return_datetime
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Outcome"
      expr: assignment_outcome
    - name: "Assignment Priority"
      expr: assignment_priority
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Feedback Score"
      expr: customer_feedback_score
    - name: "Dispatch Datetime"
      expr: dispatch_datetime
    - name: "Driver Rating"
      expr: driver_rating
    - name: "Hos Violation Flag"
      expr: hos_violation_flag
    - name: "Hos Violation Type"
      expr: hos_violation_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Planned Departure Datetime"
      expr: planned_departure_datetime
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Driver Assignment"
      expr: COUNT(DISTINCT driver_assignment_id)
    - name: "Total Assignment Duration Hours"
      expr: SUM(assignment_duration_hours)
    - name: "Average Assignment Duration Hours"
      expr: AVG(assignment_duration_hours)
    - name: "Total Co2 Emissions Kg"
      expr: SUM(co2_emissions_kg)
    - name: "Average Co2 Emissions Kg"
      expr: AVG(co2_emissions_kg)
    - name: "Total Distance Actual Km"
      expr: SUM(distance_actual_km)
    - name: "Average Distance Actual Km"
      expr: AVG(distance_actual_km)
    - name: "Total Distance Planned Km"
      expr: SUM(distance_planned_km)
    - name: "Average Distance Planned Km"
      expr: AVG(distance_planned_km)
    - name: "Total Driving Hours"
      expr: SUM(driving_hours)
    - name: "Average Driving Hours"
      expr: AVG(driving_hours)
    - name: "Total Fuel Consumed Liters"
      expr: SUM(fuel_consumed_liters)
    - name: "Average Fuel Consumed Liters"
      expr: AVG(fuel_consumed_liters)
    - name: "Total Hos Counter At End"
      expr: SUM(hos_counter_at_end)
    - name: "Average Hos Counter At End"
      expr: AVG(hos_counter_at_end)
    - name: "Total Hos Counter At Start"
      expr: SUM(hos_counter_at_start)
    - name: "Average Hos Counter At Start"
      expr: AVG(hos_counter_at_start)
    - name: "Total Rest Break Hours"
      expr: SUM(rest_break_hours)
    - name: "Average Rest Break Hours"
      expr: AVG(rest_break_hours)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_driver_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Driver Profile business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`driver_profile`"
  dimensions:
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Background Check Date"
      expr: background_check_date
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Disciplinary Flag"
      expr: disciplinary_flag
    - name: "Driver Name"
      expr: driver_name
    - name: "Drug Test Date"
      expr: drug_test_date
    - name: "Drug Test Result"
      expr: drug_test_result
    - name: "Email Address"
      expr: email_address
    - name: "Emergency Contact Name"
      expr: emergency_contact_name
    - name: "Emergency Contact Phone"
      expr: emergency_contact_phone
    - name: "Employment Type"
      expr: employment_type
    - name: "Gps Device Code"
      expr: gps_device_code
    - name: "Hire Date"
      expr: hire_date
    - name: "Language Proficiency"
      expr: language_proficiency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Driver Profile"
      expr: COUNT(DISTINCT driver_profile_id)
    - name: "Total Years Of Experience"
      expr: SUM(years_of_experience)
    - name: "Average Years Of Experience"
      expr: AVG(years_of_experience)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_fuel_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel Transaction business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`fuel_transaction`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fuel Card Number"
      expr: fuel_card_number
    - name: "Fuel Card Provider"
      expr: fuel_card_provider
    - name: "Fuel Grade"
      expr: fuel_grade
    - name: "Fuel Station Country Code"
      expr: fuel_station_country_code
    - name: "Fuel Station Location"
      expr: fuel_station_location
    - name: "Fuel Station Name"
      expr: fuel_station_name
    - name: "Fuel Type"
      expr: fuel_type
    - name: "General Ledger Account"
      expr: general_ledger_account
    - name: "Is Emergency Refuel"
      expr: is_emergency_refuel
    - name: "Is Reconciled"
      expr: is_reconciled
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Odometer Unit"
      expr: odometer_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fuel Transaction"
      expr: COUNT(DISTINCT fuel_transaction_id)
    - name: "Total Co2e Emission Factor"
      expr: SUM(co2e_emission_factor)
    - name: "Average Co2e Emission Factor"
      expr: AVG(co2e_emission_factor)
    - name: "Total Co2e Emissions Kg"
      expr: SUM(co2e_emissions_kg)
    - name: "Average Co2e Emissions Kg"
      expr: AVG(co2e_emissions_kg)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Fuel Efficiency"
      expr: SUM(fuel_efficiency)
    - name: "Average Fuel Efficiency"
      expr: AVG(fuel_efficiency)
    - name: "Total Fuel Station Code"
      expr: SUM(fuel_station_code)
    - name: "Average Fuel Station Code"
      expr: AVG(fuel_station_code)
    - name: "Total Odometer Reading"
      expr: SUM(odometer_reading)
    - name: "Average Odometer Reading"
      expr: AVG(odometer_reading)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incident business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`incident`"
  dimensions:
    - name: "Asset Damage Currency Code"
      expr: asset_damage_currency_code
    - name: "Cargo Damage Currency Code"
      expr: cargo_damage_currency_code
    - name: "Cargo Damage Flag"
      expr: cargo_damage_flag
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Required Flag"
      expr: corrective_action_required_flag
    - name: "Corrective Action Status"
      expr: corrective_action_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Datetime"
      expr: datetime
    - name: "Dot Report Submitted Date"
      expr: dot_report_submitted_date
    - name: "Dot Reportable Flag"
      expr: dot_reportable_flag
    - name: "Fatality Count"
      expr: fatality_count
    - name: "Incident Number"
      expr: incident_number
    - name: "Incident Status"
      expr: incident_status
    - name: "Incident Type"
      expr: incident_type
    - name: "Injuries Reported Flag"
      expr: injuries_reported_flag
    - name: "Injury Count"
      expr: injury_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Incident"
      expr: COUNT(DISTINCT incident_id)
    - name: "Total Asset Damage Estimated Cost"
      expr: SUM(asset_damage_estimated_cost)
    - name: "Average Asset Damage Estimated Cost"
      expr: AVG(asset_damage_estimated_cost)
    - name: "Total Cargo Damage Estimated Cost"
      expr: SUM(cargo_damage_estimated_cost)
    - name: "Average Cargo Damage Estimated Cost"
      expr: AVG(cargo_damage_estimated_cost)
    - name: "Total Location Latitude"
      expr: SUM(location_latitude)
    - name: "Average Location Latitude"
      expr: AVG(location_latitude)
    - name: "Total Location Longitude"
      expr: SUM(location_longitude)
    - name: "Average Location Longitude"
      expr: AVG(location_longitude)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_maintenance_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Order business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`maintenance_order`"
  dimensions:
    - name: "Actual Completion Timestamp"
      expr: actual_completion_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fault Code"
      expr: fault_code
    - name: "Fault Description"
      expr: fault_description
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Inspection Certificate Number"
      expr: inspection_certificate_number
    - name: "Inspection Expiry Date"
      expr: inspection_expiry_date
    - name: "Maintenance Category"
      expr: maintenance_category
    - name: "Maintenance Order Status"
      expr: maintenance_order_status
    - name: "Maintenance Provider Type"
      expr: maintenance_provider_type
    - name: "Maintenance Type"
      expr: maintenance_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Order"
      expr: COUNT(DISTINCT maintenance_order_id)
    - name: "Total Downtime Hours"
      expr: SUM(downtime_hours)
    - name: "Average Downtime Hours"
      expr: AVG(downtime_hours)
    - name: "Total Engine Hours"
      expr: SUM(engine_hours)
    - name: "Average Engine Hours"
      expr: AVG(engine_hours)
    - name: "Total External Service Cost"
      expr: SUM(external_service_cost)
    - name: "Average External Service Cost"
      expr: AVG(external_service_cost)
    - name: "Total Labor Cost"
      expr: SUM(labor_cost)
    - name: "Average Labor Cost"
      expr: AVG(labor_cost)
    - name: "Total Labor Hours"
      expr: SUM(labor_hours)
    - name: "Average Labor Hours"
      expr: AVG(labor_hours)
    - name: "Total Odometer Reading"
      expr: SUM(odometer_reading)
    - name: "Average Odometer Reading"
      expr: AVG(odometer_reading)
    - name: "Total Parts Cost"
      expr: SUM(parts_cost)
    - name: "Average Parts Cost"
      expr: AVG(parts_cost)
    - name: "Total Total Maintenance Cost"
      expr: SUM(total_maintenance_cost)
    - name: "Average Total Maintenance Cost"
      expr: AVG(total_maintenance_cost)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_maintenance_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Maintenance Schedule business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`maintenance_schedule`"
  dimensions:
    - name: "Auto Generate Order Flag"
      expr: auto_generate_order_flag
    - name: "Compliance Mandatory Flag"
      expr: compliance_mandatory_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Required Flag"
      expr: downtime_required_flag
    - name: "Interval Unit"
      expr: interval_unit
    - name: "Last Completed Date"
      expr: last_completed_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Next Due Date"
      expr: next_due_date
    - name: "Notes"
      expr: notes
    - name: "Parts Required Flag"
      expr: parts_required_flag
    - name: "Priority Level"
      expr: priority_level
    - name: "Regulation Reference"
      expr: regulation_reference
    - name: "Regulatory Body"
      expr: regulatory_body
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Maintenance Schedule"
      expr: COUNT(DISTINCT maintenance_schedule_id)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
    - name: "Total Interval Value"
      expr: SUM(interval_value)
    - name: "Average Interval Value"
      expr: AVG(interval_value)
    - name: "Total Last Completed Hours"
      expr: SUM(last_completed_hours)
    - name: "Average Last Completed Hours"
      expr: AVG(last_completed_hours)
    - name: "Total Last Completed Mileage"
      expr: SUM(last_completed_mileage)
    - name: "Average Last Completed Mileage"
      expr: AVG(last_completed_mileage)
    - name: "Total Next Due Hours"
      expr: SUM(next_due_hours)
    - name: "Average Next Due Hours"
      expr: AVG(next_due_hours)
    - name: "Total Next Due Mileage"
      expr: SUM(next_due_mileage)
    - name: "Average Next Due Mileage"
      expr: AVG(next_due_mileage)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_telematics_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telematics Event business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`telematics_event`"
  dimensions:
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Device Code"
      expr: device_code
    - name: "Diagnostic Trouble Code"
      expr: diagnostic_trouble_code
    - name: "Engine Rpm"
      expr: engine_rpm
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Geofence Event Type"
      expr: geofence_event_type
    - name: "Gps Satellite Count"
      expr: gps_satellite_count
    - name: "Harsh Acceleration Flag"
      expr: harsh_acceleration_flag
    - name: "Harsh Braking Flag"
      expr: harsh_braking_flag
    - name: "Ignition State"
      expr: ignition_state
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
    - name: "Network Type"
      expr: network_type
    - name: "Payload Json"
      expr: payload_json
    - name: "Signal Strength"
      expr: signal_strength
    - name: "Source System"
      expr: source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Telematics Event"
      expr: COUNT(DISTINCT telematics_event_id)
    - name: "Total Altitude M"
      expr: SUM(altitude_m)
    - name: "Average Altitude M"
      expr: AVG(altitude_m)
    - name: "Total Battery Voltage"
      expr: SUM(battery_voltage)
    - name: "Average Battery Voltage"
      expr: AVG(battery_voltage)
    - name: "Total Engine Hours"
      expr: SUM(engine_hours)
    - name: "Average Engine Hours"
      expr: AVG(engine_hours)
    - name: "Total Fuel Level Percent"
      expr: SUM(fuel_level_percent)
    - name: "Average Fuel Level Percent"
      expr: AVG(fuel_level_percent)
    - name: "Total Gps Accuracy M"
      expr: SUM(gps_accuracy_m)
    - name: "Average Gps Accuracy M"
      expr: AVG(gps_accuracy_m)
    - name: "Total Heading Degrees"
      expr: SUM(heading_degrees)
    - name: "Average Heading Degrees"
      expr: AVG(heading_degrees)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Odometer Km"
      expr: SUM(odometer_km)
    - name: "Average Odometer Km"
      expr: AVG(odometer_km)
    - name: "Total Speed Kmh"
      expr: SUM(speed_kmh)
    - name: "Average Speed Kmh"
      expr: AVG(speed_kmh)
    - name: "Total Temperature C"
      expr: SUM(temperature_c)
    - name: "Average Temperature C"
      expr: AVG(temperature_c)
    - name: "Total Temperature Setpoint C"
      expr: SUM(temperature_setpoint_c)
    - name: "Average Temperature Setpoint C"
      expr: AVG(temperature_setpoint_c)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_transport_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport Asset business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`transport_asset`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Number"
      expr: asset_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Location"
      expr: current_location
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Disposal Date"
      expr: disposal_date
    - name: "Emission Standard"
      expr: emission_standard
    - name: "Engine Type"
      expr: engine_type
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Home Location"
      expr: home_location
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transport Asset"
      expr: COUNT(DISTINCT transport_asset_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Co2 Emission Rate G Per Km"
      expr: SUM(co2_emission_rate_g_per_km)
    - name: "Average Co2 Emission Rate G Per Km"
      expr: AVG(co2_emission_rate_g_per_km)
    - name: "Total Disposal Value"
      expr: SUM(disposal_value)
    - name: "Average Disposal Value"
      expr: AVG(disposal_value)
    - name: "Total Engine Power Kw"
      expr: SUM(engine_power_kw)
    - name: "Average Engine Power Kw"
      expr: AVG(engine_power_kw)
    - name: "Total Fuel Capacity Liters"
      expr: SUM(fuel_capacity_liters)
    - name: "Average Fuel Capacity Liters"
      expr: AVG(fuel_capacity_liters)
    - name: "Total Height Meters"
      expr: SUM(height_meters)
    - name: "Average Height Meters"
      expr: AVG(height_meters)
    - name: "Total Length Meters"
      expr: SUM(length_meters)
    - name: "Average Length Meters"
      expr: AVG(length_meters)
    - name: "Total Odometer Reading"
      expr: SUM(odometer_reading)
    - name: "Average Odometer Reading"
      expr: AVG(odometer_reading)
    - name: "Total Payload Capacity Kg"
      expr: SUM(payload_capacity_kg)
    - name: "Average Payload Capacity Kg"
      expr: AVG(payload_capacity_kg)
    - name: "Total Teu Capacity"
      expr: SUM(teu_capacity)
    - name: "Average Teu Capacity"
      expr: AVG(teu_capacity)
    - name: "Total Utilization Rate Percent"
      expr: SUM(utilization_rate_percent)
    - name: "Average Utilization Rate Percent"
      expr: AVG(utilization_rate_percent)
    - name: "Total Volume Capacity Cbm"
      expr: SUM(volume_capacity_cbm)
    - name: "Average Volume Capacity Cbm"
      expr: AVG(volume_capacity_cbm)
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`fleet_trip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trip business metrics"
  source: "`transport_shipping_ecm`.`fleet`.`trip`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Cargo Type"
      expr: cargo_type
    - name: "Comments"
      expr: comments
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Location Code"
      expr: destination_location_code
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Is Expedited"
      expr: is_expedited
    - name: "Number Of Stops"
      expr: number_of_stops
    - name: "Priority Level"
      expr: priority_level
    - name: "Reason Code"
      expr: reason_code
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Scheduled End Timestamp"
      expr: scheduled_end_timestamp
    - name: "Scheduled Start Timestamp"
      expr: scheduled_start_timestamp
    - name: "Trip Number"
      expr: trip_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Trip"
      expr: COUNT(DISTINCT trip_id)
    - name: "Total Average Speed Kmh"
      expr: SUM(average_speed_kmh)
    - name: "Average Average Speed Kmh"
      expr: AVG(average_speed_kmh)
    - name: "Total Cargo Weight Kg"
      expr: SUM(cargo_weight_kg)
    - name: "Average Cargo Weight Kg"
      expr: AVG(cargo_weight_kg)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Emissions Kg Co2"
      expr: SUM(emissions_kg_co2)
    - name: "Average Emissions Kg Co2"
      expr: AVG(emissions_kg_co2)
    - name: "Total Fuel Consumed Liters"
      expr: SUM(fuel_consumed_liters)
    - name: "Average Fuel Consumed Liters"
      expr: AVG(fuel_consumed_liters)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;