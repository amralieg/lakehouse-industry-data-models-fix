-- Metric views for domain: fabrication | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_yield`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fabrication yield and quality metrics tracking die-level outcomes, defect rates, and yield performance across wafer lots and process steps"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "checkpoint_code"
      expr: checkpoint_code
      comment: "Process checkpoint where yield was measured"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Final disposition status of the yield record (pass, fail, rework, scrap)"
    - name: "excursion_severity_level"
      expr: excursion_severity_level
      comment: "Severity classification of yield excursions"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code if lot was placed on hold due to yield issues"
    - name: "yield_excursion_flag"
      expr: yield_excursion_flag
      comment: "Boolean flag indicating whether a yield excursion occurred"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Boolean flag indicating whether rework was required"
    - name: "scrap_flag"
      expr: scrap_flag
      comment: "Boolean flag indicating whether material was scrapped"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date when yield measurement was taken"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month when yield measurement was taken"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "total_gross_die"
      expr: SUM(CAST(gross_die_count AS BIGINT))
      comment: "Total gross die count across all wafers before any screening"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS BIGINT))
      comment: "Total count of good die that passed all quality criteria"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across all yield records"
    - name: "avg_defect_rate"
      expr: AVG(CAST(defect_rate AS DOUBLE))
      comment: "Average defect rate per wafer or lot"
    - name: "total_random_defect_die"
      expr: SUM(CAST(random_defect_die_count AS BIGINT))
      comment: "Total die lost to random defects"
    - name: "total_systematic_defect_die"
      expr: SUM(CAST(systematic_defect_die_count AS BIGINT))
      comment: "Total die lost to systematic defects"
    - name: "total_process_loss_die"
      expr: SUM(CAST(process_loss_die_count AS BIGINT))
      comment: "Total die lost due to process-related issues"
    - name: "total_design_loss_die"
      expr: SUM(CAST(design_loss_die_count AS BIGINT))
      comment: "Total die lost due to design-related issues"
    - name: "yield_excursion_count"
      expr: SUM(CASE WHEN yield_excursion_flag = true THEN 1 ELSE 0 END)
      comment: "Count of yield records flagged as excursions"
    - name: "rework_count"
      expr: SUM(CASE WHEN rework_flag = true THEN 1 ELSE 0 END)
      comment: "Count of yield records requiring rework"
    - name: "scrap_count"
      expr: SUM(CASE WHEN scrap_flag = true THEN 1 ELSE 0 END)
      comment: "Count of yield records resulting in scrap"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer lot production metrics tracking cycle time, throughput, WIP status, and operational efficiency across fabrication facilities"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Work-in-process status of the wafer lot"
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final disposition of the lot (released, scrapped, on-hold, etc.)"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot (production, engineering, qualification, etc.)"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for scheduling and expediting"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Boolean flag indicating whether lot is currently on hold"
    - name: "is_hot_lot"
      expr: is_hot_lot
      comment: "Boolean flag indicating whether lot is expedited (hot lot)"
    - name: "current_process_area"
      expr: current_process_area
      comment: "Current process area where lot is located"
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process technology node in nanometers"
    - name: "lot_start_month"
      expr: DATE_TRUNC('month', wafer_start_timestamp)
      comment: "Month when wafer lot was started"
    - name: "lot_completion_month"
      expr: DATE_TRUNC('month', actual_completion_timestamp)
      comment: "Month when wafer lot was completed"
  measures:
    - name: "total_wafer_lots"
      expr: COUNT(1)
      comment: "Total number of wafer lots"
    - name: "total_wafers_started"
      expr: SUM(CAST(initial_wafer_count AS BIGINT))
      comment: "Total count of wafers started across all lots"
    - name: "total_wafers_current"
      expr: SUM(CAST(wafer_count AS BIGINT))
      comment: "Current total wafer count across all lots"
    - name: "total_wafers_scrapped"
      expr: SUM(CAST(scrap_wafer_count AS BIGINT))
      comment: "Total count of wafers scrapped"
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time in days from lot start to completion"
    - name: "avg_process_time_hours"
      expr: AVG(CAST(process_time_hours AS DOUBLE))
      comment: "Average active process time in hours"
    - name: "avg_queue_time_hours"
      expr: AVG(CAST(queue_time_hours AS DOUBLE))
      comment: "Average queue time in hours waiting between operations"
    - name: "total_rework_count"
      expr: SUM(CAST(rework_count AS BIGINT))
      comment: "Total number of rework operations across all lots"
    - name: "hot_lot_count"
      expr: SUM(CASE WHEN is_hot_lot = true THEN 1 ELSE 0 END)
      comment: "Count of expedited hot lots"
    - name: "hold_lot_count"
      expr: SUM(CASE WHEN hold_flag = true THEN 1 ELSE 0 END)
      comment: "Count of lots currently on hold"
    - name: "distinct_process_nodes"
      expr: COUNT(DISTINCT process_node_nm)
      comment: "Number of distinct process technology nodes in production"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot hold and containment metrics tracking quality holds, hold duration, escalations, and disposition actions for risk management"
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the hold (active, released, expired, etc.)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (quality, engineering, customer, etc.)"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for why hold was placed"
    - name: "disposition_action"
      expr: disposition_action
      comment: "Disposition action taken (release, scrap, rework, sort, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for hold resolution"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether hold was escalated"
    - name: "approval_required"
      expr: approval_required
      comment: "Boolean flag indicating whether approval is required for release"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Boolean flag indicating whether customer notification is required"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code identified during hold investigation"
    - name: "hold_placement_month"
      expr: DATE_TRUNC('month', hold_placement_timestamp)
      comment: "Month when hold was placed"
  measures:
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of lot holds"
    - name: "total_wafers_on_hold"
      expr: SUM(CAST(wafer_count AS BIGINT))
      comment: "Total count of wafers currently or previously on hold"
    - name: "avg_hold_cycle_time_hours"
      expr: AVG(CAST(hold_cycle_time_hours AS DOUBLE))
      comment: "Average duration of holds in hours from placement to release"
    - name: "escalated_hold_count"
      expr: SUM(CASE WHEN escalation_flag = true THEN 1 ELSE 0 END)
      comment: "Count of holds that were escalated"
    - name: "customer_notification_count"
      expr: SUM(CASE WHEN customer_notification_required = true THEN 1 ELSE 0 END)
      comment: "Count of holds requiring customer notification"
    - name: "approval_required_count"
      expr: SUM(CASE WHEN approval_required = true THEN 1 ELSE 0 END)
      comment: "Count of holds requiring approval for release"
    - name: "distinct_hold_reasons"
      expr: COUNT(DISTINCT hold_reason_code)
      comment: "Number of distinct hold reason codes"
    - name: "distinct_root_causes"
      expr: COUNT(DISTINCT root_cause_code)
      comment: "Number of distinct root cause codes identified"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_lot_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot move and operation tracking metrics measuring equipment utilization, process time, queue time, and throughput efficiency"
  source: "`vibe_semiconductors_v1`.`fabrication`.`lot_move`"
  dimensions:
    - name: "move_status"
      expr: move_status
      comment: "Status of the lot move operation"
    - name: "disposition"
      expr: disposition
      comment: "Disposition outcome of the move"
    - name: "process_layer"
      expr: process_layer
      comment: "Process layer being fabricated"
    - name: "process_module"
      expr: process_module
      comment: "Process module (lithography, etch, deposition, etc.)"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for this operation"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Boolean flag indicating whether this is a rework operation"
    - name: "sampling_flag"
      expr: sampling_flag
      comment: "Boolean flag indicating whether sampling was performed"
    - name: "cooling_process_flag"
      expr: cooling_process_flag
      comment: "Boolean flag indicating whether cooling process was used"
    - name: "cooling_optimization_enabled_flag"
      expr: cooling_optimization_enabled_flag
      comment: "Boolean flag indicating whether cooling optimization was enabled"
    - name: "move_in_month"
      expr: DATE_TRUNC('month', move_in_timestamp)
      comment: "Month when lot moved into operation"
  measures:
    - name: "total_lot_moves"
      expr: COUNT(1)
      comment: "Total number of lot move transactions"
    - name: "total_quantity_in"
      expr: SUM(CAST(quantity_in AS BIGINT))
      comment: "Total quantity of wafers moved into operations"
    - name: "total_quantity_out"
      expr: SUM(CAST(quantity_out AS BIGINT))
      comment: "Total quantity of wafers moved out of operations"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS BIGINT))
      comment: "Total quantity of wafers scrapped during operations"
    - name: "avg_process_time_seconds"
      expr: AVG(CAST(process_time_seconds AS DOUBLE))
      comment: "Average process time per operation in seconds"
    - name: "avg_queue_time_seconds"
      expr: AVG(CAST(queue_time_seconds AS DOUBLE))
      comment: "Average queue time waiting for equipment in seconds"
    - name: "avg_actual_temperature_c"
      expr: AVG(CAST(actual_temperature_c AS DOUBLE))
      comment: "Average actual process temperature in Celsius"
    - name: "avg_actual_pressure_torr"
      expr: AVG(CAST(actual_pressure_torr AS DOUBLE))
      comment: "Average actual process pressure in Torr"
    - name: "avg_cooling_energy_kwh"
      expr: AVG(CAST(cooling_energy_consumption_kwh AS DOUBLE))
      comment: "Average cooling energy consumption per operation in kWh"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS BIGINT))
      comment: "Total defects detected during lot moves"
    - name: "rework_operation_count"
      expr: SUM(CASE WHEN rework_flag = true THEN 1 ELSE 0 END)
      comment: "Count of rework operations"
    - name: "sampling_operation_count"
      expr: SUM(CASE WHEN sampling_flag = true THEN 1 ELSE 0 END)
      comment: "Count of operations where sampling was performed"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabrication facility capacity, utilization, and environmental performance metrics for strategic resource planning and sustainability reporting"
  source: "`vibe_semiconductors_v1`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "facility_code"
      expr: facility_code
      comment: "Unique facility code identifier"
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the fabrication facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (wafer fab, assembly, test, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status (active, ramping, idle, decommissioned, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status"
    - name: "country_code"
      expr: country_code
      comment: "Country where facility is located"
    - name: "process_technology_node"
      expr: process_technology_node
      comment: "Primary process technology node supported"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography technology type (DUV, EUV, etc.)"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of fabrication facilities"
    - name: "total_capacity_wafers_per_month"
      expr: SUM(CAST(capacity_wafer_per_month AS BIGINT))
      comment: "Total monthly wafer capacity across all facilities"
    - name: "avg_capacity_wafers_per_month"
      expr: AVG(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Average monthly wafer capacity per facility"
    - name: "total_fab_area_sqft"
      expr: SUM(CAST(fab_area_sqft AS DOUBLE))
      comment: "Total fabrication area in square feet"
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in megawatt-hours"
    - name: "total_carbon_footprint_kgco2e"
      expr: SUM(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Total carbon footprint in kilograms CO2 equivalent"
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water usage in cubic meters"
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons"
    - name: "avg_energy_per_sqft"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE) / NULLIF(CAST(fab_area_sqft AS DOUBLE), 0))
      comment: "Average energy consumption per square foot of fab area"
    - name: "total_cleanrooms"
      expr: SUM(CAST(number_of_cleanrooms AS BIGINT))
      comment: "Total number of cleanrooms across all facilities"
    - name: "total_equipment_units"
      expr: SUM(CAST(number_of_equipment_units AS BIGINT))
      comment: "Total number of equipment units across all facilities"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_photomask`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Photomask lifecycle, utilization, and quality metrics for reticle management and lithography cost optimization"
  source: "`vibe_semiconductors_v1`.`fabrication`.`photomask`"
  dimensions:
    - name: "mask_status"
      expr: mask_status
      comment: "Current status of the photomask (active, quarantine, retired, etc.)"
    - name: "mask_type"
      expr: mask_type
      comment: "Type of photomask (binary, phase-shift, EUV, etc.)"
    - name: "layer_name"
      expr: layer_name
      comment: "Layer name for which this mask is used"
    - name: "lithography_wavelength"
      expr: lithography_wavelength
      comment: "Lithography wavelength (193nm, 13.5nm EUV, etc.)"
    - name: "mask_generation"
      expr: mask_generation
      comment: "Generation or version of the mask design"
    - name: "pellicle_status"
      expr: pellicle_status
      comment: "Status of the protective pellicle"
    - name: "retirement_reason"
      expr: retirement_reason
      comment: "Reason for mask retirement if applicable"
    - name: "qualification_month"
      expr: DATE_TRUNC('month', qualification_date)
      comment: "Month when mask was qualified for production"
  measures:
    - name: "total_photomasks"
      expr: COUNT(1)
      comment: "Total number of photomasks in inventory"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all photomasks"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per photomask"
    - name: "total_cumulative_usage"
      expr: SUM(CAST(cumulative_usage_count AS BIGINT))
      comment: "Total cumulative usage count across all masks"
    - name: "avg_cumulative_usage"
      expr: AVG(CAST(cumulative_usage_count AS DOUBLE))
      comment: "Average cumulative usage count per mask"
    - name: "total_cumulative_exposure_hours"
      expr: SUM(CAST(cumulative_exposure_hours AS DOUBLE))
      comment: "Total cumulative exposure hours across all masks"
    - name: "avg_critical_defect_count"
      expr: AVG(CAST(critical_defect_count AS DOUBLE))
      comment: "Average critical defect count per mask"
    - name: "total_cleaning_cycles"
      expr: SUM(CAST(cleaning_cycle_count AS BIGINT))
      comment: "Total cleaning cycles performed across all masks"
    - name: "avg_cd_uniformity"
      expr: AVG(CAST(cd_uniformity_specification AS DOUBLE))
      comment: "Average critical dimension uniformity specification"
    - name: "avg_meef_value"
      expr: AVG(CAST(meef_value AS DOUBLE))
      comment: "Average mask error enhancement factor (MEEF) value"
    - name: "distinct_layers"
      expr: COUNT(DISTINCT layer_name)
      comment: "Number of distinct layers covered by photomask inventory"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_process_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process flow design and qualification metrics tracking cycle time targets, step complexity, and technology readiness for new product introductions"
  source: "`vibe_semiconductors_v1`.`fabrication`.`process_flow`"
  dimensions:
    - name: "flow_code"
      expr: flow_code
      comment: "Unique process flow code"
    - name: "flow_name"
      expr: flow_name
      comment: "Name of the process flow"
    - name: "flow_type"
      expr: flow_type
      comment: "Type of process flow (standard, custom, engineering, etc.)"
    - name: "flow_status"
      expr: flow_status
      comment: "Current status of the process flow (active, development, frozen, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (qualified, in-qualification, not-qualified, etc.)"
    - name: "lithography_technology"
      expr: lithography_technology
      comment: "Lithography technology used in this flow"
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (FinFET, GAA, planar, etc.)"
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate type (silicon, SOI, etc.)"
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Boolean flag indicating whether flow is customer-specific"
    - name: "requires_nre"
      expr: requires_nre
      comment: "Boolean flag indicating whether non-recurring engineering is required"
  measures:
    - name: "total_process_flows"
      expr: COUNT(1)
      comment: "Total number of process flows"
    - name: "avg_total_process_steps"
      expr: AVG(CAST(total_process_steps AS DOUBLE))
      comment: "Average total number of process steps per flow"
    - name: "avg_feol_step_count"
      expr: AVG(CAST(feol_step_count AS DOUBLE))
      comment: "Average front-end-of-line step count"
    - name: "avg_beol_step_count"
      expr: AVG(CAST(beol_step_count AS DOUBLE))
      comment: "Average back-end-of-line step count"
    - name: "avg_metal_layer_count"
      expr: AVG(CAST(metal_layer_count AS DOUBLE))
      comment: "Average number of metal layers"
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time in days"
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage"
    - name: "customer_specific_flow_count"
      expr: SUM(CASE WHEN is_customer_specific = true THEN 1 ELSE 0 END)
      comment: "Count of customer-specific process flows"
    - name: "nre_required_flow_count"
      expr: SUM(CASE WHEN requires_nre = true THEN 1 ELSE 0 END)
      comment: "Count of flows requiring non-recurring engineering"
    - name: "distinct_lithography_technologies"
      expr: COUNT(DISTINCT lithography_technology)
      comment: "Number of distinct lithography technologies in use"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`fabrication_wafer_start`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer start authorization and release metrics tracking demand fulfillment, priority mix, and production planning effectiveness"
  source: "`vibe_semiconductors_v1`.`fabrication`.`wafer_start`"
  dimensions:
    - name: "wafer_start_status"
      expr: wafer_start_status
      comment: "Status of the wafer start authorization"
    - name: "wafer_start_type"
      expr: wafer_start_type
      comment: "Type of wafer start (production, engineering, qualification, etc.)"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification for the wafer start"
    - name: "production_line"
      expr: production_line
      comment: "Production line assigned for fabrication"
    - name: "substrate_type"
      expr: substrate_type
      comment: "Substrate type for the wafer start"
    - name: "doping_type"
      expr: doping_type
      comment: "Doping type (N-type, P-type, etc.)"
    - name: "crystal_orientation"
      expr: crystal_orientation
      comment: "Crystal orientation of the substrate"
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "Boolean flag indicating whether wafer start is ITAR controlled"
    - name: "wafer_start_month"
      expr: DATE_TRUNC('month', wafer_start_timestamp)
      comment: "Month when wafer start was authorized"
  measures:
    - name: "total_wafer_starts"
      expr: COUNT(1)
      comment: "Total number of wafer start authorizations"
    - name: "total_wafer_quantity"
      expr: SUM(CAST(wafer_quantity AS BIGINT))
      comment: "Total quantity of wafers authorized for start"
    - name: "avg_wafer_quantity_per_start"
      expr: AVG(CAST(wafer_quantity AS DOUBLE))
      comment: "Average wafer quantity per start authorization"
    - name: "avg_estimated_cycle_time_days"
      expr: AVG(CAST(estimated_cycle_time_days AS DOUBLE))
      comment: "Average estimated cycle time in days"
    - name: "itar_controlled_start_count"
      expr: SUM(CASE WHEN itar_controlled_flag = true THEN 1 ELSE 0 END)
      comment: "Count of ITAR-controlled wafer starts"
    - name: "distinct_production_lines"
      expr: COUNT(DISTINCT production_line)
      comment: "Number of distinct production lines utilized"
    - name: "distinct_priority_classes"
      expr: COUNT(DISTINCT priority_class)
      comment: "Number of distinct priority classes"
$$;