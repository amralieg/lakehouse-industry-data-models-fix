-- Metric views for domain: loan | Business: Banking | Version: 1 | Generated on: 2026-05-02 22:51:12

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core disbursement KPIs – volume, average size and fee exposure, useful for treasury and funding strategy"
  source: "`banking_ecm`.`loan`.`disbursement`"
  dimensions:
    - name: "disbursement_date"
      expr: disbursement_date
      comment: "Date of the disbursement"
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement (e.g., completed, pending)"
    - name: "disbursement_method"
      expr: disbursement_method
      comment: "Method used for disbursement (e.g., wire, ACH)"
    - name: "channel"
      expr: channel
      comment: "Distribution channel for the disbursement"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier (FK to reference.currency)"
  measures:
    - name: "total_disbursement_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount disbursed across all disbursements"
    - name: "average_disbursement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average disbursement amount per record"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of fees associated with disbursements"
    - name: "disbursement_count"
      expr: COUNT(1)
      comment: "Number of disbursement records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_repayment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Repayment performance metrics – cash flow, principal vs interest mix, and transaction volume"
  source: "`banking_ecm`.`loan`.`repayment`"
  dimensions:
    - name: "payment_date"
      expr: payment_date
      comment: "Date the payment was received"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment (e.g., posted, pending)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, check)"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid back by borrowers"
    - name: "total_principal_amount"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Sum of principal components of repayments"
    - name: "total_interest_amount"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Sum of interest components of repayments"
    - name: "average_payment_amount"
      expr: AVG(CAST(payment_amount AS DOUBLE))
      comment: "Average repayment amount per transaction"
    - name: "repayment_count"
      expr: COUNT(1)
      comment: "Number of repayment records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio‑level view of loan accounts – exposure, risk and provisioning"
  source: "`banking_ecm`.`loan`.`loan_account`"
  dimensions:
    - name: "loan_type"
      expr: loan_type
      comment: "Classification of loan (e.g., term, revolving)"
    - name: "account_status"
      expr: account_status
      comment: "Current status of the loan account"
    - name: "origination_date"
      expr: origination_date
      comment: "Date the loan was originated"
  measures:
    - name: "total_original_loan_amount"
      expr: SUM(CAST(original_loan_amount AS DOUBLE))
      comment: "Aggregate original loan amount at origination"
    - name: "total_outstanding_principal"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Current outstanding principal across all loan accounts"
    - name: "total_ecl_provision"
      expr: SUM(CAST(ecl_provision_amount AS DOUBLE))
      comment: "Total expected credit loss provision for the portfolio"
    - name: "loan_account_count"
      expr: COUNT(1)
      comment: "Number of active loan accounts"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility‑level risk and utilization metrics for credit risk management"
  source: "`banking_ecm`.`loan`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., revolving, term)"
    - name: "facility_status"
      expr: facility_status
      comment: "Current status of the facility"
    - name: "origination_date"
      expr: origination_date
      comment: "Date the facility was originated"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the facility"
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total amount committed to facilities"
    - name: "total_drawn_amount"
      expr: SUM(CAST(drawn_amount AS DOUBLE))
      comment: "Total amount actually drawn from facilities"
    - name: "average_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average Debt Service Coverage Ratio across facilities"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Number of facility records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing analytics – rate levels and spreads that drive profitability"
  source: "`banking_ecm`.`loan`.`pricing`"
  dimensions:
    - name: "pricing_type"
      expr: pricing_type
      comment: "Pricing classification (e.g., fixed, variable)"
    - name: "pricing_status"
      expr: pricing_status
      comment: "Current status of the pricing record"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the pricing became effective"
  measures:
    - name: "average_all_in_rate"
      expr: AVG(CAST(all_in_rate AS DOUBLE))
      comment: "Average all‑in rate across pricing records"
    - name: "average_spread_bps"
      expr: AVG(CAST(spread_bps AS DOUBLE))
      comment: "Average spread in basis points"
    - name: "pricing_record_count"
      expr: COUNT(1)
      comment: "Number of pricing entries"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_credit_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit application pipeline metrics – demand, approval quality and risk indicators"
  source: "`banking_ecm`.`loan`.`credit_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application (e.g., approved, declined)"
    - name: "loan_purpose"
      expr: loan_purpose
      comment: "Purpose of the loan request"
    - name: "application_type"
      expr: application_type
      comment: "Type of application (e.g., new, renewal)"
    - name: "application_submitted_timestamp"
      expr: application_submitted_timestamp
      comment: "Timestamp when the application was submitted"
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Sum of credit requested by applicants"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Sum of credit approved"
    - name: "average_dscr"
      expr: AVG(CAST(dscr AS DOUBLE))
      comment: "Average Debt Service Coverage Ratio of applicants"
    - name: "application_count"
      expr: COUNT(1)
      comment: "Number of credit applications processed"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_write_off`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Write‑off performance – loss magnitude and frequency for credit risk monitoring"
  source: "`banking_ecm`.`loan`.`write_off`"
  dimensions:
    - name: "write_off_status"
      expr: write_off_status
      comment: "Current status of the write‑off (e.g., pending, completed)"
    - name: "write_off_type"
      expr: write_off_type
      comment: "Classification of write‑off (e.g., charge‑off, recovery)"
    - name: "write_off_date"
      expr: write_off_date
      comment: "Date the write‑off was recorded"
  measures:
    - name: "total_write_off_amount"
      expr: SUM(CAST(total_write_off_amount AS DOUBLE))
      comment: "Aggregate amount written off"
    - name: "write_off_count"
      expr: COUNT(1)
      comment: "Number of write‑off events"
$$;