-- Metric views for domain: appeal | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:24:39

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_adverse_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adverse Determination business metrics"
  source: "`health_insurance_ecm`.`appeal`.`adverse_determination`"
  dimensions:
    - name: "Appeal Deadline Date"
      expr: appeal_deadline_date
    - name: "Appeal Eligibility Flag"
      expr: appeal_eligibility_flag
    - name: "Appeal Filed Date"
      expr: appeal_filed_date
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Resolution Date"
      expr: appeal_resolution_date
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Basis Of Denial"
      expr: basis_of_denial
    - name: "Clinical Criteria Version"
      expr: clinical_criteria_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Denial Reason Description"
      expr: denial_reason_description
    - name: "Determination Date"
      expr: determination_date
    - name: "Determination Number"
      expr: determination_number
    - name: "Determination Status"
      expr: determination_status
    - name: "Determination Type"
      expr: determination_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adverse Determination"
      expr: COUNT(DISTINCT adverse_determination_id)
    - name: "Total Monetary Amount Adjusted"
      expr: SUM(monetary_amount_adjusted)
    - name: "Average Monetary Amount Adjusted"
      expr: AVG(monetary_amount_adjusted)
    - name: "Total Monetary Amount Denied"
      expr: SUM(monetary_amount_denied)
    - name: "Average Monetary Amount Denied"
      expr: AVG(monetary_amount_denied)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case business metrics"
  source: "`health_insurance_ecm`.`appeal`.`case`"
  dimensions:
    - name: "Appeal Assigned To"
      expr: appeal_assigned_to
    - name: "Appeal Escalation Flag"
      expr: appeal_escalation_flag
    - name: "Appeal Number"
      expr: appeal_number
    - name: "Appeal Priority"
      expr: appeal_priority
    - name: "Appeal Review Cycle Days"
      expr: appeal_review_cycle_days
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Appeal Type"
      expr: appeal_type
    - name: "Clinical Criteria Applied"
      expr: clinical_criteria_applied
    - name: "Completeness Determination"
      expr: completeness_determination
    - name: "Decision Author Npi"
      expr: decision_author_npi
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Decision Type"
      expr: decision_type
    - name: "Effective Benefit Change Date"
      expr: effective_benefit_change_date
    - name: "Expedited Clinical Urgency Basis"
      expr: expedited_clinical_urgency_basis
    - name: "Expedited Trigger"
      expr: expedited_trigger
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Case"
      expr: COUNT(DISTINCT case_id)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Communication business metrics"
  source: "`health_insurance_ecm`.`appeal`.`communication`"
  dimensions:
    - name: "Accessibility Accommodation"
      expr: accessibility_accommodation
    - name: "Appeal Communication Status"
      expr: appeal_communication_status
    - name: "Attachment Count"
      expr: attachment_count
    - name: "Attachment Indicator"
      expr: attachment_indicator
    - name: "Body Text"
      expr: body_text
    - name: "Channel"
      expr: channel
    - name: "Communication Category"
      expr: communication_category
    - name: "Communication Number"
      expr: communication_number
    - name: "Communication Timestamp"
      expr: communication_timestamp
    - name: "Communication Type"
      expr: communication_type
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Created By User Role"
      expr: created_by_user_role
    - name: "Delivery Confirmation Date"
      expr: delivery_confirmation_date
    - name: "Delivery Confirmation Flag"
      expr: delivery_confirmation_flag
    - name: "Direction"
      expr: direction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Communication"
      expr: COUNT(DISTINCT communication_id)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_coverage_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coverage Dispute business metrics"
  source: "`health_insurance_ecm`.`appeal`.`coverage_dispute`"
  dimensions:
    - name: "Appeal Deadline"
      expr: appeal_deadline
    - name: "Appeal Filed Date"
      expr: appeal_filed_date
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Cob Order"
      expr: cob_order
    - name: "Cob Rule Applied"
      expr: cob_rule_applied
    - name: "Coverage Dispute Status"
      expr: coverage_dispute_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Number"
      expr: dispute_number
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Disputing Party Type"
      expr: disputing_party_type
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Formulary Exception Flag"
      expr: formulary_exception_flag
    - name: "Is Critical"
      expr: is_critical
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coverage Dispute"
      expr: COUNT(DISTINCT coverage_dispute_id)
    - name: "Total Coordination Amount"
      expr: SUM(coordination_amount)
    - name: "Average Coordination Amount"
      expr: AVG(coordination_amount)
    - name: "Total Subrogation Amount"
      expr: SUM(subrogation_amount)
    - name: "Average Subrogation Amount"
      expr: AVG(subrogation_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document business metrics"
  source: "`health_insurance_ecm`.`appeal`.`document`"
  dimensions:
    - name: "Appeal Document Description"
      expr: appeal_document_description
    - name: "Appeal Document Status"
      expr: appeal_document_status
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Considered In Decision"
      expr: considered_in_decision
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
    - name: "Format"
      expr: format
    - name: "Is Confidential"
      expr: is_confidential
    - name: "Is Redacted"
      expr: is_redacted
    - name: "Last Accessed Timestamp"
      expr: last_accessed_timestamp
    - name: "Phi Classification"
      expr: phi_classification
    - name: "Receipt Date"
      expr: receipt_date
    - name: "Redaction Status"
      expr: redaction_status
    - name: "Retention Period Years"
      expr: retention_period_years
    - name: "Source"
      expr: source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Document"
      expr: COUNT(DISTINCT document_id)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_expedited_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expedited Review business metrics"
  source: "`health_insurance_ecm`.`appeal`.`expedited_review`"
  dimensions:
    - name: "Actual Decision Date"
      expr: actual_decision_date
    - name: "Clinical Urgency Classification"
      expr: clinical_urgency_classification
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Due Date"
      expr: decision_due_date
    - name: "Decision Outcome"
      expr: decision_outcome
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Expedited Notification Required"
      expr: expedited_notification_required
    - name: "Expedited Reason"
      expr: expedited_reason
    - name: "Expedited Review Status"
      expr: expedited_review_status
    - name: "Is Confidential"
      expr: is_confidential
    - name: "Notes"
      expr: notes
    - name: "Notification Method"
      expr: notification_method
    - name: "Notified Timestamp"
      expr: notified_timestamp
    - name: "Regulatory Body"
      expr: regulatory_body
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Expedited Review"
      expr: COUNT(DISTINCT expedited_review_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Claim Amount"
      expr: SUM(claim_amount)
    - name: "Average Claim Amount"
      expr: AVG(claim_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_external_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External Review business metrics"
  source: "`health_insurance_ecm`.`appeal`.`external_review`"
  dimensions:
    - name: "Appeal Reason Code"
      expr: appeal_reason_code
    - name: "Appeal Reason Description"
      expr: appeal_reason_description
    - name: "Binding Determination Flag"
      expr: binding_determination_flag
    - name: "Compliance Action Taken"
      expr: compliance_action_taken
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deadline Date"
      expr: deadline_date
    - name: "Decision"
      expr: decision
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Diagnosis Code"
      expr: diagnosis_code
    - name: "External Review Source"
      expr: external_review_source
    - name: "External Review Status"
      expr: external_review_status
    - name: "External Review Type"
      expr: external_review_type
    - name: "Iro Accreditation Status"
      expr: iro_accreditation_status
    - name: "Is Urgent"
      expr: is_urgent
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct External Review"
      expr: COUNT(DISTINCT external_review_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Claim Amount"
      expr: SUM(claim_amount)
    - name: "Average Claim Amount"
      expr: AVG(claim_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_grievance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grievance business metrics"
  source: "`health_insurance_ecm`.`appeal`.`grievance`"
  dimensions:
    - name: "Acknowledgment Date"
      expr: acknowledgment_date
    - name: "Appeal Grievance Status"
      expr: appeal_grievance_status
    - name: "Appeal Reference Number"
      expr: appeal_reference_number
    - name: "Case Notes"
      expr: case_notes
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Escalation Level"
      expr: escalation_level
    - name: "External Review Outcome"
      expr: external_review_outcome
    - name: "External Review Requested"
      expr: external_review_requested
    - name: "Filing Channel"
      expr: filing_channel
    - name: "Filing Date"
      expr: filing_date
    - name: "Filing Party Type"
      expr: filing_party_type
    - name: "Grievance Number"
      expr: grievance_number
    - name: "Grievance Type"
      expr: grievance_type
    - name: "Investigation End Date"
      expr: investigation_end_date
    - name: "Investigation Start Date"
      expr: investigation_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grievance"
      expr: COUNT(DISTINCT grievance_id)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_iro_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Iro Organization business metrics"
  source: "`health_insurance_ecm`.`appeal`.`iro_organization`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Accreditation Expiration Date"
      expr: accreditation_expiration_date
    - name: "Accreditation Review Notes"
      expr: accreditation_review_notes
    - name: "Accreditation Status"
      expr: accreditation_status
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Approved States"
      expr: approved_states
    - name: "Assignment Rotation Methodology"
      expr: assignment_rotation_methodology
    - name: "City"
      expr: city
    - name: "Compliance Requirements"
      expr: compliance_requirements
    - name: "Conflict Of Interest Attestation Date"
      expr: conflict_of_interest_attestation_date
    - name: "Contract Effective End Date"
      expr: contract_effective_end_date
    - name: "Contract Effective Start Date"
      expr: contract_effective_start_date
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Email"
      expr: email
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Iro Organization"
      expr: COUNT(DISTINCT iro_organization_id)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_outcome`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outcome business metrics"
  source: "`health_insurance_ecm`.`appeal`.`outcome`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Downstream Action"
      expr: downstream_action
    - name: "Jurisdiction State"
      expr: jurisdiction_state
    - name: "Member Notification Timestamp"
      expr: member_notification_timestamp
    - name: "Notes"
      expr: notes
    - name: "Outcome Number"
      expr: outcome_number
    - name: "Outcome Status"
      expr: outcome_status
    - name: "Outcome Timestamp"
      expr: outcome_timestamp
    - name: "Outcome Type"
      expr: outcome_type
    - name: "Provider Notification Timestamp"
      expr: provider_notification_timestamp
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Regulatory Body"
      expr: regulatory_body
    - name: "Source System"
      expr: source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Outcome"
      expr: COUNT(DISTINCT outcome_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Review business metrics"
  source: "`health_insurance_ecm`.`appeal`.`review`"
  dimensions:
    - name: "Appeal Case Number"
      expr: appeal_case_number
    - name: "Appeal Reason Code"
      expr: appeal_reason_code
    - name: "Appeal Status At Review"
      expr: appeal_status_at_review
    - name: "Appeal Submission Date"
      expr: appeal_submission_date
    - name: "Clinical Rationale"
      expr: clinical_rationale
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cpt Codes Reviewed"
      expr: cpt_codes_reviewed
    - name: "Criteria Version"
      expr: criteria_version
    - name: "Drg Code"
      expr: drg_code
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Icd Codes Reviewed"
      expr: icd_codes_reviewed
    - name: "Is Independent Reviewer"
      expr: is_independent_reviewer
    - name: "Location"
      expr: location
    - name: "Notes"
      expr: notes
    - name: "Outcome"
      expr: outcome
    - name: "Record Audit Created"
      expr: record_audit_created
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Review"
      expr: COUNT(DISTINCT review_id)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`appeal_timeline`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Timeline business metrics"
  source: "`health_insurance_ecm`.`appeal`.`timeline`"
  dimensions:
    - name: "Acknowledgment Due Date"
      expr: acknowledgment_due_date
    - name: "Actual Acknowledgment Date"
      expr: actual_acknowledgment_date
    - name: "Actual Decision Date"
      expr: actual_decision_date
    - name: "Actual Expedited Date"
      expr: actual_expedited_date
    - name: "Actual Extension Date"
      expr: actual_extension_date
    - name: "Appeal Category"
      expr: appeal_category
    - name: "Appeal Filed Timestamp"
      expr: appeal_filed_timestamp
    - name: "Appeal Origin"
      expr: appeal_origin
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Breach Flag"
      expr: breach_flag
    - name: "Breach Reason"
      expr: breach_reason
    - name: "Clock Start Event"
      expr: clock_start_event
    - name: "Clock Type"
      expr: clock_type
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Corrective Action"
      expr: corrective_action
    - name: "Days Overdue"
      expr: days_overdue
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Timeline"
      expr: COUNT(DISTINCT timeline_id)
$$;