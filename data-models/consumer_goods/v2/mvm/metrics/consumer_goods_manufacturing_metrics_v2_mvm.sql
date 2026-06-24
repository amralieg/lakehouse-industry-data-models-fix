-- Metric views for domain: manufacturing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level manufacturing performance metrics covering yield, scrap, cost variance, OEE, and quality compliance. Used by manufacturing VPs and quality directors to steer production efficiency and GMP adherence."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g., Released, In-Process, Rejected) for filtering and grouping performance by lifecycle stage."
    - name: "release_status"
      expr: release_status
      comment: "Quality release status of the batch, enabling analysis of released vs. held inventory."
    - name: "batch_uom"
      expr: batch_uom
      comment: "Unit of measure for batch size, used to ensure consistent aggregation across product lines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which batch costs are recorded, enabling multi-currency cost analysis."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Indicates whether the batch was produced under GMP-compliant conditions, critical for regulatory reporting."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Flags batches with GMP deviations, enabling targeted quality investigation."
    - name: "quality_release_flag"
      expr: quality_release_flag
      comment: "Indicates whether the batch has been quality-released for distribution."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Flags batches subject to recall, a critical risk and compliance dimension."
    - name: "manufacture_date"
      expr: DATE_TRUNC('month', manufacture_date)
      comment: "Month of manufacture, enabling trend analysis of production performance over time."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level performance benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to production line, enabling line-level yield and efficiency analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to SKU, enabling product-level batch performance analysis."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batches produced. Baseline volume metric for manufacturing throughput reporting."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage. A core manufacturing efficiency KPI — declining yield signals process degradation, material waste, or equipment issues requiring immediate intervention."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all batches. Directly tied to material waste cost and sustainability targets; high scrap drives corrective action and process re-engineering."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity across batches. Rework inflates labor and material costs and signals quality control failures upstream."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) across batches. The primary manufacturing productivity KPI used by operations leadership to benchmark and drive improvement programs."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual manufacturing cost across batches. Essential for cost-of-goods-sold (COGS) reporting and budget variance analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard (planned) manufacturing cost across batches. Used as the denominator in cost variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE) - CAST(standard_cost_amount AS DOUBLE))
      comment: "Total cost variance (actual minus standard) across batches. Positive variance indicates cost overruns; a key financial steering metric for manufacturing finance reviews."
    - name: "gmp_deviation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_deviation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches with GMP deviations. A critical regulatory compliance KPI — high deviation rates trigger FDA/regulatory scrutiny and can halt production."
    - name: "recall_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recall_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches subject to recall. A top-tier risk metric directly tied to brand reputation, regulatory penalties, and consumer safety."
    - name: "quality_release_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_release_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches that have passed quality release. Measures the effectiveness of the quality control process and readiness for distribution."
    - name: "avg_batch_size_actual"
      expr: AVG(CAST(batch_size_actual AS DOUBLE))
      comment: "Average actual batch size produced. Compared against planned batch size to assess production adherence and capacity utilization."
    - name: "avg_batch_size_planned"
      expr: AVG(CAST(batch_size_planned AS DOUBLE))
      comment: "Average planned batch size. Used as the baseline for batch size attainment calculations."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution metrics covering schedule adherence, cost performance, yield, scrap, and OEE. Used by supply chain, manufacturing operations, and finance leadership to manage production efficiency and cost."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g., Released, Completed, Cancelled), enabling pipeline and throughput analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g., standard, rework, trial), enabling segmentation of production volume by purpose."
    - name: "priority"
      expr: priority
      comment: "Priority level of the production order, used to analyze whether high-priority orders are being fulfilled on schedule."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost fields on the production order, enabling multi-currency financial analysis."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicates GMP compliance status of the production order, critical for regulated consumer goods manufacturing."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned production start, enabling trend analysis of production scheduling and capacity loading."
    - name: "actual_start_date"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month of actual production start, used to measure schedule adherence over time."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level production order performance benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to production line, enabling line-level order execution analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to SKU, enabling product-level production performance analysis."
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders. Baseline volume metric for manufacturing throughput and capacity planning."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders. Core supply planning metric for capacity and demand fulfillment analysis."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed (actually produced) quantity. Compared against order quantity to measure production attainment."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity from production orders. Directly tied to material waste cost and quality performance."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across production orders. Essential for COGS and manufacturing budget variance reporting."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned cost across production orders. Used as the standard cost baseline for variance analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(planned_cost AS DOUBLE))
      comment: "Total cost variance (actual minus planned) across production orders. A primary financial KPI for manufacturing cost control and budget stewardship."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders. Measures manufacturing process efficiency and directly impacts material cost per unit."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE across production orders. The headline manufacturing productivity KPI used in operational steering meetings."
    - name: "on_time_start_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_start_date <= planned_start_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production orders that started on or before the planned start date. Measures schedule adherence and production planning effectiveness."
    - name: "on_time_finish_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_end_date <= planned_end_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production orders completed on or before the planned end date. A key supply chain reliability KPI affecting customer service levels."
    - name: "gmp_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production orders meeting GMP compliance requirements. Critical regulatory KPI for consumer goods manufacturers subject to FDA/EMA oversight."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time production confirmation metrics capturing actual vs. scheduled execution, OEE components, labor and machine time efficiency, and quality compliance at the operation level. Used by plant managers and operations analysts for shift-level and daily performance management."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "operation_status"
      expr: operation_status
      comment: "Status of the confirmed operation (e.g., Completed, Partial, Reversed), enabling filtering of valid production records."
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of production confirmation (e.g., partial, final), used to segment throughput by confirmation stage."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of production activity confirmed (e.g., setup, run, teardown), enabling time-use analysis by activity category."
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift identifier, enabling shift-level performance benchmarking and root cause analysis."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag at the confirmation level, used for regulatory compliance tracking."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Flags confirmations involving rework, enabling rework volume and cost impact analysis."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flags reversed confirmations, used to identify data quality issues and production corrections."
    - name: "is_final_confirmation"
      expr: is_final_confirmation
      comment: "Indicates whether this is the final confirmation for the order, enabling analysis of completed vs. in-progress production."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date, enabling trend analysis of production confirmation volumes and performance over time."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level operational performance analysis."
    - name: "work_center_id"
      expr: work_center_id
      comment: "Foreign key to work center, enabling granular work-center-level efficiency and throughput analysis."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of production confirmations. Baseline operational throughput metric."
    - name: "total_confirmed_yield_quantity"
      expr: SUM(CAST(confirmed_yield_quantity AS DOUBLE))
      comment: "Total good quantity confirmed as yield. The primary output volume metric for production performance reporting."
    - name: "total_confirmed_scrap_quantity"
      expr: SUM(CAST(confirmed_scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity confirmed at the operation level. Drives material waste cost analysis and quality improvement initiatives."
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(confirmed_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap as a percentage of total confirmed quantity. A key quality and efficiency KPI — high scrap rates trigger process investigations and corrective actions."
    - name: "avg_oee_availability"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability component across confirmations. Measures the proportion of scheduled time that equipment is available for production."
    - name: "avg_oee_performance"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance component. Measures how efficiently equipment runs relative to its designed speed."
    - name: "avg_oee_quality"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality component. Measures the proportion of output meeting quality standards on the first pass."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total unplanned downtime minutes across all confirmations. A critical operational KPI — high downtime directly reduces throughput and increases unit cost."
    - name: "total_actual_labor_time_minutes"
      expr: SUM(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Total actual labor time consumed in production. Used for labor efficiency analysis and workforce cost management."
    - name: "total_actual_machine_time_minutes"
      expr: SUM(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Total actual machine time consumed. Used to assess equipment utilization and identify capacity constraints."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(actual_setup_time_minutes AS DOUBLE))
      comment: "Average setup time per confirmation. Reducing setup time is a key lean manufacturing lever for increasing effective capacity."
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rework_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of confirmations involving rework. High rework rates signal systemic quality issues and inflate production costs."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and maintenance metrics covering OEE, reliability (MTBF/MTTR), maintenance cost, energy consumption, and calibration compliance. Used by asset management, maintenance, and operations leadership to optimize equipment lifecycle and minimize unplanned downtime."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment (e.g., Active, Under Maintenance, Decommissioned), enabling fleet health analysis."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type/category of equipment, enabling performance benchmarking across equipment classes."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational readiness status, used to segment available vs. unavailable assets for capacity planning."
    - name: "department"
      expr: department
      comment: "Department owning the equipment, enabling departmental asset cost and performance analysis."
    - name: "gmp_qualified_flag"
      expr: gmp_qualified_flag
      comment: "Indicates whether the equipment is GMP-qualified, critical for regulated manufacturing compliance reporting."
    - name: "calibration_required_flag"
      expr: calibration_required_flag
      comment: "Flags equipment requiring calibration, used to manage compliance and prevent quality failures from out-of-calibration assets."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer, enabling vendor performance and reliability benchmarking."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level asset performance and cost analysis."
    - name: "install_date"
      expr: DATE_TRUNC('year', install_date)
      comment: "Year of equipment installation, enabling asset age cohort analysis and lifecycle planning."
    - name: "next_maintenance_due"
      expr: DATE_TRUNC('month', next_maintenance_due)
      comment: "Month when next maintenance is due, enabling proactive maintenance scheduling and resource planning."
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets. Baseline fleet size metric for asset management and capacity planning."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across equipment. The headline asset productivity KPI used by operations leadership to benchmark and drive improvement."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across equipment. Used as the benchmark for OEE gap analysis."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours. A key reliability KPI — low MTBF signals equipment degradation and drives maintenance investment decisions."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours. Measures maintenance responsiveness — high MTTR indicates repair process inefficiencies that extend production downtime."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across the equipment fleet. A direct input to asset lifecycle cost analysis and make-vs-replace decisions."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of the equipment fleet. Used for capital asset reporting and depreciation planning."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh across the equipment fleet. A key sustainability and operational cost KPI, directly tied to energy spend and carbon footprint targets."
    - name: "avg_total_usage_hours"
      expr: AVG(CAST(total_usage_hours AS DOUBLE))
      comment: "Average total usage hours per equipment asset. Used to assess asset utilization and inform replacement scheduling."
    - name: "calibration_overdue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN calibration_required_flag = TRUE AND calibration_due_date < CURRENT_DATE() THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment with overdue calibration. A compliance risk KPI — overdue calibration can invalidate batch records and trigger regulatory findings."
    - name: "gmp_qualified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_qualified_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment that is GMP-qualified. Measures the compliance readiness of the manufacturing asset base."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line capacity, efficiency, and compliance metrics. Used by manufacturing engineering and operations leadership to benchmark line performance, plan capacity investments, and manage GMP and environmental compliance."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_line`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the production line (e.g., Active, Idle, Under Maintenance), enabling capacity availability analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g., filling, packaging, blending), enabling performance benchmarking by line category."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation on the line, used to analyze the relationship between automation investment and OEE/throughput."
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the production line, critical for regulatory compliance segmentation."
    - name: "allergen_handling_flag"
      expr: allergen_handling_flag
      comment: "Indicates whether the line handles allergens, used for scheduling, cleaning validation, and regulatory compliance analysis."
    - name: "shift_pattern"
      expr: shift_pattern
      comment: "Shift pattern for the production line, enabling capacity analysis by shift configuration."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level line performance benchmarking."
    - name: "commissioning_date"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the line was commissioned, enabling asset age cohort analysis for capital planning."
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines. Baseline capacity asset count for manufacturing network planning."
    - name: "avg_design_capacity_units_per_hour"
      expr: AVG(CAST(design_capacity_units_per_hour AS DOUBLE))
      comment: "Average designed throughput capacity in units per hour. Establishes the theoretical maximum output baseline for capacity planning."
    - name: "avg_nominal_oee_target_percent"
      expr: AVG(CAST(nominal_oee_target_percent AS DOUBLE))
      comment: "Average OEE target across production lines. Used to set performance expectations and identify lines operating below target."
    - name: "avg_changeover_time_standard_minutes"
      expr: AVG(CAST(changeover_time_standard_minutes AS DOUBLE))
      comment: "Average standard changeover time in minutes. Changeover time is a key lever for increasing effective capacity — reducing it is a primary SMED/lean manufacturing objective."
    - name: "avg_scrap_rate_target_percent"
      expr: AVG(CAST(scrap_rate_target_percent AS DOUBLE))
      comment: "Average scrap rate target across production lines. Used as the benchmark for actual scrap performance comparison."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures across production lines. A reliability KPI used to prioritize maintenance investment and predict unplanned downtime risk."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average Mean Time To Repair across production lines. Measures maintenance responsiveness and its impact on production availability."
    - name: "avg_energy_consumption_kwh_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit produced. A sustainability and operational cost efficiency KPI, used to track progress against energy reduction targets."
    - name: "allergen_line_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN allergen_handling_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production lines handling allergens. Used for scheduling risk management and cleaning validation resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned order metrics covering demand fulfillment planning, order conversion rates, safety stock adequacy, and schedule adherence. Used by supply chain planners and S&OP leadership to manage production planning effectiveness and demand responsiveness."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`planned_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the planned order (e.g., Open, Firmed, Converted, Cancelled), enabling pipeline analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (e.g., production, purchase), enabling segmentation of make vs. buy demand."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Status of order conversion to production or purchase orders, measuring planning execution effectiveness."
    - name: "demand_source_type"
      expr: demand_source_type
      comment: "Source of demand driving the planned order (e.g., sales order, forecast, safety stock), enabling demand signal analysis."
    - name: "firmed_flag"
      expr: firmed_flag
      comment: "Indicates whether the planned order has been firmed, used to distinguish committed from tentative production plans."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "GMP compliance flag on the planned order, used for regulatory planning compliance analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned production start, enabling demand loading and capacity analysis by planning horizon."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level demand planning analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to SKU, enabling product-level demand planning and supply coverage analysis."
  measures:
    - name: "total_planned_orders"
      expr: COUNT(1)
      comment: "Total number of planned orders. Baseline planning volume metric for S&OP and capacity loading analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity. The primary demand signal metric for capacity planning and material requirements planning."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across planned orders. Used to assess inventory buffer adequacy against demand variability."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across planned orders. Used to evaluate replenishment trigger levels and prevent stockouts."
    - name: "firmed_order_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN firmed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of planned orders that have been firmed. Measures planning commitment and schedule stability — low firming rates indicate planning uncertainty."
    - name: "conversion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conversion_status = 'Converted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of planned orders converted to execution orders. A key planning effectiveness KPI — low conversion rates signal planning-to-execution gaps."
    - name: "avg_planned_quantity_per_order"
      expr: AVG(CAST(planned_quantity AS DOUBLE))
      comment: "Average planned quantity per order. Used to assess lot sizing efficiency and identify opportunities for batch consolidation."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing facility capacity, compliance, and sustainability metrics. Used by network strategy, regulatory affairs, and sustainability leadership to evaluate facility performance, compliance posture, and environmental footprint."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of manufacturing facility (e.g., primary manufacturing, packaging, warehouse), enabling network-level segmentation."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility, used to filter active vs. inactive sites in capacity analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., owned, leased, contract manufacturer), enabling make-vs-outsource network analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located, enabling geographic network analysis and regulatory jurisdiction segmentation."
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Indicates whether the facility holds GMP certification, a critical compliance dimension for regulated consumer goods."
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "ISO 9001 quality management certification status, used for quality system compliance reporting."
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "ISO 14001 environmental management certification status, used for sustainability compliance reporting."
    - name: "mes_system_integrated"
      expr: mes_system_integrated
      comment: "Indicates whether the facility has MES integration, used to assess digital manufacturing maturity."
    - name: "gmp_certification_date"
      expr: DATE_TRUNC('year', gmp_certification_date)
      comment: "Year of GMP certification, enabling analysis of certification recency and renewal planning."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of manufacturing facilities. Baseline network size metric for manufacturing footprint analysis."
    - name: "total_production_capacity_units_per_day"
      expr: SUM(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Total network production capacity in units per day. The primary capacity planning metric for supply network strategy and investment decisions."
    - name: "avg_production_capacity_units_per_day"
      expr: AVG(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Average production capacity per facility. Used to identify under-utilized or over-loaded facilities in the network."
    - name: "total_energy_consumption_kwh_per_year"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption across the manufacturing network. A top-tier sustainability KPI tied to carbon reduction commitments and energy cost management."
    - name: "total_water_consumption_cubic_meters_per_year"
      expr: SUM(CAST(water_consumption_cubic_meters_per_year AS DOUBLE))
      comment: "Total annual water consumption across the manufacturing network. A key environmental sustainability KPI for consumer goods companies with water stewardship commitments."
    - name: "gmp_certified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with active GMP certification. A critical regulatory compliance KPI — non-certified facilities cannot produce regulated products."
    - name: "mes_integration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN mes_system_integrated = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with MES integration. Measures digital manufacturing maturity — a strategic KPI for Industry 4.0 transformation programs."
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average facility size in square footage. Used for capacity density analysis and real estate portfolio optimization."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity, efficiency, and compliance metrics. Used by manufacturing engineering and operations management to optimize work center utilization, manage GMP qualification status, and plan maintenance."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`work_center`"
  dimensions:
    - name: "work_center_status"
      expr: work_center_status
      comment: "Current status of the work center (e.g., Active, Inactive, Under Qualification), enabling capacity availability analysis."
    - name: "work_center_type"
      expr: work_center_type
      comment: "Type of work center (e.g., mixing, filling, inspection), enabling performance benchmarking by work center category."
    - name: "gmp_qualification_status"
      expr: gmp_qualification_status
      comment: "GMP qualification status of the work center, critical for regulated manufacturing compliance and scheduling."
    - name: "category"
      expr: category
      comment: "Work center category, used for grouping and benchmarking similar work centers."
    - name: "clean_room_class"
      expr: clean_room_class
      comment: "Clean room classification of the work center, used for compliance and scheduling analysis in regulated environments."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Indicates whether the work center is temperature-controlled, used for product-line scheduling and compliance analysis."
    - name: "humidity_controlled_flag"
      expr: humidity_controlled_flag
      comment: "Indicates whether the work center is humidity-controlled, used for environmental compliance and scheduling."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to manufacturing facility, enabling facility-level work center performance analysis."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to production line, enabling line-level work center capacity and efficiency analysis."
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total number of work centers. Baseline capacity asset count for manufacturing network planning."
    - name: "avg_utilization_rate_percent"
      expr: AVG(CAST(utilization_rate_percent AS DOUBLE))
      comment: "Average work center utilization rate. A primary capacity management KPI — low utilization signals idle capacity; high utilization signals bottleneck risk."
    - name: "avg_efficiency_pct"
      expr: AVG(CAST(efficiency_pct AS DOUBLE))
      comment: "Average work center efficiency percentage. Measures how effectively work centers convert available time into productive output."
    - name: "total_available_capacity_hours_per_day"
      expr: SUM(CAST(available_capacity_hours_per_day AS DOUBLE))
      comment: "Total available capacity hours per day across all work centers. The primary input for capacity loading and constraint analysis."
    - name: "avg_standard_rate_per_hour"
      expr: AVG(CAST(standard_rate_per_hour AS DOUBLE))
      comment: "Average standard cost rate per hour across work centers. Used for production cost estimation and variance analysis."
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time per work center. A key lean manufacturing metric — reducing setup time increases effective capacity and scheduling flexibility."
    - name: "avg_standard_cycle_time_minutes"
      expr: AVG(CAST(standard_cycle_time_minutes AS DOUBLE))
      comment: "Average standard cycle time per work center. Used for takt time analysis and production scheduling."
    - name: "avg_energy_consumption_kwh_per_hour"
      expr: AVG(CAST(energy_consumption_kwh_per_hour AS DOUBLE))
      comment: "Average energy consumption per hour across work centers. Used for energy cost allocation and sustainability reporting."
    - name: "gmp_qualified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gmp_qualification_status = 'Qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of work centers with active GMP qualification. Measures the compliance readiness of the production floor for regulated manufacturing."
$$;