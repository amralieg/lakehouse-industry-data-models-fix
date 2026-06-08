-- Metric views for domain: manufacturing | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level manufacturing performance metrics covering yield, scrap, rework, OEE, cost, and quality compliance. Primary KPI surface for production quality and efficiency steering."
  source: "`consumer_goods_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current lifecycle status of the batch (e.g. Released, In-Process, Rejected) — used to filter active vs. closed batches."
    - name: "manufacturing_date"
      expr: manufacturing_date
      comment: "Calendar date the batch was manufactured — primary time dimension for trend analysis."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to the manufacturing facility — enables site-level performance comparison."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level drill-down."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU — enables product-level yield and cost analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which actual cost amounts are denominated."
    - name: "gmp_deviation_flag"
      expr: gmp_deviation_flag
      comment: "Boolean flag indicating whether a GMP deviation occurred during this batch — critical for regulatory compliance segmentation."
    - name: "quality_release_flag"
      expr: quality_release_flag
      comment: "Boolean flag indicating whether the batch has been quality-released — used to separate released vs. held inventory."
    - name: "recall_flag"
      expr: recall_flag
      comment: "Boolean flag indicating whether this batch is subject to a product recall — high-priority risk dimension."
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Boolean flag indicating whether the batch is under a regulatory hold — compliance risk segmentation."
    - name: "bom_version"
      expr: bom_version
      comment: "Bill of materials version used for this batch — enables version-over-version yield comparison."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the batch — used for shelf-life and inventory risk analysis."
  measures:
    - name: "total_batches_produced"
      expr: COUNT(1)
      comment: "Total number of batch records — baseline volume measure for production throughput."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage across selected batches — core efficiency KPI; declining yield signals raw material waste or process drift."
    - name: "total_actual_batch_size"
      expr: SUM(CAST(batch_size_actual AS DOUBLE))
      comment: "Total actual output quantity across all batches — measures realized production volume."
    - name: "total_planned_batch_size"
      expr: SUM(CAST(batch_size_planned AS DOUBLE))
      comment: "Total planned output quantity across all batches — denominator for batch attainment rate calculation."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity generated — direct cost-of-quality indicator; high scrap drives material cost overruns."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity — measures non-conforming product requiring reprocessing; drives labor and overhead cost."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness (OEE) percentage at batch level — composite efficiency KPI used in operational steering reviews."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual manufacturing cost across batches — primary financial KPI for cost-of-goods-sold analysis."
    - name: "gmp_deviation_batch_count"
      expr: COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END)
      comment: "Number of batches with at least one GMP deviation — regulatory compliance KPI; high counts trigger quality investigations."
    - name: "recall_batch_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of batches subject to a product recall — critical risk metric reported to executive leadership and regulators."
    - name: "quality_released_batch_count"
      expr: COUNT(CASE WHEN quality_release_flag = TRUE THEN 1 END)
      comment: "Number of batches that have passed quality release — measures throughput of the quality release process."
    - name: "regulatory_hold_batch_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Number of batches currently under regulatory hold — compliance risk exposure metric."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution metrics covering schedule adherence, cost variance, yield, scrap, and OEE at the order level. Used by operations and finance to steer production efficiency and cost performance."
  source: "`consumer_goods_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g. Released, Confirmed, Closed, Cancelled) — primary lifecycle dimension."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g. Standard, Rework, Trial) — used to segment standard vs. non-standard production."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Planned start date of the production order — time dimension for schedule adherence analysis."
    - name: "scheduled_finish_date"
      expr: scheduled_finish_date
      comment: "Planned finish date of the production order — used to identify late orders."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level cost and efficiency comparison."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU — enables product-level production cost and yield analysis."
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Foreign key to the marketing brand — enables brand-level production performance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for cost amounts on this order."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance status of the production order — regulatory segmentation."
    - name: "priority"
      expr: priority
      comment: "Priority level of the production order — used to analyze whether high-priority orders are being fulfilled on time."
    - name: "plant_code"
      expr: plant_code
      comment: "ERP plant code associated with the production order — site-level grouping dimension."
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders — baseline volume measure for production planning throughput."
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders — measures planned output volume."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed (actual) production quantity — measures realized output; gap vs. order quantity reveals attainment shortfall."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across production orders — cost-of-quality KPI; high scrap drives material and overhead cost overruns."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned manufacturing cost across orders — budget baseline for cost variance analysis."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual manufacturing cost across orders — primary financial KPI for COGS and cost overrun detection."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders — efficiency KPI; declining yield signals process or material issues."
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage at production order level — composite equipment effectiveness KPI for operational steering."
    - name: "gmp_non_compliant_order_count"
      expr: COUNT(CASE WHEN gmp_compliance_flag = FALSE THEN 1 END)
      comment: "Number of production orders flagged as GMP non-compliant — regulatory risk KPI requiring immediate leadership attention."
    - name: "late_order_count"
      expr: COUNT(CASE WHEN actual_finish_timestamp > CAST(scheduled_finish_date AS TIMESTAMP) THEN 1 END)
      comment: "Number of production orders completed after their scheduled finish date — schedule adherence KPI; high counts indicate capacity or planning issues."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift-level OEE (Overall Equipment Effectiveness) metrics decomposed into availability, performance, and quality rates. The primary operational dashboard for manufacturing efficiency management."
  source: "`consumer_goods_ecm`.`manufacturing`.`oee_record`"
  dimensions:
    - name: "shift_date"
      expr: shift_date
      comment: "Date of the production shift — primary time dimension for daily and weekly OEE trend analysis."
    - name: "shift_name"
      expr: shift_name
      comment: "Name of the shift (e.g. Day, Night, Afternoon) — used to identify shift-level performance patterns."
    - name: "shift_number"
      expr: shift_number
      comment: "Shift number identifier — used for granular shift-over-shift comparison."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — primary grouping dimension for line-level OEE benchmarking."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to the manufacturing facility — enables site-level OEE comparison."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU — enables product-level OEE analysis to identify SKU-specific efficiency issues."
    - name: "oee_status"
      expr: oee_status
      comment: "Categorical OEE performance status (e.g. World Class, Acceptable, Poor) — quick segmentation for performance triage."
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect OEE data (e.g. MES automated, manual entry) — data quality dimension."
  measures:
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average OEE percentage — the headline manufacturing efficiency KPI used in all operational and executive reviews."
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average equipment availability rate — measures the proportion of planned time the equipment is actually running; low values indicate excessive downtime."
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate — measures how fast equipment runs relative to its ideal speed; low values indicate speed losses."
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate — measures the proportion of good units produced vs. total units; low values indicate high defect or rework rates."
    - name: "total_good_units_produced"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total good units produced across all shifts — primary throughput volume KPI for production planning and sales fulfillment."
    - name: "total_units_rejected"
      expr: SUM(CAST(total_units_rejected AS DOUBLE))
      comment: "Total units rejected — cost-of-quality KPI; high rejection rates drive scrap and rework costs."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes across all shifts — availability loss KPI; directly impacts production capacity and throughput."
    - name: "total_planned_production_time_minutes"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time in minutes — denominator for availability and utilization rate calculations."
    - name: "total_scrap_weight_kg"
      expr: SUM(CAST(scrap_weight_kg AS DOUBLE))
      comment: "Total scrap weight in kilograms — material waste KPI with direct cost and sustainability implications."
    - name: "total_rework_units"
      expr: SUM(CAST(rework_units AS DOUBLE))
      comment: "Total rework units — measures non-conforming product requiring reprocessing; drives hidden labor and overhead costs."
    - name: "total_speed_loss_minutes"
      expr: SUM(CAST(speed_loss_minutes AS DOUBLE))
      comment: "Total speed loss minutes — performance loss KPI; identifies where equipment is running below ideal cycle time."
    - name: "total_quality_loss_minutes"
      expr: SUM(CAST(quality_loss_minutes AS DOUBLE))
      comment: "Total quality loss minutes — time lost to producing defective units; links quality failures to capacity impact."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment and production downtime event metrics covering duration, financial impact, production loss, and root cause analysis. Used by operations and maintenance leadership to prioritize reliability investments."
  source: "`consumer_goods_ecm`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g. Planned Maintenance, Unplanned Breakdown, Changeover) — primary dimension for root cause analysis."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event — granular classification for maintenance and reliability analysis."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Coded root cause of the downtime event — used to identify systemic failure patterns driving reliability investments."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the downtime event — used to prioritize corrective actions and escalation."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the downtime event — used to track open vs. closed events."
    - name: "responsible_department"
      expr: responsible_department
      comment: "Department responsible for the downtime event — enables accountability and resource allocation analysis."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to the manufacturing facility — enables site-level downtime comparison."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level reliability analysis."
    - name: "equipment_id"
      expr: equipment_id
      comment: "Foreign key to the equipment — enables asset-level downtime and MTBF analysis."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Boolean flag indicating whether the downtime event involved a safety incident — critical risk dimension."
    - name: "oee_impact_flag"
      expr: oee_impact_flag
      comment: "Boolean flag indicating whether this downtime event impacted OEE — used to isolate OEE-relevant downtime."
    - name: "equipment_failure_mode"
      expr: equipment_failure_mode
      comment: "Failure mode of the equipment — used in reliability-centered maintenance analysis."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events — baseline frequency KPI for reliability trend analysis."
    - name: "total_downtime_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes — primary capacity loss KPI; directly impacts production throughput and OEE."
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event — proxy for Mean Time To Repair (MTTR); high values indicate slow recovery capability."
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of downtime events — monetizes reliability losses for executive and finance review."
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime — links reliability failures to output shortfalls and potential revenue loss."
    - name: "safety_incident_event_count"
      expr: COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of downtime events associated with a safety incident — critical EHS KPI reported to senior leadership."
    - name: "unresolved_downtime_event_count"
      expr: COUNT(CASE WHEN resolution_status != 'Resolved' THEN 1 END)
      comment: "Number of downtime events not yet resolved — operational risk KPI indicating open reliability issues."
    - name: "oee_impacting_event_count"
      expr: COUNT(CASE WHEN oee_impact_flag = TRUE THEN 1 END)
      comment: "Number of downtime events that directly impacted OEE — used to quantify the reliability contribution to OEE losses."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operation-level yield metrics covering actual vs. theoretical yield, scrap, rework, and cost impact of yield variance. Used by quality and operations leadership to drive continuous improvement."
  source: "`consumer_goods_ecm`.`manufacturing`.`yield_record`"
  dimensions:
    - name: "batch_number"
      expr: batch_number
      comment: "Batch number associated with the yield record — primary traceability dimension."
    - name: "batch_record_status"
      expr: batch_record_status
      comment: "Status of the batch record (e.g. Approved, Pending, Rejected) — used to filter analysis to approved records."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to the manufacturing facility — enables site-level yield benchmarking."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level yield analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU — enables product-level yield performance comparison."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code during which the yield was recorded — used to identify shift-level yield patterns."
    - name: "yield_loss_reason_code"
      expr: yield_loss_reason_code
      comment: "Coded reason for yield loss — primary dimension for root cause analysis of yield shortfalls."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance during the operation — regulatory segmentation for yield analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for yield variance cost impact amounts."
    - name: "routing_operation_number"
      expr: routing_operation_number
      comment: "Routing operation number — enables operation-level yield analysis within a multi-step process."
  measures:
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage — headline yield efficiency KPI; gap vs. theoretical yield drives material cost and waste analysis."
    - name: "avg_theoretical_yield_percentage"
      expr: AVG(CAST(theoretical_yield_percentage AS DOUBLE))
      comment: "Average theoretical yield percentage — benchmark for actual yield performance; used to compute yield gap."
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average yield variance percentage (actual minus theoretical) — measures systematic yield underperformance; negative values trigger process investigations."
    - name: "total_input_quantity"
      expr: SUM(CAST(input_quantity AS DOUBLE))
      comment: "Total input quantity consumed across all yield records — material consumption KPI for cost and sustainability analysis."
    - name: "total_output_quantity"
      expr: SUM(CAST(output_quantity AS DOUBLE))
      comment: "Total output quantity produced — realized production volume KPI."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity — material waste KPI with direct cost-of-goods impact."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity — hidden cost KPI; rework consumes labor and overhead without adding new output."
    - name: "total_yield_variance_cost_impact"
      expr: SUM(CAST(yield_variance_cost_impact AS DOUBLE))
      comment: "Total financial cost impact of yield variance — monetizes yield losses for finance and operations leadership; key input to standard cost review."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_production_confirmation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production confirmation (goods receipt) metrics covering actual vs. scheduled execution time, labor and machine utilization, scrap, yield, and OEE component rates. Used by operations to validate execution quality against plan."
  source: "`consumer_goods_ecm`.`manufacturing`.`production_confirmation`"
  dimensions:
    - name: "confirmation_type"
      expr: confirmation_type
      comment: "Type of production confirmation (e.g. Partial, Final, Reversal) — used to filter to meaningful confirmations."
    - name: "operation_status"
      expr: operation_status
      comment: "Status of the confirmed operation — used to segment completed vs. in-progress confirmations."
    - name: "posting_date"
      expr: posting_date
      comment: "Date the confirmation was posted to the ERP — primary time dimension for financial period analysis."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level execution analysis."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU — enables product-level execution performance analysis."
    - name: "shift_code"
      expr: shift_code
      comment: "Shift code for the confirmation — enables shift-level execution comparison."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance at confirmation — regulatory segmentation."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Boolean flag indicating whether this confirmation involved rework — used to isolate rework-related execution records."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Boolean flag indicating whether this confirmation was reversed — used to exclude reversals from production volume metrics."
    - name: "activity_type"
      expr: activity_type
      comment: "Activity type of the confirmation (e.g. Labor, Machine, Setup) — used to analyze time allocation by activity."
  measures:
    - name: "total_confirmations"
      expr: COUNT(1)
      comment: "Total number of production confirmations — baseline execution volume measure."
    - name: "total_confirmed_yield_quantity"
      expr: SUM(CAST(confirmed_yield_quantity AS DOUBLE))
      comment: "Total confirmed yield quantity — actual production output as recorded in the ERP; primary throughput KPI."
    - name: "total_confirmed_scrap_quantity"
      expr: SUM(CAST(confirmed_scrap_quantity AS DOUBLE))
      comment: "Total confirmed scrap quantity — cost-of-quality KPI; scrap confirmed in ERP drives material cost variance."
    - name: "total_actual_labor_time_minutes"
      expr: SUM(CAST(actual_labor_time_minutes AS DOUBLE))
      comment: "Total actual labor time in minutes — labor utilization KPI; compared against standard to identify labor efficiency gaps."
    - name: "total_actual_machine_time_minutes"
      expr: SUM(CAST(actual_machine_time_minutes AS DOUBLE))
      comment: "Total actual machine time in minutes — machine utilization KPI; compared against standard to identify capacity usage."
    - name: "total_actual_setup_time_minutes"
      expr: SUM(CAST(actual_setup_time_minutes AS DOUBLE))
      comment: "Total actual setup time in minutes — changeover efficiency KPI; excessive setup time reduces available production time."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime minutes recorded at confirmation — availability loss KPI at the operation level."
    - name: "avg_oee_availability_percent"
      expr: AVG(CAST(oee_availability_percent AS DOUBLE))
      comment: "Average OEE availability percentage at confirmation level — measures equipment uptime during confirmed operations."
    - name: "avg_oee_performance_percent"
      expr: AVG(CAST(oee_performance_percent AS DOUBLE))
      comment: "Average OEE performance percentage at confirmation level — measures speed efficiency during confirmed operations."
    - name: "avg_oee_quality_percent"
      expr: AVG(CAST(oee_quality_percent AS DOUBLE))
      comment: "Average OEE quality percentage at confirmation level — measures first-pass quality rate during confirmed operations."
    - name: "rework_confirmation_count"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Number of confirmations involving rework — quality and cost KPI; high rework counts indicate systemic process issues."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and reliability metrics covering OEE, MTBF, MTTR, maintenance cost, and energy consumption. Used by maintenance and operations leadership to prioritize capital investment and maintenance strategy."
  source: "`consumer_goods_ecm`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment (e.g. Filler, Labeler, Mixer) — primary dimension for asset class analysis."
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment (e.g. Active, Under Maintenance, Decommissioned) — used to filter active asset base."
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Foreign key to the manufacturing facility — enables site-level asset performance comparison."
    - name: "production_line_id"
      expr: production_line_id
      comment: "Foreign key to the production line — enables line-level equipment analysis."
    - name: "department"
      expr: department
      comment: "Department owning the equipment — used for departmental maintenance cost allocation."
    - name: "compliance_gmp"
      expr: compliance_gmp
      comment: "Boolean flag indicating whether the equipment is GMP-compliant — regulatory asset segmentation."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the equipment — EHS risk dimension for safety management."
    - name: "last_maintenance_date"
      expr: last_maintenance_date
      comment: "Date of the last maintenance activity — used to identify overdue maintenance and reliability risk."
    - name: "next_maintenance_due"
      expr: next_maintenance_due
      comment: "Date when next maintenance is due — forward-looking maintenance planning dimension."
  measures:
    - name: "total_equipment_count"
      expr: COUNT(1)
      comment: "Total number of equipment assets — baseline asset inventory count for capacity and investment planning."
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual OEE across equipment assets — headline asset efficiency KPI for maintenance and operations leadership."
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average OEE target across equipment assets — benchmark for actual OEE gap analysis."
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures (MTBF) in hours — reliability KPI; low MTBF indicates high breakdown frequency requiring maintenance investment."
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair (MTTR) in hours — maintainability KPI; high MTTR indicates slow recovery and extended production losses."
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost across equipment assets — financial KPI for maintenance budget management and make-vs-buy decisions."
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kWh across equipment — sustainability and operational cost KPI; high consumption drives energy efficiency investments."
    - name: "total_usage_hours"
      expr: SUM(CAST(total_usage_hours AS DOUBLE))
      comment: "Total accumulated usage hours across equipment — asset utilization and lifecycle management KPI."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`manufacturing_planned_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP/IBP planned order metrics covering planned quantity, safety stock, reorder points, and conversion status. Used by supply chain and production planning to assess planning accuracy and demand fulfillment readiness."
  source: "`consumer_goods_ecm`.`manufacturing`.`planned_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Status of the planned order (e.g. Open, Firmed, Converted, Cancelled) — primary lifecycle dimension for planning pipeline analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of planned order (e.g. Production, Purchase, Transfer) — used to segment manufacturing vs. procurement demand."
    - name: "conversion_status"
      expr: conversion_status
      comment: "Conversion status of the planned order — used to track how many planned orders have been converted to production orders."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Planned start date of the order — primary time dimension for planning horizon analysis."
    - name: "scheduled_finish_date"
      expr: scheduled_finish_date
      comment: "Planned finish date of the order — used to assess planning lead time and schedule feasibility."
    - name: "sku_id"
      expr: sku_id
      comment: "Foreign key to the SKU — enables product-level planning demand analysis."
    - name: "marketing_brand_id"
      expr: marketing_brand_id
      comment: "Foreign key to the marketing brand — enables brand-level production planning analysis."
    - name: "demand_source_type"
      expr: demand_source_type
      comment: "Source of demand driving the planned order (e.g. Sales Order, Forecast, Safety Stock) — used to understand demand signal composition."
    - name: "firming_indicator"
      expr: firming_indicator
      comment: "Boolean flag indicating whether the planned order has been firmed — used to distinguish firm vs. tentative planning."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Boolean flag indicating GMP compliance requirement for the planned order — regulatory planning dimension."
    - name: "planning_strategy_group"
      expr: planning_strategy_group
      comment: "MRP planning strategy group — used to segment make-to-stock vs. make-to-order planning behavior."
  measures:
    - name: "total_planned_orders"
      expr: COUNT(1)
      comment: "Total number of planned orders — baseline planning pipeline volume measure."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity — measures the volume of demand the planning system has scheduled; key input to capacity planning."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across planned orders — measures the buffer inventory being planned; high values indicate risk-driven over-planning."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity — measures the aggregate replenishment trigger level across the planning portfolio."
    - name: "converted_order_count"
      expr: COUNT(CASE WHEN conversion_status = 'Converted' THEN 1 END)
      comment: "Number of planned orders converted to production orders — measures planning execution rate; low conversion rates indicate planning-to-execution gaps."
    - name: "firmed_order_count"
      expr: COUNT(CASE WHEN firming_indicator = TRUE THEN 1 END)
      comment: "Number of firmed planned orders — measures the stability of the near-term production plan; low firming rates indicate planning volatility."
$$;