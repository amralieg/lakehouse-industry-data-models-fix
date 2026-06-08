-- Schema for Domain: location | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`location` COMMENT 'SSOT for all geographic and physical location master data — addresses, geo-coordinates, coverage areas, service territories, administrative regions, and location hierarchies used across network planning, service delivery, and customer management';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`location_site` (
    `location_site_id` BIGINT COMMENT 'Unique identifier for the physical telecommunications infrastructure site. Primary key for the location_site entity.',
    `geographic_zone_id` BIGINT COMMENT 'Reference to the network region or Operations Support Systems (OSS) domain that this site belongs to. Used for Network Operations Center (NOC) assignment and fault management routing.',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory or coverage area that this site serves. Used for geographic segmentation, revenue allocation, and regulatory reporting.',
    `parent_location_site_id` BIGINT COMMENT 'Self-referencing FK on location_site (parent_location_site_id)',
    `access_restrictions` STRING COMMENT 'Description of physical access restrictions, security protocols, or special entry requirements for the site (e.g., escort required, biometric access, advance notice). Used for Workforce Management (WFM) and field dispatch planning.',
    `address_line_1` STRING COMMENT 'Primary street address line for the physical site location, including street number and street name. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building name, suite number, or floor. Organizational contact data classified as confidential.',
    `annual_opex_usd` DECIMAL(18,2) COMMENT 'Total annual Operational Expenditure (OPEX) for the site in United States Dollars, including lease costs, utilities, maintenance, and security. Used for cost allocation and Return on Investment (ROI) analysis.',
    `backup_power_capacity_kwh` DECIMAL(18,2) COMMENT 'Total backup power capacity available at the site in kilowatt-hours, critical for Service Level Agreement (SLA) compliance and network resilience during outages.',
    `capacity_rating` STRING COMMENT 'Capacity classification of the site based on equipment density, power capacity, and network throughput: small (micro-site), medium (standard site), large (macro-site), enterprise (enterprise-grade facility), carrier_grade (tier-1 carrier facility).. Valid values are `small|medium|large|enterprise|carrier_grade`',
    `city` STRING COMMENT 'City or municipality name where the site is physically located. Organizational contact data classified as confidential.',
    `commissioning_date` DATE COMMENT 'Date when the site was officially commissioned and placed into active service, marking the start of its operational lifecycle. Used for asset depreciation and Capital Expenditure (CAPEX) tracking.',
    `cooling_type` STRING COMMENT 'Climate control system type deployed at the site: hvac (heating, ventilation, air conditioning), passive (natural ventilation), liquid (liquid cooling), evaporative (evaporative cooling), none (no cooling system).. Valid values are `hvac|passive|liquid|evaporative|none`',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the site is located (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this site record was first created in the system, used for audit trail and data lineage tracking.',
    `decommissioning_date` DATE COMMENT 'Date when the site was officially decommissioned and removed from active service. Null for active sites. Used for asset lifecycle management and Operational Expenditure (OPEX) optimization.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Elevation of the site above sea level in meters, critical for Radio Frequency (RF) propagation modeling, line-of-sight calculations, and antenna height planning.',
    `environmental_zone` STRING COMMENT 'Geographic and environmental classification of the site location: urban (dense city), suburban (residential area), rural (low-density area), remote (isolated location), coastal (near coastline), mountain (high-altitude terrain). Used for network planning and Quality of Service (QoS) modeling.. Valid values are `urban|suburban|rural|remote|coastal|mountain`',
    `fiber_connectivity` BOOLEAN COMMENT 'Indicates whether the site has fiber optic backhaul connectivity (True) or relies on alternative transport such as microwave or satellite (False). Critical for Fiber to the Home (FTTH) and 5G New Radio (5G NR) deployment planning.',
    `generator_available` BOOLEAN COMMENT 'Indicates whether the site has an on-site backup generator (True) or not (False). Critical for Service Level Agreement (SLA) compliance and network resilience.',
    `hazardous_materials` BOOLEAN COMMENT 'Indicates whether the site stores or uses hazardous materials such as diesel fuel, batteries, or refrigerants (True) or not (False). Used for environmental compliance and safety planning.',
    `land_area_sqm` DECIMAL(18,2) COMMENT 'Total land area of the site property in square meters, used for Capital Expenditure (CAPEX) planning, lease cost allocation, and expansion feasibility analysis.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical site inspection or audit, used for compliance tracking, maintenance scheduling, and Mean Time Between Failures (MTBF) analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this site record was last updated, used for change tracking, audit trail, and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the site in decimal degrees format, used for network planning, coverage modeling, and Radio Access Network (RAN) optimization.',
    `lease_expiry_date` DATE COMMENT 'Expiration date of the site lease agreement for leased or co-located sites. Null for owned sites. Critical for contract renewal planning and Operational Expenditure (OPEX) forecasting.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the site in decimal degrees format, used for network planning, coverage modeling, and Radio Access Network (RAN) optimization.',
    `manager_employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Telecommunications site operations require structured link to site manager employee record for on-call rosters, operational escalations, maintenance accountability, and workforce planning. Site_manage',
    `microwave_backhaul` BOOLEAN COMMENT 'Indicates whether the site uses microwave radio backhaul for transport connectivity (True) or not (False). Common for remote tower sites without fiber access.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance visit or inspection, used for Workforce Management (WFM) planning and Mean Time to Repair (MTTR) optimization.',
    `ownership_type` STRING COMMENT 'Legal ownership or occupancy model for the site: owned (company-owned property), leased (rented from third party), co_located (shared facility with other carriers), joint_venture (shared ownership), licensed (spectrum or land license).. Valid values are `owned|leased|co_located|joint_venture|licensed`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the site address, used for geographic segmentation and service territory mapping. Organizational contact data classified as confidential.',
    `power_supply_type` STRING COMMENT 'Primary electrical power source for the site: grid (utility power), solar (photovoltaic), hybrid (multiple sources), generator (diesel/gas generator), battery (battery-only for remote sites).. Valid values are `grid|solar|hybrid|generator|battery`',
    `security_classification` STRING COMMENT 'Physical security level assigned to the site based on asset value, criticality to network operations, and regulatory requirements: high (24/7 monitoring, restricted access), medium (standard security), low (minimal security), critical_infrastructure (government-designated critical asset).. Valid values are `high|medium|low|critical_infrastructure`',
    `site_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the site across operational systems, network planning tools, and workforce management systems. Used for field dispatch and asset tracking.. Valid values are `^[A-Z0-9]{6,12}$`',
    `site_name` STRING COMMENT 'Human-readable name or designation of the physical site, typically including geographic reference or facility identifier (e.g., Downtown Central Office, Tower Hill RAN Site).',
    `site_status` STRING COMMENT 'Current operational lifecycle state of the site: active (in service), decommissioned (retired), planned (approved but not built), under_construction (build in progress), maintenance (temporarily offline), suspended (temporarily inactive).. Valid values are `active|decommissioned|planned|under_construction|maintenance|suspended`',
    `site_type` STRING COMMENT 'Classification of the physical site based on its primary telecommunications function: central_office (CO - switching and routing hub), headend (cable distribution point), tower (cell tower site), rooftop (rooftop installation), data_center (compute and storage facility), exchange (telephone exchange building).. Valid values are `central_office|headend|tower|rooftop|data_center|exchange`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the site is located. Organizational contact data classified as confidential.',
    `structural_type` STRING COMMENT 'Physical structure classification of the site: building (permanent structure), tower (freestanding tower), pole (utility pole mount), rooftop (building rooftop installation), underground (below-grade facility), container (modular container unit).. Valid values are `building|tower|pole|rooftop|underground|container`',
    CONSTRAINT pk_location_site PRIMARY KEY(`location_site_id`)
) COMMENT 'Master record for every physical site in the telecommunications infrastructure — central offices (CO), headend facilities, data centers, cell tower sites, rooftop installations, exchange buildings, and POP locations. Captures site identifier, site name, site type (CO, headend, tower, rooftop, data_center, exchange), physical address, geo-coordinates (latitude, longitude, elevation), site status (active, decommissioned, planned), ownership type (owned, leased, co-located), land area, structural type, power supply type, backup power capacity, cooling type, security classification, site manager contact, commissioning date, and decommissioning date. Serves as the geographic anchor for network elements, workforce depots, and inventory assets.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`location_address` (
    `location_address_id` BIGINT COMMENT 'Unique identifier for the location address record. Primary key for the location address entity.',
    `normalized_from_location_address_id` BIGINT COMMENT 'Self-referencing FK on location_address (normalized_from_location_address_id)',
    `address_status` STRING COMMENT 'Current validation and operational status of the address record (e.g., verified, unverified, invalid, pending validation, deprecated).. Valid values are `verified|unverified|invalid|pending|deprecated`',
    `address_type` STRING COMMENT 'Classification of the address format and delivery method (e.g., civic, postal, rural route, military, PO Box, general delivery).. Valid values are `civic|postal|rural|military|pobox|general_delivery`',
    `building_name` STRING COMMENT 'Official or common name of the building, tower, or complex where the address is located.',
    `city` STRING COMMENT 'City, town, or municipality name where the address is located. Primary administrative locality for postal delivery.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0.00 to 100.00) indicating the quality and reliability of the address data based on validation, geocoding accuracy, and data completeness.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the address is located (e.g., USA, CAN, GBR, AUS).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the system. Part of standard audit trail for data lineage and compliance.',
    `dpid` STRING COMMENT 'Australia Post Delivery Point Identifier - unique 8-digit identifier assigned to each delivery point in Australia. Used for precise mail delivery routing.',
    `effective_end_date` DATE COMMENT 'Date when this address record ceases to be effective. Null for currently active addresses. Supports temporal data management and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date when this address record becomes effective and valid for operational use. Supports temporal data management and historical tracking.',
    `external_reference_code` STRING COMMENT 'External identifier or reference number from the source system or third-party address validation service. Enables cross-system reconciliation and data integration.',
    `five_g_coverage_flag` BOOLEAN COMMENT 'Boolean indicator of whether 5G New Radio (NR) wireless coverage is available at this address. Used for next-generation mobile service qualification.',
    `floor_number` STRING COMMENT 'Floor or level number within a multi-story building. May include basement (B), ground (G), mezzanine (M), or penthouse (PH) designations.',
    `ftth_serviceable_flag` BOOLEAN COMMENT 'Boolean indicator of whether Fiber to the Home (FTTH) or fiber broadband service is available at this address. Critical for product catalog and service provisioning.',
    `geocoding_status` STRING COMMENT 'Status of geocoding process indicating whether latitude and longitude coordinates have been successfully assigned and the precision level achieved.. Valid values are `geocoded|not_geocoded|approximate|rooftop|failed`',
    `gnaf_pid` STRING COMMENT 'Persistent identifier from Australias Geocoded National Address File (GNAF). Provides stable reference to address records across systems. Applicable to Australian addresses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the address record. Used for change tracking and data synchronization across systems.',
    `last_validation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent address validation or verification process. Used to track data freshness and trigger re-validation workflows.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees format. Represents north-south position on Earths surface. Range: -90.0000000 to +90.0000000.',
    `line_1` STRING COMMENT 'Primary street address line containing street number, street name, and street type. Core component of civic and postal addresses.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as unit number, suite, apartment, floor, or building name.',
    `locality` STRING COMMENT 'Suburb, neighborhood, district, or locality name. Represents the local area within a larger city or municipality.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees format. Represents east-west position on Earths surface. Range: -180.0000000 to +180.0000000.',
    `lte_coverage_flag` BOOLEAN COMMENT 'Boolean indicator of whether Long-Term Evolution (LTE) 4G wireless coverage is available at this address. Used for mobile service qualification.',
    `network_coverage_area_code` STRING COMMENT 'Code identifying the network coverage area or cell site serving this address. Used for Radio Access Network (RAN) planning and Quality of Service (QoS) analysis.',
    `plus_code` STRING COMMENT 'Open Location Code (Plus Code) providing a geocode alternative to street addresses. Format: 8-character area code + 2-3 character local code (e.g., 8FVC9G8F+6X).. Valid values are `^[23456789CFGHJMPQRVWX]{4,8}+[23456789CFGHJMPQRVWX]{2,3}$`',
    `postal_code` STRING COMMENT 'Postal code, ZIP code, or postcode for mail delivery routing. Format varies by country (e.g., 12345, 12345-6789, A1A 1A1, SW1A 1AA).',
    `service_territory_code` STRING COMMENT 'Code identifying the telecommunications service territory, franchise area, or coverage zone where this address is located. Used for service availability and network planning.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated or last updated this address (e.g., Salesforce CRM, Oracle OSM, Netcracker, SAP). Used for data lineage and reconciliation.',
    `standardization_method` STRING COMMENT 'Method or service used to standardize and validate the address (e.g., manual entry, USPS API, Google Maps API, Australia Post, Royal Mail). Used for data quality tracking.. Valid values are `manual|usps_api|google_maps|australia_post|royal_mail`',
    `state_province` STRING COMMENT 'State, province, territory, or first-level administrative division. Uses standard abbreviations (e.g., CA, NY, ON, NSW).',
    `street_direction` STRING COMMENT 'Directional prefix or suffix for the street name (e.g., North, South, East, West, Northeast, Northwest, Southeast, Southwest). [ENUM-REF-CANDIDATE: N|S|E|W|NE|NW|SE|SW — 8 candidates stripped; promote to reference product]',
    `street_name` STRING COMMENT 'Name of the street, road, avenue, or thoroughfare where the address is located.',
    `street_number` STRING COMMENT 'Numeric or alphanumeric identifier for the building or property on the street. May include suffixes like 123A or 45-47.',
    `street_type` STRING COMMENT 'Classification of the thoroughfare type (e.g., Street, Avenue, Road, Boulevard, Lane, Drive, Court, Place). [ENUM-REF-CANDIDATE: Street|Avenue|Road|Boulevard|Lane|Drive|Court|Place|Way|Terrace|Circle|Crescent|Highway|Parkway — promote to reference product]. Valid values are `Street|Avenue|Road|Boulevard|Lane|Drive`',
    `unit_number` STRING COMMENT 'Specific unit, apartment, suite, or office number within a multi-tenant building or complex.',
    `uprn` STRING COMMENT 'Unique Property Reference Number assigned by Ordnance Survey in the United Kingdom. Provides unique identifier for every addressable location in the UK.',
    `usage_type` STRING COMMENT 'Business purpose classification for the address within telecommunications operations (e.g., customer service address, installation address, billing address, network infrastructure site, office location).. Valid values are `customer_service|installation|billing|network_site|office`',
    `usps_validation_status` STRING COMMENT 'Validation status from USPS address verification service indicating whether the address matches USPS delivery records. Applicable to USA addresses only.. Valid values are `valid|invalid|corrected|not_validated`',
    CONSTRAINT pk_location_address PRIMARY KEY(`location_address_id`)
) COMMENT 'SSOT for all civic and postal address records used across the telecommunications enterprise — customer service addresses, installation addresses, billing addresses, site addresses, and network infrastructure addresses. Captures structured address components: address line 1, address line 2, unit/suite/floor, building name, street number, street name, street type, direction, suburb/locality, city, state/province, postal code, country ISO code, address type (civic, postal, rural, military), address status (verified, unverified, invalid), geocoding status, latitude, longitude, plus code, USPS/Royal Mail/Australia Post validation status, DPID, GNAF persistent identifier (AU), UPRN (UK), address confidence score, and last validation timestamp. Single authoritative address record referenced by customer, service, order, and network domains.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`geo_point` (
    `geo_point_id` BIGINT COMMENT 'Unique identifier for the geographic point record. Primary key for the geo_point entity.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key reference to the network coverage area or service territory polygon that contains this geographic point. Links the point to broader geographic service planning and coverage analysis entities.',
    `location_address_id` BIGINT COMMENT 'Foreign key reference to the civic address record associated with this geographic point. Provides the link between precise spatial coordinates and human-readable address information for customer premises and service locations.',
    `location_site_id` BIGINT COMMENT 'Foreign key reference to the parent site or facility where this geographic point is located. Links the point to a broader network site entity (e.g., cell tower site, central office, point of presence).',
    `segment_id` BIGINT COMMENT 'Foreign key reference to the logical network segment or topology element that this geographic point belongs to. Supports network planning, routing, and topology management use cases.',
    `corrected_from_geo_point_id` BIGINT COMMENT 'Self-referencing FK on geo_point (corrected_from_geo_point_id)',
    `access_instructions` STRING COMMENT 'Operational instructions for field technicians to physically access the geographic point location. May include gate codes, contact information, safety requirements, or navigation guidance. Confidential to protect infrastructure security.',
    `capture_date` DATE COMMENT 'Date when the geographic coordinates were captured or surveyed. Provides temporal context for the spatial data and supports data currency assessments for network planning and maintenance activities.',
    `capture_method` STRING COMMENT 'Method or technique used to capture the geographic coordinates of the point. Indicates the data collection approach and influences the expected accuracy and reliability of the spatial data. [ENUM-REF-CANDIDATE: gps_survey|aerial_photogrammetry|digitized|interpolated|lidar|total_station|mobile_mapping — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic point record was first created in the system. Supports audit trail and data lineage tracking.',
    `crs_code` STRING COMMENT 'EPSG code or other standard identifier for the coordinate reference system used to capture the geographic coordinates. Default is EPSG:4326 (WGS84). Enables coordinate transformation and interoperability with GIS systems.',
    `data_source` STRING COMMENT 'Name or identifier of the source system or data provider that originated this geographic point record. Supports data lineage tracking and quality assessment (e.g., Nokia NetAct, Ericsson Network Manager, Field Survey Team).',
    `decommission_date` DATE COMMENT 'Date when the infrastructure element at this geographic point was decommissioned or removed from active service. Null for active points. Supports historical analysis and asset retirement tracking.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Vertical elevation of the geographic point measured in meters above mean sea level. Critical for radio frequency propagation modeling, line-of-sight calculations, and antenna height planning in RAN and microwave transport networks.',
    `environmental_zone` STRING COMMENT 'Classification of the environmental or geographic zone where the point is located. Influences network design parameters, equipment specifications, and operational considerations (e.g., temperature, humidity, accessibility). [ENUM-REF-CANDIDATE: urban|suburban|rural|remote|coastal|mountainous|industrial|residential — 8 candidates stripped; promote to reference product]',
    `external_system_code` STRING COMMENT 'Identifier for this geographic point in external systems such as GIS platforms, network management systems, or third-party mapping services. Enables cross-system reconciliation and data integration.',
    `hazard_classification` STRING COMMENT 'Classification of natural hazard risks associated with the geographic point location. Used for risk assessment, business continuity planning, and infrastructure resilience design.. Valid values are `none|flood_zone|seismic_zone|wildfire_risk|coastal_erosion|extreme_weather`',
    `horizontal_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated horizontal positional accuracy of the latitude and longitude coordinates, measured in meters. Represents the radius of uncertainty around the recorded position. Lower values indicate higher precision.',
    `installation_date` DATE COMMENT 'Date when the infrastructure element at this geographic point was physically installed or commissioned. Supports asset lifecycle tracking, depreciation calculations, and maintenance scheduling.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the regulatory jurisdiction or administrative region where the geographic point is located. Used for compliance reporting, spectrum licensing, and regulatory obligations tied to geographic service territories.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic point record was last updated or modified. Supports change tracking and data currency assessment.',
    `last_verified_date` DATE COMMENT 'Date when the geographic coordinates and point attributes were last verified or validated in the field. Supports data quality management and indicates the currency of the spatial information.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees using the WGS84 coordinate reference system. Represents the north-south position of the point on the Earths surface. Range: -90.0000000 to +90.0000000.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees using the WGS84 coordinate reference system. Represents the east-west position of the point on the Earths surface. Range: -180.0000000 to +180.0000000.',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system account that last modified this geographic point record. Supports audit trail and accountability for data changes.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, comments, or contextual information about the geographic point that does not fit into structured attributes. Used by field operations and network planning teams.',
    `ownership_type` STRING COMMENT 'Classification of the ownership or access rights for the geographic point location. Indicates whether the telecommunications operator owns the site, leases it, has right-of-way access, or shares it with other parties.. Valid values are `owned|leased|licensed|right_of_way|shared|third_party`',
    `permit_reference` STRING COMMENT 'Reference number or identifier for the construction permit, building permit, or regulatory authorization associated with the infrastructure at this geographic point. Supports compliance tracking and regulatory reporting.',
    `point_description` STRING COMMENT 'Detailed textual description of the geographic point, including contextual information about its location, surroundings, access instructions, or special characteristics relevant to field operations and network planning.',
    `point_identifier` STRING COMMENT 'Human-readable business identifier for the geographic point, used for external reference and operational communication (e.g., TOWER-001, CAB-NW-045, MH-CENTRAL-12).',
    `point_name` STRING COMMENT 'Descriptive name or label for the geographic point, used for human-readable identification in operational systems and field documentation (e.g., Main Street Cabinet, Downtown Tower Base, Customer Entry Point - Building A).',
    `point_status` STRING COMMENT 'Current lifecycle status of the geographic point within network planning and operations. Indicates whether the point is operational, planned for future deployment, or retired from service.. Valid values are `active|inactive|planned|decommissioned|under_construction|surveyed`',
    `point_type` STRING COMMENT 'Classification of the geographic point based on its telecommunications infrastructure role. Defines the functional purpose of the spatial location within the network topology. [ENUM-REF-CANDIDATE: tower_base|cabinet|manhole|pit|antenna|premise_entry|splice_point|ont_drop|olt_location|bng_site — 10 candidates stripped; promote to reference product]',
    `surveyor_reference` STRING COMMENT 'Reference identifier for the surveyor, survey crew, or survey organization that captured the geographic coordinates. Enables traceability and quality assurance for spatial data collection activities.',
    `vertical_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated vertical positional accuracy of the elevation measurement, measured in meters. Represents the uncertainty in the elevation value. Critical for precise infrastructure placement and engineering calculations.',
    `zoning_classification` STRING COMMENT 'Local government zoning or land use classification for the geographic point location. Impacts permitting requirements, construction restrictions, and regulatory compliance for telecommunications infrastructure deployment.',
    CONSTRAINT pk_geo_point PRIMARY KEY(`geo_point_id`)
) COMMENT 'Precise geographic coordinate record representing a single spatial point of interest in the telecommunications network — cell tower base positions, ONT drop points, manhole/pit locations, cabinet positions, antenna mounting points, and customer premise entry points. Captures point identifier, point type (tower_base, cabinet, manhole, pit, antenna, premise_entry, splice_point), WGS84 latitude, longitude, elevation above sea level, horizontal accuracy (metres), vertical accuracy, coordinate reference system (CRS) code, capture method (GPS survey, aerial photogrammetry, digitized, interpolated), capture date, surveyor reference, and associated site or address reference. Provides sub-address spatial precision beyond civic address records.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`geo_boundary` (
    `geo_boundary_id` BIGINT COMMENT 'Unique identifier for the geographic boundary record. Primary key.',
    `parent_boundary_geo_boundary_id` BIGINT COMMENT 'Reference to the parent boundary in a hierarchical boundary structure (e.g., SA2 parent of SA1, state parent of LGA). Null for top-level boundaries. Enables hierarchical rollup for reporting and aggregation.',
    `parent_geo_boundary_id` BIGINT COMMENT 'Self-referencing FK on geo_boundary (parent_geo_boundary_id)',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Total area of the boundary in square kilometers. Used for density calculations, coverage planning, and capacity modeling.',
    `boundary_identifier` STRING COMMENT 'External business identifier for the boundary as assigned by the source authority (e.g., ABS region code, census tract FIPS code, postcode, LGA code). Used for cross-system integration and regulatory reporting.',
    `boundary_name` STRING COMMENT 'Human-readable name of the geographic boundary (e.g., Sydney Central Exchange, New South Wales, Greater London, Harris County).',
    `boundary_status` STRING COMMENT 'Current lifecycle status of the boundary. Active: currently in use for planning and operations; inactive: temporarily not in use; proposed: planned but not yet effective; deprecated: scheduled for retirement; superseded: replaced by a newer boundary version.. Valid values are `active|inactive|proposed|deprecated|superseded`',
    `boundary_type` STRING COMMENT 'Classification of the boundary type. Exchange: telecommunications exchange boundary; LGA: Local Government Area; SA1/SA2/SA3/SA4: Australian Statistical Geography Standard levels; census_tract: US Census tract; state/territory: administrative region; country: national boundary; planning_zone: operator-defined planning area; coverage_zone: network coverage footprint; service_area: service delivery territory. [ENUM-REF-CANDIDATE: exchange|lga|postcode|sa1|sa2|sa3|sa4|census_tract|state|territory|country|planning_zone|coverage_zone|service_area — 14 candidates stripped; promote to reference product]',
    `business_count` BIGINT COMMENT 'Estimated number of business establishments within the boundary. Used for enterprise sales targeting, B2B service planning, and commercial market analysis.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the boundarys geometric centroid in decimal degrees. Used for proximity calculations and mapping.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the boundarys geometric centroid in decimal degrees. Used for proximity calculations and mapping.',
    `coordinate_reference_system` STRING COMMENT 'Spatial reference system used for the boundary geometry (e.g., EPSG:4326 for WGS84, EPSG:3857 for Web Mercator). Critical for accurate spatial operations and coordinate transformations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the boundary (e.g., USA, AUS, GBR). Used for international operations, roaming analysis, and regulatory segmentation.. Valid values are `^[A-Z]{3}$`',
    `coverage_quality_score` DECIMAL(18,2) COMMENT 'Aggregate quality score for network coverage within the boundary (0-100 scale). Derived from signal strength measurements, QoS metrics, and customer experience data. Used for network investment prioritization and SLA reporting.',
    `coverage_type` STRING COMMENT 'Type of network coverage within the boundary (e.g., 5G NR, LTE, FTTH, GPON, HFC, Fixed Wireless). Pipe-separated list if multiple technologies are deployed. Used for coverage mapping and service eligibility determination. [ENUM-REF-CANDIDATE: 5g_nr|lte|3g|ftth|fttc|fttb|gpon|hfc|dsl|fixed_wireless|satellite|no_coverage — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this boundary record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this boundary definition became effective for operational use. Used for temporal queries and historical analysis.',
    `expiry_date` DATE COMMENT 'Date when this boundary definition expires or is superseded. Null for boundaries with no planned expiration. Used for temporal validity and version management.',
    `geometry_geojson` STRING COMMENT 'Spatial geometry of the boundary represented in GeoJSON format. Provides interoperability with web mapping applications and modern geospatial APIs.',
    `geometry_wkt` STRING COMMENT 'Spatial geometry of the boundary represented in Well-Known Text format (POLYGON or MULTIPOLYGON). Used for GIS operations, spatial queries, and coverage analysis.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the boundary hierarchy (e.g., 1=country, 2=state, 3=LGA, 4=SA2, 5=SA1). Used for hierarchical queries and aggregation logic.',
    `household_count` BIGINT COMMENT 'Estimated or census-based number of households within the boundary. Used for FTTH rollout planning, broadband penetration analysis, and market opportunity assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this boundary record was last updated. Used for change tracking and data synchronization.',
    `market_segment` STRING COMMENT 'Primary market segment served within this boundary. Used for sales territory assignment, product catalog filtering, and market analysis.. Valid values are `residential|business|wholesale|government|education|healthcare`',
    `notes` STRING COMMENT 'Free-text notes and comments about the boundary. Used for documenting special conditions, boundary disputes, data quality issues, or operational considerations.',
    `perimeter_km` DECIMAL(18,2) COMMENT 'Total perimeter length of the boundary in kilometers. Used for edge analysis and boundary adjacency calculations.',
    `population_count` BIGINT COMMENT 'Estimated or census-based population within the boundary. Used for market sizing, capacity planning, and ARPU calculations. Sourced from census data or third-party demographics.',
    `postal_code` STRING COMMENT 'Postal code or ZIP code associated with the boundary (for postcode-type boundaries). Used for address validation, service availability checks, and marketing segmentation.',
    `regulatory_zone` STRING COMMENT 'Regulatory or licensing zone designation applicable to this boundary (e.g., FCC License Area 23, Ofcom Geographic Market 4, ACMA Spectrum Zone Sydney). Used for compliance reporting and spectrum management.',
    `source_authority` STRING COMMENT 'Organization or entity that defined and published this boundary. ABS: Australian Bureau of Statistics; ONS: UK Office for National Statistics; census_bureau: US Census Bureau; eurostat: European statistical office; operator_defined: internally created by telecommunications operator; regulatory_authority: defined by telecom regulator; local_government: municipal or regional government; third_party: commercial data provider. [ENUM-REF-CANDIDATE: abs|ons|census_bureau|eurostat|operator_defined|regulatory_authority|local_government|third_party — 8 candidates stripped; promote to reference product]',
    `source_dataset` STRING COMMENT 'Name and version of the source dataset from which this boundary was derived (e.g., ASGS 2021, TIGER/Line 2023, Operator Network Planning Zones v3.2). Used for data lineage and quality assessment.',
    `state_province_code` STRING COMMENT 'State, province, or territory code within the country (e.g., NSW, CA, ON). Used for regional reporting and state-level regulatory compliance.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the boundary (e.g., America/New_York, Australia/Sydney, Europe/London). Used for scheduling, billing cycle alignment, and customer service hours.',
    `urban_rural_classification` STRING COMMENT 'Classification of the boundary as urban, suburban, rural, or remote. Used for network planning, service differentiation, and regulatory compliance (e.g., universal service obligations).. Valid values are `urban|suburban|rural|remote`',
    `version_number` STRING COMMENT 'Version identifier for this boundary definition. Incremented when boundary geometry or attributes are updated. Supports temporal analysis and change tracking.',
    CONSTRAINT pk_geo_boundary PRIMARY KEY(`geo_boundary_id`)
) COMMENT 'Master record for all polygon and multi-polygon geographic boundaries used in telecommunications planning and operations — exchange boundaries, local government areas (LGA), statistical areas (SA1/SA2/SA3/SA4, census tracts), postcode boundaries, state/territory boundaries, country boundaries, and custom planning zones. Captures boundary identifier, boundary name, boundary type (exchange, LGA, postcode, SA1, SA2, census_tract, state, country, planning_zone), geometry (WKT/GeoJSON polygon), area in square kilometres, perimeter in kilometres, coordinate reference system, effective date, expiry date, source authority (ABS, ONS, Census Bureau, operator-defined), and version number. Used for coverage mapping, regulatory reporting, and market analysis.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`coverage_area` (
    `coverage_area_id` BIGINT COMMENT 'Unique identifier for the coverage area record. Primary key.',
    `service_territory_id` BIGINT COMMENT 'Reference to the administrative service territory or franchise area to which this coverage area belongs. Used for regulatory reporting and market segmentation.',
    `parent_coverage_area_id` BIGINT COMMENT 'Self-referencing FK on coverage_area (parent_coverage_area_id)',
    `area_square_km` DECIMAL(18,2) COMMENT 'The geographic area covered by this coverage polygon, measured in square kilometers. Derived from the geometry_wkt field.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'The statistical confidence level (0-100%) associated with the predicted coverage metrics, indicating the reliability of the propagation model or measurement data.',
    `coverage_area_code` STRING COMMENT 'Business identifier for the coverage area, used for external reference and service qualification lookups.. Valid values are `^[A-Z0-9]{6,20}$`',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the coverage area. Active: currently providing service. Planned: future deployment. Decommissioned: no longer in service. Suspended: temporarily unavailable.. Valid values are `active|planned|decommissioned|suspended`',
    `coverage_tier` STRING COMMENT 'The depth or quality tier of coverage provided: outdoor (macro cell coverage), indoor (building penetration), deep_indoor (basement/interior coverage), in_vehicle (mobile coverage inside vehicles).. Valid values are `outdoor|indoor|deep_indoor|in_vehicle`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage area record was first created in the system.',
    `data_source` STRING COMMENT 'The name or identifier of the system or vendor that provided the coverage area data (e.g., Nokia NetAct, Ericsson Network Manager, third-party RF planning tool).',
    `effective_date` DATE COMMENT 'The date from which this coverage area record becomes active and valid for service qualification and order feasibility checks.',
    `exchange_code` STRING COMMENT 'The telephone exchange or central office code serving this coverage area, applicable for fixed-line technologies (FTTP, FTTN, ADSL). Used for service qualification and order routing.. Valid values are `^[A-Z0-9]{3,10}$`',
    `expiry_date` DATE COMMENT 'The date on which this coverage area record ceases to be valid. Null indicates indefinite validity.',
    `frequency_band` STRING COMMENT 'The radio frequency band or spectrum allocation used for wireless coverage (e.g., 700MHz, 2.6GHz, 3.5GHz, 28GHz, n78, n77). For fixed-line technologies, this field may be null or indicate the transmission medium.. Valid values are `^[A-Za-z0-9-.]+$`',
    `generation_method` STRING COMMENT 'The methodology used to generate the coverage area data. Drive_test: field measurements. Propagation_model: RF simulation. Crowdsourced: user device telemetry. Hybrid: combination of methods.. Valid values are `drive_test|propagation_model|crowdsourced|hybrid`',
    `geometry_wkt` STRING COMMENT 'The geographic boundary of the coverage area represented as a Well-Known Text (WKT) polygon or multipolygon, conforming to OGC Simple Features specification. Used for spatial queries and service qualification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage area record was last updated or modified.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'The timestamp when the coverage area data was last verified or updated through drive testing, propagation model refresh, or crowdsourced validation.',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, or operational notes related to this coverage area (e.g., planned upgrades, known interference issues, seasonal variations).',
    `population_covered` BIGINT COMMENT 'The estimated number of people residing within this coverage area, used for regulatory coverage reporting and market analysis.',
    `predicted_downlink_throughput_mbps` DECIMAL(18,2) COMMENT 'The estimated maximum downlink data throughput in megabits per second (Mbps) achievable in this coverage area under typical load conditions.',
    `predicted_signal_strength_dbm` DECIMAL(18,2) COMMENT 'The predicted received signal strength in decibels relative to one milliwatt (dBm) for this coverage area, derived from propagation models or drive test data. Typical range: -120 to -40 dBm.',
    `predicted_uplink_throughput_mbps` DECIMAL(18,2) COMMENT 'The estimated maximum uplink data throughput in megabits per second (Mbps) achievable in this coverage area under typical load conditions.',
    `qos_class` STRING COMMENT 'The quality of service tier associated with this coverage area. Premium: highest QoS guarantees. Standard: typical service levels. Basic: minimum service levels.. Valid values are `premium|standard|basic`',
    `regulatory_classification` STRING COMMENT 'The regulatory classification of the coverage area for compliance and subsidy reporting purposes. Urban: high-density population centers. Suburban: medium-density areas. Rural: low-density areas. Remote: very low-density or hard-to-reach areas.. Valid values are `urban|suburban|rural|remote`',
    `roaming_enabled_flag` BOOLEAN COMMENT 'Indicates whether roaming services are enabled in this coverage area. True: roaming allowed. False: roaming not permitted.',
    `technology_type` STRING COMMENT 'The radio access or fixed-line technology providing coverage in this area. Values: 4G_LTE (Long-Term Evolution), 5G_NSA (5G New Radio Non-Standalone), 5G_SA (5G Standalone), 3G_UMTS (Universal Mobile Telecommunications System), FTTP (Fiber to the Premises), FTTN (Fiber to the Node), FTTC (Fiber to the Curb), HFC (Hybrid Fiber-Coaxial), FWA (Fixed Wireless Access), ADSL2_PLUS (Asymmetric Digital Subscriber Line 2+). [ENUM-REF-CANDIDATE: 4G_LTE|5G_NSA|5G_SA|3G_UMTS|FTTP|FTTN|FTTC|HFC|FWA|ADSL2_PLUS — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_coverage_area PRIMARY KEY(`coverage_area_id`)
) COMMENT 'Master record defining the radio frequency and fixed-line service coverage footprint for a specific technology and band combination — 4G LTE, 5G NR, 3G UMTS, ADSL2+, VDSL2, FTTC, FTTN, FTTP, HFC, Fixed Wireless Access (FWA). Captures coverage area identifier, technology type (4G, 5G_NSA, 5G_SA, FTTP, FTTN, FTTC, HFC, FWA), frequency band, coverage tier (outdoor, indoor, deep_indoor), predicted signal strength (dBm), predicted throughput (Mbps downlink/uplink), geometry (polygon WKT), effective date, expiry date, confidence level, generation method (drive_test, propagation_model, crowdsourced), and associated network element or exchange. Drives service qualification, order feasibility checks, and regulatory coverage reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`service_territory` (
    `service_territory_id` BIGINT COMMENT 'Unique identifier for the service territory. Primary key for the service territory master record.',
    `parent_territory_service_territory_id` BIGINT COMMENT 'Reference to the parent service territory in a hierarchical territory structure, enabling nested regional, divisional, and national territory rollups.',
    `parent_service_territory_id` BIGINT COMMENT 'Self-referencing FK on service_territory (parent_service_territory_id)',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area of the service territory measured in square kilometers, used for resource planning and coverage density analysis.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic centroid of the service territory, used for proximity calculations and mapping.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic centroid of the service territory, used for proximity calculations and mapping.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service territory record was first created in the system, used for audit trail and data lineage tracking.',
    `customer_count` BIGINT COMMENT 'Total number of active customers or subscriber accounts currently assigned to this service territory, used for workload balancing and capacity planning.',
    `dispatch_radius_km` DECIMAL(18,2) COMMENT 'Maximum travel distance in kilometers from the territory center or depot for field workforce dispatch, used for route optimization and scheduling.',
    `effective_date` DATE COMMENT 'Date when the service territory definition became or will become operationally active and available for assignment and use.',
    `expiry_date` DATE COMMENT 'Date when the service territory definition is scheduled to expire or was deactivated. Null indicates an open-ended territory with no planned expiration.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems or partners to reference this service territory, enabling cross-system reconciliation and data integration.',
    `franchise_agreement_code` BIGINT COMMENT 'Reference to the franchise or license agreement governing the right to provide telecommunications services within this territory, applicable for franchise_area territory types.',
    `geometry_wkt` STRING COMMENT 'Geographic boundary of the service territory represented as a Well-Known Text (WKT) polygon or multipolygon, enabling spatial queries and GIS integration for coverage analysis and network planning.',
    `hierarchy_level` STRING COMMENT 'Numeric level of the territory within the organizational hierarchy (e.g., 1=national, 2=regional, 3=district, 4=local), used for aggregation and reporting rollups.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the service territory record was most recently updated, used for change tracking and data synchronization.',
    `network_coverage_type` STRING COMMENT 'Primary network technology available within the service territory: 5g (5G New Radio), lte (Long-Term Evolution), 4g (4G), 3g (3G), ftth (Fiber to the Home), gpon (Gigabit Passive Optical Network), hybrid (multiple technologies), no_coverage (no network infrastructure). [ENUM-REF-CANDIDATE: 5g|lte|4g|3g|ftth|gpon|hybrid|no_coverage — 8 candidates stripped; promote to reference product]',
    `population_estimate` BIGINT COMMENT 'Estimated total population within the service territory boundaries, used for market sizing, capacity planning, and Average Revenue Per User (ARPU) forecasting.',
    `priority_level` STRING COMMENT 'Operational priority ranking of the service territory for resource allocation, incident response, and service restoration (lower number = higher priority).',
    `regulatory_jurisdiction` STRING COMMENT 'Name or code of the regulatory authority or jurisdiction governing telecommunications operations within this territory (e.g., state Public Utilities Commission, FCC region).',
    `service_availability_flag` BOOLEAN COMMENT 'Indicates whether telecommunications services are currently available for provisioning within this territory (True=services available, False=services not available or under construction).',
    `service_territory_description` STRING COMMENT 'Detailed textual description of the service territory, including geographic landmarks, boundary definitions, operational notes, and any special characteristics or constraints.',
    `site_count` STRING COMMENT 'Total number of network sites, cell towers, Points of Presence (POP), or infrastructure facilities located within the service territory boundaries.',
    `sla_response_time_minutes` STRING COMMENT 'Target response time in minutes for service incidents or trouble tickets originating within this territory, as defined by Service Level Agreement (SLA) commitments.',
    `territory_code` STRING COMMENT 'Externally-known unique business identifier for the service territory, used across operational systems for territory reference and assignment.. Valid values are `^[A-Z0-9]{4,12}$`',
    `territory_name` STRING COMMENT 'Human-readable name of the service territory, typically reflecting geographic or organizational designation (e.g., Northeast Metro Region, Downtown Dispatch Zone).',
    `territory_status` STRING COMMENT 'Current lifecycle status of the service territory: active (in operational use), inactive (temporarily not in use), proposed (planned but not yet activated), suspended (temporarily disabled), retired (permanently decommissioned).. Valid values are `active|inactive|proposed|suspended|retired`',
    `territory_type` STRING COMMENT 'Classification of the service territory by operational purpose: field_ops (field operations coverage), sales_region (sales team assignment), noc_zone (Network Operations Center monitoring zone), dispatch_zone (workforce dispatch area), franchise_area (licensed service area), regulatory_zone (compliance jurisdiction).. Valid values are `field_ops|sales_region|noc_zone|dispatch_zone|franchise_area|regulatory_zone`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the service territory (e.g., America/New_York), used for scheduling, Service Level Agreement (SLA) calculations, and workforce dispatch timing.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `version_number` STRING COMMENT 'Sequential version number of the service territory record, incremented with each modification to support change history and optimistic locking.',
    CONSTRAINT pk_service_territory PRIMARY KEY(`service_territory_id`)
) COMMENT 'Master record defining geographic service territories assigned to field workforce teams, sales regions, and operational zones within the telecommunications enterprise. Captures territory identifier, territory name, territory type (field_ops, sales_region, noc_zone, dispatch_zone, franchise_area, regulatory_zone), geometry (polygon WKT), assigned team or cost centre, territory manager, effective date, expiry date, parent territory reference for hierarchical nesting, and territory status (active, inactive, proposed). Distinct from workforce.service_territory which is workforce-dispatch-specific — this record is the geographic master definition used across network planning, sales, and regulatory domains.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`exchange` (
    `exchange_id` BIGINT COMMENT 'Unique identifier for the telecommunications exchange facility. Primary key.',
    `location_address_id` BIGINT COMMENT 'Reference to the physical address record where the exchange facility is located. Links to the address master data product.',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: Exchanges house primary network elements (DSLAMs, OLTs, MSANs) that serve fixed-line customers. Critical for service provisioning, fault management, capacity tracking, and exchange-level performance m',
    `parent_exchange_id` BIGINT COMMENT 'Self-referencing FK on exchange (parent_exchange_id)',
    `annual_opex` DECIMAL(18,2) COMMENT 'Estimated annual Operational Expenditure (OPEX) for maintaining and operating this exchange facility, including power, maintenance, and support costs. Used for profitability analysis and budget planning.',
    `asset_tag` STRING COMMENT 'Physical asset tag or serial number affixed to the exchange equipment for inventory tracking and asset management. Links to the enterprise asset management system.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `available_ports` STRING COMMENT 'Number of ports currently available for new customer connections. Calculated as port_capacity minus currently allocated ports. Used for real-time service qualification.',
    `backbone_connection_type` STRING COMMENT 'Type of backhaul or backbone connectivity linking this exchange to the core network. Determines reliability, latency, and bandwidth capabilities.. Valid values are `fiber|microwave|copper|satellite|hybrid`',
    `commissioning_date` DATE COMMENT 'Date when the exchange facility was officially commissioned and made operational for service delivery. Used for asset lifecycle tracking and depreciation calculations.',
    `coverage_radius_km` DECIMAL(18,2) COMMENT 'Approximate service coverage radius from the exchange facility in kilometers. Represents the maximum distance at which acceptable service quality can be maintained for the primary technology served.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exchange record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `current_connected_premises` STRING COMMENT 'Number of premises currently connected and receiving active service from this exchange. Used to calculate utilization rate and available capacity.',
    `data_source_system` STRING COMMENT 'Name of the operational system of record that is the authoritative source for this exchange data (e.g., Nokia NetAct, Ericsson Network Manager, Netcracker OSS). Used for data lineage and reconciliation.',
    `decommissioning_date` DATE COMMENT 'Date when the exchange facility was or is planned to be decommissioned and removed from service. Null for active exchanges. Critical for network modernization and migration planning.',
    `environmental_zone` STRING COMMENT 'Classification of the geographic environment where the exchange is located. Used for network planning, service pricing, and regulatory reporting of rural broadband coverage.. Valid values are `urban|suburban|rural|remote`',
    `equipment_model` STRING COMMENT 'Model number or designation of the primary exchange equipment installed at this facility. Used for technical support, firmware updates, and capacity planning.',
    `exchange_code` STRING COMMENT 'Operator-specific exchange code (e.g., Telstra/BT/AT&T exchange code) used for service qualification and network routing. Unique business identifier for the exchange within the operators network.. Valid values are `^[A-Z0-9]{3,10}$`',
    `exchange_name` STRING COMMENT 'Human-readable name of the exchange facility, typically reflecting the geographic area or locality served (e.g., Downtown Central Exchange, Suburban North DSLAM).',
    `exchange_status` STRING COMMENT 'Current operational lifecycle status of the exchange facility. Determines service availability and eligibility for new customer connections.. Valid values are `operational|planned|under_construction|decommissioned|maintenance`',
    `exchange_type` STRING COMMENT 'Classification of the exchange facility based on its function in the network topology. Determines the service delivery model and technology capabilities.. Valid values are `main_exchange|remote_integrated_multiplexer|street_cabinet|gpon_headend|dslam|bng`',
    `firmware_version` STRING COMMENT 'Current firmware or software version running on the exchange equipment. Critical for security patch management, feature availability, and troubleshooting.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `installation_cost` DECIMAL(18,2) COMMENT 'Total Capital Expenditure (CAPEX) incurred for the initial installation and commissioning of the exchange facility. Used for Return on Investment (ROI) analysis and asset valuation.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance activity performed on the exchange facility. Used for preventive maintenance scheduling and Mean Time Between Failures (MTBF) analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this exchange record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the exchange facility in decimal degrees format. Used for network planning, coverage mapping, and service qualification.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the exchange facility in decimal degrees format. Used for network planning, coverage mapping, and service qualification.',
    `max_serviceable_premises` STRING COMMENT 'Total number of residential and business premises that can theoretically be served from this exchange based on its capacity and coverage footprint. Used for network capacity planning and market sizing.',
    `mttr_target_hours` DECIMAL(18,2) COMMENT 'Target Mean Time to Repair in hours for this exchange facility as defined in the Service Level Agreement (SLA). Represents the maximum acceptable downtime for fault resolution.',
    `nbn_rollout_flag` BOOLEAN COMMENT 'Indicates whether this exchange is part of a national broadband network rollout program (e.g., NBN in Australia, FTTP in UK). True if the exchange is designated for fiber upgrade or replacement under a government-mandated program.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity on the exchange facility. Used for workforce planning and customer communication regarding potential service interruptions.',
    `operator_name` STRING COMMENT 'Name of the telecommunications operator or service provider that owns and operates this exchange facility.',
    `ownership_type` STRING COMMENT 'Ownership model for the exchange facility. Determines Capital Expenditure (CAPEX) vs Operational Expenditure (OPEX) treatment, maintenance responsibilities, and asset depreciation.. Valid values are `owned|leased|shared|third_party`',
    `port_capacity` STRING COMMENT 'Total number of physical or logical ports available at this exchange for customer connections. Represents the hard capacity limit for simultaneous active services.',
    `power_backup_type` STRING COMMENT 'Type of backup power system installed at the exchange facility to ensure service continuity during power outages. Critical for Service Level Agreement (SLA) compliance and disaster recovery planning.. Valid values are `battery|generator|ups|none|hybrid`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this exchange facility must be included in regulatory reporting submissions to governing bodies (FCC, Ofcom, etc.). True if the exchange serves a regulated service area or meets reporting thresholds.',
    `service_territory_code` STRING COMMENT 'Code identifying the administrative service territory or franchise area that this exchange serves. Used for regulatory compliance, billing zone determination, and market segmentation.. Valid values are `^[A-Z0-9]{2,8}$`',
    `sla_tier` STRING COMMENT 'Service level tier assigned to this exchange facility, determining restoration time commitments, monitoring frequency, and support priority. Higher tiers serve business-critical or high-revenue areas.. Valid values are `platinum|gold|silver|bronze|standard`',
    `technology_served` STRING COMMENT 'Primary broadband access technology delivered from this exchange facility. Determines service speed capabilities and customer eligibility for specific product offerings.. Valid values are `ADSL2+|VDSL2|FTTC|FTTN|FTTP|HFC|GPON|EPON`',
    `vendor_name` STRING COMMENT 'Name of the equipment vendor or manufacturer that supplied the primary exchange infrastructure (e.g., Nokia, Ericsson, Huawei, Cisco). Used for maintenance planning, spare parts management, and vendor performance tracking.',
    `wholesale_access_flag` BOOLEAN COMMENT 'Indicates whether this exchange facility is available for wholesale access by Mobile Virtual Network Operators (MVNOs) or other service providers. True if the exchange supports unbundled local loop or bitstream access.',
    CONSTRAINT pk_exchange PRIMARY KEY(`exchange_id`)
) COMMENT 'Master record for telecommunications exchange facilities — telephone exchanges, DSLAMs, street cabinets (RIMs/FTTCs), and GPON headend points that define the logical service delivery boundary for fixed-line broadband and voice services. Captures exchange identifier, exchange name, exchange code (Telstra/BT/AT&T exchange code), exchange type (main_exchange, remote_integrated_multiplexer, street_cabinet, GPON_headend), operator, address reference, geo-coordinates, technology served (ADSL2+, VDSL2, FTTC, FTTN, FTTP, HFC), maximum serviceable premises count, current connected premises count, exchange status (operational, planned, decommissioned), commissioning date, and regulatory reporting flag. Critical for service qualification and NBN/FTTP rollout planning.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`premise` (
    `premise_id` BIGINT COMMENT 'Unique identifier for the premise. Primary key for the premise master record.',
    `broadband_serviceable_location_premise_id` BIGINT COMMENT 'Federal Communications Commission (FCC) Broadband Serviceable Location (BSL) identifier for regulatory reporting under the Broadband Data Collection (BDC) program.',
    `element_id` BIGINT COMMENT 'Reference to the Digital Subscriber Line Access Multiplexer (DSLAM) equipment that serves this premise for DSL broadband services. Null if premise is not DSL-served.',
    `location_address_id` BIGINT COMMENT 'Reference to the standardized address record in the address master data product. Links premise to its postal and geographic address.',
    `mdu_parent_premise_id` BIGINT COMMENT 'Reference to the parent premise record for individual units within a Multi-Dwelling Unit (MDU). Null for standalone premises or the MDU parent record itself. Enables hierarchical premise relationships.',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory or franchise area that contains this premise. Used for regulatory compliance, service availability determination, and operational jurisdiction.',
    `parent_premise_id` BIGINT COMMENT 'Self-referencing FK on premise (parent_premise_id)',
    `access_restrictions` STRING COMMENT 'Description of any physical access restrictions or special requirements for field technicians to reach the premise. Examples include gated communities, security clearance requirements, restricted hours, or hazardous conditions.',
    `building_name` STRING COMMENT 'Official or common name of the building or structure at this premise. Applicable for named commercial buildings, apartment complexes, or government facilities.',
    `business_count` STRING COMMENT 'Number of distinct business entities or commercial tenants operating at this premise. Used for commercial service planning and market analysis.',
    `cadastral_reference` STRING COMMENT 'Official cadastral or land registry reference number linking the premise to government property records and land title systems.',
    `census_block_code` STRING COMMENT '15-digit Federal Information Processing Standards (FIPS) census block code identifying the smallest geographic unit for which census data is collected. Used for regulatory reporting and demographic analysis.. Valid values are `^[0-9]{15}$`',
    `construction_year` STRING COMMENT 'Year the building or structure at this premise was originally constructed. Used for infrastructure planning and building age analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was first created in the system. Used for data lineage and audit trail.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score (0-100) based on completeness, accuracy, and freshness of premise attributes. Used for data stewardship prioritization and analytics confidence assessment.',
    `dwelling_count` STRING COMMENT 'Number of individual dwelling units or serviceable endpoints within this premise. For Multi-Dwelling Units (MDU), represents the total unit count. For single-family homes, typically 1.',
    `floor_number` STRING COMMENT 'Floor or level identifier within a multi-story building. May include basement levels (B1, B2) or mezzanine levels (M). Null for single-story premises.',
    `fttn_serviceable_flag` BOOLEAN COMMENT 'Indicates whether the premise is serviceable via Fiber to the Node (FTTN) technology with copper last-mile. True if FTTN infrastructure serves the premise area, false otherwise.',
    `fttp_serviceable_flag` BOOLEAN COMMENT 'Indicates whether the premise is serviceable via Fiber to the Premise (FTTP) technology. True if fiber infrastructure reaches the premise, false otherwise.',
    `fwa_serviceable_flag` BOOLEAN COMMENT 'Indicates whether the premise is serviceable via Fixed Wireless Access (FWA) technology. True if wireless coverage and capacity are available, false otherwise.',
    `geocode_accuracy` STRING COMMENT 'Precision level of the latitude and longitude coordinates. Rooftop is most precise (building-level), parcel is property boundary, street is street segment, postal code is ZIP/postal area, city is municipality level, unknown indicates unverified coordinates.. Valid values are `rooftop|parcel|street|postal_code|city|unknown`',
    `hazard_zone_flag` BOOLEAN COMMENT 'Indicates whether the premise is located in a designated hazard zone (flood plain, earthquake zone, wildfire risk area, etc.). True if in hazard zone, false otherwise. Used for risk assessment and infrastructure planning.',
    `hfc_serviceable_flag` BOOLEAN COMMENT 'Indicates whether the premise is serviceable via Hybrid Fiber-Coaxial (HFC) cable network technology. True if HFC infrastructure reaches the premise, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this premise record was last updated. Used for change tracking and data synchronization.',
    `last_serviceability_update_date` DATE COMMENT 'Date when the technology serviceability flags (FTTP, HFC, FTTN, FWA, 5G, LTE) were last updated based on network infrastructure changes or coverage analysis.',
    `last_survey_date` DATE COMMENT 'Date when the premise was last physically surveyed or verified by field technicians. Used to assess data freshness and plan re-survey activities.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the premise in decimal degrees format. Used for network planning, coverage analysis, and field dispatch routing.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the premise in decimal degrees format. Used for network planning, coverage analysis, and field dispatch routing.',
    `lot_number` STRING COMMENT 'Legal lot or parcel number assigned by local government for property identification and taxation purposes.',
    `lte_serviceable_flag` BOOLEAN COMMENT 'Indicates whether the premise is within Long-Term Evolution (LTE) coverage area and can receive 4G mobile services. True if LTE coverage exists, false otherwise.',
    `n5g_serviceable_flag` BOOLEAN COMMENT 'Indicates whether the premise is within 5G New Radio (5G NR) coverage area and can receive 5G mobile services. True if 5G coverage exists, false otherwise.',
    `ownership_type` STRING COMMENT 'Classification of the legal ownership structure of the premise. Private for individual ownership, public for publicly-owned housing, government for government facilities, corporate for company-owned properties, cooperative for co-op housing, trust for trust-owned properties.. Valid values are `private|public|government|corporate|cooperative|trust`',
    `premise_code` STRING COMMENT 'Externally-known unique business identifier for the premise, used across systems and customer communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `premise_status` STRING COMMENT 'Current lifecycle status of the premise. Active premises are serviceable, demolished premises no longer exist, under construction premises are being built, planned premises are future sites, inactive premises exist but are not currently serviceable, condemned premises are marked for demolition.. Valid values are `active|demolished|under_construction|planned|inactive|condemned`',
    `premise_type` STRING COMMENT 'Classification of the premise based on its primary use and structure. Residential single-family, residential apartment, small commercial, large commercial, Multi-Dwelling Unit (MDU), government facility, or industrial site. [ENUM-REF-CANDIDATE: residential_single|residential_apartment|commercial_small|commercial_large|mdu|government|industrial — 7 candidates stripped; promote to reference product]',
    `rural_flag` BOOLEAN COMMENT 'Indicates whether the premise is classified as rural based on population density and distance from urban centers. True if rural, false if urban or suburban. Used for regulatory reporting and subsidy program eligibility.',
    `source_system` STRING COMMENT 'Name of the operational system that is the authoritative source for this premise record (e.g., Oracle Communications Order and Service Management, Netcracker OSS/BSS Suite, GIS system).',
    `tribal_land_flag` BOOLEAN COMMENT 'Indicates whether the premise is located on federally-recognized tribal land. True if on tribal land, false otherwise. Used for regulatory compliance and special program eligibility.',
    `unit_number` STRING COMMENT 'Apartment, suite, or unit identifier within a building. Used for Multi-Dwelling Units (MDU) and commercial office buildings to identify individual serviceable endpoints.',
    `zoning_classification` STRING COMMENT 'Local government zoning designation for the premise (e.g., R1 residential, C2 commercial, I1 industrial). Used for regulatory compliance and service planning.',
    CONSTRAINT pk_premise PRIMARY KEY(`premise_id`)
) COMMENT 'Master record for every addressable premise (dwelling, business, or infrastructure point) that is or could be a service delivery endpoint in the telecommunications network — residential dwellings, apartments, commercial premises, government buildings, and multi-dwelling units (MDUs). Captures premise identifier, premise type (residential_single, residential_apartment, commercial_small, commercial_large, MDU, government, industrial), address reference, geo-coordinates, building name, floor number, unit number, MDU parent premise reference, serviceable flag per technology (FTTP_serviceable, HFC_serviceable, FTTN_serviceable, FWA_serviceable, 5G_serviceable), premise status (active, demolished, under_construction), lot/parcel number, cadastral reference, and last survey date. The SSOT for premises distinct from customer.address which is customer-centric.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`administrative_region` (
    `administrative_region_id` BIGINT COMMENT 'Unique identifier for the administrative region record. Primary key for the administrative region entity.',
    `parent_region_administrative_region_id` BIGINT COMMENT 'Reference to the parent administrative region in the geographic hierarchy. Enables traversal of the region hierarchy (e.g., a county references its parent state, a suburb references its parent LGA). Null for top-level regions (countries).',
    `parent_administrative_region_id` BIGINT COMMENT 'Self-referencing FK on administrative_region (parent_administrative_region_id)',
    `administrative_region_status` STRING COMMENT 'Current lifecycle status of the administrative region record (active = currently in use, inactive = no longer in use, pending = awaiting activation, deprecated = superseded by another region definition).. Valid values are `active|inactive|pending|deprecated`',
    `alternate_name` STRING COMMENT 'Alternative or historical name for the administrative region. Used for search, matching, and legacy system integration (e.g., Bombay as alternate for Mumbai).',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area of the administrative region measured in square kilometres. Used for coverage analysis, network planning, and service territory definition.',
    `country_code` STRING COMMENT 'Two-letter ISO 3166-1 alpha-2 country code for the country in which this administrative region is located (e.g., US, AU, GB, CA). Denormalized for query performance.. Valid values are `^[A-Z]{2}$`',
    `coverage_priority` STRING COMMENT 'Network coverage priority classification for this administrative region (high, medium, low). Drives CAPEX allocation, network rollout planning, and service expansion decisions.. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this administrative region record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the official currency used in this administrative region (e.g., USD, EUR, GBP, AUD). Used for billing, pricing, and revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'Name of the source system or data feed from which this administrative region record was ingested (e.g., ISO Registry, ABS ASGS, ONS GSS, Netcracker OSS). Used for data lineage and reconciliation.',
    `economic_indicator` STRING COMMENT 'Economic development classification or indicator for the administrative region (e.g., GDP per capita band, socioeconomic index, development tier). Used for market analysis, pricing strategy, and ARPU forecasting.',
    `effective_date` DATE COMMENT 'Date from which this administrative region definition became effective. Supports temporal tracking of boundary changes, region mergers, and administrative reorganizations.',
    `expiry_date` DATE COMMENT 'Date on which this administrative region definition ceased to be effective. Null for currently active regions. Supports historical reporting and regulatory compliance for regions that have been merged, split, or abolished.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 code for the primary language spoken in this administrative region (e.g., en for English, es for Spanish, fr for French). Used for customer communication, billing, and support localization.. Valid values are `^[a-z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this administrative region record was last modified. Used for change tracking, data synchronization, and audit compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the administrative region centroid in decimal degrees (WGS84 datum). Used for mapping, coverage analysis, and geospatial queries. Range: -90.0000000 to +90.0000000.',
    `local_language_name` STRING COMMENT 'Name of the administrative region in the local or official language, using native script (e.g., München for Munich, 東京 for Tokyo). Supports multilingual customer interfaces and regulatory compliance.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the administrative region centroid in decimal degrees (WGS84 datum). Used for mapping, coverage analysis, and geospatial queries. Range: -180.0000000 to +180.0000000.',
    `market_segment` STRING COMMENT 'Market classification of the administrative region based on population density and urbanization (urban, suburban, rural, remote). Used for network planning, service pricing, and market analysis.. Valid values are `urban|suburban|rural|remote`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the administrative region. Used for documenting boundary changes, special considerations, or data quality issues.',
    `population_estimate` BIGINT COMMENT 'Estimated population count for the administrative region as of the most recent census or statistical estimate. Used for market sizing, network capacity planning, and regulatory reporting.',
    `postal_code_pattern` STRING COMMENT 'Regular expression or pattern describing the postal code format used in this administrative region (e.g., ^[0-9]{5}$ for US ZIP codes, ^[A-Z]{1,2}[0-9]{1,2} [0-9][A-Z]{2}$ for UK postcodes). Used for address validation and data quality.',
    `region_code` STRING COMMENT 'Standardized code for the administrative region. For countries: ISO 3166-1 alpha-2 (e.g., US, AU, GB). For subdivisions: ISO 3166-2 (e.g., US-CA, AU-NSW). For statistical areas: ABS ASGS codes, ONS GSS codes, or equivalent national standard codes.',
    `region_name` STRING COMMENT 'Official name of the administrative region as recognized by the governing authority (e.g., California, New South Wales, Greater London).',
    `region_type` STRING COMMENT 'Classification of the administrative region within the geographic hierarchy (e.g., country, state, territory, province, region, county, district, local government area, suburb, locality, postcode, municipality). [ENUM-REF-CANDIDATE: country|state|territory|province|region|county|district|lga|suburb|locality|postcode|municipality — 12 candidates stripped; promote to reference product]',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the telecommunications regulatory authority or jurisdiction governing this administrative region (e.g., FCC, Ofcom, ACMA, CRTC). Used for compliance reporting, licensing, and regulatory obligation tracking.',
    `service_availability_flag` BOOLEAN COMMENT 'Indicates whether telecommunications services are currently available in this administrative region (True = services available, False = services not available). Used for service eligibility checks and market coverage reporting.',
    `source_authority` STRING COMMENT 'Name of the authoritative body or organization that defines and maintains this administrative region classification (e.g., ISO, Australian Bureau of Statistics, Office for National Statistics UK, US Census Bureau, Statistics Canada).',
    `timezone` STRING COMMENT 'IANA time zone identifier for the administrative region (e.g., America/New_York, Australia/Sydney, Europe/London). Used for scheduling, service provisioning, and customer communication.',
    CONSTRAINT pk_administrative_region PRIMARY KEY(`administrative_region_id`)
) COMMENT 'Reference master for the full hierarchy of administrative and political regions used in telecommunications regulatory reporting, market analysis, and geographic classification — country, state/territory, region, county/district, local government area (LGA), suburb/locality, and postcode. Captures region identifier, region name, region code (ISO 3166-1 alpha-2 for countries, ISO 3166-2 for subdivisions, ABS ASGS codes, ONS GSS codes), region type, parent region reference for hierarchy traversal, population estimate, area in square kilometres, effective date, expiry date, and source authority. Provides the standardized geographic classification backbone for all cross-domain reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for the location hierarchy relationship record. Primary key for the location hierarchy association entity.',
    `location_site_id` BIGINT COMMENT 'Reference to the child location entity in the hierarchical relationship. Points to the lower-level geographic or administrative location.',
    `administrative_region_id` BIGINT COMMENT 'Foreign key linking to location.administrative_region. Business justification: Administrative regions are inherently hierarchical (country → state → city). Administrative_region already has parent_region_id for same-type hierarchies. Location_hierarchy enables cross-type hierarc',
    `geo_boundary_id` BIGINT COMMENT 'Foreign key linking to location.geo_boundary. Business justification: Geo boundaries have hierarchical relationships (geo_boundary already has parent_boundary_id for same-type hierarchies). Location_hierarchy enables cross-type hierarchies (e.g., administrative_region →',
    `geographic_zone_id` BIGINT COMMENT 'Foreign key linking to location.geographic_zone. Business justification: Geographic zones have parent-child relationships (geographic_zone already has parent_zone_id for same-type hierarchies). Location_hierarchy enables cross-type hierarchies (e.g., service_territory → ge',
    `parent_location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Location hierarchy is a polymorphic association product that links various location entities in parent-child relationships. When parent_location_type = site, the parent_location_id references a loca',
    `premise_id` BIGINT COMMENT 'Foreign key linking to location.premise. Business justification: Premises can be hierarchical (building → unit). Premise already has mdu_parent_premise_id for MDU-specific hierarchies. Location_hierarchy enables broader cross-type hierarchies (e.g., mdu_building → ',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Service territories have explicit hierarchical relationships (service_territory already has parent_territory_id for same-type hierarchies). Location_hierarchy enables CROSS-TYPE hierarchies (e.g., adm',
    `parent_hierarchy_id` BIGINT COMMENT 'Self-referencing FK on hierarchy (parent_hierarchy_id)',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the child location allocated to or associated with the parent location in this hierarchical relationship. Used when a location spans multiple parent territories and requires proportional allocation for capacity planning, revenue attribution, or regulatory reporting. Value range 0.00 to 100.00.',
    `child_location_type` STRING COMMENT 'Classification of the child location entity in the hierarchy. Defines the geographic or operational category of the child node. [ENUM-REF-CANDIDATE: administrative_region|geo_boundary|service_territory|exchange|site|premise|coverage_area — 7 candidates stripped; promote to reference product]',
    `coverage_overlap_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether the child location coverage area overlaps with sibling locations under the same parent. Used for network planning and coverage analysis to identify areas with redundant or overlapping service territories.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this location hierarchy relationship record was first created in the system. Supports audit trail and data lineage tracking for compliance and troubleshooting.',
    `depth_level` STRING COMMENT 'Numeric indicator of the depth position in the location hierarchy tree. Level 0 represents the root (typically country), with each subsequent level representing a deeper geographic granularity. Used for roll-up queries and traversal optimization.',
    `distance_from_parent_km` DECIMAL(18,2) COMMENT 'Geographic distance in kilometers between the centroid of the child location and the centroid of the parent location. Used for network latency estimation, fiber route planning, and Operational Expenditure (OPEX) modeling for field service dispatch.',
    `effective_date` DATE COMMENT 'The date from which this hierarchical relationship becomes active and valid for operational use. Supports temporal queries and historical analysis of location structure changes.',
    `expiry_date` DATE COMMENT 'The date on which this hierarchical relationship ceases to be active. Null value indicates an open-ended relationship. Supports temporal queries and historical tracking of location reorganizations.',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchical relationship purpose. Defines whether the relationship is used for administrative boundaries, operational planning, commercial territories, regulatory reporting, network planning, or coverage analysis.. Valid values are `administrative|operational|commercial|regulatory|network|coverage`',
    `is_primary_hierarchy` BOOLEAN COMMENT 'Boolean indicator identifying whether this relationship represents the primary or canonical hierarchical path for the child location. A location may participate in multiple hierarchies but typically has one primary path for default reporting and navigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this location hierarchy relationship record was most recently updated. Supports change tracking, audit compliance, and data quality monitoring for location master data governance.',
    `network_planning_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this hierarchical relationship is used for network infrastructure planning, Radio Access Network (RAN) design, capacity forecasting, and Capital Expenditure (CAPEX) allocation decisions.',
    `parent_location_type` STRING COMMENT 'Classification of the parent location entity in the hierarchy. Defines the geographic or operational category of the parent node. [ENUM-REF-CANDIDATE: country|administrative_region|geo_boundary|service_territory|exchange|site|premise — 7 candidates stripped; promote to reference product]',
    `path` STRING COMMENT 'Materialized path representation of the full hierarchical lineage from root to child location. Stored as a delimited string of location identifiers enabling efficient ancestor and descendant queries without recursive joins. Format example: /1/45/892/3421.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this hierarchical relationship is used for regulatory compliance reporting and submissions to governing bodies such as Federal Communications Commission (FCC), International Telecommunication Union (ITU), or regional telecommunications authorities.',
    `relationship_notes` STRING COMMENT 'Free-text field capturing additional context, exceptions, or special conditions related to this hierarchical relationship. Used to document boundary disputes, temporary reassignments, or operational constraints affecting the parent-child association.',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the hierarchical relationship. Indicates whether the relationship is currently in use, temporarily inactive, awaiting activation, or has been superseded.. Valid values are `active|inactive|pending|deprecated`',
    `service_delivery_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this hierarchical relationship is used for service provisioning, activation workflows, Order Management and Fulfillment processes, and Customer Premises Equipment (CPE) deployment planning.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Association record defining parent-child hierarchical relationships between location entities across different location types — enabling traversal from country down to individual premise through administrative regions, exchange boundaries, service territories, and coverage areas. Captures hierarchy record identifier, parent location type (administrative_region, geo_boundary, service_territory, exchange, site, premise), parent location reference, child location type, child location reference, hierarchy type (administrative, operational, commercial, regulatory), effective date, expiry date, and hierarchy depth level. Enables roll-up queries for coverage reporting, capacity planning, and regulatory submissions at any geographic granularity.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`coverage_qualification` (
    `coverage_qualification_id` BIGINT COMMENT 'Unique identifier for the coverage qualification check record. Primary key for the coverage qualification entity.',
    `coverage_area_id` BIGINT COMMENT 'Reference to the network coverage area polygon or zone that encompasses the qualified location.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or agent who initiated the qualification request. May be customer ID, agent ID, or API client ID.',
    `location_address_id` BIGINT COMMENT 'Reference to the address entity for which coverage qualification was performed.',
    `location_site_id` BIGINT COMMENT 'Reference to the nearest cell tower or base station serving the qualified location for wireless services.',
    `exchange_id` BIGINT COMMENT 'Reference to the nearest central office or exchange facility serving the qualified location.',
    `element_id` BIGINT COMMENT 'Identifier of the specific network node (OLT, DSLAM, BNG, eNodeB, gNodeB) that would serve the qualified location.',
    `premise_id` BIGINT COMMENT 'Reference to the premise entity for which coverage qualification was performed. May be null if qualification was performed at address level only.',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory or franchise area in which the qualified location resides.',
    `superseded_coverage_qualification_id` BIGINT COMMENT 'Self-referencing FK on coverage_qualification (superseded_coverage_qualification_id)',
    `business_service_flag` BOOLEAN COMMENT 'Indicates whether the qualified location is eligible for business-grade service offerings with enhanced SLA commitments.',
    `construction_required_flag` BOOLEAN COMMENT 'Indicates whether new infrastructure construction or network extension is required to serve the qualified location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the coverage qualification record was first created in the system.',
    `disqualification_reason_code` STRING COMMENT 'Standardized code indicating why the location was not qualified for service, if applicable. Null if location is serviceable.. Valid values are `no_infrastructure|distance_exceeded|capacity_exhausted|regulatory_restriction|construction_required|pending_buildout`',
    `disqualification_reason_description` STRING COMMENT 'Detailed explanation of why the location was not qualified for service, providing context for the disqualification reason code.',
    `distance_to_cell_site_km` DECIMAL(18,2) COMMENT 'Physical distance in kilometers from the qualified location to the nearest cell site, relevant for wireless coverage prediction.',
    `distance_to_exchange_km` DECIMAL(18,2) COMMENT 'Physical distance in kilometers from the qualified location to the nearest exchange, relevant for copper-based services.',
    `eligible_product_codes` STRING COMMENT 'Comma-separated list of product codes or SKUs that are available for purchase at the qualified location based on technology and speed capabilities.',
    `estimated_construction_cost` DECIMAL(18,2) COMMENT 'Estimated cost in local currency for required construction or network extension work, if applicable.',
    `estimated_construction_days` STRING COMMENT 'Estimated number of calendar days required to complete construction or network extension work, if applicable.',
    `ipv6_support_flag` BOOLEAN COMMENT 'Indicates whether IPv6 connectivity is supported at the qualified location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the coverage qualification record was last updated or modified.',
    `network_availability_percentage` DECIMAL(18,2) COMMENT 'Predicted network uptime percentage for the qualified location based on historical performance data.',
    `predicted_downlink_speed_mbps` DECIMAL(18,2) COMMENT 'Estimated maximum download speed in megabits per second that can be delivered to the location based on network modeling.',
    `predicted_latency_ms` DECIMAL(18,2) COMMENT 'Estimated network latency in milliseconds for the qualified location, representing round-trip time for data packets.',
    `predicted_uplink_speed_mbps` DECIMAL(18,2) COMMENT 'Estimated maximum upload speed in megabits per second that can be delivered to the location based on network modeling.',
    `primary_technology_available` STRING COMMENT 'The best or recommended network technology available at the qualified location based on performance and reliability. [ENUM-REF-CANDIDATE: ftth|5g_nr|lte|dsl|cable|fixed_wireless|satellite|none — 8 candidates stripped; promote to reference product]',
    `qos_class_available` STRING COMMENT 'Highest Quality of Service class that can be delivered at the qualified location based on network capabilities.. Valid values are `premium|standard|basic|best_effort`',
    `qualification_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the coverage qualification check was completed and results were returned.',
    `qualification_confidence_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0-100) indicating the reliability of the qualification result based on data quality and network modeling accuracy.',
    `qualification_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the qualification result expires and should be re-validated before service provisioning.',
    `qualification_method` STRING COMMENT 'Method used to perform the coverage qualification check, indicating the source and reliability of the qualification data.. Valid values are `real_time_api|batch_pre_qualification|manual_engineering|network_model|field_survey`',
    `qualification_notes` STRING COMMENT 'Free-text notes providing additional context, conditions, or special instructions related to the qualification result.',
    `qualification_number` STRING COMMENT 'Business-facing unique qualification reference number used for tracking and customer communication. Format: CQ followed by 10 digits.. Valid values are `^CQ[0-9]{10}$`',
    `qualification_request_timestamp` TIMESTAMP COMMENT 'Date and time when the coverage qualification check was requested by the user or system.',
    `qualification_result` STRING COMMENT 'Overall outcome of the coverage qualification check indicating whether service can be delivered to the location.. Valid values are `serviceable|not_serviceable|conditionally_serviceable|pending_verification|requires_engineering`',
    `qualification_status` STRING COMMENT 'Current processing status of the qualification request in its lifecycle.. Valid values are `completed|in_progress|failed|expired|cancelled`',
    `requesting_system` STRING COMMENT 'Source system or channel that initiated the coverage qualification request. [ENUM-REF-CANDIDATE: order_management|self_service_portal|dealer_portal|api|crm|field_sales|call_center|partner_portal — 8 candidates stripped; promote to reference product]',
    `static_ip_available_flag` BOOLEAN COMMENT 'Indicates whether static IP address assignment is available as an option at the qualified location.',
    `technologies_checked` STRING COMMENT 'Comma-separated list of network technologies evaluated during qualification (e.g., FTTH, 5G, LTE, DSL, Cable, Fixed Wireless).',
    CONSTRAINT pk_coverage_qualification PRIMARY KEY(`coverage_qualification_id`)
) COMMENT 'Transactional record of a service coverage qualification check performed against a specific address or premise to determine technology availability and predicted service parameters. Captures qualification identifier, address or premise reference, qualification request timestamp, requesting system (order management, self-service portal, dealer portal, API), technologies checked (list), qualification result per technology (serviceable, not_serviceable, conditionally_serviceable), predicted downlink speed (Mbps), predicted uplink speed (Mbps), predicted latency (ms), qualification confidence score, disqualification reason code, nearest exchange reference, nearest cell site reference, qualification method (real-time API, batch pre-qualification, manual), and qualification expiry timestamp. Feeds order.service_qualification and drives product eligibility.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`address_validation_event` (
    `address_validation_event_id` BIGINT COMMENT 'Unique identifier for each address validation and geocoding event. Primary key for the address validation event record.',
    `location_address_id` BIGINT COMMENT 'Reference to the address record that was validated. Links this validation event to the master address being verified.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that triggered the address validation event. May be a user ID for manual validations or a system process identifier for automated batch validations.',
    `reverification_of_address_validation_event_id` BIGINT COMMENT 'Self-referencing FK on address_validation_event (reverification_of_address_validation_event_id)',
    `api_response_code` STRING COMMENT 'The HTTP or service-specific response code returned by the validation API. Captures technical success or error codes from the external geocoding service (e.g., 200 for success, 400 for bad request, 500 for service error).',
    `api_response_message` STRING COMMENT 'Detailed message or description returned by the validation API. Provides additional context about the validation result, including error messages, warnings, or informational notes from the geocoding service.',
    `corrected_city` STRING COMMENT 'The standardized city or locality name returned by the validation service. Captures any corrections made to match official postal authority city names.',
    `corrected_country_code` STRING COMMENT 'The standardized three-letter country code returned by the validation service. Uses ISO 3166-1 alpha-3 format (e.g., USA, GBR, AUS, CAN).. Valid values are `^[A-Z]{3}$`',
    `corrected_postal_code` STRING COMMENT 'The standardized postal code or ZIP code returned by the validation service. Captures any corrections made to match authoritative postal code format and assignment.',
    `corrected_state_province` STRING COMMENT 'The standardized state, province, or region code returned by the validation service. Typically uses official postal abbreviations (e.g., CA for California, NSW for New South Wales).',
    `corrected_street_name` STRING COMMENT 'The standardized street name component returned by the validation service. Captures any corrections made to the input street name including spelling, abbreviations, and directional prefixes.',
    `corrected_street_number` STRING COMMENT 'The standardized street number component returned by the validation service. Captures any corrections made to the input street number to match authoritative format.',
    `corrected_street_type` STRING COMMENT 'The standardized street type component (e.g., Street, Avenue, Road, Boulevard) returned by the validation service. Captures any corrections made to match postal authority standards.',
    `corrected_unit_number` STRING COMMENT 'The standardized unit, apartment, or suite number component returned by the validation service. Captures any corrections made to secondary address designators.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this address validation event record was first created in the data platform. Audit field for data lineage and record lifecycle tracking in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dpv_confirmation_indicator` STRING COMMENT 'USPS-specific indicator confirming whether the address is a valid delivery point. Y indicates confirmed deliverable address; N indicates not confirmed; S indicates address is missing secondary (unit) number; D indicates address matched to USPS database but missing secondary information. Critical for mail deliverability assessment.. Valid values are `Y|N|S|D`',
    `geocoding_accuracy_level` STRING COMMENT 'Precision level of the geocoding result. Rooftop indicates exact building location; parcel indicates property boundary; street indicates street segment; intersection indicates cross-street; postal_code indicates ZIP/postcode centroid; city, region, country indicate progressively coarser granularity. [ENUM-REF-CANDIDATE: rooftop|parcel|street|intersection|postal_code|city|region|country — 8 candidates stripped; promote to reference product]',
    `geocoding_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate returned by the geocoding service, expressed in decimal degrees. Represents the north-south position of the validated address on Earths surface, ranging from -90 to +90 degrees.',
    `geocoding_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate returned by the geocoding service, expressed in decimal degrees. Represents the east-west position of the validated address on Earths surface, ranging from -180 to +180 degrees.',
    `input_address_string` STRING COMMENT 'The raw, unvalidated address string submitted for validation. Captures the exact input as received from the user or system before any normalization or correction.',
    `match_confidence_score` DECIMAL(18,2) COMMENT 'Numerical confidence score indicating the quality of the address match, ranging from 0 to 100. Higher scores indicate greater confidence in the validation result. Score of 100 represents exact match, lower scores indicate partial or interpolated matches.',
    `match_type` STRING COMMENT 'Classification of the address match result. Exact indicates perfect match to authoritative database; partial indicates some components matched; interpolated indicates address was estimated based on range; no_match indicates validation failed; ambiguous indicates multiple possible matches; corrected indicates input was modified to match standard.. Valid values are `exact|partial|interpolated|no_match|ambiguous|corrected`',
    `matched_address_string` STRING COMMENT 'The standardized, validated address string returned by the validation service. Represents the best match found in the authoritative address database.',
    `residential_delivery_indicator` STRING COMMENT 'Classification indicating whether the validated address is a residential or commercial location. Used for service eligibility determination, pricing, and network planning decisions in telecommunications service delivery.. Valid values are `residential|commercial|unknown`',
    `validation_cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred for this validation event when using external paid geocoding services. Tracks per-transaction costs for services like Google Maps API or HERE Maps that charge per validation request. Used for cost allocation and vendor billing reconciliation.',
    `validation_cost_currency` STRING COMMENT 'Three-letter ISO currency code for the validation cost amount. Typically USD for most geocoding API services.. Valid values are `^[A-Z]{3}$`',
    `validation_duration_ms` STRING COMMENT 'Time taken to complete the address validation request, measured in milliseconds. Used for performance monitoring and Service Level Agreement (SLA) tracking of validation service response times.',
    `validation_notes` STRING COMMENT 'Free-text field capturing additional context, observations, or special handling instructions related to the validation event. May include manual review notes, data quality observations, or business rules applied during validation.',
    `validation_source` STRING COMMENT 'The external or internal system used to perform the address validation. Identifies which geocoding or address verification service was invoked (GNAF for Australia, USPS AMS for USA, Royal Mail PAF for UK, Google Maps API, HERE Maps, internal geocoder, etc.). [ENUM-REF-CANDIDATE: gnaf|usps_ams|royal_mail_paf|google_maps_api|here_maps|internal_geocoder|canada_post|australia_post|other — 9 candidates stripped; promote to reference product]',
    `validation_status` STRING COMMENT 'Overall status of the address validation event. Valid indicates address passed verification; invalid indicates address could not be verified; ambiguous indicates multiple possible matches; corrected indicates address was modified; unverified indicates validation could not be completed; pending indicates validation in progress.. Valid values are `valid|invalid|ambiguous|corrected|unverified|pending`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the address validation event was performed. Captures the precise moment of validation execution in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `validation_trigger_source` STRING COMMENT 'The business process or system component that initiated the address validation event. Identifies whether validation was triggered by user action, automated data quality process, service provisioning workflow, or other business event. [ENUM-REF-CANDIDATE: manual_user|batch_process|api_call|data_quality_job|customer_onboarding|service_order|network_planning|other — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_address_validation_event PRIMARY KEY(`address_validation_event_id`)
) COMMENT 'Transactional record of each address validation and geocoding event performed against an address record — capturing the full audit trail of address verification attempts, results, and corrections. Captures event identifier, address reference, validation timestamp, validation source (GNAF, USPS AMS, Royal Mail PAF, Google Maps API, HERE Maps, internal geocoder), input address string, matched address string, match confidence score (0-100), match type (exact, partial, interpolated, no_match), geocoding result (latitude, longitude, accuracy level), validation status (valid, invalid, ambiguous, corrected), corrected address components, operator who triggered validation (system or user ID), and validation API response code. Provides full audit trail for address data quality management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`coverage_area_version` (
    `coverage_area_version_id` BIGINT COMMENT 'Unique identifier for this immutable versioned snapshot of a coverage area polygon. Primary key for the coverage area version record.',
    `coverage_area_id` BIGINT COMMENT 'Reference to the parent coverage area entity for which this version record represents a point-in-time snapshot. Links to the master coverage area.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or automated process that created this coverage area version. Supports audit and accountability for coverage data changes.',
    `previous_coverage_area_version_id` BIGINT COMMENT 'Self-referencing FK on coverage_area_version (previous_coverage_area_version_id)',
    `approval_status` STRING COMMENT 'Workflow status of this coverage area version. Tracks progression from draft through review and approval before operational use. Supports governance and quality assurance of coverage data.. Valid values are `draft|pending_review|approved|rejected|superseded`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this coverage area version was approved for operational use. Null if not yet approved. Supports audit trail and compliance reporting.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area in square kilometers covered by this coverage polygon at this version. Used for coverage density analysis and regulatory reporting.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geometric centroid of this coverage area polygon at this version. Facilitates spatial indexing and proximity searches.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geometric centroid of this coverage area polygon at this version. Facilitates spatial indexing and proximity searches.',
    `change_reason` STRING COMMENT 'Business or technical reason for creating this new version of the coverage area. Supports audit trails and regulatory reporting of coverage changes. Values include network expansion, cell reconfiguration, decommissioning, propagation model updates, drive test corrections, and regulatory mandates.. Valid values are `network_expansion|cell_reconfig|decommission|model_update|drive_test_correction|regulatory_mandate`',
    `coverage_tier` STRING COMMENT 'Qualitative classification of signal strength and service quality within this coverage area version. Used for customer-facing coverage maps and network planning prioritization.. Valid values are `excellent|good|fair|marginal|fringe|no_coverage`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this coverage area version record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_source` STRING COMMENT 'Origin or methodology used to generate this coverage area version. Values include RF propagation modeling, drive test measurements, crowd-sourced data, vendor planning tools, regulatory submissions, or hybrid approaches.. Valid values are `rf_propagation_model|drive_test|crowd_sourced|vendor_planning_tool|regulatory_submission|hybrid`',
    `geometry_wkt` STRING COMMENT 'Immutable snapshot of the coverage area polygon geometry in Well-Known Text format. Captures the precise geographic boundary of network coverage at this versions effective date. Used for spatial analysis and regulatory compliance reporting.',
    `indoor_coverage_flag` BOOLEAN COMMENT 'Indicates whether this coverage area version includes reliable indoor coverage. True if indoor penetration is modeled or verified; false if coverage is outdoor-only or uncertain.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this coverage area version record was last updated. Supports audit trail and change tracking. Should rarely change after initial creation since versions are immutable snapshots.',
    `mobility_support_flag` BOOLEAN COMMENT 'Indicates whether this coverage area supports mobile handover and roaming. True for mobile network coverage; false for fixed wireless or stationary service areas.',
    `model_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) representing the reliability of the coverage prediction for this version. Higher scores indicate greater certainty based on measurement density, model validation, or drive test correlation.',
    `population_covered` BIGINT COMMENT 'Estimated population residing within this coverage area at this version. Derived from census data overlays. Critical metric for regulatory coverage obligations and market analysis.',
    `predicted_signal_strength_dbm` DECIMAL(18,2) COMMENT 'Average predicted received signal strength in decibels relative to one milliwatt (dBm) within this coverage area at this version. Derived from RF propagation models or drive test data.',
    `predicted_throughput_mbps` DECIMAL(18,2) COMMENT 'Average predicted downlink throughput in megabits per second (Mbps) achievable within this coverage area at this version. Used for service tier planning and customer expectation setting.',
    `premises_covered` BIGINT COMMENT 'Estimated number of residential and business premises within this coverage area at this version. Used for serviceable address analysis and broadband availability reporting.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier of the regulatory filing or submission associated with this coverage area version. Links coverage data to compliance obligations such as FCC Form 477 or Ofcom coverage reports.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory authority or jurisdiction governing this coverage area (e.g., FCC, Ofcom, ACMA, BEREC member state). Determines applicable coverage reporting obligations and service standards.',
    `site_count` STRING COMMENT 'Number of network sites (cell towers, base stations, or fiber nodes) contributing coverage to this area at this version. Used for network density analysis and capacity planning.',
    `spectrum_band` STRING COMMENT 'Radio frequency spectrum band or bands used to provide coverage in this area at this version (e.g., 700MHz, 1800MHz, 2.6GHz, 3.5GHz, mmWave). Applicable to wireless technologies only.',
    `technology_type` STRING COMMENT 'Radio access or wireline technology providing coverage in this area at this version. Distinguishes between mobile generations (2G, 3G, LTE, 5G NR) and fixed technologies (FTTH, GPON, DSL, cable, satellite, fixed wireless). [ENUM-REF-CANDIDATE: 2G|3G|4G_LTE|5G_NR|FTTH|GPON|DSL|CABLE|SATELLITE|FIXED_WIRELESS — 10 candidates stripped; promote to reference product]',
    `version_effective_date` DATE COMMENT 'Date when this version of the coverage area became active and operationally valid. Marks the start of this versions validity period for regulatory and operational reporting.',
    `version_expiry_date` DATE COMMENT 'Date when this version of the coverage area was superseded or decommissioned. Null for the current active version. Marks the end of this versions validity period.',
    `version_notes` STRING COMMENT 'Free-text notes or comments describing the changes, context, or special considerations for this coverage area version. Supports operational knowledge transfer and audit documentation.',
    `version_number` STRING COMMENT 'Sequential version number for this coverage area snapshot. Increments with each change to the coverage polygon or attributes. Enables chronological ordering of coverage evolution.',
    CONSTRAINT pk_coverage_area_version PRIMARY KEY(`coverage_area_version_id`)
) COMMENT 'Immutable versioned snapshot record of a coverage area polygon at a specific point in time — enabling historical coverage analysis, regulatory compliance reporting, and before/after comparison of network rollout progress. Captures version identifier, coverage area reference, version number, version effective date, version expiry date, geometry snapshot (WKT polygon), technology type, coverage tier, predicted signal strength, predicted throughput, change reason (network_expansion, cell_reconfig, decommission, model_update, drive_test_correction), changed by (system or operator), and approval status. Supports regulatory obligations to report coverage changes to bodies such as FCC, Ofcom, ACMA, and BEREC.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` (
    `network_rollout_zone_id` BIGINT COMMENT 'Unique identifier for the network infrastructure rollout zone. Primary key for the network rollout zone entity.',
    `administrative_region_id` BIGINT COMMENT 'Identifier of the administrative region (county, municipality, census tract) that this rollout zone is located within. Used for regulatory reporting and demographic analysis.',
    `contractor_id` BIGINT COMMENT 'Identifier of the primary construction contractor or vendor responsible for physical build activities in this zone. Used for vendor performance tracking and contract management.',
    `employee_id` BIGINT COMMENT 'Identifier of the project manager or programme lead responsible for delivery of this rollout zone. Used for accountability, escalation, and resource allocation.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this rollout zone record. Used for audit trail and accountability.',
    `service_territory_id` BIGINT COMMENT 'Identifier of the service territory that this rollout zone falls within or will become part of upon completion. Used for operational handover and service delivery planning.',
    `parent_network_rollout_zone_id` BIGINT COMMENT 'Self-referencing FK on network_rollout_zone (parent_network_rollout_zone_id)',
    `actual_capex_amount` DECIMAL(18,2) COMMENT 'Actual capital expenditure incurred to date for the rollout zone in local currency. Updated as costs are recorded. Used for variance analysis and cost control.',
    `actual_completion_date` DATE COMMENT 'Actual date when the rollout zone was declared complete and ready for service. Null until zone reaches completed status. Used for schedule variance analysis and lessons learned.',
    `actual_premises_passed_count` STRING COMMENT 'Actual number of premises passed as of the current date. Updated as construction progresses. Used for variance analysis against planned targets and regulatory reporting.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area of the rollout zone in square kilometers. Used for density calculations, resource planning, and CAPEX modeling.',
    `business_location_count_estimate` STRING COMMENT 'Estimated number of commercial and business locations within the rollout zone. Used for enterprise market opportunity assessment.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic centroid of the rollout zone polygon, in decimal degrees (WGS84). Used for mapping, distance calculations, and zone proximity analysis.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic centroid of the rollout zone polygon, in decimal degrees (WGS84). Used for mapping, distance calculations, and zone proximity analysis.',
    `construction_start_date` DATE COMMENT 'Date when physical construction activities commenced in the rollout zone. Null if construction not yet started. Used for schedule tracking and milestone reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rollout zone record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rollout zone record (e.g., USD, GBP, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `data_source_system` STRING COMMENT 'Name of the source system or application that originated or maintains this rollout zone record (e.g., Oracle OSM, Netcracker Resource Inventory, SAP S/4HANA Project System). Used for data lineage and integration troubleshooting.',
    `environmental_clearance_status` STRING COMMENT 'Status of environmental impact assessment and regulatory clearance for the rollout zone. Not_required: no assessment needed; Pending: under review; Approved: cleared for construction; Conditional: approved with mitigation requirements; Denied: clearance refused.. Valid values are `not_required|pending|approved|conditional|denied`',
    `estimated_capex_amount` DECIMAL(18,2) COMMENT 'Estimated total capital expenditure for the rollout zone in local currency. Includes materials, labor, permits, and indirect costs. Used for budget planning and financial forecasting.',
    `funding_source` STRING COMMENT 'Primary source of capital funding for the rollout zone. Commercial: fully private investment; Government_subsidy: federal/state grant or subsidy; Universal_service: USF or equivalent fund; Public_private_partnership: blended funding model; Internal_capex: corporate capital budget.. Valid values are `commercial|government_subsidy|universal_service|public_private_partnership|internal_capex`',
    `geometry_wkt` STRING COMMENT 'Geographic boundary of the rollout zone represented as a polygon in Well-Known Text (WKT) format. Used for spatial analysis, coverage planning, and regulatory subsidy zone validation.',
    `household_count_estimate` STRING COMMENT 'Estimated number of residential households within the rollout zone. Used for addressable market analysis and service penetration modeling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rollout zone record was last updated. Used for change tracking and data freshness assessment.',
    `median_household_income` DECIMAL(18,2) COMMENT 'Median annual household income for the rollout zone area in local currency. Used for market segmentation, product mix planning, and affordability analysis.',
    `network_activation_date` DATE COMMENT 'Date when the network infrastructure in this zone was activated and made available for service provisioning. Null if not yet activated. Used for service readiness and revenue forecasting.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, lessons learned, or operational notes related to the rollout zone. Used for knowledge capture and handover documentation.',
    `permit_approval_date` DATE COMMENT 'Date when all required construction permits and right-of-way approvals were obtained for the rollout zone. Null if permits not yet approved. Used for schedule tracking and regulatory compliance.',
    `planned_completion_date` DATE COMMENT 'Target date for completion of all construction and activation activities in the rollout zone. Used for project scheduling, milestone tracking, and subsidy deadline compliance.',
    `planned_premises_passed_count` STRING COMMENT 'Target number of residential and business premises that will have network infrastructure available upon completion of the rollout zone. Key metric for CAPEX planning and regulatory subsidy compliance.',
    `population_estimate` STRING COMMENT 'Estimated total population residing within the rollout zone boundaries. Used for market sizing, penetration forecasting, and regulatory reporting.',
    `priority_level` STRING COMMENT 'Business priority assigned to this rollout zone. Critical: regulatory deadline or strategic imperative; High: competitive or revenue opportunity; Medium: standard programme cadence; Low: opportunistic or deferred.. Valid values are `critical|high|medium|low`',
    `programme_name` STRING COMMENT 'Name of the broader infrastructure programme or initiative this zone belongs to (e.g., NBN Co National Broadband Network, RDOF Rural Digital Opportunity Fund, BEAD Broadband Equity Access and Deployment, Project Gigabit UK). Used for portfolio management and regulatory reporting.',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the regulatory authority or jurisdiction governing this rollout zone (e.g., FCC, Ofcom, ACMA, State Public Utilities Commission). Used for compliance tracking and reporting requirements.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for successful delivery of the rollout zone. Considers permitting risk, terrain complexity, contractor capacity, and schedule pressure. Used for executive reporting and mitigation planning.. Valid values are `low|medium|high|critical`',
    `rollout_phase` STRING COMMENT 'Current phase of the rollout project lifecycle. Design: engineering and planning; Permitting: regulatory approvals; Procurement: material and contractor acquisition; Construction: physical build; Testing: network commissioning; Activation: service turn-up; Closeout: final documentation and handover. [ENUM-REF-CANDIDATE: design|permitting|procurement|construction|testing|activation|closeout — 7 candidates stripped; promote to reference product]',
    `subsidy_award_amount` DECIMAL(18,2) COMMENT 'Total government subsidy or grant amount awarded for this rollout zone in local currency. Null if no subsidy awarded. Used for financial tracking and regulatory reporting.',
    `subsidy_eligible_flag` BOOLEAN COMMENT 'Indicates whether this rollout zone qualifies for government subsidy or universal service funding. True if eligible; False otherwise. Used for funding application and compliance reporting.',
    `target_technology` STRING COMMENT 'Primary network technology being deployed in this rollout zone. GPON: Gigabit Passive Optical Network; XGS_PON: 10 Gigabit Symmetric PON; NG_PON2: Next-Generation PON 2; 5G_NR: 5G New Radio; LTE_Advanced: 4G LTE-A; DOCSIS_3_1/4_0: Data Over Cable Service Interface Specification; FWA: Fixed Wireless Access. [ENUM-REF-CANDIDATE: GPON|XGS_PON|NG_PON2|5G_NR|LTE_Advanced|DOCSIS_3_1|DOCSIS_4_0|FWA_5G|FWA_LTE — 9 candidates stripped; promote to reference product]',
    `underserved_premises_count` STRING COMMENT 'Number of premises within the zone that have broadband service below target speed thresholds (typically below 100/20 Mbps or jurisdiction-specific standard). Used for subsidy eligibility and upgrade prioritization.',
    `unserved_premises_count` STRING COMMENT 'Number of premises within the zone that currently have no broadband service meeting minimum speed thresholds (typically 25/3 Mbps or jurisdiction-specific standard). Used for subsidy eligibility and digital divide reporting.',
    `version_number` STRING COMMENT 'Version number of this rollout zone record, incremented with each update. Used for optimistic locking and change history tracking.',
    `zone_code` STRING COMMENT 'Externally-known unique business identifier for the rollout zone, used in project documentation, regulatory filings, and inter-departmental communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `zone_name` STRING COMMENT 'Human-readable name of the network rollout zone, typically reflecting geographic area or project designation (e.g., Downtown Metro FTTP Phase 2, Rural County 5G Expansion).',
    `zone_status` STRING COMMENT 'Current lifecycle status of the rollout zone. Planned: approved but not yet started; In_progress: active construction or deployment; Completed: all work finished and zone operational; Cancelled: project terminated; On_hold: temporarily suspended.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `zone_type` STRING COMMENT 'Classification of the network rollout zone by deployment type. FTTP_greenfield: new fiber build in unserved areas; FTTP_brownfield: fiber overbuild in existing service areas; 5G_densification: small cell and macro site additions; HFC_upgrade: hybrid fiber-coax network modernization; FWA_deployment: fixed wireless access rollout; FTTN_remediation: fiber-to-the-node upgrade or replacement.. Valid values are `FTTP_greenfield|FTTP_brownfield|5G_densification|HFC_upgrade|FWA_deployment|FTTN_remediation`',
    CONSTRAINT pk_network_rollout_zone PRIMARY KEY(`network_rollout_zone_id`)
) COMMENT 'Master record for planned and in-progress network infrastructure rollout zones — FTTP build areas, 5G densification zones, HFC upgrade corridors, and FWA deployment zones. Captures rollout zone identifier, zone name, zone type (FTTP_greenfield, FTTP_brownfield, 5G_densification, HFC_upgrade, FWA_deployment, FTTN_remediation), geometry (polygon WKT), target technology, planned premises passed count, actual premises passed count, planned completion date, actual completion date, rollout phase, programme name (e.g., NBN Co, RDOF, BEAD, Project Gigabit), funding source (commercial, government_subsidy, universal_service), zone status (planned, in_progress, completed, cancelled), and responsible project manager. Drives capital planning and regulatory subsidy reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`premises_passed` (
    `premises_passed_id` BIGINT COMMENT 'Unique identifier for the premises passed event record. Primary key for this transactional record capturing when a specific premise was made serviceable by network infrastructure rollout.',
    `contractor_id` BIGINT COMMENT 'Reference to the construction contractor or deployment partner responsible for passing this premise. Used for performance tracking, quality assurance, and payment reconciliation.',
    `field_survey_id` BIGINT COMMENT 'Reference to the field survey or site assessment record that validated this premises passed event. Links to the engineering survey that confirmed infrastructure readiness.',
    `element_id` BIGINT COMMENT 'Reference to the specific network element (OLT - Optical Line Terminal, cabinet, node, DSLAM, BNG - Broadband Network Gateway) that serves this passed premise. Critical for capacity planning and service activation.',
    `network_rollout_zone_id` BIGINT COMMENT 'Reference to the network rollout zone or deployment area within which this premise was passed. Used for tracking infrastructure expansion by geographic deployment phases.',
    `premise_id` BIGINT COMMENT 'Reference to the specific premise (residential or commercial property) that has been passed by the network infrastructure. Links to the master premise record in the location domain.',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that verified and approved this premises passed record. Used for accountability and audit trail purposes.',
    `superseded_premises_passed_id` BIGINT COMMENT 'Self-referencing FK on premises_passed (superseded_premises_passed_id)',
    `activation_readiness_status` STRING COMMENT 'Current status of the premises readiness for service activation. Ready to connect (can be activated immediately), pending construction (infrastructure work in progress), awaiting permit (regulatory approval needed), blocked (physical or legal impediment), or under review (assessment in progress).. Valid values are `ready_to_connect|pending_construction|awaiting_permit|blocked|under_review`',
    `business_premise_flag` BOOLEAN COMMENT 'Boolean indicator of whether this premise is classified as a business or commercial location rather than residential. True indicates business premise; affects product eligibility, SLA requirements, and pricing.',
    `competitive_overlap_flag` BOOLEAN COMMENT 'Boolean indicator of whether this premise is also served by competing network infrastructure from other telecommunications providers. True indicates competitive overlap; used for market analysis and strategic planning.',
    `connection_cost_tier` STRING COMMENT 'Categorical classification of the connection cost complexity. Standard (normal installation), medium (minor additional work), high (significant construction required), or custom (requires individual assessment and quote).. Valid values are `standard|medium|high|custom`',
    `construction_completion_date` DATE COMMENT 'The date on which physical construction or infrastructure deployment was completed for this premise. May differ from pass_date if there is a lag between construction completion and formal service readiness declaration.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this premises passed record was first created in the system. Used for audit trail, data lineage, and regulatory reporting compliance.',
    `data_source` STRING COMMENT 'The originating source system or process that created this premises passed record. Field survey (engineering site visit), OSS system (Operations Support System automated detection), contractor report (third-party submission), GIS import (geographic information system batch load), or customer inquiry (customer-initiated request).. Valid values are `field_survey|oss_system|contractor_report|gis_import|customer_inquiry`',
    `distance_to_network_metres` DECIMAL(18,2) COMMENT 'The physical distance in metres from the premise to the nearest network access point or serving network element. Used for estimating connection feasibility, signal quality, and installation cost.',
    `estimated_connection_cost` DECIMAL(18,2) COMMENT 'The estimated cost in local currency to activate service at this premise, based on distance, pass type, and required infrastructure work. Used for customer quoting and financial planning.',
    `external_reference_code` STRING COMMENT 'External system identifier or reference number for this premises passed record in the source system (contractor system, GIS platform, or OSS). Used for cross-system reconciliation and data lineage tracking.',
    `franchise_area_code` STRING COMMENT 'The franchise or license area code within which this premise is located. Used for regulatory compliance, franchise fee calculation, and territorial rights management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this premises passed record was last updated or modified. Used for change tracking, audit trail, and data quality monitoring.',
    `maximum_service_speed_mbps` STRING COMMENT 'The maximum downstream service speed in megabits per second (Mbps) that can be delivered to this premise based on the technology type, distance, and network element capacity. Used for product catalog eligibility and customer expectation setting.',
    `mdu_flag` BOOLEAN COMMENT 'Boolean indicator of whether this premise is part of a Multi-Dwelling Unit (MDU) such as an apartment building, condominium complex, or office building. True indicates MDU; affects service delivery model and bulk provisioning strategies.',
    `network_element_type` STRING COMMENT 'The type of network element serving this premise. OLT (Optical Line Terminal), ONT (Optical Network Terminal), Cabinet (street cabinet), Node (distribution node), DSLAM (Digital Subscriber Line Access Multiplexer), BNG (Broadband Network Gateway), or BRAS (Broadband Remote Access Server). [ENUM-REF-CANDIDATE: OLT|ONT|Cabinet|Node|DSLAM|BNG|BRAS — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this premises passed event, including special conditions, construction challenges, access restrictions, or follow-up actions required. Used for operational coordination and issue tracking.',
    `pass_date` DATE COMMENT 'The date on which the premise was formally passed or made serviceable by the network infrastructure. This is the official date the premise became reachable by the network, critical for regulatory premises-passed reporting and NBN Co compliance.',
    `pass_reference_number` STRING COMMENT 'External business identifier for this premises passed event, typically assigned by the field deployment team or contractor. Used for tracking and reconciliation with field survey reports.',
    `pass_type` STRING COMMENT 'Classification of the pass readiness level indicating the type of infrastructure available at the premise. Aerial drop available (overhead cable ready), underground duct available (conduit in place), active port available (live connection point ready), or on-demand only (requires additional construction).. Valid values are `aerial_drop_available|underground_duct_available|active_port_available|on_demand_only`',
    `port_capacity_available` STRING COMMENT 'The number of available service ports on the serving network element that can be allocated to this premise. Critical for capacity management and preventing oversubscription in GPON and FTTH deployments.',
    `priority_level` STRING COMMENT 'The deployment or service priority level assigned to this premise. Critical (essential services, government, healthcare), high (business, high-value residential), medium (standard residential), or low (deferred deployment areas).. Valid values are `critical|high|medium|low`',
    `qos_class` STRING COMMENT 'The Quality of Service (QoS) class or service tier that can be delivered to this premise based on network capacity and technology. Premium (guaranteed high performance), standard (typical residential), basic (entry-level), or best effort (no guarantee).. Valid values are `premium|standard|basic|best_effort`',
    `record_status` STRING COMMENT 'The current lifecycle status of this premises passed record. Active (current and valid), superseded (replaced by newer record), cancelled (voided or incorrect), or under review (pending validation or correction).. Valid values are `active|superseded|cancelled|under_review`',
    `regulatory_classification` STRING COMMENT 'Regulatory geographic classification of the premise location for compliance reporting and subsidy eligibility. Urban (high-density area), suburban (medium-density), rural (low-density), or remote (very low-density or hard-to-reach).. Valid values are `urban|suburban|rural|remote`',
    `roaming_zone` STRING COMMENT 'The roaming zone classification for this premise location, relevant for mobile and fixed wireless access services. Used for billing, service availability, and interconnect agreements.',
    `serviceable_flag` BOOLEAN COMMENT 'Boolean indicator of whether the premise is currently serviceable and ready for customer activation. True indicates the premise can be connected without additional infrastructure work; false indicates further construction or engineering is required.',
    `subsidy_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this premises passed event qualifies for government subsidy, grant, or universal service funding. True indicates eligibility for programs such as FCC RDOF, Connect America Fund, or NBN Co government funding.',
    `technology_type` STRING COMMENT 'The network technology type used to pass this premise. FTTH (Fiber to the Home), FTTP (Fiber to the Premises), HFC (Hybrid Fiber-Coaxial), GPON (Gigabit Passive Optical Network), DOCSIS (Data Over Cable Service Interface Specification), DSL (Digital Subscriber Line), Fixed Wireless, or 5G FWA (Fixed Wireless Access). [ENUM-REF-CANDIDATE: FTTH|FTTP|HFC|GPON|DOCSIS|DSL|Fixed_Wireless|5G_FWA — 8 candidates stripped; promote to reference product]',
    `unit_count` STRING COMMENT 'The number of individual dwelling units or service locations within this premise if it is an MDU. Null or 1 for single-family premises. Used for capacity planning and revenue forecasting.',
    `verification_date` DATE COMMENT 'The date on which the premises passed status was verified and confirmed. Used for audit trails and regulatory reporting accuracy.',
    `verification_method` STRING COMMENT 'The method used to verify and record this premises passed event. Field inspection (physical site visit), OSS system (automated network management system detection), GIS analysis (geographic information system modeling), contractor report (third-party submission), or customer request (customer-initiated inquiry).. Valid values are `field_inspection|oss_system|gis_analysis|contractor_report|customer_request`',
    CONSTRAINT pk_premises_passed PRIMARY KEY(`premises_passed_id`)
) COMMENT 'Transactional record capturing the event of a specific premise being passed or made serviceable by a network infrastructure rollout — the formal record that a premise has been connected to or is within reach of the network. Captures premises passed identifier, premise reference, rollout zone reference, technology type, pass date, pass type (aerial_drop_available, underground_duct_available, active_port_available, on_demand_only), network element reference (OLT, cabinet, node), distance to network (metres), estimated connection cost, connection cost tier, serviceable flag, activation readiness status, and data source (field survey, OSS system, contractor report). Critical for NBN Co, FTTP, and HFC rollout tracking and regulatory premises-passed reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` (
    `cell_coverage_footprint_id` BIGINT COMMENT 'Unique identifier for the cell coverage footprint record. Primary key for this entity.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Cell coverage footprints belong to a specific coverage area; linking provides hierarchical context and removes the silo.',
    `ran_cell_id` BIGINT COMMENT 'Reference to the specific RAN cell sector that generates this coverage footprint. Links to the network.ran_cell master data product.',
    `superseded_cell_coverage_footprint_id` BIGINT COMMENT 'Self-referencing FK on cell_coverage_footprint (superseded_cell_coverage_footprint_id)',
    `antenna_gain_dbi` DECIMAL(18,2) COMMENT 'The gain of the antenna in dBi (decibels relative to an isotropic radiator). Higher gain increases coverage range in the direction of the main lobe.',
    `antenna_height_meters` DECIMAL(18,2) COMMENT 'The height of the antenna above ground level in meters. Key parameter for propagation modeling and coverage prediction.',
    `azimuth_degrees` DECIMAL(18,2) COMMENT 'The horizontal direction in degrees (0-360) that the antenna is pointing, measured clockwise from true north. Critical for coverage prediction and interference analysis.',
    `beamwidth_horizontal_degrees` DECIMAL(18,2) COMMENT 'The horizontal beamwidth of the antenna in degrees, defining the angular coverage in the azimuth plane. Typically 65 or 90 degrees for sector antennas.',
    `beamwidth_vertical_degrees` DECIMAL(18,2) COMMENT 'The vertical beamwidth of the antenna in degrees, defining the angular coverage in the elevation plane. Affects coverage distance and shape.',
    `clutter_type` STRING COMMENT 'The predominant terrain clutter classification within the coverage footprint. Affects propagation loss and coverage prediction accuracy.. Valid values are `urban|suburban|rural|dense_urban|open`',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'The statistical confidence level of the coverage prediction as a percentage (0-100). Higher values indicate greater certainty in the footprint accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage footprint record was first created in the system. Supports audit trail and data lineage.',
    `data_source` STRING COMMENT 'The source system or tool that generated this coverage footprint record (e.g., Nokia NetAct, Ericsson Network Manager, Atoll propagation tool).',
    `effective_date` DATE COMMENT 'The date from which this coverage footprint becomes active and valid for network planning and service delivery decisions.',
    `expiry_date` DATE COMMENT 'The date on which this coverage footprint is no longer valid, typically due to network configuration changes or updated measurements. Null indicates indefinite validity.',
    `footprint_code` STRING COMMENT 'Business identifier for the coverage footprint, typically combining cell identifier, technology, and band for human-readable reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `footprint_status` STRING COMMENT 'The current lifecycle status of this coverage footprint record. Active footprints are used for operational planning and customer-facing coverage maps.. Valid values are `active|inactive|planned|deprecated`',
    `frequency_band` STRING COMMENT 'The frequency band on which this cell sector operates. Determines propagation characteristics, coverage range, and capacity. [ENUM-REF-CANDIDATE: 700MHz|850MHz|1800MHz|2100MHz|2600MHz|3500MHz|26GHz — 7 candidates stripped; promote to reference product]',
    `generation_method` STRING COMMENT 'The methodology used to generate this coverage footprint: propagation_model (theoretical prediction), drive_test (field measurement), or crowdsourced_rf (aggregated device measurements).. Valid values are `propagation_model|drive_test|crowdsourced_rf`',
    `geometry_wkt` STRING COMMENT 'The spatial polygon representing the predicted or measured coverage boundary in Well-Known Text format. Used for GIS analysis and coverage visualization.',
    `indoor_penetration_depth_db` DECIMAL(18,2) COMMENT 'The estimated signal penetration loss in decibels for indoor environments within the coverage footprint. Used to assess indoor coverage quality.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage footprint record was last updated. Enables change tracking and data quality monitoring.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'The timestamp when this coverage footprint was last verified or validated through field measurements or updated propagation modeling.',
    `measurement_sample_count` STRING COMMENT 'The number of RF measurement samples used to generate or validate this coverage footprint. Applicable for drive_test and crowdsourced_rf generation methods.',
    `notes` STRING COMMENT 'Free-text field for additional context, exceptions, or special considerations related to this coverage footprint.',
    `outdoor_coverage_area_sq_km` DECIMAL(18,2) COMMENT 'The total outdoor geographic area covered by this cell sector in square kilometers, calculated from the coverage polygon.',
    `population_covered` STRING COMMENT 'The estimated population count within the coverage footprint boundary. Used for network capacity planning and market analysis.',
    `predicted_rsrp_dbm` DECIMAL(18,2) COMMENT 'The predicted average Reference Signal Received Power at the coverage boundary in dBm. Key metric for LTE and 5G coverage quality assessment.',
    `predicted_sinr_db` DECIMAL(18,2) COMMENT 'The predicted Signal-to-Interference-plus-Noise Ratio at the coverage boundary in dB. Indicates expected data throughput and service quality.',
    `propagation_model_version` STRING COMMENT 'The version identifier of the propagation model or measurement methodology used to generate this footprint. Enables traceability and model comparison.',
    `technology_type` STRING COMMENT 'The radio access technology generation for this coverage footprint. Determines the air interface standard and capabilities.. Valid values are `2G|3G|4G|5G_NSA|5G_SA`',
    `tilt_degrees` DECIMAL(18,2) COMMENT 'The vertical tilt angle of the antenna in degrees. Negative values indicate downtilt. Affects coverage shape and interference footprint.',
    `transmit_power_dbm` DECIMAL(18,2) COMMENT 'The configured transmit power of the cell sector in dBm. Directly impacts coverage range and signal strength at the cell edge.',
    CONSTRAINT pk_cell_coverage_footprint PRIMARY KEY(`cell_coverage_footprint_id`)
) COMMENT 'Master record for the predicted and measured radio coverage footprint of an individual RAN cell sector — the spatial representation of a single cells coverage at a specific technology, band, and configuration. Captures footprint identifier, cell reference (links to network.ran_cell), technology (2G, 3G, 4G, 5G_NSA, 5G_SA), frequency band (700MHz, 850MHz, 1800MHz, 2100MHz, 2600MHz, 3500MHz, 26GHz), azimuth, tilt, antenna height, geometry (polygon WKT), outdoor coverage area (sq km), indoor penetration depth, predicted RSRP (dBm), predicted SINR (dB), generation method (propagation_model, drive_test, crowdsourced_RF), model version, effective date, and expiry date. Distinct from coverage_area which represents aggregated technology-level coverage — this is cell-sector-level spatial data.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`duct_route` (
    `duct_route_id` BIGINT COMMENT 'Unique identifier for the underground duct and conduit route segment in the outside plant (OSP) civil infrastructure.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this duct route record, used for audit trail and data governance.',
    `geo_point_id` BIGINT COMMENT 'Reference to the geographic point entity representing the starting endpoint of the duct route.',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory within which this duct route is located, used for operational planning and resource allocation.',
    `continuation_duct_route_id` BIGINT COMMENT 'Self-referencing FK on duct_route (continuation_duct_route_id)',
    `asset_condition` STRING COMMENT 'Current physical condition assessment of the duct route infrastructure based on inspection findings, used for maintenance prioritization and capital planning.. Valid values are `excellent|good|fair|poor|critical`',
    `available_subduct_count` STRING COMMENT 'Number of sub-ducts currently available for future cable installations, critical for capacity planning and network expansion.',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of total duct capacity currently in use, calculated from occupied versus total sub-ducts, used for capacity planning and investment decisions.',
    `construction_method` STRING COMMENT 'Installation technique used to construct the duct route, affecting cost, disruption, and suitability for different terrain types.. Valid values are `open_trench|directional_drill|plowing|boring|microtrenching`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this duct route record was first created in the system.',
    `depth_metres` DECIMAL(18,2) COMMENT 'Average burial depth of the underground duct route measured in metres from ground surface, relevant for excavation safety and damage prevention.',
    `duct_diameter_mm` STRING COMMENT 'Internal diameter of the primary duct measured in millimetres, determining cable capacity and pull tension limits.',
    `duct_material` STRING COMMENT 'Primary construction material of the duct or conduit, affecting durability, installation method, and maintenance requirements.. Valid values are `HDPE|PVC|concrete|steel|fiberglass|asbestos_cement`',
    `environmental_zone` STRING COMMENT 'Classification of the environmental conditions along the route (e.g., flood zone, seismic zone, corrosive soil), affecting design specifications and maintenance requirements.',
    `external_system_code` STRING COMMENT 'Identifier used for this duct route in external systems such as network management systems (NMS), element management systems (EMS), or outside plant management systems.',
    `geometry_wkt` STRING COMMENT 'Spatial representation of the duct route as a linestring in Well-Known Text format, capturing the precise geographic path of the underground conduit.',
    `gis_layer_reference` STRING COMMENT 'Reference to the GIS layer or feature class where this duct route is represented in the enterprise spatial data system.',
    `installation_date` DATE COMMENT 'Date when the duct route was originally installed and commissioned for use in the outside plant network.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or condition assessment of the duct route, used for maintenance planning and asset lifecycle management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this duct route record was most recently updated in the system.',
    `maintenance_responsibility` STRING COMMENT 'Identifier of the team, contractor, or organizational unit responsible for maintaining this duct route.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory inspection of the duct route based on regulatory requirements or maintenance policies.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, historical context, or operational notes about the duct route.',
    `number_of_subducts` STRING COMMENT 'Total count of individual sub-ducts or inner ducts within the primary duct structure, each capable of housing separate cable runs.',
    `occupied_subduct_count` STRING COMMENT 'Number of sub-ducts currently occupied by installed cables or other telecommunications infrastructure.',
    `ownership_type` STRING COMMENT 'Legal ownership or usage rights model for the duct route infrastructure. IRU = Indefeasible Right of Use, a long-term lease arrangement common in telecommunications.. Valid values are `owned|leased|IRU|joint_use|municipal`',
    `permit_reference` STRING COMMENT 'Reference number or identifier of the construction permit, excavation permit, or right-of-way permit authorizing the installation and maintenance of the duct route.',
    `replacement_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to replace the entire duct route with equivalent infrastructure, used for asset valuation and insurance purposes.',
    `road_authority_reference` STRING COMMENT 'Identifier or name of the governmental road authority or public works department with jurisdiction over the right-of-way where the duct route is installed.',
    `route_code` STRING COMMENT 'Externally-known unique business identifier for the duct route, used in network planning documentation, permit applications, and field operations.. Valid values are `^[A-Z0-9]{6,20}$`',
    `route_name` STRING COMMENT 'Human-readable name or designation of the duct route, typically referencing street names, landmarks, or geographic endpoints (e.g., Main St to Oak Ave Underground).',
    `route_priority` STRING COMMENT 'Business priority classification of the duct route based on the criticality of services it supports, used for maintenance scheduling and emergency response.. Valid values are `critical|high|medium|low`',
    `route_status` STRING COMMENT 'Current lifecycle state of the duct route in the outside plant infrastructure network.. Valid values are `active|planned|under_construction|decommissioned|damaged|maintenance`',
    `route_type` STRING COMMENT 'Classification of the physical pathway method used for the telecommunications infrastructure route.. Valid values are `underground_duct|aerial_span|submarine|direct_buried|building_riser|hybrid`',
    `total_length_metres` DECIMAL(18,2) COMMENT 'Total physical length of the duct route measured in metres, used for capacity planning, cost estimation, and network design.',
    `traffic_impact_level` STRING COMMENT 'Assessment of the impact on vehicular or pedestrian traffic if maintenance or repair work is required on this route, used for work scheduling and permit coordination.. Valid values are `none|low|medium|high|critical`',
    CONSTRAINT pk_duct_route PRIMARY KEY(`duct_route_id`)
) COMMENT 'Master record for underground duct and conduit route segments in the outside plant (OSP) civil infrastructure — the physical pathways through which fiber cables, copper cables, and other telecommunications infrastructure are routed. Captures duct route identifier, route name, route type (underground_duct, aerial_span, submarine, direct_buried, building_riser), geometry (linestring WKT), total length (metres), duct material (HDPE, PVC, concrete, steel), duct diameter (mm), number of sub-ducts, occupied sub-duct count, available sub-duct count, route status (active, planned, decommissioned, damaged), ownership (owned, leased, IRU), road authority reference, permit reference, installation date, and last inspection date. Provides the civil infrastructure layer for fiber route planning and capacity management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`address_alias` (
    `address_alias_id` BIGINT COMMENT 'Unique identifier for the address alias association record. Primary key for the address alias entity.',
    `location_address_id` BIGINT COMMENT 'Reference to the master address record in the address master data product. This is the single source of truth address that all aliases map to.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that verified or approved this alias association. Used for accountability and audit purposes in manual verification workflows.',
    `canonical_address_alias_id` BIGINT COMMENT 'Self-referencing FK on address_alias (canonical_address_alias_id)',
    `address_format_standard` STRING COMMENT 'Name of the address formatting standard or specification that the alias value conforms to. Examples: AS4590 (Australia), BS7666 (UK), USPS Publication 28 (USA), Universal Postal Union S42, proprietary legacy format names. Used for format conversion and standardization logic.',
    `alias_identifier` STRING COMMENT 'The alternative identifier or code used to reference the address in source systems. May be a legacy system key, external reference code, or alternate naming convention.',
    `alias_type` STRING COMMENT 'Classification of the alias relationship. Indicates the nature and source of the alternative address representation. Types include: legacy_system (address format from retired OSS/BSS), postal_alias (alternate postal service identifier), informal_name (colloquial or common name), building_alias (building-specific identifier), dpid (Delivery Point Identifier - Australia Post), gnaf_pid (Geocoded National Address File Persistent Identifier - Australia), uprn (Unique Property Reference Number - UK), gnaf_address_detail_pid (G-NAF Address Detail PID - Australia), exchange_code_address (telephone exchange-based address code), ntd_location_id (National Telecommunications Database Location ID), geocode_alias (geocoding service identifier), service_address_id (service provisioning system address), billing_address_id (billing system address reference), installation_address_id (field installation system address). [ENUM-REF-CANDIDATE: legacy_system|postal_alias|informal_name|building_alias|dpid|gnaf_pid|uprn|gnaf_address_detail_pid|exchange_code_address|ntd_location_id|geocode_alias|service_address_id|billing_address_id|installation_address_id — 14 candidates stripped; promote to reference product]',
    `alias_value` DECIMAL(18,2) COMMENT 'The actual alternative address representation, identifier, or name. This is the value used in the source system or alternate format. May be a formatted address string, a code, or a reference number.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 100.00) representing the confidence level in the alias-to-canonical address match. Higher scores indicate stronger matching certainty. Scores below threshold may require manual review. Used in probabilistic address matching and deduplication processes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this address alias record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality score (0.00 to 100.00) for this alias record, based on completeness, accuracy, consistency, and timeliness dimensions. Used to prioritize data quality improvement efforts and filter low-quality aliases from critical processes.',
    `deduplication_group_code` STRING COMMENT 'Identifier linking this alias to a group of related aliases that were identified as duplicates during address deduplication processes. All aliases in the same group map to the same canonical address.',
    `deprecation_reason` STRING COMMENT 'Explanation for why this alias was deprecated or marked for retirement. Examples: system migration completed, address standardization project, duplicate alias identified, source system decommissioned. Populated when verification_status is deprecated or expired.',
    `effective_date` DATE COMMENT 'Date from which this alias association is valid and active. Used for temporal tracking of address alias relationships, especially during system migrations or address standardization initiatives.',
    `expiry_date` DATE COMMENT 'Date after which this alias association is no longer valid. Null indicates an open-ended, currently active alias. Used to retire legacy address references after system migrations complete.',
    `external_reference_code` STRING COMMENT 'External system or partner reference identifier associated with this alias. Used for cross-system reconciliation with third-party address databases, geocoding services, or partner systems.',
    `geographic_accuracy_level` STRING COMMENT 'Precision level of the geographic match between the alias and canonical address. Values: rooftop (exact building location), parcel (property boundary), street_segment (street address range), postal_code (postal code centroid), locality (city/suburb level), region (state/province level), country (country level), unknown (accuracy not determined). Critical for network planning and service delivery applications. [ENUM-REF-CANDIDATE: rooftop|parcel|street_segment|postal_code|locality|region|country|unknown — 8 candidates stripped; promote to reference product]',
    `is_primary_alias` BOOLEAN COMMENT 'Indicates whether this is the primary or preferred alias for the canonical address. True for the most commonly used or authoritative alias representation. Used to determine default display values in user interfaces.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the regulatory or administrative jurisdiction that governs this alias. Used for compliance with regional address data regulations and for routing to appropriate regional address validation services.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language of the alias value. Relevant for multilingual address representations in regions with multiple official languages or for international operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this address alias record was last updated. Used for change tracking and to identify recently modified alias associations that may require review.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time when this alias was last referenced in an operational transaction or system query. Used to identify dormant aliases that may be candidates for archival.',
    `match_method` STRING COMMENT 'Method or algorithm used to establish the alias-to-canonical address association. Values: exact_match (direct identifier match), fuzzy_match (probabilistic string matching), geocode_match (coordinate-based matching), manual_verification (human-reviewed match), rule_based (business rule engine), ml_model (machine learning model prediction), postal_authority (validated by postal service), third_party_service (external address validation service). [ENUM-REF-CANDIDATE: exact_match|fuzzy_match|geocode_match|manual_verification|rule_based|ml_model|postal_authority|third_party_service — 8 candidates stripped; promote to reference product]',
    `match_timestamp` TIMESTAMP COMMENT 'Date and time when the alias association was established or last verified. Critical for audit trail and understanding the recency of address matching processes.',
    `migration_batch_code` STRING COMMENT 'Identifier of the data migration or address standardization batch that created this alias association. Used to track and manage large-scale address consolidation projects during OSS/BSS system migrations.',
    `notes` STRING COMMENT 'Free-text field for additional context, special handling instructions, or explanatory comments about the alias association. May include information about known data quality issues, special matching rules applied, or business context for the alias.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this alias is a high-priority reference that must be maintained for critical business operations or regulatory compliance. True for aliases used in active service provisioning, billing, or regulatory reporting.',
    `reconciliation_status` STRING COMMENT 'Status of the alias in cross-system reconciliation processes. Values: reconciled (successfully matched across systems), pending (awaiting reconciliation), conflict (conflicting matches found), orphaned (alias exists but canonical address not found), duplicate (multiple aliases with same value detected).. Valid values are `reconciled|pending|conflict|orphaned|duplicate`',
    `source_system_code` STRING COMMENT 'Standardized code or abbreviation for the source system. Used for programmatic identification and integration mapping. Examples: AMDOCS_RM, SFDC_CRM, LEGACY_BSS, ORACLE_OSM, NETCRACKER.',
    `source_system_name` STRING COMMENT 'Name of the operational system or data source that uses this alias. Examples include legacy OSS/BSS system names (e.g., Amdocs CRM v8, Siebel CRM, legacy billing system), external geocoding services, postal authorities, or partner systems. Critical for cross-system reconciliation and data lineage.',
    `usage_count` STRING COMMENT 'Number of times this alias has been referenced or used in operational transactions. Higher usage counts indicate more critical aliases that require careful management during address standardization initiatives.',
    `verification_date` DATE COMMENT 'Date when the alias association was last verified or validated. Used to track the recency of verification and trigger re-verification workflows for aging aliases.',
    `verification_status` STRING COMMENT 'Current verification state of the alias association. Values: verified (confirmed accurate match), pending_review (awaiting manual validation), rejected (determined to be incorrect match), auto_matched (system-generated, not yet verified), manually_confirmed (human-validated), expired (past expiry date), deprecated (superseded by newer alias). [ENUM-REF-CANDIDATE: verified|pending_review|rejected|auto_matched|manually_confirmed|expired|deprecated — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_address_alias PRIMARY KEY(`address_alias_id`)
) COMMENT 'Association record linking alternative address representations, legacy address formats, and alias identifiers to the canonical address master record — enabling address matching across multiple source systems that may use different address formats, abbreviations, or legacy codes. Captures alias identifier, canonical address reference, alias type (legacy_system, postal_alias, informal_name, building_alias, DPID, GNAF_PID, UPRN, G-NAF_address_detail_pid, exchange_code_address, NTD_location_id), alias value, source system name, effective date, expiry date, and confidence score. Critical for address deduplication, cross-system reconciliation, and migration from legacy OSS/BSS systems.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`geographic_zone` (
    `geographic_zone_id` BIGINT COMMENT 'Unique identifier for the operator-defined geographic zone. Primary key for the geographic zone master reference.',
    `parent_zone_geographic_zone_id` BIGINT COMMENT 'Foreign key reference to the parent geographic zone in a hierarchical zone structure. Enables multi-level zone aggregation (e.g., sub-zones rolling up to regional zones). Nullable for top-level zones.',
    `service_territory_id` BIGINT COMMENT 'Foreign key reference to the service territory that encompasses or overlaps with this geographic zone. Used to link pricing zones to operational territories for workforce dispatch and service delivery coordination.',
    `parent_geographic_zone_id` BIGINT COMMENT 'Self-referencing FK on geographic_zone (parent_geographic_zone_id)',
    `applicable_product_types` STRING COMMENT 'Comma-separated list of product or service types to which this zone applies (e.g., broadband, mobile, IPTV, VoIP). Used by product catalog and pricing engines to determine zone-based eligibility and tariff application.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total surface area of the geographic zone measured in square kilometers. Used for network planning density calculations, coverage analysis, and Universal Service Obligation (USO) reporting.',
    `average_income_level` STRING COMMENT 'Socioeconomic classification of the geographic zone based on average household income. Used for market segmentation, product targeting, Customer Lifetime Value (CLTV) modeling, and affordability-based pricing strategies.. Valid values are `high|medium_high|medium|medium_low|low`',
    `black_spot_programme_flag` BOOLEAN COMMENT 'Indicates whether this geographic zone is designated as a mobile coverage black spot eligible for government-funded infrastructure programmes. True if the zone qualifies for black spot funding; false otherwise. Used for Capital Expenditure (CAPEX) planning and regulatory reporting.',
    `business_premises_count` BIGINT COMMENT 'Estimated number of commercial and business premises within the geographic zone. Used for enterprise service planning, Business-to-Business (B2B) market sizing, and Software-Defined Wide Area Network (SD-WAN) opportunity assessment.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic center (centroid) of the zone in decimal degrees. Used for distance calculations, map rendering, and proximity-based routing. Range: -90.0000000 to +90.0000000.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic center (centroid) of the zone in decimal degrees. Used for distance calculations, map rendering, and proximity-based routing. Range: -180.0000000 to +180.0000000.',
    `competitive_intensity` STRING COMMENT 'Assessment of competitive pressure within this geographic zone. High-intensity zones have multiple operators and aggressive pricing; monopoly zones have single-provider dominance. Used for churn risk modeling, pricing strategy, and market share analysis.. Valid values are `high|medium|low|monopoly`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic zone record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_source` STRING COMMENT 'System or process that created or last updated this geographic zone record (e.g., GIS system, network planning tool, regulatory filing). Used for data lineage tracking and reconciliation.',
    `dispatch_radius_km` DECIMAL(18,2) COMMENT 'Maximum distance in kilometers from the nearest service depot or Point of Presence (POP) for field technician dispatch to this geographic zone. Used by Workforce Management (WFM) systems for route optimization and Mean Time to Repair (MTTR) estimation.',
    `effective_date` DATE COMMENT 'Date from which this geographic zone definition becomes active and applicable for pricing, routing, and regulatory classification. Used for temporal queries and historical analysis.',
    `emergency_services_routing_code` STRING COMMENT 'Code used to route emergency calls (E911/E112) to the appropriate Public Safety Answering Point (PSAP) for this geographic zone. Critical for Voice over Long-Term Evolution (VoLTE) and IP Multimedia Subsystem (IMS) emergency call handling.. Valid values are `^[A-Z0-9]{2,10}$`',
    `expiry_date` DATE COMMENT 'Date on which this geographic zone definition ceases to be active. Nullable for zones with indefinite validity. Used for temporal queries, historical analysis, and zone lifecycle management.',
    `franchise_agreement_reference` STRING COMMENT 'Reference identifier for the franchise or operating license agreement that grants the operator rights to provide services within this geographic zone. Used for regulatory compliance tracking and contract management.',
    `geometry_wkt` STRING COMMENT 'Spatial boundary of the geographic zone represented as a Well-Known Text (WKT) polygon or multipolygon. Used for geospatial queries, coverage analysis, and GIS integration. Conforms to ISO 19125 (Simple Features) standard.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this zone within the geographic zone hierarchy. Level 1 represents top-level zones (e.g., national); higher numbers represent nested sub-zones (e.g., regional, local). Used for hierarchical rollup queries and reporting.',
    `household_count` BIGINT COMMENT 'Estimated number of households within the geographic zone. Used for Fiber to the Home (FTTH) rollout planning, broadband penetration analysis, and addressable market calculations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic zone record was last updated. Used for audit trail, change tracking, and data synchronization across systems.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the geographic zone boundaries and attributes were last verified or updated by network planning or GIS teams. Used for data quality monitoring and zone refresh scheduling.',
    `network_coverage_type` STRING COMMENT 'Predominant network technology available within this geographic zone. Used for service eligibility determination, product catalog filtering, and network modernization planning. 5G = 5G New Radio; LTE = Long-Term Evolution; FTTH = Fiber to the Home; FTTC = Fiber to the Cabinet; DSL = Digital Subscriber Line. [ENUM-REF-CANDIDATE: 5G|LTE|3G|2G|FTTH|FTTC|DSL|satellite|no_coverage — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this geographic zone (e.g., pending boundary changes, regulatory disputes, infrastructure constraints).',
    `population_estimate` BIGINT COMMENT 'Estimated total population residing within the geographic zone boundaries. Used for market sizing, network capacity planning, Average Revenue Per User (ARPU) projections, and Universal Service Obligation (USO) eligibility determination.',
    `pricing_model` STRING COMMENT 'Pricing methodology applied to services within this geographic zone. Flat-rate zones have uniform pricing; distance-based zones charge by proximity to exchange; tier-based zones use zone-tier multipliers; usage-based zones charge per consumption; hybrid zones combine multiple models. Used by rating engines and product catalog.. Valid values are `flat_rate|distance_based|tier_based|usage_based|hybrid`',
    `qos_class` STRING COMMENT 'Default Quality of Service (QoS) class assigned to services within this geographic zone. Premium zones receive highest priority for traffic management and fault resolution; best-effort zones have no guaranteed service levels. Used by Policy Control Function (PCF) and Broadband Network Gateway (BNG) for traffic shaping.. Valid values are `premium|standard|basic|best_effort`',
    `regulatory_body_reference` STRING COMMENT 'Identifier or name of the regulatory authority that governs this zone (e.g., FCC, Ofcom, BEREC). Used for compliance reporting, spectrum licensing, and Universal Service Obligation (USO) tracking.',
    `roaming_enabled_flag` BOOLEAN COMMENT 'Indicates whether roaming services are enabled within this geographic zone. True if the zone is part of a roaming agreement with Mobile Virtual Network Operators (MVNOs) or international carriers; false otherwise. Used by Home Location Register (HLR) and Home Subscriber Server (HSS) for roaming authorization.',
    `sla_response_time_minutes` STRING COMMENT 'Target response time in minutes for fault resolution and service restoration within this geographic zone, as defined in Service Level Agreements (SLAs). Metro zones typically have shorter response times (e.g., 4 hours) than remote zones (e.g., 48 hours). Used by Network Operations Center (NOC) and Workforce Management (WFM) systems.',
    `spectrum_license_reference` STRING COMMENT 'Reference identifier for the spectrum license or frequency allocation applicable to this geographic zone. Used for Radio Access Network (RAN) planning, 5G New Radio (5G NR) deployment, and regulatory compliance tracking.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the geographic zone (e.g., America/New_York, Europe/London). Used for scheduling maintenance windows, Call Detail Record (CDR) timestamp normalization, and customer communication timing.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `uso_eligible_flag` BOOLEAN COMMENT 'Indicates whether this geographic zone qualifies for Universal Service Obligation (USO) funding or subsidies. True for underserved rural or remote areas; false for commercially viable zones. Used for regulatory reporting and Capital Expenditure (CAPEX) planning.',
    `version_number` STRING COMMENT 'Sequential version number incremented with each modification to the geographic zone record. Used for optimistic locking, change history tracking, and temporal queries.',
    `zone_code` STRING COMMENT 'Unique business identifier code for the geographic zone used in operational systems, pricing engines, and regulatory reporting. Typically alphanumeric with operator-specific format.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `zone_name` STRING COMMENT 'Human-readable name of the geographic zone for display in customer-facing applications, billing systems, and operational dashboards.',
    `zone_status` STRING COMMENT 'Current lifecycle status of the geographic zone. Active zones are in operational use; pending zones are approved but not yet effective; planned zones are under design; deprecated zones are phased out but retained for historical reference; suspended zones are temporarily disabled; inactive zones are permanently retired.. Valid values are `active|inactive|pending|deprecated|suspended|planned`',
    `zone_tier` STRING COMMENT 'Hierarchical classification of the zone for pricing differentiation and service level stratification. Metro zones typically have premium pricing and highest service levels; remote zones may qualify for Universal Service Obligation (USO) subsidies and have extended SLA (Service Level Agreement) response times.. Valid values are `metro|regional|rural|remote|urban|suburban`',
    `zone_type` STRING COMMENT 'Classification of the geographic zone by its primary business purpose. Pricing zones drive differential tariffs; regulatory zones align with compliance boundaries; roaming zones define partner network areas; emergency services zones map to E911/E112 routing; disaster recovery zones support business continuity; spectrum zones track licensed frequency allocations. [ENUM-REF-CANDIDATE: pricing_zone|regulatory_zone|roaming_zone|emergency_services_zone|disaster_recovery_zone|spectrum_zone|universal_service_zone|black_spot_zone — promote to reference product]. Valid values are `pricing_zone|regulatory_zone|roaming_zone|emergency_services_zone|disaster_recovery_zone|spectrum_zone`',
    CONSTRAINT pk_geographic_zone PRIMARY KEY(`geographic_zone_id`)
) COMMENT 'Reference master for operator-defined geographic zones used in pricing, product eligibility, regulatory classification, and operational routing — distinct from administrative regions which follow government boundaries. Captures zone identifier, zone name, zone code, zone type (pricing_zone, regulatory_zone, roaming_zone, emergency_services_zone, disaster_recovery_zone, spectrum_zone, universal_service_zone, black_spot_zone), geometry (polygon WKT), zone tier (e.g., metro, regional, rural, remote for pricing differentiation), applicable product or service types, regulatory body reference, effective date, expiry date, and zone status. Drives differential pricing for regional/rural broadband, USO obligations, and black spot programme eligibility.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`change_event` (
    `change_event_id` BIGINT COMMENT 'Unique identifier for each location master data change event. Primary key for the location change event audit trail.',
    `employee_id` BIGINT COMMENT 'The user identifier of the data steward or authorized personnel who approved or rejected the location data change. Null for pending or auto-approved changes. Required for governance and compliance audit trails.',
    `primary_change_employee_id` BIGINT COMMENT 'The user identifier or system account that executed the location data change. Captures human operator for manual changes or system service account for automated changes. Required for audit trail and accountability.',
    `rollback_reference_event_id` BIGINT COMMENT 'The location_change_event_id of the original change event that is being rolled back or reversed by this change. Null for non-rollback changes. Enables traceability of correction chains.',
    `reversal_change_event_id` BIGINT COMMENT 'Self-referencing FK on change_event (reversal_change_event_id)',
    `approval_status` STRING COMMENT 'The current approval state of the location data change within the data governance workflow. Indicates whether the change requires review, has been approved, was rejected, or was automatically approved based on business rules.. Valid values are `pending|approved|rejected|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the location data change was approved or rejected by the designated approver. Null for pending or auto-approved changes. Tracks governance workflow completion time.',
    `change_category` STRING COMMENT 'High-level business classification of the change event for reporting and analytics. Examples include data quality correction, network expansion, regulatory compliance update, customer-driven change, or operational optimization.',
    `change_notes` STRING COMMENT 'Free-text notes or comments provided by the operator or system regarding the location data change. Captures additional context, justification, or special handling instructions not covered by structured fields.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason or trigger for the location data change. Examples include address correction, coverage expansion, site decommission, regulatory boundary update, or data quality remediation.',
    `change_source` STRING COMMENT 'The origin or mechanism that initiated the location data change. Distinguishes between automated system processes, manual operator corrections, field survey updates, authoritative source updates, and bulk data imports.. Valid values are `system_automated|manual_correction|survey_update|authority_update|bulk_import`',
    `change_timestamp` TIMESTAMP COMMENT 'The precise date and time when the location data change was committed to the master data repository. Represents the business event time of the modification in ISO 8601 format with timezone.',
    `change_type` STRING COMMENT 'The category of change operation performed on the location entity. Distinguishes between lifecycle events such as initial creation, attribute updates, decommissioning, entity merges, splits, and reclassifications.. Valid values are `create|update|decommission|merge|split|reclassify`',
    `changed_field_name` STRING COMMENT 'The specific attribute or field name within the location entity that was modified. Captures the column-level granularity of the change for precise audit trail tracking.',
    `compliance_framework` STRING COMMENT 'The specific regulatory or compliance framework that governs this location data change. Examples include FCC Universal Service requirements, GDPR data accuracy obligations, or national telecommunications licensing conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this change event record was first inserted into the location change event audit table. Represents the technical record creation time, distinct from the business change_timestamp.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated data quality assessment score for the location data change, ranging from 0.00 to 100.00. Evaluates completeness, accuracy, consistency, and conformance to business rules. Higher scores indicate higher confidence in data quality.',
    `effective_date` DATE COMMENT 'The business-effective date when the location data change becomes active and should be applied in operational systems and reporting. May differ from change_timestamp for scheduled or backdated changes.',
    `expiry_date` DATE COMMENT 'The business-effective date when the location data change is no longer valid and should be superseded by subsequent changes. Null for current active changes. Supports temporal data management and historical analysis.',
    `geocoding_confidence` DECIMAL(18,2) COMMENT 'Confidence level percentage for geocoded location coordinates when the change involves address or geographic data. Ranges from 0.00 to 100.00. Null for non-geographic changes. Indicates reliability of latitude/longitude assignments.',
    `impact_scope` STRING COMMENT 'Assessment of the business impact magnitude of the location data change. Considers factors such as number of affected customers, service availability implications, network planning dependencies, and regulatory reporting requirements.. Valid values are `low|medium|high|critical`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this change event record was last updated in the audit table. Tracks modifications to approval status, validation results, or other mutable fields after initial event capture.',
    `location_entity_reference` BIGINT COMMENT 'The unique identifier of the specific location entity record that was modified. References the primary key of the corresponding location master table based on location_entity_type.',
    `location_entity_type` STRING COMMENT 'The type of location entity that was changed. Categorizes the master data record type within the location domain hierarchy.. Valid values are `address|premise|site|coverage_area|geo_boundary|exchange`',
    `new_value` DECIMAL(18,2) COMMENT 'The updated value of the changed field after the modification was applied. Stored as string representation to accommodate all data types. Null for decommission operations.',
    `old_value` DECIMAL(18,2) COMMENT 'The previous value of the changed field before the modification was applied. Stored as string representation to accommodate all data types. Null for create operations.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this location data change must be included in regulatory compliance reporting to governing bodies such as FCC, ITU, or national telecommunications authorities. True for changes affecting coverage obligations, service territories, or franchise boundaries.',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this change event represents a rollback or reversal of a previous location data modification. True when the change undoes a prior change due to error correction or business decision reversal.',
    `source_system_code` STRING COMMENT 'The code or identifier of the operational system that originated the location data change. Examples include GIS platforms, OSS/BSS systems, CRM, field workforce management, or external authoritative sources like postal authorities.',
    `transaction_code` STRING COMMENT 'The unique transaction or batch identifier from the source system that generated this change event. Enables correlation of multiple related changes within a single business transaction or bulk update operation.',
    `validation_error_message` STRING COMMENT 'Detailed error or warning message generated by data quality validation rules when the location data change failed validation checks. Provides diagnostic information for data stewards to remediate quality issues.',
    `validation_status` STRING COMMENT 'The outcome of automated data quality validation rules applied to the location data change. Indicates whether the change passed all validation checks, failed critical rules, generated warnings, or was not subject to validation.. Valid values are `passed|failed|warning|not_validated`',
    CONSTRAINT pk_change_event PRIMARY KEY(`change_event_id`)
) COMMENT 'Transactional record capturing every change to a location master record — address corrections, premise reclassifications, site status changes, coverage area updates, and boundary revisions. Captures event identifier, location entity type (address, premise, site, coverage_area, geo_boundary, exchange), location entity reference, change type (create, update, decommission, merge, split, reclassify), changed field name, old value, new value, change reason code, change source (system_automated, manual_correction, survey_update, authority_update, bulk_import), operator or system that made the change, change timestamp, approval status, and approver reference. Provides the immutable audit trail for all location master data changes required for data governance and regulatory compliance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`black_spot` (
    `black_spot_id` BIGINT COMMENT 'Unique identifier for the telecommunications black spot location record. Primary key for the black spot master data entity.',
    `administrative_region_id` BIGINT COMMENT 'Reference to the administrative region (state, province, county, municipality) in which the black spot is located. Used for regulatory reporting, government programme alignment, and jurisdictional compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this black spot record. Used for audit trail and accountability.',
    `location_site_id` BIGINT COMMENT 'Reference to the nearest location or network site that currently has adequate telecommunications service. Used for network extension planning, backhaul routing, and cost estimation for black spot remediation.',
    `ran_cell_id` BIGINT COMMENT 'Foreign key linking to network.ran_cell. Business justification: Black spot remediation requires identifying nearest serving cell for coverage extension planning, signal propagation analysis, and universal service obligation compliance. Critical for government-fund',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory or operational region within which this black spot is located. Used for operational planning, resource allocation, and regional performance tracking.',
    `merged_into_black_spot_id` BIGINT COMMENT 'Self-referencing FK on black_spot (merged_into_black_spot_id)',
    `affected_population_estimate` STRING COMMENT 'Estimated number of individuals residing or working within the black spot area who are impacted by inadequate telecommunications coverage. Used for social equity analysis, government subsidy justification, and community impact assessment.',
    `affected_premises_count` STRING COMMENT 'Estimated number of residential and business premises within the black spot area that lack adequate telecommunications service. Used for programme prioritisation, funding allocation, and Universal Service Obligation (USO) compliance reporting.',
    `approval_date` DATE COMMENT 'Date when the black spot remediation project was formally approved for funding or inclusion in a network expansion programme. Used for project tracking and regulatory compliance reporting.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area of the black spot coverage deficiency zone measured in square kilometers. Used for network planning, infrastructure investment sizing, and regulatory reporting.',
    `black_spot_name` STRING COMMENT 'Human-readable name or label for the black spot location, typically referencing the geographic area, community, or landmark (e.g., Rural Valley Township, Highway 101 Corridor, Remote Island Settlement).',
    `black_spot_type` STRING COMMENT 'Classification of the type of telecommunications coverage deficiency at this location. Distinguishes between mobile network gaps (no coverage, poor signal), broadband service gaps (no service, underserved with inadequate speeds), and fixed-line unavailability.. Valid values are `mobile_no_coverage|mobile_poor_coverage|broadband_no_service|broadband_underserved|fixed_line_unavailable|mixed_deficiency`',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic centroid of the black spot area in decimal degrees (WGS84). Used for mapping, distance calculations, and proximity analysis.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic centroid of the black spot area in decimal degrees (WGS84). Used for mapping, distance calculations, and proximity analysis.',
    `community_petition_flag` BOOLEAN COMMENT 'Indicates whether this black spot was identified through a formal community petition or public consultation process. True if community-nominated, False otherwise.',
    `construction_start_date` DATE COMMENT 'Date when physical construction or network deployment activities commenced to remediate the black spot. Used for project management, milestone tracking, and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this black spot record was first created in the system. Used for data lineage, audit trail, and record lifecycle tracking.',
    `data_source_system` STRING COMMENT 'Name or identifier of the source system or data provider from which this black spot record was obtained (e.g., Nokia NetAct, Ericsson Network Manager, Government Black Spot Database, Community Petition Portal).',
    `distance_to_serviceable_location_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the black spot centroid to the nearest location with adequate telecommunications service. Used for infrastructure cost estimation, technology selection (fiber vs wireless), and programme feasibility assessment.',
    `economic_zone_classification` STRING COMMENT 'Economic classification of the black spot area (e.g., rural, remote, regional, indigenous community, agricultural zone, tourism area). Used for programme eligibility, funding prioritisation, and socio-economic impact analysis.',
    `environmental_constraints` STRING COMMENT 'Description of environmental or regulatory constraints that may impact black spot remediation (e.g., national park restrictions, heritage site limitations, protected wildlife habitat, indigenous land rights). Used for project planning and compliance management.',
    `external_reference_code` STRING COMMENT 'External system identifier or reference code for this black spot record in upstream or partner systems (e.g., government programme database ID, GIS system reference, regulatory filing number).',
    `funding_amount` DECIMAL(18,2) COMMENT 'Total funding amount allocated for remediation of this black spot location, including government subsidies, operator co-investment, and any third-party contributions. Expressed in local currency.',
    `funding_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funding amount (e.g., USD, GBP, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `geometry_wkt` STRING COMMENT 'Spatial geometry of the black spot area represented in Well-Known Text (WKT) format. May be a POINT for a specific location or a POLYGON for a broader coverage deficiency area. Used for GIS analysis, network planning, and regulatory mapping.',
    `identifier` STRING COMMENT 'External business identifier or reference code for the black spot location, used in government programmes, regulatory reporting, and inter-agency coordination. May be assigned by FCC, BDUK, ACMA, or internal network planning systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this black spot record was most recently updated. Used for change tracking, data currency validation, and audit trail.',
    `last_survey_date` DATE COMMENT 'Date when the most recent coverage survey or field measurement was conducted to verify the black spot status. Used for data currency validation and re-assessment scheduling.',
    `measured_download_speed_mbps` DECIMAL(18,2) COMMENT 'Measured broadband download speed at the black spot location in megabits per second (Mbps). Used to quantify the severity of broadband underservice and validate remediation outcomes.',
    `measured_signal_strength_dbm` DECIMAL(18,2) COMMENT 'Measured mobile network signal strength at the black spot location in dBm (decibel-milliwatts). Negative values indicate signal strength (e.g., -110 dBm is very weak, -70 dBm is strong). Used for coverage gap quantification and technology selection.',
    `measured_upload_speed_mbps` DECIMAL(18,2) COMMENT 'Measured broadband upload speed at the black spot location in megabits per second (Mbps). Used to assess service adequacy for applications requiring upstream bandwidth (video conferencing, cloud backup, telehealth).',
    `nomination_date` DATE COMMENT 'Date when the black spot location was formally nominated or identified for inclusion in a coverage improvement programme. Used for programme tracking, prioritisation, and regulatory reporting timelines.',
    `nomination_source` STRING COMMENT 'Origin or source of the black spot nomination. Indicates whether the coverage deficiency was identified by community petition, government agency, telecommunications operator internal planning, regulatory body, or third-party survey.. Valid values are `community|government|operator|regulator|third_party|internal_planning`',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about the black spot, including special circumstances, stakeholder feedback, technical challenges, or programme-specific information.',
    `priority_level` STRING COMMENT 'Priority classification for black spot remediation based on factors such as affected population, economic impact, safety considerations, and government programme requirements. Used for project sequencing and resource allocation.. Valid values are `critical|high|medium|low`',
    `programme_reference` STRING COMMENT 'Reference identifier or name of the government black spot programme, universal service obligation (USO) initiative, or subsidy scheme under which this location is registered (e.g., Mobile Black Spot Programme Round 5, FCC Connect America Fund Phase II, BDUK Gigabit Voucher Scheme).',
    `programme_status` STRING COMMENT 'Current lifecycle status of the black spot within the government or operator remediation programme. Tracks progression from nomination through approval, funding, construction, and resolution. [ENUM-REF-CANDIDATE: nominated|under_review|approved|funded|in_build|resolved|not_funded|deferred — 8 candidates stripped; promote to reference product]',
    `record_status` STRING COMMENT 'Current status of this black spot record in the master data repository. Indicates whether the record is active, archived (historical), superseded by a newer record, or marked for deletion.. Valid values are `active|archived|superseded|deleted`',
    `regulatory_jurisdiction` STRING COMMENT 'Name or code of the regulatory authority or jurisdiction responsible for telecommunications oversight in this black spot area (e.g., FCC, Ofcom, ACMA, CRTC). Used for compliance reporting and programme coordination.',
    `resolution_date` DATE COMMENT 'Date when the black spot was officially resolved and adequate telecommunications service was made available to the affected area. Marks completion of the remediation project.',
    `resolving_technology` STRING COMMENT 'Primary telecommunications technology deployed to remediate the black spot and provide adequate coverage (e.g., 5G New Radio (NR), Long-Term Evolution (LTE), Fiber to the Home (FTTH), fixed wireless access, satellite broadband). [ENUM-REF-CANDIDATE: 5G|LTE|FTTH|FTTC|fixed_wireless|satellite|microwave_backhaul|hybrid — 8 candidates stripped; promote to reference product]',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether the black spot is in a location where telecommunications coverage is critical for public safety, emergency services, or disaster response (e.g., remote highways, fire-prone areas, flood zones). True if safety-critical, False otherwise.',
    `survey_method` STRING COMMENT 'Method used to identify or verify the black spot coverage deficiency (e.g., drive test, walk test, crowdsourced data, RF propagation modeling, satellite imagery analysis, community reporting).. Valid values are `drive_test|walk_test|crowdsourced|propagation_model|satellite_imagery|community_report`',
    `target_service_level` STRING COMMENT 'Minimum service level or performance target that must be achieved to consider the black spot resolved (e.g., 25 Mbps download / 3 Mbps upload, -95 dBm outdoor signal strength, 99% availability). Used for Quality of Service (QoS) validation and regulatory compliance.',
    `terrain_type` STRING COMMENT 'Physical terrain classification of the black spot area. Influences technology selection, infrastructure cost, and signal propagation characteristics for remediation planning. [ENUM-REF-CANDIDATE: flat|hilly|mountainous|coastal|island|desert|forest|urban_canyon — 8 candidates stripped; promote to reference product]',
    `uso_obligation_flag` BOOLEAN COMMENT 'Indicates whether this black spot is subject to a Universal Service Obligation (USO) requirement, mandating the operator to provide service regardless of commercial viability. True if USO applies, False otherwise.',
    CONSTRAINT pk_black_spot PRIMARY KEY(`black_spot_id`)
) COMMENT 'Master record for identified mobile and broadband black spot locations — geographic areas with no or inadequate telecommunications coverage that are subject to government black spot programmes, universal service obligations (USO), or internal network expansion prioritisation. Captures black spot identifier, black spot name, black spot type (mobile_no_coverage, mobile_poor_coverage, broadband_no_service, broadband_underserved), geometry (point or polygon WKT), affected premises count, affected population estimate, nearest serviceable location, programme reference (Mobile Black Spot Programme, MBSP, FCC Connect America, BDUK), nomination source (community, government, operator), nomination date, programme status (nominated, approved, funded, in_build, resolved, not_funded), resolution date, and resolving technology. Supports regulatory reporting and government subsidy programme management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`address_geocode` (
    `address_geocode_id` BIGINT COMMENT 'Unique identifier for the address geocoding record. Primary key for the address geocode entity.',
    `location_address_id` BIGINT COMMENT 'Reference to the address master record that this geocode result applies to. Links to the authoritative address in the location_address product.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that performed the last verification of this geocode. May be an employee ID for manual verification or a system identifier for automated verification. Used for audit trail and quality accountability.',
    `superseded_address_geocode_id` BIGINT COMMENT 'Self-referencing FK on address_geocode (superseded_address_geocode_id)',
    `accuracy_level` STRING COMMENT 'Classification of the geocoding precision achieved. Rooftop is the most precise (exact building location), postcode_centroid is the least precise (center of postal code area). Critical for network planning and service delivery decisions.. Valid values are `rooftop|parcel_centroid|street_interpolated|street_centroid|suburb_centroid|postcode_centroid`',
    `census_block_reference` STRING COMMENT 'United States Census Bureau census block identifier. The smallest geographic unit used by the US Census Bureau, used for demographic analysis and regulatory reporting. Essential for FCC (Federal Communications Commission) reporting and Universal Service Fund compliance.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score assigned by the geocoding provider, typically expressed as a percentage (0.00 to 100.00). Higher scores indicate greater confidence in the accuracy of the geocoded location. Used to filter low-quality geocodes in network planning and service provisioning workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this geocode record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from geocoding_timestamp which represents when the geocoding operation was performed; created_timestamp represents when the record was persisted to the data product.',
    `crs_code` STRING COMMENT 'EPSG code identifying the coordinate reference system used for the latitude and longitude values. Default is EPSG:4326 (WGS84). Included to support scenarios where alternative coordinate systems are used for specialized network planning or regional requirements.',
    `data_source` STRING COMMENT 'Identifier of the source system or process that created this geocode record. Examples: address_validation_batch_20240115, salesforce_crm_integration, field_survey_team_3. Used for data lineage tracking and troubleshooting.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Elevation above mean sea level in meters. Used for network planning, signal propagation modeling, and terrain analysis. Nullable if elevation data is not available from the geocoding provider.',
    `exchange_code` STRING COMMENT 'Code identifying the telecommunications exchange serving this geocoded location. Derived from the geocoded coordinates by spatial proximity analysis. Critical for fixed-line service provisioning, FTTH planning, and wholesale access management.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems to reference this geocode record. Enables cross-system traceability and integration with third-party geocoding services, GIS (Geographic Information System) platforms, and network planning tools.',
    `geocode_identifier` STRING COMMENT 'External or provider-assigned unique identifier for this geocoding result. May be used for traceability back to the geocoding providers system.',
    `geocode_method` STRING COMMENT 'The method or provider used to obtain this geocoding result. GNAF_match refers to Australian Geocoded National Address File, USPS_match refers to United States Postal Service address matching. Enables comparison of geocoding quality across providers.. Valid values are `GNAF_match|USPS_match|HERE_API|Google_API|manual_survey|GPS_capture`',
    `geocode_quality_flag` STRING COMMENT 'Overall quality classification of the geocode result based on accuracy_level, confidence_score, and match_score. High quality geocodes are suitable for all use cases including FTTH (Fiber to the Home) planning. Low quality geocodes may require manual verification before use in service provisioning.. Valid values are `high|medium|low|unverified`',
    `geocode_status` STRING COMMENT 'Current lifecycle status of the geocode record. Active indicates the geocode is in use. Superseded indicates a newer geocode has replaced this one. Rejected indicates the geocode failed quality validation. Pending_review indicates the geocode is awaiting manual verification. Expired indicates the geocode is no longer valid due to address changes.. Valid values are `active|superseded|rejected|pending_review|expired`',
    `geocoding_provider` STRING COMMENT 'Name of the organization or service that provided the geocoding result. Examples: Google Maps Platform, HERE Technologies, Esri ArcGIS, internal survey team. Used for quality tracking and vendor performance analysis.',
    `geocoding_timestamp` TIMESTAMP COMMENT 'Date and time when the geocoding operation was performed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Enables tracking of geocoding currency and identification of stale geocodes that may need refresh.',
    `horizontal_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated horizontal accuracy of the geocoded coordinates in meters. Represents the radius of uncertainty around the reported latitude/longitude. Lower values indicate higher precision. Critical for FTTH (Fiber to the Home) planning and CPE (Customer Premises Equipment) installation.',
    `is_authoritative` BOOLEAN COMMENT 'Boolean flag indicating whether this geocode record is the authoritative, production-approved geocode for the address. True indicates this is the official geocode used for network planning, service delivery, and customer management. False indicates this is an alternative or historical geocode retained for comparison or audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this geocode record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Updated whenever any attribute of the geocode record changes. Used for change tracking and data currency assessment.',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Date and time when the geocode was last verified as accurate, either through automated validation or manual field verification. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Null if the geocode has never been verified. Used to identify geocodes requiring re-verification.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate in decimal degrees using the WGS84 coordinate reference system. Range: -90.0000000 to +90.0000000. Positive values represent North, negative values represent South.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate in decimal degrees using the WGS84 coordinate reference system. Range: -180.0000000 to +180.0000000. Positive values represent East, negative values represent West.',
    `match_score` DECIMAL(18,2) COMMENT 'Score indicating how well the input address matched the geocoding providers reference database, typically expressed as a percentage (0.00 to 100.00). Distinct from confidence_score; match_score reflects address string similarity while confidence_score reflects coordinate accuracy. Used to identify addresses requiring manual review.',
    `mesh_block_reference` STRING COMMENT 'Australian Bureau of Statistics (ABS) mesh block identifier. The smallest geographic area defined by the ABS, used for census data collection and demographic analysis. Critical for market segmentation and regulatory reporting in Australia.',
    `network_coverage_area_code` STRING COMMENT 'Code identifying the network coverage area that contains this geocoded location. Derived from the geocoded coordinates by spatial intersection with coverage area polygons. Used to determine technology availability (LTE, 5G NR, FTTH) and QoS (Quality of Service) expectations.',
    `notes` STRING COMMENT 'Free-text field for additional information about the geocode. May include details about geocoding challenges, manual adjustments made, field technician observations, or special instructions for future verification. Used for operational context and knowledge capture.',
    `output_area_reference` STRING COMMENT 'United Kingdom Office for National Statistics (ONS) output area identifier. The smallest census geography in the UK, used for demographic analysis and market research. Required for Ofcom regulatory reporting in the UK market.',
    `plus_code` STRING COMMENT 'Open Location Code (Plus Code) representation of the geocoded location. A grid-based geocoding system that provides a short, human-readable code for any location. Useful for areas without formal street addresses, common in emerging markets and rural areas.',
    `service_territory_code` STRING COMMENT 'Code identifying the service territory that contains this geocoded location. Derived from the geocoded coordinates by spatial intersection with service territory boundaries. Used for dispatch routing, SLA (Service Level Agreement) assignment, and workforce management.',
    `verification_method` STRING COMMENT 'Method used to verify the accuracy of the geocode. Field_survey indicates a technician physically visited the location. GPS_capture indicates coordinates were captured on-site using GPS equipment. Customer_confirmation indicates the customer validated the location. Automated_validation indicates system-based verification against reference data.. Valid values are `field_survey|gps_capture|customer_confirmation|automated_validation|third_party_verification`',
    `what3words_address` STRING COMMENT 'What3Words three-word address representation of the geocoded location. Each 3m x 3m square in the world has been assigned a unique three-word identifier. Used by field technicians for precise location identification during CPE (Customer Premises Equipment) installation and fault management.',
    CONSTRAINT pk_address_geocode PRIMARY KEY(`address_geocode_id`)
) COMMENT 'Master record storing the authoritative geocoding result for each address — the definitive latitude/longitude and spatial attributes assigned to an address after validation and geocoding. Captures geocode identifier, address reference, latitude (WGS84), longitude (WGS84), elevation (metres), geocode accuracy level (rooftop, parcel_centroid, street_interpolated, street_centroid, suburb_centroid, postcode_centroid), geocode method (GNAF_match, USPS_match, HERE_API, Google_API, manual_survey, GPS_capture), horizontal accuracy (metres), geocoding provider, geocoding timestamp, confidence score, mesh block reference (ABS), census block reference (US), output area reference (UK), and is_authoritative flag. Separates the geocoding concern from the address master to allow multiple geocoding attempts and provider comparisons.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` (
    `infrastructure_corridor_id` BIGINT COMMENT 'Unique identifier for the telecommunications infrastructure corridor. Primary key for the infrastructure corridor master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this corridor record. Used for audit trails and accountability.',
    `service_territory_id` BIGINT COMMENT 'Reference to the primary service territory that this corridor serves or passes through. Used for regional planning and operational assignment.',
    `branched_from_infrastructure_corridor_id` BIGINT COMMENT 'Self-referencing FK on infrastructure_corridor (branched_from_infrastructure_corridor_id)',
    `annual_opex_usd` DECIMAL(18,2) COMMENT 'Estimated annual operational expenditure for maintaining and operating the corridor, measured in United States Dollars. Includes maintenance, inspections, lease payments, and regulatory compliance costs.',
    `backup_route_available_flag` BOOLEAN COMMENT 'Indicates whether an alternative backup route exists that can carry traffic if this corridor fails. True for corridors with diverse route protection; false for single-path corridors. Critical for network resilience assessment.',
    `capacity_bandwidth_gbps` DECIMAL(18,2) COMMENT 'Total designed bandwidth capacity of the corridor measured in Gigabits per second, applicable to microwave and other non-fiber corridors. Represents aggregate throughput capability. Null for fiber corridors where capacity is measured in fiber count.',
    `capacity_fiber_count` STRING COMMENT 'Total number of fiber strands available in the corridor for fiber-based corridors (long_haul_fiber, submarine_cable). Null for non-fiber corridors. Represents total capacity for wavelength provisioning and service delivery.',
    `commissioning_date` DATE COMMENT 'Date when the corridor was officially placed into operational service and made available for traffic. Marks the transition from construction to active status.',
    `construction_start_date` DATE COMMENT 'Date when physical construction of the corridor began. Used for project tracking, CAPEX amortization, and regulatory compliance reporting.',
    `corridor_identifier` STRING COMMENT 'Externally-known unique business identifier or code for the corridor, used for operational reference and inter-system communication.',
    `corridor_name` STRING COMMENT 'Human-readable name of the infrastructure corridor, typically reflecting geographic endpoints or route designation (e.g., New York-Boston Fiber Route, Trans-Pacific Cable Landing Corridor).',
    `corridor_owner` STRING COMMENT 'Legal entity or organization that owns the physical infrastructure corridor. May be the telecommunications operator, a third-party infrastructure provider, utility company, or government entity.',
    `corridor_status` STRING COMMENT 'Current operational status of the corridor in its lifecycle. Active corridors are in service; planned corridors are approved but not yet built; under_construction corridors are being deployed; decommissioned corridors are retired; suspended corridors are temporarily out of service; maintenance corridors are undergoing scheduled work.. Valid values are `active|planned|under_construction|decommissioned|suspended|maintenance`',
    `corridor_type` STRING COMMENT 'Classification of the infrastructure corridor based on the primary transport medium and deployment method. Determines planning, permitting, and operational considerations.. Valid values are `long_haul_fiber|submarine_cable|microwave_los|power_line_colocated|rail_corridor|highway_corridor`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corridor record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `data_source_system` STRING COMMENT 'Name or identifier of the source system from which this corridor record originated (e.g., Netcracker OSS, Oracle Communications, GIS system). Used for data lineage and integration troubleshooting.',
    `decommissioning_date` DATE COMMENT 'Date when the corridor was officially retired from service and removed from the active network. Null for corridors that remain in service.',
    `end_location_reference` STRING COMMENT 'Reference identifier or name for the ending point of the corridor, typically a major network node, Point of Presence (POP), cable landing station, or exchange location.',
    `environmental_zone` STRING COMMENT 'Environmental or ecological zone classification for the corridor route, indicating special environmental considerations, protected areas, or habitat restrictions that affect construction and maintenance activities.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems, partners, or regulatory bodies to reference this corridor. Enables cross-system reconciliation and partner data exchange.',
    `geometry_wkt` STRING COMMENT 'Spatial representation of the corridor route as a LINESTRING in Well-Known Text format, capturing the geographic path from start to end including intermediate waypoints. Used for GIS analysis, route diversity calculations, and network planning.',
    `installation_cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure (CAPEX) for constructing and commissioning the corridor, measured in United States Dollars. Includes materials, labor, permitting, and right-of-way acquisition costs. Used for ROI analysis and asset valuation.',
    `interconnect_points_count` STRING COMMENT 'Number of intermediate interconnection points, splice points, or access nodes along the corridor where other network segments can connect. Indicates flexibility for network expansion and service delivery.',
    `iru_holder` STRING COMMENT 'Entity holding the Indefeasible Right of Use for the corridor, granting long-term exclusive usage rights without ownership. Common in submarine cable and long-haul fiber arrangements. Null if corridor is fully owned and operated.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or survey of the corridor infrastructure. Used for maintenance planning and asset condition tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this corridor record was most recently updated. Used for change tracking, data synchronization, and audit compliance.',
    `mttr_target_hours` DECIMAL(18,2) COMMENT 'Target Mean Time to Repair for corridor outages, measured in hours. Represents the maximum acceptable time to restore service after a failure. Used for SLA compliance monitoring and workforce planning.',
    `next_maintenance_date` DATE COMMENT 'Date when the next scheduled preventive maintenance or inspection is planned for the corridor. Used for workforce planning and outage scheduling.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special considerations, historical context, or other relevant information about the corridor that does not fit structured fields.',
    `permit_authority` STRING COMMENT 'Government agency, regulatory body, or authority responsible for issuing construction and operational permits for the corridor. Critical for compliance tracking and regulatory reporting.',
    `permit_expiry_date` DATE COMMENT 'Date when the current construction or operational permit for the corridor expires. Null for corridors with perpetual permits. Used for compliance tracking and renewal planning.',
    `protection_type` STRING COMMENT 'Network protection and redundancy strategy for the corridor. Unprotected corridors have no backup; ring_protected corridors are part of a self-healing ring topology; diverse_route corridors have physically separate backup paths; mesh_protected corridors have multiple redundant paths; dual_homing corridors connect to multiple network nodes.. Valid values are `unprotected|ring_protected|diverse_route|mesh_protected|dual_homing`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification or designation assigned to the corridor by governing authorities (e.g., interstate, intrastate, international, critical infrastructure). Determines applicable regulations and reporting requirements.',
    `right_of_way_type` STRING COMMENT 'Legal arrangement governing the right to construct and maintain infrastructure along the corridor path. Owned indicates full property ownership; leased indicates rental agreement; easement indicates legal right to use anothers property; shared_utility indicates co-location with utility infrastructure; public_right_of_way indicates use of public land; licensed indicates regulatory permission.. Valid values are `owned|leased|easement|shared_utility|public_right_of_way|licensed`',
    `route_diversity_group` STRING COMMENT 'Identifier for the route diversity group or bundle to which this corridor belongs. Corridors in the same group serve similar endpoints and are evaluated together for diversity analysis and risk assessment.',
    `seismic_risk_zone` STRING COMMENT 'Seismic activity risk classification for the corridor route. High-risk zones require enhanced structural design and more frequent inspections. Critical for submarine cables and long-haul fiber in geologically active regions.. Valid values are `low|moderate|high|very_high`',
    `sla_tier` STRING COMMENT 'Service level tier assigned to the corridor, defining restoration time objectives, availability targets, and support priority. Higher tiers receive faster response and stricter uptime guarantees.. Valid values are `platinum|gold|silver|bronze|standard`',
    `start_location_reference` STRING COMMENT 'Reference identifier or name for the starting point of the corridor, typically a major network node, Point of Presence (POP), cable landing station, or exchange location.',
    `strategic_importance_flag` BOOLEAN COMMENT 'Indicates whether this corridor is designated as strategically important for the network backbone, critical infrastructure, or national security. True for corridors that are essential for network resilience and business continuity.',
    `total_length_km` DECIMAL(18,2) COMMENT 'Total physical length of the infrastructure corridor measured in kilometers, representing the end-to-end distance along the route. Critical for capacity planning, cost estimation, and network design.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Current utilization of the corridors total capacity, expressed as a percentage. For fiber corridors, represents percentage of fibers in use; for bandwidth corridors, represents percentage of bandwidth allocated. Used for capacity planning and investment prioritization.',
    `vendor_name` STRING COMMENT 'Name of the primary vendor or contractor responsible for constructing or maintaining the corridor infrastructure. Used for vendor management and support escalation.',
    `weather_exposure_level` STRING COMMENT 'Classification of the corridors exposure to severe weather events (hurricanes, floods, ice storms, extreme temperatures). Influences design specifications, maintenance frequency, and disaster recovery planning.. Valid values are `low|moderate|high|extreme`',
    CONSTRAINT pk_infrastructure_corridor PRIMARY KEY(`infrastructure_corridor_id`)
) COMMENT 'Master record for major telecommunications infrastructure corridors — long-haul fiber routes, submarine cable landing corridors, microwave line-of-sight paths, and power line corridors used for infrastructure co-location. Captures corridor identifier, corridor name, corridor type (long_haul_fiber, submarine_cable, microwave_LOS, power_line_colocated, rail_corridor, highway_corridor), geometry (linestring WKT), total length (km), start location reference, end location reference, corridor owner, IRU holder, corridor status (active, planned, under_construction, decommissioned), capacity (fiber count or bandwidth), protection type (unprotected, ring_protected, diverse_route), permit authority, and strategic importance flag. Supports long-haul network planning, route diversity analysis, and infrastructure investment decisions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`mdu_building` (
    `mdu_building_id` BIGINT COMMENT 'Unique system identifier for the MDU or multi-tenanted building record. Primary key for the mdu_building product.',
    `exchange_id` BIGINT COMMENT 'Reference to the telecommunications exchange or central office that serves this MDU building. Determines backhaul connectivity and service availability.',
    `location_address_id` BIGINT COMMENT 'Reference to the standardized location address record for this MDU building. Links to the location_address product for full address details.',
    `element_id` BIGINT COMMENT 'Foreign key linking to network.element. Business justification: MDU buildings have dedicated network termination equipment (building switches, ONTs, fiber distribution). Critical for service activation, fault isolation, capacity management, and in-building network',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory within which this MDU building is located. Determines the responsible field team, dispatch zone, and operational jurisdiction.',
    `parent_mdu_building_id` BIGINT COMMENT 'Self-referencing FK on mdu_building (parent_mdu_building_id)',
    `access_restrictions` STRING COMMENT 'Description of any physical access restrictions, security requirements, or special procedures required for field technicians to access the MDU building infrastructure (e.g., Security escort required, Access via building manager only).',
    `agreement_expiry_date` DATE COMMENT 'Date when the current MDU access agreement or infrastructure deployment agreement with the building owner expires. Triggers renewal or renegotiation activities.',
    `body_corporate_reference` STRING COMMENT 'Reference identifier for the body corporate, owners corporation, or homeowners association governing the MDU building. Required for infrastructure installation approvals.',
    `building_code` STRING COMMENT 'Externally-known unique business identifier for the MDU building, used across network planning, service provisioning, and field operations. Typically assigned by network planning or property management systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `building_commissioning_date` DATE COMMENT 'Date when the MDU building telecommunications infrastructure was commissioned and made available for service provisioning. Marks the transition from construction to operational status.',
    `building_height_meters` DECIMAL(18,2) COMMENT 'Total height of the MDU building structure in meters from ground level to roof. Used for radio frequency propagation modeling and small cell placement planning.',
    `building_manager_contact` STRING COMMENT 'Primary contact information (phone or email) for the building manager or property management company. Used for coordinating site access and installation activities.',
    `building_name` STRING COMMENT 'Common name or marketing name of the MDU building (e.g., Sunset Towers, Central Business Plaza, University Village Apartments).',
    `building_owner_name` STRING COMMENT 'Name of the legal entity or individual that owns the MDU building. Critical for access negotiations and infrastructure agreement discussions.',
    `building_status` STRING COMMENT 'Current lifecycle status of the MDU building in the network planning and service delivery context. Determines whether the building is available for service provisioning.. Valid values are `planned|under_construction|commissioned|operational|decommissioned|demolished`',
    `building_type` STRING COMMENT 'Classification of the MDU building structure based on primary usage and tenancy model. Determines infrastructure design requirements and service delivery approach.. Valid values are `residential_apartment|commercial_office|mixed_use|shopping_centre|hotel|student_accommodation`',
    `connected_unit_count` STRING COMMENT 'Number of dwelling units or premises within the MDU building that currently have active telecommunications service connections. Used for penetration rate and take-up analysis.',
    `construction_year` STRING COMMENT 'Year when the physical MDU building structure was originally constructed. Influences infrastructure retrofit requirements and access constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MDU building record was first created in the system. Audit trail for data lineage and compliance.',
    `data_source` STRING COMMENT 'Identifier of the source system or data collection method that provided this MDU building record (e.g., Netcracker Resource Inventory, Field Survey 2024-Q1, Property Database Import).',
    `fiber_entry_point` STRING COMMENT 'Description of the physical location where external fiber optic cables enter the MDU building (e.g., South wall basement conduit, Underground vault access). Critical for outside plant to inside plant handoff.',
    `five_g_small_cell_installed` BOOLEAN COMMENT 'Indicates whether 5G small cell equipment has been deployed within or on the MDU building to provide enhanced indoor mobile coverage. Relevant for 5G New Radio (5G NR) network planning.',
    `footprint_area_sqm` DECIMAL(18,2) COMMENT 'Ground-level footprint area of the MDU building in square meters. Used for site planning and infrastructure density calculations.',
    `idf_count` STRING COMMENT 'Number of intermediate distribution frames or floor-level distribution points installed within the MDU building. Indicates the granularity of in-building network distribution.',
    `in_building_network_type` STRING COMMENT 'Type of telecommunications infrastructure deployed or planned within the MDU building. Determines service capabilities and technology limitations for end-user provisioning.. Valid values are `FTTP_riser|HFC_riser|VDSL_riser|WiFi_only|5G_small_cell`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MDU building record was most recently updated. Audit trail for data lineage and change tracking.',
    `last_site_survey_date` DATE COMMENT 'Date when the most recent physical site survey or infrastructure audit was conducted for the MDU building. Used to assess data currency and plan re-survey activities.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the MDU building centroid in decimal degrees (WGS84). Used for network coverage analysis and field dispatch routing.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the MDU building centroid in decimal degrees (WGS84). Used for network coverage analysis and field dispatch routing.',
    `mdf_location` STRING COMMENT 'Physical location description of the main distribution frame or primary telecommunications room within the MDU building (e.g., Basement Level 1, Room B-12). Critical for field technician access.',
    `mdu_agreement_status` STRING COMMENT 'Current status of the access agreement or infrastructure deployment agreement with the building owner or body corporate. Determines whether service provisioning is authorized.. Valid values are `agreement_in_place|negotiating|no_agreement|expired|terminated`',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance or infrastructure inspection activity for the MDU building telecommunications equipment.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or contextual information about the MDU building that does not fit structured fields.',
    `parking_availability` STRING COMMENT 'Availability of parking facilities for field technician vehicles during installation and maintenance activities. Impacts field dispatch planning and service appointment scheduling.. Valid values are `on_site|street_parking|no_parking|permit_required`',
    `power_backup_available` BOOLEAN COMMENT 'Indicates whether backup power (UPS or generator) is available for telecommunications equipment within the MDU building. Impacts service reliability and SLA commitments.',
    `riser_available_capacity` STRING COMMENT 'Number of unused fiber or cable pairs currently available in the vertical riser infrastructure. Used for capacity planning and service provisioning feasibility checks.',
    `riser_capacity` STRING COMMENT 'Maximum number of fiber or cable pairs available in the vertical riser infrastructure within the MDU building. Determines the maximum serviceable unit count.',
    `serviceable_unit_count` STRING COMMENT 'Number of dwelling units or premises within the MDU building that are technically serviceable with telecommunications infrastructure. May be less than total units due to infrastructure limitations.',
    `total_floors` STRING COMMENT 'Total number of floors or levels in the MDU building, including basement and ground levels. Critical for vertical infrastructure planning and riser design.',
    `total_tenancies` STRING COMMENT 'Total number of commercial tenancies, office suites, or business premises within the MDU building. Relevant for mixed-use and commercial buildings.',
    `total_units` STRING COMMENT 'Total number of individual dwelling units, apartments, or residential premises within the MDU building. Used for capacity planning and penetration rate calculations.',
    `wifi_coverage_available` BOOLEAN COMMENT 'Indicates whether managed WiFi coverage is available within common areas or individual units of the MDU building. Relevant for converged fixed-mobile service offerings.',
    CONSTRAINT pk_mdu_building PRIMARY KEY(`mdu_building_id`)
) COMMENT 'Master record for Multi-Dwelling Unit (MDU) and Multi-Tenanted Building (MTB) structures — apartment complexes, office towers, shopping centres, and mixed-use developments that require building-level telecommunications infrastructure planning and in-building network design. Captures MDU identifier, building name, building type (residential_apartment, commercial_office, mixed_use, shopping_centre, hotel, student_accommodation, retirement_village), address reference, total floors, total units, total tenancies, building owner name, building manager contact, body corporate reference, in-building network type (FTTP_riser, HFC_riser, VDSL_riser, WiFi_only, 5G_small_cell), MDU agreement status (agreement_in_place, negotiating, no_agreement), serviceable unit count, connected unit count, and building commissioning date. Critical for MDU rollout planning and in-building coverage management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`coverage_gap` (
    `coverage_gap_id` BIGINT COMMENT 'Unique identifier for the coverage gap record. Primary key.',
    `administrative_region_id` BIGINT COMMENT 'Reference to the administrative region (county, municipality, district) where the coverage gap is located, used for regulatory reporting.',
    `team_id` BIGINT COMMENT 'Reference to the network planning or engineering team responsible for analyzing and remediating this coverage gap.',
    `employee_id` BIGINT COMMENT 'Reference to the individual engineer or project manager assigned ownership of this coverage gap remediation.',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory within which this coverage gap is located, used for operational assignment and resource planning.',
    `split_from_coverage_gap_id` BIGINT COMMENT 'Self-referencing FK on coverage_gap (split_from_coverage_gap_id)',
    `actual_resolution_date` DATE COMMENT 'The actual date on which the coverage gap was resolved and service quality verified to meet minimum thresholds.',
    `affected_population_estimate` STRING COMMENT 'Estimated number of individuals residing or working within the coverage gap area who are impacted by the service deficiency.',
    `affected_premises_count` STRING COMMENT 'Number of residential and business premises located within the coverage gap area that lack adequate service.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area of the coverage gap measured in square kilometers.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic centroid of the coverage gap area, in decimal degrees.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic centroid of the coverage gap area, in decimal degrees.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage gap record was first created in the system.',
    `customer_complaint_count` STRING COMMENT 'Number of customer complaints or trouble tickets associated with poor coverage in this geographic area, used as supporting evidence for gap identification.',
    `data_source` STRING COMMENT 'The source system or tool from which the coverage gap data was derived (e.g., Nokia NetAct, Ericsson Network Manager, propagation modeling tool).',
    `estimated_remediation_cost_usd` DECIMAL(18,2) COMMENT 'Estimated capital expenditure required to remediate the coverage gap, expressed in USD.',
    `funding_source` STRING COMMENT 'The source of funding for gap remediation (e.g., internal CAPEX, government subsidy, Universal Service Fund, public-private partnership).',
    `gap_identifier` STRING COMMENT 'Business-facing unique identifier or code for the coverage gap, used for external reference and reporting to regulatory bodies.',
    `gap_name` STRING COMMENT 'Human-readable name or label for the coverage gap, typically referencing the geographic area or community affected.',
    `gap_severity` STRING COMMENT 'Business priority classification of the coverage gap based on impact to service delivery, regulatory compliance, and customer experience.. Valid values are `critical|high|medium|low`',
    `gap_status` STRING COMMENT 'Current lifecycle status of the coverage gap record in the remediation workflow. [ENUM-REF-CANDIDATE: identified|validated|prioritized|assigned|in_remediation|resolved|closed|deferred — 8 candidates stripped; promote to reference product]',
    `gap_type` STRING COMMENT 'Classification of the coverage gap based on the type of service deficiency: no 4G coverage, no 5G coverage, no broadband, below minimum speed threshold, poor indoor coverage, or no emergency coverage.. Valid values are `no_4g_coverage|no_5g_coverage|no_broadband|below_minimum_speed|poor_indoor_coverage|no_emergency_coverage`',
    `geometry_wkt` STRING COMMENT 'Geographic boundary of the coverage gap represented as a polygon in Well-Known Text format, defining the precise area where coverage does not meet minimum thresholds.',
    `identification_date` DATE COMMENT 'The date on which the coverage gap was first identified and recorded in the system.',
    `identification_method` STRING COMMENT 'The methodology or data source used to identify and validate the existence of the coverage gap.. Valid values are `propagation_model|drive_test|customer_complaint_cluster|regulatory_audit|crowdsourced_data|network_kpi_analysis`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage gap record was last updated, tracking changes to status, remediation plans, or other attributes.',
    `measured_signal_strength_dbm` DECIMAL(18,2) COMMENT 'The actual measured signal strength in dBm within the gap area, as determined by drive testing or propagation modeling.',
    `measured_throughput_mbps` DECIMAL(18,2) COMMENT 'The actual measured data throughput in Mbps within the gap area, as determined by speed testing or network performance monitoring.',
    `minimum_signal_strength_dbm` DECIMAL(18,2) COMMENT 'The minimum acceptable signal strength threshold in dBm that defines adequate coverage; values below this threshold constitute a gap.',
    `minimum_throughput_mbps` DECIMAL(18,2) COMMENT 'The minimum acceptable data throughput in Mbps that defines adequate service quality; throughput below this threshold constitutes a gap.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or special considerations related to the coverage gap and its remediation.',
    `priority_score` STRING COMMENT 'Numerical priority score assigned to the coverage gap for investment planning, based on factors such as population impact, regulatory requirements, and business case.',
    `programme_reference` STRING COMMENT 'Reference identifier for the network investment programme or project to which this coverage gap has been assigned for remediation.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory authority or jurisdiction responsible for oversight of coverage requirements in this area (e.g., FCC, Ofcom, state PUC).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this coverage gap must be reported to regulatory authorities as part of compliance obligations.',
    `remediation_method` STRING COMMENT 'The planned or implemented technical solution for closing the coverage gap (e.g., new macro site, small cell deployment, FTTH extension, capacity upgrade).',
    `remediation_plan_status` STRING COMMENT 'Current status of the remediation plan for closing this coverage gap, tracking progression from identification through resolution.. Valid values are `unplanned|planned|funded|in_progress|resolved`',
    `resolution_verification_method` STRING COMMENT 'The method used to verify that the coverage gap has been successfully closed (e.g., post-deployment drive test, customer feedback analysis, network KPI monitoring).',
    `target_resolution_date` DATE COMMENT 'The planned or committed date by which the coverage gap is expected to be resolved and service restored to acceptable levels.',
    `technology_type` STRING COMMENT 'The telecommunications technology for which the gap exists (e.g., LTE, 5G NR, FTTH, Fixed Wireless, DSL).',
    `universal_service_obligation_flag` BOOLEAN COMMENT 'Indicates whether this coverage gap falls within an area subject to Universal Service Obligations requiring mandatory service provision.',
    `validation_date` DATE COMMENT 'The date on which the coverage gap was validated through field testing or additional analysis to confirm the deficiency.',
    CONSTRAINT pk_coverage_gap PRIMARY KEY(`coverage_gap_id`)
) COMMENT 'Master record identifying and tracking specific geographic gaps in telecommunications coverage — areas where coverage analysis has identified that current network infrastructure does not meet minimum service thresholds. Captures gap identifier, gap type (no_4G_coverage, no_5G_coverage, no_broadband, below_minimum_speed, poor_indoor_coverage, no_emergency_coverage), geometry (polygon WKT), affected premises count, affected population estimate, gap severity (critical, high, medium, low), gap identification method (propagation_model, drive_test, customer_complaint_cluster, regulatory_audit), identification date, assigned programme or project reference, remediation plan status (unplanned, planned, funded, in_progress, resolved), target resolution date, and actual resolution date. Drives network investment prioritisation and regulatory compliance gap closure.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`reference_code` (
    `reference_code_id` BIGINT COMMENT 'Unique identifier for the location reference code record. Primary key for the location reference code master table.',
    `employee_id` BIGINT COMMENT 'The identifier of the user or system account that last modified this reference code record. Supports accountability and audit trail for reference data governance. May reference an enterprise identity management system or data stewardship platform.',
    `parent_reference_code_id` BIGINT COMMENT 'Self-referencing FK on reference_code (parent_reference_code_id)',
    `alternate_code_value` DECIMAL(18,2) COMMENT 'An alternative identifier or legacy code value used in external systems, partner interfaces, or historical data. Supports cross-system mapping and data migration scenarios where multiple code schemes must be reconciled (e.g., legacy BSS system codes, partner MVNO codes, regulatory reporting codes).',
    `approval_status` STRING COMMENT 'The current approval state of this reference code in the data governance workflow. Draft codes are under development; pending_review codes await data steward approval; approved codes are released for operational use; rejected codes were not approved and should not be used. Supports formal change control for reference data.. Valid values are `draft|pending_review|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this reference code was approved for operational use by the data governance authority. Null for codes that have not yet been approved. Supports audit trail and compliance validation.',
    `code_description` STRING COMMENT 'Detailed business definition and usage guidance for this reference code. Explains the semantic meaning, business rules for assignment, and any special considerations or constraints. Provides context for data stewards and business users to ensure consistent application across the enterprise.',
    `code_label` STRING COMMENT 'The human-readable display label for this reference code. Used in user interfaces, reports, and business communications (e.g., Residential for code value RES, Multi-Dwelling Unit for MDU, Cell Tower Site for CELL_TOWER).',
    `code_set_name` STRING COMMENT 'The classification category or taxonomy to which this reference code belongs. Identifies the domain of location classification (e.g., address_type for residential/commercial/PO Box, premise_type for MDU/SDU/business, site_type for cell tower/exchange/data center, zone_type for urban/suburban/rural, region_type for state/county/municipality, coverage_tier for tier-1/tier-2/tier-3). [ENUM-REF-CANDIDATE: address_type|premise_type|site_type|zone_type|region_type|coverage_tier|geocode_accuracy_level|rollout_zone_type — promote to reference product]. Valid values are `address_type|premise_type|site_type|zone_type|region_type|coverage_tier`',
    `code_value` DECIMAL(18,2) COMMENT 'The unique identifier or key value for this reference code within its code set. Used as the canonical value stored in operational systems and data products (e.g., RES for residential address type, MDU for multi-dwelling unit premise type, CELL_TOWER for cell site type).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reference code record was first created in the location reference code master table. Supports audit trail and data lineage tracking.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this reference code is visible to customers in self-service portals, mobile apps, or customer communications. True means the code label and description must be customer-friendly and comply with brand guidelines; False means the code is for internal operational use only.',
    `data_source_system` STRING COMMENT 'The name or identifier of the operational system or authoritative source from which this reference code originated (e.g., Netcracker OSS, Oracle OSM, internal data governance platform, ISO standard, TM Forum SID). Supports data lineage and source system traceability.',
    `deprecation_reason` STRING COMMENT 'The business justification or rationale for deprecating or retiring this reference code. Explains why the code is no longer needed (e.g., business process change, regulatory update, code consolidation, technology evolution). Null for active codes. Supports knowledge retention and future reference.',
    `display_order` STRING COMMENT 'The sort order or sequence number for displaying this code within its code set in user interfaces, dropdown lists, and reports. Lower numbers appear first. Enables business-driven ordering rather than alphabetical sorting.',
    `effective_date` DATE COMMENT 'The date from which this reference code becomes valid and available for use in location classification. Supports temporal validity and allows for planned introduction of new codes aligned with business initiatives or regulatory changes.',
    `expiry_date` DATE COMMENT 'The date after which this reference code is no longer valid for assignment to new location records. Null indicates the code has no planned expiration. Supports graceful deprecation of obsolete codes while maintaining historical data integrity.',
    `external_system_code` STRING COMMENT 'The corresponding code value used in external operational systems or partner platforms. Facilitates integration and data exchange with source systems (e.g., Amdocs, Salesforce, NetCracker, Oracle OSM) by maintaining the mapping between canonical lakehouse codes and system-specific codes.',
    `governing_standard` STRING COMMENT 'The authoritative standard, specification, or framework that defines this reference code. Identifies whether the code is based on an international standard (e.g., ISO 19112, TM Forum SID), industry standard (e.g., GSMA, 3GPP), regulatory requirement (e.g., FCC, BEREC), or is operator-defined for internal business needs. Ensures traceability to source authority and supports compliance validation.',
    `hierarchy_level` STRING COMMENT 'The depth level of this code within a hierarchical code set structure. Level 1 represents top-level codes, level 2 represents first-level children, and so on. Supports navigation and rollup operations in multi-tier classification schemes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this reference code is currently active and available for use in operational systems. True means the code can be assigned to new location records; False means the code is deprecated or retired but retained for historical data integrity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this reference code record was most recently updated. Tracks changes to code labels, descriptions, effective dates, or status flags. Supports change management and data governance processes.',
    `last_used_timestamp` TIMESTAMP COMMENT 'The most recent date and time when this reference code was assigned to a location record in any operational system. Helps identify obsolete or unused codes that may be candidates for retirement. Null if the code has never been used.',
    `network_planning_flag` BOOLEAN COMMENT 'Indicates whether this reference code is used in network planning and engineering processes (RAN planning, transport planning, capacity planning, coverage optimization). True means the code is critical for network design and investment decisions; False means the code is not used in network planning workflows.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, or business notes related to this reference code. May include usage guidelines, historical context, migration notes, or cross-references to related codes or documentation.',
    `parent_code_value` DECIMAL(18,2) COMMENT 'The code value of the parent reference code in a hierarchical code set structure. Enables multi-level taxonomies where codes have parent-child relationships (e.g., URBAN zone type as parent of DOWNTOWN and SUBURBAN sub-zones). Null for top-level codes.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this reference code is used in regulatory reporting submissions to governing bodies (FCC, ITU, BEREC, Ofcom). True means the code is part of mandated reporting taxonomies and must be maintained with strict governance; False means the code is for internal operational use only.',
    `replacement_code_value` DECIMAL(18,2) COMMENT 'The code value of the reference code that should be used instead of this deprecated code. Supports data migration and remediation when codes are consolidated or replaced. Null if no direct replacement exists or if the code is still active.',
    `service_delivery_flag` BOOLEAN COMMENT 'Indicates whether this reference code is used in service provisioning, activation, and fulfillment processes. True means the code drives service delivery workflows and SLA commitments; False means the code is not used in service delivery operations.',
    `usage_count` BIGINT COMMENT 'The number of active location records currently classified with this reference code across all location master tables (addresses, premises, sites, coverage areas, etc.). Provides visibility into code adoption and supports impact analysis for code deprecation or consolidation initiatives.',
    CONSTRAINT pk_reference_code PRIMARY KEY(`reference_code_id`)
) COMMENT 'Reference master for standardized location classification codes and type taxonomies used across the location domain — address types, premise types, site types, zone types, region types, and coverage tier codes. Captures code identifier, code set name (address_type, premise_type, site_type, zone_type, region_type, coverage_tier, geocode_accuracy_level, rollout_zone_type), code value, code label, code description, display order, is_active flag, effective date, expiry date, and governing standard reference (ISO, TM Forum, operator-defined). Provides the controlled vocabulary for all location classification attributes, ensuring consistent categorisation across all location master records.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`drive_test_record` (
    `drive_test_record_id` BIGINT COMMENT 'Unique identifier for the drive test measurement record.',
    `coverage_area_id` BIGINT COMMENT 'Reference to the predicted coverage area polygon that this measurement point falls within, enabling calibration of coverage models.',
    `employee_id` BIGINT COMMENT 'Reference to the field engineer or technician who conducted the drive test, used for quality assurance and accountability.',
    `ran_cell_id` BIGINT COMMENT 'Reference to the network cell that was serving the test device at the time of measurement.',
    `service_territory_id` BIGINT COMMENT 'Reference to the service territory or market area where the measurement was taken, used for regional performance analysis.',
    `test_campaign_id` BIGINT COMMENT 'Reference to the parent drive test campaign under which this measurement was collected.',
    `test_route_id` BIGINT COMMENT 'Reference to the predefined route or path followed during the drive test campaign, enabling route-based analysis and repeatability.',
    `retest_of_drive_test_record_id` BIGINT COMMENT 'Self-referencing FK on drive_test_record (retest_of_drive_test_record_id)',
    `altitude_meters` DECIMAL(18,2) COMMENT 'Elevation above sea level in meters at the point of measurement, used for terrain-aware coverage modeling.',
    `call_setup_success_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a voice call setup attempt was successful at this measurement point, used for voice service quality assessment.',
    `cqi` STRING COMMENT 'A value from 0 to 15 reported by the device indicating the quality of the downlink channel, used by the network for adaptive modulation and coding.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this drive test record was first inserted into the system, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_session_active_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether an active data session was established at the time of measurement, affecting throughput and latency readings.',
    `device_imei` STRING COMMENT 'The unique 15-digit identifier of the test device used for the measurement, enabling device-specific performance tracking.',
    `earfcn` STRING COMMENT 'The channel number identifying the LTE carrier frequency, used for frequency planning and interference analysis.',
    `frequency_band` STRING COMMENT 'The radio frequency band or spectrum band identifier used for the measurement (e.g., B28, n78, 1800MHz).',
    `handover_event_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a cell handover event occurred at this measurement point, used to assess mobility performance.',
    `horizontal_accuracy_meters` DECIMAL(18,2) COMMENT 'The estimated horizontal position accuracy of the GPS coordinates in meters, indicating the reliability of the geographic location data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this drive test record was last updated or modified, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latency_ms` DECIMAL(18,2) COMMENT 'The round-trip time delay measured in milliseconds between the test device and the network, critical for real-time application performance assessment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees where the measurement was taken, ranging from -90 to +90.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees where the measurement was taken, ranging from -180 to +180.',
    `measurement_method` STRING COMMENT 'The methodology used to collect the measurement: drive test (vehicular), walk test (pedestrian), or stationary indoor (fixed location inside building).. Valid values are `drive_test|walk_test|stationary_indoor`',
    `measurement_status` STRING COMMENT 'The quality status of the measurement record indicating whether it has been validated, flagged as suspect, or calibrated for use in coverage models.. Valid values are `valid|invalid|suspect|calibrated`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the RF signal measurement was captured in the field, in format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `network_operator_code` STRING COMMENT 'The Mobile Network Code (MNC) and Mobile Country Code (MCC) combination identifying the network operator being tested.',
    `notes` STRING COMMENT 'Free-text field for field engineers to record observations, anomalies, or contextual information about the measurement point.',
    `pci` STRING COMMENT 'The physical cell identity of the serving cell, a unique identifier within the local area used for cell identification and handover decisions.',
    `rsrp_dbm` DECIMAL(18,2) COMMENT 'The average power of the reference signal received from the serving cell, measured in decibels relative to one milliwatt (dBm). Key indicator of signal strength.',
    `rsrq_db` DECIMAL(18,2) COMMENT 'The quality of the received reference signal measured in decibels, indicating signal quality relative to interference and noise.',
    `rssi_dbm` DECIMAL(18,2) COMMENT 'The total received wideband power measured in dBm, including signal, interference, and noise across the channel bandwidth.',
    `sinr_db` DECIMAL(18,2) COMMENT 'The ratio of signal power to interference and noise power measured in decibels, critical for assessing channel quality and throughput potential.',
    `speed_kmh` DECIMAL(18,2) COMMENT 'Vehicle or pedestrian speed in kilometers per hour at the time of measurement, used to distinguish stationary vs mobile testing conditions.',
    `technology_type` STRING COMMENT 'The mobile network technology generation under test at this measurement point.. Valid values are `2G|3G|4G|5G`',
    `test_equipment_type` STRING COMMENT 'The make and model of the drive test equipment or scanner used to collect the measurement (e.g., Rohde & Schwarz ROMES, Keysight Nemo).',
    `throughput_downlink_mbps` DECIMAL(18,2) COMMENT 'The measured data transfer rate from the network to the test device in megabits per second, indicating actual user experience for download speeds.',
    `throughput_uplink_mbps` DECIMAL(18,2) COMMENT 'The measured data transfer rate from the test device to the network in megabits per second, indicating actual user experience for upload speeds.',
    `weather_conditions` STRING COMMENT 'The prevailing weather conditions at the time of measurement, as weather can impact radio propagation characteristics.. Valid values are `clear|cloudy|rain|snow|fog|storm`',
    CONSTRAINT pk_drive_test_record PRIMARY KEY(`drive_test_record_id`)
) COMMENT 'Transactional record of mobile network drive test and walk test measurements collected in the field to validate and calibrate coverage predictions — capturing actual RF signal measurements at specific geographic points. Captures drive test record identifier, test campaign reference, measurement timestamp, latitude, longitude, altitude, speed (km/h), technology (2G, 3G, 4G, 5G), frequency band, serving cell reference, RSRP (dBm), RSRQ (dB), SINR (dB), RSSI (dBm), throughput downlink (Mbps), throughput uplink (Mbps), latency (ms), handover event flag, test equipment type, tester reference, weather conditions, and measurement method (drive_test, walk_test, stationary_indoor). Feeds coverage model calibration, regulatory coverage reporting, and network optimisation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`test_campaign` (
    `test_campaign_id` BIGINT COMMENT 'Primary key for test_campaign',
    `retest_of_test_campaign_id` BIGINT COMMENT 'Self-referencing FK on test_campaign (retest_of_test_campaign_id)',
    `budget_amount` DECIMAL(18,2) COMMENT 'Allocated monetary budget for the test campaign.',
    `budget_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the budget.',
    `campaign_code` STRING COMMENT 'External code used to reference the test campaign in operational systems.',
    `campaign_type` STRING COMMENT 'Category of the test campaign indicating its purpose.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the target area where the campaign met its performance criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test campaign record was first created in the system.',
    `test_campaign_description` STRING COMMENT 'Detailed free‑text description of the test campaign objectives and scope.',
    `device_count` STRING COMMENT 'Count of measurement devices or equipment used in the campaign.',
    `end_date` DATE COMMENT 'Planned or actual end date of the test campaign.',
    `is_control_group` BOOLEAN COMMENT 'Flag indicating whether the campaign includes a control group for comparative analysis.',
    `metric_actual` DECIMAL(18,2) COMMENT 'Observed quantitative metric result after campaign execution.',
    `metric_target` DECIMAL(18,2) COMMENT 'Planned quantitative metric (e.g., coverage % or performance score) the campaign aims to achieve.',
    `test_campaign_name` STRING COMMENT 'Human‑readable name of the test campaign.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the campaign.',
    `result_status` STRING COMMENT 'Overall outcome classification of the test campaign.',
    `start_date` DATE COMMENT 'Planned or actual start date of the test campaign.',
    `test_campaign_status` STRING COMMENT 'Current lifecycle state of the test campaign.',
    `target_audience` STRING COMMENT 'Primary customer segment the campaign is designed to reach.',
    `target_region` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code representing the primary geographic region of the campaign.',
    `test_method` STRING COMMENT 'Method used to conduct the test campaign.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test campaign record.',
    CONSTRAINT pk_test_campaign PRIMARY KEY(`test_campaign_id`)
) COMMENT 'Master reference table for test_campaign. Referenced by test_campaign_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`test_route` (
    `test_route_id` BIGINT COMMENT 'Primary key for test_route',
    `coverage_area_id` BIGINT COMMENT 'Identifier of the coverage area that the route belongs to.',
    `end_location_location_site_id` BIGINT COMMENT 'Identifier of the geographic location where the route terminates.',
    `location_site_id` BIGINT COMMENT 'Identifier of the geographic location where the route originates.',
    `service_territory_id` BIGINT COMMENT 'Identifier of the service territory associated with the route.',
    `derived_from_test_route_id` BIGINT COMMENT 'Self-referencing FK on test_route (derived_from_test_route_id)',
    `capacity_mbps` DECIMAL(18,2) COMMENT 'Maximum data throughput the route can support.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test route record was first created in the system.',
    `distance_km` DECIMAL(18,2) COMMENT 'Physical length of the route in kilometres.',
    `effective_from` DATE COMMENT 'Date when the route became operational or was officially recorded.',
    `effective_until` DATE COMMENT 'Date when the route is scheduled to be retired or become inactive (null if open‑ended).',
    `estimated_travel_time_minutes` STRING COMMENT 'Estimated time to traverse the route under normal conditions.',
    `latency_ms` STRING COMMENT 'Typical end‑to‑end latency observed on the route.',
    `network_zone` STRING COMMENT 'Logical network zone grouping for the route.',
    `route_classification` STRING COMMENT 'Business classification of the route within the network hierarchy.',
    `route_code` STRING COMMENT 'External code used to reference the test route in network planning and operations.',
    `route_description` STRING COMMENT 'Detailed description of the route purpose, topology, and any special characteristics.',
    `route_name` STRING COMMENT 'Human‑readable name of the test route.',
    `route_status` STRING COMMENT 'Current operational status of the test route.',
    `route_type` STRING COMMENT 'Technology or medium used for the route.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test route record.',
    CONSTRAINT pk_test_route PRIMARY KEY(`test_route_id`)
) COMMENT 'Master reference table for test_route. Referenced by test_route_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`location`.`field_survey` (
    `field_survey_id` BIGINT COMMENT 'Primary key for field_survey',
    `location_site_id` BIGINT COMMENT 'Identifier of the geographic location where the survey was conducted.',
    `technician_id` BIGINT COMMENT 'Identifier of the field technician who performed the survey.',
    `follow_up_field_survey_id` BIGINT COMMENT 'Self-referencing FK on field_survey (follow_up_field_survey_id)',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Battery level of the measurement device at the time of the survey.',
    `coverage_area_sqkm` DECIMAL(18,2) COMMENT 'Size of the area covered by the survey in square kilometers.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the survey record was created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑1) representing the overall quality of the collected data.',
    `device_code` BIGINT COMMENT 'Identifier of the handheld device used to collect survey data.',
    `equipment_present` BOOLEAN COMMENT 'Indicates whether required network equipment was present at the survey site.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage recorded during the survey.',
    `is_outdoor` BOOLEAN COMMENT 'True if the survey was conducted at an outdoor location.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the survey point in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the survey point in decimal degrees.',
    `notes` STRING COMMENT 'Free‑form observations and comments captured by the technician.',
    `signal_strength_avg` DECIMAL(18,2) COMMENT 'Mean signal strength measured during the survey.',
    `signal_strength_max` DECIMAL(18,2) COMMENT 'Maximum signal strength observed during the survey.',
    `signal_strength_min` DECIMAL(18,2) COMMENT 'Minimum signal strength observed during the survey.',
    `field_survey_status` STRING COMMENT 'Current lifecycle status of the survey.',
    `survey_code` STRING COMMENT 'External code used to reference the survey in operational systems.',
    `survey_date` DATE COMMENT 'Planned or actual date on which the field survey was performed.',
    `survey_name` STRING COMMENT 'Human‑readable name of the survey.',
    `survey_type` STRING COMMENT 'Category of the survey indicating its purpose.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature recorded during the survey in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the survey record.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of the survey.',
    CONSTRAINT pk_field_survey PRIMARY KEY(`field_survey_id`)
) COMMENT 'Master reference table for field_survey. Referenced by field_survey_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ADD CONSTRAINT `fk_location_location_site_geographic_zone_id` FOREIGN KEY (`geographic_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`geographic_zone`(`geographic_zone_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ADD CONSTRAINT `fk_location_location_site_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ADD CONSTRAINT `fk_location_location_site_parent_location_site_id` FOREIGN KEY (`parent_location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ADD CONSTRAINT `fk_location_location_address_normalized_from_location_address_id` FOREIGN KEY (`normalized_from_location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ADD CONSTRAINT `fk_location_geo_point_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ADD CONSTRAINT `fk_location_geo_point_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ADD CONSTRAINT `fk_location_geo_point_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ADD CONSTRAINT `fk_location_geo_point_corrected_from_geo_point_id` FOREIGN KEY (`corrected_from_geo_point_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_point`(`geo_point_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ADD CONSTRAINT `fk_location_geo_boundary_parent_boundary_geo_boundary_id` FOREIGN KEY (`parent_boundary_geo_boundary_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_boundary`(`geo_boundary_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ADD CONSTRAINT `fk_location_geo_boundary_parent_geo_boundary_id` FOREIGN KEY (`parent_geo_boundary_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_boundary`(`geo_boundary_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ADD CONSTRAINT `fk_location_coverage_area_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ADD CONSTRAINT `fk_location_coverage_area_parent_coverage_area_id` FOREIGN KEY (`parent_coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ADD CONSTRAINT `fk_location_service_territory_parent_territory_service_territory_id` FOREIGN KEY (`parent_territory_service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ADD CONSTRAINT `fk_location_service_territory_parent_service_territory_id` FOREIGN KEY (`parent_service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ADD CONSTRAINT `fk_location_exchange_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ADD CONSTRAINT `fk_location_exchange_parent_exchange_id` FOREIGN KEY (`parent_exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ADD CONSTRAINT `fk_location_premise_broadband_serviceable_location_premise_id` FOREIGN KEY (`broadband_serviceable_location_premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ADD CONSTRAINT `fk_location_premise_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ADD CONSTRAINT `fk_location_premise_mdu_parent_premise_id` FOREIGN KEY (`mdu_parent_premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ADD CONSTRAINT `fk_location_premise_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ADD CONSTRAINT `fk_location_premise_parent_premise_id` FOREIGN KEY (`parent_premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ADD CONSTRAINT `fk_location_administrative_region_parent_region_administrative_region_id` FOREIGN KEY (`parent_region_administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ADD CONSTRAINT `fk_location_administrative_region_parent_administrative_region_id` FOREIGN KEY (`parent_administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_geo_boundary_id` FOREIGN KEY (`geo_boundary_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_boundary`(`geo_boundary_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_geographic_zone_id` FOREIGN KEY (`geographic_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`geographic_zone`(`geographic_zone_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_parent_location_site_id` FOREIGN KEY (`parent_location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ADD CONSTRAINT `fk_location_hierarchy_parent_hierarchy_id` FOREIGN KEY (`parent_hierarchy_id`) REFERENCES `telecommunication_ecm`.`location`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ADD CONSTRAINT `fk_location_coverage_qualification_superseded_coverage_qualification_id` FOREIGN KEY (`superseded_coverage_qualification_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_qualification`(`coverage_qualification_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ADD CONSTRAINT `fk_location_address_validation_event_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ADD CONSTRAINT `fk_location_address_validation_event_reverification_of_address_validation_event_id` FOREIGN KEY (`reverification_of_address_validation_event_id`) REFERENCES `telecommunication_ecm`.`location`.`address_validation_event`(`address_validation_event_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ADD CONSTRAINT `fk_location_coverage_area_version_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ADD CONSTRAINT `fk_location_coverage_area_version_previous_coverage_area_version_id` FOREIGN KEY (`previous_coverage_area_version_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area_version`(`coverage_area_version_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ADD CONSTRAINT `fk_location_network_rollout_zone_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ADD CONSTRAINT `fk_location_network_rollout_zone_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ADD CONSTRAINT `fk_location_network_rollout_zone_parent_network_rollout_zone_id` FOREIGN KEY (`parent_network_rollout_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`network_rollout_zone`(`network_rollout_zone_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_field_survey_id` FOREIGN KEY (`field_survey_id`) REFERENCES `telecommunication_ecm`.`location`.`field_survey`(`field_survey_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_network_rollout_zone_id` FOREIGN KEY (`network_rollout_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`network_rollout_zone`(`network_rollout_zone_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `telecommunication_ecm`.`location`.`premise`(`premise_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ADD CONSTRAINT `fk_location_premises_passed_superseded_premises_passed_id` FOREIGN KEY (`superseded_premises_passed_id`) REFERENCES `telecommunication_ecm`.`location`.`premises_passed`(`premises_passed_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ADD CONSTRAINT `fk_location_cell_coverage_footprint_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ADD CONSTRAINT `fk_location_cell_coverage_footprint_superseded_cell_coverage_footprint_id` FOREIGN KEY (`superseded_cell_coverage_footprint_id`) REFERENCES `telecommunication_ecm`.`location`.`cell_coverage_footprint`(`cell_coverage_footprint_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ADD CONSTRAINT `fk_location_duct_route_geo_point_id` FOREIGN KEY (`geo_point_id`) REFERENCES `telecommunication_ecm`.`location`.`geo_point`(`geo_point_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ADD CONSTRAINT `fk_location_duct_route_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ADD CONSTRAINT `fk_location_duct_route_continuation_duct_route_id` FOREIGN KEY (`continuation_duct_route_id`) REFERENCES `telecommunication_ecm`.`location`.`duct_route`(`duct_route_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ADD CONSTRAINT `fk_location_address_alias_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ADD CONSTRAINT `fk_location_address_alias_canonical_address_alias_id` FOREIGN KEY (`canonical_address_alias_id`) REFERENCES `telecommunication_ecm`.`location`.`address_alias`(`address_alias_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ADD CONSTRAINT `fk_location_geographic_zone_parent_zone_geographic_zone_id` FOREIGN KEY (`parent_zone_geographic_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`geographic_zone`(`geographic_zone_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ADD CONSTRAINT `fk_location_geographic_zone_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ADD CONSTRAINT `fk_location_geographic_zone_parent_geographic_zone_id` FOREIGN KEY (`parent_geographic_zone_id`) REFERENCES `telecommunication_ecm`.`location`.`geographic_zone`(`geographic_zone_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ADD CONSTRAINT `fk_location_change_event_rollback_reference_event_id` FOREIGN KEY (`rollback_reference_event_id`) REFERENCES `telecommunication_ecm`.`location`.`change_event`(`change_event_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ADD CONSTRAINT `fk_location_change_event_reversal_change_event_id` FOREIGN KEY (`reversal_change_event_id`) REFERENCES `telecommunication_ecm`.`location`.`change_event`(`change_event_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ADD CONSTRAINT `fk_location_black_spot_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ADD CONSTRAINT `fk_location_black_spot_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ADD CONSTRAINT `fk_location_black_spot_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ADD CONSTRAINT `fk_location_black_spot_merged_into_black_spot_id` FOREIGN KEY (`merged_into_black_spot_id`) REFERENCES `telecommunication_ecm`.`location`.`black_spot`(`black_spot_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ADD CONSTRAINT `fk_location_address_geocode_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ADD CONSTRAINT `fk_location_address_geocode_superseded_address_geocode_id` FOREIGN KEY (`superseded_address_geocode_id`) REFERENCES `telecommunication_ecm`.`location`.`address_geocode`(`address_geocode_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ADD CONSTRAINT `fk_location_infrastructure_corridor_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ADD CONSTRAINT `fk_location_infrastructure_corridor_branched_from_infrastructure_corridor_id` FOREIGN KEY (`branched_from_infrastructure_corridor_id`) REFERENCES `telecommunication_ecm`.`location`.`infrastructure_corridor`(`infrastructure_corridor_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ADD CONSTRAINT `fk_location_mdu_building_exchange_id` FOREIGN KEY (`exchange_id`) REFERENCES `telecommunication_ecm`.`location`.`exchange`(`exchange_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ADD CONSTRAINT `fk_location_mdu_building_location_address_id` FOREIGN KEY (`location_address_id`) REFERENCES `telecommunication_ecm`.`location`.`location_address`(`location_address_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ADD CONSTRAINT `fk_location_mdu_building_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ADD CONSTRAINT `fk_location_mdu_building_parent_mdu_building_id` FOREIGN KEY (`parent_mdu_building_id`) REFERENCES `telecommunication_ecm`.`location`.`mdu_building`(`mdu_building_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ADD CONSTRAINT `fk_location_coverage_gap_administrative_region_id` FOREIGN KEY (`administrative_region_id`) REFERENCES `telecommunication_ecm`.`location`.`administrative_region`(`administrative_region_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ADD CONSTRAINT `fk_location_coverage_gap_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ADD CONSTRAINT `fk_location_coverage_gap_split_from_coverage_gap_id` FOREIGN KEY (`split_from_coverage_gap_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_gap`(`coverage_gap_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ADD CONSTRAINT `fk_location_reference_code_parent_reference_code_id` FOREIGN KEY (`parent_reference_code_id`) REFERENCES `telecommunication_ecm`.`location`.`reference_code`(`reference_code_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_test_campaign_id` FOREIGN KEY (`test_campaign_id`) REFERENCES `telecommunication_ecm`.`location`.`test_campaign`(`test_campaign_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_test_route_id` FOREIGN KEY (`test_route_id`) REFERENCES `telecommunication_ecm`.`location`.`test_route`(`test_route_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ADD CONSTRAINT `fk_location_drive_test_record_retest_of_drive_test_record_id` FOREIGN KEY (`retest_of_drive_test_record_id`) REFERENCES `telecommunication_ecm`.`location`.`drive_test_record`(`drive_test_record_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`test_campaign` ADD CONSTRAINT `fk_location_test_campaign_retest_of_test_campaign_id` FOREIGN KEY (`retest_of_test_campaign_id`) REFERENCES `telecommunication_ecm`.`location`.`test_campaign`(`test_campaign_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ADD CONSTRAINT `fk_location_test_route_coverage_area_id` FOREIGN KEY (`coverage_area_id`) REFERENCES `telecommunication_ecm`.`location`.`coverage_area`(`coverage_area_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ADD CONSTRAINT `fk_location_test_route_end_location_location_site_id` FOREIGN KEY (`end_location_location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ADD CONSTRAINT `fk_location_test_route_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ADD CONSTRAINT `fk_location_test_route_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `telecommunication_ecm`.`location`.`service_territory`(`service_territory_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ADD CONSTRAINT `fk_location_test_route_derived_from_test_route_id` FOREIGN KEY (`derived_from_test_route_id`) REFERENCES `telecommunication_ecm`.`location`.`test_route`(`test_route_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` ADD CONSTRAINT `fk_location_field_survey_location_site_id` FOREIGN KEY (`location_site_id`) REFERENCES `telecommunication_ecm`.`location`.`location_site`(`location_site_id`);
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` ADD CONSTRAINT `fk_location_field_survey_follow_up_field_survey_id` FOREIGN KEY (`follow_up_field_survey_id`) REFERENCES `telecommunication_ecm`.`location`.`field_survey`(`field_survey_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`location` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `telecommunication_ecm`.`location` SET TAGS ('dbx_domain' = 'location');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Location Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `geographic_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `parent_location_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `annual_opex_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operational Expenditure (OPEX) in United States Dollars (USD)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `annual_opex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `backup_power_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Capacity in Kilowatt-Hours (kWh)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Site Capacity Rating');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_value_regex' = 'small|medium|large|enterprise|carrier_grade');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `cooling_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `cooling_type` SET TAGS ('dbx_value_regex' = 'hvac|passive|liquid|evaporative|none');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Meters');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote|coastal|mountain');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `fiber_connectivity` SET TAGS ('dbx_business_glossary_term' = 'Fiber Connectivity');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `generator_available` SET TAGS ('dbx_business_glossary_term' = 'Generator Available');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `hazardous_materials` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `land_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Land Area in Square Meters');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `microwave_backhaul` SET TAGS ('dbx_business_glossary_term' = 'Microwave Backhaul');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|co_located|joint_venture|licensed');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_value_regex' = 'grid|solar|hybrid|generator|battery');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical_infrastructure');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|decommissioned|planned|under_construction|maintenance|suspended');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'central_office|headend|tower|rooftop|data_center|exchange');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `structural_type` SET TAGS ('dbx_business_glossary_term' = 'Structural Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_site` ALTER COLUMN `structural_type` SET TAGS ('dbx_value_regex' = 'building|tower|pole|rooftop|underground|container');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Location Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `normalized_from_location_address_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|invalid|pending|deprecated');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'civic|postal|rural|military|pobox|general_delivery');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Address Confidence Score');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `dpid` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (DPID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `five_g_coverage_flag` SET TAGS ('dbx_business_glossary_term' = '5G New Radio (NR) Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `ftth_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Home (FTTH) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `geocoding_status` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Status');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `geocoding_status` SET TAGS ('dbx_value_regex' = 'geocoded|not_geocoded|approximate|rooftop|failed');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `gnaf_pid` SET TAGS ('dbx_business_glossary_term' = 'Geocoded National Address File (GNAF) Persistent Identifier (PID)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `last_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `locality` SET TAGS ('dbx_business_glossary_term' = 'Locality');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `locality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `locality` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `lte_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Evolution (LTE) Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `network_coverage_area_code` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage Area Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `plus_code` SET TAGS ('dbx_business_glossary_term' = 'Plus Code (Open Location Code)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `plus_code` SET TAGS ('dbx_value_regex' = '^[23456789CFGHJMPQRVWX]{4,8}+[23456789CFGHJMPQRVWX]{2,3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `standardization_method` SET TAGS ('dbx_business_glossary_term' = 'Address Standardization Method');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `standardization_method` SET TAGS ('dbx_value_regex' = 'manual|usps_api|google_maps|australia_post|royal_mail');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_direction` SET TAGS ('dbx_business_glossary_term' = 'Street Direction');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_direction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_direction` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_name` SET TAGS ('dbx_business_glossary_term' = 'Street Name');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_number` SET TAGS ('dbx_business_glossary_term' = 'Street Number');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_type` SET TAGS ('dbx_business_glossary_term' = 'Street Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_type` SET TAGS ('dbx_value_regex' = 'Street|Avenue|Road|Boulevard|Lane|Drive');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `street_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `unit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `unit_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `uprn` SET TAGS ('dbx_business_glossary_term' = 'Unique Property Reference Number (UPRN)');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Address Usage Type');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'customer_service|installation|billing|network_site|office');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `usps_validation_status` SET TAGS ('dbx_business_glossary_term' = 'United States Postal Service (USPS) Validation Status');
ALTER TABLE `telecommunication_ecm`.`location`.`location_address` ALTER COLUMN `usps_validation_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|corrected|not_validated');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` SET TAGS ('dbx_subdomain' = 'geographic_data');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `geo_point_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Point Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `corrected_from_geo_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `access_instructions` SET TAGS ('dbx_business_glossary_term' = 'Site Access Instructions');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `access_instructions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `capture_date` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Capture Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `capture_method` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Capture Method');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `crs_code` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System (CRS) Code');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Point Decommission Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation Above Sea Level (Meters)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'none|flood_zone|seismic_zone|wildfire_risk|coastal_erosion|extreme_weather');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `horizontal_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Accuracy (Meters)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Point Installation Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate (WGS84)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate (WGS84)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Point Ownership Type');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|licensed|right_of_way|shared|third_party');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Construction Permit Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `point_description` SET TAGS ('dbx_business_glossary_term' = 'Point Description');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `point_identifier` SET TAGS ('dbx_business_glossary_term' = 'Point Business Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `point_name` SET TAGS ('dbx_business_glossary_term' = 'Point Descriptive Name');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `point_status` SET TAGS ('dbx_business_glossary_term' = 'Point Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_construction|surveyed');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `point_type` SET TAGS ('dbx_business_glossary_term' = 'Point Type Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `surveyor_reference` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `vertical_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Vertical Accuracy (Meters)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_point` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Land Use Zoning Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` SET TAGS ('dbx_subdomain' = 'geographic_data');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `geo_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `parent_boundary_geo_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Boundary Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `parent_geo_boundary_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometers');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `boundary_identifier` SET TAGS ('dbx_business_glossary_term' = 'Boundary External Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `boundary_name` SET TAGS ('dbx_business_glossary_term' = 'Boundary Name');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `boundary_status` SET TAGS ('dbx_business_glossary_term' = 'Boundary Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `boundary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|proposed|deprecated|superseded');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `boundary_type` SET TAGS ('dbx_business_glossary_term' = 'Boundary Type Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `business_count` SET TAGS ('dbx_business_glossary_term' = 'Business Establishment Count');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `coordinate_reference_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System (CRS)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `coverage_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Coverage Quality Score');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage Type');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Boundary Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Boundary Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `geometry_geojson` SET TAGS ('dbx_business_glossary_term' = 'Geometry GeoJSON Representation');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Segment');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'residential|business|wholesale|government|education|healthcare');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Boundary Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `perimeter_km` SET TAGS ('dbx_business_glossary_term' = 'Perimeter in Kilometers');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `population_count` SET TAGS ('dbx_business_glossary_term' = 'Population Count');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code or ZIP Code');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Zone Designation');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `source_dataset` SET TAGS ('dbx_business_glossary_term' = 'Source Dataset Name');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_business_glossary_term' = 'Urban Rural Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote');
ALTER TABLE `telecommunication_ecm`.`location`.`geo_boundary` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Boundary Version Number');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `parent_coverage_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area (Square Kilometers)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level (Percent)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_area_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Code');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|planned|decommissioned|suspended');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'outdoor|indoor|deep_indoor|in_vehicle');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `exchange_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `frequency_band` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-.]+$');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `generation_method` SET TAGS ('dbx_business_glossary_term' = 'Generation Method');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `generation_method` SET TAGS ('dbx_value_regex' = 'drive_test|propagation_model|crowdsourced|hybrid');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `population_covered` SET TAGS ('dbx_business_glossary_term' = 'Population Covered');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `predicted_downlink_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Predicted Downlink Throughput (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `predicted_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Predicted Signal Strength (dBm)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `predicted_uplink_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Predicted Uplink Throughput (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'premium|standard|basic');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `roaming_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `parent_territory_service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `parent_service_territory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometers (km²)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `dispatch_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Radius in Kilometers (km)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `franchise_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `network_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage Type');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `service_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Availability Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `service_territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `sla_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Minutes');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|proposed|suspended|retired');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'field_ops|sales_region|noc_zone|dispatch_zone|franchise_area|regulatory_zone');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `telecommunication_ecm`.`location`.`service_territory` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `parent_exchange_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `annual_opex` SET TAGS ('dbx_business_glossary_term' = 'Annual Operational Expenditure (OPEX)');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `annual_opex` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `available_ports` SET TAGS ('dbx_business_glossary_term' = 'Available Ports');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `backbone_connection_type` SET TAGS ('dbx_business_glossary_term' = 'Backbone Connection Type');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `backbone_connection_type` SET TAGS ('dbx_value_regex' = 'fiber|microwave|copper|satellite|hybrid');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `coverage_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Coverage Radius (Kilometers)');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `current_connected_premises` SET TAGS ('dbx_business_glossary_term' = 'Current Connected Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_name` SET TAGS ('dbx_business_glossary_term' = 'Exchange Name');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_status` SET TAGS ('dbx_business_glossary_term' = 'Exchange Status');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_status` SET TAGS ('dbx_value_regex' = 'operational|planned|under_construction|decommissioned|maintenance');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'main_exchange|remote_integrated_multiplexer|street_cabinet|gpon_headend|dslam|bng');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `installation_cost` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `installation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `max_serviceable_premises` SET TAGS ('dbx_business_glossary_term' = 'Maximum Serviceable Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `mttr_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target (Hours)');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `nbn_rollout_flag` SET TAGS ('dbx_business_glossary_term' = 'National Broadband Network (NBN) Rollout Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|shared|third_party');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `port_capacity` SET TAGS ('dbx_business_glossary_term' = 'Port Capacity');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `power_backup_type` SET TAGS ('dbx_business_glossary_term' = 'Power Backup Type');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `power_backup_type` SET TAGS ('dbx_value_regex' = 'battery|generator|ups|none|hybrid');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `technology_served` SET TAGS ('dbx_business_glossary_term' = 'Technology Served');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `technology_served` SET TAGS ('dbx_value_regex' = 'ADSL2+|VDSL2|FTTC|FTTN|FTTP|HFC|GPON|EPON');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `telecommunication_ecm`.`location`.`exchange` ALTER COLUMN `wholesale_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Access Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `broadband_serviceable_location_premise_id` SET TAGS ('dbx_business_glossary_term' = 'Broadband Serviceable Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Subscriber Line Access Multiplexer (DSLAM) Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `mdu_parent_premise_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dwelling Unit (MDU) Parent Premise Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `parent_premise_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `business_count` SET TAGS ('dbx_business_glossary_term' = 'Business Count');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `cadastral_reference` SET TAGS ('dbx_business_glossary_term' = 'Cadastral Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `census_block_code` SET TAGS ('dbx_business_glossary_term' = 'Census Block Code');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `census_block_code` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `dwelling_count` SET TAGS ('dbx_business_glossary_term' = 'Dwelling Count');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `fttn_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Node (FTTN) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `fttp_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fiber to the Premise (FTTP) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `fwa_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Wireless Access (FWA) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|parcel|street|postal_code|city|unknown');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `hazard_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Zone Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `hfc_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Hybrid Fiber-Coaxial (HFC) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `last_serviceability_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Serviceability Update Date');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Date');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `lte_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Evolution (LTE) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `n5g_serviceable_flag` SET TAGS ('dbx_business_glossary_term' = '5G New Radio (5G NR) Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'private|public|government|corporate|cooperative|trust');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `premise_code` SET TAGS ('dbx_business_glossary_term' = 'Premise Code');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `premise_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_business_glossary_term' = 'Premise Status');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_value_regex' = 'active|demolished|under_construction|planned|inactive|condemned');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `rural_flag` SET TAGS ('dbx_business_glossary_term' = 'Rural Area Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `tribal_land_flag` SET TAGS ('dbx_business_glossary_term' = 'Tribal Land Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `telecommunication_ecm`.`location`.`premise` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` SET TAGS ('dbx_subdomain' = 'geographic_data');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `parent_region_administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Administrative Region Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `parent_administrative_region_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `administrative_region_status` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Status');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `administrative_region_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `alternate_name` SET TAGS ('dbx_business_glossary_term' = 'Alternate Region Name');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometres (km²)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-2)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `coverage_priority` SET TAGS ('dbx_business_glossary_term' = 'Coverage Priority');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `coverage_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `economic_indicator` SET TAGS ('dbx_business_glossary_term' = 'Economic Indicator Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Language Code (ISO 639-1)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geographic Coordinate)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `local_language_name` SET TAGS ('dbx_business_glossary_term' = 'Local Language Name');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geographic Coordinate)');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Pattern');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Code');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Name');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `region_type` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Type');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `service_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Availability Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `telecommunication_ecm`.`location`.`administrative_region` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (IANA TZ Database)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` SET TAGS ('dbx_subdomain' = 'geographic_data');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Location Hierarchy Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Child Location Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Administrative Region Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `geo_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Geo Boundary Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `geographic_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Geographic Zone Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `parent_location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Premise Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `parent_hierarchy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `child_location_type` SET TAGS ('dbx_business_glossary_term' = 'Child Location Type');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `coverage_overlap_flag` SET TAGS ('dbx_business_glossary_term' = 'Coverage Overlap Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `depth_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth Level');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `distance_from_parent_km` SET TAGS ('dbx_business_glossary_term' = 'Distance From Parent in Kilometers (KM)');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'administrative|operational|commercial|regulatory|network|coverage');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `is_primary_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Hierarchy Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `network_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Planning Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `parent_location_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Type');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `relationship_notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated');
ALTER TABLE `telecommunication_ecm`.`location`.`hierarchy` ALTER COLUMN `service_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `coverage_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Qualification Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Nearest Cell Site Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `exchange_id` SET TAGS ('dbx_business_glossary_term' = 'Nearest Exchange Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Network Node Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `superseded_coverage_qualification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `business_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Service Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `construction_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Required Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `disqualification_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason Code');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `disqualification_reason_code` SET TAGS ('dbx_value_regex' = 'no_infrastructure|distance_exceeded|capacity_exhausted|regulatory_restriction|construction_required|pending_buildout');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `disqualification_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason Description');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `distance_to_cell_site_km` SET TAGS ('dbx_business_glossary_term' = 'Distance to Cell Site (Kilometers - km)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `distance_to_exchange_km` SET TAGS ('dbx_business_glossary_term' = 'Distance to Exchange (Kilometers - km)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `eligible_product_codes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Product Codes');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `estimated_construction_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Construction Cost');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `estimated_construction_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `estimated_construction_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Construction Days');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `ipv6_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol Version 6 (IPv6) Support Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `network_availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Network Availability Percentage');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `predicted_downlink_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Predicted Downlink Speed (Megabits per Second - Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `predicted_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Predicted Latency (Milliseconds - ms)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `predicted_uplink_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Predicted Uplink Speed (Megabits per Second - Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `primary_technology_available` SET TAGS ('dbx_business_glossary_term' = 'Primary Technology Available');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qos_class_available` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class Available');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qos_class_available` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|best_effort');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Qualification Confidence Score');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_business_glossary_term' = 'Qualification Method');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_method` SET TAGS ('dbx_value_regex' = 'real_time_api|batch_pre_qualification|manual_engineering|network_model|field_survey');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^CQ[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualification Request Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_business_glossary_term' = 'Qualification Result');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_result` SET TAGS ('dbx_value_regex' = 'serviceable|not_serviceable|conditionally_serviceable|pending_verification|requires_engineering');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|expired|cancelled');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `requesting_system` SET TAGS ('dbx_business_glossary_term' = 'Requesting System');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `static_ip_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Static Internet Protocol (IP) Available Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_qualification` ALTER COLUMN `technologies_checked` SET TAGS ('dbx_business_glossary_term' = 'Technologies Checked');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `address_validation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `address_validation_event_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `address_validation_event_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Operator Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `reverification_of_address_validation_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `api_response_code` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Response Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `api_response_message` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Response Message');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_city` SET TAGS ('dbx_business_glossary_term' = 'Corrected City Name');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_country_code` SET TAGS ('dbx_business_glossary_term' = 'Corrected Country Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Corrected Postal Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_state_province` SET TAGS ('dbx_business_glossary_term' = 'Corrected State or Province Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_name` SET TAGS ('dbx_business_glossary_term' = 'Corrected Street Name');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_number` SET TAGS ('dbx_business_glossary_term' = 'Corrected Street Number');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_type` SET TAGS ('dbx_business_glossary_term' = 'Corrected Street Type');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_street_type` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `corrected_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Corrected Unit Number');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `dpv_confirmation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Validation (DPV) Confirmation Indicator');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `dpv_confirmation_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|S|D');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_accuracy_level` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Accuracy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Latitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Longitude Coordinate');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `geocoding_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `input_address_string` SET TAGS ('dbx_business_glossary_term' = 'Input Address String');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `input_address_string` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `input_address_string` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Match Confidence Score');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'exact|partial|interpolated|no_match|ambiguous|corrected');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `matched_address_string` SET TAGS ('dbx_business_glossary_term' = 'Matched Address String');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `matched_address_string` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `matched_address_string` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `residential_delivery_indicator` SET TAGS ('dbx_business_glossary_term' = 'Residential Delivery Indicator');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `residential_delivery_indicator` SET TAGS ('dbx_value_regex' = 'residential|commercial|unknown');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Validation Cost Amount');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Validation Cost Currency Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Validation Duration in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|ambiguous|corrected|unverified|pending');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_validation_event` ALTER COLUMN `validation_trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Trigger Source');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `coverage_area_version_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Version Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `previous_coverage_area_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|superseded');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area (Square Kilometers)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `change_reason` SET TAGS ('dbx_value_regex' = 'network_expansion|cell_reconfig|decommission|model_update|drive_test_correction|regulatory_mandate');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|marginal|fringe|no_coverage');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'rf_propagation_model|drive_test|crowd_sourced|vendor_planning_tool|regulatory_submission|hybrid');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `indoor_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Indoor Coverage Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `mobility_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobility Support Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `model_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Model Confidence Score');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `population_covered` SET TAGS ('dbx_business_glossary_term' = 'Population Covered');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `predicted_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Predicted Signal Strength (dBm)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `predicted_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Predicted Throughput (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `premises_covered` SET TAGS ('dbx_business_glossary_term' = 'Premises Covered');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `spectrum_band` SET TAGS ('dbx_business_glossary_term' = 'Spectrum Band');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `version_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `version_notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_area_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `network_rollout_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Network Rollout Zone Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Contractor Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Project Manager Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `parent_network_rollout_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `actual_capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Capital Expenditure (CAPEX) Amount');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `actual_capex_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `actual_premises_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Premises Passed Count');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Zone Area in Square Kilometers (km²)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `business_location_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Business Location Count Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Zone Centroid Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Zone Centroid Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `environmental_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Clearance Status');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `environmental_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|conditional|denied');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `estimated_capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX) Amount');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `estimated_capex_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'commercial|government_subsidy|universal_service|public_private_partnership|internal_capex');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Zone Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `household_count_estimate` SET TAGS ('dbx_business_glossary_term' = 'Household Count Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `median_household_income` SET TAGS ('dbx_business_glossary_term' = 'Median Household Income');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `median_household_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `network_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Network Activation Date');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rollout Zone Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `permit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Date');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `planned_premises_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Premises Passed Count');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Zone Population Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Rollout Priority Level');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `programme_name` SET TAGS ('dbx_business_glossary_term' = 'Rollout Programme Name');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Project Risk Rating');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `rollout_phase` SET TAGS ('dbx_business_glossary_term' = 'Rollout Phase');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `subsidy_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Award Amount');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `subsidy_award_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `subsidy_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `target_technology` SET TAGS ('dbx_business_glossary_term' = 'Target Network Technology');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `underserved_premises_count` SET TAGS ('dbx_business_glossary_term' = 'Underserved Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `unserved_premises_count` SET TAGS ('dbx_business_glossary_term' = 'Unserved Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Rollout Zone Code');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Rollout Zone Name');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Rollout Zone Status');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Rollout Zone Type');
ALTER TABLE `telecommunication_ecm`.`location`.`network_rollout_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'FTTP_greenfield|FTTP_brownfield|5G_densification|HFC_upgrade|FWA_deployment|FTTN_remediation');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `premises_passed_id` SET TAGS ('dbx_business_glossary_term' = 'Premises Passed Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `field_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Field Survey Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `network_rollout_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Rollout Zone Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `superseded_premises_passed_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `activation_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Readiness Status');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `activation_readiness_status` SET TAGS ('dbx_value_regex' = 'ready_to_connect|pending_construction|awaiting_permit|blocked|under_review');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `business_premise_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Premise Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `competitive_overlap_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Overlap Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `connection_cost_tier` SET TAGS ('dbx_business_glossary_term' = 'Connection Cost Tier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `connection_cost_tier` SET TAGS ('dbx_value_regex' = 'standard|medium|high|custom');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `construction_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Completion Date');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'field_survey|oss_system|contractor_report|gis_import|customer_inquiry');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `distance_to_network_metres` SET TAGS ('dbx_business_glossary_term' = 'Distance to Network (Metres)');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `estimated_connection_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Connection Cost');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `estimated_connection_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `franchise_area_code` SET TAGS ('dbx_business_glossary_term' = 'Franchise Area Code');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `maximum_service_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Service Speed (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `mdu_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dwelling Unit (MDU) Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `network_element_type` SET TAGS ('dbx_business_glossary_term' = 'Network Element Type');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `pass_date` SET TAGS ('dbx_business_glossary_term' = 'Pass Date');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `pass_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pass Reference Number');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `pass_type` SET TAGS ('dbx_business_glossary_term' = 'Pass Type');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `pass_type` SET TAGS ('dbx_value_regex' = 'aerial_drop_available|underground_duct_available|active_port_available|on_demand_only');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `port_capacity_available` SET TAGS ('dbx_business_glossary_term' = 'Port Capacity Available');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|best_effort');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|under_review');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|remote');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `roaming_zone` SET TAGS ('dbx_business_glossary_term' = 'Roaming Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `serviceable_flag` SET TAGS ('dbx_business_glossary_term' = 'Serviceable Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `subsidy_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `telecommunication_ecm`.`location`.`premises_passed` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'field_inspection|oss_system|gis_analysis|contractor_report|customer_request');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `cell_coverage_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Cell Coverage Footprint Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Network (RAN) Cell Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `superseded_cell_coverage_footprint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `antenna_gain_dbi` SET TAGS ('dbx_business_glossary_term' = 'Antenna Gain (Decibels Isotropic)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `antenna_height_meters` SET TAGS ('dbx_business_glossary_term' = 'Antenna Height Above Ground Level (Meters)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `azimuth_degrees` SET TAGS ('dbx_business_glossary_term' = 'Antenna Azimuth (Degrees)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `beamwidth_horizontal_degrees` SET TAGS ('dbx_business_glossary_term' = 'Antenna Horizontal Beamwidth (Degrees)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `beamwidth_vertical_degrees` SET TAGS ('dbx_business_glossary_term' = 'Antenna Vertical Beamwidth (Degrees)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `clutter_type` SET TAGS ('dbx_business_glossary_term' = 'Terrain Clutter Type');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `clutter_type` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|dense_urban|open');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Coverage Prediction Confidence Level (Percent)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Coverage Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Footprint Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Footprint Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `footprint_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Footprint Code');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `footprint_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `footprint_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Footprint Status');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `footprint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|deprecated');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Band');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `generation_method` SET TAGS ('dbx_business_glossary_term' = 'Coverage Generation Method');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `generation_method` SET TAGS ('dbx_value_regex' = 'propagation_model|drive_test|crowdsourced_rf');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Coverage Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `indoor_penetration_depth_db` SET TAGS ('dbx_business_glossary_term' = 'Indoor Penetration Depth (Decibels)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `measurement_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sample Count');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Footprint Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `outdoor_coverage_area_sq_km` SET TAGS ('dbx_business_glossary_term' = 'Outdoor Coverage Area (Square Kilometers)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `population_covered` SET TAGS ('dbx_business_glossary_term' = 'Population Covered');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `predicted_rsrp_dbm` SET TAGS ('dbx_business_glossary_term' = 'Predicted Reference Signal Received Power (RSRP) in Decibels-Milliwatt (dBm)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `predicted_sinr_db` SET TAGS ('dbx_business_glossary_term' = 'Predicted Signal-to-Interference-plus-Noise Ratio (SINR) in Decibels (dB)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `propagation_model_version` SET TAGS ('dbx_business_glossary_term' = 'Propagation Model Version');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Technology (RAT) Type');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = '2G|3G|4G|5G_NSA|5G_SA');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `tilt_degrees` SET TAGS ('dbx_business_glossary_term' = 'Antenna Tilt (Degrees)');
ALTER TABLE `telecommunication_ecm`.`location`.`cell_coverage_footprint` ALTER COLUMN `transmit_power_dbm` SET TAGS ('dbx_business_glossary_term' = 'Transmit Power (Decibels-Milliwatt)');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `duct_route_id` SET TAGS ('dbx_business_glossary_term' = 'Duct Route Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `geo_point_id` SET TAGS ('dbx_business_glossary_term' = 'Start Geographic Point Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `continuation_duct_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `available_subduct_count` SET TAGS ('dbx_business_glossary_term' = 'Available Sub-Duct Count');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `construction_method` SET TAGS ('dbx_business_glossary_term' = 'Construction Method');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `construction_method` SET TAGS ('dbx_value_regex' = 'open_trench|directional_drill|plowing|boring|microtrenching');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `depth_metres` SET TAGS ('dbx_business_glossary_term' = 'Depth in Metres');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `duct_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Duct Diameter in Millimetres');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `duct_material` SET TAGS ('dbx_business_glossary_term' = 'Duct Material');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `duct_material` SET TAGS ('dbx_value_regex' = 'HDPE|PVC|concrete|steel|fiberglass|asbestos_cement');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `gis_layer_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Layer Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `number_of_subducts` SET TAGS ('dbx_business_glossary_term' = 'Number of Sub-Ducts');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `occupied_subduct_count` SET TAGS ('dbx_business_glossary_term' = 'Occupied Sub-Duct Count');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|IRU|joint_use|municipal');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `replacement_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `replacement_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `road_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Road Authority Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_name` SET TAGS ('dbx_business_glossary_term' = 'Route Name');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_priority` SET TAGS ('dbx_business_glossary_term' = 'Route Priority');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_status` SET TAGS ('dbx_business_glossary_term' = 'Route Status');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_status` SET TAGS ('dbx_value_regex' = 'active|planned|under_construction|decommissioned|damaged|maintenance');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_type` SET TAGS ('dbx_business_glossary_term' = 'Route Type');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `route_type` SET TAGS ('dbx_value_regex' = 'underground_duct|aerial_span|submarine|direct_buried|building_riser|hybrid');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `total_length_metres` SET TAGS ('dbx_business_glossary_term' = 'Total Length in Metres');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Traffic Impact Level');
ALTER TABLE `telecommunication_ecm`.`location`.`duct_route` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `address_alias_id` SET TAGS ('dbx_business_glossary_term' = 'Address Alias Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `address_alias_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `address_alias_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Canonical Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `canonical_address_alias_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `address_format_standard` SET TAGS ('dbx_business_glossary_term' = 'Address Format Standard');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `alias_identifier` SET TAGS ('dbx_business_glossary_term' = 'Alias Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `alias_type` SET TAGS ('dbx_business_glossary_term' = 'Alias Type');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `alias_value` SET TAGS ('dbx_business_glossary_term' = 'Alias Value');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `deduplication_group_code` SET TAGS ('dbx_business_glossary_term' = 'Deduplication Group Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `geographic_accuracy_level` SET TAGS ('dbx_business_glossary_term' = 'Geographic Accuracy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `is_primary_alias` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Alias Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `match_method` SET TAGS ('dbx_business_glossary_term' = 'Match Method');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `match_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Match Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `migration_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Migration Batch Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|conflict|orphaned|duplicate');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `telecommunication_ecm`.`location`.`address_alias` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `geographic_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `parent_zone_geographic_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Zone Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `parent_geographic_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `applicable_product_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Types');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometers (km²)');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `average_income_level` SET TAGS ('dbx_business_glossary_term' = 'Average Income Level');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `average_income_level` SET TAGS ('dbx_value_regex' = 'high|medium_high|medium|medium_low|low');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `black_spot_programme_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Programme Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `business_premises_count` SET TAGS ('dbx_business_glossary_term' = 'Business Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intensity');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `competitive_intensity` SET TAGS ('dbx_value_regex' = 'high|medium|low|monopoly');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `dispatch_radius_km` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Radius in Kilometers (km)');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `emergency_services_routing_code` SET TAGS ('dbx_business_glossary_term' = 'Emergency Services Routing Code');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `emergency_services_routing_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `franchise_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `network_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage Type');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Population Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|distance_based|tier_based|usage_based|hybrid');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `qos_class` SET TAGS ('dbx_business_glossary_term' = 'Quality of Service (QoS) Class');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `qos_class` SET TAGS ('dbx_value_regex' = 'premium|standard|basic|best_effort');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `regulatory_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `roaming_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `sla_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time in Minutes');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `spectrum_license_reference` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `uso_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Universal Service Obligation (USO) Eligible Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|deprecated|suspended|planned');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_tier` SET TAGS ('dbx_business_glossary_term' = 'Zone Tier');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_tier` SET TAGS ('dbx_value_regex' = 'metro|regional|rural|remote|urban|suburban');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `telecommunication_ecm`.`location`.`geographic_zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'pricing_zone|regulatory_zone|roaming_zone|emergency_services_zone|disaster_recovery_zone|spectrum_zone');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_event_id` SET TAGS ('dbx_business_glossary_term' = 'Location Change Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `primary_change_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `primary_change_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `rollback_reference_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reference Event Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `reversal_change_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_notes` SET TAGS ('dbx_business_glossary_term' = 'Change Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_source` SET TAGS ('dbx_business_glossary_term' = 'Change Source');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_source` SET TAGS ('dbx_value_regex' = 'system_automated|manual_correction|survey_update|authority_update|bulk_import');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'create|update|decommission|merge|split|reclassify');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `changed_field_name` SET TAGS ('dbx_business_glossary_term' = 'Changed Field Name');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `geocoding_confidence` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Confidence');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `impact_scope` SET TAGS ('dbx_business_glossary_term' = 'Impact Scope');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `impact_scope` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `location_entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Location Entity Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `location_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Location Entity Type');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `location_entity_type` SET TAGS ('dbx_value_regex' = 'address|premise|site|coverage_area|geo_boundary|exchange');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `old_value` SET TAGS ('dbx_business_glossary_term' = 'Old Value');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `validation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Message');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `telecommunication_ecm`.`location`.`change_event` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `black_spot_id` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Nearest Serviceable Location Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Nearest Serving Cell Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `merged_into_black_spot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `affected_population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Affected Population Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `affected_premises_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Programme Approval Date');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Area Square Kilometers');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `black_spot_name` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Location Name');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `black_spot_type` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Coverage Deficiency Type');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `black_spot_type` SET TAGS ('dbx_value_regex' = 'mobile_no_coverage|mobile_poor_coverage|broadband_no_service|broadband_underserved|fixed_line_unavailable|mixed_deficiency');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Centroid Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Centroid Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `community_petition_flag` SET TAGS ('dbx_business_glossary_term' = 'Community Petition Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `distance_to_serviceable_location_km` SET TAGS ('dbx_business_glossary_term' = 'Distance to Nearest Serviceable Location Kilometers');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `economic_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Economic Zone Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `environmental_constraints` SET TAGS ('dbx_business_glossary_term' = 'Environmental Constraints');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Funding Amount');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `funding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency Code');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `funding_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Business Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Coverage Survey Date');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `measured_download_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Measured Download Speed Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `measured_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Measured Signal Strength Decibel-Milliwatts (dBm)');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `measured_upload_speed_mbps` SET TAGS ('dbx_business_glossary_term' = 'Measured Upload Speed Megabits Per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Nomination Date');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `nomination_source` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Nomination Source');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `nomination_source` SET TAGS ('dbx_value_regex' = 'community|government|operator|regulator|third_party|internal_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Remediation Priority Level');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `programme_reference` SET TAGS ('dbx_business_glossary_term' = 'Government Programme Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `programme_status` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Programme Status');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|superseded|deleted');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Black Spot Resolution Date');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `resolving_technology` SET TAGS ('dbx_business_glossary_term' = 'Resolving Technology Type');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Location Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Coverage Survey Method');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'drive_test|walk_test|crowdsourced|propagation_model|satellite_imagery|community_report');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `target_service_level` SET TAGS ('dbx_business_glossary_term' = 'Target Service Level');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `terrain_type` SET TAGS ('dbx_business_glossary_term' = 'Terrain Type Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`black_spot` ALTER COLUMN `uso_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Universal Service Obligation (USO) Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` SET TAGS ('dbx_subdomain' = 'geographic_data');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `address_geocode_id` SET TAGS ('dbx_business_glossary_term' = 'Address Geocode Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `address_geocode_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `address_geocode_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `superseded_address_geocode_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `accuracy_level` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `accuracy_level` SET TAGS ('dbx_value_regex' = 'rooftop|parcel_centroid|street_interpolated|street_centroid|suburb_centroid|postcode_centroid');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `census_block_reference` SET TAGS ('dbx_business_glossary_term' = 'Census Block Reference (US)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Geocode Confidence Score');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `crs_code` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System (CRS) Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Meters)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_identifier` SET TAGS ('dbx_business_glossary_term' = 'Geocode Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_method` SET TAGS ('dbx_business_glossary_term' = 'Geocode Method');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_method` SET TAGS ('dbx_value_regex' = 'GNAF_match|USPS_match|HERE_API|Google_API|manual_survey|GPS_capture');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Geocode Quality Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_quality_flag` SET TAGS ('dbx_value_regex' = 'high|medium|low|unverified');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_status` SET TAGS ('dbx_business_glossary_term' = 'Geocode Status');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocode_status` SET TAGS ('dbx_value_regex' = 'active|superseded|rejected|pending_review|expired');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocoding_provider` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Provider');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `geocoding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Geocoding Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `horizontal_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Accuracy (Meters)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `is_authoritative` SET TAGS ('dbx_business_glossary_term' = 'Is Authoritative Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (WGS84)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (WGS84)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Address Match Score');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `mesh_block_reference` SET TAGS ('dbx_business_glossary_term' = 'Mesh Block Reference (ABS)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `network_coverage_area_code` SET TAGS ('dbx_business_glossary_term' = 'Network Coverage Area Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `output_area_reference` SET TAGS ('dbx_business_glossary_term' = 'Output Area Reference (UK)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `plus_code` SET TAGS ('dbx_business_glossary_term' = 'Plus Code (Open Location Code)');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'field_survey|gps_capture|customer_confirmation|automated_validation|third_party_verification');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `what3words_address` SET TAGS ('dbx_business_glossary_term' = 'What3Words Address');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `what3words_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`address_geocode` ALTER COLUMN `what3words_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `infrastructure_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Corridor Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `branched_from_infrastructure_corridor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `annual_opex_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Expenditure (OPEX) in United States Dollars');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `annual_opex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `backup_route_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Route Available Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `capacity_bandwidth_gbps` SET TAGS ('dbx_business_glossary_term' = 'Corridor Capacity Bandwidth (Gigabits per Second)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `capacity_fiber_count` SET TAGS ('dbx_business_glossary_term' = 'Corridor Capacity Fiber Count');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Corridor Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Corridor Business Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_name` SET TAGS ('dbx_business_glossary_term' = 'Corridor Name');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_owner` SET TAGS ('dbx_business_glossary_term' = 'Corridor Owner');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_status` SET TAGS ('dbx_business_glossary_term' = 'Corridor Lifecycle Status');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_status` SET TAGS ('dbx_value_regex' = 'active|planned|under_construction|decommissioned|suspended|maintenance');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_type` SET TAGS ('dbx_business_glossary_term' = 'Corridor Type');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `corridor_type` SET TAGS ('dbx_value_regex' = 'long_haul_fiber|submarine_cable|microwave_los|power_line_colocated|rail_corridor|highway_corridor');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Corridor Decommissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `end_location_reference` SET TAGS ('dbx_business_glossary_term' = 'End Location Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Corridor Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Installation Cost (United States Dollars)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `installation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `interconnect_points_count` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Points Count');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `iru_holder` SET TAGS ('dbx_business_glossary_term' = 'Indefeasible Right of Use (IRU) Holder');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inspection Date');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `mttr_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) Target (Hours)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Corridor Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `permit_authority` SET TAGS ('dbx_business_glossary_term' = 'Permitting Authority');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `protection_type` SET TAGS ('dbx_business_glossary_term' = 'Corridor Protection Type');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `protection_type` SET TAGS ('dbx_value_regex' = 'unprotected|ring_protected|diverse_route|mesh_protected|dual_homing');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `right_of_way_type` SET TAGS ('dbx_business_glossary_term' = 'Right of Way (ROW) Type');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `right_of_way_type` SET TAGS ('dbx_value_regex' = 'owned|leased|easement|shared_utility|public_right_of_way|licensed');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `route_diversity_group` SET TAGS ('dbx_business_glossary_term' = 'Route Diversity Group');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `seismic_risk_zone` SET TAGS ('dbx_business_glossary_term' = 'Seismic Risk Zone');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `seismic_risk_zone` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `start_location_reference` SET TAGS ('dbx_business_glossary_term' = 'Start Location Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `strategic_importance_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `total_length_km` SET TAGS ('dbx_business_glossary_term' = 'Total Corridor Length (Kilometers)');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Corridor Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Vendor Name');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `weather_exposure_level` SET TAGS ('dbx_business_glossary_term' = 'Weather Exposure Level');
ALTER TABLE `telecommunication_ecm`.`location`.`infrastructure_corridor` ALTER COLUMN `weather_exposure_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|extreme');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `mdu_building_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dwelling Unit (MDU) Building Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `exchange_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `location_address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `location_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `location_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `element_id` SET TAGS ('dbx_business_glossary_term' = 'Network Element Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `parent_mdu_building_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `body_corporate_reference` SET TAGS ('dbx_business_glossary_term' = 'Body Corporate Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Building Commissioning Date');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_height_meters` SET TAGS ('dbx_business_glossary_term' = 'Building Height in Meters');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_manager_contact` SET TAGS ('dbx_business_glossary_term' = 'Building Manager Contact');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_manager_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_manager_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Building Owner Name');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_status` SET TAGS ('dbx_business_glossary_term' = 'Building Status');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_status` SET TAGS ('dbx_value_regex' = 'planned|under_construction|commissioned|operational|decommissioned|demolished');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_type` SET TAGS ('dbx_business_glossary_term' = 'Building Type');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `building_type` SET TAGS ('dbx_value_regex' = 'residential_apartment|commercial_office|mixed_use|shopping_centre|hotel|student_accommodation');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `connected_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Connected Unit Count');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `fiber_entry_point` SET TAGS ('dbx_business_glossary_term' = 'Fiber Entry Point');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `five_g_small_cell_installed` SET TAGS ('dbx_business_glossary_term' = '5G Small Cell Installed Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `footprint_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Footprint Area in Square Meters');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `idf_count` SET TAGS ('dbx_business_glossary_term' = 'Intermediate Distribution Frame (IDF) Count');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `in_building_network_type` SET TAGS ('dbx_business_glossary_term' = 'In-Building Network Type');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `in_building_network_type` SET TAGS ('dbx_value_regex' = 'FTTP_riser|HFC_riser|VDSL_riser|WiFi_only|5G_small_cell');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `last_site_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Site Survey Date');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `mdf_location` SET TAGS ('dbx_business_glossary_term' = 'Main Distribution Frame (MDF) Location');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `mdu_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dwelling Unit (MDU) Agreement Status');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `mdu_agreement_status` SET TAGS ('dbx_value_regex' = 'agreement_in_place|negotiating|no_agreement|expired|terminated');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `parking_availability` SET TAGS ('dbx_business_glossary_term' = 'Parking Availability');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `parking_availability` SET TAGS ('dbx_value_regex' = 'on_site|street_parking|no_parking|permit_required');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `power_backup_available` SET TAGS ('dbx_business_glossary_term' = 'Power Backup Available Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `riser_available_capacity` SET TAGS ('dbx_business_glossary_term' = 'Riser Available Capacity');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `riser_capacity` SET TAGS ('dbx_business_glossary_term' = 'Riser Capacity');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `serviceable_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Serviceable Unit Count');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `total_floors` SET TAGS ('dbx_business_glossary_term' = 'Total Floors');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `total_tenancies` SET TAGS ('dbx_business_glossary_term' = 'Total Tenancies');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `telecommunication_ecm`.`location`.`mdu_building` ALTER COLUMN `wifi_coverage_available` SET TAGS ('dbx_business_glossary_term' = 'WiFi Coverage Available Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` SET TAGS ('dbx_subdomain' = 'network_planning');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `coverage_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Gap Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `administrative_region_id` SET TAGS ('dbx_business_glossary_term' = 'Administrative Region Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `split_from_coverage_gap_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `affected_population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Affected Population Estimate');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `affected_premises_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Premises Count');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Kilometers (km²)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `customer_complaint_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Complaint Count');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `estimated_remediation_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost in United States Dollars (USD)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `estimated_remediation_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_identifier` SET TAGS ('dbx_business_glossary_term' = 'Gap Business Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_name` SET TAGS ('dbx_business_glossary_term' = 'Coverage Gap Name');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Gap Severity Level');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Gap Status');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Gap Type');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'no_4g_coverage|no_5g_coverage|no_broadband|below_minimum_speed|poor_indoor_coverage|no_emergency_coverage');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well-Known Text (WKT)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Identification Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `identification_method` SET TAGS ('dbx_business_glossary_term' = 'Gap Identification Method');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `identification_method` SET TAGS ('dbx_value_regex' = 'propagation_model|drive_test|customer_complaint_cluster|regulatory_audit|crowdsourced_data|network_kpi_analysis');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `measured_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Measured Signal Strength in Decibel-Milliwatts (dBm)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `measured_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Measured Throughput in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `minimum_signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Signal Strength in Decibel-Milliwatts (dBm)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `minimum_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Minimum Throughput in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Coverage Gap Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Priority Score');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `programme_reference` SET TAGS ('dbx_business_glossary_term' = 'Programme Reference Code');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `remediation_method` SET TAGS ('dbx_business_glossary_term' = 'Remediation Method');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `remediation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Status');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `remediation_plan_status` SET TAGS ('dbx_value_regex' = 'unplanned|planned|funded|in_progress|resolved');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `resolution_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Verification Method');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `universal_service_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Universal Service Obligation (USO) Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`coverage_gap` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Gap Validation Date');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` SET TAGS ('dbx_subdomain' = 'geographic_data');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `reference_code_id` SET TAGS ('dbx_business_glossary_term' = 'Location Reference Code Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `parent_reference_code_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `alternate_code_value` SET TAGS ('dbx_business_glossary_term' = 'Alternate Code Value');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `code_description` SET TAGS ('dbx_business_glossary_term' = 'Code Description');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `code_label` SET TAGS ('dbx_business_glossary_term' = 'Code Label');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `code_set_name` SET TAGS ('dbx_business_glossary_term' = 'Code Set Name');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `code_set_name` SET TAGS ('dbx_value_regex' = 'address_type|premise_type|site_type|zone_type|region_type|coverage_tier');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `code_value` SET TAGS ('dbx_business_glossary_term' = 'Code Value');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `customer_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Facing Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order Sequence');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry End Date');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `governing_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Standard Reference');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `network_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Planning Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `parent_code_value` SET TAGS ('dbx_business_glossary_term' = 'Parent Code Value');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `replacement_code_value` SET TAGS ('dbx_business_glossary_term' = 'Replacement Code Value');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `service_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Delivery Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`reference_code` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `drive_test_record_id` SET TAGS ('dbx_business_glossary_term' = 'Drive Test Record Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tester Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Cell Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `test_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Test Campaign Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `test_route_id` SET TAGS ('dbx_business_glossary_term' = 'Test Route Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `retest_of_drive_test_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `altitude_meters` SET TAGS ('dbx_business_glossary_term' = 'Altitude in Meters');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `call_setup_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Call Setup Success Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `cqi` SET TAGS ('dbx_business_glossary_term' = 'Channel Quality Indicator (CQI)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `data_session_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Session Active Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `device_imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `device_imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `device_imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `earfcn` SET TAGS ('dbx_business_glossary_term' = 'Evolved Absolute Radio Frequency Channel Number (EARFCN)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `handover_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Handover Event Flag');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `horizontal_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Accuracy in Meters');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency in Milliseconds (ms)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'drive_test|walk_test|stationary_indoor');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|suspect|calibrated');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `network_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Network Operator Code');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `pci` SET TAGS ('dbx_business_glossary_term' = 'Physical Cell Identifier (PCI)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `rsrp_dbm` SET TAGS ('dbx_business_glossary_term' = 'Reference Signal Received Power (RSRP) in dBm');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `rsrq_db` SET TAGS ('dbx_business_glossary_term' = 'Reference Signal Received Quality (RSRQ) in dB');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `rssi_dbm` SET TAGS ('dbx_business_glossary_term' = 'Received Signal Strength Indicator (RSSI) in dBm');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `sinr_db` SET TAGS ('dbx_business_glossary_term' = 'Signal to Interference plus Noise Ratio (SINR) in dB');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `speed_kmh` SET TAGS ('dbx_business_glossary_term' = 'Speed in Kilometers per Hour (km/h)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Radio Access Technology (RAT) Type');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = '2G|3G|4G|5G');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `test_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Type');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `throughput_downlink_mbps` SET TAGS ('dbx_business_glossary_term' = 'Throughput Downlink in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `throughput_uplink_mbps` SET TAGS ('dbx_business_glossary_term' = 'Throughput Uplink in Megabits per Second (Mbps)');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `telecommunication_ecm`.`location`.`drive_test_record` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_value_regex' = 'clear|cloudy|rain|snow|fog|storm');
ALTER TABLE `telecommunication_ecm`.`location`.`test_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`test_campaign` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`test_campaign` ALTER COLUMN `test_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Test Campaign Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`test_campaign` ALTER COLUMN `retest_of_test_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ALTER COLUMN `test_route_id` SET TAGS ('dbx_business_glossary_term' = 'Test Route Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`test_route` ALTER COLUMN `derived_from_test_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` ALTER COLUMN `field_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Field Survey Identifier');
ALTER TABLE `telecommunication_ecm`.`location`.`field_survey` ALTER COLUMN `follow_up_field_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
