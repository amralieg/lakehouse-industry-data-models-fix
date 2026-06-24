-- Metric views for domain: billing | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice performance metrics tracking revenue recognition, outstanding balances, discount impact, and tax exposure across the billing cycle. Used by Finance VPs and CFO for AR management and revenue steering."
  source: "`vibe_automotive_v1`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice (e.g., vehicle sale, parts, service, warranty) for revenue stream segmentation."
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (open, paid, cancelled, disputed) for AR aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region for geographic revenue breakdown."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-over-period revenue comparison."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue reporting."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Invoice month for trend analysis and monthly close reporting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (wire, ACH, check, card) for cash flow channel analysis."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the invoice for product-line revenue analysis."
    - name: "msrp_based_flag"
      expr: msrp_based_flag
      comment: "Indicates whether the invoice is priced at MSRP, enabling MSRP vs. negotiated price analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross billed amount across all invoices. Primary top-line revenue KPI for Finance leadership."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after discounts. Core P&L revenue line used in financial reporting."
    - name: "total_outstanding_ar"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total accounts receivable outstanding. Critical liquidity and cash flow KPI for CFO and Treasury."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected against invoices. Measures cash collection effectiveness."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted across invoices. Tracks discount leakage and pricing discipline."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected. Required for tax compliance reporting and VAT reconciliation."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued. Volume baseline for billing throughput and operational capacity."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice value. Tracks deal size trends and pricing effectiveness over time."
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount per invoice. Monitors discount policy adherence and margin erosion risk."
    - name: "distinct_account_count"
      expr: COUNT(DISTINCT account_id)
      comment: "Number of distinct billing accounts invoiced. Measures customer billing breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging, collection performance, and write-off risk metrics. Used by Credit & Collections teams and CFO to manage DSO, overdue exposure, and bad debt risk."
  source: "`vibe_automotive_v1`.`billing`.`receivable`"
  dimensions:
    - name: "receivable_status"
      expr: receivable_status
      comment: "Current status of the receivable (open, collected, written-off, disputed) for AR portfolio health."
    - name: "receivable_type"
      expr: receivable_type
      comment: "Type of receivable (vehicle, parts, service, warranty) for segment-level AR analysis."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (current, 30, 60, 90+ days) for overdue exposure stratification."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level for collection intensity tracking."
    - name: "customer_type"
      expr: customer_type
      comment: "Customer segment (dealer, fleet, retail) for receivable risk profiling."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency AR reporting."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for geographic AR concentration analysis."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates accounts on credit hold, enabling proactive risk management."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed receivables for dispute resolution prioritization."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates written-off receivables for bad debt trend analysis."
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the receivable is due for cash flow forecasting."
  measures:
    - name: "total_original_ar_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original receivable amount. Baseline for AR portfolio size and revenue recognition."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance. Primary DSO and liquidity KPI for CFO and Treasury."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as bad debt. Critical credit risk and P&L impact metric."
    - name: "receivable_count"
      expr: COUNT(1)
      comment: "Total number of open receivable records. Operational volume baseline for collections team."
    - name: "disputed_receivable_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of receivables under dispute. Tracks billing quality and dispute resolution workload."
    - name: "written_off_receivable_count"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Number of receivables written off. Monitors bad debt incidence and credit policy effectiveness."
    - name: "credit_hold_receivable_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of receivables on credit hold. Indicates accounts requiring immediate collections intervention."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per receivable. Tracks average exposure per open item for risk sizing."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection performance, reconciliation status, and cash application efficiency metrics. Used by Treasury, AR Operations, and CFO to monitor cash inflows and payment processing health."
  source: "`vibe_automotive_v1`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (received, applied, returned, disputed) for cash application tracking."
    - name: "payment_method"
      expr: method
      comment: "Payment method (wire, ACH, check, card) for channel-level cash flow analysis."
    - name: "payer_entity_type"
      expr: payer_entity_type
      comment: "Type of paying entity (dealer, fleet, retail customer) for receivables segmentation."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the payment for cash reconciliation completeness tracking."
    - name: "currency"
      expr: currency
      comment: "Payment currency for multi-currency cash management."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month of payment receipt for monthly cash collection trend analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates payments under dispute for exception management."
    - name: "channel"
      expr: channel
      comment: "Payment channel (online, branch, lockbox) for channel efficiency benchmarking."
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash received. Primary cash collection KPI for Treasury and CFO daily cash position."
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total payment amount successfully applied to invoices. Measures cash application efficiency."
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total unapplied cash sitting in suspense. Tracks cash application backlog and working capital risk."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts taken by customers. Monitors discount utilization and cost of terms."
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payments received. Volume baseline for payment processing capacity planning."
    - name: "disputed_payment_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of payments flagged as disputed. Tracks payment dispute incidence for process quality."
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction. Monitors payment size trends and customer payment behavior."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level revenue, discount, and margin metrics enabling product-mix, channel, and SKU-level profitability analysis. Used by Revenue Management, Sales Finance, and Product Controllers."
  source: "`vibe_automotive_v1`.`billing`.`billing_invoice_line`"
  dimensions:
    - name: "line_item_type"
      expr: line_item_type
      comment: "Type of line item (vehicle, part, labor, service, warranty) for revenue stream decomposition."
    - name: "line_status"
      expr: line_status
      comment: "Status of the invoice line (active, cancelled, credited) for revenue quality filtering."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category for P&L revenue line classification and management reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue analysis."
    - name: "dealer_code"
      expr: dealer_code
      comment: "Dealer identifier for dealer-level revenue and margin performance."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Billing month for period revenue trend analysis."
    - name: "labor_operation_code"
      expr: labor_operation_code
      comment: "Labor operation code for service revenue and labor efficiency analysis."
    - name: "promotion_code"
      expr: promotion_code
      comment: "Promotion code applied to the line for promotional effectiveness measurement."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity-based revenue analysis."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total billed revenue at line level. Most granular revenue KPI for product-mix and SKU profitability."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax subtotal across invoice lines. Used for pre-tax revenue reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level. Tracks discount leakage by product, dealer, and promotion."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged at line level. Required for tax compliance and VAT reporting."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total units billed. Volume KPI for parts, vehicles, and service throughput measurement."
    - name: "invoice_line_count"
      expr: COUNT(1)
      comment: "Total number of invoice lines. Billing complexity and throughput baseline."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across invoice lines. Tracks realized pricing vs. list price trends."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted. Monitors pricing discipline and margin erosion at line level."
    - name: "avg_negotiated_price"
      expr: AVG(CAST(negotiated_price AS DOUBLE))
      comment: "Average negotiated price per line. Benchmarks negotiated pricing against MSRP for deal quality analysis."
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP across billed lines. Reference baseline for price realization rate calculation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo issuance, value, and reason analysis. Used by Revenue Assurance, Sales Finance, and Dealer Relations to monitor revenue reversals, warranty reimbursements, and dispute resolutions."
  source: "`vibe_automotive_v1`.`billing`.`credit_memo`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit memo (warranty, recall, dispute, incentive) for root cause revenue reversal analysis."
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Reason code for the credit memo for structured root cause categorization."
    - name: "credit_memo_status"
      expr: credit_memo_status
      comment: "Current status of the credit memo (pending, approved, posted, rejected) for workflow tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit memo for multi-currency reversal reporting."
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Distribution channel associated with the credit for channel-level reversal analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-level credit memo impact on revenue."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual credit memo trend and revenue impact reporting."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month credit memo was issued for trend analysis."
    - name: "vehicle_model"
      expr: vehicle_model
      comment: "Vehicle model associated with the credit for product-level reversal analysis."
  measures:
    - name: "total_gross_credit_amount"
      expr: SUM(CAST(gross_credit_amount AS DOUBLE))
      comment: "Total gross credit value issued. Primary revenue reversal KPI for P&L impact assessment."
    - name: "total_net_credit_amount"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Total net credit value after tax adjustments. Net revenue reversal for financial reporting."
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Total tax component of credit memos. Required for VAT/tax credit reconciliation."
    - name: "credit_memo_count"
      expr: COUNT(1)
      comment: "Total number of credit memos issued. Volume indicator of billing errors, disputes, and warranty activity."
    - name: "avg_net_credit_amount"
      expr: AVG(CAST(net_credit_amount AS DOUBLE))
      comment: "Average net credit memo value. Tracks typical reversal size for risk and process quality benchmarking."
    - name: "distinct_dealer_count"
      expr: COUNT(DISTINCT credit_dealership_id)
      comment: "Number of distinct dealers receiving credit memos. Identifies dealer concentration in revenue reversals."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute volume, value, resolution performance, and SLA compliance metrics. Used by AR Operations, Customer Finance, and Revenue Assurance to manage dispute risk and resolution efficiency."
  source: "`vibe_automotive_v1`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of billing dispute (pricing, quantity, warranty, delivery) for root cause categorization."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status (open, under review, resolved, escalated) for workload management."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the dispute for systemic billing quality improvement."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (credit issued, rejected, adjusted) for resolution pattern analysis."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached for dispute severity and management attention tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount for multi-currency exposure reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the dispute for regional billing quality benchmarking."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the dispute breached SLA resolution targets for service quality monitoring."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month dispute was opened for trend and seasonality analysis."
    - name: "disputing_party_type"
      expr: disputing_party_type
      comment: "Type of disputing party (dealer, fleet, retail) for customer segment dispute profiling."
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total value of amounts under dispute. Primary financial exposure KPI for Revenue Assurance and CFO."
    - name: "total_credited_amount"
      expr: SUM(CAST(credited_amount AS DOUBLE))
      comment: "Total amount credited as dispute resolution. Measures financial concession cost of dispute resolution."
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes. Volume KPI for billing quality and AR operations workload."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes that breached SLA. Tracks service quality and resolution process compliance."
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL THEN 1 END)
      comment: "Number of disputes that required escalation. Indicates severity of unresolved billing issues."
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average disputed amount per dispute. Tracks typical dispute size for risk prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_rebate_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate accrual tracking, settlement performance, and liability exposure metrics. Used by Sales Finance, Dealer Relations, and CFO to manage rebate program costs and accrual accuracy."
  source: "`vibe_automotive_v1`.`billing`.`rebate_accrual`"
  dimensions:
    - name: "accrual_status"
      expr: accrual_status
      comment: "Status of the rebate accrual (pending, posted, settled, reversed) for liability management."
    - name: "rebate_rate_type"
      expr: rebate_rate_type
      comment: "Type of rebate rate (percentage, flat, tiered) for program structure analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the accrual for financial control and audit compliance."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate accrual for multi-currency liability reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for period-level rebate cost and accrual accuracy reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual rebate program cost management."
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region for geographic rebate cost distribution analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for volume-based rebate accrual analysis."
    - name: "accrual_period_month"
      expr: DATE_TRUNC('MONTH', accrual_period_start_date)
      comment: "Accrual period month for monthly rebate liability trend analysis."
  measures:
    - name: "total_accrued_rebate_amount"
      expr: SUM(CAST(accrued_amount AS DOUBLE))
      comment: "Total rebate amount accrued in the period. Primary rebate liability KPI for P&L and balance sheet."
    - name: "total_cumulative_accrued_amount"
      expr: SUM(CAST(cumulative_accrued_amount AS DOUBLE))
      comment: "Total cumulative rebate accrual. Tracks running rebate liability exposure for financial planning."
    - name: "total_accrued_units"
      expr: SUM(CAST(accrued_units AS DOUBLE))
      comment: "Total units accrued for volume-based rebate programs. Tracks program achievement vs. targets."
    - name: "accrual_record_count"
      expr: COUNT(1)
      comment: "Total number of rebate accrual records. Volume baseline for rebate program activity."
    - name: "avg_rebate_rate"
      expr: AVG(CAST(rebate_rate AS DOUBLE))
      comment: "Average rebate rate across accruals. Monitors rebate generosity and program cost efficiency."
    - name: "distinct_agreement_count"
      expr: COUNT(DISTINCT rebate_agreement_id)
      comment: "Number of distinct rebate agreements with active accruals. Tracks rebate program breadth."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate agreement portfolio, achievement, and settlement metrics. Used by Sales Finance and Dealer Relations leadership to manage rebate program performance, cost, and dealer incentive effectiveness."
  source: "`vibe_automotive_v1`.`billing`.`rebate_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of rebate agreement (volume, loyalty, conquest, fleet) for program portfolio analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (active, expired, terminated) for portfolio health monitoring."
    - name: "beneficiary_type"
      expr: beneficiary_type
      comment: "Type of rebate beneficiary (dealer, fleet, distributor) for program targeting analysis."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status of the agreement for cash outflow forecasting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rebate agreement for multi-currency program cost reporting."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for geographic rebate program distribution analysis."
    - name: "dealer_tier"
      expr: dealer_tier
      comment: "Dealer tier for tiered rebate program performance benchmarking."
    - name: "settlement_frequency"
      expr: settlement_frequency
      comment: "How often rebates are settled (monthly, quarterly, annual) for cash flow planning."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective for cohort-based program analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates agreements under dispute for risk and resolution prioritization."
  measures:
    - name: "total_accrued_rebate_liability"
      expr: SUM(CAST(total_accrued_amount AS DOUBLE))
      comment: "Total accrued rebate liability across all agreements. Primary balance sheet liability KPI for Finance."
    - name: "total_settled_rebate_amount"
      expr: SUM(CAST(total_settled_amount AS DOUBLE))
      comment: "Total rebate cash paid out. Tracks actual rebate cost vs. accrual for P&L accuracy."
    - name: "total_outstanding_rebate_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total unsettled rebate balance. Cash outflow obligation for Treasury planning."
    - name: "rebate_agreement_count"
      expr: COUNT(1)
      comment: "Total number of rebate agreements. Portfolio size KPI for program management complexity."
    - name: "avg_rebate_rate_percent"
      expr: AVG(CAST(rebate_rate_percent AS DOUBLE))
      comment: "Average rebate rate percentage across agreements. Monitors program generosity and cost efficiency."
    - name: "avg_rebate_amount_per_unit"
      expr: AVG(CAST(rebate_amount_per_unit AS DOUBLE))
      comment: "Average rebate amount per unit. Tracks per-unit incentive cost for vehicle program profitability."
    - name: "disputed_agreement_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of rebate agreements under dispute. Tracks program administration quality and legal risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_dunning_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections dunning effectiveness, overdue exposure, and escalation metrics. Used by Credit & Collections management to optimize dunning strategies and reduce bad debt."
  source: "`vibe_automotive_v1`.`billing`.`dunning_record`"
  dimensions:
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current dunning status (active, resolved, escalated, blocked) for collections pipeline management."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level (1-4) for collections intensity and strategy segmentation."
    - name: "dunning_notice_type"
      expr: dunning_notice_type
      comment: "Type of dunning notice sent for communication channel effectiveness analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for targeted collections strategy and risk profiling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency overdue exposure reporting."
    - name: "dunning_block_flag"
      expr: dunning_block_flag
      comment: "Indicates accounts with dunning blocked for exception management."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed dunning records for collections process quality."
    - name: "response_received_flag"
      expr: response_received_flag
      comment: "Indicates whether customer responded to dunning notice for engagement rate analysis."
    - name: "dunning_run_month"
      expr: DATE_TRUNC('MONTH', dunning_run_date)
      comment: "Month of dunning run for collections activity trend analysis."
  measures:
    - name: "total_overdue_amount"
      expr: SUM(CAST(total_overdue_amount AS DOUBLE))
      comment: "Total overdue AR amount under dunning. Primary collections exposure KPI for CFO and Credit management."
    - name: "total_dunning_fee_amount"
      expr: SUM(CAST(dunning_fee_amount AS DOUBLE))
      comment: "Total dunning fees charged. Tracks late payment penalty revenue and collections cost recovery."
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on overdue balances. Monitors interest income from late payments."
    - name: "total_payment_promise_amount"
      expr: SUM(CAST(payment_promise_amount AS DOUBLE))
      comment: "Total amount promised by customers during collections. Tracks expected cash recovery from dunning."
    - name: "dunning_record_count"
      expr: COUNT(1)
      comment: "Total number of active dunning records. Collections workload and overdue account volume KPI."
    - name: "response_received_count"
      expr: COUNT(CASE WHEN response_received_flag = TRUE THEN 1 END)
      comment: "Number of dunning notices with customer response. Measures dunning communication effectiveness."
    - name: "avg_overdue_amount"
      expr: AVG(CAST(total_overdue_amount AS DOUBLE))
      comment: "Average overdue amount per dunning record. Tracks typical overdue exposure for risk sizing."
    - name: "avg_credit_exposure"
      expr: AVG(CAST(credit_exposure AS DOUBLE))
      comment: "Average credit exposure per dunning account. Monitors credit risk concentration in collections portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_dealer_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dealer financial statement metrics covering vehicle sales, parts, service, warranty reimbursements, and incentive payouts. Used by Dealer Finance and Regional Sales management for dealer financial health monitoring."
  source: "`vibe_automotive_v1`.`billing`.`dealer_statement`"
  dimensions:
    - name: "statement_type"
      expr: statement_type
      comment: "Type of dealer statement (monthly, quarterly, special) for statement portfolio analysis."
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the statement (draft, issued, disputed, reconciled) for workflow tracking."
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle for statement periodicity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Statement currency for multi-currency dealer financial reporting."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization for regional dealer financial performance benchmarking."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed statements for dealer relations and AR exception management."
    - name: "floorplan_financing_flag"
      expr: floorplan_financing_flag
      comment: "Indicates statements with floorplan financing for inventory financing cost tracking."
    - name: "statement_month"
      expr: DATE_TRUNC('MONTH', statement_date)
      comment: "Statement month for dealer financial trend analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual dealer financial performance reporting."
  measures:
    - name: "total_vehicle_sales_amount"
      expr: SUM(CAST(total_vehicle_sales_amount AS DOUBLE))
      comment: "Total vehicle sales billed to dealers. Primary dealer revenue KPI for Sales Finance."
    - name: "total_parts_sales_amount"
      expr: SUM(CAST(total_parts_sales_amount AS DOUBLE))
      comment: "Total parts sales billed to dealers. Tracks parts revenue stream performance."
    - name: "total_service_charges_amount"
      expr: SUM(CAST(total_service_charges_amount AS DOUBLE))
      comment: "Total service charges billed. Monitors dealer service revenue contribution."
    - name: "total_warranty_reimbursement_amount"
      expr: SUM(CAST(total_warranty_reimbursement_amount AS DOUBLE))
      comment: "Total warranty reimbursements paid to dealers. Tracks warranty cost and dealer satisfaction."
    - name: "total_incentive_amount"
      expr: SUM(CAST(total_incentive_amount AS DOUBLE))
      comment: "Total incentive payments to dealers. Monitors dealer incentive program cost and effectiveness."
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_invoice_amount AS DOUBLE))
      comment: "Total invoiced amount on dealer statements. Aggregate billing volume for dealer portfolio."
    - name: "total_payment_received_amount"
      expr: SUM(CAST(total_payment_received_amount AS DOUBLE))
      comment: "Total payments received from dealers. Cash collection performance from dealer network."
    - name: "total_closing_balance_amount"
      expr: SUM(CAST(closing_balance_amount AS DOUBLE))
      comment: "Total closing AR balance across dealer statements. Dealer network AR exposure for credit management."
    - name: "dealer_statement_count"
      expr: COUNT(1)
      comment: "Total number of dealer statements issued. Billing volume baseline for dealer network management."
    - name: "disputed_statement_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of disputed dealer statements. Tracks dealer billing quality and dispute resolution workload."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bad debt write-off volume, value, and recovery metrics. Used by CFO, Credit Risk, and Finance Controllers to monitor credit loss, recovery rates, and bad debt provisioning accuracy."
  source: "`vibe_automotive_v1`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category of write-off (bad debt, fraud, dispute settlement) for loss classification."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write-off for root cause analysis and credit policy improvement."
    - name: "collection_status"
      expr: collection_status
      comment: "Collection status at time of write-off for collections process effectiveness evaluation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the write-off for multi-currency bad debt reporting."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level for write-off governance and control monitoring."
    - name: "sales_region_code"
      expr: sales_region_code
      comment: "Sales region for geographic bad debt concentration analysis."
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Indicates whether any recovery was achieved post write-off for recovery rate tracking."
    - name: "write_off_month"
      expr: DATE_TRUNC('MONTH', write_off_date)
      comment: "Month of write-off for bad debt trend and provisioning accuracy analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual bad debt expense reporting."
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off as bad debt. Primary credit loss KPI for CFO and risk management."
    - name: "total_original_invoice_amount"
      expr: SUM(CAST(original_invoice_amount AS DOUBLE))
      comment: "Total original invoice value of written-off receivables. Baseline for write-off rate calculation."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered post write-off. Tracks recovery program effectiveness and net credit loss."
    - name: "total_outstanding_before_write_off"
      expr: SUM(CAST(outstanding_balance_before_write_off AS DOUBLE))
      comment: "Total outstanding balance at time of write-off. Measures write-off completeness and residual exposure."
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off transactions. Volume indicator of credit loss incidence."
    - name: "recovery_count"
      expr: COUNT(CASE WHEN recovery_flag = TRUE THEN 1 END)
      comment: "Number of write-offs with partial or full recovery. Tracks recovery program reach."
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off amount per transaction. Monitors typical credit loss size for provisioning calibration."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_payment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment plan portfolio, default risk, and collection performance metrics. Used by Credit Operations and Finance to manage installment plan health, default rates, and outstanding obligations."
  source: "`vibe_automotive_v1`.`billing`.`payment_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of payment plan (installment, deferred, balloon) for portfolio structure analysis."
    - name: "payment_plan_status"
      expr: payment_plan_status
      comment: "Current status of the payment plan (active, defaulted, completed, cancelled) for portfolio health."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency (monthly, quarterly, weekly) for cash flow forecasting."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for channel-level plan performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment plan for multi-currency obligation reporting."
    - name: "defaulted_flag"
      expr: defaulted_flag
      comment: "Indicates defaulted payment plans for credit risk and collections prioritization."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Indicates auto-renewing plans for recurring revenue and retention analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates tax-exempt payment plans for tax compliance reporting."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the payment plan became effective for cohort-based default analysis."
  measures:
    - name: "total_plan_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total contracted payment plan value. Portfolio size KPI for Finance and Credit Operations."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across payment plans. Receivable exposure for Treasury and Credit."
    - name: "total_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Total amount collected against payment plans. Cash collection performance KPI."
    - name: "total_down_payment_amount"
      expr: SUM(CAST(down_payment_amount AS DOUBLE))
      comment: "Total down payments collected. Tracks upfront cash collection and credit risk mitigation."
    - name: "total_early_termination_fee"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees charged. Monitors plan cancellation cost and revenue impact."
    - name: "payment_plan_count"
      expr: COUNT(1)
      comment: "Total number of payment plans. Portfolio volume baseline for Credit Operations."
    - name: "defaulted_plan_count"
      expr: COUNT(CASE WHEN defaulted_flag = TRUE THEN 1 END)
      comment: "Number of defaulted payment plans. Primary credit default KPI for risk management."
    - name: "avg_installment_amount"
      expr: AVG(CAST(installment_amount AS DOUBLE))
      comment: "Average installment amount per plan. Tracks typical payment obligation size for affordability analysis."
    - name: "avg_interest_rate"
      expr: AVG(CAST(interest_rate AS DOUBLE))
      comment: "Average interest rate across payment plans. Monitors financing cost and pricing competitiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_advance_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advance payment and deposit management metrics tracking application rates, unapplied balances, and refund activity. Used by Treasury and AR Operations to manage customer deposits and down payment liabilities."
  source: "`vibe_automotive_v1`.`billing`.`payment`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for cash reconciliation completeness tracking."
    - name: "payer_entity_type"
      expr: payer_entity_type
      comment: "Type of payer (dealer, fleet, retail) for advance payment portfolio segmentation."
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month advance payment was received for cash flow trend analysis."
  measures:
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total advance amounts applied to invoices. Tracks advance utilization and liability reduction."
    - name: "advance_payment_count"
      expr: COUNT(1)
      comment: "Total number of advance payment records. Volume baseline for deposit management operations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing run execution performance, throughput, and error rate metrics. Used by Billing Operations and Finance IT to monitor billing cycle health, automation quality, and period-close readiness."
  source: "`vibe_automotive_v1`.`billing`.`run`"
  dimensions:
    - name: "run_type"
      expr: run_type
      comment: "Type of billing run (regular, reversal, correction, intercompany) for run portfolio analysis."
    - name: "run_status"
      expr: run_status
      comment: "Execution status of the billing run (completed, failed, partial, reversed) for operational monitoring."
    - name: "billing_category"
      expr: billing_category
      comment: "Billing category (vehicle, parts, service, warranty) for run scope analysis."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organization for organizational billing throughput benchmarking."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel for channel-level billing volume analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing run for multi-currency billing volume reporting."
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates reversal runs for billing correction volume tracking."
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Billing month for period-level throughput and close performance analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual billing operations performance reporting."
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed across all runs. Billing throughput KPI for Finance period-close management."
    - name: "total_gross_amount"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount generated by billing runs. Revenue generation volume for Finance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discounts applied across billing runs. Monitors discount volume and pricing policy adherence."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax generated across billing runs. Tax compliance and VAT reporting KPI."
    - name: "billing_run_count"
      expr: COUNT(1)
      comment: "Total number of billing runs executed. Operational volume baseline for billing cycle management."
    - name: "reversal_run_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of reversal billing runs. Tracks billing correction frequency and process quality."
    - name: "avg_billed_amount_per_run"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per run. Monitors billing run efficiency and throughput consistency."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`billing_account_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure metrics at the account level"
  source: "`vibe_automotive_v1`.`billing`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Operational status of the account"
    - name: "account_type"
      expr: account_type
      comment: "Type/category of the account"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Regulatory jurisdiction of the account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the account"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Aggregate credit limit across accounts"
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_exposure_amount AS DOUBLE))
      comment: "Aggregate credit exposure across accounts"
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of accounts"
$$;