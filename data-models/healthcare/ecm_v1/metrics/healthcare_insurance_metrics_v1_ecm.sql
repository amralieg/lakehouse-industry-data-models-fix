-- Metric views for domain: insurance | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_capitation_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial KPI for capitation contracts"
  source: "`healthcare_ecm`.`insurance`.`capitation_payment`"
  dimensions:
    - name: "payment_year"
      expr: DATE_TRUNC('year', payment_due_date)
      comment: "Calendar year of the payment due date"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Paid, Pending)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, Check)"
  measures:
    - name: "total_gross_capitation_amount"
      expr: SUM(CAST(gross_capitation_amount AS DOUBLE))
      comment: "Total gross capitation amount contracted with payers"
    - name: "total_net_payment_amount"
      expr: SUM(CAST(net_payment_amount AS DOUBLE))
      comment: "Total net payment received after adjustments"
    - name: "average_adjustment_amount"
      expr: AVG(CAST(adjustment_amount AS DOUBLE))
      comment: "Average adjustment amount applied to capitation payments"
    - name: "payment_record_count"
      expr: COUNT(1)
      comment: "Number of capitation payment records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_member_attribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs for member attribution and capitation revenue"
  source: "`healthcare_ecm`.`insurance`.`member_attribution`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Identifier of the health plan"
    - name: "payer_id"
      expr: payer_id
      comment: "Identifier of the payer"
    - name: "attribution_status"
      expr: attribution_status
      comment: "Current status of the attribution (e.g., Active, Inactive)"
    - name: "attribution_method"
      expr: attribution_method
      comment: "Method used for attribution (e.g., Algorithm, Manual)"
    - name: "attribution_year"
      expr: DATE_TRUNC('year', attribution_effective_date)
      comment: "Calendar year of the attribution effective date"
  measures:
    - name: "total_capitation_amount"
      expr: SUM(CAST(capitation_amount AS DOUBLE))
      comment: "Total capitation amount attributed to members"
    - name: "average_attribution_confidence"
      expr: AVG(CAST(attribution_confidence_score AS DOUBLE))
      comment: "Average confidence score of member attribution"
    - name: "distinct_member_count"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Number of unique members attributed"
    - name: "attribution_record_count"
      expr: COUNT(1)
      comment: "Number of attribution records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_premium_billing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of premium billing operations"
  source: "`healthcare_ecm`.`insurance`.`premium_billing`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan associated with the billing"
    - name: "payer_id"
      expr: payer_id
      comment: "Payer associated with the billing"
    - name: "billing_status"
      expr: billing_status
      comment: "Current status of the billing (e.g., Posted, Cancelled)"
    - name: "billing_year"
      expr: DATE_TRUNC('year', billing_due_date)
      comment: "Calendar year of the billing due date"
  measures:
    - name: "total_net_premium_due"
      expr: SUM(CAST(net_premium_due AS DOUBLE))
      comment: "Total net premium amount due across all billing cycles"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding premium balance"
    - name: "average_premium_per_member"
      expr: AVG(CAST(premium_rate_per_member AS DOUBLE))
      comment: "Average premium rate per member"
    - name: "billing_record_count"
      expr: COUNT(1)
      comment: "Number of premium billing records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_risk_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk adjustment financial impact and scoring"
  source: "`healthcare_ecm`.`insurance`.`risk_adjustment`"
  dimensions:
    - name: "health_plan_id"
      expr: health_plan_id
      comment: "Health plan linked to the risk adjustment"
    - name: "payer_id"
      expr: payer_id
      comment: "Payer linked to the risk adjustment"
    - name: "adjustment_year"
      expr: DATE_TRUNC('year', acceptance_date)
      comment: "Calendar year of the risk adjustment acceptance"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount associated with risk adjustments"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across adjustments"
    - name: "risk_adjustment_record_count"
      expr: COUNT(1)
      comment: "Number of risk adjustment records"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`insurance_vbc_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Value‑Based Care performance and financial outcomes"
  source: "`healthcare_ecm`.`insurance`.`vbc_performance`"
  dimensions:
    - name: "payer_id"
      expr: payer_id
      comment: "Payer associated with the VBC performance"
    - name: "performance_year"
      expr: DATE_TRUNC('year', performance_period_start_date)
      comment: "Calendar year of the performance period"
    - name: "performance_year_type"
      expr: performance_year_type
      comment: "Type of performance year (e.g., Calendar, Fiscal)"
    - name: "quality_measure_set"
      expr: quality_measure_set
      comment: "Quality measure set used for evaluation"
  measures:
    - name: "total_shared_savings_amount"
      expr: SUM(CAST(shared_savings_distribution_amount AS DOUBLE))
      comment: "Total amount of shared savings distributed"
    - name: "total_shared_loss_amount"
      expr: SUM(CAST(shared_loss_amount AS DOUBLE))
      comment: "Total amount of shared loss incurred"
    - name: "average_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score for VBC performance"
    - name: "vbc_performance_record_count"
      expr: COUNT(1)
      comment: "Number of VBC performance records"
$$;