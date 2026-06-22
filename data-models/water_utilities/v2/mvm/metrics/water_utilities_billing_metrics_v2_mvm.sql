-- Metric views for domain: billing | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing invoice KPIs tracking revenue billed, charge composition, collection risk, and billing cycle performance for water utility customers."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. OPEN, PAID, VOID, DISPUTED) — primary filter for AR aging and collection analysis."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g. REGULAR, FINAL, ESTIMATED) — used to separate routine billing from final/estimated reads."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice was delivered to the customer (e.g. PAPER, EMAIL, PORTAL) — informs paperless adoption and delivery cost analysis."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating the invoice was generated from an estimated read rather than an actual meter read — key quality indicator."
    - name: "is_final"
      expr: is_final
      comment: "Flag indicating this is a final bill (account closure) — used to track churn and service termination trends."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates the invoice is under customer dispute — drives dispute resolution workload and revenue-at-risk reporting."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month — primary time dimension for monthly billing cycle trend analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start truncated to month — aligns revenue to the service period rather than invoice generation date."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month — used for cash flow forecasting and collections scheduling."
    - name: "water_consumption_uom"
      expr: water_consumption_uom
      comment: "Unit of measure for water consumption on the invoice (e.g. CCF, GAL) — ensures consistent volume aggregation across rate schedules."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice — relevant for multi-jurisdiction utilities operating across currency boundaries."
  measures:
    - name: "total_amount_due"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total billed revenue across all invoices in the period — the primary top-line revenue KPI for the billing domain."
    - name: "total_water_charge_amount"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Sum of water service charges billed — isolates water revenue from wastewater and stormwater for rate case and regulatory reporting."
    - name: "total_wastewater_charge_amount"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Sum of wastewater service charges billed — tracks wastewater revenue stream separately for cost-of-service analysis."
    - name: "total_stormwater_charge_amount"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Sum of stormwater charges billed — monitors stormwater fee revenue for infrastructure funding compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across invoices — required for tax remittance reconciliation and regulatory reporting."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed — indicates collection pressure and customer payment behavior trends."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Net adjustments applied to invoices — tracks billing corrections, credits, and dispute resolutions impacting revenue."
    - name: "total_water_consumption_volume"
      expr: SUM(CAST(water_consumption_volume AS DOUBLE))
      comment: "Total water volume billed across invoices — core operational KPI linking consumption to revenue for rate adequacy analysis."
    - name: "avg_amount_due_per_invoice"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount — tracks affordability trends and detects anomalies in billing amounts across customer segments."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices generated — baseline billing volume metric for operational capacity and cycle performance."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices currently under dispute — key customer satisfaction and revenue-at-risk indicator."
    - name: "estimated_invoice_count"
      expr: COUNT(CASE WHEN is_estimated = TRUE THEN 1 END)
      comment: "Number of invoices generated from estimated reads — high values signal meter access or read quality issues requiring operational intervention."
    - name: "estimated_invoice_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_estimated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices based on estimated reads — regulatory and operational KPI; high rates trigger meter read improvement programs."
    - name: "disputed_invoice_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices in dispute — customer satisfaction and billing accuracy KPI; elevated rates trigger billing process reviews."
    - name: "avg_water_consumption_volume"
      expr: AVG(CAST(water_consumption_volume AS DOUBLE))
      comment: "Average water consumption volume per invoice — used for demand forecasting, conservation program evaluation, and rate design."
    - name: "total_previous_balance_amount"
      expr: SUM(CAST(previous_balance_amount AS DOUBLE))
      comment: "Sum of prior-period balances carried forward onto invoices — proxy for outstanding AR and collection effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio health metrics covering AR aging, collection risk, payment behavior, and account lifecycle for water utility customer accounts."
  source: "`vibe_water_utilities_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g. ACTIVE, CLOSED, SUSPENDED) — primary segmentation for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. RESIDENTIAL, COMMERCIAL, INDUSTRIAL) — drives rate schedule assignment and revenue segmentation."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle assignment for the account — used for workload balancing and cycle-level billing performance analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often the account is billed (e.g. MONTHLY, BIMONTHLY) — affects cash flow timing and customer experience."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections stage of the account (e.g. CURRENT, DELINQUENT, WRITE-OFF) — primary driver of collections workflow prioritization."
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Whether the account is enrolled in autopay — autopay adoption reduces delinquency and lowers payment processing costs."
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Whether the account receives paperless bills — tracks digital adoption and associated cost savings."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit risk rating of the account — used for deposit policy, credit limit setting, and collections risk stratification."
    - name: "opened_date_year"
      expr: DATE_TRUNC('YEAR', opened_date)
      comment: "Year the account was opened — enables cohort analysis of account aging and long-term customer retention."
    - name: "last_bill_date_month"
      expr: DATE_TRUNC('MONTH', last_bill_date)
      comment: "Month of the most recent bill — identifies accounts that may have missed a billing cycle."
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts — baseline portfolio size metric for capacity planning and market penetration analysis."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts — primary AR metric for financial close and cash flow management."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due balance across the portfolio — key collections risk KPI; drives disconnection and payment plan decisions."
    - name: "total_aging_current"
      expr: SUM(CAST(aging_current AS DOUBLE))
      comment: "Sum of current-period (0–30 day) AR balances — baseline for AR aging waterfall analysis."
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days AS DOUBLE))
      comment: "Sum of 30-day delinquent AR balances — early-stage delinquency indicator for proactive collections outreach."
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days AS DOUBLE))
      comment: "Sum of 60-day delinquent AR balances — mid-stage delinquency requiring escalated collections action."
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_90_days AS DOUBLE))
      comment: "Sum of 90-day delinquent AR balances — high-risk delinquency bucket; accounts here are candidates for disconnection."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_over_90_days AS DOUBLE))
      comment: "Sum of AR balances over 90 days past due — severe delinquency; primary input for bad debt reserve and write-off decisions."
    - name: "total_deposit_on_file"
      expr: SUM(CAST(deposit_on_file AS DOUBLE))
      comment: "Total customer deposits held — liability metric for financial reporting and deposit adequacy assessment against delinquent AR."
    - name: "total_current_charges"
      expr: SUM(CAST(current_charges AS DOUBLE))
      comment: "Total current-period charges billed across accounts — revenue recognition metric for the current billing cycle."
    - name: "avg_current_balance_per_account"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per account — benchmarks individual account exposure and detects outlier high-balance accounts."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN past_due_amount > 0 THEN 1 END)
      comment: "Number of accounts with any past-due balance — headline delinquency count for collections team sizing and performance tracking."
    - name: "delinquency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN past_due_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with past-due balances — portfolio-level delinquency rate; regulatory and executive KPI for affordability programs."
    - name: "autopay_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN autopay_enrolled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts enrolled in autopay — higher autopay rates correlate with lower delinquency and reduced payment processing costs."
    - name: "paperless_billing_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN paperless_billing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts on paperless billing — tracks digital transformation progress and associated print/mail cost reduction."
    - name: "total_late_fee_assessed"
      expr: SUM(CAST(late_fee_assessed AS DOUBLE))
      comment: "Total late fees assessed across accounts — revenue from penalty charges; also an affordability and customer hardship indicator."
    - name: "total_reconnection_fee"
      expr: SUM(CAST(reconnection_fee AS DOUBLE))
      comment: "Total reconnection fees assessed — tracks service interruption volume and associated revenue; high values signal collections process effectiveness."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average of the most recent payment amount per account — proxy for typical payment size and customer payment capacity."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection KPIs tracking cash receipts, payment channel mix, NSF/reversal rates, and unapplied cash for water utility billing operations."
  source: "`vibe_water_utilities_v1`.`billing`.`payment`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Payment channel used by the customer (e.g. ONLINE, IVR, WALK-IN, LOCKBOX) — drives channel cost analysis and digital adoption strategy."
    - name: "card_type"
      expr: card_type
      comment: "Type of payment card used (e.g. VISA, MASTERCARD, AMEX) — informs payment processing fee negotiations."
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Whether the payment was made via autopay — autopay payments have lower NSF rates and processing costs."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether the payment is part of a recurring schedule — distinguishes scheduled from ad-hoc payments for cash flow predictability."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Non-sufficient funds flag — NSF payments reverse cash receipts and trigger additional fees and collections activity."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month — primary time dimension for monthly cash collections trend analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month — aligns cash receipts to accounting periods for financial close reconciliation."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor used — enables processor performance benchmarking and fee analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross cash collected — primary cash receipts KPI for treasury and financial close reporting."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amounts successfully applied to invoices — measures effective cash application and AR reduction."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet applied to invoices — unapplied cash is a financial risk and operational backlog indicator."
    - name: "total_nsf_fee_amount"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees assessed — revenue from returned payments; also signals customer financial stress and collections risk."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions — baseline volume metric for payment operations capacity planning."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of payments returned for non-sufficient funds — operational and risk KPI; high NSF counts indicate customer financial hardship."
    - name: "nsf_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were returned NSF — portfolio-level payment quality KPI; elevated rates trigger collections and hardship program reviews."
    - name: "autopay_payment_count"
      expr: COUNT(CASE WHEN is_auto_pay = TRUE THEN 1 END)
      comment: "Number of payments made via autopay — tracks autopay adoption and its impact on payment reliability."
    - name: "autopay_payment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_auto_pay = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments processed via autopay — higher autopay rates reduce delinquency and lower payment processing costs."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction — benchmarks typical payment size and detects anomalous large or small payments."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of collected cash that remains unapplied — cash application efficiency KPI; high rates indicate AR reconciliation backlog."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment KPIs tracking credit/debit volumes, adjustment reasons, regulatory compliance, and revenue impact of billing corrections for water utility operations."
  source: "`vibe_water_utilities_v1`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of billing adjustment (e.g. CREDIT, DEBIT, LEAK_ALLOWANCE, REGULATORY) — primary classification for adjustment root cause analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current processing status of the adjustment (e.g. PENDING, APPROVED, APPLIED, REVERSED) — tracks adjustment workflow throughput."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment — enables systematic analysis of billing error patterns and process improvement opportunities."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the adjustment (e.g. WATER, WASTEWATER, STORMWATER) — allocates adjustment impact by revenue stream."
    - name: "leak_allowance_flag"
      expr: leak_allowance_flag
      comment: "Indicates the adjustment is a leak allowance credit — tracks financial exposure from customer leak forgiveness programs."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates the adjustment was required for regulatory compliance — separates mandated adjustments from discretionary credits."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates this adjustment reverses a prior adjustment — high reversal rates signal billing process quality issues."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the adjustment required management approval — tracks high-value adjustment governance and approval workflow compliance."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective date of the adjustment truncated to month — aligns adjustment impact to the correct accounting period."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start truncated to month — links adjustments to the original service period for revenue restatement analysis."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Net total adjustment amount — primary revenue impact KPI for billing corrections; negative values indicate net credits issued to customers."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of adjustments processed — baseline volume metric for billing quality and adjustment workload management."
    - name: "total_leak_allowance_amount"
      expr: SUM(CASE WHEN leak_allowance_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue forgiven through leak allowance credits — financial exposure from customer leak forgiveness programs; informs leak detection investment decisions."
    - name: "total_regulatory_adjustment_amount"
      expr: SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total adjustment amount driven by regulatory compliance requirements — tracks mandated revenue adjustments for rate case and regulatory reporting."
    - name: "total_reversal_amount"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of reversed adjustments — measures billing correction rework; high values indicate upstream billing quality problems."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments that are reversals — billing process quality KPI; elevated rates trigger root cause analysis and process improvement."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per transaction — benchmarks typical adjustment size and detects anomalous high-value corrections."
    - name: "total_consumption_volume_adjusted"
      expr: SUM(CAST(consumption_volume_adjusted AS DOUBLE))
      comment: "Total consumption volume adjusted across all billing corrections — measures the volumetric impact of billing errors on revenue and regulatory reporting."
    - name: "approval_required_count"
      expr: COUNT(CASE WHEN approval_required_flag = TRUE THEN 1 END)
      comment: "Number of adjustments requiring management approval — tracks high-value adjustment governance workload and approval queue depth."
    - name: "leak_allowance_count"
      expr: COUNT(CASE WHEN leak_allowance_flag = TRUE THEN 1 END)
      comment: "Number of leak allowance adjustments issued — operational KPI for leak detection program effectiveness and customer service policy."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan portfolio KPIs tracking enrollment, compliance, default rates, and financial exposure for water utility customer hardship and deferred payment programs."
  source: "`vibe_water_utilities_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g. ACTIVE, COMPLETED, BROKEN, CANCELLED) — primary dimension for plan portfolio health analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g. STANDARD, LIHEAP, HARDSHIP, BUDGET) — segments plans by program type for affordability reporting."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g. MONTHLY, WEEKLY, BIWEEKLY) — affects cash flow timing and plan compliance rates."
    - name: "liheap_eligible"
      expr: liheap_eligible
      comment: "Whether the customer is LIHEAP-eligible — tracks low-income assistance program enrollment and associated deferred revenue exposure."
    - name: "plan_start_date_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month the payment plan was initiated — tracks enrollment trends and seasonal hardship patterns."
    - name: "broken_date_month"
      expr: DATE_TRUNC('MONTH', broken_date)
      comment: "Month the payment plan was broken (defaulted) — identifies seasonal default patterns and collections escalation timing."
  measures:
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Total number of payment plans — baseline portfolio size metric for hardship program capacity and collections workload planning."
    - name: "total_enrolled_balance_amount"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total delinquent balance enrolled in payment plans — measures the financial exposure being managed through structured repayment agreements."
    - name: "total_current_balance_amount"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total remaining balance outstanding across active payment plans — tracks repayment progress and residual collections risk."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment — measures upfront cash recovery from delinquent accounts entering payment plans."
    - name: "total_installment_amount"
      expr: SUM(CAST(installment_amount AS DOUBLE))
      comment: "Sum of scheduled installment amounts across all active plans — forward-looking cash flow forecast from payment plan commitments."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active payment plans — operational KPI for collections team workload and hardship program utilization."
    - name: "broken_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'BROKEN' THEN 1 END)
      comment: "Number of payment plans that have been broken (defaulted) — key collections risk KPI; broken plans typically escalate to disconnection."
    - name: "plan_default_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN plan_status = 'BROKEN' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payment plans that have defaulted — program effectiveness KPI; high default rates indicate plan terms are not aligned with customer capacity."
    - name: "liheap_plan_count"
      expr: COUNT(CASE WHEN liheap_eligible = TRUE THEN 1 END)
      comment: "Number of payment plans for LIHEAP-eligible customers — tracks low-income assistance program reach and regulatory affordability compliance."
    - name: "avg_enrolled_balance_amount"
      expr: AVG(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Average delinquent balance enrolled per payment plan — benchmarks typical plan size and informs plan term design for affordability programs."
    - name: "repayment_progress_pct"
      expr: ROUND(100.0 * (SUM(CAST(enrolled_balance_amount AS DOUBLE)) - SUM(CAST(current_balance_amount AS DOUBLE))) / NULLIF(SUM(CAST(enrolled_balance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of enrolled balance repaid across all plans — portfolio-level repayment effectiveness KPI for collections program performance reviews."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level revenue KPIs tracking charge composition, tax exposure, proration, and dispute rates by service type and charge category for water utility billing."
  source: "`vibe_water_utilities_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the charge line (e.g. WATER, WASTEWATER, STORMWATER) — primary revenue stream segmentation dimension."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g. ACTIVE, REVERSED, DISPUTED) — filters for valid revenue lines in financial reporting."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the invoice line is under dispute — identifies revenue at risk from customer billing challenges."
    - name: "is_prorated"
      expr: is_prorated
      comment: "Whether the charge was prorated for a partial service period — prorated lines require special handling in revenue recognition."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the charge is subject to tax — drives tax liability calculation and exemption compliance reporting."
    - name: "billing_determinant"
      expr: billing_determinant
      comment: "The billing determinant driving the charge (e.g. CONSUMPTION, DEMAND, FIXED) — links revenue to the underlying service measurement."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start truncated to month — aligns line-level revenue to service periods for accrual and period-over-period analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line — ensures correct aggregation in multi-currency utility environments."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total pre-tax charge amount across invoice lines — granular revenue KPI for charge-type and service-type revenue decomposition."
    - name: "total_line_amount_with_tax"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total invoice line amount including tax — all-in revenue figure for financial reporting and customer billing reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax assessed at the line level — required for tax remittance reporting and exemption compliance audits."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines — billing complexity and volume metric; high line counts per invoice may indicate rate schedule complexity."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of invoice lines under dispute — revenue-at-risk indicator at the charge level; drives dispute resolution prioritization."
    - name: "disputed_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_disputed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoice lines in dispute — billing accuracy KPI at the charge level; elevated rates trigger rate schedule and billing logic reviews."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate charged per invoice line — tracks effective rate levels across customer classes and service types for rate adequacy analysis."
    - name: "avg_proration_factor"
      expr: AVG(CAST(proration_factor AS DOUBLE))
      comment: "Average proration factor applied to prorated lines — values significantly below 1.0 indicate high partial-period billing activity from account changes."
    - name: "taxable_line_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_taxable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoice lines subject to tax — tracks taxable revenue exposure and exemption program utilization."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`billing_rate_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate component structure KPIs tracking the composition, pricing levels, and regulatory alignment of water utility rate schedules for rate case preparation and revenue adequacy analysis."
  source: "`vibe_water_utilities_v1`.`billing`.`rate_component`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of rate component (e.g. BASE_CHARGE, VOLUMETRIC, TIER, SURCHARGE) — primary classification for rate structure analysis."
    - name: "service_type"
      expr: service_type
      comment: "Service type the rate component applies to (e.g. WATER, WASTEWATER) — segments rate structure by revenue stream."
    - name: "is_volumetric"
      expr: is_volumetric
      comment: "Whether the component charges based on consumption volume — distinguishes fixed from variable revenue components for revenue stability analysis."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Whether the rate component is subject to tax — drives tax liability modeling in rate case filings."
    - name: "conservation_tier_flag"
      expr: conservation_tier_flag
      comment: "Whether the component is part of a conservation tiered rate structure — tracks conservation pricing adoption and its revenue impact."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Whether the rate component has seasonal pricing variation — identifies seasonal rate structures for demand management analysis."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the rate component became effective — tracks rate change history and regulatory approval timelines."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Regulatory body that approved the rate component — ensures rate components are traceable to their governing authority for compliance reporting."
  measures:
    - name: "rate_component_count"
      expr: COUNT(1)
      comment: "Total number of rate components — measures rate schedule complexity; high counts may indicate need for rate structure simplification."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across components — benchmarks pricing levels for rate adequacy analysis and inter-utility comparisons."
    - name: "avg_flat_amount"
      expr: AVG(CAST(flat_amount AS DOUBLE))
      comment: "Average flat charge amount across fixed-fee components — tracks fixed revenue base for revenue stability and cost recovery analysis."
    - name: "total_flat_amount"
      expr: SUM(CAST(flat_amount AS DOUBLE))
      comment: "Sum of all flat charge amounts — total fixed revenue potential from base charges across all rate components."
    - name: "conservation_tier_component_count"
      expr: COUNT(CASE WHEN conservation_tier_flag = TRUE THEN 1 END)
      comment: "Number of conservation-tiered rate components — tracks the breadth of conservation pricing in the rate structure for regulatory and sustainability reporting."
    - name: "volumetric_component_count"
      expr: COUNT(CASE WHEN is_volumetric = TRUE THEN 1 END)
      comment: "Number of volumetric rate components — measures the proportion of consumption-based pricing in the rate structure."
    - name: "volumetric_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_volumetric = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate components that are volumetric — higher percentages indicate greater revenue sensitivity to consumption changes; key for drought revenue risk analysis."
    - name: "avg_tier_high_threshold"
      expr: AVG(CAST(tier_high_threshold AS DOUBLE))
      comment: "Average upper consumption threshold for tiered rate components — benchmarks tier boundary levels for conservation rate design reviews."
    - name: "avg_percentage_rate"
      expr: AVG(CAST(percentage_rate AS DOUBLE))
      comment: "Average percentage-based rate across applicable components — tracks surcharge and percentage-fee levels for revenue adequacy and regulatory compliance."
$$;