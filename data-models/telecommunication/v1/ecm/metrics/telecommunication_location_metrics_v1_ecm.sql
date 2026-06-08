-- Metric views for domain: location | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`location_coverage_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coverage area performance metrics for network planning and capacity decisions."
  source: "`telecommunication_ecm`.`location`.`coverage_area`"
  dimensions:
    - name: "service_territory_id"
      expr: service_territory_id
      comment: "Identifier of the service territory."
    - name: "technology_type"
      expr: technology_type
      comment: "Technology type (e.g., 4G, 5G)."
    - name: "coverage_status"
      expr: coverage_status
      comment: "Current status of the coverage area."
    - name: "coverage_tier"
      expr: coverage_tier
      comment: "Tier classification of the coverage area."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the coverage area effective date."
  measures:
    - name: "total_coverage_area_sqkm"
      expr: SUM(CAST(area_square_km AS DOUBLE))
      comment: "Total coverage area in square kilometers."
    - name: "avg_coverage_confidence_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average confidence level percent of coverage area."
    - name: "total_population_covered"
      expr: SUM(CAST(population_covered AS DOUBLE))
      comment: "Total number of people covered in the area."
    - name: "avg_predicted_downlink_mbps"
      expr: AVG(CAST(predicted_downlink_throughput_mbps AS DOUBLE))
      comment: "Average predicted downlink throughput (Mbps)."
    - name: "avg_predicted_uplink_mbps"
      expr: AVG(CAST(predicted_uplink_throughput_mbps AS DOUBLE))
      comment: "Average predicted uplink throughput (Mbps)."
    - name: "avg_predicted_signal_strength_dbm"
      expr: AVG(CAST(predicted_signal_strength_dbm AS DOUBLE))
      comment: "Average predicted signal strength (dBm)."
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of coverage area records."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`location_black_spot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for black spot identification and remediation planning."
  source: "`telecommunication_ecm`.`location`.`black_spot`"
  dimensions:
    - name: "service_territory_id"
      expr: service_territory_id
      comment: "Service territory where the black spot is located."
    - name: "black_spot_type"
      expr: black_spot_type
      comment: "Classification of the black spot (e.g., coverage, capacity)."
    - name: "black_spot_name"
      expr: black_spot_name
      comment: "Human‑readable name of the black spot."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month when the black spot was approved for remediation."
  measures:
    - name: "total_black_spot_area_sqkm"
      expr: SUM(CAST(area_square_km AS DOUBLE))
      comment: "Total area of black spots in square kilometers."
    - name: "avg_measured_download_speed_mbps"
      expr: AVG(CAST(measured_download_speed_mbps AS DOUBLE))
      comment: "Average measured download speed within black spots."
    - name: "avg_measured_upload_speed_mbps"
      expr: AVG(CAST(measured_upload_speed_mbps AS DOUBLE))
      comment: "Average measured upload speed within black spots."
    - name: "avg_measured_signal_strength_dbm"
      expr: AVG(CAST(measured_signal_strength_dbm AS DOUBLE))
      comment: "Average measured signal strength (dBm) in black spots."
    - name: "total_funding_amount_usd"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total funding amount allocated to black spot remediation (USD)."
    - name: "black_spot_count"
      expr: COUNT(1)
      comment: "Number of black spot records."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`location_drive_test_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drive‑test performance metrics used for network quality monitoring and optimization."
  source: "`telecommunication_ecm`.`location`.`drive_test_record`"
  dimensions:
    - name: "service_territory_id"
      expr: service_territory_id
      comment: "Service territory where the drive test was performed."
    - name: "technology_type"
      expr: technology_type
      comment: "Technology type under test (e.g., 4G, 5G)."
    - name: "test_campaign_id"
      expr: test_campaign_id
      comment: "Identifier of the test campaign."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to collect the drive‑test measurement."
    - name: "test_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of the drive‑test measurement."
  measures:
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average latency observed during drive tests (ms)."
    - name: "avg_throughput_downlink_mbps"
      expr: AVG(CAST(throughput_downlink_mbps AS DOUBLE))
      comment: "Average downlink throughput measured (Mbps)."
    - name: "avg_throughput_uplink_mbps"
      expr: AVG(CAST(throughput_uplink_mbps AS DOUBLE))
      comment: "Average uplink throughput measured (Mbps)."
    - name: "avg_rsrp_dbm"
      expr: AVG(CAST(rsrp_dbm AS DOUBLE))
      comment: "Average Reference Signal Received Power (dBm)."
    - name: "avg_rsrq_db"
      expr: AVG(CAST(rsrq_db AS DOUBLE))
      comment: "Average Reference Signal Received Quality (dB)."
    - name: "avg_sinr_db"
      expr: AVG(CAST(sinr_db AS DOUBLE))
      comment: "Average Signal‑to‑Interference‑plus‑Noise Ratio (dB)."
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of drive test records."
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`location_address_geocode`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geocoding quality metrics for address standardization and location accuracy."
  source: "`telecommunication_ecm`.`location`.`address_geocode`"
  dimensions:
    - name: "geocode_method"
      expr: geocode_method
      comment: "Method used for geocoding (e.g., batch, real‑time)."
    - name: "geocoding_provider"
      expr: geocoding_provider
      comment: "External provider used for geocoding."
    - name: "geocode_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month when the geocode record was created."
  measures:
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of address geocoding results."
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score indicating geocode quality."
    - name: "geocode_record_count"
      expr: COUNT(1)
      comment: "Number of address geocode records processed."
$$;