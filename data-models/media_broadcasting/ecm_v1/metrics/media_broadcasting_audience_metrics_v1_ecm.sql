-- Metric views for domain: audience | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_cross_platform_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key cross‑platform audience performance indicators for strategic planning and media buying decisions"
  source: "`media_broadcasting_ecm`.`audience`.`cross_platform_measurement`"
  dimensions:
    - name: "measurement_period_start"
      expr: measurement_period_start
      comment: "Start date of the measurement period"
    - name: "measurement_period_end"
      expr: measurement_period_end
      comment: "End date of the measurement period"
    - name: "market_coverage_id"
      expr: market_coverage_id
      comment: "Identifier for the market coverage area"
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of the content being measured"
    - name: "daypart_code"
      expr: daypart_code
      comment: "Daypart code (e.g., prime, daytime)"
  measures:
    - name: "total_audience_share"
      expr: SUM(CAST(audience_share AS DOUBLE))
      comment: "Total audience share across all measurements in the period"
    - name: "average_frequency"
      expr: AVG(CAST(average_frequency AS DOUBLE))
      comment: "Average frequency of exposure per audience"
    - name: "total_cross_platform_grp"
      expr: SUM(CAST(cross_platform_grp AS DOUBLE))
      comment: "Sum of Gross Rating Points (GRP) from cross‑platform measurement"
    - name: "total_cross_platform_trp"
      expr: SUM(CAST(cross_platform_trp AS DOUBLE))
      comment: "Sum of Target Rating Points (TRP) from cross‑platform measurement"
    - name: "avg_co_viewing_factor"
      expr: AVG(CAST(co_viewing_adjustment_factor AS DOUBLE))
      comment: "Average co‑viewing adjustment factor applied to the measurement"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_nielsen_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core Nielsen rating metrics used to evaluate program performance and advertising effectiveness"
  source: "`media_broadcasting_ecm`.`audience`.`nielsen_rating`"
  dimensions:
    - name: "air_date"
      expr: air_date
      comment: "Date the program aired"
    - name: "market_coverage_id"
      expr: market_coverage_id
      comment: "Market coverage identifier"
    - name: "daypart_id"
      expr: daypart_id
      comment: "Daypart identifier for the broadcast"
  measures:
    - name: "total_impressions"
      expr: SUM(CAST(impressions AS DOUBLE))
      comment: "Total number of impressions recorded"
    - name: "avg_audience_rating"
      expr: AVG(CAST(average_audience AS DOUBLE))
      comment: "Average audience rating across the sample"
    - name: "total_reach"
      expr: SUM(CAST(reach AS DOUBLE))
      comment: "Total reach (unique persons) measured"
    - name: "avg_trp"
      expr: AVG(CAST(trp AS DOUBLE))
      comment: "Average Target Rating Points (TRP) for the program"
    - name: "avg_household_rating"
      expr: AVG(CAST(household_rating AS DOUBLE))
      comment: "Average household rating"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`audience_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Engagement event KPIs that surface viewer interaction quality and ad effectiveness"
  source: "`media_broadcasting_ecm`.`audience`.`engagement_event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Calendar day of the engagement event"
    - name: "content_genre"
      expr: content_genre
      comment: "Genre of the content associated with the event"
    - name: "device_type"
      expr: device_type
      comment: "Device type used for the session"
    - name: "is_ad_event"
      expr: is_ad_event
      comment: "Flag indicating whether the event involved an advertisement"
    - name: "is_sweeps_period"
      expr: is_sweeps_period
      comment: "Flag indicating if the event occurred during a sweeps period"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of engagement events captured"
    - name: "avg_engagement_depth"
      expr: AVG(CAST(engagement_depth_score AS DOUBLE))
      comment: "Average engagement depth score per event"
    - name: "ad_event_count"
      expr: SUM(CASE WHEN is_ad_event THEN 1 ELSE 0 END)
      comment: "Count of ad‑related engagement events"
$$;