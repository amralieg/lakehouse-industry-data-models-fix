-- Metric views for domain: billing | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice metrics tracking revenue, payment performance, and dispute rates across billing cycles, customers, and service types"
  source: "`shipping_ports_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., draft, issued, paid, disputed, cancelled)"
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "invoice_year"
      expr: YEAR(invoice_date)
      comment: "Year the invoice was issued"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month the invoice was issued"
    - name: "due_date"
      expr: due_date
      comment: "Payment due date for the invoice"
    - name: "service_type"
      expr: service_type
      comment: "Type of port service billed (e.g., vessel services, cargo handling, storage)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the invoice is denominated"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with customer (e.g., Net 30, Net 60)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g., wire transfer, check, ACH)"
    - name: "revenue_recognition_date"
      expr: revenue_recognition_date
      comment: "Date when revenue is recognized for accounting purposes"
    - name: "is_disputed"
      expr: CASE WHEN dispute_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the invoice has been disputed"
    - name: "is_paid"
      expr: CASE WHEN payment_received_date IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether payment has been received"
    - name: "is_overdue"
      expr: CASE WHEN due_date < CURRENT_DATE() AND payment_received_date IS NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether the invoice is past due and unpaid"
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of invoices issued"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross invoice amount across all invoices"
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax invoice amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted to customers"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustments applied to invoices (positive or negative)"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice value per transaction"
    - name: "disputed_invoice_count"
      expr: COUNT(CASE WHEN dispute_date IS NOT NULL THEN 1 END)
      comment: "Number of invoices that have been disputed by customers"
    - name: "paid_invoice_count"
      expr: COUNT(CASE WHEN payment_received_date IS NOT NULL THEN 1 END)
      comment: "Number of invoices that have been paid"
    - name: "overdue_invoice_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND payment_received_date IS NULL THEN 1 END)
      comment: "Number of invoices past due date and still unpaid"
    - name: "total_baf_amount"
      expr: SUM(CAST(baf_amount AS DOUBLE))
      comment: "Total bunker adjustment factor surcharges applied"
    - name: "total_caf_amount"
      expr: SUM(CAST(caf_amount AS DOUBLE))
      comment: "Total currency adjustment factor surcharges applied"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customer accounts invoiced"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment performance metrics tracking cash collection, reconciliation efficiency, and payment channel effectiveness"
  source: "`shipping_ports_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., pending, cleared, reconciled, reversed)"
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was made by customer"
    - name: "payment_year"
      expr: YEAR(payment_date)
      comment: "Year the payment was made"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month the payment was made"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., wire transfer, check, credit card, ACH)"
    - name: "payment_type"
      expr: payment_type
      comment: "Type of payment (e.g., full payment, partial payment, advance payment)"
    - name: "channel"
      expr: channel
      comment: "Channel through which payment was received (e.g., online portal, bank transfer, in-person)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which payment was received"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of payment reconciliation against invoices"
    - name: "is_advance_payment"
      expr: is_advance_payment
      comment: "Flag indicating whether this is an advance payment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which payment was received"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period in which payment was received"
    - name: "is_reconciled"
      expr: CASE WHEN reconciled_timestamp IS NOT NULL THEN TRUE ELSE FALSE END
      comment: "Flag indicating whether payment has been reconciled"
  measures:
    - name: "total_payment_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions received"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected from customers across all payments"
    - name: "total_allocated_amount"
      expr: SUM(CAST(allocated_amount AS DOUBLE))
      comment: "Total payment amount successfully allocated to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total payment amount not yet allocated to specific invoices"
    - name: "total_discount_taken"
      expr: SUM(CAST(discount_taken AS DOUBLE))
      comment: "Total early payment discounts taken by customers"
    - name: "avg_payment_amount"
      expr: AVG(CAST(amount_paid AS DOUBLE))
      comment: "Average payment transaction size"
    - name: "reconciled_payment_count"
      expr: COUNT(CASE WHEN reconciled_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of payments successfully reconciled to invoices"
    - name: "advance_payment_count"
      expr: COUNT(CASE WHEN is_advance_payment = TRUE THEN 1 END)
      comment: "Number of advance payments received"
    - name: "unique_payer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customer accounts making payments"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_charge_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational charge event metrics tracking billable activities, exemptions, and dispute patterns at the transaction level"
  source: "`shipping_ports_ecm`.`billing`.`charge_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of billable event (e.g., vessel arrival, cargo handling, storage, pilotage)"
    - name: "billing_status"
      expr: billing_status
      comment: "Current billing status of the charge event (e.g., pending, billed, disputed, waived)"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date the billable event occurred"
    - name: "event_year"
      expr: YEAR(event_timestamp)
      comment: "Year the billable event occurred"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month the billable event occurred"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the charge is denominated"
    - name: "tariff_code"
      expr: tariff_code
      comment: "Tariff code applied to the charge"
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the charge (e.g., per TEU, per ton, per hour)"
    - name: "is_disputed"
      expr: dispute_flag
      comment: "Flag indicating whether the charge has been disputed"
    - name: "is_exempt"
      expr: exemption_flag
      comment: "Flag indicating whether the charge is exempt from billing"
    - name: "is_hazmat"
      expr: hazmat_flag
      comment: "Flag indicating whether the charge relates to hazardous materials"
    - name: "is_reefer"
      expr: reefer_flag
      comment: "Flag indicating whether the charge relates to refrigerated cargo"
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the charge event"
  measures:
    - name: "total_charge_event_count"
      expr: COUNT(1)
      comment: "Total number of billable charge events generated"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total gross charge amount before discounts and adjustments"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge amount after discounts and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to charge events"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount applied to charge events"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units charged (e.g., total TEUs, total tons)"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate charged per unit of measure"
    - name: "disputed_charge_count"
      expr: COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END)
      comment: "Number of charge events disputed by customers"
    - name: "exempt_charge_count"
      expr: COUNT(CASE WHEN exemption_flag = TRUE THEN 1 END)
      comment: "Number of charge events granted exemption from billing"
    - name: "hazmat_charge_count"
      expr: COUNT(CASE WHEN hazmat_flag = TRUE THEN 1 END)
      comment: "Number of charge events related to hazardous materials"
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight in kilograms across all charge events"
    - name: "total_cargo_volume_cbm"
      expr: SUM(CAST(cargo_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters across all charge events"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customers generating charge events"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispute management metrics tracking resolution performance, root causes, and customer satisfaction with dispute handling"
  source: "`shipping_ports_ecm`.`billing`.`dispute`"
  dimensions:
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current status of the dispute (e.g., open, under investigation, resolved, escalated)"
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of dispute (e.g., pricing error, service quality, billing error, contract dispute)"
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the dispute"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause identified during investigation"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied (e.g., credit issued, charge waived, no action, partial credit)"
    - name: "lodged_date"
      expr: lodged_date
      comment: "Date the dispute was lodged by customer"
    - name: "lodged_year"
      expr: YEAR(lodged_date)
      comment: "Year the dispute was lodged"
    - name: "lodged_month"
      expr: DATE_TRUNC('MONTH', lodged_date)
      comment: "Month the dispute was lodged"
    - name: "resolution_date"
      expr: resolution_date
      comment: "Date the dispute was resolved"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level to which dispute has been escalated (e.g., L1, L2, management, legal)"
    - name: "is_sla_breach"
      expr: sla_breach_flag
      comment: "Flag indicating whether dispute resolution breached SLA"
    - name: "customer_satisfaction_rating"
      expr: customer_satisfaction_rating
      comment: "Customer satisfaction rating with dispute resolution"
    - name: "disputed_currency_code"
      expr: disputed_currency_code
      comment: "Currency of the disputed amount"
  measures:
    - name: "total_dispute_count"
      expr: COUNT(1)
      comment: "Total number of disputes lodged by customers"
    - name: "total_disputed_amount"
      expr: SUM(CAST(disputed_amount AS DOUBLE))
      comment: "Total amount in dispute across all open and resolved disputes"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued to resolve disputes"
    - name: "resolved_dispute_count"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Number of disputes successfully resolved"
    - name: "open_dispute_count"
      expr: COUNT(CASE WHEN resolution_date IS NULL THEN 1 END)
      comment: "Number of disputes currently open and unresolved"
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of disputes that breached resolution SLA"
    - name: "escalated_dispute_count"
      expr: COUNT(CASE WHEN escalation_date IS NOT NULL THEN 1 END)
      comment: "Number of disputes escalated beyond initial handling level"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customers lodging disputes"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_receivable_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts receivable aging and credit risk metrics tracking outstanding balances, payment behavior, and collection effectiveness"
  source: "`shipping_ports_ecm`.`billing`.`receivable_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the receivable account (e.g., active, suspended, closed, in collections)"
    - name: "account_classification"
      expr: account_classification
      comment: "Classification of the account (e.g., standard, VIP, high-risk, government)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning level for overdue accounts (e.g., Level 1, Level 2, Final Notice)"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code for the account"
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred billing currency for the account"
    - name: "is_credit_hold"
      expr: credit_hold_flag
      comment: "Flag indicating whether account is on credit hold"
    - name: "is_auto_payment"
      expr: auto_payment_flag
      comment: "Flag indicating whether account uses automatic payment"
    - name: "billing_country"
      expr: billing_country
      comment: "Country of the billing address"
    - name: "tax_jurisdiction"
      expr: tax_jurisdiction
      comment: "Tax jurisdiction for the account"
  measures:
    - name: "total_account_count"
      expr: COUNT(1)
      comment: "Total number of receivable accounts"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivable balance across all accounts"
    - name: "total_aging_current"
      expr: SUM(CAST(aging_bucket_0_30_days AS DOUBLE))
      comment: "Total receivables aged 0-30 days"
    - name: "total_aging_31_60"
      expr: SUM(CAST(aging_bucket_31_60_days AS DOUBLE))
      comment: "Total receivables aged 31-60 days"
    - name: "total_aging_61_90"
      expr: SUM(CAST(aging_bucket_61_90_days AS DOUBLE))
      comment: "Total receivables aged 61-90 days"
    - name: "total_aging_over_90"
      expr: SUM(CAST(aging_bucket_over_90_days AS DOUBLE))
      comment: "Total receivables aged over 90 days (high collection risk)"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "avg_days_to_pay"
      expr: AVG(CAST(average_days_to_pay AS DOUBLE))
      comment: "Average days to pay across all accounts (payment velocity indicator)"
    - name: "total_write_off_ytd"
      expr: SUM(CAST(write_off_amount_ytd AS DOUBLE))
      comment: "Total amount written off year-to-date due to uncollectibility"
    - name: "credit_hold_account_count"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold"
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'active' THEN 1 END)
      comment: "Number of active receivable accounts"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_revenue_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition metrics tracking earned revenue, deferred revenue, and compliance with accounting standards (ASC 606 / IFRS 15)"
  source: "`shipping_ports_ecm`.`billing`.`revenue_event`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Status of revenue recognition (e.g., recognized, deferred, pending approval)"
    - name: "recognition_method"
      expr: recognition_method
      comment: "Method used for revenue recognition (e.g., point-in-time, over-time, milestone-based)"
    - name: "revenue_stream_category"
      expr: revenue_stream_category
      comment: "Category of revenue stream (e.g., vessel services, cargo handling, storage, ancillary)"
    - name: "recognition_date"
      expr: recognition_date
      comment: "Date revenue was recognized"
    - name: "recognition_year"
      expr: YEAR(recognition_date)
      comment: "Year revenue was recognized"
    - name: "recognition_month"
      expr: DATE_TRUNC('MONTH', recognition_date)
      comment: "Month revenue was recognized"
    - name: "accounting_period"
      expr: accounting_period
      comment: "Accounting period for revenue recognition"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for revenue recognition"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which revenue is recognized"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the revenue event"
    - name: "is_reversal"
      expr: reversal_flag
      comment: "Flag indicating whether this is a revenue reversal"
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the revenue event"
  measures:
    - name: "total_revenue_event_count"
      expr: COUNT(1)
      comment: "Total number of revenue recognition events"
    - name: "total_recognized_revenue"
      expr: SUM(CAST(recognized_revenue_amount AS DOUBLE))
      comment: "Total revenue recognized in the period (earned revenue)"
    - name: "total_deferred_revenue"
      expr: SUM(CAST(deferred_revenue_amount AS DOUBLE))
      comment: "Total revenue deferred to future periods (unearned revenue liability)"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments applied (positive or negative)"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units for which revenue was recognized"
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate for revenue recognition"
    - name: "reversal_event_count"
      expr: COUNT(CASE WHEN reversal_flag = TRUE THEN 1 END)
      comment: "Number of revenue reversal events"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customers for whom revenue was recognized"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing cycle performance metrics tracking cycle throughput, billing accuracy, and operational efficiency"
  source: "`shipping_ports_ecm`.`billing`.`billing_cycle`"
  dimensions:
    - name: "cycle_status"
      expr: cycle_status
      comment: "Current status of the billing cycle (e.g., open, closed, in-progress, cancelled)"
    - name: "cycle_type"
      expr: cycle_type
      comment: "Type of billing cycle (e.g., monthly, weekly, ad-hoc, adjustment)"
    - name: "cycle_code"
      expr: cycle_code
      comment: "Unique code identifying the billing cycle"
    - name: "start_date"
      expr: start_date
      comment: "Start date of the billing cycle"
    - name: "end_date"
      expr: end_date
      comment: "End date of the billing cycle"
    - name: "cycle_year"
      expr: YEAR(start_date)
      comment: "Year the billing cycle started"
    - name: "cycle_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the billing cycle started"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for the billing cycle"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter for the billing cycle"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the billing cycle"
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency for the billing cycle"
    - name: "is_adjustment_cycle"
      expr: is_adjustment_cycle
      comment: "Flag indicating whether this is an adjustment cycle"
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the billing cycle is currently active"
  measures:
    - name: "total_billing_cycle_count"
      expr: COUNT(1)
      comment: "Total number of billing cycles"
    - name: "total_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed across all cycles"
    - name: "total_net_amount"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount after discounts and adjustments"
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discount amount applied across cycles"
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax amount collected across cycles"
    - name: "avg_late_fee_percentage"
      expr: AVG(CAST(late_fee_percentage AS DOUBLE))
      comment: "Average late fee percentage applied across cycles"
    - name: "closed_cycle_count"
      expr: COUNT(CASE WHEN cycle_closed_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of billing cycles that have been closed"
    - name: "adjustment_cycle_count"
      expr: COUNT(CASE WHEN is_adjustment_cycle = TRUE THEN 1 END)
      comment: "Number of adjustment billing cycles"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`billing_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections and dunning effectiveness metrics tracking overdue account management and recovery performance"
  source: "`shipping_ports_ecm`.`billing`.`dunning_notice`"
  dimensions:
    - name: "dunning_status"
      expr: dunning_status
      comment: "Current status of the dunning notice (e.g., sent, acknowledged, escalated, resolved)"
    - name: "dunning_level"
      expr: dunning_level
      comment: "Dunning level or severity (e.g., Level 1 reminder, Level 2 warning, Final notice)"
    - name: "dunning_method"
      expr: dunning_method
      comment: "Method used to deliver dunning notice (e.g., email, postal mail, phone call)"
    - name: "dunning_date"
      expr: dunning_date
      comment: "Date the dunning notice was issued"
    - name: "dunning_year"
      expr: YEAR(dunning_date)
      comment: "Year the dunning notice was issued"
    - name: "dunning_month"
      expr: DATE_TRUNC('MONTH', dunning_date)
      comment: "Month the dunning notice was issued"
    - name: "customer_response_status"
      expr: customer_response_status
      comment: "Status of customer response to dunning notice"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the overdue amount"
    - name: "is_escalated"
      expr: escalation_flag
      comment: "Flag indicating whether dunning has been escalated"
    - name: "is_credit_blocked"
      expr: credit_block_flag
      comment: "Flag indicating whether customer credit has been blocked"
    - name: "is_legal_action_threatened"
      expr: legal_action_threatened_flag
      comment: "Flag indicating whether legal action has been threatened"
    - name: "is_written_off"
      expr: write_off_flag
      comment: "Flag indicating whether the debt has been written off"
  measures:
    - name: "total_dunning_notice_count"
      expr: COUNT(1)
      comment: "Total number of dunning notices issued"
    - name: "total_overdue_amount"
      expr: SUM(CAST(total_overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all dunning notices"
    - name: "total_dunning_fee_amount"
      expr: SUM(CAST(dunning_fee_amount AS DOUBLE))
      comment: "Total dunning fees charged to customers"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest charged on overdue amounts"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount agreed with customers"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit for accounts receiving dunning notices"
    - name: "escalated_notice_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of dunning notices escalated to higher collection level"
    - name: "credit_blocked_account_count"
      expr: COUNT(CASE WHEN credit_block_flag = TRUE THEN 1 END)
      comment: "Number of accounts with credit blocked due to non-payment"
    - name: "written_off_notice_count"
      expr: COUNT(CASE WHEN write_off_flag = TRUE THEN 1 END)
      comment: "Number of dunning notices resulting in debt write-off"
    - name: "unique_customer_count"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of unique customers receiving dunning notices"
$$;