-- Metric views for domain: search | Business: Ecommerce | Version: 1 | Generated on: 2026-05-04 23:19:28

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`search_click_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core click‑event activity and conversion signal"
  source: "`ecommerce_ecm`.`search`.`click_event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the click event"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the click"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the user"
    - name: "is_bot"
      expr: is_bot
      comment: "Whether the click originated from a bot"
    - name: "personalization_flag"
      expr: personalization_flag
      comment: "Flag indicating if personalization was applied"
    - name: "experiment_variant"
      expr: experiment_variant
      comment: "A/B test variant identifier"
  measures:
    - name: "total_clicks"
      expr: COUNT(1)
      comment: "Total number of click events recorded"
    - name: "conversion_count"
      expr: SUM(CASE WHEN is_conversion THEN 1 ELSE 0 END)
      comment: "Number of click events that resulted in a conversion"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`search_query_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Search query volume and zero‑result incidence"
  source: "`ecommerce_ecm`.`search`.`query_log`"
  dimensions:
    - name: "query_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the query event"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the query"
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country code derived from IP"
    - name: "zero_result_flag"
      expr: zero_result_flag
      comment: "Indicates if the query returned no results"
  measures:
    - name: "total_queries"
      expr: COUNT(1)
      comment: "Total number of search queries logged"
    - name: "zero_result_queries"
      expr: SUM(CASE WHEN zero_result_flag THEN 1 ELSE 0 END)
      comment: "Number of queries that returned zero results"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT customer_profile_id)
      comment: "Unique customers issuing queries"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`search_trending_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trending query performance and confidence"
  source: "`ecommerce_ecm`.`search`.`trending_query`"
  dimensions:
    - name: "trend_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the trending query was recorded"
    - name: "locale"
      expr: locale
      comment: "Locale of the query"
    - name: "language_code"
      expr: language_code
      comment: "Language of the query"
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag indicating seasonal relevance"
    - name: "is_promoted"
      expr: is_promoted
      comment: "Whether the query is promoted"
  measures:
    - name: "total_trending_queries"
      expr: COUNT(1)
      comment: "Count of trending queries captured"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score across trending queries"
    - name: "total_query_volume"
      expr: SUM(CAST(query_volume AS DOUBLE))
      comment: "Aggregate query volume for trending queries"
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`search_autocomplete_suggestion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Autocomplete suggestion effectiveness"
  source: "`ecommerce_ecm`.`search`.`autocomplete_suggestion`"
  dimensions:
    - name: "suggestion_type"
      expr: suggestion_type
      comment: "Type of autocomplete suggestion"
    - name: "language_locale"
      expr: language_locale
      comment: "Locale of the suggestion"
    - name: "is_personalized"
      expr: is_personalized
      comment: "Whether the suggestion was personalized"
    - name: "editorial_source"
      expr: editorial_source
      comment: "Editorial source of the suggestion"
  measures:
    - name: "total_suggestions"
      expr: COUNT(1)
      comment: "Total autocomplete suggestions generated"
    - name: "avg_click_through_rate"
      expr: AVG(CAST(click_through_rate AS DOUBLE))
      comment: "Average click‑through rate of suggestions"
    - name: "avg_popularity_score"
      expr: AVG(CAST(popularity_score AS DOUBLE))
      comment: "Average popularity score of suggestions"
$$;