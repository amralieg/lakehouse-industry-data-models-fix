-- Metric views for domain: billing | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice metrics tracking billing performance, revenue, outstanding balances, and payment efficiency for the transport shipping business."
  source: "`transport_shipping_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current lifecycle status of the invoice (e.g., draft, sent, paid, overdue, cancelled)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (e.g., standard, proforma, credit, debit)"
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the invoice"
    - name: "service_line"
      expr: service_line
      comment: "Business service line (e.g., express, freight, supply chain) generating the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment expected or received for the invoice"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month in which the invoice was issued for trend analysis"
    - name: "bill_to_country_code"
      expr: bill_to_country_code
      comment: "Country of the bill-to party for geographic revenue analysis"
    - name: "revenue_recognition_status"
      expr: revenue_recognition_status
      comment: "Status of revenue recognition under accounting standards"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross invoiced amount representing top-line billing revenue"
    - name: "total_amount_outstanding"
      expr: SUM(CAST(amount_outstanding AS DOUBLE))
      comment: "Total unpaid balance across invoices indicating collection exposure"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total payments received against invoices"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on invoices for tax liability reporting"
    - name: "total_discount_given"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to invoices impacting net revenue"
    - name: "avg_invoice_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value indicating typical transaction size"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued in the period"
    - name: "distinct_customer_count"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers billed, indicating billing breadth"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection metrics tracking cash inflows, payment methods, reconciliation status, and collection efficiency."
  source: "`transport_shipping_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., received, cleared, reversed, pending)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire, check, card, ACH)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payment was made"
    - name: "clearing_status"
      expr: clearing_status
      comment: "Bank clearing status of the payment"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Whether payment has been reconciled to bank statement"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received (e.g., online, branch, lockbox)"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment for cash flow trend analysis"
    - name: "business_unit_code"
      expr: business_unit_code
      comment: "Business unit receiving the payment"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Whether the payment is associated with a dispute"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total cash collected from customers"
    - name: "total_early_payment_discount"
      expr: SUM(CAST(early_payment_discount_amount AS DOUBLE))
      comment: "Total early payment discounts granted, indicating discount cost to accelerate collections"
    - name: "total_bank_charges"
      expr: SUM(CAST(bank_charges AS DOUBLE))
      comment: "Total bank processing fees incurred on payments"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax deducted from payments"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment size indicating typical collection amount"
    - name: "total_unapplied_balance"
      expr: SUM(CAST(unapplied_balance AS DOUBLE))
      comment: "Total unapplied cash requiring allocation to invoices"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed"
    - name: "distinct_paying_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers making payments"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_receivable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and credit risk metrics for monitoring collection health, DSO, and bad debt exposure."
  source: "`transport_shipping_ecm`.`billing`.`receivable`"
  dimensions:
    - name: "aging_bucket"
      expr: aging_bucket
      comment: "AR aging classification (current, 1-30, 31-60, 61-90, 90+)"
    - name: "credit_risk_rating"
      expr: credit_risk_rating
      comment: "Credit risk classification of the customer account"
    - name: "company_code"
      expr: company_code
      comment: "Legal entity code for multi-entity AR reporting"
    - name: "business_area"
      expr: business_area
      comment: "Business area for segmented AR analysis"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation status of the receivable balance"
    - name: "write_off_status"
      expr: write_off_status
      comment: "Whether the receivable has been written off or is pending write-off"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level for the account"
    - name: "snapshot_month"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month of the AR snapshot for trend analysis"
  measures:
    - name: "total_ar_balance"
      expr: SUM(CAST(ar_balance_amount AS DOUBLE))
      comment: "Total accounts receivable balance outstanding"
    - name: "total_current_amount"
      expr: SUM(CAST(current_amount AS DOUBLE))
      comment: "Total AR amount not yet past due"
    - name: "total_overdue_1_30"
      expr: SUM(CAST(days_1_30_amount AS DOUBLE))
      comment: "Total AR overdue 1-30 days"
    - name: "total_overdue_31_60"
      expr: SUM(CAST(days_31_60_amount AS DOUBLE))
      comment: "Total AR overdue 31-60 days"
    - name: "total_overdue_61_90"
      expr: SUM(CAST(days_61_90_amount AS DOUBLE))
      comment: "Total AR overdue 61-90 days"
    - name: "total_overdue_over_90"
      expr: SUM(CAST(days_over_90_amount AS DOUBLE))
      comment: "Total AR overdue more than 90 days — highest collection risk"
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision booked against receivables"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total receivable amount under dispute"
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total receivable amounts written off as uncollectable"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_percentage AS DOUBLE))
      comment: "Average credit utilization across accounts indicating credit risk concentration"
    - name: "distinct_accounts"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique billing accounts with receivable balances"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing dispute metrics tracking dispute volumes, resolution effectiveness, financial exposure, and service quality impact."
  source: "`transport_shipping_ecm`.`billing`.`billing_dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (open, investigating, resolved, closed)"
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of billing dispute (overcharge, service failure, weight discrepancy, etc.)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "High-level category of the dispute for root cause analysis"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority classification of the dispute"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the dispute"
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the dispute was resolved (credit note, rebill, rejected, etc.)"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification for systemic issue identification"
    - name: "service_failure_type"
      expr: service_failure_type
      comment: "Type of service failure that triggered the dispute"
    - name: "raised_month"
      expr: DATE_TRUNC('month', raised_date)
      comment: "Month when dispute was raised for trend analysis"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the dispute resolution breached SLA targets"
  measures:
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total financial value of disputed charges representing revenue at risk"
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total amount credited/adjusted in dispute resolutions"
    - name: "dispute_count"
      expr: COUNT(1)
      comment: "Total number of billing disputes raised"
    - name: "avg_disputed_amount"
      expr: AVG(CAST(disputed_amount AS DOUBLE))
      comment: "Average dispute value indicating typical dispute severity"
    - name: "distinct_customers_disputing"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers raising disputes indicating breadth of billing issues"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_credit_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit note metrics tracking revenue reversals, credit issuance patterns, and their impact on net revenue."
  source: "`transport_shipping_ecm`.`billing`.`credit_note`"
  dimensions:
    - name: "credit_type"
      expr: credit_type
      comment: "Type of credit note (service failure, pricing error, goodwill, etc.)"
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Reason code for credit issuance for root cause analysis"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the credit note"
    - name: "application_status"
      expr: application_status
      comment: "Whether the credit has been applied to an invoice"
    - name: "service_line"
      expr: service_line
      comment: "Service line against which the credit was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit note"
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month of credit note issuance for trend analysis"
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the credit note was auto-generated vs manually created"
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(total_credit_amount AS DOUBLE))
      comment: "Total credit notes issued representing revenue leakage"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total credit amount applied against invoices"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total unapplied credit balance outstanding"
    - name: "total_tax_on_credits"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax adjustments on credit notes"
    - name: "credit_note_count"
      expr: COUNT(1)
      comment: "Total number of credit notes issued"
    - name: "avg_credit_amount"
      expr: AVG(CAST(total_credit_amount AS DOUBLE))
      comment: "Average credit note value indicating typical adjustment size"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_carrier_payable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier payable metrics tracking transportation cost management, payment timeliness, and carrier financial relationships."
  source: "`transport_shipping_ecm`.`billing`.`carrier_payable`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the carrier payable (pending, approved, paid, disputed)"
    - name: "service_type"
      expr: service_type
      comment: "Type of carrier service (express, ground, ocean, air freight)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the carrier payable"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay the carrier"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location for lane-level cost analysis"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location for lane-level cost analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of carrier invoice for cost trend analysis"
  measures:
    - name: "total_payable_amount"
      expr: SUM(CAST(payable_amount AS DOUBLE))
      comment: "Total gross amount payable to carriers representing transportation cost"
    - name: "total_net_payable"
      expr: SUM(CAST(net_payable_amount AS DOUBLE))
      comment: "Total net payable after discounts and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts negotiated with carriers"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on carrier payables"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight for cost-per-kg analysis"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume shipped for cost-per-cbm analysis"
    - name: "avg_payable_per_shipment"
      expr: AVG(CAST(payable_amount AS DOUBLE))
      comment: "Average carrier cost per payable record indicating unit economics"
    - name: "carrier_payable_count"
      expr: COUNT(1)
      comment: "Total number of carrier payable records"
    - name: "distinct_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers with payables indicating supplier diversity"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_freight_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight audit metrics tracking carrier invoice accuracy, variance identification, and cost savings captured through audit processes."
  source: "`transport_shipping_ecm`.`billing`.`freight_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the freight audit (in progress, completed, disputed)"
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (overcharge, undercharge, duplicate, etc.)"
    - name: "service_type"
      expr: service_type
      comment: "Service type being audited"
    - name: "resolution_action"
      expr: resolution_action
      comment: "Action taken to resolve the audit finding"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the carrier breached SLA terms"
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location for lane-level audit analysis"
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location for lane-level audit analysis"
    - name: "audit_month"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Month of carrier invoice for audit trend analysis"
  measures:
    - name: "total_carrier_invoiced_amount"
      expr: SUM(CAST(carrier_invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced by carriers subject to audit"
    - name: "total_contracted_rate_amount"
      expr: SUM(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Total expected amount based on contracted rates"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total billing variance identified (overcharges minus undercharges)"
    - name: "total_savings_captured"
      expr: SUM(CAST(savings_captured_amount AS DOUBLE))
      comment: "Total cost savings recovered through the audit process"
    - name: "total_fuel_surcharge"
      expr: SUM(CAST(fuel_surcharge_amount AS DOUBLE))
      comment: "Total fuel surcharges billed by carriers"
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges_amount AS DOUBLE))
      comment: "Total accessorial charges billed by carriers"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average billing variance percentage indicating carrier invoice accuracy"
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of freight audits performed"
    - name: "distinct_carriers_audited"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Number of unique carriers audited"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking IFRS 15 compliance, recognized vs deferred revenue, and recognition patterns across service types."
  source: "`transport_shipping_ecm`.`billing`.`revenue_recognition`"
  dimensions:
    - name: "recognition_method"
      expr: recognition_method
      comment: "Revenue recognition method applied (point-in-time, over-time, percentage-of-completion)"
    - name: "recognition_trigger"
      expr: recognition_trigger
      comment: "Event that triggered revenue recognition (delivery, milestone, time-based)"
    - name: "service_type"
      expr: service_type
      comment: "Service type for which revenue is being recognized"
    - name: "company_code"
      expr: company_code
      comment: "Legal entity recognizing the revenue"
    - name: "business_area"
      expr: business_area
      comment: "Business area for segmented revenue analysis"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period of recognition for period-close reporting"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Whether this is a revenue reversal entry"
    - name: "ifrs15_compliance_flag"
      expr: ifrs15_compliance_flag
      comment: "Whether the recognition is IFRS 15 compliant"
    - name: "recognition_month"
      expr: DATE_TRUNC('month', recognition_date)
      comment: "Month of revenue recognition for trend analysis"
  measures:
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized in the period per accounting standards"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods"
    - name: "total_transaction_price_allocated"
      expr: SUM(CAST(transaction_price_allocated AS DOUBLE))
      comment: "Total transaction price allocated to performance obligations"
    - name: "total_variable_consideration"
      expr: SUM(CAST(variable_consideration_amount AS DOUBLE))
      comment: "Total variable consideration estimated in transaction prices"
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average completion progress for over-time recognition obligations"
    - name: "recognition_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_dunning_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collections metrics tracking overdue account management, escalation effectiveness, and collection recovery."
  source: "`transport_shipping_ecm`.`billing`.`dunning_record`"
  dimensions:
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level (1=reminder, 2=warning, 3=final notice, etc.)"
    - name: "dunning_status"
      expr: dunning_status
      comment: "Status of the dunning action (sent, acknowledged, escalated, resolved)"
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for dunning communication (email, letter, phone, SMS)"
    - name: "customer_response_type"
      expr: customer_response_type
      comment: "Type of customer response to dunning (promise to pay, dispute, no response)"
    - name: "service_line"
      expr: service_line
      comment: "Service line associated with the overdue amount"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit managing the collection"
    - name: "dunning_month"
      expr: DATE_TRUNC('month', dunning_date)
      comment: "Month of dunning action for trend analysis"
    - name: "collections_agency_referral_flag"
      expr: collections_agency_referral_flag
      comment: "Whether the account has been referred to external collections"
    - name: "write_off_recommendation_flag"
      expr: write_off_recommendation_flag
      comment: "Whether a write-off has been recommended for this account"
  measures:
    - name: "total_overdue_amount"
      expr: SUM(CAST(total_overdue_amount AS DOUBLE))
      comment: "Total overdue amount under dunning representing collection exposure"
    - name: "total_dunning_fees"
      expr: SUM(CAST(dunning_fee_amount AS DOUBLE))
      comment: "Total dunning fees charged to overdue accounts"
    - name: "total_interest_charges"
      expr: SUM(CAST(interest_charge_amount AS DOUBLE))
      comment: "Total interest charges on overdue balances"
    - name: "total_promised_payment"
      expr: SUM(CAST(promised_payment_amount AS DOUBLE))
      comment: "Total amount customers have promised to pay"
    - name: "dunning_record_count"
      expr: COUNT(1)
      comment: "Total number of dunning actions taken"
    - name: "distinct_accounts_dunned"
      expr: COUNT(DISTINCT billing_account_id)
      comment: "Number of unique accounts under dunning indicating collection breadth"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write-off metrics tracking bad debt losses, recovery rates, and write-off patterns for credit risk management."
  source: "`transport_shipping_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Status of the write-off (pending approval, approved, posted, reversed)"
    - name: "write_off_type"
      expr: write_off_type
      comment: "Type of write-off (bad debt, small balance, insolvency, etc.)"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the write-off for root cause analysis"
    - name: "company_code"
      expr: company_code
      comment: "Legal entity posting the write-off"
    - name: "business_area"
      expr: business_area
      comment: "Business area for segmented write-off analysis"
    - name: "service_line"
      expr: service_line
      comment: "Service line associated with the written-off receivable"
    - name: "write_off_month"
      expr: DATE_TRUNC('month', write_off_date)
      comment: "Month of write-off for trend analysis"
    - name: "recovery_flag"
      expr: recovery_flag
      comment: "Whether any recovery has been made post write-off"
    - name: "legal_action_flag"
      expr: legal_action_flag
      comment: "Whether legal action was pursued before write-off"
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount written off as uncollectable bad debt"
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered post write-off"
    - name: "total_bad_debt_provision_released"
      expr: SUM(CAST(bad_debt_provision_release_amount AS DOUBLE))
      comment: "Total provision released upon write-off"
    - name: "net_write_off_impact_total"
      expr: SUM(CAST(net_write_off_impact AS DOUBLE))
      comment: "Net P&L impact of write-offs after provision releases"
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Total number of write-off transactions"
    - name: "avg_write_off_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average write-off value indicating typical loss severity"
    - name: "distinct_customers_written_off"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with write-offs indicating credit quality issues"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_consolidated_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consolidated invoice metrics for enterprise customers tracking billing aggregation, payment performance, and dispute rates on consolidated bills."
  source: "`transport_shipping_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Status of the consolidated invoice"
    - name: "service_line"
      expr: service_line
      comment: "Service line for the consolidated billing"
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the consolidated invoice"
  measures:
    - name: "consolidated_invoice_count"
      expr: COUNT(1)
      comment: "Total number of consolidated invoices issued"
    - name: "distinct_enterprise_customers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique enterprise customers on consolidated billing"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`billing_charge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge event metrics tracking billing event generation, charge categorization, and revenue pipeline from operational events to invoicing."
  source: "`transport_shipping_ecm`.`billing`.`charge_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of charge event (shipment delivery, milestone, time-based, accessorial)"
    - name: "charge_category"
      expr: charge_category
      comment: "Category of charge (freight, fuel surcharge, handling, customs, etc.)"
    - name: "service_type"
      expr: service_type
      comment: "Service type generating the charge event"
    - name: "audit_status"
      expr: audit_status
      comment: "Audit status of the charge event"
    - name: "invoice_generation_status"
      expr: invoice_generation_status
      comment: "Whether the charge has been converted to an invoice line"
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit generating the charge"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the charge event is disputed"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month of charge event for pipeline analysis"
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount generated from operational events"
    - name: "total_chargeable_weight_kg"
      expr: SUM(CAST(chargeable_weight_kg AS DOUBLE))
      comment: "Total chargeable weight driving revenue"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total volume generating charges"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per event indicating pricing effectiveness"
    - name: "charge_event_count"
      expr: COUNT(1)
      comment: "Total number of charge events generated"
    - name: "distinct_consignments_charged"
      expr: COUNT(DISTINCT consignment_id)
      comment: "Number of unique consignments generating charges"
$$;