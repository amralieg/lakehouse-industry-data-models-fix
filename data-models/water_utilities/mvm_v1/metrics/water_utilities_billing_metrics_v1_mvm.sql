-- Metric views for domain: billing | Business: Water Utilities | Version: 1 | Generated on: 2026-05-06 01:55:38

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core billing invoice metrics tracking revenue, charges by service type, collection efficiency, and billing cycle performance for water utility operations. Used by Finance and Revenue Management to monitor billing health and revenue recognition."
  source: "`water_utilities_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., OPEN, PAID, OVERDUE, CANCELLED) — used to segment revenue by collection state."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., REGULAR, FINAL, ESTIMATED) — used to distinguish standard billing from final or estimated reads."
    - name: "delivery_method"
      expr: delivery_method
      comment: "How the invoice was delivered to the customer (e.g., PAPER, EMAIL, PORTAL) — used to track paperless adoption and delivery cost."
    - name: "generation_method"
      expr: generation_method
      comment: "How the invoice was generated (e.g., AUTOMATED, MANUAL) — used to monitor billing automation rates."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the invoice is based on an estimated read rather than an actual meter read."
    - name: "is_final"
      expr: is_final
      comment: "Flag indicating whether this is a final bill issued upon account closure."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the invoice has an active dispute — used to track disputed revenue exposure."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month — used for monthly revenue trend analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start truncated to month — used to align revenue to service delivery period."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Invoice due date truncated to month — used for cash flow forecasting and aging analysis."
    - name: "water_consumption_uom"
      expr: water_consumption_uom
      comment: "Unit of measure for water consumption (e.g., CCF, GAL) — used to normalize consumption metrics across service areas."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated — used for multi-currency revenue reporting."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total amount billed to customers across all invoices. Primary revenue recognition KPI used by Finance to track billed revenue and forecast collections."
    - name: "total_water_charge_amount"
      expr: SUM(CAST(water_charge_amount AS DOUBLE))
      comment: "Total water service charges billed. Used by Revenue Management to track water revenue contribution and rate case performance."
    - name: "total_wastewater_charge_amount"
      expr: SUM(CAST(wastewater_charge_amount AS DOUBLE))
      comment: "Total wastewater service charges billed. Used to monitor wastewater revenue stream and WWTP cost recovery."
    - name: "total_stormwater_charge_amount"
      expr: SUM(CAST(stormwater_charge_amount AS DOUBLE))
      comment: "Total stormwater charges billed. Used to track stormwater fee revenue and infrastructure cost recovery compliance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices. Used by Finance for tax remittance reporting and regulatory compliance."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed on invoices. Elevated values signal collection problems and customer payment behavior deterioration."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to invoices (credits and debits). Used to monitor billing accuracy and the financial impact of corrections."
    - name: "total_water_consumption_volume"
      expr: SUM(CAST(water_consumption_volume AS DOUBLE))
      comment: "Total water volume billed across all invoices. Used to reconcile billed consumption against production and distribution loss metrics."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice amount per billing record. Used to track average revenue per bill and detect anomalies in billing amounts."
    - name: "avg_water_consumption_volume"
      expr: AVG(CAST(water_consumption_volume AS DOUBLE))
      comment: "Average water consumption volume per invoice. Used to monitor per-customer consumption trends and conservation program effectiveness."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices generated. Used as the baseline denominator for per-invoice KPIs and billing cycle throughput measurement."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices with active disputes. Used to monitor billing quality and customer satisfaction risk."
    - name: "estimated_invoice_count"
      expr: COUNT(CASE WHEN is_estimated = TRUE THEN 1 END)
      comment: "Number of invoices based on estimated reads. High values indicate meter reading operational issues and increase dispute risk."
    - name: "total_previous_balance_amount"
      expr: SUM(CAST(previous_balance_amount AS DOUBLE))
      comment: "Total carried-forward balances on invoices. Used to track outstanding receivables rolled into new billing cycles."
    - name: "total_wastewater_volume"
      expr: SUM(CAST(wastewater_volume AS DOUBLE))
      comment: "Total wastewater volume billed. Used to reconcile billed wastewater flows against WWTP treatment capacity and permit limits."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection metrics tracking cash receipts, payment method mix, NSF incidents, and unapplied cash for water utility accounts receivable management. Used by Finance and Collections to monitor cash flow and payment performance."
  source: "`water_utilities_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., POSTED, REVERSED, PENDING) — used to segment collected vs. in-flight cash."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (e.g., CHECK, ACH, CREDIT_CARD, CASH) — used to analyze payment channel mix and processing costs."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment transaction (e.g., PAYMENT, REVERSAL, REFUND) — used to distinguish genuine receipts from reversals."
    - name: "channel"
      expr: channel
      comment: "Channel through which the payment was received (e.g., ONLINE, IVR, WALK_IN, LOCKBOX) — used to optimize payment channel strategy and cost."
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Flag indicating whether the payment was made via autopay enrollment — used to track autopay adoption and its impact on collection rates."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the payment is part of a recurring payment arrangement."
    - name: "nsf_indicator"
      expr: nsf_indicator
      comment: "Flag indicating a non-sufficient funds (NSF) return — used to monitor payment failure rates and associated fee recovery."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month — used for monthly cash receipt trend analysis and cash flow reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month — used to align cash receipts to accounting periods for revenue recognition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment — used for multi-currency cash management reporting."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor used (e.g., specific bank or payment gateway) — used to monitor processor performance and negotiate processing fees."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received from customers. Primary cash collection KPI used by Finance to track daily/monthly receipts against billed revenue."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to invoices. Used to measure cash application efficiency and reduce unapplied cash balances."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet applied to invoices. Elevated unapplied cash signals cash application backlog and distorts AR aging."
    - name: "total_nsf_fee_amount"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF fees assessed on returned payments. Used to quantify payment failure costs and identify high-risk customer segments."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Used as baseline for payment volume trending and channel throughput analysis."
    - name: "nsf_payment_count"
      expr: COUNT(CASE WHEN nsf_indicator = TRUE THEN 1 END)
      comment: "Number of payments returned for non-sufficient funds. Used to monitor payment failure rates and collection risk."
    - name: "autopay_payment_count"
      expr: COUNT(CASE WHEN is_auto_pay = TRUE THEN 1 END)
      comment: "Number of payments made via autopay. Used to track autopay adoption, which correlates with lower delinquency and collection costs."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to detect anomalies in payment behavior and benchmark against average invoice amounts."
    - name: "distinct_paying_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts making payments in the period. Used to measure payment participation rate and identify non-paying accounts."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio metrics tracking account health, receivables aging, delinquency, and collection status across the customer base. Used by Collections, Finance, and Customer Service to manage account risk and revenue recovery."
  source: "`water_utilities_ecm`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the billing account (e.g., ACTIVE, CLOSED, SUSPENDED) — used to segment the active customer base."
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (e.g., RESIDENTIAL, COMMERCIAL, INDUSTRIAL) — used for customer class revenue and risk segmentation."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections status of the account (e.g., CURRENT, DELINQUENT, WRITE_OFF) — primary dimension for AR risk management."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often the account is billed (e.g., MONTHLY, BIMONTHLY, QUARTERLY) — used to align revenue forecasting to billing cycles."
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Flag indicating whether the account is enrolled in autopay — used to correlate autopay adoption with delinquency reduction."
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Flag indicating whether the account receives paperless bills — used to track digital adoption and reduce print/mail costs."
    - name: "payment_plan_active"
      expr: payment_plan_active
      comment: "Flag indicating whether the account has an active payment plan — used to monitor customers in financial hardship arrangements."
    - name: "budget_billing_enrolled"
      expr: budget_billing_enrolled
      comment: "Flag indicating enrollment in budget billing (levelized payment) program — used to track program participation and cash flow predictability."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account — used for risk-based collections prioritization and deposit policy decisions."
    - name: "final_bill_issued"
      expr: final_bill_issued
      comment: "Flag indicating a final bill has been issued — used to track account closure pipeline and associated revenue finalization."
    - name: "opened_date_year"
      expr: DATE_TRUNC('YEAR', opened_date)
      comment: "Year the account was opened — used for account vintage analysis and cohort-based delinquency tracking."
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Flag indicating whether the account is tax-exempt — used for tax revenue reporting and compliance."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding balance across all billing accounts. Primary accounts receivable KPI used by Finance to monitor total AR exposure."
    - name: "total_past_due_amount"
      expr: SUM(CAST(past_due_amount AS DOUBLE))
      comment: "Total past-due amounts across all accounts. Critical collections KPI — elevated values trigger collection escalation and resource reallocation."
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days AS DOUBLE))
      comment: "Total receivables aged 1-30 days past due. Used in AR aging analysis to assess near-term collection risk."
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days AS DOUBLE))
      comment: "Total receivables aged 31-60 days past due. Used to identify accounts requiring proactive collection outreach."
    - name: "total_aging_90_days"
      expr: SUM(CAST(aging_90_days AS DOUBLE))
      comment: "Total receivables aged 61-90 days past due. Accounts at this stage typically require formal collection notices or payment plans."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_over_90_days AS DOUBLE))
      comment: "Total receivables aged over 90 days past due. High-risk AR bucket — used to assess write-off exposure and disconnection candidates."
    - name: "total_current_charges"
      expr: SUM(CAST(current_charges AS DOUBLE))
      comment: "Total current period charges across all accounts. Used to track billed revenue in the current billing cycle."
    - name: "total_deposit_on_file"
      expr: SUM(CAST(deposit_on_file AS DOUBLE))
      comment: "Total customer deposits held. Used by Finance to manage deposit liability and assess deposit adequacy against delinquent balances."
    - name: "total_payment_plan_balance"
      expr: SUM(CAST(payment_plan_balance AS DOUBLE))
      comment: "Total outstanding balance under active payment plans. Used to monitor payment plan portfolio size and recovery trajectory."
    - name: "total_late_fee_assessed"
      expr: SUM(CAST(late_fee_assessed AS DOUBLE))
      comment: "Total late fees assessed across accounts. Used to quantify delinquency-driven fee revenue and monitor collection policy effectiveness."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Used as the denominator for per-account KPIs and to track portfolio size changes."
    - name: "delinquent_account_count"
      expr: COUNT(CASE WHEN collection_status = 'DELINQUENT' THEN 1 END)
      comment: "Number of accounts in delinquent collection status. Used to monitor delinquency rate and trigger collection resource allocation."
    - name: "payment_plan_account_count"
      expr: COUNT(CASE WHEN payment_plan_active = TRUE THEN 1 END)
      comment: "Number of accounts with active payment plans. Used to track financial hardship program utilization and associated revenue recovery risk."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average outstanding balance per billing account. Used to benchmark account-level AR exposure and detect portfolio-wide balance shifts."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Used to assess credit risk exposure relative to outstanding balances."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment metrics tracking the volume, value, and nature of billing corrections including leak allowances, regulatory adjustments, and reversals. Used by Revenue Management and Regulatory Affairs to monitor billing accuracy and compliance."
  source: "`water_utilities_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of billing adjustment (e.g., LEAK_ALLOWANCE, METER_ERROR, RATE_CORRECTION) — used to categorize adjustment root causes."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., PENDING, APPROVED, APPLIED, REVERSED) — used to track adjustment pipeline and approval backlog."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the adjustment — used to identify systemic billing issues driving high adjustment volumes."
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge being adjusted (e.g., WATER, WASTEWATER, STORMWATER) — used to attribute adjustment impact by service line."
    - name: "service_type"
      expr: service_type
      comment: "Service type associated with the adjustment — used to segment adjustment impact by water vs. wastewater services."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Flag indicating whether the adjustment required supervisory approval — used to monitor high-value adjustment controls."
    - name: "leak_allowance_flag"
      expr: leak_allowance_flag
      comment: "Flag indicating the adjustment is a leak allowance credit — used to track leak-related revenue concessions and their financial impact."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Flag indicating the adjustment is a reversal of a prior adjustment — used to monitor adjustment correction rates."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Flag indicating the adjustment is driven by a regulatory compliance requirement — used for regulatory reporting and audit trails."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Flag indicating whether the adjustment is tax-exempt — used for tax impact analysis on billing corrections."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Effective date of the adjustment truncated to month — used for monthly adjustment trend analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start date truncated to month — used to align adjustments to the billing period they correct."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total net adjustment amount applied to customer bills. Primary billing accuracy KPI — large negative values indicate systemic overbilling; large positive values indicate underbilling corrections."
    - name: "total_consumption_volume_adjusted"
      expr: SUM(CAST(consumption_volume_adjusted AS DOUBLE))
      comment: "Total consumption volume adjusted across all billing corrections. Used to quantify the volumetric impact of billing errors and leak allowances on revenue."
    - name: "total_approval_threshold_amount"
      expr: SUM(CAST(approval_threshold_amount AS DOUBLE))
      comment: "Total value of adjustments subject to approval thresholds. Used to monitor the financial exposure of adjustments requiring supervisory review."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of billing adjustments issued. Used to track billing correction volume and identify periods of elevated billing error rates."
    - name: "leak_allowance_adjustment_count"
      expr: COUNT(CASE WHEN leak_allowance_flag = TRUE THEN 1 END)
      comment: "Number of adjustments issued as leak allowances. Used to monitor leak-related billing concessions and their correlation with distribution system integrity."
    - name: "reversal_adjustment_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of adjustments that are reversals of prior adjustments. High reversal counts indicate adjustment quality issues and rework costs."
    - name: "regulatory_adjustment_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END)
      comment: "Number of adjustments driven by regulatory compliance requirements. Used for regulatory reporting and to track compliance-driven revenue impacts."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per billing correction. Used to benchmark adjustment magnitude and detect outlier adjustment events."
    - name: "distinct_adjusted_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts receiving billing adjustments. Used to assess the breadth of billing accuracy issues across the customer base."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer billing dispute metrics tracking dispute volume, resolution performance, financial exposure, and SLA compliance. Used by Customer Service, Revenue Management, and Regulatory Affairs to manage dispute resolution quality and regulatory risk."
  source: "`water_utilities_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., OPEN, RESOLVED, ESCALATED, WITHDRAWN) — used to monitor dispute pipeline and backlog."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of billing dispute (e.g., HIGH_BILL, METER_ACCURACY, LEAK_CREDIT, SERVICE_QUALITY) — used to identify root causes driving dispute volumes."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g., CREDIT_ISSUED, NO_ADJUSTMENT, METER_TEST, PAYMENT_PLAN) — used to track resolution outcomes and credit exposure."
    - name: "channel"
      expr: channel
      comment: "Channel through which the dispute was submitted (e.g., PHONE, ONLINE, IN_PERSON, MAIL) — used to optimize dispute intake channel strategy."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the dispute (e.g., HIGH, MEDIUM, LOW) — used to ensure high-priority disputes receive timely resolution."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Flag indicating whether the dispute resolution exceeded the SLA target — used to monitor regulatory compliance and customer service quality."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Flag indicating the dispute was escalated to a regulatory body (e.g., PUC) — used to track regulatory risk exposure."
    - name: "meter_test_requested_flag"
      expr: meter_test_requested_flag
      comment: "Flag indicating a meter accuracy test was requested as part of the dispute — used to correlate meter test requests with dispute outcomes."
    - name: "leak_adjustment_approved_flag"
      expr: leak_adjustment_approved_flag
      comment: "Flag indicating a leak adjustment was approved as part of dispute resolution — used to track leak-related credit approvals."
    - name: "customer_satisfaction_rating"
      expr: customer_satisfaction_rating
      comment: "Customer satisfaction rating provided after dispute resolution — used to measure service quality and identify improvement opportunities."
    - name: "dispute_date_month"
      expr: DATE_TRUNC('MONTH', dispute_date)
      comment: "Month the dispute was filed — used for monthly dispute volume trending and seasonal pattern analysis."
    - name: "resolution_date_month"
      expr: DATE_TRUNC('MONTH', resolution_date)
      comment: "Month the dispute was resolved — used to track resolution throughput and backlog clearance rates."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total dollar amount under dispute. Primary revenue-at-risk KPI — used by Finance to quantify disputed revenue exposure and reserve requirements."
    - name: "total_credit_issued_amount"
      expr: SUM(CAST(credit_issued_amount AS DOUBLE))
      comment: "Total credits issued to resolve disputes. Used to measure the financial cost of dispute resolution and billing error impact on revenue."
    - name: "total_leak_adjustment_gallons"
      expr: SUM(CAST(leak_adjustment_gallons AS DOUBLE))
      comment: "Total volume of water adjusted due to leak-related disputes. Used to quantify the volumetric and revenue impact of customer leak events."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes filed. Used to track dispute rate trends and identify billing quality deterioration."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes that breached the SLA resolution target. Used to monitor regulatory compliance and customer service performance."
    - name: "regulatory_escalation_count"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END)
      comment: "Number of disputes escalated to a regulatory body. Used to track regulatory risk exposure and PUC complaint rates."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open disputes. Used to monitor dispute backlog and resource allocation for resolution teams."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute case. Used to benchmark dispute magnitude and prioritize high-value dispute resolution."
    - name: "avg_credit_issued_amount"
      expr: AVG(CAST(credit_issued_amount AS DOUBLE))
      comment: "Average credit issued per resolved dispute. Used to assess the cost of dispute resolution and benchmark against industry norms."
    - name: "distinct_disputing_customers"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with disputes. Used to measure the breadth of billing quality issues across the customer portfolio."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan portfolio metrics tracking financial hardship program enrollment, plan performance, and recovery rates. Used by Collections and Customer Assistance programs to manage delinquent account recovery and affordability compliance."
  source: "`water_utilities_ecm`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g., ACTIVE, COMPLETED, BROKEN, CANCELLED) — used to monitor plan portfolio health and recovery rates."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g., STANDARD, LIHEAP, HARDSHIP, BUDGET) — used to segment plan performance by program type."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g., MONTHLY, BIWEEKLY, WEEKLY) — used to analyze payment frequency impact on plan completion rates."
    - name: "liheap_eligible"
      expr: liheap_eligible
      comment: "Flag indicating LIHEAP (Low Income Home Energy Assistance Program) eligibility — used to track low-income customer assistance program utilization."
    - name: "requires_current_charges_paid"
      expr: requires_current_charges_paid
      comment: "Flag indicating whether the plan requires current charges to be paid alongside installments — used to assess plan compliance requirements."
    - name: "plan_start_date_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month the payment plan was initiated — used for cohort analysis of plan performance and seasonal delinquency patterns."
    - name: "plan_end_date_month"
      expr: DATE_TRUNC('MONTH', plan_end_date)
      comment: "Month the payment plan is scheduled to end — used for cash flow forecasting of plan recovery receipts."
  measures:
    - name: "total_enrolled_balance_amount"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total delinquent balance enrolled in payment plans. Primary collections recovery KPI — used to track the total AR under structured repayment."
    - name: "total_current_balance_amount"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total remaining balance outstanding on active payment plans. Used to monitor recovery progress and forecast remaining collections."
    - name: "total_installment_amount"
      expr: SUM(CAST(installment_amount AS DOUBLE))
      comment: "Total scheduled installment amounts across all active plans. Used for cash flow forecasting of expected payment plan receipts."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected at plan enrollment. Used to measure upfront recovery from delinquent accounts entering payment arrangements."
    - name: "payment_plan_count"
      expr: COUNT(1)
      comment: "Total number of payment plans. Used to track payment plan program scale and collections workload."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active payment plans. Used to monitor the active collections recovery portfolio size."
    - name: "broken_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'BROKEN' THEN 1 END)
      comment: "Number of payment plans that have been broken (missed installment). High broken plan rates indicate need for plan restructuring or disconnection action."
    - name: "completed_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'COMPLETED' THEN 1 END)
      comment: "Number of payment plans successfully completed. Used to measure payment plan success rate and program effectiveness."
    - name: "liheap_plan_count"
      expr: COUNT(CASE WHEN liheap_eligible = TRUE THEN 1 END)
      comment: "Number of payment plans for LIHEAP-eligible customers. Used to track low-income assistance program utilization and regulatory affordability compliance."
    - name: "avg_enrolled_balance_amount"
      expr: AVG(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Average delinquent balance enrolled per payment plan. Used to benchmark plan size and assess the severity of delinquency being managed."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice line-level revenue metrics providing granular analysis of charges by service type, rate component, revenue class, and charge type. Used by Revenue Management and Rate Case teams to analyze revenue composition and rate structure performance."
  source: "`water_utilities_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Service type for the invoice line (e.g., WATER, WASTEWATER, STORMWATER) — primary dimension for revenue decomposition by service."
    - name: "charge_type_code"
      expr: charge_type_code
      comment: "Standardized charge type code (e.g., BASE, VOLUMETRIC, SURCHARGE, TAX) — used to analyze revenue by charge structure component."
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue classification for the line item — used for financial reporting and revenue recognition by class."
    - name: "billing_determinant"
      expr: billing_determinant
      comment: "The billing determinant driving the charge (e.g., CONSUMPTION, DEMAND, AREA) — used to analyze revenue by billing basis."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (e.g., ACTIVE, VOIDED, DISPUTED) — used to filter valid revenue lines."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether this line item is under dispute — used to quantify disputed revenue at the line level."
    - name: "is_taxable"
      expr: is_taxable
      comment: "Flag indicating whether the line item is subject to tax — used for tax revenue analysis and compliance reporting."
    - name: "is_prorated"
      expr: is_prorated
      comment: "Flag indicating whether the charge was prorated — used to identify partial-period billing and its revenue impact."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Billing period start truncated to month — used to align line-level revenue to service delivery periods."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line — used for multi-currency revenue reporting."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total pre-tax line amount across all invoice lines. Used to analyze revenue composition by service type, charge type, and rate component."
    - name: "total_line_amount_with_tax"
      expr: SUM(CAST(total_line_amount AS DOUBLE))
      comment: "Total invoice line amount including taxes. Used for gross revenue reporting inclusive of tax pass-through charges."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoice lines. Used for tax liability reporting and regulatory tax remittance compliance."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice line items. Used to measure billing complexity and volume of charge components generated per billing cycle."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate charged across invoice lines. Used to monitor effective rate levels and detect rate schedule application anomalies."
    - name: "avg_proration_factor"
      expr: AVG(CAST(proration_factor AS DOUBLE))
      comment: "Average proration factor applied to invoice lines. Used to assess the prevalence and magnitude of partial-period billing."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of invoice lines under dispute. Used to measure billing accuracy at the line level and identify problematic charge types."
    - name: "distinct_invoices_with_lines"
      expr: COUNT(DISTINCT invoice_id)
      comment: "Number of distinct invoices represented in the line items. Used to validate billing completeness and detect invoices with missing line items."
$$;

CREATE OR REPLACE VIEW `water_utilities_ecm`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate schedule portfolio metrics tracking the structure, coverage, and financial parameters of billing rate schedules. Used by Rate Case teams and Regulatory Affairs to manage rate structure governance and regulatory compliance."
  source: "`water_utilities_ecm`.`billing`.`billing_rate_schedule`"
  dimensions:
    - name: "billing_rate_schedule_status"
      expr: billing_rate_schedule_status
      comment: "Current status of the rate schedule (e.g., ACTIVE, SUPERSEDED, PENDING_APPROVAL) — used to manage the active rate schedule portfolio."
    - name: "rate_structure_type"
      expr: rate_structure_type
      comment: "Type of rate structure (e.g., FLAT, TIERED, INCLINING_BLOCK, DECLINING_BLOCK) — used to analyze rate design mix and conservation incentive coverage."
    - name: "customer_class"
      expr: customer_class
      comment: "Customer class the rate schedule applies to (e.g., RESIDENTIAL, COMMERCIAL, INDUSTRIAL) — used to segment rate structures by customer type."
    - name: "service_type"
      expr: service_type
      comment: "Service type covered by the rate schedule (e.g., WATER, WASTEWATER) — used to analyze rate coverage by service."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency associated with the rate schedule — used to align rate analysis to billing cycle structure."
    - name: "conservation_rate_indicator"
      expr: conservation_rate_indicator
      comment: "Flag indicating whether the rate schedule includes conservation pricing tiers — used to track conservation rate adoption across the portfolio."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Flag indicating whether the rate schedule has seasonal rate variations — used to analyze seasonal pricing coverage."
    - name: "drought_surcharge_applicable"
      expr: drought_surcharge_applicable
      comment: "Flag indicating whether a drought surcharge applies under this rate schedule — used to assess drought response revenue mechanisms."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year the rate schedule became effective — used to track rate schedule vintage and rate case implementation timelines."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate schedule — used for multi-currency rate management."
  measures:
    - name: "avg_base_charge_amount"
      expr: AVG(CAST(base_charge_amount AS DOUBLE))
      comment: "Average base (fixed) charge across rate schedules. Used by Rate Case teams to benchmark fixed charge levels and assess revenue adequacy."
    - name: "avg_minimum_charge_amount"
      expr: AVG(CAST(minimum_charge_amount AS DOUBLE))
      comment: "Average minimum charge across rate schedules. Used to assess minimum revenue guarantee levels and their adequacy for fixed cost recovery."
    - name: "avg_maximum_charge_amount"
      expr: AVG(CAST(maximum_charge_amount AS DOUBLE))
      comment: "Average maximum charge cap across rate schedules. Used to assess rate cap levels and their impact on revenue from high-consumption customers."
    - name: "rate_schedule_count"
      expr: COUNT(1)
      comment: "Total number of rate schedules in the portfolio. Used to monitor rate schedule complexity and governance overhead."
    - name: "active_rate_schedule_count"
      expr: COUNT(CASE WHEN billing_rate_schedule_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active rate schedules. Used to track the active rate structure portfolio and identify consolidation opportunities."
    - name: "conservation_rate_schedule_count"
      expr: COUNT(CASE WHEN conservation_rate_indicator = TRUE THEN 1 END)
      comment: "Number of rate schedules with conservation pricing. Used to measure conservation rate adoption and regulatory compliance with conservation mandates."
    - name: "drought_surcharge_rate_schedule_count"
      expr: COUNT(CASE WHEN drought_surcharge_applicable = TRUE THEN 1 END)
      comment: "Number of rate schedules with drought surcharge provisions. Used to assess drought response revenue readiness across the rate portfolio."
$$;