-- Metric views for domain: enrollment | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 00:30:14

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_cobra_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cobra Election business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`cobra_election`"
  dimensions:
    - name: "Business Identifier"
      expr: business_identifier
    - name: "Classification Or Type"
      expr: classification_or_type
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Dependent Count"
      expr: dependent_count
    - name: "Early Termination Flag"
      expr: early_termination_flag
    - name: "Early Termination Notice Sent Flag"
      expr: early_termination_notice_sent_flag
    - name: "Election Decision"
      expr: election_decision
    - name: "Election Notice Sent Flag"
      expr: election_notice_sent_flag
    - name: "Election Status"
      expr: election_status
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Notes"
      expr: notes
    - name: "Notice Date Election"
      expr: notice_date_election
    - name: "Notice Date Initial"
      expr: notice_date_initial
    - name: "Notice Deadline"
      expr: notice_deadline
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cobra Election"
      expr: COUNT(DISTINCT cobra_election_id)
    - name: "Total Cobra Premium Amount"
      expr: SUM(cobra_premium_amount)
    - name: "Average Cobra Premium Amount"
      expr: AVG(cobra_premium_amount)
    - name: "Total Last Payment Date"
      expr: SUM(last_payment_date)
    - name: "Average Last Payment Date"
      expr: AVG(last_payment_date)
    - name: "Total Payment Method"
      expr: SUM(payment_method)
    - name: "Average Payment Method"
      expr: AVG(payment_method)
    - name: "Total Payment Status"
      expr: SUM(payment_status)
    - name: "Average Payment Status"
      expr: AVG(payment_status)
    - name: "Total Premium Currency"
      expr: SUM(premium_currency)
    - name: "Average Premium Currency"
      expr: AVG(premium_currency)
    - name: "Total Premium Frequency"
      expr: SUM(premium_frequency)
    - name: "Average Premium Frequency"
      expr: AVG(premium_frequency)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Subsidy Type"
      expr: SUM(subsidy_type)
    - name: "Average Subsidy Type"
      expr: AVG(subsidy_type)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_edi_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Edi Transaction business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`edi_transaction`"
  dimensions:
    - name: "Effective Date"
      expr: effective_date
    - name: "Enrollment Action Code"
      expr: enrollment_action_code
    - name: "Error Code"
      expr: error_code
    - name: "Error Description"
      expr: error_description
    - name: "File Name"
      expr: file_name
    - name: "File Received Timestamp"
      expr: file_received_timestamp
    - name: "Group Control Number"
      expr: group_control_number
    - name: "Interchange Control Number"
      expr: interchange_control_number
    - name: "Last Attempt Timestamp"
      expr: last_attempt_timestamp
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Member Count"
      expr: member_count
    - name: "Processing Attempts"
      expr: processing_attempts
    - name: "Processing Status"
      expr: processing_status
    - name: "Receiver Code"
      expr: receiver_code
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Record Audit Created"
      expr: record_audit_created
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Edi Transaction"
      expr: COUNT(DISTINCT edi_transaction_id)
    - name: "Total Average Record Size Bytes"
      expr: SUM(average_record_size_bytes)
    - name: "Average Average Record Size Bytes"
      expr: AVG(average_record_size_bytes)
    - name: "Total File Size Bytes"
      expr: SUM(file_size_bytes)
    - name: "Average File Size Bytes"
      expr: AVG(file_size_bytes)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_verification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Verification business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`eligibility_verification`"
  dimensions:
    - name: "Authorization Number"
      expr: authorization_number
    - name: "Authorization Required"
      expr: authorization_required
    - name: "Benefit Category"
      expr: benefit_category
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diagnosis Code"
      expr: diagnosis_code
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Error Code"
      expr: error_code
    - name: "Error Description"
      expr: error_description
    - name: "Inquiry Reference Number"
      expr: inquiry_reference_number
    - name: "Inquiry Timestamp"
      expr: inquiry_timestamp
    - name: "Member Identifier Type"
      expr: member_identifier_type
    - name: "Response Message"
      expr: response_message
    - name: "Response Timestamp"
      expr: response_timestamp
    - name: "Service Code"
      expr: service_code
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Verification"
      expr: COUNT(DISTINCT eligibility_verification_id)
    - name: "Total Benefit Limit"
      expr: SUM(benefit_limit)
    - name: "Average Benefit Limit"
      expr: AVG(benefit_limit)
    - name: "Total Benefit Remaining"
      expr: SUM(benefit_remaining)
    - name: "Average Benefit Remaining"
      expr: AVG(benefit_remaining)
    - name: "Total Benefit Used"
      expr: SUM(benefit_used)
    - name: "Average Benefit Used"
      expr: AVG(benefit_used)
    - name: "Total Deductible Remaining"
      expr: SUM(deductible_remaining)
    - name: "Average Deductible Remaining"
      expr: AVG(deductible_remaining)
    - name: "Total Oop Remaining"
      expr: SUM(oop_remaining)
    - name: "Average Oop Remaining"
      expr: AVG(oop_remaining)
    - name: "Total Response Time Seconds"
      expr: SUM(response_time_seconds)
    - name: "Average Response Time Seconds"
      expr: AVG(response_time_seconds)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_enrollment_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment Batch business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_batch`"
  dimensions:
    - name: "Batch Approval By"
      expr: batch_approval_by
    - name: "Batch Approval Comments"
      expr: batch_approval_comments
    - name: "Batch Approval Status"
      expr: batch_approval_status
    - name: "Batch Approval Timestamp"
      expr: batch_approval_timestamp
    - name: "Batch Description"
      expr: batch_description
    - name: "Batch Load Timestamp"
      expr: batch_load_timestamp
    - name: "Batch Load User"
      expr: batch_load_user
    - name: "Batch Notes"
      expr: batch_notes
    - name: "Batch Number"
      expr: batch_number
    - name: "Batch Priority"
      expr: batch_priority
    - name: "Batch Priority Level"
      expr: batch_priority_level
    - name: "Batch Reference Number"
      expr: batch_reference_number
    - name: "Batch Reference Type"
      expr: batch_reference_type
    - name: "Batch Source"
      expr: batch_source
    - name: "Batch Type"
      expr: batch_type
    - name: "Batch Version"
      expr: batch_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Enrollment Batch"
      expr: COUNT(DISTINCT enrollment_batch_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_enrollment_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment Cms Submission business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_cms_submission`"
  dimensions:
    - name: "Audit User"
      expr: audit_user
    - name: "Audit User Role"
      expr: audit_user_role
    - name: "Compliance Check Date"
      expr: compliance_check_date
    - name: "Compliance Error Code"
      expr: compliance_error_code
    - name: "Compliance Error Description"
      expr: compliance_error_description
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Enrollment Cms Submission Status"
      expr: enrollment_cms_submission_status
    - name: "Error Code"
      expr: error_code
    - name: "Error Message"
      expr: error_message
    - name: "Is Legacy Submission"
      expr: is_legacy_submission
    - name: "Is Test Submission"
      expr: is_test_submission
    - name: "Member Number"
      expr: member_number
    - name: "Processing End Timestamp"
      expr: processing_end_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Enrollment Cms Submission"
      expr: COUNT(DISTINCT enrollment_cms_submission_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Raf Score Impact"
      expr: SUM(raf_score_impact)
    - name: "Average Raf Score Impact"
      expr: AVG(raf_score_impact)
    - name: "Total Total Premium Amount"
      expr: SUM(total_premium_amount)
    - name: "Average Total Premium Amount"
      expr: AVG(total_premium_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enrollment Eligibility Span business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "Benefit Designation"
      expr: benefit_designation
    - name: "Benefit Period End"
      expr: benefit_period_end
    - name: "Benefit Period Start"
      expr: benefit_period_start
    - name: "Benefit Year"
      expr: benefit_year
    - name: "Coverage Category"
      expr: coverage_category
    - name: "Coverage Limit Units"
      expr: coverage_limit_units
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Enrollment Eligibility Span Status"
      expr: enrollment_eligibility_span_status
    - name: "Enrollment Event Type"
      expr: enrollment_event_type
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Is Primary Coverage"
      expr: is_primary_coverage
    - name: "Is Waiver Applied"
      expr: is_waiver_applied
    - name: "Last Status Change Timestamp"
      expr: last_status_change_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Enrollment Eligibility Span"
      expr: COUNT(DISTINCT enrollment_eligibility_span_id)
    - name: "Total Coverage Limit Amount"
      expr: SUM(coverage_limit_amount)
    - name: "Average Coverage Limit Amount"
      expr: AVG(coverage_limit_amount)
    - name: "Total Deductible Amount"
      expr: SUM(deductible_amount)
    - name: "Average Deductible Amount"
      expr: AVG(deductible_amount)
    - name: "Total Deductible Reset Date"
      expr: SUM(deductible_reset_date)
    - name: "Average Deductible Reset Date"
      expr: AVG(deductible_reset_date)
    - name: "Total Moop Threshold"
      expr: SUM(moop_threshold)
    - name: "Average Moop Threshold"
      expr: AVG(moop_threshold)
    - name: "Total Oop Maximum"
      expr: SUM(oop_maximum)
    - name: "Average Oop Maximum"
      expr: AVG(oop_maximum)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`event`"
  dimensions:
    - name: "Actor Type"
      expr: actor_type
    - name: "Event Description"
      expr: event_description
    - name: "Effective Date"
      expr: effective_date
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Event Type"
      expr: event_type
    - name: "Is Manual"
      expr: is_manual
    - name: "New Status"
      expr: new_status
    - name: "Previous Status"
      expr: previous_status
    - name: "Reason Code"
      expr: reason_code
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Source"
      expr: source
    - name: "Termination Date"
      expr: termination_date
    - name: "Vreq Validated"
      expr: vreq_validated
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
    - name: "Event Timestamp Month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Event"
      expr: COUNT(DISTINCT event_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_exchange_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exchange Enrollment business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`exchange_enrollment`"
  dimensions:
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csr Variant"
      expr: csr_variant
    - name: "Effective Date"
      expr: effective_date
    - name: "Effectuation Deadline"
      expr: effectuation_deadline
    - name: "Effectuation Status"
      expr: effectuation_status
    - name: "Enrollment Effectuation Timestamp"
      expr: enrollment_effectuation_timestamp
    - name: "Enrollment Renewal Indicator"
      expr: enrollment_renewal_indicator
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Termination Initiator"
      expr: enrollment_termination_initiator
    - name: "Enrollment Termination Reason Code"
      expr: enrollment_termination_reason_code
    - name: "Enrollment Termination Type"
      expr: enrollment_termination_type
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Exchange Eligibility Determination Reference"
      expr: exchange_eligibility_determination_reference
    - name: "Marketplace Source"
      expr: marketplace_source
    - name: "Marketplace State"
      expr: marketplace_state
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Exchange Enrollment"
      expr: COUNT(DISTINCT exchange_enrollment_id)
    - name: "Total Aptc Amount"
      expr: SUM(aptc_amount)
    - name: "Average Aptc Amount"
      expr: AVG(aptc_amount)
    - name: "Total Payment Due Date"
      expr: SUM(payment_due_date)
    - name: "Average Payment Due Date"
      expr: AVG(payment_due_date)
    - name: "Total Payment Method"
      expr: SUM(payment_method)
    - name: "Average Payment Method"
      expr: AVG(payment_method)
    - name: "Total Payment Status"
      expr: SUM(payment_status)
    - name: "Average Payment Status"
      expr: AVG(payment_status)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
    - name: "Total Premium Frequency"
      expr: SUM(premium_frequency)
    - name: "Average Premium Frequency"
      expr: AVG(premium_frequency)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Subsidy Type"
      expr: SUM(subsidy_type)
    - name: "Average Subsidy Type"
      expr: AVG(subsidy_type)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicaid_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicaid Eligibility business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicaid_eligibility`"
  dimensions:
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dual Eligible Flag"
      expr: dual_eligible_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligibility Category"
      expr: eligibility_category
    - name: "Eligibility Determination Timestamp"
      expr: eligibility_determination_timestamp
    - name: "Eligibility Notes"
      expr: eligibility_notes
    - name: "Eligibility Number"
      expr: eligibility_number
    - name: "Eligibility Reason Code"
      expr: eligibility_reason_code
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Eligibility Verification Date"
      expr: eligibility_verification_date
    - name: "Eligibility Verification Method"
      expr: eligibility_verification_method
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Federal Program Indicator"
      expr: federal_program_indicator
    - name: "Household Size"
      expr: household_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Medicaid Eligibility"
      expr: COUNT(DISTINCT medicaid_eligibility_id)
    - name: "Total Assets Amount"
      expr: SUM(assets_amount)
    - name: "Average Assets Amount"
      expr: AVG(assets_amount)
    - name: "Total Fpl Percentage"
      expr: SUM(fpl_percentage)
    - name: "Average Fpl Percentage"
      expr: AVG(fpl_percentage)
    - name: "Total Income Amount"
      expr: SUM(income_amount)
    - name: "Average Income Amount"
      expr: AVG(income_amount)
    - name: "Total Income Verification Status"
      expr: SUM(income_verification_status)
    - name: "Average Income Verification Status"
      expr: AVG(income_verification_status)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_medicare_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medicare Entitlement business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`medicare_entitlement`"
  dimensions:
    - name: "Cms Contract Number"
      expr: cms_contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Span End"
      expr: eligibility_span_end
    - name: "Eligibility Span Start"
      expr: eligibility_span_start
    - name: "Entitlement Number"
      expr: entitlement_number
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Entitlement Type"
      expr: entitlement_type
    - name: "Extra Help Effective Date"
      expr: extra_help_effective_date
    - name: "Extra Help Status"
      expr: extra_help_status
    - name: "Irmaa Effective Date"
      expr: irmaa_effective_date
    - name: "Irmaa Status"
      expr: irmaa_status
    - name: "Is Dual Eligible"
      expr: is_dual_eligible
    - name: "Is Retired"
      expr: is_retired
    - name: "Last Verified Timestamp"
      expr: last_verified_timestamp
    - name: "Lis Effective Date"
      expr: lis_effective_date
    - name: "Lis Status"
      expr: lis_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Medicare Entitlement"
      expr: COUNT(DISTINCT medicare_entitlement_id)
    - name: "Total Irmaa Income Bracket"
      expr: SUM(irmaa_income_bracket)
    - name: "Average Irmaa Income Bracket"
      expr: AVG(irmaa_income_bracket)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_open_enrollment_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Enrollment Period business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`open_enrollment_period`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligibility Segment"
      expr: eligibility_segment
    - name: "End Date"
      expr: end_date
    - name: "Enrollment Cutoff Time"
      expr: enrollment_cutoff_time
    - name: "Enrollment Deadline Date"
      expr: enrollment_deadline_date
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Exchange Type"
      expr: exchange_type
    - name: "Is Annual"
      expr: is_annual
    - name: "Is Retrospective Allowed"
      expr: is_retrospective_allowed
    - name: "Lob"
      expr: lob
    - name: "Notes"
      expr: notes
    - name: "Open Enrollment Period Status"
      expr: open_enrollment_period_status
    - name: "Period Code"
      expr: period_code
    - name: "Period Name"
      expr: period_name
    - name: "Regulatory Filing Required"
      expr: regulatory_filing_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Open Enrollment Period"
      expr: COUNT(DISTINCT open_enrollment_period_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_pend_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pend Queue business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`pend_queue`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Level"
      expr: escalation_level
    - name: "Is Aptc Csr Conflict Flag"
      expr: is_aptc_csr_conflict_flag
    - name: "Is Auto Resolved"
      expr: is_auto_resolved
    - name: "Is Cms Match Failure Flag"
      expr: is_cms_match_failure_flag
    - name: "Is Documentation Missing Flag"
      expr: is_documentation_missing_flag
    - name: "Is Duplicate Flag"
      expr: is_duplicate_flag
    - name: "Is Eligibility Discrepancy Flag"
      expr: is_eligibility_discrepancy_flag
    - name: "Is Employer Verification Hold Flag"
      expr: is_employer_verification_hold_flag
    - name: "Is Manual Review Required"
      expr: is_manual_review_required
    - name: "Last Escalation Timestamp"
      expr: last_escalation_timestamp
    - name: "Notes"
      expr: notes
    - name: "Pend Reason Code"
      expr: pend_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pend Queue"
      expr: COUNT(DISTINCT pend_queue_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_plan_election`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plan Election business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`plan_election`"
  dimensions:
    - name: "Cobra Eligibility End Date"
      expr: cobra_eligibility_end_date
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Dental Rider Flag"
      expr: dental_rider_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Election Number"
      expr: election_number
    - name: "Election Type"
      expr: election_type
    - name: "Enrollment Event Type"
      expr: enrollment_event_type
    - name: "Enrollment Source"
      expr: enrollment_source
    - name: "Fsa Election Flag"
      expr: fsa_election_flag
    - name: "Hra Election Flag"
      expr: hra_election_flag
    - name: "Hsa Election Flag"
      expr: hsa_election_flag
    - name: "Is Cobra Eligible"
      expr: is_cobra_eligible
    - name: "Notes"
      expr: notes
    - name: "Plan Election Status"
      expr: plan_election_status
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plan Election"
      expr: COUNT(DISTINCT plan_election_id)
    - name: "Total Premium Contribution Employee"
      expr: SUM(premium_contribution_employee)
    - name: "Average Premium Contribution Employee"
      expr: AVG(premium_contribution_employee)
    - name: "Total Premium Contribution Employer"
      expr: SUM(premium_contribution_employer)
    - name: "Average Premium Contribution Employer"
      expr: AVG(premium_contribution_employer)
    - name: "Total Premium Frequency"
      expr: SUM(premium_frequency)
    - name: "Average Premium Frequency"
      expr: AVG(premium_frequency)
    - name: "Total Total Premium"
      expr: SUM(total_premium)
    - name: "Average Total Premium"
      expr: AVG(total_premium)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_qualifying_life_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Qualifying Life Event business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`qualifying_life_event`"
  dimensions:
    - name: "Appeal Reference"
      expr: appeal_reference
    - name: "Cms Sep Outcome"
      expr: cms_sep_outcome
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Documentation Type"
      expr: documentation_type
    - name: "Event Date"
      expr: event_date
    - name: "Event Type"
      expr: event_type
    - name: "Qualifying Life Event Status"
      expr: qualifying_life_event_status
    - name: "Sep Category Code"
      expr: sep_category_code
    - name: "Sep Window End"
      expr: sep_window_end
    - name: "Sep Window Start"
      expr: sep_window_start
    - name: "Sep Window Status"
      expr: sep_window_status
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Verification Date"
      expr: verification_date
    - name: "Verification Status"
      expr: verification_status
    - name: "Vreq Validated"
      expr: vreq_validated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Qualifying Life Event"
      expr: COUNT(DISTINCT qualifying_life_event_id)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reconciliation business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`reconciliation`"
  dimensions:
    - name: "Auto Resolution Flag"
      expr: auto_resolution_flag
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discrepancy Add Count"
      expr: discrepancy_add_count
    - name: "Discrepancy Change Count"
      expr: discrepancy_change_count
    - name: "Discrepancy Demographic Mismatch Count"
      expr: discrepancy_demographic_mismatch_count
    - name: "Discrepancy Detail File Path"
      expr: discrepancy_detail_file_path
    - name: "Discrepancy Termination Count"
      expr: discrepancy_termination_count
    - name: "Discrepancy Total Count"
      expr: discrepancy_total_count
    - name: "Manual Resolution Flag"
      expr: manual_resolution_flag
    - name: "Period End"
      expr: period_end
    - name: "Period Start"
      expr: period_start
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Resolution Deadline"
      expr: resolution_deadline
    - name: "Run Timestamp"
      expr: run_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reconciliation"
      expr: COUNT(DISTINCT reconciliation_id)
    - name: "Total Financial Impact Adjustment"
      expr: SUM(financial_impact_adjustment)
    - name: "Average Financial Impact Adjustment"
      expr: AVG(financial_impact_adjustment)
    - name: "Total Financial Impact Gross"
      expr: SUM(financial_impact_gross)
    - name: "Average Financial Impact Gross"
      expr: AVG(financial_impact_gross)
    - name: "Total Financial Impact Net"
      expr: SUM(financial_impact_net)
    - name: "Average Financial Impact Net"
      expr: AVG(financial_impact_net)
    - name: "Total Run Number"
      expr: SUM(run_number)
    - name: "Average Run Number"
      expr: AVG(run_number)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_submission_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Submission Batch business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`submission_batch`"
  dimensions:
    - name: "Batch Approval By"
      expr: batch_approval_by
    - name: "Batch Approval Date"
      expr: batch_approval_date
    - name: "Batch Archival Date"
      expr: batch_archival_date
    - name: "Batch Deletion Date"
      expr: batch_deletion_date
    - name: "Batch Description"
      expr: batch_description
    - name: "Batch Error Count"
      expr: batch_error_count
    - name: "Batch Error Details"
      expr: batch_error_details
    - name: "Batch Failure Count"
      expr: batch_failure_count
    - name: "Batch Failure Details"
      expr: batch_failure_details
    - name: "Batch Finalization Date"
      expr: batch_finalization_date
    - name: "Batch Is Approved"
      expr: batch_is_approved
    - name: "Batch Is Archived"
      expr: batch_is_archived
    - name: "Batch Is Automatic"
      expr: batch_is_automatic
    - name: "Batch Is Deleted"
      expr: batch_is_deleted
    - name: "Batch Is Finalized"
      expr: batch_is_finalized
    - name: "Batch Is Manual"
      expr: batch_is_manual
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Submission Batch"
      expr: COUNT(DISTINCT submission_batch_id)
    - name: "Total Batch Number"
      expr: SUM(batch_number)
    - name: "Average Batch Number"
      expr: AVG(batch_number)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction business metrics"
  source: "`vibe_health_insurance_v1`.`enrollment`.`transaction`"
  dimensions:
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Approving Authority"
      expr: approving_authority
    - name: "Audit User Role"
      expr: audit_user_role
    - name: "Claims Reprocess Flag"
      expr: claims_reprocess_flag
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Coverage Period Type"
      expr: coverage_period_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Enrollment Comment"
      expr: enrollment_comment
    - name: "Enrollment Origin"
      expr: enrollment_origin
    - name: "Enrollment Transaction Number"
      expr: enrollment_transaction_number
    - name: "Enrollment Type"
      expr: enrollment_type
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Financial Impact Flag"
      expr: financial_impact_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transaction"
      expr: COUNT(DISTINCT transaction_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Original Termination Reference"
      expr: SUM(original_termination_reference)
    - name: "Average Original Termination Reference"
      expr: AVG(original_termination_reference)
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_cms_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS enrollment submission metrics tracking submission quality, compliance, risk adjustment impact, and processing efficiency for Medicare/Medicaid regulatory reporting."
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_cms_submission`"
  dimensions:
    - name: "enrollment_cms_submission_status"
      expr: enrollment_cms_submission_status
      comment: "Status of the CMS submission for pipeline monitoring"
    - name: "processing_status"
      expr: processing_status
      comment: "Processing stage of the submission for operational tracking"
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission for categorization"
    - name: "compliance_flag"
      expr: CAST(compliance_flag AS STRING)
      comment: "Whether submission passed compliance checks"
    - name: "risk_adjustment_flag"
      expr: CAST(risk_adjustment_flag AS STRING)
      comment: "Whether submission impacts risk adjustment scores"
    - name: "submission_source_system"
      expr: submission_source_system
      comment: "Source system generating the submission"
    - name: "is_test_submission"
      expr: CAST(is_test_submission AS STRING)
      comment: "Whether this is a test submission for filtering production data"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of effective date for submission cycle analysis"
  measures:
    - name: "total_cms_submissions"
      expr: COUNT(1)
      comment: "Total CMS submissions for regulatory reporting volume tracking"
    - name: "total_premium_submitted"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total premium amount in CMS submissions for revenue reconciliation with CMS"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount in submissions for financial accuracy tracking"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts in CMS submissions for correction volume monitoring"
    - name: "avg_raf_score_impact"
      expr: AVG(CAST(raf_score_impact AS DOUBLE))
      comment: "Average RAF score impact per submission for risk adjustment revenue optimization"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for submission accuracy monitoring"
    - name: "compliance_failure_count"
      expr: SUM(CASE WHEN compliance_flag = FALSE THEN 1 ELSE 0 END)
      comment: "Count of submissions failing compliance checks for regulatory risk assessment"
    - name: "risk_adjustment_submission_count"
      expr: SUM(CASE WHEN risk_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of risk-adjustment-impacting submissions for RAF revenue tracking"
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`enrollment_eligibility_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enrollment eligibility metrics tracking active coverage spans, coverage types, retroactive adjustments, and enrollment event patterns for population health management and financial planning."
  source: "`vibe_health_insurance_v1`.`enrollment`.`enrollment_eligibility_span`"
  dimensions:
    - name: "coverage_type"
      expr: coverage_type
      comment: "Type of coverage (medical, dental, vision, etc.) for segmenting enrollment metrics"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business (commercial, Medicare, Medicaid, exchange) for strategic portfolio analysis"
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Current eligibility status of the span for active vs terminated analysis"
    - name: "enrollment_event_type"
      expr: enrollment_event_type
      comment: "Type of enrollment event (new enrollment, renewal, termination, etc.)"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel or source through which enrollment originated"
    - name: "coverage_category"
      expr: coverage_category
      comment: "Category of coverage for benefit structure analysis"
    - name: "is_primary_coverage"
      expr: CAST(is_primary_coverage AS STRING)
      comment: "Whether this is the member's primary coverage"
    - name: "retroactive_adjustment_flag"
      expr: CAST(retroactive_adjustment_flag AS STRING)
      comment: "Whether the span involved a retroactive adjustment"
    - name: "benefit_year"
      expr: benefit_year
      comment: "Benefit year for annual enrollment cycle analysis"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year of enrollment effective date for trend analysis"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of enrollment effective date for seasonal pattern analysis"
  measures:
    - name: "total_enrollment_spans"
      expr: COUNT(1)
      comment: "Total number of enrollment eligibility spans for volume tracking"
    - name: "avg_deductible_amount"
      expr: AVG(CAST(deductible_amount AS DOUBLE))
      comment: "Average deductible amount across enrollment spans for cost-sharing analysis"
    - name: "total_coverage_limit_amount"
      expr: SUM(CAST(coverage_limit_amount AS DOUBLE))
      comment: "Total coverage limit exposure across all spans for risk capacity planning"
    - name: "avg_oop_maximum"
      expr: AVG(CAST(oop_maximum AS DOUBLE))
      comment: "Average out-of-pocket maximum for member financial protection analysis"
    - name: "retroactive_adjustment_count"
      expr: SUM(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of retroactive adjustments indicating operational rework and financial restatement risk"
    - name: "distinct_groups_enrolled"
      expr: COUNT(DISTINCT group_id)
      comment: "Unique employer groups with active enrollment for group retention analysis"
    - name: "waiver_applied_count"
      expr: SUM(CASE WHEN is_waiver_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of spans with waivers applied for coverage gap and opt-out analysis"
    - name: "avg_moop_threshold"
      expr: AVG(CAST(moop_threshold AS DOUBLE))
      comment: "Average maximum out-of-pocket threshold for actuarial and benefit design analysis"
$$;