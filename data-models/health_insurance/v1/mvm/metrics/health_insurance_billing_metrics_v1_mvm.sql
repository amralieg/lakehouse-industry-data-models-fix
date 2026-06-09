-- Metric views for domain: billing | Business: Health Insurance | Version: 1 | Generated on: 2026-05-03 21:24:37

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account business metrics"
  source: "`health_insurance_ecm`.`billing`.`account`"
  dimensions:
    - name: "Account Number"
      expr: account_number
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Auto Pay Authorization Date"
      expr: auto_pay_authorization_date
    - name: "Auto Pay Authorization Flag"
      expr: auto_pay_authorization_flag
    - name: "Auto Pay Enrollment"
      expr: auto_pay_enrollment
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Calendar Reference"
      expr: billing_calendar_reference
    - name: "Billing Cycle Type"
      expr: billing_cycle_type
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Billing Method"
      expr: billing_method
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Account"
      expr: COUNT(DISTINCT account_id)
    - name: "Total Aptc Amount"
      expr: SUM(aptc_amount)
    - name: "Average Aptc Amount"
      expr: AVG(aptc_amount)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Current Balance"
      expr: SUM(current_balance)
    - name: "Average Current Balance"
      expr: AVG(current_balance)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Payment Due Amount"
      expr: SUM(payment_due_amount)
    - name: "Average Payment Due Amount"
      expr: AVG(payment_due_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_aptc_subsidy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aptc Subsidy business metrics"
  source: "`health_insurance_ecm`.`billing`.`aptc_subsidy`"
  dimensions:
    - name: "Aptc Subsidy Status"
      expr: aptc_subsidy_status
    - name: "Cms Reconciliation Status"
      expr: cms_reconciliation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Csr Variant"
      expr: csr_variant
    - name: "Exchange Code"
      expr: exchange_code
    - name: "Source System"
      expr: source_system
    - name: "Subsidy Effective Date"
      expr: subsidy_effective_date
    - name: "Subsidy Number"
      expr: subsidy_number
    - name: "Subsidy Termination Date"
      expr: subsidy_termination_date
    - name: "Subsidy Type"
      expr: subsidy_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Subsidy Effective Date Month"
      expr: DATE_TRUNC('MONTH', subsidy_effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Aptc Subsidy"
      expr: COUNT(DISTINCT aptc_subsidy_id)
    - name: "Total Annual Aptc Cap"
      expr: SUM(annual_aptc_cap)
    - name: "Average Annual Aptc Cap"
      expr: AVG(annual_aptc_cap)
    - name: "Total Aptc Monthly Amount"
      expr: SUM(aptc_monthly_amount)
    - name: "Average Aptc Monthly Amount"
      expr: AVG(aptc_monthly_amount)
    - name: "Total Ytd Aptc Applied"
      expr: SUM(ytd_aptc_applied)
    - name: "Average Ytd Aptc Applied"
      expr: AVG(ytd_aptc_applied)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle business metrics"
  source: "`health_insurance_ecm`.`billing`.`cycle`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency Months"
      expr: billing_frequency_months
    - name: "Billing Method"
      expr: billing_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Cycle Code"
      expr: cycle_code
    - name: "Cycle Description"
      expr: cycle_description
    - name: "Cycle Status"
      expr: cycle_status
    - name: "Cycle Type"
      expr: cycle_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Invoice Day Of Month"
      expr: invoice_day_of_month
    - name: "Is Pro Rata"
      expr: is_pro_rata
    - name: "Last Invoice Date"
      expr: last_invoice_date
    - name: "Next Invoice Date"
      expr: next_invoice_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cycle"
      expr: COUNT(DISTINCT cycle_id)
    - name: "Total Default Premium Amount"
      expr: SUM(default_premium_amount)
    - name: "Average Default Premium Amount"
      expr: AVG(default_premium_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Premium Amount"
      expr: SUM(net_premium_amount)
    - name: "Average Net Premium Amount"
      expr: AVG(net_premium_amount)
    - name: "Total Prorated Amount"
      expr: SUM(prorated_amount)
    - name: "Average Prorated Amount"
      expr: AVG(prorated_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_grace_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grace Period business metrics"
  source: "`health_insurance_ecm`.`billing`.`grace_period`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Count"
      expr: day_count
    - name: "End Date"
      expr: end_date
    - name: "Extension End Date"
      expr: extension_end_date
    - name: "Extension Flag"
      expr: extension_flag
    - name: "Grace Period Description"
      expr: grace_period_description
    - name: "Grace Period Number"
      expr: grace_period_number
    - name: "Grace Period Status"
      expr: grace_period_status
    - name: "Grace Period Type"
      expr: grace_period_type
    - name: "Is Eligible For Aptc"
      expr: is_eligible_for_aptc
    - name: "Jurisdiction"
      expr: jurisdiction
    - name: "Notes"
      expr: notes
    - name: "Outcome"
      expr: outcome
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Received Date"
      expr: payment_received_date
    - name: "Reason Code"
      expr: reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Grace Period"
      expr: COUNT(DISTINCT grace_period_id)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`health_insurance_ecm`.`billing`.`invoice_line`"
  dimensions:
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Adjustment Reason Description"
      expr: adjustment_reason_description
    - name: "Billing Period End"
      expr: billing_period_end
    - name: "Billing Period Start"
      expr: billing_period_start
    - name: "Coverage End Date"
      expr: coverage_end_date
    - name: "Coverage Start Date"
      expr: coverage_start_date
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Is Refund"
      expr: is_refund
    - name: "Line Sequence"
      expr: line_sequence
    - name: "Payment Due Date"
      expr: payment_due_date
    - name: "Payment Status"
      expr: payment_status
    - name: "Premium Currency"
      expr: premium_currency
    - name: "Premium Line Description"
      expr: premium_line_description
    - name: "Premium Reconciliation Flag"
      expr: premium_reconciliation_flag
    - name: "Premium Source System"
      expr: premium_source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
    - name: "Total Aptc Subsidy Amount"
      expr: SUM(aptc_subsidy_amount)
    - name: "Average Aptc Subsidy Amount"
      expr: AVG(aptc_subsidy_amount)
    - name: "Total Csr Adjustment Amount"
      expr: SUM(csr_adjustment_amount)
    - name: "Average Csr Adjustment Amount"
      expr: AVG(csr_adjustment_amount)
    - name: "Total Employee Contribution"
      expr: SUM(employee_contribution)
    - name: "Average Employee Contribution"
      expr: AVG(employee_contribution)
    - name: "Total Employer Contribution"
      expr: SUM(employer_contribution)
    - name: "Average Employer Contribution"
      expr: AVG(employer_contribution)
    - name: "Total Premium Amount"
      expr: SUM(premium_amount)
    - name: "Average Premium Amount"
      expr: AVG(premium_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_payment_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Allocation business metrics"
  source: "`health_insurance_ecm`.`billing`.`payment_allocation`"
  dimensions:
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Sequence"
      expr: allocation_sequence
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Overpayment"
      expr: is_overpayment
    - name: "Is Suspense Resolution"
      expr: is_suspense_resolution
    - name: "Notes"
      expr: notes
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Reconciliation Period"
      expr: reconciliation_period
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Reconciliation Type"
      expr: reconciliation_type
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Allocation"
      expr: COUNT(DISTINCT payment_allocation_id)
    - name: "Total Allocated Amount"
      expr: SUM(allocated_amount)
    - name: "Average Allocated Amount"
      expr: AVG(allocated_amount)
    - name: "Total Allocated Quantity"
      expr: SUM(allocated_quantity)
    - name: "Average Allocated Quantity"
      expr: AVG(allocated_quantity)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Adjustments"
      expr: SUM(total_adjustments)
    - name: "Average Total Adjustments"
      expr: AVG(total_adjustments)
    - name: "Total Total Billed"
      expr: SUM(total_billed)
    - name: "Average Total Billed"
      expr: AVG(total_billed)
    - name: "Total Total Collected"
      expr: SUM(total_collected)
    - name: "Average Total Collected"
      expr: AVG(total_collected)
    - name: "Total Variance Amount"
      expr: SUM(variance_amount)
    - name: "Average Variance Amount"
      expr: AVG(variance_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_payment_method`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Method business metrics"
  source: "`health_insurance_ecm`.`billing`.`payment_method`"
  dimensions:
    - name: "Authorization Date"
      expr: authorization_date
    - name: "Authorization Reference"
      expr: authorization_reference
    - name: "Bank Name"
      expr: bank_name
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country"
      expr: billing_country
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State"
      expr: billing_state
    - name: "Card Expiration Date"
      expr: card_expiration_date
    - name: "Card Last Four"
      expr: card_last_four
    - name: "Card Type"
      expr: card_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Holder Name"
      expr: holder_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Method"
      expr: COUNT(DISTINCT payment_method_id)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium Invoice business metrics"
  source: "`health_insurance_ecm`.`billing`.`premium_invoice`"
  dimensions:
    - name: "Billing Period End"
      expr: billing_period_end
    - name: "Billing Period Start"
      expr: billing_period_start
    - name: "Collection Status"
      expr: collection_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Due Date"
      expr: due_date
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Invoice Type"
      expr: invoice_type
    - name: "Is Eligible For Subsidy"
      expr: is_eligible_for_subsidy
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Line Of Business"
      expr: line_of_business
    - name: "Notes"
      expr: notes
    - name: "Payment Channel"
      expr: payment_channel
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Premium Invoice"
      expr: COUNT(DISTINCT premium_invoice_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Amount Due"
      expr: SUM(net_amount_due)
    - name: "Average Net Amount Due"
      expr: AVG(net_amount_due)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Retroactive Adjustment Amount"
      expr: SUM(retroactive_adjustment_amount)
    - name: "Average Retroactive Adjustment Amount"
      expr: AVG(retroactive_adjustment_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Premium Amount"
      expr: SUM(total_premium_amount)
    - name: "Average Total Premium Amount"
      expr: AVG(total_premium_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium Payment business metrics"
  source: "`health_insurance_ecm`.`billing`.`premium_payment`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Nsf Indicator"
      expr: nsf_indicator
    - name: "Payer Account Number"
      expr: payer_account_number
    - name: "Payer Name"
      expr: payer_name
    - name: "Payer Type"
      expr: payer_type
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Payment Description"
      expr: payment_description
    - name: "Payment Number"
      expr: payment_number
    - name: "Payment Timestamp"
      expr: payment_timestamp
    - name: "Premium Payment Status"
      expr: premium_payment_status
    - name: "Reconciliation Status"
      expr: reconciliation_status
    - name: "Resolution Date"
      expr: resolution_date
    - name: "Resolution Due Date"
      expr: resolution_due_date
    - name: "Resolution Outcome"
      expr: resolution_outcome
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Premium Payment"
      expr: COUNT(DISTINCT premium_payment_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
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
    - name: "Total Unapplied Amount"
      expr: SUM(unapplied_amount)
    - name: "Average Unapplied Amount"
      expr: AVG(unapplied_amount)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_premium_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premium Rate business metrics"
  source: "`health_insurance_ecm`.`billing`.`premium_rate`"
  dimensions:
    - name: "Age Band"
      expr: age_band
    - name: "Coverage Tier"
      expr: coverage_tier
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Family Tier Structure"
      expr: family_tier_structure
    - name: "Market Segment"
      expr: market_segment
    - name: "Premium Rate Status"
      expr: premium_rate_status
    - name: "Premium Type"
      expr: premium_type
    - name: "Rating Method"
      expr: rating_method
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Premium Rate"
      expr: COUNT(DISTINCT premium_rate_id)
    - name: "Total Aptc Amount"
      expr: SUM(aptc_amount)
    - name: "Average Aptc Amount"
      expr: AVG(aptc_amount)
    - name: "Total Cobra Rate"
      expr: SUM(cobra_rate)
    - name: "Average Cobra Rate"
      expr: AVG(cobra_rate)
    - name: "Total Employee Contribution Rate"
      expr: SUM(employee_contribution_rate)
    - name: "Average Employee Contribution Rate"
      expr: AVG(employee_contribution_rate)
    - name: "Total Employer Contribution Rate"
      expr: SUM(employer_contribution_rate)
    - name: "Average Employer Contribution Rate"
      expr: AVG(employer_contribution_rate)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Tobacco Surcharge Rate"
      expr: SUM(tobacco_surcharge_rate)
    - name: "Average Tobacco Surcharge Rate"
      expr: AVG(tobacco_surcharge_rate)
    - name: "Total Wellness Discount Rate"
      expr: SUM(wellness_discount_rate)
    - name: "Average Wellness Discount Rate"
      expr: AVG(wellness_discount_rate)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Schedule business metrics"
  source: "`health_insurance_ecm`.`billing`.`rate_schedule`"
  dimensions:
    - name: "Applicable Year"
      expr: applicable_year
    - name: "Coverage Type"
      expr: coverage_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Family Tier Structure"
      expr: family_tier_structure
    - name: "Filing Date"
      expr: filing_date
    - name: "Filing Status"
      expr: filing_status
    - name: "Is Default Schedule"
      expr: is_default_schedule
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Market Segment"
      expr: market_segment
    - name: "Premium Type"
      expr: premium_type
    - name: "Rate Schedule Description"
      expr: rate_schedule_description
    - name: "Rate Schedule Status"
      expr: rate_schedule_status
    - name: "Rating Area"
      expr: rating_area
    - name: "Rating Method"
      expr: rating_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Schedule"
      expr: COUNT(DISTINCT rate_schedule_id)
    - name: "Total Aptc Amount"
      expr: SUM(aptc_amount)
    - name: "Average Aptc Amount"
      expr: AVG(aptc_amount)
    - name: "Total Cobra Rate"
      expr: SUM(cobra_rate)
    - name: "Average Cobra Rate"
      expr: AVG(cobra_rate)
    - name: "Total Employee Contribution Rate"
      expr: SUM(employee_contribution_rate)
    - name: "Average Employee Contribution Rate"
      expr: AVG(employee_contribution_rate)
    - name: "Total Employer Contribution Rate"
      expr: SUM(employer_contribution_rate)
    - name: "Average Employer Contribution Rate"
      expr: AVG(employer_contribution_rate)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
    - name: "Total Subsidy Amount"
      expr: SUM(subsidy_amount)
    - name: "Average Subsidy Amount"
      expr: AVG(subsidy_amount)
    - name: "Total Tobacco Surcharge Rate"
      expr: SUM(tobacco_surcharge_rate)
    - name: "Average Tobacco Surcharge Rate"
      expr: AVG(tobacco_surcharge_rate)
    - name: "Total Wellness Discount Rate"
      expr: SUM(wellness_discount_rate)
    - name: "Average Wellness Discount Rate"
      expr: AVG(wellness_discount_rate)
$$;

CREATE OR REPLACE VIEW `health_insurance_ecm`.`_metrics`.`billing_retro_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retro Adjustment business metrics"
  source: "`health_insurance_ecm`.`billing`.`retro_adjustment`"
  dimensions:
    - name: "Adjustment Number"
      expr: adjustment_number
    - name: "Adjustment Status"
      expr: adjustment_status
    - name: "Adjustment Timestamp"
      expr: adjustment_timestamp
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Authorization Reference"
      expr: authorization_reference
    - name: "Credit Memo Reference"
      expr: credit_memo_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Open Date"
      expr: dispute_open_date
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Dispute Type"
      expr: dispute_type
    - name: "Original Billing Period End"
      expr: original_billing_period_end
    - name: "Original Billing Period Start"
      expr: original_billing_period_start
    - name: "Reason Code"
      expr: reason_code
    - name: "Record Audit Created"
      expr: record_audit_created
    - name: "Record Audit Updated"
      expr: record_audit_updated
    - name: "Resolution Date"
      expr: resolution_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retro Adjustment"
      expr: COUNT(DISTINCT retro_adjustment_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
$$;