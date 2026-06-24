-- Metric views for domain: quality | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality inspection performance metrics tracking lot acceptance rates, defect rates, and inspection cycle times for manufacturing and procurement quality control"
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection lot (e.g., pending, in-progress, completed, released)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., incoming, in-process, final, supplier audit)"
    - name: "overall_result"
      expr: overall_result
      comment: "Overall quality result of the inspection (e.g., accepted, rejected, conditional)"
    - name: "usage_decision_code"
      expr: usage_decision_code
      comment: "Disposition decision code for the inspected lot (e.g., unrestricted use, rework, scrap)"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_start_date)
      comment: "Month when the inspection was initiated, for trend analysis"
    - name: "inspection_year"
      expr: YEAR(inspection_start_date)
      comment: "Year when the inspection was initiated"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed"
    - name: "total_lot_size_quantity"
      expr: SUM(CAST(lot_size_quantity AS DOUBLE))
      comment: "Total quantity of material inspected across all lots"
    - name: "total_sample_quantity"
      expr: SUM(CAST(sample_quantity AS DOUBLE))
      comment: "Total sample quantity drawn for inspection"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects identified across all inspection lots"
    - name: "avg_defect_count_per_lot"
      expr: AVG(CAST(defect_count AS DOUBLE))
      comment: "Average number of defects per inspection lot"
    - name: "defect_rate_ppm"
      expr: ROUND(1000000.0 * SUM(CAST(defect_count AS DOUBLE)) / NULLIF(SUM(CAST(lot_size_quantity AS DOUBLE)), 0), 2)
      comment: "Defect rate in parts per million (PPM) - key quality KPI for manufacturing excellence"
    - name: "avg_inspection_cycle_time_days"
      expr: AVG(DATEDIFF(inspection_completion_date, inspection_start_date))
      comment: "Average number of days from inspection start to completion - measures inspection efficiency"
    - name: "distinct_skus_inspected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs that underwent inspection"
    - name: "distinct_suppliers_inspected"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers whose materials were inspected"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance tracking metrics measuring quality issues, cost impact, and resolution performance for continuous improvement initiatives"
  source: "`vibe_consumer_goods_v1`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance (e.g., open, under investigation, closed)"
    - name: "nonconformance_type"
      expr: nonconformance_type
      comment: "Type of nonconformance (e.g., material defect, process deviation, documentation error)"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (e.g., critical, major, minor) - drives prioritization"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the nonconformance must be reported to regulatory authorities"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required for this nonconformance"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month when the nonconformance was detected"
    - name: "detection_year"
      expr: YEAR(detection_date)
      comment: "Year when the nonconformance was detected"
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of nonconformance events - key quality performance indicator"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of product affected by nonconformances"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances - critical for cost of poor quality (COPQ) analysis"
    - name: "avg_cost_per_nonconformance"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per nonconformance event"
    - name: "avg_closure_cycle_time_days"
      expr: AVG(DATEDIFF(actual_closure_date, detection_date))
      comment: "Average days from detection to closure - measures response effectiveness"
    - name: "distinct_skus_affected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs impacted by nonconformances"
    - name: "distinct_suppliers_with_issues"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers associated with nonconformances"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of nonconformances requiring regulatory reporting - compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics tracking issue resolution, cost, and on-time completion for quality management systems"
  source: "`vibe_consumer_goods_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., open, in progress, pending verification, closed)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of action (corrective vs. preventive)"
    - name: "priority"
      expr: priority
      comment: "Priority level (e.g., critical, high, medium, low) - drives resource allocation"
    - name: "effectiveness_verified_flag"
      expr: effectiveness_verified_flag
      comment: "Whether the CAPA effectiveness has been verified - quality system requirement"
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month when the CAPA was initiated"
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year when the CAPA was initiated"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPA records - indicates quality system activity level"
    - name: "total_capa_cost"
      expr: SUM(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Total estimated cost of all CAPAs - key for quality investment tracking"
    - name: "avg_capa_cost"
      expr: AVG(CAST(cost_estimate_amount AS DOUBLE))
      comment: "Average cost per CAPA"
    - name: "avg_completion_cycle_time_days"
      expr: AVG(DATEDIFF(actual_completion_date, initiation_date))
      comment: "Average days from initiation to completion - measures CAPA system efficiency"
    - name: "on_time_completion_count"
      expr: SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END)
      comment: "Count of CAPAs completed on or before target date"
    - name: "effectiveness_verified_count"
      expr: SUM(CASE WHEN effectiveness_verified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CAPAs with verified effectiveness - quality system compliance metric"
    - name: "distinct_nonconformances_addressed"
      expr: COUNT(DISTINCT nonconformance_id)
      comment: "Number of unique nonconformances linked to CAPAs"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_product_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics tracking complaint volume, severity, resolution time, and recall risk for customer satisfaction and regulatory compliance"
  source: "`vibe_consumer_goods_v1`.`quality`.`product_complaint`"
  dimensions:
    - name: "product_complaint_status"
      expr: product_complaint_status
      comment: "Current status of the complaint (e.g., open, under investigation, resolved, closed)"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint (e.g., product defect, packaging issue, labeling error, adverse event)"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Complaint category for classification and trending"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification (e.g., critical, major, minor) - drives response urgency"
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source of the complaint (e.g., consumer direct, retailer, distributor, social media)"
    - name: "adverse_event_flag"
      expr: adverse_event_flag
      comment: "Whether the complaint involves an adverse health event - regulatory trigger"
    - name: "recall_potential_flag"
      expr: recall_potential_flag
      comment: "Whether the complaint indicates potential recall risk - critical business indicator"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether the complaint must be reported to regulatory authorities"
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_date)
      comment: "Month when the complaint was received"
    - name: "complaint_year"
      expr: YEAR(complaint_date)
      comment: "Year when the complaint was received"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of product complaints - key customer satisfaction and quality indicator"
    - name: "avg_resolution_time_days"
      expr: AVG(DATEDIFF(resolution_date, complaint_date))
      comment: "Average days from complaint receipt to resolution - customer service KPI"
    - name: "adverse_event_count"
      expr: SUM(CASE WHEN adverse_event_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints involving adverse health events - critical safety metric"
    - name: "recall_potential_count"
      expr: SUM(CASE WHEN recall_potential_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints with recall potential - risk management indicator"
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of complaints requiring regulatory reporting - compliance metric"
    - name: "distinct_skus_complained"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs with complaints - product quality breadth indicator"
    - name: "distinct_shoppers_complaining"
      expr: COUNT(DISTINCT shopper_id)
      comment: "Number of unique consumers filing complaints"
    - name: "distinct_trade_accounts_complaining"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique trade accounts (retailers/distributors) filing complaints"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release performance metrics tracking release cycle time, conditional releases, and GMP compliance for manufacturing operations"
  source: "`vibe_consumer_goods_v1`.`quality`.`batch_release`"
  dimensions:
    - name: "release_status"
      expr: release_status
      comment: "Current status of the batch release (e.g., pending, released, rejected, on hold)"
    - name: "conditional_release_flag"
      expr: conditional_release_flag
      comment: "Whether the batch was released conditionally - indicates quality risk"
    - name: "gmp_compliant_flag"
      expr: gmp_compliant_flag
      comment: "Whether the batch meets Good Manufacturing Practice requirements"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when the batch was released"
    - name: "release_year"
      expr: YEAR(release_date)
      comment: "Year when the batch was released"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month when the batch was manufactured"
  measures:
    - name: "total_batch_releases"
      expr: COUNT(1)
      comment: "Total number of batch releases processed"
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity of product released to market - production throughput indicator"
    - name: "avg_released_quantity_per_batch"
      expr: AVG(CAST(released_quantity AS DOUBLE))
      comment: "Average quantity released per batch"
    - name: "conditional_release_count"
      expr: SUM(CASE WHEN conditional_release_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of conditional releases - quality risk indicator"
    - name: "gmp_compliant_count"
      expr: SUM(CASE WHEN gmp_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP-compliant batch releases - regulatory compliance metric"
    - name: "avg_shelf_life_days"
      expr: AVG(CAST(shelf_life_days AS DOUBLE))
      comment: "Average shelf life in days for released batches"
    - name: "distinct_skus_released"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs released"
    - name: "distinct_production_orders"
      expr: COUNT(DISTINCT production_order_id)
      comment: "Number of unique production orders released"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_supplier_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality performance metrics tracking assessment scores, certification status, and findings for supplier management and risk mitigation"
  source: "`vibe_consumer_goods_v1`.`quality`.`supplier_assessment`"
  dimensions:
    - name: "rating"
      expr: rating
      comment: "Overall supplier rating (e.g., excellent, good, acceptable, poor) - drives sourcing decisions"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g., on-site audit, remote review, certification review)"
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used for assessment (e.g., audit, questionnaire, third-party certification)"
    - name: "approved_supplier_flag"
      expr: approved_supplier_flag
      comment: "Whether the supplier is approved for use - critical procurement gate"
    - name: "gmp_certified_flag"
      expr: gmp_certified_flag
      comment: "Whether the supplier holds GMP certification"
    - name: "iso_9001_certified_flag"
      expr: iso_9001_certified_flag
      comment: "Whether the supplier holds ISO 9001 quality certification"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month when the assessment was conducted"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year when the assessment was conducted"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of supplier assessments conducted"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier quality score - key supplier performance indicator"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality dimension score"
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings across all assessments - risk indicator"
    - name: "total_findings"
      expr: SUM(CAST(findings_count AS DOUBLE))
      comment: "Total number of findings (all severities)"
    - name: "approved_supplier_count"
      expr: SUM(CASE WHEN approved_supplier_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments resulting in approved supplier status"
    - name: "gmp_certified_count"
      expr: SUM(CASE WHEN gmp_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of GMP-certified suppliers assessed"
    - name: "iso_9001_certified_count"
      expr: SUM(CASE WHEN iso_9001_certified_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ISO 9001-certified suppliers assessed"
    - name: "distinct_suppliers_assessed"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers assessed"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_gmp_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Good Manufacturing Practice audit metrics tracking audit findings, compliance ratings, and follow-up actions for regulatory compliance and operational excellence"
  source: "`vibe_consumer_goods_v1`.`quality`.`gmp_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in progress, completed, closed)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external, regulatory, certification)"
    - name: "audit_standard"
      expr: audit_standard
      comment: "Standard or regulation audited against (e.g., FDA 21 CFR Part 211, ISO 22716, EU GMP)"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall audit rating (e.g., compliant, minor deficiencies, major deficiencies, non-compliant)"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up actions are required - indicates compliance risk"
    - name: "certification_body"
      expr: certification_body
      comment: "Certification body conducting the audit (if external)"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority conducting or requiring the audit"
    - name: "audit_start_month"
      expr: DATE_TRUNC('MONTH', audit_start_date)
      comment: "Month when the audit started"
    - name: "audit_start_year"
      expr: YEAR(audit_start_date)
      comment: "Year when the audit started"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of GMP audits conducted"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical findings - highest priority compliance risk indicator"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total number of major findings"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total number of minor findings"
    - name: "total_observations"
      expr: SUM(CAST(observations_count AS DOUBLE))
      comment: "Total number of observations (opportunities for improvement)"
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average critical findings per audit - quality system health indicator"
    - name: "avg_audit_duration_days"
      expr: AVG(DATEDIFF(audit_end_date, audit_start_date))
      comment: "Average duration of audits in days"
    - name: "follow_up_required_count"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring follow-up actions"
    - name: "distinct_facilities_audited"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of unique manufacturing facilities audited"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection test result metrics tracking pass rates, specification compliance, and retest frequency for quality control effectiveness"
  source: "`vibe_consumer_goods_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the inspection result (e.g., final, preliminary, under review)"
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Whether the test result passed specification - key quality gate"
    - name: "retest_required_flag"
      expr: retest_required_flag
      comment: "Whether retest is required - indicates borderline or questionable results"
    - name: "characteristic_code"
      expr: characteristic_code
      comment: "Code identifying the characteristic tested"
    - name: "characteristic_name"
      expr: characteristic_name
      comment: "Name of the characteristic tested (e.g., pH, viscosity, color, purity)"
    - name: "test_method"
      expr: test_method
      comment: "Test method used (e.g., HPLC, titration, visual inspection)"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month when the test was performed"
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year when the test was performed"
  measures:
    - name: "total_test_results"
      expr: COUNT(1)
      comment: "Total number of inspection test results recorded"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of test results that passed specification"
    - name: "fail_count"
      expr: SUM(CASE WHEN pass_fail_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of test results that failed specification"
    - name: "retest_required_count"
      expr: SUM(CASE WHEN retest_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of results requiring retest - quality system efficiency indicator"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across all test results"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across all specifications"
    - name: "avg_deviation_percentage"
      expr: AVG(CAST(deviation_percentage AS DOUBLE))
      comment: "Average percentage deviation from target - process capability indicator"
    - name: "distinct_inspection_lots_tested"
      expr: COUNT(DISTINCT inspection_lot_id)
      comment: "Number of unique inspection lots with test results"
    - name: "distinct_characteristics_tested"
      expr: COUNT(DISTINCT characteristic_code)
      comment: "Number of unique characteristics tested"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_stability_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability study result metrics tracking product degradation, shelf life validation, and specification compliance over time for regulatory submissions"
  source: "`vibe_consumer_goods_v1`.`quality`.`stability_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the stability result (e.g., final, preliminary, under review)"
    - name: "pass_fail_flag"
      expr: pass_fail_flag
      comment: "Whether the stability result passed specification at this timepoint"
    - name: "out_of_specification_flag"
      expr: out_of_specification_flag
      comment: "Whether the result is out of specification - indicates shelf life limit"
    - name: "characteristic_code"
      expr: characteristic_code
      comment: "Code identifying the characteristic tested"
    - name: "characteristic_name"
      expr: characteristic_name
      comment: "Name of the characteristic tested (e.g., assay, impurities, appearance)"
    - name: "test_method"
      expr: test_method
      comment: "Test method used for stability testing"
    - name: "timepoint_number"
      expr: timepoint_number
      comment: "Stability timepoint number (e.g., T0, T3, T6, T12, T24 months)"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month when the stability test was performed"
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year when the stability test was performed"
  measures:
    - name: "total_stability_results"
      expr: COUNT(1)
      comment: "Total number of stability test results recorded"
    - name: "pass_count"
      expr: SUM(CASE WHEN pass_fail_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of stability results that passed specification"
    - name: "out_of_spec_count"
      expr: SUM(CASE WHEN out_of_specification_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of out-of-specification results - shelf life risk indicator"
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across stability timepoints"
    - name: "avg_initial_value"
      expr: AVG(CAST(initial_value AS DOUBLE))
      comment: "Average initial value (T0) for comparison"
    - name: "avg_change_from_initial_percent"
      expr: AVG(CAST(change_from_initial_percent AS DOUBLE))
      comment: "Average percentage change from initial value - degradation rate indicator"
    - name: "avg_elapsed_time_days"
      expr: AVG(CAST(elapsed_time_days AS DOUBLE))
      comment: "Average elapsed time in days for stability testing"
    - name: "distinct_stability_studies"
      expr: COUNT(DISTINCT quality_stability_study_id)
      comment: "Number of unique stability studies with results"
    - name: "distinct_characteristics_tested"
      expr: COUNT(DISTINCT characteristic_code)
      comment: "Number of unique characteristics tested in stability studies"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`quality_change_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change control metrics tracking change volume, approval cycle time, regulatory impact, and validation requirements for quality system governance"
  source: "`vibe_consumer_goods_v1`.`quality`.`change_control`"
  dimensions:
    - name: "change_control_status"
      expr: change_control_status
      comment: "Current status of the change control (e.g., draft, under review, approved, implemented, closed)"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (e.g., process, formulation, equipment, documentation)"
    - name: "change_category"
      expr: change_category
      comment: "Category of change for classification"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change (e.g., high, medium, low) - drives approval requirements"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Whether the change has regulatory impact - requires regulatory notification or approval"
    - name: "validation_required_flag"
      expr: validation_required_flag
      comment: "Whether validation is required for the change - impacts timeline and cost"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required"
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month when the change control was initiated"
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year when the change control was initiated"
  measures:
    - name: "total_change_controls"
      expr: COUNT(1)
      comment: "Total number of change control records - indicates change management activity"
    - name: "avg_approval_cycle_time_days"
      expr: AVG(DATEDIFF(approval_date, initiation_date))
      comment: "Average days from initiation to approval - change management efficiency KPI"
    - name: "avg_implementation_cycle_time_days"
      expr: AVG(DATEDIFF(actual_implementation_date, initiation_date))
      comment: "Average days from initiation to implementation - total change cycle time"
    - name: "regulatory_impact_count"
      expr: SUM(CASE WHEN regulatory_impact_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes with regulatory impact - compliance workload indicator"
    - name: "validation_required_count"
      expr: SUM(CASE WHEN validation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes requiring validation - resource planning metric"
    - name: "customer_notification_required_count"
      expr: SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes requiring customer notification"
    - name: "distinct_skus_affected"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs affected by change controls"
    - name: "distinct_facilities_affected"
      expr: COUNT(DISTINCT manufacturing_facility_id)
      comment: "Number of unique manufacturing facilities affected by changes"
$$;