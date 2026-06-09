-- Metric views for domain: infrastructure | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_berth`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core berth infrastructure metrics tracking capacity, utilization, and operational performance of berth assets"
  source: "`shipping_ports_ecm`.`infrastructure`.`berth`"
  dimensions:
    - name: "berth_name"
      expr: berth_name
      comment: "Name of the berth facility"
    - name: "berth_number"
      expr: berth_number
      comment: "Unique berth identifier number"
    - name: "berth_type"
      expr: berth_type
      comment: "Classification of berth by type (container, bulk, ro-ro, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the berth"
    - name: "isps_compliant_flag"
      expr: isps_compliant_flag
      comment: "Whether berth meets ISPS security compliance"
    - name: "shore_power_available_flag"
      expr: shore_power_available_flag
      comment: "Indicates if shore power is available for vessels"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the berth was commissioned"
    - name: "commissioning_month"
      expr: DATE_TRUNC('MONTH', commissioning_date)
      comment: "Month the berth was commissioned"
  measures:
    - name: "total_berths"
      expr: COUNT(DISTINCT berth_id)
      comment: "Total number of unique berth facilities"
    - name: "total_berth_length_m"
      expr: SUM(CAST(length_m AS DOUBLE))
      comment: "Total linear meters of berth length available"
    - name: "avg_berth_length_m"
      expr: AVG(CAST(length_m AS DOUBLE))
      comment: "Average berth length in meters"
    - name: "total_loa_capacity_m"
      expr: SUM(CAST(loa_capacity_m AS DOUBLE))
      comment: "Total length overall capacity across all berths in meters"
    - name: "total_max_dwt_capacity_tonnes"
      expr: SUM(CAST(max_dwt_tonnes AS DOUBLE))
      comment: "Total deadweight tonnage capacity across all berths"
    - name: "avg_max_draft_m"
      expr: AVG(CAST(max_draft_m AS DOUBLE))
      comment: "Average maximum draft depth across berths in meters"
    - name: "total_shore_power_capacity_kw"
      expr: SUM(CAST(shore_power_capacity_kw AS DOUBLE))
      comment: "Total shore power capacity in kilowatts for cold ironing"
    - name: "avg_bollard_swl_tonnes"
      expr: AVG(CAST(bollard_swl_tonnes AS DOUBLE))
      comment: "Average safe working load of bollards in tonnes"
    - name: "avg_fender_energy_absorption_kj"
      expr: AVG(CAST(fender_energy_absorption_kj AS DOUBLE))
      comment: "Average fender energy absorption capacity in kilojoules"
    - name: "shore_power_availability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN shore_power_available_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berths with shore power capability for environmental compliance"
    - name: "isps_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN isps_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of berths meeting ISPS security standards"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Navigation channel metrics tracking depth, capacity, and maintenance requirements for safe vessel passage"
  source: "`shipping_ports_ecm`.`infrastructure`.`channel`"
  dimensions:
    - name: "channel_name"
      expr: channel_name
      comment: "Name of the navigation channel"
    - name: "channel_code"
      expr: channel_code
      comment: "Unique channel identifier code"
    - name: "channel_type"
      expr: channel_type
      comment: "Classification of channel (approach, main, secondary, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the channel"
    - name: "pilotage_required_flag"
      expr: pilotage_required_flag
      comment: "Whether pilotage is mandatory for this channel"
    - name: "two_way_traffic_permitted_flag"
      expr: two_way_traffic_permitted_flag
      comment: "Whether simultaneous two-way vessel traffic is allowed"
    - name: "last_dredging_year"
      expr: YEAR(last_dredging_date)
      comment: "Year of most recent dredging operation"
  measures:
    - name: "total_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Total number of navigation channels"
    - name: "total_channel_length_nm"
      expr: SUM(CAST(total_length_nm AS DOUBLE))
      comment: "Total navigable channel length in nautical miles"
    - name: "avg_design_depth_m"
      expr: AVG(CAST(design_depth_cd_m AS DOUBLE))
      comment: "Average design depth of channels at chart datum in meters"
    - name: "avg_current_maintained_depth_m"
      expr: AVG(CAST(current_maintained_depth_cd_m AS DOUBLE))
      comment: "Average current maintained depth at chart datum in meters"
    - name: "avg_design_width_m"
      expr: AVG(CAST(design_width_m AS DOUBLE))
      comment: "Average design width of channels in meters"
    - name: "avg_max_permissible_loa_m"
      expr: AVG(CAST(max_permissible_loa_m AS DOUBLE))
      comment: "Average maximum permissible vessel length overall in meters"
    - name: "avg_max_permissible_draft_m"
      expr: AVG(CAST(max_permissible_draft_m AS DOUBLE))
      comment: "Average maximum permissible vessel draft in meters"
    - name: "avg_sedimentation_rate_m_per_year"
      expr: AVG(CAST(sedimentation_rate_m_per_year AS DOUBLE))
      comment: "Average annual sedimentation rate requiring dredging maintenance"
    - name: "depth_maintenance_gap_m"
      expr: AVG(CAST(design_depth_cd_m AS DOUBLE) - CAST(current_maintained_depth_cd_m AS DOUBLE))
      comment: "Average gap between design depth and current maintained depth indicating dredging need"
    - name: "pilotage_requirement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pilotage_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channels requiring mandatory pilotage for safety"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_dredging_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dredging campaign performance metrics tracking cost efficiency, volume performance, and environmental compliance"
  source: "`shipping_ports_ecm`.`infrastructure`.`dredging_campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the dredging campaign"
    - name: "campaign_code"
      expr: campaign_code
      comment: "Unique campaign identifier code"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the dredging campaign"
    - name: "dredging_type"
      expr: dredging_type
      comment: "Type of dredging operation (capital, maintenance, emergency)"
    - name: "disposal_type"
      expr: disposal_type
      comment: "Method of spoil disposal"
    - name: "sediment_contamination_level"
      expr: sediment_contamination_level
      comment: "Contamination level of dredged sediment"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year the campaign started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the campaign started"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year the campaign was completed"
  measures:
    - name: "total_campaigns"
      expr: COUNT(DISTINCT dredging_campaign_id)
      comment: "Total number of dredging campaigns"
    - name: "total_campaign_cost"
      expr: SUM(CAST(campaign_cost AS DOUBLE))
      comment: "Total cost of all dredging campaigns"
    - name: "avg_campaign_cost"
      expr: AVG(CAST(campaign_cost AS DOUBLE))
      comment: "Average cost per dredging campaign"
    - name: "total_contracted_volume_m3"
      expr: SUM(CAST(contracted_volume_m3 AS DOUBLE))
      comment: "Total contracted dredging volume in cubic meters"
    - name: "total_actual_volume_dredged_m3"
      expr: SUM(CAST(actual_volume_dredged_m3 AS DOUBLE))
      comment: "Total actual volume dredged in cubic meters"
    - name: "total_volume_disposed_m3"
      expr: SUM(CAST(cumulative_volume_disposed_m3 AS DOUBLE))
      comment: "Total volume of spoil disposed in cubic meters"
    - name: "avg_design_depth_target_m"
      expr: AVG(CAST(design_depth_target_m AS DOUBLE))
      comment: "Average target depth for dredging campaigns in meters"
    - name: "volume_performance_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_volume_dredged_m3 AS DOUBLE)) / NULLIF(SUM(CAST(contracted_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of contracted volume actually dredged indicating contractor performance"
    - name: "cost_per_cubic_meter"
      expr: ROUND(SUM(CAST(campaign_cost AS DOUBLE)) / NULLIF(SUM(CAST(actual_volume_dredged_m3 AS DOUBLE)), 0), 2)
      comment: "Average cost per cubic meter dredged for cost efficiency analysis"
    - name: "total_environmental_incidents"
      expr: SUM(CAST(environmental_incident_count AS BIGINT))
      comment: "Total environmental incidents across all campaigns"
    - name: "total_safety_incidents"
      expr: SUM(CAST(safety_incident_count AS BIGINT))
      comment: "Total safety incidents across all campaigns"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project performance metrics tracking budget adherence, schedule performance, and capacity expansion outcomes"
  source: "`shipping_ports_ecm`.`infrastructure`.`project`"
  dimensions:
    - name: "project_name"
      expr: project_name
      comment: "Name of the infrastructure project"
    - name: "project_code"
      expr: project_code
      comment: "Unique project identifier code"
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project"
    - name: "project_type"
      expr: project_type
      comment: "Type of infrastructure project"
    - name: "project_category"
      expr: project_category
      comment: "Category classification of the project"
    - name: "phase"
      expr: phase
      comment: "Current phase of the project lifecycle"
    - name: "priority"
      expr: priority
      comment: "Priority level of the project"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk assessment rating for the project"
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Year the project is planned to start"
    - name: "planned_completion_year"
      expr: YEAR(planned_completion_date)
      comment: "Year the project is planned to complete"
    - name: "actual_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Year the project was actually completed"
  measures:
    - name: "total_projects"
      expr: COUNT(DISTINCT project_id)
      comment: "Total number of infrastructure projects"
    - name: "total_approved_capex_budget"
      expr: SUM(CAST(approved_capex_budget AS DOUBLE))
      comment: "Total approved capital expenditure budget across all projects"
    - name: "total_actual_expenditure"
      expr: SUM(CAST(actual_expenditure_to_date AS DOUBLE))
      comment: "Total actual expenditure to date across all projects"
    - name: "avg_project_budget"
      expr: AVG(CAST(approved_capex_budget AS DOUBLE))
      comment: "Average approved budget per project"
    - name: "total_berth_length_increase_m"
      expr: SUM(CAST(berth_length_increase_m AS DOUBLE))
      comment: "Total berth length increase from all projects in meters"
    - name: "total_capacity_increase_teu"
      expr: SUM(CAST(capacity_increase_teu AS BIGINT))
      comment: "Total container handling capacity increase in TEU from all projects"
    - name: "avg_design_vessel_loa_m"
      expr: AVG(CAST(design_vessel_loa_m AS DOUBLE))
      comment: "Average design vessel length overall for new infrastructure in meters"
    - name: "avg_channel_depth_m"
      expr: AVG(CAST(channel_depth_m AS DOUBLE))
      comment: "Average channel depth from dredging projects in meters"
    - name: "budget_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(actual_expenditure_to_date AS DOUBLE)) / NULLIF(SUM(CAST(approved_capex_budget AS DOUBLE)), 0), 2)
      comment: "Percentage of approved budget actually spent indicating financial performance"
    - name: "capex_per_teu_capacity"
      expr: ROUND(SUM(CAST(approved_capex_budget AS DOUBLE)) / NULLIF(SUM(CAST(capacity_increase_teu AS BIGINT)), 0), 2)
      comment: "Capital expenditure per TEU of capacity added for investment efficiency analysis"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse facility metrics tracking storage capacity, utilization, and specialized handling capabilities"
  source: "`shipping_ports_ecm`.`infrastructure`.`warehouse`"
  dimensions:
    - name: "warehouse_name"
      expr: warehouse_name
      comment: "Name of the warehouse facility"
    - name: "warehouse_code"
      expr: warehouse_code
      comment: "Unique warehouse identifier code"
    - name: "warehouse_type"
      expr: warehouse_type
      comment: "Type of warehouse (general, cold storage, hazmat, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the warehouse"
    - name: "bonded_status"
      expr: bonded_status
      comment: "Whether warehouse has bonded customs status"
    - name: "temperature_control_capability"
      expr: temperature_control_capability
      comment: "Temperature control capabilities of the warehouse"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure of the warehouse"
    - name: "security_level"
      expr: security_level
      comment: "Security classification level"
    - name: "construction_year"
      expr: construction_year
      comment: "Year the warehouse was constructed"
  measures:
    - name: "total_warehouses"
      expr: COUNT(DISTINCT warehouse_id)
      comment: "Total number of warehouse facilities"
    - name: "total_floor_area_sqm"
      expr: SUM(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Total floor area across all warehouses in square meters"
    - name: "total_usable_storage_area_sqm"
      expr: SUM(CAST(usable_storage_area_sqm AS DOUBLE))
      comment: "Total usable storage area in square meters"
    - name: "avg_floor_area_sqm"
      expr: AVG(CAST(total_floor_area_sqm AS DOUBLE))
      comment: "Average floor area per warehouse in square meters"
    - name: "avg_height_clearance_m"
      expr: AVG(CAST(height_clearance_m AS DOUBLE))
      comment: "Average internal height clearance in meters"
    - name: "avg_floor_load_capacity_kn_per_sqm"
      expr: AVG(CAST(floor_load_capacity_kn_per_sqm AS DOUBLE))
      comment: "Average floor load capacity in kilonewtons per square meter"
    - name: "avg_max_forklift_capacity_tonnes"
      expr: AVG(CAST(max_forklift_capacity_tonnes AS DOUBLE))
      comment: "Average maximum forklift capacity in tonnes"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage value across all warehouses"
    - name: "space_utilization_rate"
      expr: ROUND(100.0 * SUM(CAST(usable_storage_area_sqm AS DOUBLE)) / NULLIF(SUM(CAST(total_floor_area_sqm AS DOUBLE)), 0), 2)
      comment: "Percentage of total floor area that is usable storage space"
    - name: "bonded_warehouse_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN bonded_status = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warehouses with bonded customs status for duty deferral"
    - name: "temperature_controlled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_control_capability IS NOT NULL AND temperature_control_capability != 'None' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of warehouses with temperature control capabilities"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_closure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure closure event metrics tracking downtime impact, revenue loss, and operational disruption"
  source: "`shipping_ports_ecm`.`infrastructure`.`closure`"
  dimensions:
    - name: "infrastructure_type"
      expr: infrastructure_type
      comment: "Type of infrastructure affected by closure"
    - name: "closure_status"
      expr: closure_status
      comment: "Current status of the closure"
    - name: "reason"
      expr: reason
      comment: "Primary reason for the closure"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the closure"
    - name: "safety_incident_flag"
      expr: safety_incident_flag
      comment: "Whether closure was due to a safety incident"
    - name: "environmental_impact_flag"
      expr: environmental_impact_flag
      comment: "Whether closure had environmental impact"
    - name: "planned_start_year"
      expr: YEAR(planned_start_datetime)
      comment: "Year of planned closure start"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_datetime)
      comment: "Month of planned closure start"
  measures:
    - name: "total_closures"
      expr: COUNT(DISTINCT closure_id)
      comment: "Total number of infrastructure closure events"
    - name: "total_estimated_revenue_impact_usd"
      expr: SUM(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Total estimated revenue loss from all closures in USD"
    - name: "avg_estimated_revenue_impact_usd"
      expr: AVG(CAST(estimated_revenue_impact_usd AS DOUBLE))
      comment: "Average revenue impact per closure event in USD"
    - name: "total_affected_vessel_calls"
      expr: SUM(CAST(affected_vessel_calls_count AS BIGINT))
      comment: "Total number of vessel calls affected by closures"
    - name: "avg_capacity_reduction_pct"
      expr: AVG(CAST(capacity_reduction_percentage AS DOUBLE))
      comment: "Average capacity reduction percentage during closures"
    - name: "total_extensions"
      expr: SUM(CAST(extension_count AS BIGINT))
      comment: "Total number of closure extensions indicating planning accuracy"
    - name: "safety_incident_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN safety_incident_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of closures caused by safety incidents"
    - name: "environmental_impact_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN environmental_impact_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of closures with environmental impact"
    - name: "avg_affected_calls_per_closure"
      expr: AVG(CAST(affected_vessel_calls_count AS BIGINT))
      comment: "Average number of vessel calls affected per closure event"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_structural_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Structural inspection metrics tracking asset condition, defect rates, and maintenance investment requirements"
  source: "`shipping_ports_ecm`.`infrastructure`.`structural_inspection`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of asset inspected"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for the inspection"
    - name: "overall_condition_rating"
      expr: overall_condition_rating
      comment: "Overall condition rating from inspection"
    - name: "safety_risk_level"
      expr: safety_risk_level
      comment: "Safety risk level identified"
    - name: "remediation_priority"
      expr: remediation_priority
      comment: "Priority level for remediation work"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation work"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether asset meets regulatory compliance"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was performed"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was performed"
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT structural_inspection_id)
      comment: "Total number of structural inspections performed"
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated cost of repairs identified from inspections"
    - name: "avg_estimated_repair_cost"
      expr: AVG(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Average estimated repair cost per inspection"
    - name: "total_defects_identified"
      expr: SUM(CAST(defects_identified_count AS BIGINT))
      comment: "Total number of defects identified across all inspections"
    - name: "total_critical_defects"
      expr: SUM(CAST(critical_defects_count AS BIGINT))
      comment: "Total number of critical defects requiring immediate attention"
    - name: "total_major_defects"
      expr: SUM(CAST(major_defects_count AS BIGINT))
      comment: "Total number of major defects identified"
    - name: "total_minor_defects"
      expr: SUM(CAST(minor_defects_count AS BIGINT))
      comment: "Total number of minor defects identified"
    - name: "avg_inspection_duration_hours"
      expr: AVG(CAST(inspection_duration_hours AS DOUBLE))
      comment: "Average duration of inspections in hours"
    - name: "avg_defects_per_inspection"
      expr: AVG(CAST(defects_identified_count AS BIGINT))
      comment: "Average number of defects found per inspection"
    - name: "critical_defect_rate"
      expr: ROUND(100.0 * SUM(CAST(critical_defects_count AS BIGINT)) / NULLIF(SUM(CAST(defects_identified_count AS BIGINT)), 0), 2)
      comment: "Percentage of defects classified as critical indicating asset risk"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections meeting regulatory compliance standards"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`infrastructure_terminal_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal zone capacity and utilization metrics tracking storage capacity, handling capability, and operational efficiency"
  source: "`shipping_ports_ecm`.`infrastructure`.`terminal_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of terminal zone (container yard, bulk storage, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the zone"
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the zone is currently active"
    - name: "lease_status"
      expr: lease_status
      comment: "Lease status of the zone"
    - name: "handling_equipment_type"
      expr: handling_equipment_type
      comment: "Type of handling equipment used in the zone"
    - name: "hazmat_approved_flag"
      expr: hazmat_approved_flag
      comment: "Whether zone is approved for hazardous materials"
    - name: "customs_controlled_flag"
      expr: customs_controlled_flag
      comment: "Whether zone is under customs control"
    - name: "vessel_side_flag"
      expr: vessel_side_flag
      comment: "Whether zone has direct vessel-side access"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the zone was commissioned"
  measures:
    - name: "total_zones"
      expr: COUNT(DISTINCT terminal_zone_id)
      comment: "Total number of terminal zones"
    - name: "total_area_sqm"
      expr: SUM(CAST(total_area_sqm AS DOUBLE))
      comment: "Total area of all terminal zones in square meters"
    - name: "total_paved_area_sqm"
      expr: SUM(CAST(paved_area_sqm AS DOUBLE))
      comment: "Total paved area across all zones in square meters"
    - name: "total_capacity_teu"
      expr: SUM(CAST(total_capacity_teu AS BIGINT))
      comment: "Total container storage capacity in TEU across all zones"
    - name: "total_ground_slot_capacity_teu"
      expr: SUM(CAST(ground_slot_capacity_teu AS BIGINT))
      comment: "Total ground slot capacity in TEU"
    - name: "avg_area_sqm"
      expr: AVG(CAST(total_area_sqm AS DOUBLE))
      comment: "Average area per terminal zone in square meters"
    - name: "avg_design_capacity_utilization_pct"
      expr: AVG(CAST(design_capacity_utilization_pct AS DOUBLE))
      comment: "Average design capacity utilization percentage"
    - name: "total_reefer_plugs"
      expr: SUM(CAST(reefer_plug_count AS BIGINT))
      comment: "Total number of refrigerated container plug points"
    - name: "paved_area_ratio"
      expr: ROUND(100.0 * SUM(CAST(paved_area_sqm AS DOUBLE)) / NULLIF(SUM(CAST(total_area_sqm AS DOUBLE)), 0), 2)
      comment: "Percentage of total zone area that is paved for operational efficiency"
    - name: "teu_capacity_per_sqm"
      expr: ROUND(SUM(CAST(total_capacity_teu AS BIGINT)) / NULLIF(SUM(CAST(total_area_sqm AS DOUBLE)), 0), 2)
      comment: "TEU storage capacity per square meter indicating space utilization efficiency"
    - name: "hazmat_approved_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hazmat_approved_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of zones approved for hazardous materials handling"
    - name: "vessel_side_access_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vessel_side_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of zones with direct vessel-side access for efficient cargo flow"
$$;