-- Metric views for domain: procurement | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:47:33

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`approved_vendor_list`"
  dimensions:
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Number"
      expr: approval_number
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Type"
      expr: approval_type
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Service Categories"
      expr: approved_service_categories
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Outcome"
      expr: audit_outcome
    - name: "Certification Requirements"
      expr: certification_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Financial Stability Check Date"
      expr: financial_stability_check_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Hsse Approval Date"
      expr: hsse_approval_date
    - name: "Hsse Approved"
      expr: hsse_approved
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Approved Vendor List"
      expr: COUNT(DISTINCT approved_vendor_list_id)
    - name: "Total Maximum Order Value"
      expr: SUM(maximum_order_value)
    - name: "Average Maximum Order Value"
      expr: AVG(maximum_order_value)
    - name: "Total Performance Score"
      expr: SUM(performance_score)
    - name: "Average Performance Score"
      expr: AVG(performance_score)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Receipt business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`goods_receipt`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Certificate Of Origin Number"
      expr: certificate_of_origin_number
    - name: "Container Number"
      expr: container_number
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Document Date"
      expr: document_date
    - name: "Document Number"
      expr: document_number
    - name: "Goods Receipt Status"
      expr: goods_receipt_status
    - name: "Hs Code"
      expr: hs_code
    - name: "Inspection Lot Number"
      expr: inspection_lot_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Receipt"
      expr: COUNT(DISTINCT goods_receipt_id)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Plant Code"
      expr: SUM(plant_code)
    - name: "Average Plant Code"
      expr: AVG(plant_code)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Valuation Amount"
      expr: SUM(valuation_amount)
    - name: "Average Valuation Amount"
      expr: AVG(valuation_amount)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_material_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Group business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`material_group`"
  dimensions:
    - name: "Approval Workflow"
      expr: approval_workflow
    - name: "Budget Allocation Code"
      expr: budget_allocation_code
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Contract Management Required"
      expr: contract_management_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Spare Indicator"
      expr: critical_spare_indicator
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Compliance Required"
      expr: environmental_compliance_required
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Hazmat Indicator"
      expr: hazmat_indicator
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hs Code Prefix"
      expr: hs_code_prefix
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Group"
      expr: COUNT(DISTINCT material_group_id)
    - name: "Total Annual Spend Estimate"
      expr: SUM(annual_spend_estimate)
    - name: "Average Annual Spend Estimate"
      expr: AVG(annual_spend_estimate)
    - name: "Total Local Content Requirement"
      expr: SUM(local_content_requirement)
    - name: "Average Local Content Requirement"
      expr: AVG(local_content_requirement)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_material_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Master business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`material_master`"
  dimensions:
    - name: "Abc Indicator"
      expr: abc_indicator
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Batch Management Flag"
      expr: batch_management_flag
    - name: "Created Date"
      expr: created_date
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Flag"
      expr: deletion_flag
    - name: "Hazardous Material Flag"
      expr: hazardous_material_flag
    - name: "Imdg Class"
      expr: imdg_class
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Lot Size Procedure"
      expr: lot_size_procedure
    - name: "Manufacturer Name"
      expr: manufacturer_name
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
    - name: "Material Description"
      expr: material_description
    - name: "Material Group"
      expr: material_group
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Master"
      expr: COUNT(DISTINCT material_master_id)
    - name: "Total Gross Weight"
      expr: SUM(gross_weight)
    - name: "Average Gross Weight"
      expr: AVG(gross_weight)
    - name: "Total Maximum Stock Level"
      expr: SUM(maximum_stock_level)
    - name: "Average Maximum Stock Level"
      expr: AVG(maximum_stock_level)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Moving Average Price"
      expr: SUM(moving_average_price)
    - name: "Average Moving Average Price"
      expr: AVG(moving_average_price)
    - name: "Total Net Weight"
      expr: SUM(net_weight)
    - name: "Average Net Weight"
      expr: AVG(net_weight)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Safety Stock Level"
      expr: SUM(safety_stock_level)
    - name: "Average Safety Stock Level"
      expr: AVG(safety_stock_level)
    - name: "Total Standard Price"
      expr: SUM(standard_price)
    - name: "Average Standard Price"
      expr: AVG(standard_price)
    - name: "Total Volume"
      expr: SUM(volume)
    - name: "Average Volume"
      expr: AVG(volume)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Threshold Tier"
      expr: approval_threshold_tier
    - name: "Approval Workflow Code"
      expr: approval_workflow_code
    - name: "Approved By"
      expr: approved_by
    - name: "Budget Code"
      expr: budget_code
    - name: "Competitive Tender Required Flag"
      expr: competitive_tender_required_flag
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Contract Management Required Flag"
      expr: contract_management_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hazmat Procurement Flag"
      expr: hazmat_procurement_flag
    - name: "Justification Notes"
      expr: justification_notes
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Period End Date"
      expr: period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plan"
      expr: COUNT(DISTINCT plan_id)
    - name: "Total Budget Commitment Amount"
      expr: SUM(budget_commitment_amount)
    - name: "Average Budget Commitment Amount"
      expr: AVG(budget_commitment_amount)
    - name: "Total Capex Allocation Amount"
      expr: SUM(capex_allocation_amount)
    - name: "Average Capex Allocation Amount"
      expr: AVG(capex_allocation_amount)
    - name: "Total Local Content Requirement Percentage"
      expr: SUM(local_content_requirement_percentage)
    - name: "Average Local Content Requirement Percentage"
      expr: AVG(local_content_requirement_percentage)
    - name: "Total Opex Allocation Amount"
      expr: SUM(opex_allocation_amount)
    - name: "Average Opex Allocation Amount"
      expr: AVG(opex_allocation_amount)
    - name: "Total Total Planned Spend Amount"
      expr: SUM(total_planned_spend_amount)
    - name: "Average Total Planned Spend Amount"
      expr: AVG(total_planned_spend_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`purchase_order`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Date"
      expr: cancelled_date
    - name: "Closed Date"
      expr: closed_date
    - name: "Collective Number"
      expr: collective_number
    - name: "Company Code"
      expr: company_code
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Address"
      expr: delivery_address
    - name: "Delivery Country Code"
      expr: delivery_country_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Delivery Postal Code"
      expr: delivery_postal_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order"
      expr: COUNT(DISTINCT purchase_order_id)
    - name: "Total Net Order Value"
      expr: SUM(net_order_value)
    - name: "Average Net Order Value"
      expr: AVG(net_order_value)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Po Value"
      expr: SUM(total_po_value)
    - name: "Average Total Po Value"
      expr: AVG(total_po_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_purchase_order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Order Item business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`purchase_order_item`"
  dimensions:
    - name: "Account Assignment Category"
      expr: account_assignment_category
    - name: "Asset Number"
      expr: asset_number
    - name: "Confirmation Control Key"
      expr: confirmation_control_key
    - name: "Cost Center"
      expr: cost_center
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Delivery Date"
      expr: delivery_date
    - name: "General Ledger Account"
      expr: general_ledger_account
    - name: "Goods Receipt Indicator"
      expr: goods_receipt_indicator
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Invoice Receipt Indicator"
      expr: invoice_receipt_indicator
    - name: "Item Category"
      expr: item_category
    - name: "Item Number"
      expr: item_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Order Item"
      expr: COUNT(DISTINCT purchase_order_item_id)
    - name: "Total Goods Receipt Quantity"
      expr: SUM(goods_receipt_quantity)
    - name: "Average Goods Receipt Quantity"
      expr: AVG(goods_receipt_quantity)
    - name: "Total Invoiced Quantity"
      expr: SUM(invoiced_quantity)
    - name: "Average Invoiced Quantity"
      expr: AVG(invoiced_quantity)
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
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
    - name: "Total Under Delivery Tolerance Percent"
      expr: SUM(under_delivery_tolerance_percent)
    - name: "Average Under Delivery Tolerance Percent"
      expr: AVG(under_delivery_tolerance_percent)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_purchase_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Requisition business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`purchase_requisition`"
  dimensions:
    - name: "Account Assignment Category"
      expr: account_assignment_category
    - name: "Approval Date"
      expr: approval_date
    - name: "Asset Number"
      expr: asset_number
    - name: "Contract Number"
      expr: contract_number
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Fixed Vendor Indicator"
      expr: fixed_vendor_indicator
    - name: "Gl Account"
      expr: gl_account
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Item Category"
      expr: item_category
    - name: "Material Description"
      expr: material_description
    - name: "Material Group"
      expr: material_group
    - name: "Material Number"
      expr: material_number
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

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_purchase_requisition_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase Requisition Item business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`purchase_requisition_item`"
  dimensions:
    - name: "Account Assignment Category"
      expr: account_assignment_category
    - name: "Asset Number"
      expr: asset_number
    - name: "Contract Item"
      expr: contract_item
    - name: "Contract Number"
      expr: contract_number
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Fixed Vendor Indicator"
      expr: fixed_vendor_indicator
    - name: "Gl Account"
      expr: gl_account
    - name: "Goods Receipt Indicator"
      expr: goods_receipt_indicator
    - name: "Internal Order"
      expr: internal_order
    - name: "Invoice Receipt Indicator"
      expr: invoice_receipt_indicator
    - name: "Item Category"
      expr: item_category
    - name: "Item Number"
      expr: item_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchase Requisition Item"
      expr: COUNT(DISTINCT purchase_requisition_item_id)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Total Value"
      expr: SUM(total_value)
    - name: "Average Total Value"
      expr: AVG(total_value)
    - name: "Total Valuation Price"
      expr: SUM(valuation_price)
    - name: "Average Valuation Price"
      expr: AVG(valuation_price)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_purchasing_info`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchasing Info business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`purchasing_info`"
  dimensions:
    - name: "Acknowledgement Required"
      expr: acknowledgement_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Goods Receipt Processing Time Days"
      expr: goods_receipt_processing_time_days
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Info Record Category"
      expr: info_record_category
    - name: "Info Record Number"
      expr: info_record_number
    - name: "Info Record Status"
      expr: info_record_status
    - name: "Last Purchase Order Date"
      expr: last_purchase_order_date
    - name: "Last Purchase Order Number"
      expr: last_purchase_order_number
    - name: "Manufacturer Name"
      expr: manufacturer_name
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Terms"
      expr: payment_terms
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Purchasing Info"
      expr: COUNT(DISTINCT purchasing_info_id)
    - name: "Total Last Purchase Price"
      expr: SUM(last_purchase_price)
    - name: "Average Last Purchase Price"
      expr: AVG(last_purchase_price)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Order Quantity Multiple"
      expr: SUM(order_quantity_multiple)
    - name: "Average Order Quantity Multiple"
      expr: AVG(order_quantity_multiple)
    - name: "Total Over Delivery Tolerance Percent"
      expr: SUM(over_delivery_tolerance_percent)
    - name: "Average Over Delivery Tolerance Percent"
      expr: AVG(over_delivery_tolerance_percent)
    - name: "Total Standard Order Quantity"
      expr: SUM(standard_order_quantity)
    - name: "Average Standard Order Quantity"
      expr: AVG(standard_order_quantity)
    - name: "Total Under Delivery Tolerance Percent"
      expr: SUM(under_delivery_tolerance_percent)
    - name: "Average Under Delivery Tolerance Percent"
      expr: AVG(under_delivery_tolerance_percent)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rfq business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`rfq`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Award Date"
      expr: award_date
    - name: "Award Justification"
      expr: award_justification
    - name: "Awarded Quotation Number"
      expr: awarded_quotation_number
    - name: "Commodity Description"
      expr: commodity_description
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Contract Type"
      expr: contract_type
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Environmental Requirements"
      expr: environmental_requirements
    - name: "Evaluation Criteria"
      expr: evaluation_criteria
    - name: "Gl Account"
      expr: gl_account
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rfq"
      expr: COUNT(DISTINCT rfq_id)
    - name: "Total Lowest Quoted Price"
      expr: SUM(lowest_quoted_price)
    - name: "Average Lowest Quoted Price"
      expr: AVG(lowest_quoted_price)
    - name: "Total Quantity Requested"
      expr: SUM(quantity_requested)
    - name: "Average Quantity Requested"
      expr: AVG(quantity_requested)
    - name: "Total Total Estimated Value"
      expr: SUM(total_estimated_value)
    - name: "Average Total Estimated Value"
      expr: AVG(total_estimated_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_service_entry_sheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Entry Sheet business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`service_entry_sheet`"
  dimensions:
    - name: "Acceptance Date"
      expr: acceptance_date
    - name: "Acceptance Timestamp"
      expr: acceptance_timestamp
    - name: "Accepted By Name"
      expr: accepted_by_name
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Company Code"
      expr: company_code
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Date"
      expr: document_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Invoice Verification Status"
      expr: invoice_verification_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Release Status"
      expr: payment_release_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Entry Sheet"
      expr: COUNT(DISTINCT service_entry_sheet_id)
    - name: "Total Total Accepted Quantity"
      expr: SUM(total_accepted_quantity)
    - name: "Average Total Accepted Quantity"
      expr: AVG(total_accepted_quantity)
    - name: "Total Total Accepted Value"
      expr: SUM(total_accepted_value)
    - name: "Average Total Accepted Value"
      expr: AVG(total_accepted_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Contract business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Commodity Code"
      expr: commodity_code
    - name: "Company Code"
      expr: company_code
    - name: "Compliance Requirements"
      expr: compliance_requirements
    - name: "Confidentiality Clause"
      expr: confidentiality_clause
    - name: "Contract Description"
      expr: contract_description
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Owner"
      expr: contract_owner
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Contract"
      expr: COUNT(DISTINCT supplier_contract_id)
    - name: "Total Contract Value"
      expr: SUM(contract_value)
    - name: "Average Contract Value"
      expr: AVG(contract_value)
    - name: "Total Released Quantity"
      expr: SUM(released_quantity)
    - name: "Average Released Quantity"
      expr: AVG(released_quantity)
    - name: "Total Released Value"
      expr: SUM(released_value)
    - name: "Average Released Value"
      expr: AVG(released_value)
    - name: "Total Target Quantity"
      expr: SUM(target_quantity)
    - name: "Average Target Quantity"
      expr: AVG(target_quantity)
    - name: "Total Utilization Percentage"
      expr: SUM(utilization_percentage)
    - name: "Average Utilization Percentage"
      expr: AVG(utilization_percentage)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_supplier_contract_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Contract Item business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`supplier_contract_item`"
  dimensions:
    - name: "Blocking Indicator"
      expr: blocking_indicator
    - name: "Contract Item Number"
      expr: contract_item_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deletion Indicator"
      expr: deletion_indicator
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "Goods Receipt Required"
      expr: goods_receipt_required
    - name: "Incoterms"
      expr: incoterms
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Invoice Receipt Required"
      expr: invoice_receipt_required
    - name: "Item Category"
      expr: item_category
    - name: "Item Status"
      expr: item_status
    - name: "Last Goods Receipt Date"
      expr: last_goods_receipt_date
    - name: "Last Release Order Date"
      expr: last_release_order_date
    - name: "Manufacturer Part Number"
      expr: manufacturer_part_number
    - name: "Material Description"
      expr: material_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Contract Item"
      expr: COUNT(DISTINCT supplier_contract_item_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Maximum Order Quantity"
      expr: SUM(maximum_order_quantity)
    - name: "Average Maximum Order Quantity"
      expr: AVG(maximum_order_quantity)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Order Quantity Multiple"
      expr: SUM(order_quantity_multiple)
    - name: "Average Order Quantity Multiple"
      expr: AVG(order_quantity_multiple)
    - name: "Total Released Quantity"
      expr: SUM(released_quantity)
    - name: "Average Released Quantity"
      expr: AVG(released_quantity)
    - name: "Total Released Value"
      expr: SUM(released_value)
    - name: "Average Released Value"
      expr: AVG(released_value)
    - name: "Total Remaining Quantity"
      expr: SUM(remaining_quantity)
    - name: "Average Remaining Quantity"
      expr: AVG(remaining_quantity)
    - name: "Total Remaining Value"
      expr: SUM(remaining_value)
    - name: "Average Remaining Value"
      expr: AVG(remaining_value)
    - name: "Total Target Quantity"
      expr: SUM(target_quantity)
    - name: "Average Target Quantity"
      expr: AVG(target_quantity)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`tender`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Workflow Code"
      expr: approval_workflow_code
    - name: "Award Date"
      expr: award_date
    - name: "Bid Bond Required"
      expr: bid_bond_required
    - name: "Budget Allocation Code"
      expr: budget_allocation_code
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Closing Date"
      expr: closing_date
    - name: "Closing Time"
      expr: closing_time
    - name: "Commodity Scope"
      expr: commodity_scope
    - name: "Company Code"
      expr: company_code
    - name: "Contract Duration Months"
      expr: contract_duration_months
    - name: "Cost Center"
      expr: cost_center
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Location"
      expr: delivery_location
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tender"
      expr: COUNT(DISTINCT tender_id)
    - name: "Total Awarded Value"
      expr: SUM(awarded_value)
    - name: "Average Awarded Value"
      expr: AVG(awarded_value)
    - name: "Total Bid Bond Amount"
      expr: SUM(bid_bond_amount)
    - name: "Average Bid Bond Amount"
      expr: AVG(bid_bond_amount)
    - name: "Total Estimated Value"
      expr: SUM(estimated_value)
    - name: "Average Estimated Value"
      expr: AVG(estimated_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Approved Commodity Categories"
      expr: approved_commodity_categories
    - name: "Bank Account Currency"
      expr: bank_account_currency
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Account Valid From"
      expr: bank_account_valid_from
    - name: "Bank Account Valid To"
      expr: bank_account_valid_to
    - name: "Bank Branch"
      expr: bank_branch
    - name: "Bank Name"
      expr: bank_name
    - name: "Business Registration Number"
      expr: business_registration_number
    - name: "City"
      expr: city
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Iban"
      expr: iban
    - name: "Iso 14001 Certificate Number"
      expr: iso_14001_certificate_number
    - name: "Iso 14001 Certified"
      expr: iso_14001_certified
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor"
      expr: COUNT(DISTINCT vendor_id)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Minimum Order Value"
      expr: SUM(minimum_order_value)
    - name: "Average Minimum Order Value"
      expr: AVG(minimum_order_value)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Bank Account business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_bank_account`"
  dimensions:
    - name: "Account Holder Name"
      expr: account_holder_name
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Account Purpose"
      expr: bank_account_purpose
    - name: "Bank Address Line1"
      expr: bank_address_line1
    - name: "Bank Address Line2"
      expr: bank_address_line2
    - name: "Bank Branch"
      expr: bank_branch
    - name: "Bank City"
      expr: bank_city
    - name: "Bank Control Key"
      expr: bank_control_key
    - name: "Bank Country Code"
      expr: bank_country_code
    - name: "Bank Key"
      expr: bank_key
    - name: "Bank Name"
      expr: bank_name
    - name: "Bank Postal Code"
      expr: bank_postal_code
    - name: "Bank State Province"
      expr: bank_state_province
    - name: "Block Reason"
      expr: block_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Bank Account"
      expr: COUNT(DISTINCT vendor_bank_account_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Certification business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_certification`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Audit Frequency Months"
      expr: audit_frequency_months
    - name: "Certificate Document Url"
      expr: certificate_document_url
    - name: "Certification Level"
      expr: certification_level
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Scope"
      expr: certification_scope
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Is Verified"
      expr: is_verified
    - name: "Issue Date"
      expr: issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Certification"
      expr: COUNT(DISTINCT vendor_certification_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_commodity_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Commodity Approval business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_commodity_approval`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Date"
      expr: approved_date
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Certification Number"
      expr: certification_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Supply Date"
      expr: last_supply_date
    - name: "Notes"
      expr: notes
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Approved Date Month"
      expr: DATE_TRUNC('MONTH', approved_date)
    - name: "Certification Expiry Date Month"
      expr: DATE_TRUNC('MONTH', certification_expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Commodity Approval"
      expr: COUNT(DISTINCT vendor_commodity_approval_id)
    - name: "Total Quality Rating"
      expr: SUM(quality_rating)
    - name: "Average Quality Rating"
      expr: AVG(quality_rating)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Evaluation business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_evaluation`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Vendor Tier"
      expr: current_vendor_tier
    - name: "Evaluation Comments"
      expr: evaluation_comments
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Evaluation Number"
      expr: evaluation_number
    - name: "Evaluation Period End Date"
      expr: evaluation_period_end_date
    - name: "Evaluation Period Start Date"
      expr: evaluation_period_start_date
    - name: "Evaluation Status"
      expr: evaluation_status
    - name: "Evaluation Type"
      expr: evaluation_type
    - name: "Evaluator Name"
      expr: evaluator_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Evaluation"
      expr: COUNT(DISTINCT vendor_evaluation_id)
    - name: "Total Documentation Compliance Score"
      expr: SUM(documentation_compliance_score)
    - name: "Average Documentation Compliance Score"
      expr: AVG(documentation_compliance_score)
    - name: "Total Documentation Compliance Weight"
      expr: SUM(documentation_compliance_weight)
    - name: "Average Documentation Compliance Weight"
      expr: AVG(documentation_compliance_weight)
    - name: "Total Hsse Compliance Score"
      expr: SUM(hsse_compliance_score)
    - name: "Average Hsse Compliance Score"
      expr: AVG(hsse_compliance_score)
    - name: "Total Hsse Compliance Weight"
      expr: SUM(hsse_compliance_weight)
    - name: "Average Hsse Compliance Weight"
      expr: AVG(hsse_compliance_weight)
    - name: "Total On Time Delivery Score"
      expr: SUM(on_time_delivery_score)
    - name: "Average On Time Delivery Score"
      expr: AVG(on_time_delivery_score)
    - name: "Total On Time Delivery Weight"
      expr: SUM(on_time_delivery_weight)
    - name: "Average On Time Delivery Weight"
      expr: AVG(on_time_delivery_weight)
    - name: "Total Overall Score"
      expr: SUM(overall_score)
    - name: "Average Overall Score"
      expr: AVG(overall_score)
    - name: "Total Price Competitiveness Score"
      expr: SUM(price_competitiveness_score)
    - name: "Average Price Competitiveness Score"
      expr: AVG(price_competitiveness_score)
    - name: "Total Price Competitiveness Weight"
      expr: SUM(price_competitiveness_weight)
    - name: "Average Price Competitiveness Weight"
      expr: AVG(price_competitiveness_weight)
    - name: "Total Quality Acceptance Rate"
      expr: SUM(quality_acceptance_rate)
    - name: "Average Quality Acceptance Rate"
      expr: AVG(quality_acceptance_rate)
    - name: "Total Quality Compliance Score"
      expr: SUM(quality_compliance_score)
    - name: "Average Quality Compliance Score"
      expr: AVG(quality_compliance_score)
    - name: "Total Quality Compliance Weight"
      expr: SUM(quality_compliance_weight)
    - name: "Average Quality Compliance Weight"
      expr: AVG(quality_compliance_weight)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Invoice business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_invoice`"
  dimensions:
    - name: "Baseline Date"
      expr: baseline_date
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Header Text"
      expr: document_header_text
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Receipt Date"
      expr: invoice_receipt_date
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Invoice Type"
      expr: invoice_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Block Code"
      expr: payment_block_code
    - name: "Payment Block Reason"
      expr: payment_block_reason
    - name: "Payment Date"
      expr: payment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Invoice"
      expr: COUNT(DISTINCT vendor_invoice_id)
    - name: "Total Cash Discount Amount"
      expr: SUM(cash_discount_amount)
    - name: "Average Cash Discount Amount"
      expr: AVG(cash_discount_amount)
    - name: "Total Cash Discount Percentage"
      expr: SUM(cash_discount_percentage)
    - name: "Average Cash Discount Percentage"
      expr: AVG(cash_discount_percentage)
    - name: "Total Invoice Gross Amount"
      expr: SUM(invoice_gross_amount)
    - name: "Average Invoice Gross Amount"
      expr: AVG(invoice_gross_amount)
    - name: "Total Invoice Net Amount"
      expr: SUM(invoice_net_amount)
    - name: "Average Invoice Net Amount"
      expr: AVG(invoice_net_amount)
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
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Quotation business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_quotation`"
  dimensions:
    - name: "Award Justification"
      expr: award_justification
    - name: "Commercial Terms Notes"
      expr: commercial_terms_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Incoterms"
      expr: incoterms
    - name: "Material Group"
      expr: material_group
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Price Competitiveness Rank"
      expr: price_competitiveness_rank
    - name: "Purchasing Group"
      expr: purchasing_group
    - name: "Purchasing Organization"
      expr: purchasing_organization
    - name: "Quotation Number"
      expr: quotation_number
    - name: "Quotation Status"
      expr: quotation_status
    - name: "Quotation Type"
      expr: quotation_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Quotation"
      expr: COUNT(DISTINCT vendor_quotation_id)
    - name: "Total Evaluation Score"
      expr: SUM(evaluation_score)
    - name: "Average Evaluation Score"
      expr: AVG(evaluation_score)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Quoted Value"
      expr: SUM(total_quoted_value)
    - name: "Average Total Quoted Value"
      expr: AVG(total_quoted_value)
    - name: "Total Total Value Including Tax"
      expr: SUM(total_value_including_tax)
    - name: "Average Total Value Including Tax"
      expr: AVG(total_value_including_tax)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`procurement_vendor_service_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Service Rate Card business metrics"
  source: "`shipping_ports_ecm`.`procurement`.`vendor_service_rate_card`"
  dimensions:
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Rate Review Date"
      expr: last_rate_review_date
    - name: "Next Rate Review Date"
      expr: next_rate_review_date
    - name: "Notes"
      expr: notes
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Rate Card Status"
      expr: rate_card_status
    - name: "Rate Currency Code"
      expr: rate_currency_code
    - name: "Sla Response Time Hours"
      expr: sla_response_time_hours
    - name: "Volume Discount Tier"
      expr: volume_discount_tier
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Service Rate Card"
      expr: COUNT(DISTINCT vendor_service_rate_card_id)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
    - name: "Total Negotiated Rate"
      expr: SUM(negotiated_rate)
    - name: "Average Negotiated Rate"
      expr: AVG(negotiated_rate)
$$;