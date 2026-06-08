-- Metric views for domain: process | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_spc_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control measurement metrics tracking process stability, control violations, and specification compliance for semiconductor fabrication quality management"
  source: "`semiconductors_ecm`.`process`.`spc_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of SPC measurement performed (e.g., thickness, CD, overlay)"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the measured process parameter"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g., complete, pending, failed)"
    - name: "out_of_control_flag"
      expr: out_of_control_flag
      comment: "Boolean flag indicating if measurement violated control limits"
    - name: "out_of_spec_flag"
      expr: out_of_spec_flag
      comment: "Boolean flag indicating if measurement violated specification limits"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of measurement for daily trending"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement for monthly trending"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of SPC measurements recorded"
    - name: "out_of_control_count"
      expr: SUM(CASE WHEN out_of_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements that violated control limits"
    - name: "out_of_spec_count"
      expr: SUM(CASE WHEN out_of_spec_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measurements that violated specification limits"
    - name: "out_of_control_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements violating control limits - key process stability indicator"
    - name: "out_of_spec_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN out_of_spec_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements violating specification limits - key quality indicator"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all measurements"
    - name: "avg_deviation_from_target"
      expr: AVG(CAST(deviation_from_target AS DOUBLE))
      comment: "Average deviation from target value - process centering indicator"
    - name: "avg_sigma_level"
      expr: AVG(CAST(sigma_level AS DOUBLE))
      comment: "Average sigma level - process capability indicator"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_excursion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process excursion metrics tracking out-of-control events, yield impact, and containment effectiveness for semiconductor manufacturing quality control"
  source: "`semiconductors_ecm`.`process`.`excursion`"
  dimensions:
    - name: "excursion_type"
      expr: excursion_type
      comment: "Type of excursion (e.g., SPC violation, defect density, parametric)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the excursion (e.g., critical, major, minor)"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of affected material (e.g., scrap, rework, use-as-is)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of root cause investigation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of identified root cause (e.g., equipment, material, process)"
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the excursion (e.g., SPC, inspection, test)"
    - name: "detection_date"
      expr: DATE_TRUNC('day', detection_timestamp)
      comment: "Date excursion was detected"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month excursion was detected for monthly trending"
  measures:
    - name: "total_excursions"
      expr: COUNT(1)
      comment: "Total number of process excursions recorded"
    - name: "critical_excursions"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity excursions requiring immediate action"
    - name: "avg_estimated_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact percentage across excursions"
    - name: "total_estimated_financial_impact_usd"
      expr: SUM(CAST(estimated_financial_impact_usd AS DOUBLE))
      comment: "Total estimated financial impact of all excursions in USD"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter for excursions"
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of excursions requiring customer notification - customer impact indicator"
    - name: "containment_effectiveness_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN containment_action_taken IS NOT NULL AND containment_action_taken != '' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of excursions with documented containment actions - response effectiveness indicator"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_yield_loss_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield loss event metrics tracking yield detractors, root causes, and financial impact for semiconductor manufacturing yield management"
  source: "`semiconductors_ecm`.`process`.`yield_loss_event`"
  dimensions:
    - name: "yield_loss_mode"
      expr: yield_loss_mode
      comment: "Mode of yield loss (e.g., parametric, random defect, systematic defect)"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect causing yield loss"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (e.g., equipment, material, process, design)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the yield loss event"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the yield loss event"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the yield loss (e.g., inline inspection, final test)"
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer where yield loss occurred"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of yield loss event"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of yield loss event for monthly trending"
  measures:
    - name: "total_yield_loss_events"
      expr: COUNT(1)
      comment: "Total number of yield loss events recorded"
    - name: "avg_estimated_yield_impact_pct"
      expr: AVG(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Average estimated yield impact percentage - key yield detractor metric"
    - name: "total_estimated_yield_impact_pct"
      expr: SUM(CAST(estimated_yield_impact_percent AS DOUBLE))
      comment: "Total cumulative yield impact percentage across all events"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk) at time of yield loss"
    - name: "lot_hold_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN lot_hold_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield loss events resulting in lot holds - containment action rate"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status IN ('Resolved', 'Closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield loss events resolved - problem closure effectiveness"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_capability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process capability metrics tracking Cp, Cpk, Pp, Ppk indices and control status for semiconductor process qualification and monitoring"
  source: "`semiconductors_ecm`.`process`.`capability`"
  dimensions:
    - name: "capability_status"
      expr: capability_status
      comment: "Status of capability assessment (e.g., capable, marginal, incapable)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the process"
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the parameter being assessed for capability"
    - name: "process_area"
      expr: process_area
      comment: "Process area (e.g., lithography, etch, deposition)"
    - name: "process_layer"
      expr: process_layer
      comment: "Process layer being assessed"
    - name: "product_family"
      expr: product_family
      comment: "Product family for which capability is assessed"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Boolean flag indicating if corrective action is required"
    - name: "analysis_date"
      expr: DATE_TRUNC('day', analysis_timestamp)
      comment: "Date of capability analysis"
    - name: "analysis_month"
      expr: DATE_TRUNC('month', analysis_timestamp)
      comment: "Month of capability analysis for monthly trending"
  measures:
    - name: "total_capability_assessments"
      expr: COUNT(1)
      comment: "Total number of process capability assessments performed"
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Cpk (process capability index) - key process capability metric"
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Cp (process capability index without centering)"
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Ppk (process performance index) - long-term capability metric"
    - name: "avg_pp_index"
      expr: AVG(CAST(pp_index AS DOUBLE))
      comment: "Average Pp (process performance index without centering)"
    - name: "capable_process_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capability_status = 'Capable' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of processes assessed as capable - process maturity indicator"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of assessments requiring corrective action - process health indicator"
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average mean value of measured parameters"
    - name: "avg_standard_deviation"
      expr: AVG(CAST(standard_deviation AS DOUBLE))
      comment: "Average standard deviation - process variation indicator"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_defect_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect inspection metrics tracking defect density, defect types, and excursion detection for semiconductor wafer inspection quality control"
  source: "`semiconductors_ecm`.`process`.`defect_inspection_result`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., optical, e-beam, review)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the inspection (e.g., complete, pending, failed)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition of inspected material (e.g., pass, fail, review)"
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer inspected"
    - name: "excursion_detected"
      expr: excursion_detected
      comment: "Boolean flag indicating if an excursion was detected"
    - name: "review_required"
      expr: review_required
      comment: "Boolean flag indicating if defect review is required"
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Mode of inspection (e.g., full wafer, sample, hot spot)"
    - name: "inspection_date"
      expr: DATE_TRUNC('day', inspection_timestamp)
      comment: "Date of inspection"
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_timestamp)
      comment: "Month of inspection for monthly trending"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of defect inspections performed"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter - key yield indicator"
    - name: "excursion_detection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN excursion_detected = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections detecting excursions - process stability indicator"
    - name: "review_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN review_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring defect review - defect severity indicator"
    - name: "avg_inspected_area_cm2"
      expr: AVG(CAST(inspected_area_cm2 AS DOUBLE))
      comment: "Average inspected area per inspection in square centimeters"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with pass disposition - first pass yield indicator"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_metrology_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrology measurement metrics tracking dimensional control, uniformity, and specification compliance for semiconductor process control"
  source: "`semiconductors_ecm`.`process`.`metrology_measurement`"
  dimensions:
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of metrology measurement (e.g., CD, thickness, overlay)"
    - name: "measurement_parameter"
      expr: measurement_parameter
      comment: "Specific parameter being measured"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the measurement (e.g., complete, pending, failed)"
    - name: "disposition"
      expr: disposition
      comment: "Disposition based on measurement results"
    - name: "layer_name"
      expr: layer_name
      comment: "Process layer measured"
    - name: "measurement_mode"
      expr: measurement_mode
      comment: "Mode of measurement (e.g., production, engineering, qualification)"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp)
      comment: "Date of measurement"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of measurement for monthly trending"
  measures:
    - name: "total_measurements"
      expr: COUNT(1)
      comment: "Total number of metrology measurements performed"
    - name: "avg_mean_value"
      expr: AVG(CAST(mean_value AS DOUBLE))
      comment: "Average mean value across all measurements"
    - name: "avg_std_deviation"
      expr: AVG(CAST(std_deviation AS DOUBLE))
      comment: "Average standard deviation - process variation indicator"
    - name: "avg_uniformity_pct"
      expr: AVG(CAST(uniformity_percent AS DOUBLE))
      comment: "Average uniformity percentage - within-wafer variation indicator"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average Cpk value - process capability indicator"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average Cp value - process capability without centering"
    - name: "avg_three_sigma"
      expr: AVG(CAST(three_sigma AS DOUBLE))
      comment: "Average three-sigma value - process spread indicator"
    - name: "in_spec_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'Pass' OR disposition = 'In Spec' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements within specification - process yield indicator"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process qualification metrics tracking qualification status, yield performance, and customer approval for semiconductor process and product qualification programs"
  source: "`semiconductors_ecm`.`process`.`qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., process, product, equipment, material)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of qualification program"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of qualification (e.g., pass, fail, conditional)"
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for qualification"
    - name: "requires_customer_approval"
      expr: requires_customer_approval
      comment: "Boolean flag indicating if customer approval is required"
    - name: "risk_assessment"
      expr: risk_assessment
      comment: "Risk assessment level for the qualification"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year qualification started"
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month qualification started for monthly trending"
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of qualification programs"
    - name: "avg_actual_yield_pct"
      expr: AVG(CAST(actual_yield_percent AS DOUBLE))
      comment: "Average actual yield percentage achieved in qualification"
    - name: "avg_target_yield_pct"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target yield percentage for qualifications"
    - name: "avg_actual_cpk"
      expr: AVG(CAST(actual_cpk AS DOUBLE))
      comment: "Average actual Cpk achieved in qualification"
    - name: "avg_target_cpk"
      expr: AVG(CAST(target_cpk AS DOUBLE))
      comment: "Average target Cpk for qualifications"
    - name: "pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of qualifications passing - qualification success rate"
    - name: "customer_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN requires_customer_approval = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of customer-required qualifications approved - customer satisfaction indicator"
    - name: "on_time_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_completion_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of qualifications completed on or before target date - program execution effectiveness"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`process_change_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process change notification (PCN) metrics tracking change impact, approval status, and implementation for semiconductor manufacturing change management"
  source: "`semiconductors_ecm`.`process`.`change_notification`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., process, material, equipment, design)"
    - name: "change_classification"
      expr: change_classification
      comment: "Classification of change (e.g., major, minor, administrative)"
    - name: "change_status"
      expr: change_status
      comment: "Current status of change notification"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the change"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the change"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change (e.g., high, medium, low)"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Boolean flag indicating if customer notification is required"
    - name: "customer_approval_required"
      expr: customer_approval_required
      comment: "Boolean flag indicating if customer approval is required"
    - name: "notification_year"
      expr: YEAR(notification_date)
      comment: "Year change was notified"
    - name: "notification_month"
      expr: DATE_TRUNC('month', notification_date)
      comment: "Month change was notified for monthly trending"
  measures:
    - name: "total_change_notifications"
      expr: COUNT(1)
      comment: "Total number of process change notifications issued"
    - name: "avg_cycle_time_impact_hours"
      expr: AVG(CAST(cycle_time_impact_hours AS DOUBLE))
      comment: "Average cycle time impact in hours per change"
    - name: "avg_yield_impact_pct"
      expr: AVG(CAST(yield_impact_percent AS DOUBLE))
      comment: "Average yield impact percentage per change"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes approved - change approval effectiveness"
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes requiring customer notification - customer impact indicator"
    - name: "on_time_implementation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_implementation_date <= planned_implementation_date THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_implementation_date IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of changes implemented on or before planned date - change execution effectiveness"
    - name: "high_risk_change_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of high-risk changes - change risk profile indicator"
$$;