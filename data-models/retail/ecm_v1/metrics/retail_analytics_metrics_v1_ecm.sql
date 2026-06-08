-- Metric views for domain: analytics | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`analytics_kpi_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPI performance metrics tracking actual vs target performance across business entities, time periods, and organizational dimensions. Enables executive dashboards, variance analysis, and performance steering."
  source: "`retail_ecm`.`analytics`.`kpi_value`"
  dimensions:
    - name: "kpi_definition_id"
      expr: kpi_definition_id
      comment: "Foreign key to KPI definition for metric classification and drill-through"
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity being measured (store, department, SKU, customer segment, etc.)"
    - name: "period_type"
      expr: period_type
      comment: "Measurement period granularity (daily, weekly, monthly, quarterly, yearly)"
    - name: "performance_status"
      expr: performance_status
      comment: "Performance classification (on-target, above-target, below-target, at-risk)"
    - name: "alert_triggered_flag"
      expr: alert_triggered_flag
      comment: "Whether this KPI value triggered an alert threshold"
    - name: "is_forecast"
      expr: is_forecast
      comment: "Distinguishes forecasted vs actual KPI values"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Directional trend indicator (improving, declining, stable)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for monetary KPI values"
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the measurement period for time-series analysis"
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End date of the measurement period for time-series analysis"
    - name: "data_source"
      expr: data_source
      comment: "Source system or process that generated the KPI value"
  measures:
    - name: "total_kpi_measurements"
      expr: COUNT(1)
      comment: "Total number of KPI measurements recorded"
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of actual KPI values across all measurements"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of target KPI values across all measurements"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Sum of variance between actual and target (actual minus target)"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual KPI value per measurement"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target KPI value per measurement"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance between actual and target performance"
    - name: "target_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(actual_value AS DOUBLE) >= CAST(target_value AS DOUBLE) THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPI measurements that met or exceeded target"
    - name: "alert_trigger_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_triggered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of KPI measurements that triggered alerts"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for KPI measurements"
    - name: "distinct_kpi_definitions"
      expr: COUNT(DISTINCT kpi_definition_id)
      comment: "Number of unique KPI definitions measured"
    - name: "distinct_business_entities"
      expr: COUNT(DISTINCT business_entity_id)
      comment: "Number of unique business entities measured"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`analytics_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alert management and response metrics tracking alert volume, severity distribution, resolution performance, and escalation patterns. Critical for operational monitoring and incident response effectiveness."
  source: "`retail_ecm`.`analytics`.`alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Classification of alert (threshold breach, anomaly, data quality, compliance, operational)"
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of alert (new, acknowledged, in-progress, resolved, closed, false-positive)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low)"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation tier (L1, L2, L3, executive)"
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Whether alert was determined to be a false positive"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification was successfully sent"
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used for alert notification (email, SMS, Slack, PagerDuty)"
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity that triggered the alert"
    - name: "data_source"
      expr: data_source
      comment: "Source system or process that generated the alert"
    - name: "triggered_date"
      expr: DATE(triggered_timestamp)
      comment: "Date the alert was triggered for time-series analysis"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of alerts generated"
    - name: "total_resolved_alerts"
      expr: SUM(CASE WHEN alert_status IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Number of alerts that have been resolved or closed"
    - name: "total_false_positives"
      expr: SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of alerts identified as false positives"
    - name: "alert_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_status IN ('resolved', 'closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that have been resolved"
    - name: "false_positive_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts that were false positives - key quality metric"
    - name: "notification_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of alerts where notification was successfully sent"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual value that triggered alerts"
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value for alert triggers"
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance between actual and threshold values"
    - name: "distinct_kpi_definitions"
      expr: COUNT(DISTINCT kpi_definition_id)
      comment: "Number of unique KPI definitions that generated alerts"
    - name: "distinct_business_entities"
      expr: COUNT(DISTINCT business_entity_id)
      comment: "Number of unique business entities that triggered alerts"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`analytics_dq_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality execution results tracking rule pass/fail rates, failure trends, and data trust scores. Essential for data governance, compliance reporting, and data reliability monitoring."
  source: "`retail_ecm`.`analytics`.`dq_result`"
  dimensions:
    - name: "dq_rule_id"
      expr: dq_rule_id
      comment: "Foreign key to data quality rule definition"
    - name: "execution_status"
      expr: execution_status
      comment: "Status of DQ rule execution (success, failure, error, timeout)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Overall pass/fail result of the data quality check"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of DQ failures (critical, high, medium, low)"
    - name: "rule_type"
      expr: rule_type
      comment: "Type of data quality rule (completeness, accuracy, consistency, timeliness, validity)"
    - name: "target_domain"
      expr: target_domain
      comment: "Domain of the data product being validated"
    - name: "target_product"
      expr: target_product
      comment: "Specific data product being validated"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether DQ check met SLA requirements"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Whether notification was sent for DQ failures"
    - name: "trend_direction"
      expr: trend_direction
      comment: "Trend of data quality over time (improving, declining, stable)"
    - name: "execution_date"
      expr: DATE(execution_timestamp)
      comment: "Date of DQ rule execution for time-series analysis"
  measures:
    - name: "total_dq_executions"
      expr: COUNT(1)
      comment: "Total number of data quality rule executions"
    - name: "total_records_evaluated"
      expr: SUM(CAST(records_evaluated_count AS DOUBLE))
      comment: "Total number of records evaluated across all DQ checks"
    - name: "total_records_passed"
      expr: SUM(CAST(records_passed_count AS DOUBLE))
      comment: "Total number of records that passed DQ checks"
    - name: "total_records_failed"
      expr: SUM(CAST(records_failed_count AS DOUBLE))
      comment: "Total number of records that failed DQ checks"
    - name: "dq_pass_rate"
      expr: ROUND(100.0 * SUM(CAST(records_passed_count AS DOUBLE)) / NULLIF(SUM(CAST(records_evaluated_count AS DOUBLE)), 0), 2)
      comment: "Overall data quality pass rate - key data trust metric"
    - name: "dq_failure_rate"
      expr: ROUND(100.0 * SUM(CAST(records_failed_count AS DOUBLE)) / NULLIF(SUM(CAST(records_evaluated_count AS DOUBLE)), 0), 2)
      comment: "Overall data quality failure rate"
    - name: "avg_data_trust_score"
      expr: AVG(CAST(data_trust_score AS DOUBLE))
      comment: "Average data trust score across all DQ executions"
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(execution_duration_seconds AS DOUBLE))
      comment: "Average execution time for DQ checks - performance metric"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DQ checks that met SLA requirements"
    - name: "execution_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN execution_status = 'success' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DQ rule executions that completed successfully"
    - name: "distinct_dq_rules"
      expr: COUNT(DISTINCT dq_rule_id)
      comment: "Number of unique DQ rules executed"
    - name: "distinct_target_products"
      expr: COUNT(DISTINCT target_product)
      comment: "Number of unique data products validated"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`analytics_dq_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality issue tracking and resolution metrics measuring issue volume, resolution time, root cause patterns, and business impact. Critical for data quality improvement programs and compliance."
  source: "`retail_ecm`.`analytics`.`dq_issue`"
  dimensions:
    - name: "dq_issue_status"
      expr: dq_issue_status
      comment: "Current status of DQ issue (new, assigned, in-progress, resolved, closed, reopened)"
    - name: "issue_type"
      expr: issue_type
      comment: "Classification of data quality issue type"
    - name: "severity"
      expr: severity
      comment: "Severity level of the DQ issue (critical, high, medium, low)"
    - name: "priority"
      expr: priority
      comment: "Priority for resolution (P0, P1, P2, P3)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (source system, transformation logic, data entry, integration)"
    - name: "domain"
      expr: domain
      comment: "Data domain where issue occurred"
    - name: "data_product"
      expr: data_product
      comment: "Specific data product affected by the issue"
    - name: "compliance_impact_flag"
      expr: compliance_impact_flag
      comment: "Whether issue has compliance or regulatory impact"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring issue"
    - name: "business_impact"
      expr: business_impact
      comment: "Description of business impact level"
    - name: "detected_date"
      expr: DATE(detected_timestamp)
      comment: "Date issue was detected for time-series analysis"
  measures:
    - name: "total_dq_issues"
      expr: COUNT(1)
      comment: "Total number of data quality issues logged"
    - name: "total_resolved_issues"
      expr: SUM(CASE WHEN dq_issue_status IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Number of DQ issues that have been resolved"
    - name: "total_open_issues"
      expr: SUM(CASE WHEN dq_issue_status NOT IN ('resolved', 'closed') THEN 1 ELSE 0 END)
      comment: "Number of DQ issues still open"
    - name: "total_affected_records"
      expr: SUM(CAST(affected_record_count AS DOUBLE))
      comment: "Total number of records affected by DQ issues"
    - name: "avg_affected_records"
      expr: AVG(CAST(affected_record_count AS DOUBLE))
      comment: "Average number of records affected per DQ issue"
    - name: "total_remediation_cost"
      expr: SUM(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to remediate all DQ issues"
    - name: "avg_remediation_cost"
      expr: AVG(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Average estimated remediation cost per DQ issue"
    - name: "issue_resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dq_issue_status IN ('resolved', 'closed') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DQ issues that have been resolved"
    - name: "compliance_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DQ issues with compliance impact"
    - name: "recurrence_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DQ issues that are recurring - indicates systemic problems"
    - name: "distinct_dq_rules"
      expr: COUNT(DISTINCT dq_rule_id)
      comment: "Number of unique DQ rules that generated issues"
    - name: "distinct_data_products"
      expr: COUNT(DISTINCT data_product)
      comment: "Number of unique data products with DQ issues"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`analytics_report_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report delivery and subscription engagement metrics tracking delivery success rates, subscription adoption, and report consumption patterns. Key for analytics platform ROI and user engagement."
  source: "`retail_ecm`.`analytics`.`report_subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of subscription (active, paused, cancelled, expired)"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used for report delivery (email, portal, API, FTP)"
    - name: "delivery_schedule_type"
      expr: delivery_schedule_type
      comment: "Type of delivery schedule (daily, weekly, monthly, on-demand, event-driven)"
    - name: "output_format"
      expr: output_format
      comment: "Format of delivered report (PDF, Excel, CSV, PowerPoint)"
    - name: "is_shared_subscription"
      expr: is_shared_subscription
      comment: "Whether subscription is shared across multiple users"
    - name: "data_refresh_required_flag"
      expr: data_refresh_required_flag
      comment: "Whether report requires data refresh before delivery"
    - name: "notification_on_failure_flag"
      expr: notification_on_failure_flag
      comment: "Whether notifications are sent on delivery failures"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for report delivery"
    - name: "report_definition_id"
      expr: report_definition_id
      comment: "Foreign key to report definition"
    - name: "created_date"
      expr: DATE(created_timestamp)
      comment: "Date subscription was created for time-series analysis"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of report subscriptions"
    - name: "total_active_subscriptions"
      expr: SUM(CASE WHEN subscription_status = 'active' THEN 1 ELSE 0 END)
      comment: "Number of currently active subscriptions"
    - name: "subscription_activation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN subscription_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that are currently active - engagement metric"
    - name: "delivery_success_rate"
      expr: ROUND(100.0 * (SUM(CAST(delivery_count AS DOUBLE)) - SUM(CAST(failed_delivery_count AS DOUBLE))) / NULLIF(SUM(CAST(delivery_count AS DOUBLE)), 0), 2)
      comment: "Percentage of successful report deliveries - key operational metric"
    - name: "total_deliveries"
      expr: SUM(CAST(delivery_count AS DOUBLE))
      comment: "Total number of report deliveries attempted"
    - name: "total_failed_deliveries"
      expr: SUM(CAST(failed_delivery_count AS DOUBLE))
      comment: "Total number of failed report deliveries"
    - name: "avg_deliveries_per_subscription"
      expr: AVG(CAST(delivery_count AS DOUBLE))
      comment: "Average number of deliveries per subscription"
    - name: "shared_subscription_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_shared_subscription = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of subscriptions that are shared - collaboration metric"
    - name: "distinct_report_definitions"
      expr: COUNT(DISTINCT report_definition_id)
      comment: "Number of unique reports with active subscriptions"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT primary_report_associate_id)
      comment: "Number of unique users with report subscriptions"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`analytics_self_service_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Self-service analytics usage and performance metrics tracking query volume, execution performance, cost efficiency, and user adoption. Essential for platform optimization and user enablement."
  source: "`retail_ecm`.`analytics`.`self_service_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Execution status of query (success, failed, cancelled, timeout)"
    - name: "query_type"
      expr: query_type
      comment: "Type of query (ad-hoc, saved, scheduled, dashboard)"
    - name: "query_purpose"
      expr: query_purpose
      comment: "Business purpose of query (analysis, reporting, exploration, validation)"
    - name: "bi_tool"
      expr: bi_tool
      comment: "BI tool used to execute query (Tableau, Power BI, SQL editor, Python)"
    - name: "cache_hit"
      expr: cache_hit
      comment: "Whether query result was served from cache"
    - name: "query_optimization_applied"
      expr: query_optimization_applied
      comment: "Whether query optimization was applied"
    - name: "saved_query_flag"
      expr: saved_query_flag
      comment: "Whether query was saved for reuse"
    - name: "shared_flag"
      expr: shared_flag
      comment: "Whether query was shared with other users"
    - name: "contains_pii"
      expr: contains_pii
      comment: "Whether query accessed PII data"
    - name: "target_domain"
      expr: target_domain
      comment: "Data domain queried"
    - name: "user_role"
      expr: user_role
      comment: "Role of user executing query"
    - name: "execution_date"
      expr: DATE(execution_timestamp)
      comment: "Date query was executed for time-series analysis"
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total number of self-service queries executed"
    - name: "total_successful_queries"
      expr: SUM(CASE WHEN query_status = 'success' THEN 1 ELSE 0 END)
      comment: "Number of queries that executed successfully"
    - name: "query_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN query_status = 'success' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries that executed successfully - platform reliability metric"
    - name: "cache_hit_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cache_hit = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries served from cache - performance optimization metric"
    - name: "avg_query_duration_seconds"
      expr: AVG(CAST(query_duration_seconds AS DOUBLE))
      comment: "Average query execution time in seconds - user experience metric"
    - name: "total_compute_cost_usd"
      expr: SUM(CAST(compute_cost_usd AS DOUBLE))
      comment: "Total compute cost for all queries - cost management metric"
    - name: "avg_compute_cost_usd"
      expr: AVG(CAST(compute_cost_usd AS DOUBLE))
      comment: "Average compute cost per query"
    - name: "total_data_scanned_bytes"
      expr: SUM(CAST(data_scanned_bytes AS DOUBLE))
      comment: "Total bytes of data scanned across all queries"
    - name: "avg_data_scanned_bytes"
      expr: AVG(CAST(data_scanned_bytes AS DOUBLE))
      comment: "Average bytes scanned per query - efficiency metric"
    - name: "avg_query_complexity_score"
      expr: AVG(CAST(query_complexity_score AS DOUBLE))
      comment: "Average query complexity score"
    - name: "total_rows_returned"
      expr: SUM(CAST(rows_returned AS DOUBLE))
      comment: "Total rows returned across all queries"
    - name: "avg_rows_returned"
      expr: AVG(CAST(rows_returned AS DOUBLE))
      comment: "Average rows returned per query"
    - name: "query_reuse_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN saved_query_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries saved for reuse - knowledge capture metric"
    - name: "query_sharing_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN shared_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of queries shared with others - collaboration metric"
    - name: "distinct_users"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of unique users executing self-service queries - adoption metric"
    - name: "distinct_data_products"
      expr: COUNT(DISTINCT target_data_product)
      comment: "Number of unique data products queried"
$$;