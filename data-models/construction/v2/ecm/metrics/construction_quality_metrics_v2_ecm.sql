-- Metric views for domain: quality | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) performance metrics tracking quality failures, cost impacts, and resolution efficiency across construction projects. Used by Quality Managers and Project Directors to steer corrective action programs and assess systemic quality risk."
  source: "`vibe_construction_v1`.`quality`.`ncr`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project identifier for project-level NCR analysis."
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (Open, Closed, Under Review, etc.)."
    - name: "ncr_category"
      expr: ncr_category
      comment: "Category of non-conformance (e.g., Material, Workmanship, Design) for root-cause trending."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the NCR (Critical, Major, Minor) to prioritise response."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the NCR for discipline-level quality benchmarking."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the NCR (Accept As-Is, Rework, Reject) to track quality outcomes."
    - name: "identified_date"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month of NCR identification for trend analysis over time."
    - name: "hold_status"
      expr: hold_status
      comment: "Whether the NCR has placed a hold on work, indicating active production blockage."
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Baseline KPI for quality failure frequency used in steering meetings."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN ncr_status = 'Open' THEN 1 END)
      comment: "Count of currently open NCRs. Executives use this to assess unresolved quality risk exposure."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost of all NCRs in DECIMAL(18,2). Directly informs budget risk and contingency decisions."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Average cost impact per NCR. Benchmarks the financial severity of quality failures."
    - name: "ncr_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hold_status = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs that triggered a work hold. High rates signal systemic quality issues blocking project progress."
    - name: "client_notification_required_count"
      expr: COUNT(CASE WHEN client_notification_required = TRUE THEN 1 END)
      comment: "Number of NCRs requiring client notification. Tracks contractual compliance obligations and client relationship risk."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of materials or work affected by NCRs. Informs rework scope and material replacement decisions."
    - name: "avg_quantity_affected"
      expr: AVG(CAST(quantity_affected AS DOUBLE))
      comment: "Average quantity affected per NCR. Used to benchmark the physical scope of quality failures."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection performance metrics measuring pass/fail rates, reinspection frequency, and inspection throughput. Used by Quality Managers and Project Directors to evaluate inspection program effectiveness and identify high-risk work packages."
  source: "`vibe_construction_v1`.`quality`.`inspection`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level inspection performance benchmarking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Hold Point, Witness Point, Review Point) to analyse compliance with ITP requirements."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (Passed, Failed, Pending, Reinspection Required)."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the inspection for pass/fail rate calculations."
    - name: "location_type"
      expr: location_type
      comment: "Type of location inspected (e.g., Structure, MEP, Civil) for area-based quality analysis."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of inspection for trend analysis of inspection volumes and outcomes."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Whether the inspection resulted in an NCR being raised, linking inspection outcomes to quality failures."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Whether a reinspection was required, indicating first-time quality failure."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline KPI for inspection program activity."
    - name: "inspections_with_ncr"
      expr: COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END)
      comment: "Number of inspections that generated an NCR. Directly measures quality failure rate at inspection points."
    - name: "ncr_raise_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections resulting in an NCR. Key quality KPI used in steering meetings to assess contractor performance."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. High rates indicate poor first-time quality and drive rework cost."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Tracks the volume of quality remediation work triggered by inspections."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average ambient temperature at inspection. Used to correlate environmental conditions with inspection outcomes."
    - name: "avg_humidity_percent"
      expr: AVG(CAST(humidity_percent AS DOUBLE))
      comment: "Average humidity at inspection. Environmental factor analysis for quality assurance in sensitive work packages."
    - name: "witness_signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN witness_signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections with witness signatures captured. Measures contractual compliance with witness point obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action program metrics tracking resolution timeliness, cost, and effectiveness. Used by Quality Directors and Project Managers to evaluate the speed and efficacy of quality remediation and prevent recurrence."
  source: "`vibe_construction_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (Open, In Progress, Closed, Overdue)."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action (Rework, Repair, Replace, Accept As-Is) for remediation strategy analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action to assess urgency distribution."
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Whether the corrective action addresses a systemic quality issue, flagging root-cause program needs."
    - name: "requires_client_approval"
      expr: requires_client_approval
      comment: "Whether client approval is required, tracking contractual compliance obligations."
    - name: "requires_design_change"
      expr: requires_design_change
      comment: "Whether the corrective action requires a design change, indicating design quality issues."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review (Effective, Partially Effective, Ineffective) for quality program evaluation."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('month', assigned_date)
      comment: "Month corrective action was assigned for trend analysis of quality remediation workload."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total corrective actions raised. Baseline measure of quality remediation program volume."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN action_status = 'Open' THEN 1 END)
      comment: "Count of open corrective actions. Executives use this to assess unresolved quality remediation backlog."
    - name: "systemic_issue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_systemic_issue = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions classified as systemic issues. High rates signal quality management system failures requiring strategic intervention."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions in DECIMAL(18,2). Directly measures the financial impact of quality failures on project budget."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per corrective action. Benchmarks remediation cost efficiency."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used for budget forecasting of quality remediation spend."
    - name: "cost_overrun_amount"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun on corrective actions (actual minus estimate). Measures accuracy of quality remediation cost planning."
    - name: "design_change_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_design_change = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions requiring a design change. Indicates design quality issues driving rework costs."
    - name: "client_approval_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_client_approval = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions requiring client approval. Tracks contractual compliance burden on quality program."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_defect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Defect management metrics tracking defect volumes, severity distribution, rectification costs, and closure rates. Used by Quality Managers and Project Directors to manage defect liability periods and handover readiness."
  source: "`vibe_construction_v1`.`quality`.`defect`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level defect performance benchmarking."
    - name: "defect_status"
      expr: defect_status
      comment: "Current status of the defect (Open, In Rectification, Closed, Deferred)."
    - name: "defect_type"
      expr: defect_type
      comment: "Type of defect (Structural, Finishing, MEP, etc.) for trade-level quality analysis."
    - name: "severity"
      expr: severity
      comment: "Severity of the defect (Critical, Major, Minor) to prioritise rectification resources."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade discipline responsible for the defect for subcontractor performance management."
    - name: "identified_phase"
      expr: identified_phase
      comment: "Project phase when defect was identified (Construction, Commissioning, DLP) for phase-based quality analysis."
    - name: "impact_on_handover"
      expr: impact_on_handover
      comment: "Whether the defect impacts handover, directly linking defect management to project completion milestones."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month defect was identified for trend analysis."
  measures:
    - name: "total_defects"
      expr: COUNT(1)
      comment: "Total defects identified. Baseline KPI for defect program volume used in project quality reviews."
    - name: "open_defects"
      expr: COUNT(CASE WHEN defect_status = 'Open' THEN 1 END)
      comment: "Count of open defects. Executives use this to assess handover readiness and DLP risk exposure."
    - name: "handover_blocking_defects"
      expr: COUNT(CASE WHEN impact_on_handover = TRUE THEN 1 END)
      comment: "Number of defects blocking handover. Critical KPI for project completion milestone management."
    - name: "total_rectification_cost"
      expr: SUM(CAST(rectification_cost AS DOUBLE))
      comment: "Total cost of defect rectification in DECIMAL(18,2). Directly measures quality failure financial impact on project budget."
    - name: "avg_rectification_cost"
      expr: AVG(CAST(rectification_cost AS DOUBLE))
      comment: "Average rectification cost per defect. Benchmarks defect remediation cost efficiency by trade or phase."
    - name: "defect_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN defect_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects closed. Key handover readiness KPI used in project completion steering meetings."
    - name: "critical_defect_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN severity = 'Critical' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of defects classified as critical severity. High rates trigger executive intervention and resource reallocation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list completion metrics tracking handover readiness and closeout progress. Used by Project Directors and Commissioning Managers to manage handover gates and DLP commencement milestones."
  source: "`vibe_construction_v1`.`quality`.`punch_list`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level punch list completion benchmarking."
    - name: "punch_list_status"
      expr: punch_list_status
      comment: "Current status of the punch list (Open, In Progress, Closed) for completion tracking."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline for the punch list to identify discipline-level completion bottlenecks."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Milestone type associated with the punch list (Mechanical Completion, Handover, DLP) for gate management."
    - name: "handover_gate"
      expr: handover_gate
      comment: "Whether the punch list is a handover gate requirement, directly linking to project completion milestones."
    - name: "dlp_commencement_gate"
      expr: dlp_commencement_gate
      comment: "Whether the punch list must be cleared before DLP commences, tracking defect liability period start conditions."
    - name: "priority"
      expr: priority
      comment: "Priority of the punch list for resource allocation decisions."
    - name: "creation_date_month"
      expr: DATE_TRUNC('month', creation_date)
      comment: "Month punch list was created for trend analysis of handover preparation activity."
  measures:
    - name: "total_punch_lists"
      expr: COUNT(1)
      comment: "Total punch lists created. Baseline measure of handover preparation scope."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all punch lists. Executive KPI for overall handover readiness assessment."
    - name: "handover_gate_punch_lists"
      expr: COUNT(CASE WHEN handover_gate = TRUE THEN 1 END)
      comment: "Number of punch lists that are handover gate requirements. Tracks the scope of mandatory handover conditions."
    - name: "dlp_gate_punch_lists"
      expr: COUNT(CASE WHEN dlp_commencement_gate = TRUE THEN 1 END)
      comment: "Number of punch lists blocking DLP commencement. Directly impacts defect liability period start and contract milestone payments."
    - name: "closed_punch_lists"
      expr: COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END)
      comment: "Count of fully closed punch lists. Measures handover completion progress."
    - name: "punch_list_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_list_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch lists closed. Key handover readiness KPI for project completion steering."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch item granular metrics tracking individual item resolution, cost impacts, and DLP deferrals. Used by Quality Managers and Commissioning Teams to manage item-level handover readiness and cost exposure."
  source: "`vibe_construction_v1`.`quality`.`punch_item`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level punch item analysis."
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (Open, In Progress, Closed, Deferred)."
    - name: "punch_item_category"
      expr: punch_item_category
      comment: "Category of the punch item (Structural, MEP, Finishing, Safety) for discipline-level analysis."
    - name: "priority"
      expr: priority
      comment: "Priority of the punch item for resource allocation and escalation decisions."
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Whether the item has been deferred to the Defect Liability Period, tracking handover risk."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item for completion tracking."
    - name: "identified_date_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month punch item was identified for trend analysis."
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total punch items raised. Baseline KPI for handover scope management."
    - name: "open_punch_items"
      expr: COUNT(CASE WHEN punch_item_status = 'Open' THEN 1 END)
      comment: "Count of open punch items. Executives use this to assess handover readiness and completion risk."
    - name: "dlp_deferred_items"
      expr: COUNT(CASE WHEN deferred_to_dlp = TRUE THEN 1 END)
      comment: "Number of punch items deferred to DLP. Tracks post-handover quality obligations and associated cost risk."
    - name: "dlp_deferral_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deferred_to_dlp = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items deferred to DLP. High rates indicate handover quality issues and increased post-completion liability."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of punch items in DECIMAL(18,2). Informs budget provisions for handover completion."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per punch item. Benchmarks the financial severity of individual quality deficiencies."
    - name: "item_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN punch_item_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items closed. Key handover readiness KPI for project completion milestone management."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_itp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection and Test Plan (ITP) program metrics tracking ITP coverage, approval status, and hold/witness point requirements. Used by Quality Managers to ensure contractual inspection obligations are met and ITPs are approved before work commences."
  source: "`vibe_construction_v1`.`quality`.`itp`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level ITP program coverage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the ITP (Approved, Pending, Rejected) to track readiness for work commencement."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline covered by the ITP for discipline-level quality program management."
    - name: "hold_point_required"
      expr: hold_point_required
      comment: "Whether the ITP contains mandatory hold points requiring client/consultant sign-off."
    - name: "witness_point_required"
      expr: witness_point_required
      comment: "Whether the ITP contains witness points, tracking contractual inspection obligations."
    - name: "fat_required"
      expr: fat_required
      comment: "Whether a Factory Acceptance Test is required under this ITP, tracking off-site quality obligations."
    - name: "sat_required"
      expr: sat_required
      comment: "Whether a Site Acceptance Test is required, tracking on-site commissioning quality obligations."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month ITP became effective for program timeline analysis."
  measures:
    - name: "total_itps"
      expr: COUNT(1)
      comment: "Total ITPs in the quality program. Baseline measure of inspection program scope."
    - name: "approved_itps"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved ITPs. Executives use this to confirm quality program readiness before work commences."
    - name: "itp_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ITPs approved. Key quality readiness KPI — low rates indicate risk of uninspected work."
    - name: "hold_point_itp_count"
      expr: COUNT(CASE WHEN hold_point_required = TRUE THEN 1 END)
      comment: "Number of ITPs with mandatory hold points. Tracks the volume of contractual hold point obligations."
    - name: "fat_required_count"
      expr: COUNT(CASE WHEN fat_required = TRUE THEN 1 END)
      comment: "Number of ITPs requiring Factory Acceptance Tests. Informs procurement and logistics planning for off-site quality assurance."
    - name: "sat_required_count"
      expr: COUNT(CASE WHEN sat_required = TRUE THEN 1 END)
      comment: "Number of ITPs requiring Site Acceptance Tests. Tracks commissioning quality obligations and resource planning."
    - name: "material_test_cert_required_count"
      expr: COUNT(CASE WHEN material_test_certificate_required = TRUE THEN 1 END)
      comment: "Number of ITPs requiring material test certificates. Tracks material quality documentation obligations."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_lab_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Laboratory test performance metrics tracking pass/fail rates, retest frequency, and test result distributions. Used by Quality Engineers and Project Managers to assess material quality compliance and identify specification non-conformances."
  source: "`vibe_construction_v1`.`quality`.`lab_test`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level lab test compliance analysis."
    - name: "test_type"
      expr: test_type
      comment: "Type of laboratory test (Compressive Strength, Tensile, Chemical, etc.) for test program analysis."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the lab test for compliance rate calculations."
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested for material-level quality compliance benchmarking."
    - name: "lab_test_status"
      expr: lab_test_status
      comment: "Current status of the lab test (Pending, In Progress, Completed, Cancelled)."
    - name: "retest_flag"
      expr: retest_flag
      comment: "Whether this test is a retest of a previously failed sample."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Whether the test result triggered an NCR, linking lab failures to quality non-conformances."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of testing for trend analysis of lab test volumes and outcomes."
  measures:
    - name: "total_lab_tests"
      expr: COUNT(1)
      comment: "Total laboratory tests conducted. Baseline measure of material quality testing program activity."
    - name: "failed_tests"
      expr: COUNT(CASE WHEN pass_fail_status = 'Fail' THEN 1 END)
      comment: "Number of failed lab tests. Directly measures material quality non-compliance requiring remediation."
    - name: "test_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab tests passing specification. Key material quality KPI used in project quality steering reviews."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that are retests. High rates indicate persistent material quality failures and supplier issues."
    - name: "ncr_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lab tests triggering an NCR. Measures the rate at which material failures escalate to formal non-conformances."
    - name: "avg_measured_result"
      expr: AVG(CAST(measured_result AS DOUBLE))
      comment: "Average measured test result value. Used to benchmark material performance against specification requirements."
    - name: "avg_result_value"
      expr: AVG(CAST(result_value AS DOUBLE))
      comment: "Average result value across all lab tests. Supports statistical quality control analysis."
    - name: "total_test_cost"
      expr: SUM(CAST(cost_code AS DOUBLE))
      comment: "Total cost of laboratory testing. Informs quality program budget management and cost-per-test benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_concrete_pour_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Concrete pour quality metrics tracking pour volumes, slump compliance, NCR rates, and curing performance. Used by Quality Engineers and Project Managers to manage concrete quality compliance and identify specification deviations."
  source: "`vibe_construction_v1`.`quality`.`concrete_pour_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level concrete quality analysis."
    - name: "concrete_grade"
      expr: concrete_grade
      comment: "Concrete grade specification (e.g., C30, C40) for grade-level quality compliance analysis."
    - name: "element_type"
      expr: element_type
      comment: "Structural element type (Column, Beam, Slab, Foundation) for element-level quality benchmarking."
    - name: "pour_status"
      expr: pour_status
      comment: "Current status of the pour (Planned, In Progress, Completed, Failed) for program management."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the pour (Accepted, Rejected, Conditional) for quality compliance tracking."
    - name: "slump_test_passed"
      expr: slump_test_passed
      comment: "Whether the slump test passed specification, indicating fresh concrete workability compliance."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Whether an NCR was raised for this pour, linking concrete quality failures to formal non-conformances."
    - name: "pour_date_month"
      expr: DATE_TRUNC('month', pour_date)
      comment: "Month of pour for trend analysis of concrete quality performance."
  measures:
    - name: "total_pours"
      expr: COUNT(1)
      comment: "Total concrete pours recorded. Baseline measure of concrete construction activity."
    - name: "total_pour_volume_m3"
      expr: SUM(CAST(total_pour_volume_m3 AS DOUBLE))
      comment: "Total concrete volume poured in cubic metres. Key production KPI for concrete construction progress tracking."
    - name: "avg_pour_volume_m3"
      expr: AVG(CAST(pour_volume_m3 AS DOUBLE))
      comment: "Average volume per pour in cubic metres. Benchmarks pour size for resource planning."
    - name: "slump_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN slump_test_passed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours passing slump test. Key concrete quality KPI — low rates indicate mix design or batching issues."
    - name: "ncr_raise_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of pours resulting in an NCR. Measures concrete quality non-conformance rate for executive quality reviews."
    - name: "avg_slump_mm"
      expr: AVG(CAST(slump_mm AS DOUBLE))
      comment: "Average slump value in millimetres. Used to monitor concrete workability trends and detect mix design drift."
    - name: "avg_concrete_temperature_c"
      expr: AVG(CAST(concrete_temperature_c AS DOUBLE))
      comment: "Average concrete temperature at placement. Monitors compliance with temperature specification limits for concrete quality."
    - name: "avg_ambient_temperature_c"
      expr: AVG(CAST(ambient_temperature_c AS DOUBLE))
      comment: "Average ambient temperature during pours. Correlates environmental conditions with concrete quality outcomes."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_weld_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weld quality metrics tracking acceptance rates, NDT outcomes, rework rates, and PWHT compliance. Used by Quality Engineers and Project Managers to manage structural welding quality and regulatory compliance."
  source: "`vibe_construction_v1`.`quality`.`weld_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level weld quality analysis."
    - name: "weld_type"
      expr: weld_type
      comment: "Type of weld (Butt, Fillet, Groove, etc.) for weld-type quality benchmarking."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the weld (Accepted, Rejected, Conditional) for quality compliance tracking."
    - name: "ndt_method"
      expr: ndt_method
      comment: "NDT method applied (UT, RT, MT, PT) for NDT program analysis."
    - name: "ndt_result"
      expr: ndt_result
      comment: "NDT test result (Pass, Fail, Indication) for weld quality outcome analysis."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Whether weld rework was required, indicating first-time quality failure."
    - name: "pwht_required_flag"
      expr: pwht_required_flag
      comment: "Whether Post-Weld Heat Treatment was required, tracking compliance with material specification requirements."
    - name: "weld_date_month"
      expr: DATE_TRUNC('month', weld_date)
      comment: "Month of welding for trend analysis of weld quality performance."
  measures:
    - name: "total_welds"
      expr: COUNT(1)
      comment: "Total weld records. Baseline measure of welding program scope."
    - name: "weld_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds accepted on first inspection. Key structural quality KPI used in project quality steering reviews."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rework_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds requiring rework. High rates indicate welder performance issues and drive schedule and cost impacts."
    - name: "ndt_fail_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ndt_result = 'Fail' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of welds failing NDT. Measures structural quality non-conformance rate for executive quality reviews."
    - name: "total_weld_length_mm"
      expr: SUM(CAST(weld_length_mm AS DOUBLE))
      comment: "Total weld length in millimetres. Production KPI for welding program progress tracking."
    - name: "avg_weld_length_mm"
      expr: AVG(CAST(weld_length_mm AS DOUBLE))
      comment: "Average weld length per record. Benchmarks weld complexity and resource requirements."
    - name: "avg_preheat_temperature_c"
      expr: AVG(CAST(preheat_temperature_c AS DOUBLE))
      comment: "Average preheat temperature applied. Monitors compliance with material specification preheat requirements."
    - name: "pwht_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pwht_required_flag = TRUE AND pwht_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN pwht_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of welds requiring PWHT that have a recorded completion date. Tracks PWHT compliance for regulatory and specification adherence."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit program metrics tracking audit frequency, findings, corrective action rates, and closure performance. Used by Quality Directors and Senior Management to evaluate quality management system effectiveness."
  source: "`vibe_construction_v1`.`quality`.`quality_audit`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level quality audit program analysis."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (Internal, External, Certification, Surveillance) for audit program composition analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (Planned, In Progress, Closed, Overdue) for program management."
    - name: "quality_audit_status"
      expr: quality_audit_status
      comment: "Detailed quality audit status for lifecycle tracking."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard audited against (ISO 9001, etc.) for standards compliance tracking."
    - name: "follow_up_audit_required"
      expr: follow_up_audit_required
      comment: "Whether a follow-up audit is required, indicating unresolved findings requiring re-verification."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit for trend analysis of audit program activity."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total quality audits conducted. Baseline measure of quality assurance program activity."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_audit_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring follow-up. High rates indicate persistent quality management system deficiencies."
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average audit duration in hours. Benchmarks audit resource consumption for program planning."
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours invested in quality audits. Informs quality assurance resource allocation decisions."
    - name: "distinct_projects_audited"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct construction projects audited. Measures quality audit program coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ndt_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Destructive Testing (NDT) metrics tracking acceptance rates, repair requirements, and retest frequency. Used by Quality Engineers and Project Managers to manage structural integrity compliance and NDT program effectiveness."
  source: "`vibe_construction_v1`.`quality`.`ndt_record`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level NDT compliance analysis."
    - name: "ndt_method"
      expr: ndt_method
      comment: "NDT method applied (UT, RT, MT, PT, VT) for method-level performance analysis."
    - name: "acceptance_status"
      expr: acceptance_status
      comment: "Acceptance status of the NDT result (Accepted, Rejected, Conditional) for compliance tracking."
    - name: "ndt_record_status"
      expr: ndt_record_status
      comment: "Current status of the NDT record for lifecycle management."
    - name: "repair_required"
      expr: repair_required
      comment: "Whether repair was required following NDT, indicating structural quality failures."
    - name: "retest_required"
      expr: retest_required
      comment: "Whether a retest was required, indicating first-time NDT failure."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Whether an NCR was raised following NDT failure, linking structural quality failures to formal non-conformances."
    - name: "test_date_month"
      expr: DATE_TRUNC('month', test_date)
      comment: "Month of NDT for trend analysis of structural quality performance."
  measures:
    - name: "total_ndt_records"
      expr: COUNT(1)
      comment: "Total NDT records. Baseline measure of structural quality testing program scope."
    - name: "ndt_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests accepted. Key structural quality KPI for executive quality reviews and regulatory compliance."
    - name: "repair_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repair_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests requiring repair. High rates indicate structural quality issues driving schedule and cost impacts."
    - name: "retest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN retest_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests requiring retest. Measures first-time quality failure rate for structural inspection."
    - name: "ncr_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_raised = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NDT tests triggering an NCR. Measures the rate at which structural failures escalate to formal non-conformances."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_checklist_execution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Checklist execution performance metrics tracking compliance rates, critical failures, and NCR generation. Used by Quality Managers to evaluate field inspection effectiveness and identify high-risk work activities."
  source: "`vibe_construction_v1`.`quality`.`checklist_execution`"
  dimensions:
    - name: "checklist_construction_project_id"
      expr: checklist_construction_project_id
      comment: "Construction project for project-level checklist execution analysis."
    - name: "overall_result"
      expr: overall_result
      comment: "Overall result of the checklist execution (Pass, Fail, Conditional) for compliance tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the checklist execution for sign-off compliance tracking."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection executed for program composition analysis."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of inspection (Pre-Pour, In-Process, Final) for stage-level quality analysis."
    - name: "critical_failure_flag"
      expr: critical_failure_flag
      comment: "Whether the execution resulted in a critical failure requiring immediate escalation."
    - name: "ncr_generated_flag"
      expr: ncr_generated_flag
      comment: "Whether the checklist execution generated an NCR, linking field inspections to formal non-conformances."
    - name: "execution_date_month"
      expr: DATE_TRUNC('month', execution_date)
      comment: "Month of checklist execution for trend analysis."
  measures:
    - name: "total_executions"
      expr: COUNT(1)
      comment: "Total checklist executions. Baseline measure of field inspection program activity."
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across all checklist executions. Key field quality KPI for steering meetings."
    - name: "critical_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_failure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions with critical failures. High rates trigger immediate executive intervention."
    - name: "ncr_generation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ncr_generated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklist executions generating an NCR. Measures field quality failure rate for quality program management."
    - name: "witness_signature_capture_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN witness_signature_captured = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of executions with witness signatures captured. Measures contractual compliance with witness point obligations."
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature during checklist execution. Environmental quality control monitoring."
    - name: "avg_humidity_percentage"
      expr: AVG(CAST(humidity_percentage AS DOUBLE))
      comment: "Average humidity during checklist execution. Environmental quality control monitoring for sensitive work activities."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_test_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test certificate compliance metrics tracking certificate validity, pass/fail rates, and expiry management. Used by Quality Managers and Procurement teams to ensure material quality documentation is current and compliant."
  source: "`vibe_construction_v1`.`quality`.`test_certificate`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level test certificate compliance analysis."
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of test certificate (Mill Certificate, Factory Test, Third-Party, etc.) for documentation compliance analysis."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (Valid, Expired, Pending, Rejected) for compliance tracking."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass/fail outcome of the test certificate for material quality compliance analysis."
    - name: "material_type"
      expr: material_type
      comment: "Type of material covered by the certificate for material-level compliance benchmarking."
    - name: "test_certificate_status"
      expr: test_certificate_status
      comment: "Detailed test certificate status for lifecycle management."
    - name: "certificate_issue_date_month"
      expr: DATE_TRUNC('month', certificate_issue_date)
      comment: "Month certificate was issued for trend analysis of material quality documentation."
  measures:
    - name: "total_test_certificates"
      expr: COUNT(1)
      comment: "Total test certificates recorded. Baseline measure of material quality documentation program scope."
    - name: "valid_certificates"
      expr: COUNT(CASE WHEN certificate_status = 'Valid' THEN 1 END)
      comment: "Number of currently valid test certificates. Executives use this to confirm material quality documentation compliance."
    - name: "certificate_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN pass_fail_status = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test certificates with passing results. Key material quality compliance KPI."
    - name: "expired_certificates"
      expr: COUNT(CASE WHEN certificate_status = 'Expired' THEN 1 END)
      comment: "Number of expired test certificates. Tracks compliance risk from outdated material quality documentation."
    - name: "expiry_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certificate_status != 'Expired' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certificates that are not expired. Measures material quality documentation currency compliance."
    - name: "distinct_materials_certified"
      expr: COUNT(DISTINCT material_catalog_id)
      comment: "Number of distinct material catalog items with test certificates. Measures material quality documentation coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality submittal review performance metrics tracking review cycle times, approval rates, and resubmission frequency. Used by Quality Managers and Project Engineers to manage submittal program efficiency and contractual compliance."
  source: "`vibe_construction_v1`.`quality`.`quality_submittal`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Construction project for project-level submittal program analysis."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of quality submittal (Method Statement, Material Approval, Shop Drawing, etc.) for program composition analysis."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the submittal (Approved, Rejected, Under Review, Resubmit) for pipeline management."
    - name: "quality_submittal_status"
      expr: quality_submittal_status
      comment: "Detailed quality submittal status for lifecycle tracking."
    - name: "resubmission_required"
      expr: resubmission_required
      comment: "Whether resubmission was required, indicating first-time approval failure."
    - name: "certification_required"
      expr: certification_required
      comment: "Whether third-party certification is required for the submittal, tracking compliance obligations."
    - name: "review_priority"
      expr: review_priority
      comment: "Priority of the submittal review for resource allocation and scheduling decisions."
    - name: "submission_date_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of submission for trend analysis of submittal program activity."
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total quality submittals. Baseline measure of quality documentation program scope."
    - name: "approved_submittals"
      expr: COUNT(CASE WHEN review_status = 'Approved' THEN 1 END)
      comment: "Number of approved submittals. Executives use this to confirm quality documentation readiness for work commencement."
    - name: "submittal_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN review_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals approved. Key quality program readiness KPI — low rates indicate risk of uninspected or non-compliant work."
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN resubmission_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals requiring resubmission. High rates indicate poor submittal quality and drive review cycle delays."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total cost impact of quality submittals in DECIMAL(18,2). Informs budget provisions for quality documentation program."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact AS DOUBLE))
      comment: "Average cost impact per submittal. Benchmarks the financial burden of quality documentation requirements."
$$;