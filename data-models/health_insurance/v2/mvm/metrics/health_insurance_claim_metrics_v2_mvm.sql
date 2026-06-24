-- Metric views for domain: claim | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim-level financial and operational KPIs derived from claim headers. Covers billed vs. allowed vs. paid amounts, denial rates, SLA compliance, and claim volume by type and status — the primary steering dashboard for claims operations and finance leadership."
  source: "`vibe_health_insurance_v1`.`claim`.`header`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim (e.g., professional, institutional, pharmacy) — primary segmentation for all claim KPIs."
    - name: "claim_status"
      expr: claim_status
      comment: "Current processing status of the claim (e.g., paid, denied, pending, suspended) — used to filter and segment operational dashboards."
    - name: "line_of_business"
      expr: lob
      comment: "Line of business (e.g., Commercial, Medicare, Medicaid) — critical segmentation for financial and regulatory reporting."
    - name: "claim_source"
      expr: claim_source
      comment: "Originating source of the claim submission (e.g., EDI, portal, paper) — used to track channel efficiency and auto-adjudication rates."
    - name: "place_of_service"
      expr: place_of_service_code
      comment: "Place of service code indicating care setting (e.g., inpatient, outpatient, office) — used for utilization and cost analysis."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', admission_date)
      comment: "Month of service admission date — used for trend analysis of claim volumes and financials over time."
    - name: "is_cob_claim"
      expr: cob_indicator
      comment: "Flag indicating whether coordination of benefits applies — used to segment COB-impacted financial flows."
    - name: "is_mlr_excluded"
      expr: is_mlr_excluded
      comment: "Flag indicating whether the claim is excluded from Medical Loss Ratio calculations — critical for regulatory MLR reporting."
    - name: "sla_met"
      expr: sla_met
      comment: "Flag indicating whether the claim was processed within SLA — used to monitor operational timeliness compliance."
    - name: "billing_type"
      expr: billing_type
      comment: "Billing type classification of the claim — used to segment institutional vs. professional billing patterns."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of claim headers submitted. Baseline volume KPI used in all claim operations dashboards and executive reporting."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total gross billed amount across all claims. Represents the full charge exposure before adjudication discounts and denials — key input to financial forecasting."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total contractually allowed amount across all claims. Represents the maximum payable after contract discounts — core to cost trend analysis."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total net paid amount across all claims. Primary financial outflow metric used by CFO and finance leadership for budget vs. actual tracking."
    - name: "avg_paid_amount_per_claim"
      expr: AVG(CAST(paid_amount AS DOUBLE))
      comment: "Average paid amount per claim. Tracks unit cost trends over time — a key indicator of cost inflation or deflation by claim type and LOB."
    - name: "discount_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE) - CAST(allowed_amount AS DOUBLE))
      comment: "Total contractual discount (billed minus allowed). Measures the value of provider contract negotiations — directly tied to cost containment strategy."
    - name: "denied_claim_count"
      expr: COUNT(CASE WHEN claim_status = 'DENIED' THEN 1 END)
      comment: "Count of claims with a denied status. Numerator for denial rate calculation — a primary quality and operational efficiency KPI."
    - name: "suspended_claim_count"
      expr: COUNT(CASE WHEN is_suspended = TRUE THEN 1 END)
      comment: "Count of claims currently suspended from processing. Tracks operational backlog and workflow bottlenecks requiring intervention."
    - name: "sla_compliant_claim_count"
      expr: COUNT(CASE WHEN sla_met = TRUE THEN 1 END)
      comment: "Count of claims processed within SLA. Numerator for SLA compliance rate — used to monitor regulatory and contractual timeliness obligations."
    - name: "cob_claim_count"
      expr: COUNT(CASE WHEN cob_indicator = TRUE THEN 1 END)
      comment: "Count of claims with coordination of benefits. Used to track COB volume and its financial impact on net liability."
    - name: "mlr_included_paid_amount"
      expr: SUM(CASE WHEN is_mlr_excluded = FALSE THEN CAST(paid_amount AS DOUBLE) ELSE 0 END)
      comment: "Total paid amount included in Medical Loss Ratio calculations. Critical for ACA regulatory MLR compliance reporting and rebate liability estimation."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjudication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjudication-level financial and quality KPIs covering allowed amounts, cost-sharing, COB adjustments, prior authorization compliance, and edit outcomes. Used by medical economics, compliance, and operations leadership to evaluate adjudication accuracy and cost drivers."
  source: "`vibe_health_insurance_v1`.`claim`.`adjudication`"
  dimensions:
    - name: "adjudication_status"
      expr: adjudication_status
      comment: "Final adjudication outcome status (e.g., approved, denied, pended) — primary segmentation for adjudication quality analysis."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of claim being adjudicated — used to segment financial KPIs by care setting and billing type."
    - name: "auto_adjudication_flag"
      expr: auto_adjudication_flag
      comment: "Indicates whether the claim was auto-adjudicated without manual intervention — key operational efficiency dimension."
    - name: "prior_authorization_required"
      expr: prior_authorization_required
      comment: "Flag indicating whether prior authorization was required for this claim — used to track PA compliance and denial risk."
    - name: "prior_authorization_status"
      expr: prior_authorization_status
      comment: "Status of the prior authorization associated with this adjudication — used to correlate PA outcomes with claim financials."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Flag indicating whether medical necessity was a factor in adjudication — used for clinical quality and denial analysis."
    - name: "cob_processing_result"
      expr: cob_processing_result
      comment: "Result of COB processing for this adjudication — used to segment COB-adjusted financial flows."
    - name: "edit_outcome"
      expr: edit_outcome
      comment: "Outcome of claim edit checks (e.g., passed, failed, bypassed) — used to monitor edit compliance and override patterns."
    - name: "service_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month of service date — used for trend analysis of adjudication financials and volumes."
    - name: "timeliness_flag"
      expr: timeliness_flag
      comment: "Flag indicating whether the adjudication met timeliness standards — used for regulatory compliance monitoring."
  measures:
    - name: "total_adjudications"
      expr: COUNT(1)
      comment: "Total number of adjudication records. Baseline volume metric for adjudication throughput reporting."
    - name: "total_allowed_amount"
      expr: SUM(CAST(allowed_amount AS DOUBLE))
      comment: "Total allowed amount across all adjudications. Core financial KPI representing maximum contractual liability before cost-sharing."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross charge amount submitted for adjudication. Used to measure billed exposure and calculate discount yield."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net payable amount after all adjustments. Represents actual plan financial liability — primary cost management KPI."
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible applied across adjudications. Tracks member cost-sharing burden and deductible accumulation trends."
    - name: "total_oop_amount"
      expr: SUM(CAST(oop_amount AS DOUBLE))
      comment: "Total out-of-pocket amount applied across adjudications. Tracks member financial exposure and OOP maximum utilization."
    - name: "total_cob_adjusted_amount"
      expr: SUM(CAST(cob_adjusted_amount AS DOUBLE))
      comment: "Total amount adjusted through coordination of benefits. Measures COB recovery value — directly impacts net plan liability."
    - name: "total_deductible_accumulator_impact"
      expr: SUM(CAST(accumulator_deductible_impact AS DOUBLE))
      comment: "Total deductible accumulator impact across adjudications. Used to track deductible accumulation velocity and benefit period exposure."
    - name: "total_oop_accumulator_impact"
      expr: SUM(CAST(accumulator_oop_impact AS DOUBLE))
      comment: "Total OOP accumulator impact across adjudications. Used to monitor OOP maximum approach rates and member financial risk."
    - name: "auto_adjudicated_count"
      expr: COUNT(CASE WHEN auto_adjudication_flag = TRUE THEN 1 END)
      comment: "Count of claims auto-adjudicated without manual review. Numerator for auto-adjudication rate — a key operational efficiency KPI."
    - name: "edit_override_count"
      expr: COUNT(CASE WHEN edit_override_flag = TRUE THEN 1 END)
      comment: "Count of adjudications where edit checks were overridden. Tracks compliance risk — high override rates signal potential fraud or process breakdown."
    - name: "avg_allowed_amount"
      expr: AVG(CAST(allowed_amount AS DOUBLE))
      comment: "Average allowed amount per adjudication. Unit cost benchmark used to detect cost trend shifts by claim type and service category."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total post-adjudication adjustment amount. Tracks the financial magnitude of claim corrections and retroactive changes."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial management KPIs covering denial volumes, denied financial amounts, appeal eligibility, medical necessity denials, and resolution outcomes. Used by medical management, compliance, and revenue integrity teams to reduce denial rates and recover revenue."
  source: "`vibe_health_insurance_v1`.`claim`.`denial`"
  dimensions:
    - name: "denial_type"
      expr: denial_type
      comment: "Classification of denial (e.g., clinical, administrative, billing) — primary segmentation for denial root cause analysis."
    - name: "denial_status"
      expr: denial_status
      comment: "Current status of the denial (e.g., upheld, overturned, pending appeal) — used to track denial lifecycle and resolution rates."
    - name: "denial_subtype"
      expr: subtype
      comment: "Granular subtype of denial — used for detailed root cause categorization and targeted intervention programs."
    - name: "carc_code"
      expr: carc_code
      comment: "Claim Adjustment Reason Code — industry-standard code explaining the denial reason, used for payer benchmarking and trend analysis."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Final resolution outcome of the denial (e.g., resolved, appealed, written off) — used to measure denial recovery effectiveness."
    - name: "medical_necessity_flag"
      expr: medical_necessity_flag
      comment: "Flag indicating whether the denial was based on medical necessity — used to track clinical denial rates and UM policy effectiveness."
    - name: "appeal_eligibility_flag"
      expr: appeal_eligibility_flag
      comment: "Flag indicating whether the denial is eligible for appeal — used to prioritize recovery efforts and track appeal opportunity volume."
    - name: "denial_month"
      expr: DATE_TRUNC('MONTH', denial_date)
      comment: "Month of denial date — used for trend analysis of denial volumes and financial impact over time."
    - name: "override_flag"
      expr: override_flag
      comment: "Flag indicating whether the denial was overridden — used to track override patterns and clinical review outcomes."
  measures:
    - name: "total_denials"
      expr: COUNT(1)
      comment: "Total number of denial records. Baseline volume KPI for denial management dashboards and regulatory reporting."
    - name: "total_denied_gross_amount"
      expr: SUM(CAST(denied_gross_amount AS DOUBLE))
      comment: "Total gross amount denied across all denial records. Measures the full financial exposure of denials before any recovery — key revenue integrity KPI."
    - name: "total_denied_net_amount"
      expr: SUM(CAST(denied_net_amount AS DOUBLE))
      comment: "Total net amount denied after adjustments. Represents actual financial impact of denials on plan liability and provider payments."
    - name: "total_denied_adjustment_amount"
      expr: SUM(CAST(denied_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount associated with denials. Tracks the financial magnitude of denial-driven claim corrections."
    - name: "medical_necessity_denial_count"
      expr: COUNT(CASE WHEN medical_necessity_flag = TRUE THEN 1 END)
      comment: "Count of denials based on medical necessity. Tracks clinical denial volume — a key indicator of UM policy stringency and provider compliance."
    - name: "appeal_eligible_denial_count"
      expr: COUNT(CASE WHEN appeal_eligibility_flag = TRUE THEN 1 END)
      comment: "Count of denials eligible for appeal. Quantifies the recoverable denial opportunity — used to prioritize appeal resources and estimate recovery potential."
    - name: "overturned_denial_count"
      expr: COUNT(CASE WHEN denial_status = 'OVERTURNED' THEN 1 END)
      comment: "Count of denials that were overturned. Measures denial reversal rate — high overturn rates signal inappropriate initial denial decisions."
    - name: "avg_denied_net_amount"
      expr: AVG(CAST(denied_net_amount AS DOUBLE))
      comment: "Average net denied amount per denial record. Used to benchmark denial severity and prioritize high-value denial recovery efforts."
    - name: "letter_generated_count"
      expr: COUNT(CASE WHEN letter_generated_flag = TRUE THEN 1 END)
      comment: "Count of denials for which a denial letter was generated. Tracks regulatory compliance with member notification requirements."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment-level financial KPIs covering gross and net payment amounts, tax, adjustments, reconciliation status, and payment channel distribution. Used by finance, treasury, and accounts payable leadership to manage cash flow, reconciliation, and payment integrity."
  source: "`vibe_health_insurance_v1`.`claim`.`payment`"
  dimensions:
    - name: "payment_channel"
      expr: channel
      comment: "Payment delivery channel (e.g., EFT, check, virtual card) — used to analyze channel mix, cost, and reconciliation efficiency."
    - name: "payee_type"
      expr: payee_type
      comment: "Type of payment recipient (e.g., provider, member, facility) — used to segment payment flows by recipient category."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current reconciliation status of the payment — used to track outstanding reconciliation items and financial close readiness."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Flag indicating whether the payment has been reconciled — primary filter for outstanding payment identification."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the payment was voided — used to track void rates and financial restatement activity."
    - name: "is_returned"
      expr: is_returned
      comment: "Flag indicating whether the payment was returned — used to track return rates and recovery of undeliverable payments."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — used for multi-currency financial reporting and FX exposure analysis."
    - name: "payment_cycle"
      expr: cycle
      comment: "Payment processing cycle identifier — used to analyze payment volume and financial exposure by cycle."
  measures:
    - name: "total_payments"
      expr: COUNT(1)
      comment: "Total number of payment records processed. Baseline volume KPI for payment operations and treasury reporting."
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross payment amount before adjustments and taxes. Primary cash outflow metric used by treasury and finance leadership for liquidity management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after all adjustments. Represents actual cash disbursed — core metric for accounts payable and financial close."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax withheld or applied across payments. Used for tax liability reporting and compliance with withholding obligations."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustment amount. Tracks the financial magnitude of payment corrections, recoupments, and retroactive changes."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Count of payments not yet reconciled. Tracks outstanding reconciliation backlog — a key financial close and audit readiness KPI."
    - name: "voided_payment_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Count of voided payments. Tracks payment integrity issues — high void rates signal processing errors or fraud risk."
    - name: "returned_payment_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Count of returned payments. Tracks undeliverable payment volume — used to manage provider data quality and reduce payment waste."
    - name: "avg_net_payment_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net payment amount per payment record. Used to benchmark payment size trends and detect anomalies in payment distributions."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Claim adjustment KPIs covering adjustment volumes, financial magnitudes, overpayment recovery, fraud indicators, and compliance with the 60-day rule. Used by revenue integrity, compliance, and finance leadership to manage post-payment corrections and regulatory obligations."
  source: "`vibe_health_insurance_v1`.`claim`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (e.g., overpayment, underpayment, COB, audit) — primary segmentation for adjustment root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., pending, completed, voided) — used to track adjustment lifecycle and resolution."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of overpayment recovery (e.g., recovered, outstanding, written off) — used to track recovery program effectiveness."
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method used to recover overpayments (e.g., offset, refund, demand letter) — used to optimize recovery strategy mix."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Flag indicating whether the adjustment is fraud-related — used to track fraud-driven financial exposure and SIU referral volume."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating whether the adjustment is a claim reversal — used to track reversal rates and their financial impact."
    - name: "compliance_60_day_rule"
      expr: compliance_60_day_rule
      comment: "Flag indicating compliance with the CMS 60-day overpayment reporting rule — critical for regulatory compliance monitoring."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit that triggered the adjustment (e.g., RAC, RADV, internal) — used to segment audit-driven financial corrections."
    - name: "adjustment_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of adjustment effective date — used for trend analysis of adjustment volumes and financial impact."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether the adjustment requires regulatory reporting — used to ensure compliance reporting completeness."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of claim adjustment records. Baseline volume KPI for revenue integrity and post-payment correction tracking."
    - name: "total_adjusted_amount"
      expr: SUM(CAST(adjusted_amount AS DOUBLE))
      comment: "Total gross adjusted amount across all adjustments. Measures the full financial scope of post-payment corrections — key revenue integrity KPI."
    - name: "total_net_adjustment_amount"
      expr: SUM(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Total net adjustment amount after offsets. Represents actual financial impact of adjustments on plan liability — used for financial restatement reporting."
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original claim amount before adjustment. Used as denominator context for calculating adjustment rate and financial correction magnitude."
    - name: "fraud_adjustment_count"
      expr: COUNT(CASE WHEN is_fraud = TRUE THEN 1 END)
      comment: "Count of adjustments flagged as fraud-related. Tracks fraud-driven financial corrections — used by SIU and compliance leadership."
    - name: "fraud_adjusted_amount"
      expr: SUM(CASE WHEN is_fraud = TRUE THEN CAST(adjusted_amount AS DOUBLE) ELSE 0 END)
      comment: "Total adjusted amount associated with fraud findings. Quantifies fraud financial exposure — a key input to fraud program ROI and risk reporting."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of claim reversals. Tracks reversal volume — high rates indicate adjudication quality issues or provider disputes."
    - name: "non_60day_compliant_count"
      expr: COUNT(CASE WHEN compliance_60_day_rule = FALSE THEN 1 END)
      comment: "Count of adjustments not compliant with the CMS 60-day overpayment reporting rule. Tracks regulatory compliance risk — non-compliance can result in False Claims Act liability."
    - name: "avg_net_adjustment_amount"
      expr: AVG(CAST(net_adjustment_amount AS DOUBLE))
      comment: "Average net adjustment amount per record. Used to benchmark adjustment severity and prioritize high-value recovery cases."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_accumulator`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit accumulator KPIs tracking deductible and OOP accumulation, remaining balances, limit utilization, and reversal activity. Used by member services, actuarial, and benefits administration to monitor member cost-sharing progress and benefit period exposure."
  source: "`vibe_health_insurance_v1`.`claim`.`accumulator`"
  dimensions:
    - name: "accumulator_type"
      expr: accumulator_type
      comment: "Type of accumulator (e.g., deductible, OOP maximum, benefit limit) — primary segmentation for cost-sharing analysis."
    - name: "accumulator_status"
      expr: accumulator_status
      comment: "Current status of the accumulator record — used to filter active vs. closed accumulator periods."
    - name: "benefit_category"
      expr: benefit_category
      comment: "Benefit category associated with the accumulator — used to analyze cost-sharing by benefit type."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business for the accumulator — used to segment cost-sharing metrics by LOB for financial and regulatory reporting."
    - name: "network_tier"
      expr: network_tier
      comment: "Network tier (e.g., in-network, out-of-network) — used to analyze cost-sharing differentials by network participation."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Flag indicating whether the accumulator entry is a reversal — used to track accumulator correction activity."
    - name: "is_adjustment"
      expr: is_adjustment
      comment: "Flag indicating whether the accumulator entry is an adjustment — used to track retroactive accumulator corrections."
    - name: "benefit_period_start_month"
      expr: DATE_TRUNC('MONTH', benefit_period_start)
      comment: "Month of benefit period start — used to align accumulator metrics to benefit year and track accumulation velocity."
  measures:
    - name: "total_accumulated_amount"
      expr: SUM(CAST(accumulated_amount AS DOUBLE))
      comment: "Total amount accumulated toward benefit limits across all accumulator records. Tracks member cost-sharing progress — key input to benefit exhaustion forecasting."
    - name: "total_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total benefit limit amount across all accumulator records. Represents the aggregate cost-sharing ceiling — used for actuarial exposure modeling."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance before benefit limits are reached. Tracks aggregate member cost-sharing headroom — used to forecast future plan liability exposure."
    - name: "avg_accumulated_amount"
      expr: AVG(CAST(accumulated_amount AS DOUBLE))
      comment: "Average accumulated amount per accumulator record. Used to benchmark member cost-sharing utilization and detect outlier accumulation patterns."
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance per accumulator record. Tracks typical member proximity to benefit exhaustion — used in member outreach and care management targeting."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Count of accumulator reversals. Tracks accumulator correction volume — high rates indicate adjudication instability or retroactive eligibility changes."
    - name: "members_near_limit_count"
      expr: COUNT(CASE WHEN CAST(remaining_balance AS DOUBLE) <= 0.10 * CAST(limit_amount AS DOUBLE) THEN 1 END)
      comment: "Count of accumulator records where remaining balance is within 10% of the limit. Identifies members approaching benefit exhaustion — used for proactive care management and financial risk flagging."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coordination of Benefits (COB) KPIs covering primary payer recoveries, net liability after COB, crossover claim volumes, and MSP compliance. Used by COB operations, finance, and compliance leadership to maximize COB recoveries and ensure Medicare Secondary Payer compliance."
  source: "`vibe_health_insurance_v1`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB record (e.g., processed, pending, disputed) — primary segmentation for COB operational dashboards."
    - name: "cob_method"
      expr: method
      comment: "COB calculation method applied (e.g., standard, non-duplication, maintenance of benefits) — used to analyze method mix and financial impact."
    - name: "msp_type"
      expr: msp_type
      comment: "Medicare Secondary Payer type — used for MSP compliance reporting and CMS regulatory submissions."
    - name: "msp_indicator"
      expr: msp_indicator
      comment: "Flag indicating Medicare Secondary Payer applicability — used to segment MSP-impacted claims for compliance monitoring."
    - name: "crossover_claim_flag"
      expr: crossover_claim_flag
      comment: "Flag indicating whether the claim is a Medicaid/Medicare crossover claim — used to track crossover volume and dual-eligible financial flows."
    - name: "medicaid_crossover_indicator"
      expr: medicaid_crossover_indicator
      comment: "Flag indicating Medicaid crossover status — used for dual-eligible program financial analysis and state reporting."
    - name: "process_order"
      expr: process_order
      comment: "Order in which payers are processed for this COB record — used to validate COB sequencing compliance."
    - name: "cob_effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of COB effective date — used for trend analysis of COB recovery volumes and financial impact."
  measures:
    - name: "total_cob_records"
      expr: COUNT(1)
      comment: "Total number of COB records processed. Baseline volume KPI for COB operations and recovery program tracking."
    - name: "total_primary_payer_paid_amount"
      expr: SUM(CAST(primary_payer_paid_amount AS DOUBLE))
      comment: "Total amount paid by the primary payer across all COB records. Measures COB recovery from primary payers — directly reduces plan net liability."
    - name: "total_primary_payer_allowed_amount"
      expr: SUM(CAST(primary_payer_allowed_amount AS DOUBLE))
      comment: "Total amount allowed by the primary payer. Used to benchmark primary payer generosity and calculate secondary liability."
    - name: "total_net_liability_amount"
      expr: SUM(CAST(net_liability_amount AS DOUBLE))
      comment: "Total net plan liability after COB adjustments. Represents actual plan financial exposure after primary payer recovery — core COB financial KPI."
    - name: "total_cob_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total COB adjustment amount applied. Tracks the financial magnitude of COB-driven claim corrections."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross charge amount on COB claims. Used as the baseline for calculating COB savings rate and recovery yield."
    - name: "crossover_claim_count"
      expr: COUNT(CASE WHEN crossover_claim_flag = TRUE THEN 1 END)
      comment: "Count of crossover claims (Medicaid/Medicare dual-eligible). Tracks dual-eligible program volume — used for state and federal reporting obligations."
    - name: "msp_claim_count"
      expr: COUNT(CASE WHEN msp_indicator = TRUE THEN 1 END)
      comment: "Count of Medicare Secondary Payer claims. Tracks MSP compliance volume — non-compliance with MSP rules carries significant CMS penalty risk."
    - name: "avg_net_liability_amount"
      expr: AVG(CAST(net_liability_amount AS DOUBLE))
      comment: "Average net plan liability per COB record. Used to benchmark COB effectiveness and detect anomalies in secondary payer recovery patterns."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`claim_drg`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG (Diagnosis Related Group) payment and case mix KPIs for inpatient claims. Covers DRG payment amounts, case mix index contributions, length of stay benchmarks, and outlier payments. Used by medical economics, actuarial, and hospital contracting teams to manage inpatient cost and case complexity."
  source: "`vibe_health_insurance_v1`.`claim`.`drg`"
  dimensions:
    - name: "drg_type"
      expr: drg_type
      comment: "Type of DRG grouping methodology (e.g., MS-DRG, AP-DRG) — used to segment DRG analytics by grouper type."
    - name: "major_diagnostic_category"
      expr: major_diagnostic_category
      comment: "Major Diagnostic Category (MDC) — broad clinical grouping used for inpatient utilization and cost trend analysis."
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "Flag indicating presence of complication or comorbidity (CC/MCC) — used to analyze case complexity and its impact on DRG weight and payment."
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of DRG assignment (e.g., final, preliminary, disputed) — used to filter confirmed DRG assignments for financial reporting."
    - name: "grouper_method"
      expr: grouper_method
      comment: "DRG grouper software method used — used to ensure consistency in DRG analytics across grouper versions."
    - name: "drg_effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of DRG effective date — used for trend analysis of inpatient case mix and payment patterns."
  measures:
    - name: "total_drg_cases"
      expr: COUNT(1)
      comment: "Total number of DRG-assigned inpatient cases. Baseline volume KPI for inpatient utilization reporting."
    - name: "total_drg_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total DRG-based payment amount across all inpatient cases. Primary inpatient cost KPI used by hospital contracting and medical economics teams."
    - name: "total_outlier_payment_amount"
      expr: SUM(CAST(outlier_payment_amount AS DOUBLE))
      comment: "Total outlier payment amount for high-cost inpatient cases. Tracks catastrophic case financial exposure — used for stop-loss and reinsurance management."
    - name: "total_case_mix_index_contribution"
      expr: SUM(CAST(case_mix_index_contribution AS DOUBLE))
      comment: "Total case mix index contribution across all DRG cases. Aggregate measure of clinical complexity — used to benchmark hospital case mix and negotiate contract rates."
    - name: "avg_drg_weight"
      expr: AVG(CAST(weight AS DOUBLE))
      comment: "Average DRG weight across all cases. Measures average case complexity — a key input to inpatient cost benchmarking and actuarial pricing."
    - name: "avg_arithmetic_mean_los"
      expr: AVG(CAST(arithmetic_mean_los AS DOUBLE))
      comment: "Average arithmetic mean length of stay across DRG cases. Benchmarks actual LOS against DRG norms — used to identify outlier utilization and care management opportunities."
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay across DRG cases. Standard LOS efficiency benchmark used in hospital performance evaluation and contract negotiations."
    - name: "avg_base_rate_applied"
      expr: AVG(CAST(base_rate_applied AS DOUBLE))
      comment: "Average base rate applied in DRG payment calculations. Used to monitor contract rate application consistency and detect rate configuration errors."
    - name: "cc_mcc_case_count"
      expr: COUNT(CASE WHEN cc_mcc_flag = TRUE THEN 1 END)
      comment: "Count of inpatient cases with complications or comorbidities (CC/MCC). Tracks high-complexity case volume — used for case management targeting and cost risk stratification."
$$;