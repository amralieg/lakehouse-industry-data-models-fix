-- Metric views for domain: regulatory | Business: Clinical Trials | Version: 1 | Generated on: 2026-05-06 23:23:25

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key regulatory submission metrics tracking submission volume, timeliness, and decision outcomes to monitor regulatory filing efficiency and agency responsiveness."
  source: "`clinical_trials_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., IND, NDA, BLA, supplement, amendment)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission in the regulatory lifecycle"
    - name: "agency_country_code"
      expr: agency_country_code
      comment: "Country code of the target regulatory agency"
    - name: "target_agency"
      expr: target_agency
      comment: "Name of the target health authority receiving the submission"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the submitted drug product"
    - name: "phase"
      expr: phase
      comment: "Clinical trial phase associated with the submission"
    - name: "submission_category"
      expr: submission_category
      comment: "Category classification of the submission"
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether the submission was filed under an expedited pathway"
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Whether this is a resubmission after prior agency action"
    - name: "agency_decision"
      expr: agency_decision
      comment: "Decision rendered by the agency on the submission"
    - name: "dossier_format"
      expr: dossier_format
      comment: "Format of the regulatory dossier (eCTD, paper, etc.)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was filed"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date))
      comment: "Quarter the submission was filed"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions filed"
    - name: "expedited_submissions"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of submissions filed under expedited pathways"
    - name: "resubmission_count"
      expr: COUNT(CASE WHEN is_resubmission = TRUE THEN 1 END)
      comment: "Number of resubmissions indicating prior rejection or complete response"
    - name: "pending_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Pending' THEN 1 END)
      comment: "Number of submissions currently pending agency review"
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN agency_decision = 'Approved' THEN 1 END)
      comment: "Number of submissions that received approval decisions"
    - name: "distinct_products_submitted"
      expr: COUNT(DISTINCT drug_product_name)
      comment: "Number of distinct drug products with active submissions"
    - name: "distinct_agencies_targeted"
      expr: COUNT(DISTINCT target_agency)
      comment: "Number of distinct health authorities targeted across submissions"
    - name: "avg_days_to_agency_action"
      expr: AVG(DATEDIFF(agency_action_date, submission_date))
      comment: "Average number of days from submission to agency action date"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory application portfolio metrics tracking application lifecycle, designations, and approval timelines for strategic portfolio management."
  source: "`clinical_trials_ecm`.`regulatory`.`application`"
  dimensions:
    - name: "application_type"
      expr: application_type
      comment: "Type of regulatory application (IND, NDA, BLA, MAA, etc.)"
    - name: "application_status"
      expr: application_status
      comment: "Current lifecycle status of the application"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the application product"
    - name: "product_name"
      expr: product_name
      comment: "Name of the product under application"
    - name: "lead_agency"
      expr: lead_agency
      comment: "Lead regulatory agency for the application"
    - name: "lifecycle_phase"
      expr: lifecycle_phase
      comment: "Current lifecycle phase of the application"
    - name: "clinical_hold_status"
      expr: clinical_hold_status
      comment: "Whether the application is under clinical hold"
    - name: "agency_country_code"
      expr: agency_country_code
      comment: "Country code of the regulatory agency"
    - name: "product_type"
      expr: product_type
      comment: "Type of product (small molecule, biologic, etc.)"
    - name: "filing_year"
      expr: YEAR(initial_filing_date)
      comment: "Year of initial filing"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of regulatory applications in portfolio"
    - name: "active_applications"
      expr: COUNT(CASE WHEN application_status = 'Active' THEN 1 END)
      comment: "Number of currently active applications"
    - name: "applications_on_clinical_hold"
      expr: COUNT(CASE WHEN clinical_hold_status = 'Active' THEN 1 END)
      comment: "Number of applications currently under clinical hold — critical risk indicator"
    - name: "breakthrough_therapy_designations"
      expr: COUNT(CASE WHEN breakthrough_therapy = TRUE THEN 1 END)
      comment: "Number of applications with breakthrough therapy designation"
    - name: "fast_track_designations"
      expr: COUNT(CASE WHEN fast_track_designation = TRUE THEN 1 END)
      comment: "Number of applications with fast track designation"
    - name: "orphan_drug_designations"
      expr: COUNT(CASE WHEN orphan_drug_designation = TRUE THEN 1 END)
      comment: "Number of applications with orphan drug designation"
    - name: "priority_review_applications"
      expr: COUNT(CASE WHEN priority_review = TRUE THEN 1 END)
      comment: "Number of applications granted priority review"
    - name: "accelerated_approval_applications"
      expr: COUNT(CASE WHEN accelerated_approval = TRUE THEN 1 END)
      comment: "Number of applications on accelerated approval pathway"
    - name: "distinct_therapeutic_areas"
      expr: COUNT(DISTINCT therapeutic_area)
      comment: "Number of distinct therapeutic areas in the application portfolio"
    - name: "avg_days_to_approval"
      expr: AVG(DATEDIFF(approval_date, initial_filing_date))
      comment: "Average days from initial filing to approval"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory approval metrics tracking approval outcomes, conditional approvals, and post-marketing obligations for marketed product governance."
  source: "`clinical_trials_ecm`.`regulatory`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (active, withdrawn, suspended)"
    - name: "approval_type"
      expr: approval_type
      comment: "Type of approval (full, conditional, accelerated)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the approved product"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the approval (national, regional, global)"
    - name: "review_pathway"
      expr: review_pathway
      comment: "Regulatory review pathway used (standard, priority, accelerated)"
    - name: "is_conditional_approval"
      expr: is_conditional_approval
      comment: "Whether the approval is conditional requiring further confirmatory data"
    - name: "is_renewal_required"
      expr: is_renewal_required
      comment: "Whether the approval requires periodic renewal"
    - name: "drug_name"
      expr: drug_name
      comment: "Name of the approved drug"
    - name: "dosage_form"
      expr: dosage_form
      comment: "Dosage form of the approved product"
    - name: "approval_year"
      expr: YEAR(effective_date)
      comment: "Year the approval became effective"
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of regulatory approvals granted"
    - name: "conditional_approvals"
      expr: COUNT(CASE WHEN is_conditional_approval = TRUE THEN 1 END)
      comment: "Number of conditional approvals requiring post-marketing confirmatory studies"
    - name: "renewals_required"
      expr: COUNT(CASE WHEN is_renewal_required = TRUE THEN 1 END)
      comment: "Number of approvals requiring renewal — drives renewal workload planning"
    - name: "distinct_approved_drugs"
      expr: COUNT(DISTINCT drug_name)
      comment: "Number of distinct drugs with active approvals"
    - name: "distinct_approved_indications"
      expr: COUNT(DISTINCT approved_indication)
      comment: "Number of distinct approved indications across portfolio"
    - name: "approvals_expiring_within_year"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of approvals expiring within the next 12 months requiring renewal action"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-marketing commitment tracking metrics measuring compliance with regulatory obligations, overdue commitments, and fulfillment rates."
  source: "`clinical_trials_ecm`.`regulatory`.`commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the commitment (open, fulfilled, overdue, deferred)"
    - name: "commitment_type"
      expr: commitment_type
      comment: "Type of post-marketing commitment"
    - name: "commitment_category"
      expr: commitment_category
      comment: "Category of the commitment (PMC, PMR, REMS, etc.)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the commitment"
    - name: "product_name"
      expr: product_name
      comment: "Product associated with the commitment"
    - name: "is_binding"
      expr: is_binding
      comment: "Whether the commitment is legally binding"
    - name: "is_pediatric"
      expr: is_pediatric
      comment: "Whether the commitment relates to pediatric studies"
    - name: "accelerated_approval_condition"
      expr: accelerated_approval_condition
      comment: "Whether commitment is a condition of accelerated approval"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the commitment"
    - name: "indication"
      expr: indication
      comment: "Therapeutic indication associated with the commitment"
  measures:
    - name: "total_commitments"
      expr: COUNT(1)
      comment: "Total number of regulatory commitments tracked"
    - name: "open_commitments"
      expr: COUNT(CASE WHEN commitment_status = 'Open' THEN 1 END)
      comment: "Number of currently open/active commitments requiring attention"
    - name: "overdue_commitments"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND commitment_status NOT IN ('Fulfilled', 'Released', 'Closed') THEN 1 END)
      comment: "Number of commitments past due date — critical compliance risk indicator"
    - name: "binding_commitments"
      expr: COUNT(CASE WHEN is_binding = TRUE THEN 1 END)
      comment: "Number of legally binding commitments with regulatory enforcement risk"
    - name: "accelerated_approval_commitments"
      expr: COUNT(CASE WHEN accelerated_approval_condition = TRUE THEN 1 END)
      comment: "Number of commitments tied to accelerated approval — failure risks withdrawal"
    - name: "fulfilled_commitments"
      expr: COUNT(CASE WHEN commitment_status = 'Fulfilled' THEN 1 END)
      comment: "Number of commitments successfully fulfilled"
    - name: "commitments_due_within_90_days"
      expr: COUNT(CASE WHEN due_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND commitment_status NOT IN ('Fulfilled', 'Released', 'Closed') THEN 1 END)
      comment: "Number of open commitments due within 90 days requiring immediate action planning"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection metrics tracking inspection outcomes, findings severity, and readiness status to manage GCP/GMP compliance risk."
  source: "`clinical_trials_ecm`.`regulatory`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (routine, for-cause, pre-approval)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome/classification of the inspection (NAI, VAI, OAI)"
    - name: "inspection_category"
      expr: inspection_category
      comment: "Category of inspection (GCP, GMP, GLP, pharmacovigilance)"
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of the inspection (site, system, product)"
    - name: "readiness_status"
      expr: readiness_status
      comment: "Inspection readiness status of the inspected entity"
    - name: "is_unannounced"
      expr: is_unannounced
      comment: "Whether the inspection was unannounced"
    - name: "is_repeat_inspection"
      expr: is_repeat_inspection
      comment: "Whether this is a repeat/follow-up inspection"
    - name: "inspection_mode"
      expr: inspection_mode
      comment: "Mode of inspection (on-site, remote, hybrid)"
    - name: "inspection_year"
      expr: YEAR(actual_start_date)
      comment: "Year the inspection was conducted"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections conducted or scheduled"
    - name: "inspections_with_critical_findings"
      expr: COUNT(CASE WHEN critical_findings_count != '0' AND critical_findings_count IS NOT NULL THEN 1 END)
      comment: "Number of inspections that resulted in critical findings — highest risk category"
    - name: "unannounced_inspections"
      expr: COUNT(CASE WHEN is_unannounced = TRUE THEN 1 END)
      comment: "Number of unannounced inspections indicating heightened regulatory scrutiny"
    - name: "repeat_inspections"
      expr: COUNT(CASE WHEN is_repeat_inspection = TRUE THEN 1 END)
      comment: "Number of repeat inspections suggesting unresolved prior findings"
    - name: "for_cause_inspections"
      expr: COUNT(CASE WHEN inspection_type = 'For-Cause' THEN 1 END)
      comment: "Number of for-cause inspections triggered by specific compliance concerns"
    - name: "favorable_outcome_inspections"
      expr: COUNT(CASE WHEN outcome = 'NAI' THEN 1 END)
      comment: "Number of inspections with No Action Indicated outcome — best possible result"
    - name: "official_action_indicated"
      expr: COUNT(CASE WHEN outcome = 'OAI' THEN 1 END)
      comment: "Number of inspections with Official Action Indicated — most severe outcome requiring immediate remediation"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory milestone tracking metrics measuring on-time delivery, delays, and critical path adherence for regulatory program execution."
  source: "`clinical_trials_ecm`.`regulatory`.`regulatory_milestone`"
  dimensions:
    - name: "milestone_status"
      expr: milestone_status
      comment: "Current status of the milestone (planned, in-progress, completed, delayed)"
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of regulatory milestone"
    - name: "milestone_category"
      expr: milestone_category
      comment: "Category of the milestone (submission, approval, meeting, etc.)"
    - name: "phase"
      expr: phase
      comment: "Clinical development phase associated with the milestone"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Whether the milestone is on the critical path for program timelines"
    - name: "is_agency_committed"
      expr: is_agency_committed
      comment: "Whether the milestone has an agency-committed date (e.g., PDUFA)"
    - name: "priority_designation"
      expr: priority_designation
      comment: "Priority designation associated with the milestone"
    - name: "delay_reason_code"
      expr: delay_reason_code
      comment: "Coded reason for milestone delay"
    - name: "milestone_year"
      expr: YEAR(planned_date)
      comment: "Year the milestone is planned for"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of regulatory milestones tracked"
    - name: "completed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Completed' THEN 1 END)
      comment: "Number of milestones successfully completed"
    - name: "delayed_milestones"
      expr: COUNT(CASE WHEN milestone_status = 'Delayed' THEN 1 END)
      comment: "Number of milestones currently delayed — indicates program risk"
    - name: "critical_path_milestones"
      expr: COUNT(CASE WHEN is_critical_path = TRUE THEN 1 END)
      comment: "Number of milestones on the critical path affecting overall program timelines"
    - name: "overdue_milestones"
      expr: COUNT(CASE WHEN planned_date < CURRENT_DATE AND milestone_status NOT IN ('Completed', 'Cancelled') THEN 1 END)
      comment: "Number of milestones past planned date and not yet completed"
    - name: "avg_milestone_variance_days"
      expr: AVG(DATEDIFF(actual_date, planned_date))
      comment: "Average variance in days between planned and actual milestone completion dates"
    - name: "avg_probability_of_success"
      expr: AVG(CAST(probability_of_success_pct AS DOUBLE))
      comment: "Average probability of success across milestones — portfolio confidence indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_clinical_trial_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical trial authorization metrics tracking CTA approvals, timelines, and conditions across member states for global trial start-up efficiency."
  source: "`clinical_trials_ecm`.`regulatory`.`clinical_trial_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the clinical trial authorization"
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization (initial, substantial modification, renewal)"
    - name: "member_state_code"
      expr: member_state_code
      comment: "EU member state code for the authorization"
    - name: "trial_phase"
      expr: trial_phase
      comment: "Phase of the clinical trial being authorized"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the trial"
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Decision outcome from the health authority"
    - name: "conditions_attached"
      expr: conditions_attached
      comment: "Whether conditions were attached to the authorization"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework under which the CTA was filed (CTR, CTD, national)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the CTA was submitted"
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of clinical trial authorizations filed or active"
    - name: "approved_authorizations"
      expr: COUNT(CASE WHEN decision_outcome = 'Approved' THEN 1 END)
      comment: "Number of CTAs that received approval"
    - name: "authorizations_with_conditions"
      expr: COUNT(CASE WHEN conditions_attached = TRUE THEN 1 END)
      comment: "Number of authorizations granted with conditions requiring compliance"
    - name: "suspended_authorizations"
      expr: COUNT(CASE WHEN authorization_status = 'Suspended' THEN 1 END)
      comment: "Number of suspended authorizations — critical risk to trial continuity"
    - name: "distinct_member_states"
      expr: COUNT(DISTINCT member_state_code)
      comment: "Number of distinct member states with active CTAs — geographic reach indicator"
    - name: "avg_days_to_decision"
      expr: AVG(DATEDIFF(decision_date, submission_date))
      comment: "Average days from CTA submission to health authority decision"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_safety_report_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety report submission metrics tracking expedited reporting compliance, timeliness, and volume for pharmacovigilance regulatory obligations."
  source: "`clinical_trials_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether the report required expedited submission (7/15 day timeline)"
  measures:
    - name: "total_safety_reports"
      expr: COUNT(1)
      comment: "Total number of safety reports submitted to health authorities"
    - name: "expedited_reports"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited safety reports (SUSARs, fatal/life-threatening cases)"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_correspondence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory correspondence metrics tracking agency communications, response timeliness, and escalation patterns for regulatory relationship management."
  source: "`clinical_trials_ecm`.`regulatory`.`correspondence`"
  dimensions:
    - name: "correspondence_type"
      expr: correspondence_type
      comment: "Type of regulatory correspondence (information request, deficiency letter, etc.)"
    - name: "correspondence_status"
      expr: correspondence_status
      comment: "Current status of the correspondence"
    - name: "direction"
      expr: direction
      comment: "Direction of correspondence (inbound from agency, outbound to agency)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the correspondence"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the corresponding agency"
    - name: "response_required_flag"
      expr: response_required_flag
      comment: "Whether a response is required"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the correspondence has been escalated"
    - name: "clinical_hold_flag"
      expr: clinical_hold_flag
      comment: "Whether the correspondence relates to a clinical hold"
    - name: "correspondence_year"
      expr: YEAR(correspondence_date)
      comment: "Year of the correspondence"
  measures:
    - name: "total_correspondence"
      expr: COUNT(1)
      comment: "Total number of regulatory correspondence items"
    - name: "pending_responses"
      expr: COUNT(CASE WHEN response_required_flag = TRUE AND response_submitted_flag = FALSE THEN 1 END)
      comment: "Number of correspondence items requiring response that have not yet been submitted"
    - name: "overdue_responses"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE AND response_required_flag = TRUE AND response_submitted_flag = FALSE THEN 1 END)
      comment: "Number of overdue responses to agency correspondence — compliance and relationship risk"
    - name: "escalated_correspondence"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated correspondence items indicating high-risk agency interactions"
    - name: "clinical_hold_correspondence"
      expr: COUNT(CASE WHEN clinical_hold_flag = TRUE THEN 1 END)
      comment: "Number of correspondence items related to clinical holds — critical program risk"
    - name: "avg_days_to_respond"
      expr: AVG(DATEDIFF(response_date, received_date))
      comment: "Average days between receiving agency correspondence and submitting response"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_action_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory action item metrics tracking open items, overdue actions, and resolution efficiency for regulatory operations management."
  source: "`clinical_trials_ecm`.`regulatory`.`regulatory_action_item`"
  dimensions:
    - name: "action_item_status"
      expr: action_item_status
      comment: "Current status of the action item (open, in-progress, completed, overdue)"
    - name: "action_item_type"
      expr: action_item_type
      comment: "Type of regulatory action item"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the action item"
    - name: "source_event_type"
      expr: source_event_type
      comment: "Type of event that generated the action item (inspection, meeting, correspondence)"
    - name: "regulatory_area"
      expr: regulatory_area
      comment: "Regulatory area the action item pertains to"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the action item has been escalated"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring action item indicating systemic issues"
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team assigned to resolve the action item"
  measures:
    - name: "total_action_items"
      expr: COUNT(1)
      comment: "Total number of regulatory action items tracked"
    - name: "open_action_items"
      expr: COUNT(CASE WHEN action_item_status = 'Open' THEN 1 END)
      comment: "Number of currently open action items requiring resolution"
    - name: "overdue_action_items"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND action_item_status NOT IN ('Completed', 'Closed', 'Cancelled') THEN 1 END)
      comment: "Number of action items past due date — operational risk indicator"
    - name: "escalated_action_items"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated action items requiring management attention"
    - name: "recurring_action_items"
      expr: COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END)
      comment: "Number of recurring action items indicating systemic process gaps"
    - name: "avg_days_to_completion"
      expr: AVG(DATEDIFF(completion_date, open_date))
      comment: "Average days from action item creation to completion — operational efficiency metric"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_special_designation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special regulatory designation metrics tracking orphan drug, breakthrough therapy, fast track, and other expedited pathway designations for portfolio strategy."
  source: "`clinical_trials_ecm`.`regulatory`.`special_designation`"
  dimensions:
    - name: "designation_type"
      expr: designation_type
      comment: "Type of special designation (orphan, breakthrough, fast track, PRIME, etc.)"
    - name: "designation_status"
      expr: designation_status
      comment: "Current status of the designation (granted, pending, denied, withdrawn)"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the designated product"
    - name: "product_name"
      expr: product_name
      comment: "Product name associated with the designation"
    - name: "indication"
      expr: indication
      comment: "Indication for which the designation was sought"
    - name: "fee_waiver_applicable"
      expr: fee_waiver_applicable
      comment: "Whether a fee waiver is applicable with the designation"
    - name: "confirmatory_trial_required"
      expr: confirmatory_trial_required
      comment: "Whether a confirmatory trial is required post-approval"
    - name: "grant_year"
      expr: YEAR(grant_date)
      comment: "Year the designation was granted"
  measures:
    - name: "total_designations"
      expr: COUNT(1)
      comment: "Total number of special designation requests and grants"
    - name: "granted_designations"
      expr: COUNT(CASE WHEN designation_status = 'Granted' THEN 1 END)
      comment: "Number of designations successfully granted"
    - name: "denied_designations"
      expr: COUNT(CASE WHEN designation_status = 'Denied' THEN 1 END)
      comment: "Number of designation requests denied by health authorities"
    - name: "pending_designations"
      expr: COUNT(CASE WHEN designation_status = 'Pending' THEN 1 END)
      comment: "Number of designation requests currently pending review"
    - name: "distinct_designated_products"
      expr: COUNT(DISTINCT product_name)
      comment: "Number of distinct products with special designations — portfolio breadth indicator"
$$;

CREATE OR REPLACE VIEW `clinical_trials_ecm`.`_metrics`.`regulatory_rems_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "REMS program metrics tracking risk management program compliance, enrollment, and assessment status for post-marketing safety obligations."
  source: "`clinical_trials_ecm`.`regulatory`.`rems_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the REMS program (active, modified, released)"
    - name: "program_type"
      expr: program_type
      comment: "Type of REMS program"
    - name: "therapeutic_area"
      expr: therapeutic_area
      comment: "Therapeutic area of the REMS product"
    - name: "product_name"
      expr: product_name
      comment: "Product name under REMS"
    - name: "has_etasu"
      expr: has_etasu
      comment: "Whether the REMS includes Elements to Assure Safe Use"
    - name: "has_medication_guide"
      expr: has_medication_guide
      comment: "Whether the REMS includes a medication guide"
    - name: "patient_enrollment_required"
      expr: patient_enrollment_required
      comment: "Whether patient enrollment in a registry is required"
    - name: "prescriber_certification_required"
      expr: prescriber_certification_required
      comment: "Whether prescriber certification is required"
  measures:
    - name: "total_rems_programs"
      expr: COUNT(1)
      comment: "Total number of REMS programs managed"
    - name: "active_rems_programs"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Number of currently active REMS programs requiring ongoing management"
    - name: "programs_with_etasu"
      expr: COUNT(CASE WHEN has_etasu = TRUE THEN 1 END)
      comment: "Number of REMS programs with ETASU — highest complexity and compliance burden"
    - name: "avg_compliance_rate"
      expr: AVG(CAST(compliance_rate_percent AS DOUBLE))
      comment: "Average compliance rate across REMS programs — key FDA assessment metric"
    - name: "avg_goal_compliance_gap"
      expr: AVG(goal_compliance_rate_percent - compliance_rate_percent)
      comment: "Average gap between goal and actual compliance rates — identifies programs needing intervention"
    - name: "assessments_overdue"
      expr: COUNT(CASE WHEN next_assessment_due_date < CURRENT_DATE THEN 1 END)
      comment: "Number of REMS programs with overdue FDA assessments — regulatory risk"
$$;