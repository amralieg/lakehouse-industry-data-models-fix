-- Schema for Domain: asset | Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`asset` COMMENT 'Utility asset lifecycle management including generation units, transmission towers, distribution poles, transformers, switchgear, protection relays, substation equipment, fleet vehicles, and facilities. Manages asset registry, condition assessments, work orders, preventive/corrective maintenance schedules, depreciation schedules, capital projects, spare parts inventory, and O&M cost tracking via Ventyx Asset Suite EAM. Supports CAPEX/OPEX planning and RAB valuation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`registry` (
    `registry_id` BIGINT COMMENT 'Unique identifier for the asset registry record. Primary key for the asset registry product.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: asset_registry currently has asset_class (STRING) attribute storing class name/code. This should be normalized to FK pointing to asset_class reference table. The asset_class product is the authoritati',
    `parent_asset_registry_id` BIGINT COMMENT 'Reference to the parent asset in a hierarchical asset structure (e.g., a relays parent transformer, a components parent assembly). Enables bill-of-materials and asset hierarchy navigation.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase or construction cost of the asset in USD. Used for depreciation calculations and financial reporting.',
    `asset_class` STRING COMMENT 'High-level classification of the asset type based on utility functional area. Used for portfolio segmentation and regulatory reporting. [ENUM-REF-CANDIDATE: generation|transmission|distribution|substation|protection|metering|fleet|facility — 8 candidates stripped; promote to reference product]',
    `asset_condition_rating` STRING COMMENT 'Current physical and operational condition assessment of the asset based on inspection and testing. Drives maintenance prioritization and replacement planning.. Valid values are `excellent|good|fair|poor|critical`',
    `asset_name` STRING COMMENT 'Human-readable name or title of the asset for identification and reporting purposes.',
    `asset_tag` STRING COMMENT 'Externally-known unique asset identifier assigned by the utility for tracking and identification purposes. Used across maintenance, inventory, and financial systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `asset_type` STRING COMMENT 'Detailed asset type within the asset class (e.g., power transformer, circuit breaker, transmission tower, distribution pole, generation turbine, relay). [ENUM-REF-CANDIDATE: power_transformer|circuit_breaker|transmission_tower|distribution_pole|generation_turbine|combustion_turbine|steam_turbine|relay|capacitor_bank|voltage_regulator|recloser|sectionalizer|switchgear|substation_battery|diesel_generator|service_vehicle|bucket_truck|operations_center|warehouse — promote to reference product]',
    `book_value` DECIMAL(18,2) COMMENT 'Current net book value of the asset after accumulated depreciation. Updated periodically based on depreciation schedules.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated capacity field (Megawatt, Megavolt-Ampere, Kilovolt, Kilovolt-Ampere, Ampere, Kiloampere).. Valid values are `MW|MVA|kV|kVA|A|kA`',
    `commissioning_date` DATE COMMENT 'Date when the asset was placed into service and became operational. Used for depreciation calculations and lifecycle planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset registry record was first created in the system. Used for data lineage and audit trail.',
    `criticality_score` STRING COMMENT 'Numerical score (typically 1-10) representing the assets criticality to grid reliability and customer service. Used for maintenance prioritization and risk assessment.',
    `data_source_system` STRING COMMENT 'Name of the source system that provided this asset record (e.g., Ventyx Asset Suite, SAP PM, GIS). Used for data lineage and reconciliation.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate depreciation for this asset class. Typically prescribed by regulatory authority.. Valid values are `straight_line|declining_balance|units_of_production|regulatory`',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this asset is subject to EPA environmental regulations (e.g., emissions monitoring, hazardous materials handling, PCB transformer tracking).',
    `failure_risk_category` STRING COMMENT 'Risk category for asset failure based on condition, age, and operational stress. Drives preventive maintenance and replacement strategies.. Valid values are `low|medium|high|critical`',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts code for financial classification of the asset. Required for regulatory financial reporting and rate case filings.. Valid values are `^[0-9]{3}(.[0-9]{1,2})?$`',
    `installation_date` DATE COMMENT 'Date when the asset was physically installed at its location, which may precede commissioning date.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection or condition assessment performed on the asset.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent completed maintenance work order for this asset. Used to calculate next maintenance due dates.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset registry record was most recently modified. Used for change tracking and data synchronization.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset location in decimal degrees. Used for GIS mapping and outage analysis.',
    `location_description` STRING COMMENT 'Human-readable description of the assets physical location (e.g., substation name, pole number, facility address).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset location in decimal degrees. Used for GIS mapping and outage analysis.',
    `maintenance_strategy` STRING COMMENT 'Assigned maintenance approach for this asset based on criticality, failure modes, and cost-benefit analysis. Determines work order generation rules.. Valid values are `reactive|preventive|predictive|condition_based|run_to_failure`',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the asset. Used for spare parts procurement and technical specifications lookup.',
    `nerc_critical_asset_flag` BOOLEAN COMMENT 'Indicates whether this asset is designated as a NERC Critical Cyber Asset or Critical Infrastructure Protection (CIP) asset, requiring enhanced security and compliance controls.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on regulatory requirements or maintenance strategy.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity based on maintenance strategy and interval rules.',
    `operational_status` STRING COMMENT 'Current operational state of the asset in its lifecycle. Determines availability for grid operations and maintenance planning.. Valid values are `in_service|out_of_service|standby|retired|under_construction|commissioned`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the asset. Determines financial treatment, maintenance responsibility, and regulatory reporting requirements.. Valid values are `owned|leased|joint_ownership|customer_owned|third_party`',
    `rab_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this asset is included in the Regulatory Asset Base for rate-making purposes. Critical for CAPEX planning and rate case preparation.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Nameplate capacity or rating of the asset in its primary unit of measure (MW for generation, MVA for transformers, kV for voltage equipment). Critical for grid planning and load management.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this asset registry record is currently active and valid. Used for soft deletes and historical record retention.',
    `retirement_date` DATE COMMENT 'Date when the asset was permanently removed from service and retired. Triggers final depreciation and asset disposal processes.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Critical for warranty tracking and asset identity verification.',
    `service_territory` STRING COMMENT 'Utility service territory or operating region where the asset is located. Used for regulatory reporting and operational planning.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years as determined by engineering standards or regulatory guidance. Used for depreciation and replacement planning.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class of the asset in kilovolts. Used for grid segmentation and equipment compatibility analysis.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage expires. Important for maintenance cost planning and vendor claims.',
    CONSTRAINT pk_registry PRIMARY KEY(`registry_id`)
) COMMENT 'Master record for all utility physical assets including generation units, transmission towers, distribution poles, transformers, switchgear, protection relays, substation equipment, fleet vehicles, and facilities. Captures asset identity, classification, installation details, location (GIS coordinates), manufacturer, model, serial number, commissioning date, rated capacity, voltage class, asset condition rating, operational status, regulatory classification, and RAB (Regulatory Asset Base) inclusion flag. SSOT for asset identity across the enterprise, sourced from Ventyx Asset Suite EAM.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for the asset hierarchy relationship record. Primary key for the asset hierarchy product.',
    `registry_id` BIGINT COMMENT 'Reference to the child asset in the hierarchy structure. Links to the asset registry for the lower-level asset (e.g., equipment, component, device).',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: DER assets must be positioned in utility asset hierarchy for cost allocation to planning areas, outage impact propagation analysis, SCADA aggregation, and regulatory reporting by service territory/vol',
    `hierarchy_registry_id` BIGINT COMMENT 'Reference to the parent asset in the hierarchy structure. Links to the asset registry for the higher-level asset (e.g., substation, facility, network segment).',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of OPEX and CAPEX costs allocated to this hierarchical relationship. Used when a child asset serves multiple parent facilities or network segments and costs must be apportioned. Value between 0.00 and 100.00. Supports regulatory cost allocation and rate case preparation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy relationship record was first created in the system. Used for audit trail, data lineage tracking, and regulatory compliance. Immutable after initial creation.',
    `criticality_inherited_flag` BOOLEAN COMMENT 'Indicates whether the child asset inherits the criticality classification from the parent asset in the hierarchy. True means child criticality is derived from parent (e.g., all equipment in a critical substation is critical). False means child has independent criticality assessment. Used for risk-based maintenance prioritization and outage impact analysis.',
    `depth` STRING COMMENT 'Total depth of the hierarchy tree from this relationship to the deepest leaf node. Used for hierarchy complexity analysis and query optimization. Updated when child relationships are added or removed.',
    `effective_end_date` DATE COMMENT 'Date when this hierarchical relationship ended or was superseded. Null for currently active relationships. Supports historical hierarchy reconstruction for regulatory reporting, asset lifecycle analysis, and audit trails.',
    `effective_start_date` DATE COMMENT 'Date when this hierarchical relationship became active. Supports temporal hierarchy tracking for asset relocations, network reconfigurations, and organizational restructuring. Used for point-in-time hierarchy queries and historical CAPEX/OPEX roll-up.',
    `functional_location_code` STRING COMMENT 'Structured functional location identifier from the enterprise asset management system representing the hierarchical path (e.g., NORTH-SUB132-BAY03-CB01). Aligns with SAP S/4HANA Plant Maintenance functional location structure and Ventyx Asset Suite location hierarchy. Used for work order assignment, maintenance planning, and cost center allocation.',
    `geographic_zone_code` STRING COMMENT 'Geographic or service territory zone identifier for the hierarchical relationship. Used for regional reporting, storm response planning, mutual aid coordination, and geographic cost allocation. Aligns with GIS-based service territory boundaries.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the hierarchy tree structure where level 1 is the top-most parent (e.g., network segment, region) and higher numbers represent deeper nesting (e.g., level 5 might be a component within equipment within a bay within a substation within a zone). Supports depth-based queries and roll-up aggregations.',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchical relationship type. Functional location represents organizational structure (e.g., substation > bay > equipment). Electrical connectivity represents electrical network topology. Linear asset represents sequential physical assets (e.g., transmission line spans). Spatial containment represents physical location nesting. Logical grouping represents business-defined asset groups. System subsystem represents system decomposition.. Valid values are `functional_location|electrical_connectivity|linear_asset|spatial_containment|logical_grouping|system_subsystem`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this hierarchy relationship record was last modified. Updated whenever any attribute changes. Used for audit trail, change detection, and incremental data processing.',
    `maintenance_responsibility_code` STRING COMMENT 'Code identifying the organizational unit or crew responsible for maintenance of assets in this hierarchical relationship. Used for work order routing, preventive maintenance scheduling, and O&M cost tracking. May differ from parent asset responsibility for shared or outsourced maintenance scenarios.',
    `network_segment_code` STRING COMMENT 'Business identifier for the top-level network segment or zone in the hierarchy (e.g., Northern Transmission Zone, Metro Distribution Area). Used for regulatory reporting by network segment, RAB valuation aggregation, and CAPEX/OPEX planning at the network level.',
    `outage_impact_propagation_flag` BOOLEAN COMMENT 'Indicates whether an outage of the parent asset automatically impacts the child asset in this hierarchical relationship. True means child is dependent on parent (e.g., feeder outage when substation is out). False means child can operate independently. Used for outage management, customer impact analysis, and SAIDI/SAIFI calculation.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership or allocation of the child asset to this parent relationship. Used for jointly-owned assets, shared facilities, or cost allocation scenarios where a single asset may have multiple parent relationships with fractional ownership. Value between 0.00 and 100.00. Null for full ownership (100%).',
    `path` STRING COMMENT 'Materialized path representation of the full hierarchical lineage from root to this relationship (e.g., /REGION_NORTH/ZONE_132KV/SUB_NORTHSIDE/BAY_03/). Enables efficient ancestor and descendant queries without recursive joins. Updated when hierarchy structure changes.',
    `planning_area_code` STRING COMMENT 'Integrated resource planning area or load zone identifier for the hierarchical relationship. Used for CAPEX planning, load forecasting aggregation, and IRP scenario modeling. Aligns with transmission planning zones and distribution planning areas.',
    `rab_allocation_flag` BOOLEAN COMMENT 'Indicates whether this hierarchical relationship is used for RAB valuation roll-up and regulatory rate base calculations. True means the relationship is included in RAB aggregation. False means the relationship is excluded (e.g., non-regulated assets, assets under construction). Critical for regulatory financial reporting and rate case preparation.',
    `relationship_notes` STRING COMMENT 'Free-text notes documenting special conditions, exceptions, or business context for this hierarchical relationship. May include reasons for non-standard configurations, temporary arrangements during capital projects, or regulatory reporting exceptions.',
    `relationship_sequence` STRING COMMENT 'Ordinal position of the child asset among siblings under the same parent. Used for ordered hierarchies such as linear assets (transmission tower sequence along a line) or bay numbering within a substation. Null for unordered hierarchies.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the hierarchical relationship. Active indicates the relationship is currently in effect. Inactive indicates the relationship has been terminated. Pending indicates a planned future relationship. Superseded indicates the relationship was replaced by a newer configuration. Planned indicates a relationship scheduled for future capital projects.. Valid values are `active|inactive|pending|superseded|planned`',
    `scada_aggregation_flag` BOOLEAN COMMENT 'Indicates whether SCADA measurements from child assets are aggregated to the parent level in this hierarchy. True means real-time data is rolled up (e.g., substation total load from individual feeders). False means no aggregation. Used for EMS and DMS real-time monitoring and control.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system of record that is the authoritative source for this hierarchy relationship (e.g., VENTYX_ASSET_SUITE, SAP_PM, ARCGIS_UTILITY_NETWORK). Used for data lineage tracking, reconciliation, and master data management. Critical for multi-system integration scenarios.',
    `source_system_record_code` STRING COMMENT 'Primary key or unique identifier of this hierarchy relationship record in the source operational system. Used for bidirectional traceability, data synchronization, and issue resolution. Enables drill-back to source system for detailed investigation.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level in kilovolts for electrical connectivity hierarchies. Represents the voltage class of the hierarchical relationship (e.g., 500kV transmission, 132kV sub-transmission, 11kV distribution). Used for network topology analysis and voltage-based asset segmentation. Null for non-electrical hierarchies.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the parent-child structural hierarchy of utility assets, enabling roll-up from component level (e.g., circuit breaker trip coil) to equipment level (e.g., 132kV circuit breaker) to functional location (e.g., substation bay 3) to facility (e.g., Northside 132kV Substation) to network segment (e.g., Northern Transmission Zone). Each hierarchy record captures parent asset reference, child asset reference, hierarchy level, hierarchy type (functional location, linear asset, electrical connectivity), and effective date range. Supports CAPEX/OPEX cost roll-up, condition aggregation, RAB valuation at any hierarchy level, and regulatory reporting by network segment. Aligned with Ventyx Asset Suite functional location structure, SAP S/4HANA Plant Maintenance hierarchy, and IEC 61968 CIM asset model.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`class` (
    `class_id` BIGINT COMMENT 'Unique identifier for the asset class record. Primary key.',
    `annual_om_cost_per_unit_usd` DECIMAL(18,2) COMMENT 'Standard annual Operations and Maintenance cost per asset unit in this class. Includes routine maintenance, inspections, and minor repairs. Used for OPEX budgeting and lifecycle cost analysis.',
    `asset_category` STRING COMMENT 'High-level functional category of the asset class within the utility value chain. Determines applicable regulatory frameworks and operational management systems. [ENUM-REF-CANDIDATE: generation|transmission|distribution|metering|fleet|facility|substation|protection|scada — 9 candidates stripped; promote to reference product]',
    `asset_class_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the asset class within the utilitys asset taxonomy. Used for regulatory reporting and financial accounting groupings.. Valid values are `^[A-Z0-9]{4,12}$`',
    `asset_class_name` STRING COMMENT 'Full descriptive name of the asset class (e.g., Combined Cycle Gas Turbine, Power Transformer 230kV, Underground Distribution Cable).',
    `asset_type` STRING COMMENT 'Specific technology or equipment type within the asset category (e.g., CCGT, Wind Turbine, Overhead Line, Underground Cable, Circuit Breaker, Relay).',
    `capacity_rating_mw` DECIMAL(18,2) COMMENT 'Nameplate capacity rating in megawatts for generation assets or power handling capacity for transmission/distribution equipment. Null for non-power assets.',
    `capital_expenditure_flag` BOOLEAN COMMENT 'Indicates whether acquisition of assets in this class is typically capitalized (true) or expensed as Operations and Maintenance (OPEX) (false) per accounting policies.',
    `class_status` STRING COMMENT 'Current lifecycle status of this asset class definition in the utilitys asset taxonomy. Only active classes are available for new asset registration.. Valid values are `active|inactive|deprecated|proposed`',
    `condition_assessment_method` STRING COMMENT 'Primary technique(s) used for condition-based health assessment of assets in this class. Supports predictive maintenance and asset replacement prioritization. [ENUM-REF-CANDIDATE: visual_inspection|diagnostic_testing|dissolved_gas_analysis|thermography|partial_discharge|vibration_analysis|oil_analysis — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the system. Supports audit trail and data lineage tracking.',
    `criticality_rating` STRING COMMENT 'Standard criticality classification for assets in this class based on impact to grid reliability, customer service, and safety. Influences maintenance prioritization and spare parts stocking.. Valid values are `critical|high|medium|low`',
    `cybersecurity_classification` STRING COMMENT 'NERC Critical Infrastructure Protection (CIP) cybersecurity impact classification for assets in this class. Determines required cyber controls and monitoring.. Valid values are `high_impact|medium_impact|low_impact|not_applicable`',
    `depreciation_method` STRING COMMENT 'Standard accounting depreciation method applied to assets in this class for financial reporting and Regulatory Asset Base (RAB) valuation.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production`',
    `distributed_energy_resource_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are Distributed Energy Resources requiring integration with Distributed Energy Resource Management System (DERMS) and Advanced Distribution Management System (ADMS).',
    `effective_date` DATE COMMENT 'Date when this asset class definition became effective for use in asset registry and capital planning. Supports historical asset classification tracking.',
    `environmental_impact_category` STRING COMMENT 'Classification of potential environmental impact from operation or failure of assets in this class. Drives EPA compliance requirements and environmental monitoring protocols.. Valid values are `high|medium|low|none`',
    `expected_useful_life_years` STRING COMMENT 'Standard expected service life in years for this asset class. Used for depreciation calculations, capital planning, and replacement forecasting.',
    `expiration_date` DATE COMMENT 'Date when this asset class definition was retired or superseded. Null for currently active asset classes. Supports asset taxonomy version control.',
    `failure_mode_profile` STRING COMMENT 'Typical failure modes and mechanisms for assets in this class (e.g., insulation degradation, mechanical wear, corrosion). Informs reliability-centered maintenance strategies.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts code for capitalization and depreciation reporting. Maps asset class to regulatory accounting categories.. Valid values are `^[0-9]{3,6}$`',
    `gis_layer_name` STRING COMMENT 'Standard GIS feature class or layer name in Esri ArcGIS Utility Network where assets of this class are spatially represented for network modeling and outage analysis.',
    `grid_modernization_category` STRING COMMENT 'Classification of assets in this class within utility grid modernization and smart grid investment programs. Used for capital planning and regulatory cost recovery filings.. Valid values are `advanced_metering|distribution_automation|grid_sensors|energy_storage|ev_infrastructure|legacy`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether assets in this class contain or use hazardous materials (e.g., PCBs in transformers, SF6 in switchgear) requiring special handling and disposal procedures.',
    `iec_standard_reference` STRING COMMENT 'Applicable IEC international standard(s) governing design, testing, and operation of assets in this class (e.g., IEC 60076 for power transformers).',
    `ieee_standard_reference` STRING COMMENT 'Applicable IEEE standard(s) for equipment specifications, testing, and maintenance practices (e.g., IEEE C57.12.00 for transformers).',
    `inspection_frequency_months` STRING COMMENT 'Standard interval in months between scheduled inspections for assets in this class. Null if inspection frequency is condition-based rather than time-based.',
    `interoperability_standard` STRING COMMENT 'Communication protocol or interoperability standard for assets in this class (e.g., DNP3, IEC 61850, Modbus, IEEE 2030.5). Ensures integration with utility control systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this asset class record. Supports change tracking and data quality monitoring.',
    `maintenance_strategy` STRING COMMENT 'Standard maintenance approach for assets in this class. Drives work order scheduling, inspection intervals, and Operations and Maintenance (O&M) cost planning.. Valid values are `preventive|predictive|condition_based|run_to_failure|reliability_centered`',
    `manufacturer_diversity_required_flag` BOOLEAN COMMENT 'Indicates whether reliability standards or utility policy require multiple manufacturers for assets in this class to mitigate common-mode failure risk.',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Industry-standard or utility-specific average operating hours between failures for assets in this class. Used for reliability modeling and spare parts planning.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time in hours required to restore an asset in this class to service following a failure. Includes diagnosis, parts procurement, repair, and testing time.',
    `nerc_asset_type` STRING COMMENT 'NERC-defined asset type classification for bulk electric system reliability reporting and Critical Infrastructure Protection (CIP) compliance.',
    `obsolescence_risk_rating` STRING COMMENT 'Assessment of technology obsolescence and spare parts availability risk for assets in this class. High risk indicates limited vendor support or discontinued product lines.. Valid values are `high|medium|low|none`',
    `rab_eligible_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are eligible for inclusion in the Regulatory Asset Base for rate recovery and Return on Equity (ROE) calculation.',
    `renewable_energy_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are renewable energy generation or Distributed Energy Resource (DER) equipment eligible for Renewable Energy Certificate (REC) generation and Renewable Portfolio Standard (RPS) compliance.',
    `replacement_lead_time_months` STRING COMMENT 'Typical procurement and installation lead time in months for new assets in this class. Critical for capital project planning and long-lead equipment identification.',
    `safety_classification` STRING COMMENT 'Primary safety hazard category for work on assets in this class. Determines required safety training, personal protective equipment (PPE), and work clearance procedures.. Valid values are `high_voltage|confined_space|elevated_work|heavy_equipment|standard`',
    `scada_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether assets in this class require real-time SCADA monitoring and integration with Energy Management System (EMS) or Distribution Management System (DMS).',
    `spare_parts_stocking_strategy` STRING COMMENT 'Standard inventory management approach for spare parts supporting assets in this class. Balances inventory carrying costs against outage risk and restoration time.. Valid values are `critical_spare|insurance_spare|consignment|just_in_time|no_stock`',
    `standard_unit_cost_usd` DECIMAL(18,2) COMMENT 'Baseline unit acquisition cost in USD for assets in this class. Used for capital budgeting, business case analysis, and Regulatory Asset Base (RAB) valuation. Excludes installation and commissioning costs.',
    `technology_generation` STRING COMMENT 'Technology vintage or generation for assets in this class (e.g., Gen 1, Gen 2, Legacy, Current, Next-Gen). Tracks technology evolution and obsolescence risk.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal voltage rating in kilovolts for electrical assets. Null for non-electrical assets (fleet, facilities). Determines applicable safety and maintenance protocols.',
    CONSTRAINT pk_class PRIMARY KEY(`class_id`)
) COMMENT 'Reference classification taxonomy for utility asset types defining asset class codes, asset category (generation, transmission, distribution, metering, fleet, facility), voltage class, technology type (CCGT, wind turbine, overhead line, underground cable, power transformer, circuit breaker, etc.), expected useful life, standard depreciation method, and applicable NERC/IEC/IEEE standards. Drives depreciation schedules, maintenance strategies, and regulatory reporting groupings.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order. Primary key for the work order entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Work orders are frequently driven by regulatory compliance obligations (NERC CIP maintenance requirements, environmental permit conditions, safety inspection mandates). Compliance-driven maintenance s',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution or transmission circuit affected by this work order. Used for outage impact analysis and load transfer planning.',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_run. Business justification: Work order scheduling in utilities requires forecast data (load, generation, weather) to optimize maintenance timing, avoid peak demand periods, and coordinate outages. Operations planning teams use f',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to distribution.network_segment. Business justification: Work orders for conductor replacement, reconductoring, and line patching are tied to specific network segments. Capital project managers and field crews need this link to track segment-level work and ',
    `parent_work_order_id` BIGINT COMMENT 'Reference to a parent work order if this is a child or sub-work order. Used for complex projects broken into multiple work packages.',
    `power_transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.power_transformer. Business justification: Work orders are raised directly against power transformers for maintenance, repair, and replacement. Consistent with existing work_order FKs to transmission_line and transmission_substation. Enables t',
    `registry_id` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Every work order is executed against a specific asset. This is the most fundamental FK in any EAM system — work orders without asset references are unroutable and uncosted.',
    `maintenance_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance schedule or plan that generated this work order. Used for PM compliance tracking and maintenance strategy optimization.',
    `protection_device_id` BIGINT COMMENT 'Foreign key linking to transmission.protection_device. Business justification: Work orders are raised for protection device testing, calibration, firmware updates, and replacement — a NERC PRC-005 compliance requirement. Consistent with existing work_order FKs to transmission as',
    `to_maintenance_plan_id` BIGINT COMMENT 'FK to asset.maintenance_plan.maintenance_plan_id — Preventive maintenance work orders are auto-generated from maintenance plans. The FK traces which plan triggered the work order for compliance tracking and schedule adherence reporting.',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.transformer. Business justification: Work orders for transformer maintenance (oil testing, tap changer service, thermal imaging, replacement) must link to the specific transformer. Core utility field operations process; existing FKs cove',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Work orders for transmission substation maintenance (transformer servicing, breaker testing, relay calibration) require direct linkage to the specific transmission substation for work scheduling, outa',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when work was completed and asset returned to service. Used for outage duration reporting, SAIDI/SAIFI calculation, and maintenance cycle analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work commenced on site. Used for labor tracking, outage duration calculation, and performance analysis.',
    `approved_by` STRING COMMENT 'Name of the person who approved the work order for execution. Used for audit trail and authorization verification.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was approved for execution. Used for approval cycle time analysis and audit trail.',
    `asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Every work order must reference the asset it is performed against. This is the most fundamental FK in asset management — without it, maintenance costs cannot be attributed to assets, and asset history',
    `capex_flag` BOOLEAN COMMENT 'Indicates whether this work order represents capital expenditure (true) or operational expenditure (false). Capital work orders contribute to RAB valuation and depreciation schedules.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was administratively closed and finalized. Used for cycle time analysis and completion reporting.',
    `closure_code` STRING COMMENT 'Standardized code indicating the reason and manner of work order closure. Used for completion analysis, deferral tracking, and maintenance effectiveness metrics.. Valid values are `completed_as_planned|completed_with_variance|deferred|cancelled_duplicate|cancelled_not_required|cancelled_no_access`',
    `closure_notes` STRING COMMENT 'Detailed narrative notes entered by the crew or supervisor upon work order completion, documenting work performed, findings, issues encountered, and recommendations for future maintenance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the system. Used for work order aging analysis and backlog tracking.',
    `equipment_cost` DECIMAL(18,2) COMMENT 'Cost of specialized equipment, tools, and machinery rental or usage allocated to this work order. Includes bucket trucks, cranes, diagnostic equipment, and specialized tooling.',
    `failure_mode` STRING COMMENT 'For corrective and emergency work orders, describes the observed failure or defect mode (e.g., insulation breakdown, mechanical wear, corrosion, overheating, control malfunction) that triggered the work order.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost including wages, benefits, and contractor fees for this work order. Used for O&M cost tracking and rate case justification.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended on this work order across all crew members and contractors. Used for OPEX tracking, productivity analysis, and cost allocation.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work site in decimal degrees. Used for crew dispatch optimization, GIS integration, and spatial analysis.',
    `location_description` STRING COMMENT 'Textual description of the work site location including street address, nearest intersection, substation name, or geographic landmark to assist crew dispatch and navigation.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work site in decimal degrees. Used for crew dispatch optimization, GIS integration, and spatial analysis.',
    `material_cost` DECIMAL(18,2) COMMENT 'Total cost of materials, spare parts, and consumables used in this work order. Sourced from inventory withdrawals and purchase orders. Used for OPEX and CAPEX tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last modified. Used for audit trail and change tracking.',
    `outage_required_flag` BOOLEAN COMMENT 'Indicates whether this work order requires a planned outage or de-energization of the asset or circuit. Used for outage coordination and customer notification.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and resource allocation precedence. Critical for emergency outages, high for reliability-impacting work, medium for routine preventive maintenance, low for deferred work.. Valid values are `critical|high|medium|low`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this work order must be reported to regulatory authorities (PUC, NERC, FERC) due to safety incidents, major equipment failures, or compliance events.',
    `requester_contact` STRING COMMENT 'Phone number or email address of the work order requester for follow-up communication and status updates.',
    `requester_name` STRING COMMENT 'Name of the person or department that originated the work order request. Used for accountability and follow-up communication.',
    `safety_permit_number` STRING COMMENT 'Reference number for the safety work permit or clearance authorization required before work can commence. Ensures compliance with OSHA and utility safety protocols.',
    `scheduled_completion_date` DATE COMMENT 'Planned date when work is scheduled to be completed. Used for outage window planning and service restoration commitments.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin. Used for resource planning, outage coordination, and customer notification.',
    `to_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Every work order is raised against a specific asset. This is the most fundamental transactional-to-master FK in any EAM system. Without it, work orders are orphaned.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the work order including labor, materials, equipment, and contractor fees. Used for OPEX reporting, RAB valuation, and regulatory rate case filings.',
    `warranty_flag` BOOLEAN COMMENT 'Indicates whether this work order is covered under manufacturer or contractor warranty. Used for cost recovery and warranty claim tracking.',
    `work_order_description` STRING COMMENT 'Detailed narrative description of the work to be performed, including scope, specific tasks, safety considerations, and any special instructions for the crew or contractor.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, used for tracking and communication across systems and with contractors.. Valid values are `^WO-[0-9]{8,12}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order. Draft (created but not approved), approved (authorized for scheduling), scheduled (crew assigned and date set), in_progress (work underway), on_hold (temporarily suspended), completed (work finished pending closure), closed (administratively finalized), cancelled (work not performed). [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|on_hold|completed|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by maintenance strategy: preventive (scheduled maintenance), corrective (repair of known defect), emergency (unplanned urgent repair), inspection (condition assessment), capital_project (major upgrade or replacement), or condition_assessment (detailed asset evaluation).. Valid values are `preventive|corrective|emergency|inspection|capital_project|condition_assessment`',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional record for all planned and unplanned maintenance activities on utility assets. Captures work order number, type (preventive, corrective, emergency, inspection, capital project), priority, originating asset, work description, assigned crew/contractor, scheduled start and completion dates, actual start and completion dates, labor hours, material costs, total O&M cost, work order status, safety permit references, and closure codes. Sourced from Ventyx Asset Suite Work Management module and SAP S/4HANA Plant Maintenance (PM) orders.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Unique identifier for the maintenance plan record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Maintenance plans implement regulatory requirements (NERC PRC-005 protection system maintenance, FERC gas pipeline integrity management, environmental permit conditions). Linking plans to obligations ',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.transformer. Business justification: Transformer maintenance plans (oil sampling, dissolved gas analysis, thermography, load tap changer servicing) are mandated by IEEE/NETA standards and insurance requirements. Links preventive maintena',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_permit. Business justification: Maintenance plans for permitted equipment (emissions controls, cooling systems, wastewater treatment) must comply with permit conditions. Utilities track permit-required maintenance frequencies, testi',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Preventive maintenance plans are organized by feeder for patrol inspections, vegetation management, reliability-centered maintenance programs, and regulatory compliance. Enables automated work order g',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Maintenance plans are coordinated with forecast zones to analyze maintenance impact on load/generation forecasts, schedule zone-level outages, and support reliability planning. Enables zone-specific m',
    `power_transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.power_transformer. Business justification: Maintenance plans (oil testing, tap changer service, DGA sampling) are created for specific transformers. Consistent with existing maintenance_plan FKs to transmission_line and transmission_substation',
    `class_id` BIGINT COMMENT 'FK to asset.asset_class.asset_class_id — Maintenance plans are often defined at the asset class level (e.g., all 132kV power transformers get DGA every 2 years). This FK enables class-level maintenance strategy inheritance.',
    `registry_id` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Maintenance plans are defined for specific assets or asset classes. The asset-level FK enables automatic work order generation for the correct asset.',
    `protection_device_id` BIGINT COMMENT 'Foreign key linking to transmission.protection_device. Business justification: NERC PRC-005 mandates documented maintenance plans for protection systems with defined test intervals. Consistent with existing maintenance_plan FKs to transmission assets. Required to schedule and tr',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Transmission line maintenance plans (patrol inspections, ROW clearing, structure inspections, conductor monitoring) are line-specific. Utilities schedule preventive maintenance by line for NERC compli',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Preventive maintenance plans for substation equipment (transformer oil analysis, breaker testing, relay calibration, battery testing) are organized by substation. Utilities schedule and track maintena',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Indicates whether work orders are automatically created by the system when the maintenance plan becomes due (True) or require manual initiation by a planner (False).',
    `compliance_mandatory_flag` BOOLEAN COMMENT 'Indicates whether this maintenance plan is legally or regulatorily mandated (True) or discretionary for asset optimization (False). Mandatory plans cannot be deferred without regulatory approval.',
    `condition_trigger_parameter` STRING COMMENT 'For condition-based maintenance plans, the specific asset health parameter or SCADA measurement that triggers maintenance (e.g., oil_dielectric_strength, vibration_amplitude, temperature_differential, partial_discharge_level). Empty for time-based plans.',
    `condition_trigger_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold value for the condition trigger parameter. When the monitored parameter exceeds (or falls below) this threshold, maintenance is triggered. Empty for time-based plans.',
    `condition_trigger_unit` STRING COMMENT 'Unit of measure for the condition trigger threshold (e.g., kV, ppm, mm/s, degrees_celsius, percent). Empty for time-based plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `cycle_interval_unit` STRING COMMENT 'Unit of measure for the maintenance interval: calendar units (days, weeks, months, years), operational hours, operational cycles, or energy production (MWh for generation assets). [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|mwh — 7 candidates stripped; promote to reference product]',
    `cycle_interval_value` STRING COMMENT 'Numeric value representing the maintenance interval (e.g., 12 for annual, 5 for five-year). Used in conjunction with cycle_interval_unit to calculate next due date.',
    `cycle_type` STRING COMMENT 'Frequency or trigger pattern for maintenance execution. Time-based cycles are calendar-driven; on-condition cycles are triggered by asset health thresholds; on-demand cycles are manually initiated. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|biennial|five_year|ten_year|on_condition|on_demand — 11 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this maintenance plan is scheduled to expire or be retired. Nullable for ongoing plans. Used for asset decommissioning or maintenance strategy transitions.',
    `effective_start_date` DATE COMMENT 'Date when this maintenance plan becomes active and begins generating work orders. Used for phased rollout of new maintenance strategies or asset commissioning.',
    `estimated_contractor_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost of external contractor services required for maintenance execution, expressed in US dollars. Used for OPEX budgeting and procurement planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated total labor hours required to complete all tasks defined in the maintenance plan. Used for crew scheduling, OPEX forecasting, and resource capacity planning.',
    `estimated_material_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost of spare parts, consumables, and materials required for maintenance execution, expressed in US dollars. Used for OPEX budgeting and inventory planning.',
    `functional_location` STRING COMMENT 'Hierarchical location identifier in the asset management system representing the physical or logical location of the asset (e.g., substation, plant, transmission line section). Used for geographic and organizational reporting.',
    `last_execution_date` DATE COMMENT 'Date when maintenance activities under this plan were last completed. Used to calculate the next due date for time-based and usage-based maintenance cycles.',
    `last_execution_work_order_number` STRING COMMENT 'Work order number of the most recent maintenance execution under this plan. Provides traceability to historical maintenance records and completion documentation.. Valid values are `^WO-[A-Z0-9]{8,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance plan record was most recently updated. Used for change tracking and audit compliance.',
    `lead_time_days` STRING COMMENT 'Number of days before the scheduled due date that the work order should be generated, allowing time for planning, material procurement, crew scheduling, and outage coordination.',
    `maintenance_strategy` STRING COMMENT 'High-level maintenance philosophy applied to the asset: preventive (scheduled), predictive (condition monitoring), reliability-centered (RCM analysis-driven), risk-based (prioritized by failure impact), or run-to-failure (no proactive maintenance).. Valid values are `preventive|predictive|reliability_centered|risk_based|run_to_failure`',
    `next_due_date` DATE COMMENT 'Calculated date when the next maintenance execution is scheduled or required. System-calculated based on last execution date, cycle interval, and usage/condition triggers.',
    `next_scheduled_work_order_number` STRING COMMENT 'Work order number of the upcoming maintenance execution that has been generated but not yet completed. Empty if no future work order has been created.. Valid values are `^WO-[A-Z0-9]{8,12}$`',
    `outage_required_flag` BOOLEAN COMMENT 'Indicates whether execution of this maintenance plan requires taking the asset out of service (True) or can be performed while the asset is energized or in standby (False). Critical for outage coordination and reliability planning.',
    `plan_asset_class` BIGINT COMMENT 'FK to asset.asset_class.asset_class_id — Maintenance plans are typically defined at the asset class level (all 132kV transformers get the same PM plan). This FK enables plan-to-class association.',
    `plan_description` STRING COMMENT 'Detailed textual description of the maintenance plan objectives, scope, and special instructions. Provides context for planners and technicians executing the work.',
    `plan_name` STRING COMMENT 'Descriptive name of the maintenance plan for human identification and reporting purposes.',
    `plan_number` STRING COMMENT 'Business identifier for the maintenance plan, externally visible and used in work order generation and asset management reporting.. Valid values are `^MP-[A-Z0-9]{8,12}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the maintenance plan. Active plans generate work orders automatically; suspended plans are temporarily paused; inactive plans are disabled but retained for historical reference; retired plans are archived.. Valid values are `draft|active|suspended|inactive|retired`',
    `plan_type` STRING COMMENT 'Classification of the maintenance strategy: time-based (calendar-driven), condition-based (triggered by asset condition thresholds), usage-based (driven by operational hours or cycles), predictive (AI/ML-driven forecasting), regulatory (compliance-mandated), or corrective (reactive repair).. Valid values are `time_based|condition_based|usage_based|predictive|regulatory|corrective`',
    `planning_plant_code` STRING COMMENT 'Organizational unit responsible for maintenance planning and execution. Aligns with SAP PM planning plant structure for multi-site utility operations.. Valid values are `^PP-[A-Z0-9]{4,8}$`',
    `priority` STRING COMMENT 'Business priority level for maintenance execution. Critical plans address safety or regulatory compliance; high priority plans prevent major outages; medium and low priority plans optimize asset performance and lifecycle cost.. Valid values are `critical|high|medium|low`',
    `regulatory_driver` STRING COMMENT 'Specific regulatory standard, code, or compliance requirement that mandates this maintenance plan (e.g., NERC FAC-003 Transmission Vegetation Management, NERC PRC-005 Protection System Maintenance, OSHA 1910.269 Electric Power Generation). Empty if not compliance-driven.',
    `safety_requirements` STRING COMMENT 'Specific safety protocols, personal protective equipment (PPE), lockout/tagout (LOTO) procedures, or clearance requirements mandated for maintenance execution under this plan. Ensures OSHA 1910.269 compliance.',
    `scheduling_window_days` STRING COMMENT 'Allowable time window (in days) after the due date within which maintenance can be performed without being considered overdue. Provides scheduling flexibility for resource optimization and outage coordination.',
    `task_list_reference` STRING COMMENT 'Reference code to the detailed task list or work instruction document that defines the specific maintenance activities, inspection points, and procedures to be executed under this plan.. Valid values are `^TL-[A-Z0-9]{6,10}$`',
    `to_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Maintenance plans are assigned to specific assets or asset classes. The FK to asset_registry enables plan-to-asset resolution for work order generation.',
    `usage_trigger_parameter` STRING COMMENT 'For usage-based maintenance plans, the operational metric that triggers maintenance (e.g., operating hours for turbines, breaker operations for circuit breakers, MWh generated for generators). Empty for time-based and condition-based plans.. Valid values are `operating_hours|start_stop_cycles|mwh_generated|breaker_operations|tap_changer_operations`',
    `usage_trigger_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold value for the usage trigger parameter. When cumulative usage since last maintenance reaches this threshold, maintenance is triggered. Empty for time-based and condition-based plans.',
    `work_order_type` STRING COMMENT 'Classification of work orders automatically generated by this maintenance plan. Determines work order routing, approval workflows, and cost accounting treatment in Ventyx Asset Suite and SAP PM. [ENUM-REF-CANDIDATE: preventive_maintenance|predictive_maintenance|inspection|calibration|testing|overhaul|refurbishment — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_maintenance_plan PRIMARY KEY(`maintenance_plan_id`)
) COMMENT 'Preventive and predictive maintenance strategy definition for an asset class or individual asset. Captures maintenance plan type (time-based, condition-based, usage-based), maintenance cycle (e.g., annual, 5-year), task list reference, required materials, estimated labor hours, regulatory compliance driver (e.g., NERC FAC-003, OSHA), last execution date, next due date, and plan active status. Drives automatic work order generation in Ventyx Asset Suite and SAP PM.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`failure_event` (
    `failure_event_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key.',
    `capacitor_bank_id` BIGINT COMMENT 'Foreign key linking to distribution.capacitor_bank. Business justification: Capacitor bank failures (fuse blowing, bank explosion, control failure) are tracked as failure events for reliability reporting and root cause analysis. Asset managers need this link to correlate fail',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: DER equipment failures (inverter trips, battery faults, turbine blade damage) tracked for reliability analysis, warranty claims, RPS compliance reporting, and NERC event reporting. Required for root c',
    `direct_load_control_device_id` BIGINT COMMENT 'Foreign key linking to demand.direct_load_control_device. Business justification: DLC device failures (communication loss, control malfunction, hardware failure) impact DR program dispatch capability. Failure tracking supports reliability analysis, root cause investigation, and dev',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Failure events must be attributed to feeders for IEEE 1366 reliability reporting (SAIDI/SAIFI/CAIDI), root cause analysis, worst-performing feeder identification, and targeted reliability improvement ',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to asset.inspection. Business justification: A failure event is frequently discovered during or triggered by a periodic or event-driven inspection. Linking failure_event.inspection_id → inspection.inspection_id allows traceability from the inspe',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to distribution.network_segment. Business justification: Conductor failures (wire down, cable fault, tree contact) are tracked as failure events tied to specific network segments for reliability analysis, capital replacement prioritization, and vegetation m',
    `power_transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.power_transformer. Business justification: Transformer failures are critical reliability events requiring NERC EOP reporting and root cause analysis. Consistent with existing failure_event FKs to transmission_line and transmission_substation. ',
    `registry_id` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Failure events must reference the failed asset for reliability analysis, MTBF calculations, and NERC reporting. Core FK for RCM analysis.',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order created to address the failure.',
    `protection_device_id` BIGINT COMMENT 'Foreign key linking to transmission.protection_device. Business justification: Protection device misoperations and failures are NERC PRC-004 reportable events requiring root cause analysis. Consistent with existing failure_event FKs to transmission assets. Enables relay misopera',
    `sectionalizing_device_id` BIGINT COMMENT 'Foreign key linking to distribution.sectionalizing_device. Business justification: Sectionalizing device failures (recloser lockout, switch failure-to-operate, fuse blowing) are primary outage causes tracked in failure events for IEEE 1366 reliability reporting and root cause analys',
    `to_work_order_id` BIGINT COMMENT 'FK to asset.work_order.work_order_id — Failure events typically generate corrective work orders. The FK links the failure to its remediation for root cause analysis and cost tracking.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Equipment failures on transmission lines must be tracked to the specific line for reliability analysis (SAIDI/SAIFI metrics), root cause analysis, NERC reporting, and maintenance optimization. Essenti',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Substation equipment failures require linkage to the specific substation for reliability metrics, outage analysis, root cause investigation, and regulatory reporting. Utilities track failure history b',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: Failure events are correlated with specific weather conditions (temperature, wind, precipitation) for root cause analysis, predictive maintenance modeling, and reliability engineering. Standard practi',
    `affected_component` STRING COMMENT 'Specific component or subsystem of the asset that failed (e.g., transformer winding, circuit breaker mechanism).',
    `asset_age_years` DECIMAL(18,2) COMMENT 'Age of the asset in years at the time of failure. Used for age-based reliability analysis.',
    `caidi_contribution_minutes` DECIMAL(18,2) COMMENT 'Contribution of this failure event to the overall CAIDI reliability metric for the reporting period.',
    `corrective_action_plan` STRING COMMENT 'Description of preventive measures and process improvements to prevent recurrence of similar failures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure event record was first created in the asset management system.',
    `customers_affected_count` STRING COMMENT 'Number of customers who experienced service interruption due to this failure. Used for SAIFI calculation.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the failure was detected by SCADA, protection relays, or field personnel.',
    `energy_not_supplied_mwh` DECIMAL(18,2) COMMENT 'Total energy in megawatt-hours that could not be delivered to customers due to the failure.',
    `failure_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Every failure event must reference the failed asset. Critical for reliability analysis, MTBF calculations, and NERC reporting.',
    `failure_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure per utility taxonomy.',
    `failure_cause_description` STRING COMMENT 'Detailed narrative description of the failure cause including contributing factors and conditions.',
    `failure_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the failure including repair labor, materials, equipment replacement, and lost revenue.',
    `failure_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the failure cost amount.. Valid values are `^[A-Z]{3}$`',
    `failure_location` STRING COMMENT 'Physical location or component within the asset where the failure occurred.',
    `failure_mode` STRING COMMENT 'Primary mode of failure categorizing the physical mechanism of breakdown.. Valid values are `electrical|mechanical|thermal|insulation|corrosion|external_damage`',
    `failure_number` STRING COMMENT 'Business identifier for the failure event, typically auto-generated by the asset management system.',
    `failure_status` STRING COMMENT 'Current lifecycle status of the failure event record in the asset management workflow.. Valid values are `open|under_investigation|rca_in_progress|resolved|closed`',
    `failure_timestamp` TIMESTAMP COMMENT 'Date and time when the asset failure occurred. Critical for reliability analysis and SAIDI/SAIFI calculations.',
    `failure_type` STRING COMMENT 'Classification of the failure event by operational impact and planning status.. Valid values are `forced_outage|planned_outage|degraded_operation|partial_failure`',
    `investigated_by` STRING COMMENT 'Name or identifier of the engineer or team responsible for investigating the failure.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the asset prior to failure.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this failure event record was most recently modified.',
    `load_interrupted_mw` DECIMAL(18,2) COMMENT 'Amount of electrical load in megawatts that was interrupted by the failure event.',
    `nerc_report_submitted_date` DATE COMMENT 'Date when the NERC reliability report was submitted for this failure event, if applicable.',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this failure event meets NERC reporting thresholds for reliability compliance.',
    `operating_hours_at_failure` DECIMAL(18,2) COMMENT 'Cumulative operating hours of the asset at the time of failure. Used for MTBF analysis.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the forced outage in minutes from failure to restoration. Used for SAIDI calculation.',
    `puc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this failure event must be reported to the state Public Utility Commission.',
    `repair_action_taken` STRING COMMENT 'Description of the corrective action performed to restore the asset to service.',
    `reported_by` STRING COMMENT 'Name or identifier of the person or system that reported the failure event.',
    `restoration_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was restored to normal operation following repair.',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis has been completed for this failure event.',
    `root_cause_analysis_findings` STRING COMMENT 'Summary of root cause analysis findings including identified systemic issues and contributing factors.',
    `saidi_contribution_minutes` DECIMAL(18,2) COMMENT 'Contribution of this failure event to the overall SAIDI reliability metric for the reporting period.',
    `saifi_contribution` DECIMAL(18,2) COMMENT 'Contribution of this failure event to the overall SAIFI reliability metric for the reporting period.',
    `severity_level` STRING COMMENT 'Severity classification based on safety risk, customer impact, and asset damage extent.. Valid values are `critical|major|moderate|minor`',
    `to_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Failure events record which asset failed. Without this FK, reliability analysis (MTBF, failure rate by asset class) is impossible.',
    CONSTRAINT pk_failure_event PRIMARY KEY(`failure_event_id`)
) COMMENT 'Records of asset failures, forced outages, and equipment breakdowns including failure date and time, failure mode (electrical, mechanical, thermal, insulation, corrosion, external damage), failure cause, affected asset, associated outage reference, repair action taken, root cause analysis findings, failure cost, and SAIDI/SAIFI impact contribution. Supports reliability-centered maintenance (RCM) analysis and NERC reliability reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`capital_project` (
    `capital_project_id` BIGINT COMMENT 'Unique identifier for the capital expenditure project. Primary key for the capital project entity.',
    `registry_id` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Capital projects create or refurbish assets. Linking project to resulting asset enables CAPEX-to-RAB traceability and in-service date tracking.',
    `irp_scenario_id` BIGINT COMMENT 'Foreign key linking to forecast.irp_scenario. Business justification: Capital projects are planned and justified based on specific IRP scenarios. Project timing, scope, and budget are driven by IRP load growth, capacity needs, and retirement assumptions. Standard utilit',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to distribution.network_segment. Business justification: Capital projects for reconductoring, undergrounding, and line upgrades are tied to specific network segments. Existing capital_project links to feeder and substation but not segment-level, which is ne',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to forecast.planning_period. Business justification: Capital projects are budgeted, approved, and tracked within specific planning periods (annual budget cycles, multi-year capital plans). Standard utility financial planning and regulatory reporting req',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Utility capital projects for renewable procurement (transmission upgrades, substation expansions enabling PPA delivery) must link to associated PPA contracts for regulatory cost recovery, rate base tr',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_case. Business justification: Capital projects are justified and approved for cost recovery in rate cases. Utilities must track which rate case authorized capital investments for regulatory accounting, prudency reviews, and rate b',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.transformer. Business justification: Capital projects for transformer replacement or upgrade (capacity increase, PCB remediation, smart transformer installation) must link to the specific transformer being replaced. Existing capital_proj',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Capital projects are executed on specific transmission lines (reconductoring, uprating, line extensions). Required for transmission capital planning, FERC rate case support, and RAB inclusion tracking',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Capital projects are executed at transmission substations (breaker replacement, transformer additions, substation expansion). capital_project has distribution_substation_id but no transmission_substat',
    `actual_completion_date` DATE COMMENT 'Actual date when the capital project completed all construction and commissioning activities.',
    `actual_in_service_date` DATE COMMENT 'Actual date when the asset or infrastructure resulting from the capital project was placed into operational service and began providing utility function.',
    `actual_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual capital expenditure incurred and paid to date for the project, including all invoiced and settled costs.',
    `actual_start_date` DATE COMMENT 'Actual date when the capital project execution activities commenced.',
    `approved_capex_budget` DECIMAL(18,2) COMMENT 'Total capital expenditure budget approved for the project by the appropriate governance authority. Represents the authorized spending limit.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this capital project record.. Valid values are `^[A-Z]{3}$`',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Rated capacity in megawatts for generation or transmission projects. Represents the power handling capability of the infrastructure being built or upgraded.',
    `committed_spend` DECIMAL(18,2) COMMENT 'Total amount of capital expenditure committed through purchase orders, contracts, and other binding obligations, but not yet paid.',
    `contractor_name` STRING COMMENT 'Name of the primary contractor or engineering-procurement-construction (EPC) firm executing the capital project.',
    `cpcn_reference_number` STRING COMMENT 'Reference number for the Certificate of Public Convenience and Necessity issued by the state Public Utility Commission authorizing the capital project. Required for major utility infrastructure investments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was first created in the system.',
    `depreciation_method` STRING COMMENT 'Accounting depreciation method to be applied to the assets resulting from the capital project once placed in service.. Valid values are `straight_line|declining_balance|units_of_production|regulatory`',
    `estimated_useful_life_years` STRING COMMENT 'Expected useful life in years for the assets resulting from the capital project, used for depreciation and asset management planning.',
    `ferc_reportable_flag` BOOLEAN COMMENT 'Indicates whether the capital project must be reported to FERC for regulatory oversight and rate case proceedings.',
    `funding_source` STRING COMMENT 'Primary source of capital funding for the project: internal cash reserves, debt financing, equity issuance, government grants, customer contributions, or rate recovery mechanisms.. Valid values are `internal_cash|debt_financing|equity|grants|customer_contributions|rate_recovery`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was last updated or modified.',
    `nerc_compliance_flag` BOOLEAN COMMENT 'Indicates whether the capital project is subject to NERC reliability standards and compliance requirements.',
    `planned_completion_date` DATE COMMENT 'Target date for the capital project to complete all construction and commissioning activities.',
    `planned_in_service_date` DATE COMMENT 'Target date for the asset or infrastructure resulting from the capital project to be placed into operational service.',
    `planned_start_date` DATE COMMENT 'Planned date for the capital project to commence execution activities.',
    `project_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Capital projects create or refurbish assets. The link from project to resulting asset(s) is required for CAPEX-to-RAB traceability and commissioning workflows.',
    `project_category` STRING COMMENT 'High-level asset category that the capital project targets: generation units, transmission infrastructure, distribution network, substation equipment, facilities, fleet vehicles, or IT infrastructure. [ENUM-REF-CANDIDATE: generation|transmission|distribution|substation|facilities|fleet|it_infrastructure — 7 candidates stripped; promote to reference product]',
    `project_closeout_date` DATE COMMENT 'Date when the capital project was formally closed out, including final cost reconciliation, asset capitalization, and administrative closure.',
    `project_description` STRING COMMENT 'Detailed narrative description of the capital project scope, objectives, deliverables, and expected benefits.',
    `project_justification` STRING COMMENT 'Primary business driver or justification for the capital project: reliability improvement, capacity expansion, regulatory compliance, safety enhancement, operational efficiency, customer service improvement, or environmental requirement. [ENUM-REF-CANDIDATE: reliability|capacity|compliance|safety|efficiency|customer_service|environmental — 7 candidates stripped; promote to reference product]',
    `project_name` STRING COMMENT 'Human-readable name or title of the capital project describing its purpose and scope.',
    `project_number` STRING COMMENT 'Externally-known unique business identifier for the capital project, typically assigned by the ERP system. Used for cross-system reference and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `project_phase` STRING COMMENT 'Current execution phase of the capital project within the project delivery lifecycle.. Valid values are `feasibility|design|procurement|construction|commissioning|closeout`',
    `project_priority` STRING COMMENT 'Business priority level assigned to the capital project for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `project_status` STRING COMMENT 'Current lifecycle status of the capital project indicating its phase in the project delivery workflow. [ENUM-REF-CANDIDATE: feasibility|design|approved|procurement|construction|commissioning|closeout|cancelled|on_hold — 9 candidates stripped; promote to reference product]',
    `project_type` STRING COMMENT 'Classification of the capital project by its primary purpose: new asset construction, asset replacement, system upgrade, major refurbishment, regulatory compliance, or network augmentation.. Valid values are `new_build|replacement|upgrade|refurbishment|compliance|augmentation`',
    `rab_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the project capital expenditure that is eligible for inclusion in the Regulatory Asset Base. May be less than 100% if only portions are rate-recoverable.',
    `rab_eligible_flag` BOOLEAN COMMENT 'Indicates whether the capital expenditure from this project is eligible for inclusion in the Regulatory Asset Base for rate recovery purposes.',
    `risk_level` STRING COMMENT 'Overall risk assessment level for the capital project considering technical, financial, regulatory, and execution risks.. Valid values are `low|medium|high|critical`',
    `service_territory` STRING COMMENT 'Geographic service territory or region where the capital project assets will be located and provide utility service.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which the capital project record originated: SAP Project System, Ventyx Asset Suite, SAP S/4HANA, or manual entry.. Valid values are `SAP_PS|VENTYX|S4HANA|MANUAL`',
    `source_system_record_code` STRING COMMENT 'Unique identifier for the capital project record in the source system, used for data lineage and reconciliation.',
    `sponsoring_business_unit` STRING COMMENT 'The business unit or division that owns and sponsors the capital project, responsible for funding and business case justification.',
    `to_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Capital projects create or refurbish assets. The FK links project spend to the resulting asset for RAB capitalization and commissioning tracking.',
    `variance_to_budget` DECIMAL(18,2) COMMENT 'Calculated variance between actual spend to date and approved CAPEX budget. Positive values indicate over-budget, negative values indicate under-budget.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Primary voltage level in kilovolts for electrical infrastructure projects. Applicable to transmission, distribution, and substation projects.',
    CONSTRAINT pk_capital_project PRIMARY KEY(`capital_project_id`)
) COMMENT 'Capital expenditure project record for new asset construction, major refurbishment, or network augmentation. Captures project number, project name, project type (new build, replacement, upgrade, compliance), sponsoring business unit, project manager, approved CAPEX budget, committed spend, actual spend to date, project phase (feasibility, design, procurement, construction, commissioning, closeout), planned in-service date, actual in-service date, CPCN reference, and RAB eligibility flag. Sourced from SAP S/4HANA Project System (PS) and Ventyx Asset Suite.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Unique identifier for the depreciation schedule record. Primary key for the depreciation schedule entity.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to asset.capital_project. Business justification: When a capital project completes and an asset is placed in service, a depreciation schedule is created for that asset. Linking depreciation_schedule.capital_project_id → capital_project.capital_projec',
    `class_id` BIGINT COMMENT 'FK to asset.asset_class.asset_class_id — Depreciation methods and useful life defaults are driven by asset class. This FK enables class-level depreciation policy inheritance.',
    `registry_id` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Depreciation schedules are defined per asset. Without this FK, depreciation charges cannot be allocated to specific assets for RAB valuation and financial reporting.',
    `accounting_period` STRING COMMENT 'Accounting period (month) within the fiscal year to which this depreciation schedule record applies. Typically 1-12.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Increases each period by the depreciation charge.',
    `accumulated_depreciation_gl_account_code` STRING COMMENT 'General ledger account code for the accumulated depreciation contra-asset account on the balance sheet.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired or placed in service. Marks the start of the depreciation period.',
    `annual_depreciation_charge` DECIMAL(18,2) COMMENT 'Annual depreciation expense allocated to the asset under the selected depreciation method. For straight-line: depreciable base divided by useful life years.',
    `business_area_code` STRING COMMENT 'Business area or operating segment (e.g., generation, transmission, distribution, retail) to which this asset and its depreciation expense are allocated.',
    `capex_opex_classification` STRING COMMENT 'Classification of the asset as capital expenditure (CAPEX) or operational expenditure (OPEX) for financial planning and regulatory reporting purposes. CAPEX assets are capitalized and depreciated; OPEX items are expensed immediately.. Valid values are `capex|opex`',
    `company_code` STRING COMMENT 'Company code or legal entity to which this depreciation schedule belongs. Supports multi-entity utility holding companies.',
    `cost_center_code` STRING COMMENT 'Cost center to which depreciation expense is allocated for internal management accounting and OPEX tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this depreciation schedule record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this depreciation schedule (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciable_base` DECIMAL(18,2) COMMENT 'Amount subject to depreciation, calculated as original cost minus salvage value. Used as the basis for annual depreciation charge calculation.',
    `depreciation_area_code` STRING COMMENT 'Code identifying the depreciation area or ledger (e.g., book depreciation, tax depreciation, regulatory depreciation) to which this schedule applies. Utilities often maintain parallel depreciation schedules for different reporting purposes.',
    `depreciation_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Depreciation schedules must reference the asset being depreciated. Required for RAB valuation and financial reporting.',
    `depreciation_end_date` DATE COMMENT 'Date on which depreciation calculation ends for this asset. Typically the date the asset is fully depreciated, retired, or disposed of.',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation expense over the assets useful life. Straight-line is most common for utility assets; units of production may be used for generation equipment; regulatory composite may be mandated by PUC for rate-regulated assets.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits|regulatory_composite`',
    `depreciation_start_date` DATE COMMENT 'Date on which depreciation calculation begins for this asset. Typically the placed-in-service date or the first day of the following month.',
    `depreciation_status` STRING COMMENT 'Current status of the depreciation schedule. Active indicates ongoing depreciation; fully depreciated indicates the asset has reached its salvage value; suspended indicates temporary halt; retired/disposed indicates asset is no longer in service.. Valid values are `active|fully_depreciated|suspended|retired|disposed`',
    `depreciation_to_asset` BIGINT COMMENT 'FK to asset.asset_registry.asset_registry_id — Each depreciation schedule is assigned to a specific asset for financial reporting, RAB valuation, and SOX compliance. This is a mandatory FK for fixed asset accounting.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this depreciation schedule record applies. Enables year-over-year tracking of depreciation expense and accumulated depreciation.',
    `functional_area_code` STRING COMMENT 'Functional area (e.g., operations, maintenance, administration) to which depreciation expense is allocated for cost analysis.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which depreciation expense is posted. Typically a depreciation expense account in the income statement.',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Indicates whether the asset has been identified as potentially impaired (carrying value may exceed recoverable amount). Triggers impairment testing under GAAP ASC 360.',
    `last_depreciation_run_date` DATE COMMENT 'Date of the most recent depreciation calculation run for this asset. Used to track depreciation processing and ensure timely financial close.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this depreciation schedule record was last modified in the source system.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset on the balance sheet, calculated as original cost minus accumulated depreciation. Also known as book value or carrying amount.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this depreciation schedule, including adjustments, regulatory guidance, or special circumstances.',
    `original_cost` DECIMAL(18,2) COMMENT 'Original acquisition or construction cost of the asset, including capitalized installation, engineering, and AFUDC (Allowance for Funds Used During Construction). Basis for depreciation calculation.',
    `placed_in_service_date` DATE COMMENT 'Date the asset was placed into operational service and began generating revenue or providing utility function. Depreciation typically begins on this date.',
    `rab_depreciation_treatment` STRING COMMENT 'Treatment of this assets depreciation in the Regulatory Asset Base (RAB) for rate-making purposes. Determines whether depreciation expense is recoverable through customer rates.. Valid values are `included|excluded|deferred|accelerated|regulatory_lag`',
    `rab_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this asset is included in the Regulatory Asset Base (RAB) for rate-making purposes. True if included; false if excluded.',
    `regulatory_depreciation_rate_percent` DECIMAL(18,2) COMMENT 'Depreciation rate (as a percentage of original cost) approved by the Public Utility Commission (PUC) for rate-making purposes. May differ from book depreciation rate.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining useful life of the asset in years as of the current reporting period. Calculated as original useful life minus elapsed time since placed in service.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Subtracted from original cost to determine depreciable base.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this depreciation schedule record originated (e.g., SAP_S4HANA, VENTYX_ASSET_SUITE).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this depreciation schedule record in the source system. Enables traceability and reconciliation.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method used for tax reporting purposes. May differ from book depreciation method. MACRS (Modified Accelerated Cost Recovery System) is common in the US.. Valid values are `macrs|straight_line|declining_balance|bonus_depreciation|section_179`',
    `tax_useful_life_years` DECIMAL(18,2) COMMENT 'Useful life of the asset for tax depreciation purposes, as defined by tax regulations. May differ from book useful life.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the asset in years, as determined by engineering assessment and regulatory guidance. Used to calculate annual depreciation charge under straight-line or declining balance methods.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Asset depreciation schedule defining the financial depreciation profile for each utility asset or asset class. Captures depreciation method (straight-line, declining balance, units of production), useful life (years), salvage value, annual depreciation charge, accumulated depreciation, net book value, regulatory depreciation rate (as approved by PUC), and RAB depreciation treatment. Supports CAPEX/OPEX planning, regulatory asset base (RAB) valuation, and SOX-compliant financial reporting. Sourced from SAP S/4HANA Fixed Asset Accounting (FI-AA).';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` (
    `spare_parts_inventory_id` BIGINT COMMENT 'Unique identifier for the spare parts inventory record. Primary key for the spare parts inventory product.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Utilities stock spare parts for utility-owned/operated DER assets (utility-scale solar inverters, battery storage components, wind turbine parts). Inventory management, warranty claims, and maintenanc',
    `direct_load_control_device_id` BIGINT COMMENT 'Foreign key linking to demand.direct_load_control_device. Business justification: Spare parts inventory for DLC devices (communication modules, control relays, thermostats) supports DR program reliability. Warehouse management links spare parts to device models for reorder point ca',
    `class_id` BIGINT COMMENT 'FK to asset.asset_class.asset_class_id — Spare parts are stocked for specific asset classes (e.g., bushings for 132kV transformers). This FK enables parts applicability lookup during work order planning.',
    `registry_id` BIGINT COMMENT 'FK to asset.asset_class.asset_class_id — Spare parts are stocked for specific asset classes. This FK enables identification of which parts serve which equipment types for inventory optimization.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and usage frequency. A items are high-value or high-usage requiring tight control and frequent review, B items are moderate-value with standard controls, C items are low-value with minimal controls. Used for cycle counting frequency and inventory management prioritization.. Valid values are `A|B|C`',
    `bin_location` STRING COMMENT 'Specific bin, shelf, or rack location within the stocking location where the material is stored. Supports warehouse picking and cycle counting operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the spare parts inventory record was first created in the system. Supports audit trail and data lineage requirements.',
    `criticality_classification` STRING COMMENT 'Business criticality rating of the spare part based on impact to operations if unavailable. Critical items are essential for emergency restoration and grid reliability, high items support major assets, medium items are standard maintenance spares, and low items are non-essential consumables.. Valid values are `critical|high|medium|low`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost valuation (e.g., USD, CAD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and disposal procedures per OSHA and EPA regulations. True if hazardous, False if non-hazardous.',
    `last_issue_date` DATE COMMENT 'Date when the material was most recently issued from inventory to a work order or maintenance activity. Used for inventory turnover analysis and obsolescence management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the spare parts inventory record was most recently updated. Supports change tracking and audit compliance.',
    `last_physical_count_date` DATE COMMENT 'Date when the last physical cycle count or annual inventory audit was performed for this material at this stocking location. Supports inventory accuracy and SOX compliance requirements.',
    `last_purchase_date` DATE COMMENT 'Date when the material was most recently purchased via a purchase order. Used for inventory aging analysis and procurement pattern tracking.',
    `last_purchase_order_number` STRING COMMENT 'Most recent purchase order number used to procure this material. Provides audit trail and reference for pricing, lead time, and supplier performance analysis.',
    `lead_time_days` STRING COMMENT 'Expected number of calendar days from purchase order placement to material receipt at the stocking location. Used for reorder point calculation and emergency procurement planning.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) or supplier who produces the spare part. Used for warranty tracking, quality management, and supplier performance analysis.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturers part number or catalog number for the spare part. Used for cross-referencing, procurement, and ensuring correct part substitution.',
    `material_description` STRING COMMENT 'Detailed textual description of the spare part or consumable item including technical specifications, manufacturer details, and usage context.',
    `material_group_code` STRING COMMENT 'Hierarchical classification code grouping similar materials for procurement, reporting, and spend analysis. Examples include electrical components, mechanical parts, safety equipment, or consumables.. Valid values are `^[A-Z0-9]{4,8}$`',
    `material_number` STRING COMMENT 'Unique material master identifier assigned to the spare part or consumable item in the enterprise asset management system. This is the externally-known business identifier used across procurement, inventory, and maintenance operations.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material master record. Active materials are available for procurement and issue, inactive materials are temporarily blocked, obsolete materials are phased out, pending approval materials are under review, and discontinued materials are no longer supported by the manufacturer.. Valid values are `active|inactive|obsolete|pending_approval|discontinued`',
    `material_type` STRING COMMENT 'Classification of the inventory item by usage category. Spare parts are replaceable components for assets, consumables are items used up during maintenance, critical spares are high-value low-turnover items essential for emergency restoration, tools are reusable equipment, safety equipment includes PPE and protective gear, and bulk materials are commodities purchased in volume.. Valid values are `spare_part|consumable|critical_spare|tool|safety_equipment|bulk_material`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum inventory quantity threshold to avoid overstocking and excess capital tied up in inventory. Used for inventory optimization and storage capacity planning.',
    `minimum_stock_level` DECIMAL(18,2) COMMENT 'Minimum inventory quantity threshold below which replenishment should be triggered. Set based on lead time, usage rate, and criticality to ensure availability for planned and emergency maintenance.',
    `obsolete_flag` BOOLEAN COMMENT 'Indicates whether the material has been marked as obsolete and should no longer be procured or issued. True if obsolete, False if active. Obsolete materials may still have on-hand inventory for legacy asset support.',
    `plant_code` STRING COMMENT 'Identifier for the organizational plant or business unit to which this inventory record belongs. Used for multi-site inventory management and cost allocation across generation, transmission, and distribution operations.. Valid values are `^[A-Z0-9]{4,6}$`',
    `preferred_supplier_code` STRING COMMENT 'Identifier for the preferred or primary supplier from whom this material should be procured. Links to vendor master data in the enterprise resource planning system.. Valid values are `^[A-Z0-9]{6,10}$`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical inventory quantity available in stock at the stocking location. Measured in the materials unit of measure.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a purchase requisition or replenishment order should be automatically generated. Calculated based on lead time demand plus safety stock.',
    `serial_number_tracking_flag` BOOLEAN COMMENT 'Indicates whether individual units of this material are tracked by unique serial numbers for warranty, calibration, or asset lifecycle management. True if serial-tracked, False if batch-tracked or non-serialized.',
    `shelf_life_months` STRING COMMENT 'Maximum number of months the material can be stored before it expires or degrades and must be disposed of. Applicable to consumables, lubricants, chemicals, and time-sensitive spare parts. Null for non-perishable items.',
    `source_system_code` STRING COMMENT 'Identifier for the operational system of record from which this inventory data originated. VENTYX for Ventyx Asset Suite Inventory module, SAP_MM for SAP S/4HANA Materials Management, SAP_PM for SAP Plant Maintenance, MANUAL for manually entered records.. Valid values are `VENTYX|SAP_MM|SAP_PM|MANUAL`',
    `source_system_record_code` STRING COMMENT 'Unique identifier or primary key of this inventory record in the source operational system. Used for data lineage, reconciliation, and bidirectional synchronization.',
    `spare_parts_to_asset_class` BIGINT COMMENT 'FK to asset.asset_class.asset_class_id — Spare parts are stocked for specific asset classes (e.g., transformer bushings for 132kV power transformers). This FK enables bill-of-materials resolution and critical spare identification.',
    `stocking_location_code` STRING COMMENT 'Identifier for the warehouse, storeroom, or facility where the spare part inventory is physically held. May reference central warehouses, regional depots, or substation storerooms.. Valid values are `^[A-Z0-9]{4,10}$`',
    `stocking_location_name` STRING COMMENT 'Human-readable name of the warehouse or storeroom where the inventory is held.',
    `storage_condition_code` STRING COMMENT 'Required environmental storage conditions for the material. Ambient for standard warehouse conditions, climate controlled for temperature and humidity sensitive items, refrigerated for cold storage, outdoor for weather-resistant bulk materials, and hazmat storage for hazardous materials requiring special containment.. Valid values are `ambient|climate_controlled|refrigerated|outdoor|hazmat_storage`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'Total monetary value of the on-hand inventory calculated as quantity on hand multiplied by unit cost. Used for Regulatory Asset Base (RAB) valuation, financial reporting, and Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) tracking.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard or moving average cost per unit of measure for the material. Used for inventory valuation, work order costing, and Operations and Maintenance (O&M) expense tracking.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the material quantity is tracked and issued. EA=each, FT=feet, M=meters, KG=kilograms, LB=pounds, GAL=gallons, L=liters, BOX=box, ROLL=roll, SET=set. [ENUM-REF-CANDIDATE: EA|FT|M|KG|LB|GAL|L|BOX|ROLL|SET — 10 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'Accounting classification code used to assign inventory value to specific general ledger accounts for financial reporting. Links material inventory to chart of accounts for CAPEX, OPEX, and balance sheet reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `warranty_months` STRING COMMENT 'Number of months of manufacturer warranty coverage from the date of purchase or installation. Used for warranty claim management and total cost of ownership analysis. Null if no warranty applies.',
    CONSTRAINT pk_spare_parts_inventory PRIMARY KEY(`spare_parts_inventory_id`)
) COMMENT 'Inventory management for spare parts, consumables, and critical spares held for utility asset maintenance and emergency restoration. Captures material master data (number, description, asset class applicability, criticality classification), stocking details (location, quantity on hand, min stock, reorder point, lead time), valuation (unit cost, total inventory value), and supplier references. Also records material issue and return transactions against work orders including issue date, quantity, receiving technician, and cost allocation. Supports O&M material cost tracking, inventory replenishment triggers, and critical spare availability assurance. Sourced from Ventyx Asset Suite Inventory module and SAP S/4HANA Materials Management (MM).';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the asset inspection record. Primary key.',
    `capacitor_bank_id` BIGINT COMMENT 'Foreign key linking to distribution.capacitor_bank. Business justification: Capacitor banks require periodic inspections (visual condition, electrical testing, fuse condition, control verification). Asset managers need this link to record inspection results and trigger mainte',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Asset inspections are mandated by specific regulatory obligations (FERC dam safety, NERC vegetation management, state PUC equipment inspection requirements). Direct link enables compliance reporting, ',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.transformer. Business justification: Transformer inspections (visual, oil sampling, dissolved gas analysis, thermography) are mandated by NFPA 70B, IEEE C57 standards, and insurance requirements. Links inspection results to specific tran',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Feeder inspections (patrol, infrared thermography, detailed climbing inspections) are regulatory requirements (NERC FAC standards, state PUC mandates) and reliability best practices. Links inspection ',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to asset.maintenance_plan. Business justification: Inspections in utility asset management are frequently scheduled and triggered by preventive maintenance plans (e.g., annual transformer inspection per maintenance plan MP-001). Linking inspection.mai',
    `network_segment_id` BIGINT COMMENT 'Foreign key linking to distribution.network_segment. Business justification: Conductor and line inspections (aerial patrol, ground patrol, LiDAR, thermographic) are tied to specific network segments for vegetation management compliance, condition tracking, and capital replacem',
    `power_transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.power_transformer. Business justification: Transformer inspections (thermal imaging, oil sampling, visual inspection) are mandatory per NERC and utility standards. Consistent with existing inspection FKs to transmission_line and transmission_s',
    `protection_device_id` BIGINT COMMENT 'Foreign key linking to transmission.protection_device. Business justification: Protection device inspections and functional tests are mandatory per NERC PRC-005 with documented results. Consistent with existing inspection FKs to transmission assets. Required to record relay test',
    `registry_id` BIGINT COMMENT 'Identifier of the utility asset being inspected (generation unit, transmission tower, distribution pole, transformer, switchgear, protection relay, substation equipment, fleet vehicle, or facility).',
    `sectionalizing_device_id` BIGINT COMMENT 'Foreign key linking to distribution.sectionalizing_device. Business justification: Sectionalizing devices require periodic inspections (visual condition, operational testing, contact resistance measurement) tracked for compliance and condition-based maintenance. Asset managers need ',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Transmission line inspections (aerial patrols, ground inspections, LiDAR surveys, drone inspections) are line-specific and required for NERC FAC standards compliance, vegetation management, and struct',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Substation inspections (thermographic surveys, equipment condition assessments, oil sampling, visual inspections) are performed at specific substations and must be tracked for NERC compliance, mainten',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius at the time of inspection, relevant for temperature-sensitive diagnostic tests (e.g., thermography, oil analysis).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was reviewed and approved by a supervisor or engineer.',
    `asset_load_percent` DECIMAL(18,2) COMMENT 'Percentage of rated capacity at which the asset was operating during the inspection, relevant for load-dependent diagnostic tests.',
    `condition_rating` STRING COMMENT 'Qualitative condition rating corresponding to the overall condition score.. Valid values are `excellent|good|fair|poor|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was first created in the system.',
    `defect_description` STRING COMMENT 'Detailed narrative description of the defects, anomalies, or conditions observed during the inspection.',
    `defect_severity` STRING COMMENT 'Highest severity classification of defects identified: critical (immediate safety/reliability risk), major (near-term failure risk), minor (long-term degradation), or informational (observation only).. Valid values are `critical|major|minor|informational`',
    `defects_identified_count` STRING COMMENT 'Number of defects, anomalies, or non-conformances identified during the inspection.',
    `document_attachment_count` STRING COMMENT 'Number of supporting documents (test reports, certificates, checklists) attached to the inspection record.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total time in hours required to complete the inspection, including travel, setup, testing, and documentation.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD to remediate identified defects or perform recommended actions. Used for CAPEX/OPEX planning and maintenance budget forecasting.',
    `frequency_months` STRING COMMENT 'Interval in months between scheduled inspections for this asset, based on regulatory mandates, asset criticality, or condition-based maintenance strategy.',
    `health_index` DECIMAL(18,2) COMMENT 'Composite health index score (0-100 scale) calculated from inspection results, test data, and condition indicators. Feeds asset health analytics and predictive maintenance models.',
    `inspection_date` DATE COMMENT 'The date on which the inspection or condition assessment was performed.',
    `inspection_method` STRING COMMENT 'The technical method or technology used to perform the inspection or diagnostic test. [ENUM-REF-CANDIDATE: visual|infrared_thermography|ultrasonic|vibration|oil_analysis|electrical_test|drone_aerial|manual_measurement|scada_online_monitoring — 9 candidates stripped; promote to reference product]',
    `inspection_number` STRING COMMENT 'Business identifier for the inspection, typically generated by the work management system or field inspection application.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record in the work management system.. Valid values are `scheduled|in_progress|completed|cancelled|pending_review|approved`',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity: routine patrol (visual), post-storm assessment, vegetation management inspection, scheduled condition assessment, or advanced diagnostic test type. [ENUM-REF-CANDIDATE: routine_patrol|post_storm|vegetation_management|scheduled_condition_assessment|thermographic_survey|dissolved_gas_analysis|partial_discharge_test|oil_sampling|vibration_analysis|ultrasonic_testing — 10 candidates stripped; promote to reference product]',
    `inspector_name` STRING COMMENT 'Full name of the inspector or assessor who conducted the inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection record was last updated or modified.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next inspection or condition assessment based on regulatory requirements, manufacturer recommendations, or condition-based maintenance triggers.',
    `notes` STRING COMMENT 'Free-text field for additional observations, context, or comments recorded by the inspector during the inspection.',
    `overall_condition_score` STRING COMMENT 'Overall asset condition rating on a 1-5 scale per IEEE/IEC standards (1=excellent, 2=good, 3=fair, 4=poor, 5=very poor/critical).',
    `pass_fail_status` STRING COMMENT 'Indicates whether the test result meets acceptance criteria or threshold limits defined by manufacturer specifications or industry standards.. Valid values are `pass|fail|marginal|not_applicable`',
    `photo_attachment_count` STRING COMMENT 'Number of photos or images attached to the inspection record for documentation purposes.',
    `recommended_action` STRING COMMENT 'Recommended follow-up action based on inspection findings: repair, replace, continue monitoring, no action required, further investigation needed, or emergency repair.. Valid values are `repair|replace|monitor|no_action|further_investigation|emergency_repair`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this inspection is mandated by regulatory requirements (e.g., NERC FAC-003 vegetation management, OSHA confined space entry, state PUC inspection mandates).',
    `regulatory_standard_code` STRING COMMENT 'Code or reference to the specific regulatory standard or requirement that mandates this inspection (e.g., NERC FAC-003, OSHA 1910.269, IEEE Std 62.2).',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score based on condition assessment results, asset criticality, and consequence of failure. Used for risk-based maintenance prioritization.',
    `scada_data_source_flag` BOOLEAN COMMENT 'Indicates whether inspection data was sourced from SCADA-integrated online monitoring systems (true) or from manual field inspection (false).',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which the inspection data originated (Ventyx Asset Suite, SCADA, field inspection mobile app, OSIsoft PI, or GE PowerOn ADMS).. Valid values are `VENTYX|SCADA|MOBILE_APP|PI|ADMS`',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the inspection record in the source system, used for data lineage and reconciliation.',
    `test_result_unit` STRING COMMENT 'Unit of measure for the test result value (e.g., ppm, pC, mm/s, kV, degrees Celsius, ohms).',
    `test_result_value` DECIMAL(18,2) COMMENT 'Numeric result of the diagnostic test or measurement (e.g., dissolved gas concentration in ppm, partial discharge magnitude in pC, vibration amplitude in mm/s, oil dielectric strength in kV).',
    `threshold_limit` DECIMAL(18,2) COMMENT 'The acceptance threshold or limit value against which the test result is compared to determine pass/fail status.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for outdoor asset inspections (e.g., clear, rain, snow, high wind, extreme temperature).',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Periodic, event-driven, or regulatory-mandated evaluation of utility asset condition encompassing routine patrol inspections (visual, post-storm, vegetation management), scheduled condition assessments, and advanced diagnostic tests (thermographic survey, dissolved gas analysis, partial discharge test, oil sampling, vibration analysis, ultrasonic testing). Records inspection/assessment date, method/type, inspector or assessor identity, overall condition score (1-5 scale per IEEE/IEC standards), individual test results with pass/fail thresholds, defects identified with severity classification (critical, major, minor), recommended follow-up actions (repair, replace, monitor, no action), estimated remediation cost, next assessment due date, and regulatory compliance flags (e.g., NERC FAC-003 vegetation management, OSHA confined space). Feeds asset health indices, risk-based maintenance prioritization, reliability-centered maintenance analysis, and condition-based maintenance triggers. SSOT for all asset condition evaluation data. Sourced from Ventyx Asset Suite Condition Monitoring, field inspection mobile apps, and SCADA-integrated online monitoring systems.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`valuation` (
    `valuation_id` BIGINT COMMENT 'Unique identifier for the asset valuation record. Primary key for the asset valuation entity.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_case. Business justification: Asset valuations (RAB, ODRC, fair market value) are submitted in rate case filings to justify rate base and depreciation rates. Utilities must link valuation records to specific rate case dockets for ',
    `registry_id` BIGINT COMMENT 'Reference to the utility asset being valued (generation unit, transmission tower, distribution pole, transformer, switchgear, protection relay, substation equipment, fleet vehicle, or facility).',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation accumulated on the asset from its in-service date to the valuation date. Calculated based on approved depreciation rates and asset age.',
    `appraiser_certification_number` STRING COMMENT 'Professional certification or license number of the appraiser, demonstrating qualifications to perform utility asset valuations. Required for regulatory acceptance.',
    `appraiser_name` STRING COMMENT 'Name of the individual or firm that performed the valuation. Required for independent appraisals and regulatory submissions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this valuation was formally approved for use in regulatory filings or financial reporting.',
    `basis` STRING COMMENT 'The source or basis for the valuation: independent appraisal (external certified appraiser), internal estimate (utility staff assessment), regulatory formula (PUC-prescribed calculation), indexed cost (inflation-adjusted historical cost), engineering assessment (technical evaluation), or third party valuation (consultant report).. Valid values are `independent_appraisal|internal_estimate|regulatory_formula|indexed_cost|engineering_assessment|third_party_valuation`',
    `condition_assessment_score` DECIMAL(18,2) COMMENT 'Numerical score representing the physical condition of the asset at the valuation date, typically on a scale of 1-10 or 1-100. Influences depreciation adjustments and replacement prioritization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this valuation record was first created in the system. Part of audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this valuation record. Typically USD for US utilities.. Valid values are `^[A-Z]{3}$`',
    `depreciation_rate_percent` DECIMAL(18,2) COMMENT 'The annual depreciation rate applied to this asset, expressed as a percentage. Approved by the PUC and used to calculate accumulated depreciation and remaining life.',
    `economic_obsolescence_factor` DECIMAL(18,2) COMMENT 'Adjustment factor (0 to 1) representing the impact of external economic factors on asset value, such as changes in market demand, regulatory environment, or competitive conditions.',
    `effective_end_date` DATE COMMENT 'The date on which this valuation ceases to be effective, typically when superseded by a new valuation or when the asset is retired. Null for current valuations.',
    `effective_start_date` DATE COMMENT 'The date from which this valuation becomes effective for regulatory and financial reporting purposes. May differ from valuation date for prospective valuations.',
    `fair_market_value` DECIMAL(18,2) COMMENT 'The estimated price at which the asset would change hands between a willing buyer and willing seller in an arms length transaction. Used for financial reporting and M&A activities.',
    `functional_obsolescence_factor` DECIMAL(18,2) COMMENT 'Adjustment factor (0 to 1) representing the degree of functional obsolescence due to technological advances or changes in operational requirements. Applied to reduce replacement cost for outdated assets.',
    `gross_replacement_cost` DECIMAL(18,2) COMMENT 'The estimated cost to replace the asset with a new equivalent asset at current prices, before any depreciation. Represents the full reproduction cost of the asset in todays dollars.',
    `inflation_adjustment_factor` DECIMAL(18,2) COMMENT 'The cumulative inflation factor applied to convert historical asset costs to current replacement costs. Derived from the selected inflation index over the assets life.',
    `inflation_index_applied` STRING COMMENT 'The inflation index used to trend historical costs to current replacement costs, such as Handy-Whitman Index, GDP deflator, or CPI. Specifies the index name and base year.',
    `insurance_value` DECIMAL(18,2) COMMENT 'The value used for insurance coverage determination, representing the cost to replace the asset in the event of loss or damage. May include additional costs for expedited replacement and business interruption.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this valuation record was most recently updated. Tracks changes for audit and compliance purposes.',
    `methodology` STRING COMMENT 'The primary methodology used to determine the asset value: cost approach (replacement cost basis), market approach (comparable sales), income approach (discounted cash flows), hybrid (combination of methods), index trending (inflation-adjusted historical cost), or engineering estimate (technical assessment).. Valid values are `cost_approach|market_approach|income_approach|hybrid|index_trending|engineering_estimate`',
    `net_book_value` DECIMAL(18,2) COMMENT 'The current book value of the asset calculated as original cost minus accumulated depreciation. Represents the accounting value on the balance sheet.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, limitations, or special considerations related to this valuation. May include references to supporting documentation or regulatory guidance.',
    `odrc_value` DECIMAL(18,2) COMMENT 'The optimised depreciated replacement cost representing the current cost of replacing the asset with its modern equivalent, adjusted for technological improvements and optimised capacity. Critical for RAB determination in regulatory proceedings.',
    `puc_submission_reference` STRING COMMENT 'Reference number for the PUC regulatory filing or rate case submission that includes this valuation. Critical for tracking regulatory approval and RAB determination.',
    `rab_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this asset valuation is included in the Regulatory Asset Base for rate-making purposes. True if the asset is rate-base eligible and approved by the PUC.',
    `rate_case_docket_number` STRING COMMENT 'The official docket number assigned by the PUC for the rate case proceeding in which this valuation was submitted. Used for regulatory tracking and compliance.',
    `remaining_useful_life_years` STRING COMMENT 'The estimated number of years of useful service life remaining for the asset at the valuation date. Used for depreciation calculations and capital planning.',
    `report_reference` STRING COMMENT 'Reference number or identifier for the detailed valuation report or appraisal document supporting this valuation record. Links to document management system.',
    `salvage_value` DECIMAL(18,2) COMMENT 'The estimated residual value of the asset at the end of its useful life, representing the amount recoverable through sale or scrap. Used in depreciation calculations and retirement planning.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this valuation record originated, such as Ventyx Asset Suite, SAP S/4HANA Asset Accounting, or external appraisal system.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this valuation record in the source system. Enables traceability and reconciliation with operational systems.',
    `valuation_date` DATE COMMENT 'The date on which the asset valuation was performed or is effective. Critical for regulatory reporting and RAB determination.',
    `valuation_number` STRING COMMENT 'Business identifier for the valuation record, typically assigned by the valuation process or external appraiser. Used for tracking and referencing in regulatory filings.',
    `valuation_status` STRING COMMENT 'Current lifecycle status of the valuation record: draft (initial preparation), under review (internal validation), approved (management sign-off), submitted to PUC (regulatory filing), accepted (PUC approval), rejected (requires revision), or superseded (replaced by newer valuation). [ENUM-REF-CANDIDATE: draft|under_review|approved|submitted_to_puc|accepted|rejected|superseded — 7 candidates stripped; promote to reference product]',
    `valuation_type` STRING COMMENT 'The type or purpose of the valuation: RAB (Regulatory Asset Base) for rate case filings, insurance replacement cost for coverage determination, fair value for financial reporting, depreciated replacement cost for asset management, market value for disposal decisions, or liquidation value for decommissioning scenarios.. Valid values are `rab|insurance_replacement_cost|fair_value|depreciated_replacement_cost|market_value|liquidation_value`',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Periodic valuation record for utility assets supporting RAB (Regulatory Asset Base) determination, insurance valuation, and fair value assessment. Captures valuation date, valuation type (RAB, insurance replacement cost, fair value, depreciated replacement cost), gross replacement cost, accumulated depreciation, optimised depreciated replacement cost (ODRC), valuation methodology, valuation basis (independent appraisal, internal estimate), appraiser reference, and PUC/regulatory submission reference. Critical for IRP and rate case filings.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`warranty` (
    `warranty_id` BIGINT COMMENT 'Unique identifier for the asset warranty record. Primary key for the asset warranty product.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: Manufacturer warranties on DER equipment (inverters 10-25 years, batteries 10 years, turbines 5-10 years) critical for O&M cost forecasting, replacement planning, and failure cost recovery. Required f',
    `registry_id` BIGINT COMMENT 'Reference to the utility asset covered by this warranty. Links to the asset registry for generation units, transformers, switchgear, protection relays, substation equipment, transmission towers, distribution poles, fleet vehicles, and facilities.',
    `claim_documentation_required` STRING COMMENT 'Description of documentation required to support warranty claims, such as failure reports, inspection records, maintenance logs, photographs, or condition monitoring data from SCADA or OSIsoft PI.',
    `claim_submission_method` STRING COMMENT 'Preferred or required method for submitting warranty claims to the manufacturer. Online portals provide fastest processing; email and phone are common alternatives; fax and mail are legacy methods.. Valid values are `online_portal|email|phone|fax|mail`',
    `claims_approved_count` STRING COMMENT 'Total number of warranty claims approved and settled to date. Used to calculate claim approval rate and supplier responsiveness metrics.',
    `claims_limit_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate claim amount in USD allowed during the coverage period. Nullable if unlimited claim value is permitted. Used for financial exposure management.',
    `claims_limit_count` STRING COMMENT 'Maximum number of warranty claims allowed during the coverage period. Nullable if unlimited claims are permitted. Used to track claim utilization and prevent warranty abuse.',
    `claims_rejected_count` STRING COMMENT 'Total number of warranty claims rejected by the manufacturer to date. Used to identify warranty coverage disputes and supplier performance issues.',
    `claims_submitted_count` STRING COMMENT 'Total number of warranty claims submitted to date for this warranty agreement. Used to track claim utilization against claims limit and for supplier performance analysis.',
    `contract_reference_number` STRING COMMENT 'Reference number for the master service contract or extended warranty agreement. Used to link warranty records to contract management systems.',
    `coverage_scope` STRING COMMENT 'Detailed description of what components, failures, and conditions are covered under the warranty. Specifies inclusions such as parts, labor, travel, and exclusions such as normal wear, misuse, or environmental damage.',
    `covered_components` STRING COMMENT 'Comma-separated list or detailed enumeration of specific asset components covered by the warranty. For transformers may include windings, bushings, tap changers; for generators may include rotor, stator, bearings, exciter.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warranty record was first created in the system. Audit trail field for data lineage and compliance reporting.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount in USD that the utility must pay before warranty coverage applies. Common in extended warranty agreements and service contracts.',
    `document_url` STRING COMMENT 'URL or file path to the digital warranty certificate, terms and conditions document, or service agreement. Provides quick access to warranty documentation for claim processing.',
    `duration_months` STRING COMMENT 'Total duration of warranty coverage expressed in months. Standard manufacturer warranties typically range from 12 to 60 months; extended warranties may exceed 120 months for critical utility assets.',
    `end_date` DATE COMMENT 'Expiration date when warranty coverage terminates. Used for proactive warranty expiry management and planning for post-warranty maintenance strategies. Nullable for lifetime warranties.',
    `exclusions` STRING COMMENT 'Detailed description of conditions, failures, or circumstances explicitly excluded from warranty coverage. Common exclusions include normal wear and tear, misuse, unauthorized modifications, environmental damage, and force majeure events.',
    `labor_covered_flag` BOOLEAN COMMENT 'Indicates whether labor costs for repair or replacement are covered under the warranty. True if labor is included; false if parts-only warranty.',
    `last_claim_date` DATE COMMENT 'Date of the most recent warranty claim submission. Used to track claim frequency and identify assets with recurring failures.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the warranty record was last updated. Audit trail field for tracking warranty status changes, claim updates, and data corrections.',
    `maintenance_requirements` STRING COMMENT 'Description of preventive maintenance activities required to maintain warranty validity. May include inspection frequency, lubrication schedules, condition monitoring, and use of OEM parts. Non-compliance may void warranty.',
    `manufacturer_contact_email` STRING COMMENT 'Email address for the manufacturer warranty contact. Business-confidential organizational contact information used for claim correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manufacturer_contact_name` STRING COMMENT 'Primary contact person at the manufacturer or supplier for warranty administration and claim processing.',
    `manufacturer_contact_phone` STRING COMMENT 'Phone number for the manufacturer warranty contact. Business-confidential organizational contact information.',
    `notes` STRING COMMENT 'Free-text field for additional warranty information, special terms, claim history notes, or internal comments. Used for warranty administration and knowledge management.',
    `parts_covered_flag` BOOLEAN COMMENT 'Indicates whether replacement parts are covered under the warranty. True if parts are included; false if labor-only warranty.',
    `performance_guarantee_flag` BOOLEAN COMMENT 'Indicates whether the warranty includes performance guarantees such as minimum efficiency, capacity factor, or availability. Common for generation units and renewable energy assets under Power Purchase Agreements (PPA).',
    `prorated_flag` BOOLEAN COMMENT 'Indicates whether warranty coverage or claim value is prorated based on asset age or usage. True if prorated; false if full coverage throughout warranty period.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the asset acquisition and warranty agreement. Links warranty to procurement records in SAP S/4HANA Materials Management (MM).',
    `registration_date` DATE COMMENT 'Date when the warranty was registered with the manufacturer. Some warranties require registration within a specified period after installation to activate coverage.',
    `repair_time_hours` STRING COMMENT 'Maximum time in hours for the manufacturer to complete repair or replacement under warranty. Service Level Agreement (SLA) metric impacting System Average Interruption Duration Index (SAIDI) for critical assets.',
    `response_time_hours` STRING COMMENT 'Maximum time in hours for the manufacturer to respond to a warranty claim or service request. Service Level Agreement (SLA) metric for critical utility infrastructure.',
    `start_date` DATE COMMENT 'Effective start date when warranty coverage begins. Typically aligned with asset commissioning date or installation date. Critical for determining coverage eligibility and expiry calculation.',
    `total_claims_recovered_amount` DECIMAL(18,2) COMMENT 'Cumulative amount in USD recovered through approved warranty claims to date. Used for Operational Expenditure (OPEX) cost recovery tracking and supplier performance analysis.',
    `total_warranty_value` DECIMAL(18,2) COMMENT 'Total monetary value of the warranty coverage in USD. Represents the maximum potential claim recovery or the insured value of covered components. Used for financial risk assessment and Capital Expenditure (CAPEX) planning.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether the warranty can be transferred to a new owner if the asset is sold or relocated. Relevant for fleet vehicles, mobile equipment, and assets subject to ownership changes.',
    `travel_covered_flag` BOOLEAN COMMENT 'Indicates whether technician travel and mobilization costs are covered under the warranty. Particularly relevant for remote utility assets such as transmission towers and rural substations.',
    `warranty_number` STRING COMMENT 'Unique warranty certificate or agreement number issued by the manufacturer or supplier. Business identifier for external reference and claim submission.',
    `warranty_status` STRING COMMENT 'Current lifecycle state of the warranty agreement. Active warranties are in force and eligible for claims; expired warranties have passed their coverage period; cancelled warranties were terminated early; suspended warranties are temporarily inactive; pending activation warranties are registered but not yet effective.. Valid values are `active|expired|cancelled|suspended|pending_activation`',
    `warranty_type` STRING COMMENT 'Classification of warranty coverage. Manufacturer standard warranties are included with equipment purchase; extended warranties provide coverage beyond standard terms; service contracts cover ongoing maintenance; performance guarantees ensure operational specifications. [ENUM-REF-CANDIDATE: manufacturer_standard|extended|service_contract|performance_guarantee|parts_only|labor_only|comprehensive — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_warranty PRIMARY KEY(`warranty_id`)
) COMMENT 'Warranty records and claim management for utility assets and equipment. Covers manufacturer warranty terms, extended warranty agreements, warranty start and expiry dates, covered components, and supplier/OEM contact details. Also captures warranty claim transactions including claim date, failure description, claim status (submitted, acknowledged, accepted, rejected, settled), replacement or repair outcome, credit value, and resolution date. Enables proactive warranty expiry management, claim cost recovery tracking, and supplier performance analysis. Sourced from Ventyx Asset Suite and SAP S/4HANA MM contract management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` (
    `maintenance_plan_parts_requirement_id` BIGINT COMMENT 'Unique identifier for this maintenance plan parts requirement record. Primary key.',
    `maintenance_plan_id` BIGINT COMMENT 'Foreign key linking to the maintenance plan that requires this spare part',
    `spare_parts_inventory_id` BIGINT COMMENT 'Foreign key linking to the spare part or consumable required by this maintenance plan',
    `alternative_part_group_code` STRING COMMENT 'Reference to an approved alternative parts group or equivalency list. When substitution_allowed_flag is True, this code identifies which substitute parts are acceptable for this maintenance plan requirement.',
    `consumption_type` STRING COMMENT 'Classification of how this part is consumed in the maintenance plan. PLANNED parts are always used; CONTINGENT parts are used only if inspection reveals need; EMERGENCY_SPARE parts are staged but only consumed if failure occurs during maintenance.',
    `created_by_user` STRING COMMENT 'Identifier of the user or system process that created this parts requirement record. Supports accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance plan parts requirement record was first created in the system. Used for audit trail and change tracking.',
    `criticality_for_plan` STRING COMMENT 'Criticality rating of this specific part within the context of this maintenance plan. A part may be CRITICAL for one plan (e.g., transformer oil for transformer maintenance) but LOW for another. Drives material availability assurance and expediting decisions.',
    `effective_end_date` DATE COMMENT 'Date when this parts requirement expires or is superseded. Nullable for ongoing requirements. Used to manage engineering change orders and obsolescence transitions.',
    `effective_start_date` DATE COMMENT 'Date when this parts requirement becomes active for the maintenance plan. Supports phased plan updates, engineering changes, or seasonal material requirements.',
    `estimated_unit_cost_usd` DECIMAL(18,2) COMMENT 'Estimated unit cost of this spare part at the time of maintenance plan definition. Used for maintenance plan cost estimation and budgeting. May differ from current inventory valuation due to price changes or plan-specific procurement terms.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the user or system process that most recently modified this parts requirement record. Supports change management accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance plan parts requirement record was most recently updated. Supports change management and audit compliance.',
    `lead_time_buffer_days` STRING COMMENT 'Additional lead time buffer (in days) beyond the parts standard procurement lead time, specific to this maintenance plan. Accounts for plan-specific logistics complexity, vendor coordination, or regulatory approval requirements. Used to calculate material order trigger dates.',
    `required_quantity` DECIMAL(18,2) COMMENT 'Planned quantity of this spare part required per execution of the maintenance plan. Used for material staging and inventory consumption forecasting. Unit of measure aligns with the spare parts base UOM.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether an alternative or substitute part can be used if the specified part is unavailable. True allows substitution per approved equivalency list; False requires exact part (common for OEM-specific or safety-critical components).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the required quantity (e.g., EA for each, GAL for gallons, FT for feet). Must align with the spare parts inventory UOM or be a valid conversion unit.',
    CONSTRAINT pk_maintenance_plan_parts_requirement PRIMARY KEY(`maintenance_plan_parts_requirement_id`)
) COMMENT 'This association product represents the bill of materials (BOM) relationship between maintenance plans and spare parts inventory. It captures the specific parts and consumables required to execute a preventive or predictive maintenance plan, including planned quantities, criticality ratings, and lead time buffers. Each record links one maintenance plan to one spare part with attributes that exist only in the context of this maintenance requirement. This is a core operational entity in utility EAM systems (Ventyx Asset Suite, SAP PM) that drives material planning, inventory replenishment triggers, and work order material staging.. Existence Justification: In utility asset maintenance operations, maintenance plans define a bill of materials (BOM) specifying which spare parts and consumables are required for plan execution. One maintenance plan requires many different spare parts (oil, filters, gaskets, breakers, etc.), and one spare part is required by many different maintenance plans (e.g., transformer oil is required by all transformer maintenance plans across the fleet). This is a recognized operational entity in EAM systems called a maintenance BOM or parts requirement list.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_class_id` FOREIGN KEY (`class_id`) REFERENCES `energy_utilities_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_parent_asset_registry_id` FOREIGN KEY (`parent_asset_registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_hierarchy_registry_id` FOREIGN KEY (`hierarchy_registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_parent_work_order_id` FOREIGN KEY (`parent_work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_to_maintenance_plan_id` FOREIGN KEY (`to_maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_class_id` FOREIGN KEY (`class_id`) REFERENCES `energy_utilities_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_to_work_order_id` FOREIGN KEY (`to_work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `energy_utilities_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_class_id` FOREIGN KEY (`class_id`) REFERENCES `energy_utilities_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ADD CONSTRAINT `fk_asset_spare_parts_inventory_class_id` FOREIGN KEY (`class_id`) REFERENCES `energy_utilities_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ADD CONSTRAINT `fk_asset_spare_parts_inventory_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ADD CONSTRAINT `fk_asset_valuation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ADD CONSTRAINT `fk_asset_maintenance_plan_parts_requirement_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ADD CONSTRAINT `fk_asset_maintenance_plan_parts_requirement_spare_parts_inventory_id` FOREIGN KEY (`spare_parts_inventory_id`) REFERENCES `energy_utilities_ecm`.`asset`.`spare_parts_inventory`(`spare_parts_inventory_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `energy_utilities_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` SET TAGS ('dbx_subdomain' = 'physical_registry');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `parent_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Book Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'MW|MVA|kV|kVA|A|kA');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Criticality Score');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|regulatory');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `failure_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Failure Risk Category');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `failure_risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}(.[0-9]{1,2})?$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'reactive|preventive|predictive|condition_based|run_to_failure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `nerc_critical_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Asset Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|standby|retired|under_construction|commissioned');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|joint_ownership|customer_owned|third_party');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `rab_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Inclusion Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (kV)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`registry` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` SET TAGS ('dbx_subdomain' = 'physical_registry');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Child Asset Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `criticality_inherited_flag` SET TAGS ('dbx_business_glossary_term' = 'Criticality Inherited Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `geographic_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'functional_location|electrical_connectivity|linear_asset|spatial_containment|logical_grouping|system_subsystem');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `maintenance_responsibility_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `network_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `outage_impact_propagation_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Impact Propagation Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `planning_area_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Area Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `rab_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Allocation Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `relationship_notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `relationship_sequence` SET TAGS ('dbx_business_glossary_term' = 'Relationship Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|planned');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `scada_aggregation_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Aggregation Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV - Kilovolt)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` SET TAGS ('dbx_subdomain' = 'physical_registry');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `annual_om_cost_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operations and Maintenance (O&M) Cost Per Unit (USD - United States Dollar)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `annual_om_cost_per_unit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `capacity_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating (MW - Megawatt)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `capital_expenditure_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `class_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|proposed');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `condition_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `cybersecurity_classification` SET TAGS ('dbx_business_glossary_term' = 'Cybersecurity Classification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `cybersecurity_classification` SET TAGS ('dbx_value_regex' = 'high_impact|medium_impact|low_impact|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `distributed_energy_resource_flag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Category');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `failure_mode_profile` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Profile');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,6}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `gis_layer_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Layer Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `grid_modernization_category` SET TAGS ('dbx_business_glossary_term' = 'Grid Modernization Category');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `grid_modernization_category` SET TAGS ('dbx_value_regex' = 'advanced_metering|distribution_automation|grid_sensors|energy_storage|ev_infrastructure|legacy');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `iec_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'International Electrotechnical Commission (IEC) Standard Reference');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `ieee_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Institute of Electrical and Electronics Engineers (IEEE) Standard Reference');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `inspection_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (Months)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `interoperability_standard` SET TAGS ('dbx_business_glossary_term' = 'Interoperability Standard');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|condition_based|run_to_failure|reliability_centered');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `manufacturer_diversity_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Diversity Required Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `nerc_asset_type` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Asset Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `obsolescence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Risk Rating');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `obsolescence_risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `rab_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `renewable_energy_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `replacement_lead_time_months` SET TAGS ('dbx_business_glossary_term' = 'Replacement Lead Time (Months)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'high_voltage|confined_space|elevated_work|heavy_equipment|standard');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `scada_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitoring Required Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `spare_parts_stocking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Stocking Strategy');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `spare_parts_stocking_strategy` SET TAGS ('dbx_value_regex' = 'critical_spare|insurance_spare|consignment|just_in_time|no_stock');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `standard_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Cost (USD - United States Dollar)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `standard_unit_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `technology_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Generation');
ALTER TABLE `energy_utilities_ecm`.`asset`.`class` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (kV - Kilovolt)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_management');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `parent_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Order ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `power_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Power Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `capex_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `closure_code` SET TAGS ('dbx_business_glossary_term' = 'Closure Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `closure_code` SET TAGS ('dbx_value_regex' = 'completed_as_planned|completed_with_variance|deferred|cancelled_duplicate|cancelled_not_required|cancelled_no_access');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `equipment_cost` SET TAGS ('dbx_business_glossary_term' = 'Equipment Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `material_cost` SET TAGS ('dbx_business_glossary_term' = 'Material Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `outage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `requester_contact` SET TAGS ('dbx_business_glossary_term' = 'Requester Contact');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `requester_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `requester_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `safety_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Operations and Maintenance (O&M) Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|inspection|capital_project|condition_assessment');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` SET TAGS ('dbx_subdomain' = 'maintenance_management');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `power_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Power Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `auto_generate_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generate Work Order Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `compliance_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Mandatory Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `condition_trigger_parameter` SET TAGS ('dbx_business_glossary_term' = 'Condition Trigger Parameter');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `condition_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Condition Trigger Threshold');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `condition_trigger_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Trigger Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `cycle_interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Interval Unit');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `cycle_interval_value` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Interval Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `estimated_contractor_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contractor Cost (USD)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `estimated_material_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost (USD)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `last_execution_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Work Order Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `last_execution_work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[A-Z0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Lead Time (Days)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'preventive|predictive|reliability_centered|risk_based|run_to_failure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `next_scheduled_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Work Order Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `next_scheduled_work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[A-Z0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `outage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^MP-[A-Z0-9]{8,12}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|inactive|retired');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'time_based|condition_based|usage_based|predictive|regulatory|corrective');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `planning_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Plant Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `planning_plant_code` SET TAGS ('dbx_value_regex' = '^PP-[A-Z0-9]{4,8}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Priority');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Driver');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `scheduling_window_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Window (Days)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_business_glossary_term' = 'Task List Reference');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `task_list_reference` SET TAGS ('dbx_value_regex' = '^TL-[A-Z0-9]{6,10}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `usage_trigger_parameter` SET TAGS ('dbx_business_glossary_term' = 'Usage Trigger Parameter');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `usage_trigger_parameter` SET TAGS ('dbx_value_regex' = 'operating_hours|start_stop_cycles|mwh_generated|breaker_operations|tap_changer_operations');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `usage_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Usage Trigger Threshold');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` SET TAGS ('dbx_subdomain' = 'maintenance_management');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Event ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `capacitor_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Capacitor Bank Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `direct_load_control_device_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Load Control Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `direct_load_control_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `direct_load_control_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `power_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Power Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `sectionalizing_device_id` SET TAGS ('dbx_business_glossary_term' = 'Sectionalizing Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `sectionalizing_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `sectionalizing_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `affected_component` SET TAGS ('dbx_business_glossary_term' = 'Affected Component');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `asset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Age (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `caidi_contribution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Customer Average Interruption Duration Index (CAIDI) Contribution (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `energy_not_supplied_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Not Supplied (MWh)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Failure Cost Amount');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Failure Cost Currency');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_location` SET TAGS ('dbx_business_glossary_term' = 'Failure Location');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'electrical|mechanical|thermal|insulation|corrosion|external_damage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_status` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|rca_in_progress|resolved|closed');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_type` SET TAGS ('dbx_business_glossary_term' = 'Failure Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `failure_type` SET TAGS ('dbx_value_regex' = 'forced_outage|planned_outage|degraded_operation|partial_failure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `investigated_by` SET TAGS ('dbx_business_glossary_term' = 'Investigated By');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `load_interrupted_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Interrupted (MW)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `nerc_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'NERC Report Submitted Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `operating_hours_at_failure` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours at Failure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `puc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `repair_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Repair Action Taken');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Completed Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `root_cause_analysis_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `saidi_contribution_minutes` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Duration Index (SAIDI) Contribution (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `saifi_contribution` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Frequency Index (SAIFI) Contribution');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` SET TAGS ('dbx_subdomain' = 'capital_accounting');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Irp Scenario Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_in_service_date` SET TAGS ('dbx_business_glossary_term' = 'Actual In-Service Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend to Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `approved_capex_budget` SET TAGS ('dbx_business_glossary_term' = 'Approved Capital Expenditure (CAPEX) Budget');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `cpcn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Public Convenience and Necessity (CPCN) Reference Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|regulatory');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `estimated_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Estimated Useful Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `ferc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reportable Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal_cash|debt_financing|equity|grants|customer_contributions|rate_recovery');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `nerc_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `planned_in_service_date` SET TAGS ('dbx_business_glossary_term' = 'Planned In-Service Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Project Closeout Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_justification` SET TAGS ('dbx_business_glossary_term' = 'Project Justification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'feasibility|design|procurement|construction|commissioning|closeout');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_build|replacement|upgrade|refurbishment|compliance|augmentation');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `rab_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Allocation Percentage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `rab_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_PS|VENTYX|S4HANA|MANUAL');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `variance_to_budget` SET TAGS ('dbx_business_glossary_term' = 'Variance to Budget');
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` SET TAGS ('dbx_subdomain' = 'capital_accounting');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation General Ledger (GL) Account Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `annual_depreciation_charge` SET TAGS ('dbx_business_glossary_term' = 'Annual Depreciation Charge');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operational Expenditure (OPEX) Classification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'capex|opex');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciable_base` SET TAGS ('dbx_business_glossary_term' = 'Depreciable Base');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_area_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits|regulatory_composite');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_value_regex' = 'active|fully_depreciated|suspended|retired|disposed');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `last_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Run Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Notes');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `placed_in_service_date` SET TAGS ('dbx_business_glossary_term' = 'Placed in Service Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `rab_depreciation_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Depreciation Treatment');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `rab_depreciation_treatment` SET TAGS ('dbx_value_regex' = 'included|excluded|deferred|accelerated|regulatory_lag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `rab_depreciation_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `rab_depreciation_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `rab_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Inclusion Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `regulatory_depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Depreciation Rate (Percent)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'macrs|straight_line|declining_balance|bonus_depreciation|section_179');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `tax_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Tax Useful Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`depreciation_schedule` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` SET TAGS ('dbx_subdomain' = 'maintenance_management');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `spare_parts_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Inventory ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `direct_load_control_device_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Load Control Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `direct_load_control_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `direct_load_control_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `last_purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval|discontinued');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'spare_part|consumable|critical_spare|tool|safety_equipment|bulk_material');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `obsolete_flag` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `preferred_supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `preferred_supplier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hand');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `serial_number_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Tracking Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'VENTYX|SAP_MM|SAP_PM|MANUAL');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `stocking_location_code` SET TAGS ('dbx_business_glossary_term' = 'Stocking Location Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `stocking_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `stocking_location_name` SET TAGS ('dbx_business_glossary_term' = 'Stocking Location Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_value_regex' = 'ambient|climate_controlled|refrigerated|outdoor|hazmat_storage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ALTER COLUMN `warranty_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` SET TAGS ('dbx_subdomain' = 'maintenance_management');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Inspection ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `capacitor_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Capacitor Bank Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `network_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Segment Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `power_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Power Transformer Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `sectionalizing_device_id` SET TAGS ('dbx_business_glossary_term' = 'Sectionalizing Device Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `sectionalizing_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `sectionalizing_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature in Celsius');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `asset_load_percent` SET TAGS ('dbx_business_glossary_term' = 'Asset Load Percentage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity Classification');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|informational');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `defects_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `document_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration in Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency in Months');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `health_index` SET TAGS ('dbx_business_glossary_term' = 'Asset Health Index');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `health_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `health_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|pending_review|approved');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `overall_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Condition Score');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|marginal|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `photo_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Follow-Up Action');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'repair|replace|monitor|no_action|further_investigation|emergency_repair');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `regulatory_standard_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `scada_data_source_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Data Source Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'VENTYX|SCADA|MOBILE_APP|PI|ADMS');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `test_result_unit` SET TAGS ('dbx_business_glossary_term' = 'Test Result Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `test_result_value` SET TAGS ('dbx_business_glossary_term' = 'Test Result Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `threshold_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit');
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions During Inspection');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` SET TAGS ('dbx_subdomain' = 'capital_accounting');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Valuation ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `appraiser_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Certification Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `appraiser_name` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Valuation Basis');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'independent_appraisal|internal_estimate|regulatory_formula|indexed_cost|engineering_assessment|third_party_valuation');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `condition_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Score');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `depreciation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `economic_obsolescence_factor` SET TAGS ('dbx_business_glossary_term' = 'Economic Obsolescence Factor');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `fair_market_value` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `functional_obsolescence_factor` SET TAGS ('dbx_business_glossary_term' = 'Functional Obsolescence Factor');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `gross_replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Gross Replacement Cost');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `inflation_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Inflation Adjustment Factor');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `inflation_index_applied` SET TAGS ('dbx_business_glossary_term' = 'Inflation Index Applied');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Replacement Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'cost_approach|market_approach|income_approach|hybrid|index_trending|engineering_estimate');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `odrc_value` SET TAGS ('dbx_business_glossary_term' = 'Optimised Depreciated Replacement Cost (ODRC) Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `puc_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Submission Reference');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `rab_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Inclusion Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `rate_case_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Docket Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life Years');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Valuation Report Reference');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'rab|insurance_replacement_cost|fair_value|depreciated_replacement_cost|market_value|liquidation_value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` SET TAGS ('dbx_subdomain' = 'capital_accounting');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Warranty Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claim_documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Claim Documentation Required');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claim_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Method');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claim_submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|phone|fax|mail');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claims_approved_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Approved Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claims_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Limit Amount');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claims_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Limit Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claims_rejected_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Rejected Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `claims_submitted_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Submitted Count');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `covered_components` SET TAGS ('dbx_business_glossary_term' = 'Covered Components List');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Deductible Amount');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Warranty Document Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration in Months');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Warranty Exclusions Description');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `labor_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Labor Covered Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `maintenance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Warranty Maintenance Requirements');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Contact Name');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `manufacturer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `parts_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Covered Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `performance_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `prorated_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Prorated Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Registration Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `repair_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Warranty Repair Time in Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Warranty Response Time in Hours');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `total_claims_recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Recovered Amount');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `total_warranty_value` SET TAGS ('dbx_business_glossary_term' = 'Total Warranty Value');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transferable Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `travel_covered_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Covered Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|suspended|pending_activation');
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` SET TAGS ('dbx_subdomain' = 'maintenance_management');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` SET TAGS ('dbx_association_edges' = 'asset.maintenance_plan,asset.spare_parts_inventory');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `maintenance_plan_parts_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Parts Requirement ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Parts Requirement - Maintenance Plan Id');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `spare_parts_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Parts Requirement - Spare Parts Inventory Id');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `alternative_part_group_code` SET TAGS ('dbx_business_glossary_term' = 'Alternative Part Group Code');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `consumption_type` SET TAGS ('dbx_business_glossary_term' = 'Consumption Type');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `criticality_for_plan` SET TAGS ('dbx_business_glossary_term' = 'Criticality for Plan');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `estimated_unit_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Cost USD');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `lead_time_buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Buffer Days');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan_parts_requirement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
