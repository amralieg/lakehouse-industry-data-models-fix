-- Metric views for domain: fabrication | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_equipment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment run performance metrics tracking process efficiency, yield, and equipment utilization across fabrication operations"
  source: "`semiconductors_ecm`.`fabrication`.`equipment_run`"
  dimensions:
    - name: "process_type"
      expr: process_type
      comment: "Type of fabrication process (lithography, deposition, etch, implant, CMP)"
    - name: "run_status"
      expr: run_status
      comment: "Status of the equipment run (completed, aborted, in-progress)"
    - name: "abort_reason"
      expr: abort_reason
      comment: "Reason for run abortion if applicable"
    - name: "deposition_film_material"
      expr: deposition_film_material
      comment: "Material deposited during deposition process runs"
    - name: "implant_species"
      expr: implant_species
      comment: "Ion species used in implantation runs"
    - name: "cmp_slurry_type"
      expr: cmp_slurry_type
      comment: "Type of slurry used in chemical mechanical polishing"
    - name: "run_year"
      expr: YEAR(run_start_timestamp)
      comment: "Year when the equipment run started"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_start_timestamp)
      comment: "Month when the equipment run started"
    - name: "run_date"
      expr: DATE(run_start_timestamp)
      comment: "Date when the equipment run started"
  measures:
    - name: "total_equipment_runs"
      expr: COUNT(1)
      comment: "Total number of equipment runs executed"
    - name: "total_wafers_processed"
      expr: SUM(CAST(processes_lot AS DOUBLE))
      comment: "Total number of wafers processed across all equipment runs"
    - name: "avg_run_duration_hours"
      expr: AVG(CAST(run_duration_seconds AS DOUBLE) / 3600.0)
      comment: "Average equipment run duration in hours"
    - name: "total_run_time_hours"
      expr: SUM(CAST(run_duration_seconds AS DOUBLE) / 3600.0)
      comment: "Total equipment run time in hours"
    - name: "avg_deposition_rate"
      expr: AVG(CAST(deposition_rate_angstrom_per_min AS DOUBLE))
      comment: "Average deposition rate in angstroms per minute for deposition processes"
    - name: "avg_deposition_uniformity_pct"
      expr: AVG(CAST(deposition_uniformity_percent AS DOUBLE))
      comment: "Average deposition uniformity percentage indicating process quality"
    - name: "avg_lithography_cd_nm"
      expr: AVG(CAST(lithography_cd_measurement_nm AS DOUBLE))
      comment: "Average critical dimension measurement in nanometers for lithography processes"
    - name: "avg_cmp_removal_rate"
      expr: AVG(CAST(cmp_removal_rate_angstrom_per_min AS DOUBLE))
      comment: "Average CMP material removal rate in angstroms per minute"
    - name: "avg_cmp_wiwnu_pct"
      expr: AVG(CAST(cmp_wiwnu_percent AS DOUBLE))
      comment: "Average within-wafer non-uniformity percentage for CMP processes"
    - name: "avg_actual_temperature_celsius"
      expr: AVG(CAST(actual_temperature_celsius AS DOUBLE))
      comment: "Average actual process temperature in celsius"
    - name: "avg_actual_pressure_torr"
      expr: AVG(CAST(actual_pressure_torr AS DOUBLE))
      comment: "Average actual process pressure in torr"
    - name: "distinct_tools_used"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct fabrication tools used"
    - name: "distinct_recipes_executed"
      expr: COUNT(DISTINCT fabrication_process_recipe_id)
      comment: "Number of distinct process recipes executed"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_wafer_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer lot lifecycle and work-in-process metrics tracking cycle time, throughput, and lot status across fabrication"
  source: "`semiconductors_ecm`.`fabrication`.`fabrication_wafer_lot`"
  dimensions:
    - name: "wip_status"
      expr: wip_status
      comment: "Work-in-process status of the wafer lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of wafer lot (production, engineering, qualification)"
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Final disposition of the lot (pass, fail, scrap, rework)"
    - name: "priority_class"
      expr: priority_class
      comment: "Priority classification of the lot"
    - name: "current_process_area"
      expr: current_process_area
      comment: "Current process area where the lot is located"
    - name: "hold_flag"
      expr: hold_flag
      comment: "Indicates whether the lot is currently on hold"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for lot hold if applicable"
    - name: "is_hot_lot"
      expr: is_hot_lot
      comment: "Indicates whether this is a high-priority hot lot"
    - name: "wafer_size_mm"
      expr: wafer_size_mm
      comment: "Wafer size in millimeters (200mm, 300mm, etc.)"
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process technology node in nanometers"
    - name: "lot_start_year"
      expr: YEAR(wafer_start_timestamp)
      comment: "Year when the lot was started"
    - name: "lot_start_month"
      expr: DATE_TRUNC('MONTH', wafer_start_timestamp)
      comment: "Month when the lot was started"
    - name: "completion_year"
      expr: YEAR(actual_completion_timestamp)
      comment: "Year when the lot was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', actual_completion_timestamp)
      comment: "Month when the lot was completed"
  measures:
    - name: "total_wafer_lots"
      expr: COUNT(1)
      comment: "Total number of wafer lots"
    - name: "total_wafers_started"
      expr: SUM(CAST(initial_wafer_count AS DOUBLE))
      comment: "Total number of wafers started across all lots"
    - name: "total_wafers_scrapped"
      expr: SUM(CAST(scrap_wafer_count AS DOUBLE))
      comment: "Total number of wafers scrapped"
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average cycle time in days from lot start to completion"
    - name: "avg_process_time_hours"
      expr: AVG(CAST(process_time_hours AS DOUBLE))
      comment: "Average active process time in hours"
    - name: "avg_queue_time_hours"
      expr: AVG(CAST(queue_time_hours AS DOUBLE))
      comment: "Average queue time in hours waiting between operations"
    - name: "total_process_time_hours"
      expr: SUM(CAST(process_time_hours AS DOUBLE))
      comment: "Total process time in hours across all lots"
    - name: "total_queue_time_hours"
      expr: SUM(CAST(queue_time_hours AS DOUBLE))
      comment: "Total queue time in hours across all lots"
    - name: "lots_on_hold"
      expr: SUM(CASE WHEN hold_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots currently on hold"
    - name: "hot_lots"
      expr: SUM(CASE WHEN is_hot_lot = TRUE THEN 1 ELSE 0 END)
      comment: "Number of high-priority hot lots"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers with active lots"
    - name: "distinct_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct IC design projects in fabrication"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of distinct fabrication facilities processing lots"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_fab_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabrication yield and die-level quality metrics tracking good die, defects, and yield performance"
  source: "`semiconductors_ecm`.`fabrication`.`fab_yield_record`"
  dimensions:
    - name: "checkpoint_code"
      expr: checkpoint_code
      comment: "Process checkpoint where yield was measured"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Disposition status of the yield record"
    - name: "yield_excursion_flag"
      expr: yield_excursion_flag
      comment: "Indicates whether yield excursion was detected"
    - name: "excursion_severity_level"
      expr: excursion_severity_level
      comment: "Severity level of yield excursion if detected"
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether lot was reworked"
    - name: "scrap_flag"
      expr: scrap_flag
      comment: "Indicates whether lot was scrapped"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code if lot was placed on hold"
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year when yield was measured"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when yield was measured"
    - name: "measurement_date"
      expr: DATE(measurement_timestamp)
      comment: "Date when yield was measured"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total number of good die across all yield records"
    - name: "total_gross_die"
      expr: SUM(CAST(gross_die_count AS DOUBLE))
      comment: "Total number of gross die before yield loss"
    - name: "total_reject_die"
      expr: SUM(CAST(reject_bin_die_count AS DOUBLE))
      comment: "Total number of rejected die"
    - name: "total_design_loss_die"
      expr: SUM(CAST(design_loss_die_count AS DOUBLE))
      comment: "Total die lost due to design issues"
    - name: "total_process_loss_die"
      expr: SUM(CAST(process_loss_die_count AS DOUBLE))
      comment: "Total die lost due to process issues"
    - name: "total_random_defect_die"
      expr: SUM(CAST(random_defect_die_count AS DOUBLE))
      comment: "Total die lost to random defects"
    - name: "total_systematic_defect_die"
      expr: SUM(CAST(systematic_defect_die_count AS DOUBLE))
      comment: "Total die lost to systematic defects"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across all measurements"
    - name: "yield_excursions"
      expr: SUM(CASE WHEN yield_excursion_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of yield excursion events detected"
    - name: "lots_reworked"
      expr: SUM(CASE WHEN rework_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots that required rework"
    - name: "lots_scrapped"
      expr: SUM(CASE WHEN scrap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of lots that were scrapped"
    - name: "distinct_lots_measured"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots with yield measurements"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of distinct fabrication facilities with yield data"
    - name: "distinct_tools"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct tools associated with yield measurements"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_lot_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot hold and quality incident metrics tracking hold reasons, cycle time impact, and resolution performance"
  source: "`semiconductors_ecm`.`fabrication`.`fabrication_lot_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the lot hold (active, released, expired)"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold (quality, engineering, customer, equipment)"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Standardized reason code for the hold"
    - name: "hold_reason_description"
      expr: hold_reason_description
      comment: "Detailed description of hold reason"
    - name: "disposition_action"
      expr: disposition_action
      comment: "Action taken to resolve the hold"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code identified during investigation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the hold"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether hold was escalated"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Indicates whether customer notification was required"
    - name: "approval_required"
      expr: approval_required
      comment: "Indicates whether management approval was required for release"
    - name: "defect_density_threshold_exceeded"
      expr: defect_density_threshold_exceeded
      comment: "Indicates whether defect density threshold was exceeded"
    - name: "hold_placement_year"
      expr: YEAR(hold_placement_timestamp)
      comment: "Year when hold was placed"
    - name: "hold_placement_month"
      expr: DATE_TRUNC('MONTH', hold_placement_timestamp)
      comment: "Month when hold was placed"
  measures:
    - name: "total_lot_holds"
      expr: COUNT(1)
      comment: "Total number of lot hold events"
    - name: "avg_hold_cycle_time_hours"
      expr: AVG(CAST(hold_cycle_time_hours AS DOUBLE))
      comment: "Average time in hours from hold placement to release"
    - name: "total_hold_time_hours"
      expr: SUM(CAST(hold_cycle_time_hours AS DOUBLE))
      comment: "Total hold time in hours across all hold events"
    - name: "holds_escalated"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds that were escalated"
    - name: "holds_requiring_customer_notification"
      expr: SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds requiring customer notification"
    - name: "holds_requiring_approval"
      expr: SUM(CASE WHEN approval_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds requiring management approval"
    - name: "defect_density_excursions"
      expr: SUM(CASE WHEN defect_density_threshold_exceeded = TRUE THEN 1 ELSE 0 END)
      comment: "Number of holds due to defect density threshold excursions"
    - name: "distinct_lots_held"
      expr: COUNT(DISTINCT primary_fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots placed on hold"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of distinct facilities with lot holds"
    - name: "distinct_tools_involved"
      expr: COUNT(DISTINCT fab_tool_id)
      comment: "Number of distinct tools associated with holds"
    - name: "distinct_process_steps"
      expr: COUNT(DISTINCT process_step_id)
      comment: "Number of distinct process steps where holds occurred"
    - name: "distinct_customers_affected"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers affected by holds"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_fab_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fabrication facility capacity, utilization, and environmental performance metrics"
  source: "`semiconductors_ecm`.`fabrication`.`fab_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of fabrication facility (wafer fab, assembly, test)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status (active, ramping, idle, decommissioned)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status"
    - name: "cleanroom_class"
      expr: cleanroom_class
      comment: "ISO cleanroom classification"
    - name: "lithography_type"
      expr: lithography_type
      comment: "Primary lithography technology (DUV, EUV, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where facility is located"
    - name: "state_province"
      expr: state_province
      comment: "State or province location"
    - name: "city"
      expr: city
      comment: "City location"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of fabrication facilities"
    - name: "total_capacity_wafers_per_month"
      expr: SUM(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Total monthly wafer capacity across all facilities"
    - name: "avg_capacity_wafers_per_month"
      expr: AVG(CAST(capacity_wafer_per_month AS DOUBLE))
      comment: "Average monthly wafer capacity per facility"
    - name: "total_fab_area_sqft"
      expr: SUM(CAST(fab_area_sqft AS DOUBLE))
      comment: "Total fabrication area in square feet"
    - name: "avg_fab_area_sqft"
      expr: AVG(CAST(fab_area_sqft AS DOUBLE))
      comment: "Average fabrication area per facility in square feet"
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in megawatt-hours"
    - name: "avg_energy_consumption_mwh"
      expr: AVG(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Average energy consumption per facility in megawatt-hours"
    - name: "total_carbon_footprint_kgco2e"
      expr: SUM(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Total carbon footprint in kilograms CO2 equivalent"
    - name: "avg_carbon_footprint_kgco2e"
      expr: AVG(CAST(carbon_footprint_kgco2e AS DOUBLE))
      comment: "Average carbon footprint per facility in kilograms CO2 equivalent"
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_m3 AS DOUBLE))
      comment: "Total water usage in cubic meters"
    - name: "avg_water_usage_m3"
      expr: AVG(CAST(water_usage_m3 AS DOUBLE))
      comment: "Average water usage per facility in cubic meters"
    - name: "total_waste_generated_tons"
      expr: SUM(CAST(waste_generated_tons AS DOUBLE))
      comment: "Total waste generated in tons"
    - name: "avg_waste_generated_tons"
      expr: AVG(CAST(waste_generated_tons AS DOUBLE))
      comment: "Average waste generated per facility in tons"
    - name: "distinct_legal_entities"
      expr: COUNT(DISTINCT legal_entity_id)
      comment: "Number of distinct legal entities operating facilities"
    - name: "distinct_profit_centers"
      expr: COUNT(DISTINCT profit_center_id)
      comment: "Number of distinct profit centers"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_process_step`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process step performance metrics tracking cycle time, cost, and operational efficiency"
  source: "`semiconductors_ecm`.`fabrication`.`process_step`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of fabrication operation"
    - name: "process_category"
      expr: process_category
      comment: "High-level process category (FEOL, BEOL, MOL)"
    - name: "process_subcategory"
      expr: process_subcategory
      comment: "Detailed process subcategory"
    - name: "equipment_class"
      expr: equipment_class
      comment: "Class of equipment required for this step"
    - name: "step_status"
      expr: step_status
      comment: "Status of the process step definition (active, obsolete, development)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the process step"
    - name: "critical_step_flag"
      expr: critical_step_flag
      comment: "Indicates whether this is a critical process step"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether inspection is required after this step"
    - name: "rework_loop_indicator"
      expr: rework_loop_indicator
      comment: "Indicates whether this step is part of a rework loop"
    - name: "skip_allowed_flag"
      expr: skip_allowed_flag
      comment: "Indicates whether this step can be skipped under certain conditions"
  measures:
    - name: "total_process_steps"
      expr: COUNT(1)
      comment: "Total number of defined process steps"
    - name: "critical_process_steps"
      expr: SUM(CASE WHEN critical_step_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of critical process steps"
    - name: "steps_requiring_inspection"
      expr: SUM(CASE WHEN inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of steps requiring inspection"
    - name: "rework_loop_steps"
      expr: SUM(CASE WHEN rework_loop_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of steps that are part of rework loops"
    - name: "avg_target_cycle_time_minutes"
      expr: AVG(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Average target cycle time per step in minutes"
    - name: "total_target_cycle_time_minutes"
      expr: SUM(CAST(target_cycle_time_minutes AS DOUBLE))
      comment: "Total target cycle time across all steps in minutes"
    - name: "avg_standard_queue_time_minutes"
      expr: AVG(CAST(standard_queue_time_minutes AS DOUBLE))
      comment: "Average standard queue time per step in minutes"
    - name: "total_standard_queue_time_minutes"
      expr: SUM(CAST(standard_queue_time_minutes AS DOUBLE))
      comment: "Total standard queue time across all steps in minutes"
    - name: "avg_max_queue_time_minutes"
      expr: AVG(CAST(max_queue_time_minutes AS DOUBLE))
      comment: "Average maximum allowed queue time per step in minutes"
    - name: "avg_step_cost_per_wafer"
      expr: AVG(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Average cost per wafer per process step"
    - name: "total_step_cost_per_wafer"
      expr: SUM(CAST(step_cost_per_wafer AS DOUBLE))
      comment: "Total cost per wafer across all process steps"
    - name: "avg_sampling_rate_percent"
      expr: AVG(CAST(sampling_rate_percent AS DOUBLE))
      comment: "Average sampling rate percentage for quality control"
    - name: "distinct_process_flows"
      expr: COUNT(DISTINCT process_flow_id)
      comment: "Number of distinct process flows containing these steps"
    - name: "distinct_recipes"
      expr: COUNT(DISTINCT fabrication_process_recipe_id)
      comment: "Number of distinct process recipes associated with steps"
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers responsible for process steps"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_wafer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual wafer tracking and die-level quality metrics for fabrication yield analysis"
  source: "`semiconductors_ecm`.`fabrication`.`wafer`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Final disposition status of the wafer"
    - name: "substrate_type"
      expr: substrate_type
      comment: "Type of wafer substrate material"
    - name: "doping_type"
      expr: doping_type
      comment: "Doping type (N-type, P-type)"
    - name: "crystal_orientation"
      expr: crystal_orientation
      comment: "Crystal orientation of the wafer"
    - name: "diameter_mm"
      expr: diameter_mm
      comment: "Wafer diameter in millimeters"
    - name: "epitaxial_layer_flag"
      expr: epitaxial_layer_flag
      comment: "Indicates whether wafer has epitaxial layer"
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code if wafer is on hold"
    - name: "scrap_reason_code"
      expr: scrap_reason_code
      comment: "Reason code if wafer was scrapped"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the wafer"
    - name: "current_process_step"
      expr: current_process_step
      comment: "Current process step where wafer is located"
    - name: "start_year"
      expr: YEAR(start_timestamp)
      comment: "Year when wafer processing started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when wafer processing started"
    - name: "completion_year"
      expr: YEAR(completion_timestamp)
      comment: "Year when wafer processing completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_timestamp)
      comment: "Month when wafer processing completed"
  measures:
    - name: "total_wafers"
      expr: COUNT(1)
      comment: "Total number of individual wafers"
    - name: "total_expected_die"
      expr: SUM(CAST(expected_die_count AS DOUBLE))
      comment: "Total expected die count across all wafers"
    - name: "total_good_die"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total good die count across all wafers"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all wafers"
    - name: "total_critical_defect_count"
      expr: SUM(CAST(critical_defect_count AS DOUBLE))
      comment: "Total critical defect count across all wafers"
    - name: "avg_resistivity_ohm_cm"
      expr: AVG(CAST(resistivity_ohm_cm AS DOUBLE))
      comment: "Average wafer resistivity in ohm-centimeters"
    - name: "avg_thickness_um"
      expr: AVG(CAST(thickness_um AS DOUBLE))
      comment: "Average wafer thickness in micrometers"
    - name: "avg_epitaxial_thickness_um"
      expr: AVG(CAST(epitaxial_thickness_um AS DOUBLE))
      comment: "Average epitaxial layer thickness in micrometers"
    - name: "avg_epitaxial_resistivity_ohm_cm"
      expr: AVG(CAST(epitaxial_resistivity_ohm_cm AS DOUBLE))
      comment: "Average epitaxial layer resistivity in ohm-centimeters"
    - name: "wafers_with_epitaxial_layer"
      expr: SUM(CASE WHEN epitaxial_layer_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of wafers with epitaxial layers"
    - name: "distinct_lots"
      expr: COUNT(DISTINCT fabrication_wafer_lot_id)
      comment: "Number of distinct wafer lots"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of distinct fabrication facilities"
    - name: "distinct_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct IC design projects"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`fabrication_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity, utilization, and operational performance metrics"
  source: "`semiconductors_ecm`.`fabrication`.`work_center`"
  dimensions:
    - name: "work_center_type"
      expr: work_center_type
      comment: "Type of work center (lithography, etch, deposition, etc.)"
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current status of the work center"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status (running, idle, maintenance, down)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status"
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating of the work center"
    - name: "is_automated"
      expr: is_automated
      comment: "Indicates whether work center is fully automated"
    - name: "fab_line"
      expr: fab_line
      comment: "Fabrication line identifier"
    - name: "location"
      expr: location
      comment: "Physical location within the facility"
    - name: "shift_schedule"
      expr: shift_schedule
      comment: "Shift schedule configuration"
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers"
    - name: "automated_work_centers"
      expr: SUM(CASE WHEN is_automated = TRUE THEN 1 ELSE 0 END)
      comment: "Number of fully automated work centers"
    - name: "total_capacity_wafers_per_hour"
      expr: SUM(CAST(capacity_wafers_per_hour AS DOUBLE))
      comment: "Total capacity in wafers per hour across all work centers"
    - name: "avg_capacity_wafers_per_hour"
      expr: AVG(CAST(capacity_wafers_per_hour AS DOUBLE))
      comment: "Average capacity per work center in wafers per hour"
    - name: "total_area_sq_m"
      expr: SUM(CAST(area_sq_m AS DOUBLE))
      comment: "Total work center area in square meters"
    - name: "avg_area_sq_m"
      expr: AVG(CAST(area_sq_m AS DOUBLE))
      comment: "Average work center area in square meters"
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kilowatt-hours"
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per work center in kilowatt-hours"
    - name: "avg_temperature_c"
      expr: AVG(CAST(temperature_c AS DOUBLE))
      comment: "Average operating temperature in celsius"
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity percentage"
    - name: "total_equipment_count"
      expr: SUM(CAST(equipment_count AS DOUBLE))
      comment: "Total equipment count across all work centers"
    - name: "avg_equipment_count"
      expr: AVG(CAST(equipment_count AS DOUBLE))
      comment: "Average equipment count per work center"
    - name: "distinct_facilities"
      expr: COUNT(DISTINCT fab_facility_id)
      comment: "Number of distinct fabrication facilities"
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of distinct cost centers"
$$;