-- Metric views for domain: guest | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 02:26:41

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile overview metrics"
  source: "`restaurants_ecm`.`guest`.`profile`"
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the guest"
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (e.g., individual, corporate)"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the guest address"
    - name: "city"
      expr: city
      comment: "City of the guest address"
    - name: "state"
      expr: state
      comment: "State or province of the guest address"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Preferred language of the guest"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the guest profile"
  measures:
    - name: "total_guests"
      expr: COUNT(1)
      comment: "Total number of guest profiles"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_profile_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance metrics derived from guest profiles"
  source: "`restaurants_ecm`.`guest`.`profile`"
  dimensions:
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the guest"
    - name: "guest_type"
      expr: guest_type
      comment: "Guest type"
  measures:
    - name: "total_spent_sum"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total spend across all guests"
    - name: "average_spent"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average total spend per guest"
    - name: "average_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value per guest"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lifetime value metrics for guests"
  source: "`restaurants_ecm`.`guest`.`lifetime_value`"
  dimensions:
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "Lifetime value tier classification"
    - name: "segment"
      expr: segment
      comment: "Guest segment used for LTV analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of monetary values"
    - name: "ltv_status"
      expr: ltv_status
      comment: "Status of the LTV calculation"
    - name: "first_visit_month"
      expr: DATE_TRUNC('month', first_visit_date)
      comment: "Month of the guest's first visit"
  measures:
    - name: "total_historical_spend_sum"
      expr: SUM(CAST(total_historical_spend AS DOUBLE))
      comment: "Aggregate historical spend across all guests"
    - name: "average_historical_spend"
      expr: AVG(CAST(total_historical_spend AS DOUBLE))
      comment: "Average historical spend per guest"
    - name: "total_predicted_future_value_sum"
      expr: SUM(CAST(predicted_future_value AS DOUBLE))
      comment: "Sum of predicted future value across all guests"
    - name: "average_predicted_future_value"
      expr: AVG(CAST(predicted_future_value AS DOUBLE))
      comment: "Average predicted future value per guest"
    - name: "guest_count"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of distinct guests with LTV records"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interaction event metrics capturing guest engagement channels"
  source: "`restaurants_ecm`.`guest`.`interaction`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Interaction channel (e.g., email, SMS, app)"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction"
    - name: "is_test"
      expr: is_test
      comment: "Flag indicating if the interaction is a test"
    - name: "outcome"
      expr: outcome
      comment: "Resulting outcome of the interaction"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the interaction event"
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of interaction events"
    - name: "distinct_guest_interactors"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of distinct guests who generated interactions"
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint handling and resolution metrics"
  source: "`restaurants_ecm`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint"
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level assigned to the complaint"
    - name: "channel"
      expr: channel
      comment: "Channel through which the complaint was received"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints logged"
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Sum of monetary amounts resolved for complaints"
$$;