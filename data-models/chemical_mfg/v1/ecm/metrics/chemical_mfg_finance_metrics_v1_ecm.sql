-- Metric views for domain: finance | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 13:07:02

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_asset_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial activity captured at the asset transaction level"
  source: "`chemical_mfg_ecm`.`finance`.`asset_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the asset involved"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset"
    - name: "posting_date"
      expr: posting_date
      comment: "Date the transaction was posted"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of asset transaction"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the transaction"
  measures:
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of asset transactions recorded"
    - name: "total_gross_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Sum of gross amounts for all asset transactions"
    - name: "total_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Sum of net amounts for all asset transactions"
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Sum of tax amounts for all asset transactions"
    - name: "average_gross_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross amount per asset transaction"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated view of general ledger journal entries"
  source: "`chemical_mfg_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "posting_date"
      expr: posting_date
      comment: "Posting date of the journal entry"
    - name: "document_type"
      expr: document_type
      comment: "Type of accounting document"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used in the journal entry"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity associated with the entry"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center linked to the entry"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the entry"
    - name: "business_unit_id"
      expr: business_unit_id
      comment: "Business unit linked to the entry"
  measures:
    - name: "journal_entry_count"
      expr: COUNT(1)
      comment: "Number of journal entries recorded"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross amounts across journal entries"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts across journal entries"
    - name: "total_local_currency_amount"
      expr: SUM(CAST(local_currency_amount AS DOUBLE))
      comment: "Sum of amounts expressed in local currency"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per journal entry"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key budgeting KPIs for financial planning"
  source: "`chemical_mfg_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget plan"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operational, capital)"
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status of the budget plan"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center the budget plan belongs to"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center the budget plan belongs to"
    - name: "scenario"
      expr: scenario
      comment: "Planning scenario (e.g., baseline, optimistic)"
    - name: "planning_period"
      expr: planning_period
      comment: "Period covered by the budget plan"
  measures:
    - name: "budget_plan_count"
      expr: COUNT(1)
      comment: "Number of budget plans"
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Sum of planned amounts across all budget plans"
    - name: "total_variance_allowed"
      expr: SUM(CAST(variance_allowed AS DOUBLE))
      comment: "Sum of variance allowances across budget plans"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure request performance metrics"
  source: "`chemical_mfg_ecm`.`finance`.`capex_request`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the CAPEX request"
    - name: "capex_classification"
      expr: capex_classification
      comment: "Classification of the CAPEX request"
    - name: "capex_request_status"
      expr: capex_request_status
      comment: "Current status of the CAPEX request"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the request"
    - name: "project_start_date"
      expr: project_start_date
      comment: "Planned start date of the CAPEX project"
    - name: "project_end_date"
      expr: project_end_date
      comment: "Planned end date of the CAPEX project"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the CAPEX amounts"
  measures:
    - name: "capex_request_count"
      expr: COUNT(1)
      comment: "Number of CAPEX requests submitted"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Sum of approved CAPEX budgets"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Sum of estimated total costs for CAPEX projects"
    - name: "total_net_capex_amount"
      expr: SUM(CAST(net_capex_amount AS DOUBLE))
      comment: "Sum of net CAPEX amounts after adjustments"
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_fx_exposure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Foreign exchange exposure risk metrics"
  source: "`chemical_mfg_ecm`.`finance`.`fx_exposure`"
  dimensions:
    - name: "exposure_type"
      expr: exposure_type
      comment: "Type of FX exposure (e.g., transaction, translation)"
    - name: "exposure_category"
      expr: exposure_category
      comment: "Category of exposure (e.g., cash, derivative)"
    - name: "currency_pair"
      expr: currency_pair
      comment: "Currency pair involved in the exposure"
    - name: "base_currency"
      expr: base_currency
      comment: "Base currency of the exposure"
    - name: "reporting_currency"
      expr: reporting_currency
      comment: "Reporting currency for the exposure"
    - name: "is_exposure_active"
      expr: is_exposure_active
      comment: "Flag indicating if the exposure is currently active"
  measures:
    - name: "fx_exposure_count"
      expr: COUNT(1)
      comment: "Number of FX exposure records"
    - name: "total_notional_amount"
      expr: SUM(CAST(notional_amount AS DOUBLE))
      comment: "Sum of notional amounts for all FX exposures"
    - name: "total_fair_value"
      expr: SUM(CAST(fair_value AS DOUBLE))
      comment: "Sum of fair values for all FX exposures"
$$;