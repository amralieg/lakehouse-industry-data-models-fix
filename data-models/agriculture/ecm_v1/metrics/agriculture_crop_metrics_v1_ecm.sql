-- Metric views for domain: crop | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core yield performance metrics derived from the yield_record fact table"
  source: "`agriculture_ecm`.`crop`.`yield_record`"
  dimensions:
    - name: "harvest_date"
      expr: harvest_date
      comment: "Date of harvest"
    - name: "field_id"
      expr: field_id
      comment: "Identifier of the field where the yield was recorded"
    - name: "growing_season_id"
      expr: growing_season_id
      comment: "Growing season identifier"
  measures:
    - name: "total_production_bu"
      expr: SUM(CAST(total_production_bu AS DOUBLE))
      comment: "Total production in bushels for the selected period"
    - name: "avg_yield_per_acre"
      expr: AVG(CAST(yield_per_acre AS DOUBLE))
      comment: "Average yield per acre across records"
    - name: "total_harvested_area_acres"
      expr: SUM(CAST(harvested_area_acres AS DOUBLE))
      comment: "Total harvested area in acres"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of yield records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_harvest_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Harvest efficiency and volume metrics"
  source: "`agriculture_ecm`.`crop`.`harvest_event`"
  dimensions:
    - name: "harvest_date"
      expr: harvest_date
      comment: "Date of harvest"
    - name: "field_id"
      expr: field_id
      comment: "Field identifier"
    - name: "growing_season_id"
      expr: growing_season_id
      comment: "Growing season identifier"
    - name: "harvest_method"
      expr: harvest_method
      comment: "Method used for harvesting"
  measures:
    - name: "total_gross_weight_bu"
      expr: SUM(CAST(gross_weight_bu AS DOUBLE))
      comment: "Total gross weight harvested in bushels"
    - name: "avg_harvest_loss_pct"
      expr: AVG(CAST(harvest_loss_pct AS DOUBLE))
      comment: "Average harvest loss percentage"
    - name: "total_harvested_area_acres"
      expr: SUM(CAST(harvested_area_acres AS DOUBLE))
      comment: "Total area harvested in acres"
    - name: "harvest_event_count"
      expr: COUNT(1)
      comment: "Number of harvest events"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_fertilization_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fertilization input and efficiency metrics"
  source: "`agriculture_ecm`.`crop`.`fertilization_event`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date the fertilizer was applied"
    - name: "field_id"
      expr: field_id
      comment: "Field identifier"
    - name: "growing_season_id"
      expr: growing_season_id
      comment: "Growing season identifier"
    - name: "application_method"
      expr: application_method
      comment: "Method of fertilizer application"
  measures:
    - name: "total_nitrogen_applied_lbs_acre"
      expr: SUM(CAST(nitrogen_applied_lbs_acre AS DOUBLE))
      comment: "Total nitrogen applied per acre"
    - name: "avg_nitrogen_pct"
      expr: AVG(CAST(nitrogen_pct AS DOUBLE))
      comment: "Average nitrogen percentage in applied fertilizer"
    - name: "total_product_applied"
      expr: SUM(CAST(total_product_applied AS DOUBLE))
      comment: "Total amount of fertilizer product applied"
    - name: "fertilization_event_count"
      expr: COUNT(1)
      comment: "Number of fertilization events"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_irrigation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irrigation resource usage and cost metrics"
  source: "`agriculture_ecm`.`crop`.`irrigation_event`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date of irrigation application"
    - name: "field_id"
      expr: field_id
      comment: "Field identifier"
    - name: "growing_season_id"
      expr: growing_season_id
      comment: "Growing season identifier"
    - name: "irrigation_method"
      expr: irrigation_method
      comment: "Irrigation method used"
  measures:
    - name: "total_volume_applied_acre_inches"
      expr: SUM(CAST(volume_applied_acre_inches AS DOUBLE))
      comment: "Total irrigation volume applied (acre‑inches)"
    - name: "avg_water_cost_usd"
      expr: AVG(CAST(water_cost_usd AS DOUBLE))
      comment: "Average water cost per irrigation event in USD"
    - name: "total_energy_cost_usd"
      expr: SUM(CAST(energy_cost_usd AS DOUBLE))
      comment: "Total energy cost for irrigation"
    - name: "irrigation_event_count"
      expr: COUNT(1)
      comment: "Number of irrigation events"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_rotation_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Soil health and planning metrics from rotation plans"
  source: "`agriculture_ecm`.`crop`.`rotation_plan`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the rotation plan effectiveness"
    - name: "field_id"
      expr: field_id
      comment: "Field identifier"
    - name: "primary_agronomic_goal"
      expr: primary_agronomic_goal
      comment: "Primary agronomic goal of the rotation plan"
  measures:
    - name: "avg_soil_om_pct"
      expr: AVG(CAST(soil_om_pct AS DOUBLE))
      comment: "Average soil organic matter percentage across rotation plans"
    - name: "avg_soil_health_score"
      expr: AVG(CAST(soil_health_score AS DOUBLE))
      comment: "Average soil health score"
    - name: "total_planned_area_acres"
      expr: SUM(CAST(planned_area_acres AS DOUBLE))
      comment: "Total planned area for rotation plans in acres"
    - name: "rotation_plan_count"
      expr: COUNT(1)
      comment: "Number of rotation plans"
$$;