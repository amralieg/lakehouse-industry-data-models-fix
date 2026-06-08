-- Metric views for domain: studentlife | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_dining_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dining transaction metrics tracking meal plan usage, spending patterns, and dining behavior across campus locations"
  source: "`education_ecm`.`studentlife`.`dining_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: DATE(transaction_timestamp)
      comment: "Date of the dining transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of the dining transaction for trend analysis"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of dining transaction (meal swipe, dining dollars, cash, etc.)"
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period (breakfast, lunch, dinner, late night)"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the transaction"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (completed, refunded, pending, etc.)"
    - name: "is_refunded"
      expr: is_refunded
      comment: "Flag indicating whether the transaction was refunded"
  measures:
    - name: "total_transaction_count"
      expr: COUNT(1)
      comment: "Total number of dining transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all dining transactions"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per dining transaction"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across all transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all transactions"
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amount across all transactions"
    - name: "unique_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students making dining transactions"
    - name: "refund_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_refunded = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions that were refunded, indicating service quality issues"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_housing_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Housing contract metrics tracking occupancy, revenue, cancellations, and contract lifecycle management"
  source: "`education_ecm`.`studentlife`.`housing_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the housing contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of housing contract (academic year, semester, summer, etc.)"
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the housing contract"
    - name: "academic_term"
      expr: academic_term
      comment: "Academic term of the housing contract"
    - name: "occupancy_status"
      expr: occupancy_status
      comment: "Current occupancy status of the contracted space"
    - name: "room_type"
      expr: room_type
      comment: "Type of room contracted (single, double, suite, etc.)"
    - name: "renewal_eligible"
      expr: renewal_eligible
      comment: "Flag indicating whether the contract is eligible for renewal"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month when the contract was signed"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of housing contracts"
    - name: "total_contract_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from all housing contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average contract value per housing agreement"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amount collected across all contracts"
    - name: "total_cancellation_fees"
      expr: SUM(CAST(cancellation_fee_amount AS DOUBLE))
      comment: "Total cancellation fees collected from terminated contracts"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cancellation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts that were cancelled, indicating housing satisfaction and retention"
    - name: "renewal_eligible_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN renewal_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contracts eligible for renewal, indicating student retention potential"
    - name: "unique_students_housed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students with housing contracts"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_conduct_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student conduct case metrics tracking violations, case resolution, appeals, and disciplinary outcomes"
  source: "`education_ecm`.`studentlife`.`conduct_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the conduct case"
    - name: "violation_type_primary"
      expr: violation_type_primary
      comment: "Primary type of conduct violation"
    - name: "finding"
      expr: finding
      comment: "Finding or outcome of the conduct case (responsible, not responsible, etc.)"
    - name: "hearing_type"
      expr: hearing_type
      comment: "Type of hearing conducted for the case"
    - name: "appeal_filed_flag"
      expr: appeal_filed_flag
      comment: "Flag indicating whether an appeal was filed"
    - name: "appeal_decision"
      expr: appeal_decision
      comment: "Decision on the appeal if filed"
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_occurrence_date)
      comment: "Month when the incident occurred"
    - name: "case_closure_month"
      expr: DATE_TRUNC('MONTH', case_closure_date)
      comment: "Month when the case was closed"
  measures:
    - name: "total_conduct_cases"
      expr: COUNT(1)
      comment: "Total number of student conduct cases"
    - name: "unique_students_with_cases"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students involved in conduct cases"
    - name: "appeal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_filed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where an appeal was filed, indicating case fairness perception"
    - name: "responsible_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN finding = 'Responsible' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resulting in a responsible finding"
    - name: "avg_case_resolution_days"
      expr: AVG(DATEDIFF(case_closure_date, incident_report_date))
      comment: "Average number of days from incident report to case closure, measuring process efficiency"
    - name: "parent_notification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN parent_notification_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases where parents were notified, indicating severity"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_health_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health services visit metrics tracking utilization, wait times, referrals, and healthcare delivery efficiency"
  source: "`education_ecm`.`studentlife`.`health_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of health visit (routine, urgent, follow-up, etc.)"
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the health visit"
    - name: "visit_month"
      expr: DATE_TRUNC('MONTH', visit_date)
      comment: "Month of the health visit for trend analysis"
    - name: "provider_credential_type"
      expr: provider_credential_type
      comment: "Credential type of the healthcare provider"
    - name: "referral_flag"
      expr: referral_flag
      comment: "Flag indicating whether a referral was made"
    - name: "insurance_used_flag"
      expr: insurance_used_flag
      comment: "Flag indicating whether insurance was used for the visit"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flag indicating whether follow-up care is required"
  measures:
    - name: "total_health_visits"
      expr: COUNT(1)
      comment: "Total number of health service visits"
    - name: "unique_students_served"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students receiving health services"
    - name: "avg_visit_duration_minutes"
      expr: AVG(CAST(visit_duration_minutes AS DOUBLE))
      comment: "Average duration of health visits in minutes, measuring service efficiency"
    - name: "total_visit_charges"
      expr: SUM(CAST(visit_charge_amount AS DOUBLE))
      comment: "Total charges for health visits"
    - name: "avg_copay_amount"
      expr: AVG(CAST(copay_amount AS DOUBLE))
      comment: "Average copay amount per visit"
    - name: "referral_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN referral_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits resulting in external referrals, indicating case complexity"
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits requiring follow-up care, indicating ongoing health needs"
    - name: "insurance_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_used_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits where insurance was used, measuring financial accessibility"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_event_attendance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campus event attendance metrics tracking student engagement, participation patterns, and co-curricular credit"
  source: "`education_ecm`.`studentlife`.`event_attendance`"
  dimensions:
    - name: "attendance_status"
      expr: attendance_status
      comment: "Status of the event attendance (attended, registered, cancelled, no-show)"
    - name: "attendance_method"
      expr: attendance_method
      comment: "Method of attendance (in-person, virtual, hybrid)"
    - name: "participation_level"
      expr: participation_level
      comment: "Level of participation in the event"
    - name: "co_curricular_credit_awarded_flag"
      expr: co_curricular_credit_awarded_flag
      comment: "Flag indicating whether co-curricular credit was awarded"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Flag indicating whether the student registered but did not attend"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for ticketed events"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_timestamp)
      comment: "Month when the student registered for the event"
  measures:
    - name: "total_attendance_records"
      expr: COUNT(1)
      comment: "Total number of event attendance records"
    - name: "unique_students_attending"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students attending campus events"
    - name: "total_cocurricular_credits"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total co-curricular credits awarded through event attendance"
    - name: "avg_cocurricular_credit_per_event"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average co-curricular credit awarded per event attendance"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registrations resulting in no-shows, measuring event planning accuracy"
    - name: "cocurricular_credit_award_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN co_curricular_credit_awarded_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of attendances resulting in co-curricular credit awards"
    - name: "total_ticket_revenue"
      expr: SUM(CAST(ticket_cost_amount AS DOUBLE))
      comment: "Total revenue from ticketed event attendance"
    - name: "avg_attendance_duration_minutes"
      expr: AVG(CAST(attendance_duration_minutes AS DOUBLE))
      comment: "Average duration of event attendance in minutes"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_org_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Student organization membership metrics tracking engagement, leadership, retention, and organizational health"
  source: "`education_ecm`.`studentlife`.`org_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the organization membership"
    - name: "membership_role"
      expr: membership_role
      comment: "Role of the member within the organization"
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year of the membership"
    - name: "good_standing_flag"
      expr: good_standing_flag
      comment: "Flag indicating whether the member is in good standing"
    - name: "dues_paid_flag"
      expr: dues_paid_flag
      comment: "Flag indicating whether membership dues have been paid"
    - name: "leadership_training_completed_flag"
      expr: leadership_training_completed_flag
      comment: "Flag indicating whether leadership training has been completed"
    - name: "conduct_violation_flag"
      expr: conduct_violation_flag
      comment: "Flag indicating whether the member has a conduct violation"
    - name: "membership_start_month"
      expr: DATE_TRUNC('MONTH', membership_start_date)
      comment: "Month when the membership started"
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total number of organization memberships"
    - name: "unique_student_members"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students with organization memberships"
    - name: "total_dues_collected"
      expr: SUM(CAST(dues_amount AS DOUBLE))
      comment: "Total membership dues collected across all organizations"
    - name: "avg_dues_amount"
      expr: AVG(CAST(dues_amount AS DOUBLE))
      comment: "Average membership dues amount per organization"
    - name: "total_volunteer_hours"
      expr: SUM(CAST(volunteer_hours AS DOUBLE))
      comment: "Total volunteer hours contributed by organization members"
    - name: "avg_volunteer_hours_per_member"
      expr: AVG(CAST(volunteer_hours AS DOUBLE))
      comment: "Average volunteer hours per organization member, measuring engagement"
    - name: "good_standing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN good_standing_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members in good standing, indicating organizational health"
    - name: "dues_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dues_paid_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members who have paid dues, measuring financial compliance"
    - name: "leadership_training_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN leadership_training_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of members completing leadership training, measuring development investment"
    - name: "retention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN membership_end_date IS NULL OR membership_end_date > CURRENT_DATE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active memberships, measuring organizational retention"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_service_learning_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service learning placement metrics tracking community engagement, academic integration, and service hour completion"
  source: "`education_ecm`.`studentlife`.`service_learning_placement`"
  dimensions:
    - name: "placement_status"
      expr: placement_status
      comment: "Current status of the service learning placement"
    - name: "placement_type"
      expr: placement_type
      comment: "Type of service learning placement"
    - name: "placement_approval_status"
      expr: placement_approval_status
      comment: "Approval status of the placement"
    - name: "site_organization_type"
      expr: site_organization_type
      comment: "Type of organization hosting the service learning placement"
    - name: "background_check_required_flag"
      expr: background_check_required_flag
      comment: "Flag indicating whether a background check is required"
    - name: "reflection_required_flag"
      expr: reflection_required_flag
      comment: "Flag indicating whether reflection is required"
    - name: "placement_start_month"
      expr: DATE_TRUNC('MONTH', placement_start_date)
      comment: "Month when the placement started"
  measures:
    - name: "total_placements"
      expr: COUNT(1)
      comment: "Total number of service learning placements"
    - name: "unique_students_placed"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students in service learning placements"
    - name: "total_required_service_hours"
      expr: SUM(CAST(required_service_hours AS DOUBLE))
      comment: "Total required service hours across all placements"
    - name: "total_completed_service_hours"
      expr: SUM(CAST(completed_service_hours AS DOUBLE))
      comment: "Total completed service hours across all placements"
    - name: "avg_completed_hours_per_placement"
      expr: AVG(CAST(completed_service_hours AS DOUBLE))
      comment: "Average completed service hours per placement"
    - name: "total_cocurricular_credits_awarded"
      expr: SUM(CAST(co_curricular_credit_awarded AS DOUBLE))
      comment: "Total co-curricular credits awarded through service learning"
    - name: "total_academic_credit_hours"
      expr: SUM(CAST(academic_credit_hours AS DOUBLE))
      comment: "Total academic credit hours earned through service learning"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(completed_service_hours AS DOUBLE)) / NULLIF(SUM(CAST(required_service_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of required service hours completed, measuring program effectiveness"
    - name: "reflection_submission_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reflection_submission_status = 'Submitted' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN reflection_required_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required reflections submitted, measuring academic integration"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`studentlife_wellness_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wellness program participation metrics tracking student wellbeing engagement, completion rates, and outcome improvement"
  source: "`education_ecm`.`studentlife`.`wellness_participation`"
  dimensions:
    - name: "participation_status"
      expr: participation_status
      comment: "Current status of wellness program participation"
    - name: "delivery_mode"
      expr: delivery_mode
      comment: "Mode of wellness program delivery (in-person, virtual, hybrid)"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Flag indicating whether participation is mandatory"
    - name: "cocurricular_category"
      expr: cocurricular_category
      comment: "Co-curricular category of the wellness program"
    - name: "referral_source"
      expr: referral_source
      comment: "Source of referral to the wellness program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month when the student enrolled in the wellness program"
  measures:
    - name: "total_participations"
      expr: COUNT(1)
      comment: "Total number of wellness program participations"
    - name: "unique_students_participating"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique students participating in wellness programs"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all wellness participations, measuring engagement"
    - name: "total_cocurricular_credits_awarded"
      expr: SUM(CAST(cocurricular_credit_awarded AS DOUBLE))
      comment: "Total co-curricular credits awarded through wellness program participation"
    - name: "total_program_fees"
      expr: SUM(CAST(program_fee_amount AS DOUBLE))
      comment: "Total program fees collected from wellness participations"
    - name: "avg_pre_assessment_score"
      expr: AVG(CAST(pre_assessment_score AS DOUBLE))
      comment: "Average pre-assessment score across wellness programs"
    - name: "avg_post_assessment_score"
      expr: AVG(CAST(post_assessment_score AS DOUBLE))
      comment: "Average post-assessment score across wellness programs"
    - name: "avg_assessment_improvement"
      expr: AVG(CAST(assessment_improvement_score AS DOUBLE))
      comment: "Average improvement in assessment scores, measuring program effectiveness"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of wellness participations completed, measuring program retention"
    - name: "fee_waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fee_waived_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of participations with fee waivers, measuring financial accessibility"
$$;