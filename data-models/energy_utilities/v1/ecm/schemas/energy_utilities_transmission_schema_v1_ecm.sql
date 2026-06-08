-- Schema for Domain: transmission | Business: Energy Utilities | Version: v1_ecm
-- Generated on: 2026-05-04 21:10:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`transmission` COMMENT 'High-voltage bulk power transmission network operations including substations, transmission lines, transformers, circuit breakers, ATC calculations, congestion management, OATT compliance, and interconnection with RTOs/ISOs. Manages transmission rights, FTR positions, power flow models, NERC reliability coordination, and FERC transmission reporting. Integrates with EMS and SCADA for real-time grid state.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for line',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Transmission lines link to conductor material master records for procurement history, technical specifications (ACSR, ACCC types), replacement material sourcing, and capital project cost estimation. E',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transmission lines are assigned to cost centers for O&M expense allocation, budget tracking, and variance analysis. Supports operational expense management and regulatory cost reporting by functional ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transmission lines are capital assets requiring fixed asset tracking for FERC Form 1 reporting, depreciation calculation, rate base valuation, and regulatory compliance. Essential for utility financia',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the originating (sending-end) substation for the transmission line. Used to define the lines position in the network topology for power flow models, ATC calculations, and NERC reliability studies. References the substation master record.',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: Transmission lines classified as BES facilities require NERC CIP cyber security asset registration and compliance tracking. NERC CIP-002 mandates asset identification and categorization for all BES cy',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transmission lines require designated engineering owner for NERC facility rating reviews, maintenance planning, and compliance documentation. rating_approving_engineer currently stored as plain text; ',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Transmission lines are capital assets requiring lifecycle tracking, depreciation, maintenance planning, and FERC regulatory reporting. Every utility tracks transmission lines in their asset registry f',
    `right_of_way_corridor_id` BIGINT COMMENT 'Reference to the right-of-way corridor record that grants the legal easement for the transmission line route. ROW corridors define land rights, width restrictions, and co-location constraints. Used in asset management, land rights compliance, and GIS spatial analysis via Esri ArcGIS Utility Network.',
    `to_substation_transmission_substation_id` BIGINT COMMENT 'Identifier of the terminating (receiving-end) substation for the transmission line. Together with from_substation_id, defines the lines terminal nodes in the network model for power flow, contingency analysis, and OATT path definitions.',
    `circuit_configuration` STRING COMMENT 'Physical circuit arrangement of the transmission line structure. Single-circuit lines carry one three-phase circuit; double-circuit lines carry two three-phase circuits on the same tower/structure. Affects contingency analysis (N-1, N-2), right-of-way utilization, and NERC TPL reliability planning studies.. Valid values are `single-circuit|double-circuit|multi-circuit`',
    `commissioning_date` DATE COMMENT 'Date on which the transmission line successfully completed commissioning tests and was accepted for energization. Distinct from in_service_date (commercial operation); commissioning_date marks the technical acceptance milestone. Used in warranty tracking and asset lifecycle management in Ventyx Asset Suite.',
    `conductor_size_kcmil` DECIMAL(18,2) COMMENT 'Cross-sectional area of the conductor expressed in thousand circular mils (kcmil), the North American standard unit for conductor sizing. Directly determines the conductors current-carrying capacity and is a key input to IEEE Std 738 dynamic line rating calculations.',
    `conductor_type` STRING COMMENT 'Designation of the conductor material and construction used on the transmission line (e.g., ACSR — Aluminum Conductor Steel Reinforced, ACCC — Aluminum Conductor Composite Core, AAAC — All Aluminum Alloy Conductor, HTLS — High-Temperature Low-Sag). Determines ampacity, sag characteristics, and thermal rating methodology per IEEE Std 738.',
    `conductors_per_phase` STRING COMMENT 'Number of sub-conductors per phase bundle (e.g., 1 = single, 2 = twin bundle, 3 = triple bundle, 4 = quad bundle). Bundled conductors are used on EHV lines to reduce corona discharge and increase ampacity. Affects thermal rating calculations and power flow model parameters.',
    `emergency_rating_mva` DECIMAL(18,2) COMMENT 'Short-term emergency thermal rating of the transmission line in MVA, applicable for a defined duration (typically 15–30 minutes) following an N-1 contingency event. Used in contingency analysis, post-contingency corrective action planning, and NERC TPL reliability studies.',
    `ferc_oatt_path_code` STRING COMMENT 'FERC OATT transmission path or flowgate code associated with this line, used in ATC/TTC calculations, transmission service requests, and congestion management. Links the physical line to the commercial transmission path definitions in the OATT tariff schedules.. Valid values are `^[A-Z0-9_-]{1,30}$`',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier for this transmission line in the Esri ArcGIS Utility Network geospatial system. Enables spatial joins for route mapping, right-of-way analysis, outage impact assessment, and integration with OMS/ADMS systems.. Valid values are `^[A-Za-z0-9_-]{1,100}$`',
    `in_service_date` DATE COMMENT 'Date on which the transmission line was energized and placed into commercial service. Used for asset age calculations, depreciation schedules in SAP S/4HANA, FERC Form 1 plant-in-service reporting, and NERC reliability model versioning.',
    `insulation_type` STRING COMMENT 'Type of electrical insulation used on the transmission line. For overhead lines, refers to insulator material (porcelain, glass, polymer). For underground/submarine cables, refers to cable insulation type (XLPE, PILC). Affects dielectric performance, maintenance intervals, and failure mode analysis.. Valid values are `porcelain|glass|polymer|XLPE|PILC|XLPE-HVDC`',
    `length_km` DECIMAL(18,2) COMMENT 'Total route length of the transmission line in kilometers. Metric equivalent of length_miles for international reporting, IEC standard compliance, and cross-border interconnection documentation. Sourced from Esri ArcGIS Utility Network.',
    `length_miles` DECIMAL(18,2) COMMENT 'Total route length of the transmission line in miles. Used in impedance calculations, line loss estimation, right-of-way cost allocation, FERC transmission rate base calculations, and O&M cost modeling. Sourced from Esri ArcGIS Utility Network spatial data.',
    `line_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the transmission line within the utilitys network and used in FERC OATT filings, NERC reliability models, and EMS/SCADA systems. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE. Sourced from GE PowerOn ADMS and Esri ArcGIS Utility Network.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `line_name` STRING COMMENT 'Human-readable descriptive name of the transmission line, typically referencing the from/to substations or geographic corridor (e.g., Northgate–Riverside 345kV). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE. Used in operational displays, FERC filings, and customer-facing interconnection documents.',
    `line_type` STRING COMMENT 'Physical construction type of the transmission line. Overhead lines use aerial conductors on towers/poles; underground lines use buried cables; submarine lines cross bodies of water. Determines applicable rating standards, maintenance practices, and outage restoration timelines.. Valid values are `overhead|underground|submarine`',
    `load_dump_rating_mva` DECIMAL(18,2) COMMENT 'Extreme short-term (load dump) thermal rating in MVA, applicable for a very brief duration (typically 1–5 minutes) under extreme contingency conditions before protective relay action. Used in NERC TPL extreme event (P5–P7) analysis and system protection scheme design.',
    `nerc_bes_flag` BOOLEAN COMMENT 'Indicates whether this transmission line is classified as part of the NERC Bulk Electric System (BES), which subjects it to mandatory NERC reliability standards (CIP, FAC, TPL, MOD, etc.). Lines operating at ≥100 kV are generally BES-applicable. Critical for NERC compliance program scoping.',
    `nerc_facility_rating_code` STRING COMMENT 'NERC-assigned or utility-assigned facility rating identifier used in NERC FAC-008 compliance documentation and transmission planning model submissions (NERC MOD-032). Links this line record to the formal facility rating study documentation.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `normal_rating_amps` DECIMAL(18,2) COMMENT 'Continuous normal thermal rating expressed in amperes (A) per phase. Complements normal_rating_mva for use in protection relay settings, SCADA alarm thresholds in OSIsoft PI, and conductor temperature monitoring applications where current is the direct measured quantity.',
    `normal_rating_mva` DECIMAL(18,2) COMMENT 'Continuous normal (steady-state) thermal rating of the transmission line in megavolt-amperes (MVA) under standard ambient conditions. This is the primary facility rating used in real-time operations, ATC calculations, and NERC FAC-008 compliance. Represents the maximum continuous loading without exceeding conductor temperature limits.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the transmission line. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE. Drives inclusion in power flow models, ATC calculations, and NERC reliability assessments. Sourced from GE PowerOn ADMS and Ventyx Asset Suite.. Valid values are `in-service|out-of-service|mothballed|under-construction|decommissioned|planned`',
    `owner_entity_code` STRING COMMENT 'NERC-registered entity identifier (e.g., NERC Entity ID or DUNS number) of the primary owner/operator of the transmission line. Used in NERC reliability filings, FERC OATT compliance, and joint-ownership coordination. For lines with multiple owners, represents the operating owner.. Valid values are `^[A-Z0-9]{2,20}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of the transmission line owned by this utility (0.00–100.00). Joint-ownership lines are common in the bulk power system. Drives rate base allocation in FERC OATT transmission rates, revenue requirement calculations, and co-owner settlement in OpenLink Endur.',
    `pnode_code` STRING COMMENT 'RTO/ISO pricing node (PNode) identifier associated with the transmission lines terminal buses. Used in LMP (Locational Marginal Price) calculations, congestion cost allocation, FTR settlement, and energy trading position management in OpenLink Endur.. Valid values are `^[A-Z0-9_.-]{1,50}$`',
    `protection_scheme` STRING COMMENT 'Primary protection scheme applied to the transmission line (e.g., Distance-Zone 1-2-3, Pilot-POTT, Pilot-DCUB, Current Differential). Critical for NERC PRC (Protection and Control) standard compliance, relay coordination studies, and system protection scheme documentation.',
    `rating_last_review_date` DATE COMMENT 'Date on which the transmission lines facility ratings were most recently reviewed and validated by the approving engineer. NERC FAC-008 requires periodic review of facility ratings. Triggers re-review workflow in Ventyx Asset Suite when approaching the required review interval.',
    `rating_methodology` STRING COMMENT 'Methodology used to determine the transmission lines thermal ratings. Static ratings use fixed conservative assumptions; dynamic line ratings (DLR) use real-time weather and conductor temperature data; ambient-adjusted ratings use seasonal ambient temperature corrections. Required disclosure under NERC FAC-008 and FERC Order 881 (ambient-adjusted ratings mandate).. Valid values are `static|dynamic|ambient-adjusted|real-time`',
    `reactance_ohms_per_mile` DECIMAL(18,2) COMMENT 'Positive-sequence inductive reactance of the transmission line in ohms per mile. Critical parameter for power flow models, short-circuit analysis, and distance protection relay settings. Used in NERC MOD-032 power flow base case models submitted to RTOs/ISOs.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission line master record was first created in the Silver Layer data product. Serves as the RECORD_AUDIT_CREATED field for this MASTER_RESOURCE. Used for data lineage, audit trail, and regulatory record-keeping under SOX and NERC CIP.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission line master record was most recently modified. Used for change data capture (CDC) in the Databricks Silver Layer, audit trail compliance under SOX, and detecting stale records in power flow model synchronization workflows.',
    `resistance_ohms_per_mile` DECIMAL(18,2) COMMENT 'AC resistance of the transmission line conductor in ohms per mile at 50°C (or specified temperature). A fundamental electrical parameter used in power flow models (PSS/E, PowerWorld), line loss calculations, and impedance-based protection relay settings. Sourced from conductor manufacturer data sheets.',
    `retirement_date` DATE COMMENT 'Date on which the transmission line was or is planned to be permanently retired from service. Nullable for active lines. Used in asset lifecycle management (Ventyx Asset Suite), FERC Form 1 retirements reporting, IRP planning, and NERC model updates.',
    `rto_iso_region` STRING COMMENT 'Name or code of the RTO or ISO within whose footprint this transmission line operates (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE). Determines applicable market rules, ATC calculation methodology, congestion management procedures, and FTR/ARR allocation. [ENUM-REF-CANDIDATE: PJM|MISO|CAISO|SPP|ERCOT|NYISO|ISO-NE|SERC|WECC|non-RTO — promote to reference product]',
    `scada_tag_code` STRING COMMENT 'SCADA system tag identifier for the transmission lines real-time telemetry point in OSIsoft PI historian. Used to retrieve real-time MW flow, MVAR flow, and current measurements for EMS state estimation, real-time ATC monitoring, and NERC reliability coordinator data exchange.. Valid values are `^[A-Za-z0-9_.:-]{1,100}$`',
    `spring_fall_normal_rating_mva` DECIMAL(18,2) COMMENT 'Seasonal normal thermal rating for spring and fall shoulder seasons (typically March–May and September–November) in MVA. Used in seasonal ATC calculations and NERC seasonal assessments where a third seasonal rating is required.',
    `summer_normal_rating_mva` DECIMAL(18,2) COMMENT 'Seasonal normal thermal rating for summer conditions (typically June–August) in MVA, reflecting higher ambient temperatures that reduce conductor ampacity. Used in seasonal ATC calculations, summer peak planning, and NERC seasonal assessments submitted to RTOs/ISOs.',
    `susceptance_siemens_per_mile` DECIMAL(18,2) COMMENT 'Positive-sequence shunt susceptance (charging susceptance) of the transmission line in siemens per mile. Represents the lines capacitive charging current contribution, which is significant for long EHV lines. Used in power flow models, reactive power planning, and Volt-VAR optimization.',
    `tower_structure_type` STRING COMMENT 'Type of supporting structure used for the overhead transmission line. Determines structural loading capacity, maintenance access requirements, storm vulnerability, and asset replacement cost estimates in Ventyx Asset Suite capital planning.. Valid values are `lattice-steel|monopole-steel|monopole-concrete|H-frame-wood|guyed-V|tubular-steel`',
    `voltage_class` STRING COMMENT 'Standardized voltage class designation for the transmission line used in asset categorization, rate base segmentation, and FERC OATT rate zone assignment. Complements the precise voltage_kv field with a discrete classification bucket aligned to industry-standard voltage tiers. [ENUM-REF-CANDIDATE: 69kV|115kV|138kV|161kV|230kV|345kV|500kV|765kV — 8 candidates stripped; promote to reference product]',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage of the transmission line in kilovolts (kV). Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE. Determines voltage class (e.g., 115 kV, 230 kV, 345 kV, 500 kV, 765 kV), which governs thermal ratings, insulation requirements, and NERC bulk electric system (BES) applicability thresholds (≥100 kV).',
    `winter_normal_rating_mva` DECIMAL(18,2) COMMENT 'Seasonal normal thermal rating for winter conditions (typically December–February) in MVA, reflecting lower ambient temperatures that increase conductor ampacity. Used in seasonal ATC calculations, winter peak planning, and NERC seasonal assessments.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Master record for high-voltage bulk power transmission lines including overhead and underground circuits, with NERC-compliant facility ratings. Captures line identifier, voltage class (kV), circuit configuration, conductor type, thermal rating (MVA), length (miles/km), right-of-way corridor reference, ownership percentage, in-service date, operational status, and facility ratings (normal/emergency/load-dump ratings in MVA/A, seasonal variants for summer/winter/spring-fall, rating methodology, last review date, approving engineer). SSOT for transmission line physical characteristics, electrical parameters, and thermal limits used in power flow models, ATC calculations, real-time operations, and FERC OATT compliance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` (
    `transmission_substation_id` BIGINT COMMENT 'Unique surrogate identifier for the transmission substation record in the lakehouse Silver layer. Serves as the primary key and topological node anchor for the transmission network model. MASTER_RESOURCE role — canonical-attrs-enforced.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Substations have assigned cost centers for operational expense management, maintenance budget tracking, and cost allocation. Required for FERC functional cost reporting and internal management account',
    `ems_node_id` BIGINT COMMENT 'Node identifier used within the Energy Management System (EMS) to represent this substation in the real-time network model. Used for state estimation, contingency analysis, and automatic generation control (AGC) coordination.',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: Substations are critical BES cyber assets requiring CIP compliance tracking for physical and electronic security perimeters. NERC CIP-006 and CIP-005 mandate asset-level security controls and document',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Substations are major capital assets requiring comprehensive asset management for regulatory rate base, depreciation schedules, capital project planning, and FERC reporting. Standard practice in utili',
    `atc_contribution_mw` DECIMAL(18,2) COMMENT 'This substations contribution to the Available Transfer Capability (ATC) calculation in megawatts (MW) as determined by the most recent power flow study. Used in transmission planning, congestion management, and OATT ATC posting requirements.',
    `bes_designation` BOOLEAN COMMENT 'Indicates whether this substation is designated as part of the Bulk Electric System (BES) per NERC BES definition. True = BES asset subject to full NERC reliability standards; False = non-BES asset. Critical for determining applicable NERC compliance obligations.',
    `bus_configuration` STRING COMMENT 'Electrical bus arrangement of the substation switchyard. Determines switching flexibility, reliability, and maintenance capability. Used in outage planning, NERC TPL reliability studies, and ADMS network modeling. [ENUM-REF-CANDIDATE: single-bus|double-bus|ring-bus|breaker-and-a-half|double-bus-double-breaker — promote to reference product]. Valid values are `single-bus|double-bus|ring-bus|breaker-and-a-half|double-bus-double-breaker`',
    `cip_asset_classification` STRING COMMENT 'NERC CIP-002 BES Cyber System impact classification for this substation. high = high-impact BES asset; medium = medium-impact; low = low-impact; not-applicable = not classified as a BES Cyber Asset. Drives cybersecurity control requirements under NERC CIP-003 through CIP-014.. Valid values are `high|medium|low|not-applicable`',
    `climate_zone` STRING COMMENT 'Climate zone classification for the substation site (e.g., ASHRAE climate zone or utility-defined zone). Used in equipment de-rating calculations, extreme weather resilience planning, and NERC EOP-011 cold weather preparedness assessments.',
    `commissioning_date` DATE COMMENT 'Date on which the substation was officially energized and placed into commercial service. Used in asset lifecycle management (Ventyx Asset Suite), depreciation calculations (SAP S/4HANA), and NERC facility registration.',
    `control_building_type` STRING COMMENT 'Physical configuration of the substation control house or control building. indoor = fully enclosed GIS or AIS indoor design; outdoor = open-air AIS with separate control building; hybrid = mixed indoor/outdoor; mobile = temporary or mobile substation.. Valid values are `indoor|outdoor|hybrid|mobile`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country in which the substation is located (e.g., USA, CAN, MEX). Used for cross-border interconnection reporting and NERC/FERC jurisdictional classification.. Valid values are `^[A-Z]{3}$`',
    `decommission_date` DATE COMMENT 'Date on which the substation was permanently retired from service. Null for active substations. Used in asset lifecycle management, regulatory retirement filings, and RAB adjustments.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the substation site above mean sea level in meters. Used in environmental assessments, flood risk analysis, and equipment insulation coordination at high-altitude sites.',
    `ferc_facility_code` STRING COMMENT 'FERC-assigned facility identifier for this substation used in FERC Form 1 transmission plant reporting and OATT compliance filings. Required for FERC-jurisdictional transmission assets.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier for this substation in the Esri ArcGIS Utility Network geospatial system. Used to link the asset record to its spatial representation for network modeling, outage analysis, and field crew dispatch.',
    `installed_transformer_mva` DECIMAL(18,2) COMMENT 'Total installed transformer capacity at the substation in megavolt-amperes (MVA). Represents the aggregate nameplate rating of all power transformers at this node. Used in congestion management, ATC calculations, and capacity planning.',
    `insulation_medium` STRING COMMENT 'Primary insulation technology used in the substation switchgear. AIS = Air-Insulated Switchgear; GIS = Gas-Insulated Switchgear (SF6); hybrid = combination of AIS and GIS. Affects maintenance requirements, footprint, and environmental compliance (SF6 reporting under EPA regulations).. Valid values are `AIS|GIS|hybrid`',
    `interconnection_agreement_ref` STRING COMMENT 'Reference number or identifier of the FERC-filed interconnection agreement (e.g., LGIA or SGIA) associated with this substations point of interconnection (POI). Used in OATT compliance and interconnection queue management.',
    `last_major_refurbishment_date` DATE COMMENT 'Date of the most recent major capital refurbishment or upgrade of the substation. Used in asset condition assessment, CAPEX planning, and remaining useful life estimation in Ventyx Asset Suite.',
    `latitude` DECIMAL(18,2) COMMENT 'WGS-84 geographic latitude coordinate of the substation in decimal degrees. Used in GIS (Esri ArcGIS Utility Network) for network modeling, outage analysis, and asset location. Positive values indicate north of the equator.',
    `longitude` DECIMAL(18,2) COMMENT 'WGS-84 geographic longitude coordinate of the substation in decimal degrees. Used in GIS (Esri ArcGIS Utility Network) for network modeling, outage analysis, and asset location. Negative values indicate west of the prime meridian.',
    `nerc_node_code` STRING COMMENT 'Externally-known NERC-assigned unique node identifier for this substation used in reliability coordination, power flow models, and NERC compliance reporting. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE. Aligns with NERC FAC-001 and FAC-002 facility registration requirements.',
    `nerc_reliability_region` STRING COMMENT 'NERC reliability region designation (e.g., MRO, SERC, WECC, RFC, NPCC, TRE) for this substation. Determines applicable NERC reliability standards, TPL planning criteria, and CIP cybersecurity requirements.',
    `number_of_bays` STRING COMMENT 'Total number of switchgear bays (feeder bays, transformer bays, bus-coupler bays) installed at the substation. Used in capacity planning, maintenance scheduling, and asset inventory management in Ventyx Asset Suite.',
    `number_of_circuit_breakers` STRING COMMENT 'Total count of high-voltage circuit breakers installed at this substation. Used in asset inventory, maintenance scheduling, and NERC FAC-002 facility rating assessments.',
    `number_of_transformers` STRING COMMENT 'Count of power transformers installed at this substation. Used in asset inventory, maintenance planning, and transformer fleet management in Ventyx Asset Suite and SAP S/4HANA PM.',
    `operating_entity_name` STRING COMMENT 'Legal name of the entity responsible for operating and maintaining this substation. May differ from the owning entity in cases of contracted O&M or joint-ownership arrangements.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the substation. in-service = energized and operational; out-of-service = temporarily de-energized; under-construction = not yet commissioned; decommissioned = permanently retired; mothballed = preserved but inactive. Serves as LIFECYCLE_STATUS for this MASTER_RESOURCE. Drives asset management workflows in Ventyx Asset Suite and SAP S/4HANA PM.. Valid values are `in-service|out-of-service|under-construction|decommissioned|mothballed`',
    `ownership_type` STRING COMMENT 'Classification of the entity that owns this substation. Determines regulatory jurisdiction, rate-setting authority, and OATT applicability. Used in FERC Form 1 reporting and RAB calculations.. Valid values are `investor-owned|municipal|cooperative|federal|joint-ownership|independent`',
    `owning_entity_name` STRING COMMENT 'Legal name of the utility or entity that owns this substation. May differ from the operating entity in joint-ownership or leased facility arrangements. Used in FERC Form 1 and NERC registration filings.',
    `physical_security_level` STRING COMMENT 'Physical security classification of the substation per NERC CIP-006 Physical Security Program requirements. Determines perimeter security controls, access management, and visitor logging requirements.. Valid values are `high|medium|low`',
    `pnode_code` STRING COMMENT 'The Locational Marginal Price (LMP) pricing node identifier assigned by the RTO/ISO for this substation. Used in energy trading settlement (OpenLink Endur), FTR position management, and DAM/RTM market operations.',
    `primary_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal primary (high-side) voltage level of the substation in kilovolts (kV). Represents the principal quantitative rating of this transmission asset. Serves as MEASUREMENT_OR_VALUE for this MASTER_RESOURCE. Used in power flow models, ATC calculations, and NERC reliability assessments.',
    `protection_scheme_type` STRING COMMENT 'Primary protection scheme employed at this substation. Determines relay coordination requirements and NERC PRC (Protection and Control) standard applicability. Used in protection engineering and NERC PRC-001 compliance. [ENUM-REF-CANDIDATE: differential|distance|overcurrent|pilot-wire|directional-comparison|hybrid — promote to reference product]. Valid values are `differential|distance|overcurrent|pilot-wire|directional-comparison|hybrid`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substation record was first created in the lakehouse Silver layer. Used for data lineage, audit trail, and record provenance tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this substation record in the lakehouse Silver layer. Used for change tracking, data quality monitoring, and incremental ETL processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO market region in which this substation operates. Determines applicable wholesale market rules, LMP pricing nodes, and OATT obligations. Used in energy trading (OpenLink Endur) and FERC transmission reporting. [ENUM-REF-CANDIDATE: MISO|PJM|CAISO|ERCOT|SPP|NYISO|ISO-NE|WECC|SERC|none — promote to reference product]',
    `sap_functional_location` STRING COMMENT 'SAP S/4HANA Plant Maintenance functional location code for this substation. Used to link the substation to work orders, maintenance plans, equipment master records, and cost center assignments in SAP.',
    `scada_integration_point` STRING COMMENT 'Identifier or endpoint reference for the SCADA integration point connecting this substation to the Energy Management System (EMS). Used in OSIsoft PI historian configuration and GE PowerOn ADMS real-time data feeds for grid state estimation.',
    `secondary_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal secondary (low-side) voltage level in kilovolts (kV) for transformer substations. Null for switching stations with no transformation. Used in power flow models and interconnection studies.',
    `seismic_zone` STRING COMMENT 'Seismic hazard zone designation for the substation site per IEEE Std 693 or applicable building code. Used in equipment qualification, civil engineering assessments, and resilience planning.',
    `short_circuit_level_ka` DECIMAL(18,2) COMMENT 'Maximum prospective short-circuit current level at the substation busbars in kiloamperes (kA). Used in equipment rating verification, protection relay coordination, and circuit breaker interrupting capacity assessments.',
    `state_province_code` STRING COMMENT 'Two-letter ISO 3166-2 state or province code where the substation is physically located. Used for jurisdictional regulatory reporting to State Public Utility Commissions (PUCs) and FERC.. Valid values are `^[A-Z]{2}$`',
    `substation_code` STRING COMMENT 'Short alphanumeric code used to identify the substation in operational systems including EMS, SCADA, and SAP S/4HANA Plant Maintenance. Typically a 2–10 character mnemonic aligned with the utilitys internal naming convention.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `substation_name` STRING COMMENT 'Official human-readable name of the transmission substation as registered in the utilitys asset management system (Ventyx Asset Suite) and GIS (Esri ArcGIS Utility Network). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE. Used in operational displays, SCADA, and regulatory filings.',
    `substation_type` STRING COMMENT 'Functional classification of the substation. transmission = bulk power transmission node; switching = bus-switching station without transformation; transformer = voltage step-up/step-down station; converter = AC/DC or DC/AC conversion station; collector = renewable energy collector substation. Serves as CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE.. Valid values are `transmission|switching|transformer|converter|collector`',
    `tertiary_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal tertiary winding voltage level in kilovolts (kV) for three-winding transformer substations. Null when no tertiary winding exists. Used in detailed power flow and short-circuit studies.',
    CONSTRAINT pk_transmission_substation PRIMARY KEY(`transmission_substation_id`)
) COMMENT 'Master record for high-voltage transmission substations including switching stations and transformer substations. Captures substation name, NERC node identifier, voltage levels served, bus configuration, geographic coordinates (GIS), ownership, commissioning date, SCADA integration point, and operational status. Serves as the topological node anchor for the transmission network model and interconnects with EMS/SCADA systems.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` (
    `power_transformer_id` BIGINT COMMENT 'Unique identifier for the bulk power transformer asset. Primary key for the power transformer master record.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transformers are individually capitalized assets with separate depreciation schedules, useful life tracking, and book value management. Required for asset retirement obligation (ARO) calculations and ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Power transformers as capital assets must link to material master for procurement history, technical specifications, spare parts cataloging, warranty management, and lifecycle cost tracking. Standard ',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: Power transformers at critical substations are BES cyber assets subject to NERC CIP-007 configuration management and CIP-010 change control requirements. Asset-level compliance tracking is mandatory f',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Power transformers are high-value critical assets requiring detailed lifecycle management, condition monitoring, depreciation tracking, and replacement analysis. Utilities maintain comprehensive asset',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Critical transformers require designated responsible engineer for condition monitoring, health index assessment, maintenance scheduling, and asset lifecycle decisions. Standard utility practice assign',
    `transmission_substation_id` BIGINT COMMENT 'Reference to the transmission substation where this power transformer is installed.',
    `book_value` DECIMAL(18,2) COMMENT 'Current net book value of the transformer after accumulated depreciation. Used for financial reporting, rate case filings, and asset valuation.',
    `capital_cost` DECIMAL(18,2) COMMENT 'Original capital cost of the transformer in US dollars including equipment, installation, and commissioning. Used for depreciation calculations, rate base determination, and capital investment reporting.',
    `commissioning_date` DATE COMMENT 'Date the transformer was energized and placed into commercial operation. May differ from installation date due to testing and acceptance procedures.',
    `condition_score` DECIMAL(18,2) COMMENT 'Composite condition assessment score based on dissolved gas analysis, oil quality tests, winding resistance, insulation power factor, and visual inspections. Typically scaled 0-100 where higher scores indicate better condition. Used for risk-based maintenance prioritization.',
    `cooling_class` STRING COMMENT 'Transformer cooling method classification per IEEE standards. ONAN (Oil Natural Air Natural) is self-cooled; ONAF (Oil Natural Air Forced) uses fans; OFAF (Oil Forced Air Forced) uses pumps and fans. Cooling class affects MVA rating and operational efficiency.. Valid values are `ONAN|ONAF|OFAF|OFWF|ODAF|ODWF`',
    `current_tap_position` STRING COMMENT 'Current tap position setting of the transformer. Used for real-time voltage regulation monitoring and optimization. Typically monitored via SCADA.',
    `expected_retirement_date` DATE COMMENT 'Planned date for transformer retirement or replacement based on asset lifecycle planning, condition assessment, and capital investment programs.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts code for the transformer asset. Transmission transformers typically classified under Account 352 (Structures and Improvements) or Account 353 (Station Equipment).. Valid values are `^[0-9]{3}$`',
    `gis_location_code` STRING COMMENT 'Reference identifier linking the transformer to its geospatial representation in the utility GIS system. Used for network modeling, outage analysis, and asset visualization.',
    `health_index` DECIMAL(18,2) COMMENT 'Normalized health index score combining condition assessment, age, loading history, and failure probability. Used for asset investment planning and replacement prioritization. Typically scaled 0-10 or 0-100.',
    `impedance_percent` DECIMAL(18,2) COMMENT 'Percentage impedance of the transformer on its rated MVA base. Critical parameter for short-circuit calculations, fault current analysis, and power flow modeling in Energy Management Systems (EMS).',
    `installation_date` DATE COMMENT 'Date the transformer was installed and commissioned at the substation. Used for calculating asset age, warranty periods, and maintenance schedules.',
    `insulation_type` STRING COMMENT 'Type of insulating medium used in the transformer. Mineral oil is most common for transmission transformers; ester fluids offer environmental benefits; dry-type uses solid insulation without liquid.. Valid values are `mineral_oil|silicone|ester|dry_type|gas`',
    `is_critical_asset` BOOLEAN COMMENT 'Boolean flag indicating whether the transformer is designated as a critical asset for grid reliability. Critical assets receive enhanced monitoring, maintenance priority, and security measures per NERC CIP standards.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent comprehensive inspection of the transformer. Used for tracking inspection compliance and scheduling future inspections.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or corrective maintenance activity performed on the transformer. Used for maintenance history tracking and interval planning.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the transformer location in decimal degrees. Used for spatial analysis, crew dispatch, and emergency response planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the transformer location in decimal degrees. Used for spatial analysis, crew dispatch, and emergency response planning.',
    `manufacture_year` STRING COMMENT 'Year the transformer was manufactured. Used for age-based risk assessment, depreciation calculations, and replacement planning.',
    `mva_rating` DECIMAL(18,2) COMMENT 'Nameplate power capacity rating of the transformer in megavolt-amperes. Represents the maximum apparent power the transformer can handle under specified conditions. Critical for transmission capacity planning and Available Transfer Capability (ATC) calculations.',
    `nerc_region` STRING COMMENT 'NERC regional entity jurisdiction where the transformer is located. Used for reliability compliance reporting, regional coordination, and regulatory oversight. [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|SPP|TRE — 8 candidates stripped; promote to reference product]',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity based on time-based or condition-based maintenance strategy.',
    `oil_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of insulating oil in the transformer in gallons. Used for oil replacement planning, environmental compliance reporting, and spill containment design. Null for dry-type transformers.',
    `operational_status` STRING COMMENT 'Current operational state of the transformer in the transmission network. In-service indicates active operation; standby indicates ready for service but not currently energized; maintenance indicates scheduled or unscheduled maintenance activities.. Valid values are `in_service|out_of_service|standby|maintenance|testing|decommissioned`',
    `ownership_type` STRING COMMENT 'Classification of ownership arrangement for the transformer. Owned assets are utility property; leased assets are rented; joint ownership involves multiple utilities; customer-owned transformers serve large industrial loads.. Valid values are `owned|leased|joint_ownership|customer_owned`',
    `pcb_contamination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the transformer contains or is contaminated with PCBs above regulatory thresholds. PCB-contaminated transformers require special handling, disposal procedures, and EPA reporting.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the transformer. Three-phase transformers are standard for bulk power transmission; single-phase units may be used in banks; phase-shifting transformers control power flow direction.. Valid values are `three_phase|single_phase|phase_shifting`',
    `primary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated voltage of the primary winding in kilovolts. Typically the higher voltage side for step-down transformers or the lower voltage side for step-up transformers.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transformer record was first created in the system. Used for data lineage tracking and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transformer record was last modified. Used for change tracking, data quality monitoring, and audit compliance.',
    `rto_iso_name` STRING COMMENT 'Name of the RTO or ISO that operates the transmission grid where this transformer is located. Examples include PJM, CAISO, MISO, NYISO, ISO-NE, SPP. Used for market operations, congestion management, and transmission rights tracking.',
    `scada_tag` STRING COMMENT 'Unique SCADA system tag identifier for real-time monitoring and control of the transformer. Links the asset record to telemetry data streams for operational monitoring, alarm management, and Energy Management System (EMS) integration.',
    `secondary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated voltage of the secondary winding in kilovolts. Typically the lower voltage side for step-down transformers or the higher voltage side for step-up transformers.',
    `tap_changer_type` STRING COMMENT 'Type of tap changer installed on the transformer. DETC (De-Energized Tap Changer) requires transformer to be offline for adjustment; LTC (Load Tap Changer) allows voltage adjustment under load. Critical for voltage regulation and grid stability.. Valid values are `DETC|LTC|none`',
    `tap_position_range` STRING COMMENT 'Available tap positions for voltage adjustment, typically expressed as a range (e.g., -10 to +10, or 1 to 33). Each tap position represents a discrete voltage adjustment step.',
    `tertiary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated voltage of the tertiary winding in kilovolts, if present. Tertiary windings are used for auxiliary loads, reactive power compensation, or harmonic filtering. Null if transformer has only two windings.',
    `transformer_installed_at_substation` BIGINT COMMENT 'FK to transmission.substation.substation_id — Every power transformer is physically installed at a specific substation. This is a fundamental topological relationship required for network modeling, outage impact analysis, and switching operations',
    `transformer_tag` STRING COMMENT 'Externally-known unique asset tag or equipment identifier assigned to the transformer for field identification and maintenance tracking. Typically follows utility naming convention.. Valid values are `^[A-Z0-9]{6,20}$`',
    `transformer_type` STRING COMMENT 'Classification of the transformer based on its functional role in the transmission network. Step-up transformers increase voltage from generation to transmission levels; step-down transformers reduce voltage for distribution or industrial loads.. Valid values are `step_up|step_down|autotransformer|phase_shifting|grounding|regulating`',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Total weight of the transformer in pounds including oil, core, windings, and tank. Critical for transportation planning, foundation design, and seismic analysis.',
    `winding_connection` STRING COMMENT 'Configuration of primary and secondary winding connections. Delta-wye and wye-delta are most common for transmission transformers. Affects voltage transformation ratio, phase shift, and harmonic performance.. Valid values are `delta_wye|wye_delta|delta_delta|wye_wye|zigzag`',
    CONSTRAINT pk_power_transformer PRIMARY KEY(`power_transformer_id`)
) COMMENT 'Master record for bulk power transformers installed at transmission substations. Captures transformer identifier, MVA rating, primary and secondary voltage (kV), impedance, cooling class (ONAN/ONAF), tap changer type, manufacturer, serial number, installation date, condition assessment score, and SCADA tag. Critical asset for transmission capacity and voltage regulation; feeds asset management and reliability reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`path` (
    `path_id` BIGINT COMMENT 'Primary key for path',
    `constraint_id` BIGINT COMMENT 'Foreign key linking to transmission.constraint. Business justification: Path can be subject to a regulatory or operational constraint; adding constraint_id FK enables direct association and eliminates ad‑hoc constraint code handling.',
    `line_id` BIGINT COMMENT 'FK to transmission.line.line_id — Transmission paths/flowgates are composed of one or more transmission lines. This is a many-to-many relationship critical for ATC calculations, congestion analysis, and outage impact assessment. The p',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Transmission paths are rated based on forecasted load conditions for seasonal transfer capability determination. Operations planning uses load forecasts to establish path ratings, calculate seasonal l',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Transmission paths have specific NERC MOD and FERC OATT obligations for ATC posting frequency, TTC calculation methodology, and reliability monitoring. Each path is subject to defined compliance requi',
    `available_transfer_capability_mw` DECIMAL(18,2) COMMENT 'Current available transmission capacity on the path for additional power transfers, calculated as total transfer capability minus existing transmission commitments and capacity benefit margin, measured in megawatts.',
    `average_loss_factor_percent` DECIMAL(18,2) COMMENT 'Average transmission energy loss rate across the path for typical power flow levels, expressed as a percentage. Used for transmission loss allocation in OATT billing.',
    `base_case_transfer_limit_mw` DECIMAL(18,2) COMMENT 'Normal operating transfer capability limit for the transmission path under base case system conditions, measured in megawatts. Represents the maximum power flow allowed without violating thermal, voltage, or stability criteria.',
    `capacity_benefit_margin_mw` DECIMAL(18,2) COMMENT 'Amount of transmission transfer capability reserved by load serving entities to ensure access to generation from interconnected systems to meet generation reliability requirements, measured in megawatts.',
    `congestion_status` STRING COMMENT 'Current congestion state of the transmission path indicating whether power flow is approaching or exceeding transfer limits, requiring congestion management actions.. Valid values are `uncongested|congested|critically_congested|constrained`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission path record was first created in the system.',
    `emergency_transfer_limit_mw` DECIMAL(18,2) COMMENT 'Maximum allowable power transfer on the transmission path under emergency operating conditions, measured in megawatts. Typically higher than base case limit and used for short durations during system contingencies.',
    `ems_integration_flag` BOOLEAN COMMENT 'Indicates whether the transmission path is integrated with the Energy Management System for state estimation, contingency analysis, and optimal power flow calculations. True if EMS-integrated, false otherwise.',
    `ferc_approved_loss_rate_flag` BOOLEAN COMMENT 'Indicates whether the transmission loss rates for this path have been approved by FERC as part of the Open Access Transmission Tariff (OATT). True if FERC-approved, false otherwise.',
    `flowgate_rating_mw` DECIMAL(18,2) COMMENT 'Thermal or stability rating of the flowgate (most limiting transmission element) on this path, measured in megawatts. Determines the path transfer capability.',
    `from_control_area_code` STRING COMMENT 'Code identifying the originating control area or balancing authority area for power flow on this transmission path.',
    `identifier` STRING COMMENT 'Externally-known business identifier for the transmission path used in operational communications, NERC reporting, and RTO/ISO scheduling. Examples include NERC-registered path names or internal path codes.',
    `in_service_date` DATE COMMENT 'Date when the transmission path was first placed into commercial operation and became available for power transfer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission path record was most recently updated, reflecting changes to path attributes, ratings, or operational parameters.',
    `last_rating_study_date` DATE COMMENT 'Date of the most recent transmission path rating study or transfer capability analysis conducted to determine current operating limits.',
    `length_miles` DECIMAL(18,2) COMMENT 'Physical length of the transmission path in miles, measured along the transmission line route from source to destination.',
    `loss_factor_effective_date` DATE COMMENT 'Date when the current transmission loss factors became effective for billing and settlement purposes.',
    `loss_factor_expiration_date` DATE COMMENT 'Date when the current transmission loss factors expire and are replaced by updated values, typically aligned with tariff revision cycles.',
    `loss_factor_period_type` STRING COMMENT 'Time-of-day period classification for transmission loss factors, distinguishing between peak demand hours and off-peak hours when losses differ due to loading levels.. Valid values are `peak|off_peak|super_peak|all_hours`',
    `loss_factor_season` STRING COMMENT 'Seasonal period for which the transmission loss factors are applicable, reflecting seasonal variations in system loading and ambient conditions.. Valid values are `summer|winter|spring|fall|annual`',
    `marginal_loss_factor_percent` DECIMAL(18,2) COMMENT 'Incremental transmission loss rate for an additional unit of power flow on this path, expressed as a percentage. Used in economic dispatch and locational marginal pricing calculations.',
    `nerc_path_designation` STRING COMMENT 'Official NERC-registered path designation or identifier used for reliability coordination and compliance reporting.',
    `nerc_reliability_coordinator` STRING COMMENT 'Name of the NERC Reliability Coordinator responsible for real-time monitoring and coordination of this transmission path to maintain bulk electric system reliability.',
    `next_rating_study_date` DATE COMMENT 'Scheduled date for the next transmission path rating study or transfer capability reassessment, typically required annually or after significant system changes.',
    `oatt_service_type` STRING COMMENT 'Type of transmission service offered on this path under the OATT: firm (guaranteed), non-firm (interruptible), network (integrated transmission service), or point-to-point (specific source to sink).. Valid values are `firm|non_firm|network|point_to_point`',
    `ownership_type` STRING COMMENT 'Classification of ownership structure for the transmission path assets: wholly owned, jointly owned with other utilities, leased from another entity, contracted capacity, or third-party owned.. Valid values are `owned|joint_owned|leased|contracted|third_party`',
    `path_description` STRING COMMENT 'Detailed textual description of the transmission path including geographic routing, major substations, transmission line segments, and operational characteristics.',
    `path_name` STRING COMMENT 'Human-readable name or designation of the transmission path, often reflecting geographic endpoints or operational significance.',
    `path_status` STRING COMMENT 'Current operational status of the transmission path in the transmission network lifecycle.. Valid values are `active|inactive|decommissioned|under_construction|planned`',
    `path_type` STRING COMMENT 'Classification of the transmission path based on its operational role: flowgate (constrained transmission element), interface (aggregated transfer capability boundary), corridor (multi-element transmission route), tie_line (interconnection between control areas), interconnection (connection to external grid), or internal (within control area).. Valid values are `flowgate|interface|corridor|tie_line|interconnection|internal`',
    `rto_iso_name` STRING COMMENT 'Name of the RTO or ISO that has operational authority or scheduling responsibility for this transmission path. Examples: PJM, CAISO, MISO, ERCOT, SPP, NYISO, ISO-NE.',
    `scada_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the transmission path is monitored in real-time through SCADA systems for power flow, voltage, and equipment status. True if SCADA-monitored, false otherwise.',
    `to_control_area_code` STRING COMMENT 'Code identifying the destination control area or balancing authority area for power flow on this transmission path.',
    `total_transfer_capability_mw` DECIMAL(18,2) COMMENT 'Maximum amount of electric power that can be transferred over the interconnected transmission network in a reliable manner while meeting all of a specific set of defined pre- and post-contingency system conditions, measured in megawatts.',
    `transmission_reliability_margin_mw` DECIMAL(18,2) COMMENT 'Amount of transmission transfer capability necessary to ensure that the interconnected transmission network is secure under a reasonable range of uncertainties in system conditions, measured in megawatts.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the transmission path in kilovolts. Common high-voltage transmission levels include 115kV, 138kV, 230kV, 345kV, 500kV, and 765kV.',
    CONSTRAINT pk_path PRIMARY KEY(`path_id`)
) COMMENT 'Defines a logical transmission path or flowgate between two electrical areas or control zones. Captures path identifier, from-area, to-area, associated transmission lines (flowgate elements), base case transfer limit (MW), emergency limit, NERC path designation, transmission loss factors (marginal/average loss percentage, seasonal/peak-off-peak differentiation, effective date range, FERC-approved loss rate), and interchange schedule records (RTO/ISO name, scheduling period, source/sink control area, e-tag identifier, scheduled/actual MW, curtailment status, settlement reference). SSOT for transmission path topology, transfer limits, loss allocation for OATT billing, and scheduled energy flows across control area boundaries supporting NERC BAL compliance and energy trading settlement.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` (
    `atc_calculation_id` BIGINT COMMENT 'Unique identifier for the ATC calculation record. Primary key for the ATC calculation transactional event.',
    `path_id` BIGINT COMMENT 'FK to transmission.path.path_id — Every ATC calculation is performed for a specific transmission path. This is the fundamental FK that connects ATC values to the network topology. Required for OASIS posting and OATT scheduling.',
    `atc_transmission_path_id` BIGINT COMMENT 'Identifier of the transmission path (flowgate or interface) for which ATC is calculated. Links to the transmission path master data.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: ATC calculation methodologies are audited for OATT compliance and NERC MOD standards adherence. FERC Order 890 requires periodic audits of ATC/AFC calculation processes and posting accuracy.',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: ATC calculations require load forecasts to determine available transfer capability under forecasted system conditions. Standard transmission operations planning process uses forecasted load to calcula',
    `employee_id` BIGINT COMMENT 'User ID or name of the transmission operator or engineer who validated and approved the ATC calculation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: ATC calculations support transmission revenue allocation to profit centers for financial performance tracking and FERC Form 1 revenue reporting by service type and functional area.',
    `state_estimation_run_id` BIGINT COMMENT 'Foreign key linking to grid.state_estimation_run. Business justification: ATC calculations require state estimator base case solutions for topology, power flow, and contingency analysis. NERC MOD standards mandate ATC calculations use validated EMS state estimation. New FK ',
    `trading_position_id` BIGINT COMMENT 'Foreign key linking to trading.position. Business justification: ATC calculations inform trading position limits on constrained transmission paths. Traders reference specific ATC results when sizing positions for transmission capacity hedging, required for position',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: Major transmission outages trigger ATC recalculations per FERC OATT requirements. Linking ATC calculations to the triggering outage enables automated recalculation workflows, regulatory audit trails, ',
    `atc_mw` DECIMAL(18,2) COMMENT 'Available Transfer Capability: the measure of the transfer capability remaining in the physical transmission network for further commercial activity over and above already committed uses. Calculated as TTC minus TRM minus CBM minus ETC. Measured in megawatts.',
    `base_case_generation_mw` DECIMAL(18,2) COMMENT 'Total system generation assumed in the base case power flow model used for the ATC calculation. Measured in megawatts.',
    `base_case_load_mw` DECIMAL(18,2) COMMENT 'Total system load assumed in the base case power flow model used for the ATC calculation. Measured in megawatts.',
    `calculation_methodology` STRING COMMENT 'Methodology used to calculate ATC: Rated System Path (RSP), Network Response (NR), Available Flowgate Capability (AFC), or other approved method per NERC standards.. Valid values are `rated_system_path|network_response|available_flowgate_capability|other`',
    `calculation_run_number` STRING COMMENT 'Unique identifier for the batch or scheduled run that produced this ATC calculation, enabling traceability to the calculation job or process instance.',
    `calculation_software` STRING COMMENT 'Name and version of the software application used to perform the ATC calculation (e.g., EMS application, power flow analysis tool, ATC calculation engine).',
    `calculation_timestamp` TIMESTAMP COMMENT 'Date and time when the ATC calculation was performed. Represents the principal business event time for this transactional record.',
    `calculation_type` STRING COMMENT 'Type of ATC calculation based on the time horizon: day-ahead, hour-ahead, real-time, monthly, or seasonal study.. Valid values are `day_ahead|hour_ahead|real_time|monthly|seasonal`',
    `cbm_mw` DECIMAL(18,2) COMMENT 'Capacity Benefit Margin: the amount of transmission transfer capability reserved for Load-Serving Entities to access generation from interconnected systems to meet generation reliability requirements. Measured in megawatts.',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations, or context related to this ATC calculation, such as special operating conditions or unusual circumstances.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ATC calculation record was first created in the system. Audit trail for record creation.',
    `ems_snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp of the EMS real-time or historical snapshot used as input data for the ATC calculation. Represents the system state at a specific point in time.',
    `etc_mw` DECIMAL(18,2) COMMENT 'Existing Transmission Commitments: the sum of all firm transmission service reservations, grandfathered rights, and other committed uses of the transmission system. Measured in megawatts.',
    `ferc_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this ATC calculation is subject to FERC reporting requirements under OATT compliance (True) or not (False).',
    `firm_atc_mw` DECIMAL(18,2) COMMENT 'ATC available for firm transmission service reservations, which have the highest priority and are not subject to curtailment except under emergency conditions. Measured in megawatts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ATC calculation record was last updated or modified. Audit trail for record changes.',
    `limit_type` STRING COMMENT 'Type of transmission system limit that constrains the ATC: thermal (line/transformer rating), voltage (bus voltage limit), stability (transient or dynamic stability), or other.. Valid values are `thermal|voltage|stability|other`',
    `limiting_contingency` STRING COMMENT 'Description or identifier of the transmission contingency (e.g., line outage, transformer outage) that limits the transfer capability for this path in this study.',
    `limiting_facility` STRING COMMENT 'Name or identifier of the transmission facility (line, transformer, flowgate) that reaches its thermal, voltage, or stability limit first, constraining the ATC value.',
    `nerc_reliability_region` STRING COMMENT 'NERC regional entity responsible for reliability coordination and compliance for this transmission path: WECC, ERCOT, MRO, NPCC, RF, SERC, SPP, or TRE. [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|SPP|TRE — 8 candidates stripped; promote to reference product]',
    `non_firm_atc_mw` DECIMAL(18,2) COMMENT 'ATC available for non-firm transmission service reservations, which are lower priority and subject to curtailment when firm service is needed. Measured in megawatts.',
    `oasis_posting_timestamp` TIMESTAMP COMMENT 'Date and time when the ATC value was posted to the OASIS system for public access by transmission customers.',
    `oatt_service_type` STRING COMMENT 'Type of transmission service under OATT for which this ATC is calculated: network integration service, point-to-point firm service, or point-to-point non-firm service.. Valid values are `network|point_to_point_firm|point_to_point_non_firm`',
    `operator_adjustment_mw` DECIMAL(18,2) COMMENT 'Manual adjustment applied by the transmission operator to the calculated ATC value based on operational judgment, real-time conditions, or reliability concerns. Measured in megawatts.',
    `operator_adjustment_reason` STRING COMMENT 'Explanation or justification for any manual operator adjustment applied to the ATC value, documenting the operational or reliability rationale.',
    `posting_status` STRING COMMENT 'Status of the ATC value posting to OASIS: pending (not yet posted), posted (published to OASIS), revised (updated after initial posting), or withdrawn (removed from OASIS).. Valid values are `pending|posted|revised|withdrawn`',
    `rto_iso_region` STRING COMMENT 'Name or code of the RTO or ISO region responsible for this transmission path and ATC calculation (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE).',
    `scada_data_quality` STRING COMMENT 'Quality indicator for the SCADA telemetry data used in the ATC calculation: good (reliable), suspect (questionable), stale (outdated), or unavailable (missing).. Valid values are `good|suspect|stale|unavailable`',
    `sink_ba_code` STRING COMMENT 'Code or identifier of the sink Balancing Authority to which power is being transferred on this transmission path.',
    `source_ba_code` STRING COMMENT 'Code or identifier of the source Balancing Authority from which power is being transferred on this transmission path.',
    `study_case_code` STRING COMMENT 'Identifier of the power flow or contingency analysis study case used as the basis for the ATC calculation. Links to the EMS or planning system study case.',
    `study_horizon_end` TIMESTAMP COMMENT 'Ending timestamp of the time horizon for which ATC is calculated. Defines the validity period of the ATC value.',
    `study_horizon_start` TIMESTAMP COMMENT 'Beginning timestamp of the time horizon for which ATC is calculated (e.g., start of the hour or day-ahead period).',
    `trm_mw` DECIMAL(18,2) COMMENT 'Transmission Reliability Margin: the amount of transmission transfer capability reserved to ensure that the interconnected transmission network is secure under a reasonable range of uncertainties in system conditions. Measured in megawatts.',
    `ttc_mw` DECIMAL(18,2) COMMENT 'Total Transfer Capability: the maximum amount of electric power that can be transferred over the transmission path in a reliable manner while meeting all reliability criteria. Measured in megawatts.',
    `uncertainty_margin_mw` DECIMAL(18,2) COMMENT 'Additional margin reserved to account for uncertainties in load forecast, generation dispatch, or system conditions not captured in TRM. Measured in megawatts.',
    `validation_status` STRING COMMENT 'Status of the ATC calculation validation process: validated (passed all checks), pending_review (awaiting engineer review), failed (did not pass validation rules), or override (validation failure overridden by operator).. Valid values are `validated|pending_review|failed|override`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the ATC calculation was validated and approved for posting to OASIS.',
    CONSTRAINT pk_atc_calculation PRIMARY KEY(`atc_calculation_id`)
) COMMENT 'Transactional record of Available Transfer Capability (ATC) calculations performed for a transmission path over a specific time horizon. Captures calculation timestamp, path identifier, Total Transfer Capability (TTC), Transmission Reliability Margin (TRM), Capacity Benefit Margin (CBM), Existing Transmission Commitments (ETC), resulting ATC value (MW), study methodology, and posting status for OASIS. Supports FERC OATT compliance and transmission scheduling.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` (
    `transmission_service_request_id` BIGINT COMMENT 'Unique identifier for the transmission service request under OATT (Open Access Transmission Tariff). Primary key for the transmission service request record.',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Transmission service requests require load forecasts for system impact studies to assess whether requested capacity can be accommodated under forecasted system conditions. OASIS study process uses loa',
    `ems_node_id` BIGINT COMMENT 'Pricing node identifier for the point of receipt, used for LMP (Locational Marginal Price) settlement and congestion management in RTO/ISO markets.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Transmission service requestors are trading counterparties. Unified counterparty management enables credit exposure aggregation across transmission reservations and energy trades for the same entity, ',
    `transmission_service_agreement_id` BIGINT COMMENT 'Identifier of the executed transmission service agreement (TSA) resulting from this approved request. Links the request to the binding service contract.',
    `ancillary_services_required` STRING COMMENT 'Comma-separated list of ancillary services required to support the transmission service (e.g., scheduling, system control, reactive supply, regulation, frequency response, operating reserve, energy imbalance).',
    `approval_date` DATE COMMENT 'Date when the transmission service request was formally approved by the transmission provider, granting transmission rights to the requestor.',
    `approved_capacity_mw` DECIMAL(18,2) COMMENT 'Amount of transmission capacity approved by the transmission provider in megawatts (MW). May differ from requested capacity based on ATC (Available Transfer Capability) and system impact study results.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission service request record was first created in the system. Used for audit trail and data lineage.',
    `denial_date` DATE COMMENT 'Date when the transmission service request was formally denied by the transmission provider due to insufficient ATC, reliability concerns, or other OATT-compliant reasons.',
    `denial_reason` STRING COMMENT 'Detailed explanation for denial of the transmission service request, citing specific OATT provisions, ATC constraints, or reliability standards that preclude approval.',
    `estimated_upgrade_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in US dollars for transmission system network upgrades required to accommodate the requested service, as determined by the facilities study.',
    `facilities_study_status` STRING COMMENT 'Status of the facilities study required to identify transmission system upgrades or network modifications needed to accommodate the requested service.. Valid values are `NOT-REQUIRED|PENDING|IN-PROGRESS|COMPLETED|WAIVED`',
    `ferc_docket_number` STRING COMMENT 'FERC docket reference number for any related transmission service dispute, complaint, or tariff filing associated with this request.. Valid values are `^(ER|EL|RM)[0-9]{2}-[0-9]{3,5}(-[0-9]{3})?$`',
    `ftr_allocation_flag` BOOLEAN COMMENT 'Indicates whether the approved transmission service includes allocation of Financial Transmission Rights for hedging congestion costs in RTO/ISO markets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission service request record was last updated. Tracks the most recent change to any field in the record.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this transmission service request record. Used for audit and accountability.',
    `nerc_reliability_region` STRING COMMENT 'NERC regional entity responsible for reliability coordination and compliance oversight for this transmission service (e.g., WECC, ERCOT, MRO, NPCC, RF, SERC, SPP, TRE). [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|SPP|TRE — 8 candidates stripped; promote to reference product]',
    `network_upgrade_required_flag` BOOLEAN COMMENT 'Indicates whether transmission system network upgrades are required to accommodate the requested service. True if facilities study identified necessary system enhancements.',
    `point_of_delivery_name` STRING COMMENT 'Name of the sink point or substation where power will be delivered from the transmission system for point-to-point service. May reference a PNode or substation.',
    `point_of_receipt_name` STRING COMMENT 'Name of the source point or substation where power will be received onto the transmission system for point-to-point service. May reference a PNode or substation.',
    `priority_level` STRING COMMENT 'OATT priority ranking for the transmission service request. Lower numbers indicate higher priority. Firm service typically has priority 1-6, non-firm service 7.',
    `queue_position` STRING COMMENT 'Sequential position of this request in the transmission service queue, determined by submission timestamp. Used for first-come-first-served processing under OATT rules.',
    `redirect_rights_flag` BOOLEAN COMMENT 'Indicates whether the transmission customer has the right to redirect the point of receipt or point of delivery during the service period, subject to ATC availability.',
    `request_number` STRING COMMENT 'Externally-known business identifier for the transmission service request, typically formatted as TSR-YYYYMMDD-NNNN. Used for OATT queue management and FERC reporting.. Valid values are `^TSR-[0-9]{8,12}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the transmission service request in the OATT queue. Tracks progression from submission through study, approval, or denial. [ENUM-REF-CANDIDATE: SUBMITTED|UNDER-STUDY|CONDITIONALLY-APPROVED|APPROVED|DENIED|WITHDRAWN|SUPERSEDED — 7 candidates stripped; promote to reference product]',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the transmission service request was formally submitted to the transmission provider. Determines queue position and priority under OATT first-come-first-served rules.',
    `requested_capacity_mw` DECIMAL(18,2) COMMENT 'Amount of transmission capacity requested in megawatts (MW). Represents the maximum power transfer capability sought under the transmission service agreement.',
    `requestor_contact_email` STRING COMMENT 'Email address of the primary contact for transmission service request communications and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_contact_name` STRING COMMENT 'Name of the primary contact person at the requesting entity for this transmission service request.',
    `requestor_contact_phone` STRING COMMENT 'Phone number of the primary contact for urgent transmission service request communications.. Valid values are `^+?[0-9]{10,15}$`',
    `resale_allowed_flag` BOOLEAN COMMENT 'Indicates whether the transmission customer is permitted to resell or reassign the transmission service capacity to a third party under OATT resale provisions.',
    `rollover_rights_flag` BOOLEAN COMMENT 'Indicates whether the transmission customer has rollover rights to renew the transmission service at the end of the service period under OATT right-of-first-refusal provisions.',
    `rto_iso_region` STRING COMMENT 'Name of the RTO or ISO region where the transmission service is requested (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE). Used for market coordination and FERC reporting.',
    `service_end_date` DATE COMMENT 'Requested end date for the transmission service. Defines the termination of the service period. Null for open-ended or evergreen NITS agreements.',
    `service_start_date` DATE COMMENT 'Requested start date for the transmission service. Defines the beginning of the service period for capacity reservation and scheduling rights.',
    `service_type` STRING COMMENT 'Type of transmission service requested: PTP-FIRM (Point-to-Point Firm), PTP-NON-FIRM (Point-to-Point Non-Firm), NITS (Network Integration Transmission Service), or SECONDARY (Secondary Network Service).. Valid values are `PTP-FIRM|PTP-NON-FIRM|NITS|SECONDARY`',
    `study_completion_date` DATE COMMENT 'Date when all required transmission service studies (system impact and facilities studies) were completed and results delivered to the requestor.',
    `study_required_flag` BOOLEAN COMMENT 'Indicates whether a system impact study or facilities study is required to evaluate the transmission service request. True if studies are needed to assess grid reliability impacts.',
    `system_impact_study_status` STRING COMMENT 'Status of the system impact study required to evaluate whether the requested transmission service can be provided without adversely affecting system reliability.. Valid values are `NOT-REQUIRED|PENDING|IN-PROGRESS|COMPLETED|WAIVED`',
    `withdrawal_date` DATE COMMENT 'Date when the transmission service request was voluntarily withdrawn by the requestor before approval or denial.',
    CONSTRAINT pk_transmission_service_request PRIMARY KEY(`transmission_service_request_id`)
) COMMENT 'Transactional record of a request for transmission service under OATT — point-to-point (PTP) or network integration transmission service (NITS). Captures request identifier, service type, requestor entity, source and sink points, requested capacity (MW), service start and end dates, priority, queue position, study requirements, approval status, and FERC docket reference. SSOT for OATT transmission service queue management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` (
    `transmission_service_agreement_id` BIGINT COMMENT 'Unique identifier for the transmission service agreement. Primary key for this entity.',
    `billing_service_agreement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_service_agreement. Business justification: Each transmission service agreement (OATT contract) has a corresponding billing service agreement for invoicing and AR management. Real business process: transmission revenue billing creates invoices ',
    `fuel_supply_contract_id` BIGINT COMMENT 'Foreign key linking to supply.fuel_supply_contract. Business justification: Network transmission service agreements for generators must reference fuel supply contracts to validate transmission capacity reservations align with fuel delivery capabilities, scheduling constraints',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to finance.receivable. Business justification: Service agreements generate receivables for transmission capacity charges billed monthly to customers. Links transmission commercial operations to accounts receivable management and revenue recognitio',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Long-term firm transmission service agreements require FERC Section 205 rate filings for approval. Service agreements with non-standard terms or rates trigger mandatory regulatory filings and docket t',
    `transmission_customer_id` BIGINT COMMENT 'Reference to the transmission customer entity that is party to this agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the transmission service agreement, typically formatted as TSA- prefix followed by alphanumeric code.. Valid values are `^TSA-[A-Z0-9]{8,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the transmission service agreement.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `amendment_count` STRING COMMENT 'Total number of amendments executed against this transmission service agreement since original execution.',
    `ancillary_services_included` STRING COMMENT 'Comma-separated list of ancillary services included in this transmission service agreement (e.g., scheduling, system control, reactive supply, regulation, frequency response, energy imbalance, operating reserve).',
    `billing_cycle` STRING COMMENT 'Frequency of billing for this transmission service agreement.. Valid values are `monthly|quarterly|annual`',
    `collateral_amount_usd` DECIMAL(18,2) COMMENT 'Amount of financial collateral required in USD, if applicable.',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether financial collateral is required from the transmission customer for this agreement.',
    `contract_document_reference` STRING COMMENT 'Reference to the physical or electronic contract document storage location (e.g., document management system identifier, file path).',
    `contracted_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum transmission capacity in megawatts (MW) contracted under this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission service agreement record was first created in the system.',
    `credit_rating` STRING COMMENT 'Credit rating of the transmission customer at the time of agreement execution, used for credit assessment and collateral requirements.',
    `energy_charge_rate_usd_per_mwh` DECIMAL(18,2) COMMENT 'Energy transmission charge rate in USD per megawatt-hour (MWh) for actual energy throughput.',
    `executed_date` DATE COMMENT 'Date when this transmission service agreement was formally executed by all parties.',
    `ferc_docket_number` STRING COMMENT 'FERC docket number assigned to the regulatory filing for this transmission service agreement.',
    `ferc_filing_date` DATE COMMENT 'Date when this transmission service agreement was filed with FERC for regulatory approval.',
    `ferc_filing_status` STRING COMMENT 'Status of FERC regulatory filing for this transmission service agreement.. Valid values are `not_filed|filed|accepted|rejected|amended`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to this transmission service agreement.',
    `last_amendment_description` STRING COMMENT 'Brief description of the most recent amendment to this transmission service agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission service agreement record was last modified in the system.',
    `monthly_capacity_charge_usd` DECIMAL(18,2) COMMENT 'Monthly capacity reservation charge in USD based on contracted MW capacity.',
    `nerc_reliability_region` STRING COMMENT 'NERC reliability region applicable to this transmission service agreement. [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|TRE|SPP — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-form notes or comments regarding this transmission service agreement for internal reference.',
    `oatt_tariff_version` STRING COMMENT 'Version of the OATT tariff under which this transmission service agreement was executed.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due.',
    `priority_ranking` STRING COMMENT 'Priority ranking for curtailment purposes, with lower numbers indicating higher priority. Firm service typically has priority over non-firm.',
    `rate_schedule_reference` STRING COMMENT 'Reference to the applicable OATT rate schedule governing pricing for this transmission service agreement.',
    `responsible_account_manager` STRING COMMENT 'Name of the account manager or business relationship owner responsible for this transmission service agreement.',
    `rollover_rights_flag` BOOLEAN COMMENT 'Indicates whether the transmission customer has rollover rights to renew this agreement at expiration.',
    `rto_iso_region` STRING COMMENT 'RTO or ISO region in which this transmission service agreement operates (e.g., PJM, MISO, CAISO, ERCOT, SPP, NYISO, ISO-NE).',
    `service_subtype` STRING COMMENT 'Subtype classification of transmission service indicating priority and curtailment rights: firm (guaranteed), non-firm (interruptible), or conditional firm.. Valid values are `firm|non-firm|conditional_firm`',
    `service_type` STRING COMMENT 'Type of transmission service under OATT: PTP (Point-to-Point Transmission Service) or NITS (Network Integration Transmission Service).. Valid values are `PTP|NITS`',
    `sink_point_of_delivery` STRING COMMENT 'Designated point of delivery (POD) or sink location where power exits the transmission system under this agreement.',
    `source_point_of_receipt` STRING COMMENT 'Designated point of receipt (POR) or source location where power enters the transmission system under this agreement.',
    `term_end_date` DATE COMMENT 'Scheduled end date when the transmission service agreement expires. Nullable for open-ended or evergreen agreements.',
    `term_start_date` DATE COMMENT 'Effective start date when the transmission service agreement becomes binding and service begins.',
    `termination_date` DATE COMMENT 'Actual date when this transmission service agreement was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for termination of this transmission service agreement (e.g., customer request, non-payment, breach of terms, expiration).',
    CONSTRAINT pk_transmission_service_agreement PRIMARY KEY(`transmission_service_agreement_id`)
) COMMENT 'Master record for executed transmission service agreements under OATT including associated billing and invoicing. Captures agreement identifier, customer entity, service type (PTP/NITS), contracted capacity (MW), source and sink points, term start and end dates, rate schedule reference, billing determinants, FERC filing status, amendment history, and invoice records (invoice identifier, billing period, billed capacity in MW-months, energy throughput in MWh, ancillary service charges, total amount due, invoice date, due date, payment status). SSOT for transmission customer contractual entitlements and transmission revenue billing within the OATT commercial lifecycle, distinct from retail billing domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` (
    `ftr_position_id` BIGINT COMMENT 'Unique identifier for the FTR position record. Primary key for the FTR position master data.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: FTR positions are valued using energy price forecasts for mark-to-market accounting, portfolio risk assessment, and hedging strategy decisions. Treasury and trading functions require price forecasts t',
    `ferc_market_report_id` BIGINT COMMENT 'Foreign key linking to compliance.ferc_market_report. Business justification: FTR positions and settlements must be reported in FERC Electric Quarterly Reports (EQR) per 18 CFR 35.41. Market participants report FTR auction results, holdings, and settlement credits quarterly.',
    `ftr_holding_id` BIGINT COMMENT 'Foreign key linking to trading.ftr_holding. Business justification: FTR positions in transmission operations represent the same financial instruments managed as trading holdings. Energy utilities track transmission FTR positions that feed trading portfolio management ',
    `path_id` BIGINT COMMENT 'FK to transmission.path.path_id — FTR positions are defined between source and sink points that map to transmission paths. Required for congestion revenue hedging and settlement reconciliation.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Renewable generators and their offtakers routinely acquire FTR positions to hedge congestion risk between generation source and delivery sink specified in PPAs. This is standard risk management practi',
    `original_ftr_position_id` BIGINT COMMENT 'Reference to the original FTR position identifier if this position was created through reconfiguration or modification of an existing position. Null for positions acquired directly from auction.',
    `primary_path_id` BIGINT COMMENT 'FK to transmission.path.path_id — FTR positions hedge congestion on specific source-sink paths. This FK connects financial hedges to physical network elements.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: FTR positions are financial instruments assigned to profit centers for P&L tracking, mark-to-market valuation, and financial performance reporting. Required for ISO market settlement reconciliation.',
    `arr_conversion_flag` BOOLEAN COMMENT 'Indicates whether this FTR position was acquired through conversion of an Auction Revenue Right (ARR) allocation. ARRs are allocated to load-serving entities and can be converted to FTRs in annual auctions.',
    `arr_identifier` STRING COMMENT 'Identifier of the ARR that was converted to create this FTR position, if applicable. Null for FTRs acquired directly through auction.',
    `auction_clearing_price_per_mw` DECIMAL(18,2) COMMENT 'Price per MW at which this FTR position cleared in the auction, denominated in USD per MW for the contract period. Represents the upfront cost paid to acquire the FTR hedge.',
    `auction_date` DATE COMMENT 'Date on which the FTR auction was conducted and this position was awarded.',
    `auction_round` STRING COMMENT 'Identifier for the FTR auction round in which this position was acquired. Typically includes auction type (annual, monthly, reconfiguration) and period designation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTR position record was first created in the system.',
    `cumulative_settlement_credit_usd` DECIMAL(18,2) COMMENT 'Total cumulative congestion revenue credits or charges for this FTR position since effective start date, denominated in USD. Used to track overall hedge performance.',
    `effective_end_date` DATE COMMENT 'Date on which the FTR position expires and ceases to accrue congestion revenue. Typically aligned with auction period boundaries (end of month, end of planning year).',
    `effective_start_date` DATE COMMENT 'Date on which the FTR position becomes effective and begins accruing congestion revenue credits or charges.',
    `ferc_reporting_category` STRING COMMENT 'FERC reporting classification for this FTR position, used for regulatory compliance reporting under FERC Form 1 and FERC Electric Quarterly Reports (EQR).',
    `flow_direction` STRING COMMENT 'Direction of power flow for the FTR position. Prevailing flow aligns with typical congestion patterns; counter-flow opposes typical patterns and may have lower auction prices.. Valid values are `prevailing|counter-flow`',
    `ftr_identifier` STRING COMMENT 'Externally-known unique identifier for the FTR position as assigned by the RTO/ISO market system. Used for market settlement reconciliation and external reporting.',
    `ftr_type` STRING COMMENT 'Type of FTR position held. Obligation FTRs pay or charge the holder based on congestion price differences; Option FTRs only pay when positive, with no charge when negative.. Valid values are `obligation|option`',
    `hedge_strategy_code` STRING COMMENT 'Code identifying the hedging strategy or business purpose for acquiring this FTR position. Examples include load-serving hedge, generation hedge, merchant arbitrage, portfolio optimization.',
    `holding_entity_name` STRING COMMENT 'Name of the legal entity or business unit that holds this FTR position. May be the utility itself or a transmission customer.',
    `holding_entity_type` STRING COMMENT 'Classification of the entity holding the FTR position. Utility positions are held for internal hedging; transmission customer positions are held by external market participants.. Valid values are `utility|transmission_customer|affiliate|third_party`',
    `internal_book_code` STRING COMMENT 'Internal accounting book or cost center code to which this FTR position is assigned for financial reporting and cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTR position record was last updated in the system.',
    `last_settlement_date` DATE COMMENT 'Date of the most recent settlement calculation for this FTR position. Typically monthly for ongoing positions.',
    `monthly_settlement_credit_usd` DECIMAL(18,2) COMMENT 'Total congestion revenue credit received for this FTR position in the most recent monthly settlement, denominated in USD. Positive values represent credits; negative values represent charges (for obligation FTRs only).',
    `mw_quantity` DECIMAL(18,2) COMMENT 'Quantity of transmission capacity in megawatts covered by this FTR position. Determines the magnitude of congestion revenue credits or charges.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this FTR position, including hedging rationale, special conditions, or settlement exceptions.',
    `on_peak_off_peak_designation` STRING COMMENT 'Time-of-use designation for the FTR position. On-peak FTRs cover weekday business hours; off-peak FTRs cover nights and weekends; 24-hour FTRs cover all hours.. Valid values are `on-peak|off-peak|24-hour`',
    `portfolio_grouping` STRING COMMENT 'Business grouping or portfolio designation for this FTR position. Used to aggregate positions for risk management, hedging strategy analysis, and financial reporting.',
    `position_status` STRING COMMENT 'Current lifecycle status of the FTR position. Active positions are in-force and subject to settlement; expired positions have reached their end date; settled positions have completed final financial settlement; cancelled positions were terminated before expiration.. Valid values are `active|expired|settled|cancelled|pending`',
    `reconfiguration_flag` BOOLEAN COMMENT 'Indicates whether this FTR position was acquired through a reconfiguration auction, which allows holders to modify existing positions mid-period.',
    `rto_iso_market_code` STRING COMMENT 'Identifier for the RTO or ISO market in which this FTR position was acquired and is settled. Examples include PJM, MISO, CAISO, ERCOT, NYISO, ISO-NE, SPP.',
    `rto_iso_market_name` STRING COMMENT 'Human-readable name of the RTO or ISO market.',
    `sink_pnode_code` STRING COMMENT 'Identifier for the sink pricing node (withdrawal point) of the FTR path. Congestion revenue is calculated based on the Locational Marginal Price (LMP) difference between source and sink PNodes.',
    `sink_pnode_name` STRING COMMENT 'Human-readable name of the sink pricing node for the FTR path.',
    `source_pnode_code` STRING COMMENT 'Identifier for the source pricing node (injection point) of the FTR path. Congestion revenue is calculated based on the Locational Marginal Price (LMP) difference between source and sink PNodes.',
    `source_pnode_name` STRING COMMENT 'Human-readable name of the source pricing node for the FTR path.',
    `trading_hub_flag` BOOLEAN COMMENT 'Indicates whether either the source or sink PNode is a major trading hub. Hub-based FTRs typically have higher liquidity and more predictable congestion patterns.',
    CONSTRAINT pk_ftr_position PRIMARY KEY(`ftr_position_id`)
) COMMENT 'Master record for Financial Transmission Rights (FTR) positions held by the utility or transmission customers as congestion revenue hedges. Captures FTR identifier, auction round and period, obligation or option type, source PNode, sink PNode, MW quantity, direction (prevailing/counter-flow), auction clearing price ($/MW), monthly settlement credits/charges, RTO/ISO market identifier, portfolio grouping, and expiration date. Supports congestion cost hedging strategy, day-ahead market settlement reconciliation, and ARR-to-FTR conversion tracking.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` (
    `congestion_event_id` BIGINT COMMENT 'Unique identifier for the transmission congestion event record. Primary key for the congestion event entity.',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: Transmission outages frequently cause congestion events (flowgate binding, shadow prices). Linking congestion to the causal outage enables root cause analysis, market settlement dispute resolution, an',
    `path_id` BIGINT COMMENT 'FK to transmission.path.path_id — Congestion events occur on specific transmission paths/flowgates. Required for congestion cost analysis, FTR settlement, and FERC reporting.',
    `congestion_transmission_path_id` BIGINT COMMENT 'Identifier of the transmission path affected by congestion, representing the source-to-sink corridor where power flow is constrained.',
    `contingency_element_id` BIGINT COMMENT 'Identifier of the contingency element (the element whose outage would cause the monitored element to exceed its limit), if the congestion is contingency-based.',
    `ems_event_id` BIGINT COMMENT 'Identifier of the corresponding event in the Energy Management System, used for cross-system event correlation and analysis.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Congestion events are analyzed against energy price forecasts for FTR valuation, hedging strategy assessment, and portfolio risk management. Market operations teams use historical congestion patterns ',
    `ferc_market_report_id` BIGINT COMMENT 'Foreign key linking to compliance.ferc_market_report. Business justification: Congestion events, shadow prices, and LMP differentials are reportable market data in FERC EQR filings. ISO/RTO market participants report congestion costs and transmission constraint binding frequenc',
    `flowgate_id` BIGINT COMMENT 'Identifier of the transmission flowgate or monitored facility experiencing congestion. A flowgate is a mathematical construct representing one or more transmission elements that may limit power flow.',
    `ftr_holding_id` BIGINT COMMENT 'Foreign key linking to trading.ftr_holding. Business justification: Congestion events directly impact FTR settlement payouts. Trading desks link congestion events to FTR holdings to calculate actual vs expected hedge performance, required for mark-to-market valuation,',
    `ftr_position_id` BIGINT COMMENT 'Identifier of the Financial Transmission Right position associated with the congested path, used for FTR settlement reconciliation.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Congestion revenue and costs are allocated to profit centers for financial reporting and performance management. Supports ISO market settlement accounting and transmission revenue tracking.',
    `pnode_id` BIGINT COMMENT 'Identifier of the source pricing node (PNode) at the origin of the congested transmission path, used for LMP calculation.',
    `binding_constraint_code` STRING COMMENT 'Identifier of the specific binding constraint in the security-constrained economic dispatch that triggered the congestion event.',
    `congestion_cost_usd` DECIMAL(18,2) COMMENT 'Total congestion cost in USD for the event, calculated as the product of curtailed MW, event duration, and shadow price or LMP differential.',
    `congestion_direction` STRING COMMENT 'Direction of the congestion on the transmission path: forward (source to sink), reverse (sink to source), or bidirectional (constrained in both directions).. Valid values are `forward|reverse|bidirectional`',
    `congestion_end_timestamp` TIMESTAMP COMMENT 'Date and time when the transmission congestion event ended, marking the point at which the constraint was no longer binding or the event was resolved.',
    `congestion_severity` STRING COMMENT 'Severity classification of the congestion event based on shadow price, curtailed MW, and duration: low, moderate, high, or critical.. Valid values are `low|moderate|high|critical`',
    `congestion_start_timestamp` TIMESTAMP COMMENT 'Date and time when the transmission congestion event began, marking the point at which the flowgate or path became binding in the dispatch model.',
    `constraint_type` STRING COMMENT 'Type of transmission constraint that caused the congestion: thermal (line rating), voltage (voltage limit), stability (transient or dynamic stability), interface (multi-element limit), or nomogram (multi-dimensional operating limit).. Valid values are `thermal|voltage|stability|interface|nomogram`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the congestion event record was first created in the system, used for audit trail and data lineage tracking.',
    `curtailed_mw` DECIMAL(18,2) COMMENT 'Amount of power in megawatts that was curtailed or redispatched to relieve the congestion on the affected flowgate or path.',
    `element_rating_mw` DECIMAL(18,2) COMMENT 'Thermal or operational rating of the monitored transmission element in megawatts, representing the maximum allowable flow under the applicable rating methodology (normal, emergency, or seasonal).',
    `event_cause` STRING COMMENT 'Primary cause of the congestion event: high demand, generation outage, transmission outage, renewable energy variability, loop flow, unscheduled flow, or market condition. [ENUM-REF-CANDIDATE: high_demand|generation_outage|transmission_outage|renewable_variability|loop_flow|unscheduled_flow|market_condition — 7 candidates stripped; promote to reference product]',
    `event_duration_minutes` STRING COMMENT 'Total duration of the congestion event in minutes, calculated as the difference between start and end timestamps.',
    `event_number` STRING COMMENT 'Business identifier for the congestion event, typically assigned by the RTO/ISO or EMS system for external reference and reporting.',
    `event_status` STRING COMMENT 'Current status of the congestion event in the event management lifecycle: active (ongoing), resolved (cleared), under review (post-event analysis), or escalated (requires higher-level intervention).. Valid values are `active|resolved|under_review|escalated`',
    `ferc_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the congestion event meets FERC reporting thresholds and must be included in quarterly or annual transmission congestion reports.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the congestion event record was last modified, used for audit trail and change tracking.',
    `lmp_differential_usd_per_mwh` DECIMAL(18,2) COMMENT 'Difference between sink LMP and source LMP, representing the congestion component of the price spread across the transmission path.',
    `market_interval_timestamp` TIMESTAMP COMMENT 'Timestamp of the RTO/ISO market interval (typically 5-minute or hourly) during which the congestion event occurred or was recorded.',
    `market_type` STRING COMMENT 'Type of wholesale electricity market in which the congestion event occurred: day-ahead market (DAM), real-time market (RTM), intra-day market, or ancillary services market.. Valid values are `day_ahead|real_time|intra_day|ancillary_services`',
    `monitored_element_code` STRING COMMENT 'Identifier of the specific transmission element (line, transformer, or interface) that was monitored and became binding during the congestion event.',
    `nerc_reliability_region` STRING COMMENT 'NERC reliability region in which the congestion event occurred (e.g., WECC, ERCOT, MRO, NPCC, RF, SERC, TRE, FRCC).',
    `operator_notes` STRING COMMENT 'Free-text notes entered by transmission operators or market operators describing the congestion event, actions taken, and any special circumstances.',
    `percent_of_rating` DECIMAL(18,2) COMMENT 'Percentage of the element rating at which the monitored element was operating during the congestion event, calculated as (flow / rating) * 100.',
    `post_contingency_flow_mw` DECIMAL(18,2) COMMENT 'Projected power flow in megawatts on the monitored element following the contingency event, used in security-constrained dispatch.',
    `pre_contingency_flow_mw` DECIMAL(18,2) COMMENT 'Power flow in megawatts on the monitored element under normal (pre-contingency) conditions during the congestion event.',
    `remedial_action_taken` STRING COMMENT 'Type of remedial action taken to relieve the congestion: economic redispatch, Transmission Loading Relief (TLR), load curtailment, voltage control, phase shifter adjustment, topology change, or none. [ENUM-REF-CANDIDATE: redispatch|tlr|curtailment|voltage_control|phase_shifter|topology_change|none — 7 candidates stripped; promote to reference product]',
    `rto_iso_region` STRING COMMENT 'Name or code of the RTO or ISO region in which the congestion event occurred (e.g., PJM, MISO, CAISO, ERCOT, NYISO, ISO-NE, SPP).',
    `scada_alarm_code` STRING COMMENT 'Identifier of the SCADA alarm that triggered or was associated with the congestion event, linking the event to real-time grid monitoring systems.',
    `shadow_price_usd_per_mwh` DECIMAL(18,2) COMMENT 'Shadow price or marginal congestion cost in USD per MWh associated with the binding constraint. Represents the incremental cost of relieving the congestion by one MWh.',
    `sink_lmp_usd_per_mwh` DECIMAL(18,2) COMMENT 'Locational Marginal Price at the sink PNode during the congestion event, representing the cost of delivering one additional MWh at that location.',
    `sink_pnode_code` STRING COMMENT 'Identifier of the sink pricing node (PNode) at the destination of the congested transmission path, used for LMP calculation.',
    `source_lmp_usd_per_mwh` DECIMAL(18,2) COMMENT 'Locational Marginal Price at the source PNode during the congestion event, representing the cost of delivering one additional MWh at that location.',
    `source_system` STRING COMMENT 'Name or code of the source system that generated the congestion event record (e.g., EMS, market management system, SCADA historian).',
    `tlr_level` STRING COMMENT 'NERC Transmission Loading Relief level invoked during the congestion event (e.g., TLR 1, TLR 2, TLR 3a, TLR 3b, TLR 4, TLR 5a, TLR 5b, TLR 6), if applicable.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of the congestion event that may have contributed to the constraint (e.g., high temperature reducing line ratings, storm causing outages). [ENUM-REF-CANDIDATE: normal|high_temperature|low_temperature|high_wind|storm|ice|fog — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_congestion_event PRIMARY KEY(`congestion_event_id`)
) COMMENT 'Transactional record of a transmission congestion event on a specific path or flowgate where physical power flow constraints cause economic dispatch deviations. Captures event identifier, affected path or flowgate, start and end timestamps, congestion direction, shadow price ($/MWh), curtailed MW, LMP differential between source and sink nodes, RTO/ISO market interval, binding constraint identifier, and remedial action taken (redispatch, TLR, curtailment). Used for congestion cost analysis, FTR settlement reconciliation, Transmission Loading Relief (TLR) tracking, and FERC reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` (
    `transmission_outage_id` BIGINT COMMENT 'Unique identifier for the transmission outage event. Primary key for the transmission outage record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outage restoration costs are charged to specific cost centers for budget variance analysis and operational expense tracking. Essential for O&M cost management and regulatory expense reporting.',
    `crew_id` BIGINT COMMENT 'Reference to the maintenance or emergency crew assigned to address the outage and perform restoration work.',
    `ems_alarm_id` BIGINT COMMENT 'Foreign key linking to grid.ems_alarm. Business justification: Transmission outages trigger EMS alarms (breaker status, voltage violations). Linking enables automated outage-to-alarm correlation for NERC event reporting (OE-417), operator situational awareness, a',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: Transmission outages must link to enterprise outage management for unified incident tracking, NERC/FERC regulatory reporting, customer impact analysis, and cross-domain restoration coordination. Real-',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Major transmission outages often have dedicated internal orders for cost collection, tracking, and settlement to appropriate GL accounts. Supports project-based cost accounting for significant restora',
    `registry_id` BIGINT COMMENT 'Reference to the transmission facility (line, transformer, circuit breaker, or other equipment) experiencing the outage.',
    `regulatory_correspondence_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_correspondence. Business justification: Major transmission outages generate regulatory inquiries from FERC, NERC, or state commissions requiring formal correspondence responses. DOE Form OE-417 submissions and follow-up correspondence are t',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Outage restoration crews draw materials from designated emergency restoration warehouses. Operations teams track source warehouse for inventory replenishment planning, mutual aid material tracking, an',
    `self_report_id` BIGINT COMMENT 'Foreign key linking to compliance.self_report. Business justification: Transmission outages meeting NERC reportable criteria (BES facility outages, load loss >300MW, etc.) trigger mandatory self-reports to regional entities within 24 hours per NERC Rules of Procedure Sec',
    `storm_event_id` BIGINT COMMENT 'Reference to a major storm event if the outage was storm-related. Links to enterprise storm tracking and mutual aid coordination.',
    `atc_impact_mw` DECIMAL(18,2) COMMENT 'Reduction in Available Transfer Capability in megawatts caused by the outage. Used for OASIS posting and market participant notification.',
    `bes_facility_flag` BOOLEAN COMMENT 'Indicates whether the facility is classified as part of the Bulk Electric System under NERC definitions. Determines applicability of reliability standards.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the outage (e.g., equipment failure, weather, human error, vegetation). Aligned with NERC cause code taxonomy.',
    `cause_description` STRING COMMENT 'Detailed narrative description of the outage cause, including contributing factors and circumstances. Supports root cause analysis and lessons learned.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created the outage record. Supports accountability and audit trail requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the outage record was first created in the system. Audit trail for data lineage and compliance.',
    `customer_impact_count` STRING COMMENT 'Estimated number of end-use customers indirectly affected by the transmission outage through cascading distribution impacts or load shedding.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the outage event in hours, calculated from start to end timestamp. Key metric for transmission availability reporting.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the transmission facility was restored to service. Null for active outages. Used for duration and availability calculations.',
    `equipment_age_years` STRING COMMENT 'Age of the failed or outaged equipment in years at the time of the outage. Used for asset health analysis and replacement planning.',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD to repair or replace the failed equipment and restore the facility. Used for financial planning and insurance claims.',
    `facility_type` STRING COMMENT 'Classification of the transmission facility experiencing the outage. Determines applicable reliability standards and reporting requirements.. Valid values are `transmission_line|transformer|circuit_breaker|bus|capacitor_bank|reactor`',
    `ferc_reportable_flag` BOOLEAN COMMENT 'Indicates whether the outage requires reporting to FERC under transmission service or reliability standards.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed on the facility prior to the outage. Used to assess maintenance effectiveness.',
    `load_shed_mw` DECIMAL(18,2) COMMENT 'Amount of customer load in megawatts that was shed or curtailed as a result of the transmission outage. Critical for reliability and regulatory reporting.',
    `mw_impact` DECIMAL(18,2) COMMENT 'Estimated transmission capacity reduction in megawatts due to the outage. Used for congestion analysis and market impact assessment.',
    `nerc_outage_reporting_code` STRING COMMENT 'NERC-defined code indicating whether the outage meets criteria for mandatory reporting under NERC standards (e.g., OE-417 reportable event).',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Indicates whether the outage meets NERC criteria for mandatory reporting to DOE via OE-417 form (e.g., loss of firm load, BES facility outage exceeding thresholds).',
    `oe417_report_number` STRING COMMENT 'DOE OE-417 report number if the outage was reported to the Department of Energy. Links to federal emergency and disturbance reporting.',
    `outage_number` STRING COMMENT 'Business identifier for the transmission outage event, typically used in operational communications and reporting to RTOs/ISOs.',
    `outage_status` STRING COMMENT 'Current lifecycle state of the transmission outage event. Tracks progression from scheduling through restoration.. Valid values are `scheduled|active|restored|cancelled|extended`',
    `outage_type` STRING COMMENT 'Classification of the outage event indicating whether it was scheduled in advance (planned/maintenance) or occurred unexpectedly (forced/emergency). Critical for reliability metrics calculation.. Valid values are `planned|forced|maintenance|emergency|testing|regulatory`',
    `restoration_method` STRING COMMENT 'Description of the method used to restore the facility (e.g., repair, replacement, temporary bypass, switching operation).',
    `restoration_priority` STRING COMMENT 'Priority level assigned to the restoration effort based on system impact, customer criticality, and reliability considerations.. Valid values are `critical|high|medium|low`',
    `rto_iso_notification_status` STRING COMMENT 'Status of notification to the RTO/ISO. Tracks compliance with coordination timelines and communication protocols.. Valid values are `notified|pending|not_required|delayed`',
    `rto_iso_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the RTO/ISO was notified of the outage event. Required for compliance with outage coordination procedures.',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO region where the outage occurred (e.g., PJM, MISO, CAISO, ERCOT, SPP). Determines coordination and reporting requirements.',
    `safety_clearance_number` STRING COMMENT 'Safety clearance or hold number issued to protect workers during the outage. Ensures compliance with OSHA and utility safety protocols.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Originally planned restoration date and time for planned outages. Used to track schedule adherence and identify extensions.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Originally planned start date and time for planned outages. Used to track schedule adherence and coordination accuracy.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the transmission facility was taken out of service or when the forced outage occurred. Used for duration calculations and reliability reporting.',
    `switching_order_number` STRING COMMENT 'Switching order number authorizing the isolation and restoration of the transmission facility. Critical for operational safety and coordination.',
    `temperature_f` DECIMAL(18,2) COMMENT 'Ambient temperature in Fahrenheit at the time of the outage. Used for equipment performance analysis and thermal rating assessments.',
    `updated_by_user` STRING COMMENT 'User identifier or system account that last modified the outage record. Supports accountability and change tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the outage record was last modified. Tracks changes to outage status, duration, or other attributes throughout the lifecycle.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Operating voltage level in kilovolts of the transmission facility experiencing the outage. Determines BES classification and reporting requirements.',
    `weather_condition` STRING COMMENT 'Weather conditions at the time of the outage (e.g., clear, rain, snow, ice, wind, lightning). Important for cause analysis and predictive modeling.',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour at the time of the outage. Critical for weather-related outage analysis and line rating calculations.',
    `work_order_number` STRING COMMENT 'Work order or job number associated with the outage event, linking to asset management and maintenance systems.',
    CONSTRAINT pk_transmission_outage PRIMARY KEY(`transmission_outage_id`)
) COMMENT 'Transactional record of planned and forced outages on transmission facilities (lines, transformers, protection devices). Captures outage identifier, facility reference, outage type (planned/forced/maintenance), start and end timestamps, cause code, MW impact, affected paths, RTO/ISO notification status, NERC outage reporting code, restoration actions, and crew reference. Feeds transmission reliability indices and NERC OE-417 reporting. Note: this product captures transmission-specific outage events; the outage domain owns the enterprise outage management platform and customer-facing restoration workflow.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` (
    `transmission_switching_order_id` BIGINT COMMENT 'Unique identifier for the transmission switching order. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this switching order record. Supports audit trail and change management compliance.',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to supply.goods_issue. Business justification: Switching orders requiring materials (protective equipment, temporary jumpers, fuses, grounding equipment) trigger goods issues from warehouse stock. Direct operational linkage for material cost alloc',
    `outage_switching_order_id` BIGINT COMMENT 'Foreign key linking to outage.outage_switching_order. Business justification: Transmission switching orders executed during outage restoration must link to OMS switching order tracking for unified crew coordination, safety clearance management, and NERC CIP compliance. Real-wor',
    `state_estimation_run_id` BIGINT COMMENT 'Foreign key linking to grid.state_estimation_run. Business justification: Switching orders require pre-switching state estimation to validate topology changes, ensure voltage/thermal limits, and comply with NERC CIP-005 (electronic security perimeter changes). New FK captur',
    `primary_transmission_employee_id` BIGINT COMMENT 'Identifier of the transmission system operator or dispatcher who authorized and issued the switching order. Links to workforce or operator registry.',
    `tertiary_transmission_verified_by_operator_employee_id` BIGINT COMMENT 'Identifier of the operator or technician who verified the switching operation completion. May be different from the issuing dispatcher for independent verification.',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the primary transmission substation where the switching operation will be executed. Links to the substation master data.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when the switching operation was completed and verified. Used to calculate switching duration and operational efficiency metrics.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the switching operation execution began. Captured from SCADA or operator log entry for performance tracking and compliance reporting.',
    `affected_equipment_code` STRING COMMENT 'Unique identifier or tag of the specific equipment device to be switched. References equipment asset registry and SCADA tag database.',
    `affected_equipment_type` STRING COMMENT 'Type of transmission equipment that will be operated or isolated by this switching order. Determines safety protocols and operational procedures.. Valid values are `circuit_breaker|disconnect_switch|transformer|bus_section|capacitor_bank|reactor`',
    `affected_load_mw` DECIMAL(18,2) COMMENT 'Estimated or actual load in megawatts that was transferred, interrupted, or affected by the switching operation. Used for impact assessment and reliability reporting.',
    `approving_authority_name` STRING COMMENT 'Full name of the approving authority for audit trail and compliance documentation.',
    `atc_recalculation_required_flag` BOOLEAN COMMENT 'Indicates whether the switching operation changes network topology sufficiently to require recalculation of Available Transfer Capability for transmission service scheduling.',
    `cip_compliance_flag` BOOLEAN COMMENT 'Indicates whether this switching order involves CIP-designated critical cyber assets requiring enhanced security controls and audit logging per NERC CIP standards.',
    `completion_notes` STRING COMMENT 'Free-text operational notes documenting any deviations from planned procedure, unexpected conditions encountered, or additional actions taken during switching execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this switching order record was first created in the system. Audit trail for order lifecycle tracking.',
    `duration_minutes` STRING COMMENT 'Total elapsed time in minutes from start to completion of the switching operation. Used for performance analysis and future planning.',
    `ems_topology_change_code` STRING COMMENT 'Identifier of the corresponding network topology change event in the Energy Management System. Links switching order to power flow model updates and state estimation.',
    `failure_reason` STRING COMMENT 'Description of the reason for switching operation failure if status is failed or suspended. Documents equipment malfunction, safety concerns, or procedural issues.',
    `issuing_dispatcher_name` STRING COMMENT 'Full name of the transmission system operator or dispatcher who issued the switching order for audit and accountability purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this switching order record was last updated. Tracks changes to order status, execution details, or verification information.',
    `nerc_bes_designation` BOOLEAN COMMENT 'Indicates whether the affected equipment is designated as part of the Bulk Electric System under NERC reliability standards. BES-designated equipment requires enhanced documentation and compliance reporting.',
    `oatt_impact_flag` BOOLEAN COMMENT 'Indicates whether this switching operation affects transmission capacity or service under OATT agreements, requiring customer notification or ATC recalculation.',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for the switching order, typically formatted as TSO-YYYYMMDD-NNNN for tracking and reference in operational logs and SCADA systems.. Valid values are `^TSO-[0-9]{8}-[0-9]{4}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the switching order in the operational workflow. Tracks progression from draft through execution to completion or cancellation. [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|completed|cancelled|suspended|failed — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the switching order based on operational purpose. Planned orders support scheduled maintenance, emergency orders respond to grid events, restoration orders support outage recovery.. Valid values are `planned|emergency|maintenance|restoration|testing|commissioning`',
    `outage_event_reference` STRING COMMENT 'Reference to the outage event or restoration plan if this switching order is part of emergency restoration or planned outage operations.',
    `planned_execution_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the switching operation is planned to be executed. Used for operational coordination and resource scheduling.',
    `post_switching_current_amps` DECIMAL(18,2) COMMENT 'Measured current flow in amperes through the affected equipment immediately after the switching operation. Validates load redistribution and equipment status.',
    `post_switching_voltage_kv` DECIMAL(18,2) COMMENT 'Measured voltage level in kilovolts at the affected equipment location immediately after the switching operation. Confirms successful execution and grid stability.',
    `pre_switching_current_amps` DECIMAL(18,2) COMMENT 'Measured current flow in amperes through the affected equipment immediately before the switching operation. Critical for load transfer verification.',
    `pre_switching_voltage_kv` DECIMAL(18,2) COMMENT 'Measured voltage level in kilovolts at the affected equipment location immediately before the switching operation. Used for operational verification and safety validation.',
    `priority_level` STRING COMMENT 'Operational priority assigned to the switching order. Critical priority indicates immediate grid reliability impact requiring expedited execution.. Valid values are `critical|high|medium|low`',
    `rto_iso_approval_reference` STRING COMMENT 'Reference number or identifier of RTO/ISO approval or coordination acknowledgment if required for this switching operation. Links to regional coordination records.',
    `rto_iso_notification_flag` BOOLEAN COMMENT 'Indicates whether the RTO or ISO was notified of this switching operation due to potential impact on regional transmission capacity or market operations.',
    `safety_clearance_reference` STRING COMMENT 'Reference number or identifier of the associated safety clearance or work permit authorizing personnel to work on or near the affected equipment. Links to safety clearance records.',
    `scada_command_code` STRING COMMENT 'Unique identifier of the SCADA command or control sequence that executed the switching operation. Links to SCADA historian for detailed telemetry and event reconstruction.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the switching operation was executed via SCADA remote control (true) or manual field operation (false). Critical for automation tracking and reliability analysis.',
    `switching_action` STRING COMMENT 'Primary switching action to be performed on the affected equipment. Open and close apply to breakers and switches, isolate and energize apply to equipment sections. [ENUM-REF-CANDIDATE: open|close|isolate|energize|de_energize|ground|test — 7 candidates stripped; promote to reference product]',
    `switching_sequence_steps` STRING COMMENT 'Detailed step-by-step procedure for executing the switching operation in correct sequence. Includes device identifiers, actions, and verification checkpoints to ensure safe topology changes.',
    `verification_method` STRING COMMENT 'Method used to verify successful completion of the switching operation. SCADA telemetry provides remote confirmation, field visual requires on-site operator verification.. Valid values are `scada_telemetry|field_visual|relay_indication|meter_reading|remote_camera`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the switching operation was verified and confirmed complete. May differ from completion timestamp if verification requires additional checks.',
    `work_order_reference` STRING COMMENT 'Reference to the maintenance or construction work order that necessitates this switching operation. Links to asset management work order system.',
    CONSTRAINT pk_transmission_switching_order PRIMARY KEY(`transmission_switching_order_id`)
) COMMENT 'Transactional record of a transmission switching order authorizing changes to the network topology (open/close breakers, isolate equipment). Captures order identifier, issuing dispatcher, affected substation and devices, switching sequence steps, safety clearance reference, planned execution time, actual execution time, and completion status. Supports safe switching operations and SCADA-driven topology changes in EMS.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`protection_device` (
    `protection_device_id` BIGINT COMMENT 'Primary key for protection_device',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Protection relays and devices are capitalized assets tracked for depreciation, replacement planning, and capital budgeting. Essential for asset lifecycle management and financial reporting under FERC ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Protection relays and devices require material master linkage for spare parts management, firmware update tracking, warranty administration, and replacement planning. Critical for NERC CIP supply chai',
    `nerc_cip_asset_id` BIGINT COMMENT 'Foreign key linking to compliance.nerc_cip_asset. Business justification: Protection relays are cyber assets requiring CIP-010 configuration baseline management and CIP-007 patch management. Microprocessor-based relays with network connectivity are explicitly covered under ',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Protection relays and devices are tracked assets requiring periodic testing, maintenance, and replacement per NERC CIP compliance requirements. Utilities maintain asset records for lifecycle managemen',
    `scada_point_id` BIGINT COMMENT 'Supervisory Control and Data Acquisition (SCADA) system tag identifier for real-time monitoring and control integration of the protection device.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Protection relay testing requires qualified technician with NERC CIP training and voltage-class certification. Links test events to employee for competency verification, test interval compliance track',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key reference to the transmission substation where this protection device is physically installed.',
    `at_substation` BIGINT COMMENT 'FK to transmission.substation.substation_id — Protection relays and circuit breakers are installed at substations. Essential for switching order execution and fault isolation.',
    `bay_number` STRING COMMENT 'Substation bay or position number where the protection device is located within the substation layout.',
    `cip_asset_classification` STRING COMMENT 'NERC Critical Infrastructure Protection (CIP) impact classification level for cybersecurity requirements (high, medium, low impact BES Cyber System).. Valid values are `high_impact|medium_impact|low_impact|not_applicable`',
    `commissioning_date` DATE COMMENT 'Date when the protection device was placed into active service and energized for protection functions.',
    `communication_protocol` STRING COMMENT 'Communication protocol used for device integration with SCADA/EMS systems (e.g., DNP3, IEC 61850, Modbus, IEC 60870-5-101/104).',
    `device_identifier` STRING COMMENT 'Unique business identifier or asset tag for the protection device as recorded in asset management systems. Used for field identification and maintenance tracking.',
    `device_name` STRING COMMENT 'Human-readable name or designation of the protection device, typically including location and function descriptors.',
    `device_subtype` STRING COMMENT 'Detailed subclassification of the device. For relays: distance, differential, overcurrent, directional, pilot, ground fault. For breakers: oil, SF6, vacuum, air blast. For switches: motor-operated, manual, gang-operated.',
    `device_type` STRING COMMENT 'Classification of the protection device by its primary function in the transmission protection scheme.. Valid values are `protective_relay|circuit_breaker|disconnect_switch|recloser|sectionalizer`',
    `ems_device_code` STRING COMMENT 'Energy Management System (EMS) device identifier for integration with grid operations and state estimation functions.',
    `expected_service_life_years` STRING COMMENT 'Manufacturer-rated or utility-defined expected service life of the protection device in years from installation.',
    `firmware_version` STRING COMMENT 'Current firmware or software version installed on the protection device. Critical for cybersecurity compliance and functional capability tracking.',
    `gis_feature_code` STRING COMMENT 'Geographic Information System (GIS) feature identifier linking the protection device to its geospatial representation in the utility network model.',
    `ieee_device_number` STRING COMMENT 'Standard IEEE C37.2 device function number (e.g., 21 for distance relay, 87 for differential relay, 52 for circuit breaker, 89 for disconnect switch).',
    `installation_date` DATE COMMENT 'Date when the protection device was originally installed and commissioned at the substation.',
    `interrupting_rating_ka` DECIMAL(18,2) COMMENT 'For circuit breakers: maximum fault current in kiloamperes (kA) that the breaker is rated to safely interrupt. Critical for fault clearing capability assessment.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the protection device for communication and remote access. Confidential for cybersecurity purposes.',
    `last_maintenance_date` DATE COMMENT 'Date when the device last received scheduled preventive maintenance or major overhaul.',
    `last_test_date` DATE COMMENT 'Date when the protection device was last functionally tested or calibrated. Critical for NERC PRC compliance and reliability assurance.',
    `nerc_bes_designation` BOOLEAN COMMENT 'Boolean flag indicating whether this protection device is part of a NERC-designated Bulk Electric System (BES) facility and subject to NERC reliability standards.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity based on maintenance program intervals.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next required functional test or calibration based on maintenance intervals and regulatory requirements.',
    `operating_mechanism_type` STRING COMMENT 'For circuit breakers: type of operating mechanism such as spring-operated, hydraulic, pneumatic, or motor-wound spring.',
    `operational_status` STRING COMMENT 'Current operational state of the protection device indicating availability for protection functions.. Valid values are `in_service|out_of_service|testing|maintenance|standby|retired`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the protection device asset.. Valid values are `owned|leased|joint_ownership|third_party`',
    `owning_entity_code` STRING COMMENT 'Code or identifier of the legal entity that owns the protection device asset.',
    `protected_element_code` STRING COMMENT 'Identifier of the specific transmission element (line, transformer, bus, etc.) that this device protects. Links to asset registry.',
    `protected_element_type` STRING COMMENT 'Type of transmission system element that this protection device is assigned to protect.. Valid values are `transmission_line|transformer|bus|generator|capacitor_bank|reactor`',
    `protection_scheme_type` STRING COMMENT 'Overall protection scheme architecture that this device participates in (e.g., primary protection, backup protection, breaker failure, transfer trip, pilot protection).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection device record was first created in the data management system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection device record was last modified in the data management system.',
    `relay_type` STRING COMMENT 'For protective relays only: specific relay protection function type such as distance (21), differential (87), overcurrent (50/51), directional (67), pilot (85), ground fault (50N/51N), or multi-function.',
    `retirement_date` DATE COMMENT 'Date when the protection device was permanently removed from service and decommissioned.',
    `sap_equipment_number` STRING COMMENT 'SAP ERP equipment master record number for integration with enterprise asset management, maintenance planning, and financial systems.',
    `sap_functional_location` STRING COMMENT 'SAP functional location code representing the hierarchical position of the device within the asset structure (region/substation/bay/device).',
    `test_interval_months` STRING COMMENT 'Required testing frequency in months as defined by NERC PRC-005 maintenance program and manufacturer recommendations.',
    `trip_counter` STRING COMMENT 'For circuit breakers: cumulative count of trip operations since installation or last counter reset. Used for maintenance scheduling and end-of-life assessment.',
    `trip_setting_backup` STRING COMMENT 'For protective relays: backup or secondary trip threshold settings for redundant protection schemes.',
    `trip_setting_primary` STRING COMMENT 'For protective relays: primary trip threshold settings including pickup values, time delays, and coordination parameters. Stored as structured text or reference to settings file.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class in kilovolts (kV) of the transmission system where the protection device is installed. Critical for determining protection coordination requirements.',
    `zone_of_protection` STRING COMMENT 'For protective relays: description of the electrical zone or reach that the relay is configured to protect (e.g., Zone 1, Zone 2, Zone 3 for distance relays; primary/backup zones).',
    CONSTRAINT pk_protection_device PRIMARY KEY(`protection_device_id`)
) COMMENT 'Master record for transmission protection devices including protective relays, high-voltage circuit breakers, and disconnect switches at transmission substations. Captures device identifier, device type (relay/breaker/disconnect), voltage class (kV), for relays: relay type (distance, differential, overcurrent), manufacturer, model, firmware version, zone of protection, trip settings, last test date; for breakers: interrupting rating (kA), operating mechanism type, trip counter, last maintenance date; associated protected element (line/transformer/bus), SCADA integration tag, installation date, and operational status. Critical for NERC PRC compliance, fault clearing performance, switching operations, and fault isolation.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` (
    `transmission_scada_measurement_id` BIGINT COMMENT 'Unique identifier for each SCADA measurement record captured from transmission substations and lines.',
    `line_id` BIGINT COMMENT 'Foreign key reference to the transmission line being measured. Nullable for substation-level measurements not specific to a line.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key reference to the transmission substation where this measurement was captured.',
    `alarm_limit_high` DECIMAL(18,2) COMMENT 'The upper threshold value that triggers a high alarm condition when the measurement exceeds this limit.',
    `alarm_limit_low` DECIMAL(18,2) COMMENT 'The lower threshold value that triggers a low alarm condition when the measurement falls below this limit.',
    `alarm_status` STRING COMMENT 'Current alarm status of the measurement based on comparison with configured alarm limits.. Valid values are `normal|high_alarm|low_alarm|high_high_alarm|low_low_alarm|acknowledged`',
    `analog_digital_indicator` STRING COMMENT 'Indicates whether the measurement is an analog value (continuous), digital value (discrete state), calculated value (derived), or status indicator.. Valid values are `analog|digital|calculated|status`',
    `archive_flag` BOOLEAN COMMENT 'Indicates whether this measurement should be archived to the long-term operational data historian for historical trending and analysis.',
    `change_of_state_flag` BOOLEAN COMMENT 'Indicates whether this measurement represents a change of state event (e.g., breaker opened/closed) rather than a periodic scan.',
    `cip_asset_classification` STRING COMMENT 'NERC CIP classification of the asset from which this measurement originates, determining cybersecurity requirements.. Valid values are `high|medium|low|bes_cyber_asset|protected_cyber_asset|electronic_access_point`',
    `contingency_analysis_flag` BOOLEAN COMMENT 'Indicates whether this measurement is used as input to real-time contingency analysis for N-1 and N-2 reliability assessments.',
    `data_retention_days` STRING COMMENT 'The number of days this measurement record should be retained in the operational historian before archival or deletion, per data governance policy.',
    `data_source_system` STRING COMMENT 'The source system that generated this measurement record (e.g., GE EMS, OSIsoft PI, ABB MicroSCADA, Siemens Spectrum Power).',
    `deadband_value` DECIMAL(18,2) COMMENT 'The minimum change in value required before a new measurement is transmitted or logged, used to reduce data volume for slowly changing analog values.',
    `ems_state_estimator_flag` BOOLEAN COMMENT 'Indicates whether this measurement is used as an input to the EMS state estimation algorithm for real-time grid state calculation.',
    `engineering_unit` STRING COMMENT 'The unit of measure for the engineering value (e.g., MW, MVAR, kV, A, Hz, degrees, percent, degrees_C).',
    `engineering_value` DECIMAL(18,2) COMMENT 'The measurement value converted to engineering units (MW, MVAR, kV, amperes, Hz, etc.) after applying scaling factors and calibration.',
    `ferc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this measurement is required for FERC regulatory reporting (e.g., Form 1, Form 714, EQR).',
    `historian_tag` STRING COMMENT 'Reference tag identifier in the operational data historian system (e.g., OSIsoft PI) where this measurement is archived for long-term storage and trending.',
    `last_calibration_date` DATE COMMENT 'The date when the measurement instrument or transducer was last calibrated, used to assess measurement accuracy and reliability.',
    `measurement_accuracy_class` STRING COMMENT 'The accuracy class or precision rating of the measurement instrument (e.g., 0.2%, 0.5%, 1.0%) per IEEE or IEC standards.',
    `measurement_phase` STRING COMMENT 'The electrical phase or phase combination that this measurement represents in a three-phase power system. [ENUM-REF-CANDIDATE: A|B|C|AB|BC|CA|ABC|neutral|ground — 9 candidates stripped; promote to reference product]',
    `measurement_sequence_number` BIGINT COMMENT 'Sequential number assigned by the SCADA system to track measurement order and detect missing or duplicate transmissions.',
    `measurement_type` STRING COMMENT 'Type of measurement being captured: MW (real power), MVAR (reactive power), kV (voltage), amperes (current), frequency (Hz), breaker_status (open/closed), transformer_tap (position), voltage_angle (degrees), power_factor (ratio), temperature (degrees C). [ENUM-REF-CANDIDATE: MW|MVAR|kV|amperes|frequency|breaker_status|transformer_tap|voltage_angle|power_factor|temperature — 10 candidates stripped; promote to reference product]',
    `nerc_reliability_region` STRING COMMENT 'The NERC reliability region where this measurement originates (e.g., WECC, ERCOT, NPCC, SERC, MRO, RFC, SPP, TRE).',
    `next_calibration_due_date` DATE COMMENT 'The scheduled date for the next calibration of the measurement instrument, used for maintenance planning.',
    `normal_operating_range_max` DECIMAL(18,2) COMMENT 'The maximum value of the normal operating range for this measurement type at this location, used for anomaly detection.',
    `normal_operating_range_min` DECIMAL(18,2) COMMENT 'The minimum value of the normal operating range for this measurement type at this location, used for anomaly detection.',
    `operator_override_flag` BOOLEAN COMMENT 'Indicates whether a system operator has manually overridden the SCADA measurement value for operational reasons.',
    `operator_override_user` STRING COMMENT 'The user ID of the system operator who performed the manual override, if applicable. Used for audit trail and compliance.',
    `pnode_code` STRING COMMENT 'The pricing node identifier in the RTO/ISO market system associated with this measurement location, used for LMP (Locational Marginal Price) calculations.',
    `quality_flag` STRING COMMENT 'Quality indicator for the measurement: good (valid and reliable), suspect (questionable), bad (invalid), manual (operator-entered), estimated (calculated from other values), out_of_range (exceeds limits), stale (not updated within expected interval). [ENUM-REF-CANDIDATE: good|suspect|bad|manual|estimated|out_of_range|stale — 7 candidates stripped; promote to reference product]',
    `raw_value` DECIMAL(18,2) COMMENT 'The raw numeric value captured from the SCADA system before any engineering unit conversion or validation. For digital/status points, represents the state code.',
    `received_timestamp` TIMESTAMP COMMENT 'The timestamp when the measurement was received and processed by the central EMS/SCADA master station.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this measurement record was first inserted into the data historian or lakehouse silver layer.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this measurement record was last updated or modified in the data historian or lakehouse silver layer.',
    `rto_iso_region` STRING COMMENT 'The Regional Transmission Organization or Independent System Operator region that has operational authority over this measurement point.',
    `rtu_identifier` STRING COMMENT 'Identifier of the Remote Terminal Unit that collected and transmitted this measurement to the SCADA master.',
    `scada_point_tag` STRING COMMENT 'Unique SCADA point identifier or tag name in the EMS/SCADA system that identifies the specific measurement point (e.g., SUB123_LINE5_MW_OUT).',
    `scada_protocol` STRING COMMENT 'The communication protocol used to transmit this measurement (e.g., DNP3, IEC 61850, Modbus, IEC 60870-5-104).',
    `scan_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the SCADA system scanned and captured this measurement from the field device or RTU.',
    `substituted_value_flag` BOOLEAN COMMENT 'Indicates whether this measurement value has been substituted with an estimated or default value due to communication failure or bad quality.',
    CONSTRAINT pk_transmission_scada_measurement PRIMARY KEY(`transmission_scada_measurement_id`)
) COMMENT 'Transactional record of real-time and historical SCADA/EMS telemetry measurements from transmission substations and lines. Captures measurement identifier, SCADA point tag, measurement type (MW, MVAR, kV, amperes, frequency, breaker status), analog/digital indicator, raw value, engineering unit, quality flag (good/suspect/bad/manual), scan timestamp, substation source, RTU identifier, and historian tag reference. Feeds EMS state estimation, real-time contingency analysis, operator displays, and operational data historian for transmission grid situational awareness. Note: this product captures the transmission-specific SCADA data view; the grid domain owns the EMS/SCADA platform master.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` (
    `transmission_customer_id` BIGINT COMMENT 'Unique identifier for the transmission customer entity. Primary key for the transmission customer master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transmission customers require designated account manager for service request coordination, contract negotiations, and relationship management. transmission_service_agreement has responsible_account_m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Large transmission customers (especially network integration customers) may have dedicated cost centers for customer-specific cost tracking, service delivery, and profitability analysis. Supports cust',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Transmission customers and trading counterparties are the same legal entities in energy utilities. Unified counterparty master enables consolidated credit management, ISDA/CSA agreement tracking, and ',
    `active_agreement_count` STRING COMMENT 'Total number of currently active transmission service agreements held by this customer, including firm and non-firm service.',
    `billing_contact_email` STRING COMMENT 'Email address for transmission service invoices, payment notifications, and billing inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Full name of the contact responsible for transmission service billing, invoicing, and payment coordination.',
    `billing_contact_phone` STRING COMMENT 'Telephone number for billing inquiries and payment coordination related to transmission services.',
    `collateral_posted_usd` DECIMAL(18,2) COMMENT 'Total amount of financial collateral currently posted by the transmission customer to secure transmission service obligations, in USD.',
    `collateral_type` STRING COMMENT 'Type of financial instrument used to post collateral for transmission service credit requirements.. Valid values are `cash|letter_of_credit|surety_bond|parent_guarantee|none`',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the transmission customer in USD, determining the aggregate value of transmission services that can be reserved without additional collateral.',
    `credit_rating` STRING COMMENT 'Current credit rating assigned to the transmission customer by the designated rating agency, used for creditworthiness assessment and collateral requirements.',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency providing the current credit rating for the transmission customer.. Valid values are `moodys|sp|fitch|dbrs|none`',
    `credit_rating_date` DATE COMMENT 'Date when the current credit rating was assigned or last updated by the rating agency.',
    `customer_code` STRING COMMENT 'Externally-known unique business identifier for the transmission customer used in OASIS postings and transmission service agreements.. Valid values are `^[A-Z0-9]{6,12}$`',
    `customer_status` STRING COMMENT 'Current lifecycle status of the transmission customer relationship indicating eligibility for transmission service reservations and scheduling.. Valid values are `active|suspended|terminated|pending_approval|inactive|default`',
    `customer_type` STRING COMMENT 'Classification of the transmission customer based on their role in wholesale power markets and transmission service usage.. Valid values are `generator|load_serving_entity|power_marketer|rto_iso|transmission_owner|municipal_utility`',
    `dba_name` STRING COMMENT 'Trade name or doing-business-as name used by the transmission customer in market operations, if different from legal entity name.',
    `default_flag` BOOLEAN COMMENT 'Indicates whether the customer has any outstanding payment defaults or credit violations that impact transmission service eligibility.',
    `ferc_market_participant_code` STRING COMMENT 'FERC-assigned unique identifier for the market participant used in wholesale market reporting and transmission service administration.. Valid values are `^[A-Z0-9]{8,10}$`',
    `firm_service_mw` DECIMAL(18,2) COMMENT 'Total reserved firm transmission service capacity in megawatts across all active agreements for this customer.',
    `first_service_date` DATE COMMENT 'Date when the customer first received transmission service under an executed transmission service agreement.',
    `ftr_holder_flag` BOOLEAN COMMENT 'Indicates whether the customer holds financial transmission rights positions for hedging congestion costs in organized markets.',
    `headquarters_address_line1` STRING COMMENT 'Primary street address line for the transmission customer headquarters location used for legal correspondence and regulatory filings.',
    `headquarters_address_line2` STRING COMMENT 'Secondary address line for suite, floor, or building information at the headquarters location.',
    `headquarters_city` STRING COMMENT 'City name for the transmission customer headquarters location.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the headquarters location.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the headquarters location used in mailing and regulatory correspondence.',
    `headquarters_state_province` STRING COMMENT 'Two-letter state or province code for the headquarters location following ISO 3166-2 standard.. Valid values are `^[A-Z]{2}$`',
    `last_service_date` DATE COMMENT 'Most recent date when the customer received transmission service, used for activity tracking and customer lifecycle management.',
    `nerc_company_code` STRING COMMENT 'NERC-assigned unique identifier for the registered entity used in reliability coordination and compliance reporting.. Valid values are `^[0-9]{5}$`',
    `nerc_reliability_region` STRING COMMENT 'NERC regional entity jurisdiction where the customer operates for reliability coordination and compliance purposes. [ENUM-REF-CANDIDATE: wecc|tre|mro|serc|rf|npcc|frcc|spp_re — 8 candidates stripped; promote to reference product]',
    `network_service_flag` BOOLEAN COMMENT 'Indicates whether the customer holds network transmission service agreements for serving native load within the transmission provider service territory.',
    `non_firm_service_mw` DECIMAL(18,2) COMMENT 'Total reserved non-firm transmission service capacity in megawatts across all active agreements for this customer.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special instructions, or operational notes related to the transmission customer relationship.',
    `oasis_account_reference` STRING COMMENT 'Unique account identifier in the OASIS system used for transmission service requests, reservations, and scheduling.. Valid values are `^[A-Z0-9]{8,16}$`',
    `parent_company_name` STRING COMMENT 'Legal name of the parent or holding company that owns or controls the transmission customer entity, if applicable.',
    `point_to_point_service_flag` BOOLEAN COMMENT 'Indicates whether the customer holds point-to-point transmission service agreements for specific receipt and delivery point transactions.',
    `primary_contact_email` STRING COMMENT 'Primary email address for transmission service communications, OASIS notifications, and operational coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact for transmission service administration and operational coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for transmission service inquiries and emergency operational coordination.',
    `registration_date` DATE COMMENT 'Date when the transmission customer was first registered in the transmission provider system and approved for service.',
    `rto_iso_region` STRING COMMENT 'Primary RTO or ISO region where the customer participates in transmission service and wholesale markets. [ENUM-REF-CANDIDATE: caiso|ercot|isone|miso|nyiso|pjm|spp|non_rto — 8 candidates stripped; promote to reference product]',
    `tax_id_number` STRING COMMENT 'Federal tax identification number (EIN or SSN) for the transmission customer used for billing, invoicing, and regulatory reporting.',
    `termination_date` DATE COMMENT 'Date when the transmission customer relationship was terminated and all transmission service agreements were closed.',
    CONSTRAINT pk_transmission_customer PRIMARY KEY(`transmission_customer_id`)
) COMMENT 'Master record for entities that purchase transmission service under OATT — wholesale generators, load-serving entities, power marketers, and RTOs. Captures customer identifier, legal entity name, FERC market participant ID, customer type, DUNS number, contact information, credit rating, credit limit, OASIS account reference, and active agreement count. SSOT for transmission customer identity within the transmission domain; complements the retail customer domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`planning_study` (
    `planning_study_id` BIGINT COMMENT 'Primary key for planning_study',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Planning studies identify and justify capital projects that become formal capex projects in finance system. Links technical planning to capital budgeting, IRP compliance, and rate case support.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: Transmission planning studies identify system needs that drive capital projects. Utilities link planning study recommendations to specific capital projects for regulatory justification (FERC/PUC filin',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_contract. Business justification: Long-term transmission planning studies reference existing supplier contracts for major equipment (power transformers, circuit breakers, disconnect switches) to validate capital cost assumptions, deli',
    `interconnection_queue_id` BIGINT COMMENT 'Foreign key linking to renewable.interconnection_queue. Business justification: Transmission planning studies (system impact studies, facilities studies, cluster studies) directly assess the system impacts of specific interconnection queue projects. FERC Order 2023 cluster study ',
    `hedge_strategy_id` BIGINT COMMENT 'Foreign key linking to trading.hedge_strategy. Business justification: Long-term transmission planning studies (load growth, generation mix changes) directly inform multi-year hedge strategy design. Hedge strategies reference specific planning study assumptions for board',
    `irp_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.irp_filing. Business justification: Transmission expansion plans are integral components of Integrated Resource Plan filings required by state PUCs. IRP filings include transmission needs assessment, capacity expansion plans, and cost a',
    `irp_scenario_id` BIGINT COMMENT 'Foreign key linking to forecast.irp_scenario. Business justification: Transmission planning studies reference IRP scenarios for long-term load growth, generation mix, and policy assumptions. Standard regulatory planning workflow where transmission expansion plans must a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Transmission planning studies require accountable lead engineer for FERC/PUC filings, NERC TPL compliance, and stakeholder review processes. lead_engineer_name currently plain text; FK enables workloa',
    `path_id` BIGINT COMMENT 'FK to transmission.path.path_id — Planning studies analyze specific transmission paths for transfer capability and reliability. Links planning to operational topology.',
    `planning_path_id` BIGINT COMMENT 'FK to transmission.path.path_id — Planning studies evaluate transmission paths for adequacy and expansion needs. Links study recommendations to physical network elements.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Transmission planning studies are filed with state PUCs and FERC for prudency review and cost recovery approval. FERC Order 1000 requires regional transmission planning process documentation and stake',
    `approval_date` DATE COMMENT 'Date when the planning study was formally approved by management or the regional planning authority.',
    `atc_impact_mw` DECIMAL(18,2) COMMENT 'Estimated impact on Available Transfer Capability (ATC) in megawatts resulting from recommended projects or identified constraints in this study.',
    `base_case_scenario` STRING COMMENT 'Description of the base case scenario used in the power flow model (e.g., 2030 Summer Peak, 2025 Winter Off-Peak, Current Year Light Load).',
    `contingency_scenario` STRING COMMENT 'Description of contingency scenarios analyzed in this study (e.g., N-1, N-2, generator outage, transmission line outage, extreme weather).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning study record was first created in the system.',
    `estimated_capex_usd` DECIMAL(18,2) COMMENT 'Estimated total capital expenditure in USD for all recommended transmission projects identified in this study.',
    `estimated_project_in_service_date` DATE COMMENT 'Estimated date when recommended transmission projects from this study are expected to be placed in service.',
    `ferc_filing_date` DATE COMMENT 'Date when study results or associated transmission projects were filed with FERC.',
    `generation_additions_mw` DECIMAL(18,2) COMMENT 'Total megawatts (MW) of new generation capacity assumed to be added in the planning horizon for this study.',
    `generation_retirements_mw` DECIMAL(18,2) COMMENT 'Total megawatts (MW) of existing generation capacity assumed to be retired in the planning horizon for this study.',
    `identified_deficiencies` STRING COMMENT 'Summary of transmission system deficiencies, violations, or reliability issues identified through the study (e.g., thermal overloads, voltage violations, stability issues).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning study record was last modified or updated.',
    `load_growth_assumption_mw` DECIMAL(18,2) COMMENT 'Assumed load growth in megawatts (MW) for the planning horizon used in this study. Represents forecasted increase in demand.',
    `load_growth_rate_percent` DECIMAL(18,2) COMMENT 'Annual load growth rate percentage assumed for the planning horizon (e.g., 2.5% per year).',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this planning study record.',
    `nerc_model_version` STRING COMMENT 'Version identifier of the NERC-coordinated power flow model used as the base case for this study (e.g., 2024 Summer Peak Case v3.2).',
    `nerc_reliability_region` STRING COMMENT 'NERC reliability region applicable to this study: WECC (Western Electricity Coordinating Council), ERCOT (Electric Reliability Council of Texas), MRO (Midwest Reliability Organization), NPCC (Northeast Power Coordinating Council), RF (ReliabilityFirst), SERC (SERC Reliability Corporation), TRE (Texas Reliability Entity), or SPP (Southwest Power Pool). [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|TRE|SPP — 8 candidates stripped; promote to reference product]',
    `nerc_tpl_compliance_category` STRING COMMENT 'NERC TPL-001 planning event category that this study addresses: P0 (no contingency), P1 (single contingency), P2 (single generator contingency), P3 (multiple contingency), P4 (extreme event), P5 (delayed fault clearing), P6 (system instability), P7 (common structure). [ENUM-REF-CANDIDATE: P0|P1|P2|P3|P4|P5|P6|P7 — 8 candidates stripped; promote to reference product]',
    `oatt_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this study was conducted to meet OATT compliance requirements for transmission service requests or interconnection studies.',
    `peak_off_peak_indicator` STRING COMMENT 'Indicates whether the study addresses peak load conditions, off-peak load conditions, or shoulder periods.. Valid values are `peak|off_peak|shoulder`',
    `planning_horizon_year` STRING COMMENT 'Target year for the planning horizon that this study addresses (e.g., 2030, 2035). Represents the future year for which transmission needs are being assessed.',
    `power_flow_software_tool` STRING COMMENT 'Software tool used for power flow modeling and analysis in this study (e.g., PSS/E, PowerWorld, PSLF, TARA, DSATools, PSCAD). [ENUM-REF-CANDIDATE: PSS/E|PowerWorld|PSLF|TARA|DSATools|PSCAD|other — 7 candidates stripped; promote to reference product]',
    `puc_filing_date` DATE COMMENT 'Date when study results or associated transmission projects were filed with the state Public Utility Commission.',
    `recommended_projects` STRING COMMENT 'Summary of recommended transmission projects, upgrades, or mitigation measures to address identified deficiencies (e.g., new transmission lines, substation upgrades, reactive compensation).',
    `renewable_integration_mw` DECIMAL(18,2) COMMENT 'Total megawatts (MW) of renewable energy resources (wind, solar, hydro) assumed to be integrated into the transmission system in this study.',
    `rto_iso_region` STRING COMMENT 'RTO or ISO region that this planning study covers or coordinates with (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE).',
    `season` STRING COMMENT 'Season for which the power flow model and study analysis applies: summer, winter, spring, or fall.. Valid values are `summer|winter|spring|fall`',
    `stability_issues_count` STRING COMMENT 'Number of transient or dynamic stability issues identified in the study.',
    `stakeholder_review_date` DATE COMMENT 'Date when the study was presented to stakeholders for review and feedback (e.g., regional planning committee, public stakeholder meeting).',
    `study_completion_date` DATE COMMENT 'Date when the planning study was completed and finalized.',
    `study_documentation_url` STRING COMMENT 'URL or file path to the full study documentation, reports, and power flow model files.',
    `study_identifier` STRING COMMENT 'Business identifier or code assigned to the planning study for external reference and tracking (e.g., TPL-2024-001, IRP-2025-WEST).',
    `study_name` STRING COMMENT 'Descriptive name of the transmission planning study for business users and stakeholders.',
    `study_start_date` DATE COMMENT 'Date when the planning study was initiated or formally commenced.',
    `study_status` STRING COMMENT 'Current lifecycle status of the planning study: initiated, in progress, under review, completed, approved, filed with regulators, archived, or cancelled. [ENUM-REF-CANDIDATE: initiated|in_progress|under_review|completed|approved|filed|archived|cancelled — 8 candidates stripped; promote to reference product]',
    `study_team` STRING COMMENT 'Comma-separated list or description of team members and stakeholders involved in the planning study.',
    `study_type` STRING COMMENT 'Classification of the planning study type: TPL (NERC Transmission Planning), IRP (Integrated Resource Plan), regional expansion, interconnection support, generator interconnection, load interconnection, economic assessment, or reliability assessment. [ENUM-REF-CANDIDATE: TPL|IRP|regional_expansion|interconnection_support|generator_interconnection|load_interconnection|economic_assessment|reliability_assessment — 8 candidates stripped; promote to reference product]',
    `thermal_violations_count` STRING COMMENT 'Number of thermal overload violations identified in the study across all contingency scenarios.',
    `voltage_violations_count` STRING COMMENT 'Number of voltage limit violations identified in the study across all contingency scenarios.',
    CONSTRAINT pk_planning_study PRIMARY KEY(`planning_study_id`)
) COMMENT 'Master record for transmission planning studies and associated power flow models including NERC TPL assessments, IRP transmission analyses, regional transmission expansion plans, and steady-state/stability/short-circuit study cases. Captures study identifier, study type (TPL/IRP/regional/interconnection support), planning horizon, load growth assumptions, generation additions, power flow model metadata (software tool such as PSS/E or PowerWorld, NERC model version, base case/contingency scenario, season, peak/off-peak), identified deficiencies, recommended projects, estimated CAPEX, and regulatory filing reference. SSOT for long-range transmission planning and the power flow models that underpin ATC studies and NERC TPL-001 compliance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` (
    `study_path_analysis_id` BIGINT COMMENT 'Unique identifier for this study-path analysis record. Primary key.',
    `path_id` BIGINT COMMENT 'Foreign key linking to the transmission path that was analyzed in this study',
    `planning_study_id` BIGINT COMMENT 'Foreign key linking to the transmission planning study that performed this path analysis',
    `analysis_date` DATE COMMENT 'Date when this specific path analysis was performed within the planning study',
    `analysis_status` STRING COMMENT 'Current status of this path analysis within the study: pending, in_progress, completed, under_review',
    `atc_impact_mw` DECIMAL(18,2) COMMENT 'Estimated impact on Available Transfer Capability (ATC) in megawatts for this specific path resulting from this studys findings',
    `contingency_scenario` STRING COMMENT 'Description of contingency scenarios analyzed for this path in this study (e.g., N-1, N-2, generator outage)',
    `estimated_upgrade_cost_usd` DECIMAL(18,2) COMMENT 'Estimated capital expenditure in USD for recommended upgrades to this specific path identified in this study',
    `identified_deficiencies` STRING COMMENT 'Summary of transmission system deficiencies, violations, or reliability issues identified on this specific path during this study',
    `limiting_contingency` STRING COMMENT 'Description of the most limiting contingency scenario that constrains this paths transfer capability in this study',
    `limiting_facility` STRING COMMENT 'Identification of the specific transmission facility (line, transformer, etc.) that is the limiting element on this path in this study',
    `recommended_upgrades` STRING COMMENT 'Summary of recommended transmission upgrades or mitigation measures for this specific path based on this studys findings',
    `stability_issues_count` STRING COMMENT 'Number of transient or dynamic stability issues identified on this specific path during this study',
    `thermal_violations_count` STRING COMMENT 'Number of thermal overload violations identified on this specific path during this studys contingency analysis',
    `voltage_violations_count` STRING COMMENT 'Number of voltage limit violations identified on this specific path during this studys contingency analysis',
    CONSTRAINT pk_study_path_analysis PRIMARY KEY(`study_path_analysis_id`)
) COMMENT 'This association product represents the analytical relationship between transmission planning studies and transmission paths. It captures the results of analyzing specific transmission paths within a planning study context, including violations identified, contingency scenarios tested, and recommended upgrades. Each record links one planning study to one path with path-specific analysis results that exist only in the context of that study.. Existence Justification: Transmission planning studies analyze multiple transmission paths under various contingency scenarios as required by NERC TPL standards, and each transmission path is analyzed across multiple planning studies over time (different planning horizons, load assumptions, and generation scenarios). Planning engineers explicitly track path-specific analysis results within each study, including violations, limiting contingencies, and recommended upgrades. This is a core operational business process in transmission planning.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` (
    `outage_path_impact_id` BIGINT COMMENT 'Primary key for the outage_path_impact association',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to the transmission outage event that caused the path impact',
    `path_id` BIGINT COMMENT 'Foreign key linking to the transmission path that was impacted by the outage',
    `affected_transmission_paths` STRING COMMENT 'Comma-separated list of transmission paths or flowgates impacted by the outage. Critical for congestion management and market operations. [Moved from transmission_outage: This denormalized STRING attribute (comma-separated list) is the smoking gun proving the M:N relationship exists but is improperly modeled. It should be removed from transmission_outage and replaced by proper normalized records in the outage_path_impact association table.]',
    `atc_impact_mw` DECIMAL(18,2) COMMENT 'Reduction in Available Transfer Capability in megawatts for this specific path caused by this specific outage. This is path-specific and varies by outage-path combination based on the electrical topology and contingency analysis.',
    `contingency_impact_flag` BOOLEAN COMMENT 'Indicates whether this path impact is a direct result of the outage (false) or a contingency-based impact where the path becomes limiting under N-1 or N-2 analysis (true).',
    `impact_duration_hours` DECIMAL(18,2) COMMENT 'Total duration in hours that this specific path experienced reduced transfer capability due to this outage, calculated from impact start to impact end.',
    `impact_end_timestamp` TIMESTAMP COMMENT 'Date and time when this specific paths transfer capability was restored to normal following the outage resolution or system reconfiguration.',
    `impact_start_timestamp` TIMESTAMP COMMENT 'Date and time when this specific path began experiencing reduced transfer capability due to the outage. May differ from outage start if path impact is contingency-based or delayed.',
    `restoration_priority` STRING COMMENT 'Priority level for restoring transfer capability on this specific path, which may differ from the overall outage restoration priority based on path criticality and current system conditions.',
    `rto_notification_required` BOOLEAN COMMENT 'Indicates whether this specific path impact requires notification to the RTO/ISO based on the magnitude of ATC reduction and path criticality thresholds defined in operating agreements.',
    `ttc_reduction_mw` DECIMAL(18,2) COMMENT 'Reduction in Total Transfer Capability in megawatts for this path due to this outage. Used in transmission reliability analysis and NERC reporting.',
    CONSTRAINT pk_outage_path_impact PRIMARY KEY(`outage_path_impact_id`)
) COMMENT 'This association product represents the operational impact event between transmission outages and transmission paths. It captures the specific effect each outage has on each affected transmission path, including ATC reductions, timing, and RTO notification requirements. Each record links one transmission outage to one impacted path with attributes that exist only in the context of this specific outage-path impact relationship. This is a core operational and compliance entity required for NERC reliability reporting and RTO/ISO coordination.. Existence Justification: In transmission operations, a single outage event (line trip, transformer failure, planned maintenance) simultaneously impacts multiple transmission paths by reducing their Available Transfer Capability, and each path experiences impacts from multiple different outages over time. RTOs and ISOs require utilities to report path-specific ATC impacts for reliability coordination and NERC compliance, making this a core operational relationship that transmission operators actively manage and monitor in real-time.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` (
    `transformer_vendor_service_id` BIGINT COMMENT 'Primary key for the transformer-vendor service relationship record',
    `power_transformer_id` BIGINT COMMENT 'Foreign key linking to the power transformer asset receiving service from this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing service to this transformer',
    `last_service_date` DATE COMMENT 'Date of the most recent service performed by this vendor on this transformer. Used to track service history by vendor.',
    `next_service_due_date` DATE COMMENT 'Scheduled date for the next service to be performed by this vendor on this transformer. Used for maintenance planning and vendor coordination.',
    `relationship_end_date` DATE COMMENT 'Date when this vendor stopped providing services for this transformer, if applicable. Null for active relationships.',
    `relationship_start_date` DATE COMMENT 'Date when this vendor began providing services for this specific transformer. Used for vendor performance tracking and relationship history.',
    `relationship_status` STRING COMMENT 'Current status of this transformer-vendor service relationship. Active relationships are eligible for service scheduling.',
    `service_contract_end_date` DATE COMMENT 'End date of the service contract for this transformer-vendor relationship. Used for contract renewal planning.',
    `service_contract_number` STRING COMMENT 'Unique identifier for the service contract between the utility and this vendor for this specific transformer. Links to procurement system contract records.',
    `service_contract_start_date` DATE COMMENT 'Start date of the service contract for this transformer-vendor relationship.',
    `service_frequency_days` STRING COMMENT 'Contracted service frequency in days for this vendor-transformer relationship. For example, oil testing labs may perform dissolved gas analysis every 180 days.',
    `total_service_cost` DECIMAL(18,2) COMMENT 'Cumulative cost of all services performed by this vendor on this transformer. Used for cost tracking and vendor performance analysis.',
    `total_service_count` STRING COMMENT 'Cumulative count of service events performed by this vendor on this transformer. Used for vendor performance evaluation.',
    `vendor_role` STRING COMMENT 'The specific role this vendor plays for this transformer. A transformer has multiple vendors in different roles: OEM for warranty and major repairs, oil testing lab for dissolved gas analysis, bushing manufacturer for bushing maintenance, local service contractors for routine maintenance.',
    `warranty_end_date` DATE COMMENT 'End date of warranty coverage provided by this vendor for this transformer. Used to track warranty expiration and plan for post-warranty service contracts.',
    `warranty_start_date` DATE COMMENT 'Start date of warranty coverage provided by this vendor for this transformer. Typically applies to OEM vendor role.',
    `warranty_terms` STRING COMMENT 'Detailed warranty terms and conditions specific to this transformer-vendor relationship, including coverage scope, exclusions, and claim procedures.',
    CONSTRAINT pk_transformer_vendor_service PRIMARY KEY(`transformer_vendor_service_id`)
) COMMENT 'This association product represents the service and warranty relationship between power transformers and vendors. It captures the multi-vendor service ecosystem where a single transformer receives services from multiple specialized vendors (OEM for warranty, oil testing labs, bushing manufacturers, local contractors) and each vendor services many transformers. Each record links one power transformer to one vendor with warranty terms, service contract details, and service history that exist only in the context of this specific transformer-vendor relationship.. Existence Justification: In energy utilities transmission operations, a single power transformer receives specialized services from multiple vendors simultaneously: the OEM handles warranty and major repairs, oil testing laboratories perform dissolved gas analysis, bushing manufacturers provide component-specific maintenance, and local contractors handle routine servicing. Each vendor services many transformers across the utilitys transmission network. The utility actively manages these multi-vendor service relationships, tracking warranty coverage, service contracts, maintenance schedules, and vendor performance on a per-transformer, per-vendor basis.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` (
    `path_reservation_id` BIGINT COMMENT 'Unique identifier for this transmission service path reservation record. Primary key.',
    `path_id` BIGINT COMMENT 'Foreign key linking to the transmission path on which capacity is reserved',
    `transmission_service_agreement_id` BIGINT COMMENT 'Foreign key linking to the transmission service agreement that reserves capacity on this path',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the agreements total contracted capacity allocated to this specific path.',
    `atc_impact_mw` DECIMAL(18,2) COMMENT 'Impact of this reservation on Available Transfer Capability calculation for this path. Represents the reduction in available capacity due to this firm reservation.',
    `curtailment_priority` STRING COMMENT 'Priority ranking for this specific path reservation during TLR (Transmission Loading Relief) events. Lower numbers indicate higher priority and later curtailment.',
    `effective_end_date` DATE COMMENT 'Date when this path reservation expires or was terminated. Nullable for active reservations.',
    `effective_start_date` DATE COMMENT 'Date when this path reservation becomes effective. May differ from agreement term start if paths are added during agreement lifecycle.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this path reservation record, supporting audit trail and change tracking.',
    `oasis_posting_required_flag` BOOLEAN COMMENT 'Indicates whether this path reservation must be posted to OASIS (Open Access Same-Time Information System) for FERC transparency compliance.',
    `path_utilization_factor` DECIMAL(18,2) COMMENT 'Historical or projected utilization factor for this path reservation, representing actual usage relative to reserved capacity. Used for ATC forecasting and capacity planning.',
    `reservation_status` STRING COMMENT 'Current operational status of this path reservation: active (in use), suspended (temporarily inactive), curtailed (reduced due to TLR), expired (term ended), terminated (cancelled before term end).',
    `reserved_capacity_mw` DECIMAL(18,2) COMMENT 'Amount of transmission capacity in megawatts reserved on this specific path under this agreement. May differ from total contracted capacity if agreement spans multiple paths.',
    CONSTRAINT pk_path_reservation PRIMARY KEY(`path_reservation_id`)
) COMMENT 'This association product represents the contractual reservation of transmission capacity on specific paths under OATT transmission service agreements. It captures the allocation of contracted MW capacity across transmission paths, priority rankings for curtailment, and effective periods for each path reservation. Each record links one transmission service agreement to one path with attributes that exist only in the context of this capacity reservation relationship. This is the SSOT for ATC calculation, TLR implementation, and OASIS posting compliance under FERC pro forma OATT requirements.. Existence Justification: In FERC-regulated transmission operations, a single transmission service agreement commonly reserves capacity across multiple transmission paths (e.g., a long-haul PTP agreement traversing multiple flowgates), and a single transmission path hosts capacity reservations from multiple customer agreements simultaneously. Transmission providers must actively manage these path-level reservations to calculate Available Transfer Capability (ATC), implement Transmission Loading Relief (TLR) during congestion, and post capacity availability to OASIS for regulatory compliance.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` (
    `substation_maintenance_contract_id` BIGINT COMMENT 'Unique surrogate identifier for this substation maintenance contract record. Primary key for the association.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to the transmission substation receiving maintenance services under this contract',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing maintenance services under this contract',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Total annual contract value in USD for maintenance services provided by this vendor to this substation. Used for budget allocation and cost tracking by substation-vendor pair.',
    `contract_end_date` DATE COMMENT 'Expiration or termination date of the maintenance contract. Null for open-ended contracts. Used to track contract renewal cycles and vendor transitions.',
    `contract_number` STRING COMMENT 'Business identifier for this maintenance contract. May be assigned by procurement or legal systems. Used for contract document retrieval and invoice reconciliation.',
    `contract_start_date` DATE COMMENT 'Effective start date of the maintenance contract between this vendor and this substation. Defines when the vendors service obligations begin.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this maintenance contract. Active = services being provided, expired = contract ended, suspended = temporarily paused, pending_renewal = in negotiation, terminated = cancelled before end date.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance evaluation of this vendors service delivery at this substation. Used to track vendor management cadence and inform renewal decisions.',
    `last_performance_score` DECIMAL(18,2) COMMENT 'Most recent performance evaluation score (0-100) for this vendors work at this substation. Aggregates quality, timeliness, safety, and responsiveness dimensions specific to this substation-vendor relationship.',
    `preferred_vendor_rank` BIGINT COMMENT 'Ranking of this vendors preference for this specific substation (1 = primary, 2 = backup, etc.). Reflects vendor performance history, proximity, and specialized capability for this substations equipment configuration.',
    `response_time_sla_hours` DECIMAL(18,2) COMMENT 'Contractual service level agreement for vendor response time in hours for emergency calls from this substation. SLA may vary by substation criticality and vendor capability.',
    `service_scope` STRING COMMENT 'Classification of the maintenance service type covered by this contract. Defines the specialized work this vendor performs at this substation. Multiple vendors may serve the same substation for different service scopes.',
    CONSTRAINT pk_substation_maintenance_contract PRIMARY KEY(`substation_maintenance_contract_id`)
) COMMENT 'This association product represents the maintenance contract between a transmission substation and a vendor. It captures the commercial and service-level terms governing maintenance services provided by a specific vendor to a specific substation. Each record links one transmission substation to one vendor with contract-specific attributes including service scope, contract value, response time SLAs, and vendor preference ranking for that substation.. Existence Justification: In energy utilities transmission operations, substations require specialized maintenance services from multiple vendors simultaneously (transformer maintenance, protection testing, vegetation management, civil/structural, SCADA/telecom). Each vendor serves multiple substations across the transmission network. The business actively manages these maintenance contracts as distinct operational entities with substation-vendor-specific terms including service scope, contract value, response time SLAs, and performance tracking.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`constraint` (
    `constraint_id` BIGINT COMMENT 'Primary key for constraint',
    `market_participant_id` BIGINT COMMENT 'Identifier of the market participant owning or responsible for the constraint.',
    `parent_constraint_id` BIGINT COMMENT 'Self-referencing FK on constraint (parent_constraint_id)',
    `congestion_price_usd_per_mwh` DECIMAL(18,2) COMMENT 'Congestion price associated with the constraint in US dollars per megawatt‑hour.',
    `constraint_category` STRING COMMENT 'Higher‑level grouping of constraints.',
    `constraint_code` STRING COMMENT 'Unique alphanumeric code used in market and operational systems to identify the constraint.',
    `constraint_name` STRING COMMENT 'Human‑readable name of the transmission constraint.',
    `constraint_status` STRING COMMENT 'Current lifecycle status of the constraint.',
    `constraint_type` STRING COMMENT 'Category of constraint based on physical or market definition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the constraint record was created in the system.',
    `constraint_description` STRING COMMENT 'Detailed description of the constraint purpose and characteristics.',
    `direction` STRING COMMENT 'Direction of power flow the constraint applies to.',
    `effective_end_date` DATE COMMENT 'Date when the constraint expires or is scheduled to be retired.',
    `effective_start_date` DATE COMMENT 'Date when the constraint becomes effective.',
    `is_ftr` BOOLEAN COMMENT 'Indicates if the constraint is associated with a Flowgate Transmission Right (FTR).',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the constraint.',
    `limit_mw` DECIMAL(18,2) COMMENT 'Maximum megawatt limit imposed by the constraint.',
    `limit_type` STRING COMMENT 'Specifies whether the limit is a maximum, minimum, or a range.',
    `location_code` BIGINT COMMENT 'Identifier of the geographic location or substation associated with the constraint.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the constraint.',
    `region` STRING COMMENT 'Geographic region or balancing authority where the constraint is applicable.',
    `reliability_priority` STRING COMMENT 'Priority ranking for reliability coordination (higher number = higher priority).',
    `source_system` STRING COMMENT 'Name of the source system where the constraint originated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the constraint record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts at which the constraint is defined.',
    CONSTRAINT pk_constraint PRIMARY KEY(`constraint_id`)
) COMMENT 'Master reference table for constraint. Referenced by transmission_constraint_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`flowgate` (
    `flowgate_id` BIGINT COMMENT 'Primary key for flowgate',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the substation associated with the flowgate.',
    `parent_flowgate_id` BIGINT COMMENT 'Self-referencing FK on flowgate (parent_flowgate_id)',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity of the flowgate in megawatts.',
    `circuit_code` BIGINT COMMENT 'Identifier of the transmission circuit linked to the flowgate.',
    `flowgate_code` STRING COMMENT 'Standardized code used to identify the flowgate in operational systems.',
    `comments` STRING COMMENT 'Free-text field for additional notes about the flowgate.',
    `congestion_zone` STRING COMMENT 'Identifier of the congestion management zone the flowgate belongs to.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the flowgate record was created in the system.',
    `data_source_system` STRING COMMENT 'Source system that provides the flowgate data (e.g., EMS, SCADA).',
    `effective_from` DATE COMMENT 'Date when the flowgate became effective for operational use.',
    `effective_until` DATE COMMENT 'Date when the flowgate is scheduled to be retired or become inactive (nullable).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the flowgate is considered critical for grid reliability.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the flowgate.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the flowgate location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the flowgate location.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance frequency for the flowgate.',
    `measurement_unit` STRING COMMENT 'Unit of measurement used for flowgate capacity or flow readings.',
    `flowgate_name` STRING COMMENT 'Human readable name of the flowgate.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next inspection of the flowgate.',
    `owner_entity` STRING COMMENT 'Organizational entity that owns or operates the flowgate.',
    `region` STRING COMMENT 'Geographic region or control area where the flowgate resides.',
    `flowgate_status` STRING COMMENT 'Current operational status of the flowgate.',
    `flowgate_type` STRING COMMENT 'Category of flowgate based on its functional role in transmission operations.',
    `typical_flow_mw` DECIMAL(18,2) COMMENT 'Average historical power flow through the flowgate in megawatts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the flowgate record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the flowgate in kilovolts.',
    CONSTRAINT pk_flowgate PRIMARY KEY(`flowgate_id`)
) COMMENT 'Master reference table for flowgate. Referenced by flowgate_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`pnode` (
    `pnode_id` BIGINT COMMENT 'Primary key for pnode',
    `ancillary_service_eligible` BOOLEAN COMMENT 'Indicates whether the node can participate in ancillary service markets.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum MW that can be transferred through the node under normal operating conditions.',
    `congestion_price_usd_per_mwh` DECIMAL(18,2) COMMENT 'Monetary price (USD per MWh) applied when congestion occurs at the node.',
    `control_area` STRING COMMENT 'NERC control area to which the node belongs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the node record was first created in the data lake.',
    `data_source` STRING COMMENT 'Origin system or process that provided the node data.',
    `pnode_description` STRING COMMENT 'Narrative description providing additional context about the node.',
    `effective_date` DATE COMMENT 'Date on which the node entered service.',
    `interconnection_point_flag` BOOLEAN COMMENT 'True if the node serves as an interconnection point with another transmission system or ISO.',
    `is_congested` BOOLEAN COMMENT 'Flag indicating whether the node is experiencing congestion in the current market interval.',
    `is_imported` BOOLEAN COMMENT 'True if the node record was loaded from an external import rather than generated internally.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the node location (decimal degrees).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the node location (decimal degrees).',
    `market_zone` STRING COMMENT 'Market zone used for pricing and settlement calculations.',
    `node_type` STRING COMMENT 'Functional classification of the node within the transmission network.',
    `ownership_entity` STRING COMMENT 'Organization or utility that holds ownership rights for the node.',
    `pnode_category` STRING COMMENT 'Primary business purpose of the node within the utilitys processes.',
    `pnode_code` STRING COMMENT 'Standardized code assigned to the node by the ISO/RTO for market transactions.',
    `pnode_name` STRING COMMENT 'Descriptive name of the pricing node used in reports and UI.',
    `region` STRING COMMENT 'Higher‑level region (e.g., state, province) where the node resides.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the node must be reported to FERC/NERC compliance filings.',
    `retirement_date` DATE COMMENT 'Date on which the node was removed from service, if applicable.',
    `settlement_type` STRING COMMENT 'Type of financial settlement applied to transactions at the node.',
    `pnode_status` STRING COMMENT 'Current lifecycle status of the node.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the node record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Design voltage of the node in kilovolts.',
    CONSTRAINT pk_pnode PRIMARY KEY(`pnode_id`)
) COMMENT 'Master reference table for pnode. Referenced by source_pnode_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` (
    `right_of_way_corridor_id` BIGINT COMMENT 'Primary key for right_of_way_corridor',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the substation at the downstream end of the corridor.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the entity that holds the ownership or lease rights.',
    `start_substation_id` BIGINT COMMENT 'Identifier of the substation at the upstream end of the corridor.',
    `parent_right_of_way_corridor_id` BIGINT COMMENT 'Self-referencing FK on right_of_way_corridor (parent_right_of_way_corridor_id)',
    `acquisition_date` DATE COMMENT 'Date the right‑of‑way was acquired or granted.',
    `area_acres` DECIMAL(18,2) COMMENT 'Total land area covered by the corridor expressed in acres.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity of the corridor in megawatts.',
    `construction_year` STRING COMMENT 'Calendar year the corridor infrastructure was originally constructed.',
    `corridor_code` STRING COMMENT 'External business code or identifier assigned to the corridor.',
    `corridor_name` STRING COMMENT 'Human‑readable name of the corridor used in reports and maps.',
    `corridor_type` STRING COMMENT 'Category of the corridor indicating the type of infrastructure it carries.',
    `county` STRING COMMENT 'County in which the corridor primarily resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the corridor record was first created in the system.',
    `right_of_way_corridor_description` STRING COMMENT 'Free‑form textual description of the corridor, including notable features.',
    `easement_type` STRING COMMENT 'Legal instrument defining the corridors right‑of‑way.',
    `environmental_impact_rating` STRING COMMENT 'Rating of the corridors environmental impact based on internal assessments.',
    `expiration_date` DATE COMMENT 'Date the right‑of‑way agreement expires, if applicable.',
    `geographic_region` STRING COMMENT 'Broad geographic region where the corridor is located.',
    `is_conserved_area` BOOLEAN COMMENT 'True if the corridor traverses a designated conservation area.',
    `is_critical_path` BOOLEAN COMMENT 'Indicates whether the corridor is part of the systems critical transmission path.',
    `land_use_category` STRING COMMENT 'Primary land‑use classification intersected by the corridor.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the corridor.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude of the corridor centroid for GIS mapping.',
    `length_miles` DECIMAL(18,2) COMMENT 'Total linear length of the corridor measured in miles.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude of the corridor centroid for GIS mapping.',
    `maintenance_status` STRING COMMENT 'Current maintenance condition of the corridor.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next scheduled inspection.',
    `regulatory_status` STRING COMMENT 'Current compliance status with NERC/FERC regulations.',
    `state` STRING COMMENT 'Two‑letter US state abbreviation for the corridor location.',
    `right_of_way_corridor_status` STRING COMMENT 'Current operational status of the corridor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the corridor record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the transmission assets within the corridor.',
    `width_meters` DECIMAL(18,2) COMMENT 'Typical width of the right‑of‑way corridor in meters.',
    CONSTRAINT pk_right_of_way_corridor PRIMARY KEY(`right_of_way_corridor_id`)
) COMMENT 'Master reference table for right_of_way_corridor. Referenced by right_of_way_corridor_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_right_of_way_corridor_id` FOREIGN KEY (`right_of_way_corridor_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`right_of_way_corridor`(`right_of_way_corridor_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_to_substation_transmission_substation_id` FOREIGN KEY (`to_substation_transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ADD CONSTRAINT `fk_transmission_power_transformer_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ADD CONSTRAINT `fk_transmission_path_constraint_id` FOREIGN KEY (`constraint_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`constraint`(`constraint_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ADD CONSTRAINT `fk_transmission_path_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_atc_transmission_path_id` FOREIGN KEY (`atc_transmission_path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_transmission_service_agreement_id` FOREIGN KEY (`transmission_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_service_agreement`(`transmission_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_transmission_customer_id` FOREIGN KEY (`transmission_customer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_customer`(`transmission_customer_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_original_ftr_position_id` FOREIGN KEY (`original_ftr_position_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`ftr_position`(`ftr_position_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_primary_path_id` FOREIGN KEY (`primary_path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_congestion_transmission_path_id` FOREIGN KEY (`congestion_transmission_path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_flowgate_id` FOREIGN KEY (`flowgate_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`flowgate`(`flowgate_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_ftr_position_id` FOREIGN KEY (`ftr_position_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`ftr_position`(`ftr_position_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ADD CONSTRAINT `fk_transmission_protection_device_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ADD CONSTRAINT `fk_transmission_transmission_scada_measurement_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ADD CONSTRAINT `fk_transmission_transmission_scada_measurement_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ADD CONSTRAINT `fk_transmission_planning_study_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ADD CONSTRAINT `fk_transmission_planning_study_planning_path_id` FOREIGN KEY (`planning_path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ADD CONSTRAINT `fk_transmission_study_path_analysis_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ADD CONSTRAINT `fk_transmission_study_path_analysis_planning_study_id` FOREIGN KEY (`planning_study_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`planning_study`(`planning_study_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ADD CONSTRAINT `fk_transmission_outage_path_impact_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ADD CONSTRAINT `fk_transmission_outage_path_impact_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ADD CONSTRAINT `fk_transmission_transformer_vendor_service_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ADD CONSTRAINT `fk_transmission_path_reservation_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ADD CONSTRAINT `fk_transmission_path_reservation_transmission_service_agreement_id` FOREIGN KEY (`transmission_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_service_agreement`(`transmission_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ADD CONSTRAINT `fk_transmission_substation_maintenance_contract_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ADD CONSTRAINT `fk_transmission_constraint_parent_constraint_id` FOREIGN KEY (`parent_constraint_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`constraint`(`constraint_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_parent_flowgate_id` FOREIGN KEY (`parent_flowgate_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`flowgate`(`flowgate_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` ADD CONSTRAINT `fk_transmission_right_of_way_corridor_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` ADD CONSTRAINT `fk_transmission_right_of_way_corridor_start_substation_id` FOREIGN KEY (`start_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` ADD CONSTRAINT `fk_transmission_right_of_way_corridor_parent_right_of_way_corridor_id` FOREIGN KEY (`parent_right_of_way_corridor_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`right_of_way_corridor`(`right_of_way_corridor_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`transmission` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `energy_utilities_ecm`.`transmission` SET TAGS ('dbx_domain' = 'transmission');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Conductor Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'From Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Approving Engineer Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `right_of_way_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way (ROW) Corridor ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `to_substation_transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'To Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `circuit_configuration` SET TAGS ('dbx_business_glossary_term' = 'Circuit Configuration');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `circuit_configuration` SET TAGS ('dbx_value_regex' = 'single-circuit|double-circuit|multi-circuit');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `conductor_size_kcmil` SET TAGS ('dbx_business_glossary_term' = 'Conductor Size (kcmil) — Thousand Circular Mils');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `conductor_type` SET TAGS ('dbx_business_glossary_term' = 'Conductor Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `conductors_per_phase` SET TAGS ('dbx_business_glossary_term' = 'Conductors Per Phase');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `emergency_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Emergency Thermal Rating (MVA) — Megavolt-Ampere');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `ferc_oatt_path_code` SET TAGS ('dbx_business_glossary_term' = 'FERC Open Access Transmission Tariff (OATT) Path Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `ferc_oatt_path_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,30}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,100}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `insulation_type` SET TAGS ('dbx_business_glossary_term' = 'Insulation Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `insulation_type` SET TAGS ('dbx_value_regex' = 'porcelain|glass|polymer|XLPE|PILC|XLPE-HVDC');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `length_km` SET TAGS ('dbx_business_glossary_term' = 'Line Length (km) — Kilometers');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `length_miles` SET TAGS ('dbx_business_glossary_term' = 'Line Length (Miles)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'overhead|underground|submarine');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `load_dump_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Load Dump Thermal Rating (MVA) — Megavolt-Ampere');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `nerc_bes_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC Bulk Electric System (BES) Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `nerc_facility_rating_code` SET TAGS ('dbx_business_glossary_term' = 'NERC Facility Rating ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `nerc_facility_rating_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `normal_rating_amps` SET TAGS ('dbx_business_glossary_term' = 'Normal Thermal Rating (Amps) — Amperes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `normal_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Normal Thermal Rating (MVA) — Megavolt-Ampere');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in-service|out-of-service|mothballed|under-construction|decommissioned|planned');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `owner_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `owner_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `pnode_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node (PNode) ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `pnode_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_.-]{1,50}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `rating_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Rating Last Review Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Facility Rating Methodology');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'static|dynamic|ambient-adjusted|real-time');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `reactance_ohms_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Inductive Reactance (Ohms/Mile)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `resistance_ohms_per_mile` SET TAGS ('dbx_business_glossary_term' = 'AC Resistance (Ohms/Mile)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization / Independent System Operator (RTO/ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `scada_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `scada_tag_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_.:-]{1,100}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `spring_fall_normal_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Spring/Fall Normal Seasonal Rating (MVA) — Megavolt-Ampere');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `summer_normal_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Summer Normal Seasonal Rating (MVA) — Megavolt-Ampere');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `susceptance_siemens_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Shunt Susceptance (Siemens/Mile)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `tower_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Tower Structure Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `tower_structure_type` SET TAGS ('dbx_value_regex' = 'lattice-steel|monopole-steel|monopole-concrete|H-frame-wood|guyed-V|tubular-steel');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Nominal Voltage (kV) — Kilovolt');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ALTER COLUMN `winter_normal_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Winter Normal Seasonal Rating (MVA) — Megavolt-Ampere');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Node Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `atc_contribution_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) Contribution (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `bes_designation` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Designation');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `bus_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bus Configuration');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `bus_configuration` SET TAGS ('dbx_value_regex' = 'single-bus|double-bus|ring-bus|breaker-and-a-half|double-bus-double-breaker');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `cip_asset_classification` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Protection (CIP) Asset Classification');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `cip_asset_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|not-applicable');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `control_building_type` SET TAGS ('dbx_business_glossary_term' = 'Control Building Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `control_building_type` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|hybrid|mobile');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Meters)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `ferc_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Facility Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `installed_transformer_mva` SET TAGS ('dbx_business_glossary_term' = 'Installed Transformer Capacity (MVA)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `insulation_medium` SET TAGS ('dbx_business_glossary_term' = 'Insulation Medium');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `insulation_medium` SET TAGS ('dbx_value_regex' = 'AIS|GIS|hybrid');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `interconnection_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `last_major_refurbishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Refurbishment Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_node_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Node Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `number_of_bays` SET TAGS ('dbx_business_glossary_term' = 'Number of Bays');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `number_of_circuit_breakers` SET TAGS ('dbx_business_glossary_term' = 'Number of Circuit Breakers');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `number_of_transformers` SET TAGS ('dbx_business_glossary_term' = 'Number of Power Transformers');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `operating_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Operating Entity Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in-service|out-of-service|under-construction|decommissioned|mothballed');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'investor-owned|municipal|cooperative|federal|joint-ownership|independent');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `owning_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Owning Entity Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `physical_security_level` SET TAGS ('dbx_business_glossary_term' = 'Physical Security Level');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `physical_security_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `pnode_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node (PNode) Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `primary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `protection_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `protection_scheme_type` SET TAGS ('dbx_value_regex' = 'differential|distance|overcurrent|pilot-wire|directional-comparison|hybrid');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization / Independent System Operator (RTO/ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `sap_functional_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Functional Location');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `scada_integration_point` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Point');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `secondary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `seismic_zone` SET TAGS ('dbx_business_glossary_term' = 'Seismic Zone');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `short_circuit_level_ka` SET TAGS ('dbx_business_glossary_term' = 'Short Circuit Level (kA)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State / Province Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_business_glossary_term' = 'Substation Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_business_glossary_term' = 'Substation Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_value_regex' = 'transmission|switching|transformer|converter|collector');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ALTER COLUMN `tertiary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `power_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Power Transformer ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `capital_cost` SET TAGS ('dbx_business_glossary_term' = 'Capital Cost (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `capital_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `cooling_class` SET TAGS ('dbx_business_glossary_term' = 'Cooling Class');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `cooling_class` SET TAGS ('dbx_value_regex' = 'ONAN|ONAF|OFAF|OFWF|ODAF|ODWF');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `current_tap_position` SET TAGS ('dbx_business_glossary_term' = 'Current Tap Position');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `expected_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `gis_location_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `health_index` SET TAGS ('dbx_business_glossary_term' = 'Transformer Health Index');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `health_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `health_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `impedance_percent` SET TAGS ('dbx_business_glossary_term' = 'Impedance Percentage');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `insulation_type` SET TAGS ('dbx_business_glossary_term' = 'Insulation Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `insulation_type` SET TAGS ('dbx_value_regex' = 'mineral_oil|silicone|ester|dry_type|gas');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `is_critical_asset` SET TAGS ('dbx_business_glossary_term' = 'Critical Asset Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `manufacture_year` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `mva_rating` SET TAGS ('dbx_business_glossary_term' = 'Megavolt-Ampere (MVA) Rating');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `nerc_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `oil_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Insulating Oil Volume (Gallons)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|standby|maintenance|testing|decommissioned');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Ownership Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|joint_ownership|customer_owned');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `pcb_contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Polychlorinated Biphenyl (PCB) Contamination Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'three_phase|single_phase|phase_shifting');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `primary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `rto_iso_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `secondary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `tap_changer_type` SET TAGS ('dbx_business_glossary_term' = 'Tap Changer Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `tap_changer_type` SET TAGS ('dbx_value_regex' = 'DETC|LTC|none');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `tap_position_range` SET TAGS ('dbx_business_glossary_term' = 'Tap Position Range');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `tertiary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Voltage (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `transformer_tag` SET TAGS ('dbx_business_glossary_term' = 'Transformer Asset Tag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `transformer_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_business_glossary_term' = 'Transformer Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_value_regex' = 'step_up|step_down|autotransformer|phase_shifting|grounding|regulating');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Transformer Weight (Pounds)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `winding_connection` SET TAGS ('dbx_business_glossary_term' = 'Winding Connection');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ALTER COLUMN `winding_connection` SET TAGS ('dbx_value_regex' = 'delta_wye|wye_delta|delta_delta|wye_wye|zigzag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` SET TAGS ('dbx_subdomain' = 'planning_studies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Path Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Constraint Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `available_transfer_capability_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `average_loss_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Loss Factor Percentage');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `base_case_transfer_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Base Case Transfer Limit Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `capacity_benefit_margin_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Benefit Margin (CBM) Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `congestion_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Congestion Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `congestion_status` SET TAGS ('dbx_value_regex' = 'uncongested|congested|critically_congested|constrained');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `emergency_transfer_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Emergency Transfer Limit Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `ems_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Integration Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `ferc_approved_loss_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Approved Loss Rate Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `flowgate_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Flowgate Rating Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `from_control_area_code` SET TAGS ('dbx_business_glossary_term' = 'From Control Area Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Path Business Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path In-Service Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `last_rating_study_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rating Study Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `length_miles` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Length Miles');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `loss_factor_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Factor Effective Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `loss_factor_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Factor Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `loss_factor_period_type` SET TAGS ('dbx_business_glossary_term' = 'Loss Factor Period Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `loss_factor_period_type` SET TAGS ('dbx_value_regex' = 'peak|off_peak|super_peak|all_hours');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `loss_factor_season` SET TAGS ('dbx_business_glossary_term' = 'Loss Factor Season');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `loss_factor_season` SET TAGS ('dbx_value_regex' = 'summer|winter|spring|fall|annual');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `marginal_loss_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Marginal Loss Factor Percentage');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `nerc_path_designation` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Path Designation');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `nerc_reliability_coordinator` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Coordinator');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `next_rating_study_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rating Study Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `oatt_service_type` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Service Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `oatt_service_type` SET TAGS ('dbx_value_regex' = 'firm|non_firm|network|point_to_point');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Ownership Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|joint_owned|leased|contracted|third_party');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_description` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Description');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_construction|planned');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `path_type` SET TAGS ('dbx_value_regex' = 'flowgate|interface|corridor|tie_line|interconnection|internal');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `rto_iso_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `scada_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitoring Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `to_control_area_code` SET TAGS ('dbx_business_glossary_term' = 'To Control Area Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `total_transfer_capability_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Capability (TTC) Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `transmission_reliability_margin_mw` SET TAGS ('dbx_business_glossary_term' = 'Transmission Reliability Margin (TRM) Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level Kilovolts (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `atc_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) Calculation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `atc_transmission_path_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `state_estimation_run_id` SET TAGS ('dbx_business_glossary_term' = 'State Estimation Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `trading_position_id` SET TAGS ('dbx_business_glossary_term' = 'Related Position Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `atc_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `base_case_generation_mw` SET TAGS ('dbx_business_glossary_term' = 'Base Case Generation in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `base_case_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Base Case Load in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'rated_system_path|network_response|available_flowgate_capability|other');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_run_number` SET TAGS ('dbx_business_glossary_term' = 'Calculation Run Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_software` SET TAGS ('dbx_business_glossary_term' = 'Calculation Software');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'day_ahead|hour_ahead|real_time|monthly|seasonal');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `cbm_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Benefit Margin (CBM) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `ems_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Snapshot Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `etc_mw` SET TAGS ('dbx_business_glossary_term' = 'Existing Transmission Commitments (ETC) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `ferc_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `firm_atc_mw` SET TAGS ('dbx_business_glossary_term' = 'Firm Available Transfer Capability (ATC) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'thermal|voltage|stability|other');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `limiting_contingency` SET TAGS ('dbx_business_glossary_term' = 'Limiting Contingency');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `limiting_facility` SET TAGS ('dbx_business_glossary_term' = 'Limiting Facility');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `non_firm_atc_mw` SET TAGS ('dbx_business_glossary_term' = 'Non-Firm Available Transfer Capability (ATC) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `oasis_posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Open Access Same-Time Information System (OASIS) Posting Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `oatt_service_type` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Service Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `oatt_service_type` SET TAGS ('dbx_value_regex' = 'network|point_to_point_firm|point_to_point_non_firm');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `operator_adjustment_mw` SET TAGS ('dbx_business_glossary_term' = 'Operator Adjustment in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `operator_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Operator Adjustment Reason');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Open Access Same-Time Information System (OASIS) Posting Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|revised|withdrawn');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `scada_data_quality` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Data Quality');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `scada_data_quality` SET TAGS ('dbx_value_regex' = 'good|suspect|stale|unavailable');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `sink_ba_code` SET TAGS ('dbx_business_glossary_term' = 'Sink Balancing Authority (BA) Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `source_ba_code` SET TAGS ('dbx_business_glossary_term' = 'Source Balancing Authority (BA) Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `study_case_code` SET TAGS ('dbx_business_glossary_term' = 'Study Case Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `study_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Study Horizon End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `study_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Study Horizon Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `trm_mw` SET TAGS ('dbx_business_glossary_term' = 'Transmission Reliability Margin (TRM) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `ttc_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Capability (TTC) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `uncertainty_margin_mw` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty Margin in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_review|failed|override');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `transmission_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Request ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `ems_node_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Receipt PNode (Pricing Node) ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `transmission_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `ancillary_services_required` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Required');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `approved_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Approved Capacity (MW - Megawatt)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `estimated_upgrade_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Network Upgrade Cost (USD - United States Dollar)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `estimated_upgrade_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `facilities_study_status` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `facilities_study_status` SET TAGS ('dbx_value_regex' = 'NOT-REQUIRED|PENDING|IN-PROGRESS|COMPLETED|WAIVED');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `ferc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'FERC (Federal Energy Regulatory Commission) Docket Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `ferc_docket_number` SET TAGS ('dbx_value_regex' = '^(ER|EL|RM)[0-9]{2}-[0-9]{3,5}(-[0-9]{3})?$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `ftr_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTR (Financial Transmission Right) Allocation Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'NERC (North American Electric Reliability Corporation) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `network_upgrade_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Upgrade Required Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `point_of_delivery_name` SET TAGS ('dbx_business_glossary_term' = 'Point of Delivery (POD) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `point_of_receipt_name` SET TAGS ('dbx_business_glossary_term' = 'Point of Receipt (POR) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `redirect_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Redirect Rights Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Request Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^TSR-[0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `request_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submitted Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requested_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Requested Capacity (MW - Megawatt)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `requestor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `resale_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Resale Allowed Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `rollover_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Rights Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO (Regional Transmission Organization / Independent System Operator) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'PTP-FIRM|PTP-NON-FIRM|NITS|SECONDARY');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `study_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Study Required Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `system_impact_study_status` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `system_impact_study_status` SET TAGS ('dbx_value_regex' = 'NOT-REQUIRED|PENDING|IN-PROGRESS|COMPLETED|WAIVED');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `transmission_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Agreement Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `fuel_supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Generator Fuel Supply Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Item Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `transmission_customer_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Customer Entity Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Agreement Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^TSA-[A-Z0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Agreement Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `ancillary_services_included` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Included');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `collateral_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Amount in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `collateral_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `contracted_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `energy_charge_rate_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Rate in United States Dollars per Megawatt-Hour (USD/MWh)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `executed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Executed Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `ferc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Docket Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `ferc_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `ferc_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `ferc_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|accepted|rejected|amended');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `last_amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Description');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `monthly_capacity_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Capacity Charge in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `oatt_tariff_version` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Version');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `priority_ranking` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Priority Ranking');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `rate_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'OATT Rate Schedule Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `responsible_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Responsible Account Manager');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `rollover_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Rights Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `service_subtype` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Subtype');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `service_subtype` SET TAGS ('dbx_value_regex' = 'firm|non-firm|conditional_firm');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'PTP|NITS');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `sink_point_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Sink Point of Delivery');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `source_point_of_receipt` SET TAGS ('dbx_business_glossary_term' = 'Source Point of Receipt');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ftr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Position Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ferc_market_report_id` SET TAGS ('dbx_business_glossary_term' = 'Ferc Market Report Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ftr_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Ftr Holding Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Hedged Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `original_ftr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Original Financial Transmission Right (FTR) Position Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `arr_conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Auction Revenue Right (ARR) Conversion Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `arr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Auction Revenue Right (ARR) Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `auction_clearing_price_per_mw` SET TAGS ('dbx_business_glossary_term' = 'Auction Clearing Price per Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `auction_date` SET TAGS ('dbx_business_glossary_term' = 'Auction Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `auction_round` SET TAGS ('dbx_business_glossary_term' = 'Auction Round Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `cumulative_settlement_credit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Settlement Credit in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ferc_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reporting Category');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `flow_direction` SET TAGS ('dbx_business_glossary_term' = 'Flow Direction');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `flow_direction` SET TAGS ('dbx_value_regex' = 'prevailing|counter-flow');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ftr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Business Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ftr_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `ftr_type` SET TAGS ('dbx_value_regex' = 'obligation|option');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `hedge_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Hedge Strategy Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `holding_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Holding Entity Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `holding_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Holding Entity Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `holding_entity_type` SET TAGS ('dbx_value_regex' = 'utility|transmission_customer|affiliate|third_party');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `internal_book_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Book Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `monthly_settlement_credit_usd` SET TAGS ('dbx_business_glossary_term' = 'Monthly Settlement Credit in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `mw_quantity` SET TAGS ('dbx_business_glossary_term' = 'Megawatt (MW) Quantity');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Position Notes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `on_peak_off_peak_designation` SET TAGS ('dbx_business_glossary_term' = 'On-Peak / Off-Peak Designation');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `on_peak_off_peak_designation` SET TAGS ('dbx_value_regex' = 'on-peak|off-peak|24-hour');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `portfolio_grouping` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Grouping');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Position Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|expired|settled|cancelled|pending');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `reconfiguration_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconfiguration Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `rto_iso_market_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `rto_iso_market_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `sink_pnode_code` SET TAGS ('dbx_business_glossary_term' = 'Sink Pricing Node (PNode) Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `sink_pnode_name` SET TAGS ('dbx_business_glossary_term' = 'Sink Pricing Node (PNode) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `source_pnode_code` SET TAGS ('dbx_business_glossary_term' = 'Source Pricing Node (PNode) Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `source_pnode_name` SET TAGS ('dbx_business_glossary_term' = 'Source Pricing Node (PNode) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ALTER COLUMN `trading_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Trading Hub Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Congestion Event Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Causal Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_transmission_path_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `contingency_element_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Element Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `ems_event_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Event Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `ferc_market_report_id` SET TAGS ('dbx_business_glossary_term' = 'Ferc Market Report Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `flowgate_id` SET TAGS ('dbx_business_glossary_term' = 'Flowgate Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `ftr_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Ftr Holding Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `ftr_position_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Position Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Source Pricing Node (PNode) Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `binding_constraint_code` SET TAGS ('dbx_business_glossary_term' = 'Binding Constraint Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Congestion Cost in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_direction` SET TAGS ('dbx_business_glossary_term' = 'Congestion Direction');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_direction` SET TAGS ('dbx_value_regex' = 'forward|reverse|bidirectional');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Congestion End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_severity` SET TAGS ('dbx_business_glossary_term' = 'Congestion Severity Level');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_severity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `congestion_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Congestion Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'thermal|voltage|stability|interface|nomogram');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `curtailed_mw` SET TAGS ('dbx_business_glossary_term' = 'Curtailed Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `element_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Element Rating in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `event_cause` SET TAGS ('dbx_business_glossary_term' = 'Event Cause');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `event_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Event Duration in Minutes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Congestion Event Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|resolved|under_review|escalated');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `ferc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `lmp_differential_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Differential in United States Dollars (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `market_interval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|intra_day|ancillary_services');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `monitored_element_code` SET TAGS ('dbx_business_glossary_term' = 'Monitored Element Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `percent_of_rating` SET TAGS ('dbx_business_glossary_term' = 'Percent of Rating');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `post_contingency_flow_mw` SET TAGS ('dbx_business_glossary_term' = 'Post-Contingency Flow in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `pre_contingency_flow_mw` SET TAGS ('dbx_business_glossary_term' = 'Pre-Contingency Flow in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `remedial_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remedial Action Taken');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `scada_alarm_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Alarm Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `shadow_price_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Shadow Price in United States Dollars (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `sink_lmp_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Sink Locational Marginal Price (LMP) in United States Dollars (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `sink_pnode_code` SET TAGS ('dbx_business_glossary_term' = 'Sink Pricing Node (PNode) Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `source_lmp_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Source Locational Marginal Price (LMP) in United States Dollars (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `tlr_level` SET TAGS ('dbx_business_glossary_term' = 'Transmission Loading Relief (TLR) Level');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `ems_alarm_id` SET TAGS ('dbx_business_glossary_term' = 'Ems Alarm Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `regulatory_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondence Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Restoration Warehouse Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `self_report_id` SET TAGS ('dbx_business_glossary_term' = 'Self Report Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `atc_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) Impact Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `bes_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Facility Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Description');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `customer_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration Hours');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `equipment_age_years` SET TAGS ('dbx_business_glossary_term' = 'Equipment Age Years');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'transmission_line|transformer|circuit_breaker|bus|capacitor_bank|reactor');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `ferc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `load_shed_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Shed Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `mw_impact` SET TAGS ('dbx_business_glossary_term' = 'Megawatt (MW) Impact');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `nerc_outage_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Outage Reporting Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `oe417_report_number` SET TAGS ('dbx_business_glossary_term' = 'Office of Electricity (OE) Form 417 Report Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|restored|cancelled|extended');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|forced|maintenance|emergency|testing|regulatory');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `restoration_method` SET TAGS ('dbx_business_glossary_term' = 'Restoration Method');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_business_glossary_term' = 'Restoration Priority');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `rto_iso_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Notification Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `rto_iso_notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending|not_required|delayed');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `rto_iso_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Notification Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `safety_clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `switching_order_number` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Fahrenheit');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level Kilovolts (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed Miles Per Hour (MPH)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `transmission_switching_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Switching Order ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `outage_switching_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Switching Order Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `state_estimation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Switching State Estimation Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `primary_transmission_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Dispatcher ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `primary_transmission_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `primary_transmission_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `tertiary_transmission_verified_by_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Operator ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `tertiary_transmission_verified_by_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `tertiary_transmission_verified_by_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `affected_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `affected_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `affected_equipment_type` SET TAGS ('dbx_value_regex' = 'circuit_breaker|disconnect_switch|transformer|bus_section|capacitor_bank|reactor');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `affected_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Affected Load Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `atc_recalculation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'ATC (Available Transfer Capability) Recalculation Required Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `cip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CIP (Critical Infrastructure Protection) Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Switching Completion Notes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Switching Duration Minutes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `ems_topology_change_code` SET TAGS ('dbx_business_glossary_term' = 'EMS (Energy Management System) Topology Change ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Switching Failure Reason');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `issuing_dispatcher_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Dispatcher Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `nerc_bes_designation` SET TAGS ('dbx_business_glossary_term' = 'NERC (North American Electric Reliability Corporation) BES (Bulk Electric System) Designation');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `oatt_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OATT (Open Access Transmission Tariff) Impact Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^TSO-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|maintenance|restoration|testing|commissioning');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `outage_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `planned_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Execution Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `post_switching_current_amps` SET TAGS ('dbx_business_glossary_term' = 'Post-Switching Current Amperes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `post_switching_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Post-Switching Voltage Kilovolts (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `pre_switching_current_amps` SET TAGS ('dbx_business_glossary_term' = 'Pre-Switching Current Amperes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `pre_switching_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Pre-Switching Voltage Kilovolts (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Priority Level');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `rto_iso_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'RTO (Regional Transmission Organization) ISO (Independent System Operator) Approval Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `rto_iso_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'RTO (Regional Transmission Organization) ISO (Independent System Operator) Notification Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `safety_clearance_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `scada_command_code` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Command ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Integration Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `switching_action` SET TAGS ('dbx_business_glossary_term' = 'Switching Action');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `switching_sequence_steps` SET TAGS ('dbx_business_glossary_term' = 'Switching Sequence Steps');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Switching Verification Method');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'scada_telemetry|field_visual|relay_indication|meter_reading|remote_camera');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Switching Verification Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Device Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Nerc Cip Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Technician Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `bay_number` SET TAGS ('dbx_business_glossary_term' = 'Bay Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `cip_asset_classification` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Protection (CIP) Asset Classification');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `cip_asset_classification` SET TAGS ('dbx_value_regex' = 'high_impact|medium_impact|low_impact|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `device_subtype` SET TAGS ('dbx_business_glossary_term' = 'Device Subtype');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'protective_relay|circuit_breaker|disconnect_switch|recloser|sectionalizer');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ems_device_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Device ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ems_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ems_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ieee_device_number` SET TAGS ('dbx_business_glossary_term' = 'IEEE Device Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `interrupting_rating_ka` SET TAGS ('dbx_business_glossary_term' = 'Interrupting Rating (kA)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `nerc_bes_designation` SET TAGS ('dbx_business_glossary_term' = 'NERC Bulk Electric System (BES) Designation');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `operating_mechanism_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Mechanism Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|testing|maintenance|standby|retired');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|joint_ownership|third_party');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `owning_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Owning Entity Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protected_element_code` SET TAGS ('dbx_business_glossary_term' = 'Protected Element ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protected_element_type` SET TAGS ('dbx_business_glossary_term' = 'Protected Element Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protected_element_type` SET TAGS ('dbx_value_regex' = 'transmission_line|transformer|bus|generator|capacitor_bank|reactor');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `protection_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `relay_type` SET TAGS ('dbx_business_glossary_term' = 'Relay Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `sap_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Equipment Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `sap_functional_location` SET TAGS ('dbx_business_glossary_term' = 'SAP Functional Location');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `test_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Test Interval (Months)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `trip_counter` SET TAGS ('dbx_business_glossary_term' = 'Trip Counter');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `trip_setting_backup` SET TAGS ('dbx_business_glossary_term' = 'Trip Setting Backup');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `trip_setting_primary` SET TAGS ('dbx_business_glossary_term' = 'Trip Setting Primary');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (kV)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ALTER COLUMN `zone_of_protection` SET TAGS ('dbx_business_glossary_term' = 'Zone of Protection');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `transmission_scada_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission SCADA (Supervisory Control and Data Acquisition) Measurement ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `alarm_limit_high` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Limit');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `alarm_limit_low` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Limit');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `alarm_status` SET TAGS ('dbx_business_glossary_term' = 'Alarm Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `alarm_status` SET TAGS ('dbx_value_regex' = 'normal|high_alarm|low_alarm|high_high_alarm|low_low_alarm|acknowledged');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `analog_digital_indicator` SET TAGS ('dbx_business_glossary_term' = 'Analog Digital Indicator');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `analog_digital_indicator` SET TAGS ('dbx_value_regex' = 'analog|digital|calculated|status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `archive_flag` SET TAGS ('dbx_business_glossary_term' = 'Archive Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `change_of_state_flag` SET TAGS ('dbx_business_glossary_term' = 'Change of State Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `cip_asset_classification` SET TAGS ('dbx_business_glossary_term' = 'CIP (Critical Infrastructure Protection) Asset Classification');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `cip_asset_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|bes_cyber_asset|protected_cyber_asset|electronic_access_point');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `contingency_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Analysis Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `deadband_value` SET TAGS ('dbx_business_glossary_term' = 'Deadband Value');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `ems_state_estimator_flag` SET TAGS ('dbx_business_glossary_term' = 'EMS (Energy Management System) State Estimator Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `engineering_value` SET TAGS ('dbx_business_glossary_term' = 'Engineering Value');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `ferc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'FERC (Federal Energy Regulatory Commission) Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `historian_tag` SET TAGS ('dbx_business_glossary_term' = 'Historian Tag Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `measurement_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy Class');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `measurement_phase` SET TAGS ('dbx_business_glossary_term' = 'Measurement Phase');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `measurement_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'NERC (North American Electric Reliability Corporation) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `normal_operating_range_max` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Range Maximum');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `normal_operating_range_min` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Range Minimum');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `operator_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Override Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `operator_override_user` SET TAGS ('dbx_business_glossary_term' = 'Operator Override User ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `operator_override_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `pnode_code` SET TAGS ('dbx_business_glossary_term' = 'PNode (Pricing Node) ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `raw_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Measurement Value');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EMS (Energy Management System) Received Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'RTO (Regional Transmission Organization) ISO (Independent System Operator) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `rtu_identifier` SET TAGS ('dbx_business_glossary_term' = 'RTU (Remote Terminal Unit) Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `scada_point_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Point Tag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `scada_protocol` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Communication Protocol');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Scan Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ALTER COLUMN `substituted_value_flag` SET TAGS ('dbx_business_glossary_term' = 'Substituted Value Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `transmission_customer_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Customer Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `active_agreement_count` SET TAGS ('dbx_business_glossary_term' = 'Active Agreement Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|letter_of_credit|surety_bond|parent_guarantee|none');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_value_regex' = 'moodys|sp|fitch|dbrs|none');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `credit_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Customer Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `customer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `customer_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Customer Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `customer_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|inactive|default');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Customer Type');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'generator|load_serving_entity|power_marketer|rto_iso|transmission_owner|municipal_utility');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `default_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Default Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `ferc_market_participant_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Market Participant Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `ferc_market_participant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,10}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `firm_service_mw` SET TAGS ('dbx_business_glossary_term' = 'Firm Transmission Service Capacity in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `first_service_date` SET TAGS ('dbx_business_glossary_term' = 'First Transmission Service Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `ftr_holder_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Rights (FTR) Holder Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transmission Service Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `nerc_company_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Company Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `nerc_company_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `network_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Transmission Service Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `non_firm_service_mw` SET TAGS ('dbx_business_glossary_term' = 'Non-Firm Transmission Service Capacity in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Notes');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `oasis_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Open Access Same-Time Information System (OASIS) Account Reference');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `oasis_account_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `point_to_point_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Point-to-Point Transmission Service Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Registration Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_customer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Termination Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` SET TAGS ('dbx_subdomain' = 'planning_studies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `planning_study_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Study Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Supplier Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `interconnection_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Interconnection Queue Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `hedge_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Strategy Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `irp_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Scenario Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Engineer Employee Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Study Approval Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `atc_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) Impact (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `base_case_scenario` SET TAGS ('dbx_business_glossary_term' = 'Base Case Scenario Description');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `contingency_scenario` SET TAGS ('dbx_business_glossary_term' = 'Contingency Scenario Description');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `estimated_project_in_service_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project In-Service Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `ferc_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `generation_additions_mw` SET TAGS ('dbx_business_glossary_term' = 'Generation Additions (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `generation_retirements_mw` SET TAGS ('dbx_business_glossary_term' = 'Generation Retirements (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `identified_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Identified Deficiencies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `load_growth_assumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Growth Assumption (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `load_growth_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Load Growth Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `nerc_model_version` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Model Version');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `nerc_tpl_compliance_category` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Transmission Planning (TPL) Compliance Category');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `oatt_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `peak_off_peak_indicator` SET TAGS ('dbx_business_glossary_term' = 'Peak / Off-Peak Indicator');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `peak_off_peak_indicator` SET TAGS ('dbx_value_regex' = 'peak|off_peak|shoulder');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `planning_horizon_year` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Year');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `power_flow_software_tool` SET TAGS ('dbx_business_glossary_term' = 'Power Flow Software Tool');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `puc_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Filing Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `recommended_projects` SET TAGS ('dbx_business_glossary_term' = 'Recommended Projects');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `renewable_integration_mw` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Integration (MW)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Region');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'summer|winter|spring|fall');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `stability_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Stability Issues Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `stakeholder_review_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Review Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Study Documentation Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_identifier` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier Code');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_team` SET TAGS ('dbx_business_glossary_term' = 'Study Team Members');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type Classification');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `thermal_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Thermal Violations Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`planning_study` ALTER COLUMN `voltage_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Voltage Violations Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` SET TAGS ('dbx_subdomain' = 'planning_studies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` SET TAGS ('dbx_association_edges' = 'transmission.planning_study,transmission.path');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `study_path_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Study Path Analysis Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Study Path Analysis - Transmission Path Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `planning_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Path Analysis - Transmission Planning Study Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `atc_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'ATC Impact Megawatts');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `contingency_scenario` SET TAGS ('dbx_business_glossary_term' = 'Contingency Scenario');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `estimated_upgrade_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Upgrade Cost USD');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `identified_deficiencies` SET TAGS ('dbx_business_glossary_term' = 'Identified Deficiencies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `limiting_contingency` SET TAGS ('dbx_business_glossary_term' = 'Limiting Contingency');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `limiting_facility` SET TAGS ('dbx_business_glossary_term' = 'Limiting Facility');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `recommended_upgrades` SET TAGS ('dbx_business_glossary_term' = 'Recommended Upgrades');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `stability_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Stability Issues Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `thermal_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Thermal Violations Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`study_path_analysis` ALTER COLUMN `voltage_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Voltage Violations Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` SET TAGS ('dbx_subdomain' = 'planning_studies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` SET TAGS ('dbx_association_edges' = 'transmission.transmission_outage,transmission.path');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `outage_path_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Path Impact - Outage Path Impact Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Path Impact - Transmission Outage Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Path Impact - Transmission Path Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `affected_transmission_paths` SET TAGS ('dbx_business_glossary_term' = 'Affected Transmission Paths');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `atc_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability Impact');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `contingency_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Impact Indicator');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `impact_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Impact Duration');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `impact_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impact End Time');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `impact_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Impact Start Time');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_business_glossary_term' = 'Path Restoration Priority');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `rto_notification_required` SET TAGS ('dbx_business_glossary_term' = 'RTO Notification Required');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`outage_path_impact` ALTER COLUMN `ttc_reduction_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Capability Reduction');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` SET TAGS ('dbx_association_edges' = 'transmission.power_transformer,supply.vendor');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `transformer_vendor_service_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer Vendor Service ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `power_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer Vendor Service - Power Transformer Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer Vendor Service - Vendor Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `last_service_date` SET TAGS ('dbx_business_glossary_term' = 'Last Service Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `next_service_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Service Due Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `service_contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `service_contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `service_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Service Frequency Days');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `total_service_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Service Cost');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `total_service_count` SET TAGS ('dbx_business_glossary_term' = 'Total Service Count');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `vendor_role` SET TAGS ('dbx_business_glossary_term' = 'Vendor Role');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transformer_vendor_service` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` SET TAGS ('dbx_association_edges' = 'transmission.transmission_service_agreement,transmission.path');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `path_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Path Reservation Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Path Reservation - Transmission Path Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `transmission_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Path Reservation - Transmission Agreement Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Path Allocation Percentage');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `atc_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'ATC Impact Megawatts');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `curtailment_priority` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Priority Ranking');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `oasis_posting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'OASIS Posting Required Flag');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `path_utilization_factor` SET TAGS ('dbx_business_glossary_term' = 'Path Utilization Factor');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path_reservation` ALTER COLUMN `reserved_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Reserved Capacity Megawatts');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` SET TAGS ('dbx_subdomain' = 'planning_studies');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` SET TAGS ('dbx_association_edges' = 'transmission.transmission_substation,supply.vendor');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `substation_maintenance_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Maintenance Contract ID');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Maintenance Contract - Transmission Substation Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Maintenance Contract - Vendor Id');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract End Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Start Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `last_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Score');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `preferred_vendor_rank` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Rank');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time SLA Hours');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`substation_maintenance_contract` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ALTER COLUMN `constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Constraint Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ALTER COLUMN `parent_constraint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ALTER COLUMN `flowgate_id` SET TAGS ('dbx_business_glossary_term' = 'Flowgate Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ALTER COLUMN `parent_flowgate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`pnode` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`pnode` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`pnode` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` ALTER COLUMN `right_of_way_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Corridor Identifier');
ALTER TABLE `energy_utilities_ecm`.`transmission`.`right_of_way_corridor` ALTER COLUMN `parent_right_of_way_corridor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
