-- Metric views for domain: invoice | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core accounts-receivable invoice metrics covering billed revenue, discount leakage, tax exposure, and invoice lifecycle status — primary steering KPIs for the AR and Finance functions."
  source: "`vibe_semiconductors_v1`.`invoice`.`ar_invoice`"
  dimensions:
    - name: "invoice_currency"
      expr: currency_code
      comment: "Currency in which the invoice was issued; used to slice revenue by billing currency."
    - name: "invoice_status"
      expr: ar_invoice_status
      comment: "Current lifecycle status of the invoice (e.g. Draft, Posted, Paid, Cancelled)."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment collection status (e.g. Open, Partial, Paid, Overdue)."
    - name: "document_type"
      expr: document_type
      comment: "Type of billing document (Standard Invoice, Credit Memo, Proforma, etc.)."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice issuance; enables monthly revenue trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due; used to bucket aging and cash-flow forecasting."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flag indicating whether the document is a credit memo rather than a standard invoice."
    - name: "export_control_flag"
      expr: export_control_flag
      comment: "Flag indicating the invoice involves export-controlled goods requiring license tracking."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (Wire, ACH, Check, etc.) for cash-application analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Collections workflow status (e.g. Current, Dunning, Legal) for AR aging management."
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued; baseline volume KPI for billing throughput."
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross invoice amounts before discounts and tax; top-line billed revenue indicator."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net invoice amounts after discounts; recognized revenue base for AR."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across all invoices; critical for tax liability reporting and compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted across invoices; measures pricing leakage and discount discipline."
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount AS DOUBLE))
      comment: "Total early-payment discounts offered; quantifies cost of accelerating cash collection."
    - name: "total_late_fee_amount"
      expr: SUM(CAST(late_fee_amount AS DOUBLE))
      comment: "Total late fees assessed; indicator of customer payment discipline and collections effectiveness."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value; used to benchmark deal size and detect anomalous billing events."
    - name: "distinct_billed_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts billed; measures billing reach and customer activity."
    - name: "credit_memo_count"
      expr: COUNT(CASE WHEN is_credit_memo = TRUE THEN 1 END)
      comment: "Number of credit memos issued; elevated count signals billing errors or customer disputes."
    - name: "credit_memo_gross_amount"
      expr: SUM(CASE WHEN is_credit_memo = TRUE THEN gross_amount ELSE 0 END)
      comment: "Total gross value of credit memos; measures revenue reversal exposure."
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN payment_status = 'Overdue' THEN 1 END)
      comment: "Number of invoices past due date; key AR aging and collections risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level invoice metrics enabling revenue analysis by product, charge type, sales channel, and region — essential for product revenue mix and margin management."
  source: "`vibe_semiconductors_v1`.`invoice`.`invoice_line`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge on the line (Product, NRE, Royalty, Service, etc.) for revenue category analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel (Direct, Distributor, Online) for channel revenue mix analysis."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional revenue performance tracking."
    - name: "revenue_recognition_category"
      expr: revenue_recognition_category
      comment: "ASC 606 revenue recognition category for compliance and financial reporting."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the invoice line (Active, Cancelled, Disputed, etc.)."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for the line item; used in multi-currency revenue analysis."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the billing period start; enables period-over-period revenue comparison."
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag indicating whether the line is tax-exempt; used for tax exposure analysis."
    - name: "is_discount_applied"
      expr: is_discount_applied
      comment: "Flag indicating a discount was applied to this line; used to measure discount frequency."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the billed quantity (Units, Wafers, Dies, etc.)."
  measures:
    - name: "total_line_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount across all invoice lines; top-line product revenue."
    - name: "total_line_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after discounts; recognized revenue at line level."
    - name: "total_line_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level; used for tax liability and compliance reporting."
    - name: "total_line_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at line level; measures pricing discipline and leakage."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units/wafers/dies billed; volume KPI for production and shipment reconciliation."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit selling price across invoice lines; tracks ASP trends critical to margin management."
    - name: "total_royalty_bearing_lines"
      expr: COUNT(CASE WHEN royalty_rate_percent > 0 THEN 1 END)
      comment: "Number of lines with royalty obligations; used to monitor IP licensing revenue exposure."
    - name: "total_royalty_implied_amount"
      expr: SUM(CASE WHEN CAST(royalty_rate_percent AS DOUBLE) > 0 THEN CAST(net_amount AS DOUBLE) * CAST(royalty_rate_percent AS DOUBLE) / 100.0 ELSE 0 END)
      comment: "Implied royalty obligation amount derived from line net amount and royalty rate; tracks IP cost exposure."
    - name: "distinct_skus_billed"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs billed; measures product breadth in revenue mix."
    - name: "discounted_line_count"
      expr: COUNT(CASE WHEN is_discount_applied = TRUE THEN 1 END)
      comment: "Number of lines where a discount was applied; measures discount frequency for pricing governance."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_payment_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash collection metrics covering payment volumes, methods, partial payments, and overpayments — core KPIs for treasury, AR, and cash-flow management."
  source: "`vibe_semiconductors_v1`.`invoice`.`payment_receipt`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (Wire, ACH, Check, Card) for cash-application channel analysis."
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment receipt (Applied, Unapplied, Reversed, On-Account)."
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (Standard, Advance, Partial, Overpayment) for cash-flow categorization."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which payment was received (Bank Transfer, Portal, Manual) for process efficiency analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment receipt for multi-currency cash management."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt; enables monthly cash collection trend analysis."
    - name: "is_partial_payment"
      expr: is_partial_payment
      comment: "Flag indicating a partial payment was received; used to track incomplete collections."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating the payment was reversed; used to monitor payment reversal rates."
    - name: "compliance_check_status"
      expr: compliance_check_status
      comment: "Status of compliance screening on the payment (Passed, Failed, Pending) for AML/sanctions monitoring."
  measures:
    - name: "total_payments_received"
      expr: COUNT(1)
      comment: "Total number of payment receipts processed; baseline cash collection volume KPI."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash collected; primary treasury KPI for cash-flow management."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount_total AS DOUBLE))
      comment: "Total amount allocated to invoices; measures AR clearance effectiveness."
    - name: "total_residual_open_amount"
      expr: SUM(CAST(residual_open_amount AS DOUBLE))
      comment: "Total unallocated residual amount remaining after payment application; indicates unapplied cash risk."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early-payment discounts taken by customers; measures cost of accelerated cash collection."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected through payments; used for tax remittance reconciliation."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount_received AS DOUBLE))
      comment: "Average payment receipt amount; benchmarks typical payment size for anomaly detection."
    - name: "partial_payment_count"
      expr: COUNT(CASE WHEN is_partial_payment = TRUE THEN 1 END)
      comment: "Number of partial payments received; elevated count signals customer liquidity stress."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of payment reversals; high reversal rate indicates fraud risk or processing errors."
    - name: "total_functional_currency_amount"
      expr: SUM(CAST(functional_currency_amount AS DOUBLE))
      comment: "Total payments converted to functional currency; used for consolidated cash reporting."
    - name: "distinct_paying_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts that made payments; measures active paying customer base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute metrics tracking disputed amounts, resolution rates, and aging — critical KPIs for AR quality, customer satisfaction, and revenue risk management."
  source: "`vibe_semiconductors_v1`.`invoice`.`dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Category of dispute (Pricing, Quantity, Quality, Duplicate) for root-cause analysis."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (Open, In Review, Resolved, Escalated)."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Outcome of dispute resolution (Accepted, Rejected, Partial Settlement)."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification of the dispute; used to drive systemic billing quality improvements."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier of the dispute (L1, L2, Legal); used to prioritize collections resources."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the dispute for workload management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for multi-currency exposure analysis."
    - name: "dispute_date_month"
      expr: DATE_TRUNC('MONTH', dispute_date)
      comment: "Month the dispute was raised; enables trend analysis of dispute frequency."
    - name: "channel"
      expr: channel
      comment: "Channel through which the dispute was raised (Portal, Email, Phone) for process improvement."
  measures:
    - name: "total_disputes"
      expr: COUNT(1)
      comment: "Total number of disputes raised; baseline KPI for billing quality and AR risk."
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of amounts under dispute; measures revenue at risk from billing disagreements."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled in dispute resolution; measures concession cost and resolution effectiveness."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute; benchmarks typical dispute size for prioritization."
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN dispute_status = 'Open' THEN 1 END)
      comment: "Number of currently open disputes; key AR risk exposure indicator for collections teams."
    - name: "open_disputed_amount"
      expr: SUM(CASE WHEN dispute_status = 'Open' THEN disputed_amount ELSE 0 END)
      comment: "Total value of open disputes; measures current revenue at risk requiring resolution."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL AND escalation_level != '' THEN 1 END)
      comment: "Number of disputes escalated beyond first-line resolution; indicates systemic billing issues."
    - name: "resolved_dispute_count"
      expr: COUNT(CASE WHEN resolution_status = 'Resolved' OR dispute_status = 'Resolved' THEN 1 END)
      comment: "Number of disputes successfully resolved; measures collections team effectiveness."
    - name: "distinct_disputing_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts with active or historical disputes; identifies high-dispute customer segments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_credit_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit hold metrics tracking hold volumes, amounts, and risk exposure — essential KPIs for credit risk management, order fulfillment impact, and collections strategy."
  source: "`vibe_semiconductors_v1`.`invoice`.`credit_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the credit hold (Active, Released, Expired)."
    - name: "hold_category"
      expr: hold_category
      comment: "Category of the hold (Overdue Balance, Credit Limit Exceeded, Risk Score) for root-cause analysis."
    - name: "hold_reason_code"
      expr: hold_reason_code
      comment: "Reason code for the credit hold; used to classify and trend hold causes."
    - name: "block_level"
      expr: block_level
      comment: "Level at which the hold blocks transactions (Order, Shipment, Invoice) for impact assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the hold amounts for multi-currency credit risk reporting."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the credit hold is currently active; used to filter live risk exposure."
    - name: "hold_start_month"
      expr: DATE_TRUNC('MONTH', hold_start_date)
      comment: "Month the hold was placed; enables trend analysis of credit hold frequency."
  measures:
    - name: "total_credit_holds"
      expr: COUNT(1)
      comment: "Total number of credit holds placed; baseline KPI for credit risk event frequency."
    - name: "active_credit_hold_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active credit holds; measures live order fulfillment blockage."
    - name: "total_hold_amount"
      expr: SUM(CAST(hold_amount AS DOUBLE))
      comment: "Total value of amounts blocked by credit holds; measures revenue at risk from credit constraints."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue balance driving credit holds; primary collections risk KPI."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average credit risk score across held accounts; used to benchmark portfolio credit quality."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across all hold records; measures aggregate credit exposure under management."
    - name: "distinct_accounts_on_hold"
      expr: COUNT(DISTINCT credit_account_id)
      comment: "Number of unique customer accounts currently or historically on credit hold; measures breadth of credit risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_customer_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit limit metrics covering utilization, availability, and risk classification — strategic KPIs for credit policy management and financial risk governance."
  source: "`vibe_semiconductors_v1`.`invoice`.`customer_credit_limit`"
  dimensions:
    - name: "credit_limit_status"
      expr: credit_limit_status
      comment: "Status of the credit limit record (Active, Suspended, Expired)."
    - name: "credit_limit_type"
      expr: credit_limit_type
      comment: "Type of credit limit (Standard, Secured, Insured) for credit policy segmentation."
    - name: "credit_risk_classification"
      expr: credit_risk_classification
      comment: "Risk tier assigned to the customer (Low, Medium, High) for portfolio risk management."
    - name: "credit_rating"
      expr: credit_rating
      comment: "External or internal credit rating of the customer; used for credit policy benchmarking."
    - name: "credit_currency"
      expr: credit_currency
      comment: "Currency of the credit limit for multi-currency credit exposure reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the customer for regional credit risk analysis."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating the account is currently on credit hold; used to filter at-risk accounts."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the credit limit record is currently active."
    - name: "credit_review_month"
      expr: DATE_TRUNC('MONTH', credit_review_date)
      comment: "Month of the last credit review; used to identify accounts overdue for review."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit extended to all customers; measures aggregate credit exposure for risk governance."
    - name: "total_credit_used_amount"
      expr: SUM(CAST(credit_used_amount AS DOUBLE))
      comment: "Total credit currently utilized by customers; measures active credit draw-down."
    - name: "total_credit_available_amount"
      expr: SUM(CAST(credit_available_amount AS DOUBLE))
      comment: "Total unused credit capacity; measures headroom for additional orders without credit risk."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue balance across all credit limit records; primary collections risk indicator."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across customers; high utilization signals elevated default risk."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold; measures breadth of credit risk events."
    - name: "high_utilization_account_count"
      expr: COUNT(CASE WHEN credit_utilization_pct >= 80 THEN 1 END)
      comment: "Number of accounts with credit utilization at or above 80%; early warning indicator for credit risk escalation."
    - name: "distinct_active_credit_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with active credit limits; measures credit program reach."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_royalty_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP royalty billing metrics covering royalty revenue, rates, and collection status — strategic KPIs for IP monetization, licensing compliance, and royalty program management."
  source: "`vibe_semiconductors_v1`.`invoice`.`royalty_billing`"
  dimensions:
    - name: "royalty_type"
      expr: royalty_type
      comment: "Type of royalty (Per-Unit, Revenue-Share, Flat-Fee) for IP revenue mix analysis."
    - name: "royalty_billing_status"
      expr: royalty_billing_status
      comment: "Current billing status (Draft, Invoiced, Paid, Disputed) for royalty collection tracking."
    - name: "royalty_calculation_method"
      expr: royalty_calculation_method
      comment: "Method used to calculate royalties (Unit-Based, Revenue-Based, Tiered) for audit and compliance."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing workflow status for the royalty record."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the royalty billing for regional IP revenue analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the royalty billing for multi-currency IP revenue reporting."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month of the royalty billing period; enables period-over-period IP revenue trend analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating the royalty billing is under dispute; used to quantify disputed IP revenue."
    - name: "tier_level"
      expr: tier_level
      comment: "Royalty tier level for tiered licensing agreements; used to analyze tier distribution."
  measures:
    - name: "total_royalty_billings"
      expr: COUNT(1)
      comment: "Total number of royalty billing records; baseline volume KPI for IP licensing activity."
    - name: "total_royalty_amount_gross"
      expr: SUM(CAST(royalty_amount_gross AS DOUBLE))
      comment: "Total gross royalty revenue billed; primary IP monetization KPI for executive reporting."
    - name: "total_royalty_amount_net"
      expr: SUM(CAST(royalty_amount_net AS DOUBLE))
      comment: "Total net royalty revenue after adjustments; recognized IP revenue for financial reporting."
    - name: "total_royalty_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to royalty billings; measures billing correction magnitude."
    - name: "total_units_shipped"
      expr: SUM(CAST(units_shipped AS DOUBLE))
      comment: "Total units shipped subject to royalty; volume driver for per-unit royalty revenue."
    - name: "avg_per_unit_royalty"
      expr: AVG(CAST(per_unit_royalty_usd AS DOUBLE))
      comment: "Average per-unit royalty rate in USD; benchmarks IP pricing across licensing agreements."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate percentage across all billings; used to monitor rate compliance and trends."
    - name: "disputed_royalty_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of royalty billings under dispute; measures IP licensing compliance risk."
    - name: "disputed_royalty_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN royalty_amount_gross ELSE 0 END)
      comment: "Total gross royalty amount under dispute; quantifies IP revenue at risk from licensing disagreements."
    - name: "total_tax_on_royalties"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax assessed on royalty billings; used for tax compliance and withholding reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 revenue recognition metrics tracking recognized amounts, deferrals, and event types — critical KPIs for financial close, audit compliance, and revenue quality management."
  source: "`vibe_semiconductors_v1`.`invoice`.`revenue_recognition_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of revenue recognition event (Point-in-Time, Over-Time, Milestone) for ASC 606 classification."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the recognition event (Pending, Recognized, Reversed, Deferred)."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category (Product, NRE, Royalty, Service) for revenue mix analysis."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for recognition (Straight-Line, Percentage-of-Completion, etc.) for audit traceability."
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period in which the event is recognized; used for period-close reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition event for multi-currency revenue reporting."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating the recognition event was reversed; used to monitor revenue reversal frequency."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month of revenue recognition; enables monthly recognized revenue trend analysis."
  measures:
    - name: "total_recognition_events"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events; baseline volume KPI for recognition activity."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period; primary financial reporting KPI for top-line revenue."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods; measures unearned revenue liability on the balance sheet."
    - name: "total_revenue_amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total revenue amount associated with recognition events; used for revenue completeness checks."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue; used for gross margin calculation."
    - name: "total_profit_amount"
      expr: SUM(CAST(profit_amount AS DOUBLE))
      comment: "Total profit from recognized revenue events; measures gross profitability of recognized revenue."
    - name: "total_tax_on_recognized_revenue"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax associated with recognized revenue events; used for tax provision reconciliation."
    - name: "reversal_event_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of reversed recognition events; elevated count signals revenue quality or audit issues."
    - name: "avg_recognized_amount_per_event"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized revenue per event; benchmarks recognition event size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_performance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ASC 606 performance obligation metrics tracking satisfaction status, allocated amounts, and recognition progress — essential KPIs for contract revenue management and audit compliance."
  source: "`vibe_semiconductors_v1`.`invoice`.`performance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of performance obligation (Product Delivery, NRE Service, License, Support) for revenue classification."
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the obligation (Open, Partially Satisfied, Fully Satisfied, Cancelled)."
    - name: "revenue_recognition_method"
      expr: revenue_recognition_method
      comment: "ASC 606 recognition method applied (Point-in-Time, Over-Time) for compliance reporting."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the obligation (Monthly, Quarterly, Milestone) for cash-flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the performance obligation for multi-currency contract management."
    - name: "is_satisfied"
      expr: is_satisfied
      comment: "Flag indicating the obligation has been fully satisfied; used to track completion rates."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the obligation became effective; used for cohort analysis of contract obligations."
  measures:
    - name: "total_performance_obligations"
      expr: COUNT(1)
      comment: "Total number of performance obligations; baseline KPI for contract complexity and revenue pipeline."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations; measures contracted revenue backlog."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total amount recognized from performance obligations; measures revenue earned against contracts."
    - name: "total_standalone_selling_price"
      expr: SUM(CAST(standalone_selling_price AS DOUBLE))
      comment: "Total standalone selling price across obligations; used for SSP allocation compliance under ASC 606."
    - name: "total_tax_on_obligations"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax associated with performance obligations; used for tax provision and compliance reporting."
    - name: "satisfied_obligation_count"
      expr: COUNT(CASE WHEN is_satisfied = TRUE THEN 1 END)
      comment: "Number of fully satisfied obligations; measures contract fulfillment rate."
    - name: "unsatisfied_obligation_count"
      expr: COUNT(CASE WHEN is_satisfied = FALSE OR is_satisfied IS NULL THEN 1 END)
      comment: "Number of unsatisfied obligations; measures remaining revenue delivery commitments."
    - name: "avg_allocated_amount_per_obligation"
      expr: AVG(CAST(allocated_amount AS DOUBLE))
      comment: "Average allocated amount per performance obligation; benchmarks contract value distribution."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections dunning metrics tracking overdue amounts, dunning levels, and escalation — operational KPIs for collections effectiveness and bad-debt risk management."
  source: "`vibe_semiconductors_v1`.`invoice`.`dunning_notice`"
  dimensions:
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level (1st Notice, 2nd Notice, Final, Legal) for collections intensity analysis."
    - name: "dunning_notice_status"
      expr: dunning_notice_status
      comment: "Current status of the dunning notice (Sent, Responded, Ignored, Escalated)."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the dunning notice (Email, Post, Portal) for channel effectiveness analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the overdue amount for multi-currency collections reporting."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating a credit hold was placed in conjunction with the dunning notice."
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Flag indicating the account has been escalated to legal collections."
    - name: "notice_month"
      expr: DATE_TRUNC('MONTH', notice_date)
      comment: "Month the dunning notice was issued; enables trend analysis of collections activity."
    - name: "escalation_threshold_exceeded"
      expr: escalation_threshold_exceeded
      comment: "Flag indicating the overdue amount exceeded the escalation threshold."
  measures:
    - name: "total_dunning_notices"
      expr: COUNT(1)
      comment: "Total dunning notices issued; baseline KPI for collections activity volume."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue balance subject to dunning; primary collections risk KPI."
    - name: "total_due_amount"
      expr: SUM(CAST(total_due AS DOUBLE))
      comment: "Total amount due including principal, interest, and dunning charges; measures full collections exposure."
    - name: "total_dunning_charges"
      expr: SUM(CAST(dunning_charge AS DOUBLE))
      comment: "Total dunning fees assessed; measures revenue from late-payment penalties."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest accrued on overdue balances; measures cost of customer late payment."
    - name: "legal_escalation_count"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts escalated to legal collections; measures severity of collections portfolio."
    - name: "avg_overdue_amount_per_notice"
      expr: AVG(CAST(overdue_amount AS DOUBLE))
      comment: "Average overdue amount per dunning notice; benchmarks typical collections case size."
    - name: "distinct_accounts_in_dunning"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique accounts receiving dunning notices; measures breadth of collections risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad-debt write-off metrics tracking write-off volumes, amounts, and recovery — critical KPIs for credit loss management, provisioning accuracy, and collections ROI."
  source: "`vibe_semiconductors_v1`.`invoice`.`write_off`"
  dimensions:
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (Bad Debt, Contractual, Operational) for loss categorization."
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of the write-off for financial reporting and provisioning analysis."
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write-off (Pending Approval, Approved, Reversed)."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write-off; used to identify systemic causes of bad debt."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery efforts on written-off amounts (Not Attempted, In Progress, Recovered)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write-off for multi-currency bad-debt reporting."
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating the write-off has been approved; used to separate approved from pending write-offs."
    - name: "is_reversed"
      expr: is_reversed
      comment: "Flag indicating the write-off was subsequently reversed; used to monitor reversal rates."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month the write-off was recorded; enables trend analysis of bad-debt losses."
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Flag indicating recovery was attempted on the written-off amount."
  measures:
    - name: "total_write_offs"
      expr: COUNT(1)
      comment: "Total number of write-off records; baseline KPI for bad-debt event frequency."
    - name: "total_write_off_amount_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross amount written off; primary bad-debt loss KPI for credit risk management."
    - name: "total_write_off_amount_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net write-off amount after adjustments; used for P&L bad-debt expense reporting."
    - name: "total_write_off_adjustment"
      expr: SUM(CAST(amount_adjustment AS DOUBLE))
      comment: "Total adjustments applied to write-offs; measures correction magnitude in bad-debt accounting."
    - name: "total_tax_effect_amount"
      expr: SUM(CAST(tax_effect_amount AS DOUBLE))
      comment: "Total tax effect of write-offs; used for tax provision and deferred tax asset calculations."
    - name: "approved_write_off_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of approved write-offs; measures finalized bad-debt losses."
    - name: "reversed_write_off_count"
      expr: COUNT(CASE WHEN is_reversed = TRUE THEN 1 END)
      comment: "Number of reversed write-offs; measures recovery of previously written-off amounts."
    - name: "recovery_attempted_count"
      expr: COUNT(CASE WHEN recovery_flag = TRUE THEN 1 END)
      comment: "Number of write-offs where recovery was attempted; measures collections follow-through on bad debt."
    - name: "distinct_accounts_written_off"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with write-offs; measures breadth of bad-debt exposure."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_adjustment_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice adjustment memo metrics tracking credit/debit adjustments, approval rates, and settlement — KPIs for billing accuracy, revenue integrity, and adjustment governance."
  source: "`vibe_semiconductors_v1`.`invoice`.`adjustment_memo`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment (Credit, Debit, Rebate, Correction) for adjustment category analysis."
    - name: "adjustment_subtype"
      expr: adjustment_subtype
      comment: "Sub-type of the adjustment for granular billing correction analysis."
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Business category of the adjustment for root-cause and trend analysis."
    - name: "adjustment_memo_status"
      expr: adjustment_memo_status
      comment: "Current lifecycle status of the adjustment memo."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the adjustment memo (Pending, Approved, Rejected)."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the adjustment (Unsettled, Partially Settled, Fully Settled)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the adjustment for multi-currency billing correction reporting."
    - name: "is_approved"
      expr: is_approved
      comment: "Flag indicating the adjustment memo has been approved."
    - name: "is_tax_included"
      expr: is_tax_included
      comment: "Flag indicating tax is included in the adjustment amount."
    - name: "memo_date_month"
      expr: DATE_TRUNC('MONTH', memo_date)
      comment: "Month the adjustment memo was issued; enables trend analysis of billing corrections."
  measures:
    - name: "total_adjustment_memos"
      expr: COUNT(1)
      comment: "Total number of adjustment memos issued; baseline KPI for billing correction frequency."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total value of adjustments issued; measures magnitude of billing corrections and revenue impact."
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total approved adjustment amount; measures finalized billing corrections affecting revenue."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total adjustment amount applied to invoices; measures actual revenue impact of corrections."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total unapplied adjustment balance; measures pending billing correction exposure."
    - name: "total_tax_on_adjustments"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of adjustments; used for tax reconciliation on billing corrections."
    - name: "approved_memo_count"
      expr: COUNT(CASE WHEN is_approved = TRUE THEN 1 END)
      comment: "Number of approved adjustment memos; measures governance throughput for billing corrections."
    - name: "avg_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment memo value; benchmarks typical correction size for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_nre_billing_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NRE (Non-Recurring Engineering) billing milestone metrics tracking milestone completion, billing amounts, and schedule adherence — KPIs for NRE revenue recognition and project billing governance."
  source: "`vibe_semiconductors_v1`.`invoice`.`nre_billing_milestone`"
  dimensions:
    - name: "nre_billing_milestone_status"
      expr: nre_billing_milestone_status
      comment: "Current status of the NRE billing milestone (Planned, Achieved, Invoiced, Paid)."
    - name: "billing_trigger_type"
      expr: billing_trigger_type
      comment: "Event that triggers billing (Milestone Completion, Date-Based, Deliverable Acceptance)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the NRE billing milestone for multi-currency project revenue reporting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flag indicating whether the milestone recurs; used to separate one-time vs. recurring NRE revenue."
    - name: "planned_date_month"
      expr: DATE_TRUNC('MONTH', planned_date)
      comment: "Month the milestone was planned; used for NRE revenue schedule vs. actuals analysis."
    - name: "actual_date_month"
      expr: DATE_TRUNC('MONTH', actual_date)
      comment: "Month the milestone was actually achieved; used to measure schedule adherence."
  measures:
    - name: "total_nre_milestones"
      expr: COUNT(1)
      comment: "Total number of NRE billing milestones; baseline KPI for NRE project billing activity."
    - name: "total_nre_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross NRE amount billed across milestones; primary NRE revenue KPI."
    - name: "total_nre_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net NRE amount after tax; recognized NRE revenue for financial reporting."
    - name: "total_nre_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on NRE billings; used for tax compliance on engineering service revenue."
    - name: "avg_nre_milestone_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average NRE milestone billing amount; benchmarks milestone value for project pricing governance."
    - name: "distinct_nre_projects"
      expr: COUNT(DISTINCT ic_design_project_id)
      comment: "Number of distinct design projects with NRE billing milestones; measures NRE program breadth."
    - name: "recurring_milestone_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring NRE milestones; measures predictable NRE revenue stream size."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_pricing_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing agreement metrics covering discount rates, rebate accruals, and commitment levels — strategic KPIs for pricing governance, margin management, and commercial compliance."
  source: "`vibe_semiconductors_v1`.`invoice`.`pricing_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of pricing agreement (Volume Discount, Rebate, Fixed Price, Tiered) for commercial analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the pricing agreement (Active, Expired, Pending Renewal)."
    - name: "rebate_type"
      expr: rebate_type
      comment: "Type of rebate (Volume, Growth, Loyalty) for rebate program performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing agreement for multi-currency commercial reporting."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the agreement is currently active; used to filter live commercial commitments."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Flag indicating the agreement is exclusive; used to track exclusivity commitments."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the agreement became effective; used for cohort analysis of commercial agreements."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "Frequency of rebate settlement (Monthly, Quarterly, Annual) for cash-flow planning."
  measures:
    - name: "total_pricing_agreements"
      expr: COUNT(1)
      comment: "Total number of pricing agreements; baseline KPI for commercial agreement portfolio size."
    - name: "total_minimum_commitment_amount"
      expr: SUM(CAST(minimum_commitment_amount AS DOUBLE))
      comment: "Total minimum purchase commitments across agreements; measures contracted revenue floor."
    - name: "total_maximum_commitment_amount"
      expr: SUM(CAST(maximum_commitment_amount AS DOUBLE))
      comment: "Total maximum purchase commitments; measures contracted revenue ceiling."
    - name: "total_rebate_accrued_amount"
      expr: SUM(CAST(rebate_accrued_amount AS DOUBLE))
      comment: "Total rebate liability accrued; measures commercial rebate obligation for financial provisioning."
    - name: "total_rebate_settled_amount"
      expr: SUM(CAST(rebate_settled_amount AS DOUBLE))
      comment: "Total rebates paid out to customers; measures actual rebate cash outflow."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across pricing agreements; benchmarks pricing discipline."
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across agreements; used to monitor rebate program cost trends."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active pricing agreements; measures live commercial commitment portfolio."
    - name: "distinct_accounts_with_agreements"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of unique customer accounts with pricing agreements; measures commercial coverage."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_tax_determination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax determination metrics tracking tax amounts, rates, exemptions, and withholding — critical KPIs for tax compliance, liability management, and regulatory reporting."
  source: "`vibe_semiconductors_v1`.`invoice`.`tax_determination`"
  dimensions:
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (VAT, GST, Sales Tax, Withholding) for tax liability categorization."
    - name: "tax_category"
      expr: tax_category
      comment: "Tax category for the line item; used for tax code compliance and reporting."
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction (country/state/region) for geographic tax liability analysis."
    - name: "tax_jurisdiction_type"
      expr: tax_jurisdiction_type
      comment: "Level of tax jurisdiction (Federal, State, Local) for multi-level tax reporting."
    - name: "tax_currency"
      expr: tax_currency
      comment: "Currency in which tax is assessed for multi-currency tax reporting."
    - name: "is_tax_exempt"
      expr: is_tax_exempt
      comment: "Flag indicating the transaction is tax-exempt; used to monitor exemption compliance."
    - name: "tax_is_reverse_charge"
      expr: tax_is_reverse_charge
      comment: "Flag indicating reverse charge mechanism applies; critical for VAT compliance in cross-border transactions."
    - name: "tax_withholding_flag"
      expr: tax_withholding_flag
      comment: "Flag indicating withholding tax applies; used for withholding tax liability reporting."
    - name: "tax_reporting_month"
      expr: DATE_TRUNC('MONTH', tax_reporting_period)
      comment: "Month of the tax reporting period; used for periodic tax filing and remittance analysis."
  measures:
    - name: "total_tax_determinations"
      expr: COUNT(1)
      comment: "Total number of tax determination records; baseline KPI for tax transaction volume."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax assessed across all determinations; primary tax liability KPI for compliance reporting."
    - name: "total_taxable_amount"
      expr: SUM(CAST(taxable_amount AS DOUBLE))
      comment: "Total taxable base amount; used to validate tax calculation accuracy and effective tax rates."
    - name: "total_tax_base_amount"
      expr: SUM(CAST(tax_base_amount AS DOUBLE))
      comment: "Total tax base amount for rate application; used for tax audit and reconciliation."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total withholding tax assessed; used for withholding tax remittance and compliance reporting."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax credits applied; measures tax credit utilization for cash tax optimization."
    - name: "tax_exempt_transaction_count"
      expr: COUNT(CASE WHEN is_tax_exempt = TRUE THEN 1 END)
      comment: "Number of tax-exempt transactions; used to monitor exemption certificate compliance."
    - name: "reverse_charge_transaction_count"
      expr: COUNT(CASE WHEN tax_is_reverse_charge = TRUE THEN 1 END)
      comment: "Number of reverse-charge transactions; critical for cross-border VAT compliance monitoring."
    - name: "avg_tax_rate_percent"
      expr: AVG(CAST(tax_rate_percent AS DOUBLE))
      comment: "Average effective tax rate across determinations; used to benchmark tax burden and detect rate anomalies."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`invoice_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition schedule metrics tracking scheduled vs. recognized amounts and schedule adherence — KPIs for deferred revenue management and ASC 606 compliance."
  source: "`vibe_semiconductors_v1`.`invoice`.`recognition_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of recognition schedule (Straight-Line, Milestone, Usage-Based) for revenue pattern analysis."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the recognition schedule (Active, Completed, Cancelled, On-Hold)."
    - name: "frequency"
      expr: frequency
      comment: "Recognition frequency (Monthly, Quarterly, Annual) for cash-flow and revenue timing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition schedule for multi-currency deferred revenue reporting."
    - name: "is_recognized"
      expr: is_recognized
      comment: "Flag indicating the scheduled amount has been recognized; used to track recognition completion."
    - name: "is_prorated"
      expr: is_prorated
      comment: "Flag indicating the schedule uses proration; used to identify partial-period recognition."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of the scheduled recognition date; enables forward-looking revenue schedule analysis."
  measures:
    - name: "total_recognition_schedules"
      expr: COUNT(1)
      comment: "Total number of recognition schedule records; baseline KPI for deferred revenue schedule volume."
    - name: "total_scheduled_amount"
      expr: SUM(CAST(scheduled_amount AS DOUBLE))
      comment: "Total amount scheduled for recognition; measures deferred revenue pipeline."
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total amount actually recognized from schedules; measures recognition execution vs. plan."
    - name: "total_amount_per_period"
      expr: SUM(CAST(amount_per_period AS DOUBLE))
      comment: "Total periodic recognition amount across all active schedules; used for revenue run-rate forecasting."
    - name: "total_schedule_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total contract value covered by recognition schedules; measures deferred revenue balance sheet exposure."
    - name: "recognized_schedule_count"
      expr: COUNT(CASE WHEN is_recognized = TRUE THEN 1 END)
      comment: "Number of fully recognized schedule records; measures recognition completion rate."
    - name: "pending_recognition_count"
      expr: COUNT(CASE WHEN is_recognized = FALSE OR is_recognized IS NULL THEN 1 END)
      comment: "Number of schedule records pending recognition; measures deferred revenue backlog."
    - name: "avg_amount_per_period"
      expr: AVG(CAST(amount_per_period AS DOUBLE))
      comment: "Average periodic recognition amount; benchmarks typical revenue recognition cadence."
$$;