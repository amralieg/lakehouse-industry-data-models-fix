-- Metric views for domain: metering | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_meter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the meter asset population — fleet composition, AMI adoption, accuracy health, and lifecycle cost. Used by asset management and capital planning teams to steer meter replacement programs and smart-meter rollout investments."
  source: "`vibe_water_utilities_v1`.`metering`.`meter`"
  dimensions:
    - name: "meter_type"
      expr: meter_type
      comment: "Meter technology type (e.g. positive displacement, turbine, ultrasonic) — primary segmentation for fleet analysis."
    - name: "meter_status"
      expr: meter_status
      comment: "Current operational status of the meter (active, retired, in-repair) — used to filter active fleet vs. retired assets."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Meter manufacturer — used to benchmark accuracy and failure rates by vendor."
    - name: "size_inches"
      expr: size_inches
      comment: "Physical meter size in inches — key dimension for capacity planning and replacement cost estimation."
    - name: "is_ami_enabled"
      expr: is_ami_enabled
      comment: "Flag indicating whether the meter is AMI-enabled — used to track smart-meter rollout progress."
    - name: "measurement_technology"
      expr: measurement_technology
      comment: "Underlying measurement technology (mechanical, electromagnetic, ultrasonic) — informs accuracy benchmarking."
    - name: "install_date_month"
      expr: DATE_TRUNC('MONTH', install_date)
      comment: "Month of meter installation — used for cohort analysis of fleet age and replacement scheduling."
    - name: "last_test_date_year"
      expr: YEAR(last_test_date)
      comment: "Year of last accuracy test — used to identify meters overdue for testing per regulatory schedules."
  measures:
    - name: "total_active_meters"
      expr: COUNT(CASE WHEN is_active = TRUE THEN meter_id END)
      comment: "Total count of active meters in the fleet. Core fleet-size KPI used by asset management to track inventory and plan capital programs."
    - name: "ami_enabled_meter_count"
      expr: COUNT(CASE WHEN is_ami_enabled = TRUE THEN meter_id END)
      comment: "Count of AMI-enabled meters. Tracks smart-meter rollout progress — a key capital investment KPI for digital transformation programs."
    - name: "ami_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_ami_enabled = TRUE THEN meter_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN meter_id END), 0), 2)
      comment: "Percentage of active meters that are AMI-enabled. Executive KPI for smart-meter rollout — directly tied to operational efficiency and revenue protection investment decisions."
    - name: "avg_last_test_accuracy_pct"
      expr: AVG(CAST(last_test_accuracy_pct AS DOUBLE))
      comment: "Average accuracy percentage from the most recent test across all meters. Regulatory compliance KPI — low values trigger meter replacement programs and revenue recovery investigations."
    - name: "avg_acquisition_cost_usd"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per meter. Used by procurement and capital planning to benchmark vendor pricing and forecast replacement program budgets."
    - name: "total_fleet_acquisition_cost_usd"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of the meter fleet. Capital asset valuation KPI used in rate cases and infrastructure investment planning."
    - name: "meters_overdue_for_test"
      expr: COUNT(CASE WHEN test_due_date < CURRENT_DATE() AND is_active = TRUE THEN meter_id END)
      comment: "Count of active meters whose test due date has passed. Regulatory compliance risk KPI — directly triggers field testing work orders and avoids regulatory penalties."
    - name: "avg_max_flow_rate_gpm"
      expr: AVG(CAST(max_flow_rate_gpm AS DOUBLE))
      comment: "Average maximum flow rate capacity (gallons per minute) across the meter fleet. Used by engineering to validate meter sizing adequacy against demand growth."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_accuracy_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter accuracy testing performance KPIs — pass rates, accuracy deviations, repair outcomes, and replacement recommendations. Used by field operations, regulatory compliance, and asset management to manage meter accuracy programs and meet regulatory testing requirements."
  source: "`vibe_water_utilities_v1`.`metering`.`accuracy_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of accuracy test performed (in-service, bench, field) — used to segment test outcomes by methodology."
    - name: "test_result"
      expr: test_result
      comment: "Overall test result (pass/fail/conditional) — primary outcome dimension for compliance reporting."
    - name: "test_reason"
      expr: test_reason
      comment: "Reason the test was initiated (complaint, scheduled, random sample) — used to analyze drivers of accuracy failures."
    - name: "test_method"
      expr: test_method
      comment: "Testing methodology applied — used to compare accuracy outcomes across different test approaches."
    - name: "disposition"
      expr: disposition
      comment: "Post-test disposition of the meter (returned to service, replaced, repaired) — key operational outcome dimension."
    - name: "repair_performed"
      expr: repair_performed
      comment: "Flag indicating whether a repair was performed following the test — used to track repair intervention rates."
    - name: "replacement_recommended"
      expr: replacement_recommended
      comment: "Flag indicating whether meter replacement was recommended — drives replacement order pipeline."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of test — used for trend analysis of testing volume and pass rates over time."
    - name: "test_date_year"
      expr: YEAR(test_date)
      comment: "Year of test — used for annual regulatory compliance reporting on testing program performance."
  measures:
    - name: "total_tests_conducted"
      expr: COUNT(1)
      comment: "Total number of accuracy tests conducted. Baseline volume KPI for regulatory compliance — utilities must test a minimum percentage of their fleet annually."
    - name: "tests_passed_count"
      expr: COUNT(CASE WHEN passed = TRUE THEN accuracy_test_id END)
      comment: "Count of tests that passed accuracy thresholds. Used alongside total tests to compute pass rate for regulatory reporting."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN passed = TRUE THEN accuracy_test_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accuracy tests that passed. Primary regulatory compliance KPI — low pass rates trigger accelerated replacement programs and may indicate systemic fleet accuracy degradation."
    - name: "avg_accuracy_pct"
      expr: AVG(CAST(accuracy_pct AS DOUBLE))
      comment: "Average meter accuracy percentage across all tests. Fleet-wide accuracy health KPI — deviations from 100% represent revenue loss (under-registration) or customer overcharge risk (over-registration)."
    - name: "avg_weighted_accuracy_pct"
      expr: AVG(CAST(weighted_accuracy_pct AS DOUBLE))
      comment: "Average weighted accuracy percentage (accounts for flow-rate distribution). More representative accuracy KPI than simple average — used in regulatory submissions and revenue loss calculations."
    - name: "avg_high_flow_accuracy_pct"
      expr: AVG(CAST(high_flow_accuracy_pct AS DOUBLE))
      comment: "Average accuracy at high flow rates. High-flow accuracy is critical for large commercial/industrial customers where revenue impact of inaccuracy is greatest."
    - name: "avg_low_flow_accuracy_pct"
      expr: AVG(CAST(low_flow_accuracy_pct AS DOUBLE))
      comment: "Average accuracy at low flow rates. Low-flow accuracy identifies meters that miss slow leaks and continuous drip consumption — a key non-revenue water KPI."
    - name: "replacement_recommendation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN replacement_recommended = TRUE THEN accuracy_test_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests resulting in a replacement recommendation. Drives capital replacement program sizing and budget forecasting for meter procurement."
    - name: "avg_post_adjustment_accuracy_pct"
      expr: AVG(CAST(post_adjustment_accuracy_pct AS DOUBLE))
      comment: "Average accuracy after calibration adjustment. Measures the effectiveness of field calibration — if post-adjustment accuracy remains low, replacement is warranted."
    - name: "avg_actual_volume_gallons"
      expr: AVG(CAST(actual_volume AS DOUBLE))
      comment: "Average actual volume measured during test. Used to normalize accuracy results across different test volumes and validate test methodology consistency."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_read`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter reading quality, consumption, and billing cycle KPIs. Used by billing operations, field services, and revenue management to monitor read success rates, estimated read exposure, consumption trends, and data quality — all directly tied to billing accuracy and revenue integrity."
  source: "`vibe_water_utilities_v1`.`metering`.`read`"
  dimensions:
    - name: "read_type"
      expr: read_type
      comment: "Type of meter read (AMI, manual, drive-by, estimated) — primary dimension for read method performance analysis."
    - name: "read_status"
      expr: read_status
      comment: "Status of the read record (validated, exception, pending) — used to filter quality reads for billing."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle identifier — used to aggregate consumption and read quality by billing period."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the read was estimated rather than actual — key data quality dimension for billing accuracy analysis."
    - name: "estimation_method"
      expr: estimation_method
      comment: "Method used to estimate consumption when actual read was unavailable — used to assess estimation quality and risk."
    - name: "validation_status"
      expr: validation_status
      comment: "Outcome of the read validation process — used to track data quality pipeline performance."
    - name: "exception_code"
      expr: exception_code
      comment: "Exception code assigned to anomalous reads — used to categorize and prioritize field investigation workloads."
    - name: "read_date_month"
      expr: DATE_TRUNC('MONTH', read_date)
      comment: "Month of meter read — used for monthly consumption trend analysis and billing cycle performance reporting."
    - name: "read_date_year"
      expr: YEAR(read_date)
      comment: "Year of meter read — used for annual consumption benchmarking and year-over-year trend analysis."
    - name: "source"
      expr: source
      comment: "Data source system that generated the read (AMI network, handheld device, manual entry) — used to assess channel reliability."
  measures:
    - name: "total_reads"
      expr: COUNT(1)
      comment: "Total number of meter reads processed. Baseline operational volume KPI for read route and billing cycle management."
    - name: "estimated_read_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_estimated = TRUE THEN read_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reads that were estimated rather than actual. High estimated read rates indicate field access problems or AMI communication failures — directly impacts billing accuracy and customer dispute risk."
    - name: "total_consumption_gallons"
      expr: SUM(CAST(consumption_value AS DOUBLE))
      comment: "Total metered consumption volume across all reads. Primary revenue-linked volume KPI — used in water balance calculations and revenue forecasting."
    - name: "avg_daily_consumption_gallons"
      expr: AVG(CAST(average_daily_consumption AS DOUBLE))
      comment: "Average daily consumption per read record. Used to benchmark per-account usage, detect anomalies, and set high-usage alert thresholds."
    - name: "leak_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN leak_flag = TRUE THEN read_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reads flagged as potential leaks. Directly tied to non-revenue water reduction — a key operational efficiency and revenue protection KPI."
    - name: "zero_consumption_read_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN zero_consumption_flag = TRUE THEN read_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reads recording zero consumption. Elevated rates may indicate meter stoppages, vacant premises, or AMI communication failures — triggers field investigation."
    - name: "tamper_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tamper_flag = TRUE THEN read_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reads with a tamper flag. Revenue protection KPI — tamper events represent potential theft of service and require immediate field investigation."
    - name: "avg_consumption_variance_pct"
      expr: AVG(CAST(consumption_variance_pct AS DOUBLE))
      comment: "Average consumption variance percentage versus prior period. Used to detect systematic over/under-reading patterns and validate meter accuracy in the field."
    - name: "validated_read_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN validated_flag = TRUE THEN read_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reads that passed validation. Data quality KPI for the metering data pipeline — low rates indicate systemic issues in AMI communication or read processing."
    - name: "billed_read_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_billed = TRUE THEN read_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reads that were successfully billed. Revenue completeness KPI — unbilled reads represent deferred or lost revenue."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_interval_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI interval-level consumption and data quality KPIs. Used by operations, leak detection, and revenue management teams to monitor real-time consumption patterns, AMI network data completeness, and continuous flow events that indicate leaks or unauthorized use."
  source: "`vibe_water_utilities_v1`.`metering`.`interval_consumption`"
  dimensions:
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the interval record — used to filter quality data for consumption analysis."
    - name: "data_quality_indicator"
      expr: data_quality_indicator
      comment: "Data quality flag from the AMI network — used to assess AMI communication reliability by endpoint and network node."
    - name: "leak_detection_flag"
      expr: leak_detection_flag
      comment: "Flag indicating a potential leak was detected in this interval — primary dimension for leak investigation workflows."
    - name: "high_usage_flag"
      expr: high_usage_flag
      comment: "Flag indicating abnormally high consumption in this interval — used to trigger high-usage alerts and customer notifications."
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Flag indicating reverse flow detected — may indicate backflow, meter tampering, or installation error."
    - name: "zero_consumption_flag"
      expr: zero_consumption_flag
      comment: "Flag indicating zero consumption in the interval — used to identify meter stoppages or communication gaps."
    - name: "gap_flag"
      expr: gap_flag
      comment: "Flag indicating a data gap in the interval sequence — used to measure AMI network data completeness."
    - name: "interval_start_hour"
      expr: DATE_TRUNC('HOUR', interval_start_timestamp)
      comment: "Hour of interval start — used for intra-day demand profiling and peak demand analysis."
    - name: "interval_start_date"
      expr: DATE_TRUNC('DAY', interval_start_timestamp)
      comment: "Date of interval — used for daily consumption aggregation and trend analysis."
  measures:
    - name: "total_interval_consumption_gallons"
      expr: SUM(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Total consumption volume across all intervals in gallons. Foundation for water balance calculations — comparing this to billed consumption reveals non-revenue water at the interval level."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute across intervals. Used for demand profiling and identifying peak demand periods for infrastructure capacity planning."
    - name: "max_flow_rate_gpm"
      expr: MAX(flow_rate_gpm)
      comment: "Maximum observed flow rate in gallons per minute. Peak demand KPI used by engineering for pressure zone management and infrastructure sizing."
    - name: "leak_detection_interval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN leak_detection_flag = TRUE THEN interval_consumption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals flagged for potential leak. Operational KPI for non-revenue water management — high rates in a zone indicate distribution system or customer-side leakage requiring investigation."
    - name: "data_gap_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gap_flag = TRUE THEN interval_consumption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals with data gaps. AMI network reliability KPI — high gap rates indicate communication failures that degrade billing accuracy and leak detection capability."
    - name: "zero_consumption_interval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN zero_consumption_flag = TRUE THEN interval_consumption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals recording zero consumption. Used to distinguish vacant premises from meter or communication failures — informs field investigation prioritization."
    - name: "reverse_flow_interval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reverse_flow_flag = TRUE THEN interval_consumption_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intervals with reverse flow detected. Revenue protection and safety KPI — reverse flow may indicate backflow contamination risk or meter tampering."
    - name: "avg_battery_voltage"
      expr: AVG(CAST(battery_voltage AS DOUBLE))
      comment: "Average AMI endpoint battery voltage across intervals. Predictive maintenance KPI — declining average voltage predicts endpoint battery failures before they cause data gaps."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average pressure in PSI across intervals. Distribution system health KPI — pressure deviations indicate main breaks, pressure regulator failures, or demand imbalances."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_high_usage_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High-usage alert management KPIs — alert volume, resolution rates, revenue impact, and customer notification effectiveness. Used by customer service, revenue protection, and operations teams to manage leak and high-consumption events and recover revenue."
  source: "`vibe_water_utilities_v1`.`metering`.`high_usage_alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of high-usage alert (continuous flow, spike, threshold breach) — used to categorize alert drivers and prioritize response."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert (critical, high, medium, low) — used to prioritize customer outreach and field investigation."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (open, investigating, resolved, closed) — primary operational workflow dimension."
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of alert resolution (customer leak, utility leak, meter fault, no issue found) — used to analyze root causes and improve detection algorithms."
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify the customer (email, SMS, phone, portal) — used to assess notification channel effectiveness."
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Flag indicating whether the customer was notified — used to track notification compliance and customer engagement."
    - name: "alert_generated_date"
      expr: DATE_TRUNC('DAY', alert_generated_timestamp)
      comment: "Date the alert was generated — used for daily alert volume trending and response time analysis."
    - name: "alert_generated_month"
      expr: DATE_TRUNC('MONTH', alert_generated_timestamp)
      comment: "Month the alert was generated — used for monthly reporting on high-usage event frequency and revenue impact."
  measures:
    - name: "total_alerts_generated"
      expr: COUNT(1)
      comment: "Total number of high-usage alerts generated. Baseline volume KPI for alert program management and staffing of customer notification and investigation teams."
    - name: "alert_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN high_usage_alert_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that have been resolved. Operational efficiency KPI — low resolution rates indicate backlogs in customer service or field investigation capacity."
    - name: "customer_notification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notified_flag = TRUE THEN high_usage_alert_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts where the customer was notified. Customer service compliance KPI — many utilities have regulatory or policy obligations to notify customers of high usage events."
    - name: "total_estimated_water_loss_gallons"
      expr: SUM(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Total estimated water loss across all high-usage alerts in gallons. Non-revenue water KPI — quantifies the volume impact of leaks and high-usage events detected by the alert program."
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue impact of high-usage alerts in dollars. Revenue protection KPI — used to justify investment in AMI and alert program infrastructure."
    - name: "avg_consumption_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average consumption variance percentage above baseline that triggered alerts. Used to calibrate alert threshold sensitivity — high averages suggest thresholds are set appropriately; low averages may indicate over-alerting."
    - name: "avg_actual_consumption_value"
      expr: AVG(CAST(actual_consumption_value AS DOUBLE))
      comment: "Average actual consumption value at time of alert. Used to benchmark alert severity and validate that alert thresholds are triggering at meaningful consumption levels."
    - name: "suppressed_alert_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN suppression_flag = TRUE THEN high_usage_alert_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that were suppressed. Quality KPI for the alert algorithm — high suppression rates indicate false-positive problems that erode customer trust and waste investigation resources."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_replacement_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter replacement program execution KPIs — cost, completion rates, scheduling adherence, and labor efficiency. Used by field operations, asset management, and finance to manage the meter replacement capital program and track cost performance."
  source: "`vibe_water_utilities_v1`.`metering`.`replacement_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replacement order (scheduled, in-progress, completed, cancelled) — primary workflow dimension for program management."
    - name: "order_type"
      expr: order_type
      comment: "Type of replacement order (scheduled, complaint-driven, accuracy-failure, emergency) — used to analyze drivers of replacement activity."
    - name: "replacement_reason"
      expr: replacement_reason
      comment: "Reason for meter replacement (age, accuracy failure, damage, upgrade) — used to categorize replacement drivers and inform proactive replacement strategies."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the replacement order — used to assess whether high-priority replacements are being completed on schedule."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating an emergency replacement — used to track emergency response performance and associated cost premiums."
    - name: "technician_name"
      expr: technician_name
      comment: "Name of the technician who performed the replacement — used for productivity analysis and quality assurance."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the replacement order was created — used for monthly program volume and cost trend analysis."
    - name: "completed_date_month"
      expr: DATE_TRUNC('MONTH', completed_date)
      comment: "Month the replacement was completed — used to track program execution pace against capital plan targets."
  measures:
    - name: "total_replacement_orders"
      expr: COUNT(1)
      comment: "Total number of meter replacement orders. Baseline program volume KPI — used to track execution pace against annual replacement targets."
    - name: "completed_replacement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_completed = TRUE THEN replacement_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replacement orders that have been completed. Program execution KPI — low completion rates indicate field capacity constraints or scheduling failures that put capital program targets at risk."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual cost of meter replacements in dollars. Capital program spend KPI — compared against budget to assess cost performance and forecast year-end spend."
    - name: "avg_actual_cost_usd"
      expr: AVG(CAST(actual_cost_usd AS DOUBLE))
      comment: "Average actual cost per meter replacement. Unit cost benchmarking KPI — used to identify cost outliers, negotiate vendor contracts, and forecast future replacement program budgets."
    - name: "avg_labor_hours_per_replacement"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per meter replacement. Field productivity KPI — used to optimize crew scheduling, identify training needs, and validate labor cost estimates in capital program budgets."
    - name: "total_labor_cost_usd"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost across all replacement orders. Cost component KPI — used to analyze labor vs. material cost split and identify opportunities for efficiency improvement."
    - name: "total_material_cost_usd"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost across all replacement orders. Procurement KPI — used to track material spend against budget and benchmark against meter acquisition cost estimates."
    - name: "cost_overrun_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_cost_usd > estimated_cost_usd THEN replacement_order_id END) / NULLIF(COUNT(CASE WHEN estimated_cost_usd IS NOT NULL AND actual_cost_usd IS NOT NULL THEN replacement_order_id END), 0), 2)
      comment: "Percentage of replacement orders where actual cost exceeded estimated cost. Budget accuracy KPI — high overrun rates indicate estimation methodology problems or scope creep in field execution."
    - name: "pit_repair_needed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pit_repair_needed = TRUE THEN replacement_order_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of replacement orders where pit repair was also needed. Infrastructure condition KPI — high rates indicate aging meter pit infrastructure requiring a broader civil works program alongside meter replacement."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_ami_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI endpoint fleet health, communication performance, and security KPIs. Used by AMI operations, IT/OT security, and field services to monitor network reliability, battery health, tamper events, and firmware currency across the smart metering infrastructure."
  source: "`vibe_water_utilities_v1`.`metering`.`ami_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of AMI endpoint device — used to segment performance metrics by device class."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the endpoint (RF, cellular, PLC) — used to compare reliability across network technologies."
    - name: "firmware_version"
      expr: firmware_version
      comment: "Current firmware version on the endpoint — used to track firmware currency and identify devices requiring updates."
    - name: "tamper_status"
      expr: tamper_status
      comment: "Current tamper status of the endpoint — used to identify and prioritize security investigation of tampered devices."
    - name: "leak_detection_enabled_flag"
      expr: leak_detection_enabled_flag
      comment: "Flag indicating whether leak detection is enabled on the endpoint — used to track leak detection program coverage."
    - name: "reverse_flow_detected_flag"
      expr: reverse_flow_detected_flag
      comment: "Flag indicating reverse flow has been detected — used to identify potential backflow or tampering events."
    - name: "commissioning_date_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month of endpoint commissioning — used for cohort analysis of device reliability over time."
    - name: "network_node_code"
      expr: network_node_code
      comment: "Network node the endpoint communicates through — used to identify node-level communication failures affecting multiple endpoints."
  measures:
    - name: "total_ami_endpoints"
      expr: COUNT(1)
      comment: "Total number of AMI endpoints in the fleet. Baseline fleet size KPI for AMI program management and network capacity planning."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm across all endpoints. AMI network health KPI — low average signal strength predicts communication failures and data gaps that degrade billing accuracy."
    - name: "avg_battery_level_pct"
      expr: AVG(CAST(battery_level_percent AS DOUBLE))
      comment: "Average battery level percentage across all endpoints. Predictive maintenance KPI — declining battery levels predict endpoint failures before they cause data gaps and billing exceptions."
    - name: "low_battery_endpoint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN battery_level_percent < 20 THEN ami_endpoint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with battery level below 20%. Proactive maintenance KPI — identifies endpoints requiring battery replacement before failure to prevent data gaps."
    - name: "tamper_detected_endpoint_count"
      expr: COUNT(CASE WHEN tamper_detected_timestamp IS NOT NULL THEN ami_endpoint_id END)
      comment: "Count of endpoints with a recorded tamper event. Revenue protection KPI — tamper events indicate potential theft of service requiring immediate field investigation."
    - name: "leak_detection_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN leak_detection_enabled_flag = TRUE THEN ami_endpoint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AMI endpoints with leak detection enabled. Non-revenue water program coverage KPI — directly measures the reach of the automated leak detection capability."
    - name: "avg_battery_expected_life_years"
      expr: AVG(CAST(battery_expected_life_years AS DOUBLE))
      comment: "Average expected battery life in years across the endpoint fleet. Asset lifecycle planning KPI — used to forecast battery replacement program volume and cost."
    - name: "reverse_flow_endpoint_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reverse_flow_detected_flag = TRUE THEN ami_endpoint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints that have detected reverse flow. Revenue protection and safety KPI — elevated rates may indicate systematic backflow issues or meter installation errors requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`metering_installation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter installation fleet composition, AMI readiness, and infrastructure condition KPIs. Used by field operations, asset management, and capital planning to understand the installed base, remote-read capability, and physical infrastructure condition across all service connections."
  source: "`vibe_water_utilities_v1`.`metering`.`installation`"
  dimensions:
    - name: "installation_status"
      expr: installation_status
      comment: "Current status of the installation (active, inactive, removed) — primary filter for active service connection analysis."
    - name: "installation_type"
      expr: installation_type
      comment: "Type of installation (residential, commercial, industrial, fire) — used to segment fleet metrics by customer class."
    - name: "meter_location"
      expr: meter_location
      comment: "Physical location of the meter (pit, vault, inside, curb box) — used to analyze access difficulty and maintenance cost by location type."
    - name: "remote_read_capable_flag"
      expr: remote_read_capable_flag
      comment: "Flag indicating whether the installation supports remote reading — used to track AMI/AMR readiness of the installed base."
    - name: "backflow_device_present_flag"
      expr: backflow_device_present_flag
      comment: "Flag indicating presence of a backflow prevention device — used for regulatory compliance tracking of backflow protection requirements."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the service line pipe — used to identify lead service line installations requiring priority replacement under regulatory mandates."
    - name: "install_date_year"
      expr: YEAR(install_date)
      comment: "Year of installation — used for fleet age cohort analysis and replacement program prioritization."
    - name: "state_code"
      expr: state_code
      comment: "State code of the installation — used for geographic segmentation and multi-jurisdiction regulatory reporting."
  measures:
    - name: "total_active_installations"
      expr: COUNT(CASE WHEN is_active = TRUE THEN installation_id END)
      comment: "Total count of active meter installations. Core fleet inventory KPI — represents the total number of billable service connections."
    - name: "remote_read_capable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remote_read_capable_flag = TRUE THEN installation_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN installation_id END), 0), 2)
      comment: "Percentage of active installations that are remote-read capable. AMI/AMR readiness KPI — directly measures the proportion of the fleet that can be read without field visits, reducing operational cost."
    - name: "backflow_device_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN backflow_device_present_flag = TRUE THEN installation_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN installation_id END), 0), 2)
      comment: "Percentage of active installations with a backflow prevention device. Regulatory compliance KPI — many jurisdictions mandate backflow protection on commercial and industrial connections."
    - name: "avg_service_line_size_inches"
      expr: AVG(CAST(service_line_size_inches AS DOUBLE))
      comment: "Average service line size in inches across installations. Infrastructure capacity KPI — used by engineering to assess service line adequacy for demand growth and fire flow requirements."
    - name: "avg_pipe_diameter_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average meter connection pipe diameter in inches. Used alongside service line size to validate meter sizing adequacy and identify undersized connections."
    - name: "inside_setting_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_inside_setting = TRUE THEN installation_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN installation_id END), 0), 2)
      comment: "Percentage of active installations in an inside setting. Operational cost KPI — inside meters require customer access coordination, increasing read and maintenance costs versus pit or curb-box installations."
    - name: "avg_setter_size_inches"
      expr: AVG(CAST(setter_size_inches AS DOUBLE))
      comment: "Average setter size in inches. Used by engineering and procurement to validate setter sizing standards and forecast replacement material requirements."
$$;