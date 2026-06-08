-- Metric views for domain: reservoir | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_production_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key production forecast KPIs used for strategic planning and portfolio evaluation"
  source: "`oil_gas_ecm`.`reservoir`.`production_forecast`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Identifier of the reservoir linked to the forecast"
    - name: "forecast_scenario"
      expr: forecast_scenario
      comment: "Scenario name used for the forecast"
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (e.g., base, optimistic)"
  measures:
    - name: "total_forecast_oil_bopd"
      expr: SUM(CAST(initial_production_rate_oil_bopd AS DOUBLE))
      comment: "Sum of forecasted initial oil production rates (bopd) across all forecasts"
    - name: "avg_initial_oil_rate"
      expr: AVG(CAST(initial_production_rate_oil_bopd AS DOUBLE))
      comment: "Average initial oil production rate per forecast"
    - name: "total_eur_oil_mmbbl"
      expr: SUM(CAST(eur_oil_mmbbl AS DOUBLE))
      comment: "Total estimated ultimate recovery (EUR) for oil in million barrels"
    - name: "avg_forecast_duration_days"
      expr: AVG(DATEDIFF(forecast_period_end_date, forecast_period_start_date))
      comment: "Average forecast period length in days"
    - name: "forecast_count"
      expr: COUNT(1)
      comment: "Number of forecast records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_reserves_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic reserve valuation and risk metrics for executive decision‑making"
  source: "`oil_gas_ecm`.`reservoir`.`reserves_estimate`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Reservoir identifier"
    - name: "reserves_category"
      expr: reserves_category
      comment: "Category of reserves (e.g., proved, probable)"
  measures:
    - name: "total_proved_reserves_volume"
      expr: SUM(CAST(proved_reserves_volume AS DOUBLE))
      comment: "Sum of proved reserves volume across estimates"
    - name: "total_probable_reserves_volume"
      expr: SUM(CAST(probable_reserves_volume AS DOUBLE))
      comment: "Sum of probable reserves volume"
    - name: "total_eur"
      expr: SUM(CAST(eur AS DOUBLE))
      comment: "Total EUR (in the unit defined by eur_uom) across estimates"
    - name: "avg_npv"
      expr: AVG(CAST(npv AS DOUBLE))
      comment: "Average net present value of reserves estimates"
    - name: "estimate_count"
      expr: COUNT(1)
      comment: "Number of reserve estimate records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_decline_curve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and reliability metrics of decline curve analyses used for production forecasting"
  source: "`oil_gas_ecm`.`reservoir`.`decline_curve`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Reservoir linked to the decline curve"
    - name: "decline_type"
      expr: decline_type
      comment: "Type of decline model (e.g., exponential, hyperbolic)"
  measures:
    - name: "total_cumulative_oil_mstb"
      expr: SUM(CAST(cumulative_production_oil_mstb AS DOUBLE))
      comment: "Total cumulative oil production (MSTB) from all decline curves"
    - name: "avg_initial_decline_rate"
      expr: AVG(CAST(di_initial_decline_rate AS DOUBLE))
      comment: "Average initial decline rate across curves"
    - name: "avg_r_squared_fit_quality"
      expr: AVG(CAST(r_squared_fit_quality AS DOUBLE))
      comment: "Average R-squared fit quality of decline curve models"
    - name: "decline_curve_count"
      expr: COUNT(1)
      comment: "Number of decline curve records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_injection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency and reliability metrics for injection campaigns"
  source: "`oil_gas_ecm`.`reservoir`.`injection_event`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Reservoir where injection occurred"
    - name: "injection_date"
      expr: injection_date
      comment: "Date of the injection event"
  measures:
    - name: "total_injected_volume_bbl"
      expr: SUM(CAST(injected_volume_bbl AS DOUBLE))
      comment: "Total injected fluid volume in barrels"
    - name: "avg_injection_pressure_psi"
      expr: AVG(CAST(injection_pressure_psi AS DOUBLE))
      comment: "Average injection pressure (psi)"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Aggregate downtime hours associated with injection events"
    - name: "injection_event_count"
      expr: COUNT(1)
      comment: "Number of injection event records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_pvt_analysis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key fluid property metrics that drive reservoir simulation and economic evaluation"
  source: "`oil_gas_ecm`.`reservoir`.`pvt_analysis`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Reservoir associated with the PVT analysis"
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date the PVT analysis was performed"
  measures:
    - name: "avg_oil_api_gravity"
      expr: AVG(CAST(oil_api_gravity AS DOUBLE))
      comment: "Average oil API gravity from PVT analyses"
    - name: "avg_gas_gravity"
      expr: AVG(CAST(gas_gravity AS DOUBLE))
      comment: "Average gas specific gravity"
    - name: "pvt_analysis_count"
      expr: COUNT(1)
      comment: "Number of PVT analysis records"
$$;