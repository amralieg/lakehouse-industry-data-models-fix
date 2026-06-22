-- Metric views for domain: distribution | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_flow_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational flow telemetry metrics for the distribution network. Tracks volumetric throughput, pressure performance, data quality, and alarm rates across DMAs, meters, and pump stations. Core KPI layer for NRW analysis, hydraulic performance monitoring, and SCADA data governance."
  source: "`vibe_water_utilities_v1`.`distribution`.`flow_reading`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area identifier — primary grouping for zone-level flow analysis."
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of flow measurement (e.g., inlet, outlet, bulk supply) — used to segment supply vs. consumption flows."
    - name: "flow_direction"
      expr: flow_direction
      comment: "Direction of flow (forward/reverse) — critical for detecting backflow events and network anomalies."
    - name: "validation_status"
      expr: validation_status
      comment: "Data validation state of the reading — used to filter to verified data for regulatory and billing purposes."
    - name: "engineering_unit"
      expr: engineering_unit
      comment: "Unit of measure for the flow value (e.g., GPM, MGD) — ensures correct interpretation of volumetric KPIs."
    - name: "alarm_type"
      expr: alarm_type
      comment: "Category of alarm triggered on this reading — supports alarm pattern analysis and operational triage."
    - name: "reading_date"
      expr: DATE_TRUNC('day', reading_timestamp)
      comment: "Calendar day of the flow reading — enables daily trend analysis and minimum night flow profiling."
    - name: "reading_month"
      expr: DATE_TRUNC('month', reading_timestamp)
      comment: "Calendar month of the flow reading — supports monthly demand reporting and seasonal analysis."
    - name: "nrw_calculation_flag"
      expr: nrw_calculation_flag
      comment: "Indicates whether this reading is included in NRW (Non-Revenue Water) calculations — used to scope NRW-specific flow aggregations."
    - name: "billing_flag"
      expr: billing_flag
      comment: "Indicates whether this reading feeds into customer billing — used to separate revenue-generating flows from operational flows."
    - name: "estimated_flag"
      expr: estimated_flag
      comment: "Flags estimated readings — used to assess data confidence and proportion of estimated vs. measured volume."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Indicates a data quality issue on this reading — used to monitor SCADA data integrity."
  measures:
    - name: "total_flow_volume"
      expr: SUM(CAST(flow_value AS DOUBLE))
      comment: "Total volumetric flow across all readings in the selected period and grouping. Primary throughput KPI for supply-demand balancing and NRW computation."
    - name: "avg_flow_rate"
      expr: AVG(CAST(flow_value AS DOUBLE))
      comment: "Average flow rate per reading interval. Used to establish baseline demand profiles and detect anomalous consumption patterns."
    - name: "avg_pressure_psi"
      expr: AVG(CAST(pressure_psi AS DOUBLE))
      comment: "Average hydraulic pressure across readings. Key indicator of network pressure compliance against regulatory minimum and maximum thresholds."
    - name: "min_pressure_psi"
      expr: MIN(CAST(pressure_psi AS DOUBLE))
      comment: "Minimum recorded pressure in the period. Used to identify pressure deficit events that may indicate leakage, demand surge, or pump failure."
    - name: "max_flow_value"
      expr: MAX(CAST(flow_value AS DOUBLE))
      comment: "Peak flow value recorded in the period. Used for hydraulic capacity planning and peak demand management."
    - name: "total_nrw_flow_volume"
      expr: SUM(CASE WHEN nrw_calculation_flag = TRUE THEN CAST(flow_value AS DOUBLE) ELSE 0 END)
      comment: "Total flow volume flagged for NRW calculation. Feeds directly into Non-Revenue Water reporting and loss reduction programmes."
    - name: "alarm_reading_count"
      expr: COUNT(CASE WHEN alarm_flag = TRUE THEN 1 END)
      comment: "Number of readings that triggered an alarm condition. Operational KPI for network reliability and SCADA alert management."
    - name: "data_quality_issue_count"
      expr: COUNT(CASE WHEN data_quality_flag = TRUE THEN 1 END)
      comment: "Number of readings with a data quality flag. Governs confidence in volumetric KPIs and drives SCADA maintenance prioritisation."
    - name: "estimated_reading_count"
      expr: COUNT(CASE WHEN estimated_flag = TRUE THEN 1 END)
      comment: "Number of estimated (non-measured) readings. High values indicate meter or SCADA outages and reduce billing and NRW data accuracy."
    - name: "total_reading_count"
      expr: COUNT(1)
      comment: "Total number of flow readings in the period. Baseline denominator for alarm rate, estimation rate, and data quality rate calculations."
    - name: "avg_meter_accuracy_pct"
      expr: AVG(CAST(meter_accuracy_percent AS DOUBLE))
      comment: "Average meter accuracy percentage across readings. Directly impacts billing accuracy and NRW measurement confidence; drives meter replacement prioritisation."
    - name: "avg_interval_duration_minutes"
      expr: AVG(CAST(interval_duration_minutes AS DOUBLE))
      comment: "Average logging interval duration. Used to detect SCADA configuration drift and ensure consistent time-series resolution for hydraulic modelling."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_main_break`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Main break incident metrics for the distribution network. Tracks break frequency, repair performance, water loss, customer impact, and regulatory exposure. Core KPI layer for infrastructure risk management, capital investment prioritisation, and regulatory compliance reporting."
  source: "`vibe_water_utilities_v1`.`distribution`.`main_break`"
  dimensions:
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area where the break occurred — primary geographic grouping for infrastructure risk analysis."
    - name: "break_type"
      expr: break_type
      comment: "Classification of the break (e.g., circumferential, longitudinal, joint failure) — used to identify failure mode patterns and inform repair strategy."
    - name: "pipe_material"
      expr: pipe_material
      comment: "Material of the failed pipe — critical dimension for asset renewal planning and material-specific failure rate analysis."
    - name: "break_status"
      expr: break_status
      comment: "Current status of the break incident (e.g., open, repaired, closed) — used to track active incidents and backlog."
    - name: "priority_level"
      expr: priority_level
      comment: "Operational priority assigned to the break — used to assess response time compliance by priority tier."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause of the break (e.g., corrosion, ground movement, pressure surge) — drives targeted maintenance and capital investment decisions."
    - name: "repair_method"
      expr: repair_method
      comment: "Method used to repair the break — used to compare cost and durability of repair approaches."
    - name: "soil_condition"
      expr: soil_condition
      comment: "Soil condition at the break site — environmental risk factor for infrastructure deterioration modelling."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition at time of break — used to correlate break frequency with seasonal and climatic events."
    - name: "boil_water_advisory_issued"
      expr: boil_water_advisory_issued
      comment: "Indicates whether a boil water advisory was issued — flags public health impact events for regulatory and executive reporting."
    - name: "regulatory_report_required"
      expr: regulatory_report_required
      comment: "Indicates whether a regulatory report is required for this break — used to track compliance obligations."
    - name: "break_month"
      expr: DATE_TRUNC('month', break_timestamp)
      comment: "Calendar month of the break event — enables monthly trend analysis and seasonal break rate reporting."
    - name: "break_year"
      expr: DATE_TRUNC('year', break_timestamp)
      comment: "Calendar year of the break event — supports annual infrastructure performance benchmarking."
  measures:
    - name: "total_main_breaks"
      expr: COUNT(1)
      comment: "Total number of main break incidents. Primary infrastructure reliability KPI; tracked against industry benchmarks (breaks per 100 miles of main per year)."
    - name: "total_water_lost_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE))
      comment: "Total water lost due to main breaks. Directly quantifies physical loss contribution to NRW and informs loss reduction investment cases."
    - name: "avg_water_lost_per_break_gallons"
      expr: AVG(CAST(water_lost_gallons AS DOUBLE))
      comment: "Average water lost per break event. Used to assess severity trends and prioritise high-loss break types or zones for intervention."
    - name: "avg_repair_duration_hours"
      expr: AVG(CAST(repair_duration_hours AS DOUBLE))
      comment: "Average time to repair a main break. Key service level KPI; prolonged repairs increase customer impact, water loss, and regulatory risk."
    - name: "max_repair_duration_hours"
      expr: MAX(CAST(repair_duration_hours AS DOUBLE))
      comment: "Longest repair duration in the period. Identifies worst-case service restoration performance and outlier incidents requiring root cause review."
    - name: "total_population_at_risk"
      expr: SUM(CAST(population_at_risk AS DOUBLE))
      comment: "Total population exposed to service disruption from main breaks. Public health and regulatory risk KPI used in emergency response planning."
    - name: "avg_operating_pressure_at_break_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure at the time and location of breaks. Used to correlate pressure levels with break frequency and support pressure management decisions."
    - name: "boil_water_advisory_count"
      expr: COUNT(CASE WHEN boil_water_advisory_issued = TRUE THEN 1 END)
      comment: "Number of breaks that triggered a boil water advisory. Critical public health and regulatory KPI; directly reported to health authorities."
    - name: "regulatory_reportable_break_count"
      expr: COUNT(CASE WHEN regulatory_report_required = TRUE THEN 1 END)
      comment: "Number of breaks requiring regulatory reporting. Tracks compliance obligation volume and drives regulatory submission workflows."
    - name: "avg_pipe_diameter_at_break_inches"
      expr: AVG(CAST(pipe_diameter_inches AS DOUBLE))
      comment: "Average diameter of pipes that experienced breaks. Used to identify diameter-specific failure patterns and target renewal programmes."
    - name: "total_water_lost_million_gallons"
      expr: SUM(CAST(water_lost_gallons AS DOUBLE)) / 1000000.0
      comment: "Total water lost in million gallons — executive-level summary unit for NRW reporting and board-level infrastructure performance dashboards."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_dma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District Metered Area (DMA) performance and configuration metrics. Tracks NRW/UFW targets, pressure performance, network complexity, and leakage management readiness across the distribution network. Strategic KPI layer for zone-level loss reduction and infrastructure planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`dma`"
  dimensions:
    - name: "dma_status"
      expr: dma_status
      comment: "Operational status of the DMA (e.g., active, decommissioned, under review) — used to scope analysis to live zones."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality classification of the DMA — used to prioritise investment and operational attention on high-risk zones."
    - name: "scada_monitored_flag"
      expr: scada_monitored_flag
      comment: "Indicates whether the DMA has SCADA monitoring — used to assess telemetry coverage and identify monitoring gaps."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone the DMA belongs to — enables zone-level aggregation of DMA performance metrics."
    - name: "established_year"
      expr: DATE_TRUNC('year', established_date)
      comment: "Year the DMA was established — used to correlate DMA age with performance and leakage trends."
    - name: "last_leakage_survey_month"
      expr: DATE_TRUNC('month', last_leakage_survey_date)
      comment: "Month of the most recent leakage survey — used to identify DMAs overdue for survey and track survey programme progress."
  measures:
    - name: "total_dma_count"
      expr: COUNT(1)
      comment: "Total number of DMAs in scope. Baseline denominator for network coverage and monitoring gap analysis."
    - name: "avg_target_nrw_percentage"
      expr: AVG(CAST(target_nrw_percentage AS DOUBLE))
      comment: "Average NRW target percentage across DMAs. Benchmarks the ambition of the loss reduction programme and tracks alignment with regulatory commitments."
    - name: "avg_target_ufw_percentage"
      expr: AVG(CAST(target_ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water (UFW) target percentage across DMAs. Tracks the utility's commitment to reducing physical and commercial losses."
    - name: "avg_average_pressure_psi"
      expr: AVG(CAST(average_pressure_psi AS DOUBLE))
      comment: "Average pressure across DMAs. Used to assess network-wide pressure compliance and identify zones requiring pressure management intervention."
    - name: "total_main_length_miles"
      expr: SUM(CAST(main_length_miles AS DOUBLE))
      comment: "Total pipe main length across DMAs. Used to normalise break rates (breaks per 100 miles) and scale infrastructure investment requirements."
    - name: "avg_design_flow_mgd"
      expr: AVG(CAST(design_flow_mgd AS DOUBLE))
      comment: "Average design flow capacity across DMAs. Used to assess whether network capacity is aligned with current and projected demand."
    - name: "avg_minimum_night_flow_threshold_gpm"
      expr: AVG(CAST(minimum_night_flow_threshold_gpm AS DOUBLE))
      comment: "Average minimum night flow threshold across DMAs. This threshold is the primary leakage detection trigger; tracking it ensures thresholds are appropriately calibrated."
    - name: "scada_monitored_dma_count"
      expr: COUNT(CASE WHEN scada_monitored_flag = TRUE THEN 1 END)
      comment: "Number of DMAs with active SCADA monitoring. Tracks telemetry coverage — unmonitored DMAs have blind spots for leakage detection and NRW calculation."
    - name: "total_design_flow_mgd"
      expr: SUM(CAST(design_flow_mgd AS DOUBLE))
      comment: "Total design flow capacity across all DMAs. Used for network-wide capacity planning and supply-demand gap analysis."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pressure_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pressure zone performance metrics covering demand, storage, NRW/UFW losses, and hydraulic design compliance. Strategic KPI layer for pressure management, capacity planning, and regulatory performance reporting."
  source: "`vibe_water_utilities_v1`.`distribution`.`pressure_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of pressure zone (e.g., high, medium, low pressure) — used to segment hydraulic performance analysis by zone tier."
    - name: "zone_code"
      expr: zone_code
      comment: "Unique zone code — used as a business-friendly identifier for zone-level reporting and cross-system reconciliation."
    - name: "zone_name"
      expr: zone_name
      comment: "Human-readable zone name — used in executive dashboards and regulatory submissions."
    - name: "operational_status_band"
      expr: CASE WHEN operational_status >= 1.0 THEN 'Fully Operational' WHEN operational_status >= 0.5 THEN 'Partially Operational' ELSE 'Non-Operational' END
      comment: "Banded operational status of the pressure zone — used to quickly identify zones with degraded service capability."
    - name: "commissioning_year"
      expr: DATE_TRUNC('year', commissioning_date)
      comment: "Year the pressure zone was commissioned — used to correlate zone age with NRW performance and infrastructure condition."
    - name: "last_boundary_review_year"
      expr: DATE_TRUNC('year', last_boundary_review_date)
      comment: "Year of the last boundary review — used to identify zones with outdated hydraulic boundaries that may affect NRW accuracy."
  measures:
    - name: "total_pressure_zones"
      expr: COUNT(1)
      comment: "Total number of pressure zones. Baseline count for network topology reporting and coverage analysis."
    - name: "avg_nrw_percentage"
      expr: AVG(CAST(nrw_percentage AS DOUBLE))
      comment: "Average Non-Revenue Water percentage across pressure zones. Primary loss performance KPI; tracked against regulatory targets and industry benchmarks."
    - name: "avg_ufw_percentage"
      expr: AVG(CAST(ufw_percentage AS DOUBLE))
      comment: "Average Unaccounted-For Water percentage across pressure zones. Tracks physical and commercial loss performance; drives investment in metering and leakage control."
    - name: "total_average_daily_demand_mgd"
      expr: SUM(CAST(average_daily_demand_mgd AS DOUBLE))
      comment: "Total average daily demand across all pressure zones in MGD. Core supply planning KPI used for treatment capacity and source water allocation decisions."
    - name: "total_peak_hour_demand_mgd"
      expr: SUM(CAST(peak_hour_demand_mgd AS DOUBLE))
      comment: "Total peak hour demand across all pressure zones in MGD. Used for hydraulic model calibration and infrastructure sizing to meet peak demand events."
    - name: "total_storage_capacity_mg"
      expr: SUM(CAST(storage_capacity_mg AS DOUBLE))
      comment: "Total storage capacity across pressure zones in million gallons. Used to assess system resilience, emergency supply duration, and fire flow reserve adequacy."
    - name: "avg_design_pressure_psi"
      expr: AVG(CAST(design_pressure_psi AS DOUBLE))
      comment: "Average design pressure across zones. Used to assess whether operating pressures are within design parameters and identify over/under-pressurised zones."
    - name: "avg_residual_pressure_fire_psi"
      expr: AVG(CAST(residual_pressure_fire_psi AS DOUBLE))
      comment: "Average residual pressure available during fire flow events. Regulatory compliance KPI — must meet minimum fire flow pressure standards."
    - name: "total_service_area_sq_mi"
      expr: SUM(CAST(service_area_sq_mi AS DOUBLE))
      comment: "Total service area covered by pressure zones in square miles. Used to normalise demand and loss metrics by geographic coverage."
    - name: "avg_target_pressure_max_psi"
      expr: AVG(CAST(target_pressure_max_psi AS DOUBLE))
      comment: "Average maximum target pressure across zones. Used to assess pressure management programme ambition and compliance with leakage-reduction pressure targets."
    - name: "avg_target_pressure_min_psi"
      expr: AVG(CAST(target_pressure_min_psi AS DOUBLE))
      comment: "Average minimum target pressure across zones. Ensures service pressure standards are maintained for all customers within each zone."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pipe_main`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipe main asset metrics covering network length, hydraulic capacity, condition, and renewal readiness. Strategic KPI layer for capital investment planning, risk-based asset management, and infrastructure performance reporting."
  source: "`vibe_water_utilities_v1`.`distribution`.`pipe_main`"
  dimensions:
    - name: "material"
      expr: material
      comment: "Pipe material (e.g., cast iron, ductile iron, PVC, HDPE) — primary dimension for material-specific failure rate and renewal prioritisation analysis."
    - name: "pipe_type"
      expr: pipe_type
      comment: "Functional type of the pipe (e.g., transmission, distribution, service) — used to segment capacity and condition metrics by network tier."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Asset lifecycle stage (e.g., active, decommissioned, planned renewal) — used to scope analysis to in-service assets and track renewal pipeline."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality classification of the pipe — used to prioritise inspection, maintenance, and renewal investment on high-consequence assets."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade from inspection — used to identify pipes approaching end of serviceable life and requiring capital intervention."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the pipe belongs to — enables zone-level aggregation of network length and condition metrics."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone the pipe belongs to — used to aggregate hydraulic capacity and condition by pressure zone."
    - name: "cathodic_protection_flag"
      expr: cathodic_protection_flag
      comment: "Indicates whether cathodic protection is installed — used to assess corrosion risk mitigation coverage across the metallic pipe network."
    - name: "fire_flow_capable_flag"
      expr: fire_flow_capable_flag
      comment: "Indicates whether the pipe can support fire flow requirements — used to assess fire protection coverage across the network."
    - name: "installation_decade"
      expr: FLOOR(YEAR(installation_date) / 10) * 10
      comment: "Decade of pipe installation — used to profile the age distribution of the network and identify cohorts approaching end of life."
    - name: "last_inspection_year"
      expr: DATE_TRUNC('year', last_inspection_date)
      comment: "Year of last inspection — used to identify pipes overdue for condition assessment."
  measures:
    - name: "total_pipe_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total pipe main length in feet. Primary network scale KPI used to normalise break rates, inspection coverage, and renewal investment per unit length."
    - name: "avg_pipe_length_feet"
      expr: AVG(CAST(length_feet AS DOUBLE))
      comment: "Average pipe segment length in feet. Used to assess network segmentation granularity and isolation valve spacing adequacy."
    - name: "total_pipe_count"
      expr: COUNT(1)
      comment: "Total number of pipe main segments. Baseline count for network inventory reporting and inspection programme sizing."
    - name: "avg_nominal_diameter_inches"
      expr: AVG(CAST(nominal_diameter_inches AS DOUBLE))
      comment: "Average nominal pipe diameter in inches. Used to assess network capacity profile and identify under-sized mains constraining flow."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across pipe mains. Used to identify over-pressurised segments that accelerate deterioration and increase break risk."
    - name: "avg_hazen_williams_c_factor"
      expr: AVG(CAST(hazen_williams_c_factor AS DOUBLE))
      comment: "Average Hazen-Williams C-factor (hydraulic roughness coefficient). Declining C-factors indicate internal deterioration and increased head loss — drives lining and replacement decisions."
    - name: "total_max_flow_capacity_gpm"
      expr: SUM(CAST(max_flow_capacity_gpm AS DOUBLE))
      comment: "Total maximum flow capacity across pipe mains in GPM. Used to assess network-wide hydraulic capacity headroom against peak demand requirements."
    - name: "avg_average_daily_flow_gpm"
      expr: AVG(CAST(average_daily_flow_gpm AS DOUBLE))
      comment: "Average daily flow per pipe segment in GPM. Used to identify heavily loaded mains and assess utilisation against design capacity."
    - name: "cathodic_protected_pipe_count"
      expr: COUNT(CASE WHEN cathodic_protection_flag = TRUE THEN 1 END)
      comment: "Number of pipe segments with cathodic protection installed. Used to track corrosion protection coverage and identify unprotected metallic pipe at elevated corrosion risk."
    - name: "fire_flow_capable_pipe_count"
      expr: COUNT(CASE WHEN fire_flow_capable_flag = TRUE THEN 1 END)
      comment: "Number of pipe segments capable of supporting fire flow. Used to assess fire protection network coverage and identify gaps requiring upsizing."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_storage_tank`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage tank asset and capacity metrics. Tracks total and usable storage capacity, emergency and fire flow reserves, condition, and inspection compliance. Strategic KPI layer for system resilience, regulatory compliance, and capital planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`storage_tank`"
  dimensions:
    - name: "tank_type"
      expr: tank_type
      comment: "Type of storage tank (e.g., elevated, ground-level, standpipe) — used to segment capacity and condition metrics by tank configuration."
    - name: "tank_material"
      expr: tank_material
      comment: "Construction material of the tank — used to assess material-specific deterioration risk and maintenance requirements."
    - name: "structural_condition"
      expr: structural_condition
      comment: "Structural condition rating of the tank — primary asset health indicator driving inspection and rehabilitation investment decisions."
    - name: "coating_condition"
      expr: coating_condition
      comment: "Condition of the tank coating — deteriorated coatings increase contamination risk and accelerate structural degradation."
    - name: "regulatory_inspection_status"
      expr: regulatory_inspection_status
      comment: "Status of regulatory inspection compliance — used to track and report inspection obligations to regulators."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification of the tank (e.g., utility-owned, leased) — used to scope capital investment and maintenance responsibility."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served by the tank — enables zone-level storage capacity and resilience analysis."
    - name: "mixing_system_installed"
      expr: mixing_system_installed
      comment: "Indicates whether a mixing system is installed — tanks without mixing are at higher risk of water quality issues (stratification, disinfectant decay)."
    - name: "security_system_installed"
      expr: security_system_installed
      comment: "Indicates whether a security system is installed — used to assess physical security compliance across the storage asset portfolio."
    - name: "last_inspection_year"
      expr: DATE_TRUNC('year', last_inspection_date)
      comment: "Year of last inspection — used to identify tanks overdue for regulatory inspection."
  measures:
    - name: "total_capacity_gallons"
      expr: SUM(CAST(capacity_gallons AS DOUBLE))
      comment: "Total gross storage capacity across all tanks in gallons. Primary system resilience KPI — used to assess days of supply reserve and emergency response capability."
    - name: "total_usable_capacity_gallons"
      expr: SUM(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Total usable (operational) storage capacity in gallons. More accurate than gross capacity for supply planning — excludes dead storage and structural reserves."
    - name: "total_emergency_storage_gallons"
      expr: SUM(CAST(emergency_storage_gallons AS DOUBLE))
      comment: "Total emergency storage reserve across all tanks in gallons. Regulatory and resilience KPI — must meet minimum emergency supply duration requirements."
    - name: "total_fire_flow_reserve_gallons"
      expr: SUM(CAST(fire_flow_reserve_gallons AS DOUBLE))
      comment: "Total fire flow reserve storage across all tanks in gallons. Regulatory compliance KPI — must meet fire authority minimum reserve requirements."
    - name: "total_capacity_million_gallons"
      expr: SUM(CAST(capacity_million_gallons AS DOUBLE))
      comment: "Total gross storage capacity in million gallons — executive-level summary unit for board reporting and regulatory submissions."
    - name: "avg_usable_capacity_gallons"
      expr: AVG(CAST(usable_capacity_gallons AS DOUBLE))
      comment: "Average usable capacity per tank in gallons. Used to assess tank sizing adequacy relative to zone demand and identify under-sized assets."
    - name: "total_tank_count"
      expr: COUNT(1)
      comment: "Total number of storage tanks. Baseline count for asset inventory and inspection programme management."
    - name: "mixing_system_installed_count"
      expr: COUNT(CASE WHEN mixing_system_installed = TRUE THEN 1 END)
      comment: "Number of tanks with mixing systems installed. Used to track water quality risk mitigation coverage — tanks without mixing are prioritised for retrofit."
    - name: "security_system_installed_count"
      expr: COUNT(CASE WHEN security_system_installed = TRUE THEN 1 END)
      comment: "Number of tanks with security systems installed. Tracks physical security compliance across the storage portfolio."
    - name: "avg_maximum_operating_level_feet"
      expr: AVG(CAST(maximum_operating_level_feet AS DOUBLE))
      comment: "Average maximum operating level across tanks in feet. Used to assess hydraulic head availability and pressure zone service level adequacy."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_pump_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pump station asset and capacity metrics. Tracks pumping capacity, backup power resilience, SCADA integration, and operational readiness across the distribution network. Strategic KPI layer for energy management, resilience planning, and capital investment decisions."
  source: "`vibe_water_utilities_v1`.`distribution`.`pump_station`"
  dimensions:
    - name: "station_type"
      expr: station_type
      comment: "Type of pump station (e.g., booster, transfer, raw water) — used to segment capacity and performance metrics by operational function."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality classification of the pump station — used to prioritise maintenance, redundancy investment, and emergency response planning."
    - name: "asset_condition_rating"
      expr: asset_condition_rating
      comment: "Overall condition rating of the pump station — primary asset health indicator driving rehabilitation and replacement investment decisions."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification (e.g., utility-owned, leased) — used to scope capital investment and maintenance responsibility."
    - name: "backup_generator_available"
      expr: backup_generator_available
      comment: "Indicates whether a backup generator is available — critical resilience indicator for service continuity during power outages."
    - name: "vfd_equipped"
      expr: vfd_equipped
      comment: "Indicates whether the station has Variable Frequency Drives installed — VFD-equipped stations have significantly lower energy costs and better pressure control."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone served by the pump station — enables zone-level pumping capacity and resilience analysis."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area served by the pump station — used for zone-level operational analysis."
    - name: "power_supply_phase"
      expr: power_supply_phase
      comment: "Electrical supply phase configuration — used to assess power infrastructure risk and energy management opportunities."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the pump station was installed — used to profile asset age distribution and identify stations approaching end of design life."
  measures:
    - name: "total_design_flow_capacity_mgd"
      expr: SUM(CAST(design_flow_capacity_mgd AS DOUBLE))
      comment: "Total pumping capacity across all stations in MGD. Primary capacity planning KPI — must exceed peak demand to ensure service continuity."
    - name: "avg_design_flow_capacity_mgd"
      expr: AVG(CAST(design_flow_capacity_mgd AS DOUBLE))
      comment: "Average pumping capacity per station in MGD. Used to assess station sizing adequacy relative to zone demand."
    - name: "total_design_flow_capacity_gpm"
      expr: SUM(CAST(design_flow_capacity_gpm AS DOUBLE))
      comment: "Total pumping capacity across all stations in GPM. Operational-level capacity KPI used for hydraulic model validation and peak demand management."
    - name: "avg_discharge_pressure_psi"
      expr: AVG(CAST(discharge_pressure_psi AS DOUBLE))
      comment: "Average discharge pressure across pump stations. Used to assess whether stations are delivering required system pressures and identify under-performing assets."
    - name: "avg_total_dynamic_head_ft"
      expr: AVG(CAST(total_dynamic_head_ft AS DOUBLE))
      comment: "Average total dynamic head across pump stations in feet. Key hydraulic efficiency indicator — high TDH relative to design indicates system resistance issues or pump wear."
    - name: "total_pump_station_count"
      expr: COUNT(1)
      comment: "Total number of pump stations. Baseline count for asset inventory and maintenance programme management."
    - name: "backup_generator_available_count"
      expr: COUNT(CASE WHEN backup_generator_available = TRUE THEN 1 END)
      comment: "Number of pump stations with backup generator capability. Resilience KPI — stations without backup power are a single point of failure during grid outages."
    - name: "vfd_equipped_station_count"
      expr: COUNT(CASE WHEN vfd_equipped = TRUE THEN 1 END)
      comment: "Number of pump stations equipped with Variable Frequency Drives. Energy efficiency KPI — VFD penetration rate directly impacts energy cost reduction programme performance."
    - name: "avg_backup_generator_capacity_kw"
      expr: AVG(CAST(backup_generator_capacity_kw AS DOUBLE))
      comment: "Average backup generator capacity in kW across equipped stations. Used to assess whether backup power is adequately sized to run critical pumping loads during outages."
    - name: "avg_suction_pressure_psi"
      expr: AVG(CAST(suction_pressure_psi AS DOUBLE))
      comment: "Average suction pressure across pump stations. Low suction pressure indicates supply-side constraints or cavitation risk — drives upstream network and storage investment."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service line asset metrics covering material composition, LCRR compliance, connection status, and replacement programme performance. Strategic KPI layer for lead service line replacement tracking, regulatory compliance (LCRR/LCR), and customer risk management."
  source: "`vibe_water_utilities_v1`.`distribution`.`service_line`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Material of the service line (e.g., lead, galvanised, copper, plastic) — primary dimension for LCRR compliance and public health risk assessment."
    - name: "connection_status"
      expr: connection_status
      comment: "Current connection status of the service line (e.g., active, inactive, abandoned) — used to scope analysis to live connections."
    - name: "lcrr_classification"
      expr: lcrr_classification
      comment: "Lead and Copper Rule Revision (LCRR) classification of the service line — regulatory dimension for lead service line inventory and replacement reporting."
    - name: "lcrr_inventory_verified"
      expr: lcrr_inventory_verified
      comment: "Indicates whether the LCRR inventory classification has been verified — tracks regulatory inventory completion obligation."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the service line (utility vs. customer side) — determines replacement programme responsibility and funding eligibility."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (e.g., residential, commercial, fire) — used to segment replacement programme by customer class."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the service line is in — enables zone-level LCRR compliance and replacement programme tracking."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone the service line is in — used for zone-level service line condition and compliance analysis."
    - name: "curb_stop_installed"
      expr: curb_stop_installed
      comment: "Indicates whether a curb stop is installed — used to assess isolation capability and emergency shut-off readiness."
    - name: "installation_decade"
      expr: FLOOR(YEAR(installation_date) / 10) * 10
      comment: "Decade of service line installation — used to profile age distribution and identify cohorts at highest replacement priority."
  measures:
    - name: "total_service_line_count"
      expr: COUNT(1)
      comment: "Total number of service lines. Baseline inventory count for LCRR compliance reporting and replacement programme sizing."
    - name: "total_service_line_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total service line length in feet. Used to estimate replacement programme cost and scope capital investment requirements."
    - name: "lcrr_verified_count"
      expr: COUNT(CASE WHEN lcrr_inventory_verified = TRUE THEN 1 END)
      comment: "Number of service lines with verified LCRR inventory classification. Tracks progress against the regulatory obligation to complete the lead service line inventory."
    - name: "lcrr_unverified_count"
      expr: COUNT(CASE WHEN lcrr_inventory_verified = FALSE OR lcrr_inventory_verified IS NULL THEN 1 END)
      comment: "Number of service lines with unverified LCRR classification. Represents outstanding regulatory compliance risk — unverified lines must be treated as lead until proven otherwise."
    - name: "curb_stop_installed_count"
      expr: COUNT(CASE WHEN curb_stop_installed = TRUE THEN 1 END)
      comment: "Number of service lines with curb stops installed. Tracks isolation capability — lines without curb stops cannot be individually shut off, increasing repair and emergency response complexity."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average service line diameter in inches. Used to assess flow capacity adequacy and identify under-sized connections constraining customer supply."
    - name: "avg_tap_size_inches"
      expr: AVG(CAST(tap_size_inches AS DOUBLE))
      comment: "Average tap size in inches. Used to assess connection capacity and identify taps that may be constraining customer flow."
    - name: "distinct_material_type_count"
      expr: COUNT(DISTINCT material_type)
      comment: "Number of distinct service line materials in the inventory. Used to assess inventory complexity and prioritise material-specific replacement programmes."
    - name: "active_service_line_count"
      expr: COUNT(CASE WHEN connection_status = 'Active' THEN 1 END)
      comment: "Number of active service line connections. Used to track the live customer connection base and scope replacement programme impact."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_hydrant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fire hydrant asset metrics covering flow capacity, inspection compliance, operational readiness, and flushing programme performance. Strategic KPI layer for fire protection service level management, regulatory compliance, and asset renewal planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`hydrant`"
  dimensions:
    - name: "hydrant_type"
      expr: hydrant_type
      comment: "Type of hydrant (e.g., dry barrel, wet barrel, post) — used to segment maintenance and performance metrics by hydrant design."
    - name: "condition_status"
      expr: condition_status
      comment: "Current condition status of the hydrant — primary asset health indicator for maintenance prioritisation and replacement planning."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality classification of the hydrant — used to prioritise inspection and maintenance on hydrants serving high-risk areas."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership of the hydrant (utility vs. fire authority vs. private) — determines maintenance responsibility and replacement funding."
    - name: "flow_class_color"
      expr: flow_class_color
      comment: "NFPA flow class colour code (e.g., blue, green, orange, red) — standardised fire flow capacity classification used by fire authorities."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the hydrant is in — enables zone-level fire protection coverage analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone the hydrant is in — used to assess fire flow pressure adequacy by zone."
    - name: "flushing_program_flag"
      expr: flushing_program_flag
      comment: "Indicates whether the hydrant is included in the flushing programme — used to track flushing coverage and water quality maintenance."
    - name: "last_inspection_year"
      expr: DATE_TRUNC('year', last_inspection_date)
      comment: "Year of last inspection — used to identify hydrants overdue for inspection and track inspection programme compliance."
    - name: "last_flow_test_year"
      expr: DATE_TRUNC('year', last_flow_test_date)
      comment: "Year of last flow test — used to identify hydrants with outdated flow test data that may not meet current fire flow requirements."
  measures:
    - name: "total_hydrant_count"
      expr: COUNT(1)
      comment: "Total number of hydrants in the network. Baseline inventory count for fire protection coverage analysis and inspection programme management."
    - name: "avg_static_pressure_psi"
      expr: AVG(CAST(static_pressure_psi AS DOUBLE))
      comment: "Average static pressure at hydrants in PSI. Used to assess network pressure adequacy for fire protection and identify low-pressure zones requiring intervention."
    - name: "avg_residual_pressure_psi"
      expr: AVG(CAST(residual_pressure_psi AS DOUBLE))
      comment: "Average residual pressure during flow test in PSI. Regulatory compliance KPI — must meet minimum residual pressure standards during fire flow events."
    - name: "avg_main_diameter_inches"
      expr: AVG(CAST(main_diameter_inches AS DOUBLE))
      comment: "Average diameter of the main supplying each hydrant in inches. Used to identify hydrants on under-sized mains that may not deliver adequate fire flow."
    - name: "flushing_program_hydrant_count"
      expr: COUNT(CASE WHEN flushing_program_flag = TRUE THEN 1 END)
      comment: "Number of hydrants included in the flushing programme. Tracks water quality maintenance coverage — unflushed hydrants accumulate sediment and degrade water quality."
    - name: "avg_bury_depth_feet"
      expr: AVG(CAST(bury_depth_feet AS DOUBLE))
      comment: "Average hydrant bury depth in feet. Used to assess frost protection adequacy and identify hydrants at risk of freeze damage in cold climates."
    - name: "avg_valve_turns_to_open"
      expr: AVG(CAST(valve_turns_to_open AS DOUBLE))
      comment: "Average number of turns required to open hydrant valves. Increasing turns indicate valve deterioration — used to prioritise exercising and replacement programmes."
    - name: "distinct_pressure_zones_served"
      expr: COUNT(DISTINCT pressure_zone_id)
      comment: "Number of distinct pressure zones with hydrant coverage. Used to assess fire protection geographic coverage and identify zones with inadequate hydrant density."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`distribution_network_valve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network valve asset metrics covering operational readiness, exercising compliance, condition, and isolation capability. Strategic KPI layer for network resilience, maintenance programme management, and emergency response planning."
  source: "`vibe_water_utilities_v1`.`distribution`.`network_valve`"
  dimensions:
    - name: "valve_type"
      expr: valve_type
      comment: "Type of valve (e.g., gate, butterfly, ball, PRV) — used to segment maintenance and performance metrics by valve design."
    - name: "valve_function"
      expr: valve_function
      comment: "Functional role of the valve (e.g., isolation, pressure reducing, check) — used to prioritise maintenance by operational criticality."
    - name: "condition_rating"
      expr: condition_rating
      comment: "Condition rating of the valve — primary asset health indicator for maintenance prioritisation and replacement planning."
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality classification of the valve — used to prioritise exercising and replacement on valves serving high-consequence network segments."
    - name: "current_position"
      expr: current_position
      comment: "Current operational position of the valve (e.g., open, closed, partially open) — used to identify valves in non-normal positions that may affect network performance."
    - name: "normal_position"
      expr: normal_position
      comment: "Normal operational position of the valve — used to identify valves that are not in their normal position, indicating a potential network configuration issue."
    - name: "is_motorized"
      expr: is_motorized
      comment: "Indicates whether the valve is motorised (remotely operable) — motorised valves enable faster emergency isolation and reduce field crew response time."
    - name: "is_buried"
      expr: is_buried
      comment: "Indicates whether the valve is buried — buried valves have higher access costs and are more difficult to exercise and inspect."
    - name: "dma_id"
      expr: dma_id
      comment: "District Metered Area the valve is in — enables zone-level isolation capability and maintenance compliance analysis."
    - name: "pressure_zone_id"
      expr: pressure_zone_id
      comment: "Pressure zone the valve is in — used to assess isolation capability and pressure management coverage by zone."
    - name: "last_exercised_year"
      expr: DATE_TRUNC('year', last_exercised_date)
      comment: "Year the valve was last exercised — used to identify valves overdue for exercising and track programme compliance."
  measures:
    - name: "total_valve_count"
      expr: COUNT(1)
      comment: "Total number of network valves. Baseline inventory count for exercising programme management and isolation capability assessment."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average valve diameter in inches. Used to assess the size profile of the valve population and estimate exercising effort and replacement cost."
    - name: "avg_operating_pressure_psi"
      expr: AVG(CAST(operating_pressure_psi AS DOUBLE))
      comment: "Average operating pressure across network valves in PSI. Used to identify valves operating above pressure rating — a safety and reliability risk."
    - name: "avg_pressure_rating_psi"
      expr: AVG(CAST(pressure_rating_psi AS DOUBLE))
      comment: "Average pressure rating across network valves in PSI. Used to assess whether the valve population is adequately rated for current and future operating pressures."
    - name: "motorized_valve_count"
      expr: COUNT(CASE WHEN is_motorized = TRUE THEN 1 END)
      comment: "Number of motorised (remotely operable) valves. Resilience KPI — higher motorised valve penetration enables faster emergency isolation and reduces service disruption duration."
    - name: "buried_valve_count"
      expr: COUNT(CASE WHEN is_buried = TRUE THEN 1 END)
      comment: "Number of buried valves. Used to estimate access cost for exercising and inspection programmes and identify candidates for valve box installation."
    - name: "distinct_dmas_with_valves"
      expr: COUNT(DISTINCT dma_id)
      comment: "Number of distinct DMAs with network valves. Used to assess isolation capability coverage across the distribution network."
    - name: "avg_operational_status"
      expr: AVG(CAST(operational_status AS DOUBLE))
      comment: "Average operational status score across network valves. Aggregate health indicator for the valve population — declining scores indicate deteriorating isolation capability."
$$;