-- Metric views for domain: finance | Business: Media_Broadcasting | Version: 2 | Generated on: 2026-06-22 23:42:33

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_ebitda_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive EBITDA performance dashboard tracking revenue composition, margin health, and budget/forecast variance by business segment, fiscal period, and legal entity. Primary steering metric for CFO and business unit leaders."
  source: "`vibe_media_broadcasting_v1`.`finance`.`ebitda_snapshot`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for period-over-period EBITDA trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (month/quarter) for granular EBITDA tracking."
    - name: "business_segment"
      expr: business_segment
      comment: "Business segment (e.g., linear, streaming, syndication) for segment-level P&L analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Reporting currency for multi-currency EBITDA consolidation."
    - name: "snapshot_date"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month-truncated snapshot date for time-series trending."
    - name: "covenant_compliance_flag"
      expr: covenant_compliance_flag
      comment: "Indicates whether the entity is in compliance with financial covenants — critical for debt covenant monitoring."
  measures:
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA across all snapshots. Primary profitability KPI for executive steering and investor reporting."
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total gross revenue across all revenue streams. Top-line KPI for business performance assessment."
    - name: "total_advertising_revenue"
      expr: SUM(CAST(advertising_revenue_amount AS DOUBLE))
      comment: "Total advertising revenue. Key revenue driver for linear and AVOD/FAST business models."
    - name: "total_subscription_revenue"
      expr: SUM(CAST(subscription_revenue_amount AS DOUBLE))
      comment: "Total subscription revenue. Key revenue driver for SVOD and D2C streaming businesses."
    - name: "total_syndication_revenue"
      expr: SUM(CAST(syndication_revenue_amount AS DOUBLE))
      comment: "Total syndication revenue from content licensing and distribution deals."
    - name: "total_carriage_fee_revenue"
      expr: SUM(CAST(carriage_fee_revenue_amount AS DOUBLE))
      comment: "Total carriage fee revenue from MVPD/cable affiliate agreements."
    - name: "avg_ebitda_margin_pct"
      expr: AVG(CAST(ebitda_margin_percentage AS DOUBLE))
      comment: "Average EBITDA margin percentage. Profitability efficiency metric used in investor presentations and board reviews."
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Total variance between actual and budgeted EBITDA. Negative values signal budget overruns requiring executive intervention."
    - name: "avg_budget_variance_pct"
      expr: AVG(CAST(budget_variance_percentage AS DOUBLE))
      comment: "Average percentage variance from budget. Used to assess forecast accuracy and budget discipline across business units."
    - name: "total_forecast_variance"
      expr: SUM(CAST(forecast_variance_amount AS DOUBLE))
      comment: "Total variance between actual and forecast EBITDA. Drives rolling forecast adjustments and investor guidance updates."
    - name: "total_content_acquisition_cost"
      expr: SUM(CAST(content_acquisition_cost_amount AS DOUBLE))
      comment: "Total content acquisition spend. Largest cost driver for media companies; tracked against programming budget."
    - name: "total_production_cost"
      expr: SUM(CAST(production_cost_amount AS DOUBLE))
      comment: "Total production cost. Tracks original content investment against revenue and margin targets."
    - name: "total_operating_expense"
      expr: SUM(CAST(total_operating_expense_amount AS DOUBLE))
      comment: "Total operating expenses. Used to assess cost structure and identify efficiency opportunities."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage. Measures revenue efficiency after direct costs — key for content ROI analysis."
    - name: "total_prior_period_variance"
      expr: SUM(CAST(prior_period_variance_amount AS DOUBLE))
      comment: "Total year-over-year or period-over-period EBITDA variance. Tracks business momentum and growth trajectory."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging, collection efficiency, and dispute tracking for media revenue streams. Drives cash flow management, dunning strategy, and revenue assurance decisions."
  source: "`vibe_media_broadcasting_v1`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for AR aging and collection trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AR balance and collection rate tracking."
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging bucket (current, 30/60/90+ days) for collection prioritization and credit risk assessment."
    - name: "document_currency"
      expr: document_currency
      comment: "Transaction currency for multi-currency AR exposure analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Indicates disputed invoices — used to segment clean AR from at-risk balances."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for analyzing collection patterns by payment type."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning escalation level — tracks collection effort intensity for overdue accounts."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for AR balance trend analysis."
  measures:
    - name: "total_open_ar"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open accounts receivable balance. Primary cash flow and working capital KPI for the CFO."
    - name: "total_original_ar"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original billed amount. Used to calculate collection rate and write-off exposure."
    - name: "total_local_currency_ar"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total AR balance in local currency. Used for functional currency reporting and FX exposure analysis."
    - name: "disputed_ar_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN accounts_receivable_id END)
      comment: "Number of disputed AR items. High dispute counts signal billing quality issues or customer satisfaction problems."
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN open_amount = 0 THEN original_amount ELSE 0 END) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of billed AR fully collected. Key revenue assurance KPI — low rates trigger dunning escalation."
    - name: "avg_days_past_due_count"
      expr: COUNT(CASE WHEN open_amount > 0 THEN accounts_receivable_id END)
      comment: "Count of open AR items with outstanding balances. Used to size the active collection workload."
    - name: "disputed_ar_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN open_amount ELSE 0 END)
      comment: "Total open AR amount under dispute. Tracks revenue at risk from billing disputes requiring resolution."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable liability management, payment timing, and cash outflow analysis for media production, technology, and vendor spend. Drives working capital optimization and vendor relationship management."
  source: "`vibe_media_broadcasting_v1`.`finance`.`accounts_payable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for AP liability and payment trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly AP balance and cash outflow tracking."
    - name: "document_currency"
      expr: document_currency
      comment: "Transaction currency for multi-currency AP exposure analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for analyzing AP settlement patterns."
    - name: "payment_block"
      expr: payment_block
      comment: "Payment block indicator — identifies invoices held from payment for review or dispute."
    - name: "clearing_status"
      expr: clearing_status
      comment: "AP clearing status (open, cleared, partially cleared) for liability position analysis."
    - name: "posting_date"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month-truncated posting date for AP aging and cash flow forecasting."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag — segments AP items subject to internal controls for audit and compliance reporting."
  measures:
    - name: "total_open_ap"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open accounts payable balance. Primary working capital and cash outflow KPI."
    - name: "total_gross_ap"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross AP amount before discounts and withholding. Used for vendor spend analysis."
    - name: "total_net_ap"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net AP amount after discounts. Reflects actual cash obligation to vendors."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on AP invoices. Used for tax liability reporting and VAT reconciliation."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured. Measures treasury efficiency in optimizing payment timing."
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax on AP payments. Required for tax compliance reporting to regulatory authorities."
    - name: "payment_blocked_ap_amount"
      expr: SUM(CASE WHEN payment_block IS NOT NULL AND payment_block != '' THEN open_amount ELSE 0 END)
      comment: "Total AP amount with payment blocks. Tracks invoices held from payment — high values may indicate disputes or approval bottlenecks."
    - name: "ap_invoice_count"
      expr: COUNT(1)
      comment: "Total number of AP invoice records. Used to measure AP processing volume and workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger balance and posting activity analysis for financial close, variance reporting, and EBITDA segment tracking. Core financial reporting metric view for controllers and FP&A teams."
  source: "`vibe_media_broadcasting_v1`.`finance`.`general_ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual GL balance and activity analysis."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for monthly GL close and variance analysis."
    - name: "gl_account"
      expr: gl_account
      comment: "GL account number for account-level balance and activity drill-down."
    - name: "business_area"
      expr: business_area
      comment: "Business area for segment-level P&L and balance sheet analysis."
    - name: "segment"
      expr: segment
      comment: "Reporting segment for IFRS 8 / ASC 280 segment disclosure."
    - name: "functional_currency_code"
      expr: functional_currency_code
      comment: "Functional currency for multi-currency consolidation analysis."
    - name: "ebitda_indicator"
      expr: ebitda_indicator
      comment: "Flags GL accounts that contribute to EBITDA — used to filter EBITDA-relevant postings."
    - name: "last_posting_date"
      expr: DATE_TRUNC('month', last_posting_date)
      comment: "Month-truncated last posting date for activity recency analysis."
  measures:
    - name: "total_debit_functional_currency"
      expr: SUM(CAST(debit_amount_functional_currency AS DOUBLE))
      comment: "Total debit postings in functional currency. Used for GL activity volume and balance verification."
    - name: "total_credit_functional_currency"
      expr: SUM(CAST(credit_amount_functional_currency AS DOUBLE))
      comment: "Total credit postings in functional currency. Used alongside debits for double-entry balance verification."
    - name: "total_net_balance_functional_currency"
      expr: SUM(CAST(net_balance_functional_currency AS DOUBLE))
      comment: "Total net GL balance in functional currency. Primary balance sheet and P&L balance KPI."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount_functional_currency AS DOUBLE))
      comment: "Total budgeted amount in functional currency. Used for actual-vs-budget variance analysis at GL account level."
    - name: "total_variance_functional_currency"
      expr: SUM(CAST(variance_amount_functional_currency AS DOUBLE))
      comment: "Total actual-vs-budget variance in functional currency. Negative values signal budget overruns requiring management attention."
    - name: "closing_balance_functional_currency"
      expr: SUM(CAST(closing_balance_functional_currency AS DOUBLE))
      comment: "Total closing balance in functional currency. Used for period-end financial statement preparation."
    - name: "active_gl_account_count"
      expr: COUNT(DISTINCT gl_account)
      comment: "Number of distinct GL accounts with postings. Used to assess chart of accounts utilization and rationalization opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production budget utilization, variance, and cost category analysis for original content and broadcast productions. Drives greenlight decisions, cost control interventions, and content ROI assessment."
  source: "`vibe_media_broadcasting_v1`.`finance`.`production_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual production budget planning and tracking."
    - name: "budget_status"
      expr: budget_status
      comment: "Budget status (draft, approved, locked, closed) for pipeline and approval tracking."
    - name: "budget_type"
      expr: budget_type
      comment: "Budget type (original, revised, contingency) for version-level analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Budget currency for multi-currency production cost analysis."
    - name: "production_start_date"
      expr: DATE_TRUNC('month', production_start_date)
      comment: "Month-truncated production start date for pipeline timing analysis."
    - name: "budget_version"
      expr: budget_version
      comment: "Budget version identifier for tracking revisions and approvals over the production lifecycle."
  measures:
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved production budget. Primary greenlight and content investment KPI for programming executives."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date AS DOUBLE))
      comment: "Total actual production spend to date. Tracks cash burn against approved budget."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed (contracted but not yet spent) production costs. Used for cash flow forecasting."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total budget variance (actual vs. approved). Negative values trigger cost control reviews and potential production holds."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average budget variance percentage across productions. Used to benchmark production cost discipline."
    - name: "total_above_the_line"
      expr: SUM(CAST(above_the_line_amount AS DOUBLE))
      comment: "Total above-the-line costs (talent, writers, directors). Key driver of content cost structure."
    - name: "total_below_the_line"
      expr: SUM(CAST(below_the_line_amount AS DOUBLE))
      comment: "Total below-the-line costs (crew, equipment, facilities). Tracks production execution costs."
    - name: "total_post_production_cost"
      expr: SUM(CAST(post_production_amount AS DOUBLE))
      comment: "Total post-production costs (editing, VFX, sound). Tracks finishing costs against budget."
    - name: "total_vfx_cost"
      expr: SUM(CAST(vfx_amount AS DOUBLE))
      comment: "Total VFX spend. High-growth cost category requiring dedicated tracking for tentpole productions."
    - name: "total_music_licensing_cost"
      expr: SUM(CAST(music_licensing_amount AS DOUBLE))
      comment: "Total music licensing costs. Tracks sync and master rights spend against content budget."
    - name: "total_contingency"
      expr: SUM(CAST(contingency_amount AS DOUBLE))
      comment: "Total contingency reserve. Measures risk buffer available for production overruns."
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_spend_to_date AS DOUBLE)) / NULLIF(SUM(CAST(total_approved_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget consumed. Key production control KPI — values above 90% trigger executive review."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure project tracking for broadcast facilities, technology infrastructure, and studio investments. Drives capital allocation decisions, project approval governance, and asset capitalization planning."
  source: "`vibe_media_broadcasting_v1`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "CAPEX project status (planning, approved, in-progress, completed, cancelled) for portfolio management."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class (broadcast equipment, IT infrastructure, facilities) for capital allocation analysis by asset type."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for asset lifecycle cost modeling."
    - name: "currency_code"
      expr: currency_code
      comment: "Project currency for multi-currency CAPEX portfolio analysis."
    - name: "planned_start_date"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Year-truncated planned start date for annual CAPEX pipeline planning."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag — identifies CAPEX projects subject to internal controls for audit purposes."
  measures:
    - name: "total_approved_capex_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved CAPEX budget across all projects. Primary capital allocation KPI for CFO and board."
    - name: "total_cumulative_capex_spend"
      expr: SUM(CAST(cumulative_spend_amount AS DOUBLE))
      comment: "Total cumulative CAPEX spend to date. Tracks capital deployment against approved budgets."
    - name: "total_remaining_capex_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Total remaining CAPEX budget available. Used for capital reallocation and new project approval decisions."
    - name: "capex_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_spend_amount AS DOUBLE)) / NULLIF(SUM(CAST(approved_budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of approved CAPEX budget consumed. High utilization signals need for budget supplemental requests."
    - name: "active_capex_project_count"
      expr: COUNT(CASE WHEN project_status NOT IN ('completed', 'cancelled') THEN capex_project_id END)
      comment: "Number of active CAPEX projects. Used to assess capital program complexity and governance workload."
    - name: "avg_capex_project_size"
      expr: AVG(CAST(approved_budget_amount AS DOUBLE))
      comment: "Average approved CAPEX project size. Used to benchmark investment scale and prioritize governance effort."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition event tracking for ASC 606 / IFRS 15 compliance, deferred revenue management, and revenue assurance. Critical for accurate financial reporting and audit readiness."
  source: "`vibe_media_broadcasting_v1`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual revenue recognition trend analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly revenue recognition and deferred revenue tracking."
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method (point-in-time, over-time) for ASC 606 / IFRS 15 compliance analysis."
    - name: "recognition_status"
      expr: recognition_status
      comment: "Recognition status (pending, recognized, deferred, reversed) for revenue pipeline management."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue recognition analysis."
    - name: "asc_606_compliant_flag"
      expr: asc_606_compliant_flag
      comment: "ASC 606 compliance flag — identifies non-compliant recognition events requiring remediation."
    - name: "ifrs_15_compliant_flag"
      expr: ifrs_15_compliant_flag
      comment: "IFRS 15 compliance flag — for entities reporting under IFRS standards."
    - name: "recognition_date"
      expr: DATE_TRUNC('month', recognition_date)
      comment: "Month-truncated recognition date for revenue timing analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag — identifies recognition events subject to internal controls."
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period. Primary top-line financial reporting KPI under ASC 606 / IFRS 15."
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total deferred revenue balance. Tracks future revenue obligations — key for balance sheet and cash flow analysis."
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events. Used to assess recognition processing volume and audit scope."
    - name: "non_compliant_event_count"
      expr: COUNT(CASE WHEN asc_606_compliant_flag = FALSE OR ifrs_15_compliant_flag = FALSE THEN revenue_recognition_event_id END)
      comment: "Number of non-compliant revenue recognition events. High counts signal audit risk and require immediate remediation."
    - name: "deferred_revenue_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(deferred_amount AS DOUBLE)) / NULLIF(SUM(CAST(recognized_amount AS DOUBLE)) + SUM(CAST(deferred_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of total revenue that is deferred. High ratios indicate significant future performance obligations."
    - name: "reversed_event_count"
      expr: COUNT(CASE WHEN recognition_status = 'reversed' THEN revenue_recognition_event_id END)
      comment: "Number of reversed recognition events. Reversals indicate errors or contract modifications requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_period_close`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial period close process efficiency, SOX compliance status, and consolidation health tracking. Drives close cycle time reduction, audit readiness, and regulatory filing compliance."
  source: "`vibe_media_broadcasting_v1`.`finance`.`period_close`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual close cycle benchmarking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly close performance tracking."
    - name: "period_type"
      expr: period_type
      comment: "Period type (monthly, quarterly, annual) for close complexity analysis."
    - name: "close_status"
      expr: close_status
      comment: "Close status (in-progress, completed, reopened) for close pipeline management."
    - name: "consolidation_status"
      expr: consolidation_status
      comment: "Consolidation status for group reporting readiness tracking."
    - name: "sox_control_status"
      expr: sox_control_status
      comment: "SOX control status for audit and compliance readiness assessment."
    - name: "posting_period_locked"
      expr: posting_period_locked
      comment: "Indicates whether the posting period is locked — prevents late adjustments after close."
  measures:
    - name: "avg_close_checklist_completion_pct"
      expr: AVG(CAST(close_checklist_completion_pct AS DOUBLE))
      comment: "Average close checklist completion percentage. Tracks close process progress and identifies bottlenecks."
    - name: "total_unreconciled_amount"
      expr: SUM(CAST(unreconciled_amount AS DOUBLE))
      comment: "Total unreconciled balance at period close. High values signal reconciliation gaps that delay close and create audit risk."
    - name: "total_ebitda_at_close"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA reported at period close. Used to validate EBITDA snapshot accuracy."
    - name: "total_variance_to_forecast"
      expr: SUM(CAST(variance_to_forecast_amount AS DOUBLE))
      comment: "Total variance between closed actuals and forecast. Drives forecast model recalibration."
    - name: "periods_reopened_count"
      expr: COUNT(CASE WHEN reopen_count IS NOT NULL AND reopen_count != '0' THEN period_close_id END)
      comment: "Number of periods that were reopened after initial close. Reopens indicate control failures or late adjustments."
    - name: "external_audit_required_count"
      expr: COUNT(CASE WHEN external_audit_required = TRUE THEN period_close_id END)
      comment: "Number of periods requiring external audit. Used to plan audit resource allocation and timeline."
    - name: "period_close_count"
      expr: COUNT(1)
      comment: "Total number of period close records. Used to track close cycle volume across entities and periods."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_cost_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost allocation efficiency, intercompany charge analysis, and allocation method performance for broadcast facilities and shared services. Drives cost transparency and transfer pricing governance."
  source: "`vibe_media_broadcasting_v1`.`finance`.`cost_allocation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual cost allocation analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly cost allocation tracking."
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method (headcount, revenue, usage) for methodology analysis and governance."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status (pending, posted, reversed) for allocation pipeline management."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment for segment-level cost allocation analysis."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Identifies intercompany allocations — critical for consolidation elimination and transfer pricing compliance."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for audit-relevant allocation transactions."
    - name: "allocation_run_date"
      expr: DATE_TRUNC('month', allocation_run_date)
      comment: "Month-truncated allocation run date for allocation cycle timing analysis."
  measures:
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total cost allocated across cost centers and profit centers. Primary cost transparency KPI for shared services."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage. Used to validate allocation key consistency and identify outliers."
    - name: "avg_allocation_key_value"
      expr: AVG(CAST(allocation_key_value AS DOUBLE))
      comment: "Average allocation key value (e.g., headcount, square footage). Used to validate allocation driver accuracy."
    - name: "intercompany_allocation_amount"
      expr: SUM(CASE WHEN intercompany_flag = TRUE THEN allocated_amount ELSE 0 END)
      comment: "Total intercompany cost allocations. Drives transfer pricing documentation and consolidation elimination entries."
    - name: "reversal_allocation_count"
      expr: COUNT(CASE WHEN reversal_indicator = TRUE THEN cost_allocation_id END)
      comment: "Number of reversed allocations. High reversal counts indicate allocation methodology errors requiring correction."
    - name: "allocation_transaction_count"
      expr: COUNT(1)
      comment: "Total number of cost allocation transactions. Used to assess allocation processing volume and automation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio health, depreciation tracking, and disposal analysis for broadcast facilities, transmission equipment, and technology infrastructure. Drives asset lifecycle management and capital reinvestment decisions."
  source: "`vibe_media_broadcasting_v1`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class (broadcast equipment, IT, facilities) for portfolio composition analysis."
    - name: "asset_status"
      expr: asset_status
      comment: "Asset status (active, retired, disposed) for lifecycle stage analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for asset cost modeling and tax planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Asset currency for multi-currency portfolio valuation."
    - name: "capitalization_date"
      expr: DATE_TRUNC('year', capitalization_date)
      comment: "Year-truncated capitalization date for asset vintage analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for assets subject to internal controls."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment for segment-level asset base analysis."
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total gross acquisition cost of fixed assets. Measures total capital invested in the asset base."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation. Measures asset age and remaining useful life across the portfolio."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets. Primary balance sheet asset valuation KPI."
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years. Low values signal upcoming capital reinvestment requirements."
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals. Used to assess asset monetization and capital recycling efficiency."
    - name: "total_gain_loss_on_disposal"
      expr: SUM(CAST(gain_loss_on_disposal AS DOUBLE))
      comment: "Total gain or loss on asset disposals. Impacts P&L and signals whether assets are being disposed at fair value."
    - name: "asset_depreciation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of asset cost that has been depreciated. High values indicate aging asset base requiring capital refresh."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN asset_status = 'active' THEN fixed_asset_id END)
      comment: "Number of active fixed assets. Used to size the asset management and maintenance workload."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction reconciliation, elimination status, and settlement efficiency for multi-entity media groups. Critical for consolidated financial reporting accuracy and transfer pricing compliance."
  source: "`vibe_media_broadcasting_v1`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Transaction type (content license, service charge, loan) for intercompany flow analysis."
    - name: "elimination_status"
      expr: elimination_status
      comment: "Elimination status — uneliminated intercompany transactions overstate consolidated revenue and costs."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status for identifying unmatched intercompany positions."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for cash flow and working capital analysis."
    - name: "transaction_currency"
      expr: transaction_currency
      comment: "Transaction currency for FX exposure analysis on intercompany balances."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for audit-relevant intercompany transactions."
    - name: "transaction_date"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month-truncated transaction date for intercompany flow timing analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total intercompany transaction amount. Measures the scale of intercompany flows requiring elimination in consolidation."
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total intercompany amount in group currency. Used for consolidated elimination and transfer pricing analysis."
    - name: "uneliminated_transaction_amount"
      expr: SUM(CASE WHEN elimination_flag = FALSE THEN transaction_amount ELSE 0 END)
      comment: "Total intercompany amount not yet eliminated. High values create consolidation errors and audit findings."
    - name: "unreconciled_transaction_count"
      expr: COUNT(CASE WHEN reconciliation_status != 'reconciled' THEN intercompany_transaction_id END)
      comment: "Number of unreconciled intercompany transactions. Drives period-end reconciliation workload and close risk."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to intercompany transactions. Used for FX translation analysis."
    - name: "intercompany_transaction_count"
      expr: COUNT(1)
      comment: "Total number of intercompany transactions. Used to assess intercompany complexity and automation opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset depreciation schedule analysis for fixed asset lifecycle management, impairment monitoring, and financial statement accuracy. Drives asset refresh planning and depreciation policy governance."
  source: "`vibe_media_broadcasting_v1`.`finance`.`depreciation_schedule`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual depreciation expense planning and tracking."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method for policy consistency analysis across the asset portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for multi-currency depreciation analysis."
    - name: "impairment_indicator"
      expr: impairment_indicator
      comment: "Impairment flag — identifies assets with recorded impairments requiring disclosure."
    - name: "posting_period"
      expr: posting_period
      comment: "Posting period for monthly depreciation expense tracking."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag for audit-relevant depreciation schedules."
  measures:
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_amount AS DOUBLE))
      comment: "Total annual depreciation expense. Primary P&L impact KPI for asset-heavy media businesses."
    - name: "total_planned_depreciation"
      expr: SUM(CAST(planned_depreciation_amount AS DOUBLE))
      comment: "Total planned depreciation for the period. Used for budget-to-actual depreciation variance analysis."
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation_amount AS DOUBLE))
      comment: "Total accumulated depreciation across all schedules. Measures overall asset aging in the portfolio."
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value across all depreciation schedules. Balance sheet asset valuation KPI."
    - name: "total_impairment_amount"
      expr: SUM(CAST(impairment_amount AS DOUBLE))
      comment: "Total impairment charges recorded. Impairments signal asset value deterioration requiring management disclosure."
    - name: "avg_depreciation_rate_pct"
      expr: AVG(CAST(depreciation_rate_percent AS DOUBLE))
      comment: "Average depreciation rate across the asset portfolio. Used to assess depreciation policy consistency."
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life assumption across assets. Used to benchmark depreciation policy against industry norms."
$$;

CREATE OR REPLACE VIEW `vibe_media_broadcasting_v1`.`_metrics`.`finance_financial_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial reconciliation quality, variance analysis, and SOX control compliance tracking. Drives close quality improvement, audit readiness, and internal control effectiveness assessment."
  source: "`vibe_media_broadcasting_v1`.`finance`.`financial_reconciliation`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual reconciliation quality benchmarking."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly reconciliation completion tracking."
    - name: "reconciliation_type"
      expr: reconciliation_type
      comment: "Reconciliation type (bank, intercompany, subledger) for workload and quality analysis by type."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status (open, completed, reviewed, approved) for pipeline management."
    - name: "ebitda_reporting_segment"
      expr: ebitda_reporting_segment
      comment: "EBITDA reporting segment for segment-level reconciliation quality analysis."
    - name: "sox_control_flag"
      expr: sox_control_flag
      comment: "SOX control flag — identifies reconciliations subject to internal controls."
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Identifies intercompany reconciliations — critical for consolidation accuracy."
    - name: "adjustment_required_flag"
      expr: adjustment_required_flag
      comment: "Flags reconciliations requiring adjusting journal entries — tracks remediation workload."
  measures:
    - name: "total_unreconciled_amount"
      expr: SUM(CAST(unreconciled_amount AS DOUBLE))
      comment: "Total unreconciled balance across all reconciliations. High values signal close quality issues and audit risk."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total reconciliation variance. Drives investigation and adjustment journal entry requirements."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average reconciliation variance percentage. Used to benchmark reconciliation quality against materiality thresholds."
    - name: "total_reconciled_amount"
      expr: SUM(CAST(reconciled_amount AS DOUBLE))
      comment: "Total amount successfully reconciled. Measures reconciliation throughput and close completeness."
    - name: "reconciliation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reconciliation_status = 'completed' THEN financial_reconciliation_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reconciliations completed. Key close quality KPI — low rates delay period close and increase audit risk."
    - name: "adjustment_required_count"
      expr: COUNT(CASE WHEN adjustment_required_flag = TRUE THEN financial_reconciliation_id END)
      comment: "Number of reconciliations requiring adjusting entries. High counts indicate systemic accounting errors."
$$;