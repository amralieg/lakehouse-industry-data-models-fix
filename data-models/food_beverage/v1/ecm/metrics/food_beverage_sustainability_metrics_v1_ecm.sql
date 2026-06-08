-- Metric views for domain: sustainability | Business: Food Beverage | Version: 1 | Generated on: 2026-05-05 21:55:54

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sustainability_carbon_footprint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon footprint KPIs per asset, plant, SKU and reporting period"
  source: "`food_beverage_ecm`.`sustainability`.`carbon_footprint`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Fiscal year of the carbon footprint report"
    - name: "calculation_date"
      expr: calculation_date
      comment: "Date the carbon footprint was calculated"
    - name: "plant_id"
      expr: plant_id
      comment: "Identifier of the manufacturing plant"
    - name: "asset_id"
      expr: asset_id
      comment: "Identifier of the asset associated with the footprint"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for product-level footprint"
    - name: "scope"
      expr: scope
      comment: "Emission scope (e.g., Scope 1, 2, 3)"
  measures:
    - name: "total_carbon_emission"
      expr: SUM(CAST(emission_amount AS DOUBLE))
      comment: "Total carbon emissions reported in the footprint (kg CO2e)"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption and associated emissions per plant and production line"
  source: "`food_beverage_ecm`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "reporting_date"
      expr: reporting_date
      comment: "Date of the energy consumption record"
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant identifier"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier linked to energy consumption"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier"
    - name: "emission_scope"
      expr: emission_scope
      comment: "Scope of emissions (e.g., Scope 1, 2)"
  measures:
    - name: "total_electricity_mwh"
      expr: SUM(CAST(electricity_mwh AS DOUBLE))
      comment: "Total electricity consumption in megawatt-hours"
    - name: "total_fuel_oil_mwh"
      expr: SUM(CAST(fuel_oil_mwh AS DOUBLE))
      comment: "Total fuel oil consumption in megawatt-hours"
    - name: "total_renewable_energy_mwh"
      expr: SUM(CAST(renewable_energy_mwh AS DOUBLE))
      comment: "Total renewable energy consumption in megawatt-hours"
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions associated with energy use (kg CO2e)"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sustainability_waste_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste generation KPIs per plant and asset"
  source: "`food_beverage_ecm`.`sustainability`.`waste_generation`"
  dimensions:
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period identifier"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier"
    - name: "waste_type"
      expr: waste_type
      comment: "Category of waste (e.g., hazardous, non‑hazardous)"
    - name: "waste_generation_status"
      expr: waste_generation_status
      comment: "Current status of the waste record"
  measures:
    - name: "total_waste_kg"
      expr: SUM(CAST(waste_amount_kg AS DOUBLE))
      comment: "Total waste generated in kilograms"
    - name: "average_waste_diversion_rate_percent"
      expr: AVG(CAST(waste_diversion_rate_percent AS DOUBLE))
      comment: "Average percentage of waste diverted from landfill"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sustainability_water_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water usage and recycling metrics per plant, asset and SKU"
  source: "`food_beverage_ecm`.`sustainability`.`water_usage`"
  dimensions:
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period date"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant identifier"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Production line identifier"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier"
  measures:
    - name: "total_water_consumption"
      expr: SUM(CAST(water_consumption AS DOUBLE))
      comment: "Total water consumption in cubic meters"
    - name: "total_water_recycled"
      expr: SUM(CAST(water_recycled AS DOUBLE))
      comment: "Total water recycled in cubic meters"
    - name: "average_water_intensity_per_unit"
      expr: AVG(CAST(water_intensity_per_unit AS DOUBLE))
      comment: "Average water intensity per production unit"
$$;

CREATE OR REPLACE VIEW `food_beverage_ecm`.`_metrics`.`sustainability_initiative_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Performance of sustainability initiatives"
  source: "`food_beverage_ecm`.`sustainability`.`initiative`"
  dimensions:
    - name: "initiative_name"
      expr: initiative_name
      comment: "Name of the sustainability initiative"
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the initiative"
    - name: "esg_pillar"
      expr: esg_pillar
      comment: "ESG pillar the initiative belongs to"
    - name: "start_date"
      expr: start_date
      comment: "Start date of the initiative"
    - name: "reporting_period_start"
      expr: reporting_period_start
      comment: "Start of the reporting period for the initiative"
    - name: "reporting_period_end"
      expr: reporting_period_end
      comment: "End of the reporting period for the initiative"
  measures:
    - name: "total_actual_co2e_avoided"
      expr: SUM(CAST(actual_co2e_tonnes_avoided AS DOUBLE))
      comment: "Total actual CO2e avoided by initiatives (tonnes)"
    - name: "total_projected_co2e_avoided"
      expr: SUM(CAST(projected_co2e_tonnes_avoided AS DOUBLE))
      comment: "Total projected CO2e avoidance (tonnes)"
    - name: "total_capital_investment_usd"
      expr: SUM(CAST(capital_investment_required_usd AS DOUBLE))
      comment: "Total capital investment required for initiatives (USD)"
$$;