-- Schema for Domain: exploration | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`exploration` COMMENT 'Manages all upstream exploration activities including seismic surveys, geological and geophysical (G&G) interpretation, prospect evaluation, basin analysis, and wildcat well planning. Serves as the SSOT for prospect and play data, resource potential assessments, lead/prospect generation, and PRMS-aligned resource classifications (1P/2P/3P). Integrates with Landmark DecisionSpace and Schlumberger Petrel for subsurface modeling and G&G workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`basin` (
    `basin_id` BIGINT COMMENT 'Unique identifier for the sedimentary basin. Primary key for the basin master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: E&P companies assign dedicated cost centers to basins for basin-level exploration budget tracking, AFE allocation, and cost reporting. Basin-level cost center assignment is standard in SAP-based E&P f',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each basin is governed by a primary regulatory authority (e.g., BOEM for US Gulf of Mexico, NOPSEMA for Australia NW Shelf). Basin-level regulatory authority assignment drives which compliance regime ',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the basin is currently active in the exploration portfolio. False indicates basin has been relinquished, divested, or deprioritized.',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Total geographic extent of the sedimentary basin in square kilometers. Represents the full basin boundary as defined by geological interpretation.',
    `basin_code` STRING COMMENT 'Standardized alphanumeric code for the basin used in regulatory filings and internal systems. May align with USGS province codes or company-specific taxonomy.',
    `basin_name` STRING COMMENT 'Official name of the sedimentary basin as recognized by geological surveys and industry standards (e.g., Permian Basin, Gulf of Mexico Basin, Williston Basin).',
    `basin_status` STRING COMMENT 'Current operational status of the basin in the companys exploration and production portfolio. Indicates level of activity and investment priority.. Valid values are `active_exploration|producing|mature|frontier|relinquished|suspended`',
    `basin_type` STRING COMMENT 'Geological classification of the basin based on tectonic setting and formation mechanism. Critical for understanding hydrocarbon system maturity and trap styles. [ENUM-REF-CANDIDATE: foreland|rift|passive_margin|strike_slip|intracratonic|forearc|backarc|pull_apart — 8 candidates stripped; promote to reference product]',
    `business_unit` STRING COMMENT 'Operating business unit or geographic division responsible for exploration activities in the basin. Used for portfolio segmentation and financial reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where the basin is located. For transboundary basins, represents the country with majority acreage or operational focus.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the basin record was first created in the system. Part of audit trail for data lineage and governance.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Assessment of geological and geophysical data quality and coverage for the basin on a scale of 0.00 to 1.00. Higher scores indicate better data density, vintage, and reliability for decision-making.',
    `discovery_count` STRING COMMENT 'Number of commercial hydrocarbon discoveries made in the basin. Used to calculate exploration success rate and basin prospectivity metrics.',
    `environmental_sensitivity` STRING COMMENT 'Assessment of environmental and ecological sensitivity of the basin. Considers protected areas, endangered species habitat, water resources, and community proximity. Impacts permitting and HSE requirements.. Valid values are `low|moderate|high|critical`',
    `eur_mmboe` DECIMAL(18,2) COMMENT 'Basin-level estimated ultimate recovery in million barrels of oil equivalent. Represents technically recoverable resources under current and anticipated technology and economics.',
    `exploration_maturity` STRING COMMENT 'Stage of exploration lifecycle for the basin. Indicates drilling density, geological understanding, and remaining prospectivity. Drives exploration strategy and risk profile.. Valid values are `frontier|emerging|established|mature|declining`',
    `fiscal_regime_type` STRING COMMENT 'Type of fiscal and contractual framework governing hydrocarbon development in the basin. Critical for economic evaluation and partner negotiations.. Valid values are `concession|production_sharing|service_contract|royalty_tax|hybrid`',
    `geographic_region` STRING COMMENT 'High-level geographic region where the basin is located (e.g., North America, West Africa, Middle East, Asia Pacific). Used for portfolio segmentation and regional reporting.',
    `geological_risk_score` DECIMAL(18,2) COMMENT 'Composite geological risk score for the basin on a scale of 0.00 to 1.00, where lower values indicate higher risk. Aggregates source, reservoir, trap, and seal risk factors.',
    `hydrocarbon_system_maturity` STRING COMMENT 'Assessment of the basins petroleum system maturity based on source rock thermal history, generation timing, and migration pathways. Critical for play risk assessment.. Valid values are `immature|early_mature|peak_mature|late_mature|post_mature`',
    `infrastructure_maturity` STRING COMMENT 'Level of existing oil and gas infrastructure in the basin including pipelines, processing facilities, export terminals, and service networks. Impacts development economics and time-to-market.. Valid values are `none|limited|developing|established|mature`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent basin-level resource assessment or portfolio review. Indicates currency of resource estimates and geological understanding.',
    `lead_count` STRING COMMENT 'Number of exploration leads (unrisked prospects) currently identified in the basin. Represents early-stage opportunities requiring further technical work.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the basin record was last modified. Used for change tracking and data currency verification.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next basin assessment or portfolio review. Used for planning technical work programs and resource estimate updates.',
    `ogip_bcf` DECIMAL(18,2) COMMENT 'Basin-level estimate of original gas in place in billion cubic feet. Represents total gas volume before any production. Includes associated and non-associated gas.',
    `onshore_offshore_flag` STRING COMMENT 'Indicates whether the basin is primarily onshore, offshore, or contains both onshore and offshore acreage. Impacts regulatory jurisdiction and operational complexity.. Valid values are `onshore|offshore|mixed`',
    `ooip_mmbbl` DECIMAL(18,2) COMMENT 'Basin-level estimate of original oil in place in million barrels. Represents total oil volume before any production. Aggregated from prospect and play-level assessments.',
    `play_count` STRING COMMENT 'Number of distinct exploration plays identified in the basin. Each play represents a unique combination of source-reservoir-trap-seal elements.',
    `primary_reservoir_rock` STRING COMMENT 'Main reservoir formation or lithology hosting producible hydrocarbons in the basin (e.g., sandstone, carbonate, shale). May include multiple stacked reservoirs.',
    `primary_source_rock` STRING COMMENT 'Dominant source rock formation or interval responsible for hydrocarbon generation in the basin (e.g., Woodford Shale, Kimmeridge Clay, Bakken Formation).',
    `prms_classification_tier` STRING COMMENT 'Highest PRMS resource classification tier assigned to the basins aggregate resources. Indicates confidence level in resource estimates for SEC and SPE reporting.. Valid values are `1P|2P|3P|prospective|contingent`',
    `prospect_count` STRING COMMENT 'Number of drillable prospects (risked, mature opportunities) in the basin. Represents near-term drilling inventory with AFE-ready technical packages.',
    `prospective_area_sq_km` DECIMAL(18,2) COMMENT 'Subset of basin area considered prospective for hydrocarbon accumulation based on geological and geophysical analysis. Used for resource potential calculations.',
    `recovery_factor_percent` DECIMAL(18,2) COMMENT 'Basin-wide average recovery factor expressed as percentage of OOIP/OGIP. Reflects reservoir quality, drive mechanism, and technology application potential.',
    `regulatory_authority` STRING COMMENT 'Primary government agency or regulatory body with jurisdiction over exploration and production activities in the basin (e.g., BSEE, state oil and gas commission, national oil ministry).',
    `seismic_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of prospective basin area covered by 2D or 3D seismic surveys. Indicates data availability for prospect generation and geological interpretation.',
    `tectonic_setting` STRING COMMENT 'Detailed description of the basins tectonic environment and structural evolution. Includes plate boundary type, deformation history, and current stress regime.',
    `trap_style` STRING COMMENT 'Predominant hydrocarbon trap mechanism in the basin (e.g., structural anticline, stratigraphic pinchout, combination trap, fault-bounded). Influences exploration strategy.',
    `water_depth_max_ft` DECIMAL(18,2) COMMENT 'Maximum water depth in feet for offshore portions of the basin. Null for purely onshore basins. Critical for technology selection and FPSO feasibility.',
    `water_depth_min_ft` DECIMAL(18,2) COMMENT 'Minimum water depth in feet for offshore portions of the basin. Null for purely onshore basins. Used for drilling complexity and cost estimation.',
    `well_count` STRING COMMENT 'Total number of exploration and appraisal wells drilled in the basin to date. Includes both company-operated and non-operated wells. Reflects exploration intensity.',
    CONSTRAINT pk_basin PRIMARY KEY(`basin_id`)
) COMMENT 'Master record for sedimentary basins under evaluation. Captures basin name, type (foreland, rift, passive margin, etc.), geographic extent, tectonic setting, hydrocarbon system maturity, PRMS classification tier, and basin-level resource potential estimates (OOIP/OGIP). Serves as the top-level geographic and geological hierarchy for all exploration activities. Integrates with Landmark DecisionSpace basin analysis workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`play` (
    `play_id` BIGINT COMMENT 'Unique identifier for the petroleum play. Primary key for the play master record.',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which this play is located. Links to basin master data for regional geological context.',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Plays are defined by their reservoir formations. Currently play has reservoir_formation (STRING) and reservoir_age (STRING); these should be replaced with a FK to the formation master to ensure consis',
    `analogue_play_reference` STRING COMMENT 'Reference to analogous plays in other basins or regions used for benchmarking resource estimates, well performance, and geological risk. Supports play fairway mapping and probabilistic assessment.',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'Areal extent of the play fairway in square miles. Represents the geographic footprint where the play concept is valid and prospective.',
    `average_net_pay_thickness_ft` DECIMAL(18,2) COMMENT 'Play-level average thickness of productive reservoir interval in feet. Excludes non-reservoir intervals and water-bearing zones.',
    `average_permeability_md` DECIMAL(18,2) COMMENT 'Play-level average permeability in millidarcies. Conventional reservoirs typically >1 mD; tight gas <0.1 mD; shale <0.001 mD.',
    `average_porosity_percent` DECIMAL(18,2) COMMENT 'Play-level average porosity expressed as a percentage of total rock volume. Typical ranges: excellent >20%, good 15-20%, fair 10-15%, poor <10%.',
    `charge_risk` STRING COMMENT 'Assessment of the risk that the play may not have received adequate hydrocarbon charge from the source rock. Low risk indicates proven charge; high risk indicates uncertain or inadequate charge.. Valid values are `low|moderate|high`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the play record was first created in the system. Used for audit trail and data lineage tracking.',
    `depth_range_base_ft` DECIMAL(18,2) COMMENT 'Deepest true vertical depth (TVD) at which the play reservoir is encountered across the basin, measured in feet subsea or below surface.',
    `depth_range_top_ft` DECIMAL(18,2) COMMENT 'Shallowest true vertical depth (TVD) at which the play reservoir is encountered across the basin, measured in feet subsea or below surface.',
    `discovery_count` STRING COMMENT 'Number of commercial hydrocarbon discoveries made within the play to date. Used to assess play maturity and success rate.',
    `dry_hole_count` STRING COMMENT 'Number of unsuccessful exploration wells drilled in the play. Used to calculate exploration success rate and refine geological models.',
    `exploration_success_rate_percent` DECIMAL(18,2) COMMENT 'Historical success rate for exploration wells in the play, calculated as discoveries divided by total wells drilled, expressed as a percentage.',
    `geological_chance_of_success_percent` DECIMAL(18,2) COMMENT 'Probability that the play contains commercial hydrocarbons, expressed as a percentage. Calculated as the product of individual risk factors (trap, seal, source, reservoir, charge). Typical exploration plays range 10-40%.',
    `hydrocarbon_type` STRING COMMENT 'Primary hydrocarbon phase expected in the play. Oil plays target liquid petroleum; gas plays target natural gas; condensate plays target gas with liquid dropout; mixed plays contain both oil and gas zones.. Valid values are `oil|gas|condensate|mixed`',
    `identified_date` DATE COMMENT 'Date when the play concept was first identified and entered into the exploration portfolio. Used for tracking play lifecycle and portfolio vintage analysis.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent technical and resource assessment of the play. Plays should be reassessed periodically as new data becomes available.',
    `migration_pathway` STRING COMMENT 'Description of the route hydrocarbons traveled from source rock to reservoir (e.g., vertical migration along fault planes, lateral migration through carrier beds). Critical for understanding charge risk.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the play record was last modified. Used for audit trail and change tracking.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review and update of the play assessment. Ensures plays remain current in the exploration portfolio.',
    `play_code` STRING COMMENT 'Standardized alphanumeric code for the play used in Landmark DecisionSpace and internal exploration systems for consistent identification across G&G workflows.',
    `play_name` STRING COMMENT 'Business name of the petroleum play, typically reflecting the reservoir formation and trap style (e.g., Wolfcamp Shale Unconventional, Norphlet Sandstone Structural).',
    `play_status` STRING COMMENT 'Current lifecycle status of the play. Active plays are under active exploration or development; mature plays have established production; emerging plays are newly identified; dormant plays are on hold; abandoned plays are no longer pursued.. Valid values are `active|mature|emerging|dormant|abandoned`',
    `play_type` STRING COMMENT 'Classification of the play based on reservoir characteristics and production mechanism. Conventional plays rely on natural permeability; unconventional plays require stimulation (hydraulic fracturing, horizontal drilling).. Valid values are `conventional|unconventional|tight_gas|shale_oil|shale_gas|coalbed_methane`',
    `prms_maturity_subclass` STRING COMMENT 'SPE-PRMS maturity subclass. Lead is early-stage; prospect is drill-ready; 1P/2P/3P are proved/probable/possible reserves categories.. Valid values are `lead|prospect|1P|2P|3P`',
    `prms_resource_class` STRING COMMENT 'SPE-PRMS resource classification. Prospective resources are undiscovered; contingent resources are discovered but not yet commercial; reserves are discovered and commercial.. Valid values are `prospective|contingent|reserves`',
    `reservoir_lithology` STRING COMMENT 'Dominant rock type of the reservoir. Sandstone and carbonate reservoirs typically have higher permeability; shale reservoirs require hydraulic fracturing.. Valid values are `sandstone|carbonate|shale|siltstone|conglomerate|mixed`',
    `reservoir_quality` STRING COMMENT 'Overall assessment of reservoir porosity and permeability. Excellent quality reservoirs have high porosity and permeability; poor quality reservoirs require stimulation or enhanced recovery.. Valid values are `excellent|good|fair|poor`',
    `risked_resource_estimate_mmboe` DECIMAL(18,2) COMMENT 'Play-level risked resource estimate in million barrels of oil equivalent (MMBOE). Incorporates geological chance of success and expected recoverable volumes. Aligned with SPE-PRMS probabilistic resource assessment methodology.',
    `seal_integrity` STRING COMMENT 'Assessment of the seals effectiveness in retaining hydrocarbons. Proven seals have demonstrated retention in producing fields; uncertain seals carry higher exploration risk.. Valid values are `proven|probable|possible|uncertain`',
    `seal_type` STRING COMMENT 'Type of impermeable rock that prevents hydrocarbon migration out of the reservoir. Shale and evaporite seals are most common; fault seals can be effective in some settings.. Valid values are `shale|evaporite|tight_carbonate|unconformity|fault`',
    `seismic_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of the play area covered by 3D seismic surveys. High seismic coverage reduces geological risk and improves prospect definition.',
    `source_rock_formation` STRING COMMENT 'Geological formation that generated the hydrocarbons in the play. May be the same as the reservoir formation (self-sourced) or a separate formation (migrated).',
    `source_rock_maturity` STRING COMMENT 'Thermal maturity level of the source rock, indicating the stage of hydrocarbon generation. Peak oil window generates liquid petroleum; gas window generates natural gas; overmature rocks have expelled most hydrocarbons.. Valid values are `immature|early_mature|peak_oil|late_oil|gas|overmature`',
    `technical_maturity_level` STRING COMMENT 'Assessment of the plays technical understanding and data coverage. Conceptual plays have limited data; mature plays have extensive seismic, well, and production data.. Valid values are `conceptual|emerging|established|mature`',
    `trap_configuration` STRING COMMENT 'Detailed description of the trap geometry (e.g., four-way dip closure, fault-bounded anticline, pinchout against unconformity). Used for prospect mapping and risk assessment.',
    `trap_style` STRING COMMENT 'Mechanism by which hydrocarbons are trapped in the play. Structural traps are formed by faulting or folding; stratigraphic traps by depositional or diagenetic changes; combination traps involve both; unconventional plays have no discrete trap.. Valid values are `structural|stratigraphic|combination|unconventional`',
    `unrisked_resource_estimate_mmboe` DECIMAL(18,2) COMMENT 'Play-level unrisked (gross) resource estimate in million barrels of oil equivalent (MMBOE), assuming all geological risks are successful. Used for upside scenario planning.',
    `well_control_density` STRING COMMENT 'Assessment of well penetration density within the play. Dense well control provides high confidence in reservoir properties; sparse control increases uncertainty.. Valid values are `none|sparse|moderate|dense`',
    CONSTRAINT pk_play PRIMARY KEY(`play_id`)
) COMMENT 'Master record for petroleum plays within a basin. Defines the play concept including reservoir type, trap style, seal integrity, source rock maturity, migration pathway, charge risk, and play-level risked resource estimates. Aligned with SPE-PRMS play-based exploration methodology. Links to basin and supports portfolio-level play fairway mapping in Landmark DecisionSpace.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the drillable prospect within the exploration portfolio. Primary key. MASTER_RESOURCE role.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Prospects are assigned to drilling campaigns launched from specific asset facilities (platforms, drill pads). Well planning, AFE budgeting, and slot allocation require linking a prospect to its planne',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which the prospect is located. Used for regional portfolio analysis and basin-level resource aggregation.',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Prospects are located within exploration blocks. Currently prospect has block_name (STRING); this should be replaced with a FK to the block master to ensure consistent block references and enable retr',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Exploration prospects require AFE (Authority for Expenditure) authorization before drilling commitment. The finance AFE is the financial control document governing prospect drilling costs. Direct link',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Prospect-level JOA linkage is required for AFE approval routing, non-consent election tracking, and JIB cost-sharing calculations when partners evaluate and sanction prospect drilling. Oil and gas dom',
    `joint_venture_id` BIGINT COMMENT 'Foreign key linking to venture.joint_venture. Business justification: SEC reserve disclosures and JV equity reporting require knowing which joint venture holds each prospect. Partners evaluate prospect portfolios at JV level; direct linkage enables JV-level prospect inv',
    `lead_id` BIGINT COMMENT 'Foreign key linking to exploration.lead. Business justification: Prospect should track which lead it matured from. In exploration workflows, leads are early-stage hydrocarbon concepts that mature into drillable prospects. This FK captures the maturation lineage and',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Prospects are drilled on leased land. Lease terms (expiry, working interest, royalty rate) affect prospect economics, drilling rights verification, and regulatory permit applications. Critical for dri',
    `play_id` BIGINT COMMENT 'Reference to the parent play within which this prospect is identified. Links prospect to basin-scale play fairway analysis.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Prospects advancing toward drilling are registered as capital projects in E&P financial systems for investment decision tracking, NPV/IRR evaluation, and capital allocation. Every drillable prospect r',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Prospects in PSA regimes require direct PSA linkage for cost-recovery classification of appraisal expenditures and profit-oil split calculations. Fiscal reporting and government audits require prospec',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Prospects target specific reservoir formations. Currently prospect has reservoir_formation (STRING) and reservoir_age (STRING); these should be replaced with a FK to the formation master to ensure con',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Prospects target specific hydrocarbon product types (crude, gas, condensate) for economic evaluation and resource classification. Essential for prospect maturity gates requiring product-specific price',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: A prospect sits on a specific legal land tract that defines mineral ownership and drilling rights. Land position reports and acreage inventory confirm the company holds tract-level rights to drill the',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect record was first created in the system. Used for audit trail and data lineage tracking.',
    `estimated_drill_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost to drill and complete the prospect well in US dollars. Used for AFE preparation and capital allocation decisions. Business-confidential financial data.',
    `eur_p10_mmboe` DECIMAL(18,2) COMMENT 'P10 (high case) estimate of recoverable hydrocarbon volume in million barrels of oil equivalent. Represents optimistic reserves scenario.',
    `eur_p50_mmboe` DECIMAL(18,2) COMMENT 'P50 (median) estimate of recoverable hydrocarbon volume in million barrels of oil equivalent. Represents 2P (proved plus probable) reserves classification.',
    `eur_p90_mmboe` DECIMAL(18,2) COMMENT 'P90 (low case) estimate of recoverable hydrocarbon volume in million barrels of oil equivalent. Represents conservative reserves scenario.',
    `formation_volume_factor` DECIMAL(18,2) COMMENT 'Ratio of reservoir volume to surface volume for the hydrocarbon phase. Estimated from PVT correlations and analog field data. Used to convert STOIIP to recoverable reserves.',
    `geological_chance_of_success_pct` DECIMAL(18,2) COMMENT 'Probability that all geological risk factors (trap, reservoir, seal, source, timing/migration) are present and effective. Expressed as percentage (0.00 to 100.00). Used to calculate risked resource estimates.',
    `geophysicist_name` STRING COMMENT 'Name of the lead geophysicist responsible for seismic interpretation and depth conversion. Used for accountability and technical review.',
    `giip_unrisked_bcf` DECIMAL(18,2) COMMENT 'Unrisked estimate of original gas in place in billion cubic feet. Calculated from volumetric parameters before applying geological chance of success.',
    `gross_rock_volume_mmcf` DECIMAL(18,2) COMMENT 'Total rock volume within the structural closure in million cubic feet. Calculated from seismic interpretation and depth structure maps in Petrel.',
    `hydrocarbon_saturation_fraction` DECIMAL(18,2) COMMENT 'Average hydrocarbon saturation (1 minus water saturation) as a fraction (0.0 to 1.0). Estimated from analog well logs and petrophysical models.',
    `hydrocarbon_type` STRING COMMENT 'Expected hydrocarbon phase in the prospect: oil, gas, condensate, or mixed. Drives economic evaluation and facility design assumptions.. Valid values are `oil|gas|condensate|mixed`',
    `interpretation_date` DATE COMMENT 'Date when the G&G interpretation and prospect evaluation were completed. Used for tracking prospect vintage and re-evaluation cycles.',
    `maturity_level` STRING COMMENT 'Maturity classification: lead (early stage, low confidence), prospect (G&G analysis complete), or drillable prospect (AFE approved, ready to drill).. Valid values are `lead|prospect|drillable_prospect`',
    `net_to_gross_ratio` DECIMAL(18,2) COMMENT 'Ratio of net reservoir thickness to gross interval thickness. Derived from analog well log analysis and petrophysical modeling. Range 0.0 to 1.0.',
    `porosity_fraction` DECIMAL(18,2) COMMENT 'Average reservoir porosity as a fraction (0.0 to 1.0). Estimated from seismic inversion, analog wells, and core data. Key input for STOIIP/GIIP calculation.',
    `prms_resource_class` STRING COMMENT 'SPE PRMS classification of the prospect resource: 1P (proved), 2P (proved plus probable), 3P (proved plus probable plus possible), contingent, prospective, or unrecoverable. Used for SEC reserves disclosure.. Valid values are `1P|2P|3P|contingent|prospective|unrecoverable`',
    `prospect_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the prospect for tracking across Landmark DecisionSpace and Schlumberger Petrel systems. Used in AFE and JIB documentation.',
    `prospect_name` STRING COMMENT 'Business name assigned to the prospect for identification and communication purposes. Human-readable label used in exploration planning and AFE documentation.',
    `prospect_status` STRING COMMENT 'Current lifecycle status of the prospect: identified (initial screening), evaluated (G&G analysis complete), matured (ready for drilling decision), drilled (well spudded), or abandoned (dropped from portfolio).. Valid values are `identified|evaluated|matured|drilled|abandoned`',
    `reservoir_risk_factor` DECIMAL(18,2) COMMENT 'Probability that reservoir quality (porosity, permeability) is adequate for commercial production (0.0 to 1.0). Component of geological chance of success calculation.',
    `seal_risk_factor` DECIMAL(18,2) COMMENT 'Probability that an effective seal (cap rock) is present to prevent hydrocarbon migration (0.0 to 1.0). Component of geological chance of success calculation.',
    `source_risk_factor` DECIMAL(18,2) COMMENT 'Probability that mature source rock is present and has generated sufficient hydrocarbons (0.0 to 1.0). Component of geological chance of success calculation.',
    `stoiip_unrisked_mmboe` DECIMAL(18,2) COMMENT 'Unrisked estimate of original oil in place in million barrels of oil equivalent. Calculated from volumetric parameters before applying geological chance of success.',
    `structural_closure_area_acres` DECIMAL(18,2) COMMENT 'Areal extent of the structural closure at the spill point in acres. Key input for volumetric resource calculation and STOIIP/GIIP estimation.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the prospect surface location in decimal degrees. Used for GIS mapping and regulatory filing.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the prospect surface location in decimal degrees. Used for GIS mapping and regulatory filing.',
    `target_depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth to the top of the reservoir target in feet below surface or seabed. Used for drilling cost estimation and well planning.',
    `timing_migration_risk_factor` DECIMAL(18,2) COMMENT 'Probability that hydrocarbon generation, migration, and trap formation occurred in the correct sequence (0.0 to 1.0). Component of geological chance of success calculation.',
    `trap_risk_factor` DECIMAL(18,2) COMMENT 'Probability that a valid hydrocarbon trap exists (0.0 to 1.0). Component of geological chance of success calculation.',
    `trap_type` STRING COMMENT 'Classification of the hydrocarbon trapping mechanism: structural (anticline, fault block), stratigraphic (pinchout, unconformity), combination, or hydrodynamic.. Valid values are `structural|stratigraphic|combination|hydrodynamic`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the prospect record was last modified. Used for audit trail and change tracking.',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Water depth at the prospect surface location in feet. Applicable for offshore prospects. Used for drilling cost estimation and rig selection.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Master record for individual drillable prospects identified within a play. Captures prospect name, location (latitude/longitude/block), trap type, structural closure area, gross rock volume (GRV), net-to-gross ratio, porosity, hydrocarbon saturation, formation volume factor, risked and unrisked STOIIP/GIIP estimates, geological chance of success (GCoS), and PRMS resource classification (1P/2P/3P). SSOT for prospect identity and resource potential. Integrates with Schlumberger Petrel 3D modeling.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`lead` (
    `lead_id` BIGINT COMMENT 'Unique identifier for the exploration lead record. Primary key.',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which the lead is located.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Lead maturation activities (seismic studies, G&G work) in joint-operated areas require JOA-governed AFE approvals and cost-sharing. Direct JOA linkage on lead enables work program commitment tracking ',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Leads are identified on specific leased acreage. Land position (lease expiry, working interest, royalty burden) directly impacts lead screening economics, promotion decisions, and drilling rights. Ess',
    `block_id` BIGINT COMMENT 'Reference to the exploration license or lease block in which the lead is located.',
    `play_id` BIGINT COMMENT 'Reference to the geological play or petroleum system to which this lead belongs.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Leads requiring data acquisition (seismic, studies) are registered as exploration projects for capital budgeting and portfolio management. E&P companies track lead maturation costs under project codes',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Exploration expenditures on leads in PSA areas are cost-recoverable. Direct PSA linkage on lead enables cost-recovery eligibility tracking and government reporting of exploration spend against PSA cos',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Lead economic screening (screening_npv_mm_usd, screening_irr_percent) requires a specific crude grade assumption for differential pricing against benchmarks. Portfolio teams explicitly assign a target',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Leads identify expected hydrocarbon product type early in exploration workflow. Drives screening economics using product-specific price assumptions and play fairway analysis. Real business process: le',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Leads that advance to evaluation stage (screening NPV/IRR tracked) become capital projects with WBS elements for cost tracking and investment decision support. Required for project accounting and capi',
    `archive_reason_code` STRING COMMENT 'Reason code for archiving the lead if it fails screening or evaluation. Below Threshold: resource size too small; High Risk: GCoS below acceptable level; No Data: insufficient data to evaluate; Strategic Misfit: does not align with portfolio strategy; Regulatory Constraint: permitting or access issues; Other: other reasons.. Valid values are `below_threshold|high_risk|no_data|strategic_misfit|regulatory_constraint|other`',
    `archive_reason_description` STRING COMMENT 'Detailed explanation of why the lead was archived, including technical, commercial, or strategic rationale.',
    `archived_date` DATE COMMENT 'Date when the lead was archived and removed from active portfolio.',
    `charge_risk_probability` DECIMAL(18,2) COMMENT 'Probability (0 to 1) that hydrocarbons have been generated, migrated, and charged into the trap.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the lead is geographically located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lead record was first created in the system.',
    `data_requirement_description` STRING COMMENT 'Description of additional seismic, well, or geological data required to mature the lead to prospect status. May include 3D seismic acquisition, reprocessing, or analog well data.',
    `depth_subsea_m` DECIMAL(18,2) COMMENT 'Estimated depth of the target reservoir below sea level in meters. Negative values indicate above sea level.',
    `estimated_capex_mm_usd` DECIMAL(18,2) COMMENT 'Preliminary estimate of total capital expenditure required to develop the lead if promoted to prospect and drilled, in million USD.',
    `estimated_opex_mm_usd_per_year` DECIMAL(18,2) COMMENT 'Preliminary estimate of annual operating expenditure in million USD per year if the lead is developed.',
    `evaluated_date` DATE COMMENT 'Date when detailed evaluation of the lead was completed.',
    `geological_chance_of_success` DECIMAL(18,2) COMMENT 'Probability (0 to 1) that all geological risk factors are favorable and the lead contains moveable hydrocarbons. Product of trap, reservoir, seal, and charge probabilities.',
    `gross_rock_volume_mm3` DECIMAL(18,2) COMMENT 'Estimated total rock volume of the lead structure in million cubic meters.',
    `hydrocarbon_saturation_fraction` DECIMAL(18,2) COMMENT 'Estimated average hydrocarbon saturation in the reservoir pore space as a fraction (0 to 1). One minus water saturation.',
    `hydrocarbon_type` STRING COMMENT 'Expected hydrocarbon phase in the lead accumulation. Oil: liquid petroleum; Gas: natural gas; Condensate: gas condensate; Mixed: oil and gas.. Valid values are `oil|gas|condensate|mixed`',
    `identified_date` DATE COMMENT 'Date when the lead was first identified and entered into the exploration portfolio.',
    `lead_code` STRING COMMENT 'Unique alphanumeric code assigned to the lead for tracking and reference in exploration systems and reports.',
    `lead_name` STRING COMMENT 'Business name or designation assigned to the exploration lead for identification and communication purposes.',
    `lead_status` STRING COMMENT 'Current operational status of the lead. Active: under active evaluation; On Hold: evaluation paused pending data or strategic decision; Archived: no longer being pursued; Promoted: matured to prospect.. Valid values are `active|on_hold|archived|promoted`',
    `lead_type` STRING COMMENT 'Geological classification of the lead based on trap mechanism. Structural: fault or fold trap; Stratigraphic: depositional or diagenetic trap; Combination: both structural and stratigraphic elements; Unconventional: shale, tight gas, or coalbed methane.. Valid values are `structural|stratigraphic|combination|unconventional`',
    `maturation_stage` STRING COMMENT 'Current stage in the lead-to-prospect maturation workflow. Identified: initial concept captured; Screened: passed preliminary technical and commercial filters; Evaluated: detailed subsurface and economic analysis completed; Promoted: advanced to prospect status; Archived: failed screening or evaluation.. Valid values are `identified|screened|evaluated|promoted|archived`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the lead record was last modified.',
    `net_to_gross_ratio` DECIMAL(18,2) COMMENT 'Ratio (0 to 1) of net reservoir thickness to gross interval thickness. Represents proportion of pay zone within the total interval.',
    `porosity_fraction` DECIMAL(18,2) COMMENT 'Estimated average porosity of the reservoir rock as a fraction (0 to 1). Represents pore volume as percentage of total rock volume.',
    `promoted_date` DATE COMMENT 'Date when the lead was promoted to prospect status and became a drillable candidate.',
    `promotion_criteria` STRING COMMENT 'Business and technical criteria that must be met for the lead to be promoted to drillable prospect status. May include minimum resource size, GCoS threshold, NPV hurdle, or strategic fit.',
    `recovery_factor` DECIMAL(18,2) COMMENT 'Estimated fraction (0 to 1) of in-place hydrocarbons that can be economically recovered using primary and secondary recovery methods.',
    `reservoir_risk_probability` DECIMAL(18,2) COMMENT 'Probability (0 to 1) that reservoir rock with adequate porosity and permeability is present.',
    `resource_high_boe` DECIMAL(18,2) COMMENT 'High-case (P10) risked resource estimate for the lead in barrels of oil equivalent. Represents optimistic scenario.',
    `resource_low_boe` DECIMAL(18,2) COMMENT 'Low-case (P90) risked resource estimate for the lead in barrels of oil equivalent. Represents conservative scenario.',
    `resource_mid_boe` DECIMAL(18,2) COMMENT 'Mid-case (P50) risked resource estimate for the lead in barrels of oil equivalent. Represents most likely scenario.',
    `screened_date` DATE COMMENT 'Date when the lead passed preliminary screening and was advanced to evaluation stage.',
    `screening_irr_percent` DECIMAL(18,2) COMMENT 'Preliminary internal rate of return estimate as a percentage based on screening-level economic assumptions.',
    `screening_npv_mm_usd` DECIMAL(18,2) COMMENT 'Preliminary net present value estimate in million USD based on screening-level economic assumptions. Used for portfolio ranking and prioritization.',
    `seal_risk_probability` DECIMAL(18,2) COMMENT 'Probability (0 to 1) that an effective seal (cap rock) is present to prevent hydrocarbon migration.',
    `timing_risk_probability` DECIMAL(18,2) COMMENT 'Probability (0 to 1) that trap formation occurred before or during hydrocarbon migration.',
    `trap_risk_probability` DECIMAL(18,2) COMMENT 'Probability (0 to 1) that a viable trap structure exists at the time of hydrocarbon migration.',
    `water_depth_m` DECIMAL(18,2) COMMENT 'Water depth at the lead location in meters. Zero for onshore leads.',
    CONSTRAINT pk_lead PRIMARY KEY(`lead_id`)
) COMMENT 'Master record for exploration leads — early-stage hydrocarbon accumulation concepts not yet matured to drillable prospect status. Captures lead name, play association, maturation stage (identified/screened/evaluated), data requirements for promotion to prospect, risked resource range (low/mid/high), lead-level geological risk factors, and screening-level economic indicators. Supports the lead-to-prospect maturation workflow, portfolio funnel management, and new ventures screening. Leads that mature are promoted to prospect records; leads that fail screening are archived with reason codes.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` (
    `seismic_survey_id` BIGINT COMMENT 'Unique identifier for the seismic survey record. Primary key for the seismic survey entity.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Seismic acquisition operations staged from production facilities (onshore bases, offshore platforms) for logistics, cost allocation, HSE coordination, and vessel/equipment mobilization planning. Role ',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Seismic survey costs are allocated to cost centers for exploration cost reporting and budget variance analysis. Cost center assignment on seismic surveys is required for G&G cost tracking in E&P finan',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Seismic surveys are major capital expenditures requiring AFE authorization; each survey is approved via an AFE for budget control, cost tracking, and JV partner approval. Critical for capital expendit',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Seismic data acquisition costs are capitalized as intangible fixed assets under successful efforts accounting when associated with proved properties. Direct link enables seismic cost capitalization wo',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Seismic surveys in joint-operated areas are governed by JOA provisions: AFE approval thresholds, cost-sharing ratios, and JIB billing. Direct JOA linkage on seismic_survey enables partner cost allocat',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Seismic surveys are acquired over leased acreage. Surface access rights, environmental permits, and data ownership are tied to lease agreements. Required for cost allocation, regulatory compliance, an',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Seismic operations require environmental permits (marine mammal protection, NEPA clearances) and regulatory approvals before acquisition. Standard HSE compliance requirement. Links survey to its envir',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Seismic surveys are capital projects with dedicated project codes in E&P financial systems. Large 3D seismic campaigns require project-level cost tracking, milestone management, and CAPEX reporting se',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Seismic surveys in PSA areas are cost-recoverable exploration expenditures. Direct PSA linkage enables cost-recovery accounting, government audit support, and minimum work obligation tracking for seis',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Seismic surveys require regulatory filings distinct from the drill permit — e.g., environmental impact notifications, maritime authority survey notifications, and HSE pre-activity filings. Operators m',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: Seismic acquisition crews require surface use agreements with landowners for access, vibroseis operations, and shot-hole drilling. Environmental clearance and compensation payments are tracked against',
    `acquisition_end_date` DATE COMMENT 'Date when field acquisition operations were completed for this seismic survey. Used to calculate acquisition duration and assess data currency.',
    `acquisition_method` STRING COMMENT 'Physical method used to acquire seismic data. Towed streamer for marine surveys with hydrophone cables, OBC (Ocean Bottom Cable) for seabed cable systems, OBN (Ocean Bottom Node) for autonomous seabed nodes, land vibroseis for truck-mounted vibrator sources, land dynamite for explosive sources, transition zone for shallow water/marsh environments, borehole for VSP and crosswell surveys. [ENUM-REF-CANDIDATE: towed_streamer|OBC|OBN|land_vibroseis|land_dynamite|transition_zone|borehole — 7 candidates stripped; promote to reference product]',
    `acquisition_start_date` DATE COMMENT 'Date when field acquisition operations commenced for this seismic survey. Marks the beginning of the survey lifecycle and is used for project tracking and data vintage assessment.',
    `bin_size_m` DECIMAL(18,2) COMMENT 'Spatial grid cell size for 3D seismic data binning measured in meters. Defines the horizontal resolution of the processed seismic volume. Common values: 12.5 m x 12.5 m for high-resolution surveys, 25 m x 25 m for standard surveys.',
    `coordinate_system` STRING COMMENT 'Spatial reference system used for survey positioning and navigation (e.g., WGS84, NAD83, UTM Zone 15N, State Plane). Critical for integration with well data, lease boundaries, and GIS workflows.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure for seismic survey acquisition, processing, and interpretation measured in United States Dollars. Used for AFE (Authorization for Expenditure) tracking, joint venture billing, and economic analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this seismic survey record was first created in the data management system. Used for audit trail and data lineage tracking.',
    `data_format` STRING COMMENT 'Digital file format standard used for seismic data storage and exchange. SEG-Y for Society of Exploration Geophysicists Y-format (industry standard), SEG-D for field recording format, SEG-2 for legacy format, SEGY_Rev1/Rev2 for specific revisions, proprietary for vendor-specific formats.. Valid values are `SEG-Y|SEG-D|SEG-2|SEGY_Rev1|SEGY_Rev2|proprietary`',
    `data_quality_rating` STRING COMMENT 'Qualitative assessment of overall seismic data quality based on signal-to-noise ratio, imaging clarity, structural resolution, and interpretability. Used by geophysicists to determine fitness for prospect evaluation and reserves booking.. Valid values are `excellent|good|fair|poor|marginal`',
    `data_volume_tb` DECIMAL(18,2) COMMENT 'Total size of seismic data volume measured in terabytes. Includes raw field data, processed volumes, and interpretation products. Used for storage planning and data transfer logistics.',
    `datum_elevation_m` DECIMAL(18,2) COMMENT 'Vertical reference elevation for seismic time-depth conversion measured in meters relative to mean sea level. Used to tie seismic data to well logs and subsurface geological models.',
    `dominant_frequency_hz` DECIMAL(18,2) COMMENT 'Peak frequency content of the seismic wavelet measured in Hertz. Determines vertical resolution capability and is critical for thin bed detection and reservoir characterization. Typical ranges: 15-40 Hz for deep targets, 40-80 Hz for shallow reservoirs.',
    `environmental_clearance_date` DATE COMMENT 'Date when environmental impact assessment and regulatory clearances were obtained for seismic acquisition operations. Required for HSE compliance and permitting workflows.',
    `fold_coverage` STRING COMMENT 'Number of times each subsurface point is sampled during seismic acquisition, representing the redundancy and stacking power of the survey. Higher fold improves signal-to-noise ratio. Typical values: 30-60 fold for 3D surveys, 6-12 fold for 2D surveys.',
    `interpretation_status` STRING COMMENT 'Current stage of geological and geophysical interpretation workflow. Not_started for uninterpreted data, in_progress for active interpretation, preliminary for initial interpretation results, final for completed interpretation, peer_reviewed for QC-validated interpretation ready for prospect generation.. Valid values are `not_started|in_progress|preliminary|final|peer_reviewed`',
    `licensing_terms` STRING COMMENT 'Commercial ownership and usage rights model for the seismic data. Proprietary for company-owned exclusive data, multi-client for shared-cost industry surveys, open_file for publicly available data, licensed for third-party data under license agreement, exclusive for sole access rights, non-exclusive for shared access with other licensees.. Valid values are `proprietary|multi-client|open_file|licensed|exclusive|non-exclusive`',
    `migration_type` STRING COMMENT 'Seismic imaging algorithm applied to position reflectors to their true subsurface locations. None for unmigrated data, post-stack_time for stacked time migration, pre-stack_time for PSTM, post-stack_depth for stacked depth migration, pre-stack_depth for PSDM, RTM for reverse-time migration, Kirchhoff for Kirchhoff migration, beam for beam migration. [ENUM-REF-CANDIDATE: none|post-stack_time|pre-stack_time|post-stack_depth|pre-stack_depth|RTM|Kirchhoff|beam — 8 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this seismic survey record was last updated. Used for change tracking and data governance workflows.',
    `play_type` STRING COMMENT 'Geological play classification targeted by the seismic survey (e.g., structural trap, stratigraphic trap, unconventional shale, deepwater turbidite, carbonate reef). Aligns survey data with exploration strategy and prospect generation workflows.',
    `processing_completion_date` DATE COMMENT 'Date when final seismic data processing was completed and deliverable products were generated. Indicates when data became available for interpretation and prospect evaluation.',
    `processing_contractor` STRING COMMENT 'Name of the seismic processing contractor or service company that performed data processing workflows (e.g., WesternGeco, CGG, PGS, ION Geophysical). May differ from acquisition contractor.',
    `processing_sequence` STRING COMMENT 'Summary description of the seismic processing workflow and key algorithms applied (e.g., demultiple, velocity analysis, migration type, noise attenuation methods). Used for data quality assessment and reprocessing decisions.',
    `processing_status` STRING COMMENT 'Current stage of seismic data processing. Raw for unprocessed field data, pre-stack for data before stack, post-stack for stacked data, PSDM (Pre-Stack Depth Migration) for advanced depth imaging, PSTM (Pre-Stack Time Migration) for time-domain migration, final for deliverable product, reprocessed for data that has undergone modern reprocessing workflows. [ENUM-REF-CANDIDATE: raw|pre-stack|post-stack|PSDM|PSTM|final|reprocessed — 7 candidates stripped; promote to reference product]',
    `receiver_spacing_m` DECIMAL(18,2) COMMENT 'Distance between adjacent receiver stations or hydrophone groups measured in meters. Determines spatial sampling density and horizontal resolution. Typical values: 12.5-25 m for 3D surveys, 50-100 m for 2D surveys.',
    `record_length_ms` DECIMAL(18,2) COMMENT 'Total recording time for each seismic trace measured in milliseconds. Determines the maximum depth of investigation. Typical values: 6000-12000 ms for deep exploration targets, 3000-6000 ms for shallow development surveys.',
    `sample_interval_ms` DECIMAL(18,2) COMMENT 'Time sampling rate for seismic data recording measured in milliseconds. Determines temporal resolution and Nyquist frequency. Standard values: 2 ms or 4 ms for conventional surveys, 1 ms for high-resolution surveys.',
    `shot_point_interval_m` DECIMAL(18,2) COMMENT 'Distance between successive seismic source activation points measured in meters. Controls subsurface sampling density and fold coverage. Typical values: 25-50 m for 3D surveys, 50-100 m for 2D surveys.',
    `source_type` STRING COMMENT 'Type of seismic energy source used for signal generation. Airgun for marine compressed air sources, vibroseis for truck-mounted vibrators, dynamite for explosive sources, weight_drop for accelerated weight impact, sparker for high-resolution marine surveys, boomer for shallow water surveys.. Valid values are `airgun|vibroseis|dynamite|weight_drop|sparker|boomer`',
    `storage_location` STRING COMMENT 'Physical or cloud storage location where seismic data volumes are archived (e.g., tape library, disk array, cloud object storage path). Used for data management and retrieval workflows.',
    `survey_area_sq_km` DECIMAL(18,2) COMMENT 'Total geographic area covered by the seismic survey measured in square kilometers. For 2D surveys, represents the bounding box area; for 3D surveys, represents the actual acquisition footprint.',
    `survey_name` STRING COMMENT 'Business name or designation assigned to the seismic survey for identification and reference purposes.',
    `survey_type` STRING COMMENT 'Classification of the seismic survey based on dimensionality and acquisition geometry. 2D for two-dimensional line surveys, 3D for three-dimensional volume surveys, 4D for time-lapse repeat surveys, VSP for vertical seismic profile, multi-component for shear wave acquisition, ocean_bottom for OBC/OBN surveys.. Valid values are `2D|3D|4D|VSP|multi-component|ocean_bottom`',
    `total_line_count` STRING COMMENT 'Total number of seismic lines acquired in the survey. For 2D surveys, represents the number of individual lines; for 3D surveys, represents the number of inline and crossline directions combined.',
    `total_line_km` DECIMAL(18,2) COMMENT 'Cumulative length of all seismic lines in the survey measured in kilometers. Used for project scope quantification, cost estimation, and acquisition progress tracking.',
    `velocity_model_type` STRING COMMENT 'Type of velocity model used for seismic imaging and depth conversion. Constant for simple single-velocity model, layered for interval velocity model, tomography for tomographic inversion, FWI (Full Waveform Inversion) for advanced velocity building, anisotropic for VTI/TTI models, isotropic for standard velocity models.. Valid values are `constant|layered|tomography|FWI|anisotropic|isotropic`',
    `vintage_year` STRING COMMENT 'Calendar year when the seismic survey was acquired in the field. Used to assess data currency and technology generation for interpretation and prospect evaluation.',
    `water_depth_m` DECIMAL(18,2) COMMENT 'Average water depth in meters for marine seismic surveys. Critical parameter for acquisition planning, processing velocity models, and operational feasibility assessment. Null for land surveys.',
    CONSTRAINT pk_seismic_survey PRIMARY KEY(`seismic_survey_id`)
) COMMENT 'Master record for seismic acquisition surveys (2D, 3D, 4D) including survey-level and line-level detail. Survey attributes: survey name, type, acquisition method (towed streamer, OBC, OBN, land vibroseis), survey area (sq km), vintage year, acquisition contractor, processing status, data quality rating, dominant frequency, fold coverage, and licensing terms. Line-level attributes: line name/number, shot point range, line length (km), azimuth, acquisition parameters (record length, sample interval, source type, receiver spacing), processing sequence, and interpretation status. SSOT for seismic survey identity, line inventory, and data management. Integrates with Landmark DecisionSpace seismic interpretation workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`formation` (
    `formation_id` BIGINT COMMENT 'Unique identifier for the stratigraphic formation record. Primary key for the formation master reference table.',
    `average_permeability_md` DECIMAL(18,2) COMMENT 'Average permeability of the formation measured in millidarcies (mD). Critical for production forecasting, well completion design, and EOR (Enhanced Oil Recovery) feasibility assessment.',
    `average_porosity_percent` DECIMAL(18,2) COMMENT 'Average porosity of the formation expressed as a percentage. Key petrophysical parameter for reservoir volumetrics and EUR (Estimated Ultimate Recovery) calculations.',
    `average_thickness_ft` DECIMAL(18,2) COMMENT 'Average gross thickness of the formation measured in feet across its regional extent. Used for volumetric calculations, STOIIP (Stock Tank Oil Initially in Place) and OGIP (Original Gas in Place) estimates, and well planning.',
    `base_marker` STRING COMMENT 'Stratigraphic or seismic marker used to identify the base boundary of the formation. Used in conjunction with the top marker to define the formation interval in subsurface models.',
    `chronostratigraphic_chart_reference` STRING COMMENT 'Reference to the regional or international chronostratigraphic chart used for age correlation. Ensures consistency with ICS (International Commission on Stratigraphy) standards and regional basin frameworks.',
    `completion_type_recommendation` STRING COMMENT 'Recommended well completion strategy for the formation (e.g., openhole, cased-hole perforation, horizontal multi-stage fracturing, gravel pack). Based on reservoir characteristics and production optimization studies.',
    `data_source` STRING COMMENT 'Primary data source or system from which the formation attributes were derived (e.g., Landmark DecisionSpace, Schlumberger Petrel, regional geological survey, published literature). Supports data lineage and quality assessment.',
    `depositional_environment` STRING COMMENT 'Sedimentary environment in which the formation was deposited (e.g., marine shelf, deltaic, fluvial, lacustrine, deep marine, aeolian). Influences reservoir architecture, connectivity, and hydrocarbon distribution patterns.',
    `drilling_hazard_notes` STRING COMMENT 'Free-text notes documenting known drilling hazards associated with the formation (e.g., overpressure, lost circulation zones, H2S presence, unstable shales). Critical for well planning and AFE (Authorization for Expenditure) risk assessment.',
    `eur_estimate_boe` DECIMAL(18,2) COMMENT 'Estimated Ultimate Recovery per well for the formation, expressed in BOE (Barrels of Oil Equivalent). Used for economic evaluation, reserves booking, and portfolio ranking.',
    `exploration_maturity` STRING COMMENT 'Maturity level of exploration activity in the formation. Frontier = minimal data; Emerging = early exploration; Mature = well-understood with production history; Depleted = late-life or abandoned.. Valid values are `frontier|emerging|mature|depleted`',
    `formation_code` STRING COMMENT 'Standardized alphanumeric code or abbreviation for the formation used in well logs, seismic interpretation, and subsurface mapping. Enables rapid identification in operational systems such as Landmark DecisionSpace and Schlumberger Petrel.',
    `formation_name` STRING COMMENT 'Official stratigraphic name of the geological formation following AAPG (American Association of Petroleum Geologists) nomenclature standards. Used for consistent identification across G&G (Geological and Geophysical) interpretation, prospect evaluation, and well targeting.',
    `formation_status` STRING COMMENT 'Current lifecycle status of the formation record. Active = in use for exploration and well planning; Inactive = no longer targeted; Under Review = pending geological re-evaluation; Deprecated = superseded by updated nomenclature.. Valid values are `active|inactive|under_review|deprecated`',
    `hydrocarbon_type` STRING COMMENT 'Primary hydrocarbon type produced or expected from the formation. Used for play typing, prospect evaluation, and reserves classification under PRMS (Petroleum Resources Management System) standards.. Valid values are `oil|gas|condensate|mixed|unknown`',
    `last_updated_date` DATE COMMENT 'Date when the formation record was last updated or reviewed. Ensures data currency and supports audit trails for regulatory compliance and internal quality control.',
    `lithology_type` STRING COMMENT 'Primary rock type or lithological composition of the formation. Critical for reservoir quality assessment, drilling hazard identification, and petrophysical modeling. [ENUM-REF-CANDIDATE: sandstone|shale|limestone|dolomite|siltstone|conglomerate|chalk|marl|evaporite|coal|mixed — 11 candidates stripped; promote to reference product]',
    `net_to_gross_ratio` DECIMAL(18,2) COMMENT 'Ratio of net reservoir thickness to gross formation thickness, expressed as a decimal (0.0 to 1.0). Indicates the proportion of the formation that is productive reservoir rock versus non-reservoir intervals.',
    `play_type` STRING COMMENT 'Exploration play type associated with the formation (e.g., structural trap, stratigraphic trap, combination trap, unconventional resource play). Used for prospect classification and portfolio management.',
    `prms_resource_class` STRING COMMENT 'Petroleum Resources Management System (PRMS) classification of resources associated with the formation. 1P = Proved Reserves, 2P = Proved plus Probable, 3P = Proved plus Probable plus Possible. Aligns with SPE/SEC reserves reporting standards.. Valid values are `1P|2P|3P|Contingent|Prospective|Unknown`',
    `regional_extent` STRING COMMENT 'Geographic or basin-scale distribution of the formation (e.g., Gulf Coast Basin, Permian Basin, North Sea). Defines the area over which the formation is recognized and correlated.',
    `remarks` STRING COMMENT 'Additional free-text comments or notes regarding the formation, including special geological features, correlation challenges, or operational considerations. Supports knowledge capture and cross-functional collaboration.',
    `reservoir_quality_class` STRING COMMENT 'Reservoir quality classification based on porosity, permeability, and net-to-gross ratio. Class I represents excellent reservoir quality; Class IV represents poor quality; Non-Reservoir indicates non-productive intervals.. Valid values are `Class I|Class II|Class III|Class IV|Non-Reservoir`',
    `seal_quality` STRING COMMENT 'Assessment of the overlying seal or cap rock quality that prevents hydrocarbon migration. Critical for trap integrity evaluation and risk assessment in prospect generation.. Valid values are `excellent|good|fair|poor|unknown`',
    `source_rock_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the formation is recognized as a hydrocarbon source rock. True if the formation has demonstrated source rock potential based on TOC (Total Organic Carbon), maturity, and geochemical analysis.',
    `stratigraphic_age_epoch` STRING COMMENT 'Geological epoch subdivision within the period (e.g., Early Cretaceous, Late Jurassic). Provides finer temporal resolution for stratigraphic correlation and basin analysis.',
    `stratigraphic_age_period` STRING COMMENT 'Geological time period during which the formation was deposited (e.g., Jurassic, Cretaceous, Permian). Aligns with the ICS (International Commission on Stratigraphy) International Chronostratigraphic Chart.',
    `stratigraphic_age_stage` STRING COMMENT 'Geological stage within the epoch (e.g., Albian, Aptian, Turonian). Finest level of chronostratigraphic resolution used for detailed correlation studies and regional play analysis.',
    `thickness_range_max_ft` DECIMAL(18,2) COMMENT 'Maximum observed thickness of the formation in feet. Represents the upper bound of thickness variability, often associated with basin depocenters or structural lows.',
    `thickness_range_min_ft` DECIMAL(18,2) COMMENT 'Minimum observed thickness of the formation in feet. Represents the lower bound of thickness variability across the basin or play fairway.',
    `top_marker` STRING COMMENT 'Stratigraphic or seismic marker used to identify the top boundary of the formation in well logs and seismic data. Enables consistent correlation across wells and seismic surveys.',
    `type_section_reference` STRING COMMENT 'Reference to the type section or stratotype location where the formation was originally defined and described. Provides the authoritative reference for stratigraphic nomenclature and correlation.',
    CONSTRAINT pk_formation PRIMARY KEY(`formation_id`)
) COMMENT 'Reference master for stratigraphic formations and reservoir units relevant to exploration targeting and well evaluation. Captures formation name, stratigraphic age (period/epoch/stage), lithology type, depositional environment, average thickness, regional extent, source rock indicator flag, reservoir quality classification (I/II/III/IV), type section reference, and correlation to regional chronostratigraphic chart. Used for consistent stratigraphic nomenclature across G&G interpretation, prospect evaluation, well targeting, and cross-basin correlation studies. Aligns with AAPG stratigraphic nomenclature standards and ICS International Chronostratigraphic Chart.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`block` (
    `block_id` BIGINT COMMENT 'Primary key for block',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which this block is located. Links to basin master data for regional geological context and play fairway analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration blocks are cost centers in oil-and-gas accounting; all block-related costs (seismic, G&G, lease maintenance) are tracked to specific cost centers for budgeting, variance analysis, and JV b',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or partnership arrangement under which the block is being explored. Links to joint venture master data for partner tracking and cost allocation.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Exploration blocks are often subdivided into or overlap with leases. Regulatory filings, work program commitments, and commercial tracking require linking blocks to specific lease agreements for right',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Exploration blocks are governed by operating licenses (PSAs, concessions) defining authorized activities, work programs, and fiscal terms. Legal framework for block operations. Links block to its gove',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Exploration blocks are mapped to profit centers for production sharing agreement (PSA) revenue allocation, working interest P&L reporting, and segment financial reporting. Block-level profit center as',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: International exploration blocks often operate under Production Sharing Agreements defining fiscal terms, cost recovery, and profit split. Links block-level exploration activities to PSA cost recovery',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: block.regulatory_body is a plain text denormalization of regulatory_authority. The regulatory body governing a block drives permit applications, work program compliance, and operating license manageme',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Block minimum work program obligations (seismic km, well count) are tracked under WBS elements for project cost control and regulatory compliance reporting. WBS-level tracking enables block-by-block C',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Total geographic area of the exploration block in square kilometers as defined in the license agreement. Used for acreage tracking, relinquishment calculations, and work program planning.',
    `block_name` STRING COMMENT 'Common name or designation for the exploration block, often including geographic or regional identifiers for ease of reference.',
    `block_number` STRING COMMENT 'Official block number or identifier assigned by the regulatory authority or licensing body. This is the externally-known business identifier used in regulatory filings, license agreements, and industry communications.',
    `cost_recovery_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of gross revenues that can be used for cost recovery under a PSA fiscal regime. Limits the contractors ability to recover exploration and development costs from production.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the sovereign jurisdiction in which the block is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this block record was first created in the system. Used for audit trail and data lineage tracking.',
    `discovery_flag` BOOLEAN COMMENT 'Indicates whether a commercial hydrocarbon discovery has been made within the block. True if at least one discovery has been declared; false otherwise.',
    `effective_date` DATE COMMENT 'Date on which the exploration license becomes legally effective and operational activities may commence. May differ from award date due to regulatory approvals or contract execution timelines.',
    `environmental_sensitivity_flag` BOOLEAN COMMENT 'Indicates whether the block is located in or adjacent to an environmentally sensitive area requiring enhanced HSE protocols, such as marine protected areas, coral reefs, or critical habitats.',
    `first_discovery_date` DATE COMMENT 'Date of the first commercial hydrocarbon discovery within the block. Marks a significant milestone in the blocks exploration history and may trigger license extension or conversion rights.',
    `fiscal_regime_type` STRING COMMENT 'Type of fiscal and contractual regime governing the exploration license. Determines cost recovery mechanisms, profit sharing, and taxation structures.. Valid values are `concession|psa|service_contract|risk_service_contract`',
    `geological_risk_factor` DECIMAL(18,2) COMMENT 'Probability of geological success for the block, expressed as a decimal between 0 and 1. Represents the chance of discovering commercial hydrocarbons based on play fairway analysis and geological risk assessment.',
    `hydrocarbon_type` STRING COMMENT 'Expected or discovered hydrocarbon type in the block. Indicates whether the block is prospective for oil, natural gas, condensate, or a mixed hydrocarbon system.. Valid values are `oil|gas|condensate|mixed`',
    `last_seismic_survey_date` DATE COMMENT 'Date of the most recent seismic survey conducted over the block. Used to assess data currency and plan reprocessing or new acquisition campaigns.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this block record was last modified. Used for audit trail, change tracking, and data currency assessment.',
    `minimum_work_program_seismic_km` DECIMAL(18,2) COMMENT 'Minimum number of kilometers of seismic survey data acquisition required under the exploration license work program. Represents a firm commitment to the regulatory authority.',
    `minimum_work_program_well_count` STRING COMMENT 'Minimum number of exploration or appraisal wells required to be drilled under the exploration license work program. Represents a firm drilling commitment to the regulatory authority.',
    `net_revenue_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest held by the company in this exploration block after deducting royalties and other burdens. NRI represents the actual economic share of production revenues.',
    `offshore_onshore_flag` STRING COMMENT 'Indicates whether the block is located offshore (in marine waters) or onshore (on land). Critical for determining applicable regulatory frameworks, operational requirements, and cost structures.. Valid values are `offshore|onshore`',
    `play_type` STRING COMMENT 'Geological play type or petroleum system classification for the block (e.g., structural trap, stratigraphic trap, combination trap). Used for portfolio segmentation and risk analysis.',
    `primary_target_formation` STRING COMMENT 'Name of the primary geological formation or reservoir interval targeted for exploration drilling in this block. Represents the main prospective zone of interest.',
    `prms_classification` STRING COMMENT 'Classification of the blocks resource potential according to the SPE PRMS framework. Indicates the maturity and certainty level of resource estimates (prospective resources, contingent resources, or reserves).. Valid values are `prospective|contingent|proved|probable|possible`',
    `prospect_count` STRING COMMENT 'Number of identified prospects or leads within the block boundaries. Represents the inventory of drillable opportunities generated from geological and geophysical interpretation.',
    `relinquishment_schedule` STRING COMMENT 'Structured description of the mandatory relinquishment schedule specifying the percentage of block area that must be relinquished at defined intervals during the exploration term. Typically defined in the PSA or license agreement.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or contextual information about the block that does not fit into structured fields. May include historical context, special conditions, or operational notes.',
    `resource_potential_boe` DECIMAL(18,2) COMMENT 'Estimated prospective resource potential of the block in barrels of oil equivalent. Represents the unrisked best estimate of recoverable hydrocarbons based on geological and geophysical analysis.',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'Royalty rate percentage payable to the government or mineral rights owner on gross production from the block. Applicable under concession or royalty-based fiscal regimes.',
    `seismic_data_availability` STRING COMMENT 'Indicates the type and extent of seismic survey data available for the block. Critical for prospect evaluation and drilling risk assessment.. Valid values are `none|2d_only|3d_available|4d_available`',
    `water_depth_max_m` DECIMAL(18,2) COMMENT 'Maximum water depth in meters within the block boundaries. Applicable only to offshore blocks. Critical for determining deepwater vs shallow water classification and associated technical challenges.',
    `water_depth_min_m` DECIMAL(18,2) COMMENT 'Minimum water depth in meters within the block boundaries. Applicable only to offshore blocks. Used for drilling feasibility assessment and rig selection.',
    `well_count` STRING COMMENT 'Total number of exploration, appraisal, or wildcat wells drilled within the block to date. Used for tracking drilling activity and work program compliance.',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the company in this exploration block. Working Interest represents the ownership share and corresponding obligation to fund exploration costs.',
    CONSTRAINT pk_block PRIMARY KEY(`block_id`)
) COMMENT 'Master record for exploration license blocks and concession areas. Captures block name/number, country, offshore/onshore flag, water depth range, block area (sq km), license round, award date, expiration date, relinquishment schedule, minimum work program obligations (seismic km, well count), and regulatory body. Serves as the geographic unit for exploration activity organization — prospects, wells, surveys, and partner interests are all located within blocks. Links to basin for regional context. Integrates with Quorum Land System for license tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`license` (
    `license_id` BIGINT COMMENT 'Primary key for license',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration licenses are cost objects; signature bonuses, work program commitments, and license maintenance costs are tracked to cost centers for accounting and JV partner billing. Required for cost c',
    `joint_venture_id` BIGINT COMMENT 'Foreign key linking to venture.joint_venture. Business justification: Exploration licenses are held by joint ventures. License already links to JOA and PSA but not directly to the JV entity. Direct JV linkage enables JV-level license portfolio reporting, SEC disclosure ',
    `operator_id` BIGINT COMMENT 'FK to land.operator',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Exploration licenses generate revenue entitlements and royalty obligations mapped to profit centers for P&L reporting. License-level profit center assignment is required for net revenue interest calcu',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: license.issuing_authority is a plain text denormalization of regulatory_authority. The authority issuing an exploration license must be a proper FK for license renewal workflows, compliance reporting,',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: License acquisitions, renewals, and relinquishments require regulatory filings with authorities (SEC Form 10-K reserves disclosures, BOEM filings). Mandatory disclosure requirement. Links license to i',
    `acreage_gross` DECIMAL(18,2) COMMENT 'Total surface area covered by the exploration license in acres. Represents the full geographic extent of exploration rights regardless of working interest ownership.',
    `acreage_net` DECIMAL(18,2) COMMENT 'Net acreage attributable to the company based on working interest (WI) percentage. Calculated as gross acreage multiplied by WI. Used for reserves reporting and portfolio valuation.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the exploration license is geographically located (e.g., USA, GBR, NOR). Used for regulatory jurisdiction and fiscal regime mapping.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the exploration license record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date on which the exploration license becomes legally binding and work program commitments commence. Marks the start of the license term.',
    `environmental_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether an Environmental Impact Assessment (EIA) or Environmental Impact Statement (EIS) is required by the issuing authority before exploration activities can commence. True = assessment required; False = not required or already completed.',
    `environmental_assessment_status` STRING COMMENT 'Current status of the environmental assessment process. Tracks progress toward regulatory approval to commence exploration activities.. Valid values are `Not Started|In Progress|Submitted|Approved|Rejected`',
    `estimated_resource_potential_boe` DECIMAL(18,2) COMMENT 'Estimated ultimate recovery (EUR) potential of the license area expressed in barrels of oil equivalent. Represents unrisked prospective resources (not yet classified as reserves). Used for portfolio valuation and investment prioritization.',
    `expiry_date` DATE COMMENT 'Date on which the exploration license term ends unless renewed or extended. After this date, all exploration rights revert to the issuing authority unless a production license is granted or renewal is approved.',
    `geological_risk_factor` DECIMAL(18,2) COMMENT 'Probability of geological success (POS) for the license area, expressed as a decimal between 0 and 1. Represents the likelihood that a prospect contains recoverable hydrocarbons. Used for risked resource valuation and portfolio optimization.',
    `joint_venture_flag` BOOLEAN COMMENT 'Indicates whether the exploration license is held under a joint venture arrangement with multiple working interest partners. True = JV structure; False = single operator or non-JV arrangement.',
    `license_number` STRING COMMENT 'Official license or permit number issued by the regulatory authority. This is the externally-known business identifier used in all regulatory correspondence and filings.',
    `license_status` STRING COMMENT 'Current lifecycle state of the exploration license. Active = in force and work program underway; Pending = application submitted awaiting approval; Suspended = temporarily halted by operator or regulator; Expired = term ended without renewal; Relinquished = voluntarily returned by operator; Terminated = cancelled by regulator or mutual agreement.. Valid values are `Active|Pending|Suspended|Expired|Relinquished|Terminated`',
    `license_type` STRING COMMENT 'Classification of the exploration entitlement. PSC = Production Sharing Contract, JOA = Joint Operating Agreement. Determines fiscal terms, ownership structure, and regulatory obligations.. Valid values are `PSC|Concession|JOA|License|Lease|Permit`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the exploration license record was last updated in the system. Used for change tracking and data quality monitoring.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue the company is entitled to receive after deducting royalties, overriding royalty interests (ORRI), and government share. NRI = WI × (1 - royalty rate - ORRI).',
    `offshore_onshore_flag` STRING COMMENT 'Indicates whether the exploration license covers offshore (subsea) or onshore (land-based) acreage. Determines applicable regulatory framework, HSE requirements, and operational complexity.. Valid values are `Offshore|Onshore`',
    `operator_type` STRING COMMENT 'Classification of the operator entity. IOC = International Oil Company; NOC = National Oil Company; Independent = smaller independent E&P company; JV = Joint Venture entity.. Valid values are `IOC|NOC|Independent|JV`',
    `play_type` STRING COMMENT 'Geological play classification for the license area (e.g., structural trap, stratigraphic trap, unconventional shale, carbonate reef). Used for analog analysis and technical risk assessment.',
    `primary_target_formation` STRING COMMENT 'Name of the primary geological formation or reservoir interval targeted for exploration (e.g., Wolfcamp, Niobrara, Brent). Used for well planning and G&G correlation.',
    `prospect_count` STRING COMMENT 'Number of identified exploration prospects or leads within the license area based on G&G interpretation. Used for portfolio ranking and resource potential assessment.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the license agreement includes a contractual option to renew or extend the exploration term. True = renewal option exists; False = no renewal provision.',
    `renewal_term_years` DECIMAL(18,2) COMMENT 'Duration in years of the renewal or extension period if the renewal option is exercised. Null if no renewal option exists.',
    `resource_classification` STRING COMMENT 'PRMS-aligned classification of hydrocarbon resources within the license area. Prospective = undiscovered; Contingent = discovered but not yet commercial; Proved/Probable/Possible = reserves categories (1P/2P/3P).. Valid values are `Prospective|Contingent|Proved|Probable|Possible`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of gross production or revenue payable to the mineral rights owner or government as royalty. Deducted from working interest to calculate net revenue interest.',
    `seismic_data_available_flag` BOOLEAN COMMENT 'Indicates whether 2D or 3D seismic data has been acquired and is available for interpretation within the license area. True = seismic data exists; False = no seismic coverage.',
    `seismic_data_vintage_year` STRING COMMENT 'Year in which the most recent seismic survey was acquired for the license area. Used to assess data quality and determine need for reprocessing or new acquisition.',
    `signature_bonus_amount` DECIMAL(18,2) COMMENT 'One-time upfront payment made to the issuing authority upon execution of the exploration license agreement. Typically non-refundable and independent of exploration success.',
    `signature_bonus_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the signature bonus payment (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this license data originated (e.g., Quorum Land System, Landmark DecisionSpace). Used for data lineage and reconciliation.',
    `water_depth_max_meters` DECIMAL(18,2) COMMENT 'Maximum water depth in meters within the license area. Applicable only to offshore licenses. Critical for assessing technical feasibility and CAPEX requirements.',
    `water_depth_min_meters` DECIMAL(18,2) COMMENT 'Minimum water depth in meters within the license area. Applicable only to offshore licenses. Used for drilling rig selection and cost estimation.',
    `work_program_commitment_amount` DECIMAL(18,2) COMMENT 'Total monetary value of exploration activities (seismic, drilling, G&G studies) the operator is contractually obligated to spend during the license term. Used for AFE planning and compliance tracking.',
    `work_program_commitment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the work program commitment amount.. Valid values are `^[A-Z]{3}$`',
    `work_program_seismic_km` DECIMAL(18,2) COMMENT 'Minimum number of kilometers of seismic survey (2D or 3D) the operator is contractually committed to acquire during the exploration phase. Failure to meet this commitment may result in penalties or license termination.',
    `work_program_well_count` STRING COMMENT 'Minimum number of exploration or appraisal wells the operator is contractually committed to drill during the license term. Critical compliance metric tracked by regulatory authorities.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage ownership of operating rights and cost-bearing responsibility in the exploration license. WI holders fund exploration activities and receive production revenue net of royalties and government take.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Master record for exploration licenses, permits, and concession agreements granted by regulatory authorities. Captures license number, license type (PSC, concession, JOA, license), issuing authority, effective date, expiry date, renewal options, work program commitments (seismic km, well count), bonus payments, royalty rate, and current status. SSOT for exploration entitlement and license compliance. Integrates with Quorum Land System.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` (
    `prospect_resource_estimate_id` BIGINT COMMENT 'Unique identifier for the prospect resource estimate record. Primary key for this transactional evaluation entity.',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Post-drill resource estimates are revised based on well results (DST rates, net pay, fluid contacts). The drilling well result directly triggers PRMS resource reclassification. This link enables post-',
    `prospect_id` BIGINT COMMENT 'Reference to the prospect being evaluated. Links this resource estimate to the specific exploration prospect or play.',
    `superseded_by_estimate_prospect_resource_estimate_id` BIGINT COMMENT 'Reference to the newer estimate version that supersedes this record. Enables version chain tracking and audit trail for estimate evolution.',
    `charge_adequacy_risk_pct` DECIMAL(18,2) COMMENT 'Probability that sufficient hydrocarbon charge has migrated into the trap. Individual geological risk factor component.',
    `comments` STRING COMMENT 'Free-text field for evaluator notes, assumptions, data quality observations, and technical commentary supporting the resource estimate.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this resource estimate record was first created in the database. Supports audit trail and data lineage.',
    `estimate_date` DATE COMMENT 'Date when this resource estimate was prepared. Represents the principal business event timestamp for this evaluation record.',
    `estimate_status` STRING COMMENT 'Current lifecycle status of this resource estimate version. Active is current, superseded indicates newer version exists, archived for historical record, withdrawn if invalidated.. Valid values are `active|superseded|archived|withdrawn`',
    `estimate_version` STRING COMMENT 'Version number of this resource estimate. Multiple versions per prospect track evaluation evolution over time as new data becomes available.',
    `eur_1p_boe` DECIMAL(18,2) COMMENT 'Proved reserves (1P) estimated ultimate recovery in barrels of oil equivalent. Represents recoverable volumes with reasonable certainty per SEC and SPE-PRMS standards.',
    `eur_2p_boe` DECIMAL(18,2) COMMENT 'Proved plus probable reserves (2P) estimated ultimate recovery in barrels of oil equivalent. Represents best estimate of recoverable volumes per SPE-PRMS standards.',
    `eur_3p_boe` DECIMAL(18,2) COMMENT 'Proved plus probable plus possible reserves (3P) estimated ultimate recovery in barrels of oil equivalent. Represents high-side estimate of recoverable volumes per SPE-PRMS standards.',
    `evaluation_methodology` STRING COMMENT 'Technical methodology used to derive the resource estimate. Volumetric uses reservoir volume calculations, analog uses comparable field data, simulation uses reservoir modeling software.. Valid values are `volumetric|analog|simulation|probabilistic|deterministic`',
    `evaluator_name` STRING COMMENT 'Name of the geoscientist or engineer who prepared this resource estimate. Supports audit trail and technical accountability.',
    `expected_monetary_value_usd` DECIMAL(18,2) COMMENT 'Risk-weighted net present value of the prospect calculated as NPV multiplied by geological chance of success. Key metric for portfolio optimization and investment decisions.',
    `geological_chance_of_success_pct` DECIMAL(18,2) COMMENT 'Composite probability that all geological risk factors are favorable and prospect contains commercial hydrocarbons. Calculated using risk methodology (multiplicative or additive).',
    `giip_high_case_bcf` DECIMAL(18,2) COMMENT 'High case (P10) estimate of original gas in place in billion cubic feet. Represents optimistic scenario for gas prospects.',
    `giip_low_case_bcf` DECIMAL(18,2) COMMENT 'Low case (P90) estimate of original gas in place in billion cubic feet. Represents conservative scenario for gas prospects.',
    `giip_mid_case_bcf` DECIMAL(18,2) COMMENT 'Mid case (P50) estimate of original gas in place in billion cubic feet. Represents best estimate scenario for gas prospects.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this resource estimate record was last modified. Supports audit trail and change tracking.',
    `peer_review_date` DATE COMMENT 'Date when peer review was completed. Tracks evaluation lifecycle and supports audit requirements.',
    `peer_review_status` STRING COMMENT 'Current status of technical peer review process for this resource estimate. Ensures quality control and technical governance before investment decisions.. Valid values are `draft|submitted|reviewed|approved|rejected`',
    `peer_reviewer_name` STRING COMMENT 'Name of senior geoscientist or engineer who conducted peer review of this resource estimate. Supports technical accountability and audit trail.',
    `prms_resource_category` STRING COMMENT 'SPE-PRMS 2018 classification of resource maturity. Prospective resources are undiscovered, contingent resources are discovered but not yet commercial, reserves are discovered and commercial.. Valid values are `prospective|contingent|reserves`',
    `prms_resource_subclass` STRING COMMENT 'Detailed SPE-PRMS sub-classification. For prospective: play, lead, prospect. For reserves: PDP (proved developed producing), PDNP (proved developed non-producing), PUD (proved undeveloped).. Valid values are `play|lead|prospect|pdp|pdnp|pud`',
    `recovery_factor_high_pct` DECIMAL(18,2) COMMENT 'High case recovery factor as percentage of OOIP or OGIP that can be economically produced. Optimistic estimate of reservoir producibility.',
    `recovery_factor_low_pct` DECIMAL(18,2) COMMENT 'Low case recovery factor as percentage of OOIP or OGIP that can be economically produced. Conservative estimate of reservoir producibility.',
    `recovery_factor_mid_pct` DECIMAL(18,2) COMMENT 'Mid case recovery factor as percentage of OOIP or OGIP that can be economically produced. Best estimate of reservoir producibility.',
    `reservoir_presence_risk_pct` DECIMAL(18,2) COMMENT 'Probability that reservoir-quality rock is present at the prospect location. Individual geological risk factor component for chance of success calculation.',
    `reservoir_quality_risk_pct` DECIMAL(18,2) COMMENT 'Probability that reservoir rock has sufficient porosity and permeability for commercial production. Individual geological risk factor component.',
    `risk_methodology` STRING COMMENT 'Method used to combine individual geological risk factors into composite chance of success. Multiplicative multiplies all factors, additive uses weighted sum, hybrid combines both approaches.. Valid values are `multiplicative|additive|hybrid`',
    `risk_weighted_npv_usd` DECIMAL(18,2) COMMENT 'Discounted cash flow value adjusted for geological and commercial risks. Used for economic ranking and capital allocation decisions.',
    `risked_resource_high_boe` DECIMAL(18,2) COMMENT 'High case recoverable resource volume adjusted by geological chance of success. Calculated as EUR high case multiplied by composite geological risk factor.',
    `risked_resource_low_boe` DECIMAL(18,2) COMMENT 'Low case recoverable resource volume adjusted by geological chance of success. Calculated as EUR low case multiplied by composite geological risk factor.',
    `risked_resource_mid_boe` DECIMAL(18,2) COMMENT 'Mid case recoverable resource volume adjusted by geological chance of success. Calculated as EUR mid case multiplied by composite geological risk factor.',
    `seal_effectiveness_risk_pct` DECIMAL(18,2) COMMENT 'Probability that cap rock or seal is present and effective to prevent hydrocarbon migration. Individual geological risk factor component.',
    `stoiip_high_case_bbl` DECIMAL(18,2) COMMENT 'High case (P10) estimate of original oil in place in stock tank barrels. Represents optimistic scenario with 10% probability of exceeding this volume.',
    `stoiip_low_case_bbl` DECIMAL(18,2) COMMENT 'Low case (P90) estimate of original oil in place in stock tank barrels. Represents conservative scenario with 90% probability of exceeding this volume.',
    `stoiip_mid_case_bbl` DECIMAL(18,2) COMMENT 'Mid case (P50) estimate of original oil in place in stock tank barrels. Represents best estimate scenario with 50% probability of exceeding this volume.',
    `timing_migration_risk_pct` DECIMAL(18,2) COMMENT 'Probability that hydrocarbon generation, migration, and trap formation occurred in correct sequence. Individual geological risk factor component.',
    `trap_integrity_risk_pct` DECIMAL(18,2) COMMENT 'Probability that structural or stratigraphic trap is present and intact to contain hydrocarbons. Individual geological risk factor component.',
    CONSTRAINT pk_prospect_resource_estimate PRIMARY KEY(`prospect_resource_estimate_id`)
) COMMENT 'Transactional record capturing versioned prospect evaluations combining resource estimates and geological risk assessments. Stores estimate date, evaluator, methodology (volumetric, analog, simulation), low/mid/high case STOIIP/GIIP, recovery factor, EUR (1P/2P/3P), risked resource volumes, individual geological risk factor scores (reservoir presence/quality, trap integrity, seal effectiveness, charge adequacy, timing/migration), composite geological chance of success (GCoS), risk methodology (multiplicative/additive), economic risking parameters (EMV, risk-weighted NPV), PRMS resource category (Prospective/Contingent/Reserves with sub-classes), and peer review status. SSOT for all prospect-level risk and resource evaluation. Supports SEC reserves disclosure, SPE-PRMS 2018 compliance, investment decision gates, and portfolio risk management. Multiple versions per prospect track evaluation evolution over time.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`exploration_well` (
    `exploration_well_id` BIGINT COMMENT 'Unique system identifier for the exploration well record. Primary key for the exploration well entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Every exploration well is authorized and tracked under an AFE budget — the AFE governs drilling cost authorization, variance tracking, and JIB billing. A domain expert would immediately expect explora',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which the exploration well is located.',
    `carried_interest_id` BIGINT COMMENT 'Foreign key linking to venture.carried_interest. Business justification: Exploration wells are frequently drilled under carried interest arrangements where one partner funds anothers share. Direct carried_interest linkage on exploration_well enables tracking which carry a',
    `company_code_id` BIGINT COMMENT 'Reference to the company serving as the operator responsible for drilling and managing the exploration well.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Exploration wells are drilled under a drilling services contract governing day rates, NPT penalties, and scope of work. Linking exploration_well to its governing procurement contract enables contract ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration wells are drilled within cost centers; well costs are allocated to cost centers for accounting, budgeting, and JV partner billing. Required for cost allocation and financial reporting in e',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Exploration wells that encounter hydrocarbons during DST produce fluid samples formally classified against the crude grade catalog. This drives commerciality decisions, appraisal well planning, and ea',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Wells record actual hydrocarbon product type encountered for reserve booking by product category and JV partner reporting. Business process: well completion reports specify product type for reserves c',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Exploration wells in joint-operated areas are governed by JOA: non-consent elections, cost-sharing, and JIB billing. The existing venture_afe_id covers AFE authorization but not the governing JOA. Dir',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Exploration wells are drilled on leased acreage; the lease governs drilling rights, HBP status, and permit applications. Land administration tracks which lease each well is on for title opinion, delay',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Exploration wells require the operator to hold a valid operating license (e.g., BSEE operator number, state oil and gas commission license) distinct from the drill permit. Operating license governs op',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Drilling wells requires regulatory permits (APD, drilling permits) from authorities like BLM, BSEE, state agencies. Permit tracking is mandatory for HSE compliance and operational authorization. Links',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Exploration wells are registered as capital projects for CAPEX tracking, milestone management, and investment reporting. Project-level tracking enables well cost benchmarking, portfolio performance re',
    `prospect_id` BIGINT COMMENT 'Reference to the geological prospect that this exploration well is designed to test and evaluate.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Exploration well costs in PSA areas are cost-recoverable. Direct PSA linkage on exploration_well enables well-level cost-recovery classification, government audit support, and minimum work obligation ',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig used or planned for drilling this exploration well.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Exploration wells are drilled from surface locations registered as asset facilities (drill pads, offshore platforms). Well planning, AFE preparation, and HSE reporting require linking the well to its ',
    `surface_use_agreement_id` BIGINT COMMENT 'Foreign key linking to land.surface_use_agreement. Business justification: A surface use agreement with the surface owner must be executed before drilling an exploration well. Drilling permit applications and HSE compliance require referencing the governing SUA. Land profess',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: An exploration well targets a specific stratigraphic formation as its primary drilling objective. The existing target_formation (STRING) is a denormalized free-text reference that should be replaced b',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Exploration well costs are tracked under WBS elements for project cost control and AFE variance reporting. WBS-level tracking enables phase-by-phase cost monitoring (drilling, completion, testing) and',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Exploration wells transition to producing assets; business requires linkage for reserves booking, production allocation, asset integrity tracking, regulatory compliance, and lifecycle cost analysis. C',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred to drill and evaluate the exploration well, including all drilling, completion, and testing expenses.',
    `actual_md_depth` DECIMAL(18,2) COMMENT 'Actual total measured depth achieved by the well in feet or meters, measured along the wellbore trajectory.',
    `actual_tvd_depth` DECIMAL(18,2) COMMENT 'Actual true vertical depth achieved by the well in feet or meters, representing vertical distance from surface to bottom hole.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of oil samples recovered, measuring oil density and quality on the API scale.',
    `api_number` STRING COMMENT 'Unique 14-digit API well identifier assigned by regulatory authorities for well tracking and reporting. Format: state code (2) - county code (3) - unique well number (5) - optional sidetrack (2).. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `bottom_hole_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the well bottom hole location in decimal degrees (WGS84 datum). May differ from surface location for directional wells.',
    `bottom_hole_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the well bottom hole location in decimal degrees (WGS84 datum). May differ from surface location for directional wells.',
    `co2_content_percent` DECIMAL(18,2) COMMENT 'Percentage of carbon dioxide in produced gas, important for processing and corrosion management.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the exploration well is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exploration well record was first created in the system.',
    `depth_uom` STRING COMMENT 'Unit of measure used for all depth measurements in this well record (feet or meters).. Valid values are `feet|meters`',
    `drilling_days` STRING COMMENT 'Total number of days from spud to total depth, including productive time and non-productive time.',
    `dst_flow_rate` DECIMAL(18,2) COMMENT 'Measured flow rate during DST in barrels of oil per day (BOPD) for oil wells or thousand cubic feet per day (MCFD) for gas wells.',
    `dst_fluid_type` STRING COMMENT 'Primary type of fluid recovered during the drill stem test.. Valid values are `oil|gas|water|condensate|mixed`',
    `dst_interval_bottom` DECIMAL(18,2) COMMENT 'Bottom depth of the primary DST interval in feet or meters measured depth.',
    `dst_interval_top` DECIMAL(18,2) COMMENT 'Top depth of the primary DST interval in feet or meters measured depth.',
    `dst_performed_flag` BOOLEAN COMMENT 'Indicates whether a drill stem test was performed on this exploration well to evaluate reservoir productivity.',
    `dst_shut_in_pressure` DECIMAL(18,2) COMMENT 'Final shut-in pressure measured during DST in pounds per square inch (PSI), indicating reservoir pressure.',
    `environment_type` STRING COMMENT 'Classification of the operating environment for the exploration well.. Valid values are `onshore|offshore_shallow|offshore_deepwater|offshore_ultra_deepwater`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost to drill and complete the exploration well as documented in the Authorization for Expenditure (AFE).',
    `gor` DECIMAL(18,2) COMMENT 'Gas-oil ratio measured during testing, expressed as cubic feet of gas per barrel of oil, indicating reservoir fluid characteristics.',
    `gross_pay_thickness` DECIMAL(18,2) COMMENT 'Total gross thickness of the reservoir interval in feet or meters, including both productive and non-productive zones within the pay section.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Concentration of hydrogen sulfide in produced fluids measured in parts per million, critical for safety and processing requirements.',
    `hydrocarbon_type` STRING COMMENT 'Primary type of hydrocarbon encountered in the exploration well, if any.. Valid values are `oil|gas|condensate|mixed|none`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this exploration well record was last modified in the system.',
    `net_pay_thickness` DECIMAL(18,2) COMMENT 'Total net thickness of productive or potentially productive reservoir intervals in feet or meters, excluding non-reservoir rock.',
    `npt_days` DECIMAL(18,2) COMMENT 'Total non-productive time in days during drilling operations due to equipment failures, weather delays, or other unplanned events.',
    `objective` STRING COMMENT 'Detailed description of the technical and business objectives for drilling this exploration well, including geological targets, data acquisition goals, and success criteria.',
    `pay_zone_summary` STRING COMMENT 'Textual summary of productive or potentially productive zones encountered, including formation names, depths, and characteristics.',
    `permit_expiry_date` DATE COMMENT 'Date on which the drilling permit expires and drilling operations must be completed or permit renewed.',
    `permit_issue_date` DATE COMMENT 'Date on which the drilling permit was officially issued by the regulatory authority.',
    `planned_td_depth` DECIMAL(18,2) COMMENT 'Planned total measured depth of the well in feet or meters as specified in the well design and AFE.',
    `planned_tvd_depth` DECIMAL(18,2) COMMENT 'Planned true vertical depth of the well in feet or meters, representing the vertical distance from surface to target.',
    `recommendation` STRING COMMENT 'Technical and commercial recommendation following well evaluation: complete as producer, plug and abandon, suspend for future evaluation, drill appraisal well, etc.',
    `spud_date` DATE COMMENT 'Date on which drilling operations officially commenced (bit penetrated ground or seafloor).',
    `state_province` STRING COMMENT 'State, province, or administrative region where the exploration well is located.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the well surface location in decimal degrees (WGS84 datum).',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the well surface location in decimal degrees (WGS84 datum).',
    `td_date` DATE COMMENT 'Date on which the well reached its total measured depth and drilling operations concluded.',
    `trajectory_type` STRING COMMENT 'Classification of the planned or actual wellbore trajectory design.. Valid values are `vertical|directional|horizontal|multilateral|extended_reach`',
    `water_depth` DECIMAL(18,2) COMMENT 'Water depth at the well location in feet or meters for offshore wells. Null for onshore wells.',
    `well_name` STRING COMMENT 'Official name assigned to the exploration well, typically following operator naming conventions and regulatory requirements.',
    `well_result` STRING COMMENT 'Final outcome classification of the exploration well: discovery (commercial hydrocarbons found), dry hole (no hydrocarbons), shows (non-commercial indications), technical success (objectives met but non-commercial), or suspended (evaluation incomplete).. Valid values are `discovery|dry_hole|shows|technical_success|suspended`',
    `well_status` STRING COMMENT 'Current operational status of the exploration well in its lifecycle from planning through post-drill disposition. [ENUM-REF-CANDIDATE: planned|permitted|drilling|suspended|completed|abandoned|producing|shut_in — 8 candidates stripped; promote to reference product]',
    `well_type` STRING COMMENT 'Classification of the exploration well based on its purpose: wildcat (new prospect), appraisal (discovery evaluation), delineation (reservoir extent), stratigraphic (geological data), or exploratory (general exploration).. Valid values are `wildcat|appraisal|delineation|stratigraphic|exploratory`',
    CONSTRAINT pk_exploration_well PRIMARY KEY(`exploration_well_id`)
) COMMENT 'Master record for exploration and appraisal wells across their full lifecycle — from planning through drilling to post-drill evaluation. Captures well identity (name, API number), well type (wildcat/appraisal/delineation/stratigraphic), planning attributes (target prospect, planned TD, target formation, well objectives, trajectory type, estimated cost/AFE, rig type, permit status), drilling attributes (spud date, TD date, MD, TVD, surface location), well result (discovery/dry hole/shows/technical success, pay zone summary, net pay, hydrocarbon type, recommendation), DST results (test interval, flow rate, shut-in pressure, fluid type, GOR, API gravity, H2S/CO2), and current status. SSOT for exploration well identity in the exploration domain. Integrates with Schlumberger Petrel well planning and drilling domain for completion data handoff.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`core_sample` (
    `core_sample_id` BIGINT COMMENT 'Unique identifier for the rock core sample record. Primary key for the core sample entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Core analysis programs (laboratory analysis, preservation, storage) are authorized under well AFE budgets as a distinct cost line. Linking core_sample to afe_budget enables coring cost tracking agains',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Coring contractors are specialized drilling service vendors - enables vendor performance tracking, cost analysis, and contract management for coring operations. Role prefix distinguishes from other dr',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Core sample fluid analysis (DST/PVT) classifies the reservoir fluid as a specific crude grade — a fundamental exploration reservoir characterization process. Geologists and reservoir engineers use thi',
    `exploration_well_id` BIGINT COMMENT 'Foreign key reference to the exploration or appraisal well from which this core sample was acquired.',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Core samples are collected from wells drilled on leased acreage. Chain of custody, ownership rights, and regulatory reporting requirements tie samples to the underlying lease. Essential for data manag',
    `analysis_date` DATE COMMENT 'Date when the core analysis was completed by the laboratory.',
    `analysis_laboratory` STRING COMMENT 'Name of the laboratory or service company that performed the core analysis.',
    `bottom_depth_md` DECIMAL(18,2) COMMENT 'Measured depth in feet or meters to the bottom of the core sample interval along the wellbore trajectory.',
    `bottom_depth_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet or meters to the bottom of the core sample interval, corrected for wellbore deviation.',
    `bulk_density` DECIMAL(18,2) COMMENT 'Total density of the core sample including both rock matrix and pore fluids, in grams per cubic centimeter.',
    `core_analysis_type` STRING COMMENT 'Type of laboratory analysis performed on the core sample. Routine analysis includes basic porosity and permeability; Special Core Analysis (SCAL) includes advanced tests like relative permeability and capillary pressure.. Valid values are `routine|special_core_analysis|scal|thin_section|xrd|sem`',
    `core_barrel_type` STRING COMMENT 'Type of core barrel used for the coring operation (e.g., conventional, wireline, rotary sidewall), affecting core quality and recovery.',
    `core_diameter` DECIMAL(18,2) COMMENT 'Diameter of the core sample in inches or centimeters, determined by the core barrel size used.',
    `core_length_cut` DECIMAL(18,2) COMMENT 'Total length of core attempted to be cut during the coring operation, in feet or meters.',
    `core_length_recovered` DECIMAL(18,2) COMMENT 'Actual length of intact core recovered to surface, in feet or meters. Used to calculate core recovery percentage.',
    `core_recovery_percentage` DECIMAL(18,2) COMMENT 'Percentage of core recovered relative to the length cut, calculated as (core_length_recovered / core_length_cut) * 100. Key quality indicator for core data reliability.',
    `core_run_number` STRING COMMENT 'Sequential number identifying the coring operation run within the wellbore. Multiple core runs may occur at different depth intervals.',
    `coring_date` DATE COMMENT 'Date when the core sample was physically cut and retrieved from the wellbore during drilling operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this core sample record was first created in the system.',
    `depth_unit` STRING COMMENT 'Unit of measure for all depth measurements in this core sample record.. Valid values are `feet|meters`',
    `fluid_saturation_gas` DECIMAL(18,2) COMMENT 'Percentage of pore space occupied by gas at the time of coring, measured through core analysis.',
    `fluid_saturation_oil` DECIMAL(18,2) COMMENT 'Percentage of pore space occupied by oil at the time of coring, measured through core analysis.',
    `fluid_saturation_water` DECIMAL(18,2) COMMENT 'Percentage of pore space occupied by water at the time of coring. Key input for Original Oil in Place (OOIP) calculations.',
    `grain_density` DECIMAL(18,2) COMMENT 'Density of the solid rock matrix in grams per cubic centimeter, excluding pore space. Used in porosity calculations.',
    `lithology_description` STRING COMMENT 'Detailed textual description of the rock characteristics including color, grain size, texture, sedimentary structures, and mineralogy observed by the geologist.',
    `lithology_primary` STRING COMMENT 'Dominant rock type observed in the core sample based on visual and microscopic examination. [ENUM-REF-CANDIDATE: sandstone|shale|limestone|dolomite|siltstone|conglomerate|coal|salt|anhydrite|chalk|marl|mudstone — 12 candidates stripped; promote to reference product]',
    `lithology_secondary` STRING COMMENT 'Secondary or interbedded rock type present in the core sample, if applicable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this core sample record was last modified or updated in the system.',
    `permeability_horizontal` DECIMAL(18,2) COMMENT 'Permeability measured parallel to bedding planes, in millidarcies. Important for understanding lateral fluid flow in the reservoir.',
    `permeability_md` DECIMAL(18,2) COMMENT 'Measured permeability of the core sample in millidarcies, indicating the rocks ability to transmit fluids. Critical parameter for reservoir flow modeling.',
    `permeability_vertical` DECIMAL(18,2) COMMENT 'Permeability measured perpendicular to bedding planes, in millidarcies. Critical for understanding vertical communication between reservoir layers.',
    `porosity_percentage` DECIMAL(18,2) COMMENT 'Measured porosity of the core sample expressed as a percentage of total rock volume, representing the void space available for fluid storage.',
    `preservation_method` STRING COMMENT 'Method used to preserve the core sample to maintain its original properties and prevent degradation.. Valid values are `frozen|refrigerated|ambient|sealed|waxed`',
    `remarks` STRING COMMENT 'Additional notes, observations, or special conditions related to the core sample, coring operation, or analysis results.',
    `sample_condition` STRING COMMENT 'Current physical condition of the core sample, assessing integrity and suitability for further analysis or re-examination.. Valid values are `excellent|good|fair|poor|damaged|depleted`',
    `sample_number` STRING COMMENT 'Unique alphanumeric identifier assigned to this specific core sample for laboratory tracking and reference.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `sample_status` STRING COMMENT 'Current lifecycle status of the core sample indicating availability for analysis or disposition.. Valid values are `available|in_analysis|depleted|archived|destroyed`',
    `storage_location` STRING COMMENT 'Physical location where the core sample is stored, including facility name, warehouse, and bin/shelf identifier for retrieval.',
    `top_depth_md` DECIMAL(18,2) COMMENT 'Measured depth in feet or meters to the top of the core sample interval along the wellbore trajectory.',
    `top_depth_tvd` DECIMAL(18,2) COMMENT 'True vertical depth in feet or meters to the top of the core sample interval, corrected for wellbore deviation.',
    CONSTRAINT pk_core_sample PRIMARY KEY(`core_sample_id`)
) COMMENT 'Master record for rock core samples acquired from exploration and appraisal wells. Captures core run number, depth interval (MD/TVD), formation, core length recovered, core recovery percentage, lithology description, porosity measurement, permeability measurement, fluid saturation, core analysis type (routine/special SCAL), storage location, and sample condition. Supports reservoir characterization and G&G interpretation workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`discovery` (
    `discovery_id` BIGINT COMMENT 'Primary key for discovery',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin containing the discovery.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Oil discoveries are characterized by crude grade (API, sulfur) for commerciality assessment and regulatory notification. Business process: discovery declarations to government specify crude grade for ',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: When a discovery moves to appraisal/development, it is associated with a production facility for development planning, reserves booking (PRMS), and FID decisions. O&G portfolio managers require this l',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: A discovery triggers JOA obligations: appraisal work program approval, commerciality declaration, and development planning AFEs. Direct JOA linkage on discovery enables partner notification workflows,',
    `joint_venture_id` BIGINT COMMENT 'Foreign key linking to venture.joint_venture. Business justification: SEC reserve disclosures and JV equity reporting require discovery-level JV attribution. Partners report discovered resources at JV level; direct linkage enables JV-level discovery portfolio reporting ',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: A discovery is made on leased acreage; the lease governs production rights, HBP status, royalty obligations, and commerciality assessment. Land and exploration teams jointly track which lease covers a',
    `block_id` BIGINT COMMENT 'Reference to the exploration license or block within which the discovery was made.',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: A discovery must be tied to an operating license to proceed to appraisal and development. PRMS commerciality assessment and reserves booking require confirmation of a valid operating license. Every oi',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Discoveries must classify hydrocarbon product type (oil, gas, condensate, NGL) for reserve booking, regulatory reporting, and commerciality decisions. Real process: discovery evaluation reports specif',
    `play_id` BIGINT COMMENT 'Reference to the geological play within which the discovery was made.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Discovery events must link to producing well assets for reserves booking, commerciality declarations, regulatory notifications, and field development planning. Role prefix producing distinguishes fr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Discoveries that achieve commerciality become profit centers for P&L tracking; each discovery is tracked as a profit center for revenue, cost, and profitability reporting. Essential for asset-level fi',
    `prospect_id` BIGINT COMMENT 'Reference to the prospect that was being tested when the discovery was made.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Discoveries in PSA areas trigger specific PSA obligations: commerciality declaration deadlines, development plan submission to host government, and profit-oil regime activation. Direct PSA linkage is ',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Discoveries are made in specific reservoir formations. Currently discovery has reservoir_formation (STRING) and reservoir_age (STRING); these should be replaced with a FK to the formation master to en',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Discovery appraisal programs (appraisal wells, studies) are tracked under WBS elements for cost control and CAPEX reporting. WBS-level tracking enables appraisal cost accumulation per discovery for ca',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the discovered oil, indicating the density and quality of the crude oil. Higher values indicate lighter, more valuable crude.',
    `commerciality_status` STRING COMMENT 'Assessment of whether the discovery is commercially viable for development based on technical and economic evaluation.. Valid values are `commercial|sub_commercial|under_evaluation|not_commercial`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the discovery is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the discovery record was first created in the system.',
    `depth_md_ft` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore to the top of the discovered reservoir interval, measured in feet.',
    `depth_tvd_ft` DECIMAL(18,2) COMMENT 'True vertical depth from surface to the top of the discovered reservoir interval, measured in feet.',
    `discovery_code` STRING COMMENT 'Unique alphanumeric code assigned to the discovery for internal tracking and regulatory reporting purposes.',
    `discovery_date` DATE COMMENT 'Official date when the hydrocarbon discovery was formally declared, typically following successful well test results.',
    `discovery_name` STRING COMMENT 'Official name assigned to the hydrocarbon discovery, typically reflecting geographic location or geological feature.',
    `discovery_status` STRING COMMENT 'Current lifecycle status of the discovery from initial declaration through appraisal to commercial determination.. Valid values are `declared|under_appraisal|commercial|non_commercial|suspended|relinquished`',
    `eur_p10_mmboe` DECIMAL(18,2) COMMENT 'High estimate (P10) of the total recoverable hydrocarbon volume from the discovery, representing optimistic scenario.',
    `eur_p50_mmboe` DECIMAL(18,2) COMMENT 'Best estimate (P50) of the total recoverable hydrocarbon volume from the discovery over its productive life, expressed in million barrels of oil equivalent.',
    `eur_p90_mmboe` DECIMAL(18,2) COMMENT 'Low estimate (P90) of the total recoverable hydrocarbon volume from the discovery, representing conservative scenario.',
    `fluid_type_detail` STRING COMMENT 'Detailed description of the discovered fluid characteristics including API gravity for oil or gas composition for gas discoveries.',
    `giip_bcf` DECIMAL(18,2) COMMENT 'Estimated volume of gas initially in place in the reservoir at discovery, expressed in billion cubic feet, before any production.',
    `gor_scf_stb` DECIMAL(18,2) COMMENT 'Gas-oil ratio measured during the discovery well test, expressed as standard cubic feet of gas per stock tank barrel of oil.',
    `hydrocarbon_saturation_percent` DECIMAL(18,2) COMMENT 'Percentage of pore space filled with hydrocarbons in the discovered reservoir.',
    `hydrocarbon_type` STRING COMMENT 'Primary type of hydrocarbon discovered (oil, natural gas, condensate, or associated gas).. Valid values are `oil|gas|condensate|associated_gas|wet_gas|dry_gas`',
    `initial_production_rate_bopd` DECIMAL(18,2) COMMENT 'Initial production rate of oil measured during the discovery well test, expressed in barrels of oil per day.',
    `initial_production_rate_mcfd` DECIMAL(18,2) COMMENT 'Initial production rate of gas measured during the discovery well test, expressed in thousand cubic feet per day.',
    `initial_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'Initial reservoir pressure measured during the discovery well test, expressed in pounds per square inch.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the discovery record was last modified in the system.',
    `net_pay_thickness_ft` DECIMAL(18,2) COMMENT 'Thickness of the productive reservoir interval with sufficient porosity and hydrocarbon saturation, measured in feet.',
    `permeability_md` DECIMAL(18,2) COMMENT 'Average permeability of the discovered reservoir, measured in millidarcies, indicating the ability of fluids to flow through the rock.',
    `porosity_percent` DECIMAL(18,2) COMMENT 'Average porosity of the discovered reservoir, expressed as a percentage of total rock volume.',
    `prms_maturity_subclass` STRING COMMENT 'PRMS maturity subclass indicating the level of technical and commercial maturity (e.g., development pending, development on hold, development not viable).',
    `prms_resource_class` STRING COMMENT 'PRMS classification of the discovered resources: 1P (proved), 2P (proved plus probable), 3P (proved plus probable plus possible), contingent, or prospective.. Valid values are `1P|2P|3P|contingent|prospective`',
    `recovery_factor_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of in-place hydrocarbons that can be recovered from the discovery using primary and secondary recovery methods.',
    `reservoir_temperature_f` DECIMAL(18,2) COMMENT 'Reservoir temperature measured at discovery depth, expressed in degrees Fahrenheit.',
    `stoiip_mmbbl` DECIMAL(18,2) COMMENT 'Estimated volume of oil initially in place in the reservoir at discovery, expressed in million barrels, before any production.',
    `water_depth_ft` DECIMAL(18,2) COMMENT 'Water depth at the discovery location for offshore discoveries, measured in feet. Null for onshore discoveries.',
    CONSTRAINT pk_discovery PRIMARY KEY(`discovery_id`)
) COMMENT 'Transactional record capturing the formal declaration of a hydrocarbon discovery following a successful exploration well result. Captures discovery name, discovery date, discovery well reference, discovered fluid type (oil/gas/condensate), initial flow rate (IP), initial reservoir pressure, discovery depth, estimated in-place volumes (STOIIP/GIIP), PRMS resource classification at discovery, and regulatory notification date. SSOT for discovery events that trigger appraisal planning and reserves booking workflows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ADD CONSTRAINT `fk_exploration_play_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ADD CONSTRAINT `fk_exploration_play_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `oil_gas_ecm`.`exploration`.`lead`(`lead_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ADD CONSTRAINT `fk_exploration_prospect_resource_estimate_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ADD CONSTRAINT `fk_exploration_prospect_resource_estimate_superseded_by_estimate_prospect_resource_estimate_id` FOREIGN KEY (`superseded_by_estimate_prospect_resource_estimate_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect_resource_estimate`(`prospect_resource_estimate_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`exploration` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`exploration` SET TAGS ('dbx_domain' = 'exploration');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Basin Area (Square Kilometers)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Basin Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_name` SET TAGS ('dbx_business_glossary_term' = 'Basin Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_status` SET TAGS ('dbx_business_glossary_term' = 'Basin Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_status` SET TAGS ('dbx_value_regex' = 'active_exploration|producing|mature|frontier|relinquished|suspended');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_type` SET TAGS ('dbx_business_glossary_term' = 'Basin Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `discovery_count` SET TAGS ('dbx_business_glossary_term' = 'Discovery Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `eur_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `eur_mmboe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `exploration_maturity` SET TAGS ('dbx_business_glossary_term' = 'Exploration Maturity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `exploration_maturity` SET TAGS ('dbx_value_regex' = 'frontier|emerging|established|mature|declining');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Regime Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_value_regex' = 'concession|production_sharing|service_contract|royalty_tax|hybrid');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `geological_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Geological Risk Score');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `hydrocarbon_system_maturity` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon System Maturity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `hydrocarbon_system_maturity` SET TAGS ('dbx_value_regex' = 'immature|early_mature|peak_mature|late_mature|post_mature');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `infrastructure_maturity` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Maturity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `infrastructure_maturity` SET TAGS ('dbx_value_regex' = 'none|limited|developing|established|mature');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `lead_count` SET TAGS ('dbx_business_glossary_term' = 'Lead Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `ogip_bcf` SET TAGS ('dbx_business_glossary_term' = 'Original Gas In Place (OGIP) Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `ogip_bcf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `onshore_offshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Onshore Offshore Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `onshore_offshore_flag` SET TAGS ('dbx_value_regex' = 'onshore|offshore|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `ooip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Original Oil In Place (OOIP) Million Barrels (MMBBL)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `ooip_mmbbl` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `play_count` SET TAGS ('dbx_business_glossary_term' = 'Play Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `primary_reservoir_rock` SET TAGS ('dbx_business_glossary_term' = 'Primary Reservoir Rock');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `primary_source_rock` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Rock');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `prms_classification_tier` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Classification Tier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `prms_classification_tier` SET TAGS ('dbx_value_regex' = '1P|2P|3P|prospective|contingent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `prospect_count` SET TAGS ('dbx_business_glossary_term' = 'Prospect Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `prospective_area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Prospective Area (Square Kilometers)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `recovery_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor (Percent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `seismic_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Seismic Coverage (Percent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `tectonic_setting` SET TAGS ('dbx_business_glossary_term' = 'Tectonic Setting');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `trap_style` SET TAGS ('dbx_business_glossary_term' = 'Trap Style');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `water_depth_max_ft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Water Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `water_depth_min_ft` SET TAGS ('dbx_business_glossary_term' = 'Minimum Water Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `well_count` SET TAGS ('dbx_business_glossary_term' = 'Well Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `analogue_play_reference` SET TAGS ('dbx_business_glossary_term' = 'Analogue Play Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Play Area Square Miles');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `average_net_pay_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Average Net Pay Thickness Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `average_net_pay_thickness_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `average_net_pay_thickness_ft` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `average_permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Average Permeability Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `average_porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Porosity Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `charge_risk` SET TAGS ('dbx_business_glossary_term' = 'Charge Risk');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `charge_risk` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `depth_range_base_ft` SET TAGS ('dbx_business_glossary_term' = 'Depth Range Base Feet (ft) True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `depth_range_top_ft` SET TAGS ('dbx_business_glossary_term' = 'Depth Range Top Feet (ft) True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `discovery_count` SET TAGS ('dbx_business_glossary_term' = 'Discovery Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `dry_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Dry Hole Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `exploration_success_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Exploration Success Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `geological_chance_of_success_percent` SET TAGS ('dbx_business_glossary_term' = 'Geological Chance of Success Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `geological_chance_of_success_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `migration_pathway` SET TAGS ('dbx_business_glossary_term' = 'Migration Pathway');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_code` SET TAGS ('dbx_business_glossary_term' = 'Play Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_name` SET TAGS ('dbx_business_glossary_term' = 'Play Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_status` SET TAGS ('dbx_business_glossary_term' = 'Play Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_status` SET TAGS ('dbx_value_regex' = 'active|mature|emerging|dormant|abandoned');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `play_type` SET TAGS ('dbx_value_regex' = 'conventional|unconventional|tight_gas|shale_oil|shale_gas|coalbed_methane');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `prms_maturity_subclass` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Maturity Subclass');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `prms_maturity_subclass` SET TAGS ('dbx_value_regex' = 'lead|prospect|1P|2P|3P');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Class');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_value_regex' = 'prospective|contingent|reserves');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `reservoir_lithology` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Lithology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `reservoir_lithology` SET TAGS ('dbx_value_regex' = 'sandstone|carbonate|shale|siltstone|conglomerate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `reservoir_quality` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Quality');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `reservoir_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `risked_resource_estimate_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Risked Resource Estimate Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `risked_resource_estimate_mmboe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `seal_integrity` SET TAGS ('dbx_business_glossary_term' = 'Seal Integrity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `seal_integrity` SET TAGS ('dbx_value_regex' = 'proven|probable|possible|uncertain');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `seal_type` SET TAGS ('dbx_business_glossary_term' = 'Seal Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `seal_type` SET TAGS ('dbx_value_regex' = 'shale|evaporite|tight_carbonate|unconformity|fault');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `seismic_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Seismic Coverage Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `source_rock_formation` SET TAGS ('dbx_business_glossary_term' = 'Source Rock Formation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `source_rock_maturity` SET TAGS ('dbx_business_glossary_term' = 'Source Rock Maturity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `source_rock_maturity` SET TAGS ('dbx_value_regex' = 'immature|early_mature|peak_oil|late_oil|gas|overmature');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `technical_maturity_level` SET TAGS ('dbx_business_glossary_term' = 'Technical Maturity Level');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `technical_maturity_level` SET TAGS ('dbx_value_regex' = 'conceptual|emerging|established|mature');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `trap_configuration` SET TAGS ('dbx_business_glossary_term' = 'Trap Configuration');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `trap_style` SET TAGS ('dbx_business_glossary_term' = 'Trap Style');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `trap_style` SET TAGS ('dbx_value_regex' = 'structural|stratigraphic|combination|unconventional');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `unrisked_resource_estimate_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Unrisked Resource Estimate Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `unrisked_resource_estimate_mmboe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `well_control_density` SET TAGS ('dbx_business_glossary_term' = 'Well Control Density');
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ALTER COLUMN `well_control_density` SET TAGS ('dbx_value_regex' = 'none|sparse|moderate|dense');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `estimated_drill_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Drill Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `estimated_drill_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `eur_p10_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P10 Million Barrels of Oil Equivalent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `eur_p50_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P50 Million Barrels of Oil Equivalent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `eur_p90_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P90 Million Barrels of Oil Equivalent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Formation Volume Factor (FVF)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `geological_chance_of_success_pct` SET TAGS ('dbx_business_glossary_term' = 'Geological Chance of Success (GCoS) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `geophysicist_name` SET TAGS ('dbx_business_glossary_term' = 'Geophysicist Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `giip_unrisked_bcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Initially in Place (GIIP) Unrisked Billion Cubic Feet');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `gross_rock_volume_mmcf` SET TAGS ('dbx_business_glossary_term' = 'Gross Rock Volume (GRV) Million Cubic Feet');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `hydrocarbon_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Saturation Fraction');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `maturity_level` SET TAGS ('dbx_business_glossary_term' = 'Prospect Maturity Level');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `maturity_level` SET TAGS ('dbx_value_regex' = 'lead|prospect|drillable_prospect');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `net_to_gross_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net-to-Gross (NTG) Ratio');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `porosity_fraction` SET TAGS ('dbx_business_glossary_term' = 'Porosity Fraction');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_value_regex' = '1P|2P|3P|contingent|prospective|unrecoverable');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_code` SET TAGS ('dbx_business_glossary_term' = 'Prospect Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_value_regex' = 'identified|evaluated|matured|drilled|abandoned');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `reservoir_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `seal_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Seal Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `source_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Source Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `stoiip_unrisked_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially in Place (STOIIP) Unrisked Million Barrels of Oil Equivalent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `structural_closure_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Structural Closure Area (Acres)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `target_depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Target Depth True Vertical Depth (TVD) Feet');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `timing_migration_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Timing and Migration Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `trap_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Trap Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `trap_type` SET TAGS ('dbx_business_glossary_term' = 'Trap Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `trap_type` SET TAGS ('dbx_value_regex' = 'structural|stratigraphic|combination|hydrodynamic');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'License Block Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Target Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `archive_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Archive Reason Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `archive_reason_code` SET TAGS ('dbx_value_regex' = 'below_threshold|high_risk|no_data|strategic_misfit|regulatory_constraint|other');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `archive_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Archive Reason Description');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `charge_risk_probability` SET TAGS ('dbx_business_glossary_term' = 'Charge Risk Probability');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `data_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Data Requirement Description');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `depth_subsea_m` SET TAGS ('dbx_business_glossary_term' = 'Depth Subsea (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `estimated_capex_mm_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (Million United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `estimated_capex_mm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `estimated_opex_mm_usd_per_year` SET TAGS ('dbx_business_glossary_term' = 'Estimated Operating Expenditure (Million United States Dollars per Year)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `estimated_opex_mm_usd_per_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `evaluated_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `geological_chance_of_success` SET TAGS ('dbx_business_glossary_term' = 'Geological Chance of Success (GCoS)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `gross_rock_volume_mm3` SET TAGS ('dbx_business_glossary_term' = 'Gross Rock Volume (Million Cubic Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `hydrocarbon_saturation_fraction` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Saturation Fraction');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_code` SET TAGS ('dbx_business_glossary_term' = 'Lead Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_business_glossary_term' = 'Lead Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|archived|promoted');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_business_glossary_term' = 'Lead Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_type` SET TAGS ('dbx_value_regex' = 'structural|stratigraphic|combination|unconventional');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `maturation_stage` SET TAGS ('dbx_business_glossary_term' = 'Lead Maturation Stage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `maturation_stage` SET TAGS ('dbx_value_regex' = 'identified|screened|evaluated|promoted|archived');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `net_to_gross_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net to Gross Ratio (N/G)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `porosity_fraction` SET TAGS ('dbx_business_glossary_term' = 'Porosity Fraction');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `promoted_date` SET TAGS ('dbx_business_glossary_term' = 'Promoted Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `promotion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Promotion Criteria');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `reservoir_risk_probability` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Risk Probability');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `resource_high_boe` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate High Case (Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `resource_low_boe` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Low Case (Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `resource_mid_boe` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Mid Case (Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `screened_date` SET TAGS ('dbx_business_glossary_term' = 'Screened Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `screening_irr_percent` SET TAGS ('dbx_business_glossary_term' = 'Screening Internal Rate of Return (Percent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `screening_irr_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `screening_npv_mm_usd` SET TAGS ('dbx_business_glossary_term' = 'Screening Net Present Value (Million United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `screening_npv_mm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `seal_risk_probability` SET TAGS ('dbx_business_glossary_term' = 'Seal Risk Probability');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `timing_risk_probability` SET TAGS ('dbx_business_glossary_term' = 'Timing Risk Probability');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `trap_risk_probability` SET TAGS ('dbx_business_glossary_term' = 'Trap Risk Probability');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `water_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Water Depth (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `acquisition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition End Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `acquisition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Start Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `bin_size_m` SET TAGS ('dbx_business_glossary_term' = 'Bin Size (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost (United States Dollars)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'SEG-Y|SEG-D|SEG-2|SEGY_Rev1|SEGY_Rev2|proprietary');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|marginal');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `data_volume_tb` SET TAGS ('dbx_business_glossary_term' = 'Data Volume (Terabytes)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `datum_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Datum Elevation (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `dominant_frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Dominant Frequency (Hertz)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `environmental_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `fold_coverage` SET TAGS ('dbx_business_glossary_term' = 'Fold Coverage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|preliminary|final|peer_reviewed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `licensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Licensing Terms');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `licensing_terms` SET TAGS ('dbx_value_regex' = 'proprietary|multi-client|open_file|licensed|exclusive|non-exclusive');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `licensing_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `migration_type` SET TAGS ('dbx_business_glossary_term' = 'Migration Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `processing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Completion Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `processing_contractor` SET TAGS ('dbx_business_glossary_term' = 'Processing Contractor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `processing_sequence` SET TAGS ('dbx_business_glossary_term' = 'Processing Sequence');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `receiver_spacing_m` SET TAGS ('dbx_business_glossary_term' = 'Receiver Spacing (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `record_length_ms` SET TAGS ('dbx_business_glossary_term' = 'Record Length (Milliseconds)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `sample_interval_ms` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval (Milliseconds)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `shot_point_interval_m` SET TAGS ('dbx_business_glossary_term' = 'Shot Point Interval (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'airgun|vibroseis|dynamite|weight_drop|sparker|boomer');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `survey_area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Survey Area (Square Kilometers)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `survey_name` SET TAGS ('dbx_business_glossary_term' = 'Survey Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = '2D|3D|4D|VSP|multi-component|ocean_bottom');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `total_line_km` SET TAGS ('dbx_business_glossary_term' = 'Total Line Kilometers');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `velocity_model_type` SET TAGS ('dbx_business_glossary_term' = 'Velocity Model Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `velocity_model_type` SET TAGS ('dbx_value_regex' = 'constant|layered|tomography|FWI|anisotropic|isotropic');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `water_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Water Depth (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Formation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `average_permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Average Permeability (Millidarcies)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `average_porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Porosity (Percent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `average_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Average Thickness (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `base_marker` SET TAGS ('dbx_business_glossary_term' = 'Formation Base Marker');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `chronostratigraphic_chart_reference` SET TAGS ('dbx_business_glossary_term' = 'Chronostratigraphic Chart Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `completion_type_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Completion Type Recommendation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `depositional_environment` SET TAGS ('dbx_business_glossary_term' = 'Depositional Environment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `drilling_hazard_notes` SET TAGS ('dbx_business_glossary_term' = 'Drilling Hazard Notes');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `eur_estimate_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `exploration_maturity` SET TAGS ('dbx_business_glossary_term' = 'Exploration Maturity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `exploration_maturity` SET TAGS ('dbx_value_regex' = 'frontier|emerging|mature|depleted');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `formation_code` SET TAGS ('dbx_business_glossary_term' = 'Formation Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `formation_name` SET TAGS ('dbx_business_glossary_term' = 'Formation Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `formation_status` SET TAGS ('dbx_business_glossary_term' = 'Formation Record Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `formation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|deprecated');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed|unknown');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `lithology_type` SET TAGS ('dbx_business_glossary_term' = 'Lithology Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `net_to_gross_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net-to-Gross Ratio (N/G)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_business_glossary_term' = 'PRMS Resource Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_value_regex' = '1P|2P|3P|Contingent|Prospective|Unknown');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `regional_extent` SET TAGS ('dbx_business_glossary_term' = 'Regional Extent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `reservoir_quality_class` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Quality Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `reservoir_quality_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Class IV|Non-Reservoir');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `seal_quality` SET TAGS ('dbx_business_glossary_term' = 'Seal Quality');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `seal_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unknown');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `source_rock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Source Rock Indicator');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `stratigraphic_age_epoch` SET TAGS ('dbx_business_glossary_term' = 'Stratigraphic Age Epoch');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `stratigraphic_age_period` SET TAGS ('dbx_business_glossary_term' = 'Stratigraphic Age Period');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `stratigraphic_age_stage` SET TAGS ('dbx_business_glossary_term' = 'Stratigraphic Age Stage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `thickness_range_max_ft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Thickness Range (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `thickness_range_min_ft` SET TAGS ('dbx_business_glossary_term' = 'Minimum Thickness Range (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `top_marker` SET TAGS ('dbx_business_glossary_term' = 'Formation Top Marker');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` ALTER COLUMN `type_section_reference` SET TAGS ('dbx_business_glossary_term' = 'Type Section Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Block Area (Square Kilometers)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `block_number` SET TAGS ('dbx_business_glossary_term' = 'Block Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `cost_recovery_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `cost_recovery_limit_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `discovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Discovery Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `environmental_sensitivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `first_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'First Discovery Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Regime Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_value_regex' = 'concession|psa|service_contract|risk_service_contract');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `geological_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Geological Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `geological_risk_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `last_seismic_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Seismic Survey Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `minimum_work_program_seismic_km` SET TAGS ('dbx_business_glossary_term' = 'Minimum Work Program Seismic (Kilometers)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `minimum_work_program_well_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Work Program Well Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `net_revenue_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `net_revenue_interest_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `offshore_onshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore/Onshore Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `offshore_onshore_flag` SET TAGS ('dbx_value_regex' = 'offshore|onshore');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `primary_target_formation` SET TAGS ('dbx_business_glossary_term' = 'Primary Target Formation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `prms_classification` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `prms_classification` SET TAGS ('dbx_value_regex' = 'prospective|contingent|proved|probable|possible');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `prospect_count` SET TAGS ('dbx_business_glossary_term' = 'Prospect Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `relinquishment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Schedule');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `resource_potential_boe` SET TAGS ('dbx_business_glossary_term' = 'Resource Potential (Barrel of Oil Equivalent - BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `resource_potential_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `seismic_data_availability` SET TAGS ('dbx_business_glossary_term' = 'Seismic Data Availability');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `seismic_data_availability` SET TAGS ('dbx_value_regex' = 'none|2d_only|3d_available|4d_available');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `water_depth_max_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Water Depth (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `water_depth_min_m` SET TAGS ('dbx_business_glossary_term' = 'Minimum Water Depth (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `well_count` SET TAGS ('dbx_business_glossary_term' = 'Well Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `acreage_gross` SET TAGS ('dbx_business_glossary_term' = 'Acreage Gross');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `acreage_net` SET TAGS ('dbx_business_glossary_term' = 'Acreage Net');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `environmental_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Required Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Submitted|Approved|Rejected');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `estimated_resource_potential_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Resource Potential Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `estimated_resource_potential_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `geological_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Geological Risk Factor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `geological_risk_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `joint_venture_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'Active|Pending|Suspended|Expired|Relinquished|Terminated');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'PSC|Concession|JOA|License|Lease|Permit');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `offshore_onshore_flag` SET TAGS ('dbx_business_glossary_term' = 'Offshore Onshore Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `offshore_onshore_flag` SET TAGS ('dbx_value_regex' = 'Offshore|Onshore');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `operator_type` SET TAGS ('dbx_business_glossary_term' = 'Operator Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `operator_type` SET TAGS ('dbx_value_regex' = 'IOC|NOC|Independent|JV');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `primary_target_formation` SET TAGS ('dbx_business_glossary_term' = 'Primary Target Formation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `prospect_count` SET TAGS ('dbx_business_glossary_term' = 'Prospect Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'Prospective|Contingent|Proved|Probable|Possible');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `seismic_data_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Seismic Data Available Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `seismic_data_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Seismic Data Vintage Year');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `signature_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Signature Bonus Amount');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `signature_bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `signature_bonus_currency` SET TAGS ('dbx_business_glossary_term' = 'Signature Bonus Currency');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `signature_bonus_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `water_depth_max_meters` SET TAGS ('dbx_business_glossary_term' = 'Water Depth Maximum Meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `water_depth_min_meters` SET TAGS ('dbx_business_glossary_term' = 'Water Depth Minimum Meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `work_program_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Work Program Commitment Amount');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `work_program_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `work_program_commitment_currency` SET TAGS ('dbx_business_glossary_term' = 'Work Program Commitment Currency');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `work_program_commitment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `work_program_seismic_km` SET TAGS ('dbx_business_glossary_term' = 'Work Program Seismic Kilometers (km)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `work_program_well_count` SET TAGS ('dbx_business_glossary_term' = 'Work Program Well Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` SET TAGS ('dbx_subdomain' = 'geological_assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prospect_resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Resource Estimate Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `superseded_by_estimate_prospect_resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Estimate Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `charge_adequacy_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Charge Adequacy Risk Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Estimate Comments');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `estimate_date` SET TAGS ('dbx_business_glossary_term' = 'Estimate Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_business_glossary_term' = 'Estimate Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `estimate_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|withdrawn');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `estimate_version` SET TAGS ('dbx_business_glossary_term' = 'Estimate Version Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `eur_1p_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) One P (1P) Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `eur_2p_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Two P (2P) Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `eur_3p_boe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) Three P (3P) Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_value_regex' = 'volumetric|analog|simulation|probabilistic|deterministic');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `expected_monetary_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Expected Monetary Value (EMV) United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `expected_monetary_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `geological_chance_of_success_pct` SET TAGS ('dbx_business_glossary_term' = 'Geological Chance of Success (GCoS) Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `giip_high_case_bcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Initially In Place (GIIP) High Case Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `giip_low_case_bcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Initially In Place (GIIP) Low Case Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `giip_mid_case_bcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Initially In Place (GIIP) Mid Case Billion Cubic Feet (BCF)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prms_resource_category` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Category');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prms_resource_category` SET TAGS ('dbx_value_regex' = 'prospective|contingent|reserves');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prms_resource_subclass` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Subclass');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prms_resource_subclass` SET TAGS ('dbx_value_regex' = 'play|lead|prospect|pdp|pdnp|pud');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `recovery_factor_high_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor High Case Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `recovery_factor_low_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Low Case Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `recovery_factor_mid_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Mid Case Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `reservoir_presence_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Presence Risk Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `reservoir_quality_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Quality Risk Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Methodology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risk_methodology` SET TAGS ('dbx_value_regex' = 'multiplicative|additive|hybrid');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risk_weighted_npv_usd` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Net Present Value (NPV) United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risk_weighted_npv_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risked_resource_high_boe` SET TAGS ('dbx_business_glossary_term' = 'Risked Resource High Case Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risked_resource_low_boe` SET TAGS ('dbx_business_glossary_term' = 'Risked Resource Low Case Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `risked_resource_mid_boe` SET TAGS ('dbx_business_glossary_term' = 'Risked Resource Mid Case Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `seal_effectiveness_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Seal Effectiveness Risk Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `stoiip_high_case_bbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially In Place (STOIIP) High Case Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `stoiip_low_case_bbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially In Place (STOIIP) Low Case Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `stoiip_mid_case_bbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially In Place (STOIIP) Mid Case Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `timing_migration_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Timing and Migration Risk Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `trap_integrity_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Trap Integrity Risk Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sedimentary Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `carried_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Company Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Encountered Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Encountered Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Target Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_use_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Use Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Target Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Well Cost');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_md_depth` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_tvd_depth` SET TAGS ('dbx_business_glossary_term' = 'Actual True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `api_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Location Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `co2_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `depth_uom` SET TAGS ('dbx_business_glossary_term' = 'Depth Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `depth_uom` SET TAGS ('dbx_value_regex' = 'feet|meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Total Drilling Days');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Flow Rate');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Fluid Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_fluid_type` SET TAGS ('dbx_value_regex' = 'oil|gas|water|condensate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_interval_bottom` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Interval Bottom Depth');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_interval_top` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Interval Top Depth');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Performed Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `dst_shut_in_pressure` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Shut-In Pressure');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Environment Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `environment_type` SET TAGS ('dbx_value_regex' = 'onshore|offshore_shallow|offshore_deepwater|offshore_ultra_deepwater');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Well Cost');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `gor` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `gross_pay_thickness` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Thickness');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `gross_pay_thickness` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `gross_pay_thickness` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type Encountered');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed|none');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `net_pay_thickness` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Thickness');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `net_pay_thickness` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `net_pay_thickness` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `npt_days` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Days');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Well Drilling Objective');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `pay_zone_summary` SET TAGS ('dbx_business_glossary_term' = 'Pay Zone Summary Description');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `planned_td_depth` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth (TD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `planned_tvd_depth` SET TAGS ('dbx_business_glossary_term' = 'Planned True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Post-Drill Recommendation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `td_date` SET TAGS ('dbx_business_glossary_term' = 'Total Depth (TD) Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `trajectory_type` SET TAGS ('dbx_business_glossary_term' = 'Well Trajectory Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `trajectory_type` SET TAGS ('dbx_value_regex' = 'vertical|directional|horizontal|multilateral|extended_reach');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `water_depth` SET TAGS ('dbx_business_glossary_term' = 'Water Depth');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_result` SET TAGS ('dbx_business_glossary_term' = 'Well Result Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_result` SET TAGS ('dbx_value_regex' = 'discovery|dry_hole|shows|technical_success|suspended');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_status` SET TAGS ('dbx_business_glossary_term' = 'Well Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_type` SET TAGS ('dbx_business_glossary_term' = 'Well Type Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_type` SET TAGS ('dbx_value_regex' = 'wildcat|appraisal|delineation|stratigraphic|exploratory');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Core Sample Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Coring Contractor Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `analysis_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Analysis Laboratory Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `bottom_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Bottom Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `bottom_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Bottom Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `bulk_density` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density Grams per Cubic Centimeter (g/cc)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Core Analysis Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_analysis_type` SET TAGS ('dbx_value_regex' = 'routine|special_core_analysis|scal|thin_section|xrd|sem');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_barrel_type` SET TAGS ('dbx_business_glossary_term' = 'Core Barrel Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_diameter` SET TAGS ('dbx_business_glossary_term' = 'Core Diameter');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_length_cut` SET TAGS ('dbx_business_glossary_term' = 'Core Length Cut');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_length_recovered` SET TAGS ('dbx_business_glossary_term' = 'Core Length Recovered');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_recovery_percentage` SET TAGS ('dbx_business_glossary_term' = 'Core Recovery Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_run_number` SET TAGS ('dbx_business_glossary_term' = 'Core Run Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `coring_date` SET TAGS ('dbx_business_glossary_term' = 'Coring Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `depth_unit` SET TAGS ('dbx_business_glossary_term' = 'Depth Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `depth_unit` SET TAGS ('dbx_value_regex' = 'feet|meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `fluid_saturation_gas` SET TAGS ('dbx_business_glossary_term' = 'Gas Saturation Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `fluid_saturation_oil` SET TAGS ('dbx_business_glossary_term' = 'Oil Saturation Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `fluid_saturation_water` SET TAGS ('dbx_business_glossary_term' = 'Water Saturation Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `grain_density` SET TAGS ('dbx_business_glossary_term' = 'Grain Density Grams per Cubic Centimeter (g/cc)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `lithology_description` SET TAGS ('dbx_business_glossary_term' = 'Lithology Description');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `lithology_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Lithology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `lithology_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Lithology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `permeability_horizontal` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Permeability Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Permeability Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `permeability_vertical` SET TAGS ('dbx_business_glossary_term' = 'Vertical Permeability Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `porosity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Porosity Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Preservation Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `preservation_method` SET TAGS ('dbx_value_regex' = 'frozen|refrigerated|ambient|sealed|waxed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `sample_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `sample_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged|depleted');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'available|in_analysis|depleted|archived|destroyed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `top_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Top Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `top_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Top Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Development Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'License Block Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Producing Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `commerciality_status` SET TAGS ('dbx_business_glossary_term' = 'Commerciality Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `commerciality_status` SET TAGS ('dbx_value_regex' = 'commercial|sub_commercial|under_evaluation|not_commercial');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `depth_md_ft` SET TAGS ('dbx_business_glossary_term' = 'Discovery Depth Measured Depth (MD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `depth_tvd_ft` SET TAGS ('dbx_business_glossary_term' = 'Discovery Depth True Vertical Depth (TVD) in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_code` SET TAGS ('dbx_business_glossary_term' = 'Discovery Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_name` SET TAGS ('dbx_business_glossary_term' = 'Discovery Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_status` SET TAGS ('dbx_business_glossary_term' = 'Discovery Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_status` SET TAGS ('dbx_value_regex' = 'declared|under_appraisal|commercial|non_commercial|suspended|relinquished');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `eur_p10_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P10 in Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `eur_p50_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P50 in Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `eur_p90_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P90 in Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `fluid_type_detail` SET TAGS ('dbx_business_glossary_term' = 'Fluid Type Detail');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `giip_bcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Initially in Place (GIIP) in Billion Cubic Feet (Bcf)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `gor_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Stock Tank Barrel (scf/stb)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `hydrocarbon_saturation_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Saturation Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|associated_gas|wet_gas|dry_gas');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `initial_production_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate in Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `initial_production_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate in Thousand Cubic Feet per Day (MCFD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `initial_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Reservoir Pressure in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Thickness in Feet (ft)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Permeability in Millidarcies (md)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Porosity Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `prms_maturity_subclass` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Maturity Subclass');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Class');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_value_regex' = '1P|2P|3P|contingent|prospective');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `recovery_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `reservoir_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Temperature in Fahrenheit (F)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `stoiip_mmbbl` SET TAGS ('dbx_business_glossary_term' = 'Stock Tank Oil Initially in Place (STOIIP) in Million Barrels (MMbbl)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `water_depth_ft` SET TAGS ('dbx_business_glossary_term' = 'Water Depth in Feet (ft)');
