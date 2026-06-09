-- Metric views for domain: exploration | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_discovery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key discovery performance metrics."
  source: "`oil_gas_ecm`.`exploration`.`discovery`"
  dimensions:
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of discovery."
    - name: "hydrocarbon_type"
      expr: hydrocarbon_type
      comment: "Hydrocarbon type of discovery."
    - name: "discovery_status"
      expr: discovery_status
      comment: "Current status of discovery."
    - name: "discovery_year"
      expr: DATE_TRUNC('year', discovery_date)
      comment: "Year of discovery."
  measures:
    - name: "total_discoveries"
      expr: COUNT(1)
      comment: "Count of discovery records."
    - name: "total_eur_p50"
      expr: SUM(CAST(eur_p50_mmboe AS DOUBLE))
      comment: "Sum of estimated ultimate recovery (P50) in MMboe."
    - name: "avg_eur_p50"
      expr: AVG(CAST(eur_p50_mmboe AS DOUBLE))
      comment: "Average EUR P50 per discovery."
    - name: "total_initial_production_rate_bopd"
      expr: SUM(CAST(initial_production_rate_bopd AS DOUBLE))
      comment: "Total initial oil production rate (bopd)."
    - name: "avg_initial_production_rate_bopd"
      expr: AVG(CAST(initial_production_rate_bopd AS DOUBLE))
      comment: "Average initial oil production rate (bopd)."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_well`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exploration well cost and performance metrics."
  source: "`oil_gas_ecm`.`exploration`.`exploration_well`"
  dimensions:
    - name: "well_type"
      expr: well_type
      comment: "Type of exploration well."
    - name: "well_status"
      expr: well_status
      comment: "Current status of the well."
    - name: "country_code"
      expr: country_code
      comment: "Country code where well is located."
    - name: "spud_year"
      expr: DATE_TRUNC('year', spud_date)
      comment: "Year the well was spudded."
  measures:
    - name: "total_wells"
      expr: COUNT(1)
      comment: "Number of exploration wells."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual drilling costs."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual drilling cost."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated drilling costs."
    - name: "avg_estimated_cost"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated drilling cost."
    - name: "avg_water_depth"
      expr: AVG(CAST(water_depth AS DOUBLE))
      comment: "Average water depth (ft)."
    - name: "avg_gor"
      expr: AVG(CAST(gor AS DOUBLE))
      comment: "Average gas-oil ratio (scf/stb)."
    - name: "avg_api_gravity"
      expr: AVG(CAST(api_gravity AS DOUBLE))
      comment: "Average API gravity."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block-level resource and area metrics."
  source: "`oil_gas_ecm`.`exploration`.`block`"
  dimensions:
    - name: "block_name"
      expr: block_name
      comment: "Block name."
    - name: "country_code"
      expr: country_code
      comment: "Country code of block."
  measures:
    - name: "total_blocks"
      expr: COUNT(1)
      comment: "Count of blocks."
    - name: "total_area_sq_km"
      expr: SUM(CAST(area_sq_km AS DOUBLE))
      comment: "Total block area (sq km)."
    - name: "avg_area_sq_km"
      expr: AVG(CAST(area_sq_km AS DOUBLE))
      comment: "Average block area (sq km)."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exploration campaign financial and operational metrics."
  source: "`oil_gas_ecm`.`exploration`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign."
    - name: "country_code"
      expr: country_code
      comment: "Country where campaign operates."
    - name: "campaign_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year campaign was created."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Number of campaigns."
    - name: "total_budget_capex"
      expr: SUM(CAST(total_budget_capex_mm_usd AS DOUBLE))
      comment: "Total capital expenditure budget (MM USD)."
    - name: "avg_budget_capex"
      expr: AVG(CAST(total_budget_capex_mm_usd AS DOUBLE))
      comment: "Average capital expenditure budget per campaign (MM USD)."
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_mm_usd AS DOUBLE))
      comment: "Total actual spend (MM USD)."
    - name: "avg_actual_spend"
      expr: AVG(CAST(actual_spend_mm_usd AS DOUBLE))
      comment: "Average actual spend per campaign (MM USD)."
    - name: "total_actual_seismic_km"
      expr: SUM(CAST(actual_seismic_survey_km AS DOUBLE))
      comment: "Total actual seismic survey kilometers."
    - name: "avg_actual_seismic_km"
      expr: AVG(CAST(actual_seismic_survey_km AS DOUBLE))
      comment: "Average actual seismic survey km per campaign."
    - name: "total_planned_seismic_km"
      expr: SUM(CAST(planned_seismic_survey_km AS DOUBLE))
      comment: "Total planned seismic survey kilometers."
    - name: "avg_planned_seismic_km"
      expr: AVG(CAST(planned_seismic_survey_km AS DOUBLE))
      comment: "Average planned seismic survey km per campaign."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk assessment score."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`exploration_prospect_resource_estimate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect resource estimate financial and risk metrics."
  source: "`oil_gas_ecm`.`exploration`.`prospect_resource_estimate`"
  dimensions:
    - name: "prospect_id"
      expr: prospect_id
      comment: "Identifier of the prospect."
    - name: "estimate_status"
      expr: estimate_status
      comment: "Status of the estimate (e.g., approved, draft)."
    - name: "estimate_version"
      expr: estimate_version
      comment: "Version label of the estimate."
    - name: "estimate_year"
      expr: DATE_TRUNC('year', estimate_date)
      comment: "Year of the estimate."
  measures:
    - name: "total_estimates"
      expr: COUNT(1)
      comment: "Number of resource estimates."
    - name: "sum_eur_1p"
      expr: SUM(CAST(eur_1p_boe AS DOUBLE))
      comment: "Sum of 1P EUR (BOE)."
    - name: "avg_eur_1p"
      expr: AVG(CAST(eur_1p_boe AS DOUBLE))
      comment: "Average 1P EUR per estimate (BOE)."
    - name: "sum_eur_2p"
      expr: SUM(CAST(eur_2p_boe AS DOUBLE))
      comment: "Sum of 2P EUR (BOE)."
    - name: "avg_eur_2p"
      expr: AVG(CAST(eur_2p_boe AS DOUBLE))
      comment: "Average 2P EUR per estimate (BOE)."
    - name: "sum_eur_3p"
      expr: SUM(CAST(eur_3p_boe AS DOUBLE))
      comment: "Sum of 3P EUR (BOE)."
    - name: "avg_eur_3p"
      expr: AVG(CAST(eur_3p_boe AS DOUBLE))
      comment: "Average 3P EUR per estimate (BOE)."
    - name: "sum_risk_weighted_npv"
      expr: SUM(CAST(risk_weighted_npv_usd AS DOUBLE))
      comment: "Sum of risk-weighted NPV (USD)."
    - name: "avg_risk_weighted_npv"
      expr: AVG(CAST(risk_weighted_npv_usd AS DOUBLE))
      comment: "Average risk-weighted NPV per estimate (USD)."
$$;