-- Metric views for domain: finance | Business: Sports Entertainment | Version: 1 | Generated on: 2026-05-09 01:35:39

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable revenue and collection performance metrics"
  source: "`sports_entertainment_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AR invoice (e.g., standard, credit memo, debit memo)"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the invoice"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category classification for the invoice"
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Status of revenue recognition for the invoice"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_date)
      comment: "Month when the invoice was billed"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the invoice was posted to the ledger"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the invoice"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Indicates if this is an intercompany transaction"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts and taxes"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount actually paid by customers"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount given to customers"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred for future recognition"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off as uncollectible"
    - name: "invoice_count"
      expr: COUNT(ar_invoice_id)
      comment: "Total number of AR invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount"
    - name: "collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net invoice amount collected"
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage discount given relative to gross amount"
    - name: "write_off_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of net amount written off as bad debt"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable spend and payment efficiency metrics"
  source: "`sports_entertainment_ecm`.`finance`.`ap_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the AP invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the invoice"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Type of AP invoice"
    - name: "expense_category"
      expr: expense_category
      comment: "Category of expense for the invoice"
    - name: "vendor_category"
      expr: vendor_category
      comment: "Category of vendor"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Status of three-way match (PO, receipt, invoice)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when the invoice was issued"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the invoice was posted"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates if this is a recurring invoice"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoice amount before discounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoice amount after discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax amount"
    - name: "invoice_count"
      expr: COUNT(ap_invoice_id)
      comment: "Total number of AP invoices"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross invoice amount"
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of available discounts captured"
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tax_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_amount AS DOUBLE)), 0), 2)
      comment: "Effective tax rate on net invoice amounts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning, variance, and forecast accuracy metrics"
  source: "`sports_entertainment_ecm`.`finance`.`budget`"
  dimensions:
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital, project)"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the budget"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Budget scenario type (e.g., base, optimistic, pessimistic)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of plan (e.g., annual, quarterly, rolling)"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area of the budget"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the budget"
    - name: "period_granularity"
      expr: period_granularity
      comment: "Granularity of budget periods (e.g., monthly, quarterly)"
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Indicates if this is an intercompany budget"
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total planned budget amount"
    - name: "total_revised_amount"
      expr: SUM(CAST(revised_amount AS DOUBLE))
      comment: "Total revised budget amount after adjustments"
    - name: "total_actuals_amount"
      expr: SUM(CAST(actuals_amount AS DOUBLE))
      comment: "Total actual spend against budget"
    - name: "total_forecast_amount"
      expr: SUM(CAST(forecast_amount AS DOUBLE))
      comment: "Total forecasted amount"
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total committed amount (encumbered funds)"
    - name: "budget_count"
      expr: COUNT(budget_id)
      comment: "Total number of budget line items"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(actuals_amount AS DOUBLE)) / NULLIF(SUM(CAST(revised_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of revised budget utilized by actuals"
    - name: "forecast_accuracy_pct"
      expr: ROUND(100.0 * (1.0 - ABS(SUM(CAST(forecast_amount AS DOUBLE)) - SUM(CAST(actuals_amount AS DOUBLE))) / NULLIF(SUM(CAST(actuals_amount AS DOUBLE)), 0)), 2)
      comment: "Forecast accuracy as percentage (100% = perfect forecast)"
    - name: "budget_variance_amount"
      expr: SUM((CAST(revised_amount AS DOUBLE)) - (CAST(actuals_amount AS DOUBLE)))
      comment: "Total budget variance (revised minus actuals)"
    - name: "commitment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_amount AS DOUBLE)) / NULLIF(SUM(CAST(revised_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of revised budget committed"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_cash_flow_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash flow forecasting accuracy and liquidity planning metrics"
  source: "`sports_entertainment_ecm`.`finance`.`cash_flow_forecast`"
  dimensions:
    - name: "cash_flow_category"
      expr: cash_flow_category
      comment: "Category of cash flow (e.g., operating, investing, financing)"
    - name: "cash_flow_type"
      expr: cash_flow_type
      comment: "Type of cash flow (inflow or outflow)"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., short-term, long-term)"
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the forecast"
    - name: "scenario_type"
      expr: scenario_type
      comment: "Scenario type (e.g., base, best, worst)"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit for the forecast"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates if this is a recurring cash flow"
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Indicates if this is an intercompany cash flow"
    - name: "period_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month of the forecast period"
  measures:
    - name: "total_projected_amount"
      expr: SUM(CAST(projected_amount AS DOUBLE))
      comment: "Total projected cash flow amount"
    - name: "total_actual_amount"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Total actual cash flow amount"
    - name: "total_revised_projected_amount"
      expr: SUM(CAST(revised_projected_amount AS DOUBLE))
      comment: "Total revised projected cash flow amount"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance between projected and actual"
    - name: "forecast_count"
      expr: COUNT(cash_flow_forecast_id)
      comment: "Total number of cash flow forecast items"
    - name: "weighted_avg_probability"
      expr: AVG(CAST(probability_pct AS DOUBLE))
      comment: "Average probability percentage across forecasts"
    - name: "forecast_accuracy_pct"
      expr: ROUND(100.0 * (1.0 - ABS(SUM(CAST(projected_amount AS DOUBLE)) - SUM(CAST(actual_amount AS DOUBLE))) / NULLIF(ABS(SUM(CAST(actual_amount AS DOUBLE))), 0)), 2)
      comment: "Cash flow forecast accuracy percentage"
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across forecasts"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger posting volume, accuracy, and SOX compliance metrics"
  source: "`sports_entertainment_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "document_type"
      expr: document_type
      comment: "Type of journal entry document"
    - name: "posting_status"
      expr: posting_status
      comment: "Posting status of the journal entry"
    - name: "sox_approval_status"
      expr: sox_approval_status
      comment: "SOX approval status for the entry"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category if applicable"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area of the entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Indicates if this is an intercompany entry"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Indicates if this is a reversal entry"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month when the entry was posted"
    - name: "document_month"
      expr: DATE_TRUNC('MONTH', document_date)
      comment: "Month of the document date"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total transaction amount across all entries"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Total amount in local currency"
    - name: "total_group_currency_amount"
      expr: SUM(CAST(group_currency_amount AS DOUBLE))
      comment: "Total amount in group reporting currency"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal entries"
    - name: "journal_entry_count"
      expr: COUNT(journal_entry_id)
      comment: "Total number of journal entries"
    - name: "avg_entry_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average transaction amount per journal entry"
    - name: "reversal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reversal_indicator = TRUE THEN 1 END) / NULLIF(COUNT(journal_entry_id), 0), 2)
      comment: "Percentage of journal entries that are reversals"
    - name: "sox_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sox_approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(journal_entry_id), 0), 2)
      comment: "Percentage of entries with SOX approval"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_recurring_revenue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Annual recurring revenue (ARR), monthly recurring revenue (MRR), and subscription growth metrics"
  source: "`sports_entertainment_ecm`.`finance`.`recurring_revenue`"
  dimensions:
    - name: "arr_component_type"
      expr: arr_component_type
      comment: "Type of ARR component (e.g., new, expansion, contraction, churn)"
    - name: "contract_status"
      expr: contract_status
      comment: "Status of the recurring revenue contract"
    - name: "product_tier"
      expr: product_tier
      comment: "Product tier or subscription level"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing (e.g., monthly, annual)"
    - name: "distribution_channel"
      expr: distribution_channel
      comment: "Channel through which the subscription was sold"
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market for the subscription"
    - name: "churn_reason_category"
      expr: churn_reason_category
      comment: "Category of churn reason if applicable"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates if the subscription auto-renews"
    - name: "multi_year_deal_flag"
      expr: multi_year_deal_flag
      comment: "Indicates if this is a multi-year deal"
    - name: "reporting_month"
      expr: DATE_TRUNC('MONTH', reporting_period_start)
      comment: "Month of the reporting period"
  measures:
    - name: "total_arr"
      expr: SUM(CAST(arr_amount AS DOUBLE))
      comment: "Total annual recurring revenue"
    - name: "total_mrr"
      expr: SUM(CAST(mrr_amount AS DOUBLE))
      comment: "Total monthly recurring revenue"
    - name: "total_contracted_arr"
      expr: SUM(CAST(contracted_arr_amount AS DOUBLE))
      comment: "Total contracted ARR (committed future revenue)"
    - name: "total_expansion_arr"
      expr: SUM(CAST(expansion_amount AS DOUBLE))
      comment: "Total ARR from expansions (upsells, cross-sells)"
    - name: "total_contraction_arr"
      expr: SUM(CAST(contraction_amount AS DOUBLE))
      comment: "Total ARR lost from contractions (downgrades)"
    - name: "total_churn_arr"
      expr: SUM(CAST(churn_amount AS DOUBLE))
      comment: "Total ARR lost from customer churn"
    - name: "net_arr_movement"
      expr: SUM(CAST(net_arr_movement AS DOUBLE))
      comment: "Net ARR movement (expansion minus contraction minus churn)"
    - name: "total_arpu"
      expr: SUM(CAST(arpu_amount AS DOUBLE))
      comment: "Total average revenue per user"
    - name: "subscriber_count"
      expr: SUM(CAST(subscriber_count AS BIGINT))
      comment: "Total number of active subscribers"
    - name: "new_subscriber_count"
      expr: SUM(CAST(new_subscriber_count AS BIGINT))
      comment: "Total number of new subscribers added"
    - name: "churned_subscriber_count"
      expr: SUM(CAST(churned_subscriber_count AS BIGINT))
      comment: "Total number of subscribers churned"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu_amount AS DOUBLE))
      comment: "Average revenue per user across all subscriptions"
    - name: "churn_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(churn_amount AS DOUBLE)) / NULLIF(SUM(CAST(arr_amount AS DOUBLE)), 0), 2)
      comment: "ARR churn rate as percentage of total ARR"
    - name: "expansion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(expansion_amount AS DOUBLE)) / NULLIF(SUM(CAST(arr_amount AS DOUBLE)), 0), 2)
      comment: "ARR expansion rate as percentage of total ARR"
    - name: "net_revenue_retention_pct"
      expr: ROUND(100.0 * (1.0 + SUM(CAST(net_arr_movement AS DOUBLE)) / NULLIF(SUM(CAST(arr_amount AS DOUBLE)), 0)), 2)
      comment: "Net revenue retention rate (100% + net ARR movement rate)"
    - name: "avg_contract_term_years"
      expr: AVG(CAST(contract_term_years AS DOUBLE))
      comment: "Average contract term in years"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_revenue_recognition_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition compliance, deferred revenue, and performance obligation metrics"
  source: "`sports_entertainment_ecm`.`finance`.`revenue_recognition_schedule`"
  dimensions:
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition (e.g., straight-line, milestone)"
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract"
    - name: "accounting_standard"
      expr: accounting_standard
      comment: "Accounting standard applied (e.g., ASC 606, IFRS 15)"
    - name: "recognition_basis"
      expr: recognition_basis
      comment: "Basis for revenue recognition (e.g., time, performance)"
    - name: "modification_flag"
      expr: modification_flag
      comment: "Indicates if the schedule has been modified"
    - name: "variable_consideration_flag"
      expr: variable_consideration_flag
      comment: "Indicates if variable consideration is present"
    - name: "significant_financing_flag"
      expr: significant_financing_flag
      comment: "Indicates if significant financing component exists"
    - name: "constraint_applied_flag"
      expr: constraint_applied_flag
      comment: "Indicates if constraint was applied to variable consideration"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_start_date)
      comment: "Month when revenue recognition started"
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all schedules"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_balance AS DOUBLE))
      comment: "Total deferred revenue balance"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(cumulative_recognized_amount AS DOUBLE))
      comment: "Total cumulative recognized revenue"
    - name: "current_period_recognition"
      expr: SUM(CAST(current_period_recognition_amount AS DOUBLE))
      comment: "Total revenue recognized in current period"
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration amount"
    - name: "schedule_count"
      expr: COUNT(revenue_recognition_schedule_id)
      comment: "Total number of revenue recognition schedules"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per schedule"
    - name: "recognition_completion_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_recognized_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total contract value recognized"
    - name: "deferred_revenue_ratio"
      expr: ROUND(SUM(CAST(deferred_revenue_balance AS DOUBLE)) / NULLIF(SUM(CAST(total_contract_value AS DOUBLE)), 0), 2)
      comment: "Ratio of deferred revenue to total contract value"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset utilization, depreciation efficiency, and capital expenditure metrics"
  source: "`sports_entertainment_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the fixed asset"
    - name: "asset_class_name"
      expr: asset_class_name
      comment: "Asset class name"
    - name: "depreciation_method_code"
      expr: depreciation_method_code
      comment: "Depreciation method applied"
    - name: "is_fully_depreciated"
      expr: is_fully_depreciated
      comment: "Indicates if the asset is fully depreciated"
    - name: "is_leased"
      expr: is_leased
      comment: "Indicates if the asset is leased"
    - name: "disposal_type"
      expr: disposal_type
      comment: "Type of disposal if applicable"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year when the asset was acquired"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year when the asset was placed in service"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of fixed assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_annual_depreciation"
      expr: SUM(CAST(annual_depreciation_charge AS DOUBLE))
      comment: "Total annual depreciation charge"
    - name: "total_impairment_loss"
      expr: SUM(CAST(impairment_loss AS DOUBLE))
      comment: "Total impairment loss recognized"
    - name: "total_disposal_proceeds"
      expr: SUM(CAST(disposal_proceeds AS DOUBLE))
      comment: "Total proceeds from asset disposals"
    - name: "total_revaluation_amount"
      expr: SUM(CAST(revaluation_amount AS DOUBLE))
      comment: "Total revaluation amount"
    - name: "asset_count"
      expr: COUNT(fixed_asset_id)
      comment: "Total number of fixed assets"
    - name: "avg_asset_age_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years"
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost depreciated"
    - name: "asset_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(net_book_value AS DOUBLE)) / NULLIF(SUM(CAST(acquisition_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of acquisition cost remaining as net book value"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit center performance, budget adherence, and EBITDA margin metrics"
  source: "`sports_entertainment_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "profit_center_status"
      expr: profit_center_status
      comment: "Status of the profit center"
    - name: "business_unit_type"
      expr: business_unit_type
      comment: "Type of business unit"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category for the profit center"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "segment_code"
      expr: segment_code
      comment: "Business segment code"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Indicates if intercompany transactions are involved"
    - name: "arr_tracking_flag"
      expr: arr_tracking_flag
      comment: "Indicates if ARR is tracked for this profit center"
    - name: "nil_revenue_eligible"
      expr: nil_revenue_eligible
      comment: "Indicates if eligible for NIL revenue"
    - name: "sox_risk_rating"
      expr: sox_risk_rating
      comment: "SOX risk rating for the profit center"
  measures:
    - name: "total_revenue_budget"
      expr: SUM(CAST(annual_revenue_budget AS DOUBLE))
      comment: "Total annual revenue budget across profit centers"
    - name: "total_opex_budget"
      expr: SUM(CAST(annual_opex_budget AS DOUBLE))
      comment: "Total annual operating expense budget"
    - name: "total_capex_budget"
      expr: SUM(CAST(annual_capex_budget AS DOUBLE))
      comment: "Total annual capital expenditure budget"
    - name: "profit_center_count"
      expr: COUNT(profit_center_id)
      comment: "Total number of profit centers"
    - name: "avg_target_ebitda_margin"
      expr: AVG(CAST(target_ebitda_margin_pct AS DOUBLE))
      comment: "Average target EBITDA margin percentage"
    - name: "budgeted_ebitda"
      expr: SUM((CAST(annual_revenue_budget AS DOUBLE)) - (CAST(annual_opex_budget AS DOUBLE)))
      comment: "Total budgeted EBITDA (revenue budget minus opex budget)"
    - name: "budgeted_ebitda_margin_pct"
      expr: ROUND(100.0 * (SUM(CAST(annual_revenue_budget AS DOUBLE)) - SUM(CAST(annual_opex_budget AS DOUBLE))) / NULLIF(SUM(CAST(annual_revenue_budget AS DOUBLE)), 0), 2)
      comment: "Budgeted EBITDA margin as percentage of revenue budget"
$$;

CREATE OR REPLACE VIEW `sports_entertainment_ecm`.`_metrics`.`finance_sox_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOX control effectiveness, testing coverage, and remediation metrics"
  source: "`sports_entertainment_ecm`.`finance`.`sox_control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current status of the SOX control"
    - name: "control_type"
      expr: control_type
      comment: "Type of SOX control (e.g., preventive, detective)"
    - name: "control_category"
      expr: control_category
      comment: "Category of the control"
    - name: "financial_process_area"
      expr: financial_process_area
      comment: "Financial process area covered by the control"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the control"
    - name: "is_key_control"
      expr: is_key_control
      comment: "Indicates if this is a key control"
    - name: "test_result"
      expr: test_result
      comment: "Result of the most recent control test"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation if deficiency exists"
    - name: "deficiency_classification"
      expr: deficiency_classification
      comment: "Classification of any identified deficiency"
    - name: "control_frequency"
      expr: control_frequency
      comment: "Frequency of control execution"
    - name: "testing_frequency"
      expr: testing_frequency
      comment: "Frequency of control testing"
    - name: "segregation_of_duties_flag"
      expr: segregation_of_duties_flag
      comment: "Indicates if segregation of duties is required"
  measures:
    - name: "control_count"
      expr: COUNT(sox_control_id)
      comment: "Total number of SOX controls"
    - name: "key_control_count"
      expr: COUNT(CASE WHEN is_key_control = TRUE THEN 1 END)
      comment: "Total number of key controls"
    - name: "effective_control_count"
      expr: COUNT(CASE WHEN test_result = 'Effective' THEN 1 END)
      comment: "Number of controls tested as effective"
    - name: "deficient_control_count"
      expr: COUNT(CASE WHEN deficiency_classification IS NOT NULL THEN 1 END)
      comment: "Number of controls with identified deficiencies"
    - name: "control_effectiveness_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'Effective' THEN 1 END) / NULLIF(COUNT(sox_control_id), 0), 2)
      comment: "Percentage of controls tested as effective"
    - name: "key_control_effectiveness_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_key_control = TRUE AND test_result = 'Effective' THEN 1 END) / NULLIF(COUNT(CASE WHEN is_key_control = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of key controls tested as effective"
    - name: "deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deficiency_classification IS NOT NULL THEN 1 END) / NULLIF(COUNT(sox_control_id), 0), 2)
      comment: "Percentage of controls with deficiencies"
    - name: "remediation_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remediation_status = 'Completed' THEN 1 END) / NULLIF(COUNT(CASE WHEN deficiency_classification IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deficiencies remediated"
$$;