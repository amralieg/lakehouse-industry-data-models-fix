-- Metric views for domain: billing | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic billing performance metrics derived from the invoice fact table. Covers revenue billed, collection efficiency, dispute exposure, and payment velocity — core KPIs for CFO, VP Finance, and Revenue Operations steering meetings."
  source: "`waste_management_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. DRAFT, ISSUED, PAID, VOID, DISPUTED). Enables aging and status-mix analysis."
    - name: "billing_model_type"
      expr: billing_model_type
      comment: "Billing model applied to the invoice (e.g. FLAT_RATE, WEIGHT_BASED, SUBSCRIPTION). Drives pricing strategy analysis."
    - name: "customer_type"
      expr: customer_type
      comment: "Classification of the customer (e.g. RESIDENTIAL, COMMERCIAL, INDUSTRIAL). Enables segment-level revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the invoice. Required for multi-currency revenue reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method recorded on the invoice (e.g. ACH, CREDIT_CARD, CHECK). Informs payment channel strategy."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms on the invoice (e.g. NET_30, NET_60). Used to benchmark DSO against terms."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean flag indicating whether the invoice is under dispute. Enables disputed vs. clean invoice segmentation."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance. Primary time dimension for monthly revenue trend analysis."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month in which the billed service period begins. Supports revenue recognition period alignment."
    - name: "revenue_recognition_period"
      expr: revenue_recognition_period
      comment: "Accounting period in which revenue is recognized per ASC 606 / IFRS 15. Critical for finance close reporting."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Invoice delivery channel (e.g. EMAIL, PAPER, PORTAL). Supports paperless adoption tracking."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center associated with the invoice. Enables P&L attribution by business unit."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross amount billed across all invoices. Primary top-line revenue KPI for executive dashboards and QBRs."
    - name: "total_tax_billed"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component billed. Required for tax remittance reconciliation and regulatory reporting."
    - name: "total_discount_granted"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across invoices. Tracks discount leakage and promotional spend impact on revenue."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Net adjustments applied to invoices (credits, corrections). High values signal billing quality issues."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all open invoices. Core AR exposure metric for cash flow management."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected against invoices. Measures cash collection effectiveness."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput and operational capacity planning."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices flagged as disputed. Elevated counts signal billing accuracy or service delivery problems."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value. Tracks revenue per billing event and detects shifts in customer mix or pricing."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average unpaid balance per invoice. Indicates typical collection lag and credit risk exposure per account."
    - name: "subtotal_amount_sum"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-discount invoice subtotals. Used to isolate service revenue from tax and surcharge components."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing metrics enabling granular revenue analysis by service type, waste stream, charge category, and offering. Supports margin analysis, surcharge tracking, and tonnage-based revenue yield calculations."
  source: "`waste_management_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "charge_category"
      expr: charge_category
      comment: "Category of the charge on the line (e.g. SERVICE, SURCHARGE, DISPOSAL, RENTAL). Enables revenue decomposition by charge type."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the billed quantity (e.g. TON, LIFT, GALLON). Required for yield and rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the invoice line. Supports multi-currency revenue reporting."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Boolean flag indicating whether this specific line item is under dispute. Enables line-level dispute exposure analysis."
    - name: "revenue_recognition_rule"
      expr: revenue_recognition_rule
      comment: "Revenue recognition rule applied to this line (e.g. POINT_IN_TIME, OVER_TIME). Supports ASC 606 compliance reporting."
    - name: "service_period_start_month"
      expr: DATE_TRUNC('MONTH', service_period_start_date)
      comment: "Month the service period begins for this line. Enables period-accurate revenue attribution."
    - name: "service_date_month"
      expr: DATE_TRUNC('MONTH', service_date)
      comment: "Month the service was delivered. Supports operational revenue timing analysis."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the line item. Enables finance-level revenue account analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for the line item. Supports P&L attribution at the line level."
    - name: "adjustment_reason_code"
      expr: adjustment_reason_code
      comment: "Reason code for any adjustment applied to this line. Identifies root causes of billing corrections."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total gross revenue across all invoice lines. Granular revenue KPI enabling decomposition by service, waste stream, and charge type."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts and adjustments. Represents actual earned revenue for P&L reporting."
    - name: "total_tax_on_lines"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected at the line level. Supports tax remittance and jurisdiction-level tax reporting."
    - name: "total_discount_on_lines"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at the line level. Measures discount leakage and promotional impact on net revenue."
    - name: "total_tonnage_billed"
      expr: SUM(CAST(tonnage AS DOUBLE))
      comment: "Total tonnage billed across all lines. Key operational-financial bridge metric linking waste volumes to revenue."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total billed quantity (lifts, units, etc.). Enables rate-per-unit and yield analysis by service type."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across billed lines. Tracks pricing levels and rate erosion over time."
    - name: "disputed_line_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Number of disputed invoice lines. High counts indicate systemic billing accuracy issues requiring operational intervention."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Baseline volume metric for billing complexity and processing capacity."
    - name: "avg_net_amount_per_line"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net revenue per invoice line. Tracks revenue density per billing event and detects pricing shifts."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection and payment performance metrics. Tracks payment volumes, refund rates, NSF exposure, and unapplied cash — critical KPIs for Treasury, AR Operations, and CFO cash flow management."
  source: "`waste_management_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. CLEARED, PENDING, REVERSED, NSF). Enables collection pipeline analysis."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment transaction (e.g. STANDARD, PREPAYMENT, OVERPAYMENT). Supports cash application strategy."
    - name: "payment_method_channel"
      expr: channel
      comment: "Payment channel used (e.g. ONLINE, LOCKBOX, AUTOPAY, PHONE). Informs channel optimization and cost-to-collect analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the payment. Required for multi-currency treasury reporting."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt. Primary time dimension for cash collection trend analysis."
    - name: "gl_period"
      expr: gl_period
      comment: "General ledger accounting period for the payment. Supports period-close cash reconciliation."
    - name: "refund_status"
      expr: refund_status
      comment: "Status of any refund associated with the payment (e.g. PENDING, ISSUED, VOID). Tracks refund liability exposure."
    - name: "processor"
      expr: processor
      comment: "Payment processor used (e.g. STRIPE, BRAINTREE, BANK). Enables processor performance and cost benchmarking."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross cash received. Primary cash collection KPI for treasury and AR management."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to invoices. Measures cash application efficiency."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total cash received but not yet applied to invoices. High unapplied cash signals cash application backlog and revenue recognition risk."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued to customers. Tracks refund liability and customer satisfaction-driven cash outflows."
    - name: "total_nsf_fee_amount"
      expr: SUM(CAST(nsf_fee_amount AS DOUBLE))
      comment: "Total NSF (non-sufficient funds) fees assessed. Indicates payment failure rates and associated fee revenue."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions. Baseline volume metric for payment processing capacity and trend analysis."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Tracks typical payment size and detects shifts in customer payment behavior."
    - name: "unapplied_cash_rate"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash that remains unapplied. A key AR operations efficiency KPI — high rates indicate cash application process failures."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_ar_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable health and aging metrics. Provides executive visibility into outstanding balances, credit risk, collection status, and DSO — foundational KPIs for CFO, Credit Risk, and Collections teams."
  source: "`waste_management_ecm`.`billing`.`ar_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the AR account (e.g. ACTIVE, CLOSED, SUSPENDED). Enables active vs. inactive AR portfolio analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status (e.g. CURRENT, DELINQUENT, IN_COLLECTIONS, WRITTEN_OFF). Core credit risk segmentation dimension."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level for the account. Tracks severity of collection efforts across the AR portfolio."
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account (e.g. GOOD, WATCH, HOLD). Enables credit risk portfolio segmentation."
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle assigned to the account (e.g. MONTHLY, QUARTERLY). Supports cycle-level AR analysis."
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency of the AR account. Required for multi-currency AR reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method on the account. Informs autopay adoption and payment channel strategy."
    - name: "auto_pay_enrolled_flag"
      expr: auto_pay_enrolled_flag
      comment: "Whether the account is enrolled in autopay. Autopay accounts typically have lower delinquency rates."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the account is on credit hold. Accounts on hold represent service delivery and revenue risk."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the account has an active dispute. Disputed accounts require prioritized resolution to protect revenue."
    - name: "account_opened_month"
      expr: DATE_TRUNC('MONTH', account_opened_date)
      comment: "Month the AR account was opened. Supports cohort-based aging and credit risk analysis."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all accounts. Primary AR exposure KPI for cash flow forecasting and credit risk management."
    - name: "total_aging_0_30_days"
      expr: SUM(CAST(aging_bucket_0_30_days AS DOUBLE))
      comment: "Total AR balance aged 0-30 days. Represents current, low-risk receivables in the collection pipeline."
    - name: "total_aging_31_60_days"
      expr: SUM(CAST(aging_bucket_31_60_days AS DOUBLE))
      comment: "Total AR balance aged 31-60 days. Early-stage delinquency indicator requiring proactive collection outreach."
    - name: "total_aging_61_90_days"
      expr: SUM(CAST(aging_bucket_61_90_days AS DOUBLE))
      comment: "Total AR balance aged 61-90 days. Elevated risk bucket — accounts here are candidates for dunning escalation."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_bucket_over_90_days AS DOUBLE))
      comment: "Total AR balance aged over 90 days. Highest-risk bucket — primary input to bad debt reserve and write-off decisions."
    - name: "total_bad_debt_reserve"
      expr: SUM(CAST(bad_debt_reserve AS DOUBLE))
      comment: "Total bad debt reserve held against AR balances. Tracks provisioning adequacy for credit loss exposure."
    - name: "total_write_off_amount_ytd"
      expr: SUM(CAST(write_off_amount_ytd AS DOUBLE))
      comment: "Total year-to-date write-offs across AR accounts. Key credit quality KPI — rising write-offs signal deteriorating customer creditworthiness."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total AR balance under active dispute. Disputed balances are at risk of credit issuance and represent revenue leakage exposure."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit across AR accounts. Tracks credit utilization and headroom for customer spending."
    - name: "ar_account_count"
      expr: COUNT(1)
      comment: "Total number of AR accounts. Baseline portfolio size metric for per-account KPI normalization."
    - name: "accounts_on_credit_hold_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold. Elevated counts indicate credit risk concentration requiring management attention."
    - name: "over_90_day_aging_rate"
      expr: ROUND(100.0 * SUM(CAST(aging_bucket_over_90_days AS DOUBLE)) / NULLIF(SUM(CAST(current_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of total AR balance aged over 90 days. A critical credit quality ratio — industry benchmark is typically below 10%."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute resolution metrics tracking dispute volumes, financial exposure, resolution efficiency, and SLA compliance. Directly informs billing quality, customer satisfaction, and revenue protection strategies."
  source: "`waste_management_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. OPEN, RESOLVED, ESCALATED, CLOSED). Enables pipeline and backlog analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the dispute (e.g. INCORRECT_CHARGE, MISSED_PICKUP, DUPLICATE_INVOICE). Identifies root causes of billing failures."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g. CREDIT_ISSUED, INVOICE_VOIDED, NO_ACTION). Tracks resolution patterns and credit leakage."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "High-level root cause category for the dispute. Enables systemic issue identification and process improvement prioritization."
    - name: "financial_impact_category"
      expr: financial_impact_category
      comment: "Financial impact classification of the dispute (e.g. HIGH, MEDIUM, LOW). Supports prioritization of resolution resources."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the dispute. High escalation levels indicate unresolved customer dissatisfaction."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the dispute (e.g. CRITICAL, HIGH, NORMAL). Drives SLA and resource allocation decisions."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the dispute resolution SLA was breached. SLA breaches directly impact customer satisfaction scores and contract compliance."
    - name: "dispute_month"
      expr: DATE_TRUNC('MONTH', dispute_date)
      comment: "Calendar month the dispute was raised. Primary time dimension for dispute trend and seasonality analysis."
    - name: "customer_satisfaction_rating"
      expr: customer_satisfaction_rating
      comment: "Customer satisfaction rating recorded at dispute resolution. Links billing quality to customer experience outcomes."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute. Primary revenue-at-risk KPI — high values require immediate executive attention."
    - name: "total_credit_amount_issued"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits issued to resolve disputes. Measures revenue concession cost of billing errors and service failures."
    - name: "total_refund_amount_issued"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued through dispute resolution. Tracks cash outflows driven by billing disputes."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Baseline volume metric for billing quality and customer satisfaction monitoring."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes where resolution SLA was breached. SLA breaches carry contractual penalty risk and customer churn risk."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END)
      comment: "Number of disputes that reached an escalation level. Escalated disputes represent heightened customer dissatisfaction and management cost."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average financial value per dispute. Tracks typical dispute magnitude and detects shifts in dispute severity."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes where resolution SLA was breached. A key billing operations quality KPI — target is typically below 5%."
    - name: "credit_to_disputed_ratio"
      expr: ROUND(100.0 * SUM(CAST(credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of disputed amount resolved via credit issuance. High ratios indicate systemic billing errors driving revenue concessions."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing adjustment metrics tracking financial corrections, write-offs, revenue impact, and recovery performance. Enables revenue integrity monitoring and identification of systemic billing quality issues."
  source: "`waste_management_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of billing adjustment (e.g. CREDIT, DEBIT, WRITE_OFF, CORRECTION). Enables adjustment mix analysis."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g. PENDING, APPROVED, POSTED, REVERSED). Tracks adjustment lifecycle."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the adjustment. Pending approvals represent unresolved financial exposure."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the adjustment (e.g. SERVICE_FAILURE, PRICING_ERROR, GOODWILL). Identifies root causes of revenue corrections."
    - name: "gl_account_code"
      expr: gl_account_code
      comment: "General ledger account code for the adjustment. Enables finance-level adjustment attribution."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this adjustment is a reversal of a prior adjustment. Reversals indicate correction-of-correction scenarios requiring investigation."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Whether the adjustment represents a write-off. Write-off adjustments directly impact bad debt expense."
    - name: "bad_debt_flag"
      expr: bad_debt_flag
      comment: "Whether the adjustment is classified as bad debt. Enables bad debt trend analysis and reserve adequacy assessment."
    - name: "recovery_eligible_flag"
      expr: recovery_eligible_flag
      comment: "Whether the adjustment amount is eligible for recovery. Tracks potential revenue recovery pipeline."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the adjustment takes effect. Primary time dimension for adjustment trend and seasonality analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the adjustment. Required for multi-currency adjustment reporting."
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total net adjustment amount issued. Primary revenue integrity KPI — large or growing totals signal systemic billing quality problems."
    - name: "total_revenue_impact_amount"
      expr: SUM(CAST(revenue_impact_amount AS DOUBLE))
      comment: "Total revenue impact of all adjustments. Directly measures the P&L effect of billing corrections and credits."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from previously adjusted balances. Tracks effectiveness of recovery efforts on written-off or credited amounts."
    - name: "total_original_charge_amount"
      expr: SUM(CAST(original_charge_amount AS DOUBLE))
      comment: "Total original charge amount before adjustment. Provides context for adjustment magnitude relative to original billing."
    - name: "total_corrected_charge_amount"
      expr: SUM(CAST(corrected_charge_amount AS DOUBLE))
      comment: "Total corrected charge amount after adjustment. Represents the revised billing value post-correction."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of adjustments issued. Baseline volume metric for billing correction frequency and process quality."
    - name: "write_off_count"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Number of adjustments classified as write-offs. Tracks bad debt event frequency for credit risk management."
    - name: "recovery_eligible_count"
      expr: COUNT(CASE WHEN recovery_eligible_flag = TRUE THEN 1 END)
      comment: "Number of adjustments eligible for recovery. Quantifies the recoverable adjustment pipeline for collections strategy."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average adjustment amount per transaction. Tracks typical correction magnitude and detects outlier adjustment events."
    - name: "revenue_impact_to_adjustment_ratio"
      expr: ROUND(100.0 * SUM(CAST(revenue_impact_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Ratio of revenue impact to total adjustment amount. Values near 100% indicate adjustments are fully flowing through to P&L."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_rated_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Usage-based billing performance metrics tracking rated charges, surcharges, fuel costs, and environmental fees by service type, waste stream, and accounting period. Core KPI layer for revenue yield and pricing effectiveness analysis."
  source: "`waste_management_ecm`.`billing`.`rated_usage`"
  dimensions:
    - name: "rating_status"
      expr: rating_status
      comment: "Status of the usage rating process (e.g. RATED, ERROR, PENDING, OVERRIDE). Enables billing pipeline health monitoring."
    - name: "service_type_code"
      expr: service_type_code
      comment: "Code identifying the type of service rated (e.g. RESIDENTIAL_COLLECTION, ROLLOFF, RECYCLING). Primary service mix dimension."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for rated usage (e.g. TON, LIFT, GALLON). Required for yield and rate-per-unit analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for the rated usage charge. Supports multi-currency revenue reporting."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for the rated usage. Enables period-accurate revenue recognition and close reporting."
    - name: "override_flag"
      expr: override_flag
      comment: "Whether the rated charge was manually overridden. High override rates indicate pricing engine issues or excessive manual intervention."
    - name: "override_reason_code"
      expr: override_reason_code
      comment: "Reason code for manual rating overrides. Identifies patterns in pricing exceptions requiring process improvement."
    - name: "revenue_recognition_rule"
      expr: revenue_recognition_rule
      comment: "Revenue recognition rule applied to the rated usage. Supports ASC 606 compliance and period-close accuracy."
    - name: "usage_month"
      expr: DATE_TRUNC('MONTH', usage_date)
      comment: "Calendar month of usage. Primary time dimension for usage-based revenue trend analysis."
    - name: "rating_error_code"
      expr: rating_error_code
      comment: "Error code from the rating engine. Enables systematic diagnosis of rating failures impacting revenue."
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total rated charge amount including all components. Primary usage-based revenue KPI for pricing and yield analysis."
    - name: "total_base_charge_amount"
      expr: SUM(CAST(base_charge_amount AS DOUBLE))
      comment: "Total base service charge before surcharges and taxes. Isolates core service revenue from pass-through fees."
    - name: "total_fuel_surcharge_amount"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharge revenue. Tracks fuel cost recovery effectiveness and surcharge yield against fuel cost exposure."
    - name: "total_environmental_fee_amount"
      expr: SUM(CAST(environmental_fee_amount AS DOUBLE))
      comment: "Total environmental fee revenue. Tracks regulatory fee recovery and environmental compliance cost pass-through."
    - name: "total_tax_on_usage"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax assessed on rated usage. Supports tax remittance reconciliation at the usage level."
    - name: "total_usage_quantity"
      expr: SUM(CAST(usage_quantity AS DOUBLE))
      comment: "Total usage quantity rated (tons, lifts, etc.). Operational volume metric linking service delivery to revenue generation."
    - name: "rated_usage_record_count"
      expr: COUNT(1)
      comment: "Total number of rated usage records. Baseline volume metric for billing engine throughput and coverage."
    - name: "override_count"
      expr: COUNT(CASE WHEN override_flag = TRUE THEN 1 END)
      comment: "Number of usage records with manual rating overrides. High counts indicate pricing engine reliability issues."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across all rated usage records. Tracks effective pricing levels and rate realization vs. contracted rates."
    - name: "override_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rated usage records with manual overrides. A pricing governance KPI — high override rates signal pricing engine or contract data quality issues."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan performance metrics tracking enrolled balances, collection progress, default risk, and settlement outcomes. Enables Credit and Collections teams to manage delinquent account recovery strategies."
  source: "`waste_management_ecm`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the payment plan (e.g. ACTIVE, DEFAULTED, COMPLETED, CANCELLED). Enables plan portfolio health analysis."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (e.g. STANDARD, BANKRUPTCY, HARDSHIP). Supports segmentation by customer financial situation."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of installment payments (e.g. WEEKLY, MONTHLY). Informs cash flow forecasting from payment plans."
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Whether autopay is enabled on the plan. Autopay plans have significantly lower default rates."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the plan required management approval. Flags high-risk or non-standard plans requiring oversight."
    - name: "plan_start_month"
      expr: DATE_TRUNC('MONTH', plan_start_date)
      comment: "Month the payment plan was initiated. Enables cohort-based default and completion rate analysis."
    - name: "bankruptcy_chapter"
      expr: bankruptcy_chapter
      comment: "Bankruptcy chapter if applicable (e.g. CHAPTER_7, CHAPTER_11, CHAPTER_13). Enables bankruptcy-specific recovery analysis."
  measures:
    - name: "total_enrolled_balance"
      expr: SUM(CAST(enrolled_balance_amount AS DOUBLE))
      comment: "Total balance enrolled in payment plans. Measures the scale of delinquent AR being managed through structured repayment."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance_amount AS DOUBLE))
      comment: "Total outstanding balance remaining on active payment plans. Tracks recovery pipeline and expected future cash collections."
    - name: "total_paid_on_plans"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount collected through payment plans. Measures recovery effectiveness of structured repayment programs."
    - name: "total_settlement_discount_amount"
      expr: SUM(CAST(settlement_discount_amount AS DOUBLE))
      comment: "Total settlement discounts granted on payment plans. Tracks revenue concessions made to secure delinquent account recovery."
    - name: "total_late_fees_assessed"
      expr: SUM(CAST(total_late_fees_assessed AS DOUBLE))
      comment: "Total late fees assessed on payment plans. Tracks fee revenue from plan defaults and payment delays."
    - name: "total_interest_accrued"
      expr: SUM(CAST(interest_accrued_amount AS DOUBLE))
      comment: "Total interest accrued on payment plans. Measures carrying cost revenue on delinquent balances."
    - name: "payment_plan_count"
      expr: COUNT(1)
      comment: "Total number of payment plans. Baseline metric for delinquency management program scale."
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment payment amount. Tracks typical repayment capacity of customers on payment plans."
    - name: "plan_recovery_rate"
      expr: ROUND(100.0 * SUM(CAST(total_paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(enrolled_balance_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of enrolled balance recovered through payment plans. Primary payment plan effectiveness KPI for Collections leadership."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`billing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing run execution metrics tracking throughput, error rates, financial totals, and processing performance. Enables Billing Operations to monitor run quality, identify failures, and ensure timely invoice generation."
  source: "`waste_management_ecm`.`billing`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the billing run (e.g. COMPLETED, FAILED, IN_PROGRESS, CANCELLED). Primary run health dimension."
    - name: "run_type"
      expr: run_type
      comment: "Type of billing run (e.g. STANDARD, CORRECTION, FINAL, PRELIMINARY). Enables run type mix and quality analysis."
    - name: "ar_posting_status"
      expr: ar_posting_status
      comment: "Status of AR posting for the run (e.g. POSTED, PENDING, FAILED). Tracks financial close readiness."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the run required management approval before release. Flags non-standard runs requiring oversight."
    - name: "billing_period_start_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the billing period covered by the run. Primary time dimension for billing cycle performance analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the billing run (e.g. SAP, ORACLE, CUSTOM). Enables system-level performance benchmarking."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed across all runs. Aggregate billing throughput KPI for revenue operations monitoring."
    - name: "total_service_charge_amount"
      expr: SUM(CAST(total_service_charge_amount AS DOUBLE))
      comment: "Total service charges generated across billing runs. Isolates core service revenue from tax and adjustment components."
    - name: "total_tax_amount_billed"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount generated across billing runs. Supports tax remittance reconciliation at the run level."
    - name: "total_adjustment_amount_in_runs"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts processed across billing runs. High values relative to billed amounts signal billing quality issues."
    - name: "billing_run_count"
      expr: COUNT(1)
      comment: "Total number of billing runs executed. Baseline metric for billing operations throughput and cycle frequency."
    - name: "avg_billed_amount_per_run"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average amount billed per run. Tracks billing run scale and detects anomalous runs requiring investigation."
    - name: "total_usage_charge_amount"
      expr: SUM(CAST(total_usage_charge_amount AS DOUBLE))
      comment: "Total usage-based charges generated across billing runs. Tracks variable revenue component from consumption-based billing."
$$;