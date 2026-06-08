-- Metric views for domain: product | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_payment_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance metrics for payment products."
  source: "`payments_fintech_ecm`.`product`.`payment_product`"
  dimensions:
    - name: "payment_product_name"
      expr: payment_product_name
      comment: "Descriptive name of the payment product."
    - name: "payment_product_type"
      expr: product_type
      comment: "Category or type of the payment product."
    - name: "payment_product_status"
      expr: payment_product_status
      comment: "Current lifecycle status of the payment product."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency identifier for the product."
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner that provides the product."
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the product became effective."
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the product expires."
  measures:
    - name: "total_payment_products"
      expr: COUNT(1)
      comment: "Count of payment product records."
    - name: "avg_max_transaction_amount"
      expr: AVG(CAST(max_transaction_amount AS DOUBLE))
      comment: "Average maximum transaction amount allowed."
    - name: "avg_min_transaction_amount"
      expr: AVG(CAST(min_transaction_amount AS DOUBLE))
      comment: "Average minimum transaction amount allowed."
    - name: "avg_transaction_fee_fixed_amount"
      expr: AVG(CAST(transaction_fee_fixed_amount AS DOUBLE))
      comment: "Average fixed transaction fee per payment product."
    - name: "avg_transaction_fee_percent"
      expr: AVG(CAST(transaction_fee_percent AS DOUBLE))
      comment: "Average transaction fee percentage per payment product."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge amount across all payment products."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated fee schedule metrics per product."
  source: "`payments_fintech_ecm`.`product`.`product_fee_schedule`"
  dimensions:
    - name: "payment_product_id"
      expr: payment_product_id
      comment: "Identifier of the associated payment product."
    - name: "fee_category"
      expr: fee_category
      comment: "Category of the fee (e.g., transaction, service)."
    - name: "fee_code"
      expr: fee_code
      comment: "Code representing the fee type."
    - name: "fee_name"
      expr: fee_name
      comment: "Human‑readable name of the fee."
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the fee schedule becomes effective."
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the fee schedule expires."
  measures:
    - name: "total_fee_lines"
      expr: COUNT(1)
      comment: "Count of fee schedule lines."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount defined in the schedule."
    - name: "avg_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average fee amount per schedule line."
    - name: "total_fee_rate"
      expr: SUM(CAST(fee_rate AS DOUBLE))
      comment: "Sum of fee rates across schedule lines."
    - name: "avg_fee_rate"
      expr: AVG(CAST(fee_rate AS DOUBLE))
      comment: "Average fee rate per schedule line."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_promotional_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics that evaluate the financial impact of promotional offers."
  source: "`payments_fintech_ecm`.`product`.`promotional_offer`"
  dimensions:
    - name: "offer_name"
      expr: offer_name
      comment: "Name of the promotional offer."
    - name: "offer_type"
      expr: offer_type
      comment: "Type/category of the offer."
    - name: "start_date"
      expr: start_date
      comment: "Offer start date."
    - name: "end_date"
      expr: end_date
      comment: "Offer end date."
    - name: "promotional_offer_status"
      expr: promotional_offer_status
      comment: "Current status of the offer."
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner associated with the offer."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency in which the offer is denominated."
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Count of promotional offers."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across offers."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered."
    - name: "total_max_redemption_amount"
      expr: SUM(CAST(max_redemption_amount AS DOUBLE))
      comment: "Total maximum redemption amount allowed across offers."
    - name: "avg_redemption_limit_per_user"
      expr: AVG(CAST(redemption_limit_per_user AS DOUBLE))
      comment: "Average redemption limit per user."
    - name: "total_remaining_amount"
      expr: SUM(CAST(remaining_amount AS DOUBLE))
      comment: "Total remaining monetary value to be redeemed."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_bnpl_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for BNPL (Buy‑Now‑Pay‑Later) plans."
  source: "`payments_fintech_ecm`.`product`.`bnpl_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Name of the BNPL plan."
    - name: "plan_type"
      expr: plan_type
      comment: "Type/category of the BNPL plan."
    - name: "bnpl_plan_status"
      expr: bnpl_plan_status
      comment: "Current status of the BNPL plan."
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner offering the BNPL plan."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the BNPL plan."
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Date when the BNPL plan becomes effective."
    - name: "effective_end_date"
      expr: effective_end_date
      comment: "Date when the BNPL plan expires."
  measures:
    - name: "total_bnpl_plans"
      expr: COUNT(1)
      comment: "Count of BNPL plans."
    - name: "avg_interest_rate_annual_percent"
      expr: AVG(CAST(interest_rate_annual_percent AS DOUBLE))
      comment: "Average annual interest rate for BNPL plans."
    - name: "avg_early_repayment_fee_percent"
      expr: AVG(CAST(early_repayment_fee_percent AS DOUBLE))
      comment: "Average early repayment fee percentage."
    - name: "total_max_total_amount"
      expr: SUM(CAST(max_total_amount AS DOUBLE))
      comment: "Total of maximum total amounts across BNPL plans."
    - name: "avg_max_installment_amount"
      expr: AVG(CAST(max_installment_amount AS DOUBLE))
      comment: "Average maximum installment amount."
    - name: "total_maximum_credit_limit"
      expr: SUM(CAST(maximum_credit_limit AS DOUBLE))
      comment: "Total maximum credit limit across BNPL plans."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and service‑level metrics for product bundles."
  source: "`payments_fintech_ecm`.`product`.`bundle`"
  dimensions:
    - name: "bundle_name"
      expr: bundle_name
      comment: "Name of the bundle."
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type/category of the bundle."
    - name: "bundle_status"
      expr: bundle_status
      comment: "Current lifecycle status of the bundle."
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner that provides the bundle."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the bundle pricing."
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the bundle becomes effective."
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the bundle expires."
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Count of product bundles."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price of bundles."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied across bundles."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate for bundles."
    - name: "total_sla_penalty_amount"
      expr: SUM(CAST(sla_penalty_amount AS DOUBLE))
      comment: "Total SLA penalty amount across bundles."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key limits applied to payment products (e.g., daily, monthly caps)."
  source: "`payments_fintech_ecm`.`product`.`limit`"
  dimensions:
    - name: "limit_name"
      expr: limit_name
      comment: "Descriptive name of the limit."
    - name: "limit_type"
      expr: limit_type
      comment: "Type of limit (e.g., transaction, withdrawal)."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency for the limit amounts."
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the limit becomes effective."
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the limit expires."
  measures:
    - name: "total_limits"
      expr: COUNT(1)
      comment: "Count of limit records."
    - name: "avg_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average limit amount."
    - name: "total_daily_cumulative_limit"
      expr: SUM(CAST(daily_cumulative_limit AS DOUBLE))
      comment: "Total daily cumulative limit across all limits."
    - name: "avg_monthly_cumulative_limit"
      expr: AVG(CAST(monthly_cumulative_limit AS DOUBLE))
      comment: "Average monthly cumulative limit."
    - name: "total_weekly_cumulative_limit"
      expr: SUM(CAST(weekly_cumulative_limit AS DOUBLE))
      comment: "Total weekly cumulative limit."
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`product_a2a_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core metrics for account‑to‑account (A2A) payment products."
  source: "`payments_fintech_ecm`.`product`.`a2a_product`"
  dimensions:
    - name: "a2a_product_name"
      expr: a2a_product_name
      comment: "Name of the A2A product."
    - name: "a2a_product_status"
      expr: a2a_product_status
      comment: "Current status of the A2A product."
    - name: "ecosystem_partner_id"
      expr: ecosystem_partner_id
      comment: "Partner associated with the A2A product."
    - name: "currency_id"
      expr: currency_id
      comment: "Currency of the A2A product."
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the A2A product became effective."
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the A2A product expires."
  measures:
    - name: "total_a2a_products"
      expr: COUNT(1)
      comment: "Count of A2A products."
    - name: "avg_max_transaction_amount"
      expr: AVG(CAST(max_transaction_amount AS DOUBLE))
      comment: "Average maximum transaction amount for A2A products."
    - name: "avg_min_transaction_amount"
      expr: AVG(CAST(min_transaction_amount AS DOUBLE))
      comment: "Average minimum transaction amount for A2A products."
    - name: "avg_surcharge_rate"
      expr: AVG(CAST(surcharge_rate AS DOUBLE))
      comment: "Average surcharge rate for A2A products."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharge amount across A2A products."
$$;