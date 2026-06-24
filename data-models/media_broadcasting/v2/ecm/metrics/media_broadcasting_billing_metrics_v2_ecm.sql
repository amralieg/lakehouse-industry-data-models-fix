-- Metric views for domain: billing | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics tracking total billings, outstanding balances, discount impact, and tax exposure across billing periods. Used by Finance and Revenue Operations to monitor AR health and billing cycle effectiveness."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status_id
      comment: "Current status of the invoice (e.g. draft, sent, paid, void) for pipeline segmentation."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month bucket of the billing period start date for trend analysis."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued, used for revenue recognition timing analysis."
    - name: "proration_flag"
      expr: proration_flag
      comment: "Indicates whether the invoice includes prorated charges, useful for partial-period billing analysis."
    - name: "revenue_stream"
      expr: revenue_stream_id
      comment: "Revenue stream associated with the invoice for P&L attribution."
    - name: "cost_center"
      expr: cost_center_id
      comment: "Cost center dimension for departmental billing analysis."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total gross amount billed across all invoices. Primary top-line billing KPI used in revenue reporting and QBRs."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unpaid balance across all invoices. Key AR health indicator — rising balance signals collection risk."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against invoices. Tracks payment velocity and cash conversion effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across invoices. Monitors discount leakage and promotional spend impact on revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across invoices. Required for tax remittance reporting and compliance."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Pre-tax, pre-discount invoice subtotal. Used to isolate net billing volume from tax and discount effects."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-issuance adjustments applied to invoices. Tracks billing correction volume and operational quality."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing run productivity and capacity planning."
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount_due AS DOUBLE))
      comment: "Average invoice value. Tracks deal size trends and identifies shifts in customer mix or pricing."
    - name: "distinct_billing_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts invoiced. Measures active customer billing footprint."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection and cash application metrics tracking payment volumes, refund activity, and dispute exposure. Used by Treasury and AR Operations to monitor cash flow and payment processing health."
  source: "`vibe_media_broadcasting_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: billing_status_id
      comment: "Current status of the payment (e.g. pending, settled, reversed) for cash flow segmentation."
    - name: "payment_method_type"
      expr: method_type_id
      comment: "Payment method type (e.g. ACH, credit card, wire) for payment channel analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for cash collection trend analysis."
    - name: "is_autopay"
      expr: is_autopay
      comment: "Whether payment was collected via autopay. Autopay penetration is a key subscriber retention and collection efficiency indicator."
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the payment is under dispute. Segments disputed vs clean payment volume."
    - name: "payment_channel"
      expr: channel
      comment: "Channel through which payment was received (e.g. online, phone, mail) for channel mix analysis."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment amount received. Primary cash collection KPI for Treasury and CFO reporting."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices. Measures cash application completeness — gap vs total_payment_amount indicates unapplied cash."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied payment balance. High unapplied cash signals AR processing backlog and revenue recognition risk."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refunds issued against payments. Tracks refund exposure and customer satisfaction issues."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed. Baseline volume metric for payment operations capacity."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment transaction size. Tracks payment behavior trends and identifies anomalies."
    - name: "distinct_paying_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts making payments. Measures active payer base and collection reach."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute resolution metrics tracking dispute volume, financial exposure, resolution velocity, and SLA compliance. Used by Revenue Operations and Customer Finance to manage dispute risk and operational quality."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status_id
      comment: "Current status of the dispute (e.g. open, under review, resolved) for pipeline management."
    - name: "dispute_type"
      expr: dispute_type_id
      comment: "Category of dispute (e.g. billing error, service failure, rate dispute) for root cause analysis."
    - name: "disputing_party_type"
      expr: disputing_party_type_id
      comment: "Type of party raising the dispute (e.g. advertiser, subscriber, partner) for segmentation."
    - name: "root_cause_category"
      expr: root_cause_category_id
      comment: "Root cause classification of the dispute for systemic issue identification and process improvement."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the dispute resolution breached SLA. Key operational quality indicator."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the dispute was opened for trend and seasonality analysis."
    - name: "credit_memo_issued_flag"
      expr: credit_memo_issued_flag
      comment: "Whether a credit memo was issued to resolve the dispute. Tracks financial resolution rate."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute. Primary risk exposure metric for CFO and Revenue Operations."
    - name: "total_credit_amount_issued"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credits issued to resolve disputes. Tracks financial concession cost and revenue leakage from disputes."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes raised. Volume indicator for billing quality and customer satisfaction."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case. Tracks severity trends and helps prioritize high-value dispute resolution."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputes that breached resolution SLA. Operational quality KPI — high breach count triggers process review."
    - name: "credit_memo_issued_count"
      expr: SUM(CASE WHEN credit_memo_issued_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputes resolved via credit memo issuance. Measures financial resolution rate."
    - name: "distinct_disputing_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique partners with active disputes. Identifies partner relationship health issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off metrics tracking write-off volume, recovery performance, and EBITDA impact. Used by CFO, Credit Risk, and AR leadership to monitor credit loss exposure and collection effectiveness."
  source: "`vibe_media_broadcasting_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_date_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month of write-off for trend analysis and period-over-period comparison."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the write-off for annual bad debt reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the write-off for sub-annual reporting and period close analysis."
    - name: "ebitda_impact_flag"
      expr: ebitda_impact_flag
      comment: "Whether the write-off impacts EBITDA. Segments material vs non-material write-offs for executive reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether the write-off was subsequently reversed. Tracks write-off quality and recovery events."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category of the written-off amount for P&L attribution."
    - name: "cost_center"
      expr: cost_center_id
      comment: "Cost center responsible for the written-off receivable for departmental accountability."
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross amount written off as bad debt. Primary credit loss KPI for CFO and board reporting."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered after write-off. Measures collection agency and recovery program effectiveness."
    - name: "total_original_invoice_amount"
      expr: SUM(CAST(original_invoice_amount AS DOUBLE))
      comment: "Total original invoice value of written-off accounts. Provides context for write-off severity relative to original billing."
    - name: "total_outstanding_at_write_off"
      expr: SUM(CAST(outstanding_balance_at_write_off AS DOUBLE))
      comment: "Total outstanding balance at time of write-off. Measures the net AR exposure eliminated through write-off."
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off events. Volume indicator for credit risk and collection process health."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per event. Tracks severity trends and informs credit limit policy decisions."
    - name: "ebitda_impacting_write_off_amount"
      expr: SUM(CASE WHEN ebitda_impact_flag = TRUE THEN amount ELSE 0 END)
      comment: "Write-off amount with direct EBITDA impact. Critical for earnings reporting and investor communications."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_ad_billing_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising billing order financial metrics tracking contracted vs billed vs paid amounts, makegood exposure, and CPM/GRP performance. Used by Ad Sales Finance and Revenue Operations to monitor advertising revenue realization."
  source: "`vibe_media_broadcasting_v1`.`billing`.`ad_billing_order`"
  dimensions:
    - name: "billing_status"
      expr: billing_status_id
      comment: "Current billing status of the ad order (e.g. invoiced, paid, disputed) for pipeline management."
    - name: "affidavit_status"
      expr: affidavit_status_id
      comment: "Affidavit verification status indicating whether spot delivery has been confirmed for billing."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the ad flight began for revenue period attribution."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month the ad order was placed for bookings trend analysis."
    - name: "rate_basis"
      expr: rate_basis
      comment: "Pricing basis for the order (e.g. CPM, GRP, flat rate) for yield analysis segmentation."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month revenue is recognized for ASC 606 compliance reporting."
  measures:
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted advertising revenue. Represents the committed revenue backlog for ad sales forecasting."
    - name: "total_billed_amount"
      expr: SUM(CAST(billed_amount AS DOUBLE))
      comment: "Total amount actually billed to advertisers. Measures revenue realization against contracted commitments."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total cash collected from advertisers. Primary cash collection KPI for ad revenue operations."
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid advertising receivables. AR exposure metric for credit risk and collections management."
    - name: "total_makegoods_value"
      expr: SUM(CAST(makegoods_value AS DOUBLE))
      comment: "Total value of makegoods issued for missed or underdelivered spots. Tracks delivery quality cost and revenue at risk."
    - name: "avg_cpm_rate"
      expr: AVG(CAST(cpm_rate AS DOUBLE))
      comment: "Average CPM rate across ad billing orders. Tracks pricing yield and rate card effectiveness."
    - name: "avg_grp_rate"
      expr: AVG(CAST(grp_rate AS DOUBLE))
      comment: "Average GRP rate across ad billing orders. Monitors audience-based pricing performance."
    - name: "ad_billing_order_count"
      expr: COUNT(1)
      comment: "Total number of ad billing orders. Volume baseline for ad operations capacity and billing throughput."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_ad_billing_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advertising billing reconciliation metrics tracking delivery variance, makegood activity, and reconciliation quality. Used by Ad Operations and Finance to ensure accurate billing against actual spot delivery."
  source: "`vibe_media_broadcasting_v1`.`billing`.`ad_billing_reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status_id
      comment: "Current status of the reconciliation (e.g. pending, complete, disputed) for workflow management."
    - name: "reconciliation_type"
      expr: reconciliation_type_id
      comment: "Type of reconciliation (e.g. affidavit, makegood, adjustment) for process segmentation."
    - name: "affidavit_verification_status"
      expr: affidavit_verification_status_id
      comment: "Affidavit verification outcome for delivery confirmation quality analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the reconciliation is under dispute. Segments clean vs disputed reconciliations."
    - name: "reconciliation_date_month"
      expr: DATE_TRUNC('MONTH', reconciliation_date)
      comment: "Month of reconciliation for trend and period-close analysis."
    - name: "flight_start_month"
      expr: DATE_TRUNC('MONTH', flight_start_date)
      comment: "Month the ad flight started for revenue period attribution."
  measures:
    - name: "total_contracted_amount"
      expr: SUM(CAST(contracted_amount AS DOUBLE))
      comment: "Total contracted amount subject to reconciliation. Baseline for variance analysis."
    - name: "total_delivered_amount"
      expr: SUM(CAST(delivered_amount AS DOUBLE))
      comment: "Total amount delivered and confirmed via affidavit. Measures actual delivery against contracted commitments."
    - name: "total_net_billable_amount"
      expr: SUM(CAST(net_billable_amount AS DOUBLE))
      comment: "Total net billable amount after reconciliation adjustments. The authoritative billing figure post-reconciliation."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-reconciliation adjustments. Tracks billing correction volume and financial impact of delivery discrepancies."
    - name: "total_makegood_value"
      expr: SUM(CAST(makegood_value_amount AS DOUBLE))
      comment: "Total makegood value issued. Measures the cost of delivery failures and their financial remediation."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average delivery variance percentage. Key quality metric — high variance indicates systematic delivery or billing issues."
    - name: "reconciliation_count"
      expr: COUNT(1)
      comment: "Total number of reconciliation records processed. Operational throughput metric for ad billing operations."
    - name: "disputed_reconciliation_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reconciliations under dispute. Tracks billing quality and advertiser satisfaction issues."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_subscription_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription billing metrics tracking recurring revenue, churn risk, proration, and promotional discount impact. Used by Subscriber Finance and Product leadership to monitor subscription revenue health and retention signals."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected from subscription invoices. Measures payment success rate and cash conversion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on subscription invoices. Required for tax remittance and compliance reporting."
    - name: "subscription_invoice_count"
      expr: COUNT(1)
      comment: "Total subscription invoices generated. Baseline volume metric for billing run productivity."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_revenue_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition schedule metrics tracking deferred revenue balances, recognition progress, and ASC 606 compliance. Used by Finance and Accounting to manage revenue recognition accuracy and period-close processes."
  source: "`vibe_media_broadcasting_v1`.`billing`.`revenue_recognition_schedule`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status_id
      comment: "Current recognition status (e.g. scheduled, in-progress, complete) for pipeline management."
    - name: "recognition_method"
      expr: recognition_method_id
      comment: "Revenue recognition method applied (e.g. straight-line, event-based) for policy compliance analysis."
    - name: "approval_status"
      expr: approval_status_id
      comment: "Approval status of the recognition schedule for SOX control and audit trail."
    - name: "contract_type"
      expr: contract_type_id
      comment: "Contract type driving the recognition schedule for revenue category analysis."
    - name: "recognition_start_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month recognition begins for period-accurate revenue scheduling."
    - name: "next_recognition_date_month"
      expr: DATE_TRUNC('MONTH', next_recognition_date)
      comment: "Month of next scheduled recognition event for forward-looking revenue pipeline."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit associated with the recognition schedule for segment-level revenue reporting."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value under revenue recognition schedules. Represents the full revenue backlog being recognized."
    - name: "total_cumulative_recognized"
      expr: SUM(CAST(cumulative_recognized_amount AS DOUBLE))
      comment: "Total revenue recognized to date across all schedules. Measures recognition progress against total contract value."
    - name: "total_deferred_revenue_balance"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance remaining. Critical balance sheet liability metric for period-close and investor reporting."
    - name: "total_current_period_recognized"
      expr: SUM(CAST(current_period_recognized_amount AS DOUBLE))
      comment: "Revenue recognized in the current period. Primary input for period revenue reporting and variance analysis."
    - name: "total_monthly_recognized"
      expr: SUM(CAST(monthly_recognized_amount AS DOUBLE))
      comment: "Monthly recognized revenue amount. Used for MRR calculation and revenue run-rate analysis."
    - name: "recognition_schedule_count"
      expr: COUNT(1)
      comment: "Total number of active revenue recognition schedules. Measures recognition complexity and accounting workload."
    - name: "avg_deferred_revenue_balance"
      expr: AVG(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Average deferred revenue balance per schedule. Tracks typical recognition lag and contract duration patterns."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund processing metrics tracking refund volume, net refund amounts, chargeback exposure, and processing efficiency. Used by Customer Finance and Operations to monitor refund liability and customer satisfaction costs."
  source: "`vibe_media_broadcasting_v1`.`billing`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status_id
      comment: "Current status of the refund (e.g. pending, processed, settled) for pipeline management."
    - name: "refund_type"
      expr: refund_type_id
      comment: "Type of refund (e.g. full, partial, chargeback) for root cause and financial impact analysis."
    - name: "refund_method"
      expr: refund_method_id
      comment: "Method used to issue the refund (e.g. original payment method, check, credit) for operational analysis."
    - name: "reason_code"
      expr: reason_code_id
      comment: "Reason code for the refund for root cause analysis and process improvement."
    - name: "is_chargeback_related"
      expr: is_chargeback_related
      comment: "Whether the refund is chargeback-related. Chargebacks carry additional fees and merchant risk implications."
    - name: "is_partial_refund"
      expr: is_partial_refund
      comment: "Whether the refund is partial. Partial refunds indicate negotiated resolutions vs full reversals."
    - name: "request_date_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month refund was requested for trend and seasonality analysis."
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross refund amount issued. Primary refund liability metric for CFO and customer finance reporting."
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_refund_amount AS DOUBLE))
      comment: "Total net refund amount after fees. Measures actual cash outflow from refund activity."
    - name: "total_refund_fee"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees incurred on refund processing. Tracks payment processing cost of refund activity."
    - name: "refund_count"
      expr: COUNT(1)
      comment: "Total number of refunds processed. Volume indicator for customer satisfaction issues and billing quality."
    - name: "chargeback_refund_count"
      expr: SUM(CASE WHEN is_chargeback_related = TRUE THEN 1 ELSE 0 END)
      comment: "Number of chargeback-related refunds. High chargeback count triggers payment processor risk review and potential fee increases."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per event. Tracks refund severity trends and informs refund policy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_dunning_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collections process metrics tracking recovery amounts, account terminations, service suspensions, and dunning effectiveness. Used by Collections and AR leadership to optimize the dunning strategy and minimize bad debt."
  source: "`vibe_media_broadcasting_v1`.`billing`.`dunning_event`"
  dimensions:
    - name: "action_type"
      expr: action_type_id
      comment: "Type of dunning action taken (e.g. reminder, suspension, termination) for process stage analysis."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for dunning communication (e.g. email, SMS, phone) for channel effectiveness analysis."
    - name: "action_date_month"
      expr: DATE_TRUNC('MONTH', action_timestamp)
      comment: "Month the dunning action was taken for trend and cohort analysis."
    - name: "account_termination_flag"
      expr: account_termination_flag
      comment: "Whether the dunning action resulted in account termination. Tracks churn driven by non-payment."
    - name: "service_suspension_flag"
      expr: service_suspension_flag
      comment: "Whether service was suspended as part of the dunning action. Measures escalation intensity."
    - name: "response_received_flag"
      expr: response_received_flag
      comment: "Whether the customer responded to the dunning communication. Measures dunning engagement rate."
  measures:
    - name: "total_amount_recovered"
      expr: SUM(CAST(amount_recovered AS DOUBLE))
      comment: "Total amount recovered through dunning actions. Primary collections effectiveness KPI."
    - name: "total_account_balance_at_action"
      expr: SUM(CAST(account_balance_at_action AS DOUBLE))
      comment: "Total outstanding balance at time of dunning action. Measures the financial exposure being pursued through collections."
    - name: "dunning_event_count"
      expr: COUNT(1)
      comment: "Total number of dunning events executed. Operational volume metric for collections team capacity planning."
    - name: "account_termination_count"
      expr: SUM(CASE WHEN account_termination_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accounts terminated due to non-payment. Tracks involuntary churn driven by collections escalation."
    - name: "service_suspension_count"
      expr: SUM(CASE WHEN service_suspension_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of service suspensions executed. Measures mid-escalation intervention intensity."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score at time of dunning action. Helps prioritize high-risk accounts for proactive retention."
    - name: "response_received_count"
      expr: SUM(CASE WHEN response_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of dunning communications that received a customer response. Measures dunning engagement and channel effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_syndication_license_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Syndication license fee billing metrics tracking fee amounts, withholding tax, payment status, and installment schedules. Used by Content Licensing Finance and Partner Management to monitor syndication revenue collection."
  source: "`vibe_media_broadcasting_v1`.`billing`.`syndication_license_fee`"
  dimensions:
    - name: "billing_status"
      expr: billing_status_id
      comment: "Current billing status of the syndication license fee (e.g. invoiced, paid, overdue)."
    - name: "recognition_status"
      expr: recognition_status_id
      comment: "Revenue recognition status for ASC 606 compliance reporting."
    - name: "license_window_type"
      expr: license_window_type_id
      comment: "Type of license window (e.g. first-run, rerun, VOD) for revenue mix analysis."
    - name: "license_start_month"
      expr: DATE_TRUNC('MONTH', license_start_date)
      comment: "Month the license period begins for revenue period attribution."
    - name: "revenue_recognition_date_month"
      expr: DATE_TRUNC('MONTH', revenue_recognition_date)
      comment: "Month revenue is recognized for period-accurate financial reporting."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the syndication deal for segment-level revenue reporting."
    - name: "license_territory"
      expr: license_territory
      comment: "Geographic territory of the license for international revenue analysis."
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total syndication license fees billed. Primary syndication revenue KPI for content licensing P&L."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment received after withholding tax. Measures actual cash collected from syndication licenses."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from syndication payments. Required for international tax compliance reporting."
    - name: "syndication_fee_count"
      expr: COUNT(1)
      comment: "Total number of syndication license fee records. Volume metric for content licensing activity."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average syndication license fee. Tracks deal size trends and pricing benchmarks for content licensing."
    - name: "avg_withholding_tax_rate"
      expr: AVG(CAST(withholding_tax_rate AS DOUBLE))
      comment: "Average withholding tax rate applied. Monitors international tax exposure and treaty benefit utilization."
    - name: "distinct_partners"
      expr: COUNT(DISTINCT partner_id)
      comment: "Number of unique syndication partners billed. Measures breadth of active syndication relationships."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_carriage_fee_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carriage fee invoice metrics tracking per-subscriber fees, blackout credits, and total carriage revenue from distribution partners. Used by Distribution Finance and Partner Management to monitor affiliate carriage revenue."
  source: "`vibe_media_broadcasting_v1`.`billing`.`invoice`"
  dimensions:
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of the carriage fee billing period for trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month payment is due for cash flow forecasting."
  measures:
    - name: "carriage_invoice_count"
      expr: COUNT(1)
      comment: "Total number of carriage fee invoices issued. Volume metric for distribution billing operations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment allocation efficiency metrics tracking cash application completeness, unapplied balances, write-offs, and discount utilization. Used by AR Operations and Finance to ensure accurate cash application and minimize unapplied cash."
  source: "`vibe_media_broadcasting_v1`.`billing`.`payment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status_id
      comment: "Current status of the allocation (e.g. pending, applied, reversed) for workflow management."
    - name: "allocation_type"
      expr: allocation_type_id
      comment: "Type of allocation (e.g. standard, credit memo, write-off) for cash application analysis."
    - name: "allocation_method"
      expr: allocation_method_id
      comment: "Method used for allocation (e.g. FIFO, specific invoice) for process consistency analysis."
    - name: "reconciliation_status"
      expr: reconciliation_status_id
      comment: "Reconciliation status of the allocation for period-close quality control."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month of allocation for cash application trend analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the allocation is under dispute. Segments clean vs disputed cash applications."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount successfully allocated to invoices. Primary cash application completeness KPI."
    - name: "total_unapplied_balance"
      expr: SUM(CAST(unapplied_balance AS DOUBLE))
      comment: "Total unapplied cash balance remaining. High unapplied balance signals AR processing backlog and revenue recognition risk."
    - name: "total_writeoff_amount"
      expr: SUM(CAST(writeoff_amount AS DOUBLE))
      comment: "Total amount written off through payment allocation. Tracks bad debt recognition through the allocation process."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts applied through allocation. Measures discount utilization and its revenue impact."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied during allocation. Tracks billing correction volume in the cash application process."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of payment allocations processed. Operational throughput metric for AR operations."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax collection and remittance metrics tracking taxable amounts, tax collected, exemptions, and remittance status. Used by Tax and Finance to ensure accurate tax reporting and regulatory compliance."
  source: "`vibe_media_broadcasting_v1`.`billing`.`tax_record`"
  dimensions:
    - name: "tax_type"
      expr: tax_type_id
      comment: "Type of tax (e.g. sales tax, VAT, GST) for tax category analysis and reporting."
    - name: "tax_category"
      expr: tax_category_id
      comment: "Tax category for product/service classification in tax reporting."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code_id
      comment: "Tax jurisdiction for geographic tax liability analysis and nexus reporting."
    - name: "remittance_status"
      expr: remittance_status_id
      comment: "Status of tax remittance to authorities (e.g. pending, remitted, overdue) for compliance monitoring."
    - name: "tax_exemption_flag"
      expr: tax_exemption_flag
      comment: "Whether the transaction is tax-exempt. Segments taxable vs exempt revenue for compliance analysis."
    - name: "reverse_charge_flag"
      expr: reverse_charge_flag
      comment: "Whether reverse charge VAT applies. Required for EU VAT compliance reporting."
    - name: "transaction_date_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the taxable transaction for period tax liability analysis."
    - name: "nexus_country"
      expr: nexus_country
      comment: "Country of tax nexus for international tax exposure analysis."
  measures:
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable transaction amount. Baseline for tax liability calculation and audit verification."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected. Primary tax liability metric for remittance and regulatory reporting."
    - name: "avg_tax_rate"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate applied. Monitors rate consistency and identifies anomalies requiring investigation."
    - name: "tax_record_count"
      expr: COUNT(1)
      comment: "Total number of tax records. Volume metric for tax processing capacity and audit scope."
    - name: "tax_exempt_record_count"
      expr: SUM(CASE WHEN tax_exemption_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tax-exempt transactions. Tracks exemption certificate utilization and compliance risk."
    - name: "disputed_tax_record_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of tax records under dispute. Tracks tax dispute exposure and audit risk."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo issuance metrics tracking credit amounts, recovery activity, and bad debt write-off exposure. Used by Revenue Operations and Finance to monitor billing correction costs and credit policy effectiveness."
  source: "`vibe_media_broadcasting_v1`.`billing`.`credit_memo`"
  dimensions:
    - name: "credit_memo_status"
      expr: credit_memo_status_id
      comment: "Current status of the credit memo (e.g. draft, issued, applied, voided) for pipeline management."
    - name: "reason_code"
      expr: reason_code_id
      comment: "Reason code for the credit memo issuance for root cause analysis and process improvement."
    - name: "bad_debt_write_off_flag"
      expr: bad_debt_write_off_flag
      comment: "Whether the credit memo is associated with a bad debt write-off. Segments credit activity by financial impact type."
    - name: "collection_agency_referral_flag"
      expr: collection_agency_referral_flag
      comment: "Whether the account was referred to a collection agency. Tracks escalation rate for delinquent accounts."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the credit memo was issued for trend analysis."
    - name: "cost_center"
      expr: cost_center_id
      comment: "Cost center associated with the credit memo for departmental accountability."
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total gross credit amount issued. Primary revenue leakage metric from billing corrections and concessions."
    - name: "total_net_credit_amount"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Total net credit amount after tax adjustments. Measures actual financial impact of credit memo activity."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax adjustment associated with credit memos. Required for accurate tax liability recalculation."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered after credit memo issuance. Measures partial recovery from disputed or adjusted billing."
    - name: "credit_memo_count"
      expr: COUNT(1)
      comment: "Total number of credit memos issued. Volume indicator for billing quality and customer satisfaction issues."
    - name: "bad_debt_credit_count"
      expr: SUM(CASE WHEN bad_debt_write_off_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of credit memos associated with bad debt write-offs. Tracks credit activity driven by uncollectible receivables."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit memo amount. Tracks credit severity trends and informs credit approval policy thresholds."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio metrics tracking account balances, credit limits, payment terms, and account health. Used by Credit Risk and AR leadership to monitor the overall billing account portfolio and identify at-risk accounts."
  source: "`vibe_media_broadcasting_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_status"
      expr: account_status_id
      comment: "Current status of the billing account (e.g. active, suspended, closed) for portfolio health segmentation."
    - name: "account_type"
      expr: account_type_id
      comment: "Type of billing account (e.g. advertiser, subscriber, partner) for segment-level analysis."
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Whether autopay is enabled on the account. Autopay accounts have lower delinquency and churn rates."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the account is tax-exempt. Segments taxable vs exempt account portfolio."
    - name: "opened_date_month"
      expr: DATE_TRUNC('MONTH', opened_date)
      comment: "Month the account was opened for cohort and vintage analysis."
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance_amount AS DOUBLE))
      comment: "Total outstanding balance across all billing accounts. Portfolio-level AR exposure metric for CFO reporting."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all billing accounts. Measures total credit exposure and utilization headroom."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payments across accounts. Measures recent payment activity and cash collection velocity."
    - name: "billing_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline portfolio size metric for capacity and growth planning."
    - name: "autopay_enabled_account_count"
      expr: SUM(CASE WHEN auto_pay_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of accounts with autopay enabled. Autopay penetration is a key payment success and churn reduction KPI."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance_amount AS DOUBLE))
      comment: "Average outstanding balance per billing account. Tracks typical account exposure and identifies outliers."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`billing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing run execution metrics tracking billing throughput, error rates, invoice generation volumes, and processing performance. Used by Billing Operations to monitor billing cycle health and identify processing issues."
  source: "`vibe_media_broadcasting_v1`.`billing`.`run`"
  dimensions:
    - name: "run_status"
      expr: run_status_id
      comment: "Current status of the billing run (e.g. scheduled, running, complete, failed) for operational monitoring."
    - name: "run_type"
      expr: run_type_id
      comment: "Type of billing run (e.g. regular, ad-hoc, correction) for run classification and analysis."
    - name: "billing_date_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month of the billing run for trend and capacity analysis."
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether the run required approval before execution. Tracks governance overhead in billing operations."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category processed in the billing run for segment-level throughput analysis."
  measures:
    - name: "total_amount_billed"
      expr: SUM(CAST(total_amount_billed AS DOUBLE))
      comment: "Total amount billed across all billing runs. Primary billing throughput KPI for revenue operations."
    - name: "billing_run_count"
      expr: COUNT(1)
      comment: "Total number of billing runs executed. Operational volume metric for billing cycle management."
    - name: "avg_amount_billed_per_run"
      expr: AVG(CAST(total_amount_billed AS DOUBLE))
      comment: "Average amount billed per run. Tracks billing run productivity and identifies anomalous runs."
$$;