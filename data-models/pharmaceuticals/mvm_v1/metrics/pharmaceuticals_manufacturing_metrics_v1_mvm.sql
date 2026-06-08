-- Metric views for domain: manufacturing | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 21:06:11

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_batch_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core batch manufacturing performance metrics tracking yield efficiency, disposition outcomes, and quality compliance across all production batches. Used by manufacturing operations, quality, and supply chain leadership to steer batch release decisions and identify systemic yield or compliance issues."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`batch_record`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the batch (e.g. Released, Rejected, Quarantine) — primary filter for batch disposition analysis."
    - name: "batch_type"
      expr: batch_type
      comment: "Classification of the batch (e.g. Commercial, Validation, Clinical) — used to segment yield and quality metrics by production purpose."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition outcome (e.g. Approved, Rejected, Rework) — key dimension for release rate and rejection analysis."
    - name: "gmp_classification"
      expr: gmp_classification
      comment: "GMP classification of the batch — used to segment compliance and quality metrics by regulatory tier."
    - name: "sterilization_method"
      expr: sterilization_method
      comment: "Sterilization method applied to the batch — relevant for sterile manufacturing quality analysis."
    - name: "manufacture_month"
      expr: DATE_TRUNC('MONTH', manufacture_date)
      comment: "Month of manufacture — enables trending of batch yield and quality metrics over time."
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of batch disposition — used to track release cycle time trends."
    - name: "capa_required"
      expr: capa_required
      comment: "Indicates whether a CAPA was required for this batch — used to flag batches with quality events requiring corrective action."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Batch reconciliation status — used to identify batches with unresolved material reconciliation issues."
    - name: "pat_monitoring_enabled"
      expr: pat_monitoring_enabled
      comment: "Indicates whether Process Analytical Technology monitoring was active — used to compare yield and quality outcomes between PAT and non-PAT batches."
    - name: "qbd_design_space_compliance"
      expr: qbd_design_space_compliance
      comment: "Indicates whether the batch operated within the QbD design space — used to assess design space adherence and its impact on yield."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of batch records — baseline volume metric for manufacturing throughput analysis."
    - name: "total_actual_yield_quantity"
      expr: SUM(CAST(actual_yield_quantity AS DOUBLE))
      comment: "Sum of actual yield quantities across all batches — measures total manufactured output volume for supply planning and capacity analysis."
    - name: "total_theoretical_yield_quantity"
      expr: SUM(CAST(theoretical_yield_quantity AS DOUBLE))
      comment: "Sum of theoretical yield quantities — used as the denominator baseline for yield efficiency calculations."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average batch yield percentage — a primary manufacturing efficiency KPI. Declining yield signals process drift, raw material issues, or equipment degradation requiring immediate investigation."
    - name: "total_batch_size_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Total planned batch size quantity across all batches — used to measure planned production volume and compare against actual yield."
    - name: "batches_with_capa_required"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of batches requiring a CAPA — a quality risk indicator. High counts signal systemic manufacturing quality issues requiring leadership intervention."
    - name: "batches_rejected"
      expr: COUNT(CASE WHEN disposition_decision = 'Rejected' THEN 1 END)
      comment: "Number of batches with a rejected disposition decision — directly impacts supply availability and cost of goods. Executives use this to assess batch failure rates and financial exposure."
    - name: "batch_rejection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_decision = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches rejected — a critical quality and supply risk KPI. Elevated rejection rates trigger supply chain contingency planning and quality investigations."
    - name: "avg_manufacturing_cycle_hours"
      expr: AVG(CAST((unix_timestamp(manufacturing_end_timestamp) - unix_timestamp(manufacturing_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average manufacturing cycle time in hours from start to end timestamp — a throughput efficiency KPI. Longer cycle times reduce capacity utilization and increase cost per batch."
    - name: "batches_env_monitoring_compliant"
      expr: COUNT(CASE WHEN environmental_monitoring_compliant = TRUE THEN 1 END)
      comment: "Number of batches with environmental monitoring compliance confirmed — a GMP compliance indicator used to assess site-level environmental control effectiveness."
    - name: "env_monitoring_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_monitoring_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches meeting environmental monitoring compliance requirements — a regulatory compliance KPI. Non-compliance can trigger regulatory action and batch rejection."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order execution metrics tracking planned vs. actual output, yield efficiency, scrap, and schedule adherence. Used by manufacturing operations and supply chain leadership to manage production performance, identify capacity gaps, and optimize order fulfillment."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`production_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the production order (e.g. Released, Completed, Cancelled) — primary filter for active vs. closed order analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of production order (e.g. Standard, Rework, Validation) — used to segment performance metrics by production purpose."
    - name: "priority"
      expr: priority
      comment: "Order priority level — used to assess whether high-priority orders are meeting schedule and yield targets."
    - name: "rework_flag"
      expr: rework_flag
      comment: "Indicates whether the order is a rework order — used to quantify rework volume and its impact on capacity and cost."
    - name: "validation_batch_flag"
      expr: validation_batch_flag
      comment: "Indicates whether the order is a validation batch — used to separate commercial production metrics from validation activities."
    - name: "pat_enabled_flag"
      expr: pat_enabled_flag
      comment: "Indicates whether PAT was enabled for this order — used to compare yield and efficiency outcomes between PAT and non-PAT orders."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Material reconciliation status of the order — used to identify orders with unresolved material balance issues."
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month of scheduled production start — enables trending of order volume and performance over time."
    - name: "scheduled_finish_month"
      expr: DATE_TRUNC('MONTH', scheduled_finish_date)
      comment: "Month of scheduled production finish — used for capacity planning and schedule adherence analysis."
  measures:
    - name: "total_production_orders"
      expr: COUNT(1)
      comment: "Total number of production orders — baseline volume metric for manufacturing throughput and capacity utilization analysis."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned production quantity across all orders — used to measure planned manufacturing output for supply planning."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total actual production quantity across all orders — measures realized manufacturing output. Gap vs. planned quantity signals capacity or execution shortfalls."
    - name: "total_scrap_quantity"
      expr: SUM(CAST(scrap_quantity AS DOUBLE))
      comment: "Total scrap quantity across all production orders — a direct cost-of-quality metric. High scrap drives up cost of goods and reduces supply availability."
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across production orders — a primary manufacturing efficiency KPI used to benchmark process performance and identify underperforming lines or products."
    - name: "production_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Ratio of actual to planned production quantity expressed as a percentage — a key supply reliability KPI. Values below 95% trigger supply risk escalation and capacity review."
    - name: "scrap_rate"
      expr: ROUND(100.0 * SUM(CAST(scrap_quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0), 2)
      comment: "Scrap quantity as a percentage of planned quantity — a cost-of-quality KPI. Elevated scrap rates directly increase cost of goods sold and reduce supply availability."
    - name: "rework_order_count"
      expr: COUNT(CASE WHEN rework_flag = TRUE THEN 1 END)
      comment: "Number of rework production orders — a quality and efficiency KPI. High rework volumes indicate systemic process or material quality issues consuming capacity."
    - name: "rework_order_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production orders that are rework orders — used to assess the burden of quality failures on manufacturing capacity."
    - name: "avg_actual_cycle_hours"
      expr: AVG(CAST((unix_timestamp(actual_finish_timestamp) - unix_timestamp(actual_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average actual production cycle time in hours — a throughput efficiency KPI. Longer cycle times reduce line utilization and increase cost per unit."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Manufacturing deviation metrics tracking frequency, severity, root cause distribution, and investigation cycle times. Used by quality, manufacturing, and regulatory leadership to manage GMP compliance risk, prioritize CAPA investments, and assess regulatory reportability exposure."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`manufacturing_deviation`"
  dimensions:
    - name: "deviation_category"
      expr: deviation_category
      comment: "Category of the manufacturing deviation (e.g. Process, Equipment, Material) — used to identify systemic root cause patterns."
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type of deviation — provides granular classification for root cause and trend analysis."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the deviation (e.g. Critical, Major, Minor) — primary filter for risk-based prioritization of quality investigations."
    - name: "manufacturing_deviation_status"
      expr: manufacturing_deviation_status
      comment: "Current status of the deviation record (e.g. Open, Closed, Under Investigation) — used to track open quality event backlog."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the deviation — used to identify systemic manufacturing process weaknesses driving recurring deviations."
    - name: "detection_phase"
      expr: detection_phase
      comment: "Manufacturing phase during which the deviation was detected — used to identify process steps with highest deviation frequency."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the deviation is reportable to a regulatory authority — used to track regulatory exposure and submission obligations."
    - name: "cmo_cdmo_flag"
      expr: cmo_cdmo_flag
      comment: "Indicates whether the deviation occurred at a CMO/CDMO site — used to assess third-party manufacturing quality performance."
    - name: "product_disposition"
      expr: product_disposition
      comment: "Disposition of the affected product following the deviation — used to quantify supply impact of quality events."
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month of deviation occurrence — enables trending of deviation frequency over time to detect process deterioration."
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of manufacturing deviations — baseline quality event volume metric used to track GMP compliance burden and trend quality performance."
    - name: "critical_deviations"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity deviations — a top-tier quality risk KPI. Critical deviations can trigger batch rejection, regulatory reporting, and supply disruption."
    - name: "critical_deviation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations classified as critical — used to assess the severity profile of the quality event portfolio and prioritize investigation resources."
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of deviations requiring regulatory reporting — a direct regulatory compliance KPI. Executives use this to manage regulatory submission obligations and agency relationship risk."
    - name: "open_deviations"
      expr: COUNT(CASE WHEN manufacturing_deviation_status = 'Open' THEN 1 END)
      comment: "Number of currently open deviation records — a quality backlog KPI. High open counts indicate investigation resource constraints or systemic quality issues."
    - name: "avg_investigation_cycle_days"
      expr: AVG(CAST(datediff(investigation_completion_date, investigation_start_date) AS DOUBLE))
      comment: "Average number of days to complete a deviation investigation — a quality process efficiency KPI. Long investigation cycles delay batch disposition and increase supply risk."
    - name: "avg_closure_cycle_days"
      expr: AVG(CAST(datediff(closure_date, detection_date) AS DOUBLE))
      comment: "Average number of days from deviation detection to closure — an end-to-end quality event resolution KPI. Prolonged closure cycles signal resource or process bottlenecks in quality management."
    - name: "cmo_cdmo_deviations"
      expr: COUNT(CASE WHEN cmo_cdmo_flag = TRUE THEN 1 END)
      comment: "Number of deviations originating at CMO/CDMO sites — used to assess third-party manufacturing quality performance and inform outsourcing risk decisions."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_process_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process parameter control and conformance metrics tracking in-process control adherence, specification compliance, and critical process parameter performance. Used by manufacturing science, quality, and regulatory teams to assess process capability and identify parameters driving out-of-specification events."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`process_parameter`"
  dimensions:
    - name: "parameter_type"
      expr: parameter_type
      comment: "Type of process parameter (e.g. Critical Process Parameter, Key Process Attribute) — used to segment conformance metrics by regulatory criticality."
    - name: "parameter_name"
      expr: parameter_name
      comment: "Name of the process parameter — used to identify specific parameters with high out-of-specification rates."
    - name: "conformance_status"
      expr: conformance_status
      comment: "Conformance status of the parameter result (e.g. Conforming, Non-Conforming) — primary filter for process control analysis."
    - name: "pat_enabled_flag"
      expr: pat_enabled_flag
      comment: "Indicates whether PAT was used to measure this parameter — used to compare conformance rates between PAT and traditional measurement methods."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether a non-conformance on this parameter is regulatory reportable — used to prioritize investigation of high-regulatory-risk parameters."
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Indicates whether an investigation was triggered by this parameter result — used to track investigation burden from process parameter excursions."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure the parameter — used to assess measurement system performance and identify method-related variability."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of parameter measurement — enables trending of process conformance over time."
  measures:
    - name: "total_parameter_measurements"
      expr: COUNT(1)
      comment: "Total number of process parameter measurements — baseline volume metric for process monitoring coverage analysis."
    - name: "non_conforming_parameters"
      expr: COUNT(CASE WHEN conformance_status = 'Non-Conforming' THEN 1 END)
      comment: "Number of non-conforming process parameter results — a direct process quality KPI. High counts signal process capability issues requiring manufacturing science investigation."
    - name: "parameter_conformance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN conformance_status = 'Conforming' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process parameter measurements in conformance — a core process capability KPI used to assess manufacturing process control effectiveness."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual measured value across all process parameter results — used to assess central tendency and detect systematic process drift from target."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across process parameters — used as the reference baseline for process drift analysis."
    - name: "parameters_requiring_investigation"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END)
      comment: "Number of parameter results triggering an investigation — a quality workload and process risk KPI. High counts indicate process instability consuming quality investigation resources."
    - name: "regulatory_reportable_excursions"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of process parameter results with regulatory reportability — used to track regulatory submission obligations arising from process excursions."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_process_validation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process validation lifecycle metrics tracking validation status, outcomes, and compliance across manufacturing processes. Used by manufacturing science, quality, and regulatory leadership to ensure validated state of manufacturing processes and manage revalidation obligations."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`process_validation`"
  dimensions:
    - name: "validation_status"
      expr: validation_status
      comment: "Current status of the process validation (e.g. Approved, In Progress, Expired) — primary filter for validated state management."
    - name: "validation_type"
      expr: validation_type
      comment: "Type of validation (e.g. Prospective, Concurrent, Retrospective) — used to segment validation portfolio by regulatory approach."
    - name: "validation_stage"
      expr: validation_stage
      comment: "Stage of the validation lifecycle (e.g. PPQ, Continued Process Verification) — used to track validation maturity across the product portfolio."
    - name: "validation_outcome"
      expr: validation_outcome
      comment: "Outcome of the validation execution (e.g. Passed, Failed, Conditional) — used to assess validation success rates and identify processes requiring remediation."
    - name: "validation_approach"
      expr: validation_approach
      comment: "Scientific approach used for validation (e.g. QbD, Traditional) — used to track adoption of modern validation approaches."
    - name: "pat_implementation"
      expr: pat_implementation
      comment: "Indicates whether PAT was implemented in the validated process — used to assess PAT adoption across the validated process portfolio."
    - name: "design_space_defined"
      expr: design_space_defined
      comment: "Indicates whether a QbD design space was defined for this process — used to track QbD implementation maturity."
    - name: "execution_start_month"
      expr: DATE_TRUNC('MONTH', execution_start_date)
      comment: "Month of validation execution start — enables trending of validation activity volume over time."
  measures:
    - name: "total_validations"
      expr: COUNT(1)
      comment: "Total number of process validation records — baseline metric for validation portfolio size and activity volume."
    - name: "validations_passed"
      expr: COUNT(CASE WHEN validation_outcome = 'Passed' THEN 1 END)
      comment: "Number of validations with a passed outcome — a regulatory compliance KPI. Executives use this to confirm that manufacturing processes are in a validated state for commercial supply."
    - name: "validation_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN validation_outcome = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of process validations that passed — a strategic quality KPI. Low pass rates signal process development gaps and can block regulatory submissions and commercial launch."
    - name: "validations_with_deviations"
      expr: COUNT(CASE WHEN deviation_count IS NOT NULL AND deviation_count != '0' THEN 1 END)
      comment: "Number of validations that recorded deviations during execution — used to assess validation execution quality and identify processes with elevated risk profiles."
    - name: "avg_validation_duration_days"
      expr: AVG(CAST(datediff(execution_end_date, execution_start_date) AS DOUBLE))
      comment: "Average duration of process validation execution in days — a validation efficiency KPI. Long validation cycles delay product launches and increase development costs."
    - name: "avg_batch_size_max"
      expr: AVG(CAST(batch_size_max AS DOUBLE))
      comment: "Average maximum validated batch size — used to assess manufacturing scale capability across the validated process portfolio."
    - name: "validations_with_oos"
      expr: COUNT(CASE WHEN oos_count IS NOT NULL AND oos_count != '0' THEN 1 END)
      comment: "Number of validations with out-of-specification results — a critical quality risk KPI. OOS results during validation can invalidate the process and require root cause investigation before regulatory submission."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_equipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment asset performance and qualification metrics tracking calibration compliance, qualification status, and GMP-critical asset readiness. Used by manufacturing engineering, quality, and finance leadership to manage equipment availability, compliance risk, and capital asset performance."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`equipment`"
  dimensions:
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment (e.g. Mixer, Tablet Press, Autoclave) — used to segment performance and compliance metrics by equipment category."
    - name: "equipment_category"
      expr: equipment_category
      comment: "Category of equipment — provides a higher-level grouping for asset portfolio analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the equipment (e.g. Active, Under Maintenance, Decommissioned) — primary filter for available capacity analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the equipment (e.g. Qualified, Expired, Pending) — a GMP compliance dimension used to identify equipment requiring requalification."
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the equipment — used to identify equipment with overdue or failed calibrations that pose GMP compliance risk."
    - name: "gmp_critical_flag"
      expr: gmp_critical_flag
      comment: "Indicates whether the equipment is GMP-critical — used to prioritize compliance monitoring and maintenance for high-risk assets."
    - name: "csv_status"
      expr: csv_status
      comment: "Computer System Validation status of the equipment — used to track CSV compliance for computerized manufacturing systems."
    - name: "clean_room_classification"
      expr: clean_room_classification
      comment: "Clean room classification of the equipment location — used to segment equipment compliance metrics by environmental control tier."
    - name: "commissioning_year"
      expr: DATE_TRUNC('YEAR', commissioning_date)
      comment: "Year of equipment commissioning — used to analyze asset age distribution and plan capital replacement cycles."
  measures:
    - name: "total_equipment_assets"
      expr: COUNT(1)
      comment: "Total number of equipment assets — baseline metric for asset portfolio size used in capacity and compliance planning."
    - name: "gmp_critical_equipment_count"
      expr: COUNT(CASE WHEN gmp_critical_flag = TRUE THEN 1 END)
      comment: "Number of GMP-critical equipment assets — used to size the compliance monitoring and qualification workload for high-risk manufacturing assets."
    - name: "equipment_qualified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment assets in a qualified state — a GMP compliance KPI. Equipment operating outside qualified state creates regulatory risk and can invalidate batch records."
    - name: "equipment_calibration_compliant_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN calibration_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment assets with compliant calibration status — a GMP compliance KPI. Non-compliant calibration can invalidate measurement data and trigger batch rejection."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of equipment assets — a capital asset management KPI used by finance and manufacturing leadership to assess capital investment in manufacturing infrastructure."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per equipment asset — used to benchmark capital investment levels and inform future equipment procurement decisions."
    - name: "avg_capacity_value"
      expr: AVG(CAST(capacity_value AS DOUBLE))
      comment: "Average capacity value across equipment assets — used to assess manufacturing capacity per asset and identify capacity expansion opportunities."
    - name: "equipment_overdue_calibration"
      expr: COUNT(CASE WHEN next_calibration_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of equipment assets with overdue calibration — a GMP compliance risk KPI. Overdue calibrations must be resolved before the equipment can be used in GMP manufacturing."
    - name: "equipment_overdue_qualification"
      expr: COUNT(CASE WHEN next_qualification_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of equipment assets with overdue qualification — a regulatory compliance KPI. Unqualified equipment cannot be used in GMP production without risk of batch rejection."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_production_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production schedule adherence and capacity utilization metrics used by manufacturing operations and supply chain leadership to assess schedule execution efficiency, capacity loading, and planning horizon performance."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`production_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the production schedule (e.g. Planned, Frozen, Executed, Cancelled) — primary filter for schedule execution analysis."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of production schedule (e.g. Master, Detailed, Campaign) — used to segment capacity and adherence metrics by planning horizon."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of manufacturing campaign — used to analyze capacity utilization and schedule performance by campaign category."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the scheduled production run — used to assess whether high-priority schedules are being executed on time."
    - name: "cmo_cdmo_flag"
      expr: cmo_cdmo_flag
      comment: "Indicates whether the schedule is for a CMO/CDMO site — used to compare internal vs. external manufacturing schedule performance."
    - name: "cgmp_compliance_flag"
      expr: cgmp_compliance_flag
      comment: "Indicates whether the schedule was executed under cGMP conditions — used to track GMP compliance of scheduled production."
    - name: "pat_implementation_flag"
      expr: pat_implementation_flag
      comment: "Indicates whether PAT was implemented in the scheduled production — used to track PAT adoption across the production schedule."
    - name: "planning_period_start_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month of planning period start — enables trending of scheduled capacity and utilization over planning horizons."
    - name: "downtime_reason"
      expr: downtime_reason
      comment: "Reason for scheduled downtime — used to analyze the root causes of capacity loss and prioritize maintenance or process improvement investments."
  measures:
    - name: "total_scheduled_runs"
      expr: COUNT(1)
      comment: "Total number of production schedule records — baseline metric for manufacturing schedule volume and planning activity."
    - name: "avg_capacity_utilization_percent"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across scheduled production runs — a primary manufacturing efficiency KPI. Low utilization signals underloaded assets; high utilization signals supply risk from insufficient buffer capacity."
    - name: "total_scheduled_duration_hours"
      expr: SUM(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Total scheduled production duration in hours — used to measure planned manufacturing capacity consumption and assess line loading."
    - name: "avg_scheduled_duration_hours"
      expr: AVG(CAST(scheduled_duration_hours AS DOUBLE))
      comment: "Average scheduled production run duration in hours — used to benchmark run length efficiency and identify scheduling optimization opportunities."
    - name: "total_planned_batch_size"
      expr: SUM(CAST(batch_size_planned AS DOUBLE))
      comment: "Total planned batch size across all scheduled production runs — used to measure planned manufacturing output volume for supply planning."
    - name: "schedules_with_downtime"
      expr: COUNT(CASE WHEN downtime_window_start_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of scheduled production runs with a recorded downtime window — used to quantify unplanned capacity loss events and their frequency."
    - name: "downtime_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN downtime_window_start_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled production runs experiencing downtime — a manufacturing availability KPI. High downtime rates reduce effective capacity and increase cost per unit."
    - name: "cgmp_compliant_schedule_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN cgmp_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of production schedules executed under cGMP compliance — a regulatory compliance KPI used to confirm that manufacturing operations meet GMP requirements."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_environmental_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental monitoring compliance and exceedance metrics for cleanroom and controlled manufacturing environments. Used by quality, manufacturing, and regulatory leadership to manage GMP environmental control compliance, detect contamination trends, and assess regulatory risk."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`environmental_monitoring`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the environmental monitoring result (e.g. Pass, Fail, Alert, Action) — primary filter for compliance analysis."
    - name: "monitoring_type"
      expr: monitoring_type
      comment: "Type of environmental monitoring (e.g. Viable Air, Surface, Personnel) — used to segment compliance metrics by monitoring category."
    - name: "cleanroom_classification_iso"
      expr: cleanroom_classification_iso
      comment: "ISO cleanroom classification of the monitoring location — used to assess compliance by environmental control tier."
    - name: "cleanroom_grade_eu"
      expr: cleanroom_grade_eu
      comment: "EU GMP cleanroom grade of the monitoring location — used for regulatory compliance analysis under EU GMP Annex 1."
    - name: "manufacturing_operation_phase"
      expr: manufacturing_operation_phase
      comment: "Manufacturing operation phase during which monitoring was conducted (e.g. At Rest, In Operation) — used to assess environmental control under different operational conditions."
    - name: "action_limit_exceeded_flag"
      expr: action_limit_exceeded_flag
      comment: "Indicates whether the action limit was exceeded — used to identify monitoring events requiring immediate corrective action."
    - name: "alert_limit_exceeded_flag"
      expr: alert_limit_exceeded_flag
      comment: "Indicates whether the alert limit was exceeded — used to identify early warning environmental control trends before action limits are breached."
    - name: "trend_flag"
      expr: trend_flag
      comment: "Indicates whether a trend was identified in the monitoring data — used to detect deteriorating environmental control before exceedances occur."
    - name: "sampling_method"
      expr: sampling_method
      comment: "Method used for environmental sampling — used to assess monitoring program coverage and method performance."
    - name: "sample_collection_month"
      expr: DATE_TRUNC('MONTH', sample_collection_timestamp)
      comment: "Month of sample collection — enables trending of environmental monitoring compliance over time."
  measures:
    - name: "total_monitoring_samples"
      expr: COUNT(1)
      comment: "Total number of environmental monitoring samples — baseline metric for monitoring program coverage and activity volume."
    - name: "action_limit_exceedances"
      expr: COUNT(CASE WHEN action_limit_exceeded_flag = TRUE THEN 1 END)
      comment: "Number of environmental monitoring results exceeding action limits — a critical GMP compliance KPI. Action limit exceedances require immediate investigation and can trigger batch rejection."
    - name: "action_limit_exceedance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_limit_exceeded_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of environmental monitoring results exceeding action limits — a regulatory compliance KPI used to assess cleanroom environmental control effectiveness."
    - name: "alert_limit_exceedances"
      expr: COUNT(CASE WHEN alert_limit_exceeded_flag = TRUE THEN 1 END)
      comment: "Number of environmental monitoring results exceeding alert limits — an early warning quality KPI. Elevated alert exceedances predict future action limit breaches if not addressed."
    - name: "avg_cfu_per_cubic_meter"
      expr: AVG(CAST(cfu_per_cubic_meter AS DOUBLE))
      comment: "Average colony-forming units per cubic meter across all viable air monitoring samples — a direct measure of microbial contamination levels in controlled manufacturing environments."
    - name: "avg_particulate_count_0_5_micron"
      expr: AVG(CAST(particulate_count_0_5_micron AS DOUBLE))
      comment: "Average 0.5-micron particulate count — used to assess cleanroom particulate control compliance against ISO and EU GMP classification limits."
    - name: "avg_particulate_count_5_0_micron"
      expr: AVG(CAST(particulate_count_5_0_micron AS DOUBLE))
      comment: "Average 5.0-micron particulate count — a key sterile manufacturing compliance metric. Elevated 5-micron counts in Grade A/B environments signal contamination risk requiring immediate investigation."
    - name: "trending_exceedances"
      expr: COUNT(CASE WHEN trend_flag = TRUE THEN 1 END)
      comment: "Number of monitoring results with an identified trend — a proactive quality risk KPI. Trends indicate deteriorating environmental control before formal action limits are breached."
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`manufacturing_equipment_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment qualification lifecycle metrics tracking qualification outcomes, cycle times, and requalification compliance. Used by manufacturing engineering, quality, and regulatory leadership to ensure equipment is maintained in a qualified state and to manage qualification workload and risk."
  source: "`pharmaceuticals_ecm`.`manufacturing`.`equipment_qualification`"
  dimensions:
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification activity (e.g. IQ, OQ, PQ, Requalification) — used to segment qualification metrics by lifecycle phase."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of the qualification (e.g. Approved, In Progress, Failed) — primary filter for qualification portfolio management."
    - name: "qualification_outcome"
      expr: qualification_outcome
      comment: "Outcome of the qualification execution (e.g. Passed, Failed, Conditional) — used to assess qualification success rates and identify equipment requiring remediation."
    - name: "gmp_impact_classification"
      expr: gmp_impact_classification
      comment: "GMP impact classification of the qualification — used to prioritize qualification activities by regulatory risk."
    - name: "csv_category"
      expr: csv_category
      comment: "Computer System Validation category — used to segment qualification metrics for computerized systems."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether a CAPA was required following the qualification — used to identify qualifications with quality events requiring corrective action."
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Indicates whether the qualification requires regulatory submission — used to track regulatory filing obligations from equipment qualification activities."
    - name: "execution_start_month"
      expr: DATE_TRUNC('MONTH', execution_start_date)
      comment: "Month of qualification execution start — enables trending of qualification activity volume over time."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of equipment qualification records — baseline metric for qualification portfolio size and activity volume."
    - name: "qualifications_passed"
      expr: COUNT(CASE WHEN qualification_outcome = 'Passed' THEN 1 END)
      comment: "Number of qualifications with a passed outcome — a GMP compliance KPI confirming equipment is in a validated state for manufacturing use."
    - name: "qualification_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_outcome = 'Passed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of equipment qualifications that passed — a strategic quality KPI. Low pass rates signal equipment reliability issues and increase GMP compliance risk."
    - name: "qualifications_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of qualifications requiring a CAPA — a quality risk KPI. High CAPA rates from qualification activities indicate systemic equipment or process issues."
    - name: "avg_qualification_duration_days"
      expr: AVG(CAST(datediff(execution_end_date, execution_start_date) AS DOUBLE))
      comment: "Average duration of equipment qualification execution in days — an efficiency KPI. Long qualification cycles delay equipment availability for manufacturing and increase operational costs."
    - name: "overdue_requalifications"
      expr: COUNT(CASE WHEN next_requalification_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of equipment assets with overdue requalification — a GMP compliance risk KPI. Overdue requalifications create regulatory exposure and can prevent equipment from being used in GMP production."
    - name: "regulatory_submission_required_count"
      expr: COUNT(CASE WHEN regulatory_submission_flag = TRUE THEN 1 END)
      comment: "Number of qualifications requiring regulatory submission — used to track regulatory filing obligations and ensure timely submission to health authorities."
$$;