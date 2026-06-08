-- Metric views for domain: billing | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_student_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core student account financial health and collections metrics for institutional revenue management and risk assessment"
  source: "`education_ecm`.`billing`.`student_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the student account (active, closed, suspended, etc.)"
    - name: "account_type"
      expr: account_type
      comment: "Type classification of the student account"
    - name: "collections_status"
      expr: collections_status
      comment: "Current collections status indicating delinquency stage"
    - name: "has_registration_hold"
      expr: has_registration_hold
      comment: "Flag indicating if account has a registration hold preventing enrollment"
    - name: "has_transcript_hold"
      expr: has_transcript_hold
      comment: "Flag indicating if account has a transcript hold preventing credential release"
    - name: "has_graduation_hold"
      expr: has_graduation_hold
      comment: "Flag indicating if account has a graduation hold preventing degree conferral"
    - name: "payment_plan_enrolled"
      expr: payment_plan_enrolled
      comment: "Flag indicating if student is enrolled in a payment plan"
    - name: "third_party_billing_flag"
      expr: third_party_billing_flag
      comment: "Flag indicating if account has third-party sponsor billing arrangement"
    - name: "account_opened_year"
      expr: YEAR(account_opened_date)
      comment: "Year the student account was opened"
    - name: "account_opened_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month the student account was opened"
    - name: "last_payment_year_month"
      expr: DATE_TRUNC('MONTH', last_payment_date)
      comment: "Month of the most recent payment received"
  measures:
    - name: "total_student_accounts"
      expr: COUNT(1)
      comment: "Total number of student accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all student accounts"
    - name: "total_cumulative_charges"
      expr: SUM(CAST(cumulative_charges AS DOUBLE))
      comment: "Total cumulative charges billed to student accounts"
    - name: "total_cumulative_payments"
      expr: SUM(CAST(cumulative_payments AS DOUBLE))
      comment: "Total cumulative payments received from student accounts"
    - name: "total_cumulative_adjustments"
      expr: SUM(CAST(cumulative_adjustments AS DOUBLE))
      comment: "Total cumulative adjustments applied to student accounts"
    - name: "total_pending_charges"
      expr: SUM(CAST(pending_charges AS DOUBLE))
      comment: "Total pending charges not yet posted to student accounts"
    - name: "total_pending_financial_aid"
      expr: SUM(CAST(pending_financial_aid AS DOUBLE))
      comment: "Total pending financial aid expected to disburse"
    - name: "total_anticipated_balance"
      expr: SUM(CAST(anticipated_balance AS DOUBLE))
      comment: "Total anticipated balance after pending charges and aid are applied"
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per student account"
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average amount of the most recent payment per account"
    - name: "accounts_with_holds"
      expr: COUNT(CASE WHEN has_registration_hold = TRUE OR has_transcript_hold = TRUE OR has_graduation_hold = TRUE THEN 1 END)
      comment: "Number of student accounts with any type of hold"
    - name: "accounts_in_collections"
      expr: COUNT(CASE WHEN collections_status IS NOT NULL AND collections_status != '' THEN 1 END)
      comment: "Number of student accounts currently in collections"
    - name: "accounts_with_payment_plans"
      expr: COUNT(CASE WHEN payment_plan_enrolled = TRUE THEN 1 END)
      comment: "Number of student accounts enrolled in payment plans"
    - name: "accounts_with_third_party_billing"
      expr: COUNT(CASE WHEN third_party_billing_flag = TRUE THEN 1 END)
      comment: "Number of student accounts with third-party sponsor billing"
    - name: "distinct_students"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with accounts"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction metrics for cash flow analysis, payment method performance, and revenue recognition"
  source: "`education_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment transaction"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (credit card, ACH, check, cash, etc.)"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received (online, in-person, mail, etc.)"
    - name: "payer_type"
      expr: payer_type
      comment: "Type of payer (student, parent, sponsor, etc.)"
    - name: "card_type"
      expr: card_type
      comment: "Type of credit/debit card used for payment"
    - name: "is_refundable"
      expr: is_refundable
      comment: "Flag indicating if payment is eligible for refund"
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was made"
    - name: "payment_year_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was made"
    - name: "posted_year_month"
      expr: DATE_TRUNC('MONTH', posted_date)
      comment: "Month the payment was posted to the account"
    - name: "cleared_year_month"
      expr: DATE_TRUNC('MONTH', cleared_date)
      comment: "Month the payment cleared the bank"
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount received"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment amount after processing fees"
    - name: "total_processing_fees"
      expr: SUM(CAST(processing_fee AS DOUBLE))
      comment: "Total processing fees charged on payments"
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment amount converted to base currency"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
    - name: "avg_processing_fee"
      expr: AVG(CAST(processing_fee AS DOUBLE))
      comment: "Average processing fee per payment transaction"
    - name: "distinct_payers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students making payments"
    - name: "distinct_student_accounts_paid"
      expr: COUNT(DISTINCT student_account_id)
      comment: "Distinct count of student accounts receiving payments"
    - name: "reversed_payments"
      expr: COUNT(CASE WHEN primary_reversed_by_payment_id IS NOT NULL THEN 1 END)
      comment: "Number of payments that have been reversed"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_tuition_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tuition and fee charge metrics for revenue forecasting, pricing analysis, and enrollment yield management"
  source: "`education_ecm`.`billing`.`tuition_charge`"
  dimensions:
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the tuition charge"
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (tuition, fee, lab, technology, etc.)"
    - name: "billing_method"
      expr: billing_method
      comment: "Method used to calculate the charge (flat rate, per credit hour, etc.)"
    - name: "residency_classification"
      expr: residency_classification
      comment: "Residency classification affecting tuition rate (in-state, out-of-state, international)"
    - name: "program_level"
      expr: program_level
      comment: "Academic program level (undergraduate, graduate, doctoral, etc.)"
    - name: "student_type"
      expr: student_type
      comment: "Type of student (full-time, part-time, continuing education, etc.)"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category for financial reporting"
    - name: "is_refundable"
      expr: is_refundable
      comment: "Flag indicating if charge is eligible for refund"
    - name: "is_reportable_1098t"
      expr: is_reportable_1098t
      comment: "Flag indicating if charge is reportable on IRS Form 1098-T"
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the charge was assessed"
    - name: "posted_year_month"
      expr: DATE_TRUNC('MONTH', posted_date)
      comment: "Month the charge was posted to the student account"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the charge is due for payment"
  measures:
    - name: "total_charges"
      expr: COUNT(1)
      comment: "Total number of tuition and fee charges"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charge amount assessed"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after adjustments and waivers"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to charges"
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total waiver amount reducing charges"
    - name: "total_credit_hours"
      expr: SUM(CAST(credit_hours AS DOUBLE))
      comment: "Total credit hours associated with charges"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per transaction"
    - name: "avg_net_charge_amount"
      expr: AVG(CAST(net_charge_amount AS DOUBLE))
      comment: "Average net charge amount per transaction after adjustments"
    - name: "avg_rate_per_credit_hour"
      expr: AVG(CAST(rate_per_credit_hour AS DOUBLE))
      comment: "Average tuition rate per credit hour"
    - name: "distinct_students_charged"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with charges"
    - name: "distinct_courses_charged"
      expr: COUNT(DISTINCT course_id)
      comment: "Distinct count of courses generating charges"
    - name: "charges_with_waivers"
      expr: COUNT(CASE WHEN waiver_amount > 0 THEN 1 END)
      comment: "Number of charges with waivers applied"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund transaction metrics for cash outflow management, Title IV compliance, and student satisfaction analysis"
  source: "`education_ecm`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund transaction"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (overpayment, withdrawal, financial aid, etc.)"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue refund (check, ACH, wire, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Code indicating reason for refund"
    - name: "is_title_iv_refund"
      expr: is_title_iv_refund
      comment: "Flag indicating if refund is subject to Title IV return of funds calculation"
    - name: "is_reportable_1098t"
      expr: is_reportable_1098t
      comment: "Flag indicating if refund is reportable on IRS Form 1098-T"
    - name: "originating_credit_source"
      expr: originating_credit_source
      comment: "Source of the credit being refunded (payment, financial aid, adjustment, etc.)"
    - name: "refund_year_month"
      expr: DATE_TRUNC('MONTH', refund_date)
      comment: "Month the refund was issued"
    - name: "requested_year_month"
      expr: DATE_TRUNC('MONTH', requested_date)
      comment: "Month the refund was requested"
    - name: "processed_year_month"
      expr: DATE_TRUNC('MONTH', processed_date)
      comment: "Month the refund was processed"
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year associated with the refund"
    - name: "tax_year"
      expr: tax_year
      comment: "Tax year for IRS reporting"
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions"
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount refunded to students"
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction"
    - name: "distinct_students_refunded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students receiving refunds"
    - name: "title_iv_refunds"
      expr: COUNT(CASE WHEN is_title_iv_refund = TRUE THEN 1 END)
      comment: "Number of refunds subject to Title IV return of funds"
    - name: "total_title_iv_refund_amount"
      expr: SUM(CASE WHEN is_title_iv_refund = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of Title IV refunds"
    - name: "reportable_1098t_refunds"
      expr: COUNT(CASE WHEN is_reportable_1098t = TRUE THEN 1 END)
      comment: "Number of refunds reportable on IRS Form 1098-T"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan enrollment and performance metrics for affordability program management and default risk assessment"
  source: "`education_ecm`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (active, completed, defaulted, cancelled)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan offered"
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (monthly, bi-weekly, etc.)"
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Payment method type for installments"
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Flag indicating if automatic payments are enabled"
    - name: "enrollment_year_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month the payment plan was enrolled"
    - name: "approval_year_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the payment plan was approved"
    - name: "completion_year_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month the payment plan was completed"
    - name: "default_year_month"
      expr: DATE_TRUNC('MONTH', default_date)
      comment: "Month the payment plan defaulted"
  measures:
    - name: "total_payment_plans"
      expr: COUNT(1)
      comment: "Total number of payment plans"
    - name: "total_plan_amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total amount financed through payment plans"
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount paid on payment plans"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance_amount AS DOUBLE))
      comment: "Total outstanding balance remaining on payment plans"
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at enrollment"
    - name: "total_enrollment_fees"
      expr: SUM(CAST(enrollment_fee_amount AS DOUBLE))
      comment: "Total enrollment fees charged for payment plans"
    - name: "total_late_fees"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on payment plans"
    - name: "avg_plan_amount"
      expr: AVG(CAST(total_plan_amount AS DOUBLE))
      comment: "Average amount financed per payment plan"
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment amount per payment plan"
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate_percent AS DOUBLE))
      comment: "Average interest rate charged on payment plans"
    - name: "distinct_students_on_plans"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students enrolled in payment plans"
    - name: "completed_plans"
      expr: COUNT(CASE WHEN plan_status = 'completed' THEN 1 END)
      comment: "Number of payment plans successfully completed"
    - name: "defaulted_plans"
      expr: COUNT(CASE WHEN plan_status = 'defaulted' THEN 1 END)
      comment: "Number of payment plans that defaulted"
    - name: "cancelled_plans"
      expr: COUNT(CASE WHEN cancellation_date IS NOT NULL THEN 1 END)
      comment: "Number of payment plans cancelled"
    - name: "plans_with_autopay"
      expr: COUNT(CASE WHEN auto_pay_enabled_flag = TRUE THEN 1 END)
      comment: "Number of payment plans with automatic payments enabled"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_collections_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections case metrics for delinquency management, recovery performance, and bad debt forecasting"
  source: "`education_ecm`.`billing`.`collections_case`"
  dimensions:
    - name: "collections_status"
      expr: collections_status
      comment: "Current status of the collections case"
    - name: "collections_type"
      expr: collections_type
      comment: "Type of collections action (internal, external agency, legal, etc.)"
    - name: "aging_bucket_at_referral"
      expr: aging_bucket_at_referral
      comment: "Aging bucket of the debt at time of referral to collections"
    - name: "closure_reason"
      expr: closure_reason
      comment: "Reason the collections case was closed"
    - name: "legal_action_initiated"
      expr: legal_action_initiated
      comment: "Flag indicating if legal action was initiated"
    - name: "judgment_obtained"
      expr: judgment_obtained
      comment: "Flag indicating if a legal judgment was obtained"
    - name: "payment_plan_established"
      expr: payment_plan_established
      comment: "Flag indicating if a payment plan was established during collections"
    - name: "referral_year_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month the case was referred to collections"
    - name: "closure_year_month"
      expr: DATE_TRUNC('MONTH', closure_date)
      comment: "Month the collections case was closed"
    - name: "last_contact_year_month"
      expr: DATE_TRUNC('MONTH', last_contact_date)
      comment: "Month of the most recent contact attempt"
  measures:
    - name: "total_collections_cases"
      expr: COUNT(1)
      comment: "Total number of collections cases"
    - name: "total_delinquent_balance_at_referral"
      expr: SUM(CAST(delinquent_balance_at_referral AS DOUBLE))
      comment: "Total delinquent balance at time of referral to collections"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current outstanding balance in collections"
    - name: "total_recovered_amount"
      expr: SUM(CAST(total_recovered_amount AS DOUBLE))
      comment: "Total amount recovered through collections efforts"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled for less than full balance"
    - name: "total_judgment_amount"
      expr: SUM(CAST(judgment_amount AS DOUBLE))
      comment: "Total amount of legal judgments obtained"
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total commission paid to collections agencies"
    - name: "avg_delinquent_balance_at_referral"
      expr: AVG(CAST(delinquent_balance_at_referral AS DOUBLE))
      comment: "Average delinquent balance per case at referral"
    - name: "avg_recovered_amount"
      expr: AVG(CAST(total_recovered_amount AS DOUBLE))
      comment: "Average amount recovered per collections case"
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate charged by collections agencies"
    - name: "distinct_students_in_collections"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with collections cases"
    - name: "cases_with_legal_action"
      expr: COUNT(CASE WHEN legal_action_initiated = TRUE THEN 1 END)
      comment: "Number of cases where legal action was initiated"
    - name: "cases_with_judgment"
      expr: COUNT(CASE WHEN judgment_obtained = TRUE THEN 1 END)
      comment: "Number of cases where a legal judgment was obtained"
    - name: "cases_with_payment_plan"
      expr: COUNT(CASE WHEN payment_plan_established = TRUE THEN 1 END)
      comment: "Number of cases where a payment plan was established"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_account_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account hold metrics for registration management, compliance enforcement, and student service impact analysis"
  source: "`education_ecm`.`billing`.`account_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the account hold"
    - name: "hold_type"
      expr: hold_type
      comment: "Type of hold placed on the account"
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason the hold was placed"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the hold"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level for hold resolution"
    - name: "restricts_registration"
      expr: restricts_registration
      comment: "Flag indicating if hold prevents course registration"
    - name: "restricts_transcript"
      expr: restricts_transcript
      comment: "Flag indicating if hold prevents transcript release"
    - name: "restricts_diploma"
      expr: restricts_diploma
      comment: "Flag indicating if hold prevents diploma issuance"
    - name: "restricts_grades"
      expr: restricts_grades
      comment: "Flag indicating if hold prevents grade access"
    - name: "restricts_financial_aid"
      expr: restricts_financial_aid
      comment: "Flag indicating if hold prevents financial aid disbursement"
    - name: "collections_flag"
      expr: collections_flag
      comment: "Flag indicating if hold is related to collections"
    - name: "waiver_eligible_flag"
      expr: waiver_eligible_flag
      comment: "Flag indicating if hold is eligible for waiver"
    - name: "placed_year_month"
      expr: DATE_TRUNC('MONTH', placed_date)
      comment: "Month the hold was placed"
    - name: "release_year_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month the hold was released"
    - name: "academic_year"
      expr: academic_year
      comment: "Academic year associated with the hold"
  measures:
    - name: "total_account_holds"
      expr: COUNT(1)
      comment: "Total number of account holds"
    - name: "total_minimum_payment_amount"
      expr: SUM(CAST(minimum_payment_amount AS DOUBLE))
      comment: "Total minimum payment amount required to release holds"
    - name: "avg_minimum_payment_amount"
      expr: AVG(CAST(minimum_payment_amount AS DOUBLE))
      comment: "Average minimum payment amount per hold"
    - name: "distinct_students_with_holds"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students with account holds"
    - name: "holds_restricting_registration"
      expr: COUNT(CASE WHEN restricts_registration = TRUE THEN 1 END)
      comment: "Number of holds preventing course registration"
    - name: "holds_restricting_transcript"
      expr: COUNT(CASE WHEN restricts_transcript = TRUE THEN 1 END)
      comment: "Number of holds preventing transcript release"
    - name: "holds_restricting_diploma"
      expr: COUNT(CASE WHEN restricts_diploma = TRUE THEN 1 END)
      comment: "Number of holds preventing diploma issuance"
    - name: "holds_restricting_financial_aid"
      expr: COUNT(CASE WHEN restricts_financial_aid = TRUE THEN 1 END)
      comment: "Number of holds preventing financial aid disbursement"
    - name: "collections_related_holds"
      expr: COUNT(CASE WHEN collections_flag = TRUE THEN 1 END)
      comment: "Number of holds related to collections activity"
    - name: "waiver_eligible_holds"
      expr: COUNT(CASE WHEN waiver_eligible_flag = TRUE THEN 1 END)
      comment: "Number of holds eligible for waiver"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_late_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Late fee assessment and waiver metrics for policy compliance, student impact analysis, and revenue recognition"
  source: "`education_ecm`.`billing`.`late_fee`"
  dimensions:
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the late fee"
    - name: "fee_type"
      expr: fee_type
      comment: "Type of late fee assessed"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Status of any appeal submitted for the late fee"
    - name: "appeal_submitted_flag"
      expr: appeal_submitted_flag
      comment: "Flag indicating if an appeal was submitted"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating if the late fee was reversed"
    - name: "waiver_eligible_flag"
      expr: waiver_eligible_flag
      comment: "Flag indicating if the late fee is eligible for waiver"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Flag indicating if notification was sent to student"
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the late fee was assessed"
    - name: "posted_year_month"
      expr: DATE_TRUNC('MONTH', posted_date)
      comment: "Month the late fee was posted to the account"
    - name: "waiver_year_month"
      expr: DATE_TRUNC('MONTH', waiver_date)
      comment: "Month the late fee was waived"
  measures:
    - name: "total_late_fees"
      expr: COUNT(1)
      comment: "Total number of late fees assessed"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total gross late fee amount assessed"
    - name: "total_net_fee_amount"
      expr: SUM(CAST(net_fee_amount AS DOUBLE))
      comment: "Total net late fee amount after waivers"
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total amount of late fees waived"
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average late fee amount assessed"
    - name: "avg_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average late fee percentage rate"
    - name: "distinct_students_with_late_fees"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of students assessed late fees"
    - name: "late_fees_with_appeals"
      expr: COUNT(CASE WHEN appeal_submitted_flag = TRUE THEN 1 END)
      comment: "Number of late fees with appeals submitted"
    - name: "late_fees_reversed"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of late fees that were reversed"
    - name: "late_fees_waived"
      expr: COUNT(CASE WHEN waiver_amount > 0 THEN 1 END)
      comment: "Number of late fees with waivers applied"
    - name: "waiver_eligible_fees"
      expr: COUNT(CASE WHEN waiver_eligible_flag = TRUE THEN 1 END)
      comment: "Number of late fees eligible for waiver"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`billing_sponsor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Third-party sponsor invoice metrics for contract billing performance, receivables management, and partnership revenue tracking"
  source: "`education_ecm`.`billing`.`sponsor_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the sponsor invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the invoice"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the sponsor"
    - name: "invoice_year_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice payment is due"
    - name: "payment_received_year_month"
      expr: DATE_TRUNC('MONTH', payment_received_date)
      comment: "Month the invoice payment was received"
    - name: "billing_period_start_year_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Start month of the billing period"
  measures:
    - name: "total_sponsor_invoices"
      expr: COUNT(1)
      comment: "Total number of sponsor invoices issued"
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced to sponsors"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount paid by sponsors"
    - name: "total_balance_due"
      expr: SUM(CAST(balance_due AS DOUBLE))
      comment: "Total outstanding balance due from sponsors"
    - name: "total_tuition_amount"
      expr: SUM(CAST(tuition_amount AS DOUBLE))
      comment: "Total tuition amount billed to sponsors"
    - name: "total_fees_amount"
      expr: SUM(CAST(fees_amount AS DOUBLE))
      comment: "Total fees amount billed to sponsors"
    - name: "total_room_amount"
      expr: SUM(CAST(room_amount AS DOUBLE))
      comment: "Total room charges billed to sponsors"
    - name: "total_board_amount"
      expr: SUM(CAST(board_amount AS DOUBLE))
      comment: "Total board charges billed to sponsors"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to sponsor invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to sponsor invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_invoiced_amount AS DOUBLE))
      comment: "Average invoice amount per sponsor invoice"
    - name: "distinct_sponsors"
      expr: COUNT(DISTINCT sponsor_id)
      comment: "Distinct count of sponsors invoiced"
$$;