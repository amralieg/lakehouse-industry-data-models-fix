-- Schema for Domain: geology | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:39

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`geology` COMMENT 'Owns the geological model of the orebody including lithological logging, structural mapping, ore body definitions, grade control, block models, and GIS-referenced spatial data. Provides foundational geological intelligence that drives mine planning, cut-off grade decisions, and resource-to-reserve conversion.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`orebody` (
    `orebody_id` BIGINT COMMENT 'Unique identifier for the orebody or mineralised zone within the mining tenement portfolio. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Orebodies are defined by primary commodity (iron ore, copper, lithium). Links to standardized commodity master for pricing indices, regulatory classification, JORC reporting, and market analysis. Repl',
    `competent_person_id` BIGINT COMMENT 'Reference to the qualified competent person responsible for the geological characterisation and resource estimation of this orebody, as required by JORC/NI 43-101.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Orebodies are fundamental cost tracking units in mining operations. Each orebody accumulates exploration, development, and production costs through its lifecycle. Essential for AISC reporting, reserve',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Orebodies are profit-generating assets requiring P&L tracking for management reporting and IFRS segment disclosure. Mining companies report financial performance by orebody/mine for investor relations',
    `site_id` BIGINT COMMENT 'Reference to the mine site or operational location where this orebody is being or will be extracted.',
    `tenement_id` BIGINT COMMENT 'Reference to the mining tenement or lease within which this orebody is located. Links to land and tenements domain.',
    `alteration_type` STRING COMMENT 'Dominant hydrothermal or weathering alteration assemblage associated with mineralisation. Used as a vectoring tool in exploration and grade control.',
    `average_grade` DECIMAL(18,2) COMMENT 'Mean grade of the primary commodity across the entire orebody resource. Key metric for economic evaluation and processing plant design.',
    `average_grade_unit` STRING COMMENT 'Unit of measure for the average grade. Aligns with commodity type and industry reporting standards.. Valid values are `percent|ppm|gpt|opt`',
    `centroid_elevation_m` DECIMAL(18,2) COMMENT 'Elevation above sea level of the orebody centroid in meters. Used for mine planning, haulage design, and hydrological modeling.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the orebody centroid in decimal degrees. Enables spatial analysis and GIS integration.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the orebody centroid in decimal degrees. Enables spatial analysis and GIS integration.',
    `contained_metal_kt` DECIMAL(18,2) COMMENT 'Estimated quantity of contained metal or commodity in the orebody in thousand tonnes. Calculated as tonnage multiplied by average grade.',
    `coordinate_system` STRING COMMENT 'Spatial reference system or coordinate system used for orebody spatial data (e.g., WGS84, local mine grid). Ensures spatial data interoperability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this orebody record was first created in the system. Supports audit trail and data lineage tracking.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold used to define ore versus waste for this orebody. Critical parameter for resource-to-reserve conversion and mine planning.',
    `cutoff_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade (e.g., percent for iron ore, grams per tonne for gold). Ensures correct interpretation of grade thresholds.. Valid values are `percent|ppm|gpt|opt`',
    `depletion_date` DATE COMMENT 'Actual or forecast date when economically recoverable reserves in this orebody will be exhausted. Critical for mine closure planning.',
    `deposit_style` STRING COMMENT 'Geological classification of the deposit type. Defines the genetic model and controls exploration, mining method selection, and metallurgical processing approach. [ENUM-REF-CANDIDATE: porphyry|vms|bif|sedimentary|epithermal|skarn|iocg|laterite|pegmatite|orogenic|carlin — 11 candidates stripped; promote to reference product]',
    `discovery_date` DATE COMMENT 'Date when the orebody was first discovered or identified through exploration activities. Key milestone for resource maturity tracking.',
    `environmental_sensitivity` STRING COMMENT 'Assessment of environmental sensitivity and regulatory constraints affecting this orebody. Influences permitting, mine design, and closure planning.. Valid values are `low|moderate|high|critical`',
    `first_production_date` DATE COMMENT 'Date when commercial ore extraction from this orebody commenced. Marks transition from development to production phase.',
    `geological_confidence` STRING COMMENT 'Highest level of geological confidence classification achieved for this orebody per JORC/NI 43-101 standards. Reflects drill density and estimation quality.. Valid values are `inferred|indicated|measured`',
    `geological_model_date` DATE COMMENT 'Date when the current geological model version was finalized and approved. Supports audit trail for resource and reserve reporting.',
    `geological_model_version` STRING COMMENT 'Version identifier of the current geological block model from which this orebody definition is derived. Tracks model updates and resource estimate revisions.',
    `geotechnical_domain` STRING COMMENT 'Geotechnical classification or domain assignment for the orebody based on rock mass characteristics. Informs slope design, ground support, and mining method.',
    `host_lithology` STRING COMMENT 'Primary rock type or lithological unit hosting the mineralisation. Influences geotechnical properties, mining method, and processing characteristics.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this orebody record is currently active in operational systems. Inactive records represent historical or superseded orebody definitions.',
    `metallurgical_domain` STRING COMMENT 'Metallurgical domain classification based on processing characteristics and recovery performance. Drives processing plant design and recovery assumptions.',
    `mineralisation_type` STRING COMMENT 'Style of mineralisation within the orebody, describing how the valuable minerals are distributed within the host rock. Influences mining selectivity and dilution. [ENUM-REF-CANDIDATE: disseminated|vein|massive_sulphide|replacement|stockwork|breccia|stratiform|alluvial — 8 candidates stripped; promote to reference product]',
    `mining_method` STRING COMMENT 'Planned or current mining extraction method for this orebody. Drives mine design, equipment selection, and operating cost assumptions. [ENUM-REF-CANDIDATE: open_pit|underground|slc|block_cave|longwall|room_and_pillar|open_stope|cut_and_fill|mixed — 9 candidates stripped; promote to reference product]',
    `orebody_code` STRING COMMENT 'Business identifier code for the orebody used across geological modeling, mine planning, and resource reporting systems. Externally known reference code.. Valid values are `^[A-Z0-9]{3,20}$`',
    `orebody_name` STRING COMMENT 'Human-readable name of the orebody or mineralised zone, typically reflecting geographic location, discovery history, or geological characteristics.',
    `orebody_status` STRING COMMENT 'Current lifecycle status of the orebody from exploration through to depletion. Drives investment decisions and operational planning. [ENUM-REF-CANDIDATE: exploration|resource_defined|reserve_declared|in_production|depleted|suspended|closed — 7 candidates stripped; promote to reference product]',
    `oxidation_state` STRING COMMENT 'Degree of weathering and oxidation of the orebody. Critical for metallurgical processing route selection (oxide vs sulphide processing).. Valid values are `oxide|transitional|fresh_sulphide|mixed`',
    `reserve_status` STRING COMMENT 'Highest reserve classification achieved for this orebody. Indicates whether economic extraction has been demonstrated through feasibility studies.. Valid values are `no_reserve|probable|proved|mixed`',
    `spatial_extent_area_sqm` DECIMAL(18,2) COMMENT 'Horizontal surface area extent of the orebody footprint in square meters. Derived from GIS spatial analysis of geological model boundaries.',
    `structural_control` STRING COMMENT 'Description of the structural geological features (faults, folds, shear zones) that control the geometry and extent of mineralisation. Informs geological modeling and mine design.',
    `tonnage_estimate_mt` DECIMAL(18,2) COMMENT 'Estimated total tonnage of mineralised material in the orebody in million tonnes. Represents the scale of the resource and drives LOM planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this orebody record was last modified. Tracks data currency and supports change management processes.',
    `vertical_extent_m` DECIMAL(18,2) COMMENT 'Maximum vertical thickness or depth extent of the orebody from top to bottom in meters. Influences mining method selection and pit depth or underground level design.',
    CONSTRAINT pk_orebody PRIMARY KEY(`orebody_id`)
) COMMENT 'Master definition of each discrete orebody or mineralised zone within the mining tenement portfolio. Captures geological characterisation including commodity type, deposit style (porphyry, VMS, BIF, sedimentary), structural controls, mineralisation type, spatial extent, and discovery date. Serves as the foundational anchor entity linking all geological modelling, resource estimation, grade control, and mine planning activities. Each orebody record also owns its child geological domains (statistically homogeneous estimation zones). Sourced from Geovia GEMS and Hexagon MinePlan geological models.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`geological_unit` (
    `geological_unit_id` BIGINT COMMENT 'Unique identifier for the geological unit. Primary key for the geological unit reference catalogue.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Geological units with ore-bearing potential reference specific commodities for resource estimation and geological domain definition. Essential for block model estimation and resource categorization. R',
    `alteration_type` STRING COMMENT 'Type of hydrothermal or metamorphic alteration affecting the unit (e.g., potassic, phyllic, argillic, propylitic, silicification, chloritization). Nullable for unaltered units. Key indicator for ore body proximity and grade control.',
    `approval_date` DATE COMMENT 'Date on which the geological unit definition was formally approved for use in the enterprise geological model and resource estimation.',
    `approved_by` STRING COMMENT 'Name or identifier of the competent person or senior geologist who approved the geological unit definition. Ensures accountability and compliance with JORC/NI 43-101 competent person requirements.',
    `colour_code_hex` STRING COMMENT 'Hexadecimal colour code used for visualisation of the geological unit in cross-sections, block models, and GIS maps. Ensures consistent colour representation across all geological visualisations.. Valid values are `^#[0-9A-Fa-f]{6}$`',
    `colour_code_rgb` STRING COMMENT 'RGB colour code (comma-separated R,G,B values 0-255) for the geological unit. Alternative colour representation for systems that do not support hexadecimal codes.. Valid values are `^d{1,3},d{1,3},d{1,3}$`',
    `density_g_cm3` DECIMAL(18,2) COMMENT 'Average bulk density of the geological unit in grams per cubic centimetre. Used for tonnage calculations in resource estimation and block modelling.',
    `depositional_environment` STRING COMMENT 'Geological environment in which the unit was originally deposited or formed (e.g., marine, fluvial, volcanic, intrusive, metamorphic). Provides genetic context for the unit.',
    `effective_from_date` DATE COMMENT 'Date from which this geological unit definition became effective in the enterprise geological model. Supports temporal versioning of geological interpretations.',
    `effective_to_date` DATE COMMENT 'Date until which this geological unit definition was effective. Nullable for currently active units. Supports temporal versioning and historical analysis of geological model changes.',
    `geological_age` STRING COMMENT 'Geological age or epoch of the unit (e.g., Proterozoic, Archean, Permian, Jurassic). Provides temporal context for the formation of the unit and aids in regional correlation.',
    `geological_unit_status` STRING COMMENT 'Current lifecycle status of the geological unit in the enterprise geological model. Active units are in current use; deprecated units have been superseded by revised geological interpretations.. Valid values are `active|inactive|deprecated|under_review`',
    `geotechnical_domain` STRING COMMENT 'Geotechnical domain code or name to which this geological unit is assigned. Links geological units to rock mass strength, stability, and slope design parameters.',
    `hardness_classification` STRING COMMENT 'Relative hardness classification of the geological unit. Influences drilling rates, blasting design, and comminution energy requirements in mineral processing.. Valid values are `soft|medium|hard|very_hard`',
    `lithology_description` STRING COMMENT 'Detailed textual description of the rock type, texture, grain size, colour, and primary mineralogy of the geological unit. Used by geologists for consistent logging and interpretation.',
    `notes` STRING COMMENT 'Free-text field for additional geological observations, interpretation notes, or special considerations related to the unit. Captures contextual information not covered by structured fields.',
    `ore_bearing_flag` BOOLEAN COMMENT 'Boolean indicator of whether the geological unit is known to host economic mineralisation. True if the unit is part of the ore body definition; false if it is waste rock or gangue.',
    `parent_formation` STRING COMMENT 'Name of the parent geological formation or group to which this unit belongs. Establishes hierarchical stratigraphic relationships (e.g., a member within a formation, a sub-unit within a larger intrusive complex).',
    `primary_mineralogy` STRING COMMENT 'Comma-separated list of the dominant minerals present in the geological unit (e.g., quartz, feldspar, biotite, magnetite, hematite, chalcopyrite). Critical for understanding ore-forming processes and metallurgical behaviour.',
    `processing_domain` STRING COMMENT 'Mineral processing domain or metallurgical type to which this geological unit is assigned (e.g., oxide, transitional, sulphide, high-grade, low-grade). Determines processing route and recovery method.',
    `recovery_rate_percent` DECIMAL(18,2) COMMENT 'Typical metallurgical recovery rate (percentage of valuable mineral extracted) for ore from this geological unit. Used in resource-to-reserve conversion and economic modelling. Nullable for non-ore units.',
    `source_system` STRING COMMENT 'Name of the source system from which the geological unit definition was extracted (e.g., Geovia GEMS, Hexagon MinePlan, Deswik). Provides data lineage and traceability.',
    `structural_setting` STRING COMMENT 'Description of the structural geological context of the unit (e.g., footwall, hanging wall, fault zone, fold limb, shear zone). Critical for understanding ore body geometry and mining method selection.',
    `typical_grade_range` STRING COMMENT 'Typical range of metal grades observed in this geological unit (e.g., 0.5-1.2% Cu, 55-62% Fe). Provides context for grade control and cut-off grade decisions. Nullable for non-ore units.',
    `unit_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the geological unit across all mine sites. Used consistently in drillhole logging, block model coding, and grade control. Sourced from Geovia GEMS formation tables.. Valid values are `^[A-Z0-9]{2,10}$`',
    `unit_name` STRING COMMENT 'Full formal name of the geological unit (e.g., lithological formation, stratigraphic member, intrusive phase, alteration assemblage, weathering horizon). Human-readable identifier used in geological reports and cross-section interpretation.',
    `unit_type` STRING COMMENT 'Classification of the geological unit by its primary geological nature: lithological (rock type), stratigraphic (formation/member), structural (fault/fold zone), alteration (hydrothermal/metamorphic assemblage), weathering (oxidation/supergene horizon), or intrusive (igneous phase).. Valid values are `lithological|stratigraphic|structural|alteration|weathering|intrusive`',
    `weathering_state` STRING COMMENT 'Degree of weathering or oxidation of the geological unit. Influences geotechnical properties, ore recovery rates, and processing methods (oxide vs. sulphide ore).. Valid values are `fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil`',
    CONSTRAINT pk_geological_unit PRIMARY KEY(`geological_unit_id`)
) COMMENT 'Reference catalogue of all named geological units (lithological formations, stratigraphic members, intrusive phases, alteration assemblages, weathering horizons) recognised across the mines geological model. Defines the formal lithostratigraphic, structural, and alteration classification scheme used consistently in drillhole logging, cross-section interpretation, block model coding, and grade control. Each unit has a unique code, full name, parent formation, geological age, typical mineralogy, and colour code for visualisation. Underpins consistent geological coding enterprise-wide. Sourced from Geovia GEMS formation tables.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`production_drillhole` (
    `production_drillhole_id` BIGINT COMMENT 'Unique identifier for the production drillhole record. Primary key for the production drillhole master register.',
    `capital_project_id` BIGINT COMMENT 'Reference to the mining project or tenement under which this drillhole was executed.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Grade control drilling is a direct mining operational cost allocated to cost centres for unit cost calculation and AISC reporting. Mining operations track drilling costs per cost centre for budget var',
    `drill_hole_id` BIGINT COMMENT 'Business identifier for the drillhole, typically a site-specific alphanumeric code used in geological logs, assay reports, and JORC disclosures. This is the externally-known unique code for the hole.',
    `drill_program_id` BIGINT COMMENT 'Reference to the exploration or grade control drill program under which this hole was planned and executed.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Production drillholes must reference the specific drill rig asset for equipment utilization tracking, maintenance correlation with hole quality metrics, and operational planning. Replaces unlinked rig',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Grade control and production drilling require tracking which geologist logged the hole for accountability, QAQC audits, competency verification, and JORC compliance. Real-world mining operations link ',
    `laboratory_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory_sample. Business justification: Production drillholes generate samples sent to laboratory for grade control assay. Links drilling location and depth to laboratory analysis for spatial grade distribution and mining reconciliation. Es',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Production drillholes target specific orebodies for grade control and resource definition. Currently production_drillhole has site_id but no orebody_id. Adding orebody_id FK enables direct linkage of ',
    `site_id` BIGINT COMMENT 'Reference to the mine site where the drillhole is located.',
    `azimuth` DECIMAL(18,2) COMMENT 'Planned azimuth (bearing) of the drillhole at collar, measured in degrees from 0 to 360, where 0/360 is north, 90 is east, 180 is south, and 270 is west. Used to define hole trajectory.',
    `collar_easting` DECIMAL(18,2) COMMENT 'Easting coordinate of the drillhole collar (surface location) in the site coordinate reference system, typically in meters. Used for spatial positioning in GIS and geological modeling systems.',
    `collar_northing` DECIMAL(18,2) COMMENT 'Northing coordinate of the drillhole collar (surface location) in the site coordinate reference system, typically in meters. Used for spatial positioning in GIS and geological modeling systems.',
    `collar_rl` DECIMAL(18,2) COMMENT 'Reduced Level (elevation) of the drillhole collar relative to site datum, typically in meters above mean sea level. Critical for accurate 3D geological modeling and resource estimation.',
    `comments` STRING COMMENT 'Free-text field for recording operational notes, drilling issues, geological observations, or other relevant information about the drillhole. Used for quality control and historical reference.',
    `completion_date` DATE COMMENT 'Date when drilling operations were completed or abandoned. Used for program scheduling, performance tracking, and cost allocation.',
    `coordinate_system` STRING COMMENT 'Coordinate reference system (CRS) or projection used for collar coordinates. Examples: MGA94 Zone 50, WGS84 UTM Zone 51S, local mine grid. Critical for spatial data integration.',
    `core_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of the drill core or bit size in millimeters. Common sizes include HQ (63.5mm), NQ (47.6mm), PQ (85mm) for diamond drilling, or bit diameter for RC/RAB drilling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drillhole record was first created in the system. Used for data lineage and audit trail.',
    `datum` STRING COMMENT 'Vertical datum used for collar RL (elevation). Examples: AHD (Australian Height Datum), MSL (Mean Sea Level), site-specific datum. Critical for accurate 3D modeling.',
    `dip` DECIMAL(18,2) COMMENT 'Planned dip (inclination) of the drillhole at collar, measured in degrees from -90 (vertically down) to +90 (vertically up). Negative values indicate downward drilling. Used to define hole trajectory.',
    `driller_name` STRING COMMENT 'Name of the lead driller or drilling supervisor responsible for executing the drillhole. Used for quality control and performance tracking.',
    `drilling_contractor` STRING COMMENT 'Name of the drilling contractor company that executed the drillhole. Used for quality control, performance tracking, and contractor management.',
    `hole_purpose` STRING COMMENT 'Primary purpose of the drillhole: Exploration (greenfield discovery), Resource Definition (resource estimation), Grade Control (short-term mine planning), Geotechnical (rock mechanics), Hydrogeological (water management), or Condemnation (infrastructure siting).. Valid values are `Exploration|Resource Definition|Grade Control|Geotechnical|Hydrogeological|Condemnation`',
    `hole_status` STRING COMMENT 'Current lifecycle status of the drillhole: Planned (scheduled but not started), In Progress (drilling underway), Completed (drilling finished), Abandoned (terminated early), Suspended (paused), Logged (geological logging complete), Assayed (laboratory results received). [ENUM-REF-CANDIDATE: Planned|In Progress|Completed|Abandoned|Suspended|Logged|Assayed — 7 candidates stripped; promote to reference product]',
    `hole_type` STRING COMMENT 'Type of drilling method used: RC (Reverse Circulation), Diamond (core drilling), RAB (Rotary Air Blast), AC (Air Core), Rotary, or Percussion.. Valid values are `RC|Diamond|RAB|AC|Rotary|Percussion`',
    `is_assayed` BOOLEAN COMMENT 'Boolean flag indicating whether samples from this drillhole have been submitted to the laboratory and assay results received. True if assayed, False if not yet assayed.',
    `is_surveyed` BOOLEAN COMMENT 'Boolean flag indicating whether downhole survey measurements have been completed to determine actual hole trajectory. True if surveyed, False if not yet surveyed.',
    `jorc_category` STRING COMMENT 'JORC resource classification category that this drillhole contributes to: Measured (highest confidence), Indicated (moderate confidence), Inferred (lowest confidence), Exploration (pre-resource), or Non-JORC (not used in resource estimation).. Valid values are `Measured|Indicated|Inferred|Exploration|Non-JORC`',
    `logged_date` DATE COMMENT 'Date when geological logging of the drillhole was completed. Represents when lithological, structural, and mineralisation observations were recorded.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this drillhole record was last modified. Used for data lineage, audit trail, and change tracking.',
    `planned_depth` DECIMAL(18,2) COMMENT 'Originally planned depth for the drillhole in meters. Used to compare against actual total depth for program performance tracking.',
    `recovery_percent` DECIMAL(18,2) COMMENT 'Average core recovery percentage for the drillhole, calculated as (recovered core length / drilled length) × 100. Critical quality indicator for diamond drilling and resource confidence classification.',
    `sample_interval_m` DECIMAL(18,2) COMMENT 'Standard sampling interval length in meters used for this drillhole. Typical intervals are 1m for grade control, 2m for resource drilling, or variable for geological contacts.',
    `start_date` DATE COMMENT 'Date when drilling operations commenced for this hole. Used for program scheduling and performance tracking.',
    `survey_method` STRING COMMENT 'Method used to survey the drillhole trajectory (azimuth and dip at depth intervals). Common methods include Gyroscopic, Magnetic, Electronic Multi-Shot, Single Shot, Optical, or Downhole Camera.. Valid values are `Gyroscopic|Magnetic|Electronic Multi-Shot|Single Shot|Optical|Downhole Camera`',
    `total_depth` DECIMAL(18,2) COMMENT 'Total depth drilled from collar, measured in meters along the hole trajectory. Represents the final depth achieved before completion or abandonment.',
    CONSTRAINT pk_production_drillhole PRIMARY KEY(`production_drillhole_id`)
) COMMENT 'Master register of all drillholes (exploration, resource definition, grade control, geotechnical, and hydrogeological) across all projects and mine sites. Records collar location (easting, northing, RL), azimuth, dip, total depth, hole type (RC, diamond, RAB, AC), drilling contractor, rig identifier, purpose, status, and JORC reporting category. The SSOT for drillhole identity — geology domain owns the master record; exploration domain references via FK for program planning. Integrates with Geovia GEMS and LabWare LIMS for assay linkage.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`production_drillhole_survey` (
    `production_drillhole_survey_id` BIGINT COMMENT 'Unique identifier for the drillhole survey record. Primary key for the production drillhole survey entity.',
    `drill_hole_id` BIGINT COMMENT 'Foreign key reference to the parent drillhole for which this survey record was captured. Links this survey measurement to the specific drillhole being surveyed.',
    `production_drillhole_id` BIGINT COMMENT 'Foreign key linking to geology.production_drillhole. Business justification: production_drillhole_survey records directional survey measurements for a specific production drillhole. Currently only links to exploration.drill_hole, but the survey belongs to the production_drillh',
    `survey_run_id` BIGINT COMMENT 'Identifier for the survey run or batch in which this measurement was captured. Multiple survey points may be captured in a single survey run down the hole.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Downhole survey quality and QAQC require tracking surveyor identity for competency verification, audit trails, and accountability. Survey accuracy directly impacts resource estimation and mine design,',
    `azimuth_degrees` DECIMAL(18,2) COMMENT 'Horizontal direction of the drillhole at this survey point, measured in degrees clockwise from true north (0-360). Used to calculate the 3D trajectory of the hole.',
    `comments` STRING COMMENT 'Free-text field for surveyor notes, observations, or explanations regarding this survey measurement. May include information about survey conditions, instrument issues, or data quality concerns.',
    `coordinate_system` STRING COMMENT 'Name or code of the coordinate reference system (CRS) used for the calculated spatial coordinates (e.g., MGA94 Zone 50, WGS84 UTM Zone 31N). Critical for spatial data integration and GIS compatibility.',
    `correction_applied_flag` BOOLEAN COMMENT 'Boolean indicator of whether magnetic declination, temperature, or other correction factors have been applied to the raw survey measurements. True indicates corrected data, false indicates raw uncorrected data.',
    `correction_factor` DECIMAL(18,2) COMMENT 'Numerical correction factor applied to the raw survey measurements to account for magnetic declination, instrument drift, or environmental interference. Null if no correction was applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey record was first created in the Geovia GEMS system. Used for data lineage and audit trail purposes.',
    `depth_metres` DECIMAL(18,2) COMMENT 'Measured depth down the drillhole from the collar at which this survey reading was taken, expressed in metres. Critical for spatial positioning of all downhole data.',
    `dip_degrees` DECIMAL(18,2) COMMENT 'Vertical inclination of the drillhole at this survey point, measured in degrees from horizontal. Negative values indicate downward inclination, positive values indicate upward inclination. Typically ranges from -90 (vertical down) to +90 (vertical up).',
    `easting_coordinate` DECIMAL(18,2) COMMENT 'Calculated easting (X) coordinate of this survey point in the mine coordinate system, derived from collar position and survey trajectory. Used for 3D spatial positioning in GIS and block models.',
    `elevation_rl` DECIMAL(18,2) COMMENT 'Calculated elevation (Z) coordinate of this survey point relative to a defined datum, expressed as Reduced Level (RL) in metres. Used for 3D spatial positioning in GIS and block models.',
    `gravity_field_strength` DECIMAL(18,2) COMMENT 'Measured gravitational field strength at this survey point, expressed in g-units. Used by gyroscopic instruments for orientation reference.',
    `magnetic_dip_angle` DECIMAL(18,2) COMMENT 'Angle of the local magnetic field relative to horizontal, measured in degrees. Used for magnetic survey correction and quality validation.',
    `magnetic_field_strength` DECIMAL(18,2) COMMENT 'Measured magnetic field strength at this survey point, expressed in nanoTesla (nT). Used to assess potential magnetic interference that could affect survey accuracy.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this survey record was last modified or updated in the Geovia GEMS system. Used for data lineage and change tracking.',
    `northing_coordinate` DECIMAL(18,2) COMMENT 'Calculated northing (Y) coordinate of this survey point in the mine coordinate system, derived from collar position and survey trajectory. Used for 3D spatial positioning in GIS and block models.',
    `qaqc_status` STRING COMMENT 'Current status of quality assurance and quality control validation for this survey record. Indicates whether the data has been reviewed and approved for use in geological modeling.. Valid values are `pending|passed|failed|under_review`',
    `survey_date` DATE COMMENT 'Date on which this downhole survey measurement was captured. Used for temporal tracking and correlation with drilling progress.',
    `survey_instrument` STRING COMMENT 'Specific make and model of the survey instrument used to capture this reading (e.g., Reflex EZ-TRAC, Gyrodata MGTS). Important for quality assurance and data validation.',
    `survey_method` STRING COMMENT 'Type of survey instrument or technique used to capture this directional measurement. Determines the accuracy and reliability of the survey data.. Valid values are `gyroscopic|magnetic|electronic_multi_shot|single_shot|north_seeking_gyro|acid_bottle`',
    `survey_quality_code` STRING COMMENT 'Quality assessment classification for this survey measurement based on instrument performance, environmental conditions, and validation checks. Determines whether the survey data is suitable for resource estimation.. Valid values are `excellent|good|acceptable|poor|rejected`',
    `survey_sequence_number` STRING COMMENT 'Sequential order number of this survey measurement within the drillhole. Used to order survey points from collar to end-of-hole.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Downhole temperature at this survey point, measured in degrees Celsius. High temperatures can affect instrument accuracy and require correction factors.',
    CONSTRAINT pk_production_drillhole_survey PRIMARY KEY(`production_drillhole_survey_id`)
) COMMENT 'Downhole directional survey records for each drillhole capturing depth, azimuth, and dip measurements at regular intervals to define the actual 3D trajectory of the hole. Essential for accurate spatial positioning of all downhole data (assays, lithology, geotechnics) and for de-surveying collar coordinates into 3D space. Sourced from gyroscopic and magnetic survey instruments logged into Geovia GEMS.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`lithology_log` (
    `lithology_log_id` BIGINT COMMENT 'Unique identifier for the lithological logging record. Primary key for the lithology log entity.',
    `drill_hole_id` BIGINT COMMENT 'Reference to the drill hole in which this lithological observation was recorded. Links this log entry to the parent drill hole entity.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Lithology log intervals are assigned to geological domains for resource estimation. Currently lithology_log stores domain_code as a STRING; this should be normalized to FK to geological_domain.geologi',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Lithology logs reference standardized geological units from the geological_unit reference catalog. Currently lithology_log stores geological_unit as a STRING; this should be normalized to FK to geolog',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Geological logging is a regulated activity requiring competent person sign-off for JORC/NI 43-101 compliance. Linking to employee enables competency verification, training currency checks, and audit t',
    `alteration_intensity` STRING COMMENT 'Degree or intensity of alteration affecting the rock unit. Ranges from none to pervasive and influences rock competence and processing behavior.. Valid values are `none|weak|moderate|strong|pervasive`',
    `alteration_type` STRING COMMENT 'Type of hydrothermal or weathering alteration affecting the rock unit (e.g., sericitic, chloritic, argillic, propylitic). Important for understanding ore genesis and processing characteristics.',
    `colour` STRING COMMENT 'Observed colour of the rock unit. Provides visual identification characteristics and may correlate with mineralogy or alteration.',
    `comments` STRING COMMENT 'Additional free-text comments or observations recorded by the logging geologist. Captures contextual information that does not fit structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lithology log record was first created in the system. Provides audit trail for data governance and regulatory compliance.',
    `data_source` STRING COMMENT 'Source system or database from which this lithological log record originated (e.g., Geovia GEMS, field logging tablet). Provides data lineage for integration and reconciliation.',
    `grain_size` STRING COMMENT 'Average grain size of the rock matrix, classified according to standard grain size scales. Influences rock strength and processing characteristics.. Valid values are `very_fine|fine|medium|coarse|very_coarse`',
    `hardness` STRING COMMENT 'Relative hardness of the rock unit assessed by field tests. Provides indication of rock competence and drilling characteristics.. Valid values are `very_soft|soft|medium|hard|very_hard`',
    `interval_from_depth_m` DECIMAL(18,2) COMMENT 'Starting depth of the logged interval measured in metres from the drill hole collar. Defines the top boundary of the lithological unit being described.',
    `interval_length_m` DECIMAL(18,2) COMMENT 'Length of the logged interval in metres, calculated as the difference between to_depth and from_depth. Represents the thickness of the lithological unit.',
    `interval_to_depth_m` DECIMAL(18,2) COMMENT 'Ending depth of the logged interval measured in metres from the drill hole collar. Defines the bottom boundary of the lithological unit being described.',
    `lithology_code` STRING COMMENT 'Detailed lithological classification code representing the specific lithological unit or formation. More granular than rock_type_code and aligned with the geological model nomenclature.',
    `lithology_description` STRING COMMENT 'Comprehensive free-text description of the lithological characteristics including texture, structure, mineralogy, alteration, weathering, and any other relevant geological observations made by the logging geologist.',
    `logging_date` DATE COMMENT 'Date on which the lithological logging was performed. Important for data provenance and temporal tracking of geological interpretation evolution.',
    `logging_method` STRING COMMENT 'Method used to perform the lithological logging (e.g., visual inspection, digital logging, photographic logging). Affects data quality and consistency.. Valid values are `visual|digital|photographic`',
    `mineralisation_type` STRING COMMENT 'Style or morphology of mineralisation observed in the interval. Critical for understanding ore body geometry and grade distribution.. Valid values are `none|disseminated|vein|massive|stockwork|breccia`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lithology log record was last modified. Tracks data currency and supports change management processes.',
    `oxidation_state` STRING COMMENT 'Oxidation state of the rock unit indicating the degree of supergene alteration. Critical for metallurgical processing route selection and resource classification.. Valid values are `oxide|transitional|fresh_sulphide`',
    `primary_mineral` STRING COMMENT 'Dominant mineral species observed in the interval. Represents the most abundant mineral constituent of the rock unit.',
    `qaqc_comments` STRING COMMENT 'Comments or notes from the quality control review process. Documents any issues, corrections, or validation decisions made during QAQC review.',
    `qaqc_status` STRING COMMENT 'Quality control status of the lithological log entry indicating whether it has been validated, requires review, or has been rejected. Critical for data governance and compliance with JORC reporting standards.. Valid values are `pending|validated|rejected|requires_review`',
    `recovery_percent` DECIMAL(18,2) COMMENT 'Percentage of core recovered from the drilled interval. High recovery indicates competent rock; low recovery may indicate fractured, weathered, or weak zones. Critical quality control metric.',
    `rock_type_code` STRING COMMENT 'Standardized code representing the primary rock type observed in this interval (e.g., GRAN for granite, BAS for basalt, SEDS for sedimentary). Used for geological classification and modeling.',
    `rock_type_description` STRING COMMENT 'Detailed textual description of the rock type including lithological characteristics, composition, and geological interpretation. Provides full context beyond the standardized code.',
    `rqd_percent` DECIMAL(18,2) COMMENT 'Rock Quality Designation expressed as percentage of intact core pieces greater than 10cm in length. Standard geotechnical parameter for rock mass quality assessment.',
    `secondary_mineral` STRING COMMENT 'Second most abundant mineral species observed in the interval. Provides additional mineralogical context for geological interpretation.',
    `structure` STRING COMMENT 'Structural features observed in the interval including bedding, foliation, jointing, veining, or other geological structures. Important for geotechnical and structural geological interpretation.',
    `sulphide_percent` DECIMAL(18,2) COMMENT 'Visual estimate of sulphide mineral content as percentage of the interval. Important for ore grade estimation and metallurgical characterisation.',
    `texture` STRING COMMENT 'Textural characteristics of the rock including fabric, grain relationships, and structural features (e.g., porphyritic, aphanitic, foliated, massive).',
    `vein_type` STRING COMMENT 'Description of vein characteristics including composition, orientation, and morphology (e.g., quartz vein, calcite vein, tension gash). Relevant for structural and mineralisation interpretation.',
    `veining_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of the interval occupied by veins or veinlets. Important for understanding structural controls on mineralisation and rock mass characteristics.',
    `weathering_degree` STRING COMMENT 'Extent of weathering affecting the rock unit, classified according to standard weathering scales. Critical for geotechnical assessment and mine planning.. Valid values are `fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil`',
    CONSTRAINT pk_lithology_log PRIMARY KEY(`lithology_log_id`)
) COMMENT 'Downhole lithological logging records capturing rock type, mineralogy, alteration, texture, colour, grain size, and structural observations at depth intervals along each drillhole. Represents the primary geological description of the subsurface and forms the basis for geological unit interpretation and 3D geological modelling. Logged by geologists in the field and entered into Geovia GEMS. Includes QAQC flags and logging geologist identifier.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`structural_measurement` (
    `structural_measurement_id` BIGINT COMMENT 'Unique identifier for the structural measurement record. Primary key.',
    `drill_hole_id` BIGINT COMMENT 'Reference to the drill hole from which this structural measurement was captured.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Structural measurements require geologist accountability for JORC/NI 43-101 compliance and geotechnical data quality audits. Links enable competency verification for structural geology interpretation ',
    `alpha_angle` DECIMAL(18,2) COMMENT 'The alpha angle representing the orientation of the structural feature relative to the drill hole axis, used in oriented core analysis.',
    `alteration_type` STRING COMMENT 'Type of alteration associated with the structural feature (e.g., silicification, chloritization, sericitization).',
    `beta_angle` DECIMAL(18,2) COMMENT 'The beta angle representing the orientation of the structural feature relative to the drill hole axis, used in oriented core analysis.',
    `comments` STRING COMMENT 'Additional comments or notes about the structural measurement, including any anomalies or special observations.',
    `coordinate_system` STRING COMMENT 'The spatial reference system used for the coordinate data (e.g., MGA94 Zone 50, WGS84 UTM Zone 51S).',
    `data_classification` STRING COMMENT 'The classification level of this structural measurement data for information security and access control purposes.. Valid values are `internal|confidential`',
    `dip` DECIMAL(18,2) COMMENT 'The angle of inclination of the structural feature measured downward from the horizontal plane, in degrees (0-90).',
    `dip_direction` DECIMAL(18,2) COMMENT 'The azimuth direction in which the structural feature dips, measured in degrees from north (0-360).',
    `easting` DECIMAL(18,2) COMMENT 'The easting coordinate of the measurement location in the project coordinate system, used for GIS-referenced spatial data.',
    `elevation` DECIMAL(18,2) COMMENT 'The elevation of the measurement location in meters above mean sea level.',
    `feature_description` STRING COMMENT 'Detailed textual description of the structural feature including characteristics such as thickness, infill material, surface texture, and any other relevant observations.',
    `feature_thickness` DECIMAL(18,2) COMMENT 'The measured thickness of the structural feature in millimeters (e.g., vein width, fault gouge thickness).',
    `geomechanical_significance` STRING COMMENT 'Assessment of the geomechanical significance of the structural feature for pit slope design and ground stability analysis.. Valid values are `high|medium|low`',
    `infill_material` STRING COMMENT 'Description of the material filling the structural feature (e.g., quartz, calcite, clay, gouge).',
    `measurement_date` DATE COMMENT 'The date on which the structural measurement was captured in the field or from core logging.',
    `measurement_depth_from` DECIMAL(18,2) COMMENT 'The starting depth in meters down the drill hole where the structural feature was measured. Null for surface measurements.',
    `measurement_depth_to` DECIMAL(18,2) COMMENT 'The ending depth in meters down the drill hole where the structural feature was measured. Null for surface measurements.',
    `measurement_method` STRING COMMENT 'The method or instrument used to capture the structural measurement.. Valid values are `compass_clinometer|oriented_core|photogrammetry|lidar|digital_compass`',
    `measurement_source` STRING COMMENT 'The source from which the structural measurement was obtained (drillhole core, surface mapping, underground mapping, outcrop, or trench).. Valid values are `drillhole_core|surface_mapping|underground_mapping|outcrop|trench`',
    `mineralisation_association` STRING COMMENT 'Indicates whether the structural feature is associated with mineralisation, critical for understanding structural controls on ore bodies.. Valid values are `yes|no|possible`',
    `northing` DECIMAL(18,2) COMMENT 'The northing coordinate of the measurement location in the project coordinate system, used for GIS-referenced spatial data.',
    `quality_code` STRING COMMENT 'Quality assessment of the structural measurement based on exposure quality, measurement accuracy, and confidence.. Valid values are `excellent|good|fair|poor`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this structural measurement record was first created in the source system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this structural measurement record was last updated in the source system.',
    `roughness` STRING COMMENT 'Qualitative assessment of the surface roughness of the structural feature, important for geomechanical modeling.. Valid values are `smooth|slightly_rough|rough|very_rough|stepped|irregular`',
    `source_system` STRING COMMENT 'The system from which this structural measurement record was sourced (e.g., Geovia GEMS, field logging application).',
    `strike` DECIMAL(18,2) COMMENT 'The compass direction of a horizontal line on the plane of the structural feature, measured in degrees from north (0-360).',
    `structural_domain` STRING COMMENT 'The structural domain or zone to which this measurement is assigned, representing areas with similar structural characteristics.',
    `structural_feature_type` STRING COMMENT 'The type of structural geological feature being measured (fault, fold, joint, shear zone, vein, or foliation).. Valid values are `fault|fold|joint|shear_zone|vein|foliation`',
    `weathering_state` STRING COMMENT 'The degree of weathering observed on the structural feature surface.. Valid values are `fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil`',
    CONSTRAINT pk_structural_measurement PRIMARY KEY(`structural_measurement_id`)
) COMMENT 'Records of structural geology measurements captured from drillhole core and surface mapping including orientation data (dip, dip direction, strike), structural feature type (fault, fold, joint, shear zone, vein, foliation), alpha and beta angles, and structural domain assignment. Critical for geomechanical modelling, pit slope design, and understanding structural controls on mineralisation. Sourced from core logging in Geovia GEMS.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`geotechnical_log` (
    `geotechnical_log_id` BIGINT COMMENT 'Unique identifier for the geotechnical log record. Primary key for downhole geotechnical and physical property measurements from diamond drillhole core.',
    `drill_hole_id` BIGINT COMMENT 'Unique identifier of the diamond drillhole from which this geotechnical core sample was extracted. Links to the drill hole master record in the exploration domain.',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: Geotechnical logs capture physical properties for specific lithologies. Currently geotechnical_log stores lithology_code as a STRING; this should be normalized to FK to geological_unit.geological_unit',
    `laboratory_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the geotechnical testing and density measurements. Used for QAQC traceability and inter-laboratory comparison.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Geotechnical data collection requires competent person accountability for rock mechanics studies, slope stability analysis, and mine design. Links enable competency verification and audit trails for s',
    `comments` STRING COMMENT 'Free-text field for geotechnical observations, notes on core condition, structural features, alteration, or any other relevant geomechanical information not captured in structured fields.',
    `core_recovery_percent` DECIMAL(18,2) COMMENT 'Percentage of core recovered from the drilled interval, calculated as (recovered core length / drilled interval length) × 100. Critical indicator of rock quality and drilling conditions.',
    `data_source_system` STRING COMMENT 'Source system from which this geotechnical log record was extracted. Typically Geovia GEMS for geological logging or LabWare LIMS for laboratory density and strength testing results.. Valid values are `geovia_gems|labware_lims|manual_entry|import`',
    `density_measurement_method` STRING COMMENT 'Laboratory method used to determine density and specific gravity. Water immersion is standard for competent core; wax-coated method used for porous or friable samples; pycnometer for fine material.. Valid values are `water_immersion|wax_coated|pycnometer|caliper|other`',
    `depth_from` DECIMAL(18,2) COMMENT 'Starting depth in meters downhole from collar for this geotechnical measurement interval. Defines the top of the logged interval.',
    `depth_to` DECIMAL(18,2) COMMENT 'Ending depth in meters downhole from collar for this geotechnical measurement interval. Defines the bottom of the logged interval.',
    `dry_bulk_density` DECIMAL(18,2) COMMENT 'Dry bulk density of the core sample in tonnes per cubic meter, measured after oven-drying to constant mass. Primary density value for resource tonnage calculations.',
    `fracture_frequency` DECIMAL(18,2) COMMENT 'Number of natural fractures, joints, or discontinuities per meter of core. Key parameter for rock mass characterization and ground support design.',
    `geomechanical_domain` STRING COMMENT 'Geomechanical domain classification code representing zones of similar rock mass behavior. Used to group rock masses with consistent geotechnical properties for slope stability and stope design modeling.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `interval_length` DECIMAL(18,2) COMMENT 'Length of the geotechnical logging interval in meters, calculated as depth_to minus depth_from. Represents the core run length for this measurement.',
    `logging_date` DATE COMMENT 'Date when the geotechnical core logging was performed in the field or core shed. Distinct from laboratory test date.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Moisture content of the sample at time of measurement, calculated as ((wet mass - dry mass) / dry mass) × 100. Used to convert between wet and dry density values.',
    `oxidation_state` STRING COMMENT 'Degree of oxidation and weathering of the rock mass per ISRM weathering classification. Critical for density correction and geotechnical property correlation.. Valid values are `fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil`',
    `point_load_index_mpa` DECIMAL(18,2) COMMENT 'Point Load Strength Index corrected to 50mm diameter equivalent (Is50) in megapascals. Field-based rock strength indicator used to estimate UCS when core testing is not available.',
    `porosity_percent` DECIMAL(18,2) COMMENT 'Porosity of the rock sample expressed as percentage of void space to total volume. Influences density, strength, and fluid flow characteristics.',
    `q_index` DECIMAL(18,2) COMMENT 'Tunneling Quality Index (Q-system) per Barton et al. (1974). Logarithmic rock mass classification calculated from RQD, joint set number, joint roughness, joint alteration, water reduction factor, and stress reduction factor. Used for underground excavation support design.',
    `qaqc_flag` STRING COMMENT 'Free-text quality control flag or comment describing any data quality issues, anomalies, or validation failures identified during QAQC review. Empty if no issues detected.',
    `qaqc_status` STRING COMMENT 'Quality assurance and quality control validation status for this geotechnical record. Indicates whether the data has passed internal validation checks for completeness, consistency, and accuracy.. Valid values are `pending|passed|failed|flagged|verified`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geotechnical log record was first created in the source system. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this geotechnical log record was last modified in the source system. Used for change tracking and incremental data loading.',
    `rmr_rating` STRING COMMENT 'Rock Mass Rating classification value (0-100 scale) per Bieniawski (1989). Composite geomechanical classification integrating rock strength, RQD, discontinuity spacing, condition, groundwater, and orientation. Used for ground support design.',
    `rqd_percent` DECIMAL(18,2) COMMENT 'Rock Quality Designation percentage, calculated as the sum of intact core pieces greater than 100mm divided by total interval length × 100. Standard geotechnical index for rock mass quality per Deere (1964).',
    `sample_number` STRING COMMENT 'Unique laboratory sample number assigned to the core interval for geotechnical testing. Links to sample chain-of-custody and laboratory information management system.. Valid values are `^[A-Z0-9_-]{4,30}$`',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the rock sample, representing the ratio of sample density to water density. Measured using water immersion, wax-coated, or pycnometer methods.',
    `test_date` DATE COMMENT 'Date when the geotechnical laboratory testing was performed. Critical for temporal QAQC analysis and data vintage tracking.',
    `ucs_mpa` DECIMAL(18,2) COMMENT 'Unconfined Compressive Strength of intact rock measured in megapascals (MPa). Laboratory-determined strength of rock under uniaxial compression, critical for pit slope and stope design.',
    `wet_bulk_density` DECIMAL(18,2) COMMENT 'Wet bulk density of the core sample in tonnes per cubic meter, measured at natural moisture content. Used for in-situ tonnage estimation and comparison with dry density.',
    CONSTRAINT pk_geotechnical_log PRIMARY KEY(`geotechnical_log_id`)
) COMMENT 'Downhole geotechnical, physical property, and density logging records from diamond drillhole core. Captures rock quality designation (RQD), core recovery, fracture frequency, rock strength (UCS), point load index, rock mass rating (RMR), Q-index, geomechanical domain classification, and all density/specific gravity measurements (water immersion, wax-coated, dry bulk, pycnometer methods) with moisture content at depth intervals. Density records include measurement method, laboratory identifier, geological unit, oxidation state, and QAQC flags. Feeds pit slope stability analysis, underground stope design, ground support specification, and provides density inputs for resource tonnage calculations. Sourced from Geovia GEMS and LabWare LIMS.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`block_model` (
    `block_model_id` BIGINT COMMENT 'Primary key for block_model',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Block models are created to support specific capital projects for pit optimization, plant sizing, and mine planning. Feasibility studies and stage gate reviews reference block models for tonnage/grade',
    `competent_person_id` BIGINT COMMENT 'Identifier of the competent person who signed off on this block model version. Links to the competent person register.',
    `orebody_id` BIGINT COMMENT 'FK to geology.orebody',
    `primary_superseded_by_model_block_model_id` BIGINT COMMENT 'Reference to the block model version that superseded this version. Null for active models. Enables version chain navigation.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Block model creation is a capital project deliverable with significant costs (drilling campaigns, geological consulting, software). Mining companies track geological modeling costs through WBS for cap',
    `approval_date` DATE COMMENT 'Date when this block model version was formally approved by the competent person and management.',
    `approval_status` STRING COMMENT 'Approval status of this block model version. Indicates whether the model has been formally approved by the competent person and management for use in resource reporting and mine planning.. Valid values are `pending|approved|rejected|conditional`',
    `commodity_type` STRING COMMENT 'Primary commodity or mineral type modeled in this block model (e.g., iron ore, copper, coal, lithium, nickel). [ENUM-REF-CANDIDATE: iron_ore|copper|coal|lithium|nickel|gold|silver|zinc|lead|bauxite|other — 11 candidates stripped; promote to reference product]',
    `coordinate_system` STRING COMMENT 'Coordinate reference system used for the block model (e.g., MGA Zone 50, WGS84 UTM Zone 33S, NAD83 State Plane). Defines the spatial reference framework.',
    `data_cutoff_date` DATE COMMENT 'Date up to which drilling and sampling data were included in this block model. Defines the temporal scope of input data.',
    `datum` STRING COMMENT 'Geodetic datum used for the block model (e.g., GDA94, WGS84, NAD83). Defines the reference ellipsoid and origin for coordinate measurements.',
    `drill_hole_count` STRING COMMENT 'Number of drill holes used as input data for this block model version. Indicates the density of sampling data.',
    `estimation_method` STRING COMMENT 'Statistical method used for grade estimation in this block model (e.g., ordinary kriging, inverse distance weighting, nearest neighbor, indicator kriging). Critical for JORC compliance and resource classification. [ENUM-REF-CANDIDATE: ordinary_kriging|inverse_distance|nearest_neighbor|indicator_kriging|multiple_indicator_kriging|uniform_conditioning|other — 7 candidates stripped; promote to reference product]',
    `estimation_software` STRING COMMENT 'Software package used to create and populate the block model (e.g., Geovia GEMS 6.8, Datamine Studio RM 1.8, Leapfrog Geo 2023.1).',
    `extent_x` DECIMAL(18,2) COMMENT 'Total extent of the block model in the X direction (easting) in meters. Defines the overall model width.',
    `extent_y` DECIMAL(18,2) COMMENT 'Total extent of the block model in the Y direction (northing) in meters. Defines the overall model length.',
    `extent_z` DECIMAL(18,2) COMMENT 'Total extent of the block model in the Z direction (elevation) in meters. Defines the overall model height.',
    `key_changes_summary` STRING COMMENT 'Summary of key changes made in this version compared to the previous version. Provides context for version history and audit trail.',
    `model_code` STRING COMMENT 'Unique business identifier or code for the block model, used for external reference and reporting (e.g., NPT_IO_2024_V3, SCD_CU_2023_V1).',
    `model_name` STRING COMMENT 'Business name of the block model instance, typically referencing the orebody or deposit name (e.g., North Pit Iron Ore Model, South Copper Deposit Model).',
    `model_status` STRING COMMENT 'Current lifecycle status of the block model instance. Active models are used for current planning and resource estimation; superseded models have been replaced by newer versions; archived models are retained for historical reference; draft models are under development; under_review models are pending validation; approved models have passed competent person sign-off.. Valid values are `active|superseded|archived|draft|under_review|approved`',
    `origin_x` DECIMAL(18,2) COMMENT 'X-coordinate (easting) of the block model origin point in the specified coordinate system. Defines the southwest corner of the model grid.',
    `origin_y` DECIMAL(18,2) COMMENT 'Y-coordinate (northing) of the block model origin point in the specified coordinate system. Defines the southwest corner of the model grid.',
    `origin_z` DECIMAL(18,2) COMMENT 'Z-coordinate (elevation) of the block model origin point in meters above the datum. Defines the base elevation of the model grid.',
    `parent_block_size_x` DECIMAL(18,2) COMMENT 'X-axis dimension (easting) of the parent block in meters. Defines the fundamental block size in the east-west direction.',
    `parent_block_size_y` DECIMAL(18,2) COMMENT 'Y-axis dimension (northing) of the parent block in meters. Defines the fundamental block size in the north-south direction.',
    `parent_block_size_z` DECIMAL(18,2) COMMENT 'Z-axis dimension (elevation) of the parent block in meters. Defines the fundamental block size in the vertical direction.',
    `rotation_angle` DECIMAL(18,2) COMMENT 'Rotation angle of the block model grid in degrees, measured clockwise from north. Used to align the model with the orebody strike direction.',
    `sample_count` STRING COMMENT 'Total number of assay samples used as input data for this block model version. Indicates the volume of analytical data.',
    `sub_block_configuration` STRING COMMENT 'Description of the sub-blocking configuration if enabled (e.g., 2x2x2, 4x4x4, adaptive). Specifies how parent blocks are subdivided.',
    `sub_blocking_enabled` BOOLEAN COMMENT 'Indicates whether sub-blocking (subdivision of parent blocks into smaller blocks) is enabled in this model to improve resolution at orebody boundaries and geological contacts.',
    `superseded_date` DATE COMMENT 'Date when this block model version was superseded by a newer version. Null for active models.',
    `total_block_count` BIGINT COMMENT 'Total number of blocks (parent and sub-blocks) in the block model. Used for model size assessment and computational planning.',
    `update_reason` STRING COMMENT 'Primary reason for creating this new version of the block model (e.g., new drilling data, geological reinterpretation, methodology change, data correction, resource update, mine depletion). [ENUM-REF-CANDIDATE: new_drilling|geological_reinterpretation|methodology_change|data_correction|resource_update|mine_depletion|other — 7 candidates stripped; promote to reference product]',
    `version_date` DATE COMMENT 'Effective date of this block model version. Represents the date from which this version is considered current for resource reporting and mine planning.',
    `version_identifier` STRING COMMENT 'Version number or identifier for this block model instance (e.g., V1, V2.1, 2024.03). Used to track model evolution and updates.',
    `creation_date` DATE COMMENT 'Date when this block model version was created. Used for version control and audit trail.',
    CONSTRAINT pk_block_model PRIMARY KEY(`block_model_id`)
) COMMENT 'Master register of 3D block model instances representing the geological and grade model of each orebody, with full version control. Captures model name, version identifier, block dimensions (X, Y, Z rotation), parent block size, sub-blocking configuration, coordinate system, datum, creation date, estimation method, model status (active, superseded, archived), version date, reason for update (new drilling, reinterpretation, methodology change), key changes summary, competent person sign-off, approval status, and superseded version reference. Each block model instance is the container for all block-level attribute data used in resource estimation and mine planning. Version history ensures full audit trail for JORC-compliant resource reporting and regulatory disclosure. Sourced from Geovia GEMS.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`block_model_cell` (
    `block_model_cell_id` BIGINT COMMENT 'Unique identifier for the block model cell. Primary key for the block model cell entity.',
    `block_model_id` BIGINT COMMENT 'Reference to the parent block model to which this cell belongs. Links to the specific geological model version and configuration.',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Block model cells are classified into geological domains for resource estimation. The cell currently stores geological_domain_code as a STRING; this should be normalized to a FK to geological_domain.g',
    `geological_unit_id` BIGINT COMMENT 'Foreign key linking to geology.geological_unit. Business justification: block_model_cell currently has lithology_code and rock_type as STRING attributes. These are denormalized references to the geological_unit reference catalog. Adding geological_unit_id FK normalizes th',
    `pit_design_id` BIGINT COMMENT 'Identifier of the optimized pit shell that contains this block. Used for open pit mine planning and scheduling. Links to pit optimization scenarios.',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Block model cells classified as ore are assigned to specific saleable products based on grade and quality specifications. Critical for mine-to-mill optimization, production scheduling, product forecas',
    `block_dimension_x` DECIMAL(18,2) COMMENT 'Width of the block in the X direction (easting) measured in meters. Defines the block size in the east-west dimension.',
    `block_dimension_y` DECIMAL(18,2) COMMENT 'Length of the block in the Y direction (northing) measured in meters. Defines the block size in the north-south dimension.',
    `block_dimension_z` DECIMAL(18,2) COMMENT 'Height of the block in the Z direction (elevation) measured in meters. Defines the vertical block size.',
    `block_volume_m3` DECIMAL(18,2) COMMENT 'Volume of the block in cubic meters. Calculated as the product of block dimensions (X * Y * Z) and used for tonnage calculations.',
    `centroid_x` DECIMAL(18,2) COMMENT 'X coordinate of the block centroid in the mine coordinate system (easting). Represents the center point of the block in the east-west direction.',
    `centroid_y` DECIMAL(18,2) COMMENT 'Y coordinate of the block centroid in the mine coordinate system (northing). Represents the center point of the block in the north-south direction.',
    `centroid_z` DECIMAL(18,2) COMMENT 'Z coordinate of the block centroid representing elevation or depth below surface. Vertical position of the block center in the mine coordinate system.',
    `cut_off_grade_applied` DECIMAL(18,2) COMMENT 'The minimum economic grade threshold applied to classify this block as ore or waste. Critical parameter for resource-to-reserve conversion and mine planning optimization.',
    `density_t_per_m3` DECIMAL(18,2) COMMENT 'Bulk density of the block material measured in tonnes per cubic meter. Used to convert block volume to tonnage for resource estimation.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Expected dilution factor representing the proportion of waste material mixed with ore during mining. Modifying factor applied during reserve conversion.',
    `estimation_method` STRING COMMENT 'Geostatistical method used to estimate grades for this block. Documents the interpolation technique applied during resource modeling.. Valid values are `ordinary_kriging|inverse_distance|nearest_neighbor|indicator_kriging|multiple_indicator_kriging`',
    `estimation_pass` STRING COMMENT 'The estimation pass number during which this block was populated. Multi-pass estimation uses progressively relaxed search parameters to fill all blocks.',
    `grade_au_g_per_t` DECIMAL(18,2) COMMENT 'Estimated gold (Au) grade within the block expressed in grams per tonne. Critical for precious metal deposits and by-product recovery.',
    `grade_coal_ash_pct` DECIMAL(18,2) COMMENT 'Estimated ash content percentage for coal blocks. Key quality parameter for coal deposits affecting market value and processing requirements.',
    `grade_coal_sulfur_pct` DECIMAL(18,2) COMMENT 'Estimated sulfur content percentage for coal blocks. Environmental and quality parameter affecting coal marketability and emissions.',
    `grade_cu_ppm` DECIMAL(18,2) COMMENT 'Estimated copper (Cu) grade within the block expressed in parts per million (ppm). Used for copper and polymetallic deposits.',
    `grade_fe_pct` DECIMAL(18,2) COMMENT 'Estimated iron (Fe) grade within the block expressed as a percentage. Primary commodity grade for iron ore deposits.',
    `grade_li_ppm` DECIMAL(18,2) COMMENT 'Estimated lithium (Li) grade within the block expressed in parts per million (ppm). Used for lithium brine and hard rock deposits.',
    `grade_ni_pct` DECIMAL(18,2) COMMENT 'Estimated nickel (Ni) grade within the block expressed as a percentage. Primary commodity grade for nickel deposits.',
    `kriging_variance` DECIMAL(18,2) COMMENT 'Statistical variance from kriging estimation for this block. Measure of estimation uncertainty and confidence in the grade estimate.',
    `mining_method_flag` STRING COMMENT 'Planned or applicable mining method for extracting this block. Values include open_pit, underground, SLC (Sub-Level Caving), block_cave, longwall (coal), room_pillar, not_applicable. [ENUM-REF-CANDIDATE: open_pit|underground|slc|block_cave|longwall|room_pillar|not_applicable — 7 candidates stripped; promote to reference product]',
    `mining_phase` STRING COMMENT 'Planned mining phase or stage in which this block is scheduled for extraction. Used for Life of Mine (LOM) planning and sequencing.',
    `mining_recovery_factor` DECIMAL(18,2) COMMENT 'Expected mining recovery factor representing the proportion of in-situ ore that can be extracted. Modifying factor applied during reserve conversion.',
    `model_version` STRING COMMENT 'Version identifier of the block model. Tracks model updates and revisions over time as new geological data becomes available.',
    `number_of_samples` STRING COMMENT 'Count of drill hole samples used to estimate grades for this block. Indicator of estimation confidence and data density.',
    `ore_waste_classification` STRING COMMENT 'Classification of the block as ore, waste, or intermediate material based on cut-off grade criteria. Drives mine planning and scheduling decisions.. Valid values are `ore|waste|low_grade|marginal|overburden|gangue`',
    `oxidation_state` STRING COMMENT 'Oxidation state of the ore within the block. Critical for determining processing method and recovery rates. Values: oxide (weathered), transitional (mixed), fresh (unweathered), supergene (secondary enrichment), hypogene (primary).. Valid values are `oxide|transitional|fresh|supergene|hypogene`',
    `processing_recovery_factor` DECIMAL(18,2) COMMENT 'Expected metallurgical recovery factor representing the proportion of valuable mineral that can be recovered during processing. Modifying factor applied during reserve conversion.',
    `reserve_category` STRING COMMENT 'JORC/NI 43-101 ore reserve classification category for this block after applying modifying factors. Proved (highest confidence), probable (moderate confidence), not_reserve (does not meet economic criteria), unclassified.. Valid values are `proved|probable|not_reserve|unclassified`',
    `resource_category` STRING COMMENT 'JORC/NI 43-101 resource classification category for this block. Reflects confidence level in the geological and grade continuity: measured (highest confidence), indicated (moderate confidence), inferred (lowest confidence), unclassified (insufficient data).. Valid values are `measured|indicated|inferred|unclassified`',
    `tonnage` DECIMAL(18,2) COMMENT 'Total tonnage of material within the block, calculated as volume multiplied by density. Fundamental metric for resource and reserve reporting.',
    CONSTRAINT pk_block_model_cell PRIMARY KEY(`block_model_cell_id`)
) COMMENT 'Individual block (cell) records within a 3D block model, each representing a discrete volumetric unit of the orebody model. Captures block centroid coordinates (X, Y, Z), block dimensions, geological domain code, lithological unit, estimated grade by commodity (Fe%, Cu ppm, Au g/t, etc.), density, rock type, oxidation state, ore/waste classification, and modifying factor flags. The fundamental unit of resource estimation and mine planning optimisation. Sourced from Geovia GEMS block model exports.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`grade_control_sample` (
    `grade_control_sample_id` BIGINT COMMENT 'Unique identifier for the grade control sample record. Primary key for the grade control sample entity.',
    `blast_pattern_id` BIGINT COMMENT 'Identifier of the blast pattern from which the sample was collected. Links grade control samples to specific drilling and blasting operations for reconciliation.',
    `block_model_cell_id` BIGINT COMMENT 'Foreign key linking to geology.block_model_cell. Business justification: Grade control samples validate specific block model cell predictions. Required for ore/waste classification decisions, model confidence assessment, and identifying areas requiring infill sampling.',
    `block_model_id` BIGINT COMMENT 'Foreign key linking to geology.block_model. Business justification: Grade control samples are compared against block model predictions for reconciliation. Currently grade_control_sample has block_model_grade (a VALUE) but no FK to the block_model. Adding block_model_i',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Grade control sampling is an operational cost (drilling, assaying, geological labor) allocated to cost centres for ore control activities. Essential for mining opex tracking, AISC calculation, and uni',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Grade control sampling operations must track which drill rig collected each sample for sample integrity verification, QAQC traceability, and correlation of sample quality with equipment performance. C',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Grade control decisions (ore/waste classification) require geologist sign-off for production accountability and reconciliation. Links enable competency verification, production variance analysis, and ',
    `laboratory_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory_sample. Business justification: Grade control samples are collected from production drilling/blasting and sent to laboratory for assay. Links mining execution to laboratory analysis for ore/waste classification and production reconc',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Grade control samples are collected from specific orebodies during production. Currently grade_control_sample has pit_name and mining_block but no direct orebody link. Adding orebody_id FK enables dir',
    `production_drillhole_id` BIGINT COMMENT 'Identifier of the specific blast hole or drill hole from which the sample was collected. Used for blast hole samples to link back to drilling operations.',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Grade control samples determine real-time material destination to specific saleable products based on assay results meeting product specifications. Essential for ore routing decisions, stockpile alloc',
    `al2o3_percent` DECIMAL(18,2) COMMENT 'Assayed alumina content of the sample expressed as a percentage. Key deleterious element for iron ore quality and processing.',
    `assay_completion_date` DATE COMMENT 'Date when the laboratory completed the assay analysis and reported results. Used to track turnaround time and operational delays.',
    `assay_method` STRING COMMENT 'Analytical method used for sample assay. Examples include XRF (X-Ray Fluorescence), fire assay, ICP-MS (Inductively Coupled Plasma Mass Spectrometry), AAS (Atomic Absorption Spectroscopy). Critical for quality control and data validation.',
    `au_g_per_t` DECIMAL(18,2) COMMENT 'Assayed gold content of the sample expressed in grams per tonne. Critical commodity grade for gold operations and by-product recovery.',
    `bench` STRING COMMENT 'Identifier of the mining bench or level where the sample was collected. Benches are horizontal working surfaces in open pit mines, typically designated by elevation (e.g., 450RL, 440RL).',
    `block_model_grade` DECIMAL(18,2) COMMENT 'Predicted grade from the long-term geological block model for the spatial location of this sample. Used for model-versus-actual reconciliation to assess geological model accuracy.',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the grade control sample was physically collected in the field during mining operations. Critical for temporal reconciliation and operational sequencing.',
    `comments` STRING COMMENT 'Free-text field for geologist observations, sample collection notes, geological features, contamination issues, or any other relevant contextual information about the sample.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this grade control sample record was first created in the database. Used for audit trail and data lineage.',
    `cu_ppm` DECIMAL(18,2) COMMENT 'Assayed copper content of the sample expressed in parts per million. Key commodity grade for copper operations.',
    `easting` DECIMAL(18,2) COMMENT 'East-west spatial coordinate of the sample location in the mine grid coordinate system, typically in meters. Used for GIS mapping and spatial reconciliation against the geological block model.',
    `elevation_rl` DECIMAL(18,2) COMMENT 'Vertical elevation of the sample location relative to a defined datum, typically in meters above sea level. RL (Reduced Level) is the mining industry standard term for elevation.',
    `fe_percent` DECIMAL(18,2) COMMENT 'Assayed iron content of the sample expressed as a percentage of total mass. Primary commodity grade for iron ore operations.',
    `geologist_sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the grade control geologist formally validated and signed off on the sample data and classification. Critical for operational approval workflow.',
    `grade_variance` DECIMAL(18,2) COMMENT 'Calculated difference between the assayed grade and the block model predicted grade. Positive values indicate actual grade exceeded prediction, negative values indicate under-prediction. Key metric for geological model reconciliation.',
    `interval_length` DECIMAL(18,2) COMMENT 'Length of the sample interval in meters, calculated as the difference between interval_to and interval_from. Represents the vertical or horizontal extent of material represented by the sample.',
    `laboratory_name` STRING COMMENT 'Name or identifier of the laboratory that performed the assay analysis. May be on-site laboratory or external commercial laboratory.',
    `material_destination` STRING COMMENT 'Designated destination for the material represented by this sample based on grade control classification. Crusher for direct processing, ROM (Run of Mine) pad for temporary storage before processing, stockpile for longer-term ore storage, waste dump for sub-economic material.. Valid values are `crusher|rom_pad|stockpile|waste_dump`',
    `mining_block` STRING COMMENT 'Short-term mining block identifier representing the operational dig unit. Mining blocks are subdivisions of the pit used for daily to weekly mine planning and grade control.',
    `northing` DECIMAL(18,2) COMMENT 'North-south spatial coordinate of the sample location in the mine grid coordinate system, typically in meters. Used for GIS mapping and spatial reconciliation against the geological block model.',
    `ore_type` STRING COMMENT 'Geological classification of the ore type based on mineralogy, lithology, and processing characteristics. Examples include hematite, magnetite, banded iron formation, oxide copper, sulfide copper, free-milling gold. Used for material routing and processing decisions. [ENUM-REF-CANDIDATE: hematite|magnetite|goethite|bif|oxide_cu|sulfide_cu|transitional_cu|free_milling_au|refractory_au — promote to reference product]',
    `p_percent` DECIMAL(18,2) COMMENT 'Assayed phosphorus content of the sample expressed as a percentage. Critical deleterious element for steel-making iron ore quality.',
    `pit_name` STRING COMMENT 'Name or identifier of the open pit mine where the sample was collected. Used to segment grade control data by mining area.',
    `qaqc_status` STRING COMMENT 'Status of quality assurance and quality control checks for this sample. Passed indicates all QC checks met acceptance criteria, failed indicates QC failure requiring re-assay, pending indicates QC checks in progress.. Valid values are `passed|failed|pending|not_applicable`',
    `reconciliation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this sample has been included in formal mine-to-model reconciliation reporting. True indicates the sample has been reconciled, false indicates pending reconciliation.',
    `s_percent` DECIMAL(18,2) COMMENT 'Assayed sulfur content of the sample expressed as a percentage. Key deleterious element for iron ore and copper concentrate quality.',
    `sample_interval_from` DECIMAL(18,2) COMMENT 'Starting depth of the sample interval in meters, measured from the collar of the hole. Used for blast hole and channel samples to define the vertical extent of the sample.',
    `sample_interval_to` DECIMAL(18,2) COMMENT 'Ending depth of the sample interval in meters, measured from the collar of the hole. Used for blast hole and channel samples to define the vertical extent of the sample.',
    `sample_number` STRING COMMENT 'Externally-known unique sample identifier assigned by the laboratory or field geologist. Used for tracking and reconciliation across systems.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the grade control sample. Tracks progression from field collection through laboratory assay to final validation and reconciliation against block model predictions.. Valid values are `collected|submitted|assayed|validated|reconciled|rejected`',
    `sample_type` STRING COMMENT 'Classification of the grade control sample collection method. Blast hole samples are taken from production blast holes, channel samples from exposed faces, trench samples from excavated trenches, face samples from active mining faces, chip samples from rock chips, and grab samples are representative bulk samples.. Valid values are `blast_hole|channel|trench|face|chip|grab`',
    `sample_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the collected sample in kilograms. Used for quality control and to ensure representative sample mass for laboratory analysis.',
    `sio2_percent` DECIMAL(18,2) COMMENT 'Assayed silica content of the sample expressed as a percentage. Key deleterious element for iron ore quality and processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this grade control sample record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_grade_control_sample PRIMARY KEY(`grade_control_sample_id`)
) COMMENT 'Grade control sampling records from blast holes, channel samples, trench samples, and face samples taken during active mining operations to define ore/waste boundaries for short-term mine planning and dig-line delineation. Captures sample identifier, spatial location (easting, northing, RL, bench, pit, mining block), sample type, interval length, assay results by commodity (Fe%, Cu ppm, Au g/t), ore type classification, material destination (crusher, ROM pad, stockpile, waste dump), reconciliation flag against the block model prediction, and grade control geologist sign-off. The operational bridge between the long-term geological model and daily mining execution — enables model-vs-actual reconciliation. Sourced from LabWare LIMS and Geovia GEMS grade control modules.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`geological_domain` (
    `geological_domain_id` BIGINT COMMENT 'Unique identifier for the geological domain. Primary key.',
    `competent_person_id` BIGINT COMMENT 'Reference to the Competent Person (as defined by JORC Code) responsible for defining and validating this geological domain. Ensures professional accountability.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Geological domains drive mining method selection and cost structure. Mining operations map domains to cost centres for mine planning, budget allocation, and cost forecasting. Different domains (oxide ',
    `orebody_id` BIGINT COMMENT 'Reference to the parent orebody that this geological domain belongs to. Links domain to the broader mineralized body.',
    `average_grade` DECIMAL(18,2) COMMENT 'Mean grade of the primary commodity across all samples within this geological domain. Used for domain validation and resource reporting.',
    `bulk_density` DECIMAL(18,2) COMMENT 'Average bulk density of the rock within this domain in tonnes per cubic meter. Used to convert volume to tonnage for resource estimation.',
    `commodity` STRING COMMENT 'Primary mineral commodity that this domain is defined for. Determines which assay grades are interpolated within this domain. [ENUM-REF-CANDIDATE: iron_ore|copper|gold|nickel|lithium|coal|zinc|lead|silver|platinum — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geological domain record was first created in the system. Audit trail for data governance.',
    `cut_off_grade` DECIMAL(18,2) COMMENT 'Minimum grade threshold used to define economic mineralization within this domain. Blocks below this grade are classified as waste. Expressed in commodity-specific units (e.g., % Fe, g/t Au).',
    `cut_off_grade_unit` STRING COMMENT 'Unit of measure for the cut-off grade (e.g., percent for iron ore, grams per tonne for gold, parts per million for trace elements). [ENUM-REF-CANDIDATE: percent|ppm|gpt|opt|pct_fe|pct_cu|pct_ni — 7 candidates stripped; promote to reference product]',
    `domain_code` STRING COMMENT 'Short alphanumeric code used to identify the domain in geological models and block models. Typically used in Geovia GEMS domain coding workflows.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `domain_name` STRING COMMENT 'Descriptive name of the geological domain that conveys its geological or spatial characteristics (e.g., High Grade Core, Oxide Zone, Supergene Enrichment).',
    `domain_type` STRING COMMENT 'Classification of the domain based on the geological characteristic used to define its boundary: lithological (rock type), structural (fault/fold), alteration (hydrothermal), grade (metal concentration), oxidation (weathering), or mineralization (ore type).. Valid values are `lithological|structural|alteration|grade|oxidation|mineralization`',
    `domain_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the geological domain in cubic meters, calculated from the 3D wireframe boundary. Used for tonnage estimation.',
    `effective_date` DATE COMMENT 'Date from which this domain definition became effective for resource estimation and mine planning purposes. Supports temporal versioning of geological interpretations.',
    `estimation_constraint_type` STRING COMMENT 'Defines how the domain boundary constrains grade interpolation during resource estimation. Hard boundary prevents grade estimation across the boundary; soft boundary allows limited influence; transitional allows gradual transition.. Valid values are `hard|soft|transitional`',
    `geological_confidence` STRING COMMENT 'Qualitative assessment of geological understanding and continuity confidence within the domain, independent of resource classification. Informs risk assessment.. Valid values are `low|moderate|high`',
    `geological_domain_status` STRING COMMENT 'Current lifecycle status of the domain definition. Active domains are used in current resource models; superseded domains have been replaced by updated interpretations; archived domains are retained for historical reference.. Valid values are `active|superseded|archived|under_review`',
    `grade_variance` DECIMAL(18,2) COMMENT 'Statistical variance of grade values within the domain. Indicates grade heterogeneity and informs estimation strategy.',
    `maximum_sample_count` STRING COMMENT 'Maximum number of assay samples used in a single block grade estimation. Prevents over-smoothing and maintains local variability.',
    `minimum_sample_count` STRING COMMENT 'Minimum number of assay samples required within the search ellipsoid to estimate a block grade. Ensures statistical reliability of estimates.',
    `model_version` STRING COMMENT 'Version identifier of the geological model in which this domain definition was created or last updated. Enables traceability and change management.. Valid values are `^[A-Z0-9._-]{1,30}$`',
    `notes` STRING COMMENT 'Free-text field for geological observations, interpretation rationale, estimation assumptions, or special considerations related to this domain. Captures expert knowledge.',
    `resource_category` STRING COMMENT 'JORC classification of the resource confidence level within this domain: Inferred (lowest confidence), Indicated (moderate confidence), or Measured (highest confidence). Drives reserve conversion and mine planning.. Valid values are `inferred|indicated|measured`',
    `sample_count` STRING COMMENT 'Total number of assay samples (drill hole intercepts, channel samples, etc.) used to define and characterize this geological domain.',
    `search_ellipsoid_azimuth_deg` DECIMAL(18,2) COMMENT 'Azimuth angle in degrees (0-360) defining the orientation of the major axis of the search ellipsoid used in kriging. Typically aligned with geological strike.',
    `search_ellipsoid_dip_deg` DECIMAL(18,2) COMMENT 'Dip angle in degrees (-90 to +90) defining the plunge of the major axis of the search ellipsoid. Typically aligned with orebody dip.',
    `search_ellipsoid_plunge_deg` DECIMAL(18,2) COMMENT 'Plunge angle in degrees (0-360) defining the rotation of the search ellipsoid around the major axis. Used for complex 3D orientations.',
    `superseded_date` DATE COMMENT 'Date on which this domain definition was superseded by a newer interpretation. Null for active domains. Supports audit trail of geological model evolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this geological domain record was last modified. Supports change tracking and data lineage.',
    `variogram_model_type` STRING COMMENT 'Type of geostatistical variogram model used to characterize spatial continuity of grades within this domain. Used in kriging interpolation.. Valid values are `spherical|exponential|gaussian|power|nugget_effect`',
    `variogram_nugget_effect` DECIMAL(18,2) COMMENT 'Proportion of total variance attributed to micro-scale variability and measurement error. Expressed as a ratio (0 to 1). Higher values indicate greater short-range variability.',
    `variogram_range_major_m` DECIMAL(18,2) COMMENT 'Maximum range of spatial continuity in the major axis direction (typically along strike or longest dimension) in meters. Defines search ellipsoid for kriging.',
    `variogram_range_minor_m` DECIMAL(18,2) COMMENT 'Minimum range of spatial continuity in the minor axis direction (typically vertical or shortest dimension) in meters.',
    `variogram_range_semi_major_m` DECIMAL(18,2) COMMENT 'Range of spatial continuity in the semi-major axis direction (typically across strike or intermediate dimension) in meters.',
    `variogram_sill` DECIMAL(18,2) COMMENT 'Total variance of the grade population within the domain. Represents the plateau value that the variogram approaches at large distances.',
    `wireframe_reference` STRING COMMENT 'Reference to the 3D wireframe surface file or object in the geological modeling system (Geovia GEMS, Leapfrog, Vulcan) that defines the spatial boundary of this domain.',
    CONSTRAINT pk_geological_domain PRIMARY KEY(`geological_domain_id`)
) COMMENT 'Spatial geological domain definitions used to constrain resource estimation and grade interpolation. Each domain represents a statistically homogeneous population of grade data bounded by geological contacts (lithological, structural, or alteration boundaries). Captures domain name, parent orebody, bounding wireframe reference, commodity, estimation constraint type (hard or soft boundary), variogram model parameters, and domain status. Sourced from Geovia GEMS domain coding.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`wireframe` (
    `wireframe_id` BIGINT COMMENT 'Unique identifier for the geological wireframe record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Wireframes (3D geological models) are created for specific capital projects to support pit optimization, underground mine design, and infrastructure placement. Project design teams use wireframes for ',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Wireframes constrain geological domains for resource estimation. Currently wireframe stores geological_domain as a STRING; this should be normalized to FK to geological_domain.geological_domain_id. Th',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Wireframes define the 3D spatial boundaries of orebodies. Currently wireframe stores orebody_name as a STRING; this should be normalized to FK to orebody.orebody_id. The orebody table is the master de',
    `parent_wireframe_id` BIGINT COMMENT 'Reference to a parent or containing wireframe in hierarchical geological models. For example, a sub-domain wireframe may reference its parent orebody envelope wireframe.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Wireframe validation requires competent person sign-off for resource estimation and mine planning. Links enable competency verification for JORC/NI 43-101 compliance and audit trails for geological mo',
    `centroid_easting` DECIMAL(18,2) COMMENT 'Easting coordinate of the geometric centroid (centre of mass) of the wireframe. Used for spatial indexing and proximity analysis.',
    `centroid_elevation_rl` DECIMAL(18,2) COMMENT 'Elevation (reduced level) of the geometric centroid (centre of mass) of the wireframe in metres. Used for spatial indexing and 3D analysis.',
    `centroid_northing` DECIMAL(18,2) COMMENT 'Northing coordinate of the geometric centroid (centre of mass) of the wireframe. Used for spatial indexing and proximity analysis.',
    `comments` STRING COMMENT 'Free-text field for geologist notes, interpretation rationale, assumptions, limitations, or special considerations related to the wireframe construction. Supports knowledge transfer and audit trail.',
    `coordinate_system` STRING COMMENT 'The spatial reference system or coordinate system used for the wireframe geometry (e.g., WGS84, GDA2020, local mine grid, UTM Zone). Essential for GIS integration and spatial accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the wireframe record was first created in the geological database. Provides audit trail and version history.',
    `creation_method` STRING COMMENT 'The methodology or technique used to construct the wireframe. Manual interpretation involves geologist-driven section-by-section digitization. Implicit modelling uses algorithmic interpolation from drill data. Explicit modelling involves direct construction from known boundaries. Kriging, triangulation, and digitization represent specific technical approaches.. Valid values are `manual_interpretation|implicit_modelling|explicit_modelling|kriging|triangulation|digitization`',
    `data_source` STRING COMMENT 'Primary data sources used to construct the wireframe (e.g., drill hole logs, geological mapping, geophysical surveys, historical mine workings). Documents the evidence base for the interpretation.',
    `datum` STRING COMMENT 'The geodetic datum or reference ellipsoid used for the coordinate system (e.g., WGS84, GDA94, GDA2020). Critical for accurate spatial positioning and integration with survey data.',
    `drill_hole_count` STRING COMMENT 'Number of drill holes used to constrain or inform the wireframe interpretation. Indicates the data density and reliability of the geological model.',
    `interpretation_confidence` STRING COMMENT 'Geologists assessment of confidence in the wireframe interpretation based on data density, geological complexity, and structural understanding. High confidence indicates dense drill spacing and clear geological boundaries. Low confidence indicates sparse data or complex geology requiring further investigation.. Valid values are `high|medium|low`',
    `is_closed_solid` BOOLEAN COMMENT 'Boolean flag indicating whether the wireframe is a closed solid (true) or an open surface (false). Closed solids are required for volume calculations and block model domain coding.',
    `maximum_elevation_rl` DECIMAL(18,2) COMMENT 'Highest elevation (reduced level) of the wireframe in metres. Defines the top extent of the geological feature or orebody envelope.',
    `minimum_elevation_rl` DECIMAL(18,2) COMMENT 'Lowest elevation (reduced level) of the wireframe in metres. Defines the bottom extent of the geological feature or orebody envelope.',
    `model_version` STRING COMMENT 'Version identifier of the broader geological model or block model that this wireframe belongs to. Enables version control and historical tracking of model evolution.',
    `modelling_software` STRING COMMENT 'Name and version of the geological modelling software used to create the wireframe (e.g., Geovia GEMS, Hexagon MinePlan, Leapfrog, Surpac, Vulcan). Critical for reproducibility and audit trail.',
    `modified_by` STRING COMMENT 'Name or identifier of the geologist or modeller who last modified the wireframe. Supports change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the wireframe record was last modified. Provides audit trail and supports version control.',
    `projection_zone` STRING COMMENT 'The map projection zone or grid zone identifier (e.g., UTM Zone 50S, MGA Zone 51). Provides additional spatial context for coordinate transformation.',
    `quality_check_status` STRING COMMENT 'Result of automated quality assurance checks on the wireframe geometry (e.g., checks for self-intersecting triangles, inverted normals, gaps, overlaps). Passed indicates the wireframe meets technical quality standards.. Valid values are `passed|failed|pending|not_applicable`',
    `software_version` STRING COMMENT 'Specific version number or release identifier of the modelling software used. Required for technical reproducibility and compliance with JORC competent person requirements.',
    `surface_area_sqm` DECIMAL(18,2) COMMENT 'Total surface area of the wireframe in square metres. For solid wireframes, represents the external surface area. For surface wireframes, represents the area of the surface itself. Used for volume calculations and spatial analysis.',
    `triangle_count` STRING COMMENT 'Number of triangular facets or polygons that compose the wireframe mesh. Indicates the level of detail and complexity of the wireframe geometry.',
    `validation_date` DATE COMMENT 'Date when the wireframe was validated or approved by a competent person or technical reviewer. Required for JORC compliance and audit trail.',
    `validation_status` STRING COMMENT 'Current validation and approval status of the wireframe. Draft indicates initial construction, under review indicates peer review in progress, validated indicates technical QA complete, approved indicates competent person sign-off, superseded indicates replaced by newer version, archived indicates historical record only.. Valid values are `draft|under_review|validated|approved|superseded|archived`',
    `vertex_count` STRING COMMENT 'Number of vertices (points) that define the wireframe mesh. Higher vertex counts indicate finer resolution and more detailed geometry.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume enclosed by the wireframe in cubic metres. Applicable only to solid (closed) wireframes. Critical for tonnage estimation and mine planning.',
    `wireframe_code` STRING COMMENT 'Unique alphanumeric code or identifier used to reference the wireframe in geological databases and mine planning software.',
    `wireframe_name` STRING COMMENT 'Business name or label assigned to the wireframe for identification and reference in geological models and mine planning systems.',
    `wireframe_type` STRING COMMENT 'Classification of the wireframe geometry type. Solid represents 3D closed volumes (orebody envelopes), surface represents 2D boundaries, DTM (Digital Terrain Model) represents topographic surfaces, fault represents structural discontinuities, contact represents lithological boundaries, and alteration represents geochemical or mineralogical zones.. Valid values are `solid|surface|DTM|fault|contact|alteration`',
    `created_by` STRING COMMENT 'Name or identifier of the geologist or modeller who created the wireframe. Required for accountability and professional responsibility under JORC Code.',
    CONSTRAINT pk_wireframe PRIMARY KEY(`wireframe_id`)
) COMMENT '3D geological wireframe (solid or surface) model records representing interpreted geological boundaries including orebody envelopes, lithological contacts, fault surfaces, alteration shells, and topographic surfaces. Captures wireframe name, type (solid, DTM, fault, contact), associated geological unit or domain, creation method (manual interpretation, implicit modelling), software version, coordinate system, and validation status. The spatial backbone of all geological modelling. Sourced from Geovia GEMS and Hexagon MinePlan.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`geostatistical_run` (
    `geostatistical_run_id` BIGINT COMMENT 'Unique identifier for the geostatistical estimation run. Primary key. Role: MASTER_RESOURCE (specialized analytical resource representing a parameterized estimation execution).',
    `block_model_id` BIGINT COMMENT 'Reference to the parent block model for which this geostatistical run was executed. Links to the geological block model entity.',
    `competent_person_id` BIGINT COMMENT 'Reference to the JORC Competent Person who reviewed and approved this geostatistical run for resource reporting purposes.',
    `geological_domain_id` BIGINT COMMENT 'Reference to the specific geological domain (ore body, lithological unit, or mineralization zone) for which this estimation run was performed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Geostatistical estimation requires operator accountability for JORC/NI 43-101 compliance and resource estimation quality. Links enable competency verification for kriging/estimation techniques and aud',
    `comments` STRING COMMENT 'Free-text comments or notes regarding this geostatistical run, including assumptions, limitations, or special considerations.',
    `commodity_code` STRING COMMENT 'Chemical symbol or code for the commodity being estimated (e.g., FE for iron ore, CU for copper, AU for gold, LI for lithium, NI for nickel, COAL for coal).. Valid values are `^[A-Z]{1,4}$`',
    `composite_length_metres` DECIMAL(18,2) COMMENT 'Length in metres of the composited intervals used in the estimation (e.g., 1.0m, 2.0m, 5.0m). Null if variable length compositing was used.',
    `compositing_method` STRING COMMENT 'Method used to composite drill hole assay intervals prior to estimation (e.g., fixed length, bench composite, geological composite).. Valid values are `fixed_length|variable_length|bench_composite|geological_composite|downhole_composite`',
    `conditional_bias` DECIMAL(18,2) COMMENT 'Measure of systematic over- or under-estimation in the kriging results, calculated from cross-validation (values near zero indicate unbiased estimation).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geostatistical run record was first created in the system.',
    `effective_date` DATE COMMENT 'Effective date for the resource classification output from this run, used for JORC reporting and reserve conversion.',
    `estimation_method` STRING COMMENT 'Geostatistical or interpolation method used for grade estimation in this run (e.g., ordinary kriging, inverse distance weighting, conditional simulation). [ENUM-REF-CANDIDATE: ordinary_kriging|simple_kriging|indicator_kriging|inverse_distance_weighted|nearest_neighbour|conditional_simulation|multiple_indicator_kriging — 7 candidates stripped; promote to reference product]',
    `indicated_kriging_variance_threshold` DECIMAL(18,2) COMMENT 'Maximum kriging variance threshold for blocks to be classified as Indicated Resource. Null if kriging variance not used for classification.',
    `kriging_efficiency` DECIMAL(18,2) COMMENT 'Ratio of kriging variance to total variance, measuring the effectiveness of the kriging estimator (values closer to 1.0 indicate better efficiency).',
    `maximum_samples` STRING COMMENT 'Maximum number of composite samples used in the kriging neighbourhood to estimate a block grade, limiting computational load and over-smoothing.',
    `maximum_samples_per_drillhole` STRING COMMENT 'Maximum number of samples allowed from a single drill hole in the kriging neighbourhood to avoid clustering bias.',
    `measured_kriging_variance_threshold` DECIMAL(18,2) COMMENT 'Maximum kriging variance threshold for blocks to be classified as Measured Resource. Null if kriging variance not used for classification.',
    `minimum_samples` STRING COMMENT 'Minimum number of composite samples required within the search ellipsoid to estimate a block grade. Blocks with fewer samples remain unestimated.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geostatistical run record was last modified or updated.',
    `resource_classification_method` STRING COMMENT 'Method used to assign JORC resource classification categories (Measured, Indicated, Inferred) to estimated blocks (e.g., kriging variance thresholds, search pass, data spacing).. Valid values are `kriging_variance|search_pass|data_spacing|slope_of_regression|combined_criteria`',
    `run_date` DATE COMMENT 'Date on which the geostatistical estimation run was executed.',
    `run_name` STRING COMMENT 'Human-readable name or label assigned to this geostatistical run for identification and reference purposes (e.g., Q4_2023_FE_Main_Orebody_OK).',
    `run_status` STRING COMMENT 'Current lifecycle status of the geostatistical run indicating its stage in the estimation and approval workflow. [ENUM-REF-CANDIDATE: draft|in_progress|completed|validated|approved|rejected|archived — 7 candidates stripped; promote to reference product]',
    `search_ellipse_major_metres` DECIMAL(18,2) COMMENT 'Radius of the search ellipsoid along the major axis in metres, defining the maximum search distance for sample selection during kriging.',
    `search_ellipse_minor_metres` DECIMAL(18,2) COMMENT 'Radius of the search ellipsoid along the minor axis in metres.',
    `search_ellipse_semi_major_metres` DECIMAL(18,2) COMMENT 'Radius of the search ellipsoid along the semi-major axis in metres.',
    `search_pass_count` STRING COMMENT 'Number of search passes executed with progressively relaxed search parameters to ensure all blocks are estimated (e.g., 1st pass strict, 2nd pass expanded).',
    `slope_of_regression` DECIMAL(18,2) COMMENT 'Slope of the regression line between estimated block grades and true sample grades from cross-validation, indicating estimation accuracy (ideal value near 1.0).',
    `software_name` STRING COMMENT 'Name of the geostatistical software package used to execute this run (e.g., Geovia GEMS, Datamine Studio, Leapfrog Geo, Surpac).',
    `software_version` STRING COMMENT 'Version number of the geostatistical software used, ensuring reproducibility and audit compliance.',
    `top_cut_grade` DECIMAL(18,2) COMMENT 'Upper grade threshold applied to composite samples to cap extreme high values and reduce the influence of outliers on the estimate. Null if no top cut applied.',
    `variogram_azimuth_degrees` DECIMAL(18,2) COMMENT 'Azimuth rotation angle in degrees (0-360) defining the orientation of the major axis of the variogram ellipsoid in the horizontal plane.',
    `variogram_dip_degrees` DECIMAL(18,2) COMMENT 'Dip angle in degrees (-90 to +90) defining the vertical inclination of the major axis of the variogram ellipsoid.',
    `variogram_model_type` STRING COMMENT 'Type of variogram model fitted to the spatial continuity data (e.g., spherical, exponential, Gaussian, nested model). [ENUM-REF-CANDIDATE: spherical|exponential|gaussian|power|cubic|pentaspherical|hole_effect|nested — 8 candidates stripped; promote to reference product]',
    `variogram_nugget` DECIMAL(18,2) COMMENT 'Nugget effect value representing short-range variability or measurement error in the variogram model (dimensionless variance component).',
    `variogram_plunge_degrees` DECIMAL(18,2) COMMENT 'Plunge rotation angle in degrees defining the third rotation axis of the variogram ellipsoid for full 3D orientation.',
    `variogram_range_major_metres` DECIMAL(18,2) COMMENT 'Range of spatial continuity along the major axis of the variogram ellipsoid in metres, representing the maximum distance of grade correlation.',
    `variogram_range_minor_metres` DECIMAL(18,2) COMMENT 'Range of spatial continuity along the minor axis of the variogram ellipsoid in metres, typically representing the shortest correlation distance.',
    `variogram_range_semi_major_metres` DECIMAL(18,2) COMMENT 'Range of spatial continuity along the semi-major (intermediate) axis of the variogram ellipsoid in metres.',
    `variogram_sill` DECIMAL(18,2) COMMENT 'Total sill value of the variogram model representing the maximum spatial variance (nugget plus structural components).',
    CONSTRAINT pk_geostatistical_run PRIMARY KEY(`geostatistical_run_id`)
) COMMENT 'Records of individual geostatistical estimation runs capturing the full estimation methodology, variogram model, and resource classification output for a specific geological domain and commodity within a block model. Includes compositing parameters (method, length, support correction), variogram model definition (type — spherical/exponential/Gaussian, nugget, sill, range for major/semi-major/minor axes, rotation angles, fitting method), search ellipse configuration, minimum and maximum samples, kriging neighbourhood, estimation method (ordinary kriging, simple kriging, inverse distance, conditional simulation), run date, operator, software version, and validation statistics (slope of regression, kriging efficiency, conditional bias, swath plots). Also captures the resulting resource classification assignment per block (JORC category, classification method, criteria thresholds such as kriging variance, search volume, data spacing, effective date). Provides complete audit trail for resource estimation reproducibility and JORC competent person sign-off. This is the SSOT for all geostatistical parameterisation and classification outputs. Sourced from Geovia GEMS.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`resource_statement` (
    `resource_statement_id` BIGINT COMMENT 'Unique identifier for the mineral resource and ore reserve statement record.',
    `block_model_id` BIGINT COMMENT 'Foreign key linking to geology.block_model. Business justification: Resource statements are derived from specific block model versions. Currently resource_statement stores block_model_version as a STRING; this should be normalized to FK to block_model.geology_block_mo',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Resource statements are prepared for capital projects to support investment decisions, financing applications, and regulatory approvals (JORC/NI 43-101 compliance). Stage gate reviews require resource',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Resource statements are commodity-specific for JORC/NI 43-101 compliance and investor reporting. Links to standardized commodity definitions for regulatory classification, pricing assumptions, and res',
    `competent_person_id` BIGINT COMMENT 'Reference to the competent person record who is responsible for this resource statement.',
    `orebody_id` BIGINT COMMENT 'Reference to the orebody for which this resource statement is prepared.',
    `previous_statement_resource_statement_id` BIGINT COMMENT 'Reference to the previous version of the resource statement that this statement supersedes, enabling version tracking and reconciliation.',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Resource statements are formal public disclosures that must reference the specific technical resource estimate(s) they report for regulatory compliance (JORC/NI 43-101/SAMREC). Currently resource_stat',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Resource statement preparation involves project costs (drilling programs, competent person fees, technical studies) tracked through WBS elements. Essential for exploration expenditure capitalization d',
    `superseded_resource_statement_id` BIGINT COMMENT 'Self-referencing FK on resource_statement (superseded_resource_statement_id)',
    `approval_date` DATE COMMENT 'Date when the resource statement was formally approved by the competent person and management for publication.',
    `change_reason` STRING COMMENT 'Explanation of the reason for changes from the previous resource statement (e.g., new drilling data, updated geological model, revised economic assumptions, depletion from mining).',
    `comments` STRING COMMENT 'Additional notes, qualifications, or commentary regarding the resource statement, including any material assumptions or limitations.',
    `commodity_price_assumption` DECIMAL(18,2) COMMENT 'Assumed long-term commodity price used in economic evaluation for reserve conversion, expressed in USD per unit (tonne, ounce, pound).',
    `competent_person_membership` STRING COMMENT 'Professional body membership of the Competent Person (e.g., AusIMM, CIM, SACNASP) that qualifies them to sign off on this statement.',
    `contained_metal_kt` DECIMAL(18,2) COMMENT 'Total contained metal in thousand tonnes (kt), calculated as tonnage multiplied by grade.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this resource statement record was first created in the system.',
    `cutoff_grade` DECIMAL(18,2) COMMENT 'Minimum economic grade threshold applied to define the resource or reserve boundary, expressed in the same unit as grade_unit.',
    `data_cutoff_date` DATE COMMENT 'Date beyond which no new drilling, sampling, or geological data was included in the resource estimate.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Percentage of waste material expected to be mixed with ore during mining operations, reducing the effective grade. Applied as a modifying factor in reserve conversion.',
    `drill_hole_count` STRING COMMENT 'Total number of drill holes used in the resource estimation for this statement.',
    `economic_assumptions_summary` STRING COMMENT 'Summary of key economic assumptions used in reserve conversion, including commodity price, exchange rate, operating cost, and capital cost assumptions.',
    `effective_date` DATE COMMENT 'The date as of which the resource or reserve estimate is valid, typically the data cutoff date for the geological model and economic assumptions.',
    `estimation_method` STRING COMMENT 'Geostatistical or interpolation method used to estimate grades in the block model (e.g., Ordinary Kriging, Inverse Distance).. Valid values are `Ordinary Kriging|Indicator Kriging|Inverse Distance|Nearest Neighbour|Multiple Indicator Kriging`',
    `grade_unit` STRING COMMENT 'Unit of measure for the grade value: percent (%), parts per million (ppm), grams per tonne (g/t), or ounces per tonne (oz/t).. Valid values are `percent|ppm|g/t|oz/t`',
    `grade_value` DECIMAL(18,2) COMMENT 'Average grade of the primary commodity in the resource or reserve, expressed in the unit specified in grade_unit.',
    `material_change_flag` BOOLEAN COMMENT 'Indicates whether this statement represents a material change from the previous published resource or reserve estimate, requiring disclosure under continuous disclosure obligations.',
    `mining_method` STRING COMMENT 'Planned or assumed mining method for extraction of the resource or reserve (e.g., Open Pit, Underground, Sub-Level Caving). [ENUM-REF-CANDIDATE: Open Pit|Underground|Sub-Level Caving|Block Caving|Longwall|Room and Pillar|In-Situ Leaching — 7 candidates stripped; promote to reference product]',
    `mining_recovery_factor` DECIMAL(18,2) COMMENT 'Percentage of in-situ resource that can be extracted during mining, accounting for mining losses and dilution. Applied as a modifying factor in reserve conversion.',
    `modifying_factors_applied` BOOLEAN COMMENT 'Indicates whether modifying factors (mining, metallurgical, economic, marketing, legal, environmental, social, governmental) have been applied to convert resource to reserve.',
    `processing_recovery_factor` DECIMAL(18,2) COMMENT 'Percentage of contained metal that can be recovered through mineral processing and beneficiation. Applied as a modifying factor in reserve conversion.',
    `publication_date` DATE COMMENT 'Date when the resource statement was publicly disclosed or filed with regulatory authorities.',
    `reporting_standard` STRING COMMENT 'The international mineral resource reporting standard under which this statement is prepared (JORC, NI 43-101, SAMREC, PERC, SEC S-K 1300, or CIM).. Valid values are `JORC|NI 43-101|SAMREC|PERC|SEC S-K 1300|CIM`',
    `reserve_classification` STRING COMMENT 'Ore reserve classification category: Proved (highest confidence, derived from Measured Resource) or Probable (derived from Indicated Resource). Not Applicable if this is a resource-only statement.. Valid values are `Proved|Probable|Not Applicable`',
    `resource_classification` STRING COMMENT 'Mineral resource classification category based on geological confidence: Measured (highest confidence), Indicated (moderate confidence), or Inferred (lowest confidence).. Valid values are `Measured|Indicated|Inferred`',
    `sample_count` STRING COMMENT 'Total number of assay samples used in the resource estimation for this statement.',
    `statement_code` STRING COMMENT 'Unique business identifier code for the resource statement, typically used in external reporting and regulatory filings.',
    `statement_name` STRING COMMENT 'Descriptive name of the resource statement, typically including orebody name and reporting period.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the resource statement in the approval and publication workflow.. Valid values are `Draft|Under Review|Approved|Published|Superseded|Withdrawn`',
    `statement_type` STRING COMMENT 'Type of statement: Mineral Resource only, Ore Reserve only, or Combined Resource and Reserve statement.. Valid values are `Mineral Resource|Ore Reserve|Combined`',
    `superseded_date` DATE COMMENT 'Date when this resource statement was replaced by a newer version. Null if this is the current active statement.',
    `tonnage_mt` DECIMAL(18,2) COMMENT 'Total tonnage of mineral resource or ore reserve in million tonnes (Mt) for this classification category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this resource statement record was last modified in the system.',
    CONSTRAINT pk_resource_statement PRIMARY KEY(`resource_statement_id`)
) COMMENT 'Consolidated JORC/NI 43-101/SAMREC-compliant mineral resource and ore reserve statement records for each orebody, capturing both resource classification (Measured, Indicated, Inferred) and reserve classification (Proved, Probable) with full modifying factors and competent person sign-off.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`orebody_permit` (
    `orebody_permit_id` BIGINT COMMENT 'Unique identifier for this orebody-permit authorization relationship. Primary key.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to the environmental permit authorizing extraction from this orebody',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to the orebody being extracted under this permit authorization',
    `compliance_status` STRING COMMENT 'Current compliance status for this specific orebody-permit relationship. Tracks whether extraction activities from this orebody are meeting the conditions of this permit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this orebody-permit authorization record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this permit authorization becomes effective for extraction from this specific orebody. May differ from the general permit effective date if orebody-specific approvals were granted later.',
    `expiry_date` DATE COMMENT 'Date on which this permit authorization expires for extraction from this specific orebody. May differ from the general permit expiry date based on orebody-specific conditions or phased extraction plans.',
    `last_compliance_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment conducted for this orebody-permit combination. Supports tracking of orebody-specific compliance audits.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this orebody-permit authorization record.',
    `monitoring_frequency` STRING COMMENT 'Required frequency for environmental monitoring activities specific to this orebody-permit combination. May differ from the general permit monitoring frequency based on orebody-specific risk factors or conditions.',
    `next_monitoring_due_date` DATE COMMENT 'Date by which the next environmental monitoring activity must be completed for this orebody-permit combination.',
    `orebody_specific_conditions` STRING COMMENT 'Free-text description of any special permit conditions that apply specifically to extraction from this orebody (e.g., seasonal restrictions, proximity to sensitive areas, specific mitigation measures).',
    `permitted_extraction_volume` DECIMAL(18,2) COMMENT 'Maximum volume or tonnage of material authorized for extraction from this specific orebody under this permit. Varies by orebody-permit combination based on environmental impact assessments and regulatory approvals.',
    `permitted_extraction_volume_unit` STRING COMMENT 'Unit of measure for the permitted extraction volume (tonnes, cubic meters, million tonnes).',
    `responsible_officer` STRING COMMENT 'Name or identifier of the individual responsible for managing compliance for this specific orebody-permit relationship.',
    CONSTRAINT pk_orebody_permit PRIMARY KEY(`orebody_permit_id`)
) COMMENT 'This association product represents the regulatory compliance relationship between an orebody and the environmental permits that govern its extraction activities. It captures permit-specific extraction limits, monitoring obligations, and compliance status for each orebody-permit combination. Each record links one orebody to one environmental permit with attributes that exist only in the context of this regulatory relationship, enabling tracking of which permits authorize extraction from which orebodies and the specific conditions that apply to each combination.. Existence Justification: In mining operations, environmental permits (covering water discharge, air emissions, waste disposal, land disturbance) are typically issued at the site or tenement level and govern extraction activities across multiple orebodies within that area. Conversely, a single orebody may be subject to multiple permits depending on the environmental aspects of its extraction (e.g., one permit for water use, another for air emissions, another for waste disposal). The business actively manages permit-orebody relationships to track extraction limits, monitoring obligations, and compliance status specific to each orebody-permit combination.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`orebody_allocation` (
    `orebody_allocation_id` BIGINT COMMENT 'Unique identifier for this orebody-to-offtake allocation record. Primary key.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to the orebody being allocated to fulfill the offtake agreement',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to the offtake agreement receiving allocated production from the orebody',
    `allocated_volume_tonnes` DECIMAL(18,2) COMMENT 'Total volume of material in metric tonnes allocated from this orebody to fulfill this specific offtake agreement. This is a commitment volume that drives mine planning and production scheduling.',
    `allocation_priority` STRING COMMENT 'Priority ranking for this allocation when multiple offtake agreements draw from the same orebody. Lower numbers indicate higher priority. Used in production scheduling and allocation optimization.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation: active (currently governing production), suspended (temporarily paused), completed (volume fully delivered), cancelled (allocation terminated before completion).',
    `blending_strategy` STRING COMMENT 'Description of the blending approach used when this orebody is combined with others to meet the offtake agreement specification. Captures operational knowledge for mine planning and metallurgical processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this orebody-to-offtake allocation becomes active and governs production planning. May differ from the offtake agreement effective date if allocations are phased.',
    `expiry_date` DATE COMMENT 'Date on which this allocation ceases to be active. Null for ongoing allocations. Used to track historical allocation strategies and support mine planning horizon analysis.',
    `product_specification` STRING COMMENT 'Specific product grade or quality specification that this orebody must meet to fulfill this offtake agreement (e.g., Fines 62% Fe, Lump 64% Fe, Coking Coal Premium). Drives blending strategies when a single orebody supplies multiple specifications or multiple orebodies blend to meet one specification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified. Supports audit trail for allocation strategy changes.',
    CONSTRAINT pk_orebody_allocation PRIMARY KEY(`orebody_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between orebodies and offtake agreements. It captures the strategic assignment of production volumes from specific orebodies to fulfill contractual commitments under offtake agreements. Each record links one orebody to one offtake agreement with attributes that govern volume commitments, priority sequencing, and product specifications that exist only in the context of this allocation relationship. This is essential for mine planning, blending strategies, and customer portfolio management in multi-orebody operations.. Existence Justification: In multi-orebody mining operations, a single orebody routinely supplies material to multiple offtake agreements to diversify customer portfolio and manage commercial risk, while a single offtake agreement frequently sources from multiple orebodies to achieve required product specifications through blending strategies. This allocation relationship is actively managed by commercial and mine planning teams as a core operational process, with explicit tracking of volume commitments, priority sequencing, and product specifications per orebody-agreement pair.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`survey_run` (
    `survey_run_id` BIGINT COMMENT 'Primary key for survey_run',
    `contractor_id` BIGINT COMMENT 'Reference to the external contractor or service provider engaged to perform the survey fieldwork, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the lead geologist responsible for planning, executing, and validating this survey run.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where this survey run was conducted.',
    `orebody_id` BIGINT COMMENT 'Reference to the specific orebody or mineral deposit being surveyed in this run.',
    `survey_campaign_id` BIGINT COMMENT 'Reference to the broader survey campaign or program that this run is part of, enabling grouping of related survey activities.',
    `rerun_survey_run_id` BIGINT COMMENT 'Self-referencing FK on survey_run (rerun_survey_run_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'The actual total cost incurred for this survey run, including all fieldwork, laboratory analysis, and reporting expenses.',
    `actual_drill_meters` DECIMAL(18,2) COMMENT 'The actual total drilling depth in meters achieved during this survey run.',
    `actual_end_date` DATE COMMENT 'The actual date when the survey run completed all fieldwork and data collection activities.',
    `actual_sample_count` STRING COMMENT 'The actual number of samples or data points collected during this survey run.',
    `actual_start_date` DATE COMMENT 'The actual date when the survey run commenced fieldwork or data collection activities.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The planned budget allocated for this survey run, including all fieldwork, laboratory analysis, and reporting costs.',
    `certification_date` DATE COMMENT 'The date when the survey run was formally certified by a competent person.',
    `certification_status` STRING COMMENT 'Indicates whether the survey run has been certified by a competent person or qualified professional as required by regulatory standards.',
    `certified_by` STRING COMMENT 'Name and credentials of the competent person or qualified professional who certified the survey run results.',
    `coordinate_system` STRING COMMENT 'The spatial reference system or coordinate system used for georeferencing survey data, such as WGS84, UTM zones, or local mine grid.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this survey run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this survey run.',
    `data_storage_location` STRING COMMENT 'The physical or digital location where raw survey data, samples, and documentation are stored for this survey run.',
    `datum` STRING COMMENT 'The geodetic datum used as the reference for elevation and positional measurements in this survey run.',
    `environmental_impact_assessment` STRING COMMENT 'Indicates whether an environmental impact assessment was required and completed for this survey run.',
    `grid_spacing_meters` DECIMAL(18,2) COMMENT 'The spacing between survey points or drill holes in meters, defining the resolution and density of the survey grid.',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this survey run record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this survey run record was last modified.',
    `notes` STRING COMMENT 'Free-text field for capturing additional observations, issues, or contextual information relevant to this survey run.',
    `planned_end_date` DATE COMMENT 'The scheduled date when the survey run is planned to complete all fieldwork and data collection activities.',
    `planned_start_date` DATE COMMENT 'The scheduled date when the survey run is planned to commence fieldwork or data collection activities.',
    `quality_assurance_level` STRING COMMENT 'The level of quality assurance and quality control protocols applied to this survey run, determining the rigor of validation and certification.',
    `safety_incidents_count` STRING COMMENT 'The number of safety incidents or near-misses recorded during the execution of this survey run.',
    `survey_run_status` STRING COMMENT 'Current lifecycle status of the survey run, indicating its operational state and readiness for downstream use.',
    `survey_method` STRING COMMENT 'The physical method or technique used to conduct the survey, such as drilling type or sampling approach.',
    `survey_purpose` STRING COMMENT 'Detailed description of the business or technical objective for conducting this survey run, such as resource estimation, grade control, or geotechnical assessment.',
    `survey_run_number` STRING COMMENT 'Business identifier for the survey run, externally visible and used for operational reference and reporting.',
    `survey_type` STRING COMMENT 'Classification of the survey run by its primary geological or operational purpose.',
    `target_drill_meters` DECIMAL(18,2) COMMENT 'The planned total drilling depth in meters to be achieved during this survey run, applicable for drilling-based surveys.',
    `target_sample_count` STRING COMMENT 'The planned number of samples or data points to be collected during this survey run.',
    `weather_conditions` STRING COMMENT 'Description of prevailing weather conditions during the survey run that may have impacted data collection quality or operational efficiency.',
    `created_by` STRING COMMENT 'The user or system identifier that created this survey run record.',
    CONSTRAINT pk_survey_run PRIMARY KEY(`survey_run_id`)
) COMMENT 'Master reference table for survey_run. Referenced by survey_run_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`geology`.`survey_campaign` (
    `survey_campaign_id` BIGINT COMMENT 'Primary key for survey_campaign',
    `parent_survey_campaign_id` BIGINT COMMENT 'Self-referencing FK on survey_campaign (parent_survey_campaign_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the survey campaign in the reporting currency.',
    `actual_drill_holes` STRING COMMENT 'Number of drill holes or survey points actually completed during the campaign.',
    `actual_end_date` DATE COMMENT 'Actual date when the survey campaign completed all field operations.',
    `actual_start_date` DATE COMMENT 'Actual date when the survey campaign commenced field operations.',
    `actual_total_meters` DECIMAL(18,2) COMMENT 'Total actual drilling or survey distance in meters completed during the campaign.',
    `assay_laboratory_id` BIGINT COMMENT 'Reference to the laboratory conducting assay analysis for samples collected during the campaign.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budgeted cost for the survey campaign in the reporting currency.',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the survey campaign, used for reference in field operations and reporting.',
    `campaign_name` STRING COMMENT 'Human-readable name of the survey campaign describing its purpose or location focus.',
    `campaign_objective` STRING COMMENT 'Detailed description of the geological objectives and expected outcomes of the survey campaign.',
    `campaign_type` STRING COMMENT 'Classification of the survey campaign based on its geological purpose and scope.',
    `contractor_id` BIGINT COMMENT 'Reference to the drilling or survey contractor engaged for the campaign.',
    `coordinate_system` STRING COMMENT 'Geographic Information System (GIS) coordinate reference system used for spatial data capture (e.g., WGS84, MGA94).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and cost amounts.',
    `data_quality_rating` STRING COMMENT 'Overall quality rating of the geological data collected during the campaign, based on QA/QC review.',
    `datum` STRING COMMENT 'Geodetic datum used as the reference frame for survey coordinates.',
    `environmental_clearance_date` DATE COMMENT 'Date when environmental clearance or approval was granted for the survey campaign.',
    `geological_domain` STRING COMMENT 'Geological domain or zone being investigated, such as lithological unit or structural domain.',
    `grid_spacing_m` DECIMAL(18,2) COMMENT 'Spacing between drill holes or survey points in meters, defining the survey density.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site where the survey campaign is conducted.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey campaign record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or comments related to the survey campaign.',
    `orebody_id` BIGINT COMMENT 'Reference to the orebody being surveyed in this campaign.',
    `planned_drill_holes` STRING COMMENT 'Number of drill holes or survey points planned for the campaign.',
    `planned_end_date` DATE COMMENT 'Scheduled date for the survey campaign to complete all field operations.',
    `planned_start_date` DATE COMMENT 'Scheduled date for the survey campaign to commence field operations.',
    `planned_total_meters` DECIMAL(18,2) COMMENT 'Total planned drilling or survey distance in meters for the campaign.',
    `project_id` BIGINT COMMENT 'Reference to the parent exploration or mining project under which this campaign is executed.',
    `quality_assurance_protocol` STRING COMMENT 'Quality assurance and quality control protocol applied to the survey campaign, including standards for sampling, logging, and assay.',
    `regulatory_approval_number` STRING COMMENT 'Government or regulatory body approval or permit number authorizing the survey campaign.',
    `responsible_geologist_id` BIGINT COMMENT 'Reference to the geologist responsible for overseeing the survey campaign.',
    `sample_recovery_percent` DECIMAL(18,2) COMMENT 'Average sample recovery rate as a percentage, indicating the quality of core or chip recovery during drilling.',
    `survey_campaign_status` STRING COMMENT 'Current lifecycle status of the survey campaign.',
    `survey_method` STRING COMMENT 'Primary geological survey or drilling method employed during the campaign.',
    `target_commodity` STRING COMMENT 'Primary mineral commodity targeted by the survey campaign.',
    `target_depth_m` DECIMAL(18,2) COMMENT 'Planned maximum depth in meters for drilling or survey penetration.',
    CONSTRAINT pk_survey_campaign PRIMARY KEY(`survey_campaign_id`)
) COMMENT 'Master reference table for survey_campaign. Referenced by survey_campaign_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ADD CONSTRAINT `fk_geology_production_drillhole_survey_production_drillhole_id` FOREIGN KEY (`production_drillhole_id`) REFERENCES `mining_ecm`.`geology`.`production_drillhole`(`production_drillhole_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ADD CONSTRAINT `fk_geology_production_drillhole_survey_survey_run_id` FOREIGN KEY (`survey_run_id`) REFERENCES `mining_ecm`.`geology`.`survey_run`(`survey_run_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_primary_superseded_by_model_block_model_id` FOREIGN KEY (`primary_superseded_by_model_block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_block_model_cell_id` FOREIGN KEY (`block_model_cell_id`) REFERENCES `mining_ecm`.`geology`.`block_model_cell`(`block_model_cell_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_production_drillhole_id` FOREIGN KEY (`production_drillhole_id`) REFERENCES `mining_ecm`.`geology`.`production_drillhole`(`production_drillhole_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_parent_wireframe_id` FOREIGN KEY (`parent_wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ADD CONSTRAINT `fk_geology_geostatistical_run_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ADD CONSTRAINT `fk_geology_geostatistical_run_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_previous_statement_resource_statement_id` FOREIGN KEY (`previous_statement_resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_superseded_resource_statement_id` FOREIGN KEY (`superseded_resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ADD CONSTRAINT `fk_geology_orebody_permit_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ADD CONSTRAINT `fk_geology_orebody_allocation_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ADD CONSTRAINT `fk_geology_survey_run_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ADD CONSTRAINT `fk_geology_survey_run_survey_campaign_id` FOREIGN KEY (`survey_campaign_id`) REFERENCES `mining_ecm`.`geology`.`survey_campaign`(`survey_campaign_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ADD CONSTRAINT `fk_geology_survey_run_rerun_survey_run_id` FOREIGN KEY (`rerun_survey_run_id`) REFERENCES `mining_ecm`.`geology`.`survey_run`(`survey_run_id`);
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` ADD CONSTRAINT `fk_geology_survey_campaign_parent_survey_campaign_id` FOREIGN KEY (`parent_survey_campaign_id`) REFERENCES `mining_ecm`.`geology`.`survey_campaign`(`survey_campaign_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`geology` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`geology` SET TAGS ('dbx_domain' = 'geology');
ALTER TABLE `mining_ecm`.`geology`.`orebody` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`orebody` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Identifier');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Identifier');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Identifier');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `alteration_type` SET TAGS ('dbx_business_glossary_term' = 'Alteration Type');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `average_grade` SET TAGS ('dbx_business_glossary_term' = 'Average Grade');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `average_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `average_grade_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|gpt|opt');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Centroid Elevation (Meters)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `contained_metal_kt` SET TAGS ('dbx_business_glossary_term' = 'Contained Metal (Thousand Tonnes)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `cutoff_grade_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|gpt|opt');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `depletion_date` SET TAGS ('dbx_business_glossary_term' = 'Depletion Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `deposit_style` SET TAGS ('dbx_business_glossary_term' = 'Deposit Style');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `environmental_sensitivity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `first_production_date` SET TAGS ('dbx_business_glossary_term' = 'First Production Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `geological_confidence` SET TAGS ('dbx_business_glossary_term' = 'Geological Confidence Category');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `geological_confidence` SET TAGS ('dbx_value_regex' = 'inferred|indicated|measured');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `geological_model_date` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `geological_model_version` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Version');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `geotechnical_domain` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Domain');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `host_lithology` SET TAGS ('dbx_business_glossary_term' = 'Host Lithology');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `metallurgical_domain` SET TAGS ('dbx_business_glossary_term' = 'Metallurgical Domain');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `mineralisation_type` SET TAGS ('dbx_business_glossary_term' = 'Mineralisation Type');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `orebody_code` SET TAGS ('dbx_business_glossary_term' = 'Orebody Code');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `orebody_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `orebody_name` SET TAGS ('dbx_business_glossary_term' = 'Orebody Name');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `orebody_status` SET TAGS ('dbx_business_glossary_term' = 'Orebody Status');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_business_glossary_term' = 'Oxidation State');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_value_regex' = 'oxide|transitional|fresh_sulphide|mixed');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'no_reserve|probable|proved|mixed');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `spatial_extent_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Spatial Extent Area (Square Meters)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `structural_control` SET TAGS ('dbx_business_glossary_term' = 'Structural Control');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `tonnage_estimate_mt` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Estimate (Million Tonnes)');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`orebody` ALTER COLUMN `vertical_extent_m` SET TAGS ('dbx_business_glossary_term' = 'Vertical Extent (Meters)');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit ID');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `alteration_type` SET TAGS ('dbx_business_glossary_term' = 'Alteration Type');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `colour_code_hex` SET TAGS ('dbx_business_glossary_term' = 'Colour Code (Hexadecimal)');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `colour_code_hex` SET TAGS ('dbx_value_regex' = '^#[0-9A-Fa-f]{6}$');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `colour_code_rgb` SET TAGS ('dbx_business_glossary_term' = 'Colour Code (Red Green Blue)');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `colour_code_rgb` SET TAGS ('dbx_value_regex' = '^d{1,3},d{1,3},d{1,3}$');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `density_g_cm3` SET TAGS ('dbx_business_glossary_term' = 'Density (g/cm³)');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `depositional_environment` SET TAGS ('dbx_business_glossary_term' = 'Depositional Environment');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `geological_age` SET TAGS ('dbx_business_glossary_term' = 'Geological Age');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `geological_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Status');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `geological_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `geotechnical_domain` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Domain');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `hardness_classification` SET TAGS ('dbx_business_glossary_term' = 'Hardness Classification');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `hardness_classification` SET TAGS ('dbx_value_regex' = 'soft|medium|hard|very_hard');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `lithology_description` SET TAGS ('dbx_business_glossary_term' = 'Lithology Description');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Notes');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `ore_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Ore Bearing Flag');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `parent_formation` SET TAGS ('dbx_business_glossary_term' = 'Parent Formation Name');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `primary_mineralogy` SET TAGS ('dbx_business_glossary_term' = 'Primary Mineralogy');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `processing_domain` SET TAGS ('dbx_business_glossary_term' = 'Processing Domain');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `recovery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate (Percent)');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `structural_setting` SET TAGS ('dbx_business_glossary_term' = 'Structural Setting');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `typical_grade_range` SET TAGS ('dbx_business_glossary_term' = 'Typical Grade Range');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Code');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Name');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Type');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'lithological|stratigraphic|structural|alteration|weathering|intrusive');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `weathering_state` SET TAGS ('dbx_business_glossary_term' = 'Weathering State');
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ALTER COLUMN `weathering_state` SET TAGS ('dbx_value_regex' = 'fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `production_drillhole_id` SET TAGS ('dbx_business_glossary_term' = 'Production Drillhole Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Rig Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Geologist Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `azimuth` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Azimuth');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `collar_easting` SET TAGS ('dbx_business_glossary_term' = 'Collar Easting Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `collar_northing` SET TAGS ('dbx_business_glossary_term' = 'Collar Northing Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `collar_rl` SET TAGS ('dbx_business_glossary_term' = 'Collar Reduced Level (RL) Elevation');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Comments');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Drilling Completion Date');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `core_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Core Diameter (Millimeters)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `datum` SET TAGS ('dbx_business_glossary_term' = 'Elevation Datum');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `dip` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Dip');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `driller_name` SET TAGS ('dbx_business_glossary_term' = 'Driller Name');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `drilling_contractor` SET TAGS ('dbx_business_glossary_term' = 'Drilling Contractor Name');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `hole_purpose` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Purpose');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `hole_purpose` SET TAGS ('dbx_value_regex' = 'Exploration|Resource Definition|Grade Control|Geotechnical|Hydrogeological|Condemnation');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `hole_status` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Status');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `hole_type` SET TAGS ('dbx_business_glossary_term' = 'Drillhole Type');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `hole_type` SET TAGS ('dbx_value_regex' = 'RC|Diamond|RAB|AC|Rotary|Percussion');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `is_assayed` SET TAGS ('dbx_business_glossary_term' = 'Assay Completed Flag');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `is_surveyed` SET TAGS ('dbx_business_glossary_term' = 'Downhole Survey Completed Flag');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `jorc_category` SET TAGS ('dbx_business_glossary_term' = 'Joint Ore Reserves Committee (JORC) Resource Category');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `jorc_category` SET TAGS ('dbx_value_regex' = 'Measured|Indicated|Inferred|Exploration|Non-JORC');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `logged_date` SET TAGS ('dbx_business_glossary_term' = 'Geological Logging Date');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `planned_depth` SET TAGS ('dbx_business_glossary_term' = 'Planned Drillhole Depth');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Core Recovery Percentage');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `sample_interval_m` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval (Meters)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Drilling Start Date');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Downhole Survey Method');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'Gyroscopic|Magnetic|Electronic Multi-Shot|Single Shot|Optical|Downhole Camera');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ALTER COLUMN `total_depth` SET TAGS ('dbx_business_glossary_term' = 'Total Drillhole Depth');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `production_drillhole_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Production Drillhole Survey ID');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole ID');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `production_drillhole_id` SET TAGS ('dbx_business_glossary_term' = 'Production Drillhole Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_run_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Run ID');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `azimuth_degrees` SET TAGS ('dbx_business_glossary_term' = 'Azimuth (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Survey Comments');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `correction_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Correction Applied Flag');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `correction_factor` SET TAGS ('dbx_business_glossary_term' = 'Correction Factor');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `depth_metres` SET TAGS ('dbx_business_glossary_term' = 'Depth (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `dip_degrees` SET TAGS ('dbx_business_glossary_term' = 'Dip (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `easting_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Easting Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `elevation_rl` SET TAGS ('dbx_business_glossary_term' = 'Elevation Reduced Level (RL)');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `gravity_field_strength` SET TAGS ('dbx_business_glossary_term' = 'Gravity Field Strength');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `magnetic_dip_angle` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Dip Angle');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `magnetic_field_strength` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Field Strength');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `northing_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Northing Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Status');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|under_review');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_instrument` SET TAGS ('dbx_business_glossary_term' = 'Survey Instrument');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'gyroscopic|magnetic|electronic_multi_shot|single_shot|north_seeking_gyro|acid_bottle');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Quality Code');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_quality_code` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|poor|rejected');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `survey_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Sequence Number');
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `lithology_log_id` SET TAGS ('dbx_business_glossary_term' = 'Lithology Log Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Logging Geologist Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `alteration_intensity` SET TAGS ('dbx_business_glossary_term' = 'Alteration Intensity');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `alteration_intensity` SET TAGS ('dbx_value_regex' = 'none|weak|moderate|strong|pervasive');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `alteration_type` SET TAGS ('dbx_business_glossary_term' = 'Alteration Type');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `colour` SET TAGS ('dbx_business_glossary_term' = 'Rock Colour');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Logging Comments');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `grain_size` SET TAGS ('dbx_business_glossary_term' = 'Grain Size');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `grain_size` SET TAGS ('dbx_value_regex' = 'very_fine|fine|medium|coarse|very_coarse');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `hardness` SET TAGS ('dbx_business_glossary_term' = 'Rock Hardness');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `hardness` SET TAGS ('dbx_value_regex' = 'very_soft|soft|medium|hard|very_hard');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `interval_from_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Interval From Depth (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `interval_length_m` SET TAGS ('dbx_business_glossary_term' = 'Interval Length (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `interval_to_depth_m` SET TAGS ('dbx_business_glossary_term' = 'Interval To Depth (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `lithology_code` SET TAGS ('dbx_business_glossary_term' = 'Lithology Code');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `lithology_description` SET TAGS ('dbx_business_glossary_term' = 'Lithology Description');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `logging_date` SET TAGS ('dbx_business_glossary_term' = 'Logging Date');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `logging_method` SET TAGS ('dbx_business_glossary_term' = 'Logging Method');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `logging_method` SET TAGS ('dbx_value_regex' = 'visual|digital|photographic');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `mineralisation_type` SET TAGS ('dbx_business_glossary_term' = 'Mineralisation Type');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `mineralisation_type` SET TAGS ('dbx_value_regex' = 'none|disseminated|vein|massive|stockwork|breccia');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_business_glossary_term' = 'Oxidation State');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_value_regex' = 'oxide|transitional|fresh_sulphide');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `primary_mineral` SET TAGS ('dbx_business_glossary_term' = 'Primary Mineral');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `qaqc_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Comments');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Status');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|requires_review');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Core Recovery Percentage');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `rock_type_code` SET TAGS ('dbx_business_glossary_term' = 'Rock Type Code');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `rock_type_description` SET TAGS ('dbx_business_glossary_term' = 'Rock Type Description');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `rqd_percent` SET TAGS ('dbx_business_glossary_term' = 'Rock Quality Designation (RQD) Percentage');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `secondary_mineral` SET TAGS ('dbx_business_glossary_term' = 'Secondary Mineral');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `structure` SET TAGS ('dbx_business_glossary_term' = 'Rock Structure');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `sulphide_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulphide Percentage');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `texture` SET TAGS ('dbx_business_glossary_term' = 'Rock Texture');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `vein_type` SET TAGS ('dbx_business_glossary_term' = 'Vein Type');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `veining_percent` SET TAGS ('dbx_business_glossary_term' = 'Veining Percentage');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `weathering_degree` SET TAGS ('dbx_business_glossary_term' = 'Weathering Degree');
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ALTER COLUMN `weathering_degree` SET TAGS ('dbx_value_regex' = 'fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `structural_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Structural Measurement Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Geologist Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `alpha_angle` SET TAGS ('dbx_business_glossary_term' = 'Alpha Angle (degrees)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `alteration_type` SET TAGS ('dbx_business_glossary_term' = 'Alteration Type');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `beta_angle` SET TAGS ('dbx_business_glossary_term' = 'Beta Angle (degrees)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'internal|confidential');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `dip` SET TAGS ('dbx_business_glossary_term' = 'Dip (degrees)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `dip_direction` SET TAGS ('dbx_business_glossary_term' = 'Dip Direction (degrees)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `easting` SET TAGS ('dbx_business_glossary_term' = 'Easting Coordinate (meters)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `elevation` SET TAGS ('dbx_business_glossary_term' = 'Elevation (meters)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `feature_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Description');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `feature_thickness` SET TAGS ('dbx_business_glossary_term' = 'Feature Thickness (millimeters)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `geomechanical_significance` SET TAGS ('dbx_business_glossary_term' = 'Geomechanical Significance');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `geomechanical_significance` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `infill_material` SET TAGS ('dbx_business_glossary_term' = 'Infill Material');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_depth_from` SET TAGS ('dbx_business_glossary_term' = 'Measurement Depth From (meters)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_depth_to` SET TAGS ('dbx_business_glossary_term' = 'Measurement Depth To (meters)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'compass_clinometer|oriented_core|photogrammetry|lidar|digital_compass');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'drillhole_core|surface_mapping|underground_mapping|outcrop|trench');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `mineralisation_association` SET TAGS ('dbx_business_glossary_term' = 'Mineralisation Association');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `mineralisation_association` SET TAGS ('dbx_value_regex' = 'yes|no|possible');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `northing` SET TAGS ('dbx_business_glossary_term' = 'Northing Coordinate (meters)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `quality_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Quality Code');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `quality_code` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `roughness` SET TAGS ('dbx_business_glossary_term' = 'Surface Roughness');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `roughness` SET TAGS ('dbx_value_regex' = 'smooth|slightly_rough|rough|very_rough|stepped|irregular');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `strike` SET TAGS ('dbx_business_glossary_term' = 'Strike (degrees)');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `structural_domain` SET TAGS ('dbx_business_glossary_term' = 'Structural Domain');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `structural_feature_type` SET TAGS ('dbx_business_glossary_term' = 'Structural Feature Type');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `structural_feature_type` SET TAGS ('dbx_value_regex' = 'fault|fold|joint|shear_zone|vein|foliation');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `weathering_state` SET TAGS ('dbx_business_glossary_term' = 'Weathering State');
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ALTER COLUMN `weathering_state` SET TAGS ('dbx_value_regex' = 'fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `geotechnical_log_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Log ID');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Identifier');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Logged By Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Comments');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `core_recovery_percent` SET TAGS ('dbx_business_glossary_term' = 'Core Recovery Percentage');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'geovia_gems|labware_lims|manual_entry|import');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `density_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Density Measurement Method');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `density_measurement_method` SET TAGS ('dbx_value_regex' = 'water_immersion|wax_coated|pycnometer|caliper|other');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `depth_from` SET TAGS ('dbx_business_glossary_term' = 'Depth From (meters)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `depth_to` SET TAGS ('dbx_business_glossary_term' = 'Depth To (meters)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `dry_bulk_density` SET TAGS ('dbx_business_glossary_term' = 'Dry Bulk Density (t/m³)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `fracture_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fracture Frequency (fractures per meter)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `geomechanical_domain` SET TAGS ('dbx_business_glossary_term' = 'Geomechanical Domain Code');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `geomechanical_domain` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `interval_length` SET TAGS ('dbx_business_glossary_term' = 'Interval Length (meters)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `logging_date` SET TAGS ('dbx_business_glossary_term' = 'Logging Date');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_business_glossary_term' = 'Oxidation and Weathering State');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_value_regex' = 'fresh|slightly_weathered|moderately_weathered|highly_weathered|completely_weathered|residual_soil');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `point_load_index_mpa` SET TAGS ('dbx_business_glossary_term' = 'Point Load Index (Is50) in Megapascals');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `porosity_percent` SET TAGS ('dbx_business_glossary_term' = 'Porosity Percentage');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `q_index` SET TAGS ('dbx_business_glossary_term' = 'Q-Index (Rock Mass Quality)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `qaqc_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Flag');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Status');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|flagged|verified');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `rmr_rating` SET TAGS ('dbx_business_glossary_term' = 'Rock Mass Rating (RMR)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `rqd_percent` SET TAGS ('dbx_business_glossary_term' = 'Rock Quality Designation (RQD) Percentage');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,30}$');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity (SG)');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `ucs_mpa` SET TAGS ('dbx_business_glossary_term' = 'Unconfined Compressive Strength (UCS) in Megapascals');
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ALTER COLUMN `wet_bulk_density` SET TAGS ('dbx_business_glossary_term' = 'Wet Bulk Density (t/m³)');
ALTER TABLE `mining_ecm`.`geology`.`block_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`block_model` SET TAGS ('dbx_subdomain' = 'estimation_modeling');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Identifier');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person ID');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `orebody_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `primary_superseded_by_model_block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Block Model ID');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `data_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Data Cutoff Date');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `datum` SET TAGS ('dbx_business_glossary_term' = 'Geodetic Datum');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `drill_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Count');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Grade Estimation Method');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `estimation_software` SET TAGS ('dbx_business_glossary_term' = 'Estimation Software');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `extent_x` SET TAGS ('dbx_business_glossary_term' = 'Block Model Extent X Dimension');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `extent_y` SET TAGS ('dbx_business_glossary_term' = 'Block Model Extent Y Dimension');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `extent_z` SET TAGS ('dbx_business_glossary_term' = 'Block Model Extent Z Dimension');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `key_changes_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Changes Summary');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Block Model Code');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Block Model Name');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Block Model Status');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|draft|under_review|approved');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `origin_x` SET TAGS ('dbx_business_glossary_term' = 'Block Model Origin X Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `origin_y` SET TAGS ('dbx_business_glossary_term' = 'Block Model Origin Y Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `origin_z` SET TAGS ('dbx_business_glossary_term' = 'Block Model Origin Z Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `parent_block_size_x` SET TAGS ('dbx_business_glossary_term' = 'Parent Block Size X Dimension');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `parent_block_size_y` SET TAGS ('dbx_business_glossary_term' = 'Parent Block Size Y Dimension');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `parent_block_size_z` SET TAGS ('dbx_business_glossary_term' = 'Parent Block Size Z Dimension');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `rotation_angle` SET TAGS ('dbx_business_glossary_term' = 'Block Model Rotation Angle');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `sub_block_configuration` SET TAGS ('dbx_business_glossary_term' = 'Sub-block Configuration');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `sub_blocking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Sub-blocking Enabled Flag');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `total_block_count` SET TAGS ('dbx_business_glossary_term' = 'Total Block Count');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `update_reason` SET TAGS ('dbx_business_glossary_term' = 'Model Update Reason');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `version_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `version_identifier` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `mining_ecm`.`geology`.`block_model` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Block Model Creation Date');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` SET TAGS ('dbx_subdomain' = 'estimation_modeling');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `block_model_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Cell Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `geological_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `pit_design_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Shell Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `block_dimension_x` SET TAGS ('dbx_business_glossary_term' = 'Block Dimension X (Width)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `block_dimension_y` SET TAGS ('dbx_business_glossary_term' = 'Block Dimension Y (Length)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `block_dimension_z` SET TAGS ('dbx_business_glossary_term' = 'Block Dimension Z (Height)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `block_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Block Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `centroid_x` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid X Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `centroid_y` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Y Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `centroid_z` SET TAGS ('dbx_business_glossary_term' = 'Block Centroid Z Coordinate (Elevation)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `cut_off_grade_applied` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Applied');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `density_t_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (Tonnes per Cubic Meter)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Grade Estimation Method');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'ordinary_kriging|inverse_distance|nearest_neighbor|indicator_kriging|multiple_indicator_kriging');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `estimation_pass` SET TAGS ('dbx_business_glossary_term' = 'Estimation Pass Number');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_au_g_per_t` SET TAGS ('dbx_business_glossary_term' = 'Gold (Au) Grade (Grams per Tonne)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_coal_ash_pct` SET TAGS ('dbx_business_glossary_term' = 'Coal Ash Content Percentage');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_coal_sulfur_pct` SET TAGS ('dbx_business_glossary_term' = 'Coal Sulfur Content Percentage');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_cu_ppm` SET TAGS ('dbx_business_glossary_term' = 'Copper (Cu) Grade (Parts Per Million)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_fe_pct` SET TAGS ('dbx_business_glossary_term' = 'Iron (Fe) Grade Percentage');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_li_ppm` SET TAGS ('dbx_business_glossary_term' = 'Lithium (Li) Grade (Parts Per Million)');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `grade_ni_pct` SET TAGS ('dbx_business_glossary_term' = 'Nickel (Ni) Grade Percentage');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `kriging_variance` SET TAGS ('dbx_business_glossary_term' = 'Kriging Variance');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `mining_method_flag` SET TAGS ('dbx_business_glossary_term' = 'Mining Method Flag');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `mining_phase` SET TAGS ('dbx_business_glossary_term' = 'Mining Phase');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `mining_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Mining Recovery Factor');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Block Model Version');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `number_of_samples` SET TAGS ('dbx_business_glossary_term' = 'Number of Samples Used');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `ore_waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Ore Waste Classification');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `ore_waste_classification` SET TAGS ('dbx_value_regex' = 'ore|waste|low_grade|marginal|overburden|gangue');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_business_glossary_term' = 'Oxidation State');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `oxidation_state` SET TAGS ('dbx_value_regex' = 'oxide|transitional|fresh|supergene|hypogene');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `processing_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Processing Recovery Factor');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `reserve_category` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Category');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `reserve_category` SET TAGS ('dbx_value_regex' = 'proved|probable|not_reserve|unclassified');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `resource_category` SET TAGS ('dbx_business_glossary_term' = 'Mineral Resource Category');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `resource_category` SET TAGS ('dbx_value_regex' = 'measured|indicated|inferred|unclassified');
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ALTER COLUMN `tonnage` SET TAGS ('dbx_business_glossary_term' = 'Block Tonnage');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `grade_control_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `blast_pattern_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Pattern Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `block_model_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Cell Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Rig Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Geologist Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `production_drillhole_id` SET TAGS ('dbx_business_glossary_term' = 'Hole Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `al2o3_percent` SET TAGS ('dbx_business_glossary_term' = 'Alumina (Al2O3) Percentage (%)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `assay_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assay Completion Date');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `assay_method` SET TAGS ('dbx_business_glossary_term' = 'Assay Method');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `au_g_per_t` SET TAGS ('dbx_business_glossary_term' = 'Gold (Au) Grams Per Tonne (g/t)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `bench` SET TAGS ('dbx_business_glossary_term' = 'Mining Bench');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `block_model_grade` SET TAGS ('dbx_business_glossary_term' = 'Block Model Predicted Grade');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Sample Comments');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `cu_ppm` SET TAGS ('dbx_business_glossary_term' = 'Copper (Cu) Parts Per Million (ppm)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `easting` SET TAGS ('dbx_business_glossary_term' = 'Easting Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `elevation_rl` SET TAGS ('dbx_business_glossary_term' = 'Reduced Level (RL) Elevation');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `fe_percent` SET TAGS ('dbx_business_glossary_term' = 'Iron (Fe) Percentage (%)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `geologist_sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Geologist Sign-Off Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `grade_variance` SET TAGS ('dbx_business_glossary_term' = 'Grade Variance');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `interval_length` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval Length');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `material_destination` SET TAGS ('dbx_business_glossary_term' = 'Material Destination');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `material_destination` SET TAGS ('dbx_value_regex' = 'crusher|rom_pad|stockpile|waste_dump');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `mining_block` SET TAGS ('dbx_business_glossary_term' = 'Mining Block');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `northing` SET TAGS ('dbx_business_glossary_term' = 'Northing Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `ore_type` SET TAGS ('dbx_business_glossary_term' = 'Ore Type Classification');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `p_percent` SET TAGS ('dbx_business_glossary_term' = 'Phosphorus (P) Percentage (%)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `pit_name` SET TAGS ('dbx_business_glossary_term' = 'Pit Name');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QAQC) Status');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `s_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur (S) Percentage (%)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_interval_from` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval From Depth');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_interval_to` SET TAGS ('dbx_business_glossary_term' = 'Sample Interval To Depth');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_value_regex' = 'collected|submitted|assayed|validated|reconciled|rejected');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'blast_hole|channel|trench|face|chip|grab');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sample_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight in Kilograms (kg)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `sio2_percent` SET TAGS ('dbx_business_glossary_term' = 'Silica (SiO2) Percentage (%)');
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `average_grade` SET TAGS ('dbx_business_glossary_term' = 'Average Grade within Domain');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `bulk_density` SET TAGS ('dbx_business_glossary_term' = 'Bulk Density (Tonnes per Cubic Meter)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Primary Commodity');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `cut_off_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade (Minimum Economic Grade)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `cut_off_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `domain_code` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Code');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `domain_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `domain_name` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Name');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `domain_type` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Type');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `domain_type` SET TAGS ('dbx_value_regex' = 'lithological|structural|alteration|grade|oxidation|mineralization');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `domain_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Domain Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Domain Effective Date');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `estimation_constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Estimation Constraint Type');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `estimation_constraint_type` SET TAGS ('dbx_value_regex' = 'hard|soft|transitional');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `geological_confidence` SET TAGS ('dbx_business_glossary_term' = 'Geological Confidence Level');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `geological_confidence` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `geological_domain_status` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Status');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `geological_domain_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|under_review');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `grade_variance` SET TAGS ('dbx_business_glossary_term' = 'Grade Variance within Domain');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `maximum_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Sample Count for Estimation');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `minimum_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Sample Count for Estimation');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Version');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,30}$');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Notes');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `resource_category` SET TAGS ('dbx_business_glossary_term' = 'Mineral Resource Category (JORC)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `resource_category` SET TAGS ('dbx_value_regex' = 'inferred|indicated|measured');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Total Sample Count in Domain');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `search_ellipsoid_azimuth_deg` SET TAGS ('dbx_business_glossary_term' = 'Search Ellipsoid Azimuth (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `search_ellipsoid_dip_deg` SET TAGS ('dbx_business_glossary_term' = 'Search Ellipsoid Dip (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `search_ellipsoid_plunge_deg` SET TAGS ('dbx_business_glossary_term' = 'Search Ellipsoid Plunge (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Domain Superseded Date');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_model_type` SET TAGS ('dbx_business_glossary_term' = 'Variogram Model Type');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_model_type` SET TAGS ('dbx_value_regex' = 'spherical|exponential|gaussian|power|nugget_effect');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_nugget_effect` SET TAGS ('dbx_business_glossary_term' = 'Variogram Nugget Effect');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_range_major_m` SET TAGS ('dbx_business_glossary_term' = 'Variogram Range Major Axis (Meters)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_range_minor_m` SET TAGS ('dbx_business_glossary_term' = 'Variogram Range Minor Axis (Meters)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_range_semi_major_m` SET TAGS ('dbx_business_glossary_term' = 'Variogram Range Semi-Major Axis (Meters)');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `variogram_sill` SET TAGS ('dbx_business_glossary_term' = 'Variogram Sill Value');
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ALTER COLUMN `wireframe_reference` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Reference Identifier');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `wireframe_id` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `parent_wireframe_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Wireframe Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `centroid_easting` SET TAGS ('dbx_business_glossary_term' = 'Centroid Easting Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `centroid_elevation_rl` SET TAGS ('dbx_business_glossary_term' = 'Centroid Elevation Reduced Level (RL)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `centroid_northing` SET TAGS ('dbx_business_glossary_term' = 'Centroid Northing Coordinate');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `creation_method` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Creation Method');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `creation_method` SET TAGS ('dbx_value_regex' = 'manual_interpretation|implicit_modelling|explicit_modelling|kriging|triangulation|digitization');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `datum` SET TAGS ('dbx_business_glossary_term' = 'Geodetic Datum');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `drill_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Count');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `interpretation_confidence` SET TAGS ('dbx_business_glossary_term' = 'Interpretation Confidence Level');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `interpretation_confidence` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `is_closed_solid` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Solid Flag');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `maximum_elevation_rl` SET TAGS ('dbx_business_glossary_term' = 'Maximum Elevation Reduced Level (RL)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `minimum_elevation_rl` SET TAGS ('dbx_business_glossary_term' = 'Minimum Elevation Reduced Level (RL)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Geological Model Version');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `modelling_software` SET TAGS ('dbx_business_glossary_term' = 'Modelling Software');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `projection_zone` SET TAGS ('dbx_business_glossary_term' = 'Projection Zone');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `surface_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Surface Area (Square Metres)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `triangle_count` SET TAGS ('dbx_business_glossary_term' = 'Triangle Count');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|validated|approved|superseded|archived');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `vertex_count` SET TAGS ('dbx_business_glossary_term' = 'Vertex Count');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Metres)');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `wireframe_code` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Code');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `wireframe_name` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Name');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `wireframe_type` SET TAGS ('dbx_business_glossary_term' = 'Wireframe Type');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `wireframe_type` SET TAGS ('dbx_value_regex' = 'solid|surface|DTM|fault|contact|alteration');
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` SET TAGS ('dbx_subdomain' = 'estimation_modeling');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `geostatistical_run_id` SET TAGS ('dbx_business_glossary_term' = 'Geostatistical Run Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Identifier (ID)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Run Comments');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,4}$');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `composite_length_metres` SET TAGS ('dbx_business_glossary_term' = 'Composite Length (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `compositing_method` SET TAGS ('dbx_business_glossary_term' = 'Compositing Method');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `compositing_method` SET TAGS ('dbx_value_regex' = 'fixed_length|variable_length|bench_composite|geological_composite|downhole_composite');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `conditional_bias` SET TAGS ('dbx_business_glossary_term' = 'Conditional Bias');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification Effective Date');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `indicated_kriging_variance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Indicated Resource Kriging Variance Threshold');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `kriging_efficiency` SET TAGS ('dbx_business_glossary_term' = 'Kriging Efficiency');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `maximum_samples` SET TAGS ('dbx_business_glossary_term' = 'Maximum Samples');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `maximum_samples_per_drillhole` SET TAGS ('dbx_business_glossary_term' = 'Maximum Samples Per Drillhole');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `measured_kriging_variance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Measured Resource Kriging Variance Threshold');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `minimum_samples` SET TAGS ('dbx_business_glossary_term' = 'Minimum Samples');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `resource_classification_method` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification Method');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `resource_classification_method` SET TAGS ('dbx_value_regex' = 'kriging_variance|search_pass|data_spacing|slope_of_regression|combined_criteria');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Execution Date');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Geostatistical Run Name');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `search_ellipse_major_metres` SET TAGS ('dbx_business_glossary_term' = 'Search Ellipse Major Axis (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `search_ellipse_minor_metres` SET TAGS ('dbx_business_glossary_term' = 'Search Ellipse Minor Axis (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `search_ellipse_semi_major_metres` SET TAGS ('dbx_business_glossary_term' = 'Search Ellipse Semi-Major Axis (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `search_pass_count` SET TAGS ('dbx_business_glossary_term' = 'Search Pass Count');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `slope_of_regression` SET TAGS ('dbx_business_glossary_term' = 'Slope of Regression');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `software_name` SET TAGS ('dbx_business_glossary_term' = 'Geostatistical Software Name');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `top_cut_grade` SET TAGS ('dbx_business_glossary_term' = 'Top Cut Grade');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_azimuth_degrees` SET TAGS ('dbx_business_glossary_term' = 'Variogram Azimuth (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_dip_degrees` SET TAGS ('dbx_business_glossary_term' = 'Variogram Dip (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_model_type` SET TAGS ('dbx_business_glossary_term' = 'Variogram Model Type');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_nugget` SET TAGS ('dbx_business_glossary_term' = 'Variogram Nugget Effect');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_plunge_degrees` SET TAGS ('dbx_business_glossary_term' = 'Variogram Plunge (Degrees)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_range_major_metres` SET TAGS ('dbx_business_glossary_term' = 'Variogram Range Major Axis (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_range_minor_metres` SET TAGS ('dbx_business_glossary_term' = 'Variogram Range Minor Axis (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_range_semi_major_metres` SET TAGS ('dbx_business_glossary_term' = 'Variogram Range Semi-Major Axis (Metres)');
ALTER TABLE `mining_ecm`.`geology`.`geostatistical_run` ALTER COLUMN `variogram_sill` SET TAGS ('dbx_business_glossary_term' = 'Variogram Sill');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement ID');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `block_model_id` SET TAGS ('dbx_business_glossary_term' = 'Block Model Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person ID');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody ID');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `previous_statement_resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Statement ID');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `superseded_resource_statement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `commodity_price_assumption` SET TAGS ('dbx_business_glossary_term' = 'Commodity Price Assumption');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `commodity_price_assumption` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `competent_person_membership` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Professional Membership');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `contained_metal_kt` SET TAGS ('dbx_business_glossary_term' = 'Contained Metal (Thousand Tonnes)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `cutoff_grade` SET TAGS ('dbx_business_glossary_term' = 'Cut-off Grade');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `data_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Data Cut-off Date');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor (Percent)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `drill_hole_count` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Count');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `economic_assumptions_summary` SET TAGS ('dbx_business_glossary_term' = 'Economic Assumptions Summary');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'Ordinary Kriging|Indicator Kriging|Inverse Distance|Nearest Neighbour|Multiple Indicator Kriging');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Grade Unit');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `grade_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|g/t|oz/t');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `grade_value` SET TAGS ('dbx_business_glossary_term' = 'Grade Value');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `material_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Change Flag');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `mining_method` SET TAGS ('dbx_business_glossary_term' = 'Mining Method');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `mining_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Mining Recovery Factor (Percent)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `modifying_factors_applied` SET TAGS ('dbx_business_glossary_term' = 'Modifying Factors Applied Flag');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `processing_recovery_factor` SET TAGS ('dbx_business_glossary_term' = 'Processing Recovery Factor (Percent)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC|NI 43-101|SAMREC|PERC|SEC S-K 1300|CIM');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `reserve_classification` SET TAGS ('dbx_business_glossary_term' = 'Reserve Classification');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `reserve_classification` SET TAGS ('dbx_value_regex' = 'Proved|Probable|Not Applicable');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `resource_classification` SET TAGS ('dbx_business_glossary_term' = 'Resource Classification');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `resource_classification` SET TAGS ('dbx_value_regex' = 'Measured|Indicated|Inferred');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `statement_code` SET TAGS ('dbx_business_glossary_term' = 'Statement Code');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `statement_name` SET TAGS ('dbx_business_glossary_term' = 'Statement Name');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Published|Superseded|Withdrawn');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'Mineral Resource|Ore Reserve|Combined');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `tonnage_mt` SET TAGS ('dbx_business_glossary_term' = 'Tonnage (Million Tonnes)');
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` SET TAGS ('dbx_association_edges' = 'geology.orebody,hse.environmental_permit');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `orebody_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Permit Identifier');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Permit - Environmental Permit Id');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Permit - Orebody Id');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `next_monitoring_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Due Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `orebody_specific_conditions` SET TAGS ('dbx_business_glossary_term' = 'Orebody Specific Conditions');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `permitted_extraction_volume` SET TAGS ('dbx_business_glossary_term' = 'Permitted Extraction Volume');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `permitted_extraction_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Permitted Extraction Volume Unit');
ALTER TABLE `mining_ecm`.`geology`.`orebody_permit` ALTER COLUMN `responsible_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` SET TAGS ('dbx_subdomain' = 'resource_characterization');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` SET TAGS ('dbx_association_edges' = 'geology.orebody,sales.offtake_agreement');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `orebody_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Allocation Identifier');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Allocation - Orebody Id');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Allocation - Sales Offtake Agreement Id');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `allocated_volume_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `blending_strategy` SET TAGS ('dbx_business_glossary_term' = 'Blending Strategy');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `product_specification` SET TAGS ('dbx_business_glossary_term' = 'Product Specification');
ALTER TABLE `mining_ecm`.`geology`.`orebody_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `mining_ecm`.`geology`.`survey_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`survey_run` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ALTER COLUMN `survey_run_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Run Identifier');
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ALTER COLUMN `rerun_survey_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`survey_run` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` SET TAGS ('dbx_subdomain' = 'drilling_operations');
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` ALTER COLUMN `survey_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Campaign Identifier');
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` ALTER COLUMN `parent_survey_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`geology`.`survey_campaign` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
