-- Metric views for domain: analytics | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_kpi_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core KPI performance tracking — measures actual vs target values, variance, and trend across all business KPIs. Primary steering view for executive dashboards and QBRs."
  source: "`vibe_retail_v1`.`analytics`.`kpi_value`"
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Granularity of the measurement period (daily, weekly, monthly, quarterly, annual) for time-series slicing."
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity the KPI value is attributed to (store, product, customer, channel, etc.)."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for monetary KPI values, enabling multi-currency reporting."
    - name: "performance_status"
      expr: performance_status
      comment: "Categorical performance rating (on_track, at_risk, off_track) for traffic-light dashboards."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of KPI movement (improving, declining, stable) for trend analysis."
    - name: "is_forecast"
      expr: is_forecast
      comment: "Flag distinguishing forecast values from actuals, enabling plan-vs-actual comparisons."
    - name: "measurement_period_start_date"
      expr: measurement_period_start_date
      comment: "Start date of the measurement window for time-series bucketing."
    - name: "measurement_period_end_date"
      expr: measurement_period_end_date
      comment: "End date of the measurement window for period-over-period analysis."
    - name: "data_source"
      expr: data_source
      comment: "Source system that produced the KPI value, supporting data lineage and trust scoring."
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of any alert triggered by this KPI value (critical, high, medium, low)."
  measures:
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of all actual KPI values in the selected period and dimension slice. Additive for monetary and count KPIs."
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual KPI value per record, useful for rate and score KPIs where summing is not meaningful."
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all target KPI values, used as the denominator in attainment calculations."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per KPI record, for rate-based KPIs where targets are set per unit."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total absolute variance (actual minus target) across all KPI records. Negative values indicate underperformance."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from target. Key executive metric for performance gap assessment."
    - name: "total_prior_period_variance_amount"
      expr: SUM(CAST(prior_period_variance_amount AS DOUBLE))
      comment: "Total period-over-period variance amount, enabling YoY and QoQ trend analysis."
    - name: "avg_prior_period_variance_percentage"
      expr: AVG(CAST(prior_period_variance_percentage AS DOUBLE))
      comment: "Average period-over-period variance percentage, used in trend dashboards and steering meetings."
    - name: "kpi_record_count"
      expr: COUNT(1)
      comment: "Total number of KPI value records in the slice, used to assess coverage and completeness."
    - name: "alert_triggered_count"
      expr: SUM(CASE WHEN alert_triggered_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of KPI values that triggered an alert, indicating the volume of performance exceptions requiring leadership attention."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across KPI values, used to assess trustworthiness of reported metrics."
    - name: "forecast_record_count"
      expr: SUM(CASE WHEN is_forecast = TRUE THEN 1 ELSE 0 END)
      comment: "Count of forecast vs actual records, supporting plan-vs-actual coverage analysis."
    - name: "avg_confidence_interval_lower"
      expr: AVG(CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average lower bound of confidence intervals for forecast KPI values, indicating forecast uncertainty."
    - name: "avg_confidence_interval_upper"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE))
      comment: "Average upper bound of confidence intervals for forecast KPI values, indicating forecast uncertainty range."
    - name: "total_prior_period_value"
      expr: SUM(CAST(prior_period_value AS DOUBLE))
      comment: "Sum of prior period KPI values for period-over-period benchmarking and trend analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_kpi_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI target-setting governance — tracks target values, stretch goals, floor thresholds, and approval status across business units. Used by finance and strategy teams to govern performance expectations."
  source: "`vibe_retail_v1`.`analytics`.`analytics_kpi_target`"
  dimensions:
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of entity the target applies to (store, region, product category, channel) for hierarchical target analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the target for annual planning and budget cycle alignment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month, quarter) of the target for in-year tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status (pending, approved, rejected) for governance and audit trails."
    - name: "target_setting_method"
      expr: target_setting_method
      comment: "Method used to set the target (top-down, bottom-up, statistical) for process transparency."
    - name: "target_basis"
      expr: target_basis
      comment: "Basis for the target (prior_year, budget, forecast, benchmark) for context in performance reviews."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for monetary targets, enabling multi-currency target management."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the target is currently active, filtering out superseded versions."
    - name: "incentive_eligible_flag"
      expr: incentive_eligible_flag
      comment: "Flag indicating whether this target is tied to incentive compensation, critical for HR and finance alignment."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the target measurement period for time-series analysis."
  measures:
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Sum of all KPI target values in the slice. Additive for monetary and volume targets used in budget reviews."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value per record, useful for rate-based KPIs where targets are set per unit or store."
    - name: "total_stretch_target_value"
      expr: SUM(CAST(stretch_target_value AS DOUBLE))
      comment: "Sum of stretch target values, representing aspirational performance goals used in incentive planning."
    - name: "avg_stretch_target_value"
      expr: AVG(CAST(stretch_target_value AS DOUBLE))
      comment: "Average stretch target value, used to assess ambition level relative to base targets."
    - name: "total_floor_threshold_value"
      expr: SUM(CAST(floor_threshold_value AS DOUBLE))
      comment: "Sum of floor threshold values, representing minimum acceptable performance levels for risk management."
    - name: "avg_variance_alert_threshold_percent"
      expr: AVG(CAST(variance_alert_threshold_percent AS DOUBLE))
      comment: "Average variance alert threshold percentage, indicating how tightly targets are monitored across the portfolio."
    - name: "active_target_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active targets, used to assess target coverage across the business."
    - name: "approved_target_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved targets, used to track governance completion in the target-setting cycle."
    - name: "incentive_eligible_target_count"
      expr: SUM(CASE WHEN incentive_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of targets tied to incentive compensation, used by HR and finance for compensation planning."
    - name: "total_target_records"
      expr: COUNT(1)
      comment: "Total number of target records, used to assess target-setting coverage and completeness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational alert performance — tracks alert volume, severity distribution, resolution times, and false positive rates. Used by operations and analytics teams to manage exception handling and system health."
  source: "`vibe_retail_v1`.`analytics`.`alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Category of alert (threshold_breach, anomaly, data_quality, compliance) for triage and routing."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, high, medium, low) for prioritization in operations dashboards."
    - name: "alert_status"
      expr: alert_status
      comment: "Current lifecycle status (open, acknowledged, resolved, suppressed) for workload management."
    - name: "business_entity_type"
      expr: business_entity_type
      comment: "Type of business entity the alert relates to, enabling domain-specific alert analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier reached (L1, L2, L3, executive) for SLA compliance tracking."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to deliver the alert (email, slack, pagerduty) for notification effectiveness analysis."
    - name: "period_type"
      expr: period_type
      comment: "Time granularity of the alert measurement period for trend analysis."
    - name: "false_positive_flag"
      expr: false_positive_flag
      comment: "Flag indicating the alert was a false positive, used to tune alert rules and reduce noise."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for monetary threshold alerts, enabling financial impact analysis."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of alerts fired in the period. High volumes indicate systemic issues requiring leadership attention."
    - name: "critical_alert_count"
      expr: SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical-severity alerts, the primary metric for operational risk dashboards and executive escalation."
    - name: "false_positive_count"
      expr: SUM(CASE WHEN false_positive_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of false positive alerts, used to measure alert rule quality and reduce analyst fatigue."
    - name: "suppressed_alert_count"
      expr: SUM(CASE WHEN suppression_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of suppressed alerts, used to audit suppression policies and ensure no real issues are hidden."
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Sum of actual metric values at alert trigger time, providing financial or operational magnitude of exceptions."
    - name: "total_threshold_value"
      expr: SUM(CAST(threshold_value AS DOUBLE))
      comment: "Sum of threshold values that triggered alerts, used to calibrate alert sensitivity."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount across all alerts, quantifying the aggregate magnitude of performance deviations."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance at alert trigger, indicating typical deviation severity across the alert portfolio."
    - name: "notification_sent_count"
      expr: SUM(CASE WHEN notification_sent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of alerts where notifications were successfully sent, used to measure alert delivery effectiveness."
    - name: "unique_kpi_definitions_alerted"
      expr: COUNT(DISTINCT kpi_definition_id)
      comment: "Number of distinct KPI definitions that triggered alerts, indicating breadth of performance issues."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dq_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality execution results — tracks pass/fail rates, failure volumes, and data trust scores across all DQ rule executions. Critical for data governance, regulatory compliance, and analytics trustworthiness."
  source: "`vibe_retail_v1`.`analytics`.`dq_result`"
  dimensions:
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Binary outcome of the DQ rule execution (pass, fail) for quality gate monitoring."
    - name: "rule_type"
      expr: rule_type
      comment: "Category of DQ rule (completeness, uniqueness, validity, consistency, timeliness) for root cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the DQ result (critical, high, medium, low) for prioritizing remediation efforts."
    - name: "target_domain"
      expr: target_domain
      comment: "Business domain of the data being validated, enabling domain-level quality scorecards."
    - name: "target_product"
      expr: target_product
      comment: "Specific data product being validated, for product-level quality tracking."
    - name: "execution_status"
      expr: execution_status
      comment: "Technical execution status (success, error, timeout) to distinguish data failures from infrastructure failures."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Execution schedule type (real-time, batch, on-demand) for operational planning."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Direction of quality trend (improving, degrading, stable) for proactive governance."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Flag indicating whether the DQ check completed within its SLA window, for SLA reporting."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of DQ rule executions, used to assess monitoring coverage and cadence."
    - name: "failed_execution_count"
      expr: SUM(CASE WHEN pass_fail_status = 'fail' THEN 1 ELSE 0 END)
      comment: "Count of failed DQ checks, the primary metric for data quality health dashboards."
    - name: "total_records_evaluated"
      expr: SUM(CAST(records_evaluated_count AS DOUBLE))
      comment: "Total records evaluated across all DQ checks, providing scale context for failure rates."
    - name: "total_records_failed"
      expr: SUM(CAST(records_failed_count AS DOUBLE))
      comment: "Total records that failed DQ validation, quantifying the volume of data quality issues."
    - name: "total_records_passed"
      expr: SUM(CAST(records_passed_count AS DOUBLE))
      comment: "Total records that passed DQ validation, used to compute overall pass rates."
    - name: "avg_failure_rate_percent"
      expr: AVG(CAST(failure_rate_percent AS DOUBLE))
      comment: "Average failure rate percentage across DQ executions, the headline data quality KPI for executive reporting."
    - name: "avg_data_trust_score"
      expr: AVG(CAST(data_trust_score AS DOUBLE))
      comment: "Average data trust score across all validated entities, used in data product certification and consumer confidence."
    - name: "avg_execution_duration_seconds"
      expr: AVG(CAST(execution_duration_seconds AS DOUBLE))
      comment: "Average DQ check execution time, used to identify performance bottlenecks in the quality pipeline."
    - name: "sla_compliant_count"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of DQ executions that met their SLA, used for SLA compliance reporting to data governance boards."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value configured across DQ rules, used to assess rule sensitivity calibration."
    - name: "unique_products_validated"
      expr: COUNT(DISTINCT target_product)
      comment: "Number of distinct data products validated, measuring breadth of DQ monitoring coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dq_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality issue management — tracks open issues, remediation progress, compliance impact, and recurrence rates. Used by data governance teams and CDOs to manage data quality risk."
  source: "`vibe_retail_v1`.`analytics`.`dq_issue`"
  dimensions:
    - name: "dq_issue_status"
      expr: dq_issue_status
      comment: "Lifecycle status of the issue (open, in_progress, resolved, closed) for workload and backlog management."
    - name: "issue_type"
      expr: issue_type
      comment: "Category of data quality issue (missing_value, duplicate, format_error, referential_integrity) for root cause analysis."
    - name: "severity"
      expr: severity
      comment: "Business severity of the issue (critical, high, medium, low) for prioritization in governance reviews."
    - name: "priority"
      expr: priority
      comment: "Remediation priority assigned to the issue, used for sprint planning and resource allocation."
    - name: "domain"
      expr: domain
      comment: "Business domain where the issue was detected, enabling domain-level quality scorecards."
    - name: "data_product"
      expr: data_product
      comment: "Specific data product affected by the issue, for product-level quality accountability."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification (upstream_source, transformation, schema_change, process) for systemic improvement."
    - name: "compliance_impact_flag"
      expr: compliance_impact_flag
      comment: "Flag indicating the issue has regulatory or compliance implications, triggering escalation protocols."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating the issue is a recurrence of a previously resolved problem, used to measure fix effectiveness."
    - name: "detection_method"
      expr: detection_method
      comment: "How the issue was detected (automated_rule, manual_review, user_report) for detection coverage analysis."
  measures:
    - name: "total_issues"
      expr: COUNT(1)
      comment: "Total number of data quality issues, the headline metric for data quality health reporting."
    - name: "open_issue_count"
      expr: SUM(CASE WHEN dq_issue_status = 'open' THEN 1 ELSE 0 END)
      comment: "Count of currently open issues, representing the active data quality backlog requiring remediation."
    - name: "compliance_impact_issue_count"
      expr: SUM(CASE WHEN compliance_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of issues with compliance impact, the critical metric for regulatory risk management and audit readiness."
    - name: "recurrence_count"
      expr: SUM(CASE WHEN recurrence_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of recurring issues, indicating systemic problems where root cause fixes have not been effective."
    - name: "total_affected_records"
      expr: SUM(CAST(affected_record_count AS DOUBLE))
      comment: "Total number of data records affected by quality issues, quantifying the business impact of data problems."
    - name: "total_remediation_cost_estimate"
      expr: SUM(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Total estimated cost to remediate all open data quality issues, used in budget planning for data engineering."
    - name: "avg_remediation_cost_estimate"
      expr: AVG(CAST(remediation_cost_estimate AS DOUBLE))
      comment: "Average remediation cost per issue, used to prioritize high-cost issues and justify quality investment."
    - name: "unique_domains_affected"
      expr: COUNT(DISTINCT domain)
      comment: "Number of distinct business domains with active data quality issues, measuring breadth of quality risk."
    - name: "critical_issue_count"
      expr: SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical-severity issues requiring immediate executive attention and remediation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dq_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data quality rule governance — tracks rule coverage, violation rates, and rule health across the data quality framework. Used by data stewards and governance teams to manage the DQ rule portfolio."
  source: "`vibe_retail_v1`.`analytics`.`dq_rule`"
  dimensions:
    - name: "rule_type"
      expr: rule_type
      comment: "Category of DQ rule (completeness, uniqueness, validity, consistency, timeliness) for portfolio analysis."
    - name: "rule_status"
      expr: rule_status
      comment: "Lifecycle status of the rule (active, draft, deprecated, suspended) for rule portfolio management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to violations of this rule, used for risk-weighted quality scoring."
    - name: "target_domain"
      expr: target_domain
      comment: "Business domain the rule monitors, enabling domain-level coverage analysis."
    - name: "target_product"
      expr: target_product
      comment: "Data product the rule validates, for product-level rule coverage reporting."
    - name: "execution_frequency"
      expr: execution_frequency
      comment: "How often the rule executes (real-time, hourly, daily, weekly) for monitoring cadence analysis."
    - name: "blocking_flag"
      expr: blocking_flag
      comment: "Flag indicating whether rule failures block data pipeline progression, for critical path analysis."
    - name: "execution_layer"
      expr: execution_layer
      comment: "Layer where the rule executes (ingestion, transformation, serving) for architecture governance."
  measures:
    - name: "total_rules"
      expr: COUNT(1)
      comment: "Total number of DQ rules in the portfolio, used to assess monitoring coverage breadth."
    - name: "active_rule_count"
      expr: SUM(CASE WHEN rule_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active DQ rules, the baseline for coverage reporting to governance boards."
    - name: "blocking_rule_count"
      expr: SUM(CASE WHEN blocking_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocking rules that halt pipelines on failure, indicating the strictness of quality gates."
    - name: "total_last_violation_count"
      expr: SUM(CAST(last_violation_count AS DOUBLE))
      comment: "Total violations recorded in the most recent execution across all rules, the headline quality health metric."
    - name: "avg_last_violation_count"
      expr: AVG(CAST(last_violation_count AS DOUBLE))
      comment: "Average violations per rule in the last execution, used to identify rules with systemic failure patterns."
    - name: "avg_threshold_value"
      expr: AVG(CAST(threshold_value AS DOUBLE))
      comment: "Average threshold value across rules, used to assess overall sensitivity calibration of the DQ framework."
    - name: "unique_domains_covered"
      expr: COUNT(DISTINCT target_domain)
      comment: "Number of distinct domains with active DQ rules, measuring breadth of quality monitoring coverage."
    - name: "notification_enabled_count"
      expr: SUM(CASE WHEN notification_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of rules with notifications enabled, used to assess alerting coverage for quality failures."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_kpi_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI governance and catalog — tracks the health, coverage, and certification status of the enterprise KPI library. Used by analytics leadership to govern the semantic layer and ensure metric standardization."
  source: "`vibe_retail_v1`.`analytics`.`kpi_definition`"
  dimensions:
    - name: "owning_business_function"
      expr: owning_business_function
      comment: "Business function that owns the KPI (finance, operations, marketing, supply_chain) for accountability mapping."
    - name: "approval_status"
      expr: approval_status
      comment: "Governance approval status (draft, pending, approved, deprecated) for KPI lifecycle management."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "How often the KPI is reported (daily, weekly, monthly, quarterly) for operational planning."
    - name: "data_type"
      expr: data_type
      comment: "Data type of the KPI value (monetary, percentage, count, ratio) for display and aggregation guidance."
    - name: "time_grain"
      expr: time_grain
      comment: "Finest time grain at which the KPI is meaningful (day, week, month) for drill-down capability."
    - name: "trend_direction"
      expr: trend_direction
      comment: "Expected direction of improvement (higher_is_better, lower_is_better) for performance coloring."
    - name: "is_lagging_indicator"
      expr: is_lagging_indicator
      comment: "Flag indicating the KPI is a lagging indicator, used to balance leading vs lagging metric portfolios."
    - name: "is_leading_indicator"
      expr: is_leading_indicator
      comment: "Flag indicating the KPI is a leading indicator, used to identify predictive metrics for early warning systems."
    - name: "is_published_externally"
      expr: is_published_externally
      comment: "Flag indicating the KPI is published externally (investor relations, regulatory), requiring stricter governance."
  measures:
    - name: "total_kpi_definitions"
      expr: COUNT(1)
      comment: "Total number of KPI definitions in the enterprise catalog, measuring semantic layer completeness."
    - name: "approved_kpi_count"
      expr: SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END)
      comment: "Count of approved KPI definitions, the primary metric for semantic layer governance maturity."
    - name: "externally_published_kpi_count"
      expr: SUM(CASE WHEN is_published_externally = TRUE THEN 1 ELSE 0 END)
      comment: "Count of KPIs published externally, used to manage regulatory and investor-facing metric governance."
    - name: "leading_indicator_count"
      expr: SUM(CASE WHEN is_leading_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of leading indicator KPIs, used to assess the predictive capability of the metric portfolio."
    - name: "avg_benchmark_value"
      expr: AVG(CAST(benchmark_value AS DOUBLE))
      comment: "Average benchmark value across KPI definitions, used to calibrate target-setting against industry standards."
    - name: "avg_target_threshold_value"
      expr: AVG(CAST(target_threshold_value AS DOUBLE))
      comment: "Average target threshold value across KPIs, providing a portfolio-level view of performance expectations."
    - name: "avg_minimum_acceptable_value"
      expr: AVG(CAST(minimum_acceptable_value AS DOUBLE))
      comment: "Average minimum acceptable value across KPIs, used to assess the floor of acceptable performance."
    - name: "unique_business_functions_covered"
      expr: COUNT(DISTINCT owning_business_function)
      comment: "Number of distinct business functions with defined KPIs, measuring enterprise-wide metric coverage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_semantic_layer_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Semantic layer entity governance — tracks certification status, usage, data quality, and coverage of semantic entities. Used by analytics engineering and data governance to manage the semantic layer health."
  source: "`vibe_retail_v1`.`analytics`.`semantic_layer_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of semantic entity (dimension, fact, metric, aggregate) for portfolio composition analysis."
    - name: "domain"
      expr: domain
      comment: "Business domain the entity belongs to, enabling domain-level semantic layer coverage reporting."
    - name: "certified_status"
      expr: certified_status
      comment: "Certification status (certified, pending, deprecated, experimental) for consumer trust and governance."
    - name: "consumption_tier"
      expr: consumption_tier
      comment: "Consumption tier (gold, silver, bronze) indicating data product quality level for consumer guidance."
    - name: "platform_type"
      expr: platform_type
      comment: "Platform where the entity is deployed (databricks, dbt, looker) for architecture governance."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the entity is currently active and available for consumption."
    - name: "is_financial_flag"
      expr: is_financial_flag
      comment: "Flag indicating the entity contains financial data, triggering stricter access and audit controls."
    - name: "is_pii_flag"
      expr: is_pii_flag
      comment: "Flag indicating the entity contains PII, used for privacy governance and access control."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How often the entity is refreshed (real-time, hourly, daily) for freshness SLA management."
  measures:
    - name: "total_entities"
      expr: COUNT(1)
      comment: "Total number of semantic layer entities, measuring the breadth of the governed semantic layer."
    - name: "certified_entity_count"
      expr: SUM(CASE WHEN certified_status = 'certified' THEN 1 ELSE 0 END)
      comment: "Count of certified semantic entities, the primary metric for semantic layer maturity and consumer trust."
    - name: "active_entity_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active entities available for consumption, used for capacity and coverage planning."
    - name: "pii_entity_count"
      expr: SUM(CASE WHEN is_pii_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entities containing PII, used for privacy governance and access control audits."
    - name: "financial_entity_count"
      expr: SUM(CASE WHEN is_financial_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entities containing financial data, used for SOX and financial governance scope management."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across semantic entities, the headline metric for semantic layer trustworthiness."
    - name: "unique_domains_covered"
      expr: COUNT(DISTINCT domain)
      comment: "Number of distinct business domains with semantic entities, measuring enterprise semantic coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_report_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Report governance and catalog — tracks report certification, usage, compliance scope, and lifecycle status. Used by analytics leadership to govern the enterprise reporting portfolio."
  source: "`vibe_retail_v1`.`analytics`.`report_definition`"
  dimensions:
    - name: "report_category"
      expr: report_category
      comment: "Business category of the report (operational, financial, compliance, executive) for portfolio organization."
    - name: "report_type"
      expr: report_type
      comment: "Technical type of report (dashboard, scheduled, ad-hoc, regulatory) for delivery planning."
    - name: "report_status"
      expr: report_status
      comment: "Lifecycle status (active, deprecated, draft, retired) for portfolio hygiene management."
    - name: "approval_status"
      expr: approval_status
      comment: "Governance approval status for report certification and publication control."
    - name: "is_certified"
      expr: is_certified
      comment: "Flag indicating the report has passed certification review, used for consumer trust and governance."
    - name: "contains_financial_data"
      expr: contains_financial_data
      comment: "Flag indicating the report contains financial data, triggering SOX and audit controls."
    - name: "contains_pii"
      expr: contains_pii
      comment: "Flag indicating the report contains PII, used for privacy governance and access control."
    - name: "governance_classification"
      expr: governance_classification
      comment: "Data governance classification (public, internal, confidential, restricted) for access management."
    - name: "refresh_cadence"
      expr: refresh_cadence
      comment: "How often the report data is refreshed (real-time, daily, weekly) for freshness SLA management."
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of report definitions in the enterprise catalog, measuring reporting portfolio size."
    - name: "certified_report_count"
      expr: SUM(CASE WHEN is_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certified reports, the primary metric for reporting governance maturity."
    - name: "financial_report_count"
      expr: SUM(CASE WHEN contains_financial_data = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports containing financial data, used to scope SOX and financial audit controls."
    - name: "pii_report_count"
      expr: SUM(CASE WHEN contains_pii = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reports containing PII, used for privacy governance and GDPR/CCPA compliance scoping."
    - name: "active_report_count"
      expr: SUM(CASE WHEN report_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active reports, used to assess the live reporting portfolio size."
    - name: "avg_execution_time_seconds"
      expr: AVG(CAST(average_execution_time_seconds AS DOUBLE))
      comment: "Average report execution time in seconds, used to identify performance bottlenecks and SLA risks."
    - name: "unique_owning_teams"
      expr: COUNT(DISTINCT owning_team)
      comment: "Number of distinct teams owning reports, used to assess reporting accountability distribution."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_self_service_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Self-service analytics usage — tracks query volume, performance, cost, and data access patterns. Used by analytics platform teams to optimize infrastructure and govern self-service data access."
  source: "`vibe_retail_v1`.`analytics`.`self_service_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of query (exploration, report, export, scheduled) for usage pattern analysis."
    - name: "query_status"
      expr: query_status
      comment: "Execution status (success, failed, timeout, cancelled) for reliability monitoring."
    - name: "bi_tool"
      expr: bi_tool
      comment: "BI tool used to execute the query (databricks_sql, tableau, power_bi) for platform adoption tracking."
    - name: "user_department"
      expr: user_department
      comment: "Department of the query author, used to understand self-service adoption by business unit."
    - name: "user_role"
      expr: user_role
      comment: "Role of the query author, used to assess self-service capability by persona."
    - name: "target_domain"
      expr: target_domain
      comment: "Business domain being queried, used to identify high-demand data domains."
    - name: "target_data_product"
      expr: target_data_product
      comment: "Specific data product being queried, for product-level usage and demand analysis."
    - name: "data_classification"
      expr: data_classification
      comment: "Data classification of the query target (public, internal, confidential) for access governance."
    - name: "cache_hit"
      expr: cache_hit
      comment: "Flag indicating the query was served from cache, used to measure caching effectiveness and cost savings."
    - name: "contains_pii"
      expr: contains_pii
      comment: "Flag indicating the query accessed PII data, used for privacy audit and access control monitoring."
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total number of self-service queries executed, the headline metric for platform adoption and usage."
    - name: "successful_query_count"
      expr: SUM(CASE WHEN query_status = 'success' THEN 1 ELSE 0 END)
      comment: "Count of successfully executed queries, used to measure platform reliability and user productivity."
    - name: "failed_query_count"
      expr: SUM(CASE WHEN query_status = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed queries, used to identify reliability issues and user experience problems."
    - name: "total_compute_cost_usd"
      expr: SUM(CAST(compute_cost_usd AS DOUBLE))
      comment: "Total compute cost of all self-service queries in USD, the primary metric for platform cost management."
    - name: "avg_compute_cost_usd"
      expr: AVG(CAST(compute_cost_usd AS DOUBLE))
      comment: "Average compute cost per query, used to identify expensive query patterns and optimization opportunities."
    - name: "avg_query_duration_seconds"
      expr: AVG(CAST(query_duration_seconds AS DOUBLE))
      comment: "Average query execution time in seconds, used to monitor platform performance and SLA compliance."
    - name: "total_data_scanned_bytes"
      expr: SUM(CAST(data_scanned_bytes AS DOUBLE))
      comment: "Total data scanned across all queries in bytes, used to monitor storage access costs and query efficiency."
    - name: "total_rows_returned"
      expr: SUM(CAST(rows_returned AS DOUBLE))
      comment: "Total rows returned across all queries, used to assess data consumption volume and export risk."
    - name: "cache_hit_count"
      expr: SUM(CASE WHEN cache_hit = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cache-served queries, used to measure caching effectiveness and compute cost avoidance."
    - name: "pii_query_count"
      expr: SUM(CASE WHEN contains_pii = TRUE THEN 1 ELSE 0 END)
      comment: "Count of queries accessing PII data, used for privacy governance and access audit reporting."
    - name: "avg_query_complexity_score"
      expr: AVG(CAST(query_complexity_score AS DOUBLE))
      comment: "Average query complexity score, used to identify complex query patterns that may need optimization or governance."
    - name: "unique_active_users"
      expr: COUNT(DISTINCT associate_id)
      comment: "Number of distinct users executing self-service queries, measuring platform adoption breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_sla_kpi_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA-KPI linkage performance — tracks measurement weights, breach penalties, and compliance status for SLA-bound KPIs. Used by operations and vendor management to govern SLA performance."
  source: "`vibe_retail_v1`.`analytics`.`sla_kpi_measurement`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Current status of the SLA KPI measurement (active, breached, compliant, suspended) for SLA health monitoring."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How often the SLA KPI is measured (daily, weekly, monthly) for operational cadence planning."
    - name: "is_primary_kpi"
      expr: is_primary_kpi
      comment: "Flag indicating this is the primary KPI for the SLA, used to focus executive attention on headline metrics."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the SLA measurement period for time-series analysis."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "End date of the SLA measurement period for contract period analysis."
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(1)
      comment: "Total number of SLA-KPI measurement configurations, used to assess SLA monitoring coverage."
    - name: "primary_kpi_count"
      expr: SUM(CASE WHEN is_primary_kpi = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary KPI measurements, used to identify the most critical SLA performance indicators."
    - name: "total_breach_penalty_rate"
      expr: SUM(CAST(breach_penalty_rate AS DOUBLE))
      comment: "Total breach penalty rate across all SLA measurements, quantifying the financial exposure from SLA non-compliance."
    - name: "avg_breach_penalty_rate"
      expr: AVG(CAST(breach_penalty_rate AS DOUBLE))
      comment: "Average breach penalty rate per SLA measurement, used to prioritize high-risk SLA compliance efforts."
    - name: "total_threshold_value"
      expr: SUM(CAST(threshold_value AS DOUBLE))
      comment: "Sum of threshold values across SLA KPI measurements, used to understand the aggregate performance bar."
    - name: "avg_measurement_weight"
      expr: AVG(CAST(measurement_weight AS DOUBLE))
      comment: "Average weight assigned to SLA KPI measurements, used to understand the relative importance distribution."
    - name: "avg_alert_threshold_value"
      expr: AVG(CAST(alert_threshold_value AS DOUBLE))
      comment: "Average alert threshold value, used to assess how early warnings are configured relative to SLA breach points."
    - name: "unique_sla_definitions_monitored"
      expr: COUNT(DISTINCT sla_definition_id)
      comment: "Number of distinct SLA definitions being monitored, measuring SLA governance coverage breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_dashboard_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dashboard portfolio governance — tracks dashboard certification, usage, publication status, and access controls. Used by analytics platform teams to manage the enterprise dashboard catalog."
  source: "`vibe_retail_v1`.`analytics`.`dashboard_config`"
  dimensions:
    - name: "dashboard_type"
      expr: dashboard_type
      comment: "Type of dashboard (executive, operational, analytical, self-service) for portfolio segmentation."
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status (draft, published, archived, deprecated) for lifecycle management."
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status (certified, pending, uncertified) for consumer trust and governance."
    - name: "bi_platform"
      expr: bi_platform
      comment: "BI platform hosting the dashboard (databricks, tableau, power_bi) for platform adoption tracking."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit that owns the dashboard, for accountability and portfolio management."
    - name: "target_persona"
      expr: target_persona
      comment: "Intended audience persona (executive, analyst, operator) for user experience governance."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the dashboard is currently active and available to users."
    - name: "mobile_enabled"
      expr: mobile_enabled
      comment: "Flag indicating the dashboard is optimized for mobile access, for platform capability tracking."
    - name: "export_enabled"
      expr: export_enabled
      comment: "Flag indicating data export is enabled, used for data governance and DLP monitoring."
  measures:
    - name: "total_dashboards"
      expr: COUNT(1)
      comment: "Total number of dashboard configurations in the enterprise catalog."
    - name: "published_dashboard_count"
      expr: SUM(CASE WHEN publication_status = 'published' THEN 1 ELSE 0 END)
      comment: "Count of published dashboards available to end users, measuring active reporting portfolio size."
    - name: "certified_dashboard_count"
      expr: SUM(CASE WHEN certification_status = 'certified' THEN 1 ELSE 0 END)
      comment: "Count of certified dashboards, the primary metric for reporting governance maturity."
    - name: "total_usage_count"
      expr: SUM(CAST(usage_count AS DOUBLE))
      comment: "Total usage count across all dashboards, measuring overall analytics platform engagement."
    - name: "avg_usage_count"
      expr: AVG(CAST(usage_count AS DOUBLE))
      comment: "Average usage count per dashboard, used to identify high-value vs underutilized dashboards for portfolio rationalization."
    - name: "mobile_enabled_count"
      expr: SUM(CASE WHEN mobile_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mobile-enabled dashboards, used to track mobile analytics capability coverage."
    - name: "export_enabled_count"
      expr: SUM(CASE WHEN export_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of dashboards with export enabled, used for data governance and DLP risk assessment."
    - name: "unique_business_units_covered"
      expr: COUNT(DISTINCT owning_business_unit)
      comment: "Number of distinct business units with owned dashboards, measuring analytics adoption breadth."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_workspace`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analytics workspace utilization — tracks storage consumption, member counts, and workspace health across the analytics platform. Used by platform engineering and finance to manage capacity and cost."
  source: "`vibe_retail_v1`.`analytics`.`workspace`"
  dimensions:
    - name: "workspace_type"
      expr: workspace_type
      comment: "Type of workspace (project, team, personal, shared) for capacity planning and governance."
    - name: "environment_type"
      expr: environment_type
      comment: "Environment classification (production, development, sandbox) for cost allocation and governance."
    - name: "workspace_status"
      expr: workspace_status
      comment: "Current status (active, archived, suspended, expired) for lifecycle management."
    - name: "visibility_scope"
      expr: visibility_scope
      comment: "Visibility scope (public, private, team) for access governance."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the workspace is currently active, used to filter active capacity."
    - name: "is_template"
      expr: is_template
      comment: "Flag indicating the workspace is a template, used to distinguish template vs operational workspaces."
    - name: "data_residency_country"
      expr: data_residency_country
      comment: "Country where workspace data resides, used for data sovereignty and regulatory compliance."
    - name: "region_code"
      expr: region_code
      comment: "Cloud region of the workspace, used for infrastructure cost allocation and latency optimization."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the workspace (critical, high, standard) for resource allocation decisions."
  measures:
    - name: "total_workspaces"
      expr: COUNT(1)
      comment: "Total number of analytics workspaces, used to assess platform scale and governance scope."
    - name: "active_workspace_count"
      expr: SUM(CASE WHEN is_active = TRUE THEN 1 ELSE 0 END)
      comment: "Count of currently active workspaces, used for capacity planning and license management."
    - name: "total_storage_quota_gb"
      expr: SUM(CAST(storage_quota_gb AS DOUBLE))
      comment: "Total storage quota allocated across all workspaces in GB, used for capacity planning and cost forecasting."
    - name: "total_storage_used_gb"
      expr: SUM(CAST(storage_used_gb AS DOUBLE))
      comment: "Total storage actually consumed across all workspaces in GB, the primary metric for storage cost management."
    - name: "avg_storage_used_gb"
      expr: AVG(CAST(storage_used_gb AS DOUBLE))
      comment: "Average storage used per workspace in GB, used to identify storage-heavy workspaces for optimization."
    - name: "avg_storage_utilization_rate"
      expr: AVG(ROUND(100.0 * storage_used_gb / NULLIF(storage_quota_gb, 0), 2))
      comment: "Average storage utilization rate (used/quota) per workspace, used to identify over-provisioned or at-risk workspaces."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`analytics_retail_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail calendar coverage and composition — tracks the distribution of retail calendar periods, holiday flags, and fiscal alignment. Used by analytics and finance teams to validate calendar completeness and support time-series analysis."
  source: "`vibe_retail_v1`.`analytics`.`retail_calendar`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year label for annual period analysis and year-over-year comparisons."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly business review alignment."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month equivalent) for monthly reporting cycles."
    - name: "season"
      expr: season
      comment: "Retail season (spring, summer, fall, holiday) for seasonal performance analysis."
    - name: "is_holiday"
      expr: is_holiday
      comment: "Flag indicating a public holiday, used to adjust performance expectations and staffing models."
    - name: "is_holiday_shopping_period"
      expr: is_holiday_shopping_period
      comment: "Flag indicating the date falls in the holiday shopping season, critical for retail performance benchmarking."
    - name: "is_black_friday_week"
      expr: is_black_friday_week
      comment: "Flag indicating Black Friday week, the highest-volume retail period requiring special performance tracking."
    - name: "is_back_to_school_period"
      expr: is_back_to_school_period
      comment: "Flag indicating the back-to-school shopping period, a key seasonal event for relevant retail categories."
    - name: "is_weekday"
      expr: is_weekday
      comment: "Flag distinguishing weekdays from weekends for traffic and sales pattern analysis."
    - name: "is_53_week_year"
      expr: is_53_week_year
      comment: "Flag indicating a 53-week fiscal year, critical for accurate year-over-year comparisons in retail."
  measures:
    - name: "total_calendar_days"
      expr: COUNT(1)
      comment: "Total number of calendar days in the selected period, used to validate calendar completeness and compute day-normalized metrics."
    - name: "holiday_day_count"
      expr: SUM(CASE WHEN is_holiday = TRUE THEN 1 ELSE 0 END)
      comment: "Count of public holidays in the period, used to adjust performance expectations and staffing plans."
    - name: "holiday_shopping_period_day_count"
      expr: SUM(CASE WHEN is_holiday_shopping_period = TRUE THEN 1 ELSE 0 END)
      comment: "Count of days in the holiday shopping period, used to normalize seasonal performance comparisons."
    - name: "black_friday_week_day_count"
      expr: SUM(CASE WHEN is_black_friday_week = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Black Friday week days, used to scope the highest-volume retail period for planning."
    - name: "weekday_count"
      expr: SUM(CASE WHEN is_weekday = TRUE THEN 1 ELSE 0 END)
      comment: "Count of weekdays in the period, used for traffic normalization and staffing models."
    - name: "weekend_day_count"
      expr: SUM(CASE WHEN is_weekend = TRUE THEN 1 ELSE 0 END)
      comment: "Count of weekend days in the period, used for weekend-vs-weekday performance analysis."
$$;