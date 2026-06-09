-- Metric views for domain: infrastructure | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_berth`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for berth infrastructure — capacity, depth adequacy, maintenance posture, and shore-power readiness. Used by port operations and capital planning teams to prioritise investment and manage berth availability."
  source: "`shipping_ports_ecm`.`infrastructure`.`berth`"
  dimensions:
    - name: "berth_type"
      expr: berth_type
      comment: "Classification of the berth (e.g. container, bulk, RoRo) for segmented capacity analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational state of the berth (e.g. Active, Under Maintenance, Decommissioned) — primary filter for availability reporting."
    - name: "isps_compliant_flag"
      expr: isps_compliant_flag
      comment: "Indicates whether the berth meets ISPS security compliance requirements — used for regulatory reporting."
    - name: "shore_power_available_flag"
      expr: shore_power_available_flag
      comment: "Indicates availability of shore power (cold ironing) — key sustainability and ESG dimension."
    - name: "tidal_constraint_flag"
      expr: tidal_constraint_flag
      comment: "Flags berths with tidal access restrictions, affecting vessel scheduling windows."
    - name: "fender_condition"
      expr: fender_condition
      comment: "Condition rating of the fender system — used to prioritise maintenance spend."
    - name: "commissioning_year"
      expr: DATE_TRUNC('YEAR', commissioning_date)
      comment: "Year the berth was commissioned — supports age-based capital renewal analysis."
    - name: "next_maintenance_month"
      expr: DATE_TRUNC('MONTH', next_maintenance_date)
      comment: "Month of next scheduled maintenance — used for maintenance workload forecasting."
  measures:
    - name: "total_berths"
      expr: COUNT(1)
      comment: "Total number of berths in scope — baseline capacity count for port infrastructure planning."
    - name: "total_quay_length_m"
      expr: SUM(CAST(length_m AS DOUBLE))
      comment: "Total quay face length in metres across all berths — primary physical capacity indicator used in port master planning."
    - name: "avg_water_depth_alongside_m"
      expr: AVG(CAST(water_depth_alongside_m AS DOUBLE))
      comment: "Average water depth alongside berths — determines the vessel size class the port can accommodate; critical for commercial positioning."
    - name: "max_water_depth_alongside_m"
      expr: MAX(CAST(water_depth_alongside_m AS DOUBLE))
      comment: "Maximum water depth alongside any berth — indicates the deepest-draft vessel the port can receive; used in marketing and vessel acceptance decisions."
    - name: "avg_max_draft_m"
      expr: AVG(CAST(max_draft_m AS DOUBLE))
      comment: "Average maximum permissible vessel draft across berths — used to assess fleet compatibility and revenue potential from larger vessels."
    - name: "total_shore_power_capacity_kw"
      expr: SUM(CAST(shore_power_capacity_kw AS DOUBLE))
      comment: "Total installed shore power capacity in kilowatts — ESG and regulatory KPI for cold-ironing infrastructure investment decisions."
    - name: "avg_bollard_swl_tonnes"
      expr: AVG(CAST(bollard_swl_tonnes AS DOUBLE))
      comment: "Average safe working load of bollards in tonnes — structural capacity indicator used to assess mooring suitability for larger vessels."
    - name: "avg_fender_energy_absorption_kj"
      expr: AVG(CAST(fender_energy_absorption_kj AS DOUBLE))
      comment: "Average fender energy absorption capacity in kilojoules — used to assess whether fender systems are rated for the vessel classes calling the port."
    - name: "avg_max_dwt_tonnes"
      expr: AVG(CAST(max_dwt_tonnes AS DOUBLE))
      comment: "Average maximum deadweight tonnage capacity across berths — commercial capacity indicator used in trade lane and vessel acceptance strategy."
    - name: "depth_deficit_m"
      expr: AVG(CAST(max_draft_m AS DOUBLE) - CAST(water_depth_alongside_m AS DOUBLE))
      comment: "Average gap between maximum permissible draft and actual water depth alongside — negative values indicate dredging headroom; positive values signal dredging urgency."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Navigation channel depth, capacity, and maintenance KPIs. Used by harbour masters, dredging planners, and port executives to manage safe vessel transit and dredging investment priorities."
  source: "`shipping_ports_ecm`.`infrastructure`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of navigation channel (e.g. approach, inner harbour, turning basin) — used to segment depth and capacity analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the channel — primary filter for active vs. restricted navigation analysis."
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Indicates whether pilotage is mandatory — affects vessel scheduling and port dues revenue."
    - name: "two_way_traffic_permitted_flag"
      expr: two_way_traffic_permitted_flag
      comment: "Indicates whether two-way vessel traffic is permitted — key throughput capacity dimension."
    - name: "environmental_sensitivity_flag"
      expr: environmental_sensitivity_flag
      comment: "Flags environmentally sensitive channels where dredging requires additional regulatory approval."
    - name: "dredging_authority"
      expr: dredging_authority
      comment: "Authority responsible for dredging maintenance — used for accountability and budget allocation."
    - name: "last_survey_year"
      expr: DATE_TRUNC('YEAR', last_survey_date)
      comment: "Year of the most recent hydrographic survey — used to identify channels overdue for resurvey."
  measures:
    - name: "total_channels"
      expr: COUNT(1)
      comment: "Total number of navigation channels — baseline infrastructure count for port capacity planning."
    - name: "total_channel_length_nm"
      expr: SUM(CAST(total_length_nm AS DOUBLE))
      comment: "Total navigable channel length in nautical miles — physical scale indicator for dredging programme sizing and cost estimation."
    - name: "avg_maintained_depth_m"
      expr: AVG(CAST(current_maintained_depth_cd_m AS DOUBLE))
      comment: "Average currently maintained channel depth in metres — primary indicator of the port's ability to accommodate deep-draft vessels."
    - name: "avg_design_depth_m"
      expr: AVG(CAST(design_depth_cd_m AS DOUBLE))
      comment: "Average design depth of channels — benchmark against maintained depth to quantify sedimentation-driven capacity loss."
    - name: "avg_depth_deficit_vs_design_m"
      expr: AVG(CAST(design_depth_cd_m AS DOUBLE) - CAST(current_maintained_depth_cd_m AS DOUBLE))
      comment: "Average shortfall between design depth and current maintained depth — directly quantifies dredging backlog and urgency; drives capital dredging budget decisions."
    - name: "avg_sedimentation_rate_m_per_year"
      expr: AVG(CAST(sedimentation_rate_m_per_year AS DOUBLE))
      comment: "Average annual sedimentation rate across channels — used to forecast dredging frequency and lifecycle cost of channel maintenance."
    - name: "avg_under_keel_clearance_m"
      expr: AVG(CAST(under_keel_clearance_m AS DOUBLE))
      comment: "Average under-keel clearance across channels — safety-critical metric; insufficient UKC triggers vessel size restrictions and revenue loss."
    - name: "avg_max_permissible_draft_m"
      expr: AVG(CAST(max_permissible_draft_m AS DOUBLE))
      comment: "Average maximum permissible vessel draft across channels — commercial capacity indicator used in vessel acceptance and trade lane strategy."
    - name: "avg_max_permissible_dwt"
      expr: AVG(CAST(max_permissible_dwt AS DOUBLE))
      comment: "Average maximum permissible deadweight tonnage across channels — used to assess revenue potential from larger vessel classes."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_dredging_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dredging programme performance and cost KPIs. Used by port engineering, finance, and executive teams to track dredging delivery, cost efficiency, and environmental compliance."
  source: "`shipping_ports_ecm`.`infrastructure`.`dredging_campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the dredging campaign (e.g. Planned, Active, Completed) — primary lifecycle filter."
    - name: "dredging_type"
      expr: dredging_type
      comment: "Type of dredging (e.g. capital, maintenance, emergency) — used to segment cost and volume analysis by programme type."
    - name: "disposal_type"
      expr: disposal_type
      comment: "Method of spoil disposal (e.g. open sea, confined facility, beneficial reuse) — environmental compliance dimension."
    - name: "sediment_contamination_level"
      expr: sediment_contamination_level
      comment: "Contamination classification of dredged material — drives disposal cost and regulatory approval complexity."
    - name: "contractor_name"
      expr: contractor_name
      comment: "Name of the dredging contractor — used for contractor performance benchmarking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of campaign cost reporting — required for multi-currency financial consolidation."
    - name: "start_year"
      expr: DATE_TRUNC('YEAR', start_date)
      comment: "Year the dredging campaign commenced — used for annual capital expenditure trend analysis."
    - name: "completion_year"
      expr: DATE_TRUNC('YEAR', completion_date)
      comment: "Year the dredging campaign was completed — used for programme delivery timeline analysis."
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of dredging campaigns — baseline count for programme portfolio management."
    - name: "total_campaign_cost"
      expr: SUM(CAST(campaign_cost AS DOUBLE))
      comment: "Total expenditure across all dredging campaigns — primary financial KPI for dredging programme budget control and board reporting."
    - name: "total_actual_volume_dredged_m3"
      expr: SUM(CAST(actual_volume_dredged_m3 AS DOUBLE))
      comment: "Total volume of material actually dredged in cubic metres — physical output KPI used to measure programme delivery and contractor performance."
    - name: "total_contracted_volume_m3"
      expr: SUM(CAST(contracted_volume_m3 AS DOUBLE))
      comment: "Total contracted dredging volume in cubic metres — used as the baseline for delivery variance analysis."
    - name: "volume_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_dredged_m3 AS DOUBLE)) / NULLIF(SUM(CAST(contracted_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted dredging volume actually delivered — contractor performance and programme completion KPI; below 90% triggers contract review."
    - name: "avg_cost_per_m3"
      expr: ROUND(SUM(CAST(campaign_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_volume_dredged_m3 AS DOUBLE)), 0), 2)
      comment: "Average cost per cubic metre of material dredged — unit cost efficiency KPI used to benchmark contractors and evaluate dredging technology choices."
    - name: "total_approved_disposal_volume_m3"
      expr: SUM(CAST(approved_disposal_volume_m3 AS DOUBLE))
      comment: "Total volume approved for disposal — used to track regulatory permit utilisation and identify campaigns at risk of exceeding disposal limits."
    - name: "disposal_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(cumulative_volume_disposed_m3 AS DOUBLE)) / NULLIF(SUM(CAST(approved_disposal_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of approved disposal volume consumed — environmental compliance KPI; approaching 100% signals need for additional permit approval."
    - name: "avg_design_depth_target_m"
      expr: AVG(CAST(design_depth_target_m AS DOUBLE))
      comment: "Average target dredging depth across campaigns — used to assess whether the dredging programme is aligned with port depth strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_depth_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hydrographic survey quality, shoaling detection, and dredging trigger KPIs. Used by harbour masters, dredging planners, and port engineers to manage navigational safety and maintenance dredging decisions."
  source: "`shipping_ports_ecm`.`infrastructure`.`depth_survey`"
  dimensions:
    - name: "survey_area_type"
      expr: survey_area_type
      comment: "Type of area surveyed (e.g. channel, berth, anchorage) — used to segment depth findings by infrastructure type."
    - name: "survey_method"
      expr: survey_method
      comment: "Hydrographic survey method used (e.g. multibeam, singlebeam) — affects data accuracy and comparability."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the survey report — only approved surveys should inform operational depth decisions."
    - name: "dredging_required_flag"
      expr: dredging_required_flag
      comment: "Indicates whether the survey triggered a dredging requirement — primary flag for maintenance dredging programme initiation."
    - name: "shoaling_detected_flag"
      expr: shoaling_detected_flag
      comment: "Indicates whether shoaling was detected — safety-critical flag used to trigger navigational restrictions or emergency dredging."
    - name: "dredging_priority"
      expr: dredging_priority
      comment: "Priority classification for dredging action (e.g. Urgent, High, Routine) — used to sequence the dredging programme."
    - name: "survey_year"
      expr: DATE_TRUNC('YEAR', survey_date)
      comment: "Year the survey was conducted — used for annual survey programme tracking and trend analysis."
    - name: "survey_accuracy_order"
      expr: survey_accuracy_order
      comment: "IHO accuracy order of the survey — determines fitness for purpose in safety-critical navigation decisions."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of depth surveys conducted — baseline for survey programme coverage and frequency monitoring."
    - name: "total_survey_coverage_area_sqm"
      expr: SUM(CAST(survey_coverage_area_sqm AS DOUBLE))
      comment: "Total area covered by depth surveys in square metres — used to assess survey programme completeness relative to total port water area."
    - name: "avg_mean_depth_m"
      expr: AVG(CAST(mean_depth_m AS DOUBLE))
      comment: "Average mean depth recorded across surveys — baseline depth indicator used to track sedimentation trends over time."
    - name: "avg_minimum_depth_recorded_m"
      expr: AVG(CAST(minimum_depth_recorded_m AS DOUBLE))
      comment: "Average of minimum depths recorded — identifies the shallowest conditions across surveyed areas; directly constrains maximum permissible vessel draft."
    - name: "avg_depth_variance_m"
      expr: AVG(CAST(depth_variance_m AS DOUBLE))
      comment: "Average variance between declared depth and surveyed depth — measures accuracy of published port depth information; large variance indicates navigational safety risk."
    - name: "total_shoaling_volume_cbm"
      expr: SUM(CAST(shoaling_volume_cbm AS DOUBLE))
      comment: "Total volume of shoaling material identified across surveys in cubic metres — primary input to dredging programme volume planning and cost estimation."
    - name: "shoaling_detection_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shoaling_detected_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys that detected shoaling — trend indicator for sedimentation pressure across the port; rising rate signals need for increased dredging frequency."
    - name: "dredging_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dredging_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys that triggered a dredging requirement — operational KPI used to assess maintenance dredging demand and programme adequacy."
    - name: "total_survey_cost"
      expr: SUM(CAST(survey_cost_amount AS DOUBLE))
      comment: "Total expenditure on depth surveys — cost management KPI for the hydrographic survey programme budget."
    - name: "avg_survey_cost"
      expr: AVG(CAST(survey_cost_amount AS DOUBLE))
      comment: "Average cost per depth survey — used to benchmark survey contractor pricing and optimise survey programme spend."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure closure impact and duration KPIs. Used by port operations, commercial, and executive teams to quantify availability loss, revenue impact, and closure root-cause patterns."
  source: "`shipping_ports_ecm`.`infrastructure`.`closure`"
  dimensions:
    - name: "infrastructure_type"
      expr: infrastructure_type
      comment: "Type of infrastructure affected by the closure (e.g. Berth, Channel, Gate) — used to segment availability loss by asset class."
    - name: "closure_status"
      expr: closure_status
      comment: "Current status of the closure (e.g. Planned, Active, Resolved) — primary lifecycle filter for operational reporting."
    - name: "reason"
      expr: reason
      comment: "Primary reason category for the closure (e.g. Maintenance, Weather, Security) — used for root-cause analysis and preventive action planning."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the closure — used to prioritise response and escalation."
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Indicates whether the closure was triggered by a safety incident — used for safety performance reporting."
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Indicates whether the closure had an environmental impact — used for environmental compliance and ESG reporting."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_datetime)
      comment: "Month the closure was planned to start — used for seasonal availability trend analysis."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_datetime)
      comment: "Month the closure actually started — used for actual vs. planned availability comparison."
  measures:
    - name: "total_closures"
      expr: COUNT(1)
      comment: "Total number of infrastructure closures — baseline availability event count for port resilience reporting."
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue impact of closures in USD — primary financial KPI for closure management; used in board reporting and insurance claims."
    - name: "avg_estimated_revenue_impact_usd"
      expr: AVG(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Average revenue impact per closure event — used to prioritise closure prevention investment by comparing prevention cost against average impact."
    - name: "avg_capacity_reduction_pct"
      expr: AVG(CAST(capacity_reduction_percentage AS DOUBLE))
      comment: "Average capacity reduction percentage during closures — operational impact KPI used to assess the severity of availability events on port throughput."
    - name: "avg_planned_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(planned_end_datetime) - UNIX_TIMESTAMP(planned_start_datetime) AS DOUBLE) / 3600.0)
      comment: "Average planned closure duration in hours — used to assess planned maintenance window sizing and scheduling efficiency."
    - name: "avg_actual_duration_hours"
      expr: AVG(CAST(UNIX_TIMESTAMP(actual_end_datetime) - UNIX_TIMESTAMP(actual_start_datetime) AS DOUBLE) / 3600.0)
      comment: "Average actual closure duration in hours — compared against planned duration to measure closure management effectiveness and overrun frequency."
    - name: "safety_incident_closure_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of closures triggered by safety incidents — safety performance KPI; rising rate signals deteriorating infrastructure safety standards."
    - name: "total_extension_count"
      expr: SUM(CAST(extension_count AS BIGINT))
      comment: "Total number of closure extensions across all events — measures closure overrun frequency; high values indicate poor maintenance planning or scope underestimation."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_structural_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Structural inspection findings, defect severity, and remediation KPIs. Used by port engineering, asset management, and executive teams to manage infrastructure integrity risk and maintenance investment."
  source: "`shipping_ports_ecm`.`infrastructure`.`structural_inspection`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of infrastructure asset inspected (e.g. Quay Wall, Berth, Navigational Aid) — used to segment defect findings by asset class."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection conducted (e.g. Routine, Principal, Special) — used to compare findings across inspection regimes."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g. Completed, In Progress, Overdue) — used to track inspection programme compliance."
    - name: "overall_condition_rating"
      expr: overall_condition_rating
      comment: "Overall structural condition rating assigned by the inspector — primary asset health dimension for portfolio risk assessment."
    - name: "safety_risk_level"
      expr: safety_risk_level
      comment: "Safety risk classification from the inspection — used to prioritise remediation and trigger operational restrictions."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current status of remediation actions (e.g. Not Started, In Progress, Completed) — used to track defect resolution progress."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates whether the inspection found the asset to be regulatory compliant — used for compliance reporting to port authorities."
    - name: "inspection_year"
      expr: DATE_TRUNC('YEAR', inspection_date)
      comment: "Year the inspection was conducted — used for annual inspection programme tracking and trend analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of structural inspections conducted — baseline for inspection programme coverage monitoring."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated cost of repairs identified across all inspections — primary capital planning KPI for infrastructure renewal budgeting."
    - name: "avg_estimated_repair_cost"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per inspection — used to benchmark asset condition and prioritise maintenance spend allocation."
    - name: "avg_inspection_duration_hours"
      expr: AVG(CAST(inspection_duration_hours AS DOUBLE))
      comment: "Average inspection duration in hours — used to plan inspection resource requirements and contractor scheduling."
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defects_count AS BIGINT))
      comment: "Total number of critical structural defects identified — safety-critical KPI; any increase triggers immediate executive escalation and potential asset closure."
    - name: "total_major_defects"
      expr: SUM(CAST(major_defects_count AS BIGINT))
      comment: "Total number of major structural defects identified — used to assess the scale of significant remediation work required across the asset portfolio."
    - name: "total_defects_identified"
      expr: SUM(CAST(defects_identified_count AS BIGINT))
      comment: "Total number of defects identified across all inspections — overall infrastructure health indicator used in asset management reporting."
    - name: "critical_defect_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(critical_defects_count AS BIGINT)) / NULLIF(SUM(CAST(defects_identified_count AS BIGINT)), 0), 2)
      comment: "Percentage of identified defects classified as critical — structural risk concentration KPI; rising rate signals accelerating infrastructure deterioration."
    - name: "non_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections finding regulatory non-compliance — regulatory risk KPI; used to prioritise remediation to avoid enforcement action and licence risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory permit portfolio health, compliance, and expiry risk KPIs. Used by compliance, legal, and executive teams to manage permit validity, renewal risk, and regulatory standing."
  source: "`shipping_ports_ecm`.`infrastructure`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of regulatory permit (e.g. Environmental, Construction, Operational) — used to segment compliance risk by regulatory category."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (e.g. Active, Expired, Suspended, Revoked) — primary compliance filter."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory authority that issued the permit — used to segment compliance posture by regulator."
    - name: "environmental_sensitivity_flag"
      expr: environmental_sensitivity_flag
      comment: "Indicates whether the permit relates to an environmentally sensitive area — used for ESG and environmental compliance reporting."
    - name: "financial_security_required_flag"
      expr: financial_security_required_flag
      comment: "Indicates whether a financial security bond is required — used to track financial exposure from permit obligations."
    - name: "last_inspection_outcome"
      expr: last_inspection_outcome
      comment: "Outcome of the most recent regulatory inspection — used to assess current compliance standing with each issuing authority."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the permit expires — used for renewal pipeline planning and regulatory risk forecasting."
    - name: "issue_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year the permit was issued — used for permit portfolio age analysis."
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits in the portfolio — baseline count for regulatory compliance programme scope."
    - name: "active_permits"
      expr: SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of currently active permits — operational compliance baseline; any reduction signals regulatory risk requiring immediate action."
    - name: "expired_permits"
      expr: SUM(CASE WHEN permit_status = 'Expired' THEN 1 ELSE 0 END)
      comment: "Number of expired permits — critical compliance risk KPI; operating under an expired permit exposes the port to enforcement action and licence revocation."
    - name: "suspended_or_revoked_permits"
      expr: SUM(CASE WHEN permit_status IN ('Suspended', 'Revoked') THEN 1 ELSE 0 END)
      comment: "Number of suspended or revoked permits — highest-severity compliance risk indicator; directly impacts operational authorisation and may trigger port closure."
    - name: "permit_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of permits currently in active/compliant status — overall regulatory compliance health score used in board and regulator reporting."
    - name: "total_financial_security_amount"
      expr: SUM(CAST(financial_security_amount AS DOUBLE))
      comment: "Total financial security (bond) value across all permits — financial exposure KPI for treasury and risk management; represents contingent liability on the balance sheet."
    - name: "avg_financial_security_amount"
      expr: AVG(CAST(financial_security_amount AS DOUBLE))
      comment: "Average financial security amount per permit — used to assess the typical regulatory financial obligation and benchmark against industry norms."
    - name: "permits_expiring_within_90_days"
      expr: SUM(CASE WHEN permit_status = 'Active' AND expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 ELSE 0 END)
      comment: "Number of active permits expiring within the next 90 days — forward-looking renewal risk KPI; used to trigger renewal actions before operational authorisation lapses."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital infrastructure project delivery, budget performance, and portfolio KPIs. Used by port executives, capital programme managers, and finance teams to govern CAPEX investment and project delivery."
  source: "`shipping_ports_ecm`.`infrastructure`.`project`"
  dimensions:
    - name: "project_type"
      expr: project_type
      comment: "Type of infrastructure project (e.g. New Construction, Expansion, Rehabilitation) — used to segment CAPEX by investment category."
    - name: "project_category"
      expr: project_category
      comment: "Business category of the project (e.g. Berth, Channel, Terminal) — used to allocate capital spend by infrastructure domain."
    - name: "project_status"
      expr: project_status
      comment: "Current lifecycle status of the project (e.g. Approved, In Progress, Completed, On Hold) — primary portfolio filter."
    - name: "phase"
      expr: phase
      comment: "Current project phase (e.g. Design, Construction, Commissioning) — used for stage-gate reporting and resource planning."
    - name: "priority"
      expr: priority
      comment: "Strategic priority classification of the project — used to align capital allocation with port strategy."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating of the project — used to identify projects requiring enhanced governance and executive oversight."
    - name: "environmental_impact_assessment_required"
      expr: environmental_impact_assessment_required
      comment: "Indicates whether an Environmental Impact Assessment is required — used to track regulatory approval pipeline for major projects."
    - name: "planned_start_year"
      expr: DATE_TRUNC('YEAR', planned_start_date)
      comment: "Year the project is planned to start — used for capital expenditure phasing and resource planning."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of capital projects in the portfolio — baseline count for programme governance reporting."
    - name: "total_approved_capex_budget"
      expr: SUM(CAST(approved_capex_budget AS DOUBLE))
      comment: "Total approved CAPEX budget across all projects — primary financial scale indicator for the capital programme; used in board and investor reporting."
    - name: "total_actual_expenditure_to_date"
      expr: SUM(CAST(actual_expenditure_to_date AS DOUBLE))
      comment: "Total actual capital expenditure incurred to date — used to track programme spend against approved budget and forecast cash flow."
    - name: "budget_utilisation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_to_date AS DOUBLE)) / NULLIF(SUM(CAST(approved_capex_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of approved CAPEX budget spent to date — programme delivery pace KPI; significantly below 100% at period end signals delivery delays and budget underspend."
    - name: "budget_variance"
      expr: SUM(CAST(actual_expenditure_to_date AS DOUBLE) - CAST(approved_capex_budget AS DOUBLE))
      comment: "Total variance between actual expenditure and approved budget (positive = overspend) — financial control KPI; overspend triggers executive review and potential scope adjustment."
    - name: "avg_approved_capex_budget"
      expr: AVG(CAST(approved_capex_budget AS DOUBLE))
      comment: "Average approved CAPEX budget per project — used to assess project sizing and compare against industry benchmarks for similar infrastructure investments."
    - name: "total_berth_length_increase_m"
      expr: SUM(CAST(berth_length_increase_m AS DOUBLE))
      comment: "Total planned berth length increase in metres across all projects — physical capacity expansion KPI used to quantify the port's growth pipeline."
    - name: "avg_channel_depth_target_m"
      expr: AVG(CAST(channel_depth_m AS DOUBLE))
      comment: "Average target channel depth across channel deepening projects — used to assess whether the capital programme will achieve the port's vessel size strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_terminal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal capacity, physical infrastructure, and operational readiness KPIs. Used by terminal management, commercial teams, and port executives to assess terminal competitiveness and investment needs."
  source: "`shipping_ports_ecm`.`infrastructure`.`infrastructure_terminal`"
  dimensions:
    - name: "terminal_type"
      expr: terminal_type
      comment: "Type of terminal (e.g. Container, Bulk, RoRo, Multi-purpose) — primary segmentation dimension for capacity and throughput analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the terminal — used to filter active vs. inactive terminal capacity."
    - name: "operator_type"
      expr: operator_type
      comment: "Type of terminal operator (e.g. Port Authority, Private, Joint Venture) — used to segment performance by ownership model."
    - name: "free_trade_zone"
      expr: free_trade_zone
      comment: "Indicates whether the terminal operates within a free trade zone — commercial and regulatory dimension affecting cargo routing decisions."
    - name: "rail_connection_available"
      expr: rail_connection_available
      comment: "Indicates availability of rail connection — multimodal connectivity dimension used in hinterland logistics strategy."
    - name: "shore_power_available"
      expr: shore_power_available
      comment: "Indicates availability of shore power — ESG and sustainability dimension for terminal environmental performance."
    - name: "customs_facility_available"
      expr: customs_facility_available
      comment: "Indicates whether customs clearance facilities are available on-terminal — affects dwell time and cargo velocity."
    - name: "commissioning_year"
      expr: DATE_TRUNC('YEAR', commissioning_date)
      comment: "Year the terminal was commissioned — used for asset age analysis and capital renewal planning."
  measures:
    - name: "total_terminals"
      expr: COUNT(1)
      comment: "Total number of terminals in the port system — baseline infrastructure count for portfolio management."
    - name: "total_quay_length_m"
      expr: SUM(CAST(total_quay_length_m AS DOUBLE))
      comment: "Total quay length across all terminals in metres — primary physical berth capacity indicator used in port master planning and commercial positioning."
    - name: "total_area_sqm"
      expr: SUM(CAST(total_area_sqm AS DOUBLE))
      comment: "Total terminal area in square metres — land use capacity indicator used in expansion planning and lease revenue optimisation."
    - name: "total_open_storage_area_sqm"
      expr: SUM(CAST(open_storage_area_sqm AS DOUBLE))
      comment: "Total open storage area across terminals in square metres — yard capacity indicator used to assess container dwell time risk and storage revenue potential."
    - name: "total_warehouse_area_sqm"
      expr: SUM(CAST(warehouse_area_sqm AS DOUBLE))
      comment: "Total covered warehouse area across terminals in square metres — used to assess value-added logistics capacity and warehouse lease revenue potential."
    - name: "avg_max_draft_m"
      expr: AVG(CAST(max_draft_m AS DOUBLE))
      comment: "Average maximum vessel draft across terminals — commercial capacity indicator used to assess the port's ability to attract larger vessel classes."
    - name: "avg_rail_track_length_m"
      expr: AVG(CAST(rail_track_length_m AS DOUBLE))
      comment: "Average rail track length per terminal — multimodal connectivity indicator used to assess hinterland rail capacity and investment needs."
    - name: "terminals_with_shore_power_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN shore_power_available = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of terminals equipped with shore power — ESG and sustainability KPI used in environmental certification and regulatory compliance reporting."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_anchorage_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Anchorage capacity, depth adequacy, and operational readiness KPIs. Used by harbour masters and port planners to manage vessel waiting area capacity and navigational safety."
  source: "`shipping_ports_ecm`.`infrastructure`.`anchorage_area`"
  dimensions:
    - name: "anchorage_category"
      expr: anchorage_category
      comment: "Category of anchorage (e.g. Commercial, Emergency, Quarantine) — used to segment capacity and utilisation by designated use."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the anchorage area — primary availability filter."
    - name: "emergency_anchorage_flag"
      expr: emergency_anchorage_flag
      comment: "Indicates whether the area is designated as an emergency anchorage — safety-critical dimension for contingency planning."
    - name: "environmental_sensitivity_flag"
      expr: environmental_sensitivity_flag
      comment: "Indicates environmental sensitivity of the anchorage area — used for environmental compliance and dredging approval planning."
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Indicates whether pilotage is required to access the anchorage — affects vessel scheduling and pilotage revenue."
    - name: "holding_ground_type"
      expr: holding_ground_type
      comment: "Type of seabed holding ground (e.g. Sand, Mud, Rock) — affects anchoring safety and suitability for different vessel types."
    - name: "wind_exposure_category"
      expr: wind_exposure_category
      comment: "Wind exposure classification of the anchorage — used to assess weather-related operational restrictions."
    - name: "designation_year"
      expr: DATE_TRUNC('YEAR', designation_date)
      comment: "Year the anchorage was officially designated — used for asset age and regulatory review cycle analysis."
  measures:
    - name: "total_anchorage_areas"
      expr: COUNT(1)
      comment: "Total number of designated anchorage areas — baseline capacity count for port waiting area management."
    - name: "total_area_sqm"
      expr: SUM(CAST(area_size_square_meters AS DOUBLE))
      comment: "Total anchorage area in square metres — physical capacity indicator used to assess the port's ability to accommodate vessel queues during peak demand."
    - name: "avg_water_depth_maximum_m"
      expr: AVG(CAST(water_depth_maximum_meters AS DOUBLE))
      comment: "Average maximum water depth across anchorage areas — determines the largest vessel class that can safely anchor; used in vessel acceptance decisions."
    - name: "avg_water_depth_minimum_m"
      expr: AVG(CAST(water_depth_minimum_meters AS DOUBLE))
      comment: "Average minimum water depth across anchorage areas — safety-critical metric; constrains the minimum under-keel clearance for anchored vessels."
    - name: "avg_max_vessel_dwt"
      expr: AVG(CAST(maximum_vessel_dwt AS DOUBLE))
      comment: "Average maximum vessel DWT capacity across anchorage areas — commercial capacity indicator used to assess whether anchorage infrastructure supports the port's target vessel size strategy."
    - name: "avg_swinging_circle_radius_m"
      expr: AVG(CAST(swinging_circle_radius_meters AS DOUBLE))
      comment: "Average swinging circle radius across anchorage areas — determines the effective usable capacity per vessel; used in anchorage density and congestion planning."
    - name: "avg_distance_to_berth_nm"
      expr: AVG(CAST(distance_to_berth_nm AS DOUBLE))
      comment: "Average distance from anchorage to berth in nautical miles — affects vessel transit time and port efficiency; used in port layout and anchorage location planning."
    - name: "emergency_anchorage_availability_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN emergency_anchorage_flag = TRUE AND operational_status = 'Active' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN emergency_anchorage_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of designated emergency anchorages currently operational — safety resilience KPI; below 100% requires immediate remediation to maintain port emergency response capability."
$$;