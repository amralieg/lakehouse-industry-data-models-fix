-- Metric views for domain: merchant | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core merchant overview metrics for executive and product steering"
  source: "`payments_fintech_ecm`.`merchant`.`merchant`"
  dimensions:
    - name: "business_type"
      expr: business_type
      comment: "Merchant's declared business type"
    - name: "business_country"
      expr: business_country
      comment: "Country where the merchant operates"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the merchant (e.g., active, terminated)"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the merchant was activated"
  measures:
    - name: "total_merchants"
      expr: COUNT(1)
      comment: "Total number of merchant records"
    - name: "average_mdr_rate"
      expr: AVG(CAST(mdr_rate AS DOUBLE))
      comment: "Average merchant discount rate (MDR) across all merchants"
    - name: "average_monthly_processing_limit"
      expr: AVG(CAST(monthly_processing_limit AS DOUBLE))
      comment: "Average monthly processing limit per merchant"
    - name: "average_single_transaction_limit"
      expr: AVG(CAST(transaction_limit_single AS DOUBLE))
      comment: "Average single transaction limit per merchant"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_fee_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial fee schedule metrics to monitor revenue impact and fee structure"
  source: "`payments_fintech_ecm`.`merchant`.`merchant_fee_schedule`"
  dimensions:
    - name: "scheme_id"
      expr: scheme_id
      comment: "Payment scheme identifier (e.g., Visa, Mastercard)"
    - name: "fee_type"
      expr: fee_type
      comment: "Category of the fee (e.g., transaction, monthly)"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month when the fee schedule became effective"
  measures:
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Sum of all fee amounts across fee schedules"
    - name: "average_fee_percentage"
      expr: AVG(CAST(fee_percentage AS DOUBLE))
      comment: "Average fee percentage across fee schedules"
    - name: "fee_schedule_count"
      expr: COUNT(1)
      comment: "Number of fee schedule records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_processing_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Limits governing merchant transaction processing, useful for risk and capacity planning"
  source: "`payments_fintech_ecm`.`merchant`.`processing_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of limit (e.g., daily, monthly, single transaction)"
    - name: "payment_corridor_id"
      expr: payment_corridor_id
      comment: "Identifier for the payment corridor (currency routing)"
    - name: "underwriting_decision_id"
      expr: underwriting_decision_id
      comment: "Decision identifier linked to underwriting outcome"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the limit became effective"
  measures:
    - name: "total_daily_volume_cap"
      expr: SUM(CAST(daily_volume_cap_amount AS DOUBLE))
      comment: "Total daily volume cap amount across all processing limits"
    - name: "average_card_not_present_limit"
      expr: AVG(CAST(card_not_present_limit_amount AS DOUBLE))
      comment: "Average card‑not‑present transaction limit amount"
    - name: "average_cross_border_limit"
      expr: AVG(CAST(cross_border_limit_amount AS DOUBLE))
      comment: "Average cross‑border transaction limit amount"
    - name: "processing_limit_count"
      expr: COUNT(1)
      comment: "Number of processing limit records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_risk_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key risk indicators for merchants, supporting risk management and underwriting decisions"
  source: "`payments_fintech_ecm`.`merchant`.`risk_profile`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification"
    - name: "risk_status"
      expr: risk_status
      comment: "Current risk status (e.g., active, under review)"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the risk profile became effective"
  measures:
    - name: "average_chargeback_rate_current"
      expr: AVG(CAST(chargeback_rate_current AS DOUBLE))
      comment: "Average current chargeback rate across risk profiles"
    - name: "average_fraud_rate"
      expr: AVG(CAST(fraud_rate AS DOUBLE))
      comment: "Average fraud rate across risk profiles"
    - name: "average_monthly_volume"
      expr: AVG(CAST(average_monthly_volume AS DOUBLE))
      comment: "Average monthly transaction volume (in monetary units)"
    - name: "risk_profile_count"
      expr: COUNT(1)
      comment: "Number of risk profile records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Location‑level transaction limits and risk scores, informing operational capacity and regional risk monitoring"
  source: "`payments_fintech_ecm`.`merchant`.`location`"
  dimensions:
    - name: "state_province"
      expr: state_province
      comment: "State or province of the location"
    - name: "city"
      expr: city
      comment: "City of the location"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the location"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_date)
      comment: "Month the location became active"
  measures:
    - name: "average_daily_transaction_limit"
      expr: AVG(CAST(daily_transaction_limit AS DOUBLE))
      comment: "Average daily transaction limit per location"
    - name: "average_single_transaction_limit"
      expr: AVG(CAST(single_transaction_limit AS DOUBLE))
      comment: "Average single transaction limit per location"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score for locations"
    - name: "location_count"
      expr: COUNT(1)
      comment: "Number of merchant location records"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`merchant_pricing_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing plan metrics that drive revenue and competitive positioning"
  source: "`payments_fintech_ecm`.`merchant`.`merchant_pricing_plan`"
  dimensions:
    - name: "plan_name"
      expr: plan_name
      comment: "Descriptive name of the pricing plan"
    - name: "pricing_model_type"
      expr: pricing_model_type
      comment: "Model type (e.g., flat, tiered)"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the pricing plan became effective"
  measures:
    - name: "average_mdr_rate_percentage"
      expr: AVG(CAST(mdr_rate_percentage AS DOUBLE))
      comment: "Average MDR rate percentage across pricing plans"
    - name: "average_interchange_markup_percentage"
      expr: AVG(CAST(interchange_markup_percentage AS DOUBLE))
      comment: "Average interchange markup percentage"
    - name: "pricing_plan_count"
      expr: COUNT(1)
      comment: "Number of merchant pricing plan records"
$$;