-- Metric views for domain: quality | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance Report (NCR) metrics tracking volume, severity, disposition outcomes, and closure performance. Core quality KPI layer for manufacturing nonconformance management."
  source: "`vibe_manufacturing_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_type"
      expr: ncr_type
      comment: "Type of nonconformance (e.g., incoming, in-process, outgoing) for segmenting NCR volume by origin."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current workflow status of the NCR (e.g., open, closed, under review) for pipeline analysis."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance (e.g., critical, major, minor) for risk prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (e.g., process, material, human error) for Pareto analysis."
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code for trend analysis and recurring defect identification."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision (e.g., scrap, rework, use-as-is) for cost and yield impact analysis."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (e.g., incoming inspection, customer, in-process) for detection effectiveness analysis."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag indicating whether the NCR requires regulatory reporting, critical for compliance tracking."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month the NCR was reported, used for trend and volume analysis over time."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month the nonconformance was detected, used for detection lag and trend analysis."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Primary volume KPI for nonconformance management dashboards."
    - name: "total_nonconforming_qty"
      expr: SUM(CAST(nonconforming_qty AS DOUBLE))
      comment: "Total quantity of nonconforming units across all NCRs. Drives scrap/rework cost estimation and yield analysis."
    - name: "avg_nonconforming_qty_per_ncr"
      expr: AVG(CAST(nonconforming_qty AS DOUBLE))
      comment: "Average nonconforming quantity per NCR. Indicates severity of individual nonconformance events."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Number of currently open NCRs. Key operational KPI for backlog management and quality team workload."
    - name: "regulatory_reportable_ncr_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of NCRs flagged as regulatory reportable. Critical compliance metric for regulatory risk management."
    - name: "ncr_requiring_8d_count"
      expr: COUNT(CASE WHEN is_8d_required = TRUE THEN 1 END)
      comment: "Number of NCRs requiring an 8D problem-solving report. Indicates severity of systemic quality issues requiring structured resolution."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Count of NCRs requiring customer notification. Directly impacts customer satisfaction and contractual compliance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics covering pass/fail rates, nonconforming quantities, and disposition outcomes. Foundational quality yield and inspection effectiveness KPIs."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type_code"
      expr: inspection_type_code
      comment: "Type of inspection (e.g., incoming, in-process, final) for segmenting quality performance by inspection stage."
    - name: "inspection_level"
      expr: inspection_level
      comment: "Inspection level (e.g., normal, tightened, reduced) reflecting dynamic modification of sampling rigor."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall pass/fail result of the inspection lot. Core quality outcome dimension."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code applied to the lot (e.g., accept, reject, rework) for yield and cost analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision narrative for detailed quality outcome segmentation."
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inspection lot (e.g., in-inspection, closed, blocked) for pipeline monitoring."
    - name: "ncr_triggered"
      expr: ncr_triggered
      comment: "Flag indicating whether the inspection lot triggered an NCR. Links inspection outcomes to nonconformance events."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g., visual, dimensional, destructive) for method effectiveness analysis."
    - name: "lot_origin_month"
      expr: DATE_TRUNC('MONTH', lot_origin_timestamp)
      comment: "Month the inspection lot originated, used for trend analysis of incoming quality over time."
    - name: "inspection_start_month"
      expr: DATE_TRUNC('MONTH', inspection_start_timestamp)
      comment: "Month inspection started, used for throughput and cycle time trend analysis."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed. Baseline volume KPI for inspection throughput."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity of units submitted for inspection. Drives yield rate calculations and capacity planning."
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Total nonconforming units identified across all inspection lots. Core quality cost and yield driver."
    - name: "total_sample_size"
      expr: SUM(CAST(sample_size AS DOUBLE))
      comment: "Total units sampled across all inspection lots. Used to assess inspection coverage and sampling adequacy."
    - name: "avg_lot_quantity"
      expr: AVG(CAST(lot_quantity AS DOUBLE))
      comment: "Average lot size submitted for inspection. Useful for capacity and resource planning."
    - name: "lots_with_ncr_triggered"
      expr: COUNT(CASE WHEN ncr_triggered = TRUE THEN 1 END)
      comment: "Number of inspection lots that triggered an NCR. Measures the rate of nonconformance escalation from inspection."
    - name: "lots_passed"
      expr: COUNT(CASE WHEN overall_result = 'Accepted' THEN 1 END)
      comment: "Number of inspection lots that passed (accepted). Numerator for first-pass yield rate calculation."
    - name: "lots_rejected"
      expr: COUNT(CASE WHEN overall_result = 'Rejected' THEN 1 END)
      comment: "Number of inspection lots rejected. Key quality failure volume metric for supplier and process performance."
    - name: "certificate_of_conformance_required_count"
      expr: COUNT(CASE WHEN certificate_of_conformance_required = TRUE THEN 1 END)
      comment: "Count of lots requiring a certificate of conformance. Tracks compliance documentation burden."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics at the characteristic measurement level, covering process capability (Cp/Cpk), out-of-spec rates, and SPC control violations. Enables statistical process control and product quality steering."
  source: "`vibe_manufacturing_v1`.`quality`.`inspection_result`"
  dimensions:
    - name: "characteristic_type"
      expr: characteristic_type
      comment: "Type of inspection characteristic (e.g., dimensional, visual, functional) for quality analysis segmentation."
    - name: "characteristic_name"
      expr: characteristic_name
      comment: "Name of the measured characteristic for drill-down into specific quality attributes."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (e.g., incoming, in-process, final) for stage-specific quality performance analysis."
    - name: "result_status"
      expr: result_status
      comment: "Pass/fail/conditional status of the individual inspection result. Core quality outcome dimension."
    - name: "is_out_of_spec"
      expr: is_out_of_spec
      comment: "Flag indicating the measured value is outside specification limits. Drives defect rate and yield calculations."
    - name: "is_out_of_control"
      expr: is_out_of_control
      comment: "Flag indicating an SPC out-of-control condition. Triggers process investigation and corrective action."
    - name: "spc_chart_type"
      expr: spc_chart_type
      comment: "Type of SPC chart used (e.g., X-bar R, I-MR) for statistical process monitoring context."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code associated with the out-of-spec result for Pareto and trend analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Measurement method used for the inspection result, relevant for gauge R&R and method effectiveness analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis of quality performance over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the measured value, used for dimensional analysis context."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection result records. Baseline volume for defect rate and yield calculations."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_out_of_spec = TRUE THEN 1 END)
      comment: "Number of inspection results outside specification limits. Primary defect volume KPI."
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN is_out_of_control = TRUE THEN 1 END)
      comment: "Number of SPC out-of-control signals. Indicates process instability requiring immediate investigation."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average process capability index (Cpk) across inspection results. Core SPC KPI — values below 1.33 indicate process incapability requiring corrective action."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average process potential index (Cp) across inspection results. Measures process spread relative to specification width."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk observed across all inspection results. Identifies the worst-performing characteristic or process step requiring priority attention."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results. Used for process centering analysis and trend monitoring."
    - name: "distinct_defect_codes"
      expr: COUNT(DISTINCT defect_code)
      comment: "Number of distinct defect codes observed. Indicates breadth of quality issues across the product or process."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics tracking complaint volume, severity, resolution cycle times, and safety/regulatory exposure. Critical for customer satisfaction, warranty cost management, and regulatory compliance."
  source: "`vibe_manufacturing_v1`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (e.g., dimensional, functional, cosmetic) for Pareto and trend analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., open, closed, under investigation) for pipeline and backlog management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint (e.g., critical, major, minor) for risk prioritization."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (e.g., field, warranty, direct) for source analysis."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode associated with the complaint for root cause and FMEA linkage analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category for systemic quality improvement prioritization."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the complaint was resolved (e.g., replacement, repair, credit) for cost and customer satisfaction analysis."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag for safety-related complaints. Highest priority dimension for regulatory and liability risk management."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for complaints requiring regulatory reporting. Critical compliance dimension."
    - name: "customer_acceptance_status"
      expr: customer_acceptance_status
      comment: "Whether the customer has accepted the resolution. Measures complaint closure quality and customer satisfaction."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the complaint was reported for trend and volume analysis over time."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of customer complaints received. Primary customer quality KPI for executive dashboards."
    - name: "safety_related_complaint_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Number of safety-related complaints. Highest-priority quality metric for product liability and regulatory risk management."
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Number of complaints requiring regulatory reporting. Critical compliance KPI with direct legal and financial consequences."
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN complaint_status = 'Open' THEN 1 END)
      comment: "Number of currently open complaints. Operational KPI for customer service backlog and response time management."
    - name: "complaints_with_8d_report"
      expr: COUNT(CASE WHEN eight_d_report_number IS NOT NULL THEN 1 END)
      comment: "Number of complaints with an 8D report issued. Measures structured problem-solving response rate for serious complaints."
    - name: "distinct_customers_with_complaints"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers who raised complaints. Measures breadth of customer quality impact across the customer base."
    - name: "distinct_skus_complained"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs involved in complaints. Identifies product breadth of quality issues for portfolio risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics tracking action volume, closure performance, effectiveness verification, and recurrence rates. Core quality system KPI for continuous improvement governance."
  source: "`vibe_manufacturing_v1`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs. preventive) for distinguishing reactive from proactive quality actions."
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., open, closed, overdue) for pipeline and governance monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the CAPA (e.g., high, medium, low) for resource allocation and escalation decisions."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for systemic quality improvement analysis and Pareto prioritization."
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Method used for root cause analysis (e.g., 5-Why, Fishbone, 8D) for methodology effectiveness assessment."
    - name: "source_type"
      expr: source_type
      comment: "Source that triggered the CAPA (e.g., customer complaint, internal audit, NCR) for origin analysis."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the CAPA for accountability and workload distribution analysis."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Flag indicating whether the CAPA effectiveness has been verified. Measures quality system closure rigor."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating the issue recurred after CAPA closure. Critical metric for CAPA effectiveness and systemic problem resolution."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flag for CAPAs with regulatory impact. Drives compliance prioritization and reporting."
    - name: "ppap_impact_flag"
      expr: ppap_impact_flag
      comment: "Flag indicating CAPA impacts a PPAP submission. Relevant for new product launch quality governance."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the CAPA was initiated for trend and volume analysis over time."
  measures:
    - name: "total_capa_count"
      expr: COUNT(1)
      comment: "Total number of CAPAs initiated. Primary quality system activity volume KPI."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status = 'Open' THEN 1 END)
      comment: "Number of currently open CAPAs. Key governance KPI for quality management system backlog and overdue action tracking."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Number of CAPAs with verified effectiveness. Measures quality system closure rigor and corrective action sustainability."
    - name: "recurrence_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs where the issue recurred. Critical KPI for CAPA effectiveness — high recurrence indicates systemic root cause resolution failure."
    - name: "regulatory_impact_capa_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs with regulatory impact. Drives compliance risk management and regulatory reporting prioritization."
    - name: "customer_notification_required_count"
      expr: COUNT(CASE WHEN customer_notification_required = TRUE THEN 1 END)
      comment: "Number of CAPAs requiring customer notification. Measures customer-facing quality event exposure."
    - name: "ppap_impacted_capa_count"
      expr: COUNT(CASE WHEN ppap_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs impacting PPAP submissions. Relevant for new product launch risk and customer approval management."
    - name: "distinct_plants_with_capa"
      expr: COUNT(DISTINCT plant_id)
      comment: "Number of distinct plants with active CAPAs. Measures geographic and operational breadth of quality issues."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Part Approval Process (PPAP) submission metrics tracking approval rates, submission levels, safety-critical part exposure, and resubmission activity. Key new product launch and supplier quality governance KPIs."
  source: "`vibe_manufacturing_v1`.`quality`.`ppap_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the PPAP submission (e.g., approved, rejected, interim) for launch readiness monitoring."
    - name: "submission_level"
      expr: submission_level
      comment: "PPAP submission level (1-5) indicating the depth of documentation required by the customer."
    - name: "submission_reason"
      expr: submission_reason
      comment: "Reason for the PPAP submission (e.g., new part, engineering change, tooling change) for change management analysis."
    - name: "psw_disposition"
      expr: psw_disposition
      comment: "Part Submission Warrant disposition (approved, rejected, interim) — the formal customer approval outcome."
    - name: "apqp_phase"
      expr: apqp_phase
      comment: "APQP phase associated with the submission for new product development pipeline analysis."
    - name: "is_safety_critical_part"
      expr: is_safety_critical_part
      comment: "Flag for safety-critical parts. Highest-priority dimension for PPAP governance and regulatory compliance."
    - name: "regulatory_compliance_status"
      expr: regulatory_compliance_status
      comment: "Regulatory compliance status of the PPAP submission for compliance risk management."
    - name: "dimensional_results_status"
      expr: dimensional_results_status
      comment: "Status of dimensional results element within the PPAP package for quality completeness tracking."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of PPAP submission for launch pipeline and trend analysis."
    - name: "customer_approval_month"
      expr: DATE_TRUNC('MONTH', customer_approval_date)
      comment: "Month of customer approval for launch readiness and cycle time analysis."
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total number of PPAP submissions. Baseline volume KPI for new product launch and engineering change activity."
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Number of approved PPAP submissions. Numerator for first-time approval rate — key launch quality KPI."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected PPAP submissions. Indicates quality readiness gaps in new product launches."
    - name: "interim_approval_submissions"
      expr: COUNT(CASE WHEN psw_disposition = 'Interim' THEN 1 END)
      comment: "Number of submissions with interim approval. Interim approvals represent controlled risk — high counts signal systemic launch readiness issues."
    - name: "safety_critical_part_submissions"
      expr: COUNT(CASE WHEN is_safety_critical_part = TRUE THEN 1 END)
      comment: "Number of PPAP submissions for safety-critical parts. Highest-priority compliance and liability metric."
    - name: "avg_cpk_minimum"
      expr: AVG(CAST(cpk_minimum AS DOUBLE))
      comment: "Average minimum Cpk requirement across PPAP submissions. Reflects the process capability bar set by customers for approved production."
    - name: "distinct_customers_with_submissions"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with PPAP submissions. Measures breadth of new product launch activity across the customer portfolio."
    - name: "distinct_skus_in_ppap"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs undergoing PPAP. Measures new product launch pipeline breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_supplier_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quality audit metrics tracking audit scores, nonconformance findings, CAPA requirements, and re-audit rates. Core supplier development and supply chain risk management KPIs."
  source: "`vibe_manufacturing_v1`.`quality`.`supplier_quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., initial qualification, surveillance, re-audit) for audit program analysis."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (e.g., quality system, process, product) for scope-based performance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in-progress, closed) for audit pipeline management."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result (e.g., pass, conditional pass, fail) for supplier qualification decisions."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Quality standard audited against (e.g., ISO 9001, IATF 16949) for compliance program analysis."
    - name: "supplier_facility_country"
      expr: supplier_facility_country
      comment: "Country of the audited supplier facility for geographic supply chain risk analysis."
    - name: "supplier_qualification_level"
      expr: supplier_qualification_level
      comment: "Supplier qualification tier resulting from the audit for approved supplier list management."
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating whether a CAPA was required as a result of the audit. Measures audit finding severity."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating a re-audit is required. High re-audit rates signal systemic supplier quality issues."
    - name: "ppap_assessment_included"
      expr: ppap_assessment_included
      comment: "Flag indicating the audit included a PPAP assessment. Relevant for new supplier qualification depth."
    - name: "audit_method"
      expr: audit_method
      comment: "Audit method used (e.g., on-site, remote, hybrid) for audit program effectiveness analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the audit was planned to start for audit program scheduling and trend analysis."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of supplier quality audits conducted. Baseline KPI for audit program activity and supplier coverage."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average supplier audit score. Primary supplier quality performance KPI used in supplier scorecards and qualification decisions."
    - name: "min_audit_score"
      expr: MIN(audit_score)
      comment: "Minimum audit score observed. Identifies worst-performing suppliers requiring immediate development or disqualification action."
    - name: "total_audit_duration_days"
      expr: SUM(CAST(audit_duration_days AS DOUBLE))
      comment: "Total audit duration in days. Measures audit program resource investment and capacity utilization."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average audit duration in days. Used for audit program planning and resource allocation."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of audits resulting in a CAPA requirement. Measures the rate of significant findings requiring corrective action."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Number of audits requiring a re-audit. High re-audit rates indicate systemic supplier quality failures and increased supply chain risk."
    - name: "total_checklist_items_assessed"
      expr: SUM(CAST(total_checklist_items AS DOUBLE))
      comment: "Total checklist items assessed across all audits. Measures audit thoroughness and program coverage depth."
    - name: "distinct_suppliers_audited"
      expr: COUNT(DISTINCT procurement_contract_id)
      comment: "Number of distinct supplier contracts audited. Measures supplier quality program coverage breadth across the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis (FMEA) metrics tracking risk priority, safety-critical exposure, regulatory compliance, and action completion rates. Drives proactive risk reduction and design/process robustness decisions."
  source: "`vibe_manufacturing_v1`.`quality`.`fmea`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (e.g., DFMEA, PFMEA) for distinguishing design vs. process risk analysis."
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current status of the FMEA (e.g., draft, approved, under review) for governance and completeness tracking."
    - name: "action_priority"
      expr: action_priority
      comment: "Action priority level (e.g., high, medium, low) for risk-based resource allocation decisions."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Flag for safety-critical failure modes. Highest-priority dimension for product liability and regulatory risk management."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag for failure modes with regulatory compliance implications. Drives compliance risk prioritization."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode description for Pareto analysis of top risk contributors."
    - name: "process_step"
      expr: process_step
      comment: "Process step associated with the failure mode for process-level risk analysis."
    - name: "special_characteristic_code"
      expr: special_characteristic_code
      comment: "Special characteristic code (e.g., safety, critical, significant) for regulatory and customer-specific risk classification."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the FMEA was initiated for program activity trend analysis."
  measures:
    - name: "total_fmea_records"
      expr: COUNT(1)
      comment: "Total number of FMEA records. Baseline KPI for risk analysis program coverage and activity."
    - name: "safety_critical_failure_mode_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Number of safety-critical failure modes identified. Highest-priority risk metric for product safety governance."
    - name: "regulatory_compliance_failure_mode_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of failure modes with regulatory compliance implications. Drives compliance risk management and audit readiness."
    - name: "high_priority_action_count"
      expr: COUNT(CASE WHEN action_priority = 'High' THEN 1 END)
      comment: "Number of FMEA records with high-priority actions outstanding. Measures unresolved high-risk exposure requiring immediate attention."
    - name: "actions_completed_count"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of FMEA records with completed recommended actions. Measures risk reduction execution rate."
    - name: "distinct_skus_in_fmea"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs covered by FMEA analysis. Measures product portfolio risk analysis coverage."
$$;