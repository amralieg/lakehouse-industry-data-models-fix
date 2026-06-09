-- Metric views for domain: mine | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_shift_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational shift-level production and efficiency KPIs. Tracks ore mined vs target, waste movement, equipment utilisation, drilling performance, and delay analysis per shift. Primary steering dashboard for mine operations managers and site GMs."
  source: "`mining_ecm`.`mine`.`shift_report`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Calendar date of the shift, used for daily and weekly trend analysis."
    - name: "shift_type"
      expr: shift_type
      comment: "Day or night shift classification, enabling shift-pattern performance comparison."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method applied during the shift (e.g. open cut, underground), for method-level benchmarking."
    - name: "shift_status"
      expr: shift_status
      comment: "Current status of the shift report (e.g. draft, approved, closed), used to filter to finalised records."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Recorded weather condition during the shift, enabling weather-impact analysis on production."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Foreign key to mine site, enabling site-level aggregation and cross-site benchmarking."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Foreign key to pit or underground level, enabling pit-level production drill-down."
    - name: "cost_centre_id"
      expr: cost_centre_id
      comment: "Cost centre responsible for the shift, enabling financial accountability alignment."
  measures:
    - name: "total_ore_mined_tonnes"
      expr: SUM(CAST(ore_mined_tonnes AS DOUBLE))
      comment: "Total ore tonnes mined across all shifts in the period. Core production volume KPI used in daily, weekly, and monthly production reporting."
    - name: "total_ore_mined_target_tonnes"
      expr: SUM(CAST(ore_mined_target_tonnes AS DOUBLE))
      comment: "Total planned ore tonnes target for the period. Used as the denominator for production achievement rate."
    - name: "total_waste_moved_tonnes"
      expr: SUM(CAST(waste_moved_tonnes AS DOUBLE))
      comment: "Total waste rock moved in the period. Drives strip ratio calculation and waste-handling cost management."
    - name: "total_waste_moved_target_tonnes"
      expr: SUM(CAST(waste_moved_target_tonnes AS DOUBLE))
      comment: "Total planned waste movement target. Used to assess waste movement schedule adherence."
    - name: "avg_strip_ratio_actual"
      expr: AVG(CAST(strip_ratio_actual AS DOUBLE))
      comment: "Average actual strip ratio (waste:ore) across shifts. A rising strip ratio signals increasing mining cost per tonne of ore and is a key cost driver for executive review."
    - name: "avg_equipment_utilisation_pct"
      expr: AVG(CAST(equipment_utilisation_pct AS DOUBLE))
      comment: "Average equipment utilisation percentage across shifts. Low utilisation directly reduces production throughput and increases unit cost — a primary fleet management KPI."
    - name: "total_equipment_operating_hours"
      expr: SUM(CAST(equipment_operating_hours AS DOUBLE))
      comment: "Total productive equipment hours in the period. Used to assess fleet productivity and benchmark against scheduled hours."
    - name: "total_equipment_scheduled_hours"
      expr: SUM(CAST(equipment_scheduled_hours AS DOUBLE))
      comment: "Total scheduled equipment hours in the period. Denominator for equipment availability and utilisation rate calculations."
    - name: "total_breakdown_delay_hours"
      expr: SUM(CAST(breakdown_delay_hours AS DOUBLE))
      comment: "Total hours lost to unplanned equipment breakdowns. A leading indicator of maintenance effectiveness and production risk."
    - name: "total_weather_delay_hours"
      expr: SUM(CAST(weather_delay_hours AS DOUBLE))
      comment: "Total hours lost to weather events. Used in production variance analysis and risk planning."
    - name: "total_planned_maintenance_delay_hours"
      expr: SUM(CAST(planned_maintenance_delay_hours AS DOUBLE))
      comment: "Total hours lost to planned maintenance shutdowns. Enables assessment of maintenance scheduling impact on production."
    - name: "total_metres_drilled"
      expr: SUM(CAST(metres_drilled AS DOUBLE))
      comment: "Total metres drilled across shifts. Drilling progress is a leading indicator of future blast and ore availability."
    - name: "total_metres_drilled_target"
      expr: SUM(CAST(metres_drilled_target AS DOUBLE))
      comment: "Total planned drilling metres target. Used to compute drilling schedule adherence rate."
    - name: "total_metres_developed"
      expr: SUM(CAST(metres_developed AS DOUBLE))
      comment: "Total development metres achieved (underground). Critical for underground mine access and future stope availability."
    - name: "avg_ore_grade_fe_pct"
      expr: AVG(CAST(ore_grade_fe_pct AS DOUBLE))
      comment: "Average iron ore grade (Fe%) across shifts. Grade variability directly impacts product quality, pricing, and processing efficiency."
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average ore dilution percentage across shifts. High dilution reduces effective ore grade and increases processing cost per unit of metal."
    - name: "shift_count"
      expr: COUNT(1)
      comment: "Total number of shift reports in the period. Used as the baseline denominator for per-shift averages and coverage checks."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_material_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular material movement KPIs covering ore and waste tonnes, payload efficiency, grade, dilution, and cycle time. Used by mine planners and operations managers to track actual vs planned material flow and identify haulage inefficiencies."
  source: "`mining_ecm`.`mine`.`material_movement`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the material movement, enabling daily production trend analysis."
    - name: "material_type"
      expr: material_type
      comment: "Classification of material moved (ore, waste, low-grade, etc.), essential for separating ore and waste movement KPIs."
    - name: "movement_type"
      expr: movement_type
      comment: "Type of movement event (e.g. load, dump, rehandle), used to filter primary production movements from rehandle."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method associated with the movement, enabling method-level productivity benchmarking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (truck, conveyor, rail), used to analyse haulage cost and efficiency by mode."
    - name: "movement_status"
      expr: movement_status
      comment: "Status of the movement record (e.g. confirmed, pending reconciliation), used to filter to finalised data."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Boolean flag indicating whether the movement has been reconciled against survey data. Used to assess data quality and completeness."
    - name: "area_id"
      expr: area_id
      comment: "Source mining area, enabling area-level production and grade analysis."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Pit or underground level of origin, enabling pit-level material flow analysis."
    - name: "geological_domain_id"
      expr: geological_domain_id
      comment: "Geological domain of the source material, enabling grade and hardness analysis by domain."
  measures:
    - name: "total_tonnes_loaded"
      expr: SUM(CAST(tonnes_loaded AS DOUBLE))
      comment: "Total tonnes loaded at source. Primary production volume measure for material movement tracking."
    - name: "total_tonnes_delivered"
      expr: SUM(CAST(tonnes_delivered AS DOUBLE))
      comment: "Total tonnes delivered to destination (ROM pad, waste dump, etc.). Compared against tonnes loaded to identify in-transit losses."
    - name: "total_dry_tonnes"
      expr: SUM(CAST(dry_tonnes AS DOUBLE))
      comment: "Total dry tonnes moved, adjusting for moisture content. Used for accurate mass balance and royalty calculations."
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_tonnes AS DOUBLE))
      comment: "Total payload tonnes across all movements. Used to assess truck payload efficiency against nominal capacity."
    - name: "avg_payload_tonnes"
      expr: AVG(CAST(payload_tonnes AS DOUBLE))
      comment: "Average payload per movement. Compared against nominal payload to identify under-loading, which directly increases unit haulage cost."
    - name: "avg_estimated_grade_pct"
      expr: AVG(CAST(estimated_grade_pct AS DOUBLE))
      comment: "Average estimated ore grade of material moved. Tracks grade delivered to ROM vs mine plan grade, a key reconciliation input."
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage across movements. Dilution above plan reduces effective grade and increases processing cost per unit of metal."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content of moved material. High moisture increases payload weight without adding ore value and affects processing performance."
    - name: "avg_cycle_time_minutes"
      expr: AVG(CAST(cycle_time_minutes AS DOUBLE))
      comment: "Average haulage cycle time in minutes. A key fleet productivity metric — longer cycle times reduce tonnes per hour and increase unit cost."
    - name: "avg_strip_ratio_contribution"
      expr: AVG(CAST(strip_ratio_contribution AS DOUBLE))
      comment: "Average strip ratio contribution per movement record. Tracks the waste-to-ore ratio trend at movement level, informing cost-per-tonne forecasts."
    - name: "movement_count"
      expr: COUNT(1)
      comment: "Total number of material movement events. Used as baseline for per-movement averages and to validate data completeness."
    - name: "reconciled_movement_count"
      expr: COUNT(CASE WHEN is_reconciled = TRUE THEN 1 END)
      comment: "Count of movements that have been reconciled against survey data. Low reconciliation rates indicate data quality risk in production reporting."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_haulage_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Haulage fleet productivity and efficiency KPIs at the individual cycle level. Enables fleet managers and mine controllers to identify payload shortfalls, overloading events, rehandle waste, and fuel consumption trends that drive unit haulage cost."
  source: "`mining_ecm`.`mine`.`haulage_cycle`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date of the haulage cycle, enabling daily fleet productivity trending."
    - name: "material_type"
      expr: material_type
      comment: "Material classification (ore, waste, low-grade), used to separate ore haulage KPIs from waste movement."
    - name: "dump_type"
      expr: dump_type
      comment: "Destination dump type (ROM pad, waste dump, crusher), used to analyse material routing efficiency."
    - name: "cycle_status"
      expr: cycle_status
      comment: "Status of the haulage cycle record, used to filter to completed and validated cycles."
    - name: "is_overloaded"
      expr: is_overloaded
      comment: "Boolean flag for overloaded trucks. Overloading accelerates tyre and suspension wear, increasing maintenance cost and safety risk."
    - name: "is_rehandle"
      expr: is_rehandle
      comment: "Boolean flag indicating rehandle movements (material moved more than once). Rehandle is non-productive cost that should be minimised."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Source pit or level, enabling pit-level haulage productivity analysis."
    - name: "area_id"
      expr: area_id
      comment: "Source mining area, enabling area-level haulage efficiency benchmarking."
    - name: "data_source_system"
      expr: data_source_system
      comment: "Source FMS or dispatch system, used to assess data coverage and cross-system consistency."
  measures:
    - name: "total_payload_tonnes"
      expr: SUM(CAST(payload_tonnes AS DOUBLE))
      comment: "Total payload tonnes hauled across all cycles. Primary haulage throughput measure."
    - name: "avg_payload_tonnes"
      expr: AVG(CAST(payload_tonnes AS DOUBLE))
      comment: "Average payload per cycle. Compared against nominal payload to quantify under-loading losses — each tonne of under-loading is a direct productivity and cost inefficiency."
    - name: "avg_nominal_payload_tonnes"
      expr: AVG(CAST(nominal_payload_tonnes AS DOUBLE))
      comment: "Average nominal (design) payload capacity per cycle. Used as the benchmark for payload efficiency ratio calculations."
    - name: "total_fuel_consumption_litres"
      expr: SUM(CAST(fuel_consumption_litres AS DOUBLE))
      comment: "Total fuel consumed across all haulage cycles. Fuel is typically the largest single operating cost in open-cut mining — tracking consumption drives cost reduction initiatives."
    - name: "avg_fuel_consumption_litres"
      expr: AVG(CAST(fuel_consumption_litres AS DOUBLE))
      comment: "Average fuel consumption per haulage cycle. Enables identification of inefficient routes, operators, or equipment consuming above-benchmark fuel."
    - name: "avg_dilution_factor"
      expr: AVG(CAST(dilution_factor AS DOUBLE))
      comment: "Average dilution factor across haulage cycles. Dilution above plan reduces effective ore grade delivered to the ROM pad."
    - name: "avg_ore_grade_estimate"
      expr: AVG(CAST(ore_grade_estimate AS DOUBLE))
      comment: "Average estimated ore grade of material hauled. Tracks grade delivered to ROM vs mine plan, a key input to production reconciliation."
    - name: "overloaded_cycle_count"
      expr: COUNT(CASE WHEN is_overloaded = TRUE THEN 1 END)
      comment: "Number of overloaded haulage cycles. Overloading is a safety and equipment integrity risk — high counts trigger fleet management intervention."
    - name: "rehandle_cycle_count"
      expr: COUNT(CASE WHEN is_rehandle = TRUE THEN 1 END)
      comment: "Number of rehandle cycles (material moved more than once). Rehandle represents pure cost with no ore value addition — minimising it is a key operational efficiency target."
    - name: "total_cycle_count"
      expr: COUNT(1)
      comment: "Total number of haulage cycles completed. Baseline fleet productivity measure and denominator for per-cycle averages."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_blast_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blast execution performance KPIs covering fragmentation quality, explosive efficiency, safety compliance, and ore/waste yield per blast. Used by drill and blast engineers, mine planners, and HSE managers to optimise blast design and ensure regulatory compliance."
  source: "`mining_ecm`.`mine`.`blast_execution`"
  dimensions:
    - name: "blast_status"
      expr: blast_status
      comment: "Current status of the blast (e.g. planned, executed, misfired), used to filter to completed blasts for performance analysis."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method for the blast (open cut, underground), enabling method-level blast performance benchmarking."
    - name: "initiation_system_type"
      expr: initiation_system_type
      comment: "Type of initiation system used (electronic, shock tube, etc.), used to compare fragmentation and safety outcomes by system."
    - name: "exclusion_zone_compliant"
      expr: exclusion_zone_compliant
      comment: "Boolean flag for exclusion zone compliance. Non-compliant blasts are a critical safety and regulatory risk requiring immediate investigation."
    - name: "misfire_resolved"
      expr: misfire_resolved
      comment: "Boolean flag indicating whether any misfires were resolved. Unresolved misfires are a safety hazard that halts production."
    - name: "area_id"
      expr: area_id
      comment: "Mining area where the blast was executed, enabling area-level blast performance analysis."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Pit or level of the blast, enabling pit-level fragmentation and yield benchmarking."
    - name: "bench_id"
      expr: bench_id
      comment: "Bench where the blast was executed, enabling bench-level drill and blast optimisation."
  measures:
    - name: "total_ore_tonnes_blasted"
      expr: SUM(CAST(ore_tonnes_blasted AS DOUBLE))
      comment: "Total ore tonnes released by blasting. Primary blast productivity measure — directly feeds ROM stockpile availability."
    - name: "total_waste_tonnes_blasted"
      expr: SUM(CAST(waste_tonnes_blasted AS DOUBLE))
      comment: "Total waste tonnes blasted. Combined with ore tonnes blasted to compute blast-level strip ratio."
    - name: "total_blasted_rock_mass_t"
      expr: SUM(CAST(blasted_rock_mass_t AS DOUBLE))
      comment: "Total rock mass blasted (ore + waste). Used to assess explosive efficiency and blast scale."
    - name: "total_actual_explosive_mass_kg"
      expr: SUM(CAST(actual_explosive_mass_kg AS DOUBLE))
      comment: "Total explosive mass consumed across blasts. A major direct cost driver — tracking against plan identifies over/under-charging patterns."
    - name: "total_planned_explosive_mass_kg"
      expr: SUM(CAST(planned_explosive_mass_kg AS DOUBLE))
      comment: "Total planned explosive mass. Used as denominator for explosive consumption variance analysis."
    - name: "avg_powder_factor_kg_per_t"
      expr: AVG(CAST(powder_factor_kg_per_t AS DOUBLE))
      comment: "Average powder factor (kg explosive per tonne of rock). A key blast efficiency metric — high powder factor increases cost; low powder factor risks poor fragmentation and crusher throughput loss."
    - name: "avg_fragmentation_p80_mm"
      expr: AVG(CAST(fragmentation_p80_mm AS DOUBLE))
      comment: "Average actual P80 fragmentation size in mm. Coarse fragmentation (high P80) reduces crusher throughput and increases processing cost — a direct link between blast quality and plant performance."
    - name: "avg_fragmentation_target_p80_mm"
      expr: AVG(CAST(fragmentation_target_p80_mm AS DOUBLE))
      comment: "Average target P80 fragmentation size. Used as benchmark to assess whether blasts are achieving design fragmentation."
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average blast dilution percentage. Dilution above design reduces effective ore grade and increases processing cost per unit of metal."
    - name: "avg_peak_particle_velocity_mms"
      expr: AVG(CAST(peak_particle_velocity_mms AS DOUBLE))
      comment: "Average peak particle velocity (mm/s) from blast vibration monitoring. Exceeding regulatory PPV limits triggers community complaints and potential permit conditions — a key HSE and regulatory KPI."
    - name: "avg_airblast_overpressure_db"
      expr: AVG(CAST(airblast_overpressure_db AS DOUBLE))
      comment: "Average airblast overpressure in decibels. Regulatory limits apply — exceedances risk permit conditions and community relations impacts."
    - name: "non_compliant_exclusion_zone_count"
      expr: COUNT(CASE WHEN exclusion_zone_compliant = FALSE THEN 1 END)
      comment: "Number of blasts with exclusion zone non-compliance. Each non-compliant blast is a critical safety event requiring root cause analysis and corrective action."
    - name: "blast_count"
      expr: COUNT(1)
      comment: "Total number of blasts executed. Baseline measure for blast frequency and denominator for per-blast averages."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_production_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mine-to-mill production reconciliation KPIs comparing actual mined tonnes and grade against geological model predictions. The F1/F2/F3 reconciliation factors are the primary tool for assessing geological model accuracy, mining dilution, and processing recovery — critical for reserve confidence and financial reporting."
  source: "`mining_ecm`.`mine`.`production_reconciliation`"
  dimensions:
    - name: "reconciliation_period_start"
      expr: reconciliation_period_start
      comment: "Start date of the reconciliation period, used for monthly and quarterly reconciliation trend analysis."
    - name: "reconciliation_period_end"
      expr: reconciliation_period_end
      comment: "End date of the reconciliation period."
    - name: "period_type"
      expr: period_type
      comment: "Reconciliation period type (daily, monthly, quarterly, annual), used to filter to the appropriate reporting granularity."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of the reconciliation record (draft, approved, locked), used to filter to finalised reconciliations for reporting."
    - name: "ore_source_type"
      expr: ore_source_type
      comment: "Source type of ore (primary, rehandle, stockpile reclaim), enabling analysis of reconciliation performance by ore source."
    - name: "resource_classification"
      expr: resource_classification
      comment: "JORC/NI43-101 resource classification (Measured, Indicated, Inferred), used to assess model confidence by classification."
    - name: "variance_category"
      expr: variance_category
      comment: "Category of reconciliation variance (geological, mining, survey, processing), used to direct corrective action to the right function."
    - name: "grade_unit"
      expr: grade_unit
      comment: "Unit of grade measurement (%, g/t, ppm), used to ensure consistent grade comparisons across commodities."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site for the reconciliation, enabling cross-site model accuracy benchmarking."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Pit or level reconciled, enabling pit-level model accuracy analysis."
  measures:
    - name: "total_actual_tonnes"
      expr: SUM(CAST(actual_tonnes AS DOUBLE))
      comment: "Total actual mined tonnes as measured (survey, weightometer). The ground-truth production volume for the period."
    - name: "total_model_tonnes"
      expr: SUM(CAST(model_tonnes AS DOUBLE))
      comment: "Total geological model predicted tonnes for the same blocks. Used to compute the F1 tonnes reconciliation factor."
    - name: "avg_actual_grade"
      expr: AVG(CAST(actual_grade AS DOUBLE))
      comment: "Average actual ore grade achieved. Compared against model grade to assess geological model accuracy and identify grade risk."
    - name: "avg_model_grade"
      expr: AVG(CAST(model_grade AS DOUBLE))
      comment: "Average geological model predicted grade. Persistent over-prediction of grade is a reserve confidence risk requiring model update."
    - name: "total_actual_metal_content"
      expr: SUM(CAST(actual_metal_content AS DOUBLE))
      comment: "Total actual contained metal (tonnes of metal). The ultimate measure of value delivered from the mine — directly drives revenue."
    - name: "total_model_metal_content"
      expr: SUM(CAST(model_metal_content AS DOUBLE))
      comment: "Total model predicted contained metal. Used to compute the F3 (mine-to-model metal) reconciliation factor."
    - name: "avg_f1_factor"
      expr: AVG(CAST(f1_factor AS DOUBLE))
      comment: "Average F1 reconciliation factor (actual tonnes / model tonnes). F1 < 1.0 indicates the model over-predicted tonnes — a reserve write-down risk. Monitored by geologists and CFO."
    - name: "avg_f2_factor"
      expr: AVG(CAST(f2_factor AS DOUBLE))
      comment: "Average F2 reconciliation factor (actual grade / model grade). F2 < 1.0 indicates grade over-prediction — directly impacts revenue forecasts and offtake contract performance."
    - name: "avg_f3_factor"
      expr: AVG(CAST(f3_factor AS DOUBLE))
      comment: "Average F3 reconciliation factor (actual metal / model metal = F1 × F2). The composite mine-to-model reconciliation factor — the single most important number in reserve confidence assessment."
    - name: "avg_tonnes_variance_pct"
      expr: AVG(CAST(tonnes_variance_pct AS DOUBLE))
      comment: "Average percentage variance between actual and model tonnes. Persistent positive or negative bias triggers geological model review."
    - name: "avg_grade_variance_pct"
      expr: AVG(CAST(grade_variance_pct AS DOUBLE))
      comment: "Average percentage variance between actual and model grade. Grade variance directly impacts revenue and is a key input to quarterly reserve statements."
    - name: "avg_ore_recovery_pct"
      expr: AVG(CAST(ore_recovery_pct AS DOUBLE))
      comment: "Average ore recovery percentage achieved. Recovery below plan reduces metal production and revenue — a key processing and mining efficiency KPI."
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage in reconciled ore. Dilution above design reduces effective grade and is a primary driver of F2 factor degradation."
    - name: "model_update_required_count"
      expr: COUNT(CASE WHEN model_update_required = TRUE THEN 1 END)
      comment: "Number of reconciliation records flagged as requiring a geological model update. High counts indicate systematic model bias requiring resource statement revision."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of reconciliation records in the period. Used to assess reconciliation coverage and completeness."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mine production schedule KPIs covering planned ore, waste, strip ratio, grade, and cost targets. Used by mine planners, finance, and executive leadership to assess schedule quality, track plan vs actuals setup, and manage life-of-mine delivery commitments."
  source: "`mining_ecm`.`mine`.`production_schedule`"
  dimensions:
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the scheduled production period, used for timeline and milestone analysis."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the scheduled production period."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (short-term, medium-term, life-of-mine), used to separate operational from strategic planning KPIs."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Approval status of the schedule (draft, approved, superseded), used to filter to current approved schedules."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method planned, enabling method-level schedule analysis."
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification of scheduled ore (Proved, Probable, Inferred), used to assess schedule risk profile."
    - name: "is_lom_schedule"
      expr: is_lom_schedule
      comment: "Boolean flag identifying life-of-mine schedules vs short/medium-term operational schedules."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site for the schedule, enabling cross-site production planning comparison."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Pit or level scheduled, enabling pit-level production plan analysis."
  measures:
    - name: "total_planned_ore_tonnes"
      expr: SUM(CAST(planned_ore_tonnes AS DOUBLE))
      comment: "Total planned ore tonnes across schedule periods. The primary production commitment used in revenue forecasting and offtake contract management."
    - name: "total_planned_waste_tonnes"
      expr: SUM(CAST(planned_waste_tonnes AS DOUBLE))
      comment: "Total planned waste tonnes. Drives waste handling cost budgets and waste dump capacity planning."
    - name: "total_planned_total_material_tonnes"
      expr: SUM(CAST(planned_total_material_tonnes AS DOUBLE))
      comment: "Total planned material movement (ore + waste). Used to size fleet requirements and assess mining rate feasibility."
    - name: "avg_planned_strip_ratio"
      expr: AVG(CAST(planned_strip_ratio AS DOUBLE))
      comment: "Average planned strip ratio across schedule periods. A rising strip ratio in the schedule signals increasing future mining cost per tonne of ore — a key input to LOM cost forecasting."
    - name: "avg_target_head_grade"
      expr: AVG(CAST(target_head_grade AS DOUBLE))
      comment: "Average planned head grade across schedule periods. Grade scheduling directly determines planned metal production and revenue."
    - name: "avg_planned_dilution_pct"
      expr: AVG(CAST(planned_dilution_pct AS DOUBLE))
      comment: "Average planned dilution percentage. Used as the design benchmark against which actual dilution is reconciled."
    - name: "avg_planned_recovery_rate_pct"
      expr: AVG(CAST(planned_recovery_rate_pct AS DOUBLE))
      comment: "Average planned ore recovery rate. Recovery assumptions directly drive planned metal production and revenue forecasts."
    - name: "total_planned_opex_usd"
      expr: SUM(CAST(planned_opex_usd AS DOUBLE))
      comment: "Total planned operating expenditure in USD. Used in budget setting, cost-per-tonne benchmarking, and financial planning."
    - name: "total_planned_capex_usd"
      expr: SUM(CAST(planned_capex_usd AS DOUBLE))
      comment: "Total planned capital expenditure in USD. Drives investment approval processes and cash flow forecasting."
    - name: "total_planned_drill_metres"
      expr: SUM(CAST(planned_drill_metres AS DOUBLE))
      comment: "Total planned drilling metres. Used to size drill fleet requirements and assess schedule feasibility against available drill capacity."
    - name: "avg_cutoff_grade"
      expr: AVG(CAST(cutoff_grade AS DOUBLE))
      comment: "Average cut-off grade applied in the schedule. Cut-off grade determines the ore/waste boundary and directly impacts ore reserve tonnes and mine life."
    - name: "schedule_count"
      expr: COUNT(1)
      comment: "Total number of schedule records. Used to assess schedule coverage and version proliferation."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_lom_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Life-of-Mine plan financial and technical KPIs covering NPV, IRR, AISC, C1 cash cost, reserve tonnes, strip ratio, and recovery assumptions. Used by executive leadership, CFO, and board to evaluate mine economics, approve investment decisions, and monitor LOM plan health."
  source: "`mining_ecm`.`mine`.`lom_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Approval status of the LOM plan (draft, approved, superseded), used to filter to current approved plans."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of LOM plan (feasibility, pre-feasibility, operational), used to separate study-phase from operational plans."
    - name: "mining_method"
      expr: mining_method
      comment: "Primary mining method in the plan, enabling method-level economic comparison."
    - name: "resource_classification"
      expr: resource_classification
      comment: "Resource classification basis of the plan (Proved+Probable, etc.), used to assess plan risk profile."
    - name: "reporting_standard"
      expr: reporting_standard
      comment: "Reporting standard used (JORC, NI43-101, SAMREC), relevant for regulatory and investor reporting."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site for the LOM plan, enabling cross-site economic benchmarking."
    - name: "plan_start_date"
      expr: plan_start_date
      comment: "Planned start date of the LOM, used for timeline and milestone tracking."
    - name: "plan_end_date"
      expr: plan_end_date
      comment: "Planned end date of the LOM, used to assess remaining mine life."
  measures:
    - name: "avg_npv_musd"
      expr: AVG(CAST(npv_musd AS DOUBLE))
      comment: "Average Net Present Value in million USD across LOM plans. The primary investment value metric used by the board and CFO to approve mine development and expansion decisions."
    - name: "avg_irr_pct"
      expr: AVG(CAST(irr_pct AS DOUBLE))
      comment: "Average Internal Rate of Return percentage. Compared against the company hurdle rate to determine whether mine investments meet return thresholds — a go/no-go decision metric."
    - name: "avg_aisc_usd_per_t"
      expr: AVG(CAST(aisc_usd_per_t AS DOUBLE))
      comment: "Average All-In Sustaining Cost (AISC) in USD per tonne. The industry-standard cost competitiveness metric — positions the mine on the global cost curve and determines margin resilience to commodity price falls."
    - name: "avg_c1_cash_cost_usd_per_t"
      expr: AVG(CAST(c1_cash_cost_usd_per_t AS DOUBLE))
      comment: "Average C1 cash cost in USD per tonne. The direct operating cost benchmark used to assess mine competitiveness and set production cost targets."
    - name: "total_total_ore_reserve_mt"
      expr: SUM(CAST(total_ore_reserve_mt AS DOUBLE))
      comment: "Total ore reserve in million tonnes across LOM plans. Represents the economic inventory of the mine — a key metric for reserve life, asset valuation, and investor disclosure."
    - name: "total_proved_reserve_mt"
      expr: SUM(CAST(proved_reserve_mt AS DOUBLE))
      comment: "Total Proved ore reserve in million tonnes. The highest-confidence reserve category — used in financial reporting and debt covenant compliance."
    - name: "total_probable_reserve_mt"
      expr: SUM(CAST(probable_reserve_mt AS DOUBLE))
      comment: "Total Probable ore reserve in million tonnes. Combined with Proved reserves for total bankable reserve reporting."
    - name: "avg_lom_strip_ratio"
      expr: AVG(CAST(lom_strip_ratio AS DOUBLE))
      comment: "Average life-of-mine strip ratio. A fundamental driver of LOM mining cost — higher strip ratio means more waste per tonne of ore and higher unit cost."
    - name: "avg_planned_recovery_rate_pct"
      expr: AVG(CAST(planned_recovery_rate_pct AS DOUBLE))
      comment: "Average planned ore recovery rate across LOM plans. Recovery assumptions directly determine planned metal production and LOM revenue."
    - name: "avg_average_ore_grade"
      expr: AVG(CAST(average_ore_grade AS DOUBLE))
      comment: "Average planned ore grade across LOM plans. Grade is the primary determinant of mine value — declining grade profiles signal increasing cost per unit of metal over the mine life."
    - name: "total_total_capex_musd"
      expr: SUM(CAST(total_capex_musd AS DOUBLE))
      comment: "Total planned capital expenditure in million USD across LOM plans. Used in investment approval, balance sheet planning, and return-on-capital calculations."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate applied in NPV calculations. Tracks consistency of valuation assumptions across plans and periods."
    - name: "lom_plan_count"
      expr: COUNT(1)
      comment: "Total number of LOM plans. Used to track plan version proliferation and ensure only current approved plans are used in reporting."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_rom_stockpile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ROM (Run-of-Mine) stockpile inventory and grade KPIs. Tracks current ore inventory, grade quality, and capacity utilisation at the ROM pad — a critical buffer between mining and processing that determines plant feed continuity and product quality."
  source: "`mining_ecm`.`mine`.`rom_stockpile`"
  dimensions:
    - name: "stockpile_status"
      expr: stockpile_status
      comment: "Current operational status of the stockpile (active, depleted, reclaiming), used to filter to active inventory."
    - name: "stockpile_type"
      expr: stockpile_type
      comment: "Type of ROM stockpile (high-grade, low-grade, blend, direct-ship), used to analyse grade blending strategy and inventory by type."
    - name: "mining_method"
      expr: mining_method
      comment: "Mining method that sourced the stockpile material, enabling grade and recovery analysis by mining method."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site of the stockpile, enabling cross-site inventory comparison."
    - name: "pit_or_level_id"
      expr: pit_or_level_id
      comment: "Source pit or level for the stockpile, enabling pit-level inventory tracking."
    - name: "geological_domain_id"
      expr: geological_domain_id
      comment: "Geological domain of the stockpiled material, used for grade and metallurgical characterisation."
  measures:
    - name: "total_current_inventory_t"
      expr: SUM(CAST(current_inventory_t AS DOUBLE))
      comment: "Total current ROM stockpile inventory in tonnes. The primary buffer stock metric — low inventory risks plant feed interruption; excess inventory ties up working capital."
    - name: "total_design_capacity_t"
      expr: SUM(CAST(design_capacity_t AS DOUBLE))
      comment: "Total design capacity of ROM stockpiles in tonnes. Used to compute stockpile utilisation rate and assess capacity adequacy."
    - name: "avg_head_grade_primary_pct"
      expr: AVG(CAST(head_grade_primary_pct AS DOUBLE))
      comment: "Average primary commodity head grade of ROM stockpile inventory. Grade of material feeding the plant directly determines metal production and revenue."
    - name: "avg_head_grade_fe_pct"
      expr: AVG(CAST(head_grade_fe_pct AS DOUBLE))
      comment: "Average iron (Fe%) head grade of ROM stockpile. For iron ore operations, Fe% is the primary product quality and pricing determinant."
    - name: "avg_head_grade_cu_pct"
      expr: AVG(CAST(head_grade_cu_pct AS DOUBLE))
      comment: "Average copper (Cu%) head grade of ROM stockpile. For copper operations, Cu% drives concentrate grade and smelter payability."
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_pct AS DOUBLE))
      comment: "Average moisture content of ROM stockpile material. High moisture reduces effective dry tonnes delivered to plant and increases haulage cost per dry tonne."
    - name: "avg_ore_recovery_pct"
      expr: AVG(CAST(ore_recovery_pct AS DOUBLE))
      comment: "Average ore recovery percentage from ROM stockpile. Recovery below design reduces metal production and is a key processing efficiency KPI."
    - name: "avg_dilution_pct"
      expr: AVG(CAST(dilution_pct AS DOUBLE))
      comment: "Average dilution percentage in ROM stockpile. Dilution above plan reduces effective grade and increases processing cost per unit of metal."
    - name: "total_reconciliation_variance_t"
      expr: SUM(CAST(reconciliation_variance_t AS DOUBLE))
      comment: "Total reconciliation variance in tonnes (surveyed vs system inventory). Large variances indicate measurement or data quality issues that affect production reporting accuracy."
    - name: "total_scheduled_tonnes_t"
      expr: SUM(CAST(scheduled_tonnes_t AS DOUBLE))
      comment: "Total scheduled reclaim tonnes from ROM stockpiles. Used to assess whether plant feed scheduling is achievable from available inventory."
    - name: "stockpile_count"
      expr: COUNT(1)
      comment: "Total number of active ROM stockpile locations. Used to assess inventory distribution and management complexity."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_waste_dump`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste dump capacity, utilisation, and rehabilitation KPIs. Used by mine planners, environmental managers, and CFO to track waste storage capacity consumption, rehabilitation liability, and regulatory compliance — critical for mine closure planning and environmental permit management."
  source: "`mining_ecm`.`mine`.`waste_dump`"
  dimensions:
    - name: "dump_status"
      expr: dump_status
      comment: "Operational status of the waste dump (active, full, rehabilitating, closed), used to filter to active dumps for capacity planning."
    - name: "dump_type"
      expr: dump_type
      comment: "Type of waste dump (overburden, low-grade ore, tailings, PAF, NAF), used to separate waste streams with different environmental risk profiles."
    - name: "waste_rock_classification"
      expr: waste_rock_classification
      comment: "Geochemical classification of waste rock (PAF, NAF, UC), used to assess acid mine drainage risk and rehabilitation cost."
    - name: "leachate_management_status"
      expr: leachate_management_status
      comment: "Status of leachate management at the dump, used to identify environmental compliance risks."
    - name: "progressive_rehab_required"
      expr: progressive_rehab_required
      comment: "Boolean flag for dumps requiring progressive rehabilitation, used to prioritise rehabilitation scheduling and bond management."
    - name: "groundwater_monitoring_required"
      expr: groundwater_monitoring_required
      comment: "Boolean flag for dumps requiring groundwater monitoring, used to track environmental compliance obligations."
    - name: "mine_site_id"
      expr: mine_site_id
      comment: "Mine site of the waste dump, enabling cross-site waste capacity and rehabilitation liability comparison."
  measures:
    - name: "total_current_fill_tonnes"
      expr: SUM(CAST(current_fill_tonnes AS DOUBLE))
      comment: "Total current waste fill in tonnes across all dumps. Tracks waste storage consumption against design capacity — a critical constraint on mine life extension."
    - name: "total_design_capacity_tonnes"
      expr: SUM(CAST(design_capacity_tonnes AS DOUBLE))
      comment: "Total design capacity of waste dumps in tonnes. Used to compute remaining capacity and assess whether additional waste storage is required."
    - name: "total_current_fill_volume_bcm"
      expr: SUM(CAST(current_fill_volume_bcm AS DOUBLE))
      comment: "Total current fill volume in bank cubic metres. Used for volumetric capacity planning and survey reconciliation."
    - name: "total_design_capacity_bcm"
      expr: SUM(CAST(design_capacity_bcm AS DOUBLE))
      comment: "Total design capacity in BCM. Used as denominator for volumetric utilisation rate calculations."
    - name: "total_rehabilitation_bond_amount"
      expr: SUM(CAST(rehabilitation_bond_amount AS DOUBLE))
      comment: "Total rehabilitation bond value across waste dumps. Represents the financial closure liability — a key balance sheet item and regulatory compliance metric monitored by CFO and board."
    - name: "total_progressive_rehab_area_ha"
      expr: SUM(CAST(progressive_rehab_area_ha AS DOUBLE))
      comment: "Total area progressively rehabilitated in hectares. Tracks rehabilitation progress against permit conditions — a key environmental compliance and closure cost management KPI."
    - name: "total_surface_area_ha"
      expr: SUM(CAST(surface_area_ha AS DOUBLE))
      comment: "Total surface area of waste dumps in hectares. Used to assess land disturbance footprint and rehabilitation scope."
    - name: "avg_overall_slope_angle_deg"
      expr: AVG(CAST(overall_slope_angle_deg AS DOUBLE))
      comment: "Average overall slope angle of waste dumps in degrees. Slope angles above geotechnical design limits are a safety and stability risk — monitored by geotechnical engineers and HSE."
    - name: "waste_dump_count"
      expr: COUNT(1)
      comment: "Total number of waste dump facilities. Used to assess waste management complexity and environmental liability scope."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`mine_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mine site portfolio KPIs covering production capacity, ore reserve, grade, strip ratio, and operational status. Used by executive leadership and corporate planning to assess the health and value of the mine site portfolio, prioritise capital allocation, and track life-of-mine metrics."
  source: "`mining_ecm`.`mine`.`mine_site`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the mine site (operating, care and maintenance, development, closed), used to filter to active producing assets."
    - name: "mining_method"
      expr: mining_method
      comment: "Primary mining method at the site (open cut, underground, ISL), used for method-level portfolio analysis."
    - name: "site_type"
      expr: site_type
      comment: "Type of mine site (open pit, underground, combined), used for portfolio segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of operation, used for geographic portfolio analysis and country risk assessment."
    - name: "state_province"
      expr: state_province
      comment: "State or province of operation, used for regional regulatory and operational analysis."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag for active mine sites, used to filter to currently operating assets."
    - name: "is_joint_venture"
      expr: is_joint_venture
      comment: "Boolean flag for joint venture sites, used to separate wholly-owned from JV assets in portfolio analysis."
    - name: "has_processing_plant"
      expr: has_processing_plant
      comment: "Boolean flag indicating on-site processing capability, used to differentiate integrated mine-to-plant operations from ROM-only operations."
  measures:
    - name: "total_annual_production_capacity_tonnes"
      expr: SUM(CAST(annual_production_capacity_tonnes AS DOUBLE))
      comment: "Total annual production capacity in tonnes across the mine site portfolio. Represents the maximum throughput ceiling — used in production planning and capacity investment decisions."
    - name: "total_ore_reserve_tonnes"
      expr: SUM(CAST(ore_reserve_tonnes AS DOUBLE))
      comment: "Total ore reserve tonnes across all mine sites. The aggregate economic inventory of the company — a primary metric for asset valuation, reserve life, and investor disclosure."
    - name: "avg_average_ore_grade_percent"
      expr: AVG(CAST(average_ore_grade_percent AS DOUBLE))
      comment: "Average ore grade percentage across mine sites. Portfolio-level grade is a key determinant of average unit cost and revenue per tonne mined."
    - name: "avg_strip_ratio"
      expr: AVG(CAST(strip_ratio AS DOUBLE))
      comment: "Average strip ratio across mine sites. A higher portfolio strip ratio signals increasing mining cost intensity — used in cost curve positioning and capital allocation."
    - name: "avg_life_of_mine_years"
      expr: AVG(CAST(life_of_mine_years AS DOUBLE))
      comment: "Average remaining life of mine in years across the portfolio. Short average LOM signals need for exploration investment or acquisition to sustain production."
    - name: "total_area_hectares"
      expr: SUM(CAST(area_hectares AS DOUBLE))
      comment: "Total land area of mine sites in hectares. Used to assess land tenure footprint and rehabilitation liability scope."
    - name: "total_rehabilitation_bond_amount"
      expr: SUM(CAST(rehabilitation_bond_amount AS DOUBLE))
      comment: "Total rehabilitation bond value across mine sites. Represents the aggregate closure financial liability — a key balance sheet and regulatory compliance metric."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across mine sites. Used to compute attributable production and reserves for financial reporting."
    - name: "mine_site_count"
      expr: COUNT(1)
      comment: "Total number of mine sites in the portfolio. Used as baseline for portfolio-level averages and to track asset count changes from acquisitions or divestments."
    - name: "active_mine_site_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active mine sites. Tracks the producing asset base — a key metric for revenue capacity and operational footprint."
$$;