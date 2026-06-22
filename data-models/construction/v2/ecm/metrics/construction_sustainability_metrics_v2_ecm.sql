-- Metric views for domain: sustainability | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon emission KPIs tracking total CO2e output by scope, source type, and reporting period — core metric for net-zero progress and regulatory reporting."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "scope"
      expr: scope
      comment: "GHG Protocol scope classification (Scope 1, 2, or 3) for emissions categorisation."
    - name: "source_type"
      expr: source_type
      comment: "Type of emission source (e.g., fuel combustion, electricity, transport) for source-level analysis."
    - name: "source_category"
      expr: source_category
      comment: "Emission source category enabling drill-down into specific activity types."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to quantify emissions (e.g., activity-based, spend-based) for data quality assessment."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of the emission record for assurance reporting."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period start month for time-series trend analysis."
    - name: "reporting_period_end"
      expr: DATE_TRUNC('month', reporting_period_end)
      comment: "Reporting period end month for period-over-period comparison."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag indicating whether the emission record has a data quality concern."
  measures:
    - name: "total_co2e_tonnes"
      expr: SUM(CAST(co2e_tonnes AS DOUBLE))
      comment: "Total CO2-equivalent emissions in tonnes — primary KPI for carbon footprint tracking and net-zero progress."
    - name: "avg_co2e_per_activity_unit"
      expr: AVG(CAST(co2e_tonnes AS DOUBLE))
      comment: "Average CO2e per emission record, indicating typical emission intensity per activity event."
    - name: "total_activity_quantity"
      expr: SUM(CAST(activity_quantity AS DOUBLE))
      comment: "Total activity quantity (e.g., litres of fuel, kWh) driving emissions — used to compute emission intensity ratios."
    - name: "emission_record_count"
      expr: COUNT(1)
      comment: "Total number of emission records — baseline volume metric for data completeness monitoring."
    - name: "verified_emission_record_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of third-party verified emission records — measures assurance coverage for ESG reporting credibility."
    - name: "co2e_intensity_per_activity"
      expr: ROUND(SUM(CAST(co2e_tonnes AS DOUBLE)) / NULLIF(SUM(CAST(activity_quantity AS DOUBLE)), 0), 4)
      comment: "CO2e tonnes per unit of activity — emission intensity ratio used to benchmark efficiency improvements over time."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon reduction target KPIs tracking ambition level, baseline emissions, and target trajectory — essential for SBTi alignment and net-zero governance."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of carbon target (absolute, intensity, net-zero) for target portfolio analysis."
    - name: "target_scope"
      expr: target_scope
      comment: "GHG scope coverage of the target (Scope 1+2, Scope 3, All Scopes)."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the target (Active, Superseded, Achieved, Withdrawn)."
    - name: "sbti_validation_status"
      expr: sbti_validation_status
      comment: "Science Based Targets initiative validation status — critical for investor and regulatory credibility."
    - name: "target_year"
      expr: target_year
      comment: "Target achievement year for milestone tracking and long-range planning."
    - name: "baseline_year"
      expr: baseline_year
      comment: "Baseline year against which reduction progress is measured."
    - name: "alignment_paris_pathway"
      expr: alignment_paris_pathway
      comment: "Paris Agreement pathway alignment (1.5°C, Well Below 2°C) for climate strategy positioning."
  measures:
    - name: "total_baseline_emissions_tco2e"
      expr: SUM(CAST(baseline_emissions_tco2e AS DOUBLE))
      comment: "Sum of baseline emissions across all targets — establishes the starting point for reduction measurement."
    - name: "total_target_value_tco2e"
      expr: SUM(CAST(target_value_tco2e AS DOUBLE))
      comment: "Sum of absolute emission targets in tCO2e — quantifies the total committed reduction ambition."
    - name: "avg_target_reduction_pct"
      expr: AVG(CAST(target_reduction_pct AS DOUBLE))
      comment: "Average percentage reduction committed across all active targets — headline ambition indicator for ESG disclosures."
    - name: "avg_target_intensity_value"
      expr: AVG(CAST(target_intensity_value AS DOUBLE))
      comment: "Average intensity target value — used to benchmark emission efficiency commitments across business units."
    - name: "active_target_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Number of currently active carbon targets — governance metric for target portfolio completeness."
    - name: "sbti_validated_target_count"
      expr: COUNT(CASE WHEN sbti_validation_status = 'Validated' THEN 1 END)
      comment: "Count of SBTi-validated targets — investor-grade credibility metric for science-based climate commitments."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_carbon_reduction_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon reduction initiative KPIs measuring the pipeline, delivery, and financial performance of decarbonisation investments — drives capital allocation decisions."
  source: "`vibe_construction_v1`.`sustainability`.`carbon_reduction_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Category of initiative (e.g., renewable energy, efficiency, electrification) for portfolio analysis."
    - name: "carbon_reduction_initiative_status"
      expr: carbon_reduction_initiative_status
      comment: "Current status of the initiative (Planned, In Progress, Completed, Cancelled) for pipeline management."
    - name: "climate_risk_category"
      expr: climate_risk_category
      comment: "Climate risk category addressed by the initiative for risk-reduction portfolio tracking."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of funding (internal, grant, green finance) for investment governance."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of reported savings for assurance and reporting integrity."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Initiative start year for cohort and vintage analysis of the decarbonisation pipeline."
  measures:
    - name: "total_estimated_co2e_saving"
      expr: SUM(CAST(estimated_co2e_saving AS DOUBLE))
      comment: "Total estimated CO2e savings across all initiatives — headline pipeline metric for net-zero roadmap planning."
    - name: "total_actual_co2e_saving"
      expr: SUM(CAST(actual_co2e_saving AS DOUBLE))
      comment: "Total realised CO2e savings — measures delivery against the decarbonisation pipeline."
    - name: "total_projected_annual_co2e_saving"
      expr: SUM(CAST(projected_annual_co2e_saving AS DOUBLE))
      comment: "Total projected annual CO2e savings — forward-looking KPI for annual carbon budget planning."
    - name: "total_implementation_cost"
      expr: SUM(CAST(implementation_cost AS DOUBLE))
      comment: "Total capital invested in carbon reduction initiatives — cost-of-decarbonisation metric for CFO reporting."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual spend on initiatives — budget vs actual tracking for programme financial control."
    - name: "avg_payback_period_years"
      expr: AVG(CAST(payback_period_years AS DOUBLE))
      comment: "Average payback period in years across initiatives — investment efficiency metric for capital allocation decisions."
    - name: "co2e_saving_delivery_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_co2e_saving AS DOUBLE)) / NULLIF(SUM(CAST(estimated_co2e_saving AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated CO2e savings actually delivered — programme effectiveness KPI for executive steering."
    - name: "cost_per_tco2e_saved"
      expr: ROUND(SUM(CAST(actual_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_co2e_saving AS DOUBLE)), 0), 2)
      comment: "Cost per tonne of CO2e actually saved — abatement cost metric used to prioritise future investments."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption KPIs tracking total energy use, carbon footprint, and intensity by type and project — drives energy efficiency investment and regulatory compliance."
  source: "`vibe_construction_v1`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_type"
      expr: energy_type
      comment: "Type of energy consumed (electricity, diesel, natural gas, renewable) for energy mix analysis."
    - name: "energy_consumption_status"
      expr: energy_consumption_status
      comment: "Record status (Submitted, Verified, Rejected) for data quality governance."
    - name: "metering_source"
      expr: metering_source
      comment: "Source of the meter reading (smart meter, manual, estimated) for data reliability assessment."
    - name: "is_estimated"
      expr: is_estimated
      comment: "Flag indicating whether the consumption figure is estimated rather than metered — data quality dimension."
    - name: "period_start_date"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Consumption period start month for time-series trend analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of energy measurement (kWh, MWh, GJ) for normalisation and comparison."
  measures:
    - name: "total_consumption_quantity"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total energy consumed in reported units — primary energy use KPI for efficiency benchmarking and regulatory reporting."
    - name: "total_carbon_emission_kg"
      expr: SUM(CAST(carbon_emission_kg AS DOUBLE))
      comment: "Total carbon emissions in kg attributable to energy consumption — Scope 2 emissions input for GHG inventory."
    - name: "avg_energy_intensity"
      expr: AVG(CAST(energy_intensity AS DOUBLE))
      comment: "Average energy intensity per record — efficiency metric used to track improvement over time."
    - name: "avg_carbon_emission_factor"
      expr: AVG(CAST(carbon_emission_factor AS DOUBLE))
      comment: "Average carbon emission factor applied — monitors grid decarbonisation impact on Scope 2 emissions."
    - name: "metered_record_count"
      expr: COUNT(CASE WHEN is_estimated = FALSE THEN 1 END)
      comment: "Count of metered (non-estimated) consumption records — data quality metric for assurance purposes."
    - name: "estimated_record_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_estimated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consumption records that are estimated rather than metered — data quality risk indicator for ESG assurance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste management KPIs tracking waste volumes, diversion rates, and disposal costs — drives circular economy performance and regulatory compliance."
  source: "`vibe_construction_v1`.`sustainability`.`waste_record`"
  dimensions:
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Waste stream classification (inert, hazardous, recyclable, organic) for waste portfolio analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category for detailed material flow tracking and reporting."
    - name: "disposal_route"
      expr: disposal_route
      comment: "Disposal route (landfill, recycling, energy recovery, reuse) — key metric for circular economy performance."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Indicates whether the waste is classified as hazardous — critical for regulatory compliance monitoring."
    - name: "waste_record_status"
      expr: waste_record_status
      comment: "Record status (Draft, Submitted, Verified) for data governance."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period start month for time-series waste trend analysis."
    - name: "waste_source"
      expr: waste_source
      comment: "Source activity generating the waste (demolition, excavation, fit-out) for source reduction targeting."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total waste generated in reported units — primary waste volume KPI for regulatory reporting and target tracking."
    - name: "total_waste_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of waste disposal — financial KPI for waste management budget control and cost reduction initiatives."
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate — headline circular economy KPI measuring landfill avoidance performance."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN hazardous_flag = TRUE THEN quantity ELSE 0 END)
      comment: "Total hazardous waste generated — regulatory compliance KPI requiring mandatory reporting and management."
    - name: "landfill_waste_quantity"
      expr: SUM(CASE WHEN disposal_route = 'Landfill' THEN quantity ELSE 0 END)
      comment: "Total waste sent to landfill — key metric for zero-waste-to-landfill target tracking."
    - name: "waste_record_count"
      expr: COUNT(1)
      comment: "Total number of waste records — data completeness baseline for waste management programme monitoring."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_waste_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste reduction target KPIs measuring ambition, progress, and delivery against waste diversion and intensity commitments — drives circular economy governance."
  source: "`vibe_construction_v1`.`sustainability`.`waste_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of waste target (diversion rate, absolute volume, intensity) for target portfolio analysis."
    - name: "waste_target_status"
      expr: waste_target_status
      comment: "Current status of the waste target (Active, Achieved, Missed, Superseded)."
    - name: "progress_status"
      expr: progress_status
      comment: "Progress status against the target (On Track, At Risk, Off Track) for executive steering."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region of the target for regional performance benchmarking."
    - name: "start_date"
      expr: DATE_TRUNC('year', start_date)
      comment: "Target start year for cohort analysis of waste reduction commitments."
  measures:
    - name: "avg_target_diversion_rate_pct"
      expr: AVG(CAST(target_diversion_rate_pct AS DOUBLE))
      comment: "Average target diversion rate committed — headline ambition metric for circular economy strategy."
    - name: "avg_actual_diversion_rate_pct"
      expr: AVG(CAST(actual_diversion_rate_pct AS DOUBLE))
      comment: "Average actual diversion rate achieved — delivery metric for circular economy performance reporting."
    - name: "diversion_rate_achievement_gap"
      expr: ROUND(AVG(CAST(actual_diversion_rate_pct AS DOUBLE)) - AVG(CAST(target_diversion_rate_pct AS DOUBLE)), 2)
      comment: "Gap between actual and target diversion rates — performance gap metric triggering corrective action when negative."
    - name: "total_target_landfill_diversion_tonnes"
      expr: SUM(CAST(target_landfill_diversion_tonnes AS DOUBLE))
      comment: "Total committed landfill diversion in tonnes — absolute target volume for zero-waste-to-landfill programmes."
    - name: "total_actual_landfill_diversion_tonnes"
      expr: SUM(CAST(actual_landfill_diversion_tonnes AS DOUBLE))
      comment: "Total actual landfill diversion achieved in tonnes — delivery metric against zero-waste commitments."
    - name: "avg_actual_waste_intensity_kg_per_sqm"
      expr: AVG(CAST(actual_waste_intensity_kg_per_sqm AS DOUBLE))
      comment: "Average actual waste intensity per square metre — normalised efficiency metric for cross-project benchmarking."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water consumption KPIs tracking total usage, discharge, and carbon footprint of water activities — supports water stewardship targets and stress-area risk management."
  source: "`vibe_construction_v1`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of water (mains, groundwater, recycled, rainwater) for water sourcing mix analysis."
    - name: "water_stress_area_classification"
      expr: water_stress_area_classification
      comment: "Water stress classification of the location — critical for prioritising water reduction in high-risk areas."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the water consumption record."
    - name: "metering_method"
      expr: metering_method
      comment: "Method used to measure consumption (metered, estimated, calculated) for data quality assessment."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Reporting period start month for time-series water trend analysis."
    - name: "discharge_destination"
      expr: discharge_destination
      comment: "Destination of discharged water (sewer, watercourse, ground) for environmental impact assessment."
  measures:
    - name: "total_consumption_volume_m3"
      expr: SUM(CAST(consumption_volume_m3 AS DOUBLE))
      comment: "Total water consumed in cubic metres — primary water use KPI for stewardship reporting and target tracking."
    - name: "total_discharge_volume_m3"
      expr: SUM(CAST(discharge_volume_m3 AS DOUBLE))
      comment: "Total water discharged in cubic metres — environmental impact metric for discharge permit compliance."
    - name: "net_water_consumption_m3"
      expr: ROUND(SUM(CAST(consumption_volume_m3 AS DOUBLE)) - SUM(CAST(discharge_volume_m3 AS DOUBLE)), 2)
      comment: "Net water consumed (intake minus discharge) — true water consumption metric for water stewardship accounting."
    - name: "total_carbon_footprint_kg"
      expr: SUM(CAST(carbon_footprint_kg AS DOUBLE))
      comment: "Total carbon footprint attributable to water consumption — Scope 3 emissions input for GHG inventory."
    - name: "avg_consumption_volume_m3"
      expr: AVG(CAST(consumption_volume_m3 AS DOUBLE))
      comment: "Average water consumption per record — intensity benchmark for cross-project water efficiency comparison."
    - name: "water_recycling_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discharge_volume_m3 AS DOUBLE)) / NULLIF(SUM(CAST(consumption_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of consumed water that is discharged/recycled — circular water use efficiency metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_esg_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG report KPIs aggregating headline sustainability performance metrics across emissions, energy, waste, and water — primary executive and investor reporting view."
  source: "`vibe_construction_v1`.`sustainability`.`esg_report`"
  dimensions:
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "ESG reporting framework used (GRI, TCFD, CSRD, CDP) for framework-specific performance analysis."
    - name: "publication_status"
      expr: publication_status
      comment: "Publication status of the ESG report (Draft, Published, Submitted) for reporting cycle governance."
    - name: "assurance_level"
      expr: assurance_level
      comment: "Level of external assurance obtained (None, Limited, Reasonable) — credibility metric for investor relations."
    - name: "net_zero_commitment_status"
      expr: net_zero_commitment_status
      comment: "Status of net-zero commitment (Committed, Validated, Achieved) for climate strategy positioning."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for annual ESG performance trend analysis."
    - name: "scope_boundary"
      expr: scope_boundary
      comment: "Organisational boundary of the report (operational control, financial control, equity share)."
  measures:
    - name: "total_scope1_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope1 AS DOUBLE))
      comment: "Total Scope 1 direct emissions in tCO2e — mandatory GHG inventory metric for regulatory and investor reporting."
    - name: "total_scope2_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope2 AS DOUBLE))
      comment: "Total Scope 2 indirect emissions from purchased energy — key metric for renewable energy transition tracking."
    - name: "total_scope3_emissions_tco2e"
      expr: SUM(CAST(total_emissions_scope3 AS DOUBLE))
      comment: "Total Scope 3 value chain emissions — largest emission category for construction, critical for supply chain decarbonisation."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumed in MWh across all reported entities — energy transition baseline metric."
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage — clean energy transition KPI for RE100 and net-zero commitments."
    - name: "total_waste_diverted_tonnes"
      expr: SUM(CAST(waste_diverted_tons AS DOUBLE))
      comment: "Total waste diverted from landfill in tonnes — circular economy performance metric for ESG disclosure."
    - name: "avg_waste_diverted_pct"
      expr: AVG(CAST(waste_diverted_percentage AS DOUBLE))
      comment: "Average waste diversion rate across reports — headline circular economy KPI for ESG benchmarking."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Total water consumed in cubic metres — water stewardship metric for CDP Water and TCFD physical risk reporting."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity across ESG reports — normalised emission efficiency metric for year-on-year improvement tracking."
    - name: "avg_emission_reduction_target_pct"
      expr: AVG(CAST(emission_reduction_target_percentage AS DOUBLE))
      comment: "Average emission reduction target percentage committed — ambition metric for climate strategy governance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_esg_disclosure_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG disclosure item KPIs measuring data completeness, verification coverage, and reported values by framework indicator — supports assurance and regulatory submission quality."
  source: "`vibe_construction_v1`.`sustainability`.`esg_disclosure_item`"
  dimensions:
    - name: "framework"
      expr: framework
      comment: "Reporting framework (GRI, SASB, TCFD, CSRD) for framework-specific disclosure completeness analysis."
    - name: "indicator_code"
      expr: indicator_code
      comment: "Specific framework indicator code for granular disclosure tracking."
    - name: "emission_scope"
      expr: emission_scope
      comment: "GHG scope of the disclosure item for emissions categorisation."
    - name: "esg_disclosure_item_status"
      expr: esg_disclosure_item_status
      comment: "Status of the disclosure item (Draft, Submitted, Verified, Restated) for reporting cycle management."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status for assurance coverage analysis."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality concern flag for identifying disclosures requiring remediation."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for annual disclosure completeness trend analysis."
    - name: "is_key_metric"
      expr: is_key_metric
      comment: "Flag indicating whether this is a key performance metric for prioritised monitoring."
  measures:
    - name: "total_reported_value"
      expr: SUM(CAST(reported_value AS DOUBLE))
      comment: "Sum of all reported quantitative disclosure values — aggregate performance metric across ESG indicators."
    - name: "total_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of ESG disclosures — financial materiality metric for TCFD and CSRD reporting."
    - name: "verified_disclosure_count"
      expr: COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END)
      comment: "Count of verified disclosure items — assurance coverage metric for ESG report credibility."
    - name: "verification_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosure items with third-party verification — assurance quality KPI for investor and regulator confidence."
    - name: "data_quality_issue_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of disclosure items flagged for data quality issues — data governance KPI triggering remediation action."
    - name: "restated_disclosure_count"
      expr: COUNT(CASE WHEN restated = TRUE THEN 1 END)
      comment: "Count of restated disclosure items — data reliability metric indicating prior-period corrections requiring investigation."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_green_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Green building certification KPIs tracking certification achievement, cost, and carbon reduction outcomes — drives sustainable construction value and asset premium analysis."
  source: "`vibe_construction_v1`.`sustainability`.`green_certification`"
  dimensions:
    - name: "certification_scheme"
      expr: certification_scheme
      comment: "Green building certification scheme (LEED, BREEAM, WELL, Green Star) for scheme-level performance analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (Registered, Certified, Expired, Withdrawn) for portfolio management."
    - name: "achieved_rating"
      expr: achieved_rating
      comment: "Rating level achieved (Platinum, Gold, Silver, Certified) for premium asset identification."
    - name: "target_rating_level"
      expr: target_rating_level
      comment: "Target rating level for gap analysis between ambition and achievement."
    - name: "certification_body"
      expr: certification_body
      comment: "Certifying organisation for scheme-specific benchmarking."
    - name: "rating_date"
      expr: DATE_TRUNC('year', rating_date)
      comment: "Year of certification rating for vintage analysis of green building portfolio."
  measures:
    - name: "total_certification_cost"
      expr: SUM(CAST(certification_cost AS DOUBLE))
      comment: "Total investment in green building certifications — cost-of-sustainability metric for ROI analysis."
    - name: "total_carbon_reduction_amount"
      expr: SUM(CAST(carbon_reduction_amount AS DOUBLE))
      comment: "Total carbon reduction attributed to certified buildings — sustainability outcome metric for portfolio reporting."
    - name: "avg_sustainable_material_pct"
      expr: AVG(CAST(sustainable_material_pct AS DOUBLE))
      comment: "Average sustainable material content across certified projects — circular economy input metric."
    - name: "avg_waste_diversion_pct"
      expr: AVG(CAST(waste_diversion_pct AS DOUBLE))
      comment: "Average waste diversion rate across certified projects — construction waste performance benchmark."
    - name: "certified_project_count"
      expr: COUNT(CASE WHEN certification_status = 'Certified' THEN 1 END)
      comment: "Number of certified green buildings — portfolio headline metric for sustainability strategy reporting."
    - name: "certification_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'Certified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of registered projects achieving certification — programme effectiveness KPI for green building strategy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_green_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Green credit KPIs tracking points achieved, targeted, and compliance status across certification programmes — drives credit optimisation and certification strategy."
  source: "`vibe_construction_v1`.`sustainability`.`green_credit`"
  dimensions:
    - name: "certification_program"
      expr: certification_program
      comment: "Green building certification programme (LEED, BREEAM, WELL) for programme-level credit analysis."
    - name: "credit_category"
      expr: credit_category
      comment: "Credit category (Energy, Water, Materials, Indoor Environment) for category-level performance optimisation."
    - name: "green_credit_status"
      expr: green_credit_status
      comment: "Status of the credit (Targeted, Submitted, Achieved, Not Pursued) for credit pipeline management."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the credit submission for regulatory and certification body requirements."
    - name: "is_verified"
      expr: is_verified
      comment: "Flag indicating whether the credit has been independently verified."
    - name: "assessment_date"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Assessment year for credit achievement trend analysis."
  measures:
    - name: "total_points_achieved"
      expr: SUM(CAST(points_achieved AS DOUBLE))
      comment: "Total green building points achieved — primary certification score metric driving rating level outcomes."
    - name: "total_points_targeted"
      expr: SUM(CAST(points_targeted AS DOUBLE))
      comment: "Total points targeted across all credits — ambition metric for certification strategy planning."
    - name: "total_points_max"
      expr: SUM(CAST(points_max AS DOUBLE))
      comment: "Total maximum available points — denominator for credit achievement rate calculation."
    - name: "credit_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(points_achieved AS DOUBLE)) / NULLIF(SUM(CAST(points_max AS DOUBLE)), 0), 2)
      comment: "Percentage of maximum available points achieved — overall certification performance efficiency metric."
    - name: "points_gap_to_target"
      expr: ROUND(SUM(CAST(points_targeted AS DOUBLE)) - SUM(CAST(points_achieved AS DOUBLE)), 2)
      comment: "Gap between targeted and achieved points — action trigger metric for credit recovery planning."
    - name: "verified_credit_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN 1 END)
      comment: "Count of independently verified credits — assurance quality metric for certification submission integrity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_supply_chain_carbon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain carbon KPIs measuring Scope 3 emissions by supplier, material category, and data quality — critical for value chain decarbonisation and procurement decisions."
  source: "`vibe_construction_v1`.`sustainability`.`supply_chain_carbon`"
  dimensions:
    - name: "material_category"
      expr: material_category
      comment: "Material or service category for identifying highest-carbon procurement categories."
    - name: "supply_chain_carbon_status"
      expr: supply_chain_carbon_status
      comment: "Record status (Draft, Submitted, Verified) for data governance."
    - name: "data_quality_tier"
      expr: data_quality_tier
      comment: "Data quality tier (Primary, Secondary, Spend-based) — critical for Scope 3 assurance and accuracy improvement."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Emission calculation method (activity-based, spend-based, supplier-specific) for methodology transparency."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of supply chain activity for regional carbon risk analysis."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for Scope 3 trend analysis and year-on-year reduction tracking."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status for Scope 3 assurance coverage analysis."
  measures:
    - name: "total_scope3_tco2e"
      expr: SUM(CAST(scope3_tco2e AS DOUBLE))
      comment: "Total Scope 3 supply chain emissions in tCO2e — primary value chain carbon footprint metric for CDP and CSRD reporting."
    - name: "total_spend_amount"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total procurement spend associated with Scope 3 emissions — financial materiality metric for spend-based emission analysis."
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity of supply chain activities — efficiency metric for supplier decarbonisation benchmarking."
    - name: "avg_emission_factor"
      expr: AVG(CAST(emission_factor AS DOUBLE))
      comment: "Average emission factor applied across supply chain records — data quality metric for Scope 3 methodology improvement."
    - name: "scope3_per_spend_unit"
      expr: ROUND(SUM(CAST(scope3_tco2e AS DOUBLE)) / NULLIF(SUM(CAST(spend_amount AS DOUBLE)), 0), 6)
      comment: "Scope 3 tCO2e per unit of spend — spend-normalised carbon intensity metric for procurement decarbonisation targeting."
    - name: "primary_data_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_tier = 'Primary' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of Scope 3 records using primary supplier data — data quality improvement KPI for Scope 3 assurance readiness."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_embodied_carbon_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Embodied carbon assessment KPIs measuring whole-life carbon performance of construction assets — drives low-carbon design decisions and regulatory compliance."
  source: "`vibe_construction_v1`.`sustainability`.`embodied_carbon_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (Draft, Approved, Superseded) for assessment lifecycle management."
    - name: "methodology"
      expr: methodology
      comment: "Assessment methodology (EN 15978, RICS WLCA) for methodology-level benchmarking."
    - name: "riba_stage"
      expr: riba_stage
      comment: "RIBA design stage at which the assessment was conducted — tracks carbon reduction through design evolution."
    - name: "scope"
      expr: scope
      comment: "Assessment scope (A1-A5, A-C, A-D) for lifecycle boundary comparison."
    - name: "is_verified"
      expr: is_verified
      comment: "Flag indicating independent verification of the assessment."
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating whether the assessment is required for regulatory submission."
    - name: "assessment_timestamp"
      expr: DATE_TRUNC('year', assessment_timestamp)
      comment: "Assessment year for tracking embodied carbon improvement over design iterations."
  measures:
    - name: "total_embodied_carbon_tco2e"
      expr: SUM(CAST(total_embodied_carbon_tco2e AS DOUBLE))
      comment: "Total embodied carbon across all assessed assets in tCO2e — primary whole-life carbon metric for net-zero buildings strategy."
    - name: "total_upfront_carbon_tco2e"
      expr: SUM(CAST(upfront_carbon_tco2e AS DOUBLE))
      comment: "Total upfront (A1-A5) embodied carbon — construction phase carbon metric for immediate reduction targeting."
    - name: "total_end_of_life_carbon_tco2e"
      expr: SUM(CAST(end_of_life_carbon_tco2e AS DOUBLE))
      comment: "Total end-of-life carbon — circular economy metric for design-for-disassembly and material recovery planning."
    - name: "avg_carbon_intensity_kg_per_m3"
      expr: AVG(CAST(carbon_intensity_kg_per_m3 AS DOUBLE))
      comment: "Average embodied carbon intensity per cubic metre — normalised benchmark for cross-project design efficiency comparison."
    - name: "avg_renewable_material_pct"
      expr: AVG(CAST(renewable_material_percentage AS DOUBLE))
      comment: "Average renewable material content — sustainable materials adoption metric for low-carbon procurement strategy."
    - name: "avg_waste_diversion_rate_pct"
      expr: AVG(CAST(waste_diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate in assessed projects — circular economy performance metric linked to embodied carbon reduction."
    - name: "verified_assessment_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of embodied carbon assessments independently verified — assurance quality metric for regulatory and investor reporting."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability audit KPIs measuring audit outcomes, compliance ratings, and environmental performance findings — drives continuous improvement and regulatory assurance."
  source: "`vibe_construction_v1`.`sustainability`.`sustainability_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of sustainability audit (internal, external, regulatory, certification) for audit portfolio analysis."
    - name: "sustainability_audit_status"
      expr: sustainability_audit_status
      comment: "Current audit status (Planned, In Progress, Completed, Closed) for audit programme management."
    - name: "compliance_rating"
      expr: compliance_rating
      comment: "Overall compliance rating from the audit — headline governance metric for regulatory and board reporting."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of audit findings for assurance completeness."
    - name: "net_zero_commitment_status"
      expr: net_zero_commitment_status
      comment: "Net-zero commitment status assessed during the audit for climate governance tracking."
    - name: "audit_date"
      expr: DATE_TRUNC('year', audit_date)
      comment: "Audit year for annual audit programme performance trend analysis."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Flag indicating data quality concerns identified during the audit."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average sustainability audit score — headline performance metric for sustainability governance effectiveness."
    - name: "total_carbon_emission_tonnes"
      expr: SUM(CAST(carbon_emission_tonnes AS DOUBLE))
      comment: "Total carbon emissions reported across audited entities — GHG inventory validation metric."
    - name: "total_energy_consumption_mwh"
      expr: SUM(CAST(energy_consumption_mwh AS DOUBLE))
      comment: "Total energy consumption across audited entities — energy management performance metric."
    - name: "total_water_usage_m3"
      expr: SUM(CAST(water_usage_cubic_meters AS DOUBLE))
      comment: "Total water usage across audited entities — water stewardship performance metric."
    - name: "avg_waste_diversion_pct"
      expr: AVG(CAST(waste_diversion_percentage AS DOUBLE))
      comment: "Average waste diversion rate across audited entities — circular economy performance benchmark."
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Total number of sustainability audits conducted — programme coverage metric for governance completeness."
    - name: "data_quality_issue_audit_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with data quality flags — data governance risk metric triggering remediation action."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_biodiversity_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biodiversity assessment KPIs measuring habitat impact, biodiversity net gain, and mitigation effectiveness — supports regulatory compliance and nature-positive construction commitments."
  source: "`vibe_construction_v1`.`sustainability`.`biodiversity_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of biodiversity assessment (baseline, impact, post-construction) for assessment lifecycle tracking."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (Draft, Approved, Submitted) for governance management."
    - name: "statutory_approval_status"
      expr: statutory_approval_status
      comment: "Statutory approval status — regulatory compliance metric for planning and environmental permitting."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status for assurance coverage."
    - name: "monitoring_status"
      expr: monitoring_status
      comment: "Status of post-construction biodiversity monitoring programme."
    - name: "assessment_date"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Assessment year for biodiversity performance trend analysis."
  measures:
    - name: "total_habitat_area_ha"
      expr: SUM(CAST(habitat_area_ha AS DOUBLE))
      comment: "Total habitat area assessed in hectares — scale metric for biodiversity impact portfolio management."
    - name: "total_biodiversity_units_gained"
      expr: SUM(CAST(biodiversity_units_gained AS DOUBLE))
      comment: "Total biodiversity units gained — primary biodiversity net gain metric for regulatory compliance and nature-positive reporting."
    - name: "total_biodiversity_units_lost"
      expr: SUM(CAST(biodiversity_units_lost AS DOUBLE))
      comment: "Total biodiversity units lost — impact metric for mitigation hierarchy application and offset planning."
    - name: "total_net_biodiversity_units"
      expr: SUM(CAST(net_biodiversity_units AS DOUBLE))
      comment: "Net biodiversity units (gained minus lost) — headline biodiversity net gain KPI for planning compliance and ESG reporting."
    - name: "avg_habitat_quality_score"
      expr: AVG(CAST(habitat_quality_score AS DOUBLE))
      comment: "Average habitat quality score — ecological condition metric for biodiversity management effectiveness."
    - name: "avg_biodiversity_units_per_ha"
      expr: AVG(CAST(biodiversity_units_per_ha AS DOUBLE))
      comment: "Average biodiversity units per hectare — intensity metric for habitat quality benchmarking across projects."
    - name: "biodiversity_net_gain_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_biodiversity_units AS DOUBLE)) / NULLIF(SUM(CAST(biodiversity_units_lost AS DOUBLE)), 0), 2)
      comment: "Net biodiversity gain as a percentage of units lost — regulatory compliance metric for mandatory 10% BNG requirement."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_climate_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Climate risk assessment KPIs measuring financial exposure, risk distribution, and strategic priority of climate risks — supports TCFD disclosure and climate resilience investment."
  source: "`vibe_construction_v1`.`sustainability`.`climate_risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of climate risk assessment (physical, transition, liability) for TCFD category analysis."
    - name: "climate_risk_assessment_status"
      expr: climate_risk_assessment_status
      comment: "Current status of the assessment for governance and reporting cycle management."
    - name: "risk_category"
      expr: risk_category
      comment: "Climate risk category (physical acute, physical chronic, transition policy, market) for TCFD-aligned reporting."
    - name: "climate_scenario"
      expr: climate_scenario
      comment: "Climate scenario used (1.5°C, 2°C, 4°C) for scenario analysis and stress testing."
    - name: "time_horizon"
      expr: time_horizon
      comment: "Time horizon of the risk (short, medium, long-term) for temporal risk prioritisation."
    - name: "is_strategic_priority"
      expr: is_strategic_priority
      comment: "Flag indicating whether the risk is a strategic priority for executive attention."
    - name: "assessment_date"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Assessment year for climate risk portfolio trend analysis."
  measures:
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Total estimated financial impact of climate risks — primary TCFD financial materiality metric for board and investor reporting."
    - name: "avg_financial_impact_estimate"
      expr: AVG(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Average financial impact per climate risk assessment — risk severity benchmark for prioritisation decisions."
    - name: "strategic_priority_risk_count"
      expr: COUNT(CASE WHEN is_strategic_priority = TRUE THEN 1 END)
      comment: "Count of climate risks classified as strategic priorities — executive attention metric for climate governance."
    - name: "avg_temperature_increase_estimate"
      expr: AVG(CAST(temperature_increase_estimate AS DOUBLE))
      comment: "Average temperature increase estimate across assessments — physical risk scenario metric for resilience planning."
    - name: "avg_sea_level_rise_estimate"
      expr: AVG(CAST(sea_level_rise_estimate AS DOUBLE))
      comment: "Average sea level rise estimate — coastal and flood risk metric for asset vulnerability assessment."
    - name: "regulatory_change_risk_count"
      expr: COUNT(CASE WHEN regulatory_change_indicator = TRUE THEN 1 END)
      comment: "Count of assessments identifying regulatory change as a risk driver — transition risk metric for compliance planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_social_value_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social value KPIs measuring monetised social outcomes, delivery volumes, and verification status — supports social value reporting for public sector contracts and ESG disclosure."
  source: "`vibe_construction_v1`.`sustainability`.`social_value_record`"
  dimensions:
    - name: "social_value_record_category"
      expr: social_value_record_category
      comment: "Category of social value outcome (employment, skills, community, environment) for portfolio analysis."
    - name: "social_value_record_status"
      expr: social_value_record_status
      comment: "Record status (Draft, Submitted, Verified) for data governance."
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status for assurance coverage of social value claims."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality flag for identifying records requiring remediation."
    - name: "reporting_period_start"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for annual social value performance trend analysis."
  measures:
    - name: "total_monetised_value"
      expr: SUM(CAST(monetised_value AS DOUBLE))
      comment: "Total monetised social value delivered — headline social impact metric for public sector contract compliance and ESG reporting."
    - name: "total_quantity_delivered"
      expr: SUM(CAST(quantity_delivered AS DOUBLE))
      comment: "Total quantity of social value outcomes delivered — volume metric for social programme effectiveness."
    - name: "avg_monetised_value_per_record"
      expr: AVG(CAST(monetised_value AS DOUBLE))
      comment: "Average monetised value per social value record — efficiency metric for social investment ROI analysis."
    - name: "verified_social_value"
      expr: SUM(CASE WHEN verification_status = 'Verified' THEN monetised_value ELSE 0 END)
      comment: "Total verified monetised social value — assurance-grade metric for public sector reporting and investor ESG disclosure."
    - name: "verification_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of social value records independently verified — data credibility metric for social value assurance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`sustainability_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability plan KPIs measuring target ambition, budget allocation, and plan coverage — drives sustainability programme governance and resource allocation decisions."
  source: "`vibe_construction_v1`.`sustainability`.`sustainability_plan`"
  dimensions:
    - name: "plan_type"
      expr: plan_type
      comment: "Type of sustainability plan (carbon, waste, water, biodiversity, social) for plan portfolio analysis."
    - name: "sustainability_plan_status"
      expr: sustainability_plan_status
      comment: "Current status of the plan (Draft, Approved, Active, Expired) for plan lifecycle management."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the plan for governance and sign-off tracking."
    - name: "plan_category"
      expr: plan_category
      comment: "Category of sustainability plan for thematic portfolio analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the plan for assurance coverage."
    - name: "effective_from"
      expr: DATE_TRUNC('year', effective_from)
      comment: "Plan effective year for cohort analysis of sustainability commitments."
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to sustainability plans — financial commitment metric for sustainability investment governance."
    - name: "total_carbon_reduction_target_tonnes"
      expr: SUM(CAST(carbon_reduction_target_tonnes AS DOUBLE))
      comment: "Total carbon reduction committed across all plans — aggregate decarbonisation ambition metric."
    - name: "avg_renewable_energy_target_pct"
      expr: AVG(CAST(renewable_energy_target_percent AS DOUBLE))
      comment: "Average renewable energy target percentage — clean energy transition ambition metric across the plan portfolio."
    - name: "avg_waste_diversion_target_pct"
      expr: AVG(CAST(waste_diversion_target_percent AS DOUBLE))
      comment: "Average waste diversion target — circular economy ambition metric for plan portfolio benchmarking."
    - name: "avg_water_use_reduction_target_pct"
      expr: AVG(CAST(water_use_reduction_target_percent AS DOUBLE))
      comment: "Average water use reduction target — water stewardship ambition metric for plan portfolio analysis."
    - name: "active_plan_count"
      expr: COUNT(CASE WHEN sustainability_plan_status = 'Active' THEN 1 END)
      comment: "Number of currently active sustainability plans — programme coverage metric for sustainability governance completeness."
$$;