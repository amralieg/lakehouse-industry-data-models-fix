-- Metric views for domain: exploration | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_basin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level basin KPIs for strategic resource planning"
  source: "`oil_gas_ecm`.`exploration`.`basin`"
  dimensions:
    - name: "basin_name"
      expr: basin_name
      comment: "Name of the basin"
    - name: "basin_type"
      expr: basin_type
      comment: "Classification of basin (e.g., onshore, offshore)"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where basin is located"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the basin"
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates if basin is currently active for exploration"
  measures:
    - name: "total_basins"
      expr: COUNT(1)
      comment: "Count of basin records"
    - name: "total_area_sq_km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total surface area of basins in square kilometers"
    - name: "avg_eur_mmboe"
      expr: AVG(CAST(eur_mmboe AS DOUBLE))
      comment: "Average estimated ultimate recovery (MMboe) across basins"
    - name: "avg_geological_risk_score"
      expr: AVG(CAST(geological_risk_score AS DOUBLE))
      comment: "Average geological risk score for basins"
    - name: "total_ogip_bcf"
      expr: SUM(CAST(ogip_bcf AS DOUBLE))
      comment: "Total original gas in place (BCF) across basins"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_discovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discovery performance metrics for evaluating prospect potential"
  source: "`oil_gas_ecm`.`exploration`.`discovery`"
  dimensions:
    - name: "discovery_status"
      expr: discovery_status
      comment: "Current status of the discovery"
    - name: "commerciality_status"
      expr: commerciality_status
      comment: "Commercial viability status"
    - name: "country_code"
      expr: country_code
      comment: "Country where discovery is located"
    - name: "hydrocarbon_type"
      expr: hydrocarbon_type
      comment: "Type of hydrocarbon (oil, gas, condensate)"
    - name: "discovery_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the discovery record was created"
  measures:
    - name: "total_discoveries"
      expr: COUNT(1)
      comment: "Count of discovery records"
    - name: "sum_eur_p50_mmboe"
      expr: SUM(CAST(eur_p50_mmboe AS DOUBLE))
      comment: "Sum of median EUR (MMboe) for discoveries"
    - name: "avg_initial_production_rate_bopd"
      expr: AVG(CAST(initial_production_rate_bopd AS DOUBLE))
      comment: "Average initial oil production rate (BOPD)"
    - name: "avg_gor_scf_stb"
      expr: AVG(CAST(gor_scf_stb AS DOUBLE))
      comment: "Average gas‑oil ratio (SCF/STB) for discoveries"
    - name: "avg_recovery_factor_percent"
      expr: AVG(CAST(recovery_factor_percent AS DOUBLE))
      comment: "Average recovery factor percent across discoveries"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_well`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key well drilling cost and performance indicators"
  source: "`oil_gas_ecm`.`exploration`.`exploration_well`"
  dimensions:
    - name: "well_status"
      expr: well_status
      comment: "Operational status of the well"
    - name: "well_type"
      expr: well_type
      comment: "Classification of well (e.g., exploration, appraisal)"
    - name: "country_code"
      expr: country_code
      comment: "Country where the well is located"
    - name: "spud_year"
      expr: DATE_TRUNC('year', spud_date)
      comment: "Year the well was spudded"
  measures:
    - name: "total_wells"
      expr: COUNT(1)
      comment: "Count of exploration wells"
    - name: "sum_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred for wells"
    - name: "avg_actual_tvd_depth"
      expr: AVG(CAST(actual_tvd_depth AS DOUBLE))
      comment: "Average true vertical depth of wells"
    - name: "avg_gor"
      expr: AVG(CAST(gor AS DOUBLE))
      comment: "Average gas‑oil ratio for wells"
    - name: "avg_water_depth"
      expr: AVG(CAST(water_depth AS DOUBLE))
      comment: "Average water depth at well locations"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect evaluation metrics to prioritize drilling programs"
  source: "`oil_gas_ecm`.`exploration`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect"
    - name: "maturity_level"
      expr: maturity_level
      comment: "Maturity level of the prospect evaluation"
    - name: "prospect_name"
      expr: prospect_name
      comment: "Descriptive name of the prospect"
    - name: "prospect_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the prospect record was created"
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Count of prospect records"
    - name: "sum_estimated_drill_cost_usd"
      expr: SUM(CAST(estimated_drill_cost_usd AS DOUBLE))
      comment: "Total estimated drilling cost for prospects"
    - name: "avg_eur_p50_mmboe"
      expr: AVG(CAST(eur_p50_mmboe AS DOUBLE))
      comment: "Average median EUR (MMboe) across prospects"
    - name: "avg_geological_chance_of_success_pct"
      expr: AVG(CAST(geological_chance_of_success_pct AS DOUBLE))
      comment: "Average geological chance of success percent"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_play`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic play‑level resource and risk metrics"
  source: "`oil_gas_ecm`.`exploration`.`play`"
  dimensions:
    - name: "play_status"
      expr: play_status
      comment: "Current status of the play"
    - name: "play_type"
      expr: play_type
      comment: "Classification of play (e.g., conventional, unconventional)"
    - name: "hydrocarbon_type"
      expr: hydrocarbon_type
      comment: "Dominant hydrocarbon type in the play"
    - name: "play_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the play record was created"
  measures:
    - name: "total_plays"
      expr: COUNT(1)
      comment: "Count of play records"
    - name: "sum_risked_resource_estimate_mmboe"
      expr: SUM(CAST(risked_resource_estimate_mmboe AS DOUBLE))
      comment: "Total risked resource estimate (MMboe) for plays"
    - name: "avg_exploration_success_rate_percent"
      expr: AVG(CAST(exploration_success_rate_percent AS DOUBLE))
      comment: "Average exploration success rate percent across plays"
    - name: "avg_seismic_coverage_percent"
      expr: AVG(CAST(seismic_coverage_percent AS DOUBLE))
      comment: "Average seismic coverage percent for plays"
$$;