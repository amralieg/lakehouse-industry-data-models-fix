-- Metric views for domain: energy | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_generation_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core energy generation performance metrics tracking gross and net generation, efficiency, emissions, and renewable energy credits across waste-to-energy facilities"
  source: "`waste_management_ecm`.`energy`.`generation_reading`"
  dimensions:
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of generation reading for daily aggregation"
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Month of generation reading for monthly trend analysis"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the generation unit during reading period"
    - name: "rec_certification_type"
      expr: rec_certification_type
      comment: "Type of renewable energy credit certification"
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for reading validation"
    - name: "reading_interval_type"
      expr: reading_interval_type
      comment: "Type of reading interval (hourly, daily, etc.)"
  measures:
    - name: "total_gross_generation_mwh"
      expr: SUM(CAST(gross_generation_mwh AS DOUBLE))
      comment: "Total gross electrical generation in megawatt-hours before parasitic load"
    - name: "total_net_generation_mwh"
      expr: SUM(CAST(net_generation_mwh AS DOUBLE))
      comment: "Total net electrical generation in megawatt-hours available for sale or use"
    - name: "total_grid_export_mwh"
      expr: SUM(CAST(grid_export_mwh AS DOUBLE))
      comment: "Total electrical energy exported to the grid for revenue generation"
    - name: "avg_capacity_factor_percent"
      expr: AVG(CAST(capacity_factor_percent AS DOUBLE))
      comment: "Average capacity factor indicating utilization of nameplate capacity"
    - name: "avg_heat_rate_btu_per_kwh"
      expr: AVG(CAST(heat_rate_btu_per_kwh AS DOUBLE))
      comment: "Average heat rate measuring thermal efficiency of energy conversion"
    - name: "total_msw_feedstock_tons"
      expr: SUM(CAST(fuel_input_tons_msw AS DOUBLE))
      comment: "Total municipal solid waste feedstock processed in tons"
    - name: "total_renewable_energy_credits"
      expr: SUM(CAST(renewable_energy_credits_qty AS DOUBLE))
      comment: "Total renewable energy credits generated for environmental attribute monetization"
    - name: "total_co2_emissions_tons"
      expr: SUM(CAST(co2_emissions_tons AS DOUBLE))
      comment: "Total carbon dioxide emissions in tons for GHG reporting"
    - name: "total_nox_emissions_lbs"
      expr: SUM(CAST(nox_emissions_lbs AS DOUBLE))
      comment: "Total nitrogen oxide emissions in pounds for air quality compliance"
    - name: "avg_boiler_efficiency_percent"
      expr: AVG(CAST(boiler_efficiency_percent AS DOUBLE))
      comment: "Average boiler thermal efficiency percentage"
    - name: "avg_turbine_efficiency_percent"
      expr: AVG(CAST(turbine_efficiency_percent AS DOUBLE))
      comment: "Average turbine conversion efficiency percentage"
    - name: "total_ash_residue_tons"
      expr: SUM(CAST(ash_residue_tons AS DOUBLE))
      comment: "Total ash residue generated requiring disposal or beneficial reuse"
    - name: "total_parasitic_load_mwh"
      expr: SUM(CAST(parasitic_load_mwh AS DOUBLE))
      comment: "Total parasitic load consumed by facility operations"
    - name: "generation_reading_count"
      expr: COUNT(1)
      comment: "Number of generation readings recorded"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_combustion_operating_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily combustion operations metrics tracking throughput, emissions, energy output, and compliance for waste-to-energy boiler units"
  source: "`waste_management_ecm`.`energy`.`combustion_operating_log`"
  dimensions:
    - name: "operating_date"
      expr: operating_date
      comment: "Date of combustion operations"
    - name: "operating_month"
      expr: DATE_TRUNC('month', operating_date)
      comment: "Month of operations for trend analysis"
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of boiler unit during shift"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether operations met all compliance requirements"
    - name: "deviation_reported_flag"
      expr: deviation_reported_flag
      comment: "Indicates whether any regulatory deviations were reported"
  measures:
    - name: "total_msw_throughput_tons"
      expr: SUM(CAST(msw_throughput_tons AS DOUBLE))
      comment: "Total municipal solid waste processed in tons - primary operational volume metric"
    - name: "total_energy_output_mwh"
      expr: SUM(CAST(energy_output_mwh AS DOUBLE))
      comment: "Total electrical energy output in megawatt-hours"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours for availability analysis"
    - name: "avg_availability_factor_percent"
      expr: AVG(CAST(availability_factor_percent AS DOUBLE))
      comment: "Average availability factor measuring uptime performance"
    - name: "avg_gross_heat_rate_btu_per_kwh"
      expr: AVG(CAST(gross_heat_rate_btu_per_kwh AS DOUBLE))
      comment: "Average gross heat rate indicating overall thermal efficiency"
    - name: "total_nox_emissions_pounds"
      expr: SUM(CAST(nox_emissions_pounds AS DOUBLE))
      comment: "Total nitrogen oxide emissions for air permit compliance tracking"
    - name: "total_so2_emissions_pounds"
      expr: SUM(CAST(so2_emissions_pounds AS DOUBLE))
      comment: "Total sulfur dioxide emissions for acid gas compliance"
    - name: "total_co_emissions_pounds"
      expr: SUM(CAST(co_emissions_pounds AS DOUBLE))
      comment: "Total carbon monoxide emissions for combustion efficiency monitoring"
    - name: "total_particulate_matter_emissions_pounds"
      expr: SUM(CAST(particulate_matter_emissions_pounds AS DOUBLE))
      comment: "Total particulate matter emissions for air quality compliance"
    - name: "total_mercury_emissions_pounds"
      expr: SUM(CAST(mercury_emissions_pounds AS DOUBLE))
      comment: "Total mercury emissions for hazardous air pollutant tracking"
    - name: "total_fly_ash_tons"
      expr: SUM(CAST(fly_ash_tons AS DOUBLE))
      comment: "Total fly ash generated requiring disposal or beneficial reuse"
    - name: "total_bottom_ash_tons"
      expr: SUM(CAST(bottom_ash_tons AS DOUBLE))
      comment: "Total bottom ash generated from combustion grate"
    - name: "total_rec_credits_generated"
      expr: SUM(CAST(rec_credits_generated AS DOUBLE))
      comment: "Total renewable energy credits generated for revenue"
    - name: "avg_carbon_intensity_score"
      expr: AVG(CAST(carbon_intensity_score AS DOUBLE))
      comment: "Average carbon intensity score for sustainability reporting"
    - name: "total_forced_outage_hours"
      expr: SUM(CAST(forced_outage_hours AS DOUBLE))
      comment: "Total unplanned outage hours impacting availability"
    - name: "total_planned_outage_hours"
      expr: SUM(CAST(planned_outage_hours AS DOUBLE))
      comment: "Total planned maintenance outage hours"
    - name: "avg_cems_data_availability_percent"
      expr: AVG(CAST(cems_data_availability_percent AS DOUBLE))
      comment: "Average continuous emissions monitoring system data availability for regulatory compliance"
    - name: "operating_log_count"
      expr: COUNT(1)
      comment: "Number of daily operating log entries"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy delivery and revenue metrics tracking metered quantities, pricing, renewable energy credits, and settlement for offtake agreements"
  source: "`waste_management_ecm`.`energy`.`delivery`"
  dimensions:
    - name: "delivery_date"
      expr: DATE_TRUNC('day', period_start)
      comment: "Date of energy delivery period start"
    - name: "delivery_month"
      expr: DATE_TRUNC('month', period_start)
      comment: "Month of energy delivery for revenue trend analysis"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of delivery transaction (confirmed, settled, disputed)"
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy delivered (electricity, steam, RNG)"
    - name: "point"
      expr: point
      comment: "Delivery or interconnection point"
    - name: "quality_certification_flag"
      expr: quality_certification_flag
      comment: "Indicates whether delivery met quality certification requirements"
    - name: "settlement_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month of financial settlement for revenue recognition"
  measures:
    - name: "total_metered_quantity"
      expr: SUM(CAST(metered_quantity AS DOUBLE))
      comment: "Total metered energy quantity delivered"
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total scheduled energy quantity for delivery performance analysis"
    - name: "total_curtailment_quantity"
      expr: SUM(CAST(curtailment_quantity AS DOUBLE))
      comment: "Total curtailed energy quantity due to grid or operational constraints"
    - name: "total_revenue_amount"
      expr: SUM(CAST(revenue_amount AS DOUBLE))
      comment: "Total gross revenue from energy deliveries before adjustments"
    - name: "total_net_revenue_amount"
      expr: SUM(CAST(net_revenue_amount AS DOUBLE))
      comment: "Total net revenue after adjustments and curtailments"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit of energy delivered"
    - name: "total_rec_quantity"
      expr: SUM(CAST(rec_quantity AS DOUBLE))
      comment: "Total renewable energy credits delivered with energy"
    - name: "total_emissions_offset_quantity"
      expr: SUM(CAST(emissions_offset_quantity AS DOUBLE))
      comment: "Total emissions offsets associated with deliveries"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total revenue adjustments for delivery variances or quality issues"
    - name: "delivery_count"
      expr: COUNT(1)
      comment: "Number of delivery transactions"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_rin_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable Identification Number (RIN) generation metrics tracking RNG production, EPA compliance, and environmental credit value for landfill gas-to-energy projects"
  source: "`waste_management_ecm`.`energy`.`rin_generation`"
  dimensions:
    - name: "generation_date"
      expr: generation_date
      comment: "Date of RIN generation"
    - name: "generation_month"
      expr: DATE_TRUNC('month', generation_date)
      comment: "Month of RIN generation for trend analysis"
    - name: "rin_status"
      expr: rin_status
      comment: "Status of RIN (generated, verified, retired, sold)"
    - name: "rin_year"
      expr: rin_year
      comment: "Compliance year for RIN vintage"
    - name: "d_code"
      expr: d_code
      comment: "EPA D-code classification for renewable fuel type"
    - name: "pathway_code"
      expr: pathway_code
      comment: "EPA pathway code for fuel production process"
    - name: "feedstock_type"
      expr: feedstock_type
      comment: "Type of feedstock used for RNG production"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status for RIN validity"
    - name: "lcfs_credit_eligible"
      expr: lcfs_credit_eligible
      comment: "Indicates eligibility for California Low Carbon Fuel Standard credits"
    - name: "qa_qc_passed"
      expr: qa_qc_passed
      comment: "Indicates whether quality assurance checks passed"
  measures:
    - name: "total_rin_quantity"
      expr: SUM(CAST(rin_quantity AS DOUBLE))
      comment: "Total Renewable Identification Numbers generated for EPA RFS compliance"
    - name: "total_rng_volume_mmbtu"
      expr: SUM(CAST(rng_volume_mmbtu AS DOUBLE))
      comment: "Total renewable natural gas volume in million BTUs"
    - name: "total_rng_volume_gge"
      expr: SUM(CAST(rng_volume_gge AS DOUBLE))
      comment: "Total renewable natural gas volume in gasoline gallon equivalents"
    - name: "total_rin_value_usd"
      expr: SUM(CAST(total_rin_value_usd AS DOUBLE))
      comment: "Total market value of RINs generated in USD"
    - name: "avg_market_value_per_rin"
      expr: AVG(CAST(market_value_per_rin AS DOUBLE))
      comment: "Average market value per RIN for pricing analysis"
    - name: "avg_ghg_reduction_percent"
      expr: AVG(CAST(ghg_reduction_percent AS DOUBLE))
      comment: "Average greenhouse gas reduction percentage versus baseline fossil fuel"
    - name: "total_co2_removed_tons"
      expr: SUM(CAST(co2_removed_tons AS DOUBLE))
      comment: "Total carbon dioxide removed from landfill gas stream"
    - name: "avg_methane_content_percent"
      expr: AVG(CAST(methane_content_percent AS DOUBLE))
      comment: "Average methane content percentage in raw landfill gas"
    - name: "avg_upgrading_efficiency_percent"
      expr: AVG(CAST(upgrading_efficiency_percent AS DOUBLE))
      comment: "Average efficiency of gas upgrading process to pipeline quality"
    - name: "total_raw_lfg_volume_scfm"
      expr: SUM(CAST(raw_lfg_volume_scfm AS DOUBLE))
      comment: "Total raw landfill gas volume in standard cubic feet per minute"
    - name: "avg_equivalence_value"
      expr: AVG(CAST(equivalence_value AS DOUBLE))
      comment: "Average equivalence value for RIN calculation"
    - name: "rin_generation_count"
      expr: COUNT(1)
      comment: "Number of RIN generation batches"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_rec_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable Energy Credit transaction metrics tracking trading, retirement, and market value for compliance and voluntary renewable energy markets"
  source: "`waste_management_ecm`.`energy`.`rec_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of REC transaction"
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_date)
      comment: "Month of transaction for market trend analysis"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of transaction (purchase, sale, retirement, transfer)"
    - name: "retirement_status"
      expr: retirement_status
      comment: "Status of REC retirement for compliance or voluntary claims"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Year of renewable energy generation for REC vintage"
    - name: "eligibility_state"
      expr: eligibility_state
      comment: "State for which REC is eligible for RPS compliance"
    - name: "technology_type"
      expr: technology_type
      comment: "Renewable energy technology type (waste-to-energy, landfill gas, etc.)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used for renewable generation"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Financial settlement status of transaction"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status"
    - name: "trading_restriction_flag"
      expr: trading_restriction_flag
      comment: "Indicates whether trading restrictions apply"
  measures:
    - name: "total_rec_quantity_mwh"
      expr: SUM(CAST(rec_quantity_mwh AS DOUBLE))
      comment: "Total renewable energy credits transacted in megawatt-hours"
    - name: "total_transaction_value_usd"
      expr: SUM(CAST(total_transaction_value_usd AS DOUBLE))
      comment: "Total transaction value in USD for revenue or cost tracking"
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average price per REC for market pricing analysis"
    - name: "total_broker_fee_usd"
      expr: SUM(CAST(broker_fee_usd AS DOUBLE))
      comment: "Total broker fees paid for transaction facilitation"
    - name: "total_emissions_avoided_co2e_tons"
      expr: SUM(CAST(emissions_avoided_co2e_tons AS DOUBLE))
      comment: "Total carbon dioxide equivalent emissions avoided through renewable generation"
    - name: "rec_transaction_count"
      expr: COUNT(1)
      comment: "Number of REC transactions"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_lcfs_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Low Carbon Fuel Standard credit metrics tracking carbon intensity, credit generation, and market value for California and Oregon clean fuel programs"
  source: "`waste_management_ecm`.`energy`.`lcfs_credit`"
  dimensions:
    - name: "generation_date"
      expr: generation_date
      comment: "Date of LCFS credit generation"
    - name: "generation_month"
      expr: DATE_TRUNC('month', generation_date)
      comment: "Month of credit generation for trend analysis"
    - name: "credit_status"
      expr: credit_status
      comment: "Status of LCFS credit (generated, verified, sold, retired)"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for LCFS program"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of fuel production"
    - name: "fuel_pathway_code"
      expr: fuel_pathway_code
      comment: "CARB fuel pathway code for carbon intensity certification"
    - name: "feedstock_type"
      expr: feedstock_type
      comment: "Type of feedstock used for renewable fuel production"
    - name: "fuel_use_type"
      expr: fuel_use_type
      comment: "End-use application of renewable fuel"
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of credit transaction (generation, sale, transfer, retirement)"
    - name: "oregon_cfp_eligible_flag"
      expr: oregon_cfp_eligible_flag
      comment: "Indicates eligibility for Oregon Clean Fuels Program"
    - name: "rin_generation_eligible_flag"
      expr: rin_generation_eligible_flag
      comment: "Indicates eligibility for federal RIN generation"
  measures:
    - name: "total_lcfs_credit_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total LCFS credits generated in metric tons CO2e"
    - name: "total_market_value_usd"
      expr: SUM(CAST(market_value_usd AS DOUBLE))
      comment: "Total market value of LCFS credits in USD"
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average price per LCFS credit for market pricing"
    - name: "avg_carbon_intensity_score"
      expr: AVG(CAST(carbon_intensity_score AS DOUBLE))
      comment: "Average carbon intensity score in grams CO2e per megajoule"
    - name: "total_ghg_emissions_avoided_co2e_tons"
      expr: SUM(CAST(ghg_emissions_avoided_co2e_tons AS DOUBLE))
      comment: "Total greenhouse gas emissions avoided versus baseline fossil fuel"
    - name: "total_rng_volume_mmbtu"
      expr: SUM(CAST(rng_volume_mmbtu AS DOUBLE))
      comment: "Total renewable natural gas volume in million BTUs"
    - name: "total_rng_volume_dge"
      expr: SUM(CAST(rng_volume_dge AS DOUBLE))
      comment: "Total renewable natural gas volume in diesel gallon equivalents"
    - name: "total_oregon_cfp_credit_quantity"
      expr: SUM(CAST(oregon_cfp_credit_quantity AS DOUBLE))
      comment: "Total Oregon Clean Fuels Program credits generated"
    - name: "lcfs_credit_count"
      expr: COUNT(1)
      comment: "Number of LCFS credit batches"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_tipping_fee_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tipping fee revenue metrics tracking waste acceptance, tonnage, pricing, and contamination for waste-to-energy facility gate operations"
  source: "`waste_management_ecm`.`energy`.`tipping_fee_receipt`"
  dimensions:
    - name: "receipt_date"
      expr: DATE_TRUNC('day', receipt_timestamp)
      comment: "Date of tipping fee receipt"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of receipt for revenue trend analysis"
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste received (MSW, commercial, industrial)"
    - name: "waste_subtype"
      expr: waste_subtype
      comment: "Subtype classification of waste stream"
    - name: "load_acceptance_status"
      expr: load_acceptance_status
      comment: "Status of load acceptance (accepted, rejected, conditional)"
    - name: "contamination_flag"
      expr: contamination_flag
      comment: "Indicates whether load contained contamination"
    - name: "contamination_type"
      expr: contamination_type
      comment: "Type of contamination detected"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of tipping fee"
    - name: "hauler_name"
      expr: hauler_name
      comment: "Name of hauling company for customer analysis"
    - name: "origin_location"
      expr: origin_location
      comment: "Geographic origin of waste load"
  measures:
    - name: "total_net_weight_tons"
      expr: SUM(CAST(net_weight_tons AS DOUBLE))
      comment: "Total net weight of waste received in tons - primary throughput metric"
    - name: "total_gross_weight_tons"
      expr: SUM(CAST(gross_weight_tons AS DOUBLE))
      comment: "Total gross weight including vehicle tare"
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total tipping fee revenue collected"
    - name: "avg_tipping_fee_rate_per_ton"
      expr: AVG(CAST(tipping_fee_rate_per_ton AS DOUBLE))
      comment: "Average tipping fee rate per ton for pricing analysis"
    - name: "total_base_charge_amount"
      expr: SUM(CAST(base_charge_amount AS DOUBLE))
      comment: "Total base charge before surcharges and discounts"
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharges applied for special handling or contamination"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied for contract or volume commitments"
    - name: "tipping_fee_receipt_count"
      expr: COUNT(1)
      comment: "Number of tipping fee transactions"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_emissions_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Air emissions monitoring metrics tracking pollutant concentrations, mass emission rates, and permit compliance for continuous emissions monitoring systems"
  source: "`waste_management_ecm`.`energy`.`emissions_reading`"
  dimensions:
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of emissions reading"
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Month of reading for compliance trend analysis"
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of air pollutant measured (NOx, SO2, CO, PM, Hg, HCl)"
    - name: "averaging_period"
      expr: averaging_period
      comment: "Averaging period for emission limit compliance (hourly, daily, annual)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status relative to permit limits"
    - name: "deviation_flag"
      expr: deviation_flag
      comment: "Indicates whether reading exceeded permit limits"
    - name: "qa_qc_status"
      expr: qa_qc_status
      comment: "Quality assurance/quality control status of reading"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used for emissions measurement (CEMS, stack test, calculation)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type being combusted during reading"
    - name: "control_device_status"
      expr: control_device_status
      comment: "Operational status of air pollution control device"
    - name: "data_source"
      expr: data_source
      comment: "Source of emissions data (CEMS, manual, estimated)"
  measures:
    - name: "avg_measured_concentration"
      expr: AVG(CAST(measured_concentration AS DOUBLE))
      comment: "Average measured pollutant concentration"
    - name: "avg_corrected_concentration"
      expr: AVG(CAST(corrected_concentration AS DOUBLE))
      comment: "Average oxygen-corrected pollutant concentration for permit comparison"
    - name: "total_mass_emission_rate"
      expr: SUM(CAST(mass_emission_rate AS DOUBLE))
      comment: "Total mass emission rate for permit limit tracking"
    - name: "avg_flow_rate"
      expr: AVG(CAST(flow_rate AS DOUBLE))
      comment: "Average stack gas flow rate"
    - name: "avg_oxygen_percent"
      expr: AVG(CAST(oxygen_percent AS DOUBLE))
      comment: "Average oxygen percentage for concentration correction"
    - name: "avg_stack_temperature"
      expr: AVG(CAST(stack_temperature AS DOUBLE))
      comment: "Average stack gas temperature"
    - name: "avg_operating_load"
      expr: AVG(CAST(operating_load AS DOUBLE))
      comment: "Average operating load during emissions reading"
    - name: "avg_moisture_content"
      expr: AVG(CAST(moisture_content AS DOUBLE))
      comment: "Average moisture content in stack gas"
    - name: "emissions_reading_count"
      expr: COUNT(1)
      comment: "Number of emissions readings recorded"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_planned_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned maintenance outage metrics tracking duration, cost, lost generation, and schedule adherence for waste-to-energy facility reliability management"
  source: "`waste_management_ecm`.`energy`.`planned_outage`"
  dimensions:
    - name: "planned_start_month"
      expr: DATE_TRUNC('month', planned_start_date)
      comment: "Month of planned outage start for scheduling analysis"
    - name: "actual_start_month"
      expr: DATE_TRUNC('month', actual_start_date)
      comment: "Month of actual outage start"
    - name: "outage_status"
      expr: outage_status
      comment: "Status of outage (planned, in-progress, completed, cancelled, postponed)"
    - name: "outage_type"
      expr: outage_type
      comment: "Type of outage (annual, major overhaul, minor maintenance, inspection)"
    - name: "outage_reason_code"
      expr: outage_reason_code
      comment: "Standardized reason code for outage"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether outage is on critical path for facility operations"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether outage is required for regulatory compliance"
    - name: "safety_plan_required_flag"
      expr: safety_plan_required_flag
      comment: "Indicates whether formal safety plan is required"
    - name: "utility_approval_status"
      expr: utility_approval_status
      comment: "Utility approval status for planned outage"
  measures:
    - name: "total_planned_duration_hours"
      expr: SUM(CAST(planned_duration_hours AS DOUBLE))
      comment: "Total planned outage duration in hours"
    - name: "total_actual_duration_hours"
      expr: SUM(CAST(actual_duration_hours AS DOUBLE))
      comment: "Total actual outage duration for schedule adherence analysis"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Total estimated outage cost for budget planning"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Total actual outage cost for budget variance analysis"
    - name: "total_estimated_lost_generation_mwh"
      expr: SUM(CAST(estimated_lost_generation_mwh AS DOUBLE))
      comment: "Total estimated lost generation in megawatt-hours"
    - name: "total_actual_lost_generation_mwh"
      expr: SUM(CAST(actual_lost_generation_mwh AS DOUBLE))
      comment: "Total actual lost generation for revenue impact analysis"
    - name: "planned_outage_count"
      expr: COUNT(1)
      comment: "Number of planned outage events"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`energy_lfg_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landfill gas flow and composition metrics tracking methane concentration, flow rates, and collection system performance for gas-to-energy projects"
  source: "`waste_management_ecm`.`energy`.`lfg_flow_reading`"
  dimensions:
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Date of landfill gas flow reading"
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Month of reading for trend analysis"
    - name: "reading_type"
      expr: reading_type
      comment: "Type of reading (well, header, flare, blower station)"
    - name: "reading_status"
      expr: reading_status
      comment: "Status of reading (valid, invalid, estimated, missing)"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Indicates whether reading meets regulatory compliance requirements"
    - name: "alarm_triggered_flag"
      expr: alarm_triggered_flag
      comment: "Indicates whether reading triggered operational alarm"
    - name: "data_source"
      expr: data_source
      comment: "Source of reading data (SCADA, manual, portable analyzer)"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions during reading for correlation analysis"
  measures:
    - name: "total_flow_rate_scfm"
      expr: SUM(CAST(flow_rate_scfm AS DOUBLE))
      comment: "Total landfill gas flow rate in standard cubic feet per minute"
    - name: "avg_methane_concentration_pct"
      expr: AVG(CAST(methane_concentration_pct AS DOUBLE))
      comment: "Average methane concentration percentage for energy content assessment"
    - name: "avg_co2_concentration_pct"
      expr: AVG(CAST(co2_concentration_pct AS DOUBLE))
      comment: "Average carbon dioxide concentration percentage"
    - name: "avg_oxygen_concentration_pct"
      expr: AVG(CAST(oxygen_concentration_pct AS DOUBLE))
      comment: "Average oxygen concentration for air intrusion monitoring"
    - name: "avg_balance_gas_pct"
      expr: AVG(CAST(balance_gas_pct AS DOUBLE))
      comment: "Average balance gas percentage (nitrogen and trace gases)"
    - name: "avg_hydrogen_sulfide_ppm"
      expr: AVG(CAST(hydrogen_sulfide_ppm AS DOUBLE))
      comment: "Average hydrogen sulfide concentration for corrosion and odor management"
    - name: "avg_static_pressure_inches_h2o"
      expr: AVG(CAST(static_pressure_inches_h2o AS DOUBLE))
      comment: "Average static pressure in inches of water column"
    - name: "avg_temperature_fahrenheit"
      expr: AVG(CAST(temperature_fahrenheit AS DOUBLE))
      comment: "Average gas temperature in Fahrenheit"
    - name: "avg_barometric_pressure_inhg"
      expr: AVG(CAST(barometric_pressure_inhg AS DOUBLE))
      comment: "Average barometric pressure for flow correction"
    - name: "avg_lel_reading_pct"
      expr: AVG(CAST(lel_reading_pct AS DOUBLE))
      comment: "Average lower explosive limit reading for safety monitoring"
    - name: "lfg_flow_reading_count"
      expr: COUNT(1)
      comment: "Number of landfill gas flow readings"
$$;