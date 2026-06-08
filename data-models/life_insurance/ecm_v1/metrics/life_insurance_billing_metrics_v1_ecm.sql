-- Metric views for domain: billing | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_bill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing KPIs tracking premium billing performance, collection efficiency, and grace period risk across policies and accounts"
  source: "`life_insurance_ecm`.`billing`.`premium_bill`"
  dimensions:
    - name: "bill_status"
      expr: bill_status
      comment: "Current status of the premium bill (paid, outstanding, overdue, cancelled)"
    - name: "billing_mode"
      expr: billing_mode
      comment: "Frequency of billing (monthly, quarterly, annual, single)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (EFT, check, credit card, cash value)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the bill was delivered (email, postal mail, portal)"
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where the policy was issued, for regulatory and geographic analysis"
    - name: "bill_year"
      expr: YEAR(bill_date)
      comment: "Year the bill was issued"
    - name: "bill_month"
      expr: DATE_TRUNC('MONTH', bill_date)
      comment: "Month the bill was issued, for time-series trending"
    - name: "due_year_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the payment is due, for cash flow forecasting"
    - name: "apl_triggered_flag"
      expr: apl_triggered
      comment: "Whether automatic premium loan was triggered for this bill"
    - name: "group_bill_flag"
      expr: group_bill_indicator
      comment: "Whether this is a group billing arrangement"
    - name: "reinstatement_required_flag"
      expr: reinstatement_required
      comment: "Whether policy reinstatement is required"
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total premium amount billed across all bills, primary revenue metric"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid premium balance, key collection and cash flow metric"
    - name: "total_ape_amount"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total Annualized Premium Equivalent, standardized new business production metric"
    - name: "total_base_premium"
      expr: SUM(CAST(base_premium_amount AS DOUBLE))
      comment: "Total base premium excluding riders, core product revenue"
    - name: "total_rider_premium"
      expr: SUM(CAST(rider_premium_amount AS DOUBLE))
      comment: "Total rider premium, supplemental coverage revenue"
    - name: "total_coi_amount"
      expr: SUM(CAST(coi_amount AS DOUBLE))
      comment: "Total cost of insurance charges, key profitability component"
    - name: "total_apl_amount"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total automatic premium loan amount, lapse prevention metric"
    - name: "total_nsf_fees"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total non-sufficient funds fees collected, payment quality indicator"
    - name: "total_reinstatement_arrears"
      expr: SUM(CAST(reinstatement_arrears_amount AS DOUBLE))
      comment: "Total arrears for reinstatement, lapse recovery metric"
    - name: "bill_count"
      expr: COUNT(DISTINCT premium_bill_id)
      comment: "Number of unique premium bills issued"
    - name: "policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies billed"
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique billing accounts"
    - name: "avg_billed_amount"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average premium amount per bill, pricing and segmentation metric"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average unpaid balance per bill, collection efficiency indicator"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(billed_amount AS DOUBLE)) - SUM(CAST(outstanding_balance AS DOUBLE))) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed premium collected, primary collection efficiency KPI"
    - name: "apl_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_triggered THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bills triggering automatic premium loan, lapse prevention effectiveness"
    - name: "nsf_occurrence_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(nsf_occurrence_count AS INT) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bills with NSF events, payment quality and risk metric"
    - name: "grace_period_risk_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grace_period_expiry_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bills in grace period, lapse risk indicator"
    - name: "reinstatement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reinstatement_required THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bills requiring reinstatement, policy persistency quality metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment processing KPIs tracking payment velocity, method mix, NSF rates, and suspense resolution efficiency"
  source: "`life_insurance_ecm`.`billing`.`billing_premium_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (cleared, pending, failed, reversed)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (EFT, check, credit card, wire)"
    - name: "payment_source"
      expr: payment_source
      comment: "Source of payment (policyholder, employer, third party)"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (premium, reinstatement, arrears)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Bank clearance status of the payment"
    - name: "modal_premium_mode"
      expr: modal_premium_mode
      comment: "Premium payment frequency mode (monthly, quarterly, annual)"
    - name: "payment_year_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month payment was made, for cash flow and collection trending"
    - name: "received_year_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month payment was received by the company"
    - name: "nsf_flag"
      expr: nsf_indicator
      comment: "Whether payment resulted in NSF event"
    - name: "suspense_flag"
      expr: is_suspense
      comment: "Whether payment went to suspense account"
    - name: "grace_period_payment_flag"
      expr: grace_period_payment_flag
      comment: "Whether payment was made during grace period"
    - name: "reinstatement_payment_flag"
      expr: reinstatement_payment_flag
      comment: "Whether payment is for policy reinstatement"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total premium payments received, primary cash collection metric"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount applied to policies, allocation efficiency metric"
    - name: "total_suspense_amount"
      expr: SUM(CAST(suspense_amount AS DOUBLE))
      comment: "Total payment amount in suspense, operational efficiency indicator"
    - name: "total_nsf_fees"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees charged, payment quality cost metric"
    - name: "total_ape_amount"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total APE from payments, new business production metric"
    - name: "payment_count"
      expr: COUNT(DISTINCT billing_premium_payment_id)
      comment: "Number of unique payment transactions processed"
    - name: "policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies receiving payments"
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts making payments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction, customer behavior metric"
    - name: "payment_application_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of payments successfully applied, operational efficiency KPI"
    - name: "suspense_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_suspense THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments going to suspense, processing quality metric"
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN nsf_indicator THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments with NSF, payment quality and risk KPI"
    - name: "grace_period_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grace_period_payment_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments made during grace period, lapse risk indicator"
    - name: "reinstatement_payment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reinstatement_payment_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments for reinstatement, persistency recovery metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_lapse_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy lapse KPIs tracking lapse rates, reasons, APL effectiveness, and reinstatement eligibility for persistency management"
  source: "`life_insurance_ecm`.`billing`.`lapse_event`"
  dimensions:
    - name: "lapse_status"
      expr: lapse_status
      comment: "Current status of the lapse event (pending, confirmed, reinstated, cancelled)"
    - name: "lapse_reason_code"
      expr: lapse_reason_code
      comment: "Coded reason for policy lapse"
    - name: "lapse_reason_description"
      expr: lapse_reason_description
      comment: "Detailed description of lapse reason for root cause analysis"
    - name: "billing_mode"
      expr: billing_mode
      comment: "Premium payment frequency at time of lapse"
    - name: "product_type"
      expr: product_type
      comment: "Type of insurance product that lapsed"
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where policy was issued, for regulatory and geographic analysis"
    - name: "non_forfeiture_option"
      expr: non_forfeiture_option
      comment: "Non-forfeiture option elected (cash surrender, reduced paid-up, extended term)"
    - name: "lapse_year_month"
      expr: DATE_TRUNC('MONTH', lapse_effective_date)
      comment: "Month of lapse effective date for time-series trending"
    - name: "apl_applied_flag"
      expr: apl_applied
      comment: "Whether automatic premium loan was applied"
    - name: "apl_eligible_flag"
      expr: apl_eligible
      comment: "Whether policy was eligible for APL"
    - name: "reinstatement_eligible_flag"
      expr: reinstatement_eligible
      comment: "Whether policy is eligible for reinstatement"
  measures:
    - name: "lapse_count"
      expr: COUNT(DISTINCT lapse_event_id)
      comment: "Number of unique lapse events, primary persistency failure metric"
    - name: "lapsed_policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies lapsed"
    - name: "lapsed_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with lapsed policies"
    - name: "total_face_amount_lapsed"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total death benefit face amount lapsed, coverage loss metric"
    - name: "total_csv_at_lapse"
      expr: SUM(CAST(csv_at_lapse AS DOUBLE))
      comment: "Total cash surrender value at lapse, asset value at risk"
    - name: "total_nar_at_lapse"
      expr: SUM(CAST(nar_at_lapse AS DOUBLE))
      comment: "Total net amount at risk at lapse, underwriting exposure metric"
    - name: "total_outstanding_premium"
      expr: SUM(CAST(outstanding_premium_amount AS DOUBLE))
      comment: "Total unpaid premium at lapse, collection failure metric"
    - name: "total_modal_premium_lost"
      expr: SUM(CAST(modal_premium_amount AS DOUBLE))
      comment: "Total modal premium lost due to lapse, revenue impact metric"
    - name: "total_policy_loan_balance"
      expr: SUM(CAST(policy_loan_balance AS DOUBLE))
      comment: "Total policy loan balance at lapse, asset recovery metric"
    - name: "total_apl_amount"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total APL amount used, lapse prevention investment metric"
    - name: "total_reduced_paid_up_face"
      expr: SUM(CAST(reduced_paid_up_face_amount AS DOUBLE))
      comment: "Total reduced paid-up face amount elected, non-forfeiture value metric"
    - name: "avg_face_amount_lapsed"
      expr: AVG(CAST(face_amount AS DOUBLE))
      comment: "Average face amount per lapsed policy, coverage size metric"
    - name: "avg_policy_duration_months"
      expr: AVG(CAST(policy_duration_months AS INT))
      comment: "Average policy duration before lapse, persistency quality indicator"
    - name: "apl_application_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_applied THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lapses where APL was applied, lapse prevention effectiveness"
    - name: "apl_eligibility_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_eligible THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lapses that were APL eligible, product design metric"
    - name: "reinstatement_eligibility_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reinstatement_eligible THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lapses eligible for reinstatement, recovery opportunity metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace period management KPIs tracking at-risk policies, APL utilization, resolution outcomes, and lapse prevention effectiveness"
  source: "`life_insurance_ecm`.`billing`.`grace_period`"
  dimensions:
    - name: "period_status"
      expr: period_status
      comment: "Current status of grace period (active, resolved, lapsed)"
    - name: "period_type"
      expr: period_type
      comment: "Type of grace period (standard, extended, regulatory)"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "How the grace period was resolved (paid, lapsed, APL, waiver)"
    - name: "trigger_reason"
      expr: trigger_reason
      comment: "Reason grace period was triggered"
    - name: "billing_mode"
      expr: billing_mode
      comment: "Premium payment frequency"
    - name: "product_type"
      expr: product_type
      comment: "Type of insurance product in grace period"
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where policy was issued"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for the policy"
    - name: "notice_channel"
      expr: notice_channel
      comment: "Channel used for grace period notices (email, mail, phone)"
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month grace period started, for trending"
    - name: "apl_eligible_flag"
      expr: apl_eligible
      comment: "Whether policy is eligible for automatic premium loan"
    - name: "waiver_of_premium_active_flag"
      expr: waiver_of_premium_active
      comment: "Whether waiver of premium rider is active"
  measures:
    - name: "grace_period_count"
      expr: COUNT(DISTINCT grace_period_id)
      comment: "Number of unique grace period events, at-risk policy volume metric"
    - name: "policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies in grace period"
    - name: "total_outstanding_premium"
      expr: SUM(CAST(outstanding_premium_amount AS DOUBLE))
      comment: "Total unpaid premium triggering grace periods, collection risk metric"
    - name: "total_modal_premium"
      expr: SUM(CAST(modal_premium_amount AS DOUBLE))
      comment: "Total modal premium at risk, revenue exposure metric"
    - name: "total_csv_at_trigger"
      expr: SUM(CAST(csv_at_trigger AS DOUBLE))
      comment: "Total cash surrender value at grace period trigger, asset value at risk"
    - name: "total_apl_amount"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total APL amount available, lapse prevention capacity metric"
    - name: "total_partial_payment"
      expr: SUM(CAST(partial_payment_amount AS DOUBLE))
      comment: "Total partial payments received during grace period, collection effort metric"
    - name: "avg_outstanding_premium"
      expr: AVG(CAST(outstanding_premium_amount AS DOUBLE))
      comment: "Average unpaid premium per grace period event"
    - name: "avg_duration_days"
      expr: AVG(CAST(duration_days AS INT))
      comment: "Average grace period duration in days, resolution speed metric"
    - name: "avg_days_remaining"
      expr: AVG(CAST(days_remaining AS INT))
      comment: "Average days remaining in active grace periods, urgency metric"
    - name: "apl_eligibility_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_eligible THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods with APL eligibility, lapse prevention coverage"
    - name: "waiver_active_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_of_premium_active THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage with active waiver of premium, rider utilization metric"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods resolved, operational efficiency KPI"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_nsf_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NSF event KPIs tracking payment failure rates, bank return reasons, remediation effectiveness, and lapse risk from failed payments"
  source: "`life_insurance_ecm`.`billing`.`nsf_event`"
  dimensions:
    - name: "event_status"
      expr: event_status
      comment: "Current status of NSF event (open, remediated, lapsed)"
    - name: "bank_return_reason_code"
      expr: bank_return_reason_code
      comment: "Bank return code for NSF event"
    - name: "bank_return_reason_description"
      expr: bank_return_reason_description
      comment: "Detailed description of bank return reason for root cause analysis"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method that failed (EFT, check, ACH)"
    - name: "billing_mode"
      expr: billing_mode
      comment: "Premium payment frequency"
    - name: "remediation_action"
      expr: remediation_action
      comment: "Action taken to remediate NSF (retry, contact customer, APL)"
    - name: "representment_status"
      expr: representment_status
      comment: "Status of payment representment attempt"
    - name: "state_code"
      expr: state_code
      comment: "State code for geographic analysis"
    - name: "nsf_year_month"
      expr: DATE_TRUNC('MONTH', nsf_date)
      comment: "Month of NSF event for trending"
    - name: "apl_triggered_flag"
      expr: apl_triggered
      comment: "Whether APL was triggered due to NSF"
    - name: "nsf_fee_waived_flag"
      expr: nsf_fee_waived
      comment: "Whether NSF fee was waived"
  measures:
    - name: "nsf_event_count"
      expr: COUNT(DISTINCT nsf_event_id)
      comment: "Number of unique NSF events, payment quality failure metric"
    - name: "policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies with NSF events"
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with NSF events"
    - name: "total_payment_amount_failed"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount that failed due to NSF, collection failure metric"
    - name: "total_nsf_fees"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees charged, cost of payment failure"
    - name: "total_apl_amount"
      expr: SUM(CAST(apl_amount AS DOUBLE))
      comment: "Total APL amount triggered by NSF, lapse prevention cost"
    - name: "avg_payment_amount_failed"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average failed payment amount per NSF event"
    - name: "avg_nsf_occurrence_count"
      expr: AVG(CAST(nsf_occurrence_count AS INT))
      comment: "Average number of NSF occurrences per policy, repeat failure metric"
    - name: "avg_representment_count"
      expr: AVG(CAST(representment_count AS INT))
      comment: "Average number of representment attempts, remediation effort metric"
    - name: "apl_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_triggered THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NSF events triggering APL, lapse prevention effectiveness"
    - name: "nsf_fee_waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN nsf_fee_waived THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NSF fees waived, customer service metric"
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NSF events successfully remediated, recovery effectiveness KPI"
    - name: "lapse_initiation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN lapse_initiation_date IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NSF events leading to lapse initiation, persistency risk metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account KPIs tracking account health, balance aging, payment method mix, and delinquency risk across the customer base"
  source: "`life_insurance_ecm`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of billing account (active, suspended, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (individual, group, corporate)"
    - name: "payment_method"
      expr: payment_method
      comment: "Primary payment method for the account"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual)"
    - name: "billing_state_code"
      expr: billing_state_code
      comment: "State code of billing address"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country code of billing address"
    - name: "bank_account_type"
      expr: bank_account_type
      comment: "Type of bank account (checking, savings)"
    - name: "effective_year_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month account became effective"
    - name: "delinquency_flag"
      expr: delinquency_indicator
      comment: "Whether account is currently delinquent"
    - name: "apl_flag"
      expr: apl_indicator
      comment: "Whether account has APL active"
    - name: "paperless_billing_flag"
      expr: paperless_billing_indicator
      comment: "Whether account is enrolled in paperless billing"
  measures:
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique billing accounts, customer base size metric"
    - name: "total_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts, primary AR metric"
    - name: "total_ape_amount"
      expr: SUM(CAST(ape_amount AS DOUBLE))
      comment: "Total APE across accounts, production volume metric"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed to accounts, billing volume metric"
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payments, collection activity metric"
    - name: "avg_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average outstanding balance per account, account health indicator"
    - name: "avg_ape_amount"
      expr: AVG(CAST(ape_amount AS DOUBLE))
      comment: "Average APE per account, account size metric"
    - name: "avg_policy_count"
      expr: AVG(CAST(policy_count AS INT))
      comment: "Average number of policies per account, account complexity metric"
    - name: "delinquency_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delinquency_indicator THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts delinquent, primary collection risk KPI"
    - name: "apl_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_indicator THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts using APL, lapse prevention utilization"
    - name: "paperless_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN paperless_billing_indicator THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts on paperless billing, operational efficiency metric"
    - name: "grace_period_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grace_period_end_date IS NOT NULL AND grace_period_end_date >= CURRENT_DATE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts currently in grace period, at-risk account metric"
    - name: "nsf_account_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN CAST(nsf_count AS INT) > 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with NSF history, payment quality risk metric"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`billing_reinstatement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy reinstatement KPIs tracking reinstatement success rates, approval cycle time, back premium collection, and persistency recovery effectiveness"
  source: "`life_insurance_ecm`.`billing`.`billing_reinstatement`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of reinstatement (pending, approved, denied)"
    - name: "reinstatement_type"
      expr: reinstatement_type
      comment: "Type of reinstatement (standard, simplified, full underwriting)"
    - name: "evidence_type"
      expr: evidence_type
      comment: "Type of evidence required (none, statement, medical exam)"
    - name: "underwriting_decision"
      expr: underwriting_decision
      comment: "Underwriting decision for reinstatement"
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code if reinstatement was denied"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for reinstatement"
    - name: "product_code"
      expr: product_code
      comment: "Product code of reinstated policy"
    - name: "state_of_issue"
      expr: state_of_issue
      comment: "State where policy was issued"
    - name: "application_year_month"
      expr: DATE_TRUNC('MONTH', application_date)
      comment: "Month reinstatement was applied for"
    - name: "apl_used_flag"
      expr: apl_used
      comment: "Whether APL was used for reinstatement"
    - name: "underwriting_evidence_required_flag"
      expr: underwriting_evidence_required
      comment: "Whether underwriting evidence was required"
    - name: "fraud_flag"
      expr: fraud_indicator
      comment: "Whether fraud was suspected"
  measures:
    - name: "reinstatement_count"
      expr: COUNT(DISTINCT billing_reinstatement_id)
      comment: "Number of unique reinstatement applications, persistency recovery volume"
    - name: "policy_count"
      expr: COUNT(DISTINCT in_force_policy_id)
      comment: "Number of unique policies with reinstatement applications"
    - name: "account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts applying for reinstatement"
    - name: "total_amount_collected"
      expr: SUM(CAST(amount_collected AS DOUBLE))
      comment: "Total amount collected for reinstatements, recovery revenue metric"
    - name: "total_back_premium"
      expr: SUM(CAST(back_premium_amount AS DOUBLE))
      comment: "Total back premium collected, arrears recovery metric"
    - name: "total_back_premium_interest"
      expr: SUM(CAST(back_premium_interest_amount AS DOUBLE))
      comment: "Total interest on back premium, cost of lapse metric"
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount due for reinstatements, collection target metric"
    - name: "total_face_amount"
      expr: SUM(CAST(face_amount AS DOUBLE))
      comment: "Total face amount reinstated, coverage recovery metric"
    - name: "total_csv_at_lapse"
      expr: SUM(CAST(csv_at_lapse AS DOUBLE))
      comment: "Total CSV at time of lapse, asset value recovered"
    - name: "total_policy_loan_balance"
      expr: SUM(CAST(policy_loan_balance_at_lapse AS DOUBLE))
      comment: "Total policy loan balance at lapse"
    - name: "avg_lapse_duration_days"
      expr: AVG(CAST(lapse_duration_days AS INT))
      comment: "Average days lapsed before reinstatement, recovery speed metric"
    - name: "avg_prior_reinstatement_count"
      expr: AVG(CAST(prior_reinstatement_count AS INT))
      comment: "Average prior reinstatements per policy, persistency quality indicator"
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN approval_status = 'approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reinstatements approved, recovery success KPI"
    - name: "apl_usage_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN apl_used THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage using APL for reinstatement, lapse prevention effectiveness"
    - name: "underwriting_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN underwriting_evidence_required THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage requiring underwriting evidence, complexity metric"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_collected AS DOUBLE)) / NULLIF(SUM(CAST(total_amount_due AS DOUBLE)), 0), 2)
      comment: "Percentage of reinstatement amounts collected, collection effectiveness KPI"
$$;