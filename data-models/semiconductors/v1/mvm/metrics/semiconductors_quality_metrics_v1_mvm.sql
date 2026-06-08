-- Metric views for domain: quality | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:30:11

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality inspection metrics tracking lot-level yield, defect density, and disposition outcomes for semiconductor wafer lots and finished goods"
  source: "`semiconductors_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (incoming, in-process, final, etc.)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed"
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision (accept, reject, rework, conditional release)"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall inspection result (pass, fail, conditional)"
    - name: "material_type"
      expr: material_type
      comment: "Type of material inspected"
    - name: "lot_type"
      expr: lot_type
      comment: "Classification of lot (production, engineering, qualification)"
    - name: "kgd_certified"
      expr: kgd_certified
      comment: "Known Good Die certification status"
    - name: "iso_9001_compliant"
      expr: iso_9001_compliant
      comment: "ISO 9001 compliance flag"
    - name: "iatf_16949_compliant"
      expr: iatf_16949_compliant
      comment: "IATF 16949 automotive quality compliance flag"
    - name: "jedec_reliability_compliant"
      expr: jedec_reliability_compliant
      comment: "JEDEC reliability standard compliance flag"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month of inspection measurement"
    - name: "inspection_quarter"
      expr: DATE_TRUNC('QUARTER', measurement_timestamp)
      comment: "Quarter of inspection measurement"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed"
    - name: "total_lot_size"
      expr: SUM(CAST(lot_size AS DOUBLE))
      comment: "Total units inspected across all lots"
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size in units"
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inspection lots"
    - name: "avg_defect_density"
      expr: AVG(CAST(defect_density AS DOUBLE))
      comment: "Average defect density per unit area"
    - name: "avg_wafer_size_mm"
      expr: AVG(CAST(wafer_size_mm AS DOUBLE))
      comment: "Average wafer size in millimeters"
    - name: "kgd_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN kgd_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots achieving Known Good Die certification"
    - name: "first_pass_yield_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_result = 'pass' AND disposition = 'accept' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots passing inspection on first attempt without rework"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'reject' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots rejected and scrapped"
    - name: "rework_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition = 'rework' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots requiring rework"
    - name: "iso_9001_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_9001_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots meeting ISO 9001 quality standards"
    - name: "iatf_16949_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iatf_16949_compliant = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots meeting IATF 16949 automotive quality standards"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect tracking and analysis metrics for semiconductor manufacturing, capturing defect density, classification, and root cause patterns"
  source: "`semiconductors_ecm`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_classification"
      expr: defect_classification
      comment: "Classification category of the defect"
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of the defect (critical, major, minor)"
    - name: "defect_layer"
      expr: defect_layer
      comment: "Manufacturing layer where defect was detected"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the defect (optical, e-beam, electrical test)"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the defect"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for defective unit"
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of defect record (open, closed, under investigation)"
    - name: "edge_exclusion_zone_flag"
      expr: edge_exclusion_zone_flag
      comment: "Whether defect occurred in wafer edge exclusion zone"
    - name: "repeatability_flag"
      expr: repeatability_flag
      comment: "Whether defect is repeatable across multiple units"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when defect was detected"
    - name: "detection_quarter"
      expr: DATE_TRUNC('QUARTER', event_timestamp)
      comment: "Quarter when defect was detected"
  measures:
    - name: "total_defects"
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
      comment: "Average defect density per zone"
    - name: "critical_defect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN defect_severity = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects classified as critical severity"
    - name: "repeatable_defect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN repeatability_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that are repeatable, indicating systematic issues"
    - name: "edge_defect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edge_exclusion_zone_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects occurring in wafer edge exclusion zones"
    - name: "defect_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN defect_status = 'closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defect records that have been closed with resolution"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_dppm_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defective Parts Per Million (DPPM) quality metrics tracking customer-facing quality performance and compliance"
  source: "`semiconductors_ecm`.`quality`.`dppm_record`"
  dimensions:
    - name: "notification_type"
      expr: notification_type
      comment: "Type of DPPM notification (customer complaint, field return, audit finding)"
    - name: "closure_status"
      expr: closure_status
      comment: "Status of DPPM issue closure"
    - name: "compliance_iso9001"
      expr: compliance_iso9001
      comment: "ISO 9001 compliance status for this DPPM record"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Whether product was Known Good Die certified"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle status at time of defect"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', shipment_start_date)
      comment: "Month of shipment start date"
    - name: "shipment_quarter"
      expr: DATE_TRUNC('QUARTER', shipment_start_date)
      comment: "Quarter of shipment start date"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when DPPM event was recorded"
  measures:
    - name: "total_dppm_records"
      expr: COUNT(1)
      comment: "Total number of DPPM quality records"
    - name: "total_defective_units"
      expr: SUM(CAST(defective_units AS DOUBLE))
      comment: "Total number of defective units reported"
    - name: "total_units_shipped"
      expr: SUM(CAST(total_units_shipped AS DOUBLE))
      comment: "Total number of units shipped in DPPM reporting period"
    - name: "avg_dppm_value"
      expr: AVG(CAST(dppm_value AS DOUBLE))
      comment: "Average defective parts per million across all records"
    - name: "weighted_dppm"
      expr: ROUND(1000000.0 * SUM(CAST(defective_units AS DOUBLE)) / NULLIF(SUM(CAST(total_units_shipped AS DOUBLE)), 0), 2)
      comment: "Weighted DPPM calculated as total defective units per million shipped units"
    - name: "kgd_certified_dppm_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_kgd_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DPPM records for KGD-certified products"
    - name: "closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closure_status = 'closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DPPM issues that have been closed"
    - name: "iso9001_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_iso9001 = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of DPPM records meeting ISO 9001 compliance"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint tracking and resolution metrics measuring customer satisfaction impact and corrective action effectiveness"
  source: "`semiconductors_ecm`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (quality, delivery, documentation, performance)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint"
    - name: "priority"
      expr: priority
      comment: "Priority assigned to complaint resolution"
    - name: "customer_complaint_status"
      expr: customer_complaint_status
      comment: "Current status of complaint (open, investigating, resolved, closed)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of complaint resolution"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action implementation"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether complaint has been escalated"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation (management, executive, customer executive)"
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Whether complaint resulted in warranty claim"
    - name: "regulatory_report_flag"
      expr: regulatory_report_flag
      comment: "Whether complaint requires regulatory reporting"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance-related complaint flag"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which complaint was received"
    - name: "complaint_month"
      expr: DATE_TRUNC('MONTH', complaint_timestamp)
      comment: "Month when complaint was received"
    - name: "complaint_quarter"
      expr: DATE_TRUNC('QUARTER', complaint_timestamp)
      comment: "Quarter when complaint was received"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints"
    - name: "total_complaint_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost impact of customer complaints"
    - name: "total_cost_net"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost after adjustments"
    - name: "avg_complaint_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per customer complaint"
    - name: "avg_dppm_impact"
      expr: AVG(CAST(dppm_impact AS DOUBLE))
      comment: "Average DPPM impact per complaint"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints requiring escalation"
    - name: "warranty_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN warranty_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints resulting in warranty claims"
    - name: "regulatory_report_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_report_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints requiring regulatory reporting"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints successfully resolved"
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints with completed corrective actions"
    - name: "critical_severity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN severity = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints classified as critical severity"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_capa_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics tracking quality improvement initiatives and closure performance"
  source: "`semiconductors_ecm`.`quality`.`capa_record`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, both)"
    - name: "capa_record_status"
      expr: capa_record_status
      comment: "Current status of CAPA record"
    - name: "priority"
      expr: priority
      comment: "Priority level of CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity of the issue being addressed"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment"
    - name: "root_cause_method"
      expr: root_cause_method
      comment: "Method used for root cause analysis (5-Why, Fishbone, FTA)"
    - name: "detection_phase"
      expr: detection_phase
      comment: "Phase where issue was detected"
    - name: "detection_source"
      expr: detection_source
      comment: "Source of issue detection"
    - name: "closure_approval_status"
      expr: closure_approval_status
      comment: "Approval status for CAPA closure"
    - name: "verification_result"
      expr: verification_result
      comment: "Result of effectiveness verification"
    - name: "impact"
      expr: impact
      comment: "Business impact classification"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month when issue was detected"
    - name: "detection_quarter"
      expr: DATE_TRUNC('QUARTER', detection_date)
      comment: "Quarter when issue was detected"
  measures:
    - name: "total_capa_records"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "total_capa_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual cost of CAPA implementation"
    - name: "total_capa_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of CAPA"
    - name: "avg_capa_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost per CAPA"
    - name: "avg_capa_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost per CAPA"
    - name: "capa_closure_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_record_status = 'closed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPA records that have been closed"
    - name: "verification_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_result = 'effective' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs verified as effective"
    - name: "high_risk_capa_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN risk_level = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs classified as high risk"
    - name: "preventive_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN capa_type IN ('preventive', 'both') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs including preventive actions"
    - name: "cost_variance_rate"
      expr: ROUND(100.0 * (SUM(CAST(cost_actual AS DOUBLE)) - SUM(CAST(cost_estimate AS DOUBLE))) / NULLIF(SUM(CAST(cost_estimate AS DOUBLE)), 0), 2)
      comment: "Percentage variance between actual and estimated CAPA costs"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_reliability_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Semiconductor reliability test metrics tracking FIT rates, qualification status, and compliance with JEDEC and automotive standards"
  source: "`semiconductors_ecm`.`quality`.`reliability_test`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of reliability test (HTOL, HAST, TC, EM, etc.)"
    - name: "test_status"
      expr: test_status
      comment: "Current status of reliability test"
    - name: "test_result"
      expr: test_result
      comment: "Result of reliability test (pass, fail, conditional)"
    - name: "overall_status"
      expr: overall_status
      comment: "Overall qualification status"
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (new product, process change, requalification)"
    - name: "reliability_grade"
      expr: reliability_grade
      comment: "Reliability grade assigned (automotive, industrial, commercial)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Observed failure mode"
    - name: "failure_mechanism"
      expr: failure_mechanism
      comment: "Physical failure mechanism"
    - name: "is_kgd_certified"
      expr: is_kgd_certified
      comment: "Known Good Die certification status"
    - name: "compliance_jedec"
      expr: compliance_jedec
      comment: "JEDEC standard compliance flag"
    - name: "compliance_iso_9001"
      expr: compliance_iso_9001
      comment: "ISO 9001 compliance flag"
    - name: "compliance_iatf_16949"
      expr: compliance_iatf_16949
      comment: "IATF 16949 automotive compliance flag"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_execution_timestamp)
      comment: "Month when test was executed"
    - name: "test_quarter"
      expr: DATE_TRUNC('QUARTER', test_execution_timestamp)
      comment: "Quarter when test was executed"
  measures:
    - name: "total_reliability_tests"
      expr: COUNT(1)
      comment: "Total number of reliability tests conducted"
    - name: "avg_fit_rate"
      expr: AVG(CAST(fit_rate AS DOUBLE))
      comment: "Average Failures In Time rate (failures per billion device hours)"
    - name: "avg_test_duration_hours"
      expr: AVG(CAST(test_duration_hours AS DOUBLE))
      comment: "Average test duration in hours"
    - name: "avg_failure_time_hours"
      expr: AVG(CAST(failure_time_hours AS DOUBLE))
      comment: "Average time to failure in hours"
    - name: "avg_test_temperature_c"
      expr: AVG(CAST(test_temperature_c AS DOUBLE))
      comment: "Average test temperature in Celsius"
    - name: "avg_test_voltage_v"
      expr: AVG(CAST(test_voltage_v AS DOUBLE))
      comment: "Average test voltage in volts"
    - name: "avg_weibull_shape"
      expr: AVG(CAST(weibull_shape_parameter AS DOUBLE))
      comment: "Average Weibull shape parameter (beta) for failure distribution"
    - name: "avg_weibull_scale"
      expr: AVG(CAST(weibull_scale_parameter AS DOUBLE))
      comment: "Average Weibull scale parameter (eta) for failure distribution"
    - name: "test_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN test_result = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reliability tests passing acceptance criteria"
    - name: "kgd_certification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_kgd_certified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests for KGD-certified products"
    - name: "jedec_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_jedec = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests meeting JEDEC reliability standards"
    - name: "automotive_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_iatf_16949 = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests meeting IATF 16949 automotive quality standards"
    - name: "qualification_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN overall_status = 'qualified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reliability qualifications successfully completed"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Semiconductor manufacturing yield metrics tracking die-level yield performance, defect density, and yield gap analysis"
  source: "`semiconductors_ecm`.`quality`.`yield_record`"
  dimensions:
    - name: "yield_record_status"
      expr: yield_record_status
      comment: "Status of yield record"
    - name: "measurement_stage"
      expr: measurement_stage
      comment: "Manufacturing stage where yield was measured"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure yield"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of yield inspection"
    - name: "quality_gate"
      expr: quality_gate
      comment: "Quality gate checkpoint"
    - name: "lot_status"
      expr: lot_status
      comment: "Status of the lot"
    - name: "yield_loss_category"
      expr: yield_loss_category
      comment: "Category of yield loss (systematic, random, parametric)"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect causing yield loss"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of measurement equipment"
    - name: "fab_line"
      expr: fab_line
      comment: "Fabrication line identifier"
    - name: "shift"
      expr: shift
      comment: "Manufacturing shift"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of yield measurement event"
    - name: "event_quarter"
      expr: DATE_TRUNC('QUARTER', event_timestamp)
      comment: "Quarter of yield measurement event"
  measures:
    - name: "total_yield_records"
      expr: COUNT(1)
      comment: "Total number of yield measurement records"
    - name: "total_die_count"
      expr: SUM(CAST(total_die_count AS DOUBLE))
      comment: "Total number of die measured"
    - name: "total_good_die_count"
      expr: SUM(CAST(good_die_count AS DOUBLE))
      comment: "Total number of good die passing all tests"
    - name: "total_defect_count"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total number of defects detected"
    - name: "avg_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across all measurements"
    - name: "avg_defect_density_per_cm2"
      expr: AVG(CAST(defect_density_per_cm2 AS DOUBLE))
      comment: "Average defect density per square centimeter"
    - name: "avg_yield_gap_percent"
      expr: AVG(CAST(yield_gap_percent AS DOUBLE))
      comment: "Average gap between actual and target yield"
    - name: "avg_test_time_seconds"
      expr: AVG(CAST(test_time_seconds AS DOUBLE))
      comment: "Average test time per unit in seconds"
    - name: "weighted_yield"
      expr: ROUND(100.0 * SUM(CAST(good_die_count AS DOUBLE)) / NULLIF(SUM(CAST(total_die_count AS DOUBLE)), 0), 2)
      comment: "Weighted yield calculated as total good die divided by total die"
    - name: "yield_target_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN yield_percentage >= yield_target_percent THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of yield measurements meeting or exceeding target"
    - name: "quality_gate_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN inspection_result = 'pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lots passing quality gate inspection"
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`quality_nonconformance_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance and Material Review Board (MRB) metrics tracking quality escapes, disposition decisions, and containment effectiveness"
  source: "`semiconductors_ecm`.`quality`.`nonconformance_report`"
  dimensions:
    - name: "nonconformance_report_status"
      expr: nonconformance_report_status
      comment: "Current status of nonconformance report"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of nonconformance"
    - name: "priority"
      expr: priority
      comment: "Priority for resolution"
    - name: "detection_point"
      expr: detection_point
      comment: "Point in process where nonconformance was detected"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "MRB disposition decision (use-as-is, rework, scrap, return)"
    - name: "mrb_decision"
      expr: mrb_decision
      comment: "Material Review Board decision"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quality hold applied"
    - name: "is_customer_impact"
      expr: is_customer_impact
      comment: "Whether nonconformance impacts customer"
    - name: "customer_notification_required"
      expr: customer_notification_required
      comment: "Whether customer notification is required"
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Applicable compliance standard"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', report_timestamp)
      comment: "Month when nonconformance was reported"
    - name: "report_quarter"
      expr: DATE_TRUNC('QUARTER', report_timestamp)
      comment: "Quarter when nonconformance was reported"
  measures:
    - name: "total_nonconformance_reports"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports"
    - name: "total_impact_amount"
      expr: SUM(CAST(impact_amount AS DOUBLE))
      comment: "Total financial impact of nonconformances"
    - name: "avg_impact_amount"
      expr: AVG(CAST(impact_amount AS DOUBLE))
      comment: "Average financial impact per nonconformance"
    - name: "customer_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_customer_impact = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances impacting customers"
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customer_notification_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances requiring customer notification"
    - name: "scrap_disposition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition_decision = 'scrap' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances resulting in scrap disposition"
    - name: "rework_disposition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition_decision = 'rework' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances requiring rework"
    - name: "use_as_is_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN disposition_decision = 'use-as-is' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances accepted as-is by MRB"
    - name: "corrective_action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances with completed corrective actions"
    - name: "critical_severity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN severity_level = 'critical' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nonconformances classified as critical severity"
$$;