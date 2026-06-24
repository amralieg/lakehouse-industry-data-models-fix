-- Metric views for domain: quality | Business: Semiconductors | Version: 2 | Generated on: 2026-06-24 02:09:37

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core yield performance metrics tracking die-level and wafer-level yield rates, defect density, and yield gap analysis across fabrication and test stages"
  source: "`vibe_semiconductors_v1`.`quality`.`yield_record`"
  dimensions:
    - name: "yield_type"
      expr: yield_type
      comment: "Type of yield measurement (wafer probe, final test, parametric, etc.)"
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Stage in manufacturing where yield was measured"
    - name: "process_node"
      expr: process_node
      comment: "Technology process node for the yield measurement"
    - name: "fab_line"
      expr: fab_line
      comment: "Fabrication line where the lot was processed"
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint identifier"
    - name: "defect_type"
      expr: defect_type
      comment: "Primary defect type contributing to yield loss"
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the lot"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall inspection result (pass/fail/conditional)"
    - name: "shift"
      expr: shift
      comment: "Manufacturing shift when yield was recorded"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of yield measurement event"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of yield measurement event"
  measures:
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total number of die measured across all yield records"
    - name: "good_die_count"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total number of good die passing quality criteria"
    - name: "defect_count_total"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects detected"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across records"
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter"
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield"
    - name: "avg_fallout_rate"
      expr: AVG(CAST(fallout_rate AS DOUBLE))
      comment: "Average fallout rate (percentage of units failing quality checks)"
    - name: "yield_record_count"
      expr: COUNT(1)
      comment: "Number of yield measurement records"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_dppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defective parts per million (DPPM) tracking for customer quality and field failure analysis, critical for automotive and high-reliability applications"
  source: "`vibe_semiconductors_v1`.`quality`.`dppm_record`"
  dimensions:
    - name: "notification_type"
      expr: notification_type
      comment: "Type of DPPM notification (customer complaint, field failure, RMA, etc.)"
    - name: "closure_status"
      expr: closure_status
      comment: "Status of DPPM case closure"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle status at time of defect"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category for the defect"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether the affected product was Known Good Die certified"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance flag"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of DPPM event"
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Start month of measurement period"
  measures:
    - name: "total_units_shipped"
      expr: SUM(CAST(total_units_shipped AS DOUBLE))
      comment: "Total units shipped in the measurement period"
    - name: "defective_units_total"
      expr: SUM(CAST(defective_units AS DOUBLE))
      comment: "Total defective units reported"
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defective parts per million rate"
    - name: "avg_defect_rate"
      expr: AVG(CAST(defect_rate AS DOUBLE))
      comment: "Average defect rate percentage"
    - name: "avg_reject_rate"
      expr: AVG(CAST(reject_rate AS DOUBLE))
      comment: "Average reject rate percentage"
    - name: "dppm_record_count"
      expr: COUNT(1)
      comment: "Number of DPPM records"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with DPPM events"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed defect tracking metrics for wafer-level and die-level defects, supporting root cause analysis and process improvement"
  source: "`vibe_semiconductors_v1`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification category of the defect"
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of the defect (critical, major, minor)"
    - name: "defect_layer"
      expr: defect_layer
      comment: "Semiconductor layer where defect was detected"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect (optical, e-beam, electrical test, etc.)"
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause category for the defect"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defective unit"
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect record"
    - name: "bin_assignment"
      expr: bin_assignment
      comment: "Test bin assignment for the defective die"
    - name: "edge_exclusion_zone_flag"
      expr: edge_exclusion_zone_flag
      comment: "Whether defect is in wafer edge exclusion zone"
    - name: "repeatability_flag"
      expr: repeatability_flag
      comment: "Whether defect is repeatable across multiple measurements"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of defect detection"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of defect detection"
  measures:
    - name: "defect_count"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "avg_defect_size_nm"
      expr: AVG(CAST(defect_size_nm AS DOUBLE))
      comment: "Average defect size in nanometers"
    - name: "avg_defect_area_um2"
      expr: AVG(CAST(defect_area_um2 AS DOUBLE))
      comment: "Average defect area in square micrometers"
    - name: "avg_defect_density_per_zone"
      expr: AVG(CAST(defect_density_per_zone AS DOUBLE))
      comment: "Average defect density per wafer zone"
    - name: "distinct_wafers"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers with defects"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers associated with defects"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_reliability_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability qualification and stress test metrics including FIT rate, MTBF, and Weibull analysis for product qualification and customer confidence"
  source: "`vibe_semiconductors_v1`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, HAST, TC, ELFR, etc.)"
    - name: "test_standard"
      expr: test_standard
      comment: "Industry standard followed for the test (JEDEC, AEC-Q100, etc.)"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, process change, supplier change)"
    - name: "test_result"
      expr: test_result
      comment: "Overall test result (pass/fail/conditional)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of the reliability test"
    - name: "overall_status"
      expr: overall_status
      comment: "Overall qualification status"
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade assigned (automotive, industrial, commercial)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Observed failure mode"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism"
    - name: "device_type"
      expr: device_type
      comment: "Type of device under test"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether test is for KGD certification"
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "JEDEC compliance flag"
    - name: "compliance_iatf_16949"
      expr: compliance_iatf_16949
      comment: "IATF 16949 automotive compliance flag"
    - name: "test_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of reliability test"
  measures:
    - name: "reliability_test_count"
      expr: COUNT(1)
      comment: "Number of reliability test records"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage"
    - name: "avg_test_humidity_percent"
      expr: AVG(CAST(test_humidity_percent AS DOUBLE))
      comment: "Average test humidity percentage"
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average failures in time (FIT) rate per billion device-hours"
    - name: "avg_fit_rate_confidence"
      expr: AVG(CAST(fit_rate_confidence AS DOUBLE))
      comment: "Average confidence level for FIT rate calculation"
    - name: "avg_weibull_shape_parameter"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter (beta) for failure distribution"
    - name: "avg_weibull_scale_parameter"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter (eta) for failure distribution"
    - name: "distinct_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct IC design projects under reliability test"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance and material review board (MRB) metrics tracking quality escapes, corrective actions, and disposition decisions"
  source: "`vibe_semiconductors_v1`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Status of the nonconformance report"
    - name: "nonconformance_report_status"
      expr: nonconformance_report_status
      comment: "Detailed status of the NCR"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the nonconformance"
    - name: "priority"
      expr: priority
      comment: "Priority level for resolution"
    - name: "detection_point"
      expr: detection_point
      comment: "Point in process where nonconformance was detected"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision (use-as-is, rework, scrap, return)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Detailed disposition decision"
    - name: "mrb_decision"
      expr: mrb_decision
      comment: "Material Review Board decision"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "is_customer_impact"
      expr: is_customer_impact
      comment: "Whether nonconformance impacts customer"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold placed on material"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard referenced"
    - name: "report_month"
      expr: DATE_TRUNC('month', report_timestamp)
      comment: "Month of NCR creation"
  measures:
    - name: "ncr_count"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports"
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances"
    - name: "avg_impact_amount"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with nonconformances"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customers impacted by nonconformances"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics tracking quality improvement initiatives, closure rates, and cost impact"
  source: "`vibe_semiconductors_v1`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, or both)"
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA"
    - name: "capa_record_status"
      expr: capa_record_status
      comment: "Detailed record status"
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status for CAPA closure"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity level of the underlying issue"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment"
    - name: "impact"
      expr: impact
      comment: "Impact category of the issue"
    - name: "department"
      expr: department
      comment: "Department responsible for CAPA"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where issue was detected"
    - name: "detection_source"
      expr: detection_source
      comment: "Source of issue detection"
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Method used for root cause analysis (5-Why, Fishbone, etc.)"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of effectiveness verification"
    - name: "detection_month"
      expr: DATE_TRUNC('month', detection_date)
      comment: "Month of issue detection"
    - name: "closure_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month of CAPA closure"
  measures:
    - name: "capa_count"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA implementation"
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of CAPA"
    - name: "avg_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA"
    - name: "avg_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per CAPA"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers involved in CAPAs"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_wafer_map`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wafer-level spatial quality metrics tracking die yield, defect patterns, and bin distributions for process control and yield improvement"
  source: "`vibe_semiconductors_v1`.`quality`.`wafer_map`"
  dimensions:
    - name: "map_status"
      expr: map_status
      comment: "Status of the wafer map"
    - name: "defect_type"
      expr: defect_type
      comment: "Primary defect type observed on wafer"
    - name: "defect_zone"
      expr: defect_zone
      comment: "Wafer zone with defect concentration"
    - name: "pass_bin_code"
      expr: pass_bin_code
      comment: "Bin code for passing die"
    - name: "fail_bin_code"
      expr: fail_bin_code
      comment: "Bin code for failing die"
    - name: "flat_orientation"
      expr: flat_orientation
      comment: "Wafer flat orientation"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether wafer is KGD certified"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance flag"
    - name: "compliance_iatf16949"
      expr: compliance_iatf16949
      comment: "IATF 16949 automotive compliance flag"
    - name: "map_generation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of wafer map generation"
  measures:
    - name: "wafer_map_count"
      expr: COUNT(1)
      comment: "Number of wafer maps"
    - name: "avg_die_yield_percentage"
      expr: AVG(CAST(die_yield_percentage AS DOUBLE))
      comment: "Average die yield percentage across wafers"
    - name: "avg_defect_density_per_sqmm"
      expr: AVG(CAST(defect_density_per_sqmm AS DOUBLE))
      comment: "Average defect density per square millimeter"
    - name: "avg_edge_exclusion_zone_mm"
      expr: AVG(CAST(edge_exclusion_zone_mm AS DOUBLE))
      comment: "Average edge exclusion zone width in millimeters"
    - name: "distinct_wafers"
      expr: COUNT(DISTINCT wafer_id)
      comment: "Number of distinct wafers mapped"
    - name: "distinct_design_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct IC design projects"
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming and in-process inspection metrics tracking acceptance rates, defect density, and compliance for materials and work-in-process"
  source: "`vibe_semiconductors_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (incoming, in-process, final)"
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage in manufacturing where inspection occurred"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall inspection result"
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Status of the inspection lot"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the lot"
    - name: "disposition_reason"
      expr: disposition_reason
      comment: "Reason for disposition decision"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of lot inspected"
    - name: "material_type"
      expr: material_type
      comment: "Type of material inspected"
    - name: "technology_node"
      expr: technology_node
      comment: "Technology node for semiconductor lots"
    - name: "kgd_certified"
      expr: kgd_certified
      comment: "Whether lot is KGD certified"
    - name: "iso_9001_compliant"
      expr: iso_9001_compliant
      comment: "ISO 9001 compliance flag"
    - name: "iatf_16949_compliant"
      expr: iatf_16949_compliant
      comment: "IATF 16949 automotive compliance flag"
    - name: "jedec_reliability_compliant"
      expr: jedec_reliability_compliant
      comment: "JEDEC reliability compliance flag"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of inspection measurement"
  measures:
    - name: "inspection_lot_count"
      expr: COUNT(1)
      comment: "Number of inspection lots"
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total lot size across all inspections"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value"
    - name: "avg_wafer_size_mm"
      expr: AVG(CAST(wafer_size_mm AS DOUBLE))
      comment: "Average wafer size in millimeters"
    - name: "distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers inspected"
$$;