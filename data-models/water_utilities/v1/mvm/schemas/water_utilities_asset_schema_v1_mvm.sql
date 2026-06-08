-- Schema for Domain: asset | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`asset` COMMENT 'Enterprise asset management domain owning the full lifecycle of physical infrastructure assets including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, and vehicles. Manages asset registry, condition assessments, criticality ratings, preventive and corrective maintenance, work order management, depreciation schedules, and CAPEX/OPEX planning. Integrates with IBM Maximo CMMS and SAP PM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`registry` (
    `registry_id` BIGINT COMMENT 'Unique surrogate primary key for each physical infrastructure asset record in the enterprise asset registry. This is the authoritative SSOT identifier that IBM Maximo Asset Management and SAP Plant Maintenance (PM) equipment master synchronize against.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Registry stores asset classification as a free‑text field; linking to the asset_class taxonomy enables consistent classification and removes the redundant string column.',
    `facility_id` BIGINT COMMENT 'Reference to the facility or site where the asset is physically located (e.g., Water Treatment Plant, Wastewater Treatment Plant, pump station, reservoir). Links the asset to its parent facility for geographic and operational grouping in GIS and CMMS.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Registry currently has no explicit location reference; adding a foreign key to location allows assets to be tied to a physical site and supports location‑based reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Physical assets (pumps, valves, hydrants) correspond to material master records for replacement procurement and spare parts identification. Water utility asset managers use this link to identify corre',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Water utilities must trace each asset back to the CIP project that created or replaced it for warranty tracking, asset capitalization closeout, and regulatory rate base filings. Role-prefix originati',
    `parent_asset_registry_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent asset in the asset hierarchy (e.g., a pump impellers parent is the pump assembly; the pump assemblys parent is the pump station). Enables parent-child asset hierarchy navigation for maintenance cost roll-up and condition assessment aggregation. Null for top-level assets.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Critical assets (SCADA systems, treatment equipment, pump stations) often have long-term service/maintenance contracts. Links enable contract compliance tracking, SLA monitoring, preventive maintenanc',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: LCRR requires individual lead service line assets to be mapped to specific regulatory requirements. SDWA asset-level compliance tracking requires direct asset-to-regulation traceability. regulatory_as',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Distribution assets (hydrants, valves, mains) serve specific service addresses. Critical for emergency response, outage notifications, GIS integration, and customer impact analysis during main breaks ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Assets must be assigned to service territories for regulatory reporting by jurisdiction, CIP prioritization, and service planning. Utilities report asset inventory and condition by territory to regula',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: Every asset in a water utility belongs to a specific water system (PWSID) for SDWA regulatory asset inventory reporting, LCRR lead service line inventories, and capital planning. Regulators require as',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: In SAP-integrated water utilities, assets are capitalized against WBS elements at CIP project closeout. This FK enables financial reporting, rate base calculations, and CIP-to-asset reconciliation req',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or construction cost of the asset in US dollars at the time of acquisition. Represents the capitalized cost basis used for depreciation calculations and fixed asset register reporting. Sourced from SAP FI/CO asset accounting module. Required for GASB Statement No. 34 infrastructure asset reporting.',
    `asset_category` STRING COMMENT 'Operational domain category indicating which business process area the asset belongs to (e.g., water_treatment for WTP equipment, wastewater_treatment for WWTP equipment, distribution for pipes and valves in the distribution network, collection for sewer infrastructure, metering for AMI/AMR devices). [ENUM-REF-CANDIDATE: water_treatment|wastewater_treatment|distribution|collection|metering|electrical|mechanical|civil|vehicle|instrumentation_control — 10 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable name or short description of the asset (e.g., Raw Water Pump No. 3, Influent Gate Valve 12-inch, Chlorine Contact Basin Filter 2). Used as the primary display label in CMMS, GIS, and reporting interfaces.',
    `asset_tag` STRING COMMENT 'Physical asset tag number (barcode, QR code, or RFID label) affixed to the asset in the field. Used by field technicians for asset identification during inspections, maintenance, and inventory audits. Corresponds to the Maximo asset tag field.',
    `asset_type` STRING COMMENT 'Sub-classification within the asset class providing more granular categorization (e.g., Centrifugal Pump, Gate Valve, Ductile Iron Pipe, AMI Smart Meter). Aligns with IBM Maximo asset type and SAP PM equipment category for maintenance planning and spare parts management.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated_capacity field. Common units include GPM (Gallons per Minute) for pumps, MGD (Million Gallons per Day) for treatment processes, gallons for storage tanks, kW for electrical equipment, and PSI (Pounds per Square Inch) for pressure vessels. [ENUM-REF-CANDIDATE: GPM|MGD|gallons|kW|kVA|HP|PSI|NTU|mg_L — 9 candidates stripped; promote to reference product]',
    `condition_assessment_date` DATE COMMENT 'Date of the most recent formal condition assessment performed on the asset. Used to determine assessment currency and schedule the next inspection cycle. Condition assessments may be visual inspections, CCTV surveys, vibration analysis, or other diagnostic methods.',
    `condition_grade` STRING COMMENT 'Standardized condition rating of the asset based on the most recent condition assessment, using a 1-5 scale where 1=Excellent/New, 2=Good, 3=Fair, 4=Poor, 5=Very Poor/Failed. Aligned with AWWA and WEF condition assessment frameworks. Drives maintenance prioritization and renewal planning.. Valid values are `1|2|3|4|5`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the enterprise asset registry. Provides audit trail for record provenance and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `criticality_rating` STRING COMMENT 'Risk-based criticality classification of the asset based on consequence of failure analysis (CoFA). critical assets have the highest consequence of failure impacting public health, regulatory compliance, or major service disruption. Used to prioritize maintenance resources, Capital Improvement Program (CIP) investments, and emergency response planning. Aligned with AWWA risk and resilience assessment methodology.. Valid values are `critical|high|medium|low`',
    `decommission_date` DATE COMMENT 'Date the asset was permanently decommissioned, retired, or removed from service. Null for active assets. Used for asset lifecycle reporting, fixed asset register reconciliation, and Capital Improvement Program (CIP) tracking. Triggers write-off in SAP FI/CO fixed asset module.',
    `diameter_mm` DECIMAL(18,2) COMMENT 'Nominal diameter of the asset in millimeters. For pipes and valves, this is the internal bore diameter. For pumps, this is the discharge diameter. Used for hydraulic capacity calculations, spare parts specification, and network modeling in Innovyze InfoWater.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the asset above mean sea level in meters. Critical for hydraulic modeling, pressure zone assignment, and gravity-fed system design. Used in Innovyze InfoWater hydraulic models and Esri ArcGIS 3D network analysis.',
    `expected_useful_life_years` STRING COMMENT 'The estimated total useful life of the asset in years as defined by engineering standards, manufacturer specifications, or utility policy. Used for depreciation calculations, Capital Improvement Program (CIP) planning, and asset renewal forecasting. Aligns with GASB Statement No. 34 infrastructure reporting requirements.',
    `functional_location` STRING COMMENT 'Hierarchical functional location code representing the physical or functional position of the asset within the utilitys infrastructure (e.g., WTP-PUMP-STATION-01-PUMP-03). Mirrors the SAP PM Functional Location (FLOC) structure and IBM Maximo Location field. Used for structured asset hierarchy navigation and maintenance cost allocation.',
    `gis_feature_code` STRING COMMENT 'The unique feature identifier for this asset in the Esri ArcGIS geographic information system. Enables spatial queries, network tracing, and hydraulic model integration via Innovyze InfoWater. Used for field crew navigation and infrastructure mapping.',
    `installation_date` DATE COMMENT 'Date the asset was physically installed and placed into service at its current location. Used as the baseline for age calculations, depreciation schedules, warranty period tracking, and remaining useful life (RUL) estimation. Sourced from IBM Maximo installation date field.',
    `is_lead_service_line` BOOLEAN COMMENT 'Indicates whether this asset is a lead service line or contains lead components. Critical for compliance with the EPA Lead and Copper Rule Revisions (LCRR) which requires utilities to inventory and replace lead service lines. True = confirmed lead service line; False = non-lead or unknown.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recently completed maintenance activity (preventive or corrective) performed on this asset. Used to calculate maintenance intervals, identify overdue assets, and support compliance reporting for regulatory-mandated maintenance activities.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record in the enterprise asset registry. Used for change tracking, data synchronization with IBM Maximo and SAP PM, and audit trail maintenance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset location in decimal degrees (WGS84 datum). Used for GIS mapping, field crew navigation, spatial analysis, and hydraulic network modeling in Innovyze InfoWater. Sourced from Esri ArcGIS asset layer.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset location in decimal degrees (WGS84 datum). Used for GIS mapping, field crew navigation, spatial analysis, and hydraulic network modeling in Innovyze InfoWater. Sourced from Esri ArcGIS asset layer.',
    `maintenance_strategy` STRING COMMENT 'The primary maintenance approach applied to this asset as defined in the Computerized Maintenance Management System (CMMS). preventive indicates time-based scheduled maintenance; predictive indicates condition-monitoring-based maintenance; condition_based indicates maintenance triggered by condition thresholds; run_to_failure is applied to non-critical, easily replaceable assets.. Valid values are `preventive|predictive|corrective|run_to_failure|condition_based`',
    `manufacture_date` DATE COMMENT 'Date the asset was manufactured by the OEM. May differ from installation date for assets stored in inventory before deployment. Used for age-based condition assessment and manufacturer warranty calculations.',
    `maximo_asset_num` STRING COMMENT 'The asset number as assigned and maintained in IBM Maximo Asset Management (CMMS). This is the operational cross-reference key used by maintenance crews and work order management. Must be unique within the Maximo instance.',
    `next_maintenance_date` DATE COMMENT 'Date on which the next scheduled preventive maintenance activity is due for this asset. Derived from the PM schedule and last maintenance date. Used for maintenance planning, resource scheduling, and compliance tracking in IBM Maximo.',
    `operational_status` STRING COMMENT 'Current operational lifecycle state of the asset. in_service indicates the asset is active and performing its intended function. standby indicates the asset is available but not currently operating. out_of_service indicates the asset is temporarily removed from service for maintenance or repair. decommissioned indicates permanent retirement. Drives maintenance scheduling and regulatory reporting.. Valid values are `in_service|out_of_service|standby|decommissioned|under_construction|abandoned`',
    `pipe_material` STRING COMMENT 'Material composition of the asset (e.g., Ductile Iron, PVC, HDPE, Cast Iron, Concrete, Stainless Steel, Copper). Critical for corrosion risk assessment, Lead and Copper Rule Revisions (LCRR) compliance, Cured-in-Place Pipe (CIPP) rehabilitation planning, and remaining useful life estimation. Applicable primarily to pipe and fitting assets.',
    `power_rating_kw` DECIMAL(18,2) COMMENT 'Nameplate power rating of the asset in kilowatts (kW). Applicable to pumps, blowers, motors, generators, and other electrical equipment. Used for energy consumption analysis, Variable Frequency Drive (VFD) sizing, electrical load planning, and OPEX budgeting.',
    `pressure_zone` STRING COMMENT 'The hydraulic pressure zone or District Metered Area (DMA) in which the asset is located. Used for pressure management, Non-Revenue Water (NRW) analysis, and distribution network operations. Aligns with Innovyze InfoWater zone definitions and GIS pressure zone polygons.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'The manufacturer-rated operational capacity of the asset expressed in the appropriate unit of measure (see capacity_unit field). For pumps: Gallons per Minute (GPM); for treatment units: Million Gallons per Day (MGD); for tanks: gallons. Used for capacity planning, hydraulic modeling, and performance benchmarking.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Current estimated cost to replace the asset with a new equivalent unit in US dollars. Updated periodically based on market pricing and engineering estimates. Used for Capital Improvement Program (CIP) budgeting, insurance valuation, and risk-based asset management decision-making.',
    `sap_equipment_num` STRING COMMENT 'The equipment number assigned in SAP Plant Maintenance (PM) module. Used for integration with SAP FI/CO for depreciation, CAPEX/OPEX tracking, and maintenance cost postings. Enables bidirectional synchronization between SAP PM and the asset registry.',
    `scada_tag` STRING COMMENT 'The Supervisory Control and Data Acquisition (SCADA) tag name used to identify this assets data point(s) in the OSIsoft PI Historian system. Enables linkage between the physical asset registry and real-time operational data streams for performance monitoring, alarm management, and predictive maintenance analytics.',
    `serial_num` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Used for warranty claims, recall tracking, and precise asset identification when multiple identical units exist. Sourced from IBM Maximo serial number field.',
    `warranty_expiry_date` DATE COMMENT 'Date on which the manufacturers warranty for the asset expires. Used to trigger warranty claim processes before expiry and to transition maintenance responsibility from warranty to O&M budget. Sourced from IBM Maximo warranty end date.',
    CONSTRAINT pk_registry PRIMARY KEY(`registry_id`)
) COMMENT 'Master record for every physical infrastructure asset owned or operated by the utility, including WTP/WWTP equipment, pipes, pumps, valves, electrical systems, meters, and vehicles. Captures asset identity, classification, installation details, location (GIS coordinates), manufacturer, model, serial number, asset tag, parent-child hierarchy, operational status, and lifecycle dates. This is the authoritative SSOT for all physical assets — the IBM Maximo asset master and SAP PM equipment master both synchronize to this record.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`asset_class` (
    `asset_class_id` BIGINT COMMENT 'Unique surrogate identifier for the asset class record in the enterprise asset management system. Primary key for the asset_class reference taxonomy. [ROLE: REFERENCE_LOOKUP — this entity is a reference taxonomy/classification table defining the hierarchy of utility asset types; per-role minimums are exempt, but MASTER_RESOURCE categories are applied for completeness given the entity carries rich business metadata beyond a simple code list.]',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: asset_class carries a plain gl_account_code attribute (denormalized). Asset classes define default GL accounts for depreciation and capital posting under GASB 34. Linking to finance.general_ledger ena',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Asset classes in water utilities are defined by regulatory standards (e.g., AWIA asset categories, LCRR pipe material classes). Class-level regulatory requirement linkage drives inspection frequency, ',
    `ami_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are part of the AMI/AMR metering infrastructure managed via the Sensus FlexNet AMI Platform. True for smart meters and communication endpoints; False for all other asset classes.',
    `asset_domain` STRING COMMENT 'Operational domain to which this asset class primarily belongs within the utility (e.g., Water Treatment, Water Distribution, Wastewater Collection, Wastewater Treatment, Metering, Fleet, Facilities, Cross-Domain). Drives domain-specific maintenance strategies and regulatory reporting alignment. [ENUM-REF-CANDIDATE: Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Fleet|Facilities|Cross-Domain — promote to reference product]',
    `capex_threshold_usd` DECIMAL(18,2) COMMENT 'Minimum acquisition or renewal cost in USD above which expenditures on assets of this class are capitalized as CAPEX rather than expensed as OPEX. Aligned with GAAP/GASB capitalization policies and SAP FI/CO asset accounting rules.',
    `cip_program_category` STRING COMMENT 'CIP program category under which capital renewal projects for assets of this class are budgeted and tracked. Aligns with the utilitys multi-year CIP planning structure in SAP PS and financial reporting to the Public Utilities Commission. [ENUM-REF-CANDIDATE: Water Supply|Water Treatment|Water Distribution|Wastewater Collection|Wastewater Treatment|Metering|Facilities|Fleet|Cross-Program — promote to reference product]',
    `class_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the asset class within the enterprise taxonomy (e.g., MECH-PUMP, ELEC-TRANS, CIVIL-PIPE). Used as the externally-known business identifier in IBM Maximo, SAP PM, and GIS integrations.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `class_description` STRING COMMENT 'Detailed narrative description of the asset class, including its functional role within water or wastewater operations, typical installation context, and distinguishing characteristics from adjacent classes.',
    `class_name` STRING COMMENT 'Human-readable name of the asset class (e.g., Centrifugal Pump, Distribution Main Pipe, UV Disinfection Unit). Used in reports, work orders, and CAPEX planning documents.',
    `class_status` STRING COMMENT 'Current lifecycle status of the asset class record within the reference taxonomy. Active classes are available for new asset registrations; Deprecated classes are retained for historical assets but cannot be assigned to new assets.. Valid values are `Active|Inactive|Deprecated|Under Review`',
    `condition_assessment_method` STRING COMMENT 'Default method used to assess the physical condition of assets in this class. CIPP and pipe assets typically use CCTV; rotating equipment uses vibration analysis; distribution mains may use acoustic leak detection. Drives field inspection work order types in Maximo. [ENUM-REF-CANDIDATE: Visual Inspection|CCTV|Acoustic Leak Detection|Vibration Analysis|Ultrasonic Testing|Hydraulic Testing|SCADA Monitoring|Not Applicable — promote to reference product]',
    `consequence_of_failure` STRING COMMENT 'Primary category of consequence if assets of this class fail. Drives risk-based maintenance prioritization and emergency response planning. [ENUM-REF-CANDIDATE: Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational — promote to reference product]. Valid values are `Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the enterprise data platform. Supports audit trail and data lineage requirements.',
    `criticality_tier` STRING COMMENT 'Default criticality tier classification for assets of this class based on consequence of failure analysis. Critical assets (e.g., primary WTP pumps, transmission mains) receive highest maintenance priority and fastest response SLAs.. Valid values are `Critical|High|Medium|Low`',
    `criticality_weight` DECIMAL(18,2) COMMENT 'Numeric weighting factor (typically 0.00–10.00) applied to assets of this class during criticality assessment scoring. Higher values indicate greater consequence of failure on service delivery, public health, or regulatory compliance. Used in risk-based asset prioritization per ISO 55001.',
    `depreciation_method` STRING COMMENT 'Default accounting depreciation method applied to assets of this class for financial reporting purposes. Straight-Line is most common for utility infrastructure. Aligned with GAAP/GASB requirements for municipal utility financial statements. [ENUM-REF-CANDIDATE: Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery — promote to reference product]. Valid values are `Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery`',
    `effective_date` DATE COMMENT 'Date from which this asset class definition became effective and available for use in asset registrations. Supports temporal validity tracking of the reference taxonomy.',
    `environmental_risk_flag` BOOLEAN COMMENT 'Indicates whether failure of assets in this class poses a direct environmental risk requiring regulatory notification (e.g., SSO, CSO, chemical spill, NPDES permit exceedance). True triggers mandatory environmental incident reporting workflows.',
    `gis_feature_class` STRING COMMENT 'Corresponding feature class name in Esri ArcGIS geodatabase for assets of this class (e.g., wDistributionMain, wValve, wPump). Enables spatial analysis, network modeling in Innovyze InfoWater, and GIS-CMMS integration for field crew dispatch.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this class within the classification hierarchy (1 = top-level category, 2 = sub-category, 3 = class, 4 = sub-class). Drives roll-up aggregation logic in CAPEX planning and maintenance reporting.',
    `inspection_frequency_days` STRING COMMENT 'Default interval in calendar days between mandatory regulatory or condition inspections for assets of this class. Distinct from PM frequency — this is driven by regulatory compliance requirements (e.g., EPA, state primacy agency mandates) rather than maintenance strategy.',
    `iso_55001_aligned` BOOLEAN COMMENT 'Indicates whether the maintenance strategy, criticality assessment, and lifecycle management approach for this asset class have been formally aligned with ISO 55001 Asset Management System requirements. Used for ISO certification audit evidence.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was most recently modified in the enterprise data platform. Used for change tracking, data synchronization with source systems (Maximo, SAP), and audit compliance.',
    `lcrr_applicable` BOOLEAN COMMENT 'Indicates whether assets of this class are subject to EPA Lead and Copper Rule Revisions (LCRR) compliance requirements, such as lead service line inventory and replacement tracking. Applicable to service lines, connectors, and plumbing components.',
    `maintenance_strategy` STRING COMMENT 'Default O&M maintenance strategy applied to assets of this class in IBM Maximo CMMS. Drives automatic PM schedule generation. Preventive and Condition-Based strategies are typical for critical water infrastructure; Run-to-Failure may apply to low-criticality ancillary assets.. Valid values are `Preventive|Predictive|Corrective|Condition-Based|Run-to-Failure`',
    `material_standard` STRING COMMENT 'Default material specification or construction standard applicable to assets of this class (e.g., AWWA C900 PVC, AWWA C200 Steel, ASTM A536 Ductile Iron, HDPE ASTM D3035). Used in procurement specifications and asset registry for infrastructure renewal planning.',
    `maximo_class_code` STRING COMMENT 'Corresponding asset class identifier in IBM Maximo Asset Management CMMS. Used for bidirectional synchronization between the Silver Layer lakehouse and Maximo for work order generation, PM scheduling, and asset lifecycle management.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `mean_time_between_failures_days` DECIMAL(18,2) COMMENT 'Industry benchmark mean time between failures in days for assets of this class, used as a baseline for reliability-centered maintenance planning and failure probability modeling. Sourced from AWWA reliability benchmarks and historical Maximo work order data.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Industry benchmark mean time to repair in hours for assets of this class, used for SLA setting, crew resource planning, and service restoration time estimation. Sourced from AWWA benchmarks and historical Maximo corrective work order durations.',
    `number_sap` STRING COMMENT 'Corresponding asset class number in SAP FI/CO Asset Accounting module (transaction AS02/AS03). Enables direct cross-reference between the enterprise data lakehouse and the SAP ERP system of record for financial reconciliation.. Valid values are `^[0-9]{4,8}$`',
    `pm_frequency_days` STRING COMMENT 'Default interval in calendar days between scheduled preventive maintenance activities for assets of this class. Used by IBM Maximo PM scheduling engine to auto-generate work orders. Overridable at the individual asset level.',
    `primary_category` STRING COMMENT 'Top-level classification grouping for the asset class aligned with standard utility asset taxonomy: Mechanical (pumps, blowers, mixers), Electrical (transformers, switchgear), Civil (pipes, structures, tanks), Instrumentation (sensors, meters, SCADA RTUs), Vehicle (fleet), Information Technology, or Other. [ENUM-REF-CANDIDATE: Mechanical|Electrical|Civil|Instrumentation|Vehicle|Information Technology|Other — promote to reference product]',
    `renewal_strategy` STRING COMMENT 'Default end-of-life renewal strategy for assets of this class used in CIP planning. CIPP (Cured-in-Place Pipe) and trenchless methods are common for buried pipe rehabilitation; rotating equipment typically follows Replace-in-Kind or Upgrade strategies.. Valid values are `Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission`',
    `retirement_date` DATE COMMENT 'Date on which this asset class was retired or deprecated from the active taxonomy. Null for currently active classes. Retained for historical asset records that were registered under this class prior to retirement.',
    `safety_classification` STRING COMMENT 'Primary safety hazard classification for work activities on assets of this class. Drives OSHA-compliant safety permit requirements (e.g., confined space entry permits, lockout/tagout procedures) when generating work orders in Maximo.. Valid values are `Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None`',
    `salvage_value_pct` DECIMAL(18,2) COMMENT 'Default residual/salvage value expressed as a percentage of original acquisition cost at end of useful life for assets in this class. Used in depreciation calculations and asset disposal planning within SAP FI/CO.',
    `scada_monitored` BOOLEAN COMMENT 'Indicates whether assets of this class are typically monitored via SCADA (Supervisory Control and Data Acquisition) systems integrated with OSIsoft PI Historian. True for pumps, valves, flow meters, and treatment equipment; False for passive civil assets such as buried pipes.',
    `size_unit_of_measure` STRING COMMENT 'Standard unit of measure used to express the principal sizing attribute for assets of this class (e.g., inches for pipe diameter, HP for pump motor horsepower, kVA for transformer capacity, GPM for flow capacity). Ensures consistent sizing data entry across the asset registry. [ENUM-REF-CANDIDATE: inches|mm|feet|meters|kVA|HP|kW|GPM|MGD|gallons|cubic feet — promote to reference product]',
    `spare_parts_required` BOOLEAN COMMENT 'Indicates whether assets of this class typically require dedicated spare parts inventory to be maintained in the storeroom (SAP MM / Maximo Inventory). True for critical rotating equipment and instrumentation; False for passive civil assets.',
    `useful_life_years` STRING COMMENT 'Default expected useful life in years for assets belonging to this class, used as the baseline for depreciation schedules, CAPEX renewal planning, and CIP prioritization. Can be overridden at the individual asset level.',
    `work_order_type_default` STRING COMMENT 'Default work order type generated in IBM Maximo for assets of this class when a maintenance event is triggered. Drives labor planning, cost coding, and CAPEX vs OPEX classification of maintenance expenditures.. Valid values are `Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation`',
    CONSTRAINT pk_asset_class PRIMARY KEY(`asset_class_id`)
) COMMENT 'Reference taxonomy defining the classification hierarchy for utility assets (e.g., Mechanical, Electrical, Civil, Instrumentation, Vehicle). Each class carries default useful life, depreciation method, maintenance strategy, criticality weighting rules, and applicable regulatory standards. Used to drive preventive maintenance scheduling, CAPEX planning, and ISO 55001 asset management framework alignment.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the asset location record. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the top-level facility (WTP, WWTP, pump station) where this location resides.',
    `parent_location_id` BIGINT COMMENT 'Reference to the parent location in the hierarchical location structure (e.g., a rooms parent is a floor, a floors parent is a building).',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Physical locations fall within service territories, driving regulatory jurisdiction assignment, crew dispatch routing, and territory-level infrastructure reporting. The existing plain-text service_ter',
    `access_restrictions` STRING COMMENT 'Description of physical or security access restrictions for the location (e.g., Restricted - Badge Required, Public Access, Confined Space).',
    `address_line_1` STRING COMMENT 'Primary street address of the location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, unit, building number). Organizational contact data classified as confidential.',
    `area_square_feet` DECIMAL(18,2) COMMENT 'Physical area of the location in square feet, used for space planning and asset density analysis.',
    `capacity_rating` DECIMAL(18,2) COMMENT 'Rated capacity of the location for asset storage or operational throughput (e.g., MGD for treatment facilities, gallons for storage tanks).',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity rating (e.g., Million Gallons per Day (MGD), Gallons per Minute (GPM), gallons, cubic meters).. Valid values are `mgd|gpm|gallons|cubic_meters|units`',
    `city` STRING COMMENT 'City or municipality where the location is situated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the system.',
    `dma_zone` STRING COMMENT 'District Metered Area zone identifier for water distribution network segmentation and Non-Revenue Water (NRW) analysis.',
    `effective_end_date` DATE COMMENT 'Date when the location was decommissioned or removed from active service (null for active locations).',
    `effective_start_date` DATE COMMENT 'Date when the location became operational or was added to the asset registry.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet, used for hydraulic modeling and pressure zone analysis.',
    `environmental_conditions` STRING COMMENT 'Description of environmental conditions at the location (e.g., Indoor Climate Controlled, Outdoor Exposed, Wet Environment, Corrosive Atmosphere).',
    `floor_level` STRING COMMENT 'Floor or level number within a building (e.g., 1 for ground floor, 2 for second floor, -1 for basement).',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier in the Esri ArcGIS system for spatial data integration and network topology analysis.',
    `hazard_classification` STRING COMMENT 'Safety hazard classification for the location (e.g., Confined Space, High Voltage, Chemical Storage, None).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was last updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for GIS integration with Esri ArcGIS.',
    `location_code` STRING COMMENT 'Business identifier code for the location, used for operational reference and integration with IBM Maximo CMMS and SAP PM systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `location_description` STRING COMMENT 'Detailed description of the location, including physical characteristics, purpose, and operational context.',
    `location_name` STRING COMMENT 'Human-readable name of the asset location (e.g., Main Street Pump Station, North WTP Filter Building).',
    `location_status` STRING COMMENT 'Current operational status of the location in its lifecycle.. Valid values are `active|inactive|under_construction|decommissioned|temporary`',
    `location_type` STRING COMMENT 'Classification of the location type within the asset hierarchy.. Valid values are `facility|building|floor|room|outdoor_site|storage_yard`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for GIS integration with Esri ArcGIS.',
    `maximo_location_code` STRING COMMENT 'Location identifier in IBM Maximo CMMS for work order management and maintenance routing integration.',
    `notes` STRING COMMENT 'Additional notes or comments about the location for operational reference and maintenance planning.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the location. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `pressure_zone` STRING COMMENT 'Pressure zone designation for hydraulic modeling and distribution network operations, typically defined by elevation and Pressure Reducing Valve (PRV) boundaries.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory jurisdiction or primacy agency responsible for oversight (e.g., state EPA, local health department).',
    `room_number` STRING COMMENT 'Room or space identifier within a floor or building (e.g., Room 101, Electrical Vault A).',
    `sap_functional_location` STRING COMMENT 'SAP PM functional location code for asset hierarchy and maintenance planning integration.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the location is integrated with SCADA systems (OSIsoft PI Historian) for real-time monitoring and control.',
    `spatial_reference_code` STRING COMMENT 'Coordinate system reference identifier (EPSG code) used for GIS spatial data (e.g., EPSG:4326 for WGS 84).',
    `state_province` STRING COMMENT 'Two-letter state or province code (e.g., CA, TX, NY).. Valid values are `^[A-Z]{2}$`',
    `watershed` STRING COMMENT 'Watershed or drainage basin identifier for regulatory reporting and environmental compliance under the Clean Water Act (CWA).',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Hierarchical location registry defining where assets are physically installed or stored — from service territory down to facility, building, floor, room, and GIS coordinate. Supports Esri ArcGIS integration with spatial reference data (latitude, longitude, elevation, DMA zone, pressure zone, watershed). Enables location-based maintenance routing, network topology analysis, and regulatory reporting by geographic jurisdiction.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`condition_assessment` (
    `condition_assessment_id` BIGINT COMMENT 'Unique identifier for the condition assessment record. Primary key.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.analytical_result. Business justification: Condition assessments for pipes, coatings, and linings often reference supporting lab analysis results (corrosion testing, material integrity tests). Real business need: linking physical asset conditi',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Condition assessments are the primary driver of CIP project initiation in water utilities. Regulators and rate case filings require traceability from poor condition grades to capital investment decisi',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: LCRR mandates condition assessments of lead service lines tied to lead contaminant monitoring. Asbestos cement pipe assessments reference asbestos contaminant limits. Water utilities perform contamina',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: GASB 42 requires impairment testing when events or changes in circumstances indicate a capital assets service utility has declined significantly. Linking condition_assessment to fixed_asset enables t',
    `location_id` BIGINT COMMENT 'Reference to the asset location in the Geographic Information System (GIS), enabling spatial analysis and mapping of condition assessment results.',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: A condition assessment is the formal output produced by an inspection event. Linking condition_assessment to the triggering inspection_event establishes the provenance chain: inspection performed → as',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Condition assessments in water utilities are frequently scheduled activities driven by PM schedules (e.g., annual CCTV inspections, biennial structural assessments). Linking condition_assessment to th',
    `registry_id` BIGINT COMMENT 'Reference to the infrastructure asset being assessed (pipe, pump, valve, treatment equipment, vehicle, etc.).',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: LCRR, AWIA, and SDWA mandate specific condition assessment programs for asset classes. Water utilities must trace each condition assessment to the regulatory requirement driving it for compliance repo',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this condition assessment was performed, if applicable.',
    `approved_date` DATE COMMENT 'Date when the assessment was formally approved by management.',
    `assessment_date` DATE COMMENT 'The date on which the condition assessment was performed in the field.',
    `assessment_interval_months` STRING COMMENT 'Standard inspection frequency interval in months for this asset type and condition grade.',
    `assessment_method` STRING COMMENT 'The inspection or testing method used to assess asset condition. Common methods include visual inspection, Closed-Circuit Television (CCTV) for pipes, acoustic leak detection, vibration analysis for rotating equipment, ultrasonic thickness measurement for corrosion, infrared thermography for electrical systems, and various hydraulic testing methods. [ENUM-REF-CANDIDATE: visual|cctv|acoustic|vibration_analysis|ultrasonic_thickness|infrared_thermography|dye_testing|smoke_testing|pressure_testing|flow_testing|electrical_testing|corrosion_survey — 12 candidates stripped; promote to reference product]',
    `assessment_number` STRING COMMENT 'Business identifier for the condition assessment, typically generated by the Computerized Maintenance Management System (CMMS) or inspection system.',
    `assessment_status` STRING COMMENT 'Current workflow status of the condition assessment record: scheduled, in progress, completed (field work done), reviewed (technical review complete), approved (management sign-off), or cancelled.. Valid values are `scheduled|in_progress|completed|reviewed|approved|cancelled`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the condition assessment was completed, including time zone information.',
    `assessment_type` STRING COMMENT 'Classification of the assessment purpose: routine scheduled inspection, preventive maintenance assessment, reactive inspection following an incident, condition-based monitoring, regulatory compliance inspection, pre-failure investigation, post-repair verification, or new asset commissioning. [ENUM-REF-CANDIDATE: routine|preventive|reactive|condition_based|regulatory|pre_failure|post_repair|commissioning — 8 candidates stripped; promote to reference product]',
    `condition_grade` STRING COMMENT 'Standardized condition rating on a 1-5 scale per American Water Works Association (AWWA) and Water Research Foundation (WRF) standards, where 1 = Excellent/New, 2 = Good/Minor Defects, 3 = Fair/Moderate Defects, 4 = Poor/Significant Defects, 5 = Very Poor/Critical/Imminent Failure.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this condition assessment record was first created in the Computerized Maintenance Management System (CMMS).',
    `critical_defect_count` STRING COMMENT 'Number of critical or high-severity defects requiring immediate attention or corrective action.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the asset based on consequence of failure analysis, considering service impact, public health risk, environmental impact, and financial exposure.. Valid values are `critical|high|medium|low`',
    `defect_count` STRING COMMENT 'Total number of defects, anomalies, or non-conformances identified during the condition assessment.',
    `defect_description` STRING COMMENT 'Detailed narrative description of defects, damage, deterioration, or performance issues observed during the assessment.',
    `environmental_conditions` STRING COMMENT 'Environmental factors that may affect assessment results or asset condition (e.g., soil conditions, groundwater level, chemical exposure, temperature extremes).',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Preliminary cost estimate for recommended repair or rehabilitation work, used for Capital Expenditure (CAPEX) and Operating Expenditure (OPEX) planning.',
    `estimated_replacement_cost` DECIMAL(18,2) COMMENT 'Estimated cost to fully replace the asset with equivalent new equipment or infrastructure.',
    `failure_probability` DECIMAL(18,2) COMMENT 'Statistical probability (0.0000 to 1.0000) of asset failure within the next planning period, calculated from condition data, age, and historical failure rates.',
    `inspection_equipment_used` STRING COMMENT 'Description of specialized equipment, instruments, or tools used during the assessment (e.g., CCTV crawler, ultrasonic thickness gauge, vibration analyzer, acoustic leak detector).',
    `inspector_certification` STRING COMMENT 'Professional certifications held by the inspector relevant to the assessment method (e.g., NASSCO PACP/MACP/LACP for pipeline inspection, ASNT Level II for ultrasonic testing, thermography certification).',
    `inspector_name` STRING COMMENT 'Full name of the inspector or technician who conducted the assessment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the assessment location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the assessment location.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this condition assessment record was last updated.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next condition assessment based on asset criticality, condition grade, and inspection frequency requirements.',
    `notes` STRING COMMENT 'Additional observations, comments, or contextual information recorded by the inspector during the assessment.',
    `performance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100 scale) representing the operational performance and efficiency of the asset relative to design specifications.',
    `recommended_action` STRING COMMENT 'Recommended intervention strategy based on assessment findings: continue monitoring, schedule repair, plan rehabilitation, schedule replacement, no action required, or emergency repair needed.. Valid values are `monitor|repair|rehabilitate|replace|no_action|emergency_repair`',
    `recommended_action_priority` STRING COMMENT 'Priority level for the recommended intervention: immediate (0-30 days), urgent (1-6 months), high (6-12 months), medium (1-3 years), low (3+ years).. Valid values are `immediate|urgent|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this assessment was performed to satisfy regulatory inspection requirements from Environmental Protection Agency (EPA), state primacy agencies, or other governing bodies.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated number of years the asset can continue to operate before requiring major rehabilitation or replacement, based on current condition and deterioration rate.',
    `reviewed_date` DATE COMMENT 'Date when the assessment was reviewed and validated by a supervisor or subject matter expert.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated as the product of failure probability and consequence of failure, used to prioritize asset renewal and Capital Improvement Program (CIP) planning.',
    `structural_integrity_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100 scale) representing the structural soundness of the asset based on inspection findings. Higher scores indicate better structural condition.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of assessment, relevant for outdoor inspections and certain testing methods.',
    CONSTRAINT pk_condition_assessment PRIMARY KEY(`condition_assessment_id`)
) COMMENT 'Records the results of all formal assessments and inspections performed on infrastructure assets, encompassing both scored condition evaluations (condition grade 1-5 per AWWA/WRF standards, structural integrity score, remaining useful life estimate, failure probability) and regulatory/compliance inspections (EPA, state primacy agency, OSHA requirements). Captures assessment date, type (condition-scoring, regulatory-compliance, routine-operational, post-incident, pre-commissioning), method (visual, CCTV, acoustic, vibration analysis, ultrasonic thickness, leak detection), inspector identity and certification, checklist/protocol used, pass/fail outcome, deficiencies identified, corrective action required flag, recommended intervention, and regulatory permit reference. A single unified record for any event where an asset is formally evaluated — whether for condition scoring, compliance verification, or operational readiness. Drives asset renewal prioritization, CIP planning, regulatory inspection compliance tracking, and OSHA safety audit evidence. Integrates with IBM Maximo inspection records and supports EPA/state primacy agency reporting requirements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`criticality_rating` (
    `criticality_rating_id` BIGINT COMMENT 'Unique identifier for the criticality rating record. Primary key for the criticality rating entity.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset being evaluated for criticality. Links to the asset registry in IBM Maximo CMMS.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: LCRR and AWIA require risk-based asset criticality ratings tied to specific regulatory mandates. Utilities must demonstrate that criticality methodology aligns with regulatory consequence criteria. Di',
    `approval_date` DATE COMMENT 'Date when this criticality rating was formally approved for operational use. Supports audit trail and governance compliance.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role that approved this criticality rating for operational use. Supports governance and accountability for asset management decisions.',
    `assessment_date` DATE COMMENT 'The date when the criticality assessment was performed. Distinct from the effective date; tracks when the analysis was conducted.',
    `assessment_performed_by` STRING COMMENT 'Name or identifier of the person, team, or system that performed the criticality assessment. Supports audit trail and accountability for rating decisions.',
    `capital_renewal_priority_rank` STRING COMMENT 'Relative priority ranking for capital renewal or replacement within the asset portfolio. Lower numbers indicate higher priority. Derived from criticality tier and overall risk score.',
    `cip_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this asset is eligible for inclusion in the Capital Improvement Program based on its criticality rating and condition. True if eligible for CIP funding consideration.',
    `consequence_of_failure_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the business, operational, safety, environmental, and regulatory impact if the asset fails. Typically scaled 1-100 or 1-10 depending on methodology.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this criticality rating record was first created in the system. Supports data lineage and audit trail requirements.',
    `criticality_tier` STRING COMMENT 'Categorical classification of asset criticality derived from the overall risk score. Determines maintenance frequency, inspection intervals, and capital renewal priority.. Valid values are `Critical|High|Medium|Low`',
    `customer_impact_count` STRING COMMENT 'Estimated number of customers or service connections that would be affected by failure of this asset. Used to quantify consequence of failure for distribution and collection system assets.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would result in environmental harm such as discharge of untreated wastewater, contamination of water sources, or SSO/CSO events. True if environmental impact is likely.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial consequence of asset failure including emergency repair costs, lost revenue, regulatory fines, and liability claims. Expressed in USD.',
    `inspection_frequency_days` STRING COMMENT 'Recommended interval in days between routine inspections based on the criticality tier. Critical assets require more frequent inspection than low-criticality assets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this criticality rating record was last updated. Supports change tracking and audit trail requirements.',
    `likelihood_of_failure_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the probability of asset failure based on age, condition, maintenance history, and operating environment. Typically scaled 1-100 or 1-10 depending on methodology.',
    `methodology_version` STRING COMMENT 'Version identifier of the criticality assessment methodology used to calculate this rating. Enables tracking of methodology changes over time and ensures consistent application across asset portfolio.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next criticality reassessment. Critical assets typically require more frequent review cycles than low-criticality assets.',
    `notes` STRING COMMENT 'Free-text notes documenting special considerations, assumptions, or qualitative factors that influenced the criticality rating. Supports transparency and knowledge transfer.',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score calculated from Consequence of Failure and Likelihood of Failure scores. Typically computed as CoF × LoF. Used to rank assets for maintenance and capital investment prioritization.',
    `preventive_maintenance_frequency_days` STRING COMMENT 'Recommended interval in days between preventive maintenance activities based on the criticality tier. Critical assets require more frequent PM than low-criticality assets.',
    `public_health_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would pose a direct threat to public health through loss of water supply, water quality degradation, or exposure to contaminants. True if public health risk exists.',
    `rating_effective_date` DATE COMMENT 'The date from which this criticality rating becomes effective and is used for maintenance prioritization and capital planning decisions.',
    `rating_expiration_date` DATE COMMENT 'The date when this criticality rating expires and must be reassessed. Nullable for ratings without a defined review cycle.',
    `rating_status` STRING COMMENT 'Current lifecycle status of the criticality rating record. Active ratings are used for operational decisions; superseded ratings are retained for historical analysis.. Valid values are `Active|Superseded|Under Review|Pending Approval`',
    `redundancy_available_flag` BOOLEAN COMMENT 'Indicates whether backup or redundant assets are available to maintain service if this asset fails. True if redundancy exists, False if asset is a single point of failure.',
    `regulatory_consequence_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would result in regulatory non-compliance, permit violations, or mandatory reporting under SDWA, CWA, or NPDES. True if regulatory consequences exist.',
    `review_frequency_months` STRING COMMENT 'Standard interval in months between criticality reassessments for this asset. Typically shorter for critical assets and longer for low-criticality assets.',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether failure of this asset would create safety hazards for employees, contractors, or the public (e.g., chemical release, electrical hazard, structural collapse). True if safety risk exists.',
    `service_disruption_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that service would be disrupted if this asset fails, accounting for repair time, parts availability, and system restoration procedures.',
    CONSTRAINT pk_criticality_rating PRIMARY KEY(`criticality_rating_id`)
) COMMENT 'Stores the criticality evaluation for each asset, capturing consequence of failure (CoF) score, likelihood of failure (LoF) score, overall risk score, criticality tier (Critical/High/Medium/Low), redundancy availability, customer impact count, regulatory consequence flag, and the methodology version used. Criticality ratings drive maintenance prioritization, inspection frequency, and capital renewal sequencing per ISO 55001 and AWWA asset management best practices.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Work orders for new connections, meter sets, and service changes are executed under a specific service agreement. Linking work_order to agreement enables SLA breach tracking, customer notification, an',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Work orders performed for specific customer accounts (service calls, meter work, customer-requested repairs) require account linkage. Required for customer work history tracking, account-specific main',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: During CIP execution, utility crews generate work orders for construction support, tie-ins, and commissioning tasks charged to capital projects. This FK enables internal labor and material costs to be',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Work orders for permitted activities (NPDES-permitted discharge operations, construction under operating permits) must reference the applicable compliance permit. This is distinct from enforcement-dri',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work orders charge costs to departmental cost centers (treatment plants, pump stations, distribution zones) for budget tracking, variance analysis, and operational cost allocation required for utility',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Water utilities operate under GASB fund accounting — capital work orders draw from capital improvement funds while O&M work orders draw from operating funds. Linking work_order to finance.fund enables',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Work orders post labor, material, and overhead costs to specific GL accounts for financial reporting, rate case cost-of-service studies, and GASB compliance. Essential for integrating maintenance cost',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Work orders for customer-requested services (meter replacement, service line repair, reconnection after disconnection) generate billable charges appearing on invoices. Required for billable work order',
    `job_plan_id` BIGINT COMMENT 'Foreign key linking to asset.job_plan. Business justification: Work orders frequently execute standardized job plans that define task sequences, labor requirements, materials, and safety procedures. This is a standard CMMS pattern (IBM Maximo, SAP PM). Job plan p',
    `location_id` BIGINT COMMENT 'Reference to the functional location or site where the work is performed (Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pump station, District Metered Area (DMA)).',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule or route that generated this work order, if applicable.',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Work orders for meter sets, service line repairs, and backflow tests are executed at specific service points. Linking work_order to service.point enables complete service history per point, customer i',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Work orders for meter replacements, service line repairs, and backflow preventer installations are executed at specific premises. Field dispatch, permit tracking, and premise-level asset history requi',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (pipe, pump, valve, treatment equipment, vehicle) that is the subject of this work order.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Capital work orders and major repairs have associated POs for materials/equipment procurement. Enables three-way match (work order-PO-invoice), project cost reconciliation, budget tracking, and financ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory-mandated work orders (LCRR lead service line replacements, mandated flushing programs, SDWA monitoring) must be traceable to the specific regulatory requirement. This supports compliance pr',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Work orders require service address for crew dispatch, customer contact, access instructions, and completion documentation. Essential for field operations, customer communication, and GIS-based work o',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Work orders for meter sets, service activations, and turn-on/off directly fulfill or terminate a service agreement. Water utility field operations require this link to track which service agreement a ',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Work orders must be measured against SLA response/restoration time commitments defined in sla_definition. Utilities track SLA compliance per work order for regulatory reporting and penalty avoidance. ',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order, including labor, materials, contractor services, and overhead allocations.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution was completed in the field.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended on the work order, captured from time sheets and labor transactions.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work execution began in the field.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or manager who approved the work order for execution or closure.',
    `assigned_to` STRING COMMENT 'Name or identifier of the technician, crew, or contractor assigned to execute the work order.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure (e.g., corrosion, age, improper operation, design defect).',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was formally closed and moved to historical status.',
    `completion_notes` STRING COMMENT 'Detailed narrative entered by the technician upon work completion, documenting findings, actions taken, parts replaced, and any follow-up recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the Computerized Maintenance Management System (CMMS).',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total hours the asset was out of service or unavailable due to this maintenance activity, critical for calculating Mean Time Between Failures (MTBF) and Mean Time To Repair (MTTR) Key Performance Indicators (KPIs).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Planned total cost for the work order including labor, materials, and services, used for budgeting and Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete the work order, used for resource planning and scheduling.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or problem that triggered the work order (e.g., leak, blockage, electrical fault, mechanical wear).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last updated or modified.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether regulatory permits (confined space entry, hot work, excavation, discharge) are required before work can commence.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact of the work order on operations, safety, and regulatory compliance.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this work order is driven by regulatory compliance requirements (Safe Drinking Water Act (SDWA), Clean Water Act (CWA), National Pollutant Discharge Elimination System (NPDES), Lead and Copper Rule Revisions (LCRR)).',
    `remedy_code` STRING COMMENT 'Standardized code identifying the corrective action taken to resolve the failure (e.g., repair, replace, adjust, clean).',
    `reported_date` DATE COMMENT 'Date when the work need was first reported or identified.',
    `safety_plan_required` BOOLEAN COMMENT 'Indicates whether a formal safety plan, Job Safety Analysis (JSA), or Occupational Safety and Health Administration (OSHA) compliance documentation is required for this work order.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when work is scheduled to be completed.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin.',
    `supervisor_approval_date` DATE COMMENT 'Date when the work order was reviewed and approved by the maintenance supervisor or manager.',
    `warranty_claim` BOOLEAN COMMENT 'Indicates whether this work order is associated with a warranty claim against a vendor or contractor for defective equipment or workmanship.',
    `work_order_description` STRING COMMENT 'Detailed narrative description of the work to be performed, including scope, objectives, and any special instructions or safety considerations.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, typically human-readable and used in field operations and reporting.',
    `work_order_source` STRING COMMENT 'Origin or trigger that created the work order (preventive maintenance schedule, Supervisory Control and Data Acquisition (SCADA) alarm, customer complaint, inspection finding, operator observation, predictive analytics model, regulatory mandate). [ENUM-REF-CANDIDATE: pm_schedule|scada_alarm|customer_complaint|inspection|operator_round|predictive_analytics|regulatory_requirement — 7 candidates stripped; promote to reference product]',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the maintenance workflow, from creation through completion and closure. [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|on_hold|completed|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by maintenance strategy: preventive maintenance (PM), corrective maintenance (CM), predictive maintenance (PdM), emergency, inspection, calibration, or capital project work. [ENUM-REF-CANDIDATE: preventive_maintenance|corrective_maintenance|predictive_maintenance|emergency|inspection|calibration|project — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional record for all maintenance activities — preventive (PM), corrective (CM), predictive (PdM), and emergency work orders. Captures work type, priority, originating asset, assigned crew/technician, scheduled and actual start/finish dates, labor hours, failure code, cause code, remedy code, downtime duration, and work order cost. Includes material line items: parts consumed or reserved with quantity, unit cost, issue date, storeroom, and reservation status. Enables actual vs. planned cost tracking (labor, material, contractor/service, overhead) per work order with GL account code and cost center. The authoritative SSOT for maintenance execution and O&M cost accounting, synchronized with IBM Maximo Work Order and SAP PM Order. Supports rate case cost justification and AWWA benchmarking.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Preventive maintenance schedules in water utilities are often defined at the asset class level as templates (e.g., all centrifugal pumps follow a 90-day PM schedule). Linking pm_schedule to asset_clas',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: PM schedules for permitted assets (NPDES outfall maintenance, operating permit equipment maintenance) must reference the applicable compliance permit. Supports permit condition compliance demonstratio',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: PM schedules for disinfection equipment, lead service line flushing, and treatment barriers are driven by specific contaminant control requirements (LCRR, DBP rules). Water utilities schedule contamin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM schedules carry a plain cost_center_code attribute (denormalized). Linking to finance.cost_center enables maintenance budget tracking, cost allocation reporting, and encumbrance management for plan',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), pumping station, or other facility where the asset is located and the preventive maintenance will be performed.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: PM schedules carry a plain gl_account_code attribute (denormalized). Linking to finance.general_ledger enables GL account validation for planned maintenance cost posting and supports rate case O&M exp',
    `job_plan_id` BIGINT COMMENT 'Reference to the standardized job plan that defines the detailed work instructions, materials, tools, and safety procedures for this maintenance task.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: PM schedules in water utilities specify required materials (filter media, lubricants, gaskets) to pre-stage inventory before scheduled maintenance execution. SAP PM/Maximo PM schedules reference mater',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset (equipment, pipe, pump, valve, vehicle) to which this preventive maintenance schedule applies.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory requirements drive PM schedules (monthly chlorine residual checks per permit, quarterly backwash inspections per state rules). Links maintenance planning to compliance obligations, ensures ',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: PM schedule frequency must align with SLA restoration time commitments — e.g., pump station PM intervals are set to meet SLA uptime guarantees. Utilities link PM schedules to SLA definitions during ma',
    `asset_criticality_rating` STRING COMMENT 'Criticality classification of the asset to which this schedule applies, indicating the impact of asset failure on operations, safety, regulatory compliance, or customer service.. Valid values are `critical|essential|important|standard`',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Indicates whether work orders should be automatically generated by the CMMS system when the schedule becomes due, or whether manual review and approval is required before work order creation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was first created in the CMMS system.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether the asset must be taken out of service (downtime) to perform the preventive maintenance task, requiring operational planning and backup capacity arrangements.',
    `effective_end_date` DATE COMMENT 'Date when this preventive maintenance schedule expires or is deactivated, after which no further work orders will be generated. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this preventive maintenance schedule becomes active and begins generating work orders.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset will be out of service during preventive maintenance, used for operational planning and redundancy management.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated cost of labor required to complete the preventive maintenance task based on estimated hours and labor rates, used for budgeting and OPEX planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the preventive maintenance task, used for workforce planning and scheduling.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated cost of materials, parts, and consumables required to complete the preventive maintenance task, used for budgeting and OPEX planning.',
    `frequency_interval` STRING COMMENT 'Numeric value representing the interval between preventive maintenance occurrences, interpreted based on the frequency unit (e.g., 30 for days, 500 for hours, 1000 for gallons).',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval, defining whether the schedule is based on time periods (days, weeks, months, years), operating hours, operational cycles, or volume processed (gallons, cubic meters). [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|gallons|cubic_meters — 8 candidates stripped; promote to reference product]',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this preventive maintenance schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this preventive maintenance schedule record was last modified in the CMMS system.',
    `last_performed_date` DATE COMMENT 'Date when the preventive maintenance task was last completed, used to calculate the next due date for calendar-based schedules.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated to allow for planning, scheduling, and resource allocation.',
    `maintenance_task_description` STRING COMMENT 'Detailed description of the preventive maintenance task to be performed, including specific procedures, inspections, or servicing activities required.',
    `next_due_date` DATE COMMENT 'Calculated date when the next preventive maintenance work order should be generated based on the schedule frequency and last performed date.',
    `priority` STRING COMMENT 'Priority level assigned to the preventive maintenance schedule based on asset criticality, regulatory requirements, or operational impact, used to sequence work order execution.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance schedule is required to meet regulatory compliance obligations such as EPA Safe Drinking Water Act (SDWA), Clean Water Act (CWA), NPDES permit conditions, or state-level inspection requirements.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulatory requirement, permit condition, or compliance standard that mandates this preventive maintenance activity (e.g., SDWA Section 1412, NPDES Permit Condition 3.2).',
    `required_skill_certifications` STRING COMMENT 'Comma-separated list of required skill certifications or qualifications that technicians must possess to perform this preventive maintenance task safely and effectively (e.g., electrical license, confined space entry, SCADA operator certification).',
    `safety_requirements` STRING COMMENT 'Description of safety precautions, personal protective equipment (PPE), lockout/tagout procedures, confined space entry protocols, or other safety measures required for this preventive maintenance task.',
    `schedule_name` STRING COMMENT 'Descriptive name of the preventive maintenance schedule for easy identification by operations and maintenance staff.',
    `schedule_number` STRING COMMENT 'Business identifier for the preventive maintenance schedule, typically assigned by the CMMS system for tracking and reporting purposes.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the preventive maintenance schedule indicating whether it is actively generating work orders or has been suspended or deactivated.. Valid values are `active|inactive|suspended|draft|expired`',
    `seasonal_end_month` STRING COMMENT 'Month number (1-12) when seasonal preventive maintenance schedule becomes inactive, applicable only when seasonal_schedule_flag is true.',
    `seasonal_schedule_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance schedule is seasonal in nature, applicable only during specific months or seasons (e.g., winterization of outdoor equipment, summer peak demand preparation).',
    `seasonal_start_month` STRING COMMENT 'Month number (1-12) when seasonal preventive maintenance schedule becomes active, applicable only when seasonal_schedule_flag is true.',
    `trigger_type` STRING COMMENT 'Type of trigger mechanism that determines when preventive maintenance is due: calendar-based (time intervals), meter-based (usage thresholds), condition-based (sensor readings), runtime-based (operating hours), or cycle-based (number of operations).. Valid values are `calendar|meter|condition|runtime|cycle`',
    `work_order_type` STRING COMMENT 'Classification of the work order that will be generated from this schedule, indicating the nature of the maintenance activity (preventive maintenance, inspection, calibration, lubrication, cleaning).. Valid values are `preventive|inspection|calibration|lubrication|cleaning`',
    `work_zone` STRING COMMENT 'Specific work zone, area, or department within the facility where the preventive maintenance activity will take place, used for crew assignment and access control.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this preventive maintenance schedule record in the CMMS system.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Defines preventive maintenance schedules for assets, including maintenance task description, trigger type (calendar-based, meter-based, condition-based), frequency or interval, last performed date, next due date, estimated labor hours, required skill certifications, and associated job plan. Drives automatic work order generation in IBM Maximo. Supports AWWA O&M best practices and regulatory inspection compliance requirements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`job_plan` (
    `job_plan_id` BIGINT COMMENT 'Unique identifier for the job plan. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Job plans are standardized maintenance procedures defined for specific asset classes. Currently asset_class is stored as STRING code; should be FK to asset_class.asset_class_id for referential integri',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Job plans define standard maintenance tasks with estimated costs allocated to cost centers for annual O&M budgeting. Supports bottom-up budget development and cost center planning.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Job plans carry estimated_labor_cost and estimated_material_cost. Water utilities pre-code job plans with GL accounts for budget encumbrance and cost pre-authorization before work order execution. job',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Job plans explicitly define required materials for maintenance tasks. The plain-text materials_list column is a denormalization of material_master. Linking enables automated material reservation when ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Job plans for regulatory-mandated maintenance tasks (LCRR flushing procedures, SDWA monitoring protocols) must reference the governing regulatory requirement. regulatory_compliance_notes is a denormal',
    `approved_by` STRING COMMENT 'Username or identifier of the supervisor or manager who approved this job plan for active use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan was approved and activated for use in work orders and preventive maintenance schedules.',
    `confined_space_flag` BOOLEAN COMMENT 'Indicates whether this job plan involves work in a confined space (e.g., wet well, tank, vault) requiring permit and atmospheric monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan record was first created in the system.',
    `downtime_required_flag` BOOLEAN COMMENT 'Indicates whether this job plan requires taking the asset or system offline, impacting operations and requiring coordination.',
    `effective_end_date` DATE COMMENT 'Date when this job plan version is superseded or retired. Null indicates the job plan is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this job plan version becomes effective and available for use in work order generation.',
    `environmental_impact_notes` STRING COMMENT 'Description of potential environmental impacts and mitigation measures for this job plan (e.g., chemical spill containment, waste disposal procedures).',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset or system will be out of service during execution of this job plan.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to complete all tasks in this job plan. Used for work order scheduling and resource planning.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Estimated total labor cost in USD to execute this job plan, calculated from labor craft rates and estimated hours.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Estimated total material and parts cost in USD required to execute this job plan, based on the materials list.',
    `estimated_tool_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for specialized tools, equipment rental, or contractor services required for this job plan.',
    `frequency_code` STRING COMMENT 'Standard frequency code indicating how often this job plan should be executed when attached to a preventive maintenance schedule. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|as_needed — 7 candidates stripped; promote to reference product]',
    `inspection_points` STRING COMMENT 'List of quality control and inspection checkpoints to be verified during or after job execution, ensuring work meets standards.',
    `job_plan_description` STRING COMMENT 'Detailed narrative description of the job plan purpose, scope, and overview of the maintenance activity to be performed.',
    `job_plan_number` STRING COMMENT 'The externally-known unique alphanumeric code identifying this job plan template across the organization. Used for referencing in work orders and preventive maintenance schedules.',
    `job_plan_status` STRING COMMENT 'Current lifecycle status of the job plan. Only active job plans can be attached to work orders or preventive maintenance schedules.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `job_type` STRING COMMENT 'Classification of the maintenance activity type that this job plan supports. Determines scheduling and priority rules.. Valid values are `preventive_maintenance|corrective_maintenance|predictive_maintenance|inspection|calibration|emergency_repair`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who most recently updated this job plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan record was most recently updated.',
    `loto_required_flag` BOOLEAN COMMENT 'Indicates whether Lockout/Tagout procedures are mandatory for this job plan to ensure worker safety during equipment maintenance.',
    `notes` STRING COMMENT 'Additional free-form notes, lessons learned, or special instructions for executing this job plan.',
    `ppe_requirements` STRING COMMENT 'List of required Personal Protective Equipment for workers executing this job plan (e.g., Hard hat, safety glasses, chemical-resistant gloves, steel-toe boots).',
    `priority` STRING COMMENT 'Default priority level assigned to work orders generated from this job plan. Lower numbers indicate higher priority (e.g., 1=Critical, 5=Routine).',
    `required_labor_crafts` STRING COMMENT 'Comma-separated list of labor craft skills required to execute this job plan (e.g., Electrician, Mechanic, Instrumentation Technician).',
    `revision_number` STRING COMMENT 'Sequential version number tracking changes to the job plan over time. Incremented each time the job plan is updated and re-approved.',
    `safety_requirements` STRING COMMENT 'Detailed safety procedures and precautions required for this job plan, including Lockout/Tagout (LOTO), confined space entry, Personal Protective Equipment (PPE), and hazard mitigation steps.',
    `source_reference` STRING COMMENT 'Reference to the source document or standard from which this job plan was derived (e.g., AWWA M11 Steel Pipe Manual, Manufacturer Service Bulletin 2023-04).',
    `task_sequence` STRING COMMENT 'Step-by-step instructions detailing the ordered sequence of tasks to be performed. Each step includes action description, safety notes, and quality checkpoints.',
    `title` STRING COMMENT 'Short descriptive title of the job plan that summarizes the maintenance activity (e.g., Pump Impeller Replacement, Chlorine Analyzer Calibration).',
    `tools_list` STRING COMMENT 'List of specialized tools, equipment, and instruments required to perform this job plan (e.g., Torque wrench, multimeter, pipe wrench set).',
    `created_by` STRING COMMENT 'Username or identifier of the person who originally created this job plan record.',
    CONSTRAINT pk_job_plan PRIMARY KEY(`job_plan_id`)
) COMMENT 'Standardized task library defining the step-by-step instructions, required labor crafts, estimated durations, safety procedures (LOTO, confined space, PPE), and materials/tools needed to perform a specific maintenance activity. Job plans are reusable templates attached to PM schedules and work orders. Sourced from IBM Maximo Job Plan module and aligned with AWWA O&M manuals and OSHA safety standards.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`failure_record` (
    `failure_record_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key.',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.exceedance. Business justification: Asset failures (main breaks, treatment upsets) directly cause MCL exceedances requiring regulatory notification. SDWA incident reporting requires traceability from the causative asset failure to the r',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Catastrophic or repeated asset failures in water utilities directly trigger emergency or planned CIP projects for main replacement or rehabilitation. Linking failure records to the resulting CIP proje',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: Asset failures (main breaks, treatment failures) directly cause compliance violations (boil water advisories, permit exceedances). Direct FK from failure_record to compliance_violation supports root c',
    `condition_assessment_id` BIGINT COMMENT 'Foreign key linking to asset.condition_assessment. Business justification: A failure record can reference the most recent condition assessment that documented the assets deteriorating state prior to failure. This traceability link supports root cause analysis (RCA) workflow',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Failure events trigger emergency repairs charged to cost centers for unplanned maintenance budget tracking. Critical for analyzing cost center budget variances and justifying contingency reserves in r',
    `inspection_event_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_event. Business justification: Failures in water utility infrastructure are frequently discovered during routine or regulatory inspection events (e.g., a CCTV pipe inspection reveals a structural failure, or a field inspection iden',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Failures of customer-side assets (service line breaks, meter malfunctions, lateral collapses) must be tracked to premises for customer impact analysis, regulatory reporting (e.g., lead service line fa',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset that experienced the failure (equipment, pipe, pump, valve, etc.).',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Asset failures of treatment process units (filters, clarifiers, UV reactors) must reference the process_unit for root cause analysis linking asset failures to treatment process performance degradation',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Asset failures triggering regulatory notification (regulatory_notification_required_flag=true) must be traceable to the specific regulatory requirement mandating notification. Supports SDWA, Clean Wat',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Asset failures (main breaks, tank overflows, pressure loss events) trigger mandatory water quality sampling per regulatory requirements (e.g., bacteriological sampling after pressure loss per TCR/RTCR',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order generated in response to this failure event.',
    `actual_repair_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred to repair or replace the failed asset after work completion.',
    `affected_system` STRING COMMENT 'The operational system or process affected by the failure (e.g., high service pump station, chlorination system, SCADA network, distribution main).',
    `corrective_actions_recommended` STRING COMMENT 'List of recommended corrective and preventive actions to prevent recurrence of similar failures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure record was first created in the system.',
    `cso_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a Combined Sewer Overflow event requiring regulatory reporting.',
    `customers_affected_count` STRING COMMENT 'Count of customer accounts impacted by the failure event (service interruption, pressure loss, water quality issue).',
    `detection_method` STRING COMMENT 'Method by which the failure was discovered (SCADA alarm, operator inspection, customer complaint, etc.). [ENUM-REF-CANDIDATE: scada_alarm|operator_inspection|customer_complaint|scheduled_inspection|predictive_maintenance|routine_testing|emergency_response — 7 candidates stripped; promote to reference product]',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total duration in hours that the asset was out of service due to the failure.',
    `emergency_response_actions` STRING COMMENT 'Detailed description of immediate emergency response actions taken to mitigate the failure (e.g., valve isolation, backup system activation, customer notification).',
    `environmental_impact_description` STRING COMMENT 'Description of any environmental impact resulting from the failure (e.g., water body contamination, soil contamination, habitat damage).',
    `failure_cause` STRING COMMENT 'Identified root cause of the failure (e.g., age-related deterioration, improper installation, inadequate maintenance, design deficiency, operational error, external damage).',
    `failure_criticality_score` STRING COMMENT 'Calculated criticality score based on failure severity, service impact, and asset importance (typically 1-100 scale).',
    `failure_date` DATE COMMENT 'Calendar date when the asset failure occurred.',
    `failure_effect` STRING COMMENT 'Description of the operational impact and consequences of the failure on system performance and service delivery.',
    `failure_mode` STRING COMMENT 'Classification of how the asset failed (e.g., mechanical fracture, electrical short, corrosion perforation, seal leakage, bearing seizure, control malfunction).',
    `failure_number` STRING COMMENT 'Business-readable unique identifier for the failure event, typically auto-generated by CMMS.',
    `failure_severity` STRING COMMENT 'Severity classification of the failure based on service impact, safety risk, and regulatory implications.. Valid values are `critical|major|moderate|minor`',
    `failure_status` STRING COMMENT 'Current lifecycle status of the failure record in the investigation and resolution workflow.. Valid values are `reported|under_investigation|rca_in_progress|corrective_action_pending|resolved|closed`',
    `failure_time` TIMESTAMP COMMENT 'Precise date and time when the asset failure was detected or occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure record was last updated or modified.',
    `mtbf_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this failure event should be included in MTBF reliability calculations for the asset class.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Measured time in hours from failure detection to restoration of asset to full operational status.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the failure event.',
    `overflow_volume_gallons` DECIMAL(18,2) COMMENT 'Estimated volume of wastewater overflow in gallons resulting from SSO or CSO event, if applicable.',
    `pressure_drop_psi` DECIMAL(18,2) COMMENT 'Measured drop in system pressure (PSI) resulting from the failure event.',
    `production_loss_mgd` DECIMAL(18,2) COMMENT 'Estimated water production capacity lost due to the failure, measured in Million Gallons per Day.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory agencies were notified of the failure event, if applicable.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure event requires notification to regulatory agencies (EPA, state primacy agency).',
    `repair_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost to repair or replace the failed asset, including labor, materials, and contractor costs.',
    `resolution_date` DATE COMMENT 'Date when the failure was fully resolved and the asset was restored to normal operation.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a formal root cause analysis (RCA) has been completed for this failure event.',
    `root_cause_analysis_findings` STRING COMMENT 'Detailed findings and conclusions from the root cause analysis investigation, including contributing factors and systemic issues identified.',
    `service_interruption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a complete service interruption to customers.',
    `sso_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure resulted in a Sanitary Sewer Overflow event requiring regulatory reporting.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the failure is covered under manufacturer or contractor warranty and a claim was filed.',
    CONSTRAINT pk_failure_record PRIMARY KEY(`failure_record_id`)
) COMMENT 'Documents asset failure events including failure date and time, failure mode, failure cause, failure effect, affected system, downtime duration, service impact (customers affected, MGD lost, PSI drop), emergency response actions taken, and root cause analysis findings. Supports reliability-centered maintenance (RCM) analysis, MTBF/MTTR calculations, and regulatory SSO/CSO incident reporting. Linked to corrective work orders in IBM Maximo.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`asset_meter` (
    `asset_meter_id` BIGINT COMMENT 'Unique surrogate identifier for the asset meter record in the enterprise data platform. Primary key for the asset_meter product. Role: MASTER_RESOURCE.',
    `location_id` BIGINT COMMENT 'Reference to the functional location or facility location record where the metered asset is installed. Links to the location hierarchy in the asset domain (e.g., WTP, pump station, WWTP). Supports geographic and facility-level aggregation of meter data.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Asset meters (flow meters, pressure transducers) are stocked physical devices with material master records in SAP/Maximo. Linking enables spare parts management, calibration scheduling, and reorder tr',
    `metering_meter_id` BIGINT COMMENT 'The native meter identifier from IBM Maximo Asset Management CMMS (METERNAME or internal Maximo meter key). Used for system-of-record traceability and bidirectional synchronization between the Silver Layer and Maximo.',
    `registry_id` BIGINT COMMENT 'Reference to the parent physical asset (pump, motor, valve, pipe segment, vehicle, etc.) to which this operational meter or counter is attached. Links to the asset master record in the asset domain.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Asset meters installed on treatment process units (run-hour meters on filters, flow meters on clarifiers) must reference the process_unit for SCADA integration, PM trigger management, and process perf',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory meters (is_regulatory_meter=true) are designated for specific monitoring requirements under NPDES, SDWA, or state permits. Tracing each regulatory meter to its governing requirement support',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sampling_point. Business justification: Operational meters (flow, pressure, chlorine residual) are co-located with or serve as quality sampling points. Water utilities integrate meter readings with sampling point data for distribution syste',
    `alarm_high_threshold` DECIMAL(18,2) COMMENT 'The upper alarm threshold value for this meter. When the reading exceeds this value, a SCADA or CMMS alarm is triggered. For example, high vibration alarm at 0.5 in/s for a pump motor. Supports integration with SCADA HMI alarm management.',
    `alarm_low_threshold` DECIMAL(18,2) COMMENT 'The lower alarm threshold value for this meter. When the reading falls below this value, a SCADA or CMMS alarm is triggered. For example, low flow alarm at 0.1 MGD for a treatment process feed pump.',
    `average_reading_rate` DECIMAL(18,2) COMMENT 'The average rate of change per day for this meter, calculated and stored by the CMMS during reading entry (not a derived KPI — stored as a CMMS field used for PM trigger forecasting). For example, average run-hours per day for a pump. Used by meter-based PM triggers to forecast next maintenance due date.',
    `avg_calculation_method` STRING COMMENT 'Method used by the CMMS to compute the average_reading_rate. SLIDING_WINDOW: rolling average over a configurable number of recent readings. FIXED_PERIOD: average over a fixed calendar period. LAST_READING: uses only the most recent reading interval.. Valid values are `SLIDING_WINDOW|FIXED_PERIOD|LAST_READING`',
    `calibration_interval_days` STRING COMMENT 'The required frequency of calibration expressed in calendar days. Used to compute next_calibration_date from last_calibration_date and to schedule calibration work orders in IBM Maximo.',
    `calibration_status` STRING COMMENT 'Current calibration status of the meter instrument. CALIBRATED: within valid calibration period. DUE: calibration due within the next calibration_interval_days. OVERDUE: calibration date has passed without recalibration. IN_PROGRESS: currently being calibrated. NOT_REQUIRED: meter type does not require formal calibration (e.g., simple cycle counters).. Valid values are `CALIBRATED|DUE|OVERDUE|IN_PROGRESS|NOT_REQUIRED`',
    `calibration_tolerance` DECIMAL(18,2) COMMENT 'Acceptable measurement tolerance or accuracy specification for this meter expressed in the meters unit of measure. Readings outside this tolerance trigger recalibration. For example, ±0.5 PSI for a pressure transducer or ±0.01 MGD for a flow totalizer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset meter record was first created in the enterprise data platform. Supports audit trail and data lineage requirements. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `current_reading` DECIMAL(18,2) COMMENT 'The most recent recorded value of the meter or counter as of the last_reading_date. For CONTINUOUS meters this is the cumulative total; for GAUGE meters this is the last observed point-in-time value. Principal quantitative fact for this MASTER_RESOURCE.',
    `decommission_date` DATE COMMENT 'Date on which the meter was permanently removed from service and retired. Null for active meters. Used for lifecycle reporting and asset history.',
    `installation_date` DATE COMMENT 'Date on which the meter was physically installed on the asset. Used to calculate meter age, warranty expiry, and to establish the baseline reading at installation.',
    `is_regulatory_meter` BOOLEAN COMMENT 'Indicates whether readings from this meter are used in regulatory compliance reporting (e.g., EPA NPDES Discharge Monitoring Reports, Safe Drinking Water Act compliance, Monthly Operating Reports). True = regulatory-grade meter subject to calibration and data integrity requirements.',
    `last_calibration_date` DATE COMMENT 'Date on which the meter was most recently calibrated and certified as accurate. Critical for regulatory compliance where metered values (e.g., flow, pressure, chemical dosing) are used in EPA/NPDES reporting.',
    `last_reading_date` TIMESTAMP COMMENT 'Timestamp of the most recent meter reading captured, whether from SCADA/OSIsoft PI Historian automated feed or manual entry in IBM Maximo. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `location_description` STRING COMMENT 'Free-text description of the physical location where the meter is installed on the asset, e.g., Discharge side of Pump 3 at WTP Building A, Inlet valve actuator shaft. Supplements the parent asset location for field technician navigation.',
    `measurement_unit` STRING COMMENT 'Engineering unit of measure for the meter reading, e.g., HOURS (run-hours), STARTS (motor starts), CYCLES (valve cycles), MGD (Million Gallons per Day), GPM (Gallons per Minute), PSI (Pounds per Square Inch), NTU (Nephelometric Turbidity Units), RPM, DEGREES_F, INCHES. Aligns with OSIsoft PI Historian tag engineering units.',
    `meter_name` STRING COMMENT 'Human-readable descriptive name for the meter or counter, e.g., Pump 3 Run Hours, Valve 12 Cycle Count, Influent Flow Totalizer. Used for display in CMMS work orders and PM triggers.',
    `meter_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the meter as assigned in IBM Maximo CMMS or SAP PM. Used for cross-system reference and field identification. Distinct from customer billing meter numbers managed by the Metering domain.',
    `meter_status` STRING COMMENT 'Current operational lifecycle status of the meter. ACTIVE: in service and collecting readings. INACTIVE: temporarily not in use. RETIRED: permanently decommissioned. SUSPENDED: readings paused (e.g., asset out of service). PENDING_CALIBRATION: due for or undergoing calibration.. Valid values are `ACTIVE|INACTIVE|RETIRED|SUSPENDED|PENDING_CALIBRATION`',
    `meter_type` STRING COMMENT 'Classification of the meter per IBM Maximo meter type taxonomy. CONTINUOUS: accumulating counter that never resets (e.g., run-hours, cycle counts, flow totalizer). GAUGE: point-in-time measurement that can go up or down (e.g., PSI, vibration amplitude, temperature). CHARACTERISTIC: qualitative or categorical observation (e.g., condition rating, oil color).. Valid values are `CONTINUOUS|GAUGE|CHARACTERISTIC`',
    `next_calibration_date` DATE COMMENT 'Scheduled date by which the meter must next be calibrated to maintain measurement accuracy and regulatory compliance. Drives calibration work order generation in IBM Maximo.',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag identifier associated with this meter for automated SCADA data ingestion. Enables direct linkage between the CMMS meter record and the PI Historian time-series data stream. Null if the meter is not integrated with PI Historian.',
    `pm_trigger_interval` DECIMAL(18,2) COMMENT 'The recurring interval of meter units between successive PM work order generations. For example, every 500 run-hours or every 1000 valve cycles. Works in conjunction with pm_trigger_threshold for ongoing PM scheduling.',
    `pm_trigger_threshold` DECIMAL(18,2) COMMENT 'The meter reading value at which a Preventive Maintenance (PM) work order is automatically generated. For example, a pump PM triggered every 2000 run-hours. Core field enabling meter-based PM scheduling in IBM Maximo.',
    `previous_reading` DECIMAL(18,2) COMMENT 'The meter reading value recorded immediately prior to the current reading. Used to calculate consumption delta between readings and to detect anomalous jumps or rollover events.',
    `previous_reading_date` TIMESTAMP COMMENT 'Timestamp of the meter reading that preceded the current reading. Used in conjunction with previous_reading to compute usage rate and validate reading intervals.',
    `reading_frequency` STRING COMMENT 'Expected frequency at which meter readings are collected. CONTINUOUS: real-time SCADA/PI Historian streaming. HOURLY/DAILY/WEEKLY/MONTHLY: scheduled batch collection. ON_DEMAND: readings taken only when required (e.g., during inspections or work orders).. Valid values are `CONTINUOUS|HOURLY|DAILY|WEEKLY|MONTHLY|ON_DEMAND`',
    `reading_range_max` DECIMAL(18,2) COMMENT 'Maximum valid reading value for this meter as defined by the instruments operating range or process design limits. Readings above this value are flagged as suspect or trigger alarms. For example, 150 PSI maximum for a distribution pressure transducer.',
    `reading_range_min` DECIMAL(18,2) COMMENT 'Minimum valid reading value for this meter as defined by the instruments operating range or process design limits. Readings below this value are flagged as suspect. For example, 0 PSI minimum for a pressure transducer.',
    `reading_source` STRING COMMENT 'The system or method by which the current meter reading was captured. SCADA: from Supervisory Control and Data Acquisition system. PI_HISTORIAN: from OSIsoft PI Historian automated feed. MANUAL: entered manually by a technician in IBM Maximo. AMI: from Advanced Metering Infrastructure. CMMS_IMPORT: batch import from CMMS. FIELD_DEVICE: direct PLC/RTU feed.. Valid values are `SCADA|PI_HISTORIAN|MANUAL|AMI|CMMS_IMPORT|FIELD_DEVICE`',
    `remarks` STRING COMMENT 'Free-text field for operational notes, technician observations, or special instructions related to this meter. For example, notes about known reading anomalies, temporary bypass conditions, or pending replacement. Sourced from IBM Maximo meter remarks field.',
    `rollover_value` DECIMAL(18,2) COMMENT 'The maximum value the meter counter can reach before rolling over to zero. Applicable to CONTINUOUS meters with fixed-digit displays (e.g., 99999.9 hours). Used to correctly compute cumulative usage across rollover events. Null if the meter has no rollover limit.',
    `sap_measuring_point_code` STRING COMMENT 'The measuring point identifier from SAP Plant Maintenance (PM) module corresponding to this asset meter. Enables reconciliation between IBM Maximo CMMS and SAP PM for assets managed across both systems.',
    `serial_number` STRING COMMENT 'Manufacturers serial number uniquely identifying the physical meter instrument. Used for warranty claims, calibration certificates, and asset tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset meter record was most recently modified in the enterprise data platform. Used for change tracking, incremental data loads, and audit compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_asset_meter PRIMARY KEY(`asset_meter_id`)
) COMMENT 'Tracks operational meters, counters, and their reading history for asset condition and usage monitoring — distinct from customer billing meters (owned by the metering domain). Examples include pump run-hours, motor starts, valve cycle counts, flow totalizers (MGD), pressure transducers (PSI), and vibration sensors. Captures meter type, unit of measure, current reading, rollover value, calibration status, and historical reading records (reading date/time, value, source — manual or SCADA/PI Historian automated, inspector ID, delta from previous reading). Feeds meter-based PM triggers, tracks asset utilization trends, and supports predictive maintenance analytics. Integrates with OSIsoft PI Historian.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`asset`.`inspection_event` (
    `inspection_event_id` BIGINT COMMENT 'Unique identifier for the inspection event record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.agreement. Business justification: Backflow preventer and cross-connection inspections are mandated conditions of specific service agreements. Regulators require inspection records to be traceable to the service agreement imposing the ',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP), wastewater treatment plant (WWTP), or other facility where the inspection occurred.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Inspection events are performed at specific physical locations within the utilitys infrastructure hierarchy. Adding location_id normalizes the denormalized functional_location STRING column, enabling',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.pm_schedule. Business justification: Inspection events in water utilities are frequently triggered by preventive maintenance schedules (e.g., regulatory inspection schedules, routine condition checks). Linking inspection_event directly t',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Inspections of backflow prevention devices, service laterals, and customer-owned infrastructure occur at premises. Required for cross-connection control programs, LCRR compliance, and regulatory repor',
    `registry_id` BIGINT COMMENT 'Reference to the asset or infrastructure component that was inspected.',
    `project_permit_id` BIGINT COMMENT 'Foreign key linking to project.project_permit. Business justification: Operational compliance inspections (NPDES, drinking water, dam safety) reference permits issued during project phase; regulatory reporting requires linking inspection findings to permit conditions, de',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Regulatory inspections are conducted by or reported to specific agencies (EPA, state primacy agency). The inspection_event.regulatory_agency plain attribute is a denormalized reference to compliance.r',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: AWIA vulnerability assessments, LCRR service line inspections, and state-mandated facility inspections are driven by specific regulatory requirements. Linking inspection events to the governing requir',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Regulatory inspections (CCTV pipe surveys, structural assessments) are routinely performed by contracted third-party vendors in water utilities. Tracking which vendor performed each inspection is requ',
    `water_sample_id` BIGINT COMMENT 'Foreign key linking to quality.water_sample. Business justification: Regulatory inspections (sanitary surveys, LCRR system assessments, tank inspections) include water quality sampling as part of the inspection protocol. Real business need: compliance documentation lin',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order under which this inspection was performed, if applicable.',
    `approval_date` DATE COMMENT 'Date on which the inspection results were formally approved by the reviewing authority.',
    `checklist_version` STRING COMMENT 'Version identifier of the inspection checklist used, ensuring traceability to specific regulatory or operational standards.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which identified deficiencies must be remediated, based on regulatory or operational requirements.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action work orders or follow-up activities are required as a result of this inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection event record was first created in the system.',
    `critical_deficiency_flag` BOOLEAN COMMENT 'Indicates whether any critical or high-severity deficiencies were identified that require immediate corrective action.',
    `deficiencies_identified_count` STRING COMMENT 'Total number of deficiencies, non-conformances, or issues identified during the inspection.',
    `deficiency_summary` STRING COMMENT 'Summary description of all deficiencies identified during the inspection, including severity and recommended actions.',
    `duration_minutes` STRING COMMENT 'Total time spent performing the inspection, measured in minutes.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the inspection identified any environmental compliance issues or potential environmental impacts.',
    `inspection_date` DATE COMMENT 'The calendar date on which the physical inspection was performed.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity was completed.',
    `inspection_frequency_days` STRING COMMENT 'Required frequency of this inspection type, measured in days, as mandated by regulatory or operational policy.',
    `inspection_notes` STRING COMMENT 'Free-text field for inspector observations, comments, and detailed findings from the inspection.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity commenced.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection event. [ENUM-REF-CANDIDATE: scheduled|in_progress|completed|cancelled|failed|pending_review|approved — 7 candidates stripped; promote to reference product]',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity. [ENUM-REF-CANDIDATE: routine|regulatory|post_incident|pre_commissioning|condition_assessment|safety|environmental|quality|preventive|corrective — promote to reference product]',
    `inspector_certification_num` STRING COMMENT 'Professional certification or license number of the inspector, if required by regulatory authority.',
    `inspector_name` STRING COMMENT 'Full name of the inspector who conducted the inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection event record was most recently updated.',
    `maximo_inspection_num` STRING COMMENT 'External inspection identifier from IBM Maximo CMMS system.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of this asset or component.',
    `pass_fail_outcome` STRING COMMENT 'Overall pass/fail result of the inspection based on checklist criteria and regulatory requirements.. Valid values are `pass|fail|conditional_pass|not_applicable`',
    `permit_number` STRING COMMENT 'External permit identifier issued by the regulatory authority, if this inspection is tied to permit compliance.',
    `regulatory_inspection_flag` BOOLEAN COMMENT 'Indicates whether this inspection was mandated by a regulatory authority (EPA, state primacy agency, OSHA) or was voluntary/internal.',
    `report_submission_date` DATE COMMENT 'Date on which the inspection report was submitted to the regulatory authority.',
    `report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the inspection report has been submitted to the regulatory authority, if required.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or near-miss occurred during the inspection activity.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection, relevant for outdoor infrastructure inspections (pipes, valves, tanks).',
    CONSTRAINT pk_inspection_event PRIMARY KEY(`inspection_event_id`)
) COMMENT 'Operational record of a physical inspection performed on an asset or infrastructure component, including inspection type (routine, regulatory, post-incident, pre-commissioning), inspector identity, inspection date, checklist used, pass/fail outcome, deficiencies identified, corrective action required flag, and regulatory permit reference. Distinct from condition_assessment (which produces a scored condition grade) — inspection_event captures compliance-driven inspection activities required by EPA, state primacy agencies, and OSHA.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_parent_asset_registry_id` FOREIGN KEY (`parent_asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ADD CONSTRAINT `fk_asset_criticality_rating_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `water_utilities_ecm`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `water_utilities_ecm`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `water_utilities_ecm`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `water_utilities_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `parent_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Cost (USD)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category / Business Domain');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name / Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag / Barcode Identifier');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `condition_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Condition Assessment Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Grade');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission / Retirement Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Asset Nominal Diameter (Millimeters)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Asset Elevation (Meters Above Sea Level)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life (Years)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `is_lead_service_line` SET TAGS ('dbx_business_glossary_term' = 'Lead Service Line (LSL) Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|corrective|run_to_failure|condition_based');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `maximo_asset_num` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|standby|decommissioned|under_construction|abandoned');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe / Asset Material');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `power_rating_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Rating (Kilowatts)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone / District Metered Area (DMA)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Replacement Cost (USD)');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `sap_equipment_num` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Equipment Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `serial_num` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `ami_applicable` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `asset_domain` SET TAGS ('dbx_business_glossary_term' = 'Asset Operational Domain');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `capex_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Capitalization Threshold (USD)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `cip_program_category` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Category');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `class_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Under Review');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `condition_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Default Condition Assessment Method');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `consequence_of_failure` SET TAGS ('dbx_business_glossary_term' = 'Primary Consequence of Failure Category');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `consequence_of_failure` SET TAGS ('dbx_value_regex' = 'Service Interruption|Public Health Risk|Environmental Non-Compliance|Safety Hazard|Financial Loss|Reputational');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Default Criticality Tier');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `criticality_weight` SET TAGS ('dbx_business_glossary_term' = 'Criticality Weighting Factor');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Default Depreciation Method');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'Straight-Line|Declining Balance|Units of Production|Sum-of-Years-Digits|Modified Accelerated Cost Recovery');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Effective Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `environmental_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Risk Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `gis_feature_class` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Class Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Hierarchy Level');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Frequency (Days)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `iso_55001_aligned` SET TAGS ('dbx_business_glossary_term' = 'ISO 55001 Asset Management Aligned Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `lcrr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Rule Revisions (LCRR) Applicable Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Maintenance Strategy');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'Preventive|Predictive|Corrective|Condition-Based|Run-to-Failure');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `material_standard` SET TAGS ('dbx_business_glossary_term' = 'Default Material Standard');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `maximo_class_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Asset Class Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `maximo_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `mean_time_between_failures_days` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) (Days)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) (Hours)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `number_sap` SET TAGS ('dbx_business_glossary_term' = 'SAP Asset Class Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `number_sap` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `pm_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency (Days)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `primary_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Primary Category');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_business_glossary_term' = 'Default Asset Renewal Strategy');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `renewal_strategy` SET TAGS ('dbx_value_regex' = 'Replace-in-Kind|Upgrade|Rehabilitation|CIPP|Trenchless|Decommission');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Retirement Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Classification');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'Confined Space|Electrical Hazard|Chemical Hazard|High Pressure|Radiation|None');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `salvage_value_pct` SET TAGS ('dbx_business_glossary_term' = 'Default Salvage Value Percentage');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `scada_monitored` SET TAGS ('dbx_business_glossary_term' = 'SCADA Monitored Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `size_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Asset Size Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `spare_parts_required` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Default Useful Life (Years)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Work Order Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_value_regex' = 'Preventive Maintenance|Corrective Maintenance|Inspection|Emergency Repair|Capital Renewal|Rehabilitation');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `area_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Area in Square Feet (sq ft)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'mgd|gpm|gallons|cubic_meters|units');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `dma_zone` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Zone');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet (ft)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|temporary');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'facility|building|floor|room|outdoor_site|storage_yard');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Location Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `sap_functional_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Functional Location');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `spatial_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Spatial Reference Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ALTER COLUMN `watershed` SET TAGS ('dbx_business_glossary_term' = 'Watershed');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Assessment Interval (Months)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|reviewed|approved|cancelled');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `estimated_replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Replacement Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `estimated_replacement_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `failure_probability` SET TAGS ('dbx_business_glossary_term' = 'Failure Probability');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `inspection_equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Inspection Equipment Used');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'monitor|repair|rehabilitate|replace|no_action|emergency_repair');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action Priority');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action_priority` SET TAGS ('dbx_value_regex' = 'immediate|urgent|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `structural_integrity_score` SET TAGS ('dbx_business_glossary_term' = 'Structural Integrity Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `criticality_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `assessment_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessment Performed By');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `capital_renewal_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Capital Renewal Priority Rank');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `cip_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Eligibility Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `consequence_of_failure_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (CoF) Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Criticality Tier');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `customer_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Count');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (Days)');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `likelihood_of_failure_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood of Failure (LoF) Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `methodology_version` SET TAGS ('dbx_business_glossary_term' = 'Methodology Version');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `preventive_maintenance_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Frequency (Days)');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Health Impact Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `public_health_impact_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `rating_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `rating_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'Active|Superseded|Under Review|Pending Approval');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `redundancy_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Available Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `regulatory_consequence_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Consequence Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ALTER COLUMN `service_disruption_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Disruption Duration (Hours)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `permit_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `remedy_code` SET TAGS ('dbx_business_glossary_term' = 'Remedy Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `safety_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `supervisor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Approval Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `warranty_claim` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_source` SET TAGS ('dbx_business_glossary_term' = 'Work Order Source');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|essential|important|standard');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `auto_generate_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Generate Work Order Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Priority');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `required_skill_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Skill Certifications');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|draft|expired');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_end_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal End Month');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Schedule Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_start_month` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Start Month');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'calendar|meter|condition|runtime|cycle');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|inspection|calibration|lubrication|cleaning');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `work_zone` SET TAGS ('dbx_business_glossary_term' = 'Work Zone');
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Entry Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `downtime_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `environmental_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime (Hours)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `estimated_tool_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tool Cost');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Code');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `inspection_points` SET TAGS ('dbx_business_glossary_term' = 'Inspection Points');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_type` SET TAGS ('dbx_business_glossary_term' = 'Job Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `job_type` SET TAGS ('dbx_value_regex' = 'preventive_maintenance|corrective_maintenance|predictive_maintenance|inspection|calibration|emergency_repair');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `loto_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout (LOTO) Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Priority');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `required_labor_crafts` SET TAGS ('dbx_business_glossary_term' = 'Required Labor Crafts');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `source_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Reference');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Title');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `tools_list` SET TAGS ('dbx_business_glossary_term' = 'Tools List');
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `actual_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost in US Dollars (USD)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System or Process');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `corrective_actions_recommended` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective Actions');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `cso_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Combined Sewer Overflow (CSO) Event Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Customers Affected');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Detection Method');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Asset Downtime Duration in Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `emergency_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Actions Taken');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `environmental_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause of Failure');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Failure Criticality Score');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Occurrence Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Classification');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity Level');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|rca_in_progress|corrective_action_pending|resolved|closed');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `failure_time` SET TAGS ('dbx_business_glossary_term' = 'Failure Occurrence Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `mtbf_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Impact Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time to Repair (MTTR) in Hours');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `overflow_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Overflow Volume in Gallons');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `pressure_drop_psi` SET TAGS ('dbx_business_glossary_term' = 'System Pressure Drop in Pounds per Square Inch (PSI)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `production_loss_mgd` SET TAGS ('dbx_business_glossary_term' = 'Production Loss in Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `repair_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost in US Dollars (USD)');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Resolution Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `root_cause_analysis_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Findings');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `service_interruption_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Interruption Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `sso_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanitary Sewer Overflow (SSO) Event Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `asset_meter_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `metering_meter_id` SET TAGS ('dbx_business_glossary_term' = 'IBM Maximo Meter ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sampling Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `alarm_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm High Threshold');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `alarm_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm Low Threshold');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `average_reading_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Meter Reading Rate');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `avg_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Average Calculation Method');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `avg_calculation_method` SET TAGS ('dbx_value_regex' = 'SLIDING_WINDOW|FIXED_PERIOD|LAST_READING');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Calibration Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'CALIBRATED|DUE|OVERDUE|IN_PROGRESS|NOT_REQUIRED');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `calibration_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Calibration Tolerance');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `current_reading` SET TAGS ('dbx_business_glossary_term' = 'Current Meter Reading');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Decommission Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `is_regulatory_meter` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Meter Indicator');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `last_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading Date and Time');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Description');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `meter_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `meter_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `meter_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|RETIRED|SUSPENDED|PENDING_CALIBRATION');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Meter Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'CONTINUOUS|GAUGE|CHARACTERISTIC');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI Historian Tag Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `pm_trigger_interval` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Interval');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `pm_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Trigger Threshold');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `previous_reading` SET TAGS ('dbx_business_glossary_term' = 'Previous Meter Reading');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `previous_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Meter Reading Date and Time');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `reading_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Frequency');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `reading_frequency` SET TAGS ('dbx_value_regex' = 'CONTINUOUS|HOURLY|DAILY|WEEKLY|MONTHLY|ON_DEMAND');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `reading_range_max` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Range Maximum');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `reading_range_min` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Range Minimum');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `reading_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Source');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `reading_source` SET TAGS ('dbx_value_regex' = 'SCADA|PI_HISTORIAN|MANUAL|AMI|CMMS_IMPORT|FIELD_DEVICE');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Meter Remarks');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `rollover_value` SET TAGS ('dbx_business_glossary_term' = 'Meter Rollover Value');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `sap_measuring_point_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Maintenance (PM) Measuring Point ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_event_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `checklist_version` SET TAGS ('dbx_business_glossary_term' = 'Checklist Version');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `critical_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `deficiencies_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiencies Identified Count');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `deficiency_summary` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Summary');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration in Minutes');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Days');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspector_certification_num` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `maximo_inspection_num` SET TAGS ('dbx_business_glossary_term' = 'Maximo Inspection Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Outcome');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `pass_fail_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|not_applicable');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `regulatory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Report Submitted Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
