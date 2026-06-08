-- Metric views for domain: manufacturing | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:14:33

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch Record business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "Allergen Statement"
      expr: allergen_statement
    - name: "Batch Notes"
      expr: batch_notes
    - name: "Batch Number"
      expr: batch_number
    - name: "Batch Status"
      expr: batch_status
    - name: "Best Before Date"
      expr: best_before_date
    - name: "Co Packer Flag"
      expr: co_packer_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deviation Count"
      expr: deviation_count
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gluten Free Claim Flag"
      expr: gluten_free_claim_flag
    - name: "Gmp Compliance Flag"
      expr: gmp_compliance_flag
    - name: "Haccp Signoff Status"
      expr: haccp_signoff_status
    - name: "Halal Certification Flag"
      expr: halal_certification_flag
    - name: "Kosher Certification Flag"
      expr: kosher_certification_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manufacturing Date"
      expr: manufacturing_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Batch Record"
      expr: COUNT(DISTINCT batch_record_id)
    - name: "Total Actual Yield Quantity"
      expr: SUM(actual_yield_quantity)
    - name: "Average Actual Yield Quantity"
      expr: AVG(actual_yield_quantity)
    - name: "Total Batch Size Quantity"
      expr: SUM(batch_size_quantity)
    - name: "Average Batch Size Quantity"
      expr: AVG(batch_size_quantity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_equipment_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment Master business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`equipment_master`"
  dimensions:
    - name: "Acquisition Currency Code"
      expr: acquisition_currency_code
    - name: "Allergen Handling Capability"
      expr: allergen_handling_capability
    - name: "Asset Owner Department"
      expr: asset_owner_department
    - name: "Calibration Certificate Number"
      expr: calibration_certificate_number
    - name: "Calibration Frequency Days"
      expr: calibration_frequency_days
    - name: "Capacity Unit Of Measure"
      expr: capacity_unit_of_measure
    - name: "Cip Capable Flag"
      expr: cip_capable_flag
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Level"
      expr: criticality_level
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Equipment Category"
      expr: equipment_category
    - name: "Equipment Name"
      expr: equipment_name
    - name: "Equipment Tag Number"
      expr: equipment_tag_number
    - name: "Equipment Type"
      expr: equipment_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Equipment Master"
      expr: COUNT(DISTINCT equipment_master_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Energy Consumption Rating Kwh"
      expr: SUM(energy_consumption_rating_kwh)
    - name: "Average Energy Consumption Rating Kwh"
      expr: AVG(energy_consumption_rating_kwh)
    - name: "Total Oee Baseline Target Percent"
      expr: SUM(oee_baseline_target_percent)
    - name: "Average Oee Baseline Target Percent"
      expr: AVG(oee_baseline_target_percent)
    - name: "Total Rated Capacity"
      expr: SUM(rated_capacity)
    - name: "Average Rated Capacity"
      expr: AVG(rated_capacity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_haccp_ccp_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haccp Ccp Log business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`haccp_ccp_log`"
  dimensions:
    - name: "Ccp Identifier"
      expr: ccp_identifier
    - name: "Ccp Name"
      expr: ccp_name
    - name: "Comments"
      expr: comments
    - name: "Corrective Action Required Flag"
      expr: corrective_action_required_flag
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Data Source"
      expr: data_source
    - name: "Deviation Severity"
      expr: deviation_severity
    - name: "Hazard Type"
      expr: hazard_type
    - name: "In Limit Flag"
      expr: in_limit_flag
    - name: "Monitoring Frequency"
      expr: monitoring_frequency
    - name: "Monitoring Method"
      expr: monitoring_method
    - name: "Monitoring Timestamp"
      expr: monitoring_timestamp
    - name: "Product Disposition"
      expr: product_disposition
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Modified Timestamp"
      expr: record_modified_timestamp
    - name: "Regulatory Hold Triggered Flag"
      expr: regulatory_hold_triggered_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Haccp Ccp Log"
      expr: COUNT(DISTINCT haccp_ccp_log_id)
    - name: "Total Critical Limit Lower"
      expr: SUM(critical_limit_lower)
    - name: "Average Critical Limit Lower"
      expr: AVG(critical_limit_lower)
    - name: "Total Critical Limit Upper"
      expr: SUM(critical_limit_upper)
    - name: "Average Critical Limit Upper"
      expr: AVG(critical_limit_upper)
    - name: "Total Measured Value"
      expr: SUM(measured_value)
    - name: "Average Measured Value"
      expr: AVG(measured_value)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_lot_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot Consumption business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`lot_consumption`"
  dimensions:
    - name: "Allergen Flag"
      expr: allergen_flag
    - name: "Backflush Indicator"
      expr: backflush_indicator
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Consumption Type"
      expr: consumption_type
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fifo Fefo Sequence Number"
      expr: fifo_fefo_sequence_number
    - name: "Gmo Status"
      expr: gmo_status
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Lot Expiry Date"
      expr: lot_expiry_date
    - name: "Material Document Number"
      expr: material_document_number
    - name: "Material Document Year"
      expr: material_document_year
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lot Consumption"
      expr: COUNT(DISTINCT lot_consumption_id)
    - name: "Total Bom Quantity"
      expr: SUM(bom_quantity)
    - name: "Average Bom Quantity"
      expr: AVG(bom_quantity)
    - name: "Total Consumption Quantity"
      expr: SUM(consumption_quantity)
    - name: "Average Consumption Quantity"
      expr: AVG(consumption_quantity)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
    - name: "Total Variance Quantity"
      expr: SUM(variance_quantity)
    - name: "Average Variance Quantity"
      expr: AVG(variance_quantity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`plant`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Capacity Unit Of Measure"
      expr: capacity_unit_of_measure
    - name: "City"
      expr: city
    - name: "Cold Storage Capacity Pallets"
      expr: cold_storage_capacity_pallets
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommissioning Date"
      expr: decommissioning_date
    - name: "Erp Plant Code"
      expr: erp_plant_code
    - name: "Fda Registration Number"
      expr: fda_registration_number
    - name: "Gfsi Certification Expiry Date"
      expr: gfsi_certification_expiry_date
    - name: "Gfsi Scheme"
      expr: gfsi_scheme
    - name: "Gmp Certified Flag"
      expr: gmp_certified_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plant"
      expr: COUNT(DISTINCT plant_id)
    - name: "Total Daily Capacity Units"
      expr: SUM(daily_capacity_units)
    - name: "Average Daily Capacity Units"
      expr: AVG(daily_capacity_units)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Operating Hours Per Day"
      expr: SUM(operating_hours_per_day)
    - name: "Average Operating Hours Per Day"
      expr: AVG(operating_hours_per_day)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Line business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`production_line`"
  dimensions:
    - name: "Changeover Time Minutes"
      expr: changeover_time_minutes
    - name: "Control System"
      expr: control_system
    - name: "Downtime Minutes"
      expr: downtime_minutes
    - name: "Gmp Compliant"
      expr: gmp_compliant
    - name: "Haccp Status"
      expr: haccp_status
    - name: "Is Automated"
      expr: is_automated
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Quality Check Timestamp"
      expr: last_quality_check_timestamp
    - name: "Line Code"
      expr: line_code
    - name: "Line Description"
      expr: line_description
    - name: "Line End Date"
      expr: line_end_date
    - name: "Line Group"
      expr: line_group
    - name: "Line Name"
      expr: line_name
    - name: "Line Operating Mode"
      expr: line_operating_mode
    - name: "Line Start Date"
      expr: line_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Line"
      expr: COUNT(DISTINCT production_line_id)
    - name: "Total Capacity Per Hour"
      expr: SUM(capacity_per_hour)
    - name: "Average Capacity Per Hour"
      expr: AVG(capacity_per_hour)
    - name: "Total Energy Consumption Kwh"
      expr: SUM(energy_consumption_kwh)
    - name: "Average Energy Consumption Kwh"
      expr: AVG(energy_consumption_kwh)
    - name: "Total Line Speed M Per Min"
      expr: SUM(line_speed_m_per_min)
    - name: "Average Line Speed M Per Min"
      expr: AVG(line_speed_m_per_min)
    - name: "Total Oee Actual"
      expr: SUM(oee_actual)
    - name: "Average Oee Actual"
      expr: AVG(oee_actual)
    - name: "Total Oee Target"
      expr: SUM(oee_target)
    - name: "Average Oee Target"
      expr: AVG(oee_target)
    - name: "Total Quality Score"
      expr: SUM(quality_score)
    - name: "Average Quality Score"
      expr: AVG(quality_score)
    - name: "Total Uptime Percentage"
      expr: SUM(uptime_percentage)
    - name: "Average Uptime Percentage"
      expr: AVG(uptime_percentage)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Order business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "Actual End Timestamp"
      expr: actual_end_timestamp
    - name: "Actual Start Timestamp"
      expr: actual_start_timestamp
    - name: "Bom Version"
      expr: bom_version
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Confirmation Timestamp"
      expr: confirmation_timestamp
    - name: "Confirmation Type"
      expr: confirmation_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fefo Lot Consumption Flag"
      expr: fefo_lot_consumption_flag
    - name: "Fifo Lot Consumption Flag"
      expr: fifo_lot_consumption_flag
    - name: "Gmp Compliance Flag"
      expr: gmp_compliance_flag
    - name: "Goods Movement Document"
      expr: goods_movement_document
    - name: "Haccp Ccp Log Reference"
      expr: haccp_ccp_log_reference
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Mes Work Order Reference"
      expr: mes_work_order_reference
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Order"
      expr: COUNT(DISTINCT production_order_id)
    - name: "Total Batch Size"
      expr: SUM(batch_size)
    - name: "Average Batch Size"
      expr: AVG(batch_size)
    - name: "Total Confirmed Quantity"
      expr: SUM(confirmed_quantity)
    - name: "Average Confirmed Quantity"
      expr: AVG(confirmed_quantity)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Rework Quantity"
      expr: SUM(rework_quantity)
    - name: "Average Rework Quantity"
      expr: AVG(rework_quantity)
    - name: "Total Scrap Quantity"
      expr: SUM(scrap_quantity)
    - name: "Average Scrap Quantity"
      expr: AVG(scrap_quantity)
    - name: "Total Yield Percentage"
      expr: SUM(yield_percentage)
    - name: "Average Yield Percentage"
      expr: AVG(yield_percentage)
    - name: "Total Yield Variance Percentage"
      expr: SUM(yield_variance_percentage)
    - name: "Average Yield Variance Percentage"
      expr: AVG(yield_variance_percentage)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Schedule business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`production_schedule`"
  dimensions:
    - name: "Allergen Changeover Required"
      expr: allergen_changeover_required
    - name: "Changeover Time Minutes"
      expr: changeover_time_minutes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Size Required"
      expr: crew_size_required
    - name: "Execution Completion Timestamp"
      expr: execution_completion_timestamp
    - name: "Frozen Zone Flag"
      expr: frozen_zone_flag
    - name: "Haccp Ccp Applicable"
      expr: haccp_ccp_applicable
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Replanning Timestamp"
      expr: last_replanning_timestamp
    - name: "Lot Number Planned"
      expr: lot_number_planned
    - name: "Material Availability Status"
      expr: material_availability_status
    - name: "Otif Target Date"
      expr: otif_target_date
    - name: "Planned Quantity Uom"
      expr: planned_quantity_uom
    - name: "Planning Horizon"
      expr: planning_horizon
    - name: "Priority Code"
      expr: priority_code
    - name: "Quality Inspection Required"
      expr: quality_inspection_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Schedule"
      expr: COUNT(DISTINCT production_schedule_id)
    - name: "Total Batch Size Target"
      expr: SUM(batch_size_target)
    - name: "Average Batch Size Target"
      expr: AVG(batch_size_target)
    - name: "Total Capacity Utilization Percent"
      expr: SUM(capacity_utilization_percent)
    - name: "Average Capacity Utilization Percent"
      expr: AVG(capacity_utilization_percent)
    - name: "Total Forecast Demand Quantity"
      expr: SUM(forecast_demand_quantity)
    - name: "Average Forecast Demand Quantity"
      expr: AVG(forecast_demand_quantity)
    - name: "Total Planned Quantity"
      expr: SUM(planned_quantity)
    - name: "Average Planned Quantity"
      expr: AVG(planned_quantity)
    - name: "Total Safety Stock Target"
      expr: SUM(safety_stock_target)
    - name: "Average Safety Stock Target"
      expr: AVG(safety_stock_target)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_routing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Routing business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`routing`"
  dimensions:
    - name: "Allergen Handling Required Flag"
      expr: allergen_handling_required_flag
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Base Unit Of Measure"
      expr: base_unit_of_measure
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Gmp Compliant Flag"
      expr: gmp_compliant_flag
    - name: "Haccp Critical Flag"
      expr: haccp_critical_flag
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Operation Count"
      expr: operation_count
    - name: "Organic Certified Flag"
      expr: organic_certified_flag
    - name: "Rework Allowed Flag"
      expr: rework_allowed_flag
    - name: "Routing Description"
      expr: routing_description
    - name: "Routing Number"
      expr: routing_number
    - name: "Routing Status"
      expr: routing_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Routing"
      expr: COUNT(DISTINCT routing_id)
    - name: "Total Base Quantity"
      expr: SUM(base_quantity)
    - name: "Average Base Quantity"
      expr: AVG(base_quantity)
    - name: "Total Changeover Time Minutes"
      expr: SUM(changeover_time_minutes)
    - name: "Average Changeover Time Minutes"
      expr: AVG(changeover_time_minutes)
    - name: "Total Lot Size From"
      expr: SUM(lot_size_from)
    - name: "Average Lot Size From"
      expr: AVG(lot_size_from)
    - name: "Total Lot Size To"
      expr: SUM(lot_size_to)
    - name: "Average Lot Size To"
      expr: AVG(lot_size_to)
    - name: "Total Maximum Batch Size"
      expr: SUM(maximum_batch_size)
    - name: "Average Maximum Batch Size"
      expr: AVG(maximum_batch_size)
    - name: "Total Minimum Batch Size"
      expr: SUM(minimum_batch_size)
    - name: "Average Minimum Batch Size"
      expr: AVG(minimum_batch_size)
    - name: "Total Scrap Percentage"
      expr: SUM(scrap_percentage)
    - name: "Average Scrap Percentage"
      expr: AVG(scrap_percentage)
    - name: "Total Total Standard Production Time Minutes"
      expr: SUM(total_standard_production_time_minutes)
    - name: "Average Total Standard Production Time Minutes"
      expr: AVG(total_standard_production_time_minutes)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work Center business metrics"
  source: "`food_beverage_ecm`.`manufacturing`.`work_center`"
  dimensions:
    - name: "Active From Date"
      expr: active_from_date
    - name: "Active To Date"
      expr: active_to_date
    - name: "Allergen Capable Flag"
      expr: allergen_capable_flag
    - name: "Allergen Types"
      expr: allergen_types
    - name: "Capacity Unit Of Measure"
      expr: capacity_unit_of_measure
    - name: "Cip Required Flag"
      expr: cip_required_flag
    - name: "Co Packing Approved Flag"
      expr: co_packing_approved_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Gmp Classification"
      expr: gmp_classification
    - name: "Haccp Ccp Flag"
      expr: haccp_ccp_flag
    - name: "Halal Certified Flag"
      expr: halal_certified_flag
    - name: "Kosher Certified Flag"
      expr: kosher_certified_flag
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Type"
      expr: line_type
    - name: "Mes Asset Tag"
      expr: mes_asset_tag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Work Center"
      expr: COUNT(DISTINCT work_center_id)
    - name: "Total Available Hours Per Day"
      expr: SUM(available_hours_per_day)
    - name: "Average Available Hours Per Day"
      expr: AVG(available_hours_per_day)
    - name: "Total Changeover Time Minutes"
      expr: SUM(changeover_time_minutes)
    - name: "Average Changeover Time Minutes"
      expr: AVG(changeover_time_minutes)
    - name: "Total Cip Cycle Time Minutes"
      expr: SUM(cip_cycle_time_minutes)
    - name: "Average Cip Cycle Time Minutes"
      expr: AVG(cip_cycle_time_minutes)
    - name: "Total Maximum Run Size"
      expr: SUM(maximum_run_size)
    - name: "Average Maximum Run Size"
      expr: AVG(maximum_run_size)
    - name: "Total Minimum Run Size"
      expr: SUM(minimum_run_size)
    - name: "Average Minimum Run Size"
      expr: AVG(minimum_run_size)
    - name: "Total Oee Target Percent"
      expr: SUM(oee_target_percent)
    - name: "Average Oee Target Percent"
      expr: AVG(oee_target_percent)
    - name: "Total Rated Capacity Units Per Hour"
      expr: SUM(rated_capacity_units_per_hour)
    - name: "Average Rated Capacity Units Per Hour"
      expr: AVG(rated_capacity_units_per_hour)
    - name: "Total Setup Time Minutes"
      expr: SUM(setup_time_minutes)
    - name: "Average Setup Time Minutes"
      expr: AVG(setup_time_minutes)
    - name: "Total Standard Cycle Time Minutes"
      expr: SUM(standard_cycle_time_minutes)
    - name: "Average Standard Cycle Time Minutes"
      expr: AVG(standard_cycle_time_minutes)
    - name: "Total Teardown Time Minutes"
      expr: SUM(teardown_time_minutes)
    - name: "Average Teardown Time Minutes"
      expr: AVG(teardown_time_minutes)
$$;