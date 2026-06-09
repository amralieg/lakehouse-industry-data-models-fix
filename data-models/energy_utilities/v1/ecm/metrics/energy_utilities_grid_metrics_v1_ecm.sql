-- Metric views for domain: grid | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_ace_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key ACE performance and compliance metrics for control areas"
  source: "`energy_utilities_ecm`.`grid`.`ace_record`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Identifier of the control area"
    - name: "measurement_date"
      expr: DATE_TRUNC('day', measurement_timestamp_utc)
      comment: "Date of the ACE measurement"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region associated with the control area"
    - name: "interconnection_name"
      expr: interconnection_name
      comment: "Name of the interconnection"
  measures:
    - name: "total_ace_raw_mw"
      expr: SUM(CAST(ace_raw_mw AS DOUBLE))
      comment: "Total raw ACE (Area Control Error) in megawatts across all records"
    - name: "average_ace_raw_mw"
      expr: AVG(CAST(ace_raw_mw AS DOUBLE))
      comment: "Average raw ACE per record, indicating typical control error magnitude"
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of ACE records captured"
    - name: "compliant_records"
      expr: COUNT(CASE WHEN cps1_compliant AND cps2_compliant THEN 1 END)
      comment: "Count of ACE records where both CPS1 and CPS2 compliance flags are true"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_agc_signal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AGC signal effectiveness and utilization"
  source: "`energy_utilities_ecm`.`grid`.`agc_signal`"
  dimensions:
    - name: "signal_timestamp"
      expr: signal_timestamp
      comment: "Timestamp of the AGC signal"
    - name: "agc_mode"
      expr: agc_mode
      comment: "AGC operating mode"
    - name: "ancillary_service_type"
      expr: ancillary_service_type
      comment: "Type of ancillary service"
  measures:
    - name: "total_regulation_reserve_deployed_mw"
      expr: SUM(CAST(regulation_reserve_deployed_mw AS DOUBLE))
      comment: "Total regulation reserve deployed via AGC signals"
    - name: "average_regulation_signal_mw"
      expr: AVG(CAST(regulation_signal_mw AS DOUBLE))
      comment: "Average regulation signal magnitude"
    - name: "total_records"
      expr: COUNT(1)
      comment: "Number of AGC signal records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_control_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic capacity and frequency metrics per control area"
  source: "`energy_utilities_ecm`.`grid`.`control_area`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Primary key of the control area"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region"
    - name: "balancing_authority_name"
      expr: balancing_authority_name
      comment: "Balancing authority responsible for the area"
    - name: "geographic_boundary_description"
      expr: geographic_boundary_description
      comment: "Geographic description of the control area"
  measures:
    - name: "total_installed_capacity_mw"
      expr: SUM(CAST(installed_generation_capacity_mw AS DOUBLE))
      comment: "Total installed generation capacity for the control area"
    - name: "peak_load_mw"
      expr: MAX(peak_load_mw)
      comment: "Maximum recorded peak load"
    - name: "average_nominal_frequency_hz"
      expr: AVG(CAST(nominal_frequency_hz AS DOUBLE))
      comment: "Average nominal frequency"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_load_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load forecasting performance metrics"
  source: "`energy_utilities_ecm`.`grid`.`load_forecast`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area for which load is forecasted"
    - name: "forecast_run_timestamp"
      expr: forecast_run_timestamp
      comment: "Timestamp of the forecast run"
    - name: "day_type"
      expr: day_type
      comment: "Classification of the day (e.g., weekday, weekend)"
    - name: "season"
      expr: season
      comment: "Season of the forecast"
  measures:
    - name: "total_forecasted_load_mw"
      expr: SUM(CAST(forecasted_load_mw AS DOUBLE))
      comment: "Sum of forecasted load across all forecasts"
    - name: "average_forecast_error_pct"
      expr: AVG(CAST(forecast_error_percentage AS DOUBLE))
      comment: "Average forecast error percentage"
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of load forecast records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_generation_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation dispatch volume, pricing, and compliance"
  source: "`energy_utilities_ecm`.`grid`.`generation_dispatch`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area of the dispatch"
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Generating unit identifier"
    - name: "dispatch_timestamp"
      expr: dispatch_timestamp
      comment: "Timestamp of the dispatch event"
  measures:
    - name: "dispatch_compliant_records"
      expr: COUNT(CASE WHEN dispatch_compliance_flag THEN 1 END)
      comment: "Count of dispatch records that met compliance criteria"
    - name: "total_dispatch_records"
      expr: COUNT(1)
      comment: "Total number of dispatch records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_scada_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SCADA measurement quality and voltage compliance"
  source: "`energy_utilities_ecm`.`grid`.`grid_scada_measurement`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area of the measurement"
    - name: "measurement_timestamp"
      expr: measurement_timestamp_utc
      comment: "Timestamp of the SCADA measurement"
    - name: "voltage_level_kv"
      expr: voltage_level_kv
      comment: "Voltage level bucket"
    - name: "measurement_category"
      expr: measurement_category
      comment: "Category of the measurement (e.g., power, voltage)"
  measures:
    - name: "average_active_power_mw"
      expr: AVG(CAST(active_power_mw AS DOUBLE))
      comment: "Average active power measured by SCADA"
    - name: "max_voltage_magnitude_kv"
      expr: MAX(voltage_magnitude_kv)
      comment: "Maximum voltage magnitude observed"
    - name: "voltage_violation_count"
      expr: COUNT(CASE WHEN limit_violation_type IS NOT NULL THEN 1 END)
      comment: "Count of SCADA records with a voltage limit violation"
    - name: "scada_record_count"
      expr: COUNT(1)
      comment: "Total SCADA measurement records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_frequency_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Frequency event impact and severity metrics"
  source: "`energy_utilities_ecm`.`grid`.`frequency_event`"
  dimensions:
    - name: "event_start_timestamp"
      expr: event_start_timestamp
      comment: "Start time of the frequency event"
    - name: "event_type"
      expr: event_type
      comment: "Type of frequency event"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region"
  measures:
    - name: "average_frequency_deviation_hz"
      expr: AVG(CAST(frequency_deviation_hz AS DOUBLE))
      comment: "Average frequency deviation during events"
    - name: "max_rocof_hz_per_second"
      expr: MAX(rocof_hz_per_second)
      comment: "Maximum Rate of Change of Frequency observed"
    - name: "total_load_shed_mw"
      expr: SUM(CAST(load_shed_mw AS DOUBLE))
      comment: "Total load shed across frequency events"
    - name: "frequency_event_count"
      expr: COUNT(1)
      comment: "Number of frequency events recorded"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_reliability_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability event outcomes for operational risk management"
  source: "`energy_utilities_ecm`.`grid`.`grid_reliability_event`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area impacted"
    - name: "event_start_timestamp"
      expr: event_start_timestamp
      comment: "Start timestamp of the reliability event"
    - name: "event_type"
      expr: event_type
      comment: "Category of reliability event"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region"
  measures:
    - name: "total_mw_impact"
      expr: SUM(CAST(mw_impact AS DOUBLE))
      comment: "Aggregate megawatt impact of reliability events"
    - name: "average_event_duration_minutes"
      expr: AVG(CAST(event_duration_minutes AS DOUBLE))
      comment: "Average duration of reliability events in minutes"
    - name: "reliability_event_count"
      expr: COUNT(1)
      comment: "Number of reliability events recorded"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_operating_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating limit capacity and safety margins"
  source: "`energy_utilities_ecm`.`grid`.`operating_limit`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area of the operating limit"
    - name: "element_type"
      expr: element_type
      comment: "Type of element the limit applies to"
    - name: "limit_type"
      expr: limit_type
      comment: "Classification of the limit (e.g., thermal, voltage)"
  measures:
    - name: "average_normal_rating_mva"
      expr: AVG(CAST(normal_rating_mva AS DOUBLE))
      comment: "Average normal rating of operating limits"
    - name: "max_emergency_rating_mva"
      expr: MAX(emergency_rating_mva)
      comment: "Maximum emergency rating across limits"
    - name: "operating_limit_record_count"
      expr: COUNT(1)
      comment: "Number of operating limit records"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`grid_protection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protection event severity and impact metrics"
  source: "`energy_utilities_ecm`.`grid`.`protection_event`"
  dimensions:
    - name: "control_area_id"
      expr: control_area_id
      comment: "Control area where protection event occurred"
    - name: "event_timestamp"
      expr: event_timestamp
      comment: "Timestamp of the protection event"
    - name: "fault_type"
      expr: fault_type
      comment: "Type of fault detected"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region"
  measures:
    - name: "total_fault_current_amps"
      expr: SUM(CAST(fault_current_magnitude_amps AS DOUBLE))
      comment: "Sum of fault current magnitudes for protection events"
    - name: "average_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration caused by protection events"
    - name: "protection_event_count"
      expr: COUNT(1)
      comment: "Number of protection events recorded"
$$;