-- Schema for Domain: property | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`property` COMMENT 'Core operational domain and master registry for all real estate assets — commercial, residential, and mixed-use properties, buildings, land parcels, units, and spaces. Owns physical attributes (GLA, NLA, SQF/SQM, FAR), building specifications, GIS coordinates, zoning classifications, COO status, LEED/BREEAM certifications, BIM references, title information, and ownership hierarchy. Single source of truth for every asset the enterprise owns, manages, or brokers.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique system-generated surrogate identifier for each real estate asset record. Primary key for the asset master registry.',
    `address_id` BIGINT COMMENT 'Foreign key linking to property.address. Business justification: Asset currently embeds address fields (street_address, city, state_code, postal_code, country_code) directly. The address product is the single source of truth for standardized addresses with USPS val',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: All asset-level financial reporting (acquisition cost, NOI, valuations) requires a linked currency reference for multi-currency portfolio management, FX translation, and investor reporting. currency_c',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Assets are located within geographic market/submarket hierarchies used for portfolio roll-up reporting, market allocation analysis, and investment strategy segmentation. market and submarket are denor',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: An assets primary jurisdiction determines which regulatory obligations, permits, and ESG reporting requirements apply. This is the foundational compliance scoping link — every real estate compliance ',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (LLC, LP, REIT subsidiary, etc.) that holds title to this asset. Required for financial consolidation and SEC/FASB reporting.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which this asset is assigned. Supports portfolio-level aggregation and reporting.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Every asset is classified by property type (office, retail, industrial, multifamily) for NCREIF benchmarking, REIT segment reporting, and NOI analysis. asset_class and asset_subtype are denormalized r',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Tenure type (freehold, leasehold, ground lease) is fundamental to asset valuation methodology, CMBS eligibility, REIT compliance, and title insurance requirements. ownership_type on asset is a denorma',
    `zoning_code_id` BIGINT COMMENT 'Foreign key linking to reference.zoning_code. Business justification: Assets are subject to zoning regulations governing permitted uses, FAR, and development rights — critical for entitlement analysis, development underwriting, and land use compliance. zoning_code on as',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total purchase price paid to acquire the asset including closing costs, transfer taxes, and capitalized transaction costs. Establishes the cost basis for depreciation, LTV calculations, and gain/loss on disposition.',
    `acquisition_date` DATE COMMENT 'The date on which the enterprise acquired title or controlling interest in the asset. Establishes the holding period for IRR calculations, depreciation start, and capital gains tax basis.',
    `apn` STRING COMMENT 'Assessor Parcel Number assigned by the county assessors office. Uniquely identifies the land parcel for property tax assessment, title search, and GIS integration.',
    `asset_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the asset as assigned in the property management system (e.g., Yardi property code). Used for cross-system reconciliation and reporting.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `asset_name` STRING COMMENT 'The canonical marketing or operational name of the property (e.g., One Embarcadero Center, Riverside Apartments). Used as the primary human-readable identifier across all systems.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the asset within the enterprise portfolio. Drives inclusion/exclusion in NOI reporting, REIT FFO calculations, and disposition tracking.. Valid values are `active|disposed|under_development|held_for_sale|held_for_investment`',
    `bim_model_reference` STRING COMMENT 'Reference identifier or URL to the BIM model file for this asset stored in the document management system (e.g., Procore). Enables digital twin integration, construction oversight, and facility management.',
    `breeam_rating` STRING COMMENT 'BREEAM sustainability rating for the building, primarily applicable to UK and European assets. Supports ESG reporting and international investor sustainability requirements.. Valid values are `outstanding|excellent|very_good|good|pass|unclassified`',
    `coo_date` DATE COMMENT 'Date on which the Certificate of Occupancy was issued by the local building authority. Used for lease commencement eligibility and regulatory compliance tracking.',
    `coo_status` STRING COMMENT 'Current status of the Certificate of Occupancy issued by the local building authority. Required for legal occupancy, lease commencement, and regulatory compliance.. Valid values are `issued|pending|not_required|expired|revoked`',
    `costar_property_number` STRING COMMENT 'CoStar Suites proprietary property identifier for this asset. Enables direct linkage to CoStar market data, comparable transactions, and analytics feeds.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system. Supports data lineage, audit trail, and SOX compliance requirements.',
    `disposition_date` DATE COMMENT 'The date on which the asset was sold, transferred, or otherwise disposed of. Null for active assets. Used to calculate holding period, realized IRR, and remove asset from active portfolio reporting.',
    `energy_star_score` STRING COMMENT 'EPA ENERGY STAR score (1–100) measuring the assets energy efficiency relative to similar buildings. Used for ESG benchmarking, utility cost management, and green certification eligibility.',
    `far` DECIMAL(18,2) COMMENT 'Floor Area Ratio — the ratio of total building floor area to the area of the land parcel. Determines maximum allowable development density under zoning regulations. Key input for development feasibility and entitlement analysis.',
    `fips_code` STRING COMMENT 'Five-digit FIPS county code identifying the county in which the asset is located. Used for geographic aggregation, regulatory reporting, and HUD compliance.. Valid values are `^[0-9]{5}$`',
    `gla_sqft` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area of the asset measured in square feet. The primary size metric for commercial properties used in rent PSF calculations, CAP rate analysis, and lease administration.',
    `is_encumbered` BOOLEAN COMMENT 'Indicates whether the asset is subject to a mortgage, lien, deed of trust, or other encumbrance. Flags assets with debt obligations for LTV monitoring and disposition clearance requirements.',
    `latitude` DECIMAL(18,2) COMMENT 'WGS-84 decimal degree latitude coordinate of the assets primary location. Enables GIS mapping, spatial analytics, and proximity-based market analysis.',
    `leed_certification` STRING COMMENT 'LEED certification level awarded by the U.S. Green Building Council. Drives ESG reporting, green lease premiums, and investor sustainability disclosures.. Valid values are `certified|silver|gold|platinum|not_certified`',
    `legal_description` STRING COMMENT 'Full legal description of the property as recorded in the deed and title documents (metes and bounds, lot/block, or subdivision description). Required for ALTA title insurance and conveyancing.',
    `longitude` DECIMAL(18,2) COMMENT 'WGS-84 decimal degree longitude coordinate of the assets primary location. Enables GIS mapping, spatial analytics, and proximity-based market analysis.',
    `mls_number` STRING COMMENT 'Unique identifier assigned to the property in the Multiple Listing Service. Used for residential brokerage, market comparables, and CoStar/MLS data syndication.',
    `nla_sqft` DECIMAL(18,2) COMMENT 'Net Leasable Area excluding common areas, mechanical rooms, and structural elements. Used for NNN lease calculations, tenant billing, and CAM reconciliation.',
    `total_floors` STRING COMMENT 'Total number of above-grade floors in the building. Used for building specification reporting, fire safety compliance, and elevator/HVAC system planning.',
    `total_units` STRING COMMENT 'Total number of leasable units within the asset (applicable to multifamily, self-storage, and hospitality assets). Used for occupancy rate calculations and per-unit financial benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record. Used for change data capture, data lineage tracking, and audit compliance.',
    `year_built` STRING COMMENT 'The calendar year in which the building was originally constructed and received its Certificate of Occupancy. Used for depreciation schedules, capital planning, and valuation age adjustments.',
    `year_renovated` STRING COMMENT 'The calendar year of the most recent major renovation or capital improvement. Used for effective age adjustments in appraisals and CAPEX planning cycles.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master registry and single source of truth for every real estate asset the enterprise owns, manages, or brokers — the root anchor for the entire property domain. Each record represents one distinct property (commercial, residential, or mixed-use). Captures canonical identity: asset class (office, retail, industrial, multifamily, land, hospitality, self-storage), portfolio assignment, legal entity ownership, acquisition date, disposition date, asset status (active, disposed, under development, held for sale), GIS coordinates (latitude/longitude), legal description, APN (Assessor Parcel Number), FIPS code, market/submarket classification, and BIM model reference. All other property-domain products reference this entity as their parent.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`building` (
    `building_id` BIGINT COMMENT 'Unique surrogate identifier for the building record in the enterprise data platform. Primary key for the building master data product.',
    `address_id` BIGINT COMMENT 'Foreign key linking to property.address. Business justification: Building currently embeds address fields (address_line1, address_line2, city, state_province, postal_code, country_code) directly on the record. The address product is the authoritative standardized a',
    `asset_id` BIGINT COMMENT 'Reference to the parent real estate asset (property) to which this building belongs. Supports one-to-many asset-to-building relationships for campuses and mixed-use developments.',
    `building_class_id` BIGINT COMMENT 'Foreign key linking to reference.building_class. Business justification: Building class (A/B/C) drives rent benchmarking, tenant targeting, investment grade classification, and REIT eligibility assessment. building_class on building is a denormalized representation of the ',
    `construction_type_id` BIGINT COMMENT 'Foreign key linking to reference.construction_type. Business justification: Construction type determines IBC fire resistance ratings, insurance classification (ISO construction class), and structural system compliance — used in property insurance underwriting and building per',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Each building is governed by a specific jurisdiction that determines applicable building codes, fire codes, ADA requirements, and permit authorities. This link is essential for scoping compliance requ',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Buildings are classified by property type for leasing strategy, rent benchmarking, and investment reporting. property_type on building is a denormalized representation of the property_type reference e',
    `zoning_code_id` BIGINT COMMENT 'Foreign key linking to reference.zoning_code. Business justification: Buildings must comply with zoning regulations for permitted uses, FAR limits, and height restrictions — required for certificate of occupancy issuance, development approvals, and land use compliance r',
    `bim_reference_code` STRING COMMENT 'External reference identifier linking this building record to its Building Information Modeling (BIM) model in Procore or the enterprise BIM repository. Enables digital twin integration and construction document traceability.',
    `building_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the building across operational systems (Yardi Voyager, MRI Software, Building Engines). Used as the cross-system business key for integration and reporting.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `building_name` STRING COMMENT 'Official marketing or operational name of the building (e.g., One Market Plaza, Tower A). Used in tenant communications, leasing materials, and portfolio reporting.',
    `building_status` STRING COMMENT 'Current lifecycle status of the building. Drives leasing eligibility, maintenance scheduling, and portfolio reporting. [ENUM-REF-CANDIDATE: operational|under_construction|under_renovation|demolished|held_for_sale|mothballed — promote to reference product]. Valid values are `operational|under_construction|under_renovation|demolished|held_for_sale|mothballed`',
    `coo_date` DATE COMMENT 'Date on which the Certificate of Occupancy (COO) was issued by the local building authority. Used in lease commencement validation, insurance policy dating, and regulatory compliance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the building record was first created in the enterprise data platform. Used for data lineage, audit trail, and SOX financial controls compliance.',
    `elevator_count` STRING COMMENT 'Total number of passenger and service elevators in the building. Used in building operations planning, tenant service level assessments, and ADA compliance verification.',
    `far` DECIMAL(18,2) COMMENT 'Floor Area Ratio (FAR) — the ratio of total building floor area to the area of the land parcel. Represents the maximum allowable development density per zoning regulations. Critical for development feasibility and air rights analysis.',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed in the building. Required for insurance underwriting, OSHA compliance reporting, and tenant safety disclosures.. Valid values are `wet_pipe|dry_pipe|pre_action|deluge|none`',
    `floors_above_grade` STRING COMMENT 'Total number of occupied or leasable floors above ground level. Used in floor plan management, elevator capacity planning, and fire safety compliance.',
    `floors_below_grade` STRING COMMENT 'Total number of floors below ground level (basement, sub-basement, parking levels). Used in parking stall counts, mechanical space planning, and flood risk assessments.',
    `gla_sqft` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the building measured in square feet (SQF). Represents the total floor area designed for tenant occupancy and exclusive use. Primary metric for retail and commercial leasing revenue calculations.',
    `gla_sqm` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the building measured in square meters (SQM). Required for international portfolio reporting, IFRS 16 compliance, and cross-border investment analysis.',
    `hvac_system_type` STRING COMMENT 'Description of the primary Heating, Ventilation, and Air Conditioning (HVAC) system type installed in the building (e.g., VAV, chilled beam, VRF, central plant). Used in maintenance scheduling, energy benchmarking, and ESG reporting.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the building meets Americans with Disabilities Act (ADA) accessibility requirements. Required for lease disclosures, regulatory compliance, and tenant accommodation obligations.',
    `is_esg_reported` BOOLEAN COMMENT 'Indicates whether this building is included in the enterprises Environmental, Social, and Governance (ESG) reporting scope. Drives inclusion in GRESB, SEC sustainability disclosures, and REIT ESG benchmarks.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the building record was most recently modified in the enterprise data platform. Used for change data capture, data lineage, and audit trail compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the building in decimal degrees (WGS84). Enables GIS-based spatial analytics, proximity analysis, and map-based portfolio visualization.',
    `load_factor` DECIMAL(18,2) COMMENT 'Ratio of rentable area to usable area (rentable/usable), representing the tenants proportionate share of common areas. Also known as the add-on factor or core factor. Used in lease negotiations and CAM calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the building in decimal degrees (WGS84). Enables GIS-based spatial analytics, proximity analysis, and map-based portfolio visualization.',
    `nla_sqft` DECIMAL(18,2) COMMENT 'Net Leasable Area (NLA) of the building in square feet (SQF), excluding common areas, mechanical rooms, and structural elements. Used for Per Square Foot (PSF) rent calculations and lease abstractions.',
    `nla_sqm` DECIMAL(18,2) COMMENT 'Net Leasable Area (NLA) of the building in square meters (SQM). Used for international lease abstractions, IFRS 16 right-of-use asset calculations, and ESG intensity metrics (e.g., energy per SQM).',
    `parking_ratio` DECIMAL(18,2) COMMENT 'Number of parking stalls per 1,000 square feet of rentable area. Standard metric for commercial leasing competitiveness and tenant attraction, particularly for office and retail properties.',
    `parking_stalls_total` STRING COMMENT 'Total number of parking stalls associated with the building, including surface, structured, and underground parking. Used in lease negotiations, parking revenue management, and zoning compliance.',
    `structural_system` STRING COMMENT 'Description of the primary structural system (e.g., moment frame, shear wall, flat plate, post-tensioned slab). Required for engineering assessments, seismic compliance, and BIM documentation.',
    `total_rentable_sqft` DECIMAL(18,2) COMMENT 'Total rentable area per BOMA measurement standards, including tenant usable area plus the tenants pro-rata share of Common Area Maintenance (CAM) spaces. Basis for rent billing and CAM reconciliation.',
    `year_built` STRING COMMENT 'Calendar year in which the building was originally constructed and received its Certificate of Occupancy (COO). Used in depreciation calculations, valuation models, and ESG reporting.',
    `year_renovated` STRING COMMENT 'Calendar year of the most recent major renovation or capital improvement. Null if no significant renovation has occurred. Influences building class assignment and market comparables.',
    CONSTRAINT pk_building PRIMARY KEY(`building_id`)
) COMMENT 'Physical building structure record associated with a real estate asset. One asset may contain multiple buildings (e.g., campus, mixed-use development). Captures building name, year built/renovated, floors above and below grade, total GLA/NLA (SQF and SQM), building class (A/B/C), construction type, structural system, building status (operational, under construction, demolished), COO number and date, fire suppression type, elevator count, parking stalls, and BIM reference. SSOT for building-level sustainability certifications (LEED level/date, BREEAM rating, ENERGY STAR score, WELL, FITWEL) with certifying body, certification number, expiration, and ESG reporting flags. SSOT for building amenity inventory (fitness, parking, F&B, conference, outdoor, technology, security) with capacity, hours, ADA compliance, and fee details. SSOT for floor plan records (as-built, current, proposed) with area breakdowns, load factors, and CAD/BIM file references. The comprehensive physical structure record and single source of truth for all building attributes, certifications, amenities, and floor plans in the portfolio.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`parcel` (
    `parcel_id` BIGINT COMMENT 'Unique surrogate identifier for the land parcel record in the enterprise data platform (Silver Layer). Primary key for the parcel entity.',
    `address_id` BIGINT COMMENT 'Foreign key linking to property.address. Business justification: Parcel currently embeds address fields (street_address, city, county, state_code, country_code, postal_code) directly. The address product is the authoritative standardized address registry. Adding pa',
    `asset_id` BIGINT COMMENT 'Foreign key linking to property.asset. Business justification: Parcel is currently siloed with no in-domain FK relationships. A land parcel is the legal foundation of a real estate asset — every asset sits on one or more parcels. The relationship is 1:N from asse',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Parcels are subject to jurisdiction-specific zoning, environmental, and land use regulations. The jurisdiction governs subdivision approvals, environmental designations, and title recording requiremen',
    `zoning_code_id` BIGINT COMMENT 'Foreign key linking to reference.zoning_code. Business justification: Parcels are directly subject to zoning ordinances governing permitted uses, FAR, setbacks, and density — foundational for development feasibility analysis, entitlement processing, and land use complia',
    `apn` STRING COMMENT 'Assessor Parcel Number assigned by the county assessors office. Serves as the official government-issued identifier for the land parcel used in title searches, tax records, and regulatory filings. Aligns with county recorder and MLS data.',
    `assessed_land_value` DECIMAL(18,2) COMMENT 'County assessors assessed value of the land (excluding improvements) in USD. Used for property tax calculation, Argus Enterprise valuation modeling, and NAV/GAV reporting.',
    `assessed_value_year` STRING COMMENT 'Tax year for which the assessed_land_value was determined by the county assessor. Ensures temporal accuracy of valuation data for tax and financial reporting.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Decimal latitude coordinate of the parcel centroid in WGS84 datum. Used for mapping, proximity analysis, and GIS-based portfolio reporting.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Decimal longitude coordinate of the parcel centroid in WGS84 datum. Used for mapping, proximity analysis, and GIS-based portfolio reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parcel record was first created in the enterprise data platform. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and SOX compliance.',
    `deed_book_page` STRING COMMENT 'County recorder deed book and page number reference (e.g., Book 1234, Page 567) identifying the recorded deed instrument for this parcel. Used for title chain verification and ALTA surveys.',
    `easement_description` STRING COMMENT 'Description of any recorded easements, rights-of-way, or encumbrances affecting the parcel (e.g., utility easement, access easement, drainage easement). Material to title review and development planning.',
    `environmental_designation` STRING COMMENT 'Environmental status designation of the parcel indicating known contamination or regulatory classification. brownfield indicates previously developed land with potential contamination; superfund indicates EPA National Priorities List site; wetland indicates protected wetland area; contaminated indicates confirmed contamination; under_review indicates active Phase I/II ESA in progress.. Valid values are `none|brownfield|superfund|wetland|contaminated|under_review`',
    `far_allowed` DECIMAL(18,2) COMMENT 'Maximum Floor Area Ratio (FAR) permitted under current zoning regulations. FAR is the ratio of total building floor area to the parcel land area. Critical input for development feasibility and Argus Enterprise cash flow modeling.',
    `fema_map_panel_number` STRING COMMENT 'FEMA Flood Insurance Rate Map (FIRM) panel number identifying the specific flood map panel on which this parcel appears. Required for flood insurance underwriting and lender compliance.',
    `flood_zone_designation` STRING COMMENT 'Federal Emergency Management Agency (FEMA) flood zone designation for the parcel (e.g., Zone A, Zone AE, Zone X, Zone VE). Determines flood insurance requirements, lender mandates, and development risk. Sourced from FEMA Flood Insurance Rate Maps (FIRM). [ENUM-REF-CANDIDATE: Zone A|Zone AE|Zone AH|Zone AO|Zone AR|Zone A99|Zone V|Zone VE|Zone X|Zone D — promote to reference product]',
    `front_setback_ft` DECIMAL(18,2) COMMENT 'Minimum required front setback distance in feet from the street right-of-way to the building face, as mandated by local zoning regulations. Impacts buildable area calculations.',
    `gis_boundary_wkt` STRING COMMENT 'GIS polygon boundary of the parcel expressed in Well-Known Text (WKT) format (e.g., POLYGON((lon1 lat1, lon2 lat2, ...))). Enables spatial analysis, mapping, and integration with GIS platforms. Conforms to OGC Simple Features standard.',
    `last_sale_date` DATE COMMENT 'Date of the most recent arms-length sale transaction recorded for this parcel. Used for Comparative Market Analysis (CMA), Broker Price Opinion (BPO), and CoStar comparable sales analysis.',
    `last_sale_price` DECIMAL(18,2) COMMENT 'Recorded sale price in USD from the most recent arms-length transaction for this parcel. Used for CMA, BPO, CAP rate analysis, and Argus Enterprise valuation benchmarking.',
    `legal_description` STRING COMMENT 'Full legal description of the parcel as recorded in the county deed or title document (e.g., metes and bounds, lot and block, or government rectangular survey). Required for title insurance and ALTA surveys.',
    `lot_size_acres` DECIMAL(18,2) COMMENT 'Total land area of the parcel expressed in acres as recorded by the county assessor. Used for valuation, FAR calculations, and development feasibility analysis.',
    `lot_size_sqf` DECIMAL(18,2) COMMENT 'Total land area of the parcel expressed in square feet (SQF). Primary unit for commercial real estate analysis, PSF calculations, and CoStar/MLS data alignment.',
    `lot_size_sqm` DECIMAL(18,2) COMMENT 'Total land area of the parcel expressed in square meters (SQM). Required for international portfolio reporting, IFRS 16 compliance, and cross-border investment analysis.',
    `max_building_height_ft` DECIMAL(18,2) COMMENT 'Maximum allowable building height in feet as specified by local zoning ordinance. Constrains development potential and is used in Procore construction project planning and Argus Enterprise valuation models.',
    `parcel_name` STRING COMMENT 'Human-readable business name or label assigned to the parcel for internal identification and reporting purposes (e.g., Westside Industrial Lot 4). Distinct from the legal description.',
    `parcel_status` STRING COMMENT 'Current lifecycle status of the parcel record. active indicates the parcel is a valid, undivided legal unit; subdivided indicates it has been split into child parcels; merged indicates it has been combined with adjacent parcels; inactive indicates retired or decommissioned; pending indicates awaiting county confirmation.. Valid values are `active|subdivided|merged|inactive|pending`',
    `parcel_type` STRING COMMENT 'Classification of the parcel by its legal and physical nature. land denotes unimproved vacant land; improved denotes land with structures; condominium denotes a condo parcel; timeshare denotes a fractional ownership parcel; right_of_way denotes easement or access parcels.. Valid values are `land|improved|condominium|timeshare|right_of_way`',
    `parent_apn` STRING COMMENT 'APN of the parent parcel from which this parcel was subdivided. Populated when status is subdivided to maintain the parcel lineage and ownership hierarchy. Null for original parcels.',
    `phase_i_esa_completed` BOOLEAN COMMENT 'Indicates whether a Phase I Environmental Site Assessment (ESA) has been completed for this parcel. Required by lenders and investors prior to acquisition per ASTM E1527 standard.',
    `phase_i_esa_date` DATE COMMENT 'Date on which the most recent Phase I Environmental Site Assessment (ESA) was completed. Used to determine if the assessment is current (typically valid for 180 days per ASTM E1527).',
    `plat_map_reference` STRING COMMENT 'Reference to the recorded subdivision plat map (e.g., plat book and page, or plat file number) from which the parcels lot and block description is derived. Required for title and survey work.',
    `rear_setback_ft` DECIMAL(18,2) COMMENT 'Minimum required rear setback distance in feet from the rear property line to the building, as mandated by local zoning regulations.',
    `recording_date` DATE COMMENT 'Date on which the parcel deed or plat was officially recorded with the county recorders office. Establishes the legal effective date of the parcels existence and is used in title chain analysis.',
    `side_setback_ft` DECIMAL(18,2) COMMENT 'Minimum required side setback distance in feet from the side property line to the building, as mandated by local zoning regulations.',
    `soil_classification` STRING COMMENT 'Soil type classification for the parcel as determined by geotechnical survey or USDA Natural Resources Conservation Service (NRCS) soil survey data (e.g., Class I, Class II, expansive clay, sandy loam). Relevant for construction feasibility, agricultural use, and environmental assessment.',
    `subdivision_name` STRING COMMENT 'Name of the recorded subdivision or plat in which the parcel is located (e.g., Oakwood Business Park Phase II). Used for lot-and-block legal descriptions and development project tracking in Procore.',
    `title_reference_number` STRING COMMENT 'Title or deed reference number as recorded with the county recorder or land registry. Links the parcel to its chain of title and is required for ALTA title insurance and ownership verification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the parcel record was most recently modified in the enterprise data platform. Conforms to ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data lineage, and SOX compliance.',
    CONSTRAINT pk_parcel PRIMARY KEY(`parcel_id`)
) COMMENT 'Land parcel record representing a legally defined unit of land as recorded by the county assessor. Captures APN (Assessor Parcel Number), legal description, lot size in acres and SQF, zoning classification code, zoning description, FAR (Floor Area Ratio) allowed, maximum building height, setback requirements, flood zone designation (FEMA), soil classification, environmental designation (Superfund, brownfield), GIS polygon boundary (WKT or GeoJSON), county, municipality, state, country, and parcel status (active, subdivided, merged). Serves as the authoritative land record underpinning title and ownership data.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`unit` (
    `unit_id` BIGINT COMMENT 'Unique surrogate identifier for a leasable or saleable unit within the portfolio. Primary key for the unit master record.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Unit area measurement standard (BOMA, IPMS, RICS) is required for lease compliance, area certification, and international portfolio reporting. New column area_uom_id created as no existing unlinked co',
    `asset_id` BIGINT COMMENT 'Reference to the parent property (development or complex) that contains this unit. Supports portfolio-level rollup and reporting.',
    `building_id` BIGINT COMMENT 'Reference to the parent building in which this unit is located. Establishes the unit-to-building hierarchy within the property domain.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Unit-level rent benchmarking (asking_rent_psf, market_rent_psf) and TI allowance reporting require a currency reference for multi-currency portfolio management and cross-border lease comparisons. New ',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Units in mixed-use and multifamily assets have a space use type (residential, retail, office) governing CAM applicability, lease structure eligibility, TI allowance benchmarks, and zoning use class co',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'Current listed asking rent for the unit expressed as an annual rate per square foot (PSF). Used in leasing negotiations, broker marketing, and MLS/CoStar syndication.',
    `available_date` DATE COMMENT 'The date on which the unit is or will be available for leasing or sale. Drives vacancy reporting, leasing pipeline prioritization, and revenue forecasting in Argus Enterprise.',
    `bathroom_count` DECIMAL(18,2) COMMENT 'Number of bathrooms in the unit, expressed as a decimal to accommodate half-baths (e.g., 1.5, 2.0). Standard residential listing attribute per RESO Data Dictionary.',
    `bedroom_count` STRING COMMENT 'Number of bedrooms in the unit. Applicable to residential units (apartments, condominiums). Used for MLS listing, rent benchmarking, and residential portfolio segmentation.',
    `bim_reference` STRING COMMENT 'Reference identifier linking this unit to its corresponding object in the Building Information Modeling (BIM) system (e.g., Procore or Revit model GUID). Enables digital twin integration and construction-to-operations handover.',
    `breeam_rating` STRING COMMENT 'BREEAM sustainability rating applicable to this unit or its parent building. Required for international ESG compliance, green financing, and institutional investor reporting.. Valid values are `outstanding|excellent|very_good|good|pass|unclassified`',
    `cam_eligible` BOOLEAN COMMENT 'Indicates whether the unit is subject to Common Area Maintenance (CAM) charge recovery. Drives operating expense billing setup in Yardi Voyager and MRI Software.',
    `configuration` STRING COMMENT 'Physical layout configuration of the unit interior. Relevant for office and commercial leasing where tenant fit-out requirements vary by configuration type.. Valid values are `open_plan|private_offices|mixed|bullpen|loft|raw`',
    `construction_year` STRING COMMENT 'The year in which the unit was originally constructed. Used for depreciation calculations, building age analysis, and capital planning under FASB ASC 840/842.',
    `coo_issue_date` DATE COMMENT 'The date on which the Certificate of Occupancy (COO) was issued for this unit by the relevant municipal authority. Required for compliance documentation and leasing eligibility verification.',
    `coo_status` STRING COMMENT 'Current status of the Certificate of Occupancy (COO) for this unit. A valid COO is required before a unit can be legally occupied. Tracked for regulatory compliance and leasing eligibility.. Valid values are `issued|pending|not_required|expired|revoked`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this unit record was first created in the data platform. Supports data lineage, audit trail, and SOX financial controls compliance.',
    `efficiency_ratio` DECIMAL(18,2) COMMENT 'Ratio of usable area to rentable area (usable_area_sqf / rentable_area_sqf). Indicates how much of the rented space is directly usable by the tenant. A key metric in office leasing and space planning.',
    `energy_rating` STRING COMMENT 'Energy Performance Certificate (EPC) rating for the unit, ranging from A (most efficient) to G (least efficient). Required for regulatory compliance in many jurisdictions and ESG portfolio reporting.. Valid values are `A|B|C|D|E|F`',
    `floor_number` STRING COMMENT 'The floor level on which the unit is located within the building. Used for view classification, accessibility analysis, and vertical stacking reports.',
    `has_balcony` BOOLEAN COMMENT 'Indicates whether the unit includes a private balcony or patio. Used in residential marketing, rent premium analysis, and amenity-based comparables.',
    `hvac_zone` STRING COMMENT 'The HVAC zone designation for this unit within the buildings mechanical system. Used for facility operations, energy management, and service request routing in Building Engines.',
    `internet_connectivity` STRING COMMENT 'Type of internet connectivity infrastructure available in the unit. Increasingly a key leasing criterion for commercial and residential tenants; tracked for marketing and tenant amenity reporting.. Valid values are `fiber|cable|DSL|none`',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the unit meets Americans with Disabilities Act (ADA) accessibility requirements. Required for regulatory compliance reporting, HUD compliance, and accessible unit inventory tracking.',
    `is_furnished` BOOLEAN COMMENT 'Indicates whether the unit is offered with furniture included. Relevant for short-term residential leasing, corporate housing, and serviced apartment inventory.',
    `last_renovated_date` DATE COMMENT 'The date on which the unit was most recently renovated or refurbished. Used for capital expenditure (CAPEX) planning, asset condition assessment, and maintenance scheduling.',
    `lease_type_eligibility` STRING COMMENT 'The lease structure(s) for which this unit is eligible, such as Gross, Triple Net (NNN), Modified Gross, or Full Service Gross (FSG). Drives lease template selection and operating expense recovery modeling. [ENUM-REF-CANDIDATE: gross|NNN|modified_gross|FSG|double_net|ground_lease — promote to reference product]. Valid values are `gross|NNN|modified_gross|NNN|FSG`',
    `leed_certification` STRING COMMENT 'LEED certification level applicable to this unit or its parent building as awarded by the U.S. Green Building Council (USGBC). Supports ESG reporting, green lease compliance, and sustainability benchmarking.. Valid values are `certified|silver|gold|platinum|none`',
    `market_rent_psf` DECIMAL(18,2) COMMENT 'Estimated market rent for the unit per square foot (PSF) based on comparable market analysis (CMA) and CoStar benchmarking. Used for Argus Enterprise DCF modeling, NAV calculations, and asset management reporting.',
    `max_occupancy` STRING COMMENT 'Maximum number of occupants permitted in the unit as specified by the Certificate of Occupancy (COO) or local building code. Used for compliance monitoring and lease clause enforcement.',
    `metering_type` STRING COMMENT 'Indicates how utilities (electricity, gas, water) are metered for this unit. Drives utility billing setup, CAM reconciliation, and ESG energy consumption reporting.. Valid values are `individually_metered|master_metered|sub_metered|none`',
    `mri_unit_code` STRING COMMENT 'The units native identifier in MRI Software, used for residential management and investment accounting. Supports cross-system reconciliation for mixed-use portfolios.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special conditions, or leasing remarks associated with the unit. Used by property managers and leasing agents for internal communication.',
    `parking_spaces` STRING COMMENT 'Number of dedicated parking spaces allocated to this unit. Used in lease administration, tenant onboarding, and parking revenue management.',
    `pro_rata_share` DECIMAL(18,2) COMMENT 'The units proportionate share of the buildings total rentable area, expressed as a decimal fraction. Used to calculate the tenants share of Common Area Maintenance (CAM) charges, real estate taxes, and insurance under NNN and modified gross leases.',
    `rentable_area_sqf` DECIMAL(18,2) COMMENT 'Total rentable area of the unit measured in square feet (SQF) per BOMA/RESO standards. Used as the basis for rent calculation (PSF), CAM charge proration, and GLA/NLA portfolio reporting.',
    `rentable_area_sqm` DECIMAL(18,2) COMMENT 'Total rentable area of the unit measured in square meters (SQM). Required for international portfolio reporting, IFRS 16 compliance, and cross-border investment analysis.',
    `ti_allowance_psf` DECIMAL(18,2) COMMENT 'Standard Tenant Improvement (TI) allowance offered for this unit expressed per square foot (PSF). Used in deal structuring, LOI preparation, and lease economics modeling in Argus Enterprise.',
    `unit_number` STRING COMMENT 'Human-readable alphanumeric identifier for the unit as displayed on signage, lease documents, and tenant correspondence (e.g., 101, Suite 2A, Bay 5). Sourced from Yardi Voyager unit master.',
    `unit_status` STRING COMMENT 'Current operational lifecycle state of the unit. Drives vacancy reporting, leasing pipeline management, and NOI forecasting. offline indicates the unit is temporarily removed from leasable inventory.. Valid values are `vacant|occupied|under_renovation|offline|pre_leased|model`',
    `unit_type` STRING COMMENT 'Classification of the unit by its intended use and configuration. Drives lease template selection, rent benchmarking, and portfolio segmentation. [ENUM-REF-CANDIDATE: studio|1BR|2BR|3BR|penthouse|office_suite|retail_bay|industrial_bay|storage|mixed_use|other — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this unit record was most recently modified in the data platform. Used for incremental data pipeline processing, change data capture, and audit compliance.',
    `usable_area_sqf` DECIMAL(18,2) COMMENT 'Net usable area of the unit in square feet (SQF), excluding common areas and structural elements. Used to compute the efficiency ratio and for tenant space planning.',
    `view_type` STRING COMMENT 'Classification of the primary view from the unit. Influences premium pricing, marketing positioning, and tenant preference scoring in CRM systems.. Valid values are `city|park|water|courtyard|street|none`',
    `yardi_unit_code` STRING COMMENT 'The units native identifier in Yardi Voyager, the system of record for property management and lease administration. Used for data lineage, system reconciliation, and integration with AR/AP workflows.',
    CONSTRAINT pk_unit PRIMARY KEY(`unit_id`)
) COMMENT 'Leasable or saleable unit within a building — apartment unit, office suite, retail bay, industrial bay, or storage unit. Captures unit number, floor number, unit type (studio, 1BR, 2BR, office suite, retail bay), rentable area in SQF and SQM, usable area, efficiency ratio, unit status (vacant, occupied, under renovation, offline), asking rent PSF, market rent PSF, unit configuration (open plan, private offices), ADA compliance flag, balcony/patio flag, view type, and date last renovated. The SSOT for all leasable space inventory within the portfolio.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`space` (
    `space_id` BIGINT COMMENT 'Primary key for space',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Space area measurement standard (BOMA, IPMS) is required for lease compliance, CAM area certification, and pro-rata share calculations in commercial leasing. New column area_uom_id created as no exist',
    `building_id` BIGINT COMMENT 'Reference to the parent building in which this space is physically located. Establishes the building-to-space hierarchy for GLA/NLA reconciliation.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Space-level rent metrics (asking_rent_psf, effective_rent_psf, ti_allowance_psf) require a currency reference for multi-currency portfolio reporting and cross-border lease comparisons. New column curr',
    `floor_id` BIGINT COMMENT 'Reference to the floor record within the building on which this space resides. Supports multi-floor space configurations and floor-level reporting.',
    `lease_type_id` BIGINT COMMENT 'Foreign key linking to reference.lease_type. Business justification: The lease type (NNN, gross, modified gross) on a space determines expense recovery obligations, ASC 842/IFRS 16 classification, and NOI modeling inputs — used in lease abstracting and financial report',
    `space_use_type_id` BIGINT COMMENT 'Foreign key linking to reference.space_use_type. Business justification: Space use type classification drives CAM recovery rules, TI allowance benchmarks, lease structure eligibility, and zoning compliance — fundamental to lease abstracting and space management. use_type o',
    `suite_unit_id` BIGINT COMMENT 'Reference to the suite or demised premises to which this space belongs. Enables grouping of individual spaces into a leasable suite for lease administration in Yardi Voyager.',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Space is described as a sub-unit space within a building, supporting multi-tenant floor configurations and co-working arrangements. A space can be a subdivision of a leasable unit (e.g., a suite subdi',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the space meets Americans with Disabilities Act (ADA) or equivalent accessibility standards. Required for regulatory compliance reporting, COO issuance, and HUD-related affordable housing programs.',
    `asking_rent_psf` DECIMAL(18,2) COMMENT 'Quoted annual asking rent per square foot for this space as listed in the leasing market. Used by brokerage and leasing teams for deal pricing, CoStar market comparisons, and Salesforce CRM deal pipeline management. Confidential as it reflects pricing strategy.',
    `available_date` DATE COMMENT 'Date on which the space is or will be available for occupancy by a new tenant. Drives leasing pipeline management in Salesforce CRM, vacancy reporting, and CoStar listing syndication.',
    `bim_element_code` STRING COMMENT 'Unique element identifier from the Building Information Modeling (BIM) model corresponding to this space. Enables integration between the data lakehouse and BIM authoring tools (e.g., Revit) via Procore for construction and facility management workflows.',
    `building_engines_space_code` STRING COMMENT 'Space identifier as recorded in Building Engines facility operations platform. Used to link work orders, tenant service requests, and preventive maintenance schedules to the correct physical space.',
    `cam_area_sqf` DECIMAL(18,2) COMMENT 'Square footage of this space that is allocated to the CAM pool. May differ from total rentable area when only a portion of the space is CAM-eligible (e.g., a partially shared corridor). Used in CAM charge calculations and annual CAM reconciliation.',
    `cam_eligible` BOOLEAN COMMENT 'Indicates whether this space is included in the Common Area Maintenance (CAM) pool for charge-back calculations to tenants. True for common corridors, lobbies, and shared amenities; False for exclusively demised tenant spaces. Drives CAM reconciliation in Yardi Voyager.',
    `ceiling_height_ft` DECIMAL(18,2) COMMENT 'Clear ceiling height of the space measured in feet from finished floor to finished ceiling. A key physical specification influencing tenant suitability (e.g., data centers require raised floors and high ceilings), TI design, and HVAC system sizing.',
    `condition` STRING COMMENT 'Physical condition and fit-out state of the space at the time of listing or inspection. Shell = bare concrete/structure only; Warm Shell = HVAC and electrical roughed in; Plug and Play = fully furnished and wired; Full Fit Out = custom tenant improvements complete; As Is = existing condition without landlord work.. Valid values are `shell|warm_shell|plug_and_play|full_fit_out|as_is`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this space record was first created in the enterprise data platform. Supports data lineage, audit trail requirements, and SOX financial controls for publicly traded REITs.',
    `effective_rent_psf` DECIMAL(18,2) COMMENT 'Net effective rent per square foot after accounting for free rent periods, TI allowances, and other concessions. Used in Argus Enterprise cash flow modeling and investment analysis to reflect true economic rent versus face rent.',
    `electrical_capacity_amps` DECIMAL(18,2) COMMENT 'Dedicated electrical capacity allocated to this space in amperes. Critical for tenant fit-out planning, data center and lab space leasing, and building infrastructure load management.',
    `energy_star_eligible` BOOLEAN COMMENT 'Indicates whether this space qualifies for ENERGY STAR certification based on energy performance benchmarks. Supports ESG reporting, green lease provisions, and EPA ENERGY STAR portfolio benchmarking.',
    `floor_number` STRING COMMENT 'Numeric floor level on which the space is located within the building. Negative values represent below-grade levels (e.g., -1 for basement). Used for floor plan mapping, elevator zoning, and emergency egress planning.',
    `floor_plan_reference` STRING COMMENT 'Document reference or URL pointing to the architectural floor plan drawing for this space, typically stored in Procore or a document management system. Supports TI space planning, BIM coordination, and tenant improvement design reviews.',
    `hvac_zone` STRING COMMENT 'HVAC zone designation for this space as configured in the building management system and Building Engines. Determines which HVAC unit serves the space, supports after-hours HVAC billing, and drives preventive maintenance scheduling.',
    `is_contiguous` BOOLEAN COMMENT 'Indicates whether this space is physically contiguous with adjacent spaces, enabling combination into a larger demised unit for a single tenant. Critical for large-block leasing strategies and tenant expansion rights.',
    `is_subdivisible` BOOLEAN COMMENT 'Indicates whether this space can be physically subdivided into smaller demised units to accommodate multiple tenants or co-working configurations. Supports leasing flexibility analysis and TI space planning.',
    `last_occupied_date` DATE COMMENT 'Date on which the most recent tenant vacated or the space was last in active occupancy. Used to calculate vacancy duration, assess market re-leasing timelines, and trigger preventive maintenance inspections in Building Engines.',
    `leed_certification_level` STRING COMMENT 'LEED certification level applicable to this space or the building section it occupies, as awarded by the U.S. Green Building Council (USGBC). Drives ESG reporting, green premium rent analysis, and sustainability compliance disclosures for publicly traded REITs.. Valid values are `certified|silver|gold|platinum|none`',
    `load_factor` DECIMAL(18,2) COMMENT 'Ratio of rentable area to usable area (rentable_area_sqf / usable_area_sqf), also known as the add-on factor or loss factor. Quantifies the tenants proportionate share of common areas. A load factor of 1.15 means 15% of the rentable area is common space. Critical for NLA/GLA reconciliation and lease negotiation.',
    `max_occupancy` STRING COMMENT 'Maximum number of persons permitted to occupy the space simultaneously as determined by the Certificate of Occupancy (COO) and local fire/building codes. Used for OSHA compliance, emergency planning, and co-working capacity management.',
    `notes` STRING COMMENT 'Free-text field for operational notes, leasing remarks, or special conditions associated with the space (e.g., Column intrusion on north wall, Dedicated fiber riser access, Requires landlord approval for signage). Used by property managers and leasing agents.',
    `occupancy_class` STRING COMMENT 'Building quality classification of the space (Class A, B, or C) per BOMA/CoStar standards. Influences asking rent benchmarks, tenant profile targeting, and portfolio reporting in CoStar Suite and Argus Enterprise.. Valid values are `class_a|class_b|class_c`',
    `pro_rata_share` DECIMAL(18,2) COMMENT 'Tenants proportionate share of the buildings total rentable area, expressed as a decimal (e.g., 0.125000 = 12.5%). Used to allocate CAM charges, operating expenses, and real estate taxes under NNN and modified gross lease structures.',
    `rentable_area_sqf` DECIMAL(18,2) COMMENT 'Rentable area of the space measured in square feet per BOMA standards, inclusive of the tenants pro-rata share of common areas. This is the basis for rent calculation, CAM charge allocation, and GLA reconciliation in Yardi Voyager and Argus Enterprise.',
    `rentable_area_sqm` DECIMAL(18,2) COMMENT 'Rentable area of the space measured in square meters for international portfolio reporting and IFRS 16 compliance. Maintained in parallel with SQF for cross-border asset comparisons.',
    `space_name` STRING COMMENT 'Descriptive human-readable name for the space (e.g., Executive Conference Room, North Lobby, Parking Bay 12). Used in tenant communications, floor plan references, and facility operations.',
    `space_number` STRING COMMENT 'Alphanumeric identifier assigned to the space within the building, as recorded in Yardi Voyager and Building Engines (e.g., 101A, B-204, LOBBY-1). Used for physical wayfinding, work order routing, and tenant service requests.. Valid values are `^[A-Za-z0-9-.]{1,30}$`',
    `space_status` STRING COMMENT 'Current lifecycle status of the space indicating its operational availability. available = ready to lease; occupied = active tenant; under_build_out = TI construction in progress; offline = temporarily out of service; reserved = held for a prospect or pending deal; decommissioned = permanently removed from inventory.. Valid values are `available|occupied|under_build_out|offline|reserved|decommissioned`',
    `space_type` STRING COMMENT 'Categorical classification of the spaces functional use within the building. Drives CAM eligibility, GLA/NLA inclusion rules, and TI planning. [ENUM-REF-CANDIDATE: private_office|conference_room|common_corridor|lobby|mechanical_room|parking_bay|storage|retail_unit|coworking_bay|restroom — promote to reference product]',
    `ti_allowance_psf` DECIMAL(18,2) COMMENT 'Landlord-funded Tenant Improvement (TI) allowance per square foot offered for this space to cover fit-out construction costs. A key lease concession tracked in Yardi Voyager and DocuSign CLM during lease negotiation and execution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this space record was most recently modified in the enterprise data platform. Used for incremental data pipeline processing, change data capture, and audit compliance.',
    `usable_area_sqf` DECIMAL(18,2) COMMENT 'Usable area of the space in square feet, representing the area exclusively occupied by the tenant excluding common areas. Used alongside rentable area to compute the load factor and NLA reconciliation.',
    `usable_area_sqm` DECIMAL(18,2) COMMENT 'Usable area of the space in square meters. Used for international lease administration, IFRS 16 right-of-use asset calculations, and cross-border portfolio benchmarking.',
    `yardi_space_code` STRING COMMENT 'Native space identifier as assigned in Yardi Voyager Property Management system. Used for system-of-record reconciliation, data lineage tracking, and integration with Yardi AR/AP and lease administration modules.',
    CONSTRAINT pk_space PRIMARY KEY(`space_id`)
) COMMENT 'Sub-unit space or common area within a building, supporting multi-tenant floor configurations, co-working arrangements, and common area maintenance (CAM) allocations. Captures space number, space type (private office, conference room, common corridor, lobby, mechanical room, parking bay, storage), rentable area SQF, usable area SQF, load factor, CAM-eligible flag, space status (available, occupied, under build-out, offline), floor number, floor plan reference, and suite assignment. Enables precise GLA/NLA reconciliation, CAM charge calculations, and tenant improvement (TI) space planning across the portfolio.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each standardized address record in the enterprise property address registry. Serves as the primary key for all address-related joins across the property domain.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Country reference is required for international portfolio management, regulatory jurisdiction determination, foreign ownership compliance, and GDPR applicability assessment. country_code on address is',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Addresses are located within geographic market hierarchies used for market analysis, portfolio geographic roll-up, and investment strategy segmentation. msa_name and submarket_name on address are deno',
    `address_source` STRING COMMENT 'Operational system of record from which this address record was originally sourced or last updated. Supports data lineage tracking, conflict resolution during ETL, and audit trail requirements. Values correspond to enterprise operational systems. [ENUM-REF-CANDIDATE: yardi|mri|costar|manual|usps|gis|procore — 7 candidates stripped; promote to reference product]',
    `address_type` STRING COMMENT 'Classification of the address purpose within the enterprise. Primary indicates the main physical address; mailing is the postal delivery address; legal is the address of record for title and regulatory filings; billing is used for invoicing; secondary captures additional frontages for corner properties.. Valid values are `primary|mailing|legal|billing|secondary`',
    `carrier_route` STRING COMMENT 'USPS carrier route code identifying the specific mail carrier delivery route for the address. Used for bulk mail processing, address quality validation, and USPS CASS (Coding Accuracy Support System) certification.. Valid values are `^[A-Z][0-9]{3}$`',
    `census_tract` STRING COMMENT 'U.S. Census Bureau census tract code for the address location. Used for HUD regulatory reporting, Community Reinvestment Act (CRA) compliance, demographic analysis, and opportunity zone identification for tax-advantaged investment reporting.. Valid values are `^[0-9]{4,6}(.[0-9]{2})?$`',
    `city` STRING COMMENT 'Municipality or city name in which the property address is located. Used for market segmentation, submarket analysis, and regulatory reporting. Aligned with USPS city name standardization.',
    `congressional_district` STRING COMMENT 'U.S. Congressional district designation for the address location. Used for government affairs tracking, lobbying activity reporting, and compliance with federal housing and development programs administered at the district level.',
    `county` STRING COMMENT 'County or parish name in which the property is located. Required for property tax assessment, title searches, and regulatory compliance reporting to HUD and local jurisdictions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this address record was first created in the enterprise data platform. Supports audit trail requirements, data lineage, and SOX financial controls for publicly traded REITs.',
    `delivery_point_barcode` STRING COMMENT 'USPS-assigned Delivery Point Barcode (DPBC) for the address, consisting of the ZIP+4 code plus a two-digit delivery point code. Confirms mail deliverability and is used for bulk mail operations and address quality scoring.',
    `effective_date` DATE COMMENT 'Date from which this address record became or becomes effective for the associated property. Used for bi-temporal data management, historical address tracking, and compliance with FASB ASC 842 and IFRS 16 lease accounting address change requirements.',
    `expiry_date` DATE COMMENT 'Date on which this address record ceases to be effective. Null indicates the address is open-ended with no planned expiry. Supports bi-temporal address history management and regulatory audit trails.',
    `fips_code` STRING COMMENT 'Five-digit FIPS code uniquely identifying the state and county of the address (first two digits = state, last three = county). Required for government regulatory reporting, HUD submissions, and geographic data integration with federal datasets.. Valid values are `^[0-9]{5}$`',
    `flood_zone_code` STRING COMMENT 'FEMA National Flood Insurance Program (NFIP) flood zone designation for the address (e.g., AE, X, VE). Required for property insurance underwriting, lender due diligence, environmental compliance reporting, and disclosure obligations under HUD and EPA regulations.',
    `geocode_accuracy` STRING COMMENT 'Precision level of the geocoded latitude/longitude coordinates. Rooftop indicates exact building-level precision; parcel_centroid is parcel-level; street_interpolated is estimated from street range; zip_centroid and city_centroid are approximate. Critical for GIS analysis quality assessment.. Valid values are `rooftop|parcel_centroid|street_interpolated|zip_centroid|city_centroid`',
    `geocode_timestamp` TIMESTAMP COMMENT 'Date and time when the latitude and longitude coordinates were last geocoded or re-geocoded for this address. Supports GIS data freshness monitoring and triggers re-geocoding workflows when coordinates are stale relative to address changes.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this address record is currently active and in use. False indicates the address has been superseded, retired, or invalidated (e.g., due to a street renaming, rezoning, or property demolition). Supports soft-delete patterns in the Silver layer.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the primary address for the associated property or building. True when this is the main address used for all official correspondence, title records, and regulatory filings. A property may have multiple addresses (e.g., corner properties with multiple street frontages); only one should be flagged as primary.',
    `latitude` DECIMAL(18,2) COMMENT 'WGS 84 decimal degree latitude coordinate of the property address, ranging from -90 to +90. Derived from geocoding the standardized address. Supports GIS integration, spatial analysis, proximity searches, and market boundary delineation.',
    `line_1` STRING COMMENT 'Primary street address line including house/building number and street name. Represents the first line of the standardized postal address as defined by USPS or local postal authority. Sourced from Yardi Voyager property address fields.',
    `line_2` STRING COMMENT 'Secondary address line capturing suite, floor, unit, building name, or additional directional information not captured in address line 1. Common for multi-tenant commercial buildings with multiple street frontages or suite designations.',
    `longitude` DECIMAL(18,2) COMMENT 'WGS 84 decimal degree longitude coordinate of the property address, ranging from -180 to +180. Derived from geocoding the standardized address. Supports GIS integration, spatial analysis, proximity searches, and market boundary delineation.',
    `msa_code` STRING COMMENT 'U.S. Office of Management and Budget (OMB) five-digit code identifying the Metropolitan Statistical Area (MSA) in which the property is located. Used for market-level performance benchmarking, CoStar market analytics, and investment portfolio geographic classification.. Valid values are `^[0-9]{5}$`',
    `neighborhood_name` STRING COMMENT 'Recognized neighborhood or district name within the city or submarket (e.g., SoHo, Buckhead, River North). Supports hyper-local market analysis, tenant demand mapping, and broker price opinion (BPO) comparables selection.',
    `notes` STRING COMMENT 'Free-text field for capturing additional address-related context, exceptions, or clarifications not accommodated by structured fields (e.g., building access instructions, address disambiguation notes for corner properties, or historical address change explanations).',
    `opportunity_zone_flag` BOOLEAN COMMENT 'Indicates whether the address falls within a federally designated Qualified Opportunity Zone (QOZ) as defined under the Tax Cuts and Jobs Act of 2017. True enables investment advisory teams to identify tax-advantaged investment opportunities and report to investors on QOZ portfolio exposure.',
    `plus4_code` STRING COMMENT 'Four-digit USPS ZIP+4 extension code that narrows the delivery area to a specific block face, building, or floor. Enhances address precision for mail delivery and is required for USPS bulk mailing discounts and DPV validation.. Valid values are `^[0-9]{4}$`',
    `postal_code` STRING COMMENT 'USPS ZIP code or ZIP+4 code for domestic US addresses, or equivalent postal code for international properties. Supports mail delivery, market area delineation, and GIS-based spatial analysis.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `source_system_code` STRING COMMENT 'The native identifier for this address record in the originating source system (e.g., Yardi Voyager property address ID, MRI address key, CoStar property address code). Enables cross-system reconciliation and ETL lineage tracing.',
    `state_province` STRING COMMENT 'Two-letter ISO 3166-2 state or province code (e.g., CA, NY, TX) in which the property is located. Used for state-level regulatory compliance, tax reporting, and portfolio geographic segmentation.',
    `tax_parcel_number` STRING COMMENT 'Assessors Parcel Number (APN) or tax parcel identification number assigned by the county assessors office. Links the address to property tax records, title searches, and ALTA surveys. Used in Yardi Voyager fixed asset and property tax modules.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, America/Los_Angeles). Used for scheduling property inspections, maintenance work orders in Building Engines, lease commencement date calculations, and multi-timezone portfolio reporting.',
    `transit_score` STRING COMMENT 'Transit Score rating (0–100) for the address location measuring access to public transportation. Used in tenant demand analysis, property valuation inputs, and ESG reporting on sustainable location attributes for LEED and BREEAM certifications.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this address record was last modified in the enterprise data platform. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance.',
    `usps_standardized` BOOLEAN COMMENT 'Indicates whether the address has been standardized according to USPS Publication 28 postal addressing standards. True means the address conforms to USPS format and has passed DPV validation. Used for mail deliverability and regulatory reporting quality assurance.',
    `validation_status` STRING COMMENT 'Current USPS or third-party address standardization and validation status. Validated indicates the address has been confirmed against the USPS Delivery Point Validation (DPV) database. Failed indicates the address could not be matched. Corrected indicates the address was auto-corrected during standardization.. Valid values are `validated|unvalidated|failed|corrected|pending`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when this address was last validated or re-validated against USPS DPV or a third-party address verification service. Used to assess address data freshness and trigger re-validation workflows when the timestamp exceeds a defined staleness threshold.',
    `walk_score` STRING COMMENT 'Walk Score rating (0–100) for the address location measuring pedestrian accessibility to amenities. Used in tenant demand analysis, property marketing, and investment advisory scoring for commercial and residential assets. Sourced from Walk Score API or CoStar.',
    `zoning_jurisdiction` STRING COMMENT 'Name of the local government authority (municipality, county, or special district) with zoning jurisdiction over the address. Critical for development feasibility, permitting, and regulatory compliance tracking in Procore and SAP S/4HANA project systems.',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Standardized physical address record for properties, buildings, parcels, and units. Captures address line 1, address line 2, city, county, state/province, postal code, country, USPS standardization status, geocode latitude, geocode longitude, geocode accuracy level, MSA (Metropolitan Statistical Area) code, submarket name, neighborhood name, and address validation timestamp. Supports GIS integration, market analysis, and regulatory reporting. One asset or building may have multiple addresses (e.g., corner properties with multiple street frontages).';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`property_ownership_interest` (
    `property_ownership_interest_id` BIGINT COMMENT 'Unique surrogate identifier for each ownership interest record in the property ownership interest registry. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the property asset for which this ownership interest is recorded. Links the ownership interest to the property master registry.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Equity contributions, allocated debt amounts, and preferred return calculations on ownership interests require a currency reference for multi-currency fund consolidation and investor capital account r',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (LLC, LP, REIT, trust, individual) through which the ownership interest is held. Supports multi-entity ownership structures including joint ventures and fund ownership.',
    `owner_id` BIGINT COMMENT 'Reference to the owner entity holding this ownership interest. Bridges the property domain to the owner domain.',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Tenure type (freehold, leasehold, fee simple, ground lease) on ownership interests is required for title insurance policy selection, CMBS eligibility, REIT compliance, and SNDA requirement determinati',
    `title_record_id` BIGINT COMMENT 'Foreign key linking to property.title_record. Business justification: An ownership interest in a real estate asset is legally evidenced by a title record (deed, title policy). property_ownership_interest currently has title_policy_number and deed_reference_number as str',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'The total purchase price or cost basis allocated to this ownership interest at the time of acquisition, in the reporting currency. Used for depreciation, gain/loss on sale, and Capital Expenditure (CAPEX) tracking in Yardi Voyager Fixed Assets and Argus Enterprise.',
    `acquisition_date` DATE COMMENT 'The date on which the ownership interest was acquired or the title was vested. Used for holding period calculations, capital gains tax determination, and depreciation schedules under FASB ASC 360.',
    `allocated_debt_amount` DECIMAL(18,2) COMMENT 'The portion of property-level debt (mortgage, CMBS, or other financing) allocated to this ownership interest based on the ownership percentage. Used for Loan-to-Value (LTV) ratio calculations and Debt Service Coverage Ratio (DSCR) reporting in Argus Enterprise.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ownership interest record was first created in the data platform. Used for audit trail, data lineage, and SOX compliance controls.',
    `deed_reference_number` STRING COMMENT 'The recorded deed book and page number or instrument number from the county recorders office that evidences this ownership interest. Critical for title chain of custody and legal due diligence.',
    `disposition_date` DATE COMMENT 'The date on which the ownership interest was disposed of, transferred, or relinquished. Null if the interest is currently active. Used for gain/loss on sale calculations and portfolio reporting.',
    `distribution_priority` STRING COMMENT 'The numeric priority rank of this ownership interest in the waterfall distribution structure (1 = highest priority). Determines the order in which distributions are made among multiple interest holders in joint ventures and fund structures.',
    `effective_date` DATE COMMENT 'The date on which this ownership interest record becomes legally effective and binding. May differ from acquisition date in cases of retroactive title corrections or delayed closing settlements.',
    `encumbrance_description` STRING COMMENT 'Narrative description of any liens, mortgages, easements, covenants, or other encumbrances affecting this ownership interest. Sourced from ALTA title search results and legal due diligence documentation.',
    `equity_contribution_amount` DECIMAL(18,2) COMMENT 'The total equity capital contributed by the owner entity for this ownership interest, net of debt financing. Used for Return on Investment (ROI), Internal Rate of Return (IRR), and Net Asset Value (NAV) calculations in Argus Enterprise and MRI Software.',
    `expiry_date` DATE COMMENT 'The date on which this ownership interest is scheduled to expire or terminate, applicable for leasehold interests, ground leases, and time-limited easements. Null for fee simple and perpetual interests.',
    `interest_reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this ownership interest record, as tracked in Yardi Voyager or MRI Software. Used for cross-system reconciliation and title documentation.',
    `is_controlling_interest` BOOLEAN COMMENT 'Indicates whether this ownership interest constitutes a controlling interest in the property or owning entity, triggering consolidation requirements under FASB ASC 810. True if controlling; False if non-controlling (minority interest).',
    `is_managing_member` BOOLEAN COMMENT 'Indicates whether the owner entity holding this interest serves as the managing member or general partner of the ownership structure, with authority over day-to-day property management decisions.',
    `ownership_notes` STRING COMMENT 'Free-text field for additional context, legal annotations, or special conditions associated with this ownership interest record, such as pending litigation, regulatory restrictions, or investor-specific terms not captured in structured fields.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total ownership interest held by the owner entity in this property, expressed as a decimal (e.g., 50.0000 for 50%). All active ownership interests for a given property should sum to 100%. Critical for pro-rata income allocation, NOI distribution, and REIT reporting.',
    `ownership_status` STRING COMMENT 'Current lifecycle status of the ownership interest record. Active indicates the interest is currently held; transferred indicates the interest has been conveyed to another party; dissolved indicates the owning entity has been wound down; pending indicates a transaction in progress; encumbered indicates the interest is subject to a lien or restriction.. Valid values are `active|transferred|dissolved|pending|encumbered`',
    `ownership_structure` STRING COMMENT 'The legal and organizational structure under which the ownership interest is held. Supports complex arrangements including joint ventures (JV), tenancy-in-common (TIC), Real Estate Investment Trust (REIT) structures, and fund ownership. [ENUM-REF-CANDIDATE: sole_ownership|joint_venture|tic|reit|fund|partnership|trust — promote to reference product]',
    `preferred_return_rate` DECIMAL(18,2) COMMENT 'The annual preferred return rate (expressed as a percentage) to which this ownership interest is entitled before residual distributions are made to other interest holders. Common in joint venture and fund structures. Used in waterfall distribution modeling in Argus Enterprise.',
    `recording_jurisdiction` STRING COMMENT 'The county, parish, or municipality where the deed or title instrument for this ownership interest is recorded. Determines applicable property law, transfer taxes, and regulatory reporting requirements.',
    `snda_status` STRING COMMENT 'The execution status of the Subordination Non-Disturbance and Attornment Agreement (SNDA) associated with this ownership interest, which governs the relationship between the lender, owner, and tenants in the event of foreclosure.. Valid values are `executed|pending|not_required|waived`',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record from which this ownership interest record was sourced (e.g., Yardi Voyager, MRI Software, Argus Enterprise, SAP S/4HANA, or manual entry). Used for data lineage and reconciliation in the Silver Layer.. Valid values are `yardi|mri|argus|sap|manual`',
    `source_system_record_code` STRING COMMENT 'The native record identifier for this ownership interest in the originating operational system (e.g., Yardi entity code, MRI ownership record ID). Enables traceability from the Silver Layer back to the system of record.',
    `title_company_name` STRING COMMENT 'The name of the title insurance company that issued the title policy for this ownership interest. Used for title claim escalation and due diligence tracking.',
    `title_policy_number` STRING COMMENT 'The policy number of the title insurance policy issued by the title company at the time of acquisition, as referenced in ALTA title commitments. Used for title claim management and due diligence.',
    `title_vesting_language` STRING COMMENT 'The exact legal language used in the deed or title instrument to describe how title is vested in the owner entity (e.g., as joint tenants with right of survivorship, as tenants in common). Sourced from ALTA title commitments and closing documents managed in DocuSign CLM.',
    `transfer_restriction_flag` BOOLEAN COMMENT 'Indicates whether this ownership interest is subject to transfer restrictions, right of first refusal (ROFR), or lock-up provisions that limit the owners ability to sell or assign the interest. True if restricted; False if freely transferable.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ownership interest record was last modified in the data platform. Used for change tracking, incremental data loads, and audit compliance.',
    `voting_rights_percentage` DECIMAL(18,2) COMMENT 'The percentage of voting rights held by this ownership interest, which may differ from the economic ownership percentage in certain joint venture or preferred equity structures. Used for consolidation analysis under FASB ASC 810.',
    CONSTRAINT pk_property_ownership_interest PRIMARY KEY(`property_ownership_interest_id`)
) COMMENT 'Records the ownership interest structure for each real estate asset — capturing who owns what percentage of each property and under what legal structure. Supports complex ownership arrangements including joint ventures, tenancy-in-common (TIC), REIT structures, and fund ownership. Captures owner entity reference, ownership percentage, ownership type (fee simple, leasehold, ground lease, easement), legal entity name, legal entity type (LLC, LP, REIT, individual), acquisition date, disposition date, ownership status (active, transferred, dissolved), and title vesting language. Bridges the property domain to the owner domain.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`title_record` (
    `title_record_id` BIGINT COMMENT 'Unique surrogate identifier for each title record entry in the enterprise title registry. Primary key for the title_record data product.',
    `asset_id` BIGINT COMMENT 'Reference to the property asset for which this title record is maintained. Links the title record to the master property registry.',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to reference.document_type. Business justification: Deed type (warranty deed, quitclaim, grant deed) is a document type classification used in title examination workflows, recording compliance, and retention policy enforcement. deed_type on title_recor',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Title records are legally tied to specific land parcels — a deed, encumbrance, or title policy applies to a specific parcel of land. title_record currently has a parcel_number string field which is a ',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Vesting type (joint tenancy, tenants in common, fee simple) in title records maps to tenure type — used in title examination workflows, ownership transfer compliance, and lender due diligence. vesting',
    `chain_of_title_notes` STRING COMMENT 'Free-text narrative summarizing the historical sequence of ownership transfers and any notable gaps, breaks, or anomalies identified in the chain of title examination. Critical for transaction due diligence.',
    `county_recorder_jurisdiction` STRING COMMENT 'Name of the county or local government jurisdiction where the deed and title instruments are recorded. Determines the applicable recording laws, fees, and public record access procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this title record was first created in the enterprise data platform. Supports audit trail, data lineage, and SOX compliance requirements.',
    `deed_book` STRING COMMENT 'Official deed book number or volume identifier as recorded in the county recorders office. Used in conjunction with deed_page to locate the physical or digital deed instrument in public records.',
    `deed_page` STRING COMMENT 'Official deed page number within the deed book as recorded in the county recorders office. Combined with deed_book provides the precise public record locator for the deed instrument.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the encumbrance recorded against the property, such as the outstanding principal of a mortgage lien, the amount of a mechanics lien claim, or the assessed amount of a tax lien. Expressed in USD.',
    `encumbrance_grantee` STRING COMMENT 'Legal name of the party receiving the benefit of the encumbrance (e.g., lender receiving a mortgage lien, utility company receiving an easement). Used for lien holder identification and release coordination.',
    `encumbrance_grantor` STRING COMMENT 'Legal name of the party granting the encumbrance (e.g., property owner granting an easement, borrower granting a mortgage lien). Used for due diligence and lien release tracking.',
    `encumbrance_maturity_date` DATE COMMENT 'Date on which the encumbrance is scheduled to mature or expire by its own terms (e.g., loan maturity date for a mortgage lien, expiration date for a temporary easement). Null for perpetual encumbrances.',
    `encumbrance_recording_date` DATE COMMENT 'Date on which the encumbrance instrument was officially recorded with the county recorder. Establishes the legal priority position of the encumbrance relative to other recorded interests.',
    `encumbrance_recording_number` STRING COMMENT 'Official instrument number assigned by the county recorder when the encumbrance instrument (lien, easement, restriction) was recorded. Used to locate the encumbrance in public records.',
    `encumbrance_release_date` DATE COMMENT 'Date on which the encumbrance was formally released, discharged, or satisfied and the release instrument was recorded. Null if the encumbrance remains active. Used to confirm clear title status.',
    `encumbrance_status` STRING COMMENT 'Current status of the encumbrance recorded against the property title. Active indicates the encumbrance is in force; released indicates it has been formally discharged; expired indicates it lapsed by its own terms; disputed indicates it is subject to legal challenge.. Valid values are `active|released|expired|disputed`',
    `encumbrance_type` STRING COMMENT 'Classification of the encumbrance recorded against the property title. [ENUM-REF-CANDIDATE: mortgage_lien|mechanics_lien|tax_lien|easement|deed_restriction|ccr|right_of_way|ground_lease|judgment_lien|lis_pendens — promote to reference product]',
    `environmental_lien_flag` BOOLEAN COMMENT 'Indicates whether an environmental lien or notice of environmental action has been recorded against the property by the EPA or a state environmental agency. Critical for acquisition due diligence and ESG compliance.',
    `grantee_name` STRING COMMENT 'Legal name of the party receiving title (buyer or transferee) as recorded on the deed instrument. Identifies the current or incoming owner of record for chain of title purposes.',
    `grantor_name` STRING COMMENT 'Legal name of the party conveying title (seller or transferor) as recorded on the deed instrument. Critical for chain of title verification and due diligence.',
    `legal_description` STRING COMMENT 'Full legal description of the property as it appears on the recorded deed, including metes and bounds, lot and block, or government survey description. Required for title examination and conveyancing.',
    `lis_pendens_flag` BOOLEAN COMMENT 'Indicates whether a lis pendens (notice of pending litigation) has been recorded against the property. A lis pendens clouds title and must be resolved prior to any sale or refinancing.',
    `policy_amount` DECIMAL(18,2) COMMENT 'Dollar amount of coverage provided under the title insurance policy, typically equal to the purchase price (owners policy) or loan amount (lenders policy). Expressed in USD.',
    `policy_effective_date` DATE COMMENT 'Date on which the title insurance policy became effective, typically the date of closing or recording. Establishes the coverage commencement date for claims purposes.',
    `policy_expiry_date` DATE COMMENT 'Date on which the title insurance policy expires or is no longer in force. Null for perpetual owners policies. Populated for lender policies tied to loan maturity.',
    `policy_number` STRING COMMENT 'Unique policy number assigned by the title insurance company for the title insurance policy covering this property. Used for claims filing, policy retrieval, and underwriting reference.',
    `policy_type` STRING COMMENT 'Classification of the title insurance policy per American Land Title Association (ALTA) standards. Distinguishes between owners policies protecting the buyer and lenders policies protecting the mortgagee.. Valid values are `alta_owner|alta_lender|alta_extended|leasehold_owner|leasehold_lender`',
    `priority_position` STRING COMMENT 'Numeric lien priority position of the encumbrance relative to other recorded interests on the property (e.g., 1 = first lien, 2 = second lien). Determines payment order in foreclosure or disposition proceedings.',
    `recording_date` DATE COMMENT 'Date on which the deed or title instrument was officially recorded with the county recorder or land registry authority. Establishes the legal priority date for chain of title purposes.',
    `recording_number` STRING COMMENT 'Official instrument or document number assigned by the county recorder at the time of deed recordation. Unique identifier within the recorders jurisdiction for this recorded instrument.',
    `snda_on_file` BOOLEAN COMMENT 'Indicates whether a Subordination Non-Disturbance and Attornment Agreement (SNDA) has been executed and is on file for this property. Critical for lender underwriting and tenant protection in leveraged assets.',
    `source_system` STRING COMMENT 'Operational system of record from which this title record was originated or last updated. Supports data lineage, reconciliation, and audit trail requirements.. Valid values are `yardi_voyager|mri_software|docusign_clm|manual_entry`',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation (USPS standard) for the jurisdiction in which the property and title record are located. Used for regulatory compliance and jurisdictional routing.. Valid values are `^[A-Z]{2}$`',
    `survey_date` DATE COMMENT 'Date of the most recent ALTA/NSPS land title survey conducted for the property. Used to assess the currency of boundary and encumbrance information relative to current conditions.',
    `survey_on_file` BOOLEAN COMMENT 'Indicates whether a current ALTA/NSPS land title survey is on file for this property. Surveys are required for commercial transactions and lender underwriting to identify boundary issues, encroachments, and easement locations.',
    `title_company` STRING COMMENT 'Name of the title insurance company that issued the title insurance policy for this property. Used for claims management, underwriting reference, and vendor relationship tracking.',
    `title_examination_date` DATE COMMENT 'Date on which the most recent title examination or title search was completed by the title company or attorney. Indicates the currency of the title status and chain of title review.',
    `title_examiner` STRING COMMENT 'Name of the attorney, title officer, or title company representative who conducted the most recent title examination. Used for accountability and follow-up on title defects.',
    `title_number` STRING COMMENT 'Externally assigned title or certificate number issued by the county recorder or land registry authority. Serves as the official public record identifier for this title.',
    `title_opinion_on_file` BOOLEAN COMMENT 'Indicates whether a formal attorneys title opinion letter is on file for this property. Title opinions are required by certain lenders and in states where attorney title opinions substitute for title insurance.',
    `title_status` STRING COMMENT 'Current status of the title indicating whether ownership is unencumbered and marketable. Values: clear (no outstanding encumbrances), encumbered (active liens or restrictions), in_dispute (ownership contested), pending_release (encumbrance release in process), under_review (title examination ongoing).. Valid values are `clear|encumbered|in_dispute|pending_release|under_review`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this title record was most recently modified in the enterprise data platform. Used for change tracking, incremental data loads, and audit compliance.',
    CONSTRAINT pk_title_record PRIMARY KEY(`title_record_id`)
) COMMENT 'Title, deed, and encumbrance registry for each real estate asset — the single source of truth for chain of title, all recorded encumbrances, and title insurance details. Stores deed type (warranty, quitclaim, grant, special warranty), deed book and page reference, recording date and number, county recorder jurisdiction, title company, policy number, policy type (ALTA owner, ALTA lender), policy amount, effective date, and title status (clear, encumbered, in dispute). SSOT for all encumbrances recorded against the asset: liens (mortgage lien, mechanics lien, tax lien), easements, deed restrictions, CC&Rs, rights-of-way, and ground lease encumbrances — with recording details, priority position, grantor/grantee, encumbrance amounts, maturity dates, release dates, and encumbrance status (active, released, expired, disputed). Critical for transaction due diligence, lender underwriting, SNDA management, and regulatory compliance.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Primary key for inspection',
    `asset_id` BIGINT COMMENT 'Reference to the property asset being inspected. Links the inspection record to the master property registry.',
    `building_id` BIGINT COMMENT 'Reference to the specific building within a multi-building property that is the subject of this inspection. Nullable for land-only or portfolio-level inspections.',
    `common_area_id` BIGINT COMMENT 'Foreign key linking to property.common_area. Business justification: Common areas (lobbies, hallways, elevators, shared facilities) require regular inspections for safety compliance, ADA compliance, and CAM cost justification. The inspection products inspection_scope ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Property inspections are directly tied to permits — final inspections close out building permits and COO issuance. Inspection.permit_number is a denormalized plain attr; replacing with FK to complianc',
    `debt_covenant_id` BIGINT COMMENT 'Foreign key linking to investment.debt_covenant. Business justification: Lenders impose physical condition covenants requiring periodic property inspections as compliance evidence. Linking inspection records directly to debt covenants supports covenant compliance tracking,',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Property inspections are triggered by development project milestones including COO inspections, pre-acquisition site inspections, and post-construction condition assessments. Linking property.inspecti',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to reference.document_type. Business justification: Inspection reports are classified by document type for retention policy enforcement, legal instrument status determination, and workflow routing in property management systems. New column document_typ',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Property inspections are triggered by lease events: move-in condition surveys, move-out inspections, and renewal condition assessments. Linking inspections to lease agreements enables lease-driven ins',
    `osha_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.osha_incident. Business justification: Post-incident safety inspections are a standard OSHA compliance workflow — an incident triggers a mandatory property inspection to assess hazards and verify corrective actions. Linking inspection to t',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Regulatory inspections (fire code, building code, environmental Phase I/II) are governed by specific regulatory frameworks — linking enables compliance tracking, penalty risk assessment, and regulator',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Mandatory inspections (fire safety, elevator, HVAC, ADA) are required by specific regulatory obligations. Linking inspection to regulatory_obligation enables compliance tracking of which obligation ma',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Inspections are conducted at multiple levels of the property hierarchy — asset, building, and individual unit. The existing FKs cover asset_id and building_id but not unit_id. Unit-level inspections a',
    `access_restrictions` STRING COMMENT 'Free-text description of any areas, systems, or components that were inaccessible during the inspection and therefore excluded from the assessment. Required per ASTM E2018 to document inspection limitations and scope exclusions.',
    `compliance_due_date` DATE COMMENT 'Deadline by which the inspection must be completed or deficiencies remediated to maintain regulatory compliance. Distinct from scheduled_date — this is the hard regulatory deadline, not the planned inspection date.',
    `condition_rating` STRING COMMENT 'Overall condition score assigned by the inspector on a standardized 1-to-5 scale where 1 = critical/poor and 5 = excellent. Used for asset valuation inputs, capital planning, insurance underwriting, and portfolio benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system. Serves as the audit trail creation marker for data governance, lineage tracking, and Silver Layer ingestion auditing.',
    `critical_deficiency_count` STRING COMMENT 'Number of deficiencies classified as critical — those posing immediate safety risk, regulatory non-compliance, or requiring urgent remediation within 30 days. Subset of deficiency_count. Drives escalation workflows and insurance notifications.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies, defects, or non-conformances identified during the inspection across all systems and areas assessed. Used to prioritize remediation planning and track property condition trends over time.',
    `end_time` TIMESTAMP COMMENT 'Precise date and time when the physical inspection was concluded on-site. Used together with inspection_start_time to compute inspection duration for billing and performance analytics.',
    `environmental_phase` STRING COMMENT 'For environmental inspections, identifies the ASTM Phase I, II, or III Environmental Site Assessment (ESA) stage. Phase I is a records review, Phase II involves physical sampling, Phase III is remediation. Not applicable for non-environmental inspection types.. Valid values are `phase_i|phase_ii|phase_iii|not_applicable`',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Inspectors estimated total cost in USD to remediate all identified deficiencies. Used for Capital Expenditure (CAPEX) budgeting, acquisition due diligence pricing adjustments, and insurance claim estimation. Classified confidential as it is commercially sensitive.',
    `frequency` STRING COMMENT 'Required or agreed recurrence interval for this inspection type at this property. Determines the cadence for next_inspection_date calculation and compliance calendar population.. Valid values are `annual|semi_annual|quarterly|monthly|biennial|as_needed`',
    `has_critical_deficiency` BOOLEAN COMMENT 'Boolean flag indicating whether the inspection identified at least one critical deficiency requiring immediate attention. True when critical_deficiency_count > 0. Used as a quick filter for escalation dashboards and executive reporting.',
    `immediate_repair_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for repairs that must be completed within 90 days to address critical deficiencies and safety hazards. Subset of estimated_remediation_cost. Used for short-term CAPEX planning and acquisition price negotiation.',
    `inspection_date` DATE COMMENT 'The actual calendar date on which the inspection was physically conducted. May differ from scheduled_date due to rescheduling. Null until the inspection is completed or in progress.',
    `inspection_number` STRING COMMENT 'Externally-known, human-readable business identifier for the inspection record. Used in reports, regulatory submissions, and communications with inspectors and authorities. Format: INSP-YYYY-NNNNNN.. Valid values are `^INSP-[0-9]{4}-[0-9]{6}$`',
    `inspection_scope` STRING COMMENT 'Defines the physical boundary and extent of the inspection. Determines which areas, systems, or components are included in the assessment. Drives checklist generation and report structure.. Valid values are `full_property|building_only|unit_only|common_areas|exterior_only|specific_system`',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection record. Drives workflow routing: scheduled triggers calendar reminders, in_progress locks the record for editing, completed enables report upload, failed triggers remediation work order creation, cancelled requires a reason code.. Valid values are `scheduled|in_progress|completed|failed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection by its primary purpose or regulatory category. Drives the checklist applied, the required inspector credentials, and the governing regulatory authority. [ENUM-REF-CANDIDATE: property_condition_assessment|fire_safety|elevator|hvac|environmental_phase_i|environmental_phase_ii|ada_compliance|roof|structural|seismic|electrical|plumbing|facade|pest|energy_audit — promote to reference product]',
    `inspector_company` STRING COMMENT 'Name of the third-party firm or organization that employs the inspector and is contracted to perform the inspection. Used for vendor management, insurance certificate tracking, and report attribution.',
    `inspector_license_number` STRING COMMENT 'Professional license or certification number of the lead inspector as issued by the relevant state or regulatory body. Required to validate inspector credentials for regulatory compliance and insurance purposes.',
    `inspector_name` STRING COMMENT 'Full name of the lead inspector who conducted the inspection. Required for regulatory submissions, report attribution, and liability tracking. Classified confidential as it identifies a professional individual.',
    `inspector_notes` STRING COMMENT 'Free-text field for the inspectors on-site observations, qualitative findings, and contextual commentary not captured in structured fields. Supplements the formal report with real-time field observations.',
    `internal_reviewer` STRING COMMENT 'Name of the internal Asset Manager (AM) or Property Manager (PM) responsible for reviewing the inspection report, validating findings, and approving remediation plans. Establishes internal accountability for follow-up actions.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this inspection is mandated by a government regulation, code, or regulatory authority. True for fire safety, elevator, and environmental inspections required by law. False for voluntary or insurance-driven inspections.',
    `leed_relevant` BOOLEAN COMMENT 'Indicates whether the findings of this inspection are relevant to the propertys LEED or BREEAM green building certification status. True for energy audits, HVAC inspections, and environmental assessments that may affect certification scores.',
    `long_term_repair_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for capital replacements and major repairs projected over a 3-to-10-year horizon. Used for long-range CAPEX planning, reserve studies, and asset lifecycle management.',
    `next_inspection_date` DATE COMMENT 'Date on which the next recurring or follow-up inspection is due for this property and inspection type. Drives automated scheduling reminders and regulatory compliance calendar management.',
    `pass_fail_result` STRING COMMENT 'Binary or conditional outcome of the inspection as determined by the inspector or regulatory authority. A fail result triggers mandatory remediation and re-inspection workflows. Conditional pass indicates compliance with conditions attached.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `reinspection_date` DATE COMMENT 'Planned date for the follow-up re-inspection to verify that deficiencies identified in this inspection have been remediated. Populated when reinspection_required is True.',
    `reinspection_required` BOOLEAN COMMENT 'Indicates whether a follow-up re-inspection is required after remediation of identified deficiencies. Typically set to True when pass_fail_result is fail or conditional_pass. Drives re-inspection scheduling workflow.',
    `report_document_ref` STRING COMMENT 'File path, URL, or document management system reference (e.g., DocuSign CLM, SharePoint, Procore) pointing to the formal inspection report document. Enables direct access to the full inspection report from the data record.',
    `report_issued_date` DATE COMMENT 'Date on which the formal inspection report was issued or delivered by the inspector or inspection firm. Used for SLA tracking, due diligence timeline management, and regulatory submission deadlines.',
    `report_version` STRING COMMENT 'Version identifier of the inspection report document (e.g., v1.0, v2.1). Tracks report revisions issued after initial delivery, such as updates following inspector corrections or additional findings.. Valid values are `^v[0-9]+.[0-9]+$`',
    `review_completed_date` DATE COMMENT 'Date on which the internal reviewer completed their review of the inspection report and approved or escalated findings. Used for SLA tracking between report receipt and internal action initiation.',
    `scheduled_date` DATE COMMENT 'The planned calendar date on which the inspection is expected to be conducted. Used for scheduling, resource planning, and regulatory compliance tracking of inspection frequency requirements.',
    `short_term_repair_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for repairs required within 1 to 2 years beyond the immediate repair window. Used for annual CAPEX budgeting and reserve fund planning in property management.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this inspection record originated. Used for data lineage tracking, reconciliation, and audit trail purposes in the Silver Layer lakehouse.. Valid values are `building_engines|yardi_voyager|procore|manual|mri_software`',
    `start_time` TIMESTAMP COMMENT 'Precise date and time when the physical inspection commenced on-site. Used for duration calculation, inspector billing, and audit trail purposes.',
    `trigger` STRING COMMENT 'Business reason or event that initiated this inspection. Distinguishes routine scheduled inspections from event-driven ones (e.g., acquisition due diligence, insurance renewal, tenant complaint, post-incident assessment). [ENUM-REF-CANDIDATE: scheduled|due_diligence|insurance_requirement|regulatory_mandate|tenant_request|incident_response|post_construction — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this inspection record. Used for change data capture (CDC), incremental ETL processing, and audit trail maintenance in the Databricks Silver Layer.',
    `work_order_triggered` BOOLEAN COMMENT 'Indicates whether this inspection has resulted in the creation of one or more maintenance work orders to address identified deficiencies. True when remediation work orders have been raised in Building Engines or Yardi.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Physical property and building inspection records capturing scheduled and ad-hoc inspections for due diligence, regulatory compliance, insurance requirements, and condition assessment. Captures inspection type (property condition assessment, fire safety, elevator, HVAC, environmental Phase I/II, ADA compliance, roof, structural, seismic), inspection date, inspector name, inspector company, inspection status (scheduled, in progress, completed, failed), overall condition rating (1-5 scale), deficiency count, critical deficiency flag, estimated remediation cost, report document reference, next scheduled inspection date, and regulatory authority (OSHA, EPA, local fire marshal). Distinct from maintenance work orders — inspections are formal assessments that may trigger work orders but are not repair events themselves.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`occupancy_record` (
    `occupancy_record_id` BIGINT COMMENT 'Unique surrogate identifier for each occupancy snapshot record in the silver layer. Serves as the primary key for this point-in-time or period occupancy record.',
    `uom_id` BIGINT COMMENT 'Foreign key linking to reference.uom. Business justification: Area measurement standard (BOMA, IPMS) is required for consistent occupancy reporting across international portfolios and NCREIF/INREV benchmarking submissions. New column area_uom_id created; no exis',
    `asset_id` BIGINT COMMENT 'Reference to the property (building or asset) for which this occupancy snapshot is recorded. Links to the property master registry.',
    `asset_performance_id` BIGINT COMMENT 'Foreign key linking to investment.asset_performance. Business justification: Asset performance calculations (NOI, cap rate, EGI) are derived from occupancy snapshots. Linking the source occupancy record to the asset performance period supports audit trail, data lineage reconci',
    `building_id` BIGINT COMMENT 'Foreign key linking to property.building. Business justification: Occupancy records capture point-in-time and period occupancy snapshots at multiple measurement levels (asset, building, unit). The existing FKs cover asset_id and unit_id but not building_id. The meas',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Financial occupancy metrics (potential gross income, effective gross income, vacancy loss) require a currency reference for multi-currency portfolio consolidation and investor reporting. currency_code',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Occupancy records track lease-up progress post-development. Linking to dev_project enables yield-on-cost calculations, stabilization tracking, and investor reporting on development outcomes — core met',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Occupancy reporting is segmented by property type for NCREIF benchmarking, investor reporting, and market analysis. asset_class on occupancy_record is a denormalized representation of the property_typ',
    `unit_id` BIGINT COMMENT 'Reference to the specific leasable unit within the property for which this occupancy record applies. Null when the record is at building/property level rather than unit level.',
    `area_under_notice_sqf` DECIMAL(18,2) COMMENT 'Total square footage of GLA where tenants have issued a notice to vacate but leases have not yet expired. Used alongside units_under_notice_count for forward vacancy exposure analysis and Argus cash flow modeling.',
    `average_in_place_rent_psf` DECIMAL(18,2) COMMENT 'Weighted average contractual base rent per square foot (PSF) across all occupied leases as of the snapshot date. Core metric for rent roll analysis, mark-to-market rent spread calculations, and NOI benchmarking against CoStar market comparables.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this occupancy record was first created in the silver layer data product. Supports audit trail requirements under SOX Section 302 and data lineage tracking in the Databricks lakehouse.',
    `credit_loss_amount` DECIMAL(18,2) COMMENT 'Dollar value of rental income lost due to tenant delinquency, bad debt, or credit concessions during the reporting period. Distinct from vacancy loss; reflects economic occupancy shortfall versus physical occupancy. Used in EGI and NOI calculations.',
    `data_quality_flag` STRING COMMENT 'Quality status of this occupancy record as assessed during silver layer ingestion. Clean records are validated against source system; estimated records use interpolated values; reconciling records have discrepancies under investigation; error records failed validation rules.. Valid values are `clean|estimated|reconciling|error`',
    `economic_occupancy_rate` DECIMAL(18,2) COMMENT 'Ratio of actual rent collected (or contractually due) to potential gross income (PGI) at 100% occupancy, expressed as a decimal. Accounts for rent concessions, free rent periods, and delinquencies. Critical for NOI calculations, DSCR covenant compliance, and investor reporting.',
    `effective_gross_income` DECIMAL(18,2) COMMENT 'Actual rental income after deducting vacancy loss and credit loss from PGI for the reporting period. EGI is the revenue basis for NOI calculations, DSCR covenant testing, and REIT FFO/AFFO reporting.',
    `gross_absorption_sqf` DECIMAL(18,2) COMMENT 'Total square footage of new leases commenced during the reporting period, without netting out space vacated. Measures leasing velocity and demand activity independent of move-outs. Used in CoStar market analytics and portfolio leasing reports.',
    `is_same_store` BOOLEAN COMMENT 'Flag indicating whether this property qualifies for same-store NOI comparison in the current reporting period (i.e., owned and stabilized for at least 12 consecutive months). Required for REIT same-store NOI reporting per NAREIT guidelines.',
    `is_stabilized` BOOLEAN COMMENT 'Flag indicating whether the property has reached stabilized occupancy (typically 90%+ physical occupancy for 90+ days). Stabilized assets are included in core portfolio NOI reporting; non-stabilized assets are tracked separately during lease-up.',
    `lease_expirations_sqf` DECIMAL(18,2) COMMENT 'Total square footage of leases scheduled to expire within the reporting period. Used for lease expiry schedule reporting, WALE/WALT calculations, and rollover risk assessment in Argus Enterprise cash flow models.',
    `lease_up_start_date` DATE COMMENT 'Date on which the property entered the active lease-up phase following construction completion or major repositioning. Null for stabilized assets. Used to track lease-up velocity and project stabilization timelines in Argus Enterprise.',
    `market_rent_psf` DECIMAL(18,2) COMMENT 'Estimated current market rent per square foot (PSF) for comparable space in the submarket as of the snapshot date, sourced from CoStar Suite or broker price opinions (BPO). Used to calculate mark-to-market rent spread and underwrite lease renewal assumptions in Argus.',
    `measurement_level` STRING COMMENT 'Granularity at which this occupancy record is measured — building-level for asset management dashboards, unit-level for rent roll reconciliation, portfolio-level for REIT investor reporting.. Valid values are `building|floor|unit|portfolio`',
    `net_absorption_sqf` DECIMAL(18,2) COMMENT 'Change in occupied area square footage between the current and prior reporting period (current occupied SQF minus prior occupied SQF). Positive values indicate demand exceeding supply; negative values indicate space being returned to market. Key CoStar market benchmarking metric.',
    `new_leases_sqf` DECIMAL(18,2) COMMENT 'Square footage of brand-new lease agreements (not renewals or expansions) that commenced during the reporting period. Distinguishes new demand from renewal activity for leasing performance attribution.',
    `occupied_area_sqf` DECIMAL(18,2) COMMENT 'Total square footage of GLA currently under an active lease or occupancy agreement as of the snapshot date. Core input for physical occupancy rate calculation and NOI modeling in Argus Enterprise.',
    `occupied_unit_count` STRING COMMENT 'Number of units currently under an active lease or occupancy agreement as of the snapshot date. Used for unit-based occupancy rate reporting in multifamily portfolios and MRI residential management.',
    `period_type` STRING COMMENT 'Granularity of the occupancy reporting period. Monthly periods support rent roll reconciliation; quarterly periods align with REIT FFO/AFFO investor reporting; point-in-time supports ad hoc snapshots.. Valid values are `monthly|quarterly|annual|point_in_time`',
    `physical_occupancy_rate` DECIMAL(18,2) COMMENT 'Ratio of physically occupied area to total GLA, expressed as a decimal (e.g., 0.9250 = 92.50%). Measures actual space utilization regardless of rent collection status. Key metric for asset management dashboards and REIT same-store comparisons.',
    `potential_gross_income` DECIMAL(18,2) COMMENT 'Total rental income the property would generate if 100% occupied at market rent for the full reporting period. PGI is the starting point for NOI calculations and EGI derivation in Argus Enterprise cash flow models.',
    `record_status` STRING COMMENT 'Lifecycle status of this occupancy record within the data pipeline. Draft records are pending validation; published records are approved for investor reporting; superseded records have been replaced by a revised snapshot for the same period.. Valid values are `draft|published|revised|superseded|void`',
    `renewal_leases_sqf` DECIMAL(18,2) COMMENT 'Square footage of lease renewals executed during the reporting period. Supports tenant retention rate analysis, WALE/WALT calculations, and same-store NOI stability assessment.',
    `reporting_period_end_date` DATE COMMENT 'The last calendar date of the reporting period (month or quarter) covered by this occupancy snapshot. Together with start date defines the exact measurement window.',
    `reporting_period_start_date` DATE COMMENT 'The first calendar date of the reporting period (month or quarter) covered by this occupancy snapshot. Used for same-store NOI comparisons and REIT FFO/AFFO period alignment.',
    `snapshot_date` DATE COMMENT 'The specific calendar date on which the occupancy measurement was captured or as-of date for point-in-time snapshots. Enables historical trend analysis and WALE/WALT calculations.',
    `source_system` STRING COMMENT 'Operational system of record from which this occupancy data was extracted (e.g., Yardi Voyager, MRI Software, RealPage). Required for data lineage, reconciliation, and audit trail in the Databricks silver layer.. Valid values are `Yardi Voyager|MRI Software|RealPage|Argus Enterprise|Manual`',
    `source_system_record_code` STRING COMMENT 'The native identifier of this occupancy record in the originating source system (e.g., Yardi Voyager property occupancy record ID, MRI occupancy snapshot key). Enables reconciliation between the silver layer and the operational system of record.',
    `stabilization_date` DATE COMMENT 'Date on which the property first achieved stabilized occupancy status. Marks the transition from lease-up to core portfolio reporting. Used for same-store inclusion eligibility and investment performance benchmarking.',
    `total_gla_sqf` DECIMAL(18,2) COMMENT 'Total Gross Leasable Area (GLA) of the property or unit in square feet as of the snapshot date. GLA is the standard denominator for occupancy rate calculations, NOI per square foot (PSF) analysis, and CAP rate benchmarking.',
    `total_nla_sqf` DECIMAL(18,2) COMMENT 'Total Net Leasable Area (NLA) of the property or unit in square feet, excluding common areas and building core. NLA is used for NNN lease calculations, CAM reconciliation, and tenant PSF rent comparisons.',
    `total_unit_count` STRING COMMENT 'Total number of leasable units within the property or building as of the snapshot date. Used as the denominator for unit-based occupancy rate calculations in multifamily and mixed-use assets tracked in MRI Software.',
    `units_under_notice_count` STRING COMMENT 'Number of units where the tenant has issued a notice to vacate but the lease has not yet expired. Critical for forward-looking vacancy forecasting, WALE/WALT calculations, and leasing team pipeline management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this occupancy record was last modified in the silver layer, including revisions, restatements, or data quality corrections. Required for change data capture (CDC) and SOX audit trail compliance.',
    `vacancy_loss_amount` DECIMAL(18,2) COMMENT 'Dollar value of rental income lost due to vacant space during the reporting period (PGI minus income from occupied space). Used in NOI statements, EGI calculations, and investor reporting for portfolio performance monitoring.',
    `vacant_area_sqf` DECIMAL(18,2) COMMENT 'Total square footage of GLA not under any active lease or occupancy agreement as of the snapshot date. Equals total GLA minus occupied area. Used for vacancy loss calculations in NOI statements and EGI modeling.',
    `vacant_unit_count` STRING COMMENT 'Number of units not under any active lease or occupancy agreement as of the snapshot date. Equals total unit count minus occupied unit count. Supports vacancy trend analysis and leasing pipeline prioritization.',
    `wale_years` DECIMAL(18,2) COMMENT 'Weighted Average Lease Expiry (WALE) in years as of the snapshot date, weighted by GLA. Measures the average time until leases expire across the occupied portfolio. Core metric for REIT investor reporting, debt covenant compliance, and asset management risk assessment.',
    `walt_years` DECIMAL(18,2) COMMENT 'Weighted Average Lease Term (WALT) in years as of the snapshot date, weighted by GLA. Measures the average remaining lease term across the occupied portfolio. Distinct from WALE in that it reflects the full contracted term rather than expiry proximity. Used in Argus Enterprise DCF modeling.',
    CONSTRAINT pk_occupancy_record PRIMARY KEY(`occupancy_record_id`)
) COMMENT 'Point-in-time and period occupancy snapshots for buildings and units — the transactional record capturing physical and economic occupancy rates for NOI calculations, investor reporting, and portfolio performance monitoring. Each record represents one reporting period (month or quarter) for one building or unit. Captures total leasable area SQF, occupied area SQF, vacant area SQF, physical occupancy rate, economic occupancy rate, occupied unit count, vacant unit count, units under notice, net absorption SQF, and data source system (Yardi Voyager, MRI, RealPage). Supports WALE/WALT calculations, REIT FFO/AFFO reporting, same-store NOI comparisons, rent roll reconciliation, and asset management dashboards.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`asset_hierarchy` (
    `asset_hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each node in the asset hierarchy structure. Primary key for the asset_hierarchy data product. Entity role: MASTER_RESOURCE — represents a hierarchical node (fund, portfolio, sub-portfolio, market, submarket, region, or asset) that the enterprise owns, manages, or reports against.',
    `asset_id` BIGINT COMMENT 'Reference to the underlying real estate asset (property) when the node_type is asset. Links the hierarchy node to the master property record in the property domain. Null for non-asset nodes (fund, portfolio, sub-portfolio, market, submarket, region).',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: AUM and GAV reporting at hierarchy nodes requires a currency reference for multi-currency fund consolidation, FX translation, and investor reporting. currency_code on asset_hierarchy is a denormalized',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund entity that owns or sponsors this hierarchy node. Populated for all nodes that roll up to a specific fund vehicle (REIT, closed-end fund, open-end fund). Supports AUM reporting, SEC REIT segment disclosures, and fund-level GAV/NAV calculations.',
    `geographic_hierarchy_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_hierarchy. Business justification: Portfolio hierarchy nodes are organized by geographic market for geographic roll-up reporting, market allocation analysis, and fund geographic mandate compliance. geographic_region, market_name, subma',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity (SPV, LLC, LP, REIT) that holds title or operational responsibility for this hierarchy node. Critical for financial consolidation, SOX compliance, and SEC regulatory reporting. Aligns with SAP S/4HANA legal entity structure.',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: Portfolio hierarchy nodes are classified by investment strategy/market segment (core, value-add, opportunistic) for fund reporting, investor communications, and INREV/NCREIF strategy classification. i',
    `parent_node_asset_hierarchy_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent node in the hierarchy tree. Null for root-level nodes (e.g., fund-level). Enables recursive traversal for roll-up reporting from individual asset to fund level, supporting AUM calculations and REIT segment disclosures.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Portfolio-level AUM attribution, GAV reporting, and investment strategy segmentation require hierarchy nodes to be mapped directly to portfolios. asset_hierarchy already links to fund; adding portfoli',
    `primary_prior_parent_node_asset_hierarchy_id` BIGINT COMMENT 'Reference to the previous parent node before a hierarchy restructuring event. Populated when a node is moved to a different parent (e.g., asset transferred between portfolios, sub-portfolio merged). Enables historical hierarchy reconstruction and audit trail for organizational changes.',
    `approved_by` STRING COMMENT 'Name or identifier of the investment committee member, asset manager, or authorized approver who approved the creation or restructuring of this hierarchy node. Required for governance and SOX internal controls over financial reporting hierarchy changes.',
    `approved_date` DATE COMMENT 'Date on which the creation or restructuring of this hierarchy node was formally approved by the investment committee or authorized governance body. Supports SOX internal controls documentation and audit trail for hierarchy governance.',
    `argus_portfolio_code` STRING COMMENT 'Corresponding portfolio or asset code in Argus Enterprise that maps to this hierarchy node. Enables cross-system reconciliation for valuation, cash flow modeling, and investment analysis between Argus Enterprise and the Databricks Silver layer.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    `aum_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy nodes assets are included in the enterprises reported Assets Under Management (AUM) figure. True = included in AUM calculation; False = excluded (e.g., third-party managed assets, assets under disposition). Drives AUM reporting for investor relations and regulatory disclosures.',
    `benchmark_index` STRING COMMENT 'Name of the performance benchmark index against which this hierarchy node is measured (e.g., NCREIF NPI, MSCI Real Estate, FTSE NAREIT All Equity REITs, ODCE). Used for relative performance reporting, IRR benchmarking, and investor reporting. Populated primarily at fund and portfolio levels.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the geographic location of this hierarchy node (e.g., USA, GBR, DEU). Required for international portfolio reporting, GDPR compliance scoping, and cross-border investment analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the system. Satisfies MASTER_RESOURCE RECORD_AUDIT_CREATED category. Used for audit trail, data lineage, and SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_source` STRING COMMENT 'Identifies the operational system of record from which this hierarchy node record was sourced or is primarily maintained. Supports data lineage tracking, reconciliation, and Silver layer provenance in the Databricks Lakehouse.. Valid values are `yardi|mri|argus|manual|sap|costar`',
    `effective_from_date` DATE COMMENT 'Date on which this hierarchy node relationship became effective. Captures when an asset was added to a portfolio, when a fund was established, or when a restructuring took effect. Essential for point-in-time reporting, WALE calculations, and historical AUM/GAV/NAV analysis.',
    `effective_to_date` DATE COMMENT 'Date on which this hierarchy node relationship ceased to be effective. Null for currently active nodes. Populated when an asset is disposed, a portfolio is dissolved, or a restructuring removes the node. Enables historical point-in-time hierarchy reconstruction for regulatory and audit purposes.',
    `esg_classification` STRING COMMENT 'ESG classification of this hierarchy node indicating its sustainability profile. green = meets ESG/LEED/BREEAM criteria; brown = does not meet ESG criteria; transition = undergoing ESG improvement program; not_classified = ESG assessment not yet completed. Used for ESG reporting, green bond compliance, and investor ESG mandates.. Valid values are `green|brown|transition|not_classified`',
    `gav_basis` STRING COMMENT 'Valuation basis used to calculate the Gross Asset Value (GAV) for this hierarchy node. cost = historical cost basis; fair_value = mark-to-market per IFRS 13/ASC 820; appraised = independent appraisal value; book_value = net book value after depreciation. Determines how GAV rolls up through the hierarchy for NAV and investor reporting.. Valid values are `cost|fair_value|appraised|book_value`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this node within the hierarchy tree, where 1 = root (fund level) and higher numbers represent deeper levels (e.g., 2 = portfolio, 3 = sub-portfolio, 4 = market, 5 = submarket, 6 = asset). Used to control roll-up aggregation depth and filter reporting by organizational tier.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain from root to this node (e.g., FUND_001/PORT_003/SUBPORT_007/ASSET_042). Enables efficient subtree queries without recursive joins, supporting fast roll-up reporting in Databricks Silver layer analytics.',
    `hierarchy_status` STRING COMMENT 'Current lifecycle state of the hierarchy node. active = node is live and included in all roll-ups; restructured = node has been reorganized but historical data is preserved; dissolved = node no longer exists (fund wound down, portfolio merged); pending = node is being set up but not yet operational; suspended = temporarily excluded from reporting. Satisfies MASTER_RESOURCE LIFECYCLE_STATUS category.. Valid values are `active|restructured|dissolved|pending|suspended`',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether this hierarchy node is included in the consolidated financial statements of the parent legal entity. True = node is fully consolidated per FASB ASC 810; False = node is accounted for under equity method or excluded. Drives financial consolidation logic in SAP S/4HANA.',
    `is_reportable_segment` BOOLEAN COMMENT 'Indicates whether this hierarchy node constitutes a reportable segment for SEC and FASB ASC 280 segment reporting purposes. True = this node is disclosed as a separate segment in financial statements and REIT filings. Critical for publicly traded REITs to identify which nodes require standalone segment disclosures.',
    `mri_hierarchy_code` STRING COMMENT 'Corresponding investment hierarchy or portfolio code in MRI Software that maps to this hierarchy node. Enables cross-system reconciliation for investment management, property accounting, and residential management reporting between MRI Software and the Databricks Silver layer.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    `node_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this hierarchy node across systems (e.g., Yardi Voyager property tree code, MRI Software investment hierarchy code, Argus Enterprise portfolio code). Used as the business key for cross-system reconciliation and regulatory reporting. Satisfies MASTER_RESOURCE BUSINESS_IDENTIFIER category.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `node_name` STRING COMMENT 'Human-readable name of the hierarchy node (e.g., Core Plus Fund II, Northeast Portfolio, Manhattan Submarket, One Liberty Plaza). Used in investment reports, AUM dashboards, GAV/NAV roll-ups, and REIT segment disclosures. Satisfies MASTER_RESOURCE IDENTITY_LABEL category.',
    `node_type` STRING COMMENT 'Classification of the hierarchy node indicating its role in the investment and operational structure. fund = top-level investment vehicle (REIT, closed-end fund); portfolio = grouping of assets within a fund; sub_portfolio = subset of a portfolio; market = major geographic market (e.g., New York MSA); submarket = geographic submarket (e.g., Midtown Manhattan); region = operational region; asset = individual property asset. Drives roll-up logic for AUM, GAV, NOI reporting. Satisfies MASTER_RESOURCE CLASSIFICATION_OR_TYPE category. [ENUM-REF-CANDIDATE: fund|portfolio|sub_portfolio|market|submarket|region|asset — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional business context, special instructions, or commentary about this hierarchy node. May include investment thesis notes, restructuring rationale, or operational considerations not captured in structured fields. Used by asset managers and portfolio managers for qualitative documentation.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage ownership interest held by the enterprise in this hierarchy node (0.00 to 100.00). Used for proportional consolidation, AUM calculations, and investor reporting. Critical for joint venture structures where ownership is less than 100%. Classified as confidential due to sensitive investment structure information.',
    `reit_segment_code` STRING COMMENT 'Segment code assigned to this hierarchy node for SEC REIT segment reporting purposes. Maps to the segment codes disclosed in the REITs 10-K, 10-Q, and supplemental operating data filings. Required for publicly traded REITs to comply with FASB ASC 280 and SEC disclosure requirements.. Valid values are `^[A-Z0-9_-]{1,20}$`',
    `restructure_reason` STRING COMMENT 'Business reason or description explaining why this hierarchy node was restructured, dissolved, or had its parent changed. Populated when hierarchy_status is restructured or dissolved. Provides audit trail for organizational changes, fund wind-downs, portfolio mergers, and asset dispositions.',
    `sort_order` STRING COMMENT 'Numeric ordering sequence for sibling nodes at the same hierarchy level under the same parent. Controls display order in investment reports, portfolio dashboards, and regulatory filings. Allows business users to control the presentation sequence of nodes without altering the hierarchy structure.',
    `target_allocation_pct` DECIMAL(18,2) COMMENT 'Target percentage allocation of capital to this hierarchy node within its parent portfolio or fund (0.00 to 100.00). Used for portfolio construction, rebalancing decisions, and investment strategy compliance monitoring. Classified as confidential due to proprietary investment strategy information.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was last modified. Used for change tracking, incremental data pipeline processing in Databricks Silver layer, and audit trail compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `version_number` STRING COMMENT 'Incrementing version number for this hierarchy node record, supporting slowly changing dimension (SCD Type 2) tracking in the Databricks Silver layer. Increments each time the nodes attributes or parent relationship changes, enabling point-in-time hierarchy reconstruction for historical reporting.',
    `yardi_tree_code` STRING COMMENT 'Corresponding property tree or entity code in Yardi Voyager that maps to this hierarchy node. Enables cross-system reconciliation between the Databricks Silver layer hierarchy and the Yardi Voyager source system for property management, lease administration, and financial reporting.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    CONSTRAINT pk_asset_hierarchy PRIMARY KEY(`asset_hierarchy_id`)
) COMMENT 'Hierarchical relationship structure organizing real estate assets into portfolios, funds, sub-portfolios, and geographic clusters for investment management, regulatory reporting, and operational roll-ups. Captures hierarchy node name, hierarchy node type (fund, portfolio, sub-portfolio, market, submarket, region, asset), parent node reference, hierarchy level number, effective date, end date, and hierarchy status (active, restructured, dissolved). Enables roll-up reporting from individual asset to fund level, supporting AUM calculations, GAV/NAV reporting, REIT segment disclosures (per SEC requirements), and geographic performance benchmarking.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`amenity` (
    `amenity_id` BIGINT COMMENT 'Unique system-generated identifier for the amenity record. Primary key for the amenity data product within the property domain.',
    `amenity_type_id` BIGINT COMMENT 'Foreign key linking to reference.amenity_type. Business justification: Amenity type classification drives CAM recoverability determination, ESG reporting, LEED/BREEAM qualification, and tenant attraction scoring — a standard property management and leasing concept. ameni',
    `asset_id` BIGINT COMMENT 'Reference to the property (asset) to which this amenity belongs. Links the amenity to its parent real estate asset.',
    `building_id` BIGINT COMMENT 'Reference to the specific building within a property where this amenity is located. Nullable for land-level or property-wide amenities.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Annual OpEx budget for amenities requires a currency reference for multi-currency portfolio management and CAM reconciliation reporting. currency_code on amenity is a denormalized reference.',
    `replaced_amenity_id` BIGINT COMMENT 'Self-referencing FK on amenity (replaced_amenity_id)',
    `access_control_type` STRING COMMENT 'Method used to control and restrict physical access to the amenity. Determines security configuration and tenant onboarding requirements.. Valid values are `key_fob|key_card|pin_code|biometric|open_access|staff_supervised`',
    `amenity_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this amenity within the property management system. Used for cross-system reference in Yardi Voyager and Building Engines.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `amenity_description` STRING COMMENT 'Detailed narrative description of the amenity including features, finishes, equipment, and any notable characteristics. Used for tenant marketing materials, listing syndication, and CoStar/MLS data feeds.',
    `amenity_name` STRING COMMENT 'Human-readable name of the amenity as displayed to tenants, prospects, and property managers (e.g., Rooftop Deck, Fitness Center, Conference Room A).',
    `amenity_status` STRING COMMENT 'Current operational lifecycle status of the amenity. active indicates available for use; under_maintenance indicates temporarily unavailable; seasonal indicates availability is time-bound; planned indicates not yet operational.. Valid values are `active|inactive|under_maintenance|seasonal|decommissioned|planned`',
    `annual_opex_budget` DECIMAL(18,2) COMMENT 'Budgeted annual operating expenditure (OPEX) for maintaining and operating this amenity, expressed in the propertys functional currency. Used for CAM reconciliation and NOI reporting.',
    `area_sqf` DECIMAL(18,2) COMMENT 'Total floor area of the amenity space measured in square feet (SQF). Used for space planning, Common Area Maintenance (CAM) allocation, and lease marketing.',
    `area_sqm` DECIMAL(18,2) COMMENT 'Total floor area of the amenity space measured in square meters (SQM). Used for international reporting and properties in metric-standard markets.',
    `building_engines_amenity_code` STRING COMMENT 'Native amenity or space identifier from the Building Engines facility operations and work order management system. Used for cross-system reconciliation and work order routing.',
    `cam_eligible` BOOLEAN COMMENT 'Indicates whether the costs associated with this amenity are eligible for inclusion in Common Area Maintenance (CAM) charge reconciliations billed to tenants under applicable lease structures.',
    `capacity` STRING COMMENT 'Maximum number of persons or units the amenity can accommodate simultaneously (e.g., 50 persons for a conference room, 30 vehicles for a parking structure level). Supports occupancy compliance and reservation management.',
    `condition_rating` STRING COMMENT 'Current physical condition assessment of the amenity based on the most recent inspection or maintenance review. Drives capital expenditure (CAPEX) planning and preventive maintenance scheduling.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this amenity record was first created in the system. Supports data lineage, audit trail, and Silver layer ingestion tracking.',
    `decommission_date` DATE COMMENT 'Date on which the amenity was or is scheduled to be permanently decommissioned and removed from active service. Null for currently active amenities.',
    `effective_date` DATE COMMENT 'Date on which this amenity record became or becomes operationally effective. Supports temporal data management and historical reporting of amenity availability.',
    `esg_category` STRING COMMENT 'Environmental, Social, and Governance (ESG) classification indicating which ESG pillar this amenity supports (e.g., EV charging = environmental; childcare center = social). Used for ESG portfolio reporting.. Valid values are `environmental|social|governance|none`',
    `ev_charging_stations` STRING COMMENT 'Number of electric vehicle (EV) charging stations available within or associated with this amenity. Relevant for ESG reporting and tenant attraction in commercial and residential properties.',
    `floor_number` STRING COMMENT 'Floor level within the building where the amenity is located. Negative values indicate below-grade levels (e.g., -1 for basement parking). Null for outdoor or property-wide amenities.',
    `is_24_hour` BOOLEAN COMMENT 'Indicates whether the amenity is accessible 24 hours a day, 7 days a week. When True, operating hours fields are not applicable.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether the amenity meets Americans with Disabilities Act (ADA) accessibility requirements. Critical for regulatory compliance reporting and fair housing obligations.',
    `is_reservable` BOOLEAN COMMENT 'Indicates whether the amenity requires or supports advance reservation by tenants or occupants. True for conference rooms, event spaces, and guest suites; False for open-access amenities such as lobbies or fitness centers with open access.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether the amenity operates on a seasonal schedule (e.g., outdoor pools open only in summer months). When True, seasonal open and close dates apply.',
    `is_tenant_exclusive` BOOLEAN COMMENT 'Indicates whether access to this amenity is restricted exclusively to building tenants and their authorized guests, as opposed to being open to the general public or shared with other buildings.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection or condition assessment of the amenity. Used to track inspection frequency compliance and maintenance scheduling.',
    `leed_contribution` BOOLEAN COMMENT 'Indicates whether this amenity contributes to the buildings Leadership in Energy and Environmental Design (LEED) certification score (e.g., EV charging stations, bike storage, green roofs).',
    `location_description` STRING COMMENT 'Textual description of the amenitys physical location within the property or building (e.g., Level 3, East Wing, Rooftop Level 22, Ground Floor Lobby Adjacent).',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for the ongoing maintenance and upkeep of the amenity. Determines Operations and Maintenance (O&M) cost allocation and work order routing in Building Engines.. Valid values are `landlord|tenant|hoa|third_party_vendor|shared`',
    `next_inspection_date` DATE COMMENT 'Date on which the next scheduled inspection or condition assessment of the amenity is due. Supports proactive maintenance planning and regulatory compliance.',
    `notes` STRING COMMENT 'Free-text operational notes or remarks about the amenity recorded by property managers or facility operations staff. May include special instructions, known issues, or tenant communication guidance.',
    `operating_hours_weekday` STRING COMMENT 'Standard weekday operating hours for the amenity expressed in HH:MM-HH:MM 24-hour format (e.g., 06:00-22:00). Used for tenant communications and facility scheduling.. Valid values are `^([01]d|2[0-3]):[0-5]d-([01]d|2[0-3]):[0-5]d$`',
    `operating_hours_weekend` STRING COMMENT 'Standard weekend operating hours for the amenity expressed in HH:MM-HH:MM 24-hour format (e.g., 08:00-20:00). Null if the amenity is closed on weekends.. Valid values are `^([01]d|2[0-3]):[0-5]d-([01]d|2[0-3]):[0-5]d$`',
    `parking_stalls` STRING COMMENT 'Number of individual parking stalls associated with this amenity, applicable when the amenity type is a parking structure, surface lot, or valet facility. Supports parking ratio calculations.',
    `photo_reference` STRING COMMENT 'URI or document management system reference path to the primary marketing photograph of the amenity. Used for tenant-facing portals, listing syndication, and property marketing collateral.',
    `seasonal_close_date` DATE COMMENT 'Annual calendar date on which a seasonal amenity closes for the season (e.g., pool closing date). Applicable only when is_seasonal is True.',
    `seasonal_open_date` DATE COMMENT 'Annual calendar date on which a seasonal amenity opens for the season (e.g., pool opening date). Applicable only when is_seasonal is True.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this amenity record was most recently modified. Used for change data capture (CDC), incremental ETL processing, and audit compliance.',
    `yardi_amenity_code` STRING COMMENT 'Amenity identifier or feature code as recorded in Yardi Voyager property management system. Used for lease marketing, unit amenity mapping, and CAM charge allocation.',
    CONSTRAINT pk_amenity PRIMARY KEY(`amenity_id`)
) COMMENT 'Physical amenity record for a property or building — pools, fitness centers, parking structures, concierge services, rooftop decks, conference rooms, and other value-add features. Captures amenity type, location within property, capacity, operating hours, condition, and maintenance responsibility.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`common_area` (
    `common_area_id` BIGINT COMMENT 'Unique surrogate identifier for the common area record. Primary key for the common_area data product within the property domain. Role: MASTER_RESOURCE.',
    `asset_id` BIGINT COMMENT 'Reference to the parent property (asset) to which this common area belongs. Supports multi-building property hierarchies.',
    `space_id` BIGINT COMMENT 'Unique identifier for this common area as recorded in Building Engines facility operations platform. Used for work order routing, tenant service request linkage, and preventive maintenance scheduling.',
    `building_id` BIGINT COMMENT 'Reference to the building in which this common area is located. Links the common area to its parent building record.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Annual CAM budget and renovation cost reporting for common areas require a currency reference for multi-currency portfolio management and CAM reconciliation. currency_code on common_area is a denormal',
    `parent_common_area_id` BIGINT COMMENT 'Self-referencing FK on common_area (parent_common_area_id)',
    `access_control_type` STRING COMMENT 'Type of access control system governing entry to this common area. Supports security management, tenant access provisioning, and building operations in Building Engines.. Valid values are `unrestricted|key_card|key_fob|biometric|intercom|locked`',
    `ada_last_assessment_date` DATE COMMENT 'Date of the most recent ADA compliance assessment for this common area. Supports compliance tracking and scheduling of periodic accessibility reviews.',
    `annual_cam_budget` DECIMAL(18,2) COMMENT 'Budgeted annual operating expenditure (OPEX) for maintaining this common area, expressed in the functional currency. Used in CAM reconciliation, tenant billing estimates, and budget variance analysis in Yardi Voyager.',
    `area_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this common area within the building or property. Used in Yardi Voyager and Building Engines for work order routing and CAM reconciliation. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `area_name` STRING COMMENT 'Human-readable name or label for the common area (e.g., Main Lobby, East Stairwell, Loading Dock B). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE.',
    `area_notes` STRING COMMENT 'Free-text field for operational notes, special conditions, access restrictions, or maintenance observations related to this common area. Used by property managers and facility operations teams.',
    `area_status` STRING COMMENT 'Current lifecycle status of the common area record indicating whether the space is operational, temporarily closed, under renovation, or decommissioned. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE.. Valid values are `active|inactive|under_renovation|decommissioned|pending_activation`',
    `bim_element_code` STRING COMMENT 'Reference identifier linking this common area to its corresponding element in the Building Information Modeling (BIM) model. Enables spatial coordination, facility management integration, and digital twin alignment.',
    `cam_allocation_basis` STRING COMMENT 'Method used to allocate CAM expenses associated with this common area to tenants. Options include pro-rata by square footage, fixed amount, equal share among tenants, custom formula, or excluded from CAM pool.. Valid values are `pro_rata_sqf|fixed_amount|equal_share|custom_formula|excluded`',
    `cam_area_sqf` DECIMAL(18,2) COMMENT 'Square footage of this common area included in the CAM expense pool for tenant billing purposes. May differ from rentable_area_sqf when partial exclusions apply per lease terms.',
    `cam_eligible` BOOLEAN COMMENT 'Indicates whether this common area is eligible for inclusion in Common Area Maintenance (CAM) expense pools that are allocated to tenants. Drives CAM reconciliation in Yardi Voyager and MRI Software.',
    `cctv_coverage` BOOLEAN COMMENT 'Indicates whether this common area is covered by closed-circuit television (CCTV) surveillance. Relevant for security management, insurance underwriting, and tenant safety disclosures.',
    `ceiling_height_ft` DECIMAL(18,2) COMMENT 'Clear ceiling height of the common area measured in feet. Relevant for space planning, equipment clearance requirements, and building specifications documentation.',
    `condition_rating` STRING COMMENT 'Current physical condition rating of the common area as assessed during the most recent inspection. Drives capital expenditure (CAPEX) planning and preventive maintenance scheduling in Building Engines.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this common area record was first created in the data platform. Supports data lineage, audit trail, and SOX financial controls compliance.',
    `decommission_date` DATE COMMENT 'Date on which this common area was permanently decommissioned or removed from service. Null for active areas. Used to manage lifecycle transitions and exclude decommissioned areas from CAM pools.',
    `effective_date` DATE COMMENT 'Date from which this common area record became operationally active and eligible for CAM allocation and maintenance tracking. Supports temporal data management and historical reporting.',
    `energy_metering_type` STRING COMMENT 'Describes how energy consumption is measured for this common area. Determines whether energy costs are directly attributable or must be allocated via CAM. Relevant for ESG reporting and LEED compliance.. Valid values are `sub_metered|master_metered|unmetered|shared_meter`',
    `esg_classification` STRING COMMENT 'ESG classification of this common area based on energy efficiency, sustainability features, and environmental compliance. Supports portfolio-level ESG reporting to investors and regulators.. Valid values are `green|standard|non_compliant|under_review`',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed in this common area. Required for life safety compliance reporting, insurance underwriting, and OSHA regulatory filings.. Valid values are `sprinkler_wet|sprinkler_dry|halon|none|other`',
    `floor_number` STRING COMMENT 'Floor level on which the common area is located within the building. Negative values indicate below-grade levels (e.g., -1 for basement). Used for spatial navigation, maintenance routing, and BIM alignment.',
    `hvac_zone` STRING COMMENT 'HVAC zone designation for this common area. Used for building systems management, energy allocation, and preventive maintenance scheduling in Building Engines.',
    `is_ada_compliant` BOOLEAN COMMENT 'Indicates whether this common area meets Americans with Disabilities Act (ADA) accessibility requirements. Critical for regulatory compliance reporting and tenant disclosure obligations.',
    `is_publicly_accessible` BOOLEAN COMMENT 'Indicates whether this common area is accessible to the general public without tenant authorization. Affects liability exposure, insurance classification, and ADA compliance obligations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of this common area. Used to track inspection frequency compliance and trigger follow-up work orders in Building Engines.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent capital renovation or significant improvement to this common area. Supports CAPEX tracking, depreciation scheduling, and asset condition assessment.',
    `leed_certification_level` STRING COMMENT 'LEED certification level applicable to this common area or the building zone it occupies. Supports ESG reporting, green building compliance, and tenant sustainability disclosures.. Valid values are `certified|silver|gold|platinum|none`',
    `maintenance_responsibility` STRING COMMENT 'Party responsible for the ongoing maintenance and upkeep of this common area. Determines work order assignment in Building Engines and cost allocation in Yardi Voyager.. Valid values are `landlord|tenant|shared|hoa|third_party`',
    `max_occupancy` STRING COMMENT 'Maximum number of persons permitted in this common area at any one time as determined by fire code and building regulations. Required for life safety compliance and OSHA reporting.',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next physical inspection of this common area. Supports preventive maintenance planning and regulatory compliance scheduling.',
    `pro_rata_share` DECIMAL(18,2) COMMENT 'Proportional share of this common areas CAM costs expressed as a decimal fraction (e.g., 0.125000 = 12.5%). Calculated as the common areas CAM-eligible square footage divided by total building rentable area. Used in lease administration and CAM reconciliation.',
    `renovation_cost` DECIMAL(18,2) COMMENT 'Total capital expenditure (CAPEX) incurred for the most recent renovation of this common area, expressed in the propertys functional currency. Used for fixed asset tracking and depreciation in Yardi Voyager and SAP S/4HANA.',
    `rentable_area_sqf` DECIMAL(18,2) COMMENT 'Rentable square footage of the common area as measured per BOMA standards. Used in pro-rata share calculations for Common Area Maintenance (CAM) charges allocated to tenants. Principal quantitative measurement for this MASTER_RESOURCE (MEASUREMENT_OR_VALUE).',
    `rentable_area_sqm` DECIMAL(18,2) COMMENT 'Rentable area of the common area expressed in square meters. Used for international reporting, ESG metrics, and cross-border portfolio comparisons.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this common area record. Supports change tracking, data lineage, and audit trail requirements under SOX and GDPR.',
    `usable_area_sqf` DECIMAL(18,2) COMMENT 'Net usable square footage of the common area, excluding structural elements and mechanical shafts. Supports NLA calculations and space efficiency analysis.',
    `yardi_space_code` STRING COMMENT 'Space code assigned to this common area in Yardi Voyager property management system. Used for CAM reconciliation, lease administration, and accounts receivable allocation.',
    CONSTRAINT pk_common_area PRIMARY KEY(`common_area_id`)
) COMMENT 'Common area record for shared spaces within a property or building — lobbies, hallways, elevators, stairwells, loading docks, and shared restrooms. Captures area type, square footage, maintenance responsibility, CAM allocation basis, and ADA compliance status.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`parking` (
    `parking_id` BIGINT COMMENT 'Unique system-generated identifier for the parking facility or space inventory record. Primary key for the parking data product.',
    `asset_id` BIGINT COMMENT 'Reference to the parent property asset to which this parking facility belongs.',
    `space_id` BIGINT COMMENT 'Unique identifier for the parking facility as recorded in Building Engines facility operations platform. Used for work order management, preventive maintenance scheduling, and tenant service request routing.',
    `building_id` BIGINT COMMENT 'Reference to the specific building associated with this parking facility, applicable for structured garages or underground parking attached to a building.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Parking rate reporting (monthly_rate_reserved, monthly_rate_unreserved, daily_rate, hourly_rate) requires a currency reference for multi-currency portfolio management and parking revenue reporting. cu',
    `replaced_parking_id` BIGINT COMMENT 'Self-referencing FK on parking (replaced_parking_id)',
    `access_control_type` STRING COMMENT 'Type of access control system used to manage entry and exit at the parking facility. Informs security compliance, operational cost planning, and tenant experience reporting.. Valid values are `key_card|fob|license_plate_recognition|ticket|app_based|none`',
    `ada_spaces` STRING COMMENT 'Number of parking spaces that meet Americans with Disabilities Act (ADA) accessibility requirements, including required dimensions and proximity to accessible building entrances. Required for regulatory compliance reporting.',
    `cam_eligible` BOOLEAN COMMENT 'Indicates whether parking facility operating costs are recoverable through Common Area Maintenance (CAM) charges billed to tenants. Directly impacts lease CAM reconciliation in Yardi Voyager.',
    `clearance_height_ft` DECIMAL(18,2) COMMENT 'Minimum vertical clearance height in feet within the parking facility. Critical for determining suitability for oversized vehicles (SUVs, vans, trucks) and for tenant communication and signage compliance.',
    `condition_rating` STRING COMMENT 'Current physical condition rating of the parking facility as assessed during the most recent inspection. Informs capital expenditure (CAPEX) planning, reserve fund modeling, and asset management decisions.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this parking facility record was first created in the data platform. Supports data lineage, audit trail, and Silver layer ingestion tracking.',
    `daily_rate` DECIMAL(18,2) COMMENT 'Daily transient parking rate charged per space. Applicable for surface lots and garages offering hourly or daily public parking. Used in revenue modeling and benchmarking.',
    `effective_date` DATE COMMENT 'Date from which this parking facility record and its associated rates and configurations are operationally effective. Supports temporal data management and historical rate tracking.',
    `ev_charging_level` STRING COMMENT 'Classification of EV charging infrastructure by power delivery level (Level 1 = 120V standard outlet, Level 2 = 240V dedicated charger, DC Fast Charge = direct current rapid charging). Informs ESG and LEED documentation.. Valid values are `level_1|level_2|dc_fast_charge|mixed`',
    `ev_charging_spaces` STRING COMMENT 'Number of parking spaces equipped with electric vehicle (EV) charging stations. Relevant to ESG reporting, LEED certification scoring, and tenant amenity marketing.',
    `expiry_date` DATE COMMENT 'Date on which this parking facility record or its current rate configuration expires or is superseded. Null for open-ended active records. Supports SCD (Slowly Changing Dimension) management in the Silver layer.',
    `facility_code` STRING COMMENT 'Unique alphanumeric business identifier for the parking facility used in operational systems such as Yardi Voyager and Building Engines for work order and billing reference.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `facility_name` STRING COMMENT 'Human-readable name or label for the parking facility (e.g., North Garage, Surface Lot B, Underground Level P1) used in tenant communications and operational reporting.',
    `facility_status` STRING COMMENT 'Current operational lifecycle status of the parking facility. Drives availability reporting and asset management workflows in Yardi Voyager and Building Engines.. Valid values are `active|inactive|under_construction|temporarily_closed|decommissioned`',
    `facility_type` STRING COMMENT 'Classification of the parking facility by physical structure type. Drives operational, maintenance, and capital expenditure (CAPEX) planning. [ENUM-REF-CANDIDATE: surface_lot|structured_garage|underground|covered_carport|valet_only|mixed — promote to reference product if additional types are needed]. Valid values are `surface_lot|structured_garage|underground|covered_carport|valet_only|mixed`',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly transient parking rate charged per space. Applicable for facilities offering short-term public parking. Supports revenue analytics and competitive benchmarking.',
    `is_covered` BOOLEAN COMMENT 'Indicates whether the parking facility provides covered or enclosed protection from weather. Influences tenant desirability, rental rate premiums, and property marketing.',
    `is_gated` BOOLEAN COMMENT 'Indicates whether the parking facility has controlled access via gates, barriers, or access control systems. Relevant for security assessments, insurance underwriting, and tenant amenity reporting.',
    `is_valet_available` BOOLEAN COMMENT 'Indicates whether valet parking service is available at this facility. Relevant for Class A commercial and hospitality properties; used in tenant amenity reporting and marketing.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the parking facility for structural integrity, safety compliance, and operational condition. Supports preventive maintenance scheduling and OSHA compliance tracking.',
    `leed_contribution_flag` BOOLEAN COMMENT 'Indicates whether this parking facility contributes to the propertys LEED certification score (e.g., through EV charging, preferred parking for low-emission vehicles, or reduced surface lot footprint). Supports ESG and green certification reporting.',
    `levels_count` STRING COMMENT 'Number of levels or floors within a structured or underground parking facility. Used in building information modeling (BIM) references and facility operations planning.',
    `monthly_rate_reserved` DECIMAL(18,2) COMMENT 'Monthly rental rate charged per reserved parking space in the local currency. Used in lease administration, CAM reconciliation, and parking revenue forecasting in Yardi Voyager and Argus Enterprise.',
    `monthly_rate_unreserved` DECIMAL(18,2) COMMENT 'Monthly rental rate charged per unreserved parking space in the local currency. Supports transient parking revenue modeling and market comparability analysis.',
    `next_inspection_date` DATE COMMENT 'Date of the next scheduled inspection for the parking facility. Drives preventive maintenance workflows in Building Engines and regulatory compliance calendars.',
    `notes` STRING COMMENT 'Free-text operational notes or remarks about the parking facility, including special access instructions, tenant restrictions, seasonal closures, or pending capital improvements.',
    `operator_name` STRING COMMENT 'Name of the third-party parking operator or management company responsible for day-to-day operations of the facility (e.g., LAZ Parking, SP+, REEF Technology). Relevant when parking is outsourced.',
    `ownership_type` STRING COMMENT 'Indicates the ownership or operational control structure of the parking facility. Drives accounting treatment (owned vs. leased under ASC 842/IFRS 16), asset management, and portfolio reporting.. Valid values are `owned|leased|managed|licensed|joint_venture`',
    `ratio` DECIMAL(18,2) COMMENT 'Number of parking spaces provided per 1,000 square feet (SQF) of gross leasable area (GLA). Standard real estate metric used in property underwriting, lease negotiations, and market comparability analysis.',
    `reserved_spaces` STRING COMMENT 'Number of spaces designated as reserved and assigned to specific tenants, owners, or lease agreements. Used in lease administration and parking revenue tracking in Yardi Voyager.',
    `spaces_per_level` STRING COMMENT 'Average number of parking spaces per level in a multi-level structured or underground facility. Supports capacity planning and fire safety compliance documentation.',
    `total_area_sqf` DECIMAL(18,2) COMMENT 'Total physical area of the parking facility in square feet (SQF). Used in property valuation, fixed asset (FA) records, and capital expenditure (CAPEX) planning.',
    `total_spaces` STRING COMMENT 'Total count of all parking spaces within the facility, including reserved, unreserved, ADA-compliant, and EV charging spaces. Principal capacity metric used in property underwriting and lease negotiations.',
    `unreserved_spaces` STRING COMMENT 'Number of spaces available on a first-come, first-served basis, not assigned to any specific tenant or lease. Supports transient and hourly parking revenue modeling.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this parking facility record was last modified in the data platform. Supports incremental data processing, change detection, and audit compliance.',
    `valet_spaces` STRING COMMENT 'Number of spaces designated for valet parking operations. Applicable only when is_valet_available is True. Used in operational planning and tenant service level reporting.',
    `yardi_parking_code` STRING COMMENT 'Unique parking facility or space code as recorded in Yardi Voyager property management system. Used for system-of-record reconciliation, AR billing, and lease charge code mapping.',
    CONSTRAINT pk_parking PRIMARY KEY(`parking_id`)
) COMMENT 'Parking facility and space inventory record for properties — surface lots, structured garages, underground parking, and reserved spaces. Captures total spaces, reserved vs unreserved counts, monthly rates, valet availability, EV charging stations, and ADA-compliant space counts.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each asset-employee assignment record.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the real estate asset being managed or operated by the employee.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to manage, lease, maintain, or operate the asset.',
    `assignment_role` STRING COMMENT 'The specific operational role the employee performs for this asset. Drives responsibility matrix, escalation routing, and performance metrics. Explicitly identified in detection reasoning.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment. Drives operational visibility and access control.',
    `effective_end_date` DATE COMMENT 'The date on which this employee-asset assignment ended or is scheduled to end. Null for active assignments. Supports historical tracking and succession planning. Explicitly identified in detection reasoning.',
    `effective_start_date` DATE COMMENT 'The date on which this employee-asset assignment became effective. Supports historical tracking and transition management. Explicitly identified in detection reasoning.',
    `fte_allocation_pct` DECIMAL(18,2) COMMENT 'The percentage of the employees full-time equivalent capacity allocated to this specific asset. Supports workload balancing and cost allocation. Explicitly identified in detection reasoning.',
    `is_primary_assignment` BOOLEAN COMMENT 'Indicates whether this is the employees primary asset assignment. Used for default routing, primary work location determination, and reporting hierarchy. Explicitly identified in detection reasoning.',
    `managed_gla_sqft` DECIMAL(18,2) COMMENT 'The gross leasable area (in square feet) for which this employee is responsible within this asset. May be less than total asset GLA for shared responsibility models. Drives portfolio size metrics and compensation benchmarking. Explicitly identified in detection reasoning (managed_gla_sqf).',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'This association product represents the operational assignment of workforce personnel to real estate assets. It captures the formal relationship between employees and the properties they manage, lease, maintain, or operate. Each record links one employee to one asset with role-specific attributes including assignment dates, FTE allocation, managed square footage, and primary assignment designation. This is the authoritative source for answering who is responsible for which property and what properties does this employee manage.. Existence Justification: In real estate operations, employees are routinely assigned to multiple assets simultaneously (e.g., a regional property manager oversees 8 office buildings, a leasing agent covers 3 retail centers), and assets require multiple specialized staff (e.g., a Class A tower has a property manager, assistant property manager, chief engineer, leasing director, and facilities coordinator). The detection reasoning explicitly confirms that a work_assignment product already exists modeling this junction with role, FTE allocation, start/end dates, and managed GLA—proving this is an actively managed operational relationship, not an analytical correlation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`building_policy_coverage` (
    `building_policy_coverage_id` BIGINT COMMENT 'Unique surrogate identifier for each building-policy coverage record in the Schedule of Locations.',
    `blanket_group_id` BIGINT COMMENT 'Identifier for the blanket coverage group to which this building belongs within the policy. Buildings in the same blanket group share a combined limit rather than individual limits. Null if building has specific (non-blanket) coverage.',
    `building_id` BIGINT COMMENT 'Foreign key linking to the building record covered under this policy. References the physical structure insured.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the insurance policy record providing coverage. References the master policy under which this building is scheduled.',
    `coinsurance_pct` DECIMAL(18,2) COMMENT 'Building-specific coinsurance percentage requirement (typically 80%, 90%, or 100%). Determines the minimum insured value relative to replacement cost to avoid coinsurance penalties at claim time. May vary by building within the same policy.',
    `construction_class` STRING COMMENT 'Insurance construction classification for this building as reported to the insurer (e.g., ISO construction class 1-6, or frame/joisted masonry/non-combustible/masonry non-combustible/modified fire resistive/fire resistive). Drives premium and coverage eligibility.',
    `coverage_effective_date` DATE COMMENT 'Date on which insurance coverage for this specific building became effective under this policy. May differ from the master policy effective date if the building was added mid-term via endorsement.',
    `coverage_expiry_date` DATE COMMENT 'Date on which insurance coverage for this specific building expires under this policy. May differ from the master policy expiration if the building is removed mid-term or if coverage is non-renewed for this location only.',
    `coverage_status` STRING COMMENT 'Current status of coverage for this building under this policy. Active = currently covered; Pending = endorsement submitted but not yet effective; Expired = coverage term ended; Cancelled = coverage terminated mid-term; Excluded = building explicitly excluded from policy coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this building-policy coverage record was first created in the enterprise data platform.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Building-specific deductible amount applicable to covered losses at this location. May vary by building based on construction type, occupancy, or loss history. Overrides the master policy deductible when specified in the schedule.',
    `location_number` STRING COMMENT 'Insurer-assigned location identifier for this building within the policy schedule. Used on certificates of insurance and claims documentation. Maps to ACORD SOV location number.',
    `occupancy_code` STRING COMMENT 'Insurance occupancy classification code for this building as reported to the insurer (e.g., ISO occupancy code). Drives premium rating and coverage terms. Captured at the building-policy level because occupancy may change over time and different policies may have different occupancy representations.',
    `scheduled_insured_value` DECIMAL(18,2) COMMENT 'Building-specific insured value (replacement cost or agreed value) as scheduled on this policy. May differ from the buildings total insurable value if multiple policies provide layered coverage. Used for coinsurance penalty calculations and claims settlement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this building-policy coverage record was last modified. Tracks changes to coverage terms, insured values, or status.',
    `valuation_date` DATE COMMENT 'Date on which the scheduled insured value for this building was last determined or updated. Used to track valuation currency and trigger revaluation workflows per policy requirements (e.g., annual revaluation).',
    CONSTRAINT pk_building_policy_coverage PRIMARY KEY(`building_policy_coverage_id`)
) COMMENT 'This association product represents the Schedule of Locations (SOV) entry linking each building to each insurance policy that covers it. In commercial real estate insurance, a single blanket policy typically covers multiple buildings across a portfolio, and a single building may be covered under multiple policies simultaneously (e.g., property policy + flood policy + earthquake policy). Each record captures the building-specific coverage terms, insured value, deductible, and coinsurance percentage as documented in the insurers Schedule of Locations. This is the SSOT for building-level insurance coverage terms and is used for certificate of insurance generation, claims processing, and insurance compliance reporting.. Existence Justification: In commercial real estate insurance, a single blanket policy routinely covers multiple buildings across a portfolio (one policy → many buildings), and a single building is simultaneously covered under multiple policies for different perils (one building → many policies: property, flood, earthquake, terrorism). Insurers document this via a Schedule of Locations (SOV), an industry-standard artifact that lists each building with its location number, insured value, deductible, coinsurance percentage, and coverage dates. This is an operational business entity actively managed by risk managers and insurers.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`property_occupancy` (
    `property_occupancy_id` BIGINT COMMENT 'Primary key for property_occupancy',
    `occupancy_record_id` BIGINT COMMENT 'Unique surrogate identifier for this space-tenant occupancy record',
    `space_id` BIGINT COMMENT 'Foreign key linking to the specific space being leased',
    `tenant_id` BIGINT COMMENT 'Foreign key linking to the tenant occupying the space',
    `cam_pro_rata_share` DECIMAL(18,2) COMMENT 'This tenants proportionate share of Common Area Maintenance costs for this specific space, expressed as a decimal fraction of the buildings total CAM pool',
    `lease_end_date` DATE COMMENT 'Date on which the tenants lease for this space expires or expired',
    `lease_start_date` DATE COMMENT 'Date on which the tenants occupancy of this space commenced under the current lease agreement',
    `leased_area_sqf` DECIMAL(18,2) COMMENT 'Actual square footage leased to this tenant for this specific space. May differ from the spaces total rentable area in co-tenancy or partial lease scenarios.',
    `occupancy_status` STRING COMMENT 'Current lifecycle status of this space-tenant occupancy: active (tenant in possession), pending (lease signed, not yet commenced), expired (lease term ended), terminated (early termination), holdover (tenant remaining after expiration)',
    `rent_psf` DECIMAL(18,2) COMMENT 'Annual rent per square foot charged to this tenant for this specific space. Tenant-specific rate that may differ from asking rent due to negotiations, concessions, or lease vintage.',
    CONSTRAINT pk_property_occupancy PRIMARY KEY(`property_occupancy_id`)
) COMMENT 'This association product represents the commercial lease occupancy relationship between a space and a tenant. It captures the operational leasing arrangement including leased area, rent terms, CAM allocation, and occupancy period. Each record links one space to one tenant with attributes that exist only in the context of this specific lease arrangement.. Existence Justification: In commercial real estate operations, a single space can be simultaneously leased to multiple tenants through co-tenancy arrangements (e.g., shared conference rooms, co-working spaces, multi-tenant floors with subdivided areas), and a single tenant frequently leases multiple spaces across a building or portfolio (e.g., corporate headquarters spanning multiple floors, retail chains with multiple units). Each space-tenant combination represents a distinct lease arrangement with its own leased area, rent rate, CAM allocation, and term dates that cannot be stored on either the space or tenant entity alone.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`property_demised_space` (
    `property_demised_space_id` BIGINT COMMENT 'Primary key for property_demised_space',
    `space_id` BIGINT COMMENT 'Unique surrogate identifier for this space-lease association record',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to the lease agreement under which this space is demised',
    `property_space_id` BIGINT COMMENT 'Foreign key linking to the physical space record within the building',
    `base_rent_psf` DECIMAL(18,2) COMMENT 'The annual base rent per square foot applicable to this specific space under this lease agreement. Allows for different rent rates across spaces within a multi-space lease.',
    `effective_date` DATE COMMENT 'The date on which this space became part of the lease agreement. May differ from lease commencement if spaces are added mid-term or phased occupancy occurs.',
    `expiry_date` DATE COMMENT 'The date on which this space is released from the lease agreement. May differ from lease expiration if spaces are released early or partial terminations occur.',
    `lease_expiry_date` DATE COMMENT 'Date on which the current lease for this space expires. Denormalized from the lease agreement for operational convenience in space availability dashboards, WALT/WALE calculations, and leasing pipeline management. [Moved from space: This attribute in the space product represents the expiration date of the lease covering this space. It is denormalized from the lease domain and belongs in the demised_space association as expiry_date, since a space can be covered by successive leases with different expiration dates.]',
    `leased_area_sqf` DECIMAL(18,2) COMMENT 'The rentable area in square feet for this specific space as stated in the lease agreement. May differ from the spaces current rentable_area_sqf if the lease was executed under different measurement standards or if remeasurement occurred post-execution.',
    `pro_rata_share` DECIMAL(18,2) COMMENT 'The proportionate share of the buildings total rentable area represented by this space within this lease agreement. Used for CAM charge allocation and expense reconciliation specific to this space-lease combination.',
    `space_status` STRING COMMENT 'The current status of this space within the context of this lease agreement. Tracks lifecycle states such as active (currently leased), pending (lease signed but not yet commenced), released (space returned to landlord), or terminated (lease ended for this space).',
    CONSTRAINT pk_property_demised_space PRIMARY KEY(`property_demised_space_id`)
) COMMENT 'This association product represents the contractual allocation of physical space to a lease agreement. It captures the specific spaces covered under each lease, including effective dates, rent rates, and area measurements that exist only in the context of this space-lease relationship. Each record links one space to one agreement with attributes that reflect the terms and conditions specific to that space within the broader lease.. Existence Justification: In real estate lease administration, a single physical space can be leased under multiple agreements over time (successive leases) and occasionally split across concurrent agreements for partial occupancy or subleasing scenarios. Conversely, a single lease agreement frequently covers multiple spaces (multi-space leases, entire floors, or suites comprising multiple rooms). The business actively manages the space-lease relationship with specific effective dates, rent rates per space, area measurements as stated in each lease, and status tracking for each space within each agreement.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` (
    `building_compliance_obligation_id` BIGINT COMMENT 'Unique surrogate identifier for each building-obligation compliance record',
    `building_id` BIGINT COMMENT 'Foreign key linking to the building subject to this regulatory obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation applicable to this building',
    `applicability_status` STRING COMMENT 'Indicates whether this regulatory obligation applies to this specific building based on asset class, jurisdiction, building characteristics, and exemptions. Explicitly identified in detection reasoning as relationship data.',
    `certification_expiration_date` DATE COMMENT 'Expiration date of the certification or permit for this building-obligation pairing, after which renewal is required',
    `certification_number` STRING COMMENT 'Official certification, permit, or filing number issued for this buildings compliance with this obligation (e.g., COO number, EPA permit number, fire inspection certificate)',
    `compliance_status` STRING COMMENT 'Current compliance status of this building with respect to this specific obligation. Explicitly identified in detection reasoning as relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this building-obligation compliance record was first created in the system',
    `effective_date` DATE COMMENT 'Date on which this obligation became applicable to this specific building. May differ from the obligations general effective_date if the building was acquired later or underwent changes triggering applicability. Explicitly identified in detection reasoning as relationship data.',
    `exemption_reason` STRING COMMENT 'Explanation of why this building is exempted from this obligation, if applicability_status is Exempted',
    `last_reviewed_date` DATE COMMENT 'Date on which compliance with this obligation was last reviewed or audited for this building. Explicitly identified in detection reasoning as relationship data.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or audit of this building against this obligation',
    `non_compliance_notes` STRING COMMENT 'Narrative description of any non-compliance issues, remediation plans, or special circumstances for this building-obligation pairing',
    `responsible_party` STRING COMMENT 'Name or identifier of the individual or team responsible for ensuring this building complies with this obligation. Explicitly identified in detection reasoning as relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was last updated',
    CONSTRAINT pk_building_compliance_obligation PRIMARY KEY(`building_compliance_obligation_id`)
) COMMENT 'This association product represents the applicability and compliance tracking of regulatory obligations to specific buildings. It captures which obligations apply to which buildings, the current compliance status, responsible parties, and key compliance dates. Each record links one building to one regulatory obligation with attributes that exist only in the context of this specific building-obligation pairing.. Existence Justification: In real estate operations, each building is subject to multiple regulatory obligations (fire codes, ADA compliance, energy benchmarking, elevator inspections, environmental permits, zoning requirements), and each regulatory obligation applies to multiple buildings across the portfolio. The compliance team actively manages this relationship by tracking applicability status, compliance status, responsible parties, certification numbers, review dates, and remediation activities for each building-obligation pairing. This is an operational compliance management process, not an analytical correlation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`building_certification` (
    `building_certification_id` BIGINT COMMENT 'Unique surrogate identifier for this building certification record',
    `building_id` BIGINT COMMENT 'Foreign key linking to the building that holds this certification',
    `sustainability_rating_id` BIGINT COMMENT 'Foreign key linking to the specific sustainability rating level achieved',
    `auditor_name` STRING COMMENT 'Name of the third-party auditor or assessor who conducted the certification assessment for this building. Used for audit trail and quality assurance.',
    `certification_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost incurred to achieve this certification for this building, including application fees, consultant fees, and audit costs. Used for ROI analysis and budgeting for recertification.',
    `certification_date` DATE COMMENT 'Date on which the certification was officially awarded to the building by the certifying body. Used for tracking certification age and renewal scheduling.',
    `certification_score` DECIMAL(18,2) COMMENT 'The actual numeric score achieved by this building under this rating scheme (e.g., 78 points for LEED, 85 for BREEAM). Used for ESG reporting and portfolio benchmarking.',
    `certification_status` STRING COMMENT 'Current lifecycle status of this certification: ACTIVE (valid and current), EXPIRED (past expiry date), PENDING_RENEWAL (renewal application submitted), SUSPENDED (temporarily invalid), WITHDRAWN (voluntarily or involuntarily removed). Drives ESG reporting inclusion logic.',
    `certification_version` STRING COMMENT 'Specific version or edition of the rating scheme under which this building was certified (e.g., LEED v4, BREEAM 2018). Important because scoring criteria change across versions.',
    `certifying_body_reference` STRING COMMENT 'External reference number or certificate ID issued by the certifying body (e.g., USGBC certificate number, BREEAM assessment ID). Used for audit verification and investor due diligence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the enterprise data platform',
    `expiry_date` DATE COMMENT 'Date on which this certification expires and requires renewal or recertification. Null if the certification does not expire. Drives compliance monitoring workflows.',
    `is_esg_reported` BOOLEAN COMMENT 'Indicates whether this certification is included in the enterprise ESG reporting and investor disclosures (GRESB, GRI, SASB). Typically true for ACTIVE certifications on reportable buildings.',
    `recertification_due_date` DATE COMMENT 'Target date by which recertification process should be initiated to avoid lapse. Typically 90-180 days before expiry_date. Drives proactive compliance workflows.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this certification record. Used for change tracking and data freshness monitoring.',
    `well_certification_level` STRING COMMENT 'WELL Building Standard certification level awarded by the International WELL Building Institute (IWBI). Increasingly required by institutional tenants and ESG-focused investors. [Moved from building: This attribute in the building table represents a specific WELL certification level, which is one instance of a sustainability certification. It should be modeled as a record in the building_certification association (with sustainability_rating_id pointing to the WELL rating level) rather than a dedicated column. This allows the building to hold multiple WELL certifications over time (e.g., recertification at a higher level) and treats WELL consistently with other certification schemes.]. Valid values are `bronze|silver|gold|platinum|none`',
    CONSTRAINT pk_building_certification PRIMARY KEY(`building_certification_id`)
) COMMENT 'This association product represents the certification relationship between a building and a sustainability rating scheme. It captures the specific certification achievement for a building under a particular rating system. Each record links one building to one sustainability rating level with attributes that exist only in the context of this certification event: the score achieved, dates of certification and expiry, certifying body reference, and current status. This is the operational record of green building certifications managed by ESG and sustainability teams.. Existence Justification: In real estate ESG operations, buildings routinely hold multiple sustainability certifications simultaneously (e.g., LEED Gold + ENERGY STAR + BREEAM Excellent + WELL Silver) to meet diverse investor, tenant, and regulatory requirements. Each certification scheme can be held by thousands of buildings across a portfolio. The business actively manages these certifications as operational records with specific scores, award dates, expiry dates, renewal cycles, and statuses that belong to the building-scheme combination, not to either entity alone.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Unique system-generated identifier for this parking allocation record. Primary key.',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key to lease.agreement.agreement_id identifying the lease agreement under which parking is allocated',
    `parking_id` BIGINT COMMENT 'Foreign key to property.parking.parking_id identifying the parking facility from which spaces are allocated',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this parking allocation (Active, Suspended, Terminated, Pending). Drives billing and access control.',
    `effective_date` DATE COMMENT 'Date on which this parking allocation becomes effective. May align with lease commencement or be a later amendment date. Corresponds to effective_date from detection data.',
    `expiry_date` DATE COMMENT 'Date on which this parking allocation expires or terminates. May align with lease expiration or be earlier if parking is released. Corresponds to expiry_date from detection data.',
    `monthly_rate` DECIMAL(18,2) COMMENT 'Monthly rental rate per space charged to the tenant under this allocation. May differ from facility standard rates due to lease negotiation. Corresponds to monthly_rate from detection data.',
    `reserved_flag` BOOLEAN COMMENT 'Indicates whether the allocated spaces are reserved (assigned to specific tenant) or unreserved (first-come, first-served from tenant pool). Drives space assignment and access control. Corresponds to reserved_flag from detection data.',
    `spaces_allocated` STRING COMMENT 'Number of parking spaces allocated to this lease agreement from this parking facility. Corresponds to parking_spaces_allocated from detection data.',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'This association product represents the contractual allocation of parking spaces to lease agreements. It captures the number of spaces reserved for each tenant under their lease, the applicable monthly rate, and the effective period of the allocation. Each record links one parking facility to one lease agreement with attributes that exist only in the context of this parking entitlement.. Existence Justification: In real estate lease administration, a single parking facility serves multiple tenants across different lease agreements, and a single lease agreement can allocate parking spaces from multiple facilities (e.g., surface lot + garage, or multiple buildings in a campus). The business actively manages parking allocations as contractual entitlements, tracking the number of spaces, negotiated rates, effective periods, and reservation status per tenant-per-facility. This is an operational relationship that lease administrators create, modify, and terminate as part of lease execution and amendment processes.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` (
    `space_campaign_inclusion_id` BIGINT COMMENT 'Unique surrogate identifier for this space-campaign inclusion record. Primary key for the association.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign in which this space is being promoted',
    `space_id` BIGINT COMMENT 'Foreign key linking to the specific leasable space or common area being marketed in this campaign',
    `allocated_budget_amount` DECIMAL(18,2) COMMENT 'The portion of the campaigns total budget allocated specifically to marketing this space. Used when campaign budgets are distributed across spaces based on size, priority, or market conditions.',
    `asking_rent_psf_at_inclusion` DECIMAL(18,2) COMMENT 'The asking rent per square foot for this space at the time it was included in the campaign. Captured at inclusion time because asking rent may change during long-running campaigns, and marketing performance must be evaluated against the rent being advertised.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this space-campaign inclusion record was created. Used for audit and data lineage.',
    `impression_count` BIGINT COMMENT 'The number of ad impressions or views attributed to this space within this campaign. Relevant for digital campaigns where space-level impression tracking is available via UTM parameters or listing IDs.',
    `inclusion_end_date` DATE COMMENT 'The date on which this space was removed from the campaign or the campaign concluded for this space. May differ from campaign.actual_end_date if spaces are added/removed mid-campaign.',
    `inclusion_start_date` DATE COMMENT 'The date on which this space was added to the campaign and began being actively marketed. Used to calculate campaign duration per space and align with lead attribution windows.',
    `lead_count` STRING COMMENT 'The number of qualified leads generated for this specific space through this campaign. Aggregated from CRM lead records where campaign_id and space_id match. Used for space-level campaign ROI analysis.',
    `priority_rank` STRING COMMENT 'The relative priority or prominence of this space within the campaigns portfolio of marketed spaces. Lower numbers indicate higher priority. Used to allocate budget, determine creative placement order, and prioritize lead routing when multiple spaces match prospect criteria.',
    `space_marketing_status` STRING COMMENT 'The marketing status of this space within this specific campaign. Drives whether the space continues to appear in campaign creative and lead routing. Values: active (currently being marketed), paused (temporarily suspended), leased (space leased during campaign), withdrawn (removed from campaign).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this space-campaign inclusion record was last modified. Used for incremental ETL and change tracking.',
    CONSTRAINT pk_space_campaign_inclusion PRIMARY KEY(`space_campaign_inclusion_id`)
) COMMENT 'This association product represents the marketing inclusion relationship between a leasable space and a marketing campaign. It captures the time-bounded participation of a specific space in a campaign, including the asking rent at the time of marketing, the spaces status during the campaign period, and its priority within the campaigns portfolio of marketed spaces. Each record links one space to one campaign with attributes that exist only in the context of this marketing relationship.. Existence Justification: In commercial real estate marketing operations, a single leasable space can be simultaneously marketed across multiple campaigns (e.g., broker outreach, digital advertising, open house events, MLS syndication), and each campaign typically promotes multiple available spaces across the portfolio. Marketing teams actively manage which spaces are included in which campaigns, tracking inclusion dates, the asking rent being advertised, marketing status per space-campaign combination, and priority rankings to allocate budget and creative prominence.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`deal_asset` (
    `deal_asset_id` BIGINT COMMENT 'Unique surrogate identifier for each deal-asset association record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the real estate asset included in this investment deal',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to the investment deal pipeline record',
    `acquisition_priority` STRING COMMENT 'The investment teams priority or preference for including this asset in the final transaction. In portfolio deals, some assets may be must-haves (anchor assets), while others are optional or even undesirable. This attribute guides negotiation strategy and deal structuring.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total deal value or equity allocation attributed to this specific asset within the deal. Used in portfolio acquisitions where the purchase price or equity is allocated across multiple assets. Expressed as a decimal (e.g., 0.3500 = 35%). Sum of allocation_percentage across all assets in a deal should equal 1.0000.',
    `asset_specific_conditions` STRING COMMENT 'Free-text field capturing any conditions, contingencies, or special terms that apply specifically to this asset within the deal. Examples: Subject to tenant lease renewal, Requires environmental remediation, Seller to complete deferred maintenance. These conditions are deal-context-specific.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this deal-asset association record was created in the system. Audit trail for when the asset was added to the deal pipeline.',
    `dd_completion_date` DATE COMMENT 'The date on which due diligence for this specific asset within this deal was completed or cleared. Null if DD is not yet complete. Used to track deal timeline and readiness for IC submission.',
    `deal_role` STRING COMMENT 'The strategic role or classification of this specific asset within the investment deal structure. Indicates whether the asset is the primary anchor (e.g., flagship property in a portfolio acquisition), a portfolio filler, a value-add opportunity, or another strategic designation. This attribute exists only in the context of the deal and varies by deal.',
    `due_diligence_status` STRING COMMENT 'The current status of due diligence activities specific to this asset within this deal. Tracks whether DD is not started, in progress, has identified issues, has been cleared, waived by IC, or has surfaced deal-breaker issues. This status is deal-specific because the same asset may have different DD outcomes in different deal contexts or timeframes.',
    `included_in_ic_memo` BOOLEAN COMMENT 'Indicates whether this asset was explicitly included in the Investment Committee memo for this deal. In some portfolio deals, certain assets may be excluded from IC review or presented separately. True = included in IC memo, False = excluded or presented separately.',
    `underwritten_value_allocated` DECIMAL(18,2) COMMENT 'The portion of the total underwritten deal value allocated to this specific asset. In portfolio deals, the total underwritten_value from investment_deal is broken down per asset. This represents the Asset Managers valuation of this individual asset within the deal context. Currency matches the deal currency.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this deal-asset association record. Audit trail for tracking changes to allocation, DD status, or other deal-asset attributes.',
    CONSTRAINT pk_deal_asset PRIMARY KEY(`deal_asset_id`)
) COMMENT 'This association product represents the inclusion of a specific asset within an investment deal pipeline. It captures the underwriting, due diligence, and allocation details that exist only in the context of a specific asset being evaluated or transacted within a specific deal. Each record links one asset to one investment deal with attributes such as allocated underwritten value, due diligence status, allocation percentage, and asset-specific deal roles (e.g., anchor asset, portfolio filler, value-add component).. Existence Justification: In real estate investment operations, a single asset can appear in multiple competing deal scenarios simultaneously (e.g., multiple bidders, different portfolio configurations, disposition vs. hold analysis), and portfolio acquisition deals routinely involve multiple assets under a single transaction structure. Investment teams actively manage the deal-asset relationship by tracking per-asset underwritten values, due diligence findings, allocation percentages, and strategic roles (anchor vs. filler) that exist only in the deal context.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`asset_audit_scope` (
    `asset_audit_scope_id` BIGINT COMMENT 'Unique system-generated identifier for this asset-audit scope inclusion record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the real estate asset included in the audit engagement scope.',
    `audit_engagement_id` BIGINT COMMENT 'Foreign key linking to the audit engagement that includes this asset in its scope.',
    `asset_risk_rating` STRING COMMENT 'The risk rating assigned to this specific asset within the context of this particular audit engagement. The same asset may have different risk ratings across different audit engagements depending on audit focus, timing, and asset circumstances. This is relationship-specific data that belongs to the asset-audit association, not to the asset itself (which may have a separate enterprise risk rating) or the audit engagement (which has an overall engagement risk rating).',
    `auditor_assigned` STRING COMMENT 'Name or identifier of the specific auditor or audit team member assigned to review this asset within the engagement. While the engagement has a lead_auditor_name, individual assets within the scope may be assigned to different team members. This is relationship-specific assignment data.',
    `fieldwork_hours` DECIMAL(18,2) COMMENT 'Total number of auditor hours spent on fieldwork activities specific to this asset within this engagement. Enables asset-level effort tracking and cost allocation. This is relationship-specific quantitative data that belongs to the association.',
    `findings_count_for_asset` STRING COMMENT 'The number of audit findings identified that are specific to this asset within this audit engagement. This is relationship-specific data — the audit engagement has a total_findings_count across all assets, but this attribute captures findings attributable to this particular asset within this particular audit. Essential for asset-level audit performance tracking and risk management.',
    `included_date` DATE COMMENT 'The date on which this asset was formally added to the audit engagement scope. Captures the operational event of scope definition. May differ from the audit engagement fieldwork_start_date if scope was defined earlier or if assets were added mid-engagement. This is relationship-specific temporal data that belongs to the association.',
    `scope_inclusion_reason` STRING COMMENT 'The business rationale for including this specific asset in this audit engagement scope. Captures why the asset was selected for review — risk-based selection, regulatory requirement, management request, prior findings follow-up, acquisition due diligence, disposition review, material asset threshold, random sampling, geographic coverage, or asset class coverage. This attribute exists only in the context of the asset-audit relationship and cannot belong to either the asset or the audit engagement alone.',
    `scope_status` STRING COMMENT 'The current status of audit activities for this specific asset within this engagement. Tracks progression from planned inclusion through fieldwork completion and findings issuance. Allows for asset-level status tracking within an engagement where different assets may be at different stages of review.',
    CONSTRAINT pk_asset_audit_scope PRIMARY KEY(`asset_audit_scope_id`)
) COMMENT 'This association product represents the inclusion of specific real estate assets within formal audit engagement scopes. It captures the operational reality that audit engagements cover multiple properties across the portfolio, and individual assets are subject to multiple audit engagements over time (annual audits, acquisition due diligence, disposition audits, regulatory examinations). Each record links one asset to one audit engagement with attributes that exist only in the context of this specific audit scope inclusion — the reason the asset was selected for review, the risk rating assigned to that asset within this particular engagement, the number of findings specific to that asset, and the date the asset was formally included in scope.. Existence Justification: In real estate audit operations, audit engagements routinely cover multiple properties across the portfolio (portfolio-wide SOX audits, regulatory examinations, internal control reviews), and individual assets are subject to multiple audit engagements over time (annual financial audits, acquisition due diligence audits, disposition audits, ESG audits, regulatory examinations). The business actively manages audit scope as an operational process — compliance teams define which assets are in scope for each engagement, assign asset-specific risk ratings, track asset-specific findings, and allocate auditor resources at the asset level within each engagement.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`property`.`floor` (
    `floor_id` BIGINT COMMENT 'Primary key for floor',
    `building_id` BIGINT COMMENT 'Reference to the parent building that contains this floor.',
    `hvac_zone_id` BIGINT COMMENT 'Identifier for the HVAC zone or system serving this floor.',
    `parent_floor_id` BIGINT COMMENT 'Self-referencing FK on floor (parent_floor_id)',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the floor meets ADA accessibility standards for persons with disabilities.',
    `bim_model_reference` STRING COMMENT 'Reference identifier or URI to the BIM model element representing this floor.',
    `cctv_coverage` BOOLEAN COMMENT 'Indicates whether the floor is monitored by CCTV security cameras.',
    `ceiling_height_m` DECIMAL(18,2) COMMENT 'Standard ceiling height from finished floor to finished ceiling, measured in meters.',
    `certificate_of_occupancy_date` DATE COMMENT 'Date when the Certificate of Occupancy was issued for this floor, permitting legal occupancy.',
    `common_area_sqft` DECIMAL(18,2) COMMENT 'Shared spaces on the floor such as lobbies, corridors, restrooms, and elevator lobbies. Measured in square feet.',
    `common_area_sqm` DECIMAL(18,2) COMMENT 'Shared spaces on the floor such as lobbies, corridors, restrooms, and elevator lobbies. Measured in square meters.',
    `construction_completion_date` DATE COMMENT 'Date when construction or major renovation of the floor was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the floor record was first created in the system.',
    `elevator_access` BOOLEAN COMMENT 'Indicates whether the floor is served by elevator access.',
    `emergency_exit_count` STRING COMMENT 'Number of emergency exits or egress points available on the floor.',
    `energy_efficiency_rating` STRING COMMENT 'Energy performance rating or certification level for the floor (e.g., LEED Gold, BREEAM Excellent, Energy Star score).',
    `fire_zone_designation` STRING COMMENT 'Fire safety zone classification for emergency response and compartmentalization.',
    `floor_finish_type` STRING COMMENT 'Type of flooring material or finish installed (e.g., carpet, tile, hardwood, concrete, vinyl).',
    `floor_load_capacity_kg_sqm` DECIMAL(18,2) COMMENT 'Maximum live load the floor structure can support, measured in kilograms per square meter.',
    `floor_load_capacity_lbs_sqft` DECIMAL(18,2) COMMENT 'Maximum live load the floor structure can support, measured in pounds per square foot.',
    `floor_name` STRING COMMENT 'Common or marketing name for the floor (e.g., Executive Suite Level, Retail Concourse, Sky Lobby).',
    `floor_number` STRING COMMENT 'The floor number or level designation within the building (e.g., 1, 2, B1 for basement 1, M for mezzanine, PH for penthouse). May include alphanumeric codes for special levels.',
    `floor_plate_efficiency_pct` DECIMAL(18,2) COMMENT 'Ratio of net leasable area to gross floor area, expressed as a percentage. Indicates how efficiently the floor space is utilized for revenue-generating purposes.',
    `floor_type` STRING COMMENT 'Classification of the floor based on its position and function within the building structure.',
    `gross_floor_area_sqft` DECIMAL(18,2) COMMENT 'Total floor area measured to the exterior face of exterior walls, including all enclosed spaces. Measured in square feet.',
    `gross_floor_area_sqm` DECIMAL(18,2) COMMENT 'Total floor area measured to the exterior face of exterior walls, including all enclosed spaces. Measured in square meters.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the floor record is currently active in the system.',
    `last_renovation_date` DATE COMMENT 'Date of the most recent renovation or refurbishment work performed on the floor.',
    `natural_light_availability` BOOLEAN COMMENT 'Indicates whether the floor has access to natural daylight through windows or skylights.',
    `net_leasable_area_sqft` DECIMAL(18,2) COMMENT 'The area available for lease to tenants, excluding common areas, mechanical rooms, and structural elements. Measured in square feet.',
    `net_leasable_area_sqm` DECIMAL(18,2) COMMENT 'The area available for lease to tenants, excluding common areas, mechanical rooms, and structural elements. Measured in square meters.',
    `number_of_units` STRING COMMENT 'Total count of individual units, suites, or spaces located on this floor.',
    `occupancy_capacity` STRING COMMENT 'Maximum number of occupants permitted on the floor based on building code and fire safety regulations.',
    `remarks` STRING COMMENT 'Additional notes, comments, or special considerations related to the floor.',
    `security_access_level` STRING COMMENT 'Classification of security access controls required to enter the floor.',
    `smart_building_enabled` BOOLEAN COMMENT 'Indicates whether the floor is equipped with smart building technologies such as IoT sensors, automated controls, or integrated building management systems.',
    `sprinkler_system_installed` BOOLEAN COMMENT 'Indicates whether an automatic fire sprinkler system is installed on this floor.',
    `stair_access` BOOLEAN COMMENT 'Indicates whether the floor is accessible via stairways.',
    `floor_status` STRING COMMENT 'Current operational status of the floor in its lifecycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the floor record was last modified in the system.',
    `usage_type` STRING COMMENT 'Primary intended use or occupancy classification for the floor.',
    `wifi_coverage` BOOLEAN COMMENT 'Indicates whether the floor has wireless internet (WiFi) coverage available.',
    `window_line_exposure` STRING COMMENT 'Primary direction of exterior window exposure for natural light and views.',
    CONSTRAINT pk_floor PRIMARY KEY(`floor_id`)
) COMMENT 'Master reference table for floor. Referenced by floor_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`property`.`asset` ADD CONSTRAINT `fk_property_asset_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building` ADD CONSTRAINT `fk_property_building_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_address_id` FOREIGN KEY (`address_id`) REFERENCES `real_estate_ecm`.`property`.`address`(`address_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`unit` ADD CONSTRAINT `fk_property_unit_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_floor_id` FOREIGN KEY (`floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_suite_unit_id` FOREIGN KEY (`suite_unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space` ADD CONSTRAINT `fk_property_space_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ADD CONSTRAINT `fk_property_property_ownership_interest_title_record_id` FOREIGN KEY (`title_record_id`) REFERENCES `real_estate_ecm`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `real_estate_ecm`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_common_area_id` FOREIGN KEY (`common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ADD CONSTRAINT `fk_property_inspection_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ADD CONSTRAINT `fk_property_occupancy_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `real_estate_ecm`.`property`.`unit`(`unit_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_parent_node_asset_hierarchy_id` FOREIGN KEY (`parent_node_asset_hierarchy_id`) REFERENCES `real_estate_ecm`.`property`.`asset_hierarchy`(`asset_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ADD CONSTRAINT `fk_property_asset_hierarchy_primary_prior_parent_node_asset_hierarchy_id` FOREIGN KEY (`primary_prior_parent_node_asset_hierarchy_id`) REFERENCES `real_estate_ecm`.`property`.`asset_hierarchy`(`asset_hierarchy_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ADD CONSTRAINT `fk_property_amenity_replaced_amenity_id` FOREIGN KEY (`replaced_amenity_id`) REFERENCES `real_estate_ecm`.`property`.`amenity`(`amenity_id`);
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ADD CONSTRAINT `fk_property_common_area_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ADD CONSTRAINT `fk_property_common_area_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ADD CONSTRAINT `fk_property_common_area_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ADD CONSTRAINT `fk_property_common_area_parent_common_area_id` FOREIGN KEY (`parent_common_area_id`) REFERENCES `real_estate_ecm`.`property`.`common_area`(`common_area_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parking` ADD CONSTRAINT `fk_property_parking_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parking` ADD CONSTRAINT `fk_property_parking_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parking` ADD CONSTRAINT `fk_property_parking_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`parking` ADD CONSTRAINT `fk_property_parking_replaced_parking_id` FOREIGN KEY (`replaced_parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ADD CONSTRAINT `fk_property_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ADD CONSTRAINT `fk_property_building_policy_coverage_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ADD CONSTRAINT `fk_property_property_occupancy_occupancy_record_id` FOREIGN KEY (`occupancy_record_id`) REFERENCES `real_estate_ecm`.`property`.`occupancy_record`(`occupancy_record_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ADD CONSTRAINT `fk_property_property_occupancy_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ADD CONSTRAINT `fk_property_property_demised_space_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ADD CONSTRAINT `fk_property_property_demised_space_property_space_id` FOREIGN KEY (`property_space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ADD CONSTRAINT `fk_property_building_compliance_obligation_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ADD CONSTRAINT `fk_property_building_certification_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ADD CONSTRAINT `fk_property_allocation_parking_id` FOREIGN KEY (`parking_id`) REFERENCES `real_estate_ecm`.`property`.`parking`(`parking_id`);
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ADD CONSTRAINT `fk_property_space_campaign_inclusion_space_id` FOREIGN KEY (`space_id`) REFERENCES `real_estate_ecm`.`property`.`space`(`space_id`);
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ADD CONSTRAINT `fk_property_deal_asset_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ADD CONSTRAINT `fk_property_asset_audit_scope_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `real_estate_ecm`.`property`.`asset`(`asset_id`);
ALTER TABLE `real_estate_ecm`.`property`.`floor` ADD CONSTRAINT `fk_property_floor_building_id` FOREIGN KEY (`building_id`) REFERENCES `real_estate_ecm`.`property`.`building`(`building_id`);
ALTER TABLE `real_estate_ecm`.`property`.`floor` ADD CONSTRAINT `fk_property_floor_parent_floor_id` FOREIGN KEY (`parent_floor_id`) REFERENCES `real_estate_ecm`.`property`.`floor`(`floor_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`property` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `real_estate_ecm`.`property` SET TAGS ('dbx_domain' = 'property');
ALTER TABLE `real_estate_ecm`.`property`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `zoning_code_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|disposed|under_development|held_for_sale|held_for_investment');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `bim_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Model Reference');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `breeam_rating` SET TAGS ('dbx_business_glossary_term' = 'Building Research Establishment Environmental Assessment Method (BREEAM) Rating');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `breeam_rating` SET TAGS ('dbx_value_regex' = 'outstanding|excellent|very_good|good|pass|unclassified');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `coo_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Issue Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `coo_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Status');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `coo_status` SET TAGS ('dbx_value_regex' = 'issued|pending|not_required|expired|revoked');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `costar_property_number` SET TAGS ('dbx_business_glossary_term' = 'CoStar Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `disposition_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `energy_star_score` SET TAGS ('dbx_business_glossary_term' = 'ENERGY STAR Score');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `far` SET TAGS ('dbx_business_glossary_term' = 'Floor Area Ratio (FAR)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `fips_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `is_encumbered` SET TAGS ('dbx_business_glossary_term' = 'Is Encumbered Flag');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `leed_certification` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `leed_certification` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|not_certified');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `legal_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `nla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area (NLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `total_floors` SET TAGS ('dbx_business_glossary_term' = 'Total Floors');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `total_units` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`property`.`asset` ALTER COLUMN `year_renovated` SET TAGS ('dbx_business_glossary_term' = 'Year Renovated');
ALTER TABLE `real_estate_ecm`.`property`.`building` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`building` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_class_id` SET TAGS ('dbx_business_glossary_term' = 'Building Class Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `construction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `zoning_code_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `bim_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Reference ID');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_status` SET TAGS ('dbx_business_glossary_term' = 'Building Status');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `building_status` SET TAGS ('dbx_value_regex' = 'operational|under_construction|under_renovation|demolished|held_for_sale|mothballed');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `coo_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Date');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `elevator_count` SET TAGS ('dbx_business_glossary_term' = 'Elevator Count');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `far` SET TAGS ('dbx_business_glossary_term' = 'Floor Area Ratio (FAR)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Type');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_value_regex' = 'wet_pipe|dry_pipe|pre_action|deluge|none');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `floors_above_grade` SET TAGS ('dbx_business_glossary_term' = 'Floors Above Grade');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `floors_below_grade` SET TAGS ('dbx_business_glossary_term' = 'Floors Below Grade');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `gla_sqm` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) System Type');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `is_esg_reported` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Reporting Flag');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `nla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area (NLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `nla_sqm` SET TAGS ('dbx_business_glossary_term' = 'Net Leasable Area (NLA) in Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `parking_ratio` SET TAGS ('dbx_business_glossary_term' = 'Parking Ratio');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `parking_stalls_total` SET TAGS ('dbx_business_glossary_term' = 'Total Parking Stalls');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `structural_system` SET TAGS ('dbx_business_glossary_term' = 'Structural System');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `total_rentable_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Rentable Area in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `real_estate_ecm`.`property`.`building` ALTER COLUMN `year_renovated` SET TAGS ('dbx_business_glossary_term' = 'Year Renovated');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel ID');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `zoning_code_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `assessed_land_value` SET TAGS ('dbx_business_glossary_term' = 'Assessed Land Value');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `assessed_land_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `assessed_value_year` SET TAGS ('dbx_business_glossary_term' = 'Assessed Value Year');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Parcel Centroid Latitude');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Parcel Centroid Longitude');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `deed_book_page` SET TAGS ('dbx_business_glossary_term' = 'Deed Book and Page Reference');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `easement_description` SET TAGS ('dbx_business_glossary_term' = 'Easement Description');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `environmental_designation` SET TAGS ('dbx_business_glossary_term' = 'Environmental Designation');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `environmental_designation` SET TAGS ('dbx_value_regex' = 'none|brownfield|superfund|wetland|contaminated|under_review');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `far_allowed` SET TAGS ('dbx_business_glossary_term' = 'Floor Area Ratio (FAR) Allowed');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `fema_map_panel_number` SET TAGS ('dbx_business_glossary_term' = 'FEMA Flood Insurance Rate Map (FIRM) Panel Number');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `flood_zone_designation` SET TAGS ('dbx_business_glossary_term' = 'FEMA Flood Zone Designation');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `front_setback_ft` SET TAGS ('dbx_business_glossary_term' = 'Front Setback (Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `gis_boundary_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Boundary Well-Known Text (WKT)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `last_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sale Date');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `last_sale_price` SET TAGS ('dbx_business_glossary_term' = 'Last Sale Price');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `last_sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `lot_size_acres` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Acres)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `lot_size_sqf` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `lot_size_sqm` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `max_building_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Maximum Building Height (Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parcel_name` SET TAGS ('dbx_business_glossary_term' = 'Parcel Name');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parcel_status` SET TAGS ('dbx_business_glossary_term' = 'Parcel Status');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parcel_status` SET TAGS ('dbx_value_regex' = 'active|subdivided|merged|inactive|pending');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parcel_type` SET TAGS ('dbx_business_glossary_term' = 'Parcel Type');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parcel_type` SET TAGS ('dbx_value_regex' = 'land|improved|condominium|timeshare|right_of_way');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `parent_apn` SET TAGS ('dbx_business_glossary_term' = 'Parent Assessor Parcel Number (APN)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `phase_i_esa_completed` SET TAGS ('dbx_business_glossary_term' = 'Phase I Environmental Site Assessment (ESA) Completed');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `phase_i_esa_date` SET TAGS ('dbx_business_glossary_term' = 'Phase I Environmental Site Assessment (ESA) Date');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `plat_map_reference` SET TAGS ('dbx_business_glossary_term' = 'Plat Map Reference');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `rear_setback_ft` SET TAGS ('dbx_business_glossary_term' = 'Rear Setback (Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `side_setback_ft` SET TAGS ('dbx_business_glossary_term' = 'Side Setback (Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `soil_classification` SET TAGS ('dbx_business_glossary_term' = 'Soil Classification');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `subdivision_name` SET TAGS ('dbx_business_glossary_term' = 'Subdivision Name');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `title_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Title Reference Number');
ALTER TABLE `real_estate_ecm`.`property`.`parcel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`unit` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `available_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Available Date');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `bathroom_count` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Count');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `bedroom_count` SET TAGS ('dbx_business_glossary_term' = 'Bedroom Count');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `bim_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Reference');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `breeam_rating` SET TAGS ('dbx_business_glossary_term' = 'Building Research Establishment Environmental Assessment Method (BREEAM) Rating');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `breeam_rating` SET TAGS ('dbx_value_regex' = 'outstanding|excellent|very_good|good|pass|unclassified');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `cam_eligible` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Eligible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `configuration` SET TAGS ('dbx_business_glossary_term' = 'Unit Configuration');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `configuration` SET TAGS ('dbx_value_regex' = 'open_plan|private_offices|mixed|bullpen|loft|raw');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `coo_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Issue Date');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `coo_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Status');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `coo_status` SET TAGS ('dbx_value_regex' = 'issued|pending|not_required|expired|revoked');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `efficiency_ratio` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Ratio');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `energy_rating` SET TAGS ('dbx_business_glossary_term' = 'Energy Performance Rating');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `energy_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `has_balcony` SET TAGS ('dbx_business_glossary_term' = 'Balcony or Patio Flag');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `hvac_zone` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Zone');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `internet_connectivity` SET TAGS ('dbx_business_glossary_term' = 'Internet Connectivity Type');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `internet_connectivity` SET TAGS ('dbx_value_regex' = 'fiber|cable|DSL|none');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `is_furnished` SET TAGS ('dbx_business_glossary_term' = 'Furnished Unit Flag');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `last_renovated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovated Date');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `lease_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Lease Type Eligibility');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `lease_type_eligibility` SET TAGS ('dbx_value_regex' = 'gross|NNN|modified_gross|NNN|FSG');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `leed_certification` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Level');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `leed_certification` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|none');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `market_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Market Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `market_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `metering_type` SET TAGS ('dbx_business_glossary_term' = 'Utility Metering Type');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `metering_type` SET TAGS ('dbx_value_regex' = 'individually_metered|master_metered|sub_metered|none');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `mri_unit_code` SET TAGS ('dbx_business_glossary_term' = 'MRI Software Unit Code');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Unit Notes');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Allocated Parking Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'Pro Rata Share');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `rentable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Rentable Area in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `rentable_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Rentable Area in Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Status');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'vacant|occupied|under_renovation|offline|pre_leased|model');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `usable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Usable Area in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `view_type` SET TAGS ('dbx_business_glossary_term' = 'View Type');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `view_type` SET TAGS ('dbx_value_regex' = 'city|park|water|courtyard|street|none');
ALTER TABLE `real_estate_ecm`.`property`.`unit` ALTER COLUMN `yardi_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Unit Code');
ALTER TABLE `real_estate_ecm`.`property`.`space` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`space` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Space Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor ID');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `lease_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Lease Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_use_type_id` SET TAGS ('dbx_business_glossary_term' = 'Space Use Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `suite_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Suite ID');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `asking_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `available_date` SET TAGS ('dbx_business_glossary_term' = 'Available Date');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `bim_element_code` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Element ID');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `building_engines_space_code` SET TAGS ('dbx_business_glossary_term' = 'Building Engines Space ID');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `cam_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `cam_eligible` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Eligible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `ceiling_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Height Feet');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Space Condition');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'shell|warm_shell|plug_and_play|full_fit_out|as_is');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `effective_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Effective Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `effective_rent_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `electrical_capacity_amps` SET TAGS ('dbx_business_glossary_term' = 'Electrical Capacity Amperes');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `energy_star_eligible` SET TAGS ('dbx_business_glossary_term' = 'ENERGY STAR Eligible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `floor_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Floor Plan Reference');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `hvac_zone` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Zone');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `is_contiguous` SET TAGS ('dbx_business_glossary_term' = 'Contiguous Space Flag');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `is_subdivisible` SET TAGS ('dbx_business_glossary_term' = 'Subdivisible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `last_occupied_date` SET TAGS ('dbx_business_glossary_term' = 'Last Occupied Date');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Level');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|none');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Space Notes');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `occupancy_class` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Class');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `occupancy_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'Pro-Rata Share');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `rentable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Rentable Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `rentable_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Rentable Area Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_name` SET TAGS ('dbx_business_glossary_term' = 'Space Name');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_number` SET TAGS ('dbx_business_glossary_term' = 'Space Number');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_number` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-.]{1,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_status` SET TAGS ('dbx_business_glossary_term' = 'Space Status');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_status` SET TAGS ('dbx_value_regex' = 'available|occupied|under_build_out|offline|reserved|decommissioned');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `space_type` SET TAGS ('dbx_business_glossary_term' = 'Space Type');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_business_glossary_term' = 'Tenant Improvement (TI) Allowance Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `ti_allowance_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `usable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Usable Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `usable_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Usable Area Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`space` ALTER COLUMN `yardi_space_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Space Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`address` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address ID');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_source` SET TAGS ('dbx_business_glossary_term' = 'Address Source System');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_source` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'primary|mailing|legal|billing|secondary');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `carrier_route` SET TAGS ('dbx_business_glossary_term' = 'USPS Carrier Route Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `carrier_route` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_value_regex' = '^[0-9]{4,6}(.[0-9]{2})?$');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `congressional_district` SET TAGS ('dbx_business_glossary_term' = 'Congressional District');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `delivery_point_barcode` SET TAGS ('dbx_business_glossary_term' = 'USPS Delivery Point Barcode (DPBC)');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Address Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `fips_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Information Processing Standards (FIPS) County Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `flood_zone_code` SET TAGS ('dbx_business_glossary_term' = 'FEMA Flood Zone Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy Level');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'rooftop|parcel_centroid|street_interpolated|zip_centroid|city_centroid');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `geocode_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Geocode Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Address Flag');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geocode Latitude');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geocode Longitude');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `msa_code` SET TAGS ('dbx_business_glossary_term' = 'Metropolitan Statistical Area (MSA) Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `msa_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `neighborhood_name` SET TAGS ('dbx_business_glossary_term' = 'Neighborhood Name');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `opportunity_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Zone Flag');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `plus4_code` SET TAGS ('dbx_business_glossary_term' = 'USPS ZIP+4 Code');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `plus4_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP Code)');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Address Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `tax_parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Parcel Number (APN)');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `transit_score` SET TAGS ('dbx_business_glossary_term' = 'Transit Score');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `usps_standardized` SET TAGS ('dbx_business_glossary_term' = 'USPS Standardized Flag');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|corrected|pending');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `walk_score` SET TAGS ('dbx_business_glossary_term' = 'Walk Score');
ALTER TABLE `real_estate_ecm`.`property`.`address` ALTER COLUMN `zoning_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Zoning Jurisdiction');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `property_ownership_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Property Ownership Interest ID');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner ID');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `title_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title Record Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `allocated_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Debt Amount');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `allocated_debt_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `deed_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Deed Reference Number');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `deed_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `distribution_priority` SET TAGS ('dbx_business_glossary_term' = 'Distribution Priority');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `encumbrance_description` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Description');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `encumbrance_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `equity_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Equity Contribution Amount');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `equity_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `interest_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Reference Number');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `is_controlling_interest` SET TAGS ('dbx_business_glossary_term' = 'Controlling Interest Flag');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `is_managing_member` SET TAGS ('dbx_business_glossary_term' = 'Managing Member Flag');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `ownership_notes` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Notes');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Interest Status');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'active|transferred|dissolved|pending|encumbered');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `ownership_structure` SET TAGS ('dbx_business_glossary_term' = 'Ownership Structure');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferred Return Rate');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `preferred_return_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `recording_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Recording Jurisdiction');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `snda_status` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment Agreement (SNDA) Status');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `snda_status` SET TAGS ('dbx_value_regex' = 'executed|pending|not_required|waived');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'yardi|mri|argus|sap|manual');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `title_company_name` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `title_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Number');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `title_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `title_vesting_language` SET TAGS ('dbx_business_glossary_term' = 'Title Vesting Language');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `title_vesting_language` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `transfer_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction Flag');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `voting_rights_percentage` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`property_ownership_interest` ALTER COLUMN `voting_rights_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title Record ID');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `chain_of_title_notes` SET TAGS ('dbx_business_glossary_term' = 'Chain of Title Notes');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `county_recorder_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'County Recorder Jurisdiction');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `deed_book` SET TAGS ('dbx_business_glossary_term' = 'Deed Book Reference');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `deed_page` SET TAGS ('dbx_business_glossary_term' = 'Deed Page Reference');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_grantee` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Grantee');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_grantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_grantor` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Grantor');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_grantor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Maturity Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_recording_date` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Recording Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_recording_number` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Recording Number');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_release_date` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Release Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Status');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|disputed');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `encumbrance_type` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Type');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `environmental_lien_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Lien Flag');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `grantee_name` SET TAGS ('dbx_business_glossary_term' = 'Grantee Name');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `grantee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `grantor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `lis_pendens_flag` SET TAGS ('dbx_business_glossary_term' = 'Lis Pendens Flag');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_amount` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Amount');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Number');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Type (ALTA)');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'alta_owner|alta_lender|alta_extended|leasehold_owner|leasehold_lender');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `priority_position` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Priority Position');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `recording_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Number');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `snda_on_file` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment Agreement (SNDA) on File');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi_voyager|mri_software|docusign_clm|manual_entry');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `survey_on_file` SET TAGS ('dbx_business_glossary_term' = 'Survey on File');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_company` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_examination_date` SET TAGS ('dbx_business_glossary_term' = 'Title Examination Date');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_examiner` SET TAGS ('dbx_business_glossary_term' = 'Title Examiner Name');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_number` SET TAGS ('dbx_business_glossary_term' = 'Title Number');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_opinion_on_file` SET TAGS ('dbx_business_glossary_term' = 'Title Opinion on File');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_status` SET TAGS ('dbx_business_glossary_term' = 'Title Status');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `title_status` SET TAGS ('dbx_value_regex' = 'clear|encumbered|in_dispute|pending_release|under_review');
ALTER TABLE `real_estate_ecm`.`property`.`title_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `common_area_id` SET TAGS ('dbx_business_glossary_term' = 'Common Area Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `debt_covenant_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Covenant Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Osha Incident Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions Notes');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Due Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Condition Rating');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Total Deficiency Count');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `environmental_phase` SET TAGS ('dbx_business_glossary_term' = 'Environmental Site Assessment (ESA) Phase');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `environmental_phase` SET TAGS ('dbx_value_regex' = 'phase_i|phase_ii|phase_iii|not_applicable');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|biennial|as_needed');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `has_critical_deficiency` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Flag');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `immediate_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Immediate Repair Cost Estimate');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `immediate_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^INSP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_value_regex' = 'full_property|building_only|unit_only|common_areas|exterior_only|specific_system');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|cancelled');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspector_company` SET TAGS ('dbx_business_glossary_term' = 'Inspector Company Name');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspector_license_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector License Number');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspector_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Full Name');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Field Notes');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `internal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Internal Reviewer Name');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Required Flag');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `leed_relevant` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Relevant Flag');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `long_term_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Repair Cost Estimate');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `long_term_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Pass/Fail Result');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `reinspection_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Scheduled Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `reinspection_required` SET TAGS ('dbx_business_glossary_term' = 'Re-Inspection Required Flag');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `report_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Document Reference');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Version');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `report_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Completed Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `short_term_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Short-Term Repair Cost Estimate');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `short_term_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'building_engines|yardi_voyager|procore|manual|mri_software');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `trigger` SET TAGS ('dbx_business_glossary_term' = 'Inspection Trigger');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`inspection` ALTER COLUMN `work_order_triggered` SET TAGS ('dbx_business_glossary_term' = 'Work Order Triggered Flag');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `occupancy_record_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Record ID');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `uom_id` SET TAGS ('dbx_business_glossary_term' = 'Area Uom Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `asset_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Performance Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit ID');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `area_under_notice_sqf` SET TAGS ('dbx_business_glossary_term' = 'Area Under Notice Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `average_in_place_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Average In-Place Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `credit_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Loss Amount');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `credit_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'clean|estimated|reconciling|error');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `economic_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Economic Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `effective_gross_income` SET TAGS ('dbx_business_glossary_term' = 'Effective Gross Income (EGI)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `effective_gross_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `gross_absorption_sqf` SET TAGS ('dbx_business_glossary_term' = 'Gross Absorption Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `is_same_store` SET TAGS ('dbx_business_glossary_term' = 'Same-Store Indicator');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `is_stabilized` SET TAGS ('dbx_business_glossary_term' = 'Stabilized Asset Indicator');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `lease_expirations_sqf` SET TAGS ('dbx_business_glossary_term' = 'Lease Expirations Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `lease_up_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease-Up Start Date');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `market_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Market Rent Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `measurement_level` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Measurement Level');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `measurement_level` SET TAGS ('dbx_value_regex' = 'building|floor|unit|portfolio');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `net_absorption_sqf` SET TAGS ('dbx_business_glossary_term' = 'Net Absorption Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `new_leases_sqf` SET TAGS ('dbx_business_glossary_term' = 'New Leases Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `occupied_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Occupied Area Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `occupied_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Occupied Unit Count');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|point_in_time');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `physical_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Physical Occupancy Rate');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `potential_gross_income` SET TAGS ('dbx_business_glossary_term' = 'Potential Gross Income (PGI)');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `potential_gross_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Record Status');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|published|revised|superseded|void');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `renewal_leases_sqf` SET TAGS ('dbx_business_glossary_term' = 'Renewal Leases Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Yardi Voyager|MRI Software|RealPage|Argus Enterprise|Manual');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `stabilization_date` SET TAGS ('dbx_business_glossary_term' = 'Stabilization Date');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `total_gla_sqf` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Leasable Area (GLA) Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `total_nla_sqf` SET TAGS ('dbx_business_glossary_term' = 'Total Net Leasable Area (NLA) Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `total_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Count');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `units_under_notice_count` SET TAGS ('dbx_business_glossary_term' = 'Units Under Notice Count');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `vacancy_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Loss Amount');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `vacancy_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `vacant_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Vacant Area Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `vacant_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Vacant Unit Count');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `wale_years` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Lease Expiry (WALE) Years');
ALTER TABLE `real_estate_ecm`.`property`.`occupancy_record` ALTER COLUMN `walt_years` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Lease Term (WALT) Years');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `asset_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `geographic_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Hierarchy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `parent_node_asset_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Node ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `primary_prior_parent_node_asset_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Parent Node ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `argus_portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Argus Enterprise Portfolio Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `argus_portfolio_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `aum_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Inclusion Flag');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'yardi|mri|argus|manual|sap|costar');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `esg_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Classification');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `esg_classification` SET TAGS ('dbx_value_regex' = 'green|brown|transition|not_classified');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `gav_basis` SET TAGS ('dbx_business_glossary_term' = 'Gross Asset Value (GAV) Basis');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `gav_basis` SET TAGS ('dbx_value_regex' = 'cost|fair_value|appraised|book_value');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level Number');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|restructured|dissolved|pending|suspended');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Flag');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `is_reportable_segment` SET TAGS ('dbx_business_glossary_term' = 'Reportable Segment Flag');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `mri_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'MRI Software Hierarchy Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `mri_hierarchy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Type');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Notes');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `reit_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Investment Trust (REIT) Segment Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `reit_segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,20}$');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `restructure_reason` SET TAGS ('dbx_business_glossary_term' = 'Restructure Reason');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `target_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `target_allocation_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `yardi_tree_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Tree Code');
ALTER TABLE `real_estate_ecm`.`property`.`asset_hierarchy` ALTER COLUMN `yardi_tree_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity ID');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_type_id` SET TAGS ('dbx_business_glossary_term' = 'Amenity Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `replaced_amenity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `access_control_type` SET TAGS ('dbx_business_glossary_term' = 'Access Control Type');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `access_control_type` SET TAGS ('dbx_value_regex' = 'key_fob|key_card|pin_code|biometric|open_access|staff_supervised');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_code` SET TAGS ('dbx_business_glossary_term' = 'Amenity Code');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_description` SET TAGS ('dbx_business_glossary_term' = 'Amenity Description');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_name` SET TAGS ('dbx_business_glossary_term' = 'Amenity Name');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_status` SET TAGS ('dbx_business_glossary_term' = 'Amenity Status');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `amenity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_maintenance|seasonal|decommissioned|planned');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `annual_opex_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Expenditure (OPEX) Budget');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Amenity Area (Square Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Amenity Area (Square Meters)');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `building_engines_amenity_code` SET TAGS ('dbx_business_glossary_term' = 'Building Engines Amenity ID');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `cam_eligible` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Eligible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Amenity Capacity');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Amenity Condition Rating');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `esg_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Category');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `esg_category` SET TAGS ('dbx_value_regex' = 'environmental|social|governance|none');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `ev_charging_stations` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Charging Stations Count');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `is_24_hour` SET TAGS ('dbx_business_glossary_term' = 'Is 24-Hour Access Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `is_reservable` SET TAGS ('dbx_business_glossary_term' = 'Is Reservable Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `is_tenant_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Tenant Exclusive Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `leed_contribution` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Contribution Flag');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Amenity Location Description');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'landlord|tenant|hoa|third_party_vendor|shared');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amenity Notes');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d-([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d-([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `parking_stalls` SET TAGS ('dbx_business_glossary_term' = 'Parking Stalls Count');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `photo_reference` SET TAGS ('dbx_business_glossary_term' = 'Amenity Photo Reference');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `seasonal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Close Date');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `seasonal_open_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Open Date');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`amenity` ALTER COLUMN `yardi_amenity_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Amenity Code');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `common_area_id` SET TAGS ('dbx_business_glossary_term' = 'Common Area ID');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Building Engines Space ID');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `parent_common_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `access_control_type` SET TAGS ('dbx_business_glossary_term' = 'Access Control Type');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `access_control_type` SET TAGS ('dbx_value_regex' = 'unrestricted|key_card|key_fob|biometric|intercom|locked');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `ada_last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Last Assessment Date');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `annual_cam_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Common Area Maintenance (CAM) Budget');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `annual_cam_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Common Area Code');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Common Area Name');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `area_notes` SET TAGS ('dbx_business_glossary_term' = 'Common Area Notes');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `area_status` SET TAGS ('dbx_business_glossary_term' = 'Common Area Status');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `area_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_renovation|decommissioned|pending_activation');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `bim_element_code` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Element ID');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `cam_allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Allocation Basis');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `cam_allocation_basis` SET TAGS ('dbx_value_regex' = 'pro_rata_sqf|fixed_amount|equal_share|custom_formula|excluded');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `cam_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `cam_eligible` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Eligible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `cctv_coverage` SET TAGS ('dbx_business_glossary_term' = 'Closed-Circuit Television (CCTV) Coverage Flag');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `ceiling_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Height Feet');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `energy_metering_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Metering Type');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `energy_metering_type` SET TAGS ('dbx_value_regex' = 'sub_metered|master_metered|unmetered|shared_meter');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `esg_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Classification');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `esg_classification` SET TAGS ('dbx_value_regex' = 'green|standard|non_compliant|under_review');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_value_regex' = 'sprinkler_wet|sprinkler_dry|halon|none|other');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `hvac_zone` SET TAGS ('dbx_business_glossary_term' = 'Heating Ventilation and Air Conditioning (HVAC) Zone');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `is_ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Flag');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `is_publicly_accessible` SET TAGS ('dbx_business_glossary_term' = 'Publicly Accessible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `last_renovation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Date');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Level');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|none');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `maintenance_responsibility` SET TAGS ('dbx_value_regex' = 'landlord|tenant|shared|hoa|third_party');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `max_occupancy` SET TAGS ('dbx_business_glossary_term' = 'Maximum Occupancy');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'Pro-Rata Share');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `renovation_cost` SET TAGS ('dbx_business_glossary_term' = 'Renovation Cost');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `renovation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `rentable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Rentable Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `rentable_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Rentable Area Square Meters (SQM)');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `usable_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Usable Area Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`property`.`common_area` ALTER COLUMN `yardi_space_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Space Code');
ALTER TABLE `real_estate_ecm`.`property`.`parking` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`parking` SET TAGS ('dbx_subdomain' = 'facility_management');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `parking_id` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility ID');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Building Engines Parking Space ID');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building ID');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `replaced_parking_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `access_control_type` SET TAGS ('dbx_business_glossary_term' = 'Parking Access Control Type');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `access_control_type` SET TAGS ('dbx_value_regex' = 'key_card|fob|license_plate_recognition|ticket|app_based|none');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ada_spaces` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `cam_eligible` SET TAGS ('dbx_business_glossary_term' = 'Common Area Maintenance (CAM) Eligible Flag');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `clearance_height_ft` SET TAGS ('dbx_business_glossary_term' = 'Parking Clearance Height (Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Condition Rating');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Parking Rate');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `daily_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Parking Record Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ev_charging_level` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Charging Level');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ev_charging_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|dc_fast_charge|mixed');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ev_charging_spaces` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Charging Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Parking Record Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Code');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Name');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Status');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|temporarily_closed|decommissioned');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Type');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'surface_lot|structured_garage|underground|covered_carport|valet_only|mixed');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Parking Rate');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `is_covered` SET TAGS ('dbx_business_glossary_term' = 'Covered Parking Flag');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `is_gated` SET TAGS ('dbx_business_glossary_term' = 'Gated Parking Facility Flag');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `is_valet_available` SET TAGS ('dbx_business_glossary_term' = 'Valet Parking Available Flag');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Parking Facility Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `leed_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Contribution Flag');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `levels_count` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Levels Count');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `monthly_rate_reserved` SET TAGS ('dbx_business_glossary_term' = 'Monthly Reserved Parking Rate');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `monthly_rate_reserved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `monthly_rate_unreserved` SET TAGS ('dbx_business_glossary_term' = 'Monthly Unreserved Parking Rate');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `monthly_rate_unreserved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Parking Facility Inspection Date');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Notes');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Operator Name');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Ownership Type');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|managed|licensed|joint_venture');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `ratio` SET TAGS ('dbx_business_glossary_term' = 'Parking Ratio (Per 1,000 Square Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `reserved_spaces` SET TAGS ('dbx_business_glossary_term' = 'Reserved Parking Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `spaces_per_level` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces Per Level');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `total_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Total Parking Area (Square Feet)');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `total_spaces` SET TAGS ('dbx_business_glossary_term' = 'Total Parking Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `unreserved_spaces` SET TAGS ('dbx_business_glossary_term' = 'Unreserved Parking Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `valet_spaces` SET TAGS ('dbx_business_glossary_term' = 'Valet Parking Spaces');
ALTER TABLE `real_estate_ecm`.`property`.`parking` ALTER COLUMN `yardi_parking_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Parking Code');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` SET TAGS ('dbx_association_edges' = 'property.asset,workforce.employee');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Asset Id');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment - Employee Id');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `fte_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'FTE Allocation Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `is_primary_assignment` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `real_estate_ecm`.`property`.`assignment` ALTER COLUMN `managed_gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Managed Gross Leasable Area');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` SET TAGS ('dbx_association_edges' = 'property.building,insurance.policy');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `building_policy_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Building Policy Coverage ID');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `blanket_group_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Group ID');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Policy Coverage - Building Id');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Building Policy Coverage - Policy Id');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `coinsurance_pct` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `construction_class` SET TAGS ('dbx_business_glossary_term' = 'Construction Class');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `coverage_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `location_number` SET TAGS ('dbx_business_glossary_term' = 'Location Number');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `occupancy_code` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Code');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `scheduled_insured_value` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Insured Value');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building_policy_coverage` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` SET TAGS ('dbx_association_edges' = 'property.space,tenant.tenant');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `property_occupancy_id` SET TAGS ('dbx_business_glossary_term' = 'property_occupancy Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `occupancy_record_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy - Property Space Id');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `tenant_id` SET TAGS ('dbx_business_glossary_term' = 'Occupancy - Profile Id');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `cam_pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'CAM Pro Rata Share');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `lease_start_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `leased_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Leased Area Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `real_estate_ecm`.`property`.`property_occupancy` ALTER COLUMN `rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Rent Per Square Foot');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` SET TAGS ('dbx_association_edges' = 'property.space,lease.agreement');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `property_demised_space_id` SET TAGS ('dbx_business_glossary_term' = 'property_demised_space Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Demised Space Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Demised Space - Agreement Id');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `property_space_id` SET TAGS ('dbx_business_glossary_term' = 'Demised Space - Property Space Id');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `base_rent_psf` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Per Square Foot');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `leased_area_sqf` SET TAGS ('dbx_business_glossary_term' = 'Leased Area Square Feet');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `pro_rata_share` SET TAGS ('dbx_business_glossary_term' = 'Pro Rata Share');
ALTER TABLE `real_estate_ecm`.`property`.`property_demised_space` ALTER COLUMN `space_status` SET TAGS ('dbx_business_glossary_term' = 'Space Status');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` SET TAGS ('dbx_association_edges' = 'property.building,compliance.regulatory_obligation');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `building_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Building Compliance Obligation ID');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Compliance Obligation - Building Id');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Building Compliance Obligation - Regulatory Obligation Id');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `applicability_status` SET TAGS ('dbx_business_glossary_term' = 'Applicability Status');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `real_estate_ecm`.`property`.`building_compliance_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` SET TAGS ('dbx_association_edges' = 'property.building,reference.sustainability_rating');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `building_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Building Certification Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Building Certification - Building Id');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `sustainability_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Building Certification - Sustainability Rating Id');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Auditor');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `certification_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Award Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `certification_score` SET TAGS ('dbx_business_glossary_term' = 'Certification Score Achieved');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `certification_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Scheme Version');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `certifying_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Reference Number');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `is_esg_reported` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Flag');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `well_certification_level` SET TAGS ('dbx_business_glossary_term' = 'WELL Building Standard Certification Level');
ALTER TABLE `real_estate_ecm`.`property`.`building_certification` ALTER COLUMN `well_certification_level` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|none');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` SET TAGS ('dbx_association_edges' = 'property.parking,lease.agreement');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Agreement Reference');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `parking_id` SET TAGS ('dbx_business_glossary_term' = 'Parking Facility Reference');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `monthly_rate` SET TAGS ('dbx_business_glossary_term' = 'Monthly Parking Rate');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `reserved_flag` SET TAGS ('dbx_business_glossary_term' = 'Reserved Space Indicator');
ALTER TABLE `real_estate_ecm`.`property`.`allocation` ALTER COLUMN `spaces_allocated` SET TAGS ('dbx_business_glossary_term' = 'Allocated Space Count');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` SET TAGS ('dbx_association_edges' = 'property.space,marketing.campaign');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `space_campaign_inclusion_id` SET TAGS ('dbx_business_glossary_term' = 'Space Campaign Inclusion ID');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Space Campaign Inclusion - Campaign Id');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `space_id` SET TAGS ('dbx_business_glossary_term' = 'Space Campaign Inclusion - Property Space Id');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `asking_rent_psf_at_inclusion` SET TAGS ('dbx_business_glossary_term' = 'Asking Rent PSF at Inclusion');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `impression_count` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `inclusion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion End Date');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `inclusion_start_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Start Date');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `lead_count` SET TAGS ('dbx_business_glossary_term' = 'Lead Count');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `space_marketing_status` SET TAGS ('dbx_business_glossary_term' = 'Space Marketing Status');
ALTER TABLE `real_estate_ecm`.`property`.`space_campaign_inclusion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` SET TAGS ('dbx_association_edges' = 'property.asset,investment.investment_deal');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `deal_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Asset Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Asset - Asset Id');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Asset - Investment Deal Pipeline Id');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `acquisition_priority` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Priority');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Percentage');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `asset_specific_conditions` SET TAGS ('dbx_business_glossary_term' = 'Asset-Specific Deal Conditions');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `dd_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `deal_role` SET TAGS ('dbx_business_glossary_term' = 'Asset Role in Deal');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `due_diligence_status` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Status for Asset in Deal');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `included_in_ic_memo` SET TAGS ('dbx_business_glossary_term' = 'Included in IC Memo Flag');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `underwritten_value_allocated` SET TAGS ('dbx_business_glossary_term' = 'Underwritten Value Allocated to Asset');
ALTER TABLE `real_estate_ecm`.`property`.`deal_asset` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` SET TAGS ('dbx_subdomain' = 'operational_relationships');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` SET TAGS ('dbx_association_edges' = 'property.asset,compliance.audit_engagement');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `asset_audit_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Audit Scope ID');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Audit Scope - Asset Id');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `audit_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Audit Scope - Audit Engagement Id');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `asset_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Risk Rating');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `auditor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Assigned Auditor');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `fieldwork_hours` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Hours');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `findings_count_for_asset` SET TAGS ('dbx_business_glossary_term' = 'Findings Count for Asset');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `included_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusion Date');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `scope_inclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusion Reason');
ALTER TABLE `real_estate_ecm`.`property`.`asset_audit_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Scope Status');
ALTER TABLE `real_estate_ecm`.`property`.`floor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`property`.`floor` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `real_estate_ecm`.`property`.`floor` ALTER COLUMN `floor_id` SET TAGS ('dbx_business_glossary_term' = 'Floor Identifier');
ALTER TABLE `real_estate_ecm`.`property`.`floor` ALTER COLUMN `parent_floor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
