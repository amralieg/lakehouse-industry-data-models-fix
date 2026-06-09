-- Schema for Domain: mine | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`mine` COMMENT 'Core mining operations encompassing mine planning, pit design, drill-and-blast, ore extraction, ROM pad management, haulage, strip ratio tracking, dilution control, production scheduling, and LOM planning. Integrates with FMS and SCADA for real-time operational visibility across open-cut and underground methods.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`pit_design` (
    `pit_design_id` BIGINT COMMENT 'Unique surrogate identifier for each pit design record in the lakehouse silver layer. Primary key for the pit_design data product.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Pit designs are key deliverables of capital projects (pit expansion, cutback, deepening projects). Each design version is produced by a specific capital project. Essential for project handover documen',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Pit designs must comply with permitted disturbance footprint and depth limits. Required for permit compliance verification and regulatory submissions showing design is within approved boundaries.',
    `functional_location_id` BIGINT COMMENT 'Reference to the parent pit or open-cut entity that this design belongs to. A single pit may have multiple design revisions or pushback stages over its life.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Pit designs respect geological domain boundaries for grade control and geotechnical stability. Required for optimizing pit shells, managing dilution, and ensuring design aligns with geological structu',
    `lom_plan_id` BIGINT COMMENT 'Reference to the Life of Mine (LOM) plan under which this pit design was created or is currently active. Enables traceability of design decisions to the governing LOM schedule.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: pit_design has mine_site_code (STRING) but no FK to mine_site table. Adding mine_site_id FK normalizes site reference and removes redundant code column. The mine_site table contains site_code.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Pit designs target specific orebodies for extraction. Essential for mine planning, resource allocation, and regulatory reporting. Domain experts expect pit designs to reference their target orebody.',
    `plan_scenario_id` BIGINT COMMENT 'Foreign key linking to mine.mine_plan_scenario. Business justification: Pit designs can be generated from mine plan scenarios. N:1 relationship (many pit designs from one scenario). No bidirectional conflict. Valid planning link.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Pit designs are developed for specific exploration prospects that have been converted to mineable resources. Mine planning teams reference the original prospect to validate design assumptions, resourc',
    `resettlement_plan_id` BIGINT COMMENT 'Foreign key linking to community.resettlement_plan. Business justification: Pit expansions trigger resettlement when they encroach on communities. Pit design boundaries define resettlement scope, household counts, and timing. Real business process: resettlement planning, regu',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Pit designs must be spatially validated against tenement boundaries before regulatory approval. Mining engineers verify designs remain within licensed areas for Programme of Work submissions and envir',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Pit designs are developed under capital projects tracked via WBS elements for design capex, engineering cost control, and project cost tracking. Capital project link for open-pit mining.',
    `wireframe_id` BIGINT COMMENT 'Foreign key linking to geology.wireframe. Business justification: Pit designs use orebody wireframes as geometric constraints for optimization. Required for pit shell generation, ensuring designs respect geological boundaries, and volume calculations.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the engineering authority (e.g., Chief Mine Planner, Geotechnical Manager) who formally approved this pit design for use in mine planning and scheduling.',
    `approved_date` DATE COMMENT 'Date on which the pit design was formally approved by the responsible engineering authority for use in mine planning and scheduling. Null if not yet approved.',
    `bench_height_m` DECIMAL(18,2) COMMENT 'The vertical height of each mining bench in metres. Determines the drilling and blasting pattern, equipment selection, and ore/waste delineation resolution. Typically 5–15 m for large open-cut operations.',
    `berm_width_m` DECIMAL(18,2) COMMENT 'The width of catch berms (safety benches) in metres between inter-ramp slope segments. Berms are designed to catch falling material and provide geotechnical stability. Minimum berm width is governed by geotechnical design criteria.',
    `commodity_type` STRING COMMENT 'Primary mineral commodity targeted by this pit design. Drives cut-off grade parameters, processing route selection, and economic optimisation inputs. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|bauxite|zinc|manganese — promote to reference product]',
    `coordinate_system` STRING COMMENT 'The spatial coordinate reference system (CRS) used for the pit design geometry (e.g., GDA2020 / MGA Zone 51, WGS84 UTM Zone 50S). Required for GIS integration and spatial accuracy of the pit shell.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pit design record was first created in the lakehouse data platform. Supports audit trail and data lineage tracking in the silver layer.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'The minimum economic grade (concentration of target mineral) used to classify material as ore versus waste within this pit design. Expressed in the commodity-appropriate unit (e.g., % Fe for iron ore, % Cu for copper, g/t Au for gold). Drives ore/waste classification in the block model.',
    `cutoff_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade value (e.g., pct for percentage Fe/Cu, g_per_t for grams per tonne Au/Ag, ppm for parts per million). Required to correctly interpret the cutoff_grade field.. Valid values are `pct|g_per_t|kg_per_t|ppm`',
    `design_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this pit design within the mine planning system (e.g., PIT-NW-001-R3). Used as the business-facing reference across engineering, scheduling, and LOM planning documents.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `design_engineer` STRING COMMENT 'Name or employee identifier of the mine planning or geotechnical engineer responsible for authoring this pit design revision. Used for accountability and design review traceability.',
    `design_file_reference` STRING COMMENT 'File path or document management system reference to the source design file (e.g., DXF, DWG, or MinePlan project file) containing the pit shell geometry. Enables engineers to retrieve the authoritative spatial data.',
    `design_name` STRING COMMENT 'Human-readable descriptive name of the pit design (e.g., North-West Pit Stage 3 Pushback). Used in reports, LOM schedules, and stakeholder communications.',
    `design_notes` STRING COMMENT 'Free-text field for engineering notes, assumptions, constraints, or change rationale associated with this pit design revision. Captures context not represented in structured fields.',
    `design_status` STRING COMMENT 'Current lifecycle status of the pit design record. draft indicates work-in-progress; under_review means submitted for engineering or geotechnical review; approved is the authorised design for mine planning; superseded means replaced by a newer revision; archived is retained for historical reference only.. Valid values are `draft|under_review|approved|superseded|archived`',
    `design_type` STRING COMMENT 'Classification of the pit design indicating its engineering purpose. ultimate_pit is the final planned pit extent; pushback or cutback represents an incremental mining stage; stage is a scheduled mining increment; interim is a temporary design used for short-term planning. [ENUM-REF-CANDIDATE: ultimate_pit|pushback|stage|cutback|interim|exploration — promote to reference product if additional types emerge]. Valid values are `ultimate_pit|pushback|stage|cutback|interim`',
    `effective_from_date` DATE COMMENT 'Date from which this pit design is considered the active and authoritative design for mine planning purposes. Supports temporal versioning of pit designs across LOM schedule periods.',
    `effective_to_date` DATE COMMENT 'Date on which this pit design ceases to be the active authoritative design, typically when superseded by a new revision. Null for the currently active design.',
    `face_angle_deg` DECIMAL(18,2) COMMENT 'The bench face angle in degrees, representing the angle of the individual bench face from horizontal. Determined by rock mass strength and blasting parameters. Typically 65°–80° for competent rock.',
    `geotechnical_domain` STRING COMMENT 'The geotechnical domain or zone classification applied to this pit design, reflecting the rock mass characterisation used to determine slope angle parameters. Sourced from the geotechnical model underpinning the design.',
    `hydrogeology_considered` BOOLEAN COMMENT 'Indicates whether hydrogeological conditions (groundwater, dewatering requirements) were explicitly incorporated into the pit slope design parameters. True = hydrogeology modelled; False = not considered or not applicable.',
    `inter_ramp_angle_deg` DECIMAL(18,2) COMMENT 'The inter-ramp slope angle in degrees, measured between catch berms. Represents the slope angle of the pit wall between successive ramp access levels. Used in geotechnical stability analysis and bench design.',
    `mining_method` STRING COMMENT 'The open-cut mining method applied in this pit design. Determines the geometric and operational parameters used in the design (e.g., bench height, slope angles, equipment selection).. Valid values are `open_cut|open_pit|strip_mining|highwall_mining`',
    `optimisation_software` STRING COMMENT 'Name of the mine planning software used to generate the pit shell optimisation (e.g., Hexagon MinePlan, Deswik, Whittle). Provides provenance for the design methodology and enables reproducibility of results.. Valid values are `hexagon_mineplan|deswik|whittle|geovia_gems|other`',
    `ore_tonnes` DECIMAL(18,2) COMMENT 'Total estimated ore tonnes within the pit design shell above the applied cut-off grade. Derived from the resource block model intersected with the pit shell geometry. Used in LOM scheduling and reserve reporting.',
    `overall_slope_angle_deg` DECIMAL(18,2) COMMENT 'The overall inter-ramp or overall pit slope angle in degrees, representing the angle from horizontal of the pit wall from crest to toe. A critical geotechnical parameter governing pit stability and strip ratio. Typically ranges from 35° to 55° depending on rock mass conditions.',
    `pit_bottom_rl_m` DECIMAL(18,2) COMMENT 'The elevation of the pit floor at its lowest point, expressed as a Reduced Level (RL) in metres above mean sea level (AHD or equivalent datum). Defines the maximum depth of the pit design.',
    `pit_crest_rl_m` DECIMAL(18,2) COMMENT 'The elevation of the pit crest (top of the uppermost bench) in metres above mean sea level (AHD or equivalent datum). Together with pit_bottom_rl_m defines the total vertical depth of the pit.',
    `pit_volume_bcm` DECIMAL(18,2) COMMENT 'Total volume of material (ore and waste) within the pit design shell, expressed in Bank Cubic Metres (BCM). Used for LOM scheduling, equipment fleet sizing, and capital cost estimation.',
    `ramp_gradient_pct` DECIMAL(18,2) COMMENT 'The maximum gradient of haul road ramps within the pit expressed as a percentage (rise over run × 100). Governs truck cycle times and fuel consumption. Typically 8–12% for large haul trucks.',
    `ramp_width_m` DECIMAL(18,2) COMMENT 'The design width of haul road ramps within the pit in metres. Determines the minimum turning radius and equipment access for the selected truck fleet. Typically 3–4 times the width of the largest haul truck.',
    `resource_model_version` STRING COMMENT 'Version identifier of the geological resource block model used as the basis for this pit design optimisation. Ensures traceability between the pit shell geometry and the underlying resource estimate. Sourced from Geovia GEMS or Hexagon MinePlan.. Valid values are `^[A-Z0-9._-]{1,30}$`',
    `revision_date` DATE COMMENT 'Date on which this revision of the pit design was formally issued or updated. Used to track the currency of the design relative to the LOM schedule and resource model.',
    `revision_number` STRING COMMENT 'Sequential integer revision number for this pit design, incremented each time the design is formally updated. Enables version control and audit trail of design changes over the LOM planning cycle.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'The ratio of waste tonnes to ore tonnes within the pit design, expressed as tonnes of waste per tonne of ore (t:t). A fundamental economic parameter for open-cut mining — higher strip ratios increase operating costs (OPEX). Calculated as waste_tonnes / ore_tonnes.',
    `total_depth_m` DECIMAL(18,2) COMMENT 'The total vertical depth of the pit design in metres, calculated as the difference between pit crest RL and pit bottom RL. A key design parameter for geotechnical stability assessment and LOM planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pit design record was last modified in the lakehouse data platform. Used to detect changes and support incremental data processing in the silver layer.',
    `waste_tonnes` DECIMAL(18,2) COMMENT 'Total estimated waste rock tonnes within the pit design shell, including overburden and internal waste. Used to calculate strip ratio and plan waste dump capacity.',
    CONSTRAINT pk_pit_design PRIMARY KEY(`pit_design_id`)
) COMMENT 'Master record of open-cut pit designs including pit shell geometry, bench configurations, slope angles, berm widths, and design revision history. Sourced from Hexagon MinePlan and Deswik. Represents the authoritative spatial and engineering definition of each pit or pushback stage used in mine planning and LOM scheduling.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`stope_design` (
    `stope_design_id` BIGINT COMMENT 'Unique system-generated identifier for each stope design record. Primary key for the stope_design data product.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Underground stope designs are outputs of underground development capital projects (level development, decline construction). Each stope design is delivered by a specific capital project. Critical for ',
    `functional_location_id` BIGINT COMMENT 'Reference to the mine site where this stope design is located. Links to the master mine site record for geographic, regulatory, and operational context.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Stope designs are constrained by geological domains for ore continuity. Essential for underground mine planning, ensuring extraction respects mineralization boundaries and geotechnical domains.',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Stope designs are part of the overall LOM plan. N:1 relationship (many stope designs in one LOM plan). No bidirectional conflict. Valid planning link.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Stope designs are specific to mine sites. Adding mine_site_id FK establishes the site context for underground stope designs. This is a missing normalization for underground operations. No redundant co',
    `mining_block_id` BIGINT COMMENT 'Reference to the mine planning block or stope envelope from which this design was derived. Links to the block model and resource estimation data in Geovia GEMS.',
    `orebody_id` BIGINT COMMENT 'Reference to the geological orebody or mineralised zone that this stope design targets. Links to the geological resource model for grade, tonnage, and resource classification context.',
    `plan_scenario_id` BIGINT COMMENT 'Foreign key linking to mine.mine_plan_scenario. Business justification: Stope designs can be generated from mine plan scenarios. N:1 relationship (many stope designs from one scenario). No bidirectional conflict. Valid planning link.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Underground stope designs target specific prospects discovered during exploration. Mine engineers reference prospect geology, mineralization style, and structural characteristics when designing extrac',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Underground stope designs must remain within tenement boundaries for legal compliance. Critical for resource classification reporting and ensuring extraction rights are valid for designed ore bodies.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Underground stope designs are developed under capital projects for development capex tracking, engineering cost control, and underground project cost management. Capital project link for underground m',
    `wireframe_id` BIGINT COMMENT 'Foreign key linking to geology.wireframe. Business justification: Stope designs are bounded by orebody wireframes for extraction planning. Required for underground design, ensuring stopes remain within ore boundaries, and dilution control.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the authorised engineer or geotechnical specialist who formally approved this stope design for construction issue.',
    `approved_date` DATE COMMENT 'Date on which the stope design was formally approved by the authorised geotechnical or mine planning engineer, permitting issue for construction. Null if not yet approved.',
    `backfill_strength_mpa` DECIMAL(18,2) COMMENT 'Specified minimum unconfined compressive strength (UCS) of the cemented backfill in megapascals (MPa) at the design cure time. Applicable only to cemented paste fill and cemented rock fill designs. Drives cement binder content and backfill plant mix design.',
    `backfill_type` STRING COMMENT 'Type of backfill material specified for this stope design after ore extraction. Determines geotechnical stability of adjacent stopes, backfill plant requirements, and extraction sequence constraints. None indicates open stoping without backfill.. Valid values are `cemented_paste|hydraulic_fill|rock_fill|cemented_rock_fill|uncemented_paste|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stope design record was first created in the data platform, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold applied to define the stope boundary and determine ore versus waste classification within the design. Expressed in the same unit as design_grade_primary. Directly impacts designed ore tonnes and LOM economics.',
    `design_date` DATE COMMENT 'Date on which the current revision of the stope design was formally completed and issued by the mine design engineer.',
    `design_grade_primary` DECIMAL(18,2) COMMENT 'Estimated in-situ grade of the primary commodity within the designed stope boundary, expressed in the commodity-appropriate unit (g/t for gold/silver, % for base metals). Derived from the block model and used for mill feed planning and revenue forecasting.',
    `design_revision` STRING COMMENT 'Sequential revision number of the stope design, incremented each time the design is formally updated. Revision 0 represents the initial issue; subsequent revisions capture engineering changes, geotechnical updates, or grade re-interpretations.',
    `design_status` STRING COMMENT 'Current lifecycle status of the stope design record, tracking progression from initial draft through engineering review, approval, and construction issue. Superseded status indicates a newer revision has replaced this design.. Valid values are `draft|under_review|approved|issued_for_construction|superseded|cancelled`',
    `designed_by` STRING COMMENT 'Name or employee identifier of the mine design engineer responsible for authoring this stope design revision.',
    `designed_dilution_pct` DECIMAL(18,2) COMMENT 'Planned dilution percentage representing the proportion of waste rock expected to be extracted with the ore due to stope geometry and mining method. Expressed as a percentage of total ROM tonnes. Key input to mill feed grade forecasting.',
    `designed_ore_tonnes` DECIMAL(18,2) COMMENT 'Estimated in-situ ore tonnage within the designed stope boundary, calculated from the block model grade-tonnage curve. Represents the planned ore extraction quantity before dilution and recovery adjustments.',
    `designed_recovery_pct` DECIMAL(18,2) COMMENT 'Planned ore recovery percentage representing the proportion of in-situ ore tonnes expected to be extracted from the stope. Accounts for ore loss to pillars, hangingwall slough, and extraction method limitations.',
    `designed_volume_m3` DECIMAL(18,2) COMMENT 'Total designed void volume of the stope in cubic metres as calculated from the 3D stope solid in Deswik or Geovia GEMS. Used for backfill volume estimation, blast design, and ventilation requirements.',
    `deswik_stope_reference` STRING COMMENT 'Native stope identifier from the Deswik mine planning and stope optimisation system. Enables reconciliation between the silver layer data product and the Deswik source system for scheduling and optimisation workflows.',
    `extraction_method` STRING COMMENT 'Underground mining extraction method applied to this stope design. Determines drill pattern, blast design, support requirements, and backfill strategy. Key driver of dilution, recovery rate, and OPEX. [ENUM-REF-CANDIDATE: longhole_open|longhole_retreat|cut_and_fill|sublevel_caving|sublevel_stoping|bench_and_fill|room_and_pillar|shrinkage — promote to reference product]. Valid values are `longhole_open|longhole_retreat|cut_and_fill|sublevel_caving|sublevel_stoping|bench_and_fill`',
    `extraction_sequence` STRING COMMENT 'Planned extraction sequence number of this stope within its mining block or production area. Governs the order of stope firing to manage geotechnical stability, backfill curing time, and ventilation circuit integrity.',
    `geovia_gems_stope_reference` STRING COMMENT 'Native stope object identifier from the Geovia GEMS geological modelling and mine design system. Used for traceability and data lineage between the silver layer data product and the source system of record.',
    `grade_unit` STRING COMMENT 'Unit of measure for the primary commodity grade value (e.g., g/t for gold, % for copper or iron ore, ppm for trace elements). Ensures correct interpretation of design_grade_primary across different commodity types.. Valid values are `g/t|%|ppm|ppb`',
    `ground_support_class` STRING COMMENT 'Geotechnical ground support classification assigned to the stope design, typically based on rock mass rating (RMR) or Q-system. Drives the specification of rock bolts, cable bolts, mesh, and shotcrete requirements. Class A = competent rock; Class E = very poor ground.. Valid values are `A|B|C|D|E`',
    `level_elevation_m` DECIMAL(18,2) COMMENT 'Elevation in metres above mean sea level (mAMSL) of the primary extraction level or ore drive floor for this stope design. Used for ventilation circuit design, dewatering planning, and LOM scheduling.',
    `lom_schedule_period` STRING COMMENT 'Life of Mine (LOM) planning period or fiscal year-quarter in which this stope is scheduled for extraction (e.g., FY2026-Q2). Links the stope design to the LOM production schedule in Deswik for NPV and IRR modelling.',
    `ore_drive_count` STRING COMMENT 'Number of ore drives (extraction drives) designed within the stope footprint. Determines development metres required, drill rig access, and mucking logistics for the stope.',
    `ore_drive_height_m` DECIMAL(18,2) COMMENT 'Designed height of each ore drive (extraction drive) within the stope in metres. Determines equipment clearance and development cost per metre.',
    `ore_drive_width_m` DECIMAL(18,2) COMMENT 'Designed width of each ore drive (extraction drive) within the stope in metres. Determines equipment clearance, drill pattern geometry, and development cost per metre.',
    `pillar_type` STRING COMMENT 'Type of geotechnical pillar incorporated into the stope design to maintain ground stability. Crown pillars separate stopes vertically; rib pillars separate stopes horizontally; sill pillars provide floor support; barrier pillars protect major infrastructure. None indicates pillarless design.. Valid values are `crown|rib|sill|barrier|none`',
    `pillar_width_m` DECIMAL(18,2) COMMENT 'Designed width of the geotechnical pillar in metres. Null if no pillar is specified (pillar_type = none). Critical geotechnical parameter determining pillar stability factor and ore loss to pillars.',
    `primary_commodity` STRING COMMENT 'Principal mineral commodity targeted by this stope design. Determines processing route, grade control requirements, and commodity-specific regulatory reporting obligations. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|zinc|lead|silver|manganese|cobalt — promote to reference product]',
    `stope_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the stope design within the mine planning system. Used as the primary business reference across Deswik, Geovia GEMS, and SAP PS work breakdown structures.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `stope_height_m` DECIMAL(18,2) COMMENT 'Designed vertical height of the stope from floor to back (crown) in metres. Critical input for geotechnical stability assessment, cable bolt design, and blast energy calculations.',
    `stope_length_m` DECIMAL(18,2) COMMENT 'Designed horizontal length of the stope along the strike direction in metres. Primary dimension used for volume calculation, drill pattern design, and production scheduling.',
    `stope_name` STRING COMMENT 'Human-readable name or label assigned to the stope design, typically incorporating level, drive, and sequence identifiers (e.g., L15-OD-001). Used in engineering drawings, P&IDs, and operational communications.',
    `stope_width_m` DECIMAL(18,2) COMMENT 'Designed horizontal width of the stope across the orebody in metres. Determines minimum mining width, dilution exposure, and equipment access requirements.',
    `sublevel_interval_m` DECIMAL(18,2) COMMENT 'Vertical distance in metres between sublevels within the stope design, applicable to sublevel caving (SLC) and sublevel stoping extraction methods. Drives drill ring burden, blast design, and ore recovery modelling.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stope design record was most recently modified in the data platform, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks design revision history and supports change management auditing.',
    `ventilation_requirement_m3s` DECIMAL(18,2) COMMENT 'Minimum required fresh air supply to the stope in cubic metres per second (m³/s) during active extraction, as specified in the stope design. Determined by diesel equipment fleet, blast fume clearance time, and regulatory minimum airflow standards.',
    CONSTRAINT pk_stope_design PRIMARY KEY(`stope_design_id`)
) COMMENT 'Master record of underground stope designs including stope geometry, dimensions, ore drive layouts, pillar specifications, SLC/sublevel configurations, ventilation requirements, and ground support specifications. Captures extraction method (longhole, cut-and-fill, sublevel caving), backfill type and sequence, and design revision history. Sourced from Deswik and Geovia GEMS. Represents the authoritative engineering definition of each underground extraction unit including associated ventilation and ground support requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`lom_plan` (
    `lom_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the Life of Mine (LOM) plan record in the Databricks Silver Layer. Primary key for this entity.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: LOM revenue projections drive benefit-sharing calculations (royalty percentages, trust fund contributions, infrastructure commitments). Agreement terms are embedded in mine planning assumptions. Real ',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: LOM plans are mandatory technical inputs for capital project approval (stage gates, feasibility studies). Every major mining capital project (pit expansion, underground development, processing plant) ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: LOM plans are budgeted and tracked against specific cost centres for financial planning, AISC reporting, and operational cost allocation. Standard mining finance structure for life-of-mine cost manage',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Life-of-mine plans must reference the primary environmental permit authorizing mining operations. Regulatory requirement for demonstrating operations are within permitted scope and conditions.',
    `legal_register_id` BIGINT COMMENT 'Foreign key linking to hse.legal_register. Business justification: LOM plans must demonstrate compliance with applicable mining and environmental legislation. Links plan to legal compliance framework for regulatory reporting and competent person sign-off.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: Life of Mine plans are specific to mine sites. Adding mine_site_id FK establishes the site context for the plan. The lom_plan table has warehouse_location_id but no direct mine_site reference, which i',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: LOM plans extract ore reserves that define the economically extractable portion of resources. Reserve declarations are the basis for LOM production scheduling, financial modeling, and regulatory repor',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: LOM plans roll up to profit centres for segment reporting, NPV analysis, corporate financial consolidation, and JORC reserve reporting. Core mining finance hierarchy for profitability tracking.',
    `project_valuation_id` BIGINT COMMENT 'Foreign key linking to finance.project_valuation. Business justification: LOM plans are valued via project valuation studies for NPV, IRR, investment decision-making, and reserve reporting. Core valuation link for mining project economics.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Life-of-Mine plans are built on prospects that have been converted to reserves. LOM planning requires traceability to the original exploration prospect for resource classification, regulatory reportin',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: LOM plans are based on resource estimates that define the geological inventory. Mine planning uses the resource estimate as the technical foundation for reserve conversion, production scheduling, and ',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: LOM plans are based on resource statements as the foundation for reserve conversion. Required for regulatory compliance, investor reporting, and linking mine plans to competent person declarations.',
    `social_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to community.social_impact_assessment. Business justification: Life-of-mine plans are developed to address SIA findings and regulatory conditions. SIA commitments constrain mine planning (resettlement timing, heritage exclusions, benefit-sharing obligations). Req',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: LOM plans must reference the primary tenement for JORC/NI 43-101 reserve reporting, regulatory submissions, and legal mining authority verification. Essential for competent person sign-off and ASX/SEC',
    `aisc_usd_per_t` DECIMAL(18,2) COMMENT 'All-In Sustaining Cost (AISC) per tonne, expressed in USD. Includes C1 cash costs plus sustaining CAPEX, royalties, and corporate G&A. Provides a comprehensive cost measure for economic viability assessment and investor disclosure.',
    `approval_date` DATE COMMENT 'The date on which this LOM plan version received formal executive or board approval. Marks the transition from under_review to approved status and triggers downstream planning and budgeting activities.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the executive or technical authority who formally approved this LOM plan version. Required for governance, audit trail, and regulatory compliance.',
    `average_annual_ore_mt` DECIMAL(18,2) COMMENT 'The average annual ore extraction rate in million tonnes per year (Mtpa) over the full LOM plan. Used for steady-state OPEX modelling, workforce planning, and long-term supply agreements.',
    `average_ore_grade` DECIMAL(18,2) COMMENT 'The average head grade of the ore reserve included in the LOM plan, expressed in the same unit as cutoff_grade_unit. A key input to revenue and concentrate production forecasts.',
    `c1_cash_cost_usd_per_t` DECIMAL(18,2) COMMENT 'The C1 Cash Cost per tonne of ore or concentrate produced, expressed in USD. Represents direct cash costs of mining and processing excluding royalties, depreciation, and sustaining capital. Industry-standard cost metric for benchmarking and investor reporting.',
    `commodity` STRING COMMENT 'The primary mineral commodity targeted by this LOM plan (e.g., iron_ore, copper, lithium). Drives cut-off grade assumptions, processing routes, and commodity price inputs used in NPV/IRR calculations. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|zinc|bauxite|manganese|silver|other — promote to reference product]',
    `commodity_price_assumption_usd` DECIMAL(18,2) COMMENT 'The long-term commodity price assumption used in the LOM financial model, expressed in USD per tonne (or per lb/oz as applicable). A critical sensitivity input; changes to this assumption materially affect NPV and IRR outcomes.',
    `competent_person_name` STRING COMMENT 'Name of the Competent Person (JORC/SAMREC) or Qualified Person (NI 43-101/SEC S-K 1300) who has reviewed and signed off on the mineral resource and reserve estimates underpinning this LOM plan. Required for regulatory disclosure.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this LOM plan record was first created in the data platform. Supports audit trail, data lineage, and Silver Layer ingestion tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'The minimum economic grade of ore included in the LOM plan reserve, below which material is classified as waste. Expressed in the commodity-appropriate unit (e.g., % Fe for iron ore, % Cu for copper, g/t Au for gold). Drives ore/waste classification and reserve estimation.',
    `cutoff_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade value (e.g., pct for percentage Fe/Cu, g_per_t for grams per tonne Au/Ag, ppm for parts per million). Required to correctly interpret the cutoff_grade field.. Valid values are `pct|g_per_t|kg_per_t|ppm`',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'The real or nominal discount rate (%) applied in the Discounted Cash Flow (DCF) model to calculate the NPV of the LOM plan. Typically represents the Weighted Average Cost of Capital (WACC) or a project-specific hurdle rate.',
    `exchange_rate_assumption` DECIMAL(18,2) COMMENT 'The foreign exchange rate assumption used in the LOM financial model (e.g., AUD/USD, CLP/USD). Applied to convert local currency OPEX and CAPEX to USD for NPV/IRR calculations. A key sensitivity variable in the financial model.',
    `irr_pct` DECIMAL(18,2) COMMENT 'Internal Rate of Return (IRR) of the LOM plan expressed as a percentage. The discount rate at which the NPV of the project equals zero. Used alongside NPV as a primary investment hurdle metric for project sanctioning.',
    `lom_strip_ratio` DECIMAL(18,2) COMMENT 'The overall Life of Mine strip ratio, expressed as tonnes of waste per tonne of ore (t:t). A key economic indicator representing the ratio of overburden to ore that must be moved to extract the ore reserve. Calculated as total_waste_mt / total_ore_reserve_mt.',
    `mine_life_years` STRING COMMENT 'Total planned duration of the mine life in years, from first ore extraction to final closure. Derived from plan_start_date and plan_end_date for planning purposes; stored explicitly for reporting and regulatory disclosure.',
    `mining_method` STRING COMMENT 'Primary mining method employed in this LOM plan. open_cut refers to open-pit operations; underground includes methods such as Sub-Level Caving (SLC) and longwall; open_cut_underground indicates a combined operation.. Valid values are `open_cut|underground|open_cut_underground|in_situ_leach|placer`',
    `npv_musd` DECIMAL(18,2) COMMENT 'Net Present Value (NPV) of the LOM plan in millions of USD, calculated using the Discounted Cash Flow (DCF) methodology at the specified discount rate. Primary financial metric for investment decision-making and project approval.',
    `peak_annual_ore_mt` DECIMAL(18,2) COMMENT 'The maximum planned annual ore extraction rate in million tonnes per year (Mtpa) over the LOM plan. Used for infrastructure sizing, processing plant capacity planning, and peak CAPEX determination.',
    `plan_code` STRING COMMENT 'Externally-known business identifier for the LOM plan, typically assigned by the mine planning team in Deswik or Hexagon MinePlan. Format: LOM-{SITE}-{YEAR}. Used for cross-system referencing and regulatory submissions.. Valid values are `^LOM-[A-Z0-9]{3,10}-[0-9]{4}$`',
    `plan_end_date` DATE COMMENT 'The calendar date on which the LOM plan production schedule concludes, representing the projected end of mine life including rehabilitation and closure activities.',
    `plan_name` STRING COMMENT 'Human-readable name of the LOM plan (e.g., Pilbara Iron Ore LOM 2024 Base Case). Used for identification in planning reports and executive dashboards.',
    `plan_start_date` DATE COMMENT 'The calendar date from which the LOM plan production schedule commences. Represents the effective start of the planned mine life, aligned with the first scheduled ore extraction period.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the LOM plan. draft indicates work-in-progress; under_review indicates pending technical and executive sign-off; approved is the active SSOT plan; superseded indicates replaced by a newer version; archived indicates retired from active use.. Valid values are `draft|under_review|approved|superseded|archived`',
    `plan_type` STRING COMMENT 'Classification of the LOM plan scenario. base_case is the primary planning scenario; upside_case and downside_case represent sensitivity scenarios; closure_case models mine rehabilitation; feasibility is used for pre-production studies.. Valid values are `base_case|upside_case|downside_case|closure_case|feasibility`',
    `plan_version` STRING COMMENT 'Version identifier of the LOM plan (e.g., v1.0, v2.3). Enables tracking of iterative revisions and scenario comparisons over the mine life planning cycle.. Valid values are `^v[0-9]+.[0-9]+$`',
    `planned_recovery_rate_pct` DECIMAL(18,2) COMMENT 'The planned metallurgical recovery rate expressed as a percentage, representing the proportion of the valuable mineral extracted from the ore during processing. A critical input to concentrate production and revenue forecasting in the LOM plan.',
    `probable_reserve_mt` DECIMAL(18,2) COMMENT 'Probable Ore Reserve category in million tonnes, as defined by JORC/NI 43-101/SAMREC. Lower geological confidence than Proved Reserve but still economically viable and included in the LOM production schedule.',
    `proved_reserve_mt` DECIMAL(18,2) COMMENT 'Highest-confidence ore reserve category (Proved Reserve) in million tonnes, as defined by JORC/NI 43-101/SAMREC. Represents the portion of the ore body with the greatest geological certainty, used in bankable feasibility studies and investor disclosures.',
    `reporting_standard` STRING COMMENT 'The mineral resource and reserve reporting standard under which this LOM plan has been prepared and disclosed (e.g., JORC for Australia, NI 43-101 for Canada, SAMREC for South Africa, SEC S-K 1300 for US-listed companies).. Valid values are `JORC|NI_43-101|SAMREC|SEC_SK1300|CIM`',
    `resource_classification` STRING COMMENT 'The highest mineral resource classification category underpinning the LOM plan per JORC/NI 43-101/SAMREC standards. measured is highest confidence, indicated is moderate, inferred is lowest. Determines the regulatory disclosure obligations for the plan.. Valid values are `measured|indicated|inferred|measured_indicated`',
    `source_system` STRING COMMENT 'The operational system of record from which this LOM plan was sourced or generated (e.g., Deswik, Hexagon MinePlan, Geovia GEMS). Supports data lineage tracking and Silver Layer provenance in the Databricks Lakehouse.. Valid values are `Deswik|Hexagon_MinePlan|Geovia_GEMS|manual`',
    `total_capex_musd` DECIMAL(18,2) COMMENT 'Total planned Capital Expenditure (CAPEX) over the full mine life in millions of USD, including pre-production development, sustaining capital, and closure/rehabilitation costs. A primary input to NPV and IRR calculations in the LOM financial model.',
    `total_opex_musd` DECIMAL(18,2) COMMENT 'Total planned Operating Expenditure (OPEX) over the full mine life in millions of USD, encompassing mining, processing, G&A, and site services costs. Used in conjunction with revenue forecasts to derive LOM cash flow projections.',
    `total_ore_reserve_mt` DECIMAL(18,2) COMMENT 'Total Proved and Probable Ore Reserve underpinning the LOM plan, expressed in million tonnes (Mt). Classified per JORC/NI 43-101/SAMREC standards. This is the primary ore inventory figure driving the production schedule.',
    `total_waste_mt` DECIMAL(18,2) COMMENT 'Total planned waste rock and overburden movement over the full mine life in million tonnes. Used to calculate the Life of Mine (LOM) strip ratio and plan waste dump infrastructure and haulage requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this LOM plan record was last modified in the data platform. Used to detect changes, support incremental processing, and maintain audit trail integrity in the Silver Layer.',
    CONSTRAINT pk_lom_plan PRIMARY KEY(`lom_plan_id`)
) COMMENT 'Life of Mine (LOM) plan master record capturing the long-term production schedule, annual ore and waste movement targets, strip ratio projections, cut-off grade assumptions, NPV/IRR parameters, and CAPEX/OPEX phasing across the full mine life. Sourced from Deswik and Hexagon MinePlan. The SSOT for strategic mine planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each production schedule record in the lakehouse Silver layer. Primary key for this entity.',
    `bench_id` BIGINT COMMENT 'Foreign key linking to mine.bench. Business justification: production_schedule has bench_elevation_m (DECIMAL) and bench_sequence_number (INT) but no FK to bench table. Adding bench_id FK normalizes bench reference and removes redundant elevation and sequence',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: Production schedules reference capex budgets for sustaining capital planning, equipment replacement forecasting, and capital expenditure tracking. Core capital planning link for mining operations.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Production schedules must track which capital project enabled each mining area (pit pushback project, underground level development). Critical for capital effectiveness reporting, project performance ',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to finance.cash_flow_forecast. Business justification: Production schedules feed short-term cash flow forecasts for working capital management, liquidity planning, and operational cash forecasting. Operational treasury link for mining operations.',
    `commitment_id` BIGINT COMMENT 'Foreign key linking to community.community_commitment. Business justification: Production schedules must align with community commitments (employment quotas, local procurement targets, infrastructure delivery timing). Schedulers track commitment milestones. Real business process',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Production schedules incur costs tracked to specific cost centres for budget-vs-actual variance analysis, operational cost control, and AISC calculation. Core mining operational accounting link.',
    `lom_plan_id` BIGINT COMMENT 'Reference to the parent Life of Mine (LOM) plan from which this short-to-medium term production schedule is derived. Enables traceability from operational schedules back to the strategic LOM plan.',
    `mining_block_id` BIGINT COMMENT 'Reference to the specific mining block or ore block within the geological block model that this schedule targets. Sourced from Geovia GEMS or Hexagon MinePlan block model.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Production schedules near communities require stakeholder notification for blasting, noise, dust. Mining operations maintain notification registers linking schedules to affected stakeholder groups. Re',
    `opex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.opex_budget. Business justification: Production schedules are budgeted against opex budgets for cost forecasting, variance analysis, and budget-to-actual reconciliation. Core budget-to-actual link for mining operational accounting.',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Production schedules are constrained by ore reserves. Schedulers ensure planned extraction stays within declared reserve boundaries for regulatory compliance and investor reporting. Required for linki',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Production schedules specify which orebody is being mined in each period. Required for material tracking, grade forecasting, reserve depletion reporting, and compliance with mining permits.',
    `pit_design_id` BIGINT COMMENT 'Foreign key linking to mine.pit_design. Business justification: Production schedules are executed against a pit design. N:1 relationship (many schedules for one pit design). No bidirectional conflict. Valid planning link. Complements existing pit_or_stope_id gener',
    `pit_or_stope_stope_design_id` BIGINT COMMENT 'Reference to the specific open-cut pit or underground stope to which this schedule applies. Enables scheduling at the individual mining unit level for bench sequencing and stope optimization.',
    `plan_scenario_id` BIGINT COMMENT 'Foreign key linking to mine.mine_plan_scenario. Business justification: Production schedules can be generated from mine plan scenarios. N:1 relationship (many schedules derived from one scenario). No bidirectional conflict. Valid planning link.',
    `employee_id` BIGINT COMMENT 'Reference to the mine planning engineer or scheduler responsible for authoring this production schedule. Links to the workforce/employee master record in SAP HR.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Production schedules extract ore from specific prospects. Short-term planning references prospect boundaries, geological characteristics, and mineralization style for sequencing decisions. Essential f',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Production schedules reference resource estimates for tonnage and grade planning. Schedulers validate planned extraction against the resource estimate to ensure compliance with reserve declarations an',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Production schedules are derived from approved resource statements for compliance. Required for JORC/NI 43-101 reporting, ensuring schedules align with publicly reported reserves, and audit trails.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Production schedules require approved risk assessments before execution per mining safety regulations. Critical for demonstrating due diligence and regulatory compliance in production planning.',
    `rom_stockpile_id` BIGINT COMMENT 'Reference to the Run of Mine (ROM) stockpile pad designated to receive ore from this scheduled extraction. Links to the ROM pad master record for inventory and feed management to the processing plant.',
    `stope_design_id` BIGINT COMMENT 'Foreign key linking to mine.stope_design. Business justification: Production schedules for underground can reference stope designs. N:1 relationship (many schedules for one stope design). No bidirectional conflict. Valid planning link (alternative to pit_design for ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Production schedules must track source tenement for state/private royalty calculations, expenditure commitment substantiation, and regulatory production reporting. Essential for quarterly compliance r',
    `approved_date` DATE COMMENT 'The date on which the production schedule was formally approved by the mine planning or operations management team. Required for governance and audit trail of schedule sign-off.',
    `commodity_code` STRING COMMENT 'Standard code identifying the primary mineral commodity targeted by this schedule (e.g., FE for iron ore, CU for copper, COAL, LI for lithium, NI for nickel). Aligns with commodity trading and sales reporting conventions.. Valid values are `^[A-Z]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this production schedule record was first created in the system. Supports audit trail and data lineage requirements.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'The minimum economic grade threshold applied to classify material as ore versus waste in this schedule. Material below this grade is treated as waste. A fundamental mine planning parameter that determines ore tonnes and reserve classification.',
    `is_lom_schedule` BOOLEAN COMMENT 'Indicates whether this schedule record is part of the long-range Life of Mine (LOM) plan (True) or a short-to-medium term operational schedule (False). Used to filter LOM planning records from operational scheduling records in analytics.',
    `mine_site_code` BIGINT COMMENT 'Reference to the mine site or operation to which this production schedule applies. Links to the mine site master record for geographic and operational context.',
    `mining_method` STRING COMMENT 'Primary extraction method applicable to this schedule. open_cut refers to open-pit surface mining; underground refers to sub-surface methods such as Sub-Level Caving (SLC) or longwall; open_cut_underground indicates a combined operation.. Valid values are `open_cut|underground|open_cut_underground`',
    `period_end_date` DATE COMMENT 'The calendar date on which the scheduled production period ends. Defines the end boundary of the planning horizon for this schedule record.',
    `period_start_date` DATE COMMENT 'The calendar date on which the scheduled production period begins. Defines the start boundary of the planning horizon for this schedule record (e.g., first day of the week, month, or quarter).',
    `planned_blast_count` STRING COMMENT 'The number of planned blast events scheduled within the production period. Used for explosives procurement planning, blast crew scheduling, and regulatory notification compliance.',
    `planned_capex_usd` DECIMAL(18,2) COMMENT 'The planned Capital Expenditure (CAPEX) in USD allocated to this production schedule period, covering equipment, infrastructure, and development costs. Used for LOM capital planning and NPV/IRR analysis.',
    `planned_dilution_pct` DECIMAL(18,2) COMMENT 'The planned percentage of waste material mixed with ore during the extraction process (Dilution = waste mixed with ore during mining). Expressed as a percentage. Used to adjust head grade targets and assess ore quality at the ROM pad.',
    `planned_drill_metres` DECIMAL(18,2) COMMENT 'The total planned drilling metres for blast hole drilling associated with this schedule period. A key drill-and-blast planning metric used to size drilling equipment requirements and schedule blast events.',
    `planned_haulage_cycles` STRING COMMENT 'The planned number of truck haulage cycles required to move the scheduled ore and waste tonnes during the period. Used for fleet utilisation planning and fuel consumption estimation in the Fleet Management System (FMS).',
    `planned_opex_usd` DECIMAL(18,2) COMMENT 'The planned Operating Expenditure (OPEX) in USD associated with executing this production schedule for the period. Includes mining, haulage, and processing costs. Used for budget tracking and AISC (All-In Sustaining Cost) reporting.',
    `planned_ore_tonnes` DECIMAL(18,2) COMMENT 'The scheduled quantity of ore (in dry metric tonnes) to be extracted from the mining block or stope during the schedule period. Represents the primary production target and is the principal quantitative fact of this schedule record. Excludes waste and overburden.',
    `planned_recovery_rate_pct` DECIMAL(18,2) COMMENT 'The planned percentage of the valuable mineral expected to be recovered from the ore during mineral processing and beneficiation. Expressed as a percentage. Drives concentrate production targets and revenue forecasting.',
    `planned_strip_ratio` DECIMAL(18,2) COMMENT 'The planned ratio of waste tonnes to ore tonnes (waste:ore) for the schedule period. A key economic indicator in open-cut mining used to assess mining cost efficiency. Calculated as planned_waste_tonnes / planned_ore_tonnes but stored as a scheduled target value from the mine plan.',
    `planned_total_material_tonnes` DECIMAL(18,2) COMMENT 'Total planned material movement (ore plus waste, in dry metric tonnes) for the schedule period. Used for equipment allocation, fleet sizing, and haulage planning via the Fleet Management System (FMS).',
    `planned_waste_tonnes` DECIMAL(18,2) COMMENT 'The scheduled quantity of waste rock and overburden (in dry metric tonnes) to be moved during the schedule period. Used to calculate the planned strip ratio and assess haulage and equipment requirements.',
    `resource_classification` STRING COMMENT 'The JORC/CIM resource or reserve classification of the ore scheduled for extraction. Values align with JORC Code categories: measured (Measured Resource), indicated (Indicated Resource), inferred (Inferred Resource), probable_reserve (Probable Reserve), proved_reserve (Proved Reserve — highest confidence).. Valid values are `measured|indicated|inferred|probable_reserve|proved_reserve`',
    `schedule_basis` STRING COMMENT 'Indicates the planning basis of this schedule record. budget is the approved annual plan; forecast is a revised in-period estimate; actual_reconciled is a schedule updated with actual production data; scenario is a what-if planning scenario.. Valid values are `budget|forecast|actual_reconciled|scenario`',
    `schedule_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this production schedule record as sourced from Deswik or Hexagon MinePlan (e.g., PS-2024-Q3-001). Used for cross-system reference and operational reporting.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `schedule_name` STRING COMMENT 'Human-readable descriptive name for the production schedule (e.g., North Pit Q3 2024 Monthly Schedule). Used for identification in planning dashboards and operational reports.',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the production schedule. draft indicates under preparation; approved indicates sign-off by mine planning; active indicates currently being executed; superseded indicates replaced by a revised version; cancelled indicates no longer valid.. Valid values are `draft|approved|active|superseded|cancelled`',
    `schedule_type` STRING COMMENT 'Temporal horizon classification of the schedule. weekly covers 7-day operational targets; monthly covers 4-week periods; quarterly covers 13-week periods; annual covers full-year plans; lom refers to Life of Mine (LOM) long-range planning schedules.. Valid values are `weekly|monthly|quarterly|annual|lom`',
    `schedule_version` STRING COMMENT 'Incremental version number of the production schedule, incremented each time the schedule is revised and re-approved. Enables tracking of schedule revisions and comparison between versions for variance analysis.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this production schedule record was sourced. DESWIK indicates Deswik mine planning software; HEXAGON_MINEPLAN indicates Hexagon MinePlan; MANUAL indicates a manually entered schedule.. Valid values are `DESWIK|HEXAGON_MINEPLAN|MANUAL`',
    `target_head_grade` DECIMAL(18,2) COMMENT 'The planned average grade of the primary commodity (e.g., % Fe for iron ore, % Cu for copper, g/t Au for gold) in the ore scheduled for extraction. Expressed as a decimal fraction or percentage per commodity convention. Drives mill feed quality targets and recovery rate planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this production schedule record was last modified. Supports change tracking, audit trail, and incremental data pipeline processing.',
    CONSTRAINT pk_production_schedule PRIMARY KEY(`production_schedule_id`)
) COMMENT 'Short-to-medium term production schedule records (weekly, monthly, quarterly) defining planned ore tonnes, waste tonnes, grade targets, bench sequences, and equipment allocation per mining block or stope. Sourced from Deswik and Hexagon MinePlan. Drives daily operational targets and integrates with FMS for execution tracking.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`mining_block` (
    `mining_block_id` BIGINT COMMENT 'Unique surrogate identifier for the mining block record in the Databricks Silver Layer. Primary key for this spatial volumetric unit.',
    `bench_id` BIGINT COMMENT 'Foreign key linking to mine.bench. Business justification: mining_block has bench_number (INT) but no FK to bench table. Adding bench_id FK normalizes bench reference and removes redundant bench_number column. The bench table contains sequence_number which se',
    `block_model_id` BIGINT COMMENT 'Reference to the parent geological block model from which this block originates. Links the block to its resource estimation model in Geovia GEMS or Hexagon MinePlan.',
    `cultural_heritage_site_id` BIGINT COMMENT 'Foreign key linking to community.cultural_heritage_site. Business justification: Mining blocks must avoid or manage cultural heritage sites. Block extraction sequencing respects heritage exclusion zones and FPIC conditions. Real business process: heritage clearance, FPIC complianc',
    `functional_location_id` BIGINT COMMENT 'Reference to the mine site or operation where this block is located. Enables multi-site enterprise reporting and LOM planning aggregation.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Mining blocks inherit geological domain classification for resource reporting. Required for JORC/NI 43-101 compliance, reserve classification, and ensuring mining units align with estimation domains.',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Mining blocks are scheduled within LOM plan. N:1 relationship (many blocks in one LOM plan). No bidirectional conflict. Valid planning link.',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Mining blocks are classified against ore reserves. Reserve classification (proved/probable) is assigned to mining blocks for production reporting, reserve depletion tracking, and regulatory compliance',
    `pit_design_id` BIGINT COMMENT 'Foreign key linking to mine.pit_design. Business justification: Mining blocks are spatially located within pit designs. N:1 relationship (many blocks in one pit design). No bidirectional conflict. Valid spatial link.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Mining blocks are spatial subdivisions of prospects being extracted. Grade control and reconciliation require linking mined blocks back to the exploration prospect for variance analysis, resource mode',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Mining blocks inherit tonnage and grade from resource estimates. Block models are derived from resource estimates for mine planning and grade control. Essential for tracing mining blocks back to the s',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Resource blocks must be attributed to tenements for JORC/NI 43-101 reserve reporting, royalty calculations on extracted ore, and compliance with mining lease resource classification requirements.',
    `wireframe_id` BIGINT COMMENT 'Foreign key linking to geology.wireframe. Business justification: Mining blocks are spatially constrained by wireframe boundaries. Required for determining which blocks are inside ore zones, calculating ore/waste classification, and spatial queries.',
    `actual_extraction_date` DATE COMMENT 'Actual calendar date on which extraction of this block commenced. Populated post-extraction from FMS (Fleet Management System) or SCADA records. Used for schedule variance analysis and production reconciliation.',
    `block_code` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the mining block within the source geological block model (Geovia GEMS or Hexagon MinePlan). Used for cross-system reconciliation and grade control referencing.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `block_height_m` DOUBLE COMMENT 'Height dimension of the mining block in metres (Z-direction / bench height). Corresponds to the bench height in open-cut or the stope height in underground operations.',
    `block_length_m` DOUBLE COMMENT 'Length dimension of the mining block in metres (Y-direction in the block model). Used with width and height to compute block volume and in-situ tonnage.',
    `block_name` STRING COMMENT 'Human-readable descriptive name or label for the mining block, typically incorporating bench, drive, or stope identifiers for operational reference.',
    `block_status` STRING COMMENT 'Current lifecycle status of the mining block within the production workflow. Tracks progression from resource model through scheduling, active extraction, and post-extraction reconciliation.. Valid values are `planned|scheduled|active|extracted|reconciled|depleted`',
    `block_width_m` DOUBLE COMMENT 'Width dimension of the mining block in metres (X-direction in the block model). Together with height and length defines the block volume used for tonnage estimation.',
    `centroid_easting_m` DOUBLE COMMENT 'Easting coordinate (X-axis) of the block centroid in metres, referenced to the mine grid or UTM coordinate system. Used for spatial analysis, GIS integration, and block model visualisation.',
    `centroid_elevation_m` DOUBLE COMMENT 'Elevation (Z-axis) of the block centroid in metres above sea level (mRL). Defines the vertical position of the block within the orebody and bench/level structure.',
    `centroid_northing_m` DOUBLE COMMENT 'Northing coordinate (Y-axis) of the block centroid in metres, referenced to the mine grid or UTM coordinate system. Used for spatial analysis, GIS integration, and block model visualisation.',
    `commodity` STRING COMMENT 'Primary target mineral commodity for this block (e.g., iron ore, copper, coal, lithium, nickel). Drives processing route selection, grade reporting, and sales contract alignment. [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|lead|manganese|cobalt — promote to reference product]',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold applied to classify this block as ore or waste at the time of scheduling. Blocks with primary_grade below this value are classified as waste. Expressed in the same unit as primary_grade. Drives ore/waste classification and strip ratio calculations.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Estimated proportion of waste material mixed with ore during extraction, expressed as a decimal fraction (e.g., 0.05 = 5% dilution). Accounts for planned and unplanned dilution from adjacent waste rock. Used to adjust mined grade and tonnage estimates for production scheduling.',
    `extraction_sequence` STRING COMMENT 'Numeric sequence or priority order in which this block is scheduled for extraction within the mine plan. Lower values indicate earlier extraction. Drives the production schedule and LOM (Life of Mine) plan sequencing in Deswik and Hexagon MinePlan.',
    `hardness_index` DECIMAL(18,2) COMMENT 'Measure of rock hardness or grindability, typically expressed as Bond Work Index (BWi) in kWh/t. Used to estimate comminution energy requirements for SAG mill and HPGR circuit design and throughput forecasting.',
    `insitu_density` DECIMAL(18,2) COMMENT 'Estimated in-situ bulk density of the block material in tonnes per cubic metre (t/m³). Derived from geological sampling and used to convert block volume to tonnage. Critical input to resource estimation.',
    `insitu_tonnes` DECIMAL(18,2) COMMENT 'Estimated in-situ (undisturbed) mass of the block in dry metric tonnes, calculated from block volume and in-situ density. The primary tonnage measure used in resource estimation and LOM scheduling.',
    `level_or_drive` STRING COMMENT 'Underground level designation or drive name to which this block is assigned (e.g., 4200L, North Drive). Applicable for underground mining methods only; null for open-cut blocks.',
    `lom_period` STRING COMMENT 'Life of Mine (LOM) planning period to which this block is assigned, expressed as a year (e.g., 2027) or year-quarter (e.g., 2027-Q3). Enables aggregation of block-level data to LOM schedule periods for strategic planning and NPV/IRR analysis.. Valid values are `^[0-9]{4}(-Q[1-4]|-H[12])?$`',
    `material_type` STRING COMMENT 'Classification of the block material as ore, waste, low-grade, marginal ore, or overburden. Determines routing to processing plant, ROM pad, or waste dump. Directly impacts strip ratio calculations and cut-off grade decisions.. Valid values are `ore|waste|low_grade|marginal|overburden`',
    `mining_method` STRING COMMENT 'Extraction method applied to this block. Distinguishes open-cut from underground methods including Sub-Level Caving (SLC), longwall, room-and-pillar, cut-and-fill, and stoping. Drives drill-and-blast design and equipment selection. [ENUM-REF-CANDIDATE: open_cut|underground_sublevel_caving|underground_longwall|underground_room_and_pillar|underground_cut_and_fill|underground_stoping|underground_block_caving — promote to reference product]. Valid values are `open_cut|underground_sublevel_caving|underground_longwall|underground_room_and_pillar|underground_cut_and_fill|underground_stoping`',
    `model_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this blocks attributes in the source geological block model. Supports data lineage tracking, reconciliation workflows, and audit trail requirements under JORC and regulatory reporting frameworks.',
    `model_version` STRING COMMENT 'Version identifier of the geological block model from which this blocks attributes were sourced (e.g., v3.2.1). Enables traceability of resource estimates to specific model iterations for JORC/NI 43-101 compliance and audit purposes.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `oxidation_state` STRING COMMENT 'Weathering and oxidation classification of the block material. Fresh rock is unweathered; transitional is partially weathered; oxidised is fully weathered. Determines metallurgical processing route (e.g., oxide ore may require heap leaching vs. fresh ore flotation).. Valid values are `fresh|transitional|oxidised`',
    `pit_or_level_code` BIGINT COMMENT 'Reference to the open-cut pit or underground level/drive to which this block is assigned for extraction planning and scheduling.',
    `primary_grade` DECIMAL(18,2) COMMENT 'Estimated in-situ grade of the primary target element or commodity in the block, expressed as percentage (%) for base metals and iron ore, or grams per tonne (g/t) for precious metals. The principal economic value indicator for the block. Unit of measure is defined in primary_grade_unit.',
    `primary_grade_unit` STRING COMMENT 'Unit of measure for the primary element grade value. Percentage (pct) is used for iron ore, copper, and coal; grams per tonne (g/t) for gold and silver; parts per million (ppm) for trace elements.. Valid values are `pct|g_per_t|kg_per_t|ppm`',
    `recovery_factor` DECIMAL(18,2) COMMENT 'Estimated proportion of the target mineral that will be successfully extracted and recovered through the processing circuit, expressed as a decimal fraction (e.g., 0.88 = 88% recovery). Incorporates both mining recovery and metallurgical recovery. Used to calculate payable metal from the block.',
    `resource_classification` STRING COMMENT 'JORC/NI 43-101/SAMREC mineral resource or ore reserve classification assigned to this block. Measured Resource is the highest confidence category; Inferred Resource is the lowest. Proved Reserve and Probable Reserve are ore reserve categories derived from resource estimates. Critical for regulatory reporting and investor disclosure.. Valid values are `measured|indicated|inferred|proved_reserve|probable_reserve`',
    `rock_type` STRING COMMENT 'Lithological rock type classification for the block (e.g., GRANITE, BASALT, SHALE, MAGNETITE_QUARTZITE). Influences blast design parameters, comminution energy requirements, and processing circuit selection.',
    `scheduled_extraction_date` DATE COMMENT 'Planned calendar date on which extraction of this block is scheduled to commence, as defined in the current mine production schedule. Used for LOM planning, fleet scheduling, and processing plant feed forecasting.',
    `secondary_grade` DECIMAL(18,2) COMMENT 'Estimated in-situ grade of a secondary or by-product element in the block (e.g., cobalt in a nickel block, silver in a copper block). Unit of measure is defined in secondary_grade_unit. Null if no economically significant secondary element is present.',
    `secondary_grade_unit` STRING COMMENT 'Unit of measure for the secondary element grade value. Mirrors the unit options available for primary_grade_unit.. Valid values are `pct|g_per_t|kg_per_t|ppm`',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste/overburden tonnes to ore tonnes associated with this blocks extraction context. Expressed as waste:ore (e.g., 3.5 means 3.5 tonnes of waste per tonne of ore). Key economic indicator for open-cut mine viability and OPEX estimation.',
    CONSTRAINT pk_mining_block PRIMARY KEY(`mining_block_id`)
) COMMENT 'Spatial mining block representing a discrete volumetric unit of ore or waste material scheduled for extraction. Captures block centroid coordinates, elevation, bench number (open-cut) or level/drive (underground), estimated tonnes, in-situ grade by element, density, dilution factor, recovery factor, and extraction sequence priority. Sourced from Geovia GEMS and Hexagon MinePlan block models. The fundamental spatial unit linking the geological resource model to mine production scheduling, grade control, and reconciliation.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`blast_execution` (
    `blast_execution_id` BIGINT COMMENT 'Primary key for blast_execution',
    `bench_id` BIGINT COMMENT 'Foreign key linking to mine.bench. Business justification: blast_execution has bench_elevation_m (DECIMAL) but no FK to bench table. Adding bench_id FK normalizes bench reference and removes redundant elevation column. The bench table contains elevation_rl_m,',
    `blast_pattern_id` BIGINT COMMENT 'Foreign key linking to mine.blast_pattern. Business justification: blast_execution has blast_pattern_type (STRING) but no FK to blast_pattern table. Adding blast_pattern_id FK allows normalization of blast pattern details and removes redundant string column. The blas',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Blasting is high-risk activity requiring documented risk assessment before execution. Regulatory requirement in all mining jurisdictions. Complements existing incident link by capturing preventive con',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Explosives are regulated dangerous goods requiring chemical registration with SDS and handling procedures. Links blast to chemical register for regulatory compliance and emergency response planning.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Blast events are costed to specific cost centres for drill-and-blast cost tracking, explosive cost allocation, and AISC calculation. Direct operational cost link for mining activities.',
    `drill_pattern_id` BIGINT COMMENT 'Foreign key linking to mine.drill_pattern. Business justification: Blast execution involves drilling operations. Linking to drill_pattern provides access to hole diameter, burden, spacing, and other drilling parameters that inform blast design. No redundant columns t',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Blast operations require tracking which drill rig prepared the blast pattern for compliance verification, equipment performance analysis, and blast design optimization. Mining operations must trace bl',
    `functional_location_id` BIGINT COMMENT 'Reference to the mine site where the blast was executed. Enables multi-site reporting and site-level production reconciliation.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Blast events are tracked by geological domain for fragmentation and recovery analysis. Required for optimizing blast designs by rock type and understanding domain-specific mining performance.',
    `grade_control_block_id` BIGINT COMMENT 'Foreign key linking to mine.grade_control_block. Business justification: Blasts are designed based on grade control block classifications. N:1 relationship (many blasts can target one grade control block). No bidirectional conflict. Valid operational link.',
    `incident_id` BIGINT COMMENT 'Reference to an associated HSE incident record in IsoMetrix if a safety or environmental event (e.g., flyrock, misfire, dust, vibration exceedance) occurred during or as a result of this blast. Null if no incident was recorded.',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry_line. Business justification: Blast events generate cost postings via journal entries for explosive costs, contractor charges, and drill-and-blast cost allocation. Transactional accounting link for mining operational costs.',
    `mine_area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Blasts occur within defined mine areas. This FK provides geographic/operational context for blast execution records and enables area-level reporting and analysis. No redundant columns to remove.',
    `mining_block_id` BIGINT COMMENT 'Reference to the target mining block(s) associated with this blast event, linking blast execution to the geological block model and production schedule.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Blast events near communities trigger mandatory stakeholder notification under environmental permits. Operations track which stakeholder groups were notified for each blast. Real business process: bla',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Blast events occur within orebody boundaries. Essential for ore recovery tracking, dilution analysis, fragmentation assessment, and reconciliation of blasted material against geological models.',
    `pit_or_level_id` BIGINT COMMENT 'Reference to the specific open-cut pit or underground level where the blast was executed. Supports spatial analysis and strip ratio tracking by pit.',
    `employee_id` BIGINT COMMENT 'Reference to the shift supervisor or blast crew leader who oversaw the physical loading and firing of the blast. Supports accountability tracking and post-incident investigation.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Blast events are executed as part of a production schedule. N:1 relationship (many blasts per schedule). No bidirectional conflict. Valid operational link.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Blasts occur within prospect boundaries. Blast reporting and reconciliation track which prospect is being mined for production accounting, grade control, and resource depletion tracking. Required for ',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to mine.shift_report. Business justification: Blast events occur during a shift and are reported in shift report. N:1 relationship (many blasts per shift). No bidirectional conflict. Valid operational link.',
    `standard_job_id` BIGINT COMMENT 'Reference to the approved blast design record containing the planned hole pattern, spacing, burden, depth, explosive type, and initiation sequence. Links execution outcomes to the original design for compliance measurement.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Blast execution consumes explosives managed in material master. Critical for: explosive inventory tracking, blast cost accounting, regulatory compliance (explosives usage reporting), procurement plann',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Blasts target specific commodity zones (ore vs waste, different ore types). Critical for blast design optimization, fragmentation targets, and downstream processing requirements. New attribute needed ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Blast events tracked by tenement for expenditure commitment reporting, environmental compliance monitoring (noise/vibration limits per tenement conditions), and regulatory audit trails for explosives ',
    `training_record_id` BIGINT COMMENT 'Foreign key linking to hse.training_record. Business justification: Blasting requires certified shot-firer with current explosives license. Regulatory requirement to link blast execution to shot-firers training certification for compliance audits and incident investi',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Blast execution draws explosives from licensed explosive magazines (warehouse_location). Critical for: explosive inventory tracking, magazine stock reconciliation, regulatory compliance (explosive mov',
    `actual_explosive_mass_kg` DECIMAL(18,2) COMMENT 'Total mass of explosive in kilograms actually consumed during loading and detonation. Compared against planned to compute consumption variance and update explosive inventory in SAP MM.',
    `actual_hole_count` STRING COMMENT 'Number of blast holes actually drilled and loaded at the time of detonation. Compared against planned_hole_count to compute pattern compliance and identify deviations.',
    `airblast_overpressure_db` DECIMAL(18,2) COMMENT 'Peak airblast overpressure in decibels (dB) measured at the nearest sensitive receiver. Used to assess compliance with community noise and airblast limits specified in the mines Environmental Impact Statement (EIS) and operating licence.',
    `blast_approval_timestamp` TIMESTAMP COMMENT 'Date and time at which the blast design and loading plan received formal approval from the authorised blast engineer or mine manager. Required for regulatory compliance and audit trail under MSHA and state mining regulations.',
    `blast_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the blast event by the blast management system (e.g., SHOTPlus or BME). Used for cross-system traceability and regulatory reporting. Corresponds to the blast ID in Hexagon MinePlan and IsoMetrix incident linkage.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `blast_status` STRING COMMENT 'Current lifecycle state of the blast event, tracking progression from design through execution and post-blast clearance. Drives exclusion zone management and shift handover communications.. Valid values are `planned|approved|loaded|fired|post_blast_cleared|cancelled`',
    `blasted_rock_mass_t` DECIMAL(18,2) COMMENT 'Estimated total mass of rock in tonnes broken by the blast, derived from the blast volume and in-situ rock density. Used for powder factor calculation, production reconciliation, and haulage planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blast execution record was first created in the source blast management system. Used for audit trail and data lineage tracking in the Silver layer.',
    `detonation_timestamp` TIMESTAMP COMMENT 'Actual date and time at which the blast was detonated. The principal real-world event timestamp for the blast execution lifecycle. Recorded to millisecond precision for vibration and airblast monitoring correlation.',
    `dilution_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of waste material mixed with ore during the blast, expressed as a percentage of total blasted material. High dilution reduces head grade and processing efficiency. A key blast quality KPI tracked against the LOM plan.',
    `exclusion_zone_compliant` BOOLEAN COMMENT 'Indicates whether the exclusion zone was fully established and verified clear of personnel and equipment prior to detonation. Non-compliance triggers mandatory IsoMetrix HSE incident reporting.',
    `exclusion_zone_radius_m` DECIMAL(18,2) COMMENT 'Radius in metres of the mandatory exclusion zone established around the blast area prior to detonation. Determined by blast design and regulatory requirements to protect personnel and equipment from flyrock.',
    `fragmentation_p80_mm` DECIMAL(18,2) COMMENT 'Post-blast fragmentation size at the 80th percentile in millimetres, assessed via photogrammetry or image analysis (e.g., Split-Desktop, WipFrag). Indicates whether the blast achieved the target fragmentation for downstream crusher and mill feed requirements.',
    `fragmentation_target_p80_mm` DECIMAL(18,2) COMMENT 'Planned target fragmentation size at the 80th percentile in millimetres as specified in the blast design. Compared against actual fragmentation_p80_mm to assess blast quality and optimise future designs.',
    `initiation_system_type` STRING COMMENT 'Type of detonation initiation system used (e.g., electronic, non-electric NONEL, shock tube). Electronic systems (e.g., Orica i-kon, Dyno Nobel DigiShot) provide precise timing control for vibration management.. Valid values are `electronic|non_electric|electric|shock_tube`',
    `mining_method` STRING COMMENT 'Mining method applicable to this blast event. Distinguishes open-cut bench blasting from underground methods such as Sub-Level Caving (SLC) or longhole stoping, which have different design and safety requirements.. Valid values are `open_cut|underground_sublevel_caving|underground_longhole|underground_development`',
    `misfire_count` STRING COMMENT 'Number of holes that failed to detonate as planned during the blast event. Misfires are a critical safety hazard requiring mandatory reporting under MSHA and state mining regulations and must be managed per IsoMetrix HSE incident workflow.',
    `misfire_resolved` BOOLEAN COMMENT 'Indicates whether all misfires identified during this blast event have been safely resolved and cleared. A value of False triggers a mandatory hold on re-entry and follow-up IsoMetrix HSE action.',
    `ore_tonnes_blasted` DECIMAL(18,2) COMMENT 'Estimated mass of ore-grade material in tonnes broken by the blast, based on the geological block model classification. Used for production reconciliation, dilution tracking, and ROM pad inventory updates.',
    `peak_particle_velocity_mms` DECIMAL(18,2) COMMENT 'Maximum ground vibration measured in millimetres per second (mm/s) at the nearest sensitive receiver during the blast. Compared against regulatory and community limits to assess vibration compliance. Sourced from OSIsoft PI System seismograph integration.',
    `planned_burden_m` DECIMAL(18,2) COMMENT 'Designed distance in metres between the blast hole and the free face (burden). A critical blast design parameter controlling fragmentation, flyrock risk, and ground vibration.',
    `planned_explosive_mass_kg` DECIMAL(18,2) COMMENT 'Total mass of explosive in kilograms specified in the approved blast design across all holes. Used for powder factor calculation and explosive inventory planning.',
    `planned_hole_count` STRING COMMENT 'Number of blast holes specified in the approved blast design. Used as the baseline for pattern compliance assessment against actual drilled and loaded holes.',
    `planned_hole_depth_m` DECIMAL(18,2) COMMENT 'Designed depth of each blast hole in metres as specified in the blast design. Includes sub-drill allowance below the bench floor to ensure complete fragmentation at the toe.',
    `planned_spacing_m` DECIMAL(18,2) COMMENT 'Designed distance in metres between adjacent blast holes within a row. Together with burden, determines the powder factor and fragmentation distribution.',
    `powder_factor_kg_per_t` DECIMAL(18,2) COMMENT 'Ratio of actual explosive mass consumed (kg) to the total mass of rock blasted (tonnes). A key blast efficiency metric used to optimise fragmentation, digging rates, and explosive costs. Calculated as actual_explosive_mass_kg / blasted_rock_mass_t.',
    `re_entry_timestamp` TIMESTAMP COMMENT 'Date and time at which the exclusion zone was lifted and personnel were authorised to re-enter the blast area following post-blast inspection and fume clearance. Critical for shift productivity and safety compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the blast execution record, capturing design revisions, status transitions, or post-blast assessment updates.',
    `waste_tonnes_blasted` DECIMAL(18,2) COMMENT 'Estimated mass of waste rock in tonnes broken by the blast. Used for strip ratio calculation, waste dump scheduling, and overburden haulage planning.',
    CONSTRAINT pk_blast_execution PRIMARY KEY(`blast_execution_id`)
) COMMENT 'Complete drill-and-blast lifecycle record covering the planned design (hole pattern, spacing, burden, depth, explosive type, powder factor, fragmentation targets, initiation sequence) and actual execution outcomes (blast date/time, location, explosive consumption, detonation sequence, misfires, exclusion zone compliance, vibration/airblast monitoring, post-blast fragmentation assessment). Includes pattern compliance metrics and links to target mining blocks. Sourced from Hexagon MinePlan, blast management systems (BME, Orica SHOTPlus), and IsoMetrix. The SSOT for the full drill-and-blast cycle from design through execution to quality assessment.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`material_movement` (
    `material_movement_id` BIGINT COMMENT 'Primary key for material_movement',
    `asset_id` BIGINT COMMENT 'Reference to the haul truck, conveyor, or other equipment unit that performed this material movement. Sourced from the Fleet Management System (FMS) equipment registry.',
    `bench_id` BIGINT COMMENT 'Foreign key linking to mine.bench. Business justification: material_movement has source_bench_elevation_m (DECIMAL) but no FK to bench table. Adding bench_id FK normalizes bench reference and removes redundant elevation column. The bench table contains elevat',
    `blast_execution_id` BIGINT COMMENT 'Identifier of the drill-and-blast event that fragmented the material prior to this movement. Links material movement to the blast design and execution record for fragmentation quality and dilution analysis.',
    `functional_location_id` BIGINT COMMENT 'Reference to the destination location to which material was delivered, such as a crusher, processing plant, stockpile, or waste dump. Sourced from the mine location registry.',
    `dispatch_instruction_id` BIGINT COMMENT 'Reference to the dispatch instruction issued by the Fleet Management System (FMS) that authorised this material movement. Links to the originating dispatch event in Caterpillar MineStar.',
    `employee_id` BIGINT COMMENT 'Reference to the mine operator or truck driver who executed this material movement during the shift. Links to the workforce personnel record.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Material movements record geological domain for downstream processing optimization. Required for metallurgical blending, understanding domain-specific recovery rates, and plant feed quality control.',
    `grade_control_block_id` BIGINT COMMENT 'Foreign key linking to mine.grade_control_block. Business justification: Material movements are dispatched based on grade control block classification. N:1 relationship (many movements from one grade control block). No bidirectional conflict. Valid operational link.',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Haul road traffic generates community grievances (dust, road damage, safety, noise). Dispatch systems link specific movements to grievance incidents for investigation. Real business process: haulage i',
    `haul_route_id` BIGINT COMMENT 'Foreign key linking to mine.haul_route. Business justification: Material movement follows defined haul routes. Adding haul_route_id FK provides access to route characteristics and normalizes route reference. The haul_route table contains route_distance_km, making ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Material movement operations frequently involved in incidents (collisions, spills, rollovers). Links specific movement records to incident investigations for root cause analysis and equipment/location',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry_line. Business justification: Material movements generate cost postings for haulage costs, fuel consumption, and equipment cost allocation. Transactional accounting link for mining haulage and material handling costs.',
    `mining_block_id` BIGINT COMMENT 'Identifier of the geological block model cell or polygon from which the moved material originated. Enables grade reconciliation between the geological model and actual production, supporting JORC resource reporting.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Material movements are costed to cost centres for haulage cost allocation, unit cost calculation, and mining cost tracking. Core operational finance link. Reusing cost_centre_code as denormalized fiel',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Material movements track which orebody material originated from. Critical for production reconciliation, stockpile grade management, and validating resource model predictions against actual mined mate',
    `pit_or_level_id` BIGINT COMMENT 'Foreign key linking to mine.pit_or_level. Business justification: material_movement has source_pit_name (STRING) but no FK to pit_or_level table. Adding pit_or_level_id FK normalizes pit/level reference and removes redundant name column. The pit_or_level table conta',
    `primary_material_functional_location_id` BIGINT COMMENT 'Reference to the source location from which material was extracted or loaded, such as a bench, stope, ROM pad, or stockpile. Sourced from the mine location registry.',
    `production_schedule_id` BIGINT COMMENT 'Reference to the short-term or long-term production schedule plan against which this material movement is reconciled. Enables actual vs. planned production variance analysis and LOM (Life of Mine) schedule tracking.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Ore movements originate from specific prospects. Material tracking and grade reconciliation require prospect-level attribution for metallurgical accounting, blending decisions, and production reportin',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Material movements can be dispatched TO ROM stockpiles as destination. N:1 relationship (many movements to one stockpile). No bidirectional conflict. Valid operational link.',
    `safety_observation_id` BIGINT COMMENT 'Foreign key linking to hse.safety_observation. Business justification: Material movement operations are primary focus of safety observations for at-risk behaviors and conditions. Links movement records to leading indicator program for proactive risk management.',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to mine.shift_report. Business justification: Material movements occur during a shift and roll up to shift report. N:1 relationship (many movements per shift). No bidirectional conflict. Valid operational link.',
    `shift_schedule_id` BIGINT COMMENT 'Reference to the production shift during which this material movement occurred. Used for shift-based production reporting and reconciliation.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Ore movements must track source tenement for accurate royalty calculations (rates vary by tenement/state), production reporting by license area, and expenditure commitment substantiation for regulator',
    `waste_dump_id` BIGINT COMMENT 'Foreign key linking to mine.waste_dump. Business justification: Waste material movements are dispatched to waste dumps as destination. N:1 relationship (many movements to one dump). No bidirectional conflict. Valid operational link.',
    `commodity_code` STRING COMMENT 'Standardised code identifying the primary commodity contained in the moved material (e.g., FE for iron ore, CU for copper, COAL for coal, LI for lithium, NI for nickel). Aligns with commodity trading and sales reporting. [ENUM-REF-CANDIDATE: FE|CU|COAL|LI|NI|AU|AG|ZN — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this material movement record was first captured and persisted in the data platform. Distinct from the business event start timestamp.',
    `cycle_time_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time in minutes for the complete material movement cycle, from loading at the source to dumping at the destination and returning to queue. Key input for OEE (Overall Equipment Effectiveness) and fleet productivity analysis.',
    `data_source_system` STRING COMMENT 'Identifies the originating operational system that generated this material movement record. Supports data lineage, quality assessment, and reconciliation between FMS, SCADA, and manual entry sources.. Valid values are `MineStar|SCADA|manual|weighbridge|LIMS`',
    `destination_name` STRING COMMENT 'Human-readable name of the destination facility or location, such as the crusher name, processing plant name, stockpile identifier, ROM pad name, or waste dump name. Complements destination_location_id for operational reporting.',
    `dilution_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of waste or gangue material mixed with ore during extraction and loading, expressed as a percentage of total tonnes moved. Dilution reduces the effective head grade and impacts mineral processing recovery. Sourced from geological model and blast design.',
    `dry_tonnes` DECIMAL(18,2) COMMENT 'Weight of material in metric dry tonnes, calculated by adjusting tonnes_delivered for moisture content. Dry tonnes is the standard unit for commodity sales contracts, JORC resource reporting, and revenue recognition under CIF/FOB terms.',
    `estimated_grade_pct` DECIMAL(18,2) COMMENT 'Estimated head grade of the primary commodity in the moved material, expressed as a percentage (e.g., % Fe for iron ore, % Cu for copper). Derived from the geological block model at the source location. Used for ore quality tracking and production reconciliation.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether this material movement record has been reconciled against the production plan, weighbridge data, and geological model as part of the mine production reconciliation process. True = reconciled; False = pending reconciliation.',
    `material_description` STRING COMMENT 'Free-text description of the material being moved, providing additional context beyond the material type classification, such as lithology, ore zone name, or specific waste rock type.',
    `material_type` STRING COMMENT 'Classification of the material being moved. Distinguishes between ore (economic mineral-bearing rock), waste (non-economic rock), low-grade ore, overburden (material above the ore body), and Run of Mine (ROM) material. Critical for strip ratio and production reconciliation.. Valid values are `ore|waste|low_grade|overburden|ROM`',
    `mining_method` STRING COMMENT 'The mining method used to extract the material at the source location. Distinguishes between open-cut (surface) and underground methods including Sub-Level Caving (SLC), longwall, and room-and-pillar. Drives operational reporting and cost allocation.. Valid values are `open_cut|underground|sub_level_caving|longwall|room_and_pillar`',
    `moisture_pct` DECIMAL(18,2) COMMENT 'Estimated moisture content of the moved material expressed as a percentage of total weight. Moisture affects the dry tonne calculation, commodity grade reporting, and processing plant feed quality. Sourced from geological sampling or SCADA sensors.',
    `movement_end_timestamp` TIMESTAMP COMMENT 'The real-world timestamp when the material movement was completed, i.e., when the haul truck or conveyor finished dumping or delivering material at the destination location.',
    `movement_reference_number` STRING COMMENT 'Externally-known business identifier for this material movement transaction, formatted as MM-{YEAR}-{SEQUENCE}. Used for cross-system reconciliation between FMS, SCADA, and ERP.. Valid values are `^MM-[0-9]{4}-[0-9]{8}$`',
    `movement_start_timestamp` TIMESTAMP COMMENT 'The real-world timestamp when the material movement commenced, i.e., when the haul truck or conveyor began loading or transporting material at the source location. Principal business event time for this transaction.',
    `movement_status` STRING COMMENT 'Current lifecycle status of the material movement transaction as tracked by the Fleet Management System (FMS). Drives production reporting and dispatch reconciliation.. Valid values are `dispatched|in_progress|completed|cancelled|rejected`',
    `movement_type` STRING COMMENT 'Classification of the movement activity type. Primary haul is direct extraction to destination; rehandle is movement of previously stockpiled material; stockpile reclaim is feeding from a stockpile to the plant; ROM feed is delivery to the Run of Mine (ROM) pad; waste dump is disposal of waste rock.. Valid values are `primary_haul|rehandle|stockpile_reclaim|ROM_feed|waste_dump`',
    `payload_tonnes` DECIMAL(18,2) COMMENT 'Actual payload weight in metric tonnes as measured by the trucks on-board payload management system (TPMS) at the point of loading. Distinct from tonnes_loaded (weighbridge) and tonnes_delivered (destination). Used for truck utilisation and overloading compliance.',
    `shift_date` DATE COMMENT 'The calendar date of the production shift during which this material movement occurred. Used as the primary date dimension for daily production reporting, shift-based reconciliation, and operational dashboards.',
    `strip_ratio_contribution` DECIMAL(18,2) COMMENT 'The incremental contribution of this movement to the strip ratio calculation, expressed as the ratio of waste tonnes to ore tonnes moved in this transaction. Aggregated to compute the overall strip ratio (overburden to ore ratio) for the pit or mining area.',
    `tonnes_delivered` DECIMAL(18,2) COMMENT 'Net weight in metric tonnes of material delivered and confirmed at the destination location, as recorded by the FMS or weighbridge at the crusher or stockpile. May differ from tonnes_loaded due to spillage or measurement variance.',
    `tonnes_loaded` DECIMAL(18,2) COMMENT 'Gross weight in metric tonnes of material loaded onto the haul truck or conveyor at the source location, as measured by the on-board payload management system or weighbridge.',
    `transport_mode` STRING COMMENT 'The mode of transport used to move material from source to destination. Distinguishes between haul truck, conveyor belt, rail, front-end loader (FEL), and underground truck, enabling mode-specific cost and productivity analysis.. Valid values are `haul_truck|conveyor|rail|front_end_loader|underground_truck`',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this material movement record was last modified in the data platform, such as after a correction or status update from the FMS.',
    CONSTRAINT pk_material_movement PRIMARY KEY(`material_movement_id`)
) COMMENT 'Transactional record of all material movement from source (bench, stope, ROM pad, stockpile) to destination (crusher, stockpile, processing plant, waste dump). Captures tonnes moved, source location, destination location, material type (ore, waste, low-grade), estimated grade, truck/conveyor ID, shift, operator, and dispatch instruction reference. Sourced from Caterpillar MineStar FMS and dispatch systems. The SSOT for ore, waste, and material flow tracking across the mine.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`rom_stockpile` (
    `rom_stockpile_id` BIGINT COMMENT 'Unique surrogate identifier for the ROM stockpile master record. Primary key for this entity. MASTER_RESOURCE role — serves as the globally unique reference for all ROM pad configuration, inventory, and grade management records.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: ROM stockpiles are managed under specific cost centres for inventory valuation, ore handling cost tracking, and stockpile management cost allocation. Asset-based costing for mining operations.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: ROM stockpiles may require permits for dust emissions and stormwater runoff management. Links stockpile operations to environmental compliance obligations and monitoring requirements.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: ROM stockpiles (pads, infrastructure) are capitalized as fixed assets for depreciation, asset register management, and balance sheet reporting. Asset accounting link for mining infrastructure.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: ROM stockpiles are segregated by geological domain for metallurgical performance. Required for blending strategies, recovery optimization, and managing domain-specific processing characteristics.',
    `lom_plan_id` BIGINT COMMENT 'Reference to the Life of Mine (LOM) plan under which this ROM stockpile is designed and scheduled. Links stockpile configuration to the governing mine plan for long-term production scheduling and capital planning.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: ROM stockpiles contain material from specific orebodies. Essential for blending strategies, grade management, metallurgical performance prediction, and traceability from pit to plant.',
    `pit_design_id` BIGINT COMMENT 'Reference to the open-cut pit or underground mining area that primarily feeds this ROM stockpile. Supports production reconciliation and ore source tracking.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: ROM stockpiles often blend ore from multiple tenements; tracking primary source tenement enables royalty allocation, grade reconciliation by license area, and accurate production reporting for regulat',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: ROM stockpiles accumulate ore from specific prospects. Stockpile management tracks source prospect for blending decisions, metallurgical planning, and grade reconciliation. Critical for managing ore q',
    `bulk_density_t_m3` DECIMAL(18,2) COMMENT 'Estimated bulk density of the ROM stockpile material in tonnes per cubic metre. Used to convert survey-derived volume measurements to tonne estimates for inventory reconciliation.',
    `commissioned_date` DATE COMMENT 'Date on which the ROM stockpile pad was formally commissioned and made available for ore dumping operations. Marks the start of the operational lifecycle for this pad.',
    `current_inventory_t` DECIMAL(18,2) COMMENT 'Current estimated tonnes of ore on the ROM stockpile pad at the time of the last survey or inventory snapshot. Sourced from Caterpillar MineStar truck dispatch data and periodic survey reconciliation.',
    `cut_off_grade_pct` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold applied to classify material as ore (vs waste) for this stockpile. Material below cut-off grade is directed to waste dumps. Determined by LOM economic parameters.',
    `decommissioned_date` DATE COMMENT 'Date on which the ROM stockpile pad was formally decommissioned and removed from active operations. Null for currently active pads. Supports LOM planning and mine rehabilitation scheduling.',
    `design_capacity_t` DECIMAL(18,2) COMMENT 'Maximum engineered storage capacity of the ROM stockpile pad in dry metric tonnes (DMT) as per mine design specifications. Used for capacity planning, haulage scheduling, and LOM planning.',
    `dilution_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of waste rock (gangue) mixed with ore in the ROM stockpile due to mining dilution. High dilution reduces head grade and processing plant recovery. Tracked against mine design dilution targets.',
    `easting_m` DECIMAL(18,2) COMMENT 'Easting coordinate of the ROM stockpile pad centroid in metres, referenced to the mine site local grid or MGA/UTM coordinate system. Used for GIS mapping and spatial analysis.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the ROM stockpile pad base in metres above sea level (mAHD or equivalent datum). Used for drainage design, geotechnical assessment, and survey volume calculations.',
    `environmental_permit_ref` STRING COMMENT 'Reference number of the environmental permit or approval governing the operation of this ROM stockpile pad, including conditions related to dust suppression, drainage, and contamination prevention.',
    `fms_zone_code` STRING COMMENT 'Zone code assigned to this ROM stockpile in the Caterpillar MineStar Fleet Management System (FMS). Used to track haul truck dump assignments, cycle times, and tonne delivery records to this pad.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `geotechnical_zone` STRING COMMENT 'Geotechnical classification zone of the stockpile pad foundation and surrounding area. Informs structural stability assessments, load-bearing capacity, and safe stacking height limits for the ROM pad.',
    `head_grade_cu_pct` DECIMAL(18,2) COMMENT 'Estimated head grade of copper (Cu) content in the ROM stockpile expressed as a percentage. Applicable for copper operations; null for non-copper commodities. Sourced from LabWare LIMS assay results.',
    `head_grade_fe_pct` DECIMAL(18,2) COMMENT 'Estimated head grade of iron (Fe) content in the ROM stockpile expressed as a percentage. Derived from assay data and geological block model estimates. Used for processing plant feed quality management.',
    `head_grade_primary_pct` DECIMAL(18,2) COMMENT 'Estimated head grade of the primary valuable element in the ROM stockpile expressed as a percentage, applicable to the commodity type (e.g., Li2O for lithium, Ni for nickel, ash content for coal). Sourced from LabWare LIMS assay results and geological model.',
    `inventory_snapshot_timestamp` TIMESTAMP COMMENT 'Date and time at which the current inventory estimate was last updated or surveyed. Critical for understanding the currency of the inventory figure and scheduling reclaim operations.',
    `max_stack_height_m` DECIMAL(18,2) COMMENT 'Maximum permitted stacking height of ore on the ROM stockpile pad in metres, as determined by geotechnical assessment and mine design. Exceeding this limit creates slope stability and safety risks.',
    `mine_site_code` BIGINT COMMENT 'Reference to the mine site where this ROM stockpile is physically located. Links to the mine site master record for geographic and operational context.',
    `mining_method` STRING COMMENT 'Primary mining method used to extract ore delivered to this ROM stockpile. Determines operational characteristics, dilution profiles, and equipment types associated with the material.. Valid values are `open_cut|underground|open_cut_underground|in_situ`',
    `moisture_content_pct` DECIMAL(18,2) COMMENT 'Estimated moisture content of the ROM stockpile material expressed as a percentage. Critical for accurate tonne reconciliation (wet vs dry), processing plant feed management, and transport logistics (weight limits).',
    `northing_m` DECIMAL(18,2) COMMENT 'Northing coordinate of the ROM stockpile pad centroid in metres, referenced to the mine site local grid or MGA/UTM coordinate system. Used for GIS mapping and spatial analysis.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, or contextual information about the ROM stockpile pad not captured in structured fields (e.g., temporary access restrictions, blending instructions, survey anomalies).',
    `ore_recovery_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of in-situ ore successfully extracted and delivered to the ROM stockpile relative to the geological resource model estimate. Tracks ore loss during mining operations.',
    `pad_area_m2` DECIMAL(18,2) COMMENT 'Total surface area of the ROM stockpile pad in square metres as per mine design. Used for capacity calculations, survey volume estimation, and infrastructure planning.',
    `reconciliation_variance_t` DECIMAL(18,2) COMMENT 'Difference between scheduled tonnes and actual surveyed inventory tonnes for the current period. Positive value indicates over-delivery; negative indicates under-delivery. Key metric for production schedule adherence and ore loss/dilution tracking.',
    `scada_tag_code` STRING COMMENT 'OSIsoft PI System tag identifier associated with this ROM stockpile for real-time process data monitoring (e.g., belt scale feed rate, moisture sensor readings). Enables integration between the master record and time-series operational data.. Valid values are `^[A-Z0-9._-]{1,64}$`',
    `scheduled_tonnes_t` DECIMAL(18,2) COMMENT 'Planned tonnes to be delivered to this ROM stockpile in the current production scheduling period as per the mine production schedule. Used for reconciliation variance calculation against actual inventory.',
    `stockpile_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the ROM stockpile pad, used across operational systems including Caterpillar MineStar, OSIsoft PI, and mine planning tools. Unique within the mine site.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `stockpile_name` STRING COMMENT 'Human-readable descriptive name of the ROM stockpile pad (e.g., North ROM Pad 1, Crusher Feed Stockpile A). Used in operational reporting and mine planning communications.',
    `stockpile_status` STRING COMMENT 'Current operational lifecycle status of the ROM stockpile pad. Active = receiving material; Reclaiming = material being drawn down to processing plant; Full = at design capacity; Depleted = empty; On Hold = temporarily suspended.. Valid values are `active|inactive|reclaiming|full|depleted|on_hold`',
    `stockpile_type` STRING COMMENT 'Categorical classification of the stockpiles operational role within the ore flow: ROM Pad (direct dump from haul trucks), Crusher Feed, Blend Stockpile, Low-Grade, High-Grade, or Waste. Drives processing plant feed sequencing.. Valid values are `rom_pad|crusher_feed|blend_stockpile|low_grade|high_grade|waste`',
    `surveyed_volume_m3` DECIMAL(18,2) COMMENT 'Volume of material on the ROM stockpile pad as measured by the most recent survey (drone, LiDAR, or conventional survey). Combined with bulk density to derive tonne inventory estimate.',
    CONSTRAINT pk_rom_stockpile PRIMARY KEY(`rom_stockpile_id`)
) COMMENT 'Master record of Run of Mine (ROM) stockpile areas including stockpile name, location, design capacity, ore type classification, and reclaim priority. Includes time-series inventory snapshots capturing current tonnes on pad, estimated head grade by element, ore type split, moisture content, and reconciliation variance against production schedule. Sourced from Caterpillar MineStar, survey data, and OSIsoft PI. The SSOT for ROM pad configuration, inventory state, and grade management for processing plant feed quality.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`haulage_cycle` (
    `haulage_cycle_id` BIGINT COMMENT 'Unique surrogate identifier for each individual haul truck cycle record in the Silver layer. Primary key generated by the Databricks lakehouse ingestion pipeline from Caterpillar MineStar Fleet Management System (FMS) telemetry data.',
    `bench_id` BIGINT COMMENT 'Identifier of the mining bench or level from which the material was extracted for this cycle. Aligns with the mine design bench nomenclature in Hexagon MinePlan. Used for grade control, production scheduling, and geological reconciliation.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Individual haulage cycles contribute to cost centre actuals for fleet cost tracking, fuel cost allocation, and productivity analysis. Operational cost allocation for mining haulage.',
    `employee_id` BIGINT COMMENT 'Reference to the mine worker who operated the haul truck during this cycle. Links to the workforce/personnel master record. Used for operator performance analysis and fatigue management compliance.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Haulage cycles track geological domain of source material for blending control. Required for real-time stockpile management, ensuring plant feed meets metallurgical specifications.',
    `grade_control_block_id` BIGINT COMMENT 'Foreign key linking to mine.grade_control_block. Business justification: Haulage cycles load material classified by grade control blocks. N:1 relationship (many cycles from one grade control block). No bidirectional conflict. Valid operational link.',
    `haul_route_id` BIGINT COMMENT 'Foreign key linking to mine.haul_route. Business justification: haulage_cycle represents movement along defined haul routes. Adding haul_route_id FK provides access to route characteristics (gradient, surface type, speed limits). The haul_route table contains rout',
    `mining_block_id` BIGINT COMMENT 'Foreign key linking to mine.mining_block. Business justification: Haulage cycles load from mining blocks. N:1 relationship (many cycles from one block). No bidirectional conflict. Valid operational link.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Haulage cycles transport material from specific orebodies to destinations. Required for ore tracking, stockpile blending decisions, and linking equipment productivity to geological sources.',
    `pit_or_level_id` BIGINT COMMENT 'Foreign key linking to mine.pit_or_level. Business justification: Haulage cycles originate from pits or underground levels. This FK provides source location context for material movement tracking. No redundant columns to remove.',
    `asset_id` BIGINT COMMENT 'Reference to the haul truck asset that performed this cycle. Links to the equipment/fleet master record in the Fleet Management System (FMS) and Infor EAM asset registry.',
    `functional_location_id` BIGINT COMMENT 'Reference to the spatial location (bench, pit, stope, or ROM pad) from which the truck was loaded. Links to the mine location/spatial master for origin-based production and grade tracking.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Haulage cycles are executed against a production schedule. N:1 relationship (many cycles per schedule). No bidirectional conflict. Valid operational link.',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Haulage cycles can dump to ROM stockpiles. N:1 relationship (many cycles to one stockpile). No bidirectional conflict. Valid operational link.',
    `safety_observation_id` BIGINT COMMENT 'Foreign key linking to hse.safety_observation. Business justification: Haulage cycles are high-risk activities frequently observed for speed, fatigue, and interaction compliance. Links specific cycles to safety observations for behavior-based safety program tracking.',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to mine.shift_report. Business justification: Haulage cycles occur during a shift and roll up to shift report. N:1 relationship (many cycles per shift). No bidirectional conflict. Valid operational link.',
    `shift_schedule_id` BIGINT COMMENT 'Reference to the mine shift during which this haulage cycle occurred. Links to the shift schedule master for shift-based production reporting and crew allocation analysis.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Haulage cycles consume fuel tracked in material master for cost accounting. Business need: fuel consumption tracking, haulage cost calculation, fuel inventory management, procurement planning. Real pr',
    `tertiary_haulage_functional_location_id` BIGINT COMMENT 'Reference to the primary haul road segment traversed during this cycle. Used for road condition monitoring, fuel consumption benchmarking by route, and haulage route optimisation.',
    `waste_dump_id` BIGINT COMMENT 'Foreign key linking to mine.waste_dump. Business justification: Haulage cycles can dump waste to waste dumps. N:1 relationship (many cycles to one dump). No bidirectional conflict. Valid operational link.',
    `cycle_end_timestamp` TIMESTAMP COMMENT 'The real-world timestamp when the haul truck completed the empty return haul and the cycle was closed. Used to calculate total cycle time and production throughput per shift.',
    `cycle_reference` STRING COMMENT 'Externally-known business identifier for the haulage cycle as assigned by Caterpillar MineStar FMS. Used for cross-system traceability and operational reporting. Format: CYC-YYYYMMDD-XXXXXX.. Valid values are `^CYC-[0-9]{8}-[A-Z0-9]{6}$`',
    `cycle_start_timestamp` TIMESTAMP COMMENT 'The real-world timestamp when the haul truck arrived at the loading point and the cycle commenced (spot time begins). Sourced from Caterpillar MineStar GPS telemetry. Principal business event timestamp for the cycle.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the haulage cycle record. completed indicates a full cycle was recorded; aborted indicates the cycle was interrupted; partial indicates incomplete telemetry data; under_review indicates data quality investigation is in progress.. Valid values are `completed|aborted|partial|under_review`',
    `data_source_system` STRING COMMENT 'Identifies the operational system of record from which this cycle record was sourced. Primarily minestar (Caterpillar MineStar FMS GPS telemetry), but may be manual for dispatcher-entered corrections, scada for SCADA-integrated sites, or pi_system for OSIsoft PI System integrations.. Valid values are `minestar|manual|scada|pi_system`',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Estimated proportion (0.0 to 1.0) of waste or gangue material mixed with ore in this truck load, as assessed by the grade control model. Dilution (waste mixed with ore during mining) directly impacts mill feed grade and recovery rate. Key metric for mine planning reconciliation.',
    `dump_time_seconds` STRING COMMENT 'Duration in seconds from when the truck arrived at the dump point to when it departed after discharging its load. Includes tipping and body lowering time. Used in cycle time analysis and dump point throughput modelling.',
    `dump_type` STRING COMMENT 'Categorical classification of the dump destination for this cycle. Values: crusher (primary crusher feed), rom_pad (Run of Mine stockpile pad), stockpile (grade-segregated stockpile), waste_dump (permanent waste rock dump), tsf (Tailings Storage Facility). Drives material flow reconciliation.. Valid values are `crusher|rom_pad|stockpile|waste_dump|tsf`',
    `fuel_consumption_litres` DECIMAL(18,2) COMMENT 'Total diesel fuel consumed in litres during this haulage cycle as recorded by the trucks on-board fuel monitoring system integrated with Caterpillar MineStar. Used for C1 (C1 Cash Cost) per tonne calculation, OPEX tracking, and GHG emissions reporting.',
    `haul_empty_time_seconds` STRING COMMENT 'Duration in seconds for the empty (return) haul from the dump destination back to the loading point. Compared against haul full time to assess road grade asymmetry and return route efficiency.',
    `haul_full_time_seconds` STRING COMMENT 'Duration in seconds for the loaded (full) haul from the loading point to the dump destination. Reflects haul road conditions, grade, distance, and truck speed. Key input for haulage route optimisation and fuel modelling.',
    `is_overloaded` BOOLEAN COMMENT 'Indicates whether the truck payload exceeded the nominal rated payload capacity for this cycle (True = overloaded). Overloading causes accelerated tyre and suspension wear, increases maintenance costs, and may breach equipment warranty conditions. Sourced from Caterpillar MineStar TPMS.',
    `is_rehandle` BOOLEAN COMMENT 'Indicates whether this cycle involved rehandling of previously stockpiled material (True = rehandle). Rehandle cycles are tracked separately from primary extraction cycles for accurate OPEX (Operating Expenditure) per tonne reporting and production efficiency analysis.',
    `load_pass_count` STRING COMMENT 'Number of bucket/dipper passes made by the loading unit (excavator or shovel) to fill the haul truck to its payload target. Used in truck-shovel match factor analysis and loader bucket fill factor assessment.',
    `load_time_seconds` STRING COMMENT 'Duration in seconds from when loading commenced to when the truck departed the loading point with a full load. Reflects loader productivity and number of passes required. Used in truck-shovel match factor analysis.',
    `material_type` STRING COMMENT 'Classification of the material hauled during this cycle. Distinguishes ore (economic mineral-bearing rock) from waste (gangue and overburden) for strip ratio calculation, grade control, and production reconciliation. [ENUM-REF-CANDIDATE: ore|waste|low_grade_ore|overburden|topsoil|tailings — promote to reference product if additional types are required]. Valid values are `ore|waste|low_grade_ore|overburden|topsoil`',
    `nominal_payload_tonnes` DECIMAL(18,2) COMMENT 'The rated/design payload capacity of the haul truck model in metric tonnes as specified by the manufacturer. Used as the denominator for payload utilisation percentage calculation and overload detection.',
    `ore_grade_estimate` DECIMAL(18,2) COMMENT 'Estimated head grade of the material in the truck load as assigned by the grade control model at the time of loading (e.g., % Fe for iron ore, % Cu for copper). Nullable for waste loads. Used for production grade reconciliation against JORC resource model.',
    `payload_tonnes` DECIMAL(18,2) COMMENT 'Actual measured payload weight of the truck load in metric tonnes, as recorded by the on-board payload monitoring system (TPMS) integrated with Caterpillar MineStar. Primary quantitative measure of material moved per cycle. Used for production reconciliation and OEE (Overall Equipment Effectiveness) calculation.',
    `production_date` DATE COMMENT 'Calendar date on which this haulage cycle occurred, derived from the cycle start timestamp. Used as the primary date dimension key for daily production reporting, shift reconciliation, and LOM (Life of Mine) plan vs actual tracking.',
    `queue_time_seconds` STRING COMMENT 'Duration in seconds the truck spent waiting in queue at the dump point before being able to discharge its load. Indicates crusher or dump point congestion. Used for bottleneck analysis and production scheduling optimisation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this haulage cycle record was first ingested and created in the Databricks Silver layer. Used for data lineage, audit trail, and SLA monitoring of the FMS telemetry pipeline.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this haulage cycle record was last modified in the Databricks Silver layer, including dispatcher corrections, payload adjustments, or data quality remediation. Supports audit trail and change tracking.',
    `spot_time_seconds` STRING COMMENT 'Duration in seconds from when the truck arrived at the loading point to when loading commenced. Measures truck positioning efficiency. A key component of the cycle time breakdown used in truck-shovel match factor analysis.',
    `total_cycle_time_seconds` STRING COMMENT 'Total elapsed time in seconds for the complete haulage cycle from spot to end of empty return haul. Sum of spot, load, haul full, queue, dump, and haul empty times. Primary KPI input for truck productivity and OEE (Overall Equipment Effectiveness) reporting.',
    CONSTRAINT pk_haulage_cycle PRIMARY KEY(`haulage_cycle_id`)
) COMMENT 'Transactional record of an individual haul truck cycle from loading point to dump point, capturing truck ID, operator ID, loader/excavator ID, load origin (bench, stockpile), dump destination (crusher, stockpile, waste dump), payload tonnes, cycle time breakdown (spot, load, haul full, queue, dump, haul empty), distance travelled, fuel consumption, and road segment. Sourced from Caterpillar MineStar FMS GPS telemetry. Enables truck-shovel match analysis, OEE calculation, and haulage route optimization.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`grade_control_block` (
    `grade_control_block_id` BIGINT COMMENT 'Unique surrogate identifier for the grade control block record in the Databricks Silver Layer. Primary key for this entity.',
    `bench_id` BIGINT COMMENT 'Foreign key linking to mine.bench. Business justification: grade_control_block has bench_name (STRING) and bench_elevation_m (DECIMAL) but no FK to bench table. Adding bench_id FK normalizes bench reference and removes redundant name and elevation columns. Th',
    `block_model_cell_id` BIGINT COMMENT 'Foreign key linking to geology.block_model_cell. Business justification: Grade control blocks are derived from block model cells for operational execution. Essential for linking short-term mine plans to long-term resource models and tracking model accuracy.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Grade control blocks are classified by geological domain for estimation consistency. Critical for applying correct grade estimation parameters and ensuring operational classification matches resource ',
    `sample_batch_id` BIGINT COMMENT 'Identifier of the assay sample batch in LabWare LIMS from which the grade data for this block was sourced. Provides traceability from the grade control block back to the laboratory analysis records.',
    `mining_block_id` BIGINT COMMENT 'Reference identifier linking this grade control block to the corresponding mining block or polygon in the mine planning system (Hexagon MinePlan or Deswik). Enables reconciliation between grade control and mine plan.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Grade control blocks are spatial subdivisions of orebodies for operational ore/waste classification. Critical for dispatch decisions, dilution tracking, and production reconciliation against orebody m',
    `pit_or_level_id` BIGINT COMMENT 'Foreign key linking to mine.pit_or_level. Business justification: grade_control_block has pit_name (STRING) but no FK to pit_or_level table. Adding pit_or_level_id FK normalizes pit/level reference and removes redundant name column. The pit_or_level table contains n',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Grade control blocks are classified and dispatched according to production schedule. N:1 relationship (many blocks per schedule). No bidirectional conflict. Valid operational link.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Grade control blocks are sampled within prospect boundaries. Grade control programs reference exploration prospect geology for classification, dispatch decisions, and ore/waste designation. Essential ',
    `block_model_id` BIGINT COMMENT 'Identifier of the geological resource block model version from which this grade control blocks initial grade estimates were derived. Enables traceability back to the JORC-compliant resource model in Geovia GEMS.',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Grade control blocks are dispatched to specific product destinations (lump, fines, different grade products). Critical operational decision linking mine execution to product specifications. Ore_type_c',
    `standard_job_id` BIGINT COMMENT 'Identifier of the drill-and-blast pattern associated with this grade control block. Links the block to the blast design from which grade control samples were collected. Used for blast-to-mill reconciliation.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Grade control blocks must be attributed to tenements for accurate reserve depletion reporting, royalty calculations on mined ore grades, and compliance with mining lease resource extraction conditions',
    `block_code` STRING COMMENT 'Externally-known alphanumeric identifier for the grade control block as assigned in Geovia GEMS or the mines block model system. Used for cross-system traceability and field reference.',
    `block_name` STRING COMMENT 'Human-readable name or label assigned to the grade control block, typically combining bench, row, and column identifiers for operational reference at the mine face.',
    `block_size_x_m` DECIMAL(18,2) COMMENT 'Horizontal dimension of the grade control block in the X (easting) direction, in metres. Defines the block geometry used for volume and tonnage calculations.',
    `block_size_y_m` DECIMAL(18,2) COMMENT 'Horizontal dimension of the grade control block in the Y (northing) direction, in metres. Defines the block geometry used for volume and tonnage calculations.',
    `block_size_z_m` DECIMAL(18,2) COMMENT 'Vertical dimension (height) of the grade control block in metres, typically equal to the bench height. Used for volume and tonnage calculations.',
    `block_status` STRING COMMENT 'Current lifecycle status of the grade control block indicating its operational state. active = classified and awaiting dispatch; dispatched = ore/waste destination assigned; mined_out = block fully extracted; on_hold = pending re-assay or review; cancelled = block voided.. Valid values are `active|dispatched|mined_out|on_hold|cancelled`',
    `block_volume_m3` DECIMAL(18,2) COMMENT 'Calculated volume of the grade control block in cubic metres, derived from block dimensions. Used as the basis for in-situ tonnage estimation.',
    `bulk_density_tm3` DECIMAL(18,2) COMMENT 'Bulk density of the material in the grade control block expressed in tonnes per cubic metre (t/m³). Used to convert block volume to in-situ tonnes. Sourced from laboratory measurements or geological domain defaults.',
    `centroid_easting_m` DECIMAL(18,2) COMMENT 'Easting coordinate of the block centroid in the mines local or projected coordinate system (metres). Used for spatial location, blast pattern design, and GIS integration.',
    `centroid_northing_m` DECIMAL(18,2) COMMENT 'Northing coordinate of the block centroid in the mines local or projected coordinate system (metres). Used for spatial location, blast pattern design, and GIS integration.',
    `classification` STRING COMMENT 'Grade control classification of the block based on cut-off grade analysis. Determines whether the block is directed to the mill, ROM pad, low-grade stockpile, or waste dump. This is the primary ore/waste discrimination decision for the block.. Valid values are `ore|waste|low_grade|marginal_ore`',
    `classification_date` DATE COMMENT 'Date on which the ore/waste classification decision was made for this grade control block, based on assay results and cut-off grade analysis. Represents the principal business event date for this entity.',
    `confidence_level` STRING COMMENT 'Confidence level assigned to the grade estimate for this block, reflecting the density and quality of sampling data. high = well-drilled with close-spaced samples; medium = adequate sampling; low = sparse data, interpolated grade. Influences dispatch decision risk.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grade control block record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides the audit trail creation marker for data lineage and compliance purposes.',
    `cut_off_grade` DECIMAL(18,2) COMMENT 'The minimum economic grade threshold applied to classify this block as ore or waste. Blocks with primary_grade at or above this value are classified as ore. Derived from the current LOM (Life of Mine) economic parameters and commodity price assumptions.',
    `dilution_factor_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of waste or gangue material mixed with ore during mining of this block, expressed as a percentage. Dilution reduces the effective grade of mined material relative to in-situ grade. Used for reconciliation and production planning.',
    `dispatch_date` DATE COMMENT 'Date on which the dispatch instruction was issued and material from this grade control block was directed to its assigned destination. Used for production scheduling reconciliation and haulage tracking.',
    `dispatch_destination` STRING COMMENT 'Assigned destination for the material in this grade control block based on its classification. Drives truck dispatch instructions in the Fleet Management System (FMS). mill_feed = direct to processing plant; rom_pad = Run of Mine stockpile; low_grade_stockpile = future processing; waste_dump = permanent waste; tsf = Tailings Storage Facility.. Valid values are `mill_feed|rom_pad|low_grade_stockpile|waste_dump|tsf`',
    `dispatch_instruction_code` STRING COMMENT 'Specific dispatch instruction code issued to the Fleet Management System (FMS) for truck routing of material from this block. Corresponds to a destination code in Caterpillar MineStar for automated truck assignment.',
    `estimation_method` STRING COMMENT 'Statistical or geostatistical method used to estimate the grade of this block from drill hole or blast hole assay data. Common methods include Ordinary Kriging, Inverse Distance Weighting, and Nearest Neighbour.. Valid values are `kriging|inverse_distance|nearest_neighbour|polygonal|manual`',
    `insitu_tonnes` DECIMAL(18,2) COMMENT 'Estimated in-situ dry metric tonnes of material within the grade control block, calculated from block volume and bulk density. Represents the raw tonnage before mining dilution or recovery adjustments.',
    `is_resampled` BOOLEAN COMMENT 'Indicates whether this grade control block has been subject to a re-assay or resampling event due to initial classification uncertainty or grade variability. True = block was resampled; False = original assay used. Supports audit trail for classification decisions.',
    `mined_out_date` DATE COMMENT 'Date on which the grade control block was fully extracted and the block status transitioned to mined_out. Used for production reconciliation, LOM tracking, and mine closure planning.',
    `mineral_domain_code` STRING COMMENT 'Geological domain or mineralisation zone code to which this block belongs, as defined in the resource model. Used for grade estimation and variogram modelling within homogeneous geological units.',
    `primary_grade` DECIMAL(18,2) COMMENT 'Assay-derived grade of the primary commodity (e.g., Fe%, Cu%, Li ppm) for the grade control block. The principal quantitative fact driving ore/waste classification and dispatch decisions. Units depend on commodity (% for Fe/Cu, ppm for Li/Au).',
    `primary_grade_unit` STRING COMMENT 'Unit of measure for the primary commodity grade value (e.g., pct for percentage, ppm for parts per million, g_per_t for grams per tonne). Ensures correct interpretation of the primary_grade field across different commodities.. Valid values are `pct|ppm|ppb|g_per_t|kg_per_t`',
    `recovery_rate_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of the primary commodity that will be recovered during mineral processing of this blocks material. Used for contained metal calculations and production forecasting.',
    `sample_count` STRING COMMENT 'Number of drill hole or blast hole assay samples used in the grade estimation for this block. Higher sample counts generally indicate greater confidence in the grade estimate.',
    `secondary_grade` DECIMAL(18,2) COMMENT 'Assay-derived grade of a secondary or by-product commodity (e.g., SiO2%, Al2O3%, S%) for the grade control block. Used for penalty/bonus calculations, blending decisions, and metallurgical planning.',
    `secondary_grade_element` STRING COMMENT 'Chemical element or compound symbol for the secondary grade value (e.g., SiO2, Al2O3, S, P). Identifies which element the secondary_grade field represents for this block.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this grade control block record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data lineage, and incremental ETL processing in the Databricks Silver Layer.',
    CONSTRAINT pk_grade_control_block PRIMARY KEY(`grade_control_block_id`)
) COMMENT 'Grade control block record representing a short-range ore classification unit used to direct ore and waste to appropriate destinations. Captures block ID, location, ore type, cut-off grade classification (ore/waste/low-grade), assay results, confidence level, and dispatch instruction. Sourced from LabWare LIMS and Geovia GEMS. The operational SSOT for ore/waste discrimination at the face.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`shift_report` (
    `shift_report_id` BIGINT COMMENT 'Unique surrogate identifier for the shift report record. Primary key for the shift_report data product in the mine domain Silver layer.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Shift-level costs are allocated to cost centres for daily cost tracking, reconciliation against budget, and operational cost reporting. Standard shift-to-finance integration for mining operations.',
    `employee_id` BIGINT COMMENT 'Reference to the shift supervisor or leading hand responsible for the crew during this shift. Used for accountability, handover management, and workforce reporting. Maps to the workforce master record.',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Shift reports document community complaints received during operations (noise, dust, traffic, safety concerns). Supervisors log grievances in shift handovers for follow-up. Real business process: oper',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Shift reports document incidents that occurred during the shift for handover and management reporting. Standard mining operational practice to reference incidents in shift documentation.',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Shift reports track progress against LOM plan. N:1 relationship (many shifts in one LOM plan). No bidirectional conflict. Valid planning link.',
    `mine_site_id` BIGINT COMMENT 'FK to mine.mine_site',
    `opex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.opex_budget. Business justification: Shift actuals are reconciled against opex budgets for daily cost control, forecast accuracy, and operational budget tracking. Real-time budget variance monitoring for mining operations.',
    `pit_or_level_id` BIGINT COMMENT 'FK to mine.pit_or_level',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Shift reports track which commodity was primarily mined during the shift. Required for daily production reporting, reconciliation against plan, and operational performance tracking. New attribute need',
    `production_schedule_id` BIGINT COMMENT 'Reference to the mine production schedule record that defines the targets for this shift. Links actuals to the scheduled plan for variance analysis and LOM planning reconciliation.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Shift reports document production from specific prospects. Daily reporting attributes tonnes and grade to source prospect for production accounting, resource depletion tracking, and operational perfor',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_schedule. Business justification: Shift reports capture actual production outcomes for a scheduled workforce shift. Linking to shift_schedule enables variance analysis between planned workforce deployment and actual production deliver',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Daily shift reports track production by tenement for expenditure commitment substantiation, quarterly regulatory reporting, and operational performance analysis by license area. Required for annual co',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Shift reports track consumables usage from site warehouses (explosives, fuel, ground support). Business need: shift-level consumables reconciliation, warehouse demand forecasting, inventory replenishm',
    `blasts_fired_count` STRING COMMENT 'Number of blast events executed during the shift. Used for drill-and-blast productivity tracking, explosive consumption reconciliation, and regulatory blast notification compliance.',
    `breakdown_delay_hours` DECIMAL(18,2) COMMENT 'Total hours of production lost during the shift due to unplanned equipment breakdowns and mechanical failures. Used for Mean Time Between Failures (MTBF) and Mean Time To Repair (MTTR) analysis and maintenance planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift report record was first created in the system. Used for audit trail, data lineage, and Silver layer ingestion tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crew_headcount` STRING COMMENT 'Total number of personnel (operators, technicians, supervisors) who worked during the shift. Used for workforce productivity analysis, labour cost allocation, and safety compliance (persons on site).',
    `dilution_pct` DECIMAL(18,2) COMMENT 'Percentage of waste material mixed with ore during mining operations for the shift, expressed as a decimal. Dilution control is a critical operational metric impacting ore quality and processing recovery rates.',
    `equipment_operating_hours` DECIMAL(18,2) COMMENT 'Total aggregate operating hours across all production equipment (trucks, excavators, drills) during the shift. Sourced from Caterpillar MineStar FMS engine hours. Used for OEE calculation and maintenance scheduling.',
    `equipment_scheduled_hours` DECIMAL(18,2) COMMENT 'Total aggregate scheduled operating hours for all production equipment during the shift as per the mine production schedule. Used as the denominator for equipment utilisation rate calculation.',
    `equipment_utilisation_pct` DECIMAL(18,2) COMMENT 'Actual equipment utilisation rate for the shift expressed as a decimal percentage (e.g., 0.8500 = 85%). Calculated as equipment operating hours divided by equipment scheduled hours. Key input to Overall Equipment Effectiveness (OEE) reporting.',
    `handover_notes` STRING COMMENT 'Free-text handover communication from the outgoing shift supervisor to the incoming shift supervisor. Captures outstanding tasks, equipment status, safety hazards, and operational priorities for continuity of operations.',
    `is_daily_rollup_complete` BOOLEAN COMMENT 'Indicates whether this shift report has been included in the daily production rollup for management reporting. True when the shift data has been aggregated into the daily summary; False when pending rollup.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift report record was most recently modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Lakehouse Silver layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lost_time_injury_count` STRING COMMENT 'Number of Lost Time Injuries (LTIs) recorded during the shift — injuries resulting in at least one full shift of lost work time. Key input to Lost Time Injury Frequency Rate (LTIFR) regulatory reporting.',
    `metres_developed` DECIMAL(18,2) COMMENT 'Total metres of underground development advance (drives, declines, crosscuts) completed during the shift. Applicable to underground mining operations. Used for development schedule tracking.',
    `metres_drilled` DECIMAL(18,2) COMMENT 'Total metres of drilling completed during the shift across all drill rigs, including blast hole drilling and development drilling. Used for drill-and-blast performance tracking and production scheduling.',
    `metres_drilled_target` DECIMAL(18,2) COMMENT 'Scheduled target metres of drilling for the shift as per the mine production schedule. Used for drill performance variance analysis.',
    `mining_method` STRING COMMENT 'The primary mining extraction method employed during this shift. Distinguishes open-cut from underground methods and specific underground techniques such as Sub-Level Caving (SLC), longwall, or cut-and-fill. [ENUM-REF-CANDIDATE: open_cut|underground_sublevel_caving|underground_longwall|underground_room_and_pillar|underground_cut_and_fill|underground_block_caving|surface_strip — promote to reference product]. Valid values are `open_cut|underground_sublevel_caving|underground_longwall|underground_room_and_pillar|underground_cut_and_fill|underground_block_caving`',
    `ore_grade_fe_pct` DECIMAL(18,2) COMMENT 'Average head grade of iron (Fe) content in ore mined during the shift, expressed as a decimal percentage. Sourced from assay results and grade control data. Used for production reconciliation and mineral resource reporting.',
    `ore_mined_target_tonnes` DECIMAL(18,2) COMMENT 'Scheduled target ore tonnes to be mined during the shift as per the mine production schedule. Used for variance analysis and production reconciliation against actuals.',
    `ore_mined_tonnes` DECIMAL(18,2) COMMENT 'Actual tonnes of ore material mined and dispatched to the Run of Mine (ROM) pad or stockpile during the shift. Core production KPI. Sourced from Caterpillar MineStar FMS truck payload data and OSIsoft PI belt weigher integration.',
    `planned_maintenance_delay_hours` DECIMAL(18,2) COMMENT 'Total hours of production lost during the shift due to scheduled preventive maintenance activities. Distinguishes planned downtime from unplanned breakdowns for OEE and availability reporting.',
    `safety_incident_count` STRING COMMENT 'Total number of safety incidents (including near misses, first aid, medical treatment, and lost time injuries) recorded during the shift. Used for LTIFR and TRIFR calculation and regulatory HSE reporting.',
    `shift_date` DATE COMMENT 'The calendar date to which this shift report is attributed for daily rollup and management reporting purposes. Aligns with the mine site operational day boundary (which may differ from midnight). Format: yyyy-MM-dd.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'The actual date and time the shift concluded at the mine site. Used in conjunction with shift_start_timestamp to calculate shift duration and for production period boundary alignment.',
    `shift_report_number` STRING COMMENT 'Externally-known business identifier for the shift report, typically formatted as SR-YYYY-MM-DD-SHF-NNN (e.g., SR-2024-07-15-DAY-001). Used for cross-system reference, regulatory production returns, and management reporting.. Valid values are `^SR-[0-9]{4}-[0-9]{2}-[0-9]{2}-[A-Z]{3}-[0-9]{3}$`',
    `shift_start_timestamp` TIMESTAMP COMMENT 'The actual date and time the shift commenced at the mine site. Principal business event timestamp for the shift. Used for production reconciliation, KPI dashboards, and regulatory production returns. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_status` STRING COMMENT 'Current lifecycle state of the shift report record. Draft indicates data entry in progress; submitted indicates supervisor sign-off; approved indicates management review complete; closed indicates period locked; voided indicates record cancelled.. Valid values are `draft|submitted|approved|closed|voided`',
    `shift_type` STRING COMMENT 'Classification of the shift period within the 24-hour operational cycle. Typical values: day (e.g., 06:00–18:00), night (e.g., 18:00–06:00), afternoon, or extended for non-standard shift patterns.. Valid values are `day|night|afternoon|extended`',
    `significant_events_notes` STRING COMMENT 'Free-text narrative capturing significant events during the shift including major breakdowns, safety incidents, geotechnical events, blast misfires, environmental exceedances, or other notable occurrences. Critical for shift handover and management reporting.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this shift report data was sourced. Values: MINESTAR (Caterpillar MineStar FMS), OSI_PI (OSIsoft PI System), CREW_REPORT (crew reporting system), MANUAL (manual entry). Supports data lineage and reconciliation.. Valid values are `MINESTAR|OSI_PI|CREW_REPORT|MANUAL`',
    `strip_ratio_actual` DECIMAL(18,2) COMMENT 'Actual strip ratio for the shift, calculated as waste tonnes moved divided by ore tonnes mined (overburden to ore ratio). A key economic indicator for open-cut mining operations used in OPEX and LOM planning.',
    `waste_moved_target_tonnes` DECIMAL(18,2) COMMENT 'Scheduled target waste tonnes to be moved during the shift as per the mine production schedule. Used for strip ratio variance analysis and LOM planning reconciliation.',
    `waste_moved_tonnes` DECIMAL(18,2) COMMENT 'Actual tonnes of waste rock (overburden and interburden) moved to waste dumps during the shift. Used to calculate the strip ratio and track overburden removal progress against the Life of Mine (LOM) plan.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition at the mine site during the shift. Used to contextualise production performance, explain delays, and support environmental and safety compliance reporting. [ENUM-REF-CANDIDATE: clear|cloudy|rain|heavy_rain|storm|fog|dust_storm|snow|extreme_heat|hail — promote to reference product]',
    `weather_delay_hours` DECIMAL(18,2) COMMENT 'Total hours of production lost during the shift due to adverse weather conditions (e.g., lightning stand-down, heavy rain, dust storm). Used for delay analysis and production variance reporting.',
    CONSTRAINT pk_shift_report PRIMARY KEY(`shift_report_id`)
) COMMENT 'Shift-level production performance record and the consolidated SSOT for all mine production actuals. Captures actual ore tonnes mined, waste tonnes moved, metres advanced (drill and development), blasts fired, equipment operating hours and utilisation rates versus scheduled targets, crew supervisor, significant events (breakdowns, safety incidents, weather delays), and handover notes. Includes daily rollup capability for management reporting. Sourced from Caterpillar MineStar FMS, OSIsoft PI, and crew reporting systems. Feeds production reconciliation, KPI dashboards, regulatory production returns, and management reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`waste_dump` (
    `waste_dump_id` BIGINT COMMENT 'Unique surrogate identifier for the waste rock dump facility record. Primary key for the waste_dump master data product.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Waste dumps are managed under cost centres for waste handling cost tracking, rehabilitation provision calculation, and environmental cost management. Core environmental accounting link.',
    `environmental_monitoring_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_monitoring. Business justification: Waste dumps monitored for groundwater quality, geotechnical stability, and acid rock drainage. Regulatory requirement to link dump facility to monitoring program for compliance reporting.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Waste dumps require specific environmental permits for construction and operation covering geotechnical stability, water management, and rehabilitation. Regulatory requirement in all mining jurisdicti',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Waste dumps subject to periodic environmental and geotechnical audits per regulatory requirements. Links dump facility to audit findings for compliance tracking and corrective action management.',
    `land_compensation_agreement_id` BIGINT COMMENT 'Foreign key linking to community.land_compensation_agreement. Business justification: Waste dump footprints often occupy compensated land parcels. Agreement terms govern placement, access, rehabilitation obligations, and ongoing payments. Real business process: land use compliance, com',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Waste dumps are planned as part of LOM plan. N:1 relationship (many dumps in one LOM plan). No bidirectional conflict. Valid planning link.',
    `mine_site_id` BIGINT COMMENT 'FK to mine.mine_site',
    `pit_design_id` BIGINT COMMENT 'Reference to the open-cut pit or underground mining area that primarily generates the waste material deposited in this dump. Supports strip ratio and waste tracking by source area.',
    `rehabilitation_provision_id` BIGINT COMMENT 'Foreign key linking to finance.rehabilitation_provision. Business justification: Waste dumps trigger rehabilitation provisions for closure cost estimation, balance sheet liability management, and environmental accounting. Core environmental accounting link for mining closure oblig',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Waste dumps must be located within authorized tenement boundaries or have specific surface rights agreements. Critical for environmental compliance, Programme of Work approvals, and land use authoriza',
    `acid_rock_drainage_risk` STRING COMMENT 'Classification of the waste dumps potential to generate Acid Rock Drainage (ARD) based on net acid generation (NAG) testing and acid-base accounting (ABA) of the waste material. Drives encapsulation design, water management, and long-term monitoring requirements.. Valid values are `low|medium|high|very_high`',
    `closure_date` DATE COMMENT 'Date on which waste emplacement operations formally ceased and the dump was closed to further filling. Null if the dump is still active. Used for LOM planning and rehabilitation scheduling.',
    `commissioned_date` DATE COMMENT 'Date on which the waste dump facility was formally commissioned and first received waste material. Marks the start of the operational lifecycle for compliance and LOM tracking purposes.',
    `current_fill_tonnes` DECIMAL(18,2) COMMENT 'Cumulative mass of waste material currently emplaced in the dump expressed in dry metric tonnes. Derived from FMS truck payload data and survey reconciliation. Used for mass-balance and OPEX reporting.',
    `current_fill_volume_bcm` DECIMAL(18,2) COMMENT 'Cumulative volume of waste material currently emplaced in the dump expressed in Bank Cubic Metres (BCM). Updated from survey data and FMS haulage records. Used to calculate remaining capacity and track fill progression against LOM schedule.',
    `design_capacity_bcm` DECIMAL(18,2) COMMENT 'Total approved design capacity of the waste dump expressed in Bank Cubic Metres (BCM). Represents the maximum volume of in-situ material the facility is permitted and engineered to receive. Sourced from mine planning systems (Hexagon MinePlan, Deswik).',
    `design_capacity_tonnes` DECIMAL(18,2) COMMENT 'Total approved design capacity of the waste dump expressed in dry metric tonnes. Complements BCM capacity for mass-balance reconciliation and LOM planning. Sourced from mine planning systems.',
    `dump_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the waste dump facility, used in mine planning systems (Hexagon MinePlan, Deswik) and regulatory submissions. Unique across the mine site.. Valid values are `^WD-[A-Z0-9]{3,10}$`',
    `dump_name` STRING COMMENT 'Human-readable name assigned to the waste dump facility (e.g., North Waste Dump 1, Southern Overburden Emplacement). Used in operational communications, mine plans, and regulatory reports.',
    `dump_status` STRING COMMENT 'Current lifecycle status of the waste dump facility. Active indicates ongoing waste emplacement; closed indicates emplacement has ceased; rehabilitating indicates progressive or final rehabilitation is underway per the mine closure plan.. Valid values are `active|inactive|closed|rehabilitating|decommissioned`',
    `dump_type` STRING COMMENT 'Classification of the waste dump by material type deposited. Overburden refers to material above the ore body; waste rock is non-economic mineralised material; low-grade stockpile holds sub-cut-off-grade ore for potential future processing. [ENUM-REF-CANDIDATE: overburden|waste_rock|low_grade_stockpile|mixed|tailings_co_disposal — promote to reference product if additional types emerge]. Valid values are `overburden|waste_rock|low_grade_stockpile|mixed|tailings_co_disposal`',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the waste dump crest above mean sea level in metres. Critical for geotechnical stability assessment, drainage design, and regulatory height limit compliance.',
    `geotechnical_classification` STRING COMMENT 'Geotechnical risk classification of the waste dump based on foundation conditions, material properties, and consequence of failure. Class 1 (lowest risk) to Class 4 (highest risk). Drives inspection frequency, monitoring requirements, and regulatory reporting obligations. [ENUM-REF-CANDIDATE: class_1|class_2|class_3|class_4 — promote to reference product]. Valid values are `class_1|class_2|class_3|class_4`',
    `groundwater_monitoring_required` BOOLEAN COMMENT 'Indicates whether ongoing groundwater quality monitoring is required for this waste dump as a condition of the environmental permit or based on ARD risk classification. True triggers monitoring schedule in IsoMetrix.',
    `isometrix_facility_reference` STRING COMMENT 'Source system identifier for this waste dump facility as recorded in IsoMetrix HSE and Environmental Monitoring module. Used for data lineage and cross-system reconciliation.',
    `last_survey_date` DATE COMMENT 'Date of the most recent topographic survey conducted on the waste dump to update volume and surface area measurements. Survey data is used to reconcile FMS haulage records with actual fill volumes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the waste dump centroid or reference point in decimal degrees (WGS84). Used for GIS mapping, environmental monitoring zone delineation, and regulatory spatial reporting.',
    `leachate_management_status` STRING COMMENT 'Current operational status of the leachate collection and management system for the waste dump. Indicates whether leachate is being actively collected, passively monitored, or not required based on liner type and regulatory conditions.. Valid values are `not_required|collection_system_active|collection_system_inactive|monitoring_only`',
    `liner_type` STRING COMMENT 'Type of engineered liner system installed at the base of the waste dump to control leachate migration and protect groundwater. None indicates an unlined facility; HDPE geomembrane is a high-density polyethylene synthetic liner. Sourced from mine design records and IsoMetrix.. Valid values are `none|compacted_clay|hdpe_geomembrane|composite|low_permeability_rock`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the waste dump centroid or reference point in decimal degrees (WGS84). Used for GIS mapping, environmental monitoring zone delineation, and regulatory spatial reporting.',
    `max_height_m` DECIMAL(18,2) COMMENT 'Maximum permitted or current height of the waste dump from base to crest in metres. A key geotechnical design parameter governing slope stability and regulatory permit conditions.',
    `mine_plan_dump_reference` STRING COMMENT 'Source system identifier for this waste dump as recorded in the mine planning system (Hexagon MinePlan or Deswik). Used for data lineage, cross-system reconciliation, and LOM schedule integration.',
    `next_inspection_date` DATE COMMENT 'Date of the next scheduled geotechnical or environmental inspection of the waste dump as required by the geotechnical classification, permit conditions, or IsoMetrix inspection schedule.',
    `notes` STRING COMMENT 'Free-text field for operational notes, geotechnical observations, or special conditions applicable to this waste dump that are not captured in structured fields. Used by mine planning and environmental teams.',
    `overall_slope_angle_deg` DECIMAL(18,2) COMMENT 'Designed overall slope angle of the waste dump in degrees from horizontal. A critical geotechnical stability parameter reviewed against factor-of-safety thresholds in the geotechnical design report.',
    `permit_expiry_date` DATE COMMENT 'Date on which the environmental permit or licence for this waste dump expires and must be renewed. Triggers compliance workflow in IsoMetrix for permit renewal actions.',
    `permit_number` STRING COMMENT 'Regulatory permit or licence number issued by the relevant environmental authority authorising the construction and operation of this waste dump. Required for compliance tracking and regulatory reporting.',
    `progressive_rehab_area_ha` DECIMAL(18,2) COMMENT 'Cumulative area of the waste dump that has been progressively rehabilitated to date, expressed in hectares. Used to track rehabilitation progress against permit commitments and LOM closure plan milestones.',
    `progressive_rehab_required` BOOLEAN COMMENT 'Indicates whether progressive rehabilitation (rehabilitation of completed dump benches during the operational phase) is required as a permit condition or company commitment. True drives progressive rehab scheduling in the LOM plan.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste dump master record was first created in the data platform. Supports data lineage, audit trail, and Silver layer ingestion tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste dump master record was most recently updated in the data platform. Used for change detection, incremental processing, and audit trail in the Databricks Silver layer.',
    `rehabilitation_bond_amount` DECIMAL(18,2) COMMENT 'Financial assurance (bond) amount in the sites functional currency held by the relevant regulatory authority to cover the estimated cost of rehabilitating this waste dump to an approved post-mining land use standard. Commercially sensitive.',
    `rehabilitation_bond_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the rehabilitation bond amount (e.g., AUD, USD, ZAR). Required for multi-jurisdiction financial reporting under IFRS.. Valid values are `^[A-Z]{3}$`',
    `rehabilitation_plan_reference` STRING COMMENT 'Document reference number or identifier for the approved mine rehabilitation and closure plan applicable to this waste dump. Links to the formal closure plan document registered in the document management system. Required for regulatory compliance and bond calculation.',
    `responsible_engineer` STRING COMMENT 'Name or employee identifier of the qualified geotechnical engineer responsible for the design, monitoring, and sign-off of this waste dump facility. Required for regulatory accountability and competent person declarations.',
    `surface_area_ha` DECIMAL(18,2) COMMENT 'Total surface footprint of the waste dump facility in hectares, including all active and inactive benches. Used for rehabilitation cost estimation, environmental bond calculation, and land tenure management.',
    `waste_rock_classification` STRING COMMENT 'Geochemical classification of the predominant waste rock material deposited in the dump based on laboratory acid-base accounting. Non-Acid Forming (NAF), Potentially Acid Forming (PAF), or Acid Forming (AF). Determines encapsulation and placement strategy.. Valid values are `non_acid_forming|potentially_acid_forming|acid_forming|uncertain`',
    CONSTRAINT pk_waste_dump PRIMARY KEY(`waste_dump_id`)
) COMMENT 'Master record of waste rock dump facilities including dump name, location coordinates, design capacity (tonnes/BCM), current fill volume, geotechnical classification, liner type, leachate management status, and rehabilitation plan reference. Sourced from mine planning systems and IsoMetrix. The SSOT for waste dump inventory and geotechnical compliance.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`survey_measurement` (
    `survey_measurement_id` BIGINT COMMENT 'Unique system-generated identifier for each mine survey measurement record. Primary key for the survey_measurement data product.',
    `bench_id` BIGINT COMMENT 'Foreign key linking to mine.bench. Business justification: survey_measurement has bench_level (STRING) but no FK to bench table. Adding bench_id FK normalizes bench reference and removes redundant bench_level string column. The bench table contains bench_code',
    `functional_location_id` BIGINT COMMENT 'Reference to the mine area, pit, bench, or underground zone where the survey was conducted. Links to the mine area master data product for spatial context.',
    `location_id` BIGINT COMMENT 'Reference to the specific geographic location or spatial feature (stockpile, dump, TSF cell, stope) being surveyed, as defined in the mines GIS (Geographic Information System) location master.',
    `mining_block_id` BIGINT COMMENT 'Foreign key linking to mine.mining_block. Business justification: Surveys can measure individual mining blocks. N:1 relationship (many surveys of one block). No bidirectional conflict. Valid operational link.',
    `pit_design_id` BIGINT COMMENT 'Foreign key linking to mine.pit_design. Business justification: Surveys measure actual pit progress against design. N:1 relationship (many surveys comparing to one design). No bidirectional conflict. Valid operational link.',
    `pit_or_level_id` BIGINT COMMENT 'Foreign key linking to mine.pit_or_level. Business justification: Survey measurements are conducted on pits or underground levels. Adding pit_or_level_id FK provides location context for survey records. No redundant columns to remove.',
    `previous_survey_survey_measurement_id` BIGINT COMMENT 'Reference to the immediately preceding survey measurement record for the same location, enabling period-over-period volumetric change calculation and production reconciliation.',
    `employee_id` BIGINT COMMENT 'Reference to the licensed mine surveyor or survey crew responsible for conducting the field survey. Links to the workforce/personnel master data product.',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Surveys measure ROM stockpile volumes. N:1 relationship (many surveys of one stockpile over time). No bidirectional conflict. Valid operational link.',
    `stope_design_id` BIGINT COMMENT 'Foreign key linking to mine.stope_design. Business justification: For underground surveys, linking to stope_design provides access to design parameters for comparison with surveyed actuals. This is essential for underground survey reconciliation. No redundant column',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Mine surveys (stockpile volumes, pit progression, waste dump monitoring) are performed using specific survey equipment (total stations, drones, GPS rovers). Tracking which asset performed each survey ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Survey measurements of mined volumes must be attributed to tenements for production reconciliation, royalty calculations, and regulatory reporting. Essential for quarterly production returns and reser',
    `waste_dump_id` BIGINT COMMENT 'Foreign key linking to mine.waste_dump. Business justification: Surveys measure waste dump volumes. N:1 relationship (many surveys of one dump over time). No bidirectional conflict. Valid operational link.',
    `wireframe_id` BIGINT COMMENT 'Foreign key linking to geology.wireframe. Business justification: Survey measurements validate as-built geometry against design wireframes. Required for reconciliation, identifying deviations from design, and updating wireframes based on actual mining progress.',
    `accuracy_class` STRING COMMENT 'Classification of the positional accuracy standard achieved by the survey method. Survey-grade (±0.05m) is required for production reconciliation; engineering-grade (±0.1–0.5m) for planning; reconnaissance for preliminary assessments.. Valid values are `survey_grade|engineering_grade|reconnaissance`',
    `approval_date` DATE COMMENT 'The date on which the survey measurement record was formally approved by the authorised mine surveyor. Required for regulatory compliance and production reporting sign-off.',
    `bulk_density` DECIMAL(18,2) COMMENT 'Bulk density factor in tonnes per cubic metre (t/m³) applied to convert surveyed volume to estimated tonnes. Value may vary by material type (ore, waste, ROM, concentrate) and moisture content.',
    `coordinate_system` STRING COMMENT 'The geodetic coordinate reference system (CRS) used for the survey, expressed as an EPSG code or named datum (e.g., GDA2020 / MGA Zone 54, WGS84 UTM). Ensures spatial data interoperability with GIS and Hexagon MinePlan.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this survey measurement record was first created in the system, including timezone offset. Used for audit trail and data lineage tracking in the Databricks Silver Layer.',
    `design_volume_m3` DECIMAL(18,2) COMMENT 'The planned or design volume in cubic metres (m³) for the surveyed feature as per the mine design model in Hexagon MinePlan or Deswik. Used to calculate variance to design for production scheduling compliance.',
    `dtm_file_ref` STRING COMMENT 'File path or object storage URI referencing the Digital Terrain Model (DTM) or Digital Surface Model (DSM) derived from the survey, used as the basis for volume calculations in Hexagon MinePlan.',
    `elevation_max_m` DECIMAL(18,2) COMMENT 'Maximum elevation in metres above Reduced Level (mRL) datum recorded within the survey extent. Used for crest height validation, dump height compliance, and TSF (Tailings Storage Facility) freeboard monitoring.',
    `elevation_min_m` DECIMAL(18,2) COMMENT 'Minimum elevation in metres above Reduced Level (mRL) datum recorded within the survey extent. Used for bench floor validation, geotechnical monitoring, and pit design compliance.',
    `geotechnical_flag` BOOLEAN COMMENT 'Indicates whether this survey measurement was triggered or flagged for geotechnical monitoring purposes (e.g., slope stability monitoring, TSF embankment deformation, underground convergence). When true, the record is shared with the geotechnical team for risk assessment.',
    `horizontal_accuracy_m` DECIMAL(18,2) COMMENT 'Estimated horizontal positional accuracy of the survey in metres (m), representing the root mean square error (RMSE) of check point comparisons. Governs fitness-for-purpose for production reconciliation and geotechnical monitoring.',
    `material_type` STRING COMMENT 'Classification of the primary material type present in the surveyed feature. Distinguishes ore, waste rock, ROM (Run of Mine) material, overburden, tailings, or concentrate stockpiles for production accounting and reconciliation.. Valid values are `ore|waste|rom|overburden|tailings|concentrate`',
    `notes` STRING COMMENT 'Free-text field for the surveyor to record observations, anomalies, data quality caveats, or contextual information about the survey event (e.g., partial coverage due to access restrictions, equipment issues, or safety exclusion zones).',
    `point_cloud_file_ref` STRING COMMENT 'File path or object storage URI referencing the raw point cloud dataset (LAS/LAZ format) or photogrammetric model generated by the survey. Enables traceability back to source survey data in the data lake.',
    `production_period` STRING COMMENT 'The production reporting period (e.g., 2024-Q3, 2024-W42) to which this survey measurement is attributed for production reconciliation and LOM (Life of Mine) schedule tracking.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'The ratio of waste/overburden volume to ore volume derived from the survey measurement for the period, expressed as bcm waste per tonne of ore. A key open-cut mining efficiency metric used in LOM planning and OPEX (Operating Expenditure) tracking.',
    `survey_area_m2` DECIMAL(18,2) COMMENT 'Total horizontal surface area in square metres (m²) covered by the survey extent polygon. Used to assess survey coverage completeness and calculate average depth or height of material.',
    `survey_date` DATE COMMENT 'The calendar date on which the physical survey was conducted in the field. This is the principal real-world event date used for production reconciliation and scheduling alignment.',
    `survey_method` STRING COMMENT 'The geospatial data capture technique used to conduct the survey. Common methods include drone photogrammetry, LiDAR (Light Detection and Ranging), total station, GPS RTK (Real-Time Kinematic), mobile mapping system (MMS), and terrestrial laser scanning. [ENUM-REF-CANDIDATE: drone_photogrammetry|lidar|total_station|gps_rtk|mms|laser_scan|handheld_gps|aerial_photogrammetry — promote to reference product]. Valid values are `drone_photogrammetry|lidar|total_station|gps_rtk|mms|laser_scan`',
    `survey_reference_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the survey event, used for cross-referencing with Hexagon MinePlan survey records, field reports, and production reconciliation documents.',
    `survey_status` STRING COMMENT 'Current workflow lifecycle status of the survey measurement record, from initial field capture through review and approval to archival.. Valid values are `draft|submitted|approved|rejected|archived`',
    `survey_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the survey capture commenced, including timezone offset. Used for SCADA integration and time-series alignment with OSIsoft PI System historian data.',
    `survey_type` STRING COMMENT 'Classification of the survey target area or structure being measured. Covers open-cut pit floors, waste dumps, ROM (Run of Mine) stockpiles, underground workings, Tailings Storage Facilities (TSF), and haul roads. [ENUM-REF-CANDIDATE: pit_floor|dump|stockpile|underground|tsf|haul_road|portal|decline|berm — promote to reference product]. Valid values are `pit_floor|dump|stockpile|underground|tsf|haul_road`',
    `surveyed_tonnes` DECIMAL(18,2) COMMENT 'Estimated mass in dry metric tonnes (dmt) of material represented by the surveyed volume, derived by applying the appropriate bulk density factor. Used for production reconciliation against FMS (Fleet Management System) truck counts.',
    `surveyed_volume_m3` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the surveyed feature (pit void, stockpile, dump, or underground void) in cubic metres (m³), as calculated from the survey point cloud or digital terrain model (DTM) in Hexagon MinePlan.',
    `tonnes_change` DECIMAL(18,2) COMMENT 'Net change in estimated dry metric tonnes between the current and previous survey for the same location. Used as the primary production reconciliation metric against FMS-reported movement tonnes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this survey measurement record was last modified, including timezone offset. Used for change tracking, incremental data pipeline processing, and audit compliance.',
    `variance_to_design_m3` DECIMAL(18,2) COMMENT 'Difference in cubic metres (m³) between the surveyed volume and the design volume (surveyed minus design). Negative values indicate under-excavation; positive values indicate over-excavation or excess material. Critical for LOM (Life of Mine) plan compliance.',
    `variance_to_design_pct` DECIMAL(18,2) COMMENT 'Percentage variance between the surveyed volume and the design volume, expressed as (surveyed - design) / design × 100. Enables normalised comparison across survey areas of different sizes for production scheduling KPI reporting.',
    `vertical_accuracy_m` DECIMAL(18,2) COMMENT 'Estimated vertical positional accuracy of the survey in metres (m), representing the RMSE of elevation check point comparisons. Critical for volumetric calculation reliability and bench floor compliance.',
    `volume_change_m3` DECIMAL(18,2) COMMENT 'Net volumetric change in cubic metres (m³) between the current survey and the previous survey for the same location. Positive values indicate material addition (e.g., stockpile build); negative values indicate material removal (e.g., pit excavation, reclaim).',
    `weather_conditions` STRING COMMENT 'Prevailing weather conditions at the time of the survey, which may affect data quality for drone photogrammetry and LiDAR methods. Used for data quality qualification and survey validity assessment.. Valid values are `clear|overcast|rain|fog|wind|dust`',
    CONSTRAINT pk_survey_measurement PRIMARY KEY(`survey_measurement_id`)
) COMMENT 'Mine survey measurement record capturing periodic topographic and volumetric surveys of pits, dumps, stockpiles, and underground workings. Includes survey date, method (drone, LiDAR, total station), surveyed volume/tonnes, comparison to previous survey, and variance to design. Sourced from survey systems and Hexagon MinePlan. Enables production reconciliation and geotechnical monitoring.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`production_reconciliation` (
    `production_reconciliation_id` BIGINT COMMENT 'Unique surrogate identifier for each production reconciliation record in the silver layer lakehouse. Primary key for this entity.',
    `block_model_id` BIGINT COMMENT 'Foreign key linking to geology.block_model. Business justification: Reconciliation validates specific block model versions against actual mining results. Critical for model versioning, competent person reviews, and determining when model updates are required.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Reconciliation is performed by geological domain to identify model biases. Required for domain-specific model updates, understanding estimation performance, and refining variogram parameters.',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Reconciliation compares actuals to LOM plan predictions. N:1 relationship (many reconciliations reference one LOM plan). No bidirectional conflict. Valid planning link.',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: production_reconciliation has mine_site_code (STRING) but no FK to mine_site table. Adding mine_site_id FK normalizes site reference and removes redundant code column. The mine_site table contains sit',
    `mining_block_id` BIGINT COMMENT 'Foreign key linking to mine.mining_block. Business justification: Reconciliation is performed at mining block level. N:1 relationship (many reconciliation records per block over time). No bidirectional conflict. Valid operational link.',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Reconciliation tracks reserve depletion. Reserve reconciliation is a regulatory requirement comparing mined tonnes against declared reserves for stock exchange reporting, reserve replacement tracking,',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Reconciliation compares model vs actual performance by orebody. Required for resource model updates, reserve confidence assessment, and identifying systematic geological estimation biases.',
    `pit_design_id` BIGINT COMMENT 'Foreign key linking to mine.pit_design. Business justification: Reconciliation can compare actuals to pit design. N:1 relationship (many reconciliations for one pit design). No bidirectional conflict. Valid planning link.',
    `employee_id` BIGINT COMMENT 'Identifier of the qualified geologist responsible for preparing and validating the reconciliation record. The responsible geologist is a Competent Person under JORC or Qualified Person under NI 43-101 who certifies the geological model inputs.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Reconciliation compares actuals to a specific production schedule. N:1 relationship (many reconciliations can reference one schedule period). No bidirectional conflict. Valid operational link.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Reconciliation compares actual production against exploration resource estimates at prospect level. Monthly/quarterly reconciliation is a regulatory requirement linking mined tonnes back to the origin',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Reconciliation compares actual results against resource estimates. F1/F2/F3 factor calculation requires linking mined blocks to the source resource estimate for model updating, resource classification',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Reconciliation validates resource statement accuracy over time. Required for material change assessments, determining when resource restatements are needed, and maintaining competent person confidence',
    `stope_design_id` BIGINT COMMENT 'Foreign key linking to mine.stope_design. Business justification: For underground mining reconciliation, linking to stope_design provides access to design parameters for comparison with actuals. This is essential for underground production reconciliation. No redunda',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Production reconciliation must track planned vs actual by tenement for reserve reporting updates, royalty calculation verification, and expenditure commitment substantiation. Required for annual reser',
    `actual_grade` DECIMAL(18,2) COMMENT 'Actual head grade (percentage or grams per tonne) of the primary commodity as determined by assay results from LabWare LIMS for the reconciliation period. Used as the numerator in F2 (grade reconciliation factor) calculation.',
    `actual_metal_content` DECIMAL(18,2) COMMENT 'Actual contained metal or mineral content (tonnes of metal) for the reconciliation period, derived from actual_tonnes and actual_grade assay data from LabWare LIMS. Used as the numerator in F3 (metal content reconciliation factor) calculation.',
    `actual_tonnes` DECIMAL(18,2) COMMENT 'Actual ore tonnes mined and delivered to the ROM pad or processing plant during the reconciliation period, as measured by Caterpillar MineStar FMS payload data and survey. Used as the numerator in F1 (tonnes reconciliation factor) calculation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the reconciliation record received final sign-off approval from the authorised approver. Null if reconciliation_status is not yet approved. Provides audit trail for JORC compliance and regulatory reporting.',
    `assay_sample_count` STRING COMMENT 'Number of assay samples collected and analysed in LabWare LIMS to determine the actual_grade for this reconciliation period. Higher sample counts increase grade confidence. Used to assess statistical reliability of the F2 grade reconciliation factor.',
    `bench_elevation_m` DECIMAL(18,2) COMMENT 'Elevation in metres above sea level (mRL) of the mining bench or stope level from which the reconciled ore was extracted. Used to spatially locate the reconciliation within the mine design and correlate with the geological block model in Geovia GEMS.',
    `commodity_code` STRING COMMENT 'Standard code for the primary commodity being reconciled (e.g., FE for iron ore, CU for copper, LI for lithium, NI for nickel, COAL). Used to align reconciliation data with sales, trading, and JORC resource reporting.. Valid values are `^[A-Z]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production reconciliation record was first created in the system. Provides audit trail for data lineage and compliance with JORC documentation requirements.',
    `dilution_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of waste rock (gangue) mixed with ore during the mining process, contributing to grade reduction relative to the geological model. Calculated from blast movement monitoring and survey data. High dilution is a primary driver of negative F2 factors.',
    `f1_factor` DECIMAL(18,2) COMMENT 'F1 reconciliation factor representing the ratio of actual mined tonnes to geological model tonnes (actual_tonnes / model_tonnes). A value of 1.0 indicates perfect tonnes reconciliation. Values significantly above or below 1.0 indicate geological model uncertainty or mining dilution issues. Critical JORC resource model confidence metric.',
    `f2_factor` DECIMAL(18,2) COMMENT 'F2 reconciliation factor representing the ratio of actual mined grade to geological model grade (actual_grade / model_grade). A value of 1.0 indicates perfect grade reconciliation. Deviations indicate geological estimation error, sampling bias, or dilution effects. Critical for resource model confidence and JORC compliance.',
    `f3_factor` DECIMAL(18,2) COMMENT 'F3 reconciliation factor representing the ratio of actual metal content to geological model metal content (actual_metal_content / model_metal_content). Combines the effect of both F1 and F2 (F3 = F1 × F2). The primary indicator of overall geological model performance and resource model confidence for JORC and NI 43-101 reporting.',
    `grade_unit` STRING COMMENT 'Unit of measure for model_grade and actual_grade fields. Percentage (pct) is used for base metals such as copper and iron ore; grams per tonne (g_per_t) for gold and silver; parts per million (ppm) for trace elements.. Valid values are `pct|g_per_t|kg_per_t|ppm`',
    `grade_variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance between actual mined grade and geological model grade, expressed as ((actual_grade - model_grade) / model_grade) × 100. Positive values indicate higher-than-predicted grade; negative values indicate grade underperformance. Drives cut-off grade and ore/waste classification reviews.',
    `model_grade` DECIMAL(18,2) COMMENT 'Predicted head grade (percentage or grams per tonne) of the primary commodity for the reconciliation period as estimated in the geological block model. Used as the denominator in F2 (grade reconciliation factor) calculation.',
    `model_metal_content` DECIMAL(18,2) COMMENT 'Predicted contained metal or mineral content (tonnes of metal) for the reconciliation period, calculated as model_tonnes multiplied by model_grade. Represents the geological models expected metal inventory. Used in F3 (metal content reconciliation factor) calculation.',
    `model_tonnes` DECIMAL(18,2) COMMENT 'Predicted ore tonnes for the reconciliation period as derived from the geological block model in Geovia GEMS or Hexagon MinePlan. Represents the mine plan scheduled tonnes before actual mining. Used as the denominator in F1 (tonnes reconciliation factor) calculation.',
    `model_update_required` BOOLEAN COMMENT 'Indicates whether the reconciliation results have triggered a requirement to update the geological block model in Geovia GEMS. Set to True when F1, F2, or F3 factors fall outside acceptable tolerance thresholds, indicating the resource model requires re-estimation.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, caveats, or contextual information related to the reconciliation record that do not fit into structured fields. May include references to specific blast events, equipment downtime, or exceptional geological conditions observed during the period.',
    `ore_recovery_pct` DECIMAL(18,2) COMMENT 'Percentage of the geological model ore tonnes that were successfully extracted and delivered to the ROM pad or processing plant, accounting for ore losses to waste dumps or misclassification. Distinct from metallurgical recovery rate in the processing plant.',
    `ore_source_code` STRING COMMENT 'Identifier for the specific ore source (e.g., pit bench, stope, ore block, or mining block) from which the reconciled tonnes were extracted. Sourced from Geovia GEMS block model and Hexagon MinePlan scheduling.',
    `ore_source_type` STRING COMMENT 'Classification of the ore source by mining method or material origin. Distinguishes between open-cut bench, underground stope, ROM pad stockpile, or blended feed to the processing plant. Critical for strip ratio and dilution analysis.. Valid values are `open_cut|underground|stockpile|rom_pad|blend`',
    `period_type` STRING COMMENT 'Granularity of the reconciliation period. Determines the reporting cadence and is used to aggregate or disaggregate reconciliation factors (F1/F2/F3) for LOM planning and JORC resource model confidence assessments.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `reconciliation_period_end` DATE COMMENT 'End date of the production period covered by this reconciliation. Together with reconciliation_period_start defines the temporal scope of the comparison between geological model and actual production.',
    `reconciliation_period_start` DATE COMMENT 'Start date of the production period covered by this reconciliation. Typically aligned to shift, daily, weekly, monthly, or quarterly reporting cycles.',
    `reconciliation_reference` STRING COMMENT 'Externally-known business identifier for the reconciliation run, typically formatted as REC-<SITE>-<YEAR>-<PERIOD>. Used for cross-system traceability across Geovia GEMS, LabWare LIMS, and Caterpillar MineStar.. Valid values are `^REC-[A-Z0-9]{4,}-[0-9]{4}-[0-9]{2}$`',
    `reconciliation_status` STRING COMMENT 'Current workflow state of the reconciliation record. Tracks progression from initial draft through geologist and mine manager review to final approval or rejection. Superseded indicates a newer reconciliation has replaced this record.. Valid values are `draft|pending_review|approved|rejected|superseded`',
    `resource_classification` STRING COMMENT 'JORC resource or reserve classification of the ore source being reconciled. Measured and Proved Reserve classifications carry the highest geological confidence; Inferred carries the lowest. Reconciliation factors are tracked by classification to assess model confidence at each JORC category level. [ENUM-REF-CANDIDATE: measured|indicated|inferred|proved_reserve|probable_reserve — promote to reference product if additional classifications such as SAMREC or NI 43-101 equivalents are required]. Valid values are `measured|indicated|inferred|proved_reserve|probable_reserve`',
    `source_system` STRING COMMENT 'Operational system of record from which the reconciliation data was primarily sourced. Geovia GEMS provides geological model data; Caterpillar MineStar provides actual tonnes via FMS; LabWare LIMS provides assay grade data. Manual indicates data was entered directly without system integration.. Valid values are `geovia_gems|hexagon_mineplan|caterpillar_minestar|labware_lims|manual`',
    `survey_method` STRING COMMENT 'Method used to measure actual mined tonnes for the reconciliation period. Drone survey and laser scan provide volumetric measurements; GPS RTK and total station provide traditional survey data; truck payload uses Caterpillar MineStar FMS payload data. Affects accuracy confidence of actual_tonnes.. Valid values are `drone_survey|total_station|gps_rtk|laser_scan|truck_payload`',
    `tonnes_variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance between actual mined tonnes and geological model tonnes, expressed as ((actual_tonnes - model_tonnes) / model_tonnes) × 100. Positive values indicate over-mining relative to model; negative values indicate under-mining. Used for production scheduling variance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the production reconciliation record was most recently modified. Tracks revisions to reconciliation factors, variance explanations, or approval status. Essential for data lineage in the Databricks silver layer.',
    `variance_category` STRING COMMENT 'Primary categorical classification of the reconciliation variance cause. Used for trend analysis and systematic identification of recurring model or operational issues. Supports resource model update prioritisation and mine planning improvement. [ENUM-REF-CANDIDATE: geological_model|dilution|ore_loss|sampling_bias|survey_error|blast_movement|equipment_error|classification_error — promote to reference product]. Valid values are `geological_model|dilution|ore_loss|sampling_bias|survey_error|blast_movement`',
    `variance_explanation` STRING COMMENT 'Narrative explanation of the primary causes of variance between geological model predictions and actual production results. Documents factors such as geological model uncertainty, blast movement, dilution, ore loss, sampling bias, or survey error. Required for JORC compliance documentation and resource model update decisions.',
    CONSTRAINT pk_production_reconciliation PRIMARY KEY(`production_reconciliation_id`)
) COMMENT 'Periodic production reconciliation record comparing geological model predictions to actual mined tonnes and grades. Captures reconciliation period, ore source, model tonnes vs actual tonnes, model grade vs actual grade, reconciliation factor (F1/F2/F3), variance explanation, and sign-off. Sourced from LabWare LIMS, Caterpillar MineStar, and Geovia GEMS. Critical for JORC compliance and resource model confidence.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`plan_scenario` (
    `plan_scenario_id` BIGINT COMMENT 'Unique identifier for the mine plan scenario record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Mine plan scenarios are created to evaluate capital project alternatives (different pit expansion sequences, processing capacity options, mining method changes). Each scenario evaluates a specific cap',
    `lom_plan_id` BIGINT COMMENT 'Reference to the parent Life of Mine plan that this scenario supports or derives from.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site for which this scenario is planned.',
    `parent_scenario_plan_scenario_id` BIGINT COMMENT 'Reference to the parent scenario from which this scenario was derived or forked, enabling scenario lineage tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who created this scenario record.',
    `project_valuation_id` BIGINT COMMENT 'Foreign key linking to finance.project_valuation. Business justification: Mine plan scenarios are valued for sensitivity analysis, trade-off studies, and investment option evaluation. Scenario valuation link for mining project economics and decision-making.',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Mine plan scenarios test sensitivity against resource statement assumptions. Required for feasibility studies, understanding resource confidence impacts on economics, and scenario planning.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Mine plan scenarios evaluate extraction strategies constrained by tenement boundaries, expiry dates, and expenditure commitments. Essential for strategic planning, NPV analysis, and tenement renewal d',
    `base_plan_scenario_id` BIGINT COMMENT 'Self-referencing FK on plan_scenario (base_plan_scenario_id)',
    `aisc_usd_per_t` DECIMAL(18,2) COMMENT 'All-In Sustaining Cost in US dollars per tonne calculated for this scenario.',
    `approval_date` DATE COMMENT 'Date when this scenario was formally approved for use in decision-making or investment analysis.',
    `average_ore_grade` DECIMAL(18,2) COMMENT 'Average ore grade assumed across the scenario planning horizon.',
    `commodity_price_assumption_usd` DECIMAL(18,2) COMMENT 'Assumed commodity price in US dollars per unit used for economic modeling in this scenario.',
    `commodity_price_unit` STRING COMMENT 'Unit of measure for the commodity price assumption (e.g., per tonne, per pound, per ounce).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario record was first created in the system.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold used to classify material as ore in this scenario.',
    `cutoff_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade (e.g., percent, grams per tonne, parts per million).',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'Discount rate percentage applied for Net Present Value (NPV) calculations in this scenario.',
    `exchange_rate_assumption` DECIMAL(18,2) COMMENT 'Assumed foreign exchange rate used for currency conversion in economic modeling for this scenario.',
    `exchange_rate_currency_pair` STRING COMMENT 'Currency pair for the exchange rate assumption (e.g., USD/AUD, USD/CAD).',
    `external_scenario_reference` STRING COMMENT 'External reference identifier or file path in the source planning system (Deswik or Hexagon MinePlan) for traceability.',
    `fleet_size_constraint` STRING COMMENT 'Maximum number of equipment units (trucks, loaders, drills) assumed available in this scenario as a constraint parameter.',
    `irr_pct` DECIMAL(18,2) COMMENT 'Internal Rate of Return percentage calculated for this scenario.',
    `market_demand_constraint_tpa` DECIMAL(18,2) COMMENT 'Maximum annual market demand in tonnes per annum assumed as a constraint in this scenario.',
    `mining_method` STRING COMMENT 'Primary mining method assumed in this scenario (open pit, underground, sub-level caving, block caving, longwall, room and pillar, or mixed methods). [ENUM-REF-CANDIDATE: open_pit|underground|sub_level_caving|block_caving|longwall|room_and_pillar|mixed — 7 candidates stripped; promote to reference product]',
    `npv_musd` DECIMAL(18,2) COMMENT 'Net Present Value in million US dollars calculated for this scenario using the assumed discount rate.',
    `planned_recovery_rate_pct` DECIMAL(18,2) COMMENT 'Planned mineral recovery rate percentage from processing assumed in this scenario.',
    `planning_horizon_end_date` DATE COMMENT 'End date of the planning horizon covered by this scenario.',
    `planning_horizon_start_date` DATE COMMENT 'Start date of the planning horizon covered by this scenario.',
    `planning_horizon_years` STRING COMMENT 'Duration of the planning horizon in years for this scenario.',
    `primary_commodity` STRING COMMENT 'Primary commodity targeted in this mine plan scenario (e.g., iron ore, copper, coal, lithium, nickel).',
    `processing_capacity_constraint_tpa` DECIMAL(18,2) COMMENT 'Maximum annual processing plant capacity in tonnes per annum assumed as a constraint in this scenario.',
    `reporting_standard` STRING COMMENT 'Mineral resource reporting standard applied to this scenario (JORC, NI 43-101, SAMREC, SEC S-K 1300, PERC).. Valid values are `JORC|NI_43_101|SAMREC|SEC_SK_1300|PERC`',
    `resource_classification` STRING COMMENT 'Resource classification category used in this scenario (e.g., Measured, Indicated, Inferred, Proved, Probable).',
    `scenario_code` STRING COMMENT 'Business identifier code for the mine plan scenario, used for external reference and reporting.',
    `scenario_description` STRING COMMENT 'Detailed textual description of the scenario purpose, assumptions, and key differentiators from other scenarios.',
    `scenario_name` STRING COMMENT 'Descriptive name of the mine plan scenario for business user identification and reporting purposes.',
    `scenario_status` STRING COMMENT 'Current lifecycle status of the mine plan scenario in the approval workflow.. Valid values are `draft|under_review|approved|superseded|archived|rejected`',
    `scenario_type` STRING COMMENT 'Classification of the scenario type indicating the planning approach or purpose (base case, optimistic, pessimistic, sensitivity analysis, feasibility study, expansion plan).. Valid values are `base_case|optimistic|pessimistic|sensitivity|feasibility|expansion`',
    `scenario_version` STRING COMMENT 'Version number of this scenario, incremented with each revision to support version control and audit trail.',
    `sensitivity_parameter` STRING COMMENT 'Key parameter being varied in sensitivity analysis scenarios (e.g., commodity price, exchange rate, discount rate, recovery rate).',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this scenario was created or imported (Deswik, Hexagon MinePlan, Geovia GEMS, Manual entry, Other).. Valid values are `DESWIK|HEXAGON_MINEPLAN|GEOVIA_GEMS|MANUAL|OTHER`',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Overall strip ratio (waste to ore ratio) assumed in this scenario.',
    `superseded_date` DATE COMMENT 'Date when this scenario was superseded by a newer version or alternative scenario.',
    `total_capex_musd` DECIMAL(18,2) COMMENT 'Total capital expenditure in million US dollars assumed for this scenario.',
    `total_opex_musd` DECIMAL(18,2) COMMENT 'Total operating expenditure in million US dollars assumed for this scenario.',
    `total_ore_reserve_mt` DECIMAL(18,2) COMMENT 'Total ore reserve in million tonnes assumed in this scenario.',
    `total_waste_mt` DECIMAL(18,2) COMMENT 'Total waste material in million tonnes assumed in this scenario.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario record was last updated.',
    CONSTRAINT pk_plan_scenario PRIMARY KEY(`plan_scenario_id`)
) COMMENT 'Master record of mine plan scenarios and versions capturing scenario name, planning horizon, commodity price assumptions, discount rate, exchange rate assumptions, constraint parameters (fleet size, processing capacity, market demand), status (draft, approved, superseded), approval workflow, and creation date. Enables comparison of alternative LOM strategies, sensitivity analysis, and investment decision audit trail. Sourced from Deswik and Hexagon MinePlan.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` (
    `equipment_schedule_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each equipment schedule assignment record in the lakehouse',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the specific mining asset (truck, excavator, drill, etc.) assigned to execute this production schedule',
    `employee_id` BIGINT COMMENT 'Reference to the mine planner or production supervisor who created this equipment assignment. Used for accountability and assignment audit trail.',
    `fleet_assignment_id` BIGINT COMMENT 'Reference to the equipment fleet or fleet configuration allocated to execute this production schedule. Links to the fleet management master record in Caterpillar MineStar FMS for execution tracking and OEE monitoring. [Moved from production_schedule: This attribute currently exists in production_schedule but represents the fleet configuration allocated to execute the schedule. In reality, equipment assignments are made at the individual asset level (not fleet level), and each asset assignment may have different parameters. If fleet_id is used for aggregate planning, it should remain in production_schedule as a planning input, but the actual asset-level assignments with their specific hours, utilisation, and fuel budgets belong in this association. However, upon review, equipment_fleet_id appears to be a fleet-level planning attribute (aggregate fleet configuration) rather than individual asset assignment data, so it should likely REMAIN in production_schedule as a planning input. Removing this from the move list.]',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to the production schedule record that defines the mining block, time period, and production targets for this equipment assignment',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'The date and time when this equipment schedule assignment record was first created in the system. Supports audit trail and assignment history tracking.',
    `assignment_end_date` DATE COMMENT 'The calendar date when this asset assignment to the production schedule ends. May differ from the schedule period_end_date if equipment is reallocated before period completion.',
    `assignment_start_date` DATE COMMENT 'The calendar date when this asset assignment to the production schedule becomes effective. May differ from the schedule period_start_date if equipment is allocated mid-period.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the equipment assignment. Values: planned (assignment created but not yet active), active (asset currently deployed to this schedule), completed (schedule period finished), cancelled (assignment removed before completion), suspended (temporarily paused due to breakdown or reallocation). Used to track assignment lifecycle and enable dynamic fleet reallocation.',
    `assignment_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this equipment schedule assignment record was last modified. Supports change tracking and audit trail for fleet reallocation decisions.',
    `priority_rank` STRING COMMENT 'Priority ranking of this equipment assignment relative to other concurrent assignments for the same asset. Lower numbers indicate higher priority. Used when an asset is assigned to multiple overlapping schedules to determine allocation precedence.',
    `scheduled_fuel_budget_litres` DECIMAL(18,2) COMMENT 'The planned fuel consumption budget in litres allocated for this asset during the schedule period. Used for fuel logistics planning and cost control.',
    `scheduled_maintenance_window` STRING COMMENT 'Planned maintenance window or downtime period scheduled for this asset during the production schedule period (e.g., Week 2 Day Shift, Mid-period 24hr service). Used to coordinate production planning with maintenance planning.',
    `scheduled_operating_hours` DECIMAL(18,2) COMMENT 'The planned number of operating hours for this asset during the schedule period. Used to calculate equipment availability and utilisation targets for the mining block or bench.',
    `scheduled_utilisation_pct` DECIMAL(18,2) COMMENT 'The target utilisation percentage for this asset during the schedule period, calculated as productive hours divided by available hours. Used for fleet performance planning and KPI tracking.',
    CONSTRAINT pk_equipment_schedule_assignment PRIMARY KEY(`equipment_schedule_assignment_id`)
) COMMENT 'This association product represents the operational assignment of mining fleet and fixed plant assets to specific production schedules. It captures the planned deployment of equipment (haul trucks, excavators, drills, shovels, dozers, graders) to mining blocks, benches, and stopes for defined schedule periods. Each record links one production schedule to one asset with operational planning attributes including scheduled operating hours, utilisation targets, fuel budgets, and maintenance windows. This is the core of mine production planning and fleet deployment optimization, enabling mine planners to allocate equipment resources across multiple concurrent schedules and track asset utilisation across different mining areas and time periods.. Existence Justification: In mining operations, production schedules require multiple pieces of equipment (haul trucks, excavators, drills, dozers) to be deployed simultaneously to mining blocks and benches, and each asset works across multiple schedule periods and locations throughout the year. Mine planners actively create and manage these equipment assignments as part of the production planning workflow, tracking scheduled hours, utilisation targets, fuel budgets, and maintenance windows for each asset-schedule combination. This is a core operational business process called Equipment Scheduling or Fleet Assignment Planning.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` (
    `schedule_crew_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each production schedule crew assignment record',
    `employee_id` BIGINT COMMENT 'Reference to the mine planner or workforce coordinator who created this crew assignment. Used for accountability and assignment history tracking.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the crew assigned to execute this production schedule',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to the production schedule that requires crew execution',
    `assignment_notes` STRING COMMENT 'Free-text field for operational notes specific to this crew assignment, such as special equipment requirements, coordination dependencies, or constraints.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this crew assignment to the production schedule. Identified in detection phase as relationship-specific data. Tracks progression from planning through execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew assignment record was first created in the system. Used for audit trail.',
    `crew_role` STRING COMMENT 'The specific operational role this crew performs within this production schedule (e.g., drilling, blasting, loading, hauling). Identified in detection phase as relationship-specific data. A crew may have different roles in different schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew assignment record was last updated. Used for change tracking and audit trail.',
    `planned_hours` DECIMAL(18,2) COMMENT 'The total planned hours this crew is allocated to work on this production schedule. Identified in detection phase as relationship-specific data. Used for capacity planning and cost estimation.',
    `planned_shift_count` STRING COMMENT 'The number of shifts this crew is planned to work on this production schedule during the assignment period. Derived from scheduled dates and crew roster pattern.',
    `priority_rank` STRING COMMENT 'Priority ranking of this assignment when a crew is assigned to multiple concurrent schedules. Lower numbers indicate higher priority. Used for resource conflict resolution.',
    `scheduled_end_date` DATE COMMENT 'The date when this crew is scheduled to complete work on this production schedule. Identified in detection phase as relationship-specific data.',
    `scheduled_start_date` DATE COMMENT 'The date when this crew is scheduled to begin work on this production schedule. Identified in detection phase as relationship-specific data.',
    CONSTRAINT pk_schedule_crew_assignment PRIMARY KEY(`schedule_crew_assignment_id`)
) COMMENT 'This association product represents the operational assignment of mine crews to production schedules. It captures the planned allocation of specific crews (drilling, blasting, loading, hauling, maintenance) to execute production schedules across different mining blocks, benches, and time periods. Each record links one production schedule to one crew with temporal and role-specific attributes that exist only in the context of this assignment relationship. Essential for workforce capacity planning, production schedule feasibility validation, and shift-based execution tracking.. Existence Justification: In mining operations, production schedules require multiple specialized crews to execute different phases of the extraction process - drilling crews prepare blast holes, blasting crews execute controlled explosions, loading crews operate excavators, and hauling crews transport material. Each crew is simultaneously assigned to multiple production schedules across different mining blocks, benches, and time periods based on equipment allocation, skill requirements, and operational sequencing. The assignment itself carries critical operational data including temporal coordination (scheduled start/end dates), role specification (what function the crew performs in this schedule), planned capacity (hours allocated), and status tracking (planned through completed).';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` (
    `stockpile_circuit_feed_id` BIGINT COMMENT 'Unique surrogate identifier for the stockpile-circuit feed relationship record. Primary key.',
    `circuit_id` BIGINT COMMENT 'Foreign key linking to the processing circuit receiving feed from this stockpile',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to the ROM stockpile that feeds this circuit',
    `blend_ratio_pct` DECIMAL(18,2) COMMENT 'Target percentage contribution of this stockpile to the total feed blend for this circuit. Used in multi-stockpile blending strategies to achieve target feed grade and quality.',
    `conveyor_route_code` STRING COMMENT 'Code identifying the conveyor system route used to transport material from this stockpile to this circuit. Supports logistics and maintenance planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this stockpile-circuit feed relationship record was created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this stockpile-circuit feed relationship became or becomes active. Supports temporal feed scheduling and historical analysis.',
    `effective_to_date` DATE COMMENT 'Date until which this stockpile-circuit feed relationship remains or remained active. Null indicates currently active. Supports temporal feed scheduling and historical analysis.',
    `feed_priority` STRING COMMENT 'Integer ranking indicating the priority order in which this stockpile should feed this specific circuit. Lower numbers indicate higher priority. Used when multiple stockpiles can feed the same circuit.',
    `feed_rate_tph` DECIMAL(18,2) COMMENT 'Target or actual feed rate from this stockpile to this circuit expressed in dry metric tonnes per hour. Drives production scheduling and circuit loading.',
    `feed_status` STRING COMMENT 'Current operational status of this stockpile-circuit feed relationship. Active = currently feeding, Planned = scheduled future feed, Suspended = temporarily halted, Completed = historical feed relationship ended.',
    `reclaim_method` STRING COMMENT 'Method used to reclaim material from this stockpile for feeding this circuit (e.g., Front-End Loader, Reclaimer, Apron Feeder). Drives operational planning and equipment allocation.',
    `reclaim_priority` STRING COMMENT 'Integer ranking indicating the priority order in which this stockpile should be reclaimed to the processing plant feed. Lower number = higher priority. Used by plant feed scheduling to manage blend quality and FIFO/grade-based reclaim strategies. [Moved from rom_stockpile: Reclaim priority is not an absolute property of the ROM stockpile itself, but rather depends on which circuit is being fed. A stockpile may have high priority for one circuit (e.g., oxide ore to leach circuit) but low priority for another (e.g., same stockpile to flotation circuit). This attribute belongs in the association as feed_priority.]',
    `reclaim_rate_t_hr` DECIMAL(18,2) COMMENT 'Design or operational reclaim rate of material from this stockpile to the processing plant in tonnes per hour. Used for plant feed scheduling and production planning. [Moved from rom_stockpile: Reclaim rate varies by destination circuit based on circuit capacity, feed requirements, and blending strategy. A stockpile may feed different circuits at different rates. This attribute belongs in the association as feed_rate_tph.]',
    `target_feed_grade_pct` DECIMAL(18,2) COMMENT 'Target head grade of the primary valuable element for this specific stockpile-circuit feed pairing. May differ from circuit-level target when blending multiple stockpiles.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this stockpile-circuit feed relationship record was last modified.',
    CONSTRAINT pk_stockpile_circuit_feed PRIMARY KEY(`stockpile_circuit_feed_id`)
) COMMENT 'This association product represents the operational feed scheduling relationship between ROM stockpiles and processing circuits. It captures the feed rate, blend ratio, and priority for each stockpile-circuit pairing, enabling mine-to-mill optimization and feed quality management. Each record links one ROM stockpile to one processing circuit with attributes that exist only in the context of this feed scheduling relationship.. Existence Justification: In mining operations, ROM stockpiles serve as intermediate storage between mining and processing, and the feed scheduling relationship is genuinely many-to-many. A single ROM stockpile can feed multiple processing circuits (e.g., high-grade material to primary circuit, low-grade to secondary circuit, oxide ore to leach circuit while sulphide goes to flotation). Conversely, a processing circuit draws from multiple stockpiles to achieve target feed grade through blending strategies. Plant metallurgists and production schedulers actively manage these feed relationships, adjusting blend ratios, feed rates, and priorities based on stockpile inventory, ore quality, and circuit performance.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`stockpile_blend` (
    `stockpile_blend_id` BIGINT COMMENT 'Unique surrogate identifier for this ROM stockpile to saleable product blend record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user (typically a mine planning engineer or metallurgist) who created this blend recipe record.',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to the ROM stockpile contributing material to this blend',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to the saleable product being produced from this blend',
    `actual_reclaim_tonnes` DECIMAL(18,2) COMMENT 'Actual tonnes reclaimed from this ROM stockpile for this saleable product blend to date. Used for reconciliation against target and inventory tracking.',
    `blend_ratio_pct` DECIMAL(18,2) COMMENT 'Percentage contribution of this ROM stockpile to the saleable product blend recipe. Represents the proportion of material from this stockpile in the final product blend. Identified in detection phase relationship data.',
    `blend_recipe_version` STRING COMMENT 'Version identifier for the blend recipe specification. Blend recipes are versioned as they are refined based on actual quality outcomes and changing stockpile characteristics.',
    `blend_status` STRING COMMENT 'Current operational status of this blend recipe. Planned: designed but not yet in use, Active: currently being executed, Suspended: temporarily paused, Completed: no longer in use (superseded), Cancelled: abandoned before execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this blend recipe record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this blend recipe is effective and operational. Blend recipes change over time as stockpile inventory, grades, and product specifications evolve. Part of effective_date_range identified in detection phase.',
    `effective_to_date` DATE COMMENT 'Date until which this blend recipe is effective. Null indicates current active blend. Part of effective_date_range identified in detection phase.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this blend recipe record.',
    `quality_contribution_fe_pct` DECIMAL(18,2) COMMENT 'Contribution of this ROM stockpile to the iron (Fe) grade of the final saleable product, expressed as percentage. Used for blend quality modeling and product specification achievement. Identified in detection phase relationship data.',
    `quality_contribution_sio2_pct` DECIMAL(18,2) COMMENT 'Contribution of this ROM stockpile to the silica (SiO2) content of the final saleable product, expressed as percentage. Critical for managing impurity levels in product specifications. Identified in detection phase relationship data.',
    `reclaim_sequence` STRING COMMENT 'Integer indicating the order in which this ROM stockpile should be reclaimed when producing this saleable product. Governs operational scheduling of reclaim equipment and material flow to processing plant. Identified in detection phase relationship data.',
    `target_reclaim_tonnes` DECIMAL(18,2) COMMENT 'Planned tonnes to be reclaimed from this ROM stockpile for this saleable product blend over the effective period. Used for production planning and stockpile inventory management.',
    CONSTRAINT pk_stockpile_blend PRIMARY KEY(`stockpile_blend_id`)
) COMMENT 'This association product represents the blending operation between ROM stockpiles and saleable products. It captures the operational reality that saleable products are created by blending material from multiple ROM stockpiles, and each ROM stockpile contributes to multiple saleable products. Each record links one ROM stockpile to one saleable product with blend ratios, quality contributions, reclaim sequences, and effective date ranges that exist only in the context of this blending relationship.. Existence Justification: In mining operations, saleable products are created by blending material from multiple ROM stockpiles to achieve target grade specifications, and each ROM stockpile contributes material to multiple different saleable products over time. Blending is an active operational process managed by mine planning and metallurgy teams who create blend recipes specifying which stockpiles to reclaim, in what sequence, at what ratios, to produce each product grade. This is a core operational M:N relationship with substantial relationship-specific data.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`mine_site` (
    `mine_site_id` BIGINT COMMENT 'Primary key for mine_site',
    `parent_mine_site_id` BIGINT COMMENT 'Self-referencing FK on mine_site (parent_mine_site_id)',
    `annual_production_capacity_tonnes` DECIMAL(18,2) COMMENT 'Nameplate annual production capacity of the mine site in metric tonnes of ore or product.',
    `closure_date` DATE COMMENT 'Date when the mine site ceased operations or entered closure phase. Nullable for active sites.',
    `commissioning_date` DATE COMMENT 'Date when the mine site commenced commercial production operations.',
    `commodity_primary` STRING COMMENT 'The primary mineral or ore extracted at this mine site.',
    `commodity_secondary` STRING COMMENT 'Secondary or by-product minerals extracted at this mine site, if applicable. Comma-separated list.',
    `contact_email` STRING COMMENT 'Primary contact email address for the mine site administration.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the mine site office.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the mine site is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mine site record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts associated with this mine site.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Average elevation of the mine site surface above sea level in meters.',
    `environmental_permit_number` STRING COMMENT 'Official environmental approval or permit number issued by the regulatory authority.',
    `is_joint_venture` BOOLEAN COMMENT 'Indicates whether the mine site is operated as a joint venture with other mining companies.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the mine site centroid in decimal degrees.',
    `lease_expiry_date` DATE COMMENT 'Date when the current mining lease or permit expires. Nullable for indefinite leases subject to renewal.',
    `lease_number` STRING COMMENT 'Official mining lease or permit number issued by the regulatory authority.',
    `lease_start_date` DATE COMMENT 'Date when the mining lease or permit became effective.',
    `life_of_mine_years` DECIMAL(18,2) COMMENT 'Estimated remaining operational life of the mine in years based on current reserves and production rates.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the mine site centroid in decimal degrees.',
    `mining_method` STRING COMMENT 'Primary extraction technique employed at the mine site.',
    `nearest_town` STRING COMMENT 'Name of the nearest populated town or city to the mine site.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or contextual information about the mine site.',
    `operating_company` STRING COMMENT 'Legal name of the company or joint venture entity that operates the mine site.',
    `operational_status` STRING COMMENT 'Current operational state of the mine site in its lifecycle.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage ownership stake held by the parent company in this mine site. 100.00 for wholly-owned operations.',
    `postal_address` STRING COMMENT 'Full postal address of the mine site office or administrative location.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the mine site location.',
    `rehabilitation_bond_amount` DECIMAL(18,2) COMMENT 'Financial bond or guarantee amount held by regulatory authorities for site rehabilitation and closure obligations, in local currency.',
    `safety_rating` STRING COMMENT 'Current safety performance rating of the mine site based on incident frequency and severity metrics.',
    `site_area_hectares` DECIMAL(18,2) COMMENT 'Total land area covered by the mine site lease in hectares.',
    `site_code` STRING COMMENT 'Externally-known unique alphanumeric code for the mine site used in operational systems and reporting.',
    `site_name` STRING COMMENT 'Official name of the mine site as registered with regulatory authorities and used in business communications.',
    `site_type` STRING COMMENT 'Classification of the mine site based on extraction method and operational phase.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the mine site is located.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the mine site location (e.g., Australia/Perth, America/Santiago).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this mine site record was last modified in the system.',
    `workforce_count` STRING COMMENT 'Total number of employees and contractors working at the mine site.',
    CONSTRAINT pk_mine_site PRIMARY KEY(`mine_site_id`)
) COMMENT 'Master reference table for mine_site. Referenced by mine_site_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `parent_site_id` BIGINT COMMENT 'Self-referencing FK on site (parent_site_id)',
    `annual_production_capacity_tonnes` DECIMAL(18,2) COMMENT 'Maximum annual production capacity of the site measured in tonnes of ore or product.',
    `average_ore_grade_percent` DECIMAL(18,2) COMMENT 'Average grade or concentration of the primary commodity in the ore body, expressed as a percentage.',
    `closure_date` DATE COMMENT 'Date when the site ceased operations or is planned to cease operations.',
    `commissioning_date` DATE COMMENT 'Date when the site commenced commercial production operations.',
    `contact_email` STRING COMMENT 'Primary contact email address for the site office.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the site office.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the site is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this site record was first created in the system.',
    `distance_to_port_km` DECIMAL(18,2) COMMENT 'Distance from the site to the primary export port measured in kilometers.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Average elevation of the site above sea level measured in meters.',
    `environmental_permit_number` STRING COMMENT 'Government-issued environmental approval or permit identifier authorizing mining operations.',
    `has_port_facility` BOOLEAN COMMENT 'Indicates whether the site includes or operates a dedicated port or ship loading facility.',
    `has_processing_plant` BOOLEAN COMMENT 'Indicates whether the site has an on-site ore processing or beneficiation plant.',
    `has_rail_connection` BOOLEAN COMMENT 'Indicates whether the site is connected to a rail network for product transportation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this site record is currently active and in use for operational reporting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this site record was last modified in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the site centroid in decimal degrees.',
    `lease_expiry_date` DATE COMMENT 'Date when the current mining lease expires and requires renewal or extension.',
    `life_of_mine_years` DECIMAL(18,2) COMMENT 'Estimated remaining operational life of the mine in years based on current reserves and production rates.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the site centroid in decimal degrees.',
    `mining_lease_number` STRING COMMENT 'Government-issued mining lease or tenement identifier authorizing extraction activities.',
    `nearest_town` STRING COMMENT 'Name of the nearest populated town or city to the site.',
    `operational_status` STRING COMMENT 'Current operational state of the site in its lifecycle.',
    `ore_reserve_tonnes` DECIMAL(18,2) COMMENT 'Total proven and probable ore reserves at the site measured in tonnes, as per JORC or NI 43-101 standards.',
    `postal_address` STRING COMMENT 'Full postal address of the site office for correspondence and deliveries.',
    `primary_commodity` STRING COMMENT 'The principal mineral or ore extracted at this site.',
    `rehabilitation_bond_amount` DECIMAL(18,2) COMMENT 'Financial security or bond amount held by regulatory authorities for site rehabilitation and closure obligations.',
    `secondary_commodities` STRING COMMENT 'Additional minerals or ores extracted as by-products at this site, comma-separated list.',
    `site_area_hectares` DECIMAL(18,2) COMMENT 'Total land area covered by the mining site including pit, infrastructure, and buffer zones, measured in hectares.',
    `site_code` STRING COMMENT 'Externally-known unique alphanumeric code for the site, used in operational systems and reporting.',
    `site_manager_name` STRING COMMENT 'Full name of the current site manager or general manager responsible for operations.',
    `site_name` STRING COMMENT 'Official name of the mining site as registered with regulatory authorities.',
    `site_type` STRING COMMENT 'Classification of the site based on mining method and operational purpose.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the site is located.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste material to ore that must be removed, expressed as waste tonnes per ore tonne.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the site location used for operational scheduling and reporting.',
    `workforce_capacity` STRING COMMENT 'Maximum number of personnel that can be accommodated at the site including employees and contractors.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master reference table for site. Referenced by site_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`haul_route` (
    `haul_route_id` BIGINT COMMENT 'Primary key for haul_route',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this haul route operates.',
    `location_id` BIGINT COMMENT 'Reference to the starting location of the haul route, typically a pit, bench, or stockpile.',
    `return_haul_route_id` BIGINT COMMENT 'Self-referencing FK on haul_route (return_haul_route_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the haul route record was first created in the system.',
    `destination_location_code` BIGINT COMMENT 'Reference to the ending location of the haul route, typically a crusher, ROM pad, or waste dump.',
    `dust_suppression_required_flag` BOOLEAN COMMENT 'Indicates whether active dust suppression measures are required on this route for environmental and health compliance.',
    `effective_from_date` DATE COMMENT 'Date when the haul route became or will become operational and available for use.',
    `effective_to_date` DATE COMMENT 'Date when the haul route is planned to be decommissioned or is no longer operational. Null for indefinite routes.',
    `estimated_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Planned round-trip cycle time for a loaded and empty haul, used in production scheduling and fleet sizing.',
    `gps_waypoints` STRING COMMENT 'Comma-separated list of GPS coordinate waypoints defining the haul route path for Fleet Management System (FMS) integration.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance activity was completed on the haul route.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the haul route record was most recently modified.',
    `lighting_available_flag` BOOLEAN COMMENT 'Indicates whether the haul route has permanent lighting infrastructure for night shift operations.',
    `maintenance_frequency_days` STRING COMMENT 'Standard interval in days between scheduled maintenance activities for the haul route.',
    `maximum_gradient_percent` DECIMAL(18,2) COMMENT 'Steepest gradient section along the haul route, critical for equipment selection and safety assessment.',
    `maximum_vehicle_capacity_tonnes` DECIMAL(18,2) COMMENT 'Maximum payload capacity in tonnes that vehicles are permitted to carry on this route, constrained by road design and gradient.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date when the next planned maintenance activity is scheduled for the haul route.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or constraints related to the haul route.',
    `number_of_lanes` STRING COMMENT 'Count of traffic lanes on the haul route. Single-lane routes require passing bays.',
    `permitted_vehicle_class` STRING COMMENT 'Classification of vehicles authorized to use this haul route based on size, weight, and operational capability.',
    `road_surface_type` STRING COMMENT 'Type of road surface material used on the haul route, affecting rolling resistance and maintenance requirements.',
    `road_width_m` DECIMAL(18,2) COMMENT 'Width of the haul road in meters, determining the size and number of vehicles that can safely operate.',
    `route_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the haul route. Used for operational communication and dispatch systems.',
    `route_condition_rating` STRING COMMENT 'Current assessed condition of the haul route based on surface quality, drainage, and structural integrity.',
    `route_distance_km` DECIMAL(18,2) COMMENT 'Total physical distance of the haul route measured in kilometers, used for cycle time calculation and fuel consumption estimation.',
    `route_gradient_percent` DECIMAL(18,2) COMMENT 'Average gradient or slope of the haul route expressed as a percentage. Positive values indicate uphill, negative values indicate downhill.',
    `route_name` STRING COMMENT 'Human-readable descriptive name of the haul route, typically including origin and destination landmarks.',
    `route_priority` STRING COMMENT 'Operational priority level of the haul route for maintenance scheduling and resource allocation.',
    `route_status` STRING COMMENT 'Current operational status of the haul route indicating availability for use in production scheduling.',
    `route_type` STRING COMMENT 'Classification of the haul route based on origin and destination function within the mining operation.',
    `safety_risk_level` STRING COMMENT 'Assessed safety risk level of the haul route based on gradient, width, surface condition, and historical incident data.',
    `speed_limit_kmh` STRING COMMENT 'Maximum permitted vehicle speed on the haul route for safety and operational control.',
    `traffic_control_type` STRING COMMENT 'Method of traffic management and control used on the haul route to ensure safe vehicle movement.',
    `weather_dependent_flag` BOOLEAN COMMENT 'Indicates whether the route is significantly affected by weather conditions and may require closure during adverse weather.',
    CONSTRAINT pk_haul_route PRIMARY KEY(`haul_route_id`)
) COMMENT 'Master reference table for haul_route. Referenced by haul_route_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`drill_pattern` (
    `drill_pattern_id` BIGINT COMMENT 'Primary key for drill_pattern',
    `employee_id` BIGINT COMMENT 'Reference to the authorized person who approved this drill pattern for operational use.',
    `designed_by_employee_id` BIGINT COMMENT 'Reference to the mining engineer or blast designer who created this drill pattern.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this drill pattern is applicable or was designed for.',
    `pit_or_level_id` BIGINT COMMENT 'Reference to the specific open pit or mining area where this pattern is used.',
    `adjacent_drill_pattern_id` BIGINT COMMENT 'Self-referencing FK on drill_pattern (adjacent_drill_pattern_id)',
    `approval_date` DATE COMMENT 'Date when this drill pattern was formally approved for operational use.',
    `bench_height_m` DECIMAL(18,2) COMMENT 'Vertical height of the mining bench in meters for which this drill pattern is designed.',
    `blast_type` STRING COMMENT 'Classification of the blast operation this pattern is designed for, determining explosive loading and timing requirements.',
    `burden_m` DECIMAL(18,2) COMMENT 'Distance in meters from the blast hole to the free face, critical parameter for blast energy distribution and fragmentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drill pattern record was first created in the system.',
    `design_date` DATE COMMENT 'Date when this drill pattern was originally designed or created.',
    `drill_rig_type` STRING COMMENT 'Recommended or required drilling equipment type for executing this pattern, ensuring operational compatibility.',
    `effective_from_date` DATE COMMENT 'Date from which this drill pattern becomes valid and available for operational use.',
    `effective_to_date` DATE COMMENT 'Date until which this drill pattern remains valid, nullable for patterns with indefinite validity.',
    `explosive_type` STRING COMMENT 'Primary explosive product specified for this drill pattern, determining blast performance characteristics.',
    `fragmentation_target_p80_mm` DECIMAL(18,2) COMMENT 'Target fragment size in millimeters where 80% of blasted material passes through, critical for downstream processing efficiency.',
    `hole_depth_m` DECIMAL(18,2) COMMENT 'Planned depth of blast holes in meters, typically including sub-drill below the bench floor.',
    `hole_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of blast holes in millimeters, determining explosive capacity and fragmentation characteristics.',
    `holes_per_row` STRING COMMENT 'Typical number of blast holes per row in this pattern configuration.',
    `initiation_system` STRING COMMENT 'Detonation initiation technology used for blast timing control and sequencing.',
    `is_standard_pattern` BOOLEAN COMMENT 'Indicates whether this is a standard, reusable pattern or a custom design for specific conditions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this drill pattern record was last updated or modified.',
    `number_of_rows` STRING COMMENT 'Typical number of hole rows in a blast using this pattern, affecting blast volume and timing complexity.',
    `ore_waste_classification` STRING COMMENT 'Material classification indicating whether this pattern is used for ore extraction, waste removal, or transitional material.',
    `pattern_code` STRING COMMENT 'Externally-known unique code identifying the drill pattern design, used for operational reference and communication.',
    `pattern_name` STRING COMMENT 'Human-readable name or designation of the drill pattern for identification and reporting purposes.',
    `pattern_notes` STRING COMMENT 'Additional operational notes, constraints, or special instructions for applying this drill pattern in the field.',
    `pattern_status` STRING COMMENT 'Current lifecycle status of the drill pattern indicating its availability for operational use.',
    `pattern_type` STRING COMMENT 'Classification of the drill pattern geometry used for blast design, determining hole spacing and burden configuration.',
    `powder_factor_kg_per_m3` DECIMAL(18,2) COMMENT 'Target explosive consumption in kilograms per cubic meter of rock, indicating blast intensity and fragmentation energy.',
    `rock_strength_mpa` DECIMAL(18,2) COMMENT 'Unconfined compressive strength of the target rock in megapascals, determining drilling difficulty and explosive requirements.',
    `rock_type` STRING COMMENT 'Primary geological rock type or material classification this pattern is designed for, influencing drilling and blasting parameters.',
    `safety_exclusion_zone_m` DECIMAL(18,2) COMMENT 'Minimum safe distance in meters required around the blast area when using this pattern, for personnel and equipment safety.',
    `spacing_m` DECIMAL(18,2) COMMENT 'Distance in meters between adjacent blast holes in a row, determining blast coverage and fragmentation uniformity.',
    `stemming_length_m` DECIMAL(18,2) COMMENT 'Length of inert material (stemming) placed at the top of the blast hole in meters to confine explosive gases.',
    `sub_drill_m` DECIMAL(18,2) COMMENT 'Additional drilling depth below the bench floor in meters to ensure complete breakage at the toe of the blast.',
    `version_number` STRING COMMENT 'Version number of this drill pattern design, incremented when pattern parameters are modified.',
    CONSTRAINT pk_drill_pattern PRIMARY KEY(`drill_pattern_id`)
) COMMENT 'Master reference table for drill_pattern. Referenced by drill_pattern_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`mine_area` (
    `mine_area_id` BIGINT COMMENT 'Primary key for mine_area',
    `mine_site_id` BIGINT COMMENT 'Reference to the parent mine site to which this area belongs.',
    `rom_stockpile_id` BIGINT COMMENT 'Reference to the primary ROM pad where ore from this area is delivered for initial processing.',
    `parent_mine_area_id` BIGINT COMMENT 'Self-referencing FK on mine_area (parent_mine_area_id)',
    `area_code` STRING COMMENT 'Externally-known unique code identifying the mine area, used in operational systems, planning documents, and reporting.',
    `area_name` STRING COMMENT 'Human-readable name of the mine area, used for identification in operational communications and planning.',
    `area_size_hectares` DECIMAL(18,2) COMMENT 'Total surface area of the mine area measured in hectares.',
    `area_type` STRING COMMENT 'Classification of the mine area based on its operational purpose and extraction method.',
    `blast_zone_flag` BOOLEAN COMMENT 'Indicates whether this area is designated for drill-and-blast operations.',
    `closure_planned_date` DATE COMMENT 'Planned date for closure of mining operations in this area based on life-of-mine planning.',
    `commissioning_date` DATE COMMENT 'Date when the mine area was officially commissioned and began operational production.',
    `commodity_primary` STRING COMMENT 'Primary mineral or commodity extracted from this mine area.',
    `commodity_secondary` STRING COMMENT 'Secondary or by-product commodities extracted from this mine area, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mine area record was first created in the system.',
    `depth_max_m` DECIMAL(18,2) COMMENT 'Maximum depth of the mine area below surface, measured in meters. Applicable to pits and underground workings.',
    `elevation_max_m` DECIMAL(18,2) COMMENT 'Maximum elevation of the mine area measured in meters above sea level.',
    `elevation_min_m` DECIMAL(18,2) COMMENT 'Minimum elevation of the mine area measured in meters above sea level.',
    `environmental_sensitivity` STRING COMMENT 'Classification of environmental sensitivity based on proximity to protected areas, water sources, or ecological significance.',
    `equipment_fleet_assigned` STRING COMMENT 'Designation of the primary equipment fleet assigned to operate in this mine area.',
    `extraction_method` STRING COMMENT 'Primary mining method employed in this area for ore extraction.',
    `geotechnical_risk_rating` STRING COMMENT 'Assessment of geotechnical stability and risk level for the mine area.',
    `haulage_route_primary` STRING COMMENT 'Primary haulage route designation for material transport from this area to processing or stockpile locations.',
    `last_survey_date` DATE COMMENT 'Date of the most recent surveying activity conducted in this mine area.',
    `life_of_mine_years` DECIMAL(18,2) COMMENT 'Estimated remaining operational life of the mine area based on current reserves and production rates, measured in years.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, constraints, or special considerations for this mine area.',
    `operational_status` STRING COMMENT 'Current operational state of the mine area in its lifecycle.',
    `ore_grade_percent` DECIMAL(18,2) COMMENT 'Average ore grade of the primary commodity in this area, expressed as percentage.',
    `ore_reserve_tonnes` DECIMAL(18,2) COMMENT 'Estimated proven and probable ore reserves in this area, measured in tonnes.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the mining permit for this area.',
    `permit_number` STRING COMMENT 'Regulatory permit or license number authorizing mining operations in this area.',
    `production_capacity_tonnes_per_year` DECIMAL(18,2) COMMENT 'Designed annual production capacity of the mine area, measured in tonnes per year.',
    `rehabilitation_status` STRING COMMENT 'Current status of mine closure and rehabilitation activities for the area.',
    `responsible_superintendent` STRING COMMENT 'Name or identifier of the mining superintendent responsible for operations in this area.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether this area is integrated with SCADA systems for real-time operational monitoring.',
    `shift_pattern` STRING COMMENT 'Operating shift pattern for this mine area, such as 24/7, day-shift-only, or FIFO roster pattern.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste material to ore that must be removed to extract the ore, expressed as waste:ore.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this mine area record was last updated in the system.',
    `water_management_zone` STRING COMMENT 'Designated water management zone or catchment area for environmental and operational water control.',
    CONSTRAINT pk_mine_area PRIMARY KEY(`mine_area_id`)
) COMMENT 'Master reference table for mine_area. Referenced by mine_area_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`blast_pattern` (
    `blast_pattern_id` BIGINT COMMENT 'Primary key for blast_pattern',
    `employee_id` BIGINT COMMENT 'Reference to the authorized person (typically a senior mining engineer or blasting superintendent) who approved this blast pattern for operational use.',
    `designed_by_employee_id` BIGINT COMMENT 'Reference to the mining engineer or blast designer who created this blast pattern.',
    `explosive_type_id` BIGINT COMMENT 'Reference to the primary explosive product used in this blast pattern (e.g., ANFO, emulsion, heavy ANFO).',
    `geological_unit_id` BIGINT COMMENT 'Reference to the geological rock type or lithology for which this blast pattern is optimized (e.g., iron ore, overburden, coal, hard rock).',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this blast pattern is designed for use.',
    `pit_or_level_id` BIGINT COMMENT 'Reference to the specific open-cut pit or mining area where this blast pattern is applied.',
    `adjacent_blast_pattern_id` BIGINT COMMENT 'Self-referencing FK on blast_pattern (adjacent_blast_pattern_id)',
    `application_notes` STRING COMMENT 'Free-text field capturing operational guidance, constraints, or special instructions for applying this blast pattern in the field.',
    `approval_date` DATE COMMENT 'Date when the blast pattern was formally approved for operational use.',
    `bench_height_m` DECIMAL(18,2) COMMENT 'Vertical height of the bench face in meters for which this blast pattern is designed. Critical parameter for calculating explosive load and fragmentation outcomes.',
    `burden_m` DECIMAL(18,2) COMMENT 'Perpendicular distance in meters from the blast hole to the free face. Primary design parameter controlling rock movement and fragmentation.',
    `charge_length_m` DECIMAL(18,2) COMMENT 'Total length of the explosive column in meters within the blast hole.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this blast pattern record was first created in the system.',
    `delay_timing_ms` STRING COMMENT 'Time delay in milliseconds between detonation of adjacent blast holes, used to control vibration, fragmentation, and muck pile throw.',
    `design_date` DATE COMMENT 'Date when the blast pattern was originally designed.',
    `effective_from_date` DATE COMMENT 'Date from which this blast pattern becomes valid for operational use.',
    `effective_to_date` DATE COMMENT 'Date until which this blast pattern remains valid. Nullable for patterns with indefinite validity.',
    `explosive_mass_per_hole_kg` DECIMAL(18,2) COMMENT 'Total mass of explosive loaded into each blast hole in kilograms.',
    `fragmentation_target_p80_mm` DECIMAL(18,2) COMMENT 'Target fragmentation size in millimeters where 80% of the blasted material passes through (P80 metric). Drives crusher feed requirements and downstream processing efficiency.',
    `hole_depth_m` DECIMAL(18,2) COMMENT 'Total depth of the blast hole in meters, including sub-drill below the bench floor to ensure complete breakage.',
    `hole_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of the blast holes in millimeters. Determines explosive charge capacity and influences fragmentation and powder factor.',
    `initiation_system_type` STRING COMMENT 'Type of detonation initiation system used in the blast pattern. Electronic systems offer precise timing; non-electric and shock tube systems are cost-effective alternatives.',
    `is_standard_pattern` BOOLEAN COMMENT 'Indicates whether this is a standard, repeatable blast pattern (true) or a custom, one-off design (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this blast pattern record was last updated in the system.',
    `number_of_holes` STRING COMMENT 'Total count of blast holes in the pattern design.',
    `number_of_rows` STRING COMMENT 'Number of rows of blast holes in the pattern, measured perpendicular to the free face.',
    `pattern_code` STRING COMMENT 'Externally-known unique code identifying the blast pattern design, used in operational communications and drill-and-blast planning systems.',
    `pattern_name` STRING COMMENT 'Human-readable name or designation of the blast pattern, typically describing the geometry or application context.',
    `pattern_type` STRING COMMENT 'Classification of the blast pattern geometry. Square and rectangular patterns are common in open-cut operations; staggered patterns optimize energy distribution; echelon patterns suit angled benches; radial patterns are used in underground or specialized applications.',
    `powder_factor_kg_per_m3` DECIMAL(18,2) COMMENT 'Mass of explosive in kilograms required to break one cubic meter of rock. Key performance indicator for blast efficiency and cost control.',
    `rock_strength_mpa` DECIMAL(18,2) COMMENT 'Unconfined compressive strength of the target rock in megapascals. Influences explosive selection and powder factor requirements.',
    `safety_exclusion_zone_m` DECIMAL(18,2) COMMENT 'Minimum safe distance in meters from the blast area within which all personnel and equipment must be evacuated prior to detonation.',
    `spacing_m` DECIMAL(18,2) COMMENT 'Distance in meters between adjacent blast holes in the same row. Typically 1.0 to 1.5 times the burden distance.',
    `blast_pattern_status` STRING COMMENT 'Current lifecycle status of the blast pattern. Active patterns are approved for operational use; draft patterns are under design; retired patterns are no longer used but retained for historical reference.',
    `stemming_length_m` DECIMAL(18,2) COMMENT 'Length of inert material (typically crushed rock or drill cuttings) placed at the top of the blast hole in meters to confine explosive gases and prevent premature venting.',
    `sub_drill_m` DECIMAL(18,2) COMMENT 'Additional drilling depth below the bench floor in meters to ensure complete rock breakage at the toe of the blast.',
    `version_number` STRING COMMENT 'Version number of the blast pattern design, incremented when modifications are made to an existing pattern.',
    CONSTRAINT pk_blast_pattern PRIMARY KEY(`blast_pattern_id`)
) COMMENT 'Master reference table for blast_pattern. Referenced by blast_pattern_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`pit_or_level` (
    `pit_or_level_id` BIGINT COMMENT 'Primary key for pit_or_level',
    `mine_site_id` BIGINT COMMENT 'Reference to the parent mine site where this pit or level is located.',
    `rehabilitation_provision_id` BIGINT COMMENT 'Reference to the approved environmental rehabilitation plan for this pit or level upon closure.',
    `parent_pit_or_level_id` BIGINT COMMENT 'Self-referencing FK on pit_or_level (parent_pit_or_level_id)',
    `access_ramp_code` BIGINT COMMENT 'Reference to the primary access ramp or decline providing haulage access to this pit or level.',
    `actual_completion_date` DATE COMMENT 'Actual date when mining operations were completed at this pit or level. Used for historical analysis and future planning accuracy.',
    `actual_start_date` DATE COMMENT 'Actual date when mining operations commenced at this pit or level. Used for schedule variance analysis and performance tracking.',
    `average_ore_grade_percent` DECIMAL(18,2) COMMENT 'Average grade of ore at this pit or level, expressed as percentage of target mineral content. Business-sensitive data used for mine sequencing and blending strategies.',
    `bench_height_m` DECIMAL(18,2) COMMENT 'Vertical height of the mining bench at this level, measured in meters. Standard bench heights are critical for blast design and equipment selection.',
    `blast_pattern_code` STRING COMMENT 'Standard blast design pattern code used at this pit or level. References drill spacing, burden, and explosive configuration for this geological domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pit or level record was first created in the system. Used for data lineage and audit purposes.',
    `cutoff_grade_percent` DECIMAL(18,2) COMMENT 'Minimum ore grade threshold for economic extraction at this pit or level, expressed as percentage. Material below this grade is classified as waste.',
    `depth_m` DECIMAL(18,2) COMMENT 'Vertical depth of the pit or level from surface or reference datum, measured in meters. Used for geotechnical analysis and ventilation planning.',
    `design_capacity_tonnes_per_day` DECIMAL(18,2) COMMENT 'Planned daily production capacity for this pit or level, measured in tonnes per day. Used for production scheduling and resource allocation.',
    `dilution_factor_percent` DECIMAL(18,2) COMMENT 'Expected percentage of waste material mixed with ore during extraction at this pit or level. Used for grade reconciliation and mill feed planning.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the pit floor or level datum above sea level, measured in meters. Critical for mine planning, haulage optimization, and surveying.',
    `geotechnical_risk_rating` STRING COMMENT 'Assessment of ground stability and geotechnical hazards at this pit or level: low (stable), moderate (manageable risks), high (significant controls required), or extreme (critical hazard management).',
    `haulage_distance_km` DECIMAL(18,2) COMMENT 'Average haulage distance from this pit or level to the primary destination (ROM pad, crusher, or waste dump), measured in kilometers. Used for cycle time and cost modeling.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this pit or level record is currently active and valid for operational use. True indicates active, False indicates inactive or archived.',
    `mining_method` STRING COMMENT 'The extraction method employed at this pit or level: open-cut/open-pit for surface mining, underground methods including block cave, sublevel stoping, longwall, or room and pillar.',
    `pit_or_level_name` STRING COMMENT 'Human-readable name of the pit or level for identification and communication purposes.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, or additional context about this pit or level.',
    `ore_reserve_tonnes` DECIMAL(18,2) COMMENT 'Estimated economically recoverable ore reserves at this pit or level, measured in tonnes. Business-sensitive reserve data used for Life of Mine (LOM) planning.',
    `pit_or_level_code` STRING COMMENT 'Business identifier code for the pit or level, used in operational systems and reporting. Externally-known unique code.',
    `planned_completion_date` DATE COMMENT 'Scheduled date for completion of mining operations at this pit or level. Used for Life of Mine (LOM) planning and closure planning.',
    `planned_start_date` DATE COMMENT 'Scheduled date for commencement of mining operations at this pit or level. Used for production scheduling and resource planning.',
    `primary_commodity` STRING COMMENT 'The primary mineral commodity being extracted from this pit or level: iron ore, copper, coal, lithium, nickel, gold, silver, zinc, lead, or bauxite.',
    `recovery_factor_percent` DECIMAL(18,2) COMMENT 'Expected percentage of in-situ ore that will be successfully extracted and recovered from this pit or level. Accounts for mining losses and operational constraints.',
    `secondary_commodity` STRING COMMENT 'Secondary or by-product mineral commodity present at this pit or level, if applicable. Used for polymetallic deposit planning and revenue optimization.',
    `slope_angle_degrees` DECIMAL(18,2) COMMENT 'Design slope angle for pit walls or level access at this location, measured in degrees from horizontal. Critical for geotechnical stability and safety.',
    `pit_or_level_status` STRING COMMENT 'Current lifecycle status of the pit or level: planned (future), design (engineering phase), development (construction), active (in production), depleted (ore exhausted), suspended (temporarily halted), closed (operations ceased), or rehabilitated (environmental restoration complete).',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste to ore for this pit or level, calculated as waste volume divided by ore volume. Key economic indicator for open-cut mining operations.',
    `surveyed_date` DATE COMMENT 'Date of the most recent survey measurement for this pit or level. Used for as-built reconciliation and spatial accuracy tracking.',
    `pit_or_level_type` STRING COMMENT 'Classification of the mining excavation structure: pit for open-cut operations, level for underground operations, bench for stepped excavation, stage for phased development, cutback for pit expansion, or pushback for sequential mining phases.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pit or level record was last modified. Used for change tracking and data quality monitoring.',
    `ventilation_requirement_m3_per_sec` DECIMAL(18,2) COMMENT 'Required airflow rate for underground levels, measured in cubic meters per second. Critical for occupational health and safety compliance.',
    `waste_volume_bcm` DECIMAL(18,2) COMMENT 'Estimated volume of waste material to be removed from this pit or level, measured in bank cubic meters. Critical for strip ratio calculation and waste dump planning.',
    `water_inflow_rate_liters_per_min` DECIMAL(18,2) COMMENT 'Average groundwater inflow rate at this pit or level, measured in liters per minute. Used for dewatering system design and water management planning.',
    CONSTRAINT pk_pit_or_level PRIMARY KEY(`pit_or_level_id`)
) COMMENT 'Master reference table for pit_or_level. Referenced by pit_or_level_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`bench` (
    `bench_id` BIGINT COMMENT 'Primary key for bench',
    `access_ramp_id` BIGINT COMMENT 'Reference to the primary access ramp providing haulage access to this bench.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this bench is located.',
    `pit_or_level_id` BIGINT COMMENT 'Reference to the pit or open-cut mine where this bench is located.',
    `parent_bench_id` BIGINT COMMENT 'Self-referencing FK on bench (parent_bench_id)',
    `actual_completion_date` DATE COMMENT 'Actual date when mining operations were completed on this bench.',
    `actual_start_date` DATE COMMENT 'Actual date when mining operations commenced on this bench.',
    `bench_code` STRING COMMENT 'Externally-known unique code for the bench used in mine planning and operational systems.',
    `bench_height_m` DECIMAL(18,2) COMMENT 'Vertical height of the bench face in meters, typically standardized within a pit design.',
    `bench_name` STRING COMMENT 'Human-readable name or designation of the bench.',
    `bench_status` STRING COMMENT 'Current operational status of the bench in its lifecycle: planned for future extraction, actively being mined, depleted of material, temporarily suspended, or permanently closed.',
    `bench_type` STRING COMMENT 'Classification of the bench based on material type: ore-bearing, waste rock, mixed material, overburden, or interburden.',
    `bench_width_m` DECIMAL(18,2) COMMENT 'Horizontal width of the bench working area in meters, measured from crest to toe.',
    `berm_width_m` DECIMAL(18,2) COMMENT 'Width of the safety berm or catch bench in meters, designed to catch falling material and provide access.',
    `blast_pattern_code` STRING COMMENT 'Code identifying the standard drill-and-blast pattern design used for this bench.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bench record was first created in the system.',
    `design_capacity_bcm` DECIMAL(18,2) COMMENT 'Planned total volume of material to be extracted from the bench in bank cubic meters (in-situ volume).',
    `drill_hole_burden_m` DECIMAL(18,2) COMMENT 'Standard distance from the drill hole to the free face (burden) in the blast pattern, measured in meters.',
    `drill_hole_diameter_mm` DECIMAL(18,2) COMMENT 'Standard diameter of blast holes drilled in the bench, measured in millimeters.',
    `drill_hole_spacing_m` DECIMAL(18,2) COMMENT 'Standard horizontal spacing between drill holes in the blast pattern, measured in meters.',
    `elevation_rl_m` DECIMAL(18,2) COMMENT 'The reduced level elevation of the bench floor in meters above mean sea level, used for vertical positioning in mine design.',
    `face_angle_degrees` DECIMAL(18,2) COMMENT 'Angle of the bench face in degrees from horizontal, critical for geotechnical stability and safety.',
    `geotechnical_domain` STRING COMMENT 'Geotechnical classification or domain code for the bench, indicating rock mass characteristics and stability parameters.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the bench is currently active in production operations.',
    `material_type` STRING COMMENT 'Primary geological material type present in the bench (e.g., iron ore, copper ore, coal, limestone, sandstone).',
    `mining_method` STRING COMMENT 'Primary extraction method used for the bench: drill-and-blast, rip-and-load (dozer ripping), direct loading, or selective mining.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, comments, or special instructions related to the bench.',
    `ore_grade_percent` DECIMAL(18,2) COMMENT 'Average ore grade percentage for the bench, representing the concentration of valuable mineral content.',
    `ore_tonnes` DECIMAL(18,2) COMMENT 'Estimated total tonnage of ore material within the bench.',
    `phase_code` STRING COMMENT 'Mine planning phase code indicating which development phase or pushback this bench belongs to.',
    `planned_completion_date` DATE COMMENT 'Scheduled date when mining operations are planned to be completed on this bench, per the Life of Mine (LOM) plan.',
    `planned_start_date` DATE COMMENT 'Scheduled date when mining operations are planned to commence on this bench, per the Life of Mine (LOM) plan.',
    `remaining_volume_bcm` DECIMAL(18,2) COMMENT 'Current remaining volume of material available for extraction from the bench in bank cubic meters.',
    `rock_mass_rating` STRING COMMENT 'Rock Mass Rating score for the bench, a geotechnical classification system indicating rock quality and stability.',
    `sequence_number` STRING COMMENT 'Mining sequence order number for the bench within the pit development plan, indicating the planned extraction order.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste tonnes to ore tonnes for the bench, a key economic indicator for mining operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the bench record was last modified in the system.',
    `waste_tonnes` DECIMAL(18,2) COMMENT 'Estimated total tonnage of waste material within the bench.',
    CONSTRAINT pk_bench PRIMARY KEY(`bench_id`)
) COMMENT 'Master reference table for bench. Referenced by bench_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `origin_location_id` BIGINT COMMENT 'Self-referencing FK on location (origin_location_id)',
    `access_restriction` STRING COMMENT 'Access control classification for the location. Used for safety management and operational security.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the location is currently active in operational systems and available for use in planning and scheduling.',
    `actual_end_date` DATE COMMENT 'Actual date when operations ceased at this location. Nullable for active locations.',
    `actual_start_date` DATE COMMENT 'Actual date when operations commenced at this location.',
    `area_sqm` DECIMAL(18,2) COMMENT 'Surface area of the location in square meters. Used for capacity planning, rehabilitation costing, and environmental impact assessment.',
    `bench_height_m` DECIMAL(18,2) COMMENT 'Vertical height of mining benches at this location in meters. Applicable to open-cut operations.',
    `blast_zone_flag` BOOLEAN COMMENT 'Indicates whether the location is within an active blast zone requiring special safety protocols.',
    `capacity_tonnes` DECIMAL(18,2) COMMENT 'Maximum material capacity of the location in tonnes. Used for stockpile management, ROM pad planning, and dump scheduling.',
    `coordinate_system` STRING COMMENT 'Spatial reference system used for location coordinates (e.g., WGS84, UTM Zone 50S, MGA94 Zone 51).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was first created in the system.',
    `location_description` STRING COMMENT 'Detailed textual description of the location including operational context, boundaries, and special characteristics.',
    `drainage_zone` STRING COMMENT 'Water drainage zone or catchment area identifier for the location. Used for water management and environmental compliance.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the location above mean sea level in meters. Critical for pit design, haul road planning, and drainage management.',
    `environmental_zone` STRING COMMENT 'Environmental management zone classification for the location (e.g., rehabilitation zone, buffer zone, heritage area).',
    `geotechnical_risk_rating` STRING COMMENT 'Geotechnical stability risk assessment rating for the location. Critical for safety and operational planning.',
    `grade_percent` DECIMAL(18,2) COMMENT 'Average ore grade at this location expressed as a percentage. Critical for mine planning, blending, and economic evaluation.',
    `haul_distance_km` DECIMAL(18,2) COMMENT 'Average haul distance from this location to the primary destination (e.g., crusher, ROM pad, waste dump) in kilometers.',
    `last_survey_date` DATE COMMENT 'Date of the most recent survey or measurement of this location. Critical for maintaining accurate spatial data and volume calculations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was last modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the location centroid in decimal degrees (WGS84).',
    `location_code` STRING COMMENT 'Externally-known unique code for the location used across operational systems and reporting.',
    `location_name` STRING COMMENT 'Human-readable name of the location (e.g., pit name, dump name, stockpile name, ROM pad identifier).',
    `location_status` STRING COMMENT 'Current operational status of the location in its lifecycle.',
    `location_type` STRING COMMENT 'Classification of the location within the mining operation. [ENUM-REF-CANDIDATE: pit|dump|stockpile|rom_pad|crusher|processing_plant|workshop|office|haul_road|bench|ramp|portal|stope|drive|shaft|decline|ore_pass|waste_dump|tailings_storage_facility — promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the location centroid in decimal degrees (WGS84).',
    `mine_site_id` BIGINT COMMENT 'Reference to the parent mine site to which this location belongs.',
    `mining_method` STRING COMMENT 'Primary mining method employed at this location.',
    `ore_type` STRING COMMENT 'Primary ore or mineral type extracted or stored at this location (e.g., iron ore, copper ore, coal, lithium, nickel).',
    `owner_department` STRING COMMENT 'Business unit or department responsible for managing this location (e.g., Mining Operations, Processing, Maintenance).',
    `parent_location_id` BIGINT COMMENT 'Reference to the parent location in a hierarchical location structure (e.g., a bench within a pit, a drive within a stope). Nullable for top-level locations.',
    `planned_end_date` DATE COMMENT 'Planned date for completion or closure of operations at this location. Used in Life of Mine (LOM) planning.',
    `planned_start_date` DATE COMMENT 'Planned date for commencement of operations at this location. Used in Life of Mine (LOM) planning.',
    `rehabilitation_required_flag` BOOLEAN COMMENT 'Indicates whether the location requires environmental rehabilitation upon closure or depletion.',
    `strip_ratio` DECIMAL(18,2) COMMENT 'Ratio of waste material to ore material at this location. Key metric for open-cut mining economics and scheduling.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Volume capacity of the location in cubic meters. Applicable to stockpiles, ROM pads, waste dumps, and tailings storage facilities.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by origin_location_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`explosive_type` (
    `explosive_type_id` BIGINT COMMENT 'Primary key for explosive_type',
    `parent_explosive_type_id` BIGINT COMMENT 'Self-referencing FK on explosive_type (parent_explosive_type_id)',
    `application_type` STRING COMMENT 'Primary mining application context for this explosive type (surface, underground, both). Determines operational suitability.',
    `approval_authority` STRING COMMENT 'Name of the regulatory body or authority that has approved this explosive type for use (e.g., state mining department, federal agency).',
    `approval_date` DATE COMMENT 'Date on which regulatory approval was granted for this explosive type. Used for compliance tracking and audit purposes.',
    `approval_expiry_date` DATE COMMENT 'Date on which the current regulatory approval expires and requires renewal. Null if approval does not expire.',
    `classification` STRING COMMENT 'Primary classification category of the explosive based on form and composition (bulk, packaged, emulsion, ANFO, watergel, slurry).',
    `explosive_type_code` STRING COMMENT 'Short alphanumeric code used to identify the explosive type in operational systems and blast designs. Typically 2-10 characters.',
    `compatibility_group` STRING COMMENT 'Single letter (A-S) indicating which explosives can be stored and transported together based on hazard compatibility.',
    `cost_per_kg` DECIMAL(18,2) COMMENT 'Standard cost per kilogram of this explosive type in the base currency. Used for blast cost estimation and budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this explosive type record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost_per_kg field (e.g., USD, AUD, CAD).',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Typical density of the explosive in kilograms per cubic meter. Critical for blast design calculations and loading specifications.',
    `explosive_type_description` STRING COMMENT 'Detailed description of the explosive type including composition, characteristics, and typical use cases in mining operations.',
    `effective_from_date` DATE COMMENT 'Date from which this explosive type record became effective and available for operational use.',
    `effective_to_date` DATE COMMENT 'Date on which this explosive type record ceased to be effective. Null if currently effective.',
    `energy_content_mj_per_kg` DECIMAL(18,2) COMMENT 'Energy released per kilogram of explosive, measured in megajoules. Used for blast energy calculations and fragmentation modeling.',
    `fume_class` STRING COMMENT 'Classification of toxic fume production (Class 1 = lowest toxicity, Class 3 = highest). Important for underground operations and ventilation planning.',
    `hazard_class` STRING COMMENT 'Dangerous goods hazard class and division for the explosive (e.g., 1.1, 1.5) per international transport regulations.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this explosive type is currently active and available for use in blast designs. True = active, False = inactive/discontinued.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this explosive type record was last updated. Used for audit trail and change tracking.',
    `manufacturer_name` STRING COMMENT 'Name of the primary manufacturer or supplier of this explosive type. Used for procurement and quality assurance.',
    `minimum_priming_requirement` STRING COMMENT 'Minimum primer or booster size and type required to reliably initiate this explosive type. Critical for blast design and safety.',
    `explosive_type_name` STRING COMMENT 'Full commercial or technical name of the explosive type (e.g., ANFO, Emulsion, Heavy ANFO, Bulk Emulsion).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this explosive type. Free-text field for operational guidance.',
    `product_family` STRING COMMENT 'Manufacturers product family or series name to which this explosive type belongs. Groups related explosive products.',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status for use in mining operations (approved, pending, expired, suspended, withdrawn).',
    `relative_bulk_strength_percent` DECIMAL(18,2) COMMENT 'Explosive strength per unit volume relative to ANFO. Accounts for density differences in blast design calculations.',
    `relative_weight_strength_percent` DECIMAL(18,2) COMMENT 'Explosive strength relative to ANFO (100%). Used to calculate equivalent explosive quantities and blast design parameters.',
    `sensitivity_rating` STRING COMMENT 'Sensitivity of the explosive to initiation by impact, friction, or heat (very_low, low, moderate, high, very_high). Affects handling and storage requirements.',
    `shelf_life_months` STRING COMMENT 'Maximum storage duration in months before the explosive degrades or requires re-certification. Used for inventory management and rotation.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum ambient temperature in Celsius at which the explosive maintains reliable performance and safety characteristics.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum ambient temperature in Celsius at which the explosive maintains reliable performance and safety characteristics.',
    `typical_hole_diameter_max_mm` DECIMAL(18,2) COMMENT 'Maximum blast hole diameter in millimeters for which this explosive type is typically suitable. Guides blast design parameters.',
    `typical_hole_diameter_min_mm` DECIMAL(18,2) COMMENT 'Minimum blast hole diameter in millimeters for which this explosive type is typically suitable. Guides blast design parameters.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for the explosive type used in transportation and regulatory compliance (e.g., UN0082, UN0241).',
    `velocity_of_detonation_m_per_s` DECIMAL(18,2) COMMENT 'Speed at which the detonation wave travels through the explosive, measured in meters per second. Key performance indicator for explosive effectiveness.',
    `water_resistance` STRING COMMENT 'Ability of the explosive to maintain performance in wet conditions (none, poor, fair, good, excellent). Critical for wet hole applications.',
    CONSTRAINT pk_explosive_type PRIMARY KEY(`explosive_type_id`)
) COMMENT 'Master reference table for explosive_type. Referenced by explosive_type_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`mine`.`access_ramp` (
    `access_ramp_id` BIGINT COMMENT 'Primary key for access_ramp',
    `connects_to_access_ramp_id` BIGINT COMMENT 'Self-referencing FK on access_ramp (connects_to_access_ramp_id)',
    `commissioning_date` DATE COMMENT 'Date when the access ramp was officially commissioned and put into operational service.',
    `construction_completion_date` DATE COMMENT 'Date when construction of the access ramp was completed and the ramp was ready for commissioning.',
    `construction_method` STRING COMMENT 'Engineering method used to construct the access ramp.',
    `construction_start_date` DATE COMMENT 'Date when construction of the access ramp commenced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access ramp record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the access ramp was or is planned to be decommissioned and removed from active service.',
    `design_capacity_tonnes_per_hour` DECIMAL(18,2) COMMENT 'The planned maximum haulage throughput capacity of the ramp in tonnes per hour based on engineering design specifications.',
    `drainage_system_installed` BOOLEAN COMMENT 'Indicates whether a drainage system is installed to manage water ingress and prevent flooding or erosion.',
    `emergency_egress_route` BOOLEAN COMMENT 'Indicates whether this ramp is designated as an emergency evacuation route for personnel safety.',
    `entry_elevation_meters` DECIMAL(18,2) COMMENT 'Elevation above sea level in meters at the ramp entry point.',
    `exit_elevation_meters` DECIMAL(18,2) COMMENT 'Elevation above sea level in meters at the ramp exit point.',
    `geotechnical_rating` STRING COMMENT 'Current geotechnical stability assessment rating of the ramp based on rock mass quality and ground conditions.',
    `gradient_percent` DECIMAL(18,2) COMMENT 'The slope or incline of the ramp expressed as a percentage, critical for haulage equipment performance and safety calculations.',
    `ground_support_type` STRING COMMENT 'Type of ground support system installed to maintain ramp stability and prevent rock falls.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety and structural inspection of the ramp.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this access ramp record was most recently modified in the system.',
    `length_meters` DECIMAL(18,2) COMMENT 'Total length of the access ramp in meters from entry to exit point.',
    `lighting_installed` BOOLEAN COMMENT 'Indicates whether permanent lighting infrastructure is installed along the ramp for operational safety.',
    `maximum_vehicle_weight_tonnes` DECIMAL(18,2) COMMENT 'Maximum gross vehicle weight in tonnes permitted to use this ramp based on structural and geotechnical design limits.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this access ramp is located.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection of the ramp based on regulatory and operational requirements.',
    `ore_type_access` STRING COMMENT 'Type of ore or mineral that this ramp provides access to, relevant for production planning and scheduling.',
    `pit_id` BIGINT COMMENT 'Reference to the specific open pit or underground mine area that this ramp provides access to.',
    `primary_use` STRING COMMENT 'The primary operational purpose or function that this ramp serves in the mine operations.',
    `ramp_code` STRING COMMENT 'Externally-known unique business identifier code for the access ramp used in operational systems and mine planning documentation.',
    `ramp_name` STRING COMMENT 'Human-readable name or designation of the access ramp for operational reference and communication.',
    `ramp_status` STRING COMMENT 'Current operational lifecycle status of the access ramp indicating its availability for use.',
    `ramp_type` STRING COMMENT 'Classification of the ramp based on its primary operational purpose within the mine infrastructure.',
    `remarks` STRING COMMENT 'Additional operational notes, observations, or special conditions related to the access ramp.',
    `speed_limit_kmh` STRING COMMENT 'Maximum permitted vehicle speed on the ramp in kilometers per hour for safety compliance.',
    `surface_type` STRING COMMENT 'Type of surface material used on the ramp floor for traction and durability.',
    `traffic_direction` STRING COMMENT 'Permitted traffic flow direction on the ramp for operational safety and efficiency.',
    `ventilation_type` STRING COMMENT 'Type of ventilation system installed in the ramp for air quality and safety management, particularly relevant for underground ramps.',
    `vertical_depth_meters` DECIMAL(18,2) COMMENT 'The vertical distance in meters that the ramp descends or ascends, representing the elevation change from surface or reference level.',
    `width_meters` DECIMAL(18,2) COMMENT 'The operational width of the ramp in meters, determining the size of equipment that can safely traverse it.',
    CONSTRAINT pk_access_ramp PRIMARY KEY(`access_ramp_id`)
) COMMENT 'Master reference table for access_ramp. Referenced by access_ramp_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_plan_scenario_id` FOREIGN KEY (`plan_scenario_id`) REFERENCES `mining_ecm`.`mine`.`plan_scenario`(`plan_scenario_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_plan_scenario_id` FOREIGN KEY (`plan_scenario_id`) REFERENCES `mining_ecm`.`mine`.`plan_scenario`(`plan_scenario_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_pit_or_stope_stope_design_id` FOREIGN KEY (`pit_or_stope_stope_design_id`) REFERENCES `mining_ecm`.`mine`.`stope_design`(`stope_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_plan_scenario_id` FOREIGN KEY (`plan_scenario_id`) REFERENCES `mining_ecm`.`mine`.`plan_scenario`(`plan_scenario_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_stope_design_id` FOREIGN KEY (`stope_design_id`) REFERENCES `mining_ecm`.`mine`.`stope_design`(`stope_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_blast_pattern_id` FOREIGN KEY (`blast_pattern_id`) REFERENCES `mining_ecm`.`mine`.`blast_pattern`(`blast_pattern_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_drill_pattern_id` FOREIGN KEY (`drill_pattern_id`) REFERENCES `mining_ecm`.`mine`.`drill_pattern`(`drill_pattern_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_grade_control_block_id` FOREIGN KEY (`grade_control_block_id`) REFERENCES `mining_ecm`.`mine`.`grade_control_block`(`grade_control_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_mine_area_id` FOREIGN KEY (`mine_area_id`) REFERENCES `mining_ecm`.`mine`.`mine_area`(`mine_area_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_grade_control_block_id` FOREIGN KEY (`grade_control_block_id`) REFERENCES `mining_ecm`.`mine`.`grade_control_block`(`grade_control_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_haul_route_id` FOREIGN KEY (`haul_route_id`) REFERENCES `mining_ecm`.`mine`.`haul_route`(`haul_route_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_grade_control_block_id` FOREIGN KEY (`grade_control_block_id`) REFERENCES `mining_ecm`.`mine`.`grade_control_block`(`grade_control_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_haul_route_id` FOREIGN KEY (`haul_route_id`) REFERENCES `mining_ecm`.`mine`.`haul_route`(`haul_route_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ADD CONSTRAINT `fk_mine_grade_control_block_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_previous_survey_survey_measurement_id` FOREIGN KEY (`previous_survey_survey_measurement_id`) REFERENCES `mining_ecm`.`mine`.`survey_measurement`(`survey_measurement_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_stope_design_id` FOREIGN KEY (`stope_design_id`) REFERENCES `mining_ecm`.`mine`.`stope_design`(`stope_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ADD CONSTRAINT `fk_mine_survey_measurement_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_stope_design_id` FOREIGN KEY (`stope_design_id`) REFERENCES `mining_ecm`.`mine`.`stope_design`(`stope_design_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_parent_scenario_plan_scenario_id` FOREIGN KEY (`parent_scenario_plan_scenario_id`) REFERENCES `mining_ecm`.`mine`.`plan_scenario`(`plan_scenario_id`);
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ADD CONSTRAINT `fk_mine_plan_scenario_base_plan_scenario_id` FOREIGN KEY (`base_plan_scenario_id`) REFERENCES `mining_ecm`.`mine`.`plan_scenario`(`plan_scenario_id`);
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ADD CONSTRAINT `fk_mine_equipment_schedule_assignment_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ADD CONSTRAINT `fk_mine_schedule_crew_assignment_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ADD CONSTRAINT `fk_mine_stockpile_circuit_feed_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ADD CONSTRAINT `fk_mine_stockpile_blend_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ADD CONSTRAINT `fk_mine_mine_site_parent_mine_site_id` FOREIGN KEY (`parent_mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`site` ADD CONSTRAINT `fk_mine_site_parent_site_id` FOREIGN KEY (`parent_site_id`) REFERENCES `mining_ecm`.`mine`.`site`(`site_id`);
ALTER TABLE `mining_ecm`.`mine`.`haul_route` ADD CONSTRAINT `fk_mine_haul_route_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`haul_route` ADD CONSTRAINT `fk_mine_haul_route_location_id` FOREIGN KEY (`location_id`) REFERENCES `mining_ecm`.`mine`.`location`(`location_id`);
ALTER TABLE `mining_ecm`.`mine`.`haul_route` ADD CONSTRAINT `fk_mine_haul_route_return_haul_route_id` FOREIGN KEY (`return_haul_route_id`) REFERENCES `mining_ecm`.`mine`.`haul_route`(`haul_route_id`);
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ADD CONSTRAINT `fk_mine_drill_pattern_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ADD CONSTRAINT `fk_mine_drill_pattern_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ADD CONSTRAINT `fk_mine_drill_pattern_adjacent_drill_pattern_id` FOREIGN KEY (`adjacent_drill_pattern_id`) REFERENCES `mining_ecm`.`mine`.`drill_pattern`(`drill_pattern_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ADD CONSTRAINT `fk_mine_mine_area_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ADD CONSTRAINT `fk_mine_mine_area_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ADD CONSTRAINT `fk_mine_mine_area_parent_mine_area_id` FOREIGN KEY (`parent_mine_area_id`) REFERENCES `mining_ecm`.`mine`.`mine_area`(`mine_area_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_explosive_type_id` FOREIGN KEY (`explosive_type_id`) REFERENCES `mining_ecm`.`mine`.`explosive_type`(`explosive_type_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_adjacent_blast_pattern_id` FOREIGN KEY (`adjacent_blast_pattern_id`) REFERENCES `mining_ecm`.`mine`.`blast_pattern`(`blast_pattern_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_parent_pit_or_level_id` FOREIGN KEY (`parent_pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_access_ramp_id` FOREIGN KEY (`access_ramp_id`) REFERENCES `mining_ecm`.`mine`.`access_ramp`(`access_ramp_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_parent_bench_id` FOREIGN KEY (`parent_bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`mine`.`location` ADD CONSTRAINT `fk_mine_location_origin_location_id` FOREIGN KEY (`origin_location_id`) REFERENCES `mining_ecm`.`mine`.`location`(`location_id`);
ALTER TABLE `mining_ecm`.`mine`.`explosive_type` ADD CONSTRAINT `fk_mine_explosive_type_parent_explosive_type_id` FOREIGN KEY (`parent_explosive_type_id`) REFERENCES `mining_ecm`.`mine`.`explosive_type`(`explosive_type_id`);
ALTER TABLE `mining_ecm`.`mine`.`access_ramp` ADD CONSTRAINT `fk_mine_access_ramp_connects_to_access_ramp_id` FOREIGN KEY (`connects_to_access_ramp_id`) REFERENCES `mining_ecm`.`mine`.`access_ramp`(`access_ramp_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`mine` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`mine` SET TAGS ('dbx_domain' = 'mine');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Design ID');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pit ID');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan ID');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `plan_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Plan Scenario Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `resettlement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `wireframe_id` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Design Approved By');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Design Approved Date');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `bench_height_m` SET TAGS ('dbx_business_glossary_term' = 'Bench Height (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `berm_width_m` SET TAGS ('dbx_business_glossary_term' = 'Catch Berm Width (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_value_regex' = 'pct|g_per_t|kg_per_t|ppm');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_code` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Code');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Design Engineer');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Design File Reference Path');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_name` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Name');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_notes` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Notes');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_status` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Status');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|archived');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Type');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `design_type` SET TAGS ('dbx_value_regex' = 'ultimate_pit|pushback|stage|cutback|interim');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Design Effective From Date');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Design Effective To Date');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `face_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Bench Face Angle (Degrees)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `geotechnical_domain` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Domain');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `hydrogeology_considered` SET TAGS ('dbx_business_glossary_term' = 'Hydrogeology Considered Flag');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `inter_ramp_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Inter-Ramp Slope Angle (Degrees)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|open_pit|strip_mining|highwall_mining');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `optimisation_software` SET TAGS ('dbx_business_glossary_term' = 'Pit Optimisation Software');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `optimisation_software` SET TAGS ('dbx_value_regex' = 'hexagon_mineplan|deswik|whittle|geovia_gems|other');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `ore_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Ore Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `overall_slope_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Overall Slope Angle (Degrees)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `pit_bottom_rl_m` SET TAGS ('dbx_business_glossary_term' = 'Pit Bottom Reduced Level (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `pit_crest_rl_m` SET TAGS ('dbx_business_glossary_term' = 'Pit Crest Reduced Level (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `pit_volume_bcm` SET TAGS ('dbx_business_glossary_term' = 'Pit Volume (Bank Cubic Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `ramp_gradient_pct` SET TAGS ('dbx_business_glossary_term' = 'Haul Road Ramp Gradient (Percent)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `ramp_width_m` SET TAGS ('dbx_business_glossary_term' = 'Haul Road Ramp Width (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `resource_model_version` SET TAGS ('dbx_business_glossary_term' = 'Resource Block Model Version');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `resource_model_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,30}$');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Date');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Number');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio (Waste to Ore)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `total_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Total Pit Depth (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ALTER COLUMN `waste_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Waste Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_design_id` SET TAGS ('dbx_business_glossary_term' = 'Stope Design ID');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block ID');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody ID');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `plan_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Plan Scenario Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `wireframe_id` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Engineer Name)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Design Approved Date');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `backfill_strength_mpa` SET TAGS ('dbx_business_glossary_term' = 'Backfill Unconfined Compressive Strength (MPa)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `backfill_type` SET TAGS ('dbx_business_glossary_term' = 'Backfill Type');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `backfill_type` SET TAGS ('dbx_value_regex' = 'cemented_paste|hydraulic_fill|rock_fill|cemented_rock_fill|uncemented_paste|none');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `design_date` SET TAGS ('dbx_business_glossary_term' = 'Design Date');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `design_grade_primary` SET TAGS ('dbx_business_glossary_term' = 'Designed Primary Commodity Grade');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `design_revision` SET TAGS ('dbx_business_glossary_term' = 'Design Revision Number');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `design_status` SET TAGS ('dbx_business_glossary_term' = 'Stope Design Status');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `design_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|issued_for_construction|superseded|cancelled');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `designed_by` SET TAGS ('dbx_business_glossary_term' = 'Designed By (Engineer Name)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `designed_dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Designed Dilution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `designed_ore_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Designed Ore Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `designed_recovery_pct` SET TAGS ('dbx_business_glossary_term' = 'Designed Ore Recovery Rate Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `designed_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Designed Stope Volume (cubic metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `deswik_stope_reference` SET TAGS ('dbx_business_glossary_term' = 'Deswik Stope Optimisation Identifier');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Extraction Method');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `extraction_method` SET TAGS ('dbx_value_regex' = 'longhole_open|longhole_retreat|cut_and_fill|sublevel_caving|sublevel_stoping|bench_and_fill');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `extraction_sequence` SET TAGS ('dbx_business_glossary_term' = 'Extraction Sequence Number');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `geovia_gems_stope_reference` SET TAGS ('dbx_business_glossary_term' = 'Geovia GEMS Stope Identifier');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `grade_unit` SET TAGS ('dbx_value_regex' = 'g/t|%|ppm|ppb');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `ground_support_class` SET TAGS ('dbx_business_glossary_term' = 'Ground Support Classification');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `ground_support_class` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `level_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Level Elevation (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `lom_schedule_period` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Schedule Period');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `ore_drive_count` SET TAGS ('dbx_business_glossary_term' = 'Ore Drive Count');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `ore_drive_height_m` SET TAGS ('dbx_business_glossary_term' = 'Ore Drive Height (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `ore_drive_width_m` SET TAGS ('dbx_business_glossary_term' = 'Ore Drive Width (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `pillar_type` SET TAGS ('dbx_business_glossary_term' = 'Pillar Type');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `pillar_type` SET TAGS ('dbx_value_regex' = 'crown|rib|sill|barrier|none');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `pillar_width_m` SET TAGS ('dbx_business_glossary_term' = 'Pillar Width (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `primary_commodity` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_code` SET TAGS ('dbx_business_glossary_term' = 'Stope Design Code');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_height_m` SET TAGS ('dbx_business_glossary_term' = 'Stope Height (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_length_m` SET TAGS ('dbx_business_glossary_term' = 'Stope Length (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_name` SET TAGS ('dbx_business_glossary_term' = 'Stope Name');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `stope_width_m` SET TAGS ('dbx_business_glossary_term' = 'Stope Width (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `sublevel_interval_m` SET TAGS ('dbx_business_glossary_term' = 'Sub-Level Caving (SLC) Interval (metres)');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ALTER COLUMN `ventilation_requirement_m3s` SET TAGS ('dbx_business_glossary_term' = 'Ventilation Airflow Requirement (cubic metres per second)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan ID');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `legal_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Legal Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `project_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Valuation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `aisc_usd_per_t` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) (USD per Tonne)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `aisc_usd_per_t` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'LOM Plan Approval Date');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'LOM Plan Approved By');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `average_annual_ore_mt` SET TAGS ('dbx_business_glossary_term' = 'Average Annual Ore Production (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `average_ore_grade` SET TAGS ('dbx_business_glossary_term' = 'Average Ore Grade');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `average_ore_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `c1_cash_cost_usd_per_t` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost (USD per Tonne)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `c1_cash_cost_usd_per_t` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `commodity_price_assumption_usd` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Assumption (USD per Unit)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `commodity_price_assumption_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `competent_person_name` SET TAGS ('dbx_business_glossary_term' = 'Competent Person / Qualified Person Name');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `competent_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_value_regex' = 'pct|g_per_t|kg_per_t|ppm');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (%)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `exchange_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Assumption (USD/Local Currency)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `exchange_rate_assumption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `irr_pct` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) (%)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `irr_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `lom_strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Strip Ratio');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `mine_life_years` SET TAGS ('dbx_business_glossary_term' = 'Mine Life (Years)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground|open_cut_underground|in_situ_leach|placer');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `npv_musd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) (Million USD)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `npv_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `peak_annual_ore_mt` SET TAGS ('dbx_business_glossary_term' = 'Peak Annual Ore Production (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Code');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^LOM-[A-Z0-9]{3,10}-[0-9]{4}$');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan End Date');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Name');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Start Date');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Status');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|archived');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Type');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'base_case|upside_case|downside_case|closure_case|feasibility');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan Version');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `planned_recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Metallurgical Recovery Rate (%)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `probable_reserve_mt` SET TAGS ('dbx_business_glossary_term' = 'Probable Ore Reserve (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `probable_reserve_mt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `proved_reserve_mt` SET TAGS ('dbx_business_glossary_term' = 'Proved Ore Reserve (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `proved_reserve_mt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Mineral Reporting Standard');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC|NI_43-101|SAMREC|SEC_SK1300|CIM');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Mineral Resource Classification');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'measured|indicated|inferred|measured_indicated');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `resource_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Deswik|Hexagon_MinePlan|Geovia_GEMS|manual');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_capex_musd` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (CAPEX) (Million USD)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_capex_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_opex_musd` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenditure (OPEX) (Million USD)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_opex_musd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_ore_reserve_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Ore Reserve (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_ore_reserve_mt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `total_waste_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Waste Movement (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Community Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `pit_or_stope_stope_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit or Stope ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `plan_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Plan Scenario Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Planner Employee ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Run of Mine (ROM) Pad ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `stope_design_id` SET TAGS ('dbx_business_glossary_term' = 'Stope Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Approved Date');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `is_lom_schedule` SET TAGS ('dbx_business_glossary_term' = 'Is Life of Mine (LOM) Schedule Flag');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground|open_cut_underground');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period End Date');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Start Date');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_blast_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Blast Count');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Capital Expenditure (CAPEX) USD');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Dilution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_drill_metres` SET TAGS ('dbx_business_glossary_term' = 'Planned Drill Metres');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_haulage_cycles` SET TAGS ('dbx_business_glossary_term' = 'Planned Haulage Cycles');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_opex_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Operating Expenditure (OPEX) USD');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_opex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_ore_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Planned Ore Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Recovery Rate Percentage');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Planned Strip Ratio');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_total_material_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Material Moved Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `planned_waste_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Planned Waste Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Mineral Resource Classification');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'measured|indicated|inferred|probable_reserve|proved_reserve');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_basis` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Basis');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_basis` SET TAGS ('dbx_value_regex' = 'budget|forecast|actual_reconciled|scenario');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Code');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Name');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Status');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|superseded|cancelled');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Type');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual|lom');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Version');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'DESWIK|HEXAGON_MINEPLAN|MANUAL');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `target_head_grade` SET TAGS ('dbx_business_glossary_term' = 'Target Head Grade');
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block ID');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model ID');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `cultural_heritage_site_id` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `wireframe_id` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `actual_extraction_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Extraction Date');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Block Code');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_height_m` SET TAGS ('dbx_business_glossary_term' = 'Block Height (metres)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_length_m` SET TAGS ('dbx_business_glossary_term' = 'Block Length (metres)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'planned|scheduled|active|extracted|reconciled|depleted');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `block_width_m` SET TAGS ('dbx_business_glossary_term' = 'Block Width (metres)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `centroid_easting_m` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Easting (metres)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `centroid_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Elevation (metres above sea level)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `centroid_northing_m` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Northing (metres)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `extraction_sequence` SET TAGS ('dbx_business_glossary_term' = 'Extraction Sequence Priority');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `hardness_index` SET TAGS ('dbx_business_glossary_term' = 'Rock Hardness Index (Bond Work Index)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `insitu_density` SET TAGS ('dbx_business_glossary_term' = 'In-Situ Density (t/m³)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `insitu_tonnes` SET TAGS ('dbx_business_glossary_term' = 'In-Situ Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `level_or_drive` SET TAGS ('dbx_business_glossary_term' = 'Underground Level or Drive');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `lom_period` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Period');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `lom_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}(-Q[1-4]|-H[12])?$');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'ore|waste|low_grade|marginal|overburden');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground_sublevel_caving|underground_longwall|underground_room_and_pillar|underground_cut_and_fill|underground_stoping');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `model_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Block Model Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Block Model Version');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_business_glossary_term' = 'Oxidation State');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_value_regex' = 'fresh|transitional|oxidised');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `pit_or_level_code` SET TAGS ('dbx_business_glossary_term' = 'Pit or Level ID');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `primary_grade` SET TAGS ('dbx_business_glossary_term' = 'Primary Element Grade');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `primary_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Primary Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `primary_grade_unit` SET TAGS ('dbx_value_regex' = 'pct|g_per_t|kg_per_t|ppm');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Recovery Factor (Recovery Rate)');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'measured|indicated|inferred|proved_reserve|probable_reserve');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `rock_type` SET TAGS ('dbx_business_glossary_term' = 'Rock Type');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `scheduled_extraction_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Extraction Date');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `secondary_grade` SET TAGS ('dbx_business_glossary_term' = 'Secondary Element Grade');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `secondary_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Secondary Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `secondary_grade_unit` SET TAGS ('dbx_value_regex' = 'pct|g_per_t|kg_per_t|ppm');
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio (Overburden to Ore Ratio)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Execution Identifier');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Pattern Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `drill_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Pattern Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Rig Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `grade_control_block_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident ID');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `mine_area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block ID');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit or Underground Level ID');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Crew Supervisor ID');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Design ID');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Explosive Material Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Target Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Shotfirer Training Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `actual_explosive_mass_kg` SET TAGS ('dbx_business_glossary_term' = 'Actual Explosive Mass (kg)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `actual_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Hole Count');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `airblast_overpressure_db` SET TAGS ('dbx_business_glossary_term' = 'Airblast Overpressure (dB)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Blast Approval Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_number` SET TAGS ('dbx_business_glossary_term' = 'Blast Number');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_status` SET TAGS ('dbx_business_glossary_term' = 'Blast Status');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blast_status` SET TAGS ('dbx_value_regex' = 'planned|approved|loaded|fired|post_blast_cleared|cancelled');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `blasted_rock_mass_t` SET TAGS ('dbx_business_glossary_term' = 'Blasted Rock Mass (tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `detonation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detonation Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Dilution Percentage (%)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `exclusion_zone_compliant` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Zone Compliance Flag');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `exclusion_zone_radius_m` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Zone Radius (metres)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `fragmentation_p80_mm` SET TAGS ('dbx_business_glossary_term' = 'Fragmentation P80 (mm)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `fragmentation_target_p80_mm` SET TAGS ('dbx_business_glossary_term' = 'Fragmentation Target P80 (mm)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `initiation_system_type` SET TAGS ('dbx_business_glossary_term' = 'Initiation System Type');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `initiation_system_type` SET TAGS ('dbx_value_regex' = 'electronic|non_electric|electric|shock_tube');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground_sublevel_caving|underground_longhole|underground_development');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `misfire_count` SET TAGS ('dbx_business_glossary_term' = 'Misfire Count');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `misfire_resolved` SET TAGS ('dbx_business_glossary_term' = 'Misfire Resolved Flag');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `ore_tonnes_blasted` SET TAGS ('dbx_business_glossary_term' = 'Ore Tonnes Blasted');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `peak_particle_velocity_mms` SET TAGS ('dbx_business_glossary_term' = 'Peak Particle Velocity (mm/s)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `planned_burden_m` SET TAGS ('dbx_business_glossary_term' = 'Planned Burden (metres)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `planned_explosive_mass_kg` SET TAGS ('dbx_business_glossary_term' = 'Planned Explosive Mass (kg)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `planned_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Hole Count');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `planned_hole_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Planned Hole Depth (metres)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `planned_spacing_m` SET TAGS ('dbx_business_glossary_term' = 'Planned Spacing (metres)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `powder_factor_kg_per_t` SET TAGS ('dbx_business_glossary_term' = 'Powder Factor (kg per tonne)');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `re_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Re-Entry Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ALTER COLUMN `waste_tonnes_blasted` SET TAGS ('dbx_business_glossary_term' = 'Waste Tonnes Blasted');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `material_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Movement Identifier');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `blast_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Blast ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `dispatch_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `grade_control_block_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `haul_route_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Route Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Source Block Model ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `primary_material_functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Source Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `waste_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Minutes)');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'MineStar|SCADA|manual|weighbridge|LIMS');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `destination_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Name');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Dilution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `dry_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Dry Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `estimated_grade_pct` SET TAGS ('dbx_business_glossary_term' = 'Estimated Grade Percentage');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Reconciled Flag');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'ore|waste|low_grade|overburden|ROM');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground|sub_level_caving|longwall|room_and_pillar');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `moisture_pct` SET TAGS ('dbx_business_glossary_term' = 'Moisture Percentage');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Material Movement End Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Material Movement Reference Number');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_reference_number` SET TAGS ('dbx_value_regex' = '^MM-[0-9]{4}-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Material Movement Start Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Material Movement Status');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'dispatched|in_progress|completed|cancelled|rejected');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'primary_haul|rehandle|stockpile_reclaim|ROM_feed|waste_dump');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `payload_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Payload Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `strip_ratio_contribution` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio Contribution');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `tonnes_delivered` SET TAGS ('dbx_business_glossary_term' = 'Tonnes Delivered');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `tonnes_loaded` SET TAGS ('dbx_business_glossary_term' = 'Tonnes Loaded');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'haul_truck|conveyor|rail|front_end_loader|underground_truck');
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Run of Mine (ROM) Stockpile ID');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan ID');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit / Mining Area ID');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `bulk_density_t_m3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (Tonnes per Cubic Metre)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `commissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioned Date');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `current_inventory_t` SET TAGS ('dbx_business_glossary_term' = 'Current Inventory (Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `cut_off_grade_pct` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `decommissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioned Date');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `design_capacity_t` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Dilution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `easting_m` SET TAGS ('dbx_business_glossary_term' = 'Easting Coordinate (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Metres Above Sea Level)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `environmental_permit_ref` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Reference');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `fms_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Fleet Management System (FMS) Zone Code');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `fms_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `geotechnical_zone` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Zone');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `head_grade_cu_pct` SET TAGS ('dbx_business_glossary_term' = 'Head Grade Copper (Cu) Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `head_grade_fe_pct` SET TAGS ('dbx_business_glossary_term' = 'Head Grade Iron (Fe) Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `head_grade_primary_pct` SET TAGS ('dbx_business_glossary_term' = 'Head Grade Primary Element Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `inventory_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inventory Snapshot Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `max_stack_height_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stack Height (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground|open_cut_underground|in_situ');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `moisture_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `northing_m` SET TAGS ('dbx_business_glossary_term' = 'Northing Coordinate (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `ore_recovery_pct` SET TAGS ('dbx_business_glossary_term' = 'Ore Recovery Percentage');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `pad_area_m2` SET TAGS ('dbx_business_glossary_term' = 'Pad Area (Square Metres)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `reconciliation_variance_t` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance (Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `scada_tag_code` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Identifier');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `scada_tag_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,64}$');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `scheduled_tonnes_t` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Tonnes (Production Schedule)');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_code` SET TAGS ('dbx_business_glossary_term' = 'Run of Mine (ROM) Stockpile Code');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_name` SET TAGS ('dbx_business_glossary_term' = 'Run of Mine (ROM) Stockpile Name');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_status` SET TAGS ('dbx_business_glossary_term' = 'ROM Stockpile Operational Status');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|reclaiming|full|depleted|on_hold');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_type` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Type Classification');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `stockpile_type` SET TAGS ('dbx_value_regex' = 'rom_pad|crusher_feed|blend_stockpile|low_grade|high_grade|waste');
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ALTER COLUMN `surveyed_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Surveyed Volume (Cubic Metres)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `haulage_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Haulage Cycle ID');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Bench Identifier');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Truck Operator ID');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `grade_control_block_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `haul_route_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Route Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Truck Asset ID');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Load Origin Location ID');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Material Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `tertiary_haulage_functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Road Segment ID');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `waste_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cycle_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cycle_reference` SET TAGS ('dbx_business_glossary_term' = 'Haulage Cycle Reference Number');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cycle_reference` SET TAGS ('dbx_value_regex' = '^CYC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cycle_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Haulage Cycle Status');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'completed|aborted|partial|under_review');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'minestar|manual|scada|pi_system');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `dump_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Dump Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `dump_type` SET TAGS ('dbx_business_glossary_term' = 'Dump Destination Type');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `dump_type` SET TAGS ('dbx_value_regex' = 'crusher|rom_pad|stockpile|waste_dump|tsf');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `fuel_consumption_litres` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (Litres)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `haul_empty_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Haul Empty Return Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `haul_full_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Haul Full Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `is_overloaded` SET TAGS ('dbx_business_glossary_term' = 'Overload Flag');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `is_rehandle` SET TAGS ('dbx_business_glossary_term' = 'Rehandle Flag');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `load_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Loader Pass Count');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `load_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Load Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'ore|waste|low_grade_ore|overburden|topsoil');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `nominal_payload_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Nominal Payload Capacity (Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `ore_grade_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Ore Grade');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `payload_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Payload Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `queue_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Queue Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `spot_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Spot Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ALTER COLUMN `total_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time (Seconds)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `grade_control_block_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block ID');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_model_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Cell Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Sample Batch ID');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block ID');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Model ID');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Pattern ID');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Code');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Name');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_size_x_m` SET TAGS ('dbx_business_glossary_term' = 'Block Size X Dimension (metres)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_size_y_m` SET TAGS ('dbx_business_glossary_term' = 'Block Size Y Dimension (metres)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_size_z_m` SET TAGS ('dbx_business_glossary_term' = 'Block Size Z Dimension (metres)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Status');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'active|dispatched|mined_out|on_hold|cancelled');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `block_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Block Volume (cubic metres)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `bulk_density_tm3` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (tonnes per cubic metre)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `centroid_easting_m` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Easting (metres)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `centroid_northing_m` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Northing (metres)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Ore/Waste Classification');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'ore|waste|low_grade|marginal_ore');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Estimation Confidence Level');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `cut_off_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade (Minimum Economic Grade)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `dilution_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor (Percentage)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `dispatch_destination` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Destination');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `dispatch_destination` SET TAGS ('dbx_value_regex' = 'mill_feed|rom_pad|low_grade_stockpile|waste_dump|tsf');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `dispatch_instruction_code` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction Code');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Grade Estimation Method');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'kriging|inverse_distance|nearest_neighbour|polygonal|manual');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `insitu_tonnes` SET TAGS ('dbx_business_glossary_term' = 'In-Situ Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `is_resampled` SET TAGS ('dbx_business_glossary_term' = 'Is Resampled Flag');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `mined_out_date` SET TAGS ('dbx_business_glossary_term' = 'Mined Out Date');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `mineral_domain_code` SET TAGS ('dbx_business_glossary_term' = 'Mineral Domain Code');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `primary_grade` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Grade');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `primary_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `primary_grade_unit` SET TAGS ('dbx_value_regex' = 'pct|ppm|ppb|g_per_t|kg_per_t');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate (Percentage)');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `secondary_grade` SET TAGS ('dbx_business_glossary_term' = 'Secondary Commodity Grade');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `secondary_grade_element` SET TAGS ('dbx_business_glossary_term' = 'Secondary Grade Element Symbol');
ALTER TABLE `mining_ecm`.`mine`.`grade_control_block` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report ID');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Supervisor ID');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `blasts_fired_count` SET TAGS ('dbx_business_glossary_term' = 'Blasts Fired Count');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `breakdown_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Delay Hours');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `crew_headcount` SET TAGS ('dbx_business_glossary_term' = 'Crew Headcount');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Dilution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `equipment_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Operating Hours');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `equipment_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Scheduled Hours');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `equipment_utilisation_pct` SET TAGS ('dbx_business_glossary_term' = 'Equipment Utilisation Percentage');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `handover_notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Notes');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `is_daily_rollup_complete` SET TAGS ('dbx_business_glossary_term' = 'Daily Rollup Complete Flag');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `lost_time_injury_count` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Count');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `metres_developed` SET TAGS ('dbx_business_glossary_term' = 'Metres Developed');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `metres_drilled` SET TAGS ('dbx_business_glossary_term' = 'Metres Drilled');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `metres_drilled_target` SET TAGS ('dbx_business_glossary_term' = 'Metres Drilled Target');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `mining_method` SET TAGS ('dbx_value_regex' = 'open_cut|underground_sublevel_caving|underground_longwall|underground_room_and_pillar|underground_cut_and_fill|underground_block_caving');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `ore_grade_fe_pct` SET TAGS ('dbx_business_glossary_term' = 'Ore Grade Iron (Fe) Percentage');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `ore_mined_target_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Ore Mined Target Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `ore_mined_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Ore Mined Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `planned_maintenance_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Maintenance Delay Hours');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_report_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Number');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_report_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{4}-[0-9]{2}-[0-9]{2}-[A-Z]{3}-[0-9]{3}$');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Status');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|closed|voided');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|afternoon|extended');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `significant_events_notes` SET TAGS ('dbx_business_glossary_term' = 'Significant Events Notes');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'MINESTAR|OSI_PI|CREW_REPORT|MANUAL');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `strip_ratio_actual` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio Actual');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `waste_moved_target_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Waste Moved Target Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `waste_moved_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Waste Moved Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ALTER COLUMN `weather_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Weather Delay Hours');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `waste_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump ID');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `environmental_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Audit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit / Mining Area ID');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `rehabilitation_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Provision Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `acid_rock_drainage_risk` SET TAGS ('dbx_business_glossary_term' = 'Acid Rock Drainage (ARD) Risk Classification');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `acid_rock_drainage_risk` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Closure Date');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `commissioned_date` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Commissioned Date');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `current_fill_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Current Fill Volume (Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `current_fill_volume_bcm` SET TAGS ('dbx_business_glossary_term' = 'Current Fill Volume (Bank Cubic Metres)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `design_capacity_bcm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (Bank Cubic Metres)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `design_capacity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_code` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Code');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_code` SET TAGS ('dbx_value_regex' = '^WD-[A-Z0-9]{3,10}$');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_name` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Name');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_status` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Operational Status');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|rehabilitating|decommissioned');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Type');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `dump_type` SET TAGS ('dbx_value_regex' = 'overburden|waste_rock|low_grade_stockpile|mixed|tailings_co_disposal');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Crest Elevation (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `geotechnical_classification` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Classification');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `geotechnical_classification` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `groundwater_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Groundwater Monitoring Required Flag');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `isometrix_facility_reference` SET TAGS ('dbx_business_glossary_term' = 'IsoMetrix Facility ID');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Centroid Latitude');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `leachate_management_status` SET TAGS ('dbx_business_glossary_term' = 'Leachate Management Status');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `leachate_management_status` SET TAGS ('dbx_value_regex' = 'not_required|collection_system_active|collection_system_inactive|monitoring_only');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `liner_type` SET TAGS ('dbx_business_glossary_term' = 'Liner Type');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `liner_type` SET TAGS ('dbx_value_regex' = 'none|compacted_clay|hdpe_geomembrane|composite|low_permeability_rock');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Centroid Longitude');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `max_height_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dump Height (Metres)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `mine_plan_dump_reference` SET TAGS ('dbx_business_glossary_term' = 'Mine Planning System Dump ID');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Operational Notes');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `overall_slope_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Overall Slope Angle (Degrees)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Expiry Date');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `progressive_rehab_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Progressive Rehabilitation Completed Area (Hectares)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `progressive_rehab_required` SET TAGS ('dbx_business_glossary_term' = 'Progressive Rehabilitation Required Flag');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `rehabilitation_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Bond Amount');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `rehabilitation_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `rehabilitation_bond_currency` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Bond Currency (ISO 4217)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `rehabilitation_bond_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `rehabilitation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Plan Reference');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Geotechnical Engineer');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `surface_area_ha` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Surface Area (Hectares)');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `waste_rock_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Geochemical Classification');
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ALTER COLUMN `waste_rock_classification` SET TAGS ('dbx_value_regex' = 'non_acid_forming|potentially_acid_forming|acid_forming|uncertain');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Measurement ID');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area ID');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `previous_survey_survey_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Survey ID');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor ID');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `stope_design_id` SET TAGS ('dbx_business_glossary_term' = 'Stope Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Equipment Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `waste_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `wireframe_id` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Survey Accuracy Class');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_value_regex' = 'survey_grade|engineering_grade|reconnaissance');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `bulk_density` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (t/m³)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `design_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Design Volume (m³)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `dtm_file_ref` SET TAGS ('dbx_business_glossary_term' = 'Digital Terrain Model (DTM) File Reference');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `elevation_max_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Elevation (mRL)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `elevation_min_m` SET TAGS ('dbx_business_glossary_term' = 'Minimum Elevation (mRL)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `geotechnical_flag` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Monitoring Flag');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `horizontal_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Positional Accuracy (m)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'ore|waste|rom|overburden|tailings|concentrate');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `point_cloud_file_ref` SET TAGS ('dbx_business_glossary_term' = 'Point Cloud File Reference');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `production_period` SET TAGS ('dbx_business_glossary_term' = 'Production Period');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio (Overburden to Ore Ratio)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_area_m2` SET TAGS ('dbx_business_glossary_term' = 'Survey Area (m²)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'drone_photogrammetry|lidar|total_station|gps_rtk|mms|laser_scan');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Reference Number');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'pit_floor|dump|stockpile|underground|tsf|haul_road');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `surveyed_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Surveyed Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `surveyed_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Surveyed Volume (m³)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `tonnes_change` SET TAGS ('dbx_business_glossary_term' = 'Tonnes Change');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `variance_to_design_m3` SET TAGS ('dbx_business_glossary_term' = 'Variance to Design Volume (m³)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `variance_to_design_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance to Design Percentage (%)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `vertical_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'Vertical Positional Accuracy (m)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `volume_change_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume Change (m³)');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions During Survey');
ALTER TABLE `mining_ecm`.`mine`.`survey_measurement` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_value_regex' = 'clear|overcast|rain|fog|wind|dust');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `production_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Reconciliation ID');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Geologist ID');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `stope_design_id` SET TAGS ('dbx_business_glossary_term' = 'Stope Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `actual_grade` SET TAGS ('dbx_business_glossary_term' = 'Actual Mined Grade');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `actual_metal_content` SET TAGS ('dbx_business_glossary_term' = 'Actual Metal Content');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `actual_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Actual Mined Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `assay_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Assay Sample Count');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `bench_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Bench Elevation (metres above sea level)');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `dilution_pct` SET TAGS ('dbx_business_glossary_term' = 'Dilution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `f1_factor` SET TAGS ('dbx_business_glossary_term' = 'F1 Tonnes Reconciliation Factor');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `f2_factor` SET TAGS ('dbx_business_glossary_term' = 'F2 Grade Reconciliation Factor');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `f3_factor` SET TAGS ('dbx_business_glossary_term' = 'F3 Metal Content Reconciliation Factor');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `grade_unit` SET TAGS ('dbx_value_regex' = 'pct|g_per_t|kg_per_t|ppm');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `grade_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Grade Variance Percentage');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `model_grade` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Grade');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `model_metal_content` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Metal Content');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `model_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `model_update_required` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Update Required Flag');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `ore_recovery_pct` SET TAGS ('dbx_business_glossary_term' = 'Ore Recovery Percentage');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `ore_source_code` SET TAGS ('dbx_business_glossary_term' = 'Ore Source Code');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `ore_source_type` SET TAGS ('dbx_business_glossary_term' = 'Ore Source Type');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `ore_source_type` SET TAGS ('dbx_value_regex' = 'open_cut|underground|stockpile|rom_pad|blend');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Type');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `reconciliation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `reconciliation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference Number');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_value_regex' = '^REC-[A-Z0-9]{4,}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|superseded');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'JORC Resource Classification');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'measured|indicated|inferred|proved_reserve|probable_reserve');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'geovia_gems|hexagon_mineplan|caterpillar_minestar|labware_lims|manual');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'drone_survey|total_station|gps_rtk|laser_scan|truck_payload');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `tonnes_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Tonnes Variance Percentage');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `variance_category` SET TAGS ('dbx_business_glossary_term' = 'Variance Category');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `variance_category` SET TAGS ('dbx_value_regex' = 'geological_model|dilution|ore_loss|sampling_bias|survey_error|blast_movement');
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Explanation');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` SET TAGS ('dbx_subdomain' = 'planning_design');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `plan_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Plan Scenario ID');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Life of Mine (LOM) Plan ID');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `parent_scenario_plan_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Scenario ID');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `project_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Valuation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `base_plan_scenario_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `aisc_usd_per_t` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) (USD per Tonne)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `average_ore_grade` SET TAGS ('dbx_business_glossary_term' = 'Average Ore Grade');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `commodity_price_assumption_usd` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Assumption (USD)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `commodity_price_unit` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Unit');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `exchange_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Assumption');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `exchange_rate_currency_pair` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Currency Pair');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `external_scenario_reference` SET TAGS ('dbx_business_glossary_term' = 'External Scenario Reference');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `fleet_size_constraint` SET TAGS ('dbx_business_glossary_term' = 'Fleet Size Constraint');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `irr_pct` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percentage');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `market_demand_constraint_tpa` SET TAGS ('dbx_business_glossary_term' = 'Market Demand Constraint (Tonnes Per Annum)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `npv_musd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) (Million USD)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `planned_recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Recovery Rate Percentage');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `planning_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Years');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `primary_commodity` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `processing_capacity_constraint_tpa` SET TAGS ('dbx_business_glossary_term' = 'Processing Capacity Constraint (Tonnes Per Annum)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC|NI_43_101|SAMREC|SEC_SK_1300|PERC');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Scenario Code');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Scenario Status');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|superseded|archived|rejected');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'base_case|optimistic|pessimistic|sensitivity|feasibility|expansion');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `scenario_version` SET TAGS ('dbx_business_glossary_term' = 'Scenario Version');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `sensitivity_parameter` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Parameter');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'DESWIK|HEXAGON_MINEPLAN|GEOVIA_GEMS|MANUAL|OTHER');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `strip_ratio` SET TAGS ('dbx_business_glossary_term' = 'Strip Ratio');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `total_capex_musd` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (CAPEX) (Million USD)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `total_opex_musd` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenditure (OPEX) (Million USD)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `total_ore_reserve_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Ore Reserve (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `total_waste_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Waste (Million Tonnes)');
ALTER TABLE `mining_ecm`.`mine`.`plan_scenario` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` SET TAGS ('dbx_association_edges' = 'mine.production_schedule,equipment.asset');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `equipment_schedule_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Schedule Assignment ID');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Schedule Assignment - Asset Id');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `fleet_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Fleet ID');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Schedule Assignment - Production Schedule Id');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `assignment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Rank');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `scheduled_fuel_budget_litres` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Fuel Budget');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `scheduled_maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Window');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `scheduled_operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Operating Hours');
ALTER TABLE `mining_ecm`.`mine`.`equipment_schedule_assignment` ALTER COLUMN `scheduled_utilisation_pct` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Utilisation Percentage');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` SET TAGS ('dbx_subdomain' = 'extraction_operations');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` SET TAGS ('dbx_association_edges' = 'mine.production_schedule,workforce.crew');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `schedule_crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Crew Assignment Identifier');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Planner');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Crew Assignment - Crew Id');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Crew Assignment - Production Schedule Id');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role in Schedule');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Crew Hours');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `planned_shift_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Shift Count');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Rank');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Scheduled End Date');
ALTER TABLE `mining_ecm`.`mine`.`schedule_crew_assignment` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Scheduled Start Date');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` SET TAGS ('dbx_association_edges' = 'mine.rom_stockpile,processing.processing_circuit');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `stockpile_circuit_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Circuit Feed Identifier');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Circuit Feed - Processing Circuit Id');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Circuit Feed - Rom Stockpile Id');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `blend_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Blend Ratio Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `conveyor_route_code` SET TAGS ('dbx_business_glossary_term' = 'Conveyor Route Code');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `feed_priority` SET TAGS ('dbx_business_glossary_term' = 'Feed Priority Rank');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `feed_rate_tph` SET TAGS ('dbx_business_glossary_term' = 'Feed Rate Tonnes Per Hour');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `feed_status` SET TAGS ('dbx_business_glossary_term' = 'Feed Status');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `reclaim_method` SET TAGS ('dbx_business_glossary_term' = 'Reclaim Method');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `reclaim_priority` SET TAGS ('dbx_business_glossary_term' = 'Reclaim Priority Ranking');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `reclaim_rate_t_hr` SET TAGS ('dbx_business_glossary_term' = 'Reclaim Rate (Tonnes per Hour)');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `target_feed_grade_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Feed Grade Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_circuit_feed` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` SET TAGS ('dbx_association_edges' = 'mine.rom_stockpile,product.saleable_product');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `stockpile_blend_id` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Blend Identifier');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Blend - Rom Stockpile Id');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Stockpile Blend - Saleable Product Id');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `actual_reclaim_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Actual Reclaim Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `blend_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Blend Ratio Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `blend_recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Blend Recipe Version');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `blend_status` SET TAGS ('dbx_business_glossary_term' = 'Blend Status');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Blend Effective From Date');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Blend Effective To Date');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `quality_contribution_fe_pct` SET TAGS ('dbx_business_glossary_term' = 'Iron Quality Contribution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `quality_contribution_sio2_pct` SET TAGS ('dbx_business_glossary_term' = 'Silica Quality Contribution Percentage');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `reclaim_sequence` SET TAGS ('dbx_business_glossary_term' = 'Reclaim Sequence Order');
ALTER TABLE `mining_ecm`.`mine`.`stockpile_blend` ALTER COLUMN `target_reclaim_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Target Reclaim Tonnes');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `parent_mine_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `postal_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `postal_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ALTER COLUMN `rehabilitation_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`site` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `average_ore_grade_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `mining_lease_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `ore_reserve_tonnes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `postal_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `postal_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`site` ALTER COLUMN `rehabilitation_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`haul_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`haul_route` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`haul_route` ALTER COLUMN `haul_route_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Route Identifier');
ALTER TABLE `mining_ecm`.`mine`.`haul_route` ALTER COLUMN `return_haul_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ALTER COLUMN `drill_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Pattern Identifier');
ALTER TABLE `mining_ecm`.`mine`.`drill_pattern` ALTER COLUMN `adjacent_drill_pattern_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ALTER COLUMN `mine_area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Identifier');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ALTER COLUMN `parent_mine_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ALTER COLUMN `life_of_mine_years` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ALTER COLUMN `ore_grade_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ALTER COLUMN `ore_reserve_tonnes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`mine_area` ALTER COLUMN `production_capacity_tonnes_per_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ALTER COLUMN `blast_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Pattern Identifier');
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ALTER COLUMN `adjacent_blast_pattern_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Identifier');
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ALTER COLUMN `parent_pit_or_level_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ALTER COLUMN `average_ore_grade_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ALTER COLUMN `ore_reserve_tonnes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`bench` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`bench` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`bench` ALTER COLUMN `bench_id` SET TAGS ('dbx_business_glossary_term' = 'Bench Identifier');
ALTER TABLE `mining_ecm`.`mine`.`bench` ALTER COLUMN `parent_bench_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`location` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `mining_ecm`.`mine`.`location` ALTER COLUMN `origin_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`explosive_type` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`explosive_type` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`explosive_type` ALTER COLUMN `explosive_type_id` SET TAGS ('dbx_business_glossary_term' = 'Explosive Type Identifier');
ALTER TABLE `mining_ecm`.`mine`.`explosive_type` ALTER COLUMN `parent_explosive_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`explosive_type` ALTER COLUMN `cost_per_kg` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`mine`.`access_ramp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`mine`.`access_ramp` SET TAGS ('dbx_subdomain' = 'reference_entities');
ALTER TABLE `mining_ecm`.`mine`.`access_ramp` ALTER COLUMN `access_ramp_id` SET TAGS ('dbx_business_glossary_term' = 'Access Ramp Identifier');
ALTER TABLE `mining_ecm`.`mine`.`access_ramp` ALTER COLUMN `connects_to_access_ramp_id` SET TAGS ('dbx_self_ref_fk' = 'true');
