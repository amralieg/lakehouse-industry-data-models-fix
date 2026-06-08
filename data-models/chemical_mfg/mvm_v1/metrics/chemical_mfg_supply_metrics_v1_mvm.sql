-- Metric views for domain: supply | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:35:19

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_asn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asn business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`asn`"
  dimensions:
    - name: "Actual Arrival Timestamp"
      expr: actual_arrival_timestamp
    - name: "Asn Number"
      expr: asn_number
    - name: "Asn Status"
      expr: asn_status
    - name: "Asn Type"
      expr: asn_type
    - name: "Container Number"
      expr: container_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Expected Delivery Time"
      expr: expected_delivery_time
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Hazmat Placard Code"
      expr: hazmat_placard_code
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Package Count"
      expr: package_count
    - name: "Pallet Count"
      expr: pallet_count
    - name: "Pro Number"
      expr: pro_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asn"
      expr: COUNT(DISTINCT asn_id)
    - name: "Total Required Temperature Max"
      expr: SUM(required_temperature_max)
    - name: "Average Required Temperature Max"
      expr: AVG(required_temperature_max)
    - name: "Total Required Temperature Min"
      expr: SUM(required_temperature_min)
    - name: "Average Required Temperature Min"
      expr: AVG(required_temperature_min)
    - name: "Total Total Gross Weight"
      expr: SUM(total_gross_weight)
    - name: "Average Total Gross Weight"
      expr: AVG(total_gross_weight)
    - name: "Total Total Net Weight"
      expr: SUM(total_net_weight)
    - name: "Average Total Net Weight"
      expr: AVG(total_net_weight)
    - name: "Total Total Volume"
      expr: SUM(total_volume)
    - name: "Average Total Volume"
      expr: AVG(total_volume)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`contract`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Cas Number"
      expr: cas_number
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Frequency"
      expr: delivery_frequency
    - name: "Force Majeure Terms"
      expr: force_majeure_terms
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Price Currency"
      expr: price_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract"
      expr: COUNT(DISTINCT contract_id)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Price Per Unit"
      expr: SUM(price_per_unit)
    - name: "Average Price Per Unit"
      expr: AVG(price_per_unit)
    - name: "Total Target Quantity"
      expr: SUM(target_quantity)
    - name: "Average Target Quantity"
      expr: AVG(target_quantity)
    - name: "Total Value Amount"
      expr: SUM(value_amount)
    - name: "Average Value Amount"
      expr: AVG(value_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_contract_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Price business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`contract_price`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Calculation Type"
      expr: calculation_type
    - name: "Condition Class"
      expr: condition_class
    - name: "Condition Record Number"
      expr: condition_record_number
    - name: "Condition Type"
      expr: condition_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Freight Included Flag"
      expr: freight_included_flag
    - name: "Hazmat Surcharge Flag"
      expr: hazmat_surcharge_flag
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Info Record Number"
      expr: info_record_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Negotiation Date"
      expr: negotiation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Price"
      expr: COUNT(DISTINCT contract_price_id)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Price Amount"
      expr: SUM(price_amount)
    - name: "Average Price Amount"
      expr: AVG(price_amount)
    - name: "Total Price Unit"
      expr: SUM(price_unit)
    - name: "Average Price Unit"
      expr: AVG(price_unit)
    - name: "Total Scale Quantity From"
      expr: SUM(scale_quantity_from)
    - name: "Average Scale Quantity From"
      expr: AVG(scale_quantity_from)
    - name: "Total Scale Quantity To"
      expr: SUM(scale_quantity_to)
    - name: "Average Scale Quantity To"
      expr: AVG(scale_quantity_to)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Receipt business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "Cas Number"
      expr: cas_number
    - name: "Coa Document Number"
      expr: coa_document_number
    - name: "Coa Received Flag"
      expr: coa_received_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Damage Description"
      expr: damage_description
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gr Date"
      expr: gr_date
    - name: "Gr Document Number"
      expr: gr_document_number
    - name: "Gr Status"
      expr: gr_status
    - name: "Gr Timestamp"
      expr: gr_timestamp
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Movement Type"
      expr: movement_type
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Receipt"
      expr: COUNT(DISTINCT goods_receipt_id)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Temperature On Arrival C"
      expr: SUM(temperature_on_arrival_c)
    - name: "Average Temperature On Arrival C"
      expr: AVG(temperature_on_arrival_c)
    - name: "Total Valuation Amount"
      expr: SUM(valuation_amount)
    - name: "Average Valuation Amount"
      expr: AVG(valuation_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_inbound_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound Delivery business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`inbound_delivery`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Actual Arrival Time"
      expr: actual_arrival_time
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Number"
      expr: delivery_number
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Destination Plant Code"
      expr: destination_plant_code
    - name: "Destination Storage Location"
      expr: destination_storage_location
    - name: "Dot Hazmat Document Number"
      expr: dot_hazmat_document_number
    - name: "Freight Currency Code"
      expr: freight_currency_code
    - name: "Ghs Hazard Class"
      expr: ghs_hazard_class
    - name: "Goods Receipt Date"
      expr: goods_receipt_date
    - name: "Goods Receipt Number"
      expr: goods_receipt_number
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Incoterm"
      expr: incoterm
    - name: "Inspection Lot Number"
      expr: inspection_lot_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inbound Delivery"
      expr: COUNT(DISTINCT inbound_delivery_id)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Gross Weight Kg"
      expr: SUM(gross_weight_kg)
    - name: "Average Gross Weight Kg"
      expr: AVG(gross_weight_kg)
    - name: "Total Net Weight Kg"
      expr: SUM(net_weight_kg)
    - name: "Average Net Weight Kg"
      expr: AVG(net_weight_kg)
    - name: "Total Required Temperature Max C"
      expr: SUM(required_temperature_max_c)
    - name: "Average Required Temperature Max C"
      expr: AVG(required_temperature_max_c)
    - name: "Total Required Temperature Min C"
      expr: SUM(required_temperature_min_c)
    - name: "Average Required Temperature Min C"
      expr: AVG(required_temperature_min_c)
    - name: "Total Volume Liters"
      expr: SUM(volume_liters)
    - name: "Average Volume Liters"
      expr: AVG(volume_liters)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_invoice_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Verification business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`invoice_verification`"
  dimensions:
    - name: "Baseline Date"
      expr: baseline_date
    - name: "Blocking Reason"
      expr: blocking_reason
    - name: "Coa Received Flag"
      expr: coa_received_flag
    - name: "Coa Review Status"
      expr: coa_review_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Date"
      expr: document_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Material Number"
      expr: material_number
    - name: "Payment Block Indicator"
      expr: payment_block_indicator
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Release By"
      expr: payment_release_by
    - name: "Payment Release Date"
      expr: payment_release_date
    - name: "Plant Code"
      expr: plant_code
    - name: "Posting Date"
      expr: posting_date
    - name: "Posting Status"
      expr: posting_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Verification"
      expr: COUNT(DISTINCT invoice_verification_id)
    - name: "Total Freight Charge"
      expr: SUM(freight_charge)
    - name: "Average Freight Charge"
      expr: AVG(freight_charge)
    - name: "Total Hazmat Handling Fee"
      expr: SUM(hazmat_handling_fee)
    - name: "Average Hazmat Handling Fee"
      expr: AVG(hazmat_handling_fee)
    - name: "Total Index Escalator Amount"
      expr: SUM(index_escalator_amount)
    - name: "Average Index Escalator Amount"
      expr: AVG(index_escalator_amount)
    - name: "Total Invoiced Amount"
      expr: SUM(invoiced_amount)
    - name: "Average Invoiced Amount"
      expr: AVG(invoiced_amount)
    - name: "Total Invoiced Quantity"
      expr: SUM(invoiced_quantity)
    - name: "Average Invoiced Quantity"
      expr: AVG(invoiced_quantity)
    - name: "Total Price Variance"
      expr: SUM(price_variance)
    - name: "Average Price Variance"
      expr: AVG(price_variance)
    - name: "Total Quantity Variance"
      expr: SUM(quantity_variance)
    - name: "Average Quantity Variance"
      expr: AVG(quantity_variance)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Invoice Amount"
      expr: SUM(total_invoice_amount)
    - name: "Average Total Invoice Amount"
      expr: AVG(total_invoice_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_material_info_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Info Record business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`material_info_record`"
  dimensions:
    - name: "Acknowledgement Required"
      expr: acknowledgement_required
    - name: "Agreement Item Number"
      expr: agreement_item_number
    - name: "Blocked Source"
      expr: blocked_source
    - name: "Certificate Of Analysis Required"
      expr: certificate_of_analysis_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fixed Source"
      expr: fixed_source
    - name: "Goods Receipt Required"
      expr: goods_receipt_required
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Info Record Category"
      expr: info_record_category
    - name: "Info Record Number"
      expr: info_record_number
    - name: "Info Record Status"
      expr: info_record_status
    - name: "Invoice Receipt Required"
      expr: invoice_receipt_required
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Purchase Order Date"
      expr: last_purchase_order_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Info Record"
      expr: COUNT(DISTINCT material_info_record_id)
    - name: "Total Last Purchase Order Price"
      expr: SUM(last_purchase_order_price)
    - name: "Average Last Purchase Order Price"
      expr: AVG(last_purchase_order_price)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Over Delivery Tolerance Pct"
      expr: SUM(over_delivery_tolerance_pct)
    - name: "Average Over Delivery Tolerance Pct"
      expr: AVG(over_delivery_tolerance_pct)
    - name: "Total Standard Order Quantity"
      expr: SUM(standard_order_quantity)
    - name: "Average Standard Order Quantity"
      expr: AVG(standard_order_quantity)
    - name: "Total Standard Price"
      expr: SUM(standard_price)
    - name: "Average Standard Price"
      expr: AVG(standard_price)
    - name: "Total Under Delivery Tolerance Pct"
      expr: SUM(under_delivery_tolerance_pct)
    - name: "Average Under Delivery Tolerance Pct"
      expr: AVG(under_delivery_tolerance_pct)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Po Line business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`po_line`"
  dimensions:
    - name: "Batch Managed Flag"
      expr: batch_managed_flag
    - name: "Cas Number"
      expr: cas_number
    - name: "Confirmation Control Key"
      expr: confirmation_control_key
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Ghs Hazard Category"
      expr: ghs_hazard_category
    - name: "Goods Receipt Required Flag"
      expr: goods_receipt_required_flag
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Invoice Receipt Required Flag"
      expr: invoice_receipt_required_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Po Line"
      expr: COUNT(DISTINCT po_line_id)
    - name: "Total Goods Receipt Quantity"
      expr: SUM(goods_receipt_quantity)
    - name: "Average Goods Receipt Quantity"
      expr: AVG(goods_receipt_quantity)
    - name: "Total Invoice Receipt Quantity"
      expr: SUM(invoice_receipt_quantity)
    - name: "Average Invoice Receipt Quantity"
      expr: AVG(invoice_receipt_quantity)
    - name: "Total Net Order Value"
      expr: SUM(net_order_value)
    - name: "Average Net Order Value"
      expr: AVG(net_order_value)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Outstanding Quantity"
      expr: SUM(outstanding_quantity)
    - name: "Average Outstanding Quantity"
      expr: AVG(outstanding_quantity)
    - name: "Total Over Delivery Tolerance Pct"
      expr: SUM(over_delivery_tolerance_pct)
    - name: "Average Over Delivery Tolerance Pct"
      expr: AVG(over_delivery_tolerance_pct)
    - name: "Total Under Delivery Tolerance Pct"
      expr: SUM(under_delivery_tolerance_pct)
    - name: "Average Under Delivery Tolerance Pct"
      expr: AVG(under_delivery_tolerance_pct)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Document Date"
      expr: document_date
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Po Number"
      expr: po_number
    - name: "Po Status"
      expr: po_status
    - name: "Po Type"
      expr: po_type
    - name: "Purchasing Group"
      expr: purchasing_group
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Total Gross Value"
      expr: SUM(total_gross_value)
    - name: "Average Total Gross Value"
      expr: AVG(total_gross_value)
    - name: "Total Total Net Value"
      expr: SUM(total_net_value)
    - name: "Average Total Net Value"
      expr: AVG(total_net_value)
    - name: "Total Total Tax Amount"
      expr: SUM(total_tax_amount)
    - name: "Average Total Tax Amount"
      expr: AVG(total_tax_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Requisition business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`purchase_requisition`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approver Name"
      expr: approver_name
    - name: "Campaign Production Flag"
      expr: campaign_production_flag
    - name: "Cas Number"
      expr: cas_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Material Number"
      expr: material_number
    - name: "Mrp Element"
      expr: mrp_element
    - name: "Notes"
      expr: notes
    - name: "Planner Code"
      expr: planner_code
    - name: "Planning Horizon"
      expr: planning_horizon
    - name: "Po Conversion Status"
      expr: po_conversion_status
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Requisition"
      expr: COUNT(DISTINCT purchase_requisition_id)
    - name: "Total Estimated Total Value"
      expr: SUM(estimated_total_value)
    - name: "Average Estimated Total Value"
      expr: AVG(estimated_total_value)
    - name: "Total Estimated Unit Price"
      expr: SUM(estimated_unit_price)
    - name: "Average Estimated Unit Price"
      expr: AVG(estimated_unit_price)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_source_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Source List business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`source_list`"
  dimensions:
    - name: "Agreement Item"
      expr: agreement_item
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Avl Status"
      expr: avl_status
    - name: "Blocked Flag"
      expr: blocked_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fixed Source Flag"
      expr: fixed_source_flag
    - name: "Incoterm"
      expr: incoterm
    - name: "Incoterm Location"
      expr: incoterm_location
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Purchase Order Date"
      expr: last_purchase_order_date
    - name: "Last Qualification Date"
      expr: last_qualification_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Mrp Relevant Flag"
      expr: mrp_relevant_flag
    - name: "Next Qualification Due Date"
      expr: next_qualification_due_date
    - name: "Order Quantity Uom"
      expr: order_quantity_uom
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Source List"
      expr: COUNT(DISTINCT source_list_id)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`vendor`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Classification"
      expr: classification
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Duns Number"
      expr: duns_number
    - name: "Hazmat Handling Capable"
      expr: hazmat_handling_capable
    - name: "Headquarters Address Line1"
      expr: headquarters_address_line1
    - name: "Headquarters Address Line2"
      expr: headquarters_address_line2
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Country Code"
      expr: headquarters_country_code
    - name: "Headquarters Postal Code"
      expr: headquarters_postal_code
    - name: "Headquarters State Province"
      expr: headquarters_state_province
    - name: "Incoterms"
      expr: incoterms
    - name: "Iso 14001 Certified"
      expr: iso_14001_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor"
      expr: COUNT(DISTINCT vendor_id)
    - name: "Total Performance Score"
      expr: SUM(performance_score)
    - name: "Average Performance Score"
      expr: AVG(performance_score)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_vendor_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Audit business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`vendor_audit`"
  dimensions:
    - name: "Audit Closure Date"
      expr: audit_closure_date
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit End Date"
      expr: audit_end_date
    - name: "Audit Frequency Months"
      expr: audit_frequency_months
    - name: "Audit Method"
      expr: audit_method
    - name: "Audit Number"
      expr: audit_number
    - name: "Audit Report Issued Date"
      expr: audit_report_issued_date
    - name: "Audit Scope"
      expr: audit_scope
    - name: "Audit Status"
      expr: audit_status
    - name: "Audit Team Members"
      expr: audit_team_members
    - name: "Audit Type"
      expr: audit_type
    - name: "Capa Approval Date"
      expr: capa_approval_date
    - name: "Capa Due Date"
      expr: capa_due_date
    - name: "Capa Required Flag"
      expr: capa_required_flag
    - name: "Capa Submission Date"
      expr: capa_submission_date
    - name: "Comments"
      expr: comments
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Audit"
      expr: COUNT(DISTINCT vendor_audit_id)
    - name: "Total Audit Score"
      expr: SUM(audit_score)
    - name: "Average Audit Score"
      expr: AVG(audit_score)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_vendor_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Qualification business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`vendor_qualification`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Duration Days"
      expr: audit_duration_days
    - name: "Audit Method"
      expr: audit_method
    - name: "Audit Team Members"
      expr: audit_team_members
    - name: "Capa Due Date"
      expr: capa_due_date
    - name: "Capa Required Flag"
      expr: capa_required_flag
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Findings Critical Count"
      expr: findings_critical_count
    - name: "Findings Major Count"
      expr: findings_major_count
    - name: "Findings Minor Count"
      expr: findings_minor_count
    - name: "Gmp Certified Flag"
      expr: gmp_certified_flag
    - name: "Initiated Date"
      expr: initiated_date
    - name: "Iso 14001 Certified Flag"
      expr: iso_14001_certified_flag
    - name: "Iso 45001 Certified Flag"
      expr: iso_45001_certified_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Qualification"
      expr: COUNT(DISTINCT vendor_qualification_id)
    - name: "Total Delivery Performance Score"
      expr: SUM(delivery_performance_score)
    - name: "Average Delivery Performance Score"
      expr: AVG(delivery_performance_score)
    - name: "Total Ehs Score"
      expr: SUM(ehs_score)
    - name: "Average Ehs Score"
      expr: AVG(ehs_score)
    - name: "Total Financial Stability Score"
      expr: SUM(financial_stability_score)
    - name: "Average Financial Stability Score"
      expr: AVG(financial_stability_score)
    - name: "Total Qualification Score"
      expr: SUM(qualification_score)
    - name: "Average Qualification Score"
      expr: AVG(qualification_score)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
    - name: "Total Regulatory Compliance Score"
      expr: SUM(regulatory_compliance_score)
    - name: "Average Regulatory Compliance Score"
      expr: AVG(regulatory_compliance_score)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`supply_vendor_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Site business metrics"
  source: "`chemical_mfg_ecm`.`supply`.`vendor_site`"
  dimensions:
    - name: "Active From Date"
      expr: active_from_date
    - name: "Active To Date"
      expr: active_to_date
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dock Hours"
      expr: dock_hours
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Hazmat Handling Capable"
      expr: hazmat_handling_capable
    - name: "Incoterm"
      expr: incoterm
    - name: "Iso 14001 Certificate Number"
      expr: iso_14001_certificate_number
    - name: "Iso 14001 Certified"
      expr: iso_14001_certified
    - name: "Iso 14001 Expiration Date"
      expr: iso_14001_expiration_date
    - name: "Iso 9001 Certificate Number"
      expr: iso_9001_certificate_number
    - name: "Iso 9001 Certified"
      expr: iso_9001_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Site"
      expr: COUNT(DISTINCT vendor_site_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
$$;