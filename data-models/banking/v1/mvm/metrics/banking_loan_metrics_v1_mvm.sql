-- Metric views for domain: loan | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key loan portfolio balances and risk indicators at loan account level."
  source: "`banking_ecm`.`loan`.`loan_account`"
  dimensions:
    - name: "product_type_id"
      expr: product_type_id
      comment: "Product type of the loan"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the loan"
    - name: "account_status"
      expr: account_status
      comment: "Current status of the loan account"
    - name: "origination_year"
      expr: DATE_TRUNC('year', origination_date)
      comment: "Year the loan was originated"
  measures:
    - name: "total_outstanding_principal"
      expr: SUM(CAST(outstanding_principal_balance AS DOUBLE))
      comment: "Total outstanding principal balance across loan accounts"
    - name: "average_interest_rate"
      expr: AVG(CAST(current_interest_rate AS DOUBLE))
      comment: "Average interest rate of loan accounts"
    - name: "loan_account_count"
      expr: COUNT(1)
      comment: "Number of loan accounts"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility commitment and drawdown utilization metrics."
  source: "`banking_ecm`.`loan`.`facility`"
  dimensions:
    - name: "product_type_id"
      expr: product_type_id
      comment: "Product type of the facility"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the facility"
    - name: "facility_status"
      expr: facility_status
      comment: "Current status of the facility"
    - name: "origination_year"
      expr: DATE_TRUNC('year', origination_date)
      comment: "Year the facility was originated"
  measures:
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total amount committed for the facility"
    - name: "total_drawn_amount"
      expr: SUM(CAST(drawn_amount AS DOUBLE))
      comment: "Total amount drawn against the facility"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Number of facilities"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_disbursement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash outflow from loan disbursements."
  source: "`banking_ecm`.`loan`.`disbursement`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the disbursement"
    - name: "channel_id"
      expr: channel_id
      comment: "Channel through which disbursement was made"
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current status of the disbursement"
    - name: "disbursement_year"
      expr: DATE_TRUNC('year', disbursement_date)
      comment: "Year of disbursement"
  measures:
    - name: "total_disbursed_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total amount disbursed"
    - name: "average_disbursement_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average disbursement amount"
    - name: "disbursement_count"
      expr: COUNT(1)
      comment: "Number of disbursement records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_repayment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cash inflow and repayment performance metrics."
  source: "`banking_ecm`.`loan`.`repayment`"
  dimensions:
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the repayment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment"
    - name: "payment_year"
      expr: DATE_TRUNC('year', payment_date)
      comment: "Year of payment"
  measures:
    - name: "total_principal_repaid"
      expr: SUM(CAST(principal_amount AS DOUBLE))
      comment: "Total principal amount repaid"
    - name: "total_interest_repaid"
      expr: SUM(CAST(interest_amount AS DOUBLE))
      comment: "Total interest amount repaid"
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total payment amount (principal + interest + fees)"
    - name: "repayment_count"
      expr: COUNT(1)
      comment: "Number of repayment transactions"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_credit_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loan application pipeline and approval metrics."
  source: "`banking_ecm`.`loan`.`credit_application`"
  dimensions:
    - name: "product_type_id"
      expr: product_type_id
      comment: "Product type requested"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the requested amount"
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "loan_purpose"
      expr: loan_purpose
      comment: "Purpose of the loan"
    - name: "application_year"
      expr: DATE_TRUNC('year', application_submitted_timestamp)
      comment: "Year the application was submitted"
  measures:
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Sum of amounts requested in applications"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Sum of amounts approved"
    - name: "application_count"
      expr: COUNT(1)
      comment: "Number of loan applications"
    - name: "approved_application_count"
      expr: SUM(CASE WHEN application_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of applications with status Approved"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`loan_ecl_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Expected credit loss (ECL) provisioning metrics for loan portfolio."
  source: "`banking_ecm`.`loan`.`loan_ecl_provision`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility associated with the provision"
    - name: "loan_account_id"
      expr: loan_account_id
      comment: "Loan account associated with the provision"
    - name: "ecl_model_code"
      expr: ecl_model_code
      comment: "Model code used for ECL calculation"
  measures:
    - name: "total_ecl_provision_amount"
      expr: SUM(CAST(provision_amount AS DOUBLE))
      comment: "Total ECL provision amount"
    - name: "total_ead"
      expr: SUM(CAST(ead AS DOUBLE))
      comment: "Total Exposure at Default"
    - name: "average_lgd"
      expr: AVG(CAST(lgd AS DOUBLE))
      comment: "Average Loss Given Default"
    - name: "average_pd"
      expr: AVG(CAST(pd AS DOUBLE))
      comment: "Average Probability of Default"
    - name: "ecl_provision_record_count"
      expr: COUNT(1)
      comment: "Number of ECL provision records"
$$;