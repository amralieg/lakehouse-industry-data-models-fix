-- Metric views for domain: vehicle | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_vin_registry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core vehicle production and fleet metrics derived from the VIN registry — the authoritative record of every manufactured vehicle. Supports production volume tracking, EV fleet composition, warranty exposure, telematics adoption, and recall risk management."
  source: "`vibe_automotive_v1`.`vehicle`.`vin_registry`"
  dimensions:
    - name: "model_year"
      expr: model_year_decoded
      comment: "Decoded model year of the vehicle, used to slice production volumes and warranty exposure by model year cohort."
    - name: "destination_market"
      expr: destination_market
      comment: "Target market/region for the vehicle, enabling geographic segmentation of fleet composition and recall exposure."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code where the vehicle was built, used to assess plant-level output and quality."
    - name: "vehicle_lifecycle_status"
      expr: vehicle_lifecycle_status
      comment: "Current lifecycle status of the vehicle (e.g., in-production, sold, end-of-life), enabling active fleet segmentation."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emissions standard the vehicle is certified to (e.g., Euro 6, EPA Tier 3), critical for regulatory compliance reporting."
    - name: "obd_protocol"
      expr: obd_protocol
      comment: "OBD diagnostic protocol version, used to segment vehicles by diagnostic capability for service and recall planning."
    - name: "build_date_month"
      expr: DATE_TRUNC('MONTH', build_date)
      comment: "Month of vehicle build date, enabling monthly production trend analysis."
    - name: "warranty_end_date_year"
      expr: YEAR(warranty_end_date)
      comment: "Year the vehicle warranty expires, used to forecast warranty cost exposure by cohort."
  measures:
    - name: "total_vehicles_produced"
      expr: COUNT(1)
      comment: "Total number of vehicles in the VIN registry. Primary production volume KPI used in executive production dashboards and capacity planning."
    - name: "ev_vehicles_count"
      expr: COUNT(CASE WHEN battery_capacity_kwh > 0 THEN 1 END)
      comment: "Number of battery electric vehicles (BEV) identified by non-zero battery capacity. Tracks EV fleet growth as a strategic electrification KPI."
    - name: "ev_fleet_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN battery_capacity_kwh > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of total produced vehicles that are EVs. Key electrification strategy metric reported to board and regulators."
    - name: "telematics_enabled_count"
      expr: COUNT(CASE WHEN telematics_enabled_flag = TRUE THEN 1 END)
      comment: "Number of vehicles with telematics enabled. Drives connected services revenue forecasting and OTA deployment eligibility."
    - name: "telematics_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telematics_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vehicles with telematics enabled. Strategic KPI for connected vehicle monetization and OTA readiness."
    - name: "recall_flagged_vehicles_count"
      expr: COUNT(CASE WHEN recall_flag = TRUE THEN 1 END)
      comment: "Number of vehicles flagged for active recall. Critical safety and regulatory risk KPI monitored by quality and legal leadership."
    - name: "recall_exposure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of the fleet currently under recall. Drives recall campaign prioritization and regulatory reporting."
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kWh across EV fleet. Tracks product mix shift toward higher-range EVs over time."
    - name: "avg_curb_weight_kg"
      expr: AVG(CAST(curb_weight_kg AS DOUBLE))
      comment: "Average curb weight in kg across produced vehicles. Used in emissions compliance and fuel economy regulatory reporting."
    - name: "avg_epa_combined_mpg"
      expr: AVG(CAST(epa_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy across the fleet. Key regulatory compliance and product competitiveness metric."
    - name: "extended_warranty_active_count"
      expr: COUNT(CASE WHEN extended_warranty_active_flag = TRUE THEN 1 END)
      comment: "Number of vehicles with active extended warranty coverage. Drives aftersales revenue forecasting and warranty reserve planning."
    - name: "connected_diagnostics_enabled_count"
      expr: COUNT(CASE WHEN connected_diagnostics_enabled_flag = TRUE THEN 1 END)
      comment: "Number of vehicles with connected diagnostics enabled. Supports proactive maintenance service revenue and OBD-based service scheduling."
    - name: "self_service_portal_registered_count"
      expr: COUNT(CASE WHEN self_service_portal_registered_flag = TRUE THEN 1 END)
      comment: "Number of vehicles registered on the customer self-service portal. Tracks digital channel adoption and customer engagement."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_model_year_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program-level metrics for vehicle model year programs, tracking launch readiness, production ramp, and program portfolio health. Used by program management and executive leadership to steer product launch timelines."
  source: "`vibe_automotive_v1`.`vehicle`.`vehicle_model_year_program`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the program, enabling year-over-year program portfolio comparison."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the model year program (e.g., planning, active, closed), used to filter active vs. historical programs."
    - name: "market_regions"
      expr: market_regions
      comment: "Target market regions for the program, enabling regional program portfolio analysis."
    - name: "obd_compliance_standard"
      expr: obd_compliance_standard
      comment: "OBD compliance standard applicable to the program, used for regulatory readiness tracking."
    - name: "ota_deployment_strategy"
      expr: ota_deployment_strategy
      comment: "OTA software deployment strategy for the program, used to assess connected vehicle readiness by program."
    - name: "sop_year"
      expr: YEAR(sop_date)
      comment: "Year of start-of-production, used to group programs by production launch year."
    - name: "eop_year"
      expr: YEAR(eop_date)
      comment: "Year of end-of-production, used to identify programs approaching end-of-life."
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Total number of model year programs in the portfolio. Baseline KPI for program portfolio size and complexity management."
    - name: "active_programs_count"
      expr: COUNT(CASE WHEN program_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active model year programs. Drives resource allocation and program management capacity planning."
    - name: "programs_with_ota_strategy_count"
      expr: COUNT(CASE WHEN ota_deployment_strategy IS NOT NULL AND ota_deployment_strategy <> '' THEN 1 END)
      comment: "Number of programs with a defined OTA deployment strategy. Tracks connected vehicle program readiness as a strategic digitalization KPI."
    - name: "ota_strategy_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_deployment_strategy IS NOT NULL AND ota_deployment_strategy <> '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of model year programs with an OTA deployment strategy defined. Executive KPI for connected vehicle program readiness."
    - name: "avg_program_duration_days"
      expr: AVG(CAST(DATEDIFF(eop_date, sop_date) AS DOUBLE))
      comment: "Average duration in days between SOP and EOP across programs. Used to benchmark program lifecycle length and plan future program timelines."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_trim_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trim level portfolio metrics tracking pricing spread, active trim coverage, and connected services tier distribution. Used by product management and pricing teams to optimize the trim hierarchy and MSRP strategy."
  source: "`vibe_automotive_v1`.`vehicle`.`vehicle_trim_level`"
  dimensions:
    - name: "trim_tier"
      expr: trim_tier
      comment: "Tier classification of the trim level (e.g., base, mid, premium, sport), used to analyze portfolio balance across price tiers."
    - name: "connected_services_tier"
      expr: connected_services_tier
      comment: "Connected services tier bundled with the trim level, used to assess connected revenue potential by trim."
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the trim level is currently active in the product catalog, used to filter active vs. discontinued trims."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the trim level became effective, used to track trim portfolio evolution over time."
  measures:
    - name: "total_trim_levels"
      expr: COUNT(1)
      comment: "Total number of trim levels in the portfolio. Baseline KPI for product complexity and portfolio breadth management."
    - name: "active_trim_levels_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active trim levels. Used by product management to assess active catalog complexity."
    - name: "avg_base_msrp_usd"
      expr: AVG(CAST(base_msrp_usd AS DOUBLE))
      comment: "Average base MSRP in USD across all trim levels. Key pricing strategy metric for competitive positioning analysis."
    - name: "min_base_msrp_usd"
      expr: MIN(CAST(base_msrp_usd AS DOUBLE))
      comment: "Minimum base MSRP across trim levels. Identifies the entry price point for the model lineup, critical for market accessibility strategy."
    - name: "max_base_msrp_usd"
      expr: MAX(CAST(base_msrp_usd AS DOUBLE))
      comment: "Maximum base MSRP across trim levels. Identifies the top-of-range price point, used in premium segment positioning."
    - name: "msrp_price_spread_usd"
      expr: COUNT(1)
      comment: "Difference between highest and lowest trim MSRP. Measures the pricing breadth of the lineup — a wide spread indicates strong market segmentation coverage."
    - name: "trims_with_connected_services_count"
      expr: COUNT(CASE WHEN connected_services_tier IS NOT NULL AND connected_services_tier <> '' THEN 1 END)
      comment: "Number of trim levels bundled with connected services. Tracks connected vehicle monetization coverage across the trim portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_adas_feature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADAS feature deployment metrics tracking autonomy level distribution, OTA updatability, and regulatory approval status across vehicle configurations. Used by product safety, regulatory, and technology leadership."
  source: "`vibe_automotive_v1`.`vehicle`.`vehicle_adas_feature`"
  dimensions:
    - name: "adas_level"
      expr: adas_level
      comment: "ADAS capability level (e.g., L1, L2, L2+, L3), used to segment the fleet by autonomy capability."
    - name: "sae_autonomy_level"
      expr: sae_autonomy_level
      comment: "SAE J3016 autonomy level classification, the industry-standard taxonomy for autonomous driving capability reporting."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the ADAS feature, used to track compliance readiness for market launch."
    - name: "ota_updatable_flag"
      expr: CAST(ota_updatable_flag AS STRING)
      comment: "Whether the ADAS feature can be updated over-the-air, used to assess software-defined vehicle capability."
    - name: "is_standard"
      expr: CAST(is_standard AS STRING)
      comment: "Whether the ADAS feature is standard equipment (vs. optional), used to assess standard safety feature penetration."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the ADAS feature became effective on configurations, used to track ADAS technology adoption over time."
  measures:
    - name: "total_adas_feature_assignments"
      expr: COUNT(1)
      comment: "Total ADAS feature assignments across vehicle configurations. Baseline measure for ADAS portfolio breadth."
    - name: "ota_updatable_adas_count"
      expr: COUNT(CASE WHEN ota_updatable_flag = TRUE THEN 1 END)
      comment: "Number of ADAS features that are OTA-updatable. Strategic KPI for software-defined vehicle capability and post-sale feature enhancement revenue."
    - name: "ota_updatable_adas_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_updatable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADAS features that are OTA-updatable. Tracks progress toward software-defined vehicle architecture goals."
    - name: "standard_adas_feature_count"
      expr: COUNT(CASE WHEN is_standard = TRUE THEN 1 END)
      comment: "Number of ADAS features included as standard equipment. Measures safety feature democratization across the lineup."
    - name: "regulatory_approved_adas_count"
      expr: COUNT(CASE WHEN regulatory_approval_status = 'APPROVED' THEN 1 END)
      comment: "Number of ADAS features with confirmed regulatory approval. Critical compliance KPI for market launch readiness."
    - name: "regulatory_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_approval_status = 'APPROVED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of ADAS features with regulatory approval. Tracks compliance readiness for ADAS-equipped vehicle launches."
    - name: "distinct_configurations_with_adas"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Number of distinct vehicle configurations equipped with at least one ADAS feature. Measures ADAS penetration across the vehicle portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_emissions_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emissions certification compliance metrics tracking certification coverage, CO2 performance, and OTA recertification risk across vehicle configurations. Used by regulatory affairs, sustainability, and product compliance leadership."
  source: "`vibe_automotive_v1`.`vehicle`.`vehicle_emissions_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the emissions certification (e.g., certified, pending, expired), used to identify compliance gaps."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Emissions standard the certification applies to (e.g., Euro 6d, EPA Tier 3), used for regulatory framework segmentation."
    - name: "market_region"
      expr: market_region
      comment: "Market region for which the certification is valid, enabling regional compliance coverage analysis."
    - name: "certifying_authority"
      expr: certifying_authority
      comment: "Regulatory authority that issued the certification (e.g., EPA, CARB, EU Type Approval), used for authority-level compliance tracking."
    - name: "test_cycle"
      expr: test_cycle
      comment: "Test cycle used for certification (e.g., WLTP, FTP-75, NEDC), used to compare emissions performance across test methodologies."
    - name: "ota_recertification_required_flag"
      expr: CAST(ota_recertification_required_flag AS STRING)
      comment: "Whether an OTA update triggers recertification requirement, used to manage OTA deployment risk."
    - name: "certification_year"
      expr: YEAR(certification_date)
      comment: "Year of certification, used to track certification vintage and upcoming renewal cycles."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires, used to proactively manage renewal pipeline."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of emissions certifications on record. Baseline KPI for regulatory compliance portfolio size."
    - name: "active_certifications_count"
      expr: COUNT(CASE WHEN certification_status = 'CERTIFIED' THEN 1 END)
      comment: "Number of currently valid emissions certifications. Critical compliance KPI — gaps indicate vehicles that cannot be legally sold in target markets."
    - name: "certification_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN certification_status = 'CERTIFIED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications that are currently active/valid. Regulatory compliance health metric reported to compliance leadership."
    - name: "avg_co2_g_per_km"
      expr: AVG(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Average CO2 emissions in g/km across certified configurations. Key sustainability and regulatory compliance KPI (EU fleet average CO2 targets)."
    - name: "max_co2_g_per_km"
      expr: MAX(CAST(co2_emissions_g_per_km AS DOUBLE))
      comment: "Maximum CO2 emissions g/km across certified configurations. Identifies highest-emitting configurations for regulatory risk management."
    - name: "avg_nox_mg_per_km"
      expr: AVG(CAST(nox_mg_per_km AS DOUBLE))
      comment: "Average NOx emissions in mg/km. Critical air quality compliance metric, especially for Euro 6 and CARB LEV III standards."
    - name: "avg_particulate_mg_per_km"
      expr: AVG(CAST(particulate_mg_per_km AS DOUBLE))
      comment: "Average particulate matter emissions in mg/km. Regulatory compliance metric for Euro 6 and EPA particulate standards."
    - name: "ota_recertification_risk_count"
      expr: COUNT(CASE WHEN ota_recertification_required_flag = TRUE THEN 1 END)
      comment: "Number of certifications where OTA updates require recertification. Drives OTA deployment risk management and regulatory pre-approval planning."
    - name: "distinct_configurations_certified"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Number of distinct vehicle configurations with at least one emissions certification. Measures regulatory coverage breadth across the vehicle portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_ota_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OTA software deployment metrics tracking deployment success rates, rollback rates, payload volumes, and deployment velocity. Used by connected vehicle, software engineering, and product leadership to manage the software-defined vehicle lifecycle."
  source: "`vibe_automotive_v1`.`vehicle`.`vehicle_ota_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: vehicle_ota_deployment_status
      comment: "Current status of the OTA deployment (e.g., pending, in-progress, completed, failed, rolled-back), used to monitor deployment pipeline health."
    - name: "ecu_target"
      expr: ecu_target
      comment: "Target ECU for the OTA update, used to analyze deployment success rates by ECU type."
    - name: "rollback_flag"
      expr: CAST(rollback_flag AS STRING)
      comment: "Whether the deployment was rolled back, used to identify problematic software releases."
    - name: "consent_given"
      expr: CAST(consent_given AS STRING)
      comment: "Whether customer consent was obtained for the OTA update, used for GDPR/consent compliance monitoring."
    - name: "customer_self_service_initiated"
      expr: CAST(customer_self_service_initiated_flag AS STRING)
      comment: "Whether the deployment was initiated by the customer via self-service, used to track digital channel adoption."
    - name: "deployment_month"
      expr: DATE_TRUNC('MONTH', deployment_initiated_timestamp)
      comment: "Month the OTA deployment was initiated, used for monthly deployment volume and success rate trending."
  measures:
    - name: "total_ota_deployments"
      expr: COUNT(1)
      comment: "Total number of OTA deployment events. Baseline KPI for connected vehicle software update activity volume."
    - name: "successful_deployments_count"
      expr: COUNT(CASE WHEN vehicle_ota_deployment_status = 'COMPLETED' THEN 1 END)
      comment: "Number of successfully completed OTA deployments. Primary quality KPI for OTA release management."
    - name: "deployment_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vehicle_ota_deployment_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA deployments that completed successfully. Critical software quality KPI — low rates trigger release investigation and rollback decisions."
    - name: "rollback_count"
      expr: COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END)
      comment: "Number of OTA deployments that were rolled back. Safety and quality KPI — high rollback counts indicate software release quality issues."
    - name: "rollback_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rollback_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA deployments that required rollback. Executive KPI for software release quality — triggers release process review when elevated."
    - name: "total_payload_bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total OTA payload data transferred in bytes. Used for network capacity planning and bandwidth cost management."
    - name: "avg_payload_size_bytes"
      expr: AVG(CAST(payload_size_bytes AS DOUBLE))
      comment: "Average OTA update payload size in bytes. Tracks software package size trends, impacting deployment time and bandwidth costs."
    - name: "distinct_vehicles_updated"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles that received at least one OTA update. Measures connected fleet software currency and OTA program reach."
    - name: "consent_given_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_given = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OTA deployments where customer consent was obtained. Compliance KPI for GDPR and connected vehicle consent management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_option_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Option package portfolio metrics tracking active package availability, pricing, and connected service inclusion. Used by product management and pricing teams to optimize the option package strategy and connected revenue."
  source: "`vibe_automotive_v1`.`vehicle`.`vehicle_option_package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of option package (e.g., technology, safety, appearance, performance), used to analyze portfolio balance by package category."
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the option package is currently active, used to filter active vs. discontinued packages."
    - name: "is_available"
      expr: CAST(is_available AS STRING)
      comment: "Whether the option package is currently available for ordering, used to track availability gaps."
    - name: "connected_service_included_flag"
      expr: CAST(connected_service_included_flag AS STRING)
      comment: "Whether the package includes connected services, used to segment packages by connected revenue potential."
    - name: "ota_feature_unlock_flag"
      expr: CAST(ota_feature_unlock_flag AS STRING)
      comment: "Whether the package includes OTA-unlockable features, used to track software-defined vehicle monetization packages."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the option package became effective, used to track portfolio evolution over time."
  measures:
    - name: "total_option_packages"
      expr: COUNT(1)
      comment: "Total number of option packages in the portfolio. Baseline KPI for product complexity and configurability breadth."
    - name: "active_packages_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active option packages. Used by product management to assess active catalog complexity."
    - name: "avg_package_price_usd"
      expr: AVG(CAST(package_price_usd AS DOUBLE))
      comment: "Average option package price in USD. Key pricing metric for assessing option revenue potential and competitive positioning."
    - name: "total_package_revenue_potential_usd"
      expr: SUM(CAST(package_price_usd AS DOUBLE))
      comment: "Sum of all active option package prices. Proxy for maximum option revenue potential across the portfolio."
    - name: "connected_service_packages_count"
      expr: COUNT(CASE WHEN connected_service_included_flag = TRUE THEN 1 END)
      comment: "Number of packages that include connected services. Tracks connected vehicle revenue bundle coverage."
    - name: "ota_unlock_packages_count"
      expr: COUNT(CASE WHEN ota_feature_unlock_flag = TRUE THEN 1 END)
      comment: "Number of packages with OTA feature unlock capability. Strategic KPI for software-defined vehicle monetization — post-sale revenue through OTA feature activation."
    - name: "ota_unlock_package_share_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_feature_unlock_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of option packages with OTA feature unlock. Tracks progress toward software-defined vehicle business model adoption."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_msrp_pricing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MSRP pricing metrics tracking price levels, EV tax credit eligibility, destination charges, and pricing portfolio coverage. Used by pricing, finance, and product leadership for revenue planning and competitive pricing strategy."
  source: "`vibe_automotive_v1`.`vehicle`.`msrp_pricing`"
  dimensions:
    - name: "model_year"
      expr: model_year
      comment: "Model year of the priced vehicle, used to analyze pricing trends across model year cohorts."
    - name: "market_region"
      expr: market_region
      comment: "Market region for the pricing record, enabling regional pricing strategy analysis."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Country code for the pricing record, used for country-level pricing compliance and competitive analysis."
    - name: "trim_level"
      expr: trim_level
      comment: "Trim level associated with the pricing record, used to analyze MSRP distribution across the trim hierarchy."
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain type (e.g., ICE, BEV, PHEV, HEV), used to compare pricing across powertrain technologies."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pricing record, used for multi-currency pricing portfolio analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the pricing became effective, used to track pricing changes over time."
  measures:
    - name: "total_pricing_records"
      expr: COUNT(1)
      comment: "Total number of MSRP pricing records. Baseline KPI for pricing portfolio coverage."
    - name: "avg_msrp_price_usd"
      expr: AVG(CAST(price_amount AS DOUBLE))
      comment: "Average MSRP price across all pricing records. Key pricing strategy metric for competitive positioning and revenue forecasting."
    - name: "min_msrp_price_usd"
      expr: MIN(CAST(price_amount AS DOUBLE))
      comment: "Minimum MSRP price in the portfolio. Identifies the entry price point for market accessibility analysis."
    - name: "max_msrp_price_usd"
      expr: MAX(CAST(price_amount AS DOUBLE))
      comment: "Maximum MSRP price in the portfolio. Identifies the premium ceiling for luxury/performance segment positioning."
    - name: "total_destination_charges_usd"
      expr: SUM(CAST(destination_charge_amount AS DOUBLE))
      comment: "Total destination charges across all pricing records. Used in total vehicle cost analysis and consumer transparency reporting."
    - name: "avg_destination_charge_usd"
      expr: AVG(CAST(destination_charge_amount AS DOUBLE))
      comment: "Average destination charge in USD. Tracks logistics cost pass-through to consumers and competitive benchmarking."
    - name: "avg_ev_tax_credit_usd"
      expr: AVG(CAST(ev_tax_credit_amount AS DOUBLE))
      comment: "Average EV tax credit amount across eligible pricing records. Used to assess IRA/EV incentive impact on effective consumer price."
    - name: "avg_price_uplift_usd"
      expr: AVG(CAST(price_uplift_amount AS DOUBLE))
      comment: "Average price uplift amount applied to base MSRP. Tracks premium pricing adjustments for market demand and supply constraints."
    - name: "distinct_models_priced"
      expr: COUNT(DISTINCT model_id)
      comment: "Number of distinct vehicle models with active MSRP pricing. Measures pricing catalog completeness across the model portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership metrics tracking fleet composition, ownership types, connected services adoption, and ownership lifecycle. Used by sales, aftersales, and connected services leadership for customer retention and revenue planning."
  source: "`vibe_automotive_v1`.`vehicle`.`ownership`"
  dimensions:
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of ownership (e.g., retail, fleet, lease, CPO), used to segment the owner base by acquisition type."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the vehicle was acquired (e.g., dealer, online, fleet direct), used to track digital vs. traditional sales channel mix."
    - name: "is_current_owner"
      expr: CAST(is_current_owner AS STRING)
      comment: "Whether this is the current active owner, used to filter active ownership records."
    - name: "connected_services_active_flag"
      expr: CAST(connected_services_active_flag AS STRING)
      comment: "Whether connected services are active for this ownership, used to track connected services penetration."
    - name: "title_state"
      expr: title_state
      comment: "State where the vehicle title is registered, used for geographic ownership distribution analysis."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of vehicle acquisition, used to analyze ownership cohort trends and retention."
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Year of vehicle disposition, used to analyze ownership duration and churn patterns."
  measures:
    - name: "total_ownership_records"
      expr: COUNT(1)
      comment: "Total ownership records. Baseline KPI for fleet size and ownership history volume."
    - name: "current_owners_count"
      expr: COUNT(CASE WHEN is_current_owner = TRUE THEN 1 END)
      comment: "Number of active current vehicle owners. Drives aftersales targeting, connected services upsell, and warranty management."
    - name: "connected_services_active_count"
      expr: COUNT(CASE WHEN connected_services_active_flag = TRUE THEN 1 END)
      comment: "Number of ownership records with active connected services. Key connected vehicle revenue KPI."
    - name: "connected_services_penetration_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN connected_services_active_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_current_owner = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of current owners with active connected services. Strategic KPI for connected vehicle monetization and subscription revenue growth."
    - name: "self_service_portal_enrolled_count"
      expr: COUNT(CASE WHEN self_service_portal_enrolled_flag = TRUE THEN 1 END)
      comment: "Number of owners enrolled in the self-service portal. Tracks digital engagement and reduces dealer service call volume."
    - name: "distinct_vehicles_owned"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles with ownership records. Measures the breadth of the tracked fleet."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_homologation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Homologation compliance metrics tracking certification status, OTA regulatory approval, and renewal pipeline across vehicle configurations and markets. Used by regulatory affairs and compliance leadership to manage type approval risk."
  source: "`vibe_automotive_v1`.`vehicle`.`homologation`"
  dimensions:
    - name: "certification_status"
      expr: certification_status_date
      comment: "Date of the most recent certification status update, used to identify recently changed homologation records."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the homologation (e.g., active, expired, pending renewal), used to manage the compliance portfolio."
    - name: "approval_type"
      expr: approval_type
      comment: "Type of homologation approval (e.g., type approval, self-certification, COC), used to segment by regulatory framework."
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the homologation (e.g., UNECE, FMVSS, EU Directive), used for framework-level compliance tracking."
    - name: "authority_name"
      expr: authority_name
      comment: "Name of the regulatory authority that issued the homologation, used for authority-level compliance portfolio management."
    - name: "is_active"
      expr: CAST(is_active AS STRING)
      comment: "Whether the homologation is currently active, used to filter active vs. expired certifications."
    - name: "ota_regulatory_approval_flag"
      expr: CAST(ota_regulatory_approval_flag AS STRING)
      comment: "Whether OTA updates have regulatory approval under this homologation, used to manage OTA deployment compliance."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of homologation approval, used to track certification vintage and renewal cycles."
  measures:
    - name: "total_homologations"
      expr: COUNT(1)
      comment: "Total number of homologation records. Baseline KPI for regulatory compliance portfolio size."
    - name: "active_homologations_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active homologations. Critical compliance KPI — gaps mean vehicles cannot be legally sold in target markets."
    - name: "active_homologation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of homologations that are currently active. Regulatory compliance health metric reported to compliance and legal leadership."
    - name: "ota_approved_homologations_count"
      expr: COUNT(CASE WHEN ota_regulatory_approval_flag = TRUE THEN 1 END)
      comment: "Number of homologations with OTA regulatory approval. Enables OTA deployment planning without recertification risk."
    - name: "ota_approval_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ota_regulatory_approval_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of homologations with OTA regulatory approval. Strategic KPI for software-defined vehicle OTA deployment scalability."
    - name: "obd_compliance_verified_count"
      expr: COUNT(CASE WHEN obd_compliance_verified_flag = TRUE THEN 1 END)
      comment: "Number of homologations with verified OBD compliance. Regulatory requirement for vehicle diagnostics access in most markets."
    - name: "distinct_configurations_homologated"
      expr: COUNT(DISTINCT configuration_id)
      comment: "Number of distinct vehicle configurations with at least one homologation. Measures regulatory coverage breadth across the vehicle portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_campaign_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service campaign enrollment and remedy completion metrics tracking recall/campaign coverage, remedy costs, and completion rates. Used by quality, aftersales, and regulatory leadership to manage recall execution and cost."
  source: "`vibe_automotive_v1`.`vehicle`.`campaign_enrollment`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "Status of the campaign notification to the vehicle owner (e.g., sent, acknowledged, pending), used to track outreach effectiveness."
    - name: "warranty_covered"
      expr: CAST(warranty_covered AS STRING)
      comment: "Whether the campaign remedy is covered under warranty, used to segment warranty vs. out-of-warranty campaign costs."
    - name: "digital_notification_flag"
      expr: CAST(digital_notification_flag AS STRING)
      comment: "Whether the notification was sent digitally, used to track digital channel effectiveness for campaign outreach."
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_date)
      comment: "Month of campaign notification, used to track notification volume and completion rate trends over time."
    - name: "remedy_completion_month"
      expr: DATE_TRUNC('MONTH', remedy_completion_date)
      comment: "Month of remedy completion, used to track campaign closure velocity."
  measures:
    - name: "total_campaign_enrollments"
      expr: COUNT(1)
      comment: "Total number of vehicles enrolled in service campaigns. Baseline KPI for campaign scope and recall exposure."
    - name: "remedies_completed_count"
      expr: COUNT(CASE WHEN remedy_completion_date IS NOT NULL THEN 1 END)
      comment: "Number of campaign enrollments where the remedy has been completed. Primary recall completion KPI monitored by NHTSA/regulators."
    - name: "remedy_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remedy_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrolled vehicles where the remedy has been completed. Critical regulatory KPI — NHTSA monitors completion rates and can mandate escalation."
    - name: "total_remedy_cost_usd"
      expr: SUM(CAST(total_remedy_cost_usd AS DOUBLE))
      comment: "Total cost of all campaign remedies. Key financial KPI for recall reserve adequacy and warranty cost management."
    - name: "avg_remedy_cost_per_vehicle_usd"
      expr: AVG(CAST(total_remedy_cost_usd AS DOUBLE))
      comment: "Average remedy cost per enrolled vehicle. Used to forecast total recall liability and benchmark against reserve estimates."
    - name: "total_labor_cost_usd"
      expr: SUM(CAST(total_labor_cost_usd AS DOUBLE))
      comment: "Total labor cost across all campaign remedies. Used to manage dealer reimbursement budgets and labor capacity planning."
    - name: "total_parts_cost_usd"
      expr: SUM(CAST(total_parts_cost_usd AS DOUBLE))
      comment: "Total parts cost across all campaign remedies. Used for parts procurement planning and recall cost reserve management."
    - name: "avg_labor_time_hours"
      expr: AVG(CAST(labor_time_hours AS DOUBLE))
      comment: "Average labor time in hours per campaign remedy. Used for dealer capacity planning and labor time standard validation."
    - name: "digital_notification_count"
      expr: COUNT(CASE WHEN digital_notification_flag = TRUE THEN 1 END)
      comment: "Number of campaign notifications sent via digital channels. Tracks digital outreach effectiveness and cost efficiency vs. physical mail."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_lifecycle_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle lifecycle event metrics tracking event volumes, OBD-triggered events, OTA-related events, and critical event rates. Used by connected vehicle, quality, and aftersales leadership to monitor fleet health and proactive service triggers."
  source: "`vibe_automotive_v1`.`vehicle`.`lifecycle_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of lifecycle event (e.g., sale, service, recall, OTA update, end-of-life), used to analyze event distribution across the vehicle lifecycle."
    - name: "event_subtype"
      expr: event_subtype
      comment: "Sub-classification of the lifecycle event, enabling granular event analysis within each event type."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the lifecycle event (e.g., open, closed, pending), used to identify unresolved events."
    - name: "event_source_system"
      expr: event_source_system
      comment: "Source system that generated the event (e.g., DMS, telematics, OBD, OTA platform), used for data lineage and system health monitoring."
    - name: "is_critical"
      expr: CAST(is_critical AS STRING)
      comment: "Whether the event is classified as critical, used to prioritize response and escalation."
    - name: "obd_triggered_flag"
      expr: CAST(obd_triggered_flag AS STRING)
      comment: "Whether the event was triggered by an OBD diagnostic reading, used to track proactive maintenance trigger rates."
    - name: "ota_related_flag"
      expr: CAST(ota_related_flag AS STRING)
      comment: "Whether the event is related to an OTA update, used to correlate OTA deployments with downstream lifecycle events."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the lifecycle event, used for monthly event volume trending and seasonality analysis."
    - name: "event_location_country"
      expr: event_location_country
      comment: "Country where the lifecycle event occurred, used for geographic event distribution analysis."
  measures:
    - name: "total_lifecycle_events"
      expr: COUNT(1)
      comment: "Total number of vehicle lifecycle events. Baseline KPI for fleet activity volume and event management workload."
    - name: "critical_events_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical lifecycle events. Safety and quality KPI — high counts trigger immediate investigation and escalation."
    - name: "critical_event_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events classified as critical. Fleet health KPI used by quality and safety leadership."
    - name: "obd_triggered_events_count"
      expr: COUNT(CASE WHEN obd_triggered_flag = TRUE THEN 1 END)
      comment: "Number of events triggered by OBD diagnostics. Measures proactive maintenance trigger volume from connected vehicle diagnostics."
    - name: "obd_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN obd_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lifecycle events triggered by OBD diagnostics. Tracks connected vehicle proactive service capability utilization."
    - name: "ota_related_events_count"
      expr: COUNT(CASE WHEN ota_related_flag = TRUE THEN 1 END)
      comment: "Number of lifecycle events related to OTA updates. Used to assess OTA deployment impact on vehicle lifecycle activity."
    - name: "distinct_vehicles_with_events"
      expr: COUNT(DISTINCT vin_registry_id)
      comment: "Number of distinct vehicles with at least one lifecycle event. Measures active fleet engagement and event coverage breadth."
    - name: "avg_odometer_at_event_km"
      expr: AVG(CAST(odometer_reading_km AS DOUBLE))
      comment: "Average odometer reading at the time of lifecycle events. Used to benchmark event occurrence by vehicle mileage for predictive maintenance modeling."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_powertrain_variant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Powertrain variant portfolio metrics tracking fuel economy performance, EV range, CO2 emissions, and electrification mix. Used by product engineering, sustainability, and regulatory leadership to manage powertrain strategy."
  source: "`vibe_automotive_v1`.`vehicle`.`powertrain_variant`"
  dimensions:
    - name: "powertrain_type"
      expr: powertrain_type
      comment: "Powertrain technology type (e.g., ICE, BEV, PHEV, HEV, FCEV), used to analyze portfolio electrification mix."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type (e.g., gasoline, diesel, electric, hydrogen), used for regulatory compliance and sustainability reporting."
    - name: "drive_type"
      expr: drive_type
      comment: "Drive configuration (e.g., FWD, RWD, AWD, 4WD), used to analyze drivetrain portfolio balance."
    - name: "transmission_type"
      expr: transmission_type
      comment: "Transmission type (e.g., automatic, manual, CVT, DCT), used for product mix analysis."
    - name: "powertrain_variant_status"
      expr: powertrain_variant_status
      comment: "Current status of the powertrain variant (e.g., active, discontinued, planned), used to filter active vs. historical variants."
    - name: "subscription_available_flag"
      expr: CAST(subscription_available_flag AS STRING)
      comment: "Whether a subscription service is available for this powertrain variant, used to track vehicle-as-a-service portfolio coverage."
    - name: "model_year"
      expr: model_year
      comment: "Model year of the powertrain variant, used for year-over-year powertrain performance comparison."
  measures:
    - name: "total_powertrain_variants"
      expr: COUNT(1)
      comment: "Total number of powertrain variants in the portfolio. Baseline KPI for powertrain complexity and engineering investment scope."
    - name: "avg_combined_system_power_kw"
      expr: AVG(CAST(combined_system_power_kw AS DOUBLE))
      comment: "Average combined system power in kW across powertrain variants. Tracks product performance positioning and electrification power trends."
    - name: "avg_battery_capacity_kwh"
      expr: AVG(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Average battery capacity in kWh across electrified powertrain variants. Tracks EV range capability evolution across the portfolio."
    - name: "avg_epa_fuel_economy_combined_mpg"
      expr: AVG(CAST(epa_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average EPA combined fuel economy in MPG. Key regulatory compliance metric for CAFE standards and consumer fuel cost communication."
    - name: "avg_wltp_fuel_economy_combined_mpg"
      expr: AVG(CAST(wltp_fuel_economy_combined_mpg AS DOUBLE))
      comment: "Average WLTP combined fuel economy in MPG. European regulatory compliance metric for fleet CO2 average calculations."
    - name: "avg_electric_motor_power_kw"
      expr: AVG(CAST(electric_motor_power_kw AS DOUBLE))
      comment: "Average electric motor power in kW across electrified variants. Tracks electrification performance capability across the portfolio."
    - name: "subscription_eligible_variants_count"
      expr: COUNT(CASE WHEN subscription_available_flag = TRUE THEN 1 END)
      comment: "Number of powertrain variants with subscription service availability. Tracks vehicle-as-a-service portfolio coverage for mobility business model."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_regulatory_compliance_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance assignment metrics tracking compliance status, OTA impact assessments, and review currency across vehicle models and markets. Used by regulatory affairs and compliance leadership to manage regulatory risk."
  source: "`vibe_automotive_v1`.`vehicle`.`regulatory_compliance_assignment`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., compliant, non-compliant, under-review, pending), used to identify compliance gaps requiring action."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Category of regulatory compliance (e.g., emissions, safety, cybersecurity, OBD), used to analyze compliance portfolio by regulatory domain."
    - name: "market_region"
      expr: market_region
      comment: "Market region for the compliance assignment, enabling regional regulatory compliance gap analysis."
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify compliance (e.g., test, audit, self-declaration), used to assess compliance evidence quality."
    - name: "obd_compliance_category"
      expr: obd_compliance_category
      comment: "OBD-specific compliance category, used to track OBD regulatory compliance separately from other compliance types."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the compliance assignment became effective, used to track regulatory compliance portfolio evolution."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the compliance assignment expires, used to proactively manage renewal pipeline."
  measures:
    - name: "total_compliance_assignments"
      expr: COUNT(1)
      comment: "Total number of regulatory compliance assignments. Baseline KPI for regulatory compliance portfolio scope."
    - name: "compliant_assignments_count"
      expr: COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END)
      comment: "Number of compliance assignments with confirmed compliant status. Primary regulatory health KPI."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'COMPLIANT' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of regulatory compliance assignments that are compliant. Executive KPI for regulatory risk — non-compliance can result in market withdrawal or fines."
    - name: "non_compliant_assignments_count"
      expr: COUNT(CASE WHEN compliance_status = 'NON_COMPLIANT' THEN 1 END)
      comment: "Number of non-compliant regulatory assignments. Critical risk KPI requiring immediate remediation action."
    - name: "distinct_models_with_compliance_assignments"
      expr: COUNT(DISTINCT model_id)
      comment: "Number of distinct vehicle models with regulatory compliance assignments. Measures compliance coverage breadth across the model portfolio."
    - name: "distinct_requirements_assigned"
      expr: COUNT(DISTINCT regulatory_requirement_id)
      comment: "Number of distinct regulatory requirements tracked across the vehicle portfolio. Measures regulatory complexity and compliance management scope."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_build_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production build metrics for vehicles."
  source: "`vibe_automotive_v1`.`vehicle`.`build_spec`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant code."
    - name: "production_line"
      expr: production_line
      comment: "Production line identifier."
    - name: "build_month"
      expr: DATE_TRUNC('month', build_date)
      comment: "Build month."
    - name: "configuration_id"
      expr: configuration_id
      comment: "Configuration identifier."
  measures:
    - name: "total_builds"
      expr: COUNT(1)
      comment: "Total number of vehicle builds."
    - name: "avg_fuel_efficiency_mpg"
      expr: AVG(CAST(fuel_efficiency_mpg AS DOUBLE))
      comment: "Average fuel efficiency (mpg) across builds."
    - name: "avg_vehicle_weight_kg"
      expr: AVG(CAST(vehicle_weight_kg AS DOUBLE))
      comment: "Average vehicle weight (kg)."
    - name: "special_order_count"
      expr: SUM(CASE WHEN special_order_flag THEN 1 ELSE 0 END)
      comment: "Count of special order builds."
    - name: "ota_updatable_count"
      expr: SUM(CASE WHEN ota_updatable_flag THEN 1 ELSE 0 END)
      comment: "Count of builds with OTA updatable capability."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`vehicle_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Configuration pricing and feature metrics."
  source: "`vibe_automotive_v1`.`vehicle`.`configuration`"
  dimensions:
    - name: "model_id"
      expr: model_id
      comment: "Model identifier."
    - name: "platform_id"
      expr: platform_id
      comment: "Platform identifier."
    - name: "body_style"
      expr: body_style
      comment: "Body style."
    - name: "drivetrain"
      expr: drivetrain
      comment: "Drivetrain type."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type."
    - name: "market_region"
      expr: market_region
      comment: "Market region."
    - name: "market_country_code"
      expr: market_country_code
      comment: "Market country code."
    - name: "production_start_month"
      expr: DATE_TRUNC('month', start_of_production_date)
      comment: "Start of production month."
  measures:
    - name: "configuration_count"
      expr: COUNT(1)
      comment: "Number of configurations."
    - name: "avg_total_price"
      expr: AVG(CAST(total_price AS DOUBLE))
      comment: "Average total price of configuration."
    - name: "avg_msrp_amount"
      expr: AVG(CAST(msrp_amount AS DOUBLE))
      comment: "Average MSRP amount."
    - name: "avg_destination_charge"
      expr: AVG(CAST(destination_charge AS DOUBLE))
      comment: "Average destination charge."
    - name: "avg_optional_package_price"
      expr: AVG(total_price - msrp_amount - destination_charge)
      comment: "Average price contribution of optional packages."
$$;