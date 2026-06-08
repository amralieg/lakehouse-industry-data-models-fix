-- Metric views for domain: spa | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core spa appointment performance metrics covering booking volume, no-show behaviour, cancellation patterns, prepayment capture, and intake-form compliance. Used by Spa Directors and Revenue Managers to steer scheduling efficiency and guest experience quality."
  source: "`travel_hospitality_ecm`.`spa`.`appointment`"
  dimensions:
    - name: "appointment_date"
      expr: appointment_date
      comment: "Calendar date of the appointment; primary time axis for trend analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current lifecycle status of the appointment (e.g. Confirmed, Completed, Cancelled, No-Show)."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (e.g. Online, Front Desk, Mobile App)."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided when an appointment was cancelled; used to identify avoidable cancellation drivers."
    - name: "guest_gender_preference"
      expr: guest_gender_preference
      comment: "Guest's stated therapist gender preference; informs staffing and scheduling decisions."
    - name: "pressure_preference"
      expr: pressure_preference
      comment: "Guest's preferred massage pressure level; used for personalisation and therapist matching."
    - name: "therapist_gender_preference"
      expr: therapist_gender_preference
      comment: "Guest's preferred therapist gender; used to assess fulfilment rate of gender-preference requests."
    - name: "intake_form_completed"
      expr: intake_form_completed
      comment: "Boolean flag indicating whether the guest completed the intake form prior to the appointment."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Boolean flag indicating the guest did not arrive for a confirmed appointment."
    - name: "prepayment_currency_code"
      expr: prepayment_currency_code
      comment: "Currency in which the prepayment was collected; supports multi-currency revenue analysis."
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointment records; baseline volume KPI for spa scheduling capacity utilisation."
    - name: "completed_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'Completed' THEN 1 END)
      comment: "Number of appointments that reached a Completed status; measures actual service delivery throughput."
    - name: "cancelled_appointments"
      expr: COUNT(CASE WHEN appointment_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled appointments; high values signal scheduling or demand-management issues."
    - name: "no_show_appointments"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Count of appointments where the guest did not arrive; directly impacts therapist utilisation and lost revenue."
    - name: "intake_form_completion_count"
      expr: COUNT(CASE WHEN intake_form_completed = TRUE THEN 1 END)
      comment: "Number of appointments where the intake form was completed; measures compliance with health and safety protocols."
    - name: "total_prepayment_amount"
      expr: SUM(CAST(prepayment_amount AS DOUBLE))
      comment: "Total prepayment revenue collected at booking; indicates advance cash capture and commitment level."
    - name: "avg_prepayment_amount"
      expr: AVG(CAST(prepayment_amount AS DOUBLE))
      comment: "Average prepayment amount per appointment; benchmarks prepayment policy effectiveness across channels."
    - name: "distinct_guests"
      expr: COUNT(DISTINCT appointment_guest_profile_id)
      comment: "Count of unique guests with appointments; measures spa reach and guest penetration within the property."
    - name: "distinct_therapists_utilised"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of distinct therapists assigned to appointments; supports workforce planning and load-balancing decisions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa revenue and charge-level financial metrics covering gross revenue, discounting, service charges, gratuity, and tax. Primary financial KPI layer for Spa Finance and Revenue Management teams."
  source: "`travel_hospitality_ecm`.`spa`.`charge`"
  dimensions:
    - name: "charge_date"
      expr: charge_date
      comment: "Date the charge was posted; primary time axis for daily and period revenue reporting."
    - name: "charge_type"
      expr: charge_type
      comment: "Classification of the charge (e.g. Treatment, Retail, Gratuity, Package); enables revenue-mix analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. Credit Card, Cash, Room Charge); informs payment-channel strategy."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the charge (e.g. Posted, Voided, Pending); used to filter to revenue-recognised charges."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge; required for multi-currency revenue consolidation."
    - name: "revenue_center_code"
      expr: revenue_center_code
      comment: "Revenue centre to which the charge is attributed; supports P&L reporting by spa sub-department."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the charge; links spa revenue to the finance chart of accounts."
    - name: "discount_code"
      expr: discount_code
      comment: "Discount code applied to the charge; used to measure promotional discount impact on revenue."
    - name: "gratuity_included_flag"
      expr: gratuity_included_flag
      comment: "Boolean indicating whether gratuity is included in the charge; used to separate net revenue from gratuity."
  measures:
    - name: "total_charge_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross charge revenue posted; primary spa revenue KPI used in P&L and executive dashboards."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all charges; measures promotional spend and its drag on net revenue."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected; a key ancillary revenue stream and cost-recovery metric."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on spa charges; required for tax compliance and remittance reporting."
    - name: "avg_charge_value"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average charge value per transaction; benchmarks spend-per-visit and informs upsell strategy."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across charged services; used to monitor pricing realisation vs. rack rate."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units of services or products charged; measures service volume independent of price."
    - name: "voided_charge_count"
      expr: COUNT(CASE WHEN voided_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of voided charges; elevated counts indicate operational errors or guest disputes requiring investigation."
    - name: "distinct_guests_charged"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles with spa charges; measures revenue-generating guest penetration."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership portfolio metrics covering active membership base, fee revenue, renewal health, discount exposure, and early-termination risk. Used by Spa Membership Sales and Finance teams to manage recurring revenue and retention."
  source: "`travel_hospitality_ecm`.`spa`.`membership`"
  dimensions:
    - name: "membership_type"
      expr: membership_type
      comment: "Type of spa membership (e.g. Annual, Monthly, Corporate); primary segmentation for portfolio analysis."
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the membership (e.g. Active, Suspended, Cancelled, Expired); used to track portfolio health."
    - name: "enrollment_date"
      expr: enrollment_date
      comment: "Date the membership was enrolled; used for cohort analysis and retention curve modelling."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Date the membership expires; used to identify upcoming renewals and at-risk members."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of membership fees; required for multi-currency recurring revenue reporting."
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for membership billing (e.g. Credit Card, Direct Debit); informs payment failure risk."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Boolean indicating whether the membership is set to auto-renew; key predictor of retention rate."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for membership cancellation; used to identify and address churn drivers."
    - name: "referral_source"
      expr: referral_source
      comment: "Source through which the member was referred; used to evaluate acquisition channel effectiveness."
  measures:
    - name: "total_memberships"
      expr: COUNT(1)
      comment: "Total membership records; baseline portfolio size KPI for membership programme management."
    - name: "active_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Active' THEN 1 END)
      comment: "Count of currently active memberships; primary recurring-revenue base metric for executive reporting."
    - name: "cancelled_memberships"
      expr: COUNT(CASE WHEN membership_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled memberships; used to calculate churn rate and assess retention programme effectiveness."
    - name: "auto_renewal_memberships"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of memberships enrolled in auto-renewal; higher counts reduce renewal friction and improve revenue predictability."
    - name: "total_annual_fee_revenue"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual membership fee revenue; primary recurring revenue KPI for the spa membership programme."
    - name: "total_monthly_fee_revenue"
      expr: SUM(CAST(monthly_fee AS DOUBLE))
      comment: "Total monthly membership fee revenue; used alongside annual fees to compute blended recurring revenue."
    - name: "avg_annual_fee"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual membership fee; benchmarks pricing tier performance and informs fee structure decisions."
    - name: "total_discount_exposure"
      expr: SUM(CAST(discount_percentage AS DOUBLE))
      comment: "Sum of discount percentages across memberships; measures total promotional discount exposure in the portfolio."
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees assessed; indicates revenue recovered from premature cancellations."
    - name: "distinct_members"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guest profiles holding memberships; measures true membership penetration across the guest base."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_membership_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa membership visit engagement metrics covering visit frequency, credit consumption, retail spend, gratuity, and no-show behaviour. Used by Spa Operations and Membership teams to assess member engagement and value realisation."
  source: "`travel_hospitality_ecm`.`spa`.`membership_visit`"
  dimensions:
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the membership visit; primary time axis for visit frequency and trend analysis."
    - name: "visit_status"
      expr: visit_status
      comment: "Status of the visit (e.g. Completed, Cancelled, No-Show); used to measure engagement quality."
    - name: "visit_type"
      expr: visit_type
      comment: "Type of membership visit (e.g. Treatment, Fitness Class, Facility Access); enables visit-mix analysis."
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Boolean flag for member no-shows; high rates indicate disengagement and wasted capacity."
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Boolean indicating whether the visit was complimentary; used to track comp visit costs."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for visit cancellation; used to identify operational or member-experience issues."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of visit-related charges; required for multi-currency spend analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total membership visits recorded; baseline engagement volume KPI for the membership programme."
    - name: "completed_visits"
      expr: COUNT(CASE WHEN visit_status = 'Completed' THEN 1 END)
      comment: "Number of completed membership visits; measures actual member engagement and service delivery."
    - name: "no_show_visits"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Count of member no-shows; directly impacts therapist utilisation and lost capacity revenue."
    - name: "total_credits_consumed"
      expr: SUM(CAST(credits_consumed AS DOUBLE))
      comment: "Total membership credits consumed across visits; measures credit utilisation rate and programme value delivery."
    - name: "avg_credits_per_visit"
      expr: AVG(CAST(credits_consumed AS DOUBLE))
      comment: "Average credits consumed per visit; benchmarks credit burn rate and informs credit package pricing."
    - name: "total_retail_purchase_amount"
      expr: SUM(CAST(retail_purchase_amount AS DOUBLE))
      comment: "Total retail spend by members during visits; measures ancillary revenue generated by the membership base."
    - name: "total_gratuity_amount"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected during membership visits; informs therapist compensation and guest satisfaction levels."
    - name: "avg_remaining_credit_balance"
      expr: AVG(CAST(remaining_credit_balance AS DOUBLE))
      comment: "Average remaining credit balance at visit time; low values indicate high engagement; high values signal under-utilisation risk."
    - name: "distinct_members_visited"
      expr: COUNT(DISTINCT membership_id)
      comment: "Number of distinct memberships with at least one visit; measures active engagement rate within the membership portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_therapist_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist workforce productivity and scheduling efficiency metrics covering utilisation, overtime, booked vs. available hours, and schedule variance. Used by Spa Operations Managers and HR to optimise staffing levels and labour costs."
  source: "`travel_hospitality_ecm`.`spa`.`therapist_schedule`"
  dimensions:
    - name: "schedule_date"
      expr: schedule_date
      comment: "Date of the therapist schedule; primary time axis for workforce planning and trend analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the schedule entry (e.g. Published, Confirmed, Cancelled); used to filter to active schedules."
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g. Morning, Evening, Split); used to analyse productivity by shift pattern."
    - name: "primary_treatment_specialty"
      expr: primary_treatment_specialty
      comment: "Primary treatment specialty assigned for the shift; used to match supply to treatment demand."
    - name: "overtime_eligible_flag"
      expr: overtime_eligible_flag
      comment: "Boolean indicating whether the therapist is eligible for overtime on this schedule; used for labour cost forecasting."
  measures:
    - name: "total_scheduled_hours"
      expr: SUM(CAST(total_scheduled_hours AS DOUBLE))
      comment: "Total therapist hours scheduled; baseline capacity supply metric for spa workforce planning."
    - name: "total_available_hours"
      expr: SUM(CAST(total_available_hours AS DOUBLE))
      comment: "Total therapist hours available for bookings after breaks; denominator for utilisation rate calculations."
    - name: "total_booked_hours"
      expr: SUM(CAST(total_booked_hours AS DOUBLE))
      comment: "Total therapist hours booked with appointments; numerator for utilisation rate; key capacity efficiency KPI."
    - name: "total_actual_hours_worked"
      expr: SUM(CAST(actual_hours_worked AS DOUBLE))
      comment: "Total actual hours worked by therapists; compared against scheduled hours to identify attendance variances."
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Total overtime hours incurred; elevated values signal understaffing or demand spikes requiring scheduling adjustment."
    - name: "avg_utilisation_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average therapist utilisation percentage across schedule entries; primary workforce efficiency KPI for spa operations."
    - name: "distinct_therapists_scheduled"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of distinct therapists scheduled; used to assess active workforce size and scheduling coverage."
    - name: "cancelled_schedules"
      expr: COUNT(CASE WHEN schedule_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled schedule entries; high counts indicate staffing instability or operational disruptions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_appointment_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spa package booking revenue and fulfilment metrics covering package revenue, discounting, tax, add-on services, and payment status. Used by Revenue Management and Spa Sales teams to evaluate package programme performance."
  source: "`travel_hospitality_ecm`.`spa`.`appointment_package`"
  dimensions:
    - name: "booking_date"
      expr: booking_date
      comment: "Date the package was booked; primary time axis for package sales trend analysis."
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the package booking (e.g. Confirmed, Completed, Cancelled); used to filter to active revenue."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the package was booked; used to evaluate channel contribution to package revenue."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the package (e.g. Paid, Pending, Refunded); used to identify outstanding receivables."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the package; informs payment channel strategy and fraud risk assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the package transaction; required for multi-currency revenue consolidation."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for package cancellation; used to identify and address avoidable cancellation drivers."
    - name: "redemption_status"
      expr: redemption_status
      comment: "Redemption status of the package (e.g. Redeemed, Partially Redeemed, Unredeemed); measures fulfilment rate."
  measures:
    - name: "total_package_bookings"
      expr: COUNT(1)
      comment: "Total spa package bookings; baseline volume KPI for package programme demand assessment."
    - name: "total_package_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from spa package bookings; primary package revenue KPI for executive and revenue management reporting."
    - name: "total_package_price"
      expr: SUM(CAST(package_price AS DOUBLE))
      comment: "Sum of base package prices before adjustments; used to measure rack-rate package revenue potential."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to package bookings; measures promotional investment and its impact on package yield."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on package bookings; required for tax compliance and remittance reporting."
    - name: "total_addon_services_amount"
      expr: SUM(CAST(addon_services_amount AS DOUBLE))
      comment: "Total add-on services revenue attached to packages; measures upsell effectiveness within the package programme."
    - name: "avg_package_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total package value per booking; benchmarks package yield and informs pricing strategy."
    - name: "distinct_guests_with_packages"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique guests who booked spa packages; measures package programme reach across the guest base."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_therapist`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist workforce quality and compensation metrics covering guest ratings, commission rates, hourly rates, and experience levels. Used by Spa HR and Operations to manage talent quality, compensation equity, and certification compliance."
  source: "`travel_hospitality_ecm`.`spa`.`therapist`"
  dimensions:
    - name: "therapist_status"
      expr: therapist_status
      comment: "Current employment status of the therapist (e.g. Active, On Leave, Terminated); used to filter to active workforce."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type (e.g. Full-Time, Part-Time, Contractor); used to analyse workforce composition and cost structure."
    - name: "certification_level"
      expr: certification_level
      comment: "Highest certification level held by the therapist; used to assess workforce quality and training investment needs."
    - name: "gender"
      expr: gender
      comment: "Therapist gender; used to assess gender-preference fulfilment capacity and workforce diversity."
    - name: "tip_eligible_flag"
      expr: tip_eligible_flag
      comment: "Boolean indicating whether the therapist is eligible to receive tips; used in compensation analysis."
    - name: "hire_date"
      expr: hire_date
      comment: "Date the therapist was hired; used for tenure analysis and workforce stability reporting."
  measures:
    - name: "total_therapists"
      expr: COUNT(1)
      comment: "Total therapist headcount; baseline workforce size KPI for spa staffing capacity planning."
    - name: "active_therapists"
      expr: COUNT(CASE WHEN therapist_status = 'Active' THEN 1 END)
      comment: "Number of currently active therapists; primary workforce availability metric for scheduling and capacity management."
    - name: "avg_guest_rating"
      expr: AVG(CAST(guest_rating_average AS DOUBLE))
      comment: "Average guest satisfaction rating across therapists; key quality KPI used to identify top performers and coaching needs."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate_percent AS DOUBLE))
      comment: "Average commission rate across therapists; used to benchmark compensation structure and manage labour cost."
    - name: "avg_hourly_rate"
      expr: AVG(CAST(hourly_rate AS DOUBLE))
      comment: "Average hourly rate across therapists; used for labour cost modelling and compensation equity analysis."
    - name: "avg_years_of_experience"
      expr: AVG(CAST(years_of_experience AS DOUBLE))
      comment: "Average years of experience across the therapist workforce; measures team seniority and informs training investment decisions."
    - name: "therapists_with_expiring_license"
      expr: COUNT(CASE WHEN primary_license_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND primary_license_expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of therapists whose primary license expires within 30 days; critical compliance risk metric requiring immediate HR action."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`spa_therapist_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Therapist certification compliance and training investment metrics covering certification status, continuing education progress, training hours, and cost. Used by Spa HR and Compliance teams to manage regulatory compliance and workforce development spend."
  source: "`travel_hospitality_ecm`.`spa`.`therapist_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. State License, Brand Certification, Specialty); used to segment compliance by requirement type."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of the certification (e.g. Basic, Advanced, Master); used to assess workforce skill depth."
    - name: "verification_status"
      expr: verification_status
      comment: "Current verification status of the certification (e.g. Verified, Pending, Expired); used for compliance monitoring."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification (e.g. Renewed, Due, Lapsed); used to identify at-risk compliance gaps."
    - name: "reimbursement_status"
      expr: reimbursement_status
      comment: "Status of employer reimbursement for certification cost; used to track training investment and reimbursement liability."
    - name: "is_brand_required"
      expr: is_brand_required
      comment: "Boolean indicating whether the certification is required by the brand standard; used to prioritise compliance actions."
    - name: "is_state_required"
      expr: is_state_required
      comment: "Boolean indicating whether the certification is a state regulatory requirement; critical for legal compliance tracking."
    - name: "specialty_area"
      expr: specialty_area
      comment: "Specialty area covered by the certification (e.g. Massage, Aesthetics, Hydrotherapy); used for skill-mix analysis."
    - name: "expiry_date"
      expr: expiry_date
      comment: "Expiry date of the certification; used to identify upcoming compliance renewals."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total certification records; baseline compliance portfolio size metric."
    - name: "verified_certifications"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Number of verified certifications; measures current compliance posture across the therapist workforce."
    - name: "expiring_certifications_30d"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "Certifications expiring within 30 days; critical compliance risk KPI requiring immediate renewal action."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications across the workforce; measures training and compliance investment spend."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification; benchmarks training investment efficiency and informs budget planning."
    - name: "total_training_hours"
      expr: SUM(CAST(training_hours AS DOUBLE))
      comment: "Total training hours invested in certifications; measures workforce development effort and informs L&D strategy."
    - name: "total_continuing_education_hours_completed"
      expr: SUM(CAST(continuing_education_hours_completed AS DOUBLE))
      comment: "Total continuing education hours completed; measures ongoing professional development compliance."
    - name: "total_continuing_education_hours_required"
      expr: SUM(CAST(continuing_education_hours_required AS DOUBLE))
      comment: "Total continuing education hours required; used as denominator to compute CE completion rate at portfolio level."
    - name: "distinct_therapists_certified"
      expr: COUNT(DISTINCT therapist_id)
      comment: "Number of distinct therapists with at least one certification record; measures certified workforce coverage."
$$;