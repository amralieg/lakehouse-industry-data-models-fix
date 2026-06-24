-- Metric views for domain: finance | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core general ledger posting metrics tracking financial activity volume, amounts, and compliance across fiscal periods. Used by CFO and controllers to monitor posting health, reversal rates, and period-close completeness."
  source: "`vibe_manufacturing_v1`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry for period-over-period trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) within the fiscal year for granular period analysis."
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document (e.g., standard, accrual, reversal) for classification."
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status (posted, parked, blocked) to monitor close readiness."
    - name: "company_code"
      expr: company_code
      comment: "Legal entity company code for entity-level financial reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency analysis."
    - name: "business_area"
      expr: business_area
      comment: "Business area segment for sub-entity financial analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for monthly trend analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Flag indicating whether the entry is a reversal, used to track reversal volume."
    - name: "gaap_compliance_flag"
      expr: gaap_compliance_flag
      comment: "GAAP compliance flag to monitor regulatory adherence of postings."
  measures:
    - name: "total_journal_entries"
      expr: COUNT(1)
      comment: "Total number of journal entries posted. Baseline volume metric for period-close monitoring."
    - name: "total_debit_amount"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Sum of all debit amounts across journal entries. Core ledger balance metric used by controllers."
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Sum of all credit amounts across journal entries. Paired with debits to verify ledger balance."
    - name: "net_posting_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Net amount of all journal entries (debits minus credits). Indicates net financial impact per period."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount_total AS DOUBLE))
      comment: "Total tax amount posted across journal entries. Used for tax liability monitoring and reporting."
    - name: "reversal_entry_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END)
      comment: "Count of reversal journal entries. High reversal rates signal posting quality issues."
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries that are reversals. KPI for posting accuracy and close quality."
    - name: "avg_net_amount_per_entry"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net amount per journal entry. Helps detect anomalous posting sizes."
    - name: "gaap_compliant_entry_count"
      expr: COUNT(CASE WHEN gaap_compliance_flag = TRUE THEN 1 END)
      comment: "Count of GAAP-compliant journal entries. Used for audit and compliance reporting."
    - name: "gaap_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gaap_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of journal entries flagged as GAAP compliant. Critical for external audit readiness."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable invoice metrics tracking payment performance, discount capture, tax exposure, and three-way match quality. Used by AP managers and CFO to optimize working capital and supplier payment compliance."
  source: "`vibe_manufacturing_v1`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice (standard, credit memo, etc.) for classification."
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the invoice for workflow monitoring."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status (matched, unmatched, exception) for procurement compliance."
    - name: "currency"
      expr: currency
      comment: "Invoice currency for multi-currency AP analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the invoice is tax exempt, for tax liability segmentation."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of invoice date for trend analysis of AP volume."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for period-close AP analysis."
    - name: "bank_statement_reconciliation_status"
      expr: bank_statement_reconciliation_status
      comment: "Reconciliation status of the invoice against bank statement."
  measures:
    - name: "total_ap_invoices"
      expr: COUNT(1)
      comment: "Total number of AP invoices. Baseline volume metric for AP workload monitoring."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount. Core AP liability metric used by treasury and CFO."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts. Used for cash flow forecasting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices. Used for tax liability reporting."
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts captured. Measures working capital optimization effectiveness."
    - name: "total_withholding_tax_amount"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from AP invoices. Required for tax compliance reporting."
    - name: "avg_invoice_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount. Benchmarks typical invoice size for anomaly detection."
    - name: "three_way_match_failure_count"
      expr: COUNT(CASE WHEN three_way_match_status != 'MATCHED' THEN 1 END)
      comment: "Count of invoices failing three-way match. High count signals procurement or receiving issues."
    - name: "three_way_match_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status != 'MATCHED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of AP invoices failing three-way match. Key procurement compliance KPI."
    - name: "pending_approval_invoice_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('APPROVED', 'PAID') THEN 1 END)
      comment: "Count of invoices pending approval. Monitors AP bottlenecks and payment delay risk."
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid against AP invoices. Tracks actual cash outflow for treasury management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_ar_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable metrics tracking outstanding balances, aging, collection performance, and write-off exposure. Used by CFO, credit managers, and collections teams to manage cash flow and credit risk."
  source: "`vibe_manufacturing_v1`.`finance`.`ar_item`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (current, 30-60, 60-90, 90+ days) for receivables aging analysis."
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status of the AR item for collections workflow monitoring."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Dispute status of the AR item to track contested receivables."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the AR item for multi-currency receivables analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level indicating escalation stage of overdue receivables."
    - name: "cleared_flag"
      expr: cleared_flag
      comment: "Whether the AR item has been cleared/paid, for open vs. closed analysis."
    - name: "write_off_flag"
      expr: write_off_flag
      comment: "Whether the AR item has been written off, for bad debt analysis."
    - name: "credit_memo_flag"
      expr: credit_memo_flag
      comment: "Whether the item is a credit memo, for net AR calculation."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for monthly AR trend analysis."
    - name: "due_date_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month of due date for cash collection forecasting."
    - name: "segment"
      expr: segment
      comment: "Customer segment for AR analysis by customer tier or market segment."
  measures:
    - name: "total_ar_items"
      expr: COUNT(1)
      comment: "Total number of AR line items. Baseline volume metric for AR workload."
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total outstanding open AR amount. Primary KPI for cash flow and credit risk management."
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount across AR items. Measures total revenue billed."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as bad debt. Critical KPI for credit risk and loss provisioning."
    - name: "total_credit_memo_amount"
      expr: SUM(CAST(credit_memo_amount AS DOUBLE))
      comment: "Total credit memo amounts issued. Tracks revenue adjustments and customer dispute resolutions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to AR items. Measures revenue leakage from payment terms."
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(invoice_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of invoiced amount written off as bad debt. Key credit quality KPI for CFO."
    - name: "overdue_ar_item_count"
      expr: COUNT(CASE WHEN cleared_flag = FALSE AND write_off_flag = FALSE THEN 1 END)
      comment: "Count of open, non-written-off AR items. Proxy for collections workload."
    - name: "avg_open_amount_per_item"
      expr: AVG(CAST(open_amount AS DOUBLE))
      comment: "Average open amount per AR item. Benchmarks typical receivable size for risk assessment."
    - name: "disputed_ar_amount"
      expr: SUM(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'RESOLVED' THEN CAST(open_amount AS DOUBLE) ELSE 0 END)
      comment: "Total open AR amount under dispute. Measures revenue at risk from customer disputes."
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AR amount in local currency. Used for functional currency reporting and FX exposure analysis."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost center performance metrics tracking budget utilization, variance, and overhead allocation. Used by finance controllers and department heads to manage spending against budget and identify cost overruns."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_center`"
  dimensions:
    - name: "controlling_area_code"
      expr: controlling_area_code
      comment: "Controlling area for organizational cost center grouping."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level of the cost center for roll-up reporting."
    - name: "is_overhead"
      expr: is_overhead
      comment: "Whether the cost center is classified as overhead for overhead rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost center for multi-currency cost analysis."
    - name: "owner_department"
      expr: owner_department
      comment: "Owning department for departmental cost accountability."
    - name: "valid_from_year"
      expr: YEAR(valid_from)
      comment: "Year the cost center became valid for temporal cost analysis."
  measures:
    - name: "total_cost_centers"
      expr: COUNT(1)
      comment: "Total number of active cost centers. Baseline for organizational cost structure monitoring."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual costs incurred across cost centers. Primary cost management KPI."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across cost centers. Baseline for budget vs. actual analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual minus budget). Negative values indicate overspend."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed by actual costs. Core cost control KPI for department heads."
    - name: "overspend_cost_center_count"
      expr: COUNT(CASE WHEN CAST(actual_cost AS DOUBLE) > CAST(budget_amount AS DOUBLE) THEN 1 END)
      comment: "Number of cost centers exceeding their budget. Flags areas requiring management intervention."
    - name: "overhead_cost_center_count"
      expr: COUNT(CASE WHEN is_overhead = TRUE THEN 1 END)
      comment: "Count of overhead cost centers. Used to monitor overhead structure complexity."
    - name: "avg_actual_cost_per_center"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per cost center. Benchmarks cost center spending for anomaly detection."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and execution metrics tracking planned vs. committed spend, capex/opex split, and budget approval status. Used by CFO and FP&A teams for annual planning, reforecasting, and variance management."
  source: "`vibe_manufacturing_v1`.`finance`.`finance_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget for annual planning analysis."
    - name: "period"
      expr: period
      comment: "Budget period (monthly/quarterly) for granular budget tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Budget approval status to monitor planning cycle completion."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the budget for multi-currency planning."
    - name: "department_code"
      expr: department_code
      comment: "Department owning the budget for departmental spend accountability."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional budget analysis."
    - name: "is_capex"
      expr: is_capex
      comment: "Whether the budget line is capital expenditure for capex/opex split analysis."
    - name: "is_opex"
      expr: is_opex
      comment: "Whether the budget line is operational expenditure for capex/opex split analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the budget period starts for timeline analysis."
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(total_planned_amount AS DOUBLE))
      comment: "Total planned budget amount. Primary FP&A metric for resource allocation decisions."
    - name: "total_committed_amount"
      expr: SUM(CAST(total_committed_amount AS DOUBLE))
      comment: "Total committed spend against budget. Measures budget consumption before actual posting."
    - name: "total_revised_amount"
      expr: SUM(CAST(total_revised_amount AS DOUBLE))
      comment: "Total revised budget amount after reforecasting. Tracks planning agility."
    - name: "budget_commitment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_planned_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of planned budget that has been committed. Key FP&A KPI for spend velocity."
    - name: "budget_revision_variance"
      expr: SUM(CAST(total_revised_amount AS DOUBLE) - CAST(total_planned_amount AS DOUBLE))
      comment: "Total difference between revised and original planned budget. Measures reforecast magnitude."
    - name: "approved_budget_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved budget lines. Monitors planning cycle completion rate."
    - name: "budget_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of budget lines approved. Tracks planning cycle health for CFO."
    - name: "capex_planned_amount"
      expr: SUM(CASE WHEN is_capex = TRUE THEN CAST(total_planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total planned capital expenditure budget. Used for capex governance and board reporting."
    - name: "opex_planned_amount"
      expr: SUM(CASE WHEN is_opex = TRUE THEN CAST(total_planned_amount AS DOUBLE) ELSE 0 END)
      comment: "Total planned operational expenditure budget. Used for opex management and cost control."
    - name: "variance_threshold_avg_pct"
      expr: AVG(CAST(variance_threshold_percent AS DOUBLE))
      comment: "Average variance threshold percentage set across budget lines. Benchmarks tolerance levels."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset lifecycle and depreciation metrics tracking asset value, accumulated depreciation, net book value, and insurance coverage. Used by CFO, asset managers, and auditors for capital asset governance and financial reporting."
  source: "`vibe_manufacturing_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (machinery, buildings, vehicles, etc.) for asset portfolio analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method (straight-line, declining balance) for accounting policy analysis."
    - name: "fixed_asset_status"
      expr: fixed_asset_status
      comment: "Current status of the fixed asset (active, retired, disposed) for lifecycle tracking."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Whether the asset has been capitalized for capex vs. expense classification."
    - name: "plant"
      expr: plant
      comment: "Plant location of the fixed asset for site-level asset reporting."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for the asset for accountability reporting."
    - name: "acquisition_date_year"
      expr: YEAR(acquisition_date)
      comment: "Year of asset acquisition for vintage analysis and depreciation scheduling."
    - name: "asset_origin"
      expr: asset_origin
      comment: "Origin of the asset (purchased, leased, transferred) for asset sourcing analysis."
  measures:
    - name: "total_fixed_assets"
      expr: COUNT(1)
      comment: "Total number of fixed assets. Baseline for asset portfolio size monitoring."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of all fixed assets. Primary capital investment KPI for board reporting."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all assets. Measures asset aging and value erosion."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Core balance sheet metric for financial reporting."
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of assets. Used for depreciation planning and disposal decisions."
    - name: "total_replacement_cost"
      expr: SUM(CAST(replacement_cost AS DOUBLE))
      comment: "Total replacement cost of fixed assets. Used for insurance adequacy and capital planning."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage across fixed assets. Monitors insurance adequacy vs. replacement cost."
    - name: "avg_net_book_value"
      expr: AVG(CAST(net_book_value AS DOUBLE))
      comment: "Average net book value per fixed asset. Benchmarks asset value for portfolio analysis."
    - name: "depreciation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost that has been depreciated. Measures asset age and replacement urgency."
    - name: "tax_net_book_value_total"
      expr: SUM(CAST(tax_net_book_value AS DOUBLE))
      comment: "Total tax net book value of fixed assets. Used for tax depreciation reporting and deferred tax calculations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation metrics tracking allocation amounts, methods, and posting status across cost objects. Used by controlling teams and CFO to ensure accurate overhead distribution and cost transparency."
  source: "`vibe_manufacturing_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used for cost allocation (activity-based, percentage, statistical) for methodology analysis."
    - name: "allocation_category"
      expr: allocation_category
      comment: "Category of cost allocation (overhead, direct, indirect) for cost type analysis."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the allocation for period-over-period analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the allocation for monthly controlling analysis."
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the allocation (posted, pending, reversed) for close monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the allocation for multi-currency controlling."
    - name: "is_manual_allocation"
      expr: is_manual_allocation
      comment: "Whether the allocation was manually entered vs. system-generated for audit quality."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the allocation has been reversed for correction tracking."
    - name: "allocation_date_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation date for monthly cost distribution analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of cost allocation records. Baseline for allocation volume monitoring."
    - name: "total_allocation_amount"
      expr: SUM(CAST(allocation_amount AS DOUBLE))
      comment: "Total amount allocated across all cost objects. Primary overhead distribution KPI."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage across allocation rules. Benchmarks distribution ratios."
    - name: "manual_allocation_count"
      expr: COUNT(CASE WHEN is_manual_allocation = TRUE THEN 1 END)
      comment: "Count of manually entered allocations. High manual rates indicate automation gaps."
    - name: "manual_allocation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_manual_allocation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allocations that are manual. KPI for controlling process automation maturity."
    - name: "reversal_allocation_amount"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN CAST(allocation_amount AS DOUBLE) ELSE 0 END)
      comment: "Total amount of reversed allocations. Measures allocation correction volume and quality."
    - name: "posted_allocation_amount"
      expr: SUM(CASE WHEN posting_status = 'POSTED' THEN CAST(allocation_amount AS DOUBLE) ELSE 0 END)
      comment: "Total allocation amount successfully posted to the ledger. Tracks close completion."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request pipeline metrics tracking investment amounts, approval rates, ROI expectations, and budget utilization. Used by CFO, investment committee, and FP&A for capex governance and portfolio prioritization."
  source: "`vibe_manufacturing_v1`.`finance`.`capex_request`"
  dimensions:
    - name: "approval_stage"
      expr: approval_stage
      comment: "Current approval stage of the capex request for pipeline monitoring."
    - name: "request_status"
      expr: request_status
      comment: "Overall status of the capex request (submitted, approved, rejected, cancelled)."
    - name: "asset_category"
      expr: asset_category
      comment: "Category of asset being requested (machinery, IT, infrastructure) for portfolio analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the capex request for multi-currency investment analysis."
    - name: "requesting_department"
      expr: requesting_department
      comment: "Department submitting the capex request for departmental investment tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the capex request for investment prioritization."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Whether the request has been capitalized for capex vs. expense tracking."
    - name: "regulatory_approval_needed"
      expr: regulatory_approval_needed
      comment: "Whether regulatory approval is required, for compliance-driven capex tracking."
    - name: "request_date_year"
      expr: YEAR(request_date)
      comment: "Year of capex request submission for annual investment pipeline analysis."
  measures:
    - name: "total_capex_requests"
      expr: COUNT(1)
      comment: "Total number of capex requests submitted. Baseline for investment pipeline volume."
    - name: "total_estimated_amount"
      expr: SUM(CAST(estimated_amount AS DOUBLE))
      comment: "Total estimated capex investment amount. Primary KPI for investment committee and board."
    - name: "total_budget_line_item"
      expr: SUM(CAST(budget_line_item AS DOUBLE))
      comment: "Total budgeted amount for capex requests. Used for budget vs. estimate variance analysis."
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percent AS DOUBLE))
      comment: "Average expected ROI across capex requests. Key investment quality metric for CFO."
    - name: "approved_capex_amount"
      expr: SUM(CASE WHEN request_status = 'APPROVED' THEN CAST(estimated_amount AS DOUBLE) ELSE 0 END)
      comment: "Total estimated amount for approved capex requests. Measures committed capital investment."
    - name: "capex_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of capex requests approved. Measures investment governance efficiency."
    - name: "avg_estimated_amount"
      expr: AVG(CAST(estimated_amount AS DOUBLE))
      comment: "Average estimated capex amount per request. Benchmarks investment size for portfolio analysis."
    - name: "regulatory_capex_request_count"
      expr: COUNT(CASE WHEN regulatory_approval_needed = TRUE THEN 1 END)
      comment: "Count of capex requests requiring regulatory approval. Monitors compliance-driven investment complexity."
    - name: "total_tax_implications"
      expr: SUM(CAST(tax_implications AS DOUBLE))
      comment: "Total tax implications across capex requests. Used for tax planning and investment structuring."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance metrics tracking planned vs. actual profit, budget utilization, and OEE targets. Used by CFO, business unit leaders, and FP&A for P&L accountability and strategic performance management."
  source: "`vibe_manufacturing_v1`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_type"
      expr: profit_center_type
      comment: "Type of profit center (product line, geography, business unit) for portfolio analysis."
    - name: "profit_center_group"
      expr: profit_center_group
      comment: "Profit center group for hierarchical P&L roll-up reporting."
    - name: "controlling_area"
      expr: controlling_area
      comment: "Controlling area for organizational grouping of profit centers."
    - name: "region"
      expr: region
      comment: "Geographic region of the profit center for regional P&L analysis."
    - name: "segment"
      expr: segment
      comment: "Business segment for segment-level profitability reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the profit center for multi-currency P&L analysis."
    - name: "is_reportable"
      expr: is_reportable
      comment: "Whether the profit center is included in external reporting."
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Current status of the profit center (active, inactive) for portfolio management."
  measures:
    - name: "total_profit_centers"
      expr: COUNT(1)
      comment: "Total number of profit centers. Baseline for organizational P&L structure monitoring."
    - name: "total_actual_profit"
      expr: SUM(CAST(actual_profit AS DOUBLE))
      comment: "Total actual profit across all profit centers. Primary P&L KPI for executive reporting."
    - name: "total_planned_profit"
      expr: SUM(CAST(planned_profit AS DOUBLE))
      comment: "Total planned profit across profit centers. Baseline for actual vs. plan variance analysis."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to profit centers. Used for budget utilization analysis."
    - name: "profit_vs_plan_variance"
      expr: SUM(CAST(actual_profit AS DOUBLE) - CAST(planned_profit AS DOUBLE))
      comment: "Total variance between actual and planned profit. Key steering metric for CFO and business unit leaders."
    - name: "profit_plan_attainment_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_profit AS DOUBLE)) / NULLIF(SUM(CAST(planned_profit AS DOUBLE)), 0), 2)
      comment: "Percentage of planned profit achieved. Core P&L performance KPI for quarterly business reviews."
    - name: "avg_oee_target_pct"
      expr: AVG(CAST(oee_target_percent AS DOUBLE))
      comment: "Average OEE target percentage across profit centers. Links financial performance to operational efficiency."
    - name: "underperforming_profit_center_count"
      expr: COUNT(CASE WHEN CAST(actual_profit AS DOUBLE) < CAST(planned_profit AS DOUBLE) THEN 1 END)
      comment: "Count of profit centers below plan. Identifies areas requiring management intervention."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction metrics tracking transfer pricing, elimination status, and cross-entity financial flows. Used by group controllers and CFO for consolidation quality, transfer pricing compliance, and intercompany reconciliation."
  source: "`vibe_manufacturing_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction (loan, sale, service, dividend) for classification."
    - name: "transaction_subtype"
      expr: transaction_subtype
      comment: "Subtype for granular intercompany transaction categorization."
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Company code of the sending entity for intercompany flow analysis."
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Company code of the receiving entity for intercompany flow analysis."
    - name: "elimination_status"
      expr: elimination_status
      comment: "Consolidation elimination status for group reporting quality monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the intercompany transaction for governance monitoring."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction for annual intercompany analysis."
    - name: "posting_date_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of posting date for monthly intercompany volume analysis."
    - name: "transfer_pricing_method"
      expr: transfer_pricing_method
      comment: "Transfer pricing method used (arm's length, cost-plus, etc.) for compliance analysis."
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether the transaction has been reversed for correction tracking."
  measures:
    - name: "total_intercompany_transactions"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions. Baseline for consolidation workload monitoring."
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross intercompany transaction amount. Primary metric for transfer pricing and consolidation."
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net intercompany amount. Used for consolidation elimination and group P&L."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on intercompany transactions. Used for transfer pricing tax compliance."
    - name: "total_transfer_price"
      expr: SUM(CAST(transfer_price AS DOUBLE))
      comment: "Total transfer price across intercompany transactions. Core transfer pricing KPI."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage on intercompany transactions. Monitors transfer pricing policy compliance."
    - name: "uneliminated_transaction_count"
      expr: COUNT(CASE WHEN elimination_flag = FALSE THEN 1 END)
      comment: "Count of transactions not yet eliminated in consolidation. Measures consolidation close risk."
    - name: "elimination_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN elimination_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of intercompany transactions eliminated in consolidation. Key group close quality KPI."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to intercompany transactions. Used for FX exposure monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_financial_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial planning metrics tracking plan amounts, capex/opex split, revenue targets, and EBITDA goals. Used by CFO and FP&A for strategic planning cycle management, scenario analysis, and board-level financial reporting."
  source: "`vibe_manufacturing_v1`.`finance`.`financial_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of financial plan (annual budget, rolling forecast, strategic plan) for plan classification."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the financial plan for annual planning analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the financial plan for governance monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financial plan for multi-currency planning."
    - name: "scenario_name"
      expr: scenario_name
      comment: "Scenario name (base, optimistic, pessimistic) for scenario-based planning analysis."
    - name: "classification"
      expr: classification
      comment: "Classification of the financial plan for reporting hierarchy."
    - name: "is_consolidated"
      expr: is_consolidated
      comment: "Whether the plan is a consolidated group plan for entity vs. group analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the plan (draft, active, archived) for plan management."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the financial plan becomes effective for planning horizon analysis."
  measures:
    - name: "total_financial_plans"
      expr: COUNT(1)
      comment: "Total number of financial plans. Baseline for planning cycle volume monitoring."
    - name: "total_plan_amount"
      expr: SUM(CAST(total_plan_amount AS DOUBLE))
      comment: "Total financial plan amount across all plans. Primary FP&A KPI for resource allocation."
    - name: "total_revenue_plan_amount"
      expr: SUM(CAST(revenue_plan_amount AS DOUBLE))
      comment: "Total planned revenue across financial plans. Core top-line planning metric for board reporting."
    - name: "total_capex_plan_amount"
      expr: SUM(CAST(capex_plan_amount AS DOUBLE))
      comment: "Total planned capital expenditure. Used for investment governance and board capex approval."
    - name: "total_opex_plan_amount"
      expr: SUM(CAST(opex_plan_amount AS DOUBLE))
      comment: "Total planned operational expenditure. Used for cost management and efficiency planning."
    - name: "total_ebitda_target"
      expr: SUM(CAST(ebitda_target_amount AS DOUBLE))
      comment: "Total EBITDA target across financial plans. Primary profitability planning KPI for executives."
    - name: "capex_to_total_plan_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(capex_plan_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_plan_amount AS DOUBLE)), 0), 2)
      comment: "Capex as a percentage of total plan. Measures capital intensity of the financial plan."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN approval_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved financial plans. Monitors planning cycle completion."
    - name: "avg_total_plan_amount"
      expr: AVG(CAST(total_plan_amount AS DOUBLE))
      comment: "Average total plan amount per financial plan. Benchmarks planning scale."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger account portfolio metrics tracking account balances, account type distribution, and reconciliation status. Used by controllers and auditors for chart of accounts governance and balance sheet integrity."
  source: "`vibe_manufacturing_v1`.`finance`.`gl_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of GL account (asset, liability, equity, revenue, expense) for balance sheet classification."
    - name: "account_category"
      expr: account_category
      comment: "Category of GL account for financial reporting hierarchy."
    - name: "account_group"
      expr: account_group
      comment: "Account group for chart of accounts structure analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the GL account for multi-currency balance analysis."
    - name: "gl_account_status"
      expr: gl_account_status
      comment: "Current status of the GL account (active, blocked, deprecated) for account lifecycle management."
    - name: "is_reconciliation_account"
      expr: is_reconciliation_account
      comment: "Whether the account is a reconciliation account for subledger reconciliation monitoring."
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Whether the account is used for intercompany transactions for consolidation analysis."
    - name: "is_tax_relevant"
      expr: is_tax_relevant
      comment: "Whether the account is tax-relevant for tax reporting scope analysis."
    - name: "segment"
      expr: segment
      comment: "Business segment associated with the GL account for segment reporting."
  measures:
    - name: "total_gl_accounts"
      expr: COUNT(1)
      comment: "Total number of GL accounts. Baseline for chart of accounts complexity monitoring."
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all GL accounts. Core balance sheet integrity metric."
    - name: "total_opening_balance"
      expr: SUM(CAST(opening_balance AS DOUBLE))
      comment: "Total opening balance across GL accounts. Used for period-over-period balance movement analysis."
    - name: "net_balance_movement"
      expr: SUM(CAST(current_balance AS DOUBLE) - CAST(opening_balance AS DOUBLE))
      comment: "Net movement in GL account balances from opening to current. Measures period financial activity."
    - name: "deprecated_account_count"
      expr: COUNT(CASE WHEN is_deprecated = TRUE THEN 1 END)
      comment: "Count of deprecated GL accounts. Monitors chart of accounts hygiene and cleanup needs."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN gl_account_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active GL accounts. Measures operational chart of accounts size."
    - name: "reconciliation_account_count"
      expr: COUNT(CASE WHEN is_reconciliation_account = TRUE THEN 1 END)
      comment: "Count of reconciliation accounts. Used for subledger reconciliation scope planning."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per GL account. Benchmarks account balance size for anomaly detection."
$$;