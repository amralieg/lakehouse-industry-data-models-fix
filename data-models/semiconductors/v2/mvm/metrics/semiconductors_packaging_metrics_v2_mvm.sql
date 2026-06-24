-- Metric views for domain: packaging | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly Lot business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_lot`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Assembly Site"
      expr: assembly_site
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Current Process Step"
      expr: current_process_step
    - name: "Die Count"
      expr: die_count
    - name: "Hold Flag"
      expr: hold_flag
    - name: "Hold Reason"
      expr: hold_reason
    - name: "Inspection Fail Count"
      expr: inspection_fail_count
    - name: "Inspection Pass Count"
      expr: inspection_pass_count
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lot Name"
      expr: lot_name
    - name: "Lot Number"
      expr: lot_number
    - name: "Lot Status"
      expr: lot_status
    - name: "Package Version"
      expr: package_version
    - name: "Quality Status"
      expr: quality_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assembly Lot"
      expr: COUNT(DISTINCT assembly_lot_id)
    - name: "Total Cost Estimate Usd"
      expr: SUM(cost_estimate_usd)
    - name: "Average Cost Estimate Usd"
      expr: AVG(cost_estimate_usd)
    - name: "Total Cumulative Yield Percent"
      expr: SUM(cumulative_yield_percent)
    - name: "Average Cumulative Yield Percent"
      expr: AVG(cumulative_yield_percent)
    - name: "Total Defect Density"
      expr: SUM(defect_density)
    - name: "Average Defect Density"
      expr: AVG(defect_density)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly Order business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_order`"
  dimensions:
    - name: "Assembly Order Status"
      expr: assembly_order_status
    - name: "Assembly Site"
      expr: assembly_site
    - name: "Completion Date"
      expr: completion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Defect Count"
      expr: defect_count
    - name: "Hold Flag"
      expr: hold_flag
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Last Status Change Timestamp"
      expr: last_status_change_timestamp
    - name: "Notes"
      expr: notes
    - name: "Order Number"
      expr: order_number
    - name: "Order Placed Timestamp"
      expr: order_placed_timestamp
    - name: "Order Source"
      expr: order_source
    - name: "Priority"
      expr: priority
    - name: "Quantity Ordered"
      expr: quantity_ordered
    - name: "Release Date"
      expr: release_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assembly Order"
      expr: COUNT(DISTINCT assembly_order_id)
    - name: "Total Actual Yield Percent"
      expr: SUM(actual_yield_percent)
    - name: "Average Actual Yield Percent"
      expr: AVG(actual_yield_percent)
    - name: "Total Assembly Osat Vendor Fk"
      expr: SUM(assembly_osat_vendor_fk)
    - name: "Average Assembly Osat Vendor Fk"
      expr: AVG(assembly_osat_vendor_fk)
    - name: "Total Cost Adjustment Amount"
      expr: SUM(cost_adjustment_amount)
    - name: "Average Cost Adjustment Amount"
      expr: AVG(cost_adjustment_amount)
    - name: "Total Cost Gross Amount"
      expr: SUM(cost_gross_amount)
    - name: "Average Cost Gross Amount"
      expr: AVG(cost_gross_amount)
    - name: "Total Cost Net Amount"
      expr: SUM(cost_net_amount)
    - name: "Average Cost Net Amount"
      expr: AVG(cost_net_amount)
    - name: "Total Expected Yield Percent"
      expr: SUM(expected_yield_percent)
    - name: "Average Expected Yield Percent"
      expr: AVG(expected_yield_percent)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly Process Flow business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_process_flow`"
  dimensions:
    - name: "Assembly Process Flow Status"
      expr: assembly_process_flow_status
    - name: "Bond Type"
      expr: bond_type
    - name: "Compliance Standard"
      expr: compliance_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dfm Constraints"
      expr: dfm_constraints
    - name: "Die Attach Method"
      expr: die_attach_method
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Equipment Class"
      expr: equipment_class
    - name: "Final Inspection Type"
      expr: final_inspection_type
    - name: "Flow Name"
      expr: flow_name
    - name: "Flow Status"
      expr: flow_status
    - name: "Is Default Flow"
      expr: is_default_flow
    - name: "Marking Method"
      expr: marking_method
    - name: "Molding Material"
      expr: molding_material
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assembly Process Flow"
      expr: COUNT(DISTINCT assembly_process_flow_id)
    - name: "Total Process Time Target"
      expr: SUM(process_time_target)
    - name: "Average Process Time Target"
      expr: AVG(process_time_target)
    - name: "Total Process Yield Target"
      expr: SUM(process_yield_target)
    - name: "Average Process Yield Target"
      expr: AVG(process_yield_target)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_assembly_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assembly Yield business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`assembly_yield`"
  dimensions:
    - name: "Assembly Yield Status"
      expr: assembly_yield_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "First Pass Yield"
      expr: first_pass_yield
    - name: "Good Unit Count"
      expr: good_unit_count
    - name: "Process Step"
      expr: process_step
    - name: "Recorded Timestamp"
      expr: recorded_timestamp
    - name: "Scrap Reason Code"
      expr: scrap_reason_code
    - name: "Step End Timestamp"
      expr: step_end_timestamp
    - name: "Step Sequence"
      expr: step_sequence
    - name: "Step Start Timestamp"
      expr: step_start_timestamp
    - name: "Units In"
      expr: units_in
    - name: "Units Out"
      expr: units_out
    - name: "Units Scrapped"
      expr: units_scrapped
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Recorded Timestamp Month"
      expr: DATE_TRUNC('MONTH', recorded_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assembly Yield"
      expr: COUNT(DISTINCT assembly_yield_id)
    - name: "Total Cumulative Yield Percent"
      expr: SUM(cumulative_yield_percent)
    - name: "Average Cumulative Yield Percent"
      expr: AVG(cumulative_yield_percent)
    - name: "Total Dppm"
      expr: SUM(dppm)
    - name: "Average Dppm"
      expr: AVG(dppm)
    - name: "Total Fallout Rate"
      expr: SUM(fallout_rate)
    - name: "Average Fallout Rate"
      expr: AVG(fallout_rate)
    - name: "Total Yield Percent"
      expr: SUM(yield_percent)
    - name: "Average Yield Percent"
      expr: AVG(yield_percent)
    - name: "Total Yield Rate"
      expr: SUM(yield_rate)
    - name: "Average Yield Rate"
      expr: AVG(yield_rate)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_material_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Lot business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`material_lot`"
  dimensions:
    - name: "Certificate Of Conformance Ref"
      expr: certificate_of_conformance_ref
    - name: "Compliance Document Ref"
      expr: compliance_document_ref
    - name: "Compliance Itar Status"
      expr: compliance_itar_status
    - name: "Compliance Reach Status"
      expr: compliance_reach_status
    - name: "Compliance Rohs Status"
      expr: compliance_rohs_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Incoming Inspection Status"
      expr: incoming_inspection_status
    - name: "Inspection Failure Reason"
      expr: inspection_failure_reason
    - name: "Inspection Passed"
      expr: inspection_passed
    - name: "Lot Number"
      expr: lot_number
    - name: "Material Description"
      expr: material_description
    - name: "Material Lot Status"
      expr: material_lot_status
    - name: "Material Type"
      expr: material_type
    - name: "Quarantine Flag"
      expr: quarantine_flag
    - name: "Received Date"
      expr: received_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Material Lot"
      expr: COUNT(DISTINCT material_lot_id)
    - name: "Total Cost Per Unit"
      expr: SUM(cost_per_unit)
    - name: "Average Cost Per Unit"
      expr: AVG(cost_per_unit)
    - name: "Total Humidity Storage Percent"
      expr: SUM(humidity_storage_percent)
    - name: "Average Humidity Storage Percent"
      expr: AVG(humidity_storage_percent)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
    - name: "Total Quantity Received"
      expr: SUM(quantity_received)
    - name: "Average Quantity Received"
      expr: AVG(quantity_received)
    - name: "Total Temperature Storage C"
      expr: SUM(temperature_storage_c)
    - name: "Average Temperature Storage C"
      expr: AVG(temperature_storage_c)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_osat_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Osat Vendor business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`osat_vendor`"
  dimensions:
    - name: "Aec Q100 Certified"
      expr: aec_q100_certified
    - name: "Capacity Tier"
      expr: capacity_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Duns Number"
      expr: duns_number
    - name: "Export Control Classification"
      expr: export_control_classification
    - name: "Iatf 16949 Certified"
      expr: iatf_16949_certified
    - name: "Iso 9001 Certified"
      expr: iso_9001_certified
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Nda Ip Protection"
      expr: nda_ip_protection
    - name: "Notes"
      expr: notes
    - name: "Package Capabilities"
      expr: package_capabilities
    - name: "Partnership Status"
      expr: partnership_status
    - name: "Preferred Package Types"
      expr: preferred_package_types
    - name: "Primary Contact Email"
      expr: primary_contact_email
    - name: "Primary Contact Name"
      expr: primary_contact_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Osat Vendor"
      expr: COUNT(DISTINCT osat_vendor_id)
    - name: "Total Audit Score"
      expr: SUM(audit_score)
    - name: "Average Audit Score"
      expr: AVG(audit_score)
    - name: "Total Dppm Rate"
      expr: SUM(dppm_rate)
    - name: "Average Dppm Rate"
      expr: AVG(dppm_rate)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Qualification business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`package_qualification`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Defect Rate Ppm"
      expr: defect_rate_ppm
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "External Audit Date"
      expr: external_audit_date
    - name: "External Audit Required"
      expr: external_audit_required
    - name: "Notes"
      expr: notes
    - name: "Pass Fail Criteria"
      expr: pass_fail_criteria
    - name: "Qualification Document Number"
      expr: qualification_document_number
    - name: "Qualification Method"
      expr: qualification_method
    - name: "Qualification Owner"
      expr: qualification_owner
    - name: "Qualification Result"
      expr: qualification_result
    - name: "Qualification Standard"
      expr: qualification_standard
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Qualification"
      expr: COUNT(DISTINCT package_qualification_id)
    - name: "Total Qualification Cost Usd"
      expr: SUM(qualification_cost_usd)
    - name: "Average Qualification Cost Usd"
      expr: AVG(qualification_cost_usd)
    - name: "Total Test Duration Hours"
      expr: SUM(test_duration_hours)
    - name: "Average Test Duration Hours"
      expr: AVG(test_duration_hours)
    - name: "Total Test Temperature C"
      expr: SUM(test_temperature_c)
    - name: "Average Test Temperature C"
      expr: AVG(test_temperature_c)
    - name: "Total Yield Percentage"
      expr: SUM(yield_percentage)
    - name: "Average Yield Percentage"
      expr: AVG(yield_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`packaging_package_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Type business metrics"
  source: "`vibe_semiconductors_v1`.`packaging`.`package_type`"
  dimensions:
    - name: "Ball Count Max"
      expr: ball_count_max
    - name: "Ball Count Min"
      expr: ball_count_min
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is 3d Ic"
      expr: is_3d_ic
    - name: "Is Advanced Package"
      expr: is_advanced_package
    - name: "Is Ball Grid Array"
      expr: is_ball_grid_array
    - name: "Is Flip Chip"
      expr: is_flip_chip
    - name: "Is Heterogeneous Integration"
      expr: is_heterogeneous_integration
    - name: "Is Itar Controlled"
      expr: is_itar_controlled
    - name: "Is Leadframe"
      expr: is_leadframe
    - name: "Is Osat Supported"
      expr: is_osat_supported
    - name: "Is Reach Compliant"
      expr: is_reach_compliant
    - name: "Is Rohs Compliant"
      expr: is_rohs_compliant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Type"
      expr: COUNT(DISTINCT package_type_id)
    - name: "Total Max Current A"
      expr: SUM(max_current_a)
    - name: "Average Max Current A"
      expr: AVG(max_current_a)
    - name: "Total Max Die Pitch Um"
      expr: SUM(max_die_pitch_um)
    - name: "Average Max Die Pitch Um"
      expr: AVG(max_die_pitch_um)
    - name: "Total Max Operating Temperature C"
      expr: SUM(max_operating_temperature_c)
    - name: "Average Max Operating Temperature C"
      expr: AVG(max_operating_temperature_c)
    - name: "Total Max Power Dissipation W"
      expr: SUM(max_power_dissipation_w)
    - name: "Average Max Power Dissipation W"
      expr: AVG(max_power_dissipation_w)
    - name: "Total Max Voltage V"
      expr: SUM(max_voltage_v)
    - name: "Average Max Voltage V"
      expr: AVG(max_voltage_v)
    - name: "Total Min Die Pitch Um"
      expr: SUM(min_die_pitch_um)
    - name: "Average Min Die Pitch Um"
      expr: AVG(min_die_pitch_um)
    - name: "Total Min Operating Temperature C"
      expr: SUM(min_operating_temperature_c)
    - name: "Average Min Operating Temperature C"
      expr: AVG(min_operating_temperature_c)
    - name: "Total Package Dimensions Height Um"
      expr: SUM(package_dimensions_height_um)
    - name: "Average Package Dimensions Height Um"
      expr: AVG(package_dimensions_height_um)
    - name: "Total Package Dimensions Length Um"
      expr: SUM(package_dimensions_length_um)
    - name: "Average Package Dimensions Length Um"
      expr: AVG(package_dimensions_length_um)
    - name: "Total Package Dimensions Width Um"
      expr: SUM(package_dimensions_width_um)
    - name: "Average Package Dimensions Width Um"
      expr: AVG(package_dimensions_width_um)
    - name: "Total Thermal Resistance C Per W"
      expr: SUM(thermal_resistance_c_per_w)
    - name: "Average Thermal Resistance C Per W"
      expr: AVG(thermal_resistance_c_per_w)
    - name: "Total Typical Thickness Um"
      expr: SUM(typical_thickness_um)
    - name: "Average Typical Thickness Um"
      expr: AVG(typical_thickness_um)
$$;