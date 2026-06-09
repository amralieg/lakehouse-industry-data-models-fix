-- Metric views for domain: quality | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) metrics tracking quality failures, cost impacts, resolution velocity, and systemic risk across construction projects. NCRs are the primary quality control instrument for identifying and resolving deviations from specifications."
  source: "`construction_ecm`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (e.g. Open, Closed, Under Review) — used to segment open vs resolved quality issues."
    - name: "ncr_category"
      expr: ncr_category
      comment: "Category of non-conformance (e.g. Material, Workmanship, Design) — enables root-cause trend analysis by category."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the NCR (e.g. Critical, Major, Minor) — drives prioritisation and escalation decisions."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the NCR (e.g. Civil, Structural, MEP) — supports discipline-level quality benchmarking."
    - name: "disposition"
      expr: disposition
      comment: "Approved disposition of the NCR (e.g. Rework, Use-As-Is, Reject) — indicates the resolution pathway chosen."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month in which the NCR was identified — enables trend analysis of quality failure rates over time."
    - name: "hold_status"
      expr: hold_status
      comment: "Whether the NCR has placed a hold on work (True/False) — critical for tracking work stoppages caused by quality issues."
    - name: "reported_by_organization"
      expr: reported_by_organization
      comment: "Organisation that raised the NCR (contractor, client, third-party inspector) — supports accountability and vendor quality tracking."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Baseline quality failure volume metric used in steering meetings and QA dashboards."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Number of currently open NCRs. A rising open count signals unresolved quality risk and potential schedule/handover impact."
    - name: "critical_ncr_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of NCRs classified as Critical severity. Directly informs executive escalation and risk management decisions."
    - name: "ncr_on_hold_count"
      expr: COUNT(CASE WHEN hold_status = TRUE THEN 1 END)
      comment: "Number of NCRs that have placed a hold on construction work. Directly tied to schedule risk and cost overrun exposure."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost impact of all NCRs. Key financial risk metric for project cost forecasting and client reporting."
    - name: "avg_estimated_cost_impact_per_ncr"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average estimated cost impact per NCR. Benchmarks the financial severity of quality failures and informs contingency planning."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of materials or work affected by NCRs. Indicates the physical scale of quality non-conformances."
    - name: "ncr_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs that have been closed. Core quality management KPI measuring resolution effectiveness and backlog clearance."
    - name: "ncr_with_client_notification_count"
      expr: COUNT(CASE WHEN client_notification_required = TRUE THEN 1 END)
      comment: "Number of NCRs requiring client notification. Tracks contractual and regulatory notification obligations and client relationship risk."
    - name: "avg_days_to_corrective_action"
      expr: AVG(CAST(DATEDIFF(corrective_action_completion_date, identified_date) AS DOUBLE))
      comment: "Average number of days from NCR identification to corrective action completion. Measures quality response velocity and process efficiency."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection outcome metrics tracking pass/fail rates, reinspection demand, NCR generation, and inspection throughput across construction projects. Inspections are the primary quality gate mechanism ensuring work meets specification before progression."
  source: "`construction_ecm`.`quality`.`inspection`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Passed, Failed, Pending, Reinspection Required) — primary outcome dimension."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. Hold Point, Witness Point, Review Point) — differentiates mandatory vs advisory quality gates."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Overall pass/fail outcome of the inspection — used for high-level quality performance reporting."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection — enables trend analysis of inspection volumes and outcomes over the project lifecycle."
    - name: "location_type"
      expr: location_type
      comment: "Type of location inspected (e.g. Structure, MEP, Civil) — supports spatial quality analysis across project areas."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether a reinspection was required (True/False) — a key quality rework indicator."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Whether corrective action was mandated following the inspection (True/False) — links inspection outcomes to remediation workload."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of inspection — enables correlation analysis between environmental conditions and inspection outcomes."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline throughput metric for quality assurance activity volume."
    - name: "passed_inspections"
      expr: COUNT(CASE WHEN overall_outcome = 'Pass' THEN 1 END)
      comment: "Number of inspections with a passing outcome. Core quality performance indicator."
    - name: "failed_inspections"
      expr: COUNT(CASE WHEN overall_outcome = 'Fail' THEN 1 END)
      comment: "Number of inspections with a failing outcome. Directly triggers rework, NCR generation, and schedule risk."
    - name: "inspection_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_outcome = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that passed first time. Premier quality KPI used in project performance dashboards and client reporting."
    - name: "reinspection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. Measures rework burden and first-time quality effectiveness."
    - name: "ncr_raised_count"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of inspections that generated an NCR. Tracks the rate at which inspections escalate to formal non-conformance records."
    - name: "ncr_generation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that resulted in an NCR being raised. Key quality failure rate metric for executive reporting."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during inspections. Supports environmental condition analysis and correlation with inspection outcomes."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity percentage during inspections. Supports environmental quality risk analysis for moisture-sensitive work."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections mandating corrective action. Quantifies the remediation workload generated by quality inspections."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect management metrics tracking defect volumes, rectification costs, severity distribution, and closure performance. Defects represent physical quality failures requiring remediation and directly impact project handover and client satisfaction."
  source: "`construction_ecm`.`quality`.`defect`"
  dimensions:
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (e.g. Open, In Progress, Closed, Verified) — primary lifecycle dimension for defect backlog management."
    - name: "defect_type"
      expr: defect_type
      comment: "Classification of the defect type (e.g. Structural, Finishing, MEP) — enables root-cause analysis by defect category."
    - name: "severity"
      expr: severity
      comment: "Severity of the defect (e.g. Critical, Major, Minor) — drives prioritisation and escalation of rectification work."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade or discipline responsible for the defect (e.g. Concrete, Steel, Electrical) — supports subcontractor performance benchmarking."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the defect was identified — enables trend analysis of defect discovery rates over the project lifecycle."
    - name: "impact_on_handover"
      expr: impact_on_handover
      comment: "Whether the defect impacts project handover (True/False) — critical for milestone and contractual completion risk tracking."
    - name: "location_zone"
      expr: location_zone
      comment: "Zone or area of the project where the defect was found — supports spatial quality analysis and hotspot identification."
    - name: "location_level"
      expr: location_level
      comment: "Building level or floor where the defect was identified — enables level-by-level quality performance analysis."
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total number of defects recorded. Baseline quality failure volume metric for project quality dashboards."
    - name: "open_defects"
      expr: COUNT(CASE WHEN defect_status = 'Open' THEN 1 END)
      comment: "Number of currently open defects. A rising open defect count signals handover risk and client satisfaction exposure."
    - name: "critical_defects"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity defects. Directly informs executive escalation and risk management decisions."
    - name: "handover_blocking_defects"
      expr: COUNT(CASE WHEN impact_on_handover = TRUE THEN 1 END)
      comment: "Number of defects that block project handover. Directly tied to milestone achievement, contract completion, and revenue recognition."
    - name: "defect_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN defect_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects that have been closed and verified. Core quality management KPI for backlog clearance and handover readiness."
    - name: "total_rectification_cost"
      expr: SUM(CAST(rectification_cost AS DOUBLE))
      comment: "Total cost incurred to rectify defects. Key financial quality metric for cost-of-poor-quality (COPQ) analysis and project cost control."
    - name: "avg_rectification_cost_per_defect"
      expr: AVG(CAST(rectification_cost AS DOUBLE))
      comment: "Average rectification cost per defect. Benchmarks the financial impact of quality failures and informs quality investment decisions."
    - name: "avg_days_to_rectification"
      expr: AVG(CAST(DATEDIFF(actual_rectification_date, identified_date) AS DOUBLE))
      comment: "Average number of days from defect identification to actual rectification. Measures quality response speed and rectification efficiency."
    - name: "overdue_defects"
      expr: COUNT(CASE WHEN defect_status != 'Closed' AND target_rectification_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of defects past their target rectification date that remain open. Critical operational metric for schedule and handover risk management."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list item metrics tracking pre-handover quality completion, cost impacts, and closure velocity. Punch items represent outstanding quality items that must be resolved before project handover and directly gate milestone payments."
  source: "`construction_ecm`.`quality`.`punch_item`"
  dimensions:
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (e.g. Open, Closed, Deferred) — primary lifecycle dimension for handover readiness tracking."
    - name: "punch_item_category"
      expr: punch_item_category
      comment: "Category of the punch item (e.g. Structural, Finishing, Commissioning) — enables category-level completion analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch item (e.g. High, Medium, Low) — drives sequencing of rectification work before handover."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item — differentiates formally closed items from those still in progress."
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Whether the punch item has been deferred to the Defect Liability Period (True/False) — tracks items accepted with conditions at handover."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the punch item was identified — enables trend analysis of punch item generation rates during commissioning and handover phases."
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total number of punch items raised. Baseline handover readiness metric used in project completion dashboards."
    - name: "open_punch_items"
      expr: COUNT(CASE WHEN punch_item_status = 'Open' THEN 1 END)
      comment: "Number of currently open punch items. Directly measures handover readiness — a high open count blocks milestone completion and payment."
    - name: "deferred_to_dlp_count"
      expr: COUNT(CASE WHEN deferred_to_dlp = TRUE THEN 1 END)
      comment: "Number of punch items deferred to the Defect Liability Period. Tracks contractual risk carried into the post-handover warranty period."
    - name: "punch_item_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_item_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items closed. Premier handover readiness KPI used in project completion reporting and client milestone sign-off."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all punch items. Key metric for cost-of-poor-quality analysis and final account settlement."
    - name: "avg_cost_impact_per_item"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per punch item. Benchmarks the financial severity of pre-handover quality issues."
    - name: "overdue_punch_items"
      expr: COUNT(CASE WHEN punch_item_status != 'Closed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of punch items past their target completion date. Critical metric for handover schedule risk and contractual milestone management."
    - name: "avg_days_to_close"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, identified_date) AS DOUBLE))
      comment: "Average days from punch item identification to actual completion. Measures pre-handover quality resolution velocity."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action metrics tracking remediation effectiveness, cost of quality, systemic issue rates, and resolution velocity. Corrective actions are the formal response mechanism to NCRs and quality failures, directly impacting project cost and schedule."
  source: "`construction_ecm`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g. Open, In Progress, Completed, Verified) — primary lifecycle dimension."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (e.g. Rework, Repair, Replace, Procedure Change) — enables analysis of remediation strategy patterns."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action (e.g. Urgent, High, Normal) — drives resource allocation and scheduling decisions."
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Whether the root cause is a systemic issue (True/False) — systemic issues require process-level interventions and executive attention."
    - name: "requires_design_change"
      expr: requires_design_change
      comment: "Whether the corrective action requires a design change (True/False) — flags actions with broader project scope and cost implications."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review (e.g. Effective, Partially Effective, Ineffective) — measures whether corrective actions actually resolved the root cause."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the corrective action was assigned — enables trend analysis of quality remediation workload over time."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions raised. Baseline quality remediation volume metric."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Number of currently open corrective actions. Measures unresolved quality remediation backlog and associated schedule/cost risk."
    - name: "systemic_issue_count"
      expr: COUNT(CASE WHEN is_systemic_issue = TRUE THEN 1 END)
      comment: "Number of corrective actions identified as systemic issues. Systemic issues indicate process failures requiring management intervention."
    - name: "systemic_issue_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_systemic_issue = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that are systemic issues. A rising rate signals deteriorating quality management processes requiring executive action."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Core cost-of-poor-quality (COPQ) metric for financial performance reporting."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting and cost-of-quality planning."
    - name: "cost_overrun_on_corrective_actions"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun (actual minus estimated) across all corrective actions. Measures accuracy of quality remediation cost estimation."
    - name: "avg_days_to_complete"
      expr: AVG(CAST(DATEDIFF(actual_completion_date, assigned_date) AS DOUBLE))
      comment: "Average days from corrective action assignment to actual completion. Measures quality remediation velocity and process efficiency."
    - name: "overdue_corrective_actions"
      expr: COUNT(CASE WHEN action_status != 'Completed' AND target_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of corrective actions past their target completion date. Critical operational metric for quality backlog and schedule risk management."
    - name: "effective_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN effectiveness_review_outcome = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN effectiveness_review_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of reviewed corrective actions deemed effective. Measures whether quality interventions are actually resolving root causes — a key continuous improvement KPI."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_checklist_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checklist execution metrics tracking quality inspection compliance rates, critical failure rates, and NCR generation from field quality checks. Checklist executions are the operational quality control activity at the work-face."
  source: "`construction_ecm`.`quality`.`checklist_execution`"
  dimensions:
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the checklist execution (e.g. Pass, Fail, Conditional Pass) — primary outcome dimension."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed during checklist execution — differentiates quality check categories."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of construction at which the checklist was executed (e.g. Pre-pour, Post-pour, Commissioning) — enables stage-level quality analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the checklist execution (e.g. Approved, Pending, Rejected) — tracks formal sign-off on quality checks."
    - name: "critical_failure_flag"
      expr: critical_failure_flag
      comment: "Whether the execution recorded a critical failure (True/False) — critical failures trigger immediate escalation and work stoppage."
    - name: "ncr_generated_flag"
      expr: ncr_generated_flag
      comment: "Whether the checklist execution generated an NCR (True/False) — links field quality checks to formal non-conformance records."
    - name: "execution_date_month"
      expr: DATE_TRUNC('MONTH', execution_date)
      comment: "Month of checklist execution — enables trend analysis of quality check volumes and outcomes over time."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during checklist execution — supports environmental quality risk analysis."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total number of checklist executions performed. Baseline quality control activity volume metric."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all checklist executions. Premier field quality KPI measuring adherence to quality standards at the work-face."
    - name: "critical_failure_count"
      expr: COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END)
      comment: "Number of checklist executions with critical failures. Critical failures halt work and trigger immediate management escalation."
    - name: "critical_failure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions resulting in a critical failure. Key quality risk indicator for executive and safety reporting."
    - name: "ncr_generation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions that generated an NCR. Measures the rate at which field quality checks escalate to formal non-conformances."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature during checklist executions. Supports environmental condition analysis and correlation with quality outcomes."
    - name: "avg_humidity_percentage"
      expr: AVG(CAST(humidity_percentage AS DOUBLE))
      comment: "Average humidity during checklist executions. Supports moisture-sensitive quality risk analysis."
    - name: "witness_signature_capture_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN witness_signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN witness_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of witness-required executions where witness signature was captured. Measures compliance with witness point obligations — a contractual and regulatory requirement."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_test_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test certificate metrics tracking material and equipment test compliance, pass/fail rates, and certificate validity. Test certificates are mandatory quality evidence for regulatory compliance, client handover, and material acceptance."
  source: "`construction_ecm`.`quality`.`test_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the test certificate (e.g. Valid, Expired, Pending, Rejected) — primary lifecycle dimension."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of test certificate (e.g. Material Test Certificate, Weld Test, Pressure Test) — enables analysis by test category."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail result of the test — primary quality outcome dimension for test certificate analysis."
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested (e.g. Concrete, Steel, Pipe) — enables material-level quality compliance analysis."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month the test was conducted — enables trend analysis of testing activity and outcomes over time."
    - name: "issuing_laboratory"
      expr: issuing_laboratory
      comment: "Laboratory that issued the test certificate — supports laboratory performance benchmarking and accreditation tracking."
    - name: "test_method"
      expr: test_method
      comment: "Test method applied (e.g. Tensile, Hardness, Chemical Analysis) — enables method-level quality analysis."
  measures:
    - name: "total_test_certificates"
      expr: COUNT(1)
      comment: "Total number of test certificates issued. Baseline quality evidence volume metric for handover documentation completeness."
    - name: "passed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END)
      comment: "Number of tests that passed. Core material quality compliance metric."
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of tests that failed. Failed tests trigger material rejection, rework, or retest — directly impacting project schedule and cost."
    - name: "test_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that passed. Premier material quality KPI used in project quality reports and regulatory submissions."
    - name: "expired_certificates"
      expr: COUNT(CASE WHEN certificate_expiry_date < CURRENT_DATE() AND certificate_status != 'Superseded' THEN 1 END)
      comment: "Number of test certificates that have expired. Expired certificates create regulatory compliance risk and may invalidate material acceptance."
    - name: "certificates_pending_approval"
      expr: COUNT(CASE WHEN certificate_status = 'Pending' THEN 1 END)
      comment: "Number of test certificates awaiting approval. Tracks documentation bottlenecks that could delay handover and milestone payments."
    - name: "distinct_materials_tested"
      expr: COUNT(DISTINCT material_catalog_id)
      comment: "Number of distinct material catalog items with test certificates. Measures breadth of material quality evidence coverage for handover documentation."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`quality_punch_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list aggregate metrics tracking handover readiness, completion percentages, and closeout performance at the punch list level. Punch lists are the primary handover quality gate instrument gating milestone payments and project completion."
  source: "`construction_ecm`.`quality`.`punch_list`"
  dimensions:
    - name: "punch_list_status"
      expr: punch_list_status
      comment: "Current status of the punch list (e.g. Open, Closed, In Progress) — primary lifecycle dimension for handover readiness."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline covered by the punch list — enables discipline-level handover readiness analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch list — drives sequencing of closeout activities before handover."
    - name: "handover_gate"
      expr: handover_gate
      comment: "Whether this punch list is a handover gate (True/False) — identifies punch lists that directly block project handover and milestone payments."
    - name: "dlp_commencement_gate"
      expr: dlp_commencement_gate
      comment: "Whether this punch list gates commencement of the Defect Liability Period (True/False) — tracks contractual DLP trigger conditions."
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for closing the punch list (e.g. Main Contractor, Subcontractor, Client) — supports accountability tracking."
    - name: "project_area"
      expr: project_area
      comment: "Project area or zone covered by the punch list — enables spatial handover readiness analysis."
    - name: "creation_date_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month the punch list was created — enables trend analysis of punch list generation during commissioning phases."
  measures:
    - name: "total_punch_lists"
      expr: COUNT(1)
      comment: "Total number of punch lists created. Baseline handover management activity metric."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all punch lists. Premier handover readiness KPI used in project completion dashboards and client reporting."
    - name: "closed_punch_lists"
      expr: COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END)
      comment: "Number of fully closed punch lists. Measures handover milestone achievement across project areas."
    - name: "punch_list_closure_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch lists that have been fully closed. Core handover readiness KPI for project completion reporting."
    - name: "handover_gate_punch_lists_open"
      expr: COUNT(CASE WHEN handover_gate = TRUE AND punch_list_status != 'Closed' THEN 1 END)
      comment: "Number of open punch lists that are handover gates. Directly measures the number of outstanding items blocking project handover and milestone payments."
    - name: "overdue_punch_lists"
      expr: COUNT(CASE WHEN punch_list_status != 'Closed' AND target_closeout_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of punch lists past their target closeout date. Critical schedule risk metric for project completion and contractual milestone management."
$$;