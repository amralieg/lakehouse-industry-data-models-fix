-- Metric views for domain: sustainability | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 16:21:15

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_carbon_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for carbon credit transactions and pricing"
  source: "`agriculture_ecm`.`sustainability`.`carbon_credit`"
  dimensions:
    - name: "issuance_year"
      expr: DATE_TRUNC('year', issuance_date)
      comment: "Year the carbon credit was issued"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of carbon credit (e.g., voluntary, compliance)"
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of the credit (e.g., active, retired)"
    - name: "project_country_code"
      expr: project_country_code
      comment: "ISO country code of the project generating the credit"
    - name: "registry_name"
      expr: registry_name
      comment: "Name of the registry where the credit is recorded"
  measures:
    - name: "total_quantity_tco2e"
      expr: SUM(CAST(quantity_tco2e AS DOUBLE))
      comment: "Total tonnes of CO2e covered by carbon credits"
    - name: "total_transaction_value_usd"
      expr: SUM(CAST(total_transaction_value_usd AS DOUBLE))
      comment: "Total monetary value of carbon credit transactions in USD"
    - name: "avg_price_per_tonne_usd"
      expr: AVG(CAST(price_per_tonne_usd AS DOUBLE))
      comment: "Average price per tonne of CO2e for carbon credits"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of carbon credit records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_carbon_footprint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated carbon footprint metrics for land units"
  source: "`agriculture_ecm`.`sustainability`.`carbon_footprint`"
  dimensions:
    - name: "reporting_year"
      expr: DATE_TRUNC('year', reporting_period_start_date)
      comment: "Reporting year of the carbon footprint"
    - name: "company_code_id"
      expr: company_code_id
      comment: "Company code identifier"
  measures:
    - name: "total_emissions_co2e_mt"
      expr: SUM(CAST(total_emissions_co2e_mt AS DOUBLE))
      comment: "Total CO2e emissions captured in the carbon footprint"
    - name: "avg_emission_intensity_per_ha"
      expr: AVG(CAST(emission_intensity_per_ha AS DOUBLE))
      comment: "Average emission intensity per hectare"
    - name: "total_land_area_ha"
      expr: SUM(CAST(total_land_area_ha AS DOUBLE))
      comment: "Total land area covered by the footprint in hectares"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of carbon footprint records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_biodiversity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key biodiversity assessment KPIs to monitor ecosystem health"
  source: "`agriculture_ecm`.`sustainability`.`biodiversity_assessment`"
  dimensions:
    - name: "assessment_year"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Year of the biodiversity assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of assessment (e.g., baseline, follow‑up)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment"
    - name: "habitat_type"
      expr: habitat_type
      comment: "Primary habitat type evaluated"
    - name: "invasive_species_present"
      expr: invasive_species_present
      comment: "Indicator if invasive species were observed"
  measures:
    - name: "avg_biodiversity_net_gain_score"
      expr: AVG(CAST(biodiversity_net_gain_score AS DOUBLE))
      comment: "Average net gain score for biodiversity assessments"
    - name: "avg_habitat_quality_score"
      expr: AVG(CAST(habitat_quality_score AS DOUBLE))
      comment: "Average habitat quality score"
    - name: "avg_soil_biodiversity_score"
      expr: AVG(CAST(soil_biodiversity_score AS DOUBLE))
      comment: "Average soil biodiversity score"
    - name: "total_assessed_area_ha"
      expr: SUM(CAST(assessed_area_ha AS DOUBLE))
      comment: "Total area assessed in hectares"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of biodiversity assessment records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_deforestation_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deforestation risk metrics to guide conservation investment"
  source: "`agriculture_ecm`.`sustainability`.`deforestation_risk`"
  dimensions:
    - name: "assessment_year"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Year of the deforestation risk assessment"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the assessed parcel"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification category"
    - name: "forest_cover_baseline_year"
      expr: forest_cover_baseline_year
      comment: "Baseline year for forest cover reference"
  measures:
    - name: "avg_current_forest_cover_pct"
      expr: AVG(CAST(current_forest_cover_pct AS DOUBLE))
      comment: "Average current forest cover percentage"
    - name: "avg_forest_cover_change_pct"
      expr: AVG(current_forest_cover_pct - forest_cover_baseline_pct)
      comment: "Average change in forest cover percentage since baseline"
    - name: "total_assessed_area_ha"
      expr: SUM(CAST(assessed_area_ha AS DOUBLE))
      comment: "Total area assessed for deforestation risk in hectares"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of deforestation risk assessment records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption and associated emissions for sustainability tracking"
  source: "`agriculture_ecm`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "consumption_year"
      expr: DATE_TRUNC('year', consumption_start_date)
      comment: "Year when energy consumption started"
    - name: "energy_source_type"
      expr: energy_source_type
      comment: "Type of energy source (e.g., solar, diesel)"
    - name: "facility_id"
      expr: facility_id
      comment: "Identifier of the facility consuming energy"
    - name: "renewable_flag"
      expr: renewable_flag
      comment: "Flag indicating if the energy source is renewable"
  measures:
    - name: "total_consumption_gj"
      expr: SUM(CAST(consumption_gj AS DOUBLE))
      comment: "Total energy consumption in gigajoules"
    - name: "total_ghg_emissions_co2e_mt"
      expr: SUM(CAST(ghg_emissions_co2e_mt AS DOUBLE))
      comment: "Total GHG emissions associated with energy consumption in CO2e metric tons"
    - name: "avg_renewable_pct"
      expr: AVG(CAST(renewable_pct AS DOUBLE))
      comment: "Average percentage of energy that is renewable"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of energy consumption records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_water_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water usage KPIs for monitoring efficiency and stewardship"
  source: "`agriculture_ecm`.`sustainability`.`water_usage`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source (e.g., groundwater, surface)"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility identifier where water is used"
    - name: "water_stewardship_plan_id"
      expr: water_stewardship_plan_id
      comment: "Associated water stewardship plan"
  measures:
    - name: "total_withdrawal_volume_ml"
      expr: SUM(CAST(withdrawal_volume_ml AS DOUBLE))
      comment: "Total water withdrawn in megaliters"
    - name: "avg_consumptive_use_ml"
      expr: AVG(CAST(consumptive_use_volume_ml AS DOUBLE))
      comment: "Average consumptive water use per record in megaliters"
    - name: "total_return_flow_volume_ml"
      expr: SUM(CAST(return_flow_volume_ml AS DOUBLE))
      comment: "Total water returned to the system in megaliters"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of water usage records"
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`sustainability_waste_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management metrics to assess environmental impact and diversion performance"
  source: "`agriculture_ecm`.`sustainability`.`waste_event`"
  dimensions:
    - name: "event_year"
      expr: DATE_TRUNC('year', event_date)
      comment: "Year of the waste event"
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (e.g., hazardous, organic)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the waste event occurred"
  measures:
    - name: "total_co2e_emissions_mt"
      expr: SUM(CAST(co2e_emissions_mt AS DOUBLE))
      comment: "Total CO2e emissions from waste events in metric tons"
    - name: "total_quantity_disposed"
      expr: SUM(CAST(quantity_disposed AS DOUBLE))
      comment: "Total quantity of waste disposed"
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_pct AS DOUBLE))
      comment: "Average diversion rate percentage"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of waste event records"
$$;