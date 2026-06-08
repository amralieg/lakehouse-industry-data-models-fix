-- Metric views for domain: finance | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 19:22:26

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_accounts_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Payable business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`accounts_payable`"
  dimensions:
    - name: "Assignment Reference"
      expr: assignment_reference
    - name: "Baseline Date"
      expr: baseline_date
    - name: "Clearing Date"
      expr: clearing_date
    - name: "Clearing Document Number"
      expr: clearing_document_number
    - name: "Clearing Status"
      expr: clearing_status
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discount Due Date"
      expr: discount_due_date
    - name: "Document Currency"
      expr: document_currency
    - name: "Document Date"
      expr: document_date
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
    - name: "Due Date"
      expr: due_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account"
      expr: gl_account
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accounts Payable"
      expr: COUNT(DISTINCT accounts_payable_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Local Currency Amount"
      expr: SUM(local_currency_amount)
    - name: "Average Local Currency Amount"
      expr: AVG(local_currency_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Open Amount"
      expr: SUM(open_amount)
    - name: "Average Open Amount"
      expr: AVG(open_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Withholding Tax Amount"
      expr: SUM(withholding_tax_amount)
    - name: "Average Withholding Tax Amount"
      expr: AVG(withholding_tax_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_accounts_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts Receivable business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`accounts_receivable`"
  dimensions:
    - name: "Aging Bucket"
      expr: aging_bucket
    - name: "Assignment Field"
      expr: assignment_field
    - name: "Baseline Date"
      expr: baseline_date
    - name: "Business Unit"
      expr: business_unit
    - name: "Clearing Date"
      expr: clearing_date
    - name: "Clearing Status"
      expr: clearing_status
    - name: "Company Code"
      expr: company_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Past Due"
      expr: days_past_due
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Document Currency"
      expr: document_currency
    - name: "Document Date"
      expr: document_date
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accounts Receivable"
      expr: COUNT(DISTINCT accounts_receivable_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Local Currency Amount"
      expr: SUM(local_currency_amount)
    - name: "Average Local Currency Amount"
      expr: AVG(local_currency_amount)
    - name: "Total Open Amount"
      expr: SUM(open_amount)
    - name: "Average Open Amount"
      expr: AVG(open_amount)
    - name: "Total Original Amount"
      expr: SUM(original_amount)
    - name: "Average Original Amount"
      expr: AVG(original_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_chart_of_accounts`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chart Of Accounts business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`chart_of_accounts`"
  dimensions:
    - name: "Account Currency"
      expr: account_currency
    - name: "Account Group"
      expr: account_group
    - name: "Account Name"
      expr: account_name
    - name: "Account Notes"
      expr: account_notes
    - name: "Account Short Text"
      expr: account_short_text
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Alternative Account Number"
      expr: alternative_account_number
    - name: "Balance Sheet Classification"
      expr: balance_sheet_classification
    - name: "Chart Of Accounts Code"
      expr: chart_of_accounts_code
    - name: "Company Code"
      expr: company_code
    - name: "Consolidation Account"
      expr: consolidation_account
    - name: "Cost Center Required"
      expr: cost_center_required
    - name: "Cost Element Category"
      expr: cost_element_category
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Chart Of Accounts"
      expr: COUNT(DISTINCT chart_of_accounts_id)
    - name: "Total Materiality Threshold Amount"
      expr: SUM(materiality_threshold_amount)
    - name: "Average Materiality Threshold Amount"
      expr: AVG(materiality_threshold_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Center business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "Activity Type"
      expr: activity_type
    - name: "Budget Allocation Reference"
      expr: budget_allocation_reference
    - name: "Business Area"
      expr: business_area
    - name: "Company Code"
      expr: company_code
    - name: "Controlling Area"
      expr: controlling_area
    - name: "Cost Allocation Method"
      expr: cost_allocation_method
    - name: "Cost Center Category"
      expr: cost_center_category
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Cost Center Description"
      expr: cost_center_description
    - name: "Cost Center Name"
      expr: cost_center_name
    - name: "Cost Center Status"
      expr: cost_center_status
    - name: "Cost Center Type"
      expr: cost_center_type
    - name: "Cost Element Group"
      expr: cost_element_group
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Center"
      expr: COUNT(DISTINCT cost_center_id)
    - name: "Total Annual Budget Amount"
      expr: SUM(annual_budget_amount)
    - name: "Average Annual Budget Amount"
      expr: AVG(annual_budget_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_general_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General Ledger business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`general_ledger`"
  dimensions:
    - name: "Account Type"
      expr: account_type
    - name: "Business Area"
      expr: business_area
    - name: "Company Code"
      expr: company_code
    - name: "Consolidation Unit"
      expr: consolidation_unit
    - name: "Document Type"
      expr: document_type
    - name: "Ebitda Indicator"
      expr: ebitda_indicator
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Functional Area"
      expr: functional_area
    - name: "Functional Currency Code"
      expr: functional_currency_code
    - name: "Gl Account"
      expr: gl_account
    - name: "Last Posting Date"
      expr: last_posting_date
    - name: "Ledger Group"
      expr: ledger_group
    - name: "Period Lock Status"
      expr: period_lock_status
    - name: "Posting Key"
      expr: posting_key
    - name: "Posting Period"
      expr: posting_period
    - name: "Reconciliation Account Indicator"
      expr: reconciliation_account_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct General Ledger"
      expr: COUNT(DISTINCT general_ledger_id)
    - name: "Total Budget Amount Functional Currency"
      expr: SUM(budget_amount_functional_currency)
    - name: "Average Budget Amount Functional Currency"
      expr: AVG(budget_amount_functional_currency)
    - name: "Total Closing Balance Functional Currency"
      expr: SUM(closing_balance_functional_currency)
    - name: "Average Closing Balance Functional Currency"
      expr: AVG(closing_balance_functional_currency)
    - name: "Total Credit Amount Functional Currency"
      expr: SUM(credit_amount_functional_currency)
    - name: "Average Credit Amount Functional Currency"
      expr: AVG(credit_amount_functional_currency)
    - name: "Total Credit Amount Transaction Currency"
      expr: SUM(credit_amount_transaction_currency)
    - name: "Average Credit Amount Transaction Currency"
      expr: AVG(credit_amount_transaction_currency)
    - name: "Total Debit Amount Functional Currency"
      expr: SUM(debit_amount_functional_currency)
    - name: "Average Debit Amount Functional Currency"
      expr: AVG(debit_amount_functional_currency)
    - name: "Total Debit Amount Transaction Currency"
      expr: SUM(debit_amount_transaction_currency)
    - name: "Average Debit Amount Transaction Currency"
      expr: AVG(debit_amount_transaction_currency)
    - name: "Total Net Balance Functional Currency"
      expr: SUM(net_balance_functional_currency)
    - name: "Average Net Balance Functional Currency"
      expr: AVG(net_balance_functional_currency)
    - name: "Total Opening Balance Functional Currency"
      expr: SUM(opening_balance_functional_currency)
    - name: "Average Opening Balance Functional Currency"
      expr: AVG(opening_balance_functional_currency)
    - name: "Total Variance Amount Functional Currency"
      expr: SUM(variance_amount_functional_currency)
    - name: "Average Variance Amount Functional Currency"
      expr: AVG(variance_amount_functional_currency)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "Accrual Reversal Date"
      expr: accrual_reversal_date
    - name: "Accrual Reversal Indicator"
      expr: accrual_reversal_indicator
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Batch Input Session"
      expr: batch_input_session
    - name: "Company Code"
      expr: company_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Date"
      expr: document_date
    - name: "Document Header Text"
      expr: document_header_text
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
    - name: "Entry Date"
      expr: entry_date
    - name: "Entry Time"
      expr: entry_time
    - name: "Exchange Rate Type"
      expr: exchange_rate_type
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Intercompany Indicator"
      expr: intercompany_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry"
      expr: COUNT(DISTINCT journal_entry_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Entity business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`legal_entity`"
  dimensions:
    - name: "Accounting Standard"
      expr: accounting_standard
    - name: "Activation Date"
      expr: activation_date
    - name: "Broadcast License Holder Flag"
      expr: broadcast_license_holder_flag
    - name: "Chart Of Accounts"
      expr: chart_of_accounts
    - name: "Company Code"
      expr: company_code
    - name: "Consolidation Group"
      expr: consolidation_group
    - name: "Country Of Incorporation"
      expr: country_of_incorporation
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Control Area"
      expr: credit_control_area
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Ebitda Reporting Flag"
      expr: ebitda_reporting_flag
    - name: "Entity Status"
      expr: entity_status
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year Variant"
      expr: fiscal_year_variant
    - name: "Functional Currency"
      expr: functional_currency
    - name: "Incorporation Date"
      expr: incorporation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Entity"
      expr: COUNT(DISTINCT legal_entity_id)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_production_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production Budget business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`production_budget`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Budget Effective Date"
      expr: budget_effective_date
    - name: "Budget Expiry Date"
      expr: budget_expiry_date
    - name: "Budget Notes"
      expr: budget_notes
    - name: "Budget Number"
      expr: budget_number
    - name: "Budget Status"
      expr: budget_status
    - name: "Budget Type"
      expr: budget_type
    - name: "Budget Version"
      expr: budget_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Production End Date"
      expr: production_end_date
    - name: "Production Start Date"
      expr: production_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Production Budget"
      expr: COUNT(DISTINCT production_budget_id)
    - name: "Total Above The Line Amount"
      expr: SUM(above_the_line_amount)
    - name: "Average Above The Line Amount"
      expr: AVG(above_the_line_amount)
    - name: "Total Actual Spend To Date"
      expr: SUM(actual_spend_to_date)
    - name: "Average Actual Spend To Date"
      expr: AVG(actual_spend_to_date)
    - name: "Total Below The Line Amount"
      expr: SUM(below_the_line_amount)
    - name: "Average Below The Line Amount"
      expr: AVG(below_the_line_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Contingency Amount"
      expr: SUM(contingency_amount)
    - name: "Average Contingency Amount"
      expr: AVG(contingency_amount)
    - name: "Total Facilities Amount"
      expr: SUM(facilities_amount)
    - name: "Average Facilities Amount"
      expr: AVG(facilities_amount)
    - name: "Total Music Licensing Amount"
      expr: SUM(music_licensing_amount)
    - name: "Average Music Licensing Amount"
      expr: AVG(music_licensing_amount)
    - name: "Total Post Production Amount"
      expr: SUM(post_production_amount)
    - name: "Average Post Production Amount"
      expr: AVG(post_production_amount)
    - name: "Total Total Approved Amount"
      expr: SUM(total_approved_amount)
    - name: "Average Total Approved Amount"
      expr: AVG(total_approved_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
    - name: "Total Variance Percentage"
      expr: SUM(variance_percentage)
    - name: "Average Variance Percentage"
      expr: AVG(variance_percentage)
    - name: "Total Vfx Amount"
      expr: SUM(vfx_amount)
    - name: "Average Vfx Amount"
      expr: AVG(vfx_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit Center business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Budget Allocation Method"
      expr: budget_allocation_method
    - name: "Business Unit"
      expr: business_unit
    - name: "Closure Date"
      expr: closure_date
    - name: "Company Code"
      expr: company_code
    - name: "Controlling Area Code"
      expr: controlling_area_code
    - name: "Cost Center Assignment Flag"
      expr: cost_center_assignment_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Ebitda Reporting Flag"
      expr: ebitda_reporting_flag
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Hierarchy Node"
      expr: hierarchy_node
    - name: "Intercompany Elimination Flag"
      expr: intercompany_elimination_flag
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profit Center"
      expr: COUNT(DISTINCT profit_center_id)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_revenue_recognition_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Recognition Event business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`revenue_recognition_event`"
  dimensions:
    - name: "Accounting Document Number"
      expr: accounting_document_number
    - name: "Asc 606 Compliant Flag"
      expr: asc_606_compliant_flag
    - name: "Company Code"
      expr: company_code
    - name: "Contract Modification Flag"
      expr: contract_modification_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Ifrs 15 Compliant Flag"
      expr: ifrs_15_compliant_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Platform Type"
      expr: platform_type
    - name: "Recognition Date"
      expr: recognition_date
    - name: "Recognition Method"
      expr: recognition_method
    - name: "Recognition Status"
      expr: recognition_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Recognition Event"
      expr: COUNT(DISTINCT revenue_recognition_event_id)
    - name: "Total Deferred Amount"
      expr: SUM(deferred_amount)
    - name: "Average Deferred Amount"
      expr: AVG(deferred_amount)
    - name: "Total Recognized Amount"
      expr: SUM(recognized_amount)
    - name: "Average Recognized Amount"
      expr: AVG(recognized_amount)
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`finance_revenue_stream`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Stream business metrics"
  source: "`media_broadcasting_ecm`.`finance`.`revenue_stream`"
  dimensions:
    - name: "Accounting Standard"
      expr: accounting_standard
    - name: "Audience Measurement Source"
      expr: audience_measurement_source
    - name: "Audit Trail Required"
      expr: audit_trail_required
    - name: "Business Unit"
      expr: business_unit
    - name: "Content Type"
      expr: content_type
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Is Deferred"
      expr: is_deferred
    - name: "Is Recurring"
      expr: is_recurring
    - name: "Makegoods Policy"
      expr: makegoods_policy
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Stream"
      expr: COUNT(DISTINCT revenue_stream_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
$$;