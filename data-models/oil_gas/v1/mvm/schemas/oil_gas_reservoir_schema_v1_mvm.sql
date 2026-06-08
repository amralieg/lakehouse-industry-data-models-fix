-- Schema for Domain: reservoir | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`reservoir` COMMENT 'Serves as the SSOT for subsurface reservoir characterization, simulation models, PVT data, OOIP/OGIP estimates, STOIIP calculations, EUR estimation, material balance data, and recovery factor optimization. Tracks EOR/IOR programs including WAG, SAGD, and CSS schemes. Supports SEC and SPE-PRMS reserves classification (PDP, PUD, PDNP) and production forecast modeling. Integrates with Schlumberger Petrel reservoir simulation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`reservoir` (
    `reservoir_id` BIGINT COMMENT 'Unique identifier for the subsurface reservoir unit. Primary key for the reservoir entity.',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Reservoirs are discovered and developed under lease agreements that grant exploration and production rights. Essential for reserves booking, royalty calculations, working interest determination, and S',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Every producing reservoir operates under an operating license that defines production rights, royalty obligations, and reporting requirements. The existing operating_permit_id covers the specific well',
    `play_id` BIGINT COMMENT 'Foreign key linking to exploration.play. Business justification: A reservoir is the physical realization of a play concept. Play-level resource aggregation, exploration success rate tracking, and PRMS play-based resource classification all require linking each rese',
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
    `assay_id` BIGINT COMMENT 'Foreign key linking to product.assay. Business justification: PVT analysis and crude assay are often performed on the same reservoir fluid sample. Linking pvt_analysis to assay enables the lab and reservoir team to trace which crude assay was derived from the sa',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: PVT samples are processed at specific lab facilities; results drive facility design (separator sizing, pipeline specs). Facility design basis, separator optimization, and pipeline flow assurance requi',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: PVT analysis characterizes reservoir fluid that is commercially classified as a crude grade. Labs and reservoir engineers use PVT results to confirm or assign crude grade (API gravity, GOR, compositio',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: PVT samples collected during exploration/appraisal drilling (DST, wireline sampling). Links fluid properties to discovery wells for initial reservoir characterization. Critical for early-stage reserve',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: PVT fluid sampling from H2S-bearing or high-pressure reservoirs requires a Permit to Work. HSE regulations mandate PTW for any wellsite sampling operation. A domain expert would expect pvt_analysis to',
    `reservoir_id` BIGINT COMMENT 'Identifier of the reservoir zone from which the sample was obtained.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: PVT analysis samples are collected from specific reservoir zones, particularly in multi-zone reservoirs where fluid properties vary by zone (different GOR, API gravity, bubble point pressure). The pvt',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key linking to procurement.service_entry_sheet. Business justification: PVT analysis is a contracted laboratory service (e.g., Core Laboratories, Intertek). SES documents service acceptance for three-way match payment processing — consistent with the established pattern f',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: PVT analysis is procured from qualified laboratories (Core Lab, Weatherford, etc.). Links fluid analysis to vendor qualification, performance tracking, and invoice reconciliation. Removes denormalized',
    `well_asset_id` BIGINT COMMENT 'Identifier of the well from which the reservoir fluid sample was collected.',
    `well_test_id` BIGINT COMMENT 'Foreign key linking to reservoir.well_test. Business justification: PVT fluid samples are commonly collected during well tests (DST, production tests). The pvt_analysis references the well_test during which the fluid sample was obtained, providing sample provenance an',
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
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Volumetric estimation studies (OOIP/OGIP determination) are authorized via AFE as G&G capital expenditures. Linking volumetric_estimate to finance_afe enables cost tracking of the study against capita',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Volumetric estimates (OOIP, OGIP, EUR) are presented to JOA operating committees for development-decision approvals and joint reserves certifications. Domain experts expect volumetric_estimate to refe',
    `petrophysical_interp_id` BIGINT COMMENT 'Foreign key linking to reservoir.petrophysical_interp. Business justification: Volumetric estimates are directly computed from petrophysical interpretation results — porosity, net pay thickness, net-to-gross ratio, and water saturation from petrophysical_interp feed directly int',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Volumetric estimates are first computed at prospect stage and refined post-discovery. The prospect-to-reservoir volumetric reconciliation workflow and PRMS resource reclassification process require li',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Under PSA regimes, volumetric estimates underpin minimum-work-obligation compliance reporting and host-government resource assessments. Domain experts expect volumetric_estimate to reference the PSA f',
    `pvt_analysis_id` BIGINT COMMENT 'Foreign key linking to reservoir.pvt_analysis. Business justification: Volumetric estimates require PVT data for converting in-situ volumes to surface conditions. The formation_volume_factor_oil and formation_volume_factor_gas on volumetric_estimate are derived from PVT ',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir or reservoir zone for which this volumetric estimate applies.',
    `zone_id` BIGINT COMMENT 'FK to reservoir.zone',
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
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Reserves are booked and reported by facility for SEC compliance, asset valuation, and portfolio management. Facility-level reserves reporting for asset sales, SEC disclosure by operated facility, and ',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: SEC/PRMS reserves reporting requires specifying the hydrocarbon product and grade. The existing product_type is a denormalized text field; replacing it with crude_grade_id enables proper reserves book',
    `decline_curve_id` BIGINT COMMENT 'Foreign key linking to reservoir.decline_curve. Business justification: Decline Curve Analysis (DCA) is one of the primary methods for reserves estimation, particularly for PDP (Proved Developed Producing) reserves. When DCA is the estimation method, the reserves_estimate',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Reserves evaluation work requires AFE authorization for cost tracking. SEC compliance requires linking reserves estimates to capital spend for proved property classification and reserves booking certi',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Reserves estimates drive partner entitlements, SEC disclosures, and economic evaluations under JOA frameworks. Required for partner reserves booking, net revenue interest calculations, and operating c',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: SEC and PRMS reserves must be attributed to specific lease holdings for 10-K financial reporting, proved developed producing reserves classification, and working interest/NRI calculations. Lease-level',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: SEC reserves reporting, PSA/PSC annual reports, and PRMS certification require reserves to be attributed to the specific operating license granting production rights. Auditors and regulators verify re',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Reserves estimates are prepared and reported at the pooling unit level for SEC filings and regulatory submissions. Unitized fields require reserves booking by pooling unit to correctly allocate proved',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Reserves valuation (NPV calculation, SEC pricing method) directly references pricing agreements for economic assumptions. SEC rules require pricing basis documentation. Reserves engineers use actual c',
    `production_forecast_id` BIGINT COMMENT 'Foreign key linking to reservoir.production_forecast. Business justification: Reserves booking under SEC and SPE-PRMS requires a production forecast that demonstrates the economic producibility of the reserves. The reserves_estimate references the production_forecast used as th',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Reserves estimates are the culmination of the prospect-to-reserves maturation workflow. SEC and PRMS reporting require full audit trail from prospect through discovery to booked reserves. reserves_est',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: PSA entitlements (cost oil, profit oil) are calculated from reserves estimates; contractor and government shares, R-factor calculations, and production tier thresholds depend on certified reserves vol',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Reserves estimates are formally submitted in SEC 10-K filings, annual reserves reports to national regulators, and PSA/PSC reporting. Linking reserves_estimate directly to the regulatory filing enable',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which reserves are being estimated.',
    `simulation_run_id` BIGINT COMMENT 'Foreign key linking to reservoir.simulation_run. Business justification: Reserves estimates derived from simulation-based methods (material balance, full-field simulation) must reference the specific simulation run that generated the production profile used for booking. Th',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: SEC-mandated independent reserves certifications are performed by qualified external firms (D&M, Ryder Scott, Gaffney Cline). vendor_id provides proper FK attribution replacing the denormalized certif',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Net reserves volumes are calculated by applying NRI/WI percentages from venture_working_interest to gross reserves. The venture_working_interest record is the authoritative source for these percentage',
    `volumetric_estimate_id` BIGINT COMMENT 'Foreign key linking to reservoir.volumetric_estimate. Business justification: Reserves estimates (SEC/SPE-PRMS booking) are fundamentally derived from volumetric estimates (OOIP/OGIP). The volumetric_estimate provides the in-place volumes from which recovery factors are applied',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: SEC reserves filings and PRMS reporting require well-level reserves attribution. Reserves engineers prepare well-level estimates for booking proved reserves against specific well assets. The existing ',
    `booking_status` STRING COMMENT 'Current workflow status of the reserves estimate: draft, submitted for review, approved for booking, rejected, or revised.. Valid values are `draft|submitted|approved|rejected|revised`',
    `certification_date` DATE COMMENT 'Date on which the reserves estimate was certified by the qualified petroleum engineer.',
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
    CONSTRAINT pk_reserves_estimate PRIMARY KEY(`reserves_estimate_id`)
) COMMENT 'SSOT for SEC and SPE-PRMS reserves classification and booking. Captures reserves category (1P/2P/3P), sub-category (PDP/PDNP/PUD), product type (oil/gas/NGL/condensate), proved reserves volume (BOE), probable reserves, possible reserves, EUR, recovery factor, effective date, revision reason, SEC pricing used, discount rate, NPV10, booking status, and certifying engineer. Tracks annual reserves revisions, extensions, discoveries, and production revisions per SEC Rule 4-10(a) and SPE-PRMS.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` (
    `simulation_run_id` BIGINT COMMENT 'Unique identifier for the simulation run instance. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Simulation runs consume computational resources and engineering time charged to AFE budgets. Essential for tracking reservoir study costs against authorized capital and operating budgets in field deve',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: Economic simulation runs use oil_price_assumption and gas_price_assumption fields that should reference actual commercial pricing agreements for NPV forecasting. Investment decisions require alignment',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Reservoir simulation studies are capital projects authorized and tracked in finance.project for capex budgeting, NPV analysis, and project lifecycle management. O&G engineers expect every simulation c',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Reservoir simulation NPV and economic-limit calculations under PSA regimes incorporate PSA-specific fiscal parameters (cost-recovery ceiling, profit-oil split, R-factor). Domain experts expect simulat',
    `pvt_analysis_id` BIGINT COMMENT 'Foreign key linking to reservoir.pvt_analysis. Business justification: Reservoir simulation runs require PVT fluid property data as a critical input to the simulation model (EOS parameters, formation volume factors, viscosity, GOR). A simulation run references the specif',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: A simulation run is executed against a specific reservoir simulation model. This is the fundamental parent-child relationship for simulation_run — every run belongs to exactly one reservoir. The descr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Reservoir simulation studies are frequently contracted to specialist vendors (CMG, Petrel consultants, independent reservoir engineers). Vendor attribution on simulation_run enables vendor performance',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` (
    `pressure_survey_id` BIGINT COMMENT 'Unique identifier for the pressure survey record. Primary key for the pressure survey entity.',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Pressure surveys run in exploration/appraisal wells establish initial reservoir pressure regime and fluid contacts. Critical for reserves estimation, aquifer strength assessment, and development plann',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Post-incident pressure surveys are mandated by BSEE and HSE UK following well control events or abnormal pressure anomalies. The pressure survey record must reference the triggering incident for regul',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Pressure surveys involve downhole gauge deployment/retrieval requiring Permit to Work for safe execution: well access, wireline operations, pressure equipment handling, and coordination with productio',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Pressure surveys are conducted to monitor reservoir pressure decline over the producing life. Currently pressure_survey has well_asset_id and simulation_model_id but no direct reservoir_id FK. This is',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Pressure surveys measure zone-specific pressures in multi-zone completions. Currently has reservoir_zone as a STRING attribute but no FK. This should be normalized - zone-level pressure monitoring is ',
    `service_entry_sheet_id` BIGINT COMMENT 'Foreign key linking to procurement.service_entry_sheet. Business justification: Pressure surveys are wireline/slickline services procured from vendors (Schlumberger, Halliburton, Baker Hughes). Links survey data to service entry sheets for cost accrual and vendor payment. Removes',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the well where the pressure survey was conducted. Links to the well asset master data.',
    `well_test_id` BIGINT COMMENT 'Foreign key linking to reservoir.well_test. Business justification: Pressure surveys are frequently conducted as part of well tests (DST, production tests, pressure transient analysis). A BHP survey during a DST is a child record of the well test. This FK links the pr',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Pressure surveys are scheduled field operations executed under work orders in asset management systems. This link enables cost tracking, permit-to-work association, and operational scheduling. The exi',
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
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Well test fluid samples are used to classify or confirm the crude grade of production from a well. O&G operations teams use well test results (API gravity, GOR, composition) to assign crude grade for ',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Drill stem tests (DSTs) conducted on exploration/appraisal wells provide initial reservoir pressure, permeability, and productivity data. Essential for discovery evaluation, reserves booking, and deve',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Well tests are authorized via AFE for wireline, testing equipment, and engineering costs. well_test.afe_number is a denormalized text field; replacing it with finance_afe_id FK enables proper AFE vari',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: State regulators (e.g., TRRC, COGCC) require operators to reference the specific well-test authorization permit when conducting and reporting initial potential tests and DSTs. This regulatory permit i',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: Well testing operations require Permit to Work authorization due to inherent hazards: high-pressure operations, H2S exposure risk, flaring activities, and well intervention. PTW ensures isolation, gas',
    `process_safety_event_id` BIGINT COMMENT 'Foreign key linking to hse.process_safety_event. Business justification: Well tests involving high H2S concentrations, pressure exceedances, or loss of primary containment generate IOGP-classified Process Safety Events (Tier 1/2). Linking well_test to process_safety_event ',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Well tests conducted during exploration drilling validate prospect resource estimates and confirm commerciality. The prospect de-risking and PRMS maturation workflow requires linking well test results',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Well tests target specific reservoir zones to measure zone-level productivity, permeability, and skin factor. Currently well_test lacks zone-level attribution. This is critical for multi-zone reservoi',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the well asset where the test was conducted.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Well tests are field operations planned and executed under work orders in asset management systems (SAP PM, Maximo). This link enables cost capture against the work order, permit-to-work association, ',
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
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Production forecasts are commodity-specific: the crude grade determines pricing differentials, refinery routing, and offtake agreement terms. Commercial and planning teams require the crude grade refe',
    `eor_scheme_id` BIGINT COMMENT 'Foreign key linking to reservoir.eor_scheme. Business justification: Production forecasts for EOR/IOR programs must reference the specific EOR scheme they are projecting. The production_forecast.eor_program_type field indicates EOR forecasts exist, and this FK links to',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: JOA operating committees review and approve production forecasts; forecasts drive annual work-program budgets, cash-call schedules, and JIB cost allocations among partners. Domain experts expect produ',
    `lifting_program_id` BIGINT COMMENT 'Foreign key linking to commercial.lifting_program. Business justification: Lifting programs are built from production forecasts — equity entitlement volumes and scheduled lifting dates are derived from reservoir production forecasts. JV partners use production forecasts to p',
    `marketing_deal_id` BIGINT COMMENT 'Foreign key linking to commercial.marketing_deal. Business justification: Production forecasts directly drive marketing deal structuring — commercial traders use forecast volumes, plateau rates, and EUR to negotiate deal size and duration. Deal approval requires a confirmed',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Under PSA regimes, production forecasts determine cost-oil and profit-oil volumes by period, directly feeding lifting-entitlement calculations and domestic-market-obligation compliance. Domain experts',
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
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: EOR schemes target incremental recovery of a specific crude grade. Economic evaluations (NPV, IRR) and SEC reserves booking for EOR incremental volumes require the crude grade for grade-specific prici',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: EOR schemes require JOA operating-committee approval and cost-sharing among partners; JIB billing for EOR injectant and facility costs flows through the JOA. Domain experts expect eor_scheme to refere',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: EOR programs require lease-level approval for surface use rights, injection operations, and royalty rate adjustments. Lease agreements often contain specific EOR provisions governing cost recovery, in',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: EOR programs (CO2 injection, water flooding, steam injection) trigger specific regulatory obligations: UIC Class II injection reporting, GHG monitoring, produced water disposal reporting. Operators tr',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: EOR pattern floods (waterflood, CO2, steam) operate within pooling unit boundaries defined by regulatory agencies. The pooling unit determines injection well spacing, regulatory approval requirements,',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: EOR schemes are discrete capital projects tracked in finance.project for capex authorization, NPV analysis, and lifecycle cost management. O&G finance teams require this link to track EOR investment p',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Under PSA regimes, EOR injectant costs qualify for cost recovery and incremental production triggers separate profit-oil split tiers. The PSA link is required for cost-recovery ceiling calculations an',
    `reservoir_id` BIGINT COMMENT 'Foreign key reference to the target reservoir where the EOR scheme is being applied.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: EOR/IOR schemes target specific reservoir zones for injection (e.g., SAGD targets specific bitumen zones, WAG targets specific oil zones). The eor_scheme references the primary target zone for the inj',
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
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: Injection events post costs (injectant volume × unit price, compression costs) to the finance actual_cost ledger. injection_event.injection_cost_usd is a denormalized cost field that should be replace',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Injection operations require environmental monitoring for induced seismicity (microseismic monitoring), groundwater protection (observation well sampling), surface emissions (fugitive methane, CO2), a',
    `eor_scheme_id` BIGINT COMMENT 'Reference to the parent EOR/IOR program or scheme under which this injection event was executed. Links to the EOR scheme master data.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Individual injection events can cause HSE incidents including induced seismicity, surface spills, or equipment failures. EPA UIC and BSEE regulations require injection-related incidents to be traceabl',
    `injection_well_id` BIGINT COMMENT 'Reference to the well asset through which the injection occurred. Links to the well asset master data.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Injected fluids (water, gas, chemicals, polymers, steam) are procured materials tracked in material master for inventory, cost allocation, and HSE compliance. Links injection volumes to material speci',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Injection activities must operate under UIC permits from EPA or state authorities. The existing environmental_permit_number is a denormalized string; proper FK enables tracking permit compliance, inje',
    `permit_to_work_id` BIGINT COMMENT 'Foreign key linking to hse.permit_to_work. Business justification: EOR injection operations (water, gas, steam, chemical) require PTW due to high-pressure injection, chemical handling hazards, equipment isolation needs, and SIMOPS coordination with adjacent productio',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: EOR injectants (CO2, polymer, surfactant, water) are procured via purchase orders. Linking injection_event to the supplying PO enables cost reconciliation between actual injection volumes and procurem',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir into which the injection occurred. Links to the reservoir master data for subsurface characterization.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Individual injection events target specific reservoir zones (perforated intervals). Tracking which zone receives injection is critical for EOR performance monitoring, conformance analysis, and materia',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Injection events must link to the well_asset record of the injection well for integrity management, work order generation, failure reporting, and asset performance KPIs. The existing injection_well_id',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` (
    `petrophysical_interp_id` BIGINT COMMENT 'Primary key for petrophysical_interp',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Petrophysical interpretation services are governed by procurement contracts (MSAs or specific service contracts). Linking enables contract compliance tracking, scope-of-work verification, and spend ma',
    `core_sample_id` BIGINT COMMENT 'Foreign key linking to exploration.core_sample. Business justification: Petrophysical log interpretations are calibrated against core sample measurements (porosity, permeability, saturation). The log-to-core calibration workflow is a mandatory QC step in reservoir charact',
    `exploration_well_id` BIGINT COMMENT 'Foreign key linking to exploration.exploration_well. Business justification: Petrophysical interpretations from exploration/appraisal well logs quantify reservoir quality and hydrocarbon volumes. Essential for discovery evaluation, reserves booking, and static model population',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Petrophysical interpretation programs are authorized via AFE in O&G capital planning. Linking to finance_afe enables cost-to-AFE variance tracking and ensures G&G study expenditures are captured under',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` (
    `decline_curve_id` BIGINT COMMENT 'Primary key for decline_curve',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir being analyzed. Links to the reservoir master data for subsurface characterization context.',
    `zone_id` BIGINT COMMENT 'Foreign key linking to reservoir.zone. Business justification: Decline Curve Analysis is performed at both reservoir and zone level. Zone-level DCA is critical for multi-zone reservoirs where individual zones have different decline characteristics. The decline_cu',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: DCA studies for reserves certification are routinely performed by external reservoir engineering consultants (e.g., Ryder Scott, D&M). Vendor attribution on decline_curve is required for audit trail, ',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`reservoir`.`development_plan` (
    `development_plan_id` BIGINT COMMENT 'Primary key for development_plan',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Development plans require AFE authorization for drilling, completion, and facilities capex. Links reservoir engineering plans to approved budgets for execution tracking, variance reporting, and invest',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Development plans specify facility requirements, tie-ins, and infrastructure needs. Facility capacity planning, brownfield vs greenfield decisions, and facility CAPEX allocation depend on this link. C',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Field Development Plans are executed under specific procurement contracts (EPCI, FEED, drilling contracts). Linking development_plan to the governing contract enables contract compliance monitoring, s',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Field development plans are built around the crude grade to be produced, driving pipeline specifications, refinery configuration, and offtake agreement terms. FDP economic models (NPV, IRR, payout) us',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Development plans are authorized via finance AFE for capital expenditure approval. development_plan already has afe_budget_id (procurement-side), but the finance_afe_id links to the finance-side autho',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Development plans require JOA partner approval, budget allocation, and working interest commitments. Operating committee must approve development scenarios, well counts, and capital expenditures befor',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Development plans must respect lease boundaries, primary term drilling obligations, and continuous drilling clauses. Essential for AFE preparation, regulatory spacing unit applications, and held-by-pr',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: FDP regulatory approval creates binding compliance obligations: environmental monitoring programs, production reporting schedules, decommissioning obligations, and HSE management system requirements. ',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Field Development Plans (FDPs) must be approved under and explicitly reference the operating license authorizing field development. Regulatory bodies (BSEE, NOPSEMA, OGUK) require FDPs to cite the ope',
    `pooling_unit_id` BIGINT COMMENT 'Foreign key linking to land.pooling_unit. Business justification: Field development plans are scoped to pooling units for regulatory well-spacing compliance, drilling permit applications, and royalty obligation planning. Regulators require development plans to refer',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Field development plans are major capital projects tracked in finance.project for full lifecycle cost management, NPV/IRR reporting, and capex authorization. Every FDP in O&G has a corresponding finan',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Development plans under PSA regimes require host-government approval per PSA terms; capex commitments, plateau rates, and work programs are contractually governed by the PSA. Domain experts expect dev',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir for which this development plan is designed. Links to the reservoir master data.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ADD CONSTRAINT `fk_reservoir_zone_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_petrophysical_interp_id` FOREIGN KEY (`petrophysical_interp_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`petrophysical_interp`(`petrophysical_interp_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_pvt_analysis_id` FOREIGN KEY (`pvt_analysis_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`pvt_analysis`(`pvt_analysis_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_decline_curve_id` FOREIGN KEY (`decline_curve_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`decline_curve`(`decline_curve_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_production_forecast_id` FOREIGN KEY (`production_forecast_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`production_forecast`(`production_forecast_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_simulation_run_id` FOREIGN KEY (`simulation_run_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_run`(`simulation_run_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_volumetric_estimate_id` FOREIGN KEY (`volumetric_estimate_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`volumetric_estimate`(`volumetric_estimate_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_pvt_analysis_id` FOREIGN KEY (`pvt_analysis_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`pvt_analysis`(`pvt_analysis_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_simulation_run_id` FOREIGN KEY (`simulation_run_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_run`(`simulation_run_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`reservoir` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`reservoir` SET TAGS ('dbx_domain' = 'reservoir');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `volumetric_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Estimate Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `petrophysical_interp_id` SET TAGS ('dbx_business_glossary_term' = 'Petrophysical Interp Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `pvt_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Pvt Analysis Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ALTER COLUMN `zone_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reserves_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Reserves Estimate Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `decline_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `production_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Production Forecast Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `volumetric_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Volumetric Estimate Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|revised');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `pvt_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Pvt Analysis Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `pressure_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Survey Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `well_test_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Well Test Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `process_safety_event_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `production_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Production Forecast Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Eor Scheme Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `lifting_program_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `marketing_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Deal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Scheme ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Target Reservoir ID');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Event Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `eor_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Enhanced Oil Recovery (EOR) Scheme Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `injection_well_id` SET TAGS ('dbx_business_glossary_term' = 'Injection Well Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit To Work Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `petrophysical_interp_id` SET TAGS ('dbx_business_glossary_term' = 'Petrophysical Interp Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `core_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Core Sample Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` SET TAGS ('dbx_subdomain' = 'reservoir_modeling');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `decline_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Decline Curve Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Zone Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Identifier');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `pooling_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Pooling Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
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
