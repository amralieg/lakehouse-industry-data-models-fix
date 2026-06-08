-- Metric views for domain: sustainability | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_ghg_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Greenhouse gas inventory metrics tracking total emissions across all scopes, intensity ratios, and year-over-year performance for regulatory and ESG reporting"
  source: "`waste_management_ecm`.`sustainability`.`ghg_inventory`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the GHG inventory (draft, approved, submitted, verified)"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the inventory"
    - name: "organizational_boundary_approach"
      expr: organizational_boundary_approach
      comment: "Approach used for organizational boundary (equity share, operational control, financial control)"
    - name: "esg_framework_alignment"
      expr: esg_framework_alignment
      comment: "ESG reporting frameworks aligned with (GRI, SASB, TCFD, CDP)"
    - name: "restatement_flag"
      expr: restatement_flag
      comment: "Indicates if this inventory includes restated historical data"
  measures:
    - name: "total_co2e_emissions"
      expr: SUM(CAST(total_co2e_metric_tons AS DOUBLE))
      comment: "Total greenhouse gas emissions across all scopes in metric tons CO2 equivalent"
    - name: "scope_1_emissions"
      expr: SUM(CAST(scope_1_co2e_metric_tons AS DOUBLE))
      comment: "Direct GHG emissions from owned or controlled sources (Scope 1)"
    - name: "scope_2_location_based_emissions"
      expr: SUM(CAST(scope_2_location_based_co2e_metric_tons AS DOUBLE))
      comment: "Indirect emissions from purchased electricity using location-based method (Scope 2)"
    - name: "scope_2_market_based_emissions"
      expr: SUM(CAST(scope_2_market_based_co2e_metric_tons AS DOUBLE))
      comment: "Indirect emissions from purchased electricity using market-based method (Scope 2)"
    - name: "scope_3_emissions"
      expr: SUM(CAST(scope_3_co2e_metric_tons AS DOUBLE))
      comment: "All other indirect emissions in the value chain (Scope 3)"
    - name: "biogenic_co2_emissions"
      expr: SUM(CAST(biogenic_co2_metric_tons AS DOUBLE))
      comment: "Biogenic CO2 emissions reported separately from fossil-based emissions"
    - name: "avg_emissions_intensity"
      expr: AVG(CAST(emissions_intensity_ratio AS DOUBLE))
      comment: "Average emissions intensity ratio (CO2e per unit of business activity)"
    - name: "inventory_count"
      expr: COUNT(1)
      comment: "Number of GHG inventory records"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_carbon_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon reduction initiative performance metrics tracking investment, projected ROI, emission reduction targets, and initiative lifecycle status"
  source: "`waste_management_ecm`.`sustainability`.`carbon_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of carbon reduction initiative (fleet electrification, renewable energy, efficiency, etc.)"
    - name: "carbon_initiative_status"
      expr: carbon_initiative_status
      comment: "Current status of the initiative (planning, active, completed, cancelled)"
    - name: "initiative_phase"
      expr: initiative_phase
      comment: "Current phase of the initiative lifecycle"
    - name: "priority_level"
      expr: priority_level
      comment: "Strategic priority level assigned to the initiative"
    - name: "responsible_business_unit"
      expr: responsible_business_unit
      comment: "Business unit responsible for executing the initiative"
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding for the initiative (capital budget, operating budget, grant, etc.)"
    - name: "regulatory_driver"
      expr: regulatory_driver
      comment: "Regulatory requirement or driver for the initiative"
    - name: "carbon_credit_eligible_flag"
      expr: carbon_credit_eligible_flag
      comment: "Indicates if the initiative is eligible to generate carbon credits"
    - name: "is_critical_path"
      expr: is_critical_path
      comment: "Indicates if this initiative is on the critical path for meeting reduction targets"
  measures:
    - name: "total_capital_investment"
      expr: SUM(CAST(capital_investment_amount AS DOUBLE))
      comment: "Total capital investment committed to carbon reduction initiatives"
    - name: "total_target_co2e_reduction"
      expr: SUM(CAST(target_co2e_reduction_tons AS DOUBLE))
      comment: "Total targeted CO2e reduction across all initiatives in metric tons"
    - name: "total_scope_1_reduction"
      expr: SUM(CAST(scope_1_reduction_tons AS DOUBLE))
      comment: "Total Scope 1 emission reductions targeted across initiatives"
    - name: "total_scope_2_reduction"
      expr: SUM(CAST(scope_2_reduction_tons AS DOUBLE))
      comment: "Total Scope 2 emission reductions targeted across initiatives"
    - name: "total_scope_3_reduction"
      expr: SUM(CAST(scope_3_reduction_tons AS DOUBLE))
      comment: "Total Scope 3 emission reductions targeted across initiatives"
    - name: "avg_projected_roi"
      expr: AVG(CAST(projected_roi_percent AS DOUBLE))
      comment: "Average projected return on investment across carbon initiatives"
    - name: "avg_payback_period"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years for carbon reduction investments"
    - name: "total_renewable_energy_capacity"
      expr: SUM(CAST(renewable_energy_capacity_mw AS DOUBLE))
      comment: "Total renewable energy generation capacity in megawatts from initiatives"
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Number of carbon reduction initiatives"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_diversion_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste diversion performance metrics tracking tons diverted from landfill, diversion rates, contamination, revenue, and GHG emissions avoided"
  source: "`waste_management_ecm`.`sustainability`.`diversion_record`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material diverted (recyclables, organics, construction debris, etc.)"
    - name: "diversion_pathway"
      expr: diversion_pathway
      comment: "Pathway for diversion (recycling, composting, waste-to-energy, reuse, etc.)"
    - name: "service_line"
      expr: service_line
      comment: "Service line generating the diversion (residential, commercial, industrial)"
    - name: "record_status"
      expr: record_status
      comment: "Status of the diversion record (draft, approved, audited)"
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard applied to the diversion activity"
    - name: "esg_reporting_flag"
      expr: esg_reporting_flag
      comment: "Indicates if this diversion is included in ESG reporting"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Indicates if this diversion is included in regulatory reporting"
  measures:
    - name: "total_waste_received"
      expr: SUM(CAST(total_waste_received_tons AS DOUBLE))
      comment: "Total waste received in metric tons across all diversion activities"
    - name: "total_waste_diverted"
      expr: SUM(CAST(waste_diverted_tons AS DOUBLE))
      comment: "Total waste diverted from landfill in metric tons"
    - name: "total_waste_to_landfill"
      expr: SUM(CAST(waste_to_landfill_tons AS DOUBLE))
      comment: "Total waste sent to landfill in metric tons"
    - name: "avg_diversion_rate"
      expr: AVG(CAST(diversion_rate_percentage AS DOUBLE))
      comment: "Average waste diversion rate as a percentage"
    - name: "avg_contamination_rate"
      expr: AVG(CAST(contamination_rate_percentage AS DOUBLE))
      comment: "Average contamination rate in diverted materials"
    - name: "total_ghg_emissions_avoided"
      expr: SUM(CAST(ghg_emissions_avoided_co2e_tons AS DOUBLE))
      comment: "Total GHG emissions avoided through diversion activities in metric tons CO2e"
    - name: "total_revenue_generated"
      expr: SUM(CAST(revenue_generated_usd AS DOUBLE))
      comment: "Total revenue generated from diverted materials in USD"
    - name: "total_processing_cost"
      expr: SUM(CAST(processing_cost_usd AS DOUBLE))
      comment: "Total cost of processing diverted materials in USD"
    - name: "diversion_record_count"
      expr: COUNT(1)
      comment: "Number of diversion records"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_reduction_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emission reduction target metrics tracking baseline values, target values, reduction percentages, and progress toward science-based and regulatory commitments"
  source: "`waste_management_ecm`.`sustainability`.`reduction_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of reduction target (absolute, intensity-based, renewable energy, etc.)"
    - name: "target_category"
      expr: target_category
      comment: "Category of the target (emissions, energy, waste, water, etc.)"
    - name: "scope"
      expr: scope
      comment: "GHG scope covered by the target (Scope 1, Scope 2, Scope 3, or combination)"
    - name: "commitment_status"
      expr: commitment_status
      comment: "Status of the commitment (proposed, approved, active, achieved, revised)"
    - name: "framework_alignment"
      expr: framework_alignment
      comment: "Framework the target aligns with (SBTi, CDP, GRI, etc.)"
    - name: "sbti_validated_flag"
      expr: sbti_validated_flag
      comment: "Indicates if the target has been validated by the Science Based Targets initiative"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Indicates if the target has been publicly disclosed"
    - name: "baseline_year"
      expr: baseline_year
      comment: "Baseline year for measuring progress"
    - name: "target_year"
      expr: target_year
      comment: "Target year for achieving the reduction"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the target"
  measures:
    - name: "total_baseline_value"
      expr: SUM(CAST(baseline_value AS DOUBLE))
      comment: "Total baseline value across all reduction targets"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value to be achieved across all reduction targets"
    - name: "avg_reduction_percentage"
      expr: AVG(CAST(reduction_percentage AS DOUBLE))
      comment: "Average reduction percentage committed across all targets"
    - name: "target_count"
      expr: COUNT(1)
      comment: "Number of reduction targets established"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_target_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reduction target progress metrics tracking actual performance against targets, variance from trajectory, and cumulative progress toward commitments"
  source: "`waste_management_ecm`.`sustainability`.`target_progress`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the progress reporting period"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the progress reporting period"
    - name: "reporting_scope"
      expr: reporting_scope
      comment: "Scope of the progress report (facility, business unit, enterprise)"
    - name: "ghg_scope"
      expr: ghg_scope
      comment: "GHG scope being reported (Scope 1, Scope 2, Scope 3)"
    - name: "emission_category"
      expr: emission_category
      comment: "Category of emissions being tracked"
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "Reporting framework used for progress tracking"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the progress data"
    - name: "is_restated"
      expr: is_restated
      comment: "Indicates if this progress report includes restated data"
    - name: "published_in_report"
      expr: published_in_report
      comment: "Indicates if this progress has been published in external reports"
  measures:
    - name: "total_actual_value"
      expr: SUM(CAST(actual_value AS DOUBLE))
      comment: "Total actual performance value achieved"
    - name: "total_cumulative_progress"
      expr: SUM(CAST(cumulative_progress_to_date AS DOUBLE))
      comment: "Total cumulative progress toward targets to date"
    - name: "avg_target_achievement_percentage"
      expr: AVG(CAST(target_achievement_percentage AS DOUBLE))
      comment: "Average percentage of target achieved across all tracked targets"
    - name: "avg_variance_from_trajectory"
      expr: AVG(CAST(variance_from_trajectory AS DOUBLE))
      comment: "Average variance from planned trajectory (positive = ahead, negative = behind)"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for progress reporting"
    - name: "progress_record_count"
      expr: COUNT(1)
      comment: "Number of target progress records"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_fleet_fuel_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet fuel consumption and emissions metrics tracking fuel usage, distance traveled, fuel efficiency, CO2e emissions, and renewable fuel adoption"
  source: "`waste_management_ecm`.`sustainability`.`fleet_fuel_consumption`"
  dimensions:
    - name: "vehicle_type"
      expr: vehicle_type
      comment: "Type of vehicle (collection truck, transfer truck, support vehicle, etc.)"
    - name: "service_line"
      expr: service_line
      comment: "Service line the vehicle supports (residential, commercial, industrial)"
    - name: "renewable_fuel_flag"
      expr: renewable_fuel_flag
      comment: "Indicates if renewable fuel (RNG, biodiesel, etc.) was used"
    - name: "esg_reporting_flag"
      expr: esg_reporting_flag
      comment: "Indicates if this consumption is included in ESG reporting"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the consumption record"
    - name: "ghg_inventory_category"
      expr: ghg_inventory_category
      comment: "GHG inventory category for the fuel consumption"
  measures:
    - name: "total_fuel_quantity_gallons"
      expr: SUM(CAST(fuel_quantity_gallons AS DOUBLE))
      comment: "Total fuel consumed in gallons"
    - name: "total_fuel_quantity_gge"
      expr: SUM(CAST(fuel_quantity_gge AS DOUBLE))
      comment: "Total fuel consumed in gasoline gallon equivalents (GGE)"
    - name: "total_distance_traveled"
      expr: SUM(CAST(distance_traveled_miles AS DOUBLE))
      comment: "Total distance traveled in miles"
    - name: "avg_fuel_efficiency_mpg"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency in miles per gallon"
    - name: "avg_fuel_efficiency_mpge"
      expr: AVG(CAST(fuel_efficiency_mpge AS DOUBLE))
      comment: "Average fuel efficiency in miles per gallon equivalent"
    - name: "total_co2e_emissions"
      expr: SUM(CAST(co2e_emissions_metric_tons AS DOUBLE))
      comment: "Total CO2e emissions from fleet fuel consumption in metric tons"
    - name: "total_fuel_cost"
      expr: SUM(CAST(fuel_cost_usd AS DOUBLE))
      comment: "Total fuel cost in USD"
    - name: "total_energy_quantity_mmbtu"
      expr: SUM(CAST(energy_quantity_mmbtu AS DOUBLE))
      comment: "Total energy consumed in million BTUs"
    - name: "total_idle_time"
      expr: SUM(CAST(idle_time_hours AS DOUBLE))
      comment: "Total idle time in hours"
    - name: "total_lcfs_credits"
      expr: SUM(CAST(lcfs_credits_generated AS DOUBLE))
      comment: "Total Low Carbon Fuel Standard credits generated"
    - name: "total_rin_credits"
      expr: SUM(CAST(rin_credits_generated AS DOUBLE))
      comment: "Total Renewable Identification Number credits generated"
    - name: "avg_carbon_intensity_score"
      expr: AVG(CAST(carbon_intensity_score AS DOUBLE))
      comment: "Average carbon intensity score for fuel consumed"
    - name: "consumption_record_count"
      expr: COUNT(1)
      comment: "Number of fuel consumption records"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_rng_production`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable natural gas production metrics tracking RNG output volume, energy content, carbon intensity, environmental credits, and production efficiency"
  source: "`waste_management_ecm`.`sustainability`.`rng_production`"
  dimensions:
    - name: "production_status"
      expr: production_status
      comment: "Status of the production batch (in progress, completed, quality hold, rejected)"
    - name: "shift_type"
      expr: shift_type
      comment: "Shift during which production occurred"
    - name: "quality_test_passed_flag"
      expr: quality_test_passed_flag
      comment: "Indicates if the RNG batch passed quality testing"
    - name: "renewable_fuel_pathway_code"
      expr: renewable_fuel_pathway_code
      comment: "EPA renewable fuel pathway code for the RNG"
    - name: "rin_d_code"
      expr: rin_d_code
      comment: "RIN D-code classification for the renewable fuel"
    - name: "carbon_credit_registry"
      expr: carbon_credit_registry
      comment: "Registry where carbon credits are issued"
  measures:
    - name: "total_rng_output_volume_scf"
      expr: SUM(CAST(rng_output_volume_scf AS DOUBLE))
      comment: "Total RNG output volume in standard cubic feet"
    - name: "total_rng_output_energy_mmbtu"
      expr: SUM(CAST(rng_output_energy_mmbtu AS DOUBLE))
      comment: "Total RNG energy output in million BTUs"
    - name: "total_pipeline_injection_volume"
      expr: SUM(CAST(pipeline_injection_volume_scf AS DOUBLE))
      comment: "Total RNG volume injected into pipeline in standard cubic feet"
    - name: "total_vehicle_fuel_dispensed"
      expr: SUM(CAST(vehicle_fuel_dispensed_gge AS DOUBLE))
      comment: "Total RNG dispensed as vehicle fuel in gasoline gallon equivalents"
    - name: "avg_production_efficiency"
      expr: AVG(CAST(production_efficiency_percent AS DOUBLE))
      comment: "Average production efficiency as a percentage"
    - name: "avg_rng_methane_purity"
      expr: AVG(CAST(rng_methane_purity_percent AS DOUBLE))
      comment: "Average methane purity of RNG produced"
    - name: "avg_carbon_intensity_score"
      expr: AVG(CAST(carbon_intensity_score AS DOUBLE))
      comment: "Average carbon intensity score for RNG produced"
    - name: "total_co2e_avoided"
      expr: SUM(CAST(co2e_avoided_metric_tons AS DOUBLE))
      comment: "Total CO2e emissions avoided through RNG production in metric tons"
    - name: "total_lcfs_credits"
      expr: SUM(CAST(lcfs_credits_generated AS DOUBLE))
      comment: "Total Low Carbon Fuel Standard credits generated"
    - name: "total_rin_credits"
      expr: SUM(CAST(rin_credits_generated AS DOUBLE))
      comment: "Total Renewable Identification Number credits generated"
    - name: "total_voluntary_carbon_credits"
      expr: SUM(CAST(voluntary_carbon_credits_issued AS DOUBLE))
      comment: "Total voluntary carbon credits issued"
    - name: "total_uptime_hours"
      expr: SUM(CAST(uptime_hours AS DOUBLE))
      comment: "Total production uptime in hours"
    - name: "total_downtime_hours"
      expr: SUM(CAST(downtime_hours AS DOUBLE))
      comment: "Total production downtime in hours"
    - name: "production_batch_count"
      expr: COUNT(1)
      comment: "Number of RNG production batches"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_lfg_capture`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landfill gas capture metrics tracking LFG collection volume, utilization pathways, flaring, electricity generation, emissions avoided, and carbon credits"
  source: "`waste_management_ecm`.`sustainability`.`lfg_capture`"
  dimensions:
    - name: "collection_system_status"
      expr: collection_system_status
      comment: "Operational status of the LFG collection system"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status for LFG capture"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure LFG capture volume"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for the capture record"
  measures:
    - name: "total_lfg_volume_collected_mmscf"
      expr: SUM(CAST(total_lfg_volume_collected_mmscf AS DOUBLE))
      comment: "Total landfill gas collected in million standard cubic feet"
    - name: "total_lfg_volume_collected_mmbtu"
      expr: SUM(CAST(total_lfg_volume_collected_mmbtu AS DOUBLE))
      comment: "Total landfill gas collected in million BTUs"
    - name: "total_lfg_flared_volume_mmscf"
      expr: SUM(CAST(lfg_flared_volume_mmscf AS DOUBLE))
      comment: "Total LFG volume flared in million standard cubic feet"
    - name: "total_lfg_utilized_wte_mmscf"
      expr: SUM(CAST(lfg_utilized_wte_volume_mmscf AS DOUBLE))
      comment: "Total LFG volume used for waste-to-energy in million standard cubic feet"
    - name: "total_lfg_utilized_rng_mmscf"
      expr: SUM(CAST(lfg_utilized_rng_volume_mmscf AS DOUBLE))
      comment: "Total LFG volume converted to RNG in million standard cubic feet"
    - name: "total_electricity_generated"
      expr: SUM(CAST(electricity_generated_mwh AS DOUBLE))
      comment: "Total electricity generated from LFG in megawatt-hours"
    - name: "total_co2e_emissions_avoided"
      expr: SUM(CAST(co2e_emissions_avoided_metric_tons AS DOUBLE))
      comment: "Total CO2e emissions avoided through LFG capture in metric tons"
    - name: "total_carbon_credits_generated"
      expr: SUM(CAST(carbon_credits_generated AS DOUBLE))
      comment: "Total carbon credits generated from LFG capture"
    - name: "avg_collection_system_efficiency"
      expr: AVG(CAST(collection_system_efficiency_percent AS DOUBLE))
      comment: "Average collection system efficiency as a percentage"
    - name: "avg_methane_concentration"
      expr: AVG(CAST(methane_concentration_percent AS DOUBLE))
      comment: "Average methane concentration in collected LFG"
    - name: "lfg_capture_record_count"
      expr: COUNT(1)
      comment: "Number of LFG capture records"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon offset purchase and retirement metrics tracking offset quantity, cost, project types, verification standards, and retirement for compliance or voluntary programs"
  source: "`waste_management_ecm`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "carbon_offset_status"
      expr: carbon_offset_status
      comment: "Status of the carbon offset (purchased, retired, held, cancelled)"
    - name: "project_type"
      expr: project_type
      comment: "Type of carbon offset project (forestry, renewable energy, methane capture, etc.)"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of carbon credit (verified carbon standard, gold standard, etc.)"
    - name: "verification_standard"
      expr: verification_standard
      comment: "Verification standard applied to the offset"
    - name: "additionality_verified"
      expr: additionality_verified
      comment: "Indicates if additionality has been verified for the offset"
    - name: "project_region"
      expr: project_region
      comment: "Geographic region of the offset project"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of the carbon offset"
    - name: "retirement_reason"
      expr: retirement_reason
      comment: "Reason for retiring the offset (compliance, voluntary, customer program)"
  measures:
    - name: "total_offset_quantity_tco2e"
      expr: SUM(CAST(quantity_tco2e AS DOUBLE))
      comment: "Total carbon offset quantity in metric tons CO2 equivalent"
    - name: "total_purchase_amount"
      expr: SUM(CAST(total_purchase_amount AS DOUBLE))
      comment: "Total amount spent on carbon offset purchases"
    - name: "avg_purchase_price_per_tco2e"
      expr: AVG(CAST(purchase_price_per_tco2e AS DOUBLE))
      comment: "Average purchase price per metric ton CO2 equivalent"
    - name: "offset_transaction_count"
      expr: COUNT(1)
      comment: "Number of carbon offset transactions"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`sustainability_esg_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG disclosure metrics tracking comprehensive sustainability performance including emissions, waste diversion, renewable energy, community investment, and safety for external reporting"
  source: "`waste_management_ecm`.`sustainability`.`esg_disclosure`"
  dimensions:
    - name: "framework_type"
      expr: framework_type
      comment: "ESG reporting framework used (GRI, SASB, TCFD, CDP, integrated)"
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the disclosure submission"
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of third-party assurance (limited, reasonable, none)"
    - name: "restatement_flag"
      expr: restatement_flag
      comment: "Indicates if this disclosure includes restated data"
  measures:
    - name: "total_scope_1_emissions_disclosed"
      expr: SUM(CAST(scope_1_emissions_co2e_metric_tons AS DOUBLE))
      comment: "Total Scope 1 emissions disclosed in metric tons CO2e"
    - name: "total_scope_2_emissions_disclosed"
      expr: SUM(CAST(scope_2_emissions_co2e_metric_tons AS DOUBLE))
      comment: "Total Scope 2 emissions disclosed in metric tons CO2e"
    - name: "total_scope_3_emissions_disclosed"
      expr: SUM(CAST(scope_3_emissions_co2e_metric_tons AS DOUBLE))
      comment: "Total Scope 3 emissions disclosed in metric tons CO2e"
    - name: "total_waste_diverted_disclosed"
      expr: SUM(CAST(total_waste_diverted_metric_tons AS DOUBLE))
      comment: "Total waste diverted from landfill disclosed in metric tons"
    - name: "avg_waste_diversion_rate_disclosed"
      expr: AVG(CAST(waste_diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate disclosed as a percentage"
    - name: "total_renewable_energy_consumption"
      expr: SUM(CAST(renewable_energy_consumption_mwh AS DOUBLE))
      comment: "Total renewable energy consumption disclosed in megawatt-hours"
    - name: "avg_renewable_energy_percentage"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy as a percentage of total energy consumption"
    - name: "total_carbon_offsets_purchased"
      expr: SUM(CAST(carbon_offset_credits_purchased_metric_tons AS DOUBLE))
      comment: "Total carbon offset credits purchased in metric tons"
    - name: "total_community_investment"
      expr: SUM(CAST(community_investment_amount_usd AS DOUBLE))
      comment: "Total community investment disclosed in USD"
    - name: "avg_esg_score"
      expr: AVG(CAST(esg_score AS DOUBLE))
      comment: "Average ESG score across disclosures"
    - name: "disclosure_count"
      expr: COUNT(1)
      comment: "Number of ESG disclosure submissions"
$$;