-- Metric views for domain: manufacturing | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core production order KPIs tracking order execution, cost variance, yield performance, and GMP compliance for manufacturing operations steering."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g., Released, In Progress, Completed, Cancelled)"
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g., Standard, Rework, Sample, Trial)"
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where the order is executed"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line assigned to the order"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being produced"
    - name: "brand_id"
      expr: marketing_brand_id
      comment: "Brand associated with the production order"
    - name: "gmp_compliant"
      expr: gmp_compliance_flag
      comment: "Whether the order meets Good Manufacturing Practice standards"
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Whether quality inspection is required for this order"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month when production was planned to start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month when production actually started"
    - name: "planned_end_month"
      expr: DATE_TRUNC('MONTH', planned_end_date)
      comment: "Month when production was planned to end"
    - name: "actual_end_month"
      expr: DATE_TRUNC('MONTH', actual_end_date)
      comment: "Month when production actually ended"
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders"
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders"
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total confirmed production quantity delivered"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity generated across orders"
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned production cost"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual production cost incurred"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage"
    - name: "order_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(order_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity that was confirmed (order fulfillment rate)"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(order_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of planned quantity that became scrap"
    - name: "cost_variance_amount"
      expr: SUM((CAST(actual_cost AS DOUBLE)) - (CAST(planned_cost AS DOUBLE)))
      comment: "Total cost variance (actual minus planned cost)"
    - name: "gmp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production orders that are GMP compliant"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch-level manufacturing KPIs tracking yield, quality, cost, and regulatory compliance for batch production steering and GMP audit readiness."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g., In Progress, Released, Quarantine, Rejected)"
    - name: "release_status"
      expr: release_status
      comment: "Quality release status of the batch"
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where the batch was produced"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line used for the batch"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU produced in the batch"
    - name: "brand_id"
      expr: marketing_brand_id
      comment: "Brand associated with the batch"
    - name: "gmp_compliant"
      expr: gmp_compliant_flag
      comment: "Whether the batch is GMP compliant"
    - name: "gmp_deviation_occurred"
      expr: gmp_deviation_flag
      comment: "Whether any GMP deviation occurred during batch production"
    - name: "quality_released"
      expr: quality_release_flag
      comment: "Whether the batch has been released by quality"
    - name: "recall_flagged"
      expr: recall_flag
      comment: "Whether the batch is flagged for recall"
    - name: "regulatory_hold"
      expr: regulatory_hold_flag
      comment: "Whether the batch is under regulatory hold"
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month when the batch was manufactured"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when the batch was released"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch records"
    - name: "total_batch_size_planned"
      expr: SUM(CAST(batch_size_planned AS DOUBLE))
      comment: "Total planned batch size across all batches"
    - name: "total_batch_size_actual"
      expr: SUM(CAST(batch_size_actual AS DOUBLE))
      comment: "Total actual batch size produced"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity requiring rework"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity generated"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost incurred for batch production"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost_amount AS DOUBLE))
      comment: "Total standard cost for batch production"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across batches"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage"
    - name: "batch_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(batch_size_actual AS DOUBLE)) / NULLIF(SUM(CAST(batch_size_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned batch size that was actually produced"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(batch_size_actual AS DOUBLE)), 0), 2)
      comment: "Percentage of actual production requiring rework"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(batch_size_actual AS DOUBLE)), 0), 2)
      comment: "Percentage of actual production that became scrap"
    - name: "cost_variance_amount"
      expr: SUM((CAST(actual_cost_amount AS DOUBLE)) - (CAST(standard_cost_amount AS DOUBLE)))
      comment: "Total cost variance (actual minus standard cost)"
    - name: "gmp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches that are GMP compliant"
    - name: "gmp_deviation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_deviation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches with GMP deviations"
    - name: "quality_release_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_release_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches released by quality"
    - name: "recall_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches flagged for recall"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_oee_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Overall Equipment Effectiveness (OEE) KPIs tracking availability, performance, and quality rates for production line optimization and capacity planning."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`oee_record`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where OEE was measured"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line being measured"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center being measured"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU being produced during the measurement period"
    - name: "shift_name"
      expr: shift_name
      comment: "Shift during which OEE was measured"
    - name: "oee_status"
      expr: oee_status
      comment: "Status of the OEE record (e.g., Validated, Draft, Under Review)"
    - name: "data_collection_method"
      expr: data_collection_method
      comment: "Method used to collect OEE data (e.g., Manual, MES, SCADA)"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month when the OEE record was created"
    - name: "shift_month"
      expr: DATE_TRUNC('MONTH', shift_date)
      comment: "Month of the shift being measured"
  measures:
    - name: "total_oee_records"
      expr: COUNT(1)
      comment: "Total number of OEE measurement records"
    - name: "avg_oee_percentage"
      expr: AVG(CAST(oee_percentage AS DOUBLE))
      comment: "Average Overall Equipment Effectiveness percentage"
    - name: "avg_availability_rate"
      expr: AVG(CAST(availability_rate AS DOUBLE))
      comment: "Average availability rate (uptime / planned production time)"
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate (actual output / theoretical output)"
    - name: "avg_quality_rate"
      expr: AVG(CAST(quality_rate AS DOUBLE))
      comment: "Average quality rate (good units / total units)"
    - name: "total_planned_production_time"
      expr: SUM(CAST(planned_production_time_minutes AS DOUBLE))
      comment: "Total planned production time in minutes"
    - name: "total_actual_operating_time"
      expr: SUM(CAST(actual_operating_time_minutes AS DOUBLE))
      comment: "Total actual operating time in minutes"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total downtime in minutes"
    - name: "total_changeover_time"
      expr: SUM(CAST(changeover_time_minutes AS DOUBLE))
      comment: "Total changeover time in minutes"
    - name: "total_quality_loss_minutes"
      expr: SUM(CAST(quality_loss_minutes AS DOUBLE))
      comment: "Total time lost due to quality issues in minutes"
    - name: "total_good_units_produced"
      expr: SUM(CAST(good_units_produced AS DOUBLE))
      comment: "Total number of good units produced"
    - name: "total_units_produced"
      expr: SUM(CAST(total_units_produced AS DOUBLE))
      comment: "Total number of units produced (good + defective)"
    - name: "total_units_rejected"
      expr: SUM(CAST(total_units_rejected AS BIGINT))
      comment: "Total number of units rejected"
    - name: "total_rework_units"
      expr: SUM(CAST(rework_units AS BIGINT))
      comment: "Total number of units requiring rework"
    - name: "availability_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_operating_time_minutes AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_time_minutes AS DOUBLE)), 0), 2)
      comment: "Availability rate as percentage of planned time"
    - name: "quality_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(good_units_produced AS DOUBLE)) / NULLIF(SUM(CAST(total_units_produced AS DOUBLE)), 0), 2)
      comment: "Quality yield as percentage of total units produced"
    - name: "downtime_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(downtime_minutes AS DOUBLE)) / NULLIF(SUM(CAST(planned_production_time_minutes AS DOUBLE)), 0), 2)
      comment: "Downtime as percentage of planned production time"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime event KPIs tracking frequency, duration, root causes, and financial impact for maintenance optimization and production reliability improvement."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`downtime_event`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where downtime occurred"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line affected by downtime"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center affected by downtime"
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime (e.g., Planned, Unplanned, Emergency)"
    - name: "downtime_category"
      expr: downtime_category
      comment: "Category of downtime (e.g., Equipment Failure, Material Shortage, Changeover)"
    - name: "downtime_reason_code"
      expr: downtime_reason_code
      comment: "Standardized reason code for the downtime"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause code identified for the downtime"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the downtime event"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the downtime event"
    - name: "is_planned"
      expr: is_planned
      comment: "Whether the downtime was planned"
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Whether the downtime event maintained GMP compliance"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether the downtime involved a safety incident"
    - name: "oee_impact_flag"
      expr: oee_impact_flag
      comment: "Whether the downtime impacted OEE metrics"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month when the downtime started"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total downtime duration in minutes"
    - name: "avg_downtime_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average downtime duration per event in minutes"
    - name: "total_production_loss_units"
      expr: SUM(CAST(production_loss_units AS DOUBLE))
      comment: "Total production units lost due to downtime"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of downtime events"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per downtime event"
    - name: "unplanned_downtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_planned = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events that were unplanned"
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_incident_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events involving safety incidents"
    - name: "gmp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of downtime events maintaining GMP compliance"
    - name: "mttr_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Mean Time To Repair (average resolution time) in minutes"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_changeover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Changeover performance KPIs tracking duration, efficiency, waste, and SMED improvement for production scheduling optimization and setup time reduction."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`changeover`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where changeover occurred"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line undergoing changeover"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center undergoing changeover"
    - name: "from_sku_id"
      expr: from_sku_id
      comment: "SKU being changed from"
    - name: "to_sku_id"
      expr: to_sku_id
      comment: "SKU being changed to"
    - name: "changeover_type"
      expr: changeover_type
      comment: "Type of changeover (e.g., Major, Minor, Format Change)"
    - name: "changeover_status"
      expr: changeover_status
      comment: "Status of the changeover (e.g., Completed, In Progress, Aborted)"
    - name: "cleaning_validated"
      expr: cleaning_validated_flag
      comment: "Whether cleaning was validated after changeover"
    - name: "gmp_cleaning_verified"
      expr: gmp_cleaning_verified_flag
      comment: "Whether GMP cleaning verification was completed"
    - name: "smed_improvement"
      expr: smed_improvement_flag
      comment: "Whether SMED (Single-Minute Exchange of Die) improvement was applied"
    - name: "equipment_adjustment_required"
      expr: equipment_adjustment_required_flag
      comment: "Whether equipment adjustment was required"
    - name: "tooling_change_required"
      expr: tooling_change_required_flag
      comment: "Whether tooling change was required"
    - name: "changeover_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when the changeover started"
  measures:
    - name: "total_changeovers"
      expr: COUNT(1)
      comment: "Total number of changeover events"
    - name: "total_actual_duration_minutes"
      expr: SUM(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Total actual changeover duration in minutes"
    - name: "total_standard_duration_minutes"
      expr: SUM(CAST(standard_duration_minutes AS DOUBLE))
      comment: "Total standard changeover duration in minutes"
    - name: "avg_actual_duration_minutes"
      expr: AVG(CAST(actual_duration_minutes AS DOUBLE))
      comment: "Average actual changeover duration in minutes"
    - name: "avg_standard_duration_minutes"
      expr: AVG(CAST(standard_duration_minutes AS DOUBLE))
      comment: "Average standard changeover duration in minutes"
    - name: "total_variance_minutes"
      expr: SUM(CAST(variance_minutes AS DOUBLE))
      comment: "Total variance between actual and standard duration in minutes"
    - name: "total_material_waste_kg"
      expr: SUM(CAST(material_waste_kg AS DOUBLE))
      comment: "Total material waste generated during changeovers in kilograms"
    - name: "avg_material_waste_kg"
      expr: AVG(CAST(material_waste_kg AS DOUBLE))
      comment: "Average material waste per changeover in kilograms"
    - name: "avg_first_pass_yield"
      expr: AVG(CAST(first_pass_yield_percentage AS DOUBLE))
      comment: "Average first pass yield percentage after changeover"
    - name: "avg_oee_impact"
      expr: AVG(CAST(oee_impact_percentage AS DOUBLE))
      comment: "Average OEE impact percentage due to changeover"
    - name: "changeover_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(standard_duration_minutes AS DOUBLE)) / NULLIF(SUM(CAST(actual_duration_minutes AS DOUBLE)), 0), 2)
      comment: "Changeover efficiency as percentage (standard / actual duration)"
    - name: "cleaning_validation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cleaning_validated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changeovers with validated cleaning"
    - name: "gmp_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_cleaning_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changeovers with GMP cleaning verification"
    - name: "smed_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN smed_improvement_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changeovers using SMED improvement techniques"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_gmp_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Good Manufacturing Practice event KPIs tracking deviations, CAPA requirements, regulatory notifications, and resolution performance for compliance steering and audit readiness."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`gmp_event`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where the GMP event occurred"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line associated with the GMP event"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU affected by the GMP event"
    - name: "event_type"
      expr: event_type
      comment: "Type of GMP event (e.g., Deviation, Out of Specification, Contamination)"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the GMP event (e.g., Critical, Major, Minor)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the GMP event (e.g., Open, Under Investigation, Closed)"
    - name: "batch_disposition"
      expr: batch_disposition
      comment: "Disposition decision for the affected batch (e.g., Released, Rejected, Rework)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of the root cause identified"
    - name: "capa_required"
      expr: capa_required_flag
      comment: "Whether Corrective and Preventive Action is required"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Whether regulatory notification is required"
    - name: "is_product_recall_trigger"
      expr: is_product_recall_trigger
      comment: "Whether the event could trigger a product recall"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month when the GMP event occurred"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when the GMP event was detected"
  measures:
    - name: "total_gmp_events"
      expr: COUNT(1)
      comment: "Total number of GMP events"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity affected by GMP events"
    - name: "avg_affected_quantity"
      expr: AVG(CAST(affected_quantity AS DOUBLE))
      comment: "Average quantity affected per GMP event"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across GMP events"
    - name: "capa_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GMP events requiring CAPA"
    - name: "regulatory_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GMP events requiring regulatory notification"
    - name: "recall_trigger_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_product_recall_trigger = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GMP events that could trigger product recall"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GMP events that are recurring"
    - name: "critical_events"
      expr: COUNT(CASE WHEN event_severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity GMP events"
    - name: "major_events"
      expr: COUNT(CASE WHEN event_severity = 'Major' THEN 1 END)
      comment: "Number of major severity GMP events"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing yield KPIs tracking actual vs planned yield, scrap, rework, and cost impact for process optimization and waste reduction steering."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`yield_record`"
  dimensions:
    - name: "sku_id"
      expr: sku_id
      comment: "SKU for which yield was recorded"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center where yield was measured"
    - name: "batch_record_status"
      expr: batch_record_status
      comment: "Status of the associated batch record"
    - name: "gmp_compliant"
      expr: gmp_compliance_flag
      comment: "Whether the yield record is GMP compliant"
    - name: "yield_loss_reason_code"
      expr: yield_loss_reason_code
      comment: "Standardized reason code for yield loss"
    - name: "record_month"
      expr: DATE_TRUNC('MONTH', record_date)
      comment: "Month when the yield record was created"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield records"
    - name: "total_input_quantity"
      expr: SUM(CAST(input_quantity AS DOUBLE))
      comment: "Total input quantity across all yield records"
    - name: "total_output_quantity"
      expr: SUM(CAST(output_quantity AS DOUBLE))
      comment: "Total output quantity produced"
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity generated"
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total rework quantity required"
    - name: "avg_actual_yield_percentage"
      expr: AVG(CAST(actual_yield_percentage AS DOUBLE))
      comment: "Average actual yield percentage"
    - name: "avg_planned_yield"
      expr: AVG(CAST(planned_yield AS DOUBLE))
      comment: "Average planned yield"
    - name: "avg_theoretical_yield_percentage"
      expr: AVG(CAST(theoretical_yield_percentage AS DOUBLE))
      comment: "Average theoretical yield percentage"
    - name: "avg_yield_variance_percentage"
      expr: AVG(CAST(yield_variance_percentage AS DOUBLE))
      comment: "Average yield variance percentage (actual vs planned)"
    - name: "total_yield_variance_cost_impact"
      expr: SUM(CAST(yield_variance_cost_impact AS DOUBLE))
      comment: "Total cost impact of yield variance"
    - name: "actual_yield_rate"
      expr: ROUND(100.0 * SUM(CAST(output_quantity AS DOUBLE)) / NULLIF(SUM(CAST(input_quantity AS DOUBLE)), 0), 2)
      comment: "Actual yield rate as percentage of input"
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(input_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap rate as percentage of input"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CAST(rework_quantity AS DOUBLE)) / NULLIF(SUM(CAST(output_quantity AS DOUBLE)), 0), 2)
      comment: "Rework rate as percentage of output"
    - name: "gmp_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield records that are GMP compliant"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment performance and maintenance KPIs tracking utilization, reliability (MTBF/MTTR), OEE, and calibration compliance for asset management and maintenance optimization."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`equipment`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where the equipment is located"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line where the equipment is installed"
    - name: "work_center_id"
      expr: work_center_id
      comment: "Work center where the equipment operates"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment (e.g., Mixer, Filler, Packaging Line)"
    - name: "equipment_status"
      expr: equipment_status
      comment: "Current operational status of the equipment"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status (e.g., Running, Idle, Maintenance, Decommissioned)"
    - name: "gmp_qualified"
      expr: gmp_qualified_flag
      comment: "Whether the equipment is GMP qualified"
    - name: "calibration_required"
      expr: calibration_required_flag
      comment: "Whether calibration is required for this equipment"
    - name: "manufacturer"
      expr: manufacturer_name
      comment: "Manufacturer of the equipment"
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month when the equipment was commissioned"
  measures:
    - name: "total_equipment"
      expr: COUNT(1)
      comment: "Total number of equipment assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of equipment"
    - name: "total_maintenance_cost"
      expr: SUM(CAST(maintenance_cost AS DOUBLE))
      comment: "Total maintenance cost incurred"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per equipment"
    - name: "avg_maintenance_cost"
      expr: AVG(CAST(maintenance_cost AS DOUBLE))
      comment: "Average maintenance cost per equipment"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mtbf_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mttr_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours"
    - name: "avg_oee_actual"
      expr: AVG(CAST(oee_actual AS DOUBLE))
      comment: "Average actual Overall Equipment Effectiveness"
    - name: "avg_oee_target"
      expr: AVG(CAST(oee_target AS DOUBLE))
      comment: "Average target Overall Equipment Effectiveness"
    - name: "avg_capacity_value"
      expr: AVG(CAST(capacity_value AS DOUBLE))
      comment: "Average capacity value of equipment"
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Total energy consumption in kilowatt-hours"
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh AS DOUBLE))
      comment: "Average energy consumption per equipment in kilowatt-hours"
    - name: "gmp_qualification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_qualified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment that is GMP qualified"
    - name: "calibration_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN calibration_required_flag = TRUE AND calibration_due_date >= CURRENT_DATE THEN 1 END) / NULLIF(COUNT(CASE WHEN calibration_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of equipment with current calibration (not overdue)"
    - name: "oee_achievement_rate"
      expr: ROUND(100.0 * AVG(CAST(oee_actual AS DOUBLE)) / NULLIF(AVG(CAST(oee_target AS DOUBLE)), 0), 2)
      comment: "OEE achievement rate (actual vs target)"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_production_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production line performance KPIs tracking capacity utilization, OEE targets, energy efficiency, and maintenance compliance for line optimization and capacity planning."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`production_line`"
  dimensions:
    - name: "facility_id"
      expr: manufacturing_facility_id
      comment: "Manufacturing facility where the production line is located"
    - name: "line_type"
      expr: line_type
      comment: "Type of production line (e.g., Filling, Packaging, Assembly)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the line"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation (e.g., Manual, Semi-Automated, Fully Automated)"
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the production line"
    - name: "allergen_handling"
      expr: allergen_handling_flag
      comment: "Whether the line handles allergens"
    - name: "environmental_control_required"
      expr: environmental_control_required
      comment: "Whether environmental control is required"
    - name: "scada_integration_enabled"
      expr: scada_integration_enabled
      comment: "Whether SCADA integration is enabled"
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month when the production line was commissioned"
  measures:
    - name: "total_production_lines"
      expr: COUNT(1)
      comment: "Total number of production lines"
    - name: "avg_design_capacity_per_hour"
      expr: AVG(CAST(design_capacity_units_per_hour AS DOUBLE))
      comment: "Average design capacity in units per hour"
    - name: "avg_design_speed_per_hour"
      expr: AVG(CAST(design_speed_units_per_hour AS DOUBLE))
      comment: "Average design speed in units per hour"
    - name: "avg_nominal_oee_target"
      expr: AVG(CAST(nominal_oee_target_percent AS DOUBLE))
      comment: "Average nominal OEE target percentage"
    - name: "avg_scrap_rate_target"
      expr: AVG(CAST(scrap_rate_target_percent AS DOUBLE))
      comment: "Average scrap rate target percentage"
    - name: "avg_changeover_time_standard"
      expr: AVG(CAST(changeover_time_standard_minutes AS DOUBLE))
      comment: "Average standard changeover time in minutes"
    - name: "avg_energy_consumption_per_unit"
      expr: AVG(CAST(energy_consumption_kwh_per_unit AS DOUBLE))
      comment: "Average energy consumption per unit in kilowatt-hours"
    - name: "total_installed_power_kw"
      expr: SUM(CAST(installed_power_kw AS DOUBLE))
      comment: "Total installed power capacity in kilowatts"
    - name: "avg_installed_power_kw"
      expr: AVG(CAST(installed_power_kw AS DOUBLE))
      comment: "Average installed power per line in kilowatts"
    - name: "avg_mtbf_hours"
      expr: AVG(CAST(mean_time_between_failures_hours AS DOUBLE))
      comment: "Average Mean Time Between Failures in hours"
    - name: "avg_mttr_hours"
      expr: AVG(CAST(mean_time_to_repair_hours AS DOUBLE))
      comment: "Average Mean Time To Repair in hours"
    - name: "avg_line_length_meters"
      expr: AVG(CAST(line_length_meters AS DOUBLE))
      comment: "Average production line length in meters"
    - name: "allergen_handling_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN allergen_handling_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production lines handling allergens"
    - name: "scada_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN scada_integration_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production lines with SCADA integration"
    - name: "environmental_control_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_control_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production lines requiring environmental control"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`manufacturing_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing facility KPIs tracking capacity, certification compliance, sustainability metrics, and operational status for network optimization and strategic planning."
  source: "`vibe_consumer_goods_v1`.`manufacturing`.`manufacturing_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of manufacturing facility (e.g., Production, Packaging, R&D Pilot)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (e.g., Owned, Leased, Contract Manufacturing)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the facility is located"
    - name: "gmp_certified"
      expr: gmp_certified
      comment: "Whether the facility is GMP certified"
    - name: "iso_9001_certified"
      expr: iso_9001_certified
      comment: "Whether the facility is ISO 9001 certified"
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Whether the facility is ISO 14001 certified"
    - name: "mes_system_integrated"
      expr: mes_system_integrated
      comment: "Whether Manufacturing Execution System is integrated"
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month when the facility was commissioned"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of manufacturing facilities"
    - name: "total_production_capacity_per_day"
      expr: SUM(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Total production capacity across all facilities in units per day"
    - name: "avg_production_capacity_per_day"
      expr: AVG(CAST(production_capacity_units_per_day AS DOUBLE))
      comment: "Average production capacity per facility in units per day"
    - name: "total_square_footage"
      expr: SUM(CAST(square_footage AS DOUBLE))
      comment: "Total square footage across all facilities"
    - name: "avg_square_footage"
      expr: AVG(CAST(square_footage AS DOUBLE))
      comment: "Average square footage per facility"
    - name: "total_energy_consumption_kwh"
      expr: SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Total annual energy consumption in kilowatt-hours"
    - name: "avg_energy_consumption_kwh"
      expr: AVG(CAST(energy_consumption_kwh_per_year AS DOUBLE))
      comment: "Average annual energy consumption per facility in kilowatt-hours"
    - name: "total_water_consumption_cubic_meters"
      expr: SUM(CAST(water_consumption_cubic_meters_per_year AS DOUBLE))
      comment: "Total annual water consumption in cubic meters"
    - name: "avg_water_consumption_cubic_meters"
      expr: AVG(CAST(water_consumption_cubic_meters_per_year AS DOUBLE))
      comment: "Average annual water consumption per facility in cubic meters"
    - name: "gmp_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are GMP certified"
    - name: "iso_9001_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_9001_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are ISO 9001 certified"
    - name: "iso_14001_certification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_14001_certified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are ISO 14001 certified"
    - name: "mes_integration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN mes_system_integrated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with MES system integration"
    - name: "energy_intensity_per_sqft"
      expr: ROUND(SUM(CAST(energy_consumption_kwh_per_year AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 2)
      comment: "Energy intensity in kilowatt-hours per square foot"
    - name: "water_intensity_per_sqft"
      expr: ROUND(SUM(CAST(water_consumption_cubic_meters_per_year AS DOUBLE)) / NULLIF(SUM(CAST(square_footage AS DOUBLE)), 0), 2)
      comment: "Water intensity in cubic meters per square foot"
$$;