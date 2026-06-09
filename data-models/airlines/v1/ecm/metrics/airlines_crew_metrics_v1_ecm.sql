-- Metric views for domain: crew | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core crew member workforce metrics tracking headcount, experience, operational status, and qualification currency for strategic workforce planning and regulatory compliance monitoring."
  source: "`airlines_ecm`.`crew`.`member`"
  dimensions:
    - name: "crew_category"
      expr: crew_category
      comment: "Crew category classification (e.g., flight deck, cabin crew, maintenance)"
    - name: "crew_position"
      expr: crew_position
      comment: "Specific crew position or role"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, on leave, terminated, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational readiness status for duty assignment"
    - name: "base_id"
      expr: base_id
      comment: "Home base identifier for crew member"
    - name: "nationality_code"
      expr: nationality_code
      comment: "Crew member nationality code"
    - name: "medical_certificate_class"
      expr: medical_certificate_class
      comment: "Class of medical certificate held"
    - name: "hire_year"
      expr: YEAR(date_of_hire)
      comment: "Year crew member was hired"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', date_of_hire)
      comment: "Month crew member was hired"
    - name: "license_expiry_year"
      expr: YEAR(license_expiry_date)
      comment: "Year license expires"
    - name: "medical_expiry_year"
      expr: YEAR(medical_certificate_expiry_date)
      comment: "Year medical certificate expires"
    - name: "union_membership_flag"
      expr: union_membership_flag
      comment: "Whether crew member is union member"
  measures:
    - name: "total_crew_members"
      expr: COUNT(DISTINCT member_id)
      comment: "Total distinct crew members for workforce capacity planning"
    - name: "total_flight_hours"
      expr: SUM(CAST(total_flight_hours AS DOUBLE))
      comment: "Cumulative flight hours across all crew members for experience assessment"
    - name: "avg_flight_hours_per_member"
      expr: AVG(CAST(total_flight_hours AS DOUBLE))
      comment: "Average flight hours per crew member indicating experience level"
    - name: "crew_with_expired_licenses"
      expr: COUNT(DISTINCT CASE WHEN license_expiry_date < CURRENT_DATE() THEN member_id END)
      comment: "Count of crew members with expired licenses requiring immediate action"
    - name: "crew_with_expired_medicals"
      expr: COUNT(DISTINCT CASE WHEN medical_certificate_expiry_date < CURRENT_DATE() THEN member_id END)
      comment: "Count of crew members with expired medical certificates impacting operational capacity"
    - name: "crew_license_expiring_30_days"
      expr: COUNT(DISTINCT CASE WHEN license_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN member_id END)
      comment: "Crew members with licenses expiring within 30 days for proactive renewal management"
    - name: "crew_medical_expiring_30_days"
      expr: COUNT(DISTINCT CASE WHEN medical_certificate_expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN member_id END)
      comment: "Crew members with medical certificates expiring within 30 days for scheduling intervention"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_absence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew absence and sick leave metrics tracking unplanned unavailability, replacement costs, and operational disruption for workforce reliability and cost management."
  source: "`airlines_ecm`.`crew`.`absence`"
  dimensions:
    - name: "absence_type"
      expr: absence_type
      comment: "Type of absence (sick leave, personal, injury, etc.)"
    - name: "absence_status"
      expr: absence_status
      comment: "Current status of absence record"
    - name: "crew_position"
      expr: crew_position
      comment: "Position of absent crew member"
    - name: "pay_status"
      expr: pay_status
      comment: "Pay status during absence (paid, unpaid, partial)"
    - name: "replacement_required_flag"
      expr: replacement_required_flag
      comment: "Whether replacement crew was required"
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Whether this is a recurring absence pattern"
    - name: "return_to_duty_clearance_flag"
      expr: return_to_duty_clearance_flag
      comment: "Whether return to duty clearance was obtained"
    - name: "absence_start_year"
      expr: YEAR(start_date)
      comment: "Year absence started"
    - name: "absence_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month absence started"
    - name: "base_id"
      expr: base_id
      comment: "Base where absence occurred"
  measures:
    - name: "total_absences"
      expr: COUNT(DISTINCT absence_id)
      comment: "Total absence events for reliability tracking"
    - name: "total_affected_flight_legs"
      expr: SUM(CAST(affected_flight_legs_count AS BIGINT))
      comment: "Total flight legs impacted by absences measuring operational disruption"
    - name: "total_affected_duty_periods"
      expr: SUM(CAST(affected_duty_periods_count AS BIGINT))
      comment: "Total duty periods affected by absences for scheduling impact assessment"
    - name: "absences_requiring_replacement"
      expr: COUNT(DISTINCT CASE WHEN replacement_required_flag = TRUE THEN absence_id END)
      comment: "Absences requiring crew replacement indicating reserve pool demand"
    - name: "recurring_absences"
      expr: COUNT(DISTINCT CASE WHEN recurrence_flag = TRUE THEN absence_id END)
      comment: "Recurring absence patterns requiring HR intervention"
    - name: "absences_without_clearance"
      expr: COUNT(DISTINCT CASE WHEN return_to_duty_clearance_flag = FALSE AND end_date < CURRENT_DATE() THEN absence_id END)
      comment: "Past absences without return-to-duty clearance indicating compliance risk"
    - name: "avg_affected_legs_per_absence"
      expr: AVG(CAST(affected_flight_legs_count AS DOUBLE))
      comment: "Average flight legs affected per absence event measuring disruption severity"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_training`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew training effectiveness and compliance metrics tracking completion rates, costs, pass rates, and regulatory currency for safety assurance and training investment optimization."
  source: "`airlines_ecm`.`crew`.`training_event`"
  dimensions:
    - name: "training_type_code"
      expr: training_type_code
      comment: "Type of training event"
    - name: "training_category"
      expr: training_category
      comment: "Training category classification"
    - name: "training_status"
      expr: training_status
      comment: "Current status of training event"
    - name: "training_result_code"
      expr: training_result_code
      comment: "Result of training (pass, fail, incomplete, etc.)"
    - name: "training_method"
      expr: training_method
      comment: "Method of training delivery (simulator, classroom, CBT, etc.)"
    - name: "crew_position_code"
      expr: crew_position_code
      comment: "Crew position being trained"
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether training is regulatory mandated"
    - name: "training_year"
      expr: YEAR(training_date)
      comment: "Year training occurred"
    - name: "training_month"
      expr: DATE_TRUNC('MONTH', training_date)
      comment: "Month training occurred"
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Aircraft type for type-specific training"
  measures:
    - name: "total_training_events"
      expr: COUNT(DISTINCT training_event_id)
      comment: "Total training events conducted for training program scale assessment"
    - name: "total_training_cost"
      expr: SUM(CAST(training_cost_amount AS DOUBLE))
      comment: "Total training expenditure for budget management and ROI analysis"
    - name: "total_training_hours"
      expr: SUM(CAST(training_duration_hours AS DOUBLE))
      comment: "Total training hours delivered measuring training program intensity"
    - name: "avg_training_cost_per_event"
      expr: AVG(CAST(training_cost_amount AS DOUBLE))
      comment: "Average cost per training event for cost efficiency benchmarking"
    - name: "avg_training_score"
      expr: AVG(CAST(training_score AS DOUBLE))
      comment: "Average training score indicating training effectiveness and crew competency"
    - name: "training_pass_count"
      expr: COUNT(DISTINCT CASE WHEN training_result_code = 'PASS' THEN training_event_id END)
      comment: "Count of passed training events for success rate calculation"
    - name: "training_fail_count"
      expr: COUNT(DISTINCT CASE WHEN training_result_code = 'FAIL' THEN training_event_id END)
      comment: "Count of failed training events indicating training quality issues"
    - name: "regulatory_training_events"
      expr: COUNT(DISTINCT CASE WHEN is_regulatory_required = TRUE THEN training_event_id END)
      comment: "Regulatory-mandated training events for compliance tracking"
    - name: "avg_training_duration_hours"
      expr: AVG(CAST(training_duration_hours AS DOUBLE))
      comment: "Average training duration per event for resource planning"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_duty_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight and duty time limitation (FTL) compliance and fatigue risk metrics tracking duty hours, rest periods, and regulatory violations for safety assurance and crew scheduling optimization."
  source: "`airlines_ecm`.`crew`.`duty_period`"
  dimensions:
    - name: "duty_type"
      expr: duty_type
      comment: "Type of duty period (flight duty, standby, training, etc.)"
    - name: "legality_status"
      expr: legality_status
      comment: "FTL legality status of duty period"
    - name: "fatigue_risk_level"
      expr: fatigue_risk_level
      comment: "Assessed fatigue risk level (low, medium, high, critical)"
    - name: "augmented_crew_flag"
      expr: augmented_crew_flag
      comment: "Whether duty period used augmented crew"
    - name: "split_duty_flag"
      expr: split_duty_flag
      comment: "Whether duty period was split with rest break"
    - name: "far_117_compliant_flag"
      expr: far_117_compliant_flag
      comment: "Whether duty period complies with FAR 117 regulations"
    - name: "easa_ftl_compliant_flag"
      expr: easa_ftl_compliant_flag
      comment: "Whether duty period complies with EASA FTL regulations"
    - name: "actual_flag"
      expr: actual_flag
      comment: "Whether duty period is actual (vs. planned)"
    - name: "scheduled_flag"
      expr: scheduled_flag
      comment: "Whether duty period was scheduled (vs. unscheduled callout)"
    - name: "duty_start_month"
      expr: DATE_TRUNC('MONTH', fdp_start_time)
      comment: "Month duty period started"
    - name: "base_id"
      expr: base_id
      comment: "Base for duty period"
  measures:
    - name: "total_duty_periods"
      expr: COUNT(DISTINCT duty_period_id)
      comment: "Total duty periods for operational volume tracking"
    - name: "total_duty_time_minutes"
      expr: SUM(CAST(total_duty_elapsed_time_minutes AS DOUBLE))
      comment: "Total duty time across all periods for workload assessment"
    - name: "total_fdp_time_minutes"
      expr: SUM(CAST(fdp_elapsed_time_minutes AS DOUBLE))
      comment: "Total flight duty period time for FTL compliance monitoring"
    - name: "avg_duty_time_minutes"
      expr: AVG(CAST(total_duty_elapsed_time_minutes AS DOUBLE))
      comment: "Average duty period duration for scheduling efficiency"
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score indicating crew fatigue exposure for safety management"
    - name: "high_fatigue_risk_duty_periods"
      expr: COUNT(DISTINCT CASE WHEN fatigue_risk_level IN ('HIGH', 'CRITICAL') THEN duty_period_id END)
      comment: "Duty periods with high fatigue risk requiring mitigation"
    - name: "ftl_violations"
      expr: COUNT(DISTINCT CASE WHEN legality_status = 'VIOLATION' THEN duty_period_id END)
      comment: "FTL regulatory violations requiring investigation and corrective action"
    - name: "non_compliant_far117_duty_periods"
      expr: COUNT(DISTINCT CASE WHEN far_117_compliant_flag = FALSE THEN duty_period_id END)
      comment: "Duty periods non-compliant with FAR 117 indicating regulatory risk"
    - name: "non_compliant_easa_duty_periods"
      expr: COUNT(DISTINCT CASE WHEN easa_ftl_compliant_flag = FALSE THEN duty_period_id END)
      comment: "Duty periods non-compliant with EASA FTL indicating regulatory risk"
    - name: "avg_rest_period_before_minutes"
      expr: AVG(CAST(rest_period_before_minutes AS DOUBLE))
      comment: "Average rest period before duty for fatigue management assessment"
    - name: "avg_rest_period_after_minutes"
      expr: AVG(CAST(rest_period_after_minutes AS DOUBLE))
      comment: "Average rest period after duty for recovery adequacy assessment"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_pairing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew pairing optimization and cost metrics tracking pairing efficiency, crew utilization, fatigue exposure, and pairing costs for crew scheduling optimization and cost control."
  source: "`airlines_ecm`.`crew`.`pairing`"
  dimensions:
    - name: "pairing_type"
      expr: pairing_type
      comment: "Type of pairing (line, reserve, training, etc.)"
    - name: "pairing_status"
      expr: pairing_status
      comment: "Current status of pairing"
    - name: "legality_status"
      expr: legality_status
      comment: "FTL legality status of pairing"
    - name: "crew_position"
      expr: crew_position
      comment: "Crew position for pairing"
    - name: "international_flag"
      expr: international_flag
      comment: "Whether pairing includes international segments"
    - name: "red_eye_flag"
      expr: red_eye_flag
      comment: "Whether pairing includes red-eye flights"
    - name: "premium_pay_flag"
      expr: premium_pay_flag
      comment: "Whether pairing qualifies for premium pay"
    - name: "pairing_start_month"
      expr: DATE_TRUNC('MONTH', start_datetime)
      comment: "Month pairing starts"
    - name: "base_id"
      expr: base_id
      comment: "Base for pairing"
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Aircraft type for pairing"
  measures:
    - name: "total_pairings"
      expr: COUNT(DISTINCT pairing_id)
      comment: "Total pairings for crew scheduling volume assessment"
    - name: "total_pairing_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total pairing cost for crew cost management and budget control"
    - name: "total_hotel_cost"
      expr: SUM(CAST(hotel_cost AS DOUBLE))
      comment: "Total hotel costs for layover expense management"
    - name: "total_per_diem"
      expr: SUM(CAST(per_diem_amount AS DOUBLE))
      comment: "Total per diem paid for crew expense tracking"
    - name: "total_block_hours"
      expr: SUM(CAST(total_block_hours AS DOUBLE))
      comment: "Total block hours across all pairings for productivity measurement"
    - name: "total_credit_hours"
      expr: SUM(CAST(total_credit_hours AS DOUBLE))
      comment: "Total credit hours for crew pay calculation"
    - name: "total_duty_hours"
      expr: SUM(CAST(total_duty_hours AS DOUBLE))
      comment: "Total duty hours for workload and FTL compliance tracking"
    - name: "avg_pairing_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per pairing for cost efficiency benchmarking"
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score across pairings for safety risk management"
    - name: "avg_time_away_from_base_hours"
      expr: AVG(CAST(time_away_from_base_hours AS DOUBLE))
      comment: "Average time away from base per pairing for quality of life assessment"
    - name: "pairings_with_ftl_violations"
      expr: COUNT(DISTINCT CASE WHEN legality_status = 'VIOLATION' THEN pairing_id END)
      comment: "Pairings with FTL violations requiring re-optimization"
    - name: "premium_pay_pairings"
      expr: COUNT(DISTINCT CASE WHEN premium_pay_flag = TRUE THEN pairing_id END)
      comment: "Pairings qualifying for premium pay impacting crew costs"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew qualification currency and recency metrics tracking type ratings, endorsements, and qualification expiry for operational capability planning and regulatory compliance."
  source: "`airlines_ecm`.`crew`.`qualification`"
  dimensions:
    - name: "qualification_category"
      expr: qualification_category
      comment: "Category of qualification (type rating, endorsement, etc.)"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current status of qualification"
    - name: "recency_status"
      expr: recency_status
      comment: "Recency status (current, expiring, expired)"
    - name: "position_code"
      expr: position_code
      comment: "Position for which qualification applies"
    - name: "is_pic_qualified"
      expr: is_pic_qualified
      comment: "Whether qualified as pilot in command"
    - name: "is_sic_qualified"
      expr: is_sic_qualified
      comment: "Whether qualified as second in command"
    - name: "aircraft_type_id"
      expr: aircraft_type_id
      comment: "Aircraft type for qualification"
    - name: "qualification_year"
      expr: YEAR(effective_date)
      comment: "Year qualification became effective"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year qualification expires"
  measures:
    - name: "total_qualifications"
      expr: COUNT(DISTINCT qualification_id)
      comment: "Total qualifications held for crew capability assessment"
    - name: "total_flight_hours_qualified"
      expr: SUM(CAST(flight_hours AS DOUBLE))
      comment: "Total flight hours on qualification for experience tracking"
    - name: "total_simulator_hours"
      expr: SUM(CAST(simulator_hours AS DOUBLE))
      comment: "Total simulator hours for training investment tracking"
    - name: "avg_flight_hours_per_qualification"
      expr: AVG(CAST(flight_hours AS DOUBLE))
      comment: "Average flight hours per qualification indicating experience depth"
    - name: "expired_qualifications"
      expr: COUNT(DISTINCT CASE WHEN expiry_date < CURRENT_DATE() THEN qualification_id END)
      comment: "Expired qualifications requiring renewal to restore operational capacity"
    - name: "qualifications_expiring_30_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 30) THEN qualification_id END)
      comment: "Qualifications expiring within 30 days for proactive renewal scheduling"
    - name: "pic_qualified_count"
      expr: COUNT(DISTINCT CASE WHEN is_pic_qualified = TRUE THEN qualification_id END)
      comment: "PIC qualifications for captain capacity planning"
    - name: "sic_qualified_count"
      expr: COUNT(DISTINCT CASE WHEN is_sic_qualified = TRUE THEN qualification_id END)
      comment: "SIC qualifications for first officer capacity planning"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_roster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew roster efficiency and workload metrics tracking duty days, credited hours, fatigue exposure, and roster legality for crew utilization optimization and work-life balance management."
  source: "`airlines_ecm`.`crew`.`roster`"
  dimensions:
    - name: "roster_status"
      expr: roster_status
      comment: "Current status of roster"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of roster"
    - name: "roster_source"
      expr: roster_source
      comment: "Source of roster (PBS, manual, optimizer, etc.)"
    - name: "crew_position"
      expr: crew_position
      comment: "Crew position for roster"
    - name: "legality_check_status"
      expr: legality_check_status
      comment: "FTL legality check status"
    - name: "union_compliance_flag"
      expr: union_compliance_flag
      comment: "Whether roster complies with union agreements"
    - name: "bid_period_year"
      expr: bid_period_year
      comment: "Year of bid period"
    - name: "bid_period_month"
      expr: bid_period_month
      comment: "Month of bid period"
    - name: "base_id"
      expr: base_id
      comment: "Base for roster"
  measures:
    - name: "total_rosters"
      expr: COUNT(DISTINCT roster_id)
      comment: "Total rosters for crew scheduling volume tracking"
    - name: "total_credited_block_hours"
      expr: SUM(CAST(total_credited_block_hours AS DOUBLE))
      comment: "Total credited block hours for crew productivity and pay calculation"
    - name: "total_duty_hours"
      expr: SUM(CAST(total_duty_hours AS DOUBLE))
      comment: "Total duty hours for workload assessment"
    - name: "total_duty_days"
      expr: SUM(CAST(total_duty_days AS BIGINT))
      comment: "Total duty days for crew utilization measurement"
    - name: "total_days_off"
      expr: SUM(CAST(days_off_count AS BIGINT))
      comment: "Total days off for work-life balance assessment"
    - name: "total_reserve_days"
      expr: SUM(CAST(reserve_days_count AS BIGINT))
      comment: "Total reserve days for reserve pool utilization tracking"
    - name: "avg_credited_block_hours"
      expr: AVG(CAST(total_credited_block_hours AS DOUBLE))
      comment: "Average credited block hours per roster for productivity benchmarking"
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score across rosters for safety risk management"
    - name: "rosters_with_legality_issues"
      expr: COUNT(DISTINCT CASE WHEN legality_check_status = 'VIOLATION' THEN roster_id END)
      comment: "Rosters with FTL legality violations requiring correction"
    - name: "non_union_compliant_rosters"
      expr: COUNT(DISTINCT CASE WHEN union_compliance_flag = FALSE THEN roster_id END)
      comment: "Rosters non-compliant with union agreements indicating labor relations risk"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`crew_swap_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew swap request and schedule flexibility metrics tracking swap approval rates, legality compliance, and crew satisfaction for schedule flexibility management and operational agility."
  source: "`airlines_ecm`.`crew`.`swap_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of swap request"
    - name: "swap_type"
      expr: swap_type
      comment: "Type of swap (trip trade, day swap, etc.)"
    - name: "legality_check_status"
      expr: legality_check_status
      comment: "FTL legality check status for swap"
    - name: "qualification_check_status"
      expr: qualification_check_status
      comment: "Qualification check status for swap"
    - name: "target_response"
      expr: target_response
      comment: "Response from target crew member"
    - name: "mutual_swap_flag"
      expr: mutual_swap_flag
      comment: "Whether swap is mutual (both parties trading)"
    - name: "system_generated_flag"
      expr: system_generated_flag
      comment: "Whether swap was system-generated (vs. crew-initiated)"
    - name: "requires_qualification_check"
      expr: requires_qualification_check
      comment: "Whether swap requires qualification verification"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month swap was requested"
  measures:
    - name: "total_swap_requests"
      expr: COUNT(DISTINCT swap_request_id)
      comment: "Total swap requests for schedule flexibility demand assessment"
    - name: "approved_swap_requests"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'APPROVED' THEN swap_request_id END)
      comment: "Approved swap requests for flexibility accommodation measurement"
    - name: "rejected_swap_requests"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'REJECTED' THEN swap_request_id END)
      comment: "Rejected swap requests indicating flexibility constraints"
    - name: "swaps_with_legality_violations"
      expr: COUNT(DISTINCT CASE WHEN legality_check_status = 'VIOLATION' THEN swap_request_id END)
      comment: "Swap requests with FTL violations requiring rejection"
    - name: "swaps_with_qualification_issues"
      expr: COUNT(DISTINCT CASE WHEN qualification_check_status = 'FAIL' THEN swap_request_id END)
      comment: "Swap requests with qualification mismatches requiring rejection"
    - name: "avg_fatigue_risk_score"
      expr: AVG(CAST(fatigue_risk_score AS DOUBLE))
      comment: "Average fatigue risk score for swap requests indicating safety impact"
    - name: "mutual_swaps"
      expr: COUNT(DISTINCT CASE WHEN mutual_swap_flag = TRUE THEN swap_request_id END)
      comment: "Mutual swap requests for crew collaboration measurement"
$$;