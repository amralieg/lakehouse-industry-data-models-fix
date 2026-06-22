-- Metric views for domain: design | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks RFI (Request for Information) performance metrics including response timeliness, cost and schedule impact, and open/closed status distribution. Critical for managing design query resolution efficiency and contractual risk."
  source: "`vibe_construction_v1`.`design`.`rfi`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (civil, structural, MEP, etc.) for RFI breakdown by technical area."
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI (Open, Closed, Pending, Overdue) for pipeline analysis."
    - name: "priority"
      expr: priority
      comment: "RFI priority level (High, Medium, Low) to focus attention on critical queries."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Boolean flag indicating whether the RFI has a schedule impact, enabling impact segmentation."
    - name: "date_raised_month"
      expr: DATE_TRUNC('month', date_raised)
      comment: "Month the RFI was raised, for trend analysis of RFI volume over time."
    - name: "response_due_date_month"
      expr: DATE_TRUNC('month', response_due_date)
      comment: "Month the RFI response is due, for workload forecasting."
  measures:
    - name: "total_rfis"
      expr: COUNT(1)
      comment: "Total number of RFIs raised. Baseline volume metric for design query management."
    - name: "open_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Open' THEN 1 END)
      comment: "Number of currently open RFIs. High open counts signal design coordination bottlenecks."
    - name: "overdue_rfis"
      expr: COUNT(CASE WHEN rfi_status = 'Open' AND response_due_date < CURRENT_DATE() THEN 1 END)
      comment: "RFIs past their response due date. Directly indicates contractual risk and design team responsiveness failures."
    - name: "rfi_overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfi_status = 'Open' AND response_due_date < CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(CASE WHEN rfi_status = 'Open' THEN 1 END), 0), 2)
      comment: "Percentage of open RFIs that are overdue. Key SLA compliance indicator for design management."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total monetary cost impact of all RFIs. Quantifies financial exposure from design queries."
    - name: "avg_cost_impact_per_rfi"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI. Helps benchmark and forecast design change cost exposure."
    - name: "schedule_impacted_rfis"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of RFIs with confirmed schedule impact. Directly informs programme risk management."
    - name: "rfi_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfi_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all RFIs that have been closed. Measures design team resolution throughput."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors design change notices including cost and schedule impact, approval status, and regulatory compliance. Essential for change control governance and project cost management."
  source: "`vibe_construction_v1`.`design`.`change_notice`"
  dimensions:
    - name: "change_notice_status"
      expr: change_notice_status
      comment: "Current status of the change notice (Draft, Submitted, Approved, Rejected) for pipeline tracking."
    - name: "change_notice_type"
      expr: change_notice_type
      comment: "Type of change notice (Design Change, Scope Change, Regulatory, etc.) for categorised analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline affected by the change notice."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change notice for triage and resource allocation."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the change notice is driven by regulatory compliance requirements."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Whether the change notice has a confirmed schedule impact."
    - name: "date_raised_month"
      expr: DATE_TRUNC('month', date_raised)
      comment: "Month the change notice was raised, for trend analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Current implementation status of the change notice for delivery tracking."
  measures:
    - name: "total_change_notices"
      expr: COUNT(1)
      comment: "Total number of change notices. Baseline volume metric for design change control."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all change notices. Key financial exposure metric for project cost control."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE))
      comment: "Total actual cost impact realised from change notices. Measures variance from estimates and true cost of design changes."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per change notice. Benchmarks change complexity and cost exposure."
    - name: "cost_impact_variance"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE) - CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total variance between actual and estimated cost impact. Measures estimating accuracy and cost overrun risk."
    - name: "pending_approval_change_notices"
      expr: COUNT(CASE WHEN change_notice_status IN ('Submitted', 'Under Review', 'Pending') THEN 1 END)
      comment: "Number of change notices awaiting approval. Indicates approval bottlenecks in the change control process."
    - name: "regulatory_driven_change_notices"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of change notices driven by regulatory requirements. Tracks compliance-driven design change burden."
    - name: "change_notice_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN change_notice_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change notices that have been approved. Measures change control efficiency and acceptance rate."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_clash_detection_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks BIM clash detection performance including clash counts, resolution rates, and coordination effectiveness. Critical for MEP coordination quality and construction rework prevention."
  source: "`vibe_construction_v1`.`design`.`clash_detection_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the clash detection run (Completed, In Progress, Failed) for pipeline monitoring."
    - name: "discipline_pair"
      expr: discipline_pair
      comment: "Pair of disciplines compared in the clash detection run (e.g., Structural-MEP) for hotspot identification."
    - name: "primary_discipline"
      expr: primary_discipline
      comment: "Primary discipline in the clash detection run for discipline-level performance analysis."
    - name: "building_zone"
      expr: building_zone
      comment: "Building zone where clashes were detected for spatial analysis of coordination issues."
    - name: "clash_free_certification_flag"
      expr: clash_free_certification_flag
      comment: "Whether the run resulted in a clash-free certification, indicating coordination milestone achievement."
    - name: "run_date_month"
      expr: DATE_TRUNC('month', run_date)
      comment: "Month of the clash detection run for trend analysis of coordination progress."
    - name: "software_platform"
      expr: software_platform
      comment: "BIM coordination software platform used for the run."
  measures:
    - name: "total_runs"
      expr: COUNT(1)
      comment: "Total number of clash detection runs. Baseline metric for BIM coordination activity."
    - name: "total_run_duration_minutes"
      expr: SUM(CAST(run_duration_minutes AS DOUBLE))
      comment: "Total time spent on clash detection runs. Measures coordination effort investment."
    - name: "avg_run_duration_minutes"
      expr: AVG(CAST(run_duration_minutes AS DOUBLE))
      comment: "Average duration per clash detection run. Benchmarks coordination process efficiency."
    - name: "avg_clash_tolerance_mm"
      expr: AVG(CAST(clash_tolerance_mm AS DOUBLE))
      comment: "Average clash tolerance setting across runs. Indicates stringency of coordination standards applied."
    - name: "clash_free_certified_runs"
      expr: COUNT(CASE WHEN clash_free_certification_flag = TRUE THEN 1 END)
      comment: "Number of runs achieving clash-free certification. Measures BIM coordination maturity and milestone achievement."
    - name: "clash_free_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN clash_free_certification_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of clash detection runs achieving clash-free certification. Key BIM quality KPI for construction readiness."
    - name: "baseline_runs"
      expr: COUNT(CASE WHEN baseline_run_flag = TRUE THEN 1 END)
      comment: "Number of baseline clash detection runs. Tracks formal coordination milestone checkpoints."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_drawing_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures drawing revision activity, distribution performance, and approval cycle times. Supports design delivery governance and IFC (Issued for Construction) readiness tracking."
  source: "`vibe_construction_v1`.`design`.`revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the drawing revision (Approved, Under Review, Superseded, etc.)."
    - name: "revision_type"
      expr: revision_type
      comment: "Type of revision (Minor, Major, Regulatory, Client-Driven) for change classification."
    - name: "revision_date_month"
      expr: DATE_TRUNC('month', revision_date)
      comment: "Month of the revision for trend analysis of design change velocity."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of drawing revisions issued. Baseline metric for design change activity volume."
    - name: "approved_revisions"
      expr: COUNT(CASE WHEN revision_status = 'Approved' THEN 1 END)
      comment: "Number of approved drawing revisions. Measures design delivery throughput."
    - name: "revision_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN revision_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revisions that have been approved. Indicates design review efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks design submittal performance including approval rates, review cycle times, cost and schedule impacts, and regulatory compliance. Core metric for design delivery management and contractor performance."
  source: "`vibe_construction_v1`.`design`.`design_submittal`"
  dimensions:
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the design submittal (Pending, Under Review, Approved, Rejected, Resubmit Required)."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (Shop Drawing, Material Sample, Method Statement, etc.) for category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the submittal for discipline-level performance tracking."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Final approval disposition (Approved, Approved as Noted, Rejected) for quality analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the submittal is required for regulatory compliance."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Whether the submittal has a schedule impact."
    - name: "actual_submission_date_month"
      expr: DATE_TRUNC('month', actual_submission_date)
      comment: "Month of actual submission for trend analysis of submittal activity."
  measures:
    - name: "total_submittals"
      expr: COUNT(1)
      comment: "Total number of design submittals. Baseline volume metric for design delivery management."
    - name: "approved_submittals"
      expr: COUNT(CASE WHEN submittal_status = 'Approved' THEN 1 END)
      comment: "Number of approved submittals. Measures design delivery success rate."
    - name: "rejected_submittals"
      expr: COUNT(CASE WHEN approval_disposition = 'Rejected' THEN 1 END)
      comment: "Number of rejected submittals. High rejection rates indicate design quality issues and rework costs."
    - name: "submittal_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submittal_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submittals approved on first submission. Key design quality and efficiency KPI."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact from submittals with cost implications. Quantifies design change financial exposure."
    - name: "overdue_submittals"
      expr: COUNT(CASE WHEN submittal_status NOT IN ('Approved', 'Closed') AND review_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Submittals past their review due date. Indicates review bottlenecks that threaten construction schedule."
    - name: "schedule_impacted_submittals"
      expr: COUNT(CASE WHEN schedule_impact_flag = TRUE THEN 1 END)
      comment: "Number of submittals with confirmed schedule impact. Directly informs programme risk management."
    - name: "regulatory_submittals"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of submittals required for regulatory compliance. Tracks compliance-critical design delivery."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures design workflow approval performance including SLA compliance, escalation rates, and cycle time efficiency. Enables management of design review bottlenecks and approval governance."
  source: "`vibe_construction_v1`.`design`.`workflow_approval`"
  dimensions:
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow approval (In Progress, Approved, Rejected, Escalated)."
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of workflow (Drawing Approval, Submittal Review, Change Notice, etc.) for process analysis."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow approval for success/failure analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the workflow was escalated, indicating approval process failures."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the workflow was completed within SLA targets."
    - name: "priority"
      expr: priority
      comment: "Priority level of the workflow approval for workload prioritisation."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether the workflow is required for regulatory compliance."
  measures:
    - name: "total_workflows"
      expr: COUNT(1)
      comment: "Total number of workflow approvals. Baseline metric for design governance activity."
    - name: "sla_compliant_workflows"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of workflows completed within SLA. Measures design review process efficiency."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows meeting SLA targets. Key design governance KPI for executive reporting."
    - name: "escalated_workflows"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of workflows that required escalation. Indicates systemic approval bottlenecks."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of workflows escalated. High rates signal approval process dysfunction requiring management intervention."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual hours consumed by workflow approvals. Quantifies design review resource consumption."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours per workflow approval. Benchmarks review cycle time for process improvement."
    - name: "regulatory_workflows"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Number of workflows driven by regulatory requirements. Tracks compliance-critical approval workload."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_change_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quantifies the cost and schedule impact of design changes by category and severity. Enables executive-level visibility into design change risk exposure and approval status."
  source: "`vibe_construction_v1`.`design`.`change_impact`"
  dimensions:
    - name: "impact_category"
      expr: impact_category
      comment: "Category of the change impact (Cost, Schedule, Quality, Safety, Regulatory) for structured analysis."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity level of the impact (Critical, High, Medium, Low) for risk prioritisation."
    - name: "impact_status"
      expr: impact_status
      comment: "Current status of the impact assessment (Open, Approved, Rejected, Closed)."
    - name: "impact_type"
      expr: impact_type
      comment: "Type of impact (Direct, Indirect, Consequential) for financial analysis."
    - name: "is_approved"
      expr: is_approved
      comment: "Whether the change impact has been formally approved."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the change impact (Accept, Reject, Mitigate) for decision tracking."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of impact assessment for trend analysis of design change exposure."
  measures:
    - name: "total_change_impacts"
      expr: COUNT(1)
      comment: "Total number of change impact assessments. Baseline metric for design change risk management."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total monetary cost impact across all change assessments. Primary financial exposure metric for project cost control."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per change assessment. Benchmarks change complexity and cost exposure per event."
    - name: "approved_cost_impact"
      expr: SUM(CASE WHEN is_approved = TRUE THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact of approved change impacts. Represents committed additional cost to the project."
    - name: "unapproved_cost_impact"
      expr: SUM(CASE WHEN is_approved = FALSE OR is_approved IS NULL THEN cost_impact_amount ELSE 0 END)
      comment: "Total cost impact of unapproved change impacts. Represents pending financial exposure requiring management decision."
    - name: "critical_high_severity_impacts"
      expr: COUNT(CASE WHEN impact_severity IN ('Critical', 'High') THEN 1 END)
      comment: "Number of critical or high severity change impacts. Drives executive escalation and risk mitigation decisions."
    - name: "impact_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_approved = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of change impacts that have been approved. Measures change control governance effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_value_engineering_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks value engineering proposals including estimated and realised savings, approval rates, and implementation status. Directly measures design team contribution to project cost optimisation."
  source: "`vibe_construction_v1`.`design`.`value_engineering_proposal`"
  dimensions:
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the VE proposal (Draft, Submitted, Under Review, Approved, Rejected, Implemented)."
    - name: "client_decision"
      expr: client_decision
      comment: "Client decision on the VE proposal (Accepted, Rejected, Deferred) for client engagement analysis."
    - name: "implementation_status"
      expr: implementation_status
      comment: "Implementation status of approved VE proposals for delivery tracking."
    - name: "originator_discipline"
      expr: originator_discipline
      comment: "Engineering discipline that originated the VE proposal for innovation attribution."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether the VE proposal has environmental impact implications."
    - name: "safety_impact_flag"
      expr: safety_impact_flag
      comment: "Whether the VE proposal has safety impact implications."
    - name: "client_decision_date_month"
      expr: DATE_TRUNC('month', client_decision_date)
      comment: "Month of client decision for trend analysis of VE programme activity."
  measures:
    - name: "total_ve_proposals"
      expr: COUNT(1)
      comment: "Total number of value engineering proposals submitted. Baseline metric for design innovation activity."
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Total estimated cost savings from all VE proposals. Quantifies potential value creation from design optimisation."
    - name: "total_implemented_savings"
      expr: SUM(CAST(implemented_saving_value AS DOUBLE))
      comment: "Total realised cost savings from implemented VE proposals. Measures actual value delivered to the project."
    - name: "avg_estimated_saving_per_proposal"
      expr: AVG(CAST(estimated_cost_saving AS DOUBLE))
      comment: "Average estimated saving per VE proposal. Benchmarks VE programme quality and ambition."
    - name: "ve_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_decision = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VE proposals accepted by the client. Measures design team credibility and proposal quality."
    - name: "savings_realisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(implemented_saving_value AS DOUBLE)) / NULLIF(SUM(CAST(estimated_cost_saving AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated savings actually realised through implementation. Measures VE programme delivery effectiveness."
    - name: "approved_pending_implementation"
      expr: COUNT(CASE WHEN client_decision = 'Accepted' AND implementation_status NOT IN ('Completed', 'Implemented') THEN 1 END)
      comment: "Approved VE proposals not yet implemented. Tracks unrealised savings pipeline requiring follow-through."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_handover_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks design handover package completeness, submission performance, and client acceptance. Critical for project closeout governance and DLP (Defects Liability Period) management."
  source: "`vibe_construction_v1`.`design`.`handover_package`"
  dimensions:
    - name: "package_status"
      expr: package_status
      comment: "Current status of the handover package (Draft, Submitted, Under Review, Accepted, Rejected)."
    - name: "package_type"
      expr: package_type
      comment: "Type of handover package (As-Built, O&M Manual, Commissioning, etc.) for category analysis."
    - name: "client_acceptance_status"
      expr: client_acceptance_status
      comment: "Client acceptance status for the handover package, indicating project closeout readiness."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Whether the package meets ISO 19650 BIM information management standards."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether the package is under legal hold, indicating contractual or dispute risk."
    - name: "planned_submission_date_month"
      expr: DATE_TRUNC('month', planned_submission_date)
      comment: "Month of planned submission for handover schedule analysis."
  measures:
    - name: "total_handover_packages"
      expr: COUNT(1)
      comment: "Total number of handover packages. Baseline metric for project closeout progress."
    - name: "client_accepted_packages"
      expr: COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of handover packages accepted by the client. Measures project closeout achievement."
    - name: "client_acceptance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN client_acceptance_status = 'Accepted' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handover packages accepted by the client. Key project closeout KPI for executive reporting."
    - name: "avg_completeness_pct"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across all handover packages. Measures overall handover readiness."
    - name: "avg_dlp_duration_days"
      expr: AVG(CAST(dlp_duration_days AS DOUBLE))
      comment: "Average Defects Liability Period duration in days. Informs post-handover warranty obligation planning."
    - name: "iso_19650_compliant_packages"
      expr: COUNT(CASE WHEN iso_19650_compliance_flag = TRUE THEN 1 END)
      comment: "Number of packages meeting ISO 19650 BIM standards. Tracks digital information management compliance."
    - name: "overdue_submissions"
      expr: COUNT(CASE WHEN package_status NOT IN ('Accepted', 'Closed') AND planned_submission_date < CURRENT_DATE() THEN 1 END)
      comment: "Handover packages past their planned submission date. Directly indicates project closeout schedule risk."
    - name: "packages_on_legal_hold"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of handover packages under legal hold. Flags contractual or dispute risk requiring legal attention."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_interface_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors design interface management performance including open interfaces, cost impacts, and coordination effectiveness. Critical for multi-contractor project coordination and scope boundary management."
  source: "`vibe_construction_v1`.`design`.`interface_point`"
  dimensions:
    - name: "interface_status"
      expr: interface_status
      comment: "Current status of the interface point (Open, Agreed, Closed, Disputed) for pipeline management."
    - name: "interface_type"
      expr: interface_type
      comment: "Type of interface (Physical, Functional, Data, Contractual) for categorised analysis."
    - name: "interface_category"
      expr: interface_category
      comment: "Category of the interface for structured coordination management."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the interface point."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the interface (High, Medium, Low) for prioritised management attention."
    - name: "priority"
      expr: priority
      comment: "Priority of the interface point for resource allocation."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "BIM clash detection status for the interface, linking coordination to design quality."
  measures:
    - name: "total_interface_points"
      expr: COUNT(1)
      comment: "Total number of interface points. Baseline metric for multi-contractor coordination complexity."
    - name: "open_interfaces"
      expr: COUNT(CASE WHEN interface_status = 'Open' THEN 1 END)
      comment: "Number of open interface points. High counts indicate coordination risk and potential construction delays."
    - name: "interface_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN interface_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interface points closed. Measures coordination programme effectiveness."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact from interface issues. Quantifies financial exposure from coordination failures."
    - name: "avg_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per interface point. Benchmarks interface management financial risk."
    - name: "high_risk_interfaces"
      expr: COUNT(CASE WHEN risk_level = 'High' THEN 1 END)
      comment: "Number of high-risk interface points. Drives executive escalation and priority resource allocation."
    - name: "overdue_interfaces"
      expr: COUNT(CASE WHEN interface_status = 'Open' AND planned_handover_date < CURRENT_DATE() THEN 1 END)
      comment: "Interface points past their planned handover date. Directly indicates coordination schedule risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_mep_coordination_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks MEP coordination zone progress, clash resolution, and spatial coordination effectiveness. Enables management of building services coordination to prevent costly construction rework."
  source: "`vibe_construction_v1`.`design`.`mep_coordination_zone`"
  dimensions:
    - name: "coordination_status"
      expr: coordination_status
      comment: "Current coordination status of the MEP zone (Not Started, In Progress, Coordinated, Signed Off)."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "BIM clash detection status for the zone, indicating coordination quality."
    - name: "primary_discipline"
      expr: primary_discipline
      comment: "Primary MEP discipline responsible for the coordination zone."
    - name: "zone_complexity_rating"
      expr: zone_complexity_rating
      comment: "Complexity rating of the coordination zone for resource planning."
    - name: "building_reference"
      expr: building_reference
      comment: "Building reference for spatial analysis of coordination progress."
    - name: "level_reference"
      expr: level_reference
      comment: "Floor/level reference for spatial breakdown of coordination status."
    - name: "planned_completion_date_month"
      expr: DATE_TRUNC('month', planned_completion_date)
      comment: "Month of planned coordination completion for schedule analysis."
  measures:
    - name: "total_coordination_zones"
      expr: COUNT(1)
      comment: "Total number of MEP coordination zones. Baseline metric for building services coordination scope."
    - name: "coordinated_zones"
      expr: COUNT(CASE WHEN coordination_status IN ('Coordinated', 'Signed Off') THEN 1 END)
      comment: "Number of zones with completed coordination. Measures MEP coordination programme progress."
    - name: "coordination_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coordination_status IN ('Coordinated', 'Signed Off') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of MEP coordination zones completed. Key construction readiness KPI for building services."
    - name: "total_zone_area_sqm"
      expr: SUM(CAST(zone_area_sqm AS DOUBLE))
      comment: "Total area of all MEP coordination zones in square metres. Quantifies coordination programme scope."
    - name: "avg_ceiling_height_m"
      expr: AVG(CAST(ceiling_height_m AS DOUBLE))
      comment: "Average ceiling height across coordination zones. Informs MEP installation feasibility and clearance planning."
    - name: "avg_available_clearance_m"
      expr: AVG(CAST(available_clearance_m AS DOUBLE))
      comment: "Average available clearance in coordination zones. Critical for MEP installation planning and clash prevention."
    - name: "overdue_coordination_zones"
      expr: COUNT(CASE WHEN coordination_status NOT IN ('Coordinated', 'Signed Off') AND planned_completion_date < CURRENT_DATE() THEN 1 END)
      comment: "MEP coordination zones past their planned completion date. Indicates construction schedule risk from services coordination delays."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`design_document_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures document register health including controlled document compliance, review status, and information management maturity. Supports ISO 19650 compliance and design information governance."
  source: "`vibe_construction_v1`.`design`.`document_register`"
  dimensions:
    - name: "document_register_status"
      expr: document_register_status
      comment: "Current status of the document in the register (Current, Superseded, Archived, Under Review)."
    - name: "document_type"
      expr: document_type
      comment: "Type of document (Drawing, Specification, Report, Calculation, etc.) for category analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline of the document for discipline-level information management analysis."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Whether the document is a controlled document requiring formal revision management."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Whether the document is a contractual client deliverable."
    - name: "confidentiality_classification"
      expr: confidentiality_classification
      comment: "Confidentiality classification of the document for information security governance."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of document issue for trend analysis of design information production."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of documents in the register. Baseline metric for design information management scope."
    - name: "controlled_documents"
      expr: COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END)
      comment: "Number of controlled documents. Measures formal document management compliance."
    - name: "client_deliverable_documents"
      expr: COUNT(CASE WHEN is_client_deliverable = TRUE THEN 1 END)
      comment: "Number of contractual client deliverable documents. Tracks delivery obligation fulfilment."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all registered documents in MB. Supports document management infrastructure planning."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average file size per document. Benchmarks document complexity and storage requirements."
    - name: "overdue_reviews"
      expr: COUNT(CASE WHEN document_register_status NOT IN ('Approved', 'Archived') AND review_due_date < CURRENT_DATE() THEN 1 END)
      comment: "Documents past their review due date. Indicates information management governance failures."
    - name: "controlled_document_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_controlled_document = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents under formal controlled document management. Measures ISO 19650 compliance maturity."
$$;