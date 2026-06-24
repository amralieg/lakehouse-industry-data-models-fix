-- Metric views for domain: quality | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance Report (NCR) metrics tracking defect volumes, severity distribution, closure performance, and root cause patterns to drive quality improvement decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_type"
      expr: ncr_type
      comment: "Type of nonconformance (incoming, in-process, outgoing, field) for segmenting defect origin."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (open, under review, closed) for pipeline analysis."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance to prioritize response and resource allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category enabling systemic quality trend analysis."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (incoming inspection, production, customer) to assess detection effectiveness."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision (scrap, rework, use-as-is) for material cost impact analysis."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag indicating whether the NCR must be reported to a regulatory body, critical for compliance risk management."
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_timestamp)
      comment: "Month the NCR was reported, enabling trend analysis over time."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of nonconformance reports — primary volume KPI for quality performance dashboards."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of NCRs not yet closed, indicating current quality backlog and resolution capacity."
    - name: "regulatory_reportable_ncr_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of NCRs requiring regulatory reporting — critical compliance risk indicator."
    - name: "total_nonconforming_qty"
      expr: SUM(CAST(nonconforming_qty AS DOUBLE))
      comment: "Total quantity of nonconforming material across all NCRs, directly tied to scrap/rework cost exposure."
    - name: "avg_nonconforming_qty_per_ncr"
      expr: AVG(CAST(nonconforming_qty AS DOUBLE))
      comment: "Average nonconforming quantity per NCR, indicating typical defect batch size for process capability assessment."
    - name: "ncr_with_8d_required_count"
      expr: COUNT(CASE WHEN is_8d_required = TRUE THEN 1 END)
      comment: "Count of NCRs requiring 8D structured problem solving, indicating severity of systemic quality issues."
    - name: "closed_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END)
      comment: "Count of closed NCRs used as denominator for closure rate calculations in BI layer."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics measuring effectiveness, timeliness, and recurrence to evaluate the quality management system's ability to eliminate root causes."
  source: "`vibe_manufacturing_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs preventive) for understanding reactive vs proactive quality investment."
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (open, in-progress, closed, overdue) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA, enabling resource prioritization decisions."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category to identify systemic quality failure patterns across the organization."
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (NCR, customer complaint, audit, etc.) for origin analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the CAPA, enabling accountability and workload distribution analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the CAPA for site-level quality performance benchmarking."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the corrective action was verified as effective — key indicator of CAPA system maturity."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating the issue recurred after a prior CAPA, signaling systemic failure to eliminate root cause."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the CAPA was initiated for trend and aging analysis."
  measures:
    - name: "total_capa_count"
      expr: COUNT(1)
      comment: "Total number of CAPAs — baseline volume metric for quality management system load."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of open CAPAs representing unresolved quality risks requiring management attention."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN capa_status NOT IN ('Closed', 'Cancelled') AND target_closure_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of CAPAs past their target closure date — critical KPI for quality system compliance and audit readiness."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Count of CAPAs with verified effectiveness — numerator for effectiveness rate calculation in BI layer."
    - name: "recurrence_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs where the issue recurred, indicating systemic failure to eliminate root cause — drives escalation decisions."
    - name: "regulatory_impact_capa_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with regulatory impact, critical for compliance risk management and regulatory reporting."
    - name: "ppap_impact_capa_count"
      expr: COUNT(CASE WHEN ppap_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs affecting PPAP submissions, indicating risk to customer approval status."
    - name: "closed_capa_count"
      expr: COUNT(CASE WHEN capa_status = 'Closed' THEN 1 END)
      comment: "Count of closed CAPAs used as denominator for closure rate in BI layer."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics measuring incoming, in-process, and outgoing quality performance including pass rates, nonconforming quantities, and disposition outcomes to steer production and supplier quality."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type_code"
      expr: inspection_type_code
      comment: "Type of inspection (incoming goods, in-process, final, customer return) for segmenting quality performance by inspection stage."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail/conditional result of the inspection lot — primary quality outcome dimension."
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inspection lot (open, completed, released, rejected) for pipeline management."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition decision (accept, reject, rework, scrap) for material cost impact analysis."
    - name: "inspection_level"
      expr: inspection_level
      comment: "Inspection level (normal, tightened, reduced) indicating quality risk level per AQL sampling rules."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where inspection was performed for site-level quality benchmarking."
    - name: "ncr_triggered"
      expr: ncr_triggered
      comment: "Whether the inspection lot triggered an NCR, linking inspection outcomes to nonconformance management."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_start_timestamp)
      comment: "Month of inspection start for trend analysis of quality performance over time."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed — baseline throughput metric for quality operations capacity planning."
    - name: "failed_inspection_lots"
      expr: COUNT(CASE WHEN overall_result IN ('Fail', 'Rejected', 'FAIL') THEN 1 END)
      comment: "Count of inspection lots that failed — numerator for first-pass yield rate calculation in BI layer."
    - name: "ncr_triggered_lots"
      expr: COUNT(CASE WHEN ncr_triggered = TRUE THEN 1 END)
      comment: "Count of inspection lots that triggered an NCR, indicating defect escape rate into the quality system."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity of material inspected across all lots, enabling defect rate per unit calculations."
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Total nonconforming quantity across all inspection lots — directly tied to scrap and rework cost exposure."
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS DOUBLE))
      comment: "Average sample size per inspection lot, used to assess sampling plan adequacy and inspection cost efficiency."
    - name: "coc_required_lots"
      expr: COUNT(CASE WHEN certificate_of_conformance_required = TRUE THEN 1 END)
      comment: "Count of lots requiring a Certificate of Conformance, indicating customer-driven quality documentation burden."
    - name: "passed_inspection_lots"
      expr: COUNT(CASE WHEN overall_result IN ('Pass', 'Accepted', 'PASS') THEN 1 END)
      comment: "Count of passed inspection lots — denominator component for first-pass yield rate in BI layer."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics at the characteristic level measuring process capability, out-of-spec rates, and SPC performance to drive process improvement and product quality decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic measured (dimensional, functional, visual, chemical) for quality analysis segmentation."
    - name: "result_status"
      expr: result_status
      comment: "Pass/fail/conditional status of the individual inspection result — primary quality outcome at characteristic level."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (incoming, in-process, final) for quality gate performance analysis."
    - name: "is_out_of_spec"
      expr: is_out_of_spec
      comment: "Flag indicating the measured value exceeded specification limits — key driver of scrap and rework decisions."
    - name: "is_out_of_control"
      expr: is_out_of_control
      comment: "Flag indicating the process is statistically out of control per SPC rules — triggers process intervention."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant where the measurement was taken for site-level process capability benchmarking."
    - name: "spc_chart_type"
      expr: spc_chart_type
      comment: "Type of SPC chart used (Xbar-R, Xbar-S, p-chart, etc.) for statistical method analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of inspection for trend analysis of process capability and defect rates over time."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection results recorded — baseline volume for quality data completeness assessment."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_out_of_spec = TRUE THEN 1 END)
      comment: "Count of results exceeding specification limits — numerator for defect rate calculation, directly tied to scrap/rework cost."
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN is_out_of_control = TRUE THEN 1 END)
      comment: "Count of results triggering SPC out-of-control signals — drives immediate process intervention decisions."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average process capability index (Cpk) across all results — primary metric for process capability management and customer reporting."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average process potential index (Cp) indicating inherent process spread relative to specification width."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results for process centering analysis."
    - name: "total_defect_count_numeric"
      expr: SUM(CAST(defect_count AS DOUBLE))
      comment: "Total defect count across all inspection results, enabling defect density and DPU (defects per unit) calculations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics measuring complaint volumes, severity, resolution timeliness, and root cause patterns to protect customer satisfaction and revenue at risk."
  source: "`vibe_manufacturing_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (quality, delivery, documentation, service) for root cause segmentation."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, under investigation, closed) for pipeline and SLA management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the complaint (critical, major, minor) for prioritization and escalation decisions."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (portal, email, field, audit) for process improvement."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category enabling systemic analysis of recurring complaint drivers."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Specific failure mode reported by the customer for product and process improvement prioritization."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag indicating safety-related complaints requiring immediate escalation and regulatory consideration."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag indicating complaints requiring regulatory reporting — critical compliance risk indicator."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the complaint for site-level quality accountability."
    - name: "reported_month"
      expr: DATE_TRUNC('month', reported_date)
      comment: "Month complaint was reported for trend analysis and customer satisfaction tracking."
  measures:
    - name: "total_complaint_count"
      expr: COUNT(1)
      comment: "Total number of customer complaints — primary customer quality KPI for executive dashboards and customer scorecards."
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Closed', 'Cancelled') THEN 1 END)
      comment: "Count of unresolved complaints representing active customer satisfaction risk."
    - name: "safety_related_complaint_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Count of safety-related complaints — highest priority KPI requiring immediate executive attention and potential regulatory action."
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting, directly tied to compliance risk and potential liability."
    - name: "eight_d_complaint_count"
      expr: COUNT(CASE WHEN eight_d_report_number IS NOT NULL THEN 1 END)
      comment: "Count of complaints requiring 8D structured problem solving, indicating severity of systemic quality failures."
    - name: "closed_complaint_count"
      expr: COUNT(CASE WHEN complaint_status IN ('Closed') THEN 1 END)
      comment: "Count of closed complaints used as denominator for closure rate calculation in BI layer."
    - name: "distinct_customers_with_complaints"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Count of distinct customers who filed complaints — key customer relationship health indicator for account management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP (Production Part Approval Process) submission metrics measuring approval rates, submission timeliness, and resubmission patterns to manage new product launch quality risk."
  source: "`vibe_manufacturing_v1`.`quality`.`ppap_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the PPAP submission (submitted, approved, rejected, interim) for launch readiness tracking."
    - name: "submission_level"
      expr: submission_level
      comment: "PPAP submission level (1-5) indicating depth of documentation required by the customer."
    - name: "submission_reason"
      expr: submission_reason
      comment: "Reason for PPAP submission (new part, engineering change, tooling change) for change management analysis."
    - name: "psw_disposition"
      expr: psw_disposition
      comment: "Part Submission Warrant disposition (approved, interim, rejected) — primary PPAP outcome for launch go/no-go decisions."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase at time of submission for launch timeline management."
    - name: "is_safety_critical_part"
      expr: is_safety_critical_part
      comment: "Flag for safety-critical parts requiring heightened PPAP scrutiny and regulatory compliance."
    - name: "manufacturing_site"
      expr: manufacturing_site
      comment: "Manufacturing site for the submitted part, enabling site-level PPAP performance benchmarking."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of PPAP submission for launch pipeline and capacity planning."
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total PPAP submissions — baseline volume metric for new product launch pipeline management."
    - name: "approved_ppap_count"
      expr: COUNT(CASE WHEN psw_disposition = 'Approved' THEN 1 END)
      comment: "Count of fully approved PPAPs — numerator for PPAP first-time approval rate, a key launch quality KPI."
    - name: "rejected_ppap_count"
      expr: COUNT(CASE WHEN psw_disposition = 'Rejected' THEN 1 END)
      comment: "Count of rejected PPAP submissions indicating launch quality failures requiring rework and resubmission."
    - name: "interim_approval_count"
      expr: COUNT(CASE WHEN psw_disposition = 'Interim' THEN 1 END)
      comment: "Count of interim approvals indicating conditional launch risk that must be resolved before full production."
    - name: "safety_critical_ppap_count"
      expr: COUNT(CASE WHEN is_safety_critical_part = TRUE THEN 1 END)
      comment: "Count of PPAP submissions for safety-critical parts requiring heightened management oversight."
    - name: "avg_cpk_minimum"
      expr: AVG(CAST(cpk_minimum AS DOUBLE))
      comment: "Average minimum Cpk required across PPAP submissions, indicating customer process capability expectations."
    - name: "distinct_customers_with_ppap"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Count of distinct customers with active PPAP submissions, indicating new product launch breadth across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_spc`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statistical Process Control (SPC) chart metrics measuring process capability indices, control limit performance, and chart coverage to drive continuous improvement and process stability decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`spc`"
  dimensions:
    - name: "chart_type"
      expr: chart_type
      comment: "Type of SPC chart (Xbar-R, p-chart, c-chart, CUSUM, EWMA) for statistical method coverage analysis."
    - name: "chart_status"
      expr: chart_status
      comment: "Current status of the SPC chart (active, suspended, archived) for quality system coverage management."
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of characteristic monitored (dimensional, functional, process parameter) for SPC scope analysis."
    - name: "characteristic_criticality"
      expr: characteristic_criticality
      comment: "Criticality level of the monitored characteristic (safety, regulatory, key product) for risk-based SPC prioritization."
    - name: "ppap_submission_level"
      expr: ppap_submission_level
      comment: "PPAP level associated with the SPC chart, linking process control to customer approval requirements."
    - name: "nelson_rules_enabled"
      expr: nelson_rules_enabled
      comment: "Whether Nelson rules are enabled for out-of-control detection, indicating statistical rigor of the control system."
    - name: "effective_from_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the SPC chart became effective for tracking quality system maturity over time."
  measures:
    - name: "total_spc_charts"
      expr: COUNT(1)
      comment: "Total number of active SPC charts — baseline metric for statistical process control coverage breadth."
    - name: "active_spc_charts"
      expr: COUNT(CASE WHEN chart_status = 'Active' THEN 1 END)
      comment: "Count of currently active SPC charts indicating real-time process monitoring coverage."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average Cpk across all SPC charts — primary process capability KPI for executive quality dashboards and customer reporting."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average Cp (process potential) across all SPC charts, indicating inherent process spread vs specification width."
    - name: "avg_ppk_index"
      expr: AVG(CAST(ppk_index AS DOUBLE))
      comment: "Average Ppk (preliminary process capability) across SPC charts, used for new product launch capability assessment."
    - name: "avg_pp_index"
      expr: AVG(CAST(pp_index AS DOUBLE))
      comment: "Average Pp (preliminary process potential) across SPC charts for process performance benchmarking."
    - name: "charts_below_cpk_threshold"
      expr: COUNT(CASE WHEN cpk_index < 1.33 THEN 1 END)
      comment: "Count of SPC charts with Cpk below the industry standard 1.33 threshold — critical KPI identifying processes requiring immediate improvement investment."
    - name: "spc_center_line_avg"
      expr: AVG(CAST(center_line AS DOUBLE))
      comment: "Average center line value across SPC charts for process mean monitoring and drift detection."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics measuring audit completion rates, findings severity, CAPA response, and audit scores to evaluate quality management system effectiveness and compliance posture."
  source: "`vibe_manufacturing_v1`.`quality`.`quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of quality audit (internal, external, customer, regulatory) for compliance coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, completed, closed) for audit program execution tracking."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result (pass, conditional pass, fail) — primary outcome for quality system health assessment."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (process, product, system, compliance) for quality program portfolio management."
    - name: "standard"
      expr: standard
      comment: "Quality standard audited against (ISO 9001, IATF 16949, AS9100) for certification compliance tracking."
    - name: "audited_entity_type"
      expr: audited_entity_type
      comment: "Type of entity audited (department, process, product line) for organizational quality accountability."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating a re-audit is required due to findings, signaling quality system deficiencies."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month audit was planned to start for audit program scheduling and resource planning."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of quality audits — baseline metric for audit program execution completeness."
    - name: "completed_audits"
      expr: COUNT(CASE WHEN audit_status = 'Completed' THEN 1 END)
      comment: "Count of completed audits — numerator for audit completion rate, a key quality program KPI."
    - name: "failed_audits"
      expr: COUNT(CASE WHEN audit_result IN ('Fail', 'Failed') THEN 1 END)
      comment: "Count of failed audits indicating quality system non-compliance requiring immediate corrective action."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Count of audits requiring re-audit, indicating systemic quality system deficiencies."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all completed audits — primary quality system maturity KPI for executive reporting."
    - name: "avg_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average audit duration in days for resource planning and audit efficiency benchmarking."
    - name: "total_major_ncr_count"
      expr: SUM(CAST(major_ncr_count AS DOUBLE))
      comment: "Total major nonconformances found across all audits — critical indicator of quality system compliance risk."
    - name: "total_minor_ncr_count"
      expr: SUM(CAST(minor_ncr_count AS DOUBLE))
      comment: "Total minor nonconformances found across all audits for quality improvement prioritization."
    - name: "capa_required_audits"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of audits requiring CAPA, indicating the volume of systemic quality issues requiring structured resolution."
    - name: "total_checklist_items_sum"
      expr: SUM(CAST(total_checklist_items AS DOUBLE))
      comment: "Total checklist items evaluated across all audits, indicating audit thoroughness and scope coverage."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_supplier_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality audit metrics measuring supplier compliance scores, finding rates, and CAPA response to drive supplier development and supply chain quality risk management."
  source: "`vibe_manufacturing_v1`.`quality`.`supplier_quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of supplier audit (initial qualification, surveillance, re-qualification, for-cause) for supplier lifecycle management."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the supplier audit for pipeline and program execution tracking."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall supplier audit result (approved, conditional, rejected) — primary supplier qualification outcome."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Standard audited against (ISO 9001, IATF 16949, AS9100) for supplier certification compliance tracking."
    - name: "supplier_qualification_level"
      expr: supplier_qualification_level
      comment: "Supplier qualification level (approved, preferred, restricted, disqualified) for sourcing decision support."
    - name: "supplier_facility_country"
      expr: supplier_facility_country
      comment: "Country of the audited supplier facility for geographic supply chain risk analysis."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating re-audit is required, signaling supplier quality risk requiring follow-up investment."
    - name: "ppap_assessment_included"
      expr: ppap_assessment_included
      comment: "Whether PPAP assessment was included in the audit, indicating depth of supplier quality evaluation."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the supplier audit was planned for audit program scheduling and resource planning."
  measures:
    - name: "total_supplier_audits"
      expr: COUNT(1)
      comment: "Total supplier quality audits conducted — baseline metric for supplier quality program coverage."
    - name: "approved_supplier_audits"
      expr: COUNT(CASE WHEN audit_result IN ('Approved', 'Pass') THEN 1 END)
      comment: "Count of supplier audits resulting in approval — numerator for supplier approval rate, key supply chain quality KPI."
    - name: "rejected_supplier_audits"
      expr: COUNT(CASE WHEN audit_result IN ('Rejected', 'Fail') THEN 1 END)
      comment: "Count of failed supplier audits indicating supply chain quality risk requiring sourcing decisions."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average supplier audit score — primary supplier quality performance KPI for supplier scorecards and sourcing decisions."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Count of supplier audits requiring re-audit, indicating suppliers with unresolved quality risks."
    - name: "total_major_ncr_count"
      expr: SUM(CAST(major_ncr_count AS DOUBLE))
      comment: "Total major nonconformances found across supplier audits — critical supply chain quality risk indicator."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average supplier audit duration for resource planning and audit efficiency benchmarking."
    - name: "distinct_suppliers_audited"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Count of distinct suppliers audited — indicates supplier quality program coverage breadth across the supply base."
    - name: "capa_required_audits"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Count of supplier audits requiring CAPA, indicating volume of supplier quality issues requiring structured resolution."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FMEA (Failure Mode and Effects Analysis) metrics measuring risk priority, action completion, and safety-critical coverage to drive proactive quality risk reduction decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`fmea`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (Design FMEA, Process FMEA, System FMEA) for risk analysis portfolio management."
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current status of the FMEA (draft, approved, under review, obsolete) for quality documentation governance."
    - name: "action_priority"
      expr: action_priority
      comment: "Action priority level (high, medium, low) for resource allocation to risk reduction activities."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Flag indicating safety-critical failure modes requiring mandatory risk mitigation actions."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating failure modes with regulatory compliance implications for compliance risk management."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the FMEA for site-level risk management accountability."
    - name: "fmea_type_scope"
      expr: scope
      comment: "Scope of the FMEA analysis for understanding coverage breadth of risk assessments."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month FMEA was initiated for tracking risk analysis activity over time."
  measures:
    - name: "total_fmea_count"
      expr: COUNT(1)
      comment: "Total number of FMEAs — baseline metric for risk analysis program coverage."
    - name: "safety_critical_fmea_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Count of FMEAs covering safety-critical failure modes — highest priority risk management KPI."
    - name: "high_priority_action_count"
      expr: COUNT(CASE WHEN action_priority IN ('High', 'HIGH', 'Critical') THEN 1 END)
      comment: "Count of FMEAs with high-priority actions outstanding, indicating unmitigated risk requiring immediate resource allocation."
    - name: "overdue_fmea_count"
      expr: COUNT(CASE WHEN fmea_status NOT IN ('Approved', 'Closed', 'Obsolete') AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of FMEAs past their target completion date, indicating risk analysis backlog and governance gaps."
    - name: "regulatory_compliance_fmea_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Count of FMEAs with regulatory compliance implications, critical for compliance risk portfolio management."
    - name: "distinct_parts_with_fmea"
      expr: COUNT(DISTINCT part_number)
      comment: "Count of distinct parts covered by FMEAs, indicating risk analysis coverage breadth across the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_apqp_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APQP (Advanced Product Quality Planning) project metrics measuring launch readiness, gate review status, and PPAP completion to manage new product introduction quality risk."
  source: "`vibe_manufacturing_v1`.`quality`.`apqp_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the APQP project (active, on-hold, completed, cancelled) for launch pipeline management."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "Current APQP phase (1-5) indicating stage of new product quality planning for launch readiness tracking."
    - name: "project_type"
      expr: project_type
      comment: "Type of APQP project (new product, engineering change, resourcing) for portfolio segmentation."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the APQP project for prioritization of quality planning resources."
    - name: "ppap_status"
      expr: ppap_status
      comment: "PPAP status within the APQP project for launch gate management."
    - name: "customer_approval_status"
      expr: customer_approval_status
      comment: "Customer approval status for the APQP project — critical launch go/no-go indicator."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP level required by the customer for this project, indicating documentation and approval depth."
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month the APQP project was planned to start for launch pipeline and capacity planning."
  measures:
    - name: "total_apqp_projects"
      expr: COUNT(1)
      comment: "Total APQP projects — baseline metric for new product introduction pipeline volume."
    - name: "active_apqp_projects"
      expr: COUNT(CASE WHEN project_status = 'Active' THEN 1 END)
      comment: "Count of currently active APQP projects indicating new product launch workload."
    - name: "overdue_apqp_projects"
      expr: COUNT(CASE WHEN project_status NOT IN ('Completed', 'Cancelled') AND planned_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Count of APQP projects past planned completion date — critical launch risk KPI for executive escalation."
    - name: "customer_approved_projects"
      expr: COUNT(CASE WHEN customer_approval_status IN ('Approved', 'Conditionally Approved') THEN 1 END)
      comment: "Count of APQP projects with customer approval, indicating successful launch readiness achievement."
    - name: "high_risk_projects"
      expr: COUNT(CASE WHEN risk_level IN ('High', 'Critical') THEN 1 END)
      comment: "Count of high-risk APQP projects requiring heightened management attention and resource allocation."
    - name: "lessons_learned_documented_count"
      expr: COUNT(CASE WHEN lessons_learned_documented = TRUE THEN 1 END)
      comment: "Count of APQP projects with documented lessons learned, indicating organizational learning maturity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_rma_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RMA disposition metrics measuring return volumes, credit exposure, repair outcomes, and root cause patterns to manage customer return costs and drive product quality improvements."
  source: "`vibe_manufacturing_v1`.`quality`.`rma_disposition`"
  dimensions:
    - name: "rma_type"
      expr: rma_type
      comment: "Type of RMA (warranty, quality, commercial, field return) for return cost categorization."
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA disposition (received, under inspection, completed) for return pipeline management."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision (scrap, repair, return to customer, credit) for cost impact analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the returned product failure for product improvement prioritization."
    - name: "failure_code_confirmed"
      expr: failure_code_confirmed
      comment: "Confirmed failure code after inspection for warranty and quality cost analysis."
    - name: "warranty_claim_flag"
      expr: warranty_claim_flag
      comment: "Flag indicating the return is a warranty claim, directly tied to warranty cost exposure."
    - name: "supplier_responsibility_flag"
      expr: supplier_responsibility_flag
      comment: "Flag indicating supplier responsibility for the defect, enabling supplier chargeback and development decisions."
    - name: "receiving_plant_code"
      expr: receiving_plant_code
      comment: "Plant receiving the returned material for site-level return volume analysis."
    - name: "return_month"
      expr: DATE_TRUNC('month', return_initiated_date)
      comment: "Month the return was initiated for trend analysis of return rates over time."
  measures:
    - name: "total_rma_dispositions"
      expr: COUNT(1)
      comment: "Total RMA dispositions processed — baseline metric for return volume and quality cost exposure."
    - name: "total_quantity_returned"
      expr: SUM(CAST(quantity_returned AS DOUBLE))
      comment: "Total quantity of material returned across all RMAs — directly tied to warranty and quality cost exposure."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for returned material — primary financial KPI for warranty and quality cost management."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per RMA disposition for warranty cost benchmarking and reserve planning."
    - name: "warranty_claim_count"
      expr: COUNT(CASE WHEN warranty_claim_flag = TRUE THEN 1 END)
      comment: "Count of warranty claims — key financial KPI for warranty reserve adequacy and product reliability assessment."
    - name: "supplier_responsibility_count"
      expr: COUNT(CASE WHEN supplier_responsibility_flag = TRUE THEN 1 END)
      comment: "Count of returns attributed to supplier responsibility, enabling supplier chargeback and development prioritization."
    - name: "capa_required_rma_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Count of RMA dispositions requiring CAPA, indicating systemic product quality issues requiring structured resolution."
    - name: "distinct_customers_with_returns"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Count of distinct customers with RMA returns — customer satisfaction risk indicator for account management."
$$;