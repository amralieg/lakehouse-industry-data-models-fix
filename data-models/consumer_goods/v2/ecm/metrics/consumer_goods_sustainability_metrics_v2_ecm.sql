-- Metric views for domain: sustainability | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-23 23:45:49

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_biodiversity_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Biodiversity Impact business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`biodiversity_impact`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Version"
      expr: assessment_version
    - name: "Assessor Email"
      expr: assessor_email
    - name: "Assessor Name"
      expr: assessor_name
    - name: "Biodiversity Risk Level"
      expr: biodiversity_risk_level
    - name: "Biodiversity Score Method"
      expr: biodiversity_score_method
    - name: "Biodiversity Impact Category"
      expr: biodiversity_impact_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Geographic Location"
      expr: geographic_location
    - name: "Habitat Type"
      expr: habitat_type
    - name: "Impact Category"
      expr: impact_category
    - name: "Impact Type"
      expr: impact_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Biodiversity Impact"
      expr: COUNT(DISTINCT biodiversity_impact_id)
    - name: "Total Habitat Area Affected Hectares"
      expr: SUM(habitat_area_affected_hectares)
    - name: "Average Habitat Area Affected Hectares"
      expr: AVG(habitat_area_affected_hectares)
    - name: "Total Impact Score"
      expr: SUM(impact_score)
    - name: "Average Impact Score"
      expr: AVG(impact_score)
    - name: "Total Land Use Area Ha"
      expr: SUM(land_use_area_ha)
    - name: "Average Land Use Area Ha"
      expr: AVG(land_use_area_ha)
    - name: "Total Net Biodiversity Impact Score"
      expr: SUM(net_biodiversity_impact_score)
    - name: "Average Net Biodiversity Impact Score"
      expr: AVG(net_biodiversity_impact_score)
    - name: "Total Protected Area Proximity Km"
      expr: SUM(protected_area_proximity_km)
    - name: "Average Protected Area Proximity Km"
      expr: AVG(protected_area_proximity_km)
    - name: "Total Proximity To Protected Area Km"
      expr: SUM(proximity_to_protected_area_km)
    - name: "Average Proximity To Protected Area Km"
      expr: AVG(proximity_to_protected_area_km)
    - name: "Total Restoration Area Hectares"
      expr: SUM(restoration_area_hectares)
    - name: "Average Restoration Area Hectares"
      expr: AVG(restoration_area_hectares)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_carbon_emission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon Emission business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`carbon_emission`"
  dimensions:
    - name: "Activity Type"
      expr: activity_type
    - name: "Auditor Name"
      expr: auditor_name
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Calculation Methodology"
      expr: calculation_methodology
    - name: "Cdp Reporting Flag"
      expr: cdp_reporting_flag
    - name: "Cdpr Reporting Flag"
      expr: cdpr_reporting_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Data Source"
      expr: data_source
    - name: "Emission Factor Date"
      expr: emission_factor_date
    - name: "Emission Factor Source"
      expr: emission_factor_source
    - name: "Emission Factor Version"
      expr: emission_factor_version
    - name: "Emission Source"
      expr: emission_source
    - name: "Emission Source Category"
      expr: emission_source_category
    - name: "Emission Timestamp"
      expr: emission_timestamp
    - name: "External Reporting Standard"
      expr: external_reporting_standard
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carbon Emission"
      expr: COUNT(DISTINCT carbon_emission_id)
    - name: "Total Carbon Intensity Factor"
      expr: SUM(carbon_intensity_factor)
    - name: "Average Carbon Intensity Factor"
      expr: AVG(carbon_intensity_factor)
    - name: "Total Co2e Quantity Tonnes"
      expr: SUM(co2e_quantity_tonnes)
    - name: "Average Co2e Quantity Tonnes"
      expr: AVG(co2e_quantity_tonnes)
    - name: "Total Emission Factor"
      expr: SUM(emission_factor)
    - name: "Average Emission Factor"
      expr: AVG(emission_factor)
    - name: "Total Energy Consumption Mwh"
      expr: SUM(energy_consumption_mwh)
    - name: "Average Energy Consumption Mwh"
      expr: AVG(energy_consumption_mwh)
    - name: "Total Offset Quantity Tonnes"
      expr: SUM(offset_quantity_tonnes)
    - name: "Average Offset Quantity Tonnes"
      expr: AVG(offset_quantity_tonnes)
    - name: "Total Scope 1 Emissions Mt Co2e"
      expr: SUM(scope_1_emissions_mt_co2e)
    - name: "Average Scope 1 Emissions Mt Co2e"
      expr: AVG(scope_1_emissions_mt_co2e)
    - name: "Total Scope 2 Emissions Mt Co2e"
      expr: SUM(scope_2_emissions_mt_co2e)
    - name: "Average Scope 2 Emissions Mt Co2e"
      expr: AVG(scope_2_emissions_mt_co2e)
    - name: "Total Scope 3 Emissions Mt Co2e"
      expr: SUM(scope_3_emissions_mt_co2e)
    - name: "Average Scope 3 Emissions Mt Co2e"
      expr: AVG(scope_3_emissions_mt_co2e)
    - name: "Total Total Emissions Mt Co2e"
      expr: SUM(total_emissions_mt_co2e)
    - name: "Average Total Emissions Mt Co2e"
      expr: AVG(total_emissions_mt_co2e)
    - name: "Total Water Consumption M3"
      expr: SUM(water_consumption_m3)
    - name: "Average Water Consumption M3"
      expr: AVG(water_consumption_m3)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_carbon_offset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carbon Offset business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`carbon_offset`"
  dimensions:
    - name: "Alignment Type"
      expr: alignment_type
    - name: "Carbon Offset Status"
      expr: carbon_offset_status
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Offset Standard"
      expr: offset_standard
    - name: "Offset Type"
      expr: offset_type
    - name: "Project Description"
      expr: project_description
    - name: "Project Location"
      expr: project_location
    - name: "Project Name"
      expr: project_name
    - name: "Project Type"
      expr: project_type
    - name: "Purchase Certificate Number"
      expr: purchase_certificate_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carbon Offset"
      expr: COUNT(DISTINCT carbon_offset_id)
    - name: "Total Cost Per Credit"
      expr: SUM(cost_per_credit)
    - name: "Average Cost Per Credit"
      expr: AVG(cost_per_credit)
    - name: "Total Cost Per Tonne"
      expr: SUM(cost_per_tonne)
    - name: "Average Cost Per Tonne"
      expr: AVG(cost_per_tonne)
    - name: "Total Credit Quantity Purchased"
      expr: SUM(credit_quantity_purchased)
    - name: "Average Credit Quantity Purchased"
      expr: AVG(credit_quantity_purchased)
    - name: "Total Credit Quantity Retired"
      expr: SUM(credit_quantity_retired)
    - name: "Average Credit Quantity Retired"
      expr: AVG(credit_quantity_retired)
    - name: "Total Credits Purchased Mt Co2e"
      expr: SUM(credits_purchased_mt_co2e)
    - name: "Average Credits Purchased Mt Co2e"
      expr: AVG(credits_purchased_mt_co2e)
    - name: "Total Credits Retired Mt Co2e"
      expr: SUM(credits_retired_mt_co2e)
    - name: "Average Credits Retired Mt Co2e"
      expr: AVG(credits_retired_mt_co2e)
    - name: "Total Offset Quantity Tonnes"
      expr: SUM(offset_quantity_tonnes)
    - name: "Average Offset Quantity Tonnes"
      expr: AVG(offset_quantity_tonnes)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
    - name: "Total Total Cost Amount"
      expr: SUM(total_cost_amount)
    - name: "Average Total Cost Amount"
      expr: AVG(total_cost_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_circular_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular Initiative business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`circular_initiative`"
  dimensions:
    - name: "Circular Initiative Status"
      expr: circular_initiative_status
    - name: "Compliance Fsc Certified"
      expr: compliance_fsc_certified
    - name: "Compliance Rspo Certified"
      expr: compliance_rspo_certified
    - name: "Cost Savings Currency Code"
      expr: cost_savings_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "End Date"
      expr: end_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Initiative Budget Currency"
      expr: initiative_budget_currency
    - name: "Initiative Code"
      expr: initiative_code
    - name: "Initiative Description"
      expr: initiative_description
    - name: "Initiative Name"
      expr: initiative_name
    - name: "Initiative Owner"
      expr: initiative_owner
    - name: "Initiative Owner Email"
      expr: initiative_owner_email
    - name: "Initiative Status"
      expr: initiative_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Circular Initiative"
      expr: COUNT(DISTINCT circular_initiative_id)
    - name: "Total Carbon Footprint Avoided Tonnes"
      expr: SUM(carbon_footprint_avoided_tonnes)
    - name: "Average Carbon Footprint Avoided Tonnes"
      expr: AVG(carbon_footprint_avoided_tonnes)
    - name: "Total Consumer Participation Rate Pct"
      expr: SUM(consumer_participation_rate_pct)
    - name: "Average Consumer Participation Rate Pct"
      expr: AVG(consumer_participation_rate_pct)
    - name: "Total Cost Savings Amount"
      expr: SUM(cost_savings_amount)
    - name: "Average Cost Savings Amount"
      expr: AVG(cost_savings_amount)
    - name: "Total Energy Savings Mwh"
      expr: SUM(energy_savings_mwh)
    - name: "Average Energy Savings Mwh"
      expr: AVG(energy_savings_mwh)
    - name: "Total Investment Amount Usd"
      expr: SUM(investment_amount_usd)
    - name: "Average Investment Amount Usd"
      expr: AVG(investment_amount_usd)
    - name: "Total Material Diverted Tonnes"
      expr: SUM(material_diverted_tonnes)
    - name: "Average Material Diverted Tonnes"
      expr: AVG(material_diverted_tonnes)
    - name: "Total Material Recovered Kg"
      expr: SUM(material_recovered_kg)
    - name: "Average Material Recovered Kg"
      expr: AVG(material_recovered_kg)
    - name: "Total Material Recovered Tonnes"
      expr: SUM(material_recovered_tonnes)
    - name: "Average Material Recovered Tonnes"
      expr: AVG(material_recovered_tonnes)
    - name: "Total Recycling Rate Percentage"
      expr: SUM(recycling_rate_percentage)
    - name: "Average Recycling Rate Percentage"
      expr: AVG(recycling_rate_percentage)
    - name: "Total Target Material Percentage"
      expr: SUM(target_material_percentage)
    - name: "Average Target Material Percentage"
      expr: AVG(target_material_percentage)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
    - name: "Total Waste Reduction Tonnes"
      expr: SUM(waste_reduction_tonnes)
    - name: "Average Waste Reduction Tonnes"
      expr: AVG(waste_reduction_tonnes)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_commitment_progress`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commitment Progress business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`commitment_progress`"
  dimensions:
    - name: "Commentary"
      expr: commentary
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Date"
      expr: measurement_date
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Mitigation Actions"
      expr: mitigation_actions
    - name: "Notes"
      expr: notes
    - name: "On Track Flag"
      expr: on_track_flag
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Start Date"
      expr: period_start_date
    - name: "Period Type"
      expr: period_type
    - name: "Record Status"
      expr: record_status
    - name: "Reporting Boundary"
      expr: reporting_boundary
    - name: "Reporting Period End"
      expr: reporting_period_end
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commitment Progress"
      expr: COUNT(DISTINCT commitment_progress_id)
    - name: "Total Achievement Pct"
      expr: SUM(achievement_pct)
    - name: "Average Achievement Pct"
      expr: AVG(achievement_pct)
    - name: "Total Actual Value"
      expr: SUM(actual_value)
    - name: "Average Actual Value"
      expr: AVG(actual_value)
    - name: "Total Current Value"
      expr: SUM(current_value)
    - name: "Average Current Value"
      expr: AVG(current_value)
    - name: "Total Percentage Of Target"
      expr: SUM(percentage_of_target)
    - name: "Average Percentage Of Target"
      expr: AVG(percentage_of_target)
    - name: "Total Progress Percentage"
      expr: SUM(progress_percentage)
    - name: "Average Progress Percentage"
      expr: AVG(progress_percentage)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_deforestation_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Deforestation Assessment business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`deforestation_assessment`"
  dimensions:
    - name: "Assessment Approval Date"
      expr: assessment_approval_date
    - name: "Assessment Approved By"
      expr: assessment_approved_by
    - name: "Assessment Code"
      expr: assessment_code
    - name: "Assessment Created By"
      expr: assessment_created_by
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Notes"
      expr: assessment_notes
    - name: "Assessment Review Date"
      expr: assessment_review_date
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Certification Valid Until"
      expr: certification_valid_until
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Corrective Action Required Flag"
      expr: corrective_action_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Status"
      expr: data_quality_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Deforestation Assessment"
      expr: COUNT(DISTINCT deforestation_assessment_id)
    - name: "Total Carbon Emission Estimate Tonnes"
      expr: SUM(carbon_emission_estimate_tonnes)
    - name: "Average Carbon Emission Estimate Tonnes"
      expr: AVG(carbon_emission_estimate_tonnes)
    - name: "Total Certification Coverage Percent"
      expr: SUM(certification_coverage_percent)
    - name: "Average Certification Coverage Percent"
      expr: AVG(certification_coverage_percent)
    - name: "Total Energy Consumption Mwh"
      expr: SUM(energy_consumption_mwh)
    - name: "Average Energy Consumption Mwh"
      expr: AVG(energy_consumption_mwh)
    - name: "Total Forest Area Ha"
      expr: SUM(forest_area_ha)
    - name: "Average Forest Area Ha"
      expr: AVG(forest_area_ha)
    - name: "Total Forest Cover Change Percent"
      expr: SUM(forest_cover_change_percent)
    - name: "Average Forest Cover Change Percent"
      expr: AVG(forest_cover_change_percent)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
    - name: "Total Water Usage M3"
      expr: SUM(water_usage_m3)
    - name: "Average Water Usage M3"
      expr: AVG(water_usage_m3)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_energy_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy Certificate business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`energy_certificate`"
  dimensions:
    - name: "Business Unit"
      expr: business_unit
    - name: "Certificate Name"
      expr: certificate_name
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certificate Type"
      expr: certificate_type
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "Energy Certificate Status"
      expr: energy_certificate_status
    - name: "Energy Source"
      expr: energy_source
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Generating Facility Location"
      expr: generating_facility_location
    - name: "Generating Facility Name"
      expr: generating_facility_name
    - name: "Generator Location"
      expr: generator_location
    - name: "Generator Name"
      expr: generator_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Energy Certificate"
      expr: COUNT(DISTINCT energy_certificate_id)
    - name: "Total Carbon Emission Factor"
      expr: SUM(carbon_emission_factor)
    - name: "Average Carbon Emission Factor"
      expr: AVG(carbon_emission_factor)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Energy Amount Mwh"
      expr: SUM(energy_amount_mwh)
    - name: "Average Energy Amount Mwh"
      expr: AVG(energy_amount_mwh)
    - name: "Total Energy Mwh"
      expr: SUM(energy_mwh)
    - name: "Average Energy Mwh"
      expr: AVG(energy_mwh)
    - name: "Total Quantity Mwh"
      expr: SUM(quantity_mwh)
    - name: "Average Quantity Mwh"
      expr: AVG(quantity_mwh)
    - name: "Total Renewable Energy Percentage"
      expr: SUM(renewable_energy_percentage)
    - name: "Average Renewable Energy Percentage"
      expr: AVG(renewable_energy_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_energy_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy Consumption business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`energy_consumption`"
  dimensions:
    - name: "Consumption Reference"
      expr: consumption_reference
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Consumption Unit"
      expr: consumption_unit
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "Data Source System"
      expr: data_source_system
    - name: "Energy Consumption Status"
      expr: energy_consumption_status
    - name: "Energy Source"
      expr: energy_source
    - name: "Energy Type"
      expr: energy_type
    - name: "Energy Unit"
      expr: energy_unit
    - name: "Is Renewable"
      expr: is_renewable
    - name: "Iso 50001 Compliance Flag"
      expr: iso_50001_compliance_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Source"
      expr: measurement_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Energy Consumption"
      expr: COUNT(DISTINCT energy_consumption_id)
    - name: "Total Carbon Emission Factor"
      expr: SUM(carbon_emission_factor)
    - name: "Average Carbon Emission Factor"
      expr: AVG(carbon_emission_factor)
    - name: "Total Consumption Amount"
      expr: SUM(consumption_amount)
    - name: "Average Consumption Amount"
      expr: AVG(consumption_amount)
    - name: "Total Consumption Kwh"
      expr: SUM(consumption_kwh)
    - name: "Average Consumption Kwh"
      expr: AVG(consumption_kwh)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Energy Intensity Ratio"
      expr: SUM(energy_intensity_ratio)
    - name: "Average Energy Intensity Ratio"
      expr: AVG(energy_intensity_ratio)
    - name: "Total Energy Quantity"
      expr: SUM(energy_quantity)
    - name: "Average Energy Quantity"
      expr: AVG(energy_quantity)
    - name: "Total Renewable Energy Percentage"
      expr: SUM(renewable_energy_percentage)
    - name: "Average Renewable Energy Percentage"
      expr: AVG(renewable_energy_percentage)
    - name: "Total Renewable Percentage"
      expr: SUM(renewable_percentage)
    - name: "Average Renewable Percentage"
      expr: AVG(renewable_percentage)
    - name: "Total Tariff Rate"
      expr: SUM(tariff_rate)
    - name: "Average Tariff Rate"
      expr: AVG(tariff_rate)
    - name: "Total Total Cost"
      expr: SUM(total_cost)
    - name: "Average Total Cost"
      expr: AVG(total_cost)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_environmental_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental Incident business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`environmental_incident`"
  dimensions:
    - name: "City"
      expr: city
    - name: "Closure Date"
      expr: closure_date
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Corrective Action"
      expr: corrective_action
    - name: "Corrective Action Taken"
      expr: corrective_action_taken
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Environmental Impact Assessment"
      expr: environmental_impact_assessment
    - name: "Environmental Incident Status"
      expr: environmental_incident_status
    - name: "Incident Date"
      expr: incident_date
    - name: "Incident Description"
      expr: incident_description
    - name: "Incident Number"
      expr: incident_number
    - name: "Incident Severity"
      expr: incident_severity
    - name: "Incident Status"
      expr: incident_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Environmental Incident"
      expr: COUNT(DISTINCT environmental_incident_id)
    - name: "Total Estimated Cost"
      expr: SUM(estimated_cost)
    - name: "Average Estimated Cost"
      expr: AVG(estimated_cost)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Quantity Released"
      expr: SUM(quantity_released)
    - name: "Average Quantity Released"
      expr: AVG(quantity_released)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental Permit business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`environmental_permit`"
  dimensions:
    - name: "Activity Description"
      expr: activity_description
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Environmental Permit Status"
      expr: environmental_permit_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Inspection Status"
      expr: inspection_status
    - name: "Iso 14001 Linkage"
      expr: iso_14001_linkage
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Authority"
      expr: issuing_authority
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Limit Unit"
      expr: limit_unit
    - name: "Monitoring Frequency"
      expr: monitoring_frequency
    - name: "Next Inspection Date"
      expr: next_inspection_date
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Environmental Permit"
      expr: COUNT(DISTINCT environmental_permit_id)
    - name: "Total Discharge Limit"
      expr: SUM(discharge_limit)
    - name: "Average Discharge Limit"
      expr: AVG(discharge_limit)
    - name: "Total Emission Limit"
      expr: SUM(emission_limit)
    - name: "Average Emission Limit"
      expr: AVG(emission_limit)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Esg Audit business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_audit`"
  dimensions:
    - name: "Audit Certification Status"
      expr: audit_certification_status
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Findings Summary"
      expr: audit_findings_summary
    - name: "Audit Location"
      expr: audit_location
    - name: "Audit Method"
      expr: audit_method
    - name: "Audit Number"
      expr: audit_number
    - name: "Audit Region"
      expr: audit_region
    - name: "Audit Report Reference"
      expr: audit_report_reference
    - name: "Audit Report Url"
      expr: audit_report_url
    - name: "Audit Result"
      expr: audit_result
    - name: "Audit Scope"
      expr: audit_scope
    - name: "Audit Scope Description"
      expr: audit_scope_description
    - name: "Audit Standard"
      expr: audit_standard
    - name: "Audit Status"
      expr: audit_status
    - name: "Audit Type"
      expr: audit_type
    - name: "Auditing Body"
      expr: auditing_body
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Esg Audit"
      expr: COUNT(DISTINCT esg_audit_id)
    - name: "Total Audit Duration Hours"
      expr: SUM(audit_duration_hours)
    - name: "Average Audit Duration Hours"
      expr: AVG(audit_duration_hours)
    - name: "Total Overall Score"
      expr: SUM(overall_score)
    - name: "Average Overall Score"
      expr: AVG(overall_score)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Esg Commitment business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_commitment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Baseline Year"
      expr: baseline_year
    - name: "Commitment Code"
      expr: commitment_code
    - name: "Commitment Description"
      expr: commitment_description
    - name: "Commitment Name"
      expr: commitment_name
    - name: "Commitment Owner"
      expr: commitment_owner
    - name: "Commitment Scope"
      expr: commitment_scope
    - name: "Commitment Status"
      expr: commitment_status
    - name: "Commitment Type"
      expr: commitment_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disclosure Status"
      expr: disclosure_status
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Esg Commitment Status"
      expr: esg_commitment_status
    - name: "External Reference Code"
      expr: external_reference_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Esg Commitment"
      expr: COUNT(DISTINCT esg_commitment_id)
    - name: "Total Baseline Value"
      expr: SUM(baseline_value)
    - name: "Average Baseline Value"
      expr: AVG(baseline_value)
    - name: "Total Target Value"
      expr: SUM(target_value)
    - name: "Average Target Value"
      expr: AVG(target_value)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_esg_disclosure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Esg Disclosure business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`esg_disclosure`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Assurance Level"
      expr: assurance_level
    - name: "Assurance Provider"
      expr: assurance_provider
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disclosure Framework"
      expr: disclosure_framework
    - name: "Disclosure Narrative"
      expr: disclosure_narrative
    - name: "Disclosure Period"
      expr: disclosure_period
    - name: "Disclosure Reference"
      expr: disclosure_reference
    - name: "Disclosure Status"
      expr: disclosure_status
    - name: "Disclosure Topic"
      expr: disclosure_topic
    - name: "Disclosure Type"
      expr: disclosure_type
    - name: "Document Url"
      expr: document_url
    - name: "Esg Disclosure Status"
      expr: esg_disclosure_status
    - name: "External Assurance Flag"
      expr: external_assurance_flag
    - name: "Framework"
      expr: framework
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Esg Disclosure"
      expr: COUNT(DISTINCT esg_disclosure_id)
    - name: "Total Carbon Emissions Scope1"
      expr: SUM(carbon_emissions_scope1)
    - name: "Average Carbon Emissions Scope1"
      expr: AVG(carbon_emissions_scope1)
    - name: "Total Carbon Emissions Scope2"
      expr: SUM(carbon_emissions_scope2)
    - name: "Average Carbon Emissions Scope2"
      expr: AVG(carbon_emissions_scope2)
    - name: "Total Carbon Emissions Scope3"
      expr: SUM(carbon_emissions_scope3)
    - name: "Average Carbon Emissions Scope3"
      expr: AVG(carbon_emissions_scope3)
    - name: "Total Energy Consumption"
      expr: SUM(energy_consumption)
    - name: "Average Energy Consumption"
      expr: AVG(energy_consumption)
    - name: "Total Metric Value"
      expr: SUM(metric_value)
    - name: "Average Metric Value"
      expr: AVG(metric_value)
    - name: "Total Packaging Recyclability Rate"
      expr: SUM(packaging_recyclability_rate)
    - name: "Average Packaging Recyclability Rate"
      expr: AVG(packaging_recyclability_rate)
    - name: "Total Renewable Energy Percentage"
      expr: SUM(renewable_energy_percentage)
    - name: "Average Renewable Energy Percentage"
      expr: AVG(renewable_energy_percentage)
    - name: "Total Total Carbon Emissions"
      expr: SUM(total_carbon_emissions)
    - name: "Average Total Carbon Emissions"
      expr: AVG(total_carbon_emissions)
    - name: "Total Waste Generated"
      expr: SUM(waste_generated)
    - name: "Average Waste Generated"
      expr: AVG(waste_generated)
    - name: "Total Water Consumption"
      expr: SUM(water_consumption)
    - name: "Average Water Consumption"
      expr: AVG(water_consumption)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_materiality_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Materiality Assessment business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`materiality_assessment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assessment Code"
      expr: assessment_code
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Methodology"
      expr: assessment_methodology
    - name: "Assessment Name"
      expr: assessment_name
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Assessment Year"
      expr: assessment_year
    - name: "Comments"
      expr: comments
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Disclosure Priority"
      expr: disclosure_priority
    - name: "Effective Date"
      expr: effective_date
    - name: "Esg Topic"
      expr: esg_topic
    - name: "Expiration Date"
      expr: expiration_date
    - name: "External Certification"
      expr: external_certification
    - name: "Impact Category"
      expr: impact_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Materiality Assessment"
      expr: COUNT(DISTINCT materiality_assessment_id)
    - name: "Total Business Impact Score"
      expr: SUM(business_impact_score)
    - name: "Average Business Impact Score"
      expr: AVG(business_impact_score)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Materiality Score"
      expr: SUM(materiality_score)
    - name: "Average Materiality Score"
      expr: AVG(materiality_score)
    - name: "Total Stakeholder Concern Score"
      expr: SUM(stakeholder_concern_score)
    - name: "Average Stakeholder Concern Score"
      expr: AVG(stakeholder_concern_score)
    - name: "Total Stakeholder Engagement Score"
      expr: SUM(stakeholder_engagement_score)
    - name: "Average Stakeholder Engagement Score"
      expr: AVG(stakeholder_engagement_score)
    - name: "Total Stakeholder Importance Score"
      expr: SUM(stakeholder_importance_score)
    - name: "Average Stakeholder Importance Score"
      expr: AVG(stakeholder_importance_score)
    - name: "Total Threshold Value"
      expr: SUM(threshold_value)
    - name: "Average Threshold Value"
      expr: AVG(threshold_value)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_packaging_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Packaging Profile business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`packaging_profile`"
  dimensions:
    - name: "Additional Certification"
      expr: additional_certification
    - name: "Component Type"
      expr: component_type
    - name: "Compostable"
      expr: compostable
    - name: "Compostable Flag"
      expr: compostable_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Design Version"
      expr: design_version
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "End Of Life Disposal Method"
      expr: end_of_life_disposal_method
    - name: "Eu Packaging Waste Compliance Status"
      expr: eu_packaging_waste_compliance_status
    - name: "Fsc Certified"
      expr: fsc_certified
    - name: "Fsc Certified Flag"
      expr: fsc_certified_flag
    - name: "Gtin"
      expr: gtin
    - name: "How2recycle Label"
      expr: how2recycle_label
    - name: "Is Compostable"
      expr: is_compostable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Packaging Profile"
      expr: COUNT(DISTINCT packaging_profile_id)
    - name: "Total Bio Based Content Percentage"
      expr: SUM(bio_based_content_percentage)
    - name: "Average Bio Based Content Percentage"
      expr: AVG(bio_based_content_percentage)
    - name: "Total Carbon Footprint Kg Co2e"
      expr: SUM(carbon_footprint_kg_co2e)
    - name: "Average Carbon Footprint Kg Co2e"
      expr: AVG(carbon_footprint_kg_co2e)
    - name: "Total Energy Usage Kwh"
      expr: SUM(energy_usage_kwh)
    - name: "Average Energy Usage Kwh"
      expr: AVG(energy_usage_kwh)
    - name: "Total Lightweighting Reduction Percent"
      expr: SUM(lightweighting_reduction_percent)
    - name: "Average Lightweighting Reduction Percent"
      expr: AVG(lightweighting_reduction_percent)
    - name: "Total Material Composition Aluminum Percent"
      expr: SUM(material_composition_aluminum_percent)
    - name: "Average Material Composition Aluminum Percent"
      expr: AVG(material_composition_aluminum_percent)
    - name: "Total Material Composition Glass Percent"
      expr: SUM(material_composition_glass_percent)
    - name: "Average Material Composition Glass Percent"
      expr: AVG(material_composition_glass_percent)
    - name: "Total Material Composition Paper Percent"
      expr: SUM(material_composition_paper_percent)
    - name: "Average Material Composition Paper Percent"
      expr: AVG(material_composition_paper_percent)
    - name: "Total Material Composition Pcr Percent"
      expr: SUM(material_composition_pcr_percent)
    - name: "Average Material Composition Pcr Percent"
      expr: AVG(material_composition_pcr_percent)
    - name: "Total Material Composition Virgin Percent"
      expr: SUM(material_composition_virgin_percent)
    - name: "Average Material Composition Virgin Percent"
      expr: AVG(material_composition_virgin_percent)
    - name: "Total Packaging Height Cm"
      expr: SUM(packaging_height_cm)
    - name: "Average Packaging Height Cm"
      expr: AVG(packaging_height_cm)
    - name: "Total Packaging Length Cm"
      expr: SUM(packaging_length_cm)
    - name: "Average Packaging Length Cm"
      expr: AVG(packaging_length_cm)
    - name: "Total Packaging Weight G"
      expr: SUM(packaging_weight_g)
    - name: "Average Packaging Weight G"
      expr: AVG(packaging_weight_g)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_product_lca`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Lca business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`product_lca`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Certification Fsc"
      expr: certification_fsc
    - name: "Certification Rspo"
      expr: certification_rspo
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "Data Source System"
      expr: data_source_system
    - name: "Functional Unit"
      expr: functional_unit
    - name: "Functional Unit Uom"
      expr: functional_unit_uom
    - name: "Hotspot Stages"
      expr: hotspot_stages
    - name: "Intended Use"
      expr: intended_use
    - name: "Iso 14040 Compliance Flag"
      expr: iso_14040_compliance_flag
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Lca Methodology"
      expr: lca_methodology
    - name: "Lca Practitioner"
      expr: lca_practitioner
    - name: "Lca Study Name"
      expr: lca_study_name
    - name: "Lca Study Type"
      expr: lca_study_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Lca"
      expr: COUNT(DISTINCT product_lca_id)
    - name: "Total Acidification Potential Kg So2e"
      expr: SUM(acidification_potential_kg_so2e)
    - name: "Average Acidification Potential Kg So2e"
      expr: AVG(acidification_potential_kg_so2e)
    - name: "Total Carbon Footprint Kg Co2e"
      expr: SUM(carbon_footprint_kg_co2e)
    - name: "Average Carbon Footprint Kg Co2e"
      expr: AVG(carbon_footprint_kg_co2e)
    - name: "Total Energy Consumption Mj"
      expr: SUM(energy_consumption_mj)
    - name: "Average Energy Consumption Mj"
      expr: AVG(energy_consumption_mj)
    - name: "Total Eutrophication Potential Kg Po4e"
      expr: SUM(eutrophication_potential_kg_po4e)
    - name: "Average Eutrophication Potential Kg Po4e"
      expr: AVG(eutrophication_potential_kg_po4e)
    - name: "Total Functional Unit Quantity"
      expr: SUM(functional_unit_quantity)
    - name: "Average Functional Unit Quantity"
      expr: AVG(functional_unit_quantity)
    - name: "Total Water Footprint Liters"
      expr: SUM(water_footprint_liters)
    - name: "Average Water Footprint Liters"
      expr: AVG(water_footprint_liters)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_social_impact_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Social Impact Program business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`social_impact_program`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Beneficiaries Count"
      expr: beneficiaries_count
    - name: "Beneficiary Count"
      expr: beneficiary_count
    - name: "Beneficiary Group"
      expr: beneficiary_group
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Quality Status"
      expr: data_quality_status
    - name: "End Date"
      expr: end_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Geographic Focus"
      expr: geographic_focus
    - name: "Geographic Location"
      expr: geographic_location
    - name: "Impact Metric Name"
      expr: impact_metric_name
    - name: "Investment Currency Code"
      expr: investment_currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Social Impact Program"
      expr: COUNT(DISTINCT social_impact_program_id)
    - name: "Total Beneficiaries Reached"
      expr: SUM(beneficiaries_reached)
    - name: "Average Beneficiaries Reached"
      expr: AVG(beneficiaries_reached)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Impact Metric Value"
      expr: SUM(impact_metric_value)
    - name: "Average Impact Metric Value"
      expr: AVG(impact_metric_value)
    - name: "Total Investment Amount"
      expr: SUM(investment_amount)
    - name: "Average Investment Amount"
      expr: AVG(investment_amount)
    - name: "Total Outcome Metric Value"
      expr: SUM(outcome_metric_value)
    - name: "Average Outcome Metric Value"
      expr: AVG(outcome_metric_value)
    - name: "Total Program Budget"
      expr: SUM(program_budget)
    - name: "Average Program Budget"
      expr: AVG(program_budget)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_sourcing_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing Certification business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`sourcing_certification`"
  dimensions:
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Report Reference"
      expr: audit_report_reference
    - name: "Audit Status"
      expr: audit_status
    - name: "Certificate Document Url"
      expr: certificate_document_url
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certification Body"
      expr: certification_body
    - name: "Certification Scope"
      expr: certification_scope
    - name: "Certification Status"
      expr: certification_status
    - name: "Certification Type"
      expr: certification_type
    - name: "Certification Url"
      expr: certification_url
    - name: "Compliance Notes"
      expr: compliance_notes
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Effective Date"
      expr: effective_date
    - name: "Effective From"
      expr: effective_from
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sourcing Certification"
      expr: COUNT(DISTINCT sourcing_certification_id)
    - name: "Total Annual Certified Volume"
      expr: SUM(annual_certified_volume)
    - name: "Average Annual Certified Volume"
      expr: AVG(annual_certified_volume)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_supplier_esg_eval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier Esg Eval business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`supplier_esg_eval`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Reference"
      expr: assessment_reference
    - name: "Assessment Scope"
      expr: assessment_scope
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Assessment Version"
      expr: assessment_version
    - name: "Carbon Disclosure Flag"
      expr: carbon_disclosure_flag
    - name: "Comments"
      expr: comments
    - name: "Compliance Flags"
      expr: compliance_flags
    - name: "Conflict Minerals Policy Flag"
      expr: conflict_minerals_policy_flag
    - name: "Corrective Action Due Date"
      expr: corrective_action_due_date
    - name: "Corrective Action Plan"
      expr: corrective_action_plan
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Corrective Action Required Flag"
      expr: corrective_action_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Critical Findings Count"
      expr: critical_findings_count
    - name: "Data Source System"
      expr: data_source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supplier Esg Eval"
      expr: COUNT(DISTINCT supplier_esg_eval_id)
    - name: "Total Carbon Emission Score"
      expr: SUM(carbon_emission_score)
    - name: "Average Carbon Emission Score"
      expr: AVG(carbon_emission_score)
    - name: "Total Energy Consumption Score"
      expr: SUM(energy_consumption_score)
    - name: "Average Energy Consumption Score"
      expr: AVG(energy_consumption_score)
    - name: "Total Environmental Score"
      expr: SUM(environmental_score)
    - name: "Average Environmental Score"
      expr: AVG(environmental_score)
    - name: "Total Ethics Score"
      expr: SUM(ethics_score)
    - name: "Average Ethics Score"
      expr: AVG(ethics_score)
    - name: "Total Evaluation Score"
      expr: SUM(evaluation_score)
    - name: "Average Evaluation Score"
      expr: AVG(evaluation_score)
    - name: "Total Governance Score"
      expr: SUM(governance_score)
    - name: "Average Governance Score"
      expr: AVG(governance_score)
    - name: "Total Overall Esg Score"
      expr: SUM(overall_esg_score)
    - name: "Average Overall Esg Score"
      expr: AVG(overall_esg_score)
    - name: "Total Overall Score"
      expr: SUM(overall_score)
    - name: "Average Overall Score"
      expr: AVG(overall_score)
    - name: "Total Social Score"
      expr: SUM(social_score)
    - name: "Average Social Score"
      expr: AVG(social_score)
    - name: "Total Waste Management Score"
      expr: SUM(waste_management_score)
    - name: "Average Waste Management Score"
      expr: AVG(waste_management_score)
    - name: "Total Water Consumption Score"
      expr: SUM(water_consumption_score)
    - name: "Average Water Consumption Score"
      expr: AVG(water_consumption_score)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_supply_chain_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply Chain Activity business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`supply_chain_activity`"
  dimensions:
    - name: "Activity Category"
      expr: activity_category
    - name: "Activity Code"
      expr: activity_code
    - name: "Activity Date"
      expr: activity_date
    - name: "Activity Description"
      expr: activity_description
    - name: "Activity Name"
      expr: activity_name
    - name: "Activity Subcategory"
      expr: activity_subcategory
    - name: "Activity Type"
      expr: activity_type
    - name: "Certification Number"
      expr: certification_number
    - name: "Certification Type"
      expr: certification_type
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Last Reported Timestamp"
      expr: last_reported_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Supply Chain Activity"
      expr: COUNT(DISTINCT supply_chain_activity_id)
    - name: "Total Actual Amount"
      expr: SUM(actual_amount)
    - name: "Average Actual Amount"
      expr: AVG(actual_amount)
    - name: "Total Baseline Amount"
      expr: SUM(baseline_amount)
    - name: "Average Baseline Amount"
      expr: AVG(baseline_amount)
    - name: "Total Carbon Emissions Kg Co2e"
      expr: SUM(carbon_emissions_kg_co2e)
    - name: "Average Carbon Emissions Kg Co2e"
      expr: AVG(carbon_emissions_kg_co2e)
    - name: "Total Carbon Footprint Kg"
      expr: SUM(carbon_footprint_kg)
    - name: "Average Carbon Footprint Kg"
      expr: AVG(carbon_footprint_kg)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Emission Factor"
      expr: SUM(emission_factor)
    - name: "Average Emission Factor"
      expr: AVG(emission_factor)
    - name: "Total Energy Consumption Kwh"
      expr: SUM(energy_consumption_kwh)
    - name: "Average Energy Consumption Kwh"
      expr: AVG(energy_consumption_kwh)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Recycling Rate Pct"
      expr: SUM(recycling_rate_pct)
    - name: "Average Recycling Rate Pct"
      expr: AVG(recycling_rate_pct)
    - name: "Total Target Amount"
      expr: SUM(target_amount)
    - name: "Average Target Amount"
      expr: AVG(target_amount)
    - name: "Total Waste Generated Kg"
      expr: SUM(waste_generated_kg)
    - name: "Average Waste Generated Kg"
      expr: AVG(waste_generated_kg)
    - name: "Total Water Consumption Liters"
      expr: SUM(water_consumption_liters)
    - name: "Average Water Consumption Liters"
      expr: AVG(water_consumption_liters)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_waste_generation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waste Generation business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`waste_generation`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disposal Cost Currency Code"
      expr: disposal_cost_currency_code
    - name: "Disposal Method"
      expr: disposal_method
    - name: "Epa Reportable Flag"
      expr: epa_reportable_flag
    - name: "Hazardous Flag"
      expr: hazardous_flag
    - name: "Hazardous Waste Permit Number"
      expr: hazardous_waste_permit_number
    - name: "Is Recycled"
      expr: is_recycled
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Manifest Number"
      expr: manifest_number
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Notes"
      expr: notes
    - name: "Quantity Unit"
      expr: quantity_unit
    - name: "Regulatory Compliance Flag"
      expr: regulatory_compliance_flag
    - name: "Reporting Period"
      expr: reporting_period
    - name: "Reporting Period End"
      expr: reporting_period_end
    - name: "Reporting Period Start"
      expr: reporting_period_start
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Waste Generation"
      expr: COUNT(DISTINCT waste_generation_id)
    - name: "Total Disposal Cost Amount"
      expr: SUM(disposal_cost_amount)
    - name: "Average Disposal Cost Amount"
      expr: AVG(disposal_cost_amount)
    - name: "Total Diversion Rate Pct"
      expr: SUM(diversion_rate_pct)
    - name: "Average Diversion Rate Pct"
      expr: AVG(diversion_rate_pct)
    - name: "Total Diversion Rate Percent"
      expr: SUM(diversion_rate_percent)
    - name: "Average Diversion Rate Percent"
      expr: AVG(diversion_rate_percent)
    - name: "Total Recycled Amount Kg"
      expr: SUM(recycled_amount_kg)
    - name: "Average Recycled Amount Kg"
      expr: AVG(recycled_amount_kg)
    - name: "Total Recycling Rate Percentage"
      expr: SUM(recycling_rate_percentage)
    - name: "Average Recycling Rate Percentage"
      expr: AVG(recycling_rate_percentage)
    - name: "Total Waste Amount Kg"
      expr: SUM(waste_amount_kg)
    - name: "Average Waste Amount Kg"
      expr: AVG(waste_amount_kg)
    - name: "Total Waste Quantity"
      expr: SUM(waste_quantity)
    - name: "Average Waste Quantity"
      expr: AVG(waste_quantity)
    - name: "Total Waste Quantity Tonnes"
      expr: SUM(waste_quantity_tonnes)
    - name: "Average Waste Quantity Tonnes"
      expr: AVG(waste_quantity_tonnes)
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`sustainability_water_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water Consumption business metrics"
  source: "`vibe_consumer_goods_v1`.`sustainability`.`water_consumption`"
  dimensions:
    - name: "Comments"
      expr: comments
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Discharge Destination"
      expr: discharge_destination
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Is Recycled"
      expr: is_recycled
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Measurement Period End"
      expr: measurement_period_end
    - name: "Measurement Period Start"
      expr: measurement_period_start
    - name: "Measurement Unit"
      expr: measurement_unit
    - name: "Reading Date"
      expr: reading_date
    - name: "Recorded By"
      expr: recorded_by
    - name: "Regulatory Permit Reference"
      expr: regulatory_permit_reference
    - name: "Reporting Period"
      expr: reporting_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Water Consumption"
      expr: COUNT(DISTINCT water_consumption_id)
    - name: "Total Carbon Footprint Kg Co2e"
      expr: SUM(carbon_footprint_kg_co2e)
    - name: "Average Carbon Footprint Kg Co2e"
      expr: AVG(carbon_footprint_kg_co2e)
    - name: "Total Consumption Cubic Meters"
      expr: SUM(consumption_cubic_meters)
    - name: "Average Consumption Cubic Meters"
      expr: AVG(consumption_cubic_meters)
    - name: "Total Consumption Volume Cubic Meters"
      expr: SUM(consumption_volume_cubic_meters)
    - name: "Average Consumption Volume Cubic Meters"
      expr: AVG(consumption_volume_cubic_meters)
    - name: "Total Consumption Volume M3"
      expr: SUM(consumption_volume_m3)
    - name: "Average Consumption Volume M3"
      expr: AVG(consumption_volume_m3)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
    - name: "Total Discharge Cubic Meters"
      expr: SUM(discharge_cubic_meters)
    - name: "Average Discharge Cubic Meters"
      expr: AVG(discharge_cubic_meters)
    - name: "Total Discharge Volume Cubic Meters"
      expr: SUM(discharge_volume_cubic_meters)
    - name: "Average Discharge Volume Cubic Meters"
      expr: AVG(discharge_volume_cubic_meters)
    - name: "Total Discharge Volume M3"
      expr: SUM(discharge_volume_m3)
    - name: "Average Discharge Volume M3"
      expr: AVG(discharge_volume_m3)
    - name: "Total Recycled Percentage"
      expr: SUM(recycled_percentage)
    - name: "Average Recycled Percentage"
      expr: AVG(recycled_percentage)
    - name: "Total Recycled Water Volume Cubic Meters"
      expr: SUM(recycled_water_volume_cubic_meters)
    - name: "Average Recycled Water Volume Cubic Meters"
      expr: AVG(recycled_water_volume_cubic_meters)
    - name: "Total Water Intensity Per Unit"
      expr: SUM(water_intensity_per_unit)
    - name: "Average Water Intensity Per Unit"
      expr: AVG(water_intensity_per_unit)
    - name: "Total Water Recycling Rate Pct"
      expr: SUM(water_recycling_rate_pct)
    - name: "Average Water Recycling Rate Pct"
      expr: AVG(water_recycling_rate_pct)
$$;