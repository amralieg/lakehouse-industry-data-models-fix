-- Metric views for domain: finance | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:18:55

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_ar_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Invoice business metrics"
  source: "`automotive_ecm`.`finance`.`ar_invoice`"
  dimensions:
    - name: "Accounting Date"
      expr: accounting_date
    - name: "Aging Bucket"
      expr: aging_bucket
    - name: "Ar Invoice Status"
      expr: ar_invoice_status
    - name: "Billing Document Number"
      expr: billing_document_number
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Note Number"
      expr: delivery_note_number
    - name: "Discount Reason"
      expr: discount_reason
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Due Date"
      expr: due_date
    - name: "Intercompany Flag"
      expr: intercompany_flag
    - name: "Invoice Category"
      expr: invoice_category
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Type"
      expr: invoice_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Invoice"
      expr: COUNT(DISTINCT ar_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Payment Amount"
      expr: SUM(payment_amount)
    - name: "Average Payment Amount"
      expr: AVG(payment_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Warranty Reserve Amount"
      expr: SUM(warranty_reserve_amount)
    - name: "Average Warranty Reserve Amount"
      expr: AVG(warranty_reserve_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_ar_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ar Payment business metrics"
  source: "`automotive_ecm`.`finance`.`ar_payment`"
  dimensions:
    - name: "Ar Payment Status"
      expr: ar_payment_status
    - name: "Bank Account Number"
      expr: bank_account_number
    - name: "Bank Name"
      expr: bank_name
    - name: "Cash Application Status"
      expr: cash_application_status
    - name: "Clearance Date"
      expr: clearance_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Due Date"
      expr: due_date
    - name: "Exchange Rate Date"
      expr: exchange_rate_date
    - name: "Is Partial Payment"
      expr: is_partial_payment
    - name: "Notes"
      expr: notes
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Number"
      expr: payment_number
    - name: "Payment Source"
      expr: payment_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ar Payment"
      expr: COUNT(DISTINCT ar_payment_id)
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
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Original Amount"
      expr: SUM(original_amount)
    - name: "Average Original Amount"
      expr: AVG(original_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Plan business metrics"
  source: "`automotive_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Date"
      expr: approval_date
    - name: "Budget Category"
      expr: budget_category
    - name: "Budget Plan Status"
      expr: budget_plan_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Forecast"
      expr: is_forecast
    - name: "Is Locked"
      expr: is_locked
    - name: "Notes"
      expr: notes
    - name: "Plan Code"
      expr: plan_code
    - name: "Plan Name"
      expr: plan_name
    - name: "Plan Type"
      expr: plan_type
    - name: "Planning Period"
      expr: planning_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Plan"
      expr: COUNT(DISTINCT budget_plan_id)
    - name: "Total Planned Amount"
      expr: SUM(planned_amount)
    - name: "Average Planned Amount"
      expr: AVG(planned_amount)
    - name: "Total Revised Amount"
      expr: SUM(revised_amount)
    - name: "Average Revised Amount"
      expr: AVG(revised_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_capex_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capex Request business metrics"
  source: "`automotive_ecm`.`finance`.`capex_request`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Capex Request Description"
      expr: capex_request_description
    - name: "Capex Request Status"
      expr: capex_request_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Years"
      expr: depreciation_years
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Funding Source"
      expr: funding_source
    - name: "Has External Funding"
      expr: has_external_funding
    - name: "Investment Category"
      expr: investment_category
    - name: "Is Capitalized"
      expr: is_capitalized
    - name: "Is Compliant"
      expr: is_compliant
    - name: "Justification"
      expr: justification
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capex Request"
      expr: COUNT(DISTINCT capex_request_id)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Approved Budget Amount"
      expr: SUM(approved_budget_amount)
    - name: "Average Approved Budget Amount"
      expr: AVG(approved_budget_amount)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total External Funding Amount"
      expr: SUM(external_funding_amount)
    - name: "Average External Funding Amount"
      expr: AVG(external_funding_amount)
    - name: "Total Irr"
      expr: SUM(irr)
    - name: "Average Irr"
      expr: AVG(irr)
    - name: "Total Npv"
      expr: SUM(npv)
    - name: "Average Npv"
      expr: AVG(npv)
    - name: "Total Payback Period Years"
      expr: SUM(payback_period_years)
    - name: "Average Payback Period Years"
      expr: AVG(payback_period_years)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_company_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Company Code business metrics"
  source: "`automotive_ecm`.`finance`.`company_code`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Business Line"
      expr: business_line
    - name: "Chart Of Accounts"
      expr: chart_of_accounts
    - name: "City"
      expr: city
    - name: "Company Code"
      expr: company_code
    - name: "Company Code Status"
      expr: company_code_status
    - name: "Consolidation Group"
      expr: consolidation_group
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Email Address"
      expr: email_address
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year Variant"
      expr: fiscal_year_variant
    - name: "Functional Currency"
      expr: functional_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Company Code"
      expr: COUNT(DISTINCT company_code_id)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Center business metrics"
  source: "`automotive_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Status"
      expr: approval_status
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
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Last Review Date"
      expr: last_review_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Center"
      expr: COUNT(DISTINCT cost_center_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_currency_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency Rate business metrics"
  source: "`automotive_ecm`.`finance`.`currency_rate`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency From"
      expr: currency_from
    - name: "Currency Rate Description"
      expr: currency_rate_description
    - name: "Currency To"
      expr: currency_to
    - name: "Is Historical"
      expr: is_historical
    - name: "Rate Date"
      expr: rate_date
    - name: "Rate Type"
      expr: rate_type
    - name: "Source"
      expr: source
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Rate Date Month"
      expr: DATE_TRUNC('MONTH', rate_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Currency Rate"
      expr: COUNT(DISTINCT currency_rate_id)
    - name: "Total Rate Value"
      expr: SUM(rate_value)
    - name: "Average Rate Value"
      expr: AVG(rate_value)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_fiscal_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiscal Period business metrics"
  source: "`automotive_ecm`.`finance`.`fiscal_period`"
  dimensions:
    - name: "Accrual Cutoff Date"
      expr: accrual_cutoff_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Fiscal Period Description"
      expr: fiscal_period_description
    - name: "Fiscal Period Status"
      expr: fiscal_period_status
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Fiscal Year Variant"
      expr: fiscal_year_variant
    - name: "Is Current Period"
      expr: is_current_period
    - name: "Is Interim"
      expr: is_interim
    - name: "Lock Date"
      expr: lock_date
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Name"
      expr: period_name
    - name: "Period Number"
      expr: period_number
    - name: "Period Start Date"
      expr: period_start_date
    - name: "Period Type"
      expr: period_type
    - name: "Posting Deadline Date"
      expr: posting_deadline_date
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fiscal Period"
      expr: COUNT(DISTINCT fiscal_period_id)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed Asset business metrics"
  source: "`automotive_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Asset Class"
      expr: asset_class
    - name: "Asset Condition"
      expr: asset_condition
    - name: "Asset Description"
      expr: asset_description
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Asset Type"
      expr: asset_type
    - name: "Capitalized Flag"
      expr: capitalized_flag
    - name: "Condition Rating"
      expr: condition_rating
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Insurance Expiry Date"
      expr: insurance_expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fixed Asset"
      expr: COUNT(DISTINCT fixed_asset_id)
    - name: "Total Accumulated Depreciation"
      expr: SUM(accumulated_depreciation)
    - name: "Average Accumulated Depreciation"
      expr: AVG(accumulated_depreciation)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Depreciation Rate Percent"
      expr: SUM(depreciation_rate_percent)
    - name: "Average Depreciation Rate Percent"
      expr: AVG(depreciation_rate_percent)
    - name: "Total Insurance Coverage Amount"
      expr: SUM(insurance_coverage_amount)
    - name: "Average Insurance Coverage Amount"
      expr: AVG(insurance_coverage_amount)
    - name: "Total Net Book Value"
      expr: SUM(net_book_value)
    - name: "Average Net Book Value"
      expr: AVG(net_book_value)
    - name: "Total Tax Depreciation Amount"
      expr: SUM(tax_depreciation_amount)
    - name: "Average Tax Depreciation Amount"
      expr: AVG(tax_depreciation_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gl Account business metrics"
  source: "`automotive_ecm`.`finance`.`gl_account`"
  dimensions:
    - name: "Account Code"
      expr: account_code
    - name: "Account Group"
      expr: account_group
    - name: "Account Name"
      expr: account_name
    - name: "Account Type"
      expr: account_type
    - name: "Balance Type"
      expr: balance_type
    - name: "Chart Of Accounts Version"
      expr: chart_of_accounts_version
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Description"
      expr: gl_account_description
    - name: "Gl Account Status"
      expr: gl_account_status
    - name: "Is Budgeted"
      expr: is_budgeted
    - name: "Is Consolidation Account"
      expr: is_consolidation_account
    - name: "Is Deprecated"
      expr: is_deprecated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gl Account"
      expr: COUNT(DISTINCT gl_account_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Closing Balance"
      expr: SUM(closing_balance)
    - name: "Average Closing Balance"
      expr: AVG(closing_balance)
    - name: "Total Opening Balance"
      expr: SUM(opening_balance)
    - name: "Average Opening Balance"
      expr: AVG(opening_balance)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry business metrics"
  source: "`automotive_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Debit Credit Indicator"
      expr: debit_credit_indicator
    - name: "Document Date"
      expr: document_date
    - name: "Document Language"
      expr: document_language
    - name: "Document Number"
      expr: document_number
    - name: "Document Type"
      expr: document_type
    - name: "Exchange Rate Type"
      expr: exchange_rate_type
    - name: "Intercompany Indicator"
      expr: intercompany_indicator
    - name: "Is Adjustment"
      expr: is_adjustment
    - name: "Is Consolidated"
      expr: is_consolidated
    - name: "Is Manual Entry"
      expr: is_manual_entry
    - name: "Is Test Entry"
      expr: is_test_entry
    - name: "Journal Entry Status"
      expr: journal_entry_status
    - name: "Ledger Group"
      expr: ledger_group
    - name: "Line Item Count"
      expr: line_item_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry"
      expr: COUNT(DISTINCT journal_entry_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry Line business metrics"
  source: "`automotive_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "Account Type"
      expr: account_type
    - name: "Assignment"
      expr: assignment
    - name: "Business Area"
      expr: business_area
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Cc"
      expr: currency_cc
    - name: "Currency Tc"
      expr: currency_tc
    - name: "Debit Credit Indicator"
      expr: debit_credit_indicator
    - name: "Document Date"
      expr: document_date
    - name: "Exchange Rate Type"
      expr: exchange_rate_type
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Line Text"
      expr: line_text
    - name: "Plant"
      expr: plant
    - name: "Posting Date"
      expr: posting_date
    - name: "Posting Key"
      expr: posting_key
    - name: "Reference Document Item"
      expr: reference_document_item
    - name: "Reference Document Number"
      expr: reference_document_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry Line"
      expr: COUNT(DISTINCT journal_entry_line_id)
    - name: "Total Amount Cc"
      expr: SUM(amount_cc)
    - name: "Average Amount Cc"
      expr: AVG(amount_cc)
    - name: "Total Amount Tc"
      expr: SUM(amount_tc)
    - name: "Average Amount Tc"
      expr: AVG(amount_tc)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit Center business metrics"
  source: "`automotive_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Closure Date"
      expr: closure_date
    - name: "Company Code"
      expr: company_code
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "External Reference"
      expr: external_reference
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Consolidated"
      expr: is_consolidated
    - name: "Is Intercompany"
      expr: is_intercompany
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Notes"
      expr: notes
    - name: "Owner"
      expr: owner
    - name: "Profit Center Category"
      expr: profit_center_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profit Center"
      expr: COUNT(DISTINCT profit_center_id)
    - name: "Total Actual Amount"
      expr: SUM(actual_amount)
    - name: "Average Actual Amount"
      expr: AVG(actual_amount)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Ebitda Amount"
      expr: SUM(ebitda_amount)
    - name: "Average Ebitda Amount"
      expr: AVG(ebitda_amount)
    - name: "Total Margin Percent"
      expr: SUM(margin_percent)
    - name: "Average Margin Percent"
      expr: AVG(margin_percent)
    - name: "Total Plan Amount"
      expr: SUM(plan_amount)
    - name: "Average Plan Amount"
      expr: AVG(plan_amount)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Project business metrics"
  source: "`automotive_ecm`.`finance`.`project`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Audit Comments"
      expr: audit_comments
    - name: "Audit Status"
      expr: audit_status
    - name: "Capital Expenditure Flag"
      expr: capital_expenditure_flag
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "External Project Number"
      expr: external_project_number
    - name: "Funding Source"
      expr: funding_source
    - name: "Location"
      expr: location
    - name: "Operational Expenditure Flag"
      expr: operational_expenditure_flag
    - name: "Phase"
      expr: phase
    - name: "Phase End Date"
      expr: phase_end_date
    - name: "Phase Start Date"
      expr: phase_start_date
    - name: "Planned End Date"
      expr: planned_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Project"
      expr: COUNT(DISTINCT project_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Approved By"
      expr: SUM(approved_by)
    - name: "Average Approved By"
      expr: AVG(approved_by)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Expected Roi Percent"
      expr: SUM(expected_roi_percent)
    - name: "Average Expected Roi Percent"
      expr: AVG(expected_roi_percent)
    - name: "Total Forecasted Total Cost"
      expr: SUM(forecasted_total_cost)
    - name: "Average Forecasted Total Cost"
      expr: AVG(forecasted_total_cost)
    - name: "Total Revised Budget Amount"
      expr: SUM(revised_budget_amount)
    - name: "Average Revised Budget Amount"
      expr: AVG(revised_budget_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
    - name: "Total Variance Percent"
      expr: SUM(variance_percent)
    - name: "Average Variance Percent"
      expr: AVG(variance_percent)
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`finance_wbs_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wbs Element business metrics"
  source: "`automotive_ecm`.`finance`.`wbs_element`"
  dimensions:
    - name: "Accounting Status"
      expr: accounting_status
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "External Reference"
      expr: external_reference
    - name: "Investment Program Code"
      expr: investment_program_code
    - name: "Is Capex"
      expr: is_capex
    - name: "Is R And D"
      expr: is_r_and_d
    - name: "Milestone Flag"
      expr: milestone_flag
    - name: "Notes"
      expr: notes
    - name: "Plant Location"
      expr: plant_location
    - name: "Project Phase"
      expr: project_phase
    - name: "Revision Number"
      expr: revision_number
    - name: "Start Date"
      expr: start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wbs Element"
      expr: COUNT(DISTINCT wbs_element_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Committed Cost"
      expr: SUM(committed_cost)
    - name: "Average Committed Cost"
      expr: AVG(committed_cost)
    - name: "Total Planned Cost"
      expr: SUM(planned_cost)
    - name: "Average Planned Cost"
      expr: AVG(planned_cost)
$$;