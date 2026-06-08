-- Metric views for domain: finance | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable invoice metrics covering payment performance, discount capture, tax exposure, and working capital efficiency. Used by CFO, Treasury, and AP teams to manage cash outflows and supplier payment obligations."
  source: "`manufacturing_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, debit memo, etc.) for segmenting payables by transaction category."
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice (open, paid, partially paid, blocked) for cash flow and aging analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (ACH, wire, check, etc.) to analyze payment channel mix and associated costs."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval workflow status to identify bottlenecks in the AP approval pipeline."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of PO/GR/invoice three-way match to identify compliance and exception rates."
    - name: "currency"
      expr: currency
      comment: "Transaction currency for multi-currency payables exposure analysis."
    - name: "tax_code"
      expr: tax_code
      comment: "Tax code applied to the invoice for tax liability segmentation and compliance reporting."
    - name: "payment_block_reason"
      expr: payment_block_reason
      comment: "Reason an invoice is blocked from payment, used to identify and resolve AP bottlenecks."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for trend analysis of AP volumes and amounts over time."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the invoice is due for cash flow forecasting and payment scheduling."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month the invoice was posted to the ledger for period-close and accrual analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the invoice is tax-exempt, used for tax compliance and exemption certificate tracking."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP invoice amount including tax. Core payables exposure metric used by Treasury for cash flow planning and CFO for working capital management."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP invoice amount excluding tax. Used to measure actual vendor spend and compare against budget commitments."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across all AP invoices. Critical for tax liability reporting, VAT reclaim, and regulatory compliance."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount actually paid against AP invoices. Compared against gross amount to identify outstanding payables and payment completion rate."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts captured. Directly measures working capital optimization and the effectiveness of the AP discount capture program."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from supplier payments. Required for tax authority reporting and cross-border payment compliance."
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoices processed. Baseline volume metric for AP workload, automation rate benchmarking, and process efficiency tracking."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_reason IS NOT NULL AND payment_block_reason <> '' THEN 1 END)
      comment: "Number of invoices currently blocked from payment. High blocked invoice counts signal AP process failures, supplier disputes, or compliance issues requiring immediate intervention."
    - name: "three_way_match_exception_count"
      expr: COUNT(CASE WHEN three_way_match_status <> 'MATCHED' AND three_way_match_status IS NOT NULL THEN 1 END)
      comment: "Number of invoices failing three-way match (PO/GR/invoice). Drives procurement compliance reviews and supplier invoice accuracy improvement programs."
    - name: "avg_invoice_net_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net invoice amount per AP document. Used to benchmark invoice size trends and detect anomalous invoice patterns."
    - name: "avg_cash_discount_percentage"
      expr: AVG(CAST(cash_discount_percentage AS DOUBLE))
      comment: "Average early payment discount percentage offered by suppliers. Informs Treasury decisions on dynamic discounting and supply chain finance programs."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_ar_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable item metrics covering revenue recognition, collections performance, aging, dispute management, and write-off risk. Used by CFO, Credit & Collections, and Revenue teams to manage cash inflows and customer credit exposure."
  source: "`manufacturing_ecm`.`finance`.`ar_item`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification (current, 1-30, 31-60, 61-90, 90+ days) for receivables aging analysis and collections prioritization."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collections status of the AR item to track collections pipeline effectiveness."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the AR item for tracking disputed receivables and resolution cycle times."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the customer for channel mix analysis and payment behavior insights."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level indicating how far the collections process has progressed for overdue items."
    - name: "segment"
      expr: segment
      comment: "Customer or business segment for AR performance analysis by market segment."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency receivables exposure and FX risk analysis."
    - name: "cleared_flag"
      expr: cleared_flag
      comment: "Indicates whether the AR item has been cleared/paid, used to separate open from closed receivables."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Indicates whether the AR item has been written off as uncollectible, used for bad debt analysis."
    - name: "credit_memo_flag"
      expr: credit_memo_flag
      comment: "Indicates whether the item is a credit memo, used to separate revenue adjustments from standard invoices."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for period-over-period AR trend analysis and month-end close reporting."
    - name: "due_date_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month the AR item is due for cash flow forecasting and collections scheduling."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with the customer (Net 30, Net 60, etc.) for DSO analysis by terms bucket."
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced AR amount. Primary revenue recognition metric used by CFO and Revenue teams to track billed revenue and compare against targets."
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding open AR amount. Core working capital metric representing cash yet to be collected; drives Treasury cash flow forecasting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AR amount after discounts and adjustments. Used for net revenue reporting and margin analysis."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible bad debt. Critical risk metric for credit policy review and bad debt reserve adequacy assessment."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo value issued to customers. High credit memo volumes signal product quality, billing accuracy, or customer satisfaction issues."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts granted on AR items. Measures revenue leakage from discount programs and informs pricing policy decisions."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AR items for tax liability reporting and VAT/GST compliance."
    - name: "ar_item_count"
      expr: COUNT(1)
      comment: "Total number of AR line items. Baseline volume metric for billing workload, automation benchmarking, and collections capacity planning."
    - name: "open_item_count"
      expr: COUNT(CASE WHEN cleared_flag = False THEN 1 END)
      comment: "Number of AR items not yet cleared/paid. Drives collections workload planning and open item management."
    - name: "disputed_item_count"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status <> '' AND dispute_status <> 'RESOLVED' THEN 1 END)
      comment: "Number of AR items currently in dispute. High dispute counts indicate billing accuracy or contract compliance issues requiring escalation."
    - name: "written_off_item_count"
      expr: COUNT(CASE WHEN write_off_flag = True THEN 1 END)
      comment: "Number of AR items written off as bad debt. Tracks credit risk materialization and informs credit limit policy adjustments."
    - name: "avg_open_amount_per_item"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open AR amount per item. Used to benchmark receivables size and detect concentration risk in large open items."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Total of most recent payment amounts received. Used to track collections momentum and payment velocity in the current period."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and variance metrics covering planned vs. committed spend, budget utilization, and fiscal period performance. Used by CFO, FP&A, and Cost Center owners to manage financial targets and identify budget overruns."
  source: "`manufacturing_ecm`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning cycle analysis and year-over-year budget trend comparison."
    - name: "period"
      expr: period
      comment: "Fiscal period (month/quarter) within the budget year for intra-year budget tracking and reforecasting."
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (operating, capital, project, etc.) for segmenting budget performance by financial category."
    - name: "budget_category"
      expr: budget_category
      comment: "Budget category for grouping spend plans by business function or cost type."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status to track how much of the planned budget has been formally approved."
    - name: "is_capex"
      expr: is_capex
      comment: "Indicates capital expenditure budgets for CapEx vs. OpEx split analysis required for financial reporting."
    - name: "is_opex"
      expr: is_opex
      comment: "Indicates operating expenditure budgets for OpEx tracking and cost management."
    - name: "department_code"
      expr: department_code
      comment: "Department owning the budget for departmental budget performance reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the budget for regional financial performance analysis."
    - name: "finance_budget_status"
      expr: finance_budget_status
      comment: "Finance-side budget status for tracking budget lifecycle from draft through approved to closed."
    - name: "cost_element"
      expr: cost_element
      comment: "Cost element classification for granular spend category analysis within the budget."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the budget period begins for timeline-based budget analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary FP&A metric representing the financial plan baseline against which actuals and commitments are measured."
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed spend against budget (purchase orders, contracts, etc.). Measures budget consumption before actual cash outflow, critical for commitment accounting."
    - name: "total_revised_amount"
      expr: SUM(CAST(total_revised_amount AS DOUBLE))
      comment: "Total revised budget amount after amendments. Tracks how much the original plan has been adjusted, indicating forecast accuracy and planning discipline."
    - name: "budget_variance_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE) - CAST(total_committed_amount AS DOUBLE))
      comment: "Difference between planned and committed budget amounts. Positive variance indicates available budget headroom; negative signals overcommitment requiring CFO intervention."
    - name: "budget_revision_delta"
      expr: SUM(CAST(total_revised_amount AS DOUBLE) - CAST(total_planned_amount AS DOUBLE))
      comment: "Net change from original plan to revised budget. Large positive deltas indicate scope creep or planning inaccuracy; large negative deltas indicate cost reduction initiatives."
    - name: "budget_count"
      expr: COUNT(1)
      comment: "Total number of budget records. Used to track budget granularity and the number of active budget lines under management."
    - name: "approved_budget_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of budgets with approved status. Tracks budget approval pipeline completion, critical for period-start financial governance."
    - name: "avg_variance_threshold_percent"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance tolerance threshold set across budgets. Used by FP&A to assess how tightly budgets are governed and whether thresholds are appropriately calibrated."
    - name: "capex_planned_amount"
      expr: SUM(CASE WHEN is_capex = True THEN CAST(total_planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total planned capital expenditure budget. Required for CapEx approval governance, balance sheet planning, and depreciation forecasting."
    - name: "opex_planned_amount"
      expr: SUM(CASE WHEN is_opex = True THEN CAST(total_planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total planned operating expenditure budget. Core P&L planning metric used by CFO and business unit leaders to manage operating cost targets."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger journal entry metrics covering posting volumes, debit/credit balances, tax postings, and compliance flags. Used by Controllers, Auditors, and FP&A for period-close management, ledger integrity, and regulatory compliance."
  source: "`manufacturing_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Journal entry document type (SA, KR, DR, etc.) for classifying postings by transaction category."
    - name: "posting_status"
      expr: posting_status
      comment: "Status of the journal posting (posted, parked, reversed) for period-close completeness tracking."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for annual financial reporting and year-over-year ledger analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry for monthly close analysis and period-over-period trend reporting."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for ledger period management and cut-off analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency ledger analysis and FX translation reporting."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level P&L and balance sheet reporting."
    - name: "gaap_compliance_flag"
      expr: gaap_compliance_flag
      comment: "Indicates GAAP-compliant postings for US GAAP reporting and audit trail completeness."
    - name: "ifrs_compliance_flag"
      expr: ifrs_compliance_flag
      comment: "Indicates IFRS-compliant postings for international financial reporting and dual-ledger management."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates whether the journal entry is a reversal, used to identify accrual reversals and error corrections."
    - name: "is_adjusted"
      expr: is_adjusted
      comment: "Indicates adjusted journal entries for audit and restatement tracking."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting date for monthly ledger volume and amount trend analysis."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the journal entry for data lineage and reconciliation between sub-ledgers and the general ledger."
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Total debit postings in the general ledger. Core ledger balance metric; debit/credit equality is the fundamental double-entry accounting control."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit postings in the general ledger. Paired with total debits to verify ledger balance and detect posting errors."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of journal entries. Used for P&L and balance sheet roll-forward analysis."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount_total AS DOUBLE))
      comment: "Total tax amount posted through journal entries. Required for tax provision calculations and regulatory tax reporting."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total amount in local (functional) currency. Used for statutory reporting and local GAAP compliance where functional currency differs from transaction currency."
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline volume metric for period-close workload, automation rate tracking, and audit sampling."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = True THEN 1 END)
      comment: "Number of reversal journal entries. High reversal counts signal accrual management activity or error correction volumes requiring controller review."
    - name: "adjusted_entry_count"
      expr: COUNT(CASE WHEN is_adjusted = True THEN 1 END)
      comment: "Number of adjusted journal entries. Tracks post-close adjustments and restatement activity, a key audit quality indicator."
    - name: "non_compliant_entry_count"
      expr: COUNT(CASE WHEN gaap_compliance_flag = False OR ifrs_compliance_flag = False THEN 1 END)
      comment: "Number of journal entries flagged as non-compliant with GAAP or IFRS. Critical compliance metric; non-zero values require immediate controller investigation."
    - name: "avg_net_amount_per_entry"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per journal entry. Used to detect anomalous large postings and benchmark normal transaction sizes for fraud detection."
    - name: "debit_credit_balance"
      expr: SUM(CAST(total_debit_amount AS DOUBLE) - CAST(total_credit_amount AS DOUBLE))
      comment: "Net debit minus credit balance. Should equal zero for a balanced ledger; non-zero values indicate posting errors requiring immediate period-close remediation."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier invoice processing metrics covering invoice volumes, payment performance, three-way match compliance, tolerance variances, and tax. Used by Procurement Finance, AP, and Supply Chain teams to manage supplier payment efficiency and compliance."
  source: "`manufacturing_ecm`.`finance`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current processing status of the supplier invoice (received, approved, paid, blocked) for pipeline management."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of supplier invoice (standard, credit memo, debit memo) for payables categorization."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the supplier invoice for cash outflow tracking and supplier relationship management."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (matched, exception, pending) for procurement compliance and exception management."
    - name: "tolerance_check_status"
      expr: tolerance_check_status
      comment: "Result of tolerance variance check against PO price for invoice accuracy and overpayment prevention."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the supplier invoice for payment channel analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the supplier invoice for DPO analysis and early payment discount opportunity identification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the supplier invoice for annual spend analysis and budget reconciliation."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly supplier spend tracking and accrual management."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency supplier spend analysis and FX exposure management."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the invoice for spend governance and category management."
    - name: "payment_block_indicator"
      expr: payment_block_indicator
      comment: "Indicates whether the invoice is blocked from payment, used to track AP bottlenecks and resolution urgency."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for supplier spend trend analysis."
  measures:
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross supplier invoice amount. Primary procurement spend metric used by CPO and CFO to track total supplier expenditure against budget."
    - name: "total_net_invoice_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net supplier invoice amount after discounts. Used for net spend reporting and supplier contract value tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on supplier invoices for input tax recovery, VAT compliance, and tax provision calculations."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts captured on supplier invoices. Measures procurement savings from negotiated discounts and early payment programs."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight and logistics costs on supplier invoices. Used to track landed cost and identify freight cost reduction opportunities."
    - name: "total_tolerance_variance_amount"
      expr: SUM(CAST(tolerance_variance_amount AS DOUBLE))
      comment: "Total monetary variance between invoiced and PO amounts. High tolerance variances indicate supplier pricing non-compliance or PO management issues."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on supplier invoices for tax authority remittance and cross-border payment compliance."
    - name: "supplier_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices processed. Baseline volume metric for AP workload, straight-through processing rate, and automation benchmarking."
    - name: "three_way_match_exception_count"
      expr: COUNT(CASE WHEN three_way_match_status <> 'MATCHED' AND three_way_match_status IS NOT NULL THEN 1 END)
      comment: "Number of supplier invoices failing three-way match. Drives procurement compliance reviews and supplier invoice accuracy improvement initiatives."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN payment_block_indicator = True THEN 1 END)
      comment: "Number of supplier invoices blocked from payment. Blocked invoices delay supplier payments, risk relationship damage, and indicate process failures."
    - name: "avg_tolerance_variance_percentage"
      expr: AVG(CAST(tolerance_variance_percentage AS DOUBLE))
      comment: "Average percentage variance between invoiced and PO amounts. Used to calibrate tolerance thresholds and identify suppliers with systematic pricing deviations."
    - name: "avg_net_invoice_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net supplier invoice amount. Used to benchmark invoice size, detect anomalous invoices, and assess supplier billing patterns."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset metrics covering asset base value, depreciation, net book value, insurance coverage, and asset lifecycle management. Used by CFO, Controllers, and Plant Finance to manage capital asset portfolios and depreciation schedules."
  source: "`manufacturing_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (machinery, buildings, vehicles, IT equipment, etc.) for capital asset portfolio segmentation and depreciation policy management."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (straight-line, declining balance, units of production) for depreciation policy analysis and tax optimization."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Current status of the fixed asset (active, retired, under maintenance, disposed) for asset lifecycle management."
    - name: "asset_origin"
      expr: asset_origin
      comment: "Origin of the asset (purchased, leased, internally constructed) for CapEx vs. lease accounting analysis."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Indicates whether the asset has been capitalized, used to track CapEx activation and WIP-to-asset conversion."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Physical condition rating of the asset for maintenance planning and replacement investment prioritization."
    - name: "plant"
      expr: plant
      comment: "Manufacturing plant where the asset is located for plant-level asset base and depreciation analysis."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for the asset for departmental asset accountability and maintenance cost allocation."
    - name: "acquisition_date_year"
      expr: DATE_TRUNC('YEAR', acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and capital investment trend reporting."
    - name: "useful_life_years"
      expr: useful_life_years
      comment: "Useful life classification of the asset for depreciation schedule management and asset replacement planning."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of fixed assets. Primary CapEx portfolio metric used by CFO and Board to assess total capital invested in productive assets."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (acquisition cost minus accumulated depreciation). Core balance sheet metric for asset valuation and financial reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across the asset base. Measures asset age and remaining useful life at portfolio level; high ratios signal need for capital refresh investment."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total estimated replacement cost of fixed assets. Used for insurance adequacy assessment and long-term capital expenditure planning."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage value across fixed assets. Compared against replacement cost to identify under-insured assets and manage risk exposure."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage/residual value of fixed assets at end of useful life. Used in depreciation calculations and asset disposal planning."
    - name: "total_tax_net_book_value"
      expr: SUM(CAST(tax_net_book_value AS DOUBLE))
      comment: "Total tax net book value of fixed assets. Required for deferred tax calculations and tax depreciation reporting to tax authorities."
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Total number of fixed assets in the register. Baseline metric for asset base size, maintenance workload planning, and asset management system completeness."
    - name: "capitalized_asset_count"
      expr: COUNT(CASE WHEN capitalized_flag = True THEN 1 END)
      comment: "Number of capitalized fixed assets. Tracks CapEx activation rate and WIP-to-asset conversion completeness for period-close."
    - name: "avg_net_book_value_per_asset"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Used to benchmark asset value by class and identify high-value assets requiring enhanced controls."
    - name: "depreciation_coverage_ratio"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0)
      comment: "Ratio of accumulated depreciation to acquisition cost (0-1 scale). Measures average asset age/consumption across the portfolio; values approaching 1.0 signal urgent capital refresh needs."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics covering actual vs. planned profitability, budget utilization, and OEE targets. Used by CFO, Business Unit leaders, and Controllers to manage P&L accountability at the profit center level."
  source: "`manufacturing_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (production, sales, service, etc.) for P&L segmentation by business function."
    - name: "profit_center_group"
      expr: profit_center_group
      comment: "Profit center group for hierarchical P&L roll-up and management reporting."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Status of the profit center (active, inactive, closed) for filtering active P&L entities."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level P&L reporting required by IFRS 8 and management reporting."
    - name: "region"
      expr: region
      comment: "Geographic region of the profit center for regional P&L performance analysis."
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area for management accounting hierarchy and internal reporting structure."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Indicates whether the profit center is included in external financial reporting for segment disclosure compliance."
    - name: "financial_reporting_line"
      expr: financial_reporting_line
      comment: "Financial reporting line mapping for P&L statement structure and management reporting alignment."
    - name: "valid_from_year"
      expr: DATE_TRUNC('YEAR', valid_from)
      comment: "Year the profit center became valid for lifecycle and organizational change analysis."
  measures:
    - name: "total_actual_profit"
      expr: SUM(CAST(actual_profit AS DOUBLE))
      comment: "Total actual profit across profit centers. Primary P&L performance metric used by CFO and Business Unit leaders to assess financial results against plan."
    - name: "total_planned_profit"
      expr: SUM(CAST(planned_profit AS DOUBLE))
      comment: "Total planned/budgeted profit across profit centers. Baseline for variance analysis and performance accountability."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to profit centers. Used for budget utilization tracking and resource allocation decisions."
    - name: "profit_variance_amount"
      expr: SUM(CAST(actual_profit AS DOUBLE) - CAST(planned_profit AS DOUBLE))
      comment: "Actual profit minus planned profit. Positive variance indicates outperformance; negative variance triggers management investigation and corrective action."
    - name: "profit_center_count"
      expr: COUNT(1)
      comment: "Total number of profit centers. Used to track organizational complexity and P&L accountability structure."
    - name: "active_profit_center_count"
      expr: COUNT(CASE WHEN profit_center_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active profit centers. Tracks the active P&L reporting structure and organizational footprint."
    - name: "avg_oee_target_percent"
      expr: AVG(CAST(oee_target_percent AS DOUBLE))
      comment: "Average OEE (Overall Equipment Effectiveness) target across profit centers. Links financial performance targets to operational efficiency goals in manufacturing."
    - name: "profit_achievement_rate"
      expr: SUM(CAST(actual_profit AS DOUBLE)) / NULLIF(SUM(CAST(planned_profit AS DOUBLE)), 0)
      comment: "Ratio of actual to planned profit (>1 = outperformance, <1 = underperformance). Core KPI for profit center performance reviews and incentive compensation calculations."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`finance_procurement_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement contract metrics covering contract value, release consumption, remaining value, and contract compliance. Used by CPO, Procurement Finance, and Legal to manage supplier contract portfolios and spend under contract."
  source: "`manufacturing_ecm`.`finance`.`procurement_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of procurement contract (blanket order, framework agreement, spot buy, etc.) for contract portfolio segmentation."
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the procurement contract (active, expired, terminated, draft) for contract lifecycle management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the contract for regulatory and policy adherence tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend under contract analysis."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization responsible for the contract for spend governance and category management."
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group managing the contract for buyer-level performance analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates contracts set to auto-renew, used to manage contract renewal risk and avoid unintended commitments."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the contract became effective for contract vintage and portfolio age analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract expires for renewal pipeline management and contract coverage continuity planning."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all procurement contracts. Primary spend-under-contract metric used by CPO to measure procurement leverage and negotiation coverage."
    - name: "total_release_value"
      expr: SUM(CAST(release_value AS DOUBLE))
      comment: "Total value released/consumed against procurement contracts. Measures actual spend drawdown against contracted commitments."
    - name: "total_remaining_value"
      expr: SUM(CAST(remaining_value AS DOUBLE))
      comment: "Total remaining uncommitted value on procurement contracts. Tracks available contract capacity and identifies underutilized contracts."
    - name: "total_release_quantity"
      expr: SUM(CAST(release_quantity AS DOUBLE))
      comment: "Total quantity released against procurement contracts. Used for volume commitment tracking and minimum order quantity compliance."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining quantity available on procurement contracts. Informs procurement planning and supplier capacity allocation decisions."
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Total number of procurement contracts. Baseline metric for contract portfolio size and procurement governance complexity."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active procurement contracts. Tracks the live contract portfolio providing spend coverage and supplier commitments."
    - name: "contract_consumption_rate"
      expr: SUM(CAST(release_value AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0)
      comment: "Ratio of released value to total contract value. Measures contract utilization efficiency; low rates indicate underutilized contracts or maverick spend outside contracts."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average procurement contract value. Used to benchmark contract size, identify strategic vs. tactical contracts, and prioritize contract management resources."
$$;