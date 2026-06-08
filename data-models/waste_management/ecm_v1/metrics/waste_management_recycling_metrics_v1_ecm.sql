-- Metric views for domain: recycling | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 20:00:27

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_bale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bale business metrics"
  source: "`waste_management_ecm`.`recycling`.`bale`"
  dimensions:
    - name: "Allocated Timestamp"
      expr: allocated_timestamp
    - name: "Barcode"
      expr: barcode
    - name: "Bol Number"
      expr: bol_number
    - name: "Certification Number"
      expr: certification_number
    - name: "Commodity Subtype"
      expr: commodity_subtype
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days In Storage"
      expr: days_in_storage
    - name: "Grade"
      expr: grade
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Inspection Timestamp"
      expr: inspection_timestamp
    - name: "Inspection Type"
      expr: inspection_type
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Notes"
      expr: notes
    - name: "Production Shift"
      expr: production_shift
    - name: "Production Timestamp"
      expr: production_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bale"
      expr: COUNT(DISTINCT bale_id)
    - name: "Total Contamination Pct"
      expr: SUM(contamination_pct)
    - name: "Average Contamination Pct"
      expr: AVG(contamination_pct)
    - name: "Total Density Kg Per M3"
      expr: SUM(density_kg_per_m3)
    - name: "Average Density Kg Per M3"
      expr: AVG(density_kg_per_m3)
    - name: "Total Estimated Value Usd"
      expr: SUM(estimated_value_usd)
    - name: "Average Estimated Value Usd"
      expr: AVG(estimated_value_usd)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Length Cm"
      expr: SUM(length_cm)
    - name: "Average Length Cm"
      expr: AVG(length_cm)
    - name: "Total Market Price Per Ton"
      expr: SUM(market_price_per_ton)
    - name: "Average Market Price Per Ton"
      expr: AVG(market_price_per_ton)
    - name: "Total Moisture Pct"
      expr: SUM(moisture_pct)
    - name: "Average Moisture Pct"
      expr: AVG(moisture_pct)
    - name: "Total Weight Kg"
      expr: SUM(weight_kg)
    - name: "Average Weight Kg"
      expr: AVG(weight_kg)
    - name: "Total Width Cm"
      expr: SUM(width_cm)
    - name: "Average Width Cm"
      expr: AVG(width_cm)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_bale_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bale Inspection business metrics"
  source: "`waste_management_ecm`.`recycling`.`bale_inspection`"
  dimensions:
    - name: "Approved For Shipment"
      expr: approved_for_shipment
    - name: "Certification Number"
      expr: certification_number
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Contamination Type"
      expr: contamination_type
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Grade Assigned"
      expr: grade_assigned
    - name: "Inspection Duration Minutes"
      expr: inspection_duration_minutes
    - name: "Inspection Location"
      expr: inspection_location
    - name: "Inspection Notes"
      expr: inspection_notes
    - name: "Inspection Number"
      expr: inspection_number
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Inspection Timestamp"
      expr: inspection_timestamp
    - name: "Inspection Type"
      expr: inspection_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bale Inspection"
      expr: COUNT(DISTINCT bale_inspection_id)
    - name: "Total Actual Weight Lbs"
      expr: SUM(actual_weight_lbs)
    - name: "Average Actual Weight Lbs"
      expr: AVG(actual_weight_lbs)
    - name: "Total Contamination Percentage"
      expr: SUM(contamination_percentage)
    - name: "Average Contamination Percentage"
      expr: AVG(contamination_percentage)
    - name: "Total Moisture Content Percentage"
      expr: SUM(moisture_content_percentage)
    - name: "Average Moisture Content Percentage"
      expr: AVG(moisture_content_percentage)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_buyer_tsdf_return_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer Tsdf Return Agreement business metrics"
  source: "`waste_management_ecm`.`recycling`.`buyer_tsdf_return_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposal Cost Responsibility"
      expr: disposal_cost_responsibility
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Notification Protocol"
      expr: notification_protocol
    - name: "Preferred Waste Codes"
      expr: preferred_waste_codes
    - name: "Return Authorization Required"
      expr: return_authorization_required
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buyer Tsdf Return Agreement"
      expr: COUNT(DISTINCT buyer_tsdf_return_agreement_id)
    - name: "Total Contamination Threshold Pct"
      expr: SUM(contamination_threshold_pct)
    - name: "Average Contamination Threshold Pct"
      expr: AVG(contamination_threshold_pct)
    - name: "Total Max Annual Volume Tons"
      expr: SUM(max_annual_volume_tons)
    - name: "Average Max Annual Volume Tons"
      expr: AVG(max_annual_volume_tons)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity`"
  dimensions:
    - name: "Accepted Materials"
      expr: accepted_materials
    - name: "Amcs Commodity Code"
      expr: amcs_commodity_code
    - name: "Baling Required Flag"
      expr: baling_required_flag
    - name: "Commodity Category"
      expr: commodity_category
    - name: "Commodity Code"
      expr: commodity_code
    - name: "Commodity Name"
      expr: commodity_name
    - name: "Commodity Status"
      expr: commodity_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diversion Eligible Flag"
      expr: diversion_eligible_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "End Market Type"
      expr: end_market_type
    - name: "Epa Material Category Code"
      expr: epa_material_category_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Grade Description"
      expr: grade_description
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity"
      expr: COUNT(DISTINCT commodity_id)
    - name: "Total Base Price Per Ton"
      expr: SUM(base_price_per_ton)
    - name: "Average Base Price Per Ton"
      expr: AVG(base_price_per_ton)
    - name: "Total Contamination Fee Per Ton"
      expr: SUM(contamination_fee_per_ton)
    - name: "Average Contamination Fee Per Ton"
      expr: AVG(contamination_fee_per_ton)
    - name: "Total Ghg Emission Factor"
      expr: SUM(ghg_emission_factor)
    - name: "Average Ghg Emission Factor"
      expr: AVG(ghg_emission_factor)
    - name: "Total Max Bale Density Lbs Per Cf"
      expr: SUM(max_bale_density_lbs_per_cf)
    - name: "Average Max Bale Density Lbs Per Cf"
      expr: AVG(max_bale_density_lbs_per_cf)
    - name: "Total Max Contamination Pct"
      expr: SUM(max_contamination_pct)
    - name: "Average Max Contamination Pct"
      expr: AVG(max_contamination_pct)
    - name: "Total Max Moisture Pct"
      expr: SUM(max_moisture_pct)
    - name: "Average Max Moisture Pct"
      expr: AVG(max_moisture_pct)
    - name: "Total Min Bale Density Lbs Per Cf"
      expr: SUM(min_bale_density_lbs_per_cf)
    - name: "Average Min Bale Density Lbs Per Cf"
      expr: AVG(min_bale_density_lbs_per_cf)
    - name: "Total Min Processing Throughput Tpd"
      expr: SUM(min_processing_throughput_tpd)
    - name: "Average Min Processing Throughput Tpd"
      expr: AVG(min_processing_throughput_tpd)
    - name: "Total Price Floor Per Ton"
      expr: SUM(price_floor_per_ton)
    - name: "Average Price Floor Per Ton"
      expr: AVG(price_floor_per_ton)
    - name: "Total Standard Bale Weight Lbs"
      expr: SUM(standard_bale_weight_lbs)
    - name: "Average Standard Bale Weight Lbs"
      expr: AVG(standard_bale_weight_lbs)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_acceptance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Acceptance business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_acceptance`"
  dimensions:
    - name: "Acceptance Status"
      expr: acceptance_status
    - name: "Accepted Grade List"
      expr: accepted_grade_list
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Pricing Basis"
      expr: pricing_basis
    - name: "Rejection Reason Code"
      expr: rejection_reason_code
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Acceptance"
      expr: COUNT(DISTINCT commodity_acceptance_id)
    - name: "Total Contamination Threshold Pct"
      expr: SUM(contamination_threshold_pct)
    - name: "Average Contamination Threshold Pct"
      expr: AVG(contamination_threshold_pct)
    - name: "Total Minimum Volume Lbs"
      expr: SUM(minimum_volume_lbs)
    - name: "Average Minimum Volume Lbs"
      expr: AVG(minimum_volume_lbs)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_buyer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Buyer business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_buyer`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Buyer Established Date"
      expr: buyer_established_date
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Buyer Type"
      expr: buyer_type
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Status"
      expr: credit_status
    - name: "Last Transaction Date"
      expr: last_transaction_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Buyer"
      expr: COUNT(DISTINCT commodity_buyer_id)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Minimum Order Quantity Tons"
      expr: SUM(minimum_order_quantity_tons)
    - name: "Average Minimum Order Quantity Tons"
      expr: AVG(minimum_order_quantity_tons)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_grade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Grade business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_grade`"
  dimensions:
    - name: "Applicable Mrf Region"
      expr: applicable_mrf_region
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Bale Dimension Spec"
      expr: bale_dimension_spec
    - name: "Buyer Acceptance Required"
      expr: buyer_acceptance_required
    - name: "Color Specification"
      expr: color_specification
    - name: "Commodity Subtype"
      expr: commodity_subtype
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diversion Rate Credit"
      expr: diversion_rate_credit
    - name: "Domestic Export Eligibility"
      expr: domestic_export_eligibility
    - name: "Effective Date"
      expr: effective_date
    - name: "End Market Type"
      expr: end_market_type
    - name: "Epa Commodity Code"
      expr: epa_commodity_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Grade Code"
      expr: grade_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Grade"
      expr: COUNT(DISTINCT commodity_grade_id)
    - name: "Total Co2e Avoided Per Ton"
      expr: SUM(co2e_avoided_per_ton)
    - name: "Average Co2e Avoided Per Ton"
      expr: AVG(co2e_avoided_per_ton)
    - name: "Total Market Price Factor"
      expr: SUM(market_price_factor)
    - name: "Average Market Price Factor"
      expr: AVG(market_price_factor)
    - name: "Total Max Bale Weight Lbs"
      expr: SUM(max_bale_weight_lbs)
    - name: "Average Max Bale Weight Lbs"
      expr: AVG(max_bale_weight_lbs)
    - name: "Total Max Contamination Pct"
      expr: SUM(max_contamination_pct)
    - name: "Average Max Contamination Pct"
      expr: AVG(max_contamination_pct)
    - name: "Total Max Moisture Pct"
      expr: SUM(max_moisture_pct)
    - name: "Average Max Moisture Pct"
      expr: AVG(max_moisture_pct)
    - name: "Total Max Particle Size Inches"
      expr: SUM(max_particle_size_inches)
    - name: "Average Max Particle Size Inches"
      expr: AVG(max_particle_size_inches)
    - name: "Total Min Bale Density Lbs Per Cuft"
      expr: SUM(min_bale_density_lbs_per_cuft)
    - name: "Average Min Bale Density Lbs Per Cuft"
      expr: AVG(min_bale_density_lbs_per_cuft)
    - name: "Total Min Purity Pct"
      expr: SUM(min_purity_pct)
    - name: "Average Min Purity Pct"
      expr: AVG(min_purity_pct)
    - name: "Total Min Sample Size Lbs"
      expr: SUM(min_sample_size_lbs)
    - name: "Average Min Sample Size Lbs"
      expr: AVG(min_sample_size_lbs)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Inventory business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_inventory`"
  dimensions:
    - name: "Allocated Bales"
      expr: allocated_bales
    - name: "Available Bales"
      expr: available_bales
    - name: "Average Bale Age Days"
      expr: average_bale_age_days
    - name: "Batch Number"
      expr: batch_number
    - name: "Commodity Grade"
      expr: commodity_grade
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Inventory Turnover Days"
      expr: inventory_turnover_days
    - name: "Last Physical Count Date"
      expr: last_physical_count_date
    - name: "Last Quality Inspection Date"
      expr: last_quality_inspection_date
    - name: "Material Number"
      expr: material_number
    - name: "Notes"
      expr: notes
    - name: "Oldest Bale Production Date"
      expr: oldest_bale_production_date
    - name: "Plant Code"
      expr: plant_code
    - name: "Price Effective Date"
      expr: price_effective_date
    - name: "Quality Certification Status"
      expr: quality_certification_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Inventory"
      expr: COUNT(DISTINCT commodity_inventory_id)
    - name: "Total Allocated Weight Tons"
      expr: SUM(allocated_weight_tons)
    - name: "Average Allocated Weight Tons"
      expr: AVG(allocated_weight_tons)
    - name: "Total Available Weight Tons"
      expr: SUM(available_weight_tons)
    - name: "Average Available Weight Tons"
      expr: AVG(available_weight_tons)
    - name: "Total Contamination Rate Percent"
      expr: SUM(contamination_rate_percent)
    - name: "Average Contamination Rate Percent"
      expr: AVG(contamination_rate_percent)
    - name: "Total Inventory Valuation Amount"
      expr: SUM(inventory_valuation_amount)
    - name: "Average Inventory Valuation Amount"
      expr: AVG(inventory_valuation_amount)
    - name: "Total Market Price Per Ton"
      expr: SUM(market_price_per_ton)
    - name: "Average Market Price Per Ton"
      expr: AVG(market_price_per_ton)
    - name: "Total Maximum Capacity Tons"
      expr: SUM(maximum_capacity_tons)
    - name: "Average Maximum Capacity Tons"
      expr: AVG(maximum_capacity_tons)
    - name: "Total Reorder Point Tons"
      expr: SUM(reorder_point_tons)
    - name: "Average Reorder Point Tons"
      expr: AVG(reorder_point_tons)
    - name: "Total Storage Capacity Utilization Percent"
      expr: SUM(storage_capacity_utilization_percent)
    - name: "Average Storage Capacity Utilization Percent"
      expr: AVG(storage_capacity_utilization_percent)
    - name: "Total Total Weight Tons"
      expr: SUM(total_weight_tons)
    - name: "Average Total Weight Tons"
      expr: AVG(total_weight_tons)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_regulatory_applicability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Regulatory Applicability business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_regulatory_applicability`"
  dimensions:
    - name: "Commodity Regulatory Applicability Status"
      expr: commodity_regulatory_applicability_status
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Compliance Threshold"
      expr: compliance_threshold
    - name: "Created Date"
      expr: created_date
    - name: "Documentation Standard"
      expr: documentation_standard
    - name: "Effective Date"
      expr: effective_date
    - name: "Exemption Reference Number"
      expr: exemption_reference_number
    - name: "Exemption Status"
      expr: exemption_status
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Compliance Review Date"
      expr: last_compliance_review_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Next Compliance Review Date"
      expr: next_compliance_review_date
    - name: "Requirement Applicability"
      expr: requirement_applicability
    - name: "Responsible Compliance Officer"
      expr: responsible_compliance_officer
    - name: "Testing Frequency"
      expr: testing_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Regulatory Applicability"
      expr: COUNT(DISTINCT commodity_regulatory_applicability_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_sale`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Sale business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_sale`"
  dimensions:
    - name: "Bol Number"
      expr: bol_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Address"
      expr: destination_address
    - name: "Destination City"
      expr: destination_city
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Postal Code"
      expr: destination_postal_code
    - name: "Destination State"
      expr: destination_state
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Is Export Sale"
      expr: is_export_sale
    - name: "Market Index Reference"
      expr: market_index_reference
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Received Date"
      expr: payment_received_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Sale"
      expr: COUNT(DISTINCT commodity_sale_id)
    - name: "Total Adjustment Amount Usd"
      expr: SUM(adjustment_amount_usd)
    - name: "Average Adjustment Amount Usd"
      expr: AVG(adjustment_amount_usd)
    - name: "Total Contamination Rate Percent"
      expr: SUM(contamination_rate_percent)
    - name: "Average Contamination Rate Percent"
      expr: AVG(contamination_rate_percent)
    - name: "Total Freight Charge Usd"
      expr: SUM(freight_charge_usd)
    - name: "Average Freight Charge Usd"
      expr: AVG(freight_charge_usd)
    - name: "Total Net Sale Amount Usd"
      expr: SUM(net_sale_amount_usd)
    - name: "Average Net Sale Amount Usd"
      expr: AVG(net_sale_amount_usd)
    - name: "Total Total Gross Weight Tons"
      expr: SUM(total_gross_weight_tons)
    - name: "Average Total Gross Weight Tons"
      expr: AVG(total_gross_weight_tons)
    - name: "Total Total Net Weight Tons"
      expr: SUM(total_net_weight_tons)
    - name: "Average Total Net Weight Tons"
      expr: AVG(total_net_weight_tons)
    - name: "Total Total Sale Amount Usd"
      expr: SUM(total_sale_amount_usd)
    - name: "Average Total Sale Amount Usd"
      expr: AVG(total_sale_amount_usd)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_commodity_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity Supply Agreement business metrics"
  source: "`waste_management_ecm`.`recycling`.`commodity_supply_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Contract Number"
      expr: contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Payment Terms Code"
      expr: payment_terms_code
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Quality Grade"
      expr: quality_grade
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commodity Supply Agreement"
      expr: COUNT(DISTINCT commodity_supply_agreement_id)
    - name: "Total Lead Time Days"
      expr: SUM(lead_time_days)
    - name: "Average Lead Time Days"
      expr: AVG(lead_time_days)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_contamination_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contamination Event business metrics"
  source: "`waste_management_ecm`.`recycling`.`contamination_event`"
  dimensions:
    - name: "Analysis Type"
      expr: analysis_type
    - name: "Contamination Level"
      expr: contamination_level
    - name: "Contamination Type"
      expr: contamination_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Sent"
      expr: customer_notification_sent
    - name: "Detection Method"
      expr: detection_method
    - name: "Disposition Action"
      expr: disposition_action
    - name: "Epa Reportable"
      expr: epa_reportable
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Notification Sent Timestamp"
      expr: notification_sent_timestamp
    - name: "Photo Evidence Url"
      expr: photo_evidence_url
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Event Timestamp Month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contamination Event"
      expr: COUNT(DISTINCT contamination_event_id)
    - name: "Total Commodity Value Loss Usd"
      expr: SUM(commodity_value_loss_usd)
    - name: "Average Commodity Value Loss Usd"
      expr: AVG(commodity_value_loss_usd)
    - name: "Total Contaminants Percentage"
      expr: SUM(contaminants_percentage)
    - name: "Average Contaminants Percentage"
      expr: AVG(contaminants_percentage)
    - name: "Total Diversion Impact Tons"
      expr: SUM(diversion_impact_tons)
    - name: "Average Diversion Impact Tons"
      expr: AVG(diversion_impact_tons)
    - name: "Total Fiber Percentage"
      expr: SUM(fiber_percentage)
    - name: "Average Fiber Percentage"
      expr: AVG(fiber_percentage)
    - name: "Total Glass Percentage"
      expr: SUM(glass_percentage)
    - name: "Average Glass Percentage"
      expr: AVG(glass_percentage)
    - name: "Total Metals Percentage"
      expr: SUM(metals_percentage)
    - name: "Average Metals Percentage"
      expr: AVG(metals_percentage)
    - name: "Total Organics Percentage"
      expr: SUM(organics_percentage)
    - name: "Average Organics Percentage"
      expr: AVG(organics_percentage)
    - name: "Total Plastics Percentage"
      expr: SUM(plastics_percentage)
    - name: "Average Plastics Percentage"
      expr: AVG(plastics_percentage)
    - name: "Total Processing Cost Impact Usd"
      expr: SUM(processing_cost_impact_usd)
    - name: "Average Processing Cost Impact Usd"
      expr: AVG(processing_cost_impact_usd)
    - name: "Total Sample Weight Lbs"
      expr: SUM(sample_weight_lbs)
    - name: "Average Sample Weight Lbs"
      expr: AVG(sample_weight_lbs)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_epa_recycling_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Epa Recycling Report business metrics"
  source: "`waste_management_ecm`.`recycling`.`epa_recycling_report`"
  dimensions:
    - name: "Certification Date"
      expr: certification_date
    - name: "Certifying Official Name"
      expr: certifying_official_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enviance Submission Reference"
      expr: enviance_submission_reference
    - name: "Late Submission Flag"
      expr: late_submission_flag
    - name: "Processing Days"
      expr: processing_days
    - name: "Regulatory Agency"
      expr: regulatory_agency
    - name: "Regulatory Agency Name"
      expr: regulatory_agency_name
    - name: "Regulatory Reference Number"
      expr: regulatory_reference_number
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Report Notes"
      expr: report_notes
    - name: "Report Number"
      expr: report_number
    - name: "Report Preparer Name"
      expr: report_preparer_name
    - name: "Report Preparer Title"
      expr: report_preparer_title
    - name: "Report Status"
      expr: report_status
    - name: "Report Type"
      expr: report_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Epa Recycling Report"
      expr: COUNT(DISTINCT epa_recycling_report_id)
    - name: "Total Average Daily Throughput Tpd"
      expr: SUM(average_daily_throughput_tpd)
    - name: "Average Average Daily Throughput Tpd"
      expr: AVG(average_daily_throughput_tpd)
    - name: "Total Contamination Rate Pct"
      expr: SUM(contamination_rate_pct)
    - name: "Average Contamination Rate Pct"
      expr: AVG(contamination_rate_pct)
    - name: "Total Diversion Rate Pct"
      expr: SUM(diversion_rate_pct)
    - name: "Average Diversion Rate Pct"
      expr: AVG(diversion_rate_pct)
    - name: "Total Ghg Emissions Avoided Co2e Tons"
      expr: SUM(ghg_emissions_avoided_co2e_tons)
    - name: "Average Ghg Emissions Avoided Co2e Tons"
      expr: AVG(ghg_emissions_avoided_co2e_tons)
    - name: "Total Glass Tons Recycled"
      expr: SUM(glass_tons_recycled)
    - name: "Average Glass Tons Recycled"
      expr: AVG(glass_tons_recycled)
    - name: "Total Metal Tons Recycled"
      expr: SUM(metal_tons_recycled)
    - name: "Average Metal Tons Recycled"
      expr: AVG(metal_tons_recycled)
    - name: "Total Organics Tons Recycled"
      expr: SUM(organics_tons_recycled)
    - name: "Average Organics Tons Recycled"
      expr: AVG(organics_tons_recycled)
    - name: "Total Other Commodity Tons Recycled"
      expr: SUM(other_commodity_tons_recycled)
    - name: "Average Other Commodity Tons Recycled"
      expr: AVG(other_commodity_tons_recycled)
    - name: "Total Paper Tons Recycled"
      expr: SUM(paper_tons_recycled)
    - name: "Average Paper Tons Recycled"
      expr: AVG(paper_tons_recycled)
    - name: "Total Plastic Tons Recycled"
      expr: SUM(plastic_tons_recycled)
    - name: "Average Plastic Tons Recycled"
      expr: AVG(plastic_tons_recycled)
    - name: "Total Residue Tons"
      expr: SUM(residue_tons)
    - name: "Average Residue Tons"
      expr: AVG(residue_tons)
    - name: "Total Total Tons Received"
      expr: SUM(total_tons_received)
    - name: "Average Total Tons Received"
      expr: AVG(total_tons_received)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_equipment_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment Certification business metrics"
  source: "`waste_management_ecm`.`recycling`.`equipment_certification`"
  dimensions:
    - name: "Authorization Status"
      expr: authorization_status
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Expiration Date"
      expr: certification_expiration_date
    - name: "Incident Count"
      expr: incident_count
    - name: "Last Proficiency Assessment Date"
      expr: last_proficiency_assessment_date
    - name: "Next Proficiency Assessment Due Date"
      expr: next_proficiency_assessment_due_date
    - name: "Notes"
      expr: notes
    - name: "Proficiency Level"
      expr: proficiency_level
    - name: "Training Completion Date"
      expr: training_completion_date
    - name: "Certification Date Month"
      expr: DATE_TRUNC('MONTH', certification_date)
    - name: "Certification Expiration Date Month"
      expr: DATE_TRUNC('MONTH', certification_expiration_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Equipment Certification"
      expr: COUNT(DISTINCT equipment_certification_id)
    - name: "Total Total Operating Hours"
      expr: SUM(total_operating_hours)
    - name: "Average Total Operating Hours"
      expr: AVG(total_operating_hours)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_facility_initiative_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility Initiative Participation business metrics"
  source: "`waste_management_ecm`.`recycling`.`facility_initiative_participation`"
  dimensions:
    - name: "Facility Project Manager"
      expr: facility_project_manager
    - name: "Facility Role In Initiative"
      expr: facility_role_in_initiative
    - name: "Facility Status"
      expr: facility_status
    - name: "Implementation Notes"
      expr: implementation_notes
    - name: "Participation End Date"
      expr: participation_end_date
    - name: "Participation Start Date"
      expr: participation_start_date
    - name: "Participation End Date Month"
      expr: DATE_TRUNC('MONTH', participation_end_date)
    - name: "Participation Start Date Month"
      expr: DATE_TRUNC('MONTH', participation_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Facility Initiative Participation"
      expr: COUNT(DISTINCT facility_initiative_participation_id)
    - name: "Total Actual Reduction Tons"
      expr: SUM(actual_reduction_tons)
    - name: "Average Actual Reduction Tons"
      expr: AVG(actual_reduction_tons)
    - name: "Total Baseline Emissions Tons"
      expr: SUM(baseline_emissions_tons)
    - name: "Average Baseline Emissions Tons"
      expr: AVG(baseline_emissions_tons)
    - name: "Total Facility Contribution Co2e Tons"
      expr: SUM(facility_contribution_co2e_tons)
    - name: "Average Facility Contribution Co2e Tons"
      expr: AVG(facility_contribution_co2e_tons)
    - name: "Total Facility Investment Amount"
      expr: SUM(facility_investment_amount)
    - name: "Average Facility Investment Amount"
      expr: AVG(facility_investment_amount)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_facility_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility Permit business metrics"
  source: "`waste_management_ecm`.`recycling`.`facility_permit`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Compliance Officer Assigned"
      expr: compliance_officer_assigned
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Facility Specific Conditions"
      expr: facility_specific_conditions
    - name: "Last Compliance Report Date"
      expr: last_compliance_report_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Next Compliance Report Due Date"
      expr: next_compliance_report_due_date
    - name: "Next Inspection Due Date"
      expr: next_inspection_due_date
    - name: "Permit Role"
      expr: permit_role
    - name: "Termination Date"
      expr: termination_date
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Facility Permit"
      expr: COUNT(DISTINCT facility_permit_id)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_inbound_load`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound Load business metrics"
  source: "`waste_management_ecm`.`recycling`.`inbound_load`"
  dimensions:
    - name: "Amcs Load Reference"
      expr: amcs_load_reference
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Contamination Flag"
      expr: contamination_flag
    - name: "Contamination Type"
      expr: contamination_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Is Audited"
      expr: is_audited
    - name: "Load Notes"
      expr: load_notes
    - name: "Load Source Type"
      expr: load_source_type
    - name: "Load Status"
      expr: load_status
    - name: "Manifest Number"
      expr: manifest_number
    - name: "Material Stream Type"
      expr: material_stream_type
    - name: "Processing Shift"
      expr: processing_shift
    - name: "Received Timestamp"
      expr: received_timestamp
    - name: "Receiving Dock"
      expr: receiving_dock
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Sap Material Doc Number"
      expr: sap_material_doc_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inbound Load"
      expr: COUNT(DISTINCT inbound_load_id)
    - name: "Total Contamination Pct"
      expr: SUM(contamination_pct)
    - name: "Average Contamination Pct"
      expr: AVG(contamination_pct)
    - name: "Total Contamination Surcharge"
      expr: SUM(contamination_surcharge)
    - name: "Average Contamination Surcharge"
      expr: AVG(contamination_surcharge)
    - name: "Total Estimated Diversion Tons"
      expr: SUM(estimated_diversion_tons)
    - name: "Average Estimated Diversion Tons"
      expr: AVG(estimated_diversion_tons)
    - name: "Total Gross Weight Tons"
      expr: SUM(gross_weight_tons)
    - name: "Average Gross Weight Tons"
      expr: AVG(gross_weight_tons)
    - name: "Total Net Weight Tons"
      expr: SUM(net_weight_tons)
    - name: "Average Net Weight Tons"
      expr: AVG(net_weight_tons)
    - name: "Total Tare Weight Tons"
      expr: SUM(tare_weight_tons)
    - name: "Average Tare Weight Tons"
      expr: AVG(tare_weight_tons)
    - name: "Total Tipping Fee Amount"
      expr: SUM(tipping_fee_amount)
    - name: "Average Tipping Fee Amount"
      expr: AVG(tipping_fee_amount)
    - name: "Total Tipping Fee Rate"
      expr: SUM(tipping_fee_rate)
    - name: "Average Tipping Fee Rate"
      expr: AVG(tipping_fee_rate)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_market_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market Price business metrics"
  source: "`waste_management_ecm`.`recycling`.`market_price`"
  dimensions:
    - name: "Commodity Grade"
      expr: commodity_grade
    - name: "Contract Number"
      expr: contract_number
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Market Condition"
      expr: market_condition
    - name: "Modified By User"
      expr: modified_by_user
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Terms Days"
      expr: payment_terms_days
    - name: "Price Adjustment Frequency"
      expr: price_adjustment_frequency
    - name: "Price Change Reason"
      expr: price_change_reason
    - name: "Price Effective Date"
      expr: price_effective_date
    - name: "Price Expiration Date"
      expr: price_expiration_date
    - name: "Price Index Reference"
      expr: price_index_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Market Price"
      expr: COUNT(DISTINCT market_price_id)
    - name: "Total Contamination Adjustment Factor"
      expr: SUM(contamination_adjustment_factor)
    - name: "Average Contamination Adjustment Factor"
      expr: AVG(contamination_adjustment_factor)
    - name: "Total Minimum Order Quantity Tons"
      expr: SUM(minimum_order_quantity_tons)
    - name: "Average Minimum Order Quantity Tons"
      expr: AVG(minimum_order_quantity_tons)
    - name: "Total Price Ceiling Per Ton Usd"
      expr: SUM(price_ceiling_per_ton_usd)
    - name: "Average Price Ceiling Per Ton Usd"
      expr: AVG(price_ceiling_per_ton_usd)
    - name: "Total Price Change Percentage"
      expr: SUM(price_change_percentage)
    - name: "Average Price Change Percentage"
      expr: AVG(price_change_percentage)
    - name: "Total Price Floor Per Ton Usd"
      expr: SUM(price_floor_per_ton_usd)
    - name: "Average Price Floor Per Ton Usd"
      expr: AVG(price_floor_per_ton_usd)
    - name: "Total Price Per Ton Usd"
      expr: SUM(price_per_ton_usd)
    - name: "Average Price Per Ton Usd"
      expr: AVG(price_per_ton_usd)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_material_composition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Composition business metrics"
  source: "`waste_management_ecm`.`recycling`.`material_composition`"
  dimensions:
    - name: "Analysis Method"
      expr: analysis_method
    - name: "Analysis Number"
      expr: analysis_number
    - name: "Analysis Status"
      expr: analysis_status
    - name: "Analysis Timestamp"
      expr: analysis_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Hazardous Material Description"
      expr: hazardous_material_description
    - name: "Hazardous Material Found"
      expr: hazardous_material_found
    - name: "Material Stream Type"
      expr: material_stream_type
    - name: "Qc Notes"
      expr: qc_notes
    - name: "Qc Review Timestamp"
      expr: qc_review_timestamp
    - name: "Reporting Period"
      expr: reporting_period
    - name: "Sample Source Type"
      expr: sample_source_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Analysis Timestamp Month"
      expr: DATE_TRUNC('MONTH', analysis_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Composition"
      expr: COUNT(DISTINCT material_composition_id)
    - name: "Total Aluminum Pct"
      expr: SUM(aluminum_pct)
    - name: "Average Aluminum Pct"
      expr: AVG(aluminum_pct)
    - name: "Total Clear Glass Pct"
      expr: SUM(clear_glass_pct)
    - name: "Average Clear Glass Pct"
      expr: AVG(clear_glass_pct)
    - name: "Total Colored Glass Pct"
      expr: SUM(colored_glass_pct)
    - name: "Average Colored Glass Pct"
      expr: AVG(colored_glass_pct)
    - name: "Total Contamination Pct"
      expr: SUM(contamination_pct)
    - name: "Average Contamination Pct"
      expr: AVG(contamination_pct)
    - name: "Total Diversion Rate Contribution Pct"
      expr: SUM(diversion_rate_contribution_pct)
    - name: "Average Diversion Rate Contribution Pct"
      expr: AVG(diversion_rate_contribution_pct)
    - name: "Total Hdpe Pct"
      expr: SUM(hdpe_pct)
    - name: "Average Hdpe Pct"
      expr: AVG(hdpe_pct)
    - name: "Total Mixed Paper Pct"
      expr: SUM(mixed_paper_pct)
    - name: "Average Mixed Paper Pct"
      expr: AVG(mixed_paper_pct)
    - name: "Total Mixed Plastics Pct"
      expr: SUM(mixed_plastics_pct)
    - name: "Average Mixed Plastics Pct"
      expr: AVG(mixed_plastics_pct)
    - name: "Total Newspaper Pct"
      expr: SUM(newspaper_pct)
    - name: "Average Newspaper Pct"
      expr: AVG(newspaper_pct)
    - name: "Total Occ Pct"
      expr: SUM(occ_pct)
    - name: "Average Occ Pct"
      expr: AVG(occ_pct)
    - name: "Total Organics Pct"
      expr: SUM(organics_pct)
    - name: "Average Organics Pct"
      expr: AVG(organics_pct)
    - name: "Total Other Recyclables Pct"
      expr: SUM(other_recyclables_pct)
    - name: "Average Other Recyclables Pct"
      expr: AVG(other_recyclables_pct)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_mrf_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mrf Equipment business metrics"
  source: "`waste_management_ecm`.`recycling`.`mrf_equipment`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Environmental Permit Required"
      expr: environmental_permit_required
    - name: "Equipment Name"
      expr: equipment_name
    - name: "Equipment Tag"
      expr: equipment_tag
    - name: "Equipment Type"
      expr: equipment_type
    - name: "Infor Eam Asset Code"
      expr: infor_eam_asset_code
    - name: "Installation Date"
      expr: installation_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Pm Date"
      expr: last_pm_date
    - name: "Lockout Tagout Required"
      expr: lockout_tagout_required
    - name: "Model Number"
      expr: model_number
    - name: "Next Inspection Due Date"
      expr: next_inspection_due_date
    - name: "Next Pm Due Date"
      expr: next_pm_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mrf Equipment"
      expr: COUNT(DISTINCT mrf_equipment_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Design Throughput Capacity Tph"
      expr: SUM(design_throughput_capacity_tph)
    - name: "Average Design Throughput Capacity Tph"
      expr: AVG(design_throughput_capacity_tph)
    - name: "Total Floor Space Sqft"
      expr: SUM(floor_space_sqft)
    - name: "Average Floor Space Sqft"
      expr: AVG(floor_space_sqft)
    - name: "Total Mean Time Between Failures Hours"
      expr: SUM(mean_time_between_failures_hours)
    - name: "Average Mean Time Between Failures Hours"
      expr: AVG(mean_time_between_failures_hours)
    - name: "Total Mean Time To Repair Hours"
      expr: SUM(mean_time_to_repair_hours)
    - name: "Average Mean Time To Repair Hours"
      expr: AVG(mean_time_to_repair_hours)
    - name: "Total Noise Level Db"
      expr: SUM(noise_level_db)
    - name: "Average Noise Level Db"
      expr: AVG(noise_level_db)
    - name: "Total Operating Hours Meter"
      expr: SUM(operating_hours_meter)
    - name: "Average Operating Hours Meter"
      expr: AVG(operating_hours_meter)
    - name: "Total Power Rating Kw"
      expr: SUM(power_rating_kw)
    - name: "Average Power Rating Kw"
      expr: AVG(power_rating_kw)
    - name: "Total Weight Lbs"
      expr: SUM(weight_lbs)
    - name: "Average Weight Lbs"
      expr: AVG(weight_lbs)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_mrf_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mrf Facility business metrics"
  source: "`waste_management_ecm`.`recycling`.`mrf_facility`"
  dimensions:
    - name: "Accepts Cd Waste"
      expr: accepts_cd_waste
    - name: "Accepts Commercial"
      expr: accepts_commercial
    - name: "Accepts Residential"
      expr: accepts_residential
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Baling Line Count"
      expr: baling_line_count
    - name: "City"
      expr: city
    - name: "Commissioned Date"
      expr: commissioned_date
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "County"
      expr: county
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Type"
      expr: facility_type
    - name: "Iso 14001 Certified"
      expr: iso_14001_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mrf Facility"
      expr: COUNT(DISTINCT mrf_facility_id)
    - name: "Total Design Capacity Tpd"
      expr: SUM(design_capacity_tpd)
    - name: "Average Design Capacity Tpd"
      expr: AVG(design_capacity_tpd)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Contamination Rate Pct"
      expr: SUM(max_contamination_rate_pct)
    - name: "Average Max Contamination Rate Pct"
      expr: AVG(max_contamination_rate_pct)
    - name: "Total Permitted Capacity Tpd"
      expr: SUM(permitted_capacity_tpd)
    - name: "Average Permitted Capacity Tpd"
      expr: AVG(permitted_capacity_tpd)
    - name: "Total Storage Capacity Tons"
      expr: SUM(storage_capacity_tons)
    - name: "Average Storage Capacity Tons"
      expr: AVG(storage_capacity_tons)
    - name: "Total Target Diversion Rate Pct"
      expr: SUM(target_diversion_rate_pct)
    - name: "Average Target Diversion Rate Pct"
      expr: AVG(target_diversion_rate_pct)
    - name: "Total Tipping Floor Area Sqft"
      expr: SUM(tipping_floor_area_sqft)
    - name: "Average Tipping Floor Area Sqft"
      expr: AVG(tipping_floor_area_sqft)
    - name: "Total Total Floor Area Sqft"
      expr: SUM(total_floor_area_sqft)
    - name: "Average Total Floor Area Sqft"
      expr: AVG(total_floor_area_sqft)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_mrf_tsdf_disposal_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mrf Tsdf Disposal Agreement business metrics"
  source: "`waste_management_ecm`.`recycling`.`mrf_tsdf_disposal_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Approved Waste Codes"
      expr: approved_waste_codes
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Shipment Date"
      expr: last_shipment_date
    - name: "Primary Waste Stream Type"
      expr: primary_waste_stream_type
    - name: "Total Shipments Ytd"
      expr: total_shipments_ytd
    - name: "Contract Effective Date Month"
      expr: DATE_TRUNC('MONTH', contract_effective_date)
    - name: "Contract Expiration Date Month"
      expr: DATE_TRUNC('MONTH', contract_expiration_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mrf Tsdf Disposal Agreement"
      expr: COUNT(DISTINCT mrf_tsdf_disposal_agreement_id)
    - name: "Total Annual Volume Commitment Tons"
      expr: SUM(annual_volume_commitment_tons)
    - name: "Average Annual Volume Commitment Tons"
      expr: AVG(annual_volume_commitment_tons)
    - name: "Total Pricing Per Ton"
      expr: SUM(pricing_per_ton)
    - name: "Average Pricing Per Ton"
      expr: AVG(pricing_per_ton)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_outbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound Shipment business metrics"
  source: "`waste_management_ecm`.`recycling`.`outbound_shipment`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Bol Number"
      expr: bol_number
    - name: "Carrier Scac Code"
      expr: carrier_scac_code
    - name: "Commodity Grade"
      expr: commodity_grade
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Confirmation Number"
      expr: delivery_confirmation_number
    - name: "Delivery Notes"
      expr: delivery_notes
    - name: "Departure Timestamp"
      expr: departure_timestamp
    - name: "Destination Address"
      expr: destination_address
    - name: "Destination City"
      expr: destination_city
    - name: "Destination Country"
      expr: destination_country
    - name: "Destination Postal Code"
      expr: destination_postal_code
    - name: "Destination State"
      expr: destination_state
    - name: "Driver License Number"
      expr: driver_license_number
    - name: "Driver Name"
      expr: driver_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Outbound Shipment"
      expr: COUNT(DISTINCT outbound_shipment_id)
    - name: "Total Freight Charges Usd"
      expr: SUM(freight_charges_usd)
    - name: "Average Freight Charges Usd"
      expr: AVG(freight_charges_usd)
    - name: "Total Gross Weight Tons"
      expr: SUM(gross_weight_tons)
    - name: "Average Gross Weight Tons"
      expr: AVG(gross_weight_tons)
    - name: "Total Insurance Value Usd"
      expr: SUM(insurance_value_usd)
    - name: "Average Insurance Value Usd"
      expr: AVG(insurance_value_usd)
    - name: "Total Net Weight Tons"
      expr: SUM(net_weight_tons)
    - name: "Average Net Weight Tons"
      expr: AVG(net_weight_tons)
    - name: "Total Tare Weight Tons"
      expr: SUM(tare_weight_tons)
    - name: "Average Tare Weight Tons"
      expr: AVG(tare_weight_tons)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_program_target_contribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Target Contribution business metrics"
  source: "`waste_management_ecm`.`recycling`.`program_target_contribution`"
  dimensions:
    - name: "Alignment End Date"
      expr: alignment_end_date
    - name: "Alignment Start Date"
      expr: alignment_start_date
    - name: "Contribution Methodology"
      expr: contribution_methodology
    - name: "Last Measurement Date"
      expr: last_measurement_date
    - name: "Notes"
      expr: notes
    - name: "Reporting Status"
      expr: reporting_status
    - name: "Alignment End Date Month"
      expr: DATE_TRUNC('MONTH', alignment_end_date)
    - name: "Alignment Start Date Month"
      expr: DATE_TRUNC('MONTH', alignment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Target Contribution"
      expr: COUNT(DISTINCT program_target_contribution_id)
    - name: "Total Actual Contribution Value"
      expr: SUM(actual_contribution_value)
    - name: "Average Actual Contribution Value"
      expr: AVG(actual_contribution_value)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Contribution Percentage"
      expr: SUM(contribution_percentage)
    - name: "Average Contribution Percentage"
      expr: AVG(contribution_percentage)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_recycling_buyer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recycling Buyer Contract business metrics"
  source: "`waste_management_ecm`.`recycling`.`recycling_buyer_contract`"
  dimensions:
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Contamination Penalty Basis"
      expr: contamination_penalty_basis
    - name: "Contract Notes"
      expr: contract_notes
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Dispute Resolution Method"
      expr: dispute_resolution_method
    - name: "Diversion Rate Credit"
      expr: diversion_rate_credit
    - name: "End Date"
      expr: end_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Execution Date"
      expr: execution_date
    - name: "Force Majeure Clause"
      expr: force_majeure_clause
    - name: "Governing Law State"
      expr: governing_law_state
    - name: "Invoicing Frequency"
      expr: invoicing_frequency
    - name: "Minimum Quality Grade"
      expr: minimum_quality_grade
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recycling Buyer Contract"
      expr: COUNT(DISTINCT recycling_buyer_contract_id)
    - name: "Total Bale Weight Spec Lbs"
      expr: SUM(bale_weight_spec_lbs)
    - name: "Average Bale Weight Spec Lbs"
      expr: AVG(bale_weight_spec_lbs)
    - name: "Total Base Price Per Ton"
      expr: SUM(base_price_per_ton)
    - name: "Average Base Price Per Ton"
      expr: AVG(base_price_per_ton)
    - name: "Total Ceiling Price Per Ton"
      expr: SUM(ceiling_price_per_ton)
    - name: "Average Ceiling Price Per Ton"
      expr: AVG(ceiling_price_per_ton)
    - name: "Total Committed Volume Tons Monthly"
      expr: SUM(committed_volume_tons_monthly)
    - name: "Average Committed Volume Tons Monthly"
      expr: AVG(committed_volume_tons_monthly)
    - name: "Total Contamination Penalty Rate"
      expr: SUM(contamination_penalty_rate)
    - name: "Average Contamination Penalty Rate"
      expr: AVG(contamination_penalty_rate)
    - name: "Total Floor Price Per Ton"
      expr: SUM(floor_price_per_ton)
    - name: "Average Floor Price Per Ton"
      expr: AVG(floor_price_per_ton)
    - name: "Total Max Contamination Pct"
      expr: SUM(max_contamination_pct)
    - name: "Average Max Contamination Pct"
      expr: AVG(max_contamination_pct)
    - name: "Total Volume Tolerance Pct"
      expr: SUM(volume_tolerance_pct)
    - name: "Average Volume Tolerance Pct"
      expr: AVG(volume_tolerance_pct)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_recycling_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recycling Program business metrics"
  source: "`waste_management_ecm`.`recycling`.`recycling_program`"
  dimensions:
    - name: "Accepted Materials List"
      expr: accepted_materials_list
    - name: "Amcs Program Reference"
      expr: amcs_program_reference
    - name: "Collection Day Of Week"
      expr: collection_day_of_week
    - name: "Collection Frequency"
      expr: collection_frequency
    - name: "Container Type"
      expr: container_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Epa Program Code"
      expr: epa_program_code
    - name: "Ghg Reporting Required"
      expr: ghg_reporting_required
    - name: "Iso 14001 Applicable"
      expr: iso_14001_applicable
    - name: "Lea Jurisdiction Code"
      expr: lea_jurisdiction_code
    - name: "Municipality Name"
      expr: municipality_name
    - name: "Notes"
      expr: notes
    - name: "Processing Priority"
      expr: processing_priority
    - name: "Program Code"
      expr: program_code
    - name: "Program Name"
      expr: program_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recycling Program"
      expr: COUNT(DISTINCT recycling_program_id)
    - name: "Total Annual Tonnage Commitment"
      expr: SUM(annual_tonnage_commitment)
    - name: "Average Annual Tonnage Commitment"
      expr: AVG(annual_tonnage_commitment)
    - name: "Total Co2e Diversion Factor"
      expr: SUM(co2e_diversion_factor)
    - name: "Average Co2e Diversion Factor"
      expr: AVG(co2e_diversion_factor)
    - name: "Total Diversion Rate Target Pct"
      expr: SUM(diversion_rate_target_pct)
    - name: "Average Diversion Rate Target Pct"
      expr: AVG(diversion_rate_target_pct)
    - name: "Total Max Contamination Rate Pct"
      expr: SUM(max_contamination_rate_pct)
    - name: "Average Max Contamination Rate Pct"
      expr: AVG(max_contamination_rate_pct)
    - name: "Total Revenue Share Pct"
      expr: SUM(revenue_share_pct)
    - name: "Average Revenue Share Pct"
      expr: AVG(revenue_share_pct)
    - name: "Total Tipping Fee Rate"
      expr: SUM(tipping_fee_rate)
    - name: "Average Tipping Fee Rate"
      expr: AVG(tipping_fee_rate)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_residue_disposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residue Disposal business metrics"
  source: "`waste_management_ecm`.`recycling`.`residue_disposal`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Bol Number"
      expr: bol_number
    - name: "Contamination Level"
      expr: contamination_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Disposal Date"
      expr: disposal_date
    - name: "Disposal Destination Type"
      expr: disposal_destination_type
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Disposal Status"
      expr: disposal_status
    - name: "Disposal Timestamp"
      expr: disposal_timestamp
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Status"
      expr: payment_status
    - name: "Rejection Reason"
      expr: rejection_reason
    - name: "Residue Composition Notes"
      expr: residue_composition_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Residue Disposal"
      expr: COUNT(DISTINCT residue_disposal_id)
    - name: "Total Environmental Surcharge"
      expr: SUM(environmental_surcharge)
    - name: "Average Environmental Surcharge"
      expr: AVG(environmental_surcharge)
    - name: "Total Gross Weight Tons"
      expr: SUM(gross_weight_tons)
    - name: "Average Gross Weight Tons"
      expr: AVG(gross_weight_tons)
    - name: "Total Hauling Cost"
      expr: SUM(hauling_cost)
    - name: "Average Hauling Cost"
      expr: AVG(hauling_cost)
    - name: "Total Residue Weight Tons"
      expr: SUM(residue_weight_tons)
    - name: "Average Residue Weight Tons"
      expr: AVG(residue_weight_tons)
    - name: "Total Tare Weight Tons"
      expr: SUM(tare_weight_tons)
    - name: "Average Tare Weight Tons"
      expr: AVG(tare_weight_tons)
    - name: "Total Tipping Fee Per Ton"
      expr: SUM(tipping_fee_per_ton)
    - name: "Average Tipping Fee Per Ton"
      expr: AVG(tipping_fee_per_ton)
    - name: "Total Total Disposal Cost"
      expr: SUM(total_disposal_cost)
    - name: "Average Total Disposal Cost"
      expr: AVG(total_disposal_cost)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_sort_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sort Line business metrics"
  source: "`waste_management_ecm`.`recycling`.`sort_line`"
  dimensions:
    - name: "Amcs Line Reference"
      expr: amcs_line_reference
    - name: "Automation Level"
      expr: automation_level
    - name: "Baler Count"
      expr: baler_count
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Dust Suppression System"
      expr: dust_suppression_system
    - name: "Eddy Current Separator Count"
      expr: eddy_current_separator_count
    - name: "Equipment Count"
      expr: equipment_count
    - name: "Fire Suppression System"
      expr: fire_suppression_system
    - name: "Glass Breaker Count"
      expr: glass_breaker_count
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Major Overhaul Date"
      expr: last_major_overhaul_date
    - name: "Line Code"
      expr: line_code
    - name: "Line Name"
      expr: line_name
    - name: "Line Status"
      expr: line_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sort Line"
      expr: COUNT(DISTINCT sort_line_id)
    - name: "Total Conveyor Length M"
      expr: SUM(conveyor_length_m)
    - name: "Average Conveyor Length M"
      expr: AVG(conveyor_length_m)
    - name: "Total Conveyor Speed Mpm"
      expr: SUM(conveyor_speed_mpm)
    - name: "Average Conveyor Speed Mpm"
      expr: AVG(conveyor_speed_mpm)
    - name: "Total Design Recovery Rate Pct"
      expr: SUM(design_recovery_rate_pct)
    - name: "Average Design Recovery Rate Pct"
      expr: AVG(design_recovery_rate_pct)
    - name: "Total Design Throughput Tpd"
      expr: SUM(design_throughput_tpd)
    - name: "Average Design Throughput Tpd"
      expr: AVG(design_throughput_tpd)
    - name: "Total Design Throughput Tph"
      expr: SUM(design_throughput_tph)
    - name: "Average Design Throughput Tph"
      expr: AVG(design_throughput_tph)
    - name: "Total Floor Area Sqm"
      expr: SUM(floor_area_sqm)
    - name: "Average Floor Area Sqm"
      expr: AVG(floor_area_sqm)
    - name: "Total Max Contamination Pct"
      expr: SUM(max_contamination_pct)
    - name: "Average Max Contamination Pct"
      expr: AVG(max_contamination_pct)
    - name: "Total Noise Level Db"
      expr: SUM(noise_level_db)
    - name: "Average Noise Level Db"
      expr: AVG(noise_level_db)
    - name: "Total Power Consumption Kw"
      expr: SUM(power_consumption_kw)
    - name: "Average Power Consumption Kw"
      expr: AVG(power_consumption_kw)
    - name: "Total Residue Rate Target Pct"
      expr: SUM(residue_rate_target_pct)
    - name: "Average Residue Rate Target Pct"
      expr: AVG(residue_rate_target_pct)
    - name: "Total Shift Duration Hours"
      expr: SUM(shift_duration_hours)
    - name: "Average Shift Duration Hours"
      expr: AVG(shift_duration_hours)
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`recycling_sort_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sort Session business metrics"
  source: "`waste_management_ecm`.`recycling`.`sort_session`"
  dimensions:
    - name: "Abort Reason"
      expr: abort_reason
    - name: "Bale Count"
      expr: bale_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Downtime Minutes"
      expr: downtime_minutes
    - name: "Downtime Reason Code"
      expr: downtime_reason_code
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Equipment Fault Flag"
      expr: equipment_fault_flag
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Material Stream Type"
      expr: material_stream_type
    - name: "Notes"
      expr: notes
    - name: "Operator Count"
      expr: operator_count
    - name: "Qc Sample Count"
      expr: qc_sample_count
    - name: "Quality Grade"
      expr: quality_grade
    - name: "Safety Incident Flag"
      expr: safety_incident_flag
    - name: "Session Date"
      expr: session_date
    - name: "Session Duration Minutes"
      expr: session_duration_minutes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sort Session"
      expr: COUNT(DISTINCT sort_session_id)
    - name: "Total Contamination Input Pct"
      expr: SUM(contamination_input_pct)
    - name: "Average Contamination Input Pct"
      expr: AVG(contamination_input_pct)
    - name: "Total Contamination Rate Pct"
      expr: SUM(contamination_rate_pct)
    - name: "Average Contamination Rate Pct"
      expr: AVG(contamination_rate_pct)
    - name: "Total Diversion Rate Pct"
      expr: SUM(diversion_rate_pct)
    - name: "Average Diversion Rate Pct"
      expr: AVG(diversion_rate_pct)
    - name: "Total Glass Input Pct"
      expr: SUM(glass_input_pct)
    - name: "Average Glass Input Pct"
      expr: AVG(glass_input_pct)
    - name: "Total Input Tonnage"
      expr: SUM(input_tonnage)
    - name: "Average Input Tonnage"
      expr: AVG(input_tonnage)
    - name: "Total Metal Input Pct"
      expr: SUM(metal_input_pct)
    - name: "Average Metal Input Pct"
      expr: AVG(metal_input_pct)
    - name: "Total Paper Input Pct"
      expr: SUM(paper_input_pct)
    - name: "Average Paper Input Pct"
      expr: AVG(paper_input_pct)
    - name: "Total Plastic Input Pct"
      expr: SUM(plastic_input_pct)
    - name: "Average Plastic Input Pct"
      expr: AVG(plastic_input_pct)
    - name: "Total Recovered Tonnage"
      expr: SUM(recovered_tonnage)
    - name: "Average Recovered Tonnage"
      expr: AVG(recovered_tonnage)
    - name: "Total Residue Tonnage"
      expr: SUM(residue_tonnage)
    - name: "Average Residue Tonnage"
      expr: AVG(residue_tonnage)
    - name: "Total Sort Line Speed Fpm"
      expr: SUM(sort_line_speed_fpm)
    - name: "Average Sort Line Speed Fpm"
      expr: AVG(sort_line_speed_fpm)
    - name: "Total Throughput Rate Tph"
      expr: SUM(throughput_rate_tph)
    - name: "Average Throughput Rate Tph"
      expr: AVG(throughput_rate_tph)
$$;