-- Metric views for domain: finance | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics tracking payables liability, discount capture efficiency, tax exposure, and payment performance across suppliers, company codes, and fiscal periods."
  source: "`consumer_goods_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the AP invoice (e.g. Open, Cleared, Blocked) used to segment payables by lifecycle stage."
    - name: "invoice_category"
      expr: invoice_category
      comment: "Category of the AP invoice (e.g. Standard, Credit Memo, Down Payment) for payables classification."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to settle the invoice (e.g. ACH, Wire, Check) for cash management analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Agreed payment terms code (e.g. Net30, 2/10Net30) driving discount eligibility and due date calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the invoice for multi-currency payables exposure reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period payables trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) of the invoice for granular payables aging and accrual reporting."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice for VAT/GST compliance and tax liability reporting."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating why payment is blocked, used to identify and resolve payment holds."
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status (e.g. Matched, Unmatched, Exception) for invoice processing quality monitoring."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice date truncated to month for time-series payables volume and aging analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for cash outflow forecasting and liquidity planning."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for period-close accrual and ledger reconciliation."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all AP invoices. Drives payables liability on the balance sheet and cash outflow forecasting."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount after discounts and adjustments. Core payables exposure metric for treasury and working capital management."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across AP invoices. Critical for VAT/GST compliance reporting and tax cash flow planning."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts available on AP invoices. Measures potential savings from optimized payment timing."
    - name: "total_early_payment_discount_taken"
      expr: SUM(CAST(early_payment_discount_taken AS DOUBLE))
      comment: "Total early payment discounts actually captured. Directly measures procurement savings and treasury efficiency."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Used for cash disbursement reporting and bank reconciliation."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments. Required for regulatory tax compliance and supplier remittance reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for AP workload, automation rate, and process efficiency benchmarking."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers invoiced. Measures supplier base breadth and concentration risk in payables."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of invoices with an active payment block. High blocked invoice counts signal process exceptions requiring resolution to avoid late payment penalties."
    - name: "unmatched_invoice_count"
      expr: COUNT(CASE WHEN match_status <> 'Matched' THEN 1 END)
      comment: "Number of invoices that have not achieved three-way match. Drives AP exception workload and risk of duplicate or fraudulent payments."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Used to benchmark invoice size trends and identify anomalous high-value invoices for audit focus."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across AP invoices. Monitors FX exposure and rate consistency for multi-currency payables."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_ap_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable payment execution metrics covering payment amounts, discount capture, approval cycle performance, and payment block resolution for cash disbursement governance."
  source: "`consumer_goods_ecm`.`finance`.`ap_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g. Pending, Cleared, Rejected) for payment pipeline monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g. ACH, Wire, Check) for cash disbursement channel analysis."
    - name: "payment_approval_status"
      expr: payment_approval_status
      comment: "Approval workflow status of the payment for governance and audit trail reporting."
    - name: "payment_block_code"
      expr: payment_block_code
      comment: "Code indicating the reason a payment is blocked, used to prioritize resolution and avoid late fees."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency in which the payment was executed for multi-currency cash management reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency of the payment entity for consolidated financial reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms governing the disbursement for working capital and DPO analysis."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for cash outflow trend analysis and liquidity forecasting."
    - name: "approved_date_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Approval date truncated to month for payment approval cycle time trending."
    - name: "remittance_advice_sent_flag"
      expr: remittance_advice_sent_flag
      comment: "Indicates whether remittance advice was sent to the supplier, supporting supplier relationship and reconciliation quality."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash disbursed to suppliers. Primary cash outflow metric for treasury and liquidity management."
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment after discounts. Reflects actual cash outflow and working capital consumption."
    - name: "total_discount_amount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured on payments. Directly measures procurement and treasury savings from optimized payment timing."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local functional currency for consolidated balance sheet and FX exposure reporting."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions executed. Baseline for AP throughput, automation rate, and processing cost benchmarking."
    - name: "distinct_supplier_payment_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of unique suppliers paid in the period. Measures supplier payment breadth and concentration."
    - name: "blocked_payment_count"
      expr: COUNT(CASE WHEN payment_block_code IS NOT NULL AND payment_block_code <> '' THEN 1 END)
      comment: "Number of payments currently blocked. High counts indicate process exceptions that risk late payment penalties and supplier relationship damage."
    - name: "avg_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average payment amount per transaction. Used to detect anomalous disbursements and benchmark payment size trends."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX rate applied to payments. Monitors FX cost consistency for multi-currency disbursements."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable invoice metrics covering revenue billed, collections performance, outstanding balances, deductions, write-offs, and dispute management for cash conversion and credit risk governance."
  source: "`consumer_goods_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AR invoice (e.g. Open, Cleared, Disputed) for receivables pipeline monitoring."
    - name: "billing_document_type"
      expr: billing_document_type
      comment: "Type of billing document (e.g. Invoice, Credit Memo, Debit Memo) for revenue and adjustment classification."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales channel through which the invoice was generated (e.g. Retail, E-Commerce, Wholesale) for channel revenue analysis."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the invoice for regional and organizational revenue reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency receivables exposure and FX risk reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method specified on the invoice for collections channel analysis."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms governing the receivable for DSO and working capital analysis."
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "Aging bucket classification (e.g. 0-30, 31-60, 61-90, 90+ days) for receivables aging and credit risk reporting."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level applied to the invoice for collections intensity and bad debt risk assessment."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates whether the invoice is under dispute. Disputed invoices delay cash collection and require resolution resources."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions (e.g. Trade Promotion, Shortage, Pricing) for deduction management and recovery analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for annual revenue and receivables trend reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the invoice for monthly revenue recognition and period-close reporting."
    - name: "billing_date_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Billing date truncated to month for revenue billed trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Due date truncated to month for cash inflow forecasting and collections prioritization."
  measures:
    - name: "total_gross_billed_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount billed to customers. Top-line revenue billed metric used in P&L and revenue performance reporting."
    - name: "total_net_billed_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net billed amount after trade discounts and adjustments. Reflects net revenue recognized for financial reporting."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total open receivables balance. Core metric for working capital management, credit risk, and cash conversion cycle analysis."
    - name: "total_amount_received"
      expr: SUM(CAST(amount_received AS DOUBLE))
      comment: "Total cash collected against AR invoices. Measures collections effectiveness and cash inflow performance."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken against invoices. High deductions erode net revenue and require trade promotion and claims management."
    - name: "total_trade_discount_amount"
      expr: SUM(CAST(trade_discount_amount AS DOUBLE))
      comment: "Total trade discounts granted to customers. Measures the cost of trade terms and promotional pricing on net revenue."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total receivables written off as uncollectible. Directly impacts P&L as bad debt expense and signals credit policy effectiveness."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed on AR invoices. Required for VAT/GST compliance and tax liability reporting."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices issued. Baseline volume metric for billing throughput and order-to-cash process benchmarking."
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of invoices under active dispute. High dispute counts signal pricing, delivery, or quality issues impacting cash collection."
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique customers invoiced. Measures customer billing breadth and revenue concentration risk."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice value per billing document. Used to benchmark invoice size and detect anomalous billing patterns."
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CAST(amount_received AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed amount collected. Core collections effectiveness KPI — low rates signal credit risk or collections process failures requiring immediate action."
    - name: "deduction_rate"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Deductions as a percentage of gross billed amount. Measures trade promotion and claims leakage against revenue — a key net revenue management KPI."
    - name: "write_off_rate"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Write-offs as a percentage of gross billed amount. Measures bad debt risk and credit policy effectiveness — directly impacts P&L."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable payment application metrics covering cash collected, deductions, discounts, reversal activity, and payment channel performance for order-to-cash cycle optimization."
  source: "`consumer_goods_ecm`.`finance`.`ar_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the AR payment (e.g. Applied, Unapplied, Reversed) for cash application pipeline monitoring."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used by the customer to pay (e.g. ACH, Wire, Check) for payment channel analysis and automation targeting."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was received (e.g. Lockbox, EDI, Portal) for cash application efficiency analysis."
    - name: "payment_currency_code"
      expr: payment_currency_code
      comment: "Currency of the customer payment for multi-currency cash application and FX exposure reporting."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local functional currency for consolidated cash receipts reporting."
    - name: "deduction_reason_code"
      expr: deduction_reason_code
      comment: "Reason code for customer deductions taken at payment (e.g. Trade Promotion, Shortage) for deduction recovery management."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payment for annual cash collections trend reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payment for monthly cash receipts and period-close reconciliation."
    - name: "payment_date_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment date truncated to month for cash inflow trend analysis and liquidity forecasting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the payment was reversed. Reversed payments reduce effective cash collected and signal processing errors or disputes."
    - name: "short_payment_flag"
      expr: short_payment_flag
      comment: "Indicates whether the customer paid less than the invoiced amount. Short payments require deduction investigation and recovery."
    - name: "overpayment_flag"
      expr: overpayment_flag
      comment: "Indicates whether the customer overpaid. Overpayments require refund processing and customer account reconciliation."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total gross cash received from customers. Primary cash inflow metric for treasury, liquidity management, and order-to-cash performance."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount successfully applied to AR invoices. Measures cash application effectiveness and unapplied cash risk."
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total deductions taken by customers at payment. Measures revenue leakage from trade claims and requires active deduction management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts granted to customers. Measures the cost of accelerating cash collection through discount incentives."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total payment amount in local functional currency for consolidated financial reporting and FX reconciliation."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of AR payment transactions received. Baseline for collections throughput and cash application workload benchmarking."
    - name: "reversed_payment_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of payments that were reversed. High reversal counts signal payment processing errors, fraud risk, or dispute escalations."
    - name: "short_payment_count"
      expr: COUNT(CASE WHEN short_payment_flag = TRUE THEN 1 END)
      comment: "Number of short payments received. Drives deduction investigation workload and measures customer payment compliance."
    - name: "distinct_customer_payment_count"
      expr: COUNT(DISTINCT trade_account_id)
      comment: "Number of unique customers who made payments in the period. Measures collections breadth and customer payment activity."
    - name: "application_rate"
      expr: ROUND(100.0 * SUM(CAST(applied_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of received cash successfully applied to invoices. Low rates indicate unapplied cash risk and cash application process inefficiency — a key order-to-cash KPI."
    - name: "deduction_rate"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(payment_amount AS DOUBLE)), 0), 2)
      comment: "Deductions as a percentage of total payments received. Measures customer deduction behavior and net revenue leakage at the point of payment."
    - name: "reversal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of payments that were reversed. High reversal rates signal systemic payment processing issues or elevated dispute activity."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_cogs_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of Goods Sold allocation metrics covering total product cost, cost component breakdown (materials, labor, overhead, packaging, freight), and cost variance analysis by SKU, cost center, and fiscal period."
  source: "`consumer_goods_ecm`.`finance`.`cogs_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate costs (e.g. Standard, Actual, Activity-Based) for cost accounting methodology analysis."
    - name: "costing_type"
      expr: costing_type
      comment: "Type of cost estimate (e.g. Standard, Actual, Plan) for cost version comparison and variance analysis."
    - name: "costing_version"
      expr: costing_version
      comment: "Version of the cost estimate for tracking cost changes across planning cycles."
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance (e.g. Price, Quantity, Efficiency) for root cause analysis of cost deviations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost allocation for multi-currency COGS reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the cost allocation for annual COGS trend and margin analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the cost allocation for monthly COGS and gross margin reporting."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the cost estimate (e.g. Released, Preliminary) for cost validity and approval workflow tracking."
    - name: "price_control_indicator"
      expr: price_control_indicator
      comment: "Indicates whether the SKU uses standard (S) or moving average (V) price control for inventory valuation method analysis."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('MONTH', allocation_date)
      comment: "Allocation date truncated to month for monthly COGS trend analysis."
  measures:
    - name: "total_cogs_amount"
      expr: SUM(CAST(total_cost_amount AS DOUBLE))
      comment: "Total cost of goods sold allocated. Primary COGS metric driving gross margin calculation and product profitability analysis."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost component of COGS. Measures material input cost and procurement efficiency impact on product cost."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost component of COGS. Measures manufacturing labor efficiency and workforce cost impact on product margins."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead absorbed into product cost. Measures factory overhead absorption and capacity utilization impact on unit cost."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead cost component. Measures variable manufacturing cost efficiency and volume-driven cost behavior."
    - name: "total_packaging_cost"
      expr: SUM(CAST(packaging_cost AS DOUBLE))
      comment: "Total packaging cost component of COGS. Packaging is a significant cost driver in consumer goods — tracks packaging efficiency and material cost trends."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight cost allocated to COGS. Measures inbound logistics cost impact on product cost and supply chain efficiency."
    - name: "total_depreciation_cost"
      expr: SUM(CAST(depreciation_cost AS DOUBLE))
      comment: "Total depreciation cost absorbed into COGS. Measures capital asset cost contribution to product cost and capex ROI."
    - name: "total_machine_overhead_cost"
      expr: SUM(CAST(machine_overhead_cost AS DOUBLE))
      comment: "Total machine overhead cost component. Measures equipment utilization cost and manufacturing automation efficiency."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance between standard and actual costs. Negative variances indicate cost overruns requiring manufacturing or procurement corrective action."
    - name: "allocation_count"
      expr: COUNT(1)
      comment: "Total number of COGS allocation records. Baseline for cost allocation volume and SKU-level cost coverage monitoring."
    - name: "avg_unit_total_cost"
      expr: AVG(CAST(total_cost_amount AS DOUBLE))
      comment: "Average total cost per allocation record. Used to benchmark unit cost trends and identify cost outliers by SKU or facility."
    - name: "raw_material_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(raw_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost_amount AS DOUBLE)), 0), 2)
      comment: "Raw material cost as a percentage of total COGS. Measures material intensity of the product portfolio — a key input cost structure KPI for procurement strategy."
    - name: "packaging_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(packaging_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_cost_amount AS DOUBLE)), 0), 2)
      comment: "Packaging cost as a percentage of total COGS. Consumer goods packaging is a major cost lever — this KPI drives packaging optimization decisions."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial budget planning and variance metrics covering planned spend, budget utilization, and variance thresholds by cost center, GL account, profit center, and fiscal period for financial planning and control."
  source: "`consumer_goods_ecm`.`finance`.`finance_budget`"
  dimensions:
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget (e.g. OPEX, CAPEX, Marketing, R&D) for budget allocation and spend category analysis."
    - name: "ebitda_category"
      expr: ebitda_category
      comment: "EBITDA line classification of the budget item (e.g. Revenue, COGS, SG&A) for P&L budget structure analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval workflow status (e.g. Draft, Approved, Locked) for budget governance and planning cycle monitoring."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate the budget (e.g. Top-Down, Bottom-Up, Zero-Based) for planning methodology analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning and year-over-year budget trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the budget for monthly budget phasing and spend tracking."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales or distribution channel associated with the budget for channel-level investment planning."
    - name: "local_currency_code"
      expr: local_currency_code
      comment: "Local currency of the budget for multi-currency financial planning consolidation."
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group reporting currency of the budget for consolidated financial planning and board reporting."
    - name: "version"
      expr: version
      comment: "Budget version (e.g. Original, Revised, Forecast) for budget iteration and reforecast tracking."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Budget validity start date truncated to month for budget phasing and planning calendar analysis."
  measures:
    - name: "total_planned_amount_local"
      expr: SUM(CAST(planned_amount_local AS DOUBLE))
      comment: "Total planned budget amount in local currency. Primary budget baseline metric for financial planning, spend authorization, and variance tracking."
    - name: "total_planned_amount_group"
      expr: SUM(CAST(planned_amount_group AS DOUBLE))
      comment: "Total planned budget amount in group reporting currency. Used for consolidated financial planning and board-level budget reporting."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned quantity budgeted. Used for volume-based budget planning in manufacturing, procurement, and sales."
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Total number of budget line items. Measures budget granularity and planning coverage across the organization."
    - name: "approved_budget_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved budget line items. Tracks budget approval progress and planning cycle completion."
    - name: "avg_planned_amount_local"
      expr: AVG(CAST(planned_amount_local AS DOUBLE))
      comment: "Average planned budget amount per line item in local currency. Used to benchmark budget allocation size and identify outlier budget lines."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance tolerance threshold set across budget lines. Measures the tightness of budget control governance — lower thresholds indicate stricter financial discipline."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied to budget translations. Monitors FX assumption consistency across the planning cycle."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering asset base value, accumulated depreciation, net book value, impairment, disposal proceeds, and asset lifecycle management for capital investment governance and balance sheet reporting."
  source: "`consumer_goods_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (e.g. Machinery, Buildings, Vehicles, IT Equipment) for capital asset portfolio analysis and depreciation policy management."
    - name: "asset_status"
      expr: asset_status
      comment: "Current lifecycle status of the asset (e.g. Active, Retired, Under Construction) for asset base management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (e.g. Straight-Line, Declining Balance) for depreciation policy consistency analysis."
    - name: "asset_group_code"
      expr: asset_group_code
      comment: "Asset group classification for portfolio-level capital investment and depreciation reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the asset valuation for multi-currency fixed asset reporting."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant or facility where the asset is located for site-level capital investment analysis."
    - name: "location_code"
      expr: location_code
      comment: "Physical location of the asset for geographic capital asset distribution reporting."
    - name: "capex_project_code"
      expr: capex_project_code
      comment: "CAPEX project code associated with the asset for project-level capital investment tracking and ROI analysis."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Asset acquisition year for capital investment vintage analysis and asset age distribution reporting."
    - name: "capitalization_date_month"
      expr: DATE_TRUNC('MONTH', capitalization_date)
      comment: "Capitalization date truncated to month for CAPEX activation trend analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Measures total capital invested in the asset base — a key balance sheet and CAPEX reporting metric."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation on fixed assets. Measures the consumed economic value of the asset base and drives net book value calculation."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (acquisition cost minus accumulated depreciation). Core balance sheet metric for capital asset reporting and impairment testing."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded on fixed assets. Impairment directly impacts P&L and signals asset value deterioration requiring strategic review."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds received from asset disposals. Measures capital recovery from asset retirement and informs asset lifecycle and replacement strategy."
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation adjustments applied to fixed assets. Tracks fair value adjustments impacting equity and balance sheet asset values."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets on the register. Baseline for asset base size, maintenance planning, and asset management governance."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets in years. Measures asset longevity assumptions and informs depreciation policy and capital replacement planning."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset. Used to benchmark asset value by class and identify underperforming or fully depreciated assets."
    - name: "depreciation_coverage_rate"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as a percentage of acquisition cost. Measures the average age/consumption of the asset base — high rates signal aging assets requiring capital reinvestment."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated residual salvage value of fixed assets. Used in depreciation base calculation and asset disposal planning."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry line metrics covering transaction currency amounts, tax postings, quantity flows, and debit/credit activity by GL account, cost center, profit center, and fiscal period for financial close and audit governance."
  source: "`consumer_goods_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Indicates whether the line is a debit (D) or credit (C) posting for ledger balance and trial balance analysis."
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency of the original transaction for multi-currency ledger analysis."
    - name: "company_code_currency_code"
      expr: company_code_currency_code
      comment: "Company code functional currency for local GAAP financial reporting."
    - name: "group_currency_code"
      expr: group_currency_code
      comment: "Group reporting currency for consolidated financial statements."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the journal line for VAT/GST compliance and tax posting analysis."
    - name: "posting_key"
      expr: posting_key
      comment: "SAP-style posting key indicating the account type and debit/credit direction for detailed ledger analysis."
    - name: "functional_area_code"
      expr: functional_area_code
      comment: "Functional area (e.g. Manufacturing, Sales, Administration) for cost-of-sales accounting and functional P&L reporting."
    - name: "business_area_code"
      expr: business_area_code
      comment: "Business area for segment-level financial reporting and internal management accounting."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant associated with the journal line for site-level financial analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the journal line is a reversal entry. High reversal rates signal period-close quality issues or error correction activity."
    - name: "value_date_month"
      expr: DATE_TRUNC('MONTH', value_date)
      comment: "Value date truncated to month for cash flow and liquidity reporting aligned to economic settlement dates."
    - name: "clearing_date_month"
      expr: DATE_TRUNC('MONTH', clearing_date)
      comment: "Clearing date truncated to month for open item management and period-close reconciliation."
  measures:
    - name: "total_transaction_currency_amount"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total posted amount in transaction currency. Core ledger posting volume metric for financial close and audit trail completeness."
    - name: "total_company_code_currency_amount"
      expr: SUM(CAST(amount_company_code_currency AS DOUBLE))
      comment: "Total posted amount in company code functional currency. Used for local GAAP financial statement preparation and trial balance reporting."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(amount_group_currency AS DOUBLE))
      comment: "Total posted amount in group reporting currency. Drives consolidated financial statements and group-level P&L and balance sheet reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount posted on journal lines. Required for VAT/GST compliance reporting and tax account reconciliation."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity posted on journal lines. Used for quantity-based ledger reconciliation and inventory valuation verification."
    - name: "journal_line_count"
      expr: COUNT(1)
      comment: "Total number of journal entry lines posted. Baseline for ledger posting volume, period-close workload, and audit scope sizing."
    - name: "reversal_line_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Number of reversal journal lines. High reversal counts signal period-close quality issues, manual error corrections, or accrual reversals requiring review."
    - name: "distinct_gl_account_count"
      expr: COUNT(DISTINCT gl_account_id)
      comment: "Number of distinct GL accounts posted to. Measures chart of accounts utilization and posting concentration for audit and simplification analysis."
    - name: "avg_transaction_currency_amount"
      expr: AVG(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Average transaction amount per journal line. Used to detect anomalous large postings and benchmark typical transaction size for fraud detection."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average FX exchange rate applied across journal lines. Monitors FX translation consistency and rate anomalies in multi-currency postings."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics covering recognized revenue, deferred revenue, variable consideration, trade promotion deductions, rebate accruals, and ASC 606/IFRS 15 compliance indicators for revenue quality and financial reporting governance."
  source: "`consumer_goods_ecm`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the revenue recognition event (e.g. Recognized, Deferred, Reversed) for revenue pipeline and compliance monitoring."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used to recognize revenue (e.g. Point-in-Time, Over-Time) per ASC 606/IFRS 15 performance obligation classification."
    - name: "channel_code"
      expr: channel_code
      comment: "Sales channel associated with the revenue event (e.g. Retail, E-Commerce, Wholesale) for channel-level revenue quality analysis."
    - name: "product_line_code"
      expr: product_line_code
      comment: "Product line associated with the recognized revenue for product portfolio revenue mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue recognition event for multi-currency revenue reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the revenue recognition for annual revenue trend and audit reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the revenue recognition for monthly revenue close and period-end reporting."
    - name: "sox_compliant_flag"
      expr: sox_compliant_flag
      comment: "Indicates whether the revenue recognition event is SOX compliant. Non-compliant events require immediate remediation to avoid audit findings."
    - name: "constraint_applied_flag"
      expr: constraint_applied_flag
      comment: "Indicates whether a variable consideration constraint was applied per ASC 606. Constrained revenue impacts reported revenue and requires disclosure."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the revenue recognition event was reversed. Reversals reduce recognized revenue and may signal contract modifications or errors."
    - name: "recognition_date_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Revenue recognition date truncated to month for monthly revenue trend and period-close reporting."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Posting date truncated to month for ledger alignment and period-close reconciliation."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period per ASC 606/IFRS 15. The primary top-line revenue metric for financial reporting, investor relations, and executive performance management."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods. Measures the revenue backlog on the balance sheet and future revenue visibility for financial planning."
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations. Measures gross contracted revenue before variable consideration adjustments."
    - name: "total_variable_consideration_estimate"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total estimated variable consideration (e.g. rebates, returns, volume discounts). Measures revenue at risk from variable pricing arrangements under ASC 606."
    - name: "total_trade_promotion_deduction"
      expr: SUM(CAST(trade_promotion_deduction AS DOUBLE))
      comment: "Total trade promotion deductions reducing recognized revenue. A critical consumer goods net revenue management metric — measures the cost of trade investment against gross revenue."
    - name: "total_rebate_accrual"
      expr: SUM(CAST(rebate_accrual AS DOUBLE))
      comment: "Total rebate accruals reducing recognized revenue. Measures customer rebate liability and its impact on net revenue and working capital."
    - name: "total_estimated_returns_reserve"
      expr: SUM(CAST(estimated_returns_reserve AS DOUBLE))
      comment: "Total estimated returns reserve reducing recognized revenue. Measures product return risk and its impact on net revenue per ASC 606 variable consideration guidance."
    - name: "total_cumulative_catch_up_adjustment"
      expr: SUM(CAST(cumulative_catch_up_adjustment AS DOUBLE))
      comment: "Total cumulative catch-up revenue adjustments. Large catch-up adjustments signal contract modifications or estimation changes requiring audit scrutiny."
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events. Baseline for revenue recognition volume and ASC 606 compliance coverage monitoring."
    - name: "sox_non_compliant_count"
      expr: COUNT(CASE WHEN sox_compliant_flag = FALSE THEN 1 END)
      comment: "Number of revenue recognition events flagged as SOX non-compliant. Any non-zero count requires immediate remediation to avoid material weakness findings."
    - name: "net_revenue_rate"
      expr: ROUND(100.0 * SUM(CAST(recognized_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Recognized revenue as a percentage of total transaction price. Measures net revenue realization after all deductions — a key consumer goods net revenue management KPI."
    - name: "trade_deduction_rate"
      expr: ROUND(100.0 * SUM(CAST(trade_promotion_deduction AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Trade promotion deductions as a percentage of transaction price. Measures trade investment efficiency and its drag on net revenue — directly informs trade spend ROI decisions."
    - name: "deferred_revenue_rate"
      expr: ROUND(100.0 * SUM(CAST(deferred_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 2)
      comment: "Deferred revenue as a percentage of total transaction price. Measures the proportion of contracted revenue not yet earned — a key revenue quality and balance sheet metric."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard cost metrics covering product cost structure, cost component breakdown, cost variance analysis, and cost estimate governance by SKU, manufacturing facility, and fiscal period for product profitability and cost management."
  source: "`consumer_goods_ecm`.`finance`.`standard_cost`"
  dimensions:
    - name: "costing_type"
      expr: costing_type
      comment: "Type of cost estimate (e.g. Standard, Actual, Plan) for cost version comparison and variance analysis."
    - name: "costing_version"
      expr: costing_version
      comment: "Version of the cost estimate for tracking cost changes across planning and recosting cycles."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the standard cost (e.g. Released, Preliminary, Locked) for cost validity and approval workflow governance."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the cost estimate for financial control and cost release governance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the standard cost for multi-currency product cost reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the standard cost for annual cost trend and year-over-year cost change analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the standard cost for monthly cost management and period-close reporting."
    - name: "valuation_variant"
      expr: valuation_variant
      comment: "Valuation variant used in the cost estimate for costing methodology consistency analysis."
    - name: "bom_usage"
      expr: bom_usage
      comment: "BOM usage type applied in the cost estimate for production vs. costing BOM alignment analysis."
    - name: "release_date_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Standard cost release date truncated to month for cost release cycle and timing analysis."
    - name: "valid_from_date_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Standard cost validity start date truncated to month for cost effective period analysis."
  measures:
    - name: "total_standard_cost"
      expr: SUM(CAST(total_standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs and cost estimates. Primary product cost baseline metric for gross margin planning and inventory valuation."
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material standard cost component. Measures material input cost baseline for procurement strategy and supplier negotiation."
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor standard cost component. Measures labor cost baseline for manufacturing efficiency and workforce planning."
    - name: "total_fixed_overhead_cost"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead standard cost component. Measures factory overhead absorption baseline for capacity planning and cost structure analysis."
    - name: "total_variable_overhead_cost"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead standard cost component. Measures variable manufacturing cost baseline for volume-driven cost modeling."
    - name: "total_packaging_material_cost"
      expr: SUM(CAST(packaging_material_cost AS DOUBLE))
      comment: "Total packaging material standard cost. A major cost driver in consumer goods — measures packaging cost baseline for packaging optimization and supplier negotiations."
    - name: "total_freight_in_cost"
      expr: SUM(CAST(freight_in_cost AS DOUBLE))
      comment: "Total inbound freight standard cost. Measures logistics cost baseline for supply chain cost optimization."
    - name: "total_machine_overhead_cost"
      expr: SUM(CAST(machine_overhead_cost AS DOUBLE))
      comment: "Total machine overhead standard cost. Measures equipment cost baseline for manufacturing automation ROI analysis."
    - name: "total_cost_variance_amount"
      expr: SUM(CAST(cost_variance_amount AS DOUBLE))
      comment: "Total cost variance between current and previous standard costs. Measures cost inflation or deflation trends requiring procurement or manufacturing corrective action."
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage across SKUs. Measures the magnitude of cost changes relative to prior standard — a key cost management KPI for identifying high-impact SKUs."
    - name: "standard_cost_record_count"
      expr: COUNT(1)
      comment: "Total number of standard cost records. Baseline for cost estimate coverage and SKU costing completeness monitoring."
    - name: "avg_total_standard_cost"
      expr: AVG(CAST(total_standard_cost AS DOUBLE))
      comment: "Average total standard cost per SKU/estimate record. Used to benchmark unit cost levels and identify cost outliers for product portfolio rationalization."
    - name: "raw_material_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(raw_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_standard_cost AS DOUBLE)), 0), 2)
      comment: "Raw material cost as a percentage of total standard cost. Measures material intensity of the product portfolio — drives procurement strategy and make-vs-buy decisions."
    - name: "packaging_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(packaging_material_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_standard_cost AS DOUBLE)), 0), 2)
      comment: "Packaging cost as a percentage of total standard cost. Consumer goods packaging is a major cost lever — this KPI drives packaging design and supplier optimization decisions."
$$;