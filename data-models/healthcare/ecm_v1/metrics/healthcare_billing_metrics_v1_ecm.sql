-- Metric views for domain: billing | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core invoice financial KPIs used by finance leadership to monitor revenue, collections and patient liability"
  source: "`healthcare_ecm`.`billing`.`invoice`"
  dimensions:
    - name: "invoice_date"
      expr: invoice_date
      comment: "Date the invoice was issued"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice (e.g., posted, pending, voided)"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Classification of invoice (e.g., inpatient, outpatient)"
    - name: "bill_type_code"
      expr: bill_type_code
      comment: "Bill type code indicating billing category"
    - name: "place_of_service_code"
      expr: place_of_service_code
      comment: "Code for place of service where care was delivered"
    - name: "revenue_code"
      expr: revenue_code
      comment: "Revenue code associated with the invoice"
    - name: "admission_source_code"
      expr: admission_source_code
      comment: "Source of patient admission"
    - name: "admission_type_code"
      expr: admission_type_code
      comment: "Type of admission (e.g., emergency, elective)"
  measures:
    - name: "total_charges"
      expr: SUM(CAST(total_charges AS DOUBLE))
      comment: "Sum of total charges for all invoices"
    - name: "total_patient_responsibility"
      expr: SUM(CAST(patient_responsibility AS DOUBLE))
      comment: "Sum of patient responsibility amounts across invoices"
    - name: "total_non_covered_charges"
      expr: SUM(CAST(non_covered_charges AS DOUBLE))
      comment: "Sum of non-covered charges across invoices"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Sum of outstanding balances for all invoices"
    - name: "total_insurance_payment"
      expr: SUM(CAST(insurance_payment AS DOUBLE))
      comment: "Sum of insurance payments received"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of invoice records"
    - name: "average_total_charges"
      expr: AVG(CAST(total_charges AS DOUBLE))
      comment: "Average total charges per invoice"
    - name: "average_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per invoice"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment activity metrics for cash flow and collection performance monitoring"
  source: "`healthcare_ecm`.`billing`.`payment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was posted"
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., posted, pending)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (e.g., check, EFT, credit card)"
    - name: "payment_type"
      expr: payment_type
      comment: "Classification of payment (e.g., patient, insurance)"
    - name: "payment_category"
      expr: payment_category
      comment: "Business category of the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount of payments received"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total amount applied to invoices"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total amount refunded to payers or patients"
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment transactions"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average payment amount per transaction"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment metrics to track financial corrections and reversals"
  source: "`healthcare_ecm`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_date"
      expr: adjustment_date
      comment: "Date the adjustment was created"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment"
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type/category of the adjustment"
    - name: "adjustment_category"
      expr: adjustment_category
      comment: "Business category of the adjustment"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates whether the adjustment was reversed"
  measures:
    - name: "total_adjustment_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of all adjustment amounts"
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustment records"
    - name: "reversal_adjustment_amount"
      expr: SUM(CASE WHEN reversal_flag THEN amount ELSE 0 END)
      comment: "Total amount of adjustments that were reversed"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write‑off KPIs to monitor bad‑debt and financial concessions"
  source: "`healthcare_ecm`.`billing`.`write_off`"
  dimensions:
    - name: "write_off_date"
      expr: write_off_date
      comment: "Date the write‑off was recorded"
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write‑off"
    - name: "write_off_category"
      expr: write_off_category
      comment: "Category describing the reason for write‑off"
    - name: "reversal_flag"
      expr: reversal_flag
      comment: "Indicates if the write‑off was reversed"
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of all write‑off amounts"
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Number of write‑off records"
    - name: "reversal_write_off_amount"
      expr: SUM(CASE WHEN reversal_flag THEN amount ELSE 0 END)
      comment: "Total amount of write‑offs that were later reversed"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`billing_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Charge‑level financial metrics for utilization and revenue analysis"
  source: "`healthcare_ecm`.`billing`.`charge`"
  dimensions:
    - name: "service_date"
      expr: service_date
      comment: "Date the service was provided"
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (e.g., posted, pending)"
    - name: "charge_type"
      expr: charge_type
      comment: "Classification of charge (e.g., procedure, medication)"
    - name: "charge_category"
      expr: charge_category
      comment: "Business category of the charge"
    - name: "is_billable"
      expr: is_billable
      comment: "Flag indicating if the charge is billable"
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating if the charge was voided"
  measures:
    - name: "total_gross_charge_amount"
      expr: SUM(CAST(gross_charge_amount AS DOUBLE))
      comment: "Sum of gross charge amounts for all charge records"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement_amount AS DOUBLE))
      comment: "Sum of expected reimbursement amounts"
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of services/items charged"
    - name: "average_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across charges"
    - name: "charge_count"
      expr: COUNT(1)
      comment: "Number of charge records"
    - name: "billable_charge_amount"
      expr: SUM(CASE WHEN is_billable THEN gross_charge_amount ELSE 0 END)
      comment: "Sum of gross charges that are billable"
$$;