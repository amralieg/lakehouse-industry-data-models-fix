-- Metric views for domain: wastewater | Business: Water_Utilities | Version: 2 | Generated on: 2026-06-22 20:08:50

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_wwtp`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for Wastewater Treatment Plants (WWTPs) covering capacity utilization, energy efficiency, compliance posture, and operational readiness. Used by utility executives and operations leadership to steer capital investment, permit renewals, and treatment performance."
  source: "`vibe_water_utilities_v1`.`wastewater`.`wwtp`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the wastewater treatment facility for plant-level reporting."
    - name: "facility_type"
      expr: facility_type
      comment: "Type of WWTP facility (e.g., activated sludge, lagoon) for technology-segment analysis."
    - name: "treatment_level"
      expr: treatment_level
      comment: "Level of treatment applied (primary, secondary, tertiary) — key regulatory and quality dimension."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current regulatory compliance status of the plant — critical for permit and enforcement tracking."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory body or jurisdiction governing the plant — used for multi-jurisdiction reporting."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the WWTP is located — geographic grouping for regional analysis."
    - name: "city"
      expr: city
      comment: "City where the WWTP is located — sub-regional geographic dimension."
    - name: "disinfection_method"
      expr: disinfection_method
      comment: "Disinfection technology used (e.g., UV, chlorination) — relevant for treatment quality and cost benchmarking."
    - name: "biosolids_management_method"
      expr: biosolids_management_method
      comment: "Method used to manage biosolids output — environmental compliance and cost dimension."
    - name: "biosolids_class"
      expr: biosolids_class
      comment: "EPA biosolids classification (Class A or Class B) — regulatory and reuse eligibility dimension."
    - name: "operator_certification_level"
      expr: operator_certification_level
      comment: "Certification level of the plant operator — workforce compliance and risk dimension."
    - name: "receiving_water_classification"
      expr: receiving_water_classification
      comment: "Classification of the receiving water body — drives effluent limit stringency and environmental risk."
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the plant was commissioned — used for asset age cohort analysis."
    - name: "last_inspection_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of the most recent plant inspection — used to identify plants overdue for inspection."
    - name: "permit_expiration_year"
      expr: YEAR(permit_expiration_date)
      comment: "Year the operating permit expires — used for permit renewal pipeline management."
  measures:
    - name: "total_wwtp_count"
      expr: COUNT(1)
      comment: "Total number of wastewater treatment plants in the portfolio. Baseline measure for fleet sizing and capacity planning."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total permitted design treatment capacity in million gallons per day (MGD) across all WWTPs. Drives capital investment and growth planning decisions."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total actual average daily flow processed across all WWTPs in MGD. Compared against design capacity to assess system loading."
    - name: "avg_capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_flow_mgd AS DOUBLE) / NULLIF(CAST(design_capacity_mgd AS DOUBLE), 0)), 2)
      comment: "Average capacity utilization percentage across WWTPs (actual flow / design capacity). A critical executive KPI — values above 80% signal capacity risk; values below 40% may indicate over-investment."
    - name: "total_peak_flow_mgd"
      expr: SUM(CAST(peak_flow_mgd AS DOUBLE))
      comment: "Total peak flow capacity across all WWTPs in MGD. Used for wet-weather and storm event capacity planning."
    - name: "avg_energy_consumption_kwh_per_mg"
      expr: AVG(CAST(energy_consumption_kwh_per_mg AS DOUBLE))
      comment: "Average energy intensity in kWh per million gallons treated. Key operational efficiency KPI — drives energy cost reduction and sustainability programs."
    - name: "non_compliant_wwtp_count"
      expr: COUNT(CASE WHEN LOWER(compliance_status) NOT IN ('compliant', 'in compliance') THEN 1 END)
      comment: "Number of WWTPs currently out of compliance. A critical risk KPI — non-compliance triggers regulatory enforcement, fines, and public health risk."
    - name: "permit_expiring_within_1yr_count"
      expr: COUNT(CASE WHEN permit_expiration_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of WWTPs with operating permits expiring within the next 12 months. Drives permit renewal workload planning and regulatory risk management."
    - name: "operator_cert_required_count"
      expr: COUNT(CASE WHEN operator_certification_required = TRUE THEN 1 END)
      comment: "Number of WWTPs requiring certified operators. Used for workforce compliance planning and staffing risk assessment."
    - name: "avg_effluent_discharge_point"
      expr: AVG(CAST(effluent_discharge_point AS DOUBLE))
      comment: "Average effluent discharge point value across WWTPs. Monitors effluent quality trends relative to permit limits."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewer_network`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and infrastructure KPIs for the sewer network (pipes and segments). Covers capacity utilization, asset condition, risk exposure, and replacement cost. Used by asset managers, operations directors, and capital planning teams."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewer_network`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of sewer segment (e.g., gravity main, force main, lateral) — primary classification for network analysis."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Structural condition grade of the sewer segment — drives rehabilitation prioritization and capital planning."
    - name: "criticality_score"
      expr: criticality_score
      comment: "Criticality score of the segment — used to prioritize maintenance and capital investment on high-consequence assets."
    - name: "lining_type"
      expr: lining_type
      comment: "Type of pipe lining applied — used for rehabilitation tracking and material performance benchmarking."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership classification (public, private, easement) — relevant for maintenance responsibility and capital allocation."
    - name: "traffic_impact_level"
      expr: traffic_impact_level
      comment: "Level of traffic impact associated with the segment — used for scheduling maintenance and managing community disruption."
    - name: "installation_year"
      expr: installation_year
      comment: "Year the sewer segment was installed — used for asset age cohort analysis and renewal forecasting."
    - name: "fog_risk_flag"
      expr: fog_risk_flag
      comment: "Indicates whether the segment has fats, oils, and grease (FOG) risk — drives targeted cleaning and inspection programs."
    - name: "hydrogen_sulfide_risk_flag"
      expr: hydrogen_sulfide_risk_flag
      comment: "Indicates hydrogen sulfide corrosion risk — drives accelerated inspection and lining programs for at-risk segments."
    - name: "root_intrusion_flag"
      expr: root_intrusion_flag
      comment: "Indicates root intrusion presence — used to prioritize cleaning and rehabilitation work orders."
    - name: "easement_required_flag"
      expr: easement_required_flag
      comment: "Indicates whether an easement is required for access — affects maintenance scheduling and legal coordination."
    - name: "last_inspection_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of the most recent inspection — used to identify segments overdue for inspection."
    - name: "next_inspection_due_year"
      expr: YEAR(next_inspection_due_date)
      comment: "Year the next inspection is due — used for inspection scheduling and compliance planning."
    - name: "lining_installation_year"
      expr: YEAR(lining_installation_date)
      comment: "Year lining was installed — used to track lining age and plan re-lining programs."
  measures:
    - name: "total_segment_count"
      expr: COUNT(1)
      comment: "Total number of sewer network segments. Baseline measure for network inventory and coverage reporting."
    - name: "total_network_length_feet"
      expr: SUM(CAST(length_feet AS DOUBLE))
      comment: "Total length of sewer network in feet. Core infrastructure scale metric used for asset management and capital planning."
    - name: "total_replacement_cost_usd"
      expr: SUM(CAST(replacement_cost_usd AS DOUBLE))
      comment: "Total estimated replacement cost of the sewer network in USD. Critical capital planning KPI — drives long-term infrastructure investment strategy."
    - name: "avg_replacement_cost_per_foot_usd"
      expr: ROUND(SUM(CAST(replacement_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(length_feet AS DOUBLE)), 0), 2)
      comment: "Average replacement cost per linear foot of sewer pipe in USD. Benchmarking KPI for capital efficiency and contractor performance."
    - name: "total_design_capacity_mgd"
      expr: SUM(CAST(design_capacity_mgd AS DOUBLE))
      comment: "Total design flow capacity of the sewer network in MGD. Used to assess system-wide hydraulic capacity against current and projected flows."
    - name: "total_average_daily_flow_mgd"
      expr: SUM(CAST(average_daily_flow_mgd AS DOUBLE))
      comment: "Total actual average daily flow through the sewer network in MGD. Compared against design capacity to identify overloaded segments."
    - name: "avg_flow_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(average_daily_flow_mgd AS DOUBLE) / NULLIF(CAST(design_capacity_mgd AS DOUBLE), 0)), 2)
      comment: "Average hydraulic utilization percentage across sewer segments (actual flow / design capacity). Segments above 80% utilization are at overflow risk — a key SSO prevention KPI."
    - name: "total_peak_flow_gpm"
      expr: SUM(CAST(peak_flow_gpm AS DOUBLE))
      comment: "Total peak flow capacity across sewer segments in gallons per minute. Used for wet-weather capacity and SSO risk assessment."
    - name: "fog_risk_segment_count"
      expr: COUNT(CASE WHEN fog_risk_flag = TRUE THEN 1 END)
      comment: "Number of sewer segments with identified FOG risk. Drives targeted cleaning program scope and frequency planning."
    - name: "h2s_risk_segment_count"
      expr: COUNT(CASE WHEN hydrogen_sulfide_risk_flag = TRUE THEN 1 END)
      comment: "Number of sewer segments with hydrogen sulfide corrosion risk. Drives accelerated inspection and lining investment decisions."
    - name: "root_intrusion_segment_count"
      expr: COUNT(CASE WHEN root_intrusion_flag = TRUE THEN 1 END)
      comment: "Number of sewer segments with root intrusion. Used to scope root cutting and rehabilitation programs."
    - name: "avg_slope_percent"
      expr: AVG(CAST(slope_percent AS DOUBLE))
      comment: "Average pipe slope percentage across sewer segments. Low slope segments are prone to sediment buildup and SSOs — used for hydraulic risk profiling."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average pipe diameter in inches across the sewer network. Used for capacity benchmarking and rehabilitation planning."
    - name: "overdue_inspection_segment_count"
      expr: COUNT(CASE WHEN next_inspection_due_date < CURRENT_DATE THEN 1 END)
      comment: "Number of sewer segments past their scheduled inspection due date. A compliance and risk KPI — overdue inspections increase SSO and structural failure risk."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_manhole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset condition, risk, and inspection KPIs for manholes in the wastewater collection system. Used by field operations managers, asset managers, and safety officers to prioritize inspection, maintenance, and confined space programs."
  source: "`vibe_water_utilities_v1`.`wastewater`.`manhole`"
  dimensions:
    - name: "manhole_type"
      expr: manhole_type
      comment: "Type of manhole structure (e.g., standard, drop, junction) — used for asset classification and maintenance planning."
    - name: "manhole_status"
      expr: manhole_status
      comment: "Operational status of the manhole (e.g., active, abandoned, rehabilitated) — drives maintenance and decommissioning decisions."
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for the manhole — used for asset management system integration and capital planning."
    - name: "macp_score"
      expr: macp_score
      comment: "MACP (Manhole Assessment and Certification Program) condition score — primary condition rating for rehabilitation prioritization."
    - name: "cover_type"
      expr: cover_type
      comment: "Type of manhole cover (e.g., cast iron, composite) — used for replacement program planning."
    - name: "confined_space_flag"
      expr: confined_space_flag
      comment: "Indicates whether the manhole is classified as a confined space — drives safety protocol requirements and workforce training needs."
    - name: "inflow_infiltration_flag"
      expr: inflow_infiltration_flag
      comment: "Indicates known inflow and infiltration (I/I) at the manhole — used to scope I/I reduction programs and SSO risk mitigation."
    - name: "sso_history_flag"
      expr: sso_history_flag
      comment: "Indicates whether the manhole has a history of sanitary sewer overflows (SSOs) — critical risk flag for regulatory and operational prioritization."
    - name: "scada_monitored_flag"
      expr: scada_monitored_flag
      comment: "Indicates whether the manhole is monitored by SCADA — used to assess real-time monitoring coverage gaps."
    - name: "traffic_load_rating"
      expr: traffic_load_rating
      comment: "Traffic load rating of the manhole cover — used for structural risk assessment in high-traffic areas."
    - name: "ownership"
      expr: ownership
      comment: "Ownership of the manhole (public utility, private, etc.) — determines maintenance responsibility and capital allocation."
    - name: "city"
      expr: city
      comment: "City where the manhole is located — geographic dimension for regional operations planning."
    - name: "state_province"
      expr: state_province
      comment: "State or province where the manhole is located — used for multi-jurisdiction regulatory reporting."
    - name: "dma_code"
      expr: dma_code
      comment: "District Metered Area code — used for hydraulic zone-level analysis and I/I program targeting."
    - name: "last_inspection_year"
      expr: YEAR(last_inspection_date)
      comment: "Year of the most recent manhole inspection — used to identify assets overdue for inspection."
    - name: "next_inspection_year"
      expr: YEAR(next_inspection_date)
      comment: "Year the next inspection is scheduled — used for inspection program scheduling and compliance tracking."
  measures:
    - name: "total_manhole_count"
      expr: COUNT(1)
      comment: "Total number of manholes in the collection system. Baseline inventory measure for asset management and field operations planning."
    - name: "sso_history_manhole_count"
      expr: COUNT(CASE WHEN sso_history_flag = TRUE THEN 1 END)
      comment: "Number of manholes with a history of sanitary sewer overflows. A critical regulatory and environmental risk KPI — drives targeted rehabilitation and monitoring investment."
    - name: "sso_history_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sso_history_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of manholes with SSO history. Tracks system-wide SSO risk concentration — a key metric for regulatory compliance programs and capital prioritization."
    - name: "inflow_infiltration_manhole_count"
      expr: COUNT(CASE WHEN inflow_infiltration_flag = TRUE THEN 1 END)
      comment: "Number of manholes with identified inflow and infiltration. Drives I/I reduction program scope — excess I/I increases treatment costs and SSO risk."
    - name: "confined_space_manhole_count"
      expr: COUNT(CASE WHEN confined_space_flag = TRUE THEN 1 END)
      comment: "Number of manholes classified as confined spaces. Drives safety training, permitting, and equipment requirements for field crews."
    - name: "scada_monitored_manhole_count"
      expr: COUNT(CASE WHEN scada_monitored_flag = TRUE THEN 1 END)
      comment: "Number of manholes with active SCADA monitoring. Used to assess real-time monitoring coverage and identify gaps in the telemetry network."
    - name: "scada_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN scada_monitored_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of manholes covered by SCADA monitoring. Tracks real-time visibility coverage — low coverage increases response time to SSO events."
    - name: "overdue_inspection_manhole_count"
      expr: COUNT(CASE WHEN next_inspection_date < CURRENT_DATE THEN 1 END)
      comment: "Number of manholes past their scheduled next inspection date. Compliance and risk KPI — overdue inspections increase structural failure and SSO risk."
    - name: "avg_depth_feet"
      expr: AVG(CAST(depth_feet AS DOUBLE))
      comment: "Average manhole depth in feet. Used for confined space risk profiling and maintenance cost estimation."
    - name: "avg_diameter_inches"
      expr: AVG(CAST(diameter_inches AS DOUBLE))
      comment: "Average manhole diameter in inches. Used for access equipment planning and rehabilitation cost estimation."
    - name: "distinct_dma_count"
      expr: COUNT(DISTINCT dma_code)
      comment: "Number of distinct District Metered Areas with manhole assets. Used to assess geographic coverage and DMA-level risk distribution."
$$;

CREATE OR REPLACE VIEW `vibe_water_utilities_v1`.`_metrics`.`wastewater_sewershed_basin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portfolio and status KPIs for sewershed basins — the primary hydraulic planning units of the wastewater collection system. Used by planning engineers, asset managers, and utility executives to track basin inventory, activity status, and program execution."
  source: "`vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`"
  dimensions:
    - name: "sewershed_basin_status"
      expr: sewershed_basin_status
      comment: "Operational or planning status of the sewershed basin — primary status dimension for portfolio management."
    - name: "category"
      expr: category
      comment: "Category classification of the basin record — used for program and initiative grouping."
    - name: "subcategory"
      expr: subcategory
      comment: "Subcategory classification — provides finer-grained segmentation within basin categories."
    - name: "type_code"
      expr: type_code
      comment: "Type code for the basin record — used for classification and reporting alignment."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the basin or basin activity — drives resource allocation and program sequencing."
    - name: "region"
      expr: region
      comment: "Geographic region of the sewershed basin — used for regional planning and resource deployment."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the basin is currently active — used to filter operational vs. decommissioned basins."
    - name: "is_verified"
      expr: is_verified
      comment: "Indicates whether basin data has been verified — used for data quality governance and reporting confidence."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for basin metrics — used for dimensional consistency in cross-basin comparisons."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the basin record became effective — used for temporal trend analysis and program vintage tracking."
    - name: "completed_year"
      expr: YEAR(completed_date)
      comment: "Year the basin activity or program was completed — used for program delivery performance tracking."
    - name: "due_year"
      expr: YEAR(due_date)
      comment: "Year the basin activity is due — used for program scheduling and deadline management."
  measures:
    - name: "total_basin_count"
      expr: COUNT(1)
      comment: "Total number of sewershed basin records. Baseline inventory measure for hydraulic planning unit management."
    - name: "active_basin_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active sewershed basins. Used to track operational portfolio size and distinguish active from decommissioned basins."
    - name: "active_basin_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sewershed basins that are currently active. Tracks portfolio health and decommissioning program progress."
    - name: "verified_basin_count"
      expr: COUNT(CASE WHEN is_verified = TRUE THEN 1 END)
      comment: "Number of sewershed basins with verified data. Data quality KPI — low verification rates undermine planning accuracy and regulatory reporting confidence."
    - name: "data_verification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_verified = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sewershed basin records that have been verified. Tracks data governance maturity — a prerequisite for reliable hydraulic modeling and regulatory submissions."
    - name: "overdue_basin_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE AND (completed_date IS NULL OR completed_date > due_date) THEN 1 END)
      comment: "Number of sewershed basin activities past their due date without completion. Program delivery KPI — overdue basins signal planning or resource execution gaps."
    - name: "distinct_region_count"
      expr: COUNT(DISTINCT region)
      comment: "Number of distinct geographic regions covered by sewershed basins. Used to assess geographic program coverage and regional planning scope."
    - name: "avg_version_number"
      expr: AVG(CAST(version_number AS DOUBLE))
      comment: "Average version number of sewershed basin records. Tracks data revision activity — high average versions indicate frequently updated or contested basin definitions."
$$;