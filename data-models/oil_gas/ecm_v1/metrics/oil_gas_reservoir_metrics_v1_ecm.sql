-- Metric views for domain: reservoir | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_decline_curve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key production and reserve forecasts derived from decline curve analyses"
  source: "`oil_gas_ecm`.`reservoir`.`decline_curve`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Identifier of the reservoir"
    - name: "analysis_date"
      expr: analysis_date
      comment: "Date of the decline curve analysis"
    - name: "decline_type"
      expr: decline_type
      comment: "Classification of decline behavior (e.g., hyperbolic, exponential)"
    - name: "forecast_start_date"
      expr: forecast_start_date
      comment: "Start date of the production forecast period"
    - name: "forecast_end_date"
      expr: forecast_end_date
      comment: "End date of the production forecast period"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of decline curve records"
    - name: "total_cumulative_production_oil_mstb"
      expr: SUM(CAST(cumulative_production_oil_mstb AS DOUBLE))
      comment: "Total cumulative oil production (MSTB) across all decline curves"
    - name: "total_cumulative_production_gas_mmcf"
      expr: SUM(CAST(cumulative_production_gas_mmcf AS DOUBLE))
      comment: "Total cumulative gas production (MMCF) across all decline curves"
    - name: "total_eur_oil_mstb"
      expr: SUM(CAST(eur_oil_mstb AS DOUBLE))
      comment: "Total estimated ultimate recovery of oil (MSTB) from decline curve forecasts"
    - name: "total_eur_gas_mmcf"
      expr: SUM(CAST(eur_gas_mmcf AS DOUBLE))
      comment: "Total estimated ultimate recovery of gas (MMCF) from decline curve forecasts"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_material_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated material balance outcomes for reservoir performance monitoring"
  source: "`oil_gas_ecm`.`reservoir`.`material_balance`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Identifier of the reservoir"
    - name: "simulation_model_id"
      expr: simulation_model_id
      comment: "Associated simulation model identifier"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of material balance records"
    - name: "total_cumulative_oil_production_bbl"
      expr: SUM(CAST(cumulative_oil_production_bbl AS DOUBLE))
      comment: "Total cumulative oil produced (bbl) from material balance calculations"
    - name: "total_cumulative_gas_production_mcf"
      expr: SUM(CAST(cumulative_gas_production_mcf AS DOUBLE))
      comment: "Total cumulative gas produced (MCF) from material balance calculations"
    - name: "total_cumulative_water_injection_bbl"
      expr: SUM(CAST(cumulative_water_injection_bbl AS DOUBLE))
      comment: "Total cumulative water injected (bbl) from material balance calculations"
    - name: "average_recovery_factor_percent"
      expr: AVG(CAST(recovery_factor_percent AS DOUBLE))
      comment: "Average recovery factor percentage across material balances"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_injection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational injection performance metrics for EOR and pressure maintenance"
  source: "`oil_gas_ecm`.`reservoir`.`injection_event`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Identifier of the reservoir"
    - name: "injection_date"
      expr: injection_date
      comment: "Date of the injection event"
    - name: "injection_well_id"
      expr: injection_well_id
      comment: "Well used for injection"
    - name: "eor_scheme_id"
      expr: eor_scheme_id
      comment: "Associated EOR scheme identifier"
    - name: "injection_quality_flag"
      expr: injection_quality_flag
      comment: "Quality flag indicating data reliability"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of injection events"
    - name: "total_injected_volume_bbl"
      expr: SUM(CAST(injected_volume_bbl AS DOUBLE))
      comment: "Total injected fluid volume (bbl) across events"
    - name: "total_injected_volume_mcf"
      expr: SUM(CAST(injected_volume_mcf AS DOUBLE))
      comment: "Total injected gas volume (MCF) across events"
    - name: "total_injection_cost_usd"
      expr: SUM(CAST(injection_cost_usd AS DOUBLE))
      comment: "Total cost of injection operations (USD)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core reservoir inventory and recovery potential metrics"
  source: "`oil_gas_ecm`.`reservoir`.`reservoir`"
  dimensions:
    - name: "asset_facility_id"
      expr: asset_facility_id
      comment: "Asset facility associated with the reservoir"
    - name: "field_id"
      expr: field_id
      comment: "Field identifier containing the reservoir"
    - name: "reservoir_type"
      expr: reservoir_type
      comment: "Classification of reservoir type (e.g., conventional, unconventional)"
    - name: "eor_program_type"
      expr: eor_program_type
      comment: "EOR program category applied to the reservoir"
    - name: "reservoir_status"
      expr: reservoir_status
      comment: "Current operational status of the reservoir"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of reservoir records"
    - name: "total_ogip_bcf"
      expr: SUM(CAST(ogip_bcf AS DOUBLE))
      comment: "Total original gas in place (BCF) for the reservoir"
    - name: "total_ooip_mmbbl"
      expr: SUM(CAST(ooip_mmbbl AS DOUBLE))
      comment: "Total original oil in place (MMBBL) for the reservoir"
    - name: "average_recovery_factor_percent"
      expr: AVG(CAST(recovery_factor_percent AS DOUBLE))
      comment: "Average recovery factor percentage across reservoirs"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`reservoir_reserves_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated reserves estimates for portfolio valuation and planning"
  source: "`oil_gas_ecm`.`reservoir`.`reserves_estimate`"
  dimensions:
    - name: "reservoir_id"
      expr: reservoir_id
      comment: "Identifier of the reservoir"
    - name: "estimate_number"
      expr: estimate_number
      comment: "Unique estimate reference number"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Methodology used for the reserves estimate"
    - name: "reserves_category"
      expr: reserves_category
      comment: "Category of reserves (proved, probable, possible)"
    - name: "effective_date"
      expr: effective_date
      comment: "Date the estimate became effective"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of reserves estimate records"
    - name: "total_eur"
      expr: SUM(CAST(eur AS DOUBLE))
      comment: "Total estimated ultimate recovery (EUR) across estimates"
    - name: "total_ogip"
      expr: SUM(CAST(ogip AS DOUBLE))
      comment: "Total original gas in place (OGIP) across estimates"
    - name: "total_ooip"
      expr: SUM(CAST(ooip AS DOUBLE))
      comment: "Total original oil in place (OOIP) across estimates"
$$;