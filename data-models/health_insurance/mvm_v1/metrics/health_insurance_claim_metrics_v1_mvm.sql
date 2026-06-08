-- Metric views for domain: claim | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:18:32

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim volume, financial performance, and operational efficiency metrics at the claim header level"
  source: "`health_insurance_ecm`.`claim`.`header`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (professional, institutional, dental, vision, pharmacy)"
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (submitted, pending, approved, denied, paid)"
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (Commercial, Medicare, Medicaid, Exchange)"
    - name: "place_of_service"
      expr: place_of_service_code
      comment: "Place where service was rendered (office, hospital, ER, etc.)"
    - name: "admission_year"
      expr: YEAR(admission_date)
      comment: "Year of admission for inpatient claims"
    - name: "admission_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of admission for inpatient claims"
    - name: "claim_received_year"
      expr: YEAR(claim_event_timestamp)
      comment: "Year the claim was received"
    - name: "claim_received_month"
      expr: DATE_TRUNC('MONTH', claim_event_timestamp)
      comment: "Month the claim was received"
    - name: "is_suspended"
      expr: is_suspended
      comment: "Whether the claim is currently suspended for review"
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the claim processing met service level agreement"
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Whether coordination of benefits applies"
    - name: "adjustment_flag"
      expr: adjustment_flag
      comment: "Whether this is an adjustment claim"
    - name: "drg_code"
      expr: drg_code
      comment: "Diagnosis Related Group code for inpatient claims"
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim headers submitted"
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount billed by providers across all claims"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total amount allowed by the health plan after contract adjustments"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid by the health plan to providers"
    - name: "avg_billed_amount"
      expr: AVG(CAST(billed_amount AS DOUBLE))
      comment: "Average amount billed per claim"
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average amount allowed per claim"
    - name: "avg_paid_amount"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average amount paid per claim"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(billed_amount AS DOUBLE)) - SUM(CAST(allowed_amount AS DOUBLE))) / NULLIF(SUM(CAST(billed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount from billed to allowed amount, indicating network negotiation effectiveness"
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of allowed amount actually paid, indicating member cost-sharing and payment efficiency"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with claims"
    - name: "unique_providers"
      expr: COUNT(DISTINCT header_rendering_provider_id)
      comment: "Number of unique rendering providers submitting claims"
    - name: "unique_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of unique facilities where services were rendered"
    - name: "avg_length_of_stay"
      expr: AVG(CAST(length_of_stay AS DOUBLE))
      comment: "Average length of stay for inpatient claims, key utilization metric"
    - name: "suspended_claims"
      expr: SUM(CASE WHEN is_suspended = TRUE THEN 1 ELSE 0 END)
      comment: "Number of claims currently suspended for review"
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims processed within service level agreement, operational efficiency KPI"
    - name: "cob_claims"
      expr: SUM(CASE WHEN cob_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of claims with coordination of benefits"
    - name: "adjustment_claims"
      expr: SUM(CASE WHEN adjustment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of adjustment claims, indicating rework and accuracy issues"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication decision quality, auto-adjudication efficiency, and cost-sharing accuracy metrics"
  source: "`health_insurance_ecm`.`claim`.`adjudication`"
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Status of the adjudication decision (approved, denied, pending)"
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated"
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Whether the claim was auto-adjudicated without manual review"
    - name: "edit_override_flag"
      expr: edit_override_flag
      comment: "Whether system edits were overridden by manual review"
    - name: "duplicate_claim_flag"
      expr: duplicate_claim_flag
      comment: "Whether the claim was flagged as a duplicate"
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Whether prior authorization was required for the service"
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization (approved, denied, not required)"
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether the service met medical necessity criteria"
    - name: "timeliness_flag"
      expr: timeliness_flag
      comment: "Whether the claim was submitted within timely filing limits"
    - name: "allowed_amount_method"
      expr: allowed_amount_method
      comment: "Method used to determine allowed amount (fee schedule, contract rate, UCR)"
    - name: "edit_outcome"
      expr: edit_outcome
      comment: "Outcome of claim edits (pass, fail, warning)"
    - name: "adjudication_year"
      expr: YEAR(adjudication_timestamp)
      comment: "Year the adjudication was completed"
    - name: "adjudication_month"
      expr: DATE_TRUNC('MONTH', adjudication_timestamp)
      comment: "Month the adjudication was completed"
    - name: "service_year"
      expr: YEAR(service_date)
      comment: "Year the service was rendered"
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month the service was rendered"
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total number of adjudication decisions"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total amount charged by providers"
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total amount allowed after adjudication"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total member deductible applied"
    - name: "total_oop_amount"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total member out-of-pocket cost-sharing"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount payable by the health plan"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied during adjudication"
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per adjudication"
    - name: "avg_member_cost_share"
      expr: AVG(CAST(oop_amount AS DOUBLE))
      comment: "Average member out-of-pocket cost per adjudication"
    - name: "auto_adjudication_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN auto_adjudication_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims auto-adjudicated, key operational efficiency metric"
    - name: "edit_override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN edit_override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims requiring edit override, indicating system accuracy"
    - name: "duplicate_claim_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN duplicate_claim_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of duplicate claims detected, quality control metric"
    - name: "pa_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN prior_authorization_required = TRUE AND prior_authorization_status = 'approved' THEN 1 WHEN prior_authorization_required = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims with proper prior authorization, utilization management effectiveness"
    - name: "medical_necessity_pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_necessity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims meeting medical necessity criteria"
    - name: "timely_filing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN timeliness_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of claims submitted within timely filing limits"
    - name: "member_cost_share_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(oop_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)), 0), 2)
      comment: "Member out-of-pocket as percentage of allowed amount, benefit design effectiveness"
    - name: "plan_liability_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(total_net_amount AS DOUBLE)) / NULLIF(SUM(CAST(allowed_amount AS DOUBLE)), 0), 2)
      comment: "Plan liability as percentage of allowed amount, financial risk metric"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with adjudicated claims"
    - name: "unique_providers"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers with adjudicated claims"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial rate, reason analysis, and appeal opportunity metrics for quality and revenue cycle management"
  source: "`health_insurance_ecm`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Type of denial (clinical, administrative, technical, eligibility)"
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (active, appealed, overturned, upheld)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the denial (pending, resolved, closed)"
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code, standardized denial reason"
    - name: "denial_subtype"
      expr: subtype
      comment: "Subtype of denial for more granular analysis"
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the denial is eligible for appeal"
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether denial was due to medical necessity"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether the denial was overridden"
    - name: "letter_generated_flag"
      expr: letter_generated_flag
      comment: "Whether a denial letter was generated for the member"
    - name: "denial_year"
      expr: YEAR(denial_date)
      comment: "Year the denial was issued"
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month the denial was issued"
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year the denial was resolved"
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the denial was resolved"
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of claim denials"
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross amount denied before adjustments"
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net amount denied after adjustments"
    - name: "total_denied_adjustment_amount"
      expr: SUM(CAST(denied_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount on denied claims"
    - name: "avg_denied_amount"
      expr: AVG(CAST(denied_net_amount AS DOUBLE))
      comment: "Average net amount denied per denial"
    - name: "appeal_eligible_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials eligible for appeal, member rights metric"
    - name: "medical_necessity_denial_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN medical_necessity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials due to medical necessity, utilization management effectiveness"
    - name: "denial_override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials overridden, indicating initial decision accuracy"
    - name: "letter_generation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN letter_generated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of denials with member notification letters generated"
    - name: "unique_members_denied"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Number of unique members with denied claims"
    - name: "unique_providers_denied"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers with denied claims"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment velocity, accuracy, reconciliation, and financial settlement metrics"
  source: "`health_insurance_ecm`.`claim`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (pending, issued, cleared, returned, voided)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (claim, capitation, incentive, refund)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (EFT, check, virtual card)"
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (provider, member, facility)"
    - name: "payment_source"
      expr: payment_source
      comment: "Source of payment (claims, appeals, adjustments)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (reconciled, pending, exception)"
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the payment has been reconciled"
    - name: "is_returned"
      expr: is_returned
      comment: "Whether the payment was returned"
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the payment was voided"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was issued"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was issued"
    - name: "gl_posting_year"
      expr: YEAR(gl_posting_date)
      comment: "Year the payment was posted to general ledger"
    - name: "gl_posting_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month the payment was posted to general ledger"
    - name: "payment_cycle"
      expr: cycle
      comment: "Payment cycle identifier"
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payments issued"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount before adjustments"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after adjustments"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to payments"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount withheld or applied"
    - name: "avg_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per payment"
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_reconciled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments reconciled, financial control metric"
    - name: "payment_return_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments returned, payment accuracy metric"
    - name: "payment_void_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments voided, payment quality metric"
    - name: "eft_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_method = 'EFT' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments made via EFT, operational efficiency metric"
    - name: "unique_payees"
      expr: COUNT(DISTINCT payment_party_id)
      comment: "Number of unique payees receiving payments"
    - name: "unique_batches"
      expr: COUNT(DISTINCT batch_number)
      comment: "Number of unique payment batches"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Post-payment adjustment, recovery, and financial correction metrics for revenue integrity"
  source: "`health_insurance_ecm`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (overpayment recovery, underpayment correction, pricing correction)"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Status of the adjustment (pending, approved, completed, reversed)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the adjustment"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover overpayment (offset, demand letter, legal)"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery efforts"
    - name: "overpayment_indicator"
      expr: overpayment_indicator
      comment: "Whether the adjustment is for an overpayment"
    - name: "overpayment_type"
      expr: overpayment_type
      comment: "Type of overpayment (pricing error, duplicate, eligibility)"
    - name: "is_fraud"
      expr: is_fraud
      comment: "Whether the adjustment is related to fraud"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether the adjustment is a reversal"
    - name: "is_duplicate"
      expr: is_duplicate
      comment: "Whether the adjustment is for a duplicate claim"
    - name: "compliance_60_day_rule"
      expr: compliance_60_day_rule
      comment: "Whether the adjustment complies with 60-day overpayment reporting rule"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Whether the adjustment requires regulatory reporting"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that triggered the adjustment"
    - name: "adjustment_year"
      expr: YEAR(adjustment_date)
      comment: "Year the adjustment was made"
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', adjustment_date)
      comment: "Month the adjustment was made"
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of claim adjustments"
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted across all adjustments"
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment amount after offsets"
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original payment amount before adjustment"
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjusted_amount AS DOUBLE))
      comment: "Average adjustment amount per adjustment"
    - name: "overpayment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overpayment_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are overpayments, payment accuracy metric"
    - name: "fraud_adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments related to fraud, program integrity metric"
    - name: "duplicate_adjustment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_duplicate = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments for duplicate claims, claims processing quality metric"
    - name: "compliance_60_day_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_60_day_rule = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments compliant with 60-day rule, regulatory compliance metric"
    - name: "regulatory_reporting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments requiring regulatory reporting"
    - name: "recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(adjusted_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of adjusted amount successfully recovered, revenue integrity effectiveness"
    - name: "unique_members_adjusted"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with claim adjustments"
    - name: "unique_providers_adjusted"
      expr: COUNT(DISTINCT provider_id)
      comment: "Number of unique providers with claim adjustments"
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member benefit accumulator tracking for deductible, out-of-pocket max, and benefit limit management"
  source: "`health_insurance_ecm`.`claim`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (deductible, out-of-pocket max, benefit limit)"
    - name: "accumulator_code"
      expr: accumulator_code
      comment: "Standardized accumulator code"
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Status of the accumulator (active, met, expired)"
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category the accumulator applies to"
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the accumulator"
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Whether this is an adjustment to the accumulator"
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether this is a reversal of a previous accumulator entry"
    - name: "benefit_period_year"
      expr: YEAR(benefit_period_start)
      comment: "Year of the benefit period"
    - name: "benefit_period_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start)
      comment: "Month of the benefit period start"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the accumulator event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the accumulator event occurred"
  measures:
    - name: "total_accumulator_events"
      expr: COUNT(1)
      comment: "Total number of accumulator events"
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total amount accumulated across all accumulators"
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total limit amount across all accumulators"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance across all accumulators"
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average amount accumulated per accumulator"
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance per accumulator"
    - name: "accumulator_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_amount AS DOUBLE)) / NULLIF(SUM(CAST(limit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of accumulator limit utilized, benefit design effectiveness metric"
    - name: "unique_members"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Number of unique members with accumulator activity"
$$;