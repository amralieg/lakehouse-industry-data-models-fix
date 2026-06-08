-- Metric views for domain: instruction | Business: Education | Version: 1 | Generated on: 2026-05-06 12:27:29

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_attendance_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Attendance Record business metrics"
  source: "`education_ecm`.`instruction`.`attendance_record`"
  dimensions:
    - name: "Academic Activity Type"
      expr: academic_activity_type
    - name: "Attendance Date"
      expr: attendance_date
    - name: "Attendance Policy Violation"
      expr: attendance_policy_violation
    - name: "Attendance Status"
      expr: attendance_status
    - name: "Comments"
      expr: comments
    - name: "Consecutive Absences Count"
      expr: consecutive_absences_count
    - name: "Early Alert Timestamp"
      expr: early_alert_timestamp
    - name: "Early Alert Triggered"
      expr: early_alert_triggered
    - name: "Excuse Documentation Provided"
      expr: excuse_documentation_provided
    - name: "Excuse Reason"
      expr: excuse_reason
    - name: "Instructor Notes"
      expr: instructor_notes
    - name: "Ip Address"
      expr: ip_address
    - name: "Last Date Of Attendance Flag"
      expr: last_date_of_attendance_flag
    - name: "Lms Activity Indicator"
      expr: lms_activity_indicator
    - name: "Lms Activity Timestamp"
      expr: lms_activity_timestamp
    - name: "Minutes Absent"
      expr: minutes_absent
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Attendance Record"
      expr: COUNT(DISTINCT attendance_record_id)
    - name: "Total Attendance Percentage To Date"
      expr: SUM(attendance_percentage_to_date)
    - name: "Average Attendance Percentage To Date"
      expr: AVG(attendance_percentage_to_date)
    - name: "Total Geolocation Latitude"
      expr: SUM(geolocation_latitude)
    - name: "Average Geolocation Latitude"
      expr: AVG(geolocation_latitude)
    - name: "Total Geolocation Longitude"
      expr: SUM(geolocation_longitude)
    - name: "Average Geolocation Longitude"
      expr: AVG(geolocation_longitude)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_course_section`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Course Section business metrics"
  source: "`education_ecm`.`instruction`.`course_section`"
  dimensions:
    - name: "Campus Code"
      expr: campus_code
    - name: "Cip Code"
      expr: cip_code
    - name: "College Code"
      expr: college_code
    - name: "Course Level"
      expr: course_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crn"
      expr: crn
    - name: "Cross Listed Sections"
      expr: cross_listed_sections
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "End Date"
      expr: end_date
    - name: "End Time"
      expr: end_time
    - name: "Enrollment Actual"
      expr: enrollment_actual
    - name: "Enrollment Capacity"
      expr: enrollment_capacity
    - name: "Grade Mode"
      expr: grade_mode
    - name: "Instructional Method"
      expr: instructional_method
    - name: "Linked Sections"
      expr: linked_sections
    - name: "Meeting Days"
      expr: meeting_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Course Section"
      expr: COUNT(DISTINCT course_section_id)
    - name: "Total Contact Hours"
      expr: SUM(contact_hours)
    - name: "Average Contact Hours"
      expr: AVG(contact_hours)
    - name: "Total Credit Hours"
      expr: SUM(credit_hours)
    - name: "Average Credit Hours"
      expr: AVG(credit_hours)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Tuition Amount"
      expr: SUM(tuition_amount)
    - name: "Average Tuition Amount"
      expr: AVG(tuition_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_faculty_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty Assignment business metrics"
  source: "`education_ecm`.`instruction`.`faculty_assignment`"
  dimensions:
    - name: "Appointment Type"
      expr: appointment_type
    - name: "Assignment Approval Date"
      expr: assignment_approval_date
    - name: "Assignment End Date"
      expr: assignment_end_date
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Role"
      expr: assignment_role
    - name: "Assignment Start Date"
      expr: assignment_start_date
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Contract Number"
      expr: contract_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Grant Account Code"
      expr: grant_account_code
    - name: "Ipeds Reporting Category"
      expr: ipeds_reporting_category
    - name: "Is Active"
      expr: is_active
    - name: "Is Grading Authority"
      expr: is_grading_authority
    - name: "Is Primary Instructor"
      expr: is_primary_instructor
    - name: "Is Team Taught"
      expr: is_team_taught
    - name: "Lms Instructor Role"
      expr: lms_instructor_role
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Faculty Assignment"
      expr: COUNT(DISTINCT faculty_assignment_id)
    - name: "Total Compensation Amount"
      expr: SUM(compensation_amount)
    - name: "Average Compensation Amount"
      expr: AVG(compensation_amount)
    - name: "Total Fte Contribution"
      expr: SUM(fte_contribution)
    - name: "Average Fte Contribution"
      expr: AVG(fte_contribution)
    - name: "Total Grant Funded Percentage"
      expr: SUM(grant_funded_percentage)
    - name: "Average Grant Funded Percentage"
      expr: AVG(grant_funded_percentage)
    - name: "Total Office Hours Required"
      expr: SUM(office_hours_required)
    - name: "Average Office Hours Required"
      expr: AVG(office_hours_required)
    - name: "Total Percent Responsibility"
      expr: SUM(percent_responsibility)
    - name: "Average Percent Responsibility"
      expr: AVG(percent_responsibility)
    - name: "Total Workload Credit Hours"
      expr: SUM(workload_credit_hours)
    - name: "Average Workload Credit Hours"
      expr: AVG(workload_credit_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_faculty_training_requirement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Faculty Training Requirement business metrics"
  source: "`education_ecm`.`instruction`.`faculty_training_requirement`"
  dimensions:
    - name: "Assignment Date"
      expr: assignment_date
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Attempt Count"
      expr: attempt_count
    - name: "Certificate Issued Date"
      expr: certificate_issued_date
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Status"
      expr: completion_status
    - name: "Due Date"
      expr: due_date
    - name: "Last Reminder Date"
      expr: last_reminder_date
    - name: "Notes"
      expr: notes
    - name: "Notification Sent Date"
      expr: notification_sent_date
    - name: "Recertification Due Date"
      expr: recertification_due_date
    - name: "Reminder Count"
      expr: reminder_count
    - name: "Waiver Approval Date"
      expr: waiver_approval_date
    - name: "Waiver Flag"
      expr: waiver_flag
    - name: "Waiver Reason"
      expr: waiver_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Faculty Training Requirement"
      expr: COUNT(DISTINCT faculty_training_requirement_id)
    - name: "Total Score Achieved"
      expr: SUM(score_achieved)
    - name: "Average Score Achieved"
      expr: AVG(score_achieved)
    - name: "Total Waiver Approved By"
      expr: SUM(waiver_approved_by)
    - name: "Average Waiver Approved By"
      expr: AVG(waiver_approved_by)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_final_grade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Final Grade business metrics"
  source: "`education_ecm`.`instruction`.`final_grade`"
  dimensions:
    - name: "Academic Standing Impact"
      expr: academic_standing_impact
    - name: "Course Number"
      expr: course_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crn"
      expr: crn
    - name: "Degree Applicable Flag"
      expr: degree_applicable_flag
    - name: "Ferpa Protected Flag"
      expr: ferpa_protected_flag
    - name: "Grade Change Date"
      expr: grade_change_date
    - name: "Grade Change Flag"
      expr: grade_change_flag
    - name: "Grade Change Reason Code"
      expr: grade_change_reason_code
    - name: "Grade Mode"
      expr: grade_mode
    - name: "Grade Posted Date"
      expr: grade_posted_date
    - name: "Grade Posting Status"
      expr: grade_posting_status
    - name: "Grade Source System"
      expr: grade_source_system
    - name: "Grade Submission Method"
      expr: grade_submission_method
    - name: "Grade Verified Date"
      expr: grade_verified_date
    - name: "Incomplete Deadline Date"
      expr: incomplete_deadline_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Final Grade"
      expr: COUNT(DISTINCT final_grade_id)
    - name: "Total Credit Hours Attempted"
      expr: SUM(credit_hours_attempted)
    - name: "Average Credit Hours Attempted"
      expr: AVG(credit_hours_attempted)
    - name: "Total Credit Hours Earned"
      expr: SUM(credit_hours_earned)
    - name: "Average Credit Hours Earned"
      expr: AVG(credit_hours_earned)
    - name: "Total Grade Point Value"
      expr: SUM(grade_point_value)
    - name: "Average Grade Point Value"
      expr: AVG(grade_point_value)
    - name: "Total Numeric Grade"
      expr: SUM(numeric_grade)
    - name: "Average Numeric Grade"
      expr: AVG(numeric_grade)
    - name: "Total Quality Points"
      expr: SUM(quality_points)
    - name: "Average Quality Points"
      expr: AVG(quality_points)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_grade_appeal_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grade Appeal Case business metrics"
  source: "`education_ecm`.`instruction`.`grade_appeal_case`"
  dimensions:
    - name: "Appeal Case Number"
      expr: appeal_case_number
    - name: "Appeal Fee Paid"
      expr: appeal_fee_paid
    - name: "Appeal Fee Waived"
      expr: appeal_fee_waived
    - name: "Appeal Level"
      expr: appeal_level
    - name: "Appeal Reason"
      expr: appeal_reason
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Appeal Type"
      expr: appeal_type
    - name: "Closed Timestamp"
      expr: closed_timestamp
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Outcome"
      expr: decision_outcome
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Department Recommendation"
      expr: department_recommendation
    - name: "Escalation Count"
      expr: escalation_count
    - name: "Final Grade"
      expr: final_grade
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grade Appeal Case"
      expr: COUNT(DISTINCT grade_appeal_case_id)
    - name: "Total Appeal Fee Amount"
      expr: SUM(appeal_fee_amount)
    - name: "Average Appeal Fee Amount"
      expr: AVG(appeal_fee_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_grade_change_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grade Change Log business metrics"
  source: "`education_ecm`.`instruction`.`grade_change_log`"
  dimensions:
    - name: "Academic Standing Impact"
      expr: academic_standing_impact
    - name: "Accreditation Reportable"
      expr: accreditation_reportable
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approving Authority Role"
      expr: approving_authority_role
    - name: "Banner Transaction Ref"
      expr: banner_transaction_ref
    - name: "Change Justification"
      expr: change_justification
    - name: "Change Reason Code"
      expr: change_reason_code
    - name: "Change Status"
      expr: change_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Degree Audit Impact"
      expr: degree_audit_impact
    - name: "Effective Date"
      expr: effective_date
    - name: "Gpa Recalculation Required"
      expr: gpa_recalculation_required
    - name: "Grade Type"
      expr: grade_type
    - name: "Lms Gradebook Sync Flag"
      expr: lms_gradebook_sync_flag
    - name: "Lms Sync Timestamp"
      expr: lms_sync_timestamp
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grade Change Log"
      expr: COUNT(DISTINCT grade_change_log_id)
    - name: "Total Original Grade Points"
      expr: SUM(original_grade_points)
    - name: "Average Original Grade Points"
      expr: AVG(original_grade_points)
    - name: "Total Revised Grade Points"
      expr: SUM(revised_grade_points)
    - name: "Average Revised Grade Points"
      expr: AVG(revised_grade_points)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_grade_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grade Entry business metrics"
  source: "`education_ecm`.`instruction`.`grade_entry`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Attempt Number"
      expr: attempt_number
    - name: "Canvas Grade Object Ref"
      expr: canvas_grade_object_ref
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "Extra Credit Flag"
      expr: extra_credit_flag
    - name: "Grade Appeal Status"
      expr: grade_appeal_status
    - name: "Grade Entry Source"
      expr: grade_entry_source
    - name: "Grade Letter"
      expr: grade_letter
    - name: "Grade Override Flag"
      expr: grade_override_flag
    - name: "Graded Timestamp"
      expr: graded_timestamp
    - name: "Grader Comments"
      expr: grader_comments
    - name: "Grading Status"
      expr: grading_status
    - name: "Is Excused"
      expr: is_excused
    - name: "Is Final Attempt"
      expr: is_final_attempt
    - name: "Is Late"
      expr: is_late
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grade Entry"
      expr: COUNT(DISTINCT grade_entry_id)
    - name: "Total Grade Percentage"
      expr: SUM(grade_percentage)
    - name: "Average Grade Percentage"
      expr: AVG(grade_percentage)
    - name: "Total Late Penalty Applied"
      expr: SUM(late_penalty_applied)
    - name: "Average Late Penalty Applied"
      expr: AVG(late_penalty_applied)
    - name: "Total Max Score"
      expr: SUM(max_score)
    - name: "Average Max Score"
      expr: AVG(max_score)
    - name: "Total Score"
      expr: SUM(score)
    - name: "Average Score"
      expr: AVG(score)
    - name: "Total Weight In Final Grade"
      expr: SUM(weight_in_final_grade)
    - name: "Average Weight In Final Grade"
      expr: AVG(weight_in_final_grade)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_incomplete_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incomplete Contract business metrics"
  source: "`education_ecm`.`instruction`.`incomplete_contract`"
  dimensions:
    - name: "Advisor Notification Date"
      expr: advisor_notification_date
    - name: "Advisor Notified Flag"
      expr: advisor_notified_flag
    - name: "Completion Deadline"
      expr: completion_deadline
    - name: "Contract Notes"
      expr: contract_notes
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Signed Date"
      expr: contract_signed_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Grade"
      expr: default_grade
    - name: "Department Code"
      expr: department_code
    - name: "Extended Deadline"
      expr: extended_deadline
    - name: "Extension Approval Date"
      expr: extension_approval_date
    - name: "Extension Approved Flag"
      expr: extension_approved_flag
    - name: "Extension Reason"
      expr: extension_reason
    - name: "Extension Request Date"
      expr: extension_request_date
    - name: "Extension Requested Flag"
      expr: extension_requested_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Incomplete Contract"
      expr: COUNT(DISTINCT incomplete_contract_id)
    - name: "Total Credit Hours"
      expr: SUM(credit_hours)
    - name: "Average Credit Hours"
      expr: AVG(credit_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_instruction_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instruction Assignment business metrics"
  source: "`education_ecm`.`instruction`.`instruction_assignment`"
  dimensions:
    - name: "Allowed Attempts"
      expr: allowed_attempts
    - name: "Allowed File Extensions"
      expr: allowed_file_extensions
    - name: "Assignment Description"
      expr: assignment_description
    - name: "Assignment Name"
      expr: assignment_name
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Available From Date"
      expr: available_from_date
    - name: "Canvas Assignment Ref"
      expr: canvas_assignment_ref
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Date"
      expr: due_date
    - name: "External Tool Url"
      expr: external_tool_url
    - name: "Grade Group Students Individually"
      expr: grade_group_students_individually
    - name: "Grader Count"
      expr: grader_count
    - name: "Grading Type"
      expr: grading_type
    - name: "Is Anonymous Grading"
      expr: is_anonymous_grading
    - name: "Is Anonymous Peer Review"
      expr: is_anonymous_peer_review
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Instruction Assignment"
      expr: COUNT(DISTINCT instruction_assignment_id)
    - name: "Total Group Category Ref"
      expr: SUM(group_category_ref)
    - name: "Average Group Category Ref"
      expr: AVG(group_category_ref)
    - name: "Total Group Ref"
      expr: SUM(group_ref)
    - name: "Average Group Ref"
      expr: AVG(group_ref)
    - name: "Total Points Possible"
      expr: SUM(points_possible)
    - name: "Average Points Possible"
      expr: AVG(points_possible)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_instruction_early_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instruction Early Alert business metrics"
  source: "`education_ecm`.`instruction`.`instruction_early_alert`"
  dimensions:
    - name: "Absences Count"
      expr: absences_count
    - name: "Alert Date"
      expr: alert_date
    - name: "Alert Description"
      expr: alert_description
    - name: "Alert Timestamp"
      expr: alert_timestamp
    - name: "Alert Type"
      expr: alert_type
    - name: "Attendance Concern Flag"
      expr: attendance_concern_flag
    - name: "Banner Alert Ref"
      expr: banner_alert_ref
    - name: "Behavioral Concern Flag"
      expr: behavioral_concern_flag
    - name: "Contact Method"
      expr: contact_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Grade"
      expr: current_grade
    - name: "Engagement Concern Flag"
      expr: engagement_concern_flag
    - name: "Final Course Grade"
      expr: final_course_grade
    - name: "First Contact Date"
      expr: first_contact_date
    - name: "Grade Concern Flag"
      expr: grade_concern_flag
    - name: "Intervention Actions Taken"
      expr: intervention_actions_taken
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Instruction Early Alert"
      expr: COUNT(DISTINCT instruction_early_alert_id)
    - name: "Total Current Grade Percentage"
      expr: SUM(current_grade_percentage)
    - name: "Average Current Grade Percentage"
      expr: AVG(current_grade_percentage)
    - name: "Total Dfw Risk Score"
      expr: SUM(dfw_risk_score)
    - name: "Average Dfw Risk Score"
      expr: AVG(dfw_risk_score)
    - name: "Total Lms Activity Score"
      expr: SUM(lms_activity_score)
    - name: "Average Lms Activity Score"
      expr: AVG(lms_activity_score)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_instruction_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Instruction Submission business metrics"
  source: "`education_ecm`.`instruction`.`instruction_submission`"
  dimensions:
    - name: "Anonymous Ref"
      expr: anonymous_ref
    - name: "Attempt Number"
      expr: attempt_number
    - name: "Body"
      expr: body
    - name: "Cached Due Date"
      expr: cached_due_date
    - name: "Canvas Submission Ref"
      expr: canvas_submission_ref
    - name: "Comments Count"
      expr: comments_count
    - name: "Entered Grade"
      expr: entered_grade
    - name: "Extra Attempts"
      expr: extra_attempts
    - name: "Grade"
      expr: grade
    - name: "Graded At"
      expr: graded_at
    - name: "History Count"
      expr: history_count
    - name: "Is Anonymous Grading"
      expr: is_anonymous_grading
    - name: "Is Excused"
      expr: is_excused
    - name: "Is Late"
      expr: is_late
    - name: "Is Missing"
      expr: is_missing
    - name: "Last Activity At"
      expr: last_activity_at
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Instruction Submission"
      expr: COUNT(DISTINCT instruction_submission_id)
    - name: "Total Entered Score"
      expr: SUM(entered_score)
    - name: "Average Entered Score"
      expr: AVG(entered_score)
    - name: "Total Grading Period Ref"
      expr: SUM(grading_period_ref)
    - name: "Average Grading Period Ref"
      expr: AVG(grading_period_ref)
    - name: "Total Group Ref"
      expr: SUM(group_ref)
    - name: "Average Group Ref"
      expr: AVG(group_ref)
    - name: "Total Originality Score"
      expr: SUM(originality_score)
    - name: "Average Originality Score"
      expr: AVG(originality_score)
    - name: "Total Points Deducted"
      expr: SUM(points_deducted)
    - name: "Average Points Deducted"
      expr: AVG(points_deducted)
    - name: "Total Rubric Assessment Ref"
      expr: SUM(rubric_assessment_ref)
    - name: "Average Rubric Assessment Ref"
      expr: AVG(rubric_assessment_ref)
    - name: "Total Score"
      expr: SUM(score)
    - name: "Average Score"
      expr: AVG(score)
    - name: "Total Seconds Late"
      expr: SUM(seconds_late)
    - name: "Average Seconds Late"
      expr: AVG(seconds_late)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_lms_course_shell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lms Course Shell business metrics"
  source: "`education_ecm`.`instruction`.`lms_course_shell`"
  dimensions:
    - name: "Allow Student Discussion Editing"
      expr: allow_student_discussion_editing
    - name: "Allow Student Discussion Topics"
      expr: allow_student_discussion_topics
    - name: "Allow Student Forum Attachments"
      expr: allow_student_forum_attachments
    - name: "Apply Assignment Group Weights"
      expr: apply_assignment_group_weights
    - name: "Concluded Timestamp"
      expr: concluded_timestamp
    - name: "Course Code"
      expr: course_code
    - name: "Course Format"
      expr: course_format
    - name: "Course Name"
      expr: course_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default View"
      expr: default_view
    - name: "End Date"
      expr: end_date
    - name: "Hide Final Grades"
      expr: hide_final_grades
    - name: "Homeroom Course"
      expr: homeroom_course
    - name: "Integration Ref"
      expr: integration_ref
    - name: "Is Blueprint"
      expr: is_blueprint
    - name: "Is Public"
      expr: is_public
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lms Course Shell"
      expr: COUNT(DISTINCT lms_course_shell_id)
    - name: "Total Grading Standard Ref"
      expr: SUM(grading_standard_ref)
    - name: "Average Grading Standard Ref"
      expr: AVG(grading_standard_ref)
    - name: "Total Lms Account Ref"
      expr: SUM(lms_account_ref)
    - name: "Average Lms Account Ref"
      expr: AVG(lms_account_ref)
    - name: "Total Lms Root Account Ref"
      expr: SUM(lms_root_account_ref)
    - name: "Average Lms Root Account Ref"
      expr: AVG(lms_root_account_ref)
    - name: "Total Sis Import Ref"
      expr: SUM(sis_import_ref)
    - name: "Average Sis Import Ref"
      expr: AVG(sis_import_ref)
    - name: "Total Storage Quota Mb"
      expr: SUM(storage_quota_mb)
    - name: "Average Storage Quota Mb"
      expr: AVG(storage_quota_mb)
    - name: "Total Storage Used Mb"
      expr: SUM(storage_used_mb)
    - name: "Average Storage Used Mb"
      expr: AVG(storage_used_mb)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_rubric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rubric business metrics"
  source: "`education_ecm`.`instruction`.`rubric`"
  dimensions:
    - name: "Archived At"
      expr: archived_at
    - name: "Assessment Count"
      expr: assessment_count
    - name: "Canvas Rubric Ref"
      expr: canvas_rubric_ref
    - name: "Context Code"
      expr: context_code
    - name: "Context Type"
      expr: context_type
    - name: "Criteria Count"
      expr: criteria_count
    - name: "Free Form Criterion Comments"
      expr: free_form_criterion_comments
    - name: "Hide Points"
      expr: hide_points
    - name: "Hide Score Total"
      expr: hide_score_total
    - name: "Public"
      expr: public
    - name: "Published At"
      expr: published_at
    - name: "Read Only"
      expr: read_only
    - name: "Reusable"
      expr: reusable
    - name: "Rubric Description"
      expr: rubric_description
    - name: "Rubric Status"
      expr: rubric_status
    - name: "Rubric Type"
      expr: rubric_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rubric"
      expr: COUNT(DISTINCT rubric_id)
    - name: "Total Alignment Outcome Group Ref"
      expr: SUM(alignment_outcome_group_ref)
    - name: "Average Alignment Outcome Group Ref"
      expr: AVG(alignment_outcome_group_ref)
    - name: "Total Lms Account Ref"
      expr: SUM(lms_account_ref)
    - name: "Average Lms Account Ref"
      expr: AVG(lms_account_ref)
    - name: "Total Total Points Possible"
      expr: SUM(total_points_possible)
    - name: "Average Total Points Possible"
      expr: AVG(total_points_possible)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_scorm_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scorm Package business metrics"
  source: "`education_ecm`.`instruction`.`scorm_package`"
  dimensions:
    - name: "Accessibility Features"
      expr: accessibility_features
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Cip Code"
      expr: cip_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Estimated Duration Minutes"
      expr: estimated_duration_minutes
    - name: "Is Mobile Compatible"
      expr: is_mobile_compatible
    - name: "Is Oer"
      expr: is_oer
    - name: "Language Code"
      expr: language_code
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Launch Url"
      expr: launch_url
    - name: "Learning Objectives"
      expr: learning_objectives
    - name: "License Type"
      expr: license_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Package Description"
      expr: package_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Scorm Package"
      expr: COUNT(DISTINCT scorm_package_id)
    - name: "Total Average Completion Rate Percent"
      expr: SUM(average_completion_rate_percent)
    - name: "Average Average Completion Rate Percent"
      expr: AVG(average_completion_rate_percent)
    - name: "Total Average Mastery Score"
      expr: SUM(average_mastery_score)
    - name: "Average Average Mastery Score"
      expr: AVG(average_mastery_score)
    - name: "Total Completion Threshold Percent"
      expr: SUM(completion_threshold_percent)
    - name: "Average Completion Threshold Percent"
      expr: AVG(completion_threshold_percent)
    - name: "Total Cost Per Student"
      expr: SUM(cost_per_student)
    - name: "Average Cost Per Student"
      expr: AVG(cost_per_student)
    - name: "Total File Size Mb"
      expr: SUM(file_size_mb)
    - name: "Average File Size Mb"
      expr: AVG(file_size_mb)
    - name: "Total Mastery Score Threshold"
      expr: SUM(mastery_score_threshold)
    - name: "Average Mastery Score Threshold"
      expr: AVG(mastery_score_threshold)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_section_meeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Section Meeting business metrics"
  source: "`education_ecm`.`instruction`.`section_meeting`"
  dimensions:
    - name: "Accessibility Features"
      expr: accessibility_features
    - name: "Begin Time"
      expr: begin_time
    - name: "Building Code"
      expr: building_code
    - name: "Campus Code"
      expr: campus_code
    - name: "Conflict Flag"
      expr: conflict_flag
    - name: "Created Date"
      expr: created_date
    - name: "Crn"
      expr: crn
    - name: "End Date"
      expr: end_date
    - name: "End Time"
      expr: end_time
    - name: "Friday Flag"
      expr: friday_flag
    - name: "Meeting Number"
      expr: meeting_number
    - name: "Meeting Schedule Type"
      expr: meeting_schedule_type
    - name: "Meeting Status"
      expr: meeting_status
    - name: "Meeting Type"
      expr: meeting_type
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Date"
      expr: modified_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Section Meeting"
      expr: COUNT(DISTINCT section_meeting_id)
    - name: "Total Contact Hours Per Week"
      expr: SUM(contact_hours_per_week)
    - name: "Average Contact Hours Per Week"
      expr: AVG(contact_hours_per_week)
    - name: "Total Credit Hours"
      expr: SUM(credit_hours)
    - name: "Average Credit Hours"
      expr: AVG(credit_hours)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`instruction_slo_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Slo Assessment business metrics"
  source: "`education_ecm`.`instruction`.`slo_assessment`"
  dimensions:
    - name: "Accreditation Body"
      expr: accreditation_body
    - name: "Assessment Cycle"
      expr: assessment_cycle
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Method"
      expr: assessment_method
    - name: "Assessment Notes"
      expr: assessment_notes
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Cohort Flag"
      expr: cohort_flag
    - name: "Cohort Size"
      expr: cohort_size
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Evidence Artifact Reference"
      expr: evidence_artifact_reference
    - name: "Improvement Action Description"
      expr: improvement_action_description
    - name: "Improvement Action Required"
      expr: improvement_action_required
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Performance Level"
      expr: performance_level
    - name: "Reviewed Timestamp"
      expr: reviewed_timestamp
    - name: "Submitted Timestamp"
      expr: submitted_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Slo Assessment"
      expr: COUNT(DISTINCT slo_assessment_id)
    - name: "Total Proficiency Threshold"
      expr: SUM(proficiency_threshold)
    - name: "Average Proficiency Threshold"
      expr: AVG(proficiency_threshold)
    - name: "Total Score Maximum"
      expr: SUM(score_maximum)
    - name: "Average Score Maximum"
      expr: AVG(score_maximum)
    - name: "Total Score Numeric"
      expr: SUM(score_numeric)
    - name: "Average Score Numeric"
      expr: AVG(score_numeric)
$$;