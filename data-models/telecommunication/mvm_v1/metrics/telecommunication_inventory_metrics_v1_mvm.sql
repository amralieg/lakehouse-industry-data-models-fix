-- Metric views for domain: inventory | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:29:03

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_asset_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Lifecycle Event business metrics"
  source: "`telecommunication_ecm`.`inventory`.`asset_lifecycle_event`"
  dimensions:
    - name: "Actual Count"
      expr: actual_count
    - name: "Approval Required"
      expr: approval_required
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Asset Category"
      expr: asset_category
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Event Notes"
      expr: event_notes
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Expected Count"
      expr: expected_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "New State"
      expr: new_state
    - name: "Previous State"
      expr: previous_state
    - name: "Reconciliation Action"
      expr: reconciliation_action
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Lifecycle Event"
      expr: COUNT(DISTINCT asset_lifecycle_event_id)
    - name: "Total Cost Impact"
      expr: SUM(cost_impact)
    - name: "Average Cost Impact"
      expr: AVG(cost_impact)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_cpe_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cpe Asset business metrics"
  source: "`telecommunication_ecm`.`inventory`.`cpe_asset`"
  dimensions:
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Hardware Version"
      expr: hardware_version
    - name: "Imei"
      expr: imei
    - name: "Installation Date"
      expr: installation_date
    - name: "Ip Address"
      expr: ip_address
    - name: "Is 5g Capable"
      expr: is_5g_capable
    - name: "Is Wifi6 Capable"
      expr: is_wifi6_capable
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Mac Address"
      expr: mac_address
    - name: "Max Bandwidth Mbps"
      expr: max_bandwidth_mbps
    - name: "Next Maintenance Date"
      expr: next_maintenance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cpe Asset"
      expr: COUNT(DISTINCT cpe_asset_id)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_fiber_cable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiber Cable business metrics"
  source: "`telecommunication_ecm`.`inventory`.`fiber_cable`"
  dimensions:
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Assigned Fiber Count"
      expr: assigned_fiber_count
    - name: "Available Fiber Count"
      expr: available_fiber_count
    - name: "Cable Code"
      expr: cable_code
    - name: "Cable Type"
      expr: cable_type
    - name: "Conduit Material Type"
      expr: conduit_material_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deployment Method"
      expr: deployment_method
    - name: "Environmental Zone"
      expr: environmental_zone
    - name: "Fiber Count"
      expr: fiber_count
    - name: "Fire Rating"
      expr: fire_rating
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maintenance Responsibility"
      expr: maintenance_responsibility
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fiber Cable"
      expr: COUNT(DISTINCT fiber_cable_id)
    - name: "Total Attenuation Db Per Km"
      expr: SUM(attenuation_db_per_km)
    - name: "Average Attenuation Db Per Km"
      expr: AVG(attenuation_db_per_km)
    - name: "Total Conduit Fill Ratio Percent"
      expr: SUM(conduit_fill_ratio_percent)
    - name: "Average Conduit Fill Ratio Percent"
      expr: AVG(conduit_fill_ratio_percent)
    - name: "Total Conduit Inner Diameter Mm"
      expr: SUM(conduit_inner_diameter_mm)
    - name: "Average Conduit Inner Diameter Mm"
      expr: AVG(conduit_inner_diameter_mm)
    - name: "Total End Location Gps Latitude"
      expr: SUM(end_location_gps_latitude)
    - name: "Average End Location Gps Latitude"
      expr: AVG(end_location_gps_latitude)
    - name: "Total End Location Gps Longitude"
      expr: SUM(end_location_gps_longitude)
    - name: "Average End Location Gps Longitude"
      expr: AVG(end_location_gps_longitude)
    - name: "Total Route Length Meters"
      expr: SUM(route_length_meters)
    - name: "Average Route Length Meters"
      expr: AVG(route_length_meters)
    - name: "Total Start Location Gps Latitude"
      expr: SUM(start_location_gps_latitude)
    - name: "Average Start Location Gps Latitude"
      expr: AVG(start_location_gps_latitude)
    - name: "Total Start Location Gps Longitude"
      expr: SUM(start_location_gps_longitude)
    - name: "Average Start Location Gps Longitude"
      expr: AVG(start_location_gps_longitude)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_ip_address_pool`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ip Address Pool business metrics"
  source: "`telecommunication_ecm`.`inventory`.`ip_address_pool`"
  dimensions:
    - name: "Allocation Policy"
      expr: allocation_policy
    - name: "Assignment Scope"
      expr: assignment_scope
    - name: "Cgnat Ratio"
      expr: cgnat_ratio
    - name: "Cidr Block"
      expr: cidr_block
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Lease Duration Hours"
      expr: default_lease_duration_hours
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Encapsulation Type"
      expr: encapsulation_type
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Ip Version"
      expr: ip_version
    - name: "Is Cgnat Enabled"
      expr: is_cgnat_enabled
    - name: "Is Lawful Intercept Enabled"
      expr: is_lawful_intercept_enabled
    - name: "Is Public Routable"
      expr: is_public_routable
    - name: "Last Assignment Timestamp"
      expr: last_assignment_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ip Address Pool"
      expr: COUNT(DISTINCT ip_address_pool_id)
    - name: "Total Assigned Count"
      expr: SUM(assigned_count)
    - name: "Average Assigned Count"
      expr: AVG(assigned_count)
    - name: "Total Available Count"
      expr: SUM(available_count)
    - name: "Average Available Count"
      expr: AVG(available_count)
    - name: "Total High Watermark Threshold"
      expr: SUM(high_watermark_threshold)
    - name: "Average High Watermark Threshold"
      expr: AVG(high_watermark_threshold)
    - name: "Total Low Watermark Threshold"
      expr: SUM(low_watermark_threshold)
    - name: "Average Low Watermark Threshold"
      expr: AVG(low_watermark_threshold)
    - name: "Total Reserved Count"
      expr: SUM(reserved_count)
    - name: "Average Reserved Count"
      expr: AVG(reserved_count)
    - name: "Total Total Capacity"
      expr: SUM(total_capacity)
    - name: "Average Total Capacity"
      expr: AVG(total_capacity)
    - name: "Total Utilization Percentage"
      expr: SUM(utilization_percentage)
    - name: "Average Utilization Percentage"
      expr: AVG(utilization_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_msisdn_range`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Msisdn Range business metrics"
  source: "`telecommunication_ecm`.`inventory`.`msisdn_range`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Allocation Authority"
      expr: allocation_authority
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Block Size"
      expr: block_size
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Number"
      expr: end_number
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Last Assignment Timestamp"
      expr: last_assignment_timestamp
    - name: "Last Deallocation Timestamp"
      expr: last_deallocation_timestamp
    - name: "Ndc"
      expr: ndc
    - name: "Network Operator Code"
      expr: network_operator_code
    - name: "Notes"
      expr: notes
    - name: "Number Format Mask"
      expr: number_format_mask
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Msisdn Range"
      expr: COUNT(DISTINCT msisdn_range_id)
    - name: "Total Assigned Count"
      expr: SUM(assigned_count)
    - name: "Average Assigned Count"
      expr: AVG(assigned_count)
    - name: "Total Available Count"
      expr: SUM(available_count)
    - name: "Average Available Count"
      expr: AVG(available_count)
    - name: "Total Cost Per Number"
      expr: SUM(cost_per_number)
    - name: "Average Cost Per Number"
      expr: AVG(cost_per_number)
    - name: "Total Quarantined Count"
      expr: SUM(quarantined_count)
    - name: "Average Quarantined Count"
      expr: AVG(quarantined_count)
    - name: "Total Reserved Count"
      expr: SUM(reserved_count)
    - name: "Average Reserved Count"
      expr: AVG(reserved_count)
    - name: "Total Total Capacity"
      expr: SUM(total_capacity)
    - name: "Average Total Capacity"
      expr: AVG(total_capacity)
    - name: "Total Utilization Percentage"
      expr: SUM(utilization_percentage)
    - name: "Average Utilization Percentage"
      expr: AVG(utilization_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_network_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network Equipment business metrics"
  source: "`telecommunication_ecm`.`inventory`.`network_equipment`"
  dimensions:
    - name: "Administrative Status"
      expr: administrative_status
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Climate Control Required"
      expr: climate_control_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Of Life Date"
      expr: end_of_life_date
    - name: "End Of Sale Date"
      expr: end_of_sale_date
    - name: "End Of Support Date"
      expr: end_of_support_date
    - name: "Equipment Serial Number"
      expr: equipment_serial_number
    - name: "Equipment Subtype"
      expr: equipment_subtype
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Frequency Bands"
      expr: frequency_bands
    - name: "Hardware Revision"
      expr: hardware_revision
    - name: "Hostname"
      expr: hostname
    - name: "Installation Date"
      expr: installation_date
    - name: "Ip Address"
      expr: ip_address
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Network Equipment"
      expr: COUNT(DISTINCT network_equipment_id)
    - name: "Total Max Power Draw Watts"
      expr: SUM(max_power_draw_watts)
    - name: "Average Max Power Draw Watts"
      expr: AVG(max_power_draw_watts)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Operating Temperature Max Celsius"
      expr: SUM(operating_temperature_max_celsius)
    - name: "Average Operating Temperature Max Celsius"
      expr: AVG(operating_temperature_max_celsius)
    - name: "Total Operating Temperature Min Celsius"
      expr: SUM(operating_temperature_min_celsius)
    - name: "Average Operating Temperature Min Celsius"
      expr: AVG(operating_temperature_min_celsius)
    - name: "Total Port Capacity Gbps"
      expr: SUM(port_capacity_gbps)
    - name: "Average Port Capacity Gbps"
      expr: AVG(port_capacity_gbps)
    - name: "Total Power Draw Watts"
      expr: SUM(power_draw_watts)
    - name: "Average Power Draw Watts"
      expr: AVG(power_draw_watts)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_olt_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Olt Asset business metrics"
  source: "`telecommunication_ecm`.`inventory`.`olt_asset`"
  dimensions:
    - name: "Active Pon Ports"
      expr: active_pon_ports
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Chassis Type"
      expr: chassis_type
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Ont Count"
      expr: current_ont_count
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Environmental Temperature Rating Celsius"
      expr: environmental_temperature_rating_celsius
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Installed Line Cards"
      expr: installed_line_cards
    - name: "Last Firmware Update Date"
      expr: last_firmware_update_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Line Card Slots"
      expr: line_card_slots
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Olt Asset"
      expr: COUNT(DISTINCT olt_asset_id)
    - name: "Total Mean Time Between Failures Hours"
      expr: SUM(mean_time_between_failures_hours)
    - name: "Average Mean Time Between Failures Hours"
      expr: AVG(mean_time_between_failures_hours)
    - name: "Total Mean Time To Repair Hours"
      expr: SUM(mean_time_to_repair_hours)
    - name: "Average Mean Time To Repair Hours"
      expr: AVG(mean_time_to_repair_hours)
    - name: "Total Power Consumption Watts"
      expr: SUM(power_consumption_watts)
    - name: "Average Power Consumption Watts"
      expr: AVG(power_consumption_watts)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_ont_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ont Asset business metrics"
  source: "`telecommunication_ecm`.`inventory`.`ont_asset`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Configuration Profile"
      expr: configuration_profile
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Device Type"
      expr: device_type
    - name: "Distance From Olt Meters"
      expr: distance_from_olt_meters
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Gpon Port Reference"
      expr: gpon_port_reference
    - name: "Hardware Version"
      expr: hardware_version
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Firmware Update Date"
      expr: last_firmware_update_date
    - name: "Last Online Timestamp"
      expr: last_online_timestamp
    - name: "Mac Address"
      expr: mac_address
    - name: "Max Downstream Bandwidth Mbps"
      expr: max_downstream_bandwidth_mbps
    - name: "Max Upstream Bandwidth Mbps"
      expr: max_upstream_bandwidth_mbps
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ont Asset"
      expr: COUNT(DISTINCT ont_asset_id)
    - name: "Total Optical Power Rx Dbm"
      expr: SUM(optical_power_rx_dbm)
    - name: "Average Optical Power Rx Dbm"
      expr: AVG(optical_power_rx_dbm)
    - name: "Total Optical Power Tx Dbm"
      expr: SUM(optical_power_tx_dbm)
    - name: "Average Optical Power Tx Dbm"
      expr: AVG(optical_power_tx_dbm)
    - name: "Total Temperature Celsius"
      expr: SUM(temperature_celsius)
    - name: "Average Temperature Celsius"
      expr: AVG(temperature_celsius)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`inventory_sim_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sim Stock business metrics"
  source: "`telecommunication_ecm`.`inventory`.`sim_stock`"
  dimensions:
    - name: "Activated Timestamp"
      expr: activated_timestamp
    - name: "Activation Code"
      expr: activation_code
    - name: "Activation Status"
      expr: activation_status
    - name: "Allocated Timestamp"
      expr: allocated_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Bin Location"
      expr: bin_location
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivated Timestamp"
      expr: deactivated_timestamp
    - name: "Download Timestamp"
      expr: download_timestamp
    - name: "Eid"
      expr: eid
    - name: "Esim Profile State"
      expr: esim_profile_state
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Form Factor"
      expr: form_factor
    - name: "Iccid"
      expr: iccid
    - name: "Imsi Range End"
      expr: imsi_range_end
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sim Stock"
      expr: COUNT(DISTINCT sim_stock_id)
    - name: "Total Ki Value"
      expr: SUM(ki_value)
    - name: "Average Ki Value"
      expr: AVG(ki_value)
    - name: "Total Opc Value"
      expr: SUM(opc_value)
    - name: "Average Opc Value"
      expr: AVG(opc_value)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;