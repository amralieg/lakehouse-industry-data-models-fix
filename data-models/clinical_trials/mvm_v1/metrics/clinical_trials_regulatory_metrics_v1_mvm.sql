-- Metric views for domain: regulatory | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-07 02:29:00

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory submission activity, pipeline health, and agency responsiveness across all submission types and health authorities. Core KPI surface for regulatory operations leadership."
  source: "`clinical_trials_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., IND, NDA, BLA, MAA) used to segment submission volume and performance by regulatory pathway."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Accepted, Under Review, Approved, Rejected) for pipeline stage analysis."
    - name: "submission_category"
      expr: submission_category
      comment: "Categorical grouping of submissions (e.g., Original, Amendment, Supplement) to distinguish new filings from lifecycle management activities."
    - name: "agency_country_code"
      expr: agency_country_code
      comment: "Country code of the receiving health authority, enabling geographic breakdown of submission activity and approval timelines."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the submission, supporting portfolio-level regulatory performance analysis."
    - name: "regulatory_procedure_type"
      expr: regulatory_procedure_type
      comment: "Regulatory review procedure type (e.g., Centralised, Decentralised, Mutual Recognition) for procedural performance benchmarking."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the submission is on an expedited review pathway, used to track accelerated program utilization."
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Flag indicating whether this is a resubmission following a prior rejection or refusal to file, used to track rework rates."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Calendar year of submission date for year-over-year trend analysis of submission volume and performance."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month of submission date for monthly cadence tracking of submission throughput."
    - name: "agency_decision"
      expr: agency_decision
      comment: "Final agency decision on the submission (e.g., Approved, Complete Response Letter, Refuse to File) for outcome analysis."
    - name: "dossier_format"
      expr: dossier_format
      comment: "Format of the submitted dossier (e.g., eCTD, NeeS, Paper) to track electronic submission adoption."
    - name: "phase"
      expr: phase
      comment: "Clinical development phase associated with the submission (e.g., Phase I, II, III) for pipeline stage segmentation."
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed. Baseline volume KPI for regulatory operations capacity planning and throughput monitoring."
    - name: "expedited_submissions"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of submissions on expedited review pathways. Tracks utilization of accelerated regulatory programs (Breakthrough, Fast Track, Priority Review) which are strategic portfolio levers."
    - name: "resubmission_count"
      expr: COUNT(CASE WHEN is_resubmission = TRUE THEN 1 END)
      comment: "Number of resubmissions following prior agency rejection or refusal. High resubmission rates signal quality or strategy issues requiring executive intervention."
    - name: "expedited_submission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions on expedited pathways. Strategic KPI indicating how effectively the portfolio leverages accelerated regulatory designations to reduce time-to-market."
    - name: "resubmission_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_resubmission = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of submissions that are resubmissions. A rising rate signals systemic quality or strategy deficiencies in initial filings, triggering root-cause investigation."
    - name: "distinct_applications_submitted"
      expr: COUNT(DISTINCT application_id)
      comment: "Number of distinct regulatory applications with at least one submission. Measures breadth of active regulatory portfolio under management."
    - name: "distinct_health_authorities_engaged"
      expr: COUNT(DISTINCT health_authority_id)
      comment: "Number of distinct health authorities receiving submissions. Indicates geographic regulatory reach and global filing complexity."
    - name: "filing_fee_paid_count"
      expr: COUNT(CASE WHEN filing_fee_paid = TRUE THEN 1 END)
      comment: "Number of submissions where filing fees have been confirmed paid. Operational compliance KPI ensuring no submissions are at risk of rejection due to unpaid fees."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides portfolio-level visibility into regulatory applications across all product types, approval statuses, and special designation programs. Enables executive oversight of the regulatory pipeline from IND through approval."
  source: "`clinical_trials_ecm`.`regulatory`.`application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of regulatory application (e.g., NDA, BLA, MAA, IND) for portfolio segmentation by regulatory pathway."
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., Active, Approved, Withdrawn, On Hold) for pipeline stage monitoring."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the application for portfolio analysis by disease area and resource allocation decisions."
    - name: "product_type"
      expr: product_type
      comment: "Type of product (e.g., Small Molecule, Biologic, Gene Therapy) for regulatory strategy segmentation."
    - name: "lead_agency"
      expr: lead_agency
      comment: "Primary health authority leading the review (e.g., FDA, EMA, PMDA) for agency-level performance benchmarking."
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase of the application (e.g., Pre-submission, Under Review, Post-Approval) for pipeline stage analysis."
    - name: "clinical_hold_status"
      expr: clinical_hold_status
      comment: "Clinical hold status of the application. Applications on clinical hold represent critical risk events requiring immediate executive attention."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of regulatory approval for cohort analysis of approval timelines and annual approval throughput."
    - name: "initial_filing_year"
      expr: YEAR(initial_filing_date)
      comment: "Year of initial filing for cohort-based time-to-approval analysis."
    - name: "ind_type"
      expr: ind_type
      comment: "Type of IND (e.g., Commercial, Research) for segmenting investigational new drug applications by sponsor intent."
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of regulatory applications in the portfolio. Baseline KPI for portfolio size and regulatory workload assessment."
    - name: "approved_applications"
      expr: COUNT(CASE WHEN application_status = 'Approved' THEN 1 END)
      comment: "Number of applications that have received regulatory approval. Core outcome KPI directly tied to revenue-generating product launches."
    - name: "applications_on_clinical_hold"
      expr: COUNT(CASE WHEN clinical_hold_status IS NOT NULL AND clinical_hold_status != '' AND clinical_hold_status != 'None' THEN 1 END)
      comment: "Number of applications currently under a clinical hold. Clinical holds halt trial activity and represent high-priority risk events requiring immediate executive escalation."
    - name: "breakthrough_therapy_applications"
      expr: COUNT(CASE WHEN breakthrough_therapy = TRUE THEN 1 END)
      comment: "Number of applications with Breakthrough Therapy designation. Strategic KPI tracking utilization of the most impactful FDA expedited program, associated with faster approvals and competitive advantage."
    - name: "fast_track_applications"
      expr: COUNT(CASE WHEN fast_track_designation = TRUE THEN 1 END)
      comment: "Number of applications with Fast Track designation. Tracks portfolio leverage of FDA expedited development programs to accelerate time-to-market."
    - name: "priority_review_applications"
      expr: COUNT(CASE WHEN priority_review = TRUE THEN 1 END)
      comment: "Number of applications under Priority Review. Priority Review reduces the standard 12-month review clock to 6 months, directly impacting launch timing and revenue."
    - name: "orphan_drug_applications"
      expr: COUNT(CASE WHEN orphan_drug_designation = TRUE THEN 1 END)
      comment: "Number of applications with Orphan Drug designation. Tracks rare disease portfolio and associated market exclusivity and fee waiver benefits."
    - name: "accelerated_approval_applications"
      expr: COUNT(CASE WHEN accelerated_approval = TRUE THEN 1 END)
      comment: "Number of applications pursuing Accelerated Approval pathway. Tracks use of surrogate endpoint-based approvals which enable earlier market entry for serious conditions."
    - name: "expedited_designation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN breakthrough_therapy = TRUE OR fast_track_designation = TRUE OR priority_review = TRUE OR accelerated_approval = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of applications carrying at least one expedited designation. Strategic portfolio KPI measuring how effectively the organization positions products for accelerated regulatory pathways."
    - name: "rolling_review_applications"
      expr: COUNT(CASE WHEN rolling_review = TRUE THEN 1 END)
      comment: "Number of applications using rolling review, where data packages are submitted as they become available. Tracks use of this time-saving mechanism that can significantly reduce total review time."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures regulatory approval outcomes, conditional approval rates, renewal compliance, and post-marketing commitment exposure. Directly tied to product commercialization and lifecycle management decisions."
  source: "`clinical_trials_ecm`.`regulatory`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g., Active, Expired, Withdrawn, Conditional) for lifecycle stage analysis."
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (e.g., Full, Conditional, Accelerated) for segmenting approval quality and associated obligations."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the approved product for portfolio-level approval performance analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the approval (e.g., US, EU, Global) for market access coverage analysis."
    - name: "review_pathway"
      expr: review_pathway
      comment: "Regulatory review pathway used (e.g., Standard, Priority, Accelerated, Conditional) for pathway performance benchmarking."
    - name: "drug_name"
      expr: drug_name
      comment: "Name of the approved drug for product-level approval tracking."
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the approved product (e.g., Tablet, Injection, Capsule) for formulation-level analysis."
    - name: "inspection_readiness_status"
      expr: inspection_readiness_status
      comment: "Inspection readiness status at time of approval, used to assess post-approval compliance posture."
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of regulatory approvals granted. Primary outcome KPI for the regulatory function, directly linked to product commercialization and revenue generation."
    - name: "conditional_approvals"
      expr: COUNT(CASE WHEN is_conditional_approval = TRUE THEN 1 END)
      comment: "Number of conditional approvals requiring post-marketing commitments. Conditional approvals carry ongoing obligations and risk of withdrawal if conditions are not met."
    - name: "renewals_required"
      expr: COUNT(CASE WHEN is_renewal_required = TRUE THEN 1 END)
      comment: "Number of approvals requiring periodic renewal. Tracks renewal obligation exposure to prevent inadvertent lapses that would halt commercialization."
    - name: "conditional_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_conditional_approval = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of approvals that are conditional. A high rate signals elevated post-marketing obligation burden and ongoing regulatory risk exposure."
    - name: "approvals_expiring_within_365_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of approvals expiring within the next 12 months. Critical operational KPI for renewal planning — missed renewals result in loss of marketing authorization."
    - name: "distinct_approved_products"
      expr: COUNT(DISTINCT drug_name)
      comment: "Number of distinct approved drug products in the portfolio. Measures commercial product breadth and regulatory achievement."
    - name: "distinct_markets_with_approval"
      expr: COUNT(DISTINCT geographic_scope)
      comment: "Number of distinct geographic markets with at least one active approval. Measures global market access footprint."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks regulatory milestone achievement, schedule variance, and critical path performance. Enables executive oversight of regulatory timelines and early identification of delays that threaten product launch dates."
  source: "`clinical_trials_ecm`.`regulatory`.`regulatory_milestone`"
  dimensions:
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of regulatory milestone (e.g., Submission, Agency Response, Approval, Meeting) for categorized timeline analysis."
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (e.g., Planned, In Progress, Completed, Delayed) for pipeline health monitoring."
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category grouping of milestones (e.g., Pre-submission, Review, Post-Approval) for phase-level performance analysis."
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Flag indicating whether the milestone is on the critical regulatory path. Critical path delays directly impact product launch dates and revenue."
    - name: "is_agency_committed"
      expr: is_agency_committed
      comment: "Flag indicating whether the milestone date is a committed agency action date (e.g., PDUFA date). Agency-committed dates are contractual and non-negotiable."
    - name: "phase"
      expr: phase
      comment: "Development phase associated with the milestone for pipeline stage analysis."
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for milestone delay, used for root-cause analysis and process improvement."
    - name: "priority_designation"
      expr: priority_designation
      comment: "Priority designation of the milestone for resource allocation and escalation decisions."
    - name: "planned_year"
      expr: YEAR(planned_date)
      comment: "Year of planned milestone date for annual regulatory calendar planning."
    - name: "review_cycle"
      expr: review_cycle
      comment: "Review cycle associated with the milestone (e.g., Cycle 1, Complete Response) for review iteration analysis."
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of regulatory milestones tracked. Baseline KPI for regulatory program complexity and workload."
    - name: "completed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of milestones successfully completed. Measures regulatory execution velocity and program progress."
    - name: "delayed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of milestones currently in delayed status. A leading indicator of launch timeline risk requiring executive escalation."
    - name: "critical_path_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of milestones on the critical regulatory path. Critical path milestone delays have direct 1:1 impact on product launch dates."
    - name: "critical_path_delayed_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE AND milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of critical path milestones currently delayed. The highest-priority regulatory risk KPI — each delayed critical path milestone directly threatens the product launch date."
    - name: "milestone_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones completed. Measures overall regulatory execution effectiveness and program delivery performance."
    - name: "avg_probability_of_success_pct"
      expr: ROUND(AVG(CAST(probability_of_success_pct AS DOUBLE)), 2)
      comment: "Average probability of success across regulatory milestones. Portfolio-level risk KPI used in investment decisions, resource allocation, and go/no-go gate reviews."
    - name: "agency_committed_milestones"
      expr: COUNT(CASE WHEN is_agency_committed = TRUE THEN 1 END)
      comment: "Number of milestones with committed agency action dates (e.g., PDUFA dates). These are non-negotiable regulatory deadlines that anchor commercial launch planning."
    - name: "on_time_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN milestone_status = 'Completed' AND actual_date <= planned_date THEN 1 END) / NULLIF(COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed milestones achieved on or before the planned date. Measures regulatory schedule adherence and predictability of the regulatory function."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors regulatory inspection outcomes, finding severity, readiness posture, and CAPA response compliance. Critical risk management KPI surface for quality and regulatory leadership."
  source: "`clinical_trials_ecm`.`regulatory`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (e.g., GCP, GMP, GLP, Pharmacovigilance) for compliance domain segmentation."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, In Progress, Completed, CAPA Pending) for active inspection pipeline monitoring."
    - name: "inspection_category"
      expr: inspection_category
      comment: "Category of inspection (e.g., Routine, For-Cause, Pre-Approval) indicating the risk context and urgency of the inspection."
    - name: "outcome"
      expr: outcome
      comment: "Final inspection outcome (e.g., No Action Indicated, Voluntary Action Indicated, Official Action Indicated) — the primary quality signal from each inspection."
    - name: "readiness_status"
      expr: readiness_status
      comment: "Inspection readiness status at time of inspection, used to correlate preparedness with outcomes."
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Mode of inspection (e.g., On-site, Remote, Hybrid) for operational planning and resource allocation."
    - name: "is_unannounced"
      expr: is_unannounced
      comment: "Flag indicating whether the inspection was unannounced. Unannounced inspections test true compliance state and typically yield more critical findings."
    - name: "is_repeat_inspection"
      expr: is_repeat_inspection
      comment: "Flag indicating whether this is a repeat inspection of a previously inspected site or program. Repeat inspections signal persistent compliance issues."
    - name: "inspection_year"
      expr: YEAR(actual_start_date)
      comment: "Year of inspection start date for annual inspection volume and outcome trend analysis."
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection (e.g., Full, Targeted, Follow-up) for understanding inspection depth and resource implications."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections. Baseline KPI for inspection volume and compliance activity level."
    - name: "inspections_with_critical_findings"
      expr: COUNT(CASE WHEN critical_findings_count IS NOT NULL AND critical_findings_count != '0' AND critical_findings_count != '' THEN 1 END)
      comment: "Number of inspections that resulted in at least one critical finding. Critical findings can lead to Warning Letters, import alerts, or clinical holds — highest-priority compliance risk KPI."
    - name: "repeat_inspections"
      expr: COUNT(CASE WHEN is_repeat_inspection = TRUE THEN 1 END)
      comment: "Number of repeat inspections. Elevated repeat inspection rates indicate persistent systemic compliance failures requiring executive intervention."
    - name: "unannounced_inspections"
      expr: COUNT(CASE WHEN is_unannounced = TRUE THEN 1 END)
      comment: "Number of unannounced inspections received. Tracks exposure to surprise regulatory scrutiny which tests true compliance state."
    - name: "official_action_indicated_inspections"
      expr: COUNT(CASE WHEN outcome = 'Official Action Indicated' THEN 1 END)
      comment: "Number of inspections resulting in Official Action Indicated (OAI) outcome. OAI is the most severe inspection outcome, triggering mandatory regulatory action and potential enforcement."
    - name: "oai_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'Official Action Indicated' THEN 1 END) / NULLIF(COUNT(CASE WHEN outcome IS NOT NULL AND outcome != '' THEN 1 END), 0), 2)
      comment: "Percentage of completed inspections resulting in OAI outcome. Key quality KPI benchmarked against industry standards; rising OAI rate signals systemic compliance deterioration."
    - name: "capa_overdue_inspections"
      expr: COUNT(CASE WHEN capa_response_due_date < CURRENT_DATE AND capa_submission_date IS NULL THEN 1 END)
      comment: "Number of inspections where CAPA response is past due and not yet submitted. Overdue CAPAs escalate regulatory risk and can trigger enforcement action."
    - name: "avg_inspection_duration_days"
      expr: ROUND(AVG(DATEDIFF(actual_end_date, actual_start_date)), 1)
      comment: "Average duration of regulatory inspections in days. Longer inspections typically correlate with more extensive findings and greater operational disruption."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks post-approval and post-authorization regulatory commitments, including pediatric studies, REMS programs, and post-marketing requirements. Commitment non-compliance can trigger approval withdrawal."
  source: "`clinical_trials_ecm`.`regulatory`.`commitment`"
  dimensions:
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of regulatory commitment (e.g., Post-Marketing Study, REMS, Labeling Update, Pediatric Study) for obligation category analysis."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (e.g., Pending, In Progress, Completed, Overdue) for compliance pipeline monitoring."
    - name: "commitment_category"
      expr: commitment_category
      comment: "Category grouping of commitments for portfolio-level obligation management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the commitment for resource allocation and escalation decisions."
    - name: "is_binding"
      expr: is_binding
      comment: "Flag indicating whether the commitment is legally binding. Binding commitments carry regulatory enforcement risk if not fulfilled."
    - name: "is_pediatric"
      expr: is_pediatric
      comment: "Flag indicating whether the commitment is a pediatric study requirement. Pediatric commitments are legally mandated under PREA/PDCO and non-compliance results in financial penalties."
    - name: "accelerated_approval_condition"
      expr: accelerated_approval_condition
      comment: "Flag indicating whether the commitment is a condition of accelerated approval. Failure to fulfill these commitments can result in withdrawal of the accelerated approval."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of required progress reporting (e.g., Annual, Semi-Annual, Quarterly) for compliance calendar planning."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the commitment is due for annual obligation planning and resource forecasting."
    - name: "product_name"
      expr: product_name
      comment: "Name of the product associated with the commitment for product-level obligation tracking."
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of regulatory commitments under management. Baseline KPI for post-approval obligation burden and compliance workload."
    - name: "overdue_commitments"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND commitment_status NOT IN ('Completed', 'Released') THEN 1 END)
      comment: "Number of commitments past their due date and not yet completed. Overdue regulatory commitments are a direct compliance risk that can trigger agency enforcement action or approval withdrawal."
    - name: "binding_commitments"
      expr: COUNT(CASE WHEN is_binding = TRUE THEN 1 END)
      comment: "Number of legally binding regulatory commitments. Binding commitments carry the highest enforcement risk and require dedicated resource allocation."
    - name: "pediatric_commitments"
      expr: COUNT(CASE WHEN is_pediatric = TRUE THEN 1 END)
      comment: "Number of pediatric study commitments. Mandated under PREA (US) and PDCO (EU); non-compliance results in financial penalties and potential loss of exclusivity."
    - name: "accelerated_approval_conditions"
      expr: COUNT(CASE WHEN accelerated_approval_condition = TRUE THEN 1 END)
      comment: "Number of commitments that are conditions of accelerated approval. These are the highest-risk commitments — failure to fulfill them can result in withdrawal of the accelerated approval and loss of market authorization."
    - name: "commitment_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN commitment_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory commitments successfully completed. Core compliance performance KPI measuring the organization's ability to fulfill post-approval obligations."
    - name: "overdue_commitment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_date < CURRENT_DATE AND commitment_status NOT IN ('Completed', 'Released') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of commitments that are overdue. A rising overdue rate is a leading indicator of regulatory enforcement risk and requires immediate executive attention."
    - name: "commitments_due_within_90_days"
      expr: COUNT(CASE WHEN due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND commitment_status NOT IN ('Completed', 'Released') THEN 1 END)
      comment: "Number of open commitments due within the next 90 days. Near-term compliance horizon KPI for operational planning and resource prioritization."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_safety_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors safety report submission compliance, expedited reporting rates, and agency acknowledgement timeliness. Pharmacovigilance reporting failures carry severe regulatory consequences including clinical holds."
  source: "`clinical_trials_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "is_expedited"
      expr: is_expedited
      comment: "Flag indicating whether the report is an expedited (7-day or 15-day) safety report. Expedited reports have strict regulatory deadlines with zero tolerance for late submission."
  measures:
    - name: "total_safety_reports"
      expr: COUNT(1)
      comment: "Total number of safety report submissions. Baseline KPI for pharmacovigilance reporting volume and regulatory obligation fulfillment."
    - name: "expedited_safety_reports"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited safety reports (7-day or 15-day). Expedited reports have the strictest regulatory deadlines — late submission can trigger clinical holds and enforcement action."
    - name: "expedited_report_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_expedited = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of safety reports that are expedited. A rising expedited rate may signal increasing product safety concerns or expanding clinical program scope."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_clinical_trial_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Clinical Trial Authorization (CTA) status, approval rates, and suspension/withdrawal activity across member states. CTAs are the legal prerequisite for trial initiation in each country."
  source: "`clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`"
  dimensions:
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of clinical trial authorization (e.g., Initial, Amendment, Extension) for lifecycle stage analysis."
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the CTA (e.g., Submitted, Approved, Rejected, Suspended, Withdrawn) for active authorization pipeline monitoring."
    - name: "member_state_code"
      expr: member_state_code
      comment: "EU/EEA member state code for country-level CTA performance analysis and geographic trial activation tracking."
    - name: "trial_phase"
      expr: trial_phase
      comment: "Clinical trial phase (e.g., Phase I, II, III, IV) for phase-level authorization analysis."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the trial for portfolio-level CTA performance analysis."
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Outcome of the CTA decision (e.g., Approved, Rejected, Approved with Conditions) for approval rate analysis."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the CTA was submitted (e.g., EU CTR, national legislation) for framework-level compliance analysis."
    - name: "conditions_attached"
      expr: conditions_attached
      comment: "Flag indicating whether the authorization was granted with conditions. Conditional CTAs require ongoing compliance monitoring."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of CTA submission for annual authorization volume and approval rate trend analysis."
  measures:
    - name: "total_cta_submissions"
      expr: COUNT(1)
      comment: "Total number of Clinical Trial Authorization submissions. Baseline KPI for global trial activation activity and regulatory submission workload."
    - name: "approved_ctas"
      expr: COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END)
      comment: "Number of CTAs that have received authorization. Directly measures the organization's ability to activate trials in target countries — a prerequisite for patient enrollment."
    - name: "suspended_ctas"
      expr: COUNT(CASE WHEN authorization_status = 'Suspended' OR suspension_date IS NOT NULL THEN 1 END)
      comment: "Number of CTAs currently suspended. CTA suspensions halt trial activity in the affected country, directly impacting enrollment targets and timelines."
    - name: "withdrawn_ctas"
      expr: COUNT(CASE WHEN authorization_status = 'Withdrawn' OR withdrawal_date IS NOT NULL THEN 1 END)
      comment: "Number of CTAs that have been withdrawn. Withdrawals may indicate strategic portfolio decisions or regulatory compliance failures."
    - name: "cta_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN authorization_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN authorization_status IN ('Approved', 'Rejected') THEN 1 END), 0), 2)
      comment: "Percentage of decided CTAs that received authorization. Measures regulatory submission quality and health authority relationship effectiveness for trial activation."
    - name: "ctas_with_conditions"
      expr: COUNT(CASE WHEN conditions_attached = TRUE THEN 1 END)
      comment: "Number of CTAs approved with conditions attached. Conditional authorizations require ongoing compliance monitoring and may restrict trial conduct."
    - name: "distinct_countries_authorized"
      expr: COUNT(DISTINCT member_state_code)
      comment: "Number of distinct countries with at least one active CTA authorization. Measures geographic trial activation footprint and global enrollment capacity."
    - name: "irb_iec_approval_required_count"
      expr: COUNT(CASE WHEN irb_iec_approval_required = TRUE THEN 1 END)
      comment: "Number of CTAs requiring IRB/IEC approval. Tracks ethics committee approval workload associated with trial authorization activities."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_special_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks special regulatory designations (Orphan Drug, Breakthrough Therapy, Fast Track, PRIME) across the portfolio. Special designations are strategic assets that accelerate development timelines and provide market exclusivity benefits."
  source: "`clinical_trials_ecm`.`regulatory`.`special_designation`"
  dimensions:
    - name: "designation_type"
      expr: designation_type
      comment: "Type of special designation (e.g., Orphan Drug, Breakthrough Therapy, Fast Track, PRIME, Accelerated Approval) for designation program analysis."
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the designation (e.g., Granted, Denied, Withdrawn, Under Review) for active designation pipeline monitoring."
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area associated with the designation for portfolio-level special program analysis."
    - name: "product_name"
      expr: product_name
      comment: "Name of the product associated with the designation for product-level special program tracking."
    - name: "confirmatory_trial_required"
      expr: confirmatory_trial_required
      comment: "Flag indicating whether a confirmatory trial is required as a condition of the designation. Tracks post-designation clinical obligations."
    - name: "fee_waiver_applicable"
      expr: fee_waiver_applicable
      comment: "Flag indicating whether a regulatory fee waiver applies. Fee waivers represent direct cost savings associated with special designation programs."
    - name: "surrogate_endpoint_used"
      expr: surrogate_endpoint_used
      comment: "Flag indicating whether a surrogate endpoint was used as the basis for the designation. Surrogate endpoint-based designations carry confirmatory trial obligations."
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the designation was granted for annual designation achievement trend analysis."
    - name: "rolling_review_eligible"
      expr: rolling_review_eligible
      comment: "Flag indicating whether the designation makes the product eligible for rolling review, enabling earlier data submission."
  measures:
    - name: "total_designations"
      expr: COUNT(1)
      comment: "Total number of special regulatory designations in the portfolio. Baseline KPI for special program utilization and strategic regulatory positioning."
    - name: "granted_designations"
      expr: COUNT(CASE WHEN designation_status = 'Granted' THEN 1 END)
      comment: "Number of successfully granted special designations. Each granted designation represents a strategic regulatory asset providing development acceleration or market exclusivity benefits."
    - name: "denied_designations"
      expr: COUNT(CASE WHEN designation_status = 'Denied' THEN 1 END)
      comment: "Number of designation requests that were denied. Denial rates inform strategy quality and the need for pre-submission engagement with health authorities."
    - name: "designation_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN designation_status = 'Granted' THEN 1 END) / NULLIF(COUNT(CASE WHEN designation_status IN ('Granted', 'Denied') THEN 1 END), 0), 2)
      comment: "Percentage of decided designation requests that were granted. Measures regulatory strategy effectiveness in securing development-accelerating designations."
    - name: "designations_with_fee_waiver"
      expr: COUNT(CASE WHEN fee_waiver_applicable = TRUE THEN 1 END)
      comment: "Number of designations with applicable fee waivers. Quantifies direct cost savings from special designation programs — relevant for R&D budget management."
    - name: "designations_expiring_within_365_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) AND designation_status = 'Granted' THEN 1 END)
      comment: "Number of active designations expiring within 12 months. Tracks designation renewal obligations to prevent inadvertent loss of strategic regulatory assets."
    - name: "distinct_products_with_designation"
      expr: COUNT(DISTINCT product_name)
      comment: "Number of distinct products holding at least one special designation. Measures breadth of portfolio with accelerated development pathway access."
    - name: "confirmatory_trial_required_count"
      expr: COUNT(CASE WHEN confirmatory_trial_required = TRUE THEN 1 END)
      comment: "Number of designations requiring a confirmatory trial. Tracks post-designation clinical study obligations that must be fulfilled to maintain the designation and associated benefits."
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_action_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks open regulatory action items, escalation rates, and overdue response compliance. Action items from agency meetings, inspections, and correspondence must be resolved within mandated timeframes to avoid regulatory consequences."
  source: "`clinical_trials_ecm`.`regulatory`.`regulatory_action_item`"
  dimensions:
    - name: "action_item_type"
      expr: action_item_type
      comment: "Type of regulatory action item (e.g., Agency Response, CAPA, Protocol Amendment, Label Update) for workload categorization."
    - name: "action_item_status"
      expr: action_item_status
      comment: "Current status of the action item (e.g., Open, In Progress, Completed, Overdue) for active workload monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the action item (e.g., Critical, High, Medium, Low) for resource allocation and escalation decisions."
    - name: "source_event_type"
      expr: source_event_type
      comment: "Type of event that generated the action item (e.g., Agency Meeting, Inspection, Correspondence) for root-cause analysis."
    - name: "regulatory_area"
      expr: regulatory_area
      comment: "Regulatory area associated with the action item (e.g., Clinical, CMC, Pharmacovigilance) for domain-level workload analysis."
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the underlying finding (e.g., Critical, Major, Minor) for severity-based prioritization."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for resolving the action item for workload distribution and capacity planning."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Flag indicating whether this action item represents a recurring issue. Recurring action items signal systemic process failures requiring root-cause intervention."
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year the action item was opened for annual volume trend analysis."
  measures:
    - name: "total_action_items"
      expr: COUNT(1)
      comment: "Total number of regulatory action items. Baseline KPI for regulatory response workload and compliance obligation volume."
    - name: "open_action_items"
      expr: COUNT(CASE WHEN action_item_status NOT IN ('Completed', 'Closed', 'Cancelled') THEN 1 END)
      comment: "Number of currently open regulatory action items. Measures active compliance workload and outstanding regulatory obligations."
    - name: "overdue_action_items"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND action_item_status NOT IN ('Completed', 'Closed', 'Cancelled') THEN 1 END)
      comment: "Number of action items past their due date and not yet resolved. Overdue regulatory action items are a direct compliance risk — agency-mandated deadlines carry enforcement consequences."
    - name: "escalated_action_items"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of action items that have been escalated. Escalations indicate items that could not be resolved at the operational level and require executive attention."
    - name: "recurring_action_items"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of action items flagged as recurring issues. Recurring regulatory findings indicate systemic process failures and are a leading indicator of future inspection risk."
    - name: "overdue_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN due_date < CURRENT_DATE AND action_item_status NOT IN ('Completed', 'Closed', 'Cancelled') THEN 1 END) / NULLIF(COUNT(CASE WHEN action_item_status NOT IN ('Completed', 'Closed', 'Cancelled') THEN 1 END), 0), 2)
      comment: "Percentage of open action items that are overdue. Key compliance health KPI — a rising overdue rate signals deteriorating regulatory response capability."
    - name: "agency_mandated_action_items"
      expr: COUNT(CASE WHEN agency_mandated_due_date IS NOT NULL THEN 1 END)
      comment: "Number of action items with agency-mandated due dates. These carry the highest compliance risk as deadlines are set by the health authority and non-compliance triggers regulatory consequences."
    - name: "action_item_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN action_item_status IN ('Completed', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all action items that have been successfully closed. Measures regulatory response effectiveness and compliance execution capability."
$$;