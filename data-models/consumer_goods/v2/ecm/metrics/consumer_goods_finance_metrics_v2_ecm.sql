-- Metric views for domain: finance | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:38:27

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable invoice metrics tracking revenue, collections, aging, and customer payment performance"
  source: "`vibe_consumer_goods_v1`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice for period-over-period analysis"
    - name: "invoice_fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly/quarterly revenue tracking"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (open, paid, disputed, written off)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice for segmentation analysis"
    - name: "dso_aging_bucket"
      expr: dso_aging_bucket
      comment: "Days sales outstanding aging bucket for collections prioritization"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether invoice is under dispute"
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Whether invoice has been written off as uncollectible"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Sales distribution channel for channel performance analysis"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity financial consolidation"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AR invoices for volume tracking"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and deductions"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total outstanding receivables balance for cash flow forecasting"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount collected from customers"
    - name: "total_deduction_amount"
      expr: SUM(CAST(deduction_amount AS DOUBLE))
      comment: "Total customer deductions taken against invoices"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total bad debt written off for credit risk assessment"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average invoice size for customer segmentation"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount collected, key AR efficiency metric"
    - name: "deduction_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deduction_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Deduction rate as percentage of gross revenue, indicates pricing/promotion issues"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Bad debt rate for credit policy evaluation"
    - name: "dispute_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of disputed invoices for customer satisfaction tracking"
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices disputed, indicates billing quality issues"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking spend, payment timing, and supplier performance"
  source: "`vibe_consumer_goods_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for spend analysis"
    - name: "invoice_fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly spend tracking"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current invoice status (pending, approved, paid, blocked)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of invoice for spend categorization"
    - name: "match_status"
      expr: match_status
      comment: "Three-way match status for process efficiency tracking"
    - name: "payment_block_flag"
      expr: payment_block_flag
      comment: "Whether invoice is blocked from payment"
    - name: "three_way_match_flag"
      expr: three_way_match_flag
      comment: "Whether invoice passed three-way match validation"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity spend consolidation"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices for volume tracking"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net payable amount"
    - name: "total_outstanding_amount"
      expr: SUM(CAST(outstanding_amount AS DOUBLE))
      comment: "Total unpaid liability for cash planning"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid to suppliers"
    - name: "total_discount_captured"
      expr: SUM(CAST(early_payment_discount_taken AS DOUBLE))
      comment: "Total early payment discounts captured, measures working capital efficiency"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average invoice size for supplier segmentation"
    - name: "payment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(paid_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoices paid, tracks payment execution"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(early_payment_discount_taken AS DOUBLE)) / NULLIF(SUM(CAST(discount_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured, key working capital KPI"
    - name: "three_way_match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN three_way_match_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices passing three-way match, indicates process quality"
    - name: "blocked_invoice_count"
      expr: SUM(CASE WHEN payment_block_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of blocked invoices for exception management"
    - name: "blocked_invoice_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_block_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices blocked, indicates process friction"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics for financial close, audit, and SOX compliance tracking"
  source: "`vibe_consumer_goods_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close tracking"
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry for categorization"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status (draft, posted, reversed)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for workflow tracking"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether entry is a reversal"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Whether entry is intercompany for consolidation"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether entry is subject to SOX controls"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity reporting"
  measures:
    - name: "total_journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries for close volume tracking"
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit amount for balance validation"
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit amount for balance validation"
    - name: "avg_entry_amount"
      expr: AVG(CAST(total_debit_amount AS DOUBLE))
      comment: "Average journal entry size"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reversed entries, indicates error rate"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entries reversed, key quality metric for financial close"
    - name: "intercompany_entry_count"
      expr: SUM(CASE WHEN intercompany_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of intercompany entries for consolidation tracking"
    - name: "sox_controlled_entry_count"
      expr: SUM(CASE WHEN sox_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SOX-controlled entries for compliance monitoring"
    - name: "sox_controlled_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sox_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entries under SOX controls, measures control coverage"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_cogs_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost of goods sold allocation metrics for product costing, margin analysis, and variance management"
  source: "`vibe_consumer_goods_v1`.`finance`.`cogs_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for cost trend analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost tracking"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for cost allocation"
    - name: "costing_type"
      expr: costing_type
      comment: "Type of costing (standard, actual, planned)"
    - name: "variance_category"
      expr: variance_category
      comment: "Category of cost variance for root cause analysis"
    - name: "variance_type"
      expr: variance_type
      comment: "Type of variance (price, quantity, mix)"
    - name: "release_status"
      expr: release_status
      comment: "Release status of the cost allocation"
  measures:
    - name: "total_allocation_count"
      expr: COUNT(1)
      comment: "Total number of COGS allocations"
    - name: "total_cogs_amount"
      expr: SUM(CAST(total_cogs_amount AS DOUBLE))
      comment: "Total cost of goods sold for margin calculation"
    - name: "total_material_cost"
      expr: SUM(CAST(material_cost_amount AS DOUBLE))
      comment: "Total material cost component"
    - name: "total_labor_cost"
      expr: SUM(CAST(labor_cost_amount AS DOUBLE))
      comment: "Total labor cost component"
    - name: "total_overhead_cost"
      expr: SUM(CAST(overhead_cost_amount AS DOUBLE))
      comment: "Total overhead cost component"
    - name: "total_raw_material_cost"
      expr: SUM(CAST(raw_material_cost AS DOUBLE))
      comment: "Total raw material cost for sourcing decisions"
    - name: "total_direct_labor_cost"
      expr: SUM(CAST(direct_labor_cost AS DOUBLE))
      comment: "Total direct labor cost for productivity analysis"
    - name: "total_fixed_overhead"
      expr: SUM(CAST(fixed_overhead_cost AS DOUBLE))
      comment: "Total fixed overhead for capacity utilization analysis"
    - name: "total_variable_overhead"
      expr: SUM(CAST(variable_overhead_cost AS DOUBLE))
      comment: "Total variable overhead for volume-based cost management"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total cost variance for performance management"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost for pricing decisions"
    - name: "material_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(material_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Material cost as percentage of total COGS, key cost structure metric"
    - name: "labor_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(labor_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Labor cost as percentage of total COGS for automation ROI analysis"
    - name: "overhead_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(overhead_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_cogs_amount AS DOUBLE)), 0), 2)
      comment: "Overhead cost as percentage of total COGS for efficiency tracking"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics for ASC 606 compliance, deferred revenue tracking, and revenue quality"
  source: "`vibe_consumer_goods_v1`.`finance`.`revenue_recognition`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for revenue trend analysis"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue tracking"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (point in time, over time)"
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition"
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard applied (ASC 606, IFRS 15)"
    - name: "constraint_applied_flag"
      expr: constraint_applied_flag
      comment: "Whether variable consideration constraint was applied"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a revenue reversal"
    - name: "sox_compliant_flag"
      expr: sox_compliant_flag
      comment: "Whether recognition is SOX compliant"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity revenue consolidation"
  measures:
    - name: "total_recognition_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in period, key top-line metric"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total deferred revenue balance for future revenue visibility"
    - name: "total_transaction_price"
      expr: SUM(CAST(transaction_price AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations"
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_estimate AS DOUBLE))
      comment: "Total variable consideration estimated"
    - name: "total_rebate_accrual"
      expr: SUM(CAST(rebate_accrual AS DOUBLE))
      comment: "Total rebate accruals reducing net revenue"
    - name: "total_trade_promotion_deduction"
      expr: SUM(CAST(trade_promotion_deduction AS DOUBLE))
      comment: "Total trade promotion deductions for net revenue calculation"
    - name: "total_returns_reserve"
      expr: SUM(CAST(estimated_returns_reserve AS DOUBLE))
      comment: "Total estimated returns reserve for revenue quality assessment"
    - name: "avg_recognized_amount"
      expr: AVG(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Average revenue per recognition event"
    - name: "deferred_revenue_ratio"
      expr: ROUND(SUM(CAST(deferred_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_price AS DOUBLE)), 0), 3)
      comment: "Ratio of deferred to total transaction price, indicates revenue timing"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of revenue reversals for quality tracking"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recognitions reversed, indicates revenue quality issues"
    - name: "sox_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sox_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SOX-compliant recognitions for audit readiness"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_cash_flow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash position and liquidity metrics for treasury management and working capital optimization"
  source: "`vibe_consumer_goods_v1`.`finance`.`bank_account`"
  dimensions:
    - name: "account_type"
      expr: bank_account_type
      comment: "Type of bank account for cash segmentation"
    - name: "account_status"
      expr: bank_account_status
      comment: "Status of bank account"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency cash management"
    - name: "country_code"
      expr: country_code
      comment: "Country for geographic cash visibility"
    - name: "cash_pooling_flag"
      expr: cash_pooling_flag
      comment: "Whether account participates in cash pooling"
    - name: "primary_account_flag"
      expr: primary_account_flag
      comment: "Whether this is a primary operating account"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of bank accounts"
    - name: "total_cash_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total cash balance across all accounts, key liquidity metric"
    - name: "total_overdraft_limit"
      expr: SUM(CAST(overdraft_limit AS DOUBLE))
      comment: "Total overdraft capacity for liquidity buffer analysis"
    - name: "avg_account_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average balance per account"
    - name: "total_available_liquidity"
      expr: SUM((CAST(current_balance AS DOUBLE)) + (CAST(overdraft_limit AS DOUBLE)))
      comment: "Total available liquidity including overdraft facilities for stress testing"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics for consolidation, transfer pricing, and netting efficiency"
  source: "`vibe_consumer_goods_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for intercompany volume tracking"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly intercompany analysis"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction"
    - name: "transaction_status"
      expr: intercompany_transaction_status
      comment: "Status of intercompany transaction"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for close tracking"
    - name: "elimination_flag"
      expr: elimination_flag
      comment: "Whether transaction has been eliminated in consolidation"
    - name: "netting_eligible_flag"
      expr: netting_eligible_flag
      comment: "Whether transaction is eligible for netting"
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "Whether transaction is subject to SOX controls"
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method for tax compliance"
  measures:
    - name: "total_transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction value"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total amount in group reporting currency for consolidation"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance for close quality tracking"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average intercompany transaction size"
    - name: "elimination_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN elimination_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions eliminated, measures consolidation progress"
    - name: "netting_eligible_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN netting_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of transactions eligible for netting, indicates cash efficiency opportunity"
    - name: "reconciliation_variance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(variance_amount AS DOUBLE)) / NULLIF(SUM(CAST(transaction_amount AS DOUBLE)), 0), 2)
      comment: "Variance as percentage of transaction value, key reconciliation quality metric"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOX control effectiveness metrics for audit readiness, deficiency management, and compliance risk"
  source: "`vibe_consumer_goods_v1`.`finance`.`sox_control`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual SOX certification"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for quarterly testing cycles"
    - name: "control_type"
      expr: control_type
      comment: "Type of control (manual, automated, IT-dependent)"
    - name: "control_nature"
      expr: control_nature
      comment: "Nature of control (preventive, detective)"
    - name: "control_status"
      expr: control_status
      comment: "Current status of control"
    - name: "key_control_flag"
      expr: key_control_flag
      comment: "Whether this is a key control"
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether control is automated"
    - name: "deficiency_flag"
      expr: deficiency_flag
      comment: "Whether control has identified deficiencies"
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "Classification of deficiency (material weakness, significant deficiency)"
    - name: "process_area"
      expr: process_area
      comment: "Process area for risk-based analysis"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the control"
  measures:
    - name: "total_control_count"
      expr: COUNT(1)
      comment: "Total number of SOX controls in scope"
    - name: "key_control_count"
      expr: SUM(CASE WHEN key_control_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of key controls for audit focus"
    - name: "automated_control_count"
      expr: SUM(CASE WHEN automated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of automated controls for efficiency tracking"
    - name: "deficiency_count"
      expr: SUM(CASE WHEN deficiency_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of controls with deficiencies for remediation prioritization"
    - name: "control_effectiveness_rate_pct"
      expr: ROUND(100.0 * (COUNT(1) - SUM(CASE WHEN deficiency_flag = TRUE THEN 1 ELSE 0 END)) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls operating effectively, key audit readiness metric"
    - name: "automation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN automated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls automated, measures control efficiency"
    - name: "deficiency_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN deficiency_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls with deficiencies, key compliance risk indicator"
    - name: "key_control_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN key_control_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of controls designated as key controls"
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics for capital investment tracking, depreciation management, and asset utilization"
  source: "`vibe_consumer_goods_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for capital allocation analysis"
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category for segmentation"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of asset (active, disposed, under construction)"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity asset tracking"
  measures:
    - name: "total_asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost for capital investment tracking"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value for balance sheet reporting"
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges for asset quality assessment"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life of assets"
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per asset"
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Accumulated depreciation as percentage of acquisition cost, indicates asset age"
$$;