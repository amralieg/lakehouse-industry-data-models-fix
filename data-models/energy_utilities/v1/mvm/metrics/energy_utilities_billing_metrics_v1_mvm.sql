-- Metric views for domain: billing | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial performance metrics"
  source: "`energy_utilities_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Code identifying the billing cycle for the invoice"
  measures:
    - name: "total_billed_amount"
      expr: SUM(CAST(total_amount_due AS DOUBLE))
      comment: "Total invoiced amount across all invoices (revenue)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment impact and volume metrics"
  source: "`energy_utilities_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type/category of the adjustment"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary impact of billing adjustments"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment collection performance metrics"
  source: "`energy_utilities_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., credit card, ACH)"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of payments processed"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service agreement financial planning metrics"
  source: "`energy_utilities_ecm`.`billing`.`billing_service_agreement`"
  dimensions:
    - name: "revenue_class"
      expr: revenue_class
      comment: "Revenue class for the agreement"
  measures:
    - name: "total_budget_billing_amount"
      expr: SUM(CAST(budget_billing_amount AS DOUBLE))
      comment: "Total budgeted billing amount across agreements"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`billing_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing cycle revenue and usage metrics"
  source: "`energy_utilities_ecm`.`billing`.`cycle`"
  dimensions:
    - name: "cycle_code"
      expr: cycle_code
      comment: "Identifier code for the billing cycle"
  measures:
    - name: "total_cycle_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Total amount billed in the cycle"
$$;