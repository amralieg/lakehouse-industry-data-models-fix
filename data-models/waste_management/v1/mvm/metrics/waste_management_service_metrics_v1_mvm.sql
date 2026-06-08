-- Metric views for domain: service | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service area management — tracks geographic coverage, diversion rate targets, program availability, and operational readiness across residential and commercial service areas. Used by operations and sustainability leadership to evaluate area-level performance and compliance posture."
  source: "`waste_management_ecm`.`service`.`area`"
  dimensions:
    - name: "area_type"
      expr: area_type
      comment: "Classification of the service area (e.g., residential, commercial, mixed-use) — primary segmentation axis for area-level KPIs."
    - name: "state_code"
      expr: state_code
      comment: "US state code for the service area — enables geographic rollup and state-level regulatory reporting."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the area (e.g., active, suspended, pending) — used to filter active vs. inactive areas in dashboards."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the area — critical for compliance reporting and franchise management."
    - name: "recycling_program_available"
      expr: recycling_program_available
      comment: "Boolean flag indicating whether a recycling program is available in the area — used to segment areas by sustainability program coverage."
    - name: "organics_program_available"
      expr: organics_program_available
      comment: "Boolean flag indicating whether an organics/composting program is available — used to track organics diversion program rollout."
    - name: "hazmat_collection_available"
      expr: hazmat_collection_available
      comment: "Boolean flag indicating whether hazardous material collection is offered — used to assess hazmat service coverage."
    - name: "service_frequency_residential"
      expr: service_frequency_residential
      comment: "Standard residential collection frequency for the area — used to segment areas by service intensity."
    - name: "franchise_expiration_date"
      expr: DATE_TRUNC('month', franchise_expiration_date)
      comment: "Month-truncated franchise expiration date — used to identify areas with near-term franchise renewal risk."
  measures:
    - name: "total_service_areas"
      expr: COUNT(1)
      comment: "Total number of service areas — baseline headcount for area portfolio management and capacity planning."
    - name: "avg_diversion_rate_target_pct"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average diversion rate target (%) across service areas — tracks the portfolio-level sustainability ambition and informs whether targets are aligned with regulatory mandates."
    - name: "total_square_miles_covered"
      expr: SUM(CAST(square_miles AS DOUBLE))
      comment: "Total geographic coverage in square miles across all service areas — used by operations leadership to assess fleet deployment needs and route density."
    - name: "avg_square_miles_per_area"
      expr: AVG(CAST(square_miles AS DOUBLE))
      comment: "Average square miles per service area — informs route optimization decisions and identifies areas that may be over- or under-sized for efficient collection."
    - name: "recycling_program_coverage_count"
      expr: COUNT(CASE WHEN recycling_program_available = TRUE THEN 1 END)
      comment: "Number of service areas with an active recycling program — measures recycling program rollout breadth across the service portfolio."
    - name: "organics_program_coverage_count"
      expr: COUNT(CASE WHEN organics_program_available = TRUE THEN 1 END)
      comment: "Number of service areas with an active organics/composting program — tracks organics diversion program expansion progress."
    - name: "hazmat_coverage_count"
      expr: COUNT(CASE WHEN hazmat_collection_available = TRUE THEN 1 END)
      comment: "Number of service areas offering hazardous material collection — used to assess hazmat service network coverage and regulatory compliance exposure."
    - name: "route_optimization_enabled_count"
      expr: COUNT(CASE WHEN route_optimization_enabled = TRUE THEN 1 END)
      comment: "Number of service areas with route optimization enabled — measures operational efficiency technology adoption across the area portfolio."
    - name: "gps_tracking_required_count"
      expr: COUNT(CASE WHEN gps_tracking_required = TRUE THEN 1 END)
      comment: "Number of service areas requiring GPS tracking — used to assess fleet telematics compliance obligations and technology deployment scope."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service bundle management — tracks bundle pricing, discount depth, sustainability certification, GHG reduction commitments, and lifecycle health across the service product portfolio. Used by product management, pricing, and sustainability teams."
  source: "`waste_management_ecm`.`service`.`bundle`"
  dimensions:
    - name: "bundle_type"
      expr: bundle_type
      comment: "Type classification of the bundle (e.g., residential, commercial, industrial) — primary segmentation axis for bundle portfolio analysis."
    - name: "bundle_category"
      expr: bundle_category
      comment: "Business category of the bundle — used to group bundles by service line or market segment for pricing and margin analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the bundle (e.g., active, deprecated, pending) — used to filter active vs. retired bundles in portfolio reviews."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the bundle (e.g., flat rate, per-unit, tiered) — used to segment bundles by revenue model for pricing strategy analysis."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the bundle is sold (e.g., direct, broker, online) — used to evaluate channel-level bundle performance."
    - name: "sustainability_certified_flag"
      expr: sustainability_certified_flag
      comment: "Boolean flag indicating whether the bundle carries a sustainability certification — used to track certified vs. non-certified bundle mix."
    - name: "promotional_flag"
      expr: promotional_flag
      comment: "Boolean flag indicating whether the bundle is currently under a promotional offer — used to isolate promotional pricing impact on revenue."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the bundle (e.g., approved, pending, rejected) — used to track bundle governance pipeline."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date of the bundle — used to analyze bundle launch cadence and cohort pricing trends."
  measures:
    - name: "total_bundles"
      expr: COUNT(1)
      comment: "Total number of service bundles in the portfolio — baseline measure for product catalog size and governance tracking."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across all bundles — used by pricing teams to benchmark bundle pricing levels and detect outliers."
    - name: "total_base_price_value"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base prices across all bundles — proxy for total catalog list value, used in pricing portfolio reviews."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across bundles — measures overall discount depth in the bundle portfolio; high values signal margin risk."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount across all bundles — quantifies the revenue concession embedded in the current bundle catalog."
    - name: "avg_diversion_rate_target_pct"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average diversion rate target (%) committed across bundles — measures the sustainability ambition embedded in the bundle portfolio."
    - name: "total_ghg_reduction_co2e_tons"
      expr: SUM(CAST(ghg_reduction_co2e_tons AS DOUBLE))
      comment: "Total GHG reduction commitment (CO2e tons) across all bundles — key sustainability KPI for ESG reporting and carbon offset program management."
    - name: "avg_ghg_reduction_co2e_tons"
      expr: AVG(CAST(ghg_reduction_co2e_tons AS DOUBLE))
      comment: "Average GHG reduction commitment per bundle — used to compare sustainability performance across bundle types and channels."
    - name: "sustainability_certified_bundle_count"
      expr: COUNT(CASE WHEN sustainability_certified_flag = TRUE THEN 1 END)
      comment: "Number of bundles with sustainability certification — tracks certified product coverage in the portfolio for ESG and marketing purposes."
    - name: "avg_early_termination_fee"
      expr: AVG(CAST(early_termination_fee AS DOUBLE))
      comment: "Average early termination fee across bundles — used by contract management to assess revenue protection from contract cancellations."
    - name: "promotional_bundle_count"
      expr: COUNT(CASE WHEN promotional_flag = TRUE THEN 1 END)
      comment: "Number of bundles currently under a promotional offer — used to monitor promotional exposure and its potential impact on realized revenue."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service offering management — tracks offering pricing, sustainability attributes, regulatory compliance requirements, and lifecycle health. Used by product management, compliance, and sustainability leadership to govern the active service catalog."
  source: "`waste_management_ecm`.`service`.`offering`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service offering (e.g., collection, disposal, recycling, hazmat) — primary segmentation axis for offering portfolio analysis."
    - name: "service_category"
      expr: service_category
      comment: "Business category of the service offering — used to group offerings by market segment or waste stream for revenue and compliance analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the offering (e.g., active, deprecated, pending) — used to filter active vs. retired offerings."
    - name: "pricing_unit"
      expr: pricing_unit
      comment: "Unit of measure for pricing (e.g., per ton, per lift, per month) — used to segment offerings by pricing model for revenue analysis."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the offering — used to assess compliance obligations and regulatory reporting scope."
    - name: "sustainability_program_flag"
      expr: sustainability_program_flag
      comment: "Boolean flag indicating whether the offering is part of a sustainability program — used to track sustainable service mix."
    - name: "carbon_offset_eligible"
      expr: carbon_offset_eligible
      comment: "Boolean flag indicating whether the offering qualifies for carbon offset credits — used in ESG reporting and carbon program management."
    - name: "requires_special_permit"
      expr: requires_special_permit
      comment: "Boolean flag indicating whether the offering requires a special permit — used to assess regulatory complexity and permitting workload."
    - name: "requires_manifest"
      expr: requires_manifest
      comment: "Boolean flag indicating whether the offering requires a waste manifest — used to track hazardous waste handling obligations."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date — used to analyze offering launch cadence and catalog evolution over time."
  measures:
    - name: "total_offerings"
      expr: COUNT(1)
      comment: "Total number of service offerings in the catalog — baseline measure for product portfolio size and governance tracking."
    - name: "avg_base_price_amount"
      expr: AVG(CAST(base_price_amount AS DOUBLE))
      comment: "Average base price across all service offerings — used by pricing teams to benchmark offering price levels and detect pricing anomalies."
    - name: "total_base_price_value"
      expr: SUM(CAST(base_price_amount AS DOUBLE))
      comment: "Sum of base prices across all active offerings — proxy for total catalog list value used in pricing portfolio reviews."
    - name: "avg_diversion_rate_target_pct"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average diversion rate target (%) committed across offerings — measures the sustainability ambition embedded in the service catalog."
    - name: "sustainability_program_offering_count"
      expr: COUNT(CASE WHEN sustainability_program_flag = TRUE THEN 1 END)
      comment: "Number of offerings enrolled in a sustainability program — tracks sustainable service coverage in the catalog for ESG reporting."
    - name: "carbon_offset_eligible_count"
      expr: COUNT(CASE WHEN carbon_offset_eligible = TRUE THEN 1 END)
      comment: "Number of offerings eligible for carbon offset credits — used to quantify the carbon program-eligible service portfolio."
    - name: "permit_required_offering_count"
      expr: COUNT(CASE WHEN requires_special_permit = TRUE THEN 1 END)
      comment: "Number of offerings requiring a special permit — used by compliance teams to size permitting workload and track regulatory exposure."
    - name: "manifest_required_offering_count"
      expr: COUNT(CASE WHEN requires_manifest = TRUE THEN 1 END)
      comment: "Number of offerings requiring a waste manifest — used to assess hazardous waste handling scope and manifest compliance obligations."
    - name: "customer_training_required_count"
      expr: COUNT(CASE WHEN requires_customer_training = TRUE THEN 1 END)
      comment: "Number of offerings requiring customer training — used to plan customer onboarding resources and track training compliance obligations."
    - name: "site_assessment_required_count"
      expr: COUNT(CASE WHEN requires_site_assessment = TRUE THEN 1 END)
      comment: "Number of offerings requiring a site assessment — used to plan field assessment capacity and track pre-service compliance steps."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service rate schedule management — tracks base rates, surcharges, fees, and pricing structure across rate schedules by area, customer segment, and waste stream. Used by pricing, finance, and operations leadership to govern rate competitiveness, fee recovery, and revenue protection."
  source: "`waste_management_ecm`.`service`.`service_rate_schedule`"
  dimensions:
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment the rate schedule applies to (e.g., residential, small commercial, large commercial) — primary segmentation axis for rate analysis."
    - name: "rate_schedule_status"
      expr: rate_schedule_status
      comment: "Current status of the rate schedule (e.g., active, superseded, draft) — used to filter active vs. historical rate schedules."
    - name: "base_rate_unit"
      expr: base_rate_unit
      comment: "Unit of measure for the base rate (e.g., per ton, per lift, per month) — used to segment rate schedules by pricing model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the rate schedule — used to ensure consistent currency analysis in multi-currency environments."
    - name: "fuel_surcharge_method"
      expr: fuel_surcharge_method
      comment: "Method used to calculate fuel surcharges (e.g., fixed, index-based, percentage) — used to analyze fuel cost recovery strategy."
    - name: "environmental_fee_method"
      expr: environmental_fee_method
      comment: "Method used to calculate environmental recovery fees — used to assess environmental cost recovery approach across rate schedules."
    - name: "tipping_fee_method"
      expr: tipping_fee_method
      comment: "Method used to calculate tipping fee pass-through — used to evaluate disposal cost recovery strategy."
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Boolean flag indicating whether the rate is tax-inclusive — used to ensure correct revenue recognition and tax reporting."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date of the rate schedule — used to analyze rate change cadence and pricing history."
  measures:
    - name: "total_rate_schedules"
      expr: COUNT(1)
      comment: "Total number of rate schedules — baseline measure for rate catalog size and governance tracking."
    - name: "avg_base_rate_amount"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate amount across all rate schedules — used by pricing leadership to benchmark rate levels and detect pricing gaps or outliers."
    - name: "avg_fuel_surcharge_percentage"
      expr: AVG(CAST(fuel_surcharge_percentage AS DOUBLE))
      comment: "Average fuel surcharge percentage across rate schedules — tracks fuel cost recovery rate; critical for margin management during fuel price volatility."
    - name: "avg_environmental_recovery_fee"
      expr: AVG(CAST(environmental_recovery_fee AS DOUBLE))
      comment: "Average environmental recovery fee across rate schedules — measures the level of environmental cost pass-through to customers."
    - name: "avg_contamination_surcharge"
      expr: AVG(CAST(contamination_surcharge AS DOUBLE))
      comment: "Average contamination surcharge across rate schedules — used to assess the financial deterrent applied to contaminated loads and its alignment with processing costs."
    - name: "avg_tipping_fee_passthrough"
      expr: AVG(CAST(tipping_fee_passthrough AS DOUBLE))
      comment: "Average tipping fee pass-through amount — measures disposal cost recovery effectiveness across the rate portfolio."
    - name: "avg_minimum_service_charge"
      expr: AVG(CAST(minimum_service_charge AS DOUBLE))
      comment: "Average minimum service charge across rate schedules — used to evaluate revenue floor protection across customer segments."
    - name: "avg_overweight_fee"
      expr: AVG(CAST(overweight_fee AS DOUBLE))
      comment: "Average overweight fee across rate schedules — used to assess the financial deterrent for overweight containers and its contribution to cost recovery."
    - name: "avg_regulatory_compliance_fee"
      expr: AVG(CAST(regulatory_compliance_fee AS DOUBLE))
      comment: "Average regulatory compliance fee across rate schedules — tracks the level of regulatory cost recovery embedded in pricing."
    - name: "avg_sales_tax_rate"
      expr: AVG(CAST(sales_tax_rate AS DOUBLE))
      comment: "Average sales tax rate across rate schedules — used by finance to monitor tax rate consistency and identify schedules requiring tax rate updates."
    - name: "avg_contamination_threshold_pct"
      expr: AVG(CAST(contamination_threshold_percentage AS DOUBLE))
      comment: "Average contamination threshold percentage across rate schedules — used to evaluate how stringently contamination surcharges are triggered across the rate portfolio."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_sla_definition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for SLA definition management — tracks service level commitments, response and resolution time targets, penalty exposure, and credit obligations across service lines and offerings. Used by operations, customer service, and contract management leadership to govern service quality commitments."
  source: "`waste_management_ecm`.`service`.`sla_definition`"
  dimensions:
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g., response time, resolution time, on-time service) — primary segmentation axis for SLA portfolio analysis."
    - name: "sla_definition_status"
      expr: sla_definition_status
      comment: "Current status of the SLA definition (e.g., active, expired, draft) — used to filter active vs. inactive SLA commitments."
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure SLA compliance (e.g., GPS timestamp, driver log, customer report) — used to assess measurement consistency and auditability."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which SLA performance is reported (e.g., monthly, quarterly) — used to align SLA reporting cadence with contract obligations."
    - name: "auto_credit_enabled_flag"
      expr: auto_credit_enabled_flag
      comment: "Boolean flag indicating whether credits are automatically issued on SLA breach — used to assess automated financial exposure from SLA failures."
    - name: "notification_enabled_flag"
      expr: notification_enabled_flag
      comment: "Boolean flag indicating whether customer notifications are enabled for SLA events — used to assess customer communication compliance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date of the SLA definition — used to analyze SLA commitment evolution over time."
  measures:
    - name: "total_sla_definitions"
      expr: COUNT(1)
      comment: "Total number of SLA definitions — baseline measure for SLA portfolio size and governance tracking."
    - name: "avg_on_time_service_rate_target_pct"
      expr: AVG(CAST(on_time_service_rate_target_pct AS DOUBLE))
      comment: "Average on-time service rate target (%) across all SLA definitions — the primary service quality KPI; measures the portfolio-level service reliability commitment."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average response time commitment (hours) across SLA definitions — used to benchmark service responsiveness standards and identify outlier commitments."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average resolution time commitment (hours) across SLA definitions — measures the portfolio-level service resolution standard."
    - name: "avg_complaint_resolution_window_hours"
      expr: AVG(CAST(complaint_resolution_window_hours AS DOUBLE))
      comment: "Average complaint resolution window (hours) across SLA definitions — used to assess customer complaint handling commitments and their alignment with regulatory requirements."
    - name: "avg_escalation_threshold_hours"
      expr: AVG(CAST(escalation_threshold_hours AS DOUBLE))
      comment: "Average escalation threshold (hours) across SLA definitions — measures how quickly unresolved issues are escalated; lower values indicate more aggressive service quality governance."
    - name: "avg_missed_pickup_credit_amount"
      expr: AVG(CAST(missed_pickup_credit_amount AS DOUBLE))
      comment: "Average missed pickup credit amount across SLA definitions — quantifies the per-incident financial exposure from missed collection events."
    - name: "avg_missed_pickup_credit_pct"
      expr: AVG(CAST(missed_pickup_credit_pct AS DOUBLE))
      comment: "Average missed pickup credit percentage across SLA definitions — measures the proportional revenue at risk per missed pickup event."
    - name: "avg_late_delivery_penalty_amount"
      expr: AVG(CAST(late_delivery_penalty_amount AS DOUBLE))
      comment: "Average late delivery penalty amount across SLA definitions — quantifies the per-incident financial penalty exposure from late container deliveries."
    - name: "auto_credit_enabled_sla_count"
      expr: COUNT(CASE WHEN auto_credit_enabled_flag = TRUE THEN 1 END)
      comment: "Number of SLA definitions with automatic credit issuance enabled — measures the scope of automated financial exposure from SLA breaches."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_waste_stream`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for waste stream management — tracks diversion eligibility, GHG emission factors, contamination thresholds, density, and regulatory classification across waste streams. Used by sustainability, operations, and compliance leadership to govern waste stream performance and environmental impact."
  source: "`waste_management_ecm`.`service`.`waste_stream`"
  dimensions:
    - name: "waste_stream_category"
      expr: waste_stream_category
      comment: "High-level category of the waste stream (e.g., solid waste, recyclables, organics, hazardous) — primary segmentation axis for waste stream analysis."
    - name: "waste_stream_status"
      expr: waste_stream_status
      comment: "Current status of the waste stream (e.g., active, inactive, pending) — used to filter active vs. retired waste streams."
    - name: "subcategory"
      expr: subcategory
      comment: "Sub-classification of the waste stream — used for granular waste stream analysis and regulatory reporting."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the waste stream (e.g., RCRA hazardous, universal waste, non-hazardous) — critical for compliance reporting and permit management."
    - name: "disposal_pathway"
      expr: disposal_pathway
      comment: "Designated disposal pathway for the waste stream (e.g., landfill, MRF, composting, WTE) — used to analyze diversion strategy and disposal cost allocation."
    - name: "diversion_eligible_flag"
      expr: diversion_eligible_flag
      comment: "Boolean flag indicating whether the waste stream qualifies for diversion credit — used to segment divertible vs. non-divertible waste streams."
    - name: "recyclable_flag"
      expr: recyclable_flag
      comment: "Boolean flag indicating whether the waste stream is recyclable — used to track recyclable material coverage in the waste stream portfolio."
    - name: "compostable_flag"
      expr: compostable_flag
      comment: "Boolean flag indicating whether the waste stream is compostable — used to assess organics diversion potential."
    - name: "wte_feedstock_flag"
      expr: wte_feedstock_flag
      comment: "Boolean flag indicating whether the waste stream qualifies as waste-to-energy feedstock — used to evaluate WTE program capacity and feedstock availability."
    - name: "special_handling_required_flag"
      expr: special_handling_required_flag
      comment: "Boolean flag indicating whether the waste stream requires special handling — used to assess operational complexity and cost drivers."
  measures:
    - name: "total_waste_streams"
      expr: COUNT(1)
      comment: "Total number of waste streams in the catalog — baseline measure for waste stream portfolio breadth."
    - name: "avg_ghg_emission_factor_co2e_per_ton"
      expr: AVG(CAST(ghg_emission_factor_co2e_per_ton AS DOUBLE))
      comment: "Average GHG emission factor (CO2e per ton) across waste streams — the primary environmental impact KPI; used in ESG reporting and carbon reduction program management."
    - name: "avg_diversion_credit_percentage"
      expr: AVG(CAST(diversion_credit_percentage AS DOUBLE))
      comment: "Average diversion credit percentage across waste streams — measures the portfolio-level diversion incentive and its alignment with regulatory diversion mandates."
    - name: "avg_contamination_threshold_pct"
      expr: AVG(CAST(contamination_threshold_percentage AS DOUBLE))
      comment: "Average contamination threshold percentage across waste streams — used to assess how stringently contamination is managed across the waste stream portfolio."
    - name: "avg_density_lbs_per_cubic_yard"
      expr: AVG(CAST(density_lbs_per_cubic_yard AS DOUBLE))
      comment: "Average waste density (lbs per cubic yard) across waste streams — used by operations to plan container sizing, vehicle payload, and route capacity."
    - name: "avg_compaction_ratio"
      expr: AVG(CAST(compaction_ratio_avg AS DOUBLE))
      comment: "Average compaction ratio across waste streams — used to optimize compactor utilization and estimate effective container capacity."
    - name: "diversion_eligible_stream_count"
      expr: COUNT(CASE WHEN diversion_eligible_flag = TRUE THEN 1 END)
      comment: "Number of waste streams eligible for diversion credit — measures the breadth of diversion-eligible materials in the portfolio."
    - name: "recyclable_stream_count"
      expr: COUNT(CASE WHEN recyclable_flag = TRUE THEN 1 END)
      comment: "Number of recyclable waste streams — tracks recyclable material coverage for sustainability program planning."
    - name: "wte_feedstock_stream_count"
      expr: COUNT(CASE WHEN wte_feedstock_flag = TRUE THEN 1 END)
      comment: "Number of waste streams qualifying as WTE feedstock — used to assess waste-to-energy program feedstock availability and capacity planning."
    - name: "manifest_required_stream_count"
      expr: COUNT(CASE WHEN manifest_required_flag = TRUE THEN 1 END)
      comment: "Number of waste streams requiring a manifest — used to assess hazardous waste handling scope and manifest compliance obligations."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service territory management — tracks geographic coverage, diversion rate targets, program availability, franchise health, and operational readiness across service territories. Used by operations, regulatory affairs, and sustainability leadership for territory-level performance governance."
  source: "`waste_management_ecm`.`service`.`territory`"
  dimensions:
    - name: "territory_type"
      expr: territory_type
      comment: "Type classification of the territory (e.g., municipal, county, franchise zone) — primary segmentation axis for territory portfolio analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the territory (e.g., active, suspended, pending) — used to filter active vs. inactive territories."
    - name: "state_code"
      expr: state_code
      comment: "US state code for the territory — enables geographic rollup and state-level regulatory reporting."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the territory — critical for compliance reporting and franchise management."
    - name: "recycling_program_available"
      expr: recycling_program_available
      comment: "Boolean flag indicating whether a recycling program is available in the territory — used to segment territories by sustainability program coverage."
    - name: "organics_program_available"
      expr: organics_program_available
      comment: "Boolean flag indicating whether an organics program is available — used to track organics diversion program rollout across territories."
    - name: "hazmat_collection_available"
      expr: hazmat_collection_available
      comment: "Boolean flag indicating whether hazardous material collection is offered — used to assess hazmat service network coverage."
    - name: "franchise_expiration_date"
      expr: DATE_TRUNC('month', franchise_expiration_date)
      comment: "Month-truncated franchise expiration date — used to identify territories with near-term franchise renewal risk."
  measures:
    - name: "total_territories"
      expr: COUNT(1)
      comment: "Total number of service territories — baseline measure for territory portfolio size and geographic coverage management."
    - name: "total_area_square_miles"
      expr: SUM(CAST(area_square_miles AS DOUBLE))
      comment: "Total geographic coverage in square miles across all territories — used by operations leadership to assess fleet deployment needs and route density."
    - name: "avg_area_square_miles"
      expr: AVG(CAST(area_square_miles AS DOUBLE))
      comment: "Average square miles per territory — informs route optimization decisions and identifies territories that may be over- or under-sized for efficient collection."
    - name: "avg_diversion_rate_target_pct"
      expr: AVG(CAST(diversion_rate_target_pct AS DOUBLE))
      comment: "Average diversion rate target (%) across territories — tracks the portfolio-level sustainability ambition and informs whether targets are aligned with regulatory mandates."
    - name: "recycling_program_territory_count"
      expr: COUNT(CASE WHEN recycling_program_available = TRUE THEN 1 END)
      comment: "Number of territories with an active recycling program — measures recycling program rollout breadth across the territory portfolio."
    - name: "organics_program_territory_count"
      expr: COUNT(CASE WHEN organics_program_available = TRUE THEN 1 END)
      comment: "Number of territories with an active organics program — tracks organics diversion program expansion progress."
    - name: "hazmat_coverage_territory_count"
      expr: COUNT(CASE WHEN hazmat_collection_available = TRUE THEN 1 END)
      comment: "Number of territories offering hazardous material collection — used to assess hazmat service network coverage and regulatory compliance exposure."
    - name: "route_optimization_enabled_count"
      expr: COUNT(CASE WHEN route_optimization_enabled = TRUE THEN 1 END)
      comment: "Number of territories with route optimization enabled — measures operational efficiency technology adoption across the territory portfolio."
    - name: "gps_tracking_required_count"
      expr: COUNT(CASE WHEN gps_tracking_required = TRUE THEN 1 END)
      comment: "Number of territories requiring GPS tracking — used to assess fleet telematics compliance obligations and technology deployment scope."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for service line management — tracks pricing, margin targets, sustainability commitments, regulatory requirements, and operational attributes across service lines. Used by product management, finance, and sustainability leadership to govern the service line portfolio."
  source: "`waste_management_ecm`.`service`.`line`"
  dimensions:
    - name: "service_line_type"
      expr: service_line_type
      comment: "Type classification of the service line (e.g., residential collection, commercial recycling, hazmat disposal) — primary segmentation axis for service line analysis."
    - name: "service_line_status"
      expr: service_line_status
      comment: "Current status of the service line (e.g., active, deprecated, pending) — used to filter active vs. retired service lines."
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue category of the service line — used to segment service lines by revenue type for financial reporting."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the service line (e.g., flat rate, per-unit, tiered) — used to segment service lines by revenue model."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the service line — used to allocate performance metrics to organizational units."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification of the service line — used to assess compliance obligations and regulatory reporting scope."
    - name: "sustainability_program_flag"
      expr: sustainability_program_flag
      comment: "Boolean flag indicating whether the service line is part of a sustainability program — used to track sustainable service line mix."
    - name: "ghg_reduction_contribution_flag"
      expr: ghg_reduction_contribution_flag
      comment: "Boolean flag indicating whether the service line contributes to GHG reduction goals — used in ESG reporting and carbon program management."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date of the service line — used to analyze service line launch cadence and portfolio evolution."
  measures:
    - name: "total_service_lines"
      expr: COUNT(1)
      comment: "Total number of service lines — baseline measure for service line portfolio size."
    - name: "avg_base_price_usd"
      expr: AVG(CAST(base_price_usd AS DOUBLE))
      comment: "Average base price (USD) across service lines — used by pricing teams to benchmark service line pricing levels."
    - name: "avg_profit_margin_target_pct"
      expr: AVG(CAST(profit_margin_target_percent AS DOUBLE))
      comment: "Average profit margin target (%) across service lines — the primary financial health KPI for the service line portfolio; used by finance leadership to assess margin ambition and identify underperforming lines."
    - name: "avg_diversion_rate_target_pct"
      expr: AVG(CAST(diversion_rate_target_percent AS DOUBLE))
      comment: "Average diversion rate target (%) across service lines — measures the sustainability ambition embedded in the service line portfolio."
    - name: "sustainability_program_line_count"
      expr: COUNT(CASE WHEN sustainability_program_flag = TRUE THEN 1 END)
      comment: "Number of service lines enrolled in a sustainability program — tracks sustainable service line coverage for ESG reporting."
    - name: "ghg_reduction_line_count"
      expr: COUNT(CASE WHEN ghg_reduction_contribution_flag = TRUE THEN 1 END)
      comment: "Number of service lines contributing to GHG reduction goals — used to quantify the GHG-contributing service portfolio for carbon program management."
    - name: "permit_required_line_count"
      expr: COUNT(CASE WHEN permit_requirement_flag = TRUE THEN 1 END)
      comment: "Number of service lines requiring a permit — used by compliance teams to size permitting workload and track regulatory exposure."
    - name: "route_optimization_eligible_count"
      expr: COUNT(CASE WHEN route_optimization_eligible_flag = TRUE THEN 1 END)
      comment: "Number of service lines eligible for route optimization — measures the scope of operational efficiency improvement potential across the service line portfolio."
$$;