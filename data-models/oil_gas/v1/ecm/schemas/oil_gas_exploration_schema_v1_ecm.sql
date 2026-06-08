-- Schema for Domain: exploration | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`exploration` COMMENT 'Manages all upstream exploration activities including seismic surveys, geological and geophysical (G&G) interpretation, prospect evaluation, basin analysis, and wildcat well planning. Serves as the SSOT for prospect and play data, resource potential assessments, lead/prospect generation, and PRMS-aligned resource classifications (1P/2P/3P). Integrates with Landmark DecisionSpace and Schlumberger Petrel for subsurface modeling and G&G workflows.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`basin` (
    `basin_id` BIGINT COMMENT 'Unique identifier for the sedimentary basin. Primary key for the basin master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links basin to the accountable technical champion. Required for portfolio governance, resource allocation decisions, and succession planning. Basin champion is a named role in exploration organization',
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
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which the prospect is located. Used for regional portfolio analysis and basin-level resource aggregation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links prospect evaluation to the responsible geologist. Supports portfolio reviews, competency tracking, and success rate analysis by evaluator. Replaces denormalized geologist_name text field with pr',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Prospects are located within exploration blocks. Currently prospect has block_name (STRING); this should be replaced with a FK to the block master to ensure consistent block references and enable retr',
    `lead_id` BIGINT COMMENT 'Foreign key linking to exploration.lead. Business justification: Prospect should track which lead it matured from. In exploration workflows, leads are early-stage hydrocarbon concepts that mature into drillable prospects. This FK captures the maturation lineage and',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Prospects are drilled on leased land. Lease terms (expiry, working interest, royalty rate) affect prospect economics, drilling rights verification, and regulatory permit applications. Critical for dri',
    `play_id` BIGINT COMMENT 'Reference to the parent play within which this prospect is identified. Links prospect to basin-scale play fairway analysis.',
    `pricing_agreement_id` BIGINT COMMENT 'Foreign key linking to commercial.pricing_agreement. Business justification: High-value prospects in joint ventures often have pre-negotiated pricing frameworks established before drilling to align partner economics. Links exploration risk assessment to commercial terms - comm',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Prospects target specific reservoir formations. Currently prospect has reservoir_formation (STRING) and reservoir_age (STRING); these should be replaced with a FK to the formation master to ensure con',
    `seismic_survey_id` BIGINT COMMENT 'Reference to the 3D seismic survey used for prospect interpretation. Links to seismic data in Landmark DecisionSpace.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Prospects target specific hydrocarbon product types (crude, gas, condensate) for economic evaluation and resource classification. Essential for prospect maturity gates requiring product-specific price',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Prospects that advance to drilling or detailed evaluation become capital projects tracked via WBS elements for project accounting, cost control, and capitalization decisions. Essential for project eco',
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
    `employee_id` BIGINT COMMENT 'Reference to the geologist or geoscientist responsible for generating and evaluating the lead.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Leads are identified on specific leased acreage. Land position (lease expiry, working interest, royalty burden) directly impacts lead screening economics, promotion decisions, and drilling rights. Ess',
    `block_id` BIGINT COMMENT 'Reference to the exploration license or lease block in which the lead is located.',
    `play_id` BIGINT COMMENT 'Reference to the geological play or petroleum system to which this lead belongs.',
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
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Seismic acquisition contractors (CGG, PGS, WesternGeco) are vendors providing specialized geophysical services - major procurement category requiring vendor qualification, contracts, and performance t',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Seismic acquisition requires AFE authorization - major capital expenditure requiring partner approval and budget tracking. Survey costs are AFE line items for JIB billing and cost recovery. No existin',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Seismic acquisition operations staged from production facilities (onshore bases, offshore platforms) for logistics, cost allocation, HSE coordination, and vessel/equipment mobilization planning. Role ',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Seismic surveys are major capital expenditures requiring AFE authorization; each survey is approved via an AFE for budget control, cost tracking, and JV partner approval. Critical for capital expendit',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Seismic surveys are acquired over leased acreage. Surface access rights, environmental permits, and data ownership are tied to lease agreements. Required for cost allocation, regulatory compliance, an',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Seismic operations require environmental permits (marine mammal protection, NEPA clearances) and regulatory approvals before acquisition. Standard HSE compliance requirement. Links survey to its envir',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`seismic_line` (
    `seismic_line_id` BIGINT COMMENT 'Unique identifier for the seismic line record. Primary key for the seismic line entity.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Line-level acquisition contractor tracking enables performance evaluation and invoice reconciliation at granular level - operational procurement management for seismic services. Removes denormalized c',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `seismic_survey_id` BIGINT COMMENT 'Reference to the parent seismic survey to which this line belongs. Links to the survey acquisition program.',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Seismic lines are acquired to image specific target formations. Currently seismic_line has target_formation (STRING); this should be replaced with a FK to the formation master to ensure consistent for',
    `acquisition_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for acquiring the seismic data for this line, measured in USD. Includes contractor fees, equipment, and field operations. Used for CAPEX tracking and AFE management.',
    `acquisition_end_date` DATE COMMENT 'Date when seismic data acquisition was completed for this line. Marks the end of field operations.',
    `acquisition_start_date` DATE COMMENT 'Date when seismic data acquisition began for this line. Marks the start of field operations.',
    `acquisition_status` STRING COMMENT 'Current lifecycle status of the seismic line acquisition: planned, in progress, acquired, suspended, cancelled, or completed.. Valid values are `planned|in_progress|acquired|suspended|cancelled|completed`',
    `azimuth_degrees` DECIMAL(18,2) COMMENT 'Compass bearing or azimuth of the seismic line in degrees (0-360). Indicates the directional orientation of the line relative to true north.',
    `coordinate_system` STRING COMMENT 'Spatial reference system used for positioning the seismic line (e.g., WGS84, NAD83, UTM Zone 14N). Critical for integration with other geospatial datasets.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this seismic line record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_format` STRING COMMENT 'File format standard used for storing the seismic data: SEG-Y, SEG-D, SEG-2, or proprietary format. Critical for data exchange and software compatibility.. Valid values are `SEG-Y|SEG-D|SEG-2|SEGY_REV1|SEGY_REV2|proprietary`',
    `data_quality_grade` STRING COMMENT 'Qualitative assessment of the seismic data quality for this line: excellent, good, fair, poor, or unacceptable. Based on signal-to-noise ratio, coherence, and interpretability.. Valid values are `excellent|good|fair|poor|unacceptable`',
    `data_storage_location` STRING COMMENT 'File path, cloud storage URI, or archive location where the processed seismic data for this line is stored. Used for data retrieval and integration with Landmark DecisionSpace and Petrel.',
    `end_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the ending point of the seismic line in decimal degrees. Used for geospatial positioning and mapping.',
    `end_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the ending point of the seismic line in decimal degrees. Used for geospatial positioning and mapping.',
    `environmental_permit_number` STRING COMMENT 'Reference number of the environmental permit or authorization obtained for seismic acquisition activities on this line. Required for regulatory compliance.',
    `fold_coverage` STRING COMMENT 'Number of times a subsurface point is sampled by different source-receiver pairs. Higher fold improves signal-to-noise ratio and data quality.',
    `hse_incident_count` STRING COMMENT 'Number of HSE incidents recorded during acquisition of this seismic line. Used for safety performance tracking and regulatory compliance.',
    `interpretation_status` STRING COMMENT 'Current status of geological and geophysical interpretation for this seismic line: not started, in progress, preliminary, final, approved, or archived.. Valid values are `not_started|in_progress|preliminary|final|approved|archived`',
    `line_length_km` DECIMAL(18,2) COMMENT 'Total length of the seismic line measured in kilometers. Represents the physical extent of the acquisition line on the surface or subsurface.',
    `line_name` STRING COMMENT 'Human-readable name or identifier for the seismic line as assigned during acquisition planning. Used for operational reference and G&G interpretation workflows.',
    `line_number` STRING COMMENT 'Unique line number or code assigned within the survey. May follow contractor or operator naming conventions (e.g., L-1001, IL-2500).',
    `line_type` STRING COMMENT 'Classification of the seismic line by acquisition geometry: 2D (single line), 3D inline, 3D crossline, 4D (time-lapse), VSP (Vertical Seismic Profile), or walkaway VSP.. Valid values are `2D|3D_inline|3D_crossline|4D|VSP|walkaway_VSP`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this seismic line record was last modified in the system. Used for audit trail and change tracking.',
    `play_type` STRING COMMENT 'Geological play type targeted by this seismic line (e.g., structural trap, stratigraphic trap, combination trap). Supports prospect classification and resource assessment.',
    `processing_completion_date` DATE COMMENT 'Date when seismic data processing was completed and final processed data was delivered.',
    `processing_contractor` STRING COMMENT 'Name of the contractor or service company responsible for processing the seismic data for this line.',
    `processing_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for processing the seismic data for this line, measured in USD. Includes contractor fees and computational resources. Used for CAPEX tracking and AFE management.',
    `processing_sequence` STRING COMMENT 'Description of the seismic data processing workflow applied to this line. May include steps such as deconvolution, stacking, migration, filtering, and noise attenuation.',
    `receiver_spacing_m` DECIMAL(18,2) COMMENT 'Distance between successive receiver stations (geophones or hydrophones) along the line, measured in meters. Determines spatial resolution of the acquired data.',
    `record_length_ms` STRING COMMENT 'Total recording time for each seismic trace in milliseconds. Defines the temporal extent of data captured per shot point.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special considerations related to this seismic line. May include acquisition challenges, data quality issues, or interpretation insights.',
    `sample_interval_ms` DECIMAL(18,2) COMMENT 'Time interval between successive samples in the seismic trace, measured in milliseconds. Determines the temporal resolution of the acquired data.',
    `shot_point_end` STRING COMMENT 'Ending shot point number for the seismic line. Defines the end of the acquisition sequence along the line.',
    `shot_point_start` STRING COMMENT 'Starting shot point number for the seismic line. Defines the beginning of the acquisition sequence along the line.',
    `source_interval_m` DECIMAL(18,2) COMMENT 'Spacing between successive seismic source points along the line, measured in meters. Affects spatial sampling and data quality.',
    `source_type` STRING COMMENT 'Type of energy source used for seismic acquisition: dynamite, vibroseis, airgun, watergun, sparker, or weight drop. Determines the signal characteristics and environmental considerations.. Valid values are `dynamite|vibroseis|airgun|watergun|sparker|weight_drop`',
    `start_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the starting point of the seismic line in decimal degrees. Used for geospatial positioning and mapping.',
    `start_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the starting point of the seismic line in decimal degrees. Used for geospatial positioning and mapping.',
    CONSTRAINT pk_seismic_line PRIMARY KEY(`seismic_line_id`)
) COMMENT 'Master record for individual 2D seismic lines or 3D seismic inline/crossline extents within a survey. Captures line name/number, shot point range, line length (km), azimuth, acquisition parameters (record length, sample interval, source type, receiver spacing), processing sequence applied, and interpretation status. Supports detailed seismic data management and G&G interpretation workflows in Landmark DecisionSpace.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`well_log` (
    `well_log_id` BIGINT COMMENT 'Unique identifier for the well log record. Primary key for subsurface data acquisition records from exploration and appraisal wells.',
    `exploration_well_id` BIGINT COMMENT 'Reference to the exploration or appraisal well from which this log or sample was acquired. Links to the well master record.',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Well logs are acquired from specific stratigraphic formations. Currently well_log has formation_name (STRING); this should be replaced with a FK to the formation master table to ensure consistent form',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Well logs from appraisal/delineation wells characterize reservoir properties (porosity, permeability, saturation). Essential for reservoir modeling, volumetric calculations, and petrophysical analysis',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Wireline service companies (Schlumberger, Halliburton, Baker Hughes) are major vendors - critical for vendor performance tracking, invoice validation, and contract compliance. Role prefix reflects wir',
    `acquisition_date` DATE COMMENT 'Date when the log was run or the sample was collected downhole. Critical for correlating with drilling timeline and formation conditions.',
    `acquisition_tool` STRING COMMENT 'Name or model of the logging tool, coring equipment, or sampling device used. Examples: Schlumberger Platform Express, Halliburton Rotary Sidewall Coring Tool, Baker Hughes Reservoir Description Tool.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of reservoir fluid sample. Measure of petroleum density relative to water. Higher values indicate lighter, more valuable crude oil.',
    `api_well_number` STRING COMMENT 'Standardized API well number assigned by regulatory authority. Unique identifier for the well in North American jurisdictions.. Valid values are `^[0-9]{10,14}$`',
    `bottom_depth_md` DECIMAL(18,2) COMMENT 'Ending depth of the log interval or sample location along the wellbore path, measured from surface. Defines the lower boundary of the logged or sampled interval.',
    `bottom_depth_tvd` DECIMAL(18,2) COMMENT 'Ending depth of the log interval or sample location measured vertically from surface. Used for subsurface mapping and reservoir depth determination.',
    `bubble_point_pressure_psi` DECIMAL(18,2) COMMENT 'Pressure at which gas begins to come out of solution from the oil. Key parameter for reservoir simulation and production optimization.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Total cost of acquiring the log or sample, including service company charges, rig time, and laboratory analysis. Used for AFE (Authorization for Expenditure) tracking and well economics.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this well log record was first created in the data management system. Supports audit trail and data lineage.',
    `data_classification` STRING COMMENT 'Confidentiality level of the subsurface data. Restricted data may be subject to JOA (Joint Operating Agreement) confidentiality clauses or regulatory disclosure restrictions.. Valid values are `public|internal|confidential|restricted`',
    `data_format` STRING COMMENT 'Digital file format of the log data. LAS (Log ASCII Standard) and DLIS (Digital Log Interchange Standard) are industry standards for wireline logs. ASCII, PDF, and TIFF used for reports and images.. Valid values are `LAS|DLIS|ASCII|PDF|TIFF`',
    `data_quality_flag` STRING COMMENT 'Assessment of the technical quality and reliability of the acquired data. Influences confidence in petrophysical interpretation and formation evaluation.. Valid values are `excellent|good|fair|poor|unusable`',
    `depth_uom` STRING COMMENT 'Unit of measure for depth values. Feet (ft) is standard in North America; meters (m) is standard internationally.. Valid values are `ft|m`',
    `file_path` STRING COMMENT 'Network or cloud storage path to the digital log file or analytical report. Enables retrieval of raw data for reprocessing and interpretation. Business-confidential data location.',
    `gor` DECIMAL(18,2) COMMENT 'Gas-Oil Ratio from PVT (Pressure Volume Temperature) analysis. Volume of gas produced per volume of oil at standard conditions. Critical for production facility design and reserves classification.',
    `hydrocarbon_saturation_percent` DECIMAL(18,2) COMMENT 'Percentage of pore space occupied by oil or gas. Calculated as 100 minus water saturation. Critical for OOIP (Original Oil in Place) and OGIP (Original Gas in Place) calculations.',
    `interpretation_date` DATE COMMENT 'Date when the petrophysical interpretation or analytical results were finalized. Tracks data maturity and version control.',
    `interpretation_status` STRING COMMENT 'Stage of petrophysical interpretation and quality control. Raw data has not been interpreted; final data has been reviewed by geoscientists and approved for reserves estimation.. Valid values are `raw|preliminary|final|validated`',
    `interpreted_by` STRING COMMENT 'Name or identifier of the petrophysicist or geoscientist who performed the log interpretation or sample analysis. Supports data lineage and quality assurance.',
    `lithology` STRING COMMENT 'Rock type identified from core description or log interpretation. Examples: sandstone, limestone, dolomite, shale, siltstone. Fundamental for reservoir characterization.',
    `log_subtype` STRING COMMENT 'Detailed classification of the log or sample. For wireline: GR (Gamma Ray), resistivity, neutron-density, sonic, image logs. For core: conventional core, sidewall core. For fluid: PVT (Pressure Volume Temperature) sample, DST (Drill Stem Test) sample. For geochemical: TOC (Total Organic Carbon), vitrinite reflectance, Rock-Eval pyrolysis.',
    `log_type` STRING COMMENT 'Category of subsurface data acquisition. Wireline logs are run after drilling; LWD (Logging While Drilling) and MWD (Measurement While Drilling) are real-time; core samples are physical rock specimens; fluid samples are reservoir fluids; geochemical samples are for source rock analysis.. Valid values are `wireline|LWD|MWD|core|fluid_sample|geochemical`',
    `permeability_md` DECIMAL(18,2) COMMENT 'Measured permeability of core sample in millidarcies. Indicates the rocks ability to transmit fluids. Key parameter for reservoir deliverability and production forecasting.',
    `porosity_percent` DECIMAL(18,2) COMMENT 'Measured or calculated porosity of the rock sample or logged interval. Represents the percentage of pore space available for hydrocarbon storage. Critical for reservoir quality assessment.',
    `quality_comments` STRING COMMENT 'Free-text notes on data quality issues, acquisition problems, environmental corrections applied, or interpretation caveats. Provides context for data users.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this log or sample data has been submitted to regulatory authorities (BSEE, BOEM, state oil and gas commissions) as part of drilling permit compliance or reserves reporting.',
    `run_number` STRING COMMENT 'Sequential number for multiple logging runs or sample acquisitions in the same well. Differentiates repeat runs or multiple sampling events.',
    `sample_condition` STRING COMMENT 'Current physical state and availability of the core or fluid sample. Preserved samples are available for future analysis; depleted samples have been consumed by testing.. Valid values are `preserved|analyzed|depleted|archived`',
    `storage_location` STRING COMMENT 'Physical location where core or fluid samples are stored. May reference core warehouse facility, laboratory, or archive center. Business-confidential asset location.',
    `toc_percent` DECIMAL(18,2) COMMENT 'Total Organic Carbon content of source rock sample. Indicates hydrocarbon generation potential. Key parameter for unconventional resource assessment.',
    `top_depth_md` DECIMAL(18,2) COMMENT 'Starting depth of the log interval or sample location along the wellbore path, measured from surface (kelly bushing or rotary table). Expressed in feet or meters.',
    `top_depth_tvd` DECIMAL(18,2) COMMENT 'Starting depth of the log interval or sample location measured vertically from surface. Critical for subsurface correlation and structural interpretation in deviated wells.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified this record. Supports data governance and change management.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this well log record was last modified. Tracks data currency and version history for interpretation updates.',
    `viscosity_cp` DECIMAL(18,2) COMMENT 'Fluid viscosity measured in centipoise at reservoir conditions. Affects flow behavior and recovery efficiency. Critical for heavy oil and EOR (Enhanced Oil Recovery) evaluation.',
    `vitrinite_reflectance` DECIMAL(18,2) COMMENT 'Vitrinite reflectance measurement indicating thermal maturity of source rock. Values >0.6% indicate oil generation window; >1.3% indicates gas generation.',
    `water_saturation_percent` DECIMAL(18,2) COMMENT 'Percentage of pore space occupied by formation water. Complement of hydrocarbon saturation. Derived from resistivity logs or core analysis.',
    CONSTRAINT pk_well_log PRIMARY KEY(`well_log_id`)
) COMMENT 'Master record for all subsurface data acquired from exploration and appraisal wells. Covers wireline logs (GR, resistivity, neutron-density, sonic, image), LWD/MWD logs, rock core samples (conventional and sidewall, with routine and SCAL analysis including porosity, permeability, fluid saturation, lithology), reservoir fluid samples (PVT — API gravity, GOR, saturation pressure, viscosity), and geochemical samples (TOC, vitrinite reflectance, hydrogen/oxygen index, thermal maturity). Captures data type, run/sample number, depth interval (MD/TVD), acquisition tool/method, quality flag, analytical results, sample condition, storage location, and data format (LAS/DLIS). Serves as the consolidated G&G data inventory for subsurface interpretation and formation evaluation. Integrates with Landmark DecisionSpace log analysis and Petrel property modeling workflows.';

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
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Exploration blocks often contain production facilities; business needs this for block-level production reporting, joint venture accounting, infrastructure planning, and regulatory submissions. Role pr',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which this block is located. Links to basin master data for regional geological context and play fairway analysis.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the company or entity designated as the operator for exploration activities in this block. The operator is responsible for day-to-day operations and regulatory compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration blocks are cost centers in oil-and-gas accounting; all block-related costs (seismic, G&G, lease maintenance) are tracked to specific cost centers for budgeting, variance analysis, and JV b',
    `license_id` BIGINT COMMENT 'Foreign key linking to exploration.license. Business justification: Block should reference its parent exploration license. A block is awarded as part of a license, and license-level attributes (award_date, expiration_date, license_status, license_round) should be retr',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Exploration blocks are operated under Joint Operating Agreements when multiple parties hold working interests. JOA governs cost-sharing, voting rights, and operational decisions for all block activiti',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or partnership arrangement under which the block is being explored. Links to joint venture master data for partner tracking and cost allocation.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Exploration blocks are often subdivided into or overlap with leases. Regulatory filings, work program commitments, and commercial tracking require linking blocks to specific lease agreements for right',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Exploration blocks are governed by operating licenses (PSAs, concessions) defining authorized activities, work programs, and fiscal terms. Legal framework for block operations. Links block to its gove',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: International exploration blocks often operate under Production Sharing Agreements defining fiscal terms, cost recovery, and profit split. Links block-level exploration activities to PSA cost recovery',
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
    `regulatory_body` STRING COMMENT 'Name of the government agency or regulatory authority responsible for administering the exploration license, enforcing compliance, and approving work programs for this block.',
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
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: License acquisitions, renewals, and relinquishments require regulatory filings with authorities (SEC Form 10-K reserves disclosures, BOEM filings). Mandatory disclosure requirement. Links license to i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration licenses are cost objects; signature bonuses, work program commitments, and license maintenance costs are tracked to cost centers for accounting and JV partner billing. Required for cost c',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Exploration licenses with multiple interest holders operate under JOAs. Links license terms (regulatory) to JOA terms (commercial partnership). Required for tracking work program commitments, cost all',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Exploration licenses in PSA jurisdictions are governed by PSA fiscal terms. Links regulatory license to commercial PSA for cost recovery eligibility, signature bonus tracking, and work program complia',
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
    `issuing_authority` STRING COMMENT 'Name of the governmental or regulatory body that granted the exploration license (e.g., BOEM, state mineral board, national oil company, ministry of energy).',
    `joint_venture_flag` BOOLEAN COMMENT 'Indicates whether the exploration license is held under a joint venture arrangement with multiple working interest partners. True = JV structure; False = single operator or non-JV arrangement.',
    `license_number` STRING COMMENT 'Official license or permit number issued by the regulatory authority. This is the externally-known business identifier used in all regulatory correspondence and filings.',
    `license_status` STRING COMMENT 'Current lifecycle state of the exploration license. Active = in force and work program underway; Pending = application submitted awaiting approval; Suspended = temporarily halted by operator or regulator; Expired = term ended without renewal; Relinquished = voluntarily returned by operator; Terminated = cancelled by regulator or mutual agreement.. Valid values are `Active|Pending|Suspended|Expired|Relinquished|Terminated`',
    `license_type` STRING COMMENT 'Classification of the exploration entitlement. PSC = Production Sharing Contract, JOA = Joint Operating Agreement. Determines fiscal terms, ownership structure, and regulatory obligations.. Valid values are `PSC|Concession|JOA|License|Lease|Permit`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the exploration license record was last updated in the system. Used for change tracking and data quality monitoring.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of production revenue the company is entitled to receive after deducting royalties, overriding royalty interests (ORRI), and government share. NRI = WI × (1 - royalty rate - ORRI).',
    `offshore_onshore_flag` STRING COMMENT 'Indicates whether the exploration license covers offshore (subsea) or onshore (land-based) acreage. Determines applicable regulatory framework, HSE requirements, and operational complexity.. Valid values are `Offshore|Onshore`',
    `operator_name` STRING COMMENT 'Legal name of the company designated as the operator responsible for executing the exploration work program and managing day-to-day activities. The operator may or may not be the majority working interest holder.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`study` (
    `study_id` BIGINT COMMENT 'Primary key for study',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: G&G studies require AFE authorization for budget approval; the existing afe_number attribute is denormalized. Proper FK enables study cost tracking and budget variance analysis. Essential for explorat',
    `play_id` BIGINT COMMENT 'FK to exploration.play',
    `prospect_id` BIGINT COMMENT 'Unique identifier for the exploration prospect associated with this study.',
    `seismic_survey_id` BIGINT COMMENT 'Unique identifier for the seismic survey dataset used as input for this study.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the lead geoscientist assigned to this study.',
    `study_lead_geoscientist_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'The actual cost incurred for completing this study in USD.',
    `approval_date` DATE COMMENT 'The date when the study was formally approved by management or technical authority.',
    `archive_location` STRING COMMENT 'Physical or digital location where the study data and deliverables are archived for long-term retention.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total budget allocated for this study in USD.',
    `confidence_level` STRING COMMENT 'The level of confidence in the study findings and interpretations based on data quality and analysis rigor.. Valid values are `high|medium|low`',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this study record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this study record was first created in the system.',
    `data_quality_assessment` STRING COMMENT 'Overall assessment of the quality of input data (seismic, well logs, etc.) used in the study.. Valid values are `excellent|good|fair|poor`',
    `deliverables_description` STRING COMMENT 'Description of the study deliverables including maps, cross-sections, reports, and digital datasets.',
    `depth_conversion_method` STRING COMMENT 'The method used to convert seismic time data to depth for structural mapping and reservoir characterization.. Valid values are `time_to_depth|velocity_model|checkshot|vsp|other`',
    `end_date` DATE COMMENT 'The date when the geological and geophysical study work was completed or is planned to be completed.',
    `fault_count` STRING COMMENT 'The number of faults interpreted and mapped in this study.',
    `horizon_count` STRING COMMENT 'The number of seismic horizons interpreted and mapped in this study.',
    `hydrocarbon_indicators` STRING COMMENT 'Description of direct or indirect hydrocarbon indicators observed in the study (e.g., bright spots, AVO anomalies, flat spots).',
    `interpretation_method` STRING COMMENT 'The methodology used for seismic or geological interpretation (manual picking, auto-tracking, machine learning, etc.).. Valid values are `manual|semi_automated|auto_tracking|machine_learning|hybrid`',
    `key_findings_summary` STRING COMMENT 'A concise summary of the key geological and geophysical findings, observations, and conclusions from the study.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this study record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this study record was last updated.',
    `peer_review_status` STRING COMMENT 'The status of peer review for this study by senior geoscientists or technical authorities.. Valid values are `not_required|pending|in_review|approved|rejected`',
    `peer_reviewer_name` STRING COMMENT 'Full name of the peer reviewer who assessed the technical quality of this study.',
    `project_code` STRING COMMENT 'The internal project or work breakdown structure code associated with this study for cost tracking and resource allocation.',
    `remarks` STRING COMMENT 'Additional comments, notes, or observations related to the study that do not fit into other structured fields.',
    `report_document_path` STRING COMMENT 'File system path or document management system reference to the final study report.',
    `software_platform` STRING COMMENT 'The primary geological and geophysical interpretation software platform used for this study (e.g., Schlumberger Petrel, Landmark DecisionSpace).. Valid values are `petrel|decisionspace|geoframe|kingdom|opendtect|other`',
    `start_date` DATE COMMENT 'The date when the geological and geophysical study work commenced.',
    `stratigraphic_observations` STRING COMMENT 'Observations related to stratigraphic sequences, depositional environments, and reservoir quality.',
    `structural_observations` STRING COMMENT 'Detailed observations regarding structural features identified in the study, including faults, folds, and traps.',
    `study_name` STRING COMMENT 'The official title or name of the geological and geophysical study.',
    `study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `planned|in_progress|under_review|completed|archived|cancelled`',
    `study_type` STRING COMMENT 'The category or type of geological and geophysical study being conducted. [ENUM-REF-CANDIDATE: basin_analysis|avo_analysis|seismic_attribute_study|source_rock_evaluation|structural_interpretation|horizon_interpretation|fault_interpretation|depth_conversion|velocity_modeling|reservoir_characterization — 10 candidates stripped; promote to reference product]',
    `velocity_model_type` STRING COMMENT 'The type of velocity model used in the study for depth conversion and seismic processing.. Valid values are `interval_velocity|average_velocity|rms_velocity|anisotropic|isotropic`',
    CONSTRAINT pk_study PRIMARY KEY(`study_id`)
) COMMENT 'Master record for geological and geophysical (G&G) studies and interpretation work products. Covers basin analysis, AVO analysis, seismic attribute studies, source rock evaluation, structural interpretation, horizon and fault interpretation, depth conversion, and velocity modeling. Captures study title, study type, lead geoscientist, study period, software used (Petrel/DecisionSpace), interpretation method (manual/auto-tracking), key findings summary, confidence level, structural observations, and associated deliverables. SSOT for G&G intellectual work product inventory including seismic interpretation events. Integrates with Landmark DecisionSpace and Schlumberger Petrel.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` (
    `seismic_interpretation_id` BIGINT COMMENT 'Unique identifier for the seismic interpretation event record.',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Seismic interpretations identify and map formations (horizons are formation tops/bases). Currently seismic_interpretation has horizon_name (STRING) which is interpretation-specific naming convention; ',
    `employee_id` BIGINT COMMENT 'Employee identifier of the geophysicist who performed the interpretation, used for tracking and accountability.',
    `prospect_id` BIGINT COMMENT 'Reference to the exploration prospect that this seismic interpretation supports or contributes to in the prospect evaluation workflow.',
    `seismic_survey_id` BIGINT COMMENT 'Reference to the seismic survey dataset on which this interpretation was performed.',
    `superseded_by_interpretation_seismic_interpretation_id` BIGINT COMMENT 'Reference to the newer seismic interpretation record that supersedes this interpretation, maintaining interpretation lineage and version history.',
    `approval_date` DATE COMMENT 'Date on which the seismic interpretation was formally approved and accepted for use in prospect evaluation and drilling decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the seismic interpretation record was first created in the system.',
    `data_quality_assessment` STRING COMMENT 'Qualitative assessment of the underlying seismic data quality that influenced the interpretation: excellent (high signal-to-noise ratio, clear reflectors), good, fair, or poor (noisy data, weak reflectors).. Valid values are `excellent|good|fair|poor`',
    `depth_conversion_method` STRING COMMENT 'Method used to convert seismic time data to depth domain: time-to-depth transformation, velocity model application, checkshot survey, vertical seismic profile (VSP), or well tie calibration.. Valid values are `time_to_depth|velocity_model|checkshot|vsp|well_tie`',
    `fault_name` STRING COMMENT 'Name or identifier of the geological fault interpreted from the seismic data, representing a structural discontinuity.',
    `horizon_name` STRING COMMENT 'Name of the geological horizon interpreted from the seismic data, representing a specific stratigraphic boundary or reflector.',
    `hydrocarbon_indicator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether potential hydrocarbon indicators (e.g., bright spots, flat spots, amplitude anomalies) were identified during interpretation.',
    `hydrocarbon_indicator_type` STRING COMMENT 'Type of direct hydrocarbon indicator (DHI) observed in the seismic data (e.g., bright spot, flat spot, amplitude versus offset anomaly, phase reversal).',
    `integration_with_well_data_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the seismic interpretation was calibrated or integrated with well log data, checkshot surveys, or other well-based measurements.',
    `interpretation_comments` STRING COMMENT 'Free-text comments, notes, or observations recorded by the interpreter regarding data quality, interpretation challenges, or geological insights.',
    `interpretation_confidence` STRING COMMENT 'Qualitative assessment of the interpreters confidence in the accuracy and reliability of the seismic interpretation results.. Valid values are `high|medium|low|uncertain`',
    `interpretation_date` DATE COMMENT 'Date on which the seismic interpretation event was performed by the geophysicist or interpreter.',
    `interpretation_method` STRING COMMENT 'Technique or methodology used to perform the interpretation: manual picking, semi-automated workflow, auto-tracking algorithm, neural network, or machine learning model.. Valid values are `manual|semi-automated|auto-tracking|neural_network|machine_learning`',
    `interpretation_name` STRING COMMENT 'Business-friendly name or label assigned to this interpretation event for identification and tracking purposes.',
    `interpretation_quality_score` DECIMAL(18,2) COMMENT 'Quantitative quality score (0-100) assigned to the interpretation based on data quality, consistency, and geological plausibility.',
    `interpretation_software` STRING COMMENT 'Name and version of the software application used to perform the seismic interpretation (e.g., Landmark DecisionSpace, Schlumberger Petrel).',
    `interpretation_status` STRING COMMENT 'Current workflow status of the seismic interpretation: draft (in progress), in review (under peer review), approved (validated and accepted), rejected (not accepted), or superseded (replaced by newer interpretation).. Valid values are `draft|in_review|approved|rejected|superseded`',
    `interpretation_type` STRING COMMENT 'Category of seismic interpretation performed: horizon picking, fault identification, amplitude analysis, seismic attribute extraction, velocity modeling, structural interpretation, or stratigraphic interpretation. [ENUM-REF-CANDIDATE: horizon|fault|amplitude|attribute|velocity|structural|stratigraphic — 7 candidates stripped; promote to reference product]',
    `interpretation_version` STRING COMMENT 'Version number of the interpretation, incremented when the interpretation is revised or updated based on new data or insights.',
    `interpreter_name` STRING COMMENT 'Full name of the geophysicist or geoscientist who performed the seismic interpretation work.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the seismic interpretation record was last updated or modified in the system.',
    `peer_reviewer_name` STRING COMMENT 'Name of the senior geophysicist or technical expert who performed peer review of the seismic interpretation.',
    `play_type` STRING COMMENT 'Type of petroleum play identified or evaluated through the seismic interpretation (e.g., structural trap, stratigraphic trap, combination trap).',
    `review_date` DATE COMMENT 'Date on which the peer review of the seismic interpretation was completed.',
    `seismic_attribute_type` STRING COMMENT 'Type of seismic attribute analyzed or extracted during interpretation (e.g., amplitude, coherence, curvature, instantaneous frequency).',
    `signal_to_noise_ratio` DECIMAL(18,2) COMMENT 'Quantitative measure of the signal-to-noise ratio in the seismic data used for interpretation, expressed as a dimensionless ratio.',
    `stratigraphic_observation` STRING COMMENT 'Key stratigraphic observations documented during the interpretation, including depositional environments, sequence boundaries, and facies variations.',
    `structural_observation` STRING COMMENT 'Key structural geological observations documented during the interpretation, including fault patterns, fold geometries, and structural trends.',
    `velocity_model_name` STRING COMMENT 'Name or identifier of the velocity model used for depth conversion and seismic imaging during the interpretation process.',
    `well_tie_quality` STRING COMMENT 'Qualitative assessment of the quality of the well-to-seismic tie used to calibrate the interpretation, if applicable.. Valid values are `excellent|good|fair|poor|not_applicable`',
    CONSTRAINT pk_seismic_interpretation PRIMARY KEY(`seismic_interpretation_id`)
) COMMENT 'Transactional record capturing horizon and fault interpretation events performed on seismic data. Captures interpretation date, interpreter, survey reference, horizon name, fault name, interpretation method (manual/auto-tracking), depth conversion method, velocity model used, interpretation confidence, and key structural observations. Tracks the G&G interpretation workflow from raw seismic to structural maps used in prospect evaluation. Integrates with Landmark DecisionSpace.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` (
    `wildcat_well_plan_id` BIGINT COMMENT 'Unique identifier for the wildcat well plan record. Primary key for the wildcat well plan entity.',
    `basin_id` BIGINT COMMENT 'FK to exploration.basin',
    `company_code_id` BIGINT COMMENT 'Reference to the operating company responsible for drilling and managing this wildcat well. May differ from working interest owners in joint venture arrangements.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Well plans specify expected product type for AFE cost estimation (drilling fluid design, completion strategy, testing equipment differ by product). Business process: AFE approval requires product-type',
    `lease_id` BIGINT COMMENT 'Reference to the oil and gas lease or concession under which this well will be drilled. Links to land and lease management system for mineral rights verification.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Well plans reference regulatory drilling permits before spud authorization. Standard pre-drill workflow requires permit approval before AFE execution. Links plan to its regulatory permit for complianc',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies the geologist who authored the well plan. Required for AFE approval workflows, technical peer review, and accountability for geological prognosis. Well plans require named technical author ',
    `prospect_id` BIGINT COMMENT 'Reference to the target exploration prospect or play that this well is designed to test. Links to the prospect master record in the exploration domain.',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Wildcat well plans target specific formations for drilling. Currently wildcat_well_plan has target_formation (STRING); this should be replaced with a FK to the formation master to ensure consistent fo',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Wildcat well plans require venture AFE approval from JV partners before drilling authorization. Links technical well plan to JV cost authorization and partner approval tracking. Mandatory governance s',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Planned exploration wells that become producers need linkage for AFE reconciliation, actual-vs-planned cost variance analysis, lessons learned, and asset capitalization. Supports financial close proce',
    `approval_date` DATE COMMENT 'Date when the wildcat well plan received final internal approval to proceed with regulatory permitting and drilling operations.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or technical authority who approved this wildcat well plan for execution. Required for AFE authorization and drilling commencement.',
    `bottom_hole_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the planned wellbore bottom hole location in decimal degrees. May differ significantly from surface location for deviated or horizontal wells.',
    `bottom_hole_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the planned wellbore bottom hole location in decimal degrees. May differ significantly from surface location for deviated or horizontal wells.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated well cost (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the well location (e.g., USA, GBR, NOR). Used for regulatory jurisdiction and reserves reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this wildcat well plan record was first created in the system. Audit trail for plan initiation.',
    `environmental_assessment_status` STRING COMMENT 'Status of environmental impact assessment or environmental review required by EPA, BSEE, or state agencies before drilling can commence.. Valid values are `not_required|required|in_progress|completed|approved`',
    `estimated_drilling_days` STRING COMMENT 'Planned number of days from spud to total depth, including drilling, casing, and testing operations. Used for rig scheduling and cost estimation.',
    `estimated_well_cost` DECIMAL(18,2) COMMENT 'Total estimated cost to drill, complete, and test the wildcat well as documented in the Authorization for Expenditure (AFE). Includes drilling, completion, testing, and contingency costs.',
    `h2s_expected` BOOLEAN COMMENT 'Boolean flag indicating whether hydrogen sulfide gas is expected in the target formation. Requires specialized safety equipment and procedures if true.',
    `high_pressure_expected` BOOLEAN COMMENT 'Boolean flag indicating whether abnormally high formation pressures are expected. Requires enhanced blowout preventer (BOP) specifications and well control procedures.',
    `hse_risk_level` STRING COMMENT 'Overall HSE risk classification for the planned drilling operation based on factors including H2S presence, high pressure, water depth, and environmental sensitivity.. Valid values are `low|medium|high|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this wildcat well plan record. Tracks plan revisions and changes during the planning phase.',
    `permit_approval_date` DATE COMMENT 'Date the regulatory drilling permit was officially approved by the governing authority. Enables spud date scheduling and rig mobilization.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the wildcat well plan. Tracks progression from initial planning through regulatory approval to drilling commencement.. Valid values are `draft|submitted|approved|on_hold|cancelled|drilling_commenced`',
    `planned_completion_date` DATE COMMENT 'Scheduled date for well completion activities including casing, cementing, and initial testing. Marks transition from drilling to evaluation phase.',
    `planned_spud_date` DATE COMMENT 'Scheduled date to commence drilling operations (spud the well). Critical milestone for rig scheduling, AFE timing, and regulatory permit coordination.',
    `planned_td` DECIMAL(18,2) COMMENT 'Planned total measured depth of the wellbore in feet or meters. Represents the deepest point the well will reach along the wellbore trajectory.',
    `planned_td_uom` STRING COMMENT 'Unit of measure for planned total depth. Typically feet (ft) in US operations or meters (m) in international operations.. Valid values are `ft|m`',
    `planned_tvd` DECIMAL(18,2) COMMENT 'Planned true vertical depth from surface to target formation in feet or meters. Differs from measured depth for deviated or horizontal wells.',
    `planned_tvd_uom` STRING COMMENT 'Unit of measure for planned true vertical depth. Typically feet (ft) in US operations or meters (m) in international operations.. Valid values are `ft|m`',
    `rig_type_required` STRING COMMENT 'Classification of drilling rig required for this well based on location and water depth. Land rigs for onshore; jackup, semisubmersible, or drillship for offshore operations.. Valid values are `land|jackup|semisubmersible|drillship`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the well is located. Critical for state-level regulatory compliance and tax jurisdiction.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the planned well surface location in decimal degrees. Used for regulatory filings, GIS mapping, and lease verification.',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the planned well surface location in decimal degrees. Used for regulatory filings, GIS mapping, and lease verification.',
    `trajectory_type` STRING COMMENT 'Planned wellbore trajectory classification. Vertical wells drill straight down; deviated wells angle from vertical; horizontal wells turn 90 degrees; extended reach wells achieve high horizontal displacement.. Valid values are `vertical|deviated|horizontal|extended_reach`',
    `water_depth` DECIMAL(18,2) COMMENT 'Water depth at the planned well location in feet or meters. Critical for offshore rig selection and drilling engineering. Null for onshore wells.',
    `water_depth_uom` STRING COMMENT 'Unit of measure for water depth. Typically feet (ft) in US operations or meters (m) in international operations.. Valid values are `ft|m`',
    `well_name` STRING COMMENT 'Official name or designation assigned to the planned wildcat or appraisal well. Typically follows naming conventions including lease, block, or prospect identifiers.',
    `well_objectives` STRING COMMENT 'Detailed description of the technical and business objectives for drilling this exploration well, including geological targets, data acquisition goals, and resource evaluation criteria.',
    `well_type` STRING COMMENT 'Classification of the exploration well. Wildcat wells target unproven prospects in new areas; appraisal wells delineate discovered resources; stratigraphic wells gather geological data.. Valid values are `wildcat|appraisal|stratigraphic`',
    `working_interest_pct` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the operator or reporting entity in this well. Represents ownership share of costs and production before royalties.',
    CONSTRAINT pk_wildcat_well_plan PRIMARY KEY(`wildcat_well_plan_id`)
) COMMENT 'Master record for planned wildcat and appraisal exploration wells prior to spud. Captures well name, well type (wildcat/appraisal/stratigraphic), target prospect, planned spud date, planned TD (total depth), planned TVD, target formation, well objectives, planned trajectory type (vertical/deviated/horizontal), estimated well cost (AFE), rig type required, and regulatory permit status. Serves as the exploration-to-drilling handoff record. Integrates with Schlumberger Petrel well planning.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`exploration_well` (
    `exploration_well_id` BIGINT COMMENT 'Unique system identifier for the exploration well record. Primary key for the exploration well entity.',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which the exploration well is located.',
    `company_code_id` BIGINT COMMENT 'Reference to the company serving as the operator responsible for drilling and managing the exploration well.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration wells are drilled within cost centers; well costs are allocated to cost centers for accounting, budgeting, and JV partner billing. Required for cost allocation and financial reporting in e',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Wells record actual hydrocarbon product type encountered for reserve booking by product category and JV partner reporting. Business process: well completion reports specify product type for reserves c',
    `field_id` BIGINT COMMENT 'Reference to the field if the well resulted in a discovery or is part of an existing field. Null for dry holes or unassigned wells.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Drilling wells requires regulatory permits (APD, drilling permits) from authorities like BLM, BSEE, state agencies. Permit tracking is mandatory for HSE compliance and operational authorization. Links',
    `prospect_id` BIGINT COMMENT 'Reference to the geological prospect that this exploration well is designed to test and evaluate.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Exploration wells drilled for reservoir appraisal/delineation must link to the reservoir being evaluated. Critical for well planning, reserves booking, and field development decisions. Domain experts ',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig used or planned for drilling this exploration well.',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Exploration wells in JV contexts are authorized via venture AFEs for partner cost allocation and billing. Links actual well execution to AFE budget tracking, variance analysis, and JIB statement prepa',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Exploration wells transition to producing assets; business requires linkage for reserves booking, production allocation, asset integrity tracking, regulatory compliance, and lifecycle cost analysis. C',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks the field geologist assigned to supervise geological operations during drilling. Critical for daily drilling reports, formation evaluation decisions, and HSE accountability. Standard practice i',
    `wildcat_well_plan_id` BIGINT COMMENT 'Foreign key linking to exploration.wildcat_well_plan. Business justification: Exploration wells should reference their originating wildcat well plans. A wildcat well plan is the pre-spud planning document; the exploration_well is the actual well execution. This FK establishes t',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred to drill and evaluate the exploration well, including all drilling, completion, and testing expenses.',
    `actual_md_depth` DECIMAL(18,2) COMMENT 'Actual total measured depth achieved by the well in feet or meters, measured along the wellbore trajectory.',
    `actual_tvd_depth` DECIMAL(18,2) COMMENT 'Actual true vertical depth achieved by the well in feet or meters, representing vertical distance from surface to bottom hole.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of oil samples recovered, measuring oil density and quality on the API scale.',
    `api_number` STRING COMMENT 'Unique 14-digit API well identifier assigned by regulatory authorities for well tracking and reporting. Format: state code (2) - county code (3) - unique well number (5) - optional sidetrack (2).. Valid values are `^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$`',
    `block_lease_number` STRING COMMENT 'Official block or lease number assigned by regulatory authorities identifying the exploration acreage.',
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
    `secondary_target_formation` STRING COMMENT 'Secondary or alternative geological formation of interest if the primary target is not encountered or is non-productive.',
    `spud_date` DATE COMMENT 'Date on which drilling operations officially commenced (bit penetrated ground or seafloor).',
    `state_province` STRING COMMENT 'State, province, or administrative region where the exploration well is located.',
    `surface_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the well surface location in decimal degrees (WGS84 datum).',
    `surface_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the well surface location in decimal degrees (WGS84 datum).',
    `target_formation` STRING COMMENT 'Primary geological formation or reservoir interval that the exploration well is designed to penetrate and evaluate.',
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
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Coring contractors are specialized drilling service vendors - enables vendor performance tracking, cost analysis, and contract management for coring operations. Role prefix distinguishes from other dr',
    `exploration_well_id` BIGINT COMMENT 'Foreign key reference to the exploration or appraisal well from which this core sample was acquired.',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Core samples are collected from wells drilled on leased acreage. Chain of custody, ownership rights, and regulatory reporting requirements tie samples to the underlying lease. Essential for data manag',
    `wellbore_id` BIGINT COMMENT 'Foreign key reference to the specific wellbore from which the core was cut, supporting multi-lateral or sidetrack scenarios.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` (
    `fluid_sample_id` BIGINT COMMENT 'Unique identifier for the reservoir fluid sample record. Primary key for the fluid sample entity.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Exploration well fluid samples are matched to crude grades for assay comparison, refinery compatibility assessment, and marketing. Business process: crude assay programs link DST/sample data to tradea',
    `exploration_well_id` BIGINT COMMENT 'Reference to the exploration or appraisal well from which this fluid sample was collected.',
    `formation_id` BIGINT COMMENT 'FK to exploration.formation',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Fluid samples are collected from wells on leased land. Ownership, regulatory reporting, and PVT analysis data rights are tied to lease agreements. Required for reservoir characterization and commercia',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: PVT laboratories are analytical service vendors - critical for vendor qualification, quality control, and invoice validation for reservoir fluid analysis services. Role prefix reflects specialized lab',
    `reservoir_id` BIGINT COMMENT 'Reference to the reservoir or formation from which the fluid sample was obtained.',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the liquid hydrocarbon phase, a measure of petroleum liquid density relative to water. Higher API gravity indicates lighter, less dense crude oil.',
    `c1_content_mole_percent` DECIMAL(18,2) COMMENT 'Mole percentage of methane (C1) in the fluid sample. Primary component of natural gas.',
    `c2_c5_content_mole_percent` DECIMAL(18,2) COMMENT 'Combined mole percentage of ethane, propane, butane, and pentane in the fluid sample. These components constitute natural gas liquids (NGL).',
    `c6_plus_content_mole_percent` DECIMAL(18,2) COMMENT 'Mole percentage of hexane and heavier hydrocarbons in the fluid sample. Represents the heavier liquid hydrocarbon fraction.',
    `co2_content_mole_percent` DECIMAL(18,2) COMMENT 'Mole percentage of carbon dioxide in the fluid sample. Important for corrosion assessment, processing requirements, and greenhouse gas accounting.',
    `collected_by` STRING COMMENT 'Name of the person, crew, or contractor who collected the fluid sample.',
    `collection_date` DATE COMMENT 'Date when the fluid sample was collected from the well or formation.',
    `collection_depth_md_m` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore at which the fluid sample was collected, expressed in meters.',
    `collection_depth_tvd_m` DECIMAL(18,2) COMMENT 'True vertical depth below a reference datum (typically mean sea level or rotary kelly bushing) at which the fluid sample was collected, expressed in meters.',
    `contamination_type` STRING COMMENT 'Type of contamination detected in the fluid sample, if any. Common contaminants include drilling mud filtrate, completion fluids, or formation water.. Valid values are `drilling_mud|completion_fluid|water|none|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fluid sample record was first created in the system.',
    `fluid_type` STRING COMMENT 'Classification of the reservoir fluid based on phase behavior and hydrocarbon composition. Black oil: low shrinkage, low GOR; volatile oil: high shrinkage, high GOR; gas condensate: retrograde condensation; dry gas: primarily methane; wet gas: gas with liquid dropout.. Valid values are `black_oil|volatile_oil|gas_condensate|dry_gas|wet_gas`',
    `gas_formation_volume_factor` DECIMAL(18,2) COMMENT 'Ratio of gas volume at reservoir conditions to gas volume at standard conditions. Accounts for pressure and temperature effects on gas volume.',
    `gas_specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the gas phase relative to air (air = 1.0). Indicates the molecular weight and composition of the reservoir gas.',
    `gor_scf_stb` DECIMAL(18,2) COMMENT 'Gas-oil ratio representing the volume of gas (at standard conditions) produced per barrel of oil (at stock tank conditions). Key parameter for reservoir fluid characterization and production forecasting.',
    `h2s_content_mole_percent` DECIMAL(18,2) COMMENT 'Mole percentage of hydrogen sulfide in the fluid sample. Critical for safety, corrosion management, and processing facility design.',
    `n2_content_mole_percent` DECIMAL(18,2) COMMENT 'Mole percentage of nitrogen in the fluid sample. Affects heating value and processing requirements.',
    `oil_formation_volume_factor` DECIMAL(18,2) COMMENT 'Ratio of oil volume at reservoir conditions to oil volume at stock tank conditions. Accounts for dissolved gas and thermal expansion effects.',
    `oil_viscosity_cp` DECIMAL(18,2) COMMENT 'Dynamic viscosity of the oil phase at reservoir conditions, measured in centipoise. Critical parameter for reservoir simulation and production performance prediction.',
    `pvt_analysis_date` DATE COMMENT 'Date when the PVT laboratory analysis was completed.',
    `pvt_report_reference` STRING COMMENT 'Reference number or identifier for the laboratory PVT analysis report document.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to the fluid sample collection or analysis.',
    `reservoir_pressure_psia` DECIMAL(18,2) COMMENT 'Pressure of the reservoir at the sample collection depth, measured in pounds per square inch absolute. Critical input for PVT analysis and fluid phase behavior.',
    `reservoir_temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the reservoir at the sample collection depth, measured in degrees Celsius. Critical input for PVT (Pressure Volume Temperature) analysis and phase behavior modeling.',
    `sample_number` STRING COMMENT 'Unique business identifier or label assigned to the fluid sample for tracking and laboratory reference purposes.',
    `sample_quality_flag` STRING COMMENT 'Assessment of whether the fluid sample is representative of reservoir conditions or has been contaminated during collection or handling.. Valid values are `representative|contaminated|questionable|not_assessed`',
    `sample_status` STRING COMMENT 'Current lifecycle status of the fluid sample from collection through laboratory analysis to archival.. Valid values are `collected|in_transit|received_at_lab|analysis_in_progress|analysis_complete|archived`',
    `sample_type` STRING COMMENT 'Classification of the fluid sample collection method. Bottomhole samples are collected downhole under reservoir conditions; surface recombined samples are reconstituted from separator gas and liquid; separator samples are collected at surface facilities; wellhead samples are collected at the wellhead; wireline formation tester samples are collected via formation testing tools.. Valid values are `bottomhole|surface_recombined|separator|wellhead|wireline_formation_tester`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the fluid sample collected, expressed in milliliters.',
    `sampling_tool_type` STRING COMMENT 'Type of downhole or surface sampling tool used to collect the fluid sample (e.g., wireline formation tester, drill stem test tool, separator sampling system).',
    `saturation_pressure_psia` DECIMAL(18,2) COMMENT 'Bubble point pressure for oil systems or dew point pressure for gas condensate systems. The pressure at which the first gas bubble forms (oil) or first liquid droplet forms (gas condensate) during pressure decline.',
    `saturation_pressure_type` STRING COMMENT 'Indicates whether the saturation pressure represents a bubble point (for oil systems) or dew point (for gas condensate systems).. Valid values are `bubble_point|dew_point|not_applicable`',
    `solution_gas_oil_ratio_scf_stb` DECIMAL(18,2) COMMENT 'Volume of gas dissolved in oil at reservoir conditions, expressed as standard cubic feet of gas per stock tank barrel of oil. Key parameter for material balance calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fluid sample record was last modified in the system.',
    `water_content_ppm` DECIMAL(18,2) COMMENT 'Water content in the fluid sample expressed in parts per million by weight. Important for hydrate formation prediction and processing design.',
    CONSTRAINT pk_fluid_sample PRIMARY KEY(`fluid_sample_id`)
) COMMENT 'Master record for reservoir fluid samples (PVT samples) collected during exploration well testing. Captures sample type (bottomhole/surface recombined), collection depth, collection date, reservoir temperature, reservoir pressure, fluid type (black oil/volatile oil/gas condensate/dry gas), API gravity, GOR, saturation pressure (bubble/dew point), viscosity, and PVT analysis laboratory. Feeds PVT modeling in reservoir domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin where the exploration campaign is being conducted.',
    `company_code_id` BIGINT COMMENT 'Reference to the operating company responsible for executing the exploration campaign under the joint operating agreement.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Exploration campaigns require regulatory submissions for work program approvals, environmental assessments, and results reporting to licensing authorities. Licensing obligation and compliance tracking',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Exploration campaigns are cost objects; all campaign costs (wells, seismic, G&G) are tracked to cost centers for accounting and JV billing. Required for cost control and financial reporting in multi-w',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor responsible for overall campaign management and execution.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Exploration campaigns (multi-well programs) are authorized via AFEs; the existing afe_number attribute is denormalized. Proper FK enables campaign-level cost tracking, budget control, and JV partner a',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Multi-well exploration campaigns operate under JOA governance requiring partner approval of work programs and budgets. Links campaign planning to JOA voting thresholds, non-consent provisions, and cos',
    `joint_venture_id` BIGINT COMMENT 'Reference to the joint venture or partnership arrangement under which the campaign is being conducted.',
    `jv_budget_id` BIGINT COMMENT 'Foreign key linking to venture.jv_budget. Business justification: Exploration campaigns are planned within annual JV budgets approved by operating committees. Links campaign execution to approved budget envelope, enabling variance tracking and supplemental AFE trigg',
    `block_id` BIGINT COMMENT 'Reference to the exploration license or block where the campaign activities are authorized.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Exploration campaigns target specific hydrocarbon product types for portfolio strategy and capital allocation. Business process: campaigns are funded based on product-type portfolio targets (e.g., lig',
    `actual_end_date` DATE COMMENT 'Actual date when campaign field operations were completed.',
    `actual_seismic_survey_km` DECIMAL(18,2) COMMENT 'Actual length of 2D seismic lines or area coverage of 3D seismic surveys acquired in square kilometers.',
    `actual_spend_mm_usd` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred on the campaign to date in millions of USD.',
    `actual_start_date` DATE COMMENT 'Actual date when campaign field operations commenced.',
    `actual_well_count` STRING COMMENT 'Number of wells actually drilled or in progress as part of this campaign.',
    `afe_approval_date` DATE COMMENT 'Date when the AFE for this campaign was formally approved by the operating committee or management.',
    `campaign_code` STRING COMMENT 'Unique alphanumeric code assigned to the campaign for system integration and cross-reference with AFE and JIB systems.',
    `campaign_name` STRING COMMENT 'Business name of the exploration campaign for identification and reporting purposes.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the exploration campaign indicating its operational state and approval stage.. Valid values are `planning|approved|active|suspended|completed|cancelled`',
    `campaign_type` STRING COMMENT 'Classification of the exploration campaign by primary activity type: seismic survey, drilling program, geochemical sampling, integrated multi-discipline, or appraisal campaign.. Valid values are `seismic|drilling|geochemical|integrated|appraisal`',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the jurisdiction where the campaign is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was first created in the system.',
    `data_acquisition_contractor` STRING COMMENT 'Name of the primary contractor responsible for seismic data acquisition, drilling services, or geochemical sampling.',
    `environmental_permit_status` STRING COMMENT 'Status of environmental permits and regulatory approvals required for campaign execution.. Valid values are `not_required|pending|approved|conditional|denied`',
    `estimated_eur_p50_mmboe` DECIMAL(18,2) COMMENT 'P50 (median) estimate of ultimate recoverable resources expected from successful campaign outcomes, expressed in million barrels of oil equivalent.',
    `geological_chance_of_success_pct` DECIMAL(18,2) COMMENT 'Estimated probability of geological success for the campaign, expressed as a percentage, based on prospect risk analysis.',
    `hse_plan_approved_flag` BOOLEAN COMMENT 'Indicates whether the HSE management plan for the campaign has been formally approved by regulatory authorities and internal governance.',
    `hydrocarbon_type` STRING COMMENT 'Expected hydrocarbon type targeted by the exploration campaign based on geological assessment.. Valid values are `oil|gas|condensate|mixed`',
    `interpretation_software_platform` STRING COMMENT 'Primary software platform used for geological and geophysical interpretation of campaign data (e.g., Petrel, DecisionSpace, Kingdom).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was most recently modified.',
    `objective` STRING COMMENT 'Primary business and technical objectives of the exploration campaign, including target plays, resource assessment goals, and strategic rationale.',
    `planned_end_date` DATE COMMENT 'Scheduled date for completion of all campaign field activities and data acquisition.',
    `planned_seismic_survey_km` DECIMAL(18,2) COMMENT 'Total planned length of 2D seismic lines or area coverage of 3D seismic surveys in square kilometers for seismic campaigns.',
    `planned_start_date` DATE COMMENT 'Scheduled date for commencement of campaign field activities.',
    `planned_well_count` STRING COMMENT 'Number of exploration or appraisal wells planned to be drilled as part of this campaign.',
    `priority_rank` STRING COMMENT 'Relative priority ranking of this campaign within the exploration portfolio for resource allocation and scheduling purposes.',
    `prms_resource_class` STRING COMMENT 'PRMS classification of resources targeted by the campaign: prospective resources (pre-drill), contingent resources (discovered but not commercial), or reserves (commercial).. Valid values are `prospective|contingent|reserves`',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Composite risk score for the campaign based on geological, operational, HSE, and commercial risk factors, typically on a 0-100 scale.',
    `seismic_survey_type` STRING COMMENT 'Type of seismic survey technology employed in the campaign: 2D, 3D, 4D time-lapse, ocean bottom seismic, or vertical seismic profile.. Valid values are `2D|3D|4D|ocean_bottom|VSP`',
    `target_play_type` STRING COMMENT 'Geological play type being targeted by the campaign (e.g., structural trap, stratigraphic trap, combination trap).',
    `total_budget_capex_mm_usd` DECIMAL(18,2) COMMENT 'Total approved capital expenditure budget for the exploration campaign in millions of USD, covering all drilling, seismic, and support costs.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage working interest held by the operator or reporting entity in this exploration campaign.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master record for multi-well or multi-survey exploration campaigns within a basin or license area. Captures campaign name, campaign type (seismic/drilling/geochemical), target basin/block, planned start and end dates, total campaign budget (CAPEX), number of planned wells or survey km, campaign objectives, approval status (AFE reference), and campaign manager. Supports portfolio-level exploration program planning and budget tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` (
    `geochemical_sample_id` BIGINT COMMENT 'Unique identifier for the geochemical sample record. Primary key for the geochemical sample entity.',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin in which the geochemical sample was collected.',
    `exploration_well_id` BIGINT COMMENT 'Reference to the well from which the sample was collected, applicable for subsurface drilling samples.',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Geochemical samples are collected from specific formations. Currently geochemical_sample has formation_name (STRING) and geological_age (STRING); formation_name should be replaced with a FK to the for',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Geochemical laboratories are analytical service vendors - enables vendor performance tracking, quality assurance, and procurement management for source rock and maturity analysis services. Removes den',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Geochemical samples are collected on leased acreage (surface or wellbore). Surface access rights and sample ownership are governed by lease terms. Required for source rock studies and play fairway map',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Source rock geochemistry predicts expelled hydrocarbon product type (oil vs gas, API gravity range) for basin modeling and play assessment. Business process: petroleum systems analysis uses geochemica',
    `prospect_id` BIGINT COMMENT 'Reference to the exploration prospect associated with this geochemical sample collection.',
    `seismic_survey_id` BIGINT COMMENT 'Reference to the geochemical survey or sampling program under which this sample was collected.',
    `analysis_date` DATE COMMENT 'Date when the laboratory analysis was completed and results were finalized.',
    `analytical_method` STRING COMMENT 'Laboratory analytical method or technique used to analyze the geochemical sample (e.g., Rock-Eval, GC-MS, isotope analysis).',
    `collection_date` DATE COMMENT 'The date when the geochemical sample was collected in the field or during drilling operations.',
    `collection_depth_m` DECIMAL(18,2) COMMENT 'Depth at which the geochemical sample was collected, measured in meters below surface or below a specified datum.',
    `collection_timestamp` TIMESTAMP COMMENT 'Precise date and time when the geochemical sample was collected, including timezone information for accurate temporal analysis.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or contextual information about the sample collection or analysis.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the country where the geochemical sample was collected.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the geochemical sample record was first created in the system.',
    `depth_reference` STRING COMMENT 'Reference datum from which the collection depth is measured (surface, kelly bushing, rotary table, mean sea level, ground level).. Valid values are `surface|kelly_bushing|rotary_table|mean_sea_level|ground_level`',
    `geological_age` STRING COMMENT 'Geological age or epoch of the formation from which the sample was collected (e.g., Jurassic, Cretaceous, Tertiary).',
    `hydrocarbon_potential` STRING COMMENT 'Qualitative assessment of the samples hydrocarbon generation potential based on TOC, HI, and maturity indicators.. Valid values are `poor|fair|good|very_good|excellent`',
    `hydrogen_index_hi` DECIMAL(18,2) COMMENT 'Hydrogen index from Rock-Eval pyrolysis, expressed as mg HC/g TOC, indicating hydrocarbon generation potential.',
    `kerogen_type` STRING COMMENT 'Classification of organic matter type (Type I, II, III, IV, or mixed) based on HI/OI ratios and visual kerogen analysis.. Valid values are `type_i|type_ii|type_iii|type_iv|mixed`',
    `laboratory_reference_number` STRING COMMENT 'Laboratory-assigned reference or job number for tracking the sample through the analytical workflow.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the sample collection location in decimal degrees (WGS84 datum).',
    `lithology` STRING COMMENT 'Rock type or sediment composition of the sample (e.g., sandstone, shale, limestone, mudstone).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the sample collection location in decimal degrees (WGS84 datum).',
    `measured_depth_m` DECIMAL(18,2) COMMENT 'Measured depth along the wellbore trajectory where the sample was collected, applicable for subsurface drilling samples.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the geochemical sample record was last modified or updated.',
    `oxygen_index_oi` DECIMAL(18,2) COMMENT 'Oxygen index from Rock-Eval pyrolysis, expressed as mg CO2/g TOC, used to classify kerogen type.',
    `preservation_method` STRING COMMENT 'Method used to preserve the sample during transport and storage (e.g., refrigeration, freezing, chemical preservative).',
    `quality_flag` STRING COMMENT 'Quality control flag indicating whether the sample and analysis results meet quality standards.. Valid values are `passed|failed|suspect|reanalysis_required`',
    `s1_mg_hc_per_g_rock` DECIMAL(18,2) COMMENT 'S1 peak from Rock-Eval pyrolysis representing free hydrocarbons already present in the rock.',
    `s2_mg_hc_per_g_rock` DECIMAL(18,2) COMMENT 'S2 peak from Rock-Eval pyrolysis representing hydrocarbons generated by thermal cracking of kerogen.',
    `s3_mg_co2_per_g_rock` DECIMAL(18,2) COMMENT 'S3 peak from Rock-Eval pyrolysis representing CO2 generated from kerogen, used to calculate oxygen index.',
    `sample_number` STRING COMMENT 'Externally-known unique business identifier for the geochemical sample, typically assigned by the laboratory or field collection team.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sample_status` STRING COMMENT 'Current lifecycle status of the geochemical sample in the laboratory and analysis workflow.. Valid values are `collected|in_transit|received|analyzed|archived`',
    `sample_type` STRING COMMENT 'Classification of the geochemical sample based on the material collected (soil gas, water, cutting, core, outcrop, seep).. Valid values are `soil_gas|water|cutting|core|outcrop|seep`',
    `sample_weight_g` DECIMAL(18,2) COMMENT 'Weight of the geochemical sample in grams as received by the laboratory.',
    `thermal_maturity_stage` STRING COMMENT 'Thermal maturity classification of the organic matter (immature, early mature, peak mature, late mature, post-mature, overmature).. Valid values are `immature|early_mature|peak_mature|late_mature|post_mature|overmature`',
    `tmax_celsius` DECIMAL(18,2) COMMENT 'Temperature at maximum hydrocarbon generation (Tmax) from Rock-Eval pyrolysis, a thermal maturity indicator.',
    `toc_percent` DECIMAL(18,2) COMMENT 'Total organic carbon content of the sample expressed as weight percentage, a key indicator of source rock potential.',
    `true_vertical_depth_m` DECIMAL(18,2) COMMENT 'True vertical depth from surface to the sample collection point, corrected for wellbore deviation.',
    `vitrinite_reflectance_ro` DECIMAL(18,2) COMMENT 'Vitrinite reflectance measurement (Ro) indicating thermal maturity of organic matter, critical for hydrocarbon generation assessment.',
    CONSTRAINT pk_geochemical_sample PRIMARY KEY(`geochemical_sample_id`)
) COMMENT 'Master record for geochemical samples collected during surface or subsurface exploration programs. Captures sample type (soil gas, water, cutting, outcrop), collection location (lat/long), collection depth, collection date, analytical method, total organic carbon (TOC), vitrinite reflectance (Ro), hydrogen index (HI), oxygen index (OI), thermal maturity indicator, and laboratory reference. Supports source rock evaluation and hydrocarbon system analysis.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`discovery` (
    `discovery_id` BIGINT COMMENT 'Primary key for discovery',
    `basin_id` BIGINT COMMENT 'Reference to the sedimentary basin containing the discovery.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Oil discoveries are characterized by crude grade (API, sulfur) for commerciality assessment and regulatory notification. Business process: discovery declarations to government specify crude grade for ',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Discovery records require linkage to drilling execution for regulatory notification, reserves booking, AFE cost allocation, and commercial evaluation. Complements existing discovery_well_id (explorati',
    `employee_id` BIGINT COMMENT 'Reference to the lead geologist responsible for the discovery evaluation and declaration.',
    `block_id` BIGINT COMMENT 'Reference to the exploration license or block within which the discovery was made.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Discoveries must classify hydrocarbon product type (oil, gas, condensate, NGL) for reserve booking, regulatory reporting, and commerciality decisions. Real process: discovery evaluation reports specif',
    `play_id` BIGINT COMMENT 'Reference to the geological play within which the discovery was made.',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Discovery events must link to producing well assets for reserves booking, commerciality declarations, regulatory notifications, and field development planning. Role prefix producing distinguishes fr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Discoveries that achieve commerciality become profit centers for P&L tracking; each discovery is tracked as a profit center for revenue, cost, and profitability reporting. Essential for asset-level fi',
    `prospect_id` BIGINT COMMENT 'Reference to the prospect that was being tested when the discovery was made.',
    `formation_id` BIGINT COMMENT 'Foreign key linking to exploration.formation. Business justification: Discoveries are made in specific reservoir formations. Currently discovery has reservoir_formation (STRING) and reservoir_age (STRING); these should be replaced with a FK to the formation master to en',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`block_interest` (
    `block_interest_id` BIGINT COMMENT 'Primary key for block_interest',
    `block_id` BIGINT COMMENT 'Reference to the exploration block or license area in which the partner holds interest. Links to the exploration block master data.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement (JOA) governing the partners rights and obligations in the exploration block. Links to the JOA master data in the joint venture domain.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the partner company (IOC, NOC, or independent) holding working interest in the exploration block. Links to the partner company master data.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement (PSA) governing the partners rights and obligations in the exploration block. Links to the PSA master data in the joint venture domain. Null if JOA applies instead.',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Exploration block partner interests transition to production-phase venture working interests upon discovery/development. Links exploration-phase ownership to production-phase entitlements for continui',
    `approval_status` STRING COMMENT 'Regulatory or joint venture approval status for the partners interest. Approved indicates all necessary approvals obtained; pending awaits decision; rejected indicates denial; conditional requires additional steps; not required if no approval needed.. Valid values are `approved|pending_approval|rejected|conditional_approval|not_required`',
    `area_of_mutual_interest_flag` BOOLEAN COMMENT 'Indicates whether the partner is subject to an Area of Mutual Interest (AMI) clause (True), requiring them to offer participation to other partners for opportunities within a defined geographic area.',
    `back_in_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of additional working interest the partner can acquire if back-in rights are exercised. Null if no back-in right exists.',
    `back_in_right_flag` BOOLEAN COMMENT 'Indicates whether the partner has a back-in right (True) to increase their working interest upon commercial discovery or other triggering event.',
    `billing_entity_code` BIGINT COMMENT 'Reference to the entity responsible for joint interest billing (JIB) for this partners share of exploration costs. Typically the operator. Links to the partner company master data.',
    `carried_cost_limit_usd` DECIMAL(18,2) COMMENT 'Maximum amount in US dollars that the partner is carried for exploration costs. Null if not applicable or unlimited carry.',
    `carried_interest_flag` BOOLEAN COMMENT 'Indicates whether the partner is carried (True) or not carried (False) for exploration costs. Carried partners do not pay their proportionate share of costs until certain conditions are met (e.g., commercial discovery, payout).',
    `carried_phase` STRING COMMENT 'Phase of operations during which the partner is carried. Common values include exploration, appraisal, development, production, or none if no carry arrangement exists.. Valid values are `exploration|appraisal|development|production|none`',
    `consent_required_flag` BOOLEAN COMMENT 'Indicates whether the partners explicit consent is required (True) for major exploration decisions (e.g., drilling authorization, AFE approval) or if majority vote suffices (False).',
    `cost_allocation_method` STRING COMMENT 'Method by which exploration costs are allocated to the partner. Proportionate allocates costs by working interest; carried exempts partner from costs; farmout applies to farmed-out interests; area of mutual interest applies to AMI arrangements.. Valid values are `proportionate|carried|farmout|area_of_mutual_interest`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the jurisdiction in which the exploration block is located. Used for regulatory and fiscal regime alignment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this block interest record was first created in the system. Audit trail for data lineage and compliance.',
    `default_interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to overdue joint interest billing (JIB) payments. Specified in the JOA or PSA.',
    `effective_date` DATE COMMENT 'Date on which the partners interest in the exploration block became effective. Typically the JOA or PSA execution date or regulatory approval date.',
    `expiration_date` DATE COMMENT 'Date on which the partners interest in the exploration block expires or is scheduled to terminate. Null for indefinite or production-phase interests.',
    `farmout_agreement_flag` BOOLEAN COMMENT 'Indicates whether the partners interest was acquired via a farmout agreement (True), where the farmee earns interest by funding exploration activities on behalf of the farmor.',
    `farmout_earn_in_percent` DECIMAL(18,2) COMMENT 'Percentage of working interest the partner can earn by fulfilling farmout agreement obligations (e.g., drilling a well, funding seismic). Null if not a farmout arrangement.',
    `fiscal_regime_type` STRING COMMENT 'Type of fiscal regime governing the exploration block. Concession (royalty/tax), PSC (Production Sharing Contract), RSC (Risk Service Contract), service contract, or hybrid.. Valid values are `concession|psc|rsc|service_contract|hybrid`',
    `interest_status` STRING COMMENT 'Current lifecycle status of the partners interest in the exploration block. Active indicates current participation; pending awaits regulatory approval; suspended is temporarily inactive; relinquished or transferred indicates exit; expired indicates license expiration.. Valid values are `active|pending|suspended|relinquished|transferred|expired`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this block interest record was last updated. Audit trail for data lineage and compliance.',
    `net_revenue_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest (NRI) held by the partner after deducting royalties, overriding royalty interest (ORRI), and other burdens. Represents the partners share of production revenue.',
    `non_consent_option_flag` BOOLEAN COMMENT 'Indicates whether the partner has the right to elect non-consent (True) on proposed exploration operations, thereby avoiding cost participation but forfeiting interest in the operation.',
    `participating_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of participating interest in exploration activities and decision-making. May differ from working interest if carried interest arrangements exist.',
    `partner_category` STRING COMMENT 'Business classification of the partner organization. IOC (International Oil Company), NOC (National Oil Company), independent, service company, government entity, or private equity.. Valid values are `ioc|noc|independent|service_company|government_entity|private_equity`',
    `partner_type` STRING COMMENT 'Classification of the partner role in the joint venture. Operator manages day-to-day operations; non-operator is a passive investor.. Valid values are `operator|non-operator`',
    `payment_terms_days` STRING COMMENT 'Number of days within which the partner must pay their share of joint interest billings (JIB). Typically 30, 45, or 60 days per JOA terms.',
    `preferential_right_flag` BOOLEAN COMMENT 'Indicates whether the partner has preferential rights (True) to acquire additional interest if another partner wishes to sell or relinquish their interest.',
    `regulatory_approval_date` DATE COMMENT 'Date on which regulatory authorities (BOEM, BSEE, or equivalent) approved the partners interest in the exploration block. Null if approval not required or still pending.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for the regulatory approval document or decision. Null if not applicable.',
    `relinquishment_date` DATE COMMENT 'Date on which the partner voluntarily relinquished their interest in the exploration block. Null if interest is still active or was transferred.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special conditions, or clarifications regarding the partners interest in the exploration block.',
    `transfer_date` DATE COMMENT 'Date on which the partners interest was transferred to another party. Null if interest is still held or was relinquished.',
    `voting_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of voting rights held by the partner in joint venture decisions. May differ from working interest in some PSA or JOA structures.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of working interest (WI) held by the partner in the exploration block. Represents the partners share of capital expenditure (CAPEX) and operating expenditure (OPEX) obligations.',
    CONSTRAINT pk_block_interest PRIMARY KEY(`block_interest_id`)
) COMMENT 'Association record capturing working interest (WI) and participating interest ownership of exploration blocks and licenses by partner companies (IOCs, NOCs, independents). Captures partner company name, partner type (operator/non-operator), working interest percentage (WI%), net revenue interest (NRI%), carried interest flag, effective date, and partner approval status. Supports JOA/PSA partner management and JIB cost allocation for exploration activities. Complements the venture domains JOA records.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`well_result` (
    `well_result_id` BIGINT COMMENT 'Primary key for well_result',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks the geologist who performed post-drill evaluation. Essential for lessons-learned analysis, competency assessment, and discovery success tracking by individual. Replaces denormalized evaluation_',
    `exploration_well_id` BIGINT COMMENT 'Foreign key reference to the exploration or appraisal well that was drilled and evaluated. Links to the well master data product.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Well results classify encountered hydrocarbons by product type for reserve booking and regulatory reporting. Business process: post-drill evaluation reports to government and JV partners specify produ',
    `prospect_id` BIGINT COMMENT 'Foreign key reference to the prospect that this well was drilled to test. Used to update prospect status and resource estimates post-drill.',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator of whether this well result record is currently active and should be included in reporting and analytics. False indicates the record has been superseded or archived.',
    `api_gravity_degrees` DECIMAL(18,2) COMMENT 'The API gravity of the crude oil sample, measured in degrees API. Higher values indicate lighter, more valuable crude. Measured from fluid samples collected during testing.',
    `average_permeability_md` DECIMAL(18,2) COMMENT 'The arithmetic average permeability across all net pay intervals, measured in millidarcies. Derived from core analysis, well test analysis, or log-derived estimates. Critical for productivity assessment.',
    `average_porosity_percent` DECIMAL(18,2) COMMENT 'The arithmetic average porosity across all net pay intervals, expressed as a percentage. Derived from wireline logs and core analysis. Key input for volumetric calculations.',
    `average_water_saturation_percent` DECIMAL(18,2) COMMENT 'The arithmetic average water saturation across all net pay intervals, expressed as a percentage. Hydrocarbon saturation equals 100 minus water saturation. Derived from resistivity logs and capillary pressure data.',
    `business_unit` STRING COMMENT 'The exploration business unit or operating division responsible for this well and prospect. Used for organizational reporting and performance tracking.',
    `classification` STRING COMMENT 'The formal classification of the well outcome based on post-drill evaluation. Discovery indicates commercial hydrocarbon accumulation found; dry hole indicates no hydrocarbons; shows only indicates non-commercial hydrocarbon presence; technical success indicates objectives met but commercial viability uncertain.. Valid values are `discovery|dry_hole|shows_only|technical_success|suspended|abandoned`',
    `commercial_success_flag` BOOLEAN COMMENT 'Boolean indicator of whether the well discovered commercially viable hydrocarbons that justify development investment. True indicates positive economic evaluation.',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code where the well is located. Used for regulatory reporting and geographic analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this well result evaluation record was first created in the system. Used for audit trail and data lineage tracking.',
    `discovery_declaration_date` DATE COMMENT 'The date when the discovery was formally declared to regulatory authorities and joint venture partners. Nullable if well was not a commercial discovery. Triggers regulatory reporting obligations.',
    `discovery_flag` BOOLEAN COMMENT 'Boolean indicator of whether this well resulted in a commercial hydrocarbon discovery. True triggers discovery declaration workflow and regulatory reporting requirements.',
    `dst_test_conducted_flag` BOOLEAN COMMENT 'Boolean indicator of whether a drill stem test was conducted to measure reservoir pressure, permeability, and fluid properties. True indicates dynamic reservoir data is available.',
    `evaluation_petrophysicist_name` STRING COMMENT 'The name of the lead petrophysicist responsible for formation evaluation, log interpretation, and reservoir property assessment.',
    `evaluation_reservoir_engineer_name` STRING COMMENT 'The name of the lead reservoir engineer responsible for well test analysis, productivity assessment, and EUR estimation.',
    `formation_evaluation_summary` STRING COMMENT 'Narrative summary of the formation evaluation results including wireline log interpretation, core analysis findings, fluid sampling results, and well test conclusions. Provides qualitative context for quantitative measurements.',
    `gas_oil_ratio_scf_per_bbl` DECIMAL(18,2) COMMENT 'The ratio of gas volume to oil volume produced, measured in standard cubic feet per barrel. Measured from drill stem test or initial production test. Critical for fluid characterization and facilities design.',
    `geological_success_flag` BOOLEAN COMMENT 'Boolean indicator of whether the well achieved its geological objectives (e.g., encountered predicted reservoir, confirmed trap closure). True indicates geological model was validated regardless of commercial outcome.',
    `gross_pay_thickness_ft` DECIMAL(18,2) COMMENT 'The total thickness in feet of all reservoir intervals encountered, including both net pay and non-pay intervals within the hydrocarbon-bearing formation.',
    `hydrocarbon_type_encountered` STRING COMMENT 'The type of hydrocarbon encountered during drilling and formation evaluation. Mixed indicates both oil and gas present in commercial quantities.. Valid values are `oil|gas|condensate|ngl|mixed|none`',
    `initial_production_rate_bopd` DECIMAL(18,2) COMMENT 'The initial production rate measured in barrels of oil per day during the first production test. Key indicator of well productivity and used for decline curve analysis.',
    `initial_production_rate_mcfd` DECIMAL(18,2) COMMENT 'The initial gas production rate measured in thousand cubic feet per day during the first production test. Used for gas well productivity assessment.',
    `initial_reservoir_pressure_psi` DECIMAL(18,2) COMMENT 'The virgin reservoir pressure measured in pounds per square inch at the time of discovery, typically from drill stem test or wireline formation tester. Critical for reservoir drive mechanism assessment and production forecasting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this well result evaluation record was last updated. Used for audit trail and change tracking.',
    `net_pay_thickness_ft` DECIMAL(18,2) COMMENT 'The cumulative thickness in feet of reservoir intervals that meet minimum cutoff criteria for porosity, permeability, and hydrocarbon saturation. Key metric for reservoir quality assessment.',
    `number_of_pay_intervals` STRING COMMENT 'The count of distinct reservoir intervals that meet net pay criteria. Multiple pay zones indicate stacked reservoir potential.',
    `post_drill_eur_p10_mmboe` DECIMAL(18,2) COMMENT 'The revised P10 (high estimate, 10% probability of exceeding) estimate of ultimate recoverable hydrocarbons in million barrels of oil equivalent, based on actual well results.',
    `post_drill_eur_p50_mmboe` DECIMAL(18,2) COMMENT 'The revised P50 (median, 50% probability) estimate of ultimate recoverable hydrocarbons in million barrels of oil equivalent, updated based on actual well results. Used to update prospect and play resource assessments.',
    `post_drill_eur_p90_mmboe` DECIMAL(18,2) COMMENT 'The revised P90 (low estimate, 90% probability of exceeding) estimate of ultimate recoverable hydrocarbons in million barrels of oil equivalent, based on actual well results.',
    `pressure_gradient_psi_per_ft` DECIMAL(18,2) COMMENT 'The rate of pressure increase with depth, measured in psi per foot. Used to determine fluid type and reservoir connectivity. Normal hydrostatic gradient is approximately 0.433 psi/ft for water.',
    `primary_reservoir_formation` STRING COMMENT 'The name of the primary geological formation that contains the hydrocarbon accumulation. Used for play-level correlation and analogue analysis.',
    `prms_resource_class_post_drill` STRING COMMENT 'The updated PRMS resource classification after well results are incorporated. 1P represents proved reserves, 2P represents proved plus probable, 3P represents proved plus probable plus possible. Contingent resources require further evaluation before development.. Valid values are `1P|2P|3P|contingent|prospective|unrecoverable`',
    `recommendation_code` STRING COMMENT 'The formal recommendation for next steps based on well results. Appraise indicates additional wells needed to delineate discovery; develop indicates commercial development justified; abandon indicates no further activity; suspend indicates temporary deferral; sidetrack indicates drilling additional wellbore from existing well.. Valid values are `appraise|develop|abandon|suspend|sidetrack`',
    `recommendation_rationale` STRING COMMENT 'Narrative explanation of the technical and commercial rationale supporting the recommendation code. Includes discussion of reservoir quality, resource size, development costs, and economic viability.',
    `regulatory_authority` STRING COMMENT 'The name of the government agency or regulatory body with jurisdiction over this well and discovery. Examples include BSEE, BOEM, state oil and gas commissions, or national oil ministries.',
    `reservoir_temperature_f` DECIMAL(18,2) COMMENT 'The bottom hole temperature measured in degrees Fahrenheit at the reservoir depth. Critical for PVT analysis and production system design.',
    `result_evaluation_date` DATE COMMENT 'The date when the formal post-drill well result evaluation was completed and documented. This is the business event date for the well result classification.',
    `secondary_reservoir_formation` STRING COMMENT 'The name of any secondary geological formation encountered with hydrocarbon shows or pay. Nullable if only one formation was productive.',
    CONSTRAINT pk_well_result PRIMARY KEY(`well_result_id`)
) COMMENT 'Transactional record capturing the formal post-drill well result evaluation for an exploration or appraisal well. Captures result date, well result classification (discovery/dry hole/shows only/technical success), pay zone summary (net pay thickness, number of pay intervals), hydrocarbon type encountered, pressure data (initial reservoir pressure, pressure gradient), formation evaluation summary, recommendation (appraise/develop/abandon), and post-drill resource estimate revision. Triggers prospect status update and discovery declaration workflow.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` (
    `campaign_vendor_engagement_id` BIGINT COMMENT 'Unique identifier for this campaign-vendor engagement record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the exploration campaign that engaged this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing services or supplies to this campaign',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual expenditure incurred for this vendor on this campaign to date in USD, as identified in the detection phase relationship data.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the contract or purchase order governing this vendor engagement for the campaign, as identified in the detection phase relationship data.',
    `contracted_value` DECIMAL(18,2) COMMENT 'Total contracted value in USD for this vendors services or supplies on this campaign, as identified in the detection phase relationship data.',
    `end_date` DATE COMMENT 'Date when this vendor completed or is scheduled to complete their work or delivery for this campaign, as identified in the detection phase relationship data.',
    `engagement_status` STRING COMMENT 'Current status of this vendor engagement on this campaign, tracking the lifecycle of the vendor relationship within the campaign context.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Performance rating score assigned to this vendor for their work on this specific campaign, used for vendor evaluation and future selection decisions, as identified in the detection phase relationship data.',
    `scope_of_work` STRING COMMENT 'Detailed description of the scope of work, deliverables, or services contracted from this vendor for this specific campaign, as identified in the detection phase relationship data.',
    `service_type` STRING COMMENT 'Classification of the type of service or supply provided by the vendor to this campaign, as identified in the detection phase relationship data.',
    `start_date` DATE COMMENT 'Date when this vendor commenced work or delivery of services/supplies for this campaign, as identified in the detection phase relationship data.',
    CONSTRAINT pk_campaign_vendor_engagement PRIMARY KEY(`campaign_vendor_engagement_id`)
) COMMENT 'This association product represents the contractual engagement between an exploration campaign and a vendor providing services or supplies. It captures the specific scope, contract terms, performance, and financial details that exist only in the context of a particular campaign-vendor relationship. Each record links one campaign to one vendor with attributes describing the nature and outcomes of that specific engagement.. Existence Justification: In oil and gas exploration operations, campaigns routinely engage multiple vendors simultaneously for different services (seismic contractors, drilling contractors, environmental consultants, logistics providers, equipment suppliers). Each vendor participates in multiple campaigns across different basins, license blocks, and time periods. Campaign managers actively manage these vendor engagements, tracking contract terms, scope, spend, and performance ratings specific to each campaign-vendor combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` (
    `seismic_contract_line_item_id` BIGINT COMMENT 'Unique identifier for this seismic survey contract line item record. Primary key for the association.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract that governs this seismic survey delivery. Identifies the master service agreement, acquisition contract, or processing contract under which this survey work is performed.',
    `seismic_survey_id` BIGINT COMMENT 'Foreign key linking to the seismic survey that is covered under this contract line item. Identifies which surveys acquisition or processing services are governed by this contractual relationship.',
    `acceptance_date` DATE COMMENT 'Date when the seismic deliverable for this survey was formally accepted by Oil Gas technical team. Triggers final payment release and closes the line item delivery obligation.',
    `acceptance_status` STRING COMMENT 'Current acceptance status of the seismic deliverable for this survey under this contract line item. Pending indicates deliverable not yet submitted, under_review indicates technical QC in progress, accepted indicates deliverable meets contract specifications, conditionally_accepted indicates minor deficiencies with agreed remediation, rejected indicates deliverable fails to meet contract quality standards and requires rework.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the seismic data deliverable for this survey was completed and delivered by the contractor. Used to assess schedule performance and determine if late delivery penalties apply.',
    `actual_km_delivered` DECIMAL(18,2) COMMENT 'Actual line kilometers of seismic data delivered by the contractor for this survey under this contract line item. Used to calculate payment, assess contractor performance, and identify scope variances.',
    `contract_line_item_number` STRING COMMENT 'Business identifier for this line item within the parent procurement contract. Used for referencing specific survey deliverables in contract documentation and invoicing (e.g., Line 3.2, Survey Deliverable A).',
    `contracted_km` DECIMAL(18,2) COMMENT 'Total line kilometers of seismic data contracted to be acquired or processed under this line item. Represents the committed deliverable quantity against which actual delivery and payment are measured.',
    `delivery_milestone_date` DATE COMMENT 'Contractually committed date by which the seismic data deliverable for this survey must be completed and delivered by the contractor. Used to track schedule compliance and trigger milestone payments or liquidated damages.',
    `invoice_reference` STRING COMMENT 'Reference to the vendor invoice(s) submitted for payment against this contract line item. Links the contractual deliverable to accounts payable processing.',
    `line_item_value_usd` DECIMAL(18,2) COMMENT 'Total monetary value in United States Dollars for this contract line item, calculated as contracted_km × unit_rate_per_km or as a lump sum for fixed-price deliverables. Represents the financial commitment for this survey under this contract.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context about this survey-contract relationship, including scope changes, delivery issues, quality concerns, or commercial negotiations specific to this line item.',
    `payment_status` STRING COMMENT 'Current payment status for this contract line item. Not_invoiced indicates deliverable not yet billed, invoiced indicates invoice received and under review, paid indicates full payment released, partially_paid indicates milestone or progress payment made, disputed indicates payment held due to quality or scope disagreement.',
    `rejection_reason` STRING COMMENT 'Description of technical or quality deficiencies that led to rejection of the seismic deliverable. Documents non-conformance with contract specifications (e.g., Signal-to-noise ratio below contracted threshold, Incomplete line coverage in NE quadrant).',
    `survey_scope_description` STRING COMMENT 'Detailed description of the seismic work scope covered under this contract line item for this specific survey. Defines what acquisition or processing services the contractor is obligated to deliver (e.g., 3D marine acquisition 500 sq km, Pre-stack depth migration processing).',
    `unit_rate_per_km` DECIMAL(18,2) COMMENT 'Contracted unit rate in USD per line kilometer for seismic acquisition or processing services under this line item. Used to calculate line item value based on actual kilometers delivered.',
    CONSTRAINT pk_seismic_contract_line_item PRIMARY KEY(`seismic_contract_line_item_id`)
) COMMENT 'This association product represents the contractual line item relationship between seismic surveys and procurement contracts in the oil and gas exploration business. It captures the commercial and delivery terms for seismic data acquisition or processing services delivered under a specific contract for a specific survey. Each record links one seismic survey to one procurement contract with attributes that exist only in the context of this contractual relationship, including scope definition, contracted versus actual deliverables, unit rates, milestone dates, and acceptance status. This is a core operational entity managed by both exploration and procurement teams to track multi-survey master service agreements and phased contract execution.. Existence Justification: In oil and gas exploration operations, seismic surveys are commonly delivered under multi-survey master service agreements where one procurement contract covers multiple surveys over time (one contract → many surveys). Conversely, large or complex surveys are frequently split across multiple contracts, with different contractors handling acquisition versus processing, or phased contracts for different survey areas (one survey → many contracts). The business actively manages contract line items at the survey-contract intersection, tracking scope, contracted versus actual deliverables (km), unit rates, milestone dates, acceptance status, and payment status for each survey-contract pair.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`block_permit` (
    `block_permit_id` BIGINT COMMENT 'Unique identifier for this block-permit authorization relationship. Primary key.',
    `block_id` BIGINT COMMENT 'Foreign key linking to the exploration block covered by this permit authorization',
    `permit_id` BIGINT COMMENT 'Foreign key linking to the permit that authorizes activities on this block',
    `application_date` DATE COMMENT 'Date on which the permit application was submitted for this specific block. Tracks the timeline of permit acquisition for block-specific compliance reporting.',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority approved this permit for this specific block. Used to track compliance timelines and regulatory approval history.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance activities, inspections, violations, or special considerations for this permit as it applies to this block.',
    `conditions_summary` STRING COMMENT 'Summary of permit conditions, restrictions, and requirements that are specific to this block. Captures block-specific environmental restrictions, operational limitations, or reporting requirements that may differ from general permit conditions.',
    `effective_date` DATE COMMENT 'Date on which this permit becomes effective for this specific block. May differ from the permits overall effective date if the permit covers multiple blocks with staggered timelines.',
    `expiration_date` DATE COMMENT 'Date on which this permit authorization expires for this specific block. May differ from the permits overall expiration if blocks have different renewal schedules.',
    `permit_status` STRING COMMENT 'Current status of this permit as it applies to this specific block. Tracks whether the permit is active, pending approval, expired, suspended, or revoked for this block.',
    `renewal_due_date` DATE COMMENT 'Date by which the permit renewal must be submitted for continued authorization on this block. Critical for compliance planning and avoiding operational disruptions.',
    CONSTRAINT pk_block_permit PRIMARY KEY(`block_permit_id`)
) COMMENT 'This association product represents the regulatory authorization relationship between exploration blocks and permits. It captures the specific permit requirements and compliance status for each block-permit combination. Each record links one exploration block to one permit with attributes that track the permits applicability, effective dates, and compliance conditions specific to that block.. Existence Justification: In oil and gas operations, exploration blocks require multiple permits to operate (drilling permits, environmental permits, seismic survey permits, discharge permits, safety permits), and regulatory permits frequently cover multiple blocks within a geographic area or basin (regional environmental permits, area-wide discharge permits, multi-block drilling authorizations). The business actively manages these permit-block relationships, tracking block-specific effective dates, expiration schedules, compliance conditions, and renewal timelines.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`field` (
    `field_id` BIGINT COMMENT 'Primary key for field',
    `basin_id` BIGINT COMMENT 'Foreign key linking to exploration.basin. Business justification: Field belongs to a Basin; linking Field to Basin provides proper geographic hierarchy and removes redundant basin_name attribute.',
    `operator_id` BIGINT COMMENT 'FK to land.operator',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the field resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the field record was first created in the system.',
    `cumulative_production` DECIMAL(18,2) COMMENT 'Total volume produced to date, expressed in barrels of oil equivalent.',
    `current_production_rate` DECIMAL(18,2) COMMENT 'Most recent measured production rate (e.g., barrels per day).',
    `depth_md` DECIMAL(18,2) COMMENT 'Average measured depth of the fields producing zones (meters).',
    `field_description` STRING COMMENT 'Free‑form textual description of the field, including geology and operational notes.',
    `discovery_date` DATE COMMENT 'Date the field was first discovered.',
    `end_of_production_date` DATE COMMENT 'Projected or actual date when production is expected to cease.',
    `estimated_reserves_boe` DECIMAL(18,2) COMMENT 'Estimated ultimate recoverable reserves expressed in barrels of oil equivalent.',
    `field_classification` STRING COMMENT 'PRMS resource classification indicating certainty of reserves.',
    `field_code` STRING COMMENT 'External business identifier or code assigned to the field (e.g., lease or regulatory code).',
    `field_name` STRING COMMENT 'Human‑readable name of the oil or gas field.',
    `field_status` STRING COMMENT 'Current operational status of the field.',
    `field_status_date` DATE COMMENT 'Date on which the current field status became effective.',
    `field_type` STRING COMMENT 'Classification of the field based on location and water depth.',
    `is_depleted` BOOLEAN COMMENT 'Indicates whether the field has been declared depleted.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the field record.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the fields central point.',
    `lease_number` STRING COMMENT 'Regulatory lease identifier associated with the field.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the fields central point.',
    `peak_production_rate` DECIMAL(18,2) COMMENT 'Maximum historical production rate (e.g., barrels per day).',
    `prms_resource_classification` STRING COMMENT 'Resource status per Petroleum Resources Management System.',
    `region_name` STRING COMMENT 'State, province, or administrative region of the field.',
    `start_production_date` DATE COMMENT 'Date when commercial production commenced.',
    `water_depth` DECIMAL(18,2) COMMENT 'Average water depth for offshore fields (meters).',
    CONSTRAINT pk_field PRIMARY KEY(`field_id`)
) COMMENT 'Master reference table for field. Referenced by field_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`exploration`.`wellbore` (
    `wellbore_id` BIGINT COMMENT 'Primary key for wellbore',
    `rig_id` BIGINT COMMENT 'Identifier of the drilling rig that performed the spud.',
    `field_id` BIGINT COMMENT 'Foreign key linking to exploration.field. Business justification: Wellbore belongs to a Field; linking Wellbore to Field captures the structural hierarchy and removes redundant field_name and basin_name attributes.',
    `abandonment_date` DATE COMMENT 'Date when the wellbore was officially abandoned.',
    `actual_completion_date` DATE COMMENT 'Real date when drilling was completed.',
    `completion_date` DATE COMMENT 'Date when drilling was completed and the wellbore was ready for completion operations.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the wellbore location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the wellbore record was first created.',
    `cumulative_production_gas_mcf` DECIMAL(18,2) COMMENT 'Total gas produced to date, measured in thousand cubic feet.',
    `cumulative_production_oil_bbl` DECIMAL(18,2) COMMENT 'Total oil produced to date, measured in barrels.',
    `cumulative_production_water_bbl` DECIMAL(18,2) COMMENT 'Total water produced to date, measured in barrels.',
    `drilling_method` STRING COMMENT 'Technique used to drill the wellbore.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the wellhead above mean sea level.',
    `expected_completion_date` DATE COMMENT 'Projected date for drilling completion.',
    `formation_bottom` STRING COMMENT 'Geological formation at the deepest point of the wellbore.',
    `formation_top` STRING COMMENT 'Geological formation encountered at the top of the wellbore.',
    `fracture_type` STRING COMMENT 'Category of hydraulic fracturing fluid or technique used.',
    `is_hydraulic_fractured` BOOLEAN COMMENT 'Indicates whether hydraulic fracturing was performed on the wellbore.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent record update.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the wellhead (WGS84).',
    `lease_number` STRING COMMENT 'Contractual lease identifier governing the wellbore location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the wellhead (WGS84).',
    `measured_depth_m` DECIMAL(18,2) COMMENT 'Cumulative length of the wellbore measured along its trajectory.',
    `planned_depth_m` DECIMAL(18,2) COMMENT 'Target depth defined during well planning.',
    `production_end_date` DATE COMMENT 'Date when production was permanently shut in.',
    `production_start_date` DATE COMMENT 'Date when the wellbore began commercial production.',
    `reservoir_name` STRING COMMENT 'Name of the reservoir targeted by the wellbore.',
    `reservoir_pressure_bar` DECIMAL(18,2) COMMENT 'Measured pressure of the reservoir at the target zone.',
    `reservoir_temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature of the reservoir at the target zone.',
    `spud_date` DATE COMMENT 'Date when drilling commenced.',
    `state_province` STRING COMMENT 'State or province where the wellbore is located.',
    `wellbore_status` STRING COMMENT 'Current lifecycle state of the wellbore.',
    `total_depth_m` DECIMAL(18,2) COMMENT 'Maximum measured depth of the wellbore from surface to the deepest point.',
    `true_vertical_depth_m` DECIMAL(18,2) COMMENT 'Vertical distance from surface to the deepest point, ignoring deviation.',
    `well_type` STRING COMMENT 'Category of the wellbore based on its purpose.',
    `wellbore_class` STRING COMMENT 'Primary fluid or resource type produced or injected.',
    `wellbore_code` STRING COMMENT 'External code or UID used in field operations and reporting (e.g., API number).',
    `wellbore_diameter_mm` DECIMAL(18,2) COMMENT 'Nominal internal diameter of the wellbore.',
    `wellbore_length_m` DECIMAL(18,2) COMMENT 'Overall length of the wellbore including all sections.',
    `wellbore_name` STRING COMMENT 'Human‑readable name or label assigned to the wellbore.',
    `wellbore_status_reason` STRING COMMENT 'Narrative explanation for the current wellbore status.',
    CONSTRAINT pk_wellbore PRIMARY KEY(`wellbore_id`)
) COMMENT 'Master reference table for wellbore. Referenced by wellbore_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ADD CONSTRAINT `fk_exploration_play_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` ADD CONSTRAINT `fk_exploration_play_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_lead_id` FOREIGN KEY (`lead_id`) REFERENCES `oil_gas_ecm`.`exploration`.`lead`(`lead_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ADD CONSTRAINT `fk_exploration_seismic_line_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ADD CONSTRAINT `fk_exploration_seismic_line_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ADD CONSTRAINT `fk_exploration_seismic_line_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ADD CONSTRAINT `fk_exploration_well_log_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ADD CONSTRAINT `fk_exploration_well_log_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ADD CONSTRAINT `fk_exploration_prospect_resource_estimate_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ADD CONSTRAINT `fk_exploration_prospect_resource_estimate_superseded_by_estimate_prospect_resource_estimate_id` FOREIGN KEY (`superseded_by_estimate_prospect_resource_estimate_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect_resource_estimate`(`prospect_resource_estimate_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ADD CONSTRAINT `fk_exploration_seismic_interpretation_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ADD CONSTRAINT `fk_exploration_seismic_interpretation_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ADD CONSTRAINT `fk_exploration_seismic_interpretation_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ADD CONSTRAINT `fk_exploration_seismic_interpretation_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ADD CONSTRAINT `fk_exploration_seismic_interpretation_superseded_by_interpretation_seismic_interpretation_id` FOREIGN KEY (`superseded_by_interpretation_seismic_interpretation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_interpretation`(`seismic_interpretation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_wildcat_well_plan_id` FOREIGN KEY (`wildcat_well_plan_id`) REFERENCES `oil_gas_ecm`.`exploration`.`wildcat_well_plan`(`wildcat_well_plan_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_wellbore_id` FOREIGN KEY (`wellbore_id`) REFERENCES `oil_gas_ecm`.`exploration`.`wellbore`(`wellbore_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ADD CONSTRAINT `fk_exploration_fluid_sample_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ADD CONSTRAINT `fk_exploration_fluid_sample_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ADD CONSTRAINT `fk_exploration_block_interest_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ADD CONSTRAINT `fk_exploration_well_result_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ADD CONSTRAINT `fk_exploration_well_result_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ADD CONSTRAINT `fk_exploration_campaign_vendor_engagement_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `oil_gas_ecm`.`exploration`.`campaign`(`campaign_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ADD CONSTRAINT `fk_exploration_seismic_contract_line_item_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ADD CONSTRAINT `fk_exploration_block_permit_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` ADD CONSTRAINT `fk_exploration_field_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wellbore` ADD CONSTRAINT `fk_exploration_wellbore_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`exploration`.`field`(`field_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`exploration` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`exploration` SET TAGS ('dbx_domain' = 'exploration');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` SET TAGS ('dbx_subdomain' = 'basin_management');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Champion Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`play` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluating Geologist Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `pricing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Agreement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Geologist Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'License Block Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` SET TAGS ('dbx_subdomain' = 'seismic_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Contractor Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` SET TAGS ('dbx_subdomain' = 'seismic_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `seismic_line_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Line Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Contractor Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Target Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `acquisition_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `acquisition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition End Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `acquisition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Start Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|acquired|suspended|cancelled|completed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `azimuth_degrees` SET TAGS ('dbx_business_glossary_term' = 'Azimuth in Degrees');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'SEG-Y|SEG-D|SEG-2|SEGY_REV1|SEGY_REV2|proprietary');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `data_quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Grade');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `data_quality_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unacceptable');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `data_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Data Storage Location');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `data_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `end_latitude` SET TAGS ('dbx_business_glossary_term' = 'End Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `end_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `end_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `end_longitude` SET TAGS ('dbx_business_glossary_term' = 'End Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `end_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `end_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `fold_coverage` SET TAGS ('dbx_business_glossary_term' = 'Fold Coverage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `hse_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|preliminary|final|approved|archived');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `line_length_km` SET TAGS ('dbx_business_glossary_term' = 'Line Length in Kilometers (km)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Seismic Line Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Seismic Line Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Seismic Line Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = '2D|3D_inline|3D_crossline|4D|VSP|walkaway_VSP');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `processing_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Completion Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `processing_contractor` SET TAGS ('dbx_business_glossary_term' = 'Processing Contractor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `processing_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Processing Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `processing_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `processing_sequence` SET TAGS ('dbx_business_glossary_term' = 'Processing Sequence');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `receiver_spacing_m` SET TAGS ('dbx_business_glossary_term' = 'Receiver Spacing in Meters (m)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `record_length_ms` SET TAGS ('dbx_business_glossary_term' = 'Record Length in Milliseconds (ms)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `sample_interval_ms` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval in Milliseconds (ms)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `shot_point_end` SET TAGS ('dbx_business_glossary_term' = 'Shot Point End');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `shot_point_start` SET TAGS ('dbx_business_glossary_term' = 'Shot Point Start');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `source_interval_m` SET TAGS ('dbx_business_glossary_term' = 'Source Interval in Meters (m)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Seismic Source Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'dynamite|vibroseis|airgun|watergun|sparker|weight_drop');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `start_latitude` SET TAGS ('dbx_business_glossary_term' = 'Start Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `start_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `start_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `start_longitude` SET TAGS ('dbx_business_glossary_term' = 'Start Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `start_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ALTER COLUMN `start_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `well_log_id` SET TAGS ('dbx_business_glossary_term' = 'Well Log Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Company Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `acquisition_tool` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Tool');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `api_well_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `api_well_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,14}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `bottom_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Bottom Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `bottom_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Bottom Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `bubble_point_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Bubble Point Pressure Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `data_format` SET TAGS ('dbx_business_glossary_term' = 'Data Format');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `data_format` SET TAGS ('dbx_value_regex' = 'LAS|DLIS|ASCII|PDF|TIFF');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unusable');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `depth_uom` SET TAGS ('dbx_business_glossary_term' = 'Depth Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `depth_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `gor` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `hydrocarbon_saturation_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Saturation Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'raw|preliminary|final|validated');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `interpreted_by` SET TAGS ('dbx_business_glossary_term' = 'Interpreted By');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `lithology` SET TAGS ('dbx_business_glossary_term' = 'Lithology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `log_subtype` SET TAGS ('dbx_business_glossary_term' = 'Log Subtype');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `log_type` SET TAGS ('dbx_business_glossary_term' = 'Log Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `log_type` SET TAGS ('dbx_value_regex' = 'wireline|LWD|MWD|core|fluid_sample|geochemical');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Permeability Millidarcies (mD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Porosity Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `quality_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Comments');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `sample_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `sample_condition` SET TAGS ('dbx_value_regex' = 'preserved|analyzed|depleted|archived');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `toc_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Organic Carbon (TOC) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `top_depth_md` SET TAGS ('dbx_business_glossary_term' = 'Top Depth Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `top_depth_tvd` SET TAGS ('dbx_business_glossary_term' = 'Top Depth True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Viscosity Centipoise (cP)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `vitrinite_reflectance` SET TAGS ('dbx_business_glossary_term' = 'Vitrinite Reflectance (Ro)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ALTER COLUMN `water_saturation_percent` SET TAGS ('dbx_business_glossary_term' = 'Water Saturation Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`formation` SET TAGS ('dbx_subdomain' = 'sample_analysis');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` SET TAGS ('dbx_subdomain' = 'basin_management');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` SET TAGS ('dbx_subdomain' = 'basin_management');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ALTER COLUMN `prospect_resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Resource Estimate Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `play_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Geoscientist Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `study_lead_geoscientist_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Location');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Budget Amount');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `data_quality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `data_quality_assessment` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `deliverables_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverables Description');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `depth_conversion_method` SET TAGS ('dbx_business_glossary_term' = 'Depth Conversion Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `depth_conversion_method` SET TAGS ('dbx_value_regex' = 'time_to_depth|velocity_model|checkshot|vsp|other');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `fault_count` SET TAGS ('dbx_business_glossary_term' = 'Fault Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `horizon_count` SET TAGS ('dbx_business_glossary_term' = 'Horizon Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `hydrocarbon_indicators` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Indicators');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|auto_tracking|machine_learning|hybrid');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `peer_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_review|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `report_document_path` SET TAGS ('dbx_business_glossary_term' = 'Report Document Path');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `report_document_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `software_platform` SET TAGS ('dbx_business_glossary_term' = 'Software Platform');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `software_platform` SET TAGS ('dbx_value_regex' = 'petrel|decisionspace|geoframe|kingdom|opendtect|other');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `stratigraphic_observations` SET TAGS ('dbx_business_glossary_term' = 'Stratigraphic Observations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `structural_observations` SET TAGS ('dbx_business_glossary_term' = 'Structural Observations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|under_review|completed|archived|cancelled');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `velocity_model_type` SET TAGS ('dbx_business_glossary_term' = 'Velocity Model Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ALTER COLUMN `velocity_model_type` SET TAGS ('dbx_value_regex' = 'interval_velocity|average_velocity|rms_velocity|anisotropic|isotropic');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` SET TAGS ('dbx_subdomain' = 'seismic_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `seismic_interpretation_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Interpretation ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Employee ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `prospect_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `superseded_by_interpretation_seismic_interpretation_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Interpretation ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `data_quality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `data_quality_assessment` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `depth_conversion_method` SET TAGS ('dbx_business_glossary_term' = 'Depth Conversion Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `depth_conversion_method` SET TAGS ('dbx_value_regex' = 'time_to_depth|velocity_model|checkshot|vsp|well_tie');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `fault_name` SET TAGS ('dbx_business_glossary_term' = 'Fault Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `horizon_name` SET TAGS ('dbx_business_glossary_term' = 'Horizon Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `hydrocarbon_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Indicator Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `hydrocarbon_indicator_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `hydrocarbon_indicator_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Indicator Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `hydrocarbon_indicator_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `integration_with_well_data_flag` SET TAGS ('dbx_business_glossary_term' = 'Integration With Well Data Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_comments` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Comments');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_confidence` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Confidence');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_confidence` SET TAGS ('dbx_value_regex' = 'high|medium|low|uncertain');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_date` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_method` SET TAGS ('dbx_value_regex' = 'manual|semi-automated|auto-tracking|neural_network|machine_learning');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_name` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Quality Score');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_software` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Software');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|superseded');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_type` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpretation_version` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Version');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `interpreter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `play_type` SET TAGS ('dbx_business_glossary_term' = 'Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `play_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `seismic_attribute_type` SET TAGS ('dbx_business_glossary_term' = 'Seismic Attribute Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `signal_to_noise_ratio` SET TAGS ('dbx_business_glossary_term' = 'Signal to Noise Ratio');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `stratigraphic_observation` SET TAGS ('dbx_business_glossary_term' = 'Stratigraphic Observation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `structural_observation` SET TAGS ('dbx_business_glossary_term' = 'Structural Observation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `velocity_model_name` SET TAGS ('dbx_business_glossary_term' = 'Velocity Model Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `well_tie_quality` SET TAGS ('dbx_business_glossary_term' = 'Well Tie Quality');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ALTER COLUMN `well_tie_quality` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|not_applicable');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `wildcat_well_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Wildcat Well Plan Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `basin_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Expected Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Geologist Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Target Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `bottom_hole_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_business_glossary_term' = 'Bottom Hole Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `bottom_hole_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Assessment Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `environmental_assessment_status` SET TAGS ('dbx_value_regex' = 'not_required|required|in_progress|completed|approved');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `estimated_drilling_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Drilling Days');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `estimated_well_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Well Cost');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `estimated_well_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `h2s_expected` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Expected Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `high_pressure_expected` SET TAGS ('dbx_business_glossary_term' = 'High Pressure Expected Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `hse_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `permit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|on_hold|cancelled|drilling_commenced');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_spud_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Spud Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_td` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth (TD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_td_uom` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Depth (TD) Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_td_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_tvd` SET TAGS ('dbx_business_glossary_term' = 'Planned True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_tvd_uom` SET TAGS ('dbx_business_glossary_term' = 'Planned True Vertical Depth (TVD) Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `planned_tvd_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `rig_type_required` SET TAGS ('dbx_business_glossary_term' = 'Rig Type Required');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `rig_type_required` SET TAGS ('dbx_value_regex' = 'land|jackup|semisubmersible|drillship');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `trajectory_type` SET TAGS ('dbx_business_glossary_term' = 'Trajectory Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `trajectory_type` SET TAGS ('dbx_value_regex' = 'vertical|deviated|horizontal|extended_reach');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `water_depth` SET TAGS ('dbx_business_glossary_term' = 'Water Depth');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `water_depth_uom` SET TAGS ('dbx_business_glossary_term' = 'Water Depth Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `water_depth_uom` SET TAGS ('dbx_value_regex' = 'ft|m');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `well_name` SET TAGS ('dbx_business_glossary_term' = 'Well Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `well_objectives` SET TAGS ('dbx_business_glossary_term' = 'Well Objectives');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `well_type` SET TAGS ('dbx_business_glossary_term' = 'Well Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `well_type` SET TAGS ('dbx_value_regex' = 'wildcat|appraisal|stratigraphic');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ALTER COLUMN `working_interest_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sedimentary Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Company Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Encountered Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Target Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Rig Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Wellsite Geologist Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `wildcat_well_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Wildcat Well Plan Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Well Cost');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_md_depth` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Depth (MD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `actual_tvd_depth` SET TAGS ('dbx_business_glossary_term' = 'Actual True Vertical Depth (TVD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `api_number` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Well Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `api_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{3}-[0-9]{5}(-[0-9]{2})?$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `block_lease_number` SET TAGS ('dbx_business_glossary_term' = 'Block or Lease Number');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `secondary_target_formation` SET TAGS ('dbx_business_glossary_term' = 'Secondary Target Geological Formation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `spud_date` SET TAGS ('dbx_business_glossary_term' = 'Spud Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_business_glossary_term' = 'Surface Location Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `surface_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ALTER COLUMN `target_formation` SET TAGS ('dbx_business_glossary_term' = 'Target Geological Formation');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `core_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Core Sample Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Coring Contractor Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ALTER COLUMN `wellbore_id` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `fluid_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Fluid Sample Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `formation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Pvt Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `c1_content_mole_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane (C1) Content in Mole Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `c2_c5_content_mole_percent` SET TAGS ('dbx_business_glossary_term' = 'Ethane through Pentane (C2-C5) Content in Mole Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `c6_plus_content_mole_percent` SET TAGS ('dbx_business_glossary_term' = 'Hexane Plus (C6+) Content in Mole Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `co2_content_mole_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Content in Mole Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `collected_by` SET TAGS ('dbx_business_glossary_term' = 'Collected By');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `collection_depth_md_m` SET TAGS ('dbx_business_glossary_term' = 'Collection Depth Measured Depth (MD) in Meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `collection_depth_tvd_m` SET TAGS ('dbx_business_glossary_term' = 'Collection Depth True Vertical Depth (TVD) in Meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `contamination_type` SET TAGS ('dbx_business_glossary_term' = 'Contamination Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `contamination_type` SET TAGS ('dbx_value_regex' = 'drilling_mud|completion_fluid|water|none|unknown');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `fluid_type` SET TAGS ('dbx_business_glossary_term' = 'Fluid Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `fluid_type` SET TAGS ('dbx_value_regex' = 'black_oil|volatile_oil|gas_condensate|dry_gas|wet_gas');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `gas_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Gas Formation Volume Factor (Bg)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `gas_specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Gas Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `gor_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) in Standard Cubic Feet per Stock Tank Barrel (SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `h2s_content_mole_percent` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content in Mole Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `n2_content_mole_percent` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen (N2) Content in Mole Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `oil_formation_volume_factor` SET TAGS ('dbx_business_glossary_term' = 'Oil Formation Volume Factor (Bo)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `oil_viscosity_cp` SET TAGS ('dbx_business_glossary_term' = 'Oil Viscosity in Centipoise (CP)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `pvt_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Pressure Volume Temperature (PVT) Analysis Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `pvt_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Pressure Volume Temperature (PVT) Report Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `reservoir_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Pressure in Pounds per Square Inch Absolute (PSIA)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `reservoir_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Sample Quality Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_quality_flag` SET TAGS ('dbx_value_regex' = 'representative|contaminated|questionable|not_assessed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'collected|in_transit|received_at_lab|analysis_in_progress|analysis_complete|archived');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'bottomhole|surface_recombined|separator|wellhead|wireline_formation_tester');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume in Milliliters (ML)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `sampling_tool_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Tool Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `saturation_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Saturation Pressure in Pounds per Square Inch Absolute (PSIA)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `saturation_pressure_type` SET TAGS ('dbx_business_glossary_term' = 'Saturation Pressure Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `saturation_pressure_type` SET TAGS ('dbx_value_regex' = 'bubble_point|dew_point|not_applicable');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `solution_gas_oil_ratio_scf_stb` SET TAGS ('dbx_business_glossary_term' = 'Solution Gas-Oil Ratio (Rs) in Standard Cubic Feet per Stock Tank Barrel (SCF/STB)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ALTER COLUMN `water_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` SET TAGS ('dbx_subdomain' = 'seismic_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Company Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Manager Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `jv_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'License Block Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `actual_seismic_survey_km` SET TAGS ('dbx_business_glossary_term' = 'Actual Seismic Survey Kilometers (km)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `actual_spend_mm_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend in Million United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `actual_spend_mm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `actual_well_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Well Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `afe_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'planning|approved|active|suspended|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'seismic|drilling|geochemical|integrated|appraisal');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `data_acquisition_contractor` SET TAGS ('dbx_business_glossary_term' = 'Data Acquisition Contractor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|conditional|denied');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `estimated_eur_p50_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ultimate Recovery (EUR) P50 in Million Barrels of Oil Equivalent (MMBOE)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `estimated_eur_p50_mmboe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `geological_chance_of_success_pct` SET TAGS ('dbx_business_glossary_term' = 'Geological Chance of Success Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `hse_plan_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Plan Approved Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `hydrocarbon_type` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `interpretation_software_platform` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Software Platform');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `objective` SET TAGS ('dbx_business_glossary_term' = 'Campaign Objective');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `planned_seismic_survey_km` SET TAGS ('dbx_business_glossary_term' = 'Planned Seismic Survey Kilometers (km)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `planned_well_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Well Count');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority Rank');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Class');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `prms_resource_class` SET TAGS ('dbx_value_regex' = 'prospective|contingent|reserves');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `seismic_survey_type` SET TAGS ('dbx_business_glossary_term' = 'Seismic Survey Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `seismic_survey_type` SET TAGS ('dbx_value_regex' = '2D|3D|4D|ocean_bottom|VSP');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `target_play_type` SET TAGS ('dbx_business_glossary_term' = 'Target Play Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `total_budget_capex_mm_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Capital Expenditure (CAPEX) in Million United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `total_budget_capex_mm_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` SET TAGS ('dbx_subdomain' = 'sample_analysis');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `geochemical_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Geochemical Sample Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Formation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Predicted Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `collection_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Collection Depth (Meters)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `depth_reference` SET TAGS ('dbx_business_glossary_term' = 'Depth Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `depth_reference` SET TAGS ('dbx_value_regex' = 'surface|kelly_bushing|rotary_table|mean_sea_level|ground_level');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `geological_age` SET TAGS ('dbx_business_glossary_term' = 'Geological Age');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `hydrocarbon_potential` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Generation Potential');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `hydrocarbon_potential` SET TAGS ('dbx_value_regex' = 'poor|fair|good|very_good|excellent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `hydrogen_index_hi` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Index (HI)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `kerogen_type` SET TAGS ('dbx_business_glossary_term' = 'Kerogen Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `kerogen_type` SET TAGS ('dbx_value_regex' = 'type_i|type_ii|type_iii|type_iv|mixed');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `laboratory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Reference Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `lithology` SET TAGS ('dbx_business_glossary_term' = 'Lithology');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `measured_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Measured Depth (MD) in Meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `oxygen_index_oi` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Index (OI)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Preservation Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'passed|failed|suspect|reanalysis_required');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `s1_mg_hc_per_g_rock` SET TAGS ('dbx_business_glossary_term' = 'S1 Free Hydrocarbons (mg HC/g rock)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `s2_mg_hc_per_g_rock` SET TAGS ('dbx_business_glossary_term' = 'S2 Pyrolyzable Hydrocarbons (mg HC/g rock)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `s3_mg_co2_per_g_rock` SET TAGS ('dbx_business_glossary_term' = 'S3 Carbon Dioxide (mg CO2/g rock)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'collected|in_transit|received|analyzed|archived');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'soil_gas|water|cutting|core|outcrop|seep');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `sample_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight (Grams)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `thermal_maturity_stage` SET TAGS ('dbx_business_glossary_term' = 'Thermal Maturity Stage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `thermal_maturity_stage` SET TAGS ('dbx_value_regex' = 'immature|early_mature|peak_mature|late_mature|post_mature|overmature');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `tmax_celsius` SET TAGS ('dbx_business_glossary_term' = 'Tmax Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `toc_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Organic Carbon (TOC) Percentage');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `true_vertical_depth_m` SET TAGS ('dbx_business_glossary_term' = 'True Vertical Depth (TVD) in Meters');
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ALTER COLUMN `vitrinite_reflectance_ro` SET TAGS ('dbx_business_glossary_term' = 'Vitrinite Reflectance (Ro)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `discovery_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Geologist Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'License Block Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `play_id` SET TAGS ('dbx_business_glossary_term' = 'Play Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Producing Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ALTER COLUMN `formation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Formation Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` SET TAGS ('dbx_subdomain' = 'basin_management');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `block_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Block Interest Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Company ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|conditional_approval|not_required');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `area_of_mutual_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Area of Mutual Interest (AMI) Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `back_in_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Back-In Interest Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `back_in_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Back-In Right Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `billing_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Entity ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `carried_cost_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Carried Cost Limit (USD)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `carried_cost_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `carried_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `carried_phase` SET TAGS ('dbx_business_glossary_term' = 'Carried Phase');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `carried_phase` SET TAGS ('dbx_value_regex' = 'exploration|appraisal|development|production|none');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Required Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'proportionate|carried|farmout|area_of_mutual_interest');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `default_interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Rate Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `default_interest_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `farmout_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Farmout Agreement Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `farmout_earn_in_percent` SET TAGS ('dbx_business_glossary_term' = 'Farmout Earn-In Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Regime Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_value_regex' = 'concession|psc|rsc|service_contract|hybrid');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|relinquished|transferred|expired');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `net_revenue_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `non_consent_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Option Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `participating_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Participating Interest Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `partner_category` SET TAGS ('dbx_business_glossary_term' = 'Partner Category');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `partner_category` SET TAGS ('dbx_value_regex' = 'ioc|noc|independent|service_company|government_entity|private_equity');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'operator|non-operator');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `preferential_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Right Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `relinquishment_date` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `voting_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Voting Interest Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ALTER COLUMN `working_interest_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percent');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` SET TAGS ('dbx_subdomain' = 'exploration_drilling');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `well_result_id` SET TAGS ('dbx_business_glossary_term' = 'Well Result Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Geologist Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `exploration_well_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `api_gravity_degrees` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity (Degrees)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `average_permeability_md` SET TAGS ('dbx_business_glossary_term' = 'Average Permeability (Millidarcies)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `average_porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Porosity (Percent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `average_water_saturation_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Water Saturation (Percent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Well Result Classification');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'discovery|dry_hole|shows_only|technical_success|suspended|abandoned');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `commercial_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Success Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `discovery_declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Declaration Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `discovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Discovery Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `dst_test_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Drill Stem Test (DST) Conducted Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `evaluation_petrophysicist_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Petrophysicist Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `evaluation_reservoir_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Reservoir Engineer Name');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `formation_evaluation_summary` SET TAGS ('dbx_business_glossary_term' = 'Formation Evaluation Summary');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `gas_oil_ratio_scf_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Gas Oil Ratio (GOR) (Standard Cubic Feet per Barrel)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `geological_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Geological Success Flag');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `gross_pay_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Thickness (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `gross_pay_thickness_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `gross_pay_thickness_ft` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `hydrocarbon_type_encountered` SET TAGS ('dbx_business_glossary_term' = 'Hydrocarbon Type Encountered');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `hydrocarbon_type_encountered` SET TAGS ('dbx_value_regex' = 'oil|gas|condensate|ngl|mixed|none');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `initial_production_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate (Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `initial_production_rate_mcfd` SET TAGS ('dbx_business_glossary_term' = 'Initial Production (IP) Rate (Thousand Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `initial_reservoir_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Initial Reservoir Pressure (Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Thickness (Feet)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `net_pay_thickness_ft` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `number_of_pay_intervals` SET TAGS ('dbx_business_glossary_term' = 'Number of Pay Intervals');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `post_drill_eur_p10_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Post-Drill Estimated Ultimate Recovery (EUR) P10 (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `post_drill_eur_p50_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Post-Drill Estimated Ultimate Recovery (EUR) P50 (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `post_drill_eur_p90_mmboe` SET TAGS ('dbx_business_glossary_term' = 'Post-Drill Estimated Ultimate Recovery (EUR) P90 (Million Barrels of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `pressure_gradient_psi_per_ft` SET TAGS ('dbx_business_glossary_term' = 'Pressure Gradient (Pounds per Square Inch per Foot)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `primary_reservoir_formation` SET TAGS ('dbx_business_glossary_term' = 'Primary Reservoir Formation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `prms_resource_class_post_drill` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Resources Management System (PRMS) Resource Class Post-Drill');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `prms_resource_class_post_drill` SET TAGS ('dbx_value_regex' = '1P|2P|3P|contingent|prospective|unrecoverable');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `recommendation_code` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Code');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `recommendation_code` SET TAGS ('dbx_value_regex' = 'appraise|develop|abandon|suspend|sidetrack');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `recommendation_rationale` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Rationale');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `reservoir_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `result_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Result Evaluation Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ALTER COLUMN `secondary_reservoir_formation` SET TAGS ('dbx_business_glossary_term' = 'Secondary Reservoir Formation');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` SET TAGS ('dbx_subdomain' = 'seismic_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` SET TAGS ('dbx_association_edges' = 'exploration.campaign,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `campaign_vendor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Vendor Engagement ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Vendor Engagement - Exploration Campaign Id');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Vendor Engagement - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted Value');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` SET TAGS ('dbx_subdomain' = 'seismic_operations');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` SET TAGS ('dbx_association_edges' = 'exploration.seismic_survey,procurement.procurement_contract');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `seismic_contract_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Contract Line Item ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Contract Line Item - Procurement Contract Id');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `seismic_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Seismic Contract Line Item - Seismic Survey Id');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `actual_km_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Kilometers Delivered');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `contract_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item Number');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `contracted_km` SET TAGS ('dbx_business_glossary_term' = 'Contracted Kilometers');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `delivery_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Milestone Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `line_item_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Line Item Value USD');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Item Notes');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `survey_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Survey Scope Description');
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ALTER COLUMN `unit_rate_per_km` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate Per Kilometer');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` SET TAGS ('dbx_subdomain' = 'basin_management');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` SET TAGS ('dbx_association_edges' = 'exploration.block,compliance.permit');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `block_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Block Permit Authorization ID');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Permit - Exploration Block Id');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Block Permit - Permit Id');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Block Permit Application Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Block Permit Approval Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Block Permit Compliance Notes');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `conditions_summary` SET TAGS ('dbx_business_glossary_term' = 'Block-Specific Permit Conditions');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Block-Specific Permit Status');
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Block Permit Renewal Due Date');
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` SET TAGS ('dbx_subdomain' = 'basin_management');
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` ALTER COLUMN `basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wellbore` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wellbore` SET TAGS ('dbx_subdomain' = 'sample_analysis');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wellbore` ALTER COLUMN `wellbore_id` SET TAGS ('dbx_business_glossary_term' = 'Wellbore Identifier');
ALTER TABLE `oil_gas_ecm`.`exploration`.`wellbore` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
