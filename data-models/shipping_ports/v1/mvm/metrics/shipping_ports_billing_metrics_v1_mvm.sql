-- Metric views for domain: billing | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over port billing invoices. Tracks invoice volumes, revenue totals, collection performance, discount leakage, and tax exposure — core metrics for port finance and revenue management steering."
  source: "`shipping_ports_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g. DRAFT, ISSUED, PAID, OVERDUE, CANCELLED) — primary filter for AR aging and collection dashboards."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the invoice — enables multi-currency revenue analysis and FX exposure reporting."
    - name: "service_type"
      expr: service_type
      comment: "Category of port service billed (e.g. PILOTAGE, WHARFAGE, STORAGE, TOWAGE) — drives revenue-mix and service-line profitability analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment recorded on the invoice (e.g. EFT, SWIFT, CHEQUE) — used to analyse payment channel preferences and reconciliation efficiency."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (e.g. NET30, NET60) — key dimension for DSO segmentation and credit risk management."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Calendar month of invoice issuance — standard time bucket for monthly revenue trend analysis."
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Calendar year of invoice issuance — used for year-over-year revenue comparisons."
    - name: "tax_exemption_flag"
      expr: tax_exemption_flag
      comment: "Boolean indicating whether the invoice is tax-exempt — used to segment taxable vs. exempt revenue for compliance reporting."
    - name: "tax_jurisdiction_code"
      expr: tax_jurisdiction_code
      comment: "Tax jurisdiction applicable to the invoice — required for statutory tax reporting and jurisdiction-level revenue allocation."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Calendar month the invoice payment is due — used for cash flow forecasting and overdue invoice tracking."
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross invoiced value across all invoices in scope. Primary top-line revenue KPI for port billing — used in board-level revenue reporting and budget vs. actuals tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged across invoices. Critical for statutory tax liability reporting and VAT/GST reconciliation with tax authorities."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across invoices. Tracks commercial discount leakage — a key lever for revenue optimisation and tariff compliance reviews."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total post-invoice adjustments (credits/debits) applied. Signals billing quality — high adjustment volumes indicate tariff errors or dispute-driven corrections."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-adjustment invoice subtotals. Used to isolate base revenue from tax and adjustment effects in revenue decomposition analysis."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Volume KPI used alongside revenue totals to compute average invoice value and track billing throughput."
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'PAID' THEN 1 END)
      comment: "Number of invoices with PAID status. Used to compute collection rate and monitor AR clearance velocity."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'OVERDUE' THEN 1 END)
      comment: "Number of invoices past their due date. A leading indicator of credit risk and collections pressure — triggers dunning and credit hold reviews."
    - name: "avg_invoice_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average gross value per invoice. Tracks revenue yield per billing event — declining averages may signal discount abuse or service mix shifts."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN invoice_status = 'PAID' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices that have been paid. Core AR health KPI — directly informs credit policy, customer risk scoring, and collections resourcing."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices with a recorded dispute reason. Measures billing quality and tariff accuracy — high rates trigger tariff review and process improvement initiatives."
    - name: "tax_exemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN tax_exemption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices flagged as tax-exempt. Used by tax compliance teams to validate exemption certificate coverage and identify potential tax leakage."
    - name: "avg_discount_per_invoice"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount granted per invoice. Benchmarks commercial discount discipline — used in tariff governance reviews to assess whether discounts are within approved thresholds."
    - name: "baf_revenue_total"
      expr: SUM(CAST(baf_amount AS DOUBLE))
      comment: "Total Bunker Adjustment Factor (BAF) surcharge revenue. Tracks fuel surcharge recovery — a key variable cost pass-through metric for shipping line billing."
    - name: "caf_revenue_total"
      expr: SUM(CAST(caf_amount AS DOUBLE))
      comment: "Total Currency Adjustment Factor (CAF) surcharge revenue. Monitors FX surcharge recovery — important for multi-currency port operations and hedging strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_charge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular KPI layer over individual charge events — the atomic billing unit in port operations. Enables service-level revenue analysis, hazmat/reefer surcharge tracking, dispute monitoring, and tariff yield management."
  source: "`shipping_ports_ecm`.`billing`.`charge_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of charge event (e.g. PORT_DUES, WHARFAGE, PILOTAGE, STORAGE, THC) — primary dimension for service-line revenue decomposition."
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the charge event (e.g. PENDING, INVOICED, DISPUTED, CANCELLED) — used to track billing pipeline and unbilled revenue."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the charge is denominated — required for multi-currency revenue reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the charge quantity (e.g. TEU, GRT, DAY, MOVE) — enables rate yield analysis per unit type."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Boolean indicating whether the charge relates to hazardous materials — used to track hazmat surcharge revenue and compliance exposure."
    - name: "reefer_flag"
      expr: reefer_flag
      comment: "Boolean indicating whether the charge relates to refrigerated cargo — tracks reefer premium revenue stream."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean indicating whether the charge event is under dispute — key quality signal for tariff accuracy and billing process health."
    - name: "exemption_flag"
      expr: exemption_flag
      comment: "Boolean indicating whether the charge is exempt from standard tariff — used to monitor exemption usage and revenue leakage."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Calendar month of the charge event — standard time bucket for monthly charge volume and revenue trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Originating operational system (e.g. NAVIS, SAP, TOS) — used for data lineage audits and system-level billing reconciliation."
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charge amount across all charge events. Primary revenue KPI at the transaction level — used to reconcile against invoice totals and identify unbilled charges."
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts and adjustments. Represents actual earned revenue at the charge level — the most accurate measure of port service revenue."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component across charge events. Used for tax liability reconciliation and statutory reporting at the transaction level."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at the charge event level. Measures tariff discount leakage — high values relative to gross charges signal commercial policy compliance issues."
    - name: "charge_event_count"
      expr: COUNT(1)
      comment: "Total number of charge events processed. Volume KPI for billing throughput — used alongside revenue totals to compute average charge value per event."
    - name: "disputed_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of charge events under dispute. Operational quality KPI — high dispute counts indicate tariff misapplication or service delivery issues requiring investigation."
    - name: "exempted_charge_count"
      expr: COUNT(CASE WHEN exemption_flag = TRUE THEN 1 END)
      comment: "Number of charge events where an exemption was applied. Tracks revenue foregone through exemptions — used in tariff governance and commercial policy reviews."
    - name: "hazmat_charge_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of hazardous materials charge events. Tracks hazmat cargo billing volume — used for safety compliance reporting and hazmat surcharge revenue analysis."
    - name: "reefer_charge_count"
      expr: COUNT(CASE WHEN reefer_flag = TRUE THEN 1 END)
      comment: "Number of reefer cargo charge events. Tracks cold-chain cargo billing volume — used to monitor reefer premium revenue and infrastructure utilisation."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate applied across charge events. Tariff yield KPI — declining averages signal rate erosion through discounts or tariff misapplication."
    - name: "avg_net_charge_amount"
      expr: AVG(CAST(net_charge_amount AS DOUBLE))
      comment: "Average net charge per event. Used to benchmark revenue yield per billing transaction and detect anomalies in charge processing."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charge events under dispute. Billing quality KPI — directly informs tariff accuracy improvement programmes and customer satisfaction initiatives."
    - name: "exemption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exemption_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charge events where an exemption was applied. Revenue leakage indicator — used by commercial teams to review exemption policy and recover foregone revenue."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight (kg) associated with charge events. Operational throughput KPI — used to correlate cargo volume with wharfage and handling revenue."
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume (CBM) associated with charge events. Volumetric throughput KPI — used for storage and handling revenue yield analysis."
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate AS DOUBLE))
      comment: "Average daily rate applied on time-based charges (e.g. storage, demurrage). Tracks rate yield on time-based services — used in demurrage and detention revenue optimisation."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over billing disputes. Tracks dispute volumes, financial exposure, resolution performance, SLA compliance, and escalation rates — critical for billing quality management and customer satisfaction governance."
  source: "`shipping_ports_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g. OPEN, UNDER_REVIEW, RESOLVED, ESCALATED, CLOSED) — primary filter for dispute pipeline management."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute (e.g. TARIFF_ERROR, DUPLICATE_CHARGE, SERVICE_NOT_RENDERED) — used to identify systemic billing issues and prioritise root cause remediation."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (e.g. CREDIT_ISSUED, CHARGE_UPHELD, PARTIAL_CREDIT) — used to measure dispute outcome mix and commercial concession rates."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which the dispute was escalated (e.g. L1, L2, MANAGEMENT) — tracks escalation frequency and severity distribution."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardised reason code for the dispute — enables Pareto analysis of dispute root causes to drive billing process improvements."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification of the dispute — used in quality improvement programmes to address systemic billing errors."
    - name: "disputed_currency_code"
      expr: disputed_currency_code
      comment: "Currency of the disputed amount — required for multi-currency dispute exposure reporting."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Boolean indicating whether the dispute resolution SLA was breached — key customer satisfaction and operational performance indicator."
    - name: "lodged_month"
      expr: DATE_TRUNC('MONTH', lodged_timestamp)
      comment: "Calendar month the dispute was lodged — used for dispute intake trend analysis and seasonal pattern detection."
    - name: "resolution_month"
      expr: DATE_TRUNC('MONTH', resolution_timestamp)
      comment: "Calendar month the dispute was resolved — used to track resolution throughput and backlog clearance rates."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value under dispute. Primary financial exposure KPI — used by CFO and revenue management to quantify billing risk and provision for credit notes."
    - name: "total_credit_amount_issued"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued as dispute resolutions. Measures actual revenue concession — used to track commercial exposure from billing errors and dispute settlements."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes lodged. Volume KPI for billing quality — used alongside invoice counts to compute dispute rate and benchmark against industry norms."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'OPEN' THEN 1 END)
      comment: "Number of currently open disputes. Operational backlog KPI — directly informs staffing and resolution capacity planning for the disputes team."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL THEN 1 END)
      comment: "Number of disputes that were escalated beyond first-line resolution. Quality and complexity indicator — high escalation rates signal systemic billing issues or inadequate first-line resolution capability."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes where the resolution SLA was breached. Customer satisfaction risk KPI — SLA breaches trigger contractual penalties and damage shipping line relationships."
    - name: "sla_breach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that breached the resolution SLA. Operational performance KPI — used in service level reviews with shipping lines and port authority governance reporting."
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_status IN ('RESOLVED', 'CLOSED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disputes that have been resolved or closed. Throughput efficiency KPI — used to monitor disputes team performance and backlog reduction progress."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average financial value per dispute. Used to assess dispute severity trends — rising averages indicate higher-value billing errors requiring tariff governance intervention."
    - name: "credit_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(disputed_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of credit issued to total disputed amount, expressed as a percentage. Measures commercial concession rate — used by revenue management to assess dispute settlement policy effectiveness."
    - name: "avg_customer_satisfaction_rating"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating recorded at dispute closure. Customer experience KPI — used to track the impact of billing disputes on shipping line relationships and port NPS."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over port billing payments. Tracks cash collection performance, payment method mix, reconciliation status, advance payment utilisation, and unapplied cash — essential for treasury and AR management."
  source: "`shipping_ports_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. RECEIVED, CLEARED, REVERSED, UNALLOCATED) — primary filter for cash collection and reconciliation dashboards."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to make the payment (e.g. EFT, SWIFT, CHEQUE, CASH) — used to analyse payment channel mix and associated processing costs."
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of the payment (e.g. FULL, PARTIAL, ADVANCE, REVERSAL) — used to segment payment behaviour and identify partial payment risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the payment was received — required for multi-currency cash collection reporting and FX reconciliation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Bank reconciliation status of the payment (e.g. RECONCILED, UNRECONCILED, PENDING) — used to track treasury reconciliation completeness and identify outstanding items."
    - name: "is_advance_payment"
      expr: is_advance_payment
      comment: "Boolean indicating whether the payment is an advance (pre-payment) — used to track advance payment utilisation and manage deferred revenue."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Calendar month of payment receipt — standard time bucket for monthly cash collection trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment — used for year-end cash collection reporting and budget vs. actuals analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment — used for period-level cash collection reporting aligned to the port's financial calendar."
  measures:
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash received across all payments. Primary cash collection KPI — used in treasury reporting, cash flow forecasting, and AR clearance tracking."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total payment amount allocated to invoices. Measures effective cash application — the difference between amount paid and allocated reveals unapplied cash requiring action."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet allocated to invoices. Unapplied cash KPI — high balances indicate cash application backlogs that distort AR aging and collection metrics."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Tracks the cost of early payment incentive programmes — used in working capital optimisation analysis."
    - name: "total_base_currency_amount"
      expr: SUM(CAST(base_currency_amount AS DOUBLE))
      comment: "Total payment value converted to base currency. Used for consolidated treasury reporting and FX gain/loss analysis across multi-currency payment portfolios."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received. Volume KPI for cash collection throughput — used alongside amount totals to compute average payment size."
    - name: "advance_payment_count"
      expr: COUNT(CASE WHEN is_advance_payment = TRUE THEN 1 END)
      comment: "Number of advance (pre-) payments received. Tracks pre-payment adoption — advance payments improve port cash flow and reduce credit risk exposure."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN reversal_reason IS NOT NULL THEN 1 END)
      comment: "Number of payments that were reversed. Payment quality KPI — high reversal counts indicate bank transfer errors, fraud risk, or customer disputes requiring investigation."
    - name: "reconciled_payment_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'RECONCILED' THEN 1 END)
      comment: "Number of payments successfully reconciled with bank statements. Treasury completeness KPI — unreconciled payments represent open items in the bank reconciliation process."
    - name: "reconciliation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'RECONCILED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that have been bank-reconciled. Treasury efficiency KPI — low rates indicate reconciliation backlogs that increase financial close risk."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount_paid AS DOUBLE))
      comment: "Average payment amount per transaction. Used to benchmark payment size trends and detect anomalies (e.g. unusually small partial payments indicating financial stress)."
    - name: "unapplied_cash_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(unapplied_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount_paid AS DOUBLE)), 0), 2)
      comment: "Percentage of total cash received that remains unapplied to invoices. Cash application efficiency KPI — high rates distort AR aging and delay invoice clearance."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across payments. Used by treasury to monitor FX rate trends and assess currency conversion costs on multi-currency collections."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_receivable_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over port receivable accounts (AR master). Tracks credit exposure, aging buckets, collection performance, credit hold status, and write-off risk — essential for credit risk management and AR governance."
  source: "`shipping_ports_ecm`.`billing`.`receivable_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the receivable account (e.g. ACTIVE, SUSPENDED, CLOSED, CREDIT_HOLD) — primary filter for AR portfolio health monitoring."
    - name: "account_classification"
      expr: account_classification
      comment: "Classification of the account (e.g. SHIPPING_LINE, FREIGHT_FORWARDER, HAULIER) — used for segment-level credit risk and revenue concentration analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account — used to segment AR portfolio by credit risk tier and inform credit limit setting."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Boolean indicating whether the account is on credit hold — used to monitor accounts blocked from further service and assess revenue at risk."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level of the account (e.g. REMINDER, FINAL_NOTICE, LEGAL) — tracks escalation stage in the collections process."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code assigned to the account (e.g. NET30, NET60) — used to segment AR aging expectations and DSO benchmarking."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred billing currency of the account — used for multi-currency AR portfolio analysis."
    - name: "billing_country"
      expr: billing_country
      comment: "Country of the account's billing address — used for geographic AR concentration and country-level credit risk analysis."
    - name: "statement_frequency"
      expr: statement_frequency
      comment: "Frequency at which statements are issued to the account (e.g. MONTHLY, WEEKLY) — used to align collection outreach with statement cycles."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all receivable accounts. Primary AR exposure KPI — used in board-level credit risk reporting and working capital management."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Used to assess aggregate credit exposure and compare against outstanding balances for utilisation analysis."
    - name: "total_aging_0_30_days"
      expr: SUM(CAST(aging_bucket_0_30_days AS DOUBLE))
      comment: "Total AR balance in the 0-30 day aging bucket. Current receivables KPI — used in cash flow forecasting and collection prioritisation."
    - name: "total_aging_31_60_days"
      expr: SUM(CAST(aging_bucket_31_60_days AS DOUBLE))
      comment: "Total AR balance in the 31-60 day aging bucket. Early overdue indicator — accounts in this bucket are prioritised for first-level dunning outreach."
    - name: "total_aging_61_90_days"
      expr: SUM(CAST(aging_bucket_61_90_days AS DOUBLE))
      comment: "Total AR balance in the 61-90 day aging bucket. Elevated credit risk indicator — balances here trigger escalated collections and potential credit hold reviews."
    - name: "total_aging_over_90_days"
      expr: SUM(CAST(aging_bucket_over_90_days AS DOUBLE))
      comment: "Total AR balance overdue by more than 90 days. Bad debt risk KPI — the primary input for doubtful debt provisioning and write-off decisions."
    - name: "total_write_off_amount_ytd"
      expr: SUM(CAST(write_off_amount_ytd AS DOUBLE))
      comment: "Total year-to-date write-off amount across accounts. Bad debt realisation KPI — used in P&L impact reporting and credit policy effectiveness reviews."
    - name: "account_count"
      expr: COUNT(1)
      comment: "Total number of receivable accounts. Portfolio size KPI — used to normalise other AR metrics (e.g. average outstanding balance per account)."
    - name: "credit_hold_account_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold. Revenue-at-risk indicator — accounts on hold cannot receive services, directly impacting port throughput and revenue."
    - name: "avg_days_to_pay"
      expr: AVG(CAST(average_days_to_pay AS DOUBLE))
      comment: "Average days to pay across receivable accounts. DSO proxy KPI — used to benchmark payment behaviour, set credit terms, and forecast cash collection timing."
    - name: "credit_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of total credit limit utilised by outstanding balances. Credit exposure concentration KPI — high utilisation signals elevated default risk and may trigger credit limit reviews."
    - name: "over_90_day_aging_pct"
      expr: ROUND(100.0 * SUM(CAST(aging_bucket_over_90_days AS DOUBLE)) / NULLIF(SUM(CAST(outstanding_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of total outstanding AR that is more than 90 days overdue. Bad debt concentration KPI — used to set doubtful debt provisions and trigger legal collections escalation."
    - name: "avg_outstanding_balance_per_account"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding AR balance per receivable account. Used to identify high-exposure accounts and benchmark against credit limits for individual account risk reviews."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average of the most recent payment amount across accounts. Payment behaviour KPI — declining averages may indicate customers making smaller partial payments, signalling financial stress."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_revenue_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over revenue recognition events. Tracks recognised vs. deferred revenue, recognition method mix, approval status, and revenue stream composition — critical for IFRS 15 / ASC 606 compliance and financial close accuracy."
  source: "`shipping_ports_ecm`.`billing`.`revenue_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current revenue recognition status (e.g. PENDING, RECOGNISED, DEFERRED, REVERSED) — primary filter for revenue recognition pipeline monitoring."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognise revenue (e.g. POINT_IN_TIME, OVER_TIME, MILESTONE) — used to analyse recognition method mix and assess IFRS 15 compliance."
    - name: "revenue_stream_category"
      expr: revenue_stream_category
      comment: "Category of the revenue stream (e.g. PORT_DUES, CARGO_HANDLING, STORAGE, PILOTAGE) — primary dimension for revenue mix and stream-level profitability analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the revenue event (e.g. PENDING, APPROVED, REJECTED) — used to track revenue pending approval and assess financial close readiness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue event — required for multi-currency revenue recognition reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the revenue event — used for year-end revenue recognition completeness checks and audit support."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the revenue event — used for period-close revenue reconciliation and GL posting validation."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Boolean indicating whether the revenue event has been reversed — used to identify and exclude reversed entries from recognised revenue totals."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Calendar month of revenue recognition — standard time bucket for monthly revenue recognition trend analysis and period-close reporting."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the revenue event (e.g. NAVIS, SAP, TOS) — used for data lineage audits and cross-system revenue reconciliation."
  measures:
    - name: "total_recognised_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognised in the period. Primary P&L revenue KPI — the definitive measure of earned revenue for financial reporting under IFRS 15 / ASC 606."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods. Balance sheet liability KPI — used to track deferred revenue obligations and forecast future recognition schedules."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to revenue events. Revenue quality KPI — high adjustment volumes indicate billing errors or contract modification impacts requiring investigation."
    - name: "revenue_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue events processed. Volume KPI for revenue recognition throughput — used to monitor period-close processing completeness."
    - name: "reversed_event_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of revenue events that have been reversed. Revenue quality indicator — high reversal counts signal billing errors or contract cancellations impacting recognised revenue."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of revenue events pending approval. Financial close readiness KPI — pending approvals at period-end delay revenue recognition and financial statement preparation."
    - name: "avg_recognised_revenue_per_event"
      expr: AVG(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Average recognised revenue per event. Revenue yield KPI — used to benchmark revenue per service transaction and detect anomalies in recognition amounts."
    - name: "deferred_to_recognised_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(recognized_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of deferred revenue to recognised revenue, expressed as a percentage. Revenue timing KPI — high ratios indicate significant future revenue obligations and impact cash flow forecasting."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of revenue events that have been reversed. Revenue integrity KPI — used in audit reviews and billing quality programmes to assess the accuracy of initial revenue recognition."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate applied across revenue events. Tariff yield KPI — used to monitor effective rate trends and assess whether contracted rates are being correctly applied."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over billing adjustments (credit notes and reversals). Tracks credit note volumes, financial impact, approval compliance, and reversal rates — used to govern billing accuracy and manage revenue leakage from post-invoice corrections."
  source: "`shipping_ports_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "credit_note_status"
      expr: credit_note_status
      comment: "Current status of the credit note (e.g. DRAFT, APPROVED, ISSUED, REVERSED) — primary filter for adjustment pipeline management."
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Standardised reason code for the credit adjustment — used for Pareto analysis of credit note root causes and billing error classification."
    - name: "service_type"
      expr: service_type
      comment: "Port service type to which the adjustment relates — used to identify which service lines generate the most credit note activity."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment — required for multi-currency credit note exposure reporting."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Boolean indicating whether the adjustment is a reversal of a prior credit note — used to net out reversal activity from gross credit note volumes."
    - name: "customer_notification_sent"
      expr: customer_notification_sent
      comment: "Boolean indicating whether the customer was notified of the adjustment — used to track notification compliance and customer communication SLAs."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the adjustment — used for year-end credit note impact reporting and audit support."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the adjustment — used for period-level credit note reconciliation and GL posting validation."
    - name: "applied_month"
      expr: DATE_TRUNC('MONTH', applied_date)
      comment: "Calendar month the adjustment was applied — used for monthly credit note trend analysis and revenue impact tracking."
    - name: "approval_authority"
      expr: approval_authority
      comment: "Authority that approved the adjustment — used to monitor approval delegation compliance and identify high-value adjustments requiring senior sign-off."
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total base credit amount across all adjustments. Primary revenue leakage KPI — used to quantify the financial impact of billing errors and commercial concessions."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax component of credit adjustments. Used for tax liability reconciliation — tax credits must be reported to tax authorities and offset against tax payable."
    - name: "total_credit_amount_gross"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total gross credit amount (base + tax) across all adjustments. Comprehensive revenue leakage KPI — the full financial impact of post-invoice corrections on port revenue."
    - name: "total_original_charge_amount"
      expr: SUM(CAST(original_charge_amount AS DOUBLE))
      comment: "Total original charge amount that was subject to adjustment. Used to compute credit note rate — the ratio of credits to original charges measures billing accuracy."
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Total number of billing adjustments issued. Volume KPI for billing quality — used alongside invoice counts to compute adjustment rate and benchmark billing accuracy."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of adjustments that are reversals of prior credit notes. Used to identify double-correction activity and assess the stability of the adjustment process."
    - name: "notification_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notification_sent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of adjustments where the customer was notified. Customer communication compliance KPI — failure to notify customers of credits can damage relationships and trigger disputes."
    - name: "credit_to_original_charge_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(original_charge_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of credit amount to original charge amount, expressed as a percentage. Billing accuracy KPI — high rates indicate systemic overcharging or tariff misapplication requiring process improvement."
    - name: "avg_credit_amount"
      expr: AVG(CAST(total_credit_amount AS DOUBLE))
      comment: "Average gross credit amount per adjustment. Used to assess adjustment severity trends — rising averages indicate higher-value billing errors requiring escalated governance attention."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over billing cycles. Tracks cycle-level revenue totals, discount and tax amounts, invoice generation performance, and late fee applicability — used to govern billing cycle execution and period-close completeness."
  source: "`shipping_ports_ecm`.`billing`.`cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the billing cycle (e.g. OPEN, CLOSED, CANCELLED, IN_PROGRESS) — primary filter for cycle pipeline management and period-close monitoring."
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of billing cycle (e.g. MONTHLY, WEEKLY, AD_HOC, ADJUSTMENT) — used to segment cycle performance by billing frequency and type."
    - name: "service_category"
      expr: service_category
      comment: "Service category covered by the billing cycle (e.g. VESSEL_SERVICES, CARGO_HANDLING, STORAGE) — used for service-line revenue analysis at the cycle level."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing cycle — required for multi-currency cycle revenue reporting."
    - name: "is_adjustment_cycle"
      expr: is_adjustment_cycle
      comment: "Boolean indicating whether the cycle is an adjustment cycle — used to separate regular billing cycles from correction cycles in revenue analysis."
    - name: "late_fee_applicable_flag"
      expr: late_fee_applicable_flag
      comment: "Boolean indicating whether late fees apply to this cycle — used to track late fee revenue potential and monitor payment terms compliance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the billing cycle — used for year-end revenue completeness checks and budget vs. actuals analysis."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the billing cycle — used for quarterly revenue trend analysis and QBR reporting."
    - name: "cycle_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Calendar month the billing cycle started — used for monthly cycle volume and revenue trend analysis."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total gross billed amount across all billing cycles. Top-line revenue KPI at the cycle level — used to track billing throughput and compare against budget targets."
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net billed amount (after discounts) across cycles. Net revenue KPI — used to assess the impact of discounts on cycle-level revenue and monitor discount policy compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discount granted across billing cycles. Discount leakage KPI — used to monitor commercial discount discipline and assess the revenue impact of pricing concessions."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax charged across billing cycles. Tax liability KPI — used for statutory tax reporting and period-level tax reconciliation."
    - name: "cycle_count"
      expr: COUNT(1)
      comment: "Total number of billing cycles. Volume KPI for billing operations — used to monitor cycle execution throughput and identify periods with unusually high or low cycle activity."
    - name: "closed_cycle_count"
      expr: COUNT(CASE WHEN cycle_status = 'CLOSED' THEN 1 END)
      comment: "Number of billing cycles that have been closed. Period-close completeness KPI — open cycles at period-end delay revenue recognition and financial reporting."
    - name: "adjustment_cycle_count"
      expr: COUNT(CASE WHEN is_adjustment_cycle = TRUE THEN 1 END)
      comment: "Number of adjustment billing cycles. Billing quality indicator — high adjustment cycle counts signal systemic billing errors requiring process improvement."
    - name: "late_fee_applicable_cycle_count"
      expr: COUNT(CASE WHEN late_fee_applicable_flag = TRUE THEN 1 END)
      comment: "Number of cycles where late fees are applicable. Revenue opportunity KPI — used to track late fee revenue potential and monitor payment terms compliance across the customer portfolio."
    - name: "avg_billed_amount_per_cycle"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average gross billed amount per billing cycle. Cycle yield KPI — used to benchmark billing productivity and detect cycles with anomalously low revenue that may indicate processing issues."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_billed_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of gross billed amount across cycles. Commercial discipline KPI — used in tariff governance reviews to assess whether discount levels are within approved thresholds."
    - name: "avg_late_fee_percentage"
      expr: AVG(CAST(late_fee_percentage AS DOUBLE))
      comment: "Average late fee percentage applied across cycles where late fees are applicable. Used to monitor late fee rate consistency and ensure compliance with contractual payment terms."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over payment allocations. Tracks cash application completeness, allocation type mix, outstanding balances, withholding tax deductions, and reversal activity — used to govern AR cash application quality and financial close accuracy."
  source: "`shipping_ports_ecm`.`billing`.`payment_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the payment allocation (e.g. ALLOCATED, REVERSED, PENDING, PARTIAL) — primary filter for cash application pipeline monitoring."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (e.g. FULL, PARTIAL, ADVANCE, WRITE_OFF) — used to analyse cash application method mix and identify partial payment patterns."
    - name: "allocation_source"
      expr: allocation_source
      comment: "Source of the allocation (e.g. MANUAL, AUTO_MATCH, REMITTANCE) — used to assess automation rates in cash application and identify manual processing bottlenecks."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation — required for multi-currency cash application reporting."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Boolean indicating whether the allocation is associated with a disputed invoice — used to track disputed cash and its impact on AR clearance."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation — used for year-end cash application completeness checks."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of the allocation — used for period-close cash application reconciliation."
    - name: "allocation_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Calendar month of the allocation — standard time bucket for monthly cash application trend analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated across all payment allocations. Primary cash application KPI — measures the volume of cash successfully matched to invoices in the AR ledger."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance remaining after allocations. Residual AR KPI — used to identify uncleared invoice balances and prioritise collection follow-up."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken at the allocation level. Tracks the cost of early payment incentive programmes at the transaction level."
    - name: "total_withholding_tax_deducted"
      expr: SUM(CAST(withholding_tax_deducted AS DOUBLE))
      comment: "Total withholding tax deducted from payments at allocation. Tax compliance KPI — withholding tax deductions must be tracked for statutory reporting and tax credit claims."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total allocation value in local currency. Used for domestic financial reporting and local currency AR reconciliation."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of payment allocations processed. Cash application throughput KPI — used to monitor AR team productivity and period-close processing volumes."
    - name: "disputed_allocation_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of allocations associated with disputed invoices. Disputed cash KPI — allocations on disputed invoices may need to be reversed if the dispute is upheld, creating AR risk."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_reason IS NOT NULL THEN 1 END)
      comment: "Number of payment allocations that have been reversed. Cash application quality KPI — high reversal counts indicate matching errors or payment reversals requiring rework."
    - name: "avg_allocated_amount"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average amount per payment allocation. Used to benchmark allocation transaction size and detect anomalies in cash application patterns."
    - name: "outstanding_balance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(allocated_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of outstanding balance to allocated amount, expressed as a percentage. Cash application completeness KPI — high ratios indicate significant residual balances remaining after allocation, signalling partial payment issues."
$$;