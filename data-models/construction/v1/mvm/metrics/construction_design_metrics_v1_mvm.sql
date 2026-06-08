-- Metric views for domain: design | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_bim_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BIM model quality, compliance, and size metrics supporting design governance and ISO 19650 adherence across construction projects."
  source: "`construction_ecm`.`design`.`bim_model`"
  dimensions:
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g. Structural, MEP, Civil) for cross-discipline BIM performance analysis."
    - name: "model_type"
      expr: model_type
      comment: "Type of BIM model (e.g. Architectural, Structural, Services) to segment model portfolio."
    - name: "model_status"
      expr: model_status
      comment: "Current lifecycle status of the BIM model (e.g. In Progress, Approved, Superseded)."
    - name: "lod_classification"
      expr: lod_classification
      comment: "Level of Development classification indicating model maturity and detail level."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Project lifecycle stage the model belongs to (e.g. Design, Construction, Handover)."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Status of clash detection run against this model (e.g. Passed, Failed, Pending)."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Whether the BIM model is compliant with ISO 19650 information management standard."
    - name: "authoring_software"
      expr: authoring_software
      comment: "Software used to author the model (e.g. Revit, ArchiCAD) for tooling standardisation analysis."
    - name: "issue_date"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of model issue date for trend analysis of model release cadence."
  measures:
    - name: "total_bim_models"
      expr: COUNT(DISTINCT bim_model_id)
      comment: "Total number of distinct BIM models in the portfolio — baseline KPI for design asset inventory."
    - name: "iso_19650_compliant_models"
      expr: COUNT(DISTINCT CASE WHEN iso_19650_compliance_flag = TRUE THEN bim_model_id END)
      comment: "Count of BIM models that are ISO 19650 compliant, indicating adherence to international information management standards."
    - name: "models_with_clashes"
      expr: COUNT(DISTINCT CASE WHEN clash_detection_status = 'Failed' THEN bim_model_id END)
      comment: "Number of BIM models with unresolved clash detection failures — a leading indicator of rework risk and coordination quality."
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total storage footprint of all BIM models in megabytes — informs infrastructure and data management planning."
    - name: "avg_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average BIM model file size in MB — helps identify bloated models that may indicate over-modelling or inefficiency."
    - name: "superseded_model_count"
      expr: COUNT(DISTINCT CASE WHEN superseded_by_model_bim_model_id IS NOT NULL THEN bim_model_id END)
      comment: "Number of BIM models that have been superseded — tracks model churn and revision frequency."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_change_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design change notice metrics tracking cost impact, schedule impact, and change management efficiency across construction projects."
  source: "`construction_ecm`.`design`.`change_notice`"
  dimensions:
    - name: "change_notice_type"
      expr: change_notice_type
      comment: "Category of change notice (e.g. Design Change, Scope Change, Regulatory) for root-cause analysis."
    - name: "change_notice_status"
      expr: change_notice_status
      comment: "Current workflow status of the change notice (e.g. Open, Approved, Rejected, Closed)."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline originating the change notice for discipline-level change burden analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the change notice (e.g. High, Medium, Low) for triage and escalation management."
    - name: "originating_cause"
      expr: originating_cause
      comment: "Root cause category of the change (e.g. Client Request, Design Error, Regulatory) to drive corrective action."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Indicates whether the change notice carries a cost impact, enabling financial exposure filtering."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Indicates whether the change notice carries a schedule impact for programme risk analysis."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flags change notices driven by regulatory compliance requirements."
    - name: "date_raised_month"
      expr: DATE_TRUNC('month', date_raised)
      comment: "Month the change notice was raised for trend analysis of change frequency over time."
  measures:
    - name: "total_change_notices"
      expr: COUNT(DISTINCT change_notice_id)
      comment: "Total number of design change notices raised — baseline measure of change volume and design instability."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact across all change notices — critical financial exposure KPI for project budget governance."
    - name: "total_actual_cost_impact"
      expr: SUM(CAST(actual_cost_impact_amount AS DOUBLE))
      comment: "Total actual cost impact realised from change notices — measures true financial consequence of design changes."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per change notice — benchmarks the typical financial weight of a design change."
    - name: "cost_impact_change_notices"
      expr: COUNT(DISTINCT CASE WHEN cost_impact_flag = TRUE THEN change_notice_id END)
      comment: "Number of change notices with a confirmed cost impact — quantifies the proportion of changes driving budget exposure."
    - name: "schedule_impact_change_notices"
      expr: COUNT(DISTINCT CASE WHEN schedule_impact_flag = TRUE THEN change_notice_id END)
      comment: "Number of change notices with a confirmed schedule impact — key programme risk indicator."
    - name: "open_change_notices"
      expr: COUNT(DISTINCT CASE WHEN change_notice_status NOT IN ('Closed', 'Rejected') THEN change_notice_id END)
      comment: "Count of change notices not yet closed or rejected — measures outstanding change management backlog."
    - name: "cost_vs_estimate_variance"
      expr: SUM((CAST(actual_cost_impact_amount AS DOUBLE)) - (CAST(estimated_cost_impact_amount AS DOUBLE)))
      comment: "Aggregate variance between actual and estimated cost impact — measures accuracy of change cost estimation and potential budget overrun."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_rfi`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Request for Information (RFI) performance metrics tracking response timeliness, cost/schedule impact, and design query resolution efficiency."
  source: "`construction_ecm`.`design`.`rfi`"
  dimensions:
    - name: "rfi_status"
      expr: rfi_status
      comment: "Current status of the RFI (e.g. Open, Answered, Closed) for pipeline and backlog analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline that raised the RFI for discipline-level query burden analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFI (e.g. High, Medium, Low) for escalation and triage management."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Indicates whether the RFI has a cost impact, enabling financial exposure filtering."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Indicates whether the RFI has a schedule impact for programme risk analysis."
    - name: "date_raised_month"
      expr: DATE_TRUNC('month', date_raised)
      comment: "Month the RFI was raised for trend analysis of query volume over time."
  measures:
    - name: "total_rfis"
      expr: COUNT(DISTINCT rfi_id)
      comment: "Total number of RFIs raised — baseline measure of design query volume and information gap frequency."
    - name: "open_rfis"
      expr: COUNT(DISTINCT CASE WHEN rfi_status NOT IN ('Closed', 'Answered') THEN rfi_id END)
      comment: "Number of RFIs not yet answered or closed — measures outstanding design query backlog and potential programme risk."
    - name: "rfis_with_cost_impact"
      expr: COUNT(DISTINCT CASE WHEN cost_impact_flag = TRUE THEN rfi_id END)
      comment: "Number of RFIs with a confirmed cost impact — quantifies financial exposure from unresolved design queries."
    - name: "total_rfi_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total cost impact amount across all RFIs — measures cumulative financial consequence of design information gaps."
    - name: "avg_rfi_cost_impact"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per RFI — benchmarks the typical financial weight of a design query."
    - name: "rfis_with_schedule_impact"
      expr: COUNT(DISTINCT CASE WHEN schedule_impact_flag = TRUE THEN rfi_id END)
      comment: "Number of RFIs with a confirmed schedule impact — key programme risk indicator from design information gaps."
    - name: "overdue_rfis"
      expr: COUNT(DISTINCT CASE WHEN rfi_status NOT IN ('Closed', 'Answered') AND response_due_date < CURRENT_DATE() THEN rfi_id END)
      comment: "Number of RFIs past their response due date without closure — measures SLA breach rate and design team responsiveness."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_submittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Submittal management metrics tracking approval rates, cost/schedule impact, and compliance across design deliverables submitted for client or regulatory review."
  source: "`construction_ecm`.`design`.`submittal`"
  dimensions:
    - name: "submittal_status"
      expr: submittal_status
      comment: "Current status of the submittal (e.g. Pending, Approved, Rejected, Revise and Resubmit)."
    - name: "submittal_type"
      expr: submittal_type
      comment: "Type of submittal (e.g. Shop Drawing, Material Sample, Method Statement) for category-level performance analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the submittal for discipline-level throughput analysis."
    - name: "approval_disposition"
      expr: approval_disposition
      comment: "Final disposition of the submittal review (e.g. Approved, Approved as Noted, Rejected) for quality benchmarking."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flags submittals with regulatory compliance requirements for compliance-driven reporting."
    - name: "cost_impact_flag"
      expr: cost_impact_flag
      comment: "Indicates whether the submittal carries a cost impact."
    - name: "schedule_impact_flag"
      expr: schedule_impact_flag
      comment: "Indicates whether the submittal carries a schedule impact."
    - name: "actual_submission_month"
      expr: DATE_TRUNC('month', actual_submission_date)
      comment: "Month of actual submission for trend analysis of submittal throughput over time."
  measures:
    - name: "total_submittals"
      expr: COUNT(DISTINCT submittal_id)
      comment: "Total number of submittals — baseline measure of design deliverable volume."
    - name: "approved_submittals"
      expr: COUNT(DISTINCT CASE WHEN approval_disposition = 'Approved' THEN submittal_id END)
      comment: "Number of submittals approved without conditions — measures first-pass approval success rate numerator."
    - name: "rejected_submittals"
      expr: COUNT(DISTINCT CASE WHEN approval_disposition = 'Rejected' THEN submittal_id END)
      comment: "Number of rejected submittals — measures design quality and rework burden."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Total estimated cost impact from submittals — measures financial exposure from design deliverable issues."
    - name: "avg_estimated_cost_impact"
      expr: AVG(CAST(estimated_cost_impact_amount AS DOUBLE))
      comment: "Average estimated cost impact per submittal — benchmarks typical financial consequence of submittal issues."
    - name: "overdue_submittals"
      expr: COUNT(DISTINCT CASE WHEN submittal_status NOT IN ('Approved', 'Closed') AND review_due_date < CURRENT_DATE() THEN submittal_id END)
      comment: "Number of submittals past their review due date without approval — measures SLA compliance and programme risk."
    - name: "submittals_with_schedule_impact"
      expr: COUNT(DISTINCT CASE WHEN schedule_impact_flag = TRUE THEN submittal_id END)
      comment: "Number of submittals with a confirmed schedule impact — key programme risk indicator from design deliverable delays."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design review performance metrics tracking review cycle efficiency, comment resolution, and clash detection outcomes to govern design quality."
  source: "`construction_ecm`.`design`.`review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of design review (e.g. IFC, IFR, IFA, Clash Detection) for category-level performance benchmarking."
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (e.g. Scheduled, In Progress, Complete, Overdue)."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline under review for discipline-level quality analysis."
    - name: "disposition"
      expr: disposition
      comment: "Overall review outcome/disposition (e.g. Approved, Approved with Comments, Rejected) for quality benchmarking."
    - name: "stage"
      expr: stage
      comment: "Design stage at which the review was conducted (e.g. Concept, Detailed, Construction Issue)."
    - name: "clash_detection_performed"
      expr: clash_detection_performed
      comment: "Whether clash detection was performed as part of the review — tracks BIM coordination discipline."
    - name: "review_date_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month of review date for trend analysis of review cadence and throughput."
  measures:
    - name: "total_reviews"
      expr: COUNT(DISTINCT review_id)
      comment: "Total number of design reviews conducted — baseline measure of review programme activity."
    - name: "total_review_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total hours invested in design reviews — measures resource consumption of the review programme."
    - name: "avg_review_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration per design review in hours — benchmarks review efficiency and identifies outliers."
    - name: "reviews_with_clashes_identified"
      expr: COUNT(DISTINCT CASE WHEN clash_detection_performed = TRUE THEN review_id END)
      comment: "Number of reviews where clash detection was performed — measures BIM coordination coverage across the review programme."
    - name: "approved_reviews"
      expr: COUNT(DISTINCT CASE WHEN disposition = 'Approved' THEN review_id END)
      comment: "Number of reviews resulting in approval — measures first-pass design quality success rate numerator."
    - name: "overdue_reviews"
      expr: COUNT(DISTINCT CASE WHEN review_status NOT IN ('Complete', 'Closed') AND scheduled_date < CURRENT_DATE() THEN review_id END)
      comment: "Number of reviews past their scheduled date without completion — measures review programme SLA compliance."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design package delivery metrics tracking completeness, approval status, and ISO 19650 compliance across design information packages."
  source: "`construction_ecm`.`design`.`package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of design package (e.g. IFC, IFR, IFA, Tender) for category-level delivery performance analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the design package (e.g. In Preparation, Issued, Approved, Superseded)."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the package for discipline-level delivery tracking."
    - name: "approval_workflow_state"
      expr: approval_workflow_state
      comment: "Current state in the approval workflow for governance and bottleneck analysis."
    - name: "client_acceptance_status"
      expr: client_acceptance_status
      comment: "Client acceptance status of the package (e.g. Accepted, Rejected, Under Review) for client satisfaction tracking."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Whether the package meets ISO 19650 information management requirements."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of package issue date for trend analysis of design delivery cadence."
  measures:
    - name: "total_packages"
      expr: COUNT(DISTINCT package_id)
      comment: "Total number of design packages — baseline measure of design deliverable portfolio size."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across all design packages — measures overall design programme readiness."
    - name: "iso_19650_compliant_packages"
      expr: COUNT(DISTINCT CASE WHEN iso_19650_compliance_flag = TRUE THEN package_id END)
      comment: "Number of packages compliant with ISO 19650 — measures information management standard adherence."
    - name: "client_accepted_packages"
      expr: COUNT(DISTINCT CASE WHEN client_acceptance_status = 'Accepted' THEN package_id END)
      comment: "Number of packages accepted by the client — measures design delivery quality and client satisfaction."
    - name: "overdue_packages"
      expr: COUNT(DISTINCT CASE WHEN package_status NOT IN ('Issued', 'Approved', 'Superseded') AND contractual_due_date < CURRENT_DATE() THEN package_id END)
      comment: "Number of packages past their contractual due date without issue — measures design delivery schedule compliance."
    - name: "packages_below_50pct_complete"
      expr: COUNT(DISTINCT CASE WHEN CAST(completeness_percentage AS DOUBLE) < 50.0 THEN package_id END)
      comment: "Number of packages less than 50% complete — identifies at-risk deliverables requiring management intervention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_handover_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project handover package metrics tracking completeness, client acceptance, and DLP (Defects Liability Period) readiness for construction project closeout."
  source: "`construction_ecm`.`design`.`handover_package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of handover package (e.g. O&M Manuals, As-Built Drawings, Commissioning Records) for category analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the handover package (e.g. In Preparation, Submitted, Accepted, Rejected)."
    - name: "client_acceptance_status"
      expr: client_acceptance_status
      comment: "Client acceptance status of the handover package for closeout readiness tracking."
    - name: "iso_19650_compliance_flag"
      expr: iso_19650_compliance_flag
      comment: "Whether the handover package meets ISO 19650 information management requirements."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Indicates whether the handover package is under legal hold — critical for risk and legal exposure management."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of handover package submission for trend analysis of closeout progress."
  measures:
    - name: "total_handover_packages"
      expr: COUNT(DISTINCT handover_package_id)
      comment: "Total number of handover packages — baseline measure of project closeout portfolio."
    - name: "avg_completeness_percentage"
      expr: AVG(CAST(completeness_percentage AS DOUBLE))
      comment: "Average completeness percentage across handover packages — measures overall project closeout readiness."
    - name: "client_accepted_packages"
      expr: COUNT(DISTINCT CASE WHEN client_acceptance_status = 'Accepted' THEN handover_package_id END)
      comment: "Number of handover packages accepted by the client — measures closeout quality and client satisfaction."
    - name: "packages_under_legal_hold"
      expr: COUNT(DISTINCT CASE WHEN legal_hold_flag = TRUE THEN handover_package_id END)
      comment: "Number of handover packages under legal hold — critical risk indicator for project legal exposure."
    - name: "overdue_handover_packages"
      expr: COUNT(DISTINCT CASE WHEN package_status NOT IN ('Accepted', 'Closed') AND planned_submission_date < CURRENT_DATE() THEN handover_package_id END)
      comment: "Number of handover packages past their planned submission date — measures closeout schedule compliance and DLP risk."
    - name: "packages_below_80pct_complete"
      expr: COUNT(DISTINCT CASE WHEN CAST(completeness_percentage AS DOUBLE) < 80.0 THEN handover_package_id END)
      comment: "Number of handover packages below 80% completeness — identifies at-risk closeout deliverables requiring escalation."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_workflow_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design workflow approval metrics tracking SLA compliance, escalation rates, and approval cycle efficiency across document review and approval processes."
  source: "`construction_ecm`.`design`.`workflow_approval`"
  dimensions:
    - name: "workflow_type"
      expr: workflow_type
      comment: "Type of approval workflow (e.g. Document Review, Drawing Approval, Specification Sign-off) for category analysis."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Current status of the workflow (e.g. In Progress, Approved, Rejected, Escalated) for pipeline management."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final outcome of the workflow approval (e.g. Approved, Rejected, Withdrawn) for quality benchmarking."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Authority level required for approval (e.g. Project Manager, Director, Client) for governance analysis."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the workflow was completed within the agreed SLA — key process efficiency indicator."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the workflow was escalated — measures approval bottlenecks and governance issues."
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Flags workflows driven by regulatory requirements for compliance-critical approval tracking."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', CAST(initiated_date AS TIMESTAMP))
      comment: "Month the workflow was initiated for trend analysis of approval volume over time."
  measures:
    - name: "total_workflow_approvals"
      expr: COUNT(DISTINCT workflow_approval_id)
      comment: "Total number of design workflow approvals — baseline measure of approval programme activity."
    - name: "sla_compliant_workflows"
      expr: COUNT(DISTINCT CASE WHEN sla_compliance_flag = TRUE THEN workflow_approval_id END)
      comment: "Number of workflows completed within SLA — measures approval process efficiency and governance health."
    - name: "escalated_workflows"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN workflow_approval_id END)
      comment: "Number of workflows that required escalation — measures approval bottlenecks and decision-making delays."
    - name: "total_sla_actual_hours"
      expr: SUM(CAST(sla_actual_hours AS DOUBLE))
      comment: "Total actual hours consumed across all approval workflows — measures aggregate resource cost of the approval process."
    - name: "avg_sla_actual_hours"
      expr: AVG(CAST(sla_actual_hours AS DOUBLE))
      comment: "Average actual hours per approval workflow — benchmarks approval cycle time and identifies process inefficiencies."
    - name: "approved_workflows"
      expr: COUNT(DISTINCT CASE WHEN overall_outcome = 'Approved' THEN workflow_approval_id END)
      comment: "Number of workflows resulting in approval — measures first-pass approval success rate numerator."
    - name: "regulatory_workflows"
      expr: COUNT(DISTINCT CASE WHEN regulatory_requirement_flag = TRUE THEN workflow_approval_id END)
      comment: "Number of workflows with regulatory requirements — measures compliance-critical approval workload."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_drawing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drawing register metrics tracking drawing portfolio size, revision activity, file size, and client deliverable compliance across construction projects."
  source: "`construction_ecm`.`design`.`drawing`"
  dimensions:
    - name: "drawing_type"
      expr: drawing_type
      comment: "Type of drawing (e.g. General Arrangement, Detail, Schematic) for category-level portfolio analysis."
    - name: "drawing_status"
      expr: drawing_status
      comment: "Current status of the drawing (e.g. In Progress, Issued for Construction, Superseded) for lifecycle tracking."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline responsible for the drawing for discipline-level output analysis."
    - name: "clash_detection_status"
      expr: clash_detection_status
      comment: "Clash detection status of the drawing for BIM coordination quality analysis."
    - name: "is_client_deliverable"
      expr: is_client_deliverable
      comment: "Whether the drawing is a contractual client deliverable — enables client deliverable compliance tracking."
    - name: "is_controlled_document"
      expr: is_controlled_document
      comment: "Whether the drawing is a controlled document subject to formal revision management."
    - name: "issue_purpose"
      expr: issue_purpose
      comment: "Purpose of the drawing issue (e.g. For Construction, For Review, For Approval) for workflow analysis."
    - name: "revision_date_month"
      expr: DATE_TRUNC('month', revision_date)
      comment: "Month of the latest revision date for trend analysis of drawing revision activity."
  measures:
    - name: "total_drawings"
      expr: COUNT(DISTINCT drawing_id)
      comment: "Total number of drawings in the register — baseline measure of design drawing portfolio size."
    - name: "client_deliverable_drawings"
      expr: COUNT(DISTINCT CASE WHEN is_client_deliverable = TRUE THEN drawing_id END)
      comment: "Number of drawings that are contractual client deliverables — measures client deliverable portfolio scope."
    - name: "controlled_drawings"
      expr: COUNT(DISTINCT CASE WHEN is_controlled_document = TRUE THEN drawing_id END)
      comment: "Number of drawings under formal document control — measures governance coverage of the drawing register."
    - name: "total_drawing_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Total file size of all drawings in MB — informs storage infrastructure planning and data management."
    - name: "avg_drawing_file_size_mb"
      expr: AVG(CAST(file_size_mb AS DOUBLE))
      comment: "Average drawing file size in MB — helps identify oversized drawings that may indicate inefficiency."
    - name: "superseded_drawings"
      expr: COUNT(DISTINCT CASE WHEN superseded_by_drawing_number IS NOT NULL THEN drawing_id END)
      comment: "Number of drawings that have been superseded — measures drawing churn and revision frequency."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`design_transmittal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transmittal metrics tracking document distribution efficiency, acknowledgement compliance, and communication timeliness across design information exchanges."
  source: "`construction_ecm`.`design`.`transmittal`"
  dimensions:
    - name: "transmittal_status"
      expr: transmittal_status
      comment: "Current status of the transmittal (e.g. Issued, Acknowledged, Overdue) for pipeline management."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the transmittal for discipline-level communication analysis."
    - name: "purpose_of_issue"
      expr: purpose_of_issue
      comment: "Purpose for which documents were transmitted (e.g. For Construction, For Review, For Approval)."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the transmittal (e.g. Email, Portal, Hard Copy) for channel analysis."
    - name: "acknowledgement_required_flag"
      expr: acknowledgement_required_flag
      comment: "Whether acknowledgement is required from the recipient — enables SLA compliance tracking."
    - name: "acknowledgement_status"
      expr: acknowledgement_status
      comment: "Current acknowledgement status (e.g. Pending, Acknowledged, Overdue) for compliance monitoring."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of transmittal issue date for trend analysis of document distribution activity."
  measures:
    - name: "total_transmittals"
      expr: COUNT(DISTINCT transmittal_id)
      comment: "Total number of transmittals issued — baseline measure of design information distribution activity."
    - name: "transmittals_requiring_acknowledgement"
      expr: COUNT(DISTINCT CASE WHEN acknowledgement_required_flag = TRUE THEN transmittal_id END)
      comment: "Number of transmittals requiring formal acknowledgement — measures contractual communication compliance scope."
    - name: "acknowledged_transmittals"
      expr: COUNT(DISTINCT CASE WHEN acknowledgement_status = 'Acknowledged' THEN transmittal_id END)
      comment: "Number of transmittals formally acknowledged by recipients — measures communication compliance rate numerator."
    - name: "overdue_transmittals"
      expr: COUNT(DISTINCT CASE WHEN transmittal_status NOT IN ('Acknowledged', 'Closed') AND due_date < CURRENT_DATE() THEN transmittal_id END)
      comment: "Number of transmittals past their due date without acknowledgement — measures communication SLA breach rate."
$$;