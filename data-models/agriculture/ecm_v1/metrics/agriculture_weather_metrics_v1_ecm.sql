-- Metric views for domain: weather | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`weather_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alert performance metrics for weather-related crop risk management."
  source: "`agriculture_ecm`.`weather`.`alert`"
  dimensions:
    - name: "alert_type"
      expr: alert_type
      comment: "Type of weather alert (e.g., frost, heat, storm)."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert."
    - name: "alert_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the alert was created."
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of weather alerts."
    - name: "critical_alerts"
      expr: SUM(CASE WHEN alert_status = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of alerts marked as Critical."
    - name: "avg_estimated_crop_loss_pct"
      expr: AVG(CAST(estimated_crop_loss_pct AS DOUBLE))
      comment: "Average estimated crop loss percentage across alerts."
    - name: "insurance_relevant_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_claim_relevant THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of alerts relevant to insurance claims."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`weather_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast accuracy and risk indicators for operational planning."
  source: "`agriculture_ecm`.`weather`.`forecast`"
  dimensions:
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., short-term, seasonal)."
    - name: "model_version"
      expr: model_version
      comment: "Model version used for the forecast."
    - name: "forecast_date"
      expr: DATE_TRUNC('day', issued_timestamp)
      comment: "Date the forecast was issued."
  measures:
    - name: "total_forecasts"
      expr: COUNT(1)
      comment: "Total number of forecast records."
    - name: "avg_precip_probability_pct"
      expr: AVG(CAST(precip_probability_pct AS DOUBLE))
      comment: "Average probability of precipitation."
    - name: "avg_max_temp_c"
      expr: AVG(CAST(temp_max_c AS DOUBLE))
      comment: "Average forecasted maximum temperature (°C)."
    - name: "freeze_risk_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN freeze_risk THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of forecasts indicating freeze risk."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`weather_drought_index`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drought monitoring metrics to assess water stress and yield impact."
  source: "`agriculture_ecm`.`weather`.`drought_index`"
  dimensions:
    - name: "drought_category"
      expr: drought_category
      comment: "Categorization of drought severity."
    - name: "index_type"
      expr: index_type
      comment: "Type of drought index (e.g., PDSI, SPI)."
    - name: "index_date"
      expr: DATE_TRUNC('day', index_date)
      comment: "Date of the drought index measurement."
  measures:
    - name: "total_drought_records"
      expr: COUNT(1)
      comment: "Total number of drought index records."
    - name: "avg_cmi_value"
      expr: AVG(CAST(cmi_value AS DOUBLE))
      comment: "Average Crop Moisture Index value."
    - name: "avg_estimated_yield_loss_pct"
      expr: AVG(CAST(estimated_yield_loss_pct AS DOUBLE))
      comment: "Average estimated yield loss percentage due to drought."
    - name: "severe_drought_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN drought_category = 'Severe' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of records classified as Severe drought."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`weather_growing_degree_day`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Growing degree day metrics for crop development tracking."
  source: "`agriculture_ecm`.`weather`.`growing_degree_day`"
  dimensions:
    - name: "crop_type"
      expr: crop_type
      comment: "Crop type associated with the GDD record."
    - name: "growth_stage"
      expr: current_growth_stage
      comment: "Current growth stage of the crop."
    - name: "record_date"
      expr: DATE_TRUNC('day', record_date)
      comment: "Date of the GDD record."
  measures:
    - name: "total_gdd_records"
      expr: COUNT(1)
      comment: "Total number of GDD records."
    - name: "avg_cumulative_gdd"
      expr: AVG(CAST(cumulative_gdd AS DOUBLE))
      comment: "Average cumulative growing degree days."
    - name: "avg_gdd_deviation"
      expr: AVG(CAST(gdd_deviation AS DOUBLE))
      comment: "Average deviation of GDD from normal."
    - name: "frost_event_flag_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN frost_event_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of records where a frost event was flagged."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`weather_irrigation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irrigation scheduling effectiveness and water usage metrics."
  source: "`agriculture_ecm`.`weather`.`irrigation_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the irrigation schedule."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of irrigation schedule (e.g., automated, manual)."
    - name: "scheduled_date"
      expr: DATE_TRUNC('day', scheduled_date)
      comment: "Date the irrigation was scheduled."
  measures:
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of irrigation schedules."
    - name: "avg_estimated_water_volume_m3"
      expr: AVG(CAST(estimated_water_volume_m3 AS DOUBLE))
      comment: "Average estimated water volume per schedule (m³)."
    - name: "avg_et_deficit_mm"
      expr: AVG(CAST(et_deficit_mm AS DOUBLE))
      comment: "Average evapotranspiration deficit (mm)."
    - name: "frost_protection_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN frost_protection_flag THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of schedules that include frost protection."
$$;