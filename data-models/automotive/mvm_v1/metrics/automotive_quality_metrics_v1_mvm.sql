-- Metric views for domain: quality | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_defect_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality defect metrics tracking defect rates, severity distribution, and resolution performance across manufacturing, logistics, and dealer operations"
  source: "`automotive_ecm`.`quality`.`defect_record`"
  dimensions:
    - name: "defect_category"
      expr: defect_category
      comment: "Category classification of the defect"
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect identified"
    - name: "severity"
      expr: severity
      comment: "Severity level of the defect (critical, major, minor)"
    - name: "defect_record_status"
      expr: defect_record_status
      comment: "Current status of the defect record"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the defect was detected"
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the defect (rework, scrap, use-as-is)"
    - name: "is_repeat_defect"
      expr: is_repeat_defect
      comment: "Flag indicating if this is a recurring defect"
    - name: "detected_year"
      expr: YEAR(detected_timestamp)
      comment: "Year when defect was detected"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when defect was detected"
    - name: "detected_week"
      expr: DATE_TRUNC('WEEK', detected_timestamp)
      comment: "Week when defect was detected"
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defect records"
    - name: "unique_vins_with_defects"
      expr: COUNT(DISTINCT vin)
      comment: "Count of unique vehicles with defects"
    - name: "avg_ppm_rate"
      expr: AVG(CAST(ppm_rate AS DOUBLE))
      comment: "Average parts per million defect rate"
    - name: "repeat_defect_count"
      expr: SUM(CASE WHEN is_repeat_defect = true THEN 1 ELSE 0 END)
      comment: "Count of defects that are repeat occurrences"
    - name: "repeat_defect_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_defect = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that are repeat occurrences"
    - name: "critical_defect_count"
      expr: SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity defects"
    - name: "avg_investigation_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(investigation_end_timestamp) - UNIX_TIMESTAMP(investigation_start_timestamp)) / 3600 AS DOUBLE))
      comment: "Average investigation duration in hours from start to end"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance metrics tracking audit scores, findings, corrective actions, and compliance across plants, suppliers, and dealers"
  source: "`automotive_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (internal, external, supplier, process)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_scope"
      expr: audit_scope
      comment: "Scope of the audit"
    - name: "audit_method"
      expr: audit_method
      comment: "Method used to conduct the audit"
    - name: "score_category"
      expr: score_category
      comment: "Category classification of the audit score"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level identified by the audit"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating if corrective action is required"
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions"
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the audit"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year when audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month when audit was conducted"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "avg_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score"
    - name: "total_major_findings"
      expr: SUM(CAST(findings_major AS BIGINT))
      comment: "Total count of major findings across all audits"
    - name: "total_minor_findings"
      expr: SUM(CAST(findings_minor AS BIGINT))
      comment: "Total count of minor findings across all audits"
    - name: "total_severe_findings"
      expr: SUM(CAST(findings_severe AS BIGINT))
      comment: "Total count of severe findings across all audits"
    - name: "total_findings"
      expr: SUM(CAST(findings_total AS BIGINT))
      comment: "Total count of all findings across all audits"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(findings_total AS DOUBLE))
      comment: "Average number of findings per audit"
    - name: "audits_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END)
      comment: "Count of audits requiring corrective action"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action"
    - name: "high_risk_audit_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of audits with high risk level"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_supplier_quality_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality performance metrics tracking defect rates, resolution times, and corrective action effectiveness for inbound supply quality"
  source: "`automotive_ecm`.`quality`.`supplier_quality_event`"
  dimensions:
    - name: "defect_severity"
      expr: defect_severity
      comment: "Severity level of the supplier quality defect"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution status of the quality event"
    - name: "detection_method"
      expr: detection_method
      comment: "Method by which the quality issue was detected"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if this is a critical quality event"
    - name: "is_repeat_issue"
      expr: is_repeat_issue
      comment: "Flag indicating if this is a recurring issue with the supplier"
    - name: "sca_requested"
      expr: sca_requested
      comment: "Flag indicating if supplier corrective action was requested"
    - name: "supplier_response_status"
      expr: supplier_response_status
      comment: "Status of supplier response to the quality event"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the quality event"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating if regulatory compliance is affected"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year when quality event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month when quality event occurred"
  measures:
    - name: "total_supplier_quality_events"
      expr: COUNT(1)
      comment: "Total number of supplier quality events"
    - name: "unique_suppliers_with_issues"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of unique suppliers with quality events"
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS BIGINT))
      comment: "Total quantity of parts affected by quality events"
    - name: "total_defect_quantity"
      expr: SUM(CAST(defect_quantity AS BIGINT))
      comment: "Total quantity of defective parts"
    - name: "avg_resolution_time_days"
      expr: AVG(CAST(actual_resolution_time_days AS DOUBLE))
      comment: "Average actual resolution time in days"
    - name: "critical_event_count"
      expr: SUM(CASE WHEN is_critical = true THEN 1 ELSE 0 END)
      comment: "Count of critical supplier quality events"
    - name: "repeat_issue_count"
      expr: SUM(CASE WHEN is_repeat_issue = true THEN 1 ELSE 0 END)
      comment: "Count of repeat quality issues"
    - name: "repeat_issue_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_issue = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of quality events that are repeat issues"
    - name: "sca_request_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sca_requested = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events requiring supplier corrective action"
    - name: "regulatory_impact_count"
      expr: SUM(CASE WHEN regulatory_compliance_flag = true THEN 1 ELSE 0 END)
      comment: "Count of events with regulatory compliance impact"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot quality metrics tracking acceptance rates, rejection rates, and inspection effectiveness across incoming materials and production"
  source: "`automotive_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_lot_status"
      expr: inspection_lot_status
      comment: "Current status of the inspection lot"
    - name: "lot_type"
      expr: lot_type
      comment: "Type of inspection lot (incoming, in-process, final)"
    - name: "lot_origin"
      expr: lot_origin
      comment: "Origin of the inspection lot"
    - name: "decision"
      expr: decision
      comment: "Inspection decision (accept, reject, conditional)"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection"
    - name: "inspection_reason_code"
      expr: inspection_reason_code
      comment: "Reason code for the inspection"
    - name: "measurement_result_status"
      expr: measurement_result_status
      comment: "Status of measurement results"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating if corrective action is required"
    - name: "inspection_year"
      expr: YEAR(inspection_timestamp)
      comment: "Year when inspection was performed"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month when inspection was performed"
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots"
    - name: "total_quantity_inspected"
      expr: SUM(CAST(quantity_inspected AS BIGINT))
      comment: "Total quantity of items inspected"
    - name: "total_quantity_accepted"
      expr: SUM(CAST(quantity_accepted AS BIGINT))
      comment: "Total quantity of items accepted"
    - name: "total_quantity_rejected"
      expr: SUM(CAST(quantity_rejected AS BIGINT))
      comment: "Total quantity of items rejected"
    - name: "acceptance_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_accepted AS BIGINT)) / NULLIF(SUM(CAST(quantity_inspected AS BIGINT)), 0), 2)
      comment: "Percentage of inspected quantity that was accepted"
    - name: "rejection_rate"
      expr: ROUND(100.0 * SUM(CAST(quantity_rejected AS BIGINT)) / NULLIF(SUM(CAST(quantity_inspected AS BIGINT)), 0), 2)
      comment: "Percentage of inspected quantity that was rejected"
    - name: "lots_requiring_corrective_action"
      expr: SUM(CASE WHEN corrective_action_required = true THEN 1 ELSE 0 END)
      comment: "Count of inspection lots requiring corrective action"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value across inspection lots"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_apqp_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advanced Product Quality Planning metrics tracking gate completion, quality goal achievement, and program launch readiness"
  source: "`automotive_ecm`.`quality`.`apqp_plan`"
  dimensions:
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase (Plan, Design, Develop, Validate, Launch)"
    - name: "milestone_gate"
      expr: milestone_gate
      comment: "Milestone gate identifier"
    - name: "gate_status"
      expr: gate_status
      comment: "Status of the milestone gate"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the APQP plan"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the plan"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment"
    - name: "classification_type"
      expr: classification_type
      comment: "Classification type of the APQP plan"
    - name: "model_year"
      expr: model_year
      comment: "Model year for the vehicle program"
    - name: "sop_year"
      expr: YEAR(sop_date)
      comment: "Start of production year"
    - name: "sop_month"
      expr: DATE_TRUNC('MONTH', sop_date)
      comment: "Start of production month"
  measures:
    - name: "total_apqp_plans"
      expr: COUNT(1)
      comment: "Total number of APQP plans"
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target parts per million defect rate"
    - name: "avg_quality_goal_ppm"
      expr: AVG(CAST(quality_goal_ppm AS DOUBLE))
      comment: "Average quality goal parts per million"
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual parts per million defect rate achieved"
    - name: "plans_meeting_quality_goal"
      expr: SUM(CASE WHEN actual_ppm <= quality_goal_ppm THEN 1 ELSE 0 END)
      comment: "Count of plans meeting or exceeding quality goal"
    - name: "quality_goal_achievement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_ppm <= quality_goal_ppm THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of plans achieving quality goal PPM target"
    - name: "high_risk_plan_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk APQP plans"
    - name: "gates_on_time"
      expr: SUM(CASE WHEN gate_completion_date <= gate_due_date THEN 1 ELSE 0 END)
      comment: "Count of gates completed on or before due date"
    - name: "gate_on_time_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gate_completion_date <= gate_due_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of gates completed on time"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis metrics tracking risk priority numbers, severity ratings, and mitigation effectiveness"
  source: "`automotive_ecm`.`quality`.`fmea`"
  dimensions:
    - name: "analysis_type"
      expr: analysis_type
      comment: "Type of FMEA analysis (Design, Process, System)"
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current status of the FMEA"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Description of the failure mode"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the failure effect"
    - name: "occurrence_rating"
      expr: occurrence_rating
      comment: "Occurrence rating of the failure mode"
    - name: "detection_rating"
      expr: detection_rating
      comment: "Detection rating of the current controls"
    - name: "subsystem"
      expr: subsystem
      comment: "Subsystem or component being analyzed"
    - name: "detection_method"
      expr: detection_method
      comment: "Method for detecting the failure mode"
    - name: "control_effectiveness_rating"
      expr: control_effectiveness_rating
      comment: "Effectiveness rating of current controls"
  measures:
    - name: "total_fmea_analyses"
      expr: COUNT(1)
      comment: "Total number of FMEA analyses"
    - name: "avg_rpn"
      expr: AVG(CAST(rpn AS DOUBLE))
      comment: "Average Risk Priority Number across all FMEAs"
    - name: "high_rpn_count"
      expr: SUM(CASE WHEN CAST(rpn AS INT) >= 100 THEN 1 ELSE 0 END)
      comment: "Count of FMEAs with RPN of 100 or higher"
    - name: "high_severity_count"
      expr: SUM(CASE WHEN CAST(severity_rating AS INT) >= 8 THEN 1 ELSE 0 END)
      comment: "Count of failure modes with severity rating 8 or higher"
    - name: "actions_completed_on_time"
      expr: SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END)
      comment: "Count of recommended actions completed on or before target date"
    - name: "action_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN actual_completion_date <= target_completion_date THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recommended actions completed on time"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics tracking process capability, measurement conformance, and critical characteristic performance"
  source: "`automotive_ecm`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Status of the inspection result (pass, fail, conditional)"
    - name: "record_status"
      expr: record_status
      comment: "Record status of the inspection result"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if this is a critical characteristic"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used for measurement"
    - name: "measurement_tool"
      expr: measurement_tool
      comment: "Tool used for measurement"
    - name: "measurement_location"
      expr: measurement_location
      comment: "Location where measurement was taken"
    - name: "measurement_source"
      expr: measurement_source
      comment: "Source of the measurement data"
    - name: "inspection_year"
      expr: YEAR(inspection_timestamp)
      comment: "Year when inspection was performed"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_timestamp)
      comment: "Month when inspection was performed"
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection results"
    - name: "avg_measurement_value"
      expr: AVG(CAST(measurement_value AS DOUBLE))
      comment: "Average measurement value"
    - name: "avg_cp_value"
      expr: AVG(CAST(cp_value AS DOUBLE))
      comment: "Average process capability index (Cp)"
    - name: "avg_cpk_value"
      expr: AVG(CAST(cpk_value AS DOUBLE))
      comment: "Average process capability index (Cpk)"
    - name: "results_meeting_spec"
      expr: SUM(CASE WHEN measurement_value BETWEEN lower_spec_limit AND upper_spec_limit THEN 1 ELSE 0 END)
      comment: "Count of results within specification limits"
    - name: "conformance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN measurement_value BETWEEN lower_spec_limit AND upper_spec_limit THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurements within specification limits"
    - name: "critical_characteristic_count"
      expr: SUM(CASE WHEN is_critical = true THEN 1 ELSE 0 END)
      comment: "Count of critical characteristic inspections"
    - name: "avg_deviation_amount"
      expr: AVG(CAST(deviation_amount AS DOUBLE))
      comment: "Average deviation from target specification"
    - name: "capable_process_count"
      expr: SUM(CASE WHEN cpk_value >= 1.33 THEN 1 ELSE 0 END)
      comment: "Count of results with Cpk >= 1.33 indicating capable process"
    - name: "process_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cpk_value >= 1.33 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of processes meeting capability threshold (Cpk >= 1.33)"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`quality_control_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control plan effectiveness metrics tracking plan compliance, approval cycle time, and control method coverage"
  source: "`automotive_ecm`.`quality`.`control_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of control plan (prototype, pre-launch, production)"
    - name: "control_plan_status"
      expr: control_plan_status
      comment: "Current status of the control plan"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the control plan"
    - name: "control_method"
      expr: control_method
      comment: "Method of control specified in the plan"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating if the control plan is mandatory"
    - name: "responsible_function"
      expr: responsible_function
      comment: "Function responsible for executing the control plan"
    - name: "sample_frequency"
      expr: sample_frequency
      comment: "Frequency of sampling specified in the plan"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year when control plan was approved"
  measures:
    - name: "total_control_plans"
      expr: COUNT(1)
      comment: "Total number of control plans"
    - name: "approved_control_plans"
      expr: SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of approved control plans"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of control plans that are approved"
    - name: "mandatory_plan_count"
      expr: SUM(CASE WHEN is_mandatory = true THEN 1 ELSE 0 END)
      comment: "Count of mandatory control plans"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value across control plans"
    - name: "avg_lower_spec_limit"
      expr: AVG(CAST(lower_spec_limit AS DOUBLE))
      comment: "Average lower specification limit"
    - name: "avg_upper_spec_limit"
      expr: AVG(CAST(upper_spec_limit AS DOUBLE))
      comment: "Average upper specification limit"
$$;