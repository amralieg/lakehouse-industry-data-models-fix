-- Metric views for domain: claim | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core claim financial performance metrics"
  source: "`healthcare_ecm`.`claim`.`claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim"
    - name: "claim_type"
      expr: claim_type
      comment: "Type/category of the claim"
    - name: "submission_method"
      expr: submission_method
      comment: "Method used to submit the claim"
    - name: "payer_id"
      expr: payer_id
      comment: "Identifier of the payer responsible for the claim"
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where services were rendered"
    - name: "service_month"
      expr: DATE_TRUNC('month', service_from_date)
      comment: "Month of service start date"
  measures:
    - name: "total_claim_billed_amount"
      expr: SUM(CAST(total_billed_amount AS DOUBLE))
      comment: "Sum of total billed amount for all claims"
    - name: "total_claim_paid_amount"
      expr: SUM(CAST(total_paid_amount AS DOUBLE))
      comment: "Sum of total paid amount for all claims"
    - name: "total_claim_allowed_amount"
      expr: SUM(CAST(total_allowed_amount AS DOUBLE))
      comment: "Sum of total allowed amount for all claims"
    - name: "claim_count"
      expr: COUNT(1)
      comment: "Number of claim records"
    - name: "average_claim_billed_amount"
      expr: AVG(CAST(total_billed_amount AS DOUBLE))
      comment: "Average billed amount per claim"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_denial`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Denial financial impact and frequency metrics"
  source: "`healthcare_ecm`.`claim`.`denial`"
  dimensions:
    - name: "denial_category"
      expr: denial_category
      comment: "High‑level category of denial"
    - name: "denial_type"
      expr: denial_type
      comment: "Specific type of denial"
    - name: "payer_id"
      expr: payer_id
      comment: "Payer associated with the denial"
    - name: "denial_month"
      expr: DATE_TRUNC('month', denial_date)
      comment: "Month when the denial occurred"
    - name: "appeal_level"
      expr: appeal_level
      comment: "Level of appeal for the denial"
  measures:
    - name: "total_denied_amount"
      expr: SUM(CAST(denied_amount AS DOUBLE))
      comment: "Sum of amounts denied across all denial records"
    - name: "denial_count"
      expr: COUNT(1)
      comment: "Number of denial records"
    - name: "distinct_claims_denied"
      expr: COUNT(DISTINCT claim_id)
      comment: "Count of unique claims that have at least one denial"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal financial outcomes and volume"
  source: "`healthcare_ecm`.`claim`.`appeal`"
  dimensions:
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type/category of the appeal"
    - name: "appeal_level"
      expr: appeal_level
      comment: "Level of the appeal (e.g., first, second)"
    - name: "outcome_code"
      expr: outcome_code
      comment: "Outcome code of the appeal"
    - name: "appeal_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the appeal was created"
  measures:
    - name: "total_overturn_amount"
      expr: SUM(CAST(overturn_amount AS DOUBLE))
      comment: "Sum of amounts overturned after appeal"
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Number of appeal records"
    - name: "total_requested_amount"
      expr: SUM(CAST(requested_amount AS DOUBLE))
      comment: "Sum of amounts originally requested in appeals"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_remittance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remittance financial flow metrics"
  source: "`healthcare_ecm`.`claim`.`remittance`"
  dimensions:
    - name: "payer_id"
      expr: payer_id
      comment: "Payer associated with the remittance"
    - name: "payment_method_code"
      expr: payment_method_code
      comment: "Method used for payment (e.g., EFT, check)"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_date)
      comment: "Month of payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
  measures:
    - name: "total_payment_amount"
      expr: SUM(CAST(payment_amount AS DOUBLE))
      comment: "Total amount paid to providers/payers in remittances"
    - name: "remittance_count"
      expr: COUNT(1)
      comment: "Number of remittance records"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(total_adjustment_amount AS DOUBLE))
      comment: "Sum of all adjustments applied in remittances"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`claim_cob`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "COB financial distribution metrics"
  source: "`healthcare_ecm`.`claim`.`cob`"
  dimensions:
    - name: "cob_status"
      expr: cob_status
      comment: "Current status of the COB process"
    - name: "determination_method"
      expr: determination_method
      comment: "Method used to determine COB"
    - name: "cob_month"
      expr: DATE_TRUNC('month', determination_date)
      comment: "Month of COB determination"
  measures:
    - name: "total_primary_paid_amount"
      expr: SUM(CAST(primary_paid_amount AS DOUBLE))
      comment: "Sum of primary payer paid amounts"
    - name: "total_secondary_paid_amount"
      expr: SUM(CAST(secondary_paid_amount AS DOUBLE))
      comment: "Sum of secondary payer paid amounts"
    - name: "total_tertiary_paid_amount"
      expr: SUM(CAST(tertiary_paid_amount AS DOUBLE))
      comment: "Sum of tertiary payer paid amounts"
    - name: "cob_record_count"
      expr: COUNT(1)
      comment: "Number of coordination of benefits (COB) records"
$$;