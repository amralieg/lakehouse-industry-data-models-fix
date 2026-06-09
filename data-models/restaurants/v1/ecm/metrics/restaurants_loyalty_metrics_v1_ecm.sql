-- Metric views for domain: loyalty | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core loyalty member KPIs for engagement and value"
  source: "`restaurants_ecm`.`loyalty`.`member`"
  dimensions:
    - name: "current_tier"
      expr: current_tier
      comment: "Current loyalty tier of member"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which member enrolled"
    - name: "site_id"
      expr: site_id
      comment: "Site identifier where member is associated"
  measures:
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total number of loyalty members"
    - name: "avg_current_points_balance"
      expr: AVG(CAST(current_points_balance AS DOUBLE))
      comment: "Average current points balance per member"
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Cumulative points earned across all members"
    - name: "total_points_expiring_soon"
      expr: SUM(CAST(points_expiring_soon AS DOUBLE))
      comment: "Total points that will expire soon, indicating potential redemption risk"
    - name: "avg_lifetime_points_earned"
      expr: AVG(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Average lifetime points earned per member"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction-level points ledger metrics linking spend and points activity"
  source: "`restaurants_ecm`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "loyalty_member_id"
      expr: loyalty_member_id
      comment: "Member associated with the points transaction"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of points transaction (earn, redeem, adjustment)"
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of the points transaction"
    - name: "restaurant_unit_id"
      expr: restaurant_unit_id
      comment: "Restaurant unit where transaction occurred"
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of points ledger transactions"
    - name: "total_order_amount"
      expr: SUM(CAST(order_total_amount AS DOUBLE))
      comment: "Total order amount associated with points transactions"
    - name: "avg_order_amount"
      expr: AVG(CAST(order_total_amount AS DOUBLE))
      comment: "Average order amount per points transaction"
    - name: "total_points_earn_rate"
      expr: SUM(CAST(points_earn_rate AS DOUBLE))
      comment: "Sum of points earn rate across transactions"
    - name: "voided_transactions"
      expr: COUNT(CASE WHEN is_voided THEN 1 END)
      comment: "Number of transactions that were voided"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`loyalty_offer_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption performance and discount impact metrics"
  source: "`restaurants_ecm`.`loyalty`.`redemption`"
  dimensions:
    - name: "member_id"
      expr: member_id
      comment: "Member who redeemed the offer"
    - name: "redemption_date"
      expr: DATE_TRUNC('day', redemption_timestamp)
      comment: "Date of redemption"
  measures:
    - name: "total_redemptions"
      expr: COUNT(1)
      comment: "Total number of offer redemptions"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount granted through redemptions"
    - name: "avg_discount_amount"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount amount per redemption"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`loyalty_challenge_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Challenge enrollment and progress metrics"
  source: "`restaurants_ecm`.`loyalty`.`challenge_enrollment`"
  dimensions:
    - name: "challenge_id"
      expr: challenge_id
      comment: "Challenge identifier"
    - name: "loyalty_member_id"
      expr: loyalty_member_id
      comment: "Member enrolled in the challenge"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which member enrolled"
    - name: "enrollment_status"
      expr: challenge_enrollment_status
      comment: "Current status of the enrollment"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of challenge enrollments"
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average progress percentage across enrollments"
    - name: "total_reward_value"
      expr: SUM(CAST(reward_value AS DOUBLE))
      comment: "Total monetary value of rewards issued for challenges"
    - name: "completed_enrollments"
      expr: COUNT(CASE WHEN challenge_enrollment_status = 'Completed' THEN 1 END)
      comment: "Number of enrollments that reached completion"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`loyalty_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offer catalog performance and configuration metrics"
  source: "`restaurants_ecm`.`loyalty`.`offer`"
  dimensions:
    - name: "offer_type"
      expr: offer_type
      comment: "Type/category of the offer"
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the offer"
    - name: "start_date"
      expr: DATE_TRUNC('day', start_date)
      comment: "Offer start date"
    - name: "end_date"
      expr: DATE_TRUNC('day', end_date)
      comment: "Offer end date"
  measures:
    - name: "total_offers"
      expr: COUNT(1)
      comment: "Total number of offers defined"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value across offers"
    - name: "total_points_multiplier"
      expr: SUM(CAST(points_multiplier AS DOUBLE))
      comment: "Sum of points multiplier configured for offers"
    - name: "stackable_offers_count"
      expr: COUNT(CASE WHEN stackable_flag THEN 1 END)
      comment: "Number of offers that are stackable"
$$;