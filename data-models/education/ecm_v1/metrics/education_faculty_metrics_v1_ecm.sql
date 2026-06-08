-- Metric views for domain: faculty | Business: Education | Version: 1 | Generated on: 2026-05-06 12:18:16

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_accreditation_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation Qualification business metrics"
  source: "`education_ecm`.`faculty`.`accreditation_qualification`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Accreditation Visit Cycle"
      expr: accreditation_visit_cycle
    - name: "Approval Date"
      expr: approval_date
    - name: "Determination Date"
      expr: determination_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Graduate Hours In Discipline"
      expr: graduate_hours_in_discipline
    - name: "Industry Certification Date"
      expr: industry_certification_date
    - name: "Industry Certification Expiration Date"
      expr: industry_certification_expiration_date
    - name: "Industry Certification Issuing Body"
      expr: industry_certification_issuing_body
    - name: "Industry Certification Name"
      expr: industry_certification_name
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Professional Experience Description"
      expr: professional_experience_description
    - name: "Professional License Expiration Date"
      expr: professional_license_expiration_date
    - name: "Professional License Number"
      expr: professional_license_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accreditation Qualification"
      expr: COUNT(DISTINCT accreditation_qualification_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_advising_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advising Assignment business metrics"
  source: "`education_ecm`.`faculty`.`advising_assignment`"
  dimensions:
    - name: "Academic Program Code"
      expr: academic_program_code
    - name: "Accreditation Reportable Flag"
      expr: accreditation_reportable_flag
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Advising Type"
      expr: advising_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Assignment Status"
      expr: assignment_status
    - name: "College Code"
      expr: college_code
    - name: "Committee Role"
      expr: committee_role
    - name: "Compensation Eligible Flag"
      expr: compensation_eligible_flag
    - name: "Department Code"
      expr: department_code
    - name: "Expected End Date"
      expr: expected_end_date
    - name: "Last Contact Date"
      expr: last_contact_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Advising Assignment"
      expr: COUNT(DISTINCT advising_assignment_id)
    - name: "Total Advising Credit Hours"
      expr: SUM(advising_credit_hours)
    - name: "Average Advising Credit Hours"
      expr: AVG(advising_credit_hours)
    - name: "Total Advising Load Count"
      expr: SUM(advising_load_count)
    - name: "Average Advising Load Count"
      expr: AVG(advising_load_count)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_annual_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annual Review business metrics"
  source: "`education_ecm`.`faculty`.`annual_review`"
  dimensions:
    - name: "Academic Rank"
      expr: academic_rank
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Approving Authority"
      expr: approving_authority
    - name: "Chair Review Submitted Date"
      expr: chair_review_submitted_date
    - name: "Committee Assignments Count"
      expr: committee_assignments_count
    - name: "Courses Taught Count"
      expr: courses_taught_count
    - name: "Currency Code"
      expr: currency_code
    - name: "Dean Review Submitted Date"
      expr: dean_review_submitted_date
    - name: "Department Chair Narrative"
      expr: department_chair_narrative
    - name: "Faculty Self Evaluation Narrative"
      expr: faculty_self_evaluation_narrative
    - name: "Faculty Self Evaluation Submitted Date"
      expr: faculty_self_evaluation_submitted_date
    - name: "Final Approval Date"
      expr: final_approval_date
    - name: "Goals For Next Period"
      expr: goals_for_next_period
    - name: "Graduate Students Advised Count"
      expr: graduate_students_advised_count
    - name: "Grants Awarded Count"
      expr: grants_awarded_count
    - name: "Grants Submitted Count"
      expr: grants_submitted_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Annual Review"
      expr: COUNT(DISTINCT annual_review_id)
    - name: "Total Average Course Evaluation Score"
      expr: SUM(average_course_evaluation_score)
    - name: "Average Average Course Evaluation Score"
      expr: AVG(average_course_evaluation_score)
    - name: "Total Fte"
      expr: SUM(fte)
    - name: "Average Fte"
      expr: AVG(fte)
    - name: "Total Grant Funding Amount"
      expr: SUM(grant_funding_amount)
    - name: "Average Grant Funding Amount"
      expr: AVG(grant_funding_amount)
    - name: "Total Merit Pay Amount"
      expr: SUM(merit_pay_amount)
    - name: "Average Merit Pay Amount"
      expr: AVG(merit_pay_amount)
    - name: "Total Merit Pay Percentage"
      expr: SUM(merit_pay_percentage)
    - name: "Average Merit Pay Percentage"
      expr: AVG(merit_pay_percentage)
    - name: "Total Teaching Load Credit Hours"
      expr: SUM(teaching_load_credit_hours)
    - name: "Average Teaching Load Credit Hours"
      expr: AVG(teaching_load_credit_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment business metrics"
  source: "`education_ecm`.`faculty`.`appointment`"
  dimensions:
    - name: "Academic Rank"
      expr: academic_rank
    - name: "Appointment Number"
      expr: appointment_number
    - name: "Appointment Status"
      expr: appointment_status
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Benefits Eligible Flag"
      expr: benefits_eligible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Endowed Chair Name"
      expr: endowed_chair_name
    - name: "Grant Funded Flag"
      expr: grant_funded_flag
    - name: "Joint Appointment Flag"
      expr: joint_appointment_flag
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Primary Department Code"
      expr: primary_department_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Appointment"
      expr: COUNT(DISTINCT appointment_id)
    - name: "Total Annual Salary Amount"
      expr: SUM(annual_salary_amount)
    - name: "Average Annual Salary Amount"
      expr: AVG(annual_salary_amount)
    - name: "Total Fte Allocation"
      expr: SUM(fte_allocation)
    - name: "Average Fte Allocation"
      expr: AVG(fte_allocation)
    - name: "Total Research Expectation Percentage"
      expr: SUM(research_expectation_percentage)
    - name: "Average Research Expectation Percentage"
      expr: AVG(research_expectation_percentage)
    - name: "Total Service Expectation Percentage"
      expr: SUM(service_expectation_percentage)
    - name: "Average Service Expectation Percentage"
      expr: AVG(service_expectation_percentage)
    - name: "Total Teaching Load Credit Hours"
      expr: SUM(teaching_load_credit_hours)
    - name: "Average Teaching Load Credit Hours"
      expr: AVG(teaching_load_credit_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_compensation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation business metrics"
  source: "`education_ecm`.`faculty`.`compensation`"
  dimensions:
    - name: "Accreditation Qualified Flag"
      expr: accreditation_qualified_flag
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Budget Account Code"
      expr: budget_account_code
    - name: "Cip Code"
      expr: cip_code
    - name: "Compensation Status"
      expr: compensation_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Funding Source"
      expr: funding_source
    - name: "Last Salary Action Date"
      expr: last_salary_action_date
    - name: "Last Salary Action Type"
      expr: last_salary_action_type
    - name: "Market Equity Adjustment Flag"
      expr: market_equity_adjustment_flag
    - name: "Notes"
      expr: notes
    - name: "Overload Courses Count"
      expr: overload_courses_count
    - name: "Pay Grade"
      expr: pay_grade
    - name: "Rank At Compensation"
      expr: rank_at_compensation
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Compensation"
      expr: COUNT(DISTINCT compensation_id)
    - name: "Total Administrative Stipend Amount"
      expr: SUM(administrative_stipend_amount)
    - name: "Average Administrative Stipend Amount"
      expr: AVG(administrative_stipend_amount)
    - name: "Total Base Salary Amount"
      expr: SUM(base_salary_amount)
    - name: "Average Base Salary Amount"
      expr: AVG(base_salary_amount)
    - name: "Total Contract Months"
      expr: SUM(contract_months)
    - name: "Average Contract Months"
      expr: AVG(contract_months)
    - name: "Total Fte"
      expr: SUM(fte)
    - name: "Average Fte"
      expr: AVG(fte)
    - name: "Total Market Equity Adjustment Amount"
      expr: SUM(market_equity_adjustment_amount)
    - name: "Average Market Equity Adjustment Amount"
      expr: AVG(market_equity_adjustment_amount)
    - name: "Total Overload Pay Rate"
      expr: SUM(overload_pay_rate)
    - name: "Average Overload Pay Rate"
      expr: AVG(overload_pay_rate)
    - name: "Total Summer Salary Amount"
      expr: SUM(summer_salary_amount)
    - name: "Average Summer Salary Amount"
      expr: AVG(summer_salary_amount)
    - name: "Total Total Compensation Amount"
      expr: SUM(total_compensation_amount)
    - name: "Average Total Compensation Amount"
      expr: AVG(total_compensation_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_credential`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credential business metrics"
  source: "`education_ecm`.`faculty`.`credential`"
  dimensions:
    - name: "Accreditation Qualifier"
      expr: accreditation_qualifier
    - name: "Awarding Institution"
      expr: awarding_institution
    - name: "Awarding Institution Country"
      expr: awarding_institution_country
    - name: "Cip Code"
      expr: cip_code
    - name: "Conferral Date"
      expr: conferral_date
    - name: "Continuing Education Required Flag"
      expr: continuing_education_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credential Level"
      expr: credential_level
    - name: "Credential Name"
      expr: credential_name
    - name: "Credential Type"
      expr: credential_type
    - name: "Degree Type"
      expr: degree_type
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Field Of Study"
      expr: field_of_study
    - name: "Issuing Body Accreditation Status"
      expr: issuing_body_accreditation_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credential"
      expr: COUNT(DISTINCT credential_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_department_affiliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department Affiliation business metrics"
  source: "`education_ecm`.`faculty`.`department_affiliation`"
  dimensions:
    - name: "Accreditation Qualified Flag"
      expr: accreditation_qualified_flag
    - name: "Affiliation Notes"
      expr: affiliation_notes
    - name: "Affiliation Status"
      expr: affiliation_status
    - name: "Affiliation Type"
      expr: affiliation_type
    - name: "Appointment Designation"
      expr: appointment_designation
    - name: "Approval Date"
      expr: approval_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Departmental Email"
      expr: departmental_email
    - name: "Doctoral Committee Eligibility"
      expr: doctoral_committee_eligibility
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Graduate Faculty Status"
      expr: graduate_faculty_status
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Office Location"
      expr: office_location
    - name: "Office Phone"
      expr: office_phone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Department Affiliation"
      expr: COUNT(DISTINCT department_affiliation_id)
    - name: "Total Fte Percentage"
      expr: SUM(fte_percentage)
    - name: "Average Fte Percentage"
      expr: AVG(fte_percentage)
    - name: "Total Research Load Percentage"
      expr: SUM(research_load_percentage)
    - name: "Average Research Load Percentage"
      expr: AVG(research_load_percentage)
    - name: "Total Salary Allocation Percentage"
      expr: SUM(salary_allocation_percentage)
    - name: "Average Salary Allocation Percentage"
      expr: AVG(salary_allocation_percentage)
    - name: "Total Service Load Percentage"
      expr: SUM(service_load_percentage)
    - name: "Average Service Load Percentage"
      expr: AVG(service_load_percentage)
    - name: "Total Teaching Load Percentage"
      expr: SUM(teaching_load_percentage)
    - name: "Average Teaching Load Percentage"
      expr: AVG(teaching_load_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_endowed_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Endowed Position business metrics"
  source: "`education_ecm`.`faculty`.`endowed_position`"
  dimensions:
    - name: "Appointment End Date"
      expr: appointment_end_date
    - name: "Appointment Start Date"
      expr: appointment_start_date
    - name: "Appointment Term Years"
      expr: appointment_term_years
    - name: "Approval Authority"
      expr: approval_authority
    - name: "Cip Code"
      expr: cip_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Discipline Area"
      expr: discipline_area
    - name: "Donor Recognition Level"
      expr: donor_recognition_level
    - name: "Donor Reporting Required Flag"
      expr: donor_reporting_required_flag
    - name: "Establishment Date"
      expr: establishment_date
    - name: "Gift Date"
      expr: gift_date
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Position Notes"
      expr: position_notes
    - name: "Position Status"
      expr: position_status
    - name: "Position Title"
      expr: position_title
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Endowed Position"
      expr: COUNT(DISTINCT endowed_position_id)
    - name: "Total Discretionary Fund Amount"
      expr: SUM(discretionary_fund_amount)
    - name: "Average Discretionary Fund Amount"
      expr: AVG(discretionary_fund_amount)
    - name: "Total Gift Amount"
      expr: SUM(gift_amount)
    - name: "Average Gift Amount"
      expr: AVG(gift_amount)
    - name: "Total Salary Supplement Amount"
      expr: SUM(salary_supplement_amount)
    - name: "Average Salary Supplement Amount"
      expr: AVG(salary_supplement_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_event_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event Participation business metrics"
  source: "`education_ecm`.`faculty`.`event_participation`"
  dimensions:
    - name: "Honoree Flag"
      expr: honoree_flag
    - name: "Invitation Date"
      expr: invitation_date
    - name: "Notes"
      expr: notes
    - name: "Participation Status"
      expr: participation_status
    - name: "Presentation Duration Minutes"
      expr: presentation_duration_minutes
    - name: "Presentation Title"
      expr: presentation_title
    - name: "Response Date"
      expr: response_date
    - name: "Role Type"
      expr: role_type
    - name: "Travel Reimbursed Flag"
      expr: travel_reimbursed_flag
    - name: "Invitation Date Month"
      expr: DATE_TRUNC('MONTH', invitation_date)
    - name: "Response Date Month"
      expr: DATE_TRUNC('MONTH', response_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Event Participation"
      expr: COUNT(DISTINCT event_participation_id)
    - name: "Total Service Credit Hours"
      expr: SUM(service_credit_hours)
    - name: "Average Service Credit Hours"
      expr: AVG(service_credit_hours)
    - name: "Total Speaker Fee Amount"
      expr: SUM(speaker_fee_amount)
    - name: "Average Speaker Fee Amount"
      expr: AVG(speaker_fee_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_external_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "External Engagement business metrics"
  source: "`education_ecm`.`faculty`.`external_engagement`"
  dimensions:
    - name: "Accreditation Reportable Flag"
      expr: accreditation_reportable_flag
    - name: "Approval Conditions"
      expr: approval_conditions
    - name: "Approval Date"
      expr: approval_date
    - name: "Compensation Currency Code"
      expr: compensation_currency_code
    - name: "Compensation Disclosed Flag"
      expr: compensation_disclosed_flag
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Conflict Of Interest Description"
      expr: conflict_of_interest_description
    - name: "Conflict Of Interest Disclosed Flag"
      expr: conflict_of_interest_disclosed_flag
    - name: "Conflict Of Interest Mitigation Plan"
      expr: conflict_of_interest_mitigation_plan
    - name: "Disclosure Date"
      expr: disclosure_date
    - name: "End Date"
      expr: end_date
    - name: "Engagement Notes"
      expr: engagement_notes
    - name: "Engagement Number"
      expr: engagement_number
    - name: "Engagement Status"
      expr: engagement_status
    - name: "Engagement Type"
      expr: engagement_type
    - name: "Impact On Teaching Load Flag"
      expr: impact_on_teaching_load_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct External Engagement"
      expr: COUNT(DISTINCT external_engagement_id)
    - name: "Total Compensation Amount"
      expr: SUM(compensation_amount)
    - name: "Average Compensation Amount"
      expr: AVG(compensation_amount)
    - name: "Total Estimated Time Commitment Hours"
      expr: SUM(estimated_time_commitment_hours)
    - name: "Average Estimated Time Commitment Hours"
      expr: AVG(estimated_time_commitment_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_faculty_application_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty Application Access business metrics"
  source: "`education_ecm`.`faculty`.`faculty_application_access`"
  dimensions:
    - name: "Access Expiration Date"
      expr: access_expiration_date
    - name: "Access Level"
      expr: access_level
    - name: "Access Status"
      expr: access_status
    - name: "Approved By"
      expr: approved_by
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Deprovisioning Date"
      expr: deprovisioning_date
    - name: "Deprovisioning Reason"
      expr: deprovisioning_reason
    - name: "Last Login Date"
      expr: last_login_date
    - name: "License Type"
      expr: license_type
    - name: "Provisioning Date"
      expr: provisioning_date
    - name: "Requested By"
      expr: requested_by
    - name: "Training Completed Flag"
      expr: training_completed_flag
    - name: "Training Completion Date"
      expr: training_completion_date
    - name: "User Role"
      expr: user_role
    - name: "Access Expiration Date Month"
      expr: DATE_TRUNC('MONTH', access_expiration_date)
    - name: "Deprovisioning Date Month"
      expr: DATE_TRUNC('MONTH', deprovisioning_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Faculty Application Access"
      expr: COUNT(DISTINCT faculty_application_access_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_faculty_training_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty Training Completion business metrics"
  source: "`education_ecm`.`faculty`.`faculty_training_completion`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Attempt Number"
      expr: attempt_number
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Due Date"
      expr: due_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Access Date"
      expr: last_access_date
    - name: "Last Notification Date"
      expr: last_notification_date
    - name: "Notification Sent Count"
      expr: notification_sent_count
    - name: "Time Spent Minutes"
      expr: time_spent_minutes
    - name: "Waiver Date"
      expr: waiver_date
    - name: "Waiver Reason"
      expr: waiver_reason
    - name: "Assignment Date Month"
      expr: DATE_TRUNC('MONTH', assignment_date)
    - name: "Completion Date Month"
      expr: DATE_TRUNC('MONTH', completion_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Faculty Training Completion"
      expr: COUNT(DISTINCT faculty_training_completion_id)
    - name: "Total Assessment Score"
      expr: SUM(assessment_score)
    - name: "Average Assessment Score"
      expr: AVG(assessment_score)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_hire_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hire Event business metrics"
  source: "`education_ecm`.`faculty`.`hire_event`"
  dimensions:
    - name: "Accreditation Qualified Flag"
      expr: accreditation_qualified_flag
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Candidate Source"
      expr: candidate_source
    - name: "Degree Granting Institution"
      expr: degree_granting_institution
    - name: "Diversity Hire Flag"
      expr: diversity_hire_flag
    - name: "Doctoral Committee Eligibility"
      expr: doctoral_committee_eligibility
    - name: "External Hire Flag"
      expr: external_hire_flag
    - name: "Graduate Faculty Status"
      expr: graduate_faculty_status
    - name: "Highest Degree Earned"
      expr: highest_degree_earned
    - name: "Hire Notes"
      expr: hire_notes
    - name: "Hire Status"
      expr: hire_status
    - name: "Initial Rank"
      expr: initial_rank
    - name: "Negotiated Start Date"
      expr: negotiated_start_date
    - name: "Offer Accepted Date"
      expr: offer_accepted_date
    - name: "Offer Date"
      expr: offer_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hire Event"
      expr: COUNT(DISTINCT hire_event_id)
    - name: "Total Contract Months"
      expr: SUM(contract_months)
    - name: "Average Contract Months"
      expr: AVG(contract_months)
    - name: "Total Fte"
      expr: SUM(fte)
    - name: "Average Fte"
      expr: AVG(fte)
    - name: "Total Initial Annual Salary"
      expr: SUM(initial_annual_salary)
    - name: "Average Initial Annual Salary"
      expr: AVG(initial_annual_salary)
    - name: "Total Relocation Assistance Amount"
      expr: SUM(relocation_assistance_amount)
    - name: "Average Relocation Assistance Amount"
      expr: AVG(relocation_assistance_amount)
    - name: "Total Research Load Percentage"
      expr: SUM(research_load_percentage)
    - name: "Average Research Load Percentage"
      expr: AVG(research_load_percentage)
    - name: "Total Service Load Percentage"
      expr: SUM(service_load_percentage)
    - name: "Average Service Load Percentage"
      expr: AVG(service_load_percentage)
    - name: "Total Startup Package Amount"
      expr: SUM(startup_package_amount)
    - name: "Average Startup Package Amount"
      expr: AVG(startup_package_amount)
    - name: "Total Teaching Load Percentage"
      expr: SUM(teaching_load_percentage)
    - name: "Average Teaching Load Percentage"
      expr: AVG(teaching_load_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_instructor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instructor business metrics"
  source: "`education_ecm`.`faculty`.`instructor`"
  dimensions:
    - name: "Appointment End Date"
      expr: appointment_end_date
    - name: "Appointment Start Date"
      expr: appointment_start_date
    - name: "Canvas User Code"
      expr: canvas_user_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Diversity Self Identification"
      expr: diversity_self_identification
    - name: "Email Address"
      expr: email_address
    - name: "Emplid"
      expr: emplid
    - name: "Employment Classification"
      expr: employment_classification
    - name: "Faculty Rank"
      expr: faculty_rank
    - name: "Faculty Status"
      expr: faculty_status
    - name: "First Name"
      expr: first_name
    - name: "Graduate Faculty Status"
      expr: graduate_faculty_status
    - name: "Highest Degree Earned"
      expr: highest_degree_earned
    - name: "Highest Degree Field"
      expr: highest_degree_field
    - name: "Highest Degree Institution"
      expr: highest_degree_institution
    - name: "Highest Degree Year"
      expr: highest_degree_year
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Instructor"
      expr: COUNT(DISTINCT instructor_id)
    - name: "Total Banner Pidm"
      expr: SUM(banner_pidm)
    - name: "Average Banner Pidm"
      expr: AVG(banner_pidm)
    - name: "Total Teaching Load Fte"
      expr: SUM(teaching_load_fte)
    - name: "Average Teaching Load Fte"
      expr: AVG(teaching_load_fte)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_leave_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leave Record business metrics"
  source: "`education_ecm`.`faculty`.`leave_record`"
  dimensions:
    - name: "Actual Return Date"
      expr: actual_return_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved Start Date"
      expr: approved_start_date
    - name: "Benefits Continuation Flag"
      expr: benefits_continuation_flag
    - name: "College Code"
      expr: college_code
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Department Code"
      expr: department_code
    - name: "Disability Accommodation Flag"
      expr: disability_accommodation_flag
    - name: "Expected Return Date"
      expr: expected_return_date
    - name: "Fmla Eligible Flag"
      expr: fmla_eligible_flag
    - name: "Hr Case Reference"
      expr: hr_case_reference
    - name: "Intermittent Leave Flag"
      expr: intermittent_leave_flag
    - name: "Leave Duration Days"
      expr: leave_duration_days
    - name: "Leave Notes"
      expr: leave_notes
    - name: "Leave Status"
      expr: leave_status
    - name: "Leave Subtype"
      expr: leave_subtype
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Leave Record"
      expr: COUNT(DISTINCT leave_record_id)
    - name: "Total Fmla Hours Used"
      expr: SUM(fmla_hours_used)
    - name: "Average Fmla Hours Used"
      expr: AVG(fmla_hours_used)
    - name: "Total Leave Duration Weeks"
      expr: SUM(leave_duration_weeks)
    - name: "Average Leave Duration Weeks"
      expr: AVG(leave_duration_weeks)
    - name: "Total Partial Pay Percentage"
      expr: SUM(partial_pay_percentage)
    - name: "Average Partial Pay Percentage"
      expr: AVG(partial_pay_percentage)
    - name: "Total Reduced Schedule Fte"
      expr: SUM(reduced_schedule_fte)
    - name: "Average Reduced Schedule Fte"
      expr: AVG(reduced_schedule_fte)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_professional_development`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Professional Development business metrics"
  source: "`education_ecm`.`faculty`.`professional_development`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Accreditation Relevant Flag"
      expr: accreditation_relevant_flag
    - name: "Activity Name"
      expr: activity_name
    - name: "Activity Notes"
      expr: activity_notes
    - name: "Activity Type"
      expr: activity_type
    - name: "Annual Review Included Flag"
      expr: annual_review_included_flag
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Certification Earned"
      expr: certification_earned
    - name: "Certification Expiration Date"
      expr: certification_expiration_date
    - name: "Certification Number"
      expr: certification_number
    - name: "College Code"
      expr: college_code
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Professional Development"
      expr: COUNT(DISTINCT professional_development_id)
    - name: "Total Activity Cost"
      expr: SUM(activity_cost)
    - name: "Average Activity Cost"
      expr: AVG(activity_cost)
    - name: "Total Ceu Earned"
      expr: SUM(ceu_earned)
    - name: "Average Ceu Earned"
      expr: AVG(ceu_earned)
    - name: "Total Credit Hours"
      expr: SUM(credit_hours)
    - name: "Average Credit Hours"
      expr: AVG(credit_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_project_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project Participation business metrics"
  source: "`education_ecm`.`faculty`.`project_participation`"
  dimensions:
    - name: "Assigned Date"
      expr: assigned_date
    - name: "Billable Flag"
      expr: billable_flag
    - name: "End Date"
      expr: end_date
    - name: "Participation Status"
      expr: participation_status
    - name: "Role On Project"
      expr: role_on_project
    - name: "Start Date"
      expr: start_date
    - name: "Assigned Date Month"
      expr: DATE_TRUNC('MONTH', assigned_date)
    - name: "End Date Month"
      expr: DATE_TRUNC('MONTH', end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project Participation"
      expr: COUNT(DISTINCT project_participation_id)
    - name: "Total Effort Percentage"
      expr: SUM(effort_percentage)
    - name: "Average Effort Percentage"
      expr: AVG(effort_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_rank_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rank History business metrics"
  source: "`education_ecm`.`faculty`.`rank_history`"
  dimensions:
    - name: "Accreditation Qualified Flag"
      expr: accreditation_qualified_flag
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Approving Authority"
      expr: approving_authority
    - name: "Change Reason"
      expr: change_reason
    - name: "College Code"
      expr: college_code
    - name: "Contract Months"
      expr: contract_months
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Effective Date"
      expr: effective_date
    - name: "External Hire Flag"
      expr: external_hire_flag
    - name: "New Rank"
      expr: new_rank
    - name: "Prior Institution Name"
      expr: prior_institution_name
    - name: "Prior Rank"
      expr: prior_rank
    - name: "Promotion Eligibility Date"
      expr: promotion_eligibility_date
    - name: "Rank Change Notes"
      expr: rank_change_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rank History"
      expr: COUNT(DISTINCT rank_history_id)
    - name: "Total Cumulative Years Of Service"
      expr: SUM(cumulative_years_of_service)
    - name: "Average Cumulative Years Of Service"
      expr: AVG(cumulative_years_of_service)
    - name: "Total Fte"
      expr: SUM(fte)
    - name: "Average Fte"
      expr: AVG(fte)
    - name: "Total Salary At Change"
      expr: SUM(salary_at_change)
    - name: "Average Salary At Change"
      expr: AVG(salary_at_change)
    - name: "Total Years In Prior Rank"
      expr: SUM(years_in_prior_rank)
    - name: "Average Years In Prior Rank"
      expr: AVG(years_in_prior_rank)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_resource_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource Evaluation business metrics"
  source: "`education_ecm`.`faculty`.`resource_evaluation`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evaluation Comments"
      expr: evaluation_comments
    - name: "Evaluation Date"
      expr: evaluation_date
    - name: "Recommendation"
      expr: recommendation
    - name: "Subject Relevance Rating"
      expr: subject_relevance_rating
    - name: "Trial Evaluation Role"
      expr: trial_evaluation_role
    - name: "Usage Commitment"
      expr: usage_commitment
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Evaluation Date Month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Resource Evaluation"
      expr: COUNT(DISTINCT resource_evaluation_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_sabbatical`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sabbatical business metrics"
  source: "`education_ecm`.`faculty`.`sabbatical`"
  dimensions:
    - name: "Actual Return Date"
      expr: actual_return_date
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approved End Date"
      expr: approved_end_date
    - name: "Approved Start Date"
      expr: approved_start_date
    - name: "Benefits Continuation Flag"
      expr: benefits_continuation_flag
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Case Number"
      expr: case_number
    - name: "Dean Approval Date"
      expr: dean_approval_date
    - name: "Dean Decision"
      expr: dean_decision
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Department Chair Approval Date"
      expr: department_chair_approval_date
    - name: "Department Chair Decision"
      expr: department_chair_decision
    - name: "Expected Return Date"
      expr: expected_return_date
    - name: "Hr Case Reference"
      expr: hr_case_reference
    - name: "Leave Notes"
      expr: leave_notes
    - name: "Leave Request Submitted Date"
      expr: leave_request_submitted_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sabbatical"
      expr: COUNT(DISTINCT sabbatical_id)
    - name: "Total Pay Continuation Percentage"
      expr: SUM(pay_continuation_percentage)
    - name: "Average Pay Continuation Percentage"
      expr: AVG(pay_continuation_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_scholarly_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scholarly Activity business metrics"
  source: "`education_ecm`.`faculty`.`scholarly_activity`"
  dimensions:
    - name: "Accreditation Qualified Flag"
      expr: accreditation_qualified_flag
    - name: "Activity Date"
      expr: activity_date
    - name: "Activity Notes"
      expr: activity_notes
    - name: "Activity Subtype"
      expr: activity_subtype
    - name: "Activity Title"
      expr: activity_title
    - name: "Activity Type"
      expr: activity_type
    - name: "Author Sequence"
      expr: author_sequence
    - name: "Certification Issuing Body"
      expr: certification_issuing_body
    - name: "Certification Name"
      expr: certification_name
    - name: "Citation Count"
      expr: citation_count
    - name: "Co Authors Or Participants"
      expr: co_authors_or_participants
    - name: "College Code"
      expr: college_code
    - name: "Conference Location"
      expr: conference_location
    - name: "Conference Name"
      expr: conference_name
    - name: "Corresponding Author Flag"
      expr: corresponding_author_flag
    - name: "Currency Code"
      expr: currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Scholarly Activity"
      expr: COUNT(DISTINCT scholarly_activity_id)
    - name: "Total Activity Cost"
      expr: SUM(activity_cost)
    - name: "Average Activity Cost"
      expr: AVG(activity_cost)
    - name: "Total Credit Hours Or Ceus"
      expr: SUM(credit_hours_or_ceus)
    - name: "Average Credit Hours Or Ceus"
      expr: AVG(credit_hours_or_ceus)
    - name: "Total Impact Factor"
      expr: SUM(impact_factor)
    - name: "Average Impact Factor"
      expr: AVG(impact_factor)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_service_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Assignment business metrics"
  source: "`education_ecm`.`faculty`.`service_assignment`"
  dimensions:
    - name: "Accreditation Service Flag"
      expr: accreditation_service_flag
    - name: "Appointment Authority"
      expr: appointment_authority
    - name: "Appointment Date"
      expr: appointment_date
    - name: "Appointment End Date"
      expr: appointment_end_date
    - name: "Appointment Start Date"
      expr: appointment_start_date
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Committee Name"
      expr: committee_name
    - name: "Compensation Currency Code"
      expr: compensation_currency_code
    - name: "Elected Position Flag"
      expr: elected_position_flag
    - name: "Irb Service Flag"
      expr: irb_service_flag
    - name: "Leadership Role Flag"
      expr: leadership_role_flag
    - name: "Meeting Frequency"
      expr: meeting_frequency
    - name: "National Prominence Flag"
      expr: national_prominence_flag
    - name: "Organization Name"
      expr: organization_name
    - name: "Organization Type"
      expr: organization_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Assignment"
      expr: COUNT(DISTINCT service_assignment_id)
    - name: "Total Compensation Amount"
      expr: SUM(compensation_amount)
    - name: "Average Compensation Amount"
      expr: AVG(compensation_amount)
    - name: "Total Course Release Units"
      expr: SUM(course_release_units)
    - name: "Average Course Release Units"
      expr: AVG(course_release_units)
    - name: "Total Time Commitment Hours Per Year"
      expr: SUM(time_commitment_hours_per_year)
    - name: "Average Time Commitment Hours Per Year"
      expr: AVG(time_commitment_hours_per_year)
    - name: "Total Workload Credit Percentage"
      expr: SUM(workload_credit_percentage)
    - name: "Average Workload Credit Percentage"
      expr: AVG(workload_credit_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_teaching_load`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Teaching Load business metrics"
  source: "`education_ecm`.`faculty`.`teaching_load`"
  dimensions:
    - name: "Academic Term Code"
      expr: academic_term_code
    - name: "Accreditation Qualified Flag"
      expr: accreditation_qualified_flag
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Collective Bargaining Compliant Flag"
      expr: collective_bargaining_compliant_flag
    - name: "College Code"
      expr: college_code
    - name: "Contract Months"
      expr: contract_months
    - name: "Dean Approval Date"
      expr: dean_approval_date
    - name: "Dean Approval Flag"
      expr: dean_approval_flag
    - name: "Department Chair Approval Date"
      expr: department_chair_approval_date
    - name: "Department Chair Approval Flag"
      expr: department_chair_approval_flag
    - name: "Department Code"
      expr: department_code
    - name: "Faculty Rank"
      expr: faculty_rank
    - name: "Graduate Course Flag"
      expr: graduate_course_flag
    - name: "Hybrid Course Flag"
      expr: hybrid_course_flag
    - name: "Load Assignment Notes"
      expr: load_assignment_notes
    - name: "Load Balance Status"
      expr: load_balance_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Teaching Load"
      expr: COUNT(DISTINCT teaching_load_id)
    - name: "Total Actual Credit Hours Taught"
      expr: SUM(actual_credit_hours_taught)
    - name: "Average Actual Credit Hours Taught"
      expr: AVG(actual_credit_hours_taught)
    - name: "Total Adjusted Contracted Hours"
      expr: SUM(adjusted_contracted_hours)
    - name: "Average Adjusted Contracted Hours"
      expr: AVG(adjusted_contracted_hours)
    - name: "Total Administrative Release Hours"
      expr: SUM(administrative_release_hours)
    - name: "Average Administrative Release Hours"
      expr: AVG(administrative_release_hours)
    - name: "Total Contracted Credit Hours"
      expr: SUM(contracted_credit_hours)
    - name: "Average Contracted Credit Hours"
      expr: AVG(contracted_credit_hours)
    - name: "Total Faculty To Student Ratio"
      expr: SUM(faculty_to_student_ratio)
    - name: "Average Faculty To Student Ratio"
      expr: AVG(faculty_to_student_ratio)
    - name: "Total Fte"
      expr: SUM(fte)
    - name: "Average Fte"
      expr: AVG(fte)
    - name: "Total Load Variance Hours"
      expr: SUM(load_variance_hours)
    - name: "Average Load Variance Hours"
      expr: AVG(load_variance_hours)
    - name: "Total Other Release Hours"
      expr: SUM(other_release_hours)
    - name: "Average Other Release Hours"
      expr: AVG(other_release_hours)
    - name: "Total Overload Credit Hours"
      expr: SUM(overload_credit_hours)
    - name: "Average Overload Credit Hours"
      expr: AVG(overload_credit_hours)
    - name: "Total Research Release Hours"
      expr: SUM(research_release_hours)
    - name: "Average Research Release Hours"
      expr: AVG(research_release_hours)
    - name: "Total Sabbatical Release Hours"
      expr: SUM(sabbatical_release_hours)
    - name: "Average Sabbatical Release Hours"
      expr: AVG(sabbatical_release_hours)
    - name: "Total Student Credit Hours Generated"
      expr: SUM(student_credit_hours_generated)
    - name: "Average Student Credit Hours Generated"
      expr: AVG(student_credit_hours_generated)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`faculty_tenure_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenure Case business metrics"
  source: "`education_ecm`.`faculty`.`tenure_case`"
  dimensions:
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Board Approval Date"
      expr: board_approval_date
    - name: "Board Approval Status"
      expr: board_approval_status
    - name: "Case Initiation Date"
      expr: case_initiation_date
    - name: "Case Number"
      expr: case_number
    - name: "Case Status"
      expr: case_status
    - name: "College Committee Recommendation"
      expr: college_committee_recommendation
    - name: "College Committee Vote Date"
      expr: college_committee_vote_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Rank"
      expr: current_rank
    - name: "Dean Recommendation"
      expr: dean_recommendation
    - name: "Dean Recommendation Date"
      expr: dean_recommendation_date
    - name: "Department Chair Recommendation"
      expr: department_chair_recommendation
    - name: "Department Chair Recommendation Date"
      expr: department_chair_recommendation_date
    - name: "Department Committee Vote Abstain"
      expr: department_committee_vote_abstain
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tenure Case"
      expr: COUNT(DISTINCT tenure_case_id)
    - name: "Total Tenure Clock Years Elapsed"
      expr: SUM(tenure_clock_years_elapsed)
    - name: "Average Tenure Clock Years Elapsed"
      expr: AVG(tenure_clock_years_elapsed)
$$;