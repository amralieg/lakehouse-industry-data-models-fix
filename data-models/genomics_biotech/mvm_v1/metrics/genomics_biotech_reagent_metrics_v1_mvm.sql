-- Metric views for domain: reagent | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:32:53

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`catalog`"
  dimensions:
    - name: "Catalog Number"
      expr: catalog_number
    - name: "Coa Required Flag"
      expr: coa_required_flag
    - name: "Concentration"
      expr: concentration
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Freeze Thaw Cycle Limit"
      expr: freeze_thaw_cycle_limit
    - name: "Gmp Compliant Flag"
      expr: gmp_compliant_flag
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Intended Application"
      expr: intended_application
    - name: "Introduction Date"
      expr: introduction_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Light Sensitivity Flag"
      expr: light_sensitivity_flag
    - name: "Purity Specification"
      expr: purity_specification
    - name: "Quality Control Tested Flag"
      expr: quality_control_tested_flag
    - name: "Reagent Category"
      expr: reagent_category
    - name: "Reagent Type"
      expr: reagent_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog"
      expr: COUNT(DISTINCT catalog_id)
    - name: "Total Package Size"
      expr: SUM(package_size)
    - name: "Average Package Size"
      expr: AVG(package_size)
    - name: "Total Storage Humidity Max Percent"
      expr: SUM(storage_humidity_max_percent)
    - name: "Average Storage Humidity Max Percent"
      expr: AVG(storage_humidity_max_percent)
    - name: "Total Storage Humidity Min Percent"
      expr: SUM(storage_humidity_min_percent)
    - name: "Average Storage Humidity Min Percent"
      expr: AVG(storage_humidity_min_percent)
    - name: "Total Storage Temperature Max Celsius"
      expr: SUM(storage_temperature_max_celsius)
    - name: "Average Storage Temperature Max Celsius"
      expr: AVG(storage_temperature_max_celsius)
    - name: "Total Storage Temperature Min Celsius"
      expr: SUM(storage_temperature_min_celsius)
    - name: "Average Storage Temperature Min Celsius"
      expr: AVG(storage_temperature_min_celsius)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_coa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coa business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`coa`"
  dimensions:
    - name: "Acceptance Criteria Summary"
      expr: acceptance_criteria_summary
    - name: "Analytical Method References"
      expr: analytical_method_references
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Coa Status"
      expr: coa_status
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Facing Flag"
      expr: customer_facing_flag
    - name: "Deviation Description"
      expr: deviation_description
    - name: "Deviations Noted"
      expr: deviations_noted
    - name: "Document Number"
      expr: document_number
    - name: "Document Url"
      expr: document_url
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gmp Release Authorized"
      expr: gmp_release_authorized
    - name: "Intended Use"
      expr: intended_use
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Laboratory"
      expr: issuing_laboratory
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coa"
      expr: COUNT(DISTINCT coa_id)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_dispensing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispensing Event business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`dispensing_event`"
  dimensions:
    - name: "Chain Of Custody Confirmed Flag"
      expr: chain_of_custody_confirmed_flag
    - name: "Cold Chain Compliant Flag"
      expr: cold_chain_compliant_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Custody Confirmed Timestamp"
      expr: custody_confirmed_timestamp
    - name: "Destination Type"
      expr: destination_type
    - name: "Dispensing Notes"
      expr: dispensing_notes
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Movement Type"
      expr: movement_type
    - name: "Movement Type Code"
      expr: movement_type_code
    - name: "Qc Status"
      expr: qc_status
    - name: "Regulatory Status"
      expr: regulatory_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispensing Event"
      expr: COUNT(DISTINCT dispensing_event_id)
    - name: "Total Quantity Dispensed"
      expr: SUM(quantity_dispensed)
    - name: "Average Quantity Dispensed"
      expr: AVG(quantity_dispensed)
    - name: "Total Remaining Lot Quantity"
      expr: SUM(remaining_lot_quantity)
    - name: "Average Remaining Lot Quantity"
      expr: AVG(remaining_lot_quantity)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_inventory_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Balance business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`inventory_balance`"
  dimensions:
    - name: "Batch Status"
      expr: batch_status
    - name: "Consignment Flag"
      expr: consignment_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days To Expiry"
      expr: days_to_expiry
    - name: "Expiry Alert Flag"
      expr: expiry_alert_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fefo Priority Rank"
      expr: fefo_priority_rank
    - name: "Gmp Release Status"
      expr: gmp_release_status
    - name: "Last Adjustment Reason"
      expr: last_adjustment_reason
    - name: "Last Movement Date"
      expr: last_movement_date
    - name: "Last Physical Count Date"
      expr: last_physical_count_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Low Stock Alert Flag"
      expr: low_stock_alert_flag
    - name: "Manufacture Date"
      expr: manufacture_date
    - name: "Notes"
      expr: notes
    - name: "Receipt Date"
      expr: receipt_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Balance"
      expr: COUNT(DISTINCT inventory_balance_id)
    - name: "Total Available Quantity"
      expr: SUM(available_quantity)
    - name: "Average Available Quantity"
      expr: AVG(available_quantity)
    - name: "Total Maximum Stock Level"
      expr: SUM(maximum_stock_level)
    - name: "Average Maximum Stock Level"
      expr: AVG(maximum_stock_level)
    - name: "Total Minimum Stock Level"
      expr: SUM(minimum_stock_level)
    - name: "Average Minimum Stock Level"
      expr: AVG(minimum_stock_level)
    - name: "Total On Hand Quantity"
      expr: SUM(on_hand_quantity)
    - name: "Average On Hand Quantity"
      expr: AVG(on_hand_quantity)
    - name: "Total Quarantine Quantity"
      expr: SUM(quarantine_quantity)
    - name: "Average Quarantine Quantity"
      expr: AVG(quarantine_quantity)
    - name: "Total Reorder Point"
      expr: SUM(reorder_point)
    - name: "Average Reorder Point"
      expr: AVG(reorder_point)
    - name: "Total Reserved Quantity"
      expr: SUM(reserved_quantity)
    - name: "Average Reserved Quantity"
      expr: AVG(reserved_quantity)
    - name: "Total Total Valuation Amount"
      expr: SUM(total_valuation_amount)
    - name: "Average Total Valuation Amount"
      expr: AVG(total_valuation_amount)
    - name: "Total Valuation Price"
      expr: SUM(valuation_price)
    - name: "Average Valuation Price"
      expr: AVG(valuation_price)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_inventory_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Transaction business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`inventory_transaction`"
  dimensions:
    - name: "Cold Chain Compliant Flag"
      expr: cold_chain_compliant_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Date"
      expr: document_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gmp Release Status"
      expr: gmp_release_status
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Movement Reason Code"
      expr: movement_reason_code
    - name: "Posting Date"
      expr: posting_date
    - name: "Reference Document Line Item"
      expr: reference_document_line_item
    - name: "Reference Document Number"
      expr: reference_document_number
    - name: "Reference Document Type"
      expr: reference_document_type
    - name: "Reversal Flag"
      expr: reversal_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Transaction"
      expr: COUNT(DISTINCT inventory_transaction_id)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Temperature Max C"
      expr: SUM(temperature_max_c)
    - name: "Average Temperature Max C"
      expr: AVG(temperature_max_c)
    - name: "Total Temperature Min C"
      expr: SUM(temperature_min_c)
    - name: "Average Temperature Min C"
      expr: AVG(temperature_min_c)
    - name: "Total Total Transaction Value"
      expr: SUM(total_transaction_value)
    - name: "Average Total Transaction Value"
      expr: AVG(total_transaction_value)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_kit_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Kit Component business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`kit_component`"
  dimensions:
    - name: "Assembly Instruction"
      expr: assembly_instruction
    - name: "Component Role"
      expr: component_role
    - name: "Component Sequence"
      expr: component_sequence
    - name: "Component Stability Duration Days"
      expr: component_stability_duration_days
    - name: "Component Storage Requirement"
      expr: component_storage_requirement
    - name: "Component Unit Of Measure"
      expr: component_unit_of_measure
    - name: "Component Version"
      expr: component_version
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Is Active"
      expr: is_active
    - name: "Is Critical Component"
      expr: is_critical_component
    - name: "Is Substitutable"
      expr: is_substitutable
    - name: "Lot Traceability Required"
      expr: lot_traceability_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Kit Component"
      expr: COUNT(DISTINCT kit_component_id)
    - name: "Total Component Cost Usd"
      expr: SUM(component_cost_usd)
    - name: "Average Component Cost Usd"
      expr: AVG(component_cost_usd)
    - name: "Total Component Quantity"
      expr: SUM(component_quantity)
    - name: "Average Component Quantity"
      expr: AVG(component_quantity)
    - name: "Total Maximum Quantity"
      expr: SUM(maximum_quantity)
    - name: "Average Maximum Quantity"
      expr: AVG(maximum_quantity)
    - name: "Total Minimum Quantity"
      expr: SUM(minimum_quantity)
    - name: "Average Minimum Quantity"
      expr: AVG(minimum_quantity)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`lot`"
  dimensions:
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposition"
      expr: disposition
    - name: "Disposition Date"
      expr: disposition_date
    - name: "Disposition Reason"
      expr: disposition_reason
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gmp Release Status"
      expr: gmp_release_status
    - name: "Hazard Classification"
      expr: hazard_classification
    - name: "Internal Coa Reference"
      expr: internal_coa_reference
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lot Number"
      expr: lot_number
    - name: "Lot Type"
      expr: lot_type
    - name: "Manufacturing Date"
      expr: manufacturing_date
    - name: "Notes"
      expr: notes
    - name: "Qc Approval Timestamp"
      expr: qc_approval_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot"
      expr: COUNT(DISTINCT lot_id)
    - name: "Total Quantity Available"
      expr: SUM(quantity_available)
    - name: "Average Quantity Available"
      expr: AVG(quantity_available)
    - name: "Total Quantity Manufactured"
      expr: SUM(quantity_manufactured)
    - name: "Average Quantity Manufactured"
      expr: AVG(quantity_manufactured)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_qc_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qc Specification business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`qc_specification`"
  dimensions:
    - name: "Acceptance Criteria Type"
      expr: acceptance_criteria_type
    - name: "Analytical Parameter"
      expr: analytical_parameter
    - name: "Applicable Product Grade"
      expr: applicable_product_grade
    - name: "Approval Date"
      expr: approval_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Level"
      expr: criticality_level
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Coa Reportable"
      expr: is_coa_reportable
    - name: "Is Stability Indicating"
      expr: is_stability_indicating
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Out Of Specification Escalation Procedure"
      expr: out_of_specification_escalation_procedure
    - name: "Pass Fail Criteria Description"
      expr: pass_fail_criteria_description
    - name: "Sample Size Requirement"
      expr: sample_size_requirement
    - name: "Specification Code"
      expr: specification_code
    - name: "Specification Rationale"
      expr: specification_rationale
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Qc Specification"
      expr: COUNT(DISTINCT qc_specification_id)
    - name: "Total Lower Specification Limit"
      expr: SUM(lower_specification_limit)
    - name: "Average Lower Specification Limit"
      expr: AVG(lower_specification_limit)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Upper Specification Limit"
      expr: SUM(upper_specification_limit)
    - name: "Average Upper Specification Limit"
      expr: AVG(upper_specification_limit)
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`reagent_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Location business metrics"
  source: "`genomics_biotech_ecm`.`reagent`.`storage_location`"
  dimensions:
    - name: "Access Control Level"
      expr: access_control_level
    - name: "Barcode"
      expr: barcode
    - name: "Building Code"
      expr: building_code
    - name: "Capacity Occupied Units"
      expr: capacity_occupied_units
    - name: "Capacity Total Units"
      expr: capacity_total_units
    - name: "Capacity Unit Of Measure"
      expr: capacity_unit_of_measure
    - name: "Cold Chain Compliant Flag"
      expr: cold_chain_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Deactivation Reason"
      expr: deactivation_reason
    - name: "Environmental Monitor Device Code"
      expr: environmental_monitor_device_code
    - name: "Fefo Enforcement Flag"
      expr: fefo_enforcement_flag
    - name: "Fifo Enforcement Flag"
      expr: fifo_enforcement_flag
    - name: "Gmp Qualification Status"
      expr: gmp_qualification_status
    - name: "Hazardous Material Approved Flag"
      expr: hazardous_material_approved_flag
    - name: "Location Code"
      expr: location_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Storage Location"
      expr: COUNT(DISTINCT storage_location_id)
    - name: "Total Target Humidity Max Pct"
      expr: SUM(target_humidity_max_pct)
    - name: "Average Target Humidity Max Pct"
      expr: AVG(target_humidity_max_pct)
    - name: "Total Target Humidity Min Pct"
      expr: SUM(target_humidity_min_pct)
    - name: "Average Target Humidity Min Pct"
      expr: AVG(target_humidity_min_pct)
    - name: "Total Target Temperature Max C"
      expr: SUM(target_temperature_max_c)
    - name: "Average Target Temperature Max C"
      expr: AVG(target_temperature_max_c)
    - name: "Total Target Temperature Min C"
      expr: SUM(target_temperature_min_c)
    - name: "Average Target Temperature Min C"
      expr: AVG(target_temperature_min_c)
$$;