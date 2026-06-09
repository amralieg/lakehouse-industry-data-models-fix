-- Metric views for domain: trade | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 23:16:33

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual business metrics"
  source: "`food_beverage_ecm`.`trade`.`accrual`"
  dimensions:
    - name: "Accrual Number"
      expr: accrual_number
    - name: "Accrual Status"
      expr: accrual_status
    - name: "Accrual Type"
      expr: accrual_type
    - name: "Basis"
      expr: basis
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Period End"
      expr: period_end
    - name: "Period Start"
      expr: period_start
    - name: "Posting Reference"
      expr: posting_reference
    - name: "Reason"
      expr: reason
    - name: "Recognition Timestamp"
      expr: recognition_timestamp
    - name: "Reversal Flag"
      expr: reversal_flag
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accrual"
      expr: COUNT(DISTINCT accrual_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Basis Quantity"
      expr: SUM(basis_quantity)
    - name: "Average Basis Quantity"
      expr: AVG(basis_quantity)
    - name: "Total Net Sales Amount"
      expr: SUM(net_sales_amount)
    - name: "Average Net Sales Amount"
      expr: AVG(net_sales_amount)
    - name: "Total Rate"
      expr: SUM(rate)
    - name: "Average Rate"
      expr: AVG(rate)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_agreement_term`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agreement Term business metrics"
  source: "`food_beverage_ecm`.`trade`.`agreement_term`"
  dimensions:
    - name: "Accrual Method"
      expr: accrual_method
    - name: "Agreement Term Status"
      expr: agreement_term_status
    - name: "Chargeback Type"
      expr: chargeback_type
    - name: "Compliance Metric"
      expr: compliance_metric
    - name: "Compliance Required"
      expr: compliance_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Edlp Price Currency"
      expr: edlp_price_currency
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Measurement Period"
      expr: measurement_period
    - name: "Notes"
      expr: notes
    - name: "Promotional Funding Type"
      expr: promotional_funding_type
    - name: "Rate Currency"
      expr: rate_currency
    - name: "Region Code"
      expr: region_code
    - name: "Slotting Fee Currency"
      expr: slotting_fee_currency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agreement Term"
      expr: COUNT(DISTINCT agreement_term_id)
    - name: "Total Chargeback Rate"
      expr: SUM(chargeback_rate)
    - name: "Average Chargeback Rate"
      expr: AVG(chargeback_rate)
    - name: "Total Compliance Actual"
      expr: SUM(compliance_actual)
    - name: "Average Compliance Actual"
      expr: AVG(compliance_actual)
    - name: "Total Compliance Target"
      expr: SUM(compliance_target)
    - name: "Average Compliance Target"
      expr: AVG(compliance_target)
    - name: "Total Contract Term Code"
      expr: SUM(contract_term_code)
    - name: "Average Contract Term Code"
      expr: AVG(contract_term_code)
    - name: "Total Edlp Price"
      expr: SUM(edlp_price)
    - name: "Average Edlp Price"
      expr: AVG(edlp_price)
    - name: "Total Promotional Funding Rate"
      expr: SUM(promotional_funding_rate)
    - name: "Average Promotional Funding Rate"
      expr: AVG(promotional_funding_rate)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Slotting Fee Amount"
      expr: SUM(slotting_fee_amount)
    - name: "Average Slotting Fee Amount"
      expr: AVG(slotting_fee_amount)
    - name: "Total Threshold Quantity"
      expr: SUM(threshold_quantity)
    - name: "Average Threshold Quantity"
      expr: AVG(threshold_quantity)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_deduction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deduction business metrics"
  source: "`food_beverage_ecm`.`trade`.`deduction`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Batch Number"
      expr: batch_number
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deduction Category"
      expr: deduction_category
    - name: "Deduction Date"
      expr: deduction_date
    - name: "Deduction Description"
      expr: deduction_description
    - name: "Deduction Number"
      expr: deduction_number
    - name: "Deduction Status"
      expr: deduction_status
    - name: "Deduction Type"
      expr: deduction_type
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Manual Entry"
      expr: is_manual_entry
    - name: "Market Segment"
      expr: market_segment
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deduction"
      expr: COUNT(DISTINCT deduction_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Audit Trail Reference"
      expr: SUM(audit_trail_reference)
    - name: "Average Audit Trail Reference"
      expr: AVG(audit_trail_reference)
    - name: "Total Chargeback Rate Percent"
      expr: SUM(chargeback_rate_percent)
    - name: "Average Chargeback Rate Percent"
      expr: AVG(chargeback_rate_percent)
    - name: "Total Freight Amount"
      expr: SUM(freight_amount)
    - name: "Average Freight Amount"
      expr: AVG(freight_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Handling Fee Amount"
      expr: SUM(handling_fee_amount)
    - name: "Average Handling Fee Amount"
      expr: AVG(handling_fee_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund business metrics"
  source: "`food_beverage_ecm`.`trade`.`fund`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Allocation Scope"
      expr: allocation_scope
    - name: "Approval Date"
      expr: approval_date
    - name: "Classification"
      expr: classification
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Fund Code"
      expr: fund_code
    - name: "Fund Description"
      expr: fund_description
    - name: "Fund Name"
      expr: fund_name
    - name: "Fund Status"
      expr: fund_status
    - name: "Fund Type"
      expr: fund_type
    - name: "Region Code"
      expr: region_code
    - name: "Source System"
      expr: source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fund"
      expr: COUNT(DISTINCT fund_id)
    - name: "Total Accrued Amount"
      expr: SUM(accrued_amount)
    - name: "Average Accrued Amount"
      expr: AVG(accrued_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Paid Amount"
      expr: SUM(paid_amount)
    - name: "Average Paid Amount"
      expr: AVG(paid_amount)
    - name: "Total Remaining Balance"
      expr: SUM(remaining_balance)
    - name: "Average Remaining Balance"
      expr: AVG(remaining_balance)
    - name: "Total Total Approved Amount"
      expr: SUM(total_approved_amount)
    - name: "Average Total Approved Amount"
      expr: AVG(total_approved_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_promotion_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Claim business metrics"
  source: "`food_beverage_ecm`.`trade`.`promotion_claim`"
  dimensions:
    - name: "Claim Adjustment Reason"
      expr: claim_adjustment_reason
    - name: "Claim Date"
      expr: claim_date
    - name: "Claim Line Item Description"
      expr: claim_line_item_description
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Period End"
      expr: claim_period_end
    - name: "Claim Period Start"
      expr: claim_period_start
    - name: "Claim Processing Status"
      expr: claim_processing_status
    - name: "Claim Source System"
      expr: claim_source_system
    - name: "Claim Submission Timestamp"
      expr: claim_submission_timestamp
    - name: "Claim Type"
      expr: claim_type
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Lifecycle Status"
      expr: lifecycle_status
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Rejection Reason"
      expr: rejection_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Claim"
      expr: COUNT(DISTINCT promotion_claim_id)
    - name: "Total Approved Amount"
      expr: SUM(approved_amount)
    - name: "Average Approved Amount"
      expr: AVG(approved_amount)
    - name: "Total Claim Adjustment Amount"
      expr: SUM(claim_adjustment_amount)
    - name: "Average Claim Adjustment Amount"
      expr: AVG(claim_adjustment_amount)
    - name: "Total Claim Original Amount"
      expr: SUM(claim_original_amount)
    - name: "Average Claim Original Amount"
      expr: AVG(claim_original_amount)
    - name: "Total Claimed Amount"
      expr: SUM(claimed_amount)
    - name: "Average Claimed Amount"
      expr: AVG(claimed_amount)
    - name: "Total Claimed Volume"
      expr: SUM(claimed_volume)
    - name: "Average Claimed Volume"
      expr: AVG(claimed_volume)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_promotion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Event business metrics"
  source: "`food_beverage_ecm`.`trade`.`promotion_event`"
  dimensions:
    - name: "Actual End Date"
      expr: actual_end_date
    - name: "Actual Sales Volume"
      expr: actual_sales_volume
    - name: "Actual Start Date"
      expr: actual_start_date
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Audit Status"
      expr: audit_status
    - name: "Channel"
      expr: channel
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Event Number"
      expr: event_number
    - name: "Execution Timestamp"
      expr: execution_timestamp
    - name: "Field Verification Timestamp"
      expr: field_verification_timestamp
    - name: "Is Field Verified"
      expr: is_field_verified
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Mechanic Type"
      expr: mechanic_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Event"
      expr: COUNT(DISTINCT promotion_event_id)
    - name: "Total Actual Revenue"
      expr: SUM(actual_revenue)
    - name: "Average Actual Revenue"
      expr: AVG(actual_revenue)
    - name: "Total Promotional Spend Discount"
      expr: SUM(promotional_spend_discount)
    - name: "Average Promotional Spend Discount"
      expr: AVG(promotional_spend_discount)
    - name: "Total Promotional Spend Gross"
      expr: SUM(promotional_spend_gross)
    - name: "Average Promotional Spend Gross"
      expr: AVG(promotional_spend_gross)
    - name: "Total Promotional Spend Net"
      expr: SUM(promotional_spend_net)
    - name: "Average Promotional Spend Net"
      expr: AVG(promotional_spend_net)
    - name: "Total Target Revenue"
      expr: SUM(target_revenue)
    - name: "Average Target Revenue"
      expr: AVG(target_revenue)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_promotion_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Line business metrics"
  source: "`food_beverage_ecm`.`trade`.`promotion_line`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Line Number"
      expr: line_number
    - name: "Notes"
      expr: notes
    - name: "Promotion Category"
      expr: promotion_category
    - name: "Promotion Line Status"
      expr: promotion_line_status
    - name: "Promotion Type"
      expr: promotion_type
    - name: "Region Code"
      expr: region_code
    - name: "Sales Channel"
      expr: sales_channel
    - name: "Start Date"
      expr: start_date
    - name: "Target Store Type"
      expr: target_store_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Line"
      expr: COUNT(DISTINCT promotion_line_id)
    - name: "Total Baseline Volume"
      expr: SUM(baseline_volume)
    - name: "Average Baseline Volume"
      expr: AVG(baseline_volume)
    - name: "Total Bill Back Rate"
      expr: SUM(bill_back_rate)
    - name: "Average Bill Back Rate"
      expr: AVG(bill_back_rate)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Cost Of Goods Sold Per Unit"
      expr: SUM(cost_of_goods_sold_per_unit)
    - name: "Average Cost Of Goods Sold Per Unit"
      expr: AVG(cost_of_goods_sold_per_unit)
    - name: "Total Funding Amount Per Unit"
      expr: SUM(funding_amount_per_unit)
    - name: "Average Funding Amount Per Unit"
      expr: AVG(funding_amount_per_unit)
    - name: "Total Incremental Volume Target"
      expr: SUM(incremental_volume_target)
    - name: "Average Incremental Volume Target"
      expr: AVG(incremental_volume_target)
    - name: "Total Margin Per Unit"
      expr: SUM(margin_per_unit)
    - name: "Average Margin Per Unit"
      expr: AVG(margin_per_unit)
    - name: "Total Off Invoice Allowance Rate"
      expr: SUM(off_invoice_allowance_rate)
    - name: "Average Off Invoice Allowance Rate"
      expr: AVG(off_invoice_allowance_rate)
    - name: "Total Planned Price"
      expr: SUM(planned_price)
    - name: "Average Planned Price"
      expr: AVG(planned_price)
    - name: "Total Planned Volume Lift"
      expr: SUM(planned_volume_lift)
    - name: "Average Planned Volume Lift"
      expr: AVG(planned_volume_lift)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Scan Back Rate"
      expr: SUM(scan_back_rate)
    - name: "Average Scan Back Rate"
      expr: AVG(scan_back_rate)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_promotion_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Plan business metrics"
  source: "`food_beverage_ecm`.`trade`.`promotion_plan`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Forecast Created By"
      expr: forecast_created_by
    - name: "Forecast Created Timestamp"
      expr: forecast_created_timestamp
    - name: "Forecast Method"
      expr: forecast_method
    - name: "Forecast Version"
      expr: forecast_version
    - name: "Funding Source"
      expr: funding_source
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Notes"
      expr: notes
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Promotion Mechanic"
      expr: promotion_mechanic
    - name: "Promotion Name"
      expr: promotion_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Plan"
      expr: COUNT(DISTINCT promotion_plan_id)
    - name: "Total Baseline Volume"
      expr: SUM(baseline_volume)
    - name: "Average Baseline Volume"
      expr: AVG(baseline_volume)
    - name: "Total Estimated Roi Percent"
      expr: SUM(estimated_roi_percent)
    - name: "Average Estimated Roi Percent"
      expr: AVG(estimated_roi_percent)
    - name: "Total Incremental Lift Estimate"
      expr: SUM(incremental_lift_estimate)
    - name: "Average Incremental Lift Estimate"
      expr: AVG(incremental_lift_estimate)
    - name: "Total Net Revenue Impact"
      expr: SUM(net_revenue_impact)
    - name: "Average Net Revenue Impact"
      expr: AVG(net_revenue_impact)
    - name: "Total Target Sales Units"
      expr: SUM(target_sales_units)
    - name: "Average Target Sales Units"
      expr: AVG(target_sales_units)
    - name: "Total Target Sales Value"
      expr: SUM(target_sales_value)
    - name: "Average Target Sales Value"
      expr: AVG(target_sales_value)
    - name: "Total Total Promoted Volume"
      expr: SUM(total_promoted_volume)
    - name: "Average Total Promoted Volume"
      expr: AVG(total_promoted_volume)
    - name: "Total Trade Spend Investment"
      expr: SUM(trade_spend_investment)
    - name: "Average Trade Spend Investment"
      expr: AVG(trade_spend_investment)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_retailer_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retailer Agreement business metrics"
  source: "`food_beverage_ecm`.`trade`.`retailer_agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Bonus Clause"
      expr: bonus_clause
    - name: "Compliance Measure Method"
      expr: compliance_measure_method
    - name: "Creation Timestamp"
      expr: creation_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Display Compliance Requirement"
      expr: display_compliance_requirement
    - name: "Edlp Price Uom"
      expr: edlp_price_uom
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Exclusive Agreement"
      expr: is_exclusive_agreement
    - name: "Is Multi Year"
      expr: is_multi_year
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retailer Agreement"
      expr: COUNT(DISTINCT retailer_agreement_id)
    - name: "Total Bonus Amount"
      expr: SUM(bonus_amount)
    - name: "Average Bonus Amount"
      expr: AVG(bonus_amount)
    - name: "Total Co Op Advertising Allowance"
      expr: SUM(co_op_advertising_allowance)
    - name: "Average Co Op Advertising Allowance"
      expr: AVG(co_op_advertising_allowance)
    - name: "Total Edlp Price Commitment"
      expr: SUM(edlp_price_commitment)
    - name: "Average Edlp Price Commitment"
      expr: AVG(edlp_price_commitment)
    - name: "Total Funding Commitment Amount"
      expr: SUM(funding_commitment_amount)
    - name: "Average Funding Commitment Amount"
      expr: AVG(funding_commitment_amount)
    - name: "Total Mdf Allocation Amount"
      expr: SUM(mdf_allocation_amount)
    - name: "Average Mdf Allocation Amount"
      expr: AVG(mdf_allocation_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Performance Threshold"
      expr: SUM(performance_threshold)
    - name: "Average Performance Threshold"
      expr: AVG(performance_threshold)
    - name: "Total Scan Back Rate"
      expr: SUM(scan_back_rate)
    - name: "Average Scan Back Rate"
      expr: AVG(scan_back_rate)
    - name: "Total Total Funding Amount"
      expr: SUM(total_funding_amount)
    - name: "Average Total Funding Amount"
      expr: AVG(total_funding_amount)
    - name: "Total Volume Target"
      expr: SUM(volume_target)
    - name: "Average Volume Target"
      expr: AVG(volume_target)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement business metrics"
  source: "`food_beverage_ecm`.`trade`.`settlement`"
  dimensions:
    - name: "Accounting Date"
      expr: accounting_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Manual Settlement"
      expr: is_manual_settlement
    - name: "Is Tax Included"
      expr: is_tax_included
    - name: "Payment Reference"
      expr: payment_reference
    - name: "Period"
      expr: period
    - name: "Posted Timestamp"
      expr: posted_timestamp
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Settlement Description"
      expr: settlement_description
    - name: "Settlement Method"
      expr: settlement_method
    - name: "Settlement Number"
      expr: settlement_number
    - name: "Settlement Status"
      expr: settlement_status
    - name: "Settlement Timestamp"
      expr: settlement_timestamp
    - name: "Settlement Type"
      expr: settlement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Settlement"
      expr: COUNT(DISTINCT settlement_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Original Claim Amount"
      expr: SUM(original_claim_amount)
    - name: "Average Original Claim Amount"
      expr: AVG(original_claim_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_spend_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend Budget business metrics"
  source: "`food_beverage_ecm`.`trade`.`spend_budget`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Approval Status"
      expr: approval_status
    - name: "Budget Code"
      expr: budget_code
    - name: "Budget Name"
      expr: budget_name
    - name: "Budget Period"
      expr: budget_period
    - name: "Budget Type"
      expr: budget_type
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Fund Type"
      expr: fund_type
    - name: "Last Revision Timestamp"
      expr: last_revision_timestamp
    - name: "Notes"
      expr: notes
    - name: "Spend Budget Category"
      expr: spend_budget_category
    - name: "Spend Budget Description"
      expr: spend_budget_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spend Budget"
      expr: COUNT(DISTINCT spend_budget_id)
    - name: "Total Accrued Amount"
      expr: SUM(accrued_amount)
    - name: "Average Accrued Amount"
      expr: AVG(accrued_amount)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
    - name: "Total Co Op Budget Amount"
      expr: SUM(co_op_budget_amount)
    - name: "Average Co Op Budget Amount"
      expr: AVG(co_op_budget_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Display Budget Amount"
      expr: SUM(display_budget_amount)
    - name: "Average Display Budget Amount"
      expr: AVG(display_budget_amount)
    - name: "Total Feature Budget Amount"
      expr: SUM(feature_budget_amount)
    - name: "Average Feature Budget Amount"
      expr: AVG(feature_budget_amount)
    - name: "Total Paid Amount"
      expr: SUM(paid_amount)
    - name: "Average Paid Amount"
      expr: AVG(paid_amount)
    - name: "Total Remaining Balance"
      expr: SUM(remaining_balance)
    - name: "Average Remaining Balance"
      expr: AVG(remaining_balance)
    - name: "Total Slotting Budget Amount"
      expr: SUM(slotting_budget_amount)
    - name: "Average Slotting Budget Amount"
      expr: AVG(slotting_budget_amount)
    - name: "Total Total Approved Amount"
      expr: SUM(total_approved_amount)
    - name: "Average Total Approved Amount"
      expr: AVG(total_approved_amount)
    - name: "Total Tpr Budget Amount"
      expr: SUM(tpr_budget_amount)
    - name: "Average Tpr Budget Amount"
      expr: AVG(tpr_budget_amount)
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`trade_volume_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume Rebate business metrics"
  source: "`food_beverage_ecm`.`trade`.`volume_rebate`"
  dimensions:
    - name: "Accrual Flag"
      expr: accrual_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Batch Reference"
      expr: batch_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Exclusive"
      expr: is_exclusive
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Notes"
      expr: notes
    - name: "Payment Method"
      expr: payment_method
    - name: "Rebate Calculation Timestamp"
      expr: rebate_calculation_timestamp
    - name: "Rebate Program Code"
      expr: rebate_program_code
    - name: "Rebate Program Name"
      expr: rebate_program_name
    - name: "Rebate Type"
      expr: rebate_type
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Region Code"
      expr: region_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Volume Rebate"
      expr: COUNT(DISTINCT volume_rebate_id)
    - name: "Total Net Rebate Amount"
      expr: SUM(net_rebate_amount)
    - name: "Average Net Rebate Amount"
      expr: AVG(net_rebate_amount)
    - name: "Total Purchase Volume"
      expr: SUM(purchase_volume)
    - name: "Average Purchase Volume"
      expr: AVG(purchase_volume)
    - name: "Total Rebate Amount"
      expr: SUM(rebate_amount)
    - name: "Average Rebate Amount"
      expr: AVG(rebate_amount)
    - name: "Total Rebate Rate"
      expr: SUM(rebate_rate)
    - name: "Average Rebate Rate"
      expr: AVG(rebate_rate)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Threshold Volume"
      expr: SUM(threshold_volume)
    - name: "Average Threshold Volume"
      expr: AVG(threshold_volume)
$$;