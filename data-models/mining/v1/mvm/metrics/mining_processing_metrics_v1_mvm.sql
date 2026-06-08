-- Metric views for domain: processing | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_shift_production_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level production performance metrics covering throughput, recovery, utilisation, OEE, and feed quality. Primary operational KPI layer for plant managers and production controllers to steer daily and weekly performance."
  source: "`mining_ecm`.`processing`.`shift_production_run`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Calendar date of the production shift, used for daily and weekly trend analysis."
    - name: "shift_number"
      expr: shift_number
      comment: "Shift identifier (e.g. Day/Night/Afternoon) for intra-day performance breakdown."
    - name: "plant_id"
      expr: plant_id
      comment: "Foreign key to the processing plant, enabling plant-level aggregation and benchmarking."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Foreign key to the processing circuit, enabling circuit-level drill-down."
    - name: "run_status"
      expr: run_status
      comment: "Operational status of the shift run (e.g. Completed, Aborted, Partial) for filtering active production periods."
    - name: "primary_ore_type"
      expr: primary_ore_type
      comment: "Dominant ore type processed during the shift, used to segment performance by ore hardness and mineralogy."
    - name: "feed_grade_element"
      expr: feed_grade_element
      comment: "Element for which feed grade is reported (e.g. Cu, Fe, Li), enabling multi-commodity analysis."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month bucket derived from shift_date for monthly production roll-ups."
    - name: "shift_date_year"
      expr: DATE_TRUNC('YEAR', shift_date)
      comment: "Year bucket derived from shift_date for annual production reporting."
  measures:
    - name: "total_shifts"
      expr: COUNT(1)
      comment: "Total number of shift production runs recorded. Baseline volume metric for normalising other KPIs."
    - name: "total_tonnes_processed_dry"
      expr: SUM(CAST(tonnes_processed AS DOUBLE))
      comment: "Total dry ROM tonnes processed across all shifts. Primary throughput volume KPI used in production reporting and LOM plan tracking."
    - name: "total_rom_feed_tonnes_wet"
      expr: SUM(CAST(rom_feed_tonnes_wet AS DOUBLE))
      comment: "Total wet ROM feed tonnes delivered to the plant. Used alongside dry tonnes to monitor moisture impact on throughput."
    - name: "total_concentrate_produced_tonnes"
      expr: SUM(CAST(concentrate_produced_tonnes AS DOUBLE))
      comment: "Total concentrate tonnes produced. Direct output volume KPI linked to revenue and sales planning."
    - name: "avg_metallurgical_recovery_pct"
      expr: AVG(CAST(metallurgical_recovery_pct AS DOUBLE))
      comment: "Average metallurgical recovery percentage across shifts. Core efficiency KPI — a 1% recovery improvement directly increases saleable metal units and revenue."
    - name: "avg_actual_throughput_rate_tph"
      expr: AVG(CAST(actual_throughput_rate_tph AS DOUBLE))
      comment: "Average actual throughput rate in tonnes per hour. Compared against design rate to identify capacity underperformance."
    - name: "avg_design_throughput_rate_tph"
      expr: AVG(CAST(design_throughput_rate_tph AS DOUBLE))
      comment: "Average design throughput rate in tonnes per hour. Denominator for throughput utilisation ratio calculations in BI."
    - name: "avg_oee_pct"
      expr: AVG(CAST(oee_pct AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage. Composite KPI combining availability, performance, and quality — used by plant managers and executives to benchmark asset productivity."
    - name: "avg_circuit_availability_pct"
      expr: AVG(CAST(circuit_availability_pct AS DOUBLE))
      comment: "Average circuit availability percentage. Measures the proportion of scheduled time the circuit was available for production; drives maintenance prioritisation decisions."
    - name: "avg_plant_utilisation_pct"
      expr: AVG(CAST(plant_utilisation_pct AS DOUBLE))
      comment: "Average plant utilisation percentage. Indicates how effectively available plant time is being converted to productive processing hours."
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours across all shifts. Used to compute annualised throughput rates and benchmark against planned operating hours."
    - name: "total_unplanned_downtime_hours"
      expr: SUM(CAST(unplanned_downtime_hours AS DOUBLE))
      comment: "Total unplanned downtime hours. A key reliability KPI — rising unplanned downtime triggers maintenance and reliability engineering interventions."
    - name: "total_planned_downtime_hours"
      expr: SUM(CAST(planned_downtime_hours AS DOUBLE))
      comment: "Total planned downtime hours (scheduled maintenance, shutdowns). Used to assess maintenance scheduling efficiency and its impact on production availability."
    - name: "avg_feed_head_grade_pct"
      expr: AVG(CAST(feed_head_grade_pct AS DOUBLE))
      comment: "Average feed head grade percentage. Tracks ore quality entering the plant; declining head grade signals mine-to-mill grade management issues."
    - name: "avg_product_grade_pct"
      expr: AVG(CAST(product_grade_pct AS DOUBLE))
      comment: "Average product (concentrate) grade percentage. Measures product quality against specification; off-spec product incurs penalties or rejection."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_metallurgical_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metallurgical accounting and reconciliation metrics covering feed, recovery, concentrate production, mass balance closure, and resource efficiency. Used by metallurgists, plant managers, and finance for period-end reconciliation and LOM plan variance reporting."
  source: "`mining_ecm`.`processing`.`metallurgical_balance`"
  filter: is_current_version = TRUE
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level metallurgical balance aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Processing circuit identifier for circuit-level balance drill-down."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity identifier (e.g. copper, iron ore, lithium) for multi-commodity balance reporting."
    - name: "period_type"
      expr: period_type
      comment: "Accounting period type (e.g. Monthly, Quarterly, Annual) for temporal aggregation alignment."
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type processed during the balance period, used to segment recovery performance by mineralogy."
    - name: "balance_status"
      expr: balance_status
      comment: "Approval status of the metallurgical balance (e.g. Draft, Approved, Locked) for filtering finalised records."
    - name: "accounting_period_start"
      expr: accounting_period_start
      comment: "Start date of the metallurgical accounting period for time-series analysis."
    - name: "accounting_period_month"
      expr: DATE_TRUNC('MONTH', accounting_period_start)
      comment: "Month bucket of the accounting period start date for monthly roll-up reporting."
    - name: "feed_grade_unit"
      expr: feed_grade_unit
      comment: "Unit of measure for feed grade (e.g. %, g/t) to ensure correct interpretation of grade values."
  measures:
    - name: "total_balance_periods"
      expr: COUNT(1)
      comment: "Total number of metallurgical balance records. Baseline count for reconciliation completeness checks."
    - name: "total_feed_tonnes_dry"
      expr: SUM(CAST(feed_tonnes_dry AS DOUBLE))
      comment: "Total dry feed tonnes processed across balance periods. Primary input volume for metallurgical accounting and LOM plan tracking."
    - name: "total_concentrate_tonnes_dry"
      expr: SUM(CAST(concentrate_tonnes_dry AS DOUBLE))
      comment: "Total dry concentrate tonnes produced. Direct output volume linked to revenue recognition and sales contract fulfilment."
    - name: "total_tailings_tonnes_dry"
      expr: SUM(CAST(tailings_tonnes_dry AS DOUBLE))
      comment: "Total dry tailings tonnes generated. Critical for TSF capacity planning, environmental compliance, and waste management cost forecasting."
    - name: "total_metal_units_feed"
      expr: SUM(CAST(metal_units_feed AS DOUBLE))
      comment: "Total metal units contained in feed. Numerator input for metal accounting reconciliation against mine production."
    - name: "total_metal_units_recovered"
      expr: SUM(CAST(metal_units_recovered AS DOUBLE))
      comment: "Total metal units recovered into concentrate. Directly linked to revenue; gap vs feed units quantifies metallurgical losses."
    - name: "avg_measured_recovery_pct"
      expr: AVG(CAST(measured_recovery_pct AS DOUBLE))
      comment: "Average measured metallurgical recovery percentage. Core plant performance KPI — compared against theoretical recovery and LOM plan targets to identify process inefficiencies."
    - name: "avg_theoretical_recovery_pct"
      expr: AVG(CAST(theoretical_recovery_pct AS DOUBLE))
      comment: "Average theoretical recovery percentage based on ore characterisation. Denominator for recovery efficiency ratio; gap vs measured recovery drives process optimisation investment."
    - name: "avg_recovery_variance_pct"
      expr: AVG(CAST(recovery_variance_pct AS DOUBLE))
      comment: "Average variance between actual and planned recovery percentage. Negative variance triggers metallurgical investigation and process adjustment."
    - name: "avg_mass_balance_closure_pct"
      expr: AVG(CAST(mass_balance_closure_pct AS DOUBLE))
      comment: "Average mass balance closure percentage. Measures the accuracy of metallurgical accounting — closure outside ±2% indicates sampling, weighing, or data quality issues requiring investigation."
    - name: "avg_feed_grade"
      expr: AVG(CAST(feed_grade AS DOUBLE))
      comment: "Average feed grade to the plant. Tracks ore quality trends; declining feed grade impacts recovery and concentrate grade, requiring process parameter adjustments."
    - name: "avg_concentrate_grade"
      expr: AVG(CAST(concentrate_grade AS DOUBLE))
      comment: "Average concentrate grade achieved. Compared against product specification and offtake contract requirements; off-spec concentrate incurs price penalties."
    - name: "avg_plant_availability_pct"
      expr: AVG(CAST(plant_availability_pct AS DOUBLE))
      comment: "Average plant availability percentage from metallurgical balance records. Used to reconcile production losses against maintenance and downtime records."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumed in kWh across balance periods. Drives energy cost allocation, carbon reporting, and specific energy intensity benchmarking."
    - name: "avg_reagent_consumption_kg_per_t"
      expr: AVG(CAST(reagent_consumption_kg_per_t AS DOUBLE))
      comment: "Average reagent consumption per tonne of feed. Rising reagent intensity signals process inefficiency or ore variability, directly impacting operating cost."
    - name: "total_water_consumption_m3"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumed in cubic metres. Critical for water licence compliance, environmental reporting, and water stewardship KPIs."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_concentrate_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concentrate batch production quality and yield metrics. Used by metallurgists, quality managers, and commercial teams to monitor product quality, recovery performance, and batch-level economics against specification and offtake contract requirements."
  source: "`mining_ecm`.`processing`.`concentrate_batch`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level batch quality aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Processing circuit that produced the batch, enabling circuit-level quality drill-down."
    - name: "production_date"
      expr: production_date
      comment: "Date the concentrate batch was produced, used for daily and monthly quality trend analysis."
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month bucket of production date for monthly concentrate quality reporting."
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g. Produced, Approved, Dispatched, Rejected) for pipeline and quality hold tracking."
    - name: "quality_grade"
      expr: quality_grade
      comment: "Quality grade classification of the batch (e.g. Premium, Standard, Off-spec) for grade-mix analysis and penalty exposure assessment."
    - name: "is_quality_approved"
      expr: is_quality_approved
      comment: "Boolean flag indicating whether the batch has passed quality approval. Used to filter approved vs held inventory."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type of the concentrate batch for multi-commodity production reporting."
    - name: "process_route"
      expr: process_route
      comment: "Processing route used to produce the batch (e.g. Flotation, Leach, SXEW) for route-level performance comparison."
    - name: "dispatch_mode"
      expr: dispatch_mode
      comment: "Mode of dispatch (e.g. Rail, Truck, Ship) for logistics and supply chain analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of concentrate batches produced. Baseline production volume metric."
    - name: "total_dry_weight_dmt"
      expr: SUM(CAST(dry_weight_dmt AS DOUBLE))
      comment: "Total dry metric tonnes of concentrate produced. Primary saleable volume KPI linked directly to revenue and offtake contract fulfilment."
    - name: "total_feed_tonnes"
      expr: SUM(CAST(feed_tonnes AS DOUBLE))
      comment: "Total feed tonnes processed to produce concentrate batches. Used as denominator for yield and specific consumption calculations."
    - name: "avg_concentrate_grade_pct"
      expr: AVG(CAST(concentrate_grade_pct AS DOUBLE))
      comment: "Average concentrate grade percentage. Core product quality KPI — below-specification grades trigger price penalties or shipment rejection under offtake contracts."
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_pct AS DOUBLE))
      comment: "Average metallurgical recovery rate per batch. Measures process efficiency in converting feed metal to saleable concentrate; directly impacts revenue per tonne milled."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average mass yield percentage (concentrate mass / feed mass). Indicates the mass pull efficiency of the circuit; abnormal yield signals process or ore variability issues."
    - name: "avg_head_grade_pct"
      expr: AVG(CAST(head_grade_pct AS DOUBLE))
      comment: "Average feed head grade percentage across batches. Tracks ore quality delivered to the plant; declining head grade reduces metal production without process changes."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content of concentrate batches. High moisture increases freight cost per payable metal unit and may breach contract moisture specifications."
    - name: "avg_reagent_consumption_kg_t"
      expr: AVG(CAST(reagent_consumption_kg_t AS DOUBLE))
      comment: "Average reagent consumption per tonne of feed. Rising reagent intensity directly increases operating cost per tonne of concentrate produced."
    - name: "avg_energy_consumption_kwh_t"
      expr: AVG(CAST(energy_consumption_kwh_t AS DOUBLE))
      comment: "Average energy consumption per tonne of feed. Key operating cost driver and carbon intensity input for sustainability reporting."
    - name: "avg_impurity_silica_pct"
      expr: AVG(CAST(impurity_silica_pct AS DOUBLE))
      comment: "Average silica impurity percentage in concentrate. Elevated silica triggers smelter penalties and can breach offtake contract specifications."
    - name: "avg_impurity_sulfur_pct"
      expr: AVG(CAST(impurity_sulfur_pct AS DOUBLE))
      comment: "Average sulfur impurity percentage in concentrate. High sulfur content attracts smelter penalties and environmental compliance obligations."
    - name: "quality_approved_batches"
      expr: COUNT(CASE WHEN is_quality_approved = TRUE THEN 1 END)
      comment: "Count of batches that have passed quality approval. Used to compute quality approval rate and identify quality hold bottlenecks."
    - name: "avg_provisional_price_usd_dmt"
      expr: AVG(CAST(provisional_price_usd_dmt AS DOUBLE))
      comment: "Average provisional price per dry metric tonne in USD. Tracks realised price trends and informs revenue forecasting and hedging decisions."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_flotation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flotation circuit event-level performance metrics covering recovery, grade, reagent dosing, and process control parameters. Used by process engineers and metallurgists to optimise flotation circuit performance and diagnose process upsets."
  source: "`mining_ecm`.`processing`.`flotation_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level flotation performance aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Flotation circuit identifier for circuit-level performance drill-down."
    - name: "circuit_stage"
      expr: circuit_stage
      comment: "Stage of the flotation circuit (e.g. Rougher, Cleaner, Scavenger) for stage-level efficiency analysis."
    - name: "mineral_type"
      expr: mineral_type
      comment: "Mineral type being floated (e.g. chalcopyrite, galena) for mineralogy-specific performance analysis."
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type processed during the flotation event for ore-variability impact analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the flotation event (e.g. Active, Completed, Upset) for filtering operational vs upset periods."
    - name: "event_start_date"
      expr: DATE_TRUNC('DAY', event_start_timestamp)
      comment: "Day bucket of event start timestamp for daily flotation performance trending."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of event start timestamp for monthly flotation KPI roll-ups."
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Reason for flotation circuit downtime, used to categorise and prioritise reliability improvement actions."
  measures:
    - name: "total_flotation_events"
      expr: COUNT(1)
      comment: "Total number of flotation events recorded. Baseline volume for normalising performance metrics."
    - name: "avg_circuit_recovery_pct"
      expr: AVG(CAST(circuit_recovery_pct AS DOUBLE))
      comment: "Average flotation circuit recovery percentage. Primary process efficiency KPI — directly determines metal units recovered and revenue generated per tonne milled."
    - name: "avg_concentrate_grade_pct"
      expr: AVG(CAST(concentrate_grade_pct AS DOUBLE))
      comment: "Average concentrate grade achieved in flotation. Compared against target grade to assess circuit selectivity and product quality compliance."
    - name: "avg_concentrate_grade_target_pct"
      expr: AVG(CAST(concentrate_grade_target_pct AS DOUBLE))
      comment: "Average target concentrate grade for flotation events. Used as denominator in grade achievement ratio calculations in BI."
    - name: "avg_recovery_target_pct"
      expr: AVG(CAST(recovery_target_pct AS DOUBLE))
      comment: "Average target recovery percentage for flotation events. Paired with avg_circuit_recovery_pct to compute recovery achievement ratio."
    - name: "avg_feed_grade_pct"
      expr: AVG(CAST(feed_grade_pct AS DOUBLE))
      comment: "Average feed grade to the flotation circuit. Tracks ore quality variability and its impact on circuit performance."
    - name: "avg_tailings_grade_pct"
      expr: AVG(CAST(tailings_grade_pct AS DOUBLE))
      comment: "Average tailings grade percentage. Elevated tailings grade indicates metal losses to waste — a direct revenue leakage KPI."
    - name: "total_concentrate_mass_t"
      expr: SUM(CAST(concentrate_mass_t AS DOUBLE))
      comment: "Total concentrate mass produced from flotation events. Saleable output volume metric linked to revenue."
    - name: "total_tailings_mass_t"
      expr: SUM(CAST(tailings_mass_t AS DOUBLE))
      comment: "Total tailings mass generated. Drives TSF capacity planning and environmental liability quantification."
    - name: "avg_mass_pull_pct"
      expr: AVG(CAST(mass_pull_pct AS DOUBLE))
      comment: "Average mass pull percentage (concentrate mass / feed mass). Abnormal mass pull indicates reagent dosing or circuit control issues affecting grade-recovery balance."
    - name: "avg_collector_dosage_g_per_t"
      expr: AVG(CAST(collector_dosage_g_per_t AS DOUBLE))
      comment: "Average collector reagent dosage in grams per tonne. Optimising collector dosage is a primary lever for improving recovery while controlling reagent cost."
    - name: "avg_frother_dosage_g_per_t"
      expr: AVG(CAST(frother_dosage_g_per_t AS DOUBLE))
      comment: "Average frother dosage in grams per tonne. Frother dosage directly controls froth stability and concentrate grade-recovery trade-off."
    - name: "avg_circuit_availability_pct"
      expr: AVG(CAST(circuit_availability_pct AS DOUBLE))
      comment: "Average flotation circuit availability percentage. Measures the proportion of time the circuit is available for production; drives maintenance prioritisation."
    - name: "avg_feed_rate_tph"
      expr: AVG(CAST(feed_rate_tph AS DOUBLE))
      comment: "Average feed rate to the flotation circuit in tonnes per hour. Compared against design capacity to identify throughput constraints."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_leach_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leach circuit event-level performance metrics covering extraction efficiency, reagent consumption, solution chemistry, and process upsets. Used by hydrometallurgical engineers and plant managers to optimise leach performance and manage reagent costs."
  source: "`mining_ecm`.`processing`.`leach_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level leach performance aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Leach circuit identifier for circuit-level performance drill-down."
    - name: "leach_type"
      expr: leach_type
      comment: "Type of leach process (e.g. Heap Leach, Tank Leach, Vat Leach) for process-route performance comparison."
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type processed in the leach event for ore-variability impact analysis on extraction efficiency."
    - name: "reagent_type"
      expr: reagent_type
      comment: "Leach reagent type (e.g. Sulphuric Acid, Cyanide, Ammonia) for reagent-specific consumption and cost analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the leach event (e.g. Active, Completed, Upset) for filtering operational vs upset periods."
    - name: "event_start_date"
      expr: DATE_TRUNC('DAY', event_start_timestamp)
      comment: "Day bucket of event start timestamp for daily leach performance trending."
    - name: "event_start_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month bucket of event start timestamp for monthly leach KPI roll-ups."
    - name: "process_upset_flag"
      expr: process_upset_flag
      comment: "Boolean flag indicating a process upset occurred during the event. Used to filter upset periods from baseline performance calculations."
  measures:
    - name: "total_leach_events"
      expr: COUNT(1)
      comment: "Total number of leach events recorded. Baseline volume for normalising performance metrics."
    - name: "avg_extraction_efficiency_pct"
      expr: AVG(CAST(extraction_efficiency_pct AS DOUBLE))
      comment: "Average metal extraction efficiency percentage. Primary leach performance KPI — directly determines metal units recovered and revenue per tonne of ore processed."
    - name: "avg_target_extraction_efficiency_pct"
      expr: AVG(CAST(target_extraction_efficiency_pct AS DOUBLE))
      comment: "Average target extraction efficiency percentage. Paired with actual extraction efficiency to compute achievement ratio and identify underperforming leach periods."
    - name: "total_ore_feed_mass_t"
      expr: SUM(CAST(ore_feed_mass_t AS DOUBLE))
      comment: "Total ore feed mass processed through leach circuits. Primary input volume for leach throughput and specific consumption calculations."
    - name: "avg_feed_grade_pct"
      expr: AVG(CAST(feed_grade_pct AS DOUBLE))
      comment: "Average feed grade to the leach circuit. Tracks ore quality variability and its impact on extraction efficiency and reagent consumption."
    - name: "avg_residue_grade_pct"
      expr: AVG(CAST(residue_grade_pct AS DOUBLE))
      comment: "Average residue (tailings) grade after leaching. Elevated residue grade indicates metal losses to waste — a direct revenue leakage KPI."
    - name: "total_reagent_consumption_kg"
      expr: SUM(CAST(reagent_consumption_kg AS DOUBLE))
      comment: "Total reagent consumed in kilograms. Primary leach operating cost driver; monitored against budget and specific consumption targets."
    - name: "avg_reagent_concentration_g_l"
      expr: AVG(CAST(reagent_concentration_g_l AS DOUBLE))
      comment: "Average reagent concentration in solution (g/L). Optimising reagent concentration is a key lever for maximising extraction efficiency while minimising reagent cost."
    - name: "avg_leach_duration_hrs"
      expr: AVG(CAST(leach_duration_hrs AS DOUBLE))
      comment: "Average leach duration in hours. Longer leach times increase extraction but reduce throughput capacity; optimising residence time is a key process engineering decision."
    - name: "avg_solution_ph"
      expr: AVG(CAST(solution_ph AS DOUBLE))
      comment: "Average leach solution pH. pH control is critical for extraction efficiency and reagent consumption; deviations from target pH trigger immediate process intervention."
    - name: "avg_solution_temperature_c"
      expr: AVG(CAST(solution_temperature_c AS DOUBLE))
      comment: "Average leach solution temperature in Celsius. Temperature directly affects reaction kinetics and extraction efficiency; deviations indicate process control issues."
    - name: "process_upset_events"
      expr: COUNT(CASE WHEN process_upset_flag = TRUE THEN 1 END)
      comment: "Count of leach events with a process upset flag. Rising upset frequency indicates process instability requiring engineering investigation and corrective action."
    - name: "avg_dissolved_metal_concentration_ppm"
      expr: AVG(CAST(dissolved_metal_concentration_ppm AS DOUBLE))
      comment: "Average dissolved metal concentration in leach solution (ppm). Tracks solution tenor and circuit loading; declining concentration signals reduced extraction or solution dilution."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_plant_utility_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level utility consumption metrics covering electricity, water, and emissions. Used by plant managers, sustainability teams, and finance to monitor energy intensity, water stewardship, carbon footprint, and utility cost performance against budget and regulatory limits."
  source: "`mining_ecm`.`processing`.`plant_utility_consumption`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level utility consumption aggregation and benchmarking."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Processing circuit identifier for circuit-level energy and water consumption drill-down."
    - name: "period_type"
      expr: period_type
      comment: "Reporting period type (e.g. Daily, Monthly, Annual) for temporal aggregation alignment."
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_timestamp)
      comment: "Month bucket of the consumption period start for monthly utility trend analysis."
    - name: "period_start_year"
      expr: DATE_TRUNC('YEAR', period_start_timestamp)
      comment: "Year bucket of the consumption period start for annual utility and emissions reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for utility cost reporting, enabling multi-currency cost aggregation."
    - name: "record_status"
      expr: record_status
      comment: "Record approval status (e.g. Draft, Approved, Locked) for filtering finalised consumption records."
    - name: "data_source"
      expr: data_source
      comment: "Source system for the consumption record (e.g. Meter, SCADA, Manual) for data quality stratification."
  measures:
    - name: "total_electricity_consumption_kwh"
      expr: SUM(CAST(electricity_consumption_kwh AS DOUBLE))
      comment: "Total electricity consumed in kWh. Primary energy cost driver and carbon intensity input; monitored against energy budget and specific energy targets."
    - name: "total_electricity_cost"
      expr: SUM(CAST(electricity_cost_total AS DOUBLE))
      comment: "Total electricity cost in reporting currency. Direct operating cost KPI used in AISC calculations and budget variance reporting."
    - name: "avg_specific_energy_kwh_per_t"
      expr: AVG(CAST(specific_energy_kwh_per_t AS DOUBLE))
      comment: "Average specific energy consumption in kWh per tonne processed. Benchmark KPI for energy efficiency; rising specific energy signals process inefficiency or ore hardness changes."
    - name: "avg_energy_target_kwh"
      expr: AVG(CAST(energy_target_kwh AS DOUBLE))
      comment: "Average energy consumption target in kWh. Paired with actual consumption to compute energy target achievement ratio in BI."
    - name: "total_fresh_water_intake_m3"
      expr: SUM(CAST(fresh_water_intake_m3 AS DOUBLE))
      comment: "Total fresh water intake in cubic metres. Critical for water licence compliance and water stewardship reporting; exceeding licence limits triggers regulatory penalties."
    - name: "total_process_water_consumption_m3"
      expr: SUM(CAST(process_water_consumption_m3 AS DOUBLE))
      comment: "Total process water consumed in cubic metres. Tracks total water demand for processing operations, informing water balance and recycling strategy."
    - name: "total_recycled_water_m3"
      expr: SUM(CAST(recycled_water_m3 AS DOUBLE))
      comment: "Total recycled water used in cubic metres. Measures water recycling performance; higher recycled water reduces fresh water intake and environmental impact."
    - name: "avg_specific_water_m3_per_t"
      expr: AVG(CAST(specific_water_m3_per_t AS DOUBLE))
      comment: "Average specific water consumption in m3 per tonne processed. Water intensity benchmark KPI used in sustainability reporting and licence condition monitoring."
    - name: "total_scope1_emissions_co2e_t"
      expr: SUM(CAST(scope1_emissions_co2e_t AS DOUBLE))
      comment: "Total Scope 1 (direct) greenhouse gas emissions in CO2-equivalent tonnes. Mandatory for regulatory carbon reporting and net-zero target tracking."
    - name: "total_scope2_emissions_co2e_t"
      expr: SUM(CAST(scope2_emissions_co2e_t AS DOUBLE))
      comment: "Total Scope 2 (indirect electricity) greenhouse gas emissions in CO2-equivalent tonnes. Key input for carbon budget management and emissions reduction initiatives."
    - name: "avg_carbon_budget_target_co2e_t"
      expr: AVG(CAST(carbon_budget_target_co2e_t AS DOUBLE))
      comment: "Average carbon budget target in CO2-equivalent tonnes. Paired with actual emissions to compute carbon budget utilisation ratio and identify periods of budget overrun."
    - name: "total_water_cost"
      expr: SUM(CAST(water_cost_total AS DOUBLE))
      comment: "Total water cost in reporting currency. Tracks water procurement and treatment costs as a component of processing operating cost."
    - name: "total_tonnes_processed"
      expr: SUM(CAST(tonnes_processed AS DOUBLE))
      comment: "Total tonnes processed during utility consumption periods. Used as denominator for specific energy and water intensity calculations in BI."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_reagent_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reagent consumption metrics covering dosage rates, specific consumption, cost, and process chemistry context. Used by metallurgists, procurement, and finance to optimise reagent usage, control operating costs, and ensure process chemistry compliance."
  source: "`mining_ecm`.`processing`.`reagent_consumption`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level reagent consumption aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Processing circuit identifier for circuit-level reagent usage drill-down."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift during which reagent was consumed, for daily and monthly trend analysis."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month bucket of shift date for monthly reagent cost and consumption reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (e.g. Day, Night) for intra-day reagent usage pattern analysis."
    - name: "consumption_status"
      expr: consumption_status
      comment: "Status of the consumption record (e.g. Confirmed, Estimated, Adjusted) for data quality filtering."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Boolean flag indicating whether the reagent is classified as hazardous. Used for HSE compliance reporting and chemical inventory management."
    - name: "supplier_name"
      expr: supplier_name
      comment: "Reagent supplier name for supplier performance and procurement analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for reagent cost reporting."
  measures:
    - name: "total_reagent_consumption_records"
      expr: COUNT(1)
      comment: "Total number of reagent consumption records. Baseline count for data completeness and coverage checks."
    - name: "total_quantity_consumed_kg"
      expr: SUM(CAST(quantity_consumed_kg AS DOUBLE))
      comment: "Total reagent quantity consumed in kilograms. Primary reagent volume KPI for procurement planning and budget tracking."
    - name: "total_reagent_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total reagent cost in reporting currency. Direct operating cost KPI; reagents are typically one of the top three processing cost line items."
    - name: "avg_specific_consumption_g_per_t"
      expr: AVG(CAST(specific_consumption_g_per_t AS DOUBLE))
      comment: "Average specific reagent consumption in grams per tonne of ore processed. Efficiency benchmark KPI — rising specific consumption signals process inefficiency or ore variability."
    - name: "avg_dosage_rate"
      expr: AVG(CAST(dosage_rate AS DOUBLE))
      comment: "Average actual reagent dosage rate. Compared against planned dosage rate to identify over- or under-dosing, which impacts recovery and cost."
    - name: "avg_plan_dosage_rate"
      expr: AVG(CAST(plan_dosage_rate AS DOUBLE))
      comment: "Average planned reagent dosage rate. Paired with actual dosage rate to compute dosage adherence ratio in BI."
    - name: "total_ore_throughput_t"
      expr: SUM(CAST(ore_throughput_t AS DOUBLE))
      comment: "Total ore throughput tonnes associated with reagent consumption records. Used as denominator for specific consumption calculations."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per kg of reagent. Tracks reagent price trends and informs procurement strategy and contract negotiations."
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average metallurgical recovery rate associated with reagent consumption records. Enables correlation analysis between reagent dosing and recovery performance."
    - name: "hazardous_reagent_consumption_kg"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN CAST(quantity_consumed_kg AS DOUBLE) ELSE 0 END)
      comment: "Total hazardous reagent consumed in kilograms. Critical for HSE compliance reporting, chemical inventory management, and environmental permit condition monitoring."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_sxew_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Solvent Extraction and Electrowinning (SXEW) event metrics covering cathode production, current efficiency, extraction performance, and energy consumption. Used by hydrometallurgical engineers and plant managers to optimise copper cathode production and manage SXEW operating costs."
  source: "`mining_ecm`.`processing`.`sxew_event`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level SXEW performance aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "SXEW circuit identifier for circuit-level performance drill-down."
    - name: "production_date"
      expr: production_date
      comment: "Date of cathode production for daily and monthly SXEW output trending."
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_date)
      comment: "Month bucket of production date for monthly cathode production reporting."
    - name: "shift_type"
      expr: shift_type
      comment: "Shift type (e.g. Day, Night) for intra-day SXEW performance analysis."
    - name: "event_status"
      expr: event_status
      comment: "Status of the SXEW event (e.g. Active, Completed, Upset) for filtering operational periods."
    - name: "cathode_quality_grade"
      expr: cathode_quality_grade
      comment: "Quality grade of cathodes produced (e.g. LME Grade A, Off-grade) for product quality mix analysis and premium/penalty tracking."
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Reason for SXEW circuit downtime, used to categorise and prioritise reliability improvement actions."
  measures:
    - name: "total_sxew_events"
      expr: COUNT(1)
      comment: "Total number of SXEW events recorded. Baseline volume for normalising performance metrics."
    - name: "total_cathode_production_kg"
      expr: SUM(CAST(cathode_production_kg AS DOUBLE))
      comment: "Total copper cathode produced in kilograms. Primary SXEW output volume KPI directly linked to revenue and LOM plan tracking."
    - name: "avg_current_efficiency_pct"
      expr: AVG(CAST(current_efficiency_pct AS DOUBLE))
      comment: "Average electrowinning current efficiency percentage. Measures the proportion of electrical current converted to cathode metal; declining efficiency increases energy cost per kg of cathode."
    - name: "avg_extraction_efficiency_pct"
      expr: AVG(CAST(extraction_efficiency_pct AS DOUBLE))
      comment: "Average solvent extraction efficiency percentage. Measures copper transfer from PLS to organic phase; directly determines metal recovery and cathode production rate."
    - name: "avg_cathode_grade_pct"
      expr: AVG(CAST(cathode_grade_pct AS DOUBLE))
      comment: "Average cathode copper grade percentage. LME Grade A cathode requires ≥99.99% Cu; below-grade cathode attracts significant price discounts."
    - name: "avg_specific_energy_kwh_t"
      expr: AVG(CAST(specific_energy_kwh_t AS DOUBLE))
      comment: "Average specific energy consumption in kWh per tonne of cathode. Key SXEW operating cost driver; benchmarked against industry standards to identify efficiency improvement opportunities."
    - name: "avg_aqueous_feed_grade_gl"
      expr: AVG(CAST(aqueous_feed_grade_gl AS DOUBLE))
      comment: "Average PLS (pregnant leach solution) copper grade in g/L. Tracks leach circuit performance feeding SXEW; declining PLS grade reduces cathode production rate."
    - name: "avg_raffinate_grade_gl"
      expr: AVG(CAST(raffinate_grade_gl AS DOUBLE))
      comment: "Average raffinate copper grade in g/L. Elevated raffinate grade indicates incomplete extraction — a direct metal loss and revenue leakage KPI."
    - name: "avg_lom_plan_cathode_kg"
      expr: AVG(CAST(lom_plan_cathode_kg AS DOUBLE))
      comment: "Average LOM plan cathode production target in kg. Paired with actual cathode production to compute plan achievement ratio in BI."
    - name: "avg_cell_voltage_v"
      expr: AVG(CAST(cell_voltage_v AS DOUBLE))
      comment: "Average electrowinning cell voltage. Elevated cell voltage increases energy consumption per kg of cathode; deviations from design voltage indicate electrode or electrolyte issues."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_concentrate_stockpile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concentrate stockpile inventory metrics covering stock levels, grade, capacity utilisation, and shipment nomination status. Used by logistics, commercial, and operations teams to manage product inventory, plan shipments, and ensure offtake contract fulfilment."
  source: "`mining_ecm`.`processing`.`concentrate_stockpile`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level stockpile inventory aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Circuit that produced the stockpiled concentrate for source-circuit inventory tracking."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity identifier for multi-commodity stockpile inventory reporting."
    - name: "concentrate_type"
      expr: concentrate_type
      comment: "Type of concentrate (e.g. Copper, Zinc, Lead) for product-type inventory segregation."
    - name: "stockpile_status"
      expr: stockpile_status
      comment: "Current status of the stockpile (e.g. Active, Full, Depleted, On Hold) for operational inventory management."
    - name: "is_shipment_nominated"
      expr: is_shipment_nominated
      comment: "Boolean flag indicating whether the stockpile has been nominated for a shipment. Used to track committed vs uncommitted inventory."
    - name: "is_under_environmental_hold"
      expr: is_under_environmental_hold
      comment: "Boolean flag indicating the stockpile is under an environmental hold. Held inventory cannot be shipped, creating revenue deferral risk."
    - name: "last_assay_date"
      expr: last_assay_date
      comment: "Date of the most recent assay for the stockpile, used to assess grade data currency and sampling compliance."
    - name: "reconciliation_period_start"
      expr: reconciliation_period_start
      comment: "Start date of the stockpile reconciliation period for period-end inventory reporting."
  measures:
    - name: "total_stockpile_records"
      expr: COUNT(1)
      comment: "Total number of concentrate stockpile records. Baseline count for inventory coverage checks."
    - name: "total_inventory_dmt"
      expr: SUM(CAST(inventory_dmt AS DOUBLE))
      comment: "Total current concentrate inventory in dry metric tonnes. Primary inventory KPI for shipment planning, revenue forecasting, and working capital management."
    - name: "total_inventory_wmt"
      expr: SUM(CAST(inventory_wmt AS DOUBLE))
      comment: "Total current concentrate inventory in wet metric tonnes. Used for logistics planning (vessel loading, truck/rail capacity) and moisture-adjusted revenue calculations."
    - name: "total_additions_dmt"
      expr: SUM(CAST(additions_dmt AS DOUBLE))
      comment: "Total concentrate additions to stockpile in dry metric tonnes during the period. Measures production output flowing into inventory."
    - name: "total_removals_dmt"
      expr: SUM(CAST(removals_dmt AS DOUBLE))
      comment: "Total concentrate removals from stockpile in dry metric tonnes. Measures shipment and dispatch volumes; compared against additions to track inventory build or drawdown."
    - name: "total_nominated_shipment_dmt"
      expr: SUM(CAST(nominated_shipment_dmt AS DOUBLE))
      comment: "Total concentrate nominated for shipment in dry metric tonnes. Tracks committed inventory against available stock to identify shipment shortfall risk."
    - name: "avg_product_grade"
      expr: AVG(CAST(product_grade AS DOUBLE))
      comment: "Average concentrate product grade across stockpiles. Tracks blended product quality for shipment planning and offtake contract compliance."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content of stockpiled concentrate. High moisture increases freight cost per payable metal unit and may breach contract moisture specifications."
    - name: "total_max_capacity_dmt"
      expr: SUM(CAST(max_capacity_dmt AS DOUBLE))
      comment: "Total maximum stockpile capacity in dry metric tonnes. Used as denominator for stockpile utilisation ratio calculations in BI."
    - name: "stockpiles_under_environmental_hold"
      expr: COUNT(CASE WHEN is_under_environmental_hold = TRUE THEN 1 END)
      comment: "Count of stockpiles currently under environmental hold. Held stockpiles represent deferred revenue and potential regulatory compliance issues requiring urgent resolution."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_operational_exception`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Processing operational exception and production loss metrics. Used by plant managers, reliability engineers, and operations leadership to quantify production losses, identify root causes, and prioritise corrective actions to improve plant availability and throughput."
  source: "`mining_ecm`.`processing`.`operational_exception`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level exception aggregation and benchmarking."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Processing circuit identifier for circuit-level exception drill-down."
    - name: "event_type"
      expr: event_type
      comment: "Type of operational exception (e.g. Equipment Failure, Process Upset, Quality Deviation) for categorised loss analysis."
    - name: "event_category"
      expr: event_category
      comment: "Broader category of the exception event for executive-level loss categorisation."
    - name: "oee_loss_category"
      expr: oee_loss_category
      comment: "OEE loss category (e.g. Availability, Performance, Quality) for structured loss accounting aligned to OEE framework."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the exception (e.g. Critical, Major, Minor) for risk-based prioritisation of corrective actions."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code for the exception. Used in Pareto analysis to identify the vital few causes driving the majority of production losses."
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the shift during which the exception occurred for daily and monthly loss trending."
    - name: "shift_date_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month bucket of shift date for monthly production loss reporting."
    - name: "is_planned"
      expr: is_planned
      comment: "Boolean flag distinguishing planned (scheduled maintenance) from unplanned exceptions. Unplanned losses are the primary target for reliability improvement."
    - name: "hse_incident_raised"
      expr: hse_incident_raised
      comment: "Boolean flag indicating whether an HSE incident was raised in connection with this exception. Used to track safety-production interface events."
  measures:
    - name: "total_exceptions"
      expr: COUNT(1)
      comment: "Total number of operational exceptions recorded. Baseline frequency metric for exception rate trending and reliability benchmarking."
    - name: "total_production_loss_tonnes"
      expr: SUM(CAST(production_loss_tonnes AS DOUBLE))
      comment: "Total production loss in tonnes attributable to operational exceptions. Primary KPI for quantifying the revenue impact of plant downtime and process upsets."
    - name: "total_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total duration of operational exceptions in minutes. Measures cumulative downtime and process deviation time; directly linked to production loss and OEE degradation."
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per operational exception in minutes. Tracks mean time to resolve exceptions; rising average duration indicates deteriorating response or repair capability."
    - name: "total_throughput_loss_tph"
      expr: SUM(CAST(throughput_loss_tph AS DOUBLE))
      comment: "Total throughput rate loss in tonnes per hour across all exceptions. Quantifies the instantaneous capacity impact of exceptions for production scheduling adjustments."
    - name: "avg_deviation_magnitude"
      expr: AVG(CAST(deviation_magnitude AS DOUBLE))
      comment: "Average magnitude of process parameter deviation during exceptions. Larger deviations indicate more severe process upsets and higher risk of quality or safety impacts."
    - name: "unplanned_exceptions"
      expr: COUNT(CASE WHEN is_planned = FALSE THEN 1 END)
      comment: "Count of unplanned operational exceptions. Unplanned exceptions represent reliability failures; rising count triggers maintenance strategy review and root cause analysis."
    - name: "hse_linked_exceptions"
      expr: COUNT(CASE WHEN hse_incident_raised = TRUE THEN 1 END)
      comment: "Count of operational exceptions that resulted in an HSE incident being raised. Tracks the safety-production interface and informs risk management prioritisation."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`processing_recovery_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recovery and production target metrics covering planned recovery, throughput, concentrate grade, and resource efficiency targets. Used by planning engineers, metallurgists, and executives to set performance benchmarks, track LOM plan alignment, and evaluate target achievability."
  source: "`mining_ecm`.`processing`.`recovery_target`"
  filter: is_current_version = TRUE
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Processing plant identifier for plant-level target aggregation."
    - name: "circuit_id"
      expr: circuit_id
      comment: "Processing circuit identifier for circuit-level target drill-down."
    - name: "commodity_id"
      expr: commodity_id
      comment: "Commodity identifier for multi-commodity target reporting."
    - name: "ore_type"
      expr: ore_type
      comment: "Ore type for which the recovery target is set, enabling ore-type-specific performance benchmarking."
    - name: "processing_route"
      expr: processing_route
      comment: "Processing route for which the target applies (e.g. Flotation, Leach, SXEW) for route-level target tracking."
    - name: "target_period_type"
      expr: target_period_type
      comment: "Type of target period (e.g. Monthly, Annual, LOM) for temporal aggregation alignment."
    - name: "target_status"
      expr: target_status
      comment: "Approval status of the target (e.g. Draft, Approved, Superseded) for filtering active targets."
    - name: "basis_type"
      expr: basis_type
      comment: "Basis for the target (e.g. Feasibility Study, Operational Plan, LOM Plan) for target provenance tracking."
    - name: "target_period_start"
      expr: target_period_start
      comment: "Start date of the target period for time-series target vs actual analysis."
    - name: "target_period_month"
      expr: DATE_TRUNC('MONTH', target_period_start)
      comment: "Month bucket of target period start for monthly target reporting."
  measures:
    - name: "total_targets"
      expr: COUNT(1)
      comment: "Total number of recovery target records. Baseline count for target coverage and completeness checks."
    - name: "avg_target_recovery_pct"
      expr: AVG(CAST(target_recovery_pct AS DOUBLE))
      comment: "Average planned recovery percentage target. Primary benchmark for evaluating actual metallurgical recovery performance against plan."
    - name: "avg_target_throughput_tph"
      expr: AVG(CAST(target_throughput_tph AS DOUBLE))
      comment: "Average planned throughput rate target in tonnes per hour. Benchmark for evaluating actual plant throughput performance against design intent."
    - name: "total_target_throughput_kt"
      expr: SUM(CAST(target_throughput_kt AS DOUBLE))
      comment: "Total planned throughput volume in kilotonnes for the target period. Used in LOM plan tracking and production budget setting."
    - name: "total_target_concentrate_kt"
      expr: SUM(CAST(target_concentrate_kt AS DOUBLE))
      comment: "Total planned concentrate production in kilotonnes. Primary output volume target linked to revenue budget and offtake contract commitments."
    - name: "avg_target_concentrate_grade"
      expr: AVG(CAST(target_concentrate_grade AS DOUBLE))
      comment: "Average planned concentrate grade target. Benchmark for product quality management and offtake contract compliance."
    - name: "avg_target_plant_availability_pct"
      expr: AVG(CAST(target_plant_availability_pct AS DOUBLE))
      comment: "Average planned plant availability percentage target. Benchmark for maintenance and reliability performance evaluation."
    - name: "avg_target_utilisation_pct"
      expr: AVG(CAST(target_utilisation_pct AS DOUBLE))
      comment: "Average planned plant utilisation percentage target. Benchmark for operational scheduling and production efficiency evaluation."
    - name: "total_target_metal_units"
      expr: SUM(CAST(target_metal_units AS DOUBLE))
      comment: "Total planned metal units to be produced. Primary revenue-linked production target used in LOM plan and annual budget reporting."
    - name: "avg_target_reagent_consumption"
      expr: AVG(CAST(target_reagent_consumption AS DOUBLE))
      comment: "Average planned reagent consumption target. Used as benchmark for reagent efficiency monitoring and operating cost budget management."
$$;