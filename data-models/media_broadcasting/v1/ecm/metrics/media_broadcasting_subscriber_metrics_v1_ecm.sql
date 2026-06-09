-- Metric views for domain: subscriber | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core subscription revenue and subscriber metrics"
  source: "`media_broadcasting_ecm`.`subscriber`.`subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the subscription (active, cancelled, etc.)"
    - name: "subscription_type"
      expr: subscription_type
      comment: "Type of subscription (e.g., prepaid, postpaid)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary values"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle descriptor (monthly, yearly)"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the subscriber was acquired"
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether auto‑renew is enabled for the subscription"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(1)
      comment: "Total number of subscription records"
    - name: "total_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Sum of ARPU across all subscriptions (revenue proxy)"
    - name: "average_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average ARPU per subscription"
    - name: "total_ltv"
      expr: SUM(CAST(ltv AS DOUBLE))
      comment: "Sum of Lifetime Value across subscriptions"
    - name: "average_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average Lifetime Value per subscription"
    - name: "total_base_rate_revenue"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate amount billed"
    - name: "total_promotional_revenue"
      expr: SUM(CAST(promotional_rate_amount AS DOUBLE))
      comment: "Total promotional discount amount applied"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_churn_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Churn related KPIs"
  source: "`media_broadcasting_ecm`.`subscriber`.`churn_event`"
  dimensions:
    - name: "churn_type"
      expr: churn_type
      comment: "Categorization of churn (voluntary, involuntary, etc.)"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the churned subscription"
    - name: "cancellation_channel"
      expr: cancellation_channel
      comment: "Channel used for cancellation"
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the churn event"
    - name: "churn_month"
      expr: DATE_TRUNC('month', churn_timestamp)
      comment: "Month when churn occurred"
  measures:
    - name: "churn_event_count"
      expr: COUNT(1)
      comment: "Number of churn events recorded"
    - name: "average_churn_prediction_score"
      expr: AVG(CAST(churn_prediction_score AS DOUBLE))
      comment: "Average churn prediction score at time of churn"
    - name: "total_lifetime_revenue_lost"
      expr: SUM(CAST(total_lifetime_revenue AS DOUBLE))
      comment: "Sum of lifetime revenue associated with churned subscriptions"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber_household`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Household level financial and risk metrics"
  source: "`media_broadcasting_ecm`.`subscriber`.`household`"
  dimensions:
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier associated with the household"
    - name: "country_code"
      expr: country_code
      comment: "Country of the household"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the household"
    - name: "city"
      expr: city
      comment: "City of the household"
    - name: "household_status"
      expr: household_status
      comment: "Current status of the household account"
    - name: "mvpd_affiliation"
      expr: mvpd_affiliation
      comment: "MVPD affiliation flag"
    - name: "subscription_start_month"
      expr: DATE_TRUNC('month', subscription_start_date)
      comment: "Month when household subscription started"
    - name: "subscription_end_month"
      expr: DATE_TRUNC('month', subscription_end_date)
      comment: "Month when household subscription ended"
  measures:
    - name: "household_count"
      expr: COUNT(1)
      comment: "Number of households"
    - name: "average_revenue_per_user"
      expr: AVG(CAST(average_revenue_per_user AS DOUBLE))
      comment: "Average revenue per user within a household"
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_value AS DOUBLE))
      comment: "Aggregate lifetime value of all households"
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across households"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber level engagement and financial KPIs"
  source: "`media_broadcasting_ecm`.`subscriber`.`subscriber`"
  dimensions:
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the subscriber"
    - name: "country_code"
      expr: country_code
      comment: "Country of the subscriber"
    - name: "registration_source"
      expr: registration_source
      comment: "Source through which the subscriber registered"
    - name: "account_status"
      expr: account_status
      comment: "Current account status (active, suspended, etc.)"
    - name: "subscription_start_month"
      expr: DATE_TRUNC('month', subscription_start_date)
      comment: "Month of subscription start"
    - name: "subscription_end_month"
      expr: DATE_TRUNC('month', subscription_end_date)
      comment: "Month of subscription end"
  measures:
    - name: "subscriber_count"
      expr: COUNT(1)
      comment: "Total number of subscriber records"
    - name: "average_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average ARPU per subscriber"
    - name: "average_ltv"
      expr: AVG(CAST(ltv AS DOUBLE))
      comment: "Average Lifetime Value per subscriber"
    - name: "average_total_viewing_hours"
      expr: AVG(CAST(total_viewing_hours AS DOUBLE))
      comment: "Average total viewing hours per subscriber"
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across subscribers"
$$;