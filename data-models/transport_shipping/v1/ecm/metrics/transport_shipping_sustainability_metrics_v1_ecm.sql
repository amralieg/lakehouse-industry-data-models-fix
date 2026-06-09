-- Metric views for domain: sustainability | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_ghg_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core GHG inventory metrics tracking organizational carbon emissions across all scopes, enabling year-over-year reduction tracking and regulatory compliance monitoring."
  source: "`transport_shipping_ecm`.`sustainability`.`ghg_inventory`"
  dimensions:
    - name: "inventory_year"
      expr: inventory_year
      comment: "The reporting year for the GHG inventory"
    - name: "inventory_status"
      expr: inventory_status
      comment: "Current status of the inventory (draft, verified, published)"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the inventory"
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "Framework used for reporting (GHG Protocol, ISO 14064, etc.)"
    - name: "organizational_boundary_method"
      expr: organizational_boundary_method
      comment: "Method used to define organizational boundary (operational control, equity share, etc.)"
    - name: "base_year"
      expr: base_year
      comment: "Base year used for emissions reduction tracking"
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Start of the reporting period (monthly granularity)"
  measures:
    - name: "total_gross_emissions_tco2e"
      expr: SUM(CAST(total_gross_emissions_tco2e AS DOUBLE))
      comment: "Total gross GHG emissions in tonnes CO2e across all scopes before offsets"
    - name: "total_net_emissions_tco2e"
      expr: SUM(CAST(total_net_emissions_tco2e AS DOUBLE))
      comment: "Total net GHG emissions in tonnes CO2e after offsets and removals"
    - name: "scope_1_total_tco2e"
      expr: SUM(CAST(scope_1_total_tco2e AS DOUBLE))
      comment: "Total Scope 1 (direct) emissions in tonnes CO2e"
    - name: "scope_2_market_based_tco2e"
      expr: SUM(CAST(scope_2_market_based_tco2e AS DOUBLE))
      comment: "Total Scope 2 market-based emissions in tonnes CO2e"
    - name: "scope_3_total_tco2e"
      expr: SUM(CAST(scope_3_total_tco2e AS DOUBLE))
      comment: "Total Scope 3 (value chain) emissions in tonnes CO2e"
    - name: "carbon_offsets_purchased_tco2e"
      expr: SUM(CAST(carbon_offsets_purchased_tco2e AS DOUBLE))
      comment: "Total carbon offsets purchased in tonnes CO2e"
    - name: "avg_intensity_per_tonne_km"
      expr: AVG(CAST(intensity_ratio_tco2e_per_tonne_km AS DOUBLE))
      comment: "Average emissions intensity per tonne-km — key logistics efficiency indicator"
    - name: "avg_intensity_per_revenue_million"
      expr: AVG(CAST(intensity_ratio_tco2e_per_revenue_million AS DOUBLE))
      comment: "Average emissions intensity per million revenue — decoupling indicator"
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Number of GHG inventory records"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_shipment_carbon_footprint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment-level carbon footprint metrics enabling transport mode optimization, carrier benchmarking, and customer-facing emissions reporting."
  source: "`transport_shipping_ecm`.`sustainability`.`shipment_carbon_footprint`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, ocean, road, rail)"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country code of shipment origin"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "scope_classification"
      expr: scope_classification
      comment: "GHG Protocol scope classification (Scope 1, 2, or 3)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel used for the shipment leg"
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle used for transport"
    - name: "service_level"
      expr: service_level
      comment: "Service level of the shipment (express, standard, economy)"
    - name: "data_quality_tier"
      expr: data_quality_tier
      comment: "Data quality tier indicating reliability of the calculation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the footprint calculation"
    - name: "calculation_month"
      expr: DATE_TRUNC('month', calculation_timestamp)
      comment: "Month when the carbon footprint was calculated"
  measures:
    - name: "total_gross_co2e_kg"
      expr: SUM(CAST(gross_co2e_kg AS DOUBLE))
      comment: "Total gross CO2e emissions in kg across all shipments"
    - name: "total_net_co2e_kg"
      expr: SUM(CAST(net_co2e_kg AS DOUBLE))
      comment: "Total net CO2e emissions in kg after offsets"
    - name: "total_carbon_offset_kg"
      expr: SUM(CAST(carbon_offset_kg AS DOUBLE))
      comment: "Total carbon offsets applied in kg CO2e"
    - name: "total_tonne_km"
      expr: SUM(CAST(tonne_km AS DOUBLE))
      comment: "Total tonne-kilometers transported"
    - name: "total_distance_km"
      expr: SUM(CAST(distance_km AS DOUBLE))
      comment: "Total distance transported in km"
    - name: "avg_emissions_intensity_per_tonne_km"
      expr: AVG(CAST(emissions_factor_co2e_per_tonne_km AS DOUBLE))
      comment: "Average emissions factor per tonne-km — key efficiency benchmark"
    - name: "avg_load_factor_percent"
      expr: AVG(CAST(load_factor_percent AS DOUBLE))
      comment: "Average load factor percentage — utilization efficiency indicator"
    - name: "total_fuel_consumed_liters"
      expr: SUM(CAST(fuel_consumed_liters AS DOUBLE))
      comment: "Total fuel consumed in liters across shipments"
    - name: "shipment_footprint_count"
      expr: COUNT(1)
      comment: "Number of shipment carbon footprint records calculated"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_fuel_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and emissions metrics for fleet operations, enabling fuel efficiency optimization, alternative fuel adoption tracking, and Scope 1 emissions management."
  source: "`transport_shipping_ecm`.`sustainability`.`fuel_consumption_record`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel consumed (diesel, gasoline, LNG, SAF, etc.)"
    - name: "scope_classification"
      expr: scope_classification
      comment: "GHG Protocol scope classification for the fuel consumption"
    - name: "operational_mode"
      expr: operational_mode
      comment: "Operational mode during fuel consumption (linehaul, last-mile, idle, etc.)"
    - name: "data_source"
      expr: data_source
      comment: "Source of fuel consumption data (telematics, fuel card, manual)"
    - name: "carbon_offset_applied"
      expr: carbon_offset_applied
      comment: "Whether carbon offset has been applied to this consumption"
    - name: "consumption_date"
      expr: consumption_date
      comment: "Date of fuel consumption"
    - name: "consumption_month"
      expr: DATE_TRUNC('month', consumption_date)
      comment: "Month of fuel consumption for trend analysis"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the fuel consumption record"
  measures:
    - name: "total_fuel_quantity"
      expr: SUM(CAST(fuel_quantity AS DOUBLE))
      comment: "Total fuel quantity consumed"
    - name: "total_co2e_emissions"
      expr: SUM(CAST(co2e_emissions AS DOUBLE))
      comment: "Total CO2e emissions from fuel consumption in tonnes"
    - name: "total_distance_travelled"
      expr: SUM(CAST(distance_travelled AS DOUBLE))
      comment: "Total distance travelled across all records"
    - name: "total_fuel_cost"
      expr: SUM(CAST(fuel_cost AS DOUBLE))
      comment: "Total fuel cost across all consumption records"
    - name: "avg_fuel_efficiency"
      expr: AVG(CAST(fuel_efficiency AS DOUBLE))
      comment: "Average fuel efficiency (distance per unit fuel)"
    - name: "avg_load_factor"
      expr: AVG(CAST(load_factor AS DOUBLE))
      comment: "Average load factor — vehicle utilization indicator"
    - name: "total_engine_hours"
      expr: SUM(CAST(engine_hours AS DOUBLE))
      comment: "Total engine hours operated"
    - name: "total_cargo_weight"
      expr: SUM(CAST(cargo_weight AS DOUBLE))
      comment: "Total cargo weight transported"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_carbon_offset_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon offset transaction metrics tracking offset purchases, retirements, and costs to monitor decarbonization investment and compliance obligations."
  source: "`transport_shipping_ecm`.`sustainability`.`carbon_offset_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of offset transaction (purchase, retirement, transfer)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "offset_standard"
      expr: offset_standard
      comment: "Carbon offset standard (Gold Standard, VCS, etc.)"
    - name: "project_type"
      expr: project_type
      comment: "Type of offset project (reforestation, renewable energy, etc.)"
    - name: "compliance_scheme"
      expr: compliance_scheme
      comment: "Compliance scheme the offset is used for (CORSIA, EU ETS, voluntary)"
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the offset project is located"
    - name: "registry_name"
      expr: registry_name
      comment: "Carbon registry where credits are tracked"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of the carbon credits"
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the offset transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of transaction for trend analysis"
  measures:
    - name: "total_quantity_tco2e"
      expr: SUM(CAST(quantity_tco2e AS DOUBLE))
      comment: "Total quantity of carbon offsets transacted in tonnes CO2e"
    - name: "total_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of carbon offset transactions"
    - name: "total_transaction_fees"
      expr: SUM(CAST(transaction_fee AS DOUBLE))
      comment: "Total transaction fees paid for offset trades"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price per tonne CO2e — market price indicator"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of carbon offset transactions"
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT project_type)
      comment: "Number of distinct project types in portfolio — diversification indicator"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption metrics for facilities and transport assets, tracking energy efficiency, renewable energy adoption, and Scope 2 emissions reduction."
  source: "`transport_shipping_ecm`.`sustainability`.`energy_consumption_record`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (electricity, natural gas, diesel, etc.)"
    - name: "country_code"
      expr: country_code
      comment: "Country where energy is consumed"
    - name: "region_code"
      expr: region_code
      comment: "Region where energy is consumed"
    - name: "operational_context"
      expr: operational_context
      comment: "Operational context of energy use (warehouse, hub, office, fleet)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the energy consumption record"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for the energy consumption"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period identifier"
  measures:
    - name: "total_consumption_quantity"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total energy consumption quantity"
    - name: "total_scope_1_emissions_tco2e"
      expr: SUM(CAST(scope_1_emissions_tco2e AS DOUBLE))
      comment: "Total Scope 1 emissions from energy consumption in tonnes CO2e"
    - name: "total_scope_2_emissions_tco2e"
      expr: SUM(CAST(scope_2_emissions_tco2e AS DOUBLE))
      comment: "Total Scope 2 emissions from energy consumption in tonnes CO2e"
    - name: "total_energy_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total energy cost across all records"
    - name: "avg_renewable_energy_share_percent"
      expr: AVG(CAST(renewable_energy_share_percent AS DOUBLE))
      comment: "Average renewable energy share percentage — green energy transition indicator"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for energy consumption records"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_saf_procurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainable Aviation Fuel procurement metrics tracking SAF adoption, GHG reduction from alternative fuels, and CORSIA compliance for aviation decarbonization."
  source: "`transport_shipping_ecm`.`sustainability`.`saf_procurement`"
  dimensions:
    - name: "feedstock_type"
      expr: feedstock_type
      comment: "Type of feedstock used for SAF production"
    - name: "certification_scheme"
      expr: certification_scheme
      comment: "Sustainability certification scheme (ISCC, RSB, etc.)"
    - name: "procurement_status"
      expr: procurement_status
      comment: "Current status of the SAF procurement"
    - name: "corsia_eligible_flag"
      expr: corsia_eligible_flag
      comment: "Whether the SAF is eligible for CORSIA compliance"
    - name: "delivery_location_name"
      expr: delivery_location_name
      comment: "Location where SAF is delivered"
    - name: "intended_use"
      expr: intended_use
      comment: "Intended use of the SAF (own operations, customer allocation)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the procurement"
    - name: "procurement_month"
      expr: DATE_TRUNC('month', procurement_date)
      comment: "Month of SAF procurement for trend analysis"
  measures:
    - name: "total_saf_volume_litres"
      expr: SUM(CAST(saf_volume_litres AS DOUBLE))
      comment: "Total SAF volume procured in litres"
    - name: "total_ghg_reduction_tco2e"
      expr: SUM(CAST(ghg_emissions_reduction_tonnes_co2e AS DOUBLE))
      comment: "Total GHG emissions reduction achieved through SAF in tonnes CO2e"
    - name: "total_saf_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of SAF procurement"
    - name: "total_conventional_fuel_displaced_litres"
      expr: SUM(CAST(conventional_jet_fuel_displaced_litres AS DOUBLE))
      comment: "Total conventional jet fuel displaced by SAF in litres"
    - name: "total_energy_content_mj"
      expr: SUM(CAST(energy_content_mj AS DOUBLE))
      comment: "Total energy content of SAF procured in megajoules"
    - name: "avg_blending_ratio_percentage"
      expr: AVG(CAST(blending_ratio_percentage AS DOUBLE))
      comment: "Average SAF blending ratio — adoption intensity indicator"
    - name: "avg_lifecycle_ghg_intensity"
      expr: AVG(CAST(lifecycle_ghg_intensity_gco2e_per_mj AS DOUBLE))
      comment: "Average lifecycle GHG intensity of SAF in gCO2e per MJ"
    - name: "avg_unit_price_per_litre"
      expr: AVG(CAST(unit_price_per_litre AS DOUBLE))
      comment: "Average unit price per litre of SAF — cost tracking"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_eu_ets_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "EU ETS allowance metrics for monitoring emissions trading compliance, allowance surplus/deficit, and carbon cost exposure."
  source: "`transport_shipping_ecm`.`sustainability`.`eu_ets_allowance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "EU ETS compliance status (compliant, non-compliant, pending)"
    - name: "allowance_type"
      expr: allowance_type
      comment: "Type of allowance (free allocation, purchased, auctioned)"
    - name: "sector"
      expr: sector
      comment: "Sector classification under EU ETS"
    - name: "member_state_code"
      expr: member_state_code
      comment: "EU member state code"
    - name: "compliance_period_year"
      expr: compliance_period_year
      comment: "Compliance period year"
    - name: "operator_name"
      expr: operator_name
      comment: "Name of the regulated operator"
  measures:
    - name: "total_verified_emissions_co2e"
      expr: SUM(CAST(verified_emissions_co2e AS DOUBLE))
      comment: "Total verified emissions subject to EU ETS in tonnes CO2e"
    - name: "total_available_allowances"
      expr: SUM(CAST(total_available_allowances AS DOUBLE))
      comment: "Total available allowances (free + purchased + transferred)"
    - name: "total_surrendered_allowances"
      expr: SUM(CAST(surrendered_allowances AS DOUBLE))
      comment: "Total allowances surrendered for compliance"
    - name: "total_surplus_allowances"
      expr: SUM(CAST(surplus_allowances AS DOUBLE))
      comment: "Total surplus allowances — over-compliance indicator"
    - name: "total_allowance_cost"
      expr: SUM(CAST(total_allowance_cost AS DOUBLE))
      comment: "Total cost of allowances purchased"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred for non-compliance"
    - name: "avg_allowance_price"
      expr: AVG(CAST(average_allowance_price AS DOUBLE))
      comment: "Average price per allowance — carbon price exposure indicator"
    - name: "total_outstanding_obligation"
      expr: SUM(CAST(outstanding_obligation_co2e AS DOUBLE))
      comment: "Total outstanding compliance obligation in tonnes CO2e"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_esg_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG disclosure metrics tracking organizational sustainability performance across environmental, social, and governance dimensions for investor and regulatory reporting."
  source: "`transport_shipping_ecm`.`sustainability`.`esg_disclosure`"
  dimensions:
    - name: "disclosure_framework"
      expr: disclosure_framework
      comment: "ESG disclosure framework (GRI, SASB, TCFD, CDP, etc.)"
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Current status of the disclosure (draft, approved, published)"
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance (limited, reasonable, none)"
    - name: "reporting_entity_name"
      expr: reporting_entity_name
      comment: "Name of the reporting entity"
    - name: "net_zero_target_year"
      expr: net_zero_target_year
      comment: "Target year for achieving net zero emissions"
    - name: "reporting_period_end"
      expr: DATE_TRUNC('quarter', reporting_period_end_date)
      comment: "End of reporting period (quarterly)"
  measures:
    - name: "total_emissions_co2e_tonnes"
      expr: SUM(CAST(total_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total reported emissions in tonnes CO2e"
    - name: "total_scope_1_emissions"
      expr: SUM(CAST(scope_1_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total Scope 1 emissions reported in disclosures"
    - name: "total_scope_2_emissions"
      expr: SUM(CAST(scope_2_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total Scope 2 emissions reported in disclosures"
    - name: "total_scope_3_emissions"
      expr: SUM(CAST(scope_3_emissions_co2e_tonnes AS DOUBLE))
      comment: "Total Scope 3 emissions reported in disclosures"
    - name: "avg_renewable_energy_percentage"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across disclosures"
    - name: "total_sustainability_investment"
      expr: SUM(CAST(sustainability_investment_amount AS DOUBLE))
      comment: "Total sustainability investment amount reported"
    - name: "avg_waste_recycled_percentage"
      expr: AVG(CAST(waste_recycled_percentage AS DOUBLE))
      comment: "Average waste recycled percentage — circular economy indicator"
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption reported in MWh"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_supplier_emissions_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier emissions disclosure metrics for Scope 3 value chain emissions management, supplier engagement scoring, and sustainable procurement decisions."
  source: "`transport_shipping_ecm`.`sustainability`.`supplier_emissions_disclosure`"
  dimensions:
    - name: "disclosure_status"
      expr: disclosure_status
      comment: "Status of the supplier disclosure (submitted, verified, rejected)"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of supplier emissions data"
    - name: "data_quality_tier"
      expr: data_quality_tier
      comment: "Data quality tier of the supplier disclosure"
    - name: "sbti_commitment_status"
      expr: sbti_commitment_status
      comment: "Science Based Targets initiative commitment status of the supplier"
    - name: "supplier_sustainability_rating"
      expr: supplier_sustainability_rating
      comment: "Overall sustainability rating of the supplier"
    - name: "cdp_score"
      expr: cdp_score
      comment: "CDP climate disclosure score of the supplier"
    - name: "disclosure_methodology"
      expr: disclosure_methodology
      comment: "Methodology used by supplier for emissions calculation"
  measures:
    - name: "total_supplier_scope_1_tco2e"
      expr: SUM(CAST(scope_1_emissions_tco2e AS DOUBLE))
      comment: "Total Scope 1 emissions reported by suppliers in tonnes CO2e"
    - name: "total_supplier_scope_2_tco2e"
      expr: SUM(CAST(scope_2_emissions_tco2e AS DOUBLE))
      comment: "Total Scope 2 emissions reported by suppliers in tonnes CO2e"
    - name: "total_supplier_scope_3_tco2e"
      expr: SUM(CAST(scope_3_emissions_tco2e AS DOUBLE))
      comment: "Total Scope 3 emissions reported by suppliers in tonnes CO2e"
    - name: "avg_emissions_intensity_per_tonne_km"
      expr: AVG(CAST(emissions_intensity_gco2e_per_tonne_km AS DOUBLE))
      comment: "Average supplier emissions intensity per tonne-km — benchmarking metric"
    - name: "avg_alternative_fuel_usage_pct"
      expr: AVG(CAST(alternative_fuel_usage_percentage AS DOUBLE))
      comment: "Average alternative fuel usage percentage across suppliers"
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across suppliers"
    - name: "total_freight_volume_tonne_km"
      expr: SUM(CAST(total_freight_volume_tonne_km AS DOUBLE))
      comment: "Total freight volume in tonne-km covered by supplier disclosures"
    - name: "supplier_disclosure_count"
      expr: COUNT(1)
      comment: "Number of supplier emissions disclosures received"
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers providing emissions disclosures"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability initiative metrics tracking decarbonization projects, investment ROI, and actual vs projected emissions reductions to guide capital allocation."
  source: "`transport_shipping_ecm`.`sustainability`.`initiative`"
  dimensions:
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of the initiative (planned, active, completed, cancelled)"
    - name: "initiative_category"
      expr: initiative_category
      comment: "Category of sustainability initiative (fleet electrification, renewable energy, etc.)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the initiative"
    - name: "sponsoring_business_unit"
      expr: sponsoring_business_unit
      comment: "Business unit sponsoring the initiative"
    - name: "scope_1_impact_flag"
      expr: scope_1_impact_flag
      comment: "Whether the initiative impacts Scope 1 emissions"
    - name: "scope_2_impact_flag"
      expr: scope_2_impact_flag
      comment: "Whether the initiative impacts Scope 2 emissions"
    - name: "scope_3_impact_flag"
      expr: scope_3_impact_flag
      comment: "Whether the initiative impacts Scope 3 emissions"
    - name: "customer_facing_flag"
      expr: customer_facing_flag
      comment: "Whether the initiative is customer-facing"
  measures:
    - name: "total_capex_investment"
      expr: SUM(CAST(capex_investment_amount AS DOUBLE))
      comment: "Total capital expenditure invested in sustainability initiatives"
    - name: "total_opex_investment"
      expr: SUM(CAST(opex_investment_amount AS DOUBLE))
      comment: "Total operational expenditure for sustainability initiatives"
    - name: "total_projected_co2e_reduction"
      expr: SUM(CAST(projected_co2e_reduction_tco2e_per_year AS DOUBLE))
      comment: "Total projected annual CO2e reduction in tonnes from all initiatives"
    - name: "total_actual_co2e_reduction"
      expr: SUM(CAST(actual_co2e_reduction_tco2e_per_year AS DOUBLE))
      comment: "Total actual annual CO2e reduction achieved in tonnes"
    - name: "total_baseline_emissions"
      expr: SUM(CAST(baseline_co2e_emissions_tco2e_per_year AS DOUBLE))
      comment: "Total baseline emissions targeted by initiatives"
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Number of sustainability initiatives"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management metrics tracking waste generation, diversion rates, and disposal methods to support zero-waste targets and circular economy goals."
  source: "`transport_shipping_ecm`.`sustainability`.`waste_record`"
  dimensions:
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream (packaging, general, hazardous, electronic)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (recycling, landfill, incineration, composting)"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the waste is classified as hazardous"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of waste disposal"
    - name: "record_status"
      expr: record_status
      comment: "Status of the waste record"
    - name: "waste_source_area"
      expr: waste_source_area
      comment: "Area/department generating the waste"
    - name: "collection_month"
      expr: DATE_TRUNC('month', collection_date)
      comment: "Month of waste collection for trend analysis"
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(waste_quantity AS DOUBLE))
      comment: "Total waste quantity generated"
    - name: "total_ghg_emissions_tco2e"
      expr: SUM(CAST(ghg_emissions_tco2e AS DOUBLE))
      comment: "Total GHG emissions from waste in tonnes CO2e"
    - name: "total_waste_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of waste management"
    - name: "avg_diversion_rate_percent"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate — zero-waste progress indicator"
    - name: "waste_record_count"
      expr: COUNT(1)
      comment: "Number of waste records"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_renewable_energy_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable Energy Certificate (REC) metrics tracking green energy procurement, Scope 2 emissions avoidance, and RE100 progress."
  source: "`transport_shipping_ecm`.`sustainability`.`renewable_energy_certificate`"
  dimensions:
    - name: "energy_source"
      expr: energy_source
      comment: "Source of renewable energy (solar, wind, hydro, biomass)"
    - name: "certificate_status"
      expr: certificate_status
      comment: "Status of the REC (active, retired, expired)"
    - name: "certificate_type"
      expr: certificate_type
      comment: "Type of certificate (GO, REC, I-REC)"
    - name: "procurement_method"
      expr: procurement_method
      comment: "Method of procurement (PPA, unbundled, bundled)"
    - name: "facility_country_code"
      expr: facility_country_code
      comment: "Country of the facility covered by the REC"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of the renewable energy generation"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the certificate"
  measures:
    - name: "total_energy_quantity_mwh"
      expr: SUM(CAST(energy_quantity_mwh AS DOUBLE))
      comment: "Total renewable energy quantity in MWh covered by certificates"
    - name: "total_co2e_avoided_tonnes"
      expr: SUM(CAST(co2e_avoided_tonnes AS DOUBLE))
      comment: "Total CO2e emissions avoided through renewable energy in tonnes"
    - name: "total_rec_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of renewable energy certificates"
    - name: "avg_cost_per_mwh"
      expr: AVG(CAST(cost_per_mwh AS DOUBLE))
      comment: "Average cost per MWh of renewable energy — procurement efficiency"
    - name: "certificate_count"
      expr: COUNT(1)
      comment: "Number of renewable energy certificates"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_corsia_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) compliance metrics tracking aviation emissions obligations, offset retirements, and compliance gaps."
  source: "`transport_shipping_ecm`.`sustainability`.`corsia_compliance_record`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "CORSIA compliance status (compliant, non-compliant, pending)"
    - name: "compliance_phase"
      expr: compliance_phase
      comment: "CORSIA implementation phase (pilot, first, second)"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Reporting year for CORSIA compliance"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the compliance record"
    - name: "offset_unit_type"
      expr: offset_unit_type
      comment: "Type of eligible offset units used"
    - name: "competent_authority_country_code"
      expr: competent_authority_country_code
      comment: "Country code of the competent authority"
    - name: "exemption_applied"
      expr: exemption_applied
      comment: "Whether an exemption was applied"
  measures:
    - name: "total_annual_emissions_tco2e"
      expr: SUM(CAST(annual_emissions_tco2e AS DOUBLE))
      comment: "Total annual aviation emissions subject to CORSIA in tonnes CO2e"
    - name: "total_offsetting_obligation_tco2e"
      expr: SUM(CAST(offsetting_obligation_tco2e AS DOUBLE))
      comment: "Total offsetting obligation under CORSIA in tonnes CO2e"
    - name: "total_units_retired_tco2e"
      expr: SUM(CAST(eligible_units_retired_tco2e AS DOUBLE))
      comment: "Total eligible offset units retired for compliance in tonnes CO2e"
    - name: "total_shortfall_tco2e"
      expr: SUM(CAST(shortfall_tco2e AS DOUBLE))
      comment: "Total compliance shortfall in tonnes CO2e — risk indicator"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties incurred for CORSIA non-compliance"
    - name: "total_baseline_emissions_tco2e"
      expr: SUM(CAST(baseline_emissions_tco2e AS DOUBLE))
      comment: "Total baseline emissions for growth factor calculation"
    - name: "compliance_record_count"
      expr: COUNT(1)
      comment: "Number of CORSIA compliance records"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`sustainability_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability target metrics tracking progress against science-based targets, reduction commitments, and net-zero pathways."
  source: "`transport_shipping_ecm`.`sustainability`.`target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of sustainability target (absolute, intensity, renewable energy)"
    - name: "target_status"
      expr: target_status
      comment: "Current status of the target (active, achieved, off-track)"
    - name: "scope_coverage"
      expr: scope_coverage
      comment: "GHG scope coverage of the target (Scope 1, 2, 3, or combined)"
    - name: "sbti_validation_status"
      expr: sbti_validation_status
      comment: "Science Based Targets initiative validation status"
    - name: "governing_framework"
      expr: governing_framework
      comment: "Governing framework for the target (SBTi, Paris Agreement, internal)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the target"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the target"
  measures:
    - name: "avg_progress_percentage"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average progress percentage across targets — overall trajectory indicator"
    - name: "avg_reduction_percentage"
      expr: AVG(CAST(reduction_percentage AS DOUBLE))
      comment: "Average reduction percentage committed across targets"
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Total baseline value across all targets"
    - name: "total_current_value"
      expr: SUM(CAST(current_value AS DOUBLE))
      comment: "Total current value across all targets"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value to be achieved"
    - name: "target_count"
      expr: COUNT(1)
      comment: "Number of sustainability targets"
$$;