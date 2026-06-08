-- Metric views for domain: workforce | Business: Legal | Version: 1 | Generated on: 2026-05-07 11:54:14

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_timekeeper`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce productivity and utilization metrics for billable timekeepers including attorneys and paralegals"
  source: "`legal_ecm`.`workforce`.`timekeeper`"
  dimensions:
    - name: "timekeeper_type"
      expr: timekeeper_type
      comment: "Classification of timekeeper (attorney, paralegal, etc.)"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Career level (partner, senior associate, junior associate, etc.)"
    - name: "office_location"
      expr: office_location
      comment: "Geographic office where timekeeper is based"
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, on leave)"
    - name: "is_equity_partner"
      expr: is_equity_partner
      comment: "Flag indicating equity partner status"
    - name: "is_billing_timekeeper"
      expr: is_billing_timekeeper
      comment: "Flag indicating whether timekeeper bills clients"
    - name: "bar_admission_jurisdiction"
      expr: bar_admission_jurisdiction
      comment: "Primary jurisdiction where timekeeper is admitted to practice"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year timekeeper was hired"
  measures:
    - name: "total_timekeepers"
      expr: COUNT(DISTINCT timekeeper_id)
      comment: "Total number of unique timekeepers"
    - name: "total_billable_hours_target"
      expr: SUM(CAST(annual_billable_hours_target AS DOUBLE))
      comment: "Sum of annual billable hours targets across all timekeepers"
    - name: "avg_billable_hours_target"
      expr: AVG(CAST(annual_billable_hours_target AS DOUBLE))
      comment: "Average annual billable hours target per timekeeper"
    - name: "total_standard_rate_capacity"
      expr: SUM(CAST(standard_hourly_rate AS DOUBLE) * CAST(annual_billable_hours_target AS DOUBLE))
      comment: "Total revenue capacity at standard rates (rate × target hours)"
    - name: "avg_standard_hourly_rate"
      expr: AVG(CAST(standard_hourly_rate AS DOUBLE))
      comment: "Average standard hourly billing rate across timekeepers"
    - name: "total_cpd_hours_completed"
      expr: SUM(CAST(cpd_hours_completed AS DOUBLE))
      comment: "Total continuing professional development hours completed"
    - name: "cpd_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cpd_hours_completed >= cpd_hours_required THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of timekeepers meeting CPD requirements"
    - name: "avg_fte_percentage"
      expr: AVG(CAST(fte_percentage AS DOUBLE))
      comment: "Average full-time equivalent percentage across timekeepers"
    - name: "total_pro_bono_hours_target"
      expr: SUM(CAST(pro_bono_hours_target AS DOUBLE))
      comment: "Sum of pro bono hours targets across all timekeepers"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_matter_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Matter staffing, utilization, and realization metrics tracking timekeeper deployment and performance on client matters"
  source: "`legal_ecm`.`workforce`.`matter_assignment`"
  dimensions:
    - name: "assignment_role"
      expr: assignment_role
      comment: "Role of timekeeper on the matter (lead, associate, support, etc.)"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment (active, completed, on hold)"
    - name: "billing_attorney_flag"
      expr: billing_attorney_flag
      comment: "Flag indicating whether timekeeper is the billing attorney"
    - name: "responsible_attorney_flag"
      expr: responsible_attorney_flag
      comment: "Flag indicating whether timekeeper is the responsible attorney"
    - name: "originating_attorney_flag"
      expr: originating_attorney_flag
      comment: "Flag indicating whether timekeeper originated the matter"
    - name: "pro_bono_flag"
      expr: pro_bono_flag
      comment: "Flag indicating whether this is a pro bono matter assignment"
    - name: "afa_flag"
      expr: afa_flag
      comment: "Flag indicating alternative fee arrangement"
    - name: "cross_border_flag"
      expr: cross_border_flag
      comment: "Flag indicating cross-border matter"
    - name: "assignment_year"
      expr: YEAR(start_date)
      comment: "Year the assignment started"
  measures:
    - name: "total_matter_assignments"
      expr: COUNT(1)
      comment: "Total number of matter assignments"
    - name: "total_budgeted_hours"
      expr: SUM(CAST(budgeted_hours AS DOUBLE))
      comment: "Sum of budgeted hours across all assignments"
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours_to_date AS DOUBLE))
      comment: "Sum of actual hours worked to date across all assignments"
    - name: "total_budgeted_fees"
      expr: SUM(CAST(budgeted_fees AS DOUBLE))
      comment: "Sum of budgeted fees across all assignments"
    - name: "hours_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_hours_to_date AS DOUBLE)) / NULLIF(SUM(CAST(budgeted_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of budgeted hours actually worked (actual/budget)"
    - name: "avg_billing_rate_override"
      expr: AVG(CAST(billing_rate_override AS DOUBLE))
      comment: "Average billing rate override across assignments"
    - name: "total_wip_hours_unbilled"
      expr: SUM(CAST(wip_hours_unbilled AS DOUBLE))
      comment: "Total work-in-progress hours not yet billed"
    - name: "total_pro_bono_committed_hours"
      expr: SUM(CAST(pro_bono_committed_hours AS DOUBLE))
      comment: "Total pro bono hours committed across assignments"
    - name: "total_pro_bono_delivered_hours"
      expr: SUM(CAST(pro_bono_delivered_hours AS DOUBLE))
      comment: "Total pro bono hours actually delivered"
    - name: "pro_bono_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(pro_bono_delivered_hours AS DOUBLE)) / NULLIF(SUM(CAST(pro_bono_committed_hours AS DOUBLE)), 0), 2)
      comment: "Percentage of committed pro bono hours delivered"
    - name: "total_cpd_hours_earned"
      expr: SUM(CAST(cpd_hours_earned AS DOUBLE))
      comment: "Total continuing professional development hours earned from matter work"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_billing_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing rate management and pricing metrics tracking rate structures, approvals, and discounting across timekeepers and matters"
  source: "`legal_ecm`.`workforce`.`billing_rate`"
  dimensions:
    - name: "rate_type"
      expr: rate_type
      comment: "Type of billing rate (standard, discounted, blended, fixed)"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate (active, pending, expired)"
    - name: "timekeeper_class"
      expr: timekeeper_class
      comment: "Classification of timekeeper for rate purposes"
    - name: "is_client_approved"
      expr: is_client_approved
      comment: "Flag indicating whether rate is approved by client"
    - name: "is_default_rate"
      expr: is_default_rate
      comment: "Flag indicating whether this is the default rate"
    - name: "is_pro_bono"
      expr: is_pro_bono
      comment: "Flag indicating pro bono rate (typically zero)"
    - name: "afa_arrangement_type"
      expr: afa_arrangement_type
      comment: "Type of alternative fee arrangement"
    - name: "rate_basis"
      expr: rate_basis
      comment: "Basis for the rate (hourly, fixed, contingency, etc.)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which rate is denominated"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year the rate became effective"
  measures:
    - name: "total_billing_rates"
      expr: COUNT(1)
      comment: "Total number of billing rate records"
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate_amount AS DOUBLE))
      comment: "Average hourly billing rate across all rate records"
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate_amount AS DOUBLE))
      comment: "Average standard (undiscounted) rate"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied to standard rates"
    - name: "rate_realization_rate"
      expr: ROUND(100.0 * AVG(CAST(hourly_rate_amount AS DOUBLE)) / NULLIF(AVG(CAST(standard_rate_amount AS DOUBLE)), 0), 2)
      comment: "Average rate realization (billed rate as percentage of standard rate)"
    - name: "avg_rate_cap"
      expr: AVG(CAST(rate_cap_amount AS DOUBLE))
      comment: "Average rate cap amount across capped arrangements"
    - name: "client_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_client_approved = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rates approved by clients"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_compensation_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compensation and reward metrics tracking base salary, bonuses, equity, and total cash compensation across the workforce"
  source: "`legal_ecm`.`workforce`.`compensation_record`"
  dimensions:
    - name: "compensation_type"
      expr: compensation_type
      comment: "Type of compensation (base, bonus, equity, draw)"
    - name: "compensation_year"
      expr: compensation_year
      comment: "Year for which compensation applies"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of compensation record"
    - name: "is_equity_partner"
      expr: is_equity_partner
      comment: "Flag indicating equity partner status"
    - name: "equity_partner_tier_name"
      expr: equity_partner_tier_name
      comment: "Tier name for equity partners"
    - name: "fte_status"
      expr: fte_status
      comment: "Full-time equivalent status"
    - name: "job_title"
      expr: job_title
      comment: "Job title associated with compensation"
    - name: "performance_rating"
      expr: performance_rating
      comment: "Performance rating influencing compensation"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which compensation is paid"
    - name: "office_code"
      expr: office_code
      comment: "Office location code"
  measures:
    - name: "total_compensation_records"
      expr: COUNT(1)
      comment: "Total number of compensation records"
    - name: "total_base_salary"
      expr: SUM(CAST(base_salary AS DOUBLE))
      comment: "Sum of base salaries across all records"
    - name: "avg_base_salary"
      expr: AVG(CAST(base_salary AS DOUBLE))
      comment: "Average base salary per record"
    - name: "total_bonus_actual"
      expr: SUM(CAST(bonus_actual_amount AS DOUBLE))
      comment: "Sum of actual bonuses paid"
    - name: "total_bonus_target"
      expr: SUM(CAST(bonus_target_amount AS DOUBLE))
      comment: "Sum of target bonus amounts"
    - name: "bonus_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(bonus_actual_amount AS DOUBLE)) / NULLIF(SUM(CAST(bonus_target_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of target bonus actually paid (actual/target)"
    - name: "total_cash_compensation"
      expr: SUM(CAST(total_cash_compensation AS DOUBLE))
      comment: "Sum of total cash compensation (base + bonus + other cash)"
    - name: "avg_total_cash_compensation"
      expr: AVG(CAST(total_cash_compensation AS DOUBLE))
      comment: "Average total cash compensation per record"
    - name: "total_equity_partner_points"
      expr: SUM(CAST(equity_partner_points AS DOUBLE))
      comment: "Sum of equity partner points allocated"
    - name: "avg_profit_share_pct"
      expr: AVG(CAST(profit_share_pct AS DOUBLE))
      comment: "Average profit sharing percentage"
    - name: "avg_merit_increase_pct"
      expr: AVG(CAST(merit_increase_pct AS DOUBLE))
      comment: "Average merit increase percentage"
    - name: "total_deferred_compensation"
      expr: SUM(CAST(deferred_compensation AS DOUBLE))
      comment: "Sum of deferred compensation amounts"
    - name: "total_capital_contribution"
      expr: SUM(CAST(capital_contribution AS DOUBLE))
      comment: "Sum of capital contributions (typically for partners)"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_performance_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance evaluation and productivity metrics tracking billable hours, realization, utilization, and ratings across review cycles"
  source: "`legal_ecm`.`workforce`.`performance_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of performance review (annual, mid-year, probation)"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review (draft, submitted, completed)"
    - name: "review_cycle_year"
      expr: review_cycle_year
      comment: "Year of the review cycle"
    - name: "overall_rating_label"
      expr: overall_rating_label
      comment: "Label for overall performance rating (exceeds, meets, below)"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of reviewee"
    - name: "fte_status"
      expr: fte_status
      comment: "Full-time equivalent status"
    - name: "partnership_track_eligible"
      expr: partnership_track_eligible
      comment: "Flag indicating partnership track eligibility"
    - name: "promotion_recommended"
      expr: promotion_recommended
      comment: "Flag indicating promotion recommendation"
    - name: "compensation_adjustment_recommended"
      expr: compensation_adjustment_recommended
      comment: "Flag indicating compensation adjustment recommendation"
    - name: "performance_improvement_plan_required"
      expr: performance_improvement_plan_required
      comment: "Flag indicating performance improvement plan requirement"
  measures:
    - name: "total_performance_reviews"
      expr: COUNT(1)
      comment: "Total number of performance reviews"
    - name: "total_billable_hours_achieved"
      expr: SUM(CAST(billable_hours_achieved AS DOUBLE))
      comment: "Sum of billable hours achieved across all reviews"
    - name: "total_billable_hours_target"
      expr: SUM(CAST(billable_hours_target AS DOUBLE))
      comment: "Sum of billable hours targets across all reviews"
    - name: "billable_hours_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(billable_hours_achieved AS DOUBLE)) / NULLIF(SUM(CAST(billable_hours_target AS DOUBLE)), 0), 2)
      comment: "Percentage of billable hours target achieved (actual/target)"
    - name: "avg_utilization_rate_actual"
      expr: AVG(CAST(utilization_rate_actual AS DOUBLE))
      comment: "Average actual utilization rate across reviews"
    - name: "avg_utilization_rate_target"
      expr: AVG(CAST(utilization_rate_target AS DOUBLE))
      comment: "Average target utilization rate across reviews"
    - name: "avg_realization_rate"
      expr: AVG(CAST(realization_rate AS DOUBLE))
      comment: "Average realization rate (billed/standard) across reviews"
    - name: "avg_collection_rate"
      expr: AVG(CAST(collection_rate AS DOUBLE))
      comment: "Average collection rate (collected/billed) across reviews"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall performance rating score"
    - name: "avg_leadership_rating"
      expr: AVG(CAST(leadership_rating AS DOUBLE))
      comment: "Average leadership rating score"
    - name: "avg_client_feedback_score"
      expr: AVG(CAST(client_feedback_score AS DOUBLE))
      comment: "Average client feedback score"
    - name: "total_origination_credit"
      expr: SUM(CAST(origination_credit_amount AS DOUBLE))
      comment: "Sum of origination credit amounts (new business generation)"
    - name: "total_pro_bono_hours_delivered"
      expr: SUM(CAST(pro_bono_hours_delivered AS DOUBLE))
      comment: "Sum of pro bono hours delivered"
    - name: "pro_bono_attainment_rate"
      expr: ROUND(100.0 * SUM(CAST(pro_bono_hours_delivered AS DOUBLE)) / NULLIF(SUM(CAST(pro_bono_hours_target AS DOUBLE)), 0), 2)
      comment: "Percentage of pro bono hours target achieved"
    - name: "promotion_recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN promotion_recommended = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews recommending promotion"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_cle_completion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Continuing legal education compliance and professional development metrics tracking credit hours, completion rates, and accreditation"
  source: "`legal_ecm`.`workforce`.`cle_completion`"
  dimensions:
    - name: "completion_status"
      expr: completion_status
      comment: "Status of CLE completion (completed, in progress, failed)"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Accreditation status of the course"
    - name: "course_category"
      expr: course_category
      comment: "Category of CLE course"
    - name: "practice_area"
      expr: practice_area
      comment: "Practice area focus of the course"
    - name: "delivery_format"
      expr: delivery_format
      comment: "Format of course delivery (in-person, online, webinar)"
    - name: "is_ethics_credit"
      expr: is_ethics_credit
      comment: "Flag indicating ethics credit"
    - name: "is_diversity_equity_inclusion_credit"
      expr: is_diversity_equity_inclusion_credit
      comment: "Flag indicating diversity, equity, and inclusion credit"
    - name: "is_technology_credit"
      expr: is_technology_credit
      comment: "Flag indicating technology credit"
    - name: "is_firm_sponsored"
      expr: is_firm_sponsored
      comment: "Flag indicating firm-sponsored course"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating mandatory course"
    - name: "reporting_jurisdiction"
      expr: reporting_jurisdiction
      comment: "Jurisdiction to which credits are reported"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the course was completed"
  measures:
    - name: "total_cle_completions"
      expr: COUNT(1)
      comment: "Total number of CLE course completions"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Sum of all CLE credit hours earned"
    - name: "avg_credit_hours_per_completion"
      expr: AVG(CAST(credit_hours AS DOUBLE))
      comment: "Average credit hours per course completion"
    - name: "total_ethics_credit_hours"
      expr: SUM(CAST(ethics_credit_hours AS DOUBLE))
      comment: "Sum of ethics credit hours earned"
    - name: "total_dei_credit_hours"
      expr: SUM(CAST(diversity_equity_inclusion_credit_hours AS DOUBLE))
      comment: "Sum of diversity, equity, and inclusion credit hours earned"
    - name: "total_technology_credit_hours"
      expr: SUM(CAST(technology_credit_hours AS DOUBLE))
      comment: "Sum of technology credit hours earned"
    - name: "total_cle_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Sum of total cost for CLE courses"
    - name: "avg_cle_cost_per_completion"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per CLE course completion"
    - name: "firm_sponsored_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_firm_sponsored = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CLE courses that are firm-sponsored"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN completion_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CLE courses successfully completed"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_practice_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Practice group performance and capacity metrics tracking headcount, revenue targets, and organizational structure"
  source: "`legal_ecm`.`workforce`.`practice_group`"
  dimensions:
    - name: "group_name"
      expr: group_name
      comment: "Name of the practice group"
    - name: "practice_group_status"
      expr: practice_group_status
      comment: "Current status of the practice group (active, inactive, dissolved)"
    - name: "department_type"
      expr: department_type
      comment: "Type of department"
    - name: "jurisdiction_primary"
      expr: jurisdiction_primary
      comment: "Primary jurisdiction for the practice group"
    - name: "region_scope"
      expr: region_scope
      comment: "Geographic region scope"
    - name: "afa_eligible"
      expr: afa_eligible
      comment: "Flag indicating eligibility for alternative fee arrangements"
    - name: "lpp_classification"
      expr: lpp_classification
      comment: "Legal professional privilege classification"
    - name: "succession_plan_status"
      expr: succession_plan_status
      comment: "Status of succession planning for the group"
  measures:
    - name: "total_practice_groups"
      expr: COUNT(1)
      comment: "Total number of practice groups"
    - name: "total_approved_fte"
      expr: SUM(CAST(approved_fte_count AS DOUBLE))
      comment: "Sum of approved full-time equivalent positions"
    - name: "avg_approved_fte_per_group"
      expr: AVG(CAST(approved_fte_count AS DOUBLE))
      comment: "Average approved FTE per practice group"
    - name: "total_revenue_target"
      expr: SUM(CAST(revenue_target_amount AS DOUBLE))
      comment: "Sum of revenue targets across all practice groups"
    - name: "avg_revenue_target_per_group"
      expr: AVG(CAST(revenue_target_amount AS DOUBLE))
      comment: "Average revenue target per practice group"
    - name: "total_wip_writeoff_authority"
      expr: SUM(CAST(wip_write_off_authority_limit AS DOUBLE))
      comment: "Sum of work-in-progress write-off authority limits"
    - name: "avg_cle_requirement_hours"
      expr: AVG(CAST(cle_requirement_hours AS DOUBLE))
      comment: "Average CLE requirement hours per practice group"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_recruitment_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Talent acquisition and hiring pipeline metrics tracking open positions, time-to-fill, and recruitment outcomes"
  source: "`legal_ecm`.`workforce`.`recruitment_requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (open, filled, cancelled)"
    - name: "position_type"
      expr: position_type
      comment: "Type of position (attorney, paralegal, staff)"
    - name: "employment_type"
      expr: employment_type
      comment: "Type of employment (full-time, part-time, contract)"
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of the position"
    - name: "office_location"
      expr: office_location
      comment: "Office location for the position"
    - name: "replacement_or_new_flag"
      expr: replacement_or_new_flag
      comment: "Flag indicating whether position is replacement or new headcount"
    - name: "requisition_priority"
      expr: requisition_priority
      comment: "Priority level of the requisition"
    - name: "offer_extended_flag"
      expr: offer_extended_flag
      comment: "Flag indicating whether offer has been extended"
    - name: "offer_outcome"
      expr: offer_outcome
      comment: "Outcome of offer (accepted, declined, pending)"
    - name: "sourcing_channel"
      expr: sourcing_channel
      comment: "Channel through which candidates are sourced"
    - name: "bar_admission_required_flag"
      expr: bar_admission_required_flag
      comment: "Flag indicating bar admission requirement"
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of recruitment requisitions"
    - name: "total_approved_headcount"
      expr: SUM(CAST(approved_headcount AS DOUBLE))
      comment: "Sum of approved headcount across all requisitions"
    - name: "avg_salary_band_min"
      expr: AVG(CAST(salary_band_min AS DOUBLE))
      comment: "Average minimum salary band across requisitions"
    - name: "avg_salary_band_max"
      expr: AVG(CAST(salary_band_max AS DOUBLE))
      comment: "Average maximum salary band across requisitions"
    - name: "offer_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offer_outcome = 'accepted' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN offer_extended_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of offers accepted (accepted offers / total offers extended)"
    - name: "avg_current_pipeline_count"
      expr: AVG(CAST(current_pipeline_count AS DOUBLE))
      comment: "Average number of candidates in pipeline per requisition"
$$;

CREATE OR REPLACE VIEW `legal_ecm`.`_metrics`.`workforce_leave_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce absence and leave management metrics tracking leave types, durations, and impact on capacity and compliance"
  source: "`legal_ecm`.`workforce`.`leave_record`"
  dimensions:
    - name: "leave_type"
      expr: leave_type
      comment: "Type of leave (vacation, sick, parental, sabbatical, etc.)"
    - name: "leave_status"
      expr: leave_status
      comment: "Current status of leave request (pending, approved, denied, completed)"
    - name: "is_paid"
      expr: is_paid
      comment: "Flag indicating whether leave is paid"
    - name: "is_intermittent"
      expr: is_intermittent
      comment: "Flag indicating intermittent leave"
    - name: "is_phased_return"
      expr: is_phased_return
      comment: "Flag indicating phased return to work"
    - name: "regulatory_leave_category"
      expr: regulatory_leave_category
      comment: "Regulatory category of leave (FMLA, statutory, etc.)"
    - name: "bar_compliance_risk_flag"
      expr: bar_compliance_risk_flag
      comment: "Flag indicating bar compliance risk due to leave"
    - name: "matter_impact_assessed"
      expr: matter_impact_assessed
      comment: "Flag indicating whether matter impact has been assessed"
    - name: "medical_certification_required"
      expr: medical_certification_required
      comment: "Flag indicating medical certification requirement"
    - name: "leave_year"
      expr: YEAR(approved_start_date)
      comment: "Year the leave started"
  measures:
    - name: "total_leave_records"
      expr: COUNT(1)
      comment: "Total number of leave records"
    - name: "total_approved_duration_days"
      expr: SUM(CAST(approved_duration_days AS DOUBLE))
      comment: "Sum of approved leave duration in days"
    - name: "avg_approved_duration_days"
      expr: AVG(CAST(approved_duration_days AS DOUBLE))
      comment: "Average approved leave duration in days"
    - name: "total_working_days_absent"
      expr: SUM(CAST(working_days_absent AS DOUBLE))
      comment: "Sum of working days absent across all leave records"
    - name: "total_billable_hours_target_impact"
      expr: SUM(CAST(billable_hours_target_impact AS DOUBLE))
      comment: "Sum of impact on billable hours targets due to leave"
    - name: "total_cpd_impact_hours"
      expr: SUM(CAST(cpd_impact_hours AS DOUBLE))
      comment: "Sum of CPD hours impacted by leave"
    - name: "total_payroll_adjustment"
      expr: SUM(CAST(payroll_adjustment_amount AS DOUBLE))
      comment: "Sum of payroll adjustments due to leave"
    - name: "leave_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN leave_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave requests approved"
    - name: "paid_leave_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_paid = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leave that is paid"
$$;