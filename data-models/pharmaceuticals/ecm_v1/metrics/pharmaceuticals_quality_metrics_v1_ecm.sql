-- Metric views for domain: quality | Business: Pharmaceuticals | Version: 1 | Generated on: 2026-05-05 17:46:18

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_deviation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core quality deviation metrics tracking GMP impact, regulatory reportability, and investigation cycle times for manufacturing and supply chain quality events"
  source: "`pharmaceuticals_ecm`.`quality`.`quality_deviation`"
  dimensions:
    - name: "deviation_status"
      expr: deviation_status
      comment: "Current lifecycle status of the quality deviation (Open, Under Investigation, Closed, etc.)"
    - name: "deviation_type"
      expr: deviation_type
      comment: "Classification of deviation type (Process, Documentation, Equipment, Material, etc.)"
    - name: "deviation_category"
      expr: deviation_category
      comment: "Business category of the deviation for trend analysis"
    - name: "gmp_impact_classification"
      expr: gmp_impact_classification
      comment: "GMP impact severity classification (Critical, Major, Minor) for regulatory risk assessment"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating whether deviation requires regulatory authority notification"
    - name: "audit_finding_flag"
      expr: audit_finding_flag
      comment: "Boolean flag indicating deviation originated from audit finding"
    - name: "customer_complaint_flag"
      expr: customer_complaint_flag
      comment: "Boolean flag indicating deviation linked to customer complaint"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month when deviation was first detected, for trend analysis"
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month when deviation actually occurred, for root cause timing analysis"
    - name: "facility_code"
      expr: facility_code
      comment: "Manufacturing facility or site code where deviation occurred"
    - name: "process_step"
      expr: process_step
      comment: "Specific manufacturing or quality process step where deviation occurred"
  measures:
    - name: "total_deviations"
      expr: COUNT(1)
      comment: "Total count of quality deviations for volume trending and workload management"
    - name: "critical_gmp_deviation_count"
      expr: COUNT(CASE WHEN gmp_impact_classification = 'Critical' THEN 1 END)
      comment: "Count of critical GMP impact deviations requiring immediate executive attention and regulatory notification"
    - name: "regulatory_reportable_deviation_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of deviations requiring regulatory authority notification, key compliance metric"
    - name: "audit_finding_deviation_count"
      expr: COUNT(CASE WHEN audit_finding_flag = TRUE THEN 1 END)
      comment: "Count of deviations originating from audit findings, indicating systemic quality system gaps"
    - name: "customer_complaint_deviation_count"
      expr: COUNT(CASE WHEN customer_complaint_flag = TRUE THEN 1 END)
      comment: "Count of deviations linked to customer complaints, indicating market-facing quality issues"
    - name: "avg_investigation_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(investigation_completed_date, detected_date) AS DOUBLE))
      comment: "Average days from deviation detection to investigation completion, key operational efficiency metric"
    - name: "avg_closure_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(closure_date, detected_date) AS DOUBLE))
      comment: "Average days from deviation detection to final closure, measures end-to-end resolution efficiency"
    - name: "overdue_investigation_count"
      expr: COUNT(CASE WHEN investigation_due_date < CURRENT_DATE() AND investigation_completed_date IS NULL THEN 1 END)
      comment: "Count of deviations with overdue investigations, critical for compliance risk management"
    - name: "regulatory_reportable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations requiring regulatory reporting, indicates quality system maturity and regulatory risk exposure"
    - name: "critical_gmp_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_impact_classification = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deviations classified as critical GMP impact, key quality performance indicator for manufacturing excellence"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) effectiveness metrics tracking closure rates, cycle times, and regulatory commitment fulfillment"
  source: "`pharmaceuticals_ecm`.`quality`.`quality_capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current lifecycle status of CAPA (Open, In Progress, Closed, Overdue)"
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (Corrective, Preventive, Combined) for action classification"
    - name: "originating_event_type"
      expr: originating_event_type
      comment: "Type of quality event that triggered the CAPA (Deviation, Audit, Complaint, OOS, etc.)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk severity level (High, Medium, Low) for prioritization and resource allocation"
    - name: "severity"
      expr: severity
      comment: "Business impact severity classification of the CAPA"
    - name: "regulatory_commitment_flag"
      expr: regulatory_commitment_flag
      comment: "Boolean flag indicating CAPA is a regulatory commitment requiring strict deadline adherence"
    - name: "effectiveness_check_required_flag"
      expr: effectiveness_check_required_flag
      comment: "Boolean flag indicating whether effectiveness verification is required post-implementation"
    - name: "effectiveness_check_result"
      expr: effectiveness_check_result
      comment: "Result of effectiveness check (Effective, Ineffective, Pending) for CAPA quality assessment"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month when CAPA was initiated, for workload and trend analysis"
    - name: "department"
      expr: department
      comment: "Responsible department or functional area for CAPA ownership tracking"
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Methodology used for root cause analysis (5 Why, Fishbone, Fault Tree, etc.)"
  measures:
    - name: "total_capas"
      expr: COUNT(1)
      comment: "Total count of CAPAs for workload management and quality system activity tracking"
    - name: "regulatory_commitment_capa_count"
      expr: COUNT(CASE WHEN regulatory_commitment_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs tied to regulatory commitments, critical for compliance risk management"
    - name: "high_risk_capa_count"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Count of high-risk CAPAs requiring executive oversight and accelerated resolution"
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN target_completion_date < CURRENT_DATE() AND closure_date IS NULL THEN 1 END)
      comment: "Count of CAPAs past target completion date without closure, key compliance and operational risk metric"
    - name: "closed_capa_count"
      expr: COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END)
      comment: "Count of closed CAPAs for completion rate calculation"
    - name: "avg_capa_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, initiated_date) AS DOUBLE))
      comment: "Average days from CAPA initiation to actual completion, measures operational efficiency"
    - name: "avg_capa_closure_time_days"
      expr: AVG(CAST(DATEDIFF(closure_date, initiated_date) AS DOUBLE))
      comment: "Average days from CAPA initiation to final closure including effectiveness check, end-to-end cycle time"
    - name: "effectiveness_check_completion_count"
      expr: COUNT(CASE WHEN effectiveness_check_date IS NOT NULL THEN 1 END)
      comment: "Count of CAPAs with completed effectiveness checks for quality assurance tracking"
    - name: "effective_capa_count"
      expr: COUNT(CASE WHEN effectiveness_check_result = 'Effective' THEN 1 END)
      comment: "Count of CAPAs verified as effective, measures quality of corrective actions"
    - name: "capa_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CAPAs closed, key performance indicator for quality system responsiveness"
    - name: "capa_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_check_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_check_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of checked CAPAs verified as effective, measures quality of root cause analysis and corrective action design"
    - name: "regulatory_commitment_overdue_count"
      expr: COUNT(CASE WHEN regulatory_commitment_flag = TRUE AND target_completion_date < CURRENT_DATE() AND closure_date IS NULL THEN 1 END)
      comment: "Count of overdue regulatory commitment CAPAs, critical compliance risk indicator requiring immediate escalation"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_batch_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release and rejection metrics tracking manufacturing quality outcomes, regulatory holds, and product disposition decisions"
  source: "`pharmaceuticals_ecm`.`quality`.`batch_disposition`"
  dimensions:
    - name: "disposition_status"
      expr: disposition_status
      comment: "Final disposition decision status (Released, Rejected, Quarantine, Pending)"
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition action taken (Full Release, Partial Release, Destruction, Rework, etc.)"
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Current quarantine hold status for batches under investigation"
    - name: "regulatory_hold_flag"
      expr: regulatory_hold_flag
      comment: "Boolean flag indicating batch is under regulatory authority hold"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating disposition requires regulatory authority notification"
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month of disposition decision for trend analysis and reporting"
    - name: "manufacturing_month"
      expr: DATE_TRUNC('MONTH', manufacturing_date)
      comment: "Month of batch manufacturing for cycle time and aging analysis"
    - name: "batch_size_uom"
      expr: batch_size_uom
      comment: "Unit of measure for batch size (kg, L, units, etc.) for volume normalization"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total count of batch dispositions for manufacturing throughput tracking"
    - name: "released_batch_count"
      expr: COUNT(CASE WHEN disposition_status = 'Released' THEN 1 END)
      comment: "Count of batches released to market, key manufacturing success metric"
    - name: "rejected_batch_count"
      expr: COUNT(CASE WHEN disposition_status = 'Rejected' THEN 1 END)
      comment: "Count of batches rejected, critical quality failure indicator impacting supply and financials"
    - name: "regulatory_hold_batch_count"
      expr: COUNT(CASE WHEN regulatory_hold_flag = TRUE THEN 1 END)
      comment: "Count of batches under regulatory hold, indicates compliance issues requiring immediate attention"
    - name: "regulatory_reportable_batch_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of batch dispositions requiring regulatory notification, compliance risk metric"
    - name: "total_batch_size"
      expr: SUM(CAST(batch_size AS DOUBLE))
      comment: "Total batch size across all dispositions for volume-based yield analysis"
    - name: "released_quantity_total"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity released to market, measures manufacturing output and supply fulfillment"
    - name: "rejected_quantity_total"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected, measures quality loss and financial impact"
    - name: "avg_disposition_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(disposition_date, manufacturing_date) AS DOUBLE))
      comment: "Average days from manufacturing to disposition decision, measures quality review efficiency and inventory aging"
    - name: "batch_release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_status = 'Released' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches released, primary manufacturing quality KPI and right-first-time indicator"
    - name: "batch_rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disposition_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of batches rejected, critical quality performance indicator impacting supply continuity and cost"
    - name: "quantity_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(released_quantity AS DOUBLE)) / NULLIF(SUM(CAST(batch_size AS DOUBLE)), 0), 2)
      comment: "Percentage of manufactured quantity released to market, measures manufacturing efficiency and quality yield"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_oos_investigation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Out-of-Specification (OOS) investigation metrics tracking laboratory error rates, root cause identification, and regulatory reporting for analytical quality events"
  source: "`pharmaceuticals_ecm`.`quality`.`oos_investigation`"
  dimensions:
    - name: "investigation_status"
      expr: investigation_status
      comment: "Current status of OOS investigation (Open, Phase I, Phase II, Closed)"
    - name: "laboratory_error_identified"
      expr: laboratory_error_identified
      comment: "Boolean flag indicating laboratory error was identified as root cause"
    - name: "root_cause_identified"
      expr: root_cause_identified
      comment: "Boolean flag indicating definitive root cause was identified"
    - name: "phase_ii_required"
      expr: phase_ii_required
      comment: "Boolean flag indicating Phase II extended investigation is required"
    - name: "regulatory_reporting_required"
      expr: regulatory_reporting_required
      comment: "Boolean flag indicating OOS requires regulatory authority notification"
    - name: "retest_authorized"
      expr: retest_authorized
      comment: "Boolean flag indicating retest was authorized per investigation protocol"
    - name: "batch_disposition"
      expr: batch_disposition
      comment: "Final batch disposition decision resulting from OOS investigation (Release, Reject, Rework)"
    - name: "assignability_determination"
      expr: assignability_determination
      comment: "Determination of whether OOS is assignable to laboratory error or product/process issue"
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month when OOS investigation was initiated for trend analysis"
    - name: "test_parameter"
      expr: test_parameter
      comment: "Analytical test parameter that failed specification (Assay, Impurity, Dissolution, etc.)"
    - name: "test_method"
      expr: test_method
      comment: "Analytical test method used for the OOS result"
  measures:
    - name: "total_oos_investigations"
      expr: COUNT(1)
      comment: "Total count of OOS investigations for analytical quality performance tracking"
    - name: "laboratory_error_oos_count"
      expr: COUNT(CASE WHEN laboratory_error_identified = TRUE THEN 1 END)
      comment: "Count of OOS investigations attributed to laboratory error, indicates analytical quality system issues"
    - name: "root_cause_identified_count"
      expr: COUNT(CASE WHEN root_cause_identified = TRUE THEN 1 END)
      comment: "Count of OOS investigations with definitive root cause, measures investigation effectiveness"
    - name: "phase_ii_investigation_count"
      expr: COUNT(CASE WHEN phase_ii_required = TRUE THEN 1 END)
      comment: "Count of OOS requiring Phase II extended investigation, indicates complex quality issues"
    - name: "regulatory_reportable_oos_count"
      expr: COUNT(CASE WHEN regulatory_reporting_required = TRUE THEN 1 END)
      comment: "Count of OOS requiring regulatory notification, critical compliance metric"
    - name: "retest_authorized_count"
      expr: COUNT(CASE WHEN retest_authorized = TRUE THEN 1 END)
      comment: "Count of OOS investigations where retest was authorized, indicates potential laboratory error"
    - name: "batch_rejected_due_to_oos_count"
      expr: COUNT(CASE WHEN batch_disposition = 'Reject' THEN 1 END)
      comment: "Count of batches rejected due to OOS, measures quality impact on supply and financials"
    - name: "avg_phase_i_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(phase_i_completion_date, phase_i_start_date) AS DOUBLE))
      comment: "Average days to complete Phase I investigation, measures initial investigation efficiency"
    - name: "avg_phase_ii_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(phase_ii_completion_date, phase_ii_start_date) AS DOUBLE))
      comment: "Average days to complete Phase II investigation, measures extended investigation efficiency"
    - name: "avg_total_investigation_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(investigation_closed_date, initiated_date) AS DOUBLE))
      comment: "Average days from OOS initiation to investigation closure, end-to-end cycle time metric"
    - name: "laboratory_error_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN laboratory_error_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS attributed to laboratory error, key analytical quality system performance indicator"
    - name: "root_cause_identification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN root_cause_identified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OOS investigations with identified root cause, measures investigation quality and effectiveness"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product complaint metrics tracking customer-reported quality issues, regulatory reportability, investigation outcomes, and patient safety impact"
  source: "`pharmaceuticals_ecm`.`quality`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current lifecycle status of complaint (Open, Under Investigation, Closed)"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Primary category of complaint (Product Quality, Packaging, Labeling, Adverse Event, etc.)"
    - name: "subcategory"
      expr: subcategory
      comment: "Detailed subcategory for granular complaint classification and trending"
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel of complaint (Customer, Healthcare Professional, Distributor, Regulatory Authority, etc.)"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Boolean flag indicating complaint requires regulatory authority notification"
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Boolean flag indicating formal investigation is required"
    - name: "patient_impact_flag"
      expr: patient_impact_flag
      comment: "Boolean flag indicating complaint involves patient safety impact"
    - name: "trend_flag"
      expr: trend_flag
      comment: "Boolean flag indicating complaint is part of identified trend requiring systemic action"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when complaint was received for trend analysis and reporting"
    - name: "occurrence_month"
      expr: DATE_TRUNC('MONTH', occurrence_date)
      comment: "Month when complaint event occurred for lag analysis"
    - name: "market_of_origin"
      expr: market_of_origin
      comment: "Geographic market where complaint originated for regional quality tracking"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (Manufacturing, Material, Design, Handling, etc.)"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total count of product complaints for customer quality performance tracking"
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory notification, critical compliance and safety metric"
    - name: "patient_impact_complaint_count"
      expr: COUNT(CASE WHEN patient_impact_flag = TRUE THEN 1 END)
      comment: "Count of complaints with patient safety impact, highest priority quality issue requiring immediate action"
    - name: "trend_complaint_count"
      expr: COUNT(CASE WHEN trend_flag = TRUE THEN 1 END)
      comment: "Count of complaints identified as part of systemic trend, indicates recurring quality issues"
    - name: "investigation_required_complaint_count"
      expr: COUNT(CASE WHEN investigation_required_flag = TRUE THEN 1 END)
      comment: "Count of complaints requiring formal investigation for resource planning"
    - name: "closed_complaint_count"
      expr: COUNT(CASE WHEN complaint_status = 'Closed' THEN 1 END)
      comment: "Count of closed complaints for closure rate calculation"
    - name: "avg_complaint_response_time_days"
      expr: AVG(CAST(DATEDIFF(response_date, received_date) AS DOUBLE))
      comment: "Average days from complaint receipt to customer response, measures customer service quality"
    - name: "avg_complaint_closure_time_days"
      expr: AVG(CAST(DATEDIFF(closure_date, received_date) AS DOUBLE))
      comment: "Average days from complaint receipt to final closure, end-to-end resolution cycle time"
    - name: "avg_investigation_cycle_time_days"
      expr: AVG(CAST(DATEDIFF(closure_date, investigation_start_date) AS DOUBLE))
      comment: "Average days from investigation start to complaint closure for investigation efficiency tracking"
    - name: "complaint_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN complaint_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints closed, measures complaint handling efficiency and backlog management"
    - name: "regulatory_reportable_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints requiring regulatory reporting, indicates severity of customer-facing quality issues"
    - name: "patient_impact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints with patient safety impact, critical patient safety and product quality indicator"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit and inspection metrics tracking regulatory findings, CAPA requirements, and audit outcome trends for compliance risk management"
  source: "`pharmaceuticals_ecm`.`quality`.`audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of audit (Planned, In Progress, Report Issued, Closed)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (Internal, Supplier, Regulatory, Customer, etc.)"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Specific inspection classification (Pre-Approval, Routine, For-Cause, etc.)"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Regulatory authority conducting inspection (FDA, EMA, MHRA, etc.)"
    - name: "overall_audit_outcome"
      expr: overall_audit_outcome
      comment: "Final audit outcome classification (Acceptable, Voluntary Action Indicated, Official Action Indicated)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to audited entity (High, Medium, Low)"
    - name: "capa_required"
      expr: capa_required
      comment: "Boolean flag indicating CAPA is required from audit findings"
    - name: "form_483_issued"
      expr: form_483_issued
      comment: "Boolean flag indicating FDA Form 483 was issued, indicates regulatory observations"
    - name: "warning_letter_issued"
      expr: warning_letter_issued
      comment: "Boolean flag indicating regulatory warning letter was issued, critical compliance failure"
    - name: "audit_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when audit started for trend analysis and planning"
    - name: "closure_verification_status"
      expr: closure_verification_status
      comment: "Status of CAPA closure verification (Verified, Pending, Not Verified)"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total count of audits for compliance program activity tracking"
    - name: "regulatory_audit_count"
      expr: COUNT(CASE WHEN audit_type = 'Regulatory' THEN 1 END)
      comment: "Count of regulatory authority audits, critical compliance risk indicator"
    - name: "form_483_issued_count"
      expr: COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END)
      comment: "Count of audits resulting in FDA Form 483, indicates regulatory observations requiring response"
    - name: "warning_letter_issued_count"
      expr: COUNT(CASE WHEN warning_letter_issued = TRUE THEN 1 END)
      comment: "Count of audits resulting in warning letter, critical compliance failure requiring immediate executive action"
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of audits requiring CAPA for workload planning and quality system improvement tracking"
    - name: "high_risk_audit_count"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN 1 END)
      comment: "Count of audits with high risk rating, indicates entities requiring enhanced oversight"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total count of critical audit findings across all audits, highest severity observations requiring immediate action"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS DOUBLE))
      comment: "Total count of major audit findings, significant quality system gaps requiring formal CAPA"
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS DOUBLE))
      comment: "Total count of minor audit findings for continuous improvement tracking"
    - name: "avg_critical_findings_per_audit"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average critical findings per audit, measures quality system maturity and compliance risk"
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(DATEDIFF(end_date, start_date) AS DOUBLE))
      comment: "Average audit duration in days for resource planning and efficiency tracking"
    - name: "form_483_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN form_483_issued = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN audit_type = 'Regulatory' THEN 1 END), 0), 2)
      comment: "Percentage of regulatory audits resulting in Form 483, key regulatory compliance performance indicator"
$$;

CREATE OR REPLACE VIEW `pharmaceuticals_ecm`.`_metrics`.`quality_stability_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stability study metrics tracking shelf life validation, storage condition performance, and out-of-trend results for product lifecycle management"
  source: "`pharmaceuticals_ecm`.`quality`.`stability_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of stability study (Ongoing, Completed, On Hold, Cancelled)"
    - name: "study_type"
      expr: study_type
      comment: "Type of stability study (Long-term, Accelerated, Intermediate, Stress, Photostability, etc.)"
    - name: "storage_condition"
      expr: storage_condition
      comment: "Storage condition for study (25C/60%RH, 30C/65%RH, 40C/75%RH, 5C, etc.)"
    - name: "regulatory_commitment_flag"
      expr: regulatory_commitment_flag
      comment: "Boolean flag indicating study is a regulatory commitment requiring strict protocol adherence"
    - name: "oot_flag"
      expr: oot_flag
      comment: "Boolean flag indicating out-of-trend results detected requiring investigation"
    - name: "overall_pass_fail_status"
      expr: overall_pass_fail_status
      comment: "Overall study outcome (Pass, Fail, Ongoing) for shelf life validation"
    - name: "study_start_month"
      expr: DATE_TRUNC('MONTH', study_start_date)
      comment: "Month when stability study started for timeline tracking"
    - name: "container_closure_system"
      expr: container_closure_system
      comment: "Container closure system under study for packaging qualification"
  measures:
    - name: "total_stability_studies"
      expr: COUNT(1)
      comment: "Total count of stability studies for product lifecycle management tracking"
    - name: "regulatory_commitment_study_count"
      expr: COUNT(CASE WHEN regulatory_commitment_flag = TRUE THEN 1 END)
      comment: "Count of stability studies tied to regulatory commitments, critical for compliance and market authorization maintenance"
    - name: "oot_study_count"
      expr: COUNT(CASE WHEN oot_flag = TRUE THEN 1 END)
      comment: "Count of studies with out-of-trend results, indicates potential product stability issues requiring investigation"
    - name: "failed_study_count"
      expr: COUNT(CASE WHEN overall_pass_fail_status = 'Fail' THEN 1 END)
      comment: "Count of failed stability studies, critical product quality issue impacting shelf life and market authorization"
    - name: "completed_study_count"
      expr: COUNT(CASE WHEN study_status = 'Completed' THEN 1 END)
      comment: "Count of completed stability studies for program completion tracking"
    - name: "avg_study_duration_months"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, study_start_date) AS DOUBLE) / 30.0)
      comment: "Average stability study duration in months for program planning and resource allocation"
    - name: "avg_shelf_life_months"
      expr: AVG(CAST(shelf_life_months AS DOUBLE))
      comment: "Average approved shelf life in months across studies, measures product stability performance"
    - name: "study_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN study_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stability studies completed, measures program execution efficiency"
    - name: "study_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(CASE WHEN overall_pass_fail_status IN ('Pass', 'Fail') THEN 1 END), 0), 2)
      comment: "Percentage of completed studies passing acceptance criteria, key product quality and formulation robustness indicator"
    - name: "oot_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN oot_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of studies with out-of-trend results, indicates stability testing quality and product consistency"
$$;