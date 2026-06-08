-- Metric views for domain: athletics | Business: Education | Version: 1 | Generated on: 2026-05-06 12:27:04

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_athletic_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Athletic Award business metrics"
  source: "`education_ecm`.`athletics`.`athletic_award`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Award Certificate Issued Flag"
      expr: award_certificate_issued_flag
    - name: "Award Date"
      expr: award_date
    - name: "Award Description"
      expr: award_description
    - name: "Award Level"
      expr: award_level
    - name: "Award Name"
      expr: award_name
    - name: "Award Notes"
      expr: award_notes
    - name: "Award Status"
      expr: award_status
    - name: "Award Trophy Issued Flag"
      expr: award_trophy_issued_flag
    - name: "Award Type"
      expr: award_type
    - name: "Awarding Body"
      expr: awarding_body
    - name: "Benefit Description"
      expr: benefit_description
    - name: "Compliance Report Date"
      expr: compliance_report_date
    - name: "Compliance Reportable Flag"
      expr: compliance_reportable_flag
    - name: "Conference Affiliation"
      expr: conference_affiliation
    - name: "Current Record Flag"
      expr: current_record_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Athletic Award"
      expr: COUNT(DISTINCT athletic_award_id)
    - name: "Total Scholarship Value Amount"
      expr: SUM(scholarship_value_amount)
    - name: "Average Scholarship Value Amount"
      expr: AVG(scholarship_value_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_athletic_eligibility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Athletic Eligibility business metrics"
  source: "`education_ecm`.`athletics`.`athletic_eligibility`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Amateurism Certification Status"
      expr: amateurism_certification_status
    - name: "Athletic Scholarship Flag"
      expr: athletic_scholarship_flag
    - name: "Certification Timestamp"
      expr: certification_timestamp
    - name: "Compliance Hold Flag"
      expr: compliance_hold_flag
    - name: "Compliance Hold Reason"
      expr: compliance_hold_reason
    - name: "Division Level"
      expr: division_level
    - name: "Eligibility Certification Date"
      expr: eligibility_certification_date
    - name: "Eligibility Notes"
      expr: eligibility_notes
    - name: "Eligibility Status"
      expr: eligibility_status
    - name: "Eligibility Year"
      expr: eligibility_year
    - name: "Full Time Enrollment Verified"
      expr: full_time_enrollment_verified
    - name: "Gpa Threshold Met"
      expr: gpa_threshold_met
    - name: "Initial Eligibility Certified Date"
      expr: initial_eligibility_certified_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Medical Hardship Season"
      expr: medical_hardship_season
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Athletic Eligibility"
      expr: COUNT(DISTINCT athletic_eligibility_id)
    - name: "Total Credit Hours Enrolled"
      expr: SUM(credit_hours_enrolled)
    - name: "Average Credit Hours Enrolled"
      expr: AVG(credit_hours_enrolled)
    - name: "Total Cumulative Gpa"
      expr: SUM(cumulative_gpa)
    - name: "Average Cumulative Gpa"
      expr: AVG(cumulative_gpa)
    - name: "Total Degree Applicable Credits Earned"
      expr: SUM(degree_applicable_credits_earned)
    - name: "Average Degree Applicable Credits Earned"
      expr: AVG(degree_applicable_credits_earned)
    - name: "Total Progress Toward Degree Percentage"
      expr: SUM(progress_toward_degree_percentage)
    - name: "Average Progress Toward Degree Percentage"
      expr: AVG(progress_toward_degree_percentage)
    - name: "Total Term Gpa"
      expr: SUM(term_gpa)
    - name: "Average Term Gpa"
      expr: AVG(term_gpa)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_athletic_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Athletic Facility business metrics"
  source: "`education_ecm`.`athletics`.`athletic_facility`"
  dimensions:
    - name: "Ada Accessible Seating Count"
      expr: ada_accessible_seating_count
    - name: "Building Square Footage"
      expr: building_square_footage
    - name: "Climate Controlled Flag"
      expr: climate_controlled_flag
    - name: "Concession Stands Count"
      expr: concession_stands_count
    - name: "Conference Affiliation"
      expr: conference_affiliation
    - name: "Division Level"
      expr: division_level
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Status"
      expr: facility_status
    - name: "Facility Type"
      expr: facility_type
    - name: "Home Venue Flag"
      expr: home_venue_flag
    - name: "Last Renovation Year"
      expr: last_renovation_year
    - name: "Lighting Lux Level"
      expr: lighting_lux_level
    - name: "Lighting Type"
      expr: lighting_type
    - name: "Locker Room Count"
      expr: locker_room_count
    - name: "Naia Certification Status"
      expr: naia_certification_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Athletic Facility"
      expr: COUNT(DISTINCT athletic_facility_id)
    - name: "Total Surface Dimensions Length Ft"
      expr: SUM(surface_dimensions_length_ft)
    - name: "Average Surface Dimensions Length Ft"
      expr: AVG(surface_dimensions_length_ft)
    - name: "Total Surface Dimensions Width Ft"
      expr: SUM(surface_dimensions_width_ft)
    - name: "Average Surface Dimensions Width Ft"
      expr: AVG(surface_dimensions_width_ft)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_athletic_scholarship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Athletic Scholarship business metrics"
  source: "`education_ecm`.`athletics`.`athletic_scholarship`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Aid Type"
      expr: aid_type
    - name: "Appeal Decision Date"
      expr: appeal_decision_date
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Status"
      expr: appeal_status
    - name: "Award Approval Date"
      expr: award_approval_date
    - name: "Award End Date"
      expr: award_end_date
    - name: "Award Start Date"
      expr: award_start_date
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Flag"
      expr: cancellation_flag
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Compliance Verified Date"
      expr: compliance_verified_date
    - name: "Compliance Verified Flag"
      expr: compliance_verified_flag
    - name: "Counter Exemption Reason"
      expr: counter_exemption_reason
    - name: "Counter Flag"
      expr: counter_flag
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Athletic Scholarship"
      expr: COUNT(DISTINCT athletic_scholarship_id)
    - name: "Total Equivalency Value"
      expr: SUM(equivalency_value)
    - name: "Average Equivalency Value"
      expr: AVG(equivalency_value)
    - name: "Total Reduction Amount"
      expr: SUM(reduction_amount)
    - name: "Average Reduction Amount"
      expr: AVG(reduction_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_booster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booster business metrics"
  source: "`education_ecm`.`athletics`.`booster`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Alumni Flag"
      expr: alumni_flag
    - name: "Booster Status"
      expr: booster_status
    - name: "Booster Type"
      expr: booster_type
    - name: "City"
      expr: city
    - name: "Classification Date"
      expr: classification_date
    - name: "Club Member Flag"
      expr: club_member_flag
    - name: "Compliance Briefing Completed"
      expr: compliance_briefing_completed
    - name: "Compliance Briefing Date"
      expr: compliance_briefing_date
    - name: "Compliance Briefing Required"
      expr: compliance_briefing_required
    - name: "Compliance Incident Count"
      expr: compliance_incident_count
    - name: "Compliance Incident Flag"
      expr: compliance_incident_flag
    - name: "Compliance Restriction Details"
      expr: compliance_restriction_details
    - name: "Compliance Restriction Flag"
      expr: compliance_restriction_flag
    - name: "Corporate Sponsor Flag"
      expr: corporate_sponsor_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booster"
      expr: COUNT(DISTINCT booster_id)
    - name: "Total Last Contribution Amount"
      expr: SUM(last_contribution_amount)
    - name: "Average Last Contribution Amount"
      expr: AVG(last_contribution_amount)
    - name: "Total Total Lifetime Contributions"
      expr: SUM(total_lifetime_contributions)
    - name: "Average Total Lifetime Contributions"
      expr: AVG(total_lifetime_contributions)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_coach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coach business metrics"
  source: "`education_ecm`.`athletics`.`coach`"
  dimensions:
    - name: "Alma Mater"
      expr: alma_mater
    - name: "Background Check Date"
      expr: background_check_date
    - name: "Background Check Status"
      expr: background_check_status
    - name: "Bio Url"
      expr: bio_url
    - name: "Cara Supervision Authorized"
      expr: cara_supervision_authorized
    - name: "Coaching Role"
      expr: coaching_role
    - name: "Coaching Specialization"
      expr: coaching_specialization
    - name: "Compliance Training Completion Date"
      expr: compliance_training_completion_date
    - name: "Compliance Training Status"
      expr: compliance_training_status
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Countable Coach Flag"
      expr: countable_coach_flag
    - name: "Email Address"
      expr: email_address
    - name: "Employment Status"
      expr: employment_status
    - name: "Employment Type"
      expr: employment_type
    - name: "First Name"
      expr: first_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coach"
      expr: COUNT(DISTINCT coach_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_compliance_waiver`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance Waiver business metrics"
  source: "`education_ecm`.`athletics`.`compliance_waiver`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Appeal Decision Date"
      expr: appeal_decision_date
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Outcome"
      expr: appeal_outcome
    - name: "Appeal Submission Date"
      expr: appeal_submission_date
    - name: "Athletic Director Approval Flag"
      expr: athletic_director_approval_flag
    - name: "Compliance Officer Name"
      expr: compliance_officer_name
    - name: "Conference Code"
      expr: conference_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decision Date"
      expr: decision_date
    - name: "Decision Outcome"
      expr: decision_outcome
    - name: "Decision Rationale"
      expr: decision_rationale
    - name: "Eligibility Impact"
      expr: eligibility_impact
    - name: "Eligibility Year Adjustment"
      expr: eligibility_year_adjustment
    - name: "Expected Decision Date"
      expr: expected_decision_date
    - name: "Governing Body"
      expr: governing_body
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Compliance Waiver"
      expr: COUNT(DISTINCT compliance_waiver_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_drug_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drug Test business metrics"
  source: "`education_ecm`.`athletics`.`drug_test`"
  dimensions:
    - name: "Appeal Decision Date"
      expr: appeal_decision_date
    - name: "Appeal Filed Date"
      expr: appeal_filed_date
    - name: "Appeal Filed Flag"
      expr: appeal_filed_flag
    - name: "Appeal Status"
      expr: appeal_status
    - name: "B Sample Requested Flag"
      expr: b_sample_requested_flag
    - name: "B Sample Result"
      expr: b_sample_result
    - name: "Chain Of Custody Number"
      expr: chain_of_custody_number
    - name: "Collection Site Code"
      expr: collection_site_code
    - name: "Concentration Level"
      expr: concentration_level
    - name: "Games Missed"
      expr: games_missed
    - name: "Laboratory Accreditation Number"
      expr: laboratory_accreditation_number
    - name: "Notes"
      expr: notes
    - name: "Notification Date"
      expr: notification_date
    - name: "Notification Method"
      expr: notification_method
    - name: "Positive Substance Name"
      expr: positive_substance_name
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Drug Test"
      expr: COUNT(DISTINCT drug_test_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_eada_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eada Report business metrics"
  source: "`education_ecm`.`athletics`.`eada_report`"
  dimensions:
    - name: "Athletics Director Email"
      expr: athletics_director_email
    - name: "Athletics Director Name"
      expr: athletics_director_name
    - name: "Athletics Director Phone"
      expr: athletics_director_phone
    - name: "Certification Date"
      expr: certification_date
    - name: "Certified By Name"
      expr: certified_by_name
    - name: "Certified By Title"
      expr: certified_by_title
    - name: "Coeducational Participants"
      expr: coeducational_participants
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Report Notes"
      expr: report_notes
    - name: "Report Preparer Email"
      expr: report_preparer_email
    - name: "Report Preparer Name"
      expr: report_preparer_name
    - name: "Report Preparer Phone"
      expr: report_preparer_phone
    - name: "Reporting Year"
      expr: reporting_year
    - name: "Submission Date"
      expr: submission_date
    - name: "Submission Status"
      expr: submission_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eada Report"
      expr: COUNT(DISTINCT eada_report_id)
    - name: "Total Coeducational Athletically Related Student Aid"
      expr: SUM(coeducational_athletically_related_student_aid)
    - name: "Average Coeducational Athletically Related Student Aid"
      expr: AVG(coeducational_athletically_related_student_aid)
    - name: "Total Coeducational Operating Expenses"
      expr: SUM(coeducational_operating_expenses)
    - name: "Average Coeducational Operating Expenses"
      expr: AVG(coeducational_operating_expenses)
    - name: "Total Coeducational Recruiting Expenses"
      expr: SUM(coeducational_recruiting_expenses)
    - name: "Average Coeducational Recruiting Expenses"
      expr: AVG(coeducational_recruiting_expenses)
    - name: "Total Coeducational Revenues"
      expr: SUM(coeducational_revenues)
    - name: "Average Coeducational Revenues"
      expr: AVG(coeducational_revenues)
    - name: "Total Mens Assistant Coach Salaries Total"
      expr: SUM(mens_assistant_coach_salaries_total)
    - name: "Average Mens Assistant Coach Salaries Total"
      expr: AVG(mens_assistant_coach_salaries_total)
    - name: "Total Mens Athletically Related Student Aid"
      expr: SUM(mens_athletically_related_student_aid)
    - name: "Average Mens Athletically Related Student Aid"
      expr: AVG(mens_athletically_related_student_aid)
    - name: "Total Mens Head Coach Salaries Total"
      expr: SUM(mens_head_coach_salaries_total)
    - name: "Average Mens Head Coach Salaries Total"
      expr: AVG(mens_head_coach_salaries_total)
    - name: "Total Mens Operating Expenses"
      expr: SUM(mens_operating_expenses)
    - name: "Average Mens Operating Expenses"
      expr: AVG(mens_operating_expenses)
    - name: "Total Mens Recruiting Expenses"
      expr: SUM(mens_recruiting_expenses)
    - name: "Average Mens Recruiting Expenses"
      expr: AVG(mens_recruiting_expenses)
    - name: "Total Mens Total Revenues"
      expr: SUM(mens_total_revenues)
    - name: "Average Mens Total Revenues"
      expr: AVG(mens_total_revenues)
    - name: "Total Total Athletics Expenses"
      expr: SUM(total_athletics_expenses)
    - name: "Average Total Athletics Expenses"
      expr: AVG(total_athletics_expenses)
    - name: "Total Total Athletics Revenues"
      expr: SUM(total_athletics_revenues)
    - name: "Average Total Athletics Revenues"
      expr: AVG(total_athletics_revenues)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_eligibility_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Certification business metrics"
  source: "`education_ecm`.`athletics`.`eligibility_certification`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Amateurism Certification Status"
      expr: amateurism_certification_status
    - name: "Athletic Scholarship Flag"
      expr: athletic_scholarship_flag
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Notes"
      expr: certification_notes
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Term"
      expr: certification_term
    - name: "Certification Timestamp"
      expr: certification_timestamp
    - name: "Certifying Official Name"
      expr: certifying_official_name
    - name: "Compliance Hold Flag"
      expr: compliance_hold_flag
    - name: "Compliance Hold Reason"
      expr: compliance_hold_reason
    - name: "Division Level"
      expr: division_level
    - name: "Eligibility Year"
      expr: eligibility_year
    - name: "Full Time Enrollment Verified"
      expr: full_time_enrollment_verified
    - name: "Gpa Requirement Met"
      expr: gpa_requirement_met
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Certification"
      expr: COUNT(DISTINCT eligibility_certification_id)
    - name: "Total Credit Hours Enrolled"
      expr: SUM(credit_hours_enrolled)
    - name: "Average Credit Hours Enrolled"
      expr: AVG(credit_hours_enrolled)
    - name: "Total Cumulative Gpa"
      expr: SUM(cumulative_gpa)
    - name: "Average Cumulative Gpa"
      expr: AVG(cumulative_gpa)
    - name: "Total Degree Applicable Credits Earned"
      expr: SUM(degree_applicable_credits_earned)
    - name: "Average Degree Applicable Credits Earned"
      expr: AVG(degree_applicable_credits_earned)
    - name: "Total Degree Applicable Credits Required"
      expr: SUM(degree_applicable_credits_required)
    - name: "Average Degree Applicable Credits Required"
      expr: AVG(degree_applicable_credits_required)
    - name: "Total Minimum Credit Hours Required"
      expr: SUM(minimum_credit_hours_required)
    - name: "Average Minimum Credit Hours Required"
      expr: AVG(minimum_credit_hours_required)
    - name: "Total Minimum Gpa Required"
      expr: SUM(minimum_gpa_required)
    - name: "Average Minimum Gpa Required"
      expr: AVG(minimum_gpa_required)
    - name: "Total Progress Toward Degree Percentage"
      expr: SUM(progress_toward_degree_percentage)
    - name: "Average Progress Toward Degree Percentage"
      expr: AVG(progress_toward_degree_percentage)
    - name: "Total Term Gpa"
      expr: SUM(term_gpa)
    - name: "Average Term Gpa"
      expr: AVG(term_gpa)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_facility_event_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility Event Booking business metrics"
  source: "`education_ecm`.`athletics`.`facility_event_booking`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Booking Number"
      expr: booking_number
    - name: "Booking Status"
      expr: booking_status
    - name: "Broadcast Flag"
      expr: broadcast_flag
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Catering Required Flag"
      expr: catering_required_flag
    - name: "Conference Game Flag"
      expr: conference_game_flag
    - name: "Conflict Check Status"
      expr: conflict_check_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Time"
      expr: end_time
    - name: "Equipment Needs"
      expr: equipment_needs
    - name: "Event Date"
      expr: event_date
    - name: "Event Type"
      expr: event_type
    - name: "Expected Attendance"
      expr: expected_attendance
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Facility Event Booking"
      expr: COUNT(DISTINCT facility_event_booking_id)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Rental Revenue Amount"
      expr: SUM(rental_revenue_amount)
    - name: "Average Rental Revenue Amount"
      expr: AVG(rental_revenue_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_game`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game business metrics"
  source: "`education_ecm`.`athletics`.`game`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Attendance"
      expr: attendance
    - name: "Away Team Score"
      expr: away_team_score
    - name: "Broadcast Network"
      expr: broadcast_network
    - name: "Broadcast Type"
      expr: broadcast_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Conference Game Flag"
      expr: conference_game_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Datetime"
      expr: datetime
    - name: "Game Date"
      expr: game_date
    - name: "Game Number"
      expr: game_number
    - name: "Game Status"
      expr: game_status
    - name: "Game Time"
      expr: game_time
    - name: "Game Type"
      expr: game_type
    - name: "Head Official Name"
      expr: head_official_name
    - name: "Home Away Neutral"
      expr: home_away_neutral
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game"
      expr: COUNT(DISTINCT game_id)
    - name: "Total Ticket Revenue"
      expr: SUM(ticket_revenue)
    - name: "Average Ticket Revenue"
      expr: AVG(ticket_revenue)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_game_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Game Participation business metrics"
  source: "`education_ecm`.`athletics`.`game_participation`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Aces"
      expr: aces
    - name: "Assists"
      expr: assists
    - name: "Blocks"
      expr: blocks
    - name: "Competition Level"
      expr: competition_level
    - name: "Counts Toward Eligibility Flag"
      expr: counts_toward_eligibility_flag
    - name: "Disciplinary Action Description"
      expr: disciplinary_action_description
    - name: "Disciplinary Action Flag"
      expr: disciplinary_action_flag
    - name: "Ejection Flag"
      expr: ejection_flag
    - name: "Ejection Reason"
      expr: ejection_reason
    - name: "Fouls Committed"
      expr: fouls_committed
    - name: "Goals Scored"
      expr: goals_scored
    - name: "Hits"
      expr: hits
    - name: "Injury Description"
      expr: injury_description
    - name: "Injury Flag"
      expr: injury_flag
    - name: "Jersey Number"
      expr: jersey_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Game Participation"
      expr: COUNT(DISTINCT game_participation_id)
    - name: "Total Innings Played"
      expr: SUM(innings_played)
    - name: "Average Innings Played"
      expr: AVG(innings_played)
    - name: "Total Minutes Played"
      expr: SUM(minutes_played)
    - name: "Average Minutes Played"
      expr: AVG(minutes_played)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_nil_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nil Activity business metrics"
  source: "`education_ecm`.`athletics`.`nil_activity`"
  dimensions:
    - name: "Activity Description"
      expr: activity_description
    - name: "Activity Number"
      expr: activity_number
    - name: "Activity Status"
      expr: activity_status
    - name: "Activity Type"
      expr: activity_type
    - name: "Agreement End Date"
      expr: agreement_end_date
    - name: "Agreement Start Date"
      expr: agreement_start_date
    - name: "Compensation Currency Code"
      expr: compensation_currency_code
    - name: "Compensation Type"
      expr: compensation_type
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Conflict Of Interest Flag"
      expr: conflict_of_interest_flag
    - name: "Conflict Of Interest Notes"
      expr: conflict_of_interest_notes
    - name: "Disclosure Date"
      expr: disclosure_date
    - name: "Disclosure Method"
      expr: disclosure_method
    - name: "Institutional Marks Approval Status"
      expr: institutional_marks_approval_status
    - name: "Institutional Marks Used Flag"
      expr: institutional_marks_used_flag
    - name: "Institutional Review Status"
      expr: institutional_review_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nil Activity"
      expr: COUNT(DISTINCT nil_activity_id)
    - name: "Total Estimated Compensation Value"
      expr: SUM(estimated_compensation_value)
    - name: "Average Estimated Compensation Value"
      expr: AVG(estimated_compensation_value)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_nli`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nli business metrics"
  source: "`education_ecm`.`athletics`.`nli`"
  dimensions:
    - name: "Academic Year Commitment"
      expr: academic_year_commitment
    - name: "Compliance Certification Date"
      expr: compliance_certification_date
    - name: "Division Level"
      expr: division_level
    - name: "Document Number"
      expr: document_number
    - name: "Enrollment Term"
      expr: enrollment_term
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Initial Eligibility Status"
      expr: initial_eligibility_status
    - name: "Institutional Signatory Name"
      expr: institutional_signatory_name
    - name: "Institutional Signatory Title"
      expr: institutional_signatory_title
    - name: "Institutional Signature Date"
      expr: institutional_signature_date
    - name: "Ncaa Eligibility Center Number"
      expr: ncaa_eligibility_center_number
    - name: "Nli Status"
      expr: nli_status
    - name: "Notes"
      expr: notes
    - name: "Parent Guardian Signature Date"
      expr: parent_guardian_signature_date
    - name: "Parent Guardian Signature Required"
      expr: parent_guardian_signature_required
    - name: "Penalty Waiver Date"
      expr: penalty_waiver_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Nli"
      expr: COUNT(DISTINCT nli_id)
    - name: "Total Scholarship Duration Years"
      expr: SUM(scholarship_duration_years)
    - name: "Average Scholarship Duration Years"
      expr: AVG(scholarship_duration_years)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_official_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Official Visit business metrics"
  source: "`education_ecm`.`athletics`.`official_visit`"
  dimensions:
    - name: "Academic Meeting Included Flag"
      expr: academic_meeting_included_flag
    - name: "Academic Year"
      expr: academic_year
    - name: "Accompanying Parent Guardian Count"
      expr: accompanying_parent_guardian_count
    - name: "Accompanying Spouse Count"
      expr: accompanying_spouse_count
    - name: "Athletic Event Attendance Flag"
      expr: athletic_event_attendance_flag
    - name: "Athletic Facilities Tour Included Flag"
      expr: athletic_facilities_tour_included_flag
    - name: "Campus Tour Included Flag"
      expr: campus_tour_included_flag
    - name: "Compliance Post Certification Date"
      expr: compliance_post_certification_date
    - name: "Compliance Post Certification Status"
      expr: compliance_post_certification_status
    - name: "Compliance Pre Approval Date"
      expr: compliance_pre_approval_date
    - name: "Compliance Pre Approval Status"
      expr: compliance_pre_approval_status
    - name: "Compliance Violation Description"
      expr: compliance_violation_description
    - name: "Compliance Violation Flag"
      expr: compliance_violation_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Division Level"
      expr: division_level
    - name: "Itinerary Description"
      expr: itinerary_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Official Visit"
      expr: COUNT(DISTINCT official_visit_id)
    - name: "Total Entertainment Expense Amount"
      expr: SUM(entertainment_expense_amount)
    - name: "Average Entertainment Expense Amount"
      expr: AVG(entertainment_expense_amount)
    - name: "Total Lodging Expense Amount"
      expr: SUM(lodging_expense_amount)
    - name: "Average Lodging Expense Amount"
      expr: AVG(lodging_expense_amount)
    - name: "Total Meals Expense Amount"
      expr: SUM(meals_expense_amount)
    - name: "Average Meals Expense Amount"
      expr: AVG(meals_expense_amount)
    - name: "Total Total Visit Cost"
      expr: SUM(total_visit_cost)
    - name: "Average Total Visit Cost"
      expr: AVG(total_visit_cost)
    - name: "Total Transportation Expense Amount"
      expr: SUM(transportation_expense_amount)
    - name: "Average Transportation Expense Amount"
      expr: AVG(transportation_expense_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_practice_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice Session business metrics"
  source: "`education_ecm`.`athletics`.`practice_session`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Attendance Count"
      expr: attendance_count
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cara Countable Flag"
      expr: cara_countable_flag
    - name: "Competition Preparation Flag"
      expr: competition_preparation_flag
    - name: "Compliance Certification Timestamp"
      expr: compliance_certification_timestamp
    - name: "Compliance Certified Flag"
      expr: compliance_certified_flag
    - name: "Compliance Review Required Flag"
      expr: compliance_review_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Heat Index"
      expr: heat_index
    - name: "Injury Count"
      expr: injury_count
    - name: "Injury Occurred Flag"
      expr: injury_occurred_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Mandatory Attendance Flag"
      expr: mandatory_attendance_flag
    - name: "Medical Staff Present Flag"
      expr: medical_staff_present_flag
    - name: "Opponent Scouting Flag"
      expr: opponent_scouting_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Practice Session"
      expr: COUNT(DISTINCT practice_session_id)
    - name: "Total Duration Hours"
      expr: SUM(duration_hours)
    - name: "Average Duration Hours"
      expr: AVG(duration_hours)
    - name: "Total Weekly Cara Hours Accumulated"
      expr: SUM(weekly_cara_hours_accumulated)
    - name: "Average Weekly Cara Hours Accumulated"
      expr: AVG(weekly_cara_hours_accumulated)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_recruit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruit business metrics"
  source: "`education_ecm`.`athletics`.`recruit`"
  dimensions:
    - name: "Academic Eligibility Status"
      expr: academic_eligibility_status
    - name: "Act Score"
      expr: act_score
    - name: "First Contact Date"
      expr: first_contact_date
    - name: "Height Inches"
      expr: height_inches
    - name: "High School City"
      expr: high_school_city
    - name: "High School Graduation Year"
      expr: high_school_graduation_year
    - name: "High School Name"
      expr: high_school_name
    - name: "High School State Province"
      expr: high_school_state_province
    - name: "Last Contact Date"
      expr: last_contact_date
    - name: "National Letter Of Intent Signed"
      expr: national_letter_of_intent_signed
    - name: "Nli Signed Date"
      expr: nli_signed_date
    - name: "Notes"
      expr: notes
    - name: "Official Visit Count"
      expr: official_visit_count
    - name: "Position"
      expr: position
    - name: "Prospect Address Line1"
      expr: prospect_address_line1
    - name: "Prospect City"
      expr: prospect_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recruit"
      expr: COUNT(DISTINCT recruit_id)
    - name: "Total Gpa"
      expr: SUM(gpa)
    - name: "Average Gpa"
      expr: AVG(gpa)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_recruiting_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recruiting Contact business metrics"
  source: "`education_ecm`.`athletics`.`recruiting_contact`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Compliance Flag Reason"
      expr: compliance_flag_reason
    - name: "Contact City"
      expr: contact_city
    - name: "Contact Date"
      expr: contact_date
    - name: "Contact Duration Minutes"
      expr: contact_duration_minutes
    - name: "Contact Location"
      expr: contact_location
    - name: "Contact Medium"
      expr: contact_medium
    - name: "Contact Notes"
      expr: contact_notes
    - name: "Contact State"
      expr: contact_state
    - name: "Contact Subject"
      expr: contact_subject
    - name: "Contact Time"
      expr: contact_time
    - name: "Contact Type"
      expr: contact_type
    - name: "Evaluation Notes"
      expr: evaluation_notes
    - name: "Evaluation Type"
      expr: evaluation_type
    - name: "Family Members Present"
      expr: family_members_present
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recruiting Contact"
      expr: COUNT(DISTINCT recruiting_contact_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roster business metrics"
  source: "`education_ecm`.`athletics`.`roster`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Add Date"
      expr: add_date
    - name: "Captain Flag"
      expr: captain_flag
    - name: "Certification Date"
      expr: certification_date
    - name: "Certification Status"
      expr: certification_status
    - name: "Compliance Hold Flag"
      expr: compliance_hold_flag
    - name: "Compliance Hold Reason"
      expr: compliance_hold_reason
    - name: "Drop Date"
      expr: drop_date
    - name: "Eligibility Year"
      expr: eligibility_year
    - name: "Eligibility Years Remaining"
      expr: eligibility_years_remaining
    - name: "Height Inches"
      expr: height_inches
    - name: "High School Name"
      expr: high_school_name
    - name: "Home State"
      expr: home_state
    - name: "Hometown"
      expr: hometown
    - name: "Injury Status"
      expr: injury_status
    - name: "Jersey Number"
      expr: jersey_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Roster"
      expr: COUNT(DISTINCT roster_id)
    - name: "Total Scholarship Percentage"
      expr: SUM(scholarship_percentage)
    - name: "Average Scholarship Percentage"
      expr: AVG(scholarship_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_secondary_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Secondary Violation business metrics"
  source: "`education_ecm`.`athletics`.`secondary_violation`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Bylaw Citation"
      expr: bylaw_citation
    - name: "Case Closure Date"
      expr: case_closure_date
    - name: "Corrective Action Date"
      expr: corrective_action_date
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Discovery Date"
      expr: discovery_date
    - name: "Division Level"
      expr: division_level
    - name: "Governing Body"
      expr: governing_body
    - name: "Governing Body Notification Date"
      expr: governing_body_notification_date
    - name: "Investigation Completed Date"
      expr: investigation_completed_date
    - name: "Investigation Start Date"
      expr: investigation_start_date
    - name: "Involved Party Type"
      expr: involved_party_type
    - name: "Notes"
      expr: notes
    - name: "Penalty Effective Date"
      expr: penalty_effective_date
    - name: "Penalty Imposed"
      expr: penalty_imposed
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Secondary Violation"
      expr: COUNT(DISTINCT secondary_violation_id)
    - name: "Total Financial Impact Amount"
      expr: SUM(financial_impact_amount)
    - name: "Average Financial Impact Amount"
      expr: AVG(financial_impact_amount)
    - name: "Total Restitution Amount"
      expr: SUM(restitution_amount)
    - name: "Average Restitution Amount"
      expr: AVG(restitution_amount)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_sport`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sport business metrics"
  source: "`education_ecm`.`athletics`.`sport`"
  dimensions:
    - name: "Championship Eligible Flag"
      expr: championship_eligible_flag
    - name: "Competition End Date"
      expr: competition_end_date
    - name: "Competition Start Date"
      expr: competition_start_date
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Conference Affiliation"
      expr: conference_affiliation
    - name: "Contact Sport Flag"
      expr: contact_sport_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Division Level"
      expr: division_level
    - name: "Eada Reporting Code"
      expr: eada_reporting_code
    - name: "End Date"
      expr: end_date
    - name: "Gender Classification"
      expr: gender_classification
    - name: "Governing Body Code"
      expr: governing_body_code
    - name: "Ipeds Sport Code"
      expr: ipeds_sport_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Maximum Contests Allowed"
      expr: maximum_contests_allowed
    - name: "Maximum Roster Size"
      expr: maximum_roster_size
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sport"
      expr: COUNT(DISTINCT sport_id)
    - name: "Total Maximum Scholarship Equivalencies"
      expr: SUM(maximum_scholarship_equivalencies)
    - name: "Average Maximum Scholarship Equivalencies"
      expr: AVG(maximum_scholarship_equivalencies)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_sports_medicine_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sports Medicine Case business metrics"
  source: "`education_ecm`.`athletics`.`sports_medicine_case`"
  dimensions:
    - name: "Body Part"
      expr: body_part
    - name: "Body Side"
      expr: body_side
    - name: "Case Closed Date"
      expr: case_closed_date
    - name: "Case Notes"
      expr: case_notes
    - name: "Case Number"
      expr: case_number
    - name: "Case Opened Date"
      expr: case_opened_date
    - name: "Case Status"
      expr: case_status
    - name: "Concussion Protocol Flag"
      expr: concussion_protocol_flag
    - name: "Diagnosis Code"
      expr: diagnosis_code
    - name: "Diagnosis Description"
      expr: diagnosis_description
    - name: "Estimated Recovery Days"
      expr: estimated_recovery_days
    - name: "Injury Category"
      expr: injury_category
    - name: "Injury Date"
      expr: injury_date
    - name: "Injury Description"
      expr: injury_description
    - name: "Injury Time"
      expr: injury_time
    - name: "Injury Type"
      expr: injury_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sports Medicine Case"
      expr: COUNT(DISTINCT sports_medicine_case_id)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_student_athlete`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student Athlete business metrics"
  source: "`education_ecm`.`athletics`.`student_athlete`"
  dimensions:
    - name: "Amateurism Certification Status"
      expr: amateurism_certification_status
    - name: "Athletic Scholarship Flag"
      expr: athletic_scholarship_flag
    - name: "Compliance Hold Flag"
      expr: compliance_hold_flag
    - name: "Compliance Hold Reason"
      expr: compliance_hold_reason
    - name: "Division Level"
      expr: division_level
    - name: "Drug Testing Pool Flag"
      expr: drug_testing_pool_flag
    - name: "Eligibility Clock Start Term"
      expr: eligibility_clock_start_term
    - name: "Eligibility Years Remaining"
      expr: eligibility_years_remaining
    - name: "Eligibility Years Used"
      expr: eligibility_years_used
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Height Inches"
      expr: height_inches
    - name: "High School Name"
      expr: high_school_name
    - name: "Hometown"
      expr: hometown
    - name: "Initial Eligibility Certified Date"
      expr: initial_eligibility_certified_date
    - name: "Jersey Number"
      expr: jersey_number
    - name: "Medical Hardship Season"
      expr: medical_hardship_season
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Student Athlete"
      expr: COUNT(DISTINCT student_athlete_id)
    - name: "Total Scholarship Percentage"
      expr: SUM(scholarship_percentage)
    - name: "Average Scholarship Percentage"
      expr: AVG(scholarship_percentage)
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`athletics_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Team business metrics"
  source: "`education_ecm`.`athletics`.`team`"
  dimensions:
    - name: "Academic Year"
      expr: academic_year
    - name: "Assistant Coach Count"
      expr: assistant_coach_count
    - name: "Compliance Certification Date"
      expr: compliance_certification_date
    - name: "Compliance Certification Status"
      expr: compliance_certification_status
    - name: "Conference Affiliation"
      expr: conference_affiliation
    - name: "Conference Code"
      expr: conference_code
    - name: "Conference Losses"
      expr: conference_losses
    - name: "Conference Standing"
      expr: conference_standing
    - name: "Conference Wins"
      expr: conference_wins
    - name: "Division Level"
      expr: division_level
    - name: "Established Date"
      expr: established_date
    - name: "Gender"
      expr: gender
    - name: "Home Venue Name"
      expr: home_venue_name
    - name: "Losses"
      expr: losses
    - name: "Next Compliance Review Date"
      expr: next_compliance_review_date
    - name: "Nickname"
      expr: nickname
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Team"
      expr: COUNT(DISTINCT team_id)
    - name: "Total Apr Score"
      expr: SUM(apr_score)
    - name: "Average Apr Score"
      expr: AVG(apr_score)
    - name: "Total Gsr Rate"
      expr: SUM(gsr_rate)
    - name: "Average Gsr Rate"
      expr: AVG(gsr_rate)
    - name: "Total Operating Budget"
      expr: SUM(operating_budget)
    - name: "Average Operating Budget"
      expr: AVG(operating_budget)
    - name: "Total Revenue Generated"
      expr: SUM(revenue_generated)
    - name: "Average Revenue Generated"
      expr: AVG(revenue_generated)
    - name: "Total Scholarship Limit"
      expr: SUM(scholarship_limit)
    - name: "Average Scholarship Limit"
      expr: AVG(scholarship_limit)
    - name: "Total Scholarships Awarded"
      expr: SUM(scholarships_awarded)
    - name: "Average Scholarships Awarded"
      expr: AVG(scholarships_awarded)
$$;