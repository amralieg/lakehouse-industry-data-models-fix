-- Schema for Domain: reservoir | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`reservoir` COMMENT 'Serves as the SSOT for subsurface reservoir characterization, simulation models, PVT data, OOIP/OGIP estimates, STOIIP calculations, EUR estimation, material balance data, and recovery factor optimization. Tracks EOR/IOR programs including WAG, SAGD, and CSS schemes. Supports SEC and SPE-PRMS reserves classification (PDP, PUD, PDNP) and production forecast modeling. Integrates with Schlumberger Petrel reservoir simulation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`reservoir` (
    `reservoir_id` BIGINT COMMENT 'Unique identifier for the subsurface reservoir unit. Primary key for the reservoir entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Reservoirs are managed at facility level for production allocation, surveillance planning, and operational reporting. Facility-level reservoir performance dashboards and production allocation require ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reservoirs are cost objects in oil & gas accounting. All reservoir surveillance, simulation, and study costs are charged to cost centers for monthly cost allocation, AFE tracking, and reserves booking',
    `field_id` BIGINT COMMENT 'FK to asset.field',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Reservoirs are developed under Joint Operating Agreements; JOA partners require reservoir-level cost allocation, reserves booking, production forecasting, and AFE justification. Essential for partner ',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Reservoirs are discovered and developed under lease agreements that grant exploration and production rights. Essential for reserves booking, royalty calculations, working interest determination, and S',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Reservoirs require operating permits from regulatory authorities (EPA, state agencies) for production activities. Permits authorize hydrocarbon extraction, water disposal, and emissions. Essential for',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Reservoirs are profit centers in oil & gas financial reporting. Production revenue and costs roll up to reservoir level for monthly P&L reporting, working interest accounting, and reserves value repor',
    `active_well_count` STRING COMMENT 'Current number of active producing or injecting wells completed in this reservoir.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the reservoir oil, a measure of how heavy or light the crude oil is compared to water.',
    `areal_extent_acres` DECIMAL(18,2) COMMENT 'Geographic area covered by the reservoir at the productive interval, measured in acres.',
    `average_permeability_md` DECIMAL(18,2) COMMENT 'Average permeability of the reservoir rock measured in millidarcies, indicating the ability of the rock to transmit fluids.',
    `average_porosity_percent` DECIMAL(18,2) COMMENT 'Average porosity of the reservoir rock expressed as a percentage of total rock volume available for fluid storage.',
    `base_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the base of the reservoir measured in feet subsea or from surface datum.',
    `co2_content_percent` DECIMAL(18,2) COMMENT 'Concentration of carbon dioxide in the reservoir gas or oil, expressed as a percentage of total gas composition.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the reservoir record was first created in the system.',
    `current_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Most recent measured reservoir pressure, reflecting depletion or pressure maintenance activities, measured in pounds per square inch.',
    `datum_depth_ft` DECIMAL(18,2) COMMENT 'Reference depth used for pressure and fluid contact measurements, typically at the oil-water contact or a standard subsea depth, measured in feet.',
    `discovery_date` DATE COMMENT 'Date when the reservoir was first discovered through drilling or seismic interpretation.',
    `drive_mechanism` STRING COMMENT 'Primary natural energy mechanism driving hydrocarbon production from the reservoir.. Valid values are `solution_gas|water_drive|gas_cap|combination|gravity_drainage|compaction`',
    `eor_program_type` STRING COMMENT 'Type of enhanced or improved oil recovery program implemented or planned for the reservoir, including WAG (Water Alternating Gas), SAGD (Steam-Assisted Gravity Drainage), and CSS (Cyclic Steam Stimulation). [ENUM-REF-CANDIDATE: none|WAG|SAGD|CSS|polymer_flood|chemical_flood|thermal|CO2_injection — 8 candidates stripped; promote to reference product]',
    `eur_mmboe` DECIMAL(18,2) COMMENT 'Total volume of hydrocarbons expected to be recovered from the reservoir over its productive life, measured in million barrels of oil equivalent.',
    `first_production_date` DATE COMMENT 'Date when commercial hydrocarbon production from the reservoir commenced.',
    `fluid_type` STRING COMMENT 'Classification of reservoir fluid based on PVT (Pressure Volume Temperature) behavior and composition.. Valid values are `black_oil|volatile_oil|gas_condensate|dry_gas|wet_gas`',
    `gas_oil_contact_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth of the interface between gas cap and oil phases in the reservoir, measured in feet subsea.',
    `gor_scf_stb` DECIMAL(18,2) COMMENT 'Initial gas-oil ratio representing the volume of gas produced per barrel of oil at standard conditions, measured in standard cubic feet per stock tank barrel.',
    `gross_thickness_ft` DECIMAL(18,2) COMMENT 'Total vertical thickness of the reservoir interval from top to base, measured in feet.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Concentration of hydrogen sulfide in the reservoir gas or oil, measured in parts per million, critical for safety and corrosion management.',
    `initial_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Original reservoir pressure at discovery before production commenced, measured in pounds per square inch.',
    `last_simulation_date` DATE COMMENT 'Date when the reservoir simulation model was last updated or run for production forecasting.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when the reservoir record was last modified or updated.',
    `net_pay_thickness_ft` DECIMAL(18,2) COMMENT 'Cumulative thickness of reservoir rock with sufficient porosity, permeability, and hydrocarbon saturation to contribute to production, measured in feet.',
    `ogip_bcf` DECIMAL(18,2) COMMENT 'Estimated volume of gas originally present in the reservoir before production, measured in billion cubic feet.',
    `oil_water_contact_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth of the interface between oil and water phases in the reservoir, measured in feet subsea.',
    `ooip_mmbbl` DECIMAL(18,2) COMMENT 'Estimated volume of oil originally present in the reservoir before production, measured in million barrels.',
    `prms_classification` STRING COMMENT 'SPE-PRMS reserves and resources classification category indicating the level of certainty and development status. [ENUM-REF-CANDIDATE: 1P|2P|3P|PDP|PUD|PDNP|probable|possible|contingent|prospective — 10 candidates stripped; promote to reference product]',
    `recovery_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of original hydrocarbons in place that is expected to be recovered through primary, secondary, and tertiary recovery methods.',
    `reservoir_code` STRING COMMENT 'Standardized alphanumeric code used for internal identification and reporting of the reservoir across systems.',
    `reservoir_name` STRING COMMENT 'Business name or designation of the reservoir unit, typically reflecting geological formation or discovery sequence.',
    `reservoir_status` STRING COMMENT 'Current operational and lifecycle status of the reservoir.. Valid values are `active|depleted|shut_in|abandoned|under_evaluation|planned`',
    `reservoir_type` STRING COMMENT 'Classification of the reservoir based on primary hydrocarbon content and phase behavior.. Valid values are `oil|gas|condensate|gas_cap|oil_rim`',
    `stoiip_mmbbl` DECIMAL(18,2) COMMENT 'Estimated volume of oil in place at stock tank conditions (surface conditions after gas separation), measured in million barrels.',
    `temperature_f` DECIMAL(18,2) COMMENT 'Average temperature of the reservoir at initial conditions, measured in degrees Fahrenheit.',
    `top_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the top of the reservoir measured in feet subsea or from surface datum.',
    `wor_bbl_bbl` DECIMAL(18,2) COMMENT 'Current water-oil ratio representing the volume of water produced per barrel of oil, measured in barrels per barrel.',
    CONSTRAINT pk_reservoir PRIMARY KEY(`reservoir_id`)
) COMMENT 'Core master entity representing a subsurface reservoir unit — the SSOT for reservoir identity, geometry, fluid type, drive mechanism, and classification. Captures reservoir name, field association, formation, depth range (TVD/MD), areal extent, net pay thickness, porosity, permeability, fluid type (oil/gas/condensate), drive mechanism (solution gas, water drive, gas cap), initial reservoir pressure, temperature, datum depth, API gravity, GOR, WOR, H2S/CO2 content, and PRMS resource classification. Serves as the parent entity for all zone-level, volumetric, simulation, and reserves data in the domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`zone` (
    `zone_id` BIGINT COMMENT 'Primary key for zone',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `reservoir_id` BIGINT COMMENT 'Reference to the parent reservoir containing this zone. Links zone to its reservoir context for multi-zone reservoir management.',
    `average_permeability_md` DECIMAL(18,2) COMMENT 'Arithmetic or geometric mean permeability of the net pay interval measured in millidarcies. Critical for flow rate estimation and well spacing decisions.',
    `average_porosity_fraction` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average porosity of the net pay interval, expressed as a fraction (0 to 1). Key parameter for volumetric hydrocarbon-in-place calculations.',
    `average_water_saturation_fraction` DECIMAL(18,2) COMMENT 'Average fraction of pore space occupied by water in the net pay interval, expressed as a decimal (0 to 1). Used to calculate hydrocarbon saturation (1 - Sw).',
    `bottom_depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore to the bottom of the zone in feet. Used for well planning and completion design in deviated wells.',
    `bottom_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the bottom of the zone measured in feet from a reference datum. Used with top depth to calculate gross thickness.',
    `current_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Most recent measured reservoir pressure in pounds per square inch. Used to monitor depletion and assess need for pressure maintenance or secondary recovery.',
    `depositional_environment` STRING COMMENT 'Geological environment in which the zone sediments were deposited (e.g., fluvial, deltaic, marine shelf, turbidite). Influences reservoir architecture and heterogeneity.',
    `discovery_date` DATE COMMENT 'Date when the zone was first discovered through drilling or seismic interpretation. Marks the beginning of the zones lifecycle for reserves booking and regulatory reporting.',
    `drive_mechanism` STRING COMMENT 'Dominant natural energy source driving hydrocarbon production from the zone. Determines primary recovery efficiency and need for secondary recovery methods.. Valid values are `solution-gas|gas-cap|water-drive|combination|gravity-drainage|compaction`',
    `eor_method` STRING COMMENT 'Type of enhanced or improved oil recovery technique applied or planned for the zone (e.g., WAG, SAGD, CSS, polymer flood, CO2 injection). Empty if no EOR is planned.',
    `eur_mmstb` DECIMAL(18,2) COMMENT 'Estimated total volume of oil that will be recovered from the zone over its productive life, measured in million stock tank barrels. Used for economic evaluation and reserves booking.',
    `first_production_date` DATE COMMENT 'Date when commercial production from the zone first commenced. Used for reserves classification (PDP vs PUD) and economic evaluation.',
    `fluid_type` STRING COMMENT 'Primary hydrocarbon or fluid type present in the zone. Determines production facilities requirements and processing strategies.. Valid values are `oil|gas|condensate|water|oil-and-gas`',
    `gas_oil_contact_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the gas-oil contact in feet. Defines the boundary between gas cap and oil leg in zones with both phases.',
    `gas_water_contact_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the gas-water contact in feet. Defines the lower boundary of the gas column in gas reservoirs without an oil leg.',
    `gross_thickness_ft` DECIMAL(18,2) COMMENT 'Total vertical thickness of the zone from top to bottom in feet, including both reservoir-quality rock and non-reservoir intervals. Used in volumetric calculations.',
    `hydrocarbon_saturation_fraction` DECIMAL(18,2) COMMENT 'Average fraction of pore space occupied by hydrocarbons (oil and/or gas) in the net pay interval, expressed as a decimal (0 to 1). Calculated as 1 minus water saturation.',
    `initial_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Original reservoir pressure at discovery before production, measured in pounds per square inch. Critical for material balance calculations and drive mechanism identification.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was last modified in the system. Supports audit trail and data lineage for regulatory compliance.',
    `lithology_description` STRING COMMENT 'Detailed textual description of the rock type and composition of the zone (e.g., fine-grained sandstone, dolomitic limestone, shale). Supports geological interpretation and correlation.',
    `net_pay_thickness_ft` DECIMAL(18,2) COMMENT 'Cumulative thickness of reservoir-quality rock within the zone that meets cutoff criteria for porosity, permeability, and hydrocarbon saturation. Critical for OOIP and OGIP calculations.',
    `net_to_gross_ratio` DECIMAL(18,2) COMMENT 'Ratio of net pay thickness to gross thickness, expressed as a decimal fraction (0 to 1). Indicates reservoir quality and heterogeneity within the zone.',
    `ogip_bcf` DECIMAL(18,2) COMMENT 'Estimated volume of gas originally in place in the zone before production, measured in billion cubic feet. Used for gas reserves estimation and production forecasting.',
    `oil_water_contact_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the oil-water contact in feet. Defines the lower boundary of the oil column for volumetric calculations and well placement.',
    `ooip_mmstb` DECIMAL(18,2) COMMENT 'Estimated volume of oil originally in place in the zone before production, measured in million stock tank barrels. Key metric for reserves classification and recovery factor estimation.',
    `permeability_range_max_md` DECIMAL(18,2) COMMENT 'Maximum observed permeability value within the zone in millidarcies. Indicates upper bound of flow capacity for heterogeneity assessment.',
    `permeability_range_min_md` DECIMAL(18,2) COMMENT 'Minimum observed permeability value within the zone in millidarcies. Indicates lower bound of flow capacity for heterogeneity assessment.',
    `porosity_type` STRING COMMENT 'Classification of the dominant porosity system in the zone. Determines flow behavior and recovery mechanisms for reservoir simulation and production forecasting.. Valid values are `matrix|fracture|vuggy|dual-porosity|triple-porosity`',
    `primary_lithology` STRING COMMENT 'Dominant rock type classification for the zone. Determines reservoir quality, drilling challenges, and completion strategies. [ENUM-REF-CANDIDATE: sandstone|limestone|dolomite|shale|siltstone|conglomerate|chalk|granite|basalt — 9 candidates stripped; promote to reference product]',
    `recovery_factor_fraction` DECIMAL(18,2) COMMENT 'Ratio of estimated ultimate recovery to original oil in place, expressed as a decimal fraction (0 to 1). Indicates efficiency of primary, secondary, and tertiary recovery mechanisms.',
    `reserves_category` STRING COMMENT 'SPE-PRMS and SEC reserves classification for the zone: Proved Developed Producing (PDP), Proved Developed Non-Producing (PDNP), Proved Undeveloped (PUD), Proved plus Probable (2P), or Proved plus Probable plus Possible (3P).. Valid values are `PDP|PDNP|PUD|2P|3P`',
    `stoiip_mmstb` DECIMAL(18,2) COMMENT 'Volume of oil initially in place at stock tank conditions (surface pressure and temperature) in million barrels. Equivalent to OOIP but emphasizes surface volume basis.',
    `top_depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore to the top of the zone in feet. Relevant for deviated and horizontal wells where MD differs from TVD.',
    `top_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the top of the zone measured in feet from a reference datum (typically mean sea level or kelly bushing). Critical for volumetric calculations and STOIIP estimation.',
    `zone_code` STRING COMMENT 'Standardized alphanumeric code for the zone used in reservoir simulation models and production allocation systems. Unique within the reservoir context.',
    `zone_name` STRING COMMENT 'Business name or designation of the stratigraphic zone or pay interval. Human-readable identifier used in operational communications and reporting.',
    `zone_status` STRING COMMENT 'Current operational status of the zone in terms of production activity. Tracks lifecycle state for production optimization and reserves classification.. Valid values are `active|depleted|undeveloped|shut-in|abandoned`',
    `zone_type` STRING COMMENT 'Classification of the zone based on its hydrocarbon content and production potential. Distinguishes productive pay zones from non-productive intervals.. Valid values are `pay|non-pay|transition|water-bearing|gas-cap|oil-leg`',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Defines stratigraphic zones and pay intervals within a reservoir, serving as the SSOT for zone-level characterization. Captures zone name, formation, top and bottom depth (TVD/MD), net pay, gross pay, net-to-gross ratio, porosity type (matrix/fracture/vuggy), permeability range, fluid contact depths (OWC, GOC, GWC), zone status (active/depleted/undeveloped), and lithology description. Supports multi-zone reservoir management and production allocation by zone.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` (
    `pvt_analysis_id` BIGINT COMMENT 'Unique identifier for the PVT analysis record. Primary key for the PVT analysis data product.',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: PVT laboratory analysis is a direct cost charged to wells/reservoirs. Business process: cost allocation for lab services, AFE tracking, and working interest billing for joint venture operations.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: PVT samples are processed at specific lab facilities; results drive facility design (separator sizing, pipeline specs). Facility design basis, separator optimization, and pipeline flow assurance requi',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: PVT samples collected during exploration/appraisal drilling (DST, wireline sampling). Links fluid properties to discovery wells for initial reservoir characterization. Critical for early-stage reserve',
    `hazardous_substance_id` BIGINT COMMENT 'Foreign key linking to hse.hazardous_substance. Business justification: PVT fluid samples contain hazardous substances (H2S, NORM, aromatic hydrocarbons, mercury) requiring HSE characterization for laboratory handling, transportation (DOT/IATA), disposal, and personnel ex',
    `reservoir_id` BIGINT COMMENT 'Identifier of the reservoir zone from which the sample was obtained.',
    `sample_id` BIGINT COMMENT 'Unique identifier for the reservoir fluid sample collected for laboratory analysis. Links to sample collection records.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: PVT analysis is procured from qualified laboratories (Core Lab, Weatherford, etc.). Links fluid analysis to vendor qualification, performance tracking, and invoice reconciliation. Removes denormalized',
    `well_asset_id` BIGINT COMMENT 'Identifier of the well from which the reservoir fluid sample was collected.',
    `analysis_date` DATE COMMENT 'Date when the PVT laboratory analysis was completed.',
    `analysis_status` STRING COMMENT 'Current status of the PVT analysis in the data quality and approval workflow. Draft = preliminary results, validated = QC complete, approved = ready for simulation use, superseded = replaced by newer analysis.. Valid values are `draft|validated|approved|superseded`',
    `bubble_point_pressure` DECIMAL(18,2) COMMENT 'Pressure at which the first gas bubble appears when pressure is reduced on a liquid hydrocarbon system at constant temperature, measured in psia. Critical parameter for oil reservoirs.',
    `comments` STRING COMMENT 'Free-text comments and notes regarding the PVT analysis, including sample quality observations, laboratory procedures, data anomalies, and recommendations for use.',
    `composition_c1` DECIMAL(18,2) COMMENT 'Mole fraction of methane (C1) in the reservoir fluid composition, expressed as a decimal fraction. Part of the compositional analysis used for EOS modeling.',
    `composition_c2_c6` DECIMAL(18,2) COMMENT 'Combined mole fraction of ethane, propane, butanes, pentanes, and hexanes in the reservoir fluid, expressed as a decimal fraction.',
    `composition_c7_plus` DECIMAL(18,2) COMMENT 'Mole fraction of heptane and heavier hydrocarbons in the reservoir fluid, expressed as a decimal fraction. C7+ characterization is critical for black oil and volatile oil systems.',
    `composition_co2` DECIMAL(18,2) COMMENT 'Mole fraction of carbon dioxide in the reservoir fluid, expressed as a decimal fraction. Important for corrosion assessment and EOR design.',
    `composition_h2s` DECIMAL(18,2) COMMENT 'Mole fraction of hydrogen sulfide in the reservoir fluid, expressed as a decimal fraction. Critical for HSE risk assessment and materials selection in sour service.',
    `composition_n2` DECIMAL(18,2) COMMENT 'Mole fraction of nitrogen in the reservoir fluid, expressed as a decimal fraction. Affects gas heating value and processing requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PVT analysis record was first created in the system.',
    `dew_point_pressure` DECIMAL(18,2) COMMENT 'Pressure at which the first liquid droplet appears when pressure is reduced on a gas system at constant temperature, measured in psia. Critical parameter for gas condensate reservoirs.',
    `eos_model_type` STRING COMMENT 'Type of thermodynamic equation of state model used to match the PVT data for reservoir simulation. Peng-Robinson and Soave-Redlich-Kwong are common cubic EOS models.. Valid values are `peng_robinson|soave_redlich_kwong|benedict_webb_rubin|black_oil`',
    `eos_parameters` STRING COMMENT 'Tuned parameters for the EOS model including binary interaction coefficients, critical properties, and acentric factors. Stored as JSON or delimited string for use in reservoir simulators.',
    `fluid_type` STRING COMMENT 'Classification of the reservoir fluid based on phase behavior and composition. Black oil = low shrinkage crude, volatile oil = high shrinkage crude, gas condensate = retrograde condensate, dry gas = lean gas, wet gas = rich gas with NGLs.. Valid values are `black_oil|volatile_oil|gas_condensate|dry_gas|wet_gas`',
    `gas_compressibility` DECIMAL(18,2) COMMENT 'Change in gas volume per unit change in pressure, measured in reciprocal psi (1/psi). Critical for gas reservoir material balance.',
    `gas_formation_volume_factor` DECIMAL(18,2) COMMENT 'Ratio of gas volume at reservoir conditions to gas volume at standard conditions, measured in reservoir barrels per standard cubic foot (RB/SCF). Bg parameter used in gas material balance.',
    `gas_gravity` DECIMAL(18,2) COMMENT 'Ratio of gas density to air density at standard conditions, dimensionless. Used to characterize gas composition and heating value.',
    `gas_viscosity` DECIMAL(18,2) COMMENT 'Resistance of gas to flow at reservoir conditions, measured in centipoise (cp). Used in gas well deliverability calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the PVT analysis record was last modified in the system.',
    `oil_api_gravity` DECIMAL(18,2) COMMENT 'Measure of how heavy or light crude oil is compared to water, expressed in API degrees. Higher API gravity indicates lighter, more valuable crude oil.',
    `oil_compressibility` DECIMAL(18,2) COMMENT 'Change in oil volume per unit change in pressure, measured in reciprocal psi (1/psi). Used in material balance and pressure transient analysis.',
    `oil_density` DECIMAL(18,2) COMMENT 'Mass per unit volume of oil at reservoir conditions, measured in grams per cubic centimeter (g/cc) or pounds per cubic foot.',
    `oil_formation_volume_factor` DECIMAL(18,2) COMMENT 'Ratio of oil volume at reservoir conditions to oil volume at standard conditions, dimensionless. Bo parameter critical for reserves calculations and material balance.',
    `oil_viscosity` DECIMAL(18,2) COMMENT 'Resistance of oil to flow at reservoir conditions, measured in centipoise (cp). Critical for production forecasting and EOR design.',
    `quality_flag` STRING COMMENT 'Assessment of the overall quality and reliability of the PVT analysis based on sample quality, laboratory procedures, and data consistency checks.. Valid values are `excellent|good|fair|poor|questionable`',
    `reservoir_pressure` DECIMAL(18,2) COMMENT 'Initial reservoir pressure at the sample depth, measured in pounds per square inch absolute (psia).',
    `reservoir_temperature` DECIMAL(18,2) COMMENT 'Temperature of the reservoir at the sample depth, measured in degrees Fahrenheit.',
    `sample_date` DATE COMMENT 'Date when the reservoir fluid sample was collected from the well or facility.',
    `sample_source_type` STRING COMMENT 'Type of source from which the reservoir fluid sample was collected. DST = Drill Stem Test, wellbore = downhole sampling, separator = surface separator sampling, production_test = production test sampling, recombined = laboratory recombined sample.. Valid values are `DST|wellbore|separator|production_test|recombined`',
    `separator_pressure` DECIMAL(18,2) COMMENT 'Operating pressure of the production separator used in the PVT analysis, measured in pounds per square inch gauge (psig).',
    `separator_temperature` DECIMAL(18,2) COMMENT 'Operating temperature of the production separator used in the PVT analysis, measured in degrees Fahrenheit.',
    `shrinkage_factor` DECIMAL(18,2) COMMENT 'Ratio of stock tank oil volume to separator oil volume, dimensionless. Accounts for gas liberation and liquid shrinkage from separator to stock tank conditions.',
    `solution_gor` DECIMAL(18,2) COMMENT 'Volume of gas dissolved in oil at reservoir conditions, measured in standard cubic feet per stock tank barrel (SCF/STB). Rs parameter used in material balance calculations.',
    `stock_tank_pressure` DECIMAL(18,2) COMMENT 'Atmospheric pressure at the stock tank, typically 14.7 psia at standard conditions.',
    `stock_tank_temperature` DECIMAL(18,2) COMMENT 'Temperature at the stock tank, typically 60 degrees Fahrenheit at standard conditions.',
    `z_factor` DECIMAL(18,2) COMMENT 'Gas deviation factor accounting for non-ideal gas behavior at reservoir conditions, dimensionless. Z-factor is critical for gas reserves calculations and material balance.',
    CONSTRAINT pk_pvt_analysis PRIMARY KEY(`pvt_analysis_id`)
) COMMENT 'Stores Pressure-Volume-Temperature (PVT) laboratory analysis results for reservoir fluid characterization. Captures sample ID, sample source (DST/wellbore), fluid type, bubble point pressure, dew point pressure, oil formation volume factor (Bo), gas formation volume factor (Bg), solution GOR (Rs), oil viscosity, gas viscosity, oil density, gas gravity, compressibility, Z-factor, shrinkage factor, separator conditions, EOS model parameters, and lab analysis date. Critical input for reservoir simulation and material balance calculations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` (
    `volumetric_estimate_id` BIGINT COMMENT 'Primary key for volumetric_estimate',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Volumetric studies are engineering work with associated costs. Business process: cost tracking for reserves evaluation work, AFE variance analysis, and working interest billing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Volumetric OOIP estimates are foundation for reserves booking and require licensed geoscientist approval. Links estimate to employee for competency verification (professional geoscientist license), au',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir or reservoir zone for which this volumetric estimate applies.',
    `zone_id` BIGINT COMMENT 'FK to reservoir.zone',
    `simulation_model_id` BIGINT COMMENT 'FK to reservoir.simulation_model',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the crude oil in the reservoir, a measure of oil density. Higher API gravity indicates lighter, more valuable crude oil. Typical range is 10 to 50 degrees API.',
    `approval_date` DATE COMMENT 'Date when the volumetric estimate was formally approved by the qualified geoscientist or reserves committee.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the volumetric estimate based on data quality, reservoir understanding, and estimation method reliability.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this volumetric estimate record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` STRING COMMENT 'Numerical score (1-10) representing the quality and completeness of input data used for the estimate. Higher scores indicate more reliable data (seismic, well logs, core, production history).',
    `estimate_type` STRING COMMENT 'Type of volumetric estimate: OOIP (Original Oil In Place), OGIP (Original Gas In Place), STOIIP (Stock Tank Oil Initially In Place), or GIIP (Gas Initially In Place).. Valid values are `ooip|ogip|stoiip|giip`',
    `estimation_date` DATE COMMENT 'Date when this volumetric estimate was calculated or finalized. Used for tracking estimate vintage and regulatory reporting cutoff dates.',
    `estimation_method` STRING COMMENT 'Method used to calculate the volumetric estimate. Volumetric uses GRV and petrophysical properties; material balance uses production and pressure data; simulation uses reservoir modeling software.. Valid values are `volumetric|material_balance|simulation|decline_curve|analogy|probabilistic`',
    `eur_mmboe` DECIMAL(18,2) COMMENT 'Total volume of hydrocarbons expected to be recovered from the reservoir over its entire productive life, measured in million barrels of oil equivalent. Calculated as OOIP/OGIP multiplied by recovery factor.',
    `formation_volume_factor_gas` DECIMAL(18,2) COMMENT 'Ratio of gas volume at reservoir conditions to gas volume at standard conditions. Used to convert reservoir volumes to standard cubic feet.',
    `formation_volume_factor_oil` DECIMAL(18,2) COMMENT 'Ratio of oil volume at reservoir conditions to oil volume at stock tank conditions. Used to convert reservoir barrels to stock tank barrels. Typically ranges from 1.0 to 2.5.',
    `gas_oil_ratio_scf_bbl` DECIMAL(18,2) COMMENT 'Ratio of gas volume to oil volume produced from the reservoir, measured in standard cubic feet per barrel. Used to characterize reservoir fluid type and drive mechanism.',
    `gross_rock_volume_acre_ft` DECIMAL(18,2) COMMENT 'Total volume of the reservoir rock including both reservoir and non-reservoir rock, measured in acre-feet. Used in volumetric calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this volumetric estimate record was last modified. Used for audit trail and change tracking.',
    `net_rock_volume_acre_ft` DECIMAL(18,2) COMMENT 'Volume of reservoir rock that contains hydrocarbons, excluding non-reservoir intervals, measured in acre-feet. Calculated as GRV multiplied by net-to-gross ratio.',
    `net_to_gross_ratio` DECIMAL(18,2) COMMENT 'Ratio of net reservoir rock to gross rock volume, expressed as a decimal between 0 and 1. Represents the proportion of the reservoir that is productive.',
    `notes` STRING COMMENT 'Additional comments, assumptions, or qualifications related to this volumetric estimate. May include data limitations, methodology notes, or special considerations.',
    `ogip_high_p10_bcf` DECIMAL(18,2) COMMENT 'High estimate (P10 - 10% probability of exceeding) of original gas in place, measured in billion cubic feet. Optimistic estimate for gas reservoirs.',
    `ogip_low_p90_bcf` DECIMAL(18,2) COMMENT 'Low estimate (P90 - 90% probability of exceeding) of original gas in place, measured in billion cubic feet. Conservative estimate for gas reservoirs.',
    `ogip_mid_p50_bcf` DECIMAL(18,2) COMMENT 'Best estimate (P50 - 50% probability of exceeding) of original gas in place, measured in billion cubic feet. Most likely estimate for gas reservoirs.',
    `ooip_high_p10_mmbbl` DECIMAL(18,2) COMMENT 'High estimate (P10 - 10% probability of exceeding) of original oil in place, measured in million barrels. Optimistic estimate used for upside scenarios.',
    `ooip_low_p90_mmbbl` DECIMAL(18,2) COMMENT 'Low estimate (P90 - 90% probability of exceeding) of original oil in place, measured in million barrels. Conservative estimate used for reserves classification.',
    `ooip_mid_p50_mmbbl` DECIMAL(18,2) COMMENT 'Best estimate (P50 - 50% probability of exceeding) of original oil in place, measured in million barrels. Most likely estimate used for planning.',
    `porosity_fraction` DECIMAL(18,2) COMMENT 'Average porosity of the reservoir rock expressed as a fraction (0 to 1). Represents the pore space available to hold fluids.',
    `recovery_factor_fraction` DECIMAL(18,2) COMMENT 'Estimated fraction of OOIP or OGIP that can be economically recovered, expressed as a decimal (0 to 1). Used to calculate recoverable reserves from in-place volumes.',
    `reserves_category` STRING COMMENT 'SPE-PRMS reserves classification category associated with this volumetric estimate: 1P (Proved), 2P (Proved + Probable), 3P (Proved + Probable + Possible), PDP (Proved Developed Producing), PUD (Proved Undeveloped), PDNP (Proved Developed Non-Producing). [ENUM-REF-CANDIDATE: 1p|2p|3p|pdp|pud|pdnp|probable|possible — 8 candidates stripped; promote to reference product]',
    `reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Average reservoir pressure at the time of the estimate, measured in pounds per square inch. Critical input for material balance calculations and PVT analysis.',
    `revision_number` STRING COMMENT 'Sequential version number of this estimate. Incremented each time the estimate is revised due to new data, updated models, or methodology changes.',
    `revision_reason` STRING COMMENT 'Explanation for why this estimate was revised from the previous version (e.g., new well data, updated seismic interpretation, production performance review).',
    `simulation_software` STRING COMMENT 'Name and version of the reservoir simulation software used (e.g., Schlumberger Petrel 2023, Eclipse 100, CMG IMEX). Applicable when estimation method is simulation.',
    `stoiip_mmbbl` DECIMAL(18,2) COMMENT 'Volume of oil initially in place at stock tank conditions (surface conditions), measured in million barrels. Calculated by dividing OOIP by formation volume factor.',
    `uncertainty_assessment_method` STRING COMMENT 'Method used to quantify uncertainty in the volumetric estimate: Monte Carlo simulation, deterministic sensitivity analysis, scenario analysis, or expert judgment.. Valid values are `monte_carlo|deterministic|scenario_analysis|expert_judgment`',
    `volumetric_estimate_status` STRING COMMENT 'Current lifecycle status of the volumetric estimate: draft (under review), approved (finalized), superseded (replaced by newer estimate), archived (historical record).. Valid values are `draft|approved|superseded|archived`',
    `water_saturation_fraction` DECIMAL(18,2) COMMENT 'Average water saturation in the reservoir pore space expressed as a fraction (0 to 1). Hydrocarbon saturation equals 1 minus water saturation.',
    CONSTRAINT pk_volumetric_estimate PRIMARY KEY(`volumetric_estimate_id`)
) COMMENT 'Manages Original Oil In Place (OOIP) and Original Gas In Place (OGIP) volumetric estimates for each reservoir or reservoir zone. Captures estimation method (volumetric/material balance/simulation), gross rock volume (GRV), net rock volume (NRV), net-to-gross ratio, porosity, water saturation, formation volume factor, OOIP low/mid/high (P90/P50/P10), OGIP low/mid/high, STOIIP, estimation date, revision number, and approving geoscientist. Supports SEC and SPE-PRMS reserves disclosure requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` (
    `reserves_estimate_id` BIGINT COMMENT 'Primary key for reserves_estimate',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Reserves estimates are booked against AFE budgets for capital allocation, SEC reporting, and investment decision-making. The afe_number field exists but needs proper FK relationship for budget trackin',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Reserves are booked and reported by facility for SEC compliance, asset valuation, and portfolio management. Facility-level reserves reporting for asset sales, SEC disclosure by operated facility, and ',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Reserves booking for SEC compliance often tied to specific long-term sales contracts that provide revenue certainty and pricing assumptions. Auditors require contract evidence for proved reserves clas',
    `compliance_sec_reserves_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.sec_reserves_disclosure. Business justification: Reserves estimates are the source data for SEC reserves disclosures under Regulation S-K Item 1200. Each annual 10-K disclosure aggregates field-level reserves estimates. Essential for tracing disclos',
    `employee_id` BIGINT COMMENT 'Reference to the qualified petroleum engineer who certified the reserves estimate per SEC and SPE requirements.',
    `eor_scheme_id` BIGINT COMMENT 'Reference to the EOR/IOR program (WAG, SAGD, CSS, waterflooding, gas injection) associated with this reserves estimate, if applicable.',
    `discovery_id` BIGINT COMMENT 'Foreign key linking to exploration.discovery. Business justification: Reserves estimates booked upon discovery declaration per SEC/PRMS guidelines. Links reserves to the discovery event for regulatory compliance, investor reporting, and exploration performance tracking.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Reserves evaluation work requires AFE authorization for cost tracking. SEC compliance requires linking reserves estimates to capital spend for proved property classification and reserves booking certi',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Proved reserves determine fixed asset value under successful efforts or full cost accounting. Business process: SEC proved property classification, ceiling test calculations, DD&A computation, and qua',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Reserves estimates drive partner entitlements, SEC disclosures, and economic evaluations under JOA frameworks. Required for partner reserves booking, net revenue interest calculations, and operating c',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: SEC and PRMS reserves must be attributed to specific lease holdings for 10-K financial reporting, proved developed producing reserves classification, and working interest/NRI calculations. Lease-level',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Reserves valuation (NPV calculation, SEC pricing method) directly references pricing agreements for economic assumptions. SEC rules require pricing basis documentation. Reserves engineers use actual c',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA entitlements (cost oil, profit oil) are calculated from reserves estimates; contractor and government shares, R-factor calculations, and production tier thresholds depend on certified reserves vol',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which reserves are being estimated.',
    `simulation_model_id` BIGINT COMMENT 'Reference to the reservoir simulation model (e.g., Schlumberger Petrel model) used to generate the reserves estimate.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Reserves estimation process is a key SOX control area for financial reporting of proved reserves under SEC rules. Links reserves estimates to specific SOX controls (e.g., reserves committee approval, ',
    `booking_status` STRING COMMENT 'Current workflow status of the reserves estimate: draft, submitted for review, approved for booking, rejected, or revised.. Valid values are `draft|submitted|approved|rejected|revised`',
    `certification_date` DATE COMMENT 'Date on which the reserves estimate was certified by the qualified petroleum engineer.',
    `certifying_engineer_name` STRING COMMENT 'Full name of the qualified petroleum engineer who certified the reserves estimate.',
    `comments` STRING COMMENT 'Additional notes, assumptions, or qualifications related to the reserves estimate, including technical uncertainties and key assumptions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserves estimate record was first created in the system.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Annual discount rate applied to future cash flows for net present value calculation, typically 0.10 (10%) for NPV10.',
    `economic_limit_date` DATE COMMENT 'Projected date when production is expected to reach economic limit and cease to be commercially viable.',
    `effective_date` DATE COMMENT 'Date as of which the reserves estimate is valid and reported, typically year-end for SEC reporting.',
    `estimate_number` STRING COMMENT 'Business identifier for the reserves estimate, typically used in external reporting and SEC filings.',
    `estimation_method` STRING COMMENT 'Technical method used to estimate reserves: deterministic, probabilistic (Monte Carlo), analogy, volumetric, material balance, or decline curve analysis.. Valid values are `deterministic|probabilistic|analogy|volumetric|material_balance|decline_curve`',
    `eur` DECIMAL(18,2) COMMENT 'Total volume of hydrocarbons expected to be recovered from the reservoir over its entire productive life.',
    `eur_uom` STRING COMMENT 'Unit of measure for EUR: BOE, BBL, MCF, MMCF, or BCF.. Valid values are `BOE|BBL|MCF|MMCF|BCF`',
    `field_code` BIGINT COMMENT 'Reference to the oil or gas field containing the reservoir.',
    `forecast_production_profile` STRING COMMENT 'Description or reference to the production forecast profile used in reserves estimation, including decline rates and production plateau assumptions.',
    `net_reserves_volume` DECIMAL(18,2) COMMENT 'Reserves volume attributable to the company after applying net revenue interest, representing the companys economic share.',
    `net_revenue_interest` DECIMAL(18,2) COMMENT 'Ownership percentage representing the net revenue share after royalties and overriding royalties, expressed as a decimal (e.g., 0.780000 for 78%).',
    `npv` DECIMAL(18,2) COMMENT 'Discounted present value of future net cash flows from the reserves, calculated using the specified discount rate (e.g., NPV10 at 10% discount rate).',
    `npv_currency` STRING COMMENT 'Currency code (ISO 4217) for NPV valuation.. Valid values are `USD|EUR|GBP|CAD`',
    `ogip` DECIMAL(18,2) COMMENT 'Total volume of natural gas originally present in the reservoir before production.',
    `ooip` DECIMAL(18,2) COMMENT 'Total volume of oil originally present in the reservoir before production, also known as STOIIP (Stock Tank Oil Initially in Place).',
    `p10_reserves_volume` DECIMAL(18,2) COMMENT 'Reserves volume at P10 probability level (10% probability of exceeding this volume), representing high estimate in probabilistic analysis.',
    `p50_reserves_volume` DECIMAL(18,2) COMMENT 'Reserves volume at P50 probability level (50% probability of exceeding this volume), representing best estimate in probabilistic analysis.',
    `p90_reserves_volume` DECIMAL(18,2) COMMENT 'Reserves volume at P90 probability level (90% probability of exceeding this volume), representing low estimate in probabilistic analysis.',
    `possible_reserves_volume` DECIMAL(18,2) COMMENT 'Volume of possible reserves in the unit of measure specified. Incremental volume beyond proved plus probable reserves.',
    `price_currency` STRING COMMENT 'Currency code (ISO 4217) for pricing and valuation: USD, EUR, GBP, CAD, etc.. Valid values are `USD|EUR|GBP|CAD`',
    `probable_reserves_volume` DECIMAL(18,2) COMMENT 'Volume of probable reserves in the unit of measure specified. Incremental volume beyond proved reserves.',
    `product_type` STRING COMMENT 'Type of hydrocarbon product being estimated: oil, natural gas, NGL (Natural Gas Liquids), or condensate.. Valid values are `oil|gas|NGL|condensate`',
    `proved_reserves_volume` DECIMAL(18,2) COMMENT 'Volume of proved reserves in the unit of measure specified. Represents 1P reserves.',
    `recovery_factor` DECIMAL(18,2) COMMENT 'Ratio of recoverable reserves to original oil in place (OOIP) or original gas in place (OGIP), expressed as a decimal (e.g., 0.3500 for 35%).',
    `reserves_category` STRING COMMENT 'Classification of reserves certainty: 1P (Proved), 2P (Proved plus Probable), 3P (Proved plus Probable plus Possible).. Valid values are `1P|2P|3P`',
    `reserves_sub_category` STRING COMMENT 'Detailed classification: PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), PUD (Proved Undeveloped).. Valid values are `PDP|PDNP|PUD`',
    `reserves_volume_uom` STRING COMMENT 'Unit of measure for reserves volumes: BOE (Barrel of Oil Equivalent), BBL (Barrels), MCF (Thousand Cubic Feet), MMCF (Million Cubic Feet), BCF (Billion Cubic Feet).. Valid values are `BOE|BBL|MCF|MMCF|BCF`',
    `revision_reason` STRING COMMENT 'Business reason for the reserves revision: extensions, discoveries, improved recovery, revisions of previous estimates, purchases, sales, or production.',
    `revision_type` STRING COMMENT 'Categorical classification of the revision: extension (new drilling), discovery (new field), improved recovery (EOR/IOR), revision (estimate change), purchase, sale, or production depletion. [ENUM-REF-CANDIDATE: extension|discovery|improved_recovery|revision|purchase|sale|production — 7 candidates stripped; promote to reference product]',
    `sec_price_per_unit` DECIMAL(18,2) COMMENT 'Price per unit of product used in SEC reserves valuation, typically 12-month average price.',
    `sec_pricing_method` STRING COMMENT 'Pricing methodology used for SEC reserves valuation: 12-month average (standard), spot price, or contract price.. Valid values are `12_month_average|spot_price|contract_price`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the reserves estimate record was last modified in the system.',
    `working_interest` DECIMAL(18,2) COMMENT 'Ownership percentage representing the operating interest in the reservoir, expressed as a decimal (e.g., 0.650000 for 65%).',
    CONSTRAINT pk_reserves_estimate PRIMARY KEY(`reserves_estimate_id`)
) COMMENT 'SSOT for SEC and SPE-PRMS reserves classification and booking. Captures reserves category (1P/2P/3P), sub-category (PDP/PDNP/PUD), product type (oil/gas/NGL/condensate), proved reserves volume (BOE), probable reserves, possible reserves, EUR, recovery factor, effective date, revision reason, SEC pricing used, discount rate, NPV10, booking status, and certifying engineer. Tracks annual reserves revisions, extensions, discoveries, and production revisions per SEC Rule 4-10(a) and SPE-PRMS.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` (
    `simulation_model_id` BIGINT COMMENT 'Unique identifier for the reservoir simulation model record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Simulation models support facility-specific operational planning, turnaround scheduling, and capacity planning. Facility turnaround planning uses simulation forecasts; facility debottlenecking studies',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Reservoir simulation work is capital expenditure requiring AFE authorization. Business process: AFE approval for simulation studies, cost tracking for model development/updates, and capitalization dec',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Reservoir simulation models support JOA operating committee decisions on development plans, AFE justifications, and reserves certifications. Models are shared with joint venture partners for technical',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Reservoir simulation models require designated custodian for version control, approval workflows, and regulatory audit trails. SEC reserves certification and joint venture reporting require named acco',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir being modeled.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Simulation software (Eclipse, CMG, tNavigator) is procured via licenses and support contracts. Links reservoir models to software vendor for license management, support tracking, and procurement of si',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Reservoir simulation models used for reserves booking are subject to SOX IT general controls (access controls, change management) and application controls (model validation, peer review). Critical for',
    `active_cells` BIGINT COMMENT 'Number of active (non-null) cells in the simulation grid that contain reservoir rock and participate in flow calculations.',
    `approval_date` DATE COMMENT 'Date when the simulation model was formally approved for use in reserves booking, development planning, or production forecasting.',
    `approved_by` STRING COMMENT 'Name or identifier of the technical authority or manager who approved the simulation model for operational use.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this simulation model record was first created in the system.',
    `datum_depth_ft` DECIMAL(18,2) COMMENT 'Reference depth in feet (subsea or measured depth) used as the datum for pressure initialization and fluid contacts in the simulation model.',
    `datum_pressure_psi` DECIMAL(18,2) COMMENT 'Initial reservoir pressure at the datum depth in psi, used for model initialization and pressure-volume-temperature (PVT) calculations.',
    `eor_method` STRING COMMENT 'Enhanced Oil Recovery or Improved Oil Recovery method modeled in the simulation: water flood, gas injection, Water Alternating Gas (WAG), CO2 injection, Steam-Assisted Gravity Drainage (SAGD), Cyclic Steam Stimulation (CSS), chemical/polymer/surfactant flood, or microbial EOR. [ENUM-REF-CANDIDATE: none|water_flood|gas_injection|wag|co2_injection|steam_injection|sagd|css|chemical_flood|polymer_flood|surfactant_flood|microbial_eor — 12 candidates stripped; promote to reference product]',
    `eur_gas_bcf` DECIMAL(18,2) COMMENT 'Estimated Ultimate Recovery of gas in billion cubic feet forecasted by the simulation model over the economic life of the reservoir.',
    `eur_oil_mmbbl` DECIMAL(18,2) COMMENT 'Estimated Ultimate Recovery of oil in million barrels forecasted by the simulation model over the economic life of the reservoir.',
    `forecast_end_date` DATE COMMENT 'End date of the production forecast period, representing the economic limit or abandonment date for reserves estimation.',
    `forecast_start_date` DATE COMMENT 'Start date of the production forecast period, typically the day after the history match end date.',
    `grid_dimension_i` STRING COMMENT 'Number of grid cells in the I-direction (typically east-west) of the 3D simulation grid.',
    `grid_dimension_j` STRING COMMENT 'Number of grid cells in the J-direction (typically north-south) of the 3D simulation grid.',
    `grid_dimension_k` STRING COMMENT 'Number of grid cells in the K-direction (vertical/depth) of the 3D simulation grid representing reservoir layers.',
    `history_match_end_date` DATE COMMENT 'End date of the historical production period used for history matching, representing the cutoff for calibration data.',
    `history_match_start_date` DATE COMMENT 'Start date of the historical production period used for history matching and model calibration.',
    `initialization_date` DATE COMMENT 'Date representing the start of the simulation time period, typically the discovery date or first production date used for model initialization.',
    `injector_well_count` STRING COMMENT 'Number of water, gas, or steam injection wells included in the simulation model for pressure maintenance or EOR.',
    `last_run_date` DATE COMMENT 'Date when the simulation model was last executed, used for tracking model currency and update frequency.',
    `model_file_path` STRING COMMENT 'Network or cloud storage path to the simulation model data file (e.g., Petrel project file, Eclipse data deck) for version control and access.',
    `model_name` STRING COMMENT 'Business-friendly name or identifier for the simulation model used for reference and reporting.',
    `model_purpose` STRING COMMENT 'Primary business purpose of the simulation model: history matching (calibration to past production), production forecasting, EOR/IOR evaluation, SEC reserves booking, field development planning, sensitivity analysis, or uncertainty quantification. [ENUM-REF-CANDIDATE: history_match|production_forecast|eor_evaluation|ior_evaluation|reserves_booking|development_planning|sensitivity_analysis|uncertainty_quantification — 8 candidates stripped; promote to reference product]',
    `model_status` STRING COMMENT 'Current lifecycle status of the simulation model indicating its approval state and operational readiness.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `model_type` STRING COMMENT 'Type of reservoir simulation model based on fluid representation and physics: black oil (simplified PVT), compositional (full equation of state), thermal (SAGD/CSS/steam injection), streamline (fast forecasting), dual porosity/permeability (fractured reservoirs).. Valid values are `black_oil|compositional|thermal|streamline|dual_porosity|dual_permeability`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this simulation model record was last modified or updated.',
    `ogip_bcf` DECIMAL(18,2) COMMENT 'Original Gas in Place calculated by the simulation model in billion cubic feet, representing the total volume of gas initially in the reservoir before production.',
    `ooip_mmbbl` DECIMAL(18,2) COMMENT 'Original Oil in Place calculated by the simulation model in million barrels, representing the total volume of oil initially in the reservoir before production.',
    `pressure_match_quality` STRING COMMENT 'Qualitative assessment of how well the simulation model matches observed reservoir pressure data during the history match period.. Valid values are `excellent|good|fair|poor|not_evaluated`',
    `producer_well_count` STRING COMMENT 'Number of oil and gas producing wells included in the simulation model.',
    `production_match_quality` STRING COMMENT 'Qualitative assessment of how well the simulation model matches observed oil, gas, and water production rates during the history match period.. Valid values are `excellent|good|fair|poor|not_evaluated`',
    `pvt_region_count` STRING COMMENT 'Number of distinct PVT regions defined in the simulation model, each with unique fluid property tables for oil, gas, and water.',
    `recovery_factor_gas_percent` DECIMAL(18,2) COMMENT 'Gas recovery factor as a percentage of OGIP, calculated as (EUR Gas / OGIP) × 100, indicating the efficiency of gas recovery from the reservoir.',
    `recovery_factor_oil_percent` DECIMAL(18,2) COMMENT 'Oil recovery factor as a percentage of OOIP, calculated as (EUR Oil / OOIP) × 100, indicating the efficiency of oil recovery from the reservoir.',
    `saturation_region_count` STRING COMMENT 'Number of distinct saturation function regions defined in the simulation model, each with unique relative permeability and capillary pressure curves.',
    `simulator_software` STRING COMMENT 'Reservoir simulation software platform used to build and run the model (e.g., Schlumberger Petrel, Eclipse, CMG IMEX/STARS/GEM, Schlumberger Intersect, Nexus). [ENUM-REF-CANDIDATE: petrel|eclipse|cmg|intersect|nexus|imex|stars|gem|other — 9 candidates stripped; promote to reference product]',
    `simulator_version` STRING COMMENT 'Version number of the simulation software used to ensure reproducibility and compatibility of model runs.',
    `stoiip_mmbbl` DECIMAL(18,2) COMMENT 'Stock Tank Oil Initially in Place in million barrels, representing oil volume at surface conditions calculated from the simulation model.',
    `total_cells` BIGINT COMMENT 'Total number of cells in the simulation grid (I × J × K), representing the full discretization of the reservoir volume.',
    `well_count` STRING COMMENT 'Total number of wells (producers and injectors) included in the simulation model.',
    CONSTRAINT pk_simulation_model PRIMARY KEY(`simulation_model_id`)
) COMMENT 'Master record for reservoir simulation models built in Schlumberger Petrel or equivalent simulators. Captures model name, simulator type (black oil/compositional/thermal), grid dimensions (I/J/K), number of active cells, model purpose (history match/forecast/EOR), simulation software version, model file path, datum, initialization date, last run date, history match quality metrics (pressure match, production match), model custodian, and approval status. Links to PVT data, OOIP estimates, and production history.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` (
    `simulation_run_id` BIGINT COMMENT 'Unique identifier for the simulation run instance. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Simulation runs consume computational resources and engineering time charged to AFE budgets. Essential for tracking reservoir study costs against authorized capital and operating budgets in field deve',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the reservoir engineer or simulation specialist who initiated and is responsible for this simulation run, used for accountability and technical review workflows.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Economic simulation runs use oil_price_assumption and gas_price_assumption fields that should reference actual commercial pricing agreements for NPV forecasting. Investment decisions require alignment',
    `simulation_model_id` BIGINT COMMENT 'Foreign key reference to the parent reservoir simulation model against which this run was executed.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Simulation runs may be triggered by incidents to model consequences (well control event pressure transients, blowout scenarios), validate emergency response strategies, or assess reservoir integrity p',
    `convergence_status` STRING COMMENT 'Indicator of whether the numerical solution achieved convergence criteria at all timesteps (fully converged), some timesteps (partially converged), or failed to converge, affecting the reliability of results for reserves booking and production forecasting.. Valid values are `fully_converged|partially_converged|non_converged|not_applicable`',
    `convergence_tolerance` DECIMAL(18,2) COMMENT 'Numerical tolerance threshold used as the convergence criterion for the simulation run, typically expressed as a relative error in material balance or pressure solution.',
    `cpu_hours_consumed` DECIMAL(18,2) COMMENT 'Total CPU hours consumed by the simulation run across all processors, used for cost allocation and high-performance computing resource management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this simulation run record was first created in the system, used for audit trail and data lineage tracking.',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Annual discount rate used in the NPV calculation for this simulation run, typically 10% for SEC reserves reporting, used to evaluate the time value of money in production forecasting.',
    `eur_gas_bcf` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of natural gas from the reservoir based on this simulation run, expressed in billion cubic feet, used for reserves booking and economic evaluation under SEC and SPE-PRMS standards.',
    `eur_oil_mmbbl` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of oil from the reservoir based on this simulation run, expressed in million barrels, used for reserves booking and economic evaluation under SEC and SPE-PRMS standards.',
    `gas_price_assumption_usd_mcf` DECIMAL(18,2) COMMENT 'Natural gas price assumption used in the economic evaluation of this simulation run, expressed in US dollars per thousand cubic feet, critical for NPV calculation and reserves classification under SEC pricing rules.',
    `gor_constraint_scf_stb` DECIMAL(18,2) COMMENT 'Maximum gas-oil ratio constraint applied to producing wells in the simulation run, expressed in standard cubic feet per stock tank barrel, used to model well shut-in criteria and gas handling capacity limits.',
    `grid_cell_count` STRING COMMENT 'Total number of active grid cells in the simulation model for this run, indicating the spatial resolution and computational complexity of the reservoir representation.',
    `injection_rate_constraint_bopd` DECIMAL(18,2) COMMENT 'Maximum water or gas injection rate constraint applied in the simulation run, expressed in barrels of oil equivalent per day, used for EOR and IOR scenario modeling including WAG and CSS schemes.',
    `input_deck_file_path` STRING COMMENT 'Full file system path or cloud storage URI to the simulation input deck file used for this run, ensuring reproducibility and version control of simulation parameters and model configuration.',
    `max_iterations_per_timestep` STRING COMMENT 'Maximum number of Newton-Raphson or iterative solver iterations allowed per timestep before the simulator either converges or cuts the timestep, affecting run stability and duration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this simulation run record was last modified, used for audit trail, change tracking, and data governance compliance.',
    `npv_usd_mm` DECIMAL(18,2) COMMENT 'Net present value of the production forecast from this simulation run, expressed in millions of US dollars, calculated using discounted cash flow (DCF) analysis for investment decision support and AFE justification.',
    `oil_price_assumption_usd_bbl` DECIMAL(18,2) COMMENT 'Oil price assumption used in the economic evaluation of this simulation run, expressed in US dollars per barrel, critical for NPV calculation and reserves classification under SEC pricing rules.',
    `output_file_path` STRING COMMENT 'Full file system path or cloud storage URI to the simulation run output files, including grid results, well performance data, and material balance reports, used for post-processing and audit trail.',
    `pressure_target_psi` DECIMAL(18,2) COMMENT 'Target reservoir pressure constraint or objective used in the simulation run, expressed in pounds per square inch, critical for pressure maintenance schemes and EOR optimization.',
    `production_rate_constraint_bopd` DECIMAL(18,2) COMMENT 'Maximum oil production rate constraint applied to wells or field in the simulation run, expressed in BOPD, used for production forecasting and reserves classification under SEC and SPE-PRMS guidelines.',
    `production_rate_constraint_mcfd` DECIMAL(18,2) COMMENT 'Maximum gas production rate constraint applied to wells or field in the simulation run, expressed in thousand cubic feet per day, used for gas reservoir forecasting and reserves booking.',
    `quality_flag` STRING COMMENT 'Quality assurance status indicating whether the simulation run results have been reviewed and approved for use in reserves booking, production forecasting, or investment decisions. Preliminary runs are for internal analysis only; final runs are suitable for SEC disclosure and AFE justification.. Valid values are `approved|under_review|rejected|preliminary|final`',
    `recovery_factor_gas_percent` DECIMAL(18,2) COMMENT 'Percentage of original gas in place (OGIP) that is estimated to be recovered based on this simulation run, a key metric for evaluating gas reservoir depletion and recovery optimization strategies.',
    `recovery_factor_oil_percent` DECIMAL(18,2) COMMENT 'Percentage of original oil in place (OOIP) that is estimated to be recovered based on this simulation run, a key metric for evaluating primary, secondary, and enhanced oil recovery (EOR) performance.',
    `reserves_category` STRING COMMENT 'SPE-PRMS reserves classification category that this simulation run supports: 1P (Proved), 2P (Proved plus Probable), 3P (Proved plus Probable plus Possible), PDP (Proved Developed Producing), PUD (Proved Undeveloped), or PDNP (Proved Developed Non-Producing). Critical for SEC reserves disclosure compliance.. Valid values are `1P|2P|3P|PDP|PUD|PDNP`',
    `run_date` DATE COMMENT 'The calendar date on which the simulation run was initiated or executed, used for chronological tracking and version control of simulation scenarios.',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from run start to completion, used for performance benchmarking and capacity planning for simulation infrastructure.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the simulation run execution completed or terminated, used to calculate total run duration and CPU resource consumption.',
    `run_engineer_name` STRING COMMENT 'Full name of the reservoir engineer or simulation specialist who executed the run, used for reporting and technical accountability in reserves certification and AFE documentation.',
    `run_name` STRING COMMENT 'Descriptive name assigned to the simulation run for identification and reporting purposes, often indicating the scenario or sensitivity being tested.',
    `run_number` STRING COMMENT 'Business identifier for the simulation run, typically a sequential or hierarchical numbering scheme used for tracking and referencing runs in reports and AFE documentation.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the simulation run execution began, used for performance monitoring and resource allocation tracking.',
    `run_status` STRING COMMENT 'Current lifecycle status of the simulation run indicating whether it is queued for execution, actively running, successfully completed, failed due to errors, cancelled by user, converged to solution, or terminated without convergence. [ENUM-REF-CANDIDATE: queued|running|completed|failed|cancelled|converged|non_converged — 7 candidates stripped; promote to reference product]',
    `run_type` STRING COMMENT 'Classification of the simulation run purpose: history match (calibration against actual production), sensitivity analysis (parameter variation), forecast (future production prediction), optimization (maximizing recovery or NPV), probabilistic (Monte Carlo), or deterministic (single realization).. Valid values are `history_match|sensitivity_analysis|forecast|optimization|probabilistic|deterministic`',
    `scenario_description` STRING COMMENT 'Detailed textual description of the simulation scenario, including assumptions about well placement, completion strategy, EOR scheme (WAG, SAGD, CSS), economic parameters, and sensitivity variables being tested.',
    `simulator_software` STRING COMMENT 'Name of the reservoir simulation software application used to execute the run (e.g., Eclipse, CMG, Petrel, tNavigator), critical for reproducibility and version control.',
    `simulator_version` STRING COMMENT 'Version number of the simulation software used, essential for ensuring reproducibility and tracking changes in numerical methods or algorithms across software releases.',
    `timestep_count` STRING COMMENT 'Total number of timesteps executed during the simulation run, indicating the temporal resolution and computational intensity of the simulation.',
    `wor_constraint_fraction` DECIMAL(18,2) COMMENT 'Maximum water-oil ratio constraint applied to producing wells in the simulation run, expressed as a dimensionless fraction, used to model economic limits and water handling capacity constraints.',
    CONSTRAINT pk_simulation_run PRIMARY KEY(`simulation_run_id`)
) COMMENT 'Captures individual simulation run instances executed against a reservoir simulation model. Records run date, run type (history match/sensitivity/forecast/optimization), simulator version, run duration, convergence status, timestep count, CPU hours, run parameters (injection rates, production constraints, pressure targets), output file path, run engineer, and quality flag. Enables scenario comparison, sensitivity analysis, and production forecasting for reserves booking and EOR evaluation. Child record of simulation_model.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`material_balance` (
    `material_balance_id` BIGINT COMMENT 'Unique identifier for the material balance calculation record.',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Material balance studies are reservoir engineering work charged to cost centers. Business process: cost allocation for reservoir engineering, AFE tracking, and reserves evaluation cost tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Material balance calculations are regulatory-critical for reserves booking and require certified petroleum engineer signature. Links calculation to qualified engineer for competency verification, audi',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir on which this material balance calculation was performed.',
    `simulation_model_id` BIGINT COMMENT 'Foreign key linking to reservoir.simulation_model. Business justification: Material balance calculations reference simulation_model_name as a STRING but lack the FK. Material balance results (calculated OOIP/OGIP, drive indices) are compared against simulation model volumetr',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Material balance calculations may be triggered post-incident to assess reservoir integrity after well control events, evaluate pressure depletion from uncontrolled flow, quantify hydrocarbon losses fo',
    `approval_date` DATE COMMENT 'Date on which the material balance calculation was formally approved for use in reserves reporting and production planning.',
    `approved_by` STRING COMMENT 'Name of the senior reservoir engineer or technical authority who reviewed and approved the material balance calculation for use in reserves booking and production forecasting.',
    `aquifer_influx_bbl` DECIMAL(18,2) COMMENT 'Cumulative water influx (We) from the aquifer into the reservoir as of the calculation date, measured in barrels. Represents natural water drive support.',
    `aquifer_strength` STRING COMMENT 'Qualitative assessment of aquifer strength based on water influx behavior and pressure support. Indicates the effectiveness of natural water drive in maintaining reservoir pressure.. Valid values are `none|weak|moderate|strong|very strong`',
    `calculated_ogip_mcf` DECIMAL(18,2) COMMENT 'Calculated original gas in place (OGIP) derived from the material balance equation, measured in thousand cubic feet. Represents the total volume of free gas originally present in the reservoir.',
    `calculated_ooip_bbl` DECIMAL(18,2) COMMENT 'Calculated original oil in place (OOIP) derived from the material balance equation, measured in barrels. Represents the total volume of oil originally present in the reservoir at discovery.',
    `calculation_confidence_level` STRING COMMENT 'Confidence level assigned to the material balance calculation results based on data quality, pressure history reliability, and consistency of drive mechanism interpretation.. Valid values are `low|medium|high`',
    `calculation_date` DATE COMMENT 'The date on which the material balance calculation was performed or finalized by the reservoir engineer.',
    `calculation_method` STRING COMMENT 'The analytical method used to perform the material balance calculation. Common methods include Havlena-Odeh (straight-line), Craft-Hawkins, Dake, Schilthuis, Tracy, and Campbell approaches.. Valid values are `Havlena-Odeh|Craft-Hawkins|Dake|Schilthuis|Tracy|Campbell`',
    `calculation_number` STRING COMMENT 'Business identifier for the material balance calculation, typically assigned by the reservoir engineering team for tracking and reference purposes.',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the material balance calculation indicating its approval state and usability for reserves booking and production forecasting.. Valid values are `draft|preliminary|final|approved|superseded`',
    `compaction_drive_index` DECIMAL(18,2) COMMENT 'Compaction drive index (CDI) representing the fraction of reservoir energy provided by formation and connate water compressibility. Dimensionless value between 0 and 1.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this material balance calculation record was first created in the system.',
    `cumulative_gas_injection_mcf` DECIMAL(18,2) COMMENT 'Cumulative gas injection (Gi) into the reservoir as of the calculation date, measured in thousand cubic feet. Used in gas cap maintenance, gas cycling, and enhanced oil recovery (EOR) operations.',
    `cumulative_gas_production_mcf` DECIMAL(18,2) COMMENT 'Cumulative gas production (Gp) from the reservoir as of the calculation date, measured in thousand cubic feet. Includes both free gas and solution gas produced.',
    `cumulative_oil_production_bbl` DECIMAL(18,2) COMMENT 'Cumulative oil production (Np) from the reservoir as of the calculation date, measured in barrels. This is a key input to the material balance equation.',
    `cumulative_water_injection_bbl` DECIMAL(18,2) COMMENT 'Cumulative water injection (Wi) into the reservoir as of the calculation date, measured in barrels. Used in waterflood and pressure maintenance operations.',
    `cumulative_water_production_bbl` DECIMAL(18,2) COMMENT 'Cumulative water production (Wp) from the reservoir as of the calculation date, measured in barrels. Includes both formation water and injected water that has been produced.',
    `current_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Current average reservoir pressure as of the calculation date, measured in pounds per square inch. Pressure decline is a key indicator of reservoir energy and drive mechanism.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Data quality score (0-10 scale) assessing the reliability and completeness of input data used in the material balance calculation, including production history, pressure measurements, and PVT data.',
    `eor_program_type` STRING COMMENT 'Type of enhanced oil recovery or improved oil recovery program applied to the reservoir, such as WAG (Water Alternating Gas), SAGD (Steam-Assisted Gravity Drainage), CSS (Cyclic Steam Stimulation), CO2 injection, polymer flood, or chemical flood. Empty if no EOR program is active. [ENUM-REF-CANDIDATE: WAG|SAGD|CSS|CO2_injection|polymer_flood|chemical_flood|thermal|miscible_gas|immiscible_gas|microbial|none — promote to reference product]',
    `estimated_ultimate_recovery_boe` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery (EUR) representing the total volume of hydrocarbons expected to be recovered over the life of the reservoir, measured in barrels of oil equivalent.',
    `formation_water_expansion_term` DECIMAL(18,2) COMMENT 'Combined formation and connate water expansion term (Ef,w) representing the expansion of formation rock and connate water due to pressure decline. Accounts for rock and fluid compressibility effects.',
    `gas_cap_drive_index` DECIMAL(18,2) COMMENT 'Gas cap drive index (GDI) representing the fraction of reservoir energy provided by expansion of the gas cap. Dimensionless value between 0 and 1.',
    `gas_cap_size_ratio` DECIMAL(18,2) COMMENT 'Gas cap size ratio (m) representing the ratio of initial gas cap volume to initial oil zone volume. Dimensionless parameter used in material balance calculations for reservoirs with gas caps.',
    `gas_expansion_term` DECIMAL(18,2) COMMENT 'Gas expansion term (Eg) representing the change in gas cap volume due to pressure decline. Used in the material balance equation to quantify gas cap drive energy.',
    `gas_formation_volume_factor` DECIMAL(18,2) COMMENT 'Gas formation volume factor (Bg) representing the ratio of gas volume at reservoir conditions to gas volume at standard conditions. Dimensionless ratio used in material balance calculations.',
    `initial_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Initial reservoir pressure at discovery or start of production, measured in pounds per square inch. This is the baseline pressure for material balance calculations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this material balance calculation record was last modified or updated in the system.',
    `oil_expansion_term` DECIMAL(18,2) COMMENT 'Oil expansion term (Eo) representing the change in oil volume due to pressure decline and gas liberation. Used in the material balance equation to quantify solution gas drive energy.',
    `oil_formation_volume_factor` DECIMAL(18,2) COMMENT 'Oil formation volume factor (Bo) representing the ratio of oil volume at reservoir conditions to oil volume at standard conditions. Dimensionless ratio used in material balance calculations.',
    `recovery_factor_percent` DECIMAL(18,2) COMMENT 'Estimated recovery factor as a percentage of OOIP (Original Oil in Place) or OGIP (Original Gas in Place) that can be economically recovered based on the material balance analysis and drive mechanism assessment.',
    `remarks` STRING COMMENT 'Free-text remarks and observations from the reservoir engineer regarding assumptions, data limitations, uncertainties, or special considerations in the material balance calculation.',
    `reserves_category` STRING COMMENT 'SPE-PRMS reserves category classification supported by this material balance calculation. 1P (Proved), 2P (Proved plus Probable), 3P (Proved plus Probable plus Possible), PDP (Proved Developed Producing), PUD (Proved Undeveloped), PDNP (Proved Developed Non-Producing).. Valid values are `1P|2P|3P|PDP|PUD|PDNP`',
    `solution_gas_drive_index` DECIMAL(18,2) COMMENT 'Solution gas drive index (SDI) representing the fraction of reservoir energy provided by expansion of dissolved gas. Dimensionless value between 0 and 1.',
    `solution_gor_scf_stb` DECIMAL(18,2) COMMENT 'Solution gas-oil ratio (Rs) representing the volume of gas dissolved in oil at reservoir conditions, measured in standard cubic feet per stock tank barrel.',
    `water_drive_index` DECIMAL(18,2) COMMENT 'Water drive index (WDI) representing the fraction of reservoir energy provided by aquifer influx and water injection. Dimensionless value between 0 and 1.',
    CONSTRAINT pk_material_balance PRIMARY KEY(`material_balance_id`)
) COMMENT 'Stores material balance calculations performed on reservoirs to estimate OOIP/OGIP and drive mechanism strength. Captures calculation method (Havlena-Odeh/Craft-Hawkins/Dake), cumulative oil production (Np), cumulative gas production (Gp), cumulative water production (Wp), cumulative water injection (Wi), cumulative gas injection (Gi), reservoir pressure history, aquifer influx (We), expansion terms (Eo, Eg, Ef,w), calculated OOIP, drive indices (solution gas/gas cap/water/compaction), calculation date, and engineer. Critical for reservoir energy assessment.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` (
    `pressure_survey_id` BIGINT COMMENT 'Unique identifier for the pressure survey record. Primary key for the pressure survey entity.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Pressure surveys run in exploration/appraisal wells establish initial reservoir pressure regime and fluid contacts. Critical for reserves estimation, aquifer strength assessment, and development plann',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Pressure surveys involve downhole gauge deployment/retrieval requiring Permit to Work for safe execution: well access, wireline operations, pressure equipment handling, and coordination with productio',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Pressure surveys are conducted to monitor reservoir pressure decline over the producing life. Currently pressure_survey has well_asset_id and simulation_model_id but no direct reservoir_id FK. This is',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Pressure surveys measure zone-specific pressures in multi-zone completions. Currently has reservoir_zone as a STRING attribute but no FK. This should be normalized - zone-level pressure monitoring is ',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key linking to procurement.service_entry_sheet. Business justification: Pressure surveys are wireline/slickline services procured from vendors (Schlumberger, Halliburton, Baker Hughes). Links survey data to service entry sheets for cost accrual and vendor payment. Removes',
    `simulation_model_id` BIGINT COMMENT 'Reference to the reservoir simulation model that uses this pressure survey data for history matching. Links operational data to reservoir modeling workflows in Schlumberger Petrel.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pressure surveys feed reservoir management decisions and reserves updates; require qualified engineer certification for data quality assurance. Links survey to engineer for competency verification (we',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the well where the pressure survey was conducted. Links to the well asset master data.',
    `comments` STRING COMMENT 'Free-text field for additional comments, observations, or contextual information about the pressure survey that may be relevant for interpretation or future reference.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pressure survey record was first created in the system. Audit trail for data governance and lineage tracking.',
    `data_quality_flag` STRING COMMENT 'Qualitative assessment of the pressure survey data quality based on stabilization, gauge performance, and measurement conditions. Guides usage in reservoir simulation and material balance analysis.. Valid values are `excellent|good|fair|poor|rejected`',
    `datum_corrected_pressure_psi` DECIMAL(18,2) COMMENT 'The pressure measurement corrected to a common datum elevation for reservoir-wide pressure comparison and mapping. Essential for identifying pressure depletion patterns and reservoir connectivity.',
    `datum_elevation_ft` DECIMAL(18,2) COMMENT 'The reference elevation to which all pressure measurements are corrected for reservoir-wide analysis, measured in feet subsea or above mean sea level.',
    `flowing_bhp_psi` DECIMAL(18,2) COMMENT 'The bottomhole pressure measured while the well is flowing, measured in pounds per square inch. Used to calculate drawdown and well productivity.',
    `fluid_gradient_psi_ft` DECIMAL(18,2) COMMENT 'The hydrostatic pressure gradient of the reservoir fluid column, measured in PSI per foot. Indicates fluid type and density.',
    `gas_rate_mcfd` DECIMAL(18,2) COMMENT 'The gas production rate at the time of the flowing pressure survey, measured in thousand cubic feet per day. Used for gas well performance analysis and material balance calculations.',
    `gauge_accuracy_psi` DECIMAL(18,2) COMMENT 'The manufacturer-specified accuracy of the pressure gauge, measured in PSI. Defines the measurement uncertainty for data quality assessment.',
    `gauge_calibration_date` DATE COMMENT 'The date when the pressure gauge was last calibrated. Used to validate measurement accuracy and compliance with quality standards.',
    `gauge_serial_number` STRING COMMENT 'The unique serial number of the pressure gauge instrument used for the survey. Enables traceability to calibration records and quality assurance.',
    `gauge_type` STRING COMMENT 'The type of pressure gauge used for the survey. Indicates measurement technology and expected accuracy characteristics.. Valid values are `mechanical|electronic|quartz|strain_gauge|fiber_optic|memory_gauge`',
    `gor_scf_stb` DECIMAL(18,2) COMMENT 'The gas-oil ratio measured at the time of the survey, in standard cubic feet per stock tank barrel. Indicates reservoir fluid characteristics and depletion behavior.',
    `material_balance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this pressure survey is used in material balance calculations for reserves estimation and reservoir performance analysis. True indicates the survey meets quality criteria for material balance input.',
    `measured_depth_ft` DECIMAL(18,2) COMMENT 'The measured depth along the wellbore where the pressure survey was conducted, measured in feet from the surface reference point.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified this pressure survey record. Audit trail for accountability and data governance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this pressure survey record was last modified. Audit trail for data governance and change tracking.',
    `perforation_interval_bottom_ft` DECIMAL(18,2) COMMENT 'The measured depth of the bottom of the perforated interval in feet. Defines the producing interval relevant to the pressure survey.',
    `perforation_interval_top_ft` DECIMAL(18,2) COMMENT 'The measured depth of the top of the perforated interval in feet. Defines the producing interval relevant to the pressure survey.',
    `pressure_gradient_psi_ft` DECIMAL(18,2) COMMENT 'The rate of pressure change with depth, measured in PSI per foot. Used to identify fluid contacts and reservoir compartmentalization.',
    `production_rate_bopd` DECIMAL(18,2) COMMENT 'The oil production rate at the time of the flowing pressure survey, measured in barrels of oil per day. Used to calculate well productivity index and inflow performance.',
    `quality_control_notes` STRING COMMENT 'Free-text notes documenting quality control observations, anomalies, or special conditions during the survey that may affect data interpretation.',
    `reservoir_temperature_f` DECIMAL(18,2) COMMENT 'The reservoir temperature measured at the survey depth, in degrees Fahrenheit. Critical for PVT analysis and fluid property calculations.',
    `shut_in_time_hours` DECIMAL(18,2) COMMENT 'The duration in hours that the well was shut in prior to the static pressure measurement. Longer shut-in times allow pressure stabilization and more accurate reservoir pressure determination.',
    `stabilization_flag` BOOLEAN COMMENT 'Boolean indicator of whether the pressure measurement reached stabilization criteria. True indicates the pressure stabilized within acceptable tolerance; False indicates the measurement may not represent true reservoir pressure.',
    `static_bhp_psi` DECIMAL(18,2) COMMENT 'The static bottomhole pressure measured when the well is shut in and stabilized, measured in pounds per square inch. Key input for material balance calculations and reservoir simulation history matching.',
    `survey_date` DATE COMMENT 'The date when the pressure survey was conducted. Primary business event timestamp for the survey.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the pressure survey. Tracks the survey from planning through validation and final acceptance.. Valid values are `planned|in_progress|completed|validated|rejected|cancelled`',
    `survey_time` TIMESTAMP COMMENT 'The precise timestamp when the pressure survey measurement was taken, including time zone information.',
    `survey_type` STRING COMMENT 'Type of pressure survey conducted. BHP=Bottom Hole Pressure, BHT=Bottom Hole Temperature, RFT=Repeat Formation Tester, MDT=Modular Formation Dynamics Tester, DST=Drill Stem Test, PLT=Production Logging Tool.. Valid values are `BHP|BHT|RFT|MDT|DST|PLT`',
    `true_vertical_depth_ft` DECIMAL(18,2) COMMENT 'The true vertical depth from the surface reference point to the survey measurement point, measured in feet. Critical for datum correction and reservoir pressure analysis.',
    `water_rate_bwpd` DECIMAL(18,2) COMMENT 'The water production rate at the time of the flowing pressure survey, measured in barrels of water per day. Used to calculate water cut and monitor reservoir water influx.',
    `wor_ratio` DECIMAL(18,2) COMMENT 'The water-oil ratio measured at the time of the survey, expressed as a dimensionless ratio. Monitors water breakthrough and reservoir sweep efficiency.',
    CONSTRAINT pk_pressure_survey PRIMARY KEY(`pressure_survey_id`)
) COMMENT 'Records static and flowing reservoir pressure surveys conducted on wells to monitor reservoir pressure depletion and connectivity. Captures survey date, well identifier, survey type (BHP/BHT/RFT/MDT/DST), measured depth, true vertical depth, static bottomhole pressure (SBHP), flowing bottomhole pressure (FBHP), reservoir temperature, pressure gradient, fluid gradient, datum-corrected pressure, gauge type, gauge serial number, survey engineer, and data quality flag. Feeds material balance and reservoir simulation history matching.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`well_test` (
    `well_test_id` BIGINT COMMENT 'Primary key for well_test',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Well testing is a service cost charged to AFEs. Business process: cost allocation for testing services, AFE variance tracking, and working interest billing for joint operations.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Drill stem tests (DSTs) conducted on exploration/appraisal wells provide initial reservoir pressure, permeability, and productivity data. Essential for discovery evaluation, reserves booking, and deve',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Well testing operations require Permit to Work authorization due to inherent hazards: high-pressure operations, H2S exposure risk, flaring activities, and well intervention. PTW ensures isolation, gas',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Well tests are performed to characterize reservoir properties including permeability, skin factor, and productivity index. Currently well_test has well_asset_id but no direct reservoir_id FK. This cre',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Well tests target specific reservoir zones to measure zone-level productivity, permeability, and skin factor. Currently well_test lacks zone-level attribution. This is critical for multi-zone reservoi',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key linking to procurement.service_entry_sheet. Business justification: Well tests are performed by service vendors (wireline, testing services) and recorded as service entry sheets for payment processing. Links reservoir test data to procurement accruals and vendor invoi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Well test interpretation drives reserves classification and requires certified petroleum engineer. Regulatory agencies (BSEE, state commissions) require named qualified engineer for test validation. L',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the well asset where the test was conducted.',
    `afe_number` STRING COMMENT 'AFE number authorizing the well test expenditure. Links test costs to capital or operating budget and enables joint interest billing.',
    `choke_size_64ths_inch` STRING COMMENT 'Surface choke size used during the flow period, expressed in 64ths of an inch. Controls flow rate and wellhead pressure during testing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this well test record was first created in the system. Audit trail for data lineage and compliance.',
    `data_source_system` STRING COMMENT 'Source system from which this well test record originated (e.g., Avocet Production Operations, OSIsoft PI System, Schlumberger Petrel). Supports data lineage and integration troubleshooting.',
    `drainage_radius_ft` DECIMAL(18,2) COMMENT 'Estimated drainage radius of the well from pressure transient analysis, in feet. Defines the reservoir volume investigated by the test and supports EUR calculations.',
    `flow_period_count` STRING COMMENT 'Number of distinct flow periods during the test. Multi-rate tests have multiple flow periods at different rates to evaluate reservoir response.',
    `flowing_bottomhole_pressure_psi` DECIMAL(18,2) COMMENT 'Bottomhole pressure measured during flow period, in PSI. Used to calculate pressure drawdown and productivity index.',
    `fsip_psi` DECIMAL(18,2) COMMENT 'Final shut-in pressure measured at the end of the buildup period, in PSI. Used to estimate static reservoir pressure and evaluate pressure depletion.',
    `gas_flow_rate_mcfd` DECIMAL(18,2) COMMENT 'Stabilized gas production rate measured during the test, in MCFD. Critical for gas well productivity index calculation and reserves estimation.',
    `gor_scf_stb` DECIMAL(18,2) COMMENT 'Gas-Oil Ratio measured during the test, expressed as standard cubic feet of gas per stock tank barrel of oil. Critical for PVT (Pressure Volume Temperature) analysis and reservoir fluid characterization.',
    `interpretation_model` STRING COMMENT 'Reservoir model used for test interpretation (e.g., homogeneous, dual-porosity, composite, radial flow, linear flow). Defines the conceptual framework for analysis.',
    `interpretation_software` STRING COMMENT 'Software application used for pressure transient analysis and test interpretation (e.g., Saphir, Ecrin, Kappa Workstation). Documents the analytical tool and methodology.',
    `isip_psi` DECIMAL(18,2) COMMENT 'Initial shut-in pressure measured at the start of the buildup period, in PSI. Key parameter for reservoir pressure estimation and fracture gradient analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this well test record was last modified. Tracks data updates and supports change management and audit requirements.',
    `oil_flow_rate_bopd` DECIMAL(18,2) COMMENT 'Stabilized oil production rate measured during the test, in BOPD. Used for well productivity assessment and IP (Initial Production) reporting.',
    `permeability_md` DECIMAL(18,2) COMMENT 'Effective permeability of the reservoir formation derived from well test interpretation, in millidarcies. Fundamental property for reservoir simulation and EUR estimation.',
    `permeability_thickness_md_ft` DECIMAL(18,2) COMMENT 'Product of permeability and net pay thickness, in millidarcy-feet. Key reservoir property for flow capacity assessment and productivity index calculation.',
    `productivity_index_stb_day_psi` DECIMAL(18,2) COMMENT 'Well productivity index calculated as flow rate divided by pressure drawdown, in STB/day/psi. Measures well deliverability and completion effectiveness.',
    `reserves_classification` STRING COMMENT 'SPE-PRMS reserves category supported by this test. PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), PUD (Proved Undeveloped). Critical for SEC reserves disclosure.. Valid values are `PDP|PDNP|PUD|probable|possible|unclassified`',
    `reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Interpreted static reservoir pressure from pressure transient analysis (PTA), in PSI. Critical input for material balance calculations, OOIP/OGIP estimation, and reserves classification.',
    `shutin_period_count` STRING COMMENT 'Number of shut-in periods during the test. Shut-in periods allow pressure buildup for reservoir characterization and permeability estimation.',
    `skin_factor` DECIMAL(18,2) COMMENT 'Dimensionless skin factor derived from pressure transient analysis. Positive skin indicates formation damage; negative skin indicates stimulation or fracturing. Critical for well productivity optimization.',
    `static_bottomhole_pressure_psi` DECIMAL(18,2) COMMENT 'Stabilized bottomhole pressure measured during shut-in period, in PSI. Represents reservoir pressure at the wellbore and is critical for material balance analysis.',
    `test_comments` STRING COMMENT 'Free-text field for test engineer notes, observations, operational issues, data quality concerns, or interpretation caveats. Provides context for future analysis.',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the well test in hours, from start to end. Critical for pressure transient analysis and EUR (Estimated Ultimate Recovery) calculations.',
    `test_end_date` TIMESTAMP COMMENT 'Timestamp when the well test concluded. Marks the completion of data acquisition and the end of the test sequence.',
    `test_number` STRING COMMENT 'Business identifier for the well test, typically assigned by the operator or test engineer for tracking and reporting purposes.',
    `test_objective` STRING COMMENT 'Primary business objective of the well test (e.g., reservoir characterization, productivity assessment, reserves estimation, completion evaluation, interference testing).',
    `test_quality_flag` STRING COMMENT 'Qualitative assessment of test data quality and reliability. Excellent indicates clean data suitable for reserves booking; poor or invalid indicates data should not be used for critical decisions.. Valid values are `excellent|good|fair|poor|invalid`',
    `test_start_date` TIMESTAMP COMMENT 'Timestamp when the well test commenced. Represents the beginning of the flow or shut-in period for pressure transient analysis.',
    `test_status` STRING COMMENT 'Current lifecycle status of the well test. Tracks progression from planning through execution to completion or termination.. Valid values are `planned|in_progress|completed|suspended|cancelled|failed`',
    `test_temperature_f` DECIMAL(18,2) COMMENT 'Reservoir temperature measured during the test, in degrees Fahrenheit. Required for PVT analysis and fluid property correlation.',
    `test_type` STRING COMMENT 'Classification of the well test method. DST (Drill Stem Test) is conducted during drilling; buildup and drawdown are pressure transient tests; interference and pulse tests evaluate reservoir connectivity; production tests measure flow rates and fluid properties. [ENUM-REF-CANDIDATE: DST|buildup|drawdown|interference|pulse|production_test|extended_production_test — 7 candidates stripped; promote to reference product]',
    `water_flow_rate_bwpd` DECIMAL(18,2) COMMENT 'Water production rate measured during the test, in BWPD. Used to calculate WOR (Water-Oil Ratio) and assess reservoir water influx or aquifer support.',
    `wellbore_storage_coefficient` DECIMAL(18,2) COMMENT 'Wellbore storage coefficient from pressure transient analysis, representing fluid redistribution effects in the wellbore. Affects early-time pressure response interpretation.',
    `wor_ratio` DECIMAL(18,2) COMMENT 'Water-Oil Ratio calculated from test flow rates. Indicates water breakthrough and reservoir sweep efficiency, critical for EOR (Enhanced Oil Recovery) program evaluation.',
    CONSTRAINT pk_well_test PRIMARY KEY(`well_test_id`)
) COMMENT 'Manages well test data including DST (Drill Stem Test), production tests, and pressure transient analysis (PTA) results. Captures test type (DST/buildup/drawdown/interference/pulse), test date, test duration, flow periods, shut-in periods, initial shut-in pressure (ISIP), final shut-in pressure (FSIP), flow rate during test, skin factor, permeability-thickness (kh), wellbore storage coefficient, drainage radius, reservoir pressure from PTA, test engineer, and interpretation software used. Integrates with Avocet Production Operations for well test analysis.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` (
    `production_forecast_id` BIGINT COMMENT 'Unique identifier for the reservoir production forecast record. Primary key for the reservoir production forecast data product.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Production forecasts drive facility capacity planning, debottlenecking, and turnaround scheduling. Facility capacity planning, production allocation forecasting, and facility economic limit determinat',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Production forecasts drive revenue budgets and opex planning. Business process: annual budget preparation, reserves value calculation, and economic limit determination for proved reserves booking.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Production forecasts drive offtake agreement volume commitments and delivery schedules. Offtake agreements require supporting production forecasts for minimum/maximum volume obligations. Commercial te',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir from which production is forecasted. Links to reservoir master data for subsurface characterization.',
    `simulation_run_id` BIGINT COMMENT 'The unique identifier for the specific reservoir simulation run that generated this forecast. Enables linkage to detailed simulation inputs, assumptions, and sensitivity cases.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well asset for which this production forecast applies. Links to the well asset master data.',
    `approval_date` DATE COMMENT 'The date on which the production forecast was formally approved by the qualified reservoir engineer. Critical for audit trail and SEC compliance.',
    `approving_engineer_name` STRING COMMENT 'The name of the qualified reservoir engineer who reviewed and approved this production forecast. Required for SEC reserves certification and internal governance.',
    `b_factor` DECIMAL(18,2) COMMENT 'The hyperbolic decline exponent (b-factor) used in Arps decline curve analysis, ranging from 0 (exponential) to 1 (harmonic). Defines the curvature of the production decline profile. SEC guidance limits b-factor to 1.0 for PUD reserves.',
    `confidence_level` STRING COMMENT 'Probabilistic confidence level for the forecast: P10 (10% probability of exceeding, high case), P50 (50% probability, best estimate), P90 (90% probability, low case), or deterministic (single-point estimate). Used for risk assessment and reserves booking.. Valid values are `P10|P50|P90|deterministic`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this production forecast record was first created in the system. Part of the audit trail for data lineage and governance.',
    `decline_rate_annual_percent` DECIMAL(18,2) COMMENT 'The annual production decline rate expressed as a percentage, representing the rate at which production decreases over time. Critical parameter for decline curve analysis (DCA) and EUR calculation.',
    `decline_type` STRING COMMENT 'The mathematical decline curve model applied: exponential (constant percentage decline), hyperbolic (variable decline with b-factor), or harmonic (special case of hyperbolic with b=1). Determines production forecast shape.. Valid values are `exponential|hyperbolic|harmonic`',
    `economic_limit_rate_boe_per_day` DECIMAL(18,2) COMMENT 'The minimum production rate in Barrels of Oil Equivalent per day at which the well or reservoir remains economically viable. Below this rate, operating expenses exceed revenue and production is abandoned.',
    `eor_program_type` STRING COMMENT 'The type of Enhanced Oil Recovery (EOR) or Improved Oil Recovery (IOR) program applied: primary depletion, waterflood, Water Alternating Gas (WAG), Steam-Assisted Gravity Drainage (SAGD), Cyclic Steam Stimulation (CSS), CO2 injection, polymer flood, thermal steam, chemical EOR, or none. Impacts recovery factor and production profile. [ENUM-REF-CANDIDATE: primary|waterflood|wag|sagd|css|co2_injection|polymer_flood|thermal_steam|chemical|none — 10 candidates stripped; promote to reference product]',
    `eur_boe_mmboe` DECIMAL(18,2) COMMENT 'The total estimated ultimate recovery expressed in Million Barrels of Oil Equivalent (MMBOE), combining oil, gas (converted at 6 MCF = 1 BOE), and NGL. Standard metric for aggregated reserves reporting.',
    `eur_gas_bcf` DECIMAL(18,2) COMMENT 'The total estimated ultimate recovery of natural gas from the well or reservoir over its entire productive life, measured in Billion Cubic Feet (BCF). Critical for gas reserves reporting and development planning.',
    `eur_ngl_mmbbl` DECIMAL(18,2) COMMENT 'The total estimated ultimate recovery of Natural Gas Liquids (NGL) from the well or reservoir over its entire productive life, measured in Million Barrels (MMBBL). Important for gas processing economics and reserves classification.',
    `eur_oil_mmbbl` DECIMAL(18,2) COMMENT 'The total estimated ultimate recovery of oil from the well or reservoir over its entire productive life, measured in Million Barrels (MMBBL). Key metric for reserves booking and asset valuation.',
    `forecast_comments` STRING COMMENT 'Free-text field for additional notes, assumptions, limitations, or qualifications related to this production forecast. Captures engineering judgment and context not represented in structured fields.',
    `forecast_effective_date` DATE COMMENT 'The date from which this production forecast becomes effective and applicable for reserves booking, economic evaluation, and development planning. Aligns with SEC reporting requirements for reserves as of year-end.',
    `forecast_method` STRING COMMENT 'Technical method used to generate the production forecast: Decline Curve Analysis (DCA), reservoir simulation (Petrel/Eclipse), material balance, analogy to offset wells, empirical correlation, or integrated approach combining multiple methods.. Valid values are `decline_curve_analysis|reservoir_simulation|material_balance|analogy|empirical|integrated`',
    `forecast_name` STRING COMMENT 'Business-friendly name or identifier for this production forecast scenario, used for tracking and reporting purposes.',
    `forecast_period_end_date` DATE COMMENT 'The end date of the production forecast period, representing the economic limit or abandonment date when production is no longer commercially viable.',
    `forecast_period_start_date` DATE COMMENT 'The start date of the production forecast period, typically the first production date or the date from which future production is projected.',
    `forecast_scenario` STRING COMMENT 'The business scenario or case name for this forecast (e.g., base case, upside, downside, accelerated development, infill drilling). Used for sensitivity analysis and decision support.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the production forecast: draft (in preparation), under review (pending approval), approved (validated by reservoir engineer), active (currently used for planning), superseded (replaced by newer forecast), or archived (historical record).. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `forecast_type` STRING COMMENT 'Classification of the forecasting methodology used: deterministic (single outcome), probabilistic (P10/P50/P90 distribution), simulation-based (reservoir simulator output), analogy-based (type curve), or hybrid approach.. Valid values are `deterministic|probabilistic|simulation_based|analogy_based|hybrid`',
    `gor_scf_per_bbl` DECIMAL(18,2) COMMENT 'The Gas-Oil Ratio (GOR) representing the volume of gas produced per barrel of oil, measured in Standard Cubic Feet per Barrel (SCF/BBL). Critical for reservoir characterization, facility design, and production optimization.',
    `initial_production_rate_gas_mcfd` DECIMAL(18,2) COMMENT 'The initial gas production rate at the start of the forecast period, measured in Thousand Cubic Feet per Day (MCFD). Used for gas reserves estimation and decline curve modeling.',
    `initial_production_rate_oil_bopd` DECIMAL(18,2) COMMENT 'The initial oil production rate at the start of the forecast period, measured in Barrels of Oil Per Day (BOPD). Key parameter for decline curve analysis and EUR estimation.',
    `initial_production_rate_water_bwpd` DECIMAL(18,2) COMMENT 'The initial water production rate at the start of the forecast period, measured in Barrels of Water Per Day (BWPD). Important for Water-Oil Ratio (WOR) tracking and facility design.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this production forecast record was last modified. Tracks changes for version control and audit purposes.',
    `recovery_factor_percent` DECIMAL(18,2) COMMENT 'The percentage of Original Oil in Place (OOIP) or Original Gas in Place (OGIP) that is expected to be recovered over the life of the reservoir. Calculated as EUR divided by OOIP/OGIP. Key indicator of reservoir performance and Enhanced Oil Recovery (EOR) effectiveness.',
    `reserves_category` STRING COMMENT 'SPE-PRMS and SEC reserves classification: PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), PUD (Proved Undeveloped), Probable (2P), or Possible (3P). Critical for SEC reserves disclosure and financial reporting.. Valid values are `proved_developed_producing|proved_developed_non_producing|proved_undeveloped|probable|possible`',
    `simulation_model_name` STRING COMMENT 'The name or identifier of the reservoir simulation model (e.g., Schlumberger Petrel, Eclipse) used to generate this production forecast. Provides traceability to the technical basis for the forecast.',
    `wor_bbl_per_bbl` DECIMAL(18,2) COMMENT 'The Water-Oil Ratio (WOR) representing the volume of water produced per barrel of oil, measured in Barrels per Barrel (BBL/BBL). Important for waterflood monitoring, artificial lift design, and facility capacity planning.',
    CONSTRAINT pk_production_forecast PRIMARY KEY(`production_forecast_id`)
) COMMENT 'Stores well-level and reservoir-level production forecasts used for reserves booking, development planning, and economic evaluation. Captures forecast type (deterministic/probabilistic/simulation-based), forecast period start/end, decline curve parameters (initial rate, decline rate, b-factor, decline type), forecast oil rate profile, forecast gas rate profile, forecast water rate profile, EUR oil, EUR gas, EUR NGL, forecast method (DCA/simulation/analogy), confidence level (P10/P50/P90), effective date, and approving engineer. Supports SEC reserves disclosure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` (
    `eor_scheme_id` BIGINT COMMENT 'Unique identifier for the Enhanced Oil Recovery or Improved Oil Recovery scheme record.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: EOR schemes require AFE authorization for injection wells, facilities, and injectant procurement. Links estimated_capex_usd and estimated_opex_usd to approved AFE budgets for cost control and financia',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: EOR schemes require specific facility infrastructure (injection facilities, separation equipment). EOR project feasibility depends on facility capacity; CAPEX planning for facility modifications requi',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: EOR schemes have multi-year budgets for injection operations, monitoring, and incremental production. Business process: annual budgeting, variance analysis, working interest billing, and reserves book',
    `commercial_counterparty_id` BIGINT COMMENT 'Foreign key reference to the operating company responsible for executing the EOR scheme under the Joint Operating Agreement (JOA).',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: EOR programs require dedicated long-term sales contracts to justify capital investment (estimated_capex_usd, npv_usd fields). FID decisions for EOR schemes depend on secured offtake contracts. Standar',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Material EOR schemes trigger SEC reserves disclosures (proved developed reserves changes), environmental impact statements, and regulatory approval filings. Links EOR project approvals to formal regul',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: EOR schemes often have master service agreements for chemical supply, steam generation, or CO2 supply. Links EOR programs to contract terms, pricing, performance bonds, and commercial counterparty obl',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: EOR programs require environmental monitoring for groundwater protection (injection fluid migration), induced seismicity detection, surface emissions tracking (CO2, VOCs), and regulatory compliance wi',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: EOR projects are major capital programs requiring AFE authorization. Business process: EOR project approval, capital tracking, reserves booking for incremental recovery, and working interest billing. ',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: EOR programs require comprehensive HSE risk assessment (HAZOP, LOPA, quantitative risk assessment) before deployment for regulatory approval, project sanction, and operational readiness. Assessment co',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: EOR programs require lease-level approval for surface use rights, injection operations, and royalty rate adjustments. Lease agreements often contain specific EOR provisions governing cost recovery, in',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: EOR schemes require environmental and operational permits for chemical injection, steam generation, or CO2 injection. The existing environmental_permit_number is a denormalized string; proper FK enabl',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the reservoir engineer or technical professional responsible for the design, monitoring, and optimization of the EOR scheme.',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the target reservoir where the EOR scheme is being applied.',
    `simulation_model_id` BIGINT COMMENT 'Foreign key reference to the Schlumberger Petrel or other reservoir simulation model used to design and forecast the EOR scheme performance.',
    `actual_end_date` DATE COMMENT 'Actual date when the EOR scheme was completed, suspended, or abandoned. Null if scheme is still active.',
    `approval_date` DATE COMMENT 'Date when the EOR scheme was formally approved by the joint venture partners or management for implementation.',
    `comments` STRING COMMENT 'Free-text field for additional notes, lessons learned, operational challenges, or special considerations related to the EOR scheme.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this EOR scheme record was first created in the system.',
    `deployment_scope` STRING COMMENT 'Geographic and operational scale of the EOR scheme: pilot (limited test area), pattern (specific injection-production pattern), or full-field (entire reservoir coverage).. Valid values are `pilot|pattern|full_field`',
    `design_injection_pressure_psi` DECIMAL(18,2) COMMENT 'Target injection pressure in pounds per square inch (PSI) at the wellhead or downhole, designed to maintain reservoir pressure and optimize sweep efficiency.',
    `design_injection_rate_bpd` DECIMAL(18,2) COMMENT 'Planned daily injection rate in barrels per day (BPD) for water, steam, gas, or chemical injectant as specified in the EOR scheme design.',
    `eor_type` STRING COMMENT 'Classification of the Enhanced Oil Recovery method employed. WAG (Water Alternating Gas), SAGD (Steam-Assisted Gravity Drainage), CSS (Cyclic Steam Stimulation), polymer flood, CO2 flood, surfactant flood, steam flood, in-situ combustion, nitrogen injection, or microbial EOR. [ENUM-REF-CANDIDATE: WAG|SAGD|CSS|polymer_flood|CO2_flood|surfactant_flood|steam_flood|in_situ_combustion|nitrogen_injection|microbial — 10 candidates stripped; promote to reference product]',
    `estimated_capex_usd` DECIMAL(18,2) COMMENT 'Total estimated capital expenditure in US dollars for the EOR scheme, including well conversions, injection facilities, pipelines, and equipment.',
    `estimated_opex_usd_per_year` DECIMAL(18,2) COMMENT 'Estimated annual operating expenditure in US dollars for the EOR scheme, including injectant costs, energy, labor, and maintenance.',
    `field_code` BIGINT COMMENT 'Foreign key reference to the oil or gas field containing the target reservoir for this EOR scheme.',
    `injectant_source` STRING COMMENT 'Description of the source or supply point for the injectant (e.g., produced water recycling facility, CO2 pipeline, steam generation plant, chemical supplier).',
    `injectant_type` STRING COMMENT 'Primary substance or chemical being injected into the reservoir for the EOR scheme: water, steam, CO2, nitrogen, natural gas, polymer solution, surfactant, alkaline, microbial culture, or hydrocarbon solvent. [ENUM-REF-CANDIDATE: water|steam|CO2|nitrogen|natural_gas|polymer|surfactant|alkaline|microbial|solvent — 10 candidates stripped; promote to reference product]',
    `irr_percent` DECIMAL(18,2) COMMENT 'Internal rate of return for the EOR scheme expressed as a percentage, used for investment decision-making and portfolio optimization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this EOR scheme record was last updated, reflecting changes to status, performance data, or scheme parameters.',
    `npv_usd` DECIMAL(18,2) COMMENT 'Net present value of the EOR scheme in US dollars, calculated using discounted cash flow (DCF) analysis at the corporate discount rate.',
    `number_of_injection_wells` STRING COMMENT 'Total count of active injection wells dedicated to this EOR scheme.',
    `number_of_production_wells` STRING COMMENT 'Total count of production wells associated with this EOR scheme that are expected to benefit from the enhanced recovery process.',
    `pattern_type` STRING COMMENT 'Geometric configuration of injection and production wells: five-spot, seven-spot, nine-spot, line drive, peripheral flood, inverted pattern, or custom arrangement. [ENUM-REF-CANDIDATE: five_spot|seven_spot|nine_spot|line_drive|peripheral|inverted|custom — 7 candidates stripped; promote to reference product]',
    `planned_end_date` DATE COMMENT 'Forecasted date for completion or termination of the EOR scheme based on reservoir simulation and economic modeling.',
    `reserves_category` STRING COMMENT 'SPE-PRMS reserves classification for incremental oil attributed to the EOR scheme: PDP (Proved Developed Producing), PUD (Proved Undeveloped), PDNP (Proved Developed Non-Producing), probable, or possible.. Valid values are `PDP|PUD|PDNP|probable|possible`',
    `scheme_code` STRING COMMENT 'Unique alphanumeric code assigned to the EOR scheme for system identification and cross-referencing with AFE and JIB records.',
    `scheme_name` STRING COMMENT 'Business name or designation of the Enhanced Oil Recovery scheme for operational reference and reporting.',
    `scheme_status` STRING COMMENT 'Current lifecycle status of the EOR scheme: design (planning phase), pilot (small-scale test), active (full-field implementation), suspended (temporarily halted), abandoned (permanently discontinued), or completed (objectives achieved and closed).. Valid values are `design|pilot|active|suspended|abandoned|completed`',
    `sec_reporting_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether the incremental reserves from this EOR scheme are eligible for SEC reserves disclosure under Regulation S-K Item 1200.',
    `start_date` DATE COMMENT 'Date when the EOR scheme commenced injection operations or pilot testing.',
    `steam_oil_ratio_sor` DECIMAL(18,2) COMMENT 'Ratio of steam injected (in barrels of cold water equivalent) to oil produced (in barrels) for thermal EOR schemes (SAGD, CSS, steam flood). Key performance indicator for thermal efficiency.',
    `target_incremental_oil_boe` DECIMAL(18,2) COMMENT 'Target incremental oil production in barrels of oil equivalent (BOE) for schemes that also produce associated gas.',
    `target_incremental_oil_mstb` DECIMAL(18,2) COMMENT 'Target incremental oil production in thousands of stock tank barrels (MSTB) expected from the EOR scheme over its lifetime.',
    `target_incremental_recovery_factor` DECIMAL(18,2) COMMENT 'Projected increase in recovery factor (as a decimal fraction) expected from the EOR scheme beyond primary and secondary recovery. Used for EUR estimation and reserves booking.',
    `wag_ratio` DECIMAL(18,2) COMMENT 'Ratio of water to gas injection volumes for WAG schemes. Expressed as water volume divided by gas volume. Null for non-WAG schemes.',
    CONSTRAINT pk_eor_scheme PRIMARY KEY(`eor_scheme_id`)
) COMMENT 'Master record for Enhanced Oil Recovery (EOR) and Improved Oil Recovery (IOR) programs. Captures EOR type (WAG/SAGD/CSS/polymer flood/CO2 flood/surfactant/steam flood/in-situ combustion), scheme name, target reservoir, pilot vs full-field status, start date, design injection parameters, target incremental recovery factor, target incremental oil (MSTB), thermal ratios (SOR for thermal, WAG ratio), injection pressure, scheme status (design/pilot/active/suspended/abandoned), and technical lead. Parent entity for all injection events and EOR performance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`injection_event` (
    `injection_event_id` BIGINT COMMENT 'Primary key for injection_event',
    `employee_id` BIGINT COMMENT 'Reference to the operating company or joint venture partner responsible for executing this injection event. Links to the operator master data.',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Injection operations require environmental monitoring for induced seismicity (microseismic monitoring), groundwater protection (observation well sampling), surface emissions (fugitive methane, CO2), a',
    `eor_scheme_id` BIGINT COMMENT 'Reference to the parent EOR/IOR program or scheme under which this injection event was executed. Links to the EOR scheme master data.',
    `injection_well_id` BIGINT COMMENT 'Reference to the well asset through which the injection occurred. Links to the well asset master data.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Injected fluids (water, gas, chemicals, polymers, steam) are procured materials tracked in material master for inventory, cost allocation, and HSE compliance. Links injection volumes to material speci',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Injection activities must operate under UIC permits from EPA or state authorities. The existing environmental_permit_number is a denormalized string; proper FK enables tracking permit compliance, inje',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: EOR injection operations (water, gas, steam, chemical) require PTW due to high-pressure injection, chemical handling hazards, equipment isolation needs, and SIMOPS coordination with adjacent productio',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir into which the injection occurred. Links to the reservoir master data for subsurface characterization.',
    `afe_number` STRING COMMENT 'AFE number authorizing the capital or operating expenditure for this injection event. Links to financial authorization and joint interest billing.',
    `cumulative_injection_bbl` DECIMAL(18,2) COMMENT 'Total cumulative volume of liquid injected into this well from the start of the EOR scheme through this event, measured in barrels.',
    `cumulative_injection_mcf` DECIMAL(18,2) COMMENT 'Total cumulative volume of gas injected into this well from the start of the EOR scheme through this event, measured in thousand cubic feet.',
    `cycle_number` STRING COMMENT 'Sequential cycle number for cyclic injection processes such as CSS (Cyclic Steam Stimulation) or WAG (Water Alternating Gas). Null for continuous injection schemes.',
    `cycle_phase` STRING COMMENT 'The phase within a cyclic EOR process during which this injection event occurred. Applicable to CSS and other cyclic methods.. Valid values are `INJECTION|SOAK|PRODUCTION|IDLE`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated data quality score for this injection event record, ranging from 0 to 100. Based on completeness, accuracy, and consistency checks.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this injection event data was captured (e.g., OSIsoft PI System, Avocet Production Operations, Schlumberger Petrel).',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours of unplanned downtime or interruption during the injection event. Used for operational efficiency analysis and NPT (Non-Productive Time) tracking.',
    `downtime_reason` STRING COMMENT 'Description of the cause of any downtime during the injection event. Supports root cause analysis and continuous improvement.',
    `eor_method_type` STRING COMMENT 'The specific EOR/IOR technique employed for this injection event. Classifies the recovery method according to SPE standards. [ENUM-REF-CANDIDATE: WAG|SAGD|CSS|CO2_FLOOD|POLYMER_FLOOD|STEAM_FLOOD|WATER_FLOOD|GAS_INJECTION|CHEMICAL_INJECTION|MICROBIAL — 10 candidates stripped; promote to reference product]',
    `hse_incident_description` STRING COMMENT 'Detailed description of any HSE incident that occurred during the injection event. Null if no incident occurred.',
    `hse_incident_flag` BOOLEAN COMMENT 'Boolean indicator of whether any HSE incident occurred during this injection event. True if an incident was reported, false otherwise.',
    `injected_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of liquid injected during this event, measured in barrels. Used for water, steam, and liquid chemical injections.',
    `injected_volume_mcf` DECIMAL(18,2) COMMENT 'Total volume of gas injected during this event, measured in thousand cubic feet. Used for CO2, natural gas, and nitrogen injections.',
    `injection_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for this injection event, including fluid costs, energy, labor, and equipment. Used for OPEX (Operating Expenditure) tracking and economic analysis.',
    `injection_date` DATE COMMENT 'The calendar date on which the injection event occurred. Primary business event timestamp for production reporting and performance tracking.',
    `injection_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the injection event in hours. Calculated from start and end timestamps or recorded directly from operational systems.',
    `injection_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the injection event concluded. Used to calculate injection duration and operational efficiency.',
    `injection_event_number` STRING COMMENT 'Business-assigned unique identifier or tracking number for the injection event, used for operational reporting and cross-system reference.',
    `injection_pressure_psi` DECIMAL(18,2) COMMENT 'Average wellhead injection pressure during the event, measured in pounds per square inch. Critical for reservoir pressure maintenance and fracture risk management.',
    `injection_quality_flag` STRING COMMENT 'Quality indicator for the injected fluid. Flags deviations from specification that may impact EOR performance or reservoir integrity.. Valid values are `NORMAL|OFF_SPEC|CONTAMINATED|DEGRADED|UNKNOWN`',
    `injection_rate_bopd` DECIMAL(18,2) COMMENT 'Average injection rate for liquid fluids during this event, expressed in barrels per day. Key operational parameter for EOR optimization.',
    `injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Average injection rate for gas fluids during this event, expressed in thousand cubic feet per day. Critical for gas injection EOR schemes.',
    `injection_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the injection event began. Used for detailed operational analysis and SCADA integration.',
    `injection_temperature_f` DECIMAL(18,2) COMMENT 'Temperature of the injected fluid at the wellhead, measured in degrees Fahrenheit. Particularly important for thermal EOR methods like SAGD and CSS.',
    `operational_status` STRING COMMENT 'Current operational status of the injection event. Tracks the lifecycle state from planning through completion or termination.. Valid values are `COMPLETED|IN_PROGRESS|SUSPENDED|ABORTED|PLANNED`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection event record was first created in the data system. Audit trail for data lineage and compliance.',
    `record_updated_by` STRING COMMENT 'User or system identifier that last modified this injection event record. Supports audit trail and data stewardship accountability.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection event record was last modified. Audit trail for data lineage and change tracking.',
    `remarks` STRING COMMENT 'Free-text field for operational notes, observations, or special conditions related to this injection event. Supports operational knowledge capture.',
    `simulated_injection_volume_bbl` DECIMAL(18,2) COMMENT 'Predicted injection volume from reservoir simulation model (e.g., Schlumberger Petrel). Used for variance analysis between actual and simulated performance.',
    `variance_to_simulation_pct` DECIMAL(18,2) COMMENT 'Percentage variance between actual injection volume and simulated prediction. Key metric for reservoir model calibration and EOR optimization.',
    CONSTRAINT pk_injection_event PRIMARY KEY(`injection_event_id`)
) COMMENT 'Captures individual injection events within EOR/IOR schemes including WAG cycles, steam injection cycles (SAGD/CSS), CO2 injection slugs, and polymer injection batches. Records injection date, injection well, EOR scheme reference, injected fluid type, injected volume (BBL or MCF), injection pressure, injection temperature, injection rate (BOPD/MCFD), cycle number (for cyclic processes), cumulative injection to date, and operational status. Enables EOR performance monitoring and optimization against simulation predictions.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` (
    `aquifer_model_id` BIGINT COMMENT 'Unique identifier for the aquifer characterization and influx model record. Primary key for the aquifer model entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Aquifer models impact reserves estimates and waterflood design; require qualified reservoir engineer accountability. Links model to engineer for technical peer review, competency verification, and suc',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the parent reservoir that this aquifer model supports. Links aquifer characterization to the reservoir entity.',
    `aquifer_compressibility` DECIMAL(18,2) COMMENT 'Total compressibility of the aquifer system in 1/psi or 1/bar, including rock and water compressibility. Critical parameter for unsteady-state aquifer models.',
    `aquifer_compressibility_unit` STRING COMMENT 'Unit of measure for aquifer compressibility. Typically reciprocal pressure units.. Valid values are `1/psi|1/bar|1/kPa`',
    `aquifer_encroachment_angle` DECIMAL(18,2) COMMENT 'Angle in degrees representing the fraction of the reservoir perimeter in contact with the aquifer. 360 degrees indicates full radial aquifer, smaller angles indicate partial aquifer contact.',
    `aquifer_geometry` STRING COMMENT 'Geometric configuration of the aquifer relative to the reservoir. Radial indicates aquifer surrounds reservoir, linear indicates aquifer extends along one edge, bottom indicates aquifer underlies reservoir, edge/peripheral indicates aquifer contacts reservoir along specific boundaries.. Valid values are `Radial|Linear|Bottom|Edge|Peripheral`',
    `aquifer_initial_pressure` DECIMAL(18,2) COMMENT 'Initial pressure of the aquifer at the aquifer-reservoir contact depth, expressed in psi or bar. Typically equals or slightly exceeds initial reservoir pressure.',
    `aquifer_model_type` STRING COMMENT 'Mathematical model type used to characterize aquifer behavior and water influx. Schilthuis for steady-state, van Everdingen-Hurst for unsteady-state radial flow, Carter-Tracy for modified unsteady-state, Fetkovich for pseudo-steady-state, or numerical simulation approaches.. Valid values are `Schilthuis|van Everdingen-Hurst|Carter-Tracy|Fetkovich|Analytical|Numerical`',
    `aquifer_name` STRING COMMENT 'Business name or designation for the aquifer model, typically referencing the geological formation or field location.',
    `aquifer_outer_radius` DECIMAL(18,2) COMMENT 'Outer boundary radius of the aquifer in feet or meters, representing the extent of the water-bearing formation. Critical parameter for radial aquifer models.',
    `aquifer_permeability` DECIMAL(18,2) COMMENT 'Average horizontal permeability of the aquifer rock in millidarcies (mD). Controls the rate at which water can flow from the aquifer into the reservoir.',
    `aquifer_permeability_unit` STRING COMMENT 'Unit of measure for aquifer permeability. Typically millidarcies (mD) or darcies (D).. Valid values are `mD|D`',
    `aquifer_porosity` DECIMAL(18,2) COMMENT 'Average porosity of the aquifer rock expressed as a fraction (0-1) or percentage. Represents the pore volume available for water storage in the aquifer.',
    `aquifer_pressure_unit` STRING COMMENT 'Unit of measure for aquifer pressure. Typically pounds per square inch (psi), bar, or kilopascals (kPa).. Valid values are `psi|bar|kPa`',
    `aquifer_productivity_index` DECIMAL(18,2) COMMENT 'Productivity index of the aquifer in barrels per day per psi (bbl/day/psi), representing the rate of water influx per unit pressure differential. Used in Fetkovich aquifer models.',
    `aquifer_radius_unit` STRING COMMENT 'Unit of measure for aquifer radius dimensions. Typically feet (ft) in US operations or meters (m) in international operations.. Valid values are `ft|m`',
    `aquifer_strength_classification` STRING COMMENT 'Qualitative assessment of aquifer drive strength based on water influx rate relative to reservoir production. Strong aquifers maintain reservoir pressure, weak aquifers provide minimal pressure support.. Valid values are `Strong|Moderate|Weak|Negligible`',
    `aquifer_thickness` DECIMAL(18,2) COMMENT 'Average vertical thickness of the aquifer formation in feet or meters. Used to calculate aquifer pore volume and storage capacity.',
    `aquifer_thickness_unit` STRING COMMENT 'Unit of measure for aquifer thickness. Typically feet (ft) in US operations or meters (m) in international operations.. Valid values are `ft|m`',
    `aquifer_water_formation_volume_factor` DECIMAL(18,2) COMMENT 'Formation volume factor for aquifer water (Bw), representing the ratio of water volume at reservoir conditions to volume at standard conditions. Dimensionless or RB/STB.',
    `aquifer_water_viscosity` DECIMAL(18,2) COMMENT 'Viscosity of aquifer water at reservoir conditions, expressed in centipoise (cP). Used in flow calculations for aquifer influx models.',
    `comments` STRING COMMENT 'Free-text field for additional notes, assumptions, limitations, or special considerations related to the aquifer model.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this aquifer model record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cumulative_water_influx` DECIMAL(18,2) COMMENT 'Total cumulative volume of water that has entered the reservoir from the aquifer since production began, expressed in reservoir barrels (RB) or stock tank barrels (STB). Key parameter for material balance calculations.',
    `cumulative_water_influx_unit` STRING COMMENT 'Unit of measure for cumulative water influx volume. Reservoir barrels (RB), stock tank barrels (STB), or cubic meters (m3).. Valid values are `RB|STB|m3`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this aquifer model record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `material_balance_integration_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this aquifer model is integrated into the reservoir material balance calculations for reserves estimation and production forecasting.',
    `model_approval_date` DATE COMMENT 'Date when the aquifer model was formally approved for use in reserves estimation, production forecasting, or development planning. Format: yyyy-MM-dd.',
    `model_calibration_date` DATE COMMENT 'Date when the aquifer model parameters were last calibrated against historical production and pressure data. Format: yyyy-MM-dd.',
    `model_calibration_method` STRING COMMENT 'Description of the methodology used to calibrate the aquifer model, such as history matching against pressure decline data, material balance analysis, or numerical simulation.',
    `model_confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the aquifer model parameters and predictions based on data quality, calibration fit, and geological understanding.. Valid values are `High|Medium|Low`',
    `model_status` STRING COMMENT 'Current lifecycle status of the aquifer model. Active models are used in current forecasts, Under Review models are being updated, Superseded models have been replaced by newer versions, Archived models are retained for historical reference.. Valid values are `Active|Under Review|Superseded|Archived`',
    `model_version` STRING COMMENT 'Version identifier for the aquifer model, tracking iterations and updates over time (e.g., v1.0, v2.1).',
    `simulation_software` STRING COMMENT 'Name and version of the reservoir simulation or aquifer modeling software used to develop this model (e.g., Schlumberger Petrel, Eclipse, CMG).',
    `water_influx_constant` DECIMAL(18,2) COMMENT 'Aquifer influx constant (B) used in Schilthuis steady-state model, relating cumulative water influx to pressure drop. Expressed in reservoir barrels per psi (RB/psi).',
    CONSTRAINT pk_aquifer_model PRIMARY KEY(`aquifer_model_id`)
) COMMENT 'Stores aquifer characterization and influx model parameters for water-drive reservoirs. Captures aquifer model type (Schilthuis/van Everdingen-Hurst/Carter-Tracy/Fetkovich), aquifer geometry (radial/linear/bottom), aquifer outer radius, aquifer thickness, aquifer permeability, aquifer porosity, aquifer compressibility, water influx constant (B), aquifer productivity index, cumulative water influx (We), aquifer strength classification (strong/moderate/weak/negligible), calibration date, and model engineer. Feeds material balance and simulation models.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` (
    `petrophysical_interp_id` BIGINT COMMENT 'Primary key for petrophysical_interp',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Petrophysical interpretations from exploration/appraisal well logs quantify reservoir quality and hydrocarbon volumes. Essential for discovery evaluation, reserves booking, and static model population',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Petrophysical interpretations feed OOIP calculations and reserves estimates; require certified petrophysicist or geoscientist. Links interpretation to employee for competency verification (petrophysic',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir or formation being interpreted. Links to the reservoir master data.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Petrophysical log interpretations are performed on specific reservoir zones. Currently has reservoir_id but not zone_id. The interpreted_zone field is a STRING - this should be normalized to FK. Petro',
    `well_asset_id` BIGINT COMMENT 'Reference to the well for which this petrophysical interpretation was performed. Links to the well asset in the asset domain.',
    `average_hydrocarbon_saturation` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average hydrocarbon saturation across the net pay interval, calculated as 1 minus water saturation, expressed as a decimal fraction (0 to 1).',
    `average_permeability_horizontal` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average horizontal (lateral) permeability across the net pay interval in millidarcies (mD), representing the ability of rock to transmit fluids parallel to bedding.',
    `average_permeability_vertical` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average vertical permeability across the net pay interval in millidarcies (mD), representing the ability of rock to transmit fluids perpendicular to bedding.',
    `average_porosity_effective` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average effective porosity across the net pay interval, expressed as a decimal fraction (0 to 1), representing interconnected pore space available for fluid flow.',
    `average_porosity_total` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average total porosity across the net pay interval, expressed as a decimal fraction (0 to 1), representing all pore space including isolated pores.',
    `average_shale_volume` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average shale volume across the interpreted interval, expressed as a decimal fraction (0 to 1), representing the proportion of non-reservoir rock (clay and shale).',
    `average_water_saturation` DECIMAL(18,2) COMMENT 'Arithmetic or weighted average water saturation across the net pay interval, expressed as a decimal fraction (0 to 1), representing the fraction of pore space occupied by formation water.',
    `comments` STRING COMMENT 'Free-text field for interpreter notes, assumptions, data quality issues, or special considerations relevant to this petrophysical interpretation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this petrophysical interpretation record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `depth_unit_of_measure` STRING COMMENT 'Unit of measure for all depth values in this interpretation record (feet or meters).. Valid values are `ft|m`',
    `gross_thickness` DECIMAL(18,2) COMMENT 'Total thickness of the interpreted interval in feet or meters, calculated as bottom depth minus top depth.',
    `hcpv_unit_of_measure` STRING COMMENT 'Unit of measure for hydrocarbon pore volume: acre-feet, cubic meters, or barrels.. Valid values are `acre-ft|m3|bbl`',
    `hydrocarbon_pore_volume` DECIMAL(18,2) COMMENT 'Total hydrocarbon-filled pore volume for this interpreted interval, calculated as net pay thickness × effective porosity × hydrocarbon saturation × area, typically in acre-feet or cubic meters.',
    `interpretation_date` DATE COMMENT 'Date when this petrophysical interpretation was completed and finalized, in yyyy-MM-dd format.',
    `interpretation_method` STRING COMMENT 'Petrophysical interpretation method or model used to calculate water saturation and reservoir properties (e.g., Archie, Simandoux, Waxman-Smits for shaly sands).. Valid values are `Archie|Simandoux|Waxman-Smits|Indonesia|Dual Water|Total Shale`',
    `interpretation_name` STRING COMMENT 'Business-friendly name or label for this petrophysical interpretation run, typically including well name, zone, and date for identification purposes.',
    `interpretation_status` STRING COMMENT 'Current lifecycle status of this petrophysical interpretation indicating its approval state and usability for reserves calculations and production forecasting.. Valid values are `draft|preliminary|final|approved|superseded`',
    `interval_bottom_depth_md` DECIMAL(18,2) COMMENT 'Measured depth in feet or meters to the bottom of the interpreted interval along the wellbore trajectory.',
    `interval_bottom_depth_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet or meters to the bottom of the interpreted interval, corrected for wellbore deviation.',
    `interval_top_depth_md` DECIMAL(18,2) COMMENT 'Measured depth in feet or meters to the top of the interpreted interval along the wellbore trajectory.',
    `interval_top_depth_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet or meters to the top of the interpreted interval, corrected for wellbore deviation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this petrophysical interpretation record was last updated or modified, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `net_pay_thickness` DECIMAL(18,2) COMMENT 'Cumulative thickness of reservoir rock within the interval that meets cutoff criteria for porosity, water saturation, and shale volume, representing producible hydrocarbon-bearing rock.',
    `net_to_gross_ratio` DECIMAL(18,2) COMMENT 'Ratio of net pay thickness to gross thickness, expressed as a decimal fraction (0 to 1), indicating the proportion of the interval that is productive reservoir rock.',
    `permeability_unit_of_measure` STRING COMMENT 'Unit of measure for permeability values: millidarcies (mD), darcies (D), or nanodarcies (nD).. Valid values are `mD|D|nD`',
    `porosity_cutoff` DECIMAL(18,2) COMMENT 'Minimum effective porosity threshold applied to define net pay, expressed as a decimal fraction. Rock below this porosity is excluded from net pay calculations.',
    `quality_flag` STRING COMMENT 'Qualitative assessment of the interpretation quality based on log quality, data availability, and confidence in the results.. Valid values are `excellent|good|fair|poor|uncertain`',
    `shale_volume_cutoff` DECIMAL(18,2) COMMENT 'Maximum shale volume threshold applied to define net pay, expressed as a decimal fraction. Rock above this shale volume is excluded from net pay calculations.',
    `software_used` STRING COMMENT 'Name and version of the petrophysical interpretation software application used to perform this analysis (e.g., Landmark DecisionSpace Geosciences, Schlumberger Techlog, Paradigm Geolog).',
    `water_saturation_cutoff` DECIMAL(18,2) COMMENT 'Maximum water saturation threshold applied to define net pay, expressed as a decimal fraction. Rock above this water saturation is excluded from net pay calculations.',
    CONSTRAINT pk_petrophysical_interp PRIMARY KEY(`petrophysical_interp_id`)
) COMMENT 'Stores petrophysical log interpretation results for wells within a reservoir, providing the subsurface property inputs for volumetric calculations. Captures well identifier, interpreted interval top/bottom depth, gross pay, net pay, net-to-gross ratio, average porosity (total/effective), average water saturation (Sw), average permeability (horizontal/vertical), shale volume (Vsh), hydrocarbon pore volume (HCPV), interpretation method, cutoff criteria applied (porosity/Sw/Vsh cutoffs), software used (Landmark DecisionSpace), and interpretation date.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` (
    `pressure_history_id` BIGINT COMMENT 'Primary key for pressure_history',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Pressure history analysis drives reservoir management decisions and reserves revisions; requires qualified reservoir engineer. Links analysis to employee for approval workflow (approved_by references ',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir for which pressure history is recorded. Links this pressure observation to the specific subsurface reservoir being monitored.',
    `simulation_model_id` BIGINT COMMENT 'Foreign key linking to reservoir.simulation_model. Business justification: Pressure history records reference simulation_model_name as a STRING attribute, but lack the FK relationship. Pressure history is used to validate simulation model history match quality. The model nam',
    `analysis_date` DATE COMMENT 'The date on which the pressure history analysis was performed or the record was created in the system.',
    `approval_date` DATE COMMENT 'The date on which the pressure history record was formally approved for use in reserves estimation and regulatory reporting.',
    `approval_status` STRING COMMENT 'The current approval workflow status of the pressure history record. Indicates whether the data is in draft, has been submitted for review, approved for use in reserves estimation, or rejected.. Valid values are `draft|submitted|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the senior reservoir engineer or technical authority who approved this pressure history record for use in reserves reporting and production forecasting.',
    `average_reservoir_pressure_psia` DECIMAL(18,2) COMMENT 'The volumetric average reservoir pressure for the reporting period, measured in pounds per square inch absolute. This is the primary pressure metric used for material balance calculations and reserves estimation.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or explanations regarding the pressure measurement, data quality issues, or special circumstances affecting the pressure history.',
    `confidence_level` STRING COMMENT 'The level of confidence in the accuracy and representativeness of the reported reservoir pressure. Based on measurement quality, number of data points, and consistency with material balance.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pressure history record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `cumulative_gas_production_mcf` DECIMAL(18,2) COMMENT 'Total cumulative gas production from the reservoir as of the reporting period end date, measured in thousand cubic feet. Essential for gas reservoir material balance and pressure depletion modeling.',
    `cumulative_injection_bbl` DECIMAL(18,2) COMMENT 'Total cumulative volume of fluids injected into the reservoir for pressure maintenance or enhanced oil recovery as of the reporting period end date, measured in barrels.',
    `cumulative_oil_production_bbl` DECIMAL(18,2) COMMENT 'Total cumulative oil production from the reservoir as of the reporting period end date, measured in barrels. Used for material balance calculations and pressure decline analysis.',
    `cumulative_production_boe` DECIMAL(18,2) COMMENT 'Total cumulative hydrocarbon production from the reservoir expressed in barrels of oil equivalent, combining oil, gas, and natural gas liquids using standard conversion factors.',
    `cumulative_water_production_bbl` DECIMAL(18,2) COMMENT 'Total cumulative water production from the reservoir as of the reporting period end date, measured in barrels. Important for aquifer influx analysis and pressure support evaluation.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and validation status of the pressure data. Flags data that has been verified, is suspect due to measurement issues, or is provisional pending further review.. Valid values are `verified|unverified|suspect|estimated|provisional|final`',
    `datum_corrected_pressure_psia` DECIMAL(18,2) COMMENT 'Reservoir pressure corrected to a standard datum depth to enable consistent comparison across wells and time periods. Accounts for hydrostatic pressure differences due to elevation.',
    `datum_depth_ft` DECIMAL(18,2) COMMENT 'The reference depth in feet to which reservoir pressure measurements are corrected. Typically set at the top of the reservoir or a mid-point for consistent pressure comparison.',
    `depletion_rate_psi_per_month` DECIMAL(18,2) COMMENT 'The rate of reservoir pressure decline per month during the reporting period. Calculated as the change in average reservoir pressure divided by the time interval. Critical for forecasting and reserves estimation.',
    `eor_program_active` BOOLEAN COMMENT 'Boolean flag indicating whether an enhanced oil recovery or improved oil recovery program was active during this reporting period. True if EOR/IOR operations were ongoing.',
    `eor_scheme_type` STRING COMMENT 'The specific type of enhanced oil recovery scheme in operation during the reporting period. Includes water alternating gas, steam-assisted gravity drainage, cyclic steam stimulation, polymer flooding, and other tertiary recovery methods. [ENUM-REF-CANDIDATE: wag|sagd|css|polymer|surfactant|co2_flood|steam_flood|microbial|not_applicable — 9 candidates stripped; promote to reference product]',
    `history_match_quality` STRING COMMENT 'Qualitative assessment of how well the simulated pressure data matches observed field measurements. Used to evaluate the reliability of simulation-based pressure forecasts.. Valid values are `excellent|good|fair|poor|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pressure history record was most recently updated or modified. Essential for change tracking and audit compliance.',
    `material_balance_error_percent` DECIMAL(18,2) COMMENT 'The percentage error between observed pressure decline and material balance predicted pressure decline. A key quality metric for reservoir characterization and reserves estimation.',
    `measurement_method` STRING COMMENT 'The specific method or tool used to obtain the pressure measurement. Includes bottom hole pressure gauges, wireline surveys, memory gauges, permanent downhole monitoring systems, or pressure transient tests. [ENUM-REF-CANDIDATE: bottom_hole_gauge|wireline|memory_gauge|permanent_downhole_gauge|buildup_test|falloff_test|material_balance — 7 candidates stripped; promote to reference product]',
    `number_of_wells_measured` STRING COMMENT 'The count of individual wells from which pressure measurements were obtained and averaged to calculate the reservoir average pressure for this reporting period.',
    `pressure_gradient_psi_per_ft` DECIMAL(18,2) COMMENT 'The vertical pressure gradient in the reservoir at the time of measurement, expressed as pressure change per unit depth. Used to correct pressures to datum and assess fluid contacts.',
    `pressure_source_type` STRING COMMENT 'Indicates the origin of the pressure data: measured from well surveys, simulated from reservoir model, interpolated between measurements, extrapolated from trends, history matched from simulation, or estimated using material balance.. Valid values are `measured|simulated|interpolated|extrapolated|history_matched|estimated`',
    `pressure_support_mechanism` STRING COMMENT 'The primary drive mechanism or pressure support system active in the reservoir during this reporting period. Includes natural depletion, aquifer support, gas cap expansion, water injection, gas injection, water alternating gas, steam injection, or chemical enhanced oil recovery. [ENUM-REF-CANDIDATE: natural_depletion|water_drive|gas_cap_drive|solution_gas_drive|water_injection|gas_injection|wag|steam_injection|polymer_flood — 9 candidates stripped; promote to reference product]',
    `pressure_uncertainty_psia` DECIMAL(18,2) COMMENT 'The estimated uncertainty or error range in the reported average reservoir pressure measurement, expressed in psia. Reflects measurement precision and spatial variability.',
    `reporting_frequency` STRING COMMENT 'The frequency at which reservoir pressure is reported for this record. Indicates whether the measurement represents a daily, monthly, quarterly, or annual average.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period for which this average reservoir pressure measurement applies.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period for which this average reservoir pressure measurement applies. Typically monthly, quarterly, or annual intervals.',
    `reserves_category` STRING COMMENT 'The SPE-PRMS reserves classification category applicable to the reservoir at the time of this pressure measurement. Includes proved developed producing, proved developed non-producing, proved undeveloped, probable, and possible reserves.. Valid values are `pdp|pdnp|pud|probable|possible`',
    `simulation_run_date` DATE COMMENT 'The date on which the reservoir simulation was executed to generate or validate this pressure history record. Relevant for simulated or history-matched pressure data.',
    CONSTRAINT pk_pressure_history PRIMARY KEY(`pressure_history_id`)
) COMMENT 'Time-series record of average reservoir pressure decline over the producing life of a reservoir, aggregated from individual well pressure surveys and simulation history matching. Captures reporting period (monthly/quarterly/annual), average reservoir pressure (psia), datum-corrected pressure, pressure source (measured/simulated/interpolated), cumulative production at reporting date (oil/gas/water in BOE), pressure support mechanism active, depletion rate, and data quality flag. Essential for material balance, reserves revisions, and EOR timing decisions.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` (
    `decline_curve_id` BIGINT COMMENT 'Primary key for decline_curve',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Decline curve analysis is engineering cost for reserves evaluation. Business process: cost allocation for reserves evaluation, AFE tracking, and SEC reserves certification cost tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Decline curve analysis is primary method for reserves estimation and SEC reporting; requires certified petroleum engineer. Links DCA to analyst for competency verification (reserves certification), la',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir being analyzed. Links to the reservoir master data for subsurface characterization context.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well for which this decline curve analysis was performed. Links to the well asset master data.',
    `analysis_date` DATE COMMENT 'Date on which the decline curve analysis was completed and results were finalized.',
    `analysis_name` STRING COMMENT 'Business name or label assigned to this decline curve analysis for identification and reference purposes.',
    `analysis_type` STRING COMMENT 'Indicates whether the decline curve analysis is for an individual well or an aggregate of multiple wells at reservoir, field, or zone level.. Valid values are `well|reservoir_aggregate|field_aggregate|zone_aggregate`',
    `approval_date` DATE COMMENT 'Date on which the decline curve analysis was formally approved by the technical authority.',
    `approval_status` STRING COMMENT 'Current approval status of the decline curve analysis in the technical review and approval workflow. Approved analyses feed reserves booking and production planning.. Valid values are `draft|submitted|approved|rejected|superseded`',
    `approver_name` STRING COMMENT 'Name of the senior reservoir engineer or technical authority who approved the decline curve analysis for use in reserves booking and forecasting.',
    `b_factor_hyperbolic_exponent` DECIMAL(18,2) COMMENT 'Hyperbolic decline exponent used in Arps hyperbolic decline equation. Value ranges from 0 (exponential) to 1 (harmonic). Typical shale values are 0.5-2.0. Only applicable for hyperbolic and modified hyperbolic decline types.',
    `comments` STRING COMMENT 'Free-text field for analyst comments, assumptions, limitations, and special considerations related to the decline curve analysis.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the decline curve forecast based on data quality, production history length, and reservoir understanding.. Valid values are `high|medium|low`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this decline curve analysis record was first created in the system. Used for audit trail and data lineage.',
    `cumulative_production_gas_mmcf` DECIMAL(18,2) COMMENT 'Total gas produced from the well or reservoir aggregate up to the forecast start date, measured in million cubic feet.',
    `cumulative_production_ngl_mstb` DECIMAL(18,2) COMMENT 'Total natural gas liquids produced from the well or reservoir aggregate up to the forecast start date, measured in thousand stock tank barrels.',
    `cumulative_production_oil_mstb` DECIMAL(18,2) COMMENT 'Total oil produced from the well or reservoir aggregate up to the forecast start date, measured in thousand stock tank barrels. Used to calculate remaining reserves.',
    `dca_software_name` STRING COMMENT 'Name of the software application used to perform the decline curve analysis, such as Schlumberger Petrel, IHS Harmony, or Aries.',
    `dca_software_version` STRING COMMENT 'Version number of the software application used for the decline curve analysis, important for audit trail and reproducibility.',
    `decline_type` STRING COMMENT 'Mathematical model used for the decline curve analysis. Exponential assumes constant percentage decline, hyperbolic uses variable decline rate with b-factor, harmonic is special case where b=1, and modified hyperbolic transitions from hyperbolic to exponential.. Valid values are `exponential|hyperbolic|harmonic|modified_hyperbolic`',
    `di_initial_decline_rate` DECIMAL(18,2) COMMENT 'Initial decline rate parameter used in Arps decline curve equations, expressed as a decimal fraction per time unit (typically per year). Represents the rate of production decline at the start of the forecast.',
    `economic_limit_rate_bopd` DECIMAL(18,2) COMMENT 'Minimum production rate at which the well or reservoir remains economically viable. Production below this rate results in negative cash flow and triggers abandonment consideration.',
    `eur_boe_mstb` DECIMAL(18,2) COMMENT 'Total estimated ultimate recovery expressed in thousand barrels of oil equivalent, combining oil, gas (converted at 6:1 ratio), and NGL volumes for unified reporting.',
    `eur_gas_mmcf` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of natural gas from the well or reservoir aggregate over its entire economic life, measured in million cubic feet.',
    `eur_ngl_mstb` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of natural gas liquids from the well or reservoir aggregate over its entire economic life, measured in thousand stock tank barrels.',
    `eur_oil_mstb` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of oil from the well or reservoir aggregate over its entire economic life, measured in thousand stock tank barrels. Key output of decline curve analysis used for reserves booking.',
    `forecast_end_date` DATE COMMENT 'The date at which the decline curve forecast terminates, typically when production reaches the economic limit rate or the well reaches its abandonment date.',
    `forecast_start_date` DATE COMMENT 'The date from which the decline curve forecast begins. Typically the first production date or the date of the most recent production data used to calibrate the curve.',
    `ip_gas_mcfd` DECIMAL(18,2) COMMENT 'Initial gas production rate at the start of the decline curve forecast period, measured in thousand cubic feet per day.',
    `ip_ngl_bopd` DECIMAL(18,2) COMMENT 'Initial natural gas liquids production rate at the start of the decline curve forecast period, measured in barrels per day.',
    `ip_oil_bopd` DECIMAL(18,2) COMMENT 'Initial oil production rate at the start of the decline curve forecast period, measured in barrels of oil per day. Critical parameter for EUR estimation.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this decline curve analysis record was last updated. Used for audit trail and change tracking.',
    `prms_reserves_category` STRING COMMENT 'SPE-PRMS reserves classification category. 1P represents proved reserves, 2P represents proved plus probable, and 3P represents proved plus probable plus possible reserves.. Valid values are `1P|2P|3P|proved|probable|possible`',
    `production_history_months` STRING COMMENT 'Number of months of historical production data used to calibrate the decline curve model. Longer history typically improves forecast reliability.',
    `r_squared_fit_quality` DECIMAL(18,2) COMMENT 'Statistical measure of how well the decline curve model fits the historical production data, ranging from 0 to 1. Higher values indicate better fit quality.',
    `remaining_reserves_gas_mmcf` DECIMAL(18,2) COMMENT 'Remaining gas reserves calculated as EUR minus cumulative production, measured in million cubic feet.',
    `remaining_reserves_ngl_mstb` DECIMAL(18,2) COMMENT 'Remaining natural gas liquids reserves calculated as EUR minus cumulative production, measured in thousand stock tank barrels.',
    `remaining_reserves_oil_mstb` DECIMAL(18,2) COMMENT 'Remaining oil reserves calculated as EUR minus cumulative production, measured in thousand stock tank barrels. Used for SEC and SPE-PRMS reserves classification.',
    `sec_reserves_category` STRING COMMENT 'SEC reserves classification. PDP is Proved Developed Producing, PDNP is Proved Developed Non-Producing, and PUD is Proved Undeveloped. Used for financial reporting and disclosure.. Valid values are `PDP|PDNP|PUD`',
    `terminal_decline_rate` DECIMAL(18,2) COMMENT 'Final decline rate at which the well or reservoir is assumed to decline for the remainder of its economic life. Used in modified hyperbolic models to transition from hyperbolic to exponential decline.',
    CONSTRAINT pk_decline_curve PRIMARY KEY(`decline_curve_id`)
) COMMENT 'Stores Decline Curve Analysis (DCA) parameters for individual wells and reservoir aggregates used in EUR estimation and production forecasting. Captures well or reservoir identifier, decline type (exponential/hyperbolic/harmonic), initial production rate (IP), initial decline rate (Di), hyperbolic exponent (b-factor), terminal decline rate, EUR oil (MSTB), EUR gas (MMCF), EUR NGL (MSTB), forecast start date, forecast end date, economic limit rate, DCA software used, analyst name, and approval status. Feeds reserves booking and production planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` (
    `surveillance_plan_id` BIGINT COMMENT 'Primary key for surveillance_plan',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Surveillance plans track budget_allocated_usd and budget_spent_usd against AFE authorizations for pressure surveys, well tests, fluid sampling, and 4D seismic. Essential for reservoir monitoring cost ',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Surveillance activities are facility-based (well testing facilities, lab facilities, field offices). Surveillance budget allocation by facility, resource scheduling, and equipment availability plannin',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Surveillance plans have annual budgets for pressure surveys, tests, and monitoring. Business process: annual surveillance budget approval, cost tracking, and variance analysis. Complements existing bu',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Reservoir surveillance plans incorporate HSE risk assessments for planned activities (well interventions, pressure surveys, fluid sampling, tracer tests) to ensure safe execution, PTW requirements ide',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which this surveillance plan is defined. Links to the reservoir master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Surveillance plans define reservoir monitoring strategy and budget allocation; require designated accountable engineer. Links plan to employee for budget approval workflows, competency verification (r',
    `approval_date` DATE COMMENT 'Date when the surveillance plan was formally approved by management or the technical authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or authority who approved the surveillance plan.',
    `budget_allocated_usd` DECIMAL(18,2) COMMENT 'Total budget allocated for executing all surveillance activities defined in this plan, expressed in US dollars.',
    `budget_spent_usd` DECIMAL(18,2) COMMENT 'Cumulative amount spent to date on surveillance activities under this plan, expressed in US dollars.',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the surveillance plan that do not fit into other structured fields.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this surveillance plan record was first created in the system.',
    `data_integration_system` STRING COMMENT 'Name of the software system or platform used to integrate and analyze surveillance data (e.g., Schlumberger Petrel, OSIsoft PI System).',
    `data_quality_requirements` STRING COMMENT 'Specification of data quality standards and acceptance criteria for surveillance data collected under this plan.',
    `effective_date` DATE COMMENT 'Date when the surveillance plan becomes active and surveillance activities commence.',
    `eor_program_type` STRING COMMENT 'Type of EOR or IOR program being monitored by this surveillance plan, if applicable. Includes WAG (Water Alternating Gas), SAGD (Steam-Assisted Gravity Drainage), CSS (Cyclic Steam Stimulation), and other methods. [ENUM-REF-CANDIDATE: wag|sagd|css|polymer_flood|co2_injection|steam_flood|none — 7 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'Date when the surveillance plan is scheduled to end or requires renewal. Nullable for ongoing plans.',
    `fluid_sampling_frequency` STRING COMMENT 'Planned frequency for collecting reservoir fluid samples for PVT analysis and fluid characterization.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    `key_performance_indicators` STRING COMMENT 'List or description of key performance indicators that will be tracked and reported as part of the surveillance plan (e.g., reservoir pressure decline rate, GOR trends, water cut increase).',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this surveillance plan record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when the surveillance plan was last reviewed for effectiveness, accuracy, and alignment with reservoir management objectives.',
    `model_update_frequency` STRING COMMENT 'Planned frequency for updating the reservoir simulation model based on surveillance data collected.. Valid values are `quarterly|semi_annual|annual|biennial|on_demand`',
    `next_review_date` DATE COMMENT 'Date when the next formal review of the surveillance plan is scheduled.',
    `plan_code` STRING COMMENT 'Unique business code or identifier assigned to the surveillance plan for tracking and reference.',
    `plan_name` STRING COMMENT 'Business name or title of the surveillance plan, used for identification and reporting purposes.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the surveillance plan indicating its operational state.. Valid values are `draft|approved|active|suspended|completed|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the surveillance plan based on its purpose and scope (routine monitoring, special study, EOR program monitoring, regulatory compliance, or integrated surveillance).. Valid values are `routine|special|eor_monitoring|reservoir_study|regulatory_compliance|integrated`',
    `pressure_survey_frequency` STRING COMMENT 'Planned frequency for conducting reservoir pressure surveys as part of the surveillance program.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand|continuous`',
    `production_logging_frequency` STRING COMMENT 'Planned frequency for running production logging tools to assess zonal contributions and well performance.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or authority requiring surveillance activities (e.g., BSEE, state oil and gas commission).',
    `regulatory_compliance_required` BOOLEAN COMMENT 'Indicates whether this surveillance plan is required to meet specific regulatory or governmental reporting obligations.',
    `responsible_department` STRING COMMENT 'Business unit or department accountable for the surveillance plan execution and deliverables.',
    `risk_assessment_completed` BOOLEAN COMMENT 'Indicates whether a formal risk assessment has been completed for the surveillance activities defined in this plan.',
    `saturation_monitoring_planned` BOOLEAN COMMENT 'Indicates whether saturation monitoring (e.g., through pulsed neutron logs or resistivity logs) is planned to track fluid saturation changes.',
    `seismic_4d_frequency` STRING COMMENT 'Planned frequency for conducting 4D seismic surveys if included in the surveillance plan.. Valid values are `annual|biennial|triennial|five_year|on_demand`',
    `seismic_4d_planned` BOOLEAN COMMENT 'Indicates whether time-lapse (4D) seismic surveys are planned as part of the surveillance program to monitor reservoir changes over time.',
    `surveillance_objectives` STRING COMMENT 'Detailed description of the business and technical objectives that this surveillance plan aims to achieve, including reservoir performance monitoring, model calibration, and production optimization goals.',
    `tracer_test_frequency` STRING COMMENT 'Planned frequency for conducting tracer tests if included in the surveillance plan.. Valid values are `annual|biennial|on_demand`',
    `tracer_test_planned` BOOLEAN COMMENT 'Indicates whether tracer tests are planned to evaluate fluid movement, sweep efficiency, and inter-well connectivity.',
    `well_test_frequency` STRING COMMENT 'Planned frequency for conducting well tests to measure production rates, pressures, and fluid properties.. Valid values are `monthly|quarterly|semi_annual|annual|on_demand`',
    CONSTRAINT pk_surveillance_plan PRIMARY KEY(`surveillance_plan_id`)
) COMMENT 'Defines the surveillance program for a reservoir including planned pressure surveys, fluid sampling, well tests, 4D seismic, and tracer tests. Captures plan name, reservoir, surveillance objectives, planned activities with frequency (monthly/quarterly/annual), responsible engineer, budget allocation, plan effective date, plan status (draft/approved/active/completed), and last review date. Ensures systematic data acquisition to support reservoir management decisions and model updates.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` (
    `tracer_test_id` BIGINT COMMENT 'Unique identifier for the inter-well tracer test record. Primary key for the tracer test entity.',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Tracer tests are expensive surveillance activities charged to AFEs. Business process: cost tracking for tracer programs, AFE approval, and working interest billing. Complements existing test_cost_usd ',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Tracer tests incur test_cost_usd for tracer chemicals, laboratory analysis, and engineering services. Must be charged to AFE budgets for reservoir characterization and EOR program evaluation cost trac',
    `injection_well_id` BIGINT COMMENT 'Foreign key reference to the well where the tracer material was injected. Links to the well master data for the injection point.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracer test interpretation drives EOR design and well spacing decisions; requires qualified reservoir engineer. Links interpretation to employee for technical peer review, competency verification, and',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tracer tests require environmental permits for chemical injection into reservoirs. The existing regulatory_permit_number is a denormalized string; proper FK enables tracking permit conditions, approve',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Tracer injection involves chemical handling (radioactive or chemical tracers), well intervention, and injection operations requiring PTW authorization for hazard assessment, isolation verification, PP',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir where the tracer test was conducted. Links to the reservoir master data.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Tracer test analytical services are procured from specialized laboratories. Links tracer analysis to vendor qualification, analytical_method certification, and detection_limit_ppm quality assurance. R',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the producer well where tracer was first detected. Identifies the most direct or highest permeability flow path from injector.',
    `analytical_method` STRING COMMENT 'Specific analytical technique or instrumentation method used to detect and quantify tracer concentrations in produced fluid samples.',
    `channeling_indicator` STRING COMMENT 'Qualitative assessment of preferential flow path or channeling behavior based on breakthrough curve shape and timing. Indicates reservoir heterogeneity severity.. Valid values are `none|suspected|confirmed|severe`',
    `comments` STRING COMMENT 'Free-text field for capturing additional observations, operational notes, data quality issues, or special circumstances related to the tracer test execution and interpretation.',
    `connectivity_quality` STRING COMMENT 'Overall assessment of hydraulic connectivity between injector and producer wells based on tracer response characteristics and recovery efficiency.. Valid values are `excellent|good|moderate|poor|none`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this tracer test record was first created in the reservoir management system. Audit trail for data governance and lineage tracking.',
    `detection_limit_ppm` DECIMAL(18,2) COMMENT 'Minimum tracer concentration that can be reliably detected and quantified by the analytical method measured in parts per million. Defines sensitivity threshold.',
    `environmental_clearance_flag` BOOLEAN COMMENT 'Boolean indicator confirming that environmental and safety clearances were obtained prior to tracer injection per regulatory requirements.',
    `first_breakthrough_date` DATE COMMENT 'Calendar date when tracer was first detected above background levels in any monitored producer well. Indicates fastest flow path and minimum transit time.',
    `injection_concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration of tracer material in the injection fluid measured in parts per million. Baseline concentration for breakthrough detection and recovery calculations.',
    `injection_date` DATE COMMENT 'Calendar date when the tracer material was injected into the injection well. Serves as the time-zero reference for breakthrough time calculations.',
    `injection_end_time` TIMESTAMP COMMENT 'Precise timestamp when tracer injection was completed. Defines the injection duration and pulse characteristics for interpretation modeling.',
    `injection_pressure_psi` DECIMAL(18,2) COMMENT 'Average wellhead injection pressure during tracer injection measured in pounds per square inch. Affects tracer distribution and flow patterns.',
    `injection_rate_bpd` DECIMAL(18,2) COMMENT 'Average injection rate during tracer injection measured in barrels per day. Influences tracer dispersion and breakthrough timing.',
    `injection_start_time` TIMESTAMP COMMENT 'Precise timestamp when tracer injection commenced. Used for high-resolution breakthrough time analysis and flow velocity calculations.',
    `interpretation_date` DATE COMMENT 'Calendar date when the technical interpretation and analysis of tracer test results was completed and documented.',
    `interpretation_status` STRING COMMENT 'Current status of technical interpretation and analysis of tracer test results. Indicates maturity and approval level of findings.. Valid values are `pending|in_progress|preliminary|final|peer_reviewed`',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this tracer test record was most recently updated. Supports change tracking and data quality monitoring for reservoir analytics.',
    `monitoring_end_date` DATE COMMENT 'Calendar date when systematic monitoring of producer wells for tracer breakthrough was concluded. Defines the end of the observation period.',
    `monitoring_start_date` DATE COMMENT 'Calendar date when systematic monitoring of producer wells for tracer breakthrough commenced. Defines the beginning of the observation period.',
    `peak_breakthrough_date` DATE COMMENT 'Calendar date when the peak tracer concentration was observed in producer wells. Represents the time of maximum tracer arrival and sweep.',
    `peak_breakthrough_time_days` DECIMAL(18,2) COMMENT 'Elapsed time in days from tracer injection to peak concentration detection. Key parameter for flow velocity and reservoir heterogeneity assessment.',
    `peak_concentration_ppm` DECIMAL(18,2) COMMENT 'Maximum tracer concentration detected across all monitored producer wells measured in parts per million. Indicates sweep efficiency and dilution effects.',
    `producer_well_count` STRING COMMENT 'Total number of producing wells monitored for tracer breakthrough during this test. Indicates the scope and coverage of the connectivity analysis.',
    `sampling_frequency_days` STRING COMMENT 'Interval in days between successive fluid samples collected from producer wells during the monitoring period. Determines temporal resolution of breakthrough curves.',
    `swept_pore_volume_fraction` DECIMAL(18,2) COMMENT 'Fraction of total reservoir pore volume contacted by the tracer as calculated from breakthrough curve analysis. Quantifies volumetric sweep efficiency.',
    `test_code` STRING COMMENT 'Unique alphanumeric code assigned to the tracer test for tracking and reporting purposes within the reservoir management system.',
    `test_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the tracer test including materials, laboratory analysis, engineering time, and operational expenses measured in US dollars.',
    `test_name` STRING COMMENT 'Business name or designation assigned to this tracer test for identification and reference purposes.',
    `test_objective` STRING COMMENT 'Primary business objective or purpose for conducting the tracer test. Defines what reservoir characteristic or operational parameter is being evaluated. [ENUM-REF-CANDIDATE: reservoir_connectivity|sweep_efficiency|flow_path_characterization|waterflood_optimization|eor_design|channeling_detection|fracture_mapping|injection_conformance — 8 candidates stripped; promote to reference product]',
    `test_status` STRING COMMENT 'Current lifecycle status of the tracer test indicating its stage in the test workflow from planning through completion and interpretation.. Valid values are `planned|injection_complete|monitoring|analysis|completed|cancelled`',
    `tracer_cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical composition of the tracer material for regulatory compliance and safety documentation.',
    `tracer_mass_injected_kg` DECIMAL(18,2) COMMENT 'Total mass of pure tracer material injected measured in kilograms. Used for concentration calculations and material balance analysis.',
    `tracer_name` STRING COMMENT 'Specific chemical or isotopic name of the tracer material injected into the reservoir. Examples include tritium, fluorescein, or proprietary chemical tracers.',
    `tracer_recovery_percent` DECIMAL(18,2) COMMENT 'Percentage of injected tracer mass recovered in produced fluids across all monitored wells. Indicates sweep efficiency and unswept reservoir volume.',
    `tracer_type` STRING COMMENT 'Classification of the tracer material used in the test based on its physical and chemical properties. Determines detection methods and regulatory requirements. [ENUM-REF-CANDIDATE: chemical|radioactive|isotope|fluorescent|dye|gas|particulate — 7 candidates stripped; promote to reference product]',
    `tracer_volume_injected_bbl` DECIMAL(18,2) COMMENT 'Total volume of tracer solution injected into the reservoir measured in barrels. Critical for mass balance calculations and recovery percentage determination.',
    CONSTRAINT pk_tracer_test PRIMARY KEY(`tracer_test_id`)
) COMMENT 'Records inter-well tracer tests used to characterize reservoir connectivity, flow paths, and sweep efficiency between injectors and producers. Captures tracer type (chemical/radioactive/isotope), injection well, producer wells monitored, injection date, tracer volume injected, tracer concentration at injection, first tracer breakthrough date, peak tracer concentration, peak breakthrough time, tracer recovery percentage, swept pore volume, channeling indicator, and test interpretation engineer. Supports EOR design and waterflood optimization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`model_update` (
    `model_update_id` BIGINT COMMENT 'Primary key for model_update',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Simulation model updates trigger reserves revisions and require certified reservoir engineer accountability. Links update to engineer for version control, competency verification (simulation certifica',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which this model update was performed. Links to the master reservoir entity.',
    `simulation_model_id` BIGINT COMMENT 'Reference to the specific simulation model that was updated. Links to the simulation model master data.',
    `approval_date` DATE COMMENT 'Date when the model update was officially approved by the designated authority. Establishes the effective date for reserves reporting.',
    `approval_status` STRING COMMENT 'Current approval status of the model update: draft (work in progress), submitted (awaiting approval), under_review (being evaluated), approved (officially accepted), rejected (not accepted), or superseded (replaced by newer update).. Valid values are `draft|submitted|under_review|approved|rejected|superseded`',
    `approved_by` STRING COMMENT 'Name or title of the individual or committee that approved this model update (e.g., Chief Reservoir Engineer, Reserves Committee, Technical Authority). Required for governance and audit trail.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations about this model update. Used for capturing context that does not fit in structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this model update record was first created in the database. Used for audit trail and data lineage.',
    `data_cutoff_date` DATE COMMENT 'Date through which production, pressure, and other dynamic data were included in this model update. Defines the temporal boundary of the history match period.',
    `documentation_file_path` STRING COMMENT 'File system path where the technical documentation, peer review reports, and supporting analysis for this update are stored.',
    `eur_variance_mmbbl` DECIMAL(18,2) COMMENT 'Change in EUR estimate from previous model version (updated minus previous). Critical for SEC reserves revision reporting and management decision-making.',
    `history_match_quality` STRING COMMENT 'Qualitative assessment of how well the updated model matches historical production and pressure data: excellent (within 5% error), good (5-10% error), acceptable (10-15% error), poor (>15% error), or not_applicable (static model update only).. Valid values are `excellent|good|acceptable|poor|not_applicable`',
    `key_changes_summary` STRING COMMENT 'Executive summary of the most significant changes and their impact on reservoir understanding, production forecasts, or reserves estimates. Used for management reporting and peer review.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this model update record was last modified. Used for tracking changes and data currency.',
    `model_file_path` STRING COMMENT 'File system or document management system path where the updated model files are stored. Used for model retrieval and version control.',
    `model_version` STRING COMMENT 'Version identifier assigned to the model after this update. Follows organizational versioning convention (e.g., v2.3.1, 2024-Q1-Rev3).',
    `new_wells_included_count` STRING COMMENT 'Number of new wells added to the model in this update. Used for tracking model evolution and data integration.',
    `ooip_variance_mmbbl` DECIMAL(18,2) COMMENT 'Change in OOIP estimate from previous model version (updated minus previous). Positive values indicate upward revision, negative values indicate downward revision.',
    `peer_review_date` DATE COMMENT 'Date when the peer review process was completed. Required for governance and quality assurance audit trail.',
    `peer_review_status` STRING COMMENT 'Current status of the peer review process for this model update: not_started, in_progress, completed, approved (peer review passed), rejected (peer review failed), or conditional_approval (approved with conditions).. Valid values are `not_started|in_progress|completed|approved|rejected|conditional_approval`',
    `peer_reviewer_name` STRING COMMENT 'Name of the senior reservoir engineer or technical authority who conducted the peer review. Required for governance and accountability.',
    `previous_eur_oil_mmbbl` DECIMAL(18,2) COMMENT 'EUR oil estimate from the previous model version. Used for reserves revision analysis and SEC reporting of reserves changes.',
    `previous_ooip_mmbbl` DECIMAL(18,2) COMMENT 'Original Oil In Place estimate from the previous model version. Used for variance analysis and reserves revision tracking.',
    `prms_classification` STRING COMMENT 'SPE PRMS reserves classification applicable to this model update: 1P (proved), 2P (proved plus probable), 3P (proved plus probable plus possible), PDP (proved developed producing), PUD (proved undeveloped), PDNP (proved developed non-producing), probable, possible, contingent (contingent resources), or prospective (prospective resources). [ENUM-REF-CANDIDATE: 1P|2P|3P|PDP|PUD|PDNP|probable|possible|contingent|prospective — 10 candidates stripped; promote to reference product]',
    `reserves_category_impact` STRING COMMENT 'Impact of this model update on reserves categorization: proved_increase, proved_decrease, probable_increase, probable_decrease, category_upgrade (e.g., probable to proved), category_downgrade (e.g., proved to probable), or no_change. [ENUM-REF-CANDIDATE: proved_increase|proved_decrease|probable_increase|probable_decrease|category_upgrade|category_downgrade|no_change — 7 candidates stripped; promote to reference product]',
    `simulator_software` STRING COMMENT 'Name of the reservoir simulation software used for this update (e.g., Schlumberger Petrel, Eclipse, CMG, tNavigator). Important for technical reproducibility.',
    `simulator_version` STRING COMMENT 'Version number of the reservoir simulation software used. Required for technical audit trail and reproducibility.',
    `uncertainty_assessment` STRING COMMENT 'Assessment of the overall uncertainty level in the updated model: low (high data density, mature field), medium (moderate data, some uncertainty), high (sparse data, early field life), or very_high (exploration/appraisal stage).. Valid values are `low|medium|high|very_high`',
    `update_date` DATE COMMENT 'Date when the model update was completed and finalized. Represents the business event date for this revision.',
    `update_description` STRING COMMENT 'Detailed narrative description of the changes made in this model update, including key modifications to geological structure, property distributions, well configurations, production constraints, or simulation parameters.',
    `update_number` STRING COMMENT 'Sequential number of this update within the models revision history. Used for version tracking and audit trail.',
    `update_scope` STRING COMMENT 'Geographic or volumetric scope of the model update: full_field (entire reservoir), sector (specific sector model), zone (individual reservoir zone), well_area (localized around specific wells), or regional (multi-field regional model).. Valid values are `full_field|sector|zone|well_area|regional`',
    `update_trigger` STRING COMMENT 'Primary business or technical trigger that initiated this model update: new_well_data (new drilling results), production_history (updated production performance), pressure_data (new pressure surveys), 4d_seismic (time-lapse seismic), pvt_analysis (new fluid analysis), core_data (new core analysis), well_test (new well test results), reserves_review (scheduled reserves assessment), regulatory_requirement (SEC/regulatory filing), annual_review (annual model refresh), acquisition (asset acquisition integration), or divestiture (pre-sale evaluation). [ENUM-REF-CANDIDATE: new_well_data|production_history|pressure_data|4d_seismic|pvt_analysis|core_data|well_test|reserves_review|regulatory_requirement|annual_review|acquisition|divestiture — 12 candidates stripped; promote to reference product]',
    `update_type` STRING COMMENT 'Classification of the type of model update performed: static (geological/petrophysical changes), dynamic (history match/production data), full-field (entire reservoir), sector (specific area), integrated (both static and dynamic), geological (structural/stratigraphic), petrophysical (rock properties), or history_match (production calibration). [ENUM-REF-CANDIDATE: static|dynamic|full_field|sector|integrated|geological|petrophysical|history_match — 8 candidates stripped; promote to reference product]',
    `updated_eur_gas_bcf` DECIMAL(18,2) COMMENT 'Revised estimate of total recoverable gas in billion cubic feet over the life of the reservoir. Used for gas reserves classification and field development planning.',
    `updated_eur_oil_mmbbl` DECIMAL(18,2) COMMENT 'Revised estimate of total recoverable oil in million barrels over the life of the reservoir. Key metric for reserves booking and economic evaluation.',
    `updated_ogip_bcf` DECIMAL(18,2) COMMENT 'Revised estimate of Original Gas In Place in billion cubic feet resulting from this model update. Used for gas reserves classification and development planning.',
    `updated_ooip_mmbbl` DECIMAL(18,2) COMMENT 'Revised estimate of Original Oil In Place in million barrels resulting from this model update. Critical metric for reserves classification and recovery factor calculation.',
    `updated_recovery_factor_gas_percent` DECIMAL(18,2) COMMENT 'Revised gas recovery factor as a percentage of OGIP. Calculated as (EUR Gas / OGIP) × 100. Used for gas field performance evaluation.',
    `updated_recovery_factor_oil_percent` DECIMAL(18,2) COMMENT 'Revised oil recovery factor as a percentage of OOIP. Calculated as (EUR Oil / OOIP) × 100. Critical metric for evaluating reservoir performance and EOR potential.',
    `updated_stoiip_mmbbl` DECIMAL(18,2) COMMENT 'Revised estimate of Stock Tank Oil Initially In Place in million barrels at standard conditions. Represents oil volume at surface conditions after shrinkage.',
    CONSTRAINT pk_model_update PRIMARY KEY(`model_update_id`)
) COMMENT 'Tracks the history of reservoir model updates and revisions including static model updates (geological/petrophysical) and dynamic model history match updates. Captures update date, model version, update type (static/dynamic/full-field/sector), trigger for update (new well data/production history/pressure data/4D seismic), key changes made, updated OOIP/OGIP, updated EUR, updated recovery factor, peer review status, approval date, and approving authority. Provides audit trail for reserves revisions and model governance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` (
    `injection_performance_id` BIGINT COMMENT 'Unique identifier for the injection performance record. Primary key for the injection performance data product.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Injection performance monitoring requires facility-level aggregation for water/gas supply planning and facility optimization. Injection facility capacity planning, water treatment facility sizing, and',
    `reservoir_id` BIGINT COMMENT 'Unique identifier of the reservoir into which fluids are being injected. Links to reservoir master data.',
    `zone_id` BIGINT COMMENT 'Unique identifier of the specific reservoir zone targeted for injection. Enables zone-level injection performance tracking.',
    `well_asset_id` BIGINT COMMENT 'Unique identifier of the injection well being monitored. Links to the well master data.',
    `bottomhole_injection_pressure_psi` DECIMAL(18,2) COMMENT 'Calculated or measured injection pressure at the bottom of the wellbore, in pounds per square inch. Critical for reservoir pressure maintenance monitoring and fracture pressure management.',
    `comments` STRING COMMENT 'Free-text field for operational notes, observations, or explanations related to the injection performance measurement. Captures context for anomalies, operational changes, or data quality issues.',
    `conformance_issue_description` STRING COMMENT 'Detailed description of any conformance issues identified, including channeling, thief zones, poor vertical sweep, early breakthrough, or injection profile imbalance. Supports root cause analysis and remedial planning.',
    `conformance_issue_flag` BOOLEAN COMMENT 'Boolean flag indicating whether conformance issues have been identified during the injection period. True indicates problems such as channeling, thief zones, poor sweep, or uneven injection distribution requiring remedial action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this injection performance record was first created in the system. Supports data lineage and audit trail requirements.',
    `cumulative_injection_volume_bbl` DECIMAL(18,2) COMMENT 'Total cumulative volume of liquid injected since the start of the injection program, measured in barrels. Tracks lifetime injection for voidage replacement and reservoir pressure history analysis.',
    `cumulative_injection_volume_mcf` DECIMAL(18,2) COMMENT 'Total cumulative volume of gas injected since the start of the injection program, measured in thousand cubic feet. Tracks lifetime gas injection for reservoir voidage management.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for the injection performance measurement. Valid indicates verified data; estimated indicates calculated or interpolated values; suspect indicates data requiring review; invalid indicates rejected data; missing indicates no data available for the period.. Valid values are `valid|estimated|suspect|invalid|missing`',
    `data_source` STRING COMMENT 'Source system or method from which the injection performance data was captured. Includes OSIsoft PI System historian, SCADA, manual field entry, well test data, or production allocation system.. Valid values are `pi_system|scada|manual_entry|well_test|allocation_system`',
    `field_code` BIGINT COMMENT 'Unique identifier of the field containing the injection well. Supports field-level voidage management analysis.',
    `fracture_pressure_psi` DECIMAL(18,2) COMMENT 'Estimated formation fracture pressure at the injection zone, measured in pounds per square inch. Defines the maximum safe injection pressure to avoid hydraulic fracturing and out-of-zone injection.',
    `gas_quality_co2_percent` DECIMAL(18,2) COMMENT 'Carbon dioxide concentration in injected gas, measured as percentage by volume. Relevant for CO2 EOR programs and Carbon Capture and Storage (CCS) projects.',
    `gross_injection_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of liquid injected during the measurement period, measured in barrels. Applies to water, steam, polymer, surfactant, and other liquid injectants.',
    `gross_injection_volume_mcf` DECIMAL(18,2) COMMENT 'Total volume of gas injected during the measurement period, measured in thousand cubic feet. Applies to natural gas, CO2, and other gaseous injectants.',
    `injected_fluid_type` STRING COMMENT 'Type of fluid being injected into the reservoir for pressure maintenance or Enhanced Oil Recovery (EOR). Supports classification of injection schemes including water flooding, gas injection, Steam-Assisted Gravity Drainage (SAGD), Carbon Capture and Storage (CCS), and chemical EOR programs.. Valid values are `water|gas|steam|co2|polymer|surfactant`',
    `injection_availability_percent` DECIMAL(18,2) COMMENT 'Percentage of time the injection well was available for injection during the measurement period. Calculated as (injection uptime hours / total period hours) * 100. Key performance indicator for injection well reliability.',
    `injection_downtime_hours` DECIMAL(18,2) COMMENT 'Total number of hours the injection well was not injecting during the measurement period due to planned or unplanned downtime. Supports Non-Productive Time (NPT) analysis and operational performance tracking.',
    `injection_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage of injected fluid that remains in the target reservoir zone versus fluid lost to other zones or formations. Calculated from injection profile logs and tracer studies. High efficiency indicates good conformance; low efficiency signals channeling or thief zones.',
    `injection_period_end_date` DATE COMMENT 'End date of the injection performance measurement period. Typically the last day of the reporting month for monthly injection tracking.',
    `injection_period_start_date` DATE COMMENT 'Start date of the injection performance measurement period. Typically the first day of the reporting month for monthly injection tracking.',
    `injection_pressure_margin_psi` DECIMAL(18,2) COMMENT 'Difference between formation fracture pressure and current bottomhole injection pressure, measured in pounds per square inch. Positive margin indicates safe injection; negative margin indicates risk of formation fracturing.',
    `injection_profile_zone_1_percent` DECIMAL(18,2) COMMENT 'Percentage of total injection volume entering reservoir zone 1, determined from injection profile logs or flow meters. Supports conformance monitoring and identifies preferential flow paths.',
    `injection_profile_zone_2_percent` DECIMAL(18,2) COMMENT 'Percentage of total injection volume entering reservoir zone 2, determined from injection profile logs or flow meters. Supports conformance monitoring and identifies preferential flow paths.',
    `injection_profile_zone_3_percent` DECIMAL(18,2) COMMENT 'Percentage of total injection volume entering reservoir zone 3, determined from injection profile logs or flow meters. Supports conformance monitoring and identifies preferential flow paths.',
    `injection_rate_bpd` DECIMAL(18,2) COMMENT 'Average daily injection rate of liquid during the measurement period, measured in barrels per day. Key metric for monitoring injection well performance and conformance to injection plan.',
    `injection_rate_mcfd` DECIMAL(18,2) COMMENT 'Average daily injection rate of gas during the measurement period, measured in thousand cubic feet per day. Monitors gas injection performance for pressure maintenance and EOR schemes.',
    `injection_scheme_type` STRING COMMENT 'Classification of the injection program type. Includes pressure maintenance, waterflood, gas injection, Water Alternating Gas (WAG), Steam-Assisted Gravity Drainage (SAGD), Cyclic Steam Stimulation (CSS), polymer flood, surfactant flood, and Carbon Capture and Storage (CCS). [ENUM-REF-CANDIDATE: pressure_maintenance|waterflood|gas_injection|wag|sagd|css|polymer_flood|surfactant_flood|ccs — 9 candidates stripped; promote to reference product]',
    `injection_temperature_f` DECIMAL(18,2) COMMENT 'Temperature of injected fluid at the wellhead, measured in degrees Fahrenheit. Critical for thermal EOR programs (SAGD, CSS) and monitoring thermal efficiency.',
    `injection_uptime_hours` DECIMAL(18,2) COMMENT 'Total number of hours the injection well was actively injecting during the measurement period. Used to calculate injection availability and operational efficiency.',
    `injectivity_index_bpd_psi` DECIMAL(18,2) COMMENT 'Ratio of injection rate to pressure differential (bottomhole injection pressure minus reservoir pressure), measured in barrels per day per psi. Indicates the ease of fluid injection and formation acceptance. Declining injectivity index may signal formation damage, plugging, or conformance issues.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the injection performance measurement was recorded. Captured from SCADA or PI System historian.',
    `operational_status` STRING COMMENT 'Current operational status of the injection well during the measurement period. Indicates whether the well is actively injecting, shut in for reservoir management, suspended due to mechanical issues, under maintenance, undergoing testing, or offline.. Valid values are `injecting|shut_in|suspended|maintenance|testing|offline`',
    `polymer_concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration of polymer in injected water for polymer flood EOR programs, measured in parts per million. Monitors chemical injection conformance to design specifications.',
    `reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Current reservoir pressure at the injection zone datum depth, measured in pounds per square inch. Tracks reservoir pressure response to injection for voidage replacement and pressure maintenance effectiveness.',
    `steam_quality_percent` DECIMAL(18,2) COMMENT 'Steam quality (dryness fraction) of injected steam for SAGD or CSS thermal EOR programs, expressed as percentage. 100% indicates dry steam; lower values indicate wet steam with liquid water content.',
    `sweep_efficiency_percent` DECIMAL(18,2) COMMENT 'Percentage of reservoir volume contacted by the injected fluid. Combines areal sweep (horizontal coverage) and vertical sweep (layer coverage). Key metric for waterflood and EOR performance evaluation.',
    `voidage_replacement_ratio` DECIMAL(18,2) COMMENT 'Ratio of total injection volume to total production volume on a reservoir-equivalent basis. A VRR of 1.0 indicates perfect voidage replacement; values above 1.0 indicate pressure support exceeding production voidage. Critical metric for reservoir pressure maintenance strategy.',
    `water_quality_suspended_solids_ppm` DECIMAL(18,2) COMMENT 'Suspended solids concentration in injected water, measured in parts per million. Critical for monitoring filtration effectiveness and preventing formation plugging.',
    `water_quality_tds_ppm` DECIMAL(18,2) COMMENT 'Total dissolved solids concentration in injected water, measured in parts per million. Monitors water quality for formation compatibility and scale/plugging risk assessment.',
    `wellhead_injection_pressure_psi` DECIMAL(18,2) COMMENT 'Injection pressure measured at the wellhead surface, in pounds per square inch. Monitors surface injection pressure for operational control and equipment integrity.',
    CONSTRAINT pk_injection_performance PRIMARY KEY(`injection_performance_id`)
) COMMENT 'Monitors the performance of injection wells (water/gas/steam/CO2/polymer) supporting reservoir pressure maintenance and EOR schemes. Captures injection well identifier, injection period (monthly), injected fluid type, gross injection volume (BBL or MCF), injection pressure (wellhead and bottomhole), injectivity index (II), voidage replacement ratio (VRR), cumulative injection, injection efficiency, injection profile (by zone), conformance issues, and operational status. Feeds reservoir voidage management and pressure support optimization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`connectivity` (
    `connectivity_id` BIGINT COMMENT 'Primary key for connectivity',
    `well_asset_id` BIGINT COMMENT 'Reference to the source well in a well-pair connectivity analysis. Used when evaluating connectivity between two specific wells.',
    `connectivity_well_pair_target_well_asset_id` BIGINT COMMENT 'Reference to the target well in a well-pair connectivity analysis. Used when evaluating connectivity between two specific wells.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor record of the geoscientist who performed the connectivity analysis.',
    `field_id` BIGINT COMMENT 'Reference to the field containing the reservoir zones being evaluated for connectivity.',
    `interference_test_id` BIGINT COMMENT 'Reference to the interference or pulse test record if well testing was used to establish connectivity.',
    `reservoir_id` BIGINT COMMENT 'Reference to the primary reservoir being analyzed for connectivity. Links to the reservoir master data product.',
    `simulation_model_id` BIGINT COMMENT 'Reference to the reservoir simulation model that incorporates or validates this connectivity interpretation.',
    `zone_id` BIGINT COMMENT 'Reference to the first reservoir zone in the connectivity pair. Represents the zone from which connectivity is being evaluated.',
    `target_zone_id` BIGINT COMMENT 'Reference to the second reservoir zone in the connectivity pair. Represents the zone to which connectivity is being evaluated.',
    `tracer_test_id` BIGINT COMMENT 'Reference to the tracer test record if tracer breakthrough was used as evidence for connectivity.',
    `approval_date` DATE COMMENT 'Date when the connectivity interpretation was formally approved by technical authority or peer review committee.',
    `approved_by` STRING COMMENT 'Name of the technical authority or committee that approved the connectivity interpretation for use in development planning and reserves estimation.',
    `barrier_description` STRING COMMENT 'Detailed textual description of the geological barrier affecting connectivity, including its nature, extent, and impact on fluid flow.',
    `barrier_type` STRING COMMENT 'Type of geological feature acting as a flow barrier between zones. Sealing fault indicates complete fault seal, partial fault indicates leaky fault, shale barrier indicates impermeable shale layer, tight zone indicates low permeability rock, stratigraphic pinchout indicates depositional termination, diagenetic barrier indicates post-depositional cementation or alteration.. Valid values are `sealing_fault|partial_fault|shale_barrier|tight_zone|stratigraphic_pinchout|diagenetic_barrier`',
    `comments` STRING COMMENT 'Additional notes, observations, or context regarding the connectivity interpretation, including uncertainties, alternative interpretations, or recommendations for further investigation.',
    `confidence_level` STRING COMMENT 'Qualitative assessment of confidence in the connectivity interpretation based on quality and quantity of supporting evidence. High indicates strong multiple lines of evidence, medium indicates reasonable evidence with some uncertainty, low indicates limited or indirect evidence.. Valid values are `high|medium|low`',
    `connectivity_name` STRING COMMENT 'Business name or label assigned to this connectivity analysis for identification and reference purposes.',
    `connectivity_status` STRING COMMENT 'Current status of the connectivity interpretation. Confirmed indicates strong evidence, probable indicates likely but not certain, possible indicates weak evidence, uncertain indicates conflicting evidence, disproven indicates evidence of isolation.. Valid values are `confirmed|probable|possible|uncertain|disproven`',
    `connectivity_type` STRING COMMENT 'Type of connectivity observed between reservoir zones or fault blocks. Pressure connectivity indicates pressure equilibration, fluid connectivity indicates fluid movement, both indicates complete communication, none indicates isolation.. Valid values are `pressure|fluid|both|none`',
    `created_date` DATE COMMENT 'Date when the connectivity record was first created in the system.',
    `evidence_type` STRING COMMENT 'Primary type of evidence supporting the connectivity interpretation. Pressure equalization indicates synchronized pressure behavior, tracer breakthrough indicates fluid movement detection, production response indicates rate or pressure response to nearby activity, interference test indicates controlled well testing, seismic attribute indicates geophysical evidence, geological model indicates structural or stratigraphic interpretation.. Valid values are `pressure_equalization|tracer_breakthrough|production_response|interference_test|seismic_attribute|geological_model`',
    `fault_transmissibility_multiplier` DECIMAL(18,2) COMMENT 'Dimensionless multiplier applied to reservoir simulation grid cells across faults to represent the degree of flow communication. Values range from 0 (complete barrier) to 1 (no barrier). Used in reservoir simulation models to honor observed connectivity behavior.',
    `geoscientist_name` STRING COMMENT 'Name of the geoscientist or reservoir engineer responsible for the connectivity interpretation and analysis.',
    `impact_on_development` STRING COMMENT 'Description of how this connectivity interpretation impacts field development planning, well spacing decisions, Enhanced Oil Recovery (EOR) design, or production optimization strategies.',
    `impact_on_eor` STRING COMMENT 'Description of how this connectivity interpretation affects Enhanced Oil Recovery (EOR) or Improved Oil Recovery (IOR) program design, including injection patterns, sweep efficiency, and recovery factor expectations.',
    `interpretation_date` DATE COMMENT 'Date when the connectivity interpretation was completed by the geoscientist or reservoir engineer.',
    `interpretation_method` STRING COMMENT 'Methodology or technique used to determine connectivity, such as pressure transient analysis, tracer testing, production data analysis, seismic interpretation, or reservoir simulation history matching.',
    `last_modified_date` DATE COMMENT 'Date when the connectivity record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date of the most recent technical review or update of the connectivity interpretation based on new data or production performance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next technical review of the connectivity interpretation to incorporate new surveillance data or production history.',
    `pressure_equalization_observed` BOOLEAN COMMENT 'Indicates whether pressure equalization between zones or fault blocks has been observed through pressure monitoring or well testing.',
    `production_response_observed` BOOLEAN COMMENT 'Indicates whether production rate or pressure changes in one well have been observed in response to activity in another well, suggesting connectivity.',
    `quality_flag` STRING COMMENT 'Data quality indicator for the connectivity record. Verified indicates peer-reviewed and approved, unverified indicates preliminary interpretation, under review indicates active quality control, rejected indicates interpretation has been superseded or invalidated.. Valid values are `verified|unverified|under_review|rejected`',
    `source_fault_block` STRING COMMENT 'Name or identifier of the source fault block being evaluated for connectivity. Fault blocks are reservoir compartments separated by geological faults.',
    `strength` STRING COMMENT 'Qualitative assessment of the degree of communication between connected zones. Strong indicates high transmissibility, moderate indicates partial communication, weak indicates limited communication, none indicates complete isolation.. Valid values are `strong|moderate|weak|none`',
    `supporting_data_reference` STRING COMMENT 'Reference to supporting data sources used in the connectivity analysis, such as well test reports, tracer study results, pressure survey data, seismic volumes, or simulation model runs. May include document identifiers, file paths, or database references.',
    `target_fault_block` STRING COMMENT 'Name or identifier of the target fault block being evaluated for connectivity. Fault blocks are reservoir compartments separated by geological faults.',
    `tracer_breakthrough_observed` BOOLEAN COMMENT 'Indicates whether tracer material injected in one zone or well has been detected in another, confirming fluid connectivity.',
    `well_spacing_recommendation` STRING COMMENT 'Recommended well spacing or infill drilling strategy based on the connectivity interpretation. Includes guidance on optimal well placement to maximize reservoir contact while avoiding interference.',
    CONSTRAINT pk_connectivity PRIMARY KEY(`connectivity_id`)
) COMMENT 'Characterizes the degree of pressure and fluid communication between reservoir zones, fault blocks, and well pairs. Captures connectivity type (pressure/fluid/both), connected reservoir zones or fault blocks, connectivity evidence (pressure equalization/tracer breakthrough/production response), connectivity strength (strong/moderate/weak/none), fault transmissibility multiplier, barrier description, supporting data references, interpretation date, and geoscientist. Critical for development planning, well spacing, and EOR design.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` (
    `reservoir_sec_reserves_disclosure_id` BIGINT COMMENT 'Unique identifier for the SEC reserves disclosure record. Primary key for the entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: SEC reserves are disclosed by operated facility/field for regulatory compliance. SEC 10-K preparation, proved developed producing reserves by facility, and asset divestiture packages require this link',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: SEC reserves disclosures are submitted via regulatory filings (10-K, 20-F, 6-K). Links reservoir-level SEC disclosure data to the formal filing submission for tracking filing status, acknowledgment da',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: SEC reserves disclosures in 10-K filings are prepared at the lease level with lease-specific pricing, working interest, and net revenue interest. Required for standardized measure calculations, future',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA reserves are disclosed to SEC under specific fiscal terms; cost recovery limits, profit oil entitlements, and contractor shares depend on certified reserves under PSA framework. Required for SEC 1',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which reserves are being disclosed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SEC reserves disclosure requires named responsible engineer per Regulation S-K Item 1200. Links disclosure to employee for competency verification (qualified reserves evaluator), professional liabilit',
    `approval_date` DATE COMMENT 'The date on which the reserves disclosure was approved by management for inclusion in the SEC filing.',
    `approved_by` STRING COMMENT 'The name or title of the executive who approved the reserves disclosure for SEC filing.',
    `boe_reserves_mmboe` DECIMAL(18,2) COMMENT 'The total proved reserves expressed in million barrels of oil equivalent, using standard conversion factors for gas and NGL.',
    `certification_date` DATE COMMENT 'The date on which the independent engineer certified the reserves estimates.',
    `certification_reference` STRING COMMENT 'The reference number or identifier for the independent engineer certification report.',
    `comments` STRING COMMENT 'Additional notes, explanations, or qualifications related to the reserves disclosure, including any material assumptions or limitations.',
    `country_code` STRING COMMENT 'The three-letter ISO country code for the country where the reserves are located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reserves disclosure record was first created in the system.',
    `disclosure_status` STRING COMMENT 'Current lifecycle status of the SEC reserves disclosure record.. Valid values are `draft|submitted|accepted|amended|archived`',
    `disclosure_year` STRING COMMENT 'The calendar year for which the reserves disclosure is being reported, typically aligned with the fiscal year-end for annual 10-K filings.',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'The annual discount rate applied to future net cash flows to calculate the standardized measure, typically 10% as prescribed by SEC guidelines.',
    `field_code` BIGINT COMMENT 'Reference to the field containing the reservoir for which reserves are disclosed.',
    `filing_date` DATE COMMENT 'The date on which the SEC reserves disclosure was officially filed with the Securities and Exchange Commission.',
    `future_cash_inflows_usd_mm` DECIMAL(18,2) COMMENT 'The undiscounted future gross revenue from proved reserves based on SEC pricing assumptions, expressed in millions of US dollars.',
    `future_development_costs_usd_mm` DECIMAL(18,2) COMMENT 'The estimated future capital expenditures required to develop proved undeveloped reserves, expressed in millions of US dollars.',
    `future_income_tax_expense_usd_mm` DECIMAL(18,2) COMMENT 'The estimated future income tax expense associated with the future net cash flows from proved reserves, expressed in millions of US dollars.',
    `future_production_costs_usd_mm` DECIMAL(18,2) COMMENT 'The estimated future costs to produce the proved reserves, including lease operating expenses and production taxes, expressed in millions of US dollars.',
    `gas_price_usd_per_mcf` DECIMAL(18,2) COMMENT 'The SEC pricing assumption for natural gas used in reserves valuation, expressed in US dollars per thousand cubic feet.',
    `gas_reserves_bcf` DECIMAL(18,2) COMMENT 'The quantity of proved natural gas reserves for this disclosure record, expressed in billion cubic feet.',
    `geographic_region` STRING COMMENT 'The geographic region or basin where the reserves are located, used for segment reporting in SEC disclosures.',
    `independent_engineer_firm` STRING COMMENT 'The name of the independent petroleum engineering firm that certified or audited the reserves estimates for this disclosure.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this reserves disclosure record was last updated or modified.',
    `ngl_price_usd_per_bbl` DECIMAL(18,2) COMMENT 'The SEC pricing assumption for natural gas liquids used in reserves valuation, expressed in US dollars per barrel.',
    `ngl_reserves_mmbbl` DECIMAL(18,2) COMMENT 'The quantity of proved natural gas liquids reserves for this disclosure record, expressed in million barrels.',
    `oil_price_usd_per_bbl` DECIMAL(18,2) COMMENT 'The SEC pricing assumption for crude oil used in reserves valuation, expressed in US dollars per barrel.',
    `oil_reserves_mmbbl` DECIMAL(18,2) COMMENT 'The quantity of proved oil reserves for this disclosure record, expressed in million barrels.',
    `prior_year_reserves_mmboe` DECIMAL(18,2) COMMENT 'The total proved reserves reported in the prior year disclosure, expressed in million barrels of oil equivalent, used for reconciliation purposes.',
    `prms_classification` STRING COMMENT 'The SPE-PRMS classification level: 1P (Proved), 2P (Proved plus Probable), or 3P (Proved plus Probable plus Possible). SEC disclosures typically report only 1P (Proved) reserves.. Valid values are `1P|2P|3P`',
    `proved_reserves_category` STRING COMMENT 'The classification of proved reserves: PDP (Proved Developed Producing), PDNP (Proved Developed Non-Producing), or PUD (Proved Undeveloped).. Valid values are `PDP|PDNP|PUD`',
    `reporting_entity_name` STRING COMMENT 'The legal name of the entity reporting the reserves disclosure, typically the parent company or operating subsidiary.',
    `reserves_additions_mmboe` DECIMAL(18,2) COMMENT 'The total additions to proved reserves during the disclosure year from extensions, discoveries, improved recovery, and purchases, expressed in million barrels of oil equivalent.',
    `reserves_change_reason` STRING COMMENT 'The primary reason for changes in proved reserves from the prior year disclosure, such as revisions of previous estimates, extensions and discoveries, purchases of reserves in place, sales of reserves, or production.. Valid values are `revisions|extensions|discoveries|purchases|sales|production`',
    `reserves_production_mmboe` DECIMAL(18,2) COMMENT 'The total production from proved reserves during the disclosure year, expressed in million barrels of oil equivalent.',
    `reserves_revisions_mmboe` DECIMAL(18,2) COMMENT 'The net revisions to proved reserves during the disclosure year due to changes in technical or economic factors, expressed in million barrels of oil equivalent.',
    `reserves_sales_mmboe` DECIMAL(18,2) COMMENT 'The total proved reserves sold or divested during the disclosure year, expressed in million barrels of oil equivalent.',
    `sec_pricing_method` STRING COMMENT 'The pricing methodology used for reserves valuation, typically the 12-month average first-day-of-month price as required by SEC guidelines.. Valid values are `12_month_average_first_day|spot_price|other`',
    `sec_submission_reference` STRING COMMENT 'The official SEC submission identifier or accession number for the 10-K filing containing this reserves disclosure.',
    `smdfncf_usd_mm` DECIMAL(18,2) COMMENT 'The standardized measure of discounted future net cash flows from proved reserves, calculated using SEC-prescribed discount rate (10%) and pricing assumptions, expressed in millions of US dollars.',
    CONSTRAINT pk_reservoir_sec_reserves_disclosure PRIMARY KEY(`reservoir_sec_reserves_disclosure_id`)
) COMMENT 'Manages the formal SEC-compliant reserves disclosure records submitted in annual 10-K filings and supplemental oil and gas disclosures. Captures disclosure year, SEC pricing (12-month average first-day-of-month price), proved reserves by category (PDP/PDNP/PUD) and product type (oil/gas/NGL), standardized measure of discounted future net cash flows (SMDFNCF), changes in standardized measure, reserve quantity information table, independent engineer certification reference, filing date, and SEC submission reference. Governed by SEC Rule 4-10(a) and ASC 932.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`development_plan` (
    `development_plan_id` BIGINT COMMENT 'Primary key for development_plan',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Development plans require AFE authorization for drilling, completion, and facilities capex. Links reservoir engineering plans to approved budgets for execution tracking, variance reporting, and invest',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Development plans specify facility requirements, tie-ins, and infrastructure needs. Facility capacity planning, brownfield vs greenfield decisions, and facility CAPEX allocation depend on this link. C',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Development plans must reference emergency response plans for new facilities and operations to ensure regulatory compliance (BSEE SEMS, EPA RMP, OPA 90), demonstrate emergency preparedness for project',
    `employee_id` BIGINT COMMENT 'Reference to the reservoir engineer or petroleum engineer responsible for developing and maintaining this development plan.',
    `hse_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.hse_risk_assessment. Business justification: Field development plans require comprehensive HSE risk assessment (HAZID, HAZOP, quantitative risk assessment) for regulatory approval (BSEE, state agencies), project sanction, and FID decision-making',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Development plans require JOA partner approval, budget allocation, and working interest commitments. Operating committee must approve development scenarios, well counts, and capital expenditures befor',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Development plans must respect lease boundaries, primary term drilling obligations, and continuous drilling clauses. Essential for AFE preparation, regulatory spacing unit applications, and held-by-pr',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.offtake_agreement. Business justification: Field development plans require secured offtake agreements before FID to ensure market access for planned production (plateau_rate_oil_bopd, eur_oil_mmbbl). Investment committees require commercial co',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which this development plan is designed. Links to the reservoir master data.',
    `simulation_model_id` BIGINT COMMENT 'Reference to the reservoir simulation model used to generate production forecasts and reserves estimates for this development plan. Links to Schlumberger Petrel or other reservoir simulation software outputs.',
    `approval_date` DATE COMMENT 'Date when the development plan received final approval from the approving authority. Authorizes progression to Authorization for Expenditure (AFE) and execution phases.',
    `approval_status` STRING COMMENT 'Current approval status of the development plan. Tracks whether the plan has received necessary technical, commercial, and executive approvals to proceed with execution.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or title of the approving authority who authorized the development plan. May be executive management, joint venture partners, or regulatory authority depending on governance structure.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this development plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `development_capex_usd_mm` DECIMAL(18,2) COMMENT 'Total planned capital expenditure for the development plan in millions of US dollars. Includes drilling costs, completion costs, facility construction, pipeline infrastructure, and all capital investments required to execute the development plan.',
    `development_drilling_start_date` DATE COMMENT 'Planned date when development drilling operations will commence. Marks the beginning of the field development execution phase.',
    `development_opex_usd_mm` DECIMAL(18,2) COMMENT 'Total planned operating expenditure for the development plan in millions of US dollars. Includes Lease Operating Expense (LOE), production costs, maintenance, utilities, and ongoing operational costs over the field life.',
    `development_scenario` STRING COMMENT 'Classification of the development scenario representing different probabilistic outcomes or strategic approaches. Base represents most likely case, upside represents optimistic case, downside represents conservative case. P10/P50/P90 represent probabilistic reserves categories. [ENUM-REF-CANDIDATE: base|upside|downside|low|mid|high|p10|p50|p90 — 9 candidates stripped; promote to reference product]',
    `environmental_impact_assessment_completed` BOOLEAN COMMENT 'Indicates whether an environmental impact assessment has been completed for this development plan as required by Environmental Protection Agency (EPA) regulations and Environmental Social and Governance (ESG) standards.',
    `eor_program_type` STRING COMMENT 'Type of Enhanced Oil Recovery or Improved Oil Recovery program planned for this development. WAG represents Water Alternating Gas, SAGD represents Steam-Assisted Gravity Drainage, CSS represents Cyclic Steam Stimulation. None indicates primary or secondary recovery only. [ENUM-REF-CANDIDATE: none|wag|sagd|css|co2_injection|polymer_flood|chemical_flood|thermal|miscible_gas — 9 candidates stripped; promote to reference product]',
    `eur_gas_bcf` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of natural gas from the reservoir under this development plan, measured in billion cubic feet. Represents total recoverable gas over the field life.',
    `eur_ngl_mmbbl` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of natural gas liquids from the reservoir under this development plan, measured in million barrels. Includes condensate, propane, butane, and other NGLs.',
    `eur_oil_mmbbl` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery of oil from the reservoir under this development plan, measured in million barrels. Represents total recoverable oil over the field life including primary, secondary, and tertiary recovery.',
    `facility_type` STRING COMMENT 'Type of production facility required for this development plan. FPSO represents Floating Production Storage and Offloading vessel, FLNG represents Floating Liquefied Natural Gas facility. Determines infrastructure requirements and CAPEX profile.. Valid values are `onshore|offshore_platform|fpso|subsea_tieback|flng|wellhead_only`',
    `field_code` BIGINT COMMENT 'Reference to the field containing the reservoir. Links to field master data for geographic and operational context.',
    `first_production_date` DATE COMMENT 'Planned date when first commercial production from the development wells is expected to begin. Key milestone for project economics and cash flow forecasting.',
    `gas_price_assumption_usd_mcf` DECIMAL(18,2) COMMENT 'Natural gas price assumption used in economic modeling for this development plan, expressed in US dollars per thousand cubic feet. May reference Henry Hub or other regional gas price benchmarks.',
    `irr_percent` DECIMAL(18,2) COMMENT 'Internal rate of return for the development plan expressed as a percentage. Represents the discount rate at which the net present value of all cash flows equals zero. Key metric for investment decision-making.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this development plan record was last updated or modified. Used for audit trail, change tracking, and data governance.',
    `npv10_usd_mm` DECIMAL(18,2) COMMENT 'Net present value of the development plan discounted at 10 percent annual rate, measured in millions of US dollars. Standard economic metric used in oil and gas industry for project evaluation and SEC reserves reporting.',
    `oil_price_assumption_usd_bbl` DECIMAL(18,2) COMMENT 'Oil price assumption used in economic modeling for this development plan, expressed in US dollars per barrel. May reference West Texas Intermediate (WTI), Brent, or other benchmark crude prices.',
    `payout_period_years` DECIMAL(18,2) COMMENT 'Expected time in years from first production until cumulative net cash flow becomes positive. Measures how quickly the initial capital investment will be recovered.',
    `plan_code` STRING COMMENT 'Unique business code or identifier for the development plan. Used for tracking and referencing across systems and in regulatory submissions.',
    `plan_name` STRING COMMENT 'Business name or title of the field development plan. Used for identification and reference in business communications and regulatory filings.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the development plan. Tracks progression from initial draft through approval, execution, and completion phases. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|cancelled|completed — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the plan type indicating whether this is an initial development plan, a revision, a supplemental plan for additional phases, or an amendment to an existing plan.. Valid values are `initial|revised|supplemental|amendment|full_field|phase`',
    `planned_injector_count` STRING COMMENT 'Total number of injection wells planned in this development scenario. Includes water injectors, gas injectors, and wells used for Enhanced Oil Recovery (EOR) or Improved Oil Recovery (IOR) programs such as Water Alternating Gas (WAG), Steam-Assisted Gravity Drainage (SAGD), or Cyclic Steam Stimulation (CSS).',
    `planned_observation_well_count` STRING COMMENT 'Number of observation or monitoring wells planned for reservoir surveillance, pressure monitoring, and fluid movement tracking.',
    `planned_producer_count` STRING COMMENT 'Total number of producing wells planned in this development scenario. Includes oil producers, gas producers, and dual completion wells that will extract hydrocarbons from the reservoir.',
    `plateau_duration_years` DECIMAL(18,2) COMMENT 'Expected duration in years that the field will maintain plateau production rates before entering decline phase. Critical parameter for production forecasting and economic modeling.',
    `plateau_rate_gas_mmcfd` DECIMAL(18,2) COMMENT 'Target gas production rate during the plateau phase of field development, measured in million cubic feet per day. Represents the sustained maximum gas production rate before natural decline begins.',
    `plateau_rate_oil_bopd` DECIMAL(18,2) COMMENT 'Target oil production rate during the plateau phase of field development, measured in barrels of oil per day. Represents the sustained maximum production rate before natural decline begins.',
    `prms_reserves_category` STRING COMMENT 'SPE PRMS reserves classification for this development plan. 1P represents proved reserves, 2P represents proved plus probable reserves, 3P represents proved plus probable plus possible reserves. Used for technical reserves reporting and resource management.. Valid values are `1p|2p|3p|proved|probable|possible`',
    `processing_capacity_bopd` DECIMAL(18,2) COMMENT 'Design capacity of oil processing facilities in barrels of oil per day. Must accommodate peak production rates with appropriate safety margin.',
    `processing_capacity_mmcfd` DECIMAL(18,2) COMMENT 'Design capacity of gas processing facilities in million cubic feet per day. Must accommodate peak gas production rates with appropriate safety margin.',
    `recovery_factor_gas_percent` DECIMAL(18,2) COMMENT 'Percentage of Original Gas in Place (OGIP) that is expected to be recovered under this development plan. Key reservoir engineering metric for evaluating gas development effectiveness.',
    `recovery_factor_oil_percent` DECIMAL(18,2) COMMENT 'Percentage of Original Oil in Place (OOIP) or Stock Tank Oil Initially in Place (STOIIP) that is expected to be recovered under this development plan. Key reservoir engineering metric for evaluating development effectiveness.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether this development plan requires regulatory approval from Bureau of Safety and Environmental Enforcement (BSEE), Bureau of Ocean Energy Management (BOEM), state regulatory agencies, or other governmental authorities before execution.',
    `sec_reserves_category` STRING COMMENT 'SEC reserves classification for this development plan. PDP represents Proved Developed Producing, PDNP represents Proved Developed Non-Producing, PUD represents Proved Undeveloped. Used for financial reporting and SEC disclosure requirements.. Valid values are `pdp|pdnp|pud|probable|possible`',
    CONSTRAINT pk_development_plan PRIMARY KEY(`development_plan_id`)
) COMMENT 'Stores the Field Development Plan (FDP) and reservoir development scenarios including well count, well type, drilling schedule, facility requirements, production profiles, and economic parameters. Captures plan name, development scenario (base/upside/downside), planned producer count, planned injector count, development drilling start date, plateau rate target (BOPD/MMCFD), plateau duration, development CAPEX, development OPEX, NPV10, IRR, payout period, plan approval status, and approving authority. Links to production forecasts and reserves estimates.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` (
    `core_analysis_id` BIGINT COMMENT 'Unique identifier for the core analysis record. Primary key for the core analysis data product.',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Core analysis laboratory work is a direct cost charged to projects. Business process: cost allocation for core programs, AFE tracking, and working interest billing.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Core analysis is performed at lab facilities; results inform facility design (completion design, artificial lift selection). Lab facility capacity planning and facility design basis require this link.',
    `core_sample_id` BIGINT COMMENT 'Unique identifier assigned to the physical core sample in the laboratory inventory system. Links to sample tracking and chain of custody records.',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the reservoir being characterized by this core analysis. Links to reservoir master data for formation, field, and hydrocarbon type.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Core samples are taken from specific stratigraphic zones within a reservoir. Currently core_analysis has reservoir_id but not zone_id. Zone-level attribution is critical for petrophysical characteriza',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Core analysis is procured from qualified laboratories. Links petrophysical analysis to vendor qualification, API certification tracking, and service quality management. Removes denormalized laboratory',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the well from which the core sample was extracted. Links to well master data for location, operator, and drilling history.',
    `analysis_date` DATE COMMENT 'Date when the laboratory core analysis testing program was completed and results were finalized.',
    `analysis_status` STRING COMMENT 'Current workflow status of the core analysis program. Tracks progression from sample receipt through laboratory testing, quality control review, and final approval.. Valid values are `planned|in_progress|completed|qc_review|approved|rejected`',
    `analysis_type` STRING COMMENT 'Classification of the core analysis program. Routine analysis includes basic porosity and permeability; SCAL (Special Core Analysis) includes capillary pressure, relative permeability, and wettability studies.. Valid values are `routine|special|scal|advanced`',
    `bulk_density_g_cm3` DECIMAL(18,2) COMMENT 'Total density of the rock sample including both matrix and pore space, measured in grams per cubic centimeter. Used to calibrate density logs and calculate porosity.',
    `capillary_pressure_data_available` BOOLEAN COMMENT 'Boolean flag indicating whether capillary pressure versus saturation curves were measured as part of SCAL (Special Core Analysis). Capillary pressure data is critical for determining fluid contacts and initial saturation distributions.',
    `cementation_exponent_m` DECIMAL(18,2) COMMENT 'Archie equation cementation exponent relating formation factor to porosity (F = a / φ^m). Typically ranges from 1.8 to 2.2 for consolidated sandstones. Derived from core resistivity measurements and used for log-derived porosity calculations.',
    `comments` STRING COMMENT 'Free-form text field for additional observations, interpretations, or contextual information about the core analysis that does not fit in structured fields. May include geologist notes, laboratory technician observations, or data usage recommendations.',
    `core_type` STRING COMMENT 'Classification of the core sample acquisition method. Conventional cores are full-diameter samples cut during drilling; sidewall cores are smaller plugs extracted from the wellbore wall.. Valid values are `conventional|sidewall|rotary_sidewall|oriented|sponge|rubber_sleeve`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this core analysis record was first created in the data management system. Used for audit trail and data lineage tracking.',
    `formation_resistivity_factor` DECIMAL(18,2) COMMENT 'Ratio of brine-saturated rock resistivity to brine resistivity. Used to calibrate Archie equation parameters for resistivity log interpretation. Typically ranges from 1 to 1000 depending on porosity and tortuosity.',
    `gas_saturation_fraction` DECIMAL(18,2) COMMENT 'Fraction of pore space occupied by gas at reservoir conditions, expressed as a decimal (0.0 to 1.0). Important for gas reservoir characterization and gas cap modeling.',
    `grain_density_g_cm3` DECIMAL(18,2) COMMENT 'Density of the solid rock matrix material, measured in grams per cubic centimeter. Used to calibrate density log interpretations and calculate porosity from bulk density measurements.',
    `irreducible_water_saturation_fraction` DECIMAL(18,2) COMMENT 'Minimum water saturation that cannot be displaced by hydrocarbons, expressed as a decimal fraction. Determined from capillary pressure curves. Defines the maximum hydrocarbon saturation achievable in the reservoir.',
    `laboratory_location` STRING COMMENT 'Geographic location or city where the core analysis laboratory is situated. Important for logistics, sample transport, and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this core analysis record was last updated. Used for change tracking, audit compliance, and data synchronization across systems.',
    `lithology_description` STRING COMMENT 'Detailed textual description of the rock type, mineralogy, texture, and sedimentary structures observed in the core sample. Includes grain size, sorting, cementation, and visible porosity characteristics.',
    `measured_permeability_horizontal_md` DECIMAL(18,2) COMMENT 'Laboratory-measured permeability in the horizontal direction (parallel to bedding plane), expressed in millidarcies. Indicates the rocks ability to transmit fluids horizontally. Critical for production rate forecasting and well spacing decisions.',
    `measured_permeability_vertical_md` DECIMAL(18,2) COMMENT 'Laboratory-measured permeability in the vertical direction (perpendicular to bedding plane), expressed in millidarcies. Typically lower than horizontal permeability due to laminations. Important for vertical sweep efficiency in EOR (Enhanced Oil Recovery) programs.',
    `measured_porosity_fraction` DECIMAL(18,2) COMMENT 'Laboratory-measured porosity of the core sample expressed as a decimal fraction (0.0 to 1.0). Represents the pore volume as a fraction of total rock volume. Critical for OOIP (Original Oil in Place) and STOIIP (Stock Tank Oil Initially in Place) calculations.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this core analysis record. Used for audit trail and accountability in data governance processes.',
    `oil_saturation_fraction` DECIMAL(18,2) COMMENT 'Fraction of pore space occupied by oil at reservoir conditions, expressed as a decimal (0.0 to 1.0). Measured using Dean-Stark extraction or retort analysis. Critical for OOIP (Original Oil in Place) calculations.',
    `permeability_anisotropy_ratio` DECIMAL(18,2) COMMENT 'Ratio of horizontal to vertical permeability (Kh/Kv). Values greater than 1.0 indicate preferential horizontal flow. Critical for reservoir simulation grid design and EOR (Enhanced Oil Recovery) scheme selection.',
    `porosity_type` STRING COMMENT 'Classification of the porosity measurement. Total porosity includes all pore space; effective porosity excludes isolated pores; primary porosity is depositional; secondary porosity is from diagenesis or fracturing.. Valid values are `total|effective|primary|secondary|fracture|vuggy`',
    `primary_lithology` STRING COMMENT 'Dominant rock type classification of the core sample. Used for petrophysical model selection and reservoir quality assessment. [ENUM-REF-CANDIDATE: sandstone|limestone|dolomite|shale|siltstone|conglomerate|chalk|marl|coal|salt — 10 candidates stripped; promote to reference product]',
    `qc_notes` STRING COMMENT 'Detailed notes from quality control review documenting any anomalies, measurement uncertainties, sample handling issues, or deviations from standard procedures that may affect data reliability.',
    `quality_flag` STRING COMMENT 'Quality control assessment of the core analysis results. Considers sample preservation, measurement precision, data consistency, and adherence to laboratory protocols. Poor quality data may be excluded from reservoir modeling.. Valid values are `excellent|good|acceptable|questionable|poor|rejected`',
    `relative_permeability_gas_endpoint` DECIMAL(18,2) COMMENT 'Maximum relative permeability to gas at irreducible water saturation, expressed as a decimal fraction (0.0 to 1.0). Endpoint value from relative permeability curves used in gas reservoir simulation.',
    `relative_permeability_oil_endpoint` DECIMAL(18,2) COMMENT 'Maximum relative permeability to oil at irreducible water saturation, expressed as a decimal fraction (0.0 to 1.0). Endpoint value from relative permeability curves used in reservoir simulation.',
    `relative_permeability_water_endpoint` DECIMAL(18,2) COMMENT 'Maximum relative permeability to water at residual oil saturation, expressed as a decimal fraction (0.0 to 1.0). Endpoint value from relative permeability curves used in waterflood simulation.',
    `residual_oil_saturation_fraction` DECIMAL(18,2) COMMENT 'Oil saturation remaining after waterflooding or primary depletion, expressed as a decimal fraction. Represents the target for EOR (Enhanced Oil Recovery) programs such as WAG (Water Alternating Gas) or chemical flooding.',
    `sample_date` DATE COMMENT 'Date when the core sample was physically extracted from the wellbore during drilling or sidewall coring operations.',
    `sample_depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore trajectory where the core sample was extracted, measured in feet from the surface reference point.',
    `sample_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth of the core sample measured perpendicular to the surface, in feet. Used for pressure gradient calculations and reservoir modeling.',
    `saturation_exponent_n` DECIMAL(18,2) COMMENT 'Archie equation saturation exponent relating resistivity index to water saturation (Sw^-n). Typically close to 2.0 for water-wet rocks. Derived from core resistivity measurements at varying saturations and used for log-derived water saturation calculations.',
    `water_saturation_fraction` DECIMAL(18,2) COMMENT 'Fraction of pore space occupied by water at reservoir conditions, expressed as a decimal (0.0 to 1.0). Used to calibrate resistivity log interpretations and validate Archie equation parameters.',
    `wettability_index` DECIMAL(18,2) COMMENT 'Quantitative measure of rock wettability ranging from -1.0 (strongly oil-wet) to +1.0 (strongly water-wet). Measured using Amott-Harvey or USBM methods. Critical for selecting appropriate relative permeability curves and EOR (Enhanced Oil Recovery) methods.',
    CONSTRAINT pk_core_analysis PRIMARY KEY(`core_analysis_id`)
) COMMENT 'Stores laboratory core analysis results from conventional and special core analysis (SCAL) programs. Captures core sample identifier, well identifier, sample depth (MD/TVD), core type (conventional/sidewall/rotary sidewall), analysis type (routine/SCAL), measured porosity, measured permeability (horizontal/vertical), grain density, bulk density, fluid saturations (So/Sw/Sg), capillary pressure data, relative permeability (Kro/Krw/Krg), wettability index, formation resistivity factor, cementation exponent (m), saturation exponent (n), lab name, and analysis date. Calibrates petrophysical log interpretations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` (
    `equity_participation_id` BIGINT COMMENT 'Primary key for the reservoir_equity_participation association',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to the customer counterparty who is the equity partner in this reservoir',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to the reservoir in which the equity partner holds working interest',
    `agreement_reference_number` STRING COMMENT 'Reference number of the PSC or JOA agreement governing this specific equity participation arrangement.',
    `cost_recovery_status` STRING COMMENT 'Current status of cost recovery for this partner in this reservoir under PSC terms. Identified in detection phase as relationship-specific data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this equity participation record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this equity participation arrangement became effective for this partner-reservoir combination. Identified in detection phase as relationship-specific data.',
    `entitlement_calculation_method` STRING COMMENT 'The methodology used to calculate this partners entitlement from this reservoir (e.g., production-based, revenue-based, cost recovery first). Identified in detection phase as relationship-specific data.',
    `expiry_date` DATE COMMENT 'The date on which this equity participation arrangement expires or is scheduled to terminate for this partner-reservoir combination. Identified in detection phase as relationship-specific data.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this equity participation record was last modified.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of net revenue (after royalties and other burdens) to which this equity partner is entitled from this reservoir. Identified in detection phase as relationship-specific data.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether this equity partner is the designated operator for this reservoir.',
    `participation_status` STRING COMMENT 'Current lifecycle status of this equity participation arrangement.',
    `profit_oil_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of profit oil (after cost recovery) allocated to this equity partner from this reservoir under PSC arrangements. Identified in detection phase as relationship-specific data.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of working interest held by this equity partner in this specific reservoir, representing their share of capital costs and operating expenses. Identified in detection phase as relationship-specific data.',
    CONSTRAINT pk_equity_participation PRIMARY KEY(`equity_participation_id`)
) COMMENT 'This association product represents the equity participation contract between a reservoir and a customer counterparty (equity partner). It captures the working interest, net revenue interest, and profit-sharing arrangements specific to each partner-reservoir combination in Production Sharing Contracts (PSC) and Joint Operating Agreements (JOA). Each record links one reservoir to one equity partner with entitlement terms, cost recovery status, and profit distribution percentages that exist only in the context of this specific partnership arrangement.. Existence Justification: In upstream oil and gas operations, Production Sharing Contracts (PSC) and Joint Operating Agreements (JOA) create genuine many-to-many equity participation arrangements. A single reservoir commonly has multiple equity partners (IOCs, NOCs, independents) each holding different working interest percentages, and each partner typically holds interests across multiple reservoirs within a field or across multiple fields. The business actively manages these participation arrangements as distinct contractual entities with specific entitlement terms, cost recovery tracking, and profit distribution calculations that vary by partner-reservoir combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` (
    `scheme_well_assignment_id` BIGINT COMMENT 'Unique identifier for this EOR scheme well assignment record',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to the Enhanced Oil Recovery scheme that this well is assigned to support',
    `injection_well_id` BIGINT COMMENT 'Foreign key linking to the injection well participating in this EOR scheme',
    `assignment_end_date` DATE COMMENT 'Date when this injection wells participation in the EOR scheme ended (well reassigned, scheme completed, or well taken offline). Null if assignment is currently active',
    `assignment_start_date` DATE COMMENT 'Date when this injection well was assigned to participate in the EOR scheme and began injection operations for this specific scheme',
    `assignment_status` STRING COMMENT 'Current operational status of this wells assignment to the EOR scheme: active (currently injecting for scheme), suspended (temporarily offline), completed (scheme ended), reassigned (well moved to different scheme or pattern)',
    `cumulative_injection_bbl` DECIMAL(18,2) COMMENT 'Total volume in barrels injected by this well specifically for this EOR scheme since assignment start date, used for scheme-specific performance tracking and reservoir simulation calibration',
    `injection_pattern_role` STRING COMMENT 'The specific role this injection well plays within the EOR schemes injection pattern geometry (e.g., peripheral injector in five-spot, central injector, pattern edge position)',
    `pattern_position` STRING COMMENT 'Descriptive identifier for the wells physical position within the injection pattern (e.g., NW corner, Row 3 Position 5, Central)',
    `target_injection_rate_bpd` DECIMAL(18,2) COMMENT 'Target daily injection rate in barrels per day allocated to this specific well for this EOR scheme, which may differ from the wells overall permitted rate if participating in multiple schemes or zones',
    CONSTRAINT pk_scheme_well_assignment PRIMARY KEY(`scheme_well_assignment_id`)
) COMMENT 'This association product represents the operational assignment of injection wells to Enhanced Oil Recovery schemes. It captures the specific role each injection well plays within an EOR schemes injection pattern (five-spot, seven-spot, line drive), the wells position in the pattern, injection targets, and performance tracking. Each record links one EOR scheme to one injection well with attributes that exist only in the context of this assignment relationship.. Existence Justification: In oil and gas EOR operations, injection wells are strategically assigned to EOR schemes in specific geometric patterns (five-spot, seven-spot, line drive) where each well plays a defined role (peripheral injector, central injector, pattern edge). A single EOR scheme requires multiple injection wells working in coordinated patterns, and injection wells can participate in multiple EOR schemes simultaneously when targeting different reservoir zones or sequentially over time as schemes evolve. The business actively manages these assignments with scheme-specific injection targets, pattern roles, and performance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` (
    `eor_participation_id` BIGINT COMMENT 'Unique identifier for the EOR participation agreement record. Primary key.',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to the Enhanced Oil Recovery scheme',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner',
    `afe_number` STRING COMMENT 'Reference to the AFE (Authorization for Expenditure) document that governs this partners participation in the EOR scheme. Links to the capital approval and cost tracking system.',
    `back_in_threshold_boe` DECIMAL(18,2) COMMENT 'Cumulative production volume in barrels of oil equivalent (BOE) at which a non-consenting partner may exercise back-in rights to rejoin the EOR scheme. Null if partner is participating or no back-in provision exists.',
    `carried_interest_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this partners interest is being carried by other partners during the EOR scheme. True if partners costs are being funded by others with future recovery provisions.',
    `cost_sharing_percentage` DECIMAL(18,2) COMMENT 'The percentage of EOR scheme capital and operating costs that this partner is obligated to fund, expressed as a decimal fraction. May differ from participation_percentage if carried interest or non-consent provisions apply.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this participation record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this partners participation terms became effective for the EOR scheme. Typically aligned with scheme start date or AFE approval date, but may differ if partner exercised back-in rights or transferred interest.',
    `incremental_reserves_entitlement` DECIMAL(18,2) COMMENT 'The partners entitlement to incremental oil reserves generated by this EOR scheme, measured in barrels of oil equivalent (BOE). Calculated based on participation percentage and scheme target incremental recovery.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this participation record was last updated.',
    `non_consent_election` STRING COMMENT 'Partners election status for this EOR scheme under JOA non-consent provisions. Values: participating (partner is funding their share), non_consent (partner elected not to participate), back_in_pending (partner may exercise back-in rights), back_in_exercised (partner has re-entered after non-consent).',
    `non_consent_penalty_rate` DECIMAL(18,2) COMMENT 'Penalty multiplier applied to non-consenting partners share of costs if they later exercise back-in rights, expressed as a decimal (e.g., 3.000 for 300% penalty). Per JOA non-consent provisions.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'The partners working interest percentage in this specific EOR scheme, expressed as a decimal fraction (e.g., 0.35000 for 35%). May differ from base reservoir working interest due to non-consent elections or scheme-specific agreements.',
    `participation_status` STRING COMMENT 'Current lifecycle status of this participation agreement. Values: active (partner is currently participating), suspended (temporarily paused), terminated (participation ended), pending_approval (awaiting AFE or JOA approval).',
    `termination_date` DATE COMMENT 'Date when this partners participation in the EOR scheme ended, either due to scheme completion, interest transfer, or withdrawal. Null if participation is still active.',
    CONSTRAINT pk_eor_participation PRIMARY KEY(`eor_participation_id`)
) COMMENT 'This association product represents the participation agreement between an Enhanced Oil Recovery scheme and a joint venture partner. It captures scheme-specific working interests, cost sharing arrangements, carried interest provisions, non-consent elections, and incremental reserves entitlements that differ from base reservoir development agreements. Each record links one EOR scheme to one partner with participation terms that exist only in the context of this specific EOR project.. Existence Justification: In oil and gas joint ventures, EOR schemes frequently have different partner participation than base reservoir development. Partners can elect to participate or go non-consent on individual EOR projects based on technical risk, capital availability, and strategic priorities. Each EOR scheme-partner combination requires tracking of scheme-specific working interests, cost sharing obligations, carried interest provisions, non-consent elections, back-in rights, and incremental reserves entitlements that differ from the base JOA.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` (
    `eor_vendor_supply_agreement_id` BIGINT COMMENT 'Unique identifier for the EOR vendor supply agreement record. Primary key.',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to the Enhanced Oil Recovery scheme receiving supplies and services',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the procurement specialist or buyer managing the commercial aspects of this supply agreement.',
    `technical_contact_employee_id` BIGINT COMMENT 'Foreign key reference to the reservoir engineer or EOR technical lead responsible for managing this vendor relationship and ensuring supply meets scheme requirements.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing materials or services to the EOR scheme',
    `actual_volume_delivered` DECIMAL(18,2) COMMENT 'Cumulative actual volume delivered by the vendor to date under this agreement. Tracked for contract compliance and performance monitoring.',
    `agreement_status` STRING COMMENT 'Current status of the supply agreement: active (currently supplying), suspended (temporarily halted), completed (contract fulfilled), or terminated (ended early).',
    `contract_currency` STRING COMMENT 'Three-letter ISO currency code for the supply agreement pricing (USD, CAD, EUR, etc.).',
    `contract_end_date` DATE COMMENT 'Scheduled expiration or termination date of the supply agreement. May be extended or terminated early based on scheme performance.',
    `contract_start_date` DATE COMMENT 'Effective start date of the supply agreement for this EOR scheme-vendor relationship.',
    `contracted_volume` DECIMAL(18,2) COMMENT 'Total volume or quantity contracted from this vendor for the EOR scheme. Units vary by supply type: barrels for liquids, MCF for gas, tons for chemicals, or service hours for contractors.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was created in the system.',
    `delivery_terms` STRING COMMENT 'INCOTERMS or delivery terms for the supply agreement: FOB, CIF, DDP, or site-delivered. Defines responsibility for transportation and risk transfer.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this supply agreement record.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from order placement to delivery at the EOR scheme site. Critical for injection schedule planning.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity per delivery or per period as stipulated in the supply agreement. Ensures vendor can meet EOR scheme injection requirements.',
    `performance_guarantee` STRING COMMENT 'Specific performance guarantees or service level agreements committed by the vendor: chemical purity specifications, equipment uptime percentages, delivery lead times, or CO2 injection rate guarantees. Critical for EOR scheme success.',
    `purchase_order_number` STRING COMMENT 'Reference to the master purchase order or contract number in the procurement system (SAP, Oracle) governing this supply relationship.',
    `quality_rating` DECIMAL(18,2) COMMENT 'Vendor performance quality rating for this specific EOR scheme supply agreement, scored 0.00 to 5.00. Based on material quality, delivery timeliness, and performance guarantee adherence.',
    `supply_agreement_type` STRING COMMENT 'Classification of the supply agreement: chemical supply (polymer, surfactant, CO2), equipment supply (injection pumps, separators), service contract (steam generation, monitoring), or materials supply (catalysts, additives). Defines the nature of the vendors contribution to the EOR scheme.',
    `total_contract_value_usd` DECIMAL(18,2) COMMENT 'Total estimated or actual contract value in US dollars for this supply agreement over its full term. Calculated as contracted volume × unit price, converted to USD.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for the supplied material or service in the contract currency. Price per barrel, per MCF, per ton, or per hour depending on supply type.',
    `volume_unit` STRING COMMENT 'Unit of measure for contracted volume: BBL (barrels), MCF (thousand cubic feet), MT (metric tons), HR (hours), or EA (each for equipment).',
    CONSTRAINT pk_eor_vendor_supply_agreement PRIMARY KEY(`eor_vendor_supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between an Enhanced Oil Recovery scheme and its vendors. It captures procurement agreements for EOR-specific materials and services including chemical suppliers, steam generators, CO2 suppliers, and specialized equipment vendors. Each record links one EOR scheme to one vendor with contract terms, pricing, volumes, and performance guarantees that exist only in the context of this specific scheme-vendor relationship.. Existence Justification: In oil and gas EOR operations, a single Enhanced Oil Recovery scheme requires multiple vendors simultaneously (chemical supplier for polymers, CO2 supplier for gas injection, equipment vendor for pumps, service contractor for steam generation). Conversely, specialized EOR vendors supply multiple schemes across different fields and operators. The business actively manages these supply relationships as procurement contracts with scheme-specific pricing, volumes, delivery terms, and performance guarantees.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` (
    `reservoir_working_interest_id` BIGINT COMMENT 'Primary key for the reservoir_working_interest association',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to the reservoir in which the partner holds working interest',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner entity holding working interest in the reservoir',
    `assignment_agreement_reference` STRING COMMENT 'Reference number or identifier of the legal agreement that established this working interest (e.g., farmout agreement number, assignment deed reference, PSA contract number). Links to contract management system.',
    `carried_interest_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this partners interest is carried (costs borne by other partners) during a specified phase (e.g., exploration, development). If true, cost_allocation_percentage will be zero or reduced during the carry period.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The partners share of joint costs for reservoir development and operations. Typically equals working interest percentage but may differ under specific JOA terms (e.g., carried interest arrangements, non-consent penalties). Used for AFE billing and joint interest billing (JIB).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this working interest arrangement becomes legally effective. Corresponds to the effective date in the assignment agreement, farmout agreement, or PSA. Used for production allocation and cost recovery calculations.',
    `expiry_date` DATE COMMENT 'The date on which this working interest arrangement terminates or is scheduled to terminate. May be null for indefinite arrangements. Populated for term-limited PSAs, farmout earn-in periods, or relinquishment schedules.',
    `interest_status` STRING COMMENT 'Current lifecycle status of the working interest. Active = partner is currently bearing costs and receiving revenue. Pending = interest assigned but not yet effective. Relinquished = partner has surrendered interest. Farmed_Out = partner has assigned interest to another party. Suspended = interest temporarily inactive due to force majeure or regulatory action.',
    `is_operator` BOOLEAN COMMENT 'Boolean flag indicating whether this partner serves as the operator for this specific reservoir. Only one partner per reservoir should have this flag set to true. Operator has day-to-day operational control and submits AFEs on behalf of the joint venture.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this working interest record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this working interest record was last updated.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The partners proportionate share of production revenue after royalties, overriding royalties, and other burdens. NRI = WI × (1 - royalty burden). Used for revenue distribution and reserves booking.',
    `percentage` DECIMAL(18,2) COMMENT 'The partners proportionate ownership share in the reservoir, representing their obligation to bear costs and right to production. Sum of all partners WI for a reservoir must equal 100%. Used for AFE cost allocation and operational decision voting rights.',
    `reserves_entitlement_volume` DECIMAL(18,2) COMMENT 'The partners entitled share of proved reserves in the reservoir, calculated as total reservoir reserves × NRI percentage. Measured in MMBBL for oil or BCF for gas depending on reservoir type. Used for SEC reserves reporting and partner financial statements.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this working interest record.',
    CONSTRAINT pk_reservoir_working_interest PRIMARY KEY(`reservoir_working_interest_id`)
) COMMENT 'This association product represents the ownership and economic participation of venture partners in specific reservoirs. It captures the legal and financial relationship between partners and reservoirs, including working interest percentages, net revenue interest, reserves entitlement, and cost allocation. Each record links one partner to one reservoir with attributes that define the partners economic stake and obligations in that specific reservoir. This is the SSOT for partner-reservoir participation tracking, AFE cost allocation, and reserves booking by partner.. Existence Justification: In oil and gas joint ventures, multiple partners hold economic interests in multiple reservoirs simultaneously. Each partner-reservoir combination has distinct working interest percentages, net revenue interest, reserves entitlement, and cost allocation that are legally defined in JOAs, PSAs, or assignment agreements. The business actively manages these working interests through AFE approvals, revenue distribution, reserves booking, and partner billing—this is a core operational relationship, not an analytical correlation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`interference_test` (
    `interference_test_id` BIGINT COMMENT 'Primary key for interference_test',
    `reservoir_id` BIGINT COMMENT 'FK to reservoir.reservoir',
    `well_asset_id` BIGINT COMMENT 'Unique identifier of the well where the interference test was performed.',
    `parent_interference_test_id` BIGINT COMMENT 'Self-referencing FK on interference_test (parent_interference_test_id)',
    `analysis_method` STRING COMMENT 'Methodology used to interpret the interference test data.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test results were approved.',
    `approved_by` STRING COMMENT 'Name of the analyst or manager who approved the test results.',
    `comments` STRING COMMENT 'Free‑form notes captured by the operator or analyst.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interference test record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall quality and reliability of the test data.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the interference test concluded.',
    `eor_program` STRING COMMENT 'EOR/IOR scheme associated with the well during the test.',
    `equipment_used` STRING COMMENT 'Description of the hardware and tools employed for the interference test.',
    `flow_rate_bbl_per_day` DECIMAL(18,2) COMMENT 'Production or injection rate recorded during the test.',
    `fluid_type` STRING COMMENT 'Dominant fluid phase present in the wellbore during the test.',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the test data and analysis have been formally approved.',
    `operator_name` STRING COMMENT 'Name of the field operator who oversaw the test execution.',
    `permeability_md` DECIMAL(18,2) COMMENT 'Estimated permeability of the formation at test depth.',
    `porosity_percent` DECIMAL(18,2) COMMENT 'Estimated porosity of the formation at test depth.',
    `pressure_change_psi` DECIMAL(18,2) COMMENT 'Difference between final and initial pressure values.',
    `pressure_final_psi` DECIMAL(18,2) COMMENT 'Measured wellbore pressure at the end of the test.',
    `pressure_initial_psi` DECIMAL(18,2) COMMENT 'Measured wellbore pressure at the start of the test.',
    `prms_category` STRING COMMENT 'Classification of the reserve estimate according to SPE‑PRMS (Proved Developed Producing, Proved Undeveloped, Probable Developed Non‑producing).',
    `report_number` STRING COMMENT 'Reference number of the analytical report generated from the test.',
    `saturation_percent` DECIMAL(18,2) COMMENT 'Estimated fluid saturation of the formation at test depth.',
    `sec_filing_indicator` STRING COMMENT 'Flag indicating whether the test data is included in a regulatory filing with the SEC.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the interference test began.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Bottom‑hole temperature recorded during the test.',
    `test_date` DATE COMMENT 'Calendar date on which the test was scheduled or executed.',
    `test_depth_ft` DECIMAL(18,2) COMMENT 'Measured depth at which the interference test was conducted.',
    `test_duration_minutes` STRING COMMENT 'Total elapsed time of the test measured in minutes.',
    `test_location` STRING COMMENT 'Alphanumeric code identifying the geographic location of the test within the field.',
    `test_name` STRING COMMENT 'Human‑readable name or label assigned to the interference test.',
    `test_result_file_path` STRING COMMENT 'File system or object storage path to the raw test data file.',
    `test_status` STRING COMMENT 'Current lifecycle state of the test.',
    `test_type` STRING COMMENT 'Category of the interference test based on the pressure‑time methodology.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test record.',
    CONSTRAINT pk_interference_test PRIMARY KEY(`interference_test_id`)
) COMMENT 'Master reference table for interference_test. Referenced by interference_test_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `employee_id` BIGINT COMMENT 'Identifier of the personnel or crew that performed the sample collection.',
    `wellbore_id` BIGINT COMMENT 'Reference to the wellbore from which the sample originated.',
    `analysis_date` DATE COMMENT 'Date on which the sample was analyzed in the laboratory.',
    `analysis_lab` STRING COMMENT 'Name of the laboratory that performed the PVT or compositional analysis.',
    `collection_date` DATE COMMENT 'Date on which the sample was physically collected from the well.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `depth_md` DECIMAL(18,2) COMMENT 'Measured depth of the sample location in meters.',
    `fluid_type` STRING COMMENT 'Dominant fluid phase present in the sample.',
    `permeability_md` DECIMAL(18,2) COMMENT 'Measured permeability of the sample in millidarcies.',
    `porosity_percent` DECIMAL(18,2) COMMENT 'Measured porosity of the rock sample expressed as a percentage.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'In‑situ pressure at the sample depth, recorded in pounds per square inch.',
    `pvt_gas_specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the gas phase derived from PVT analysis.',
    `pvt_oil_api` DECIMAL(18,2) COMMENT 'API gravity of the oil phase derived from PVT analysis.',
    `remarks` STRING COMMENT 'Free‑form notes about sample quality, handling, or anomalies.',
    `sample_code` STRING COMMENT 'External code or tag assigned to the sample by field operations or laboratory.',
    `sample_name` STRING COMMENT 'Human‑readable name or description of the sample (e.g., "Upper Devonian Core").',
    `sample_type` STRING COMMENT 'Category of the sample indicating its physical nature.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the collected sample in milliliters.',
    `sample_weight_g` DECIMAL(18,2) COMMENT 'Weight of the sample in grams.',
    `sample_status` STRING COMMENT 'Current lifecycle state of the sample within the data repository.',
    `temperature_c` DECIMAL(18,2) COMMENT 'In‑situ temperature of the formation at the sample depth, recorded in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sample record.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ADD CONSTRAINT `fk_reservoir_zone_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`sample`(`sample_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ADD CONSTRAINT `fk_reservoir_material_balance_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ADD CONSTRAINT `fk_reservoir_material_balance_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_simulation_run_id` FOREIGN KEY (`simulation_run_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_run`(`simulation_run_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ADD CONSTRAINT `fk_reservoir_aquifer_model_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ADD CONSTRAINT `fk_reservoir_pressure_history_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ADD CONSTRAINT `fk_reservoir_pressure_history_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ADD CONSTRAINT `fk_reservoir_surveillance_plan_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ADD CONSTRAINT `fk_reservoir_model_update_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ADD CONSTRAINT `fk_reservoir_model_update_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ADD CONSTRAINT `fk_reservoir_injection_performance_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ADD CONSTRAINT `fk_reservoir_injection_performance_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_interference_test_id` FOREIGN KEY (`interference_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`interference_test`(`interference_test_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_target_zone_id` FOREIGN KEY (`target_zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_tracer_test_id` FOREIGN KEY (`tracer_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`tracer_test`(`tracer_test_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ADD CONSTRAINT `fk_reservoir_reservoir_sec_reserves_disclosure_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_simulation_model_id` FOREIGN KEY (`simulation_model_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_model`(`simulation_model_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ADD CONSTRAINT `fk_reservoir_equity_participation_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ADD CONSTRAINT `fk_reservoir_scheme_well_assignment_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ADD CONSTRAINT `fk_reservoir_eor_participation_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ADD CONSTRAINT `fk_reservoir_eor_vendor_supply_agreement_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ADD CONSTRAINT `fk_reservoir_reservoir_working_interest_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` ADD CONSTRAINT `fk_reservoir_interference_test_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` ADD CONSTRAINT `fk_reservoir_interference_test_parent_interference_test_id` FOREIGN KEY (`parent_interference_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`interference_test`(`interference_test_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`reservoir` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`reservoir` SET TAGS ('dbx_domain' = 'reservoir');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `field_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `active_well_count` SET TAGS ('dbx_business_glossary_term' = 'Active Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `areal_extent_acres` SET TAGS ('dbx_business_glossary_term' = 'Areal Extent in Acres');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `average_permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Average Permeability in Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `average_porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Porosity Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `base_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Base Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `co2_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `current_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Current Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `datum_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Datum Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `drive_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Drive Mechanism');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `drive_mechanism` SET TAGS ('dbx_value_regex' = 'solution_gas|water_drive|gas_cap|combination|gravity_drainage|compaction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `eor_program_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Program Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `eur_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Fluid Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `fluid_type` SET TAGS ('dbx_value_regex' = 'black_oil|volatile_oil|gas_condensate|dry_gas|wet_gas');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `gas_oil_contact_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Contact (GOC) True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `gor_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Stock Tank Barrel (SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `gross_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Gross Thickness in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `initial_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `last_simulation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Simulation Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Thickness in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `ogip_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas in Place (OGIP) in Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `oil_water_contact_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Oil-Water Contact (OWC) True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `ooip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil in Place (OOIP) in Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `prms_classification` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `recovery_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_code` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_name` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_status` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_status` SET TAGS ('dbx_value_regex' = 'active|depleted|shut_in|abandoned|under_evaluation|planned');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_type` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|gas_cap|oil_rim');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `stoiip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially in Place (STOIIP) in Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Temperature in Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `top_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Top Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `wor_bbl_bbl` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR) in Barrels per Barrel (BBL/BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `average_permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Average Permeability in Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `average_porosity_fraction` SET TAGS ('dbx_business_glossary_term' = 'Average Porosity Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `average_water_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Average Water Saturation Fraction (Sw)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `bottom_depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Bottom Depth Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `bottom_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Bottom Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `current_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Current Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `depositional_environment` SET TAGS ('dbx_business_glossary_term' = 'Depositional Environment');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Zone Discovery Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `drive_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Primary Drive Mechanism');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `drive_mechanism` SET TAGS ('dbx_value_regex' = 'solution-gas|gas-cap|water-drive|combination|gravity-drainage|compaction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `eor_method` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `eur_mmstb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Million Stock Tank Barrels (MMSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Dominant Fluid Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `fluid_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|water|oil-and-gas');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `gas_oil_contact_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Contact (GOC) True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `gas_water_contact_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Gas-Water Contact (GWC) True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `gross_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Gross Thickness in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `hydrocarbon_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Saturation Fraction (Sh)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `initial_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `lithology_description` SET TAGS ('dbx_business_glossary_term' = 'Lithology Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Thickness in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `net_to_gross_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net-to-Gross Ratio (NTG)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `ogip_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas in Place (OGIP) in Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `oil_water_contact_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Oil-Water Contact (OWC) True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `ooip_mmstb` SET TAGS ('dbx_business_glossary_term' = 'Original Oil in Place (OOIP) in Million Stock Tank Barrels (MMSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `permeability_range_max_md` SET TAGS ('dbx_business_glossary_term' = 'Maximum Permeability in Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `permeability_range_min_md` SET TAGS ('dbx_business_glossary_term' = 'Minimum Permeability in Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `porosity_type` SET TAGS ('dbx_business_glossary_term' = 'Porosity Type Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `porosity_type` SET TAGS ('dbx_value_regex' = 'matrix|fracture|vuggy|dual-porosity|triple-porosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `primary_lithology` SET TAGS ('dbx_business_glossary_term' = 'Primary Lithology Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `recovery_factor_fraction` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Fraction (RF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD|2P|3P');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `stoiip_mmstb` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially in Place (STOIIP) in Million Stock Tank Barrels (MMSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `top_depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Top Depth Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `top_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Top Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Production Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|depleted|undeveloped|shut-in|abandoned');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'pay|non-pay|transition|water-bearing|gas-cap|oil-leg');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `pvt_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure-Volume-Temperature (PVT) Analysis Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `hazardous_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|superseded');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `bubble_point_pressure` SET TAGS ('dbx_business_glossary_term' = 'Bubble Point Pressure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Analysis Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `composition_c1` SET TAGS ('dbx_business_glossary_term' = 'Methane (C1) Mole Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `composition_c2_c6` SET TAGS ('dbx_business_glossary_term' = 'Ethane through Hexane (C2-C6) Mole Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `composition_c7_plus` SET TAGS ('dbx_business_glossary_term' = 'Heptane Plus (C7+) Mole Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `composition_co2` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Mole Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `composition_h2s` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Mole Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `composition_n2` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen (N2) Mole Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `dew_point_pressure` SET TAGS ('dbx_business_glossary_term' = 'Dew Point Pressure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `eos_model_type` SET TAGS ('dbx_business_glossary_term' = 'Equation of State (EOS) Model Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `eos_model_type` SET TAGS ('dbx_value_regex' = 'peng_robinson|soave_redlich_kwong|benedict_webb_rubin|black_oil');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `eos_parameters` SET TAGS ('dbx_business_glossary_term' = 'Equation of State (EOS) Model Parameters');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Fluid Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `fluid_type` SET TAGS ('dbx_value_regex' = 'black_oil|volatile_oil|gas_condensate|dry_gas|wet_gas');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `gas_compressibility` SET TAGS ('dbx_business_glossary_term' = 'Gas Compressibility');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `gas_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Gas Formation Volume Factor (Bg)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `gas_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `gas_viscosity` SET TAGS ('dbx_business_glossary_term' = 'Gas Viscosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `oil_api_gravity` SET TAGS ('dbx_business_glossary_term' = 'Oil API (American Petroleum Institute) Gravity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `oil_compressibility` SET TAGS ('dbx_business_glossary_term' = 'Oil Compressibility');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `oil_density` SET TAGS ('dbx_business_glossary_term' = 'Oil Density');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `oil_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Oil Formation Volume Factor (Bo)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `oil_viscosity` SET TAGS ('dbx_business_glossary_term' = 'Oil Viscosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|questionable');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `reservoir_pressure` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `reservoir_temperature` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Temperature');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `sample_source_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Source Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `sample_source_type` SET TAGS ('dbx_value_regex' = 'DST|wellbore|separator|production_test|recombined');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `separator_pressure` SET TAGS ('dbx_business_glossary_term' = 'Separator Pressure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `separator_temperature` SET TAGS ('dbx_business_glossary_term' = 'Separator Temperature');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `shrinkage_factor` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Factor');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `solution_gor` SET TAGS ('dbx_business_glossary_term' = 'Solution Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `stock_tank_pressure` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Pressure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `stock_tank_temperature` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Temperature');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `z_factor` SET TAGS ('dbx_business_glossary_term' = 'Gas Compressibility Factor (Z-Factor)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `volumetric_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Estimate Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Geoscientist Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `zone_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_business_glossary_term' = 'Estimate Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `estimate_type` SET TAGS ('dbx_value_regex' = 'ooip|ogip|stoiip|giip');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `estimation_date` SET TAGS ('dbx_business_glossary_term' = 'Estimation Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'volumetric|material_balance|simulation|decline_curve|analogy|probabilistic');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `eur_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `formation_volume_factor_gas` SET TAGS ('dbx_business_glossary_term' = 'Gas Formation Volume Factor (Bg)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `formation_volume_factor_oil` SET TAGS ('dbx_business_glossary_term' = 'Oil Formation Volume Factor (Bo)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `gas_oil_ratio_scf_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Barrel (SCF/BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `gross_rock_volume_acre_ft` SET TAGS ('dbx_business_glossary_term' = 'Gross Rock Volume (GRV) in Acre-Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `net_rock_volume_acre_ft` SET TAGS ('dbx_business_glossary_term' = 'Net Rock Volume (NRV) in Acre-Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `net_to_gross_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net-to-Gross (NTG) Ratio');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Estimate Notes');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `ogip_high_p10_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas In Place (OGIP) High Estimate P10 in Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `ogip_low_p90_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas In Place (OGIP) Low Estimate P90 in Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `ogip_mid_p50_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas In Place (OGIP) Mid Estimate P50 in Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `ooip_high_p10_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil In Place (OOIP) High Estimate P10 in Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `ooip_low_p90_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil In Place (OOIP) Low Estimate P90 in Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `ooip_mid_p50_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil In Place (OOIP) Mid Estimate P50 in Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `porosity_fraction` SET TAGS ('dbx_business_glossary_term' = 'Porosity Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `recovery_factor_fraction` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `simulation_software` SET TAGS ('dbx_business_glossary_term' = 'Simulation Software');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `stoiip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially In Place (STOIIP) in Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `uncertainty_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Assessment Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `uncertainty_assessment_method` SET TAGS ('dbx_value_regex' = 'monte_carlo|deterministic|scenario_analysis|expert_judgment');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `volumetric_estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Estimate Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `volumetric_estimate_status` SET TAGS ('dbx_value_regex' = 'draft|approved|superseded|archived');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `water_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Water Saturation (Sw) Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Reserves Estimate Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `compliance_sec_reserves_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Sec Reserves Disclosure Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Engineer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) or Improved Oil Recovery (IOR) Program Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Discovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `certifying_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Certifying Engineer Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `economic_limit_date` SET TAGS ('dbx_business_glossary_term' = 'Economic Limit Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `estimate_number` SET TAGS ('dbx_business_glossary_term' = 'Reserves Estimate Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic|analogy|volumetric|material_balance|decline_curve');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `eur` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `eur_uom` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `eur_uom` SET TAGS ('dbx_value_regex' = 'BOE|BBL|MCF|MMCF|BCF');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `field_code` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `forecast_production_profile` SET TAGS ('dbx_business_glossary_term' = 'Forecast Production Profile');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `net_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `net_revenue_interest` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `net_revenue_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `npv` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `npv` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `npv_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Currency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `npv_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `ogip` SET TAGS ('dbx_business_glossary_term' = 'Original Gas in Place (OGIP)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `ooip` SET TAGS ('dbx_business_glossary_term' = 'Original Oil in Place (OOIP)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `p10_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'P10 Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `p50_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'P50 Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `p90_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'P90 Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `possible_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'Possible Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `probable_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'Probable Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'oil|gas|NGL|condensate');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `proved_reserves_volume` SET TAGS ('dbx_business_glossary_term' = 'Proved Reserves Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = '1P|2P|3P');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_sub_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Sub-Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_sub_category` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Reserves Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_volume_uom` SET TAGS ('dbx_value_regex' = 'BOE|BBL|MCF|MMCF|BCF');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `revision_type` SET TAGS ('dbx_business_glossary_term' = 'Revision Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `sec_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Price Per Unit');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `sec_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Pricing Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `sec_pricing_method` SET TAGS ('dbx_value_regex' = '12_month_average|spot_price|contract_price');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `working_interest` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `working_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Custodian Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Software Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `active_cells` SET TAGS ('dbx_business_glossary_term' = 'Active Grid Cells');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Model Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Model Approved By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `datum_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Datum Depth in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `datum_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Datum Pressure in Pounds per Square Inch (psi)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `eor_method` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `eur_gas_bcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery Gas in Billion Cubic Feet (EUR BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `eur_oil_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery Oil in Million Barrels (EUR MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `forecast_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `forecast_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `grid_dimension_i` SET TAGS ('dbx_business_glossary_term' = 'Grid Dimension I-Direction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `grid_dimension_j` SET TAGS ('dbx_business_glossary_term' = 'Grid Dimension J-Direction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `grid_dimension_k` SET TAGS ('dbx_business_glossary_term' = 'Grid Dimension K-Direction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `history_match_end_date` SET TAGS ('dbx_business_glossary_term' = 'History Match End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `history_match_start_date` SET TAGS ('dbx_business_glossary_term' = 'History Match Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `initialization_date` SET TAGS ('dbx_business_glossary_term' = 'Model Initialization Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `injector_well_count` SET TAGS ('dbx_business_glossary_term' = 'Injector Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `last_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Simulation Run Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_file_path` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model File Path');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_purpose` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Purpose');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'black_oil|compositional|thermal|streamline|dual_porosity|dual_permeability');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `ogip_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas in Place in Billion Cubic Feet (OGIP BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `ooip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil in Place in Million Barrels (OOIP MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `pressure_match_quality` SET TAGS ('dbx_business_glossary_term' = 'Pressure History Match Quality');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `pressure_match_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|not_evaluated');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `producer_well_count` SET TAGS ('dbx_business_glossary_term' = 'Producer Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `production_match_quality` SET TAGS ('dbx_business_glossary_term' = 'Production History Match Quality');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `production_match_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|not_evaluated');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `pvt_region_count` SET TAGS ('dbx_business_glossary_term' = 'Pressure-Volume-Temperature (PVT) Region Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `recovery_factor_gas_percent` SET TAGS ('dbx_business_glossary_term' = 'Gas Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `recovery_factor_oil_percent` SET TAGS ('dbx_business_glossary_term' = 'Oil Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `saturation_region_count` SET TAGS ('dbx_business_glossary_term' = 'Saturation Region Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `simulator_software` SET TAGS ('dbx_business_glossary_term' = 'Simulator Software Platform');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `simulator_version` SET TAGS ('dbx_business_glossary_term' = 'Simulator Software Version');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `stoiip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially in Place in Million Barrels (STOIIP MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `total_cells` SET TAGS ('dbx_business_glossary_term' = 'Total Grid Cells');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ALTER COLUMN `well_count` SET TAGS ('dbx_business_glossary_term' = 'Well Count in Model');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Engineer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `convergence_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Convergence Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `convergence_status` SET TAGS ('dbx_value_regex' = 'fully_converged|partially_converged|non_converged|not_applicable');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `convergence_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Convergence Tolerance Threshold');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `cpu_hours_consumed` SET TAGS ('dbx_business_glossary_term' = 'Central Processing Unit (CPU) Hours Consumed');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Economic Discount Rate (Percent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `eur_gas_bcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Gas (Billion Cubic Feet - BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `eur_oil_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Oil (Million Barrels - MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `gas_price_assumption_usd_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Price Assumption (United States Dollars per Thousand Cubic Feet - USD/MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `gas_price_assumption_usd_mcf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `gor_constraint_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) Constraint (Standard Cubic Feet per Stock Tank Barrel - SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `grid_cell_count` SET TAGS ('dbx_business_glossary_term' = 'Simulation Grid Cell Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `injection_rate_constraint_bopd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate Constraint (Barrels of Oil Per Day - BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `input_deck_file_path` SET TAGS ('dbx_business_glossary_term' = 'Simulation Input Deck File Path');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `max_iterations_per_timestep` SET TAGS ('dbx_business_glossary_term' = 'Maximum Iterations Per Timestep');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `npv_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) (United States Dollars - USD Millions)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `npv_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `oil_price_assumption_usd_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Price Assumption (United States Dollars per Barrel - USD/BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `oil_price_assumption_usd_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `output_file_path` SET TAGS ('dbx_business_glossary_term' = 'Simulation Output File Path');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `pressure_target_psi` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure Target (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `production_rate_constraint_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate Constraint (Barrels of Oil Per Day - BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `production_rate_constraint_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate Constraint (Thousand Cubic Feet per Day - MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'approved|under_review|rejected|preliminary|final');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `recovery_factor_gas_percent` SET TAGS ('dbx_business_glossary_term' = 'Gas Recovery Factor (Percent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `recovery_factor_oil_percent` SET TAGS ('dbx_business_glossary_term' = 'Oil Recovery Factor (Percent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = '1P|2P|3P|PDP|PUD|PDNP');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run End Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Engineer Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'history_match|sensitivity_analysis|forecast|optimization|probabilistic|deterministic');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Simulation Scenario Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `simulator_software` SET TAGS ('dbx_business_glossary_term' = 'Simulator Software Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `simulator_version` SET TAGS ('dbx_business_glossary_term' = 'Simulator Software Version');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `timestep_count` SET TAGS ('dbx_business_glossary_term' = 'Simulation Timestep Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `wor_constraint_fraction` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR) Constraint (Fraction)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `material_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Material Balance ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Approved By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `aquifer_influx_bbl` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Influx (We) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `aquifer_strength` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Strength Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `aquifer_strength` SET TAGS ('dbx_value_regex' = 'none|weak|moderate|strong|very strong');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculated_ogip_mcf` SET TAGS ('dbx_business_glossary_term' = 'Calculated Original Gas in Place (OGIP) in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculated_ooip_bbl` SET TAGS ('dbx_business_glossary_term' = 'Calculated Original Oil in Place (OOIP) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Calculation Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_confidence_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Calculation Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Calculation Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'Havlena-Odeh|Craft-Hawkins|Dake|Schilthuis|Tracy|Campbell');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_number` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Calculation Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Calculation Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|approved|superseded');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `compaction_drive_index` SET TAGS ('dbx_business_glossary_term' = 'Compaction Drive Index (CDI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `cumulative_gas_injection_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Gas Injection (Gi) in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `cumulative_gas_production_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Gas Production (Gp) in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `cumulative_oil_production_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Oil Production (Np) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `cumulative_water_injection_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Water Injection (Wi) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `cumulative_water_production_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Water Production (Wp) in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `current_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Current Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Data Quality Score');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `eor_program_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Program Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `estimated_ultimate_recovery_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `formation_water_expansion_term` SET TAGS ('dbx_business_glossary_term' = 'Formation and Water Expansion Term (Ef,w)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `gas_cap_drive_index` SET TAGS ('dbx_business_glossary_term' = 'Gas Cap Drive Index (GDI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `gas_cap_size_ratio` SET TAGS ('dbx_business_glossary_term' = 'Gas Cap Size Ratio (m)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `gas_expansion_term` SET TAGS ('dbx_business_glossary_term' = 'Gas Expansion Term (Eg)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `gas_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Gas Formation Volume Factor (Bg)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `initial_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `oil_expansion_term` SET TAGS ('dbx_business_glossary_term' = 'Oil Expansion Term (Eo)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `oil_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Oil Formation Volume Factor (Bo)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `recovery_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Calculation Remarks');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = '1P|2P|3P|PDP|PUD|PDNP');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `solution_gas_drive_index` SET TAGS ('dbx_business_glossary_term' = 'Solution Gas Drive Index (SDI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `solution_gor_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Solution Gas-Oil Ratio (GOR) in Standard Cubic Feet per Stock Tank Barrel (SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ALTER COLUMN `water_drive_index` SET TAGS ('dbx_business_glossary_term' = 'Water Drive Index (WDI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `pressure_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Survey Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|rejected');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `datum_corrected_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Datum Corrected Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `datum_elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Datum Elevation in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `flowing_bhp_psi` SET TAGS ('dbx_business_glossary_term' = 'Flowing Bottom Hole Pressure (FBHP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `fluid_gradient_psi_ft` SET TAGS ('dbx_business_glossary_term' = 'Fluid Gradient in Pounds per Square Inch per Foot (PSI/FT)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gas_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Gas Production Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gauge_accuracy_psi` SET TAGS ('dbx_business_glossary_term' = 'Gauge Accuracy in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gauge_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Gauge Calibration Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gauge_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Gauge Serial Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gauge_type` SET TAGS ('dbx_business_glossary_term' = 'Gauge Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gauge_type` SET TAGS ('dbx_value_regex' = 'mechanical|electronic|quartz|strain_gauge|fiber_optic|memory_gauge');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `gor_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Stock Tank Barrel (SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `material_balance_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `measured_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `perforation_interval_bottom_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Bottom Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `perforation_interval_top_ft` SET TAGS ('dbx_business_glossary_term' = 'Perforation Interval Top Depth in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `pressure_gradient_psi_ft` SET TAGS ('dbx_business_glossary_term' = 'Pressure Gradient in Pounds per Square Inch per Foot (PSI/FT)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `production_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `quality_control_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Notes');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `reservoir_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Temperature in Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `shut_in_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Time in Hours');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `stabilization_flag` SET TAGS ('dbx_business_glossary_term' = 'Stabilization Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `static_bhp_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Bottom Hole Pressure (SBHP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|validated|rejected|cancelled');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `survey_time` SET TAGS ('dbx_business_glossary_term' = 'Survey Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'BHP|BHT|RFT|MDT|DST|PLT');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `true_vertical_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `water_rate_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Water Production Rate in Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `wor_ratio` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `choke_size_64ths_inch` SET TAGS ('dbx_business_glossary_term' = 'Choke Size in 64ths of an Inch');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `drainage_radius_ft` SET TAGS ('dbx_business_glossary_term' = 'Drainage Radius in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `flow_period_count` SET TAGS ('dbx_business_glossary_term' = 'Flow Period Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `flowing_bottomhole_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Flowing Bottomhole Pressure (FBHP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `fsip_psi` SET TAGS ('dbx_business_glossary_term' = 'Final Shut-In Pressure (FSIP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `gas_flow_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `gor_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Stock Tank Barrel (SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `interpretation_model` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Model');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `interpretation_software` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Software');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `isip_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Shut-In Pressure (ISIP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `oil_flow_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Oil Flow Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Permeability in Millidarcies (md)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `permeability_thickness_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Permeability-Thickness (kh) in Millidarcy-Feet (md-ft)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `productivity_index_stb_day_psi` SET TAGS ('dbx_business_glossary_term' = 'Productivity Index (PI) in Stock Tank Barrels per Day per Pound per Square Inch (STB/day/psi)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `reserves_classification` SET TAGS ('dbx_business_glossary_term' = 'Reserves Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `reserves_classification` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD|probable|possible|unclassified');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `shutin_period_count` SET TAGS ('dbx_business_glossary_term' = 'Shut-In Period Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `skin_factor` SET TAGS ('dbx_business_glossary_term' = 'Skin Factor');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `static_bottomhole_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Static Bottomhole Pressure (SBHP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test End Date and Time');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_quality_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|invalid');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date and Time');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|suspended|cancelled|failed');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature in Degrees Fahrenheit (°F)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `water_flow_rate_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Water Flow Rate in Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `wellbore_storage_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Storage Coefficient');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `wor_ratio` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `production_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Production Forecast Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `approving_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Engineer Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `b_factor` SET TAGS ('dbx_business_glossary_term' = 'B-Factor (Hyperbolic Decline Exponent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'P10|P50|P90|deterministic');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `decline_rate_annual_percent` SET TAGS ('dbx_business_glossary_term' = 'Decline Rate Annual Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `decline_type` SET TAGS ('dbx_business_glossary_term' = 'Decline Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `decline_type` SET TAGS ('dbx_value_regex' = 'exponential|hyperbolic|harmonic');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `economic_limit_rate_boe_per_day` SET TAGS ('dbx_business_glossary_term' = 'Economic Limit Rate Barrel of Oil Equivalent (BOE) Per Day');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `eor_program_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Program Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `eur_boe_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Barrel of Oil Equivalent (BOE) Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `eur_gas_bcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Gas Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `eur_ngl_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Natural Gas Liquids (NGL) Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `eur_oil_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Oil Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_comments` SET TAGS ('dbx_business_glossary_term' = 'Forecast Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'decline_curve_analysis|reservoir_simulation|material_balance|analogy|empirical|integrated');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_scenario` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic|simulation_based|analogy_based|hybrid');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `gor_scf_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) Standard Cubic Feet (SCF) Per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `initial_production_rate_gas_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate Gas Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `initial_production_rate_oil_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate Oil Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `initial_production_rate_water_bwpd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production Rate Water Barrels of Water Per Day (BWPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `recovery_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'proved_developed_producing|proved_developed_non_producing|proved_undeveloped|probable|possible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `simulation_model_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `wor_bbl_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Water-Oil Ratio (WOR) Barrels Per Barrel (BBL/BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` SET TAGS ('dbx_subdomain' = 'enhanced_recovery');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Scheme ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Risk Assessment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Lead Employee ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Target Reservoir ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Simulation Model ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'EOR Scheme Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `deployment_scope` SET TAGS ('dbx_business_glossary_term' = 'Deployment Scope');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `deployment_scope` SET TAGS ('dbx_value_regex' = 'pilot|pattern|full_field');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `design_injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Injection Pressure (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `design_injection_rate_bpd` SET TAGS ('dbx_business_glossary_term' = 'Design Injection Rate (BPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `eor_type` SET TAGS ('dbx_business_glossary_term' = 'EOR Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX) USD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `estimated_opex_usd_per_year` SET TAGS ('dbx_business_glossary_term' = 'Estimated Operating Expenditure (OPEX) USD per Year');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `estimated_opex_usd_per_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `field_code` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `injectant_source` SET TAGS ('dbx_business_glossary_term' = 'Injectant Source');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `injectant_type` SET TAGS ('dbx_business_glossary_term' = 'Injectant Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `irr_percent` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `irr_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `npv_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) USD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `npv_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `number_of_injection_wells` SET TAGS ('dbx_business_glossary_term' = 'Number of Injection Wells');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `number_of_production_wells` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Wells');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Injection Pattern Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'PDP|PUD|PDNP|probable|possible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'EOR Scheme Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `scheme_name` SET TAGS ('dbx_business_glossary_term' = 'EOR Scheme Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `scheme_status` SET TAGS ('dbx_business_glossary_term' = 'EOR Scheme Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `scheme_status` SET TAGS ('dbx_value_regex' = 'design|pilot|active|suspended|abandoned|completed');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `sec_reporting_eligible` SET TAGS ('dbx_business_glossary_term' = 'SEC Reporting Eligible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'EOR Scheme Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `steam_oil_ratio_sor` SET TAGS ('dbx_business_glossary_term' = 'Steam-Oil Ratio (SOR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `target_incremental_oil_boe` SET TAGS ('dbx_business_glossary_term' = 'Target Incremental Oil (BOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `target_incremental_oil_mstb` SET TAGS ('dbx_business_glossary_term' = 'Target Incremental Oil (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `target_incremental_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Target Incremental Recovery Factor');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `wag_ratio` SET TAGS ('dbx_business_glossary_term' = 'Water Alternating Gas (WAG) Ratio');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` SET TAGS ('dbx_subdomain' = 'enhanced_recovery');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Event Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Scheme Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `cumulative_injection_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `cumulative_injection_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `cycle_phase` SET TAGS ('dbx_business_glossary_term' = 'Cycle Phase');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `cycle_phase` SET TAGS ('dbx_value_regex' = 'INJECTION|SOAK|PRODUCTION|IDLE');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `eor_method_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Method Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `hse_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `hse_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injected_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Injected Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injected_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Injected Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Injection Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_date` SET TAGS ('dbx_business_glossary_term' = 'Injection Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Injection Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Injection End Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_event_number` SET TAGS ('dbx_business_glossary_term' = 'Injection Event Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Injection Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Injection Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_quality_flag` SET TAGS ('dbx_value_regex' = 'NORMAL|OFF_SPEC|CONTAMINATED|DEGRADED|UNKNOWN');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Injection Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Injection Temperature in Fahrenheit');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'COMPLETED|IN_PROGRESS|SUSPENDED|ABORTED|PLANNED');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `simulated_injection_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Simulated Injection Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `variance_to_simulation_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance to Simulation Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_model_id` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_compressibility` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Compressibility');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_compressibility_unit` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Compressibility Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_compressibility_unit` SET TAGS ('dbx_value_regex' = '1/psi|1/bar|1/kPa');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_encroachment_angle` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Encroachment Angle');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_geometry` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Geometry');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_geometry` SET TAGS ('dbx_value_regex' = 'Radial|Linear|Bottom|Edge|Peripheral');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_initial_pressure` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Initial Pressure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_model_type` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Model Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_model_type` SET TAGS ('dbx_value_regex' = 'Schilthuis|van Everdingen-Hurst|Carter-Tracy|Fetkovich|Analytical|Numerical');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_name` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_outer_radius` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Outer Radius');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_permeability` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Permeability');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_permeability_unit` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Permeability Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_permeability_unit` SET TAGS ('dbx_value_regex' = 'mD|D');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_porosity` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Porosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_pressure_unit` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Pressure Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_pressure_unit` SET TAGS ('dbx_value_regex' = 'psi|bar|kPa');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_productivity_index` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Productivity Index (PI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_radius_unit` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Radius Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_radius_unit` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_strength_classification` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Strength Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_strength_classification` SET TAGS ('dbx_value_regex' = 'Strong|Moderate|Weak|Negligible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_thickness` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Thickness');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_thickness_unit` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Thickness Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_thickness_unit` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_water_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Water Formation Volume Factor (Bw)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `aquifer_water_viscosity` SET TAGS ('dbx_business_glossary_term' = 'Aquifer Water Viscosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `cumulative_water_influx` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Water Influx (We)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `cumulative_water_influx_unit` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Water Influx Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `cumulative_water_influx_unit` SET TAGS ('dbx_value_regex' = 'RB|STB|m3');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `material_balance_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Integration Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Model Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Model Calibration Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_calibration_method` SET TAGS ('dbx_business_glossary_term' = 'Model Calibration Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Model Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_confidence_level` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'Active|Under Review|Superseded|Archived');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `simulation_software` SET TAGS ('dbx_business_glossary_term' = 'Simulation Software');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ALTER COLUMN `water_influx_constant` SET TAGS ('dbx_business_glossary_term' = 'Water Influx Constant (B)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `petrophysical_interp_id` SET TAGS ('dbx_business_glossary_term' = 'Petrophysical Interp Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_hydrocarbon_saturation` SET TAGS ('dbx_business_glossary_term' = 'Average Hydrocarbon Saturation (Sh)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_permeability_horizontal` SET TAGS ('dbx_business_glossary_term' = 'Average Horizontal Permeability');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_permeability_vertical` SET TAGS ('dbx_business_glossary_term' = 'Average Vertical Permeability');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_porosity_effective` SET TAGS ('dbx_business_glossary_term' = 'Average Effective Porosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_porosity_total` SET TAGS ('dbx_business_glossary_term' = 'Average Total Porosity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_shale_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Shale Volume (Vsh)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `average_water_saturation` SET TAGS ('dbx_business_glossary_term' = 'Average Water Saturation (Sw)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `depth_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Depth Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `depth_unit_of_measure` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `gross_thickness` SET TAGS ('dbx_business_glossary_term' = 'Gross Thickness');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `hcpv_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Pore Volume (HCPV) Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `hcpv_unit_of_measure` SET TAGS ('dbx_value_regex' = 'acre-ft|m3|bbl');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `hydrocarbon_pore_volume` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Pore Volume (HCPV)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_value_regex' = 'Archie|Simandoux|Waxman-Smits|Indonesia|Dual Water|Total Shale');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interpretation_name` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|approved|superseded');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interval_bottom_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Interval Bottom Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interval_bottom_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Interval Bottom Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interval_top_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Interval Top Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `interval_top_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Interval Top Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `net_pay_thickness` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Thickness');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `net_pay_thickness` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `net_pay_thickness` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `net_to_gross_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net-to-Gross Ratio (NTG)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `permeability_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Permeability Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `permeability_unit_of_measure` SET TAGS ('dbx_value_regex' = 'mD|D|nD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `porosity_cutoff` SET TAGS ('dbx_business_glossary_term' = 'Porosity Cutoff');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|uncertain');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `shale_volume_cutoff` SET TAGS ('dbx_business_glossary_term' = 'Shale Volume (Vsh) Cutoff');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `software_used` SET TAGS ('dbx_business_glossary_term' = 'Software Used');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `water_saturation_cutoff` SET TAGS ('dbx_business_glossary_term' = 'Water Saturation (Sw) Cutoff');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `pressure_history_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure History Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `average_reservoir_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Average Reservoir Pressure (Pounds per Square Inch Absolute - PSIA)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `cumulative_gas_production_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Gas Production (Thousand Cubic Feet - MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `cumulative_injection_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `cumulative_oil_production_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Oil Production (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `cumulative_production_boe` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production (Barrel of Oil Equivalent - BOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `cumulative_water_production_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Water Production (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|unverified|suspect|estimated|provisional|final');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `datum_corrected_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Datum Corrected Pressure (Pounds per Square Inch Absolute - PSIA)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `datum_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Datum Depth (Feet - FT)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `depletion_rate_psi_per_month` SET TAGS ('dbx_business_glossary_term' = 'Depletion Rate (Pounds per Square Inch per Month - PSI/Month)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `eor_program_active` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Program Active');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `eor_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Scheme Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `history_match_quality` SET TAGS ('dbx_business_glossary_term' = 'History Match Quality');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `history_match_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|not_applicable');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `material_balance_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Material Balance Error (Percent - %)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `number_of_wells_measured` SET TAGS ('dbx_business_glossary_term' = 'Number of Wells Measured');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `pressure_gradient_psi_per_ft` SET TAGS ('dbx_business_glossary_term' = 'Pressure Gradient (Pounds per Square Inch per Foot - PSI/FT)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `pressure_source_type` SET TAGS ('dbx_business_glossary_term' = 'Pressure Source Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `pressure_source_type` SET TAGS ('dbx_value_regex' = 'measured|simulated|interpolated|extrapolated|history_matched|estimated');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `pressure_support_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pressure Support Mechanism');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `pressure_uncertainty_psia` SET TAGS ('dbx_business_glossary_term' = 'Pressure Uncertainty (Pounds per Square Inch Absolute - PSIA)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `reserves_category` SET TAGS ('dbx_value_regex' = 'pdp|pdnp|pud|probable|possible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ALTER COLUMN `simulation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `decline_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `analysis_name` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Analysis (DCA) Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Analysis Aggregation Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `analysis_type` SET TAGS ('dbx_value_regex' = 'well|reservoir_aggregate|field_aggregate|zone_aggregate');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Approval Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|superseded');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Approver Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `b_factor_hyperbolic_exponent` SET TAGS ('dbx_business_glossary_term' = 'Hyperbolic Exponent (b-factor)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Analysis Comments and Notes');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `cumulative_production_gas_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production Gas in Million Cubic Feet (MMCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `cumulative_production_ngl_mstb` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production Natural Gas Liquids (NGL) in Thousand Stock Tank Barrels (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `cumulative_production_oil_mstb` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Production Oil in Thousand Stock Tank Barrels (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `dca_software_name` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Analysis (DCA) Software Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `dca_software_version` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Analysis (DCA) Software Version');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `decline_type` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `decline_type` SET TAGS ('dbx_value_regex' = 'exponential|hyperbolic|harmonic|modified_hyperbolic');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `di_initial_decline_rate` SET TAGS ('dbx_business_glossary_term' = 'Initial Decline Rate (Di)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `economic_limit_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Economic Limit Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `eur_boe_mstb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Thousand Barrels of Oil Equivalent (MBOE)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `eur_gas_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Gas in Million Cubic Feet (MMCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `eur_ngl_mstb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Natural Gas Liquids (NGL) in Thousand Stock Tank Barrels (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `eur_oil_mstb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Oil in Thousand Stock Tank Barrels (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `forecast_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `forecast_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `ip_gas_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Gas Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `ip_ngl_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Natural Gas Liquids (NGL) Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `ip_oil_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Oil Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `prms_reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `prms_reserves_category` SET TAGS ('dbx_value_regex' = '1P|2P|3P|proved|probable|possible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `production_history_months` SET TAGS ('dbx_business_glossary_term' = 'Production History Duration in Months');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `r_squared_fit_quality` SET TAGS ('dbx_business_glossary_term' = 'R-Squared Fit Quality Coefficient');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `remaining_reserves_gas_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Remaining Reserves Gas in Million Cubic Feet (MMCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `remaining_reserves_ngl_mstb` SET TAGS ('dbx_business_glossary_term' = 'Remaining Reserves Natural Gas Liquids (NGL) in Thousand Stock Tank Barrels (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `remaining_reserves_oil_mstb` SET TAGS ('dbx_business_glossary_term' = 'Remaining Reserves Oil in Thousand Stock Tank Barrels (MSTB)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `sec_reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `sec_reserves_category` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `terminal_decline_rate` SET TAGS ('dbx_business_glossary_term' = 'Terminal Decline Rate');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `surveillance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Plan Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Risk Assessment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated (United States Dollar)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `budget_allocated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `budget_spent_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Spent (United States Dollar)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `budget_spent_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Plan Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `data_integration_system` SET TAGS ('dbx_business_glossary_term' = 'Data Integration System');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `data_quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Requirements');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `eor_program_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Program Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiration Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `fluid_sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fluid Sampling Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `fluid_sampling_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `key_performance_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `model_update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Model Update Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `model_update_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual|biennial|on_demand');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Plan Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Plan Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Plan Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Plan Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'routine|special|eor_monitoring|reservoir_study|regulatory_compliance|integrated');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `pressure_survey_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pressure Survey Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `pressure_survey_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand|continuous');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `production_logging_frequency` SET TAGS ('dbx_business_glossary_term' = 'Production Logging Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `production_logging_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `regulatory_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Required Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `risk_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Completed Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `saturation_monitoring_planned` SET TAGS ('dbx_business_glossary_term' = 'Saturation Monitoring Planned Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `seismic_4d_frequency` SET TAGS ('dbx_business_glossary_term' = '4D Seismic Survey Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `seismic_4d_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|five_year|on_demand');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `seismic_4d_planned` SET TAGS ('dbx_business_glossary_term' = '4D Seismic Planned Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `surveillance_objectives` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Objectives');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `tracer_test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Tracer Test Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `tracer_test_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|on_demand');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `tracer_test_planned` SET TAGS ('dbx_business_glossary_term' = 'Tracer Test Planned Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `well_test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Well Test Frequency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ALTER COLUMN `well_test_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|on_demand');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` SET TAGS ('dbx_subdomain' = 'production_forecast');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Tracer Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'First Breakthrough Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `channeling_indicator` SET TAGS ('dbx_business_glossary_term' = 'Channeling Indicator');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `channeling_indicator` SET TAGS ('dbx_value_regex' = 'none|suspected|confirmed|severe');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `connectivity_quality` SET TAGS ('dbx_business_glossary_term' = 'Inter-Well Connectivity Quality');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `connectivity_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|moderate|poor|none');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `detection_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit (Parts Per Million - PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `environmental_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `first_breakthrough_date` SET TAGS ('dbx_business_glossary_term' = 'First Tracer Breakthrough Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Injection Concentration (Parts Per Million - PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_date` SET TAGS ('dbx_business_glossary_term' = 'Tracer Injection Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Injection End Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Injection Pressure (Pounds per Square Inch - PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_rate_bpd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate (Barrels Per Day - BPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `injection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Injection Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Completion Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|preliminary|final|peer_reviewed');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `monitoring_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `monitoring_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `peak_breakthrough_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Breakthrough Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `peak_breakthrough_time_days` SET TAGS ('dbx_business_glossary_term' = 'Peak Breakthrough Time (Days)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `peak_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Peak Tracer Concentration (Parts Per Million - PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `producer_well_count` SET TAGS ('dbx_business_glossary_term' = 'Producer Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `sampling_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency (Days)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `swept_pore_volume_fraction` SET TAGS ('dbx_business_glossary_term' = 'Swept Pore Volume Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_code` SET TAGS ('dbx_business_glossary_term' = 'Tracer Test Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Test Cost (United States Dollars - USD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Tracer Test Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|injection_complete|monitoring|analysis|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_mass_injected_kg` SET TAGS ('dbx_business_glossary_term' = 'Tracer Mass Injected (Kilograms - KG)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_name` SET TAGS ('dbx_business_glossary_term' = 'Tracer Material Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Tracer Recovery Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_type` SET TAGS ('dbx_business_glossary_term' = 'Tracer Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ALTER COLUMN `tracer_volume_injected_bbl` SET TAGS ('dbx_business_glossary_term' = 'Tracer Volume Injected (Barrels - BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `model_update_id` SET TAGS ('dbx_business_glossary_term' = 'Model Update Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Model Update Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Model Update Approval Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|superseded');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Model Update Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `data_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Data Cutoff Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `documentation_file_path` SET TAGS ('dbx_business_glossary_term' = 'Documentation File Storage Path');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `documentation_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `eur_variance_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Variance Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `history_match_quality` SET TAGS ('dbx_business_glossary_term' = 'History Match Quality Assessment');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `history_match_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|poor|not_applicable');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `key_changes_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Changes Summary');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `model_file_path` SET TAGS ('dbx_business_glossary_term' = 'Model File Storage Path');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `model_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `new_wells_included_count` SET TAGS ('dbx_business_glossary_term' = 'New Wells Included Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `ooip_variance_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil In Place (OOIP) Variance Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Completion Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|approved|rejected|conditional_approval');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `previous_eur_oil_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Previous Estimated Ultimate Recovery (EUR) Oil Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `previous_ooip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Previous Original Oil In Place (OOIP) Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `prms_classification` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `reserves_category_impact` SET TAGS ('dbx_business_glossary_term' = 'Reserves Category Impact');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `simulator_software` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Simulator Software');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `simulator_version` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Simulator Software Version');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `uncertainty_assessment` SET TAGS ('dbx_business_glossary_term' = 'Model Uncertainty Assessment');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `uncertainty_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_date` SET TAGS ('dbx_business_glossary_term' = 'Model Update Completion Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_description` SET TAGS ('dbx_business_glossary_term' = 'Model Update Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_number` SET TAGS ('dbx_business_glossary_term' = 'Model Update Sequence Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_scope` SET TAGS ('dbx_business_glossary_term' = 'Model Update Scope');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_scope` SET TAGS ('dbx_value_regex' = 'full_field|sector|zone|well_area|regional');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_trigger` SET TAGS ('dbx_business_glossary_term' = 'Model Update Trigger Event');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `update_type` SET TAGS ('dbx_business_glossary_term' = 'Model Update Type Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_eur_gas_bcf` SET TAGS ('dbx_business_glossary_term' = 'Updated Estimated Ultimate Recovery (EUR) Gas Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_eur_oil_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Updated Estimated Ultimate Recovery (EUR) Oil Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_ogip_bcf` SET TAGS ('dbx_business_glossary_term' = 'Updated Original Gas In Place (OGIP) Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_ooip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Updated Original Oil In Place (OOIP) Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_recovery_factor_gas_percent` SET TAGS ('dbx_business_glossary_term' = 'Updated Gas Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_recovery_factor_oil_percent` SET TAGS ('dbx_business_glossary_term' = 'Updated Oil Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ALTER COLUMN `updated_stoiip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Updated Stock Tank Oil Initially In Place (STOIIP) Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` SET TAGS ('dbx_subdomain' = 'enhanced_recovery');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Performance Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `bottomhole_injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Bottomhole Injection Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `conformance_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Conformance Issue Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `conformance_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Conformance Issue Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `cumulative_injection_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `cumulative_injection_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|suspect|invalid|missing');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'pi_system|scada|manual_entry|well_test|allocation_system');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `field_code` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `fracture_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Fracture Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `gas_quality_co2_percent` SET TAGS ('dbx_business_glossary_term' = 'Gas Quality Carbon Dioxide (CO2) Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `gross_injection_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gross Injection Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `gross_injection_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gross Injection Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injected_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Injected Fluid Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injected_fluid_type` SET TAGS ('dbx_value_regex' = 'water|gas|steam|co2|polymer|surfactant');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_availability_percent` SET TAGS ('dbx_business_glossary_term' = 'Injection Availability Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Injection Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Injection Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Injection Period End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Injection Period Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_pressure_margin_psi` SET TAGS ('dbx_business_glossary_term' = 'Injection Pressure Margin in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_profile_zone_1_percent` SET TAGS ('dbx_business_glossary_term' = 'Injection Profile Zone 1 Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_profile_zone_2_percent` SET TAGS ('dbx_business_glossary_term' = 'Injection Profile Zone 2 Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_profile_zone_3_percent` SET TAGS ('dbx_business_glossary_term' = 'Injection Profile Zone 3 Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_rate_bpd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate in Barrels Per Day (BPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Injection Rate in Thousand Cubic Feet Per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Injection Scheme Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Injection Temperature in Degrees Fahrenheit (°F)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injection_uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Injection Uptime Hours');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `injectivity_index_bpd_psi` SET TAGS ('dbx_business_glossary_term' = 'Injectivity Index in Barrels Per Day per Pounds per Square Inch (BPD/PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'injecting|shut_in|suspended|maintenance|testing|offline');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `polymer_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Polymer Concentration in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `steam_quality_percent` SET TAGS ('dbx_business_glossary_term' = 'Steam Quality Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `sweep_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Sweep Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `voidage_replacement_ratio` SET TAGS ('dbx_business_glossary_term' = 'Voidage Replacement Ratio (VRR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `water_quality_suspended_solids_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Suspended Solids in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `water_quality_tds_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Total Dissolved Solids (TDS) in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ALTER COLUMN `wellhead_injection_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Wellhead Injection Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_id` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Source Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_well_pair_target_well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Target Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Geoscientist Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `interference_test_id` SET TAGS ('dbx_business_glossary_term' = 'Interference Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Source Reservoir Zone Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `target_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Target Reservoir Zone Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `tracer_test_id` SET TAGS ('dbx_business_glossary_term' = 'Tracer Test Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `barrier_description` SET TAGS ('dbx_business_glossary_term' = 'Barrier Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `barrier_type` SET TAGS ('dbx_business_glossary_term' = 'Barrier Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `barrier_type` SET TAGS ('dbx_value_regex' = 'sealing_fault|partial_fault|shale_barrier|tight_zone|stratigraphic_pinchout|diagenetic_barrier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_name` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Study Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_status` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_status` SET TAGS ('dbx_value_regex' = 'confirmed|probable|possible|uncertain|disproven');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `connectivity_type` SET TAGS ('dbx_value_regex' = 'pressure|fluid|both|none');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Evidence Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'pressure_equalization|tracer_breakthrough|production_response|interference_test|seismic_attribute|geological_model');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `fault_transmissibility_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Fault Transmissibility Multiplier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `geoscientist_name` SET TAGS ('dbx_business_glossary_term' = 'Geoscientist Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `impact_on_development` SET TAGS ('dbx_business_glossary_term' = 'Impact on Development Planning');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `impact_on_eor` SET TAGS ('dbx_business_glossary_term' = 'Impact on Enhanced Oil Recovery (EOR)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `pressure_equalization_observed` SET TAGS ('dbx_business_glossary_term' = 'Pressure Equalization Observed Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `production_response_observed` SET TAGS ('dbx_business_glossary_term' = 'Production Response Observed Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'verified|unverified|under_review|rejected');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `source_fault_block` SET TAGS ('dbx_business_glossary_term' = 'Source Fault Block');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Strength');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `strength` SET TAGS ('dbx_value_regex' = 'strong|moderate|weak|none');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `supporting_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Data Reference');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `target_fault_block` SET TAGS ('dbx_business_glossary_term' = 'Target Fault Block');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `tracer_breakthrough_observed` SET TAGS ('dbx_business_glossary_term' = 'Tracer Breakthrough Observed Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ALTER COLUMN `well_spacing_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Well Spacing Recommendation');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reservoir_sec_reserves_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir SEC (Securities and Exchange Commission) Reserves Disclosure ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `boe_reserves_mmboe` SET TAGS ('dbx_business_glossary_term' = 'BOE (Barrel of Oil Equivalent) Reserves MMBOE (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Reference');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `disclosure_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|amended|archived');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `disclosure_year` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Year');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `field_code` SET TAGS ('dbx_business_glossary_term' = 'Field ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_cash_inflows_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Future Cash Inflows USD (United States Dollars) MM (Million)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_cash_inflows_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_development_costs_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Future Development Costs USD (United States Dollars) MM (Million)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_development_costs_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_income_tax_expense_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Future Income Tax Expense USD (United States Dollars) MM (Million)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_income_tax_expense_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_production_costs_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Future Production Costs USD (United States Dollars) MM (Million)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `future_production_costs_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `gas_price_usd_per_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Price USD (United States Dollars) per MCF (Thousand Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `gas_reserves_bcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Reserves BCF (Billion Cubic Feet)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `independent_engineer_firm` SET TAGS ('dbx_business_glossary_term' = 'Independent Engineer Firm');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `ngl_price_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'NGL (Natural Gas Liquids) Price USD (United States Dollars) per BBL (Barrel)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `ngl_reserves_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'NGL (Natural Gas Liquids) Reserves MMBBL (Million Barrels)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `oil_price_usd_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Price USD (United States Dollars) per BBL (Barrel)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `oil_reserves_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Reserves MMBBL (Million Barrels)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `prior_year_reserves_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Reserves MMBOE (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `prms_classification` SET TAGS ('dbx_business_glossary_term' = 'PRMS (Petroleum Resources Management System) Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `prms_classification` SET TAGS ('dbx_value_regex' = '1P|2P|3P');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `proved_reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Proved Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `proved_reserves_category` SET TAGS ('dbx_value_regex' = 'PDP|PDNP|PUD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reporting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reserves_additions_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Reserves Additions MMBOE (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reserves_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Reserves Change Reason');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reserves_change_reason` SET TAGS ('dbx_value_regex' = 'revisions|extensions|discoveries|purchases|sales|production');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reserves_production_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Reserves Production MMBOE (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reserves_revisions_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Reserves Revisions MMBOE (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `reserves_sales_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Reserves Sales MMBOE (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `sec_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'SEC (Securities and Exchange Commission) Pricing Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `sec_pricing_method` SET TAGS ('dbx_value_regex' = '12_month_average_first_day|spot_price|other');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `sec_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'SEC (Securities and Exchange Commission) Submission Reference');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `smdfncf_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'SMDFNCF (Standardized Measure of Discounted Future Net Cash Flows) USD (United States Dollars) MM (Million)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ALTER COLUMN `smdfncf_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `hse_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Risk Assessment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `simulation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Authority');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_capex_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Development Capital Expenditure (CAPEX) United States Dollars (USD) Millions (MM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_capex_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_drilling_start_date` SET TAGS ('dbx_business_glossary_term' = 'Development Drilling Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_opex_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Development Operating Expenditure (OPEX) United States Dollars (USD) Millions (MM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_opex_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_scenario` SET TAGS ('dbx_business_glossary_term' = 'Development Scenario Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `environmental_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Completed Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eor_program_type` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Program Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eur_gas_bcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Gas Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eur_gas_bcf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eur_ngl_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Natural Gas Liquids (NGL) Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eur_ngl_mmbbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eur_oil_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Oil Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `eur_oil_mmbbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'onshore|offshore_platform|fpso|subsea_tieback|flng|wellhead_only');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `field_code` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `gas_price_assumption_usd_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Price Assumption United States Dollars (USD) per Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `gas_price_assumption_usd_mcf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `irr_percent` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `irr_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `npv10_usd_mm` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value at 10 Percent Discount Rate (NPV10) United States Dollars (USD) Millions (MM)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `npv10_usd_mm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `oil_price_assumption_usd_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Price Assumption United States Dollars (USD) per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `oil_price_assumption_usd_bbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `payout_period_years` SET TAGS ('dbx_business_glossary_term' = 'Payout Period Years');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `payout_period_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Code');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Field Development Plan (FDP) Name');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'initial|revised|supplemental|amendment|full_field|phase');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `planned_injector_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Injector Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `planned_observation_well_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Observation Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `planned_producer_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Producer Well Count');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plateau_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Plateau Duration Years');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plateau_rate_gas_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Plateau Rate Gas Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `plateau_rate_oil_bopd` SET TAGS ('dbx_business_glossary_term' = 'Plateau Rate Oil Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `prms_reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `prms_reserves_category` SET TAGS ('dbx_value_regex' = '1p|2p|3p|proved|probable|possible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `processing_capacity_bopd` SET TAGS ('dbx_business_glossary_term' = 'Processing Capacity Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `processing_capacity_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Processing Capacity Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `recovery_factor_gas_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Gas Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `recovery_factor_oil_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Oil Percent');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `sec_reserves_category` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Reserves Category');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `sec_reserves_category` SET TAGS ('dbx_value_regex' = 'pdp|pdnp|pud|probable|possible');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `core_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Core Analysis Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `core_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Core Sample Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Completion Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|qc_review|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Analysis Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_value_regex' = 'routine|special|scal|advanced');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `bulk_density_g_cm3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density in Grams per Cubic Centimeter (g/cm³)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `capillary_pressure_data_available` SET TAGS ('dbx_business_glossary_term' = 'Capillary Pressure Data Available Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `cementation_exponent_m` SET TAGS ('dbx_business_glossary_term' = 'Cementation Exponent (m) - Archie Parameter');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Analysis Comments');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `core_type` SET TAGS ('dbx_business_glossary_term' = 'Core Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `core_type` SET TAGS ('dbx_value_regex' = 'conventional|sidewall|rotary_sidewall|oriented|sponge|rubber_sleeve');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `formation_resistivity_factor` SET TAGS ('dbx_business_glossary_term' = 'Formation Resistivity Factor (F)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `gas_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Gas Saturation (Sg) Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `grain_density_g_cm3` SET TAGS ('dbx_business_glossary_term' = 'Grain Density in Grams per Cubic Centimeter (g/cm³)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `irreducible_water_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Irreducible Water Saturation (Swirr) Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `laboratory_location` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Location');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `lithology_description` SET TAGS ('dbx_business_glossary_term' = 'Lithology Description');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `measured_permeability_horizontal_md` SET TAGS ('dbx_business_glossary_term' = 'Measured Horizontal Permeability in Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `measured_permeability_vertical_md` SET TAGS ('dbx_business_glossary_term' = 'Measured Vertical Permeability in Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `measured_porosity_fraction` SET TAGS ('dbx_business_glossary_term' = 'Measured Porosity Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `oil_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Oil Saturation (So) Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `permeability_anisotropy_ratio` SET TAGS ('dbx_business_glossary_term' = 'Permeability Anisotropy Ratio (Kh/Kv)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `porosity_type` SET TAGS ('dbx_business_glossary_term' = 'Porosity Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `porosity_type` SET TAGS ('dbx_value_regex' = 'total|effective|primary|secondary|fracture|vuggy');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `primary_lithology` SET TAGS ('dbx_business_glossary_term' = 'Primary Lithology Classification');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `qc_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Notes');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|questionable|poor|rejected');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `relative_permeability_gas_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Relative Permeability to Gas (Krg) Endpoint');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `relative_permeability_oil_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Relative Permeability to Oil (Kro) Endpoint');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `relative_permeability_water_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Relative Permeability to Water (Krw) Endpoint');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `residual_oil_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Residual Oil Saturation (Sor) Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `sample_depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Sample Depth Measured Depth (MD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `sample_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Sample Depth True Vertical Depth (TVD) in Feet');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `saturation_exponent_n` SET TAGS ('dbx_business_glossary_term' = 'Saturation Exponent (n) - Archie Parameter');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `water_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Water Saturation (Sw) Fraction');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ALTER COLUMN `wettability_index` SET TAGS ('dbx_business_glossary_term' = 'Wettability Index (Amott-Harvey)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` SET TAGS ('dbx_association_edges' = 'reservoir.reservoir,customer.customer_counterparty');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `equity_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Equity Participation - Reservoir Equity Participation Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Equity Participation - Customer Counterparty Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Equity Participation - Reservoir Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `cost_recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `entitlement_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Calculation Method');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Expiry Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `profit_oil_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Share Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `profit_oil_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` SET TAGS ('dbx_subdomain' = 'enhanced_recovery');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` SET TAGS ('dbx_association_edges' = 'reservoir.eor_scheme,production.injection_well');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `scheme_well_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Well Assignment Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Well Assignment - Eor Scheme Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Well Assignment - Injection Well Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `cumulative_injection_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Injection Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `injection_pattern_role` SET TAGS ('dbx_business_glossary_term' = 'Injection Pattern Role');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `pattern_position` SET TAGS ('dbx_business_glossary_term' = 'Pattern Position');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ALTER COLUMN `target_injection_rate_bpd` SET TAGS ('dbx_business_glossary_term' = 'Target Injection Rate');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` SET TAGS ('dbx_subdomain' = 'enhanced_recovery');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` SET TAGS ('dbx_association_edges' = 'reservoir.eor_scheme,venture.partner');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `eor_participation_id` SET TAGS ('dbx_business_glossary_term' = 'EOR Participation Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Participation - Eor Scheme Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Participation - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `back_in_threshold_boe` SET TAGS ('dbx_business_glossary_term' = 'Back-In Threshold Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `carried_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Indicator');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `cost_sharing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `incremental_reserves_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Incremental Reserves Entitlement');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `non_consent_election` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Election Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `non_consent_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Penalty Rate');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` SET TAGS ('dbx_subdomain' = 'enhanced_recovery');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` SET TAGS ('dbx_association_edges' = 'reservoir.eor_scheme,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `eor_vendor_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'EOR Vendor Supply Agreement ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Vendor Supply Agreement - Eor Scheme Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contact Employee ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `technical_contact_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Employee ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `technical_contact_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `technical_contact_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Vendor Supply Agreement - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `actual_volume_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Delivered');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `contracted_volume` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `performance_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `supply_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Type');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `total_contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value USD');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` SET TAGS ('dbx_association_edges' = 'reservoir.reservoir,venture.partner');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `reservoir_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Working Interest - Reservoir Working Interest Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Working Interest - Reservoir Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Working Interest - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `assignment_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Agreement Reference');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `carried_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `is_operator` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `reserves_entitlement_volume` SET TAGS ('dbx_business_glossary_term' = 'Reserves Entitlement Volume');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` ALTER COLUMN `interference_test_id` SET TAGS ('dbx_business_glossary_term' = 'Interference Test Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` ALTER COLUMN `parent_interference_test_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`sample` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
