-- Metric views for domain: quality | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for inspection lots covering throughput, yield, defect rates, and lot sizing — core quality control steering metrics for manufacturing and procurement."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final, etc.) enabling segmentation of quality performance by inspection stage."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection lot (open, in-progress, completed, rejected) for pipeline and backlog analysis."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail/conditional result of the inspection lot, used to segment yield and rejection analysis."
    - name: "usage_decision_code"
      expr: usage_decision_code
      comment: "Disposition code applied to the lot (accept, reject, rework, concession) for downstream quality decision tracking."
    - name: "inspection_start_month"
      expr: DATE_TRUNC('MONTH', inspection_start_date)
      comment: "Month the inspection started, enabling trend analysis of inspection volume and quality outcomes over time."
    - name: "inspection_completion_month"
      expr: DATE_TRUNC('MONTH', inspection_completion_date)
      comment: "Month the inspection was completed, used for throughput and cycle time trending."
    - name: "lot_size_uom"
      expr: lot_size_uom
      comment: "Unit of measure for lot size, required for correct aggregation context when comparing lot quantities."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots created. Baseline volume metric for quality workload and throughput tracking."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_size_quantity AS DOUBLE))
      comment: "Total quantity of material submitted for inspection across all lots. Indicates the volume of production or procurement subject to quality control."
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total quantity sampled across all inspection lots. Used to assess sampling coverage relative to total lot volume."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size_quantity AS DOUBLE))
      comment: "Average lot size submitted for inspection. Helps identify whether lot sizing practices align with quality plan requirements."
    - name: "avg_sample_quantity"
      expr: AVG(CAST(sample_quantity AS DOUBLE))
      comment: "Average sample quantity per inspection lot. Benchmarks sampling intensity against AQL and inspection plan targets."
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers whose materials were inspected. Indicates breadth of supplier quality monitoring coverage."
    - name: "distinct_skus_inspected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that went through inspection. Measures product quality coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular test-level quality KPIs measuring pass rates, deviation magnitudes, and retest rates — the primary operational quality signal for process control and specification compliance."
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "characteristic_code"
      expr: characteristic_code
      comment: "Quality characteristic code (e.g., pH, moisture, weight) enabling analysis of which characteristics drive failures."
    - name: "characteristic_name"
      expr: characteristic_name
      comment: "Human-readable name of the quality characteristic being tested, for business-facing reporting."
    - name: "result_status"
      expr: result_status
      comment: "Status of the individual test result (pass, fail, pending, cancelled) for filtering and segmentation."
    - name: "test_method"
      expr: test_method
      comment: "Analytical or physical test method used, enabling comparison of quality outcomes by methodology."
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Boolean indicator of whether the individual test passed or failed specification limits."
    - name: "retest_required_flag"
      expr: retest_required_flag
      comment: "Boolean flag indicating whether a retest was required, used to measure first-pass quality rate."
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was performed, enabling trend analysis of quality performance over time."
    - name: "measurement_uom"
      expr: measurement_uom
      comment: "Unit of measure for the measured value, required for correct interpretation of deviation and limit metrics."
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of individual test results recorded. Baseline measure of quality testing activity volume."
    - name: "total_passed_tests"
      expr: COUNT(CASE WHEN pass_fail_flag = TRUE THEN 1 END)
      comment: "Number of test results that passed specification limits. Numerator for first-pass yield rate calculation."
    - name: "total_failed_tests"
      expr: COUNT(CASE WHEN pass_fail_flag = FALSE THEN 1 END)
      comment: "Number of test results that failed specification limits. Key signal for process capability and out-of-spec events."
    - name: "total_retest_required"
      expr: COUNT(CASE WHEN retest_required_flag = TRUE THEN 1 END)
      comment: "Number of tests requiring a retest. Elevated retest rates indicate process instability or measurement system issues."
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average percentage deviation of measured values from target. Measures how far process outputs drift from specification center — a key process capability indicator."
    - name: "max_deviation_percentage"
      expr: MAX(CAST(deviation_percentage AS DOUBLE))
      comment: "Maximum deviation percentage observed across all test results. Identifies worst-case out-of-spec events for risk prioritization."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all test results for a characteristic. Used to monitor process centering relative to target."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target specification value. Used alongside avg_measured_value to assess systematic process bias."
    - name: "distinct_inspection_lots_tested"
      expr: COUNT(DISTINCT inspection_lot_id)
      comment: "Number of distinct inspection lots with at least one test result. Measures quality testing coverage across active lots."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for nonconformance events covering financial impact, affected quantities, closure performance, and regulatory exposure — critical for quality cost management and risk governance."
  source: "`vibe_consumer_goods_v1`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_type"
      expr: nonconformance_type
      comment: "Type of nonconformance (material, process, product, supplier) enabling root cause category analysis."
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance (open, under investigation, closed) for backlog and aging analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (critical, major, minor) for risk-tiered quality management and escalation decisions."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating whether the nonconformance must be reported to a regulatory authority — critical for compliance risk tracking."
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Boolean flag indicating whether customers must be notified, used to assess customer-facing quality risk exposure."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the cost impact amount, required for correct financial aggregation and multi-currency reporting."
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month the nonconformance occurred, enabling trend analysis of quality event frequency and cost over time."
    - name: "affected_quantity_uom"
      expr: affected_quantity_uom
      comment: "Unit of measure for affected quantity, required for correct interpretation of volume impact metrics."
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of nonconformance events recorded. Baseline quality event volume metric for trend and benchmarking."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial cost of all nonconformance events. The primary quality cost KPI — directly informs cost-of-poor-quality (COPQ) reporting and investment decisions."
    - name: "avg_cost_impact_per_nonconformance"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost per nonconformance event. Enables severity-weighted cost benchmarking and prioritization of quality improvement investments."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of material or product affected by nonconformances. Measures the production volume at risk from quality failures."
    - name: "total_regulatory_reportable"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of nonconformances requiring regulatory reporting. A critical compliance KPI — elevated counts signal regulatory risk exposure."
    - name: "total_customer_notification_required"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of nonconformances requiring customer notification. Measures customer-facing quality risk and potential brand/relationship impact."
    - name: "total_open_nonconformances"
      expr: COUNT(CASE WHEN nonconformance_status = 'Open' THEN 1 END)
      comment: "Number of currently open nonconformances. Tracks the active quality backlog requiring investigation and corrective action."
    - name: "distinct_skus_affected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs impacted by nonconformances. Measures breadth of product portfolio quality risk."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) performance KPIs measuring closure rates, cost of quality remediation, effectiveness verification, and timeliness — essential for quality system maturity and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, improvement) enabling analysis of the balance between reactive and proactive quality actions."
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (open, in-progress, closed, overdue) for backlog management and escalation."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA (critical, high, medium, low) for risk-tiered resource allocation."
    - name: "effectiveness_verified_flag"
      expr: effectiveness_verified_flag
      comment: "Boolean flag indicating whether the CAPA effectiveness was verified — a key quality system maturity indicator required by GMP and ISO standards."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the CAPA cost estimate, required for correct financial aggregation."
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month the CAPA was initiated, enabling trend analysis of quality system responsiveness over time."
    - name: "closure_month"
      expr: DATE_TRUNC('MONTH', closure_date)
      comment: "Month the CAPA was closed, used for throughput and cycle time analysis of the CAPA process."
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records. Baseline measure of quality system corrective action activity volume."
    - name: "total_capa_cost_estimate"
      expr: SUM(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Total estimated cost of all CAPA activities. A key component of cost-of-poor-quality (COPQ) — informs quality investment and remediation budget decisions."
    - name: "avg_capa_cost_estimate"
      expr: AVG(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Average estimated cost per CAPA. Enables benchmarking of remediation cost by type, priority, and root cause category."
    - name: "total_effectiveness_verified"
      expr: COUNT(CASE WHEN effectiveness_verified_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with verified effectiveness. Measures quality system closure quality — a direct GMP and ISO audit metric."
    - name: "total_open_capas"
      expr: COUNT(CASE WHEN capa_status = 'Open' THEN 1 END)
      comment: "Number of currently open CAPAs. Tracks the active corrective action backlog — a key quality system health indicator."
    - name: "total_overdue_capas"
      expr: COUNT(CASE WHEN actual_completion_date > target_completion_date THEN 1 END)
      comment: "Number of CAPAs completed after their target date. Measures CAPA process timeliness — overdue CAPAs are a regulatory audit finding risk."
    - name: "distinct_skus_with_capa"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one CAPA. Measures breadth of product quality remediation activity across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_product_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consumer and customer complaint KPIs measuring complaint volume, severity, recall risk, regulatory exposure, and resolution performance — directly linked to brand equity, regulatory compliance, and customer satisfaction."
  source: "`vibe_consumer_goods_v1`.`quality`.`product_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint (foreign material, labeling, quality defect, etc.) for root cause category analysis and trend monitoring."
    - name: "complaint_category"
      expr: complaint_category
      comment: "Business category of the complaint enabling portfolio-level complaint pattern analysis."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel of the complaint (consumer, retailer, distributor, regulator) for channel-specific quality risk assessment."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint (critical, major, minor) for risk-tiered escalation and resource allocation."
    - name: "product_complaint_status"
      expr: product_complaint_status
      comment: "Current status of the complaint (open, under investigation, closed) for backlog and SLA management."
    - name: "recall_potential_flag"
      expr: recall_potential_flag
      comment: "Boolean flag indicating whether the complaint has recall potential — the highest-priority quality risk signal for executive action."
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating whether the complaint must be reported to a regulatory authority — critical compliance KPI."
    - name: "adverse_event_flag"
      expr: adverse_event_flag
      comment: "Boolean flag indicating whether the complaint involves an adverse health event — triggers mandatory regulatory reporting in most jurisdictions."
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_date)
      comment: "Month the complaint was received, enabling trend analysis of complaint rates over time."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of product complaints received. Baseline consumer quality signal — rising complaint rates trigger brand and regulatory risk escalation."
    - name: "total_recall_potential_complaints"
      expr: COUNT(CASE WHEN recall_potential_flag = TRUE THEN 1 END)
      comment: "Number of complaints flagged as having recall potential. The highest-severity quality KPI — any increase demands immediate executive and regulatory response."
    - name: "total_adverse_event_complaints"
      expr: COUNT(CASE WHEN adverse_event_flag = TRUE THEN 1 END)
      comment: "Number of complaints involving adverse health events. Mandatory regulatory reporting trigger — directly linked to consumer safety and regulatory risk."
    - name: "total_regulatory_reportable_complaints"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of complaints requiring regulatory reporting. Measures regulatory compliance exposure from the complaint portfolio."
    - name: "total_open_complaints"
      expr: COUNT(CASE WHEN product_complaint_status = 'Open' THEN 1 END)
      comment: "Number of currently open complaints. Tracks the active complaint backlog and SLA compliance risk."
    - name: "distinct_skus_with_complaints"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one complaint. Measures breadth of product quality risk across the portfolio — informs SKU rationalization and quality investment decisions."
    - name: "distinct_retail_stores_with_complaints"
      expr: COUNT(DISTINCT retail_store_id)
      comment: "Number of distinct retail stores generating complaints. Identifies geographic or channel-specific quality distribution or handling issues."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_usage_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lot disposition KPIs measuring accepted, rejected, and rework quantities from usage decisions — the final quality gate metric directly linked to yield, waste, and supply availability."
  source: "`vibe_consumer_goods_v1`.`quality`.`usage_decision`"
  dimensions:
    - name: "decision_code"
      expr: decision_code
      comment: "Disposition decision code (accept, reject, rework, concession) enabling analysis of lot disposition outcomes."
    - name: "disposition_reason_code"
      expr: disposition_reason_code
      comment: "Reason code for the disposition decision, enabling root cause analysis of rejections and rework."
    - name: "quality_hold_flag"
      expr: quality_hold_flag
      comment: "Boolean flag indicating whether the lot is on quality hold — a critical supply chain risk signal."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Boolean flag indicating whether the usage decision requires regulatory notification — compliance risk indicator."
    - name: "quantity_uom"
      expr: quantity_uom
      comment: "Unit of measure for accepted, rejected, and rework quantities — required for correct volume aggregation."
    - name: "decision_month"
      expr: DATE_TRUNC('MONTH', decision_date)
      comment: "Month the usage decision was made, enabling trend analysis of lot disposition outcomes over time."
  measures:
    - name: "total_usage_decisions"
      expr: COUNT(1)
      comment: "Total number of usage decisions made. Baseline measure of quality gate throughput."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted across all usage decisions. Primary yield volume metric — directly linked to supply availability and production efficiency."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected across all usage decisions. Measures material waste and quality failure volume — a key cost-of-poor-quality driver."
    - name: "total_rework_quantity"
      expr: SUM(CAST(rework_quantity AS DOUBLE))
      comment: "Total quantity sent for rework. Measures the volume of material requiring additional processing due to quality failures — a direct cost and throughput impact."
    - name: "avg_accepted_quantity"
      expr: AVG(CAST(accepted_quantity AS DOUBLE))
      comment: "Average accepted quantity per usage decision. Benchmarks lot acceptance performance and identifies trends in lot sizing vs. yield."
    - name: "total_quality_holds"
      expr: COUNT(CASE WHEN quality_hold_flag = TRUE THEN 1 END)
      comment: "Number of lots currently on quality hold. A critical supply chain risk KPI — elevated holds signal potential supply shortages and regulatory exposure."
    - name: "total_regulatory_notifications_required"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of usage decisions requiring regulatory notification. Measures compliance obligation volume from lot disposition activities."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release KPIs measuring released quantities, conditional release rates, GMP compliance, and release timeliness — the final manufacturing quality gate with direct impact on supply chain availability and regulatory compliance."
  source: "`vibe_consumer_goods_v1`.`quality`.`batch_release`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Current status of the batch release (released, pending, rejected, conditional) for pipeline and compliance tracking."
    - name: "conditional_release_flag"
      expr: conditional_release_flag
      comment: "Boolean flag indicating whether the batch was released under conditional terms — a quality risk and regulatory compliance indicator."
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Boolean flag indicating GMP compliance of the released batch — a mandatory regulatory requirement in consumer goods manufacturing."
    - name: "quantity_uom"
      expr: quantity_uom
      comment: "Unit of measure for released quantity, required for correct volume aggregation."
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the batch was released, enabling trend analysis of release throughput and compliance over time."
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month the batch was manufactured, used for cohort analysis of release cycle times and quality outcomes by production period."
  measures:
    - name: "total_batch_releases"
      expr: COUNT(1)
      comment: "Total number of batch release records. Baseline measure of manufacturing output throughput through the quality release gate."
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity released to market or downstream supply chain. Primary supply availability KPI — directly linked to revenue and customer service levels."
    - name: "avg_released_quantity"
      expr: AVG(CAST(released_quantity AS DOUBLE))
      comment: "Average released quantity per batch. Benchmarks batch yield performance and identifies trends in production efficiency."
    - name: "total_conditional_releases"
      expr: COUNT(CASE WHEN conditional_release_flag = TRUE THEN 1 END)
      comment: "Number of batches released under conditional terms. Elevated conditional release rates signal quality system stress and regulatory risk."
    - name: "total_gmp_compliant_releases"
      expr: COUNT(CASE WHEN gmp_compliant_flag = TRUE THEN 1 END)
      comment: "Number of batches confirmed GMP compliant at release. Measures regulatory compliance rate of the manufacturing and release process."
    - name: "total_gmp_non_compliant_releases"
      expr: COUNT(CASE WHEN gmp_compliant_flag = FALSE THEN 1 END)
      comment: "Number of batches released without GMP compliance confirmation. A critical regulatory risk KPI — any non-zero value requires immediate investigation."
    - name: "distinct_skus_released"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one batch released. Measures breadth of product portfolio throughput through the quality release gate."
$$;