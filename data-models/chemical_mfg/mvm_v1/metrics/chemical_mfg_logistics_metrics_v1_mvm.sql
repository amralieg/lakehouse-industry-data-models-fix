-- Metric views for domain: logistics | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:35:24

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill Of Lading business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`bill_of_lading`"
  dimensions:
    - name: "Bill Of Lading Status"
      expr: bill_of_lading_status
    - name: "Bol Number"
      expr: bol_number
    - name: "Bol Type"
      expr: bol_type
    - name: "Compliance Flags"
      expr: compliance_flags
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customs Declaration Number"
      expr: customs_declaration_number
    - name: "Declared Value Currency"
      expr: declared_value_currency
    - name: "Dot Certification Statement"
      expr: dot_certification_statement
    - name: "Emergency Contact Phone"
      expr: emergency_contact_phone
    - name: "Equipment Number"
      expr: equipment_number
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Freight Charge Currency"
      expr: freight_charge_currency
    - name: "Freight Class"
      expr: freight_class
    - name: "Hazmat Class"
      expr: hazmat_class
    - name: "Hazmat Flag"
      expr: hazmat_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bill Of Lading"
      expr: COUNT(DISTINCT bill_of_lading_id)
    - name: "Total Declared Value Amount"
      expr: SUM(declared_value_amount)
    - name: "Average Declared Value Amount"
      expr: AVG(declared_value_amount)
    - name: "Total Freight Charge Amount"
      expr: SUM(freight_charge_amount)
    - name: "Average Freight Charge Amount"
      expr: AVG(freight_charge_amount)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
    - name: "Total Volume M3"
      expr: SUM(volume_m3)
    - name: "Average Volume M3"
      expr: AVG(volume_m3)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "Approved Hazard Classes"
      expr: approved_hazard_classes
    - name: "Benchmark Comparison"
      expr: benchmark_comparison
    - name: "Carrier Description"
      expr: carrier_description
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Carrier Type"
      expr: carrier_type
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Corrective Action Flag"
      expr: corrective_action_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Ctpat Certified"
      expr: ctpat_certified
    - name: "Dot Carrier Number"
      expr: dot_carrier_number
    - name: "Fleet Size"
      expr: fleet_size
    - name: "Hazmat Certified"
      expr: hazmat_certified
    - name: "Hazmat Incident Count"
      expr: hazmat_incident_count
    - name: "Insurance Certificate Number"
      expr: insurance_certificate_number
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier"
      expr: COUNT(DISTINCT carrier_id)
    - name: "Total Average Load Capacity Tons"
      expr: SUM(average_load_capacity_tons)
    - name: "Average Average Load Capacity Tons"
      expr: AVG(average_load_capacity_tons)
    - name: "Total Damage Claim Rate"
      expr: SUM(damage_claim_rate)
    - name: "Average Damage Claim Rate"
      expr: AVG(damage_claim_rate)
    - name: "Total Invoice Accuracy Rate"
      expr: SUM(invoice_accuracy_rate)
    - name: "Average Invoice Accuracy Rate"
      expr: AVG(invoice_accuracy_rate)
    - name: "Total Performance On Time Delivery Rate"
      expr: SUM(performance_on_time_delivery_rate)
    - name: "Average Performance On Time Delivery Rate"
      expr: AVG(performance_on_time_delivery_rate)
    - name: "Total Performance On Time Pickup Rate"
      expr: SUM(performance_on_time_pickup_rate)
    - name: "Average Performance On Time Pickup Rate"
      expr: AVG(performance_on_time_pickup_rate)
    - name: "Total Safety Rating Score"
      expr: SUM(safety_rating_score)
    - name: "Average Safety Rating Score"
      expr: AVG(safety_rating_score)
    - name: "Total Tender Acceptance Rate"
      expr: SUM(tender_acceptance_rate)
    - name: "Average Tender Acceptance Rate"
      expr: AVG(tender_acceptance_rate)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_customs_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs Declaration business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`customs_declaration`"
  dimensions:
    - name: "Asn Number"
      expr: asn_number
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Clearance Date"
      expr: clearance_date
    - name: "Clearance Status"
      expr: clearance_status
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Broker Name"
      expr: customs_broker_name
    - name: "Declaration Date"
      expr: declaration_date
    - name: "Declaration Number"
      expr: declaration_number
    - name: "Declaration Status"
      expr: declaration_status
    - name: "Declaration Type"
      expr: declaration_type
    - name: "Destination Country"
      expr: destination_country
    - name: "Duty Currency"
      expr: duty_currency
    - name: "Eccn"
      expr: eccn
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customs Declaration"
      expr: COUNT(DISTINCT customs_declaration_id)
    - name: "Total Declared Value"
      expr: SUM(declared_value)
    - name: "Average Declared Value"
      expr: AVG(declared_value)
    - name: "Total Duty Amount"
      expr: SUM(duty_amount)
    - name: "Average Duty Amount"
      expr: AVG(duty_amount)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Tariff Rate Percent"
      expr: SUM(tariff_rate_percent)
    - name: "Average Tariff Rate Percent"
      expr: AVG(tariff_rate_percent)
    - name: "Total Volume M3"
      expr: SUM(volume_m3)
    - name: "Average Volume M3"
      expr: AVG(volume_m3)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_delivery_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery Confirmation business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`delivery_confirmation`"
  dimensions:
    - name: "Condition On Arrival"
      expr: condition_on_arrival
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Confirmation Status"
      expr: delivery_confirmation_status
    - name: "Delivery Timestamp"
      expr: delivery_timestamp
    - name: "Discrepancy Notes"
      expr: discrepancy_notes
    - name: "Exception Code"
      expr: exception_code
    - name: "Hazardous Material Indicator"
      expr: hazardous_material_indicator
    - name: "Pod Document Url"
      expr: pod_document_url
    - name: "Quantity Uom"
      expr: quantity_uom
    - name: "Receiver Signature"
      expr: receiver_signature
    - name: "Regulatory Compliance Flag"
      expr: regulatory_compliance_flag
    - name: "Transport Mode"
      expr: transport_mode
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Delivery Timestamp Month"
      expr: DATE_TRUNC('MONTH', delivery_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Delivery Confirmation"
      expr: COUNT(DISTINCT delivery_confirmation_id)
    - name: "Total Delivered Quantity"
      expr: SUM(delivered_quantity)
    - name: "Average Delivered Quantity"
      expr: AVG(delivered_quantity)
    - name: "Total Humidity Percent"
      expr: SUM(humidity_percent)
    - name: "Average Humidity Percent"
      expr: AVG(humidity_percent)
    - name: "Total Temperature C"
      expr: SUM(temperature_c)
    - name: "Average Temperature C"
      expr: AVG(temperature_c)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_freight_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight Order business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`freight_order`"
  dimensions:
    - name: "Asn Number"
      expr: asn_number
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Carrier Acceptance Status"
      expr: carrier_acceptance_status
    - name: "Carrier Mode"
      expr: carrier_mode
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contract Number"
      expr: contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Window End"
      expr: delivery_window_end
    - name: "Delivery Window Start"
      expr: delivery_window_start
    - name: "Dot Regulation Code"
      expr: dot_regulation_code
    - name: "Epa Regulation Code"
      expr: epa_regulation_code
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Freight Order Status"
      expr: freight_order_status
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Hazmat Class"
      expr: hazmat_class
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Freight Order"
      expr: COUNT(DISTINCT freight_order_id)
    - name: "Total Accessorial Charges"
      expr: SUM(accessorial_charges)
    - name: "Average Accessorial Charges"
      expr: AVG(accessorial_charges)
    - name: "Total Temperature Requirement C"
      expr: SUM(temperature_requirement_c)
    - name: "Average Temperature Requirement C"
      expr: AVG(temperature_requirement_c)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
    - name: "Total Volume Cubic M"
      expr: SUM(volume_cubic_m)
    - name: "Average Volume Cubic M"
      expr: AVG(volume_cubic_m)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_freight_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight Rate business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`freight_rate`"
  dimensions:
    - name: "Commodity Class"
      expr: commodity_class
    - name: "Compliance Hazmat Flag"
      expr: compliance_hazmat_flag
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Zone"
      expr: destination_zone
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Freight Rate Description"
      expr: freight_rate_description
    - name: "Freight Rate Status"
      expr: freight_rate_status
    - name: "Is Contractual"
      expr: is_contractual
    - name: "Lane Type"
      expr: lane_type
    - name: "Mode"
      expr: mode
    - name: "Origin Zone"
      expr: origin_zone
    - name: "Rate Code"
      expr: rate_code
    - name: "Rate Source System"
      expr: rate_source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Freight Rate"
      expr: COUNT(DISTINCT freight_rate_id)
    - name: "Total Fuel Surcharge Percent"
      expr: SUM(fuel_surcharge_percent)
    - name: "Average Fuel Surcharge Percent"
      expr: AVG(fuel_surcharge_percent)
    - name: "Total Hazmat Surcharge"
      expr: SUM(hazmat_surcharge)
    - name: "Average Hazmat Surcharge"
      expr: AVG(hazmat_surcharge)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Rate Value"
      expr: SUM(rate_value)
    - name: "Average Rate Value"
      expr: AVG(rate_value)
    - name: "Total Volume Limit Cubic Meters"
      expr: SUM(volume_limit_cubic_meters)
    - name: "Average Volume Limit Cubic Meters"
      expr: AVG(volume_limit_cubic_meters)
    - name: "Total Weight Limit Kg"
      expr: SUM(weight_limit_kg)
    - name: "Average Weight Limit Kg"
      expr: AVG(weight_limit_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_hazmat_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazmat Declaration business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`hazmat_declaration`"
  dimensions:
    - name: "Applicable Regulation"
      expr: applicable_regulation
    - name: "Compliance Review Date"
      expr: compliance_review_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Emergency Response Guide Number"
      expr: emergency_response_guide_number
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hazard Class"
      expr: hazard_class
    - name: "Hazard Division"
      expr: hazard_division
    - name: "Hazmat Declaration Status"
      expr: hazmat_declaration_status
    - name: "Is Exempt"
      expr: is_exempt
    - name: "Is Hazardous"
      expr: is_hazardous
    - name: "Line Number"
      expr: line_number
    - name: "Notes"
      expr: notes
    - name: "Packaging Type"
      expr: packaging_type
    - name: "Packing Group"
      expr: packing_group
    - name: "Ppe Requirements"
      expr: ppe_requirements
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hazmat Declaration"
      expr: COUNT(DISTINCT hazmat_declaration_id)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Temperature Limit Max"
      expr: SUM(temperature_limit_max)
    - name: "Average Temperature Limit Max"
      expr: AVG(temperature_limit_max)
    - name: "Total Temperature Limit Min"
      expr: SUM(temperature_limit_min)
    - name: "Average Temperature Limit Min"
      expr: AVG(temperature_limit_min)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_logistics_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics Party business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`logistics_party`"
  dimensions:
    - name: "Active Since"
      expr: active_since
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Business Unit"
      expr: business_unit
    - name: "City"
      expr: city
    - name: "Classification"
      expr: classification
    - name: "Compliance Documentation Url"
      expr: compliance_documentation_url
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Default Currency"
      expr: default_currency
    - name: "Dot Compliance Status"
      expr: dot_compliance_status
    - name: "Duns Number"
      expr: duns_number
    - name: "Ein Number"
      expr: ein_number
    - name: "Email Address"
      expr: email_address
    - name: "External Reference Code"
      expr: external_reference_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Logistics Party"
      expr: COUNT(DISTINCT logistics_party_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "Actual Arrival Timestamp"
      expr: actual_arrival_timestamp
    - name: "Actual Departure Timestamp"
      expr: actual_departure_timestamp
    - name: "Asn Number"
      expr: asn_number
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Declaration Number"
      expr: customs_declaration_number
    - name: "Dot Compliance Status"
      expr: dot_compliance_status
    - name: "Equipment Number"
      expr: equipment_number
    - name: "Estimated Transit Days"
      expr: estimated_transit_days
    - name: "Export Control Status"
      expr: export_control_status
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Hazardous Materials Indicator"
      expr: hazardous_materials_indicator
    - name: "Hazmat Class"
      expr: hazmat_class
    - name: "Number Of Packages"
      expr: number_of_packages
    - name: "Package Type"
      expr: package_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipment"
      expr: COUNT(DISTINCT shipment_id)
    - name: "Total Freight Amount Discount"
      expr: SUM(freight_amount_discount)
    - name: "Average Freight Amount Discount"
      expr: AVG(freight_amount_discount)
    - name: "Total Freight Amount Gross"
      expr: SUM(freight_amount_gross)
    - name: "Average Freight Amount Gross"
      expr: AVG(freight_amount_gross)
    - name: "Total Freight Amount Net"
      expr: SUM(freight_amount_net)
    - name: "Average Freight Amount Net"
      expr: AVG(freight_amount_net)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_shipment_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment Line business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`shipment_line`"
  dimensions:
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Declaration Required"
      expr: customs_declaration_required
    - name: "Customs Document Number"
      expr: customs_document_number
    - name: "Dot Label Required"
      expr: dot_label_required
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Freight Class"
      expr: freight_class
    - name: "Ghs Label Required"
      expr: ghs_label_required
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Is Freight Chargeable"
      expr: is_freight_chargeable
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Line Status"
      expr: line_status
    - name: "Manufacturing Date"
      expr: manufacturing_date
    - name: "Package Count"
      expr: package_count
    - name: "Package Type"
      expr: package_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipment Line"
      expr: COUNT(DISTINCT shipment_line_id)
    - name: "Total Freight Charge Amount"
      expr: SUM(freight_charge_amount)
    - name: "Average Freight Charge Amount"
      expr: AVG(freight_charge_amount)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Net Weight Kg"
      expr: SUM(net_weight_kg)
    - name: "Average Net Weight Kg"
      expr: AVG(net_weight_kg)
    - name: "Total Package Height Cm"
      expr: SUM(package_height_cm)
    - name: "Average Package Height Cm"
      expr: AVG(package_height_cm)
    - name: "Total Package Length Cm"
      expr: SUM(package_length_cm)
    - name: "Average Package Length Cm"
      expr: AVG(package_length_cm)
    - name: "Total Package Width Cm"
      expr: SUM(package_width_cm)
    - name: "Average Package Width Cm"
      expr: AVG(package_width_cm)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_shipment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment Plan business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`shipment_plan`"
  dimensions:
    - name: "Alternate Route Options"
      expr: alternate_route_options
    - name: "Arrival Date"
      expr: arrival_date
    - name: "Bridge Restriction Flag"
      expr: bridge_restriction_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Departure Date"
      expr: departure_date
    - name: "Estimated Transit Time Minutes"
      expr: estimated_transit_time_minutes
    - name: "Fuel Surcharge Basis"
      expr: fuel_surcharge_basis
    - name: "Hazmat Route Flag"
      expr: hazmat_route_flag
    - name: "Is Expedited"
      expr: is_expedited
    - name: "Notes"
      expr: notes
    - name: "Optimization Objective"
      expr: optimization_objective
    - name: "Plan Number"
      expr: plan_number
    - name: "Plan Timestamp"
      expr: plan_timestamp
    - name: "Planned Arrival Timestamp"
      expr: planned_arrival_timestamp
    - name: "Planned Departure Timestamp"
      expr: planned_departure_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shipment Plan"
      expr: COUNT(DISTINCT shipment_plan_id)
    - name: "Total Compliance Volume Limit M3"
      expr: SUM(compliance_volume_limit_m3)
    - name: "Average Compliance Volume Limit M3"
      expr: AVG(compliance_volume_limit_m3)
    - name: "Total Compliance Weight Limit Kg"
      expr: SUM(compliance_weight_limit_kg)
    - name: "Average Compliance Weight Limit Kg"
      expr: AVG(compliance_weight_limit_kg)
    - name: "Total Cost Adjustments"
      expr: SUM(cost_adjustments)
    - name: "Average Cost Adjustments"
      expr: AVG(cost_adjustments)
    - name: "Total Cost Gross"
      expr: SUM(cost_gross)
    - name: "Average Cost Gross"
      expr: AVG(cost_gross)
    - name: "Total Cost Net"
      expr: SUM(cost_net)
    - name: "Average Cost Net"
      expr: AVG(cost_net)
    - name: "Total Fuel Surcharge Amount"
      expr: SUM(fuel_surcharge_amount)
    - name: "Average Fuel Surcharge Amount"
      expr: AVG(fuel_surcharge_amount)
    - name: "Total Load Volume M3"
      expr: SUM(load_volume_m3)
    - name: "Average Load Volume M3"
      expr: AVG(load_volume_m3)
    - name: "Total Load Weight Kg"
      expr: SUM(load_weight_kg)
    - name: "Average Load Weight Kg"
      expr: AVG(load_weight_kg)
    - name: "Total Route Distance Km"
      expr: SUM(route_distance_km)
    - name: "Average Route Distance Km"
      expr: AVG(route_distance_km)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
    - name: "Total Vehicle Capacity Volume M3"
      expr: SUM(vehicle_capacity_volume_m3)
    - name: "Average Vehicle Capacity Volume M3"
      expr: AVG(vehicle_capacity_volume_m3)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`logistics_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle business metrics"
  source: "`chemical_mfg_ecm`.`logistics`.`vehicle`"
  dimensions:
    - name: "Annual Inspection Due Date"
      expr: annual_inspection_due_date
    - name: "Cleaning Certification Date"
      expr: cleaning_certification_date
    - name: "Cleaning Certification Status"
      expr: cleaning_certification_status
    - name: "Compliance Documentation Status"
      expr: compliance_documentation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cross Contamination Prevention"
      expr: cross_contamination_prevention
    - name: "Dedicated"
      expr: dedicated
    - name: "Emission Class"
      expr: emission_class
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Gps Enabled"
      expr: gps_enabled
    - name: "Gps Last Update"
      expr: gps_last_update
    - name: "Hazmat Placard Capability"
      expr: hazmat_placard_capability
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
    - name: "Insurance Policy Number"
      expr: insurance_policy_number
    - name: "Last Cargo Code"
      expr: last_cargo_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vehicle"
      expr: COUNT(DISTINCT vehicle_id)
    - name: "Total Gps Latitude"
      expr: SUM(gps_latitude)
    - name: "Average Gps Latitude"
      expr: AVG(gps_latitude)
    - name: "Total Gps Longitude"
      expr: SUM(gps_longitude)
    - name: "Average Gps Longitude"
      expr: AVG(gps_longitude)
    - name: "Total Maintenance Cycle Km"
      expr: SUM(maintenance_cycle_km)
    - name: "Average Maintenance Cycle Km"
      expr: AVG(maintenance_cycle_km)
    - name: "Total Max Payload Kg"
      expr: SUM(max_payload_kg)
    - name: "Average Max Payload Kg"
      expr: AVG(max_payload_kg)
    - name: "Total Odometer Km"
      expr: SUM(odometer_km)
    - name: "Average Odometer Km"
      expr: AVG(odometer_km)
    - name: "Total Tare Weight Kg"
      expr: SUM(tare_weight_kg)
    - name: "Average Tare Weight Kg"
      expr: AVG(tare_weight_kg)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
$$;