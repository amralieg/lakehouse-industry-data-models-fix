-- Metric views for domain: regulatory | Business: Genomics Biotech | Version: 1 | Generated on: 2026-05-06 15:25:46

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core regulatory submission performance metrics tracking approval rates, cycle times, and submission outcomes across pathways and jurisdictions"
  source: "`genomics_biotech_ecm`.`regulatory`.`submission`"
  dimensions:
    - name: "submission_type"
      expr: submission_type
      comment: "Type of regulatory submission (e.g., 510(k), PMA, De Novo, CE Mark)"
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the submission (e.g., Submitted, Under Review, Approved, Rejected)"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway used for submission (e.g., 510(k), PMA, De Novo)"
    - name: "target_jurisdiction"
      expr: target_jurisdiction
      comment: "Target jurisdiction for the submission (e.g., US, EU, China)"
    - name: "target_agency"
      expr: target_agency
      comment: "Target regulatory agency (e.g., FDA, EMA, NMPA)"
    - name: "device_classification"
      expr: device_classification
      comment: "Device classification (e.g., Class I, Class II, Class III)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the submission (e.g., MDR, IVDR, FDA 21 CFR)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the submission (e.g., Standard, Expedited, Breakthrough)"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the submission was filed"
    - name: "submission_quarter"
      expr: CONCAT('Q', QUARTER(submission_date), '-', YEAR(submission_date))
      comment: "Quarter and year the submission was filed"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the submission was approved"
    - name: "expedited_review_requested"
      expr: expedited_review_requested
      comment: "Whether expedited review was requested"
    - name: "expedited_review_granted"
      expr: expedited_review_granted
      comment: "Whether expedited review was granted"
  measures:
    - name: "total_submissions"
      expr: COUNT(1)
      comment: "Total number of regulatory submissions"
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Number of submissions that have been approved"
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Number of submissions that have been rejected"
    - name: "pending_submissions"
      expr: COUNT(CASE WHEN submission_status IN ('Submitted', 'Under Review') THEN 1 END)
      comment: "Number of submissions currently pending review or decision"
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average number of days from submission to approval"
    - name: "total_submission_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total submission fees paid across all submissions"
    - name: "avg_submission_fee"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average submission fee per submission"
    - name: "expedited_review_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN expedited_review_granted = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN expedited_review_requested = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of expedited review requests that were granted"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory approval portfolio metrics tracking active approvals, renewal compliance, and post-market surveillance obligations"
  source: "`genomics_biotech_ecm`.`regulatory`.`approval`"
  dimensions:
    - name: "approval_type"
      expr: approval_type
      comment: "Type of regulatory approval (e.g., Marketing Authorization, CE Mark, 510(k) Clearance)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval (e.g., Active, Expired, Suspended, Withdrawn)"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of the jurisdiction where approval was granted"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority that granted the approval (e.g., FDA, EMA, Health Canada)"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway used to obtain approval"
    - name: "device_classification"
      expr: device_classification
      comment: "Device classification under the approval"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the approval was granted"
    - name: "renewal_required"
      expr: renewal_required_flag
      comment: "Whether the approval requires periodic renewal"
    - name: "post_market_surveillance_required"
      expr: post_market_surveillance_required_flag
      comment: "Whether post-market surveillance is required for this approval"
    - name: "ruo_ivd_designation"
      expr: ruo_ivd_designation
      comment: "Research Use Only or In Vitro Diagnostic designation"
  measures:
    - name: "total_approvals"
      expr: COUNT(1)
      comment: "Total number of regulatory approvals in the portfolio"
    - name: "active_approvals"
      expr: COUNT(CASE WHEN approval_status = 'Active' THEN 1 END)
      comment: "Number of currently active regulatory approvals"
    - name: "expired_approvals"
      expr: COUNT(CASE WHEN approval_status = 'Expired' THEN 1 END)
      comment: "Number of expired approvals requiring renewal or re-submission"
    - name: "approvals_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE AND approval_status = 'Active' THEN 1 END)
      comment: "Number of active approvals that require periodic renewal"
    - name: "approvals_with_pms_obligation"
      expr: COUNT(CASE WHEN post_market_surveillance_required_flag = TRUE AND approval_status = 'Active' THEN 1 END)
      comment: "Number of active approvals with post-market surveillance obligations"
    - name: "approvals_expiring_within_90_days"
      expr: COUNT(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) <= 90 AND DATEDIFF(expiry_date, CURRENT_DATE()) >= 0 AND approval_status = 'Active' THEN 1 END)
      comment: "Number of active approvals expiring within the next 90 days"
    - name: "avg_approval_age_days"
      expr: AVG(DATEDIFF(CURRENT_DATE(), approval_date))
      comment: "Average age of approvals in days from approval date to current date"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_adverse_event_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse event reporting metrics tracking event volumes, reportability rates, closure times, and patient impact across jurisdictions"
  source: "`genomics_biotech_ecm`.`regulatory`.`adverse_event_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Type of adverse event report (e.g., Initial, Follow-up, Final)"
    - name: "report_status"
      expr: report_status
      comment: "Current status of the adverse event report (e.g., Draft, Submitted, Closed)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the adverse event was reported"
    - name: "reportability_determination"
      expr: reportability_determination
      comment: "Determination of whether the event is reportable to regulatory authorities"
    - name: "patient_impact"
      expr: patient_impact
      comment: "Level of patient impact (e.g., Death, Serious Injury, Malfunction)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause identified (e.g., Design, Manufacturing, User Error)"
    - name: "corrective_action_type"
      expr: corrective_action_type
      comment: "Type of corrective action taken (e.g., Recall, Field Safety Notice, Design Change)"
    - name: "reporter_type"
      expr: reporter_type
      comment: "Type of reporter (e.g., Healthcare Professional, Patient, Manufacturer)"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the adverse event occurred"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year the adverse event report was submitted"
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up activities (e.g., Pending, Complete, Not Required)"
  measures:
    - name: "total_adverse_events"
      expr: COUNT(1)
      comment: "Total number of adverse event reports"
    - name: "reportable_adverse_events"
      expr: COUNT(CASE WHEN reportability_determination = 'Reportable' THEN 1 END)
      comment: "Number of adverse events determined to be reportable to regulatory authorities"
    - name: "serious_adverse_events"
      expr: COUNT(CASE WHEN patient_impact IN ('Death', 'Serious Injury') THEN 1 END)
      comment: "Number of serious adverse events (death or serious injury)"
    - name: "closed_adverse_events"
      expr: COUNT(CASE WHEN report_status = 'Closed' THEN 1 END)
      comment: "Number of adverse event reports that have been closed"
    - name: "avg_closure_time_days"
      expr: AVG(DATEDIFF(closure_date, event_date))
      comment: "Average number of days from event occurrence to report closure"
    - name: "avg_regulatory_notification_time_days"
      expr: AVG(DATEDIFF(regulatory_notification_date, event_date))
      comment: "Average number of days from event occurrence to regulatory notification"
    - name: "reportability_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reportability_determination = 'Reportable' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adverse events determined to be reportable"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_field_safety_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field safety corrective action metrics tracking recall effectiveness, recovery rates, customer notification compliance, and financial impact"
  source: "`genomics_biotech_ecm`.`regulatory`.`field_safety_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of field safety action (e.g., Recall, Field Safety Notice, Safety Alert)"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the field safety action (e.g., Open, In Progress, Closed)"
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Classification of the hazard (e.g., Class I, Class II, Class III)"
    - name: "affected_product_name"
      expr: affected_product_name
      comment: "Name of the affected product"
    - name: "customer_notification_status"
      expr: customer_notification_status
      comment: "Status of customer notification (e.g., Complete, In Progress, Pending)"
    - name: "customer_notification_method"
      expr: customer_notification_method
      comment: "Method used to notify customers (e.g., Email, Letter, Phone)"
    - name: "effectiveness_check_required"
      expr: effectiveness_check_required_flag
      comment: "Whether an effectiveness check is required for this action"
    - name: "effectiveness_check_outcome"
      expr: effectiveness_check_outcome
      comment: "Outcome of the effectiveness check (e.g., Effective, Ineffective, Pending)"
    - name: "initiation_year"
      expr: YEAR(initiation_date)
      comment: "Year the field safety action was initiated"
  measures:
    - name: "total_field_safety_actions"
      expr: COUNT(1)
      comment: "Total number of field safety corrective actions"
    - name: "class_i_recalls"
      expr: COUNT(CASE WHEN hazard_classification = 'Class I' THEN 1 END)
      comment: "Number of Class I (most serious) recalls"
    - name: "closed_field_safety_actions"
      expr: COUNT(CASE WHEN action_status = 'Closed' THEN 1 END)
      comment: "Number of field safety actions that have been closed"
    - name: "avg_closure_time_days"
      expr: AVG(DATEDIFF(closure_date, initiation_date))
      comment: "Average number of days from action initiation to closure"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of all field safety actions"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average estimated financial impact per field safety action"
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_completion_percentage AS DOUBLE))
      comment: "Average recovery completion percentage across all field safety actions"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_establishment_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Establishment registration compliance metrics tracking registration status, renewal timeliness, GMP certification, and inspection outcomes"
  source: "`genomics_biotech_ecm`.`regulatory`.`establishment_registration`"
  dimensions:
    - name: "registration_type"
      expr: registration_type
      comment: "Type of establishment registration (e.g., Manufacturer, Distributor, Importer)"
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the registration (e.g., Active, Expired, Pending Renewal)"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of the jurisdiction where the establishment is registered"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority with which the establishment is registered"
    - name: "facility_country_code"
      expr: facility_country_code
      comment: "Country code where the facility is located"
    - name: "gmp_certified"
      expr: gmp_certified_flag
      comment: "Whether the establishment is GMP certified"
    - name: "iso_13485_certified"
      expr: iso_13485_certified_flag
      comment: "Whether the establishment is ISO 13485 certified"
    - name: "renewal_required"
      expr: renewal_required_flag
      comment: "Whether the registration requires periodic renewal"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the most recent inspection (e.g., Pass, Fail, Conditional)"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the establishment was registered"
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of establishment registrations"
    - name: "active_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Active' THEN 1 END)
      comment: "Number of currently active establishment registrations"
    - name: "expired_registrations"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN 1 END)
      comment: "Number of expired registrations requiring renewal"
    - name: "gmp_certified_establishments"
      expr: COUNT(CASE WHEN gmp_certified_flag = TRUE THEN 1 END)
      comment: "Number of establishments with GMP certification"
    - name: "iso_13485_certified_establishments"
      expr: COUNT(CASE WHEN iso_13485_certified_flag = TRUE THEN 1 END)
      comment: "Number of establishments with ISO 13485 certification"
    - name: "registrations_expiring_within_90_days"
      expr: COUNT(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) <= 90 AND DATEDIFF(expiry_date, CURRENT_DATE()) >= 0 AND registration_status = 'Active' THEN 1 END)
      comment: "Number of active registrations expiring within the next 90 days"
    - name: "gmp_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gmp_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of establishments with GMP certification"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_post_market_surveillance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-market surveillance program metrics tracking plan compliance, adverse event trends, corrective action triggers, and recall rates"
  source: "`genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`"
  dimensions:
    - name: "pms_type"
      expr: pms_type
      comment: "Type of post-market surveillance (e.g., Active, Passive, Registry-based)"
    - name: "pms_status"
      expr: pms_status
      comment: "Current status of the post-market surveillance plan (e.g., Active, Completed, Suspended)"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of the jurisdiction for the surveillance plan"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the surveillance plan"
    - name: "device_classification"
      expr: device_classification
      comment: "Classification of the device under surveillance"
    - name: "corrective_action_required"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required based on surveillance findings"
    - name: "recall_initiated"
      expr: recall_initiated_flag
      comment: "Whether a recall was initiated as a result of surveillance findings"
    - name: "field_safety_notice_issued"
      expr: field_safety_notice_issued_flag
      comment: "Whether a field safety notice was issued"
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency of reporting required (e.g., Annual, Semi-Annual, Quarterly)"
  measures:
    - name: "total_pms_plans"
      expr: COUNT(1)
      comment: "Total number of post-market surveillance plans"
    - name: "active_pms_plans"
      expr: COUNT(CASE WHEN pms_status = 'Active' THEN 1 END)
      comment: "Number of currently active post-market surveillance plans"
    - name: "pms_plans_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of surveillance plans that have triggered corrective action requirements"
    - name: "pms_plans_with_recalls"
      expr: COUNT(CASE WHEN recall_initiated_flag = TRUE THEN 1 END)
      comment: "Number of surveillance plans that resulted in product recalls"
    - name: "pms_plans_with_fsn"
      expr: COUNT(CASE WHEN field_safety_notice_issued_flag = TRUE THEN 1 END)
      comment: "Number of surveillance plans that resulted in field safety notices"
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveillance plans requiring corrective action"
    - name: "recall_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_initiated_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveillance plans that resulted in recalls"
$$;

CREATE OR REPLACE VIEW `genomics_biotech_ecm`.`_metrics`.`regulatory_agency_correspondence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory agency interaction metrics tracking correspondence volumes, response timeliness, escalation rates, and meeting outcomes"
  source: "`genomics_biotech_ecm`.`regulatory`.`agency_correspondence`"
  dimensions:
    - name: "correspondence_type"
      expr: correspondence_type
      comment: "Type of correspondence (e.g., Pre-Submission Meeting, Information Request, Deficiency Letter)"
    - name: "correspondence_status"
      expr: correspondence_status
      comment: "Current status of the correspondence (e.g., Open, Closed, Awaiting Response)"
    - name: "direction"
      expr: direction
      comment: "Direction of correspondence (Inbound from agency or Outbound to agency)"
    - name: "agency_name"
      expr: agency_name
      comment: "Name of the regulatory agency"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the regulatory agency"
    - name: "regulatory_pathway"
      expr: regulatory_pathway
      comment: "Regulatory pathway associated with the correspondence"
    - name: "priority"
      expr: priority
      comment: "Priority level of the correspondence (e.g., High, Medium, Low)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the correspondence has been escalated"
    - name: "meeting_type"
      expr: meeting_type
      comment: "Type of meeting if correspondence is meeting-related (e.g., Pre-Sub, Type A, Type C)"
    - name: "response_status"
      expr: response_status
      comment: "Status of response (e.g., Submitted, Pending, Overdue)"
    - name: "correspondence_year"
      expr: YEAR(correspondence_date)
      comment: "Year the correspondence occurred"
  measures:
    - name: "total_correspondence"
      expr: COUNT(1)
      comment: "Total number of agency correspondence items"
    - name: "inbound_correspondence"
      expr: COUNT(CASE WHEN direction = 'Inbound' THEN 1 END)
      comment: "Number of inbound correspondence items from agencies"
    - name: "outbound_correspondence"
      expr: COUNT(CASE WHEN direction = 'Outbound' THEN 1 END)
      comment: "Number of outbound correspondence items to agencies"
    - name: "escalated_correspondence"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of correspondence items that have been escalated"
    - name: "overdue_responses"
      expr: COUNT(CASE WHEN response_due_date < CURRENT_DATE() AND response_status != 'Submitted' THEN 1 END)
      comment: "Number of correspondence items with overdue responses"
    - name: "avg_response_time_days"
      expr: AVG(DATEDIFF(response_submitted_date, correspondence_date))
      comment: "Average number of days to respond to agency correspondence"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of correspondence items that have been escalated"
$$;