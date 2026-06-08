-- Metric views for domain: workforce | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:39:57

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_calibration_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Calibration Session business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`calibration_session`"
  dimensions:
    - name: "Action Items"
      expr: action_items
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Calibration Methodology"
      expr: calibration_methodology
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Consensus Achieved"
      expr: consensus_achieved
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decisions Made"
      expr: decisions_made
    - name: "Escalation Required"
      expr: escalation_required
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hcm System Reference"
      expr: hcm_system_reference
    - name: "Is Active"
      expr: is_active
    - name: "Meeting Location"
      expr: meeting_location
    - name: "Meeting Mode"
      expr: meeting_mode
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Calibration Session"
      expr: COUNT(DISTINCT calibration_session_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_competency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competency business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`competency`"
  dimensions:
    - name: "Applicable Job Family"
      expr: applicable_job_family
    - name: "Approved Training Provider"
      expr: approved_training_provider
    - name: "Assessment Method"
      expr: assessment_method
    - name: "Competency Category"
      expr: competency_category
    - name: "Competency Code"
      expr: competency_code
    - name: "Competency Description"
      expr: competency_description
    - name: "Competency Name"
      expr: competency_name
    - name: "Competency Status"
      expr: competency_status
    - name: "Competency Type"
      expr: competency_type
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Digital Certificate Supported"
      expr: digital_certificate_supported
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "External Reference Number"
      expr: external_reference_number
    - name: "Imo Model Course Number"
      expr: imo_model_course_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competency"
      expr: COUNT(DISTINCT competency_id)
    - name: "Total Cost To Obtain"
      expr: SUM(cost_to_obtain)
    - name: "Average Cost To Obtain"
      expr: AVG(cost_to_obtain)
    - name: "Total Training Duration Hours"
      expr: SUM(training_duration_hours)
    - name: "Average Training Duration Hours"
      expr: AVG(training_duration_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_disciplinary_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disciplinary Case business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`disciplinary_case`"
  dimensions:
    - name: "Allegation Category"
      expr: allegation_category
    - name: "Allegation Details"
      expr: allegation_details
    - name: "Appeal Decision Date"
      expr: appeal_decision_date
    - name: "Appeal Filed Date"
      expr: appeal_filed_date
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Case Closure Date"
      expr: case_closure_date
    - name: "Case Opened Date"
      expr: case_opened_date
    - name: "Case Reference Number"
      expr: case_reference_number
    - name: "Case Status"
      expr: case_status
    - name: "Case Type"
      expr: case_type
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employee Representation Type"
      expr: employee_representation_type
    - name: "Escalated To Tribunal Flag"
      expr: escalated_to_tribunal_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Disciplinary Case"
      expr: COUNT(DISTINCT disciplinary_case_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`employee`"
  dimensions:
    - name: "Career Aspirations"
      expr: career_aspirations
    - name: "Competency Certifications"
      expr: competency_certifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Date Of Birth"
      expr: date_of_birth
    - name: "Development Goals"
      expr: development_goals
    - name: "Email Address"
      expr: email_address
    - name: "Emergency Contact Name"
      expr: emergency_contact_name
    - name: "Emergency Contact Phone"
      expr: emergency_contact_phone
    - name: "Emergency Contact Relationship"
      expr: emergency_contact_relationship
    - name: "Employment Status"
      expr: employment_status
    - name: "Employment Type"
      expr: employment_type
    - name: "First Name"
      expr: first_name
    - name: "High Potential Flag"
      expr: high_potential_flag
    - name: "Hire Date"
      expr: hire_date
    - name: "Isps Clearance Expiry Date"
      expr: isps_clearance_expiry_date
    - name: "Isps Clearance Level"
      expr: isps_clearance_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employee"
      expr: COUNT(DISTINCT employee_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_employee_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Employee Certification business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`employee_certification`"
  dimensions:
    - name: "Assessment Result"
      expr: assessment_result
    - name: "Authorised Vessel Types"
      expr: authorised_vessel_types
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Name"
      expr: certification_name
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deployment Eligible Flag"
      expr: deployment_eligible_flag
    - name: "Document Reference"
      expr: document_reference
    - name: "Examining Physician Name"
      expr: examining_physician_name
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fitness Outcome"
      expr: fitness_outcome
    - name: "Fitness Restrictions"
      expr: fitness_restrictions
    - name: "Isps Compliant Flag"
      expr: isps_compliant_flag
    - name: "Issue Date"
      expr: issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Employee Certification"
      expr: COUNT(DISTINCT employee_certification_id)
    - name: "Total Assessment Score"
      expr: SUM(assessment_score)
    - name: "Average Assessment Score"
      expr: AVG(assessment_score)
    - name: "Total Maximum Dwt Tonnes"
      expr: SUM(maximum_dwt_tonnes)
    - name: "Average Maximum Dwt Tonnes"
      expr: AVG(maximum_dwt_tonnes)
    - name: "Total Maximum Loa Metres"
      expr: SUM(maximum_loa_metres)
    - name: "Average Maximum Loa Metres"
      expr: AVG(maximum_loa_metres)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_gang`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gang business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`gang`"
  dimensions:
    - name: "Cargo Type Specialisation"
      expr: cargo_type_specialisation
    - name: "Competency Review Date"
      expr: competency_review_date
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disbandment Date"
      expr: disbandment_date
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Formation Date"
      expr: formation_date
    - name: "Gang Code"
      expr: gang_code
    - name: "Gang Description"
      expr: gang_description
    - name: "Gang Name"
      expr: gang_name
    - name: "Gang Status"
      expr: gang_status
    - name: "Gang Type"
      expr: gang_type
    - name: "Imdg Certified"
      expr: imdg_certified
    - name: "Is Multi Skilled"
      expr: is_multi_skilled
    - name: "Is Permanent"
      expr: is_permanent
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gang"
      expr: COUNT(DISTINCT gang_id)
    - name: "Total Average Experience Years"
      expr: SUM(average_experience_years)
    - name: "Average Average Experience Years"
      expr: AVG(average_experience_years)
    - name: "Total Max Continuous Work Hours"
      expr: SUM(max_continuous_work_hours)
    - name: "Average Max Continuous Work Hours"
      expr: AVG(max_continuous_work_hours)
    - name: "Total Productivity Target Moves Per Hour"
      expr: SUM(productivity_target_moves_per_hour)
    - name: "Average Productivity Target Moves Per Hour"
      expr: AVG(productivity_target_moves_per_hour)
    - name: "Total Rest Period Hours"
      expr: SUM(rest_period_hours)
    - name: "Average Rest Period Hours"
      expr: AVG(rest_period_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_gang_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gang Assignment business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`gang_assignment`"
  dimensions:
    - name: "Actual Finish Time"
      expr: actual_finish_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cargo Type"
      expr: cargo_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deployment Date"
      expr: deployment_date
    - name: "Deployment Number"
      expr: deployment_number
    - name: "Deployment Status"
      expr: deployment_status
    - name: "Deployment Timestamp"
      expr: deployment_timestamp
    - name: "Gang Size Actual"
      expr: gang_size_actual
    - name: "Gang Size Planned"
      expr: gang_size_planned
    - name: "Gang Type"
      expr: gang_type
    - name: "Hatch Number"
      expr: hatch_number
    - name: "Imdg Cargo Flag"
      expr: imdg_cargo_flag
    - name: "Is Overtime Approved"
      expr: is_overtime_approved
    - name: "Is Safety Incident"
      expr: is_safety_incident
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gang Assignment"
      expr: COUNT(DISTINCT gang_assignment_id)
    - name: "Total Gross Hours Worked"
      expr: SUM(gross_hours_worked)
    - name: "Average Gross Hours Worked"
      expr: AVG(gross_hours_worked)
    - name: "Total Moves Per Hour"
      expr: SUM(moves_per_hour)
    - name: "Average Moves Per Hour"
      expr: AVG(moves_per_hour)
    - name: "Total Net Hours Worked"
      expr: SUM(net_hours_worked)
    - name: "Average Net Hours Worked"
      expr: AVG(net_hours_worked)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
    - name: "Total Stoppage Hours"
      expr: SUM(stoppage_hours)
    - name: "Average Stoppage Hours"
      expr: AVG(stoppage_hours)
    - name: "Total Teu Handled"
      expr: SUM(teu_handled)
    - name: "Average Teu Handled"
      expr: AVG(teu_handled)
    - name: "Total Teu Per Gang Hour"
      expr: SUM(teu_per_gang_hour)
    - name: "Average Teu Per Gang Hour"
      expr: AVG(teu_per_gang_hour)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_grievance_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grievance Case business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`grievance_case`"
  dimensions:
    - name: "Assigned Investigator Name"
      expr: assigned_investigator_name
    - name: "Case Number"
      expr: case_number
    - name: "Case Status"
      expr: case_status
    - name: "Closed Date"
      expr: closed_date
    - name: "Corrective Action Description"
      expr: corrective_action_description
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employee Satisfaction Rating"
      expr: employee_satisfaction_rating
    - name: "Escalated Flag"
      expr: escalated_flag
    - name: "Escalation Body"
      expr: escalation_body
    - name: "Escalation Date"
      expr: escalation_date
    - name: "Escalation Reference Number"
      expr: escalation_reference_number
    - name: "Finding Outcome"
      expr: finding_outcome
    - name: "Grievance Category"
      expr: grievance_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grievance Case"
      expr: COUNT(DISTINCT grievance_case_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_headcount_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Headcount Plan business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`headcount_plan`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Attrition Count"
      expr: attrition_count
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Employment Category"
      expr: employment_category
    - name: "Employment Type"
      expr: employment_type
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Isps Clearance Required"
      expr: isps_clearance_required
    - name: "Job Family"
      expr: job_family
    - name: "Mlc Compliant"
      expr: mlc_compliant
    - name: "New Hire Count"
      expr: new_hire_count
    - name: "Plan Notes"
      expr: plan_notes
    - name: "Plan Number"
      expr: plan_number
    - name: "Plan Status"
      expr: plan_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Headcount Plan"
      expr: COUNT(DISTINCT headcount_plan_id)
    - name: "Total Actual Headcount"
      expr: SUM(actual_headcount)
    - name: "Average Actual Headcount"
      expr: AVG(actual_headcount)
    - name: "Total Actual Labour Cost"
      expr: SUM(actual_labour_cost)
    - name: "Average Actual Labour Cost"
      expr: AVG(actual_labour_cost)
    - name: "Total Budgeted Headcount"
      expr: SUM(budgeted_headcount)
    - name: "Average Budgeted Headcount"
      expr: AVG(budgeted_headcount)
    - name: "Total Budgeted Labour Cost"
      expr: SUM(budgeted_labour_cost)
    - name: "Average Budgeted Labour Cost"
      expr: AVG(budgeted_labour_cost)
    - name: "Total Productivity Target Teu Per Gang Hour"
      expr: SUM(productivity_target_teu_per_gang_hour)
    - name: "Average Productivity Target Teu Per Gang Hour"
      expr: AVG(productivity_target_teu_per_gang_hour)
    - name: "Total Variance Headcount"
      expr: SUM(variance_headcount)
    - name: "Average Variance Headcount"
      expr: AVG(variance_headcount)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_labour_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Labour Agreement business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`labour_agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Annual Leave Entitlement Days"
      expr: annual_leave_entitlement_days
    - name: "Applicable Job Families"
      expr: applicable_job_families
    - name: "Coverage Scope"
      expr: coverage_scope
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Resolution Process"
      expr: dispute_resolution_process
    - name: "Document Reference Url"
      expr: document_reference_url
    - name: "Effective Date"
      expr: effective_date
    - name: "Employer Party Name"
      expr: employer_party_name
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fair Work Commission Approval Number"
      expr: fair_work_commission_approval_number
    - name: "Fatigue Management Rules"
      expr: fatigue_management_rules
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Labour Agreement"
      expr: COUNT(DISTINCT labour_agreement_id)
    - name: "Total Minimum Wage Rate"
      expr: SUM(minimum_wage_rate)
    - name: "Average Minimum Wage Rate"
      expr: AVG(minimum_wage_rate)
    - name: "Total Overtime Multiplier"
      expr: SUM(overtime_multiplier)
    - name: "Average Overtime Multiplier"
      expr: AVG(overtime_multiplier)
    - name: "Total Penalty Rate Multiplier"
      expr: SUM(penalty_rate_multiplier)
    - name: "Average Penalty Rate Multiplier"
      expr: AVG(penalty_rate_multiplier)
    - name: "Total Union Dues Percentage"
      expr: SUM(union_dues_percentage)
    - name: "Average Union Dues Percentage"
      expr: AVG(union_dues_percentage)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_leave_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave Request business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`leave_request`"
  dimensions:
    - name: "Actual Return Date"
      expr: actual_return_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved End Date"
      expr: approved_end_date
    - name: "Approved Start Date"
      expr: approved_start_date
    - name: "Approver Comments"
      expr: approver_comments
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employee Comments"
      expr: employee_comments
    - name: "Gang Complement Affected"
      expr: gang_complement_affected
    - name: "Half Day Flag"
      expr: half_day_flag
    - name: "Half Day Session"
      expr: half_day_session
    - name: "Handover Completed Flag"
      expr: handover_completed_flag
    - name: "Leave Category"
      expr: leave_category
    - name: "Leave Loading Applicable"
      expr: leave_loading_applicable
    - name: "Leave Type"
      expr: leave_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Leave Request"
      expr: COUNT(DISTINCT leave_request_id)
    - name: "Total Approved Days"
      expr: SUM(approved_days)
    - name: "Average Approved Days"
      expr: AVG(approved_days)
    - name: "Total Leave Balance At Request"
      expr: SUM(leave_balance_at_request)
    - name: "Average Leave Balance At Request"
      expr: AVG(leave_balance_at_request)
    - name: "Total Requested Days"
      expr: SUM(requested_days)
    - name: "Average Requested Days"
      expr: AVG(requested_days)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_medical_fitness`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Medical Fitness business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`medical_fitness`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By Ohs Manager"
      expr: approved_by_ohs_manager
    - name: "Cardiovascular Assessment"
      expr: cardiovascular_assessment
    - name: "Certificate Expiry Date"
      expr: certificate_expiry_date
    - name: "Certificate Issue Date"
      expr: certificate_issue_date
    - name: "Certificate Issued"
      expr: certificate_issued
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Confidentiality Classification"
      expr: confidentiality_classification
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Drug Screening Conducted"
      expr: drug_screening_conducted
    - name: "Drug Screening Result"
      expr: drug_screening_result
    - name: "Examination Date"
      expr: examination_date
    - name: "Examination Duration Minutes"
      expr: examination_duration_minutes
    - name: "Examination Number"
      expr: examination_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Medical Fitness"
      expr: COUNT(DISTINCT medical_fitness_id)
    - name: "Total Examination Cost"
      expr: SUM(examination_cost)
    - name: "Average Examination Cost"
      expr: AVG(examination_cost)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_mlc_compliance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mlc Compliance Record business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`mlc_compliance_record`"
  dimensions:
    - name: "Accommodation Standard Met"
      expr: accommodation_standard_met
    - name: "Certificate Expiry Date"
      expr: certificate_expiry_date
    - name: "Certificate Issue Date"
      expr: certificate_issue_date
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Complaint Lodged"
      expr: complaint_lodged
    - name: "Complaint Reference"
      expr: complaint_reference
    - name: "Compliance Area"
      expr: compliance_area
    - name: "Compliance Record Number"
      expr: compliance_record_number
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Corrective Action Completed Date"
      expr: corrective_action_completed_date
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Corrective Action Verified By"
      expr: corrective_action_verified_by
    - name: "Declaration Of Mlc Compliance Ref"
      expr: declaration_of_mlc_compliance_ref
    - name: "Flag State Code"
      expr: flag_state_code
    - name: "Inspection Type"
      expr: inspection_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Mlc Compliance Record"
      expr: COUNT(DISTINCT mlc_compliance_record_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_org_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Org Unit business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`org_unit`"
  dimensions:
    - name: "Actual Headcount"
      expr: actual_headcount
    - name: "Attrition Count"
      expr: attrition_count
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Budgeted Headcount"
      expr: budgeted_headcount
    - name: "Casual Headcount"
      expr: casual_headcount
    - name: "Competency Framework"
      expr: competency_framework
    - name: "Contract Headcount"
      expr: contract_headcount
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Headcount Variance"
      expr: headcount_variance
    - name: "Isps Security Level"
      expr: isps_security_level
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Mlc Compliance Required"
      expr: mlc_compliance_required
    - name: "Operational Area"
      expr: operational_area
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Org Unit"
      expr: COUNT(DISTINCT org_unit_id)
    - name: "Total Capex Labour Budget"
      expr: SUM(capex_labour_budget)
    - name: "Average Capex Labour Budget"
      expr: AVG(capex_labour_budget)
    - name: "Total Opex Labour Budget"
      expr: SUM(opex_labour_budget)
    - name: "Average Opex Labour Budget"
      expr: AVG(opex_labour_budget)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_payroll_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payroll Run business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`payroll_run`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bank File Reference"
      expr: bank_file_reference
    - name: "Bank Submission Timestamp"
      expr: bank_submission_timestamp
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Headcount Errors"
      expr: headcount_errors
    - name: "Headcount Processed"
      expr: headcount_processed
    - name: "Mlc Compliant"
      expr: mlc_compliant
    - name: "Oracle Hcm Batch Code"
      expr: oracle_hcm_batch_code
    - name: "Pay Frequency"
      expr: pay_frequency
    - name: "Pay Group Code"
      expr: pay_group_code
    - name: "Pay Group Description"
      expr: pay_group_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payroll Run"
      expr: COUNT(DISTINCT payroll_run_id)
    - name: "Total Gross Pay Total"
      expr: SUM(gross_pay_total)
    - name: "Average Gross Pay Total"
      expr: AVG(gross_pay_total)
    - name: "Total Net Pay Total"
      expr: SUM(net_pay_total)
    - name: "Average Net Pay Total"
      expr: AVG(net_pay_total)
    - name: "Total Total Allowances"
      expr: SUM(total_allowances)
    - name: "Average Total Allowances"
      expr: AVG(total_allowances)
    - name: "Total Total Base Pay"
      expr: SUM(total_base_pay)
    - name: "Average Total Base Pay"
      expr: AVG(total_base_pay)
    - name: "Total Total Deductions"
      expr: SUM(total_deductions)
    - name: "Average Total Deductions"
      expr: AVG(total_deductions)
    - name: "Total Total Employer Contributions"
      expr: SUM(total_employer_contributions)
    - name: "Average Total Employer Contributions"
      expr: AVG(total_employer_contributions)
    - name: "Total Total Overtime Pay"
      expr: SUM(total_overtime_pay)
    - name: "Average Total Overtime Pay"
      expr: AVG(total_overtime_pay)
    - name: "Total Total Pension Deductions"
      expr: SUM(total_pension_deductions)
    - name: "Average Total Pension Deductions"
      expr: AVG(total_pension_deductions)
    - name: "Total Total Tax Withheld"
      expr: SUM(total_tax_withheld)
    - name: "Average Total Tax Withheld"
      expr: AVG(total_tax_withheld)
    - name: "Total Total Union Dues"
      expr: SUM(total_union_dues)
    - name: "Average Total Union Dues"
      expr: AVG(total_union_dues)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_payslip`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payslip business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`payslip`"
  dimensions:
    - name: "Bank Account Reference"
      expr: bank_account_reference
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Employee Full Name"
      expr: employee_full_name
    - name: "Employment Type"
      expr: employment_type
    - name: "Is Mlc Compliant"
      expr: is_mlc_compliant
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "National Id Number"
      expr: national_id_number
    - name: "Pay Frequency"
      expr: pay_frequency
    - name: "Pay Grade"
      expr: pay_grade
    - name: "Pay Period End Date"
      expr: pay_period_end_date
    - name: "Pay Period Start Date"
      expr: pay_period_start_date
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payslip"
      expr: COUNT(DISTINCT payslip_id)
    - name: "Total Base Pay"
      expr: SUM(base_pay)
    - name: "Average Base Pay"
      expr: AVG(base_pay)
    - name: "Total Danger Allowance"
      expr: SUM(danger_allowance)
    - name: "Average Danger Allowance"
      expr: AVG(danger_allowance)
    - name: "Total Employer Pension Contribution"
      expr: SUM(employer_pension_contribution)
    - name: "Average Employer Pension Contribution"
      expr: AVG(employer_pension_contribution)
    - name: "Total Gross Pay"
      expr: SUM(gross_pay)
    - name: "Average Gross Pay"
      expr: AVG(gross_pay)
    - name: "Total Income Tax Deduction"
      expr: SUM(income_tax_deduction)
    - name: "Average Income Tax Deduction"
      expr: AVG(income_tax_deduction)
    - name: "Total Leave Hours Taken"
      expr: SUM(leave_hours_taken)
    - name: "Average Leave Hours Taken"
      expr: AVG(leave_hours_taken)
    - name: "Total Leave Loading Pay"
      expr: SUM(leave_loading_pay)
    - name: "Average Leave Loading Pay"
      expr: AVG(leave_loading_pay)
    - name: "Total Meal Allowance"
      expr: SUM(meal_allowance)
    - name: "Average Meal Allowance"
      expr: AVG(meal_allowance)
    - name: "Total Net Pay"
      expr: SUM(net_pay)
    - name: "Average Net Pay"
      expr: AVG(net_pay)
    - name: "Total Ordinary Hours Worked"
      expr: SUM(ordinary_hours_worked)
    - name: "Average Ordinary Hours Worked"
      expr: AVG(ordinary_hours_worked)
    - name: "Total Other Deductions"
      expr: SUM(other_deductions)
    - name: "Average Other Deductions"
      expr: AVG(other_deductions)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance Review business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "Acknowledgement Status"
      expr: acknowledgement_status
    - name: "Acknowledgement Timestamp"
      expr: acknowledgement_timestamp
    - name: "Bonus Eligibility Flag"
      expr: bonus_eligibility_flag
    - name: "Compensation Adjustment Recommended"
      expr: compensation_adjustment_recommended
    - name: "Competency Rating"
      expr: competency_rating
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Development Plan Summary"
      expr: development_plan_summary
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Employee Comments"
      expr: employee_comments
    - name: "Employee Self Assessment"
      expr: employee_self_assessment
    - name: "Goal Achievement Rating"
      expr: goal_achievement_rating
    - name: "High Potential Flag"
      expr: high_potential_flag
    - name: "Leadership Rating"
      expr: leadership_rating
    - name: "Mlc Compliance Rating"
      expr: mlc_compliance_rating
    - name: "Next Review Due Date"
      expr: next_review_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Performance Review"
      expr: COUNT(DISTINCT performance_review_id)
    - name: "Total Compensation Adjustment Percentage"
      expr: SUM(compensation_adjustment_percentage)
    - name: "Average Compensation Adjustment Percentage"
      expr: AVG(compensation_adjustment_percentage)
    - name: "Total Overall Rating Score"
      expr: SUM(overall_rating_score)
    - name: "Average Overall Rating Score"
      expr: AVG(overall_rating_score)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_pilot_licence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pilot Licence business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`pilot_licence`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cruise Ship Endorsement"
      expr: cruise_ship_endorsement
    - name: "Dangerous Goods Endorsement"
      expr: dangerous_goods_endorsement
    - name: "Endorsement Notes"
      expr: endorsement_notes
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Imdg Classes Authorised"
      expr: imdg_classes_authorised
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority Code"
      expr: issuing_authority_code
    - name: "Issuing Authority Name"
      expr: issuing_authority_name
    - name: "Issuing Country Code"
      expr: issuing_country_code
    - name: "Last Renewal Date"
      expr: last_renewal_date
    - name: "Licence Class"
      expr: licence_class
    - name: "Licence Number"
      expr: licence_number
    - name: "Licence Status"
      expr: licence_status
    - name: "Lng Carrier Endorsement"
      expr: lng_carrier_endorsement
    - name: "Medical Certificate Expiry Date"
      expr: medical_certificate_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pilot Licence"
      expr: COUNT(DISTINCT pilot_licence_id)
    - name: "Total Maximum Dwt Tonnes"
      expr: SUM(maximum_dwt_tonnes)
    - name: "Average Maximum Dwt Tonnes"
      expr: AVG(maximum_dwt_tonnes)
    - name: "Total Maximum Grt Tonnes"
      expr: SUM(maximum_grt_tonnes)
    - name: "Average Maximum Grt Tonnes"
      expr: AVG(maximum_grt_tonnes)
    - name: "Total Maximum Loa Metres"
      expr: SUM(maximum_loa_metres)
    - name: "Average Maximum Loa Metres"
      expr: AVG(maximum_loa_metres)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`position`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Employment Type"
      expr: employment_type
    - name: "Grade Band"
      expr: grade_band
    - name: "Headcount Budget"
      expr: headcount_budget
    - name: "Is Isps Designated"
      expr: is_isps_designated
    - name: "Is Management Position"
      expr: is_management_position
    - name: "Is Operational Position"
      expr: is_operational_position
    - name: "Is Safety Critical"
      expr: is_safety_critical
    - name: "Job Category"
      expr: job_category
    - name: "Job Family"
      expr: job_family
    - name: "Key Performance Indicators"
      expr: key_performance_indicators
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Minimum Education Level"
      expr: minimum_education_level
    - name: "Minimum Experience Years"
      expr: minimum_experience_years
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Position"
      expr: COUNT(DISTINCT position_id)
    - name: "Total Full Time Equivalent"
      expr: SUM(full_time_equivalent)
    - name: "Average Full Time Equivalent"
      expr: AVG(full_time_equivalent)
    - name: "Total Salary Range Maximum"
      expr: SUM(salary_range_maximum)
    - name: "Average Salary Range Maximum"
      expr: AVG(salary_range_maximum)
    - name: "Total Salary Range Minimum"
      expr: SUM(salary_range_minimum)
    - name: "Average Salary Range Minimum"
      expr: AVG(salary_range_minimum)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_position_competency_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position Competency Requirement business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`position_competency_requirement`"
  dimensions:
    - name: "Assessment Frequency"
      expr: assessment_frequency
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Mandatory Flag"
      expr: mandatory_flag
    - name: "Minimum Proficiency Level"
      expr: minimum_proficiency_level
    - name: "Notes"
      expr: notes
    - name: "Required Certifications"
      expr: required_certifications
    - name: "Required Competencies"
      expr: required_competencies
    - name: "Requirement Source"
      expr: requirement_source
    - name: "Revalidation Required"
      expr: revalidation_required
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
    - name: "Expiry Date Month"
      expr: DATE_TRUNC('MONTH', expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Position Competency Requirement"
      expr: COUNT(DISTINCT position_competency_requirement_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roster business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`roster`"
  dimensions:
    - name: "Advance Notice Days"
      expr: advance_notice_days
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Break Entitlement Minutes"
      expr: break_entitlement_minutes
    - name: "Change Notes"
      expr: change_notes
    - name: "Change Reason"
      expr: change_reason
    - name: "Competency Verified"
      expr: competency_verified
    - name: "Confirmed Timestamp"
      expr: confirmed_timestamp
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department Code"
      expr: department_code
    - name: "Equipment Type Assigned"
      expr: equipment_type_assigned
    - name: "Isps Clearance Required"
      expr: isps_clearance_required
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Roster"
      expr: COUNT(DISTINCT roster_id)
    - name: "Total Mlc Min Rest Hours"
      expr: SUM(mlc_min_rest_hours)
    - name: "Average Mlc Min Rest Hours"
      expr: AVG(mlc_min_rest_hours)
    - name: "Total Overtime Rate Multiplier"
      expr: SUM(overtime_rate_multiplier)
    - name: "Average Overtime Rate Multiplier"
      expr: AVG(overtime_rate_multiplier)
    - name: "Total Planned Duration Hours"
      expr: SUM(planned_duration_hours)
    - name: "Average Planned Duration Hours"
      expr: AVG(planned_duration_hours)
    - name: "Total Preceding Rest Hours"
      expr: SUM(preceding_rest_hours)
    - name: "Average Preceding Rest Hours"
      expr: AVG(preceding_rest_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_shift_pattern`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift Pattern business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`shift_pattern`"
  dimensions:
    - name: "Applicable Department"
      expr: applicable_department
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Break Count"
      expr: break_count
    - name: "Break Duration Minutes"
      expr: break_duration_minutes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Of Week"
      expr: days_of_week
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "End Time"
      expr: end_time
    - name: "Enterprise Award Code"
      expr: enterprise_award_code
    - name: "Hcm Work Schedule Code"
      expr: hcm_work_schedule_code
    - name: "Is Break Paid"
      expr: is_break_paid
    - name: "Is Overnight"
      expr: is_overnight
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Shift Pattern"
      expr: COUNT(DISTINCT shift_pattern_id)
    - name: "Total Fatigue Risk Index"
      expr: SUM(fatigue_risk_index)
    - name: "Average Fatigue Risk Index"
      expr: AVG(fatigue_risk_index)
    - name: "Total Mlc Max Hours Work Per Day"
      expr: SUM(mlc_max_hours_work_per_day)
    - name: "Average Mlc Max Hours Work Per Day"
      expr: AVG(mlc_max_hours_work_per_day)
    - name: "Total Mlc Max Hours Work Per Week"
      expr: SUM(mlc_max_hours_work_per_week)
    - name: "Average Mlc Max Hours Work Per Week"
      expr: AVG(mlc_max_hours_work_per_week)
    - name: "Total Mlc Min Rest Hours Per Day"
      expr: SUM(mlc_min_rest_hours_per_day)
    - name: "Average Mlc Min Rest Hours Per Day"
      expr: AVG(mlc_min_rest_hours_per_day)
    - name: "Total Mlc Min Rest Hours Per Week"
      expr: SUM(mlc_min_rest_hours_per_week)
    - name: "Average Mlc Min Rest Hours Per Week"
      expr: AVG(mlc_min_rest_hours_per_week)
    - name: "Total Overtime Threshold Hours"
      expr: SUM(overtime_threshold_hours)
    - name: "Average Overtime Threshold Hours"
      expr: AVG(overtime_threshold_hours)
    - name: "Total Paid Hours"
      expr: SUM(paid_hours)
    - name: "Average Paid Hours"
      expr: AVG(paid_hours)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_talent_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent Profile business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`talent_profile`"
  dimensions:
    - name: "Career Aspiration"
      expr: career_aspiration
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Experience Gaps"
      expr: critical_experience_gaps
    - name: "Development Goals"
      expr: development_goals
    - name: "Development Priority"
      expr: development_priority
    - name: "Education Level"
      expr: education_level
    - name: "Impact Of Loss"
      expr: impact_of_loss
    - name: "Isps Clearance Level"
      expr: isps_clearance_level
    - name: "Key Skills"
      expr: key_skills
    - name: "Languages Spoken"
      expr: languages_spoken
    - name: "Last Talent Review Date"
      expr: last_talent_review_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Leadership Competencies"
      expr: leadership_competencies
    - name: "Mentoring Status"
      expr: mentoring_status
    - name: "Mlc Compliance Status"
      expr: mlc_compliance_status
    - name: "Mobility Preference"
      expr: mobility_preference
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Talent Profile"
      expr: COUNT(DISTINCT talent_profile_id)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_time_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time Attendance business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`time_attendance`"
  dimensions:
    - name: "Absence Type"
      expr: absence_type
    - name: "Amendment Reason"
      expr: amendment_reason
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Attendance Date"
      expr: attendance_date
    - name: "Attendance Status"
      expr: attendance_status
    - name: "Biometric Verified"
      expr: biometric_verified
    - name: "Break Duration Minutes"
      expr: break_duration_minutes
    - name: "Break End Timestamp"
      expr: break_end_timestamp
    - name: "Break Start Timestamp"
      expr: break_start_timestamp
    - name: "Clock In Timestamp"
      expr: clock_in_timestamp
    - name: "Clock Out Timestamp"
      expr: clock_out_timestamp
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Early Departure Minutes"
      expr: early_departure_minutes
    - name: "Entry Method"
      expr: entry_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Time Attendance"
      expr: COUNT(DISTINCT time_attendance_id)
    - name: "Total Hours Worked"
      expr: SUM(hours_worked)
    - name: "Average Hours Worked"
      expr: AVG(hours_worked)
    - name: "Total Overtime Hours"
      expr: SUM(overtime_hours)
    - name: "Average Overtime Hours"
      expr: AVG(overtime_hours)
    - name: "Total Rest Hours Before Shift"
      expr: SUM(rest_hours_before_shift)
    - name: "Average Rest Hours Before Shift"
      expr: AVG(rest_hours_before_shift)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_training_course`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training Course business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`training_course`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Assessment Method"
      expr: assessment_method
    - name: "Certificate Validity Months"
      expr: certificate_validity_months
    - name: "Certification Issued Flag"
      expr: certification_issued_flag
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Course Code"
      expr: course_code
    - name: "Course Language"
      expr: course_language
    - name: "Course Materials Provided Flag"
      expr: course_materials_provided_flag
    - name: "Course Objectives"
      expr: course_objectives
    - name: "Course Status"
      expr: course_status
    - name: "Course Title"
      expr: course_title
    - name: "Course Type"
      expr: course_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "Effective End Date"
      expr: effective_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Training Course"
      expr: COUNT(DISTINCT training_course_id)
    - name: "Total Course Cost Amount"
      expr: SUM(course_cost_amount)
    - name: "Average Course Cost Amount"
      expr: AVG(course_cost_amount)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Passing Score Percentage"
      expr: SUM(passing_score_percentage)
    - name: "Average Passing Score Percentage"
      expr: AVG(passing_score_percentage)
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`workforce_training_enrolment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Training Enrolment business metrics"
  source: "`shipping_ports_ecm`.`workforce`.`training_enrolment`"
  dimensions:
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Assessment Result"
      expr: assessment_result
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Certification Issued Flag"
      expr: certification_issued_flag
    - name: "Certification Number"
      expr: certification_number
    - name: "Competency Code"
      expr: competency_code
    - name: "Completion Date"
      expr: completion_date
    - name: "Cost Centre Code"
      expr: cost_centre_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Employee Comments"
      expr: employee_comments
    - name: "Enrolment Date"
      expr: enrolment_date
    - name: "Enrolment Number"
      expr: enrolment_number
    - name: "Enrolment Source"
      expr: enrolment_source
    - name: "Enrolment Status"
      expr: enrolment_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Training Enrolment"
      expr: COUNT(DISTINCT training_enrolment_id)
    - name: "Total Assessment Score"
      expr: SUM(assessment_score)
    - name: "Average Assessment Score"
      expr: AVG(assessment_score)
    - name: "Total Attendance Percentage"
      expr: SUM(attendance_percentage)
    - name: "Average Attendance Percentage"
      expr: AVG(attendance_percentage)
    - name: "Total Passing Score Threshold"
      expr: SUM(passing_score_threshold)
    - name: "Average Passing Score Threshold"
      expr: AVG(passing_score_threshold)
    - name: "Total Training Cost Amount"
      expr: SUM(training_cost_amount)
    - name: "Average Training Cost Amount"
      expr: AVG(training_cost_amount)
    - name: "Total Training Hours"
      expr: SUM(training_hours)
    - name: "Average Training Hours"
      expr: AVG(training_hours)
$$;