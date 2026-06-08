-- Metric views for domain: claim | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 18:36:19

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim header metrics providing visibility into claim volumes, financial amounts, processing efficiency, and claim mix — the primary fact table for health insurance claim operations."
  source: "`health_insurance_ecm`.`claim`.`header`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., Professional, Institutional, Dental, Vision) for segmenting claim volumes and financials."
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the claim (e.g., Received, Adjudicated, Paid, Denied, Suspended)."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid, Individual) for strategic portfolio analysis."
    - name: "claim_source"
      expr: claim_source
      comment: "Channel through which the claim was submitted (e.g., EDI, Portal, Paper) for intake channel analysis."
    - name: "billing_type"
      expr: billing_type
      comment: "Billing classification (e.g., Inpatient, Outpatient, Professional) for cost segmentation."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service code indicating where care was rendered (e.g., Office, ER, Inpatient Hospital)."
    - name: "is_suspended"
      expr: is_suspended
      comment: "Whether the claim is currently suspended/pended, indicating processing bottlenecks."
    - name: "cob_indicator"
      expr: cob_indicator
      comment: "Whether coordination of benefits applies, indicating multi-payer complexity."
    - name: "adjustment_flag"
      expr: adjustment_flag
      comment: "Whether this claim is an adjustment to a prior claim."
    - name: "sla_met"
      expr: sla_met
      comment: "Whether the claim was processed within the SLA deadline — key regulatory and operational metric."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Denial reason code for denied claims, enabling denial root cause analysis."
    - name: "claim_received_month"
      expr: DATE_TRUNC('month', claim_event_timestamp)
      comment: "Month the claim event occurred, for time-series trending of claim volumes."
    - name: "admission_month"
      expr: DATE_TRUNC('month', admission_date)
      comment: "Month of admission for inpatient claims, for incurred-date analysis."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claims received — baseline volume metric for capacity planning and trend analysis."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total charges billed by providers — key input for understanding cost pressure and provider billing patterns."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed (contracted) amounts — represents the plan's recognized cost obligation after contract repricing."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid on claims — the primary financial outflow metric for the health plan."
    - name: "avg_paid_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim — key unit cost metric for actuarial and financial analysis."
    - name: "avg_allowed_per_claim"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per claim — measures average contracted cost per claim encounter."
    - name: "distinct_members_with_claims"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with claims — measures utilization penetration across the member population."
    - name: "distinct_providers_billed"
      expr: COUNT(DISTINCT header_claiming_provider_provider_provider_id)
      comment: "Count of unique billing providers — measures provider network breadth in claims activity."
    - name: "suspended_claim_count"
      expr: SUM(CASE WHEN is_suspended = TRUE THEN 1 ELSE 0 END)
      comment: "Number of claims currently suspended — operational bottleneck indicator requiring management attention."
    - name: "mlr_excluded_claim_count"
      expr: SUM(CASE WHEN is_mlr_excluded = TRUE THEN 1 ELSE 0 END)
      comment: "Claims excluded from Medical Loss Ratio calculation — important for regulatory MLR reporting accuracy."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim line-level metrics providing granular visibility into service-level financials, procedure mix, and member cost sharing — essential for cost management and benefit design analysis."
  source: "`health_insurance_ecm`.`claim`.`line`"
  dimensions:
    - name: "procedure_code"
      expr: procedure_code
      comment: "CPT/HCPCS procedure code identifying the specific service rendered."
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code for institutional claims, categorizing the type of facility charge."
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Place of service where the line-level service was rendered."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the claim line (e.g., Paid, Denied, Adjusted)."
    - name: "line_type"
      expr: line_type
      comment: "Type classification of the claim line for categorization."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code if the line was denied — enables line-level denial analysis."
    - name: "emergency_indicator"
      expr: emergency_indicator
      comment: "Whether the service was an emergency — critical for network exception and cost analysis."
    - name: "ndc_code"
      expr: ndc_code
      comment: "National Drug Code for pharmacy-related claim lines."
    - name: "service_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service for incurred-date trending and lag analysis."
  measures:
    - name: "total_claim_lines"
      expr: COUNT(1)
      comment: "Total number of claim lines — measures service volume granularity."
    - name: "total_line_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total billed amount across all claim lines — provider charge volume at service level."
    - name: "total_line_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount at line level — contracted cost recognized per service."
    - name: "total_line_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total paid amount at line level — actual plan payment per service."
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility_amount AS DOUBLE))
      comment: "Total member cost sharing (copay, coinsurance, deductible) — measures member financial burden and benefit design impact."
    - name: "total_units_of_service"
      expr: SUM(CAST(units_of_service AS DOUBLE))
      comment: "Total units of service rendered — volume metric for utilization analysis and unit cost calculations."
    - name: "avg_paid_per_line"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim line — unit cost metric at the service level."
    - name: "total_cob_paid_amount"
      expr: SUM(CAST(cob_paid_amount AS DOUBLE))
      comment: "Total amount paid by other payers via coordination of benefits — measures COB recovery effectiveness."
    - name: "total_line_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied at line level — measures repricing and contractual adjustment impact."
    - name: "emergency_service_count"
      expr: SUM(CASE WHEN emergency_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of emergency service lines — high-cost utilization indicator for care management intervention."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication metrics measuring claims processing quality, auto-adjudication efficiency, network utilization, and cost allocation — critical for operations and compliance monitoring."
  source: "`health_insurance_ecm`.`claim`.`adjudication`"
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Outcome status of adjudication (e.g., Approved, Denied, Pended) for processing funnel analysis."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated for segmentation."
    - name: "network_status"
      expr: network_status
      comment: "In-network vs out-of-network status — key driver of allowed amounts and member cost sharing."
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Whether the claim was auto-adjudicated vs manually processed — measures automation efficiency."
    - name: "timeliness_flag"
      expr: timeliness_flag
      comment: "Whether adjudication met timeliness standards — regulatory compliance indicator."
    - name: "duplicate_claim_flag"
      expr: duplicate_claim_flag
      comment: "Whether the claim was flagged as a potential duplicate — fraud/waste indicator."
    - name: "edit_outcome"
      expr: edit_outcome
      comment: "Result of claims editing rules (e.g., Pass, Fail, Override) for edit effectiveness analysis."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of prior authorization for the claim — utilization management compliance."
    - name: "cob_processing_result"
      expr: cob_processing_result
      comment: "Result of coordination of benefits processing."
    - name: "allowed_amount_method"
      expr: allowed_amount_method
      comment: "Method used to determine allowed amount (e.g., Fee Schedule, Percent of Billed, DRG)."
    - name: "adjudication_month"
      expr: DATE_TRUNC('month', adjudication_timestamp)
      comment: "Month of adjudication for processing volume trending."
    - name: "service_month"
      expr: DATE_TRUNC('month', service_date)
      comment: "Month of service date for incurred-date analysis."
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total adjudication events — baseline processing volume metric."
    - name: "auto_adjudicated_count"
      expr: SUM(CASE WHEN auto_adjudication_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of auto-adjudicated claims — numerator for auto-adjudication rate, a key operational efficiency KPI."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount determined through adjudication — the plan's cost obligation."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts applied — measures member cost sharing via deductible benefit design."
    - name: "total_oop_amount"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket amounts — tracks member financial exposure toward OOP maximums."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total provider charges submitted — gross cost input before repricing."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net adjudicated amount after all adjustments — the final financial obligation."
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total COB adjustment amounts — measures savings from coordination with other payers."
    - name: "timely_adjudication_count"
      expr: SUM(CASE WHEN timeliness_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims adjudicated within timeliness standards — numerator for regulatory compliance rate."
    - name: "duplicate_claim_count"
      expr: SUM(CASE WHEN duplicate_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of duplicate claims detected — fraud, waste, and abuse prevention metric."
    - name: "total_deductible_accumulator_impact"
      expr: SUM(CAST(accumulator_deductible_impact AS DOUBLE))
      comment: "Total deductible accumulator impact from adjudicated claims — tracks benefit accumulation."
    - name: "total_oop_accumulator_impact"
      expr: SUM(CAST(accumulator_oop_impact AS DOUBLE))
      comment: "Total OOP accumulator impact — tracks progress toward out-of-pocket maximums."
    - name: "edit_override_count"
      expr: SUM(CASE WHEN edit_override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of claims where editing rules were overridden — audit and compliance risk indicator."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial metrics tracking denial volumes, financial impact, appeal eligibility, and resolution — critical for provider relations, compliance, and revenue cycle management."
  source: "`health_insurance_ecm`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Category of denial (e.g., Clinical, Administrative, Eligibility) for root cause analysis."
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (e.g., Active, Overturned, Upheld)."
    - name: "subtype"
      expr: subtype
      comment: "Denial subtype for more granular categorization."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code — standardized denial reason for industry reporting."
    - name: "rac_code"
      expr: rac_code
      comment: "Remittance Advice Remark Code providing additional denial context."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the denial (e.g., Pending, Resolved, Appealed)."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Whether the denial is eligible for appeal — member rights indicator."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Whether the denial is based on medical necessity — clinical review indicator."
    - name: "denial_month"
      expr: DATE_TRUNC('month', denial_date)
      comment: "Month of denial for trending analysis."
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of claim denials — primary denial volume metric."
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross dollar amount of denied claims — financial impact of denials."
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net denied amount after adjustments — actual financial exposure from denials."
    - name: "appeal_eligible_denial_count"
      expr: SUM(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of denials eligible for appeal — measures potential appeal volume and member rights exposure."
    - name: "medical_necessity_denial_count"
      expr: SUM(CASE WHEN medical_necessity_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of medical necessity denials — clinical review workload and UM effectiveness indicator."
    - name: "override_denial_count"
      expr: SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of denials that were overridden — measures exception handling and potential process gaps."
    - name: "avg_denied_amount"
      expr: AVG(CAST(denied_gross_amount AS DOUBLE))
      comment: "Average denied amount per denial — severity metric for denial financial impact."
    - name: "distinct_denied_members"
      expr: COUNT(DISTINCT member_subscriber_id)
      comment: "Count of unique members with denials — measures member impact breadth of denial activity."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment metrics tracking disbursement volumes, financial amounts, payment methods, and reconciliation status — essential for treasury, finance, and provider payment operations."
  source: "`health_insurance_ecm`.`claim`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Issued, Cleared, Voided, Returned)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., Claim Payment, Refund, Capitation)."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., EFT, Check, Virtual Card) for payment modernization tracking."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payee (e.g., Provider, Member, Facility) for payment distribution analysis."
    - name: "channel"
      expr: channel
      comment: "Payment delivery channel."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the payment was voided — operational quality indicator."
    - name: "is_returned"
      expr: is_returned
      comment: "Whether the payment was returned — indicates payment delivery issues."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Whether the payment has been reconciled — financial controls indicator."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for financial close tracking."
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for cash flow and disbursement trending."
    - name: "gl_posting_month"
      expr: DATE_TRUNC('month', gl_posting_date)
      comment: "Month of GL posting for financial period analysis."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment transactions — payment operations volume metric."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount before adjustments — primary cash outflow metric."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after adjustments and taxes — actual disbursement metric."
    - name: "total_payment_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to payments — measures payment correction activity."
    - name: "voided_payment_count"
      expr: SUM(CASE WHEN is_voided = TRUE THEN 1 ELSE 0 END)
      comment: "Count of voided payments — operational quality and error rate indicator."
    - name: "returned_payment_count"
      expr: SUM(CASE WHEN is_returned = TRUE THEN 1 ELSE 0 END)
      comment: "Count of returned payments — payment delivery effectiveness indicator."
    - name: "unreconciled_payment_count"
      expr: SUM(CASE WHEN is_reconciled = FALSE THEN 1 ELSE 0 END)
      comment: "Count of unreconciled payments — financial controls and close readiness indicator."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount — unit cost metric for payment operations."
    - name: "distinct_payment_batches"
      expr: COUNT(DISTINCT batch_number)
      comment: "Count of distinct payment batches — measures payment processing throughput."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjustment metrics tracking post-adjudication corrections, overpayment recovery, and financial impact — essential for payment integrity, compliance, and financial accuracy."
  source: "`health_insurance_ecm`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., Overpayment, Underpayment, Contractual, Clinical)."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., Pending, Applied, Reversed)."
    - name: "adjustment_code"
      expr: adjustment_code
      comment: "Standardized adjustment reason code."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of overpayment recovery efforts."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used for recovery (e.g., Offset, Demand Letter, Refund)."
    - name: "overpayment_type"
      expr: overpayment_type
      comment: "Classification of overpayment for root cause analysis."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Whether the adjustment is fraud-related — SIU and compliance indicator."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Whether this is a reversal adjustment."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that triggered the adjustment (e.g., Internal, External, RAC)."
    - name: "initiator_role"
      expr: initiator_role
      comment: "Role of the person who initiated the adjustment for accountability tracking."
    - name: "demand_lifecycle_stage"
      expr: demand_lifecycle_stage
      comment: "Stage in the overpayment demand lifecycle."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the adjustment becomes effective for financial period analysis."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of claim adjustments — payment integrity activity volume."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total gross adjusted amount — measures the scale of post-adjudication financial corrections."
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment amount — actual financial impact of adjustments after offsets."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original payment amounts before adjustment — baseline for measuring correction magnitude."
    - name: "overpayment_count"
      expr: SUM(CASE WHEN overpayment_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of overpayment adjustments — payment integrity effectiveness metric."
    - name: "fraud_related_adjustment_count"
      expr: SUM(CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END)
      comment: "Count of fraud-related adjustments — SIU program effectiveness indicator."
    - name: "regulatory_reportable_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adjustments requiring regulatory reporting — compliance workload indicator."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Average net adjustment amount — severity metric for payment corrections."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit accumulator metrics tracking deductible, OOP max, and other benefit limit accumulations — critical for benefit administration accuracy and member financial protection."
  source: "`health_insurance_ecm`.`claim`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (e.g., Deductible, OOP Maximum, Copay Maximum, Lifetime Maximum)."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category the accumulator applies to (e.g., Medical, Pharmacy, Mental Health)."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (e.g., In-Network, Out-of-Network) — accumulators often track separately by tier."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for portfolio-level accumulator analysis."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Whether this is an adjustment to a prior accumulation."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('month', benefit_period_start)
      comment: "Start of the benefit period for accumulator tracking."
  measures:
    - name: "total_accumulator_records"
      expr: COUNT(1)
      comment: "Total accumulator transaction records — volume of benefit accumulation activity."
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total amount accumulated across all members — measures aggregate benefit utilization toward limits."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total benefit limit amounts — aggregate cap exposure across the member population."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance before limits are reached — measures how much benefit capacity remains."
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per record — measures typical member progress toward benefit limits."
    - name: "distinct_members_with_accumulators"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members with accumulator activity — measures benefit utilization breadth."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_ibnr`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incurred But Not Reported (IBNR) reserve metrics — critical actuarial and financial metrics for estimating unpaid claim liabilities and ensuring reserve adequacy."
  source: "`health_insurance_ecm`.`claim`.`ibnr`"
  dimensions:
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for IBNR segmentation (e.g., Commercial, Medicare, Medicaid)."
    - name: "plan_type"
      expr: plan_type
      comment: "Plan type for reserve analysis (e.g., HMO, PPO, HDHP)."
    - name: "service_category"
      expr: service_category
      comment: "Service category (e.g., Inpatient, Outpatient, Professional, Pharmacy) for reserve allocation."
    - name: "actuarial_method"
      expr: actuarial_method
      comment: "Actuarial method used for IBNR estimation (e.g., Chain Ladder, BF, Paid Development)."
    - name: "ibnr_status"
      expr: ibnr_status
      comment: "Status of the IBNR estimate (e.g., Preliminary, Final, Adjusted)."
    - name: "incurred_month"
      expr: DATE_TRUNC('month', incurred_month)
      comment: "Incurred month for the IBNR estimate — the service period being reserved."
    - name: "reserve_run_month"
      expr: DATE_TRUNC('month', reserve_run_date)
      comment: "Month the reserve calculation was run for vintage analysis."
  measures:
    - name: "total_estimated_ibnr"
      expr: SUM(CAST(estimated_ibnr_amount AS DOUBLE))
      comment: "Total estimated IBNR reserve — the primary unpaid claim liability metric for financial statements."
    - name: "total_paid_to_date"
      expr: SUM(CAST(paid_to_date_amount AS DOUBLE))
      comment: "Total paid-to-date amount for incurred periods — measures claim development and completion."
    - name: "total_reserve_change"
      expr: SUM(CAST(reserve_change_amount AS DOUBLE))
      comment: "Total change in reserves period-over-period — measures reserve development and adequacy trends."
    - name: "total_prior_period_reserve"
      expr: SUM(CAST(prior_period_reserve_amount AS DOUBLE))
      comment: "Total prior period reserve amounts — baseline for measuring reserve development."
    - name: "avg_completion_factor"
      expr: AVG(CAST(completion_factor AS DOUBLE))
      comment: "Average completion factor — measures how complete claim development is for incurred periods."
    - name: "avg_development_factor"
      expr: AVG(CAST(development_factor AS DOUBLE))
      comment: "Average development factor — key actuarial metric for projecting ultimate claim costs."
    - name: "total_mlr_numerator_allocation"
      expr: SUM(CAST(mlr_numerator_allocation AS DOUBLE))
      comment: "Total IBNR allocated to MLR numerator — critical for Medical Loss Ratio regulatory compliance."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_subrogation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subrogation and third-party recovery metrics — measures the effectiveness of recovering claim costs from liable third parties, a key revenue recovery and cost containment function."
  source: "`health_insurance_ecm`.`claim`.`subrogation`"
  dimensions:
    - name: "subrogation_status"
      expr: subrogation_status
      comment: "Current status of the subrogation case (e.g., Open, In Negotiation, Settled, Closed)."
    - name: "subrogation_type"
      expr: subrogation_type
      comment: "Type of subrogation (e.g., Auto Accident, Workers Comp, Liability)."
    - name: "liability_type"
      expr: liability_type
      comment: "Type of third-party liability."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method of recovery (e.g., Direct, Lien, Settlement)."
    - name: "lien_status"
      expr: lien_status
      comment: "Status of any lien applied against settlement proceeds."
    - name: "reporting_state_code"
      expr: reporting_state_code
      comment: "State jurisdiction for regulatory reporting requirements."
    - name: "is_settlement_agreed"
      expr: is_settlement_agreed
      comment: "Whether a settlement has been agreed upon."
    - name: "is_recovery_closed"
      expr: is_recovery_closed
      comment: "Whether the recovery case is closed."
    - name: "accident_month"
      expr: DATE_TRUNC('month', accident_date)
      comment: "Month of the accident/incident for trending."
  measures:
    - name: "total_subrogation_cases"
      expr: COUNT(1)
      comment: "Total subrogation cases — recovery program volume metric."
    - name: "total_demand_amount"
      expr: SUM(CAST(demand_amount AS DOUBLE))
      comment: "Total demand amounts sent to third parties — measures recovery opportunity pipeline."
    - name: "total_gross_recovery"
      expr: SUM(CAST(gross_recovery_amount AS DOUBLE))
      comment: "Total gross recovery amounts — primary recovery effectiveness metric."
    - name: "total_net_recovery"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery after legal fees — actual financial benefit from subrogation."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amounts agreed — measures negotiation outcomes."
    - name: "total_legal_fees"
      expr: SUM(CAST(legal_fees_amount AS DOUBLE))
      comment: "Total legal fees incurred in recovery — cost of recovery operations."
    - name: "total_lien_amount"
      expr: SUM(CAST(lien_amount AS DOUBLE))
      comment: "Total lien amounts applied — measures secured recovery positions."
    - name: "avg_net_recovery_per_case"
      expr: AVG(CAST(net_recovery_amount AS DOUBLE))
      comment: "Average net recovery per subrogation case — unit economics of recovery program."
    - name: "distinct_members_in_subrogation"
      expr: COUNT(DISTINCT member_identity_id)
      comment: "Count of unique members involved in subrogation — measures member impact."
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits metrics tracking multi-payer claim processing, primary payer payments, and net liability — essential for cost avoidance and accurate benefit coordination."
  source: "`health_insurance_ecm`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Status of COB processing (e.g., Pending, Processed, Denied)."
    - name: "cob_method"
      expr: cob_method
      comment: "COB calculation method used (e.g., Standard, Maintenance of Benefits, Non-Duplication)."
    - name: "other_insurance_type"
      expr: other_insurance_type
      comment: "Type of other insurance (e.g., Group, Medicare, Medicaid, Auto)."
    - name: "crossover_claim_flag"
      expr: crossover_claim_flag
      comment: "Whether this is a Medicare/Medicaid crossover claim."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Medicare Secondary Payer indicator — regulatory compliance flag."
    - name: "msp_type"
      expr: msp_type
      comment: "Type of MSP situation (e.g., Working Aged, Disability, ESRD)."
    - name: "processed_month"
      expr: DATE_TRUNC('month', processed_timestamp)
      comment: "Month COB was processed for trending."
  measures:
    - name: "total_cob_claims"
      expr: COUNT(1)
      comment: "Total COB claim transactions — multi-payer processing volume."
    - name: "total_primary_payer_paid"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by primary payer — measures cost avoidance from other coverage."
    - name: "total_secondary_payer_paid"
      expr: SUM(CAST(secondary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid as secondary payer — our plan's residual liability after primary payment."
    - name: "total_net_liability"
      expr: SUM(CAST(net_liability_amount AS DOUBLE))
      comment: "Total net liability after COB — actual plan financial obligation."
    - name: "total_cob_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total charges on COB claims — gross cost exposure before coordination."
    - name: "total_cob_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Total allowed amounts on COB claims."
    - name: "total_cob_adjustment"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total COB adjustments — measures savings from benefit coordination."
    - name: "crossover_claim_count"
      expr: SUM(CASE WHEN crossover_claim_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Medicare/Medicaid crossover claims — regulatory processing volume."
    - name: "msp_claim_count"
      expr: SUM(CASE WHEN msp_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Medicare Secondary Payer claims — CMS compliance metric."
$$;