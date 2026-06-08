-- Metric views for domain: partner | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and contractual KPIs at the agreement level"
  source: "`payments_fintech_ecm`.`partner`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., Active, Terminated)"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type/category of the agreement"
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Identifier of the partner ecosystem entity"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency used for the agreement"
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme associated with the agreement"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the agreement became effective"
    - name: "effective_end_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month when the agreement ended"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of agreement records"
    - name: "total_mdr_rate"
      expr: SUM(CAST(mdr_rate AS DOUBLE))
      comment: "Sum of MDR rates across agreements (basis for fee exposure analysis)"
    - name: "avg_mdr_rate"
      expr: AVG(CAST(mdr_rate AS DOUBLE))
      comment: "Average MDR rate per agreement"
    - name: "total_revenue_share_percentage"
      expr: SUM(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Sum of revenue share percentages across agreements"
    - name: "avg_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage per agreement"
    - name: "total_irf_rate"
      expr: SUM(CAST(irf_rate AS DOUBLE))
      comment: "Sum of IRF rates across agreements"
    - name: "avg_irf_rate"
      expr: AVG(CAST(irf_rate AS DOUBLE))
      comment: "Average IRF rate per agreement"
    - name: "exclusive_agreement_count"
      expr: SUM(CASE WHEN is_exclusive THEN 1 ELSE 0 END)
      comment: "Count of agreements flagged as exclusive"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance metrics derived from invoices"
  source: "`payments_fintech_ecm`.`partner`.`invoice`"
  dimensions:
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner associated with the invoice"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the invoice"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status (Paid, Pending, Failed)"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Lifecycle status of the invoice"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of the invoice (e.g., Standard, Credit Memo)"
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start_date)
      comment: "Billing month for the invoice"
  measures:
    - name: "total_invoices"
      expr: COUNT(1)
      comment: "Total number of invoice records"
    - name: "total_invoice_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total invoice amounts (gross revenue)"
    - name: "avg_invoice_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average invoice amount"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across invoices"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees charged on invoices"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties assessed"
    - name: "credit_memo_count"
      expr: SUM(CASE WHEN is_credit_memo THEN 1 ELSE 0 END)
      comment: "Count of credit memos (negative invoices)"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_performance_period`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational risk and performance KPIs per measurement period"
  source: "`payments_fintech_ecm`.`partner`.`performance_period`"
  dimensions:
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner being evaluated"
    - name: "period_type"
      expr: period_type
      comment: "Type of period (Monthly, Quarterly, etc.)"
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_period_start_date)
      comment: "Month of the measurement period"
  measures:
    - name: "performance_period_count"
      expr: COUNT(1)
      comment: "Number of performance period records"
    - name: "avg_authorization_approval_rate"
      expr: AVG(CAST(authorization_approval_rate AS DOUBLE))
      comment: "Average authorization approval rate"
    - name: "avg_chargeback_rate"
      expr: AVG(CAST(chargeback_rate AS DOUBLE))
      comment: "Average chargeback rate"
    - name: "avg_fraud_rate"
      expr: AVG(CAST(fraud_rate AS DOUBLE))
      comment: "Average fraud rate"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score for the partner"
    - name: "avg_settlement_timeliness_score"
      expr: AVG(CAST(settlement_timeliness_score AS DOUBLE))
      comment: "Average settlement timeliness score"
    - name: "avg_sla_compliance_score"
      expr: AVG(CAST(sla_compliance_score AS DOUBLE))
      comment: "Average SLA compliance score"
    - name: "total_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions in the period"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`partner_sla_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance and penalty exposure metrics"
  source: "`payments_fintech_ecm`.`partner`.`sla_commitment`"
  dimensions:
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner bound by the SLA"
    - name: "agreement_id"
      expr: agreement_id
      comment: "Agreement associated with the SLA"
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric (e.g., latency, uptime)"
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (Service, Performance)"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when SLA became effective"
  measures:
    - name: "sla_commitment_count"
      expr: COUNT(1)
      comment: "Total number of SLA commitments"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target value defined in SLA commitments"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount for SLA breaches"
    - name: "active_sla_commitment_count"
      expr: SUM(CASE WHEN sla_commitment_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of SLA commitments currently active"
$$;