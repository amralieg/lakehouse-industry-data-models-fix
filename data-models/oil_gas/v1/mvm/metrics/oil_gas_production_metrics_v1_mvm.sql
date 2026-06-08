-- Metric views for domain: production | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_daily_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core daily production KPIs for oil, gas, water and operational availability"
  source: "`oil_gas_ecm`.`production`.`daily_production`"
  dimensions:
    - name: "production_date"
      expr: production_date
      comment: "Date of production record"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product type (oil, gas, NGL, etc.)"
    - name: "production_status"
      expr: production_status
      comment: "Operational status of the production record"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Method used to allocate production volumes"
  measures:
    - name: "total_gross_oil_volume_bbl"
      expr: SUM(CAST(gross_oil_volume_bbl AS DOUBLE))
      comment: "Total gross oil produced (barrels) per day"
    - name: "total_gross_gas_volume_mcf"
      expr: SUM(CAST(gross_gas_volume_mcf AS DOUBLE))
      comment: "Total gross gas produced (Mcf) per day"
    - name: "total_net_oil_volume_bbl"
      expr: SUM(CAST(net_oil_volume_bbl AS DOUBLE))
      comment: "Total net oil produced (barrels) per day"
    - name: "total_net_gas_volume_mcf"
      expr: SUM(CAST(net_gas_volume_mcf AS DOUBLE))
      comment: "Total net gas produced (Mcf) per day"
    - name: "average_water_cut_percent"
      expr: AVG(CAST(water_cut_percent AS DOUBLE))
      comment: "Average water cut percentage across records"
    - name: "average_gor"
      expr: AVG(CAST(gor AS DOUBLE))
      comment: "Average gas‑oil ratio (GOR) across records"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours recorded per day"
    - name: "total_uptime_hours"
      expr: SUM(CAST(uptime_hours AS DOUBLE))
      comment: "Total uptime hours recorded per day"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of daily production records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_monthly_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated monthly production performance and efficiency metrics"
  source: "`oil_gas_ecm`.`production`.`monthly_production`"
  dimensions:
    - name: "production_month"
      expr: production_month
      comment: "Month of production (first day of month)"
    - name: "field_id"
      expr: field_id
      comment: "Identifier of the field"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product type"
    - name: "production_status"
      expr: production_status
      comment: "Overall production status for the month"
    - name: "allocation_method"
      expr: allocation_method
      comment: "Allocation method used"
  measures:
    - name: "total_boe"
      expr: SUM(CAST(boe_total AS DOUBLE))
      comment: "Total barrels of oil equivalent (BOE) produced in the month"
    - name: "total_oil_volume_bbl"
      expr: SUM(CAST(oil_volume_bbl AS DOUBLE))
      comment: "Total oil volume (barrels) produced in the month"
    - name: "total_gas_volume_mcf"
      expr: SUM(CAST(gas_volume_mcf AS DOUBLE))
      comment: "Total gas volume (Mcf) produced in the month"
    - name: "total_water_volume_bbl"
      expr: SUM(CAST(water_volume_bbl AS DOUBLE))
      comment: "Total water volume (barrels) produced in the month"
    - name: "average_gor"
      expr: AVG(CAST(gor AS DOUBLE))
      comment: "Average gas‑oil ratio for the month"
    - name: "average_net_revenue_interest_percent"
      expr: AVG(CAST(net_revenue_interest_percent AS DOUBLE))
      comment: "Average net revenue interest percentage across allocations"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total downtime hours recorded in the month"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of monthly production records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_artificial_lift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance and cost efficiency of artificial lift systems"
  source: "`oil_gas_ecm`.`production`.`artificial_lift`"
  dimensions:
    - name: "lift_type"
      expr: lift_type
      comment: "Type of artificial lift (e.g., gas, electric)"
    - name: "lift_status"
      expr: lift_status
      comment: "Current operational status of the lift"
    - name: "installation_date"
      expr: installation_date
      comment: "Date the lift was installed"
    - name: "equipment_id"
      expr: equipment_id
      comment: "Equipment identifier for the lift"
    - name: "production_well_id"
      expr: production_well_id
      comment: "Well that the lift serves"
  measures:
    - name: "average_actual_rate_bopd"
      expr: AVG(CAST(actual_rate_bopd AS DOUBLE))
      comment: "Average actual lift rate (BOPD)"
    - name: "average_design_rate_bopd"
      expr: AVG(CAST(design_rate_bopd AS DOUBLE))
      comment: "Average design lift rate (BOPD)"
    - name: "average_power_consumption_kwh"
      expr: AVG(CAST(power_consumption_kwh AS DOUBLE))
      comment: "Average power consumption (kWh) per lift"
    - name: "average_operating_cost_per_day_usd"
      expr: AVG(CAST(operating_cost_per_day_usd AS DOUBLE))
      comment: "Average operating cost per day (USD)"
    - name: "total_installation_cost_usd"
      expr: SUM(CAST(installation_cost_usd AS DOUBLE))
      comment: "Total installation cost (USD) for lifts"
    - name: "lift_utilization_percent"
      expr: AVG(actual_rate_bopd / NULLIF(design_rate_bopd, 0) * 100)
      comment: "Average utilization of lift capacity as a percentage"
    - name: "lift_count"
      expr: COUNT(1)
      comment: "Number of artificial lift records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_downtime_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Downtime events impacting production and cost"
  source: "`oil_gas_ecm`.`production`.`downtime_event`"
  dimensions:
    - name: "downtime_category"
      expr: downtime_category
      comment: "High‑level category of downtime"
    - name: "downtime_subcategory"
      expr: downtime_subcategory
      comment: "Specific sub‑category of downtime"
    - name: "field_id"
      expr: field_id
      comment: "Field where downtime occurred"
    - name: "production_well_id"
      expr: production_well_id
      comment: "Well affected by downtime"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the event"
    - name: "operator_name"
      expr: operator_name
      comment: "Operator responsible for the event"
  measures:
    - name: "total_downtime_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total downtime duration in hours"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated cost of downtime (USD)"
    - name: "average_estimated_cost_usd"
      expr: AVG(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Average estimated cost per downtime event (USD)"
    - name: "event_count"
      expr: COUNT(1)
      comment: "Number of downtime events"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_flare_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental and economic impact of gas flaring operations"
  source: "`oil_gas_ecm`.`production`.`flare_record`"
  dimensions:
    - name: "flare_date"
      expr: flare_date
      comment: "Date of the flare event"
    - name: "flare_type"
      expr: flare_type
      comment: "Classification of flare (e.g., routine, upset)"
    - name: "flare_status"
      expr: flare_status
      comment: "Operational status of the flare event"
    - name: "production_facility_id"
      expr: production_facility_id
      comment: "Facility where flaring occurred"
    - name: "petroleum_product_id"
      expr: petroleum_product_id
      comment: "Product type associated with the flare"
  measures:
    - name: "total_flare_volume_boe"
      expr: SUM(CAST(flare_volume_boe AS DOUBLE))
      comment: "Total flared volume expressed in BOE"
    - name: "total_flare_volume_mcf"
      expr: SUM(CAST(flare_volume_mcf AS DOUBLE))
      comment: "Total flared gas volume (Mcf)"
    - name: "total_ghg_emissions_tonnes"
      expr: SUM(CAST(ghg_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total GHG emissions from flaring (CO2e tonnes)"
    - name: "total_economic_loss_usd"
      expr: SUM(CAST(economic_loss_usd AS DOUBLE))
      comment: "Total economic loss attributed to flaring (USD)"
    - name: "flare_event_count"
      expr: COUNT(1)
      comment: "Number of flare events recorded"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_injection_well`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for injection wells and CO2/EOR operations"
  source: "`oil_gas_ecm`.`production`.`injection_well`"
  dimensions:
    - name: "injection_type"
      expr: injection_type
      comment: "Type of injection (e.g., CO2, water)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the injection well"
    - name: "spud_date"
      expr: spud_date
      comment: "Date the well was spudded"
    - name: "field_id"
      expr: field_id
      comment: "Field containing the injection well"
  measures:
    - name: "average_actual_injection_rate_mcfd"
      expr: AVG(CAST(actual_injection_rate_mcfd AS DOUBLE))
      comment: "Average actual injection rate (Mcf/d)"
    - name: "average_permitted_injection_rate_mcfd"
      expr: AVG(CAST(permitted_injection_rate_mcfd AS DOUBLE))
      comment: "Average permitted injection rate (Mcf/d)"
    - name: "total_cumulative_injection_volume_mcf"
      expr: SUM(CAST(cumulative_injection_volume_mcf AS DOUBLE))
      comment: "Total cumulative injection volume (Mcf) for the period"
    - name: "injection_efficiency_percent"
      expr: AVG(actual_injection_rate_mcfd / NULLIF(permitted_injection_rate_mcfd, 0) * 100)
      comment: "Average injection efficiency as a percentage of permitted rate"
    - name: "well_count"
      expr: COUNT(1)
      comment: "Number of injection well records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`production_well`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Well‑level production performance and efficiency metrics"
  source: "`oil_gas_ecm`.`production`.`production_well`"
  dimensions:
    - name: "well_status"
      expr: well_status
      comment: "Current status of the well"
    - name: "field_id"
      expr: field_id
      comment: "Field where the well is located"
    - name: "artificial_lift_type"
      expr: artificial_lift_type
      comment: "Type of artificial lift installed on the well"
    - name: "spud_date"
      expr: spud_date
      comment: "Date the well was spudded"
    - name: "well_name"
      expr: well_name
      comment: "Human‑readable name of the well"
  measures:
    - name: "average_current_production_bopd"
      expr: AVG(CAST(current_production_bopd AS DOUBLE))
      comment: "Average current oil production rate (BOPD)"
    - name: "average_gor"
      expr: AVG(CAST(gor_scf_bbl AS DOUBLE))
      comment: "Average gas‑oil ratio (SCF per barrel)"
    - name: "total_cumulative_oil_bbl"
      expr: SUM(CAST(cumulative_oil_bbls AS DOUBLE))
      comment: "Total cumulative oil produced (barrels)"
    - name: "total_cumulative_gas_mcf"
      expr: SUM(CAST(cumulative_gas_mcf AS DOUBLE))
      comment: "Total cumulative gas produced (Mcf)"
    - name: "average_water_cut_percent"
      expr: AVG(CAST(water_cut_percent AS DOUBLE))
      comment: "Average water cut percentage across wells"
    - name: "production_efficiency_percent"
      expr: AVG(current_production_bopd / NULLIF(initial_production_bopd, 0) * 100)
      comment: "Average production efficiency relative to initial rate"
    - name: "well_count"
      expr: COUNT(1)
      comment: "Number of production well records"
$$;