-- Metric views for domain: billing | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice KPIs covering revenue recognition, collection performance, discount leakage, and tax exposure. Primary steering dashboard for the CFO and AR leadership."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (standard, credit note, debit note, proforma) for segmenting revenue streams."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (draft, issued, paid, overdue, cancelled) for pipeline analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency for multi-currency revenue analysis and FX exposure reporting."
    - name: "collection_status"
      expr: collection_status
      comment: "AR collection status (current, past-due, in-collections, written-off) for cash flow risk segmentation."
    - name: "billing_period_month"
      expr: DATE_TRUNC('MONTH', billing_period_start)
      comment: "Month bucket of the billing period start date for trend analysis and period-over-period comparisons."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month bucket of invoice due date for aging and cash flow forecasting."
    - name: "is_self_billing"
      expr: is_self_billing
      comment: "Flag indicating self-billing invoices (customer-generated) vs. supplier-generated for compliance segmentation."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax-exempt, used for tax liability and compliance reporting."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount across all invoices. Primary revenue top-line KPI for executive dashboards."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Represents actual recognized revenue obligation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax billed across invoices. Critical for tax liability reporting and regulatory compliance."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on invoices. Measures discount leakage and pricing discipline."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Baseline volume metric for billing throughput and workload analysis."
    - name: "avg_invoice_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Tracks deal size trends and customer spend patterns over time."
    - name: "discount_rate_avg"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate applied across invoices. Monitors pricing discipline and margin erosion risk."
    - name: "tax_rate_avg"
      expr: AVG(CAST(tax_rate AS DOUBLE))
      comment: "Average effective tax rate across invoices. Used for tax planning and jurisdiction-level compliance review."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers billed. Measures billing reach and customer activity breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level billing KPIs for revenue decomposition, product mix analysis, discount and tax attribution, and deferred revenue tracking. Used by revenue operations and finance controllers."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice_line`"
  dimensions:
    - name: "line_type"
      expr: line_type
      comment: "Type of invoice line (product, service, tax, freight, discount) for revenue stream decomposition."
    - name: "line_status"
      expr: line_status
      comment: "Processing status of the invoice line for operational completeness tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice line for multi-currency revenue analysis."
    - name: "uom"
      expr: uom
      comment: "Unit of measure for the billed item, enabling volume-based analysis across product categories."
    - name: "is_bundle_line"
      expr: is_bundle_line
      comment: "Indicates whether the line is part of a product bundle, for bundle vs. standalone revenue analysis."
    - name: "is_credit_memo"
      expr: is_credit_memo
      comment: "Flags credit memo lines for returns and adjustments analysis."
    - name: "is_royalty_line"
      expr: is_royalty_line
      comment: "Flags royalty-bearing lines for royalty obligation tracking and partner payment analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Tax exemption flag at line level for granular tax compliance reporting."
    - name: "service_period_month"
      expr: DATE_TRUNC('MONTH', service_start_date)
      comment: "Month bucket of service start date for period-based revenue attribution."
  measures:
    - name: "total_line_amount"
      expr: SUM(CAST(line_amount AS DOUBLE))
      comment: "Total billed line amount before discounts and tax. Core revenue volume metric at line granularity."
    - name: "total_net_line_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts at line level. Represents actual revenue recognized per line."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted at line level. Enables product-level discount leakage analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level for granular tax liability attribution by product or service."
    - name: "total_quantity_billed"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity billed across invoice lines. Measures billing volume for capacity and demand analysis."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across billed lines. Tracks realized pricing vs. list price for margin management."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage at line level. Key pricing discipline KPI for sales and finance leadership."
    - name: "total_royalty_amount"
      expr: SUM(CASE WHEN is_royalty_line = TRUE THEN CAST(line_amount AS DOUBLE) ELSE 0 END)
      comment: "Total royalty-bearing revenue. Critical for partner royalty obligation management and IP monetization tracking."
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total cost/revenue allocation amount at line level for cost center and profit center attribution."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Baseline billing complexity metric for operational capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection KPIs covering cash receipt volumes, discount utilization, reconciliation rates, and fee analysis. Primary dashboard for treasury and AR management."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Payment channel (bank transfer, credit card, check, ACH) for channel mix and cost-to-collect analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency cash flow analysis and FX reconciliation."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of payment allocation to invoices (allocated, partially allocated, unallocated) for AR clearing analysis."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of payment allocation (automatic, manual, partial) for process efficiency analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Payment transaction type (receipt, refund, reversal) for cash flow categorization."
    - name: "is_reconciled"
      expr: is_reconciled
      comment: "Reconciliation flag for identifying unreconciled payments that require treasury action."
    - name: "original_currency"
      expr: original_currency
      comment: "Original payment currency before conversion, for FX gain/loss analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Month bucket of payment allocation date for cash application trend analysis."
  measures:
    - name: "total_gross_payment_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross cash received. Primary treasury KPI for cash inflow monitoring and liquidity management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net payment amount after fees and discounts. Represents actual cash applied to AR balances."
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total amount allocated to invoices. Measures AR clearing effectiveness and cash application completeness."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Measures cost of early payment incentive programs."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred. Tracks cost of payment channel operations for treasury optimization."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of payments received for tax remittance reconciliation."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received. Baseline volume metric for AR operations throughput."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross payment amount. Tracks customer payment behavior and deal size trends."
    - name: "unreconciled_payment_count"
      expr: COUNT(CASE WHEN is_reconciled = FALSE THEN 1 END)
      comment: "Number of payments not yet reconciled. Key operational risk metric for treasury and AR teams."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers making payments. Measures active paying customer base breadth."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_collections`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections performance KPIs covering exposure, recovery rates, dunning effectiveness, and legal escalation risk. Used by credit and collections management to steer recovery strategy."
  source: "`vibe_manufacturing_v1`.`billing`.`collections`"
  dimensions:
    - name: "collection_stage"
      expr: collection_stage
      comment: "Current collections stage (early, mid, late, legal) for funnel analysis and strategy assignment."
    - name: "case_status"
      expr: case_status
      comment: "Status of the collections case (open, closed, escalated, settled) for workload and resolution tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the collections exposure for multi-currency risk aggregation."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level reached for measuring collections process intensity and customer responsiveness."
    - name: "communication_method"
      expr: communication_method
      comment: "Method used to contact the customer (email, phone, letter) for channel effectiveness analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates cases escalated to senior management or legal for risk concentration monitoring."
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Indicates cases where legal action has been initiated for legal cost and recovery rate analysis."
    - name: "write_off_candidate_flag"
      expr: write_off_candidate_flag
      comment: "Flags cases identified as write-off candidates for bad debt provisioning and reserve management."
    - name: "case_open_month"
      expr: DATE_TRUNC('MONTH', case_open_date)
      comment: "Month bucket of case open date for collections vintage analysis and aging cohort tracking."
  measures:
    - name: "total_gross_exposure"
      expr: SUM(CAST(gross_exposure_amount AS DOUBLE))
      comment: "Total gross collections exposure outstanding. Primary bad debt risk KPI for CFO and credit leadership."
    - name: "total_net_exposure"
      expr: SUM(CAST(net_exposure_amount AS DOUBLE))
      comment: "Total net collections exposure after recoveries. Represents actual at-risk AR balance for provisioning."
    - name: "total_promised_amount"
      expr: SUM(CAST(promised_amount AS DOUBLE))
      comment: "Total amount promised by customers in payment arrangements. Measures committed recovery pipeline."
    - name: "total_dunning_charges"
      expr: SUM(CAST(dunning_charges AS DOUBLE))
      comment: "Total dunning charges levied. Tracks revenue from late payment penalties and collections cost recovery."
    - name: "collections_case_count"
      expr: COUNT(1)
      comment: "Total number of active collections cases. Baseline workload metric for collections team capacity planning."
    - name: "escalated_case_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of escalated collections cases. Measures severity of collections portfolio and management attention required."
    - name: "legal_action_case_count"
      expr: COUNT(CASE WHEN legal_action_flag = TRUE THEN 1 END)
      comment: "Number of cases with active legal proceedings. Key risk metric for legal cost forecasting and credit policy review."
    - name: "write_off_candidate_count"
      expr: COUNT(CASE WHEN write_off_candidate_flag = TRUE THEN 1 END)
      comment: "Number of cases flagged as write-off candidates. Drives bad debt reserve provisioning decisions."
    - name: "avg_net_exposure_per_case"
      expr: AVG(CAST(net_exposure_amount AS DOUBLE))
      comment: "Average net exposure per collections case. Measures average severity and helps prioritize collector effort."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk KPIs covering limit utilization, exposure concentration, approval status, and review cycle compliance. Used by credit risk management and CFO for portfolio risk steering."
  source: "`vibe_manufacturing_v1`.`billing`.`credit_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of credit limit (individual, group, product-specific) for risk segmentation."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the credit limit (approved, pending, rejected) for governance compliance tracking."
    - name: "risk_category"
      expr: risk_category
      comment: "Customer risk category (low, medium, high) for portfolio risk concentration analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit limit for multi-currency exposure aggregation."
    - name: "credit_block_flag"
      expr: credit_block_flag
      comment: "Indicates customers with active credit blocks for order fulfillment risk monitoring."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month bucket of credit limit effective date for limit change trend analysis."
    - name: "next_review_month"
      expr: DATE_TRUNC('MONTH', next_review_date)
      comment: "Month bucket of next scheduled review date for review cycle compliance monitoring."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all customers. Measures total credit risk exposure authorized by the business."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure AS DOUBLE))
      comment: "Total current credit exposure outstanding. Primary credit risk KPI for portfolio risk management."
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average credit utilization rate across customers. Measures how aggressively customers are drawing on credit lines."
    - name: "credit_blocked_customer_count"
      expr: COUNT(CASE WHEN credit_block_flag = TRUE THEN 1 END)
      comment: "Number of customers with active credit blocks. Directly impacts order fulfillment and revenue at risk."
    - name: "credit_limit_record_count"
      expr: COUNT(1)
      comment: "Total number of credit limit records. Baseline for credit portfolio size and governance coverage."
    - name: "high_utilization_count"
      expr: COUNT(CASE WHEN CAST(utilization_percentage AS DOUBLE) >= 80 THEN 1 END)
      comment: "Number of customers with utilization at or above 80%. Identifies customers approaching credit ceiling and potential order blockage risk."
    - name: "avg_credit_horizon_days"
      expr: AVG(CAST(credit_horizon_days AS DOUBLE))
      comment: "Average credit horizon in days across the portfolio. Measures forward-looking credit exposure window for risk planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice dispute KPIs covering dispute volume, disputed amounts, resolution rates, and escalation patterns. Used by AR management and customer success to reduce revenue leakage from billing disputes."
  source: "`vibe_manufacturing_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, under review, resolved, escalated) for pipeline management."
    - name: "reason_category"
      expr: reason_category
      comment: "Root cause category of the dispute (pricing error, delivery issue, quality) for systemic issue identification."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (credit issued, payment confirmed, write-off) for resolution quality analysis."
    - name: "priority"
      expr: priority
      comment: "Dispute priority level for workload triage and SLA compliance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for multi-currency exposure analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates escalated disputes requiring senior management attention."
    - name: "dispute_month"
      expr: DATE_TRUNC('MONTH', dispute_date)
      comment: "Month bucket of dispute creation date for trend analysis and seasonal pattern detection."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of amounts under dispute. Primary revenue-at-risk KPI for AR and finance leadership."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes raised. Measures billing quality and customer satisfaction with invoicing accuracy."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of disputes escalated to senior management. Indicates severity of billing quality issues."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per case. Tracks dispute severity and helps prioritize resolution resources."
    - name: "distinct_customer_dispute_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with active disputes. Measures breadth of billing quality issues across the customer base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off KPIs covering write-off volumes, recovery rates, and approval governance. Used by CFO and credit management to monitor bad debt provisioning accuracy and recovery effectiveness."
  source: "`vibe_manufacturing_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of the write-off (pending approval, approved, reversed, recovered) for governance tracking."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the write-off for governance compliance and delegation analysis."
    - name: "reason"
      expr: reason
      comment: "Reason for the write-off (bankruptcy, dispute settled, uncollectable) for root cause analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write-off for multi-currency bad debt reporting."
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Indicates whether any recovery has been achieved on the written-off amount."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_timestamp)
      comment: "Month bucket of write-off approval for trend analysis and period-end provisioning review."
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off as bad debt. Primary bad debt expense KPI for P&L impact assessment."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from previously written-off balances. Measures collections recovery effectiveness."
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off transactions. Baseline metric for bad debt frequency and credit policy effectiveness."
    - name: "recovery_case_count"
      expr: COUNT(CASE WHEN recovery_flag = TRUE THEN 1 END)
      comment: "Number of write-offs with partial or full recovery. Measures post-write-off collections success rate."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per transaction. Tracks severity of individual bad debt events for credit policy calibration."
    - name: "distinct_customer_write_off_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customers with write-offs. Measures breadth of credit loss across the customer portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition KPIs covering recognized vs. deferred revenue, recognition timing, and ASC 606/IFRS 15 compliance. Used by finance controllers and CFO for accurate revenue reporting."
  source: "`vibe_manufacturing_v1`.`billing`.`revenue_recognition_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of the revenue recognition event (pending, recognized, deferred, adjusted) for revenue pipeline management."
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of recognition event (point-in-time, over-time, milestone) for ASC 606 performance obligation analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognition event for multi-currency revenue reporting."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Indicates whether the recognition event has been adjusted, for audit trail and restatement risk monitoring."
    - name: "adjustment_reason"
      expr: adjustment_reason
      comment: "Reason for revenue recognition adjustment for audit and compliance review."
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_timestamp)
      comment: "Month bucket of revenue recognition for period-end close and trend analysis."
    - name: "effective_period_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month bucket of the effective recognition period start for deferred revenue schedule analysis."
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period. Primary top-line revenue KPI for financial reporting and investor relations."
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods. Critical for balance sheet deferred revenue liability management."
    - name: "total_cogs_amount"
      expr: SUM(CAST(cost_of_goods_sold_amount AS DOUBLE))
      comment: "Total cost of goods sold associated with recognized revenue. Enables gross margin calculation at recognition event level."
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total contract amount subject to recognition. Measures total performance obligation value under management."
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events. Baseline metric for recognition process volume and complexity."
    - name: "adjusted_event_count"
      expr: COUNT(CASE WHEN is_adjusted = TRUE THEN 1 END)
      comment: "Number of recognition events that required adjustment. Measures revenue recognition quality and restatement risk."
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_amount AS DOUBLE))
      comment: "Average recognized revenue per event. Tracks deal size and contract value trends for revenue planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing account portfolio KPIs covering AR balances, credit exposure, account health, and dunning status. Used by AR management and finance leadership to monitor the health of the billing portfolio."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of billing account (direct, indirect, intercompany) for portfolio segmentation."
    - name: "billing_account_status"
      expr: billing_account_status
      comment: "Current status of the billing account (active, suspended, closed) for portfolio health monitoring."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency (monthly, quarterly, annual) for cash flow forecasting and billing cycle planning."
    - name: "invoice_delivery_method"
      expr: invoice_delivery_method
      comment: "How invoices are delivered (email, portal, EDI, paper) for digital adoption and cost-to-serve analysis."
    - name: "dunning_procedure"
      expr: dunning_procedure
      comment: "Dunning procedure assigned to the account for collections strategy segmentation."
    - name: "collection_stage"
      expr: collection_stage
      comment: "Current collections stage of the account for AR risk portfolio analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Tax exemption status for compliance and revenue reporting segmentation."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing account for geographic revenue and risk analysis."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month bucket of account open date for cohort analysis and customer lifetime value tracking."
  measures:
    - name: "total_ar_balance"
      expr: SUM(CAST(current_ar_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all billing accounts. Primary cash flow and liquidity KPI for treasury."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all billing accounts. Measures total authorized credit exposure."
    - name: "billing_account_count"
      expr: COUNT(1)
      comment: "Total number of billing accounts. Baseline metric for customer billing portfolio size."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN billing_account_status = 'active' THEN 1 END)
      comment: "Number of active billing accounts. Measures active revenue-generating customer base."
    - name: "avg_ar_balance_per_account"
      expr: AVG(CAST(current_ar_balance AS DOUBLE))
      comment: "Average AR balance per billing account. Tracks average customer payment behavior and credit utilization."
    - name: "avg_credit_limit_amount"
      expr: AVG(CAST(credit_limit_amount AS DOUBLE))
      comment: "Average credit limit per billing account. Benchmarks credit policy generosity and risk appetite."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance payment KPIs covering prepayment volumes, tax exposure, and discount utilization. Used by treasury and order management to track customer prepayment behavior and working capital impact."
  source: "`vibe_manufacturing_v1`.`billing`.`payment`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the advance payment for multi-currency cash flow analysis."
  measures:
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original advance payment amount before adjustments. Used for reconciliation and clearing analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on advance payments for tax liability reporting and compliance."
    - name: "advance_payment_count"
      expr: COUNT(1)
      comment: "Total number of advance payments received. Baseline metric for prepayment program adoption and customer behavior."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_intercompany_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany billing KPIs covering transfer pricing, elimination flags, settlement status, and markup analysis. Used by group finance and consolidation teams to manage intercompany balances and ensure accurate group reporting."
  source: "`vibe_manufacturing_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of the intercompany invoice (draft, posted, settled, reversed) for consolidation completeness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the intercompany invoice for FX translation and consolidation analysis."
  measures:
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net intercompany amount after discounts. Used for intercompany balance reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany invoices for transfer pricing compliance and tax authority reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount on intercompany invoices for transfer pricing policy compliance review."
    - name: "intercompany_invoice_count"
      expr: COUNT(1)
      comment: "Total number of intercompany invoices. Baseline metric for intercompany transaction volume and consolidation complexity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing schedule KPIs covering milestone billing performance, retention tracking, and schedule adherence. Used by project finance and contract management to ensure timely billing and cash collection on project contracts."
  source: "`vibe_manufacturing_v1`.`billing`.`billing_schedule`"
  dimensions:
    - name: "billing_status"
      expr: billing_status
      comment: "Status of the billing schedule milestone (planned, billed, overdue, cancelled) for billing pipeline management."
    - name: "milestone_type"
      expr: milestone_type
      comment: "Type of billing milestone (delivery, acceptance, completion, time-based) for contract billing structure analysis."
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency of the billing schedule for multi-currency project billing analysis."
    - name: "is_retention_applicable"
      expr: is_retention_applicable
      comment: "Indicates whether retention is withheld on this billing milestone for cash flow impact analysis."
    - name: "planned_billing_month"
      expr: DATE_TRUNC('MONTH', planned_billing_date)
      comment: "Month bucket of planned billing date for cash flow forecasting and billing schedule adherence."
    - name: "actual_billing_month"
      expr: DATE_TRUNC('MONTH', actual_billing_date)
      comment: "Month bucket of actual billing date for billing timeliness and schedule variance analysis."
  measures:
    - name: "total_planned_billing_amount"
      expr: SUM(CAST(planned_billing_amount AS DOUBLE))
      comment: "Total planned billing amount across all schedule milestones. Primary project revenue pipeline KPI."
    - name: "total_actual_billed_amount"
      expr: SUM(CAST(actual_billed_amount AS DOUBLE))
      comment: "Total amount actually billed against schedule milestones. Measures billing execution vs. plan."
    - name: "total_retention_amount"
      expr: SUM(CAST(retention_amount AS DOUBLE))
      comment: "Total retention withheld across billing milestones. Measures cash tied up in retention and release timing risk."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on billing schedule milestones for project tax liability tracking."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount applied to billing schedule milestones for contract profitability analysis."
    - name: "billing_schedule_count"
      expr: COUNT(1)
      comment: "Total number of billing schedule milestones. Baseline metric for project billing complexity and workload."
    - name: "avg_percentage_complete_trigger"
      expr: AVG(CAST(percentage_complete_trigger AS DOUBLE))
      comment: "Average completion percentage required to trigger billing. Measures contract billing structure and cash flow timing."
$$;