-- Schema for Domain: wastewater | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`wastewater` COMMENT 'Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` (
    `sewer_network_id` BIGINT COMMENT 'Unique identifier for the sewer network segment. Primary key for the sewer network master topology.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Sewer segments are installed/rehabilitated via CIP projects. Link enables as-built drawing retrieval, installation year validation, capitalization tracking, and condition assessment baseline establish',
    `compliance_permit_id` BIGINT COMMENT 'National Pollutant Discharge Elimination System (NPDES) permit identifier if this segment is subject to specific discharge monitoring or CSO/SSO reporting requirements.',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Sewer pipe segments are installed or rehabilitated under construction contracts. Warranty claims, as-built documentation, and contractor defect liability tracking all require knowing which constructio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sewer network O&M costs (cleaning, lining, root cutting, emergency repairs) are tracked by cost center for annual budget management, rate case O&M expense justification, and regulatory cost reporting.',
    `dma_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) to which this sewer segment belongs. Used for I&I (Inflow and Infiltration) monitoring and flow metering analysis.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Major sewer segments meeting capitalization thresholds are tracked as fixed assets for GASB 34 depreciation, net book value calculation, rate base determination, and asset valuation for rate cases.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Sewer rehabilitation projects specify pipe, lining, and grout materials by material master records. Linking segments to installed materials enables accurate inventory forecasting for capital projects,',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: A service point (lateral connection) drains into a sewer network segment. This link is fundamental for SSO impact analysis, capacity planning, and identifying which customer connections are affected b',
    `manhole_id` BIGINT COMMENT 'Identifier of the manhole or node at the upstream end of the sewer segment. Establishes network topology for hydraulic modeling and GIS routing.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Sewer pipe segments are capital assets registered in the asset registry for lifecycle management, depreciation, CIP prioritization, and condition tracking. Asset managers expect every infrastructure s',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Sewer network segments are physically located within a service territory. Territory-level capacity planning, NPDES jurisdiction reporting, and rate case filings require knowing which territory each se',
    `wwtp_id` BIGINT COMMENT 'Identifier of the Wastewater Treatment Plant (WWTP) that receives flow from this sewer segment. Supports load allocation and treatment capacity planning.',
    `asset_tag` STRING COMMENT 'Physical asset tag or barcode identifier affixed to the segment or associated manhole for field identification and work order tracking in IBM Maximo.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily wastewater flow through the segment in Million Gallons per Day (MGD). Used for load balancing and treatment plant influent forecasting.',
    `condition_grade` STRING COMMENT 'Current physical condition assessment of the sewer segment based on CCTV inspection, PACP (Pipeline Assessment and Certification Program) scoring, or field evaluation. Drives maintenance and replacement decisions.. Valid values are `excellent|good|fair|poor|critical`',
    `coordinate_system` STRING COMMENT 'Spatial reference system identifier (e.g., EPSG code) for the GIS geometry. Ensures spatial data interoperability and accurate georeferencing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sewer network record was first created in the system. Supports data lineage and audit trail requirements.',
    `criticality_score` STRING COMMENT 'Risk-based criticality rating (typically 1-100 scale) reflecting consequence of failure, service impact, and environmental risk. Drives capital investment prioritization.',
    `data_source` STRING COMMENT 'Identifier of the source system or data collection method that provided this record (e.g., Esri ArcGIS, field survey, as-built drawings, CCTV inspection).',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Hydraulic design capacity of the sewer segment in Million Gallons per Day (MGD). Used for capacity utilization analysis and growth planning.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the sewer pipe in inches. Key hydraulic parameter for capacity analysis and flow modeling in Innovyze InfoWater.',
    `downstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the inside bottom of the pipe at the downstream end in feet above mean sea level. Used with upstream invert to calculate slope and hydraulic capacity.',
    `easement_required_flag` BOOLEAN COMMENT 'Indicates whether a legal easement is required for utility access to the sewer segment. Critical for maintenance planning and right-of-way management.',
    `fog_risk_flag` BOOLEAN COMMENT 'Indicates whether the segment is at elevated risk for FOG (Fats, Oils, and Grease) blockages based on upstream land use (restaurants, food processing). Drives preventive maintenance frequency.',
    `gis_geometry_wkt` STRING COMMENT 'Well-Known Text (WKT) representation of the sewer segment spatial geometry (typically LINESTRING). Authoritative spatial reference for GIS mapping and network analysis in Esri ArcGIS.',
    `hydrogen_sulfide_risk_flag` BOOLEAN COMMENT 'Indicates elevated risk of hydrogen sulfide gas generation and corrosion. Common in force mains and long gravity sewers with low flow velocity.',
    `installation_year` STRING COMMENT 'Year the sewer segment was originally installed. Key attribute for asset age analysis, depreciation schedules, and capital improvement program (CIP) prioritization.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent CCTV or physical inspection of the sewer segment. Supports compliance with regulatory inspection frequency requirements and condition assessment programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this sewer network record. Enables change tracking and data quality monitoring.',
    `length_feet` DECIMAL(18,2) COMMENT 'Physical length of the sewer segment in feet measured from upstream to downstream node. Used for asset inventory valuation and hydraulic calculations.',
    `lining_installation_date` DATE COMMENT 'Date when pipe lining or rehabilitation was completed. Resets the effective age for condition assessment and extends asset useful life.',
    `lining_type` STRING COMMENT 'Type of trenchless rehabilitation lining applied to the sewer segment. CIPP (Cured-in-Place Pipe) is a common method for structural renewal without excavation.. Valid values are `none|cipp|spray_on|slip_lining|grout`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on regulatory mandates, risk-based prioritization, or preventive maintenance cycles.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, historical context, or field observations relevant to the sewer segment.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the sewer segment in the collection network. Active segments are in service; abandoned segments are out of service but not removed.. Valid values are `active|inactive|abandoned|planned|under_construction`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the sewer segment. Determines maintenance responsibility, regulatory jurisdiction, and capital funding eligibility.. Valid values are `utility_owned|private|municipal|joint`',
    `peak_flow_gpm` DECIMAL(18,2) COMMENT 'Maximum observed or modeled flow rate in Gallons per Minute (GPM) during peak wet weather or high demand periods. Critical for SSO risk assessment.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the sewer segment in US Dollars. Used for asset valuation, insurance, and capital improvement program (CIP) budgeting.',
    `root_intrusion_flag` BOOLEAN COMMENT 'Indicates whether tree root intrusion has been observed or is a known risk for this segment. Common in older vitrified clay and concrete pipes.',
    `segment_identifier` STRING COMMENT 'Externally-known unique identifier for the sewer segment used in GIS systems, field operations, and regulatory reporting. Aligns with Esri ArcGIS feature identifiers.',
    `segment_type` STRING COMMENT 'Classification of the sewer segment by conveyance method and network hierarchy. Gravity sewers use slope for flow; force mains use pumps; interceptors and trunk lines are major collectors.. Valid values are `gravity_sewer|force_main|interceptor|trunk_line|lateral|service_connection`',
    `slope_percent` DECIMAL(18,2) COMMENT 'Gradient of the sewer pipe expressed as a percentage. Critical for gravity sewer hydraulic performance and self-cleansing velocity calculations.',
    `sso_history_count` STRING COMMENT 'Number of Sanitary Sewer Overflow (SSO) events recorded for this segment. High counts trigger regulatory scrutiny and prioritize capacity upgrades.',
    `traffic_impact_level` STRING COMMENT 'Assessment of traffic disruption risk if the segment requires excavation or repair. High-traffic segments require special permitting and coordination.. Valid values are `none|low|medium|high|critical`',
    `upstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the inside bottom of the pipe at the upstream end in feet above mean sea level. Essential for hydraulic grade line analysis and I&I (Inflow and Infiltration) assessment.',
    CONSTRAINT pk_sewer_network PRIMARY KEY(`sewer_network_id`)
) COMMENT 'Master topology of the wastewater collection and conveyance network including gravity sewers, force mains, interceptors, and trunk lines. Captures pipe material, diameter, length, slope, invert elevations, installation year, condition grade, and GIS geometry. Each segment is individually identifiable by upstream/downstream manhole nodes. Serves as the authoritative spatial and hydraulic reference for the sewer system, aligned with Esri ArcGIS Utility Network and Innovyze InfoSWMM/ICM hydraulic models.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`manhole` (
    `manhole_id` BIGINT COMMENT 'Unique identifier for the manhole structure in the wastewater collection system. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Manholes are constructed/rehabilitated through CIP projects. Link supports installation date validation, as-built documentation access, capital cost tracking, and useful life determination for asset m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Manhole inspection, rehabilitation, and maintenance costs must be attributed to cost centers for O&M budget management and rate case cost allocation. Utilities organize collection system maintenance b',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Manholes meeting capitalization policy thresholds are capitalized as fixed assets for GASB compliance, depreciation tracking, condition-based valuation, and comprehensive asset register maintenance.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Manholes are discrete point assets placed within the functional location hierarchy (basin, pressure zone, service territory) used for work order routing, spatial asset management, and field crew dispa',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Manhole rehabilitation uses specific materials (covers, frames, liners, grout) tracked in material master. Linking manholes to material specifications supports maintenance planning, inventory manageme',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Manholes are infrastructure assets requiring inspection scheduling, condition-based maintenance, capital replacement planning, and asset valuation for rate-setting. Integration with asset registry ena',
    `asset_class_code` STRING COMMENT 'Code identifying the asset class or category to which this manhole belongs in the utilitys asset hierarchy. Used for financial reporting, depreciation, and capital planning.',
    `basin_code` STRING COMMENT 'Code identifying the drainage basin or sewershed that this manhole serves. Used for hydraulic modeling and capacity planning.',
    `city` STRING COMMENT 'City or municipality where the manhole is located. Used for jurisdictional reporting and service area analysis.',
    `confined_space_flag` BOOLEAN COMMENT 'Indicates whether the manhole is classified as a permit-required confined space under OSHA regulations. True if the manhole requires a confined space entry permit; false otherwise. Critical for worker safety and entry procedures.',
    `cover_type` STRING COMMENT 'Type of cover installed on the manhole. Watertight covers prevent Inflow and Infiltration (I&I); bolted covers provide security; vented covers allow gas release; traffic-rated covers support vehicular loads.. Valid values are `standard|watertight|bolted|vented|traffic_rated|solid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this manhole record was first created in the system. Used for data lineage and audit trail.',
    `depth_feet` DECIMAL(18,2) COMMENT 'Total depth of the manhole from rim elevation to invert elevation, measured in feet. Critical for determining access requirements, safety protocols, and confined space entry procedures.',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the manhole structure measured in inches. Standard diameters are 48 inches (4 feet) or 60 inches (5 feet) for personnel access.',
    `dma_code` STRING COMMENT 'Code identifying the District Metered Area (DMA) or pressure zone to which this manhole belongs. Used for network segmentation and performance monitoring.',
    `gis_feature_reference` STRING COMMENT 'Unique identifier for the manhole feature in the utilitys GIS system. Used to link asset management data with spatial data layers in ArcGIS or other GIS platforms.',
    `inflow_infiltration_flag` BOOLEAN COMMENT 'Indicates whether the manhole has been identified as a source of Inflow and Infiltration (I&I) into the wastewater collection system. True if I&I has been observed or suspected; false otherwise. Used for prioritizing I&I reduction programs.',
    `invert_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the lowest point inside the manhole where wastewater flows, measured in feet above a reference datum. Critical for calculating pipe slopes and flow gradients.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the manhole. Used to track inspection frequency compliance and schedule future inspections.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance activity was performed on the manhole. Includes cleaning, repairs, or rehabilitation work.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the manhole location in decimal degrees. Used for GIS mapping, spatial analysis, and field navigation.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the manhole location in decimal degrees. Used for GIS mapping, spatial analysis, and field navigation.',
    `macp_score` STRING COMMENT 'Numerical condition score assigned using the NASSCO Manhole Assessment and Certification Program (MACP) methodology. Higher scores indicate worse condition. Used for prioritizing rehabilitation and capital planning.',
    `manhole_number` STRING COMMENT 'Business identifier or asset tag assigned to the manhole for field operations and maintenance tracking. Typically displayed on manhole covers or in field maps.',
    `manhole_status` STRING COMMENT 'Current operational status of the manhole in the wastewater collection system lifecycle. Active manholes are in service; inactive are temporarily out of service; abandoned are no longer used but not removed; planned are in design phase; under construction are being installed; decommissioned are permanently removed from service.. Valid values are `active|inactive|abandoned|planned|under_construction|decommissioned`',
    `manhole_type` STRING COMMENT 'Classification of the manhole based on its function in the wastewater collection network. Standard manholes provide access; drop manholes accommodate elevation changes; junction manholes connect multiple pipes; terminal manholes mark the end of a line; diversion manholes route flow; metering manholes house flow measurement equipment. [ENUM-REF-CANDIDATE: standard|drop|junction|terminal|diversion|metering|special — 7 candidates stripped; promote to reference product]',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next inspection of the manhole. Calculated based on condition rating, criticality, and regulatory requirements.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or special instructions related to the manhole. May include access restrictions, safety concerns, or historical information.',
    `ownership` STRING COMMENT 'Entity that owns the manhole asset. Utility-owned assets are maintained by the water utility; municipal assets may be owned by the city; private assets are on private property; joint ownership involves shared responsibility.. Valid values are `utility|municipal|private|state|federal|joint`',
    `postal_code` STRING COMMENT 'Postal code of the manhole location. Used for geographic segmentation and service area mapping.',
    `rim_elevation_feet` DECIMAL(18,2) COMMENT 'Elevation of the manhole rim (top of cover) above a reference datum, typically mean sea level, measured in feet. Used for hydraulic modeling and flood risk assessment.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the manhole is equipped with SCADA monitoring equipment for real-time level, flow, or alarm monitoring. True if SCADA-monitored; false otherwise.',
    `sso_history_flag` BOOLEAN COMMENT 'Indicates whether the manhole has a history of Sanitary Sewer Overflows (SSO). True if SSO events have occurred at this location; false otherwise. Used for identifying high-risk locations and prioritizing capacity improvements.',
    `state_province` STRING COMMENT 'State or province where the manhole is located. Used for regulatory reporting to state environmental agencies.',
    `street_address` STRING COMMENT 'Street address or nearest intersection where the manhole is located. Used for work order dispatch and public communication.',
    `traffic_load_rating` STRING COMMENT 'Load rating classification of the manhole cover based on expected vehicular traffic. Light duty for pedestrian areas; medium duty for residential streets; heavy duty for arterial roads; extra heavy duty for highways and industrial areas.. Valid values are `light_duty|medium_duty|heavy_duty|extra_heavy_duty`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this manhole record was last updated in the system. Used for data lineage and audit trail.',
    CONSTRAINT pk_manhole PRIMARY KEY(`manhole_id`)
) COMMENT 'Master record for each manhole structure in the wastewater collection system including rim elevation, invert elevation, depth, material, cover type, condition rating, GIS coordinates, and inspection status. Manholes are key access and junction points in the gravity sewer network and are individually tracked for maintenance and I&I assessment.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`lift_station` (
    `lift_station_id` BIGINT COMMENT 'Unique identifier for the wastewater lift station (pump station). Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Lift stations are capital assets constructed/rehabilitated through CIP projects. Link supports asset handover tracking, as-built documentation retrieval, warranty period management, and capital cost a',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Lift station construction and rehabilitation is executed under a construction contract. Asset managers require this link for warranty period tracking, commissioning documentation, and contractor perfo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lift stations incur significant operating costs (electricity, maintenance, repairs) that must be tracked to cost centers for budget management, variance analysis, and rate case justification of collec',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: A lift station discharges through a force main into a downstream sewer network segment. This FK links the lift station to the specific sewer_network segment it feeds, enabling network topology travers',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Lift stations are capital assets requiring fixed asset tracking for depreciation, useful life management, replacement cost estimation, rate base inclusion, and GASB 34 infrastructure reporting.',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Lift stations require flow meters for influent volume measurement, energy benchmarking, capacity planning, and SSO risk reporting. Utilities track which registered meter measures flow at each lift sta',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Lift stations are placed within the functional location hierarchy (service territory, pressure zone, basin) used for work order routing, crew dispatch, and asset hierarchy reporting in enterprise asse',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Lift stations are major capital assets requiring asset registry entries for depreciation, replacement cost tracking, CIP eligibility, and ISO 55001 lifecycle management. Every utility asset manager ex',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Lift stations serve defined geographic service areas mapped to territories. Territory assignment drives capital planning, rate allocation, and emergency response routing. Utility asset managers expect',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Lift stations store critical spare parts (pumps, motors, controls) on-site or at nearby storage facilities for emergency repairs. Linking stations to their parts storage location enables field crews t',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: A lift station pumps wastewater toward a destination WWTP. This is a fundamental operational relationship in wastewater collection — each lift station serves a specific treatment plant. Adding wwtp_id',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Estimated annual operating cost of the lift station in USD, including energy, routine maintenance, and labor. Used for budgeting and lifecycle cost analysis.',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Quantitative condition assessment score (typically 0-100 scale) based on physical inspection, performance metrics, and age. Higher scores indicate better condition. Used for capital planning and risk assessment.',
    `backup_power_capacity_kw` DECIMAL(18,2) COMMENT 'Rated capacity of the backup power system in kilowatts (kW). Determines how long the lift station can operate during a utility power outage.',
    `backup_power_type` STRING COMMENT 'Type of backup power system installed at the lift station: generator (diesel or natural gas), battery (UPS), dual feed (redundant utility feeds), or none. Critical for emergency preparedness and SSO prevention.. Valid values are `generator|battery|none|dual_feed`',
    `city` STRING COMMENT 'City or municipality where the lift station is located. Used for jurisdictional reporting and asset management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lift station record was first created in the system. Used for data lineage and audit trail.',
    `criticality_rating` STRING COMMENT 'Asset criticality classification based on consequence of failure analysis: critical (immediate SSO risk, high population impact), high (significant impact), medium (moderate impact), or low (minimal impact). Used for maintenance prioritization and risk management.. Valid values are `critical|high|medium|low`',
    `design_capacity_gpm` DECIMAL(18,2) COMMENT 'Maximum rated pumping capacity of the lift station in gallons per minute (GPM) under design conditions. Critical for hydraulic modeling and capacity planning.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum rated pumping capacity of the lift station in million gallons per day (MGD). Derived from GPM for daily flow planning and regulatory reporting.',
    `expected_useful_life_years` STRING COMMENT 'Estimated useful life of the lift station in years from installation or last major rehabilitation. Used for depreciation schedules and capital improvement program (CIP) planning.',
    `force_main_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the force main (pressurized discharge pipe) in inches that conveys wastewater from the lift station to the downstream collection system or treatment plant.',
    `force_main_length_feet` DECIMAL(18,2) COMMENT 'Total length of the force main in feet from the lift station discharge to the downstream connection point. Used for hydraulic calculations and asset valuation.',
    `force_main_material` STRING COMMENT 'Material composition of the force main pipe: ductile iron (DI), polyvinyl chloride (PVC), high-density polyethylene (HDPE), steel, or concrete. Impacts corrosion resistance, lifespan, and maintenance requirements.. Valid values are `ductile_iron|pvc|hdpe|steel|concrete`',
    `installation_date` DATE COMMENT 'Date when the lift station was originally installed and commissioned for service. Used for asset age calculation, depreciation, and replacement planning.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection of the lift station. Used to track compliance with preventive maintenance schedules and regulatory requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lift station record was last updated. Used for data lineage, audit trail, and change tracking.',
    `last_rehabilitation_date` DATE COMMENT 'Date of the most recent major rehabilitation or upgrade of the lift station. Used to track asset condition and plan future capital improvements.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the lift station in decimal degrees (WGS84). Used for GIS mapping, asset location, and emergency response.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the lift station in decimal degrees (WGS84). Used for GIS mapping, asset location, and emergency response.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for the lift station. Used for work order scheduling and resource planning.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, historical context, or site-specific information about the lift station.',
    `number_of_pumps` STRING COMMENT 'Total count of pumps installed at the lift station, including duty pumps and standby/backup units. Critical for redundancy planning and maintenance scheduling.',
    `operational_status` STRING COMMENT 'Current operational state of the lift station in its lifecycle: active (in service), inactive (temporarily offline), standby (backup), maintenance (under repair), decommissioned (retired), or under construction (not yet commissioned).. Valid values are `active|inactive|standby|maintenance|decommissioned|under_construction`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the lift station: utility owned (owned and operated by the water utility), private (privately owned), developer (owned by developer, pending transfer), municipal (owned by municipality), or joint (shared ownership). Impacts maintenance responsibility and capital planning.. Valid values are `utility_owned|private|developer|municipal|joint`',
    `postal_code` STRING COMMENT 'Postal ZIP code of the lift station location. Used for geographic analysis and service area mapping.',
    `pump_configuration` STRING COMMENT 'Pump redundancy configuration: simplex (1 pump, no backup), duplex (2 pumps, 1 duty + 1 standby), triplex (3 pumps), quadruplex (4 pumps). Determines operational reliability and maintenance flexibility.. Valid values are `duplex|triplex|quadruplex|simplex`',
    `pump_horsepower` DECIMAL(18,2) COMMENT 'Total rated horsepower (HP) of the primary duty pump(s). Used for energy consumption analysis and operational cost estimation.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated current replacement cost of the lift station in USD. Used for insurance valuation, capital improvement program (CIP) planning, and asset valuation under GASB 34.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the lift station is integrated with the SCADA system for real-time monitoring, control, and alarm management. True if SCADA-enabled, False otherwise.',
    `service_area_name` STRING COMMENT 'Name or designation of the geographic service area or collection basin served by this lift station. Used for operational planning and customer communication.',
    `service_area_population` STRING COMMENT 'Estimated population served by the lift station within its collection basin. Used for capacity planning, regulatory reporting, and capital improvement prioritization.',
    `sso_risk_flag` BOOLEAN COMMENT 'Indicates whether the lift station is identified as high-risk for sanitary sewer overflow (SSO) events due to capacity constraints, equipment age, or historical performance. True if high SSO risk, False otherwise.',
    `state_province` STRING COMMENT 'State or province where the lift station is located. Used for regulatory reporting to state primacy agencies and EPA.',
    `station_code` STRING COMMENT 'Unique alphanumeric code or tag assigned to the lift station for asset tracking, SCADA integration, and maintenance management (CMMS).',
    `station_name` STRING COMMENT 'Business name or designation of the lift station for operational reference and public communication.',
    `station_type` STRING COMMENT 'Classification of the lift station based on pump configuration and design: submersible (pumps submerged in wet well), dry pit (pumps in separate dry chamber), wet pit (pumps in wet well but accessible), pneumatic (air-pressure driven), or grinder (with grinder pumps for solids reduction).. Valid values are `submersible|dry_pit|wet_pit|pneumatic|grinder`',
    `street_address` STRING COMMENT 'Physical street address of the lift station site. Used for field service dispatch, emergency response, and asset documentation.',
    `telemetry_status` STRING COMMENT 'Current status of telemetry communication between the lift station and the central SCADA system: online (active communication), offline (no communication), intermittent (unreliable), or not installed (no telemetry equipment).. Valid values are `online|offline|intermittent|not_installed`',
    `total_dynamic_head_feet` DECIMAL(18,2) COMMENT 'Total dynamic head (TDH) in feet that the pumps must overcome, including static lift, friction losses, and discharge pressure. Critical for pump selection and hydraulic modeling.',
    `wet_well_volume_gallons` DECIMAL(18,2) COMMENT 'Total storage volume of the wet well (sump) in gallons. Determines pump cycle frequency and emergency storage capacity during power outages or pump failures.',
    CONSTRAINT pk_lift_station PRIMARY KEY(`lift_station_id`)
) COMMENT 'Master record for each wastewater lift station (pump station) including station name, location, design capacity (GPM/MGD), wet well volume, number of pumps, SCADA integration point, telemetry status, service area, and operational status. Lift stations are critical infrastructure nodes that convey wastewater from low-elevation areas to treatment facilities via force mains.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`wwtp` (
    `wwtp_id` BIGINT COMMENT 'Unique identifier for the wastewater treatment plant facility. Primary key for the WWTP master registry.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: WWTPs are delivered/upgraded via CIP projects. Linking enables asset lifecycle tracking, capitalization date validation, warranty management, and regulatory permit compliance tied to project completio',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: WWTPs operate under NPDES permits; this FK directly links the facility to its governing permit for DMR reporting, permit renewal tracking, and regulatory inspection scheduling. Domain experts expect e',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WWTPs are primary cost centers for O&M expense allocation, budget variance reporting, and rate case cost-of-service documentation. Essential for monthly financial close and regulatory rate filings.',
    `debt_instrument_id` BIGINT COMMENT 'Foreign key linking to finance.debt_instrument. Business justification: WWTPs are commonly financed through revenue bonds or SRF loans. Linking the facility to its debt instrument supports debt service coverage ratio calculations, rate case rate base documentation, and bo',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Combined utilities register WWTPs in the unified treatment facility registry for cost center assignment, permitting, and operational reporting. A domain expert expects every WWTP to reference its pare',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: WWTP facilities are major capital assets requiring fixed asset tracking for GASB reporting, depreciation calculation, net book value determination, rate base inclusion, and regulatory asset valuation.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: WWTPs are frequently constructed or upgraded using SRF loans, EPA grants, or USDA grants. Linking the facility to its primary grant enables grant drawdown reporting, allowable cost tracking, and singl',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: WWTPs are placed within the functional location hierarchy in enterprise asset management systems (Maximo, SAP PM). The location_id links the facility to its organizational and spatial context for work',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the asset registry for integration with the computerized maintenance management system (CMMS) and capital asset tracking.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: A WWTP serves one or more service territories. Territory-level wastewater capacity planning, NPDES permit jurisdiction assignment, and rate case filings require knowing which territory a WWTP serves. ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: WWTPs maintain on-site chemical and spare parts inventory requiring storage location tracking for regulatory chemical storage compliance, inventory reorder triggers, and stock audits. Water-utilities ',
    `address_line_1` STRING COMMENT 'Primary street address of the wastewater treatment plant facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, suite, or unit designation.',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Actual average daily flow processed by the facility over the most recent reporting period, measured in million gallons per day. Used for capacity utilization analysis.',
    `biosolids_class` STRING COMMENT 'EPA classification of biosolids quality based on pathogen reduction and vector attraction reduction requirements.. Valid values are `class_a|class_b|exceptional_quality|not_applicable`',
    `biosolids_management_method` STRING COMMENT 'Primary method used for disposal or beneficial reuse of biosolids (treated sewage sludge) generated by the treatment process.. Valid values are `land_application|incineration|landfill|composting|beneficial_reuse`',
    `city` STRING COMMENT 'City or municipality where the facility is located.',
    `commissioning_date` DATE COMMENT 'Date when the facility was originally placed into service and began treating wastewater.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the facility with respect to NPDES permit limits and reporting requirements.. Valid values are `compliant|non_compliant|consent_decree|administrative_order`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the facility location.. Valid values are `USA|CAN|MEX`',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum rated treatment capacity of the facility in million gallons per day as designed and permitted. Critical for capacity planning and regulatory compliance.',
    `disinfection_method` STRING COMMENT 'Primary disinfection technology used to reduce pathogen levels in treated effluent before discharge.. Valid values are `chlorine|uv|ozone|none`',
    `effluent_discharge_point` STRING COMMENT 'Geographic or infrastructure identifier for the outfall location where treated effluent is discharged from the facility.',
    `energy_consumption_kwh_per_mg` DECIMAL(18,2) COMMENT 'Average energy intensity of the treatment process measured in kilowatt-hours per million gallons treated. Key performance indicator for operational efficiency.',
    `facility_email` STRING COMMENT 'Primary email address for facility operations and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `facility_phone` STRING COMMENT 'Primary contact phone number for the wastewater treatment plant operations center.',
    `facility_type` STRING COMMENT 'Classification of the wastewater treatment facility based on service area and ownership model.. Valid values are `municipal|industrial|combined|satellite`',
    `gis_feature_reference` STRING COMMENT 'Unique identifier for the facility in the enterprise GIS system, enabling spatial analysis and network modeling.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or compliance audit conducted by the primacy agency.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major capital improvement or process upgrade to the facility.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the facility location in decimal degrees (WGS84 datum).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the facility location in decimal degrees (WGS84 datum).',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or facility-specific information not captured in structured fields.',
    `operational_status` STRING COMMENT 'Current operational state of the wastewater treatment plant in its lifecycle.. Valid values are `active|inactive|standby|decommissioned|under_construction`',
    `operator_certification_level` STRING COMMENT 'Minimum operator certification level or class required to operate this facility (e.g., Class I, Class II, Class III, Class IV).',
    `operator_certification_required` BOOLEAN COMMENT 'Indicates whether state-certified operators are required to manage this facility per regulatory requirements.',
    `peak_flow_mgd` DECIMAL(18,2) COMMENT 'Maximum instantaneous or daily flow capacity the facility can handle during wet weather or peak demand events.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility location.',
    `receiving_water_body` STRING COMMENT 'Name of the river, stream, lake, ocean, or other water body that receives the treated effluent discharge.',
    `receiving_water_classification` STRING COMMENT 'Regulatory classification of the receiving water body (e.g., Class A, Class B, impaired, sensitive) that determines discharge limits.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this facility record was last modified in the system.',
    `regulatory_jurisdiction` STRING COMMENT 'State or regional environmental agency with primacy authority over the facilitys NPDES permit and compliance oversight.',
    `scada_system_reference` STRING COMMENT 'Identifier linking this facility to the SCADA system for real-time process monitoring and control data integration.',
    `state_province` STRING COMMENT 'State or province code where the facility is located (two-letter abbreviation for US states).',
    `treatment_level` STRING COMMENT 'Highest level of treatment provided by the facility process train, indicating the degree of pollutant removal achieved.. Valid values are `preliminary|primary|secondary|tertiary|advanced`',
    `treatment_process_description` STRING COMMENT 'Detailed description of the treatment process train including primary, secondary, and tertiary treatment technologies employed (e.g., activated sludge, trickling filter, membrane bioreactor, UV disinfection).',
    CONSTRAINT pk_wwtp PRIMARY KEY(`wwtp_id`)
) COMMENT 'Master record for each Wastewater Treatment Plant (WWTP) or Sewage Treatment Plant (STP) including facility name, NPDES permit number, design capacity (MGD), actual average daily flow, treatment process train (primary, secondary, tertiary), effluent discharge point, receiving water body, regulatory jurisdiction, and operational status. The authoritative facility registry for wastewater treatment operations.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` (
    `effluent_discharge_event_id` BIGINT COMMENT 'Unique identifier for the effluent discharge event record. Primary key for tracking individual discharge occurrences from WWTP outfalls.',
    `compliance_permit_id` BIGINT COMMENT 'Identifier of the NPDES permit under which this discharge event is authorized.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Discharge monitoring, bypass event response, and upset condition mitigation costs are tracked to cost centers for NPDES compliance budgeting and operational cost variance analysis.',
    `outfall_id` BIGINT COMMENT 'Identifier of the specific outfall structure through which treated effluent was discharged to the receiving water body.',
    `wwtp_id` BIGINT COMMENT 'Identifier of the wastewater treatment plant from which the effluent was discharged.',
    `bypass_notification_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory authorities were notified of an emergency bypass or unauthorized discharge event, as required by NPDES permit conditions.',
    `bypass_reason_code` STRING COMMENT 'Standardized code indicating the reason for a treatment bypass or emergency discharge (e.g., equipment failure, extreme weather, power outage).',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the discharge event relative to NPDES permit limits. Indicates whether discharge met all permit conditions or resulted in violations.. Valid values are `compliant|non_compliant|pending_review|exceedance|violation`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this discharge event record was first created in the system.',
    `discharge_authorization_number` STRING COMMENT 'External authorization or permit number assigned by the regulatory agency for this discharge event or outfall.',
    `discharge_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the discharge event measured in hours. Calculated from start and end timestamps.',
    `discharge_end_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent discharge event ended. Used to calculate total discharge duration and volume.',
    `discharge_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate of effluent discharge measured in gallons per minute during the event.',
    `discharge_point_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the outfall discharge point in decimal degrees.',
    `discharge_point_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the outfall discharge point in decimal degrees.',
    `discharge_start_timestamp` TIMESTAMP COMMENT 'Date and time when the effluent discharge event began. Critical for calculating discharge duration and compliance with permit limits.',
    `discharge_status` STRING COMMENT 'Current operational status of the discharge event indicating whether it was authorized under permit conditions, an emergency bypass, or an unauthorized release.. Valid values are `authorized|unauthorized|emergency|bypass|planned|unplanned`',
    `discharge_type` STRING COMMENT 'Classification of the discharge event based on operational pattern: continuous flow, intermittent release, batch discharge, or bypass event.. Valid values are `continuous|intermittent|batch|emergency_bypass|planned_bypass`',
    `discharge_volume_mgd` DECIMAL(18,2) COMMENT 'Total volume of treated effluent discharged during this event, measured in million gallons per day. Core metric for NPDES permit compliance and DMR reporting.',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period to which this discharge event will be aggregated for regulatory submission.',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this discharge event data was submitted to the regulatory authority.',
    `dmr_submitted_flag` BOOLEAN COMMENT 'Indicates whether this discharge event has been included in a submitted DMR to the regulatory authority.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this discharge event record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text field for operational notes, observations, or additional context regarding the discharge event, including any unusual circumstances or corrective actions taken.',
    `operator_certification_number` STRING COMMENT 'State-issued certification number of the operator responsible for monitoring the discharge event.',
    `operator_name` STRING COMMENT 'Name of the certified wastewater treatment plant operator on duty during the discharge event.',
    `permit_limit_applicable_flag` BOOLEAN COMMENT 'Indicates whether NPDES permit discharge limits apply to this specific discharge event. False for emergency bypasses or non-permitted discharges.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during or immediately preceding the discharge event. Relevant for wet weather discharge analysis and CSO/SSO correlation.',
    `receiving_water_body_classification` STRING COMMENT 'Regulatory classification of the receiving water body (e.g., Class A, Class B, impaired waters, sensitive ecosystem) that determines applicable discharge standards.',
    `receiving_water_body_name` STRING COMMENT 'Name of the river, stream, lake, ocean, or other water body into which the treated effluent was discharged.',
    `scada_event_reference` STRING COMMENT 'Identifier linking this discharge event to the corresponding SCADA system event record for process data correlation.',
    `treatment_level_achieved` STRING COMMENT 'Level of wastewater treatment achieved prior to discharge (primary, secondary, tertiary, advanced, or partial treatment during bypass).. Valid values are `primary|secondary|tertiary|advanced|partial|none`',
    `violation_description` STRING COMMENT 'Detailed description of any permit violations or exceedances that occurred during this discharge event, including parameters exceeded and magnitude.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this discharge event resulted in one or more NPDES permit violations or exceedances of discharge limits.',
    `weather_condition` STRING COMMENT 'Description of weather conditions during the discharge event (e.g., dry weather, wet weather, storm event) that may impact discharge characteristics or permit applicability.',
    CONSTRAINT pk_effluent_discharge_event PRIMARY KEY(`effluent_discharge_event_id`)
) COMMENT 'Transactional record of treated effluent discharge events from WWTP outfalls including discharge start/end timestamps, volume discharged, receiving water body, outfall identifier, NPDES permit limit applicability, and discharge authorization status. Core record for NPDES compliance and DMR submission preparation.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` (
    `effluent_parameter_result_id` BIGINT COMMENT 'Unique identifier for the effluent parameter measurement result record.',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this effluent monitoring is conducted.',
    `dmr_id` BIGINT COMMENT 'Foreign key linking to compliance.dmr. Business justification: Effluent parameter results are the underlying measurements assembled into DMR submissions. This FK directly links each measurement to its DMR for data traceability, DMR assembly workflows, and audit t',
    `effluent_discharge_event_id` BIGINT COMMENT 'Foreign key linking to wastewater.effluent_discharge_event. Business justification: effluent_parameter_result represents water quality measurements taken during specific discharge events. The product description states Transactional record of WWTP effluent discharge events and assoc',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: NPDES effluent compliance samples are analyzed by contracted certified laboratories. Linking to supply.vendor enables lab vendor qualification tracking, DMR defensibility audits, and invoice reconcili',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Each effluent parameter result is evaluated against a specific permit condition (numeric limit, monitoring frequency). This FK enables automated compliance status determination, exceedance calculation',
    `sampling_point_id` BIGINT COMMENT 'Reference to the specific outfall or discharge monitoring point where the sample was collected.',
    `analysis_date` DATE COMMENT 'Date when the laboratory analysis was performed on the sample.',
    `analysis_method` STRING COMMENT 'EPA-approved analytical method used to measure the parameter (e.g., EPA 405.1 for BOD, EPA 160.2 for TSS, SM 4500-H+ for pH).',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations of exceedances, corrective actions taken, or other relevant information about the result.',
    `compliance_status` STRING COMMENT 'Indicates whether the measured result meets the NPDES permit limit requirement (pass/fail) or if evaluation is not applicable or pending.. Valid values are `pass|fail|not_applicable|pending_review`',
    `data_validation_status` STRING COMMENT 'Internal validation status of the result data before regulatory submission (draft, validated by supervisor, approved for submission, or rejected).. Valid values are `draft|validated|approved|rejected`',
    `detection_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that the analytical method can reliably detect for this parameter.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'Percentage by which the measured value exceeds the permit limit, calculated as ((measured_value - permit_limit_value) / permit_limit_value) * 100. Null if result is in compliance.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'Effluent discharge flow rate in million gallons per day at the time of sample collection, used for mass loading calculations.',
    `laboratory_batch_number` STRING COMMENT 'Laboratory-assigned batch or run number for quality control and traceability purposes.',
    `mass_loading_lbs_per_day` DECIMAL(18,2) COMMENT 'Calculated mass loading of the parameter in pounds per day, derived from concentration and flow rate (concentration * flow * 8.34).',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the parameter measurement as determined by laboratory analysis.',
    `parameter_code` STRING COMMENT 'EPA-standardized five-digit code identifying the specific water quality parameter measured (e.g., 00310 for BOD, 00530 for TSS).. Valid values are `^[A-Z0-9]{5}$`',
    `parameter_name` STRING COMMENT 'Full descriptive name of the water quality parameter measured (e.g., Biochemical Oxygen Demand, Total Suspended Solids, pH, Ammonia, Phosphorus, Fecal Coliform, E. coli).',
    `permit_limit_type` STRING COMMENT 'Type of NPDES permit limit against which this result is evaluated (e.g., daily maximum, monthly average, weekly average).. Valid values are `daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average`',
    `permit_limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the NPDES permit limit for this parameter and limit type.',
    `quality_control_flag` STRING COMMENT 'Indicates the outcome of quality control checks (e.g., duplicate analysis, spike recovery, blank contamination) for this result.. Valid values are `passed|failed|suspect|not_performed`',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'Minimum concentration that the analytical method can reliably quantify with acceptable precision and accuracy.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this effluent parameter result record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this effluent parameter result record was last modified.',
    `regulatory_agency` STRING COMMENT 'Regulatory authority to which this result is reported (EPA or state primacy agency).. Valid values are `EPA|state_primacy_agency`',
    `result_qualifier` STRING COMMENT 'Laboratory qualifier code indicating special conditions of the result (e.g., < for below detection limit, > for above quantitation limit, J for estimated value).',
    `sample_collection_date` DATE COMMENT 'Date when the effluent sample was collected from the discharge point.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the effluent sample was collected, including time zone.',
    `sample_type` STRING COMMENT 'Method by which the effluent sample was collected (e.g., grab sample, 24-hour composite, flow-weighted composite, continuous monitoring).. Valid values are `grab|composite_24hr|composite_flow_weighted|continuous`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the parameter result is expressed (e.g., mg/L for BOD/TSS, MPN/100mL for bacteria, SU for pH). [ENUM-REF-CANDIDATE: mg/L|ug/L|MPN/100mL|CFU/100mL|SU|NTU|percent|umhos/cm — 8 candidates stripped; promote to reference product]',
    `validation_date` DATE COMMENT 'Date when the result was validated and approved for regulatory reporting.',
    CONSTRAINT pk_effluent_parameter_result PRIMARY KEY(`effluent_parameter_result_id`)
) COMMENT 'Transactional record of WWTP effluent discharge events and associated water quality parameter measurements for NPDES compliance monitoring. Captures discharge event details (start/end timestamps, volume, receiving water body, outfall identifier, authorization status) and individual parameter results (BOD, COD, TSS, TDS, pH, ammonia, phosphorus, fecal coliform, E. coli) with measured values, units, permit limits (daily max, monthly avg), compliance status, sampling dates, analysis methods, and laboratory references. Core operational record for NPDES compliance evaluation and DMR submission preparation.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`sso_event` (
    `sso_event_id` BIGINT COMMENT 'Unique identifier for the sanitary sewer overflow event. Primary key.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: EPA SSO reporting and customer notification workflows require identifying which premises are impacted by a sanitary sewer overflow. Utilities must notify affected property owners and track premise-lev',
    `source_water_intake_id` BIGINT COMMENT 'Foreign key linking to treatment.source_water_intake. Business justification: EPA SSO reporting requirements mandate tracking when overflows may impact drinking water sources. Utilities must notify drinking water treatment facilities of nearby SSOs. This FK links the SSO event ',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: SSO events must be reported under the collection systems NPDES or collection system permit. This FK links each SSO to the governing permit for regulatory notification, DMR reporting period assignment',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: SSO events trigger formal regulatory violations requiring tracking for enforcement, penalties, DMR reporting, and corrective action plans. Essential for SSO consent decree compliance and EPA enforceme',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SSO response costs (emergency crew labor, equipment, cleanup contractors, regulatory penalties) must be charged to cost centers for EPA reporting, insurance claims, and cost recovery analysis.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: SSO events often originate from or impact specific customer properties (private lateral blockages, illegal connections). Linking to customer account enables tracking customer-caused SSOs, coordinating',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Significant SSOs trigger direct enforcement actions (consent orders, administrative orders, civil penalties) under CWA authority. Real process: SSO consent decree enforcement, penalty calculation, and',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: SSO events are asset failures requiring formal failure records for root cause analysis, MTBF tracking, and regulatory reporting. Linking sso_event to failure_record enables failure mode analysis and s',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: SSO events trigger mandatory post-event inspections of the overflow location and contributing infrastructure. Linking sso_event to inspection_event enables tracking of regulatory-required follow-up in',
    `lift_station_id` BIGINT COMMENT 'Foreign key linking to wastewater.lift_station. Business justification: SSO events frequently originate at lift stations due to wet well overflows, pump failures, or power outages. Adding lift_station_id to sso_event enables direct attribution of overflow events to specif',
    `manhole_id` BIGINT COMMENT 'Identifier of the manhole where the overflow occurred, if applicable. Links to asset registry.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: SSO events in the operational wastewater domain correspond to overflow_event records in the compliance domain for regulatory reporting and violation tracking. This FK links the operational SSO record ',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: SSO events often originate at or near a customer service point (lateral). Linking SSO events to the affected service point enables customer notification workflows, billing adjustment processing, and r',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the infrastructure asset (pipe, pump station, lift station) associated with the overflow event.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: An SSO event occurs at a specific location in the sewer collection system — either at a manhole (already linked via manhole_id) or along a pipe segment. Adding sewer_network_id to sso_event links the ',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: SSO events require immediate water quality sampling of affected surface waters or impacted areas per state/EPA regulations to assess public health risk and pathogen contamination. Links spill event to',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the work order created for corrective or preventive action related to this SSO event.',
    `cause_category` STRING COMMENT 'Primary category of the root cause of the overflow event. [ENUM-REF-CANDIDATE: blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism|inflow_infiltration|structural_failure|maintenance_activity|unknown — promote to reference product]. Valid values are `blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism`',
    `cause_code` STRING COMMENT 'Detailed cause code identifying the specific reason for the overflow (e.g., grease blockage, root intrusion, pump failure, wet weather overload).',
    `cause_description` STRING COMMENT 'Detailed narrative description of the cause and circumstances of the overflow event.',
    `corrective_action_taken` STRING COMMENT 'Description of immediate corrective actions taken to stop the overflow and mitigate environmental impact (e.g., cleared blockage, repaired pump, deployed vacuum truck).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SSO event record was first created in the system.',
    `discovered_by` STRING COMMENT 'Source or party that discovered and reported the overflow event.. Valid values are `utility_staff|customer_complaint|routine_inspection|scada_alarm|third_party|other`',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the overflow event was first discovered or reported.',
    `dmr_reported` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow event was included in the monthly Discharge Monitoring Report (DMR) submitted under the NPDES permit.',
    `dmr_reporting_period` STRING COMMENT 'Year-month (YYYY-MM) of the DMR reporting period in which this SSO event was included.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the overflow event in minutes, calculated from start to end timestamp.',
    `enforcement_action_taken` STRING COMMENT 'Type of enforcement action taken by regulatory agencies in response to the overflow event.. Valid values are `none|warning|notice_of_violation|consent_order|penalty|other`',
    `estimated_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of untreated or partially treated wastewater discharged during the SSO event, measured in gallons. Critical metric for regulatory reporting and environmental impact assessment.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the sanitary sewer overflow event was stopped or contained.',
    `event_number` STRING COMMENT 'Externally-known business identifier for the SSO event, typically formatted as SSO-YYYY-NNNNNN for regulatory reporting and tracking.. Valid values are `^SSO-[0-9]{4}-[0-9]{6}$`',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the sanitary sewer overflow event began, representing the principal business event time for regulatory reporting.',
    `event_status` STRING COMMENT 'Current lifecycle status of the SSO event in the incident management workflow.. Valid values are `reported|under_investigation|corrective_action_in_progress|resolved|closed`',
    `location_address` STRING COMMENT 'Street address or nearest address to the overflow location for emergency response and regulatory reporting.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the overflow location in decimal degrees for GIS mapping and spatial analysis.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the overflow location in decimal degrees for GIS mapping and spatial analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this SSO event record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or comments regarding the overflow event, response, or follow-up actions.',
    `overflow_location_type` STRING COMMENT 'Type of infrastructure asset where the overflow occurred.. Valid values are `manhole|cleanout|pump_station|force_main|gravity_sewer|building_lateral`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by regulatory agencies for the overflow event, in US dollars.',
    `preventive_action_planned` STRING COMMENT 'Description of long-term preventive measures planned to prevent recurrence (e.g., pipe replacement, capacity upgrade, enhanced maintenance).',
    `public_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether public notification (posting, media alert, direct contact) is required based on overflow volume, location, or receiving environment.',
    `public_notification_timestamp` TIMESTAMP COMMENT 'Date and time when public notification was issued regarding the overflow event.',
    `rainfall_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall measured in inches during the 24-hour period preceding the overflow event, used to assess weather-related causation.',
    `reached_surface_water` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow reached a surface water body, triggering enhanced regulatory reporting requirements.',
    `receiving_environment` STRING COMMENT 'Type of environment that received the discharged wastewater: surface water body, storm drainage system, land surface, building interior, or other.. Valid values are `surface_water|storm_drain|land_surface|building_interior|other`',
    `receiving_water_body_name` STRING COMMENT 'Name of the surface water body (river, stream, lake, bay) that received the discharge, if applicable.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow event meets thresholds requiring notification to state or federal regulatory agencies.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the overflow event was reported to the regulatory agency (EPA, state primacy agency), typically required within 24 hours.',
    `response_timestamp` TIMESTAMP COMMENT 'Date and time when utility personnel arrived on-site to respond to the overflow event.',
    `responsible_party` STRING COMMENT 'Name or identifier of the utility staff member or contractor responsible for managing the response to the overflow event.',
    `volume_estimation_method` STRING COMMENT 'Method used to determine the spill volume: measured (flow meter), calculated (hydraulic model), or estimated (visual observation).. Valid values are `measured|calculated|estimated`',
    `volume_recovered_gallons` DECIMAL(18,2) COMMENT 'Volume of spilled wastewater that was recovered and returned to the collection system or treatment plant, measured in gallons.',
    `weather_related` BOOLEAN COMMENT 'Boolean flag indicating whether the overflow was caused or exacerbated by wet weather conditions, inflow, or infiltration (I&I).',
    CONSTRAINT pk_sso_event PRIMARY KEY(`sso_event_id`)
) COMMENT 'Transactional record of each Sanitary Sewer Overflow (SSO) event including event date/time, duration, estimated volume spilled, overflow location (manhole or pipe), receiving environment (land, waterway, storm drain), cause code (blockage, capacity exceedance, equipment failure, I&I), corrective actions taken, regulatory notification timestamp, and enforcement status. Mandatory for state and EPA SSO reporting.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`cso_event` (
    `cso_event_id` BIGINT COMMENT 'Unique identifier for the Combined Sewer Overflow event record. Primary key for the CSO event entity.',
    `source_water_intake_id` BIGINT COMMENT 'Foreign key linking to treatment.source_water_intake. Business justification: EPAs CSO Control Policy requires utilities to assess CSO impacts on drinking water intakes. This FK links CSO events to potentially affected source water intakes, supporting regulatory notification, ',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: CSO events are reported under NPDES permits with LTCP requirements. This FK links each CSO event to its governing permit for DMR submission, LTCP milestone tracking, and regulatory notification — fund',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: CSO events exceeding NPDES permit limits or LTCP requirements become formal violations. Critical for consent decree tracking, nine minimum controls compliance, and regulatory reporting to EPA/state ag',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CSO monitoring, post-event sampling, and control measure costs are allocated to cost centers for LTCP financial tracking, consent decree compliance reporting, and capital planning budgets.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: CSO events may impact specific customer properties requiring notification under regulatory requirements. Linking enables tracking which customers received CSO notifications, coordinating with customer',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: CSO events violating LTCP milestones or permit conditions trigger enforcement actions under consent decrees. Real process: CSO consent decree enforcement, stipulated penalty assessment, and long-term ',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: CSO events represent combined sewer system failures requiring formal failure records for root cause analysis and MTBF tracking. This link supports LTCP performance reporting and asset failure mode ana',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: CSO events trigger mandatory post-event monitoring and infrastructure inspections required under NPDES permits and LTCP commitments. Linking cso_event to inspection_event tracks regulatory-required fo',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: CSO events drive Long-Term Control Plan (LTCP) projects mandated by EPA consent decrees. Linking events to the projects designed to eliminate them is required for regulatory reporting, demonstrating c',
    `outfall_id` BIGINT COMMENT 'Identifier of the specific CSO outfall location where the overflow discharge occurred. Links to the outfall asset registry.',
    `overflow_event_id` BIGINT COMMENT 'Foreign key linking to compliance.overflow_event. Business justification: CSO events in the operational wastewater domain correspond to overflow_event records in the compliance domain. This FK links the operational CSO record to its compliance-side overflow event for LTCP c',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: CSO events occur at specific combined sewer infrastructure assets. Linking cso_event to the asset registry enables asset-level CSO frequency tracking, performance reporting under Long-Term Control Pla',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: CSO (Combined Sewer Overflow) events occur at specific locations within the sewer network. Adding sewer_network_id FK links each CSO event to the network segment where the overflow occurred. This is e',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: CSO Long-Term Control Plans (LTCPs) are filed by regulatory jurisdiction mapped to service territory. Linking CSO events to territory enables territory-level LTCP compliance tracking, regulatory repor',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: NPDES permits require post-CSO water quality monitoring of receiving waters to assess environmental impact. CSO events trigger mandatory sampling for BOD, TSS, fecal coliform per regulatory protocols.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: CSO events trigger corrective work orders for infrastructure repair, control measure activation, and post-event cleanup. Linking cso_event to work_order enables cost tracking for LTCP compliance and r',
    `bod_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured Biochemical Oxygen Demand concentration in milligrams per liter from post-event water quality sampling, indicating organic pollution level.',
    `cause_category` STRING COMMENT 'Primary cause category of the CSO event: wet weather event exceeding system capacity, equipment failure, operational error, or unknown.. Valid values are `wet_weather|equipment_failure|capacity_exceedance|operational_error|unknown`',
    `cause_description` STRING COMMENT 'Detailed narrative description of the root cause and contributing factors that led to the CSO event.',
    `control_measure_active` BOOLEAN COMMENT 'Indicates whether CSO control measures (storage tanks, green infrastructure, real-time control) were operational and active during this event.',
    `control_measure_description` STRING COMMENT 'Description of the CSO control measures that were in place or activated during the event (e.g., storage tank diversion, sewer separation, green infrastructure capture).',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions planned or implemented to address the cause of the CSO event and prevent future occurrences.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to prevent recurrence of this type of CSO event.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CSO event record was first created in the system.',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period (YYYY-MM format) in which this CSO event will be included for NPDES compliance reporting.',
    `dmr_submission_date` DATE COMMENT 'Date when the DMR containing this CSO event was submitted to the regulatory agency.',
    `dmr_submitted` BOOLEAN COMMENT 'Indicates whether this CSO event has been included in a submitted DMR to the regulatory agency.',
    `event_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the CSO event in minutes, calculated from start to end timestamp.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the Combined Sewer Overflow event concluded and discharge ceased.',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the Combined Sewer Overflow event began, marking the initiation of discharge to the receiving water body.',
    `event_status` STRING COMMENT 'Current processing status of the CSO event record in the regulatory reporting workflow.. Valid values are `reported|under_review|validated|closed`',
    `fecal_coliform_cfu_100ml` DECIMAL(18,2) COMMENT 'Measured fecal coliform bacteria concentration in colony-forming units per 100 milliliters from post-event water quality sampling, indicating sewage contamination.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this CSO event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CSO event record was last updated or modified.',
    `ltcp_reference_code` BIGINT COMMENT 'Identifier linking this CSO event to the relevant Long-Term Control Plan project or mitigation strategy designed to reduce or eliminate overflows at this outfall.',
    `monitoring_sample_date` DATE COMMENT 'Date when post-event water quality samples were collected from the receiving water body.',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information about the CSO event recorded by operations or compliance staff.',
    `notification_method` STRING COMMENT 'Method used to notify the regulatory agency of the CSO event (phone call, email, online reporting portal, fax, or automated SCADA notification).. Valid values are `phone|email|online_portal|fax|automated_system`',
    `operator_response_time_minutes` DECIMAL(18,2) COMMENT 'Time in minutes from CSO event detection or alarm to operator acknowledgment and response initiation.',
    `outfall_designation` STRING COMMENT 'Regulatory designation or permit number assigned to the CSO outfall by the state or EPA.',
    `overflow_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated or measured volume of untreated or partially treated wastewater discharged during the CSO event, expressed in gallons.',
    `overflow_volume_mgd` DECIMAL(18,2) COMMENT 'Overflow volume normalized to Million Gallons per Day for regulatory reporting and comparison purposes.',
    `post_event_monitoring_completed` BOOLEAN COMMENT 'Indicates whether required post-event water quality monitoring has been completed and results documented.',
    `post_event_monitoring_required` BOOLEAN COMMENT 'Indicates whether post-event water quality monitoring of the receiving water body is required per permit conditions or LTCP commitments.',
    `precipitation_amount_inches` DECIMAL(18,2) COMMENT 'Total rainfall amount in inches recorded during the storm event that triggered the CSO, measured at the nearest rain gauge or weather station.',
    `precipitation_duration_hours` DECIMAL(18,2) COMMENT 'Duration of the precipitation event in hours that contributed to the CSO occurrence.',
    `public_notification_required` BOOLEAN COMMENT 'Indicates whether public notification (beach closure, advisory signage, media alert) was required based on the location and impact of the CSO event.',
    `public_notification_timestamp` TIMESTAMP COMMENT 'Date and time when public notification was issued regarding the CSO event and potential water quality impacts.',
    `receiving_water_body_classification` STRING COMMENT 'State-designated use classification of the receiving water body (e.g., Class A, Class B, recreational, drinking water source) per state water quality standards.',
    `receiving_water_body_name` STRING COMMENT 'Name of the river, stream, lake, or other water body that received the CSO discharge.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this CSO event triggered regulatory notification requirements to EPA or state environmental agency based on volume, duration, or receiving water sensitivity.',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory agency was notified of the CSO event occurrence, if notification was required.',
    `scada_alarm_triggered` BOOLEAN COMMENT 'Indicates whether a SCADA system alarm was triggered at the time of the CSO event, alerting operators to the overflow condition.',
    `tss_concentration_mg_l` DECIMAL(18,2) COMMENT 'Measured Total Suspended Solids concentration in milligrams per liter from post-event water quality sampling.',
    `volume_estimation_method` STRING COMMENT 'Method used to determine the overflow volume: measured via flow meter, modeled using hydraulic simulation, estimated from duration and outfall characteristics, or calculated from SCADA data.. Valid values are `measured|modeled|estimated|calculated`',
    `created_by` STRING COMMENT 'Username or identifier of the system user or automated process that created this CSO event record.',
    CONSTRAINT pk_cso_event PRIMARY KEY(`cso_event_id`)
) COMMENT 'Transactional record of each Combined Sewer Overflow (CSO) event including event date/time, outfall identifier, precipitation trigger data, estimated overflow volume, receiving water body, CSO long-term control plan (LTCP) reference, regulatory notification status, and post-event monitoring requirements. Supports CWA and NPDES CSO compliance reporting.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` (
    `ii_monitoring_point_id` BIGINT COMMENT 'Unique identifier for the I&I monitoring point record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: I/I monitoring points are installed as part of SSES (Sewer System Evaluation Survey) CIP projects. Link supports project deliverable tracking, baseline establishment for rehabilitation effectiveness m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: I&I monitoring equipment, data analysis, and SSES study costs are allocated to cost centers for rehabilitation program prioritization, capital budget justification, and consent decree compliance cost ',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area to which this monitoring point is assigned for I&I analysis and flow balancing.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: II monitoring equipment (flow meters, data loggers, sensors) are capitalized fixed assets tracked for depreciation and replacement planning. The instrument_serial_number and instrument_type attributes',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: II monitoring points are placed within the functional location hierarchy for field crew routing, basin-level I/I analysis, and rehabilitation prioritization reporting. The location_id links monitoring',
    `manhole_id` BIGINT COMMENT 'Foreign key linking to wastewater.manhole. Business justification: I&I monitoring equipment is commonly installed at manholes, which serve as access points for flow meters and data loggers. Adding manhole_id to ii_monitoring_point establishes the physical installatio',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (manhole, sewer segment, lift station) at which this monitoring point is located.',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: An I&I monitoring point is installed on a specific sewer network segment to measure inflow and infiltration. This FK links the monitoring point to the pipe segment being monitored, enabling correlatio',
    `baseline_dry_weather_flow_gpd` DECIMAL(18,2) COMMENT 'Established baseline flow rate during dry weather conditions measured in gallons per day, used as reference for I&I calculations.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the monitoring instrument to ensure data accuracy.',
    `condition_rating` STRING COMMENT 'Overall condition assessment of the sewer infrastructure at the monitoring point based on inspection findings.. Valid values are `excellent|good|fair|poor|critical`',
    `contributing_area_acres` DECIMAL(18,2) COMMENT 'Size of the drainage area contributing flow to this monitoring point measured in acres.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring point record was first created in the system.',
    `data_logger_reference` STRING COMMENT 'Identifier for the data logger or SCADA Remote Terminal Unit (RTU) collecting data from this monitoring point.',
    `defect_count` STRING COMMENT 'Number of structural or operational defects identified at or near the monitoring point during inspections.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the monitoring point above mean sea level in feet, used for hydraulic gradient analysis.',
    `ii_monitoring_point_status` STRING COMMENT 'Current operational status of the monitoring point in the I&I monitoring program.. Valid values are `active|inactive|planned|decommissioned|maintenance`',
    `infiltration_rate_gpd` DECIMAL(18,2) COMMENT 'Estimated infiltration component of I&I measured in gallons per day, representing groundwater entering the sewer system through defects.',
    `inflow_rate_gpd` DECIMAL(18,2) COMMENT 'Estimated inflow component of I&I measured in gallons per day, representing stormwater entering the sewer system through direct connections.',
    `installation_date` DATE COMMENT 'Date when the monitoring point was installed or established in the collection system.',
    `instrument_serial_number` STRING COMMENT 'Manufacturer serial number of the monitoring instrument for asset tracking and calibration management.',
    `instrument_type` STRING COMMENT 'Specific type or model of instrumentation installed at the monitoring point (e.g., ultrasonic flow meter, area-velocity sensor).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this monitoring point is currently active in the I&I monitoring program.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or data collection event at this monitoring point.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the monitoring point location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the monitoring point location in decimal degrees.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this monitoring point record was last updated in the system.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which data is collected or inspections are performed at this monitoring point.. Valid values are `continuous|daily|weekly|monthly|quarterly|event_based`',
    `monitoring_point_code` STRING COMMENT 'Business identifier or code assigned to the monitoring point for operational reference and field reporting.',
    `monitoring_point_name` STRING COMMENT 'Descriptive name or label for the monitoring point, typically referencing location or purpose.',
    `monitoring_point_type` STRING COMMENT 'Classification of the monitoring point by instrumentation or inspection method used to detect or measure inflow and infiltration.. Valid values are `flow_meter|rain_gauge|smoke_test_zone|cctv_inspection_segment|manhole_inspection|pressure_sensor`',
    `next_scheduled_inspection_date` DATE COMMENT 'Planned date for the next inspection or monitoring event at this point.',
    `notes` STRING COMMENT 'Free-text field for additional observations, special conditions, or operational notes related to the monitoring point.',
    `peak_wet_weather_flow_gpd` DECIMAL(18,2) COMMENT 'Maximum recorded flow rate during wet weather events measured in gallons per day.',
    `pipe_age_years` STRING COMMENT 'Age of the sewer pipe at the monitoring point location measured in years since installation.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Diameter of the sewer pipe at the monitoring point location measured in inches.',
    `pipe_material` STRING COMMENT 'Material composition of the sewer pipe at the monitoring point (e.g., PVC, concrete, clay, cast iron).',
    `rehabilitation_priority_category` STRING COMMENT 'Categorical classification of rehabilitation priority for capital planning and work scheduling.. Valid values are `critical|high|medium|low|deferred`',
    `rehabilitation_priority_score` STRING COMMENT 'Numerical score (typically 1-100) indicating the priority for rehabilitation or repair based on I&I severity, asset condition, and risk factors.',
    `scada_tag` STRING COMMENT 'SCADA system tag or point identifier used to retrieve real-time or historical data from this monitoring point.',
    `wet_weather_flow_multiplier` DECIMAL(18,2) COMMENT 'Multiplier factor representing the ratio of wet weather flow to dry weather flow, indicating the severity of inflow and infiltration.',
    CONSTRAINT pk_ii_monitoring_point PRIMARY KEY(`ii_monitoring_point_id`)
) COMMENT 'Master record for each Inflow and Infiltration (I&I) monitoring point and associated flow measurement history in the collection system. Includes monitoring point type (flow meter, rain gauge, smoke test zone, CCTV inspection segment), location, DMA assignment, baseline dry-weather flow, wet-weather flow multiplier, rehabilitation priority score, and time-series flow measurements with rainfall correlation. Supports I&I reduction programs, sewer system evaluation surveys (SSES), and rehabilitation investment prioritization.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` (
    `ii_flow_measurement_id` BIGINT COMMENT 'Unique identifier for the I&I flow measurement record.',
    `dma_id` BIGINT COMMENT 'Reference to the District Metered Area containing this monitoring point, used for geographic and hydraulic segmentation.',
    `ii_monitoring_point_id` BIGINT COMMENT 'Reference to the specific I&I monitoring point where this flow measurement was captured.',
    `registry_id` BIGINT COMMENT 'Reference to the rain gauge station used to capture rainfall data for this measurement.',
    `sewer_network_id` BIGINT COMMENT 'Reference to the specific sewer network segment (pipe, manhole, or structure) associated with this monitoring point.',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Indicates whether this measurement triggered an alarm condition in the SCADA system due to exceeding thresholds or anomalous patterns.',
    `alarm_type` STRING COMMENT 'Type of alarm triggered by this measurement: high flow, low flow, sensor fault, communication loss, or none.. Valid values are `high_flow|low_flow|sensor_fault|communication_loss|none`',
    `average_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Average flow rate over the measurement period, expressed in gallons per minute.',
    `calculated_ii_volume_gallons` DECIMAL(18,2) COMMENT 'Calculated volume of inflow and infiltration for the measurement period, derived by subtracting the dry weather baseline from the measured flow and integrating over time.',
    `calibration_date` DATE COMMENT 'Date when the flow sensor was last calibrated prior to this measurement, ensuring measurement accuracy.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for the measurement data: valid (passed all checks), suspect (questionable but usable), invalid (failed validation), estimated (imputed value), or missing (no data captured).. Valid values are `valid|suspect|invalid|estimated|missing`',
    `data_quality_notes` STRING COMMENT 'Free-text notes explaining data quality issues, sensor malfunctions, calibration events, or other factors affecting measurement reliability.',
    `data_source` STRING COMMENT 'Origin of the measurement data: SCADA system, manual field reading, mobile device, or third-party monitoring service.. Valid values are `scada|manual|mobile|third_party`',
    `dry_weather_baseline_gpm` DECIMAL(18,2) COMMENT 'Established baseline flow rate during dry weather conditions at this monitoring point, used as the reference for calculating I&I contributions.',
    `flow_velocity_fps` DECIMAL(18,2) COMMENT 'Measured velocity of wastewater flow at the monitoring point, expressed in feet per second.',
    `ii_type` STRING COMMENT 'Classification of the I&I contribution type: infiltration (groundwater seepage), inflow (direct stormwater entry), combined (both), or unknown.. Valid values are `infiltration|inflow|combined|unknown`',
    `measured_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Instantaneous flow rate measured at the monitoring point expressed in gallons per minute.',
    `measured_flow_rate_mgd` DECIMAL(18,2) COMMENT 'Instantaneous flow rate measured at the monitoring point expressed in million gallons per day.',
    `measurement_duration_minutes` STRING COMMENT 'Duration over which the flow measurement was averaged or integrated, expressed in minutes.',
    `measurement_method` STRING COMMENT 'Technology or method used to capture the flow measurement: ultrasonic, magnetic flow meter, weir, flume, or manual reading.. Valid values are `ultrasonic|magnetic|weir|flume|manual`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the flow measurement was recorded at the monitoring point.',
    `minimum_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Minimum instantaneous flow rate observed during the measurement period, expressed in gallons per minute.',
    `peak_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Maximum instantaneous flow rate observed during the measurement period, expressed in gallons per minute.',
    `pipe_depth_fill_percent` DECIMAL(18,2) COMMENT 'Percentage of pipe cross-sectional area filled with wastewater at the time of measurement, indicating hydraulic loading.',
    `rain_gauge_reference` BIGINT COMMENT 'Reference to the rain gauge station used to capture rainfall data for this measurement.',
    `rainfall_depth_inches` DECIMAL(18,2) COMMENT 'Cumulative rainfall depth recorded at the nearest rain gauge corresponding to the measurement timestamp, used to correlate wet-weather flow contributions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement record was last modified.',
    `rehabilitation_priority_score` STRING COMMENT 'Calculated priority score for infrastructure rehabilitation investment based on I&I volume, frequency, and impact, used to rank capital improvement projects.',
    `scada_system_reference` BIGINT COMMENT 'Reference to the SCADA system that collected and transmitted this measurement data.',
    `sensor_reference` BIGINT COMMENT 'Reference to the flow sensor or metering device that captured this measurement.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Temperature of the wastewater at the monitoring point, expressed in degrees Fahrenheit.',
    `validation_status` STRING COMMENT 'Current validation status of the measurement record: pending (awaiting review), validated (approved for use), rejected (excluded from analysis), or under review (being evaluated).. Valid values are `pending|validated|rejected|under_review`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement record was validated or reviewed.',
    `weather_condition` STRING COMMENT 'Weather condition classification at the time of measurement to contextualize flow patterns.. Valid values are `dry|wet|storm|post-storm`',
    CONSTRAINT pk_ii_flow_measurement PRIMARY KEY(`ii_flow_measurement_id`)
) COMMENT 'Transactional record of flow measurements at I&I monitoring points capturing date/time, measured flow rate (GPM/MGD), rainfall depth at nearest gauge, dry-weather baseline comparison, calculated I&I volume, and data quality flag. Used to quantify infiltration and inflow contributions and prioritize rehabilitation investments.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` (
    `industrial_user_permit_id` BIGINT COMMENT 'Unique identifier for the industrial user permit record. Primary key for the IUP registry.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Industrial pretreatment programs require linking discharge permits to service agreements for coordinated billing, service delivery, and compliance enforcement. Water utilities bill industrial users fo',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Under 40 CFR Part 403, industrial user pretreatment permits are legally authorized under the POTWs NPDES permit. Linking IUP to the authorizing treatment_permit enables pretreatment program audits an',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Industrial user permits are issued under the POTWs pretreatment program, which is authorized under the NPDES permit. This FK links the operational IUP to the governing NPDES compliance permit for pre',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Industrial users are commercial/industrial customers with billing accounts. Pretreatment program management requires linking permits to customer accounts for billing industrial wastewater charges, tra',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Industrial pretreatment permits require discharge volume monitoring for compliance and flow-based surcharge calculations. Utilities install dedicated wastewater discharge meters at industrial faciliti',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Industrial user permits are tied to specific facility locations for inspection scheduling, compliance tracking, and enforcement actions. Asset location integration enables spatial analysis of pretreat',
    `industrial_user_id` BIGINT COMMENT 'FK to compliance.industrial_user',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Industrial users are enrolled in specific wastewater service offerings (e.g., industrial discharge, pretreatment service). The IUP governs the terms of that offering. Linking IUP to offering enables b',
    `organization_id` BIGINT COMMENT 'Foreign key linking to customer.organization. Business justification: Pretreatment program management requires linking each IUP to the legal organization entity (industrial discharger). Annual pretreatment reports to EPA/state regulators identify permitted industrial us',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Industrial user permits are issued for specific discharge locations (premises). Pretreatment programs correlate permit conditions with metering data, service agreements, and compliance monitoring at t',
    `pretreatment_iup_id` BIGINT COMMENT 'Foreign key linking to compliance.pretreatment_iup. Business justification: The wastewater.industrial_user_permit (operational permit record) and compliance.pretreatment_iup (compliance tracking record) represent the same permit from different operational perspectives. This F',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Industrial users often contract pretreatment system maintenance, chemical supply, or waste hauling services. Linking permits to service vendors supports compliance monitoring (ensuring contracted pret',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Industrial user pretreatment systems (grease interceptors, pH neutralization tanks) are registered assets subject to inspection and maintenance. Linking industrial_user_permit to the asset registry en',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: IUPs require periodic compliance reports submitted to the regulatory agency (pretreatment annual reports, permit renewal applications). This FK links the permit to its regulatory submission for tracki',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Industrial user permits govern discharge conditions tied to the customers wastewater service agreement. Utilities enforce permit conditions alongside service terms and suspend service for permit viol',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: Pretreatment compliance requires correlating an industrial users water service connection with their discharge permit. Utilities use this link to compare metered water consumption against permitted d',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: An industrial user discharges process wastewater into a specific sewer network segment under their IUP. Adding sewer_network_id to industrial_user_permit identifies the point of discharge into the col',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Industrial pretreatment programs are administered by territory/jurisdiction. Territory assignment on IUPs drives regulatory reporting to primacy agencies, rate zone billing, and pretreatment program a',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: An Industrial User Permit is issued under the authority of a specific WWTPs pretreatment program. The WWTP is the control authority responsible for the IUP. Adding wwtp_id to industrial_user_permit e',
    `bod_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of BOD in milligrams per liter that the industrial user may discharge to the wastewater collection system.',
    `cadmium_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of cadmium in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `categorical_standard_applicable` BOOLEAN COMMENT 'Indicates whether federal categorical pretreatment standards apply to this industrial user based on SIC code and discharge characteristics.',
    `categorical_standard_citation` STRING COMMENT 'Specific CFR citation for the applicable categorical pretreatment standard (e.g., 40 CFR Part 433 for Metal Finishing). Null if non-categorical.',
    `chromium_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total chromium in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `cod_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of COD in milligrams per liter that the industrial user may discharge to the wastewater collection system.',
    `compliance_schedule_final_date` DATE COMMENT 'Final date by which the industrial user must achieve full compliance with all permit discharge limits. Null if no compliance schedule is required.',
    `compliance_schedule_required` BOOLEAN COMMENT 'Indicates whether the permit includes a compliance schedule with milestones for achieving full compliance with discharge limits.',
    `copper_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of copper in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user permit record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the industrial user permit becomes legally binding and enforceable.',
    `expiration_date` DATE COMMENT 'Date on which the industrial user permit expires and must be renewed or reissued. Nullable for indefinite permits subject to periodic review.',
    `flow_limit_gpd` DECIMAL(18,2) COMMENT 'Maximum permitted daily discharge flow rate in gallons per day (GPD) that the industrial user may discharge to the wastewater collection system.',
    `fog_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of FOG in milligrams per liter that the industrial user may discharge. Critical for food service and processing facilities.',
    `inspection_frequency` STRING COMMENT 'Required frequency at which the pretreatment authority will conduct on-site inspections of the industrial facility and pretreatment system.. Valid values are `monthly|quarterly|semi_annual|annual|as_needed`',
    `issuance_date` DATE COMMENT 'Date on which the permit was officially issued by the pretreatment authority.',
    `issuing_authority` STRING COMMENT 'Name of the governmental or utility entity that issued the industrial user permit (e.g., municipal wastewater utility, state environmental agency).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent on-site inspection conducted by the pretreatment authority.',
    `lead_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of lead in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `mercury_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of mercury in milligrams per liter. Heavy metal limit for dental and medical facilities.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this industrial user permit record was last updated in the system.',
    `monitoring_frequency` STRING COMMENT 'Required frequency at which the industrial user must conduct self-monitoring and submit discharge monitoring reports (DMR) to the pretreatment authority.. Valid values are `daily|weekly|monthly|quarterly|semi_annual|annual`',
    `naics_code` STRING COMMENT 'Six-digit NAICS code providing additional industry classification for the industrial user.. Valid values are `^d{6}$`',
    `nickel_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of nickel in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    `permit_number` STRING COMMENT 'Externally-known unique permit number assigned to the industrial user under the pretreatment program. Business identifier for regulatory tracking and compliance reporting.. Valid values are `^IUP-[A-Z0-9]{6,12}$`',
    `permit_status` STRING COMMENT 'Current lifecycle status of the industrial user permit. Active permits are in force; expired permits require renewal; suspended or revoked permits indicate enforcement action.. Valid values are `active|expired|suspended|revoked|pending_renewal|terminated`',
    `permit_type` STRING COMMENT 'Classification of the permit based on discharge characteristics and regulatory applicability. Categorical users are subject to federal categorical pretreatment standards; non-categorical users are subject to local limits only.. Valid values are `categorical|non-categorical|significant_industrial_user|minor_industrial_user`',
    `ph_maximum` DECIMAL(18,2) COMMENT 'Maximum permitted pH level for industrial discharge. Typically 9.0 to 12.5 per local limits.',
    `ph_minimum` DECIMAL(18,2) COMMENT 'Minimum permitted pH level for industrial discharge. Typically 5.0 to 6.0 per local limits.',
    `pretreatment_required` BOOLEAN COMMENT 'Indicates whether the industrial user is required to install and operate an on-site pretreatment system to meet discharge limits.',
    `pretreatment_system_description` STRING COMMENT 'Description of the on-site pretreatment system installed by the industrial user (e.g., oil-water separator, pH neutralization, metals precipitation). Null if no pretreatment is required.',
    `sic_code` STRING COMMENT 'Four-digit SIC code classifying the industrial users primary business activity. Used to determine categorical pretreatment standard applicability.. Valid values are `^d{4}$`',
    `silver_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of silver in milligrams per liter. Heavy metal limit for photographic and metal finishing industries.',
    `total_nitrogen_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total nitrogen in milligrams per liter that the industrial user may discharge.',
    `total_phosphorus_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of total phosphorus in milligrams per liter that the industrial user may discharge.',
    `tss_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of TSS in milligrams per liter that the industrial user may discharge to the wastewater collection system.',
    `zinc_limit_mg_per_l` DECIMAL(18,2) COMMENT 'Maximum permitted concentration of zinc in milligrams per liter. Heavy metal limit for metal finishing and plating industries.',
    CONSTRAINT pk_industrial_user_permit PRIMARY KEY(`industrial_user_permit_id`)
) COMMENT 'Master record for each Industrial User Permit (IUP) issued under the pretreatment program including permit number, industrial user name, SIC code, permitted discharge limits (BOD, COD, TSS, heavy metals, pH, FOG), permit effective and expiration dates, categorical pretreatment standard applicability, compliance schedule milestones, and issuing authority. Authoritative IUP registry for CWA pretreatment compliance.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` (
    `iup_compliance_sample_id` BIGINT COMMENT 'Unique identifier for the compliance sampling event record. Primary key for the IUP compliance sample entity.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Industrial pretreatment compliance samples generate laboratory analytical results stored centrally in analytical_result. Linking IUP compliance samples to their analytical results enables permit limit',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: IUP compliance sampling is routinely performed by contracted analytical laboratories generating AP invoices. The laboratory_report_number and chain_of_custody_number confirm external lab involvement. ',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: IUP sample exceedances trigger pretreatment program violations requiring formal documentation, enforcement response, and corrective action tracking. Essential for industrial user enforcement and EPA p',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: IUP compliance samples are analyzed by contracted analytical laboratories procured as vendors. Linking to supply.vendor enables lab vendor performance tracking, certified lab qualification management,',
    `industrial_user_permit_id` BIGINT COMMENT 'Reference to the industrial user permit under which this compliance sample was collected. Links the sample to the specific permit being monitored.',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the designated sampling point or monitoring location as defined in the IUP permit conditions.',
    `analytical_method` STRING COMMENT 'The EPA-approved analytical method used to analyze the parameter (e.g., EPA 405.1 for BOD, EPA 160.2 for TSS, EPA 200.7 for metals).',
    `chain_of_custody_number` STRING COMMENT 'The unique identifier for the chain of custody documentation that tracks sample handling from collection through analysis. Critical for legal defensibility.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the sample collection, analysis, or compliance determination.',
    `compliance_status` STRING COMMENT 'Determination of whether the measured value meets the permit limit requirements. Core field for pretreatment program enforcement and violation tracking.. Valid values are `compliant|violation|exceedance|not_applicable|pending_review`',
    `composite_duration_hours` DECIMAL(18,2) COMMENT 'For composite samples, the total duration in hours over which the sample was collected (e.g., 24-hour composite). Null for grab samples.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance sample record was first created in the system. Used for audit trail and data lineage tracking.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of the parameter that the analytical method can reliably detect. Used to interpret non-detect results.',
    `enforcement_action_required` BOOLEAN COMMENT 'Indicates whether formal enforcement action is required based on the severity or frequency of the violation. True if enforcement action is warranted.',
    `exceedance_percentage` DECIMAL(18,2) COMMENT 'The percentage by which the measured value exceeds the permit limit, calculated as ((measured_value - permit_limit) / permit_limit) * 100. Null if compliant.',
    `flow_rate_at_sampling` DECIMAL(18,2) COMMENT 'The wastewater flow rate at the time of sample collection, expressed in gallons per minute (GPM) or million gallons per day (MGD). Used for load calculations.',
    `flow_rate_unit` STRING COMMENT 'The unit of measure for the flow rate (gallons per minute, million gallons per day, liters per minute, cubic meters per day).. Valid values are `GPM|MGD|L/min|m3/day`',
    `laboratory_report_number` STRING COMMENT 'The unique report or case number assigned by the laboratory to the analytical results. Used for traceability and audit purposes.',
    `measured_value` DECIMAL(18,2) COMMENT 'The quantitative result of the laboratory analysis for the specified parameter. Represents the concentration or level detected in the sample.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance sample record was last modified. Used for audit trail and change tracking.',
    `parameter_code` STRING COMMENT 'Standardized code identifying the pollutant or water quality parameter analyzed in this sample (e.g., BOD, TSS, pH, heavy metals).',
    `parameter_name` STRING COMMENT 'Full name of the pollutant or water quality parameter analyzed (e.g., Biochemical Oxygen Demand, Total Suspended Solids, Cadmium).',
    `permit_limit` DECIMAL(18,2) COMMENT 'The maximum allowable concentration or discharge limit for this parameter as specified in the industrial user permit. Used to determine compliance status.',
    `permit_limit_type` STRING COMMENT 'The type of permit limit being evaluated (e.g., daily maximum, monthly average). Defines the averaging period and compliance calculation method.. Valid values are `daily_maximum|monthly_average|instantaneous|annual_average`',
    `quantification_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of the parameter that can be quantitatively measured with acceptable precision and accuracy.',
    `result_qualifier` STRING COMMENT 'Laboratory qualifier code indicating special conditions of the result (e.g., J=estimated, U=undetected, ND=non-detect, <MDL=below detection limit).',
    `review_date` DATE COMMENT 'The date on which the compliance determination was reviewed and approved by pretreatment program staff.',
    `reviewed_by` STRING COMMENT 'Name of the pretreatment program staff member who reviewed and validated the compliance determination for this sample.',
    `sample_date` DATE COMMENT 'The date on which the compliance sample was physically collected from the industrial user facility.',
    `sample_location` STRING COMMENT 'Description of the specific sampling point or location within the industrial facility where the sample was collected (e.g., final discharge point, process outfall).',
    `sample_number` STRING COMMENT 'Externally-known unique identifier or tracking number assigned to this compliance sample for laboratory and regulatory reference.',
    `sample_temperature` DECIMAL(18,2) COMMENT 'The temperature of the sample at the time of collection, typically in degrees Celsius. Important for certain parameter analyses and quality control.',
    `sample_time` TIMESTAMP COMMENT 'The precise timestamp when the compliance sample was collected, including time of day. Critical for composite sample timing and chain of custody.',
    `sample_type` STRING COMMENT 'The method of sample collection. Grab samples are instantaneous, composite samples are time- or flow-weighted averages over a collection period.. Valid values are `grab|composite|integrated|continuous`',
    `sample_volume` DECIMAL(18,2) COMMENT 'The volume of sample collected, typically expressed in milliliters or liters. Required for composite sample calculations and quality control.',
    `sample_volume_unit` STRING COMMENT 'The unit of measure for the sample volume (milliliters, liters, gallons).. Valid values are `mL|L|gal`',
    `sampler_name` STRING COMMENT 'Name of the individual who collected the sample. Required for chain of custody and quality assurance documentation.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., mg/L, µg/L, pH units, standard units).',
    `violation_notice_date` DATE COMMENT 'The date on which the notice of violation was issued to the industrial user. Null if no violation notice was issued.',
    `violation_notice_issued` BOOLEAN COMMENT 'Indicates whether a notice of violation (NOV) was issued to the industrial user as a result of this sample exceedance. True if NOV issued, false otherwise.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sampling (e.g., dry, rain, snow). Relevant for evaluating potential dilution or inflow and infiltration impacts.',
    CONSTRAINT pk_iup_compliance_sample PRIMARY KEY(`iup_compliance_sample_id`)
) COMMENT 'Transactional record of each compliance sampling event conducted at an industrial user facility including sample date, sample type (grab, composite), parameters analyzed, measured values, permit limits, compliance determination (compliant/violation), chain of custody reference, and laboratory report reference. Core record for pretreatment program enforcement and annual pretreatment report.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`fog_source` (
    `fog_source_id` BIGINT COMMENT 'Unique identifier for the FOG generating establishment enrolled in the FOG control program.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: FOG-generating establishments are wastewater service customers. Utilities bill for grease interceptor inspections, pumping requirements, and FOG program compliance through service agreements. Links FO',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: FOG control infrastructure (grease interceptors, traps) may be installed via CIP projects (municipal FOG program implementation). Link supports asset tracking, capital cost recovery from establishment',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: FOG program establishments (restaurants, food service facilities) are commercial customers with utility accounts. FOG program management requires linking to customer accounts for billing inspection fe',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: FOG establishments contract licensed waste haulers for grease interceptor pumping. Linking to vendor master enables manifest verification, service frequency compliance monitoring, hauler performance t',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: FOG sources (restaurants, food processors) are placed within the functional location hierarchy for inspection routing, basin-level FOG risk analysis, and sewer maintenance planning. The location_id li',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: A FOG source (restaurant, food service establishment) connects to the sewer via a service point. Linking FOG source to service point enables cross-referencing FOG compliance status with the customers',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: FOG program management links each food service establishment to its service premise for cross-referencing service agreements, meter data, and billing. Inspectors use premise records to correlate FOG c',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Grease interceptors at FOG sources are physical assets requiring maintenance tracking, pumping schedules, condition assessments, and replacement planning. Asset registry integration enables preventive',
    `service_line_id` BIGINT COMMENT 'Foreign key linking to distribution.service_line. Business justification: FOG program management requires linking each grease-generating establishment to its water service connection. Utilities correlate water consumption from the service line with required grease trap pump',
    `sewer_network_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewer_network. Business justification: A FOG-generating establishment (restaurant, food processor) discharges grease-laden wastewater into a specific sewer network segment. Adding sewer_network_id to fog_source enables identification of wh',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: FOG programs are administered by service territory. Territory assignment drives inspection scheduling, territory-level SSO risk reporting, and compliance program annual reports submitted to regulatory',
    `address_line1` STRING COMMENT 'Primary street address of the FOG generating establishment.',
    `address_line2` STRING COMMENT 'Secondary address information such as suite, unit, or building number for the FOG establishment.',
    `best_management_practices_required` STRING COMMENT 'Description of specific best management practices required for the establishment to control FOG discharge and prevent sewer blockages.',
    `city` STRING COMMENT 'City where the FOG generating establishment is located.',
    `compliance_status` STRING COMMENT 'Current compliance status of the establishment with FOG program requirements and permit conditions.. Valid values are `compliant|non_compliant|warning|violation`',
    `contact_email` STRING COMMENT 'Email address for the establishment contact responsible for FOG program compliance and communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person responsible for FOG program compliance at the establishment.',
    `contact_phone` STRING COMMENT 'Primary phone number for the establishment contact responsible for FOG compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the FOG source record was first created in the system.',
    `enrollment_date` DATE COMMENT 'Date when the establishment was enrolled in the FOG control program.',
    `establishment_name` STRING COMMENT 'Legal or trade name of the FOG generating establishment (restaurant, food processor, institutional kitchen).',
    `establishment_type` STRING COMMENT 'Classification of the FOG generating establishment based on business operations and FOG generation profile.. Valid values are `restaurant|food_processor|institutional_kitchen|commercial_kitchen|bakery|other`',
    `inspection_frequency_days` STRING COMMENT 'Scheduled frequency in days for regulatory inspections of the FOG establishment and grease interceptor.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent FOG program compliance inspection conducted at the establishment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the FOG establishment for GIS mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the FOG establishment for GIS mapping and spatial analysis.',
    `next_inspection_date` DATE COMMENT 'Date when the next FOG program compliance inspection is scheduled for the establishment.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the FOG establishment and program management.',
    `permit_expiration_date` DATE COMMENT 'Date when the current FOG permit expires and requires renewal.',
    `permit_issue_date` DATE COMMENT 'Date when the FOG permit was originally issued to the establishment.',
    `permit_number` STRING COMMENT 'Unique permit number issued to the establishment for FOG discharge and control program enrollment.',
    `permit_status` STRING COMMENT 'Current status of the FOG permit indicating compliance standing and authorization to discharge.. Valid values are `active|expired|suspended|revoked|pending|inactive`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the FOG generating establishment location.',
    `required_pumping_frequency_days` STRING COMMENT 'Mandated frequency in days for pumping and cleaning the grease interceptor to prevent FOG buildup and sewer blockages.',
    `risk_rating` STRING COMMENT 'Risk classification of the establishment based on FOG generation volume, compliance history, and potential for sewer blockages.. Valid values are `low|medium|high|critical`',
    `sso_contribution_flag` BOOLEAN COMMENT 'Indicator of whether the establishment has been identified as a contributing source to a sanitary sewer overflow event.',
    `state` STRING COMMENT 'State or province where the FOG generating establishment is located.',
    `termination_date` DATE COMMENT 'Date when the establishment was removed from the FOG control program due to closure, permit revocation, or other reasons.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the FOG source record was last modified in the system.',
    `violation_count` STRING COMMENT 'Total number of FOG program violations recorded for the establishment since enrollment.',
    CONSTRAINT pk_fog_source PRIMARY KEY(`fog_source_id`)
) COMMENT 'Master record for each Fats, Oils, and Grease (FOG) generating establishment and associated inspection history under the FOG control program. Includes business name, address, establishment type (restaurant, food processor, institutional kitchen), grease interceptor size, pumping frequency requirement, permit status, inspection schedule, and inspection event records capturing interceptor condition, grease depth measurements, pumping manifest verification, compliance status, and corrective actions. Supports FOG program management, enforcement documentation, and SSO prevention.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` (
    `fog_inspection_id` BIGINT COMMENT 'Unique identifier for the FOG inspection record. Primary key for the fog_inspection product.',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: FOG inspections that identify violations generate compliance violation records for enforcement tracking. This FK links the inspection finding directly to the compliance violation for enforcement actio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FOG program costs (inspector salaries, vehicle expenses, enforcement actions) are tracked to cost centers for program cost recovery analysis, permit fee setting, and rate design justification.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: FOG inspections finding violations trigger enforcement actions (NOVs, administrative orders, penalties) under pretreatment program authority. Real process: FOG ordinance enforcement workflow from insp',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: FOG inspections are formal inspection events that should be unified with the enterprise inspection management framework for regulatory reporting, inspector scheduling, and corrective action tracking. ',
    `fog_source_id` BIGINT COMMENT 'Identifier of the grease-generating establishment (food service establishment, restaurant, commercial kitchen) being inspected under the FOG program.',
    `registry_id` BIGINT COMMENT 'Identifier or tag number of the grease interceptor (grease trap) inspected at the establishment.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: FOG violations trigger corrective work orders for sewer cleaning, interceptor pumping enforcement, and follow-up inspections. Linking fog_inspection to work_order enables cost tracking for FOG program',
    `best_management_practices_compliant` BOOLEAN COMMENT 'Indicates whether the establishment is following FOG best management practices including proper waste disposal, employee training, and grease minimization procedures.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the establishment based on this inspection: compliant with FOG regulations, non-compliant with violations noted, conditional compliance pending corrective action, or pending review.. Valid values are `compliant|non_compliant|conditional|pending_review`',
    `corrective_action_description` STRING COMMENT 'Detailed description of corrective actions required to achieve compliance, including specific steps the establishment must take.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the establishment must complete required corrective actions to avoid enforcement action.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether the establishment is required to take corrective action to address violations or deficiencies identified during the inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG inspection record was first created in the system.',
    `enforcement_action_recommended` BOOLEAN COMMENT 'Indicates whether the inspector recommends formal enforcement action (notice of violation, administrative order, penalty) based on inspection findings.',
    `enforcement_action_type` STRING COMMENT 'Type of enforcement action recommended: warning letter, notice of violation, administrative order, civil penalty assessment, or permit suspension.. Valid values are `warning|notice_of_violation|administrative_order|civil_penalty|permit_suspension`',
    `establishment_contact_name` STRING COMMENT 'Name of the establishment representative (owner, manager, or designated contact) present during the inspection.',
    `establishment_contact_signature` STRING COMMENT 'Digital signature or acknowledgment indicator from the establishment contact confirming receipt of inspection findings and corrective action requirements.',
    `grease_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth of accumulated grease layer in the interceptor in inches. Excessive depth indicates need for pumping and cleaning.',
    `grease_depth_percentage` DECIMAL(18,2) COMMENT 'Grease accumulation as a percentage of total interceptor capacity. Regulatory thresholds typically require pumping at 25% accumulation.',
    `hauler_license_number` STRING COMMENT 'License number of the grease hauling contractor used by the establishment for interceptor pumping and waste disposal.',
    `inspection_date` DATE COMMENT 'Date when the FOG inspection was conducted at the establishment.',
    `inspection_notes` STRING COMMENT 'Free-form notes and observations recorded by the inspector during the FOG inspection, including additional context not captured in structured fields.',
    `inspection_number` STRING COMMENT 'Business-facing unique inspection number assigned to this FOG inspection for tracking and reference purposes.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the FOG inspection: scheduled, in progress, completed, cancelled, or failed to complete.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `inspection_time` TIMESTAMP COMMENT 'Precise timestamp when the FOG inspection began, including time of day.',
    `inspection_type` STRING COMMENT 'Classification of the FOG inspection type: routine scheduled inspection, follow-up after violation, complaint-driven, pre-permit issuance, annual compliance, or re-inspection after corrective action.. Valid values are `routine|follow_up|complaint_driven|pre_permit|annual|re_inspection`',
    `inspector_name` STRING COMMENT 'Full name of the inspector who conducted the FOG inspection.',
    `interceptor_capacity_gallons` DECIMAL(18,2) COMMENT 'Rated capacity of the grease interceptor in gallons, indicating the volume of wastewater it can process.',
    `interceptor_condition` STRING COMMENT 'Physical condition assessment of the grease interceptor at time of inspection: good working order, fair with minor issues, poor requiring maintenance, critical requiring immediate action, or not accessible for inspection.. Valid values are `good|fair|poor|critical|not_accessible`',
    `interceptor_type` STRING COMMENT 'Type of grease interceptor installed: gravity interceptor, hydromechanical grease interceptor, automatic grease removal device, or passive grease trap.. Valid values are `gravity|hydromechanical|automatic|passive`',
    `last_pumping_date` DATE COMMENT 'Date when the grease interceptor was last pumped and cleaned, as reported by the establishment or verified from manifest records.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FOG inspection record was last modified or updated.',
    `photo_count` STRING COMMENT 'Number of photographs taken during the inspection and attached to the inspection record.',
    `photos_taken` BOOLEAN COMMENT 'Indicates whether photographic documentation was captured during the inspection for evidence and record-keeping purposes.',
    `pumping_frequency_days` STRING COMMENT 'Required or observed frequency of grease interceptor pumping in days, based on establishment type and grease generation rate.',
    `pumping_manifest_verified` BOOLEAN COMMENT 'Indicates whether the inspector verified the pumping manifest documentation from a licensed hauler for the most recent grease interceptor pumping event.',
    `re_inspection_date` DATE COMMENT 'Scheduled date for the follow-up re-inspection to verify corrective action completion.',
    `re_inspection_required` BOOLEAN COMMENT 'Indicates whether a follow-up re-inspection is required to verify corrective action completion and compliance restoration.',
    `solids_depth_inches` DECIMAL(18,2) COMMENT 'Measured depth of settled solids at the bottom of the interceptor in inches.',
    `sso_risk_assessment` STRING COMMENT 'Inspector assessment of the risk that this establishments FOG discharge practices pose to causing a sanitary sewer overflow event: low, moderate, high, or imminent risk.. Valid values are `low|moderate|high|imminent`',
    `violation_count` STRING COMMENT 'Number of distinct FOG program violations identified during this inspection.',
    `violation_description` STRING COMMENT 'Detailed description of all FOG program violations noted during the inspection, including specific regulatory requirements not met.',
    `violation_severity` STRING COMMENT 'Severity classification of the most serious violation identified: minor administrative issue, moderate operational deficiency, major compliance failure, or critical risk to sewer system.. Valid values are `minor|moderate|major|critical`',
    `violations_noted` BOOLEAN COMMENT 'Indicates whether any FOG program violations were identified during this inspection.',
    CONSTRAINT pk_fog_inspection PRIMARY KEY(`fog_inspection_id`)
) COMMENT 'Transactional record of each FOG program inspection at a grease-generating establishment including inspection date, inspector, interceptor condition, grease depth measurement, pumping manifest verification, compliance status, violations noted, corrective action required, and re-inspection date. Supports FOG enforcement and SSO prevention program documentation.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` (
    `biosolids_batch_id` BIGINT COMMENT 'Unique identifier for the biosolids production batch. Primary key for the biosolids batch record.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: EPA 503 regulations require laboratory analytical results for metals and pathogens before biosolids land application. Each biosolids batch must link to its lab analytical result for compliance determi',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Each biosolids batch generates an AP invoice from the hauler/disposal vendor for transport and land application or disposal fees. Utilities must reconcile batch records with vendor invoices for three-',
    `ar_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.ar_transaction. Business justification: Exceptional quality biosolids sold for beneficial reuse (land application, composting) generate AR transactions for revenue recognition. Linking batch records to AR transactions enables biosolids reve',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Biosolids treatment facilities/upgrades are delivered via CIP projects. Linking batches to the project that commissioned the treatment infrastructure supports performance validation, regulatory compli',
    `compliance_permit_id` BIGINT COMMENT 'Reference to the NPDES permit under which this biosolids batch was produced. Links batch to permit limits and reporting requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Biosolids treatment and disposal costs (dewatering, hauling, testing, land application) are tracked to cost centers for unit cost analysis, budget planning, and rate case support of biosolids manageme',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Biosolids hauling/disposal is procured via purchase orders. Linking each biosolids batch to its governing PO enables three-way match (PO/batch/vendor invoice) for disposal cost reconciliation — a requ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Biosolids hauling and land application services are contracted to specialized vendors. Regulatory traceability requires linking each batch to the licensed hauler for manifest compliance (40 CFR 503), ',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Biosolids batches require regulatory submissions (EPA Part 503 annual reports, state land application reports). This FK links each batch to its regulatory submission for tracking submission status, ag',
    `process_unit_id` BIGINT COMMENT 'Reference to the specific treatment process unit (digester, dewatering equipment, stabilization system) that produced this batch.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Biosolids processing operations generate maintenance work orders when equipment (centrifuges, belt presses, dryers) fails during batch processing. Work order linkage enables equipment failure cost all',
    `wwtp_id` BIGINT COMMENT 'Reference to the wastewater treatment plant where this biosolids batch was produced.',
    `arsenic_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Arsenic concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 75 mg/kg per 40 CFR Part 503 Table 1.',
    `batch_date` DATE COMMENT 'The date when this biosolids batch was produced and removed from the treatment process. Critical for regulatory compliance and shelf-life tracking.',
    `batch_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the biosolids batch production process was completed and the material was ready for disposition.',
    `batch_number` STRING COMMENT 'Business-assigned unique batch number or identifier for tracking and traceability purposes. Used in regulatory reporting and chain-of-custody documentation.',
    `batch_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the biosolids batch production process began, including dewatering or stabilization initiation.',
    `cadmium_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Cadmium concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 85 mg/kg per 40 CFR Part 503 Table 1.',
    `copper_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Copper concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 4,300 mg/kg per 40 CFR Part 503 Table 1.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this biosolids batch record was first created in the system. Used for audit trail and data lineage tracking.',
    `disposition_date` DATE COMMENT 'The date when this biosolids batch was disposed of, applied to land, or transferred for beneficial reuse. Required for regulatory tracking and chain-of-custody documentation.',
    `disposition_method` STRING COMMENT 'The final disposition method for this biosolids batch. Determines applicable regulatory requirements under 40 CFR Part 503 Subparts B, C, D, or E.. Valid values are `land_application|landfill|incineration|beneficial_reuse|composting|surface_disposal`',
    `disposition_site_name` STRING COMMENT 'Name of the land application site, landfill, incinerator, or beneficial reuse facility where this batch was sent.',
    `disposition_site_permit_number` STRING COMMENT 'Regulatory permit number for the disposition site (land application permit, landfill permit, incinerator air permit, etc.).',
    `dmr_reporting_period` STRING COMMENT 'The monthly or quarterly DMR reporting period (YYYY-MM format) to which this batch should be included. Used for automated DMR preparation.',
    `dry_weight_tons` DECIMAL(18,2) COMMENT 'Total dry weight of the biosolids batch in US tons (2,000 lbs). Used for regulatory reporting, disposal tracking, and beneficial use application rate calculations.',
    `exceptional_quality_flag` BOOLEAN COMMENT 'Indicates whether this batch meets Exceptional Quality criteria (Class A pathogen reduction, pollutant concentration limits per Table 3, and vector attraction reduction). EQ biosolids have no federal land application restrictions.',
    `fecal_coliform_density_mpn_per_gram` DECIMAL(18,2) COMMENT 'Fecal coliform density in MPN per gram of total solids (dry weight basis). Class A requires <1,000 MPN/g; Class B requires <2,000,000 MPN/g.',
    `laboratory_analysis_date` DATE COMMENT 'Date when laboratory analysis of this batch was completed. Used to verify compliance with monitoring frequency requirements.',
    `lead_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Lead concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 840 mg/kg per 40 CFR Part 503 Table 1.',
    `mercury_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Mercury concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 57 mg/kg per 40 CFR Part 503 Table 1.',
    `nickel_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Nickel concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 420 mg/kg per 40 CFR Part 503 Table 1.',
    `notes` STRING COMMENT 'Free-text notes regarding batch production, quality issues, special handling requirements, or other operational observations.',
    `pathogen_class` STRING COMMENT 'Classification of pathogen reduction achieved: Class A (unrestricted use, meets PFRP requirements) or Class B (restricted use, meets PSRP requirements) per 40 CFR Part 503.. Valid values are `class_a|class_b`',
    `percent_solids` DECIMAL(18,2) COMMENT 'Percentage of total solids content in the biosolids batch. Typical range: 15-30% for dewatered cake, 90%+ for dried pellets. Critical for vector attraction reduction Option 7 (75% solids minimum).',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the biosolids batch. Required for alkaline stabilization processes (pH 12+ for 2 hours minimum per vector attraction reduction Option 6).',
    `salmonella_density_mpn_per_4_grams` DECIMAL(18,2) COMMENT 'Salmonella sp. bacteria density in MPN per 4 grams of total solids (dry weight basis). Class A requires <3 MPN/4g.',
    `selenium_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Selenium concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 100 mg/kg per 40 CFR Part 503 Table 1.',
    `total_nitrogen_percent` DECIMAL(18,2) COMMENT 'Total nitrogen content as percentage of dry weight. Important for agronomic application rate calculations and nutrient management planning.',
    `total_phosphorus_percent` DECIMAL(18,2) COMMENT 'Total phosphorus content as percentage of dry weight. Critical for land application planning and nutrient management compliance.',
    `total_potassium_percent` DECIMAL(18,2) COMMENT 'Total potassium content as percentage of dry weight. Used for fertilizer value assessment and agronomic rate calculations.',
    `treatment_process_type` STRING COMMENT 'The primary treatment process used to stabilize this biosolids batch. Determines pathogen reduction and vector attraction reduction requirements.. Valid values are `anaerobic_digestion|aerobic_digestion|lime_stabilization|composting|heat_drying|alkaline_stabilization`',
    `vector_attraction_reduction_method` STRING COMMENT 'The specific vector attraction reduction option (1-10) applied per 40 CFR Part 503.33. Options include volatile solids reduction, digestion, pH adjustment, moisture reduction, and others.. Valid values are `option_1|option_2|option_3|option_4|option_5|option_6`',
    `volatile_solids_reduction_percent` DECIMAL(18,2) COMMENT 'Percentage reduction in volatile solids achieved during treatment. Required for vector attraction reduction Options 1 and 2 (38% minimum reduction).',
    `wet_weight_tons` DECIMAL(18,2) COMMENT 'Total wet weight (as-hauled) of the biosolids batch in US tons. Used for transportation logistics and disposal facility invoicing.',
    `zinc_concentration_mg_per_kg` DECIMAL(18,2) COMMENT 'Zinc concentration in milligrams per kilogram dry weight. Ceiling concentration limit: 7,500 mg/kg per 40 CFR Part 503 Table 1.',
    CONSTRAINT pk_biosolids_batch PRIMARY KEY(`biosolids_batch_id`)
) COMMENT 'Transactional record of each biosolids production batch and its final disposition including land application events. Captures batch production details (date, source WWTP, treatment process, dry weight tonnage, pathogen reduction class per 40 CFR Part 503, vector attraction reduction method, pollutant concentrations) and disposition records including land application specifics (site identifier, field acreage, application rate, cumulative pollutant loading, agronomic rate justification, buffer zone compliance). Supports complete biosolids chain-of-custody from production through beneficial reuse or disposal per Part 503 requirements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` (
    `sewer_inspection_id` BIGINT COMMENT 'Unique identifier for each sewer inspection event. Primary key for the sewer inspection data product.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Contracted CCTV and PACP sewer inspections generate AP invoices from inspection vendors. Utilities must match inspection records to vendor invoices for payment approval, capital project cost capitaliz',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: CCTV inspections conducted as part of CIP projects (pre-construction baseline, post-construction acceptance) must be linked to the project for deliverable tracking, payment certification, warranty bas',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: PACP/MACP inspection results feed formal condition assessment records used for CIP prioritization and rehabilitation planning. Linking sewer_inspection to condition_assessment enables the inspection d',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Sewer CCTV and rehabilitation inspections are performed under construction contracts. Project managers and asset engineers need to know which construction contract authorized a given sewer inspection ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CCTV inspection program costs (contractor fees, equipment depreciation, staff time) are allocated to cost centers for capital planning budgets, asset management program funding, and rate case support.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Sewer CCTV inspections are formal inspection events in the enterprise inspection framework. Linking sewer_inspection to inspection_event unifies sewer inspection records with enterprise scheduling, re',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Sewer CCTV/inspection work is performed by contracted vendors procured through supply chain. Linking to supply.vendor enables contractor performance tracking, invoice reconciliation, and vendor qualif',
    `manhole_id` BIGINT COMMENT 'Foreign key reference to the manhole inspected, when the asset type is manhole.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Sewer lateral inspections (CCTV, smoke testing) are conducted at specific customer premises for property transfer programs, I/I investigations, and complaint resolution. Linking sewer_inspection to pr',
    `project_permit_id` BIGINT COMMENT 'Foreign key linking to project.project_permit. Business justification: Project permits frequently require pre- and post-construction sewer condition inspections as permit conditions. Linking sewer_inspection to the governing project_permit enables permit compliance track',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Sewer CCTV and MACP inspections are performed on registered pipe assets. Linking sewer_inspection to the asset registry enables condition data to flow into the asset lifecycle record, supporting CIP p',
    `sewer_network_id` BIGINT COMMENT 'Foreign key reference to the sewer pipe segment inspected, when the asset type is pipe.',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Sewer CCTV/PACP inspections routinely collect water samples during field work to analyze infiltration water quality, identify contamination sources, or assess groundwater intrusion chemistry. Links in',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the maintenance work order or service request that triggered this inspection, linking inspection to asset management workflows.',
    `asset_identifier` STRING COMMENT 'Business-facing identifier or tag of the specific asset inspected (pipe segment number, manhole number, etc.), used for field reference and reporting.',
    `asset_type` STRING COMMENT 'The type of sewer infrastructure asset being inspected, distinguishing between pipes, manholes, and other components.. Valid values are `pipe|manhole|lateral|junction|cleanout`',
    `condition_grade` STRING COMMENT 'Overall structural condition rating of the inspected asset based on NASSCO PACP or MACP grading scale (1=excellent, 5=imminent failure). Primary output of the inspection.. Valid values are `1|2|3|4|5`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system, for audit trail and data lineage tracking.',
    `critical_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether any critical or high-severity defects were identified that require immediate attention or emergency repair.',
    `defect_codes` STRING COMMENT 'Comma-separated list of NASSCO defect codes identified during the inspection (e.g., CL for crack longitudinal, RB for roots, DP for deformed pipe), used for detailed condition analysis.',
    `defect_count` STRING COMMENT 'Total number of discrete defects identified during the inspection, used as a quick indicator of asset condition complexity.',
    `downstream_manhole_number` STRING COMMENT 'Identifier of the downstream manhole for pipe segment inspections, establishing the ending point of the inspection run.',
    `estimated_repair_cost_usd` DECIMAL(18,2) COMMENT 'Preliminary cost estimate in US dollars for the recommended repair or rehabilitation action, used for capital planning and budget forecasting.',
    `flow_condition` STRING COMMENT 'Flow level observed in the pipe during inspection, impacting visibility and the ability to assess certain defects.. Valid values are `dry|low|medium|high|surcharge`',
    `fog_accumulation_flag` BOOLEAN COMMENT 'Boolean indicator of whether FOG buildup was observed, requiring cleaning and potentially indicating FOG program enforcement needs.',
    `infiltration_observed_flag` BOOLEAN COMMENT 'Boolean indicator of whether infiltration or inflow was observed during the inspection, contributing to non-revenue water and treatment plant overload.',
    `inspection_date` DATE COMMENT 'The date on which the sewer inspection was performed. Principal business event timestamp for this transaction.',
    `inspection_direction` STRING COMMENT 'Direction of travel during the inspection relative to flow direction, relevant for CCTV and sonar inspections of pipe segments.. Valid values are `upstream|downstream`',
    `inspection_length_feet` DECIMAL(18,2) COMMENT 'Total length of pipe segment inspected, measured in feet, used to calculate condition per linear foot and prioritize rehabilitation.',
    `inspection_method` STRING COMMENT 'The technology or technique used to perform the inspection. CCTV is the most common method for pipe condition assessment.. Valid values are `CCTV|sonar|smoke_test|dye_test|visual|laser_profiling`',
    `inspection_number` STRING COMMENT 'Business-facing unique identifier or work order number assigned to this inspection event for tracking and reference purposes.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record, tracking workflow from scheduling through final approval and integration into asset records.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `inspection_time` TIMESTAMP COMMENT 'Precise timestamp when the inspection commenced, including time of day for scheduling and operational tracking.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose or trigger, distinguishing between scheduled maintenance, reactive response, and compliance-driven inspections.. Valid values are `routine|emergency|post_repair|pre_construction|complaint_driven|regulatory`',
    `inspector_certification_number` STRING COMMENT 'Professional certification number of the inspector, typically NASSCO PACP or MACP certification, ensuring qualified personnel perform assessments.',
    `inspector_name` STRING COMMENT 'Name of the individual technician or engineer who performed the inspection, for accountability and quality assurance.',
    `macp_score` STRING COMMENT 'Numeric MACP score calculated from defect observations, representing the overall structural and operational condition of the manhole.',
    `notes` STRING COMMENT 'Free-text field for additional observations, context, or special conditions noted during the inspection that do not fit structured fields.',
    `operational_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether operational defects (roots, grease, debris, infiltration, exfiltration) were observed, impacting flow capacity.',
    `pacp_score` STRING COMMENT 'Numeric PACP score calculated from defect observations, representing the overall structural and operational condition of the pipe segment.',
    `pipe_diameter_inches` DECIMAL(18,2) COMMENT 'Internal diameter of the pipe inspected, measured in inches, relevant for capacity and defect severity assessment.',
    `pipe_material` STRING COMMENT 'Material composition of the pipe inspected (e.g., vitrified clay, PVC, concrete, cast iron), influencing defect types and rehabilitation methods.',
    `recommended_action` STRING COMMENT 'Recommended maintenance or capital action based on inspection findings, guiding asset management and CIP prioritization decisions.. Valid values are `no_action|monitor|cleaning|spot_repair|rehabilitation|replacement`',
    `rehabilitation_method` STRING COMMENT 'Specific rehabilitation technique recommended if repair or renewal is needed (e.g., CIPP lining, pipe bursting, open-cut replacement, spot repair, manhole lining).',
    `report_file_path` STRING COMMENT 'File system path or URL to the formal inspection report document, typically in PDF format, for regulatory and asset management records.',
    `review_date` DATE COMMENT 'Date on which the inspection report was reviewed and approved by qualified personnel, completing the quality assurance process.',
    `reviewed_by` STRING COMMENT 'Name of the engineer or supervisor who reviewed and validated the inspection findings, ensuring quality control and technical accuracy.',
    `root_intrusion_flag` BOOLEAN COMMENT 'Boolean indicator of whether tree root intrusion was observed, a common cause of blockages and structural damage in gravity sewers.',
    `structural_defect_flag` BOOLEAN COMMENT 'Boolean indicator of whether structural defects (cracks, fractures, collapse, deformation) were observed, impacting asset integrity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last modified, supporting change tracking and audit compliance.',
    `upstream_manhole_number` STRING COMMENT 'Identifier of the upstream manhole for pipe segment inspections, establishing the starting point of the inspection run.',
    `urgency_classification` STRING COMMENT 'Priority level assigned to the recommended action, used to sequence capital projects and maintenance work in the CIP and O&M budgets.. Valid values are `immediate|high|medium|low|routine`',
    `video_file_path` STRING COMMENT 'File system path or URL to the recorded CCTV or sonar video file, enabling review and validation of inspection findings.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection (dry, wet, recent rain), relevant for interpreting infiltration and flow observations.',
    CONSTRAINT pk_sewer_inspection PRIMARY KEY(`sewer_inspection_id`)
) COMMENT 'Transactional record of each sewer pipe or manhole inspection event including inspection date, inspection method (CCTV, sonar, smoke test, dye test), inspector or contractor, pipe segment or manhole inspected, condition grade (NASSCO PACP/MACP rating), defect codes identified, recommended rehabilitation method (CIPP, pipe bursting, spot repair), and urgency classification. Feeds asset renewal planning and CIP prioritization.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`wastewater`.`outfall` (
    `outfall_id` BIGINT COMMENT 'Primary key for outfall',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Outfall construction and modification is a CIP capital project activity. Capital planners and asset managers need to link an outfall to the CIP project that constructed or last modified it for project',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Outfalls are individually regulated under NPDES permits; permit limits and monitoring requirements are assigned per outfall. This FK supports DMR reporting, effluent limit lookups, and permit complian',
    `project_permit_id` BIGINT COMMENT 'Foreign key linking to project.project_permit. Business justification: Outfall construction and modification requires project permits (environmental, Section 404, coastal). Role-prefix construction_ distinguishes this from the operational NPDES permit. Water utilities ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outfall monitoring, inspection, and maintenance costs must be attributed to a cost center for O&M budgeting and rate case support. Regulatory agencies require outfall-specific cost tracking for NPDES ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Outfalls are capital infrastructure assets requiring GASB 34 capitalization, depreciation tracking, and inclusion in the fixed asset register. A water utility asset accountant would expect every outfa',
    `metering_meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: NPDES permits require continuous or periodic flow measurement at permitted outfalls for DMR reporting. Linking outfall to its registered flow meter enables traceability of discharge volume measurement',
    `primary_outfall_id` BIGINT COMMENT 'Self-referencing FK on outfall (primary_outfall_id)',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Outfalls are physical infrastructure assets subject to NPDES permit requirements, inspection, and maintenance. Registering outfalls in the asset registry enables lifecycle management, condition tracki',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sampling_point. Business justification: NPDES compliance requires each outfall to have a designated effluent sampling point for DMR reporting. Regulators and operators must know which quality_sampling_point is the official monitoring locati',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Outfalls are regulated under NPDES permits by territory/jurisdiction. Territory assignment on outfalls enables territory-level NPDES compliance reporting, permit tracking, and discharge monitoring rep',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: An outfall is owned and operated by a specific WWTP — it is the physical discharge point for treated effluent from that facility. Adding wwtp_id to outfall establishes this ownership relationship, ena',
    `actual_flow_cms` DECIMAL(18,2) COMMENT 'Most recent measured flow rate at the outfall.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status based on latest monitoring.',
    `construction_year` STRING COMMENT 'Year the outfall infrastructure was constructed.',
    `county` STRING COMMENT 'County where the outfall is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the outfall record was first created in the system.',
    `design_capacity_cms` DECIMAL(18,2) COMMENT 'Maximum designed flow rate the outfall can safely convey.',
    `discharge_point_type` STRING COMMENT 'Indicates whether the outfall is a point source or diffuse source.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Elevation of the outfall above mean sea level.',
    `hydraulic_retention_time_seconds` STRING COMMENT 'Time water spends in the outfall conveyance system.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.',
    `is_monitored` BOOLEAN COMMENT 'Indicates whether the outfall is subject to routine monitoring.',
    `is_public_access` BOOLEAN COMMENT 'Indicates whether the outfall location is publicly accessible.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the outfall location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the outfall location.',
    `maintenance_status` STRING COMMENT 'Current maintenance condition of the outfall.',
    `monitoring_frequency` STRING COMMENT 'How often the outfall is monitored for water quality.',
    `outfall_code` STRING COMMENT 'External identifier or code assigned to the outfall by the utility or regulatory agency.',
    `outfall_description` STRING COMMENT 'Free‑text description of the outfall, including any special characteristics.',
    `outfall_name` STRING COMMENT 'Human‑readable name of the outfall location.',
    `outfall_status` STRING COMMENT 'Current operational status of the outfall.',
    `outfall_type` STRING COMMENT 'Category describing the nature of the outfall discharge point.',
    `state` STRING COMMENT 'State jurisdiction of the outfall.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the outfall record.',
    `water_quality_parameter` STRING COMMENT 'Primary water quality metric monitored at the outfall.',
    CONSTRAINT pk_outfall PRIMARY KEY(`outfall_id`)
) COMMENT 'Master reference table for outfall. Referenced by outfall_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_effluent_discharge_event_id` FOREIGN KEY (`effluent_discharge_event_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`effluent_discharge_event`(`effluent_discharge_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_lift_station_id` FOREIGN KEY (`lift_station_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`lift_station`(`lift_station_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_ii_monitoring_point_id` FOREIGN KEY (`ii_monitoring_point_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`ii_monitoring_point`(`ii_monitoring_point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_fog_source_id` FOREIGN KEY (`fog_source_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`fog_source`(`fog_source_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_primary_outfall_id` FOREIGN KEY (`primary_outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`wastewater` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `water_utilities_ecm`.`wastewater` SET TAGS ('dbx_domain' = 'wastewater');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'NPDES (National Pollutant Discharge Elimination System) Permit ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Manhole ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow (MGD - Million Gallons per Day)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Criticality Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity (MGD - Million Gallons per Day)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `downstream_invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Downstream Invert Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `easement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Easement Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `fog_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'FOG (Fats Oils and Grease) Risk Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `gis_geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Geometry (WKT)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `hydrogen_sulfide_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Risk Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `length_feet` SET TAGS ('dbx_business_glossary_term' = 'Segment Length (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `lining_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Lining Installation Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `lining_type` SET TAGS ('dbx_business_glossary_term' = 'Pipe Lining Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `lining_type` SET TAGS ('dbx_value_regex' = 'none|cipp|spray_on|slip_lining|grout');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|planned|under_construction');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|private|municipal|joint');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `peak_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow (GPM - Gallons per Min)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost (USD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `root_intrusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Intrusion Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `segment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Segment Business Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'gravity_sewer|force_main|interceptor|trunk_line|lateral|service_connection');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `slope_percent` SET TAGS ('dbx_business_glossary_term' = 'Pipe Slope (Percent)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `sso_history_count` SET TAGS ('dbx_business_glossary_term' = 'SSO (Sanitary Sewer Overflow) History Count');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Traffic Impact Level');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ALTER COLUMN `upstream_invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Upstream Invert Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Drainage Basin Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `cover_type` SET TAGS ('dbx_business_glossary_term' = 'Manhole Cover Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `cover_type` SET TAGS ('dbx_value_regex' = 'standard|watertight|bolted|vented|traffic_rated|solid');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Manhole Depth (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Manhole Diameter (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `inflow_infiltration_flag` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Invert Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `macp_score` SET TAGS ('dbx_business_glossary_term' = 'Manhole Assessment and Certification Program (MACP) Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Manhole Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `manhole_status` SET TAGS ('dbx_business_glossary_term' = 'Manhole Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `manhole_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|planned|under_construction|decommissioned');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `manhole_type` SET TAGS ('dbx_business_glossary_term' = 'Manhole Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `ownership` SET TAGS ('dbx_business_glossary_term' = 'Ownership');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `ownership` SET TAGS ('dbx_value_regex' = 'utility|municipal|private|state|federal|joint');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `rim_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Rim Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `scada_monitored_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitored Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `sso_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) History Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_business_glossary_term' = 'Traffic Load Rating');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_value_regex' = 'light_duty|medium_duty|heavy_duty|extra_heavy_duty');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `lift_station_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Metering Meter Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost in United States Dollars (USD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Capacity in Kilowatts (kW)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_value_regex' = 'generator|battery|none|dual_feed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `design_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity in Million Gallons Per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life in Years');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `force_main_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Force Main Diameter in Inches');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `force_main_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Force Main Length in Feet');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `force_main_material` SET TAGS ('dbx_business_glossary_term' = 'Force Main Material');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `force_main_material` SET TAGS ('dbx_value_regex' = 'ductile_iron|pvc|hdpe|steel|concrete');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `last_rehabilitation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rehabilitation Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `number_of_pumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Pumps');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|standby|maintenance|decommissioned|under_construction');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|private|developer|municipal|joint');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `pump_configuration` SET TAGS ('dbx_business_glossary_term' = 'Pump Configuration');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `pump_configuration` SET TAGS ('dbx_value_regex' = 'duplex|triplex|quadruplex|simplex');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `pump_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Pump Horsepower (HP)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost in United States Dollars (USD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `service_area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `service_area_population` SET TAGS ('dbx_business_glossary_term' = 'Service Area Population');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `sso_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Risk Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `station_type` SET TAGS ('dbx_value_regex' = 'submersible|dry_pit|wet_pit|pneumatic|grinder');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_value_regex' = 'online|offline|intermittent|not_installed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `total_dynamic_head_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Dynamic Head (TDH) in Feet');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ALTER COLUMN `wet_well_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Wet Well Volume in Gallons');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|exceptional_quality|not_applicable');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_management_method` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Management Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_management_method` SET TAGS ('dbx_value_regex' = 'land_application|incineration|landfill|composting|beneficial_reuse');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|consent_decree|administrative_order');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_value_regex' = 'chlorine|uv|ozone|none');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `effluent_discharge_point` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Point');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `energy_consumption_kwh_per_mg` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Kilowatt-Hours per Million Gallons (kWh/MG)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_business_glossary_term' = 'Facility Email Address');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'municipal|industrial|combined|satellite');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|standby|decommissioned|under_construction');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Level');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Required');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `peak_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Classification');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_value_regex' = 'preliminary|primary|secondary|tertiary|advanced');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `bypass_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bypass Notification Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `bypass_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Bypass Reason Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exceedance|violation');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Discharge Authorization Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Discharge Duration (Hours)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge End Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Discharge Flow Rate Gallons per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Latitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point Longitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_point_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discharge Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_status` SET TAGS ('dbx_value_regex' = 'authorized|unauthorized|emergency|bypass|planned|unplanned');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_type` SET TAGS ('dbx_value_regex' = 'continuous|intermittent|batch|emergency_bypass|planned_bypass');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `discharge_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Discharge Volume Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `dmr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `dmr_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submitted Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Discharge Event Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `permit_limit_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `rainfall_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Amount (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `receiving_water_body_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Classification');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `scada_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Event ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level Achieved');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|advanced|partial|none');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `treatment_level_achieved` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_parameter_result_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Parameter Result ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `dmr_id` SET TAGS ('dbx_business_glossary_term' = 'Dmr Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `effluent_discharge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Point ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analysis Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|pending_review');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `data_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Data Validation Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `data_validation_status` SET TAGS ('dbx_value_regex' = 'draft|validated|approved|rejected');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `laboratory_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Batch Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `mass_loading_lbs_per_day` SET TAGS ('dbx_business_glossary_term' = 'Mass Loading Pounds per Day');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_value_regex' = 'daily_maximum|monthly_average|weekly_average|instantaneous_maximum|annual_average');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `permit_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Value');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_value_regex' = 'passed|failed|suspect|not_performed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `quantitation_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantitation Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'EPA|state_primacy_agency');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `result_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Time');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite_24hr|composite_flow_weighted|continuous');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `sso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Source Water Intake Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `lift_station_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Station Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'SSO Cause Category');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_value_regex' = 'blockage|capacity_exceedance|equipment_failure|power_failure|operator_error|vandalism');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'SSO Cause Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'SSO Cause Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `discovered_by` SET TAGS ('dbx_business_glossary_term' = 'Discovered By');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `discovered_by` SET TAGS ('dbx_value_regex' = 'utility_staff|customer_complaint|routine_inspection|scada_alarm|third_party|other');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `dmr_reported` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reported Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'DMR Reporting Period');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'SSO Duration (Minutes)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Taken');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `enforcement_action_taken` SET TAGS ('dbx_value_regex' = 'none|warning|notice_of_violation|consent_order|penalty|other');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `estimated_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Estimated Spill Volume (Gallons)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SSO Event End Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^SSO-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|corrective_action_in_progress|resolved|closed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Overflow Location Address');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SSO Event Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `overflow_location_type` SET TAGS ('dbx_business_glossary_term' = 'Overflow Location Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `overflow_location_type` SET TAGS ('dbx_value_regex' = 'manhole|cleanout|pump_station|force_main|gravity_sewer|building_lateral');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `preventive_action_planned` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Planned');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `public_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `rainfall_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Amount (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `reached_surface_water` SET TAGS ('dbx_business_glossary_term' = 'Reached Surface Water Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `receiving_environment` SET TAGS ('dbx_business_glossary_term' = 'Receiving Environment');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `receiving_environment` SET TAGS ('dbx_value_regex' = 'surface_water|storm_drain|land_surface|building_interior|other');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Volume Estimation Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_value_regex' = 'measured|calculated|estimated');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `volume_recovered_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume Recovered (Gallons)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ALTER COLUMN `weather_related` SET TAGS ('dbx_business_glossary_term' = 'Weather-Related SSO Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `cso_event_id` SET TAGS ('dbx_business_glossary_term' = 'Combined Sewer Overflow (CSO) Event ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Source Water Intake Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ltcp Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `overflow_event_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Post Event Sample Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `bod_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand (BOD) Concentration (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'Cause Category');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `cause_category` SET TAGS ('dbx_value_regex' = 'wet_weather|equipment_failure|capacity_exceedance|operational_error|unknown');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `control_measure_active` SET TAGS ('dbx_business_glossary_term' = 'Control Measure Active Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `control_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Control Measure Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `dmr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submission Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `dmr_submitted` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Submitted Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `event_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Minutes)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'reported|under_review|validated|closed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `fecal_coliform_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform (CFU/100mL)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `ltcp_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Control Plan (LTCP) Reference ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `monitoring_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Sample Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|online_portal|fax|automated_system');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `operator_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Time (Minutes)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `outfall_designation` SET TAGS ('dbx_business_glossary_term' = 'Outfall Designation Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `overflow_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Overflow Volume (Gallons)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `overflow_volume_mgd` SET TAGS ('dbx_business_glossary_term' = 'Overflow Volume Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `post_event_monitoring_completed` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Monitoring Completed Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `post_event_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Event Monitoring Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `precipitation_amount_inches` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Amount (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `precipitation_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Duration (Hours)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `public_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `public_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `receiving_water_body_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Classification');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `receiving_water_body_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `scada_alarm_triggered` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Alarm Triggered Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `tss_concentration_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Concentration (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Volume Estimation Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `volume_estimation_method` SET TAGS ('dbx_value_regex' = 'measured|modeled|estimated|calculated');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `ii_monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Monitoring Point Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `baseline_dry_weather_flow_gpd` SET TAGS ('dbx_business_glossary_term' = 'Baseline Dry Weather Flow in Gallons Per Day (GPD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `contributing_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Contributing Area in Acres');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `data_logger_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Logger Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `ii_monitoring_point_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `ii_monitoring_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|maintenance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `infiltration_rate_gpd` SET TAGS ('dbx_business_glossary_term' = 'Infiltration Rate in Gallons Per Day (GPD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `inflow_rate_gpd` SET TAGS ('dbx_business_glossary_term' = 'Inflow Rate in Gallons Per Day (GPD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `instrument_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Indicator');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|weekly|monthly|quarterly|event_based');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_name` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `monitoring_point_type` SET TAGS ('dbx_value_regex' = 'flow_meter|rain_gauge|smoke_test_zone|cctv_inspection_segment|manhole_inspection|pressure_sensor');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `next_scheduled_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `peak_wet_weather_flow_gpd` SET TAGS ('dbx_business_glossary_term' = 'Peak Wet Weather Flow in Gallons Per Day (GPD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `pipe_age_years` SET TAGS ('dbx_business_glossary_term' = 'Pipe Age in Years');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter in Inches');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `rehabilitation_priority_category` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Priority Category');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `rehabilitation_priority_category` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `rehabilitation_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Priority Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ALTER COLUMN `wet_weather_flow_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Wet Weather Flow Multiplier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_flow_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Flow Measurement ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_monitoring_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Point ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Rain Gauge ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Segment ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `alarm_type` SET TAGS ('dbx_business_glossary_term' = 'Alarm Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `alarm_type` SET TAGS ('dbx_value_regex' = 'high_flow|low_flow|sensor_fault|communication_loss|none');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `average_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `calculated_ii_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Calculated Inflow and Infiltration (I&I) Volume in Gallons');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|estimated|missing');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|manual|mobile|third_party');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `dry_weather_baseline_gpm` SET TAGS ('dbx_business_glossary_term' = 'Dry Weather Baseline Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `flow_velocity_fps` SET TAGS ('dbx_business_glossary_term' = 'Flow Velocity in Feet Per Second (FPS)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_type` SET TAGS ('dbx_business_glossary_term' = 'Inflow and Infiltration (I&I) Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `ii_type` SET TAGS ('dbx_value_regex' = 'infiltration|inflow|combined|unknown');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measured_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Measured Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measured_flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Measured Flow Rate in Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Duration in Minutes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'ultrasonic|magnetic|weir|flume|manual');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `minimum_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `peak_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow Rate in Gallons Per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `pipe_depth_fill_percent` SET TAGS ('dbx_business_glossary_term' = 'Pipe Depth Fill Percentage');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `rain_gauge_reference` SET TAGS ('dbx_business_glossary_term' = 'Rain Gauge ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `rainfall_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Rainfall Depth in Inches');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `rehabilitation_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Priority Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `sensor_reference` SET TAGS ('dbx_business_glossary_term' = 'Sensor ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature in Fahrenheit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'dry|wet|storm|post-storm');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_subdomain' = 'pretreatment_monitoring');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Treatment Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Metering Metering Meter Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `pretreatment_iup_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Iup Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment Service Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `bod_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Biochemical Oxygen Demand (BOD) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `cadmium_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Cadmium (Cd) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `categorical_standard_applicable` SET TAGS ('dbx_business_glossary_term' = 'Categorical Pretreatment Standard Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `categorical_standard_citation` SET TAGS ('dbx_business_glossary_term' = 'Categorical Standard Regulatory Citation');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `chromium_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Chromium (Cr) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `cod_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Chemical Oxygen Demand (COD) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_schedule_final_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Final Milestone Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `compliance_schedule_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Schedule Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `copper_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Copper (Cu) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `flow_limit_gpd` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discharge Flow Limit (Gallons Per Day - GPD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `fog_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Frequency');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `inspection_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|as_needed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuance Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuing Authority');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Facility Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `lead_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Lead (Pb) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `mercury_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Self-Monitoring Reporting Frequency');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|semi_annual|annual');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `nickel_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Nickel (Ni) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_value_regex' = '^IUP-[A-Z0-9]{6,12}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Lifecycle Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|terminated');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'categorical|non-categorical|significant_industrial_user|minor_industrial_user');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `ph_maximum` SET TAGS ('dbx_business_glossary_term' = 'pH Maximum Discharge Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `ph_minimum` SET TAGS ('dbx_business_glossary_term' = 'pH Minimum Discharge Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `pretreatment_required` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment System Required Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `pretreatment_system_description` SET TAGS ('dbx_business_glossary_term' = 'Pretreatment System Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `silver_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Silver (Ag) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `total_nitrogen_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `total_phosphorus_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Phosphorus Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `tss_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Total Suspended Solids (TSS) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ALTER COLUMN `zinc_limit_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Zinc (Zn) Discharge Limit (mg/L)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` SET TAGS ('dbx_subdomain' = 'pretreatment_monitoring');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `iup_compliance_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) Compliance Sample ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit (IUP) ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `chain_of_custody_number` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Sample Comments');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|violation|exceedance|not_applicable|pending_review');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `composite_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Composite Duration Hours');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `enforcement_action_required` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Required');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `exceedance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Percentage');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `flow_rate_at_sampling` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate at Sampling');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate Unit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `flow_rate_unit` SET TAGS ('dbx_value_regex' = 'GPM|MGD|L/min|m3/day');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `laboratory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Report Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `permit_limit` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `permit_limit_type` SET TAGS ('dbx_value_regex' = 'daily_maximum|monthly_average|instantaneous|annual_average');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `quantification_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantification Limit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `result_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_location` SET TAGS ('dbx_business_glossary_term' = 'Sample Location');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_temperature` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Time');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|integrated|continuous');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_volume` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume Unit');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sample_volume_unit` SET TAGS ('dbx_value_regex' = 'mL|L|gal');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Sampler Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `sampler_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `violation_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `violation_notice_issued` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Issued');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` SET TAGS ('dbx_subdomain' = 'pretreatment_monitoring');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_id` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Source Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Establishment Address Line 1');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Establishment Address Line 2');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `best_management_practices_required` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Required');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Establishment City');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Compliance Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|warning|violation');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'FOG Program Enrollment Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `establishment_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Business Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `establishment_type` SET TAGS ('dbx_business_glossary_term' = 'Establishment Type Classification');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `establishment_type` SET TAGS ('dbx_value_regex' = 'restaurant|food_processor|institutional_kitchen|commercial_kitchen|bakery|other');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Days');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Establishment Latitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Establishment Longitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'FOG Source Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Expiration Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `permit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Issue Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Permit Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|inactive');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Establishment Postal Code');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `required_pumping_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Required Pumping Frequency in Days');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Risk Rating');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `sso_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Contribution Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Establishment State');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'FOG Program Termination Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'FOG Violation Count');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` SET TAGS ('dbx_subdomain' = 'pretreatment_monitoring');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `fog_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Fats, Oils, and Grease (FOG) Inspection ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `fog_source_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Grease Interceptor ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `best_management_practices_compliant` SET TAGS ('dbx_business_glossary_term' = 'Best Management Practices (BMP) Compliant');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending_review');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Recommended');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_value_regex' = 'warning|notice_of_violation|administrative_order|civil_penalty|permit_suspension');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Contact Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `establishment_contact_signature` SET TAGS ('dbx_business_glossary_term' = 'Establishment Contact Signature');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `grease_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Grease Depth (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `grease_depth_percentage` SET TAGS ('dbx_business_glossary_term' = 'Grease Depth Percentage');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `hauler_license_number` SET TAGS ('dbx_business_glossary_term' = 'Hauler License Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Time');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|follow_up|complaint_driven|pre_permit|annual|re_inspection');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_capacity_gallons` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Capacity (Gallons)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_condition` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Condition');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical|not_accessible');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_type` SET TAGS ('dbx_business_glossary_term' = 'Interceptor Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `interceptor_type` SET TAGS ('dbx_value_regex' = 'gravity|hydromechanical|automatic|passive');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `last_pumping_date` SET TAGS ('dbx_business_glossary_term' = 'Last Pumping Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `photos_taken` SET TAGS ('dbx_business_glossary_term' = 'Photos Taken');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `pumping_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Pumping Frequency (Days)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `pumping_manifest_verified` SET TAGS ('dbx_business_glossary_term' = 'Pumping Manifest Verified');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `re_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `re_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Required');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `solids_depth_inches` SET TAGS ('dbx_business_glossary_term' = 'Solids Depth (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `sso_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Risk Assessment');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `sso_risk_assessment` SET TAGS ('dbx_value_regex' = 'low|moderate|high|imminent');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `violation_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ALTER COLUMN `violations_noted` SET TAGS ('dbx_business_glossary_term' = 'Violations Noted');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `biosolids_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Batch Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `ar_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Transaction Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Permit Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Purchase Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Hauler Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Unit Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Treatment Plant (WWTP) Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `arsenic_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Arsenic (As) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Production Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch End Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `batch_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `cadmium_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Cadmium (Cd) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `copper_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Copper (Cu) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'Disposition Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'land_application|landfill|incineration|beneficial_reuse|composting|surface_disposal');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_site_name` SET TAGS ('dbx_business_glossary_term' = 'Disposition Site Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `disposition_site_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Disposition Site Permit Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `dmr_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Period');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `dry_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Dry Weight Tonnage');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `exceptional_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceptional Quality (EQ) Biosolids Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `fecal_coliform_density_mpn_per_gram` SET TAGS ('dbx_business_glossary_term' = 'Fecal Coliform Density Most Probable Number (MPN) per Gram Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `laboratory_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `lead_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Lead (Pb) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `mercury_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `nickel_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Nickel (Ni) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `pathogen_class` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Reduction Class');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `pathogen_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `percent_solids` SET TAGS ('dbx_business_glossary_term' = 'Percent Solids');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Value');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `salmonella_density_mpn_per_4_grams` SET TAGS ('dbx_business_glossary_term' = 'Salmonella Density Most Probable Number (MPN) per 4 Grams Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `selenium_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Selenium (Se) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `total_nitrogen_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen (N) Percent Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `total_phosphorus_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Phosphorus (P) Percent Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `total_potassium_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Potassium (K) Percent Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_value_regex' = 'anaerobic_digestion|aerobic_digestion|lime_stabilization|composting|heat_drying|alkaline_stabilization');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `treatment_process_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `vector_attraction_reduction_method` SET TAGS ('dbx_business_glossary_term' = 'Vector Attraction Reduction (VAR) Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `vector_attraction_reduction_method` SET TAGS ('dbx_value_regex' = 'option_1|option_2|option_3|option_4|option_5|option_6');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `volatile_solids_reduction_percent` SET TAGS ('dbx_business_glossary_term' = 'Volatile Solids (VS) Reduction Percent');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `wet_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Wet Weight Tonnage');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ALTER COLUMN `zinc_concentration_mg_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Zinc (Zn) Concentration Milligrams per Kilogram (mg/kg) Dry Weight');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `sewer_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Inspection ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'pipe|manhole|lateral|junction|cleanout');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `critical_defect_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `defect_codes` SET TAGS ('dbx_business_glossary_term' = 'Defect Codes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `downstream_manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Downstream Manhole Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `estimated_repair_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost (USD)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `estimated_repair_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `flow_condition` SET TAGS ('dbx_business_glossary_term' = 'Flow Condition');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `flow_condition` SET TAGS ('dbx_value_regex' = 'dry|low|medium|high|surcharge');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `fog_accumulation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fats Oils and Grease (FOG) Accumulation Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `infiltration_observed_flag` SET TAGS ('dbx_business_glossary_term' = 'Infiltration and Inflow (I&I) Observed Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_direction` SET TAGS ('dbx_business_glossary_term' = 'Inspection Direction');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_direction` SET TAGS ('dbx_value_regex' = 'upstream|downstream');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Inspection Length (Feet)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'CCTV|sonar|smoke_test|dye_test|visual|laser_profiling');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|reviewed|approved|cancelled');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Time');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|emergency|post_repair|pre_construction|complaint_driven|regulatory');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `macp_score` SET TAGS ('dbx_business_glossary_term' = 'Manhole Assessment and Certification Program (MACP) Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `operational_defect_flag` SET TAGS ('dbx_business_glossary_term' = 'Operational Defect Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `pacp_score` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Assessment and Certification Program (PACP) Score');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `pipe_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter (Inches)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'no_action|monitor|cleaning|spot_repair|rehabilitation|replacement');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `rehabilitation_method` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Method');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `report_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report File Path');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `root_intrusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Intrusion Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `structural_defect_flag` SET TAGS ('dbx_business_glossary_term' = 'Structural Defect Flag');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `upstream_manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Upstream Manhole Number');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_business_glossary_term' = 'Urgency Classification');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_value_regex' = 'immediate|high|medium|low|routine');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `video_file_path` SET TAGS ('dbx_business_glossary_term' = 'Video File Path');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` SET TAGS ('dbx_subdomain' = 'treatment_compliance');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall Identifier');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Metering Meter Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `primary_outfall_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sampling Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
