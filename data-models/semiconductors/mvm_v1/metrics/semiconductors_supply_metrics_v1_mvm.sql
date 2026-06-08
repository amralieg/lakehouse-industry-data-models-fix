-- Metric views for domain: supply | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:32:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_approved_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor business metrics"
  source: "`semiconductors_ecm`.`supply`.`approved_vendor`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Commodity Scope"
      expr: approved_commodity_scope
    - name: "Approved Vendor Description"
      expr: approved_vendor_description
    - name: "Approved Vendor Status"
      expr: approved_vendor_status
    - name: "City"
      expr: city
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Country Code"
      expr: country_code
    - name: "Currency"
      expr: currency
    - name: "Duns Number"
      expr: duns_number
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Financial Rating"
      expr: financial_rating
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Lead Time Days"
      expr: lead_time_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Approved Vendor"
      expr: COUNT(DISTINCT approved_vendor_id)
    - name: "Total Audit Score"
      expr: SUM(audit_score)
    - name: "Average Audit Score"
      expr: AVG(audit_score)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Receipt business metrics"
  source: "`semiconductors_ecm`.`supply`.`goods_receipt`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "External Reference"
      expr: external_reference
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Inspection Lot Number"
      expr: inspection_lot_number
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Movement Type"
      expr: movement_type
    - name: "Notes"
      expr: notes
    - name: "Plant Code"
      expr: plant_code
    - name: "Posting Date"
      expr: posting_date
    - name: "Quality Status"
      expr: quality_status
    - name: "Receipt Date"
      expr: receipt_date
    - name: "Receipt Number"
      expr: receipt_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Receipt"
      expr: COUNT(DISTINCT goods_receipt_id)
    - name: "Total Goods Purchase Order Fk"
      expr: SUM(goods_purchase_order_fk)
    - name: "Average Goods Purchase Order Fk"
      expr: AVG(goods_purchase_order_fk)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Quantity Received"
      expr: SUM(quantity_received)
    - name: "Average Quantity Received"
      expr: AVG(quantity_received)
    - name: "Total Risk Assessment Score"
      expr: SUM(risk_assessment_score)
    - name: "Average Risk Assessment Score"
      expr: AVG(risk_assessment_score)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound Shipment business metrics"
  source: "`semiconductors_ecm`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Cold Chain Required"
      expr: cold_chain_required
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customs Declaration Number"
      expr: customs_declaration_number
    - name: "Delivery Window End"
      expr: delivery_window_end
    - name: "Delivery Window Start"
      expr: delivery_window_start
    - name: "Destination Plant"
      expr: destination_plant
    - name: "Ear Controlled"
      expr: ear_controlled
    - name: "Estimated Arrival Date"
      expr: estimated_arrival_date
    - name: "Hazardous Goods Classification"
      expr: hazardous_goods_classification
    - name: "Inbound Shipment Status"
      expr: inbound_shipment_status
    - name: "Incoterms"
      expr: incoterms
    - name: "Itar Controlled"
      expr: itar_controlled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inbound Shipment"
      expr: COUNT(DISTINCT inbound_shipment_id)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Inbound Po Fk"
      expr: SUM(inbound_po_fk)
    - name: "Average Inbound Po Fk"
      expr: AVG(inbound_po_fk)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
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

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_material_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Certification business metrics"
  source: "`semiconductors_ecm`.`supply`.`material_certification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Reference"
      expr: document_reference
    - name: "Document Version"
      expr: document_version
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Body"
      expr: issuing_body
    - name: "Material Lot Number"
      expr: material_lot_number
    - name: "Material Number"
      expr: material_number
    - name: "Notes"
      expr: notes
    - name: "Pcn Change Description"
      expr: pcn_change_description
    - name: "Pcn Change Type"
      expr: pcn_change_type
    - name: "Pcn Customer Notification Required"
      expr: pcn_customer_notification_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Certification"
      expr: COUNT(DISTINCT material_certification_id)
    - name: "Total Material Supplier Fk"
      expr: SUM(material_supplier_fk)
    - name: "Average Material Supplier Fk"
      expr: AVG(material_supplier_fk)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Supplier Fk"
      expr: SUM(supplier_fk)
    - name: "Average Supplier Fk"
      expr: AVG(supplier_fk)
    - name: "Total Test Value"
      expr: SUM(test_value)
    - name: "Average Test Value"
      expr: AVG(test_value)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Master business metrics"
  source: "`semiconductors_ecm`.`supply`.`material_master`"
  dimensions:
    - name: "Base Uom"
      expr: base_uom
    - name: "Batch Management"
      expr: batch_management
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hazardous Classification"
      expr: hazardous_classification
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Material Description"
      expr: material_description
    - name: "Material Name"
      expr: material_name
    - name: "Material Number"
      expr: material_number
    - name: "Material Type"
      expr: material_type
    - name: "Procurement Group"
      expr: procurement_group
    - name: "Quality Inspection Required"
      expr: quality_inspection_required
    - name: "Reach Compliant"
      expr: reach_compliant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Master"
      expr: COUNT(DISTINCT material_master_id)
    - name: "Total Lot Size Qty"
      expr: SUM(lot_size_qty)
    - name: "Average Lot Size Qty"
      expr: AVG(lot_size_qty)
    - name: "Total Max Order Qty"
      expr: SUM(max_order_qty)
    - name: "Average Max Order Qty"
      expr: AVG(max_order_qty)
    - name: "Total Min Order Qty"
      expr: SUM(min_order_qty)
    - name: "Average Min Order Qty"
      expr: AVG(min_order_qty)
    - name: "Total Reorder Point Qty"
      expr: SUM(reorder_point_qty)
    - name: "Average Reorder Point Qty"
      expr: AVG(reorder_point_qty)
    - name: "Total Safety Stock Qty"
      expr: SUM(safety_stock_qty)
    - name: "Average Safety Stock Qty"
      expr: AVG(safety_stock_qty)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Storage Humidity Max Pct"
      expr: SUM(storage_humidity_max_pct)
    - name: "Average Storage Humidity Max Pct"
      expr: AVG(storage_humidity_max_pct)
    - name: "Total Storage Humidity Min Pct"
      expr: SUM(storage_humidity_min_pct)
    - name: "Average Storage Humidity Min Pct"
      expr: AVG(storage_humidity_min_pct)
    - name: "Total Storage Temperature Max C"
      expr: SUM(storage_temperature_max_c)
    - name: "Average Storage Temperature Max C"
      expr: AVG(storage_temperature_max_c)
    - name: "Total Storage Temperature Min C"
      expr: SUM(storage_temperature_min_c)
    - name: "Average Storage Temperature Min C"
      expr: AVG(storage_temperature_min_c)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_material_requirement_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Requirement Plan business metrics"
  source: "`semiconductors_ecm`.`supply`.`material_requirement_plan`"
  dimensions:
    - name: "Batch Managed Flag"
      expr: batch_managed_flag
    - name: "Creation Timestamp"
      expr: creation_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Demand Date"
      expr: demand_date
    - name: "Exception Message"
      expr: exception_message
    - name: "Is Fixed Lot"
      expr: is_fixed_lot
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Sizing Procedure"
      expr: lot_sizing_procedure
    - name: "Material Number"
      expr: material_number
    - name: "Material Requirement Plan Status"
      expr: material_requirement_plan_status
    - name: "Mrp Controller"
      expr: mrp_controller
    - name: "Mrp Type"
      expr: mrp_type
    - name: "Planned Delivery Date"
      expr: planned_delivery_date
    - name: "Planning Horizon End"
      expr: planning_horizon_end
    - name: "Planning Horizon Start"
      expr: planning_horizon_start
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Requirement Plan"
      expr: COUNT(DISTINCT material_requirement_plan_id)
    - name: "Total Demand Quantity"
      expr: SUM(demand_quantity)
    - name: "Average Demand Quantity"
      expr: AVG(demand_quantity)
    - name: "Total Planned Cost"
      expr: SUM(planned_cost)
    - name: "Average Planned Cost"
      expr: AVG(planned_cost)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Planning Run Number"
      expr: SUM(planning_run_number)
    - name: "Average Planning Run Number"
      expr: AVG(planning_run_number)
    - name: "Total Reorder Point Quantity"
      expr: SUM(reorder_point_quantity)
    - name: "Average Reorder Point Quantity"
      expr: AVG(reorder_point_quantity)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_osat_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Osat Work Order business metrics"
  source: "`semiconductors_ecm`.`supply`.`osat_work_order`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Assembly Process Spec"
      expr: assembly_process_spec
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Commit Date"
      expr: delivery_commit_date
    - name: "Is Ear Controlled"
      expr: is_ear_controlled
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Last Updated By"
      expr: last_updated_by
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Notes"
      expr: notes
    - name: "Osat Work Order Status"
      expr: osat_work_order_status
    - name: "Package Type"
      expr: package_type
    - name: "Priority"
      expr: priority
    - name: "Quality Rating"
      expr: quality_rating
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Osat Work Order"
      expr: COUNT(DISTINCT osat_work_order_id)
    - name: "Total Die Quantity"
      expr: SUM(die_quantity)
    - name: "Average Die Quantity"
      expr: AVG(die_quantity)
    - name: "Total Nre Charge"
      expr: SUM(nre_charge)
    - name: "Average Nre Charge"
      expr: AVG(nre_charge)
    - name: "Total Risk Assessment Score"
      expr: SUM(risk_assessment_score)
    - name: "Average Risk Assessment Score"
      expr: AVG(risk_assessment_score)
    - name: "Total Total Assembly Cost"
      expr: SUM(total_assembly_cost)
    - name: "Average Total Assembly Cost"
      expr: AVG(total_assembly_cost)
    - name: "Total Unit Assembly Cost"
      expr: SUM(unit_assembly_cost)
    - name: "Average Unit Assembly Cost"
      expr: AVG(unit_assembly_cost)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Po Line business metrics"
  source: "`semiconductors_ecm`.`supply`.`po_line`"
  dimensions:
    - name: "Account Assignment Code"
      expr: account_assignment_code
    - name: "Account Assignment Type"
      expr: account_assignment_type
    - name: "Contract Number"
      expr: contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Incoterms"
      expr: incoterms
    - name: "Is Final Invoice"
      expr: is_final_invoice
    - name: "Is Service Line"
      expr: is_service_line
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Material Description"
      expr: material_description
    - name: "Material Number"
      expr: material_number
    - name: "Plant"
      expr: plant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Po Line"
      expr: COUNT(DISTINCT po_line_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Line Total Amount"
      expr: SUM(line_total_amount)
    - name: "Average Line Total Amount"
      expr: AVG(line_total_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Receipt Quantity"
      expr: SUM(receipt_quantity)
    - name: "Average Receipt Quantity"
      expr: AVG(receipt_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order business metrics"
  source: "`semiconductors_ecm`.`supply`.`purchase_order`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Compliance Flags"
      expr: compliance_flags
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Schedule"
      expr: delivery_schedule
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Incoterms"
      expr: incoterms
    - name: "Is Ear Controlled"
      expr: is_ear_controlled
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Material Description"
      expr: material_description
    - name: "Material Number"
      expr: material_number
    - name: "Order Date"
      expr: order_date
    - name: "Payment Terms"
      expr: payment_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Freight Amount"
      expr: SUM(freight_amount)
    - name: "Average Freight Amount"
      expr: AVG(freight_amount)
    - name: "Total Purchase Supplier Fk"
      expr: SUM(purchase_supplier_fk)
    - name: "Average Purchase Supplier Fk"
      expr: AVG(purchase_supplier_fk)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Total Gross Amount"
      expr: SUM(total_gross_amount)
    - name: "Average Total Gross Amount"
      expr: AVG(total_gross_amount)
    - name: "Total Total Net Amount"
      expr: SUM(total_net_amount)
    - name: "Average Total Net Amount"
      expr: AVG(total_net_amount)
    - name: "Total Total Tax Amount"
      expr: SUM(total_tax_amount)
    - name: "Average Total Tax Amount"
      expr: AVG(total_tax_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk Assessment business metrics"
  source: "`semiconductors_ecm`.`supply`.`risk_assessment`"
  dimensions:
    - name: "Assessment Code"
      expr: assessment_code
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Name"
      expr: assessment_name
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessor Name"
      expr: assessor_name
    - name: "Buffer Stock Target Qty"
      expr: buffer_stock_target_qty
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disruption End Date"
      expr: disruption_end_date
    - name: "Disruption Escalation Level"
      expr: disruption_escalation_level
    - name: "Disruption Event Type"
      expr: disruption_event_type
    - name: "Disruption Report Date"
      expr: disruption_report_date
    - name: "Disruption Reported By"
      expr: disruption_reported_by
    - name: "Disruption Start Date"
      expr: disruption_start_date
    - name: "Disruption Status"
      expr: disruption_status
    - name: "Estimated Fab Impact Wafer Starts"
      expr: estimated_fab_impact_wafer_starts
    - name: "Impact Estimate Wafer Starts"
      expr: impact_estimate_wafer_starts
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Risk Assessment"
      expr: COUNT(DISTINCT risk_assessment_id)
    - name: "Total Probability Percent"
      expr: SUM(probability_percent)
    - name: "Average Probability Percent"
      expr: AVG(probability_percent)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_sourcing_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing Contract business metrics"
  source: "`semiconductors_ecm`.`supply`.`sourcing_contract`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Commodity Code"
      expr: commodity_code
    - name: "Commodity Description"
      expr: commodity_description
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Force Majeure Clause"
      expr: force_majeure_clause
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Pcn Notification Obligation"
      expr: pcn_notification_obligation
    - name: "Price Escalation Clause"
      expr: price_escalation_clause
    - name: "Quality Requirements"
      expr: quality_requirements
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sourcing Contract"
      expr: COUNT(DISTINCT sourcing_contract_id)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Sourcing Supplier Fk"
      expr: SUM(sourcing_supplier_fk)
    - name: "Average Sourcing Supplier Fk"
      expr: AVG(sourcing_supplier_fk)
    - name: "Total Target Quantity"
      expr: SUM(target_quantity)
    - name: "Average Target Quantity"
      expr: AVG(target_quantity)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier business metrics"
  source: "`semiconductors_ecm`.`supply`.`supplier`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "City"
      expr: city
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Duns Number"
      expr: duns_number
    - name: "Ear Controlled"
      expr: ear_controlled
    - name: "Financial Rating"
      expr: financial_rating
    - name: "Global Footprint"
      expr: global_footprint
    - name: "Industry Classification"
      expr: industry_classification
    - name: "Is Certified Kga"
      expr: is_certified_kga
    - name: "Itar Controlled"
      expr: itar_controlled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier"
      expr: COUNT(DISTINCT supplier_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Audit business metrics"
  source: "`semiconductors_ecm`.`supply`.`supplier_audit`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Category"
      expr: audit_category
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Document Version"
      expr: audit_document_version
    - name: "Audit Method"
      expr: audit_method
    - name: "Audit Number"
      expr: audit_number
    - name: "Audit Report Url"
      expr: audit_report_url
    - name: "Audit Scope"
      expr: audit_scope
    - name: "Audit Source System"
      expr: audit_source_system
    - name: "Audit Status"
      expr: audit_status
    - name: "Audit Team"
      expr: audit_team
    - name: "Audit Type"
      expr: audit_type
    - name: "Auditor Notes"
      expr: auditor_notes
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Status"
      expr: corrective_action_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Audit"
      expr: COUNT(DISTINCT supplier_audit_id)
    - name: "Total Audit Cost Usd"
      expr: SUM(audit_cost_usd)
    - name: "Average Audit Cost Usd"
      expr: AVG(audit_cost_usd)
    - name: "Total Audit Duration Hours"
      expr: SUM(audit_duration_hours)
    - name: "Average Audit Duration Hours"
      expr: AVG(audit_duration_hours)
    - name: "Total Audit Findings Document Reference"
      expr: SUM(audit_findings_document_reference)
    - name: "Average Audit Findings Document Reference"
      expr: AVG(audit_findings_document_reference)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Sustainability Score"
      expr: SUM(sustainability_score)
    - name: "Average Sustainability Score"
      expr: AVG(sustainability_score)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Corrective Action business metrics"
  source: "`semiconductors_ecm`.`supply`.`supplier_corrective_action`"
  dimensions:
    - name: "Attached Document Url"
      expr: attached_document_url
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Containment Action"
      expr: containment_action
    - name: "Corrective Action"
      expr: corrective_action
    - name: "Corrective Action Status"
      expr: corrective_action_status
    - name: "Cost Justification"
      expr: cost_justification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Defect Description"
      expr: defect_description
    - name: "Due Date"
      expr: due_date
    - name: "Ear Controlled"
      expr: ear_controlled
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Issued Timestamp"
      expr: issued_timestamp
    - name: "Itar Controlled"
      expr: itar_controlled
    - name: "Notes"
      expr: notes
    - name: "Preventive Action"
      expr: preventive_action
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Corrective Action"
      expr: COUNT(DISTINCT supplier_corrective_action_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Qualification business metrics"
  source: "`semiconductors_ecm`.`supply`.`supplier_qualification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Team"
      expr: audit_team
    - name: "Audit Type"
      expr: audit_type
    - name: "Compliance Standards"
      expr: compliance_standards
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Corrective Action Status"
      expr: corrective_action_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Findings Severity"
      expr: findings_severity
    - name: "Findings Summary"
      expr: findings_summary
    - name: "Notes"
      expr: notes
    - name: "Overall Rating"
      expr: overall_rating
    - name: "Qualification Number"
      expr: qualification_number
    - name: "Qualification Program Type"
      expr: qualification_program_type
    - name: "Qualification Scope"
      expr: qualification_scope
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Qualification"
      expr: COUNT(DISTINCT supplier_qualification_id)
    - name: "Total Risk Assessment Score"
      expr: SUM(risk_assessment_score)
    - name: "Average Risk Assessment Score"
      expr: AVG(risk_assessment_score)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Scorecard business metrics"
  source: "`semiconductors_ecm`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "Assessment Name"
      expr: assessment_name
    - name: "Closure Date"
      expr: closure_date
    - name: "Contact Name"
      expr: contact_name
    - name: "Containment Action"
      expr: containment_action
    - name: "Corrective Action"
      expr: corrective_action
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Description"
      expr: defect_description
    - name: "Incoming Quality Rejection Rate Dppm"
      expr: incoming_quality_rejection_rate_dppm
    - name: "Notes"
      expr: notes
    - name: "Overall Rating"
      expr: overall_rating
    - name: "Pcn Compliance"
      expr: pcn_compliance
    - name: "Preventive Action"
      expr: preventive_action
    - name: "Root Cause"
      expr: root_cause
    - name: "Scar Due Date"
      expr: scar_due_date
    - name: "Scar Trigger Event"
      expr: scar_trigger_event
    - name: "Scorecard Type"
      expr: scorecard_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Scorecard"
      expr: COUNT(DISTINCT supplier_scorecard_id)
    - name: "Total On Time Delivery Rate"
      expr: SUM(on_time_delivery_rate)
    - name: "Average On Time Delivery Rate"
      expr: AVG(on_time_delivery_rate)
    - name: "Total Risk Assessment Score"
      expr: SUM(risk_assessment_score)
    - name: "Average Risk Assessment Score"
      expr: AVG(risk_assessment_score)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`supply_supply_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply Forecast business metrics"
  source: "`semiconductors_ecm`.`supply`.`supply_forecast`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Forecast Source"
      expr: forecast_source
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Forecast Type"
      expr: forecast_type
    - name: "Horizon End Date"
      expr: horizon_end_date
    - name: "Horizon Start Date"
      expr: horizon_start_date
    - name: "Is Ltb"
      expr: is_ltb
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Notes"
      expr: notes
    - name: "Period"
      expr: period
    - name: "Regulatory Status"
      expr: regulatory_status
    - name: "Risk Score"
      expr: risk_score
    - name: "Unit Of Measure"
      expr: unit_of_measure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supply Forecast"
      expr: COUNT(DISTINCT supply_forecast_id)
    - name: "Total Price Per Unit"
      expr: SUM(price_per_unit)
    - name: "Average Price Per Unit"
      expr: AVG(price_per_unit)
    - name: "Total Prior Forecast Quantity"
      expr: SUM(prior_forecast_quantity)
    - name: "Average Prior Forecast Quantity"
      expr: AVG(prior_forecast_quantity)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Supply Material Fk"
      expr: SUM(supply_material_fk)
    - name: "Average Supply Material Fk"
      expr: AVG(supply_material_fk)
    - name: "Total Supply Supplier Fk"
      expr: SUM(supply_supplier_fk)
    - name: "Average Supply Supplier Fk"
      expr: AVG(supply_supplier_fk)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
$$;