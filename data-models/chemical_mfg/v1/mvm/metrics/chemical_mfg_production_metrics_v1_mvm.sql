-- Metric views for domain: production | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:33:25

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_manufacturing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic manufacturing order KPIs tracking production efficiency, cost performance, and yield achievement across campaigns and work centers"
  source: "`chemical_mfg_ecm`.`production`.`manufacturing_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the manufacturing order (e.g., planned, released, in-progress, completed)"
    - name: "order_type"
      expr: order_type
      comment: "Type classification of the manufacturing order"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the manufacturing order"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month when the manufacturing order is scheduled to start"
    - name: "scheduled_finish_month"
      expr: DATE_TRUNC('MONTH', scheduled_finish_date)
      comment: "Month when the manufacturing order is scheduled to finish"
    - name: "cost_variance_flag"
      expr: cost_variance_flag
      comment: "Indicator whether the order has cost variance requiring attention"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicator whether the order has production deviations"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Indicator whether quality inspection is required for this order"
  measures:
    - name: "total_manufacturing_orders"
      expr: COUNT(1)
      comment: "Total count of manufacturing orders"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all manufacturing orders"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity achieved across all manufacturing orders"
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage achieved across manufacturing orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred across all manufacturing orders"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated production cost across all manufacturing orders"
    - name: "orders_with_cost_variance"
      expr: COUNT(CASE WHEN cost_variance_flag = TRUE THEN 1 END)
      comment: "Count of manufacturing orders with cost variance flags"
    - name: "orders_with_deviations"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Count of manufacturing orders with production deviation flags"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level production quality and yield KPIs tracking GMP compliance, yield performance, and quality status across chemical manufacturing batches"
  source: "`chemical_mfg_ecm`.`production`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g., in-progress, completed, released, quarantined)"
    - name: "review_status"
      expr: review_status
      comment: "Review status of the batch record"
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicator whether the batch meets Good Manufacturing Practice compliance requirements"
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Indicator whether the batch is under regulatory hold"
    - name: "coa_issued_flag"
      expr: coa_issued_flag
      comment: "Indicator whether Certificate of Analysis has been issued for the batch"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicator whether the batch has exceptions requiring attention"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month when the batch was manufactured"
    - name: "manufacturing_year"
      expr: YEAR(manufacturing_date)
      comment: "Year when the batch was manufactured"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total count of batch records"
    - name: "total_batch_size_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Total batch size quantity across all batches"
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total actual yield quantity produced across all batches"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage achieved across all batches"
    - name: "avg_process_temperature"
      expr: AVG(CAST(process_temperature_avg AS DOUBLE))
      comment: "Average process temperature across all batches"
    - name: "avg_process_pressure"
      expr: AVG(CAST(process_pressure_avg AS DOUBLE))
      comment: "Average process pressure across all batches"
    - name: "avg_process_ph"
      expr: AVG(CAST(process_ph_avg AS DOUBLE))
      comment: "Average process pH across all batches"
    - name: "gmp_compliant_batches"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of batches meeting GMP compliance requirements"
    - name: "batches_with_coa"
      expr: COUNT(CASE WHEN coa_issued_flag = TRUE THEN 1 END)
      comment: "Count of batches with Certificate of Analysis issued"
    - name: "batches_on_regulatory_hold"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Count of batches currently under regulatory hold"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_process_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process order execution KPIs tracking production efficiency, yield performance, and quality compliance for chemical process manufacturing"
  source: "`chemical_mfg_ecm`.`production`.`process_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the process order"
    - name: "order_type"
      expr: order_type
      comment: "Type classification of the process order"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code assigned to the process order"
    - name: "batch_size_category"
      expr: batch_size_category
      comment: "Category classification of the batch size"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the process order materials"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Indicator whether quality inspection is required for this process order"
    - name: "variance_flag"
      expr: variance_flag
      comment: "Indicator whether the process order has variance requiring attention"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when the process order is planned to start"
  measures:
    - name: "total_process_orders"
      expr: COUNT(1)
      comment: "Total count of process orders"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all process orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed production quantity across all process orders"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage achieved across process orders"
    - name: "orders_with_variance"
      expr: COUNT(CASE WHEN variance_flag = TRUE THEN 1 END)
      comment: "Count of process orders with variance flags"
    - name: "orders_requiring_inspection"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Count of process orders requiring quality inspection"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production yield performance KPIs tracking actual vs planned yield, efficiency scores, and waste generation across production lines"
  source: "`chemical_mfg_ecm`.`production`.`yield_record`"
  dimensions:
    - name: "quality_status"
      expr: quality_status
      comment: "Quality status of the yield record"
    - name: "yield_variance_flag"
      expr: yield_variance_flag
      comment: "Indicator whether the yield has variance exceeding threshold"
    - name: "waste_classification"
      expr: waste_classification
      comment: "Classification of waste generated during production"
    - name: "loss_reason_code"
      expr: loss_reason_code
      comment: "Reason code for yield loss"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where production occurred"
    - name: "production_line_code"
      expr: production_line_code
      comment: "Production line code where yield was recorded"
    - name: "production_month"
      expr: DATE_TRUNC('MONTH', production_start_timestamp)
      comment: "Month when production started"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total count of yield records"
    - name: "total_planned_yield_quantity"
      expr: SUM(CAST(planned_yield_quantity AS DOUBLE))
      comment: "Total planned yield quantity across all records"
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Total actual yield quantity produced across all records"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage achieved across all records"
    - name: "avg_yield_efficiency_score"
      expr: AVG(CAST(yield_efficiency_score AS DOUBLE))
      comment: "Average yield efficiency score across all records"
    - name: "total_yield_loss_quantity"
      expr: SUM(CAST(yield_loss_quantity AS DOUBLE))
      comment: "Total yield loss quantity across all records"
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity generated across all records"
    - name: "total_by_product_quantity"
      expr: SUM(CAST(by_product_quantity AS DOUBLE))
      comment: "Total by-product quantity generated across all records"
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost across all yield records"
    - name: "records_with_yield_variance"
      expr: COUNT(CASE WHEN yield_variance_flag = TRUE THEN 1 END)
      comment: "Count of yield records with variance exceeding threshold"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production campaign performance KPIs tracking OEE, cost variance, batch execution, and yield achievement across multi-batch production runs"
  source: "`chemical_mfg_ecm`.`production`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the production campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type classification of the production campaign"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the campaign"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicator whether the campaign has deviations"
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Indicator whether the campaign is under quality hold"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month when the campaign is scheduled to start"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total count of production campaigns"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all campaigns"
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity across all campaigns"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage achieved across campaigns"
    - name: "avg_oee_actual_percentage"
      expr: AVG(CAST(oee_actual_percentage AS DOUBLE))
      comment: "Average actual Overall Equipment Effectiveness percentage across campaigns"
    - name: "avg_oee_target_percentage"
      expr: AVG(CAST(oee_target_percentage AS DOUBLE))
      comment: "Average target Overall Equipment Effectiveness percentage across campaigns"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all campaigns"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost across all campaigns"
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage across campaigns"
    - name: "avg_changeover_time_hours"
      expr: AVG(CAST(changeover_time_hours AS DOUBLE))
      comment: "Average changeover time in hours across campaigns"
    - name: "avg_cip_duration_hours"
      expr: AVG(CAST(cip_duration_hours AS DOUBLE))
      comment: "Average Clean-In-Place duration in hours across campaigns"
    - name: "campaigns_with_deviations"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Count of campaigns with deviation flags"
    - name: "campaigns_on_quality_hold"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END)
      comment: "Count of campaigns under quality hold"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_work_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work center capacity and utilization KPIs tracking OEE targets, capacity utilization, and operational status across production work centers"
  source: "`chemical_mfg_ecm`.`production`.`work_center`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the work center"
    - name: "work_center_type"
      expr: work_center_type
      comment: "Type classification of the work center"
    - name: "work_center_category"
      expr: work_center_category
      comment: "Category classification of the work center"
    - name: "capacity_category"
      expr: capacity_category
      comment: "Capacity category of the work center"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "Good Manufacturing Practice classification of the work center"
    - name: "hazardous_area_classification"
      expr: hazardous_area_classification
      comment: "Hazardous area classification of the work center"
    - name: "cip_capable"
      expr: cip_clean_in_place_capable_flag
      comment: "Indicator whether the work center is Clean-In-Place capable"
    - name: "temperature_control_capable"
      expr: temperature_control_capability_flag
      comment: "Indicator whether the work center has temperature control capability"
    - name: "pressure_control_capable"
      expr: pressure_control_capability_flag
      comment: "Indicator whether the work center has pressure control capability"
  measures:
    - name: "total_work_centers"
      expr: COUNT(1)
      comment: "Total count of work centers"
    - name: "total_available_capacity_hours"
      expr: SUM(CAST(available_capacity_hours_per_day AS DOUBLE))
      comment: "Total available capacity hours per day across all work centers"
    - name: "avg_capacity_utilization_rate"
      expr: AVG(CAST(capacity_utilization_rate_percent AS DOUBLE))
      comment: "Average capacity utilization rate percentage across work centers"
    - name: "avg_oee_target_percent"
      expr: AVG(CAST(oee_target_percent AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness target percentage across work centers"
    - name: "avg_efficiency_factor_percent"
      expr: AVG(CAST(efficiency_factor_percent AS DOUBLE))
      comment: "Average efficiency factor percentage across work centers"
    - name: "avg_setup_time_minutes"
      expr: AVG(CAST(setup_time_minutes AS DOUBLE))
      comment: "Average setup time in minutes across work centers"
    - name: "avg_teardown_time_minutes"
      expr: AVG(CAST(teardown_time_minutes AS DOUBLE))
      comment: "Average teardown time in minutes across work centers"
    - name: "avg_maximum_batch_size"
      expr: AVG(CAST(maximum_batch_size AS DOUBLE))
      comment: "Average maximum batch size across work centers"
    - name: "avg_minimum_batch_size"
      expr: AVG(CAST(minimum_batch_size AS DOUBLE))
      comment: "Average minimum batch size across work centers"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production deviation and quality incident KPIs tracking OOS/OOT events, regulatory reportability, and corrective action effectiveness"
  source: "`chemical_mfg_ecm`.`production`.`production_deviation`"
  dimensions:
    - name: "production_deviation_status"
      expr: production_deviation_status
      comment: "Current status of the production deviation"
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type classification of the deviation"
    - name: "severity"
      expr: severity
      comment: "Severity level of the deviation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the deviation"
    - name: "hold_status"
      expr: hold_status
      comment: "Hold status of the deviation"
    - name: "oos_flag"
      expr: oos_flag
      comment: "Indicator whether the deviation is Out-of-Specification"
    - name: "oot_flag"
      expr: oot_flag
      comment: "Indicator whether the deviation is Out-of-Trend"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicator whether the deviation is reportable to regulatory authorities"
    - name: "customer_notification_required_flag"
      expr: customer_notification_required_flag
      comment: "Indicator whether customer notification is required for the deviation"
    - name: "moc_required_flag"
      expr: moc_required_flag
      comment: "Indicator whether Management of Change is required for the deviation"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when the deviation was detected"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total count of production deviations"
    - name: "oos_deviations"
      expr: COUNT(CASE WHEN oos_flag = TRUE THEN 1 END)
      comment: "Count of Out-of-Specification deviations"
    - name: "oot_deviations"
      expr: COUNT(CASE WHEN oot_flag = TRUE THEN 1 END)
      comment: "Count of Out-of-Trend deviations"
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of deviations reportable to regulatory authorities"
    - name: "deviations_requiring_customer_notification"
      expr: COUNT(CASE WHEN customer_notification_required_flag = TRUE THEN 1 END)
      comment: "Count of deviations requiring customer notification"
    - name: "deviations_requiring_moc"
      expr: COUNT(CASE WHEN moc_required_flag = TRUE THEN 1 END)
      comment: "Count of deviations requiring Management of Change"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_bom_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill-of-materials consumption variance KPIs tracking planned vs actual material usage, cost variance, and backflush accuracy"
  source: "`chemical_mfg_ecm`.`production`.`bom_consumption`"
  dimensions:
    - name: "movement_type"
      expr: movement_type
      comment: "Type of material movement (e.g., consumption, return, scrap)"
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Indicator whether the consumption was backflushed automatically"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicator whether the consumption transaction was reversed"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code where the consumption occurred"
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location code where material was consumed from"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the consumption was posted"
  measures:
    - name: "total_consumption_transactions"
      expr: COUNT(1)
      comment: "Total count of BOM consumption transactions"
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned consumption quantity across all transactions"
    - name: "total_actual_quantity_consumed"
      expr: SUM(CAST(actual_quantity_consumed AS DOUBLE))
      comment: "Total actual quantity consumed across all transactions"
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total variance quantity (actual minus planned) across all transactions"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across all consumption transactions"
    - name: "total_cost_amount"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total cost amount of consumed materials across all transactions"
    - name: "backflushed_transactions"
      expr: COUNT(CASE WHEN backflush_indicator = TRUE THEN 1 END)
      comment: "Count of consumption transactions that were backflushed"
    - name: "reversed_transactions"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of consumption transactions that were reversed"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_cip_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clean-In-Place effectiveness KPIs tracking cleaning cycle performance, GMP compliance, and equipment clearance for next production"
  source: "`chemical_mfg_ecm`.`production`.`cip_record`"
  dimensions:
    - name: "cip_status"
      expr: cip_status
      comment: "Current status of the CIP cleaning cycle"
    - name: "cip_type"
      expr: cip_type
      comment: "Type classification of the CIP cleaning cycle"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass or fail result of the CIP cleaning validation"
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Indicator whether the CIP cycle meets GMP compliance requirements"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicator whether the CIP cycle has deviations"
    - name: "next_production_clearance_flag"
      expr: next_production_clearance_flag
      comment: "Indicator whether the equipment is cleared for next production after CIP"
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the CIP cycle"
    - name: "cleaning_agent_name"
      expr: cleaning_agent_name
      comment: "Name of the cleaning agent used in the CIP cycle"
  measures:
    - name: "total_cip_cycles"
      expr: COUNT(1)
      comment: "Total count of CIP cleaning cycles"
    - name: "avg_cleaning_duration_minutes"
      expr: AVG(CAST(cleaning_duration_minutes AS DOUBLE))
      comment: "Average cleaning duration in minutes across CIP cycles"
    - name: "avg_cleaning_temperature_celsius"
      expr: AVG(CAST(cleaning_temperature_celsius AS DOUBLE))
      comment: "Average cleaning temperature in Celsius across CIP cycles"
    - name: "avg_cleaning_agent_concentration_ppm"
      expr: AVG(CAST(cleaning_agent_concentration_ppm AS DOUBLE))
      comment: "Average cleaning agent concentration in ppm across CIP cycles"
    - name: "avg_flow_rate_liters_per_minute"
      expr: AVG(CAST(flow_rate_liters_per_minute AS DOUBLE))
      comment: "Average flow rate in liters per minute across CIP cycles"
    - name: "avg_rinse_water_conductivity"
      expr: AVG(CAST(rinse_water_conductivity_us_cm AS DOUBLE))
      comment: "Average rinse water conductivity in microsiemens per centimeter across CIP cycles"
    - name: "gmp_compliant_cycles"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END)
      comment: "Count of CIP cycles meeting GMP compliance requirements"
    - name: "passed_cycles"
      expr: COUNT(CASE WHEN pass_fail_result = 'Pass' THEN 1 END)
      comment: "Count of CIP cycles that passed validation"
    - name: "cycles_with_deviations"
      expr: COUNT(CASE WHEN deviation_flag = TRUE THEN 1 END)
      comment: "Count of CIP cycles with deviations"
    - name: "cycles_cleared_for_production"
      expr: COUNT(CASE WHEN next_production_clearance_flag = TRUE THEN 1 END)
      comment: "Count of CIP cycles where equipment was cleared for next production"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`production_process_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process control and quality KPIs tracking specification violations, SPC control breaches, and alarm frequency across critical process parameters"
  source: "`chemical_mfg_ecm`.`production`.`process_parameter`"
  dimensions:
    - name: "parameter_status"
      expr: parameter_status
      comment: "Current status of the process parameter"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the process parameter being measured"
    - name: "phase_name"
      expr: phase_name
      comment: "Name of the process phase where parameter was measured"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source system or device that measured the parameter"
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Indicator whether an alarm was triggered for this parameter"
    - name: "specification_violation_flag"
      expr: specification_violation_flag
      comment: "Indicator whether the parameter violated specification limits"
    - name: "spc_violation_flag"
      expr: spc_violation_flag
      comment: "Indicator whether the parameter violated Statistical Process Control limits"
    - name: "quality_impact_flag"
      expr: quality_impact_flag
      comment: "Indicator whether the parameter deviation has quality impact"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Indicator whether corrective action is required for this parameter"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month when the parameter was measured"
  measures:
    - name: "total_parameter_measurements"
      expr: COUNT(1)
      comment: "Total count of process parameter measurements"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all parameter measurements"
    - name: "avg_set_point_value"
      expr: AVG(CAST(set_point_value AS DOUBLE))
      comment: "Average set point value across all parameter measurements"
    - name: "avg_deviation_value"
      expr: AVG(CAST(deviation_value AS DOUBLE))
      comment: "Average deviation value (measured minus set point) across measurements"
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average deviation percentage across all parameter measurements"
    - name: "alarms_triggered"
      expr: COUNT(CASE WHEN alarm_triggered_flag = TRUE THEN 1 END)
      comment: "Count of parameter measurements that triggered alarms"
    - name: "specification_violations"
      expr: COUNT(CASE WHEN specification_violation_flag = TRUE THEN 1 END)
      comment: "Count of parameter measurements violating specification limits"
    - name: "spc_violations"
      expr: COUNT(CASE WHEN spc_violation_flag = TRUE THEN 1 END)
      comment: "Count of parameter measurements violating SPC control limits"
    - name: "measurements_with_quality_impact"
      expr: COUNT(CASE WHEN quality_impact_flag = TRUE THEN 1 END)
      comment: "Count of parameter measurements with quality impact"
    - name: "measurements_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Count of parameter measurements requiring corrective action"
$$;