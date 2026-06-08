-- Metric views for domain: landfill | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_tonnage_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core landfill gate operations KPIs tracking waste intake volume, tipping fee revenue, load quality, and rejection rates. Primary operational dashboard for landfill site managers and finance leadership."
  source: "`waste_management_ecm`.`landfill`.`tonnage_receipt`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Broad waste classification (MSW, C&D, special waste, etc.) enabling revenue and volume analysis by waste stream category."
    - name: "waste_subtype"
      expr: waste_subtype
      comment: "Granular waste sub-classification for detailed stream-level analysis and permit compliance tracking."
    - name: "waste_origin_type"
      expr: waste_origin_type
      comment: "Origin classification (residential, commercial, industrial) for customer segment revenue attribution."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Receipt transaction lifecycle status (completed, voided, pending) for operational throughput analysis."
    - name: "load_inspection_status"
      expr: load_inspection_status
      comment: "Inbound load inspection outcome used to track compliance and rejection trends."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method dimension for accounts receivable and cash flow analysis."
    - name: "receipt_date"
      expr: CAST(receipt_timestamp AS DATE)
      comment: "Calendar date of waste receipt derived from receipt timestamp for daily trend analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month bucket of waste receipt for monthly revenue and tonnage trend reporting."
    - name: "special_handling_code"
      expr: special_handling_code
      comment: "Special handling classification code for surcharge and compliance cost attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency revenue reporting."
  measures:
    - name: "total_net_tonnage"
      expr: SUM(CAST(net_tonnage AS DOUBLE))
      comment: "Total net waste tonnage received at the landfill gate. Primary volume KPI for capacity planning, permit compliance, and operational throughput reporting."
    - name: "total_gross_weight_tons"
      expr: SUM(CAST(gross_weight_tons AS DOUBLE))
      comment: "Total gross inbound weight in tons before tare deduction. Used for scale operations reconciliation and vehicle load compliance."
    - name: "total_tipping_fee_revenue"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE))
      comment: "Total tipping fee revenue collected at the landfill gate. Core revenue KPI for site P&L and financial forecasting."
    - name: "avg_tipping_fee_rate"
      expr: AVG(CAST(tipping_fee_rate AS DOUBLE))
      comment: "Average tipping fee rate per ton across all receipts. Tracks pricing realization versus schedule rates and informs rate negotiation strategy."
    - name: "total_receipt_transactions"
      expr: COUNT(1)
      comment: "Total number of waste receipt transactions. Baseline throughput volume metric for gate operations staffing and equipment capacity planning."
    - name: "rejected_load_count"
      expr: COUNT(CASE WHEN load_rejected_flag = TRUE THEN 1 END)
      comment: "Number of inbound loads rejected at the gate. Elevated rejection rates signal compliance risk, customer quality issues, or permit violations requiring management intervention."
    - name: "contaminated_load_count"
      expr: COUNT(CASE WHEN contamination_flag = TRUE THEN 1 END)
      comment: "Number of loads flagged for contamination. Drives recycling diversion quality programs and customer education initiatives."
    - name: "avg_net_tonnage_per_receipt"
      expr: AVG(CAST(net_tonnage AS DOUBLE))
      comment: "Average net tonnage per receipt transaction. Indicates load density trends and vehicle utilization efficiency."
    - name: "avg_moisture_content_percent"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content percentage of received waste. High moisture reduces effective airspace utilization and compaction efficiency, directly impacting landfill life."
    - name: "revenue_per_ton"
      expr: SUM(CAST(tipping_fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(net_tonnage AS DOUBLE)), 0)
      comment: "Effective revenue per net ton of waste received. Composite pricing yield KPI used by finance and operations leadership to benchmark site performance and pricing strategy."
    - name: "special_handling_receipt_count"
      expr: COUNT(CASE WHEN special_handling_code IS NOT NULL AND special_handling_code <> '' THEN 1 END)
      comment: "Number of receipts requiring special handling. Drives resource allocation for hazardous and non-standard waste streams and associated surcharge revenue tracking."
    - name: "distinct_customer_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customer accounts delivering waste. Measures customer base breadth and concentration risk for the landfill site."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_airspace_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landfill airspace utilization and remaining life KPIs. Critical for long-range capital planning, permit renewal timing, and regulatory reporting on capacity status."
  source: "`waste_management_ecm`.`landfill`.`airspace_consumption`"
  dimensions:
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the airspace measurement record (certified, preliminary, estimated) for data quality filtering."
    - name: "survey_method"
      expr: survey_method
      comment: "Survey methodology used (aerial photogrammetry, LiDAR, ground survey) for measurement accuracy benchmarking."
    - name: "regulatory_reporting_period"
      expr: regulatory_reporting_period
      comment: "Regulatory reporting period label for compliance submission alignment and period-over-period comparison."
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_date)
      comment: "Month of airspace measurement for trend analysis of consumption rate over time."
    - name: "measurement_year"
      expr: DATE_TRUNC('YEAR', measurement_date)
      comment: "Year of airspace measurement for annual capacity consumption reporting."
    - name: "projected_closure_date"
      expr: projected_closure_date
      comment: "Projected site closure date as of each measurement, enabling trend analysis of closure timeline changes."
  measures:
    - name: "total_volume_consumed_cubic_yards"
      expr: SUM(CAST(volume_consumed_cubic_yards AS DOUBLE))
      comment: "Total airspace volume consumed in the measurement period in cubic yards. Primary capacity consumption KPI for permit compliance and closure planning."
    - name: "avg_remaining_permitted_airspace_cy"
      expr: AVG(CAST(remaining_permitted_airspace_cubic_yards AS DOUBLE))
      comment: "Average remaining permitted airspace in cubic yards across measurement records. Key indicator for site life and capital investment trigger for expansion permits."
    - name: "avg_years_remaining_capacity"
      expr: AVG(CAST(years_remaining_capacity AS DOUBLE))
      comment: "Average estimated years of remaining capacity. Executive-level site life KPI used to trigger permit renewal, expansion planning, and capital allocation decisions."
    - name: "avg_consumption_rate_cy_per_day"
      expr: AVG(CAST(rate_cubic_yards_per_day AS DOUBLE))
      comment: "Average airspace consumption rate in cubic yards per day. Tracks operational throughput intensity and is used to project closure dates and validate capacity plan assumptions."
    - name: "total_waste_tonnage_placed"
      expr: SUM(CAST(waste_tonnage_placed_tons AS DOUBLE))
      comment: "Total waste tonnage placed during measurement periods. Reconciles scale-house tonnage receipts against surveyed airspace consumption for operational accuracy."
    - name: "total_msw_tonnage"
      expr: SUM(CAST(msw_tonnage_tons AS DOUBLE))
      comment: "Total municipal solid waste tonnage placed. Tracks MSW stream volume for permit compliance against daily and annual acceptance rate limits."
    - name: "total_special_waste_tonnage"
      expr: SUM(CAST(special_waste_tonnage_tons AS DOUBLE))
      comment: "Total special waste tonnage placed. Monitors special waste stream volumes against permit conditions and approved disposal limits."
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio AS DOUBLE))
      comment: "Average waste compaction ratio achieved. Higher compaction extends site life; this KPI drives equipment investment and operational efficiency decisions."
    - name: "avg_in_place_density_lbs_per_cy"
      expr: AVG(CAST(in_place_density_lbs_per_cubic_yard AS DOUBLE))
      comment: "Average achieved in-place waste density in lbs per cubic yard. Compared against design density to assess compaction performance and airspace efficiency."
    - name: "airspace_utilization_pct"
      expr: SUM(CAST(cumulative_volume_consumed_cubic_yards AS DOUBLE)) / NULLIF(SUM(CAST(total_permitted_capacity_cubic_yards AS DOUBLE)), 0) * 100.0
      comment: "Percentage of total permitted airspace capacity consumed to date. Critical executive KPI for site life management — triggers expansion permit applications and closure financial assurance reviews when thresholds are crossed."
    - name: "total_cover_material_volume_cy"
      expr: SUM(CAST(cover_material_volume_cubic_yards AS DOUBLE))
      comment: "Total cover material volume applied in cubic yards. Cover material consumes permitted airspace without generating revenue; minimizing this ratio improves effective site life."
    - name: "measurement_count"
      expr: COUNT(1)
      comment: "Number of airspace measurement records. Baseline count for survey frequency compliance and data completeness auditing."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_leachate_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leachate generation, collection, and disposal KPIs for environmental compliance and cost management. Leachate management is a major operational cost driver and regulatory risk area for landfill sites."
  source: "`waste_management_ecm`.`landfill`.`leachate_collection`"
  dimensions:
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect leachate (pump, gravity, sump) for operational efficiency benchmarking."
    - name: "collection_point_type"
      expr: collection_point_type
      comment: "Type of collection point (primary sump, secondary sump, perimeter drain) for system performance analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Leachate disposal method (POTW, on-site treatment, hauling) for cost and compliance tracking."
    - name: "collection_system_status"
      expr: collection_system_status
      comment: "Operational status of the leachate collection system for availability and maintenance planning."
    - name: "liner_integrity_status"
      expr: liner_integrity_status
      comment: "Liner integrity assessment status — critical environmental risk indicator for regulatory compliance."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at time of collection for precipitation-driven leachate generation correlation analysis."
    - name: "collection_month"
      expr: DATE_TRUNC('MONTH', collection_date)
      comment: "Month of leachate collection for seasonal trend analysis and annual disposal cost forecasting."
    - name: "collection_year"
      expr: DATE_TRUNC('YEAR', collection_date)
      comment: "Year of leachate collection for annual regulatory reporting and budget variance analysis."
  measures:
    - name: "total_volume_collected_gallons"
      expr: SUM(CAST(volume_collected_gallons AS DOUBLE))
      comment: "Total leachate volume collected in gallons. Primary operational volume KPI for treatment capacity planning and regulatory permit limit compliance."
    - name: "total_disposal_volume_gallons"
      expr: SUM(CAST(disposal_volume_gallons AS DOUBLE))
      comment: "Total leachate volume disposed in gallons. Reconciles collected versus disposed volumes to identify storage or treatment gaps."
    - name: "total_disposal_cost_usd"
      expr: SUM(CAST(disposal_cost_usd AS DOUBLE))
      comment: "Total leachate disposal cost in USD. Major operational cost KPI — drives make-vs-buy decisions for on-site treatment versus off-site hauling."
    - name: "avg_disposal_cost_per_gallon"
      expr: SUM(CAST(disposal_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(disposal_volume_gallons AS DOUBLE)), 0)
      comment: "Average disposal cost per gallon of leachate. Unit cost efficiency KPI for benchmarking disposal contracts and evaluating treatment technology investments."
    - name: "avg_leachate_head_level_inches"
      expr: AVG(CAST(leachate_head_level_inches AS DOUBLE))
      comment: "Average leachate head level in inches above the liner. Regulatory compliance KPI — elevated head levels indicate collection system underperformance and trigger permit violations."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average leachate pH level. Tracks leachate chemistry for treatment process optimization and permit limit compliance."
    - name: "avg_bod_mg_l"
      expr: AVG(CAST(bod_mg_l AS DOUBLE))
      comment: "Average biochemical oxygen demand in mg/L. Key leachate strength indicator used to size treatment systems and assess disposal permit compliance."
    - name: "avg_cod_mg_l"
      expr: AVG(CAST(cod_mg_l AS DOUBLE))
      comment: "Average chemical oxygen demand in mg/L. Tracks organic loading in leachate for treatment efficiency and regulatory reporting."
    - name: "permit_exceedance_count"
      expr: COUNT(CASE WHEN permit_limit_compliance_flag = FALSE THEN 1 END)
      comment: "Number of leachate collection events where permit limits were exceeded. Regulatory risk KPI — exceedances trigger agency notifications, enforcement actions, and potential fines."
    - name: "collection_event_count"
      expr: COUNT(1)
      comment: "Total number of leachate collection events. Baseline operational frequency metric for system performance and regulatory reporting completeness."
    - name: "avg_precipitation_last_24h_inches"
      expr: AVG(CAST(precipitation_last_24h_inches AS DOUBLE))
      comment: "Average precipitation in the 24 hours preceding collection. Quantifies rainfall-driven leachate generation for seasonal capacity planning and stormwater management."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_lfg_monitoring`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landfill gas (LFG) monitoring KPIs covering methane concentration, flow rates, exceedances, and compliance status. LFG management is critical for GHG regulatory compliance, safety, and renewable energy revenue potential."
  source: "`waste_management_ecm`.`landfill`.`lfg_monitoring`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "LFG monitoring compliance status for regulatory reporting and enforcement risk tracking."
    - name: "monitoring_point_type"
      expr: monitoring_point_type
      comment: "Type of monitoring point (extraction well, perimeter probe, surface scan) for system-level performance analysis."
    - name: "monitoring_method"
      expr: monitoring_method
      comment: "Monitoring methodology used for data quality and regulatory method compliance tracking."
    - name: "exceedance_type"
      expr: exceedance_type
      comment: "Type of regulatory exceedance detected (LEL, surface emission, perimeter) for targeted corrective action prioritization."
    - name: "monitoring_frequency"
      expr: monitoring_frequency
      comment: "Required monitoring frequency for compliance schedule adherence analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions at monitoring time for correlation analysis with gas migration patterns."
    - name: "monitoring_month"
      expr: DATE_TRUNC('MONTH', monitoring_date)
      comment: "Month of LFG monitoring event for trend analysis of gas generation rates and compliance performance."
    - name: "monitoring_year"
      expr: DATE_TRUNC('YEAR', monitoring_date)
      comment: "Year of LFG monitoring for annual GHG regulatory reporting and year-over-year performance comparison."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality assessment flag for filtering valid versus suspect monitoring readings."
  measures:
    - name: "avg_methane_concentration_pct"
      expr: AVG(CAST(methane_concentration_pct AS DOUBLE))
      comment: "Average methane concentration percentage across monitoring points. Core LFG quality KPI — higher methane content increases energy recovery value and indicates active waste decomposition."
    - name: "avg_lfg_flow_rate_scfm"
      expr: AVG(CAST(lfg_flow_rate_scfm AS DOUBLE))
      comment: "Average LFG flow rate in standard cubic feet per minute. Tracks gas generation intensity for energy recovery planning and extraction system optimization."
    - name: "total_lfg_flow_rate_scfm"
      expr: SUM(CAST(lfg_flow_rate_scfm AS DOUBLE))
      comment: "Total LFG flow rate across all monitored wells. Aggregate gas generation volume KPI for RNG/energy project feasibility and GHG emissions inventory."
    - name: "exceedance_event_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of LFG monitoring events with regulatory exceedances. Critical compliance KPI — exceedances trigger mandatory corrective actions, agency notifications, and potential permit violations."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of monitoring events requiring corrective action. Operational risk KPI driving maintenance work order prioritization and compliance response timelines."
    - name: "avg_lel_percentage"
      expr: AVG(CAST(lel_percentage AS DOUBLE))
      comment: "Average lower explosive limit percentage at monitoring points. Safety-critical KPI — LEL readings approaching 100% indicate explosive gas migration risk requiring immediate intervention."
    - name: "avg_carbon_dioxide_concentration_pct"
      expr: AVG(CAST(carbon_dioxide_concentration_pct AS DOUBLE))
      comment: "Average CO2 concentration percentage. Used alongside methane readings for GHG emissions inventory and gas quality assessment for energy recovery."
    - name: "avg_hydrogen_sulfide_ppm"
      expr: AVG(CAST(hydrogen_sulfide_ppm AS DOUBLE))
      comment: "Average hydrogen sulfide concentration in ppm. H2S is a safety and odor compliance concern — elevated levels trigger community complaints and regulatory scrutiny."
    - name: "monitoring_event_count"
      expr: COUNT(1)
      comment: "Total number of LFG monitoring events. Baseline compliance frequency metric for verifying monitoring schedule adherence against permit requirements."
    - name: "exceedance_rate_pct"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of monitoring events with exceedances. Normalized compliance performance KPI enabling cross-site and period-over-period benchmarking of LFG regulatory performance."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_groundwater_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Groundwater quality monitoring KPIs for landfill environmental compliance. Groundwater exceedances are among the highest-consequence regulatory events, triggering CERCLA/RCRA corrective action programs and significant financial liability."
  source: "`waste_management_ecm`.`landfill`.`groundwater_sample`"
  dimensions:
    - name: "monitoring_program_type"
      expr: monitoring_program_type
      comment: "Type of monitoring program (detection, assessment, corrective action) for compliance stage tracking."
    - name: "sample_type"
      expr: sample_type
      comment: "Sample type classification (routine, confirmation, split) for data quality and regulatory validity analysis."
    - name: "sampling_method"
      expr: sampling_method
      comment: "Sampling methodology used for regulatory method compliance and data comparability analysis."
    - name: "qa_qc_flag"
      expr: qa_qc_flag
      comment: "QA/QC assessment flag for filtering valid versus rejected analytical results."
    - name: "sample_month"
      expr: DATE_TRUNC('MONTH', sample_date)
      comment: "Month of groundwater sampling for seasonal trend analysis and regulatory reporting period alignment."
    - name: "sample_year"
      expr: DATE_TRUNC('YEAR', sample_date)
      comment: "Year of groundwater sampling for annual compliance reporting and long-term trend analysis."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions at sampling time for data quality context and seasonal variation analysis."
  measures:
    - name: "total_samples_collected"
      expr: COUNT(1)
      comment: "Total number of groundwater samples collected. Baseline compliance frequency KPI for verifying sampling schedule adherence against permit and monitoring program requirements."
    - name: "exceedance_detected_count"
      expr: COUNT(CASE WHEN exceedance_detected_flag = TRUE THEN 1 END)
      comment: "Number of samples with detected groundwater protection standard exceedances. Highest-consequence environmental compliance KPI — exceedances trigger regulatory notifications, corrective action programs, and potential CERCLA liability."
    - name: "exceedance_rate_pct"
      expr: COUNT(CASE WHEN exceedance_detected_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of groundwater samples with exceedances. Normalized compliance performance KPI for cross-well and cross-site benchmarking of groundwater quality trends."
    - name: "regulatory_notification_required_count"
      expr: COUNT(CASE WHEN regulatory_notification_required_flag = TRUE THEN 1 END)
      comment: "Number of samples triggering mandatory regulatory notification. Tracks regulatory reporting obligations and associated enforcement risk exposure."
    - name: "cercla_reportable_count"
      expr: COUNT(CASE WHEN cercla_reportable_flag = TRUE THEN 1 END)
      comment: "Number of samples with CERCLA-reportable detections. Tracks Superfund liability exposure — a critical financial risk KPI for executive and legal leadership."
    - name: "avg_field_ph"
      expr: AVG(CAST(field_ph AS DOUBLE))
      comment: "Average field-measured pH of groundwater samples. pH trends indicate leachate migration and liner integrity issues requiring early intervention."
    - name: "avg_field_conductivity_umhos"
      expr: AVG(CAST(field_conductivity_umhos AS DOUBLE))
      comment: "Average field conductivity in micromhos. Elevated conductivity is an early indicator of leachate impact on groundwater, enabling proactive corrective action before formal exceedances occur."
    - name: "avg_purge_volume_gallons"
      expr: AVG(CAST(purge_volume_gallons AS DOUBLE))
      comment: "Average well purge volume in gallons. Validates sampling protocol compliance and well development adequacy for data defensibility in regulatory proceedings."
    - name: "distinct_wells_sampled"
      expr: COUNT(DISTINCT groundwater_monitoring_well_id)
      comment: "Number of distinct groundwater monitoring wells sampled. Tracks monitoring network coverage completeness against permit-required well inventory."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_regulatory_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory inspection outcomes, violation tracking, and enforcement action KPIs. Inspection performance directly impacts permit standing, operational continuity, and financial penalty exposure."
  source: "`waste_management_ecm`.`landfill`.`regulatory_inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of regulatory inspection (routine, complaint-driven, follow-up, comprehensive) for compliance program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record (open, closed, pending response) for compliance action tracking."
    - name: "inspecting_agency"
      expr: inspecting_agency
      comment: "Regulatory agency conducting the inspection for agency-level compliance relationship management."
    - name: "agency_jurisdiction"
      expr: agency_jurisdiction
      comment: "Jurisdictional level of the inspecting agency (federal, state, local) for regulatory risk stratification."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of inspection findings for risk prioritization and corrective action resource allocation."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of required corrective actions for open item tracking and regulatory deadline management."
    - name: "rcra_compliance_status"
      expr: rcra_compliance_status
      comment: "RCRA compliance status classification for federal hazardous waste regulatory standing."
    - name: "inspection_year"
      expr: DATE_TRUNC('YEAR', inspection_date)
      comment: "Year of inspection for annual compliance trend analysis and regulatory relationship reporting."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month of inspection for seasonal compliance pattern analysis."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of regulatory inspections. Baseline compliance activity metric for regulatory relationship management and resource planning."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties assessed from regulatory inspections. Direct financial impact KPI for compliance program ROI analysis and executive risk reporting."
    - name: "avg_penalty_per_inspection"
      expr: SUM(CAST(penalty_amount AS DOUBLE)) / NULLIF(COUNT(1), 0)
      comment: "Average penalty amount per inspection. Tracks enforcement intensity trends and benchmarks compliance program effectiveness over time."
    - name: "inspections_with_violations_count"
      expr: COUNT(CASE WHEN penalty_amount > 0 OR corrective_action_required IS NOT NULL THEN 1 END)
      comment: "Number of inspections resulting in violations or required corrective actions. Core compliance performance KPI for permit standing and regulatory relationship health."
    - name: "follow_up_inspection_required_count"
      expr: COUNT(CASE WHEN follow_up_inspection_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring follow-up visits. Elevated follow-up rates indicate systemic compliance gaps requiring management intervention."
    - name: "avg_inspection_duration_hours"
      expr: AVG(CAST(inspection_duration_hours AS DOUBLE))
      comment: "Average inspection duration in hours. Longer inspections typically indicate more complex findings; tracks regulatory scrutiny intensity over time."
    - name: "open_corrective_actions_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('Closed', 'Completed') AND corrective_action_status IS NOT NULL THEN 1 END)
      comment: "Number of inspections with open corrective action items. Tracks outstanding regulatory obligations and associated enforcement escalation risk."
    - name: "cercla_relevant_inspection_count"
      expr: COUNT(CASE WHEN cercla_relevance = TRUE THEN 1 END)
      comment: "Number of inspections with CERCLA relevance. Tracks Superfund program exposure — a high-consequence financial and reputational risk for the organization."
    - name: "swis_reporting_required_count"
      expr: COUNT(CASE WHEN swis_reporting_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring SWIS (Solid Waste Information System) reporting submissions. Tracks state regulatory reporting obligations and submission deadline compliance."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_daily_cover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily cover application compliance and operational efficiency KPIs. Daily cover is a regulatory requirement at all active landfill cells — non-compliance triggers violations, odor complaints, and vector/fire risk."
  source: "`waste_management_ecm`.`landfill`.`daily_cover`"
  dimensions:
    - name: "cover_material_type"
      expr: cover_material_type
      comment: "Type of cover material applied (soil, ADC, tarps) for cost and compliance analysis by material category."
    - name: "shift"
      expr: shift
      comment: "Work shift during which cover was applied for operational performance analysis by shift."
    - name: "record_status"
      expr: record_status
      comment: "Record lifecycle status for data quality filtering and compliance record completeness auditing."
    - name: "weather_conditions"
      expr: weather_conditions
      comment: "Weather conditions during cover application for operational context and compliance exception analysis."
    - name: "cover_month"
      expr: DATE_TRUNC('MONTH', cover_date)
      comment: "Month of cover application for monthly compliance rate trending and cost reporting."
    - name: "cover_year"
      expr: DATE_TRUNC('YEAR', cover_date)
      comment: "Year of cover application for annual regulatory compliance reporting."
  measures:
    - name: "total_volume_applied_cubic_yards"
      expr: SUM(CAST(volume_applied_cubic_yards AS DOUBLE))
      comment: "Total cover material volume applied in cubic yards. Tracks airspace consumed by cover material — a non-revenue cost that reduces effective site life."
    - name: "total_cover_material_cost_usd"
      expr: SUM(CAST(cover_material_cost_usd AS DOUBLE))
      comment: "Total cost of cover materials applied. Major operational cost KPI for budget management and ADC (alternative daily cover) program ROI analysis."
    - name: "avg_thickness_achieved_inches"
      expr: AVG(CAST(thickness_achieved_inches AS DOUBLE))
      comment: "Average cover thickness achieved in inches. Regulatory compliance KPI — minimum thickness requirements (typically 6 inches) must be met daily to avoid violations."
    - name: "compliance_rate_pct"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of daily cover events meeting regulatory compliance requirements. Core compliance performance KPI — below-threshold rates trigger regulatory scrutiny and corrective action requirements."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of cover events requiring corrective action. Tracks compliance deficiency frequency for operational improvement programs."
    - name: "avg_working_face_area_sq_ft"
      expr: AVG(CAST(working_face_area_square_feet AS DOUBLE))
      comment: "Average active working face area in square feet. Larger working faces require more cover material and labor — this KPI drives working face management decisions to optimize cost and compliance."
    - name: "total_equipment_hours"
      expr: SUM(CAST(equipment_hours AS DOUBLE))
      comment: "Total equipment hours consumed for daily cover operations. Labor and equipment cost driver KPI for operational efficiency benchmarking."
    - name: "total_labor_hours"
      expr: SUM(CAST(labor_hours AS DOUBLE))
      comment: "Total labor hours consumed for daily cover operations. Workforce planning KPI for cover crew sizing and shift scheduling optimization."
    - name: "cost_per_cubic_yard"
      expr: SUM(CAST(cover_material_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(volume_applied_cubic_yards AS DOUBLE)), 0)
      comment: "Average cost per cubic yard of cover material applied. Unit cost efficiency KPI for benchmarking cover material procurement and ADC program economics."
    - name: "cover_event_count"
      expr: COUNT(1)
      comment: "Total number of daily cover events recorded. Baseline compliance frequency metric for verifying daily cover application against active operating days."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_capacity_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Landfill capacity planning KPIs for long-range site life management, expansion decision-making, and capital investment planning. Capacity plans are the primary strategic planning instrument for landfill asset management."
  source: "`waste_management_ecm`.`landfill`.`capacity_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the capacity plan (draft, approved, active, superseded) for plan lifecycle management."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan (baseline, expansion, post-closure) for strategic planning category analysis."
    - name: "expansion_permit_status"
      expr: expansion_permit_status
      comment: "Status of expansion permit application for capital project pipeline and regulatory timeline tracking."
    - name: "lateral_expansion_planned"
      expr: CAST(lateral_expansion_planned AS STRING)
      comment: "Flag indicating whether lateral expansion is planned — key capital investment decision dimension."
    - name: "vertical_expansion_planned"
      expr: CAST(vertical_expansion_planned AS STRING)
      comment: "Flag indicating whether vertical expansion is planned — alternative to lateral expansion for sites with constrained footprint."
    - name: "permit_renewal_required"
      expr: CAST(permit_renewal_required AS STRING)
      comment: "Flag indicating permit renewal is required — triggers regulatory timeline and capital planning actions."
    - name: "planning_horizon_years"
      expr: planning_horizon_years
      comment: "Planning horizon in years for capacity plan scope classification."
    - name: "projected_closure_year"
      expr: projected_closure_year
      comment: "Projected site closure year for long-range capital and post-closure financial planning."
    - name: "plan_effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the capacity plan became effective for plan vintage analysis."
  measures:
    - name: "avg_remaining_airspace_cy"
      expr: AVG(CAST(remaining_airspace_cy AS DOUBLE))
      comment: "Average remaining airspace in cubic yards across active capacity plans. Primary site life KPI for capital allocation and expansion permit timing decisions."
    - name: "avg_projected_site_life_years"
      expr: AVG(CAST(projected_site_life_years AS DOUBLE))
      comment: "Average projected remaining site life in years. Executive-level strategic KPI for portfolio management — sites with short remaining life require immediate expansion or replacement planning."
    - name: "total_capital_investment_required"
      expr: SUM(CAST(capital_investment_required AS DOUBLE))
      comment: "Total capital investment required across capacity plans. Aggregates planned capital expenditure for landfill expansion and development for CFO-level capital budget planning."
    - name: "avg_annual_waste_acceptance_rate_tons"
      expr: AVG(CAST(annual_waste_acceptance_rate_tons AS DOUBLE))
      comment: "Average planned annual waste acceptance rate in tons. Validates operational throughput assumptions in capacity plans against actual tonnage receipts."
    - name: "avg_annual_waste_acceptance_rate_tpd"
      expr: AVG(CAST(annual_waste_acceptance_rate_tpd AS DOUBLE))
      comment: "Average planned daily waste acceptance rate in tons per day. Operational capacity planning KPI for permit limit compliance and gate operations staffing."
    - name: "total_lateral_expansion_capacity_cy"
      expr: SUM(CAST(lateral_expansion_capacity_cy AS DOUBLE))
      comment: "Total planned lateral expansion capacity in cubic yards. Quantifies the pipeline of permitted expansion airspace for long-range site life extension planning."
    - name: "total_vertical_expansion_capacity_cy"
      expr: SUM(CAST(vertical_expansion_capacity_cy AS DOUBLE))
      comment: "Total planned vertical expansion capacity in cubic yards. Tracks above-grade airspace development potential as an alternative to lateral footprint expansion."
    - name: "avg_compaction_ratio_assumption"
      expr: AVG(CAST(compaction_ratio_assumption AS DOUBLE))
      comment: "Average compaction ratio assumption used in capacity plans. Benchmarks planning assumptions against actual achieved compaction ratios to validate plan accuracy."
    - name: "capacity_plan_count"
      expr: COUNT(1)
      comment: "Total number of capacity plan records. Baseline count for plan portfolio management and version control auditing."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_special_waste_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special waste approval pipeline KPIs tracking approval rates, volumes, and regulatory compliance for non-standard waste streams. Special waste generates premium tipping fees and carries elevated regulatory and liability risk."
  source: "`waste_management_ecm`.`landfill`.`special_waste_approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current approval status (approved, rejected, pending, expired) for pipeline management and conversion rate analysis."
    - name: "waste_classification"
      expr: waste_classification
      comment: "Waste classification category (hazardous, non-hazardous, special) for risk and revenue segmentation."
    - name: "waste_origin_state_code"
      expr: waste_origin_state_code
      comment: "State of waste origin for interstate waste flow analysis and regulatory jurisdiction tracking."
    - name: "regulatory_notification_required"
      expr: CAST(regulatory_notification_required AS STRING)
      comment: "Flag indicating regulatory notification is required — tracks compliance obligations associated with special waste approvals."
    - name: "environmental_review_required"
      expr: CAST(environmental_review_required AS STRING)
      comment: "Flag indicating environmental review is required — tracks review burden and approval cycle time drivers."
    - name: "tclp_results_available"
      expr: CAST(tclp_results_available AS STRING)
      comment: "Flag indicating TCLP (Toxicity Characteristic Leaching Procedure) test results are available — required for hazardous waste characterization."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_date)
      comment: "Month of approval request for pipeline volume trend analysis."
    - name: "request_year"
      expr: DATE_TRUNC('YEAR', request_date)
      comment: "Year of approval request for annual special waste program performance reporting."
  measures:
    - name: "total_approval_requests"
      expr: COUNT(1)
      comment: "Total number of special waste approval requests. Baseline pipeline volume KPI for staffing the environmental review and approval process."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END)
      comment: "Number of approved special waste requests. Tracks approval throughput and program capacity for premium waste stream revenue generation."
    - name: "rejected_request_count"
      expr: COUNT(CASE WHEN approval_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected special waste requests. Rejection trends indicate waste stream risk profile changes or permit constraint tightening."
    - name: "approval_rate_pct"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of special waste requests approved. Conversion rate KPI for the special waste business development pipeline — low rates indicate overly conservative screening or permit constraints."
    - name: "total_approved_tonnage_limit"
      expr: SUM(CAST(approved_tonnage_limit AS DOUBLE))
      comment: "Total approved tonnage limit across all approved special waste requests. Quantifies the permitted special waste volume pipeline for revenue forecasting."
    - name: "total_estimated_volume_tons"
      expr: SUM(CAST(estimated_volume_tons AS DOUBLE))
      comment: "Total estimated volume in tons across all requests. Tracks the gross special waste opportunity pipeline for business development and capacity planning."
    - name: "avg_approved_tonnage_per_request"
      expr: AVG(CAST(approved_tonnage_limit AS DOUBLE))
      comment: "Average approved tonnage per special waste request. Tracks deal size trends for revenue per approval and resource allocation efficiency."
    - name: "regulatory_notification_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE THEN 1 END)
      comment: "Number of approvals requiring regulatory notification. Tracks compliance reporting obligations and associated administrative burden for the environmental team."
    - name: "distinct_customer_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customer accounts submitting special waste approvals. Measures customer base breadth for the special waste program and concentration risk."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`landfill_stormwater_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stormwater discharge monitoring and compliance KPIs. Stormwater permit exceedances at landfills trigger NPDES enforcement actions and can indicate leachate co-mingling — a significant environmental liability."
  source: "`waste_management_ecm`.`landfill`.`stormwater_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of stormwater event (discharge, inspection, BMP assessment) for compliance activity categorization."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the stormwater event record for open item tracking and regulatory response management."
    - name: "bmp_inspection_status"
      expr: bmp_inspection_status
      comment: "Best management practice inspection status for BMP effectiveness and maintenance tracking."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of stormwater event for seasonal discharge pattern analysis and permit reporting period alignment."
    - name: "event_year"
      expr: DATE_TRUNC('YEAR', event_date)
      comment: "Year of stormwater event for annual NPDES permit reporting and year-over-year compliance trend analysis."
  measures:
    - name: "total_discharge_volume_gallons"
      expr: SUM(CAST(discharge_volume_gallons AS DOUBLE))
      comment: "Total stormwater discharge volume in gallons. Tracks discharge loading for NPDES permit compliance and watershed impact assessment."
    - name: "exceedance_event_count"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END)
      comment: "Number of stormwater events with permit limit exceedances. NPDES compliance KPI — exceedances trigger mandatory reporting, corrective action, and potential enforcement."
    - name: "exceedance_rate_pct"
      expr: COUNT(CASE WHEN exceedance_flag = TRUE THEN 1 END) * 100.0 / NULLIF(COUNT(1), 0)
      comment: "Percentage of stormwater events with permit exceedances. Normalized compliance performance KPI for benchmarking site stormwater management effectiveness."
    - name: "avg_tss_mg_l"
      expr: AVG(CAST(tss_mg_l AS DOUBLE))
      comment: "Average total suspended solids concentration in mg/L. Primary stormwater quality parameter — elevated TSS indicates erosion control failures and triggers permit violations."
    - name: "avg_ph_level"
      expr: AVG(CAST(ph_level AS DOUBLE))
      comment: "Average pH of stormwater discharge. pH outside permit limits (typically 6.0-9.0) indicates leachate co-mingling or chemical contamination requiring immediate investigation."
    - name: "avg_precipitation_amount_inches"
      expr: AVG(CAST(precipitation_amount_inches AS DOUBLE))
      comment: "Average precipitation amount in inches per stormwater event. Correlates discharge volume and quality with storm intensity for BMP sizing and design validation."
    - name: "total_stormwater_events"
      expr: COUNT(1)
      comment: "Total number of stormwater monitoring events. Baseline compliance frequency metric for NPDES permit monitoring schedule adherence."
    - name: "avg_discharge_flow_rate_gpm"
      expr: AVG(CAST(discharge_flow_rate_gpm AS DOUBLE))
      comment: "Average stormwater discharge flow rate in gallons per minute. Tracks peak discharge intensity for detention basin and BMP capacity adequacy assessment."
$$;