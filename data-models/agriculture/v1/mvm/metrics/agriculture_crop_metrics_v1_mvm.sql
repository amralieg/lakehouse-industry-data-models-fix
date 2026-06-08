-- Metric views for domain: crop | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_harvest_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic harvest performance metrics tracking yield output, quality indicators, and harvest efficiency across fields and growing seasons. Used by operations and executive leadership to evaluate crop production outcomes."
  source: "`agriculture_ecm`.`crop`.`harvest_event`"
  dimensions:
    - name: "harvest_date"
      expr: harvest_date
      comment: "Date the harvest event occurred, used for time-series trending of harvest performance."
    - name: "harvest_method"
      expr: harvest_method
      comment: "Method used to harvest the crop (e.g., combine, hand-harvest), enabling comparison of efficiency across methods."
    - name: "crop_growth_stage"
      expr: crop_growth_stage
      comment: "Growth stage of the crop at time of harvest, used to assess harvest timing decisions."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the harvest event (e.g., completed, in-progress), used to filter active vs. closed events."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Indicates whether the harvested crop is organically certified, enabling premium market segmentation."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates whether the harvested crop is GMO, used for market channel and regulatory segmentation."
    - name: "mrl_compliant"
      expr: mrl_compliant
      comment: "Indicates whether the harvest event met Maximum Residue Level compliance requirements."
    - name: "phi_compliance_verified"
      expr: phi_compliance_verified
      comment: "Indicates whether Pre-Harvest Interval compliance was verified, critical for food safety governance."
  measures:
    - name: "total_harvested_area_acres"
      expr: SUM(CAST(harvested_area_acres AS DOUBLE))
      comment: "Total acres harvested across all events. Drives capacity planning and land utilization decisions."
    - name: "total_gross_weight_bu"
      expr: SUM(CAST(gross_weight_bu AS DOUBLE))
      comment: "Total gross production in bushels. Primary volume KPI for revenue forecasting and supply chain planning."
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross production in metric tons. Used for international trade and export planning."
    - name: "avg_yield_per_acre_bu"
      expr: ROUND(SUM(CAST(gross_weight_bu AS DOUBLE)) / NULLIF(SUM(CAST(harvested_area_acres AS DOUBLE)), 0), 2)
      comment: "Average bushels harvested per acre. Core agronomic productivity KPI used in executive reviews and benchmarking."
    - name: "avg_moisture_pct_at_harvest"
      expr: ROUND(AVG(CAST(moisture_pct_at_harvest AS DOUBLE)), 2)
      comment: "Average grain moisture percentage at harvest. Drives drying cost decisions and storage quality management."
    - name: "avg_harvest_loss_pct"
      expr: ROUND(AVG(CAST(harvest_loss_pct AS DOUBLE)), 2)
      comment: "Average percentage of crop lost during harvest operations. Directly tied to revenue leakage and equipment efficiency."
    - name: "avg_test_weight_lbs_per_bu"
      expr: ROUND(AVG(CAST(test_weight_lbs_per_bu AS DOUBLE)), 2)
      comment: "Average test weight in lbs per bushel. Key grain quality indicator affecting market price and buyer acceptance."
    - name: "avg_foreign_material_pct"
      expr: ROUND(AVG(CAST(foreign_material_pct AS DOUBLE)), 2)
      comment: "Average foreign material percentage in harvested grain. Quality KPI affecting grade, price dockage, and buyer compliance."
    - name: "avg_damaged_kernels_pct"
      expr: ROUND(AVG(CAST(damaged_kernels_pct AS DOUBLE)), 2)
      comment: "Average damaged kernel percentage. Quality defect KPI used to assess harvest timing and equipment calibration."
    - name: "avg_ndvi_at_harvest"
      expr: ROUND(AVG(CAST(ndvi_at_harvest AS DOUBLE)), 2)
      comment: "Average NDVI score at time of harvest. Remote sensing KPI used to correlate crop health with yield outcomes."
    - name: "harvest_event_count"
      expr: COUNT(1)
      comment: "Total number of harvest events recorded. Used as a baseline volume metric for operational throughput tracking."
    - name: "mrl_compliant_event_count"
      expr: COUNT(CASE WHEN mrl_compliant = TRUE THEN 1 END)
      comment: "Number of harvest events that passed MRL compliance. Regulatory KPI for food safety governance and market access."
    - name: "phi_verified_event_count"
      expr: COUNT(CASE WHEN phi_compliance_verified = TRUE THEN 1 END)
      comment: "Number of harvest events with verified Pre-Harvest Interval compliance. Critical food safety and regulatory KPI."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_yield_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Comprehensive yield performance and quality metrics derived from yield records. Enables executive-level analysis of production efficiency, yield variance against targets, and grain quality outcomes by field, season, and crop."
  source: "`agriculture_ecm`.`crop`.`yield_record`"
  dimensions:
    - name: "harvest_date"
      expr: harvest_date
      comment: "Date of harvest for time-series yield trend analysis."
    - name: "harvest_method"
      expr: harvest_method
      comment: "Harvest method used, enabling efficiency comparison across mechanized and manual approaches."
    - name: "harvest_status"
      expr: harvest_status
      comment: "Status of the yield record (e.g., finalized, pending), used to filter confirmed production data."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Organic certification flag enabling premium vs. conventional yield segmentation."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the harvested crop, used for market channel and regulatory segmentation."
    - name: "mrl_compliant"
      expr: mrl_compliant
      comment: "MRL compliance flag for food safety and market access analysis."
    - name: "phi_compliance_verified"
      expr: phi_compliance_verified
      comment: "Pre-Harvest Interval compliance verification flag for regulatory reporting."
  measures:
    - name: "total_production_bu"
      expr: SUM(CAST(total_production_bu AS DOUBLE))
      comment: "Total crop production in bushels. Primary volume KPI for revenue forecasting and supply chain commitments."
    - name: "total_production_mt"
      expr: SUM(CAST(total_production_mt AS DOUBLE))
      comment: "Total crop production in metric tons. Used for export planning and international market commitments."
    - name: "total_harvested_area_acres"
      expr: SUM(CAST(harvested_area_acres AS DOUBLE))
      comment: "Total harvested area in acres. Denominator for yield-per-acre calculations and land utilization analysis."
    - name: "avg_yield_per_acre"
      expr: ROUND(AVG(CAST(yield_per_acre AS DOUBLE)), 2)
      comment: "Average yield per acre across all yield records. Core agronomic productivity KPI for benchmarking and investment decisions."
    - name: "avg_yield_variance_bu_per_acre"
      expr: ROUND(AVG(CAST(yield_variance_bu_per_acre AS DOUBLE)), 2)
      comment: "Average variance between actual and target yield in bu/acre. Directly measures agronomic plan execution quality."
    - name: "total_moisture_adjusted_production_bu"
      expr: SUM(CAST(moisture_adjusted_production_bu AS DOUBLE))
      comment: "Total moisture-adjusted production in bushels. More accurate revenue basis than gross weight, accounting for drying shrink."
    - name: "avg_aph_yield_bu_per_acre"
      expr: ROUND(AVG(CAST(aph_yield_bu_per_acre AS DOUBLE)), 2)
      comment: "Average Actual Production History yield per acre. Used for crop insurance premium calculations and risk management."
    - name: "avg_harvest_loss_pct"
      expr: ROUND(AVG(CAST(harvest_loss_pct AS DOUBLE)), 2)
      comment: "Average harvest loss percentage. Operational efficiency KPI tied directly to revenue leakage."
    - name: "avg_moisture_pct_at_harvest"
      expr: ROUND(AVG(CAST(moisture_pct_at_harvest AS DOUBLE)), 2)
      comment: "Average moisture percentage at harvest. Drives drying cost and storage quality decisions."
    - name: "avg_test_weight_lbs_per_bu"
      expr: ROUND(AVG(CAST(test_weight_lbs_per_bu AS DOUBLE)), 2)
      comment: "Average test weight per bushel. Grain quality KPI affecting market price and buyer grade acceptance."
    - name: "avg_ndvi_at_harvest"
      expr: ROUND(AVG(CAST(ndvi_at_harvest AS DOUBLE)), 2)
      comment: "Average NDVI at harvest. Remote sensing health indicator correlated with yield outcomes for precision agriculture decisions."
    - name: "yield_target_achievement_rate"
      expr: ROUND(SUM(CAST(yield_per_acre AS DOUBLE)) / NULLIF(SUM(CAST(yield_target_bu_per_acre AS DOUBLE)), 0), 4)
      comment: "Ratio of actual yield to target yield per acre. Executive KPI measuring agronomic plan execution — values below 1.0 trigger investigation."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_growing_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Season-level production planning and performance metrics. Enables leadership to evaluate planned vs. actual area, yield targets, and season execution quality across crop years and farm operations."
  source: "`agriculture_ecm`.`crop`.`growing_season`"
  dimensions:
    - name: "crop_year"
      expr: crop_year
      comment: "Crop year (e.g., 2024), the primary time dimension for annual production planning and performance reviews."
    - name: "season_type"
      expr: season_type
      comment: "Type of growing season (e.g., spring, fall, double-crop), used to segment production by seasonal cycle."
    - name: "season_status"
      expr: season_status
      comment: "Current status of the growing season (e.g., active, completed), used to filter in-progress vs. finalized seasons."
    - name: "irrigation_method"
      expr: irrigation_method
      comment: "Irrigation method used during the season, enabling water management and cost efficiency analysis."
    - name: "planting_method"
      expr: planting_method
      comment: "Planting method used, enabling comparison of production outcomes across establishment approaches."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Organic certification flag for premium market segmentation and compliance reporting."
    - name: "is_gmo"
      expr: is_gmo
      comment: "GMO flag for market channel segmentation and regulatory reporting."
    - name: "fsma_compliance_flag"
      expr: fsma_compliance_flag
      comment: "FSMA compliance status for food safety regulatory reporting and audit readiness."
    - name: "gap_certification_status"
      expr: gap_certification_status
      comment: "Good Agricultural Practices certification status, used for buyer qualification and premium market access."
  measures:
    - name: "total_planned_area_acres"
      expr: SUM(CAST(total_planned_area_acres AS DOUBLE))
      comment: "Total planned production area in acres. Baseline for capacity planning and input procurement decisions."
    - name: "total_actual_area_acres"
      expr: SUM(CAST(total_actual_area_acres AS DOUBLE))
      comment: "Total actual planted area in acres. Compared against planned area to measure execution fidelity."
    - name: "area_execution_rate"
      expr: ROUND(SUM(CAST(total_actual_area_acres AS DOUBLE)) / NULLIF(SUM(CAST(total_planned_area_acres AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to planned area planted. Measures operational execution against the crop plan — deviations trigger agronomic review."
    - name: "total_yield_mt"
      expr: SUM(CAST(total_yield_mt AS DOUBLE))
      comment: "Total season yield in metric tons. Primary production volume KPI for revenue and supply chain planning."
    - name: "avg_actual_yield_bu_acre"
      expr: ROUND(AVG(CAST(actual_yield_bu_acre AS DOUBLE)), 2)
      comment: "Average actual yield in bushels per acre across seasons. Core productivity benchmark for executive performance reviews."
    - name: "avg_target_yield_bu_acre"
      expr: ROUND(AVG(CAST(target_yield_bu_acre AS DOUBLE)), 2)
      comment: "Average target yield in bushels per acre. Planning benchmark used to assess agronomic ambition and resource allocation."
    - name: "yield_target_achievement_rate"
      expr: ROUND(SUM(CAST(actual_yield_bu_acre AS DOUBLE)) / NULLIF(SUM(CAST(target_yield_bu_acre AS DOUBLE)), 0), 4)
      comment: "Season-level ratio of actual to target yield. Executive KPI for evaluating agronomic plan performance — below 0.9 triggers strategic review."
    - name: "avg_gdd_target"
      expr: ROUND(AVG(CAST(gdd_target AS DOUBLE)), 2)
      comment: "Average Growing Degree Day target across seasons. Used to assess climate suitability and variety selection decisions."
    - name: "growing_season_count"
      expr: COUNT(1)
      comment: "Total number of growing seasons recorded. Baseline volume metric for portfolio breadth and operational scale."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_fertilization_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nutrient management efficiency and compliance metrics for fertilization events. Enables agronomists and operations leaders to optimize input costs, track application accuracy, and ensure environmental compliance."
  source: "`agriculture_ecm`.`crop`.`fertilization_event`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date of fertilizer application, used for seasonal nutrient management trend analysis."
    - name: "application_method"
      expr: application_method
      comment: "Method of fertilizer application (e.g., broadcast, injection), used to compare efficiency and cost across approaches."
    - name: "application_type"
      expr: application_type
      comment: "Type of fertilizer application (e.g., pre-plant, side-dress, topdress), used for nutrient timing analysis."
    - name: "fertilizer_form"
      expr: fertilizer_form
      comment: "Physical form of fertilizer applied (e.g., liquid, granular), used for logistics and cost analysis."
    - name: "application_status"
      expr: application_status
      comment: "Status of the fertilization event (e.g., completed, planned), used to filter confirmed applications."
    - name: "is_organic"
      expr: is_organic
      comment: "Indicates whether organic-approved fertilizer was used, critical for organic certification compliance."
    - name: "is_vra_applied"
      expr: is_vra_applied
      comment: "Indicates whether Variable Rate Application technology was used, enabling precision agriculture ROI analysis."
    - name: "is_gmo_derived"
      expr: is_gmo_derived
      comment: "Indicates whether the fertilizer product is GMO-derived, used for organic and non-GMO compliance tracking."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions at time of application, used to assess application efficacy and runoff risk."
  measures:
    - name: "total_treated_area_acres"
      expr: SUM(CAST(treated_area_acres AS DOUBLE))
      comment: "Total area treated with fertilizer in acres. Baseline for input cost per acre calculations and coverage analysis."
    - name: "total_product_applied"
      expr: SUM(CAST(total_product_applied AS DOUBLE))
      comment: "Total volume of fertilizer product applied. Drives procurement planning and input cost management."
    - name: "total_nitrogen_applied_lbs_acre"
      expr: SUM(CAST(nitrogen_applied_lbs_acre AS DOUBLE))
      comment: "Total nitrogen applied in lbs per acre. Key nutrient management KPI for yield optimization and environmental compliance."
    - name: "avg_nitrogen_applied_lbs_acre"
      expr: ROUND(AVG(CAST(nitrogen_applied_lbs_acre AS DOUBLE)), 2)
      comment: "Average nitrogen application rate per acre. Benchmarked against agronomic recommendations to optimize yield and reduce over-application risk."
    - name: "avg_actual_rate"
      expr: ROUND(AVG(CAST(actual_rate AS DOUBLE)), 2)
      comment: "Average actual application rate. Compared against planned rate to measure application precision and equipment calibration quality."
    - name: "avg_planned_rate"
      expr: ROUND(AVG(CAST(planned_rate AS DOUBLE)), 2)
      comment: "Average planned application rate. Planning benchmark for nutrient management and input cost budgeting."
    - name: "application_rate_adherence"
      expr: ROUND(SUM(CAST(actual_rate AS DOUBLE)) / NULLIF(SUM(CAST(planned_rate AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to planned application rate. Measures equipment precision and operator compliance — deviations indicate calibration or training issues."
    - name: "avg_nitrogen_pct"
      expr: ROUND(AVG(CAST(nitrogen_pct AS DOUBLE)), 2)
      comment: "Average nitrogen content percentage of applied product. Used to validate product quality and nutrient delivery accuracy."
    - name: "avg_wind_speed_mph"
      expr: ROUND(AVG(CAST(wind_speed_mph AS DOUBLE)), 2)
      comment: "Average wind speed during application. Environmental compliance KPI — high wind speeds indicate drift risk and potential regulatory violations."
    - name: "fertilization_event_count"
      expr: COUNT(1)
      comment: "Total number of fertilization events. Operational throughput metric used to assess nutrient management program intensity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_protection_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crop protection application metrics covering pesticide usage, compliance, and IPM program effectiveness. Used by agronomists, compliance officers, and operations leaders to manage chemical input costs and regulatory risk."
  source: "`agriculture_ecm`.`crop`.`protection_event`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date of crop protection application, used for seasonal pest pressure and treatment timing analysis."
    - name: "application_method"
      expr: application_method
      comment: "Method of pesticide application (e.g., aerial, ground), used to compare cost and efficacy across delivery systems."
    - name: "application_type"
      expr: application_type
      comment: "Type of protection application (e.g., herbicide, fungicide, insecticide), used for input cost and efficacy segmentation."
    - name: "application_status"
      expr: application_status
      comment: "Status of the protection event (e.g., completed, planned), used to filter confirmed applications."
    - name: "target_pest"
      expr: target_pest
      comment: "Target pest or disease being controlled, used for IPM program effectiveness and resistance management analysis."
    - name: "active_ingredient"
      expr: active_ingredient
      comment: "Active ingredient of the applied product, used for resistance management and regulatory compliance tracking."
    - name: "ipm_justified"
      expr: ipm_justified
      comment: "Indicates whether the application was justified under an Integrated Pest Management program, used for IPM compliance reporting."
    - name: "phi_compliance_status"
      expr: phi_compliance_status
      comment: "Pre-Harvest Interval compliance status, critical food safety KPI for market access and regulatory reporting."
    - name: "rei_compliance_status"
      expr: rei_compliance_status
      comment: "Re-Entry Interval compliance status, critical worker safety KPI for regulatory and liability management."
    - name: "wind_direction"
      expr: wind_direction
      comment: "Wind direction at time of application, used for drift risk assessment and environmental compliance analysis."
  measures:
    - name: "total_area_treated_ha"
      expr: SUM(CAST(total_area_treated_ha AS DOUBLE))
      comment: "Total area treated with crop protection products in hectares. Baseline for input cost per hectare and coverage analysis."
    - name: "total_product_used"
      expr: SUM(CAST(total_product_used AS DOUBLE))
      comment: "Total volume of crop protection product used. Drives procurement planning and chemical input cost management."
    - name: "avg_application_rate"
      expr: ROUND(AVG(CAST(application_rate AS DOUBLE)), 2)
      comment: "Average application rate of crop protection products. Benchmarked against label recommendations to ensure efficacy and compliance."
    - name: "avg_water_volume_rate"
      expr: ROUND(AVG(CAST(water_volume_rate AS DOUBLE)), 2)
      comment: "Average water carrier volume rate. Operational efficiency KPI for spray equipment calibration and coverage quality."
    - name: "avg_wind_speed_mph"
      expr: ROUND(AVG(CAST(wind_speed_mph AS DOUBLE)), 2)
      comment: "Average wind speed during application. Environmental compliance KPI — high values indicate drift risk and potential off-target damage."
    - name: "avg_temperature_c"
      expr: ROUND(AVG(CAST(temperature_c AS DOUBLE)), 2)
      comment: "Average temperature during application. Efficacy and compliance KPI — extreme temperatures affect product performance and label compliance."
    - name: "avg_relative_humidity_pct"
      expr: ROUND(AVG(CAST(relative_humidity_pct AS DOUBLE)), 2)
      comment: "Average relative humidity during application. Affects spray efficacy and volatilization risk for certain active ingredients."
    - name: "avg_rei_hours_required"
      expr: ROUND(AVG(CAST(rei_hours_required AS DOUBLE)), 2)
      comment: "Average Re-Entry Interval hours required across protection events. Worker safety compliance KPI for labor scheduling and regulatory reporting."
    - name: "ipm_justified_event_count"
      expr: COUNT(CASE WHEN ipm_justified = TRUE THEN 1 END)
      comment: "Number of protection events justified under IPM protocols. Measures program discipline and chemical stewardship commitment."
    - name: "protection_event_count"
      expr: COUNT(1)
      comment: "Total number of crop protection events. Baseline intensity metric for chemical input program management."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_irrigation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water use efficiency and irrigation management metrics. Enables operations and sustainability leaders to optimize water allocation, reduce energy costs, and ensure best management practice compliance."
  source: "`agriculture_ecm`.`crop`.`irrigation_event`"
  dimensions:
    - name: "application_date"
      expr: application_date
      comment: "Date of irrigation application, used for seasonal water use trend analysis."
    - name: "irrigation_method"
      expr: irrigation_method
      comment: "Irrigation delivery method (e.g., drip, pivot, flood), used to compare water use efficiency across systems."
    - name: "event_status"
      expr: event_status
      comment: "Status of the irrigation event (e.g., completed, scheduled), used to filter confirmed applications."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Type of water source used (e.g., groundwater, surface water), used for water rights and sustainability reporting."
    - name: "water_source_name"
      expr: water_source_name
      comment: "Name of the specific water source, used for water allocation tracking and regulatory compliance."
    - name: "is_bmp_compliant"
      expr: is_bmp_compliant
      comment: "Indicates whether the irrigation event followed Best Management Practices, used for environmental compliance reporting."
    - name: "is_scheduled"
      expr: is_scheduled
      comment: "Indicates whether the event was scheduled vs. reactive, used to measure irrigation program planning discipline."
    - name: "crop_growth_stage"
      expr: crop_growth_stage
      comment: "Crop growth stage at time of irrigation, used to assess water application timing relative to crop demand."
  measures:
    - name: "total_volume_applied_acre_inches"
      expr: SUM(CAST(volume_applied_acre_inches AS DOUBLE))
      comment: "Total water applied in acre-inches. Primary water consumption KPI for water rights compliance and sustainability reporting."
    - name: "total_volume_applied_gallons"
      expr: SUM(CAST(volume_applied_gallons AS DOUBLE))
      comment: "Total water applied in gallons. Used for water cost allocation and utility billing reconciliation."
    - name: "total_water_cost_usd"
      expr: SUM(CAST(water_cost_usd AS DOUBLE))
      comment: "Total water cost in USD. Direct input cost KPI for irrigation budget management and cost-per-acre analysis."
    - name: "total_energy_cost_usd"
      expr: SUM(CAST(energy_cost_usd AS DOUBLE))
      comment: "Total energy cost for irrigation in USD. Operational cost KPI for pump efficiency and energy management decisions."
    - name: "avg_application_rate_inches_per_hour"
      expr: ROUND(AVG(CAST(application_rate_inches_per_hour AS DOUBLE)), 2)
      comment: "Average irrigation application rate in inches per hour. System efficiency KPI used to assess uniformity and equipment performance."
    - name: "avg_distribution_uniformity_pct"
      expr: ROUND(AVG(CAST(distribution_uniformity_pct AS DOUBLE)), 2)
      comment: "Average distribution uniformity percentage. Irrigation system efficiency KPI — low values indicate equipment issues causing uneven crop water stress."
    - name: "avg_flow_rate_gpm"
      expr: ROUND(AVG(CAST(flow_rate_gpm AS DOUBLE)), 2)
      comment: "Average flow rate in gallons per minute. Equipment performance KPI used to detect pump degradation and system inefficiencies."
    - name: "avg_soil_moisture_pct_before"
      expr: ROUND(AVG(CAST(soil_moisture_pct_before AS DOUBLE)), 2)
      comment: "Average soil moisture before irrigation. Used to assess irrigation trigger discipline and avoid over-watering."
    - name: "avg_soil_moisture_pct_after"
      expr: ROUND(AVG(CAST(soil_moisture_pct_after AS DOUBLE)), 2)
      comment: "Average soil moisture after irrigation. Used to validate application depth and field capacity achievement."
    - name: "avg_et_trigger_value_inches"
      expr: ROUND(AVG(CAST(et_trigger_value_inches AS DOUBLE)), 2)
      comment: "Average evapotranspiration trigger value in inches. Measures science-based irrigation scheduling discipline vs. calendar-based approaches."
    - name: "irrigation_event_count"
      expr: COUNT(1)
      comment: "Total number of irrigation events. Baseline intensity metric for water management program analysis."
    - name: "bmp_compliant_event_count"
      expr: COUNT(CASE WHEN is_bmp_compliant = TRUE THEN 1 END)
      comment: "Number of irrigation events meeting Best Management Practice standards. Environmental compliance KPI for regulatory reporting and program certification."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_loss_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crop loss risk and insurance indemnity metrics. Enables risk management, finance, and executive leadership to quantify production losses, evaluate insurance recovery rates, and prioritize loss mitigation investments."
  source: "`agriculture_ecm`.`crop`.`loss_event`"
  dimensions:
    - name: "loss_date"
      expr: loss_date
      comment: "Date the loss event occurred, used for seasonal and annual loss trend analysis."
    - name: "loss_cause"
      expr: loss_cause
      comment: "Primary cause of crop loss (e.g., drought, flood, pest, hail), used to prioritize risk mitigation investments."
    - name: "loss_severity"
      expr: loss_severity
      comment: "Severity classification of the loss event, used to triage response and insurance claim prioritization."
    - name: "event_status"
      expr: event_status
      comment: "Status of the loss event (e.g., reported, adjudicated, closed), used to track claim lifecycle."
    - name: "policy_coverage_type"
      expr: policy_coverage_type
      comment: "Type of crop insurance coverage applicable, used for insurance portfolio analysis and coverage gap identification."
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used to assess the loss (e.g., field inspection, remote sensing), used to evaluate assessment accuracy."
    - name: "replanting_recommended"
      expr: replanting_recommended
      comment: "Indicates whether replanting was recommended, used to assess recovery options and associated costs."
    - name: "prevented_planting_flag"
      expr: prevented_planting_flag
      comment: "Indicates whether planting was prevented due to the loss event, used for insurance prevented planting claim tracking."
    - name: "crop_growth_stage"
      expr: crop_growth_stage
      comment: "Crop growth stage at time of loss, used to assess economic impact severity relative to crop development."
  measures:
    - name: "total_affected_area_acres"
      expr: SUM(CAST(affected_area_acres AS DOUBLE))
      comment: "Total area affected by loss events in acres. Primary scale KPI for loss impact assessment and insurance claim sizing."
    - name: "total_estimated_indemnity_usd"
      expr: SUM(CAST(estimated_indemnity_usd AS DOUBLE))
      comment: "Total estimated insurance indemnity in USD. Financial risk KPI used for cash flow planning and insurance adequacy review."
    - name: "total_final_indemnity_usd"
      expr: SUM(CAST(final_indemnity_usd AS DOUBLE))
      comment: "Total final adjudicated indemnity in USD. Actual insurance recovery KPI used to evaluate coverage effectiveness and financial impact."
    - name: "avg_yield_loss_bu_acre"
      expr: ROUND(AVG(CAST(yield_loss_bu_acre AS DOUBLE)), 2)
      comment: "Average yield loss in bushels per acre. Agronomic impact KPI used to benchmark loss severity and prioritize prevention investments."
    - name: "avg_yield_loss_pct"
      expr: ROUND(AVG(CAST(yield_loss_pct AS DOUBLE)), 2)
      comment: "Average percentage yield loss per event. Normalized loss severity KPI enabling cross-field and cross-season comparison."
    - name: "avg_expected_yield_bu_acre"
      expr: ROUND(AVG(CAST(expected_yield_bu_acre AS DOUBLE)), 2)
      comment: "Average expected yield per acre at time of loss. Baseline for calculating economic impact and insurance indemnity accuracy."
    - name: "indemnity_recovery_rate"
      expr: ROUND(SUM(CAST(final_indemnity_usd AS DOUBLE)) / NULLIF(SUM(CAST(estimated_indemnity_usd AS DOUBLE)), 0), 4)
      comment: "Ratio of final to estimated indemnity. Insurance claim accuracy KPI — significant deviations indicate estimation methodology issues or adjuster disputes."
    - name: "avg_ndvi_at_loss"
      expr: ROUND(AVG(CAST(ndvi_at_loss AS DOUBLE)), 2)
      comment: "Average NDVI score at time of loss event. Remote sensing KPI used to validate loss extent and support insurance claim documentation."
    - name: "loss_event_count"
      expr: COUNT(1)
      comment: "Total number of loss events recorded. Baseline frequency KPI for risk exposure assessment and insurance program sizing."
    - name: "prevented_planting_event_count"
      expr: COUNT(CASE WHEN prevented_planting_flag = TRUE THEN 1 END)
      comment: "Number of events where planting was prevented. Insurance and risk KPI for prevented planting claim tracking and coverage adequacy review."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_planting_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planting execution and agronomic precision metrics. Enables operations and agronomy leadership to evaluate planting timeliness, seeding rate accuracy, and establishment quality as leading indicators of yield outcomes."
  source: "`agriculture_ecm`.`crop`.`planting_event`"
  dimensions:
    - name: "planting_date"
      expr: planting_date
      comment: "Date of planting, used for timeliness analysis and correlation with yield outcomes."
    - name: "planting_method"
      expr: planting_method
      comment: "Planting method used (e.g., no-till, conventional), used to compare establishment quality and input costs."
    - name: "event_status"
      expr: event_status
      comment: "Status of the planting event (e.g., completed, in-progress), used to filter confirmed plantings."
    - name: "is_gmo"
      expr: is_gmo
      comment: "GMO flag for market channel and regulatory segmentation."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Organic certification flag for premium market and compliance segmentation."
    - name: "gap_compliant"
      expr: gap_compliant
      comment: "Good Agricultural Practices compliance flag, used for buyer qualification and food safety audit readiness."
    - name: "seed_treatment"
      expr: seed_treatment
      comment: "Seed treatment applied, used to evaluate treatment efficacy and input cost analysis."
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions at planting, used to assess establishment risk and correlate with emergence outcomes."
    - name: "hybrid_code"
      expr: hybrid_code
      comment: "Hybrid or variety code planted, used for variety performance benchmarking and seed selection decisions."
  measures:
    - name: "total_area_planted_acres"
      expr: SUM(CAST(area_planted_acres AS DOUBLE))
      comment: "Total area planted in acres. Primary scale KPI for production capacity planning and input procurement."
    - name: "avg_seeding_rate_actual"
      expr: ROUND(AVG(CAST(seeding_rate_actual AS DOUBLE)), 2)
      comment: "Average actual seeding rate. Compared against prescribed rate to measure planting precision and seed cost efficiency."
    - name: "avg_seeding_rate_prescribed"
      expr: ROUND(AVG(CAST(seeding_rate_prescribed AS DOUBLE)), 2)
      comment: "Average prescribed seeding rate. Agronomic planning benchmark for seed cost budgeting and population optimization."
    - name: "seeding_rate_adherence"
      expr: ROUND(SUM(CAST(seeding_rate_actual AS DOUBLE)) / NULLIF(SUM(CAST(seeding_rate_prescribed AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to prescribed seeding rate. Planting precision KPI — deviations indicate equipment calibration issues or operator non-compliance."
    - name: "avg_planting_depth_cm"
      expr: ROUND(AVG(CAST(planting_depth_cm AS DOUBLE)), 2)
      comment: "Average planting depth in centimeters. Agronomic quality KPI — improper depth affects emergence uniformity and early-season yield potential."
    - name: "avg_row_spacing_cm"
      expr: ROUND(AVG(CAST(row_spacing_cm AS DOUBLE)), 2)
      comment: "Average row spacing in centimeters. Used to validate planting geometry compliance with agronomic recommendations."
    - name: "avg_soil_temperature_c"
      expr: ROUND(AVG(CAST(soil_temperature_c AS DOUBLE)), 2)
      comment: "Average soil temperature at planting in Celsius. Leading indicator of germination risk — values below threshold trigger delayed planting decisions."
    - name: "avg_soil_moisture_pct"
      expr: ROUND(AVG(CAST(soil_moisture_pct AS DOUBLE)), 2)
      comment: "Average soil moisture percentage at planting. Establishment risk KPI — extremes indicate planting condition quality and emergence risk."
    - name: "planting_event_count"
      expr: COUNT(1)
      comment: "Total number of planting events. Operational throughput metric for planting season execution tracking."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_scouting_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pest, disease, and crop health monitoring metrics derived from field scouting observations. Enables agronomists and operations leaders to prioritize intervention, track IPM program effectiveness, and manage crop protection spend."
  source: "`agriculture_ecm`.`crop`.`scouting_observation`"
  dimensions:
    - name: "observation_timestamp"
      expr: DATE(observation_timestamp)
      comment: "Date of scouting observation, used for pest pressure trend analysis and intervention timing."
    - name: "observation_category"
      expr: observation_category
      comment: "Category of observation (e.g., pest, disease, nutrient deficiency, weed), used to segment crop health issues by type."
    - name: "observation_method"
      expr: observation_method
      comment: "Method used for scouting (e.g., ground survey, drone imagery), used to assess data quality and coverage."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation (e.g., open, actioned, closed), used to track response to identified issues."
    - name: "pest_common_name"
      expr: pest_common_name
      comment: "Common name of the identified pest or disease, used for pest pressure mapping and treatment prioritization."
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the observed issue, used to triage intervention urgency and resource allocation."
    - name: "pressure_rating"
      expr: pressure_rating
      comment: "Pest or disease pressure rating, used for IPM threshold-based intervention decision making."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the observation, used to drive field response scheduling."
    - name: "anomaly_detected"
      expr: anomaly_detected
      comment: "Indicates whether an anomaly was detected during scouting, used to flag fields requiring immediate attention."
    - name: "vegetation_health_class"
      expr: vegetation_health_class
      comment: "Vegetation health classification from remote sensing or visual assessment, used for field health portfolio management."
    - name: "nutrient_deficiency_type"
      expr: nutrient_deficiency_type
      comment: "Type of nutrient deficiency observed, used to trigger corrective fertilization decisions."
  measures:
    - name: "total_scouted_area_ha"
      expr: SUM(CAST(scouted_area_ha AS DOUBLE))
      comment: "Total area scouted in hectares. Coverage KPI measuring the breadth of crop monitoring program relative to total planted area."
    - name: "avg_incidence_pct"
      expr: ROUND(AVG(CAST(incidence_pct AS DOUBLE)), 2)
      comment: "Average pest or disease incidence percentage. Core IPM KPI used to assess whether economic thresholds are exceeded and intervention is warranted."
    - name: "avg_weed_density_per_sqm"
      expr: ROUND(AVG(CAST(weed_density_per_sqm AS DOUBLE)), 2)
      comment: "Average weed density per square meter. Weed management KPI used to trigger herbicide applications and assess program effectiveness."
    - name: "avg_ndvi_value"
      expr: ROUND(AVG(CAST(ndvi_value AS DOUBLE)), 2)
      comment: "Average NDVI value from scouting observations. Crop health index used to identify stressed zones and prioritize agronomic interventions."
    - name: "avg_ndvi_baseline_delta"
      expr: ROUND(AVG(CAST(ndvi_baseline_delta AS DOUBLE)), 2)
      comment: "Average deviation of NDVI from baseline. Measures crop health deterioration trend — negative values trigger investigation and intervention."
    - name: "anomaly_detection_rate"
      expr: ROUND(COUNT(CASE WHEN anomaly_detected = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 4)
      comment: "Proportion of scouting observations where an anomaly was detected. Program sensitivity KPI — high rates indicate widespread crop stress requiring strategic response."
    - name: "anomaly_observation_count"
      expr: COUNT(CASE WHEN anomaly_detected = TRUE THEN 1 END)
      comment: "Total number of observations with detected anomalies. Absolute pest and disease pressure KPI for resource allocation and intervention planning."
    - name: "scouting_observation_count"
      expr: COUNT(1)
      comment: "Total number of scouting observations. Monitoring program intensity KPI used to assess field coverage and agronomist activity."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_cover_crop`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cover crop program performance and soil health metrics. Enables sustainability, agronomy, and compliance leaders to evaluate cover crop establishment quality, nitrogen credit generation, and BMP compliance for government program eligibility."
  source: "`agriculture_ecm`.`crop`.`cover_crop`"
  dimensions:
    - name: "planting_date"
      expr: planting_date
      comment: "Cover crop planting date, used for seasonal program timing analysis."
    - name: "termination_date"
      expr: termination_date
      comment: "Cover crop termination date, used to calculate days of soil coverage and program compliance."
    - name: "cover_crop_type"
      expr: cover_crop_type
      comment: "Type of cover crop planted (e.g., legume, grass, brassica), used to compare nitrogen credit and soil health outcomes by species."
    - name: "planting_method"
      expr: planting_method
      comment: "Method used to establish the cover crop (e.g., aerial seeding, drill), used to compare establishment success rates."
    - name: "termination_method"
      expr: termination_method
      comment: "Method used to terminate the cover crop (e.g., herbicide, tillage, roller-crimper), used for BMP and organic compliance analysis."
    - name: "planting_status"
      expr: planting_status
      comment: "Current status of the cover crop planting (e.g., established, terminated, failed), used to filter active program records."
    - name: "primary_goal"
      expr: primary_goal
      comment: "Primary agronomic goal of the cover crop (e.g., nitrogen fixation, erosion control, weed suppression), used for program effectiveness analysis."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Organic certification flag, used to track cover crop compliance within certified organic production systems."
    - name: "is_bmp_compliant"
      expr: is_bmp_compliant
      comment: "Best Management Practice compliance flag, used for government program eligibility and environmental compliance reporting."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "FSMA compliance flag for food safety regulatory reporting, particularly relevant for produce operations."
    - name: "establishment_rating"
      expr: establishment_rating
      comment: "Establishment quality rating of the cover crop stand, used to evaluate seeding success and program effectiveness."
  measures:
    - name: "total_planted_area_acres"
      expr: SUM(CAST(planted_area_acres AS DOUBLE))
      comment: "Total area planted to cover crops in acres. Primary program scale KPI for sustainability reporting and government program compliance."
    - name: "total_nitrogen_credit_lbs_acre"
      expr: SUM(CAST(nitrogen_credit_lbs_acre AS DOUBLE))
      comment: "Total nitrogen credit generated by cover crops in lbs per acre. Economic KPI measuring fertilizer cost offset from biological nitrogen fixation."
    - name: "avg_nitrogen_credit_lbs_acre"
      expr: ROUND(AVG(CAST(nitrogen_credit_lbs_acre AS DOUBLE)), 2)
      comment: "Average nitrogen credit per acre. Benchmarking KPI for cover crop species selection and program optimization decisions."
    - name: "avg_biomass_estimate_lbs_acre"
      expr: ROUND(AVG(CAST(biomass_estimate_lbs_acre AS DOUBLE)), 2)
      comment: "Average biomass produced by cover crops in lbs per acre. Soil organic matter and weed suppression effectiveness KPI."
    - name: "avg_soil_cover_pct"
      expr: ROUND(AVG(CAST(soil_cover_pct AS DOUBLE)), 2)
      comment: "Average soil surface coverage percentage. Erosion control effectiveness KPI — values below threshold indicate establishment failure or program gaps."
    - name: "avg_ndvi_at_termination"
      expr: ROUND(AVG(CAST(ndvi_at_termination AS DOUBLE)), 2)
      comment: "Average NDVI at cover crop termination. Remote sensing KPI measuring biomass and canopy density at termination — correlated with nitrogen credit and soil health outcomes."
    - name: "avg_seeding_rate_lbs_acre"
      expr: ROUND(AVG(CAST(seeding_rate_lbs_acre AS DOUBLE)), 2)
      comment: "Average actual seeding rate in lbs per acre. Compared against prescribed rate to measure program execution quality."
    - name: "seeding_rate_adherence"
      expr: ROUND(SUM(CAST(seeding_rate_lbs_acre AS DOUBLE)) / NULLIF(SUM(CAST(prescribed_seeding_rate_lbs_acre AS DOUBLE)), 0), 4)
      comment: "Ratio of actual to prescribed seeding rate. Program execution KPI — deviations indicate equipment calibration issues or operator non-compliance."
    - name: "bmp_compliant_area_acres"
      expr: SUM(CASE WHEN is_bmp_compliant = TRUE THEN CAST(planted_area_acres AS DOUBLE) ELSE 0 END)
      comment: "Total BMP-compliant cover crop area in acres. Government program eligibility KPI for USDA EQIP and CSP payment calculations."
    - name: "cover_crop_count"
      expr: COUNT(1)
      comment: "Total number of cover crop records. Program breadth metric used to assess adoption rate across the operation."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_field_crop_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crop planning quality and agronomic target metrics. Enables agronomy and operations leadership to evaluate planning completeness, nutrient management targets, and yield ambition across fields and seasons."
  source: "`agriculture_ecm`.`crop`.`field_crop_plan`"
  dimensions:
    - name: "plan_date"
      expr: plan_date
      comment: "Date the crop plan was created, used for planning cycle analysis and timeliness assessment."
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the field crop plan (e.g., draft, approved, active, closed), used to filter confirmed plans."
    - name: "tillage_method"
      expr: tillage_method
      comment: "Tillage method specified in the plan (e.g., no-till, strip-till, conventional), used for soil health and cost analysis."
    - name: "irrigation_system_type"
      expr: irrigation_system_type
      comment: "Type of irrigation system planned, used for water use efficiency and infrastructure investment analysis."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Organic certification flag for premium market planning and compliance segmentation."
    - name: "globalg_ap_certified"
      expr: globalg_ap_certified
      comment: "GlobalG.A.P. certification flag, used for premium buyer qualification and export market access planning."
    - name: "gmo_trait_used"
      expr: gmo_trait_used
      comment: "Indicates whether GMO traits are planned, used for market channel and regulatory compliance planning."
  measures:
    - name: "total_planned_area_acres"
      expr: SUM(CAST(planned_area_acres AS DOUBLE))
      comment: "Total planned production area in acres. Primary capacity planning KPI for input procurement and resource allocation."
    - name: "avg_yield_target_bu_acre"
      expr: ROUND(AVG(CAST(yield_target_bu_acre AS DOUBLE)), 2)
      comment: "Average yield target in bushels per acre. Agronomic ambition KPI used to assess planning quality and benchmark against actual outcomes."
    - name: "avg_yield_target_mt_hectare"
      expr: ROUND(AVG(CAST(yield_target_mt_hectare AS DOUBLE)), 2)
      comment: "Average yield target in metric tons per hectare. International benchmark KPI for global operations and export market planning."
    - name: "avg_target_n_rate_lbs_acre"
      expr: ROUND(AVG(CAST(target_n_rate_lbs_acre AS DOUBLE)), 2)
      comment: "Average planned nitrogen application rate in lbs per acre. Nutrient management planning KPI for input cost budgeting and environmental compliance."
    - name: "avg_target_p_rate_lbs_acre"
      expr: ROUND(AVG(CAST(target_p_rate_lbs_acre AS DOUBLE)), 2)
      comment: "Average planned phosphorus application rate in lbs per acre. Nutrient management planning KPI for soil fertility program design."
    - name: "avg_target_k_rate_lbs_acre"
      expr: ROUND(AVG(CAST(target_k_rate_lbs_acre AS DOUBLE)), 2)
      comment: "Average planned potassium application rate in lbs per acre. Nutrient management planning KPI for soil fertility program design."
    - name: "avg_water_allocation_limit_acre_ft"
      expr: ROUND(AVG(CAST(water_allocation_limit_acre_ft AS DOUBLE)), 2)
      comment: "Average water allocation limit in acre-feet per plan. Water rights compliance KPI for irrigation planning and regulatory reporting."
    - name: "avg_irrigation_target_depth_inches"
      expr: ROUND(AVG(CAST(irrigation_target_depth_inches AS DOUBLE)), 2)
      comment: "Average planned irrigation target depth in inches. Water management planning KPI for irrigation system design and scheduling."
    - name: "field_crop_plan_count"
      expr: COUNT(1)
      comment: "Total number of field crop plans. Planning program breadth metric used to assess operational planning coverage."
    - name: "approved_plan_count"
      expr: COUNT(CASE WHEN plan_status = 'approved' THEN 1 END)
      comment: "Number of approved field crop plans. Governance KPI measuring planning process compliance and approval rate."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`crop_seed_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seed quality, inventory, and procurement metrics. Enables agronomy and procurement leadership to manage seed quality standards, track germination performance, and optimize seed inventory and cost."
  source: "`agriculture_ecm`.`crop`.`seed_lot`"
  dimensions:
    - name: "receipt_date"
      expr: receipt_date
      comment: "Date seed lot was received, used for procurement cycle and seed availability analysis."
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the seed lot (e.g., available, depleted, quarantined), used to manage active inventory."
    - name: "certification_class"
      expr: certification_class
      comment: "Seed certification class (e.g., certified, foundation, registered), used for quality tier segmentation."
    - name: "seed_treatment_type"
      expr: seed_treatment_type
      comment: "Type of seed treatment applied (e.g., fungicide, insecticide, biological), used for input cost and efficacy analysis."
    - name: "is_gmo"
      expr: is_gmo
      comment: "GMO flag for market channel and regulatory compliance segmentation."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Organic certification flag for organic production system compliance."
    - name: "noxious_weed_free"
      expr: noxious_weed_free
      comment: "Indicates whether the seed lot is certified noxious weed free, critical for regulatory compliance and field contamination prevention."
    - name: "seed_origin_country"
      expr: seed_origin_country
      comment: "Country of seed origin, used for supply chain diversification and phytosanitary compliance analysis."
  measures:
    - name: "total_quantity_remaining"
      expr: SUM(CAST(quantity_remaining AS DOUBLE))
      comment: "Total seed quantity remaining in inventory. Inventory management KPI for planting season readiness and procurement gap identification."
    - name: "avg_germination_rate_pct"
      expr: ROUND(AVG(CAST(germination_rate_pct AS DOUBLE)), 2)
      comment: "Average germination rate percentage across seed lots. Primary seed quality KPI — values below threshold trigger lot rejection and emergency procurement."
    - name: "avg_purity_pct"
      expr: ROUND(AVG(CAST(purity_pct AS DOUBLE)), 2)
      comment: "Average seed purity percentage. Quality KPI measuring varietal integrity — low values indicate contamination risk affecting market channel compliance."
    - name: "avg_vigor_score"
      expr: ROUND(AVG(CAST(vigor_score AS DOUBLE)), 2)
      comment: "Average seed vigor score. Predictive quality KPI for emergence uniformity under stress conditions — drives variety selection decisions."
    - name: "avg_moisture_content_pct"
      expr: ROUND(AVG(CAST(moisture_content_pct AS DOUBLE)), 2)
      comment: "Average seed moisture content percentage. Storage quality KPI — high moisture indicates deterioration risk and potential germination loss."
    - name: "avg_unit_cost"
      expr: ROUND(AVG(CAST(unit_cost AS DOUBLE)), 2)
      comment: "Average cost per unit of seed. Procurement benchmarking KPI for vendor negotiation and input cost management."
    - name: "avg_seed_rate_per_acre"
      expr: ROUND(AVG(CAST(seed_rate_per_acre AS DOUBLE)), 2)
      comment: "Average recommended seeding rate per acre. Agronomic planning KPI used to calculate seed requirements and procurement quantities."
    - name: "avg_thousand_seed_weight_g"
      expr: ROUND(AVG(CAST(thousand_seed_weight_g AS DOUBLE)), 2)
      comment: "Average thousand seed weight in grams. Seed quality and calibration KPI used to convert seeding rates between weight and count units."
    - name: "seed_lot_count"
      expr: COUNT(1)
      comment: "Total number of seed lots in inventory. Supply diversity KPI for procurement risk management and variety portfolio analysis."
$$;