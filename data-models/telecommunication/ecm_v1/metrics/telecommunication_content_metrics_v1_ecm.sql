-- Metric views for domain: content | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`content_ad_insertion_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for ad insertion policies, informing ad revenue strategy and operational readiness"
  source: "`telecommunication_ecm`.`content`.`ad_insertion_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of ad insertion policy (e.g., linear, OTT)"
  measures:
    - name: "total_ad_insertion_policies"
      expr: COUNT(1)
      comment: "Total number of ad insertion policies defined"
    - name: "average_minimum_cpm_floor"
      expr: AVG(CAST(minimum_cpm_floor AS DOUBLE))
      comment: "Average minimum CPM floor across policies"
    - name: "average_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share percentage set in policies"
    - name: "dynamic_ad_insertion_enabled_count"
      expr: SUM(CASE WHEN dynamic_ad_insertion_enabled THEN 1 ELSE 0 END)
      comment: "Count of policies where dynamic ad insertion is enabled"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`content_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement metrics that drive subscription revenue and usage insights"
  source: "`telecommunication_ecm`.`content`.`entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Classification of entitlement (e.g., subscription, rental)"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total entitlement records"
    - name: "active_entitlements"
      expr: SUM(CASE WHEN entitlement_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of active entitlements"
    - name: "distinct_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Unique subscribers with entitlements"
    - name: "average_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share % across entitlements"
    - name: "total_access_count"
      expr: SUM(CAST(total_access_count AS DOUBLE))
      comment: "Cumulative access count for all entitlements"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`content_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License financial metrics supporting content rights and revenue planning"
  source: "`telecommunication_ecm`.`content`.`license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (e.g., active, expired)"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of licenses issued"
    - name: "average_fee_amount"
      expr: AVG(CAST(fee_amount AS DOUBLE))
      comment: "Average license fee amount"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total license fee revenue"
    - name: "average_revenue_share_percentage"
      expr: AVG(CAST(revenue_share_percentage AS DOUBLE))
      comment: "Average revenue share % across licenses"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`content_ott_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core OTT subscription KPIs for revenue and adoption tracking"
  source: "`telecommunication_ecm`.`content`.`ott_subscription`"
  dimensions:
    - name: "subscription_tier"
      expr: subscription_tier
      comment: "Tier level of the OTT subscription (e.g., basic, premium)"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total OTT subscriptions"
    - name: "average_monthly_fee"
      expr: AVG(CAST(monthly_subscription_fee AS DOUBLE))
      comment: "Average monthly subscription fee"
    - name: "total_monthly_revenue"
      expr: SUM(CAST(monthly_subscription_fee AS DOUBLE))
      comment: "Total monthly recurring revenue from OTT subscriptions"
    - name: "sso_enabled_count"
      expr: SUM(CASE WHEN sso_enabled THEN 1 ELSE 0 END)
      comment: "Number of subscriptions with SSO enabled"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`content_vod_rental`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VOD rental performance metrics informing pricing and promotion effectiveness"
  source: "`telecommunication_ecm`.`content`.`vod_rental`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
  measures:
    - name: "total_rentals"
      expr: COUNT(1)
      comment: "Total VOD rental transactions"
    - name: "total_rental_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue generated from VOD rentals"
    - name: "average_rental_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average price per rental"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Aggregate discount amount applied across rentals"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`content_network_recording`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network recording utilization metrics for capacity planning and quality monitoring"
  source: "`telecommunication_ecm`.`content`.`network_recording`"
  dimensions:
    - name: "recording_status"
      expr: recording_status
      comment: "Current status of the recording (e.g., completed, failed)"
  measures:
    - name: "total_recordings"
      expr: COUNT(1)
      comment: "Total network recording events"
    - name: "total_file_size_mb"
      expr: SUM(CAST(file_size_mb AS DOUBLE))
      comment: "Aggregate file size of recordings in MB"
    - name: "total_storage_consumed_mb"
      expr: SUM(CAST(storage_quota_consumed_mb AS DOUBLE))
      comment: "Total storage quota consumed by recordings"
$$;