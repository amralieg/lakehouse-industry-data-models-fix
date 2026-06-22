-- Metric views for domain: design | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Request for Information (RFI) performance across construction projects, measuring responsiveness, cost and schedule impact, and backlog health. Used by project managers and design leads to manage design query resolution and its downstream effects on cost and schedule."
  source: "`vibe_construction_v1`.`design`.`rfi`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level RFI performance analysis."
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI (e.g. Open, Closed, Pending), used to segment active vs. resolved queries."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g. Structural, MEP, Civil) responsible for the RFI, enabling discipline-level workload analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFI (e.g. High, Medium, Low), used to triage and escalate critical design queries."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the RFI has a schedule impact, used to filter schedule-critical RFIs."
    - name: "date_raised_month"
      expr: DATE_TRUNC('month', date_raised)
      comment: "Month the RFI was raised, used for trend analysis of RFI volume over time."
    - name: "closure_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month the RFI was closed, used to track resolution throughput over time."
  measures:
    - name: "total_rfi_count"
      expr: COUNT(1)
      comment: "Total number of RFIs raised. Baseline volume metric used to assess design query load on the project."
    - name: "open_rfi_count"
      expr: COUNT(CASE WHEN rfi_status = 'Open' THEN 1 END)
      comment: "Number of currently open RFIs. A high open count signals unresolved design issues that may block construction progress."
    - name: "rfi_with_cost_impact_count"
      expr: COUNT(CASE WHEN cost_impact_flag > 0 THEN 1 END)
      comment: "Number of RFIs flagged as having a cost impact. Drives cost risk awareness and change order forecasting."
    - name: "total_cost_impact_amount"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all RFIs. Directly informs project cost risk exposure from unresolved design queries."
    - name: "avg_cost_impact_per_rfi"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI. Helps benchmark the financial severity of design queries and prioritise resolution."
    - name: "rfi_with_schedule_impact_count"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs with a confirmed schedule impact. Critical for programme risk management and delay mitigation."
    - name: "rfi_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFIs that have been closed. Measures design query resolution efficiency; low rates indicate bottlenecks in the design review process."
    - name: "overdue_rfi_count"
      expr: COUNT(CASE WHEN rfi_status != 'Closed' AND response_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of RFIs past their response due date and still open. A leading indicator of design team responsiveness failures and potential contractual breaches."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures submittal review cycle performance, approval disposition outcomes, and cost/schedule impact of submittals across construction projects. Used by design managers and project controls to track contractor deliverable compliance and review efficiency."
  source: "`vibe_construction_v1`.`design`.`submittal`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level submittal performance benchmarking."
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (e.g. Pending, Approved, Rejected), used to track pipeline health."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (e.g. Shop Drawing, Material Sample, Method Statement), enabling category-level analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the submittal, used for workload distribution analysis."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Final approval outcome (e.g. Approved, Approved with Comments, Rejected), used to measure first-pass approval quality."
    - name: "submitting_organization"
      expr: submitting_organization
      comment: "Organisation that submitted the deliverable, enabling contractor-level performance comparison."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating whether the submittal has a regulatory compliance requirement, used to prioritise review queues."
    - name: "required_submission_month"
      expr: DATE_TRUNC('month', required_submission_date)
      comment: "Month the submittal was contractually required, used for on-time submission trend analysis."
  measures:
    - name: "total_submittal_count"
      expr: COUNT(1)
      comment: "Total number of submittals. Baseline volume metric for tracking design deliverable throughput."
    - name: "approved_submittal_count"
      expr: COUNT(CASE WHEN approval_disposition = 'Approved' THEN 1 END)
      comment: "Number of submittals approved without conditions. Measures first-pass approval quality and design maturity."
    - name: "rejected_submittal_count"
      expr: COUNT(CASE WHEN approval_disposition = 'Rejected' THEN 1 END)
      comment: "Number of rejected submittals. High rejection rates signal poor contractor quality or unclear specifications, driving rework costs."
    - name: "first_pass_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_disposition = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals approved on first submission. A key quality KPI — low rates indicate systemic design or contractor quality issues."
    - name: "overdue_submittal_count"
      expr: COUNT(CASE WHEN submittal_status NOT IN ('Approved', 'Closed') AND review_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of submittals past their review due date and not yet approved. Signals review bottlenecks that may delay construction activities."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all submittals. Informs project cost risk exposure from submittal-driven changes."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per submittal. Benchmarks the financial weight of individual submittal decisions."
    - name: "regulatory_submittal_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of submittals with regulatory compliance requirements. Ensures regulatory-critical deliverables are tracked separately for governance reporting."
    - name: "on_time_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_submission_date <= required_submission_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_submission_date IS NOT NULL AND required_submission_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of submittals submitted on or before the required date. Measures contractor schedule adherence for design deliverables."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the health, volume, and quality of the drawing register across construction projects. Used by design managers to monitor drawing production throughput, revision churn, and deliverable compliance."
  source: "`vibe_construction_v1`.`design`.`drawing`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level drawing register analysis."
    - name: "drawing_status"
      expr: drawing_status
      comment: "Current status of the drawing (e.g. Issued for Construction, Under Review, Superseded), used to track drawing lifecycle stage."
    - name: "drawing_type"
      expr: drawing_type
      comment: "Type of drawing (e.g. General Arrangement, Detail, Schematic), enabling category-level volume analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the drawing, used for workload and productivity analysis by discipline."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Boolean flag indicating whether the drawing is a contractual client deliverable, used to prioritise review and issue workflows."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Boolean flag indicating whether the drawing is under document control, used for governance and audit compliance."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Status of clash detection for the drawing (e.g. Passed, Failed, Pending), used to track BIM coordination quality."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the drawing was created, used for drawing production rate trend analysis."
  measures:
    - name: "total_drawing_count"
      expr: COUNT(1)
      comment: "Total number of drawings in the register. Baseline metric for design deliverable volume tracking."
    - name: "issued_for_construction_count"
      expr: COUNT(CASE WHEN drawing_status = 'Issued for Construction' THEN 1 END)
      comment: "Number of drawings issued for construction. Measures design completion progress and readiness to build."
    - name: "client_deliverable_count"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of drawings that are contractual client deliverables. Used to track compliance with client deliverable schedules."
    - name: "clash_detected_drawing_count"
      expr: COUNT(CASE WHEN clash_detection_status = 'Failed' THEN 1 END)
      comment: "Number of drawings with detected clashes. High counts indicate BIM coordination failures that will cause rework on site."
    - name: "clash_detection_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clash_detection_status = 'Failed' THEN 1 END) / NULLIF(COUNT(CASE WHEN clash_detection_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of drawings that failed clash detection. A key BIM quality KPI — high rates signal coordination process failures."
    - name: "total_drawing_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all drawings in megabytes. Used for storage capacity planning and digital delivery management."
    - name: "avg_drawing_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average file size per drawing in megabytes. Benchmarks drawing complexity and informs digital infrastructure requirements."
    - name: "controlled_document_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of drawings under document control. Measures governance compliance — low rates indicate document control process gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyses drawing revision activity to measure design change velocity, rework frequency, and distribution efficiency. Used by design leads and project controls to identify drawings with excessive revision churn and assess the impact of design changes on schedule."
  source: "`vibe_construction_v1`.`design`.`revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the revision (e.g. Issued, Superseded, Under Review), used to track active vs. historical revisions."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (e.g. Design Change, Error Correction, Client Comment), used to categorise the root cause of design changes."
    - name: "revision_date_month"
      expr: DATE_TRUNC('month', revision_date)
      comment: "Month the revision was issued, used for design change velocity trend analysis."
  measures:
    - name: "total_revision_count"
      expr: COUNT(1)
      comment: "Total number of drawing revisions. Baseline metric for design change volume — high counts relative to drawing count indicate excessive rework."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures design approval workflow efficiency, SLA compliance, and escalation rates. Used by design managers and PMO to identify bottlenecks in the approval process, track regulatory compliance, and ensure timely sign-off on design deliverables."
  source: "`vibe_construction_v1`.`design`.`workflow_approval`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level approval workflow benchmarking."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the approval workflow (e.g. In Progress, Approved, Rejected), used to track pipeline health."
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of approval workflow (e.g. Design Review, Regulatory Approval, Client Sign-off), enabling category-level SLA analysis."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow (e.g. Approved, Rejected, Deferred), used to measure approval success rates."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required for approval (e.g. Project Manager, Director, Client), used to analyse approval bottlenecks by authority tier."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Boolean flag indicating whether the workflow was escalated, used to identify systemic approval process failures."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Boolean flag indicating whether the approval has a regulatory requirement, used to prioritise compliance-critical workflows."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Boolean flag indicating whether the workflow was completed within SLA, used for SLA performance reporting."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_date)
      comment: "Month the approval workflow was initiated, used for workflow volume and SLA trend analysis."
  measures:
    - name: "total_workflow_count"
      expr: COUNT(1)
      comment: "Total number of approval workflows initiated. Baseline metric for design governance activity volume."
    - name: "approved_workflow_count"
      expr: COUNT(CASE WHEN overall_outcome = 'Approved' THEN 1 END)
      comment: "Number of workflows with an approved outcome. Measures design approval throughput."
    - name: "rejected_workflow_count"
      expr: COUNT(CASE WHEN overall_outcome = 'Rejected' THEN 1 END)
      comment: "Number of workflows rejected. High rejection rates signal quality issues in submitted design deliverables."
    - name: "approval_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overall_outcome = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN overall_outcome IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of completed workflows that resulted in approval. A key design quality KPI — low rates indicate systemic deliverable quality or process issues."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approval workflows completed within SLA. Measures design review process efficiency — low rates indicate resource or process bottlenecks."
    - name: "escalated_workflow_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of workflows that required escalation. Escalations indicate approval process failures and consume senior management time."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows that were escalated. A governance health KPI — high escalation rates signal systemic approval process dysfunction."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual hours consumed across all approval workflows. Used for resource capacity planning in the design review function."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours per approval workflow. Benchmarks review cycle time and identifies workflows consuming disproportionate reviewer effort."
    - name: "regulatory_workflow_count"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Number of approval workflows with a regulatory requirement. Ensures regulatory-critical approvals are tracked separately for compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_bim_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks BIM model health, coordination quality, and ISO 19650 compliance across construction projects. Used by BIM managers and design leads to monitor model maturity, clash resolution progress, and digital delivery standards."
  source: "`vibe_construction_v1`.`design`.`bim_model`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level BIM model portfolio analysis."
    - name: "model_status"
      expr: model_status
      comment: "Current status of the BIM model (e.g. In Development, Issued, Superseded), used to track model lifecycle stage."
    - name: "model_type"
      expr: model_type
      comment: "Type of BIM model (e.g. Architectural, Structural, MEP), enabling discipline-level model health analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the model, used for workload and quality analysis by discipline."
    - name: "lod_classification"
      expr: lod_classification
      comment: "Level of Development (LOD) classification of the model, used to assess model maturity against project stage requirements."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Project lifecycle stage the model is associated with (e.g. Design, Construction, Handover), used for stage-gate compliance tracking."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Boolean flag indicating ISO 19650 compliance, used for digital delivery governance reporting."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Status of clash detection for the model (e.g. Passed, Failed, Pending), used to track BIM coordination quality."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the model was issued, used for BIM delivery milestone trend analysis."
  measures:
    - name: "total_model_count"
      expr: COUNT(1)
      comment: "Total number of BIM models in the register. Baseline metric for digital model portfolio size."
    - name: "iso_19650_compliant_model_count"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Number of BIM models compliant with ISO 19650. Measures digital delivery governance compliance — non-compliance may trigger contractual penalties."
    - name: "iso_19650_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BIM models compliant with ISO 19650. A key digital delivery KPI for projects with BIM mandates."
    - name: "clash_failed_model_count"
      expr: COUNT(CASE WHEN clash_detection_status = 'Failed' THEN 1 END)
      comment: "Number of BIM models with unresolved clashes. Unresolved clashes translate directly to on-site rework costs and schedule delays."
    - name: "clash_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clash_detection_status = 'Passed' THEN 1 END) / NULLIF(COUNT(CASE WHEN clash_detection_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of models that have passed clash detection. Measures BIM coordination effectiveness — low rates predict on-site rework."
    - name: "total_model_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all BIM models in megabytes. Used for digital infrastructure capacity planning and CDE storage management."
    - name: "avg_model_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average BIM model file size in megabytes. Benchmarks model complexity and informs CDE performance requirements."
    - name: "total_federation_role_value"
      expr: SUM(CAST(federation_role AS DOUBLE))
      comment: "Sum of federation role values across all models. Used to assess the scale and complexity of the federated BIM model structure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_technical_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks the completeness, approval status, and compliance posture of technical specifications across construction projects. Used by design managers and procurement teams to ensure specifications are approved, current, and aligned with project requirements before construction and procurement activities commence."
  source: "`vibe_construction_v1`.`design`.`technical_specification`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level specification register analysis."
    - name: "technical_specification_status"
      expr: technical_specification_status
      comment: "Current status of the specification (e.g. Draft, Approved, Superseded), used to track specification lifecycle health."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the specification, enabling discipline-level completeness analysis."
    - name: "specification_type"
      expr: specification_type
      comment: "Type of specification (e.g. Performance, Prescriptive, Proprietary), used for category-level analysis."
    - name: "csi_division"
      expr: csi_division
      comment: "CSI MasterFormat division, used to align specifications with industry-standard work breakdown structures."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the specification (e.g. Pending, Approved, Rejected), used to track governance compliance."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Boolean flag indicating whether the specification is a contractual client deliverable."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the specification became effective, used for specification issuance trend analysis."
  measures:
    - name: "total_specification_count"
      expr: COUNT(1)
      comment: "Total number of technical specifications in the register. Baseline metric for specification portfolio completeness."
    - name: "approved_specification_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved technical specifications. Measures specification readiness for procurement and construction — unapproved specs block downstream activities."
    - name: "specification_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specifications that have been approved. A readiness KPI — low rates indicate design is not ready to support procurement or construction."
    - name: "superseded_specification_count"
      expr: COUNT(CASE WHEN technical_specification_status = 'Superseded' THEN 1 END)
      comment: "Number of superseded specifications. High counts relative to total indicate significant design change activity with potential procurement and construction impact."
    - name: "client_deliverable_specification_count"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of specifications that are contractual client deliverables. Used to track compliance with client deliverable schedules."
    - name: "distinct_csi_divisions_covered"
      expr: COUNT(DISTINCT csi_division)
      comment: "Number of distinct CSI MasterFormat divisions covered by specifications. Measures specification register completeness against the full scope of work."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_transmittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures design document transmittal performance, acknowledgment compliance, and distribution efficiency. Used by document controllers and project managers to ensure design information reaches the right parties on time and is formally acknowledged."
  source: "`vibe_construction_v1`.`design`.`transmittal`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project, enabling project-level transmittal performance analysis."
    - name: "transmittal_status"
      expr: transmittal_status
      comment: "Current status of the transmittal (e.g. Sent, Acknowledged, Overdue), used to track distribution pipeline health."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the transmittal, enabling discipline-level distribution analysis."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the transmittal (e.g. Email, CDE, Post), used to analyse distribution channel effectiveness."
    - name: "purpose_of_issue"
      expr: purpose_of_issue
      comment: "Purpose for which documents were issued (e.g. For Construction, For Review, For Information), used to categorise transmittal intent."
    - name: "acknowledgement_required_flag"
      expr: acknowledgement_required_flag
      comment: "Boolean flag indicating whether formal acknowledgment of receipt is required."
    - name: "acknowledgement_status"
      expr: acknowledgement_status
      comment: "Current acknowledgment status (e.g. Acknowledged, Pending, Overdue), used to track receipt confirmation compliance."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the transmittal was issued, used for distribution volume trend analysis."
  measures:
    - name: "total_transmittal_count"
      expr: COUNT(1)
      comment: "Total number of transmittals issued. Baseline metric for design information distribution activity."
    - name: "unacknowledged_transmittal_count"
      expr: COUNT(CASE WHEN acknowledgement_required_flag = TRUE AND acknowledgement_status != 'Acknowledged' THEN 1 END)
      comment: "Number of transmittals requiring acknowledgment that have not been acknowledged. Unacknowledged transmittals risk construction proceeding without confirmed receipt of current design information."
    - name: "acknowledgment_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledgement_required_flag = TRUE AND acknowledgement_status = 'Acknowledged' THEN 1 END) / NULLIF(COUNT(CASE WHEN acknowledgement_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required acknowledgments received. Measures document distribution compliance — low rates indicate recipients are not confirming receipt of critical design information."
    - name: "overdue_transmittal_count"
      expr: COUNT(CASE WHEN transmittal_status != 'Acknowledged' AND due_date < CURRENT_DATE() THEN 1 END)
      comment: "Number of transmittals past their due date without acknowledgment. Signals distribution failures that may have contractual or safety implications."
    - name: "distinct_recipient_organizations"
      expr: COUNT(DISTINCT recipient_organization)
      comment: "Number of distinct organisations receiving transmittals. Measures the breadth of design information distribution across the project supply chain."
$$;