-- Metric views for domain: product | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_payment_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for payment products, focusing on fee revenue and product characteristics."
  source: "`payments_fintech_ecm`.`product`.`payment_product`"
  dimensions:
    - name: "payment_product_status"
      expr: payment_product_status
      comment: "Current lifecycle status of the payment product."
    - name: "payment_product_type"
      expr: product_type
      comment: "Category of the payment product (e.g., card, wallet)."
    - name: "scheme_id"
      expr: scheme_id
      comment: "Identifier of the payment scheme associated with the product."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of product creation for cohort analysis."
  measures:
    - name: "total_payment_products"
      expr: COUNT(1)
      comment: "Total number of distinct payment products."
    - name: "total_fixed_fee_amount"
      expr: SUM(CAST(transaction_fee_fixed_amount AS DOUBLE))
      comment: "Sum of fixed transaction fees across all payment products."
    - name: "avg_fixed_fee_amount"
      expr: AVG(CAST(transaction_fee_fixed_amount AS DOUBLE))
      comment: "Average fixed transaction fee per payment product."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge amount collected from payment products."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_card_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics for card programs, highlighting spend limits and surcharge settings."
  source: "`payments_fintech_ecm`.`product`.`card_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current status of the card program."
    - name: "program_type"
      expr: program_type
      comment: "Type/category of the card program."
    - name: "scheme_id"
      expr: scheme_id
      comment: "Associated payment scheme identifier."
    - name: "contactless_enabled"
      expr: contactless_enabled
      comment: "Indicates if contactless payments are enabled for the program."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the card program was created."
  measures:
    - name: "total_card_programs"
      expr: COUNT(1)
      comment: "Total number of card programs."
    - name: "total_daily_spend_limit"
      expr: SUM(CAST(daily_spend_limit AS DOUBLE))
      comment: "Aggregate daily spend limit across all programs."
    - name: "avg_daily_spend_limit"
      expr: AVG(CAST(daily_spend_limit AS DOUBLE))
      comment: "Average daily spend limit per program."
    - name: "total_surcharge_rate"
      expr: SUM(CAST(surcharge_rate AS DOUBLE))
      comment: "Sum of surcharge rates for all programs (used for revenue potential estimation)."
    - name: "avg_surcharge_rate"
      expr: AVG(CAST(surcharge_rate AS DOUBLE))
      comment: "Average surcharge rate across programs."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_bnpl_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buy‑Now‑Pay‑Later plan performance indicators, focusing on interest and credit limits."
  source: "`payments_fintech_ecm`.`product`.`bnpl_plan`"
  dimensions:
    - name: "plan_status"
      expr: bnpl_plan_status
      comment: "Operational status of the BNPL plan."
    - name: "plan_type"
      expr: plan_type
      comment: "Classification of the BNPL plan (e.g., installment, revolving)."
    - name: "is_promotion_active"
      expr: is_promotion_active
      comment: "Whether a promotional APR is currently active."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month of BNPL plan creation."
  measures:
    - name: "total_bnpl_plans"
      expr: COUNT(1)
      comment: "Total number of BNPL plans."
    - name: "avg_annual_interest_rate"
      expr: AVG(CAST(interest_rate_annual_percent AS DOUBLE))
      comment: "Average annual interest rate across BNPL plans."
    - name: "total_max_total_amount"
      expr: SUM(CAST(max_total_amount AS DOUBLE))
      comment: "Sum of maximum total credit amounts offered by all BNPL plans."
    - name: "avg_max_installment_amount"
      expr: AVG(CAST(max_installment_amount AS DOUBLE))
      comment: "Average maximum installment amount per BNPL plan."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_a2a_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "A2A product metrics emphasizing fee revenue and support capabilities."
  source: "`payments_fintech_ecm`.`product`.`a2a_product`"
  dimensions:
    - name: "a2a_product_status"
      expr: a2a_product_status
      comment: "Current lifecycle status of the A2A product."
    - name: "scheme_id"
      expr: scheme_id
      comment: "Associated scheme identifier."
    - name: "is_contactless_supported"
      expr: is_contactless_supported
      comment: "Indicates if contactless transactions are supported."
    - name: "is_tokenizable"
      expr: is_tokenizable
      comment: "Indicates if tokenization is supported."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the A2A product was created."
  measures:
    - name: "total_a2a_products"
      expr: COUNT(1)
      comment: "Total number of A2A products."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge amount collected from A2A products."
    - name: "avg_surcharge_rate"
      expr: AVG(CAST(surcharge_rate AS DOUBLE))
      comment: "Average surcharge rate applied to A2A products."
    - name: "total_transaction_fee_fixed_amount"
      expr: SUM(CAST(transaction_fee_fixed_amount AS DOUBLE))
      comment: "Sum of fixed transaction fees for A2A products."
$$;