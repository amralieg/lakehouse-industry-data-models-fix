-- Metric views for domain: petrochemical | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`petrochemical_mass_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Mass balance KPIs per plant and period."
  source: "`oil_gas_ecm`.`petrochemical`.`mass_balance`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier."
    - name: "balance_month"
      expr: DATE_TRUNC('month', balance_period_start)
      comment: "Month of balance period start."
    - name: "conversion_unit_id"
      expr: conversion_unit_id
      comment: "Conversion unit identifier."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of mass balance records."
    - name: "total_feedstock_input_mt"
      expr: SUM(CAST(total_feedstock_input_mt AS DOUBLE))
      comment: "Total feedstock input in metric tons."
    - name: "total_product_output_mt"
      expr: SUM(CAST(total_product_output_mt AS DOUBLE))
      comment: "Total product output in metric tons."
    - name: "total_ghg_emissions_mt_co2e"
      expr: SUM(CAST(ghg_emissions_mt_co2e AS DOUBLE))
      comment: "Total GHG emissions CO2e in metric tons."
    - name: "avg_closure_pct"
      expr: AVG(CAST(closure_pct AS DOUBLE))
      comment: "Average closure percentage across records."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`petrochemical_production_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production order performance and efficiency."
  source: "`oil_gas_ecm`.`petrochemical`.`production_order`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier."
    - name: "product_catalog_id"
      expr: product_catalog_id
      comment: "Product catalog identifier."
    - name: "production_month"
      expr: DATE_TRUNC('month', actual_start_timestamp)
      comment: "Month of actual production start."
    - name: "priority"
      expr: priority
      comment: "Priority classification of the order."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of production order records."
    - name: "total_actual_output_qty"
      expr: SUM(CAST(actual_output_qty AS DOUBLE))
      comment: "Total actual output quantity."
    - name: "total_planned_output_qty"
      expr: SUM(CAST(planned_output_qty AS DOUBLE))
      comment: "Total planned output quantity."
    - name: "total_ghg_emissions_mt_co2e"
      expr: SUM(CAST(ghg_emissions_mt_co2e AS DOUBLE))
      comment: "Total GHG emissions CO2e for production orders."
    - name: "avg_yield_pct"
      expr: AVG(CAST(yield_pct AS DOUBLE))
      comment: "Average yield percentage across production orders."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`petrochemical_offtake_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Off‑take nomination fulfillment and variance."
  source: "`oil_gas_ecm`.`petrochemical`.`offtake_nomination`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier."
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Petroleum product identifier."
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the nomination."
    - name: "nomination_month"
      expr: DATE_TRUNC('month', nomination_date)
      comment: "Month of nomination date."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of off‑take nomination records."
    - name: "total_nominated_volume"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total nominated volume."
    - name: "total_confirmed_volume"
      expr: SUM(CAST(confirmed_volume AS DOUBLE))
      comment: "Total confirmed volume."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage between nominated and confirmed volumes."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`petrochemical_plant_opex`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating expense performance versus plan."
  source: "`oil_gas_ecm`.`petrochemical`.`plant_opex_record`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for the OPEX record."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code associated with the expense."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of plant OPEX records."
    - name: "total_actual_opex_usd"
      expr: SUM(CAST(actual_opex_amount_usd AS DOUBLE))
      comment: "Total actual OPEX in USD."
    - name: "total_planned_opex_usd"
      expr: SUM(CAST(planned_opex_amount_usd AS DOUBLE))
      comment: "Total planned OPEX in USD."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average OPEX variance percentage."
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`petrochemical_feedstock_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feedstock allocation efficiency and variance."
  source: "`oil_gas_ecm`.`petrochemical`.`feedstock_allocation`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier."
    - name: "feedstock_id"
      expr: feedstock_id
      comment: "Feedstock identifier."
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the allocation."
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation date."
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of feedstock allocation records."
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume AS DOUBLE))
      comment: "Total actual allocated volume."
    - name: "total_planned_volume"
      expr: SUM(CAST(planned_volume AS DOUBLE))
      comment: "Total planned allocated volume."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage between actual and planned volumes."
$$;