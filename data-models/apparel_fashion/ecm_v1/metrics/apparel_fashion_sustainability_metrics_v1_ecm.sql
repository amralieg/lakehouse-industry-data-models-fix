-- Metric views for domain: sustainability | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon emissions tracking across scopes, sources, and geographies with verification status and offset application"
  source: "`apparel_fashion_ecm`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "emission_scope"
      expr: emission_scope
      comment: "Scope classification (Scope 1, 2, or 3) per GHG Protocol"
    - name: "emission_source_type"
      expr: emission_source_type
      comment: "Type of emission source (e.g., stationary combustion, purchased electricity, transportation)"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where emissions occurred"
    - name: "geographic_country_code"
      expr: geographic_country_code
      comment: "ISO country code for emission location"
    - name: "reporting_year"
      expr: reporting_year
      comment: "Fiscal or calendar year for emission reporting"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status of emission data"
    - name: "science_based_target_alignment"
      expr: science_based_target_alignment
      comment: "Whether emission aligns with Science Based Targets initiative"
    - name: "offset_applied_flag"
      expr: offset_applied_flag
      comment: "Indicates if carbon offsets have been applied to this emission"
    - name: "biogenic_emission_flag"
      expr: biogenic_emission_flag
      comment: "Indicates if emission is from biogenic sources"
    - name: "renewable_energy_flag"
      expr: renewable_energy_flag
      comment: "Indicates if emission source uses renewable energy"
    - name: "emission_date_year"
      expr: YEAR(emission_date)
      comment: "Year of emission event"
    - name: "emission_date_month"
      expr: DATE_TRUNC('MONTH', emission_date)
      comment: "Month of emission event"
  measures:
    - name: "total_co2e_emissions_kg"
      expr: SUM(CAST(co2e_quantity_kg AS DOUBLE))
      comment: "Total CO2 equivalent emissions in kilograms across all greenhouse gases"
    - name: "total_co2_emissions_kg"
      expr: SUM(CAST(co2_quantity_kg AS DOUBLE))
      comment: "Total carbon dioxide emissions in kilograms"
    - name: "total_ch4_emissions_kg"
      expr: SUM(CAST(ch4_quantity_kg AS DOUBLE))
      comment: "Total methane emissions in kilograms"
    - name: "total_n2o_emissions_kg"
      expr: SUM(CAST(n2o_quantity_kg AS DOUBLE))
      comment: "Total nitrous oxide emissions in kilograms"
    - name: "total_offset_quantity_kg"
      expr: SUM(CAST(offset_quantity_kg AS DOUBLE))
      comment: "Total carbon offsets applied in kilograms CO2e"
    - name: "net_emissions_kg"
      expr: SUM((CAST(co2e_quantity_kg AS DOUBLE)) - (CAST(offset_quantity_kg AS DOUBLE)))
      comment: "Net emissions after offset application (gross emissions minus offsets)"
    - name: "avg_emission_factor"
      expr: AVG(CAST(emission_factor_value AS DOUBLE))
      comment: "Average emission factor used across emission calculations"
    - name: "emission_event_count"
      expr: COUNT(DISTINCT emission_event_number)
      comment: "Number of distinct emission events recorded"
    - name: "verified_emission_count"
      expr: COUNT(DISTINCT CASE WHEN verification_status = 'Verified' THEN emission_event_number END)
      comment: "Number of emission events with completed third-party verification"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_carbon_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon reduction targets with baseline, progress tracking, and Science Based Targets initiative alignment"
  source: "`apparel_fashion_ecm`.`sustainability`.`carbon_target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of carbon target (absolute, intensity, net-zero)"
    - name: "target_status"
      expr: target_status
      comment: "Current status of target achievement"
    - name: "scope_coverage"
      expr: scope_coverage
      comment: "Which emission scopes are covered by this target"
    - name: "sbti_validation_status"
      expr: sbti_validation_status
      comment: "Science Based Targets initiative validation status"
    - name: "temperature_alignment"
      expr: temperature_alignment
      comment: "Temperature scenario alignment (e.g., 1.5°C, 2°C)"
    - name: "on_track_flag"
      expr: on_track_flag
      comment: "Indicates if target progress is on track"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether target is publicly disclosed"
    - name: "external_assurance_flag"
      expr: external_assurance_flag
      comment: "Whether target has external assurance"
    - name: "baseline_year"
      expr: baseline_year
      comment: "Year used as baseline for reduction target"
    - name: "target_year"
      expr: target_year
      comment: "Year by which target should be achieved"
  measures:
    - name: "total_baseline_emissions_mt"
      expr: SUM(CAST(baseline_emissions_mt_co2e AS DOUBLE))
      comment: "Total baseline emissions in metric tonnes CO2e across all targets"
    - name: "total_target_emissions_mt"
      expr: SUM(CAST(target_emissions_mt_co2e AS DOUBLE))
      comment: "Total target emissions in metric tonnes CO2e"
    - name: "total_current_emissions_mt"
      expr: SUM(CAST(current_emissions_mt_co2e AS DOUBLE))
      comment: "Total current emissions in metric tonnes CO2e"
    - name: "avg_target_reduction_pct"
      expr: AVG(CAST(target_reduction_percentage AS DOUBLE))
      comment: "Average target reduction percentage across all targets"
    - name: "avg_progress_pct"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average progress percentage toward target achievement"
    - name: "total_reduction_achieved_mt"
      expr: SUM((CAST(baseline_emissions_mt_co2e AS DOUBLE)) - (CAST(current_emissions_mt_co2e AS DOUBLE)))
      comment: "Total emissions reduction achieved from baseline to current (metric tonnes CO2e)"
    - name: "total_reduction_needed_mt"
      expr: SUM((CAST(current_emissions_mt_co2e AS DOUBLE)) - (CAST(target_emissions_mt_co2e AS DOUBLE)))
      comment: "Total additional reduction needed to meet targets (metric tonnes CO2e)"
    - name: "target_count"
      expr: COUNT(1)
      comment: "Total number of carbon reduction targets"
    - name: "sbti_approved_target_count"
      expr: COUNT(DISTINCT CASE WHEN sbti_validation_status = 'Approved' THEN carbon_target_id END)
      comment: "Number of targets approved by Science Based Targets initiative"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy consumption tracking by source, facility, and renewable energy percentage with scope emissions"
  source: "`apparel_fashion_ecm`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "energy_source"
      expr: energy_source
      comment: "Type of energy source (electricity, natural gas, diesel, renewable)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility consuming energy"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of energy consumption"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code for consumption location"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of energy consumption data"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for energy consumption"
    - name: "consumption_year"
      expr: YEAR(consumption_date)
      comment: "Year of energy consumption"
    - name: "consumption_month"
      expr: DATE_TRUNC('MONTH', consumption_date)
      comment: "Month of energy consumption"
  measures:
    - name: "total_energy_consumption"
      expr: SUM(CAST(consumption_quantity AS DOUBLE))
      comment: "Total energy consumption across all sources and facilities"
    - name: "total_energy_cost"
      expr: SUM(CAST(energy_cost AS DOUBLE))
      comment: "Total cost of energy consumption"
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average percentage of energy from renewable sources"
    - name: "total_scope1_emissions_kg"
      expr: SUM(CAST(scope_1_emissions_kg_co2e AS DOUBLE))
      comment: "Total Scope 1 emissions from energy consumption in kg CO2e"
    - name: "total_scope2_emissions_kg"
      expr: SUM(CAST(scope_2_emissions_kg_co2e AS DOUBLE))
      comment: "Total Scope 2 emissions from energy consumption in kg CO2e"
    - name: "avg_energy_intensity"
      expr: AVG(CAST(energy_intensity_metric AS DOUBLE))
      comment: "Average energy intensity metric across facilities"
    - name: "avg_cost_per_unit"
      expr: ROUND(SUM(CAST(energy_cost AS DOUBLE)) / NULLIF(SUM(CAST(consumption_quantity AS DOUBLE)), 0), 4)
      comment: "Average cost per unit of energy consumed"
    - name: "facility_count"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with energy consumption"
    - name: "consumption_record_count"
      expr: COUNT(1)
      comment: "Total number of energy consumption records"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_water_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water consumption, discharge, recycling, and quality metrics with regulatory compliance tracking"
  source: "`apparel_fashion_ecm`.`sustainability`.`water_usage`"
  dimensions:
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source (municipal, groundwater, surface water, rainwater)"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility using water"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of water usage"
    - name: "water_stress_basin_classification"
      expr: water_stress_basin_classification
      comment: "Water stress level of basin (high, medium, low)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status for water usage"
    - name: "wastewater_treatment_method"
      expr: wastewater_treatment_method
      comment: "Method used for wastewater treatment"
    - name: "water_stewardship_certification"
      expr: water_stewardship_certification
      comment: "Water stewardship certification held (e.g., AWS, EWS)"
    - name: "zld_commitment_status"
      expr: zld_commitment_status
      comment: "Zero Liquid Discharge commitment status"
    - name: "water_stewardship_program_enrolled"
      expr: water_stewardship_program_enrolled
      comment: "Whether facility is enrolled in water stewardship program"
    - name: "reporting_year"
      expr: YEAR(reporting_period_start_date)
      comment: "Year of water usage reporting period"
  measures:
    - name: "total_water_intake_m3"
      expr: SUM(CAST(total_water_intake_volume_m3 AS DOUBLE))
      comment: "Total water intake volume in cubic meters"
    - name: "total_wastewater_discharged_m3"
      expr: SUM(CAST(wastewater_discharged_volume_m3 AS DOUBLE))
      comment: "Total wastewater discharged in cubic meters"
    - name: "total_water_recycled_m3"
      expr: SUM(CAST(water_recycled_volume_m3 AS DOUBLE))
      comment: "Total water recycled and reused in cubic meters"
    - name: "total_water_reduction_achieved_m3"
      expr: SUM(CAST(water_reduction_achieved_m3 AS DOUBLE))
      comment: "Total water reduction achieved against targets in cubic meters"
    - name: "water_recycling_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(water_recycled_volume_m3 AS DOUBLE)) / NULLIF(SUM(CAST(total_water_intake_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Percentage of water recycled relative to total intake"
    - name: "avg_water_consumption_per_unit"
      expr: AVG(CAST(water_consumption_per_unit_produced AS DOUBLE))
      comment: "Average water consumption per unit produced"
    - name: "avg_water_quality_ph"
      expr: AVG(CAST(water_quality_ph_level AS DOUBLE))
      comment: "Average pH level of discharged water"
    - name: "avg_water_quality_bod"
      expr: AVG(CAST(water_quality_bod_mg_per_l AS DOUBLE))
      comment: "Average Biological Oxygen Demand in mg/L"
    - name: "avg_water_quality_cod"
      expr: AVG(CAST(water_quality_cod_mg_per_l AS DOUBLE))
      comment: "Average Chemical Oxygen Demand in mg/L"
    - name: "facility_count"
      expr: COUNT(DISTINCT facility_id)
      comment: "Number of distinct facilities with water usage data"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_waste_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste generation, disposal, diversion, and recycling tracking with circular economy revenue"
  source: "`apparel_fashion_ecm`.`sustainability`.`waste_record`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste generated (textile, packaging, chemical, general)"
    - name: "waste_stream_classification"
      expr: waste_stream_classification
      comment: "Classification of waste stream (hazardous, non-hazardous, recyclable)"
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used for waste disposal (landfill, incineration, recycling, composting)"
    - name: "product_category"
      expr: product_category
      comment: "Product category generating the waste"
    - name: "material_composition"
      expr: material_composition
      comment: "Material composition of waste"
    - name: "zwtl_compliant_flag"
      expr: zwtl_compliant_flag
      comment: "Zero Waste to Landfill compliance flag"
    - name: "certification_standard"
      expr: certification_standard
      comment: "Waste management certification standard"
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for waste data"
    - name: "waste_generation_year"
      expr: YEAR(waste_generation_date)
      comment: "Year of waste generation"
    - name: "waste_generation_month"
      expr: DATE_TRUNC('MONTH', waste_generation_date)
      comment: "Month of waste generation"
  measures:
    - name: "total_waste_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total waste weight in kilograms"
    - name: "total_waste_volume_m3"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total waste volume in cubic meters"
    - name: "avg_diversion_rate_pct"
      expr: AVG(CAST(diversion_rate_percent AS DOUBLE))
      comment: "Average waste diversion rate from landfill (percentage)"
    - name: "total_carbon_footprint_kg"
      expr: SUM(CAST(carbon_footprint_kg_co2e AS DOUBLE))
      comment: "Total carbon footprint of waste in kg CO2e"
    - name: "total_recycling_revenue"
      expr: SUM(CAST(revenue_from_recycling AS DOUBLE))
      comment: "Total revenue generated from recycling waste materials"
    - name: "total_waste_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of waste management and disposal"
    - name: "net_waste_cost"
      expr: SUM((CAST(cost_amount AS DOUBLE)) - (CAST(revenue_from_recycling AS DOUBLE)))
      comment: "Net waste cost after recycling revenue (cost minus revenue)"
    - name: "waste_transaction_count"
      expr: COUNT(DISTINCT waste_transaction_number)
      comment: "Number of distinct waste transactions"
    - name: "facility_count"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of distinct facilities generating waste"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_supplier_esg_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier ESG performance assessment scores across environmental, social, and governance dimensions with remediation tracking"
  source: "`apparel_fashion_ecm`.`sustainability`.`supplier_esg_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of ESG assessment conducted"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of assessment"
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall ESG rating assigned to supplier"
    - name: "risk_level"
      expr: risk_level
      comment: "ESG risk level classification"
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Tier level of supplier in supply chain"
    - name: "facility_country_code"
      expr: facility_country_code
      comment: "Country code of assessed facility"
    - name: "certification_achieved"
      expr: certification_achieved
      comment: "Whether supplier achieved ESG certification"
    - name: "remediation_required"
      expr: remediation_required
      comment: "Whether corrective action is required"
    - name: "corrective_action_plan_approved"
      expr: corrective_action_plan_approved
      comment: "Whether corrective action plan has been approved"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of ESG assessment"
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall ESG score across suppliers"
    - name: "avg_environmental_score"
      expr: AVG(CAST(environmental_score AS DOUBLE))
      comment: "Average environmental performance score"
    - name: "avg_social_score"
      expr: AVG(CAST(social_score AS DOUBLE))
      comment: "Average social performance score"
    - name: "avg_governance_score"
      expr: AVG(CAST(governance_score AS DOUBLE))
      comment: "Average governance performance score"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total number of critical findings across all assessments"
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total number of major findings across all assessments"
    - name: "total_assessment_cost"
      expr: SUM(CAST(assessment_cost AS DOUBLE))
      comment: "Total cost of conducting ESG assessments"
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total number of supplier ESG assessments conducted"
    - name: "supplier_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct suppliers assessed"
    - name: "high_risk_supplier_count"
      expr: COUNT(DISTINCT CASE WHEN risk_level = 'High' THEN vendor_id END)
      comment: "Number of suppliers classified as high ESG risk"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_circular_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular economy program performance tracking including take-back, recycling, and material recovery initiatives"
  source: "`apparel_fashion_ecm`.`sustainability`.`circular_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of circular economy program (take-back, resale, repair, recycling)"
    - name: "program_status"
      expr: program_status
      comment: "Current operational status of program"
    - name: "is_active"
      expr: is_active
      comment: "Whether program is currently active"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of program operation"
    - name: "collection_method"
      expr: collection_method
      comment: "Method used to collect items (in-store, mail-in, pickup)"
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard for circular program"
    - name: "incentive_type"
      expr: incentive_type
      comment: "Type of customer incentive offered"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year program was launched"
  measures:
    - name: "total_annual_budget"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget allocated to circular programs"
    - name: "total_carbon_reduction_target_kg"
      expr: SUM(CAST(carbon_reduction_target_kg AS DOUBLE))
      comment: "Total carbon reduction target across all programs in kg CO2e"
    - name: "total_diversion_target"
      expr: SUM(CAST(diversion_target_quantity AS DOUBLE))
      comment: "Total waste diversion target quantity across programs"
    - name: "avg_material_recovery_rate_target_pct"
      expr: AVG(CAST(material_recovery_rate_target_pct AS DOUBLE))
      comment: "Average material recovery rate target percentage"
    - name: "avg_incentive_value"
      expr: AVG(CAST(incentive_value AS DOUBLE))
      comment: "Average customer incentive value offered"
    - name: "program_count"
      expr: COUNT(1)
      comment: "Total number of circular economy programs"
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN circular_program_id END)
      comment: "Number of currently active circular programs"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_sustainable_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainable material inventory with recycled content, organic content, carbon footprint, and certification tracking"
  source: "`apparel_fashion_ecm`.`sustainability`.`sustainable_material`"
  dimensions:
    - name: "material_status"
      expr: material_status
      comment: "Current status of sustainable material"
    - name: "fiber_type"
      expr: fiber_type
      comment: "Type of fiber (cotton, polyester, wool, etc.)"
    - name: "sustainability_attribute"
      expr: sustainability_attribute
      comment: "Primary sustainability attribute (recycled, organic, regenerative)"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of sustainability certification held"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where material is sourced"
    - name: "biodegradable_flag"
      expr: biodegradable_flag
      comment: "Whether material is biodegradable"
    - name: "renewable_source_flag"
      expr: renewable_source_flag
      comment: "Whether material is from renewable source"
    - name: "circular_economy_eligible_flag"
      expr: circular_economy_eligible_flag
      comment: "Whether material is eligible for circular economy programs"
    - name: "traceability_tier"
      expr: traceability_tier
      comment: "Level of supply chain traceability"
  measures:
    - name: "avg_recycled_content_pct"
      expr: AVG(CAST(recycled_content_percentage AS DOUBLE))
      comment: "Average recycled content percentage across materials"
    - name: "avg_organic_content_pct"
      expr: AVG(CAST(organic_content_percentage AS DOUBLE))
      comment: "Average organic content percentage across materials"
    - name: "avg_carbon_footprint_kg"
      expr: AVG(CAST(carbon_footprint_kg_co2e AS DOUBLE))
      comment: "Average carbon footprint per material in kg CO2e"
    - name: "avg_water_consumption_liters"
      expr: AVG(CAST(water_consumption_liters AS DOUBLE))
      comment: "Average water consumption per material in liters"
    - name: "avg_esg_score"
      expr: AVG(CAST(esg_score AS DOUBLE))
      comment: "Average ESG score across sustainable materials"
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of sustainable material"
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity across all materials"
    - name: "material_count"
      expr: COUNT(1)
      comment: "Total number of sustainable materials in catalog"
    - name: "certified_material_count"
      expr: COUNT(DISTINCT CASE WHEN certification_type IS NOT NULL THEN sustainable_material_id END)
      comment: "Number of materials with sustainability certification"
    - name: "supplier_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of distinct suppliers providing sustainable materials"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability initiative tracking with projected and actual impact across carbon, energy, water, and waste"
  source: "`apparel_fashion_ecm`.`sustainability`.`initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of sustainability initiative"
    - name: "initiative_status"
      expr: initiative_status
      comment: "Current status of initiative"
    - name: "sustainability_pillar"
      expr: sustainability_pillar
      comment: "Primary sustainability pillar (climate, water, waste, circularity)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of initiative"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with initiative"
    - name: "on_track_flag"
      expr: on_track_flag
      comment: "Whether initiative is on track to meet targets"
    - name: "alignment_to_sbti"
      expr: alignment_to_sbti
      comment: "Whether initiative aligns with Science Based Targets"
    - name: "public_disclosure_flag"
      expr: public_disclosure_flag
      comment: "Whether initiative is publicly disclosed"
    - name: "verification_status"
      expr: verification_status
      comment: "Third-party verification status"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of initiative"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year initiative started"
  measures:
    - name: "total_investment_amount"
      expr: SUM(CAST(investment_amount AS DOUBLE))
      comment: "Total investment in sustainability initiatives"
    - name: "total_projected_carbon_reduction_mt"
      expr: SUM(CAST(projected_carbon_reduction_mt_co2e AS DOUBLE))
      comment: "Total projected carbon reduction in metric tonnes CO2e"
    - name: "total_actual_carbon_reduction_mt"
      expr: SUM(CAST(actual_carbon_reduction_mt_co2e AS DOUBLE))
      comment: "Total actual carbon reduction achieved in metric tonnes CO2e"
    - name: "total_projected_energy_savings_mwh"
      expr: SUM(CAST(projected_energy_savings_mwh AS DOUBLE))
      comment: "Total projected energy savings in megawatt-hours"
    - name: "total_actual_energy_savings_mwh"
      expr: SUM(CAST(actual_energy_savings_mwh AS DOUBLE))
      comment: "Total actual energy savings achieved in megawatt-hours"
    - name: "total_projected_water_savings_m3"
      expr: SUM(CAST(projected_water_savings_m3 AS DOUBLE))
      comment: "Total projected water savings in cubic meters"
    - name: "total_actual_water_savings_m3"
      expr: SUM(CAST(actual_water_savings_m3 AS DOUBLE))
      comment: "Total actual water savings achieved in cubic meters"
    - name: "total_projected_waste_diversion_kg"
      expr: SUM(CAST(projected_waste_diversion_kg AS DOUBLE))
      comment: "Total projected waste diversion in kilograms"
    - name: "total_actual_waste_diversion_kg"
      expr: SUM(CAST(actual_waste_diversion_kg AS DOUBLE))
      comment: "Total actual waste diversion achieved in kilograms"
    - name: "avg_progress_pct"
      expr: AVG(CAST(progress_percentage AS DOUBLE))
      comment: "Average progress percentage across initiatives"
    - name: "carbon_achievement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_carbon_reduction_mt_co2e AS DOUBLE)) / NULLIF(SUM(CAST(projected_carbon_reduction_mt_co2e AS DOUBLE)), 0), 2)
      comment: "Percentage of projected carbon reduction actually achieved"
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Total number of sustainability initiatives"
    - name: "on_track_initiative_count"
      expr: COUNT(DISTINCT CASE WHEN on_track_flag = TRUE THEN initiative_id END)
      comment: "Number of initiatives currently on track"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`sustainability_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility-level sustainability performance including certifications, emissions, energy, water, and waste metrics"
  source: "`apparel_fashion_ecm`.`sustainability`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (manufacturing, distribution, office, retail)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of facility"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of facility location"
    - name: "tier_level"
      expr: tier_level
      comment: "Supply chain tier level of facility"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type (owned, leased, third-party)"
    - name: "certification_status"
      expr: certification_status
      comment: "Overall certification status"
    - name: "iso_14001_certified"
      expr: iso_14001_certified
      comment: "Whether facility holds ISO 14001 environmental certification"
    - name: "bluesign_certified"
      expr: bluesign_certified
      comment: "Whether facility is Bluesign certified"
    - name: "fair_trade_certified"
      expr: fair_trade_certified
      comment: "Whether facility is Fair Trade certified"
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED certification level (Certified, Silver, Gold, Platinum)"
    - name: "living_wage_compliant"
      expr: living_wage_compliant
      comment: "Whether facility pays living wage"
    - name: "wastewater_treatment_compliant"
      expr: wastewater_treatment_compliant
      comment: "Whether facility meets wastewater treatment standards"
  measures:
    - name: "total_annual_carbon_emissions_tonnes"
      expr: SUM(CAST(annual_carbon_emissions_tonnes AS DOUBLE))
      comment: "Total annual carbon emissions across facilities in metric tonnes"
    - name: "total_annual_energy_consumption_mwh"
      expr: SUM(CAST(annual_energy_consumption_mwh AS DOUBLE))
      comment: "Total annual energy consumption in megawatt-hours"
    - name: "total_annual_water_consumption_m3"
      expr: SUM(CAST(annual_water_consumption_cubic_meters AS DOUBLE))
      comment: "Total annual water consumption in cubic meters"
    - name: "total_hazardous_waste_tonnes"
      expr: SUM(CAST(hazardous_waste_generated_tonnes AS DOUBLE))
      comment: "Total hazardous waste generated in metric tonnes"
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage across facilities"
    - name: "avg_waste_diversion_rate_pct"
      expr: AVG(CAST(waste_diversion_rate_percentage AS DOUBLE))
      comment: "Average waste diversion rate from landfill"
    - name: "avg_higg_index_score"
      expr: AVG(CAST(higg_index_score AS DOUBLE))
      comment: "Average Higg Index environmental performance score"
    - name: "total_facility_area_sqm"
      expr: SUM(CAST(total_area_sqm AS DOUBLE))
      comment: "Total facility area in square meters"
    - name: "total_employee_count"
      expr: SUM(CAST(employee_count AS BIGINT))
      comment: "Total employee count across all facilities"
    - name: "facility_count"
      expr: COUNT(1)
      comment: "Total number of facilities"
    - name: "certified_facility_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Certified' THEN facility_id END)
      comment: "Number of facilities with active certifications"
$$;