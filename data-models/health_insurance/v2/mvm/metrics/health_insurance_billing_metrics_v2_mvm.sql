-- Metric views for domain: billing | Business: Health_Insurance | Version: 2 | Generated on: 2026-06-23 01:44:05

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over premium invoices — tracks billed premium volume, subsidy utilization, collection efficiency, and retroactive adjustment exposure across billing periods."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., DRAFT, ISSUED, PAID, VOID) — primary filter for collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., REGULAR, RETROACTIVE, ADJUSTMENT) — used to segment billing volume by type."
    - name: "collection_status"
      expr: collection_status
      comment: "Receivables collection state (e.g., CURRENT, DELINQUENT, IN_COLLECTIONS) — drives AR aging and collections strategy."
    - name: "line_of_business"
      expr: line_of_business
      comment: "Line of business associated with the invoice (e.g., Individual, Group, Medicare) — enables LOB-level revenue segmentation."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month bucket of the billing period start date — supports monthly trend analysis of premium billed."
    - name: "billing_period_year"
      expr: YEAR(billing_period_start)
      comment: "Calendar year of the billing period — supports annual premium revenue reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method recorded on the invoice (e.g., ACH, CREDIT_CARD, CHECK) — used to analyze payment channel mix."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was submitted (e.g., ONLINE, MAIL, AGENT) — supports channel efficiency analysis."
    - name: "is_eligible_for_subsidy"
      expr: is_eligible_for_subsidy
      comment: "Boolean flag indicating whether the invoice qualifies for APTC subsidy — used to segment subsidized vs. unsubsidized premium volume."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts — supports multi-currency reporting."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month bucket of the invoice due date — used for cash flow forecasting and aging analysis."
  measures:
    - name: "total_premium_billed"
      expr: SUM(CAST(total_premium_amount AS DOUBLE))
      comment: "Total gross premium billed across all invoices in the period. Core revenue KPI used in financial reporting and premium yield analysis."
    - name: "total_net_amount_due"
      expr: SUM(CAST(net_amount_due AS DOUBLE))
      comment: "Total net amount due after discounts and adjustments. Represents actual receivables balance — key for AR management and cash flow forecasting."
    - name: "total_subsidy_offset"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across invoices, including APTC and other subsidy offsets. Measures subsidy program financial impact."
    - name: "total_retroactive_adjustment_amount"
      expr: SUM(CAST(retroactive_adjustment_amount AS DOUBLE))
      comment: "Total retroactive premium adjustments applied. High values signal enrollment data quality issues or late eligibility changes — a risk and compliance KPI."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed across invoices. Required for tax liability reporting and regulatory compliance."
    - name: "total_refunds_issued"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts issued on invoices. Elevated refund volume may indicate billing errors, retroactive terminations, or overpayment patterns."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices generated. Baseline volume metric for billing operations throughput and capacity planning."
    - name: "avg_premium_per_invoice"
      expr: AVG(CAST(total_premium_amount AS DOUBLE))
      comment: "Average gross premium per invoice. Tracks premium yield trends and supports per-member cost benchmarking."
    - name: "subsidy_eligible_invoice_count"
      expr: COUNT(CASE WHEN is_eligible_for_subsidy = TRUE THEN 1 END)
      comment: "Count of invoices eligible for APTC subsidy. Used to measure subsidy program reach and enrollment mix."
    - name: "net_to_gross_premium_ratio"
      expr: ROUND(100.0 * SUM(CAST(net_amount_due AS DOUBLE)) / NULLIF(SUM(CAST(total_premium_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of net amount due to gross premium billed, expressed as a percentage. Measures the effective discount/subsidy rate applied to billed premiums — a key pricing and subsidy efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection KPIs — tracks cash received, NSF/failed payment rates, unapplied cash, and suspense resolution efficiency for premium payments."
  source: "`vibe_health_insurance_v1`.`billing`.`premium_payment`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of payment transaction (e.g., PAYMENT, REVERSAL, ADJUSTMENT) — used to segment cash inflows from reversals and adjustments."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the payment (e.g., RECONCILED, UNRECONCILED, PENDING) — key for cash reconciliation and close process."
    - name: "suspense_status"
      expr: suspense_status
      comment: "Status of payments held in suspense (e.g., OPEN, RESOLVED, ESCALATED) — drives suspense resolution workflow prioritization."
    - name: "payer_type"
      expr: payer_type
      comment: "Classification of the payer (e.g., MEMBER, EMPLOYER, GOVERNMENT) — enables payment source mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — supports multi-currency cash reporting."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of payment resolution (e.g., APPLIED, REFUNDED, WRITTEN_OFF) — used to track payment lifecycle completion rates."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Boolean flag for non-sufficient funds (NSF) payments. Segments failed payments for collections and member outreach workflows."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month bucket of payment creation timestamp — supports monthly cash collection trend analysis."
  measures:
    - name: "total_payment_amount_collected"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross payment amount received. Primary cash collection KPI — directly tied to premium revenue realization."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payment amount after fees and adjustments. Represents actual cash applied to member accounts — used in financial close and AR reduction reporting."
    - name: "total_unapplied_cash"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment amounts sitting unallocated. High unapplied cash signals operational inefficiency and creates revenue recognition risk."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total payment adjustments applied. Tracks correction volume — elevated adjustments may indicate billing or enrollment data quality issues."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total transaction fees charged on payments. Informs payment channel cost analysis and fee revenue reporting."
    - name: "total_tax_on_payments"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts collected on payments. Required for tax liability reconciliation."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed. Baseline throughput metric for payment operations."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Count of payments flagged as NSF (non-sufficient funds). Elevated NSF rates signal member financial distress and collection risk."
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that resulted in NSF. A key risk KPI — rising NSF rates trigger collections intervention and grace period monitoring."
    - name: "suspense_payment_count"
      expr: COUNT(CASE WHEN suspense_status IS NOT NULL AND suspense_status != 'RESOLVED' THEN 1 END)
      comment: "Count of payments currently in unresolved suspense. Unresolved suspense represents cash that cannot be applied to member accounts — a critical operational KPI."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks payment size trends and supports per-member premium affordability analysis."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment allocation efficiency KPIs — tracks how collected payments are applied to invoices, overpayment exposure, variance analysis, and reconciliation completeness."
  source: "`vibe_health_insurance_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation (e.g., APPLIED, PENDING, REVERSED) — primary filter for allocation workflow management."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g., PREMIUM, FEE, TAX, ADJUSTMENT) — used to segment payment application by purpose."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the allocation — drives financial close and AR reconciliation workflows."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Type of reconciliation process applied (e.g., AUTO, MANUAL, EXCEPTION) — used to measure automation rate in payment reconciliation."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the allocation (e.g., ACH, CHECK, CREDIT_CARD) — supports payment channel mix analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was received — used to analyze channel-level collection efficiency."
    - name: "is_overpayment"
      expr: is_overpayment
      comment: "Boolean flag indicating the allocation resulted in an overpayment — used to track overpayment exposure and refund liability."
    - name: "is_suspense_resolution"
      expr: is_suspense_resolution
      comment: "Boolean flag indicating this allocation resolved a suspense item — used to measure suspense clearance throughput."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month bucket of the allocation date — supports monthly cash application trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation — supports multi-currency reconciliation reporting."
    - name: "variance_reason"
      expr: variance_reason
      comment: "Reason code for payment variance (e.g., ROUNDING, PARTIAL_PAYMENT, DISPUTE) — used to categorize and resolve billing discrepancies."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated from payments to invoice lines. Core cash application KPI — measures how much collected cash has been successfully applied."
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed AS DOUBLE))
      comment: "Total billed amount across allocations. Used as the denominator for collection rate calculations."
    - name: "total_collected_amount"
      expr: SUM(CAST(total_collected AS DOUBLE))
      comment: "Total collected amount across allocations. Measures actual cash received against billed amounts."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between billed and collected amounts. Elevated variance signals billing disputes, partial payments, or data quality issues — a key AR quality KPI."
    - name: "total_discount_applied"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amounts applied during allocation. Tracks subsidy and promotional discount utilization in the payment application process."
    - name: "total_adjustments_applied"
      expr: SUM(CAST(total_adjustments AS DOUBLE))
      comment: "Total adjustment amounts applied across allocations. High adjustment volumes indicate retroactive billing corrections or dispute resolutions."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_collected AS DOUBLE)) / NULLIF(SUM(CAST(total_billed AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amounts successfully collected. A primary revenue realization KPI — directly measures billing-to-cash conversion efficiency."
    - name: "overpayment_count"
      expr: COUNT(CASE WHEN is_overpayment = TRUE THEN 1 END)
      comment: "Count of allocations resulting in overpayments. Overpayments create refund liabilities and member satisfaction risk — tracked for operational quality."
    - name: "suspense_resolution_count"
      expr: COUNT(CASE WHEN is_suspense_resolution = TRUE THEN 1 END)
      comment: "Count of allocations that resolved suspense items. Measures suspense clearance throughput — a key operational efficiency KPI for the billing team."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of payment allocations processed. Baseline throughput metric for cash application operations."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "APTC subsidy program KPIs — tracks subsidy utilization, annual cap exposure, reconciliation status, and year-to-date applied amounts for ACA compliance and financial reporting."
  source: "`vibe_health_insurance_v1`.`billing`.`aptc_subsidy`"
  dimensions:
    - name: "aptc_subsidy_status"
      expr: aptc_subsidy_status
      comment: "Current status of the APTC subsidy record (e.g., ACTIVE, TERMINATED, PENDING) — primary filter for active subsidy population analysis."
    - name: "cms_reconciliation_status"
      expr: cms_reconciliation_status
      comment: "CMS reconciliation status for the subsidy (e.g., RECONCILED, PENDING, DISCREPANCY) — critical for ACA regulatory compliance and CMS settlement reporting."
    - name: "subsidy_type"
      expr: subsidy_type
      comment: "Type of subsidy (e.g., APTC, CSR, STATE_SUBSIDY) — used to segment subsidy program costs by type."
    - name: "csr_variant"
      expr: csr_variant
      comment: "Cost-sharing reduction variant associated with the subsidy — used to analyze CSR plan variant distribution and associated subsidy costs."
    - name: "exchange_code"
      expr: exchange_code
      comment: "Exchange or marketplace code where the subsidy was granted — supports state/exchange-level subsidy reporting."
    - name: "subsidy_effective_month"
      expr: DATE_TRUNC('MONTH', subsidy_effective_date)
      comment: "Month bucket of subsidy effective date — supports monthly subsidy enrollment trend analysis."
    - name: "subsidy_termination_month"
      expr: DATE_TRUNC('MONTH', subsidy_termination_date)
      comment: "Month bucket of subsidy termination date — used to track subsidy attrition and termination patterns."
  measures:
    - name: "total_monthly_aptc_amount"
      expr: SUM(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Total monthly APTC subsidy amounts across all active subsidies. Primary subsidy cost KPI — directly impacts net premium revenue and CMS settlement obligations."
    - name: "total_annual_aptc_cap"
      expr: SUM(CAST(annual_aptc_cap AS DOUBLE))
      comment: "Total annual APTC cap across all subsidy records. Measures maximum subsidy exposure — used in financial planning and CMS liability forecasting."
    - name: "total_ytd_aptc_applied"
      expr: SUM(CAST(ytd_aptc_applied AS DOUBLE))
      comment: "Total year-to-date APTC amounts applied. Tracks actual subsidy utilization against annual caps — a key ACA compliance and financial close KPI."
    - name: "avg_monthly_aptc_per_member"
      expr: AVG(CAST(aptc_monthly_amount AS DOUBLE))
      comment: "Average monthly APTC subsidy per member record. Benchmarks per-member subsidy cost — used in actuarial pricing and subsidy adequacy analysis."
    - name: "cap_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(ytd_aptc_applied AS DOUBLE)) / NULLIF(SUM(CAST(annual_aptc_cap AS DOUBLE)), 0), 2)
      comment: "Percentage of annual APTC cap consumed year-to-date. Measures subsidy budget burn rate — critical for CMS reconciliation and year-end settlement planning."
    - name: "active_subsidy_count"
      expr: COUNT(CASE WHEN aptc_subsidy_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active APTC subsidies. Measures subsidized membership size — a key ACA program participation metric."
    - name: "pending_cms_reconciliation_count"
      expr: COUNT(CASE WHEN cms_reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Count of subsidies with unresolved CMS reconciliation status. Unreconciled subsidies represent regulatory risk and potential CMS clawback exposure."
    - name: "total_subsidy_count"
      expr: COUNT(1)
      comment: "Total number of APTC subsidy records. Baseline volume metric for subsidy program scale."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_cms_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS remittance KPIs — tracks government payment receipts, risk adjustment settlements, MLR rebate offsets, and reconciliation status for Medicare/ACA regulatory financial reporting."
  source: "`vibe_health_insurance_v1`.`billing`.`cms_remittance`"
  dimensions:
    - name: "remittance_status"
      expr: remittance_status
      comment: "Current status of the CMS remittance (e.g., RECEIVED, PENDING, REJECTED) — primary filter for remittance lifecycle management."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation state of the remittance — critical for CMS settlement close and regulatory reporting."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of CMS payment (e.g., CAPITATION, RISK_ADJUSTMENT, MLR_REBATE) — used to segment government payment streams by program."
    - name: "submission_type"
      expr: submission_type
      comment: "Type of CMS submission (e.g., INITIAL, ADJUSTMENT, FINAL) — used to track submission lifecycle and identify adjustment patterns."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for remittance adjustment — used to categorize and investigate CMS payment discrepancies."
    - name: "is_eligible"
      expr: is_eligible
      comment: "Boolean flag indicating member eligibility at time of remittance — used to identify ineligible payment risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the remittance — supports multi-currency government payment reporting."
    - name: "payment_period_month"
      expr: DATE_TRUNC('MONTH', payment_period_start)
      comment: "Month bucket of the CMS payment period — supports monthly government revenue trend analysis."
    - name: "payment_period_year"
      expr: YEAR(payment_period_start)
      comment: "Calendar year of the CMS payment period — supports annual CMS revenue and risk adjustment reporting."
  measures:
    - name: "total_gross_payment_received"
      expr: SUM(CAST(gross_payment_amount AS DOUBLE))
      comment: "Total gross CMS payment amounts received. Primary government revenue KPI — represents capitation and risk-adjusted payments from CMS."
    - name: "total_net_remittance_amount"
      expr: SUM(CAST(net_remittance_amount AS DOUBLE))
      comment: "Total net remittance after risk adjustments and MLR rebate offsets. Represents actual government revenue realized — key for financial planning and margin analysis."
    - name: "total_risk_adjustment_amount"
      expr: SUM(CAST(risk_adjustment_amount AS DOUBLE))
      comment: "Total risk adjustment amounts applied to CMS remittances. Measures risk score impact on government revenue — a critical actuarial and financial KPI."
    - name: "total_mlr_rebate_offset"
      expr: SUM(CAST(mlr_rebate_offset_amount AS DOUBLE))
      comment: "Total MLR rebate offsets applied against CMS remittances. Tracks ACA medical loss ratio rebate obligations — a key regulatory compliance and profitability KPI."
    - name: "avg_net_remittance_per_record"
      expr: AVG(CAST(net_remittance_amount AS DOUBLE))
      comment: "Average net remittance amount per CMS remittance record. Benchmarks per-record government payment yield — used in revenue forecasting."
    - name: "risk_adjustment_impact_pct"
      expr: ROUND(100.0 * SUM(CAST(risk_adjustment_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_payment_amount AS DOUBLE)), 0), 2)
      comment: "Risk adjustment as a percentage of gross CMS payment. Measures the magnitude of risk score adjustments on government revenue — a key actuarial performance indicator."
    - name: "remittance_count"
      expr: COUNT(1)
      comment: "Total number of CMS remittance records. Baseline volume metric for government payment processing throughput."
    - name: "unreconciled_remittance_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'RECONCILED' THEN 1 END)
      comment: "Count of CMS remittances not yet reconciled. Unreconciled remittances represent open regulatory risk and potential revenue leakage."
    - name: "ineligible_remittance_count"
      expr: COUNT(CASE WHEN is_eligible = FALSE THEN 1 END)
      comment: "Count of remittances where the member was flagged as ineligible. Ineligible remittances create CMS clawback risk and compliance exposure."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace period risk KPIs — tracks members in grace period, termination risk, APTC exposure during grace, and resolution outcomes for ACA compliance and collections management."
  source: "`vibe_health_insurance_v1`.`billing`.`grace_period`"
  dimensions:
    - name: "grace_period_status"
      expr: grace_period_status
      comment: "Current status of the grace period (e.g., ACTIVE, EXPIRED, RESOLVED, TERMINATED) — primary filter for at-risk member population analysis."
    - name: "grace_period_type"
      expr: grace_period_type
      comment: "Type of grace period (e.g., APTC_90_DAY, STANDARD_30_DAY) — used to segment grace period population by regulatory rule type."
    - name: "outcome"
      expr: outcome
      comment: "Resolution outcome of the grace period (e.g., PAID, TERMINATED, EXTENDED) — used to measure grace period resolution rates and termination risk."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the grace period initiation — used to categorize root causes of non-payment and inform member outreach strategies."
    - name: "state_code"
      expr: state_code
      comment: "State where the grace period applies — supports state-level regulatory compliance reporting and collections strategy."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction governing the grace period rules — used for multi-state compliance analysis."
    - name: "is_eligible_for_aptc"
      expr: is_eligible_for_aptc
      comment: "Boolean flag indicating APTC eligibility during grace period — used to quantify APTC subsidy at-risk exposure during non-payment periods."
    - name: "extension_flag"
      expr: extension_flag
      comment: "Boolean flag indicating the grace period was extended — used to track extension rates and associated regulatory risk."
    - name: "termination_warning_issued"
      expr: termination_warning_issued
      comment: "Boolean flag indicating a termination warning was issued — used to measure collections outreach effectiveness."
    - name: "grace_period_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month bucket of grace period start date — supports monthly grace period initiation trend analysis."
  measures:
    - name: "total_subsidy_at_risk"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts associated with grace period records. Measures government subsidy exposure during non-payment periods — a critical ACA compliance and financial risk KPI."
    - name: "grace_period_count"
      expr: COUNT(1)
      comment: "Total number of grace period records. Baseline metric for non-payment population size — used in collections capacity planning."
    - name: "active_grace_period_count"
      expr: COUNT(CASE WHEN grace_period_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active grace periods. Measures real-time at-risk member population — a key operational and risk management KPI."
    - name: "terminated_grace_period_count"
      expr: COUNT(CASE WHEN outcome = 'TERMINATED' THEN 1 END)
      comment: "Count of grace periods resulting in policy termination. Measures member attrition due to non-payment — directly impacts membership and revenue."
    - name: "termination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outcome = 'TERMINATED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods resulting in policy termination. A primary member retention and revenue risk KPI — rising termination rates signal affordability or collections process issues."
    - name: "aptc_eligible_grace_count"
      expr: COUNT(CASE WHEN is_eligible_for_aptc = TRUE THEN 1 END)
      comment: "Count of grace periods where the member is APTC-eligible. APTC members in grace have a 90-day grace period under ACA — this population requires priority outreach to avoid CMS clawback."
    - name: "extension_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN extension_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of grace periods that received an extension. Elevated extension rates may indicate systemic payment processing issues or member hardship patterns."
    - name: "avg_subsidy_at_risk_per_grace"
      expr: AVG(CAST(subsidy_amount AS DOUBLE))
      comment: "Average APTC subsidy amount per grace period record. Benchmarks per-member subsidy exposure during non-payment — used in risk-weighted collections prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account health KPIs — tracks account balance exposure, APTC subsidy distribution, auto-pay adoption, credit utilization, and PMPM rate benchmarking across the member account portfolio."
  source: "`vibe_health_insurance_v1`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the billing account (e.g., ACTIVE, SUSPENDED, CLOSED) — primary filter for active account portfolio analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., INDIVIDUAL, GROUP, EMPLOYER) — used to segment account portfolio by customer type."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing cycles (e.g., MONTHLY, QUARTERLY, ANNUAL) — used to analyze billing cycle mix and cash flow timing."
    - name: "billing_method"
      expr: billing_method
      comment: "Method of billing delivery (e.g., ELECTRONIC, PAPER, EDI) — used to track digital billing adoption and associated cost reduction."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections state of the account (e.g., CURRENT, DELINQUENT, IN_COLLECTIONS, WRITTEN_OFF) — primary filter for AR aging and collections strategy."
    - name: "auto_pay_enrollment"
      expr: auto_pay_enrollment
      comment: "Boolean flag for auto-pay enrollment — used to measure auto-pay adoption rate and its correlation with payment success rates."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Boolean flag for tax-exempt accounts — used to segment tax-exempt vs. taxable account populations for compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the account — supports multi-currency portfolio reporting."
    - name: "billing_cycle_type"
      expr: billing_cycle_type
      comment: "Type of billing cycle (e.g., CALENDAR, ANNIVERSARY) — used to analyze billing cycle distribution and operational scheduling."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the account became effective — used for account vintage analysis and cohort-based performance tracking."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all billing accounts. Primary AR exposure KPI — measures total receivables at risk across the account portfolio."
    - name: "total_payment_due_amount"
      expr: SUM(CAST(payment_due_amount AS DOUBLE))
      comment: "Total amount currently due across all accounts. Measures near-term cash collection obligation — used in cash flow forecasting and collections prioritization."
    - name: "total_aptc_amount"
      expr: SUM(CAST(aptc_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts applied across accounts. Measures government subsidy dependency in the account portfolio — a key ACA financial planning KPI."
    - name: "total_subsidy_amount"
      expr: SUM(CAST(subsidy_amount AS DOUBLE))
      comment: "Total subsidy amounts (all types) applied across accounts. Tracks total subsidy program cost at the account level."
    - name: "avg_pmpm_rate"
      expr: AVG(CAST(pmpm_rate AS DOUBLE))
      comment: "Average per-member-per-month premium rate across accounts. Core actuarial pricing KPI — benchmarks premium adequacy and supports rate setting decisions."
    - name: "avg_apr_rate"
      expr: AVG(CAST(apr_rate AS DOUBLE))
      comment: "Average APR rate across accounts. Tracks financing cost exposure in the account portfolio — relevant for accounts with payment plan arrangements."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Measures total credit exposure — used in credit risk management and underwriting review."
    - name: "credit_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(current_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of total credit limit currently utilized. Measures portfolio-level credit risk concentration — elevated utilization signals increased default risk."
    - name: "auto_pay_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_pay_enrollment = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts enrolled in auto-pay. Auto-pay enrollment is strongly correlated with payment success rates — a key operational efficiency and member retention KPI."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN collection_status = 'DELINQUENT' THEN 1 END)
      comment: "Count of accounts in delinquent status. Measures collections risk exposure — used to size collections team capacity and prioritize outreach."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline portfolio size metric — used for per-account normalization of other KPIs."
$$;

CREATE OR REPLACE VIEW `vibe_health_insurance_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level billing KPIs — tracks premium composition, APTC and CSR subsidy application, employer/employee contribution split, retroactive adjustment exposure, and refund activity at the line level."
  source: "`vibe_health_insurance_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice line (e.g., PAID, UNPAID, PARTIAL, VOID) — primary filter for receivables analysis at the line level."
    - name: "premium_status"
      expr: premium_status
      comment: "Status of the premium on this line (e.g., ACTIVE, TERMINATED, SUSPENDED) — used to segment active vs. inactive premium lines."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Coverage tier of the plan (e.g., BRONZE, SILVER, GOLD, PLATINUM) — used to analyze premium volume and subsidy distribution by metal tier."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for premium adjustment — used to categorize and investigate billing correction patterns."
    - name: "is_refund"
      expr: is_refund
      comment: "Boolean flag indicating the line represents a refund — used to separate refund lines from standard billing lines."
    - name: "retroactive_adjustment_flag"
      expr: retroactive_adjustment_flag
      comment: "Boolean flag for retroactive premium adjustments — used to measure retroactive billing volume and associated data quality risk."
    - name: "premium_reconciliation_flag"
      expr: premium_reconciliation_flag
      comment: "Boolean flag indicating the line requires premium reconciliation — used to track reconciliation backlog."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Boolean flag indicating the line is subject to regulatory reporting — used to scope regulatory submission populations."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month bucket of the billing period start — supports monthly premium line trend analysis."
    - name: "premium_source_system"
      expr: premium_source_system
      comment: "Source system that originated the premium line — used to track data lineage and identify source system quality issues."
  measures:
    - name: "total_premium_amount"
      expr: SUM(CAST(premium_amount AS DOUBLE))
      comment: "Total gross premium amount across all invoice lines. Core revenue KPI at the line level — used for premium revenue decomposition by coverage tier, period, and plan."
    - name: "total_aptc_subsidy_applied"
      expr: SUM(CAST(aptc_subsidy_amount AS DOUBLE))
      comment: "Total APTC subsidy amounts applied at the invoice line level. Measures government subsidy utilization in premium billing — critical for ACA financial reporting."
    - name: "total_csr_adjustment_amount"
      expr: SUM(CAST(csr_adjustment_amount AS DOUBLE))
      comment: "Total cost-sharing reduction adjustment amounts applied. Tracks CSR program financial impact on premium lines — required for CMS reconciliation."
    - name: "total_employee_contribution"
      expr: SUM(CAST(employee_contribution AS DOUBLE))
      comment: "Total employee premium contributions across invoice lines. Measures member-paid premium share — used in group benefit cost-sharing analysis."
    - name: "total_employer_contribution"
      expr: SUM(CAST(employer_contribution AS DOUBLE))
      comment: "Total employer premium contributions across invoice lines. Measures employer-paid premium share — used in group benefit cost analysis and employer reporting."
    - name: "total_tax_on_lines"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amounts billed at the invoice line level. Required for tax liability reporting and regulatory compliance."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts on invoice lines. Elevated refunds signal retroactive terminations, billing errors, or enrollment corrections."
    - name: "total_line_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total amount across all invoice lines including premium, tax, and adjustments. Represents total billing obligation at the line level."
    - name: "retroactive_adjustment_line_count"
      expr: COUNT(CASE WHEN retroactive_adjustment_flag = TRUE THEN 1 END)
      comment: "Count of invoice lines with retroactive adjustments. High retroactive adjustment volume indicates enrollment data quality issues and creates billing complexity."
    - name: "subsidy_coverage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(aptc_subsidy_amount AS DOUBLE)) / NULLIF(SUM(CAST(premium_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross premium covered by APTC subsidy at the line level. Measures subsidy dependency in the premium portfolio — a key ACA program effectiveness KPI."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Baseline billing volume metric — used for per-line normalization and billing operations throughput analysis."
$$;