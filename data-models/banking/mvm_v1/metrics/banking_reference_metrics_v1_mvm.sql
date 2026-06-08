-- Metric views for domain: reference | Business: Banking | Version: 1 | Generated on: 2026-05-03 02:23:20

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_benchmark_rate_fixing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for benchmark rate fixing data quality and activity"
  source: "`banking_ecm`.`reference`.`benchmark_rate_fixing`"
  dimensions:
    - name: "rate_benchmark_id"
      expr: rate_benchmark_id
      comment: "Identifier of the benchmark rate"
    - name: "currency_id"
      expr: currency_id
      comment: "Currency associated with the rate"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the rate becomes effective"
    - name: "tenor_code"
      expr: tenor_code
      comment: "Tenor code describing the rate term"
    - name: "rate_status"
      expr: rate_status
      comment: "Current status of the rate"
    - name: "is_revised"
      expr: is_revised
      comment: "Indicates if the rate has been revised"
  measures:
    - name: "total_rate_value"
      expr: SUM(CAST(rate_value AS DOUBLE))
      comment: "Sum of all benchmark rate values"
    - name: "avg_rate_value"
      expr: AVG(CAST(rate_value AS DOUBLE))
      comment: "Average benchmark rate value"
    - name: "total_spread_adjustment"
      expr: SUM(CAST(spread_adjustment AS DOUBLE))
      comment: "Sum of spread adjustments across rates"
    - name: "avg_spread_adjustment"
      expr: AVG(CAST(spread_adjustment AS DOUBLE))
      comment: "Average spread adjustment"
    - name: "revised_rate_count"
      expr: SUM(CASE WHEN is_revised THEN 1 ELSE 0 END)
      comment: "Count of rates that have been revised"
    - name: "regulatory_reporting_rate_count"
      expr: SUM(CASE WHEN regulatory_reporting_flag THEN 1 ELSE 0 END)
      comment: "Count of rates flagged for regulatory reporting"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency reference health and coverage metrics"
  source: "`banking_ecm`.`reference`.`currency`"
  dimensions:
    - name: "currency_status"
      expr: currency_status
      comment: "Operational status of the currency"
    - name: "currency_type"
      expr: currency_type
      comment: "Type classification of the currency"
    - name: "is_base_currency"
      expr: is_base_currency
      comment: "Flag indicating if this is a base currency"
    - name: "is_crypto_currency"
      expr: is_crypto_currency
      comment: "Flag indicating if this is a cryptocurrency"
    - name: "iso_code"
      expr: iso_code
      comment: "ISO code of the currency"
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date from which the currency is effective"
  measures:
    - name: "currency_count"
      expr: COUNT(1)
      comment: "Total number of currency records"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country reference coverage and risk indicators"
  source: "`banking_ecm`.`reference`.`country`"
  dimensions:
    - name: "region"
      expr: region
      comment: "Geographic region of the country"
    - name: "sub_region"
      expr: sub_region
      comment: "Sub‑region of the country"
    - name: "sovereign_credit_rating"
      expr: sovereign_credit_rating
      comment: "Sovereign credit rating"
    - name: "iso_alpha_2_code"
      expr: iso_alpha_2_code
      comment: "ISO Alpha‑2 country code"
    - name: "time_zone"
      expr: time_zone
      comment: "Primary time zone of the country"
  measures:
    - name: "country_count"
      expr: COUNT(1)
      comment: "Total number of country records"
    - name: "active_country_count"
      expr: SUM(CASE WHEN active_flag THEN 1 ELSE 0 END)
      comment: "Count of countries marked as active"
    - name: "ofac_sanctions_country_count"
      expr: SUM(CASE WHEN ofac_sanctions_flag THEN 1 ELSE 0 END)
      comment: "Count of countries with OFAC sanctions flag"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_holiday_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics on holiday calendar coverage and quality"
  source: "`banking_ecm`.`reference`.`holiday_calendar`"
  dimensions:
    - name: "calendar_type"
      expr: calendar_type
      comment: "Type of the holiday calendar"
    - name: "calendar_status"
      expr: calendar_status
      comment: "Current status of the calendar"
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone associated with the calendar"
    - name: "governing_authority"
      expr: governing_authority
      comment: "Authority governing the calendar"
  measures:
    - name: "holiday_calendar_count"
      expr: COUNT(1)
      comment: "Total number of holiday calendars"
    - name: "default_calendar_count"
      expr: SUM(CASE WHEN is_default_calendar THEN 1 ELSE 0 END)
      comment: "Count of calendars marked as default"
$$;

CREATE OR REPLACE VIEW `banking_ecm`.`_metrics`.`reference_bic_directory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BIC directory health and participation metrics"
  source: "`banking_ecm`.`reference`.`bic_directory`"
  dimensions:
    - name: "country_id"
      expr: country_id
      comment: "Country associated with the BIC"
    - name: "institution_type"
      expr: institution_type
      comment: "Type of financial institution"
    - name: "routing_number"
      expr: routing_number
      comment: "Routing number for the institution"
    - name: "swift_service_profile"
      expr: swift_service_profile
      comment: "SWIFT service profile identifier"
    - name: "time_zone"
      expr: time_zone
      comment: "Time zone of the institution"
  measures:
    - name: "bic_entry_count"
      expr: COUNT(1)
      comment: "Total number of BIC directory entries"
    - name: "active_bic_count"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of active BIC entries"
    - name: "sepa_participant_count"
      expr: SUM(CASE WHEN sepa_participant THEN 1 ELSE 0 END)
      comment: "Count of BIC entries participating in SEPA"
    - name: "total_data_quality_score"
      expr: SUM(CAST(data_quality_score AS DOUBLE))
      comment: "Aggregate data quality score for BIC entries"
$$;