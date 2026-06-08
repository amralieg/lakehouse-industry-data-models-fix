-- Metric views for domain: finance | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core receivable KPIs to monitor outstanding balances and overdue exposure"
  source: "`media_broadcasting_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the receivable"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the receivable"
    - name: "company_code"
      expr: company_code
      comment: "Company code"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
    - name: "subscriber_id"
      expr: subscriber_id
      comment: "Subscriber identifier"
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "Aging bucket classification"
    - name: "document_type"
      expr: document_type
      comment: "Document type of the receivable"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of accounts receivable records"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open amount outstanding across all receivables"
    - name: "total_overdue_amount"
      expr: SUM(CASE WHEN due_date < current_date() THEN open_amount ELSE 0 END)
      comment: "Sum of open amounts that are past their due date"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payable KPIs to track liabilities and overdue payments"
  source: "`media_broadcasting_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the payable"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the payable"
    - name: "company_code"
      expr: company_code
      comment: "Company code"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor identifier"
    - name: "payment_block"
      expr: payment_block
      comment: "Payment block status"
    - name: "document_type"
      expr: document_type
      comment: "Document type of the payable"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of accounts payable records"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of payables"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount of payables"
    - name: "total_open_amount"
      expr: SUM(CAST(open_amount AS DOUBLE))
      comment: "Total open amount outstanding"
    - name: "total_overdue_amount"
      expr: SUM(CASE WHEN due_date < current_date() THEN open_amount ELSE 0 END)
      comment: "Sum of open amounts past due date"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_ebitda_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic profitability KPIs for executive review"
  source: "`media_broadcasting_ecm`.`finance`.`ebitda_snapshot`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the snapshot"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the snapshot"
    - name: "company_code"
      expr: company_code
      comment: "Company code"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
    - name: "business_segment"
      expr: business_segment
      comment: "Business segment"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of EBITDA snapshot records"
    - name: "total_ebitda_amount"
      expr: SUM(CAST(ebitda_amount AS DOUBLE))
      comment: "Total EBITDA amount"
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue captured in the snapshot"
    - name: "total_gross_margin_amount"
      expr: SUM(CAST(gross_margin_amount AS DOUBLE))
      comment: "Total gross margin amount"
    - name: "avg_ebitda_margin_percentage"
      expr: AVG(CAST(ebitda_margin_percentage AS DOUBLE))
      comment: "Average EBITDA margin percentage"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPEX project financial health metrics"
  source: "`media_broadcasting_ecm`.`finance`.`capex_project`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project"
    - name: "project_classification"
      expr: project_classification
      comment: "Project classification"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of CAPEX project records"
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget_amount AS DOUBLE))
      comment: "Total approved CAPEX budget"
    - name: "total_cumulative_spend"
      expr: SUM(CAST(cumulative_spend_amount AS DOUBLE))
      comment: "Cumulative spend to date"
    - name: "total_remaining_budget"
      expr: SUM(CAST(remaining_budget_amount AS DOUBLE))
      comment: "Remaining budget amount"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset management KPIs for capital efficiency"
  source: "`media_broadcasting_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "company_code"
      expr: company_code
      comment: "Company code"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class"
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the asset"
    - name: "acquisition_date"
      expr: acquisition_date
      comment: "Date the asset was acquired"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of fixed asset records"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of assets"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core ledger aggregates for financial reporting"
  source: "`media_broadcasting_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the entry"
    - name: "company_code"
      expr: company_code
      comment: "Company code"
    - name: "gl_account"
      expr: gl_account
      comment: "General ledger account"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "transaction_currency_code"
      expr: transaction_currency_code
      comment: "Currency code of the transaction"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of general ledger entries"
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount_transaction_currency AS DOUBLE))
      comment: "Total debit amount in transaction currency"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount_transaction_currency AS DOUBLE))
      comment: "Total credit amount in transaction currency"
    - name: "total_net_balance"
      expr: SUM(CAST(net_balance_functional_currency AS DOUBLE))
      comment: "Net balance in functional currency"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_budget_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget version performance and control metrics"
  source: "`media_broadcasting_ecm`.`finance`.`budget_version`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the budget version"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center identifier"
    - name: "profit_center_id"
      expr: profit_center_id
      comment: "Profit center identifier"
    - name: "budget_category"
      expr: budget_category
      comment: "Category of the budget"
    - name: "version_type"
      expr: version_type
      comment: "Type of budget version"
    - name: "version_number"
      expr: version_number
      comment: "Version number"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of budget version records"
    - name: "total_approved_amount"
      expr: SUM(CAST(total_approved_amount AS DOUBLE))
      comment: "Total approved budget amount"
    - name: "avg_variance_threshold_percentage"
      expr: AVG(CAST(variance_threshold_percentage AS DOUBLE))
      comment: "Average variance threshold percentage across budgets"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_intercompany_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Intercompany transaction volume and exposure"
  source: "`media_broadcasting_ecm`.`finance`.`intercompany_transaction`"
  dimensions:
    - name: "sending_company_code"
      expr: sending_company_code
      comment: "Sending company code"
    - name: "receiving_company_code"
      expr: receiving_company_code
      comment: "Receiving company code"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of intercompany transaction"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of intercompany transaction records"
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total amount of intercompany transactions"
$$;