-- Metric views for domain: refining | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_blend_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key blending performance metrics for refinery operations"
  source: "`oil_gas_ecm`.`refining`.`blend_event`"
  dimensions:
    - name: "blend_type"
      expr: blend_type
      comment: "Category of blend (e.g., gasoline, diesel)"
  measures:
    - name: "total_blend_volume_bbl"
      expr: SUM(CAST(total_blend_volume_bbl AS DOUBLE))
      comment: "Total volume blended per event (barrels)"
    - name: "total_blend_loss_bbl"
      expr: SUM(CAST(blend_loss_bbl AS DOUBLE))
      comment: "Total blend loss (barrels) across events"
    - name: "average_blend_temperature_f"
      expr: AVG(CAST(blend_temperature_f AS DOUBLE))
      comment: "Average blend temperature in Fahrenheit"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy and emissions KPIs for operational efficiency"
  source: "`oil_gas_ecm`.`refining`.`energy_consumption`"
  dimensions:
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Identifier of the process unit consuming energy"
    - name: "measurement_date"
      expr: measurement_date
      comment: "Date of the energy measurement"
  measures:
    - name: "total_energy_consumption_mmbtu"
      expr: SUM(CAST(total_energy_consumption_mmbtu AS DOUBLE))
      comment: "Total energy consumed (MMBtu) by the refinery"
    - name: "total_ghg_emissions_tonnes"
      expr: SUM(CAST(ghg_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total GHG emissions (CO2e tonnes) associated with energy use"
    - name: "average_energy_intensity_mmbtu_per_bbl"
      expr: AVG(CAST(energy_intensity_mmbtu_per_bbl AS DOUBLE))
      comment: "Average energy intensity per barrel of product"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_unit_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Run‑level production and yield metrics"
  source: "`oil_gas_ecm`.`refining`.`unit_run`"
  dimensions:
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit where the run occurred"
    - name: "run_status"
      expr: run_status
      comment: "Operational status of the run"
    - name: "run_day"
      expr: DATE_TRUNC('day', run_start_timestamp)
      comment: "Calendar day of run start"
  measures:
    - name: "total_feedstock_volume_bbl"
      expr: SUM(CAST(feedstock_volume_bbl AS DOUBLE))
      comment: "Total feedstock volume processed in the run (barrels)"
    - name: "total_product_volume_bbl"
      expr: SUM(CAST(total_product_volume_bbl AS DOUBLE))
      comment: "Total product volume produced in the run (barrels)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield reconciliation metrics for product output"
  source: "`oil_gas_ecm`.`refining`.`yield_record`"
  dimensions:
    - name: "process_unit_id"
      expr: process_unit_id
      comment: "Process unit associated with the yield record"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Identifier of the petroleum product"
  measures:
    - name: "total_actual_volume_bbl"
      expr: SUM(CAST(actual_volume_bbl AS DOUBLE))
      comment: "Sum of actual product volume recorded (barrels)"
    - name: "total_planned_volume_bbl"
      expr: SUM(CAST(planned_volume_bbl AS DOUBLE))
      comment: "Sum of planned product volume (barrels)"
    - name: "average_yield_percentage"
      expr: AVG(CAST(yield_percentage AS DOUBLE))
      comment: "Average yield percentage across records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_refinery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic scheduling KPIs for refinery planning"
  source: "`oil_gas_ecm`.`refining`.`refinery_schedule`"
  dimensions:
    - name: "refinery_id"
      expr: refinery_id
      comment: "Refinery identifier"
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of schedule (e.g., production, maintenance)"
    - name: "planning_month"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month of the planning period"
  measures:
    - name: "total_crude_volume_bbl"
      expr: SUM(CAST(total_crude_volume_bbl AS DOUBLE))
      comment: "Total crude volume scheduled (barrels)"
    - name: "planned_margin_usd"
      expr: SUM(CAST(planned_margin_usd AS DOUBLE))
      comment: "Planned margin for the schedule (USD)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`refining_product_quality_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality assurance metrics for product testing"
  source: "`oil_gas_ecm`.`refining`.`product_quality_test`"
  dimensions:
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product being tested"
    - name: "test_property_name"
      expr: test_property_name
      comment: "Name of the property measured"
    - name: "test_day"
      expr: DATE_TRUNC('day', test_datetime)
      comment: "Date of the test"
  measures:
    - name: "total_deviation_from_spec"
      expr: SUM(CAST(deviation_from_spec AS DOUBLE))
      comment: "Aggregate deviation from specification across tests"
    - name: "non_compliant_test_count"
      expr: SUM(CASE WHEN certification_status != 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of tests that did not meet compliance"
$$;