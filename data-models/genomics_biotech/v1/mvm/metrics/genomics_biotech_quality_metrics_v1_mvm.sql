-- Metric views for domain: quality | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit performance and findings metrics tracking audit completion, duration, and critical findings across regulatory and internal audits"
  source: "`genomics_biotech_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit conducted (internal, supplier, regulatory, etc.)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (scheduled, in progress, completed, closed)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level classification of the audit (low, medium, high, critical)"
    - name: "regulatory_inspection_flag"
      expr: regulatory_inspection_flag
      comment: "Indicates whether this is a regulatory inspection audit"
    - name: "outcome"
      expr: outcome
      comment: "Overall outcome of the audit (pass, pass with observations, fail)"
    - name: "audit_year"
      expr: YEAR(actual_start_date)
      comment: "Year the audit was conducted"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(actual_start_date))
      comment: "Quarter the audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', actual_start_date)
      comment: "Month the audit was conducted"
    - name: "inspection_authority"
      expr: inspection_authority
      comment: "Regulatory authority conducting the inspection (FDA, EMA, etc.)"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether follow-up actions are required"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits conducted"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total count of critical findings across all audits"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS DOUBLE))
      comment: "Total count of all findings across all audits"
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of audits in hours"
    - name: "total_audit_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total audit hours invested across all audits"
    - name: "audits_with_critical_findings"
      expr: COUNT(CASE WHEN CAST(critical_findings_count AS DOUBLE) > 0 THEN 1 END)
      comment: "Number of audits that identified at least one critical finding"
    - name: "regulatory_inspections"
      expr: COUNT(CASE WHEN regulatory_inspection_flag = TRUE THEN 1 END)
      comment: "Number of regulatory inspection audits"
    - name: "audits_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring follow-up actions"
    - name: "avg_findings_per_audit"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding closure and response performance metrics tracking finding resolution, overdue responses, and repeat findings"
  source: "`genomics_biotech_ecm`.`quality`.`audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (observation, minor, major, critical)"
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the finding (GMP, GLP, GCP, GDP, etc.)"
    - name: "audit_finding_status"
      expr: audit_finding_status
      comment: "Current status of the finding (open, in progress, closed, verified)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the finding (low, medium, high, critical)"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Indicates whether this is a repeat finding from previous audits"
    - name: "gxp_impact_flag"
      expr: gxp_impact_flag
      comment: "Indicates whether the finding has GxP impact"
    - name: "data_integrity_issue_flag"
      expr: data_integrity_issue_flag
      comment: "Indicates whether the finding relates to data integrity"
    - name: "fda_warning_letter_related_flag"
      expr: fda_warning_letter_related_flag
      comment: "Indicates whether the finding is related to FDA warning letter items"
    - name: "response_overdue_flag"
      expr: response_overdue_flag
      comment: "Indicates whether the response is overdue"
    - name: "affected_department"
      expr: affected_department
      comment: "Department affected by the finding"
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified"
    - name: "identified_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the finding was identified"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "repeat_findings"
      expr: COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END)
      comment: "Number of repeat findings from previous audits"
    - name: "gxp_impact_findings"
      expr: COUNT(CASE WHEN gxp_impact_flag = TRUE THEN 1 END)
      comment: "Number of findings with GxP impact"
    - name: "data_integrity_findings"
      expr: COUNT(CASE WHEN data_integrity_issue_flag = TRUE THEN 1 END)
      comment: "Number of findings related to data integrity issues"
    - name: "fda_warning_letter_findings"
      expr: COUNT(CASE WHEN fda_warning_letter_related_flag = TRUE THEN 1 END)
      comment: "Number of findings related to FDA warning letter items"
    - name: "overdue_responses"
      expr: COUNT(CASE WHEN response_overdue_flag = TRUE THEN 1 END)
      comment: "Number of findings with overdue responses"
    - name: "closed_findings"
      expr: COUNT(CASE WHEN audit_finding_status = 'closed' THEN 1 END)
      comment: "Number of findings that have been closed"
    - name: "verified_findings"
      expr: COUNT(CASE WHEN verification_date IS NOT NULL THEN 1 END)
      comment: "Number of findings that have been verified as resolved"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness and cycle time metrics tracking CAPA completion, overdue actions, and effectiveness verification"
  source: "`genomics_biotech_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective, preventive, combined)"
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (initiated, investigation, action plan, implementation, effectiveness check, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA (low, medium, high, critical)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the issue (minor, major, critical)"
    - name: "gxp_classification"
      expr: gxp_classification
      comment: "GxP classification of the CAPA (GMP, GLP, GCP, GDP, non-GxP)"
    - name: "initiation_source"
      expr: initiation_source
      comment: "Source that initiated the CAPA (audit, deviation, complaint, inspection, etc.)"
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used for root cause analysis (5 Why, Fishbone, Fault Tree, etc.)"
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of the effectiveness check (effective, not effective, partially effective)"
    - name: "product_impact"
      expr: product_impact
      comment: "Impact on product quality (none, low, medium, high)"
    - name: "regulatory_impact"
      expr: regulatory_impact
      comment: "Regulatory impact level (none, low, medium, high)"
    - name: "training_required"
      expr: training_required
      comment: "Indicates whether training is required as part of CAPA"
    - name: "sop_updates_required"
      expr: sop_updates_required
      comment: "Indicates whether SOP updates are required"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the CAPA was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the CAPA was initiated"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total number of CAPAs"
    - name: "closed_capas"
      expr: COUNT(CASE WHEN capa_status = 'closed' THEN 1 END)
      comment: "Number of CAPAs that have been closed"
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_due_date < CURRENT_DATE() AND investigation_completed_date IS NULL THEN 1 END)
      comment: "Number of CAPAs with overdue investigations"
    - name: "overdue_implementations"
      expr: COUNT(CASE WHEN implementation_due_date < CURRENT_DATE() AND implementation_completed_date IS NULL THEN 1 END)
      comment: "Number of CAPAs with overdue implementations"
    - name: "overdue_effectiveness_checks"
      expr: COUNT(CASE WHEN effectiveness_check_due_date < CURRENT_DATE() AND effectiveness_check_completed_date IS NULL THEN 1 END)
      comment: "Number of CAPAs with overdue effectiveness checks"
    - name: "effective_capas"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'effective' THEN 1 END)
      comment: "Number of CAPAs verified as effective"
    - name: "ineffective_capas"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'not effective' THEN 1 END)
      comment: "Number of CAPAs found to be ineffective"
    - name: "capas_requiring_training"
      expr: COUNT(CASE WHEN training_required = TRUE THEN 1 END)
      comment: "Number of CAPAs requiring training"
    - name: "capas_requiring_sop_updates"
      expr: COUNT(CASE WHEN sop_updates_required = TRUE THEN 1 END)
      comment: "Number of CAPAs requiring SOP updates"
    - name: "high_priority_capas"
      expr: COUNT(CASE WHEN priority IN ('high', 'critical') THEN 1 END)
      comment: "Number of high or critical priority CAPAs"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality deviation and non-conformance metrics tracking deviation frequency, severity, investigation cycle time, and regulatory reportability"
  source: "`genomics_biotech_ecm`.`quality`.`deviation`"
  dimensions:
    - name: "deviation_type"
      expr: deviation_type
      comment: "Type of deviation (process, equipment, material, documentation, etc.)"
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current status of the deviation (open, investigation, closed)"
    - name: "severity_grade"
      expr: severity_grade
      comment: "Severity grade of the deviation (minor, major, critical)"
    - name: "gxp_classification"
      expr: gxp_classification
      comment: "GxP classification (GMP, GLP, GCP, GDP, non-GxP)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for affected material (accept, reject, rework, retest)"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the deviation is reportable to regulatory authorities"
    - name: "repeat_deviation_flag"
      expr: repeat_deviation_flag
      comment: "Indicates whether this is a repeat deviation"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether CAPA is required"
    - name: "customer_notification_required_flag"
      expr: customer_notification_required_flag
      comment: "Indicates whether customer notification is required"
    - name: "occurrence_year"
      expr: YEAR(CAST(occurrence_timestamp AS DATE))
      comment: "Year the deviation occurred"
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', CAST(occurrence_timestamp AS DATE))
      comment: "Month the deviation occurred"
    - name: "reported_year"
      expr: YEAR(CAST(reported_timestamp AS DATE))
      comment: "Year the deviation was reported"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total number of deviations"
    - name: "critical_deviations"
      expr: COUNT(CASE WHEN severity_grade = 'critical' THEN 1 END)
      comment: "Number of critical severity deviations"
    - name: "major_deviations"
      expr: COUNT(CASE WHEN severity_grade = 'major' THEN 1 END)
      comment: "Number of major severity deviations"
    - name: "regulatory_reportable_deviations"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of deviations reportable to regulatory authorities"
    - name: "repeat_deviations"
      expr: COUNT(CASE WHEN repeat_deviation_flag = TRUE THEN 1 END)
      comment: "Number of repeat deviations"
    - name: "deviations_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of deviations requiring CAPA"
    - name: "deviations_requiring_customer_notification"
      expr: COUNT(CASE WHEN customer_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of deviations requiring customer notification"
    - name: "closed_deviations"
      expr: COUNT(CASE WHEN deviation_status = 'closed' THEN 1 END)
      comment: "Number of closed deviations"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from occurrence to closure"
    - name: "overdue_investigations"
      expr: COUNT(CASE WHEN investigation_due_date < CURRENT_DATE() AND deviation_status != 'closed' THEN 1 END)
      comment: "Number of deviations with overdue investigations"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint and product quality issue metrics tracking complaint volume, severity, resolution time, and regulatory reportability"
  source: "`genomics_biotech_ecm`.`quality`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of complaint (product quality, service, delivery, documentation, etc.)"
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, investigation, closed)"
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source of the complaint (customer, distributor, internal, regulatory)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the complaint (low, medium, high, critical)"
    - name: "priority"
      expr: priority
      comment: "Priority level for resolution (low, medium, high, urgent)"
    - name: "mdr_reportable"
      expr: mdr_reportable
      comment: "Indicates whether the complaint is reportable under Medical Device Reporting (MDR) regulations"
    - name: "vigilance_reportable"
      expr: vigilance_reportable
      comment: "Indicates whether the complaint is reportable under vigilance regulations"
    - name: "patient_safety_impact"
      expr: patient_safety_impact
      comment: "Indicates whether the complaint has patient safety impact"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action is required"
    - name: "investigation_required"
      expr: investigation_required
      comment: "Indicates whether investigation is required"
    - name: "customer_response_sent"
      expr: customer_response_sent
      comment: "Indicates whether response has been sent to customer"
    - name: "received_year"
      expr: YEAR(received_date)
      comment: "Year the complaint was received"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month the complaint was received"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints"
    - name: "critical_complaints"
      expr: COUNT(CASE WHEN severity = 'critical' THEN 1 END)
      comment: "Number of critical severity complaints"
    - name: "mdr_reportable_complaints"
      expr: COUNT(CASE WHEN mdr_reportable = TRUE THEN 1 END)
      comment: "Number of complaints reportable under MDR regulations"
    - name: "vigilance_reportable_complaints"
      expr: COUNT(CASE WHEN vigilance_reportable = TRUE THEN 1 END)
      comment: "Number of complaints reportable under vigilance regulations"
    - name: "patient_safety_complaints"
      expr: COUNT(CASE WHEN patient_safety_impact = TRUE THEN 1 END)
      comment: "Number of complaints with patient safety impact"
    - name: "complaints_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of complaints requiring corrective action"
    - name: "closed_complaints"
      expr: COUNT(CASE WHEN complaint_status = 'closed' THEN 1 END)
      comment: "Number of closed complaints"
    - name: "complaints_with_customer_response"
      expr: COUNT(CASE WHEN customer_response_sent = TRUE THEN 1 END)
      comment: "Number of complaints where customer response has been sent"
    - name: "avg_turnaround_time_days"
      expr: AVG(CAST(turnaround_time_days AS DOUBLE))
      comment: "Average turnaround time in days from receipt to closure"
    - name: "urgent_priority_complaints"
      expr: COUNT(CASE WHEN priority = 'urgent' THEN 1 END)
      comment: "Number of urgent priority complaints"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_qc_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality control test result metrics tracking test pass rates, out-of-specification events, and retest frequency"
  source: "`genomics_biotech_ecm`.`quality`.`qc_result`"
  dimensions:
    - name: "test_type"
      expr: test_type
      comment: "Type of quality control test (release, stability, in-process, raw material, etc.)"
    - name: "test_category"
      expr: test_category
      comment: "Category of test (chemical, microbiological, physical, performance)"
    - name: "result_status"
      expr: result_status
      comment: "Status of the test result (pending, approved, rejected)"
    - name: "lot_disposition"
      expr: lot_disposition
      comment: "Disposition decision for the lot (released, rejected, quarantine, conditional release)"
    - name: "out_of_specification_flag"
      expr: out_of_specification_flag
      comment: "Indicates whether the result is out of specification"
    - name: "retest_required_flag"
      expr: retest_required_flag
      comment: "Indicates whether retest is required"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the result is reportable to regulatory authorities"
    - name: "coa_included_flag"
      expr: coa_included_flag
      comment: "Indicates whether result is included in Certificate of Analysis"
    - name: "calibration_status"
      expr: calibration_status
      comment: "Calibration status of the instrument used (current, due, overdue)"
    - name: "laboratory_location"
      expr: laboratory_location
      comment: "Laboratory location where test was performed"
    - name: "test_year"
      expr: YEAR(test_date)
      comment: "Year the test was performed"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was performed"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of QC tests performed"
    - name: "out_of_spec_tests"
      expr: COUNT(CASE WHEN out_of_specification_flag = TRUE THEN 1 END)
      comment: "Number of out-of-specification test results"
    - name: "tests_requiring_retest"
      expr: COUNT(CASE WHEN retest_required_flag = TRUE THEN 1 END)
      comment: "Number of tests requiring retest"
    - name: "regulatory_reportable_results"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of results reportable to regulatory authorities"
    - name: "approved_results"
      expr: COUNT(CASE WHEN result_status = 'approved' THEN 1 END)
      comment: "Number of approved test results"
    - name: "rejected_results"
      expr: COUNT(CASE WHEN result_status = 'rejected' THEN 1 END)
      comment: "Number of rejected test results"
    - name: "lots_released"
      expr: COUNT(CASE WHEN lot_disposition = 'released' THEN 1 END)
      comment: "Number of lots released based on test results"
    - name: "lots_rejected"
      expr: COUNT(CASE WHEN lot_disposition = 'rejected' THEN 1 END)
      comment: "Number of lots rejected based on test results"
    - name: "tests_with_overdue_calibration"
      expr: COUNT(CASE WHEN calibration_status = 'overdue' THEN 1 END)
      comment: "Number of tests performed with overdue instrument calibration"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-conformance and material disposition metrics tracking NCR frequency, disposition decisions, and financial impact"
  source: "`genomics_biotech_ecm`.`quality`.`nonconformance`"
  dimensions:
    - name: "ncr_type"
      expr: ncr_type
      comment: "Type of non-conformance report (supplier, manufacturing, customer, internal)"
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the NCR (open, investigation, closed)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision (accept, reject, rework, return to supplier, scrap)"
    - name: "detection_source"
      expr: detection_source
      comment: "Source where non-conformance was detected (receiving inspection, in-process, final inspection, customer)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Mode of failure or non-conformance"
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether CAPA is required"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates whether the non-conformance is reportable to regulatory authorities"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial impact"
    - name: "detected_year"
      expr: YEAR(detected_date)
      comment: "Year the non-conformance was detected"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month the non-conformance was detected"
  measures:
    - name: "total_nonconformances"
      expr: COUNT(1)
      comment: "Total number of non-conformance reports"
    - name: "ncrs_requiring_capa"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of NCRs requiring CAPA"
    - name: "regulatory_reportable_ncrs"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Number of NCRs reportable to regulatory authorities"
    - name: "rejected_material_ncrs"
      expr: COUNT(CASE WHEN disposition_decision = 'reject' THEN 1 END)
      comment: "Number of NCRs resulting in material rejection"
    - name: "accepted_material_ncrs"
      expr: COUNT(CASE WHEN disposition_decision = 'accept' THEN 1 END)
      comment: "Number of NCRs resulting in material acceptance"
    - name: "rework_ncrs"
      expr: COUNT(CASE WHEN disposition_decision = 'rework' THEN 1 END)
      comment: "Number of NCRs requiring rework"
    - name: "closed_ncrs"
      expr: COUNT(CASE WHEN nonconformance_status = 'closed' THEN 1 END)
      comment: "Number of closed non-conformance reports"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of non-conformances"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per non-conformance"
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of material affected by non-conformances"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_oos_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-specification investigation metrics tracking OOS event frequency, investigation phases, assignable cause identification, and result invalidation"
  source: "`genomics_biotech_ecm`.`quality`.`oos_investigation`"
  dimensions:
    - name: "investigation_type"
      expr: investigation_type
      comment: "Type of OOS investigation (laboratory, manufacturing, stability)"
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of the investigation (initiated, phase I, phase II, closed)"
    - name: "phase"
      expr: phase
      comment: "Current phase of the investigation (Phase I, Phase II)"
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision for the OOS result (invalidate, accept, reject, retest)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (laboratory error, equipment, material, process, analyst)"
    - name: "phase_i_assignable_cause_found"
      expr: phase_i_assignable_cause_found
      comment: "Indicates whether assignable cause was found in Phase I"
    - name: "phase_ii_assignable_cause_found"
      expr: phase_ii_assignable_cause_found
      comment: "Indicates whether assignable cause was found in Phase II"
    - name: "result_invalidated"
      expr: result_invalidated
      comment: "Indicates whether the OOS result was invalidated"
    - name: "retest_authorized"
      expr: retest_authorized
      comment: "Indicates whether retest was authorized"
    - name: "capa_required"
      expr: capa_required
      comment: "Indicates whether CAPA is required"
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Indicates whether the OOS is reportable to regulatory authorities"
    - name: "initiated_year"
      expr: YEAR(initiated_date)
      comment: "Year the investigation was initiated"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the investigation was initiated"
  measures:
    - name: "total_oos_investigations"
      expr: COUNT(1)
      comment: "Total number of OOS investigations"
    - name: "phase_i_assignable_cause_found_count"
      expr: COUNT(CASE WHEN phase_i_assignable_cause_found = TRUE THEN 1 END)
      comment: "Number of investigations where assignable cause was found in Phase I"
    - name: "phase_ii_assignable_cause_found_count"
      expr: COUNT(CASE WHEN phase_ii_assignable_cause_found = TRUE THEN 1 END)
      comment: "Number of investigations where assignable cause was found in Phase II"
    - name: "invalidated_results"
      expr: COUNT(CASE WHEN result_invalidated = TRUE THEN 1 END)
      comment: "Number of OOS results that were invalidated"
    - name: "retest_authorized_count"
      expr: COUNT(CASE WHEN retest_authorized = TRUE THEN 1 END)
      comment: "Number of investigations where retest was authorized"
    - name: "oos_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of OOS investigations requiring CAPA"
    - name: "regulatory_reportable_oos"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Number of OOS events reportable to regulatory authorities"
    - name: "closed_investigations"
      expr: COUNT(CASE WHEN investigation_status = 'closed' THEN 1 END)
      comment: "Number of closed OOS investigations"
    - name: "avg_deviation_magnitude"
      expr: AVG(CAST(deviation_magnitude AS DOUBLE))
      comment: "Average magnitude of deviation from specification"
    - name: "phase_ii_investigations"
      expr: COUNT(CASE WHEN phase = 'Phase II' OR phase_ii_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of investigations that progressed to Phase II"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_change_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change control and change management metrics tracking change volume, approval cycle time, implementation effectiveness, and regulatory impact"
  source: "`genomics_biotech_ecm`.`quality`.`change_control`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (process, equipment, facility, document, system, material)"
    - name: "change_category"
      expr: change_category
      comment: "Category of change (major, minor, emergency, temporary)"
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change (initiated, assessment, approval, implementation, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change (low, medium, high, critical)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the change (low, medium, high)"
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Indicates whether the change has regulatory impact"
    - name: "validation_impact_flag"
      expr: validation_impact_flag
      comment: "Indicates whether the change impacts validated systems"
    - name: "training_impact_flag"
      expr: training_impact_flag
      comment: "Indicates whether the change requires training"
    - name: "document_impact_flag"
      expr: document_impact_flag
      comment: "Indicates whether the change impacts controlled documents"
    - name: "effectiveness_check_required_flag"
      expr: effectiveness_check_required_flag
      comment: "Indicates whether effectiveness check is required"
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of the effectiveness check (effective, not effective, partially effective)"
    - name: "initiator_department"
      expr: initiator_department
      comment: "Department that initiated the change"
    - name: "created_year"
      expr: YEAR(CAST(created_timestamp AS DATE))
      comment: "Year the change control was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', CAST(created_timestamp AS DATE))
      comment: "Month the change control was created"
  measures:
    - name: "total_changes"
      expr: COUNT(1)
      comment: "Total number of change controls"
    - name: "changes_with_regulatory_impact"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of changes with regulatory impact"
    - name: "changes_with_validation_impact"
      expr: COUNT(CASE WHEN validation_impact_flag = TRUE THEN 1 END)
      comment: "Number of changes impacting validated systems"
    - name: "changes_requiring_training"
      expr: COUNT(CASE WHEN training_impact_flag = TRUE THEN 1 END)
      comment: "Number of changes requiring training"
    - name: "changes_with_document_impact"
      expr: COUNT(CASE WHEN document_impact_flag = TRUE THEN 1 END)
      comment: "Number of changes impacting controlled documents"
    - name: "effective_changes"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'effective' THEN 1 END)
      comment: "Number of changes verified as effective"
    - name: "ineffective_changes"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'not effective' THEN 1 END)
      comment: "Number of changes found to be ineffective"
    - name: "closed_changes"
      expr: COUNT(CASE WHEN change_status = 'closed' THEN 1 END)
      comment: "Number of closed change controls"
    - name: "high_risk_changes"
      expr: COUNT(CASE WHEN risk_level = 'high' THEN 1 END)
      comment: "Number of high risk changes"
    - name: "emergency_changes"
      expr: COUNT(CASE WHEN change_category = 'emergency' THEN 1 END)
      comment: "Number of emergency changes"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_training_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training compliance and effectiveness metrics tracking training completion rates, assessment scores, qualification status, and overdue training"
  source: "`genomics_biotech_ecm`.`quality`.`training_record`"
  dimensions:
    - name: "training_type"
      expr: training_type
      comment: "Type of training (initial, refresher, requalification, ad-hoc)"
    - name: "training_category"
      expr: training_category
      comment: "Category of training (GMP, GLP, GCP, safety, technical, regulatory)"
    - name: "training_method"
      expr: training_method
      comment: "Method of training delivery (classroom, online, on-the-job, self-study)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status (qualified, not qualified, expired, pending)"
    - name: "assessment_required_flag"
      expr: assessment_required_flag
      comment: "Indicates whether assessment is required"
    - name: "training_location"
      expr: training_location
      comment: "Location where training was conducted"
    - name: "training_currency_code"
      expr: training_currency_code
      comment: "Currency code for training cost"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the training was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the training was completed"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year the training was scheduled"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total number of training records"
    - name: "completed_trainings"
      expr: COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END)
      comment: "Number of completed training records"
    - name: "qualified_personnel"
      expr: COUNT(CASE WHEN qualification_status = 'qualified' THEN 1 END)
      comment: "Number of qualified personnel"
    - name: "expired_qualifications"
      expr: COUNT(CASE WHEN qualification_status = 'expired' THEN 1 END)
      comment: "Number of expired qualifications"
    - name: "overdue_trainings"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND completion_date IS NULL THEN 1 END)
      comment: "Number of overdue training records"
    - name: "overdue_retrainings"
      expr: COUNT(CASE WHEN retraining_due_date < CURRENT_DATE() AND completion_date IS NULL THEN 1 END)
      comment: "Number of overdue retraining records"
    - name: "trainings_with_assessment"
      expr: COUNT(CASE WHEN assessment_required_flag = TRUE THEN 1 END)
      comment: "Number of trainings requiring assessment"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across all trainings"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration in hours"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost AS DOUBLE))
      comment: "Total cost of training programs"
    - name: "avg_training_cost"
      expr: AVG(CAST(training_cost AS DOUBLE))
      comment: "Average cost per training record"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`quality_validation_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Validation and qualification study metrics tracking validation completion, study status, deviation counts, and revalidation due dates"
  source: "`genomics_biotech_ecm`.`quality`.`validation_study`"
  dimensions:
    - name: "validation_type"
      expr: validation_type
      comment: "Type of validation (process, equipment, cleaning, method, computer system)"
    - name: "validation_subtype"
      expr: validation_subtype
      comment: "Subtype of validation (IQ, OQ, PQ, concurrent, retrospective, prospective)"
    - name: "study_status"
      expr: study_status
      comment: "Current status of the validation study (planned, in progress, completed, approved)"
    - name: "study_phase"
      expr: study_phase
      comment: "Phase of the study (protocol, execution, report, approval)"
    - name: "validation_conclusion"
      expr: validation_conclusion
      comment: "Conclusion of the validation study (validated, not validated, conditionally validated)"
    - name: "regulatory_standard"
      expr: regulatory_standard
      comment: "Regulatory standard followed (FDA, EMA, ICH, ISO, etc.)"
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Type of regulatory submission (NDA, ANDA, BLA, 510k, PMA, etc.)"
    - name: "capa_required"
      expr: capa_required
      comment: "Indicates whether CAPA is required based on validation findings"
    - name: "study_start_year"
      expr: YEAR(study_start_date)
      comment: "Year the validation study started"
    - name: "study_start_month"
      expr: DATE_TRUNC('MONTH', study_start_date)
      comment: "Month the validation study started"
  measures:
    - name: "total_validation_studies"
      expr: COUNT(1)
      comment: "Total number of validation studies"
    - name: "completed_studies"
      expr: COUNT(CASE WHEN study_status = 'completed' THEN 1 END)
      comment: "Number of completed validation studies"
    - name: "approved_studies"
      expr: COUNT(CASE WHEN study_status = 'approved' THEN 1 END)
      comment: "Number of approved validation studies"
    - name: "validated_systems"
      expr: COUNT(CASE WHEN validation_conclusion = 'validated' THEN 1 END)
      comment: "Number of systems successfully validated"
    - name: "not_validated_systems"
      expr: COUNT(CASE WHEN validation_conclusion = 'not validated' THEN 1 END)
      comment: "Number of systems that failed validation"
    - name: "studies_requiring_capa"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of validation studies requiring CAPA"
    - name: "total_deviation_count"
      expr: SUM(CAST(deviation_count AS DOUBLE))
      comment: "Total count of deviations across all validation studies"
    - name: "avg_deviation_count"
      expr: AVG(CAST(deviation_count AS DOUBLE))
      comment: "Average number of deviations per validation study"
    - name: "studies_with_qa_approval"
      expr: COUNT(CASE WHEN qa_approval_date IS NOT NULL THEN 1 END)
      comment: "Number of studies with QA approval"
    - name: "studies_with_regulatory_approval"
      expr: COUNT(CASE WHEN regulatory_approval_date IS NOT NULL THEN 1 END)
      comment: "Number of studies with regulatory approval"
    - name: "revalidations_due"
      expr: COUNT(CASE WHEN revalidation_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of systems with revalidation due or overdue"
$$;