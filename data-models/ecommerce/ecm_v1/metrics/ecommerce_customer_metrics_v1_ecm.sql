-- Metric views for domain: customer | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and status metrics for customer accounts"
  source: "`ecommerce_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (e.g., Active, Closed)"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_account_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health indicators for the customer base"
  source: "`ecommerce_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account (e.g., Gold, Silver)"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit across all accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per account"
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Sum of CLTV for all accounts"
    - name: "avg_customer_lifetime_value"
      expr: AVG(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Average CLTV per account"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_cltv_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CLTV and churn risk metrics for strategic planning"
  source: "`ecommerce_ecm`.`customer`.`cltv_score`"
  dimensions:
    - name: "cltv_tier"
      expr: cltv_tier
      comment: "Segment tier based on CLTV"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment identifier"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the CLTV values"
  measures:
    - name: "total_predicted_cltv_12m"
      expr: SUM(CAST(predicted_cltv_12m AS DOUBLE))
      comment: "Total predicted CLTV for the next 12 months"
    - name: "avg_predicted_cltv_12m"
      expr: AVG(CAST(predicted_cltv_12m AS DOUBLE))
      comment: "Average predicted CLTV for the next 12 months"
    - name: "total_predicted_cltv_36m"
      expr: SUM(CAST(predicted_cltv_36m AS DOUBLE))
      comment: "Total predicted CLTV for the next 36 months"
    - name: "avg_predicted_cltv_36m"
      expr: AVG(CAST(predicted_cltv_36m AS DOUBLE))
      comment: "Average predicted CLTV for the next 36 months"
    - name: "total_historical_cltv"
      expr: SUM(CAST(historical_cltv AS DOUBLE))
      comment: "Sum of historical CLTV values"
    - name: "avg_historical_cltv"
      expr: AVG(CAST(historical_cltv AS DOUBLE))
      comment: "Average historical CLTV"
    - name: "avg_churn_probability_score"
      expr: AVG(CAST(churn_probability_score AS DOUBLE))
      comment: "Average churn probability across customers"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program performance and member value metrics"
  source: "`ecommerce_ecm`.`customer`.`loyalty_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment (e.g., Active, Cancelled)"
    - name: "current_tier"
      expr: current_tier
      comment: "Current loyalty tier of the member"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Number of loyalty program enrollments"
    - name: "total_current_points_balance"
      expr: SUM(CAST(current_points_balance AS DOUBLE))
      comment: "Aggregate current points across all enrollments"
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points per enrollment"
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total lifetime points earned"
    - name: "avg_lifetime_points_earned"
      expr: AVG(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Average lifetime points earned per enrollment"
    - name: "total_membership_fee_paid"
      expr: SUM(CAST(membership_fee_paid AS DOUBLE))
      comment: "Total membership fees collected"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`customer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction and advocacy metrics from NPS surveys"
  source: "`ecommerce_ecm`.`customer`.`nps_response`"
  dimensions:
    - name: "nps_score"
      expr: nps_score
      comment: "Raw NPS score provided by the respondent"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of NPS survey (e.g., Post‑purchase, Periodic)"
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of NPS survey responses"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score from free‑text comments"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time taken to respond to the survey"
    - name: "count_promoters"
      expr: SUM(CASE WHEN CAST(nps_score AS INT) >= 9 THEN 1 ELSE 0 END)
      comment: "Number of promoter responses (NPS 9‑10)"
    - name: "count_detractors"
      expr: SUM(CASE WHEN CAST(nps_score AS INT) <= 6 THEN 1 ELSE 0 END)
      comment: "Number of detractor responses (NPS 0‑6)"
$$;