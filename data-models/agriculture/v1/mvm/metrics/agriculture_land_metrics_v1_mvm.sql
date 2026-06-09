-- Metric views for domain: land | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_farm_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for farm operations — tracks total cultivated acreage, organic certification adoption, precision agriculture enablement, and operational scale across the farm portfolio. Used by leadership to assess land utilization, sustainability posture, and technology adoption."
  source: "`agriculture_ecm`.`land`.`farm_operation`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of farm operation (e.g., row crop, livestock, mixed) — used to segment KPIs by operational model."
    - name: "operation_status"
      expr: operation_status
      comment: "Current operational status of the farm (e.g., active, inactive, suspended) — filters for active portfolio analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure (e.g., owned, leased, partnership) — informs land tenure risk and investment decisions."
    - name: "state_code"
      expr: state_code
      comment: "US state where the farm operation is located — enables geographic performance benchmarking."
    - name: "country_code"
      expr: country_code
      comment: "Country of the farm operation — supports global portfolio segmentation."
    - name: "irrigation_system_type"
      expr: irrigation_system_type
      comment: "Type of irrigation system deployed — used to assess water efficiency and infrastructure investment."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Whether the farm operation holds organic certification (True/False) — key sustainability and premium market indicator."
    - name: "precision_agriculture_enabled"
      expr: precision_agriculture_enabled
      comment: "Whether precision agriculture technology is enabled (True/False) — tracks digital transformation adoption."
    - name: "legal_entity_type"
      expr: legal_entity_type
      comment: "Legal structure of the farm entity (e.g., LLC, sole proprietor, corporation) — relevant for compliance and credit risk."
    - name: "conservation_plan_status"
      expr: conservation_plan_status
      comment: "Status of the farm's conservation plan — used to monitor regulatory compliance and USDA program eligibility."
  measures:
    - name: "total_farm_operations"
      expr: COUNT(1)
      comment: "Total number of farm operations in the portfolio — baseline KPI for portfolio scale and coverage."
    - name: "total_cultivated_acreage"
      expr: SUM(CAST(cultivated_acreage AS DOUBLE))
      comment: "Total cultivated acres across all farm operations — primary measure of productive land under management."
    - name: "total_acreage_under_management"
      expr: SUM(CAST(total_acreage AS DOUBLE))
      comment: "Total deeded or managed acreage across all farm operations — measures overall land portfolio size."
    - name: "avg_cultivated_acreage_per_operation"
      expr: AVG(CAST(cultivated_acreage AS DOUBLE))
      comment: "Average cultivated acreage per farm operation — benchmarks operational scale and efficiency."
    - name: "cultivation_intensity_pct"
      expr: ROUND(100.0 * SUM(CAST(cultivated_acreage AS DOUBLE)) / NULLIF(SUM(CAST(total_acreage AS DOUBLE)), 0), 2)
      comment: "Percentage of total managed acreage that is actively cultivated — measures land utilization efficiency. Low values indicate underutilized land assets."
    - name: "organic_certified_operations_count"
      expr: COUNT(CASE WHEN organic_certified = TRUE THEN 1 END)
      comment: "Number of farm operations with active organic certification — tracks premium market eligibility and sustainability program reach."
    - name: "precision_ag_enabled_operations_count"
      expr: COUNT(CASE WHEN precision_agriculture_enabled = TRUE THEN 1 END)
      comment: "Number of farm operations with precision agriculture technology enabled — measures digital transformation adoption across the portfolio."
    - name: "rtk_gps_enabled_operations_count"
      expr: COUNT(CASE WHEN rtk_gps_enabled = TRUE THEN 1 END)
      comment: "Number of farm operations with RTK GPS enabled — indicates high-precision field guidance adoption, a leading indicator of yield optimization capability."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_field`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Field-level KPIs covering total area, irrigation coverage, NDVI vegetation health, and lease economics. Used by agronomists, land managers, and executives to assess field productivity, irrigation investment, and land cost efficiency."
  source: "`agriculture_ecm`.`land`.`field`"
  dimensions:
    - name: "field_status"
      expr: field_status
      comment: "Current operational status of the field (e.g., active, fallow, retired) — filters for productive field analysis."
    - name: "field_type"
      expr: field_type
      comment: "Classification of the field (e.g., row crop, pasture, orchard) — enables segmentation by production type."
    - name: "land_use_code"
      expr: land_use_code
      comment: "Land use designation code — used for regulatory reporting and land classification analysis."
    - name: "irrigation_system_type"
      expr: irrigation_system_type
      comment: "Type of irrigation system on the field — used to assess water infrastructure investment and efficiency."
    - name: "soil_texture_class"
      expr: soil_texture_class
      comment: "Soil texture classification (e.g., clay, loam, sandy) — key agronomic dimension for yield and input optimization."
    - name: "drainage_class"
      expr: drainage_class
      comment: "Soil drainage classification — informs water management decisions and flood risk assessment."
    - name: "state_province_code"
      expr: state_province_code
      comment: "State or province where the field is located — enables geographic performance benchmarking."
    - name: "county_name"
      expr: county_name
      comment: "County where the field is located — supports local regulatory and agronomic analysis."
    - name: "gmo_restricted"
      expr: gmo_restricted
      comment: "Whether the field has GMO restrictions (True/False) — critical for seed selection and compliance management."
    - name: "lease_type"
      expr: lease_type
      comment: "Type of land lease arrangement (e.g., cash rent, crop share) — informs land cost structure analysis."
  measures:
    - name: "total_fields"
      expr: COUNT(1)
      comment: "Total number of fields in the portfolio — baseline measure of field asset count."
    - name: "total_area_hectares"
      expr: SUM(CAST(total_area_ha AS DOUBLE))
      comment: "Total field area in hectares across all fields — primary measure of productive land area under management."
    - name: "total_irrigated_area_hectares"
      expr: SUM(CAST(irrigated_area_ha AS DOUBLE))
      comment: "Total irrigated area in hectares — measures the scale of irrigation infrastructure investment."
    - name: "irrigation_coverage_pct"
      expr: ROUND(100.0 * SUM(CAST(irrigated_area_ha AS DOUBLE)) / NULLIF(SUM(CAST(total_area_ha AS DOUBLE)), 0), 2)
      comment: "Percentage of total field area that is irrigated — key efficiency ratio for water resource management and yield potential assessment."
    - name: "avg_ndvi_score"
      expr: AVG(CAST(ndvi_last_score AS DOUBLE))
      comment: "Average NDVI (Normalized Difference Vegetation Index) score across fields — leading indicator of crop health and biomass; used to identify underperforming fields requiring intervention."
    - name: "avg_lease_rate_per_ha"
      expr: AVG(CAST(lease_rate_per_ha AS DOUBLE))
      comment: "Average lease rate per hectare — benchmarks land cost efficiency and informs lease negotiation strategy."
    - name: "total_lease_cost_exposure"
      expr: SUM(CAST(lease_rate_per_ha AS DOUBLE) * CAST(total_area_ha AS DOUBLE))
      comment: "Estimated total annual lease cost exposure (rate × area) across all fields — critical for land cost budgeting and P&L forecasting."
    - name: "avg_slope_percent"
      expr: AVG(CAST(slope_percent AS DOUBLE))
      comment: "Average field slope percentage — informs erosion risk assessment, drainage planning, and equipment suitability decisions."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_parcel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Parcel-level land asset KPIs covering acquisition cost, assessed value, property tax burden, irrigated acreage, and FSA cropland. Used by land managers and CFOs to evaluate land portfolio value, tax efficiency, and productive land classification."
  source: "`agriculture_ecm`.`land`.`parcel`"
  dimensions:
    - name: "parcel_status"
      expr: parcel_status
      comment: "Current status of the parcel (e.g., active, pending, disposed) — filters for active land asset analysis."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership structure of the parcel (e.g., fee simple, leasehold) — informs land tenure and balance sheet classification."
    - name: "land_use_designation"
      expr: land_use_designation
      comment: "Official land use designation (e.g., cropland, pasture, wetland) — used for regulatory compliance and land classification reporting."
    - name: "state_code"
      expr: state_code
      comment: "State where the parcel is located — enables geographic portfolio analysis and tax jurisdiction segmentation."
    - name: "county"
      expr: county
      comment: "County where the parcel is located — supports local tax and regulatory analysis."
    - name: "flood_zone_designation"
      expr: flood_zone_designation
      comment: "FEMA flood zone designation — critical for risk assessment, insurance cost, and financing eligibility."
    - name: "prime_farmland_class"
      expr: prime_farmland_class
      comment: "USDA prime farmland classification — key indicator of long-term land productivity and asset value."
    - name: "nrcs_land_capability_class"
      expr: nrcs_land_capability_class
      comment: "NRCS land capability class — used to assess agronomic potential and conservation program eligibility."
    - name: "zoning_classification"
      expr: zoning_classification
      comment: "Local zoning classification — relevant for land use compliance and development risk assessment."
    - name: "wetland_indicator"
      expr: wetland_indicator
      comment: "Whether the parcel contains wetland areas (True/False) — affects regulatory constraints and conservation program eligibility."
  measures:
    - name: "total_parcels"
      expr: COUNT(1)
      comment: "Total number of parcels in the land portfolio — baseline measure of land asset count."
    - name: "total_deeded_acres"
      expr: SUM(CAST(total_deeded_acres AS DOUBLE))
      comment: "Total deeded acreage across all parcels — primary measure of owned land portfolio size."
    - name: "total_fsa_cropland_acres"
      expr: SUM(CAST(fsa_cropland_acres AS DOUBLE))
      comment: "Total FSA-designated cropland acres — measures the productive cropland base eligible for USDA farm programs."
    - name: "cropland_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(fsa_cropland_acres AS DOUBLE)) / NULLIF(SUM(CAST(total_deeded_acres AS DOUBLE)), 0), 2)
      comment: "Percentage of total deeded acres classified as FSA cropland — measures productive land utilization and program payment base."
    - name: "total_irrigated_acres"
      expr: SUM(CAST(irrigated_acres AS DOUBLE))
      comment: "Total irrigated acres across all parcels — measures water infrastructure coverage and yield-enhancement investment."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total historical acquisition cost of all parcels — measures total capital deployed in land assets."
    - name: "total_assessed_value"
      expr: SUM(CAST(assessed_value AS DOUBLE))
      comment: "Total assessed value of all parcels — used for property tax planning, balance sheet reporting, and portfolio valuation."
    - name: "total_annual_property_tax"
      expr: SUM(CAST(annual_property_tax AS DOUBLE))
      comment: "Total annual property tax burden across all parcels — key fixed cost for land P&L and budget planning."
    - name: "effective_tax_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(annual_property_tax AS DOUBLE)) / NULLIF(SUM(CAST(assessed_value AS DOUBLE)), 0), 2)
      comment: "Effective property tax rate as a percentage of assessed value — benchmarks tax efficiency across geographies and informs acquisition decisions."
    - name: "avg_acquisition_cost_per_acre"
      expr: ROUND(SUM(CAST(acquisition_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_deeded_acres AS DOUBLE)), 0), 2)
      comment: "Average acquisition cost per deeded acre — key benchmark for land investment efficiency and acquisition pricing decisions."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_lease`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease portfolio KPIs covering cash rent rates, crop share terms, total leased acreage, and lease cost exposure. Used by land managers and CFOs to optimize lease terms, manage renewal risk, and control land cost per acre."
  source: "`agriculture_ecm`.`land`.`lease`"
  dimensions:
    - name: "lease_type"
      expr: lease_type
      comment: "Type of lease arrangement (e.g., cash rent, crop share, flex rent) — primary segmentation for lease economics analysis."
    - name: "lease_status"
      expr: lease_status
      comment: "Current status of the lease (e.g., active, expired, terminated) — filters for active lease portfolio analysis."
    - name: "state_code"
      expr: state_code
      comment: "State where the leased land is located — enables geographic lease cost benchmarking."
    - name: "payment_schedule"
      expr: payment_schedule
      comment: "Lease payment schedule (e.g., annual, semi-annual) — used for cash flow planning and payment risk assessment."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the lease auto-renews (True/False) — critical for lease expiration risk management."
    - name: "conservation_practice_required_flag"
      expr: conservation_practice_required_flag
      comment: "Whether the lease requires conservation practices (True/False) — tracks sustainability obligations embedded in lease terms."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the lease payments — relevant for multi-currency portfolio reporting."
    - name: "flex_rent_trigger_mechanism"
      expr: flex_rent_trigger_mechanism
      comment: "Mechanism that triggers flex rent adjustments (e.g., commodity price, yield) — used to assess variable cost exposure."
  measures:
    - name: "total_active_leases"
      expr: COUNT(1)
      comment: "Total number of leases in the portfolio — baseline measure of lease contract volume."
    - name: "total_leased_acres"
      expr: SUM(CAST(total_leased_acres AS DOUBLE))
      comment: "Total acres under lease across all lease contracts — primary measure of leased land portfolio scale."
    - name: "total_cash_rent_exposure"
      expr: SUM(CAST(cash_rent_rate_per_acre AS DOUBLE) * CAST(total_leased_acres AS DOUBLE))
      comment: "Total estimated annual cash rent cost (rate × acres) across all leases — critical fixed cost KPI for land P&L and budget planning."
    - name: "avg_cash_rent_rate_per_acre"
      expr: AVG(CAST(cash_rent_rate_per_acre AS DOUBLE))
      comment: "Average cash rent rate per acre across all leases — key benchmark for lease negotiation and market competitiveness assessment."
    - name: "avg_crop_share_percentage"
      expr: AVG(CAST(crop_share_percentage AS DOUBLE))
      comment: "Average crop share percentage across crop-share leases — used to assess landlord revenue sharing obligations and net margin impact."
    - name: "avg_flex_rent_base_price"
      expr: AVG(CAST(flex_rent_base_price AS DOUBLE))
      comment: "Average flex rent base price per acre — baseline for variable rent exposure modeling under different commodity price scenarios."
    - name: "avg_flex_rent_cap_per_acre"
      expr: AVG(CAST(flex_rent_cap_per_acre AS DOUBLE))
      comment: "Average flex rent cap per acre — measures the maximum variable rent exposure ceiling across the flex lease portfolio."
    - name: "auto_renewal_lease_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Number of leases with auto-renewal clauses — measures lease continuity risk and the proportion of the portfolio with locked-in renewal terms."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_conservation_practice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conservation practice KPIs covering cost-share program participation, producer cost, total practice investment, and carbon credit eligibility. Used by sustainability managers and executives to track conservation program ROI, compliance posture, and carbon market opportunity."
  source: "`agriculture_ecm`.`land`.`conservation_practice`"
  dimensions:
    - name: "practice_category"
      expr: practice_category
      comment: "Category of conservation practice (e.g., erosion control, water quality, habitat) — primary segmentation for conservation investment analysis."
    - name: "practice_status"
      expr: practice_status
      comment: "Current status of the conservation practice (e.g., active, planned, expired) — filters for active conservation portfolio."
    - name: "bmp_category"
      expr: bmp_category
      comment: "Best Management Practice category — used for regulatory compliance reporting and USDA program alignment."
    - name: "carbon_credit_eligible"
      expr: carbon_credit_eligible
      comment: "Whether the practice is eligible for carbon credits (True/False) — identifies carbon market monetization opportunities."
    - name: "organic_program_eligible"
      expr: organic_program_eligible
      comment: "Whether the practice qualifies for organic program enrollment (True/False) — tracks organic transition support."
    - name: "cost_share_program"
      expr: cost_share_program
      comment: "Name of the cost-share program funding the practice (e.g., EQIP, CSP) — used to track government program participation and funding sources."
    - name: "state_code"
      expr: state_code
      comment: "State where the conservation practice is implemented — enables geographic compliance and program participation analysis."
    - name: "practice_effectiveness_rating"
      expr: practice_effectiveness_rating
      comment: "Effectiveness rating of the conservation practice — used to prioritize high-impact practices and optimize conservation investment."
    - name: "resource_concern"
      expr: resource_concern
      comment: "Primary resource concern addressed by the practice (e.g., soil erosion, water quality) — aligns conservation investment with environmental outcomes."
    - name: "fsma_compliant"
      expr: fsma_compliant
      comment: "Whether the practice is FSMA compliant (True/False) — tracks food safety regulatory compliance."
  measures:
    - name: "total_conservation_practices"
      expr: COUNT(1)
      comment: "Total number of conservation practices implemented — baseline measure of conservation program scale."
    - name: "total_practice_area_acres"
      expr: SUM(CAST(practice_area_acres AS DOUBLE))
      comment: "Total acres covered by conservation practices — measures the land area under active conservation management."
    - name: "total_practice_investment"
      expr: SUM(CAST(total_practice_cost AS DOUBLE))
      comment: "Total investment in conservation practices — measures full program cost including government and producer contributions."
    - name: "total_cost_share_received"
      expr: SUM(CAST(cost_share_amount AS DOUBLE))
      comment: "Total cost-share funding received from government programs — measures USDA program benefit capture and subsidy efficiency."
    - name: "total_producer_cost"
      expr: SUM(CAST(producer_cost AS DOUBLE))
      comment: "Total out-of-pocket producer cost for conservation practices — measures net conservation investment after government cost-share."
    - name: "cost_share_recovery_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_share_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_practice_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of total practice cost recovered through government cost-share programs — measures program funding efficiency and subsidy capture rate."
    - name: "carbon_eligible_practice_count"
      expr: COUNT(CASE WHEN carbon_credit_eligible = TRUE THEN 1 END)
      comment: "Number of conservation practices eligible for carbon credits — quantifies the carbon market opportunity pipeline."
    - name: "avg_cost_per_practice_acre"
      expr: ROUND(SUM(CAST(total_practice_cost AS DOUBLE)) / NULLIF(SUM(CAST(practice_area_acres AS DOUBLE)), 0), 2)
      comment: "Average total cost per practice acre — benchmarks conservation investment efficiency across practice types and geographies."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_soil_sample`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Soil health KPIs derived from laboratory soil samples — covering nutrient levels, pH, organic matter, and fertilizer recommendations. Used by agronomists and precision agriculture teams to optimize input applications, reduce costs, and improve yield outcomes."
  source: "`agriculture_ecm`.`land`.`soil_sample`"
  dimensions:
    - name: "sample_status"
      expr: sample_status
      comment: "Status of the soil sample (e.g., received, analyzed, reported) — filters for completed analytical results."
    - name: "sample_method"
      expr: sample_method
      comment: "Sampling methodology used (e.g., grid, zone, composite) — used to assess data quality and comparability across samples."
    - name: "soil_texture_class"
      expr: soil_texture_class
      comment: "Soil texture classification of the sampled area — key agronomic dimension for nutrient management planning."
    - name: "crop_season_year"
      expr: crop_season_year
      comment: "Crop season year of the soil sample — enables year-over-year soil health trend analysis."
    - name: "phosphorus_method"
      expr: phosphorus_method
      comment: "Laboratory method used for phosphorus analysis (e.g., Bray, Mehlich-3) — critical for result comparability and recommendation accuracy."
  measures:
    - name: "total_soil_samples"
      expr: COUNT(1)
      comment: "Total number of soil samples analyzed — baseline measure of soil testing program coverage."
    - name: "avg_soil_ph"
      expr: AVG(CAST(ph_water AS DOUBLE))
      comment: "Average soil pH across all samples — primary indicator of soil health; pH outside optimal range (6.0–7.0) directly reduces nutrient availability and yield."
    - name: "avg_organic_matter_pct"
      expr: AVG(CAST(organic_matter_pct AS DOUBLE))
      comment: "Average organic matter percentage — key long-term soil health indicator; higher organic matter improves water retention, nutrient cycling, and carbon sequestration."
    - name: "avg_cec_meq_100g"
      expr: AVG(CAST(cec_meq_100g AS DOUBLE))
      comment: "Average cation exchange capacity (CEC) — measures soil's ability to retain nutrients; low CEC indicates leaching risk and higher fertilizer requirements."
    - name: "avg_phosphorus_ppm"
      expr: AVG(CAST(phosphorus_ppm AS DOUBLE))
      comment: "Average soil phosphorus level in ppm — used to calibrate phosphorus fertilizer applications and reduce input costs."
    - name: "avg_potassium_ppm"
      expr: AVG(CAST(potassium_ppm AS DOUBLE))
      comment: "Average soil potassium level in ppm — used to calibrate potassium fertilizer applications and optimize crop nutrition programs."
    - name: "total_nitrogen_recommendation_lbs_ac"
      expr: SUM(CAST(nitrogen_recommendation_lbs_ac AS DOUBLE))
      comment: "Total nitrogen fertilizer recommended across all sampled areas — drives nitrogen procurement planning and cost budgeting."
    - name: "avg_nitrogen_recommendation_lbs_ac"
      expr: AVG(CAST(nitrogen_recommendation_lbs_ac AS DOUBLE))
      comment: "Average nitrogen recommendation per acre — benchmarks nitrogen intensity and identifies over- or under-application risk zones."
    - name: "total_lime_recommendation_lbs_ac"
      expr: SUM(CAST(lime_recommendation_lbs_ac AS DOUBLE))
      comment: "Total lime application recommended across all sampled areas — drives lime procurement and soil pH correction program planning."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_water_right`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Water rights portfolio KPIs covering permitted volume, flow rates, irrigated acreage, and curtailment risk. Used by operations and sustainability leaders to manage water allocation, assess supply security, and ensure regulatory compliance."
  source: "`agriculture_ecm`.`land`.`water_right`"
  dimensions:
    - name: "water_right_status"
      expr: water_right_status
      comment: "Current status of the water right (e.g., active, curtailed, expired) — filters for active water allocation analysis."
    - name: "right_type"
      expr: right_type
      comment: "Type of water right (e.g., surface, groundwater, storage) — primary segmentation for water supply portfolio analysis."
    - name: "issuing_state"
      expr: issuing_state
      comment: "State that issued the water right — enables geographic water allocation and regulatory compliance analysis."
    - name: "source_water_body_type"
      expr: source_water_body_type
      comment: "Type of water source (e.g., river, aquifer, reservoir) — used to assess supply reliability and drought vulnerability."
    - name: "curtailment_status"
      expr: curtailment_status
      comment: "Current curtailment status of the water right — critical risk indicator for irrigation water supply security."
    - name: "permitted_use"
      expr: permitted_use
      comment: "Authorized use of the water right (e.g., irrigation, municipal, stock) — ensures compliance with permitted use restrictions."
    - name: "holder_type"
      expr: holder_type
      comment: "Type of water right holder (e.g., individual, corporation, district) — used for portfolio ownership analysis."
    - name: "is_transferable"
      expr: is_transferable
      comment: "Whether the water right can be transferred (True/False) — informs water market participation and asset liquidity."
    - name: "is_adjudicated"
      expr: is_adjudicated
      comment: "Whether the water right has been legally adjudicated (True/False) — indicates legal certainty and priority security."
  measures:
    - name: "total_water_rights"
      expr: COUNT(1)
      comment: "Total number of water rights in the portfolio — baseline measure of water entitlement count."
    - name: "total_permitted_volume_acre_feet"
      expr: SUM(CAST(annual_volume_acre_feet AS DOUBLE))
      comment: "Total annual permitted water volume in acre-feet — primary measure of water allocation capacity for irrigation planning."
    - name: "total_irrigated_acres_covered"
      expr: SUM(CAST(irrigated_acres AS DOUBLE))
      comment: "Total irrigated acres covered by water rights — measures the land area with secured water entitlements."
    - name: "avg_flow_rate_cfs"
      expr: AVG(CAST(flow_rate_cfs AS DOUBLE))
      comment: "Average permitted flow rate in cubic feet per second — benchmarks water delivery capacity across rights."
    - name: "total_flow_rate_gpm"
      expr: SUM(CAST(flow_rate_gpm AS DOUBLE))
      comment: "Total permitted flow rate in gallons per minute across all water rights — measures aggregate water delivery infrastructure capacity."
    - name: "curtailed_rights_count"
      expr: COUNT(CASE WHEN curtailment_status IS NOT NULL AND curtailment_status != 'none' THEN 1 END)
      comment: "Number of water rights currently under curtailment — critical risk KPI for irrigation water supply security and crop production continuity."
    - name: "transferable_rights_count"
      expr: COUNT(CASE WHEN is_transferable = TRUE THEN 1 END)
      comment: "Number of transferable water rights — measures water market participation potential and portfolio liquidity."
    - name: "avg_well_depth_ft"
      expr: AVG(CAST(well_depth_ft AS DOUBLE))
      comment: "Average well depth in feet for groundwater rights — indicator of aquifer depth and long-term groundwater sustainability risk."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_management_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Management zone KPIs covering soil nutrient variability, organic matter, NDVI vegetation health, and VRA eligibility. Used by precision agriculture teams and agronomists to optimize variable-rate input applications and maximize yield per zone."
  source: "`agriculture_ecm`.`land`.`management_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of management zone (e.g., productivity, soil EC, NDVI) — primary segmentation for precision agriculture analysis."
    - name: "zone_status"
      expr: zone_status
      comment: "Current status of the management zone (e.g., active, archived) — filters for current zone configurations."
    - name: "productivity_class"
      expr: productivity_class
      comment: "Productivity classification of the zone (e.g., high, medium, low) — key dimension for yield potential and input optimization analysis."
    - name: "soil_texture_class"
      expr: soil_texture_class
      comment: "Soil texture class within the management zone — used for nutrient management and water retention analysis."
    - name: "drainage_class"
      expr: drainage_class
      comment: "Drainage classification of the management zone — informs water management and tile drainage investment decisions."
    - name: "delineation_method"
      expr: delineation_method
      comment: "Method used to delineate the zone (e.g., soil EC, yield history, satellite imagery) — used to assess zone data quality and analytical confidence."
    - name: "vra_eligible"
      expr: vra_eligible
      comment: "Whether the zone is eligible for variable-rate application (True/False) — identifies precision agriculture investment opportunities."
  measures:
    - name: "total_management_zones"
      expr: COUNT(1)
      comment: "Total number of management zones defined — baseline measure of precision agriculture program coverage."
    - name: "total_zone_area_acres"
      expr: SUM(CAST(area_acres AS DOUBLE))
      comment: "Total area covered by management zones in acres — measures the scale of precision agriculture zone coverage."
    - name: "avg_soil_ph"
      expr: AVG(CAST(soil_ph_mean AS DOUBLE))
      comment: "Average soil pH across management zones — used to identify lime application needs and optimize nutrient availability at zone level."
    - name: "avg_organic_matter_pct"
      expr: AVG(CAST(organic_matter_pct AS DOUBLE))
      comment: "Average organic matter percentage across management zones — tracks soil health trends and carbon sequestration potential at zone level."
    - name: "avg_ndvi_value"
      expr: AVG(CAST(ndvi_value AS DOUBLE))
      comment: "Average NDVI value across management zones — real-time vegetation health indicator used to identify underperforming zones requiring agronomic intervention."
    - name: "avg_nitrogen_lbs_acre"
      expr: AVG(CAST(nitrogen_lbs_acre AS DOUBLE))
      comment: "Average nitrogen level in lbs per acre across zones — used to calibrate variable-rate nitrogen applications and reduce input costs."
    - name: "avg_phosphorus_lbs_acre"
      expr: AVG(CAST(phosphorus_lbs_acre AS DOUBLE))
      comment: "Average phosphorus level in lbs per acre across zones — used to calibrate variable-rate phosphorus applications."
    - name: "avg_potassium_lbs_acre"
      expr: AVG(CAST(potassium_lbs_acre AS DOUBLE))
      comment: "Average potassium level in lbs per acre across zones — used to calibrate variable-rate potassium applications."
    - name: "vra_eligible_zone_count"
      expr: COUNT(CASE WHEN vra_eligible = TRUE THEN 1 END)
      comment: "Number of management zones eligible for variable-rate application — quantifies the precision agriculture opportunity and ROI potential from VRA technology adoption."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_irrigation_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Irrigation zone KPIs covering application efficiency, installation cost, irrigated area, and system condition. Used by operations managers to optimize water use efficiency, prioritize maintenance, and plan irrigation infrastructure investment."
  source: "`agriculture_ecm`.`land`.`irrigation_zone`"
  dimensions:
    - name: "zone_type"
      expr: zone_type
      comment: "Type of irrigation zone (e.g., surface, drip, pivot) — primary segmentation for irrigation system performance analysis."
    - name: "zone_status"
      expr: zone_status
      comment: "Current operational status of the irrigation zone (e.g., active, inactive, decommissioned) — filters for active irrigation infrastructure."
    - name: "system_type"
      expr: system_type
      comment: "Irrigation system type (e.g., center pivot, drip, flood) — used to benchmark efficiency and maintenance cost by system technology."
    - name: "system_condition"
      expr: system_condition
      comment: "Current physical condition of the irrigation system (e.g., good, fair, poor) — used to prioritize capital maintenance and replacement decisions."
    - name: "water_source_type"
      expr: water_source_type
      comment: "Source of irrigation water (e.g., surface water, groundwater, municipal) — used to assess supply reliability and cost structure."
    - name: "bmp_compliant"
      expr: bmp_compliant
      comment: "Whether the irrigation zone meets Best Management Practice standards (True/False) — tracks regulatory compliance and program eligibility."
    - name: "et_scheduling_enabled"
      expr: et_scheduling_enabled
      comment: "Whether evapotranspiration-based scheduling is enabled (True/False) — indicates advanced water management technology adoption."
  measures:
    - name: "total_irrigation_zones"
      expr: COUNT(1)
      comment: "Total number of irrigation zones — baseline measure of irrigation infrastructure scale."
    - name: "total_irrigated_area_acres"
      expr: SUM(CAST(irrigated_area_acres AS DOUBLE))
      comment: "Total irrigated area in acres across all irrigation zones — primary measure of irrigation system coverage."
    - name: "total_installation_cost_usd"
      expr: SUM(CAST(installation_cost_usd AS DOUBLE))
      comment: "Total capital investment in irrigation system installation — measures total irrigation infrastructure asset value."
    - name: "avg_application_efficiency_pct"
      expr: AVG(CAST(application_efficiency_pct AS DOUBLE))
      comment: "Average irrigation application efficiency percentage — key water use efficiency KPI; low values indicate water waste and opportunity for system upgrades."
    - name: "total_permitted_volume_acre_ft"
      expr: SUM(CAST(permitted_volume_acre_ft AS DOUBLE))
      comment: "Total permitted irrigation water volume in acre-feet — measures water allocation capacity across all irrigation zones."
    - name: "avg_design_application_rate_in_hr"
      expr: AVG(CAST(design_application_rate_in_hr AS DOUBLE))
      comment: "Average design application rate in inches per hour — used to assess system capacity and match application rate to soil infiltration capacity."
    - name: "avg_installation_cost_per_acre"
      expr: ROUND(SUM(CAST(installation_cost_usd AS DOUBLE)) / NULLIF(SUM(CAST(irrigated_area_acres AS DOUBLE)), 0), 2)
      comment: "Average irrigation installation cost per irrigated acre — benchmarks capital efficiency of irrigation investments across system types."
    - name: "et_scheduling_enabled_zone_count"
      expr: COUNT(CASE WHEN et_scheduling_enabled = TRUE THEN 1 END)
      comment: "Number of irrigation zones with ET-based scheduling enabled — measures adoption of precision water management technology."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`land_farm_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Farm unit KPIs covering total operated acreage, owned vs. leased land composition, and organic certification status. Used by land managers and executives to assess land tenure structure, operational scale, and sustainability program enrollment."
  source: "`agriculture_ecm`.`land`.`farm_unit`"
  dimensions:
    - name: "farm_type"
      expr: farm_type
      comment: "Type of farm unit (e.g., grain, livestock, specialty crop) — primary segmentation for operational performance analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the farm unit (e.g., active, inactive) — filters for active farm unit portfolio."
    - name: "state_code"
      expr: state_code
      comment: "State where the farm unit is located — enables geographic portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the farm unit — supports global portfolio segmentation."
    - name: "irrigation_type"
      expr: irrigation_type
      comment: "Type of irrigation used on the farm unit — used to assess water infrastructure and yield potential."
    - name: "tillage_practice"
      expr: tillage_practice
      comment: "Tillage practice employed (e.g., no-till, conventional, strip-till) — key sustainability and soil health indicator."
    - name: "organic_certification_status"
      expr: organic_certification_status
      comment: "Organic certification status of the farm unit — tracks premium market eligibility and sustainability program enrollment."
    - name: "conservation_program_enrollment"
      expr: conservation_program_enrollment
      comment: "Conservation program the farm unit is enrolled in (e.g., CRP, EQIP) — tracks government program participation and payment eligibility."
  measures:
    - name: "total_farm_units"
      expr: COUNT(1)
      comment: "Total number of farm units in the portfolio — baseline measure of operational unit count."
    - name: "total_operated_acres"
      expr: SUM(CAST(total_operated_acres AS DOUBLE))
      comment: "Total acres operated across all farm units — primary measure of operational land scale."
    - name: "total_owned_acres"
      expr: SUM(CAST(owned_acres AS DOUBLE))
      comment: "Total owned acres across all farm units — measures the owned land asset base and balance sheet land value."
    - name: "total_leased_acres"
      expr: SUM(CAST(leased_acres AS DOUBLE))
      comment: "Total leased acres across all farm units — measures leased land exposure and associated rent cost obligations."
    - name: "owned_vs_leased_ratio"
      expr: ROUND(SUM(CAST(owned_acres AS DOUBLE)) / NULLIF(SUM(CAST(leased_acres AS DOUBLE)), 0), 2)
      comment: "Ratio of owned to leased acres — measures land tenure structure and financial risk; higher ratio indicates greater asset ownership and lower rent exposure."
    - name: "lease_dependency_pct"
      expr: ROUND(100.0 * SUM(CAST(leased_acres AS DOUBLE)) / NULLIF(SUM(CAST(total_operated_acres AS DOUBLE)), 0), 2)
      comment: "Percentage of total operated acres that are leased — measures operational dependency on leased land and associated rent cost risk."
$$;