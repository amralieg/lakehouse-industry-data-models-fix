-- Metric views for domain: quality | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational quality inspection KPIs covering pass/fail outcomes, reinspection rates, NCR raise rates, and environmental conditions at time of inspection. Drives quality assurance steering decisions across projects and disciplines."
  source: "`vibe_construction_v1`.`quality`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g. structural, electrical, civil) — used to segment quality performance by discipline."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (e.g. pending, completed, cancelled)."
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "Final pass/fail/conditional outcome of the inspection — primary quality result dimension."
    - name: "location_type"
      expr: location_type
      comment: "Type of location where inspection was conducted (e.g. on-site, off-site, factory)."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection date — enables trend analysis of inspection volumes and outcomes over time."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Flag indicating whether a corrective action was mandated as a result of this inspection."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Flag indicating whether a reinspection was required following the initial inspection outcome."
    - name: "ncr_raised"
      expr: ncr_raised
      comment: "Flag indicating whether a Non-Conformance Report was raised as a result of this inspection."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables project-level quality performance segmentation."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Baseline volume KPI for quality activity tracking."
    - name: "ncr_raise_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN ncr_raised = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that resulted in an NCR being raised. A rising rate signals systemic quality failures requiring executive intervention."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reinspection_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. High rates indicate rework loops and schedule/cost risk."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections triggering a corrective action. Directly linked to quality cost and schedule impact."
    - name: "avg_temperature_celsius"
      expr: ROUND(AVG(CAST(temperature_celsius AS DOUBLE)), 2)
      comment: "Average ambient temperature at time of inspection. Extreme temperatures correlate with material and workmanship defects in construction."
    - name: "avg_humidity_percent"
      expr: ROUND(AVG(CAST(humidity_percent AS DOUBLE)), 2)
      comment: "Average humidity at time of inspection. High humidity is a leading indicator of concrete, coating, and structural quality risk."
    - name: "inspections_with_ncr"
      expr: SUM(CASE WHEN ncr_raised = TRUE THEN 1 ELSE 0 END)
      comment: "Absolute count of inspections that generated an NCR. Used alongside ncr_raise_rate_pct for volume-weighted quality steering."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_ncr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Non-Conformance Report (NCR) KPIs covering cost impact, closure performance, severity distribution, and systemic issue rates. Core quality governance metric view for executive and project steering."
  source: "`vibe_construction_v1`.`quality`.`ncr`"
  dimensions:
    - name: "ncr_status"
      expr: ncr_status
      comment: "Current lifecycle status of the NCR (e.g. open, closed, under review) — primary operational dimension."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the non-conformance (e.g. critical, major, minor) — drives prioritisation and escalation decisions."
    - name: "category"
      expr: category
      comment: "Category of non-conformance (e.g. material, workmanship, design) — used for root cause trend analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the NCR — enables discipline-level quality benchmarking."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for the NCR (e.g. repair, reject, use-as-is) — informs rework cost and schedule impact."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the NCR was identified — enables trend analysis of non-conformance emergence over time."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables project-level NCR performance comparison."
    - name: "hold_status"
      expr: hold_status
      comment: "Flag indicating whether work is on hold pending NCR resolution — directly linked to schedule risk."
    - name: "client_notification_required"
      expr: client_notification_required
      comment: "Flag indicating whether the client must be notified of this NCR — relevant for contractual compliance tracking."
  measures:
    - name: "total_ncrs"
      expr: COUNT(1)
      comment: "Total number of NCRs raised. Baseline quality non-conformance volume KPI."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated financial cost of all non-conformances. Directly informs quality cost of poor quality (COPQ) reporting for executive review."
    - name: "avg_estimated_cost_impact"
      expr: ROUND(AVG(CAST(estimated_cost_impact AS DOUBLE)), 2)
      comment: "Average estimated cost impact per NCR. Enables benchmarking of NCR severity and cost efficiency of quality controls."
    - name: "total_quantity_affected"
      expr: SUM(CAST(quantity_affected AS DOUBLE))
      comment: "Total quantity of material or work affected by non-conformances. Indicates scale of rework and material waste."
    - name: "open_ncr_count"
      expr: SUM(CASE WHEN ncr_status NOT IN ('Closed', 'closed') THEN 1 ELSE 0 END)
      comment: "Count of NCRs not yet closed. A high open count signals quality backlog and potential schedule/handover risk."
    - name: "critical_ncr_count"
      expr: SUM(CASE WHEN severity IN ('Critical', 'critical', 'HIGH', 'High') THEN 1 ELSE 0 END)
      comment: "Count of high-severity NCRs. Executives use this to assess project quality risk and potential regulatory exposure."
    - name: "hold_status_ncr_count"
      expr: SUM(CASE WHEN hold_status = TRUE THEN 1 ELSE 0 END)
      comment: "Number of NCRs currently placing work on hold. Directly quantifies schedule risk from quality non-conformances."
    - name: "client_notification_ncr_count"
      expr: SUM(CASE WHEN client_notification_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of NCRs requiring client notification. Tracks contractual quality disclosure obligations and client relationship risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corrective action KPIs measuring cost of remediation, closure timeliness, systemic issue rates, and effectiveness review outcomes. Enables quality management teams and executives to assess the efficiency and completeness of quality remediation programs."
  source: "`vibe_construction_v1`.`quality`.`corrective_action`"
  dimensions:
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action (e.g. open, in-progress, closed, overdue) — primary operational dimension."
    - name: "action_type"
      expr: action_type
      comment: "Type of corrective action taken (e.g. rework, repair, replacement, process change) — used for cost and effort analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the corrective action — drives resource allocation and escalation decisions."
    - name: "effectiveness_review_outcome"
      expr: effectiveness_review_outcome
      comment: "Outcome of the effectiveness review (e.g. effective, partially effective, ineffective) — key quality system maturity indicator."
    - name: "is_systemic_issue"
      expr: is_systemic_issue
      comment: "Flag indicating whether the root cause is systemic rather than isolated — systemic issues require process-level intervention."
    - name: "requires_design_change"
      expr: requires_design_change
      comment: "Flag indicating whether the corrective action requires a design change — signals engineering rework cost and schedule impact."
    - name: "assigned_date_month"
      expr: DATE_TRUNC('MONTH', assigned_date)
      comment: "Month the corrective action was assigned — enables trend analysis of remediation workload over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which corrective action costs are denominated — required for multi-currency project cost aggregation."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of corrective actions raised. Baseline remediation activity volume KPI."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for corrective actions. Core cost of poor quality (COPQ) metric for executive financial review."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated cost of corrective actions. Used alongside actual cost to assess cost estimation accuracy and budget exposure."
    - name: "avg_actual_cost"
      expr: ROUND(AVG(CAST(actual_cost AS DOUBLE)), 2)
      comment: "Average actual cost per corrective action. Benchmarks remediation cost efficiency across projects and action types."
    - name: "systemic_issue_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_systemic_issue = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions classified as systemic issues. High rates indicate process-level quality failures requiring strategic intervention."
    - name: "design_change_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_design_change = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions requiring a design change. Signals engineering quality risk and downstream rework cost."
    - name: "cost_overrun_total"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost overrun across corrective actions (actual minus estimate). Negative values indicate under-spend; positive values indicate budget blowout on quality remediation."
    - name: "open_corrective_actions"
      expr: SUM(CASE WHEN action_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 ELSE 0 END)
      comment: "Count of corrective actions not yet closed. Tracks quality remediation backlog and associated schedule/cost risk."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch item KPIs tracking pre-handover defect volumes, cost impact, closure rates, and DLP deferral rates. Critical for project completion governance, handover readiness, and defect liability period management."
  source: "`vibe_construction_v1`.`quality`.`punch_item`"
  dimensions:
    - name: "punch_item_status"
      expr: punch_item_status
      comment: "Current status of the punch item (e.g. open, closed, deferred) — primary handover readiness dimension."
    - name: "category"
      expr: category
      comment: "Category of the punch item defect (e.g. structural, finishing, mechanical) — used for discipline-level defect analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch item — drives closure sequencing and resource allocation for handover."
    - name: "closure_status"
      expr: closure_status
      comment: "Closure status of the punch item — used to track handover gate readiness."
    - name: "deferred_to_dlp"
      expr: deferred_to_dlp
      comment: "Flag indicating whether the punch item has been deferred to the Defect Liability Period — impacts client satisfaction and DLP cost exposure."
    - name: "identified_date_month"
      expr: DATE_TRUNC('MONTH', identified_date)
      comment: "Month the punch item was identified — enables trend analysis of defect emergence during construction and commissioning."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables project-level punch item performance benchmarking."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the punch item cost impact — required for multi-currency project financial reporting."
  measures:
    - name: "total_punch_items"
      expr: COUNT(1)
      comment: "Total number of punch items raised. Baseline defect volume KPI for handover readiness assessment."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact AS DOUBLE))
      comment: "Total financial cost impact of all punch items. Directly informs project completion cost exposure and client contractual risk."
    - name: "avg_cost_impact"
      expr: ROUND(AVG(CAST(cost_impact AS DOUBLE)), 2)
      comment: "Average cost impact per punch item. Benchmarks defect remediation cost efficiency across projects and categories."
    - name: "open_punch_items"
      expr: SUM(CASE WHEN punch_item_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 ELSE 0 END)
      comment: "Count of open punch items. Directly measures handover readiness — high open counts block project completion milestones."
    - name: "dlp_deferral_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deferred_to_dlp = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of punch items deferred to the Defect Liability Period. High rates signal handover quality risk and future warranty cost exposure."
    - name: "dlp_deferred_cost_impact"
      expr: SUM(CASE WHEN deferred_to_dlp = TRUE THEN CAST(cost_impact AS DOUBLE) ELSE 0 END)
      comment: "Total cost impact of punch items deferred to DLP. Quantifies the financial liability carried into the post-handover warranty period."
    - name: "distinct_projects_with_open_items"
      expr: COUNT(DISTINCT CASE WHEN punch_item_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN construction_project_id END)
      comment: "Number of distinct projects with at least one open punch item. Enables portfolio-level handover risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_punch_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Punch list KPIs measuring completion percentage, closeout timeliness, and handover gate readiness across projects. Enables project directors and clients to assess construction completion status at a list level."
  source: "`vibe_construction_v1`.`quality`.`punch_list`"
  dimensions:
    - name: "punch_list_status"
      expr: punch_list_status
      comment: "Current status of the punch list (e.g. open, closed, in-progress) — primary completion tracking dimension."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline associated with the punch list — enables discipline-level completion benchmarking."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of project milestone the punch list is associated with (e.g. mechanical completion, handover) — drives gate readiness analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the punch list — used to focus closeout resources on highest-impact lists."
    - name: "handover_gate"
      expr: handover_gate
      comment: "Flag indicating whether this punch list is a handover gate requirement — directly linked to project completion milestones."
    - name: "dlp_commencement_gate"
      expr: dlp_commencement_gate
      comment: "Flag indicating whether this punch list must be closed before DLP commences — impacts warranty period start and client obligations."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables project-level punch list completion benchmarking."
    - name: "creation_date_month"
      expr: DATE_TRUNC('MONTH', creation_date)
      comment: "Month the punch list was created — enables trend analysis of defect list emergence over the project lifecycle."
  measures:
    - name: "total_punch_lists"
      expr: COUNT(1)
      comment: "Total number of punch lists. Baseline volume KPI for completion management activity."
    - name: "avg_completion_percentage"
      expr: ROUND(AVG(CAST(completion_percentage AS DOUBLE)), 2)
      comment: "Average completion percentage across all punch lists. Primary KPI for overall project handover readiness — executives use this to assess completion risk."
    - name: "handover_gate_punch_lists"
      expr: SUM(CASE WHEN handover_gate = TRUE THEN 1 ELSE 0 END)
      comment: "Count of punch lists that are handover gate requirements. Tracks the volume of completion blockers for project handover."
    - name: "open_handover_gate_punch_lists"
      expr: SUM(CASE WHEN handover_gate = TRUE AND punch_list_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 ELSE 0 END)
      comment: "Count of open punch lists that are handover gate requirements. Directly measures handover readiness risk — any non-zero value blocks project completion."
    - name: "dlp_gate_punch_lists_open"
      expr: SUM(CASE WHEN dlp_commencement_gate = TRUE AND punch_list_status NOT IN ('Closed', 'closed', 'Completed', 'completed') THEN 1 ELSE 0 END)
      comment: "Count of open punch lists blocking DLP commencement. Quantifies warranty period start risk and associated contractual exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_test_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Test certificate KPIs tracking pass/fail rates, certificate validity, and expiry risk across materials and equipment. Ensures regulatory compliance and material quality assurance for construction projects."
  source: "`vibe_construction_v1`.`quality`.`test_certificate`"
  dimensions:
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of test certificate (e.g. material test report, weld certificate, pressure test) — primary compliance classification dimension."
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate (e.g. valid, expired, pending) — used for compliance risk monitoring."
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail result of the test — primary quality outcome dimension for material and equipment certification."
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested — enables material-level quality compliance benchmarking."
    - name: "test_method"
      expr: test_method
      comment: "Test method applied (e.g. tensile, hardness, NDT) — used for test methodology quality analysis."
    - name: "issuing_laboratory"
      expr: issuing_laboratory
      comment: "Laboratory that issued the certificate — enables laboratory performance and accreditation tracking."
    - name: "test_date_month"
      expr: DATE_TRUNC('MONTH', test_date)
      comment: "Month of the test — enables trend analysis of testing activity and pass rates over time."
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Foreign key to the construction project — enables project-level material compliance benchmarking."
  measures:
    - name: "total_test_certificates"
      expr: COUNT(1)
      comment: "Total number of test certificates issued. Baseline material and equipment quality compliance volume KPI."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status IN ('Pass', 'pass', 'PASS') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of test certificates with a passing result. Core material quality compliance KPI — low pass rates signal systemic material or supplier quality failures."
    - name: "fail_count"
      expr: SUM(CASE WHEN pass_fail_status IN ('Fail', 'fail', 'FAIL') THEN 1 ELSE 0 END)
      comment: "Absolute count of failed test certificates. Used alongside pass rate to quantify material rejection volume and associated procurement/rework cost."
    - name: "expired_certificate_count"
      expr: SUM(CASE WHEN certificate_expiry_date < CURRENT_DATE() THEN 1 ELSE 0 END)
      comment: "Count of certificates that have passed their expiry date. Expired certificates represent active regulatory compliance risk and must be escalated immediately."
    - name: "expiring_within_30_days_count"
      expr: SUM(CASE WHEN certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN 1 ELSE 0 END)
      comment: "Count of certificates expiring within the next 30 days. Leading indicator of upcoming compliance risk — enables proactive renewal management."
    - name: "distinct_laboratories"
      expr: COUNT(DISTINCT issuing_laboratory)
      comment: "Number of distinct laboratories issuing certificates. Tracks laboratory diversification and dependency risk in the quality assurance supply chain."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`quality_checklist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality checklist KPIs measuring average pass rates, hold point coverage, and checklist utilisation across inspection types and disciplines. Enables quality managers to assess the effectiveness and coverage of quality control procedures."
  source: "`vibe_construction_v1`.`quality`.`checklist`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection the checklist is designed for — primary classification dimension for checklist performance analysis."
    - name: "inspection_stage"
      expr: inspection_stage
      comment: "Stage of construction at which the checklist applies (e.g. pre-pour, post-weld) — enables stage-level quality control analysis."
    - name: "discipline"
      expr: discipline
      comment: "Engineering or trade discipline the checklist covers — enables discipline-level quality procedure benchmarking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the checklist (e.g. approved, draft, superseded) — ensures only approved checklists are used in quality analysis."
    - name: "hold_point_flag"
      expr: hold_point_flag
      comment: "Flag indicating whether the checklist contains a hold point requiring third-party sign-off — critical for regulatory and client compliance."
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether the checklist is mandatory for the associated activity — used to track compliance with quality plan requirements."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of construction activity the checklist is associated with — enables activity-level quality control coverage analysis."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the checklist became effective — used to track quality procedure currency and revision cycles."
  measures:
    - name: "total_checklists"
      expr: COUNT(1)
      comment: "Total number of quality checklists in the register. Baseline quality procedure coverage KPI."
    - name: "avg_pass_rate"
      expr: ROUND(AVG(CAST(average_pass_rate AS DOUBLE)), 2)
      comment: "Average pass rate across all checklists. Primary quality effectiveness KPI — low average pass rates indicate systemic workmanship or specification compliance issues."
    - name: "hold_point_checklist_count"
      expr: SUM(CASE WHEN hold_point_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of checklists containing hold points. Tracks the volume of quality control activities requiring mandatory third-party or client witness sign-off."
    - name: "mandatory_checklist_count"
      expr: SUM(CASE WHEN mandatory_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mandatory checklists. Used to assess the scope of non-negotiable quality control requirements across the project."
    - name: "approved_checklist_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status IN ('Approved', 'approved', 'APPROVED') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checklists with approved status. Low rates indicate quality procedure governance gaps — unapproved checklists represent compliance risk."
$$;