-- Metric views for domain: inventory | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:22:17

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment business metrics"
  source: "`food_beverage_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "Accounting Document Number"
      expr: accounting_document_number
    - name: "Adjustment Number"
      expr: adjustment_number
    - name: "Adjustment Status"
      expr: adjustment_status
    - name: "Adjustment Timestamp"
      expr: adjustment_timestamp
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Account"
      expr: credit_account
    - name: "Currency Code"
      expr: currency_code
    - name: "Debit Account"
      expr: debit_account
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Inventory Valuation Method"
      expr: inventory_valuation_method
    - name: "Is Manual Adjustment"
      expr: is_manual_adjustment
    - name: "Is Quality Hold"
      expr: is_quality_hold
    - name: "Notes"
      expr: notes
    - name: "Posting Date"
      expr: posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adjustment"
      expr: COUNT(DISTINCT adjustment_id)
    - name: "Total Adjusted Quantity"
      expr: SUM(adjusted_quantity)
    - name: "Average Adjusted Quantity"
      expr: AVG(adjusted_quantity)
    - name: "Total Adjusted Value Amount"
      expr: SUM(adjusted_value_amount)
    - name: "Average Adjusted Value Amount"
      expr: AVG(adjusted_value_amount)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle Count business metrics"
  source: "`food_beverage_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "Actual Count Date"
      expr: actual_count_date
    - name: "Audit Completion Date"
      expr: audit_completion_date
    - name: "Audit Required Flag"
      expr: audit_required_flag
    - name: "Comments"
      expr: comments
    - name: "Count Completion Timestamp"
      expr: count_completion_timestamp
    - name: "Count Duration Minutes"
      expr: count_duration_minutes
    - name: "Count Method"
      expr: count_method
    - name: "Count Plan Reference"
      expr: count_plan_reference
    - name: "Count Start Timestamp"
      expr: count_start_timestamp
    - name: "Count Type"
      expr: count_type
    - name: "Counter Assigned"
      expr: counter_assigned
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cycle Count Status"
      expr: cycle_count_status
    - name: "Freeze End Timestamp"
      expr: freeze_end_timestamp
    - name: "Freeze Start Timestamp"
      expr: freeze_start_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cycle Count"
      expr: COUNT(DISTINCT cycle_count_id)
    - name: "Total Accuracy Percentage"
      expr: SUM(accuracy_percentage)
    - name: "Average Accuracy Percentage"
      expr: AVG(accuracy_percentage)
    - name: "Total Total Variance Value"
      expr: SUM(total_variance_value)
    - name: "Average Total Variance Value"
      expr: AVG(total_variance_value)
    - name: "Total Variance Threshold Percentage"
      expr: SUM(variance_threshold_percentage)
    - name: "Average Variance Threshold Percentage"
      expr: AVG(variance_threshold_percentage)
    - name: "Total Variance Threshold Quantity"
      expr: SUM(variance_threshold_quantity)
    - name: "Average Variance Threshold Quantity"
      expr: AVG(variance_threshold_quantity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_cycle_count_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle Count Item business metrics"
  source: "`food_beverage_ecm`.`inventory`.`cycle_count_item`"
  dimensions:
    - name: "Adjustment Document Number"
      expr: adjustment_document_number
    - name: "Adjustment Posted Flag"
      expr: adjustment_posted_flag
    - name: "Count Status"
      expr: count_status
    - name: "Count Timestamp"
      expr: count_timestamp
    - name: "Counter Employee Code"
      expr: counter_employee_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cycle Count Date"
      expr: cycle_count_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Line Item Notes"
      expr: line_item_notes
    - name: "Recount Flag"
      expr: recount_flag
    - name: "Recount Timestamp"
      expr: recount_timestamp
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Variance Reason Code"
      expr: variance_reason_code
    - name: "Count Timestamp Month"
      expr: DATE_TRUNC('MONTH', count_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cycle Count Item"
      expr: COUNT(DISTINCT cycle_count_item_id)
    - name: "Total Counted Quantity"
      expr: SUM(counted_quantity)
    - name: "Average Counted Quantity"
      expr: AVG(counted_quantity)
    - name: "Total Cycle Count Variance"
      expr: SUM(cycle_count_variance)
    - name: "Average Cycle Count Variance"
      expr: AVG(cycle_count_variance)
    - name: "Total System Quantity"
      expr: SUM(system_quantity)
    - name: "Average System Quantity"
      expr: AVG(system_quantity)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_goods_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods Movement business metrics"
  source: "`food_beverage_ecm`.`inventory`.`goods_movement`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Cost Center"
      expr: cost_center
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Code"
      expr: customer_code
    - name: "Destination Plant Code"
      expr: destination_plant_code
    - name: "Destination Storage Location"
      expr: destination_storage_location
    - name: "Document Date"
      expr: document_date
    - name: "Entry Timestamp"
      expr: entry_timestamp
    - name: "Gl Account"
      expr: gl_account
    - name: "Material Description"
      expr: material_description
    - name: "Material Document Item"
      expr: material_document_item
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Material Document Year"
      expr: material_document_year
    - name: "Movement Indicator"
      expr: movement_indicator
    - name: "Movement Type"
      expr: movement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Goods Movement"
      expr: COUNT(DISTINCT goods_movement_id)
    - name: "Total Amount Lc"
      expr: SUM(amount_lc)
    - name: "Average Amount Lc"
      expr: AVG(amount_lc)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_lot_trace`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot Trace business metrics"
  source: "`food_beverage_ecm`.`inventory`.`lot_trace`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Downstream Lot Refs"
      expr: downstream_lot_refs
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fsma One Up One Down Flag"
      expr: fsma_one_up_one_down_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lot Creation Timestamp"
      expr: lot_creation_timestamp
    - name: "Lot Owner"
      expr: lot_owner
    - name: "Lot Status"
      expr: lot_status
    - name: "Lot Type"
      expr: lot_type
    - name: "Plant Code"
      expr: plant_code
    - name: "Product Name"
      expr: product_name
    - name: "Production Date"
      expr: production_date
    - name: "Quality Status"
      expr: quality_status
    - name: "Recall Flag"
      expr: recall_flag
    - name: "Receipt Date"
      expr: receipt_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot Trace"
      expr: COUNT(DISTINCT lot_trace_id)
    - name: "Total Lot Cost Amount"
      expr: SUM(lot_cost_amount)
    - name: "Average Lot Cost Amount"
      expr: AVG(lot_cost_amount)
    - name: "Total Max Temperature C"
      expr: SUM(max_temperature_c)
    - name: "Average Max Temperature C"
      expr: AVG(max_temperature_c)
    - name: "Total Min Temperature C"
      expr: SUM(min_temperature_c)
    - name: "Average Min Temperature C"
      expr: AVG(min_temperature_c)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Transformation Event Code"
      expr: SUM(transformation_event_code)
    - name: "Average Transformation Event Code"
      expr: AVG(transformation_event_code)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_quarantine_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quarantine Hold business metrics"
  source: "`food_beverage_ecm`.`inventory`.`quarantine_hold`"
  dimensions:
    - name: "Allergen Flag"
      expr: allergen_flag
    - name: "Comments"
      expr: comments
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposition Decision"
      expr: disposition_decision
    - name: "Expected Review Timestamp"
      expr: expected_review_timestamp
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Hold Initiation Timestamp"
      expr: hold_initiation_timestamp
    - name: "Hold Number"
      expr: hold_number
    - name: "Hold Reason"
      expr: hold_reason
    - name: "Hold Release Timestamp"
      expr: hold_release_timestamp
    - name: "Hold Source System"
      expr: hold_source_system
    - name: "Hold Status"
      expr: hold_status
    - name: "Hold Type"
      expr: hold_type
    - name: "Is Critical Item"
      expr: is_critical_item
    - name: "Material Number"
      expr: material_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quarantine Hold"
      expr: COUNT(DISTINCT quarantine_hold_id)
    - name: "Total Quantity Held"
      expr: SUM(quantity_held)
    - name: "Average Quantity Held"
      expr: AVG(quantity_held)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reservation business metrics"
  source: "`food_beverage_ecm`.`inventory`.`reservation`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cancelled Reason"
      expr: cancelled_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Freeze End Timestamp"
      expr: freeze_end_timestamp
    - name: "Freeze Start Timestamp"
      expr: freeze_start_timestamp
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Is Frozen"
      expr: is_frozen
    - name: "Is Quality Hold"
      expr: is_quality_hold
    - name: "Is Temperature Controlled"
      expr: is_temperature_controlled
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Plant Code"
      expr: plant_code
    - name: "Priority"
      expr: priority
    - name: "Quality Hold Reason"
      expr: quality_hold_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reservation"
      expr: COUNT(DISTINCT reservation_id)
    - name: "Total Max Temperature C"
      expr: SUM(max_temperature_c)
    - name: "Average Max Temperature C"
      expr: AVG(max_temperature_c)
    - name: "Total Min Temperature C"
      expr: SUM(min_temperature_c)
    - name: "Average Min Temperature C"
      expr: AVG(min_temperature_c)
    - name: "Total Requesting Party Code"
      expr: SUM(requesting_party_code)
    - name: "Average Requesting Party Code"
      expr: AVG(requesting_party_code)
    - name: "Total Reserved Quantity"
      expr: SUM(reserved_quantity)
    - name: "Average Reserved Quantity"
      expr: AVG(reserved_quantity)
    - name: "Total Reserved Value Amount"
      expr: SUM(reserved_value_amount)
    - name: "Average Reserved Value Amount"
      expr: AVG(reserved_value_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Position business metrics"
  source: "`food_beverage_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "Abc Classification"
      expr: abc_classification
    - name: "Allergen Segregation Flag"
      expr: allergen_segregation_flag
    - name: "Best Before Date"
      expr: best_before_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expiry Status"
      expr: expiry_status
    - name: "Gtin"
      expr: gtin
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Last Movement Date"
      expr: last_movement_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lot Traceability Code"
      expr: lot_traceability_code
    - name: "Organic Certified Flag"
      expr: organic_certified_flag
    - name: "Production Date"
      expr: production_date
    - name: "Quarantine Flag"
      expr: quarantine_flag
    - name: "Recall Flag"
      expr: recall_flag
    - name: "Receipt Date"
      expr: receipt_date
    - name: "Remaining Shelf Life Days"
      expr: remaining_shelf_life_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Position"
      expr: COUNT(DISTINCT stock_position_id)
    - name: "Total Quantity Available"
      expr: SUM(quantity_available)
    - name: "Average Quantity Available"
      expr: AVG(quantity_available)
    - name: "Total Quantity Blocked"
      expr: SUM(quantity_blocked)
    - name: "Average Quantity Blocked"
      expr: AVG(quantity_blocked)
    - name: "Total Quantity In Transit"
      expr: SUM(quantity_in_transit)
    - name: "Average Quantity In Transit"
      expr: AVG(quantity_in_transit)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
    - name: "Total Quantity Quality Inspection"
      expr: SUM(quantity_quality_inspection)
    - name: "Average Quantity Quality Inspection"
      expr: AVG(quantity_quality_inspection)
    - name: "Total Quantity Reserved"
      expr: SUM(quantity_reserved)
    - name: "Average Quantity Reserved"
      expr: AVG(quantity_reserved)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Valuation Amount"
      expr: SUM(valuation_amount)
    - name: "Average Valuation Amount"
      expr: AVG(valuation_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_stock_transfer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock Transfer Order business metrics"
  source: "`food_beverage_ecm`.`inventory`.`stock_transfer_order`"
  dimensions:
    - name: "Actual Receipt Date"
      expr: actual_receipt_date
    - name: "Actual Shipment Date"
      expr: actual_shipment_date
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cancelled Reason"
      expr: cancelled_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Planned Transfer Date"
      expr: planned_transfer_date
    - name: "Priority"
      expr: priority
    - name: "Shelf Life Remaining Days"
      expr: shelf_life_remaining_days
    - name: "Shipment Number"
      expr: shipment_number
    - name: "Special Handling Code"
      expr: special_handling_code
    - name: "Stock Type"
      expr: stock_type
    - name: "Temperature Compliance Flag"
      expr: temperature_compliance_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stock Transfer Order"
      expr: COUNT(DISTINCT stock_transfer_order_id)
    - name: "Total Confirmed Quantity"
      expr: SUM(confirmed_quantity)
    - name: "Average Confirmed Quantity"
      expr: AVG(confirmed_quantity)
    - name: "Total Maximum Temperature C"
      expr: SUM(maximum_temperature_c)
    - name: "Average Maximum Temperature C"
      expr: AVG(maximum_temperature_c)
    - name: "Total Minimum Temperature C"
      expr: SUM(minimum_temperature_c)
    - name: "Average Minimum Temperature C"
      expr: AVG(minimum_temperature_c)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Requested Quantity"
      expr: SUM(requested_quantity)
    - name: "Average Requested Quantity"
      expr: AVG(requested_quantity)
    - name: "Total Transfer Cost Amount"
      expr: SUM(transfer_cost_amount)
    - name: "Average Transfer Cost Amount"
      expr: AVG(transfer_cost_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Location business metrics"
  source: "`food_beverage_ecm`.`inventory`.`storage_location`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Allergen Segregation Class"
      expr: allergen_segregation_class
    - name: "Capacity Pallet Positions"
      expr: capacity_pallet_positions
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Erp Storage Location"
      expr: erp_storage_location
    - name: "Fefo Enforcement Flag"
      expr: fefo_enforcement_flag
    - name: "Fifo Enforcement Flag"
      expr: fifo_enforcement_flag
    - name: "Gmp Compliant Flag"
      expr: gmp_compliant_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Hazmat Certified Flag"
      expr: hazmat_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Storage Location"
      expr: COUNT(DISTINCT storage_location_id)
    - name: "Total Capacity Volume M3"
      expr: SUM(capacity_volume_m3)
    - name: "Average Capacity Volume M3"
      expr: AVG(capacity_volume_m3)
    - name: "Total Capacity Weight Kg"
      expr: SUM(capacity_weight_kg)
    - name: "Average Capacity Weight Kg"
      expr: AVG(capacity_weight_kg)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Temperature Max"
      expr: SUM(temperature_max)
    - name: "Average Temperature Max"
      expr: AVG(temperature_max)
    - name: "Total Temperature Min"
      expr: SUM(temperature_min)
    - name: "Average Temperature Min"
      expr: AVG(temperature_min)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`inventory_valuation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Valuation business metrics"
  source: "`food_beverage_ecm`.`inventory`.`valuation`"
  dimensions:
    - name: "Class Code"
      expr: class_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Lot Number"
      expr: lot_number
    - name: "Material Description"
      expr: material_description
    - name: "Material Number"
      expr: material_number
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Shelf Life Remaining Days"
      expr: shelf_life_remaining_days
    - name: "Source System"
      expr: source_system
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Valuation Method"
      expr: valuation_method
    - name: "Valuation Number"
      expr: valuation_number
    - name: "Valuation Status"
      expr: valuation_status
    - name: "Valuation Timestamp"
      expr: valuation_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Valuation"
      expr: COUNT(DISTINCT valuation_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Gross Valuation Amount"
      expr: SUM(gross_valuation_amount)
    - name: "Average Gross Valuation Amount"
      expr: AVG(gross_valuation_amount)
    - name: "Total Net Valuation Amount"
      expr: SUM(net_valuation_amount)
    - name: "Average Net Valuation Amount"
      expr: AVG(net_valuation_amount)
    - name: "Total Price Variance Amount"
      expr: SUM(price_variance_amount)
    - name: "Average Price Variance Amount"
      expr: AVG(price_variance_amount)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
    - name: "Total Revaluation Amount"
      expr: SUM(revaluation_amount)
    - name: "Average Revaluation Amount"
      expr: AVG(revaluation_amount)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;