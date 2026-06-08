-- Metric views for domain: distribution | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_capacitor_bank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key asset and investment metrics for capacitor banks"
  source: "`energy_utilities_ecm`.`distribution`.`capacitor_bank`"
  dimensions:
    - name: "bank_type"
      expr: bank_type
      comment: "Type of capacitor bank (e.g., shunt, series)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the bank"
    - name: "in_service_date"
      expr: in_service_date
      comment: "Date the capacitor bank entered service"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost of capacitor banks, indicating capital investment"
    - name: "avg_asset_condition_score"
      expr: AVG(CAST(asset_condition_score AS DOUBLE))
      comment: "Average condition score of capacitor banks, reflecting asset health"
    - name: "count_banks"
      expr: COUNT(1)
      comment: "Number of capacitor banks in the system"
    - name: "avg_voltage_rating_kv"
      expr: AVG(CAST(voltage_rating_kv AS DOUBLE))
      comment: "Average voltage rating of capacitor banks"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_der_interconnection_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic DER capacity and count metrics"
  source: "`energy_utilities_ecm`.`distribution`.`der_interconnection_point`"
  dimensions:
    - name: "der_type"
      expr: der_type
      comment: "DER technology type (e.g., solar, wind)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the DER point"
    - name: "interconnection_agreement_status"
      expr: interconnection_agreement_status
      comment: "Status of the interconnection agreement"
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the DER point was commissioned"
  measures:
    - name: "total_export_capacity_kw"
      expr: SUM(CAST(export_capacity_kw AS DOUBLE))
      comment: "Total export capacity of DER interconnection points"
    - name: "total_nameplate_capacity_kw"
      expr: SUM(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Total nameplate capacity of DERs"
    - name: "avg_nameplate_capacity_kw"
      expr: AVG(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Average nameplate capacity per DER point"
    - name: "count_der_points"
      expr: COUNT(1)
      comment: "Number of DER interconnection points"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_substation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and reliability KPIs for distribution substations"
  source: "`energy_utilities_ecm`.`distribution`.`distribution_substation`"
  dimensions:
    - name: "substation_type"
      expr: substation_type
      comment: "Classification of substation (e.g., primary, secondary)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the substation"
    - name: "commissioning_date"
      expr: commissioning_date
      comment: "Date the substation was commissioned"
  measures:
    - name: "count_substations"
      expr: COUNT(1)
      comment: "Total number of distribution substations"
    - name: "total_peak_load_mw"
      expr: SUM(CAST(peak_load_mw AS DOUBLE))
      comment: "Aggregate peak load across all substations"
    - name: "avg_load_factor_percent"
      expr: AVG(CAST(load_factor_percent AS DOUBLE))
      comment: "Average load factor, indicating utilization efficiency"
    - name: "total_reliability_caidi_minutes"
      expr: SUM(CAST(reliability_index_caidi_minutes AS DOUBLE))
      comment: "Cumulative CAIDI minutes for reliability analysis"
    - name: "total_reliability_saidi_minutes"
      expr: SUM(CAST(reliability_index_saidi_minutes AS DOUBLE))
      comment: "Cumulative SAIDI minutes for reliability analysis"
    - name: "total_reliability_saifi_count"
      expr: SUM(CAST(reliability_index_saifi_count AS DOUBLE))
      comment: "Cumulative SAIFI count for reliability analysis"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_feeder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feeder performance and DER integration metrics"
  source: "`energy_utilities_ecm`.`distribution`.`feeder`"
  dimensions:
    - name: "feeder_type"
      expr: feeder_type
      comment: "Type of feeder (e.g., radial, loop)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the feeder"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification"
    - name: "in_service_date"
      expr: in_service_date
      comment: "Date the feeder entered service"
  measures:
    - name: "count_feeders"
      expr: COUNT(1)
      comment: "Number of feeders in the network"
    - name: "total_peak_load_mw"
      expr: SUM(CAST(peak_load_mw AS DOUBLE))
      comment: "Combined peak load of all feeders"
    - name: "avg_length_miles"
      expr: AVG(CAST(length_miles AS DOUBLE))
      comment: "Average feeder length in miles"
    - name: "total_der_hosting_capacity_mw"
      expr: SUM(CAST(der_hosting_capacity_mw AS DOUBLE))
      comment: "Total DER hosting capacity across feeders"
    - name: "flisr_enabled_feeder_count"
      expr: SUM(CASE WHEN flisr_enabled THEN 1 ELSE 0 END)
      comment: "Count of feeders with FLISR enabled"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic load and reliability metrics for service territories"
  source: "`energy_utilities_ecm`.`distribution`.`service_territory`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the territory"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model"
    - name: "created_timestamp"
      expr: created_timestamp
      comment: "Timestamp when the territory record was created"
  measures:
    - name: "count_territories"
      expr: COUNT(1)
      comment: "Number of service territories"
    - name: "total_connected_load_mw"
      expr: SUM(CAST(total_connected_load_mw AS DOUBLE))
      comment: "Aggregate connected load across territories"
    - name: "avg_peak_demand_mw"
      expr: AVG(CAST(peak_demand_mw AS DOUBLE))
      comment: "Average peak demand per territory"
    - name: "avg_der_penetration_percent"
      expr: AVG(CAST(der_penetration_percent AS DOUBLE))
      comment: "Average DER penetration percentage"
    - name: "avg_reliability_caidi_index"
      expr: AVG(CAST(caidi_index AS DOUBLE))
      comment: "Average CAIDI reliability index"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`distribution_reliability_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reliability performance indicators for distribution"
  source: "`energy_utilities_ecm`.`distribution`.`distribution_reliability_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Classification of reliability event (e.g., outage, fault)"
    - name: "event_start_timestamp"
      expr: event_start_timestamp
      comment: "Timestamp when the event started"
  measures:
    - name: "count_events"
      expr: COUNT(1)
      comment: "Total number of reliability events recorded"
    - name: "total_customer_minutes_interrupted"
      expr: SUM(CAST(customer_minutes_interrupted AS DOUBLE))
      comment: "Aggregate customer interruption minutes, reflecting impact severity"
    - name: "total_energy_not_served_mwh"
      expr: SUM(CAST(energy_not_served_mwh AS DOUBLE))
      comment: "Total energy not served due to reliability events"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of reliability events in minutes"
    - name: "total_load_interrupted_mw"
      expr: SUM(CAST(load_interrupted_mw AS DOUBLE))
      comment: "Total MW of load interrupted across events"
$$;