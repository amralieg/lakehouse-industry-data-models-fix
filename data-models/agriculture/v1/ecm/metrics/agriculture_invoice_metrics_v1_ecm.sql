-- Metric views for domain: invoice | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics"
  source: "`agriculture_ecm`.`invoice`.`invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., standard, credit)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts"
    - name: "customer_name"
      expr: customer_name
      comment: "Name of the customer billed"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of all invoice gross amounts"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of all invoice net amounts"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amounts across invoices"
    - name: "average_gross_amount"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average gross amount per invoice"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoices"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount paid on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied to invoices"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection performance"
  source: "`agriculture_ecm`.`invoice`.`payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was made"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag indicating inter‑company payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total payment amount received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "total_unapplied_amount"
      expr: SUM(CAST(unapplied_amount AS DOUBLE))
      comment: "Total amount not yet applied"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_credit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit memo financial impact"
  source: "`agriculture_ecm`.`invoice`.`credit_memo`"
  dimensions:
    - name: "memo_status"
      expr: memo_status
      comment: "Current status of the credit memo"
    - name: "credit_reason_code"
      expr: credit_reason_code
      comment: "Reason code for the credit"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit memo"
    - name: "issue_date"
      expr: issue_date
      comment: "Date the credit memo was issued"
    - name: "is_regulatory_deduction"
      expr: is_regulatory_deduction
      comment: "Indicates if the credit is a regulatory deduction"
  measures:
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued"
    - name: "total_net_credit_amount"
      expr: SUM(CAST(net_credit_amount AS DOUBLE))
      comment: "Net credit amount after adjustments"
    - name: "total_tax_credit_amount"
      expr: SUM(CAST(tax_credit_amount AS DOUBLE))
      comment: "Tax credit amount associated with credit memos"
    - name: "credit_memo_count"
      expr: COUNT(1)
      comment: "Number of credit memos"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_debit_memo`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Debit memo financial impact"
  source: "`agriculture_ecm`.`invoice`.`debit_memo`"
  dimensions:
    - name: "memo_status"
      expr: memo_status
      comment: "Current status of the debit memo"
    - name: "debit_reason_code"
      expr: debit_reason_code
      comment: "Reason code for the debit"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the debit memo"
    - name: "issue_date"
      expr: issue_date
      comment: "Date the debit memo was issued"
  measures:
    - name: "total_debit_amount"
      expr: SUM(CAST(debit_amount AS DOUBLE))
      comment: "Total debit amount issued"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on debit memos"
    - name: "debit_memo_count"
      expr: COUNT(1)
      comment: "Number of debit memos"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_billing_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing schedule revenue planning"
  source: "`agriculture_ecm`.`invoice`.`billing_schedule`"
  dimensions:
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "How often billing occurs (e.g., monthly, quarterly)"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the billing schedule"
    - name: "start_date"
      expr: start_date
      comment: "Schedule start date"
    - name: "end_date"
      expr: end_date
      comment: "Schedule end date"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the billing amounts"
  measures:
    - name: "total_billing_amount"
      expr: SUM(CAST(billing_amount AS DOUBLE))
      comment: "Total amount scheduled for billing"
    - name: "billing_schedule_count"
      expr: COUNT(1)
      comment: "Number of billing schedule records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_receivable_financing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financing of receivables performance"
  source: "`agriculture_ecm`.`invoice`.`receivable_financing`"
  dimensions:
    - name: "financing_status"
      expr: financing_status
      comment: "Current status of the financing arrangement"
    - name: "financing_type"
      expr: financing_type
      comment: "Type of financing (e.g., factoring, loan)"
    - name: "maturity_date"
      expr: maturity_date
      comment: "Date the financing matures"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the financing"
  measures:
    - name: "total_advance_amount"
      expr: SUM(CAST(advance_amount AS DOUBLE))
      comment: "Total advance amount financed"
    - name: "total_factoring_fee_amount"
      expr: SUM(CAST(factoring_fee_amount AS DOUBLE))
      comment: "Total factoring fees charged"
    - name: "receivable_financing_count"
      expr: COUNT(1)
      comment: "Number of receivable financing records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue recognition tracking"
  source: "`agriculture_ecm`.`invoice`.`revenue_recognition`"
  dimensions:
    - name: "recognition_status"
      expr: recognition_status
      comment: "Current status of the revenue recognition"
    - name: "recognition_type"
      expr: recognition_type
      comment: "Type of revenue recognition (e.g., point‑in‑time, over‑time)"
    - name: "recognition_event_date"
      expr: recognition_event_date
      comment: "Date of the recognition event"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recognized revenue"
  measures:
    - name: "total_recognized_amount"
      expr: SUM(CAST(recognized_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "total_deferred_amount"
      expr: SUM(CAST(deferred_amount AS DOUBLE))
      comment: "Total revenue deferred"
    - name: "revenue_recognition_count"
      expr: COUNT(1)
      comment: "Number of revenue recognition events"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_settlement_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement statement financial summary"
  source: "`agriculture_ecm`.`invoice`.`settlement_statement`"
  dimensions:
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g., cash, credit)"
    - name: "period_type"
      expr: period_type
      comment: "Classification of the period (e.g., monthly, quarterly)"
    - name: "statement_date"
      expr: statement_date
      comment: "Date of the settlement statement"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the settlement amounts"
  measures:
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total amount invoiced in the settlement period"
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Net amount settled after deductions"
    - name: "total_credits_issued_amount"
      expr: SUM(CAST(credits_issued_amount AS DOUBLE))
      comment: "Total credits issued in the settlement period"
    - name: "settlement_statement_count"
      expr: COUNT(1)
      comment: "Number of settlement statements"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_weight_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Weight ticket quality and throughput metrics"
  source: "`agriculture_ecm`.`invoice`.`weight_ticket`"
  dimensions:
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity measured"
    - name: "is_organic"
      expr: is_organic
      comment: "Flag indicating organic certification"
    - name: "is_gmo"
      expr: is_gmo
      comment: "Flag indicating GMO status"
    - name: "ticket_status"
      expr: ticket_status
      comment: "Current status of the weight ticket"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the ticket was created"
  measures:
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight captured on tickets"
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight captured on tickets"
    - name: "average_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture percentage across tickets"
    - name: "weight_ticket_count"
      expr: COUNT(1)
      comment: "Number of weight tickets recorded"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`invoice_dunning_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dunning and collections performance"
  source: "`agriculture_ecm`.`invoice`.`dunning_notice`"
  dimensions:
    - name: "dunning_level"
      expr: dunning_level
      comment: "Level of dunning (e.g., first, second, final)"
    - name: "notice_status"
      expr: notice_status
      comment: "Current status of the dunning notice"
    - name: "dunning_block_reason"
      expr: dunning_block_reason
      comment: "Reason for any dunning block"
    - name: "notice_date"
      expr: notice_date
      comment: "Date the dunning notice was issued"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amounts"
  measures:
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across dunning notices"
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_exposure AS DOUBLE))
      comment: "Total credit exposure reported in dunning notices"
    - name: "dunning_notice_count"
      expr: COUNT(1)
      comment: "Number of dunning notices issued"
$$;