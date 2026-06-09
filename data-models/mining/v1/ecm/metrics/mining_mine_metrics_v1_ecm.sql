-- Metric views for domain: mine | Business: Mining | Version: 1 | Generated on: 2026-05-05 10:43:42

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic production planning and execution KPIs tracking planned vs actual ore/waste movement, strip ratios, and operational efficiency metrics that drive mine sequencing and resource allocation decisions"
  source: "`mining_ecm`.`mine`.`production_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the production schedule (e.g., Draft, Approved, Active, Completed)"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of production schedule (e.g., Annual, Quarterly, Monthly, Weekly)"
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method employed (e.g., Open Pit, Underground, Sublevel Stoping)"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Primary commodity being extracted (e.g., Iron Ore, Copper, Coal, Lithium)"
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification category (e.g., Measured, Indicated, Inferred)"
    - name: "schedule_year"
      expr: YEAR(period_start_date)
      comment: "Year of the production schedule period start"
    - name: "schedule_quarter"
      expr: CONCAT('Q', QUARTER(period_start_date))
      comment: "Quarter of the production schedule period start"
    - name: "schedule_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the production schedule period start"
    - name: "is_lom_schedule"
      expr: is_lom_schedule
      comment: "Flag indicating if this is a Life of Mine schedule"
  measures:
    - name: "total_planned_ore_tonnes"
      expr: SUM(CAST(planned_ore_tonnes AS DOUBLE))
      comment: "Total planned ore tonnes to be extracted - primary production target metric"
    - name: "total_planned_waste_tonnes"
      expr: SUM(CAST(planned_waste_tonnes AS DOUBLE))
      comment: "Total planned waste tonnes to be moved - key cost driver metric"
    - name: "total_planned_material_tonnes"
      expr: SUM(CAST(planned_total_material_tonnes AS DOUBLE))
      comment: "Total planned material movement (ore + waste) - overall mining capacity metric"
    - name: "avg_planned_strip_ratio"
      expr: AVG(CAST(planned_strip_ratio AS DOUBLE))
      comment: "Average planned strip ratio (waste:ore) - critical mining economics indicator"
    - name: "avg_target_head_grade"
      expr: AVG(CAST(target_head_grade AS DOUBLE))
      comment: "Average target head grade percentage - ore quality metric driving revenue"
    - name: "avg_planned_recovery_rate_pct"
      expr: AVG(CAST(planned_recovery_rate_pct AS DOUBLE))
      comment: "Average planned recovery rate percentage - metallurgical efficiency metric"
    - name: "total_planned_opex_usd"
      expr: SUM(CAST(planned_opex_usd AS DOUBLE))
      comment: "Total planned operating expenditure in USD - operational cost metric"
    - name: "total_planned_capex_usd"
      expr: SUM(CAST(planned_capex_usd AS DOUBLE))
      comment: "Total planned capital expenditure in USD - investment metric"
    - name: "total_planned_drill_metres"
      expr: SUM(CAST(planned_drill_metres AS DOUBLE))
      comment: "Total planned drilling metres - drilling productivity metric"
    - name: "total_planned_blast_count"
      expr: SUM(CAST(planned_blast_count AS BIGINT))
      comment: "Total planned number of blasts - blasting activity metric"
    - name: "avg_planned_dilution_pct"
      expr: AVG(CAST(planned_dilution_pct AS DOUBLE))
      comment: "Average planned dilution percentage - ore quality control metric"
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Number of production schedule records - planning granularity metric"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_material_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational material movement KPIs tracking actual ore and waste haulage, payload efficiency, cycle times, and reconciliation status - critical for daily production monitoring and equipment utilization"
  source: "`mining_ecm`.`mine`.`material_movement`"
  dimensions:
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the material movement record (e.g., Completed, In Progress, Cancelled)"
    - name: "movement_type"
      expr: movement_type
      comment: "Type of material movement (e.g., Ore to ROM, Waste to Dump, Rehandle)"
    - name: "material_type"
      expr: material_type
      comment: "Classification of material moved (e.g., Ore, Waste, Overburden, Topsoil)"
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method used for this movement (e.g., Open Pit, Underground)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used (e.g., Truck, Conveyor, Rail)"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for ore movements"
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating if the movement has been reconciled against survey data"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift when movement occurred"
    - name: "movement_year"
      expr: YEAR(shift_date)
      comment: "Year of the material movement"
    - name: "movement_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the material movement"
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source system that captured the movement data (e.g., FMS, Dispatch, Manual)"
  measures:
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_tonnes AS DOUBLE))
      comment: "Total payload tonnes moved - primary production volume metric"
    - name: "total_tonnes_loaded"
      expr: SUM(CAST(tonnes_loaded AS DOUBLE))
      comment: "Total tonnes loaded at source - loading productivity metric"
    - name: "total_tonnes_delivered"
      expr: SUM(CAST(tonnes_delivered AS DOUBLE))
      comment: "Total tonnes delivered at destination - delivery accuracy metric"
    - name: "total_dry_tonnes"
      expr: SUM(CAST(dry_tonnes AS DOUBLE))
      comment: "Total dry tonnes (moisture-adjusted) - revenue-quality metric"
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average cycle time in minutes - haulage efficiency metric"
    - name: "avg_estimated_grade_pct"
      expr: AVG(CAST(estimated_grade_pct AS DOUBLE))
      comment: "Average estimated ore grade percentage - ore quality metric"
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content percentage - material quality metric"
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage - ore contamination metric"
    - name: "avg_strip_ratio_contribution"
      expr: AVG(CAST(strip_ratio_contribution AS DOUBLE))
      comment: "Average strip ratio contribution - mining economics metric"
    - name: "movement_count"
      expr: COUNT(1)
      comment: "Number of material movement records - activity volume metric"
    - name: "reconciled_movement_count"
      expr: SUM(CASE WHEN is_reconciled = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reconciled movements - data quality metric"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_blast_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blasting performance KPIs tracking explosive usage, fragmentation outcomes, safety compliance, and powder factors - essential for optimizing blast design and controlling mining costs"
  source: "`mining_ecm`.`mine`.`blast_execution`"
  dimensions:
    - name: "blast_status"
      expr: blast_status
      comment: "Status of the blast execution (e.g., Planned, Approved, Fired, Completed)"
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method for the blast (e.g., Open Pit, Underground)"
    - name: "initiation_system_type"
      expr: initiation_system_type
      comment: "Type of initiation system used (e.g., Electronic, Non-electric, Shock Tube)"
    - name: "exclusion_zone_compliant"
      expr: exclusion_zone_compliant
      comment: "Flag indicating if exclusion zone protocols were followed"
    - name: "misfire_resolved"
      expr: misfire_resolved
      comment: "Flag indicating if any misfires were successfully resolved"
    - name: "blast_year"
      expr: YEAR(detonation_timestamp)
      comment: "Year of blast detonation"
    - name: "blast_month"
      expr: DATE_TRUNC('MONTH', detonation_timestamp)
      comment: "Month of blast detonation"
  measures:
    - name: "total_blasted_rock_mass_t"
      expr: SUM(CAST(blasted_rock_mass_t AS DOUBLE))
      comment: "Total rock mass blasted in tonnes - primary blasting output metric"
    - name: "total_ore_tonnes_blasted"
      expr: SUM(CAST(ore_tonnes_blasted AS DOUBLE))
      comment: "Total ore tonnes blasted - ore production metric"
    - name: "total_waste_tonnes_blasted"
      expr: SUM(CAST(waste_tonnes_blasted AS DOUBLE))
      comment: "Total waste tonnes blasted - waste movement metric"
    - name: "total_actual_explosive_mass_kg"
      expr: SUM(CAST(actual_explosive_mass_kg AS DOUBLE))
      comment: "Total actual explosive mass used in kg - explosive consumption metric"
    - name: "total_planned_explosive_mass_kg"
      expr: SUM(CAST(planned_explosive_mass_kg AS DOUBLE))
      comment: "Total planned explosive mass in kg - explosive planning metric"
    - name: "avg_powder_factor_kg_per_t"
      expr: AVG(CAST(powder_factor_kg_per_t AS DOUBLE))
      comment: "Average powder factor (kg explosive per tonne rock) - blasting efficiency metric"
    - name: "avg_fragmentation_p80_mm"
      expr: AVG(CAST(fragmentation_p80_mm AS DOUBLE))
      comment: "Average P80 fragmentation size in mm - fragmentation quality metric"
    - name: "avg_fragmentation_target_p80_mm"
      expr: AVG(CAST(fragmentation_target_p80_mm AS DOUBLE))
      comment: "Average target P80 fragmentation size in mm - fragmentation design metric"
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage from blasting - ore quality impact metric"
    - name: "avg_peak_particle_velocity_mms"
      expr: AVG(CAST(peak_particle_velocity_mms AS DOUBLE))
      comment: "Average peak particle velocity in mm/s - ground vibration safety metric"
    - name: "avg_airblast_overpressure_db"
      expr: AVG(CAST(airblast_overpressure_db AS DOUBLE))
      comment: "Average airblast overpressure in dB - noise safety metric"
    - name: "total_misfire_count"
      expr: SUM(CAST(misfire_count AS BIGINT))
      comment: "Total number of misfires - safety and reliability metric"
    - name: "blast_count"
      expr: COUNT(1)
      comment: "Number of blast executions - blasting activity metric"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level operational performance KPIs tracking ore/waste production, equipment utilization, safety incidents, and delay analysis - critical for daily operational management and continuous improvement"
  source: "`mining_ecm`.`mine`.`shift_report`"
  dimensions:
    - name: "shift_status"
      expr: shift_status
      comment: "Status of the shift report (e.g., Draft, Submitted, Approved)"
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., Day, Night, Maintenance)"
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method employed during the shift"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during the shift (e.g., Clear, Rain, Storm)"
    - name: "is_daily_rollup_complete"
      expr: is_daily_rollup_complete
      comment: "Flag indicating if daily rollup aggregation is complete"
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift"
    - name: "shift_year"
      expr: YEAR(shift_date)
      comment: "Year of the shift"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift"
  measures:
    - name: "total_ore_mined_tonnes"
      expr: SUM(CAST(ore_mined_tonnes AS DOUBLE))
      comment: "Total ore mined in tonnes - primary production output metric"
    - name: "total_ore_mined_target_tonnes"
      expr: SUM(CAST(ore_mined_target_tonnes AS DOUBLE))
      comment: "Total ore mining target in tonnes - production planning metric"
    - name: "total_waste_moved_tonnes"
      expr: SUM(CAST(waste_moved_tonnes AS DOUBLE))
      comment: "Total waste moved in tonnes - waste movement metric"
    - name: "total_waste_moved_target_tonnes"
      expr: SUM(CAST(waste_moved_target_tonnes AS DOUBLE))
      comment: "Total waste movement target in tonnes - waste planning metric"
    - name: "total_metres_drilled"
      expr: SUM(CAST(metres_drilled AS DOUBLE))
      comment: "Total metres drilled - drilling productivity metric"
    - name: "total_metres_drilled_target"
      expr: SUM(CAST(metres_drilled_target AS DOUBLE))
      comment: "Total drilling target in metres - drilling planning metric"
    - name: "total_metres_developed"
      expr: SUM(CAST(metres_developed AS DOUBLE))
      comment: "Total metres of underground development - development productivity metric"
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilization percentage - equipment efficiency metric"
    - name: "total_equipment_operating_hours"
      expr: SUM(CAST(equipment_operating_hours AS DOUBLE))
      comment: "Total equipment operating hours - equipment usage metric"
    - name: "total_equipment_scheduled_hours"
      expr: SUM(CAST(equipment_scheduled_hours AS DOUBLE))
      comment: "Total equipment scheduled hours - equipment availability metric"
    - name: "total_breakdown_delay_hours"
      expr: SUM(CAST(breakdown_delay_hours AS DOUBLE))
      comment: "Total breakdown delay hours - unplanned downtime metric"
    - name: "total_planned_maintenance_delay_hours"
      expr: SUM(CAST(planned_maintenance_delay_hours AS DOUBLE))
      comment: "Total planned maintenance delay hours - planned downtime metric"
    - name: "total_weather_delay_hours"
      expr: SUM(CAST(weather_delay_hours AS DOUBLE))
      comment: "Total weather delay hours - weather impact metric"
    - name: "avg_strip_ratio_actual"
      expr: AVG(CAST(strip_ratio_actual AS DOUBLE))
      comment: "Average actual strip ratio - mining economics metric"
    - name: "avg_ore_grade_fe_pct"
      expr: AVG(CAST(ore_grade_fe_pct AS DOUBLE))
      comment: "Average iron ore grade percentage - ore quality metric"
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage - ore quality control metric"
    - name: "total_blasts_fired_count"
      expr: SUM(CAST(blasts_fired_count AS BIGINT))
      comment: "Total number of blasts fired - blasting activity metric"
    - name: "total_lost_time_injury_count"
      expr: SUM(CAST(lost_time_injury_count AS BIGINT))
      comment: "Total lost time injuries - critical safety metric"
    - name: "total_safety_incident_count"
      expr: SUM(CAST(safety_incident_count AS BIGINT))
      comment: "Total safety incidents - safety performance metric"
    - name: "shift_count"
      expr: COUNT(1)
      comment: "Number of shift reports - operational activity metric"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_production_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production reconciliation KPIs comparing actual vs model tonnes and grades, tracking variance factors (F1/F2/F3), and identifying model update requirements - essential for resource model accuracy and reserve confidence"
  source: "`mining_ecm`.`mine`.`production_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation record (e.g., Draft, Approved, Finalized)"
    - name: "period_type"
      expr: period_type
      comment: "Type of reconciliation period (e.g., Monthly, Quarterly, Annual)"
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity being reconciled"
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification (e.g., Measured, Indicated, Inferred)"
    - name: "ore_source_type"
      expr: ore_source_type
      comment: "Type of ore source (e.g., Pit, Stope, Stockpile)"
    - name: "variance_category"
      expr: variance_category
      comment: "Category of variance (e.g., Acceptable, Investigate, Critical)"
    - name: "model_update_required"
      expr: model_update_required
      comment: "Flag indicating if resource model update is required"
    - name: "survey_method"
      expr: survey_method
      comment: "Survey method used for actual measurement (e.g., Drone, GPS, Total Station)"
    - name: "reconciliation_year"
      expr: YEAR(reconciliation_period_start)
      comment: "Year of reconciliation period start"
    - name: "reconciliation_month"
      expr: DATE_TRUNC('MONTH', reconciliation_period_start)
      comment: "Month of reconciliation period start"
  measures:
    - name: "total_actual_tonnes"
      expr: SUM(CAST(actual_tonnes AS DOUBLE))
      comment: "Total actual tonnes mined - actual production metric"
    - name: "total_model_tonnes"
      expr: SUM(CAST(model_tonnes AS DOUBLE))
      comment: "Total model-predicted tonnes - model prediction metric"
    - name: "avg_actual_grade"
      expr: AVG(CAST(actual_grade AS DOUBLE))
      comment: "Average actual grade - actual ore quality metric"
    - name: "avg_model_grade"
      expr: AVG(CAST(model_grade AS DOUBLE))
      comment: "Average model-predicted grade - model prediction metric"
    - name: "total_actual_metal_content"
      expr: SUM(CAST(actual_metal_content AS DOUBLE))
      comment: "Total actual metal content - actual metal production metric"
    - name: "total_model_metal_content"
      expr: SUM(CAST(model_metal_content AS DOUBLE))
      comment: "Total model-predicted metal content - model prediction metric"
    - name: "avg_tonnes_variance_pct"
      expr: AVG(CAST(tonnes_variance_pct AS DOUBLE))
      comment: "Average tonnes variance percentage - tonnage reconciliation accuracy metric"
    - name: "avg_grade_variance_pct"
      expr: AVG(CAST(grade_variance_pct AS DOUBLE))
      comment: "Average grade variance percentage - grade reconciliation accuracy metric"
    - name: "avg_f1_factor"
      expr: AVG(CAST(f1_factor AS DOUBLE))
      comment: "Average F1 factor (mining loss/gain) - mining recovery metric"
    - name: "avg_f2_factor"
      expr: AVG(CAST(f2_factor AS DOUBLE))
      comment: "Average F2 factor (dilution) - ore contamination metric"
    - name: "avg_f3_factor"
      expr: AVG(CAST(f3_factor AS DOUBLE))
      comment: "Average F3 factor (grade estimation error) - model accuracy metric"
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage - ore quality control metric"
    - name: "avg_ore_recovery_pct"
      expr: AVG(CAST(ore_recovery_pct AS DOUBLE))
      comment: "Average ore recovery percentage - mining efficiency metric"
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Number of reconciliation records - reconciliation activity metric"
    - name: "model_update_required_count"
      expr: SUM(CASE WHEN model_update_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reconciliations requiring model update - model maintenance metric"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_lom_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Life of Mine strategic planning KPIs tracking reserves, mine life, strip ratios, financial metrics (NPV, IRR, AISC), and capital/operating costs - essential for investment decisions and long-term mine strategy"
  source: "`mining_ecm`.`mine`.`lom_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the LOM plan (e.g., Draft, Approved, Active, Superseded)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of LOM plan (e.g., Feasibility, Optimization, Budget)"
    - name: "mining_method"
      expr: mining_method
      comment: "Primary mining method for the LOM plan"
    - name: "commodity"
      expr: commodity
      comment: "Primary commodity in the LOM plan"
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification basis (e.g., Measured, Indicated)"
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard used (e.g., JORC, NI 43-101, SAMREC)"
    - name: "plan_year"
      expr: YEAR(plan_start_date)
      comment: "Year of LOM plan start"
  measures:
    - name: "total_ore_reserve_mt"
      expr: SUM(CAST(total_ore_reserve_mt AS DOUBLE))
      comment: "Total ore reserve in million tonnes - reserve base metric"
    - name: "total_waste_mt"
      expr: SUM(CAST(total_waste_mt AS DOUBLE))
      comment: "Total waste in million tonnes - waste movement metric"
    - name: "total_proved_reserve_mt"
      expr: SUM(CAST(proved_reserve_mt AS DOUBLE))
      comment: "Total proved reserve in million tonnes - high-confidence reserve metric"
    - name: "total_probable_reserve_mt"
      expr: SUM(CAST(probable_reserve_mt AS DOUBLE))
      comment: "Total probable reserve in million tonnes - moderate-confidence reserve metric"
    - name: "avg_lom_strip_ratio"
      expr: AVG(CAST(lom_strip_ratio AS DOUBLE))
      comment: "Average life-of-mine strip ratio - mining economics metric"
    - name: "avg_ore_grade"
      expr: AVG(CAST(average_ore_grade AS DOUBLE))
      comment: "Average ore grade across LOM - ore quality metric"
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average cutoff grade - economic threshold metric"
    - name: "avg_planned_recovery_rate_pct"
      expr: AVG(CAST(planned_recovery_rate_pct AS DOUBLE))
      comment: "Average planned recovery rate percentage - metallurgical efficiency metric"
    - name: "avg_annual_ore_mt"
      expr: AVG(CAST(average_annual_ore_mt AS DOUBLE))
      comment: "Average annual ore production in million tonnes - production rate metric"
    - name: "avg_peak_annual_ore_mt"
      expr: AVG(CAST(peak_annual_ore_mt AS DOUBLE))
      comment: "Average peak annual ore production in million tonnes - peak capacity metric"
    - name: "total_capex_musd"
      expr: SUM(CAST(total_capex_musd AS DOUBLE))
      comment: "Total capital expenditure in million USD - investment requirement metric"
    - name: "total_opex_musd"
      expr: SUM(CAST(total_opex_musd AS DOUBLE))
      comment: "Total operating expenditure in million USD - operating cost metric"
    - name: "avg_npv_musd"
      expr: AVG(CAST(npv_musd AS DOUBLE))
      comment: "Average net present value in million USD - project value metric"
    - name: "avg_irr_pct"
      expr: AVG(CAST(irr_pct AS DOUBLE))
      comment: "Average internal rate of return percentage - investment return metric"
    - name: "avg_aisc_usd_per_t"
      expr: AVG(CAST(aisc_usd_per_t AS DOUBLE))
      comment: "Average all-in sustaining cost per tonne in USD - cost competitiveness metric"
    - name: "avg_c1_cash_cost_usd_per_t"
      expr: AVG(CAST(c1_cash_cost_usd_per_t AS DOUBLE))
      comment: "Average C1 cash cost per tonne in USD - operating cost metric"
    - name: "lom_plan_count"
      expr: COUNT(1)
      comment: "Number of LOM plans - planning scenario metric"
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_rom_stockpile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ROM stockpile inventory and quality KPIs tracking current inventory, head grades, moisture content, and reconciliation variance - critical for production planning and blending optimization"
  source: "`mining_ecm`.`mine`.`rom_stockpile`"
  dimensions:
    - name: "stockpile_status"
      expr: stockpile_status
      comment: "Status of the ROM stockpile (e.g., Active, Inactive, Depleted)"
    - name: "stockpile_type"
      expr: stockpile_type
      comment: "Type of stockpile (e.g., Low Grade, High Grade, Blended)"
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method that feeds the stockpile"
    - name: "geotechnical_zone"
      expr: geotechnical_zone
      comment: "Geotechnical zone classification"
  measures:
    - name: "total_current_inventory_t"
      expr: SUM(CAST(current_inventory_t AS DOUBLE))
      comment: "Total current inventory in tonnes - inventory level metric"
    - name: "total_design_capacity_t"
      expr: SUM(CAST(design_capacity_t AS DOUBLE))
      comment: "Total design capacity in tonnes - capacity metric"
    - name: "total_scheduled_tonnes_t"
      expr: SUM(CAST(scheduled_tonnes_t AS DOUBLE))
      comment: "Total scheduled tonnes - planning metric"
    - name: "avg_head_grade_primary_pct"
      expr: AVG(CAST(head_grade_primary_pct AS DOUBLE))
      comment: "Average primary head grade percentage - ore quality metric"
    - name: "avg_head_grade_fe_pct"
      expr: AVG(CAST(head_grade_fe_pct AS DOUBLE))
      comment: "Average iron head grade percentage - iron ore quality metric"
    - name: "avg_head_grade_cu_pct"
      expr: AVG(CAST(head_grade_cu_pct AS DOUBLE))
      comment: "Average copper head grade percentage - copper ore quality metric"
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_pct AS DOUBLE))
      comment: "Average moisture content percentage - material quality metric"
    - name: "avg_bulk_density_t_m3"
      expr: AVG(CAST(bulk_density_t_m3 AS DOUBLE))
      comment: "Average bulk density in tonnes per cubic metre - density metric"
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage - ore quality control metric"
    - name: "avg_ore_recovery_pct"
      expr: AVG(CAST(ore_recovery_pct AS DOUBLE))
      comment: "Average ore recovery percentage - recovery efficiency metric"
    - name: "total_reconciliation_variance_t"
      expr: SUM(CAST(reconciliation_variance_t AS DOUBLE))
      comment: "Total reconciliation variance in tonnes - inventory accuracy metric"
    - name: "total_surveyed_volume_m3"
      expr: SUM(CAST(surveyed_volume_m3 AS DOUBLE))
      comment: "Total surveyed volume in cubic metres - volume measurement metric"
    - name: "avg_cut_off_grade_pct"
      expr: AVG(CAST(cut_off_grade_pct AS DOUBLE))
      comment: "Average cutoff grade percentage - economic threshold metric"
    - name: "stockpile_count"
      expr: COUNT(1)
      comment: "Number of ROM stockpiles - stockpile inventory metric"
$$;