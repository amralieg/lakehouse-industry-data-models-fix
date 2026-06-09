-- Metric views for domain: ledger | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial posting activity and volume"
  source: "`banking_ecm`.`ledger`.`journal_entry`"
  dimensions:
    - name: "accounting_month"
      expr: DATE_TRUNC('month', accounting_date)
      comment: "Month of the accounting date"
    - name: "posting_status"
      expr: posting_status
      comment: "Current posting status of the journal entry"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the journal entry"
    - name: "intercompany_indicator"
      expr: intercompany_indicator
      comment: "Flag indicating intercompany transaction"
    - name: "journal_category"
      expr: journal_category
      comment: "Category of the journal entry"
  measures:
    - name: "total_credit_amount_sum"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Sum of all journal entry credit amounts"
    - name: "total_debit_amount_sum"
      expr: SUM(CAST(total_debit_amount AS DOUBLE))
      comment: "Sum of all journal entry debit amounts"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of journal entries"
    - name: "adjustment_entry_count"
      expr: SUM(CASE WHEN adjustment_indicator THEN 1 ELSE 0 END)
      comment: "Count of journal entries marked as adjustments"
    - name: "average_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate used in journal entries"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_trial_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Snapshot of balances and period activity per accounting period"
  source: "`banking_ecm`.`ledger`.`trial_balance`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Identifier of the accounting period"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity for the balance"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "General ledger account"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the balances"
    - name: "set_id"
      expr: set_id
      comment: "Ledger set identifier"
    - name: "balance_status"
      expr: balance_status
      comment: "Status of the balance (e.g., verified, provisional)"
    - name: "balance_type"
      expr: balance_type
      comment: "Type of balance (e.g., actual, adjusted)"
    - name: "intercompany_flag"
      expr: intercompany_flag
      comment: "Indicates if the balance includes intercompany items"
  measures:
    - name: "opening_balance_debit_sum"
      expr: SUM(CAST(opening_balance_debit AS DOUBLE))
      comment: "Total opening debit balance across accounts"
    - name: "opening_balance_credit_sum"
      expr: SUM(CAST(opening_balance_credit AS DOUBLE))
      comment: "Total opening credit balance across accounts"
    - name: "closing_balance_debit_sum"
      expr: SUM(CAST(closing_balance_debit AS DOUBLE))
      comment: "Total closing debit balance across accounts"
    - name: "closing_balance_credit_sum"
      expr: SUM(CAST(closing_balance_credit AS DOUBLE))
      comment: "Total closing credit balance across accounts"
    - name: "period_debit_activity_sum"
      expr: SUM(CAST(period_debit_activity AS DOUBLE))
      comment: "Total debit activity for the period"
    - name: "period_credit_activity_sum"
      expr: SUM(CAST(period_credit_activity AS DOUBLE))
      comment: "Total credit activity for the period"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of trial balance records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget vs. actual performance at the ledger level"
  source: "`banking_ecm`.`ledger`.`ledger_budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget"
    - name: "period_number"
      expr: period_number
      comment: "Period identifier within the fiscal year"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the budget"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account for the budget line"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity owning the budget"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the budget amounts"
    - name: "budget_type"
      expr: budget_type
      comment: "Type of budget (e.g., operating, capital)"
    - name: "budget_status"
      expr: budget_status
      comment: "Current status of the budget record"
    - name: "scenario"
      expr: scenario
      comment: "Planning scenario (e.g., baseline, forecast)"
  measures:
    - name: "actual_amount_sum"
      expr: SUM(CAST(actual_amount AS DOUBLE))
      comment: "Sum of actual amounts recorded in budget"
    - name: "variance_amount_sum"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount (actual - budget)"
    - name: "average_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across budget lines"
    - name: "budget_record_count"
      expr: COUNT(1)
      comment: "Number of budget records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_consolidation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial totals produced by consolidation processes"
  source: "`banking_ecm`.`ledger`.`consolidation_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the consolidation run"
    - name: "run_type"
      expr: run_type
      comment: "Type of run (e.g., full, incremental)"
    - name: "run_mode"
      expr: run_mode
      comment: "Execution mode (e.g., batch, streaming)"
    - name: "regulatory_submission_flag"
      expr: regulatory_submission_flag
      comment: "Indicates if the run was for regulatory submission"
    - name: "regulatory_submission_type"
      expr: regulatory_submission_type
      comment: "Type of regulatory submission"
  measures:
    - name: "total_assets_consolidated_sum"
      expr: SUM(CAST(total_assets_consolidated AS DOUBLE))
      comment: "Sum of consolidated assets across runs"
    - name: "total_liabilities_consolidated_sum"
      expr: SUM(CAST(total_liabilities_consolidated AS DOUBLE))
      comment: "Sum of consolidated liabilities across runs"
    - name: "total_equity_consolidated_sum"
      expr: SUM(CAST(total_equity_consolidated AS DOUBLE))
      comment: "Sum of consolidated equity across runs"
    - name: "net_income_consolidated_sum"
      expr: SUM(CAST(net_income_consolidated AS DOUBLE))
      comment: "Sum of consolidated net income"
    - name: "consolidation_run_count"
      expr: COUNT(1)
      comment: "Number of consolidation runs"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`ledger_financial_close_task`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for financial close processes"
  source: "`banking_ecm`.`ledger`.`financial_close_task`"
  dimensions:
    - name: "accounting_period_id"
      expr: accounting_period_id
      comment: "Accounting period the task belongs to"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the task"
    - name: "gl_account_id"
      expr: gl_account_id
      comment: "GL account impacted by the task"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity associated with the task"
    - name: "task_type"
      expr: task_type
      comment: "Type of financial close task"
    - name: "financial_close_task_status"
      expr: financial_close_task_status
      comment: "Current status of the task"
    - name: "due_date"
      expr: due_date
      comment: "Due date for task completion"
    - name: "priority"
      expr: priority
      comment: "Priority level of the task"
    - name: "is_key_control"
      expr: is_key_control
      comment: "Indicates if the task is a key control"
  measures:
    - name: "actual_effort_hours_sum"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total actual effort hours spent on close tasks"
    - name: "estimated_effort_hours_sum"
      expr: SUM(CAST(estimated_effort_hours AS DOUBLE))
      comment: "Total estimated effort hours for close tasks"
    - name: "average_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across tasks"
    - name: "financial_close_task_count"
      expr: COUNT(1)
      comment: "Number of financial close tasks"
$$;