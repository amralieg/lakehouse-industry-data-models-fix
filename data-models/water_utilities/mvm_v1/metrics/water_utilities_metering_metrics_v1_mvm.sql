-- Metric views for domain: metering | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`metering_interval_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core AMI interval-level consumption metrics tracking volumetric throughput, flow rates, data quality, and anomaly rates across metered service points. Drives NRW analysis, demand forecasting, and operational efficiency decisions."
  source: "`water_utilities_ecm`.`metering`.`interval_consumption`"
  dimensions:
    - name: "interval_date"
      expr: DATE_TRUNC('day', interval_start_timestamp)
      comment: "Calendar day of the consumption interval, used for daily demand trending and anomaly detection."
    - name: "interval_month"
      expr: DATE_TRUNC('month', interval_start_timestamp)
      comment: "Calendar month of the consumption interval, used for monthly volumetric reporting and billing cycle alignment."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation status of the interval record (e.g., Valid, Estimated, Failed), used to filter or segment quality-adjusted consumption."
    - name: "data_quality_indicator"
      expr: data_quality_indicator
      comment: "Quality flag assigned to the interval read, enabling segmentation of high-confidence vs. estimated consumption volumes."
    - name: "estimated_method"
      expr: estimated_method
      comment: "Method used to estimate consumption when a direct read was unavailable, supporting audit and estimation-rate analysis."
    - name: "interval_duration_minutes"
      expr: interval_duration_minutes
      comment: "Duration of the consumption interval in minutes (e.g., 15, 60), used to normalise volumetric comparisons across different read frequencies."
    - name: "source_system"
      expr: source_system
      comment: "Originating system that produced the interval record (e.g., AMI head-end, SCADA), used for data lineage and quality segmentation."
    - name: "high_usage_flag"
      expr: high_usage_flag
      comment: "Boolean flag indicating the interval was flagged as high-usage, enabling rapid segmentation of anomalous demand events."
    - name: "leak_detection_flag"
      expr: leak_detection_flag
      comment: "Boolean flag indicating a potential leak was detected during this interval, used to quantify leak-flagged volume."
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Boolean flag indicating reverse flow was detected, used to identify backflow incidents and potential meter tampering."
    - name: "zero_consumption_flag"
      expr: zero_consumption_flag
      comment: "Boolean flag indicating zero consumption was recorded, used to identify inactive accounts or meter communication failures."
    - name: "gap_flag"
      expr: gap_flag
      comment: "Boolean flag indicating a data gap exists in the interval sequence, used to measure AMI network data completeness."
  measures:
    - name: "total_consumption_volume_gallons"
      expr: SUM(CAST(consumption_volume_gallons AS DOUBLE))
      comment: "Total metered water consumption in gallons across all intervals in the selected period. Primary volumetric KPI for demand management and revenue assurance."
    - name: "avg_flow_rate_gpm"
      expr: AVG(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Average flow rate in gallons per minute across intervals. Used to identify demand peaks, size infrastructure, and detect sustained high-flow anomalies."
    - name: "max_flow_rate_gpm"
      expr: MAX(flow_rate_gpm)
      comment: "Peak flow rate in gallons per minute observed in the period. Critical for hydraulic capacity planning and surge event identification."
    - name: "total_interval_records"
      expr: COUNT(1)
      comment: "Total number of interval records processed. Baseline denominator for data completeness and anomaly rate calculations."
    - name: "distinct_metered_endpoints"
      expr: COUNT(DISTINCT ami_endpoint_id)
      comment: "Number of unique AMI endpoints contributing interval data. Measures active AMI network coverage and read completeness."
    - name: "high_usage_interval_count"
      expr: SUM(CASE WHEN high_usage_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals flagged as high-usage. Used to quantify the frequency of demand anomalies requiring investigation."
    - name: "leak_flagged_interval_count"
      expr: SUM(CASE WHEN leak_detection_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals where a potential leak was algorithmically detected. Drives leak investigation prioritisation and NRW reduction programmes."
    - name: "leak_flagged_volume_gallons"
      expr: SUM(CASE WHEN leak_detection_flag = TRUE THEN consumption_volume_gallons ELSE 0 END)
      comment: "Total consumption volume in gallons recorded during leak-flagged intervals. Quantifies potential water loss attributable to detected leaks."
    - name: "estimated_interval_count"
      expr: SUM(CASE WHEN estimated_method IS NOT NULL AND estimated_method <> '' THEN 1 ELSE 0 END)
      comment: "Count of intervals where consumption was estimated rather than directly read. High estimation rates signal AMI communication or meter health issues."
    - name: "gap_interval_count"
      expr: SUM(CASE WHEN gap_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals with data gaps in the sequence. Measures AMI network data completeness and communication reliability."
    - name: "reverse_flow_interval_count"
      expr: SUM(CASE WHEN reverse_flow_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of intervals with detected reverse flow. Elevated counts indicate backflow events, cross-connection risks, or meter tampering."
    - name: "zero_consumption_interval_count"
      expr: SUM(CASE WHEN zero_consumption_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of zero-consumption intervals. Used to identify inactive service points, meter communication failures, or potential unbilled consumption."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average system pressure in PSI recorded at metered points during intervals. Used for pressure zone management and leakage correlation analysis."
    - name: "avg_battery_voltage"
      expr: AVG(CAST(battery_voltage AS DOUBLE))
      comment: "Average AMI endpoint battery voltage across intervals. Declining averages signal impending battery failures requiring proactive field replacement."
    - name: "total_raw_pulse_count"
      expr: SUM(CAST(raw_pulse_count AS DOUBLE))
      comment: "Sum of raw pulse counts from meter registers across all intervals. Used for meter accuracy validation and consumption reconciliation against register reads."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`metering_high_usage_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial metrics for high-usage alerts generated by the AMI system. Tracks alert volumes, resolution performance, estimated revenue and water loss impact, and customer notification effectiveness. Drives NRW reduction and customer service decisions."
  source: "`water_utilities_ecm`.`metering`.`high_usage_alert`"
  dimensions:
    - name: "alert_generated_date"
      expr: DATE_TRUNC('day', alert_generated_timestamp)
      comment: "Date the high-usage alert was generated, used for daily alert volume trending and SLA tracking."
    - name: "alert_generated_month"
      expr: DATE_TRUNC('month', alert_generated_timestamp)
      comment: "Month the alert was generated, used for monthly programme performance reporting."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity classification of the alert (e.g., Low, Medium, High, Critical), used to prioritise investigation resources."
    - name: "alert_status"
      expr: alert_status
      comment: "Current lifecycle status of the alert (e.g., Open, In Investigation, Resolved, Closed), used for workload and backlog management."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of high-usage alert (e.g., Continuous Flow, Spike, Threshold Breach), used to categorise root causes and tailor response procedures."
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of the alert resolution outcome (e.g., Leak Confirmed, Customer Behaviour, No Issue Found), used to measure detection accuracy and guide programme improvements."
    - name: "notification_method"
      expr: notification_method
      comment: "Channel used to notify the customer (e.g., Email, SMS, Portal), used to evaluate notification effectiveness by channel."
    - name: "actual_consumption_unit"
      expr: actual_consumption_unit
      comment: "Unit of measure for the consumption value triggering the alert (e.g., Gallons, CCF), used for cross-system comparability."
    - name: "data_source"
      expr: data_source
      comment: "Source system that generated the alert (e.g., AMI Head-End, Analytics Engine), used for data lineage and quality segmentation."
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Boolean indicating whether the customer was notified of the alert, used to measure notification programme coverage."
    - name: "service_order_created_flag"
      expr: service_order_created_flag
      comment: "Boolean indicating whether a service order was created in response to the alert, used to measure field investigation dispatch rates."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of high-usage alerts generated. Primary volume KPI for the AMI analytics programme and NRW management."
    - name: "distinct_alerted_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts with at least one high-usage alert. Measures the breadth of the high-usage problem across the customer base."
    - name: "total_estimated_water_loss_gallons"
      expr: SUM(CAST(estimated_water_loss_gallons AS DOUBLE))
      comment: "Total estimated water loss in gallons across all alerts. Directly quantifies NRW exposure and informs capital investment decisions for leak reduction."
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact_amount AS DOUBLE))
      comment: "Total estimated revenue at risk from high-usage events in USD. Used by finance and operations to prioritise investigation and recovery actions."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and baseline consumption across alerts. Measures the typical magnitude of usage anomalies detected by the programme."
    - name: "avg_actual_consumption_value"
      expr: AVG(CAST(actual_consumption_value AS DOUBLE))
      comment: "Average actual consumption value at the time of alert generation. Used to benchmark alert thresholds and assess detection sensitivity."
    - name: "avg_baseline_consumption_value"
      expr: AVG(CAST(baseline_consumption_value AS DOUBLE))
      comment: "Average baseline consumption value used as the comparison reference for alerts. Used to validate baseline modelling accuracy."
    - name: "customer_notified_count"
      expr: SUM(CASE WHEN customer_notified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts where the customer was successfully notified. Measures notification programme reach and regulatory compliance with customer communication requirements."
    - name: "service_order_created_count"
      expr: SUM(CASE WHEN service_order_created_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts that resulted in a field service order. Measures the rate at which alerts escalate to physical investigation, informing field crew capacity planning."
    - name: "suppressed_alert_count"
      expr: SUM(CASE WHEN suppression_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts that were suppressed. High suppression rates may indicate over-sensitive thresholds or systematic false-positive issues requiring model recalibration."
    - name: "resolved_alert_count"
      expr: SUM(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of alerts that have been resolved. Used to calculate resolution rates and measure operational throughput of the alert management process."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`metering_leak_detection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic and operational metrics for AMI-detected leak events. Tracks leak volumes, durations, detection confidence, resolution outcomes, and customer notification compliance. Central KPI layer for NRW reduction programmes and regulatory reporting."
  source: "`water_utilities_ecm`.`metering`.`leak_detection_event`"
  dimensions:
    - name: "detection_date"
      expr: DATE_TRUNC('day', detection_timestamp)
      comment: "Date the leak was algorithmically detected, used for daily detection volume trending and programme performance tracking."
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Month of leak detection, used for monthly NRW reporting and regulatory submissions."
    - name: "leak_status"
      expr: leak_status
      comment: "Current status of the leak event (e.g., Active, Resolved, Under Investigation), used for open-leak backlog management."
    - name: "leak_type"
      expr: leak_type
      comment: "Classification of the leak type (e.g., Service Line, Meter, Internal Plumbing), used to target infrastructure investment and customer education."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity of the leak alert (e.g., Low, Medium, High, Critical), used to prioritise field response and resource allocation."
    - name: "detection_method"
      expr: detection_method
      comment: "Algorithm or method used to detect the leak (e.g., Minimum Night Flow, Continuous Flow Analysis), used to evaluate detection method effectiveness."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the leak investigation and resolution (e.g., Leak Repaired, No Leak Found, Customer Resolved), used to measure detection accuracy and programme ROI."
    - name: "customer_notified_flag"
      expr: customer_notified_flag
      comment: "Boolean indicating whether the customer was notified of the detected leak, used to measure regulatory notification compliance."
    - name: "billing_adjustment_eligible_flag"
      expr: billing_adjustment_eligible_flag
      comment: "Boolean indicating whether the customer is eligible for a billing adjustment due to the leak, used to quantify financial exposure from leak credit programmes."
    - name: "continuous_flow_flag"
      expr: continuous_flow_flag
      comment: "Boolean indicating continuous flow was detected (no zero-flow period), a strong indicator of an active leak requiring urgent response."
    - name: "minimum_night_flow_anomaly_flag"
      expr: minimum_night_flow_anomaly_flag
      comment: "Boolean indicating a minimum night flow anomaly was detected, the primary algorithmic signal for customer-side leak detection."
    - name: "notification_method"
      expr: notification_method
      comment: "Channel used to notify the customer of the detected leak (e.g., Email, SMS, Letter), used to evaluate notification channel effectiveness."
  measures:
    - name: "total_leak_events"
      expr: COUNT(1)
      comment: "Total number of leak detection events. Primary volume KPI for the AMI leak detection programme and NRW management dashboard."
    - name: "distinct_affected_premises"
      expr: COUNT(DISTINCT premise_id)
      comment: "Number of unique premises with at least one detected leak event. Measures the geographic and customer breadth of the leak problem."
    - name: "total_estimated_leak_volume_gpd"
      expr: SUM(CAST(estimated_leak_volume_gallons_per_day AS DOUBLE))
      comment: "Total estimated daily leak volume in gallons per day across all active leak events. Primary NRW volumetric KPI used in regulatory reporting and capital programme justification."
    - name: "total_estimated_water_loss_gallons"
      expr: SUM(CAST(estimated_total_loss_gallons AS DOUBLE))
      comment: "Total estimated cumulative water loss in gallons across all leak events. Quantifies the full volumetric and financial impact of detected leaks."
    - name: "avg_leak_duration_hours"
      expr: AVG(CAST(leak_duration_hours AS DOUBLE))
      comment: "Average duration of leak events in hours. Measures detection-to-resolution speed; longer durations indicate response process gaps or customer engagement challenges."
    - name: "max_leak_duration_hours"
      expr: MAX(leak_duration_hours)
      comment: "Maximum leak duration in hours observed in the period. Identifies worst-case unresolved leaks requiring executive escalation."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average algorithmic confidence score for leak detections. Tracks detection model quality; declining scores indicate model drift requiring recalibration."
    - name: "avg_flow_threshold_value"
      expr: AVG(CAST(flow_threshold_value AS DOUBLE))
      comment: "Average flow threshold value used to trigger leak detection events. Used to evaluate and calibrate detection sensitivity across the network."
    - name: "customer_notified_count"
      expr: SUM(CASE WHEN customer_notified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leak events where the customer was notified. Measures compliance with regulatory and service standard notification requirements."
    - name: "billing_adjustment_eligible_count"
      expr: SUM(CASE WHEN billing_adjustment_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leak events eligible for customer billing adjustments. Quantifies the financial liability of the leak credit programme."
    - name: "continuous_flow_event_count"
      expr: SUM(CASE WHEN continuous_flow_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leak events with confirmed continuous flow. These represent the highest-priority, highest-volume leaks requiring immediate field response."
    - name: "resolved_leak_count"
      expr: SUM(CASE WHEN resolution_date IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of leak events that have been resolved. Used to calculate resolution rates and measure the operational effectiveness of the leak response programme."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`metering_ami_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset health, network performance, and lifecycle metrics for AMI endpoints (smart meters and communication devices). Tracks battery health, signal quality, tamper events, firmware currency, and operational status. Drives proactive maintenance, capital planning, and network reliability decisions."
  source: "`water_utilities_ecm`.`metering`.`ami_endpoint`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the AMI endpoint (e.g., Active, Inactive, Decommissioned, Fault), used to segment the active network and identify non-performing assets."
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of AMI endpoint (e.g., Water Meter, Pressure Sensor, Data Concentrator), used to segment performance metrics by device class."
    - name: "communication_protocol"
      expr: communication_protocol
      comment: "Communication protocol used by the endpoint (e.g., RF Mesh, Cellular, PLC), used to compare network performance across technology types."
    - name: "firmware_version"
      expr: firmware_version
      comment: "Current firmware version installed on the endpoint, used to track firmware currency and identify devices requiring updates."
    - name: "network_node_code"
      expr: network_node_code
      comment: "Network node or concentrator the endpoint communicates through, used for geographic and network topology performance analysis."
    - name: "signal_quality_indicator"
      expr: signal_quality_indicator
      comment: "Qualitative signal quality classification (e.g., Excellent, Good, Poor, No Signal), used to identify network coverage gaps requiring infrastructure investment."
    - name: "tamper_status"
      expr: tamper_status
      comment: "Current tamper status of the endpoint (e.g., Clear, Tamper Detected, Under Investigation), used to quantify revenue protection exposure."
    - name: "leak_detection_enabled_flag"
      expr: leak_detection_enabled_flag
      comment: "Boolean indicating whether leak detection is enabled on the endpoint, used to measure programme coverage across the AMI network."
    - name: "installation_date"
      expr: DATE_TRUNC('month', installation_date)
      comment: "Month of endpoint installation, used for cohort analysis of device performance and battery life by installation vintage."
    - name: "commissioning_date"
      expr: DATE_TRUNC('month', commissioning_date)
      comment: "Month the endpoint was commissioned into service, used for network rollout tracking and programme milestone reporting."
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total number of AMI endpoints in the registry. Primary asset count KPI for network coverage and capital programme tracking."
    - name: "active_endpoint_count"
      expr: SUM(CASE WHEN operational_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of endpoints in Active operational status. Measures the live, revenue-generating AMI network size and tracks activation programme progress."
    - name: "tamper_detected_count"
      expr: SUM(CASE WHEN tamper_status IS NOT NULL AND tamper_status <> 'Clear' THEN 1 ELSE 0 END)
      comment: "Count of endpoints with a non-clear tamper status. Quantifies revenue protection exposure from meter tampering and drives field investigation prioritisation."
    - name: "avg_battery_level_percent"
      expr: AVG(CAST(battery_level_percent AS DOUBLE))
      comment: "Average battery charge level across all endpoints as a percentage. Declining averages signal impending mass battery replacement needs and inform capital planning."
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average RF signal strength in dBm across the AMI network. Used to identify network coverage degradation and prioritise infrastructure reinforcement."
    - name: "avg_battery_expected_life_years"
      expr: AVG(CAST(battery_expected_life_years AS DOUBLE))
      comment: "Average expected battery life in years across the endpoint fleet. Used to model future battery replacement capital requirements."
    - name: "leak_detection_enabled_count"
      expr: SUM(CASE WHEN leak_detection_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of endpoints with leak detection enabled. Measures the coverage of the AMI leak detection programme across the network."
    - name: "reverse_flow_detected_count"
      expr: SUM(CASE WHEN reverse_flow_detected_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of endpoints currently showing a reverse flow detected flag. Identifies backflow and cross-connection risks requiring immediate field investigation."
    - name: "avg_leak_alert_threshold_gpm"
      expr: AVG(CAST(leak_alert_threshold_gpm AS DOUBLE))
      comment: "Average leak alert threshold in gallons per minute configured across endpoints. Used to assess and standardise detection sensitivity across the network."
    - name: "low_battery_endpoint_count"
      expr: SUM(CASE WHEN battery_level_percent < 20 THEN 1 ELSE 0 END)
      comment: "Count of endpoints with battery level below 20%. Drives proactive battery replacement field work orders to prevent communication failures and data gaps."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`metering_replacement_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for meter replacement orders tracking programme execution, work order linkage, and procurement fulfilment. Supports capital programme management, asset lifecycle decisions, and regulatory compliance for meter replacement mandates."
  source: "`water_utilities_ecm`.`metering`.`replacement_order`"
  dimensions:
    - name: "replacement_program_id"
      expr: replacement_program_id
      comment: "Identifier of the replacement programme driving the order, used to segment execution metrics by programme (e.g., AMI rollout, aged-meter programme, regulatory mandate)."
    - name: "has_accuracy_test"
      expr: CASE WHEN accuracy_test_id IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Boolean indicating whether the replacement was preceded by an accuracy test, used to measure compliance with test-before-replace policies."
    - name: "has_purchase_order"
      expr: CASE WHEN purchase_order_id IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Boolean indicating whether a purchase order was raised for the replacement, used to track procurement process compliance."
    - name: "has_work_order"
      expr: CASE WHEN work_order_id IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Boolean indicating whether a work order was created for the replacement, used to measure field execution linkage."
  measures:
    - name: "total_replacement_orders"
      expr: COUNT(1)
      comment: "Total number of meter replacement orders. Primary throughput KPI for capital replacement programmes and regulatory compliance tracking."
    - name: "distinct_replacement_programs"
      expr: COUNT(DISTINCT replacement_program_id)
      comment: "Number of distinct replacement programmes with active orders. Used to monitor programme portfolio breadth and resource allocation across concurrent initiatives."
    - name: "accuracy_tested_replacement_count"
      expr: SUM(CASE WHEN accuracy_test_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of replacements linked to a prior accuracy test. Measures compliance with test-before-replace policies required by AWWA standards and regulatory mandates."
    - name: "work_order_linked_count"
      expr: SUM(CASE WHEN work_order_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of replacement orders with an associated work order. Measures field execution linkage and identifies orders that may be stalled in the procurement-to-installation pipeline."
    - name: "goods_receipt_linked_count"
      expr: SUM(CASE WHEN goods_receipt_id IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of replacement orders with a confirmed goods receipt. Measures supply chain fulfilment progress and identifies procurement bottlenecks in the replacement programme."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`metering_meter_size_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reference and financial metrics for the meter size type catalogue. Tracks fleet composition by meter class, cost benchmarks, accuracy specifications, and AMI/AMR compatibility. Informs procurement strategy, replacement programme design, and regulatory compliance planning."
  source: "`water_utilities_ecm`.`metering`.`meter_size_type`"
  filter: active_flag = TRUE
  dimensions:
    - name: "meter_type"
      expr: meter_type
      comment: "Technology type of the meter (e.g., Positive Displacement, Turbine, Electromagnetic), used to segment performance and cost metrics by meter technology."
    - name: "measurement_class"
      expr: measurement_class
      comment: "Measurement class of the meter (e.g., Residential, Commercial, Industrial), used to align meter specifications with customer class requirements."
    - name: "typical_customer_class"
      expr: typical_customer_class
      comment: "Typical customer class the meter size is deployed for, used to plan replacement programmes by customer segment."
    - name: "ami_compatible_flag"
      expr: ami_compatible_flag
      comment: "Boolean indicating AMI compatibility, used to segment the meter catalogue into AMI-ready and legacy types for upgrade planning."
    - name: "amr_compatible_flag"
      expr: amr_compatible_flag
      comment: "Boolean indicating AMR compatibility, used to identify meter types eligible for automated reading without full AMI deployment."
    - name: "lead_free_certified_flag"
      expr: lead_free_certified_flag
      comment: "Boolean indicating lead-free certification, used to ensure regulatory compliance with lead-free material mandates (e.g., Safe Drinking Water Act)."
    - name: "nsf_61_certified_flag"
      expr: nsf_61_certified_flag
      comment: "Boolean indicating NSF/ANSI 61 certification for drinking water contact materials, used to verify regulatory compliance of the meter catalogue."
    - name: "meter_size_type_status"
      expr: meter_size_type_status
      comment: "Lifecycle status of the meter size type (e.g., Active, Obsolete, Discontinued), used to manage catalogue currency and procurement eligibility."
    - name: "connection_type"
      expr: connection_type
      comment: "Connection type of the meter (e.g., Threaded, Flanged, Compression), used to ensure compatibility with existing service line infrastructure."
  measures:
    - name: "total_meter_size_types"
      expr: COUNT(1)
      comment: "Total number of active meter size types in the catalogue. Measures catalogue breadth and supports procurement standardisation initiatives."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(average_unit_cost_usd AS DOUBLE))
      comment: "Average unit cost in USD across meter size types. Used for procurement budget modelling and replacement programme cost estimation."
    - name: "max_unit_cost_usd"
      expr: MAX(average_unit_cost_usd)
      comment: "Maximum unit cost in USD across meter size types. Identifies the highest-cost meter classes for capital budget sensitivity analysis."
    - name: "avg_installation_labor_hours"
      expr: AVG(CAST(installation_labor_hours AS DOUBLE))
      comment: "Average installation labour hours per meter size type. Used to estimate field crew requirements and total installed cost for replacement programmes."
    - name: "avg_accuracy_normal_flow_pct"
      expr: AVG(CAST(accuracy_percentage_normal_flow AS DOUBLE))
      comment: "Average accuracy percentage at normal flow across meter types. Measures the theoretical revenue assurance quality of the meter catalogue."
    - name: "avg_accuracy_low_flow_pct"
      expr: AVG(CAST(accuracy_percentage_low_flow AS DOUBLE))
      comment: "Average accuracy percentage at low flow across meter types. Low-flow accuracy is critical for residential leak detection and minimum night flow analysis."
    - name: "ami_compatible_type_count"
      expr: SUM(CASE WHEN ami_compatible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of meter size types that are AMI-compatible. Measures the AMI-readiness of the meter catalogue and informs technology upgrade strategy."
    - name: "lead_free_certified_type_count"
      expr: SUM(CASE WHEN lead_free_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of meter size types with lead-free certification. Measures regulatory compliance coverage of the catalogue against lead-free material mandates."
    - name: "avg_max_flow_rate_gpm"
      expr: AVG(CAST(maximum_flow_rate_gpm AS DOUBLE))
      comment: "Average maximum flow rate capacity in GPM across meter size types. Used to validate that the meter catalogue covers the full range of customer demand profiles."
$$;