-- Metric views for domain: vendor | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:42:29

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_diversity_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Diversity Certification business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`diversity_certification`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Certification Notes"
      expr: certification_notes
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Scope"
      expr: certification_scope
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Certifying Body"
      expr: certifying_body
    - name: "Certifying Body Region"
      expr: certifying_body_region
    - name: "Client Reportable Flag"
      expr: client_reportable_flag
    - name: "Control And Operations"
      expr: control_and_operations
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diversity Spend Category"
      expr: diversity_spend_category
    - name: "Document Verified Flag"
      expr: document_verified_flag
    - name: "Effective Date"
      expr: effective_date
    - name: "Employee Count"
      expr: employee_count
    - name: "Expiration Date"
      expr: expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Diversity Certification"
      expr: COUNT(DISTINCT diversity_certification_id)
    - name: "Total Annual Revenue Usd"
      expr: SUM(annual_revenue_usd)
    - name: "Average Annual Revenue Usd"
      expr: AVG(annual_revenue_usd)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_performance_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance Scorecard business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`performance_scorecard`"
  dimensions:
    - name: "Active Assignment Count"
      expr: active_assignment_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Dispute Submitted Date"
      expr: dispute_submitted_date
    - name: "Evaluation Period End Date"
      expr: evaluation_period_end_date
    - name: "Evaluation Period Start Date"
      expr: evaluation_period_start_date
    - name: "Evaluation Period Type"
      expr: evaluation_period_type
    - name: "Evaluator Notes"
      expr: evaluator_notes
    - name: "Finalized Date"
      expr: finalized_date
    - name: "Improvement Plan Due Date"
      expr: improvement_plan_due_date
    - name: "Improvement Plan Required"
      expr: improvement_plan_required
    - name: "Overall Score Grade"
      expr: overall_score_grade
    - name: "Published Date"
      expr: published_date
    - name: "Recommended Tier"
      expr: recommended_tier
    - name: "Scorecard Number"
      expr: scorecard_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Performance Scorecard"
      expr: COUNT(DISTINCT performance_scorecard_id)
    - name: "Total Assignment Completion Rate"
      expr: SUM(assignment_completion_rate)
    - name: "Average Assignment Completion Rate"
      expr: AVG(assignment_completion_rate)
    - name: "Total Client Satisfaction Rating"
      expr: SUM(client_satisfaction_rating)
    - name: "Average Client Satisfaction Rating"
      expr: AVG(client_satisfaction_rating)
    - name: "Total Compliance Rate"
      expr: SUM(compliance_rate)
    - name: "Average Compliance Rate"
      expr: AVG(compliance_rate)
    - name: "Total Fall Off Rate"
      expr: SUM(fall_off_rate)
    - name: "Average Fall Off Rate"
      expr: AVG(fall_off_rate)
    - name: "Total Interview To Offer Ratio"
      expr: SUM(interview_to_offer_ratio)
    - name: "Average Interview To Offer Ratio"
      expr: AVG(interview_to_offer_ratio)
    - name: "Total Job Order Fill Rate"
      expr: SUM(job_order_fill_rate)
    - name: "Average Job Order Fill Rate"
      expr: AVG(job_order_fill_rate)
    - name: "Total Nps Score"
      expr: SUM(nps_score)
    - name: "Average Nps Score"
      expr: AVG(nps_score)
    - name: "Total Offer To Start Ratio"
      expr: SUM(offer_to_start_ratio)
    - name: "Average Offer To Start Ratio"
      expr: AVG(offer_to_start_ratio)
    - name: "Total On Time Submittal Rate"
      expr: SUM(on_time_submittal_rate)
    - name: "Average On Time Submittal Rate"
      expr: AVG(on_time_submittal_rate)
    - name: "Total Overall Score"
      expr: SUM(overall_score)
    - name: "Average Overall Score"
      expr: AVG(overall_score)
    - name: "Total Program Allocation Pct"
      expr: SUM(program_allocation_pct)
    - name: "Average Program Allocation Pct"
      expr: AVG(program_allocation_pct)
    - name: "Total Qos Score"
      expr: SUM(qos_score)
    - name: "Average Qos Score"
      expr: AVG(qos_score)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_preferred_supplier_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preferred Supplier List business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`preferred_supplier_list`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Client Notes"
      expr: client_notes
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Conditional Notes"
      expr: conditional_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diversity Certified"
      expr: diversity_certified
    - name: "Diversity Classification"
      expr: diversity_classification
    - name: "Exclusion Date"
      expr: exclusion_date
    - name: "Exclusion Reason"
      expr: exclusion_reason
    - name: "Exclusive Supplier"
      expr: exclusive_supplier
    - name: "Ic Supplier"
      expr: ic_supplier
    - name: "Inclusion Date"
      expr: inclusion_date
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
    - name: "Insurance Verified"
      expr: insurance_verified
    - name: "Job Category"
      expr: job_category
    - name: "Job Category Code"
      expr: job_category_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Preferred Supplier List"
      expr: COUNT(DISTINCT preferred_supplier_list_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_program_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Allocation business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`program_allocation`"
  dimensions:
    - name: "Allocation Code"
      expr: allocation_code
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Auto Distribute"
      expr: auto_distribute
    - name: "Compliance Verified"
      expr: compliance_verified
    - name: "Compliance Verified Date"
      expr: compliance_verified_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusive Category"
      expr: exclusive_category
    - name: "Expiration Date"
      expr: expiration_date
    - name: "First Look Days"
      expr: first_look_days
    - name: "Ic Eligible"
      expr: ic_eligible
    - name: "Job Category"
      expr: job_category
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Max Concurrent Submissions"
      expr: max_concurrent_submissions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Allocation"
      expr: COUNT(DISTINCT program_allocation_id)
    - name: "Total Allocation Pct"
      expr: SUM(allocation_pct)
    - name: "Average Allocation Pct"
      expr: AVG(allocation_pct)
    - name: "Total Max Bill Rate"
      expr: SUM(max_bill_rate)
    - name: "Average Max Bill Rate"
      expr: AVG(max_bill_rate)
    - name: "Total Max Markup Pct"
      expr: SUM(max_markup_pct)
    - name: "Average Max Markup Pct"
      expr: AVG(max_markup_pct)
    - name: "Total Max Pay Rate"
      expr: SUM(max_pay_rate)
    - name: "Average Max Pay Rate"
      expr: AVG(max_pay_rate)
    - name: "Total Min Fill Rate Pct"
      expr: SUM(min_fill_rate_pct)
    - name: "Average Min Fill Rate Pct"
      expr: AVG(min_fill_rate_pct)
    - name: "Total Ot Bill Rate Multiplier"
      expr: SUM(ot_bill_rate_multiplier)
    - name: "Average Ot Bill Rate Multiplier"
      expr: AVG(ot_bill_rate_multiplier)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_rate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Agreement business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`rate_agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Burden Rate Included"
      expr: burden_rate_included
    - name: "Clm Document Reference"
      expr: clm_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Escalation Clause"
      expr: escalation_clause
    - name: "Escalation Frequency"
      expr: escalation_frequency
    - name: "Execution Date"
      expr: execution_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Governing Law State"
      expr: governing_law_state
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Agreement"
      expr: COUNT(DISTINCT rate_agreement_id)
    - name: "Total Conversion Fee Percentage"
      expr: SUM(conversion_fee_percentage)
    - name: "Average Conversion Fee Percentage"
      expr: AVG(conversion_fee_percentage)
    - name: "Total Dt Markup Percentage"
      expr: SUM(dt_markup_percentage)
    - name: "Average Dt Markup Percentage"
      expr: AVG(dt_markup_percentage)
    - name: "Total Escalation Percentage"
      expr: SUM(escalation_percentage)
    - name: "Average Escalation Percentage"
      expr: AVG(escalation_percentage)
    - name: "Total Markup Percentage"
      expr: SUM(markup_percentage)
    - name: "Average Markup Percentage"
      expr: AVG(markup_percentage)
    - name: "Total Max Exception Markup Pct"
      expr: SUM(max_exception_markup_pct)
    - name: "Average Max Exception Markup Pct"
      expr: AVG(max_exception_markup_pct)
    - name: "Total Msp Fee Percentage"
      expr: SUM(msp_fee_percentage)
    - name: "Average Msp Fee Percentage"
      expr: AVG(msp_fee_percentage)
    - name: "Total Ot Markup Percentage"
      expr: SUM(ot_markup_percentage)
    - name: "Average Ot Markup Percentage"
      expr: AVG(ot_markup_percentage)
    - name: "Total Spread Ceiling Amount"
      expr: SUM(spread_ceiling_amount)
    - name: "Average Spread Ceiling Amount"
      expr: AVG(spread_ceiling_amount)
    - name: "Total Spread Floor Amount"
      expr: SUM(spread_floor_amount)
    - name: "Average Spread Floor Amount"
      expr: AVG(spread_floor_amount)
    - name: "Total Vms Fee Percentage"
      expr: SUM(vms_fee_percentage)
    - name: "Average Vms Fee Percentage"
      expr: AVG(vms_fee_percentage)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_sow_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sow Agreement business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`sow_agreement`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Co Employment Risk Classification"
      expr: co_employment_risk_classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deliverables Summary"
      expr: deliverables_summary
    - name: "Docusign Clm Reference"
      expr: docusign_clm_reference
    - name: "End Date"
      expr: end_date
    - name: "Execution Date"
      expr: execution_date
    - name: "Ic Compliance Verified"
      expr: ic_compliance_verified
    - name: "Insurance Certificate Required"
      expr: insurance_certificate_required
    - name: "Insurance Verified Date"
      expr: insurance_verified_date
    - name: "Latest Amendment Date"
      expr: latest_amendment_date
    - name: "Milestone Count"
      expr: milestone_count
    - name: "Nda Required"
      expr: nda_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sow Agreement"
      expr: COUNT(DISTINCT sow_agreement_id)
    - name: "Total Not To Exceed Amount"
      expr: SUM(not_to_exceed_amount)
    - name: "Average Not To Exceed Amount"
      expr: AVG(not_to_exceed_amount)
    - name: "Total Total Contract Value"
      expr: SUM(total_contract_value)
    - name: "Average Total Contract Value"
      expr: AVG(total_contract_value)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`supplier`"
  dimensions:
    - name: "Business Type"
      expr: business_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diversity Cert Expiry Date"
      expr: diversity_cert_expiry_date
    - name: "Diversity Certifications"
      expr: diversity_certifications
    - name: "Duns Number"
      expr: duns_number
    - name: "Ein"
      expr: ein
    - name: "Hq Address Line1"
      expr: hq_address_line1
    - name: "Hq City"
      expr: hq_city
    - name: "Hq Country"
      expr: hq_country
    - name: "Hq Postal Code"
      expr: hq_postal_code
    - name: "Hq State"
      expr: hq_state
    - name: "Ic Business Structure"
      expr: ic_business_structure
    - name: "Ic Compliance Enrolled"
      expr: ic_compliance_enrolled
    - name: "Ic Compliance Vendor"
      expr: ic_compliance_vendor
    - name: "Ic Risk Score"
      expr: ic_risk_score
    - name: "Ic Worker Classification"
      expr: ic_worker_classification
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier"
      expr: COUNT(DISTINCT supplier_id)
    - name: "Total Fall Off Rate"
      expr: SUM(fall_off_rate)
    - name: "Average Fall Off Rate"
      expr: AVG(fall_off_rate)
    - name: "Total Insurance Gl Limit"
      expr: SUM(insurance_gl_limit)
    - name: "Average Insurance Gl Limit"
      expr: AVG(insurance_gl_limit)
    - name: "Total Insurance Wc Limit"
      expr: SUM(insurance_wc_limit)
    - name: "Average Insurance Wc Limit"
      expr: AVG(insurance_wc_limit)
    - name: "Total Performance Score"
      expr: SUM(performance_score)
    - name: "Average Performance Score"
      expr: AVG(performance_score)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_tier_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier Classification business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`tier_classification`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Compliance Issue Type"
      expr: compliance_issue_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Outcome"
      expr: decision_outcome
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Exclusive Supplier"
      expr: is_exclusive_supplier
    - name: "Is Preferred Vendor"
      expr: is_preferred_vendor
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Previous Tier Code"
      expr: previous_tier_code
    - name: "Program Eligibility Rules"
      expr: program_eligibility_rules
    - name: "Proposed Tier Code"
      expr: proposed_tier_code
    - name: "Rationale Notes"
      expr: rationale_notes
    - name: "Record Type"
      expr: record_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier Classification"
      expr: COUNT(DISTINCT tier_classification_id)
    - name: "Total Max Fill Rate Pct"
      expr: SUM(max_fill_rate_pct)
    - name: "Average Max Fill Rate Pct"
      expr: AVG(max_fill_rate_pct)
    - name: "Total Min Scorecard Score"
      expr: SUM(min_scorecard_score)
    - name: "Average Min Scorecard Score"
      expr: AVG(min_scorecard_score)
    - name: "Total Sla Fill Rate Target Pct"
      expr: SUM(sla_fill_rate_target_pct)
    - name: "Average Sla Fill Rate Target Pct"
      expr: AVG(sla_fill_rate_target_pct)
    - name: "Total Sla Quality Of Submission Target"
      expr: SUM(sla_quality_of_submission_target)
    - name: "Average Sla Quality Of Submission Target"
      expr: AVG(sla_quality_of_submission_target)
    - name: "Total Sla Time To Submit Hours"
      expr: SUM(sla_time_to_submit_hours)
    - name: "Average Sla Time To Submit Hours"
      expr: AVG(sla_time_to_submit_hours)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_vendor_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Compliance business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`vendor_compliance`"
  dimensions:
    - name: "Alert Threshold Days"
      expr: alert_threshold_days
    - name: "Alert Triggered"
      expr: alert_triggered
    - name: "Auto Renewal"
      expr: auto_renewal
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Certificate Holder"
      expr: certificate_holder
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Coi Document Reference"
      expr: coi_document_reference
    - name: "Compliance Category"
      expr: compliance_category
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Coverage Limit Type"
      expr: coverage_limit_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Effective Date"
      expr: document_effective_date
    - name: "Document Expiration Date"
      expr: document_expiration_date
    - name: "Everify Employer Number"
      expr: everify_employer_number
    - name: "Everify Enrollment Date"
      expr: everify_enrollment_date
    - name: "Insurance Type"
      expr: insurance_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Compliance"
      expr: COUNT(DISTINCT vendor_compliance_id)
    - name: "Total Coverage Limit Amount"
      expr: SUM(coverage_limit_amount)
    - name: "Average Coverage Limit Amount"
      expr: AVG(coverage_limit_amount)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_vendor_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Contact business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`vendor_contact`"
  dimensions:
    - name: "Communication Opt Out"
      expr: communication_opt_out
    - name: "Contact Source"
      expr: contact_source
    - name: "Contact Status"
      expr: contact_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department"
      expr: department
    - name: "Email"
      expr: email
    - name: "End Date"
      expr: end_date
    - name: "External Contact Code"
      expr: external_contact_code
    - name: "First Name"
      expr: first_name
    - name: "Full Name"
      expr: full_name
    - name: "Is Billing Contact"
      expr: is_billing_contact
    - name: "Is Compliance Contact"
      expr: is_compliance_contact
    - name: "Is Primary Contact"
      expr: is_primary_contact
    - name: "Is Vms Portal User"
      expr: is_vms_portal_user
    - name: "Job Title"
      expr: job_title
    - name: "Last Contact Date"
      expr: last_contact_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Contact"
      expr: COUNT(DISTINCT vendor_contact_id)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_vendor_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Rate Card business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`vendor_rate_card`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Flsa Classification"
      expr: flsa_classification
    - name: "Geographic Market"
      expr: geographic_market
    - name: "Is Prevailing Wage"
      expr: is_prevailing_wage
    - name: "Is Union Rate"
      expr: is_union_rate
    - name: "Job Category"
      expr: job_category
    - name: "Job Title"
      expr: job_title
    - name: "Labor Category"
      expr: labor_category
    - name: "Negotiation Notes"
      expr: negotiation_notes
    - name: "Rate Card Description"
      expr: rate_card_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Rate Card"
      expr: COUNT(DISTINCT vendor_rate_card_id)
    - name: "Total Burden Rate"
      expr: SUM(burden_rate)
    - name: "Average Burden Rate"
      expr: AVG(burden_rate)
    - name: "Total Dt Bill Rate"
      expr: SUM(dt_bill_rate)
    - name: "Average Dt Bill Rate"
      expr: AVG(dt_bill_rate)
    - name: "Total Dt Pay Rate"
      expr: SUM(dt_pay_rate)
    - name: "Average Dt Pay Rate"
      expr: AVG(dt_pay_rate)
    - name: "Total Markup Percentage"
      expr: SUM(markup_percentage)
    - name: "Average Markup Percentage"
      expr: AVG(markup_percentage)
    - name: "Total Max Bill Rate"
      expr: SUM(max_bill_rate)
    - name: "Average Max Bill Rate"
      expr: AVG(max_bill_rate)
    - name: "Total Min Bill Rate"
      expr: SUM(min_bill_rate)
    - name: "Average Min Bill Rate"
      expr: AVG(min_bill_rate)
    - name: "Total Ot Bill Rate"
      expr: SUM(ot_bill_rate)
    - name: "Average Ot Bill Rate"
      expr: AVG(ot_bill_rate)
    - name: "Total Ot Pay Rate"
      expr: SUM(ot_pay_rate)
    - name: "Average Ot Pay Rate"
      expr: AVG(ot_pay_rate)
    - name: "Total Per Diem Rate"
      expr: SUM(per_diem_rate)
    - name: "Average Per Diem Rate"
      expr: AVG(per_diem_rate)
    - name: "Total Standard Bill Rate"
      expr: SUM(standard_bill_rate)
    - name: "Average Standard Bill Rate"
      expr: AVG(standard_bill_rate)
    - name: "Total Standard Pay Rate"
      expr: SUM(standard_pay_rate)
    - name: "Average Standard Pay Rate"
      expr: AVG(standard_pay_rate)
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`vendor_vms_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vms Enrollment business metrics"
  source: "`staffing_hr_ecm_v1`.`vendor`.`vms_enrollment`"
  dimensions:
    - name: "Approved Job Categories"
      expr: approved_job_categories
    - name: "Approved Work Locations"
      expr: approved_work_locations
    - name: "Assigned Reviewer"
      expr: assigned_reviewer
    - name: "Blocking Task Flag"
      expr: blocking_task_flag
    - name: "Compliance Attestation Status"
      expr: compliance_attestation_status
    - name: "Contract Execution Status"
      expr: contract_execution_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Document Submission Status"
      expr: document_submission_status
    - name: "Electronic Onboarding Complete"
      expr: electronic_onboarding_complete
    - name: "Enrollment Agreement Ref"
      expr: enrollment_agreement_ref
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Expiry Date"
      expr: enrollment_expiry_date
    - name: "Enrollment Notes"
      expr: enrollment_notes
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vms Enrollment"
      expr: COUNT(DISTINCT vms_enrollment_id)
$$;