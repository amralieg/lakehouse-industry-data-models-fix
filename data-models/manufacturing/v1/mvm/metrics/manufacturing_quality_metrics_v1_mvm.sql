-- Metric views for domain: quality | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance Report (NCR) metrics tracking volume, severity, disposition outcomes, and closure performance. Core quality KPI layer for manufacturing nonconformance governance."
  source: "`manufacturing_ecm`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_type"
      expr: ncr_type
      comment: "Type of nonconformance (e.g., incoming, in-process, outgoing) for segmenting defect origin."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current workflow status of the NCR (e.g., open, closed, pending disposition) for pipeline analysis."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance for risk-based prioritization."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category (e.g., design, process, supplier) to drive corrective action targeting."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition decision (e.g., scrap, rework, use-as-is) for material cost impact analysis."
    - name: "detection_source"
      expr: detection_source
      comment: "Where the nonconformance was detected (e.g., incoming inspection, production, field) to evaluate detection effectiveness."
    - name: "defect_code"
      expr: defect_code
      comment: "Standardized defect code for Pareto analysis of recurring defect types."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_timestamp)
      comment: "Month the NCR was reported, enabling trend analysis over time."
    - name: "is_8d_required"
      expr: is_8d_required
      comment: "Flag indicating whether an 8D corrective action report is required for this NCR."
    - name: "regulatory_reportable"
      expr: regulatory_reportable
      comment: "Flag indicating whether the nonconformance must be reported to a regulatory body."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Baseline volume KPI for quality performance dashboards and trend monitoring."
    - name: "total_nonconforming_qty"
      expr: SUM(CAST(nonconforming_qty AS DOUBLE))
      comment: "Total quantity of nonconforming units across all NCRs. Directly measures production defect volume and material at risk."
    - name: "avg_nonconforming_qty_per_ncr"
      expr: AVG(CAST(nonconforming_qty AS DOUBLE))
      comment: "Average nonconforming quantity per NCR. Indicates typical defect batch size and helps assess severity of individual events."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Number of NCRs currently open. Measures backlog of unresolved quality issues requiring management attention."
    - name: "regulatory_reportable_ncr_count"
      expr: COUNT(CASE WHEN regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of NCRs flagged as regulatory reportable. Critical compliance KPI for regulatory risk management."
    - name: "ncr_requiring_8d_count"
      expr: COUNT(CASE WHEN is_8d_required = TRUE THEN 1 END)
      comment: "Number of NCRs requiring an 8D corrective action report. Indicates severity of systemic quality failures demanding structured resolution."
    - name: "avg_closure_cycle_days"
      expr: AVG(DATEDIFF(actual_closure_date, DATE(reported_timestamp)))
      comment: "Average days from NCR reporting to actual closure. Measures quality response agility and process efficiency."
    - name: "overdue_ncr_count"
      expr: COUNT(CASE WHEN ncr_status != 'Closed' AND target_closure_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of NCRs past their target closure date without being closed. Signals quality process bottlenecks and escalation needs."
    - name: "supplier_ncr_count"
      expr: COUNT(CASE WHEN ncr_type = 'Supplier' THEN 1 END)
      comment: "Count of NCRs attributed to supplier-origin defects. Key input for supplier quality scorecards and sourcing decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective and Preventive Action (CAPA) metrics tracking effectiveness, closure performance, recurrence, and regulatory impact. Drives continuous improvement governance."
  source: "`manufacturing_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_type"
      expr: capa_type
      comment: "Type of CAPA (corrective vs. preventive) for distinguishing reactive vs. proactive quality actions."
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., open, in-progress, closed, verified) for pipeline management."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA for resource allocation and escalation decisions."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category to identify systemic quality failure patterns across the organization."
    - name: "source_type"
      expr: source_type
      comment: "Origin of the CAPA trigger (e.g., customer complaint, audit, NCR) for source-based quality analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level CAPA performance benchmarking."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the CAPA, enabling accountability tracking by organizational unit."
    - name: "effectiveness_verified"
      expr: effectiveness_verified
      comment: "Whether the CAPA effectiveness has been formally verified, indicating completion quality."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether the same issue has recurred after a prior CAPA, measuring corrective action durability."
    - name: "regulatory_impact_flag"
      expr: regulatory_impact_flag
      comment: "Flag for CAPAs with regulatory compliance implications, critical for audit readiness."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the CAPA was initiated for trend and aging analysis."
  measures:
    - name: "total_capa_count"
      expr: COUNT(1)
      comment: "Total number of CAPAs initiated. Baseline volume KPI for quality improvement program health."
    - name: "open_capa_count"
      expr: COUNT(CASE WHEN capa_status = 'Open' THEN 1 END)
      comment: "Number of currently open CAPAs. Measures unresolved corrective action backlog requiring management oversight."
    - name: "effectiveness_verified_count"
      expr: COUNT(CASE WHEN effectiveness_verified = TRUE THEN 1 END)
      comment: "Number of CAPAs with verified effectiveness. Measures quality of corrective action closure and long-term fix durability."
    - name: "recurrence_count"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs where the issue recurred after closure. High recurrence signals systemic root cause analysis failures."
    - name: "regulatory_impact_capa_count"
      expr: COUNT(CASE WHEN regulatory_impact_flag = TRUE THEN 1 END)
      comment: "Count of CAPAs with regulatory impact. Critical compliance KPI for regulatory body reporting and audit preparedness."
    - name: "overdue_capa_count"
      expr: COUNT(CASE WHEN capa_status != 'Closed' AND target_closure_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of CAPAs past their target closure date. Indicates process discipline failures and escalation requirements."
    - name: "avg_closure_cycle_days"
      expr: AVG(DATEDIFF(actual_closure_date, initiated_date))
      comment: "Average days from CAPA initiation to actual closure. Measures corrective action responsiveness and process efficiency."
    - name: "ppap_impacted_capa_count"
      expr: COUNT(CASE WHEN ppap_impact_flag = TRUE THEN 1 END)
      comment: "Number of CAPAs impacting PPAP (Production Part Approval Process). Signals product launch risk and customer approval re-submission needs."
    - name: "avg_containment_cycle_days"
      expr: AVG(DATEDIFF(containment_completion_date, initiated_date))
      comment: "Average days from CAPA initiation to containment completion. Measures speed of immediate risk mitigation before full root cause resolution."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics tracking volume, severity, resolution performance, and safety/regulatory exposure. Directly links quality performance to customer satisfaction and retention risk."
  source: "`manufacturing_ecm`.`quality`.`customer_complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of customer complaint (e.g., product defect, delivery, documentation) for category-based quality analysis."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., open, closed, pending) for pipeline and backlog management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint for risk-based prioritization and escalation."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (e.g., field, portal, direct) for intake analysis."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the complaint for systemic quality improvement targeting."
    - name: "failure_mode"
      expr: failure_mode
      comment: "Failure mode associated with the complaint for FMEA alignment and design improvement."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the complaint was resolved (e.g., replacement, repair, credit) for cost and satisfaction analysis."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code associated with the complaint origin for site-level quality accountability."
    - name: "is_safety_related"
      expr: is_safety_related
      comment: "Flag for safety-related complaints requiring expedited handling and potential regulatory notification."
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Flag for complaints requiring regulatory body reporting, critical for compliance governance."
    - name: "reported_month"
      expr: DATE_TRUNC('MONTH', reported_date)
      comment: "Month the complaint was reported for trend analysis and seasonal quality pattern detection."
    - name: "customer_acceptance_status"
      expr: customer_acceptance_status
      comment: "Whether the customer has accepted the resolution, measuring complaint closure quality."
  measures:
    - name: "total_complaint_count"
      expr: COUNT(1)
      comment: "Total number of customer complaints received. Primary customer quality KPI for executive dashboards and customer satisfaction programs."
    - name: "open_complaint_count"
      expr: COUNT(CASE WHEN complaint_status = 'Open' THEN 1 END)
      comment: "Number of currently open complaints. Measures unresolved customer quality exposure and service backlog."
    - name: "safety_related_complaint_count"
      expr: COUNT(CASE WHEN is_safety_related = TRUE THEN 1 END)
      comment: "Count of safety-related complaints. Critical risk KPI requiring immediate executive visibility and potential product action."
    - name: "regulatory_reportable_complaint_count"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Count of complaints requiring regulatory reporting. Compliance KPI for legal and regulatory risk management."
    - name: "avg_response_cycle_days"
      expr: AVG(DATEDIFF(customer_response_date, reported_date))
      comment: "Average days from complaint receipt to customer response. Measures complaint handling responsiveness against SLA commitments."
    - name: "avg_closure_cycle_days"
      expr: AVG(DATEDIFF(closure_date, reported_date))
      comment: "Average days from complaint receipt to full closure. End-to-end complaint resolution cycle time KPI."
    - name: "overdue_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_completed_date IS NULL AND corrective_action_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of complaints with overdue corrective actions. Signals quality response discipline failures and customer escalation risk."
    - name: "distinct_affected_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct customer accounts with complaints. Measures breadth of customer quality impact for account management decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_inspection_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection lot metrics tracking pass/fail rates, nonconforming quantities, NCR trigger rates, and disposition outcomes. Core production quality yield and incoming inspection KPI layer."
  source: "`manufacturing_ecm`.`quality`.`inspection_lot`"
  dimensions:
    - name: "inspection_type_code"
      expr: inspection_type_code
      comment: "Type of inspection (e.g., incoming, in-process, final) for stage-specific quality analysis."
    - name: "inspection_level"
      expr: inspection_level
      comment: "Inspection level (e.g., normal, tightened, reduced) reflecting dynamic modification of sampling rigor."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall inspection lot result (e.g., accepted, rejected) for yield and pass rate calculations."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition code applied to the lot (e.g., accept, reject, rework, scrap) for material outcome analysis."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Disposition decision narrative for audit trail and quality governance."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level inspection performance benchmarking."
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the inspection lot for pipeline and hold management."
    - name: "ncr_triggered"
      expr: ncr_triggered
      comment: "Flag indicating whether the inspection lot triggered an NCR, linking inspection outcomes to nonconformance events."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Inspection method used (e.g., visual, dimensional, functional) for method effectiveness analysis."
    - name: "lot_origin_month"
      expr: DATE_TRUNC('MONTH', lot_origin_timestamp)
      comment: "Month the lot originated for trend analysis of inspection volumes and quality over time."
  measures:
    - name: "total_inspection_lots"
      expr: COUNT(1)
      comment: "Total number of inspection lots processed. Baseline inspection throughput KPI."
    - name: "accepted_lot_count"
      expr: COUNT(CASE WHEN overall_result = 'Accepted' THEN 1 END)
      comment: "Number of inspection lots accepted. Numerator for first-pass yield rate calculation."
    - name: "rejected_lot_count"
      expr: COUNT(CASE WHEN overall_result = 'Rejected' THEN 1 END)
      comment: "Number of inspection lots rejected. Measures incoming and in-process quality failure volume."
    - name: "ncr_triggered_lot_count"
      expr: COUNT(CASE WHEN ncr_triggered = TRUE THEN 1 END)
      comment: "Number of inspection lots that triggered an NCR. Links inspection outcomes to formal nonconformance escalation rate."
    - name: "total_lot_quantity"
      expr: SUM(CAST(lot_quantity AS DOUBLE))
      comment: "Total quantity of units across all inspection lots. Measures inspection throughput volume in units."
    - name: "total_nonconforming_quantity"
      expr: SUM(CAST(nonconforming_quantity AS DOUBLE))
      comment: "Total nonconforming units identified across all inspection lots. Core defect volume KPI for quality cost analysis."
    - name: "avg_sample_size"
      expr: AVG(CAST(sample_size AS DOUBLE))
      comment: "Average sample size per inspection lot. Monitors sampling plan compliance and statistical rigor of inspection programs."
    - name: "avg_inspection_duration_hours"
      expr: AVG((UNIX_TIMESTAMP(inspection_end_timestamp) - UNIX_TIMESTAMP(inspection_start_timestamp)) / 3600.0)
      comment: "Average inspection duration in hours per lot. Measures inspection efficiency and capacity utilization."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics tracking out-of-spec rates, process capability indices (Cp/Cpk), and defect patterns at the characteristic level. Enables SPC-driven quality control and process improvement decisions."
  source: "`manufacturing_ecm`.`quality`.`inspection_result`"
  dimensions:
    - name: "result_status"
      expr: result_status
      comment: "Result status (e.g., pass, fail, conditional) for quality outcome segmentation."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (e.g., incoming, in-process, final) for stage-specific quality analysis."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Measurement method used for the inspection result, enabling method-level capability analysis."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code for Pareto analysis of most frequent defect types driving quality losses."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level process capability and defect rate benchmarking."
    - name: "shift_code"
      expr: shift_code
      comment: "Production shift code for shift-level quality variation analysis."
    - name: "spc_chart_type"
      expr: spc_chart_type
      comment: "SPC chart type used (e.g., X-bar R, I-MR) for statistical process control method analysis."
    - name: "is_out_of_spec"
      expr: is_out_of_spec
      comment: "Flag for results outside specification limits, enabling direct out-of-spec rate calculation."
    - name: "is_out_of_control"
      expr: is_out_of_control
      comment: "Flag for results outside statistical control limits, indicating process instability."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for trend analysis of process capability and defect rates over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the inspection characteristic, enabling cross-characteristic comparison within the same UOM."
  measures:
    - name: "total_inspection_results"
      expr: COUNT(1)
      comment: "Total number of inspection results recorded. Baseline measurement volume KPI."
    - name: "out_of_spec_count"
      expr: COUNT(CASE WHEN is_out_of_spec = TRUE THEN 1 END)
      comment: "Number of inspection results outside specification limits. Core defect detection KPI for process quality control."
    - name: "out_of_control_count"
      expr: COUNT(CASE WHEN is_out_of_control = TRUE THEN 1 END)
      comment: "Number of results outside statistical control limits. Signals process instability requiring immediate SPC intervention."
    - name: "avg_cpk_index"
      expr: AVG(CAST(cpk_index AS DOUBLE))
      comment: "Average process capability index (Cpk) across inspection results. Primary process capability KPI — values below 1.33 indicate process improvement is required."
    - name: "avg_cp_index"
      expr: AVG(CAST(cp_index AS DOUBLE))
      comment: "Average process potential index (Cp) across inspection results. Measures inherent process spread relative to specification width."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured value across inspection results. Monitors process centering relative to nominal target values."
    - name: "min_cpk_index"
      expr: MIN(cpk_index)
      comment: "Minimum Cpk index observed. Identifies the worst-performing characteristic or process step requiring priority improvement."
    - name: "distinct_defect_codes"
      expr: COUNT(DISTINCT defect_code)
      comment: "Number of distinct defect codes observed. Measures defect variety breadth — high values indicate systemic process instability."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit metrics tracking audit scores, findings, CAPA requirements, and re-audit rates. Supports quality management system (QMS) governance, supplier qualification, and regulatory compliance."
  source: "`manufacturing_ecm`.`quality`.`quality_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, supplier, customer, regulatory) for audit program segmentation."
    - name: "audit_category"
      expr: audit_category
      comment: "Audit category (e.g., process, product, system) for scope-based quality governance analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in-progress, closed) for audit pipeline management."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result (e.g., pass, fail, conditional) for compliance outcome analysis."
    - name: "standard"
      expr: standard
      comment: "Quality standard audited against (e.g., ISO 9001, IATF 16949, AS9100) for standards compliance tracking."
    - name: "audited_entity_type"
      expr: audited_entity_type
      comment: "Type of entity audited (e.g., supplier, plant, process) for entity-level compliance benchmarking."
    - name: "audited_entity_country"
      expr: audited_entity_country
      comment: "Country of the audited entity for geographic compliance risk analysis."
    - name: "capa_required"
      expr: capa_required
      comment: "Flag indicating whether the audit requires a CAPA, linking audit findings to corrective action obligations."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Flag indicating whether a re-audit is required, signaling failed or conditional audit outcomes."
    - name: "audit_method"
      expr: audit_method
      comment: "Audit method used (e.g., on-site, remote, hybrid) for audit program effectiveness analysis."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month the audit was planned to start for audit program scheduling and capacity analysis."
  measures:
    - name: "total_audit_count"
      expr: COUNT(1)
      comment: "Total number of quality audits conducted. Baseline audit program activity KPI."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all audits. Primary quality management system health KPI — declining scores signal systemic compliance deterioration."
    - name: "min_audit_score"
      expr: MIN(score)
      comment: "Minimum audit score observed. Identifies worst-performing entities requiring immediate corrective action."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required = TRUE THEN 1 END)
      comment: "Number of audits requiring CAPA. Measures the volume of audits generating formal corrective action obligations."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Number of audits requiring re-audit. High re-audit rates signal persistent compliance failures and supplier/process risk."
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(duration_days AS DOUBLE))
      comment: "Average audit duration in days. Measures audit program efficiency and resource utilization."
    - name: "avg_closure_cycle_days"
      expr: AVG(DATEDIFF(closure_date, actual_start_date))
      comment: "Average days from audit start to formal closure. Measures audit resolution cycle time and reporting discipline."
    - name: "distinct_audited_entities"
      expr: COUNT(DISTINCT COALESCE(supplier_id, plant_id))
      comment: "Number of distinct entities audited (suppliers or plants). Measures audit program coverage breadth for compliance governance."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`quality_fmea`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Failure Mode and Effects Analysis (FMEA) metrics tracking risk priority, safety-critical items, and action completion rates. Supports design and process risk management decisions."
  source: "`manufacturing_ecm`.`quality`.`fmea`"
  dimensions:
    - name: "fmea_type"
      expr: fmea_type
      comment: "Type of FMEA (e.g., DFMEA, PFMEA) for design vs. process risk segmentation."
    - name: "fmea_status"
      expr: fmea_status
      comment: "Current status of the FMEA (e.g., draft, approved, obsolete) for document lifecycle management."
    - name: "action_priority"
      expr: action_priority
      comment: "Action priority level (e.g., high, medium, low) for risk-based resource allocation."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for site-level FMEA risk profile analysis."
    - name: "safety_critical_flag"
      expr: safety_critical_flag
      comment: "Flag for safety-critical failure modes requiring mandatory risk mitigation actions."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag for failure modes with regulatory compliance implications."
    - name: "fmea_scope"
      expr: fmea_scope
      comment: "Scope of the FMEA (e.g., component, subsystem, system) for risk coverage analysis."
    - name: "process_step"
      expr: process_step
      comment: "Process step associated with the failure mode for process-level risk concentration analysis."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the FMEA was initiated for program activity trend analysis."
  measures:
    - name: "total_fmea_count"
      expr: COUNT(1)
      comment: "Total number of FMEA records. Baseline risk analysis program coverage KPI."
    - name: "safety_critical_fmea_count"
      expr: COUNT(CASE WHEN safety_critical_flag = TRUE THEN 1 END)
      comment: "Number of FMEAs with safety-critical failure modes. Highest-priority risk KPI for product safety governance."
    - name: "regulatory_compliance_fmea_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of FMEAs with regulatory compliance implications. Compliance risk KPI for regulatory readiness assessments."
    - name: "high_priority_action_count"
      expr: COUNT(CASE WHEN action_priority = 'High' THEN 1 END)
      comment: "Number of FMEA entries with high-priority recommended actions. Measures volume of critical risk items requiring immediate engineering response."
    - name: "action_completed_count"
      expr: COUNT(CASE WHEN actual_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of FMEAs with completed recommended actions. Measures risk mitigation execution rate."
    - name: "overdue_action_count"
      expr: COUNT(CASE WHEN actual_completion_date IS NULL AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of FMEAs with overdue recommended actions. Signals unmitigated risk exposure requiring escalation."
    - name: "avg_review_cycle_days"
      expr: AVG(DATEDIFF(last_review_date, initiated_date))
      comment: "Average days between FMEA initiation and last review. Measures FMEA maintenance discipline and currency of risk assessments."
$$;