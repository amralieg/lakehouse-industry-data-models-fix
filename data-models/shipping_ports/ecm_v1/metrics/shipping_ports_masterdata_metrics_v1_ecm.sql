-- Metric views for domain: masterdata | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:47:27

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_cargo_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo Category business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`cargo_category`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Applicable Equipment Types"
      expr: applicable_equipment_types
    - name: "Category Code"
      expr: category_code
    - name: "Category Name"
      expr: category_name
    - name: "Category Type"
      expr: category_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Inspection Required"
      expr: customs_inspection_required
    - name: "Demurrage Applicable"
      expr: demurrage_applicable
    - name: "Detention Applicable"
      expr: detention_applicable
    - name: "Dwell Time Standard Days"
      expr: dwell_time_standard_days
    - name: "Edi Message Type"
      expr: edi_message_type
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Risk Level"
      expr: environmental_risk_level
    - name: "Handling Method"
      expr: handling_method
    - name: "Imdg Applicable"
      expr: imdg_applicable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cargo Category"
      expr: COUNT(DISTINCT cargo_category_id)
    - name: "Total Teu Conversion Factor"
      expr: SUM(teu_conversion_factor)
    - name: "Average Teu Conversion Factor"
      expr: AVG(teu_conversion_factor)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_commodity_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Code business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`commodity_code`"
  dimensions:
    - name: "Applicable Equipment Types"
      expr: applicable_equipment_types
    - name: "Commodity Code Status"
      expr: commodity_code_status
    - name: "Commodity Description"
      expr: commodity_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Steward"
      expr: data_steward
    - name: "Ems Number"
      expr: ems_number
    - name: "Excepted Quantity"
      expr: excepted_quantity
    - name: "Export License Required"
      expr: export_license_required
    - name: "Fumigation Required"
      expr: fumigation_required
    - name: "Handling Method"
      expr: handling_method
    - name: "Hs Chapter"
      expr: hs_chapter
    - name: "Hs Code"
      expr: hs_code
    - name: "Hs Heading"
      expr: hs_heading
    - name: "Hs Revision Year"
      expr: hs_revision_year
    - name: "Hs Subheading"
      expr: hs_subheading
    - name: "Import License Required"
      expr: import_license_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Code"
      expr: COUNT(DISTINCT commodity_code_id)
    - name: "Total Flash Point Celsius"
      expr: SUM(flash_point_celsius)
    - name: "Average Flash Point Celsius"
      expr: AVG(flash_point_celsius)
    - name: "Total Tariff Rate Percent"
      expr: SUM(tariff_rate_percent)
    - name: "Average Tariff Rate Percent"
      expr: AVG(tariff_rate_percent)
    - name: "Total Temperature Range Max Celsius"
      expr: SUM(temperature_range_max_celsius)
    - name: "Average Temperature Range Max Celsius"
      expr: AVG(temperature_range_max_celsius)
    - name: "Total Temperature Range Min Celsius"
      expr: SUM(temperature_range_min_celsius)
    - name: "Average Temperature Range Min Celsius"
      expr: AVG(temperature_range_min_celsius)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_container_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container Type business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`container_type`"
  dimensions:
    - name: "Container Category"
      expr: container_category
    - name: "Container Type Name"
      expr: container_type_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Steward"
      expr: data_steward
    - name: "Door Configuration"
      expr: door_configuration
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Handling Equipment Type"
      expr: handling_equipment_type
    - name: "Height Category"
      expr: height_category
    - name: "Height Mm"
      expr: height_mm
    - name: "Is Collapsible"
      expr: is_collapsible
    - name: "Is Hazmat Approved"
      expr: is_hazmat_approved
    - name: "Is Oog Capable"
      expr: is_oog_capable
    - name: "Is Reefer"
      expr: is_reefer
    - name: "Iso Standard Version"
      expr: iso_standard_version
    - name: "Iso Type Code"
      expr: iso_type_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Container Type"
      expr: COUNT(DISTINCT container_type_id)
    - name: "Total Internal Capacity Cbm"
      expr: SUM(internal_capacity_cbm)
    - name: "Average Internal Capacity Cbm"
      expr: AVG(internal_capacity_cbm)
    - name: "Total Max Gross Weight Kg"
      expr: SUM(max_gross_weight_kg)
    - name: "Average Max Gross Weight Kg"
      expr: AVG(max_gross_weight_kg)
    - name: "Total Max Payload Kg"
      expr: SUM(max_payload_kg)
    - name: "Average Max Payload Kg"
      expr: AVG(max_payload_kg)
    - name: "Total Reefer Temp Max Celsius"
      expr: SUM(reefer_temp_max_celsius)
    - name: "Average Reefer Temp Max Celsius"
      expr: AVG(reefer_temp_max_celsius)
    - name: "Total Reefer Temp Min Celsius"
      expr: SUM(reefer_temp_min_celsius)
    - name: "Average Reefer Temp Min Celsius"
      expr: AVG(reefer_temp_min_celsius)
    - name: "Total Swl Kg"
      expr: SUM(swl_kg)
    - name: "Average Swl Kg"
      expr: AVG(swl_kg)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
    - name: "Total Teu Equivalent"
      expr: SUM(teu_equivalent)
    - name: "Average Teu Equivalent"
      expr: AVG(teu_equivalent)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`country`"
  dimensions:
    - name: "Calling Code"
      expr: calling_code
    - name: "Country Name"
      expr: country_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Steward"
      expr: data_steward
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Fatf Status"
      expr: fatf_status
    - name: "Flag State Authority Contact"
      expr: flag_state_authority_contact
    - name: "Flag State Authority Name"
      expr: flag_state_authority_name
    - name: "Flag State Indicator"
      expr: flag_state_indicator
    - name: "Flag State Performance List"
      expr: flag_state_performance_list
    - name: "Imo Member Status"
      expr: imo_member_status
    - name: "Indian Ocean Mou Member"
      expr: indian_ocean_mou_member
    - name: "Iso Alpha 2 Code"
      expr: iso_alpha_2_code
    - name: "Iso Alpha 3 Code"
      expr: iso_alpha_3_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Country"
      expr: COUNT(DISTINCT country_id)
    - name: "Total Psc Targeting Factor"
      expr: SUM(psc_targeting_factor)
    - name: "Average Psc Targeting Factor"
      expr: AVG(psc_targeting_factor)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_edi_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Edi Partner business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`edi_partner`"
  dimensions:
    - name: "Acknowledgment Required"
      expr: acknowledgment_required
    - name: "Activation Date"
      expr: activation_date
    - name: "Authentication Method"
      expr: authentication_method
    - name: "Business Contact Email"
      expr: business_contact_email
    - name: "Business Contact Name"
      expr: business_contact_name
    - name: "Communication Protocol"
      expr: communication_protocol
    - name: "Connection Endpoint"
      expr: connection_endpoint
    - name: "Connection Status"
      expr: connection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Steward"
      expr: data_steward
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Edi Standard"
      expr: edi_standard
    - name: "Encryption Enabled"
      expr: encryption_enabled
    - name: "Last Inbound Message Timestamp"
      expr: last_inbound_message_timestamp
    - name: "Last Outbound Message Timestamp"
      expr: last_outbound_message_timestamp
    - name: "Last Successful Transmission Timestamp"
      expr: last_successful_transmission_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Edi Partner"
      expr: COUNT(DISTINCT edi_partner_id)
    - name: "Total Sla Availability Percentage"
      expr: SUM(sla_availability_percentage)
    - name: "Average Sla Availability Percentage"
      expr: AVG(sla_availability_percentage)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_equipment_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment Type business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`equipment_type`"
  dimensions:
    - name: "Automation Level"
      expr: automation_level
    - name: "Certification Interval Months"
      expr: certification_interval_months
    - name: "Certification Required Flag"
      expr: certification_required_flag
    - name: "Collision Avoidance System Flag"
      expr: collision_avoidance_system_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Steward"
      expr: data_steward
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Emission Standard"
      expr: emission_standard
    - name: "Environmental Compliance Flag"
      expr: environmental_compliance_flag
    - name: "Equipment Category"
      expr: equipment_category
    - name: "Equipment Subcategory"
      expr: equipment_subcategory
    - name: "Equipment Type Code"
      expr: equipment_type_code
    - name: "Equipment Type Name"
      expr: equipment_type_name
    - name: "Equipment Type Status"
      expr: equipment_type_status
    - name: "Gps Tracking Enabled Flag"
      expr: gps_tracking_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Equipment Type"
      expr: COUNT(DISTINCT equipment_type_id)
    - name: "Total Fuel Consumption Litres Per Hour"
      expr: SUM(fuel_consumption_litres_per_hour)
    - name: "Average Fuel Consumption Litres Per Hour"
      expr: AVG(fuel_consumption_litres_per_hour)
    - name: "Total Lift Height Metres"
      expr: SUM(lift_height_metres)
    - name: "Average Lift Height Metres"
      expr: AVG(lift_height_metres)
    - name: "Total Operational Speed Kmh"
      expr: SUM(operational_speed_kmh)
    - name: "Average Operational Speed Kmh"
      expr: AVG(operational_speed_kmh)
    - name: "Total Outreach Metres"
      expr: SUM(outreach_metres)
    - name: "Average Outreach Metres"
      expr: AVG(outreach_metres)
    - name: "Total Power Consumption Kw"
      expr: SUM(power_consumption_kw)
    - name: "Average Power Consumption Kw"
      expr: AVG(power_consumption_kw)
    - name: "Total Span Metres"
      expr: SUM(span_metres)
    - name: "Average Span Metres"
      expr: AVG(span_metres)
    - name: "Total Swl Rating Tonnes"
      expr: SUM(swl_rating_tonnes)
    - name: "Average Swl Rating Tonnes"
      expr: AVG(swl_rating_tonnes)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_flag_state`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flag State business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`flag_state`"
  dimensions:
    - name: "Active Status"
      expr: active_status
    - name: "Authority Contact Email"
      expr: authority_contact_email
    - name: "Authority Contact Phone"
      expr: authority_contact_phone
    - name: "Authority Name"
      expr: authority_name
    - name: "Authority Website Url"
      expr: authority_website_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Flag Of Convenience"
      expr: flag_of_convenience
    - name: "Flag State Code"
      expr: flag_state_code
    - name: "Flag State Name"
      expr: flag_state_name
    - name: "Imo Member Since Date"
      expr: imo_member_since_date
    - name: "Imo Member Status"
      expr: imo_member_status
    - name: "Indian Ocean Mou Member"
      expr: indian_ocean_mou_member
    - name: "Isps Code Compliant"
      expr: isps_code_compliant
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flag State"
      expr: COUNT(DISTINCT flag_state_id)
    - name: "Total Psc Targeting Factor"
      expr: SUM(psc_targeting_factor)
    - name: "Average Psc Targeting Factor"
      expr: AVG(psc_targeting_factor)
    - name: "Total Total Registered Dwt"
      expr: SUM(total_registered_dwt)
    - name: "Average Total Registered Dwt"
      expr: AVG(total_registered_dwt)
    - name: "Total Total Registered Grt"
      expr: SUM(total_registered_grt)
    - name: "Average Total Registered Grt"
      expr: AVG(total_registered_grt)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_imdg_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imdg Class business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`imdg_class`"
  dimensions:
    - name: "Class Name"
      expr: class_name
    - name: "Class Number"
      expr: class_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Steward"
      expr: data_steward
    - name: "Division"
      expr: division
    - name: "Ems Fire Code"
      expr: ems_fire_code
    - name: "Ems Spillage Code"
      expr: ems_spillage_code
    - name: "Excepted Quantity Code"
      expr: excepted_quantity_code
    - name: "Hazard Label Type"
      expr: hazard_label_type
    - name: "Imdg Code Amendment Cycle"
      expr: imdg_code_amendment_cycle
    - name: "Last Verified Date"
      expr: last_verified_date
    - name: "Limited Quantity Threshold"
      expr: limited_quantity_threshold
    - name: "Marine Pollutant Flag"
      expr: marine_pollutant_flag
    - name: "Marpol Annex Reference"
      expr: marpol_annex_reference
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Imdg Class"
      expr: COUNT(DISTINCT imdg_class_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_packaging_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging Type business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`packaging_type`"
  dimensions:
    - name: "Applicable Transport Modes"
      expr: applicable_transport_modes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Declaration Required"
      expr: customs_declaration_required
    - name: "Data Steward"
      expr: data_steward
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Fumigation Compatible"
      expr: fumigation_compatible
    - name: "Handling Equipment Type"
      expr: handling_equipment_type
    - name: "Height Mm"
      expr: height_mm
    - name: "Imdg Packing Group"
      expr: imdg_packing_group
    - name: "Iso Standard Version"
      expr: iso_standard_version
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Length Mm"
      expr: length_mm
    - name: "Marpol Compliant"
      expr: marpol_compliant
    - name: "Material Type"
      expr: material_type
    - name: "Maximum Stack Height"
      expr: maximum_stack_height
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Packaging Type"
      expr: COUNT(DISTINCT packaging_type_id)
    - name: "Total Maximum Capacity Liters"
      expr: SUM(maximum_capacity_liters)
    - name: "Average Maximum Capacity Liters"
      expr: AVG(maximum_capacity_liters)
    - name: "Total Maximum Gross Weight Kg"
      expr: SUM(maximum_gross_weight_kg)
    - name: "Average Maximum Gross Weight Kg"
      expr: AVG(maximum_gross_weight_kg)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_port_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port Location business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`port_location`"
  dimensions:
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Container Yard Capacity Teu"
      expr: container_yard_capacity_teu
    - name: "Crane Type"
      expr: crane_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Zone Code"
      expr: customs_zone_code
    - name: "Data Steward"
      expr: data_steward
    - name: "Decommissioning Date"
      expr: decommissioning_date
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Zone"
      expr: environmental_zone
    - name: "Fender Type"
      expr: fender_type
    - name: "Gate Lane Type"
      expr: gate_lane_type
    - name: "Icd Linkage Code"
      expr: icd_linkage_code
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Location Area"
      expr: location_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Port Location"
      expr: COUNT(DISTINCT port_location_id)
    - name: "Total Bollard Spacing Meters"
      expr: SUM(bollard_spacing_meters)
    - name: "Average Bollard Spacing Meters"
      expr: AVG(bollard_spacing_meters)
    - name: "Total Bollard Swl Tonnes"
      expr: SUM(bollard_swl_tonnes)
    - name: "Average Bollard Swl Tonnes"
      expr: AVG(bollard_swl_tonnes)
    - name: "Total Fender Energy Absorption Kj"
      expr: SUM(fender_energy_absorption_kj)
    - name: "Average Fender Energy Absorption Kj"
      expr: AVG(fender_energy_absorption_kj)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Maximum Vessel Beam Meters"
      expr: SUM(maximum_vessel_beam_meters)
    - name: "Average Maximum Vessel Beam Meters"
      expr: AVG(maximum_vessel_beam_meters)
    - name: "Total Maximum Vessel Dwt Tonnes"
      expr: SUM(maximum_vessel_dwt_tonnes)
    - name: "Average Maximum Vessel Dwt Tonnes"
      expr: AVG(maximum_vessel_dwt_tonnes)
    - name: "Total Maximum Vessel Loa Meters"
      expr: SUM(maximum_vessel_loa_meters)
    - name: "Average Maximum Vessel Loa Meters"
      expr: AVG(maximum_vessel_loa_meters)
    - name: "Total Water Depth Meters"
      expr: SUM(water_depth_meters)
    - name: "Average Water Depth Meters"
      expr: AVG(water_depth_meters)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`resource`"
  dimensions:
    - name: "Capacity Unit"
      expr: capacity_unit
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Commission Date"
      expr: commission_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Bond Number"
      expr: customs_bond_number
    - name: "Description"
      expr: description
    - name: "Home Port Code"
      expr: home_port_code
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
    - name: "Is Active"
      expr: is_active
    - name: "Is Hazmat Certified"
      expr: is_hazmat_certified
    - name: "Is Reefer Capable"
      expr: is_reefer_capable
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manufacture Date"
      expr: manufacture_date
    - name: "Manufacturer"
      expr: manufacturer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Resource"
      expr: COUNT(DISTINCT resource_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Capacity Value"
      expr: SUM(capacity_value)
    - name: "Average Capacity Value"
      expr: AVG(capacity_value)
    - name: "Total Current Book Value"
      expr: SUM(current_book_value)
    - name: "Average Current Book Value"
      expr: AVG(current_book_value)
    - name: "Total Height Meters"
      expr: SUM(height_meters)
    - name: "Average Height Meters"
      expr: AVG(height_meters)
    - name: "Total Length Meters"
      expr: SUM(length_meters)
    - name: "Average Length Meters"
      expr: AVG(length_meters)
    - name: "Total Max Gross Weight Kg"
      expr: SUM(max_gross_weight_kg)
    - name: "Average Max Gross Weight Kg"
      expr: AVG(max_gross_weight_kg)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
    - name: "Total Width Meters"
      expr: SUM(width_meters)
    - name: "Average Width Meters"
      expr: AVG(width_meters)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_service_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Code business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`service_code`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Billing Basis"
      expr: billing_basis
    - name: "Cost Gl Account"
      expr: cost_gl_account
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Steward"
      expr: data_steward
    - name: "Discount Eligible Flag"
      expr: discount_eligible_flag
    - name: "Edi Service Code"
      expr: edi_service_code
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Bundled Service"
      expr: is_bundled_service
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Regulatory Compliance Notes"
      expr: regulatory_compliance_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Code"
      expr: COUNT(DISTINCT service_code_id)
    - name: "Total Maximum Charge"
      expr: SUM(maximum_charge)
    - name: "Average Maximum Charge"
      expr: AVG(maximum_charge)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Standard Rate"
      expr: SUM(standard_rate)
    - name: "Average Standard Rate"
      expr: AVG(standard_rate)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_shipping_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipping Line business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`shipping_line`"
  dimensions:
    - name: "Alliance Membership"
      expr: alliance_membership
    - name: "Api Integration Enabled Flag"
      expr: api_integration_enabled_flag
    - name: "Bic Operator Code"
      expr: bic_operator_code
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Carrier Short Name"
      expr: carrier_short_name
    - name: "Commercial Account Reference"
      expr: commercial_account_reference
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Customs Broker Reference"
      expr: customs_broker_reference
    - name: "Dangerous Goods Approved Flag"
      expr: dangerous_goods_approved_flag
    - name: "Data Steward"
      expr: data_steward
    - name: "Edi Enabled Flag"
      expr: edi_enabled_flag
    - name: "Fleet Size Category"
      expr: fleet_size_category
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Iso Certification Status"
      expr: iso_certification_status
    - name: "Isps Compliant Flag"
      expr: isps_compliant_flag
    - name: "Last Audit Date"
      expr: last_audit_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipping Line"
      expr: COUNT(DISTINCT shipping_line_id)
    - name: "Total Average Teu Per Call"
      expr: SUM(average_teu_per_call)
    - name: "Average Average Teu Per Call"
      expr: AVG(average_teu_per_call)
    - name: "Total Average Vessel Calls Per Month"
      expr: SUM(average_vessel_calls_per_month)
    - name: "Average Average Vessel Calls Per Month"
      expr: AVG(average_vessel_calls_per_month)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_un_locode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Un Locode business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`un_locode`"
  dimensions:
    - name: "Coordinate Precision"
      expr: coordinate_precision
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Added"
      expr: date_added
    - name: "Date Last Modified"
      expr: date_last_modified
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Function Code"
      expr: function_code
    - name: "Iata Code"
      expr: iata_code
    - name: "Is Active"
      expr: is_active
    - name: "Is Airport"
      expr: is_airport
    - name: "Is Border Crossing"
      expr: is_border_crossing
    - name: "Is Fixed Transport Function"
      expr: is_fixed_transport_function
    - name: "Is Iaph Member"
      expr: is_iaph_member
    - name: "Is Inland Container Depot"
      expr: is_inland_container_depot
    - name: "Is Port"
      expr: is_port
    - name: "Is Postal Exchange"
      expr: is_postal_exchange
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Un Locode"
      expr: COUNT(DISTINCT un_locode_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_vessel_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel Master business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`vessel_master`"
  dimensions:
    - name: "Builder Name"
      expr: builder_name
    - name: "Call Sign"
      expr: call_sign
    - name: "Classification Society Code"
      expr: classification_society_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Steward"
      expr: data_steward
    - name: "Engine Type"
      expr: engine_type
    - name: "Feu Capacity"
      expr: feu_capacity
    - name: "Hull Number"
      expr: hull_number
    - name: "Ice Class"
      expr: ice_class
    - name: "Imo Number"
      expr: imo_number
    - name: "Is Current Record"
      expr: is_current_record
    - name: "Isps Compliant"
      expr: isps_compliant
    - name: "Issc Expiry Date"
      expr: issc_expiry_date
    - name: "Last Psc Inspection Date"
      expr: last_psc_inspection_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lloyds List Intelligence Reference"
      expr: lloyds_list_intelligence_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vessel Master"
      expr: COUNT(DISTINCT vessel_master_id)
    - name: "Total Beam Meters"
      expr: SUM(beam_meters)
    - name: "Average Beam Meters"
      expr: AVG(beam_meters)
    - name: "Total Grt"
      expr: SUM(grt)
    - name: "Average Grt"
      expr: AVG(grt)
    - name: "Total Loa Meters"
      expr: SUM(loa_meters)
    - name: "Average Loa Meters"
      expr: AVG(loa_meters)
    - name: "Total Maximum Draft Meters"
      expr: SUM(maximum_draft_meters)
    - name: "Average Maximum Draft Meters"
      expr: AVG(maximum_draft_meters)
    - name: "Total Nrt"
      expr: SUM(nrt)
    - name: "Average Nrt"
      expr: AVG(nrt)
    - name: "Total Propulsion Power Kw"
      expr: SUM(propulsion_power_kw)
    - name: "Average Propulsion Power Kw"
      expr: AVG(propulsion_power_kw)
    - name: "Total Summer Dwt"
      expr: SUM(summer_dwt)
    - name: "Average Summer Dwt"
      expr: AVG(summer_dwt)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_vessel_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel Type business metrics"
  source: "`shipping_ports_ecm`.`masterdata`.`vessel_type`"
  dimensions:
    - name: "Berth Compatibility Flag"
      expr: berth_compatibility_flag
    - name: "Cargo Handling Method"
      expr: cargo_handling_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dangerous Goods Capable"
      expr: dangerous_goods_capable
    - name: "Data Steward"
      expr: data_steward
    - name: "Environmental Category"
      expr: environmental_category
    - name: "Imo Vessel Type Code"
      expr: imo_vessel_type_code
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Marpol Annex Reference"
      expr: marpol_annex_reference
    - name: "Mobile Crane Compatible"
      expr: mobile_crane_compatible
    - name: "Navis Vessel Category Code"
      expr: navis_vessel_category_code
    - name: "Priority Ranking"
      expr: priority_ranking
    - name: "Requires Pilotage"
      expr: requires_pilotage
    - name: "Requires Towage"
      expr: requires_towage
    - name: "Solas Chapter Reference"
      expr: solas_chapter_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vessel Type"
      expr: COUNT(DISTINCT vessel_type_id)
    - name: "Total Typical Beam Max M"
      expr: SUM(typical_beam_max_m)
    - name: "Average Typical Beam Max M"
      expr: AVG(typical_beam_max_m)
    - name: "Total Typical Beam Min M"
      expr: SUM(typical_beam_min_m)
    - name: "Average Typical Beam Min M"
      expr: AVG(typical_beam_min_m)
    - name: "Total Typical Draft Max M"
      expr: SUM(typical_draft_max_m)
    - name: "Average Typical Draft Max M"
      expr: AVG(typical_draft_max_m)
    - name: "Total Typical Draft Min M"
      expr: SUM(typical_draft_min_m)
    - name: "Average Typical Draft Min M"
      expr: AVG(typical_draft_min_m)
    - name: "Total Typical Dwt Max"
      expr: SUM(typical_dwt_max)
    - name: "Average Typical Dwt Max"
      expr: AVG(typical_dwt_max)
    - name: "Total Typical Dwt Min"
      expr: SUM(typical_dwt_min)
    - name: "Average Typical Dwt Min"
      expr: AVG(typical_dwt_min)
    - name: "Total Typical Grt Max"
      expr: SUM(typical_grt_max)
    - name: "Average Typical Grt Max"
      expr: AVG(typical_grt_max)
    - name: "Total Typical Grt Min"
      expr: SUM(typical_grt_min)
    - name: "Average Typical Grt Min"
      expr: AVG(typical_grt_min)
    - name: "Total Typical Loa Max M"
      expr: SUM(typical_loa_max_m)
    - name: "Average Typical Loa Max M"
      expr: AVG(typical_loa_max_m)
    - name: "Total Typical Loa Min M"
      expr: SUM(typical_loa_min_m)
    - name: "Average Typical Loa Min M"
      expr: AVG(typical_loa_min_m)
$$;