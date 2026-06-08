-- Metric views for domain: finance | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:36:43

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_asset_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset Transaction business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`asset_transaction`"
  dimensions:
    - name: "Asset Acquisition Date"
      expr: asset_acquisition_date
    - name: "Asset Category"
      expr: asset_category
    - name: "Asset Life Years"
      expr: asset_life_years
    - name: "Asset Location Code"
      expr: asset_location_code
    - name: "Asset Retirement Date"
      expr: asset_retirement_date
    - name: "Asset Status"
      expr: asset_status
    - name: "Asset Sub Location Code"
      expr: asset_sub_location_code
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Area"
      expr: depreciation_area
    - name: "Depreciation Book"
      expr: depreciation_book
    - name: "Depreciation End Date"
      expr: depreciation_end_date
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Document Number"
      expr: document_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Asset Transaction"
      expr: COUNT(DISTINCT asset_transaction_id)
    - name: "Total Amount Gross"
      expr: SUM(amount_gross)
    - name: "Average Amount Gross"
      expr: AVG(amount_gross)
    - name: "Total Amount Net"
      expr: SUM(amount_net)
    - name: "Average Amount Net"
      expr: AVG(amount_net)
    - name: "Total Amount Tax"
      expr: SUM(amount_tax)
    - name: "Average Amount Tax"
      expr: AVG(amount_tax)
    - name: "Total Depreciation Amount"
      expr: SUM(depreciation_amount)
    - name: "Average Depreciation Amount"
      expr: AVG(depreciation_amount)
    - name: "Total Depreciation Rate Percent"
      expr: SUM(depreciation_rate_percent)
    - name: "Average Depreciation Rate Percent"
      expr: AVG(depreciation_rate_percent)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_bank_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bank Account business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`bank_account`"
  dimensions:
    - name: "Account Number"
      expr: account_number
    - name: "Account Type"
      expr: account_type
    - name: "Bank Account Description"
      expr: bank_account_description
    - name: "Bank Account Status"
      expr: bank_account_status
    - name: "Bank Country"
      expr: bank_country
    - name: "Bank Name"
      expr: bank_name
    - name: "Bank Swift Code"
      expr: bank_swift_code
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Overdraft Allowed"
      expr: is_overdraft_allowed
    - name: "Last Reconciliation Date"
      expr: last_reconciliation_date
    - name: "Last Statement Date"
      expr: last_statement_date
    - name: "Regulatory Approval Required"
      expr: regulatory_approval_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bank Account"
      expr: COUNT(DISTINCT bank_account_id)
    - name: "Total Account Limit"
      expr: SUM(account_limit)
    - name: "Average Account Limit"
      expr: AVG(account_limit)
    - name: "Total Overdraft Limit"
      expr: SUM(overdraft_limit)
    - name: "Average Overdraft Limit"
      expr: AVG(overdraft_limit)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_budget_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget Plan business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`budget_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Outcome"
      expr: approval_outcome
    - name: "Approval Status"
      expr: approval_status
    - name: "Budget Plan Status"
      expr: budget_plan_status
    - name: "Budget Type"
      expr: budget_type
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
    - name: "Is Locked"
      expr: is_locked
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Notes"
      expr: notes
    - name: "Plan Number"
      expr: plan_number
    - name: "Plan Version"
      expr: plan_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Budget Plan"
      expr: COUNT(DISTINCT budget_plan_id)
    - name: "Total Planned Amount"
      expr: SUM(planned_amount)
    - name: "Average Planned Amount"
      expr: AVG(planned_amount)
    - name: "Total Variance Allowed"
      expr: SUM(variance_allowed)
    - name: "Average Variance Allowed"
      expr: AVG(variance_allowed)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_business_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business Unit business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`business_unit`"
  dimensions:
    - name: "Address"
      expr: address
    - name: "Business Unit Code"
      expr: business_unit_code
    - name: "Business Unit Description"
      expr: business_unit_description
    - name: "Business Unit Name"
      expr: business_unit_name
    - name: "Business Unit Status"
      expr: business_unit_status
    - name: "Business Unit Type"
      expr: business_unit_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Headcount"
      expr: headcount
    - name: "Phone Number"
      expr: phone_number
    - name: "Region"
      expr: region
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Business Unit"
      expr: COUNT(DISTINCT business_unit_id)
    - name: "Total Annual Budget"
      expr: SUM(annual_budget)
    - name: "Average Annual Budget"
      expr: AVG(annual_budget)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_cost_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Center business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`cost_center`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Budget Year"
      expr: budget_year
    - name: "Cost Center Category"
      expr: cost_center_category
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Cost Center Description"
      expr: cost_center_description
    - name: "Cost Center Level"
      expr: cost_center_level
    - name: "Cost Center Name"
      expr: cost_center_name
    - name: "Cost Center Status"
      expr: cost_center_status
    - name: "Cost Center Type"
      expr: cost_center_type
    - name: "Cost Driver"
      expr: cost_driver
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "External Reference"
      expr: external_reference
    - name: "Group"
      expr: group
    - name: "Hierarchy Level"
      expr: hierarchy_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Center"
      expr: COUNT(DISTINCT cost_center_id)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
    - name: "Total Variance Percent"
      expr: SUM(variance_percent)
    - name: "Average Variance Percent"
      expr: AVG(variance_percent)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_cost_element`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Element business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`cost_element`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Cost Element Category"
      expr: cost_element_category
    - name: "Cost Element Code"
      expr: cost_element_code
    - name: "Cost Element Description"
      expr: cost_element_description
    - name: "Cost Element Name"
      expr: cost_element_name
    - name: "Cost Element Status"
      expr: cost_element_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Taxable"
      expr: is_taxable
    - name: "Quantity Based Flag"
      expr: quantity_based_flag
    - name: "Regulatory Compliance Flag"
      expr: regulatory_compliance_flag
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Version Number"
      expr: version_number
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Updated Timestamp Month"
      expr: DATE_TRUNC('MONTH', updated_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Element"
      expr: COUNT(DISTINCT cost_element_id)
    - name: "Total Default Rate"
      expr: SUM(default_rate)
    - name: "Average Default Rate"
      expr: AVG(default_rate)
    - name: "Total Overhead Rate"
      expr: SUM(overhead_rate)
    - name: "Average Overhead Rate"
      expr: AVG(overhead_rate)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_fiscal_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fiscal Period business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`fiscal_period`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days In Period"
      expr: days_in_period
    - name: "Fiscal Period Description"
      expr: fiscal_period_description
    - name: "Fiscal Period Status"
      expr: fiscal_period_status
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Adjusted"
      expr: is_adjusted
    - name: "Is Current"
      expr: is_current
    - name: "Period Code"
      expr: period_code
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Name"
      expr: period_name
    - name: "Period Start Date"
      expr: period_start_date
    - name: "Period Type"
      expr: period_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fiscal Period"
      expr: COUNT(DISTINCT fiscal_period_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed Asset business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`fixed_asset`"
  dimensions:
    - name: "Acquisition Date"
      expr: acquisition_date
    - name: "Asset Category"
      expr: asset_category
    - name: "Asset Condition"
      expr: asset_condition
    - name: "Asset Name"
      expr: asset_name
    - name: "Asset Subcategory"
      expr: asset_subcategory
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Capitalized Flag"
      expr: capitalized_flag
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Depreciation End Date"
      expr: depreciation_end_date
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Depreciation Start Date"
      expr: depreciation_start_date
    - name: "Disposal Date"
      expr: disposal_date
    - name: "Ehs Classification"
      expr: ehs_classification
    - name: "Fixed Asset Status"
      expr: fixed_asset_status
    - name: "Impairment Indicator"
      expr: impairment_indicator
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
    - name: "Total Disposal Proceeds"
      expr: SUM(disposal_proceeds)
    - name: "Average Disposal Proceeds"
      expr: AVG(disposal_proceeds)
    - name: "Total Environmental Impact Score"
      expr: SUM(environmental_impact_score)
    - name: "Average Environmental Impact Score"
      expr: AVG(environmental_impact_score)
    - name: "Total Impairment Amount"
      expr: SUM(impairment_amount)
    - name: "Average Impairment Amount"
      expr: AVG(impairment_amount)
    - name: "Total Insurance Value"
      expr: SUM(insurance_value)
    - name: "Average Insurance Value"
      expr: AVG(insurance_value)
    - name: "Total Location Latitude"
      expr: SUM(location_latitude)
    - name: "Average Location Latitude"
      expr: AVG(location_latitude)
    - name: "Total Location Longitude"
      expr: SUM(location_longitude)
    - name: "Average Location Longitude"
      expr: AVG(location_longitude)
    - name: "Total Net Book Value"
      expr: SUM(net_book_value)
    - name: "Average Net Book Value"
      expr: AVG(net_book_value)
    - name: "Total Residual Value"
      expr: SUM(residual_value)
    - name: "Average Residual Value"
      expr: AVG(residual_value)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_gl_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gl Account business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`gl_account`"
  dimensions:
    - name: "Account Group"
      expr: account_group
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Type"
      expr: account_type
    - name: "Controlling Area"
      expr: controlling_area
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Depreciation Key"
      expr: depreciation_key
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Financial Statement Line"
      expr: financial_statement_line
    - name: "Gl Account Description"
      expr: gl_account_description
    - name: "Gl Account Status"
      expr: gl_account_status
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Is Budget Enabled"
      expr: is_budget_enabled
    - name: "Is Capitalized"
      expr: is_capitalized
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gl Account"
      expr: COUNT(DISTINCT gl_account_id)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_internal_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Internal Order business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`internal_order`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Asset Tag"
      expr: asset_tag
    - name: "Budget Month"
      expr: budget_month
    - name: "Budget Version"
      expr: budget_version
    - name: "Budget Year"
      expr: budget_year
    - name: "Currency Code"
      expr: currency_code
    - name: "Department"
      expr: department
    - name: "External Reference"
      expr: external_reference
    - name: "Financial Period"
      expr: financial_period
    - name: "Internal Order Description"
      expr: internal_order_description
    - name: "Internal Order Number"
      expr: internal_order_number
    - name: "Is Capitalized"
      expr: is_capitalized
    - name: "Is External"
      expr: is_external
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Order Date"
      expr: order_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Internal Order"
      expr: COUNT(DISTINCT internal_order_id)
    - name: "Total Actual Cost"
      expr: SUM(actual_cost)
    - name: "Average Actual Cost"
      expr: AVG(actual_cost)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Remaining Budget"
      expr: SUM(remaining_budget)
    - name: "Average Remaining Budget"
      expr: AVG(remaining_budget)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_journal_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`journal_entry`"
  dimensions:
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Document Number"
      expr: document_number
    - name: "Document Status"
      expr: document_status
    - name: "Document Type"
      expr: document_type
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Intercompany Indicator"
      expr: intercompany_indicator
    - name: "Journal Entry Description"
      expr: journal_entry_description
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Posting Date"
      expr: posting_date
    - name: "Posting Key"
      expr: posting_key
    - name: "Posting Period"
      expr: posting_period
    - name: "Posting Reference"
      expr: posting_reference
    - name: "Reference Number"
      expr: reference_number
    - name: "Reversal Indicator"
      expr: reversal_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry"
      expr: COUNT(DISTINCT journal_entry_id)
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
    - name: "Total Party Reference"
      expr: SUM(party_reference)
    - name: "Average Party Reference"
      expr: AVG(party_reference)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Journal Entry Line business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "Assignment Field"
      expr: assignment_field
    - name: "Business Segment Code"
      expr: business_segment_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Debit Credit Indicator"
      expr: debit_credit_indicator
    - name: "Document Date"
      expr: document_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Journal Entry Line Status"
      expr: journal_entry_line_status
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Line Text"
      expr: line_text
    - name: "Posting Date"
      expr: posting_date
    - name: "Reversal Indicator"
      expr: reversal_indicator
    - name: "Tax Code"
      expr: tax_code
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Wbs Element"
      expr: wbs_element
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Journal Entry Line"
      expr: COUNT(DISTINCT journal_entry_line_id)
    - name: "Total Amount Document Currency"
      expr: SUM(amount_document_currency)
    - name: "Average Amount Document Currency"
      expr: AVG(amount_document_currency)
    - name: "Total Amount Local Currency"
      expr: SUM(amount_local_currency)
    - name: "Average Amount Local Currency"
      expr: AVG(amount_local_currency)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Line Quantity"
      expr: SUM(line_quantity)
    - name: "Average Line Quantity"
      expr: AVG(line_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Entity business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`legal_entity`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Classification"
      expr: data_classification
    - name: "End Date"
      expr: end_date
    - name: "Entity Category"
      expr: entity_category
    - name: "Entity Type"
      expr: entity_type
    - name: "Industry Code"
      expr: industry_code
    - name: "Is Public Company"
      expr: is_public_company
    - name: "Legal Entity Name"
      expr: legal_entity_name
    - name: "Legal Entity Status"
      expr: legal_entity_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Entity"
      expr: COUNT(DISTINCT legal_entity_id)
    - name: "Total Annual Revenue"
      expr: SUM(annual_revenue)
    - name: "Average Annual Revenue"
      expr: AVG(annual_revenue)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_profit_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Profit Center business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`profit_center`"
  dimensions:
    - name: "Controlling Area"
      expr: controlling_area
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Is Reportable"
      expr: is_reportable
    - name: "Profit Center Code"
      expr: profit_center_code
    - name: "Profit Center Description"
      expr: profit_center_description
    - name: "Profit Center Group"
      expr: profit_center_group
    - name: "Profit Center Name"
      expr: profit_center_name
    - name: "Profit Center Status"
      expr: profit_center_status
    - name: "Profit Center Type"
      expr: profit_center_type
    - name: "Segment"
      expr: segment
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Profit Center"
      expr: COUNT(DISTINCT profit_center_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Capex Budget"
      expr: SUM(capex_budget)
    - name: "Average Capex Budget"
      expr: AVG(capex_budget)
    - name: "Total Ebitda Amount"
      expr: SUM(ebitda_amount)
    - name: "Average Ebitda Amount"
      expr: AVG(ebitda_amount)
    - name: "Total Opex Budget"
      expr: SUM(opex_budget)
    - name: "Average Opex Budget"
      expr: AVG(opex_budget)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`finance_standard_cost`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Standard Cost business metrics"
  source: "`chemical_mfg_ecm`.`finance`.`standard_cost`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cost Name"
      expr: cost_name
    - name: "Cost Type"
      expr: cost_type
    - name: "Cost Uom"
      expr: cost_uom
    - name: "Cost Version Number"
      expr: cost_version_number
    - name: "Costing Method"
      expr: costing_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Notes"
      expr: notes
    - name: "Release Date"
      expr: release_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Standard Cost"
      expr: COUNT(DISTINCT standard_cost_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Costing Lot Size"
      expr: SUM(costing_lot_size)
    - name: "Average Costing Lot Size"
      expr: AVG(costing_lot_size)
$$;