-- Schema for Domain: maintenance | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`maintenance` COMMENT 'Plant maintenance and asset management domain for production equipment, reactors, vessels, pumps, and instrumentation. Includes maintenance work orders, preventive maintenance schedules, equipment master data, maintenance history, spare parts management, equipment reliability metrics (MTBF, MTTR), P&ID asset registry, equipment calibration, and MOC workflows for process equipment changes. Integrates with SAP PM and supports PSM mechanical integrity requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` (
    `equipment_id` BIGINT COMMENT 'Unique surrogate identifier for each maintainable plant asset in the equipment master registry. Primary key for the equipment data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Asset ownership tracking; required for customer asset registers and billing reports linking equipment to the owning account.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Required for Service Contract Management: links each equipment to the owning customers site for billing, compliance, and maintenance scheduling.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Chemical plant equipment (reactors, compressors, heat exchangers) are capitalized fixed assets. Linking equipment to its fixed_asset record enables depreciation tracking, net book value reporting, ass',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Equipment must be assigned to a functional location for hierarchy and maintenance planning.',
    `maintenance_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this equipment is physically installed and operated.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Equipment spec sheets require exact material grade for construction; regulatory compliance (PSM, ASME) and corrosion tracking depend on this link.',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: OSHA PSM standard mandates that process safety information (PSI) be accessible for covered equipment. Maintenance technicians performing work on PSM-covered equipment must reference the PSI document f',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In chemical manufacturing, equipment is assigned to profit centers (e.g., Specialty Chemicals unit, Plastics division) for segment P&L reporting and maintenance cost allocation. Finance controllers re',
    `sds_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.sds_record. Business justification: In chemical manufacturing PSM environments, equipment handling hazardous chemicals must be associated with the governing SDS for emergency response planning, MOC reviews, and hazardous area classifica',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Needed for equipment procurement, warranty, recall, and regulatory compliance tracking of the supplier of each equipment.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: Equipment traceability to originating vendor manufacturing site is required for warranty claims, spare parts sourcing, and PSM/regulatory audits in chemical manufacturing. vendor_id alone is insuffici',
    `asset_number` STRING COMMENT 'SAP FI-AA fixed asset number linked to this equipment for financial accounting, depreciation calculation, and CapEx tracking. Bridges the maintenance and finance domains.',
    `asset_tag_number` STRING COMMENT 'Physical asset tag or nameplate number affixed to the equipment in the field. Used for physical identification during inspections, maintenance activities, and fixed asset accounting reconciliation.',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether this equipment (typically instrumentation) requires periodic calibration to maintain measurement accuracy and regulatory compliance. True=calibration program applies; False=not applicable.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the equipment capacity value (e.g., m3, m3/hr, kW, kg/hr, bar). Follows SI unit conventions for chemical process engineering.',
    `capacity_value` DECIMAL(18,2) COMMENT 'Principal rated capacity or throughput of the equipment (e.g., volumetric capacity for vessels in m³, flow rate for pumps in m³/hr, heat duty for heat exchangers in kW). The unit is specified in capacity_unit.',
    `commissioning_date` DATE COMMENT 'Date the equipment was formally commissioned and accepted into operational service following installation, pre-commissioning checks, and startup testing. Distinct from installation date.',
    `construction_year` STRING COMMENT 'Year in which the equipment was manufactured or constructed. Used for age-based risk assessment, remaining useful life estimation, and regulatory inspection scheduling.',
    `corrosion_allowance_mm` DECIMAL(18,2) COMMENT 'Designed corrosion allowance in millimeters added to the minimum required wall thickness to account for expected corrosion over the equipments design life. Used in fitness-for-service assessments and remaining life calculations.',
    `cost_center` STRING COMMENT 'SAP CO cost center to which maintenance costs for this equipment are charged. Used for maintenance cost allocation, OpEx reporting, and budget variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment master record was first created in the system. Provides audit trail for record origination and supports data lineage tracking in the Silver layer.',
    `criticality_class` STRING COMMENT 'Equipment criticality ranking used to prioritize maintenance resources and inspection frequency. A=Safety-critical/production-critical (highest priority, PSM-covered); B=Important but has redundancy or workaround; C=Non-critical/low impact on safety or production.. Valid values are `A|B|C`',
    `decommission_date` DATE COMMENT 'Date the equipment was permanently removed from service and decommissioned. Null for active equipment. Required for fixed asset retirement accounting and regulatory closure documentation.',
    `design_pressure_kpa` DECIMAL(18,2) COMMENT 'Maximum allowable working pressure (MAWP) for which the equipment was designed, expressed in kilopascals (kPa). Critical nameplate data for pressure vessel inspection, relief valve sizing, and PSM mechanical integrity documentation.',
    `design_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable design temperature for which the equipment was designed, expressed in degrees Celsius. Used for material of construction verification, thermal stress analysis, and PSM mechanical integrity records.',
    `equipment_category` STRING COMMENT 'SAP PM equipment category code classifying the asset type: M=Mechanical, E=Electrical, I=Instrumentation, P=Piping, V=Vessel/Reactor. Drives maintenance planning strategy and inspection requirements. [ENUM-REF-CANDIDATE: M|E|I|P|V|C|R — promote to reference product]. Valid values are `M|E|I|P|V`',
    `equipment_class` STRING COMMENT 'Detailed equipment classification within the category (e.g., Centrifugal Pump, Reciprocating Compressor, Shell-and-Tube Heat Exchanger, Pressure Vessel, Control Valve, Thermocouple). Aligns with ISO 14224 equipment taxonomy for reliability data collection.',
    `equipment_name` STRING COMMENT 'Human-readable descriptive name or short description of the equipment asset (e.g., Reactor Feed Pump, Distillation Column Overhead Condenser). Corresponds to SAP PM equipment description field.',
    `equipment_number` STRING COMMENT 'Externally-known alphanumeric equipment number assigned in SAP PM (EQUNR). Serves as the primary business identifier used across maintenance work orders, inspection records, and P&ID cross-references.',
    `equipment_status` STRING COMMENT 'Current operational lifecycle status of the equipment asset. Active=in normal service; Inactive=installed but not in service; Decommissioned=permanently removed from service; Standby=available as backup; Under_Maintenance=currently undergoing planned or corrective maintenance.. Valid values are `active|inactive|decommissioned|standby|under_maintenance`',
    `hazardous_area_classification` STRING COMMENT 'Electrical area classification of the location where this equipment is installed, per NEC/IEC standards. Determines requirements for explosion-proof or intrinsically safe electrical equipment. Zone 0/1/2 per IEC 60079; Division 1/2 per NEC Article 500.. Valid values are `Zone 0|Zone 1|Zone 2|Division 1|Division 2|non-hazardous`',
    `inspection_interval_months` STRING COMMENT 'Required inspection frequency in months as determined by regulatory requirements, risk-based inspection (RBI) analysis, or manufacturer recommendations. Used to auto-calculate next_inspection_date.',
    `installation_date` DATE COMMENT 'Date the equipment was physically installed at its current functional location. Marks the start of the equipments operational lifecycle at this site for maintenance history and warranty tracking.',
    `insulation_type` STRING COMMENT 'Type of thermal or acoustic insulation applied to the equipment (e.g., mineral wool, calcium silicate, cellular glass, none). Relevant for corrosion under insulation (CUI) inspection programs and energy efficiency assessments.',
    `last_inspection_date` DATE COMMENT 'Date of the most recently completed inspection for this equipment. Used to calculate inspection intervals, assess compliance with regulatory inspection frequency requirements, and support risk-based inspection (RBI) programs.',
    `maintenance_planner_group` STRING COMMENT 'SAP PM planner group code responsible for planning and scheduling maintenance activities for this equipment. Determines which maintenance team owns the equipments work order planning.',
    `maintenance_strategy` STRING COMMENT 'Assigned maintenance strategy for this equipment asset: Time_Based=fixed interval preventive maintenance; Condition_Based=maintenance triggered by condition monitoring thresholds; Predictive=data-driven prediction of failure; Run_To_Failure=no planned maintenance; Reliability_Centered=RCM-derived strategy.. Valid values are `time_based|condition_based|predictive|run_to_failure|reliability_centered`',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM). Used for spare parts sourcing, warranty claims, and technical support escalation.',
    `moc_status` STRING COMMENT 'Current Management of Change (MOC) workflow status for any pending or recent modification to this equipment. Not_Required=no active MOC; Pending=MOC initiated and under review; Approved=MOC approved, change authorized; Closed=MOC completed and documented.. Valid values are `not_required|pending|approved|closed`',
    `model_number` STRING COMMENT 'Manufacturers model or part number for this equipment type. Used for spare parts procurement, technical documentation retrieval, and like-for-like replacement identification.',
    `next_calibration_date` DATE COMMENT 'Date by which the next calibration of this instrument or measurement device must be completed to maintain traceability and compliance. Null if calibration_required is False.',
    `next_inspection_date` DATE COMMENT 'Date of the next mandatory regulatory or internal inspection due for this equipment. Drives inspection scheduling for PSM mechanical integrity, API 510/570/653 inspections, and insurance surveys.',
    `operating_pressure_kpa` DECIMAL(18,2) COMMENT 'Normal operating pressure of the equipment under standard process conditions, expressed in kilopascals (kPa). Used for process monitoring, deviation detection, and SPC control limit setting.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Normal operating temperature of the equipment under standard process conditions, expressed in degrees Celsius. Used for process monitoring, heat balance calculations, and corrosion rate estimation.',
    `pi_tag_reference` STRING COMMENT 'Aveva PI System historian tag name or tag pattern associated with this equipment for real-time process data retrieval (e.g., temperature, pressure, flow readings). Enables linkage between equipment master data and real-time operational data.',
    `pid_tag` STRING COMMENT 'The P&ID tag number identifying this equipment on process engineering drawings (e.g., P-101A, E-201, V-301). Used for cross-referencing with Piping and Instrumentation Diagrams, HAZOP studies, and PSM documentation.',
    `psm_covered` BOOLEAN COMMENT 'Indicates whether this equipment is subject to OSHA Process Safety Management (PSM) mechanical integrity requirements under 29 CFR 1910.119. True=PSM-covered; requires documented inspection, testing, and quality assurance program.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for the equipment unit. Required for warranty tracking, OEM service records, and regulatory inspection documentation.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Dry operating weight of the equipment in kilograms. Used for structural load calculations, rigging and lifting plans, and transportation logistics for equipment removal or replacement.',
    `work_center` STRING COMMENT 'SAP PM work center responsible for executing maintenance activities on this equipment (e.g., MECH-01, ELEC-02, INST-03). Drives labor scheduling, capacity planning, and cost center assignment.',
    CONSTRAINT pk_equipment PRIMARY KEY(`equipment_id`)
) COMMENT 'Equipment master data registry for all maintainable plant assets including reactors, vessels, pumps, compressors, heat exchangers, instrumentation, and piping systems. SSOT for equipment identity, technical specifications (design pressure/temperature, materials of construction, nameplate data), installation history, criticality classification (A/B/C), PSM mechanical integrity status, and regulatory inspection requirements. Supports equipment taxonomy, BOM structure, P&ID tag cross-reference, and full maintenance history linkage.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` (
    `functional_location_id` BIGINT COMMENT 'Unique surrogate identifier for the functional location record in the lakehouse. Primary key for the functional_location data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Enables charging maintenance expenses of a functional location to its assigned cost center, used in plant cost‑center performance reports.',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Functional location belongs to a plant; plant_code is redundant after FK.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Functional locations (process units, plant areas) in chemical manufacturing carry profit center assignments for segment reporting. functional_location already has cost_center_id but lacks profit_cente',
    `abc_indicator` STRING COMMENT 'Criticality classification of the functional location using the SAP PM ABC indicator. A = critical (production-critical, safety-critical), B = important (significant impact), C = non-critical (minimal impact). Drives maintenance prioritization, spare parts stocking, and OEE improvement focus. Corresponds to SAP PM IFLOT-ABCKZ.. Valid values are `A|B|C`',
    `asset_number` STRING COMMENT 'Financial fixed asset number from SAP FI/CO Asset Accounting linked to this functional location. Enables reconciliation between the maintenance asset hierarchy and the financial asset register for CapEx tracking, depreciation, and SOX compliance.',
    `building_or_area_code` STRING COMMENT 'Physical building, bay, or plant area code where the functional location is situated. Used for maintenance crew routing, emergency response, and facility management. Complements the hierarchical floc_code with a physical location reference.',
    `catalog_profile_code` STRING COMMENT 'SAP PM catalog profile assigned to this functional location, defining the damage codes, cause codes, and activity codes available for maintenance notifications and work orders. Ensures standardized failure coding for reliability analysis and CAPA workflows. Corresponds to SAP PM IFLOT-RBNR.',
    `commissioning_date` DATE COMMENT 'Date on which the functional location was formally commissioned and handed over to operations. Marks the start of the operational lifecycle and the beginning of preventive maintenance scheduling. May differ from installation_date for complex systems.',
    `company_code` STRING COMMENT 'SAP company code (Buchungskreis) representing the legal entity that owns this functional location. Required for financial reporting, asset accounting, and SOX compliance. Corresponds to SAP PM IFLOT-BUKRS.',
    `construction_material` STRING COMMENT 'Primary material of construction for the functional location (e.g., Carbon Steel A516-70, 316L Stainless Steel, Hastelloy C-276, FRP). Critical for corrosion management, inspection planning, and chemical compatibility assessment under REACH and PSM requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this functional location record was first created in the source system (SAP PM). Provides audit trail for asset master data governance and SOX compliance.',
    `decommission_date` DATE COMMENT 'Date on which the functional location was formally decommissioned and removed from active service. Null for active locations. Required for asset lifecycle reporting, regulatory closure documentation, and EPA/OSHA decommissioning notifications.',
    `floc_code` STRING COMMENT 'The externally-known alphanumeric code uniquely identifying the functional location within the plant hierarchy, as maintained in SAP PM (IFLOT-TPLNR). Follows the plant-unit-area-system-subsystem naming convention (e.g., CH01-RX-001-P-001). This is the business identifier used on work orders, P&IDs, and maintenance records.',
    `floor_or_elevation` STRING COMMENT 'Floor level or elevation reference (e.g., Grade Level, EL +12.5m, Mezzanine Level 2) for the functional location within a building or structure. Supports maintenance crew navigation and emergency response planning.',
    `functional_location_category` STRING COMMENT 'Broad equipment category grouping for the functional location. Used for maintenance strategy segmentation, PSM mechanical integrity scope definition, and EHS compliance reporting. Aligns with ISO 14224 taxonomy. [ENUM-REF-CANDIDATE: process_equipment|utility_equipment|instrumentation|electrical|civil_structural|safety_system|environmental_control — 7 candidates stripped; promote to reference product]',
    `functional_location_description` STRING COMMENT 'Human-readable description of the functional location, describing its physical or logical purpose within the plant (e.g., Reactor Feed Pump — Unit 3 Ethylene Plant). Corresponds to SAP PM IFLOT-PLTXT.',
    `geo_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the functional location in decimal degrees (WGS84). Enables spatial analytics, emergency response planning, and integration with plant GIS systems for asset location visualization.',
    `geo_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the functional location in decimal degrees (WGS84). Enables spatial analytics, emergency response planning, and integration with plant GIS systems for asset location visualization.',
    `hazardous_area_classification` STRING COMMENT 'Electrical area classification for the functional location per NEC/IEC standards, indicating the presence and likelihood of flammable gases or vapors. Drives equipment selection, inspection requirements, and EHS compliance. Critical for OSHA and NFPA compliance.. Valid values are `zone_0|zone_1|zone_2|non_hazardous|division_1|division_2`',
    `inspection_class` STRING COMMENT 'Inspection methodology classification for this functional location. RBI (Risk-Based Inspection) applies to pressure equipment per API 580/581; fixed_interval for time-based statutory inspections; condition_based for CBM programs; run_to_failure for non-critical assets. Drives inspection planning and regulatory compliance.. Valid values are `RBI|fixed_interval|condition_based|run_to_failure`',
    `installation_date` DATE COMMENT 'Date on which the functional location (equipment or system) was physically installed and commissioned at the plant. Used for asset age calculations, depreciation scheduling, and mechanical integrity baseline establishment.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this functional location record in the source system (SAP PM). Supports change tracking, data lineage, and master data governance audit requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recently completed inspection for this functional location. Used to calculate inspection overdue status, support audit readiness, and demonstrate PSM mechanical integrity compliance to regulators.',
    `linear_asset_flag` BOOLEAN COMMENT 'Indicates whether this functional location represents a linear asset (e.g., pipeline, cable tray, conveyor) as opposed to a point asset. Linear assets require linear reference measurement for inspection and maintenance location identification.',
    `location_status` STRING COMMENT 'Current operational lifecycle status of the functional location. Drives maintenance scheduling eligibility, work order creation, and PSM mechanical integrity scope. Decommissioned locations are retained for historical traceability.. Valid values are `active|inactive|decommissioned|under_construction|mothballed`',
    `location_type` STRING COMMENT 'Hierarchical level classification of the functional location within the plant topology. Defines whether this node represents a plant, process unit, area, system, or sub-system. Drives hierarchy navigation and maintenance planning scope.. Valid values are `plant|unit|area|system|subsystem`',
    `maintenance_strategy_code` STRING COMMENT 'SAP PM maintenance strategy assigned to this functional location, defining the preventive maintenance cycle (e.g., time-based, condition-based, predictive). Drives automatic generation of maintenance orders and inspection plans. Corresponds to SAP PM IFLOT-MSTRAT.',
    `moc_required` BOOLEAN COMMENT 'Indicates whether any modification to this functional location requires a formal Management of Change (MOC) workflow per OSHA PSM requirements. Typically true for PSM-covered locations and safety-critical systems. Drives MOC initiation in the change management process.',
    `next_inspection_date` DATE COMMENT 'Date of the next scheduled statutory or preventive inspection for this functional location. Used for maintenance planning, regulatory compliance tracking, and PSM mechanical integrity program management. Derived from inspection intervals but stored for operational scheduling.',
    `object_type` STRING COMMENT 'SAP PM object type code classifying the functional location by equipment category (e.g., reactor, pump, heat exchanger, vessel, compressor, instrumentation). Drives maintenance strategy assignment and spare parts planning. Corresponds to SAP PM IFLOT-EQART. [ENUM-REF-CANDIDATE: reactor|pump|heat_exchanger|vessel|compressor|instrumentation|piping|column|tank|filter — promote to reference product]',
    `pi_tag_reference` STRING COMMENT 'Primary process historian tag identifier in the Aveva PI System associated with this functional location. Enables linkage between the SAP PM asset hierarchy and real-time process data for condition-based maintenance, OEE analysis, and predictive analytics.',
    `pid_reference` STRING COMMENT 'Reference number or drawing identifier of the P&ID document on which this functional location appears. Critical for PSM mechanical integrity, MOC workflows, and HAZOP studies. Enables traceability between the physical asset hierarchy and engineering drawings.',
    `planner_group_code` STRING COMMENT 'SAP PM planner group responsible for planning and scheduling maintenance activities at this functional location. Used for workload distribution, capacity planning, and maintenance KPI reporting. Corresponds to SAP PM IFLOT-INGRP.',
    `pressure_rating_bar` DECIMAL(18,2) COMMENT 'Maximum allowable working pressure (MAWP) for the functional location in bar units. Used for mechanical integrity assessments, inspection planning, and PSM compliance. Applies primarily to pressure vessels, reactors, and piping systems.',
    `process_unit_name` STRING COMMENT 'Name of the chemical process unit or production unit to which this functional location belongs (e.g., Ethylene Cracker Unit 1, Sulfuric Acid Plant, Polymerization Train B). Provides operational context for maintenance planning and P&ID alignment.',
    `psm_covered` BOOLEAN COMMENT 'Indicates whether this functional location is within the scope of OSHA Process Safety Management (PSM) regulations (29 CFR 1910.119). PSM-covered locations require mechanical integrity programs, PHA/HAZOP studies, and MOC documentation.',
    `sort_field` STRING COMMENT 'Alphanumeric sort field used for grouping and filtering functional locations in maintenance reports and work order lists. Typically encodes plant area, equipment class, or operational unit for reporting convenience. Corresponds to SAP PM IFLOT-EQFNR.',
    `temperature_rating_c` DECIMAL(18,2) COMMENT 'Maximum allowable design temperature for the functional location in degrees Celsius. Used for material selection validation, mechanical integrity assessments, and process safety compliance.',
    `work_center_code` STRING COMMENT 'SAP work center responsible for performing maintenance activities at this functional location. Used for capacity planning, scheduling, and cost allocation. Corresponds to SAP PM IFLOT-GEWRK.',
    CONSTRAINT pk_functional_location PRIMARY KEY(`functional_location_id`)
) COMMENT 'Hierarchical functional location structure representing the physical and logical plant topology — plant, unit, area, system, and sub-system levels. Provides the spatial context for equipment installation and maintenance activities. Aligns with SAP PM Functional Location (IFLOT) and supports P&ID-based asset hierarchy for chemical process units.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key for the work order entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Work orders are billed to a customer account; linking provides the Accounting & Invoicing report and compliance with contract billing.',
    `campaign_plan_id` BIGINT COMMENT 'Foreign key linking to planning.campaign_plan. Business justification: Campaign changeover and preparation work orders in chemical manufacturing are explicitly tied to campaign plans. Maintenance work orders for reactor cleaning, catalyst loading, and equipment reconfigu',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Needed for Production Work Order report to track which chemical product is being manufactured in each work order.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: External maintenance service contracts (turnaround contracts, OEM service agreements) govern work execution in chemical plants. Linking work_order to the supply contract enables contract utilization t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating labor and material costs of each work order to the proper cost center for financial reporting and budgeting.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment, asset, reactor, vessel, pump, or instrumentation device that is the subject of this maintenance work order.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Capital improvement work orders in chemical plants must reference the fixed asset being improved for capitalization workflows (asset under construction settlement, IAS 16 subsequent expenditure). Fina',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location (plant area, process unit, or facility section) where the maintenance work is to be performed. Functional locations represent the hierarchical structure of the plant.',
    `inspection_audit_id` BIGINT COMMENT 'Foreign key linking to ehs.inspection_audit. Business justification: Corrective work orders are generated directly from EHS inspection/audit findings in chemical plants. Compliance tracking requires demonstrating that all audit findings resulted in completed work order',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Maintenance work orders in chemical manufacturing are settled to internal orders for CAPEX/OPEX classification, turnaround cost tracking, and budget consumption reporting. SAP PM/CO integration mandat',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Maintenance work orders often replace raw materials; linking enables material cost tracking, inventory deduction, and safety‑data‑sheet reference.',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Maintenance work on permitted emission sources or air/water discharge equipment must reference the governing operating permit to ensure work scope does not violate permit conditions. Permit compliance',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Service work orders are generated from sales opportunities; needed for service revenue attribution and opportunity closure analysis.',
    `pm_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance plan that generated this work order, if applicable. Null for corrective or breakdown work orders not originating from a scheduled maintenance plan.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Turnaround and shutdown maintenance work orders are explicitly tied to production plans in chemical manufacturing. A work order for pre-campaign equipment preparation references the production plan it',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Shutdown and changeover maintenance work orders must complete before a production schedule slot begins. In chemical manufacturing, work orders for equipment preparation are directly linked to the prod',
    `sds_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.sds_record. Business justification: OSHA PSM and COSHH compliance require work orders for maintenance on chemical-service equipment to reference the current SDS. Technicians must review chemical hazards before execution. This supports r',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Links external maintenance contractor (vendor) to work order for cost allocation, contract compliance, and safety reporting.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual total duration of the maintenance work in hours, calculated from start to completion timestamps. Used for performance analysis and future work estimation.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work execution was completed, recorded when all work activities are finished and equipment is ready for return to service.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual total cost of internal labor based on confirmed hours and standard or actual labor rates. Used for maintenance cost accounting and variance analysis.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual total labor hours consumed across all crafts and operations, confirmed through time confirmations. Used for cost accounting and productivity analysis.',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual total cost of spare parts, materials, and consumables consumed during work order execution, based on goods issue transactions and purchase order receipts.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work execution began, recorded by the maintenance crew or supervisor when work commences on site.',
    `completion_notes` STRING COMMENT 'Detailed notes recorded by the maintenance crew upon work completion, documenting work performed, parts replaced, test results, and any deviations from planned scope.',
    `corrective_action` STRING COMMENT 'Description of the corrective action taken to address the root cause and prevent recurrence. Part of the Corrective and Preventive Action (CAPA) process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was first created in the maintenance management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost amounts on this work order (e.g., USD, EUR, GBP). Supports multi-currency operations for global manufacturing sites.. Valid values are `^[A-Z]{3}$`',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours that the equipment or process unit was offline due to this maintenance work. Used for Overall Equipment Effectiveness (OEE) calculation and production loss analysis.',
    `downtime_required` BOOLEAN COMMENT 'Indicates whether this maintenance work requires taking the equipment or process unit offline. True for intrusive maintenance; false for online maintenance activities.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Planned total duration of the maintenance work in hours, used for scheduling and resource allocation. Includes all craft labor time across all operations.',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Planned total cost of internal labor based on estimated hours and standard labor rates by craft. Used for maintenance budget planning.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours across all crafts and operations for this work order. Used for workforce planning and cost estimation.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Planned total cost of spare parts, materials, and consumables required for this work order. Used for budget planning and work order approval.',
    `external_service_cost` DECIMAL(18,2) COMMENT 'Total cost of external contractor services, third-party vendors, or specialized service providers engaged for this work order. Includes service labor, equipment rental, and contractor-supplied materials.',
    `failure_mode` STRING COMMENT 'Description of the equipment failure mode or degradation mechanism that necessitated this corrective maintenance work. Used for reliability analysis and Root Cause Investigation (RCI).',
    `lockout_tagout_required` BOOLEAN COMMENT 'Indicates whether lockout/tagout procedures are required for this work order to control hazardous energy sources. True for work on equipment with electrical, mechanical, hydraulic, or chemical energy hazards.',
    `long_text` STRING COMMENT 'Detailed instructions, technical notes, safety precautions, and procedural guidance for executing the maintenance work. May include references to Standard Operating Procedures (SOP), Process and Instrumentation Diagrams (P&ID), or special tools required.',
    `moc_reference_number` STRING COMMENT 'Reference number of the Management of Change (MOC) authorization if this work order involves modifications to process equipment, instrumentation, or control systems that require formal change management per PSM requirements.. Valid values are `^MOC[0-9]{6,10}$`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this work order record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was last modified in the maintenance management system.',
    `permit_to_work_number` STRING COMMENT 'Reference number of the safety permit authorizing this maintenance work, required for work in hazardous areas, confined spaces, hot work, or energized equipment per Process Safety Management (PSM) requirements.. Valid values are `^PTW[0-9]{6,10}$`',
    `priority` STRING COMMENT 'Business priority level assigned to the work order indicating urgency and impact on production operations. Critical priority indicates immediate safety or production impact requiring emergency response.. Valid values are `critical|high|medium|low`',
    `root_cause` STRING COMMENT 'Identified root cause of the equipment failure or maintenance need, determined through Root Cause Investigation (RCI). Used to drive Corrective and Preventive Action (CAPA) programs.',
    `scheduled_end_date` DATE COMMENT 'Planned date when maintenance work is scheduled to be completed. Used for outage planning and production restart coordination.',
    `scheduled_start_date` DATE COMMENT 'Planned date when maintenance work is scheduled to begin. Used for capacity planning and coordination with production schedules.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total actual cost of the work order including internal labor, materials, and external services. Used for maintenance cost reporting and asset lifecycle cost analysis.',
    `work_center_code` STRING COMMENT 'Code identifying the maintenance work center (craft shop or service group) that will execute the work. Work centers represent organizational units such as mechanical, electrical, instrumentation, or contractor crews.. Valid values are `^[A-Z0-9]{4,8}$`',
    `work_order_description` STRING COMMENT 'Short text description of the maintenance work to be performed, summarizing the scope and nature of the activity for quick identification and communication.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, typically system-generated and used for tracking and communication across maintenance teams and external service providers.. Valid values are `^WO[0-9]{8}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order tracking progression from creation through execution to closure. Released status indicates work is approved and ready for execution; completed indicates work is finished but administrative closure pending. [ENUM-REF-CANDIDATE: created|released|in_progress|on_hold|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the maintenance work order indicating the nature of the maintenance activity: planned maintenance, corrective repair, preventive maintenance schedule, predictive maintenance based on condition monitoring, emergency breakdown response, or capital project work.. Valid values are `planned|corrective|preventive|predictive|breakdown|project`',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core maintenance work order record capturing all planned, corrective, preventive, predictive, and externally-contracted maintenance activities. Tracks work order type, priority, functional location, equipment, planner group, work center, scheduled/actual dates, labor hours, material consumption summary, internal/external cost totals, permit-to-work reference, and completion status. Supports both internal craft execution and external service provider work. Primary transactional entity for maintenance execution, cost tracking, and PM compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` (
    `work_order_operation_id` BIGINT COMMENT 'Unique identifier for the work order operation. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each operation may be billed to a specific cost center; required for detailed operation‑level cost tracking and internal charge‑back.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment, asset, or technical object on which the operation is performed (e.g., pump, reactor, vessel, instrument).',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location (process unit, area, or system) where the operation is performed. Provides hierarchical location context.',
    `maintenance_plant_id` BIGINT COMMENT 'FK to maintenance.plant',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Operation‑level details need the specific material used for accurate labor/material costing and SDS compliance.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Associates each operation’s consumed spare parts with the purchase order that supplied them, enabling traceability, inventory reconciliation, and audit of maintenance costs.',
    `task_list_id` BIGINT COMMENT 'Foreign key linking to maintenance.task_list. Business justification: Work order operations in SAP PM are frequently generated from task list operations (standard_text_key and operation_number attributes on work_order_operation reflect this). Adding task_list_id to work',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or service provider performing the operation, applicable only when external_operation_flag is true.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (maintenance crew, shop, or organizational unit) responsible for executing this operation.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent maintenance work order that contains this operation. Links to the work_order product.',
    `activity_type` STRING COMMENT 'Classification of the maintenance activity being performed (e.g., mechanical repair, electrical work, instrumentation calibration, inspection). Used for cost allocation and capacity planning.. Valid values are `^[A-Z0-9]{4,6}$`',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Date and time when work on the operation was completed, as recorded in the final time confirmation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Date and time when work on the operation actually began, as recorded in the first time confirmation.',
    `actual_work_duration` DECIMAL(18,2) COMMENT 'Actual labor hours spent on the operation as recorded through time confirmations. Used for performance analysis and variance reporting.',
    `actual_work_unit` STRING COMMENT 'Unit of measure for actual work duration. H=hours, MIN=minutes, D=days.. Valid values are `H|MIN|D`',
    `calculation_key` STRING COMMENT 'Key that determines how operation duration is calculated based on work quantity and standard values. Used for automatic time calculation in preventive maintenance.. Valid values are `^[A-Z0-9]{1,6}$`',
    `confirmation_required_flag` BOOLEAN COMMENT 'Indicates whether time confirmation is required for this operation. True if the operation must be confirmed with actual hours and completion status.',
    `control_key` STRING COMMENT 'Control key that determines the operation type and scheduling parameters (e.g., PM01 for internal processing, PM02 for external service, PM03 for inspection). Defines whether the operation requires confirmation, external processing, or automatic goods issue.. Valid values are `^[A-Z0-9]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the operation record was first created in the system. Audit trail for record creation.',
    `earliest_finish_date` DATE COMMENT 'Earliest date the operation can be completed based on earliest start date and planned duration.',
    `earliest_start_date` DATE COMMENT 'Earliest date the operation can begin based on scheduling constraints, predecessor operations, and resource availability.',
    `external_operation_flag` BOOLEAN COMMENT 'Indicates whether this operation is performed by an external service provider rather than internal maintenance staff. True for subcontracted work.',
    `final_confirmation_flag` BOOLEAN COMMENT 'Indicates whether the operation has received its final confirmation and no further time bookings are expected. True when operation is complete.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the operation record was last updated. Audit trail for record changes.',
    `latest_finish_date` DATE COMMENT 'Latest date the operation must be completed to meet the work order required end date.',
    `latest_start_date` DATE COMMENT 'Latest date the operation must start to meet the work order required end date without delaying subsequent operations.',
    `number_of_capacities` STRING COMMENT 'Number of people or capacity units required to perform the operation simultaneously. Used for resource leveling and scheduling.',
    `operation_long_text` STRING COMMENT 'Detailed description of the operation including step-by-step instructions, safety precautions, and technical specifications required to complete the task.',
    `operation_number` STRING COMMENT 'Sequential operation number within the work order, typically a 4-digit numeric code (e.g., 0010, 0020, 0030) that defines the execution sequence.. Valid values are `^[0-9]{4}$`',
    `operation_short_text` STRING COMMENT 'Brief description of the operation task, summarizing the work to be performed (e.g., Replace pump seal, Calibrate pressure transmitter).',
    `planned_work_duration` DECIMAL(18,2) COMMENT 'Planned labor hours required to complete the operation, excluding setup time. Used for capacity planning and scheduling.',
    `planned_work_unit` STRING COMMENT 'Unit of measure for planned work duration. H=hours, MIN=minutes, D=days.. Valid values are `H|MIN|D`',
    `priority_code` STRING COMMENT 'Urgency level for the operation. 1=Very High (immediate), 2=High (same day), 3=Medium (this week), 4=Low (this month), 5=Very Low (planned). Inherited from work order but can be overridden at operation level.. Valid values are `1|2|3|4|5`',
    `setup_time` DECIMAL(18,2) COMMENT 'Time required to prepare tools, equipment, and work area before the actual maintenance work can begin. Measured in the same unit as work duration.',
    `standard_text_key` STRING COMMENT 'Reference to standard text templates containing predefined operation instructions, safety procedures, or technical specifications that apply to this operation.. Valid values are `^[A-Z0-9]{1,10}$`',
    `system_status` STRING COMMENT 'Current system-controlled status of the operation in its lifecycle. System status is automatically set by SAP PM based on business transactions and controls which actions are allowed.. Valid values are `created|released|partially_confirmed|confirmed|technically_completed|closed`',
    `teardown_time` DECIMAL(18,2) COMMENT 'Time required to clean up, restore the work area, and return tools after operation completion. Measured in the same unit as work duration.',
    `user_status` STRING COMMENT 'User-defined status that provides additional business-specific status information beyond system status. Configurable per business requirements.',
    `work_quantity` DECIMAL(18,2) COMMENT 'Quantity of work to be performed, expressed in operation-specific units (e.g., number of valves to inspect, meters of pipe to replace, number of calibrations).',
    `work_quantity_unit` STRING COMMENT 'Unit of measure for work quantity (e.g., EA=each, M=meter, KG=kilogram). ISO unit codes.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_work_order_operation PRIMARY KEY(`work_order_operation_id`)
) COMMENT 'Individual operation (task step) within a maintenance work order, representing discrete work activities assigned to specific work centers and crafts. Captures operation number, description, work center, control key, planned and actual labor hours, setup time, execution factor, and confirmation status. Aligns with SAP PM Order Operation (AFVC) and supports detailed labor planning and execution tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`notification` (
    `notification_id` BIGINT COMMENT 'Primary key for notification',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer‑impact notifications must be tied to the responsible account for SLA tracking and regulatory incident reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Notifications trigger maintenance actions that generate costs; linking to cost center ensures proper cost capture in the notification‑to‑work‑order flow.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment, reactor, vessel, pump, or instrumentation asset that is the subject of this notification.',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location (plant area, process unit, or system) where the equipment or asset is installed.',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Notification is tied to a plant; replace plant code with FK.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Maintenance notifications with production_impact_indicator=true must reference the affected production schedule. In chemical manufacturing, production planners receive notifications tied to specific s',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to address this notification. Establishes the notification-to-work-order linkage for tracking resolution.',
    `breakdown_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the breakdown or malfunction in hours, calculated from breakdown start to end timestamps. Key metric for Overall Equipment Effectiveness (OEE) and reliability reporting.',
    `breakdown_end_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment was restored to operational status. Used to calculate Mean Time To Repair (MTTR) and total downtime.',
    `breakdown_indicator` BOOLEAN COMMENT 'Flag indicating whether this notification represents a complete equipment breakdown (true) or a partial malfunction/defect (false). Critical for MTBF and reliability analysis.',
    `breakdown_start_timestamp` TIMESTAMP COMMENT 'Date and time when the equipment breakdown or malfunction began. Used to calculate downtime duration and Mean Time Between Failures (MTBF).',
    `capa_number` STRING COMMENT 'Cross-reference to the CAPA workflow document if a formal corrective action plan was created.',
    `capa_required_indicator` BOOLEAN COMMENT 'Flag indicating whether the notification requires a formal Corrective and Preventive Action (CAPA) workflow to prevent recurrence.',
    `completion_date` DATE COMMENT 'Date when the notification was closed and the issue was resolved. Used for cycle time analysis and notification aging reports.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the notification was completed. Supports time-to-resolve KPI calculation.',
    `ehs_incident_number` STRING COMMENT 'Cross-reference to an EHS incident report if the notification is related to a safety event, environmental release, or occupational health issue.',
    `failure_mode` STRING COMMENT 'Free-text or structured description of how the equipment failed or the nature of the defect. Supports Reliability-Centered Maintenance (RCM) analysis and failure mode and effects analysis (FMEA).',
    `long_description` STRING COMMENT 'Detailed narrative description of the defect, malfunction, or activity request, including symptoms, observations, and any immediate actions taken by the reporter.',
    `malfunction_start_date` DATE COMMENT 'Date when the defect or malfunction was first observed, which may differ from the reported date if discovered retrospectively.',
    `malfunction_start_time` TIMESTAMP COMMENT 'Time of day when the malfunction started, in HH:MM format. Used in conjunction with malfunction_start_date for precise event timing.',
    `moc_number` STRING COMMENT 'Cross-reference to the MOC workflow document if a formal change review was triggered by this notification.',
    `moc_required_indicator` BOOLEAN COMMENT 'Flag indicating whether the corrective action requires a formal Management of Change (MOC) review due to process equipment modification or operating parameter change. Critical for PSM compliance.',
    `notification_number` STRING COMMENT 'Externally visible business identifier for the maintenance notification, typically a 10-12 digit system-generated number used for tracking and communication.. Valid values are `^[0-9]{10,12}$`',
    `notification_status` STRING COMMENT 'Current lifecycle status of the notification: outstanding (newly created), in_progress (under investigation or work order created), completed (resolved), cancelled (no action required).. Valid values are `outstanding|in_progress|completed|cancelled`',
    `notification_type` STRING COMMENT 'Classification of the notification: M1 (Malfunction/Breakdown), M2 (Activity Request), M3 (Inspection Finding), M4 (Other). Determines workflow and priority handling.. Valid values are `M1|M2|M3|M4`',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact: critical (immediate safety or production risk), high (significant impact), medium (moderate impact), low (minor issue).. Valid values are `critical|high|medium|low`',
    `production_impact_indicator` BOOLEAN COMMENT 'Flag indicating whether the malfunction or breakdown caused a production stoppage or throughput reduction (true) or had no production impact (false).',
    `production_loss_quantity` DECIMAL(18,2) COMMENT 'Estimated quantity of product not produced due to the equipment breakdown, measured in the primary unit of measure for the affected production line (e.g., metric tons, liters, kilograms).',
    `production_loss_uom` STRING COMMENT 'Unit of measure for the production loss quantity: MT (metric tons), KG (kilograms), L (liters), GAL (gallons), LB (pounds).. Valid values are `MT|KG|L|GAL|LB`',
    `rci_number` STRING COMMENT 'Cross-reference to the RCI or RCA investigation document if a formal root cause analysis was initiated.',
    `rci_required_indicator` BOOLEAN COMMENT 'Flag indicating whether the failure severity or recurrence pattern requires a formal Root Cause Investigation (RCI) or Root Cause Analysis (RCA).',
    `reported_date` DATE COMMENT 'Date when the notification was created in the system. Used for response time analysis and notification aging reports.',
    `reported_timestamp` TIMESTAMP COMMENT 'Precise date and time when the notification was created. Supports time-to-respond KPI calculation and audit trail.',
    `required_end_date` DATE COMMENT 'Target date by which the issue must be resolved to avoid production impact or regulatory non-compliance.',
    `required_start_date` DATE COMMENT 'Target date by which corrective action or work order execution should begin, based on priority and production schedule impact.',
    `safety_indicator` BOOLEAN COMMENT 'Flag indicating whether the notification involves a safety hazard, near-miss, or condition that could lead to injury or environmental release. Triggers Process Safety Management (PSM) review.',
    `short_description` STRING COMMENT 'Brief summary of the notification issue, typically 40-80 characters, used for list views and quick identification.',
    `work_order_created_date` DATE COMMENT 'Date when the work order was created in response to this notification. Used to calculate notification-to-work-order response time.',
    CONSTRAINT pk_notification PRIMARY KEY(`notification_id`)
) COMMENT 'Maintenance notification record capturing all unplanned maintenance demand including equipment defects, malfunctions, breakdowns, activity requests, and condition-based alerts raised by operators, inspectors, or automated monitoring systems. Tracks notification type (M1 malfunction/breakdown, M2 activity request, M3 inspection finding), breakdown indicator with start/end timestamps and duration, reported damage/cause/activity codes (via catalog_code reference), failure mode classification, production impact and loss quantity, safety implications, time to restore, and notification-to-work-order linkage. Serves as the SSOT for all failure events including full breakdowns — consolidating failure recording into a single entry point. Supports MTBF/MTTR calculation, reliability-centered maintenance (RCM) analysis, RCI/RCA investigations, CAPA workflows, PSM incident reporting, and Pareto analysis of failure modes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` (
    `pm_plan_id` BIGINT COMMENT 'Primary key for pm_plan',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Preventive maintenance plans are often part of a service contract with a specific customer account; needed for contract compliance dashboards.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: OEM service contracts and inspection service agreements in chemical manufacturing define PM schedules and obligations. Linking pm_plan to the governing supply contract enables contract compliance veri',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that bears the financial burden of maintenance activities generated by this plan. Used for maintenance cost allocation and budgeting.',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment master record (reactor, vessel, pump, compressor, heat exchanger, instrumentation) covered by this PM plan.',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location (plant area, process unit, production line) where the PM plan applies. Alternative to equipment_id for location-based maintenance.',
    `production_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the PM plan is executed. Supports multi-site maintenance management.',
    `task_list_id` BIGINT COMMENT 'Reference to the task list (general maintenance task list, equipment task list, functional location task list) defining the standardized work procedures, operations, materials, and labor for this PM plan.',
    `work_center_id` BIGINT COMMENT 'Reference to the maintenance work center (mechanical shop, electrical shop, instrumentation shop, contractor crew) responsible for executing the PM activities.',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Indicates whether the system automatically generates work orders when maintenance calls are created, or whether manual planner review and approval is required before work order creation.',
    `call_horizon_days` STRING COMMENT 'Number of days in advance that the system generates maintenance call objects (schedule lines) before the planned date. Enables proactive work order creation and resource planning.',
    `counter_reading_at_last_maintenance` DECIMAL(18,2) COMMENT 'Performance counter value (operating hours, production cycles, runtime hours) recorded at the time of last maintenance completion. Used for counter-based scheduling.',
    `counter_threshold_for_next_maintenance` DECIMAL(18,2) COMMENT 'Performance counter value that triggers the next maintenance call for counter-based plans (e.g., next PM at 10,000 operating hours).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the PM plan master record was first created in the system.',
    `cycle_length` DECIMAL(18,2) COMMENT 'Numeric value defining the interval between maintenance activities in the specified cycle_unit (e.g., 90 days, 500 operating hours, 1000 production cycles).',
    `cycle_unit` STRING COMMENT 'Unit of measure for the maintenance cycle interval: day, week, month, year (time-based), operating_hour, runtime_hour (performance-based), production_cycle, batch_count (counter-based). [ENUM-REF-CANDIDATE: day|week|month|year|operating_hour|production_cycle|batch_count|runtime_hour — 8 candidates stripped; promote to reference product]',
    `end_date` DATE COMMENT 'Effective end date when the PM plan expires and stops generating maintenance calls. Nullable for indefinite plans. Used for equipment decommissioning or plan retirement.',
    `inspection_code` STRING COMMENT 'Code identifying the regulatory inspection requirement driving this PM plan (API 510 pressure vessel inspection, API 570 piping inspection, API 653 tank inspection, ASME boiler inspection, PSM mechanical integrity inspection). Links to compliance frameworks.. Valid values are `^[A-Z0-9]{4,10}$`',
    `insurance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this PM plan is mandated by insurance carrier requirements for boilers, pressure vessels, or other insured equipment. Compliance affects insurance coverage.',
    `last_maintenance_date` DATE COMMENT 'Date when the last preventive maintenance activity was completed under this plan. Used to calculate the next scheduled maintenance date based on cycle length.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this PM plan require formal MOC approval per PSM regulations. True for safety-critical equipment and process safety-related maintenance.',
    `modified_by` STRING COMMENT 'User ID of the maintenance planner or engineer who last modified the PM plan master record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the PM plan master record was last modified in the system.',
    `next_scheduled_date` DATE COMMENT 'Calculated date for the next preventive maintenance activity based on cycle length, last maintenance date, and scheduling parameters. Drives work order generation.',
    `notes` STRING COMMENT 'Free-form notes capturing planner comments, historical context, lessons learned, or special considerations for plan execution. Supports knowledge retention.',
    `plan_number` STRING COMMENT 'Business identifier for the PM plan, externally visible and used in work order generation and scheduling communications.. Valid values are `^[A-Z0-9]{8,12}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the PM plan: active (generating calls), inactive (not generating calls), suspended (temporarily paused), completed (end date reached), cancelled (permanently terminated).. Valid values are `active|inactive|suspended|completed|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the PM plan structure: single_cycle (one maintenance cycle), strategy_plan (multiple cycles with different intervals), multiple_counter (based on operating hours or production volume), time_based (calendar-driven), performance_based (triggered by performance degradation), condition_based (triggered by sensor readings or inspection results).. Valid values are `single_cycle|strategy_plan|multiple_counter|time_based|performance_based|condition_based`',
    `pm_plan_description` STRING COMMENT 'Detailed textual description of the PM plan purpose, scope, and maintenance objectives. Includes equipment context, maintenance rationale, and special instructions.',
    `priority` STRING COMMENT 'Business priority level for maintenance activities generated by this plan. Critical for safety-critical equipment (PSM), high for production-critical assets, medium for supporting equipment, low for non-critical assets.. Valid values are `critical|high|medium|low`',
    `scheduling_indicator` STRING COMMENT 'Defines how the PM plan generates maintenance calls: time_based (calendar intervals), performance_based (operating hours, cycles, production volume), condition_based (sensor thresholds, inspection findings), fixed_date (specific calendar dates), annual (yearly recurrence), seasonal (tied to production seasons or weather).. Valid values are `time_based|performance_based|condition_based|fixed_date|annual|seasonal`',
    `scheduling_tolerance_after_days` STRING COMMENT 'Number of days after the planned date that maintenance can be performed without resetting the cycle counter. Provides flexibility for delayed execution.',
    `scheduling_tolerance_before_days` STRING COMMENT 'Number of days before the planned date that maintenance can be performed without resetting the cycle counter. Provides flexibility for early execution.',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Indicates whether the PM plan schedule is adjusted for seasonal production patterns (e.g., agricultural chemical production peaks, winter shutdown periods, summer turnaround windows).',
    `seasonal_adjustment_months` STRING COMMENT 'Comma-separated list of month numbers (1-12) when seasonal adjustments apply to the PM schedule. Used in conjunction with seasonal_adjustment_flag.',
    `start_date` DATE COMMENT 'Effective start date when the PM plan becomes active and begins generating maintenance calls. Aligns with equipment commissioning or plan activation.',
    `created_by` STRING COMMENT 'User ID of the maintenance planner or engineer who created the PM plan master record.',
    CONSTRAINT pk_pm_plan PRIMARY KEY(`pm_plan_id`)
) COMMENT 'Preventive maintenance plan master record defining the scheduling strategy, cycle packages, and parameters for time-based, counter-based, or condition-based PM activities on equipment or functional locations. Captures plan type (single cycle, strategy, multiple counter), strategy cycles and packages (e.g., 3M/6M/12M/5Y), scheduling indicator, call horizon, tolerance window, task list references for work content definition, cycle set definitions, and seasonal scheduling adjustments. Governs automated generation of schedule calls and resulting work orders. References task_list for standardized work procedures. Supports PSM mechanical integrity inspection programs, API/ASME code-required inspection intervals (API 510, 570, 653), RBI risk-based inspection optimization, and insurance carrier PM requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` (
    `schedule_call_id` BIGINT COMMENT 'Primary key for schedule_call',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment or functional location that this scheduled maintenance call is for (reactor, vessel, pump, instrumentation, etc.).',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Schedule call occurs at a plant; replace plant code string with FK.',
    `pm_plan_id` BIGINT COMMENT 'Reference to the parent preventive maintenance plan that generated this schedule call item.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: PM schedule calls requiring equipment shutdown must be coordinated with production schedule gaps. In chemical manufacturing, maintenance planners check production schedules before confirming schedule ',
    `task_list_id` BIGINT COMMENT 'Foreign key linking to maintenance.task_list. Business justification: A schedule_call is a generated maintenance call from a PM plan. The PM plan references a task_list (already linked via pm_plan.task_list_id). However, when a schedule_call is generated, it should dire',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (maintenance crew, technician group) assigned to execute this maintenance call.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order that was generated from this schedule call item to execute the maintenance activity.',
    `actual_completion_date` DATE COMMENT 'The actual date when the maintenance work was completed. Null if not yet completed.',
    `call_generation_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule call item was automatically generated by the maintenance planning system.',
    `call_horizon_days` STRING COMMENT 'Number of days in advance that this call was generated before the scheduled date, based on the maintenance plan call horizon configuration.',
    `call_number` STRING COMMENT 'Business identifier for the scheduled maintenance call, typically a sequential number within the maintenance plan.',
    `call_object_type` STRING COMMENT 'Type of technical object that this maintenance call is scheduled for.. Valid values are `equipment|functional_location|assembly|material`',
    `call_status` STRING COMMENT 'Current lifecycle status of the scheduled maintenance call item.. Valid values are `scheduled|released|completed|cancelled|overdue|in_progress`',
    `cancellation_reason` STRING COMMENT 'Reason code or description if this scheduled maintenance call was cancelled (equipment decommissioned, plan revised, consolidated with other work, etc.).',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance requirement that mandates this maintenance activity (PSM, EPA, OSHA, ISO certification, etc.).',
    `counter_reading_at_call` DECIMAL(18,2) COMMENT 'The equipment counter reading (operating hours, cycles, production volume) at the time this maintenance call was generated, for performance-based maintenance scheduling.',
    `counter_unit_of_measure` STRING COMMENT 'Unit of measure for the counter reading (hours, cycles, kilometers, batches, etc.).',
    `cycle_number` STRING COMMENT 'Sequential cycle number within the maintenance plan, indicating which iteration of the recurring maintenance this call represents.',
    `days_overdue` STRING COMMENT 'Number of days this maintenance call is overdue beyond the tolerance window. Null or zero if not overdue.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required to complete the scheduled maintenance activity.',
    `is_overdue` BOOLEAN COMMENT 'Boolean flag indicating whether this scheduled maintenance call is past its due date and tolerance window.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule call record was last updated (status change, date adjustment, work order assignment, etc.).',
    `maintenance_activity_type` STRING COMMENT 'Classification of the maintenance activity to be performed (inspection, lubrication, calibration, overhaul, cleaning, etc.).',
    `moc_reference_number` STRING COMMENT 'Reference number of the associated MOC workflow if this maintenance involves process equipment changes.',
    `moc_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a Management of Change workflow is required for this maintenance activity due to process equipment modifications.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this scheduled maintenance call, including special instructions, coordination requirements, or planning remarks.',
    `planned_completion_date` DATE COMMENT 'The planned date by which the maintenance work should be completed.',
    `planned_start_date` DATE COMMENT 'The planned start date for executing the maintenance work, may differ from scheduled date due to planning adjustments.',
    `priority` STRING COMMENT 'Priority level assigned to this scheduled maintenance call, indicating urgency and business criticality.. Valid values are `critical|high|medium|low`',
    `psm_critical_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this maintenance call is for PSM-critical equipment requiring mechanical integrity compliance per OSHA PSM regulations.',
    `scheduled_date` DATE COMMENT 'The date when this preventive maintenance call is scheduled to be performed, calculated from the maintenance plan cycle.',
    `shutdown_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether equipment or process shutdown is required to perform this maintenance activity.',
    `tolerance_days_early` STRING COMMENT 'Number of days before the scheduled date that the maintenance can be performed and still be considered on-time.',
    `tolerance_days_late` STRING COMMENT 'Number of days after the scheduled date that the maintenance can be performed before being considered overdue.',
    CONSTRAINT pk_schedule_call PRIMARY KEY(`schedule_call_id`)
) COMMENT 'Individual scheduled maintenance call item generated from a preventive maintenance plan, representing a specific due date and call object for a PM activity. Tracks call date, planned date, completion date, call status, counter reading at call, and the resulting work order reference. Aligns with SAP PM Maintenance Schedule (MPOS) and enables PM compliance tracking and overdue analysis.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` (
    `measurement_point_id` BIGINT COMMENT 'Unique identifier for the measurement point record. Primary key.',
    `emission_source_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_source. Business justification: Continuous emission monitoring systems (CEMS) and stack monitors are measurement points that directly correspond to permitted emission sources. Linking measurement_point to emission_source enables aut',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment or functional location on which this measurement point is defined. Links to the equipment master record.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: In SAP PM, measurement points are associated with both equipment and functional locations. A measurement point (e.g., a pressure tap, temperature sensor location) is physically situated at a functiona',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: measurement_point has a plant_code STRING attribute that stores the plant identifier as a denormalized string. The maintenance domain has a plant product with plant_id as PK. Adding plant_id FK to mea',
    `work_center_id` BIGINT COMMENT 'Reference to the maintenance work center responsible for monitoring and maintaining this measurement point. Links to work center master data.',
    `activation_date` DATE COMMENT 'Date when the measurement point was activated and monitoring began. Used for historical analysis and compliance documentation.',
    `calibration_frequency_days` STRING COMMENT 'Planned interval in days between calibration activities for this measurement point. Supports compliance with ISO 9001 and GMP requirements.',
    `calibration_required_flag` BOOLEAN COMMENT 'Indicates whether this measurement point requires periodic calibration to maintain accuracy and compliance with quality and safety standards.',
    `characteristic_code` STRING COMMENT 'Code identifying the physical characteristic being measured (e.g., vibration, temperature, pressure, flow rate, pH, operating hours). Aligns with plant instrumentation standards.',
    `characteristic_description` STRING COMMENT 'Human-readable description of the characteristic being measured at this point.',
    `counter_overflow_value` DECIMAL(18,2) COMMENT 'Maximum value at which a counter-type measurement point resets to zero. Used for cumulative counters such as operating hours or cycle counts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement point record was first created in the system. Audit trail field.',
    `criticality_code` STRING COMMENT 'Classification of the measurement points importance to safety, environmental compliance, product quality, or equipment reliability. Drives prioritization of monitoring and maintenance activities.. Valid values are `critical|high|medium|low`',
    `data_source` STRING COMMENT 'System or method by which measurement readings are captured: manual entry, Distributed Control System (DCS), Supervisory Control and Data Acquisition (SCADA), Laboratory Information Management System (LIMS), or process historian.. Valid values are `manual|dcs|scada|lims|historian`',
    `deactivation_date` DATE COMMENT 'Date when the measurement point was deactivated or decommissioned. Null for active measurement points.',
    `decimal_places` STRING COMMENT 'Number of decimal places to which measurement values should be recorded and displayed, ensuring precision consistency.',
    `historian_tag` STRING COMMENT 'Tag identifier in the process historian system (e.g., Aveva PI System) that stores time-series data for this measurement point. Enables integration with real-time process data.',
    `last_calibration_date` DATE COMMENT 'Date when the measurement point or associated instrument was last calibrated. Used to track calibration compliance and schedule next calibration.',
    `last_reading_date` DATE COMMENT 'Date when the most recent measurement reading was recorded for this point. Used to track compliance with reading schedules.',
    `last_reading_value` DECIMAL(18,2) COMMENT 'The most recent measurement value recorded at this point. Provides current state for condition monitoring and trend analysis.',
    `lower_alarm_limit` DECIMAL(18,2) COMMENT 'Lower critical threshold that triggers an alarm and may require immediate maintenance action or equipment shutdown per Process Safety Management (PSM) requirements.',
    `lower_warning_limit` DECIMAL(18,2) COMMENT 'Lower threshold value that triggers a warning alert when measurement falls below this level. Part of condition-based maintenance strategy.',
    `measurement_point_status` STRING COMMENT 'Current lifecycle status of the measurement point. Active points are monitored per schedule; inactive or decommissioned points are no longer in use.. Valid values are `active|inactive|suspended|decommissioned`',
    `measurement_position` STRING COMMENT 'Specific physical location or position on the equipment where the measurement is taken (e.g., bearing housing north side, inlet flange, discharge line). References Piping and Instrumentation Diagram (P&ID) tag.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether changes to this measurement point (limits, frequency, sensor type) require formal Management of Change (MOC) approval per PSM requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement point record was last modified. Audit trail field for change tracking.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration activity based on calibration frequency. Critical for maintaining measurement accuracy and regulatory compliance.',
    `next_reading_due_date` DATE COMMENT 'Scheduled date for the next measurement reading based on the reading frequency. Used for work order generation and compliance tracking.',
    `oee_relevant_flag` BOOLEAN COMMENT 'Indicates whether this measurement point contributes to Overall Equipment Effectiveness (OEE) calculations, such as operating hours, cycle counts, or production rates.',
    `point_category` STRING COMMENT 'Classification of the measurement point type: counter (cumulative readings such as operating hours) or measurement (instantaneous readings such as temperature or pressure).. Valid values are `counter|measurement`',
    `point_description` STRING COMMENT 'Detailed textual description of the measurement point, including its physical location on the equipment and what is being measured.',
    `point_number` STRING COMMENT 'Business identifier for the measurement point, typically alphanumeric code used in operations and maintenance documentation.',
    `psm_critical_flag` BOOLEAN COMMENT 'Indicates whether this measurement point is critical to Process Safety Management (PSM) mechanical integrity requirements and must be monitored per OSHA PSM regulations.',
    `reading_frequency_days` STRING COMMENT 'Planned interval in days between successive readings of this measurement point. Supports preventive and condition-based maintenance scheduling.',
    `sensor_type` STRING COMMENT 'Type of sensor or instrument used to capture the measurement (e.g., thermocouple, pressure transmitter, vibration sensor, flow meter, pH probe).',
    `tag_number` STRING COMMENT 'Unique tag identifier from the Piping and Instrumentation Diagram (P&ID) for the instrument or sensor associated with this measurement point. Aligns with ISA standards.',
    `target_value` DECIMAL(18,2) COMMENT 'The ideal or expected value for this measurement point under normal operating conditions. Used for variance analysis and condition monitoring.',
    `unit_of_measure` STRING COMMENT 'Unit in which the measurement is recorded (e.g., degC, bar, ppm, hours, rpm, m3/h). Must align with ISO and industry standards.',
    `upper_alarm_limit` DECIMAL(18,2) COMMENT 'Upper critical threshold that triggers an alarm and may require immediate maintenance action or equipment shutdown per Process Safety Management (PSM) requirements.',
    `upper_warning_limit` DECIMAL(18,2) COMMENT 'Upper threshold value that triggers a warning alert when measurement exceeds this level. Part of condition-based maintenance strategy.',
    CONSTRAINT pk_measurement_point PRIMARY KEY(`measurement_point_id`)
) COMMENT 'Measurement point master record defining a specific location on equipment where counter readings or measurement values are recorded (e.g., vibration, temperature, pressure, operating hours). Captures measurement point category, characteristic, unit of measure, target value, upper/lower limits, and counter overflow value. Aligns with SAP PM Measurement Point (MPLA/IMRG) and supports condition-based maintenance and OEE tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` (
    `measurement_reading_id` BIGINT COMMENT 'Unique identifier for the measurement reading record. Primary key for the measurement reading entity.',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment asset on which the measurement was taken. Links to equipment master data for reactors, vessels, pumps, instrumentation, and other process equipment.',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location in the plant hierarchy where the measurement was taken. Supports spatial organization of measurement data.',
    `measurement_point_id` BIGINT COMMENT 'Reference to the measurement point on the equipment where this reading was captured. Links to the measurement point master data defining the characteristic being measured.',
    `notification_id` BIGINT COMMENT 'Reference to the maintenance notification that was automatically generated when this reading violated threshold limits. Supports condition-based maintenance triggering.',
    `pm_plan_id` BIGINT COMMENT 'Reference to the preventive maintenance plan that scheduled this measurement reading. Links measurement data to planned maintenance strategies.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order that triggered or resulted from this measurement reading. Links measurement data to maintenance execution.',
    `annotation` STRING COMMENT 'Free-text notes or comments entered by the reader or reviewer regarding the measurement reading. Used to document unusual conditions, context, or corrective actions taken.',
    `approved_by` STRING COMMENT 'Identifier of the person who approved or validated this measurement reading. Used for quality assurance and compliance documentation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement reading was approved or validated. Supports audit trail and regulatory compliance requirements.',
    `calibration_due_date` DATE COMMENT 'The date when the measurement instrument or sensor is next due for calibration. Used to assess the reliability of the reading and trigger calibration work orders.',
    `counter_overflow_flag` BOOLEAN COMMENT 'Boolean indicator that is true when a counter reading has rolled over or reset. Used to maintain accurate cumulative totals across counter resets.',
    `counter_reading_flag` BOOLEAN COMMENT 'Boolean indicator that is true when this reading represents a cumulative counter value (such as operating hours, cycle count, production volume) rather than an instantaneous measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement reading record was first created in the system. Represents the system capture time, which may differ from the actual reading timestamp.',
    `data_source` STRING COMMENT 'The system or method from which the measurement reading originated. Identifies whether the reading came from SCADA, DCS, Aveva PI System, LIMS, manual field entry, mobile application, or sensor network. [ENUM-REF-CANDIDATE: SCADA|DCS|PI_System|LIMS|Manual_Entry|Mobile_App|Sensor_Network — 7 candidates stripped; promote to reference product]',
    `deviation_from_target` DECIMAL(18,2) COMMENT 'The calculated difference between the measured value and the target value. Positive values indicate readings above target, negative values indicate readings below target. Used for trend analysis and condition monitoring.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'The percentage deviation of the measured value from the target value. Calculated as (measured_value - target_value) / target_value * 100. Enables normalized comparison across different measurement points.',
    `last_calibration_date` DATE COMMENT 'The date when the measurement instrument or sensor was last calibrated. Provides context for reading accuracy and quality assurance.',
    `lower_alarm_limit` DECIMAL(18,2) COMMENT 'The lower critical threshold value that triggers an alarm when the measured value falls below this limit. Indicates a serious condition requiring immediate attention.',
    `lower_warning_limit` DECIMAL(18,2) COMMENT 'The lower threshold value that triggers a warning alert when the measured value falls below this limit. Part of condition monitoring and predictive maintenance logic.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual numeric value captured by the measurement reading. Represents the observed quantity such as temperature, pressure, flow rate, vibration, pH, or counter reading.',
    `measurement_characteristic` STRING COMMENT 'The physical or operational characteristic being measured. Examples include temperature, pressure, vibration, flow rate, pH, conductivity, viscosity, level, speed, power consumption.',
    `measurement_document_number` STRING COMMENT 'External business identifier for the measurement document. Used for traceability and cross-system reference.. Valid values are `^[A-Z0-9]{10}$`',
    `measurement_position` STRING COMMENT 'The specific position or location on the equipment where the measurement was taken. Examples include inlet, outlet, bearing housing, motor winding, seal area, valve stem.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this measurement reading record was last modified. Used for audit trail and data quality tracking.',
    `pi_tag_name` STRING COMMENT 'The Aveva PI System tag name associated with this measurement reading. Enables integration and traceability between the maintenance system and the real-time process historian.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility where the measurement reading was captured. Supports multi-site maintenance operations and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_code` STRING COMMENT 'Data quality indicator for the measurement reading. Good indicates reliable data, bad indicates known error, uncertain indicates possible error, substituted indicates estimated value, questionable indicates requires review.. Valid values are `good|bad|uncertain|substituted|questionable`',
    `reading_date` DATE COMMENT 'Calendar date when the measurement reading was taken. Used for day-level aggregation and reporting.',
    `reading_status` STRING COMMENT 'Current validation status of the measurement reading. Indicates whether the reading has been reviewed, approved, or flagged for quality issues.. Valid values are `valid|invalid|suspect|pending_review|approved|rejected`',
    `reading_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement reading was actually captured in the field or by the sensor. Represents the real-world event time of the observation.',
    `reading_type` STRING COMMENT 'Classification of how the reading was obtained. Actual indicates direct measurement, estimated indicates interpolated or approximated value, calculated indicates derived from other readings, manual indicates human-entered, automatic indicates sensor-captured.. Valid values are `actual|estimated|calculated|manual|automatic`',
    `target_value` DECIMAL(18,2) COMMENT 'The expected or target value for this measurement point. Used to calculate deviation and trigger alerts when actual readings fall outside acceptable range.',
    `threshold_violation_flag` BOOLEAN COMMENT 'Boolean indicator that is true when the measured value falls outside the defined warning or alarm limits. Used to trigger maintenance notifications and condition-based maintenance workflows.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed. Examples include PSI (pressure), DEG_C (temperature), GPM (flow), HZ (frequency), PPM (concentration), PH (acidity).. Valid values are `^[A-Z]{1,3}$`',
    `upper_alarm_limit` DECIMAL(18,2) COMMENT 'The upper critical threshold value that triggers an alarm when the measured value exceeds this limit. Indicates a serious condition requiring immediate attention.',
    `upper_warning_limit` DECIMAL(18,2) COMMENT 'The upper threshold value that triggers a warning alert when the measured value exceeds this limit. Part of condition monitoring and predictive maintenance logic.',
    CONSTRAINT pk_measurement_reading PRIMARY KEY(`measurement_reading_id`)
) COMMENT 'Individual measurement document recording an actual counter or measurement value captured at a measurement point on equipment. Tracks reading date and time, measured value, unit, reading type (actual, estimated), reader identification, and deviation from target. Aligns with SAP PM Measurement Document (IMRG) and supports condition monitoring, predictive maintenance triggers, and Aveva PI System integration.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` (
    `calibration_record_id` BIGINT COMMENT 'Unique identifier for the calibration record. Primary key for the calibration record entity.',
    `calibration_procedure_id` BIGINT COMMENT 'Reference to the Standard Operating Procedure (SOP) or work instruction used for this calibration. Links to documented calibration method.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Calibration activities incur costs that must be posted to the responsible cost center for compliance and cost recovery.',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment or instrument being calibrated (transmitters, analyzers, gauges, safety valves, laboratory instruments).',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location where the calibrated equipment is installed.',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Calibration record is linked to a plant for traceability; replace plant code with FK.',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to maintenance.measurement_point. Business justification: A calibration record documents the calibration of an instrument or measurement device. In chemical plant operations, calibration is performed on specific measurement points (transmitters, analyzers, g',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Operating permits for chemical facilities mandate calibration of specific monitoring instruments (CEMS, flow meters, analyzers) at defined intervals. Linking calibration records to the governing opera',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: External calibration services are procured via PO. GMP and PSM regulations require three-way match (PO/service entry/calibration certificate) for regulated instruments. calibration_record has vendor_i',
    `vendor_id` BIGINT COMMENT 'Reference to external calibration service provider or laboratory, if calibration was performed by third party.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: GMP/PSM regulations require calibration certificates to identify the specific accredited laboratory site (not just the vendor company). vendor_lab_accreditation is a plain attribute; a proper FK to ve',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order under which this calibration was performed, linking calibration to preventive maintenance schedule.',
    `accuracy_specification` STRING COMMENT 'Manufacturer or regulatory accuracy requirement for the instrument (e.g., ±0.5%, ±2 degC). Used to determine tolerance limits.',
    `adjustment_performed_flag` BOOLEAN COMMENT 'Indicates whether the instrument required adjustment or recalibration to bring it within tolerance.',
    `as_found_value` DECIMAL(18,2) COMMENT 'Measured value of the instrument before calibration adjustment. Documents initial condition and drift since last calibration.',
    `as_left_value` DECIMAL(18,2) COMMENT 'Measured value of the instrument after calibration adjustment. Documents final calibrated state.',
    `calibration_certificate_number` STRING COMMENT 'Unique certificate number issued for this calibration event. External business identifier for traceability and audit purposes.',
    `calibration_cost` DECIMAL(18,2) COMMENT 'Total cost of calibration activity including labor, materials, and external service fees. Supports maintenance budget tracking.',
    `calibration_date` DATE COMMENT 'Date when the calibration was performed. Principal business event timestamp for this calibration record.',
    `calibration_due_date` DATE COMMENT 'Next scheduled calibration date based on calibration interval. Used for preventive maintenance scheduling and compliance tracking.',
    `calibration_interval_days` STRING COMMENT 'Standard calibration frequency in days (e.g., 365 for annual, 180 for semi-annual). Determines next due date calculation.',
    `calibration_points_tested` STRING COMMENT 'Number of measurement points tested during calibration (e.g., 5-point calibration across instrument range).',
    `calibration_standard_certificate_number` STRING COMMENT 'Certificate number of the reference standard used, providing traceability to NIST or equivalent national metrology institute.',
    `calibration_status` STRING COMMENT 'Current lifecycle status of the calibration record: scheduled (planned but not started), in-progress (calibration underway), passed (within tolerance), failed (out of tolerance), conditional (marginal pass with restrictions), cancelled (calibration not performed), overdue (past due date). [ENUM-REF-CANDIDATE: scheduled|in-progress|passed|failed|conditional|cancelled|overdue — 7 candidates stripped; promote to reference product]',
    `calibration_type` STRING COMMENT 'Classification of calibration method: in-house (performed by internal technicians), external (third-party calibration lab), vendor (OEM calibration service), field (on-site calibration), laboratory (off-site lab calibration).. Valid values are `in-house|external|vendor|field|laboratory`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this calibration record was first created in the system. Audit trail for record lifecycle.',
    `environmental_humidity` DECIMAL(18,2) COMMENT 'Relative humidity percentage during calibration. Environmental condition documentation required for measurement traceability.',
    `environmental_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature during calibration in degrees Celsius. Environmental condition documentation required for measurement traceability.',
    `gmp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this calibration is subject to Good Manufacturing Practice (GMP) requirements for pharmaceutical or food-contact chemical production.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this calibration record was last updated. Audit trail for record lifecycle and change tracking.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Quantified uncertainty of the calibration measurement, expressed in the same unit as the measured value. Required for ISO 17025 compliance.',
    `out_of_tolerance_flag` BOOLEAN COMMENT 'Indicates whether the as-found condition was outside acceptable tolerance limits, triggering investigation and potential product impact assessment.',
    `pass_fail_status` STRING COMMENT 'Calibration result: pass (within tolerance), fail (out of tolerance), conditional (marginal but acceptable with restrictions).. Valid values are `pass|fail|conditional`',
    `psm_critical_instrument_flag` BOOLEAN COMMENT 'Indicates whether this instrument is designated as PSM-critical under OSHA 1910.119 mechanical integrity requirements, requiring enhanced calibration documentation and frequency.',
    `remarks` STRING COMMENT 'Free-text notes documenting calibration observations, issues encountered, corrective actions taken, or special conditions. Supports root cause investigation and continuous improvement.',
    `review_date` DATE COMMENT 'Date when the calibration record was reviewed and approved by quality assurance.',
    `target_value` DECIMAL(18,2) COMMENT 'Expected or nominal value for the calibration point. Reference setpoint for comparison.',
    `technician_certification_number` STRING COMMENT 'Certification or qualification number of the technician performing calibration, demonstrating competency for this calibration type.',
    `tolerance_lower_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for calibration pass criteria. Defines lower bound of acceptable measurement range.',
    `tolerance_upper_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for calibration pass criteria. Defines upper bound of acceptable measurement range.',
    `unit_of_measure` STRING COMMENT 'Engineering unit for calibration values (e.g., PSI, bar, degC, degF, pH, mA, mV, GPM, kg/h). Applies to as-found, as-left, target, and tolerance values.',
    `vendor_lab_accreditation` STRING COMMENT 'Accreditation body and certificate number for external calibration laboratory (e.g., A2LA, ANAB, UKAS). Ensures vendor competency.',
    CONSTRAINT pk_calibration_record PRIMARY KEY(`calibration_record_id`)
) COMMENT 'Calibration record for instrumentation and measurement devices (transmitters, analyzers, gauges, safety valves) documenting as-found and as-left conditions, calibration procedure, tolerance limits, pass/fail status, calibration interval, and next due date. Supports PSM mechanical integrity requirements, ISO 9001 instrument calibration compliance, and LIMS integration for laboratory instrument calibration.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` (
    `breakdown_event_id` BIGINT COMMENT 'Unique identifier for the breakdown event record. Primary key for the breakdown event entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Breakdown events incur repair and downtime costs; assigning a cost center is required for loss analysis and financial impact reporting.',
    `emission_event_id` BIGINT COMMENT 'Foreign key linking to ehs.emission_event. Business justification: Equipment breakdowns in chemical manufacturing frequently cause unplanned emission events (e.g., seal failure causing fugitive release). Linking breakdown_event to emission_event supports environmenta',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment asset that experienced the breakdown failure.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Breakdown events in chemical plants directly trigger fixed asset impairment assessments (IAS 36) and insurance claims. Finance requires breakdown events linked to fixed assets to evaluate asset write-',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location where the breakdown occurred within the plant hierarchy.',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Breakdown event occurs at a plant; replace plant code with FK.',
    `notification_id` BIGINT COMMENT 'Reference to the PM notification that reported this breakdown event. Links to the maintenance notification system.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Breakdown events cause production plan deviations requiring replanning. Planners need to link breakdown events to affected production plans for production impact assessment, regulatory reporting (PSM)',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Breakdown events directly disrupt specific production schedule slots. affected_production_unit is a denormalized plain-text reference to the production schedule context. Linking to production_schedule',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Breakdown events trigger emergency procurement (spare parts, external repair services) in chemical plants. Linking breakdown_event to the resulting emergency PO enables breakdown-to-spend analysis, em',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective work order created to address this breakdown event.',
    `breakdown_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from breakdown start to restoration. Used for Mean Time To Repair (MTTR) calculation and downtime analysis.',
    `breakdown_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the equipment was restored to operational status following the breakdown event.',
    `breakdown_number` STRING COMMENT 'Business identifier for the breakdown event, typically auto-generated or manually assigned for tracking and reporting purposes.',
    `breakdown_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the equipment breakdown or failure was first detected or occurred. Critical for MTBF and MTTR calculations.',
    `breakdown_status` STRING COMMENT 'Current lifecycle status of the breakdown event indicating progression from detection through resolution.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the breakdown event record was first created in the maintenance management system.',
    `damage_code` STRING COMMENT 'Standardized code classifying the type of damage observed on the equipment, such as crack, deformation, erosion, or contamination.',
    `detection_method` STRING COMMENT 'Method by which the breakdown event was first detected, such as operator observation, automated alarm, scheduled inspection, or predictive analytics.. Valid values are `operator_observation|alarm|inspection|predictive_maintenance|condition_monitoring|customer_complaint`',
    `ehs_incident_number` STRING COMMENT 'Reference number of the associated EHS incident report if the breakdown event had safety or environmental implications.',
    `environmental_release_flag` BOOLEAN COMMENT 'Indicator of whether the breakdown event resulted in an unplanned release of chemicals or hazardous materials to the environment.',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Estimated total cost to repair or restore the equipment following the breakdown event, including labor, materials, and contractor costs.',
    `failure_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the breakdown, such as wear, corrosion, operator error, design defect, or inadequate maintenance.',
    `failure_cause_description` STRING COMMENT 'Detailed narrative explanation of the root cause analysis findings for the breakdown event. Supports RCI (Root Cause Investigation) documentation.',
    `failure_mode` STRING COMMENT 'Description of how the equipment failed, such as mechanical fracture, electrical short, seal leak, bearing seizure, or control system fault. Supports failure mode and effects analysis (FMEA).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the breakdown event record was last updated or modified.',
    `long_description` STRING COMMENT 'Detailed narrative description of the breakdown event, including symptoms, observations, and contextual information.',
    `malfunction_start_indicator` BOOLEAN COMMENT 'Flag indicating whether this breakdown event marks the initial onset of a malfunction or is a continuation of a previous issue.',
    `moc_number` STRING COMMENT 'Reference number of the MOC workflow initiated to implement corrective actions for this breakdown event.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicator of whether corrective actions for this breakdown require a formal Management of Change process due to process safety implications.',
    `priority_code` STRING COMMENT 'Priority classification for the breakdown event response, determining urgency of corrective action and resource allocation.. Valid values are `emergency|urgent|high|medium|low`',
    `production_impact_severity` STRING COMMENT 'Categorical assessment of the severity of production impact caused by the breakdown, ranging from critical plant shutdown to minimal disruption.. Valid values are `critical|high|medium|low|none`',
    `production_loss_quantity` DECIMAL(18,2) COMMENT 'Quantified amount of production output lost due to the breakdown event, measured in the unit of measure specified.',
    `production_loss_uom` STRING COMMENT 'Unit of measure for the production loss quantity, such as kilograms, liters, tons, or batch count.',
    `psm_critical_flag` BOOLEAN COMMENT 'Indicator of whether the breakdown event involved PSM-covered equipment requiring mechanical integrity documentation and regulatory reporting.',
    `rci_number` STRING COMMENT 'Reference number of the formal root cause investigation conducted for this breakdown event.',
    `rci_required_flag` BOOLEAN COMMENT 'Indicator of whether the breakdown event severity or recurrence pattern requires a formal root cause investigation.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the breakdown event was formally reported into the maintenance management system.',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Elapsed time in hours from breakdown detection to initiation of corrective action. Key metric for maintenance responsiveness.',
    `restoration_method` STRING COMMENT 'Method used to restore equipment to operational status, such as on-site repair, component replacement, temporary fix, or operational workaround.. Valid values are `repair|replacement|temporary_fix|workaround|adjustment`',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicator of whether the breakdown event resulted in or was associated with a safety incident requiring EHS reporting.',
    `short_description` STRING COMMENT 'Brief summary description of the breakdown event for quick identification and reporting purposes.',
    CONSTRAINT pk_breakdown_event PRIMARY KEY(`breakdown_event_id`)
) COMMENT 'Unplanned equipment breakdown or failure event record capturing the onset of failure, failure mode, failure cause, affected production unit, production loss quantity, safety implications, and time to restore. Tracks breakdown start and end timestamps, breakdown duration, malfunction start indicator, and linkage to corrective work order and PM notification. Supports MTBF/MTTR calculation, RCI investigations, and PSM incident reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` (
    `permit_to_work_id` BIGINT COMMENT 'Unique identifier for the permit to work record. Primary key for the permit to work entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Permit issuance often includes fees and resource allocation; linking to cost center supports permit cost accounting and audit trails.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or asset on which the permitted work will be performed.',
    `functional_location_id` BIGINT COMMENT 'Reference to the functional location where the permitted work will be performed. Identifies the specific plant area or process unit.',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: High-hazard maintenance work (confined space entry, hot work near flammables) in PSM facilities must reference the governing HAZOP study to ensure identified hazard controls are applied during the job',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Permit to work is issued for a specific plant; replace plant code with FK.',
    `notification_id` BIGINT COMMENT 'Foreign key linking to maintenance.notification. Business justification: A Permit to Work (PTW) in chemical plant operations is typically issued in response to a maintenance notification that identified the need for hazardous work. permit_to_work already links to work_orde',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: PTW issuance requires verification that the target equipment is not actively scheduled for production. In chemical manufacturing, PTW systems are integrated with production scheduling — a PTW cannot b',
    `sds_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.sds_record. Business justification: OSHA PSM (29 CFR 1910.119) and COSHH require that Permits to Work for maintenance on chemical-handling equipment reference the current SDS of the hazardous chemical involved. PTW issuers must confirm ',
    `work_center_id` BIGINT COMMENT 'Reference to the maintenance work center responsible for executing the permitted work.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order that this permit authorizes. Links permit to the underlying maintenance activity.',
    `cancellation_reason` STRING COMMENT 'Explanation if the permit was cancelled before work completion. Includes reason code and detailed justification.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was formally closed after work completion and area inspection confirmed safe conditions restored.',
    `closure_confirmation` STRING COMMENT 'Documentation confirming that all work is complete, all tools and materials removed, all isolations restored, area cleaned, and safe conditions verified before permit closure.',
    `confined_space_entry_flag` BOOLEAN COMMENT 'Indicates whether the work involves entry into a permit-required confined space as defined by OSHA 1910.146. Triggers additional safety requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was first created in the system.',
    `fire_watch_required_flag` BOOLEAN COMMENT 'Indicates whether a dedicated fire watch person must be present during hot work operations to monitor for ignition and respond to fire emergencies.',
    `gas_test_required_flag` BOOLEAN COMMENT 'Indicates whether atmospheric testing for oxygen, flammable gases, and toxic gases is required before and during the work.',
    `gas_test_results` STRING COMMENT 'Results of atmospheric testing including oxygen percentage, lower explosive limit (LEL) readings, and toxic gas concentrations. Recorded before work begins and at specified intervals.',
    `hazard_identification` STRING COMMENT 'Comprehensive identification of all hazards present in the work area including chemical, physical, biological, and process hazards. Critical for risk assessment and control measures.',
    `isolation_requirements` STRING COMMENT 'Specific isolation and lockout/tagout requirements for the work including electrical isolation, mechanical isolation, line blanking, and energy isolation procedures.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was officially issued and approved by the issuing authority.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the permit record was last updated in the system.',
    `lel_percent` DECIMAL(18,2) COMMENT 'Measured flammable gas concentration as percentage of lower explosive limit. Must be below threshold (typically <10% LEL) for hot work authorization.',
    `moc_reference_number` STRING COMMENT 'Reference number of the associated Management of Change document if MOC review was required for this work.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether the work requires a Management of Change review because it involves modifications to process equipment, procedures, or chemicals.',
    `oxygen_level_percent` DECIMAL(18,2) COMMENT 'Measured oxygen concentration in the work area atmosphere expressed as percentage. Must be within safe range (typically 19.5% to 23.5%) for entry.',
    `permit_number` STRING COMMENT 'Externally-known unique permit number assigned to this work authorization. Used for tracking and reference in safety documentation.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit to work. Tracks the permit from initial request through closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on the nature of hazardous work being authorized. Determines specific safety protocols and approval requirements.. Valid values are `hot_work|confined_space_entry|electrical_isolation|line_breaking|excavation|height_work`',
    `ppe_requirements` STRING COMMENT 'Mandatory personal protective equipment required for the permitted work including respirators, protective clothing, gloves, eye protection, and fall protection.',
    `priority_code` STRING COMMENT 'Priority level of the permitted work indicating urgency and scheduling precedence.. Valid values are `emergency|urgent|high|medium|low`',
    `psm_critical_flag` BOOLEAN COMMENT 'Indicates whether the work is on PSM-covered equipment or processes that contain highly hazardous chemicals above threshold quantities.',
    `rescue_plan` STRING COMMENT 'Documented rescue and emergency response plan for confined space entry or other high-risk work. Includes rescue equipment, procedures, and emergency contacts.',
    `shutdown_required_flag` BOOLEAN COMMENT 'Indicates whether the work requires a process unit shutdown or can be performed during normal operations.',
    `special_precautions` STRING COMMENT 'Additional safety precautions, restrictions, or conditions specific to this permit beyond standard requirements. May include weather restrictions, simultaneous operations restrictions, or special monitoring requirements.',
    `toxic_gas_ppm` DECIMAL(18,2) COMMENT 'Measured concentration of toxic gases in parts per million. Must be below permissible exposure limits for the specific chemicals present.',
    `valid_from_timestamp` TIMESTAMP COMMENT 'Date and time when the permit becomes effective and work is authorized to begin. Marks the start of the permits validity period.',
    `valid_until_timestamp` TIMESTAMP COMMENT 'Date and time when the permit expires and work must cease. Permits typically have limited duration (e.g., 8 hours, 12 hours, or one shift) and must be renewed if work continues.',
    `work_description` STRING COMMENT 'Detailed description of the maintenance or construction activity to be performed under this permit. Includes scope, methods, and expected outcomes.',
    CONSTRAINT pk_permit_to_work PRIMARY KEY(`permit_to_work_id`)
) COMMENT 'Permit to Work (PTW) record authorizing maintenance and construction activities in hazardous areas of a chemical plant. Captures permit type (hot work, confined space entry, electrical isolation, line breaking, excavation), issuing authority, work description, hazard identification, isolation requirements, PPE requirements, gas test results, validity period, and closure confirmation. Supports OSHA PSM, EHS compliance, and safe work practices.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` (
    `task_list_id` BIGINT COMMENT 'Unique surrogate key for each maintenance task list template.',
    `predecessor_task_list_id` BIGINT COMMENT 'Self-referencing FK on task_list (predecessor_task_list_id)',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the task list revision.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the task list revision was approved.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for cost estimates.. Valid values are `^[A-Z]{3}$`',
    `craft_skill_required` STRING COMMENT 'Skill or qualification code required for personnel performing the operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the task list record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date after which the task list is no longer valid (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the task list is valid for use.',
    `equipment_classification` STRING COMMENT 'Classification of equipment for which the task list is applicable (e.g., reactor, pump).',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Monetary estimate of labor cost for the task list.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours estimated for the entire task list.',
    `functional_location_code` STRING COMMENT 'Code of the functional location scope when type is functional_location.',
    `is_template` BOOLEAN COMMENT 'True if the record represents a reusable template (always true for task_list).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the task list record.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent work order generation from this task list.',
    `lockout_tagout_required` BOOLEAN COMMENT 'Indicates whether lockout/tagout procedures are mandatory for the operation.',
    `material_requirements` STRING COMMENT 'List of materials and quantities needed for the operation.',
    `moc_reference_number` STRING COMMENT 'Identifier of the associated MOC document, if applicable.',
    `moc_required_flag` BOOLEAN COMMENT 'Indicates whether a Management of Change (MOC) must be completed before execution.',
    `operation_description` STRING COMMENT 'Detailed description of the work to be performed in this step.',
    `operation_step_number` STRING COMMENT 'Sequential number of the operation within the task list.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Estimated labor time required for the operation.',
    `planned_hours_unit` STRING COMMENT 'Unit of measure for planned hours.. Valid values are `hour|minute`',
    `priority_code` STRING COMMENT 'Business priority assigned to the task list for planning purposes.. Valid values are `high|medium|low`',
    `psm_critical_flag` BOOLEAN COMMENT 'True if the task list is subject to PSM mechanical integrity requirements.',
    `regulatory_requirement_code` STRING COMMENT 'Code referencing applicable regulatory or compliance requirement (e.g., OSHA, EPA).',
    `revision_date` DATE COMMENT 'Date when the current revision was released.',
    `revision_number` STRING COMMENT 'Sequential revision number for change control.',
    `safety_precautions` STRING COMMENT 'Safety instructions, PPE, and lockout/tagout notes for the operation.',
    `task_category` STRING COMMENT 'High‑level category of maintenance activity the task list supports.. Valid values are `preventive|corrective|inspection|calibration`',
    `task_list_code` STRING COMMENT 'Business identifier or code (e.g., PLKO) used in SAP PM to reference the task list.',
    `task_list_description` STRING COMMENT 'Detailed free‑text description of the purpose and scope of the task list.',
    `task_list_name` STRING COMMENT 'Human‑readable name of the task list used by planners and technicians.',
    `task_list_status` STRING COMMENT 'Current lifecycle status of the task list.. Valid values are `active|inactive|draft|retired`',
    `task_list_type` STRING COMMENT 'Classification of the task list: equipment‑specific, functional‑location‑specific, or general.. Valid values are `equipment|functional_location|general`',
    `tool_requirements` STRING COMMENT 'List of tools or equipment required to complete the operation.',
    `usage_count` BIGINT COMMENT 'Number of times the task list has been used to generate work orders.',
    `version_number` STRING COMMENT 'Incremental version number for change management.',
    `work_center_code` STRING COMMENT 'Identifier of the work center responsible for executing the operation.',
    CONSTRAINT pk_task_list PRIMARY KEY(`task_list_id`)
) COMMENT 'Reusable maintenance task list (job plan/procedure template) defining standardized sequences of operations, required materials, tools, safety precautions, and estimated labor for recurring maintenance activities. Serves as the master template from which work order operations are generated, ensuring consistent execution quality across crews and shifts. Captures task list type (equipment-specific, functional-location-specific, general), group/counter structure, operation steps with detailed descriptions, work center assignments, planned hours per operation, required craft qualifications, material/tool requirements with quantities, and safety/lockout-tagout instructions. Referenced by pm_plan for automated work order generation. Aligns with SAP PM Task List (IA01-IA03/PLKO) and supports PSM mechanical integrity procedure documentation, OSHA-required safe work procedures, craft standardization, and audit-ready maintenance procedure records.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_procedure` (
    `calibration_procedure_id` BIGINT COMMENT 'Primary key for calibration_procedure',
    `superseded_calibration_procedure_id` BIGINT COMMENT 'Self-referencing FK on calibration_procedure (superseded_calibration_procedure_id)',
    `approval_status` STRING COMMENT 'Current approval state of the procedure definition.',
    `calibration_certificate_expiry` DATE COMMENT 'Expiration date of the calibration certificate.',
    `calibration_certificate_number` STRING COMMENT 'Identifier of the certificate issued after successful calibration.',
    `calibration_interval_days` STRING COMMENT 'Standard interval, in days, between required calibrations for equipment using this procedure.',
    `calibration_location` STRING COMMENT 'Physical location or facility where the calibration is performed.',
    `calibration_procedure_description` STRING COMMENT 'Detailed textual description of the calibration procedure.',
    `calibration_procedure_status` STRING COMMENT 'Current lifecycle status of the calibration procedure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration procedure record was created.',
    `document_reference` STRING COMMENT 'Reference to supporting documentation or SOP for the procedure.',
    `effective_from` DATE COMMENT 'Date when the calibration procedure becomes effective.',
    `effective_until` DATE COMMENT 'Date when the calibration procedure expires or is superseded (null if open‑ended).',
    `equipment_category` STRING COMMENT 'Category of equipment to which the procedure applies.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the procedure is mandatory for the equipment class.',
    `last_calibrated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent calibration performed using this procedure.',
    `measurement_unit` STRING COMMENT 'Unit of measurement for the primary calibration value.',
    `method` STRING COMMENT 'Technique used to perform the calibration.',
    `next_due_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next required calibration.',
    `procedure_code` STRING COMMENT 'Unique business code used to reference the calibration procedure.',
    `procedure_name` STRING COMMENT 'Human‑readable name of the calibration procedure.',
    `procedure_type` STRING COMMENT 'Category of measurement the procedure addresses.',
    `regulatory_standard` STRING COMMENT 'Regulatory framework that mandates the calibration procedure.',
    `required_by_regulation` BOOLEAN COMMENT 'Indicates whether the procedure is mandated by regulatory standards.',
    `tolerance_unit` STRING COMMENT 'Unit for the tolerance value.',
    `tolerance_value` DECIMAL(18,2) COMMENT 'Maximum allowable deviation from the target value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calibration procedure record.',
    `version` STRING COMMENT 'Version identifier for the procedure definition.',
    CONSTRAINT pk_calibration_procedure PRIMARY KEY(`calibration_procedure_id`)
) COMMENT 'Master reference table for calibration_procedure. Referenced by calibration_procedure_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` (
    `maintenance_plant_id` BIGINT COMMENT 'Primary key for plant',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each chemical manufacturing plant belongs to a legal entity for statutory financial reporting, tax compliance, environmental permit registration, and intercompany cost allocation. Maintenance plant ma',
    `address_line1` STRING COMMENT 'Primary street address of the plant.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `area_sq_m` DECIMAL(18,2) COMMENT 'Total built‑up area of the plant in square metres.',
    `capacity_tons_per_year` DECIMAL(18,2) COMMENT 'Maximum amount of product the plant can produce in a year.',
    `city` STRING COMMENT 'City where the plant is located.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier for budgeting and charge‑back.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plant record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the plant was or will be retired from service (nullable).',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency contact for the plant.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.',
    `environmental_permit_number` STRING COMMENT 'Identifier of the primary environmental compliance permit.',
    `establishment_date` DATE COMMENT 'Date the plant began operations.',
    `is_certified_iso14001` BOOLEAN COMMENT 'Indicates ISO 14001 environmental management certification status.',
    `is_certified_iso9001` BOOLEAN COMMENT 'Indicates whether the plant holds ISO 9001 quality certification.',
    `is_certified_ohsas18001` BOOLEAN COMMENT 'Indicates whether the plant is certified to OHSAS 18001 occupational health and safety standard.',
    `last_inspection_date` DATE COMMENT 'Most recent date a safety or regulatory inspection was performed.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the plant in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the plant in decimal degrees.',
    `maintenance_strategy` STRING COMMENT 'Approach used for maintaining plant equipment.',
    `manager_email` STRING COMMENT 'Email address of the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the plant manager.',
    `manager_phone` STRING COMMENT 'Contact phone number of the plant manager.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average operating time between equipment failures.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair equipment after a failure.',
    `number_of_employees` STRING COMMENT 'Total staff employed at the plant.',
    `number_of_units` STRING COMMENT 'Count of major equipment units (reactors, vessels, etc.) at the plant.',
    `operating_company` STRING COMMENT 'Legal entity that owns or operates the plant.',
    `plant_code` STRING COMMENT 'External business code or short identifier assigned to the plant.',
    `plant_description` STRING COMMENT 'Free‑form textual description of the plant, its purpose, and notable characteristics.',
    `plant_name` STRING COMMENT 'Human‑readable name of the plant used in reports and UI.',
    `plant_status` STRING COMMENT 'Current lifecycle status of the plant.',
    `plant_type` STRING COMMENT 'Category of the plant based on its primary function.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the plant address.',
    `regulatory_compliance_status` STRING COMMENT 'Current status of the plants regulatory compliance.',
    `safety_rating` STRING COMMENT 'Overall safety performance rating of the plant.',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plant record.',
    CONSTRAINT pk_maintenance_plant PRIMARY KEY(`maintenance_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ADD CONSTRAINT `fk_maintenance_equipment_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_task_list_id` FOREIGN KEY (`task_list_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`task_list`(`task_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ADD CONSTRAINT `fk_maintenance_work_order_operation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ADD CONSTRAINT `fk_maintenance_notification_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ADD CONSTRAINT `fk_maintenance_pm_plan_task_list_id` FOREIGN KEY (`task_list_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`task_list`(`task_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_task_list_id` FOREIGN KEY (`task_list_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`task_list`(`task_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ADD CONSTRAINT `fk_maintenance_schedule_call_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ADD CONSTRAINT `fk_maintenance_measurement_point_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_pm_plan_id` FOREIGN KEY (`pm_plan_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`pm_plan`(`pm_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ADD CONSTRAINT `fk_maintenance_measurement_reading_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_calibration_procedure_id` FOREIGN KEY (`calibration_procedure_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`calibration_procedure`(`calibration_procedure_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ADD CONSTRAINT `fk_maintenance_calibration_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ADD CONSTRAINT `fk_maintenance_breakdown_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`equipment`(`equipment_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_maintenance_plant_id` FOREIGN KEY (`maintenance_plant_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`maintenance_plant`(`maintenance_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`notification`(`notification_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ADD CONSTRAINT `fk_maintenance_permit_to_work_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ADD CONSTRAINT `fk_maintenance_task_list_predecessor_task_list_id` FOREIGN KEY (`predecessor_task_list_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`task_list`(`task_list_id`);
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_procedure` ADD CONSTRAINT `fk_maintenance_calibration_procedure_superseded_calibration_procedure_id` FOREIGN KEY (`superseded_calibration_procedure_id`) REFERENCES `chemical_mfg_ecm`.`maintenance`.`calibration_procedure`(`calibration_procedure_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`maintenance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`maintenance` SET TAGS ('dbx_domain' = 'maintenance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `calibration_required` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Equipment Capacity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Equipment Capacity Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Year of Construction');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `corrosion_allowance_mm` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Allowance (mm)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `criticality_class` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification (A/B/C)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `criticality_class` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `design_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (kPa)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `design_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'M|E|I|P|V');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_class` SET TAGS ('dbx_business_glossary_term' = 'Equipment Class');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `equipment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|standby|under_maintenance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Area Classification');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_value_regex' = 'Zone 0|Zone 1|Zone 2|Division 1|Division 2|non-hazardous');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `inspection_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval (Months)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `insulation_type` SET TAGS ('dbx_business_glossary_term' = 'Insulation Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `maintenance_planner_group` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Planner Group');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'time_based|condition_based|predictive|run_to_failure|reliability_centered');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `moc_status` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `moc_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|closed');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Model Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `next_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `operating_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Pressure (kPa)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Normal Operating Temperature (°C)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `pi_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Aveva PI System Tag Reference');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `pid_tag` SET TAGS ('dbx_business_glossary_term' = 'Piping and Instrumentation Diagram (P&ID) Tag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `psm_covered` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Covered Equipment');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Equipment Weight (kg)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`equipment` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Center');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Criticality Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `building_or_area_code` SET TAGS ('dbx_business_glossary_term' = 'Building or Area Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `catalog_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Catalog Profile Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `construction_material` SET TAGS ('dbx_business_glossary_term' = 'Construction Material');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `floc_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `floor_or_elevation` SET TAGS ('dbx_business_glossary_term' = 'Floor or Elevation Reference');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `functional_location_category` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Category');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `functional_location_description` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `geo_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `geo_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `geo_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `geo_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `geo_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `geo_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Area Classification');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_value_regex' = 'zone_0|zone_1|zone_2|non_hazardous|division_1|division_2');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `inspection_class` SET TAGS ('dbx_business_glossary_term' = 'Inspection Class');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `inspection_class` SET TAGS ('dbx_value_regex' = 'RBI|fixed_interval|condition_based|run_to_failure');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Changed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `linear_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'Linear Asset Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_construction|mothballed');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'plant|unit|area|system|subsystem');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `maintenance_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `moc_required` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `object_type` SET TAGS ('dbx_business_glossary_term' = 'SAP PM Object Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `pi_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Aveva PI System Tag Reference');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `pid_reference` SET TAGS ('dbx_business_glossary_term' = 'Piping and Instrumentation Diagram (P&ID) Reference');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `planner_group_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Planner Group Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `pressure_rating_bar` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure Rating (bar)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `process_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Name');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `psm_covered` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Covered Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `sort_field` SET TAGS ('dbx_business_glossary_term' = 'Sort Field');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `temperature_rating_c` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature Rating (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`functional_location` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Center Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `campaign_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `downtime_required` SET TAGS ('dbx_business_glossary_term' = 'Downtime Required');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `external_service_cost` SET TAGS ('dbx_business_glossary_term' = 'External Service Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `external_service_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `lockout_tagout_required` SET TAGS ('dbx_business_glossary_term' = 'Lockout Tagout (LOTO) Required');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `long_text` SET TAGS ('dbx_business_glossary_term' = 'Work Order Long Text');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_value_regex' = '^MOC[0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `permit_to_work_number` SET TAGS ('dbx_value_regex' = '^PTW[0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Work Order Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'planned|corrective|preventive|predictive|breakdown|project');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `work_order_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Operation ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `task_list_id` SET TAGS ('dbx_business_glossary_term' = 'Task List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `actual_work_duration` SET TAGS ('dbx_business_glossary_term' = 'Actual Work Duration');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `actual_work_unit` SET TAGS ('dbx_business_glossary_term' = 'Actual Work Unit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `actual_work_unit` SET TAGS ('dbx_value_regex' = 'H|MIN|D');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `calculation_key` SET TAGS ('dbx_business_glossary_term' = 'Calculation Key');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `calculation_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `confirmation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `earliest_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Earliest Finish Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `earliest_start_date` SET TAGS ('dbx_business_glossary_term' = 'Earliest Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `external_operation_flag` SET TAGS ('dbx_business_glossary_term' = 'External Operation Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `final_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Confirmation Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `latest_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Finish Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `latest_start_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `number_of_capacities` SET TAGS ('dbx_business_glossary_term' = 'Number of Capacities');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `operation_long_text` SET TAGS ('dbx_business_glossary_term' = 'Operation Long Text');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `operation_short_text` SET TAGS ('dbx_business_glossary_term' = 'Operation Short Text');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `planned_work_duration` SET TAGS ('dbx_business_glossary_term' = 'Planned Work Duration');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `planned_work_unit` SET TAGS ('dbx_business_glossary_term' = 'Planned Work Unit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `planned_work_unit` SET TAGS ('dbx_value_regex' = 'H|MIN|D');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `setup_time` SET TAGS ('dbx_business_glossary_term' = 'Setup Time');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `standard_text_key` SET TAGS ('dbx_business_glossary_term' = 'Standard Text Key');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `standard_text_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `system_status` SET TAGS ('dbx_business_glossary_term' = 'System Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `system_status` SET TAGS ('dbx_value_regex' = 'created|released|partially_confirmed|confirmed|technically_completed|closed');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `teardown_time` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `user_status` SET TAGS ('dbx_business_glossary_term' = 'User Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `work_quantity` SET TAGS ('dbx_business_glossary_term' = 'Work Quantity');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `work_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Work Quantity Unit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`work_order_operation` ALTER COLUMN `work_quantity_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `breakdown_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `breakdown_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breakdown End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `breakdown_indicator` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `breakdown_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `capa_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `ehs_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Environment Health and Safety (EHS) Incident Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Long Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `malfunction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Malfunction Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `malfunction_start_time` SET TAGS ('dbx_business_glossary_term' = 'Malfunction Start Time');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `moc_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'outstanding|in_progress|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'M1|M2|M3|M4');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Notification Priority');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `production_impact_indicator` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `production_loss_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Quantity');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `production_loss_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `production_loss_uom` SET TAGS ('dbx_value_regex' = 'MT|KG|L|GAL|LB');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `rci_number` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Investigation (RCI) Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `rci_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Investigation (RCI) Required Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `required_end_date` SET TAGS ('dbx_business_glossary_term' = 'Required End Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `required_start_date` SET TAGS ('dbx_business_glossary_term' = 'Required Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `safety_indicator` SET TAGS ('dbx_business_glossary_term' = 'Safety Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`notification` ALTER COLUMN `work_order_created_date` SET TAGS ('dbx_business_glossary_term' = 'Work Order Created Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` SET TAGS ('dbx_subdomain' = 'preventive_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `task_list_id` SET TAGS ('dbx_business_glossary_term' = 'Task List ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `auto_generate_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generate Work Order Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `call_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Call Horizon Days');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `counter_reading_at_last_maintenance` SET TAGS ('dbx_business_glossary_term' = 'Counter Reading at Last Maintenance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `counter_threshold_for_next_maintenance` SET TAGS ('dbx_business_glossary_term' = 'Counter Threshold for Next Maintenance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `cycle_length` SET TAGS ('dbx_business_glossary_term' = 'Cycle Length');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `cycle_unit` SET TAGS ('dbx_business_glossary_term' = 'Cycle Unit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `inspection_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `inspection_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `insurance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Notes');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'single_cycle|strategy_plan|multiple_counter|time_based|performance_based|condition_based');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `pm_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `scheduling_indicator` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `scheduling_indicator` SET TAGS ('dbx_value_regex' = 'time_based|performance_based|condition_based|fixed_date|annual|seasonal');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `scheduling_tolerance_after_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Tolerance After Days');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `scheduling_tolerance_before_days` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Tolerance Before Days');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `seasonal_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `seasonal_adjustment_months` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Months');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`pm_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` SET TAGS ('dbx_subdomain' = 'preventive_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `schedule_call_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Call Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `task_list_id` SET TAGS ('dbx_business_glossary_term' = 'Task List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Generation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Call Horizon Days');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Call Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_object_type` SET TAGS ('dbx_business_glossary_term' = 'Call Object Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_object_type` SET TAGS ('dbx_value_regex' = 'equipment|functional_location|assembly|material');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Call Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `call_status` SET TAGS ('dbx_value_regex' = 'scheduled|released|completed|cancelled|overdue|in_progress');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `counter_reading_at_call` SET TAGS ('dbx_business_glossary_term' = 'Counter Reading at Call');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `counter_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Counter Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Is Overdue Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `maintenance_activity_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Activity Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Call Notes');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `psm_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `shutdown_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `tolerance_days_early` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Days Early');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`schedule_call` ALTER COLUMN `tolerance_days_late` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Days Late');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `emission_source_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency (Days)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `characteristic_code` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `characteristic_description` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `counter_overflow_value` SET TAGS ('dbx_business_glossary_term' = 'Counter Overflow Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `criticality_code` SET TAGS ('dbx_business_glossary_term' = 'Criticality Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `criticality_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'manual|dcs|scada|lims|historian');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `decimal_places` SET TAGS ('dbx_business_glossary_term' = 'Decimal Places');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `historian_tag` SET TAGS ('dbx_business_glossary_term' = 'Historian Tag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `last_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reading Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `last_reading_value` SET TAGS ('dbx_business_glossary_term' = 'Last Reading Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `lower_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Alarm Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `lower_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Warning Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `measurement_point_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `measurement_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|decommissioned');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `measurement_position` SET TAGS ('dbx_business_glossary_term' = 'Measurement Position');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `next_reading_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reading Due Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `oee_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Relevant Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `point_category` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Category');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `point_category` SET TAGS ('dbx_value_regex' = 'counter|measurement');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `point_description` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `point_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `psm_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `reading_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Reading Frequency (Days)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `sensor_type` SET TAGS ('dbx_business_glossary_term' = 'Sensor Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Instrumentation Tag Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `upper_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Alarm Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_point` ALTER COLUMN `upper_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Warning Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` SET TAGS ('dbx_subdomain' = 'calibration_compliance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measurement_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Reading ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Notification ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `annotation` SET TAGS ('dbx_business_glossary_term' = 'Annotation');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `counter_overflow_flag` SET TAGS ('dbx_business_glossary_term' = 'Counter Overflow Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `counter_reading_flag` SET TAGS ('dbx_business_glossary_term' = 'Counter Reading Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `deviation_from_target` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Target');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `lower_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Alarm Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `lower_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Warning Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measurement_characteristic` SET TAGS ('dbx_business_glossary_term' = 'Measurement Characteristic');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measurement_document_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Document Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measurement_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `measurement_position` SET TAGS ('dbx_business_glossary_term' = 'Measurement Position');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'PI (Process Information) Tag Name');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `quality_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `quality_code` SET TAGS ('dbx_value_regex' = 'good|bad|uncertain|substituted|questionable');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `reading_date` SET TAGS ('dbx_business_glossary_term' = 'Reading Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_business_glossary_term' = 'Reading Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `reading_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|suspect|pending_review|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `reading_type` SET TAGS ('dbx_business_glossary_term' = 'Reading Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `reading_type` SET TAGS ('dbx_value_regex' = 'actual|estimated|calculated|manual|automatic');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `threshold_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Violation Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `upper_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Alarm Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`measurement_reading` ALTER COLUMN `upper_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Warning Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` SET TAGS ('dbx_subdomain' = 'calibration_compliance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `adjustment_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Performed Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `as_found_value` SET TAGS ('dbx_business_glossary_term' = 'As-Found Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `as_left_value` SET TAGS ('dbx_business_glossary_term' = 'As-Left Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_cost` SET TAGS ('dbx_business_glossary_term' = 'Calibration Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Interval (Days)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_points_tested` SET TAGS ('dbx_business_glossary_term' = 'Calibration Points Tested');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_standard_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'in-house|external|vendor|field|laboratory');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `environmental_humidity` SET TAGS ('dbx_business_glossary_term' = 'Environmental Humidity');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `environmental_temperature` SET TAGS ('dbx_business_glossary_term' = 'Environmental Temperature');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `gmp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Regulated Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `out_of_tolerance_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Tolerance (OOT) Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `psm_critical_instrument_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Critical Instrument Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Calibration Remarks');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `technician_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Technician Certification Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `tolerance_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `tolerance_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper Limit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_record` ALTER COLUMN `vendor_lab_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Vendor Laboratory Accreditation');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` SET TAGS ('dbx_subdomain' = 'preventive_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Event ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `emission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Event Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Maintenance (PM) Notification ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breakdown End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_number` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Event Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_status` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Event Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `breakdown_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `damage_code` SET TAGS ('dbx_business_glossary_term' = 'Damage Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Detection Method');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'operator_observation|alarm|inspection|predictive_maintenance|condition_monitoring|customer_complaint');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `ehs_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Environment Health and Safety (EHS) Incident Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `environmental_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `failure_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `failure_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Long Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `malfunction_start_indicator` SET TAGS ('dbx_business_glossary_term' = 'Malfunction Start Indicator');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Priority Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `production_impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Severity');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `production_impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `production_loss_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Quantity');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `production_loss_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `psm_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `rci_number` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Investigation (RCI) Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `rci_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Investigation (RCI) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `restoration_method` SET TAGS ('dbx_business_glossary_term' = 'Restoration Method');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `restoration_method` SET TAGS ('dbx_value_regex' = 'repair|replacement|temporary_fix|workaround|adjustment');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`breakdown_event` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Short Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `sds_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `closure_confirmation` SET TAGS ('dbx_business_glossary_term' = 'Closure Confirmation');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `confined_space_entry_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Entry Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `fire_watch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Watch Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `gas_test_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `gas_test_results` SET TAGS ('dbx_business_glossary_term' = 'Gas Test Results');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `hazard_identification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `isolation_requirements` SET TAGS ('dbx_business_glossary_term' = 'Isolation Requirements');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `lel_percent` SET TAGS ('dbx_business_glossary_term' = 'Lower Explosive Limit (LEL) Percent');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `oxygen_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Oxygen Level Percent');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'hot_work|confined_space_entry|electrical_isolation|line_breaking|excavation|height_work');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `psm_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management (PSM) Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `rescue_plan` SET TAGS ('dbx_business_glossary_term' = 'Rescue Plan');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `shutdown_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `special_precautions` SET TAGS ('dbx_business_glossary_term' = 'Special Precautions');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `toxic_gas_ppm` SET TAGS ('dbx_business_glossary_term' = 'Toxic Gas Concentration (PPM)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `valid_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid From Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `valid_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`permit_to_work` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_id` SET TAGS ('dbx_business_glossary_term' = 'Task List Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `predecessor_task_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `craft_skill_required` SET TAGS ('dbx_business_glossary_term' = 'Craft Skill Required');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `equipment_classification` SET TAGS ('dbx_business_glossary_term' = 'Equipment Classification');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `functional_location_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Is Template Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `lockout_tagout_required` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `material_requirements` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'MOC Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `operation_description` SET TAGS ('dbx_business_glossary_term' = 'Operation Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `operation_step_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Step Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `planned_hours_unit` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours Unit');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `planned_hours_unit` SET TAGS ('dbx_value_regex' = 'hour|minute');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `psm_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Management Critical Flag');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `regulatory_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `safety_precautions` SET TAGS ('dbx_business_glossary_term' = 'Safety Precautions');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_category` SET TAGS ('dbx_value_regex' = 'preventive|corrective|inspection|calibration');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_code` SET TAGS ('dbx_business_glossary_term' = 'Task List Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_description` SET TAGS ('dbx_business_glossary_term' = 'Task List Description');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_name` SET TAGS ('dbx_business_glossary_term' = 'Task List Name');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_status` SET TAGS ('dbx_business_glossary_term' = 'Task List Status');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_type` SET TAGS ('dbx_business_glossary_term' = 'Task List Type');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `task_list_type` SET TAGS ('dbx_value_regex' = 'equipment|functional_location|general');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `tool_requirements` SET TAGS ('dbx_business_glossary_term' = 'Tool Requirements');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Task List Version Number');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`task_list` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_procedure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_procedure` SET TAGS ('dbx_subdomain' = 'calibration_compliance');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_procedure` ALTER COLUMN `calibration_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`calibration_procedure` ALTER COLUMN `superseded_calibration_procedure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`maintenance`.`maintenance_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
