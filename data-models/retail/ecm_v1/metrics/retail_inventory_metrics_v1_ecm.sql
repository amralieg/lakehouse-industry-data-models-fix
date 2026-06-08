-- Metric views for domain: inventory | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:06:02

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment business metrics"
  source: "`retail_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "Adjustment Number"
      expr: adjustment_number
    - name: "Adjustment Status"
      expr: adjustment_status
    - name: "Adjustment Timestamp"
      expr: adjustment_timestamp
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Detection Method"
      expr: detection_method
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Is Shrinkage"
      expr: is_shrinkage
    - name: "Is System Generated"
      expr: is_system_generated
    - name: "Location Type"
      expr: location_type
    - name: "Lp Case Reference"
      expr: lp_case_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adjustment"
      expr: COUNT(DISTINCT adjustment_id)
    - name: "Total Adjusted Quantity"
      expr: SUM(adjusted_quantity)
    - name: "Average Adjusted Quantity"
      expr: AVG(adjusted_quantity)
    - name: "Total Cost Impact"
      expr: SUM(cost_impact)
    - name: "Average Cost Impact"
      expr: AVG(cost_impact)
    - name: "Total Quantity After Adjustment"
      expr: SUM(quantity_after_adjustment)
    - name: "Average Quantity After Adjustment"
      expr: AVG(quantity_after_adjustment)
    - name: "Total Quantity Before Adjustment"
      expr: SUM(quantity_before_adjustment)
    - name: "Average Quantity Before Adjustment"
      expr: AVG(quantity_before_adjustment)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_asn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asn business metrics"
  source: "`retail_ecm`.`inventory`.`asn`"
  dimensions:
    - name: "Actual Arrival Date"
      expr: actual_arrival_date
    - name: "Asn Number"
      expr: asn_number
    - name: "Asn Status"
      expr: asn_status
    - name: "Asn Type"
      expr: asn_type
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Node Type"
      expr: destination_node_type
    - name: "Discrepancy Flag"
      expr: discrepancy_flag
    - name: "Discrepancy Type"
      expr: discrepancy_type
    - name: "Dock Door Number"
      expr: dock_door_number
    - name: "Expected Arrival Date"
      expr: expected_arrival_date
    - name: "Freight Terms"
      expr: freight_terms
    - name: "Is Cross Dock"
      expr: is_cross_dock
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Po Number"
      expr: po_number
    - name: "Pro Number"
      expr: pro_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asn"
      expr: COUNT(DISTINCT asn_id)
    - name: "Total Total Volume M3"
      expr: SUM(total_volume_m3)
    - name: "Average Total Volume M3"
      expr: AVG(total_volume_m3)
    - name: "Total Total Weight Kg"
      expr: SUM(total_weight_kg)
    - name: "Average Total Weight Kg"
      expr: AVG(total_weight_kg)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_assortment_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment Deployment business metrics"
  source: "`retail_ecm`.`inventory`.`assortment_deployment`"
  dimensions:
    - name: "Actual Sku Count"
      expr: actual_sku_count
    - name: "Deployment Completion Date"
      expr: deployment_completion_date
    - name: "Deployment Start Date"
      expr: deployment_start_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Implementation Status"
      expr: implementation_status
    - name: "Last Compliance Check Date"
      expr: last_compliance_check_date
    - name: "Notes"
      expr: notes
    - name: "Planned Sku Count"
      expr: planned_sku_count
    - name: "Deployment Completion Date Month"
      expr: DATE_TRUNC('MONTH', deployment_completion_date)
    - name: "Deployment Start Date Month"
      expr: DATE_TRUNC('MONTH', deployment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assortment Deployment"
      expr: COUNT(DISTINCT assortment_deployment_id)
    - name: "Total Compliance Percentage"
      expr: SUM(compliance_percentage)
    - name: "Average Compliance Percentage"
      expr: AVG(compliance_percentage)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle Count business metrics"
  source: "`retail_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "Abc Classification"
      expr: abc_classification
    - name: "Adjustment Generated"
      expr: adjustment_generated
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Count Device Code"
      expr: count_device_code
    - name: "Count End Timestamp"
      expr: count_end_timestamp
    - name: "Count Frequency"
      expr: count_frequency
    - name: "Count Notes"
      expr: count_notes
    - name: "Count Number"
      expr: count_number
    - name: "Count Start Timestamp"
      expr: count_start_timestamp
    - name: "Count Status"
      expr: count_status
    - name: "Count Type"
      expr: count_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Planogram Location"
      expr: planogram_location
    - name: "Recount Number"
      expr: recount_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cycle Count"
      expr: COUNT(DISTINCT cycle_count_id)
    - name: "Total Counted Quantity"
      expr: SUM(counted_quantity)
    - name: "Average Counted Quantity"
      expr: AVG(counted_quantity)
    - name: "Total System Quantity"
      expr: SUM(system_quantity)
    - name: "Average System Quantity"
      expr: AVG(system_quantity)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Variance Cost"
      expr: SUM(variance_cost)
    - name: "Average Variance Cost"
      expr: AVG(variance_cost)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
    - name: "Total Variance Tolerance Pct"
      expr: SUM(variance_tolerance_pct)
    - name: "Average Variance Tolerance Pct"
      expr: AVG(variance_tolerance_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_expiry_tracking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expiry Tracking business metrics"
  source: "`retail_ecm`.`inventory`.`expiry_tracking`"
  dimensions:
    - name: "Action Completed Date"
      expr: action_completed_date
    - name: "Action Status"
      expr: action_status
    - name: "Batch Number"
      expr: batch_number
    - name: "Best Before Date"
      expr: best_before_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Threshold Days"
      expr: critical_threshold_days
    - name: "Currency Code"
      expr: currency_code
    - name: "Days To Expiry"
      expr: days_to_expiry
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Expiry Risk Status"
      expr: expiry_risk_status
    - name: "Fefo Sequence"
      expr: fefo_sequence
    - name: "Is Recall Active"
      expr: is_recall_active
    - name: "Is Rfid Tracked"
      expr: is_rfid_tracked
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Last Cycle Count Date"
      expr: last_cycle_count_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Expiry Tracking"
      expr: COUNT(DISTINCT expiry_tracking_id)
    - name: "Total Inventory Cost Per Unit"
      expr: SUM(inventory_cost_per_unit)
    - name: "Average Inventory Cost Per Unit"
      expr: AVG(inventory_cost_per_unit)
    - name: "Total Quantity At Risk"
      expr: SUM(quantity_at_risk)
    - name: "Average Quantity At Risk"
      expr: AVG(quantity_at_risk)
    - name: "Total Quantity Disposed"
      expr: SUM(quantity_disposed)
    - name: "Average Quantity Disposed"
      expr: AVG(quantity_disposed)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
    - name: "Total Remaining Shelf Life Pct"
      expr: SUM(remaining_shelf_life_pct)
    - name: "Average Remaining Shelf Life Pct"
      expr: AVG(remaining_shelf_life_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Receipt business metrics"
  source: "`retail_ecm`.`inventory`.`goods_receipt`"
  dimensions:
    - name: "Bill Of Lading Number"
      expr: bill_of_lading_number
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Chargeback Eligible"
      expr: chargeback_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discrepancy Resolution Status"
      expr: discrepancy_resolution_status
    - name: "Discrepancy Type"
      expr: discrepancy_type
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Po Number"
      expr: po_number
    - name: "Quality Inspection Status"
      expr: quality_inspection_status
    - name: "Receipt Date"
      expr: receipt_date
    - name: "Receipt Method"
      expr: receipt_method
    - name: "Receipt Notes"
      expr: receipt_notes
    - name: "Receipt Number"
      expr: receipt_number
    - name: "Receipt Status"
      expr: receipt_status
    - name: "Receipt Timestamp"
      expr: receipt_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Receipt"
      expr: COUNT(DISTINCT goods_receipt_id)
    - name: "Total Accepted Qty"
      expr: SUM(accepted_qty)
    - name: "Average Accepted Qty"
      expr: AVG(accepted_qty)
    - name: "Total Expected Qty"
      expr: SUM(expected_qty)
    - name: "Average Expected Qty"
      expr: AVG(expected_qty)
    - name: "Total Ordered Qty"
      expr: SUM(ordered_qty)
    - name: "Average Ordered Qty"
      expr: AVG(ordered_qty)
    - name: "Total Overage Qty"
      expr: SUM(overage_qty)
    - name: "Average Overage Qty"
      expr: AVG(overage_qty)
    - name: "Total Received Qty"
      expr: SUM(received_qty)
    - name: "Average Received Qty"
      expr: AVG(received_qty)
    - name: "Total Rejected Qty"
      expr: SUM(rejected_qty)
    - name: "Average Rejected Qty"
      expr: AVG(rejected_qty)
    - name: "Total Shortage Qty"
      expr: SUM(shortage_qty)
    - name: "Average Shortage Qty"
      expr: AVG(shortage_qty)
    - name: "Total Total Receipt Cost"
      expr: SUM(total_receipt_cost)
    - name: "Average Total Receipt Cost"
      expr: AVG(total_receipt_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_inventory_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Node business metrics"
  source: "`retail_ecm`.`inventory`.`inventory_node`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Close Date"
      expr: close_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Count Frequency"
      expr: cycle_count_frequency
    - name: "District Code"
      expr: district_code
    - name: "Dock Door Count"
      expr: dock_door_count
    - name: "Format Code"
      expr: format_code
    - name: "Gln"
      expr: gln
    - name: "Is Bopis Enabled"
      expr: is_bopis_enabled
    - name: "Is Drop Ship Origin"
      expr: is_drop_ship_origin
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Is Ropis Enabled"
      expr: is_ropis_enabled
    - name: "Is Ship From Store Enabled"
      expr: is_ship_from_store_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Node"
      expr: COUNT(DISTINCT inventory_node_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Selling Area Sqft"
      expr: SUM(selling_area_sqft)
    - name: "Average Selling Area Sqft"
      expr: AVG(selling_area_sqft)
    - name: "Total Total Storage Capacity Sqft"
      expr: SUM(total_storage_capacity_sqft)
    - name: "Average Total Storage Capacity Sqft"
      expr: AVG(total_storage_capacity_sqft)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_location_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location Assignment business metrics"
  source: "`retail_ecm`.`inventory`.`location_assignment`"
  dimensions:
    - name: "Access Level"
      expr: access_level
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Primary Location Flag"
      expr: primary_location_flag
    - name: "Role At Location"
      expr: role_at_location
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Assignment End Date Month"
      expr: DATE_TRUNC('MONTH', assignment_end_date)
    - name: "Assignment Start Date Month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Location Assignment"
      expr: COUNT(DISTINCT location_assignment_id)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot business metrics"
  source: "`retail_ecm`.`inventory`.`lot`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Best Before Date"
      expr: best_before_date
    - name: "Certification Code"
      expr: certification_code
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fefo Sequence"
      expr: fefo_sequence
    - name: "Gtin"
      expr: gtin
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Lot Number"
      expr: lot_number
    - name: "Lot Status"
      expr: lot_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot"
      expr: COUNT(DISTINCT lot_id)
    - name: "Total Available Quantity"
      expr: SUM(available_quantity)
    - name: "Average Available Quantity"
      expr: AVG(available_quantity)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_node_assortment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Node Assortment business metrics"
  source: "`retail_ecm`.`inventory`.`node_assortment`"
  dimensions:
    - name: "Actual Sku Count"
      expr: actual_sku_count
    - name: "Assortment Status"
      expr: assortment_status
    - name: "Category Manager Override Name"
      expr: category_manager_override_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Local Assortment Override"
      expr: local_assortment_override
    - name: "Max Presentation Qty"
      expr: max_presentation_qty
    - name: "Min Presentation Qty"
      expr: min_presentation_qty
    - name: "Planogram Count"
      expr: planogram_count
    - name: "Replenishment Priority"
      expr: replenishment_priority
    - name: "Shelf Capacity Units"
      expr: shelf_capacity_units
    - name: "Target Sku Count"
      expr: target_sku_count
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Node Assortment"
      expr: COUNT(DISTINCT node_assortment_id)
    - name: "Total Space Allocation Sqft"
      expr: SUM(space_allocation_sqft)
    - name: "Average Space Allocation Sqft"
      expr: AVG(space_allocation_sqft)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_promo_stock_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Stock Allocation business metrics"
  source: "`retail_ecm`.`inventory`.`promo_stock_allocation`"
  dimensions:
    - name: "Allocation Created By"
      expr: allocation_created_by
    - name: "Allocation Created Date"
      expr: allocation_created_date
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Display Location Code"
      expr: display_location_code
    - name: "Offer End Date"
      expr: offer_end_date
    - name: "Offer Start Date"
      expr: offer_start_date
    - name: "Allocation Created Date Month"
      expr: DATE_TRUNC('MONTH', allocation_created_date)
    - name: "Offer End Date Month"
      expr: DATE_TRUNC('MONTH', offer_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Stock Allocation"
      expr: COUNT(DISTINCT promo_stock_allocation_id)
    - name: "Total Actual Units Sold"
      expr: SUM(actual_units_sold)
    - name: "Average Actual Units Sold"
      expr: AVG(actual_units_sold)
    - name: "Total Promotional Inventory Reserve Qty"
      expr: SUM(promotional_inventory_reserve_qty)
    - name: "Average Promotional Inventory Reserve Qty"
      expr: AVG(promotional_inventory_reserve_qty)
    - name: "Total Promotional Price"
      expr: SUM(promotional_price)
    - name: "Average Promotional Price"
      expr: AVG(promotional_price)
    - name: "Total Promotional Quantity Threshold"
      expr: SUM(promotional_quantity_threshold)
    - name: "Average Promotional Quantity Threshold"
      expr: AVG(promotional_quantity_threshold)
    - name: "Total Promotional Revenue"
      expr: SUM(promotional_revenue)
    - name: "Average Promotional Revenue"
      expr: AVG(promotional_revenue)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_reorder_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reorder Policy business metrics"
  source: "`retail_ecm`.`inventory`.`reorder_policy`"
  dimensions:
    - name: "Abc Classification"
      expr: abc_classification
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Auto Replenishment"
      expr: is_auto_replenishment
    - name: "Is Seasonal"
      expr: is_seasonal
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Location Type"
      expr: location_type
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Policy Code"
      expr: policy_code
    - name: "Policy Name"
      expr: policy_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reorder Policy"
      expr: COUNT(DISTINCT reorder_policy_id)
    - name: "Total Max Stock Quantity"
      expr: SUM(max_stock_quantity)
    - name: "Average Max Stock Quantity"
      expr: AVG(max_stock_quantity)
    - name: "Total Min Stock Quantity"
      expr: SUM(min_stock_quantity)
    - name: "Average Min Stock Quantity"
      expr: AVG(min_stock_quantity)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total Order Multiple"
      expr: SUM(order_multiple)
    - name: "Average Order Multiple"
      expr: AVG(order_multiple)
    - name: "Total Order Quantity"
      expr: SUM(order_quantity)
    - name: "Average Order Quantity"
      expr: AVG(order_quantity)
    - name: "Total Reorder Point Quantity"
      expr: SUM(reorder_point_quantity)
    - name: "Average Reorder Point Quantity"
      expr: AVG(reorder_point_quantity)
    - name: "Total Safety Stock Quantity"
      expr: SUM(safety_stock_quantity)
    - name: "Average Safety Stock Quantity"
      expr: AVG(safety_stock_quantity)
    - name: "Total Target Days Of Supply"
      expr: SUM(target_days_of_supply)
    - name: "Average Target Days Of Supply"
      expr: AVG(target_days_of_supply)
    - name: "Total Target Wos"
      expr: SUM(target_wos)
    - name: "Average Target Wos"
      expr: AVG(target_wos)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment Order business metrics"
  source: "`retail_ecm`.`inventory`.`replenishment_order`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Buyer Notes"
      expr: buyer_notes
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Delivery Date"
      expr: expected_delivery_date
    - name: "Fulfillment Channel"
      expr: fulfillment_channel
    - name: "Is Emergency"
      expr: is_emergency
    - name: "Is Vmi"
      expr: is_vmi
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Moq Compliant"
      expr: moq_compliant
    - name: "Order Date"
      expr: order_date
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Replenishment Order"
      expr: COUNT(DISTINCT replenishment_order_id)
    - name: "Total Approved Quantity"
      expr: SUM(approved_quantity)
    - name: "Average Approved Quantity"
      expr: AVG(approved_quantity)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Total Order Cost"
      expr: SUM(total_order_cost)
    - name: "Average Total Order Cost"
      expr: AVG(total_order_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation business metrics"
  source: "`retail_ecm`.`inventory`.`reservation`"
  dimensions:
    - name: "Authorizing Department"
      expr: authorizing_department
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Encumbrance Type"
      expr: encumbrance_type
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fulfillment Channel"
      expr: fulfillment_channel
    - name: "Hold Reason Code"
      expr: hold_reason_code
    - name: "Hold Reason Description"
      expr: hold_reason_description
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Priority Level"
      expr: priority_level
    - name: "Release Notes"
      expr: release_notes
    - name: "Release Status"
      expr: release_status
    - name: "Release Timestamp"
      expr: release_timestamp
    - name: "Reservation Number"
      expr: reservation_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation"
      expr: COUNT(DISTINCT reservation_id)
    - name: "Total Case Reference Number"
      expr: SUM(case_reference_number)
    - name: "Average Case Reference Number"
      expr: AVG(case_reference_number)
    - name: "Total Inventory Cost Per Unit"
      expr: SUM(inventory_cost_per_unit)
    - name: "Average Inventory Cost Per Unit"
      expr: AVG(inventory_cost_per_unit)
    - name: "Total Reserved Quantity"
      expr: SUM(reserved_quantity)
    - name: "Average Reserved Quantity"
      expr: AVG(reserved_quantity)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_rfid_tag`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rfid Tag business metrics"
  source: "`retail_ecm`.`inventory`.`rfid_tag`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Decommission Timestamp"
      expr: decommission_timestamp
    - name: "Encoding Date"
      expr: encoding_date
    - name: "Encoding Standard"
      expr: encoding_standard
    - name: "Epc Code"
      expr: epc_code
    - name: "Epc Memory Bank Size"
      expr: epc_memory_bank_size
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frequency Band"
      expr: frequency_band
    - name: "Gtin"
      expr: gtin
    - name: "Is Locked"
      expr: is_locked
    - name: "Is Password Protected"
      expr: is_password_protected
    - name: "Is Private Label"
      expr: is_private_label
    - name: "Is Recalled"
      expr: is_recalled
    - name: "Kill Password Set"
      expr: kill_password_set
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rfid Tag"
      expr: COUNT(DISTINCT rfid_tag_id)
    - name: "Total Signal Strength Dbm"
      expr: SUM(signal_strength_dbm)
    - name: "Average Signal Strength Dbm"
      expr: AVG(signal_strength_dbm)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_stock_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Ledger business metrics"
  source: "`retail_ecm`.`inventory`.`stock_ledger`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dead Stock Flag"
      expr: dead_stock_flag
    - name: "Dsd Flag"
      expr: dsd_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Lot Number"
      expr: lot_number
    - name: "Movement Reason Code"
      expr: movement_reason_code
    - name: "Notes"
      expr: notes
    - name: "Posting Date"
      expr: posting_date
    - name: "Reference Document Number"
      expr: reference_document_number
    - name: "Reference Document Type"
      expr: reference_document_type
    - name: "Reversal Flag"
      expr: reversal_flag
    - name: "Rfid Tracked"
      expr: rfid_tracked
    - name: "Serial Number"
      expr: serial_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Ledger"
      expr: COUNT(DISTINCT stock_ledger_id)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Extended Retail Value"
      expr: SUM(extended_retail_value)
    - name: "Average Extended Retail Value"
      expr: AVG(extended_retail_value)
    - name: "Total Movement Quantity"
      expr: SUM(movement_quantity)
    - name: "Average Movement Quantity"
      expr: AVG(movement_quantity)
    - name: "Total On Hand Quantity After"
      expr: SUM(on_hand_quantity_after)
    - name: "Average On Hand Quantity After"
      expr: AVG(on_hand_quantity_after)
    - name: "Total On Hand Quantity Before"
      expr: SUM(on_hand_quantity_before)
    - name: "Average On Hand Quantity Before"
      expr: AVG(on_hand_quantity_before)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Position business metrics"
  source: "`retail_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Inventory Valuation Method"
      expr: inventory_valuation_method
    - name: "Is Dead Stock"
      expr: is_dead_stock
    - name: "Is Rfid Tracked"
      expr: is_rfid_tracked
    - name: "Is Vmi"
      expr: is_vmi
    - name: "Last Adjustment Date"
      expr: last_adjustment_date
    - name: "Last Cycle Count Date"
      expr: last_cycle_count_date
    - name: "Last Goods Receipt Date"
      expr: last_goods_receipt_date
    - name: "Last Sale Date"
      expr: last_sale_date
    - name: "Position Status"
      expr: position_status
    - name: "Position Timestamp"
      expr: position_timestamp
    - name: "Replenishment Status"
      expr: replenishment_status
    - name: "Source Record Reference"
      expr: source_record_reference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Position"
      expr: COUNT(DISTINCT stock_position_id)
    - name: "Total Available To Promise Qty"
      expr: SUM(available_to_promise_qty)
    - name: "Average Available To Promise Qty"
      expr: AVG(available_to_promise_qty)
    - name: "Total Avg Daily Sales Qty"
      expr: SUM(avg_daily_sales_qty)
    - name: "Average Avg Daily Sales Qty"
      expr: AVG(avg_daily_sales_qty)
    - name: "Total Damaged Qty"
      expr: SUM(damaged_qty)
    - name: "Average Damaged Qty"
      expr: AVG(damaged_qty)
    - name: "Total In Transit Qty"
      expr: SUM(in_transit_qty)
    - name: "Average In Transit Qty"
      expr: AVG(in_transit_qty)
    - name: "Total Max Stock Qty"
      expr: SUM(max_stock_qty)
    - name: "Average Max Stock Qty"
      expr: AVG(max_stock_qty)
    - name: "Total On Hand Qty"
      expr: SUM(on_hand_qty)
    - name: "Average On Hand Qty"
      expr: AVG(on_hand_qty)
    - name: "Total On Order Qty"
      expr: SUM(on_order_qty)
    - name: "Average On Order Qty"
      expr: AVG(on_order_qty)
    - name: "Total Quarantine Qty"
      expr: SUM(quarantine_qty)
    - name: "Average Quarantine Qty"
      expr: AVG(quarantine_qty)
    - name: "Total Reorder Point Qty"
      expr: SUM(reorder_point_qty)
    - name: "Average Reorder Point Qty"
      expr: AVG(reorder_point_qty)
    - name: "Total Reserved Qty"
      expr: SUM(reserved_qty)
    - name: "Average Reserved Qty"
      expr: AVG(reserved_qty)
    - name: "Total Safety Stock Qty"
      expr: SUM(safety_stock_qty)
    - name: "Average Safety Stock Qty"
      expr: AVG(safety_stock_qty)
    - name: "Total Sell Through Rate"
      expr: SUM(sell_through_rate)
    - name: "Average Sell Through Rate"
      expr: AVG(sell_through_rate)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Transfer business metrics"
  source: "`retail_ecm`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "Actual Receipt Date"
      expr: actual_receipt_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Node Type"
      expr: destination_node_type
    - name: "Expected Receipt Date"
      expr: expected_receipt_date
    - name: "Initiated Timestamp"
      expr: initiated_timestamp
    - name: "Is Cross Dock"
      expr: is_cross_dock
    - name: "Is Ship From Store"
      expr: is_ship_from_store
    - name: "Is Vendor Managed"
      expr: is_vendor_managed
    - name: "Notes"
      expr: notes
    - name: "Priority Level"
      expr: priority_level
    - name: "Received Quantity"
      expr: received_quantity
    - name: "Rfid Enabled"
      expr: rfid_enabled
    - name: "Shipment Date"
      expr: shipment_date
    - name: "Source Node Type"
      expr: source_node_type
    - name: "Source System Code"
      expr: source_system_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Transfer"
      expr: COUNT(DISTINCT stock_transfer_id)
    - name: "Total Inventory Cost Per Unit"
      expr: SUM(inventory_cost_per_unit)
    - name: "Average Inventory Cost Per Unit"
      expr: AVG(inventory_cost_per_unit)
    - name: "Total Transfer Cost"
      expr: SUM(transfer_cost)
    - name: "Average Transfer Cost"
      expr: AVG(transfer_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`inventory_vmi_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vmi Agreement business metrics"
  source: "`retail_ecm`.`inventory`.`vmi_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Chargeback Enabled"
      expr: chargeback_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Edi Transaction Set"
      expr: edi_transaction_set
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Inventory Ownership"
      expr: inventory_ownership
    - name: "Inventory Visibility Method"
      expr: inventory_visibility_method
    - name: "Location Type"
      expr: location_type
    - name: "Max Inventory Units"
      expr: max_inventory_units
    - name: "Min Inventory Units"
      expr: min_inventory_units
    - name: "Moq"
      expr: moq
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vmi Agreement"
      expr: COUNT(DISTINCT vmi_agreement_id)
    - name: "Total Chargeback Rate Pct"
      expr: SUM(chargeback_rate_pct)
    - name: "Average Chargeback Rate Pct"
      expr: AVG(chargeback_rate_pct)
    - name: "Total Target Fill Rate Pct"
      expr: SUM(target_fill_rate_pct)
    - name: "Average Target Fill Rate Pct"
      expr: AVG(target_fill_rate_pct)
    - name: "Total Target Otd Rate Pct"
      expr: SUM(target_otd_rate_pct)
    - name: "Average Target Otd Rate Pct"
      expr: AVG(target_otd_rate_pct)
    - name: "Total Target Weeks Of Supply"
      expr: SUM(target_weeks_of_supply)
    - name: "Average Target Weeks Of Supply"
      expr: AVG(target_weeks_of_supply)
$$;