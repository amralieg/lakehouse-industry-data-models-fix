-- Metric views for domain: sustainability | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core carbon emission KPI view – provides aggregate emissions, energy and water use, and offset application for executive sustainability tracking"
  source: "`consumer_goods_ecm`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Fiscal reporting year"
    - name: "scope"
      expr: scope
      comment: "Scope of emissions (Scope 1, 2, or 3)"
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Identifier of the manufacturing facility"
    - name: "production_line_id"
      expr: production_line_id
      comment: "Identifier of the production line"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for the product"
  measures:
    - name: "total_co2e_emissions"
      expr: SUM(CAST(co2e_quantity_tonnes AS DOUBLE))
      comment: "Total CO2e emissions in tonnes across all records"
    - name: "total_energy_consumption"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption in MWh associated with the emissions"
    - name: "total_water_consumption"
      expr: SUM(CAST(water_consumption_m3 AS DOUBLE))
      comment: "Total water consumption in cubic meters linked to the emission events"
    - name: "total_offset_quantity"
      expr: SUM(CAST(offset_quantity_tonnes AS DOUBLE))
      comment: "Total carbon offset quantity applied (tonnes)"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon offset KPI view – tracks volume and cost of purchased and retired offsets for strategic investment decisions"
  source: "`consumer_goods_ecm`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "reporting_year"
      expr: reporting_year
      comment: "Fiscal reporting year"
    - name: "country_code"
      expr: country_code
      comment: "Country where the offset project is located"
    - name: "project_type"
      expr: project_type
      comment: "Type of offset project (e.g., renewable energy, reforestation)"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify the offset"
  measures:
    - name: "total_offset_quantity_purchased"
      expr: SUM(CAST(credit_quantity_purchased AS DOUBLE))
      comment: "Total carbon credits purchased (tonnes)"
    - name: "total_offset_quantity_retired"
      expr: SUM(CAST(credit_quantity_retired AS DOUBLE))
      comment: "Total carbon credits retired (tonnes)"
    - name: "total_offset_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total monetary cost of carbon offsets"
    - name: "average_cost_per_tonne"
      expr: AVG(CAST(cost_per_tonne AS DOUBLE))
      comment: "Average cost per tonne of carbon offset"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sustainability_biodiversity_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biodiversity impact view – aggregates key biodiversity metrics to inform conservation investment and risk management"
  source: "`consumer_goods_ecm`.`sustainability`.`biodiversity_impact`"
  dimensions:
    - name: "region_id"
      expr: region_id
      comment: "Geographic region identifier"
    - name: "land_use_type"
      expr: land_use_type
      comment: "Category of land use (e.g., agricultural, industrial)"
    - name: "tnfd_risk_classification"
      expr: tnfd_risk_classification
      comment: "TNFD risk classification for the site"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the biodiversity impact was approved"
    - name: "biodiversity_impact_category"
      expr: biodiversity_impact_category
      comment: "Impact category (e.g., habitat loss, species decline)"
  measures:
    - name: "average_net_biodiversity_impact_score"
      expr: AVG(CAST(net_biodiversity_impact_score AS DOUBLE))
      comment: "Average net biodiversity impact score across assessments"
    - name: "total_land_use_area"
      expr: SUM(CAST(land_use_area_ha AS DOUBLE))
      comment: "Total land area (ha) used in the assessed activities"
    - name: "average_proximity_to_protected_area"
      expr: AVG(CAST(proximity_to_protected_area_km AS DOUBLE))
      comment: "Average distance (km) of sites to protected areas"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sustainability_circular_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular initiative view – measures material diversion, waste reduction, and energy savings to evaluate circular economy performance"
  source: "`consumer_goods_ecm`.`sustainability`.`circular_initiative`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of circular program (e.g., recycling, reuse)"
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage targeted by the initiative"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the initiative was launched"
    - name: "target_material"
      expr: target_material
      comment: "Primary material targeted for circularity"
  measures:
    - name: "total_material_diverted"
      expr: SUM(CAST(material_diverted_tonnes AS DOUBLE))
      comment: "Total material diverted from landfill (tonnes)"
    - name: "total_material_recovered"
      expr: SUM(CAST(material_recovered_tonnes AS DOUBLE))
      comment: "Total material recovered for reuse (tonnes)"
    - name: "total_waste_reduction"
      expr: SUM(CAST(waste_reduction_tonnes AS DOUBLE))
      comment: "Total waste reduction achieved (tonnes)"
    - name: "average_consumer_participation_rate"
      expr: AVG(CAST(consumer_participation_rate_pct AS DOUBLE))
      comment: "Average consumer participation rate (%)"
    - name: "total_energy_savings"
      expr: SUM(CAST(energy_savings_mwh AS DOUBLE))
      comment: "Total energy savings generated (MWh)"
    - name: "total_investment_amount_usd"
      expr: SUM(CAST(investment_amount_usd AS DOUBLE))
      comment: "Total investment in circular initiatives (USD)"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sustainability_waste_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste generation view – aggregates waste quantities and diversion rates to support waste reduction strategies"
  source: "`consumer_goods_ecm`.`sustainability`.`waste_generation`"
  dimensions:
    - name: "waste_category_code"
      expr: waste_category_code
      comment: "Code representing waste category"
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Facility where waste was generated"
    - name: "waste_year"
      expr: YEAR(waste_date)
      comment: "Year of waste generation"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of waste"
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste generated (tonnes)"
    - name: "average_diversion_rate_percent"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average diversion rate (%) across waste streams"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water consumption view – tracks water use, discharge, and recycling to manage water stewardship"
  source: "`consumer_goods_ecm`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "manufacturing_facility_id"
      expr: manufacturing_facility_id
      comment: "Facility identifier"
    - name: "water_year"
      expr: YEAR(measurement_period_start)
      comment: "Year of the measurement period"
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source (e.g., municipal, groundwater)"
  measures:
    - name: "total_water_consumption"
      expr: SUM(CAST(consumption_volume_m3 AS DOUBLE))
      comment: "Total water consumption (cubic meters)"
    - name: "total_discharge_volume"
      expr: SUM(CAST(discharge_volume_m3 AS DOUBLE))
      comment: "Total water discharged (cubic meters)"
    - name: "average_water_recycling_rate"
      expr: AVG(CAST(water_recycling_rate_pct AS DOUBLE))
      comment: "Average water recycling rate (%)"
$$;