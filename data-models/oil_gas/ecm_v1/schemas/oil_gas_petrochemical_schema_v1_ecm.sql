-- Schema for Domain: petrochemical | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`petrochemical` COMMENT 'Covers petrochemical manufacturing and conversion operations including NGL fractionation, LPG processing, GTL, feedstock cracking, polymerization, chemical synthesis, and specialty chemical production. Manages feedstock allocation, conversion unit performance, catalyst performance, product yield tracking, and plant-level OPEX. Integrates with Aspen HYSYS for process simulation and SAP PP for production planning. Supports EPA environmental compliance and ISO quality standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key for plant',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Plants must be assigned to legal entities (company codes) for financial statement consolidation, statutory reporting, and intercompany transactions. Fundamental financial accounting requirement.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Plants maintain ISO certifications (14001 environmental, 45001 safety, 55001 asset management) and industry programs (Responsible Care). Plant table has certification flags; FK enables certification e',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Petrochemical plants in oil-and-gas ventures are frequently operated under Joint Operating Agreements governing cost allocation, overhead rates, AFE approvals, and operating committee decisions. Requi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Petrochemical plants are profit centers in oil/gas operations. P&L reporting, segment analysis, and management reporting require plant-to-profit-center assignment. Standard SAP/ERP configuration.',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to logistics.terminal. Business justification: Petrochemical plants often have integrated or adjacent terminals for product loading/unloading. Links plant production facilities with logistics infrastructure for shipment planning, capacity coordina',
    `business_unit` STRING COMMENT 'Corporate business unit or division that owns and operates the petrochemical plant. Used for organizational reporting, capital allocation, and strategic planning.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the nameplate capacity. MTPA (Million Tonnes Per Annum), KTPA (Thousand Tonnes Per Annum), BPSD (Barrels Per Stream Day), MMSCFD (Million Standard Cubic Feet per Day), KTPD (Thousand Tonnes Per Day), TPH (Tonnes Per Hour).. Valid values are `MTPA|KTPA|BPSD|MMSCFD|KTPD|TPH`',
    `city` STRING COMMENT 'City or municipality where the petrochemical plant is located. Used for local regulatory reporting and logistics planning.',
    `commissioning_date` DATE COMMENT 'Date when the petrochemical plant was officially commissioned and began commercial operations. Used for asset age analysis, depreciation calculations, and lifecycle planning.',
    `cost_center` STRING COMMENT 'Financial cost center code assigned to the plant for OPEX tracking and budget management. Used in SAP FI/CO for expense allocation, variance analysis, and profitability reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the petrochemical plant is physically located. Used for regulatory compliance, tax jurisdiction determination, and geographic reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this plant master record was first created in the data system. Used for data lineage, audit trails, and record lifecycle tracking. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `email` STRING COMMENT 'Primary email address for the petrochemical plant facility. Used for business correspondence, regulatory notifications, and operational communications. Business-confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `epa_facility_code` STRING COMMENT 'Unique facility identifier assigned by the U.S. Environmental Protection Agency for environmental compliance tracking. Required for emissions reporting, permit management, and regulatory inspections under Clean Air Act and other EPA programs.',
    `ghgrp_facility_code` STRING COMMENT 'EPA Greenhouse Gas Reporting Program facility identifier. Required for annual GHG emissions reporting under 40 CFR Part 98 for facilities emitting 25,000 metric tons CO2e or more per year. Critical for ESG reporting and carbon compliance.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this plant master record is currently active in the system. True for active plants, False for decommissioned or archived facilities. Used for filtering operational reports and analytics.',
    `last_turnaround_date` DATE COMMENT 'Date of the most recent planned major maintenance turnaround or shutdown. Turnarounds are scheduled multi-week events for inspection, repair, and equipment replacement. Critical for maintenance planning and reliability analysis.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the plant facility in decimal degrees. Used for GIS mapping, logistics optimization, and emergency response planning. Positive values indicate northern hemisphere.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the plant facility in decimal degrees. Used for GIS mapping, logistics optimization, and emergency response planning. Positive values indicate eastern hemisphere.',
    `manager_name` STRING COMMENT 'Full name of the current plant manager or site leader responsible for overall facility operations. Business reference for organizational hierarchy, not direct PII classification.',
    `maximo_location_code` STRING COMMENT 'Location identifier for the plant in IBM Maximo Asset Management system. Used for work order management, preventive maintenance scheduling, and asset hierarchy navigation. Links plant master to CMMS operational data.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this plant master record was last updated. Used for change tracking, data quality monitoring, and synchronization with downstream systems. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `nameplate_capacity` DECIMAL(18,2) COMMENT 'Design-rated maximum production capacity of the petrochemical plant under optimal operating conditions. Expressed in the primary unit of measure for the plants main product. Used for capacity planning, utilization analysis, and regulatory reporting.',
    `next_turnaround_date` DATE COMMENT 'Scheduled date for the next planned major maintenance turnaround. Used for production planning, budget forecasting, and resource allocation. Typically occurs every 2-5 years depending on plant type and operating conditions.',
    `operating_company` STRING COMMENT 'Legal entity or operating company that owns the plant asset. Used for financial consolidation, tax reporting, and legal liability determination. Critical for joint venture and partnership structures.',
    `operational_status` STRING COMMENT 'Current operational state of the petrochemical plant in its lifecycle. Indicates whether the facility is actively producing, undergoing maintenance, or temporarily offline. Critical for production planning and capacity forecasting.. Valid values are `Operating|Idle|Turnaround|Startup|Shutdown|Mothballed`',
    `phone` STRING COMMENT 'Primary contact telephone number for the petrochemical plant facility. Used for business communications, emergency coordination, and logistics. Business-confidential organizational contact data.',
    `plant_code` STRING COMMENT 'Externally-known unique business identifier for the petrochemical plant. Used in operational systems, regulatory filings, and inter-company communications. Typically follows company naming conventions for facility identification.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plant_name` STRING COMMENT 'Official business name of the petrochemical manufacturing facility. Human-readable identifier used in reports, dashboards, and business communications.',
    `plant_type` STRING COMMENT 'Classification of the petrochemical manufacturing facility based on primary conversion process. Defines the core technology and product slate of the plant unit. [ENUM-REF-CANDIDATE: NGL Fractionation|Steam Cracker|Polymerization Reactor|GTL Unit|Specialty Chemical Plant|LPG Processing|Ethylene Plant|Propylene Plant|Aromatics Complex|Methanol Plant — promote to reference product]',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the plant facility location. Used for logistics, emergency services coordination, and regulatory correspondence. Business-confidential organizational contact data.',
    `primary_feedstock_type` STRING COMMENT 'Main hydrocarbon feedstock consumed by the petrochemical plant for conversion processes. Determines the plants integration with upstream production and refining operations. Critical for feedstock allocation and supply chain planning. [ENUM-REF-CANDIDATE: Ethane|Propane|Butane|Naphtha|Natural Gas|Methane|Mixed NGL|Condensate — 8 candidates stripped; promote to reference product]',
    `primary_product` STRING COMMENT 'Main petrochemical product or chemical compound produced by the plant. Represents the highest-value or highest-volume output from the facility. Used for product portfolio management and market analysis.',
    `process_technology` STRING COMMENT 'Specific proprietary process or technology platform used in the plant. Examples include Lummus SRT (Short Residence Time) cracking, Linde ethylene technology, UOP Oleflex. Defines the technical characteristics and performance envelope of the facility.',
    `profit_center` STRING COMMENT 'Financial profit center code assigned to the plant for revenue and margin tracking. Used in SAP CO-PA for profitability analysis and business segment reporting.',
    `record_source_system` STRING COMMENT 'Name of the source system or application that is the system of record for this plant master data. Examples include SAP S/4HANA, Aspen HYSYS, Maximo. Used for data lineage and reconciliation.',
    `sap_plant_code` STRING COMMENT 'Plant code used in SAP ERP system for materials management, production planning, and maintenance. Links the petrochemical plant master record to SAP MM, PP, and PM modules for integrated business processes.',
    `scada_system_code` STRING COMMENT 'Unique identifier for the plant in the SCADA or DCS system. Used to link real-time process data from OSIsoft PI System or other historians to the plant master record. Enables integration of operational data with business analytics.',
    `secondary_products` STRING COMMENT 'Additional petrochemical products or by-products generated by the plant alongside the primary product. Comma-separated list of product names. Important for yield optimization and revenue allocation.',
    `site_address` STRING COMMENT 'Physical street address of the petrochemical plant facility. Used for emergency response, logistics coordination, and regulatory filings. Business-confidential organizational contact data.',
    `state_province` STRING COMMENT 'State, province, or primary administrative subdivision where the plant is located. Used for state-level regulatory compliance and regional operational reporting.',
    `technology_licensor` STRING COMMENT 'Engineering firm or technology provider that licensed the core process technology for the plant. Examples include Lummus, KBR, Linde, UOP, Shell, ExxonMobil. Critical for technical support, catalyst procurement, and process optimization.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master record for each petrochemical manufacturing facility or plant unit, including NGL fractionation trains, steam crackers, polymerization reactors, GTL units, and specialty chemical plants. Captures plant identity, nameplate capacity, feedstock type, primary product slate, geographic location, regulatory registration numbers, operational status, and ISO certification details. Serves as the SSOT for petrochemical plant identity within the domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` (
    `conversion_unit_id` BIGINT COMMENT 'Unique identifier for the conversion unit within the petrochemical plant. Primary key for the conversion unit master record.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Individual units may hold process safety certifications (API standards, ASME certifications, SEMS for offshore). Links units to certifications for tracking certification scope, audit cycles, and renew',
    `consent_order_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_order. Business justification: Specific units may be subject to consent orders requiring operational modifications, emission reductions, or enhanced monitoring. Links units to consent orders for tracking unit-specific compliance re',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Conversion units (crackers, reformers, distillation columns) are major equipment assets requiring preventive maintenance plans, inspection events, failure tracking, and integrity management per API 58',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Individual processing units may be subject to separate JOAs or inherit parent plant JOA. Critical for unit-level AFE approvals, turnaround authorizations, and COPAS billing of unit-specific operating ',
    `plant_id` BIGINT COMMENT 'Reference to the parent petrochemical plant or facility where this conversion unit is located.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Conversion units are often individual profit centers for margin analysis and performance tracking. Enables unit-level P&L reporting and benchmarking in multi-unit plants.',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: Individual units may be audited for compliance with operating permits, safety standards, and process safety management. Links units to audits for tracking unit-specific findings and corrective actions',
    `aspen_hysys_model_reference` STRING COMMENT 'Reference to the Aspen HYSYS process simulation model for this conversion unit. Aspen HYSYS is used for process simulation, optimization, and what-if scenario analysis to maximize yield and efficiency.',
    `asset_criticality_rating` STRING COMMENT 'Criticality classification of the conversion unit based on impact to production, safety, environmental risk, and business continuity. Critical assets receive priority for maintenance, inspection, and capital investment.. Valid values are `critical|high|medium|low`',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of current operating capacity being utilized, calculated as actual throughput divided by current operating capacity. Key performance indicator for asset productivity and operational efficiency.',
    `catalyst_expected_life_months` STRING COMMENT 'Expected operational life of the catalyst in months before regeneration or replacement is required. Catalyst deactivation impacts unit performance and product yield.',
    `catalyst_load_date` DATE COMMENT 'Date when the current catalyst charge was loaded into the conversion unit. Used to track catalyst age and plan catalyst regeneration or replacement cycles.',
    `catalyst_type` STRING COMMENT 'Type or formulation of catalyst currently loaded in the conversion unit. Catalysts are critical for reaction rates, selectivity, and product yield in petrochemical processes. Examples include zeolite catalysts for Fluid Catalytic Cracking (FCC), platinum-based catalysts for reforming, or Ziegler-Natta catalysts for polymerization.',
    `commissioning_date` DATE COMMENT 'Date when the conversion unit was originally commissioned and placed into service. Used for asset age tracking, depreciation calculations, and lifecycle management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conversion unit master record was first created in the system. Used for data lineage and audit trail purposes.',
    `current_operating_capacity` DECIMAL(18,2) COMMENT 'Current achievable throughput capacity of the conversion unit considering equipment condition, catalyst activity, operational constraints, and market demand. May differ from design capacity due to aging, fouling, or operational optimization.',
    `dcs_system_reference` STRING COMMENT 'Reference identifier or node name for the conversion unit in the plant Distributed Control System (DCS). Used for integration with real-time process control and monitoring systems.',
    `design_capacity` DECIMAL(18,2) COMMENT 'Nameplate or design throughput capacity of the conversion unit as specified by the original engineering design. Represents maximum sustainable production rate under ideal conditions.',
    `design_capacity_uom` STRING COMMENT 'Unit of measure for the design capacity. Common units include Barrels Per Day (BPD) for liquid hydrocarbons, Tonnes Per Day (TPD) or Tonnes Per Year (TPY) for solid or bulk products, Million Standard Cubic Feet per Day (MMSCFD) or Thousand Cubic Feet per Day (MCFD) for gas, kilograms per hour, metric tonnes per day, or metric tonnes per year. [ENUM-REF-CANDIDATE: bpd|tpd|tpy|mmscfd|mcfd|kg_per_hour|mt_per_day|mt_per_year — 8 candidates stripped; promote to reference product]',
    `design_life_years` STRING COMMENT 'Original design life of the conversion unit in years as specified by the engineering design. Typical design life for petrochemical units ranges from 20 to 40 years.',
    `energy_consumption_mmbtu_per_day` DECIMAL(18,2) COMMENT 'Average daily energy consumption of the conversion unit in Million British Thermal Units (MMBTU). Key metric for Operating Expenditure (OPEX) tracking and energy efficiency optimization.',
    `epc_contractor` STRING COMMENT 'Name of the Engineering Procurement and Construction (EPC) contractor who designed and built the conversion unit. Relevant for warranty claims, technical support, and spare parts sourcing.',
    `feedstock_specification` STRING COMMENT 'Detailed specification of feedstock quality requirements including composition, purity, sulfur content, Total Acid Number (TAN), Research Octane Number (RON), or other relevant chemical and physical properties required for optimal unit performance.',
    `flare_system_connected_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the conversion unit is connected to a flare system for emergency pressure relief and disposal of excess hydrocarbons. Flare systems are critical safety devices for petrochemical plants.',
    `ghg_emissions_co2e_tpy` DECIMAL(18,2) COMMENT 'Annual Greenhouse Gas (GHG) emissions from the conversion unit in tonnes of Carbon Dioxide Equivalent (CO2e) per year. Critical for Environmental Social and Governance (ESG) reporting, Carbon Capture and Storage (CCS) planning, and Environmental Protection Agency (EPA) compliance.',
    `h2s_handling_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the conversion unit processes feedstocks containing Hydrogen Sulfide (H2S) or produces H2S as a byproduct. H2S is a toxic and corrosive gas requiring special safety protocols and equipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this conversion unit master record was last modified. Used for change tracking and data quality monitoring.',
    `last_turnaround_date` DATE COMMENT 'Date of the most recent planned turnaround or major maintenance shutdown. Turnarounds are scheduled maintenance events for inspection, repair, and equipment replacement to ensure safe and reliable operation.',
    `next_scheduled_turnaround_date` DATE COMMENT 'Planned date for the next turnaround or major maintenance shutdown. Critical for Capital Expenditure (CAPEX) planning, production scheduling, and maintenance resource allocation.',
    `operating_pressure_max_bar` DECIMAL(18,2) COMMENT 'Maximum operating pressure in bar for the conversion unit under normal operating conditions. Exceeding this pressure may trigger safety relief systems or equipment failure.',
    `operating_pressure_min_bar` DECIMAL(18,2) COMMENT 'Minimum operating pressure in bar for the conversion unit under normal operating conditions. Critical for process control and product quality.',
    `operating_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum operating temperature in degrees Celsius for the conversion unit under normal operating conditions. Exceeding this temperature may trigger safety interlocks or equipment damage.',
    `operating_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum operating temperature in degrees Celsius for the conversion unit under normal operating conditions. Critical for process control and safety management.',
    `operational_status` STRING COMMENT 'Current operational state of the conversion unit. Operating indicates active production, standby indicates ready but not producing, shutdown indicates temporarily offline, turnaround indicates scheduled maintenance, startup indicates ramping up to production, commissioning indicates initial testing phase, and decommissioned indicates permanently retired. [ENUM-REF-CANDIDATE: operating|standby|shutdown|turnaround|startup|commissioning|decommissioned — 7 candidates stripped; promote to reference product]',
    `original_equipment_manufacturer` STRING COMMENT 'Name of the Original Equipment Manufacturer (OEM) for the primary conversion equipment (e.g., reactor vessel, distillation column, compressor). Critical for maintenance, spare parts, and technical documentation.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the current operating permit. Permits must be renewed before expiry to maintain legal authorization to operate the conversion unit.',
    `primary_feedstock_type` STRING COMMENT 'Primary feedstock material processed by the conversion unit (e.g., naphtha, ethane, propane, vacuum gas oil, natural gas, methanol). Defines the input material specification for the conversion process.',
    `primary_product_type` STRING COMMENT 'Primary product or product family produced by the conversion unit (e.g., ethylene, propylene, gasoline, diesel, polypropylene, polyethylene, aromatics, Liquefied Petroleum Gas (LPG)).',
    `process_technology` STRING COMMENT 'Specific process technology or licensor technology employed by the conversion unit (e.g., Lummus SRT, UOP Platforming, ExxonMobil MTBE, Shell SMPO). Identifies the proprietary or standard process design.',
    `psr_completion_date` DATE COMMENT 'Date of the most recent Process Safety Review (PSR) or Process Hazard Analysis (PHA) completion. Required under Occupational Safety and Health Administration (OSHA) Process Safety Management (PSM) regulations for units handling hazardous chemicals.',
    `replacement_value_usd` DECIMAL(18,2) COMMENT 'Estimated replacement value of the conversion unit in United States Dollars (USD) at current market prices. Used for insurance valuation, Capital Expenditure (CAPEX) planning, and asset impairment testing.',
    `scada_system_reference` STRING COMMENT 'Reference identifier for the conversion unit in the Supervisory Control and Data Acquisition (SCADA) system. Enables linkage to real-time production data historian such as OSIsoft PI System for performance monitoring and analytics.',
    `turnaround_interval_months` STRING COMMENT 'Standard interval in months between planned turnarounds for this conversion unit type. Typically ranges from 24 to 60 months depending on process severity, equipment design, and regulatory requirements.',
    `unit_name` STRING COMMENT 'Business name or description of the conversion unit for operational reference and reporting purposes.',
    `unit_tag_number` STRING COMMENT 'Unique engineering tag number assigned to the conversion unit following plant naming conventions. Used for identification in Piping and Instrumentation Diagrams (P&IDs), Distributed Control System (DCS), and Supervisory Control and Data Acquisition (SCADA) systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `unit_type` STRING COMMENT 'Classification of the conversion unit by process technology. Includes steam crackers for olefin production, Fluid Catalytic Cracking (FCC) units for gasoline production, polymerization reactors for polymer synthesis, reformers for aromatics production, Hydrodesulfurization (HDS) units for sulfur removal, Gas-to-Liquids (GTL) reactors, Natural Gas Liquids (NGL) fractionation columns, and other petrochemical conversion technologies. [ENUM-REF-CANDIDATE: steam_cracker|fcc_unit|polymerization_reactor|reformer|hydrodesulfurization_unit|gtl_reactor|ngl_fractionation_column|catalytic_reformer|alkylation_unit|isomerization_unit|other — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_conversion_unit PRIMARY KEY(`conversion_unit_id`)
) COMMENT 'Master record for individual conversion units within a petrochemical plant, including steam crackers, FCC units, polymerization reactors, reformers, hydrodesulfurization units, GTL reactors, and NGL fractionation columns. Tracks unit type, design capacity, current operating capacity, feedstock specifications, catalyst type loaded, last turnaround date, next scheduled turnaround, DCS/SCADA system reference, and unit operational status. Integrates with Aspen HYSYS for process simulation linkage.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` (
    `feedstock_id` BIGINT COMMENT 'Unique identifier for the feedstock material record. Primary key for the feedstock master catalog in the petrochemical domain.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Petrochemical feedstocks (naphtha, ethane, propane, gas oil, condensate) are petroleum products with master specifications. Link enables feedstock procurement pricing against petroleum product benchma',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to refining.product_specification. Business justification: Petrochemical feedstocks sourced from refineries must meet specific quality specifications (RON, sulfur, distillation ranges). This link enables validation that refinery product specs align with petro',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the feedstock material, a standard measure of petroleum liquid density relative to water. Higher values indicate lighter, less dense materials. Critical for refining and petrochemical process design.',
    `approved_supplier_reference` STRING COMMENT 'Reference identifier or name of the approved supplier(s) for this feedstock material. Links to the supplier master data in procurement systems (SAP MM vendor master). Multiple suppliers may be comma-separated or stored as a list.',
    `aromatic_content_percent` DECIMAL(18,2) COMMENT 'Percentage of aromatic hydrocarbons (benzene, toluene, xylene) in the feedstock composition. Aromatics are valuable for petrochemical synthesis but require special handling due to toxicity and environmental regulations.',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Ash content of the feedstock measured as a percentage by weight. Represents inorganic residue remaining after combustion; high ash content can foul equipment and deactivate catalysts.',
    `autoignition_temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Autoignition temperature of the feedstock material in degrees Fahrenheit, the minimum temperature at which the material will spontaneously ignite without an external ignition source. Used for process safety design and hazard analysis.',
    `butane_fraction_percent` DECIMAL(18,2) COMMENT 'Mole percentage of butane (C4) in the feedstock composition. Used for butadiene production and alkylation feedstock planning.',
    `c5_plus_fraction_percent` DECIMAL(18,2) COMMENT 'Mole percentage of pentanes and heavier hydrocarbons (C5+) in the feedstock composition. Represents the heavier end of NGL streams and condensates.',
    `calorific_value_btu_per_scf` DECIMAL(18,2) COMMENT 'Heating value or energy content of the feedstock measured in BTU per standard cubic foot. Used for energy balance calculations, process optimization, and feedstock valuation in petrochemical operations.',
    `carbon_residue_percent` DECIMAL(18,2) COMMENT 'Carbon residue of the feedstock measured as a percentage by weight (Conradson or Ramsbottom method). Indicates the tendency of the feedstock to form coke deposits in thermal processing units.',
    `cetane_index` DECIMAL(18,2) COMMENT 'Cetane index of the feedstock material, a calculated measure of ignition quality for diesel-range materials. Relevant for middle distillate feedstocks in petrochemical processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedstock material record was first created in the system. Used for audit trail and data lineage tracking.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Density of the feedstock material at standard conditions, measured in kilograms per cubic meter (kg/m³). Used for volume-to-mass conversions, storage capacity planning, and transportation logistics.',
    `effective_date` DATE COMMENT 'Date from which this feedstock material specification became effective and approved for use in petrochemical manufacturing operations. Used for version control and historical tracking of feedstock specifications.',
    `ethane_fraction_percent` DECIMAL(18,2) COMMENT 'Mole percentage of ethane (C2) in the feedstock composition. Critical for ethylene production yield forecasting in steam cracking operations.',
    `expiration_date` DATE COMMENT 'Date on which this feedstock material specification expires or is scheduled for review. Null for active feedstocks with no planned discontinuation. Used for lifecycle management and specification refresh cycles.',
    `feedstock_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the feedstock material in enterprise systems (SAP MM material master, Aspen HYSYS component library). Used for procurement, inventory, and process simulation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `feedstock_name` STRING COMMENT 'Common business name of the feedstock material (e.g., Ethane, Propane, Naphtha, Condensate, Natural Gas, NGL Stream).',
    `feedstock_type` STRING COMMENT 'Primary classification of the feedstock material by source and composition category. Aligns with petrochemical industry standard feedstock taxonomy. [ENUM-REF-CANDIDATE: NGL|LPG|Naphtha|Condensate|Natural Gas|Crude-Derived Intermediate|Ethane|Propane|Butane|Other — 10 candidates stripped; promote to reference product]',
    `flash_point_fahrenheit` DECIMAL(18,2) COMMENT 'Flash point of the feedstock material in degrees Fahrenheit, the lowest temperature at which vapors ignite when exposed to an ignition source. Critical for fire safety and storage classification.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide (H2S) content of the feedstock measured in parts per million (ppm). H2S is highly toxic and corrosive; monitoring is critical for worker safety (OSHA exposure limits) and equipment integrity.',
    `hazard_classification` STRING COMMENT 'Primary hazard classification of the feedstock material per OSHA Hazard Communication Standard (HCS) and Globally Harmonized System (GHS). Used for HSE compliance, storage requirements, and emergency response planning.. Valid values are `Flammable|Toxic|Corrosive|Explosive|Non-Hazardous|Compressed Gas`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedstock material record was last updated. Used for change tracking and audit trail compliance.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the feedstock material in the petrochemical manufacturing process. Active feedstocks are approved for use; Inactive or Discontinued feedstocks are no longer procured or consumed.. Valid values are `Active|Inactive|Approved|Under Review|Discontinued|Restricted`',
    `mercaptan_sulfur_ppm` DECIMAL(18,2) COMMENT 'Mercaptan sulfur content of the feedstock measured in parts per million (ppm). Mercaptans are odorous sulfur compounds that can cause corrosion and product quality issues in petrochemical processing.',
    `metals_content_ppm` DECIMAL(18,2) COMMENT 'Total metals content (vanadium, nickel, iron, sodium) of the feedstock measured in parts per million (ppm). Metals are catalyst poisons and can cause fouling in petrochemical processing equipment.',
    `methane_fraction_percent` DECIMAL(18,2) COMMENT 'Mole percentage of methane (C1) in the feedstock composition. Part of the hydrocarbon composition profile used for process simulation and yield optimization.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Average molecular weight of the feedstock material in grams per mole (g/mol). Used for mass balance calculations, process simulation in Aspen HYSYS, and stoichiometric analysis in chemical reactions.',
    `nitrogen_content_ppm` DECIMAL(18,2) COMMENT 'Nitrogen content of the feedstock measured in parts per million (ppm). Nitrogen compounds can act as catalyst poisons in petrochemical processes and must be monitored for process optimization.',
    `octane_number_ron` DECIMAL(18,2) COMMENT 'Research Octane Number (RON) of the feedstock material, a measure of anti-knock performance in gasoline blending. Applicable to naphtha and gasoline-range feedstocks used in petrochemical operations.',
    `olefin_content_percent` DECIMAL(18,2) COMMENT 'Percentage of olefinic (unsaturated) hydrocarbons in the feedstock composition. Olefins are key intermediates in petrochemical manufacturing (ethylene, propylene) and affect process stability and product yield.',
    `paraffin_content_percent` DECIMAL(18,2) COMMENT 'Percentage of paraffinic (saturated) hydrocarbons in the feedstock composition. Paraffins are stable, non-reactive hydrocarbons that influence feedstock cracking behavior and product distribution.',
    `pour_point_fahrenheit` DECIMAL(18,2) COMMENT 'Pour point of the feedstock material in degrees Fahrenheit, the lowest temperature at which the material will flow under specified conditions. Important for cold weather operations and storage.',
    `propane_fraction_percent` DECIMAL(18,2) COMMENT 'Mole percentage of propane (C3) in the feedstock composition. Key input for propylene production and LPG processing operations.',
    `quality_grade` STRING COMMENT 'Quality classification of the feedstock material based on composition specifications, purity, and conformance to contractual or industry standards. Premium grade feedstocks command higher prices and yield better conversion rates.. Valid values are `Premium|Standard|Off-Spec|Blended|Contract Grade|Spot Grade`',
    `reid_vapor_pressure_psi` DECIMAL(18,2) COMMENT 'Reid Vapor Pressure (RVP) of the feedstock material measured in pounds per square inch (psi). A standard measure of volatility for petroleum liquids, critical for EPA emissions compliance and storage safety.',
    `source_type` STRING COMMENT 'Origin classification of the feedstock material indicating whether it is produced internally, purchased externally, or transferred from joint venture operations.. Valid values are `Field Production|Refinery Output|Import|Third-Party Supplier|Joint Venture|Internal Transfer`',
    `specific_gravity` DECIMAL(18,2) COMMENT 'Specific gravity of the feedstock material at standard conditions (60°F/15.6°C). Used for volume-to-mass conversions and process engineering calculations.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Sulfur content of the feedstock measured in parts per million (ppm). Critical for environmental compliance (EPA emissions standards), catalyst performance, and downstream product quality in petrochemical manufacturing.',
    `tan_mg_koh_per_g` DECIMAL(18,2) COMMENT 'Total Acid Number (TAN) of the feedstock, measured in milligrams of potassium hydroxide (KOH) required to neutralize one gram of the material. Indicates acidity level and corrosion potential in processing equipment.',
    `vapor_pressure_psia` DECIMAL(18,2) COMMENT 'Vapor pressure of the feedstock material at standard conditions, measured in pounds per square inch absolute (psia). Critical for storage tank design, transportation safety, and process equipment sizing.',
    `viscosity_centistokes` DECIMAL(18,2) COMMENT 'Kinematic viscosity of the feedstock material at standard temperature, measured in centistokes (cSt). Affects pumping requirements, heat transfer efficiency, and process equipment design.',
    `water_content_ppm` DECIMAL(18,2) COMMENT 'Water content of the feedstock measured in parts per million (ppm). Excess water can cause corrosion, catalyst deactivation, and process inefficiencies in petrochemical manufacturing.',
    CONSTRAINT pk_feedstock PRIMARY KEY(`feedstock_id`)
) COMMENT 'Master catalog of feedstock materials used in petrochemical manufacturing operations, including ethane, propane, naphtha, condensate, natural gas, NGL streams, and crude-derived intermediates. Captures feedstock name, API gravity, composition specifications (C1-C5+ fractions), sulfur content, TAN, calorific value, source type, approved supplier references, and quality grade classifications per API and ISO standards. SSOT for feedstock material identity in the petrochemical domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` (
    `feedstock_receipt_id` BIGINT COMMENT 'Unique identifier for the feedstock receipt transaction record.',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Feedstock receipts fulfill supply-side term contracts (feedstock purchase agreements). Critical for tracking supplier performance, volume commitments, and cost reconciliation. Role prefix supply_ di',
    `contract_id` BIGINT COMMENT 'Identifier of the supply contract or purchase agreement under which this feedstock receipt was delivered.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Feedstock receiving costs (inspection, handling) allocated to cost centers for budget tracking.',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Feedstock receipts of crude-derived streams require crude grade reference for acceptance testing against assay specifications, API gravity validation, sulfur content verification, and feedstock alloca',
    `feedstock_id` BIGINT COMMENT 'Foreign key linking to petrochemical.feedstock. Business justification: Receipt records must reference which feedstock material was received. The feedstock_type attribute on feedstock_receipt is redundant and should be retrieved via JOIN to feedstock.feedstock_type. Cardi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Feedstock receipts post to inventory GL accounts for balance sheet valuation and COGS calculation.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Feedstock receiving and storage operations require permits for tank storage, spill prevention (SPCC), and air emissions (loading racks). Links receipts to applicable permits for tracking permitted sto',
    `plant_id` BIGINT COMMENT 'Identifier of the petrochemical plant or facility where the feedstock was received.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Integrated oil-gas companies track reservoir source of NGL/gas feedstocks for custody transfer, supply chain optimization, and transfer pricing between upstream and downstream business units. Essentia',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Feedstock deliveries to petrochemical plants arrive via truck, rail, pipeline, or vessel shipments. Links inbound logistics documentation with plant receipt records for supply chain visibility, demurr',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: NGL and natural gas feedstocks received at petrochemical plants originate from upstream production wells tied to specific leases. Tracking source lease enables royalty burden allocation, feedstock cos',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: When feedstock originates from production facilities (gas plants, central processing facilities, separator stations), source_identifier references the facility. Explicit FK supports integrated operati',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Petrochemical plants receive NGL, condensate, and natural gas liquids directly from production wells. The source_identifier field currently stores this as text; creating explicit FK enables custody tr',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or counterparty delivering the feedstock under contract or spot purchase.',
    `acceptance_status` STRING COMMENT 'Status indicating whether the feedstock receipt was accepted, rejected, conditionally accepted, or is under quality review based on specification compliance.. Valid values are `Accepted|Rejected|Conditional|Under Review`',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity measurement of the liquid feedstock at receipt, indicating density and quality characteristics.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to this feedstock receipt for traceability through the processing chain and inventory management.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `composition_analysis` STRING COMMENT 'Detailed chemical composition breakdown of the feedstock including hydrocarbon fractions, impurities, and component percentages from laboratory assay.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this feedstock receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction cost amounts.. Valid values are `^[A-Z]{3}$`',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Density of the feedstock measured in kilograms per cubic meter at standard conditions.',
    `destination_storage_tank` STRING COMMENT 'Identifier of the storage tank or vessel where the received feedstock was initially stored after receipt.',
    `gross_volume_barrels` DECIMAL(18,2) COMMENT 'Gross volume of liquid feedstock received in barrels before any adjustments for temperature, pressure, or quality.',
    `h2s_content_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide concentration in the feedstock measured in parts per million, critical for safety and environmental compliance.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the quality inspection and acceptance verification was completed.',
    `inspector_name` STRING COMMENT 'Name of the quality inspector or receiving personnel who verified and documented the feedstock receipt.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this feedstock receipt record was last modified or updated.',
    `net_volume_barrels` DECIMAL(18,2) COMMENT 'Net volume of liquid feedstock received in barrels after adjustments for temperature, pressure, sediment, and water content.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Pressure of the feedstock at the custody transfer point measured in pounds per square inch.',
    `quality_certificate_number` STRING COMMENT 'Reference number of the quality assay certificate or certificate of analysis issued for this feedstock receipt.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `receipt_number` STRING COMMENT 'Business identifier or document number assigned to this feedstock receipt transaction for tracking and reconciliation purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the feedstock delivery was physically received at the custody transfer point.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the feedstock receipt was rejected or conditionally accepted, including specific quality parameters that failed to meet specifications.',
    `remarks` STRING COMMENT 'Additional notes, observations, or special conditions related to this feedstock receipt transaction.',
    `sediment_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sediment and solid particulates in the feedstock, affecting quality and processing efficiency.',
    `source_identifier` STRING COMMENT 'Specific identifier of the source pipeline, vessel name, truck number, rail car, or storage tank from which the feedstock was received.',
    `source_type` STRING COMMENT 'Mode of transportation or delivery method by which the feedstock arrived at the facility.. Valid values are `Pipeline|Vessel|Truck|Rail|Storage Transfer`',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Sulfur content of the feedstock measured in parts per million at receipt, critical for processing unit selection and environmental compliance.',
    `tan_value` DECIMAL(18,2) COMMENT 'Total Acid Number measurement indicating the acidity level of the feedstock, important for corrosion management and processing unit compatibility.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the feedstock at the time of receipt measurement in degrees Celsius.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'Total cost amount for this feedstock receipt transaction including base price, transportation charges, and any applicable fees.',
    `unit_cost_per_boe` DECIMAL(18,2) COMMENT 'Cost per barrel of oil equivalent paid for this feedstock receipt, used for inventory valuation and cost accounting.',
    `volume_received_boe` DECIMAL(18,2) COMMENT 'Total volume of feedstock received expressed in barrels of oil equivalent for standardized measurement and reporting.',
    `volume_received_mmcfd` DECIMAL(18,2) COMMENT 'Total volume of gaseous feedstock received expressed in million cubic feet per day, applicable for natural gas and NGL receipts.',
    `water_content_percent` DECIMAL(18,2) COMMENT 'Percentage of water content in the feedstock, measured to determine net hydrocarbon volume and processing requirements.',
    CONSTRAINT pk_feedstock_receipt PRIMARY KEY(`feedstock_receipt_id`)
) COMMENT 'Transactional record capturing each feedstock delivery or receipt event at a petrochemical plant, including receipt date and time, feedstock type, volume received in BOE or MMCFD, source pipeline or vessel, quality assay results at receipt (sulfur, TAN, density, composition), custody transfer point, and acceptance or rejection status. Supports feedstock inventory reconciliation and quality compliance tracking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` (
    `feedstock_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each feedstock allocation record in the petrochemical plant. Serves as the primary key for this transactional entity. Entity role: TRANSACTION_HEADER — governs receipt, planned allocation, and actual consumption of feedstock volumes at a petrochemical conversion unit for a defined operating period.',
    `commercial_term_contract_id` BIGINT COMMENT 'Identifier of the feedstock supply contract or purchase agreement governing the delivery terms, pricing, and volume commitments for this allocation. Links to the contract master.',
    `conversion_unit_id` BIGINT COMMENT 'Identifier of the specific petrochemical conversion unit (e.g., NGL fractionator, cracker, polymerization reactor, GTL unit) to which the feedstock is allocated for the operating period. Links to the conversion unit master record.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the SAP CO cost center to which feedstock consumption costs are charged for the operating period. Enables plant-level OPEX (Operating Expenditure) allocation and financial reporting per COPAS and IFRS/GAAP oil and gas accounting standards.',
    `crude_assay_id` BIGINT COMMENT 'Foreign key linking to refining.crude_assay. Business justification: Integrated facilities allocate refinery streams (naphtha, gas oil) to petrochemical units. Linking to crude_assay enables petrochemical planners to access detailed compositional data (API, sulfur, dis',
    `crude_grade_id` BIGINT COMMENT 'Foreign key linking to product.crude_grade. Business justification: Feedstock allocation optimization requires crude grade assay data for yield prediction, unit compatibility assessment, and sulfur/TAN constraint management. Links allocation decisions to crude grade s',
    `drilling_well_id` BIGINT COMMENT 'Foreign key linking to drilling.drilling_well. Business justification: Feedstock allocation records track which specific wells supplied gas/NGLs to conversion units. Required for: production accounting, royalty calculations, feedstock quality traceability, and integrated',
    `feedstock_id` BIGINT COMMENT 'Identifier of the feedstock material (e.g., NGL, ethane, naphtha, propane, LPG, natural gas condensate) being allocated. Links to the material master in SAP MM for feedstock specification and quality standards.',
    `feedstock_receipt_id` BIGINT COMMENT 'Foreign key linking to petrochemical.feedstock_receipt. Business justification: Feedstock allocation records track which receipt(s) the allocated feedstock came from, enabling traceability from receipt through allocation to consumption. Cardinality: N:1 (many allocations can draw',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Feedstock for capital projects (commissioning runs, performance tests) is charged to AFE for project cost tracking and capitalization.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Feedstock costs post to GL accounts (inventory, COGS, WIP) for financial statement preparation and inventory valuation.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Feedstock sourced from jointly-owned upstream assets or allocated under PSA cost recovery rules must reference governing JOA for proper cost attribution, partner billing, and cost recovery ceiling cal',
    `optimization_run_id` BIGINT COMMENT 'Reference identifier of the Aspen HYSYS linear programming or optimization model run that generated the planned allocation volumes for this record. Provides auditability of the optimization basis and enables re-run comparison. Null when allocation_basis is manual or contractual.',
    `pipeline_batch_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_batch. Business justification: Feedstock delivered to petrochemical plants via pipeline is tracked as batches with injection/delivery timestamps and quality specifications. Links supply allocation to physical pipeline movements for',
    `plant_id` BIGINT COMMENT 'Identifier of the petrochemical plant or facility where the feedstock is received and consumed. Serves as the PARTY_REFERENCE category for this TRANSACTION_HEADER entity, linking to the plant master. Used for plant-level OPEX reporting and EPA environmental compliance.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to petrochemical.production_order. Business justification: Feedstock is allocated to production orders for manufacturing execution. The sap_production_order attribute on feedstock_allocation is a business reference that should be normalized to a FK relationsh',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Feedstock costs are allocated to profit centers for margin calculation and profitability analysis. Enables unit economics and transfer pricing.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Feedstock allocation planning in integrated operations requires linking planned petrochemical plant feed volumes to specific reservoir production forecasts for supply-demand balancing, contract nomina',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: When allocating feedstock to conversion units, tracking the originating lease supports accurate cost accounting (lease-specific feedstock costs vary by royalty burden and transportation), feedstock qu',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Facility-level feedstock sourcing for allocation purposes. Supports integrated operations where production facilities supply petrochemical plants, enabling facility-to-plant cost allocation, throughpu',
    `production_well_id` BIGINT COMMENT 'Foreign key linking to production.production_well. Business justification: Feedstock allocation records distribute received volumes to conversion units and track originating production wells for cost allocation, working interest calculations, and regulatory reporting. Enable',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Feedstock cost allocations are material financial transactions affecting COGS and inventory valuation, subject to SOX controls. Links allocations to applicable SOX controls for testing, documentation,',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Feedstock costs for projects settle to WBS elements for detailed project accounting and cost capitalization.',
    `acceptance_status` STRING COMMENT 'Quality control acceptance decision for the received feedstock batch. accepted indicates the feedstock meets all specification limits; conditionally_accepted indicates minor deviations within tolerance; rejected indicates the batch fails quality specifications and cannot be processed; pending_qc indicates laboratory analysis is in progress.. Valid values are `accepted|conditionally_accepted|rejected|pending_qc`',
    `actual_volume` DECIMAL(18,2) COMMENT 'Actual volume of feedstock consumed by the conversion unit during the operating period, as recorded from OSIsoft PI System historian or SAP PP goods issue. Compared against planned_volume to compute variance. Null until the period is closed and actuals are confirmed.',
    `allocation_basis` STRING COMMENT 'Method or basis used to determine the feedstock allocation quantity for this record. optimization_model indicates the volume was derived from Aspen HYSYS linear programming output; manual indicates a planner override; contractual indicates volume is fixed by supply contract; proportional indicates pro-rata split across units; operator_override indicates a real-time field adjustment.. Valid values are `optimization_model|manual|contractual|proportional|operator_override`',
    `allocation_date` DATE COMMENT 'The principal business event date on which the feedstock allocation was formally issued or activated for the operating period. Serves as the BUSINESS_EVENT_TIMESTAMP category for this TRANSACTION_HEADER entity. Distinct from receipt date and audit timestamps.',
    `allocation_number` STRING COMMENT 'Externally-known business identifier for the feedstock allocation record, used in SAP PP production orders and cross-system references. Follows the format FA-YYYY-NNNNNN. Serves as the BUSINESS_IDENTIFIER category for this TRANSACTION_HEADER entity.. Valid values are `^FA-[0-9]{4}-[0-9]{6}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the feedstock allocation record, tracking progression from initial planning through approval, active consumption, and final closure. Serves as the LIFECYCLE_STATUS category for this TRANSACTION_HEADER entity.. Valid values are `draft|planned|approved|active|completed|cancelled`',
    `approval_status` STRING COMMENT 'Workflow approval status for the feedstock allocation record. pending indicates awaiting review; approved indicates authorized for execution; rejected indicates returned for revision; escalated indicates referred to senior authority. Required for SOX internal controls compliance over production cost authorization.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'User ID or employee identifier of the person who approved this feedstock allocation in the workflow system. Required for SOX audit trail and authorization controls. Populated when approval_status transitions to approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the feedstock allocation was formally approved in the workflow system. Provides a distinct lifecycle event timestamp for SOX audit trail, separate from created_timestamp and last_updated_timestamp.',
    `assay_gravity_api` DECIMAL(18,2) COMMENT 'American Petroleum Institute (API) gravity of the received feedstock as measured at receipt, expressed in degrees API. Higher API gravity indicates lighter hydrocarbons. Critical quality parameter for conversion unit feed specifications and yield prediction in Aspen HYSYS process simulation.',
    `assay_h2s_ppm` DECIMAL(18,2) COMMENT 'Hydrogen sulfide (H2S) concentration in the received feedstock measured in parts per million (ppm) by volume. Critical HSE parameter — elevated H2S triggers safety protocols per OSHA 29 CFR 1910.1000 and affects processing unit corrosion management.',
    `assay_heating_value` DECIMAL(18,2) COMMENT 'Gross (higher) heating value of the received feedstock expressed in BTU per standard cubic foot or MJ/kg depending on feedstock type. Used for energy balance calculations, yield optimization in Aspen HYSYS, and billing under BTU-based supply contracts.',
    `assay_sulfur_pct` DECIMAL(18,2) COMMENT 'Sulfur content of the received feedstock expressed as weight percentage (wt%), as determined by laboratory assay at receipt. Drives HDS (Hydrodesulfurization) unit loading, catalyst selection, and EPA emissions compliance for SO2 reporting.',
    `batch_number` STRING COMMENT 'Supplier or internal batch/lot number assigned to the received feedstock consignment. Enables traceability from receipt through processing to finished product for quality management and regulatory recall purposes. Corresponds to SAP MM batch classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedstock allocation record was first created in the system. Serves as the RECORD_AUDIT_CREATED category for this TRANSACTION_HEADER entity. Populated automatically at insert time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code applicable to feedstock_unit_cost and total feedstock cost for this allocation (e.g., USD, EUR, SAR). Required for multi-currency OPEX reporting and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `feedstock_type` STRING COMMENT 'Classification of the feedstock by hydrocarbon type or product category (e.g., NGL — Natural Gas Liquids, LPG — Liquefied Petroleum Gas, naphtha, ethane, propane, condensate). Drives process routing and conversion unit compatibility checks. [ENUM-REF-CANDIDATE: NGL|LPG|naphtha|ethane|propane|condensate|butane|methanol|natural_gas — promote to reference product]. Valid values are `NGL|LPG|naphtha|ethane|propane|condensate`',
    `feedstock_unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of feedstock (per BBL, MT, MMBTU, etc. as defined by volume_uom) applicable to this allocation, sourced from the supply contract or spot market price. Used for OPEX cost calculation and feedstock cost variance analysis. Classified confidential as it reflects commercial pricing terms.',
    `ghg_emission_factor` DECIMAL(18,2) COMMENT 'Greenhouse gas (GHG) emission factor associated with the feedstock type, expressed in kg CO2-equivalent per unit of feedstock consumed (per volume_uom). Used to estimate Scope 1 process emissions from feedstock combustion and conversion for EPA GHG reporting and ESG disclosure.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this feedstock allocation record was most recently modified. Serves as the RECORD_AUDIT_UPDATED category for this TRANSACTION_HEADER entity. Updated on every write operation.',
    `operating_period_end` DATE COMMENT 'End date of the operating period for which this feedstock allocation is valid. Together with operating_period_start, defines the allocation window for planned and actual consumption reconciliation.',
    `operating_period_start` DATE COMMENT 'Start date of the operating period (shift, day, week, or month) for which this feedstock allocation is valid. Used to bound planned vs actual consumption reporting and production planning cycles.',
    `period_close_flag` BOOLEAN COMMENT 'Indicates whether the operating period for this allocation has been formally closed and actuals have been confirmed (True) or the period is still open and actuals may be updated (False). Controls write-lock behavior on actual_volume and total_feedstock_cost fields.',
    `planned_volume` DECIMAL(18,2) COMMENT 'Planned volume of feedstock allocated to the conversion unit for the operating period, as determined by the production plan or optimization model output. Expressed in the unit of measure defined by volume_uom. Serves as the QUANTITATIVE_RESULT baseline for variance analysis.',
    `receipt_date` DATE COMMENT 'Date on which the feedstock was physically received at the plant from the source pipeline, vessel, or storage facility. Captures the inbound receipt event timestamp for inventory and supply chain reconciliation.',
    `received_volume` DECIMAL(18,2) COMMENT 'Gross volume of feedstock received at the plant gate from the source, measured at standard conditions. Expressed in volume_uom. May differ from planned_volume due to delivery shortfalls, measurement corrections, or quality-based rejections. Used for custody transfer reconciliation.',
    `remarks` STRING COMMENT 'Free-text field for planners or operators to record notes, justifications for manual overrides, quality deviation explanations, or other contextual information relevant to this feedstock allocation record. Not used for structured data.',
    `source_identifier` STRING COMMENT 'Name or code of the specific pipeline, vessel, storage tank, or transport unit from which the feedstock was received (e.g., pipeline segment ID, vessel IMO number, tank tag number). Provides traceability from source to plant for quality and custody transfer purposes.',
    `source_type` STRING COMMENT 'Mode or infrastructure type through which the feedstock was delivered to the plant. Distinguishes pipeline deliveries (continuous), vessel/FPSO deliveries (batch), storage tank transfers (internal), rail, or truck. Drives logistics cost allocation and supply chain analytics.. Valid values are `pipeline|vessel|storage_tank|rail|truck`',
    `total_feedstock_cost` DECIMAL(18,2) COMMENT 'Total cost of feedstock consumed during the operating period, calculated as actual_volume multiplied by feedstock_unit_cost in the currency defined by currency_code. Populated after period close. Used for plant-level OPEX reporting, LOE (Lease Operating Expense) analysis, and EBITDA calculation.',
    `variance_pct` DECIMAL(18,2) COMMENT 'Volume variance expressed as a percentage of planned volume ((actual - planned) / planned × 100). Enables normalized comparison of allocation performance across units and periods regardless of absolute volume scale. Populated after period close.',
    `volume_uom` STRING COMMENT 'Unit of measure for planned and actual feedstock volumes. Common units include BBL (barrels), MMBTU (million British thermal units), MT (metric tonnes), MCF (thousand cubic feet), MMCF (million cubic feet), KG (kilograms), LT (long tonnes). Must be consistent across planned_volume and actual_volume for valid variance calculation. [ENUM-REF-CANDIDATE: BBL|MMBTU|MT|MCF|MMCF|KG|LT — 7 candidates stripped; promote to reference product]',
    `volume_variance` DECIMAL(18,2) COMMENT 'Arithmetic difference between actual_volume and planned_volume (actual minus planned) in the unit defined by volume_uom. A positive value indicates over-consumption; a negative value indicates under-consumption. Populated after period close when actuals are confirmed. Used for production efficiency and OPEX variance reporting.',
    CONSTRAINT pk_feedstock_allocation PRIMARY KEY(`feedstock_allocation_id`)
) COMMENT 'Transactional record governing the receipt, planned allocation, and actual consumption of feedstock volumes at petrochemical plants. Captures both inbound receipt events (delivery date, source pipeline/vessel, quality assay at receipt, acceptance status) and downstream allocation to specific conversion units for a given operating period. Tracks planned vs actual volume consumed, allocation basis (optimization model or manual), variance from plan, and approval status. Integrates with SAP PP production planning and Aspen HYSYS optimization outputs.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` (
    `unit_run_record_id` BIGINT COMMENT 'Unique surrogate identifier for each unit run record entry in the petrochemical conversion unit operating log. Primary key for the silver layer lakehouse table. Entity role: TRANSACTION_HEADER.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific petrochemical conversion unit (e.g., FCC unit, steam cracker, NGL fractionator, CDU, VDU, HDS unit, polymerization reactor) for which this run record is captured. Links to the asset/equipment master in Maximo Asset Management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Run records generate operating costs (energy, catalyst, labor) allocated to cost centers for budget variance analysis and cost control.',
    `employee_id` BIGINT COMMENT 'Reference to the process operator or shift supervisor responsible for this unit run record. Serves as the PARTY_REFERENCE for this transaction. Links to the workforce/employee master. Used for accountability, training compliance, and HSE incident correlation.',
    `feedstock_id` BIGINT COMMENT 'Foreign key linking to petrochemical.feedstock. Business justification: Unit run records track which feedstock was processed during the run. The feedstock_type attribute on unit_run_record is redundant and should be retrieved via JOIN to feedstock.feedstock_type. Cardinal',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant or facility where the conversion unit is located. Links to the plant master for geographic, organizational, and regulatory context. Sourced from SAP PP plant master.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to petrochemical.production_order. Business justification: Unit run records are typically executed under a SAP PP production order. The sap_production_order attribute on unit_run_record is a business reference that should be normalized to a FK relationship. C',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Run records drive profit center production volumes and margins. Required for P&L reporting and unit economics analysis.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Unit run records during turnaround periods should reference the turnaround event for performance analysis and cost allocation. Cardinality: N:1 (many runs during same turnaround). Nullable: YES (most ',
    `approved_by` STRING COMMENT 'Name or employee identifier of the supervisor or engineer who approved and validated this unit run record. Required for data governance, audit trail, and SOX financial controls compliance where production data feeds into financial reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this unit run record was approved and validated by the responsible supervisor or engineer. Part of the record lifecycle audit trail. Required for SOX compliance and data governance controls.',
    `avg_operating_pressure_kpa` DECIMAL(18,2) COMMENT 'Average operating pressure of the conversion unit during the run period, expressed in kilopascals (kPa). Sourced from DCS/SCADA pressure transmitters via OSIsoft PI System historian. Key process variable for reaction kinetics, separation efficiency, and equipment integrity management.',
    `avg_operating_temp_c` DECIMAL(18,2) COMMENT 'Average operating temperature of the conversion unit during the run period, expressed in degrees Celsius. Sourced from DCS/SCADA thermocouple readings via OSIsoft PI System historian. Critical process variable for conversion rate optimization, catalyst performance, and product yield management.',
    `btx_yield_bbl` DECIMAL(18,2) COMMENT 'Combined volume of BTX aromatics (Benzene, Toluene, and Xylene) produced during the run period, expressed in barrels. BTX is a high-value petrochemical product slate from reforming and cracking units. Used for yield accounting and specialty chemical production planning.',
    `catalyst_activity_pct` DECIMAL(18,2) COMMENT 'Relative activity level of the process catalyst as a percentage of fresh catalyst baseline activity, measured during the run period. Declining catalyst activity indicates deactivation and triggers regeneration or replacement decisions. Critical for FCC, HDS, and reforming unit performance management.',
    `catalyst_addition_kg` DECIMAL(18,2) COMMENT 'Mass of fresh catalyst added to the conversion unit during the run period, expressed in kilograms. Tracks catalyst consumption rate for inventory management, cost accounting, and performance optimization. Relevant for continuous catalyst addition systems in FCC units.',
    `conversion_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of feedstock converted to desired products during the run period, expressed as a decimal percentage (e.g., 72.500 = 72.5%). Calculated from product yield measurements and mass balance data. Core KPI for unit performance benchmarking against design basis and Aspen HYSYS simulation targets.',
    `cooling_water_consumption_m3` DECIMAL(18,2) COMMENT 'Volume of cooling water consumed by the conversion unit during the run period, expressed in cubic metres. Used for water intensity benchmarking, utility cost allocation, and environmental compliance reporting under EPA and ISO 14001 standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this unit run record was first created in the system, either by automated DCS/SCADA ingestion via OSIsoft PI System or by manual data entry. Mandatory audit field for data lineage and silver layer record provenance.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total hours the conversion unit was not in production during the run period, including both planned maintenance downtime and unplanned outages. Combined with on_stream_hours to reconcile the full run period duration. Feeds into reliability and availability KPI calculations.',
    `downtime_reason_code` STRING COMMENT 'Standardized code classifying the primary reason for unit downtime during the run period. Used for reliability analysis, maintenance planning, and production loss accounting. Sourced from Maximo work order classification and DCS alarm logs. [ENUM-REF-CANDIDATE: PLANNED_MAINT|UNPLANNED_OUTAGE|FEEDSTOCK_SHORTAGE|UTILITY_FAILURE|PROCESS_UPSET|HSE_SHUTDOWN|TURNAROUND|OTHER — 8 candidates stripped; promote to reference product]',
    `energy_intensity_boe` DECIMAL(18,2) COMMENT 'Energy consumed per barrel of feedstock processed, expressed in Barrel of Oil Equivalent (BOE) per barrel of feed. Calculated from total utility consumption (fuel gas, steam, power) normalized to feed throughput. Key energy efficiency KPI for benchmarking against industry standards and ISO 50001 targets.',
    `ethylene_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of ethylene produced during the run period, expressed in barrels (or barrel equivalent). Primary high-value product from steam cracking and FCC operations. Used for product yield accounting, revenue attribution, and performance benchmarking against Aspen HYSYS simulation targets.',
    `feed_rate_bopd` DECIMAL(18,2) COMMENT 'Volumetric feed rate of the primary feedstock to the conversion unit, expressed in Barrels of Oil Per Day (BOPD). For gas-phase units, this may be converted from MMCFD. Sourced from DCS/SCADA flow meters and validated against OSIsoft PI System historian tags. Core input for mass balance and yield calculations.',
    `feed_rate_mmcfd` DECIMAL(18,2) COMMENT 'Volumetric feed rate of the primary feedstock expressed in Million Cubic Feet per Day (MMCFD), applicable for gas-phase conversion units such as NGL fractionators, GTL units, and gas crackers. Null for liquid-phase units where feed_rate_bopd is the primary measure.',
    `feedstock_quality_api` DECIMAL(18,2) COMMENT 'American Petroleum Institute (API) gravity of the feedstock processed during this run period. Higher API gravity indicates lighter crude or condensate feedstock. Used for yield prediction, product quality forecasting, and feedstock valuation. Sourced from laboratory analysis or inline density meters.',
    `flare_volume_mmcfd` DECIMAL(18,2) COMMENT 'Volume of gas flared from the conversion unit during the run period, expressed in MMCFD. Mandatory environmental reporting metric under EPA 40 CFR Part 60 Subpart Ja and BSEE regulations. Used for GHG emissions calculations, ESG reporting, and flare minimization program tracking.',
    `fuel_gas_consumption_mmcfd` DECIMAL(18,2) COMMENT 'Volume of fuel gas consumed by the conversion unit for process heating, furnaces, and fired heaters during the run period, expressed in MMCFD. Key utility consumption metric for energy intensity calculations, OPEX allocation, and GHG emissions reporting under EPA 40 CFR Part 98.',
    `ghg_emissions_co2e_mt` DECIMAL(18,2) COMMENT 'Total Greenhouse Gas (GHG) emissions from the conversion unit during the run period, expressed in metric tonnes of CO2 equivalent (CO2e). Calculated from fuel gas consumption, flaring, and process vents per EPA 40 CFR Part 98 methodology. Required for EPA mandatory GHG reporting and ESG disclosures.',
    `hysys_simulation_case` STRING COMMENT 'Reference identifier for the Aspen HYSYS process simulation case used as the design basis or optimization target for this unit run record. Enables comparison of actual operating performance against simulation predictions for yield gap analysis and process optimization.',
    `lpg_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of Liquefied Petroleum Gas (LPG) — primarily propane and butane fractions — produced during the run period, expressed in barrels. Tracked separately from ethylene and propylene for product slate management, storage planning, and marketing allocation.',
    `mass_balance_closure_pct` DECIMAL(18,2) COMMENT 'Percentage closure of the mass balance for the run period, calculated as (total measured outputs / total measured inputs) × 100. Values near 100% indicate accurate measurement and minimal unaccounted losses. Deviations trigger investigation per API MPMS Chapter 20 loss control procedures. SSOT for yield accounting reconciliation.',
    `ngl_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of Natural Gas Liquids (NGL) recovered during the run period from NGL fractionation or gas processing units, expressed in barrels. Includes ethane, propane, butane, and natural gasoline fractions. Used for NGL product accounting and fractionation performance tracking.',
    `npt_hours` DECIMAL(18,2) COMMENT 'Hours of Non-Productive Time (NPT) during the run period — time when the unit was available but not producing at design capacity due to operational inefficiencies, process upsets, or waiting time. Distinct from planned downtime. Used for operational efficiency analysis and OPEX benchmarking.',
    `on_stream_hours` DECIMAL(18,2) COMMENT 'Number of hours the conversion unit was in active production during the run period. Used to calculate on-stream factor (availability) and to normalize throughput and yield data for performance benchmarking. Excludes planned and unplanned downtime hours.',
    `pi_tag_reference` STRING COMMENT 'Comma-separated list or reference string of OSIsoft PI System historian tag identifiers associated with this unit run record. Enables direct traceability from the silver layer record back to the real-time process data source for audit, reconciliation, and data lineage purposes.',
    `power_consumption_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by the conversion unit during the run period, expressed in megawatt hours (MWh). Includes compressors, pumps, and auxiliary equipment. Used for energy intensity calculations, OPEX allocation, and ESG/GHG reporting.',
    `propylene_yield_bbl` DECIMAL(18,2) COMMENT 'Volume of propylene produced during the run period, expressed in barrels. Key petrochemical product from FCC and steam cracking units. Used for yield accounting, polymerization feedstock planning, and LPG product slate management.',
    `record_period_type` STRING COMMENT 'Granularity of the operating period captured in this run record. Daily records aggregate a full 24-hour period; shift records cover a single operating shift (typically 8 or 12 hours); hourly records are used for high-frequency process monitoring. Drives aggregation logic in yield accounting.. Valid values are `daily|shift|hourly|weekly`',
    `run_date` DATE COMMENT 'Calendar date of the operating period for this unit run record. Used as the primary date dimension key for daily production reporting, yield accounting, and OPEX allocation. For shift-level records, this is the date of the shift start.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the end of the operating period (shift or day) for this unit run record. Combined with run_start_timestamp to define the exact operating window for throughput, yield, and utility consumption calculations.',
    `run_record_number` STRING COMMENT 'Externally-known business identifier for the unit run record, typically generated by the DCS/SCADA or Aspen HYSYS process historian. Format: URR-{UNIT_CODE}-{YYYYMMDD}-{SEQUENCE}. Used for cross-system reconciliation with OSIsoft PI System and SAP PP production orders.. Valid values are `^URR-[A-Z0-9]{3,10}-[0-9]{8}-[0-9]{3,6}$`',
    `run_start_timestamp` TIMESTAMP COMMENT 'Principal real-world event timestamp marking the start of the operating period (shift or day) for this unit run record. Sourced from DCS/SCADA or OSIsoft PI System historian. Used as the primary business event time for performance trending and yield accounting.',
    `run_status` STRING COMMENT 'Current workflow lifecycle state of the unit run record. Draft indicates data entry in progress; submitted indicates pending supervisor review; approved indicates validated and accepted for yield accounting; rejected indicates returned for correction; closed indicates finalized and locked for reporting.. Valid values are `draft|submitted|approved|rejected|closed`',
    `shift_code` STRING COMMENT 'Identifies the operating shift during which this run record was captured (e.g., A, B, C, D for rotating shifts, or DAY/NIGHT for two-shift operations). Null for daily aggregate records. Used for shift-level performance benchmarking and crew accountability.. Valid values are `A|B|C|D|DAY|NIGHT`',
    `steam_consumption_mt` DECIMAL(18,2) COMMENT 'Mass of steam consumed by the conversion unit during the run period, expressed in metric tonnes. Includes process steam, stripping steam, and utility steam. Used for energy intensity benchmarking, utility cost allocation, and plant-level OPEX reporting.',
    `unaccounted_loss_bbl` DECIMAL(18,2) COMMENT 'Volume of feedstock or product that cannot be accounted for in the mass balance, expressed in barrels. Represents the difference between metered inputs and measured outputs after all known losses (flaring, sampling, drains) are accounted for. Triggers loss investigation when exceeding threshold. Reported to EPA for emissions compliance.',
    `unit_type` STRING COMMENT 'Classification of the petrochemical conversion unit technology. Examples include FCC (Fluid Catalytic Cracking), CDU (Crude Distillation Unit), VDU (Vacuum Distillation Unit), HDS (Hydrodesulfurization), NGL fractionator, steam cracker, GTL (Gas to Liquids), polymerization reactor, BTX extraction unit, LPG splitter. [ENUM-REF-CANDIDATE: FCC|CDU|VDU|HDS|NGL_FRACTIONATOR|STEAM_CRACKER|GTL|POLYMERIZATION|BTX_EXTRACTION|LPG_SPLITTER — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this unit run record, including data corrections, resubmissions, or approval status changes. Used for incremental data pipeline processing in the Databricks lakehouse silver layer and audit trail maintenance.',
    CONSTRAINT pk_unit_run_record PRIMARY KEY(`unit_run_record_id`)
) COMMENT 'Transactional daily or shift-level operating record for each conversion unit capturing throughput (BOPD or MMCFD), feed rate, operating temperature, pressure, conversion rate, product yield by fraction (ethylene, propylene, BTX, LPG, etc.), utility consumption (steam, power, cooling water, fuel gas), mass balance closure percentage, unaccounted losses, and key process variables from DCS/SCADA. Integrates with OSIsoft PI System historian for real-time data ingestion. Serves as the SSOT for unit performance, yield accounting, energy intensity, and mass balance reconciliation within the petrochemical domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` (
    `petrochemical_yield_record_id` BIGINT COMMENT 'Unique surrogate identifier for each yield record transaction in the petrochemical conversion unit run period. Primary key for the yield_record data product in the Databricks Silver Layer.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the petrochemical conversion unit (e.g., steam cracker, FCC unit, NGL fractionator, polymerization reactor) that produced this yield record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield performance impacts cost center efficiency metrics and variance analysis. Enables cost-per-unit tracking and benchmarking.',
    `employee_id` BIGINT COMMENT 'Reference to the production engineer responsible for validating and approving this yield record. Satisfies the PARTY_REFERENCE requirement for this transaction entity.',
    `feedstock_id` BIGINT COMMENT 'Reference to the primary feedstock material (e.g., naphtha, ethane, propane, LPG, gas oil) processed during this run period. Drives feedstock allocation and yield optimization analysis.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Yield records track production of petroleum products (ethylene, propylene, benzene, toluene, xylene) requiring petroleum_product reference for production accounting, inventory valuation, margin analys',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant or facility where the conversion unit is located. Supports plant-level OPEX aggregation and multi-site reporting.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to petrochemical.production_order. Business justification: Yield records are captured for production orders to track actual vs. planned yields. The sap_production_order_number attribute on yield_record is a business reference that should be normalized to a FK',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Yield drives profit center margin realization. Higher yields improve profitability; yield variance analysis is core to petrochemical margin management.',
    `run_period_id` BIGINT COMMENT 'Reference to the conversion unit run period during which this yield was recorded. Links to the operational run period master for scheduling and planning reconciliation.',
    `simulation_run_id` BIGINT COMMENT 'Identifier of the Aspen HYSYS simulation run that generated the planned yield targets for this record. Enables traceability between actual production outcomes and simulation model predictions for model calibration.',
    `unit_run_record_id` BIGINT COMMENT 'Foreign key linking to petrochemical.unit_run_record. Business justification: Yield records are captured FOR specific unit run periods, tracking product yields by fraction for each run. The run_period_id attribute on yield_record is semantically equivalent to unit_run_record_id',
    `actual_yield_pct` DECIMAL(18,2) COMMENT 'Actual overall product yield achieved as a percentage of feedstock charged during the run period. Sourced from OSIsoft PI System historian and laboratory analysis.',
    `benzene_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of benzene produced during the run period in metric tonnes. Aromatic compound used in styrene, cumene, and cyclohexane production. Subject to EPA MACT standards.',
    `butadiene_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of butadiene (1,3-butadiene) produced during the run period in metric tonnes. Synthetic rubber precursor recovered from C4 fraction of steam cracker output.',
    `catalyst_age_days` STRING COMMENT 'Number of days the current catalyst batch has been in service at the start of this run period. Used to model catalyst deactivation curves and predict yield decline in Aspen HYSYS simulations.',
    `catalyst_batch_number` STRING COMMENT 'Identifier for the catalyst batch loaded in the conversion unit during this run period. Enables correlation of catalyst age, activity, and selectivity with yield performance for catalyst lifecycle management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this yield record was first created in the system. Audit trail field for data lineage and SOX compliance.',
    `energy_consumption_gj` DECIMAL(18,2) COMMENT 'Total energy consumed by the conversion unit during the run period in gigajoules. Includes steam, electricity, and fuel gas consumption. Key input for energy intensity KPIs and EPA GHG emissions reporting.',
    `ethylene_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of ethylene produced during the run period in metric tonnes. Primary high-value olefin product from steam cracking operations. Tracked against Aspen HYSYS simulation targets.',
    `feedstock_volume_mt` DECIMAL(18,2) COMMENT 'Total mass of feedstock charged to the conversion unit during the run period, expressed in metric tonnes. Denominator for yield percentage calculations and mass balance closure.',
    `fuel_oil_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of fuel oil (heavy residue) produced during the run period in metric tonnes. Represents the bottom-of-barrel fraction; used as plant fuel or sold as bunker fuel.',
    `ghg_emissions_co2e_mt` DECIMAL(18,2) COMMENT 'Total Greenhouse Gas (GHG) emissions from the conversion unit during the run period expressed in metric tonnes of CO2 equivalent. Mandatory for EPA 40 CFR Part 98 Subpart X reporting and ESG disclosure.',
    `gor_equivalent` DECIMAL(18,2) COMMENT 'Gas-Oil Ratio (GOR) equivalent for the conversion unit run, expressed as standard cubic feet of gas per barrel of liquid product. Provides cross-domain comparability with upstream production metrics and supports BOE reporting.',
    `lab_analysis_number` STRING COMMENT 'Reference number of the laboratory analysis report confirming product quality and composition for this run period. Provides traceability to LIMS (Laboratory Information Management System) records for ISO 9001 compliance.',
    `lpg_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of Liquefied Petroleum Gas (LPG) — primarily propane and butane mix — produced during the run period in metric tonnes. Recovered from NGL fractionation or cracker C3/C4 streams.',
    `mass_balance_closure_pct` DECIMAL(18,2) COMMENT 'Percentage representing how closely total product outputs match total feedstock inputs on a mass basis (outputs / inputs × 100). Values near 100% indicate accurate measurement; deviations trigger investigation per API MPMS standards. Critical for EPA emissions reconciliation.',
    `naphtha_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of naphtha fraction produced during the run period in metric tonnes. May be recycled as cracker feedstock or sold as gasoline blendstock.',
    `npt_hours` DECIMAL(18,2) COMMENT 'Total Non-Productive Time (NPT) in hours during the run period due to unplanned shutdowns, equipment failures, or process upsets. Impacts yield totals and is tracked for reliability improvement programs.',
    `on_stream_factor_pct` DECIMAL(18,2) COMMENT 'Percentage of the run period during which the conversion unit was actively processing feedstock (on-stream hours / total run hours × 100). Accounts for planned and unplanned downtime within the period.',
    `operating_pressure_kpa` DECIMAL(18,2) COMMENT 'Average operating pressure of the conversion unit during the run period in kilopascals. Critical process parameter for yield optimization and safety compliance; sourced from DCS/SCADA.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Average operating temperature of the conversion unit during the run period in degrees Celsius. Key process variable influencing product selectivity and yield distribution; sourced from OSIsoft PI System historian.',
    `opex_allocated_usd` DECIMAL(18,2) COMMENT 'Plant-level Operating Expenditure (OPEX) allocated to this conversion unit run period in US dollars. Includes energy, catalyst, maintenance, and overhead costs allocated via SAP CO cost center accounting. Used for unit cost of production analysis.',
    `planned_yield_pct` DECIMAL(18,2) COMMENT 'Target overall product yield as a percentage of feedstock charged, derived from Aspen HYSYS process simulation for this run period. Baseline for variance analysis and production planning reconciliation.',
    `propylene_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of propylene produced during the run period in metric tonnes. Key petrochemical intermediate for polypropylene and acrylonitrile production.',
    `quality_grade` STRING COMMENT 'Overall quality classification of the products produced during this run period based on laboratory analysis against ISO and customer specifications. Off-spec or downgraded product impacts revenue realization and triggers quality investigation.. Valid values are `prime|off_spec|downgraded|rejected`',
    `record_number` STRING COMMENT 'Externally-known business identifier for this yield record, formatted as YR-YYYY-NNNNNN. Used for cross-system reconciliation with Aspen HYSYS simulation outputs and SAP PP production orders.. Valid values are `^YR-[0-9]{4}-[0-9]{6}$`',
    `record_status` STRING COMMENT 'Current lifecycle status of the yield record through its approval workflow. Draft indicates initial entry; validated indicates mass balance closure check passed; approved indicates sign-off by production engineer; closed indicates period locked for reporting.. Valid values are `draft|submitted|validated|approved|rejected|closed`',
    `remarks` STRING COMMENT 'Free-text field for production engineer comments on notable events, process deviations, or exceptions during the run period that affected yield performance. Supports root cause analysis and audit review.',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the conversion unit run period in hours, calculated from run start to run end timestamps. Used for throughput rate calculations and OPEX allocation.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion unit run period ended. Used to calculate run duration and annualized yield rates.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the conversion unit run period commenced. Principal business event timestamp for this yield record. Sourced from OSIsoft PI System historian or DCS.',
    `specialty_chemical_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of specialty chemical products (e.g., solvents, monomers, intermediates not classified in standard fractions) produced during the run period in metric tonnes.',
    `toluene_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of toluene produced during the run period in metric tonnes. Aromatic solvent and chemical intermediate; may be hydrodealkylated to benzene or used in TDI production.',
    `unit_type` STRING COMMENT 'Classification of the petrochemical conversion unit technology. Determines applicable yield fractions, simulation models, and EPA emissions reporting requirements. [ENUM-REF-CANDIDATE: steam_cracker|fcc|ngl_fractionator|polymerization|reformer|gtl|hds|vdu|cdu|specialty — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this yield record. Used for incremental data pipeline processing and audit trail in the Databricks Silver Layer.',
    `xylene_yield_mt` DECIMAL(18,2) COMMENT 'Actual mass of mixed xylenes (ortho, meta, para) produced during the run period in metric tonnes. Para-xylene is the primary feedstock for PTA and PET production.',
    `yield_variance_pct` DECIMAL(18,2) COMMENT 'Difference between actual yield percentage and planned yield percentage (actual minus planned). Negative values indicate underperformance versus Aspen HYSYS simulation targets. Key KPI for yield optimization.',
    CONSTRAINT pk_petrochemical_yield_record PRIMARY KEY(`petrochemical_yield_record_id`)
) COMMENT 'Transactional record capturing actual product yield by fraction for each conversion unit run period, including ethylene, propylene, butadiene, benzene, toluene, xylene, LPG, naphtha, fuel oil, and specialty chemical outputs. Records planned yield targets from Aspen HYSYS simulation, actual achieved yields, yield variance, GOR equivalent, and mass balance closure percentage. Core entity for yield optimization and production planning reconciliation.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` (
    `product_catalog_id` BIGINT COMMENT 'Primary key for product_catalog',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Petrochemical products (ethylene, propylene, benzene, BTX) are petroleum products requiring master catalog linkage for enterprise pricing benchmarks, HS codes, regulatory classification, and SEC repor',
    `plant_id` BIGINT COMMENT 'Identifier of the petrochemical plant or facility where this product is primarily manufactured or processed. Links the product to its production origin for plant-level OPEX allocation, capacity planning, and regulatory reporting. Corresponds to SAP Plant (WERKS) in the Material Master.',
    `product_line_id` BIGINT COMMENT 'Identifier linking this product to its commercial product line or business segment (e.g., Olefins, Aromatics, Polymers, LPG, Specialty Chemicals). Supports product portfolio management, revenue reporting by product line, and SAP CO Profitability Analysis (CO-PA).',
    `api_gravity` DECIMAL(18,2) COMMENT 'API gravity of the petrochemical product expressed in degrees API (°API), applicable to liquid hydrocarbon products such as condensates, naphtha, and GTL products. API gravity is inversely related to density and is used for product classification, pricing, and custody transfer per API MPMS standards.',
    `astm_standard` STRING COMMENT 'ASTM International standard designation applicable to the products quality testing and specification (e.g., ASTM D1835 for LPG, ASTM D4814 for gasoline blendstocks, ASTM D2163 for NGL analysis). Defines the test methods used to verify product quality against specification.',
    `boiling_point_c` DECIMAL(18,2) COMMENT 'Normal boiling point of the petrochemical product at atmospheric pressure expressed in degrees Celsius (°C). Used in process design, distillation column design, storage condition specification, and safety classification for flammable materials.',
    `cas_number` STRING COMMENT 'Unique Chemical Abstracts Service (CAS) Registry Number assigned to the chemical substance by the American Chemical Society. Universally recognized identifier for chemical substances used in regulatory filings (EPA TSCA, REACH), safety data sheets, import/export documentation, and chemical inventory tracking.. Valid values are `^d{2,7}-d{2}-d{1}$`',
    `chemical_formula` STRING COMMENT 'Standard molecular formula of the petrochemical product expressed in Hill notation (e.g., C2H4 for ethylene, C3H6 for propylene, C6H6 for benzene). Used for regulatory reporting, safety data sheets (SDS), and chemical inventory management per EPA and OSHA requirements.',
    `cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost and pricing fields of this petrochemical product (e.g., USD, EUR, SAR). Ensures consistent currency denomination across cost management, financial reporting, and intercompany transactions.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this petrochemical product record was first created in the master catalog. Serves as the RECORD_AUDIT_CREATED field for this MASTER_RESOURCE entity. Used for data lineage, audit trails, and SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Standard density of the petrochemical product at reference conditions (typically 15°C and 1 atm) expressed in kilograms per cubic meter (kg/m³). Critical for volumetric-to-mass conversion in custody transfer, shipping, and inventory management. Used in Aspen HYSYS simulations and API gravity calculations.',
    `discontinuation_date` DATE COMMENT 'Date on which this petrochemical product was or is scheduled to be discontinued from the catalog. Null if the product is currently active. Used for product lifecycle management, customer notification planning, and inventory wind-down.',
    `effective_date` DATE COMMENT 'Date from which this product record is valid and active in the petrochemical product catalog. Used for product lifecycle management, pricing effectivity, and regulatory compliance tracking. Corresponds to SAP Material Master validity date.',
    `feedstock_type` STRING COMMENT 'Primary feedstock or raw material from which this petrochemical product is derived or manufactured. Critical for feedstock allocation planning, cost of production analysis, and supply chain optimization. Supports Aspen HYSYS process simulation and SAP PP production planning. [ENUM-REF-CANDIDATE: naphtha|ethane|propane|butane|NGL|natural_gas|crude_oil|condensate|mixed — promote to reference product]',
    `flash_point_c` DECIMAL(18,2) COMMENT 'Flash point of the petrochemical product expressed in degrees Celsius (°C), representing the lowest temperature at which vapors can ignite. Critical for fire hazard classification, storage and handling requirements, transport classification under PHMSA/IMDG, and HSE risk assessment.',
    `ghg_emission_factor` DECIMAL(18,2) COMMENT 'Greenhouse Gas (GHG) emission factor for this petrochemical product expressed in tonnes of CO2 equivalent per unit of production (tCO2e/MT or tCO2e/BBL). Used for Scope 1 and Scope 3 GHG emissions calculations, ESG reporting, and EPA GHG reporting under 40 CFR Part 98.',
    `hazard_classification` STRING COMMENT 'Primary hazard classification of the petrochemical product under the Globally Harmonized System (GHS) of Classification and Labelling of Chemicals. Drives SDS requirements, packaging and labeling, transport documentation, and HSE risk assessments. [ENUM-REF-CANDIDATE: flammable_gas|flammable_liquid|toxic|corrosive|oxidizer|explosive|non_hazardous|environmental_hazard — promote to reference product]',
    `hs_code` STRING COMMENT 'Harmonized System (HS) tariff classification code assigned to the petrochemical product for international trade, customs declarations, and import/export documentation. Required for cross-border shipments and trade compliance. Typically 6-10 digits depending on jurisdiction.. Valid values are `^d{6,10}$`',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates whether this petrochemical product is classified as a controlled substance under applicable regulations (e.g., DEA Schedule, EPA Section 112(r) RMP threshold substances, OSHA PSM covered chemicals). Triggers additional regulatory controls, reporting obligations, and security requirements.',
    `iso_quality_standard` STRING COMMENT 'ISO quality standard or specification applicable to this petrochemical product (e.g., ISO 9001, ISO 14001, ISO 4626 for solvents). Indicates the quality management framework under which the product is manufactured and certified. Used for customer qualification and regulatory compliance.',
    `iupac_name` STRING COMMENT 'Systematic chemical name assigned according to International Union of Pure and Applied Chemistry (IUPAC) nomenclature rules. Provides an unambiguous scientific identifier for the chemical substance, used in regulatory submissions, patent filings, and technical documentation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this petrochemical product record was most recently modified in the master catalog. Used for change tracking, data synchronization with source systems (SAP MM, Aspen HYSYS), and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Molecular weight of the petrochemical product expressed in grams per mole (g/mol). Used in process engineering calculations, yield optimization, and Aspen HYSYS process simulation for mass balance and thermodynamic modeling. Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE entity.',
    `norm_classification` STRING COMMENT 'Classification indicating whether the petrochemical product or its production process involves Naturally Occurring Radioactive Material (NORM). NORM is commonly associated with NGL fractionation, produced water, and scale deposits in oil and gas processing. Drives waste disposal, worker protection, and regulatory reporting requirements.. Valid values are `NORM_present|NORM_absent|not_assessed`',
    `packaging_type` STRING COMMENT 'Standard packaging or transport mode for the petrochemical product (e.g., bulk pipeline, bulk tanker, ISO container, drum, Intermediate Bulk Container (IBC), bag, pressurized cylinder, railcar). Drives logistics planning, storage requirements, and customer delivery specifications. Corresponds to SAP Handling Unit Management. [ENUM-REF-CANDIDATE: bulk_pipeline|bulk_tanker|ISO_container|drum|IBC|bag|cylinder|railcar — 8 candidates stripped; promote to reference product]',
    `product_category` STRING COMMENT 'High-level classification of the petrochemical product into its primary chemical family or commercial category. Serves as the primary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity. [ENUM-REF-CANDIDATE: olefin|aromatic|polymer|NGL|LPG|GTL|specialty_chemical|solvent|fertilizer|other — promote to reference product]',
    `product_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the petrochemical product across business systems. Corresponds to the SAP Material Number (MATNR) in SAP S/4HANA MM. Used in procurement, sales orders, and production planning. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `product_grade` STRING COMMENT 'Commercial or technical grade designation of the product indicating purity level, specification tier, or application suitability (e.g., polymer grade, chemical grade, fuel grade, food grade, pharmaceutical grade). Drives pricing, customer qualification, and quality control requirements. Corresponds to SAP Material Batch Classification.',
    `product_name` STRING COMMENT 'Full commercial or trade name of the petrochemical product (e.g., Ethylene, Propylene, Polyethylene HD, Benzene, LPG Propane, GTL Naphtha). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity. Used in product catalogs, customer-facing documents, and regulatory filings.',
    `product_status` STRING COMMENT 'Current lifecycle status of the petrochemical product in the master catalog. Indicates whether the product is actively manufactured and sold, discontinued, under regulatory or quality review, in development, or blocked from transactions. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity. Corresponds to SAP Material Status (MMSTA).. Valid values are `active|discontinued|under_review|development|blocked`',
    `product_type` STRING COMMENT 'Operational classification indicating whether the product is a finished product sold to customers, an intermediate used in further processing, a feedstock consumed in conversion units, a by-product, or a co-product of a primary reaction. Supports production planning in SAP PP and Aspen HYSYS process simulation.. Valid values are `finished_product|intermediate|feedstock|by_product|co_product`',
    `production_process` STRING COMMENT 'Primary petrochemical manufacturing or conversion process used to produce this product (e.g., steam cracking for ethylene/propylene, NGL fractionation for LPG/NGL fractions, polymerization for polyethylene/polypropylene, Gas-to-Liquids (GTL) conversion). Supports process simulation in Aspen HYSYS and production planning in SAP PP. [ENUM-REF-CANDIDATE: steam_cracking|catalytic_reforming|NGL_fractionation|polymerization|GTL|FCC|hydrocracking|alkylation|other — promote to reference product]',
    `purity_min_pct` DECIMAL(18,2) COMMENT 'Minimum required purity of the petrochemical product expressed as a percentage (%). Defines the lower bound of the product quality specification for the primary component. Used in quality control, customer contracts, and regulatory compliance. Corresponds to SAP Batch Classification characteristic values.',
    `reach_registration_number` STRING COMMENT 'European Union REACH (Registration, Evaluation, Authorisation and Restriction of Chemicals) registration number assigned by the European Chemicals Agency (ECHA) for substances manufactured or imported into the EU in quantities above 1 tonne per year. Required for EU market access and regulatory compliance.. Valid values are `^d{2}-d{10}-d{2}-d{4}$`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the petrochemical product under applicable environmental and chemical control regulations. Indicates whether the product is listed under EPA TSCA, registered under EU REACH, classified as a Volatile Organic Compound (VOC), Hazardous Air Pollutant (HAP), or controlled substance. Drives compliance reporting obligations.. Valid values are `TSCA_listed|REACH_registered|controlled_substance|VOC|HAP|non_regulated`',
    `sds_document_ref` STRING COMMENT 'Reference number or document management system link to the Safety Data Sheet (SDS) for this petrochemical product, as required by OSHA HazCom Standard and GHS. The SDS contains hazard information, handling instructions, emergency response procedures, and regulatory classification data.',
    `shelf_life_days` STRING COMMENT 'Maximum shelf life of the petrochemical product in days from the date of manufacture, after which the product may no longer meet specification. Applicable to specialty chemicals, polymers, and reactive intermediates. Drives batch expiry management in SAP MM Batch Management and warehouse storage planning.',
    `specification_sheet_ref` STRING COMMENT 'Document reference number or URL pointing to the official product specification sheet (also known as Technical Data Sheet or TDS) that defines the products quality parameters, physical and chemical properties, and acceptance criteria. Used for customer qualification, quality audits, and ISO certification.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per primary unit of measure for this petrochemical product, used for inventory valuation, production cost analysis, and variance reporting in SAP CO. Expressed in the companys functional currency. Confidential business data used for internal cost management and OPEX tracking.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature for the petrochemical product expressed in degrees Celsius (°C). Defines the upper bound of the safe storage temperature range. Critical for preventing thermal decomposition, polymerization inhibitor depletion, or pressure buildup in storage vessels.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature for the petrochemical product expressed in degrees Celsius (°C). Defines the lower bound of the safe storage temperature range. Used for warehouse and tank farm design, HSE risk assessment, and logistics planning for temperature-sensitive products.',
    `sulfur_content_ppm` DECIMAL(18,2) COMMENT 'Sulfur content of the petrochemical product expressed in parts per million (ppm) by weight. Critical quality parameter for fuel products, aromatics, and petrochemical feedstocks. Drives compliance with EPA fuel sulfur standards, EU fuel quality directives, and refinery Hydrodesulfurization (HDS) unit performance monitoring.',
    `tsca_inventory_status` STRING COMMENT 'Status of the petrochemical product on the EPA Toxic Substances Control Act (TSCA) Chemical Substance Inventory. Indicates whether the substance is listed as active, inactive, exempt, or not listed. Active status is required for commercial manufacture or import in the United States.. Valid values are `active|inactive|exempt|not_listed`',
    `un_number` STRING COMMENT 'United Nations (UN) four-digit number assigned to hazardous materials and dangerous goods for transport classification (e.g., UN1075 for LPG, UN1962 for ethylene). Required on shipping documents, labels, and placards for road, rail, sea, and air transport of hazardous petrochemical products.. Valid values are `^UNd{4}$`',
    `uom_alternate` STRING COMMENT 'Alternate unit of measure used for specific business contexts such as customer invoicing, regulatory reporting, or production measurement, when different from the primary UOM. Supports SAP alternate unit of measure conversion in the Material Master. [ENUM-REF-CANDIDATE: MT|KG|BBL|MMBTU|KL|L|M3|LB — 8 candidates stripped; promote to reference product]',
    `uom_primary` STRING COMMENT 'Primary unit of measure used for commercial transactions, inventory management, and production reporting of this petrochemical product (e.g., MT for metric tonnes, BBL for barrels, MMBTU for gas products, KL for kiloliters). Corresponds to SAP Base Unit of Measure (MEINS) in the Material Master. [ENUM-REF-CANDIDATE: MT|KG|BBL|MMBTU|KL|L|M3|LB — 8 candidates stripped; promote to reference product]',
    `voc_content_pct` DECIMAL(18,2) COMMENT 'Volatile Organic Compound (VOC) content of the petrochemical product expressed as a percentage by weight (%). Required for EPA Clean Air Act compliance, state air quality permit conditions, and product labeling under VOC regulations. Relevant for solvents, aromatics, and light hydrocarbon products.',
    CONSTRAINT pk_product_catalog PRIMARY KEY(`product_catalog_id`)
) COMMENT 'Master catalog of petrochemical products manufactured or processed at petrochemical plants, including olefins (ethylene, propylene), aromatics (BTX), polymers (polyethylene, polypropylene), LPG, NGL fractions, GTL products, and specialty chemicals. Captures product name, chemical formula, CAS number, product grade, specification sheet reference, ISO quality standard, packaging type, and regulatory classification. Distinct from the enterprise product catalog — this is the petrochemical-specific product master.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` (
    `quality_assay_id` BIGINT COMMENT 'Unique surrogate identifier for each laboratory quality assay record in the petrochemical domain. Primary key for the quality_assay data product. Entity role: TRANSACTION_HEADER — a discrete business event (lab test) with its own lifecycle, timestamps, party reference, and quantitative result.',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Failed quality tests trigger corrective actions to address root causes (process adjustments, equipment repairs, procedure updates). Links assays to corrective actions for tracking investigation, imple',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: Quality assays are taken at specific conversion units (sample points) to monitor product quality and process performance. Linking assays to conversion units enables unit-level quality trending. Cardin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lab costs and quality control expenses are allocated to cost centers for budget tracking and cost control.',
    `custody_transfer_id` BIGINT COMMENT 'Foreign key linking to logistics.custody_transfer. Business justification: Quality assays at custody transfer points validate product specifications for commercial handover. Required for custody transfer documentation, quality claims resolution, and regulatory compliance (AP',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Quality samples taken from specific equipment for condition monitoring, corrosion tracking, fitness-for-service assessment, and equipment performance trending. Required for RBI programs, equipment int',
    `lab_instrument_equipment_id` BIGINT COMMENT 'Asset tag or equipment identifier of the analytical instrument used to perform the measurement, as registered in Maximo Asset Management (CMMS). Enables instrument-level traceability, calibration status verification, and maintenance correlation.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `original_assay_quality_assay_id` BIGINT COMMENT 'Reference to the original quality_assay record that this retest supersedes, when retest_flag is True. Enables lineage tracking between original and retest results and supports non-conformance root cause analysis.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Quality assays of petrochemical products must reference petroleum_product master for specification compliance verification, custody transfer certification, certificate of quality generation, and regul',
    `pipeline_segment_id` BIGINT COMMENT 'Identifier of the pipeline segment from which the sample was drawn, when the sample point type is pipeline. Supports PHMSA pipeline quality monitoring requirements and product contamination detection.',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant or processing facility where the sample was collected. Links the assay to plant-level OPEX, EPA environmental compliance reporting, and Aspen HYSYS process simulation context.',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory analyst or QC technician responsible for conducting the assay and signing off on results. Supports traceability, competency verification, and ISO/IEC 17025 personnel qualification requirements.',
    `process_unit_id` BIGINT COMMENT 'Identifier of the petrochemical conversion unit (e.g., NGL fractionator, FCC unit, CDU, VDU, HDS unit, cracker) from which the sample was collected at the unit outlet. Links assay results to Aspen HYSYS process simulation models and unit performance KPIs.',
    `product_catalog_id` BIGINT COMMENT 'Reference to the petrochemical product or feedstock being tested, such as LPG, NGL, ethylene, propylene, polyethylene, or specialty chemical. Links to product specification master and SAP PP production order.',
    `production_order_id` BIGINT COMMENT 'Reference to the SAP PP production order under which the sampled batch was manufactured. Enables integration between quality assay results and production planning, cost allocation (OPEX), and yield reporting in SAP S/4HANA.',
    `quality_spec_id` BIGINT COMMENT 'Reference to the applicable product quality specification document that defines the acceptance criteria (spec_min_value, spec_max_value) for this property. Specifications may be internal, customer-contractual, or regulatory.',
    `product_quality_test_id` BIGINT COMMENT 'Foreign key linking to refining.product_quality_test. Business justification: When petrochemical plants receive refinery products as feedstock, they cross-reference refinery quality tests with their own incoming assays for custody transfer validation, quality reconciliation, an',
    `sample_point_id` BIGINT COMMENT 'Reference to the defined sampling location within the plant, such as unit outlet, storage tank nozzle, pipeline tap, or product loading arm. Sampling point determines applicable specification limits and test frequency.',
    `storage_tank_equipment_id` BIGINT COMMENT 'Identifier of the storage tank from which the sample was drawn, when the sample point type is storage_tank. Used for tank quality management, blending decisions, and product segregation in the supply chain.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `waiver_id` BIGINT COMMENT 'Foreign key linking to compliance.waiver. Business justification: Quality deviations from product specifications may require regulatory waivers for product release or continued operation. Quality_assay table tracks waiver_number; FK enables waiver approval workflow ',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the QC supervisor approved the assay results and authorized product release or rejection. Distinct from created_timestamp and updated_timestamp; represents the formal quality gate event in the product release lifecycle.',
    `assay_number` STRING COMMENT 'Externally-known business identifier for the assay, used in laboratory information management systems, certificates of analysis, and product certification documents. Format: QA-{PLANT_CODE}-{YYYYMM} sequence.. Valid values are `^QA-[A-Z0-9]{4,10}-[0-9]{6}$`',
    `assay_status` STRING COMMENT 'Current lifecycle state of the assay record, tracking progression from sample receipt through laboratory analysis, QC review, and final approval or rejection. Drives product release and certification workflows.. Valid values are `pending|in_progress|completed|approved|rejected|voided`',
    `batch_number` STRING COMMENT 'Production batch or lot number of the product or feedstock from which the sample was drawn, as assigned by SAP PP production order management. Links the assay result to a specific manufacturing batch for traceability, recall management, and certificate of analysis issuance.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `calibration_due_date` DATE COMMENT 'Date by which the analytical instrument used for this assay must next be calibrated to maintain measurement traceability. If the assay was performed after the calibration due date, results may be flagged for review and the instrument quarantined.',
    `certificate_of_analysis_number` STRING COMMENT 'Reference number of the Certificate of Analysis (COA) issued to the customer or downstream user upon product release. The COA documents all measured properties and their conformance status. Required for product certification and customer delivery documentation.. Valid values are `^COA-[A-Z0-9]{4,15}-[0-9]{6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quality assay record was first created in the laboratory information management system or data platform. Used for audit trail, data lineage, and SOX compliance.',
    `deviation_value` DECIMAL(18,2) COMMENT 'Calculated difference between the measured_value and the nearest specification limit (spec_min_value or spec_max_value) when the result is out of specification. Positive value indicates magnitude of exceedance; negative indicates margin within spec. Supports SPC and corrective action prioritization.',
    `lab_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius within the laboratory at the time of measurement. Required by certain ASTM/ISO test methods (e.g., viscosity, density) where ambient conditions affect measurement accuracy and must be documented for result validity.',
    `material_type` STRING COMMENT 'Classification of the sampled material as feedstock entering a conversion unit, intermediate in-process stream, finished petrochemical product, utility fluid, or waste stream. Drives applicable specification set and regulatory reporting category.. Valid values are `feedstock|intermediate|finished_product|utility|waste_stream`',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the laboratory measurement for the specified property. Precision to six decimal places accommodates trace-level measurements such as sulfur in ppm and ultra-high-purity polymer specifications. Principal quantitative outcome of the assay transaction.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Expanded measurement uncertainty (U) associated with the measured_value, expressed in the same unit as measurement_unit. Required by ISO/IEC 17025 for accredited laboratory reporting and used in borderline conformance decisions.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measured_value, such as %, ppm, mg KOH/g (TAN), cSt (kinematic viscosity), kg/m3 (density), °C (flash point), or RON (dimensionless index). Must align with the test method standard unit.',
    `pass_fail_status` STRING COMMENT 'Conformance determination for the measured property against the applicable specification limits. Pass indicates the measured value is within spec_min_value and spec_max_value. Conditional pass may apply when a waiver or deviation has been approved. Drives product release, hold, or rework decisions.. Valid values are `pass|fail|conditional_pass|retest_required|inconclusive`',
    `property_name` STRING COMMENT 'Name of the physical or chemical property being measured in this assay record, such as purity percentage, Research Octane Number (RON), sulfur content, kinematic viscosity, density, flash point, Total Acid Number (TAN), or moisture content. One record per property per sample.',
    `remarks` STRING COMMENT 'Free-text field for the analyst or QC supervisor to record observations, anomalies, instrument issues, sample handling notes, or any other contextual information relevant to the assay result. Supports root cause analysis and audit review.',
    `replicate_count` STRING COMMENT 'Number of replicate measurements performed for this property in accordance with the test methods repeatability requirements. Typically 2–3 replicates per ASTM/ISO method. Used to validate reproducibility and calculate standard deviation.',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this assay record is a retest of a previously failed or inconclusive result. True when the assay was triggered by a prior non-conformance, enabling tracking of retest frequency and first-pass yield rates.',
    `sample_condition` STRING COMMENT 'Visual or physical condition of the sample as observed upon receipt in the laboratory. Abnormal conditions such as contamination, phase separation, or off-spec appearance may invalidate results and trigger sample rejection or re-sampling.. Valid values are `normal|degraded|contaminated|phase_separated|off_spec_appearance`',
    `sample_date` DATE COMMENT 'Calendar date on which the physical sample was collected from the sampling point. Principal business event date for the assay, used for production batch correlation, trend analysis, and regulatory reporting.',
    `sample_point_type` STRING COMMENT 'Classification of the physical location from which the sample was drawn. Determines applicable ASTM/ISO sampling method, required sample volume, and chain-of-custody handling procedures. [ENUM-REF-CANDIDATE: unit_outlet|storage_tank|pipeline|loading_arm|feed_inlet|product_header|blending_header — promote to reference product]',
    `sample_time` TIMESTAMP COMMENT 'Precise date and time at which the physical sample was collected, including timezone offset. Required for SCADA/PI System correlation, shift-level production tracking, and SIMOPS safety documentation.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the physical sample collected, expressed in millilitres. Must meet minimum volume requirements specified by the test method. Insufficient sample volume may require re-sampling and can delay product release.',
    `spec_max_value` DECIMAL(18,2) COMMENT 'Upper bound of the product or feedstock specification for the measured property. Used in conjunction with spec_min_value to evaluate conformance. Null when only a minimum limit applies (e.g., RON minimum for gasoline blendstock).',
    `spec_min_value` DECIMAL(18,2) COMMENT 'Lower bound of the product or feedstock specification for the measured property. Used to determine pass/fail status and calculate deviation from specification. Sourced from the applicable product quality specification sheet.',
    `spec_target_value` DECIMAL(18,2) COMMENT 'Optimal or nominal target value for the measured property as defined in the product quality specification or process control plan. Used for process optimization, Aspen HYSYS model calibration, and yield optimization analytics.',
    `test_method_code` STRING COMMENT 'Standardized laboratory test method code used to measure the property, such as ASTM D86 (distillation), ASTM D4052 (density), ASTM D2622 (sulfur by XRF), ISO 3104 (kinematic viscosity), or UOP 539 (TAN). Ensures analytical reproducibility and inter-laboratory comparability.. Valid values are `^(ASTM|ISO|IP|UOP|GPA|EN)[A-Z0-9 /-]{1,20}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quality assay record, including result amendments, status changes, or QC sign-off updates. Supports audit trail and data integrity monitoring.',
    CONSTRAINT pk_quality_assay PRIMARY KEY(`quality_assay_id`)
) COMMENT 'Transactional record capturing laboratory quality assay results for petrochemical products and feedstocks at defined sampling points, including sample date, sample location (unit outlet, storage tank, pipeline), product or feedstock tested, test method (ASTM, ISO), measured properties (purity %, RON, sulfur ppm, viscosity, density, flash point, TAN, moisture content), pass/fail status against specification, and QC analyst sign-off. Supports ISO quality compliance and product certification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`production_order` (
    `production_order_id` BIGINT COMMENT 'Unique surrogate identifier for the SAP PP production order record in the petrochemical domain. Primary key for the silver-layer lakehouse table. Role: TRANSACTION_HEADER.',
    `afe_budget_id` BIGINT COMMENT 'Reference to the SAP CO cost object (production order cost collector) to which all actual costs (material, labor, overhead, utilities) are settled. Enables product cost analysis and OPEX reporting per manufacturing run.',
    `catalyst_record_id` BIGINT COMMENT 'Reference to the active catalyst charge loaded in the conversion unit at the time of the production run. Enables catalyst performance tracking, deactivation monitoring, and regeneration cycle management across production orders.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific petrochemical conversion unit (e.g., NGL fractionator, steam cracker, FCC unit, polymerization reactor, GTL reactor) where the manufacturing run is executed. Supports unit-level performance and OPEX tracking.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `employee_id` BIGINT COMMENT 'Reference to the production planner or scheduler responsible for creating and managing the production order. Used for accountability tracking, workload analysis, and escalation routing in SAP PP.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Production orders execute on specific equipment for work order linkage, equipment utilization tracking, maintenance planning coordination, and asset performance analysis. Required for OEE calculation ',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Production orders for capital projects (new unit commissioning, major modifications) are AFE-controlled for budget authorization and cost tracking.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Production orders in JV-operated plants require JOA context for joint account billing, partner cost allocation, and settlement. Enables proper COPAS billing code assignment and working interest-based ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Production activities must comply with permitted emission limits, throughput caps, and operating conditions. Links production orders to applicable permits for real-time compliance monitoring and permi',
    `plant_id` BIGINT COMMENT 'Foreign key linking to petrochemical.plant. Business justification: Production orders are issued for specific petrochemical plants. The plant_code attribute on production_order is a business reference that should be normalized to a FK relationship. Cardinality: N:1 (m',
    `product_catalog_id` BIGINT COMMENT 'Reference to the primary finished or intermediate petrochemical product (e.g., ethylene, propylene, LPG, polyethylene, BTX aromatics) that the production order is designed to manufacture.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production output drives profit center P&L. Production orders must be assigned to profit centers for margin calculation and performance reporting.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Production orders in make-to-order scenarios are triggered by sales orders. Essential for order fulfillment tracking, production scheduling against customer commitments, and linking manufacturing cost',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Production costing and inventory valuation are SOX-controlled processes for accurate financial reporting. Links production orders to applicable SOX controls for testing, documentation, and audit trail',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Production orders settle to WBS elements for project accounting, enabling cost collection and settlement to fixed assets or profit centers.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time the production run was completed and goods receipt posted. Captured from SAP PP order confirmation. Used for cycle time analysis, throughput reporting, and cost settlement.',
    `actual_feedstock_qty` DECIMAL(18,2) COMMENT 'Actual quantity of primary feedstock consumed during the production run as confirmed in SAP PP goods issue. Used for feedstock yield calculation, material variance reporting, and OPEX cost tracking.',
    `actual_output_qty` DECIMAL(18,2) COMMENT 'Actual quantity of the primary finished product produced and confirmed via goods receipt in SAP PP. Used for yield variance analysis, production reporting, and inventory reconciliation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time the production run commenced at the conversion unit. Captured from SAP PP order confirmation or OSIsoft PI System SCADA integration. Used for schedule adherence and OEE analysis.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'Total actual cost accumulated on the production order in the controlling area currency, including actual material consumption, confirmed activity costs, and overhead absorption. Used for product cost analysis and OPEX reporting.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure number linking the production order to an approved CAPEX project budget when the run involves capital-linked activities (e.g., catalyst changeout, unit commissioning, major turnaround). Null for routine OPEX production runs.. Valid values are `^AFE-[A-Z0-9]{4,20}$`',
    `batch_number` STRING COMMENT 'SAP batch number assigned to the output product lot produced by this order. Enables batch traceability, quality inspection lot linkage, and product genealogy tracking from feedstock to finished product.',
    `bill_of_materials_number` STRING COMMENT 'SAP Bill of Materials number defining the feedstock and component inputs required for the production run. Governs material requirements planning (MRP) and feedstock consumption calculations.',
    `cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the controlling area currency in which planned and actual production costs are expressed (e.g., USD, EUR). Aligns with SAP controlling area currency configuration.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the production order record was first created in SAP PP (CRTD status). Serves as the audit trail creation marker and is used for data lineage, SOX compliance, and silver-layer ingestion tracking.',
    `energy_consumption_gj` DECIMAL(18,2) COMMENT 'Total energy consumed by the production run in gigajoules, including steam, fuel gas, and electricity. Used for energy intensity benchmarking, OPEX cost allocation, and EPA GHG emissions reporting.',
    `feedstock_material_code` STRING COMMENT 'SAP material number of the primary feedstock (e.g., NGL, naphtha, ethane, propane, crude condensate) consumed in the production run. Supports feedstock allocation, cost tracking, and yield analysis.',
    `feedstock_qty_uom` STRING COMMENT 'Unit of measure for the planned and actual feedstock quantities (e.g., MT for metric tonnes, BBL for barrels, MSCF for thousand standard cubic feet). Aligns with SAP base unit of measure for the feedstock material. [ENUM-REF-CANDIDATE: MT|BBL|MSCF|KG|TON|M3|MMSCF — 7 candidates stripped; promote to reference product]',
    `ghg_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions in metric tonnes of CO2 equivalent attributable to the production run. Supports EPA 40 CFR Part 98 mandatory GHG reporting, ESG disclosures, and carbon intensity tracking per unit of output.',
    `inspection_lot_number` STRING COMMENT 'SAP QM inspection lot number created upon goods receipt of the production order output. Links the production run to quality inspection results, usage decisions, and product release for sale or further processing.',
    `is_capex_linked` BOOLEAN COMMENT 'Flag indicating whether the production order is linked to a CAPEX project (True) or is a routine OPEX manufacturing run (False). Determines cost settlement path, AFE requirement, and financial reporting classification under IFRS/GAAP.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the production order record in SAP PP. Used for incremental data lake ingestion, change detection, and audit trail maintenance in the silver layer.',
    `order_number` STRING COMMENT 'Externally-known SAP PP production order number (e.g., 1000012345) used as the business identifier across ERP, cost settlement, and production planning systems. Maps to SAP AUFNR field on the AUFK table.. Valid values are `^[A-Z0-9]{1,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the production order within the SAP PP workflow. Drives cost settlement eligibility, production reporting, and capacity planning. [ENUM-REF-CANDIDATE: created|released|confirmed|technically_closed|closed|cancelled — promote to reference product]. Valid values are `created|released|confirmed|technically_closed|closed|cancelled`',
    `order_type` STRING COMMENT 'SAP PP order type code classifying the manufacturing run category (e.g., PP01 standard production, PP02 rework, PP03 pilot run, PP04 co-product run). Determines cost object behavior and settlement rules.. Valid values are `PP01|PP02|PP03|PP04`',
    `output_qty_uom` STRING COMMENT 'Unit of measure for the planned and actual output quantities (e.g., MT for metric tonnes, BBL for barrels). Aligns with SAP base unit of measure for the target product material master.. Valid values are `MT|BBL|KG|TON|M3|MSCF`',
    `planned_end_date` DATE COMMENT 'Scheduled completion date for the production order as determined by SAP PP forward or backward scheduling. Used for delivery commitment, inventory planning, and capacity utilization reporting.',
    `planned_feedstock_qty` DECIMAL(18,2) COMMENT 'Planned quantity of primary feedstock to be consumed in the production run, expressed in the feedstock base unit of measure (e.g., MT, BBL, MSCF). Derived from BOM and planned output quantity for feedstock procurement and allocation.',
    `planned_output_qty` DECIMAL(18,2) COMMENT 'Target quantity of the primary finished product to be produced in the manufacturing run, expressed in the product base unit of measure. Drives MRP, inventory planning, and sales order fulfillment commitments.',
    `planned_start_date` DATE COMMENT 'Scheduled start date for the production order as determined by SAP PP capacity planning and MRP. Used for production scheduling, feedstock procurement, and resource allocation.',
    `planned_total_cost` DECIMAL(18,2) COMMENT 'Total planned cost of the production order in the controlling area currency, including planned material costs, activity costs, and overhead. Derived from SAP CO preliminary cost estimate. Used for budget vs. actual OPEX variance analysis.',
    `priority` STRING COMMENT 'Business priority classification of the production order used for scheduling conflict resolution and capacity allocation. Critical orders may be linked to contractual delivery commitments or feedstock expiry constraints.. Valid values are `critical|high|medium|low`',
    `process_pressure_kpa` DECIMAL(18,2) COMMENT 'Target or actual operating pressure in kilopascals for the primary reaction or separation step. Key process parameter for conversion efficiency, equipment integrity, and safety management system compliance.',
    `process_temperature_c` DECIMAL(18,2) COMMENT 'Target or actual operating temperature in degrees Celsius for the primary reaction or separation step in the conversion unit. Key process parameter for yield optimization, catalyst performance, and safety compliance monitoring.',
    `ptw_number` STRING COMMENT 'Enablon HSE Permit to Work number authorizing the production run, particularly for non-routine operations, catalyst changeouts, or SIMOPS scenarios. Ensures HSE compliance and safe execution of manufacturing activities.',
    `routing_number` STRING COMMENT 'SAP routing number specifying the sequence of operations, work centers, and processing steps for the manufacturing run. Determines standard times, machine rates, and operation-level cost allocation.',
    `settlement_rule` STRING COMMENT 'SAP CO settlement rule code defining how accumulated production order costs are distributed at period-end (e.g., MAT=material stock, CTR=cost center, ORD=order, PRJ=project, FXA=fixed asset). Governs OPEX vs. CAPEX cost flow.. Valid values are `MAT|CTR|ORD|PRJ|FXA`',
    `wbs_element` STRING COMMENT 'SAP PS Work Breakdown Structure element code for CAPEX-linked production orders, enabling project cost tracking and capital expenditure reporting. Populated only when the order is associated with a capital project.',
    `work_center_code` STRING COMMENT 'SAP PP work center code identifying the specific production resource or machine group assigned to execute the order. Used for capacity planning, scheduling, and cost rate assignment.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `yield_pct` DECIMAL(18,2) COMMENT 'Ratio of actual output quantity to planned output quantity expressed as a percentage. Key petrochemical performance indicator for conversion efficiency, catalyst performance assessment, and process optimization. Calculated as (actual_output_qty / planned_output_qty) * 100.',
    CONSTRAINT pk_production_order PRIMARY KEY(`production_order_id`)
) COMMENT 'Transactional record representing a SAP PP production order for a petrochemical manufacturing run, capturing order number, plant, conversion unit, target product, planned start and end dates, planned feedstock quantity, planned output quantity, actual output quantity, order status (created, released, confirmed, closed), cost object assignment, and AFE reference for CAPEX-linked runs. Integrates with SAP PP module for production planning and cost settlement.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` (
    `plant_opex_record_id` BIGINT COMMENT 'Unique identifier for the plant-level operating expenditure record in the petrochemical facility.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or financial controller who approved the OPEX record for posting.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Opex records require legal entity context for financial statement consolidation, statutory reporting, and intercompany eliminations. Mandatory for multi-entity organizations.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Audit findings related to cost controls, environmental spending, or financial reporting may reference specific OPEX records as evidence. Links OPEX records to findings for documentation, corrective ac',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every opex transaction posts to a GL account for financial statement preparation, audit trail, and statutory reporting. Fundamental double-entry accounting requirement.',
    `intercompany_billing_id` BIGINT COMMENT 'Foreign key linking to revenue.intercompany_billing. Business justification: Integrated oil companies routinely recharge plant operating expenses between legal entities (e.g., refining subsidiary bills chemical subsidiary for shared utilities). Links operational cost tracking ',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Operating expenses in JV plants are billed to partners through Joint Interest Billing statements under governing JOA. Direct link required for COPAS billing compliance, overhead rate application, and ',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant facility where the operating expenditure was incurred.',
    `primary_plant_employee_id` BIGINT COMMENT 'Identifier of the production or process engineer responsible for reviewing and approving the OPEX record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Opex records must roll up to profit centers for segment P&L reporting, management accounting, and performance evaluation. Required for margin analysis and benchmarking.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Operating expenditures are material financial transactions subject to SOX controls for accurate financial reporting and cost allocation. Links OPEX records to applicable SOX controls for testing, docu',
    `tertiary_plant_updated_by_user_employee_id` BIGINT COMMENT 'System user identifier of the person who last modified the OPEX record.',
    `accounting_document_number` STRING COMMENT 'SAP FI accounting document number generated when the OPEX record is posted to the general ledger.. Valid values are `^[0-9]{10}$`',
    `actual_opex_amount_usd` DECIMAL(18,2) COMMENT 'Actual incurred operating expenditure amount for the cost category and period, in USD.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure number if the OPEX is associated with a specific capital project or major maintenance activity requiring AFE approval.. Valid values are `^AFE-[0-9]{6,10}$`',
    `benchmark_loe_usd_per_mt` DECIMAL(18,2) COMMENT 'Industry or internal benchmark for operating expenditure per unit of production, used for performance comparison and target setting, in USD per metric ton.',
    `catalyst_cost_usd` DECIMAL(18,2) COMMENT 'Cost of catalysts consumed, regenerated, or replaced during the period for conversion unit operations, in USD.',
    `chemical_consumables_cost_usd` DECIMAL(18,2) COMMENT 'Cost of chemical consumables including solvents, additives, and process chemicals used in production, in USD.',
    `comments` STRING COMMENT 'Free-text comments or notes providing additional context about the OPEX record, variances, or special circumstances.',
    `contract_services_cost_usd` DECIMAL(18,2) COMMENT 'Cost of contracted services including third-party maintenance, engineering support, and operational services, in USD.',
    `cost_category` STRING COMMENT 'Primary classification of the operating expenditure by cost type, enabling category-level benchmarking and analysis. [ENUM-REF-CANDIDATE: energy|catalyst|chemicals|maintenance_labor|contract_services|waste_disposal|environmental_compliance|utilities|insurance|property_tax — 10 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'SAP Controlling (CO) cost center code to which the operating expenditure is allocated for financial reporting and analysis.. Valid values are `^[A-Z0-9]{6,12}$`',
    `cost_object_number` STRING COMMENT 'SAP CO cost object number (internal order, WBS element, or cost center) used for detailed cost tracking and allocation.. Valid values are `^[A-Z0-9]{8,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OPEX record was first created in the system, in YYYY-MM-DDTHH:mm:ss.SSSXXX format.',
    `energy_cost_usd` DECIMAL(18,2) COMMENT 'Total energy costs including electricity, natural gas, steam, and fuel consumed by the plant during the period, in USD.',
    `environmental_compliance_cost_usd` DECIMAL(18,2) COMMENT 'Costs associated with environmental monitoring, emissions testing, permit fees, and regulatory compliance activities, in USD.',
    `fiscal_period` STRING COMMENT 'Fiscal year and month for which the operating expenditure is recorded, in YYYY-MM format.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `loe_per_unit_usd_per_mt` DECIMAL(18,2) COMMENT 'Operating expenditure per unit of production output, calculated as total actual OPEX divided by production volume, in USD per metric ton. Key metric for OPEX benchmarking and efficiency analysis.',
    `maintenance_labor_cost_usd` DECIMAL(18,2) COMMENT 'Direct labor costs for maintenance activities including preventive, corrective, and turnaround maintenance, in USD.',
    `planned_opex_amount_usd` DECIMAL(18,2) COMMENT 'Budgeted or planned operating expenditure amount for the cost category and period, in USD.',
    `posting_date` DATE COMMENT 'Date when the OPEX record was posted to the financial accounting system, in YYYY-MM-DD format.',
    `production_volume_mt` DECIMAL(18,2) COMMENT 'Total production output volume from the plant during the period, measured in metric tons, used for calculating unit OPEX metrics.',
    `record_status` STRING COMMENT 'Current lifecycle status of the OPEX record in the approval and posting workflow.. Valid values are `draft|submitted|approved|posted|rejected|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the OPEX record was last modified, in YYYY-MM-DDTHH:mm:ss.SSSXXX format.',
    `variance_amount_usd` DECIMAL(18,2) COMMENT 'Difference between actual and planned OPEX (actual minus planned), in USD. Positive values indicate over-budget, negative values indicate under-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual and planned OPEX, calculated as ((actual - planned) / planned) * 100.',
    `waste_disposal_cost_usd` DECIMAL(18,2) COMMENT 'Cost of hazardous and non-hazardous waste treatment, transportation, and disposal in compliance with environmental regulations, in USD.',
    `work_order_number` STRING COMMENT 'Maximo work order number if the OPEX is associated with a specific maintenance or operational work order.. Valid values are `^WO-[0-9]{8,12}$`',
    CONSTRAINT pk_plant_opex_record PRIMARY KEY(`plant_opex_record_id`)
) COMMENT 'Transactional record capturing plant-level operating expenditure (OPEX) for petrochemical facilities by cost category and period, including energy costs, catalyst costs, chemical consumables, maintenance labor, contract services, waste disposal, and environmental compliance costs. Tracks planned vs. actual OPEX, LOE per unit of output, cost center reference, and SAP CO cost object. Supports OPEX benchmarking and LOE optimization across the petrochemical portfolio.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` (
    `turnaround_event_id` BIGINT COMMENT 'Primary key for turnaround_event',
    `compliance_corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Turnarounds often implement corrective actions from regulatory audits, PSM inspections, or violation settlements. Links turnaround events to corrective actions for tracking implementation, verificatio',
    `conversion_unit_id` BIGINT COMMENT 'Identifier of the specific conversion unit affected by the turnaround event (e.g., cracker, fractionator, polymerization unit).',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Major turnarounds often require permit modifications for temporary operating conditions, increased emissions during startup/shutdown, or construction activities. Links turnaround events to permit modi',
    `plant_id` BIGINT COMMENT 'Identifier of the petrochemical plant where the turnaround event occurred. Links to the plant master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for coordinating and managing the turnaround event.',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: Major turnarounds are often subject to regulatory inspections and audits (EPA, OSHA PSM, state agencies). Links turnaround events to audits for tracking inspection findings, corrective actions, and re',
    `tertiary_turnaround_updated_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last updated the turnaround event record.',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Major turnarounds in JV plants require Authorization for Expenditure approval from all partners per JOA voting thresholds. Turnaround capex/opex are billed through JIB under specific AFE authorization',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Turnarounds are tracked as WBS projects in SAP/ERP for detailed cost collection, milestone tracking, and settlement to fixed assets or expense.',
    `actual_capex_usd` DECIMAL(18,2) COMMENT 'Actual capital expenditure incurred during the turnaround event, covering major equipment replacements and upgrades.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the turnaround event was completed and the unit was returned to service.',
    `actual_opex_usd` DECIMAL(18,2) COMMENT 'Actual operating expenditure incurred during the turnaround event, covering labor, materials, and contractor services.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the turnaround event commenced, marking the beginning of unit shutdown.',
    `approval_status` STRING COMMENT 'Approval status of the turnaround event plan: draft (under development), pending_approval (submitted for review), approved (authorized to proceed), or rejected (not authorized).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the turnaround event plan and budget were formally approved.',
    `certification_date` DATE COMMENT 'Date when the post-turnaround performance certification was completed and the unit was formally accepted back into service.',
    `cost_variance_usd` DECIMAL(18,2) COMMENT 'Difference between estimated and actual total cost (CAPEX + OPEX) for the turnaround event. Positive values indicate cost overruns; negative values indicate cost savings.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the turnaround event record was first created in the system.',
    `environmental_incident_count` STRING COMMENT 'Total number of environmental incidents (spills, releases, exceedances) that occurred during the turnaround event.',
    `estimated_capex_usd` DECIMAL(18,2) COMMENT 'Estimated capital expenditure for the turnaround event, covering major equipment replacements and upgrades.',
    `estimated_opex_usd` DECIMAL(18,2) COMMENT 'Estimated operating expenditure for the turnaround event, covering labor, materials, and contractor services.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the turnaround event record was most recently modified.',
    `lessons_learned_summary` STRING COMMENT 'Summary of key lessons learned and best practices identified during the turnaround event for future planning and execution improvement.',
    `maximo_work_order_number` STRING COMMENT 'Work order number in the Maximo CMMS system that tracks the detailed work activities and resource allocation for the turnaround event.',
    `moc_reference_number` STRING COMMENT 'Reference number of the Management of Change process associated with the turnaround event, ensuring compliance with HSE procedures.',
    `npt_hours` DECIMAL(18,2) COMMENT 'Total non-productive time in hours during which the unit was offline due to the turnaround event.',
    `performance_certification_status` STRING COMMENT 'Status of the post-turnaround performance certification: pending (awaiting test results), certified (unit meets performance criteria), failed (unit did not meet criteria), or waived (certification not required).. Valid values are `pending|certified|failed|waived`',
    `production_deferral_boe` DECIMAL(18,2) COMMENT 'Total production volume deferred due to the turnaround event, expressed in barrels of oil equivalent for standardized measurement.',
    `ptw_status` STRING COMMENT 'Status of the Permit to Work system for the turnaround event: not_required (no PTW needed), pending (awaiting approval), approved (authorized but not started), active (work in progress), or closed (work completed and permit closed).. Valid values are `not_required|pending|approved|active|closed`',
    `regulatory_driver` STRING COMMENT 'Specific regulatory requirement or compliance mandate that necessitated the turnaround event, if applicable (e.g., EPA inspection requirement, OSHA mandated maintenance).',
    `safety_incident_count` STRING COMMENT 'Total number of recordable safety incidents that occurred during the turnaround event.',
    `sap_maintenance_order_number` STRING COMMENT 'Maintenance order number in SAP PM module that tracks the financial and material aspects of the turnaround event.',
    `schedule_variance_days` STRING COMMENT 'Difference between scheduled and actual turnaround duration in days. Positive values indicate delays; negative values indicate early completion.',
    `scheduled_end_date` DATE COMMENT 'Planned completion date for the turnaround event as defined during the planning phase.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the turnaround event as defined during the planning phase.',
    `scope_of_work_summary` STRING COMMENT 'High-level description of the maintenance, inspection, and repair activities included in the turnaround scope.',
    `total_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours expended during the turnaround event, including both internal workforce and contractor hours.',
    `turnaround_number` STRING COMMENT 'Business identifier for the turnaround event, typically assigned by the maintenance planning system or CMMS.',
    `turnaround_status` STRING COMMENT 'Current lifecycle status of the turnaround event: planned (scheduled but not started), in_progress (underway), completed (finished and unit restarted), cancelled (not executed), or deferred (postponed to future period).. Valid values are `planned|in_progress|completed|cancelled|deferred`',
    `turnaround_type` STRING COMMENT 'Classification of the turnaround event: planned (scheduled maintenance), emergency (unplanned due to failure), regulatory (mandated by compliance), or opportunistic (combined with other work).. Valid values are `planned|emergency|regulatory|opportunistic`',
    CONSTRAINT pk_turnaround_event PRIMARY KEY(`turnaround_event_id`)
) COMMENT 'Master record for planned and unplanned plant turnaround and shutdown events, capturing turnaround type (planned, emergency, regulatory), affected plant and units, scheduled start and end dates, actual start and end dates, scope of work summary, estimated and actual CAPEX/OPEX cost, NPT hours, production deferral volume in BOE, MOC reference, PTW status, and post-turnaround performance certification. Integrates with Maximo CMMS for work order management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` (
    `process_simulation_id` BIGINT COMMENT 'Unique identifier for the process simulation model record. Primary key.',
    `calibration_run_id` BIGINT COMMENT 'Reference to the specific production run or test campaign record used to calibrate this simulation model, enabling traceability to actual operating data.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific petrochemical conversion unit (cracker, fractionator, polymerization reactor, etc.) that this simulation model represents.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Simulation work charged to engineering cost centers for budget tracking and resource allocation.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Simulations for capital projects (debottlenecking, new units) charged to AFE for project cost tracking.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Process simulations model production of specific petroleum products for yield optimization, capacity planning, and feedstock selection. Petroleum_product link enables simulation results to feed enterp',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant or facility where the modeled conversion unit is located, enabling plant-level aggregation and analysis.',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer or technical specialist responsible for maintaining, calibrating, and validating this simulation model.',
    `tertiary_process_model_owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `afe_number` STRING COMMENT 'Authorization for Expenditure (AFE) number if this simulation model was developed as part of a capital project or major engineering study requiring budget approval.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the simulation model was formally approved for operational use, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `calibration_basis` STRING COMMENT 'Description of the actual plant run data, operating conditions, or test campaign used as the reference basis for calibrating the simulation model parameters.',
    `component_library_version` STRING COMMENT 'Version of the Aspen HYSYS component library or pure component database used in the simulation, ensuring consistency in physical property data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this simulation model record was first created in the system, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX) for audit trail purposes.',
    `design_pressure_kpa` DECIMAL(18,2) COMMENT 'Design or baseline operating pressure in kilopascals (kPa) used as a key input parameter in the simulation model.',
    `design_temperature_c` DECIMAL(18,2) COMMENT 'Design or baseline operating temperature in degrees Celsius used as a key input parameter in the simulation model.',
    `design_throughput_mt_per_day` DECIMAL(18,2) COMMENT 'Design or nameplate feedstock processing capacity in metric tons per day that the simulation model is configured to represent.',
    `epa_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this simulation model incorporates Environmental Protection Agency (EPA) emissions modeling or environmental compliance constraints.',
    `feed_composition_basis` STRING COMMENT 'Description or reference to the feedstock composition profile used as input to the simulation, including hydrocarbon distribution, impurities, and key assay properties.',
    `ghg_emissions_modeled_mt_co2e` DECIMAL(18,2) COMMENT 'Simulated Greenhouse Gas (GHG) emissions in metric tons of carbon dioxide equivalent (CO2e) associated with the modeled conversion process, supporting Environmental Social and Governance (ESG) reporting.',
    `hysys_version` STRING COMMENT 'Version number of the Aspen HYSYS software application used to create and run this simulation model, important for compatibility and reproducibility.',
    `iso_quality_standard_compliance` STRING COMMENT 'Reference to applicable ISO quality management standards (e.g., ISO 9001) that govern the development, validation, and maintenance of this simulation model.',
    `last_calibration_date` DATE COMMENT 'The most recent date on which the simulation model was calibrated or validated against actual plant operating data to ensure predictive accuracy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this simulation model record was most recently modified, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX) for change tracking and audit purposes.',
    `model_accuracy_pct` DECIMAL(18,2) COMMENT 'Quantitative measure of the simulation models predictive accuracy expressed as a percentage, calculated by comparing modeled outputs to actual plant performance during calibration.',
    `model_approval_status` STRING COMMENT 'Approval workflow status indicating whether the simulation model has been reviewed and approved by senior process engineers or technical authorities for operational use.. Valid values are `draft|pending_review|approved|rejected`',
    `model_file_path` STRING COMMENT 'Network or cloud storage location where the Aspen HYSYS simulation model file (.hsc or .hsf) is stored, enabling retrieval and version control.',
    `model_file_size_mb` DECIMAL(18,2) COMMENT 'Size of the simulation model file in megabytes, used for storage management and performance optimization.',
    `model_purpose` STRING COMMENT 'Business objective or use case for this simulation model, such as yield optimization, feedstock evaluation, debottlenecking analysis, or capital project design.',
    `model_version` STRING COMMENT 'Version identifier of the simulation model, tracking revisions and updates to the model configuration, parameters, or calibration basis.',
    `modeled_benzene_yield_pct` DECIMAL(18,2) COMMENT 'Simulated benzene (BTX aromatics) product yield as a percentage of feedstock input, representing the models predicted output for this aromatic petrochemical.',
    `modeled_butadiene_yield_pct` DECIMAL(18,2) COMMENT 'Simulated butadiene product yield as a percentage of feedstock input, representing the models predicted output for this specialty petrochemical product.',
    `modeled_catalyst_consumption_kg_per_mt` DECIMAL(18,2) COMMENT 'Simulated catalyst consumption rate in kilograms per metric ton of feedstock processed, used for catalyst performance tracking and OPEX forecasting.',
    `modeled_energy_consumption_gj_per_mt` DECIMAL(18,2) COMMENT 'Simulated specific energy consumption in gigajoules per metric ton of feedstock processed, used for Operating Expenditure (OPEX) estimation and energy efficiency analysis.',
    `modeled_ethylene_yield_pct` DECIMAL(18,2) COMMENT 'Simulated ethylene product yield as a percentage of feedstock input, representing the models predicted output for this key petrochemical product.',
    `modeled_propylene_yield_pct` DECIMAL(18,2) COMMENT 'Simulated propylene product yield as a percentage of feedstock input, representing the models predicted output for this key petrochemical product.',
    `modeled_total_yield_pct` DECIMAL(18,2) COMMENT 'Aggregate simulated product yield across all output streams as a percentage of feedstock input, used for mass balance validation and overall conversion efficiency assessment.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, assumptions, limitations, or special considerations related to this simulation model that are important for users to understand.',
    `sap_production_order_number` STRING COMMENT 'Reference to the SAP Production Planning (PP) production order number associated with the plant run or campaign that this simulation model supports or validates.',
    `simulation_model_name` STRING COMMENT 'The business name or title assigned to this Aspen HYSYS simulation model, used for identification and reference by process engineers and operations teams.',
    `simulation_status` STRING COMMENT 'Current lifecycle status of the simulation model indicating whether it is actively used for operational decisions, requires recalibration, or has been retired.. Valid values are `active|calibrated|under_review|deprecated|archived`',
    `simulation_type` STRING COMMENT 'Classification of the simulation methodology: steady-state (equilibrium conditions), dynamic (time-dependent behavior), batch (discrete campaigns), or continuous (ongoing operations).. Valid values are `steady-state|dynamic|batch|continuous`',
    `thermodynamic_package` STRING COMMENT 'The thermodynamic property package or equation of state used in the Aspen HYSYS simulation (e.g., Peng-Robinson, SRK, NRTL) to model phase behavior and physical properties.',
    CONSTRAINT pk_process_simulation PRIMARY KEY(`process_simulation_id`)
) COMMENT 'Master record for Aspen HYSYS process simulation models associated with conversion units and plant configurations, capturing simulation model name, version, associated unit or plant, simulation type (steady-state, dynamic), key input parameters (feed composition, temperature, pressure), modeled yield outputs, last calibration date, calibration basis (actual run data), and model owner. Serves as the SSOT for simulation-to-actual performance comparison in the petrochemical domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` (
    `ngl_fractionation_run_id` BIGINT COMMENT 'Unique identifier for each NGL fractionation train run record. Primary key for the ngl_fractionation_run product.',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key linking to petrochemical.conversion_unit. Business justification: NGL fractionation train is a type of conversion unit in petrochemical operations. The fractionation_train_id attribute on ngl_fractionation_run is semantically equivalent to conversion_unit_id in the ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fractionation costs allocated to cost centers for budget tracking and cost control. Enables unit cost analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the process operator responsible for monitoring and controlling the fractionation run.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: NGL fractionation trains are major equipment assets (deethanizer, depropanizer columns) requiring maintenance tracking, inspection scheduling, and equipment performance monitoring. Essential for equip',
    `fractionation_train_id` BIGINT COMMENT 'Foreign key reference to the specific fractionation train unit where this run was executed. Links to the conversion unit master data.',
    `ngl_stream_id` BIGINT COMMENT 'Foreign key linking to product.ngl_stream. Business justification: NGL fractionation runs produce specific NGL streams (ethane, propane, butane, natural gasoline) defined in product domain. Link enables yield accounting against stream specifications, product quality ',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: NGL fractionation operations must comply with air quality permits governing VOC emissions, flaring limits, and operating conditions. Links fractionation runs to applicable permits for real-time compli',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the petrochemical plant facility where the fractionation run occurred. Links to the plant master data.',
    `process_simulation_id` BIGINT COMMENT 'Reference to the Aspen HYSYS process simulation run used for planning or validating this fractionation run, enabling model-to-actual reconciliation.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to petrochemical.production_order. Business justification: NGL fractionation runs are executed under SAP PP production orders. The sap_production_order_number attribute on ngl_fractionation_run is a business reference that should be normalized to a FK relatio',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fractionation output drives profit center margins. NGL products have different values; fractionation economics are core to profitability.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: NGL fractionation processes raw natural gas liquids from upstream production. Linking fractionation runs to source lease enables royalty calculations on fractionated products (ethane, propane, butane)',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: NGL fractionation plants receive inlet NGL streams from upstream production facilities (gas plants, processing facilities). Tracking source facility enables inlet volume reconciliation, quality varian',
    `avg_operating_pressure_kpa` DECIMAL(18,2) COMMENT 'Average pressure maintained in the fractionation column during the run, measured in kilopascals, essential for process control and safety.',
    `avg_operating_temperature_c` DECIMAL(18,2) COMMENT 'Average temperature maintained in the fractionation column during the run, measured in degrees Celsius, critical for product separation quality.',
    `butane_product_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of butane product recovered from the fractionation run, measured in barrels, used for LPG blending and gasoline blendstock.',
    `butane_recovery_efficiency_pct` DECIMAL(18,2) COMMENT 'Percentage of inlet butane successfully recovered as product, calculated as (butane product / inlet butane) * 100, used for process optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fractionation run record was first created in the system, used for audit trail and data lineage tracking.',
    `energy_consumption_gj` DECIMAL(18,2) COMMENT 'Total energy consumed during the fractionation run, measured in gigajoules, including fuel gas, steam, and electrical power.',
    `ethane_product_purity_pct` DECIMAL(18,2) COMMENT 'Purity level of the ethane product stream expressed as percentage, indicating the quality and specification compliance for petrochemical feedstock use.',
    `ethane_product_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of ethane product recovered from the fractionation run, measured in barrels, used for petrochemical feedstock supply.',
    `ethane_recovery_efficiency_pct` DECIMAL(18,2) COMMENT 'Percentage of inlet ethane successfully recovered as product, calculated as (ethane product / inlet ethane) * 100, key performance indicator for fractionation effectiveness.',
    `flare_volume_mmcfd` DECIMAL(18,2) COMMENT 'Volume of gas flared during the fractionation run due to process upsets or safety releases, measured in million cubic feet per day.',
    `fuel_gas_consumption_mmcfd` DECIMAL(18,2) COMMENT 'Volume of fuel gas consumed to provide heat for the fractionation process, measured in million cubic feet per day.',
    `ghg_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions generated during the fractionation run, measured in metric tons of CO2 equivalent, used for EPA reporting and ESG compliance.',
    `inlet_butane_composition_pct` DECIMAL(18,2) COMMENT 'Percentage by volume of butane (C4H10) in the inlet NGL stream, including both normal butane and isobutane fractions.',
    `inlet_ethane_composition_pct` DECIMAL(18,2) COMMENT 'Percentage by volume of ethane (C2H6) in the inlet NGL stream, critical for yield forecasting and product allocation.',
    `inlet_ngl_throughput_mmcfd` DECIMAL(18,2) COMMENT 'Volumetric flow rate of inlet NGL stream expressed in million cubic feet per day, representing the processing capacity utilization.',
    `inlet_ngl_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of raw NGL feedstock entering the fractionation train during this run, measured in barrels.',
    `inlet_pentane_plus_composition_pct` DECIMAL(18,2) COMMENT 'Percentage by volume of pentane and heavier hydrocarbons (C5+) in the inlet NGL stream, representing natural gasoline components.',
    `inlet_propane_composition_pct` DECIMAL(18,2) COMMENT 'Percentage by volume of propane (C3H8) in the inlet NGL stream, used for LPG yield optimization and product planning.',
    `lpg_product_volume_bbl` DECIMAL(18,2) COMMENT 'Total volume of LPG product (combined propane and butane) recovered from the fractionation run, measured in barrels.',
    `mass_balance_closure_pct` DECIMAL(18,2) COMMENT 'Percentage representing the mass balance closure for the run, calculated as (total products / total feed) * 100, used to validate measurement accuracy and identify losses.',
    `natural_gasoline_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of natural gasoline (pentane plus) product recovered from the fractionation run, measured in barrels, used as refinery blendstock.',
    `overall_recovery_efficiency_pct` DECIMAL(18,2) COMMENT 'Aggregate recovery efficiency across all NGL components, representing the overall effectiveness of the fractionation process.',
    `pi_tag_reference` STRING COMMENT 'Reference to the PI System historian tag or tag group that contains the real-time process data for this fractionation run, enabling time-series analysis.',
    `power_consumption_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by pumps, compressors, and control systems during the fractionation run, measured in megawatt hours.',
    `propane_product_purity_pct` DECIMAL(18,2) COMMENT 'Purity level of the propane product stream expressed as percentage, critical for LPG specification compliance and commercial sales.',
    `propane_product_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of propane product recovered from the fractionation run, measured in barrels, primary component of LPG production.',
    `propane_recovery_efficiency_pct` DECIMAL(18,2) COMMENT 'Percentage of inlet propane successfully recovered as product, calculated as (propane product / inlet propane) * 100, critical for LPG yield optimization.',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from run start to run end, representing the actual processing time for this fractionation cycle.',
    `run_end_timestamp` TIMESTAMP COMMENT 'Date and time when the fractionation run concluded or was terminated, marking the completion of the processing cycle.',
    `run_number` STRING COMMENT 'Business identifier for the fractionation run, typically assigned by the plant operations system for tracking and reporting purposes.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Date and time when the fractionation run commenced operations, marking the beginning of NGL processing through the train.',
    `run_status` STRING COMMENT 'Current lifecycle status of the fractionation run indicating its operational state in the production workflow.. Valid values are `planned|in_progress|completed|aborted|suspended|failed`',
    `shift_code` STRING COMMENT 'Identifier for the operational shift during which the fractionation run was executed, used for crew performance tracking and scheduling.',
    `steam_consumption_mt` DECIMAL(18,2) COMMENT 'Mass of steam consumed during the fractionation run for heating and process control, measured in metric tons.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this fractionation run record was most recently modified, supporting change tracking and audit compliance.',
    CONSTRAINT pk_ngl_fractionation_run PRIMARY KEY(`ngl_fractionation_run_id`)
) COMMENT 'Transactional record for each NGL fractionation train run, capturing inlet NGL stream composition (ethane, propane, butane, pentane+), fractionation train identifier, run start and end timestamps, throughput volume in MMCFD, product cut volumes by component (ethane, propane, LPG, natural gasoline), recovery efficiency per component, energy consumption, and product quality results. Supports NGL yield optimization and LPG production reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` (
    `product_inventory_id` BIGINT COMMENT 'Unique identifier for the product inventory record. Primary key for the product inventory master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory holding costs (storage, insurance, obsolescence) allocated to cost centers for cost control.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Inventory valuation posts to balance sheet GL accounts for financial statement preparation and audit.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Product storage in tanks requires permits for air emissions (tank breathing losses), spill prevention (SPCC), and hazardous material storage. Links inventory to permits for tracking permitted storage ',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant or manufacturing facility where the inventory is held.',
    `product_catalog_id` BIGINT COMMENT 'Reference to the petrochemical product type stored in inventory (ethylene, propylene, LPG, NGL, specialty chemicals, etc.).',
    `quality_spec_id` BIGINT COMMENT 'Reference to the product specification or quality standard that the inventory must meet.',
    `storage_inventory_id` BIGINT COMMENT 'Foreign key linking to logistics.storage_inventory. Business justification: Petrochemical product inventory at terminals is tracked in both plant systems (product_inventory) and logistics systems (storage_inventory). Links enable reconciliation between operational and commerc',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location, terminal, or intermediate storage facility within the plant.',
    `storage_tank_id` BIGINT COMMENT 'Reference to the specific storage tank or vessel holding the petrochemical product inventory.',
    `available_volume` DECIMAL(18,2) COMMENT 'Quantity of inventory available for allocation, lifting, or shipment after accounting for reservations and holds.',
    `batch_number` STRING COMMENT 'Production batch or lot number associated with the inventory, enabling traceability to the manufacturing run.',
    `blocked_volume` DECIMAL(18,2) COMMENT 'Quantity of inventory blocked or restricted due to quality issues, regulatory holds, or pending inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for inventory valuation and financial reporting. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CAD|AUD — 7 candidates stripped; promote to reference product]',
    `current_volume` DECIMAL(18,2) COMMENT 'Current quantity or volume of product in inventory at the storage location as of the last measurement.',
    `custody_status` STRING COMMENT 'Ownership or custody classification of the inventory (owned, consignment, joint venture partner share, third-party tolling).. Valid values are `owned|consignment|joint_venture|third_party|tolling`',
    `density_api` DECIMAL(18,2) COMMENT 'API gravity measurement of the product density, used for volume-to-mass conversions and quality verification.',
    `expiry_date` DATE COMMENT 'Date when the product reaches its shelf life limit or quality specification expiration, if applicable.',
    `inventory_number` STRING COMMENT 'Business identifier or record number for the inventory position, used for tracking and reconciliation purposes.',
    `inventory_status` STRING COMMENT 'Current status of the inventory position indicating availability for use, shipment, or restrictions. [ENUM-REF-CANDIDATE: available|reserved|in_transit|quality_hold|blocked|restricted|allocated — 7 candidates stripped; promote to reference product]',
    `last_quality_test_date` DATE COMMENT 'Date when the most recent quality assay or laboratory test was performed on the inventory.',
    `lifting_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator whether the inventory is eligible for customer lifting or shipment based on quality, custody, and regulatory clearance.',
    `maximum_operating_level` DECIMAL(18,2) COMMENT 'Maximum inventory capacity or safe fill level for the storage tank or facility.',
    `measurement_date` DATE COMMENT 'Date when the inventory volume was last physically measured or gauged.',
    `measurement_method` STRING COMMENT 'Method used to measure or determine the inventory volume (manual gauge, automatic tank gauge, flow meter, SCADA integration, physical count).. Valid values are `manual_gauge|automatic_tank_gauge|flow_meter|scada|pi_system|physical_count`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inventory volume was last measured, typically from SCADA or PI System.',
    `minimum_operating_level` DECIMAL(18,2) COMMENT 'Minimum inventory level required for safe and continuous plant operations, below which replenishment is triggered.',
    `pi_tag_reference` STRING COMMENT 'OSIsoft PI System tag identifier for real-time monitoring and data historian integration of the inventory position.',
    `pressure_kpa` DECIMAL(18,2) COMMENT 'Current storage pressure in kilopascals for pressurized products such as LPG or NGL.',
    `product_age_days` STRING COMMENT 'Number of days the product has been in storage since receipt or production, used for quality monitoring and FIFO management.',
    `product_grade` STRING COMMENT 'Quality grade or specification level of the product (e.g., polymer grade, chemical grade, fuel grade) meeting industry standards.',
    `quality_certificate_number` STRING COMMENT 'Certificate of analysis or quality certificate number documenting the products conformance to specifications.',
    `receipt_date` DATE COMMENT 'Date when the product was received into inventory at the storage location.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers replenishment or production planning activities.',
    `reserved_volume` DECIMAL(18,2) COMMENT 'Quantity of inventory reserved or allocated for specific sales orders, production orders, or customer commitments.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Buffer inventory quantity maintained to mitigate supply chain variability and demand fluctuations.',
    `sap_material_document` STRING COMMENT 'SAP material document number associated with the most recent goods movement affecting this inventory position.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Current storage temperature of the product in degrees Celsius, critical for quality control and safety monitoring.',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'Total financial value of the inventory position calculated as current volume multiplied by unit cost.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the inventory, used for inventory valuation and financial reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory record was last updated or modified.',
    `valuation_class` STRING COMMENT 'Financial valuation classification for inventory accounting and general ledger posting.',
    `volume_uom` STRING COMMENT 'Unit of measure for the inventory volume (barrels, metric tons, kilograms, gallons, cubic meters, thousand cubic feet, million cubic feet, barrel of oil equivalent). [ENUM-REF-CANDIDATE: bbl|mt|kg|gal|m3|mcf|mmcf|boe — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_product_inventory PRIMARY KEY(`product_inventory_id`)
) COMMENT 'Master record tracking current and historical inventory positions of petrochemical products at plant storage tanks, terminals, and intermediate storage facilities. Captures product type, storage location, tank or vessel identifier, current volume, unit of measure, quality grade, last measurement date, minimum and maximum operating levels, custody status, and product age. Supports product lifting scheduling and supply chain handoff to the logistics domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` (
    `product_lifting_id` BIGINT COMMENT 'Unique identifier for the product lifting transaction record. Primary key for the product lifting entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Account-level tracking of product liftings enables revenue allocation, credit limit monitoring, and volume commitment tracking against term contracts. Required for monthly account reconciliation, invo',
    `commercial_term_contract_id` BIGINT COMMENT 'Foreign key linking to commercial.term_contract. Business justification: Liftings often fulfill term contracts directly (not just offtake agreements). Essential for contract performance tracking, deficiency payment calculations, and volume commitment reconciliation. Remove',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Product exports (especially LNG, petrochemicals) require export licenses, customs declarations, and trade compliance filings. Links lifting transactions to regulatory submissions for export control co',
    `contract_id` BIGINT COMMENT 'Reference to the sales or offtake contract governing this product lifting transaction.',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.customer_counterparty. Business justification: Product liftings are executed for specific customer counterparties who purchase petrochemical products. Essential for revenue recognition, credit management, and commercial reporting. Oil-and-gas doma',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Product sales post to revenue GL accounts for financial statement preparation and revenue recognition. Required for audit trail.',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Petrochemical product offtake by JV partners must reconcile actual lifted volumes against entitlement percentages under JOA/PSA terms. Critical for overlift/underlift tracking, imbalance settlement, a',
    `nomination_id` BIGINT COMMENT 'Reference to the buyer nomination that initiated this lifting transaction.',
    `offtake_nomination_id` BIGINT COMMENT 'Foreign key linking to petrochemical.offtake_nomination. Business justification: Product lifting fulfills an offtake nomination. The nomination_id attribute on product_lifting should reference the in-domain offtake_nomination product (not the cross-domain customer.nomination). The',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Product liftings require petroleum_product reference for customs documentation, HS code and tariff code application, export/import regulatory classification, pricing benchmark application, and certifi',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant or terminal from which the product is being lifted.',
    `product_catalog_id` BIGINT COMMENT 'Reference to the petrochemical product being lifted (ethylene, propylene, LPG, NGL, specialty chemical, etc.).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Product sales drive profit center revenue and margins. Required for P&L reporting and profitability analysis.',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_order. Business justification: Liftings fulfill sales orders - fundamental commercial-to-operations link for order fulfillment tracking, invoice triggering, and revenue recognition. Complements existing nomination and contract link',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.settlement. Business justification: Product liftings require final settlement to reconcile actual delivered volumes/quality against invoiced amounts. Handles adjustments for measurement differences, quality premiums/penalties, and price',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Product liftings from petrochemical plants are physical shipments requiring transport documentation, custody transfer records, and logistics coordination. Essential for reconciling commercial sales wi',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Marine liftings from petrochemical terminals are voyages with charter parties, laytime calculations, and demurrage tracking. Critical for vessel scheduling, freight cost allocation, and demurrage clai',
    `actual_lifting_date` DATE COMMENT 'Actual date when the product lifting was executed and cargo loaded.',
    `actual_volume_lifted` DECIMAL(18,2) COMMENT 'Actual volume of product loaded and transferred to the buyer at the custody transfer point.',
    `boe_equivalent` DECIMAL(18,2) COMMENT 'Volume lifted converted to Barrel of Oil Equivalent for standardized reporting across product types.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product lifting record was first created in the system.',
    `custody_transfer_point` STRING COMMENT 'Physical location or meter point where product custody transfers from seller to buyer (loading rack, pipeline connection, marine terminal berth).',
    `delivery_window_end` TIMESTAMP COMMENT 'End of the agreed time window during which the buyer may lift the product.',
    `delivery_window_start` TIMESTAMP COMMENT 'Beginning of the agreed time window during which the buyer may lift the product.',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the destination country of the lifted product.',
    `destination_location` STRING COMMENT 'Final destination location or facility where the lifted product will be delivered or consumed.',
    `invoice_number` STRING COMMENT 'Sales invoice number generated for this product lifting transaction.',
    `invoice_trigger_status` STRING COMMENT 'Status indicating whether this lifting has triggered invoice generation and the current invoice processing state.. Valid values are `pending|triggered|invoiced|paid`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this product lifting record was last modified or updated.',
    `lifting_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the physical loading of product was completed at the custody transfer point.',
    `lifting_number` STRING COMMENT 'Business identifier for the product lifting transaction, used for external reference and tracking across systems.',
    `lifting_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the physical loading of product began at the custody transfer point.',
    `lifting_status` STRING COMMENT 'Current status of the product lifting transaction in its lifecycle from nomination through completion. [ENUM-REF-CANDIDATE: nominated|scheduled|in_progress|completed|cancelled|delayed|partial — 7 candidates stripped; promote to reference product]',
    `nominated_volume` DECIMAL(18,2) COMMENT 'Volume of product requested by the buyer in the original nomination.',
    `nomination_date` DATE COMMENT 'Date when the buyer submitted the nomination for this product lifting.',
    `product_grade` STRING COMMENT 'Quality grade or specification of the product being lifted (e.g., polymer grade, chemical grade, fuel grade).',
    `quality_certificate_number` STRING COMMENT 'Reference number for the certificate of analysis or quality certificate issued for this product lifting.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this product lifting is recognized for financial reporting purposes.',
    `scheduled_lifting_date` DATE COMMENT 'Planned date for the product lifting to occur, as agreed between buyer and seller.',
    `scheduled_volume` DECIMAL(18,2) COMMENT 'Volume of product scheduled for lifting after nomination approval and allocation.',
    `volume_uom` STRING COMMENT 'Unit of measure for all volume quantities in this lifting record (barrels, metric tons, cubic meters, etc.).. Valid values are `BBL|MT|KG|M3|GAL|LB`',
    `volume_variance` DECIMAL(18,2) COMMENT 'Difference between scheduled volume and actual volume lifted (actual minus scheduled).',
    `volume_variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance between scheduled and actual volume lifted, calculated as (variance / scheduled) * 100.',
    CONSTRAINT pk_product_lifting PRIMARY KEY(`product_lifting_id`)
) COMMENT 'Transactional record for the full product dispatch lifecycle from buyer nomination through cargo loading at a petrochemical plant or terminal. Captures nomination details (nominated volume, delivery window, buyer reference, contract reference, nomination status), and execution details (lifting date, actual volume lifted in BOE or metric tons, destination, vessel/truck identifier, custody transfer point, quality certificate reference, invoice trigger status). Supports commercial scheduling, supply chain coordination, and revenue recognition handoff.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` (
    `offtake_nomination_id` BIGINT COMMENT 'Unique identifier for the offtake nomination record. Primary key for the offtake nomination entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Account context for nomination processing enables credit limit checks, payment terms validation, and volume commitment tracking. Required for nomination approval workflow and allocation prioritization',
    `allocation_run_id` BIGINT COMMENT 'Reference to the supply chain allocation optimization run that processed this nomination and determined confirmed volumes.',
    `commercial_counterparty_id` BIGINT COMMENT 'Reference to the buyer entity who submitted the offtake nomination under the term offtake agreement.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Offtake agreements for regulated products (LNG exports, strategic petroleum reserve) may trigger regulatory notifications to DOE, FERC, or international authorities. Links nominations to required regu',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical delivery location where the buyer will take custody of the nominated product, such as a loading rack, pipeline interconnect, or marine terminal.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who confirmed or approved the nomination on behalf of the petrochemical plant.',
    `ferc_tariff_id` BIGINT COMMENT 'Foreign key linking to compliance.ferc_tariff. Business justification: Offtake agreements for pipeline-transported products (NGL, ethylene, propylene) reference applicable FERC tariffs for rate schedules and terms. Links nominations to tariffs for pricing, capacity alloc',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to revenue.invoice. Business justification: Offtake nominations that convert to actual deliveries generate invoices. Tracks the commercial workflow from customer nomination through confirmation to billing. Essential for reconciling contracted v',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: Offtake nominations are submitted by venture partners exercising their entitlement rights under JOA/PSA. Partner identity required for allocation scheduling, entitlement verification, overlift/underli',
    `offtake_agreement_id` BIGINT COMMENT 'Reference to the master term offtake agreement under which this nomination is submitted, defining commercial terms and entitlements.',
    `original_nomination_offtake_nomination_id` BIGINT COMMENT 'Reference to the original nomination record if this is a revised nomination, enabling traceability of nomination history.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Offtake nominations reference specific petroleum product grades for contract pricing formula application, quality specification enforcement, regulatory export approval, and customs pre-clearance. Link',
    `pipeline_nomination_id` BIGINT COMMENT 'Foreign key linking to logistics.pipeline_nomination. Business justification: Petrochemical offtake nominations for pipeline delivery are submitted as pipeline nominations to the pipeline operator. Essential for coordinating commercial sales commitments with pipeline capacity a',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical manufacturing plant that will supply the nominated product volume.',
    `product_catalog_id` BIGINT COMMENT 'Reference to the petrochemical product being nominated for lifting, such as ethylene, propylene, benzene, or specialty chemicals.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Nominations drive profit center sales forecasts and revenue planning. Required for budget preparation and variance analysis.',
    `sales_order_id` BIGINT COMMENT 'SAP Sales and Distribution (SD) sales order number generated upon confirmation of the nomination, linking to the fulfillment process.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to revenue.settlement. Business justification: Offtake nominations that result in deliveries require settlement for variances between nominated and actual volumes/prices. Tracks the full commercial cycle from nomination through delivery to final s',
    `contact_id` BIGINT COMMENT 'Reference to the buyer contact person who submitted the nomination on behalf of the buyer organization.',
    `buyer_reference_number` STRING COMMENT 'External reference number provided by the buyer for their internal tracking and reconciliation of the nomination.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when the nomination was confirmed by the petrochemical plant, establishing the commitment for product delivery.',
    `confirmed_volume` DECIMAL(18,2) COMMENT 'Quantity of product confirmed by the petrochemical plant for delivery, which may differ from the nominated volume due to production constraints or allocation rules.',
    `contract_reference_number` STRING COMMENT 'Business reference number of the offtake contract for human-readable identification and commercial documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offtake nomination record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the commercial transaction associated with this nomination. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AED|SAR — 7 candidates stripped; promote to reference product]',
    `delivery_number` STRING COMMENT 'SAP delivery document number created for the physical shipment or lifting of the nominated product.',
    `delivery_window_end` DATE COMMENT 'Ending date of the delivery window during which the buyer intends to lift the nominated product volume.',
    `delivery_window_start` DATE COMMENT 'Beginning date of the delivery window during which the buyer intends to lift the nominated product volume.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Timestamp when the nomination expires if not confirmed, based on contract terms or commercial scheduling cutoff rules.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the offtake nomination record, tracking changes throughout the nomination lifecycle.',
    `nominated_volume` DECIMAL(18,2) COMMENT 'Quantity of petrochemical product nominated by the buyer for lifting during the specified delivery window.',
    `nomination_date` DATE COMMENT 'Date when the buyer submitted the offtake nomination to the petrochemical plant for product lifting under the term offtake agreement.',
    `nomination_number` STRING COMMENT 'Business identifier for the offtake nomination, typically a human-readable reference number used in commercial communications and scheduling systems.',
    `nomination_status` STRING COMMENT 'Current lifecycle status of the offtake nomination indicating its position in the commercial scheduling workflow.. Valid values are `submitted|confirmed|revised|rejected|cancelled|expired`',
    `nomination_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the nomination was submitted, critical for scheduling priority and cutoff time enforcement.',
    `pricing_date` DATE COMMENT 'Date used to determine the contract price for the nominated volume, typically based on market indices or formula pricing in the offtake agreement.',
    `priority_basis` STRING COMMENT 'Business rule or criterion used to determine the scheduling priority of this nomination in the supply chain coordination process.. Valid values are `first_come_first_served|contract_entitlement|strategic_customer|force_majeure|operational_constraint`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for nomination rejection, such as insufficient production capacity, contract limit exceeded, or delivery point unavailable.',
    `rejection_reason_description` STRING COMMENT 'Detailed explanation of why the nomination was rejected, providing context for commercial and operational teams.',
    `revision_number` STRING COMMENT 'Sequential version number tracking revisions to the original nomination, incremented each time the buyer submits a revised nomination.',
    `scheduling_priority` STRING COMMENT 'Numeric priority ranking for scheduling the nomination relative to other nominations, typically based on submission time, contract terms, or commercial agreements.',
    `special_instructions` STRING COMMENT 'Free-text field for buyer-provided special handling instructions, quality requirements, or logistical notes relevant to the nomination.',
    `submission_method` STRING COMMENT 'Channel or method through which the buyer submitted the nomination, such as Electronic Data Interchange (EDI), web portal, or email.. Valid values are `edi|email|portal|phone|fax`',
    `variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance between nominated and confirmed volumes, calculated as (variance_volume / nominated_volume) * 100, used for allocation performance tracking.',
    `variance_volume` DECIMAL(18,2) COMMENT 'Difference between nominated volume and confirmed volume, calculated as confirmed minus nominated, indicating allocation shortfall or surplus.',
    `volume_uom` STRING COMMENT 'Unit of measure for the nominated volume, typically metric tons (MT) for petrochemicals, barrels (BBL) for liquids, or cubic meters (M3) for gases. [ENUM-REF-CANDIDATE: MT|BBL|GAL|KG|LB|M3|MMBTU — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_offtake_nomination PRIMARY KEY(`offtake_nomination_id`)
) COMMENT 'Transactional record capturing buyer nominations for petrochemical product liftings under term offtake agreements, including nomination date, product type, nominated volume, delivery window, delivery point, buyer reference, contract reference, nomination status (submitted, confirmed, revised, rejected), and scheduling priority. Supports commercial scheduling and supply chain coordination between the petrochemical and commercial domains.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` (
    `waste_disposal_record_id` BIGINT COMMENT 'Unique identifier for the waste disposal record. Primary key for the waste disposal transaction.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Waste manifests and disposal activities trigger regulatory reporting requirements (RCRA biennial reports, state hazardous waste reports). Links disposal records to regulatory submissions for complianc',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific conversion unit or process unit within the plant that generated the waste. Enables unit-level waste tracking and performance analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Waste disposal costs allocated to cost centers for environmental compliance cost tracking and budget variance analysis.',
    `contractor_id` BIGINT COMMENT 'Reference to the licensed waste disposal contractor or treatment facility that received and processed the waste. Links to vendor master data for contractor performance tracking and compliance verification.',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Turnaround waste disposal charged to turnaround AFE for project cost tracking. Major remediation projects also AFE-controlled.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Waste disposal posts to environmental compliance GL accounts for financial statement preparation and regulatory cost reporting.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Waste disposal costs in JV facilities are joint account charges billed under JOA environmental compliance provisions. Required for COPAS billing, partner cost allocation, and tracking environmental co',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Hazardous waste disposal requires permits under RCRA and state programs. Waste_disposal_record tracks regulatory_permit_number; FK enables permit capacity tracking, expiration monitoring, and ensures ',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant facility where the waste was generated. Links to the plant master data for site-level reporting and compliance tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the production or environmental engineer responsible for overseeing the waste disposal transaction and ensuring regulatory compliance.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Hazardous waste from petrochemical plants requires EPA manifest documentation and shipment tracking to disposal facilities. Links waste disposal records to transport documentation for RCRA compliance,',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Waste disposal often occurs during turnaround events when units are cleaned and maintained. Linking disposal records to turnaround events enables cost allocation and environmental compliance tracking.',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Improper waste disposal (unpermitted disposal, manifest violations, NORM handling) can result in regulatory violations. Links disposal records to violations for evidence documentation, root cause anal',
    `waste_manifest_id` BIGINT COMMENT 'Foreign key linking to hse.waste_manifest. Business justification: Waste disposal records should reference the official RCRA manifest. Compliance tracking and audit trails require linking internal petrochemical disposal records to the regulatory waste manifest.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure number approving the waste disposal cost. Links disposal expenses to capital or operating budgets for financial control and variance analysis.. Valid values are `^AFE[0-9]{6,10}$`',
    `certification_date` DATE COMMENT 'Date when the disposal facility certified that the waste was properly disposed of according to regulatory requirements. Triggers closure of the disposal transaction and compliance reporting.',
    `certification_number` STRING COMMENT 'Unique certificate number issued by the disposal facility confirming proper treatment and disposal. Required for audit trail and regulatory compliance documentation.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `compliance_status` STRING COMMENT 'Assessment of whether this disposal transaction meets all applicable EPA, OSHA, and state environmental regulations. Non-compliant status triggers corrective action workflows.. Valid values are `compliant|non_compliant|pending_review|waiver_approved`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this waste disposal record was first created in the system. Used for audit trail and data lineage tracking.',
    `disposal_cost_usd` DECIMAL(18,2) COMMENT 'Total cost incurred for the waste disposal service, including transportation, treatment, and disposal fees. Used for OPEX tracking and cost allocation to generating units.',
    `disposal_date` DATE COMMENT 'The date when the waste was physically disposed of at the treatment, storage, or disposal facility. This is the principal business event timestamp for the disposal transaction.',
    `disposal_facility_epa_code` STRING COMMENT 'Twelve-character EPA identification number assigned to the disposal facility under RCRA regulations. Format is two-letter state code plus nine digits. Required for all hazardous waste shipments.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `disposal_manifest_number` STRING COMMENT 'Unique manifest number assigned to the waste disposal shipment, required for hazardous waste tracking under EPA regulations. Also known as the uniform hazardous waste manifest number.. Valid values are `^[A-Z0-9]{8,20}$`',
    `disposal_method` STRING COMMENT 'The method used to dispose of or treat the waste material. Incineration includes thermal destruction. Treatment covers chemical, physical, or biological processing. Deep well injection is used for liquid wastes. Solidification stabilizes waste for landfill disposal.. Valid values are `incineration|landfill|recycling|treatment|deep_well_injection|solidification`',
    `disposal_status` STRING COMMENT 'Current lifecycle status of the waste disposal transaction, tracking the waste from generation through final disposal certification.. Valid values are `scheduled|in_transit|received|disposed|certified|rejected`',
    `disposal_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the waste disposal process was completed, including time zone information for multi-site operations.',
    `epa_waste_code` STRING COMMENT 'Four-character EPA hazardous waste code assigned under RCRA regulations. F-codes are from non-specific sources, K-codes from specific sources, P and U codes for discarded commercial chemical products, D-codes for characteristic wastes.. Valid values are `^[DFKPU][0-9]{3}$`',
    `generator_epa_code` STRING COMMENT 'Twelve-character EPA identification number assigned to the waste generator facility (the petrochemical plant). Required on all hazardous waste manifests.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `ghg_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions associated with the waste disposal method, measured in metric tons of CO2 equivalent. Includes emissions from transportation and treatment processes. Supports ESG reporting and carbon footprint tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this waste disposal record. Supports change tracking and audit compliance.',
    `norm_activity_level_bq` DECIMAL(18,2) COMMENT 'Radioactivity level of NORM waste measured in Becquerels. Required for NORM waste classification and disposal facility selection. NORM is commonly found in scale, sludge, and produced water from oil and gas operations.',
    `ptw_number` STRING COMMENT 'Permit to Work number authorizing the waste handling and disposal activity. Ensures HSE compliance and proper safety procedures during waste generation and packaging.. Valid values are `^PTW[0-9]{8,12}$`',
    `quantity_uom` STRING COMMENT 'Unit of measure for the waste quantity. MT is metric tons, BBL is barrels, M3 is cubic meters. Selection depends on waste type and disposal facility requirements.. Valid values are `kg|mt|bbl|gal|m3|lbs`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special handling instructions, incident reports, or deviations from standard disposal procedures. Used for audit documentation and knowledge capture.',
    `transporter_epa_code` STRING COMMENT 'Twelve-character EPA identification number of the licensed hazardous waste transporter who moved the waste from generator to disposal facility. Multiple transporters may be involved in a single shipment.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `waste_classification` STRING COMMENT 'EPA hazard classification of the waste. RCRA listed refers to wastes specifically listed in EPA regulations. RCRA characteristic refers to wastes exhibiting ignitability, corrosivity, reactivity, or toxicity. Mixed waste contains both hazardous and radioactive components.. Valid values are `hazardous|non_hazardous|universal|mixed|rcra_listed|rcra_characteristic`',
    `waste_description` STRING COMMENT 'Detailed textual description of the waste material, including physical state, chemical composition, source process, and any special handling requirements. Used for manifest documentation and disposal facility communication.',
    `waste_quantity` DECIMAL(18,2) COMMENT 'The quantity of waste material disposed in this transaction. Must be reported with corresponding unit of measure for regulatory compliance and cost allocation.',
    `waste_type` STRING COMMENT 'Classification of the waste material type. NORM refers to Naturally Occurring Radioactive Material. Spent catalyst includes deactivated catalysts from cracking and reforming units. Chemical waste covers process chemicals and byproducts.. Valid values are `spent_catalyst|norm|chemical_waste|wastewater|sludge|contaminated_soil`',
    `work_order_number` STRING COMMENT 'Maximo work order number associated with the waste generation activity, such as catalyst changeout, tank cleaning, or maintenance turnaround. Links disposal records to maintenance activities.. Valid values are `^WO[0-9]{8,12}$`',
    CONSTRAINT pk_waste_disposal_record PRIMARY KEY(`waste_disposal_record_id`)
) COMMENT 'Transactional record capturing hazardous and non-hazardous waste disposal events from petrochemical plant operations, including waste type (spent catalyst, NORM, chemical waste, wastewater), quantity disposed, disposal method (incineration, landfill, recycling, treatment), disposal contractor reference, manifest number, regulatory permit reference, disposal date, and EPA/OSHA compliance certification. Supports environmental compliance reporting and NORM management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` (
    `plant_capacity_plan_id` BIGINT COMMENT 'Unique identifier for the plant capacity plan record. Primary key for the plant capacity plan master data.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific conversion unit (cracker, fractionator, polymerization unit, etc.) within the plant for which capacity is planned.',
    `cost_center_id` BIGINT COMMENT 'Reference to the SAP CO cost center responsible for this capacity plan. Used for cost allocation and financial reporting.',
    `jv_budget_id` BIGINT COMMENT 'Foreign key linking to venture.jv_budget. Business justification: Annual capacity plans for JV plants must align with approved JV budget and work program per JOA operating committee requirements. Planning volumes drive partner cash calls, AFE submissions, and budget',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant facility for which this capacity plan is defined. Links to the plant master data.',
    `employee_id` BIGINT COMMENT 'Reference to the user or role who approved the capacity plan. Links to employee or user master data for audit trail purposes.',
    `simulation_run_id` BIGINT COMMENT 'Reference to the Aspen HYSYS or other process simulation run that generated the capacity and yield assumptions for this plan. Enables traceability to engineering models.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Plant capacity plans must account for scheduled turnarounds which impact available capacity and throughput. Linking plans to turnaround events enables accurate capacity forecasting. Cardinality: N:1 (',
    `actual_opex_total_usd` DECIMAL(18,2) COMMENT 'Actual operating expenditure incurred for the conversion unit during the planning period, expressed in United States Dollars. Populated after period close for planned versus actual variance analysis.',
    `actual_throughput_volume` DECIMAL(18,2) COMMENT 'Actual feedstock throughput volume achieved during the planning period. Populated after period close for planned versus actual variance analysis.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure number associated with capital investments or major maintenance activities included in the capacity plan. Links to joint venture accounting when applicable.',
    `approval_status` STRING COMMENT 'Current approval status of the capacity plan. Indicates whether the plan is pending review, approved for execution, rejected, or requires revision before approval.. Valid values are `pending|approved|rejected|revision_required`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the capacity plan was approved. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX) for audit trail and compliance purposes.',
    `capacity_constraint_description` STRING COMMENT 'Description of known capacity constraints or bottlenecks that limit throughput below nameplate capacity. May include equipment limitations, feedstock availability, utility constraints, environmental permit limits, or market demand constraints.',
    `capacity_uom` STRING COMMENT 'Unit of measure for capacity and throughput volumes. Common units include metric tons (MT), thousand metric tons (KMT), barrels (BBL), thousand barrels (MBBL), million barrels (MMBBL), thousand cubic feet per day (MCFD), million cubic feet per day (MMCFD), barrel of oil equivalent (BOE), thousand barrel of oil equivalent (MBOE). [ENUM-REF-CANDIDATE: MT|KMT|BBL|MBBL|MMBBL|MCFD|MMCFD|BOE|MBOE — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the capacity plan record was first created in the system. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX) for audit trail purposes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the capacity plan record was most recently modified. Recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX) for change tracking and audit trail purposes.',
    `nameplate_capacity` DECIMAL(18,2) COMMENT 'Maximum design capacity of the conversion unit under optimal operating conditions. Represents the theoretical maximum throughput volume as specified by the engineering design.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the capacity plan. May include assumptions, constraints, risks, or other contextual information relevant to plan execution and variance analysis.',
    `opex_variance_pct` DECIMAL(18,2) COMMENT 'Variance between actual and planned operating expenditure expressed as a percentage. Calculated as (actual - planned) / planned * 100. Used for OPEX benchmarking and performance management.',
    `opex_variance_usd` DECIMAL(18,2) COMMENT 'Variance between actual and planned operating expenditure expressed in United States Dollars. Calculated as actual OPEX minus planned OPEX. Positive values indicate cost overrun, negative values indicate cost savings.',
    `period_close_flag` BOOLEAN COMMENT 'Indicates whether the planning period has been closed and actual results have been finalized. True if period is closed and no further changes are allowed, False if period is still open for updates.',
    `plan_number` STRING COMMENT 'Business identifier for the capacity plan. Externally visible plan reference number used in production planning and supply chain coordination.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the capacity plan. Indicates whether the plan is in draft, approved for execution, active, revised, superseded by a newer plan, or closed.. Valid values are `draft|approved|active|revised|superseded|closed`',
    `plan_type` STRING COMMENT 'Classification of the capacity plan by planning horizon and purpose. Distinguishes between annual strategic plans, quarterly tactical plans, and monthly operational plans.. Valid values are `annual|quarterly|monthly|tactical|strategic`',
    `planned_catalyst_cost_usd` DECIMAL(18,2) COMMENT 'Planned catalyst cost component of OPEX for the planning period. Includes catalyst purchases, regeneration, and disposal costs.',
    `planned_chemicals_cost_usd` DECIMAL(18,2) COMMENT 'Planned chemicals and consumables cost component of OPEX for the planning period. Includes process chemicals, additives, and consumable materials.',
    `planned_contract_services_cost_usd` DECIMAL(18,2) COMMENT 'Planned contract services cost component of OPEX for the planning period. Includes third-party operations, maintenance contracts, technical services, and outsourced activities.',
    `planned_energy_cost_usd` DECIMAL(18,2) COMMENT 'Planned energy cost component of OPEX for the planning period. Includes electricity, natural gas, steam, and other energy consumption costs.',
    `planned_environmental_compliance_cost_usd` DECIMAL(18,2) COMMENT 'Planned environmental compliance cost component of OPEX for the planning period. Includes emissions monitoring, environmental reporting, permit fees, and compliance activities.',
    `planned_maintenance_cost_usd` DECIMAL(18,2) COMMENT 'Planned maintenance cost component of OPEX for the planning period. Includes preventive maintenance, corrective maintenance, spare parts, and turnaround costs.',
    `planned_opex_total_usd` DECIMAL(18,2) COMMENT 'Total planned operating expenditure for the conversion unit during the planning period, expressed in United States Dollars. Includes all OPEX categories: energy, catalyst, chemicals, maintenance, contract services, waste disposal, and environmental compliance.',
    `planned_product_slate` STRING COMMENT 'Description of the planned product mix and yield targets for the planning period. Specifies the target distribution of output products (ethylene, propylene, butadiene, benzene, toluene, xylene, LPG, naphtha, specialty chemicals, etc.).',
    `planned_throughput_volume` DECIMAL(18,2) COMMENT 'Planned feedstock throughput volume for the planning period. Calculated as nameplate capacity multiplied by planned utilization rate and planning period duration.',
    `planned_utilization_rate_pct` DECIMAL(18,2) COMMENT 'Planned utilization rate expressed as a percentage of nameplate capacity. Accounts for planned downtime, maintenance turnarounds, and operational constraints. Typical range 70-95%.',
    `planned_waste_disposal_cost_usd` DECIMAL(18,2) COMMENT 'Planned waste disposal cost component of OPEX for the planning period. Includes hazardous waste disposal, wastewater treatment, and solid waste management costs.',
    `planning_period_end` DATE COMMENT 'End date of the planning horizon covered by this capacity plan. Defines the conclusion of the period for which capacity and operating expenditure are planned.',
    `planning_period_start` DATE COMMENT 'Start date of the planning horizon covered by this capacity plan. Defines the beginning of the period for which capacity and operating expenditure are planned.',
    `sap_production_plan_number` STRING COMMENT 'Reference to the SAP PP production plan or sales and operations planning (S&OP) document that this capacity plan supports. Enables integration with enterprise resource planning.',
    `scheduled_downtime_hours` DECIMAL(18,2) COMMENT 'Total planned downtime hours for the planning period. Includes scheduled maintenance turnarounds, catalyst changes, inspections, and planned outages. Used to calculate planned utilization rate.',
    `throughput_variance_pct` DECIMAL(18,2) COMMENT 'Variance between actual and planned throughput expressed as a percentage. Calculated as (actual - planned) / planned * 100. Positive values indicate over-performance, negative values indicate under-performance.',
    `turnaround_flag` BOOLEAN COMMENT 'Indicates whether a major maintenance turnaround is scheduled during the planning period. True if a turnaround is planned, False otherwise. Turnarounds significantly impact capacity availability and operating expenditure.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element for project-based capacity planning. Links capacity plan to capital projects or major initiatives when applicable.',
    CONSTRAINT pk_plant_capacity_plan PRIMARY KEY(`plant_capacity_plan_id`)
) COMMENT 'Master record for planned production capacity and operating expenditure by plant and conversion unit for a defined planning horizon (monthly, quarterly, annual). Captures nameplate capacity, planned utilization rate, planned throughput volume, planned product slate, scheduled downtime allowances, capacity constraints, and planned vs actual OPEX by cost category (energy, catalyst, chemicals, maintenance, contract services, waste disposal, environmental compliance). Integrates with SAP PP production planning and SAP CO cost objects. Supports supply chain commitment management and OPEX benchmarking.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` (
    `mass_balance_id` BIGINT COMMENT 'Unique identifier for the mass balance reconciliation record.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific conversion unit (cracker, fractionator, reactor) for which mass balance is calculated.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Mass balance variances impact cost center performance metrics and inventory valuation. Unaccounted losses affect cost per unit.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: Mass balance reconciliation in JV plants supports production allocation to partners per working interest and cost recovery calculations under PSA terms. Required for entitlement determination, overlif',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant where the mass balance reconciliation was performed.',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer responsible for reviewing and approving the mass balance reconciliation.',
    `production_order_id` BIGINT COMMENT 'Reference to the SAP production order associated with this mass balance period.',
    `simulation_run_id` BIGINT COMMENT 'Reference to the Aspen HYSYS simulation run used for process modeling and mass balance validation.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to petrochemical.turnaround_event. Business justification: Mass balance records during turnaround periods should reference the turnaround event for performance analysis and reconciliation of material losses during shutdown/startup. Cardinality: N:1 (many bala',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the mass balance reconciliation was approved.',
    `balance_period_end` DATE COMMENT 'End date of the reconciliation period for which mass balance is calculated.',
    `balance_period_start` DATE COMMENT 'Start date of the reconciliation period for which mass balance is calculated.',
    `balance_record_number` STRING COMMENT 'Business identifier for the mass balance reconciliation record, formatted as MB-YYYYMMDD-UNITID.. Valid values are `^MB-[0-9]{8}-[A-Z0-9]{6}$`',
    `balance_status` STRING COMMENT 'Current lifecycle status of the mass balance reconciliation record.. Valid values are `draft|submitted|approved|rejected|closed|under_review`',
    `balance_timestamp` TIMESTAMP COMMENT 'Date and time when the mass balance reconciliation was calculated and recorded.',
    `benzene_output_mt` DECIMAL(18,2) COMMENT 'Mass of benzene product output during the balance period, measured in metric tons.',
    `butadiene_output_mt` DECIMAL(18,2) COMMENT 'Mass of butadiene product output during the balance period, measured in metric tons.',
    `butane_input_mt` DECIMAL(18,2) COMMENT 'Mass of butane feedstock input during the balance period, measured in metric tons.',
    `closure_pct` DECIMAL(18,2) COMMENT 'Percentage representing the closure of the mass balance, calculated as (total output + utilities + flare + loss) / total input * 100. Target is 100%, acceptable range typically 98-102%.',
    `cooling_water_consumption_m3` DECIMAL(18,2) COMMENT 'Total volume of cooling water consumed during the balance period, measured in cubic meters.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this mass balance record was first created in the system.',
    `ethane_input_mt` DECIMAL(18,2) COMMENT 'Mass of ethane feedstock input during the balance period, measured in metric tons.',
    `ethylene_output_mt` DECIMAL(18,2) COMMENT 'Mass of ethylene product output during the balance period, measured in metric tons.',
    `flare_volume_mt` DECIMAL(18,2) COMMENT 'Total mass of hydrocarbons flared during the balance period, measured in metric tons.',
    `fuel_gas_output_mt` DECIMAL(18,2) COMMENT 'Mass of fuel gas product output during the balance period, measured in metric tons.',
    `fuel_oil_output_mt` DECIMAL(18,2) COMMENT 'Mass of fuel oil product output during the balance period, measured in metric tons.',
    `gas_oil_input_mt` DECIMAL(18,2) COMMENT 'Mass of gas oil feedstock input during the balance period, measured in metric tons.',
    `ghg_emissions_mt_co2e` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions associated with this mass balance period, measured in metric tons of CO2 equivalent.',
    `lpg_output_mt` DECIMAL(18,2) COMMENT 'Mass of LPG product output during the balance period, measured in metric tons.',
    `naphtha_input_mt` DECIMAL(18,2) COMMENT 'Mass of naphtha feedstock input during the balance period, measured in metric tons.',
    `power_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electrical power consumed during the balance period, measured in megawatt hours.',
    `propane_input_mt` DECIMAL(18,2) COMMENT 'Mass of propane feedstock input during the balance period, measured in metric tons.',
    `propylene_output_mt` DECIMAL(18,2) COMMENT 'Mass of propylene product output during the balance period, measured in metric tons.',
    `pyrolysis_gasoline_output_mt` DECIMAL(18,2) COMMENT 'Mass of pyrolysis gasoline product output during the balance period, measured in metric tons.',
    `steam_consumption_mt` DECIMAL(18,2) COMMENT 'Total mass of steam consumed as utility during the balance period, measured in metric tons.',
    `toluene_output_mt` DECIMAL(18,2) COMMENT 'Mass of toluene product output during the balance period, measured in metric tons.',
    `total_feedstock_input_mt` DECIMAL(18,2) COMMENT 'Total mass of all feedstock streams input to the conversion unit during the balance period, measured in metric tons.',
    `total_product_output_mt` DECIMAL(18,2) COMMENT 'Total mass of all product streams output from the conversion unit during the balance period, measured in metric tons.',
    `unaccounted_loss_mt` DECIMAL(18,2) COMMENT 'Mass of material that cannot be accounted for in the mass balance (input minus output minus utilities minus flare), measured in metric tons.',
    `unit_type` STRING COMMENT 'Type of conversion unit for which the mass balance is being reconciled. [ENUM-REF-CANDIDATE: steam_cracker|catalytic_cracker|ngl_fractionator|lpg_splitter|gtl_reactor|polymerization_unit|hydrocracker|reformer — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this mass balance record was last modified.',
    `variance_mt` DECIMAL(18,2) COMMENT 'Absolute variance between total input and total output plus utilities plus flare plus loss, measured in metric tons.',
    `variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance from perfect mass balance closure, calculated as (variance / total input) * 100.',
    `variance_root_cause` STRING COMMENT 'Classification of the root cause for mass balance variance, used for continuous improvement and loss control. [ENUM-REF-CANDIDATE: measurement_error|calibration_drift|process_leak|inventory_change|sampling_error|calculation_error|unknown|acceptable_tolerance — 8 candidates stripped; promote to reference product]',
    `xylene_output_mt` DECIMAL(18,2) COMMENT 'Mass of xylene product output during the balance period, measured in metric tons.',
    CONSTRAINT pk_mass_balance PRIMARY KEY(`mass_balance_id`)
) COMMENT 'Transactional record capturing the periodic mass balance reconciliation for each conversion unit and plant, comparing total feedstock inputs against total product outputs, utility consumption, losses, and flaring. Records balance period, input volumes by feedstock stream, output volumes by product fraction, unaccounted losses, mass balance closure percentage, and variance root cause classification. Essential for yield accounting, loss control, and regulatory reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` (
    `catalyst_record_id` BIGINT COMMENT 'Unique identifier for the catalyst record. Primary key for the catalyst_record product.',
    `catalyst_id` BIGINT COMMENT 'Reference to the master catalyst definition in the feedstock or refining catalyst_lifecycle product for shared catalyst master data.',
    `conversion_unit_id` BIGINT COMMENT 'Reference to the specific conversion unit (cracker, reformer, polymerization reactor) where the catalyst is installed.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor or waste management company that handled the catalyst disposal.',
    `employee_id` BIGINT COMMENT 'Reference to the process engineer or catalyst specialist responsible for managing this catalyst record and performance monitoring.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to asset.equipment. Business justification: Catalyst is loaded into specific equipment (reactors, regenerators) for maintenance work order tracking, equipment history, turnaround planning, and NORM disposal compliance. Required for equipment-sp',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Catalyst costs post to GL accounts (materials inventory, capex, opex) for financial statement preparation and capitalization decisions.',
    `plant_id` BIGINT COMMENT 'Reference to the petrochemical plant where the catalyst is deployed.',
    `turnaround_event_id` BIGINT COMMENT 'Reference to the turnaround event during which the catalyst was loaded or replaced. Links catalyst lifecycle to major maintenance events.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or manufacturer who provided the catalyst.',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Catalyst purchases and regeneration in JV plants are typically capitalized expenditures requiring AFE approval from partners per JOA thresholds. Links catalyst costs to authorized AFE for JIB billing ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Catalyst projects tracked in WBS for project accounting, enabling cost collection and settlement to fixed assets or expense.',
    `previous_catalyst_record_id` BIGINT COMMENT 'Self-referencing FK on catalyst_record (previous_catalyst_record_id)',
    `activity_level_pct` DECIMAL(18,2) COMMENT 'Current catalytic activity level as a percentage of fresh catalyst performance. Declining activity indicates deactivation and need for regeneration or replacement.',
    `afe_number` STRING COMMENT 'Authorization for Expenditure (AFE) number to which the catalyst cost is charged. Links catalyst investment to capital project or turnaround budget.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for traceability and quality assurance. Critical for tracking catalyst performance and warranty claims.',
    `catalyst_grade` STRING COMMENT 'Manufacturer-specific grade or formulation designation for the catalyst, indicating performance characteristics and application suitability.',
    `catalyst_type` STRING COMMENT 'Classification of catalyst by chemical composition and function (e.g., zeolite, platinum-based, nickel-molybdenum, polymerization catalyst, cracking catalyst).',
    `cost_center_code` STRING COMMENT 'SAP cost center code to which Operating Expenditure (OPEX) for catalyst regeneration or disposal is allocated.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for catalyst cost (United States Dollar, Euro, British Pound, Canadian Dollar, Australian Dollar, Japanese Yen, Chinese Yuan). [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|JPY|CNY — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalyst record was first created in the system. Used for audit trail and data lineage.',
    `current_age_days` STRING COMMENT 'Current age of the catalyst in days since initial loading, used to track deactivation rate and plan regeneration or replacement.',
    `deactivation_mechanism` STRING COMMENT 'Primary mechanism causing catalyst deactivation (coking, poisoning by contaminants, sintering, fouling, physical attrition, thermal degradation). Informs regeneration strategy.. Valid values are `coking|poisoning|sintering|fouling|attrition|thermal_degradation`',
    `deactivation_rate_pct_per_day` DECIMAL(18,2) COMMENT 'Rate at which catalyst activity declines per day of operation, expressed as percentage points per day. Used for predictive maintenance and regeneration planning.',
    `disposal_date` DATE COMMENT 'Date when the catalyst was permanently removed from service and disposed of or sent for reclamation. Marks the end of the catalyst lifecycle.',
    `disposal_method` STRING COMMENT 'Method used to dispose of spent catalyst (landfill, incineration, metal reclamation, recycling, hazardous waste disposal). Must comply with EPA and NORM regulations.. Valid values are `landfill|incineration|reclamation|recycling|hazardous_waste_disposal`',
    `expected_life_months` STRING COMMENT 'Manufacturer-specified or engineering-estimated expected service life of the catalyst in months before replacement or regeneration is required.',
    `last_regeneration_date` DATE COMMENT 'Date of the most recent catalyst regeneration event. Used to calculate time since last regeneration and plan next regeneration cycle.',
    `loaded_quantity` DECIMAL(18,2) COMMENT 'Total quantity of catalyst loaded into the conversion unit, measured in the unit of measure specified.',
    `loading_date` DATE COMMENT 'Date when the catalyst was initially loaded or charged into the conversion unit. Marks the start of the catalyst service life.',
    `loading_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the catalyst loading operation was completed, including time zone information for multi-site coordination.',
    `metal_content_ppm` DECIMAL(18,2) COMMENT 'Concentration of active metal content (platinum, palladium, nickel, molybdenum) in the catalyst, measured in parts per million. Affects catalyst performance and reclamation value.',
    `next_regeneration_date` DATE COMMENT 'Scheduled date for the next catalyst regeneration based on activity decline, operating hours, or calendar-based maintenance strategy.',
    `norm_activity_level_bq` DECIMAL(18,2) COMMENT 'Measured radioactivity level of the catalyst in Becquerels, used to determine disposal requirements and worker safety protocols for NORM-contaminated catalysts.',
    `norm_classification` STRING COMMENT 'Classification of the catalyst based on Naturally Occurring Radioactive Material (NORM) content. Critical for safe handling, disposal, and regulatory compliance.. Valid values are `non_norm|norm_low|norm_medium|norm_high`',
    `quantity_uom` STRING COMMENT 'Unit of measure for catalyst quantity (kilograms, metric tons, pounds, tons).. Valid values are `kg|mt|lb|ton`',
    `record_number` STRING COMMENT 'Business-facing unique identifier for the catalyst record, typically generated by SAP or Maximo for tracking and audit purposes.',
    `record_status` STRING COMMENT 'Current lifecycle status of the catalyst record. Active indicates catalyst is in service; loaded indicates newly charged; regenerating indicates undergoing regeneration; deactivated indicates end of useful life; disposed indicates removed and disposed; retired indicates archived record.. Valid values are `active|loaded|regenerating|deactivated|disposed|retired`',
    `regeneration_count` STRING COMMENT 'Total number of regeneration cycles the catalyst has undergone. Tracks cumulative regeneration history to assess remaining useful life.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special handling instructions related to the catalyst record. Used for operational context and knowledge capture.',
    `selectivity_pct` DECIMAL(18,2) COMMENT 'Measure of the catalysts ability to produce the desired product versus undesired byproducts, expressed as a percentage. Higher selectivity indicates better performance.',
    `surface_area_m2_per_g` DECIMAL(18,2) COMMENT 'Specific surface area of the catalyst in square meters per gram, a key indicator of catalytic activity. Declining surface area indicates sintering or fouling.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost for the catalyst batch loaded, calculated as loaded quantity multiplied by unit cost. Allocated to Authorization for Expenditure (AFE) or cost center.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for the catalyst at the time of purchase. Used for inventory valuation and Capital Expenditure (CAPEX) tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this catalyst record was last modified. Tracks the most recent change for audit and data quality purposes.',
    `work_order_number` STRING COMMENT 'Maximo work order number for the catalyst loading, regeneration, or disposal activity. Links catalyst record to maintenance execution.',
    CONSTRAINT pk_catalyst_record PRIMARY KEY(`catalyst_record_id`)
) COMMENT 'Master and transactional record for catalyst inventory and lifecycle events in petrochemical conversion units, capturing catalyst type, grade, batch, loading date, regeneration events, deactivation tracking, and disposal. References refining.catalyst_lifecycle for shared catalyst master data where applicable.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` (
    `turnaround_work_order_id` BIGINT COMMENT 'Unique identifier for this turnaround-work order assignment record. Primary key.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to the turnaround event that this work order is assigned to',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to the Maximo work order being executed as part of this turnaround',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours for this work orders execution within the turnaround. Used for schedule performance measurement and future turnaround planning.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when this work order commenced execution within the turnaround event. Used for turnaround schedule variance analysis and critical path tracking.',
    `cost_allocation_pct` DECIMAL(18,2) COMMENT 'Percentage of this work orders total cost that is allocated to this specific turnaround event. Supports scenarios where a work order spans multiple turnarounds or where costs are shared across turnaround and routine maintenance budgets. Value between 0.00 and 100.00.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this work order is on the critical path for the turnaround schedule. Critical path work orders directly impact the turnaround duration and require priority resource allocation and close schedule monitoring.',
    `planned_duration_hours` DECIMAL(18,2) COMMENT 'Planned duration in hours for this work order within the turnaround schedule. Used for critical path analysis and resource leveling during turnaround planning.',
    `planned_start_date` DATE COMMENT 'Planned start date for this specific work order within the turnaround schedule. This is the turnaround-specific planned date, which may differ from the work orders general scheduled_start_date as it reflects the turnaround execution sequence.',
    `work_order_status` STRING COMMENT 'Status of this work order within the context of the turnaround event. Tracks whether the work order is planned for the turnaround, approved for execution, currently in progress, completed, deferred to a future turnaround, or cancelled. This is turnaround-specific status that complements the work orders general status.',
    `work_scope_category` STRING COMMENT 'Classification of the work scope for this work order within the context of the turnaround event. Categories include mechanical, electrical, instrumentation, inspection, civil, insulation, scaffolding, cleaning, testing, and commissioning. This categorization is specific to turnaround planning and may differ from the work orders general work_type.',
    CONSTRAINT pk_turnaround_work_order PRIMARY KEY(`turnaround_work_order_id`)
) COMMENT 'This association product represents the assignment of individual work orders to turnaround events in petrochemical plant maintenance operations. It captures the operational linkage between planned turnaround events and the specific Maximo work orders executed during those events, including work scope categorization, planned and actual execution timing, cost allocation percentages, and critical path status. Each record links one turnaround event to one work order with attributes that exist only in the context of this turnaround-specific execution.. Existence Justification: In petrochemical plant operations, turnaround events are major planned shutdowns that encompass hundreds of individual work orders across multiple units and equipment. A single turnaround event includes many work orders (mechanical repairs, inspections, equipment replacements, testing), and individual work orders can be associated with multiple turnaround events when work spans multiple turnaround phases or when concurrent turnarounds share common work packages. The business actively manages this relationship through turnaround planning systems, tracking work order assignment, scheduling, cost allocation, and critical path status for each turnaround-work order pairing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` (
    `plant_ownership_interest_id` BIGINT COMMENT 'Unique identifier for the plant ownership interest record. Primary key for the association.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the petrochemical plant in which the partner holds an ownership interest.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the venture partner who holds the ownership interest in the plant.',
    `billing_method` STRING COMMENT 'Method used to calculate and bill this partner for their share of plant costs. Direct = actual costs incurred, Proportional = based on WI%, Actual = metered usage, Deemed = contractual fixed allocation. Defined in the JOA or plant participation agreement.',
    `cost_center_allocation` STRING COMMENT 'Financial cost center code used for allocating this partners share of plant OPEX. May differ from the plants primary cost center to enable partner-specific financial tracking and reporting.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this ownership interest record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this ownership interest became effective. Used to track ownership changes over time, such as farm-ins, farm-outs, or partner exits. Critical for historical revenue and cost allocation.',
    `expiry_date` DATE COMMENT 'Date when this ownership interest expires or was terminated. Null for active ownership interests. Used to track partner exits, asset sales, or JV dissolution.',
    `interest_status` STRING COMMENT 'Current lifecycle status of this ownership interest. Active = partner is participating and being billed, Suspended = temporarily not participating (e.g., non-consent situation), Terminated = interest has ended, Pending = interest not yet effective.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of who last modified this ownership interest record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this ownership interest record was last updated.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The partners percentage entitlement to net revenues from the plant after deducting royalties, overriding royalties, and other burdens. Typically less than or equal to working interest percentage. Used for revenue distribution and profit allocation.',
    `operator_flag` BOOLEAN COMMENT 'Boolean indicator of whether this partner serves as the designated operator for this specific plant. The operator manages day-to-day operations, submits AFEs, and coordinates JIB meetings. Only one partner per plant should have this flag set to true.',
    `participation_agreement_reference` STRING COMMENT 'Reference number or identifier for the legal agreement governing this ownership interest (JOA, PSA, participation agreement, or asset purchase agreement). Links to contract management system.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners percentage ownership stake in the petrochemical plant, representing their share of capital investment and operational costs. Must sum to 100% across all partners for a given plant. Used for AFE cost allocation and capital call calculations.',
    `created_by` STRING COMMENT 'User ID or system identifier of who created this ownership interest record.',
    CONSTRAINT pk_plant_ownership_interest PRIMARY KEY(`plant_ownership_interest_id`)
) COMMENT 'This association product represents the ownership stake or working interest held by a venture partner in a petrochemical plant. It captures the financial and operational participation structure of joint venture partnerships in petrochemical manufacturing facilities. Each record links one plant to one partner with attributes that define the partners ownership percentage, revenue entitlement, operational role, and cost allocation method.. Existence Justification: In oil and gas joint ventures, petrochemical plants are routinely owned by multiple partners with different working interest percentages (e.g., 40% Partner A, 35% Partner B, 25% Partner C), and venture partners typically hold ownership stakes in multiple plants across their portfolio. This is the fundamental ownership structure in oil and gas joint ventures, governed by Joint Operating Agreements (JOAs) or Participation Agreements. The business actively manages these ownership interests for AFE cost allocation, revenue distribution, JIB billing, and partner reporting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` (
    `product_entitlement_id` BIGINT COMMENT 'Unique surrogate identifier for each product entitlement agreement record',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to the petrochemical product for which entitlement rights are granted',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner holding entitlement rights',
    `created_date` TIMESTAMP COMMENT 'System timestamp when this entitlement record was created in the master data system.',
    `delivery_point_preference` STRING COMMENT 'Preferred delivery location or terminal for this partners offtake of this product. May reference plant gate, pipeline connection point, marine terminal, or storage facility. Used for logistics planning and nomination scheduling.',
    `effective_date` DATE COMMENT 'Date from which this entitlement agreement becomes active and the partners rights to this product commence. Typically aligned with JOA effective date or plant commissioning date.',
    `entitlement_percentage` DECIMAL(18,2) COMMENT 'Percentage of production or inventory to which the partner is entitled for this specific product, based on their working interest and JOA terms. Sum of entitlement_percentage across all partners for a given product should equal 100%.',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of the entitlement agreement. ACTIVE = partner can nominate and lift, SUSPENDED = temporarily inactive due to payment default or force majeure, EXPIRED = past expiry_date, PENDING = signed but not yet effective, TERMINATED = cancelled before expiry.',
    `expiry_date` DATE COMMENT 'Date on which this entitlement agreement terminates and the partners rights to this product cease. May be null for indefinite agreements. Used for contract lifecycle management and renewal tracking.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this entitlement record.',
    `last_modified_date` TIMESTAMP COMMENT 'System timestamp when this entitlement record was last updated, used for change tracking and audit purposes.',
    `maximum_offtake_volume` DECIMAL(18,2) COMMENT 'Maximum volume (in uom_primary from product_catalog) that the partner is permitted to lift per period, preventing any single partner from over-lifting relative to their entitlement percentage.',
    `minimum_offtake_volume` DECIMAL(18,2) COMMENT 'Minimum volume (in uom_primary from product_catalog) that the partner is contractually obligated to lift per period (month/quarter/year). Used for take-or-pay enforcement and underlifting calculations.',
    `nomination_priority` STRING COMMENT 'Priority ranking for this partners nomination rights when product availability is constrained. Lower numbers indicate higher priority. Used during production shortfalls or maintenance periods to determine allocation sequence.',
    `offtake_rights_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the partner has active rights to physically lift or take delivery of this product. False indicates partner has financial entitlement only (cash settlement) without physical offtake rights.',
    `pricing_basis` STRING COMMENT 'Contractual pricing mechanism applicable to this partner for this product. SPOT = market price at lifting, CONTRACT = pre-negotiated fixed price, COST_PLUS = production cost plus margin, NETBACK = downstream value minus processing costs, INDEX_LINKED = tied to published index (e.g., Platts, ICIS).',
    `quality_specification_ref` STRING COMMENT 'Reference to partner-specific quality specifications or tolerances for this product, if different from the standard specification_sheet_ref in product_catalog. Used when partner has negotiated tighter or looser quality requirements.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for financial settlement of this partners entitlement to this product. May differ from the ventures base currency based on partner preference or regulatory requirements.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this entitlement record.',
    CONSTRAINT pk_product_entitlement PRIMARY KEY(`product_entitlement_id`)
) COMMENT 'This association product represents the contractual offtake rights between a petrochemical product and a joint venture partner. It captures partner-specific entitlement percentages, pricing terms, delivery preferences, and nomination priorities that exist only in the context of this relationship. Each record links one petrochemical product to one venture partner with attributes governing their commercial rights to that product.. Existence Justification: In petrochemical joint ventures, multiple partners hold simultaneous entitlement rights to the same product (e.g., ethylene from a shared cracker), and each partner has entitlement rights to multiple products produced by the venture. The business actively manages these entitlements through nomination processes, offtake scheduling, and entitlement balancing. This is not a transactional lifting record (those are separate events), but rather the standing contractual rights that govern who can lift what products under what terms.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` (
    `petrochemical_product_approval_id` BIGINT COMMENT 'Primary key for petrochemical_product_approval',
    `customer_counterparty_id` BIGINT COMMENT 'Foreign key linking to the customer counterparty who is approved to purchase this product',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the user or approver who authorized this customer-product approval, supporting audit trail and approval workflow requirements.',
    `product_approval_id` BIGINT COMMENT 'Unique surrogate identifier for each customer-product approval record',
    `product_catalog_id` BIGINT COMMENT 'Foreign key linking to the petrochemical product that is approved for sale to this customer',
    `approval_date` DATE COMMENT 'Date on which the customer was approved to purchase this petrochemical product, following completion of technical qualification, credit review, and regulatory compliance checks.',
    `approval_expiry_date` DATE COMMENT 'Date on which this product approval expires and requires renewal, driven by regulatory requirements, credit review cycles, or contract terms.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the customer product approval. Indicates whether the customer is currently authorized to purchase this petrochemical product.',
    `approved_grade` STRING COMMENT 'Specific product grade or specification that the customer is approved to purchase. A customer may be approved for polymer-grade propylene but not chemical-grade, based on their technical capabilities and intended use.',
    `approved_volume_bopd` DECIMAL(18,2) COMMENT 'Maximum approved daily volume in barrels of oil equivalent per day (BOPD) that this customer is authorized to purchase of this petrochemical product, based on credit limits, supply capacity, and contract terms.',
    `delivery_mode` STRING COMMENT 'Approved transportation and delivery method for this customer-product combination. Different products and customers may require different logistics modes based on infrastructure, volume, and safety requirements.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining delivery and risk transfer terms specific to this customer-product approval, which may differ from the customers default Incoterms.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this customer-product approval, supporting ongoing credit monitoring, compliance verification, and relationship management.',
    `notes` STRING COMMENT 'Free-text notes capturing special conditions, restrictions, or context specific to this customer-product approval (e.g., Requires pre-payment, Seasonal volume limits, Subject to force majeure clause).',
    `pricing_basis` STRING COMMENT 'Pricing mechanism applicable to this customer-product approval. Indicates whether pricing is spot market, long-term contract, formula-based (e.g., Platts + premium), or fixed price.',
    `regulatory_approval_ref` STRING COMMENT 'Reference to regulatory permits, export licenses, or compliance certifications required for selling this petrochemical product to this customer, particularly for cross-border transactions or hazardous materials.',
    `technical_qualification_ref` STRING COMMENT 'Document reference or certification number evidencing that the customer has the technical capability, storage infrastructure, and safety systems required to handle this petrochemical product.',
    CONSTRAINT pk_petrochemical_product_approval PRIMARY KEY(`petrochemical_product_approval_id`)
) COMMENT 'This association product represents the regulatory and commercial approval relationship between petrochemical products and customer counterparties. It captures the business process by which customers are qualified and authorized to purchase specific petrochemical products, including volume limits, pricing terms, delivery specifications, and technical qualifications. Each record links one petrochemical product to one customer counterparty with approval-specific attributes that exist only in the context of this commercial relationship.. Existence Justification: In oil and gas petrochemical sales, customer product approvals are a genuine operational M:N relationship. Each customer counterparty (IOC, NOC, refiner, trader, industrial consumer) can be approved to purchase multiple petrochemical products (ethylene, propylene, benzene, polymers, etc.), and each petrochemical product is sold to multiple approved customers across different market segments. The approval process is an active business function managed by commercial teams, involving credit assessment, technical qualification verification, regulatory compliance checks, and contract negotiation. Each approval carries relationship-specific data including approved volume limits, pricing basis, delivery mode, technical qualifications, and expiry dates that cannot be stored on either the product or customer entity alone.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` (
    `unit_integrity_enrollment_id` BIGINT COMMENT 'Unique identifier for this unit-program enrollment record. Primary key.',
    `conversion_unit_id` BIGINT COMMENT 'Foreign key to petrochemical.conversion_unit. Identifies which conversion unit is enrolled.',
    `integrity_program_id` BIGINT COMMENT 'Foreign key to asset.integrity_program. Identifies which integrity program governs this enrollment.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this enrollment record was created in the system.',
    `enrollment_notes` STRING COMMENT 'Free-text notes documenting unit-specific considerations, exceptions, or special requirements for this program enrollment.',
    `inspection_interval_override_months` STRING COMMENT 'Unit-specific override of the standard inspection interval defined in the integrity program. Allows tailoring inspection frequency based on unit-specific risk factors, operating conditions, or regulatory requirements. Explicitly identified in detection reasoning as relationship data.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent integrity assessment performed on this unit under this program. Used to calculate next due date and track compliance with program requirements. Explicitly identified in detection reasoning as relationship data.',
    `modified_date` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next integrity assessment of this unit under this program. Calculated based on enrollment date, inspection interval override, and last assessment date. Critical for compliance tracking and turnaround planning. Explicitly identified in detection reasoning as relationship data.',
    `program_enrollment_date` DATE COMMENT 'Date when this conversion unit was enrolled into this specific integrity program. Explicitly identified in detection reasoning as relationship data.',
    `program_status` STRING COMMENT 'Current status of this units enrollment in this integrity program. Allows units to be temporarily suspended from a program during turnarounds or permanently completed when units are decommissioned. Explicitly identified in detection reasoning as relationship data.',
    `risk_category_override` STRING COMMENT 'Unit-specific risk category assignment that may override the programs default risk threshold based on RBI assessment results, operating severity, or consequence of failure analysis. Explicitly identified in detection reasoning as relationship data.',
    CONSTRAINT pk_unit_integrity_enrollment PRIMARY KEY(`unit_integrity_enrollment_id`)
) COMMENT 'This association product represents the enrollment of a conversion unit into an asset integrity management program. It captures program-specific enrollment dates, inspection interval overrides, risk category assignments, and assessment schedules that exist only in the context of this unit-program relationship. Each record links one conversion unit to one integrity program with attributes that govern how that specific program is executed for that specific unit.. Existence Justification: In oil and gas operations, conversion units (steam crackers, FCC units, reactors) must participate in multiple integrity programs simultaneously to meet regulatory and safety requirements. A single conversion unit is enrolled in corrosion management, RBI, fatigue management, and PSM programs concurrently, each with different inspection strategies and schedules. Conversely, each integrity program (e.g., API 580 RBI program) governs multiple conversion units across facilities. The business actively manages these enrollments with unit-specific risk overrides, inspection interval adjustments, and assessment schedules.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` (
    `plant_carrier_contract_id` BIGINT COMMENT 'Unique identifier for the plant-carrier service contract relationship. Primary key for the association.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to the transportation carrier that is party to this service contract',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the petrochemical plant that is party to this carrier service contract',
    `approved_product_types_for_plant` STRING COMMENT 'Comma-separated list of specific petrochemical product types that this carrier is approved to transport from this specific plant, which may be a subset of the carriers overall approved products based on plant-specific requirements or certifications.',
    `contract_effective_date` DATE COMMENT 'The date on which the transportation service contract between the plant and carrier becomes active and enforceable. Identified in detection phase relationship data.',
    `contract_expiry_date` DATE COMMENT 'The date on which the current transportation service contract between the plant and carrier expires and requires renewal. Identified in detection phase relationship data.',
    `contract_owner_name` STRING COMMENT 'Full name of the logistics manager or contract administrator responsible for managing this specific plant-carrier relationship and contract performance.',
    `contract_reference_number` STRING COMMENT 'The unique identifier of the master transportation services agreement or contract governing the relationship with this carrier. [Moved from carrier: This attribute currently exists in the carrier master but represents a generic contract reference. In reality, each plant-carrier relationship has its own specific contract with unique terms, so this should be an attribute of the plant_carrier_contract association (e.g., contract_reference_number) rather than a single value on the carrier master.]',
    `contract_status` STRING COMMENT 'Current lifecycle status of the plant-carrier service contract. Indicates whether the contract is currently in force, expired, or under review.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this carrier at this plant. Used to track regular business review cadence.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next formal performance review of this carrier at this plant. Used for proactive relationship management.',
    `performance_score` DECIMAL(18,2) COMMENT 'Calculated performance metric for this carrier at this specific plant, based on on-time delivery, incident rate, and service quality. Used for carrier evaluation and contract renewal decisions. Identified in detection phase relationship data.',
    `preferred_carrier_flag` BOOLEAN COMMENT 'Indicates whether this carrier is designated as a preferred or primary carrier for this specific plant, typically receiving priority allocation of volumes. Identified in detection phase relationship data.',
    `rate_schedule` STRING COMMENT 'Reference to the negotiated rate schedule or tariff structure applicable to this plant-carrier contract, which may vary by product type, distance, or volume tier. Identified in detection phase relationship data.',
    `volume_commitment_bbl` DECIMAL(18,2) COMMENT 'The contractually committed transportation volume in barrels that the plant agrees to tender to this carrier over the contract period. Used for capacity planning and rate negotiation. Identified in detection phase relationship data.',
    CONSTRAINT pk_plant_carrier_contract PRIMARY KEY(`plant_carrier_contract_id`)
) COMMENT 'This association product represents the contractual logistics service agreement between a petrochemical plant and a transportation carrier. It captures the negotiated terms, volume commitments, rate schedules, and performance metrics that govern the transportation relationship. Each record links one plant to one carrier with attributes that exist only in the context of this specific service contract.. Existence Justification: In oil and gas logistics operations, petrochemical plants contract with multiple carriers (truck, rail, marine, pipeline) to distribute their product slate to various markets and customers. Each plant maintains separate service contracts with multiple carriers, and each carrier serves multiple plants across the companys petrochemical portfolio. The business actively manages these relationships as Plant Carrier Contracts or Logistics Service Agreements with negotiated terms, volume commitments, rate schedules, and performance tracking specific to each plant-carrier pair.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` (
    `turnaround_contractor_engagement_id` BIGINT COMMENT 'Unique identifier for the turnaround contractor engagement record. Primary key for the association.',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to the contractor engaged for the turnaround event.',
    `turnaround_event_id` BIGINT COMMENT 'Foreign key linking to the turnaround event for which the contractor was engaged.',
    `contract_value_usd` DECIMAL(18,2) COMMENT 'Total contract value in USD for this specific contractor engagement on this turnaround event. Contributes to the turnaround events total CAPEX/OPEX.',
    `contractor_role` STRING COMMENT 'Functional role of the contractor in this specific turnaround event. Determines coordination responsibilities and work authorization level.',
    `demobilization_date` DATE COMMENT 'Date when the contractor completed their scope of work and was demobilized from this turnaround event.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of this contractor engagement for this turnaround event.',
    `labor_hours_actual` DECIMAL(18,2) COMMENT 'Total labor hours expended by this contractor on this turnaround event. Contributes to the turnaround events total labor hours.',
    `mobilization_date` DATE COMMENT 'Date when the contractor was mobilized and commenced work on this turnaround event.',
    `performance_rating` STRING COMMENT 'Post-turnaround performance assessment of this contractors work quality, safety compliance, and schedule adherence for this specific engagement.',
    `safety_incidents` STRING COMMENT 'Number of recordable safety incidents attributed to this contractor during this turnaround event.',
    `scope_of_work` STRING COMMENT 'Detailed description of the specific work scope assigned to this contractor for this turnaround event (e.g., mechanical integrity inspection, scaffolding erection, electrical maintenance, vessel cleaning).',
    `work_order_reference` STRING COMMENT 'Reference to the specific work order or purchase order governing this contractor engagement.',
    CONSTRAINT pk_turnaround_contractor_engagement PRIMARY KEY(`turnaround_contractor_engagement_id`)
) COMMENT 'This association product represents the engagement contract between a turnaround event and a contractor. It captures the specific scope of work, role, mobilization schedule, contract value, and performance assessment for each contractor deployed to each turnaround event. Each record links one turnaround event to one contractor with attributes that exist only in the context of this specific engagement.. Existence Justification: In oil and gas operations, turnaround events routinely engage multiple specialized contractors simultaneously (mechanical, electrical, scaffolding, inspection, cleaning, safety), and contractors participate in multiple turnaround events across different plants and time periods. The business actively manages each contractor engagement as a distinct operational entity with specific scope, mobilization schedule, contract value, and post-event performance assessment. This is not an analytical correlation but an operational relationship that turnaround planners and project managers create, track, and evaluate.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` (
    `catalyst_id` BIGINT COMMENT 'Primary key for catalyst',
    `parent_catalyst_id` BIGINT COMMENT 'Self-referencing FK on catalyst (parent_catalyst_id)',
    `activation_date` DATE COMMENT 'Date the catalyst was first put into service.',
    `activity_factor` DECIMAL(18,2) COMMENT 'Measured activity factor indicating catalytic efficiency under standard test conditions.',
    `batch_number` STRING COMMENT 'Manufacturing batch identifier for traceability.',
    `catalogue_number` STRING COMMENT 'External catalogue or part number used to reference the catalyst in procurement and inventory systems.',
    `catalyst_class` STRING COMMENT 'Category describing the chemical nature of the catalyst.',
    `catalyst_family` STRING COMMENT 'Higher‑level family grouping for the catalyst (e.g., zeolite, metal‑oxide).',
    `catalyst_grade` STRING COMMENT 'Specific grade or performance tier of the catalyst.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the catalyst in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the catalyst record was first created in the data lake.',
    `deactivation_date` DATE COMMENT 'Date the catalyst was removed from service.',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT 'Physical density of the catalyst material.',
    `catalyst_description` STRING COMMENT 'Free‑form description of catalyst composition, intended reactions, and key properties.',
    `disposal_method` STRING COMMENT 'Recommended disposal method in compliance with environmental regulations.',
    `expiry_date` DATE COMMENT 'Date after which the catalyst is no longer guaranteed for use.',
    `handling_instructions` STRING COMMENT 'Safety and procedural instructions for handling the catalyst.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the catalyst is classified as a hazardous material.',
    `is_proprietary` BOOLEAN COMMENT 'True if the catalyst formulation is proprietary and not publicly disclosed.',
    `is_recyclable` BOOLEAN COMMENT 'Indicates whether the catalyst can be recycled after use.',
    `last_regeneration_date` DATE COMMENT 'Date of the most recent catalyst regeneration.',
    `lifespan_hours` DECIMAL(18,2) COMMENT 'Estimated total operational lifespan of the catalyst in hours.',
    `loading_rate_kg_per_hr` DECIMAL(18,2) COMMENT 'Maximum loading rate of feedstock onto the catalyst per hour.',
    `lot_number` STRING COMMENT 'Lot identifier used for quality control and recall management.',
    `manufacturer` STRING COMMENT 'Name of the company that produced the catalyst.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum temperature (in Celsius) at which the catalyst can safely operate.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum temperature (in Celsius) required for catalyst activity.',
    `catalyst_name` STRING COMMENT 'Human‑readable name of the catalyst.',
    `next_regeneration_due` DATE COMMENT 'Planned date for the next catalyst regeneration.',
    `notes` STRING COMMENT 'Additional free‑form remarks or observations.',
    `pore_volume_cm3_per_g` DECIMAL(18,2) COMMENT 'Pore volume per gram of catalyst.',
    `pressure_rating_bar` DECIMAL(18,2) COMMENT 'Maximum pressure (in bar) the catalyst can withstand.',
    `regeneration_cycle_count` STRING COMMENT 'Number of regeneration cycles the catalyst has undergone.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status of the catalyst with EPA and ISO standards.',
    `safety_data_sheet_url` STRING COMMENT 'Link to the electronic safety data sheet for the catalyst.',
    `selectivity_percent` DECIMAL(18,2) COMMENT 'Selectivity of the catalyst expressed as a percentage.',
    `catalyst_status` STRING COMMENT 'Current operational status of the catalyst within the plant.',
    `storage_location` STRING COMMENT 'Physical location within the plant where the catalyst is stored.',
    `surface_area_m2_per_g` DECIMAL(18,2) COMMENT 'Specific surface area of the catalyst.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the catalyst record.',
    `vendor_contact_email` STRING COMMENT 'Primary email address for the catalyst vendor contact.',
    `vendor_contact_phone` STRING COMMENT 'Primary telephone number for the catalyst vendor contact.',
    `vendor_name` STRING COMMENT 'Name of the external vendor supplying the catalyst.',
    CONSTRAINT pk_catalyst PRIMARY KEY(`catalyst_id`)
) COMMENT 'Master reference table for catalyst. Referenced by catalyst_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`optimization_run` (
    `optimization_run_id` BIGINT COMMENT 'Primary key for optimization_run',
    `parent_optimization_run_id` BIGINT COMMENT 'Self-referencing FK on optimization_run (parent_optimization_run_id)',
    `constraints_violated` STRING COMMENT 'Number of model constraints that were violated in the solution.',
    `convergence_status` STRING COMMENT 'Indicates whether the optimizer converged to a solution.',
    `cpu_usage_percent` DECIMAL(18,2) COMMENT 'Average CPU utilization during the run, expressed as a percent.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the run record was first created in the system.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the optimization run completed or terminated.',
    `environment` STRING COMMENT 'System environment where the run was executed.',
    `error_message` STRING COMMENT 'Error details captured if the run failed.',
    `initiated_by` STRING COMMENT 'User or system that initiated the optimization run.',
    `input_data_snapshot_id` BIGINT COMMENT 'Identifier of the input data snapshot used for this run.',
    `iteration_count` STRING COMMENT 'Number of iterations performed during the run.',
    `memory_usage_mb` DECIMAL(18,2) COMMENT 'Average memory consumption during the run, in megabytes.',
    `model_version` STRING COMMENT 'Version identifier of the optimization model used.',
    `notes` STRING COMMENT 'Free‑form notes or comments entered by the analyst.',
    `objective_name` STRING COMMENT 'Name of the primary optimization objective (e.g., maximize_yield).',
    `objective_value` DECIMAL(18,2) COMMENT 'Numeric result of the primary optimization objective.',
    `priority` STRING COMMENT 'Business priority assigned to the run.',
    `run_code` STRING COMMENT 'Human‑readable code assigned to the optimization run for tracking.',
    `runtime_seconds` DECIMAL(18,2) COMMENT 'Total wall‑clock time the run consumed, in seconds.',
    `schedule_id` BIGINT COMMENT 'Identifier of the schedule that triggered the run, if any.',
    `solution_type` STRING COMMENT 'Algorithmic approach used to generate the solution.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the optimization run started.',
    `optimization_run_status` STRING COMMENT 'Current lifecycle state of the optimization run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the run record.',
    CONSTRAINT pk_optimization_run PRIMARY KEY(`optimization_run_id`)
) COMMENT 'Master reference table for optimization_run. Referenced by optimization_run_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`fractionation_train` (
    `fractionation_train_id` BIGINT COMMENT 'Primary key for fractionation_train',
    `parent_fractionation_train_id` BIGINT COMMENT 'Self-referencing FK on fractionation_train (parent_fractionation_train_id)',
    `asset_tag` STRING COMMENT 'External tag or barcode used to physically identify the train on the shop floor.',
    `average_efficiency_percent` DECIMAL(18,2) COMMENT 'Average conversion efficiency of the train over its operating life.',
    `capacity_mmbtu_per_day` DECIMAL(18,2) COMMENT 'Maximum thermal processing capacity of the train expressed in million British thermal units per day.',
    `catalyst_type` STRING COMMENT 'Catalyst formulation used in the train, if applicable.',
    `commissioning_date` DATE COMMENT 'Date the train entered commercial operation after testing.',
    `compliance_status` STRING COMMENT 'Overall compliance standing with EPA and ISO requirements.',
    `control_system_version` STRING COMMENT 'Version identifier of the DCS/PLC controlling the train.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the train was permanently taken out of service, if applicable.',
    `fractionation_train_description` STRING COMMENT 'Free‑form textual description of the trains purpose and key characteristics.',
    `downtime_hours_last_month` STRING COMMENT 'Total unplanned downtime recorded in the most recent month.',
    `emission_rate_tons_per_year` DECIMAL(18,2) COMMENT 'Estimated greenhouse gas emissions attributable to the train.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity or fuel energy consumed by the train over a reporting period.',
    `environmental_permit_number` STRING COMMENT 'Identifier of the EPA permit authorizing operation of the train.',
    `feedstock_type` STRING COMMENT 'Primary raw material processed by the train.',
    `installation_date` DATE COMMENT 'Date the train was physically installed at the plant.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the train is classified as a critical asset for plant continuity.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance activity.',
    `location` STRING COMMENT 'Code or short name of the plant/site where the train is installed.',
    `maintenance_status` STRING COMMENT 'Current status of the trains maintenance schedule.',
    `manufacturer` STRING COMMENT 'Company that built the fractionation train.',
    `model_number` STRING COMMENT 'Manufacturer‑assigned model designation.',
    `fractionation_train_name` STRING COMMENT 'Human‑readable name or designation of the fractionation train.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next preventive maintenance.',
    `notes` STRING COMMENT 'Additional remarks, observations, or special instructions from operators.',
    `operating_hours_total` BIGINT COMMENT 'Total hours the train has been in service since commissioning.',
    `pressure_rating_psi` DECIMAL(18,2) COMMENT 'Maximum allowable operating pressure for the train.',
    `product_yield_percent` DECIMAL(18,2) COMMENT 'Typical percentage of feedstock converted to target product.',
    `retirement_reason` STRING COMMENT 'Reason for decommissioning the train.',
    `serial_number` STRING COMMENT 'Unique serial number stamped by the manufacturer.',
    `fractionation_train_status` STRING COMMENT 'Current operational state of the train.',
    `temperature_rating_c` DECIMAL(18,2) COMMENT 'Maximum allowable operating temperature for the train.',
    `train_type` STRING COMMENT 'Category of the train based on the primary product stream it processes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the record.',
    CONSTRAINT pk_fractionation_train PRIMARY KEY(`fractionation_train_id`)
) COMMENT 'Master reference table for fractionation_train. Referenced by fractionation_train_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`allocation_run` (
    `allocation_run_id` BIGINT COMMENT 'Primary key for allocation_run',
    `parent_allocation_run_id` BIGINT COMMENT 'Self-referencing FK on allocation_run (parent_allocation_run_id)',
    `allocation_method` STRING COMMENT 'Method used to compute the allocation (manual entry, automated system, or optimizer).',
    `allocation_type` STRING COMMENT 'Category of allocation performed (e.g., feedstock, product, energy).',
    `comments` STRING COMMENT 'Additional free‑form comments or notes captured by operators.',
    `created_by_user_id` BIGINT COMMENT 'System user who initiated the allocation run.',
    `allocation_run_description` STRING COMMENT 'Narrative description of the allocation run purpose and scope.',
    `effective_date` DATE COMMENT 'Date on which the allocation run becomes effective for downstream processes.',
    `effective_until` DATE COMMENT 'Date after which the allocation run is no longer considered active (nullable for open‑ended runs).',
    `end_timestamp` TIMESTAMP COMMENT 'Exact end time of the allocation process.',
    `is_test_run` BOOLEAN COMMENT 'Flag indicating whether the run was a test/simulation.',
    `mass_unit` STRING COMMENT 'Unit of measure for the allocated mass.',
    `plant_id` STRING COMMENT 'Identifier of the plant where the allocation run was executed.',
    `product_id` STRING COMMENT 'Identifier of the primary product involved in the allocation.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the allocation run record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation run record.',
    `run_code` STRING COMMENT 'Human‑readable business identifier for the allocation run, often used in reporting and scheduling.',
    `run_duration_minutes` STRING COMMENT 'Total elapsed time of the run in minutes.',
    `run_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary business event that triggered the allocation run.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact start time of the allocation process.',
    `allocation_run_status` STRING COMMENT 'Current lifecycle status of the allocation run.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., error details or completion notes.',
    `total_allocated_mass` DECIMAL(18,2) COMMENT 'Aggregate mass allocated during the run, if applicable.',
    `total_allocated_volume` DECIMAL(18,2) COMMENT 'Aggregate volume allocated during the run.',
    `volume_unit` STRING COMMENT 'Unit of measure for the allocated volume.',
    CONSTRAINT pk_allocation_run PRIMARY KEY(`allocation_run_id`)
) COMMENT 'Master reference table for allocation_run. Referenced by allocation_run_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`calibration_run` (
    `calibration_run_id` BIGINT COMMENT 'Primary key for calibration_run',
    `parent_calibration_run_id` BIGINT COMMENT 'Self-referencing FK on calibration_run (parent_calibration_run_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the calibration run was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the supervisor or quality engineer who approved the calibration results.',
    `calibration_certificate_number` STRING COMMENT 'Reference number of the official calibration certificate issued.',
    `calibration_interval_days` STRING COMMENT 'Standard interval in days between required calibrations for the equipment.',
    `calibration_method` STRING COMMENT 'Method used to perform the calibration.',
    `calibration_result_code` STRING COMMENT 'Code summarizing the outcome of the calibration run.',
    `calibration_source_system` STRING COMMENT 'Name of the source system that recorded the calibration run (e.g., Aspen HYSYS, SAP PP).',
    `calibration_standard` STRING COMMENT 'Standard or specification governing the calibration procedure.',
    `calibration_status` STRING COMMENT 'Current lifecycle status of the calibration run.',
    `calibration_tool` STRING COMMENT 'Name or model of the tool/instrument used for calibration.',
    `calibration_type` STRING COMMENT 'Category of calibration performed (e.g., temperature, pressure).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration run record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the overall quality of the calibration data.',
    `deviation` DECIMAL(18,2) COMMENT 'Absolute difference between measured value and target value.',
    `deviation_percent` DECIMAL(18,2) COMMENT 'Percentage deviation of the measured value from the target.',
    `equipment_id` BIGINT COMMENT 'Identifier of the equipment or instrument that was calibrated.',
    `location_id` BIGINT COMMENT 'Identifier of the plant or site where the calibration took place.',
    `measured_unit` STRING COMMENT 'Unit of measure associated with the measured value.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result recorded from the calibration measurement.',
    `next_due_date` DATE COMMENT 'Scheduled date for the next calibration of the equipment.',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the operator.',
    `operator_id` BIGINT COMMENT 'Identifier of the technician or operator who executed the calibration.',
    `pass_fail_flag` STRING COMMENT 'Indicates whether the calibration met acceptance criteria.',
    `regulatory_compliance_code` STRING COMMENT 'Code linking the calibration to a specific regulatory requirement (e.g., EPA, ISO).',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the calibration run was performed.',
    `target_value` DECIMAL(18,2) COMMENT 'Expected value or setpoint for the calibration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the calibration run record.',
    CONSTRAINT pk_calibration_run PRIMARY KEY(`calibration_run_id`)
) COMMENT 'Master reference table for calibration_run. Referenced by calibration_run_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`product_line` (
    `product_line_id` BIGINT COMMENT 'Primary key for product_line',
    `parent_product_line_id` BIGINT COMMENT 'Self-referencing FK on product_line (parent_product_line_id)',
    `capacity` DECIMAL(18,2) COMMENT 'Maximum production capacity associated with the product line.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity field.',
    `product_line_category` STRING COMMENT 'Broad category grouping of the product line.',
    `classification` STRING COMMENT 'Classification indicating ownership or partnership model.',
    `product_line_code` STRING COMMENT 'Unique alphanumeric code identifying the product line.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product line record was first created in the system.',
    `currency` STRING COMMENT 'ISO 4217 currency code for the price.',
    `product_line_description` STRING COMMENT 'Detailed description of the product line, including purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the product line became effective.',
    `effective_until` DATE COMMENT 'Date when the product line is scheduled to be retired or end of validity.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the environmental impact of the product line.',
    `epa_compliance_status` STRING COMMENT 'Environmental compliance status with EPA regulations.',
    `hazard_classification` STRING COMMENT 'Classification of hazards associated with the product line.',
    `iso_quality_standard` STRING COMMENT 'Applicable ISO quality or environmental management standard.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the product lines development and deployment lifecycle.',
    `market_region` STRING COMMENT 'Primary geographic market region for the product line.',
    `product_line_name` STRING COMMENT 'Descriptive name of the product line.',
    `price` DECIMAL(18,2) COMMENT 'Standard price per unit for the product line.',
    `revision_number` STRING COMMENT 'Sequential revision number for changes to the product line.',
    `safety_rating` STRING COMMENT 'Safety rating assigned to the product line based on hazard analysis.',
    `sales_channel` STRING COMMENT 'Primary sales channel through which the product line is sold.',
    `product_line_status` STRING COMMENT 'Current lifecycle status of the product line.',
    `subcategory` STRING COMMENT 'More specific subcategory within the main category.',
    `product_line_type` STRING COMMENT 'Type of product line based on primary output.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the product line record.',
    `version` STRING COMMENT 'Version identifier for the product line definition.',
    CONSTRAINT pk_product_line PRIMARY KEY(`product_line_id`)
) COMMENT 'Master reference table for product_line. Referenced by product_line_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Primary key for storage_location',
    `parent_storage_location_id` BIGINT COMMENT 'Self-referencing FK on storage_location (parent_storage_location_id)',
    `address_line1` STRING COMMENT 'Primary street address of the storage location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the location expressed in cubic metres.',
    `city` STRING COMMENT 'City where the storage location is situated.',
    `country_code` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code of the location. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|FRA|DEU|... — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the storage location record was first created in the master system.',
    `storage_location_description` STRING COMMENT 'Free‑form text describing the locations purpose, special characteristics, or notes.',
    `effective_from` DATE COMMENT 'Date on which the location became operational or valid for reporting.',
    `effective_until` DATE COMMENT 'Date on which the location is scheduled to be retired or become invalid; null if open‑ended.',
    `environmental_permit_number` STRING COMMENT 'Identifier of the environmental permit authorizing storage at this location.',
    `external_system_id` STRING COMMENT 'Identifier of the location in an external asset management system (e.g., SAP PP, Aspen HYSYS).',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the location stores hazardous substances.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `location_code` STRING COMMENT 'Enterprise‑wide alphanumeric code used to reference the location in operational systems.',
    `location_name` STRING COMMENT 'Human‑readable name of the storage location, e.g., "North Tank Farm".',
    `location_type` STRING COMMENT 'Category of the storage location indicating its physical nature.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `max_operating_pressure_bar` DECIMAL(18,2) COMMENT 'Maximum safe operating pressure for the location, expressed in bar.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the location.',
    `owner_department` STRING COMMENT 'Internal department responsible for the locations operation and maintenance.',
    `safety_rating` STRING COMMENT 'Internal safety classification based on hazard analysis.',
    `state_province` STRING COMMENT 'State or province of the storage location.',
    `storage_location_status` STRING COMMENT 'Current operational status of the location.',
    `temperature_controlled` BOOLEAN COMMENT 'True if the location maintains a controlled temperature environment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the storage location record.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master reference table for storage_location. Referenced by storage_location_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`sample_point` (
    `sample_point_id` BIGINT COMMENT 'Primary key for sample_point',
    `parent_sample_point_id` BIGINT COMMENT 'Self-referencing FK on sample_point (parent_sample_point_id)',
    `associated_process` STRING COMMENT 'Name of the process unit (e.g., cracking, distillation) that the sample point monitors.',
    `calibration_date` DATE COMMENT 'Date when the sampling instrument at this point was last calibrated.',
    `calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration of the sampling instrument.',
    `sample_point_code` STRING COMMENT 'Business‑assigned alphanumeric code uniquely identifying the physical sampling location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample point record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Quality assessment of the most recent sample data from this point.',
    `sample_point_description` STRING COMMENT 'Free‑form description of the point’s purpose, location, and any special handling notes.',
    `elevation_meters` DOUBLE COMMENT 'Elevation of the sample point above sea level, expressed in meters.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the point is critical for safety, compliance, or product quality monitoring.',
    `last_maintenance_timestamp` TIMESTAMP COMMENT 'Timestamp of the last maintenance activity performed on the sampling equipment.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the sample point in decimal degrees (WGS‑84).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the sample point in decimal degrees (WGS‑84).',
    `measurement_unit` STRING COMMENT 'Unit of measure for the primary analyte captured at this point (e.g., ppm, %vol, mg/m³).',
    `sample_point_name` STRING COMMENT 'Human‑readable name of the sample point used in reports and dashboards.',
    `sampling_frequency_hz` DOUBLE COMMENT 'Rate at which samples are collected at this point, expressed in hertz.',
    `sampling_method` STRING COMMENT 'Technique used to obtain the sample at this point.',
    `source_system` STRING COMMENT 'Originating system that defines the sample point (e.g., Aspen HYSYS, SAP PP).',
    `sample_point_status` STRING COMMENT 'Current lifecycle status of the sample point.',
    `sample_point_type` STRING COMMENT 'Category of the sample point indicating its functional role in the plant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sample point record.',
    CONSTRAINT pk_sample_point PRIMARY KEY(`sample_point_id`)
) COMMENT 'Master reference table for sample_point. Referenced by sample_point_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`petrochemical`.`run_period` (
    `run_period_id` BIGINT COMMENT 'Primary key for run_period',
    `parent_run_period_id` BIGINT COMMENT 'Self-referencing FK on run_period (parent_run_period_id)',
    `batch_number` STRING COMMENT 'External batch identifier associated with the run period, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the run period record was first created in the system.',
    `run_period_description` STRING COMMENT 'Free‑form text providing additional context or notes about the period.',
    `effective_from` TIMESTAMP COMMENT 'Exact moment the run period becomes effective for downstream processes.',
    `effective_until` TIMESTAMP COMMENT 'Exact moment the run period ceases to be effective.',
    `end_date` DATE COMMENT 'Calendar date on which the run period ends.',
    `is_current` BOOLEAN COMMENT 'Indicates whether this period is the active period for its plant/unit (true) or historical (false).',
    `is_holiday` BOOLEAN COMMENT 'True if the run period falls on a scheduled plant holiday or shutdown.',
    `period_code` STRING COMMENT 'Compact alphanumeric code used in scheduling systems to reference the period.',
    `period_name` STRING COMMENT 'Human‑readable name describing the run period (e.g., "Shift A – 2024‑03‑01").',
    `period_type` STRING COMMENT 'Category of the run period indicating its operational purpose.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant where the run period occurs.',
    `run_category` STRING COMMENT 'Higher‑level classification of the run period for reporting (e.g., production vs. maintenance).',
    `schedule_version` STRING COMMENT 'Version tag of the production schedule that generated this run period.',
    `shift_number` STRING COMMENT 'Numeric identifier of the shift within a day (e.g., 1, 2, 3).',
    `start_date` DATE COMMENT 'Calendar date on which the run period begins.',
    `run_period_status` STRING COMMENT 'Current lifecycle state of the run period.',
    `unit_id` BIGINT COMMENT 'Identifier of the specific processing unit or train associated with the run period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the run period record.',
    CONSTRAINT pk_run_period PRIMARY KEY(`run_period_id`)
) COMMENT 'Master reference table for run_period. Referenced by run_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_feedstock_id` FOREIGN KEY (`feedstock_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`feedstock`(`feedstock_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_feedstock_id` FOREIGN KEY (`feedstock_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`feedstock`(`feedstock_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_feedstock_receipt_id` FOREIGN KEY (`feedstock_receipt_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`feedstock_receipt`(`feedstock_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_optimization_run_id` FOREIGN KEY (`optimization_run_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`optimization_run`(`optimization_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`production_order`(`production_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_feedstock_id` FOREIGN KEY (`feedstock_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`feedstock`(`feedstock_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`production_order`(`production_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_feedstock_id` FOREIGN KEY (`feedstock_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`feedstock`(`feedstock_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`production_order`(`production_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_run_period_id` FOREIGN KEY (`run_period_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`run_period`(`run_period_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_unit_run_record_id` FOREIGN KEY (`unit_run_record_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`unit_run_record`(`unit_run_record_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ADD CONSTRAINT `fk_petrochemical_product_catalog_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ADD CONSTRAINT `fk_petrochemical_product_catalog_product_line_id` FOREIGN KEY (`product_line_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_line`(`product_line_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_original_assay_quality_assay_id` FOREIGN KEY (`original_assay_quality_assay_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`quality_assay`(`quality_assay_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`production_order`(`production_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_sample_point_id` FOREIGN KEY (`sample_point_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`sample_point`(`sample_point_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_catalyst_record_id` FOREIGN KEY (`catalyst_record_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`catalyst_record`(`catalyst_record_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_calibration_run_id` FOREIGN KEY (`calibration_run_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`calibration_run`(`calibration_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_fractionation_train_id` FOREIGN KEY (`fractionation_train_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`fractionation_train`(`fractionation_train_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_process_simulation_id` FOREIGN KEY (`process_simulation_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`process_simulation`(`process_simulation_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`production_order`(`production_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`storage_location`(`storage_location_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_offtake_nomination_id` FOREIGN KEY (`offtake_nomination_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`offtake_nomination`(`offtake_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_allocation_run_id` FOREIGN KEY (`allocation_run_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_original_nomination_offtake_nomination_id` FOREIGN KEY (`original_nomination_offtake_nomination_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`offtake_nomination`(`offtake_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`production_order`(`production_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_catalyst_id` FOREIGN KEY (`catalyst_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`catalyst`(`catalyst_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_previous_catalyst_record_id` FOREIGN KEY (`previous_catalyst_record_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`catalyst_record`(`catalyst_record_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ADD CONSTRAINT `fk_petrochemical_turnaround_work_order_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ADD CONSTRAINT `fk_petrochemical_plant_ownership_interest_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ADD CONSTRAINT `fk_petrochemical_product_entitlement_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ADD CONSTRAINT `fk_petrochemical_petrochemical_product_approval_product_approval_id` FOREIGN KEY (`product_approval_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval`(`petrochemical_product_approval_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ADD CONSTRAINT `fk_petrochemical_petrochemical_product_approval_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ADD CONSTRAINT `fk_petrochemical_unit_integrity_enrollment_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ADD CONSTRAINT `fk_petrochemical_plant_carrier_contract_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ADD CONSTRAINT `fk_petrochemical_turnaround_contractor_engagement_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ADD CONSTRAINT `fk_petrochemical_catalyst_parent_catalyst_id` FOREIGN KEY (`parent_catalyst_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`catalyst`(`catalyst_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`optimization_run` ADD CONSTRAINT `fk_petrochemical_optimization_run_parent_optimization_run_id` FOREIGN KEY (`parent_optimization_run_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`optimization_run`(`optimization_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`fractionation_train` ADD CONSTRAINT `fk_petrochemical_fractionation_train_parent_fractionation_train_id` FOREIGN KEY (`parent_fractionation_train_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`fractionation_train`(`fractionation_train_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`allocation_run` ADD CONSTRAINT `fk_petrochemical_allocation_run_parent_allocation_run_id` FOREIGN KEY (`parent_allocation_run_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`allocation_run`(`allocation_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`calibration_run` ADD CONSTRAINT `fk_petrochemical_calibration_run_parent_calibration_run_id` FOREIGN KEY (`parent_calibration_run_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`calibration_run`(`calibration_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_line` ADD CONSTRAINT `fk_petrochemical_product_line_parent_product_line_id` FOREIGN KEY (`parent_product_line_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_line`(`product_line_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ADD CONSTRAINT `fk_petrochemical_storage_location_parent_storage_location_id` FOREIGN KEY (`parent_storage_location_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`storage_location`(`storage_location_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`sample_point` ADD CONSTRAINT `fk_petrochemical_sample_point_parent_sample_point_id` FOREIGN KEY (`parent_sample_point_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`sample_point`(`sample_point_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`run_period` ADD CONSTRAINT `fk_petrochemical_run_period_parent_run_period_id` FOREIGN KEY (`parent_run_period_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`run_period`(`run_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`petrochemical` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `oil_gas_ecm`.`petrochemical` SET TAGS ('dbx_domain' = 'petrochemical');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'MTPA|KTPA|BPSD|MMSCFD|KTPD|TPH');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Plant Email Address');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `epa_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `ghgrp_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas Reporting Program (GHGRP) Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `last_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Last Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Manager Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `maximo_location_code` SET TAGS ('dbx_business_glossary_term' = 'Maximo Location Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `nameplate_capacity` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `next_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Next Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `operating_company` SET TAGS ('dbx_business_glossary_term' = 'Operating Company');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Operating|Idle|Turnaround|Startup|Shutdown|Mothballed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Plant Phone Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `primary_feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `primary_product` SET TAGS ('dbx_business_glossary_term' = 'Primary Product');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `scada_system_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `secondary_products` SET TAGS ('dbx_business_glossary_term' = 'Secondary Products');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `site_address` SET TAGS ('dbx_business_glossary_term' = 'Site Address');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ALTER COLUMN `technology_licensor` SET TAGS ('dbx_business_glossary_term' = 'Technology Licensor');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `consent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `aspen_hysys_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Model Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `catalyst_expected_life_months` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Expected Life in Months');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `catalyst_load_date` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Load Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `catalyst_type` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `current_operating_capacity` SET TAGS ('dbx_business_glossary_term' = 'Current Operating Capacity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `dcs_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `design_capacity` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `design_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `design_life_years` SET TAGS ('dbx_business_glossary_term' = 'Design Life in Years');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `energy_consumption_mmbtu_per_day` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption in Million British Thermal Units (MMBTU) Per Day');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `epc_contractor` SET TAGS ('dbx_business_glossary_term' = 'Engineering Procurement and Construction (EPC) Contractor');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `feedstock_specification` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Specification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `flare_system_connected_flag` SET TAGS ('dbx_business_glossary_term' = 'Flare System Connected Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `ghg_emissions_co2e_tpy` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions in Carbon Dioxide Equivalent (CO2e) Tonnes Per Year (TPY)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `h2s_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Handling Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `last_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Last Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `next_scheduled_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Turnaround Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `operating_pressure_max_bar` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Pressure in Bar');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `operating_pressure_min_bar` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Pressure in Bar');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `operating_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `operating_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `original_equipment_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Expiry Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `primary_feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `primary_product_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `process_technology` SET TAGS ('dbx_business_glossary_term' = 'Process Technology');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `psr_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Review (PSR) Completion Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `replacement_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `replacement_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `turnaround_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Interval in Months');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `unit_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Tag Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `unit_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` SET TAGS ('dbx_subdomain' = 'feedstock_management');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `feedstock_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `approved_supplier_reference` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `aromatic_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Aromatic Content Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `autoignition_temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `butane_fraction_percent` SET TAGS ('dbx_business_glossary_term' = 'Butane (C4) Fraction Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `c5_plus_fraction_percent` SET TAGS ('dbx_business_glossary_term' = 'C5+ (Pentanes Plus) Fraction Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `calorific_value_btu_per_scf` SET TAGS ('dbx_business_glossary_term' = 'Calorific Value in British Thermal Units (BTU) per Standard Cubic Foot (SCF)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `carbon_residue_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Residue Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `cetane_index` SET TAGS ('dbx_business_glossary_term' = 'Cetane Index');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (Kilograms per Cubic Meter)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `ethane_fraction_percent` SET TAGS ('dbx_business_glossary_term' = 'Ethane (C2) Fraction Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `feedstock_code` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Material Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `feedstock_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `feedstock_name` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Material Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `flash_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'Flammable|Toxic|Corrosive|Explosive|Non-Hazardous|Compressed Gas');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Approved|Under Review|Discontinued|Restricted');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `mercaptan_sulfur_ppm` SET TAGS ('dbx_business_glossary_term' = 'Mercaptan Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `metals_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Total Metals Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `methane_fraction_percent` SET TAGS ('dbx_business_glossary_term' = 'Methane (C1) Fraction Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `nitrogen_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `octane_number_ron` SET TAGS ('dbx_business_glossary_term' = 'Research Octane Number (RON)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `olefin_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Olefin Content Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `paraffin_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Paraffin Content Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `pour_point_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Pour Point (Fahrenheit)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `propane_fraction_percent` SET TAGS ('dbx_business_glossary_term' = 'Propane (C3) Fraction Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Quality Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'Premium|Standard|Off-Spec|Blended|Contract Grade|Spot Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `reid_vapor_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Reid Vapor Pressure (RVP) in Pounds per Square Inch (PSI)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Source Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'Field Production|Refinery Output|Import|Third-Party Supplier|Joint Venture|Internal Transfer');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `specific_gravity` SET TAGS ('dbx_business_glossary_term' = 'Specific Gravity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `tan_mg_koh_per_g` SET TAGS ('dbx_business_glossary_term' = 'Total Acid Number (TAN) in Milligrams Potassium Hydroxide per Gram');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `vapor_pressure_psia` SET TAGS ('dbx_business_glossary_term' = 'Vapor Pressure (Pounds per Square Inch Absolute)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `viscosity_centistokes` SET TAGS ('dbx_business_glossary_term' = 'Kinematic Viscosity (Centistokes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ALTER COLUMN `water_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Water Content (Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` SET TAGS ('dbx_subdomain' = 'feedstock_management');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `feedstock_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Receipt ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `feedstock_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'Accepted|Rejected|Conditional|Under Review');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'API (American Petroleum Institute) Gravity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `composition_analysis` SET TAGS ('dbx_business_glossary_term' = 'Composition Analysis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Density (kg/m³ - Kilograms per Cubic Meter)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `destination_storage_tank` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Tank');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `gross_volume_barrels` SET TAGS ('dbx_business_glossary_term' = 'Gross Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `h2s_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'H2S (Hydrogen Sulfide) Content (PPM - Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `net_volume_barrels` SET TAGS ('dbx_business_glossary_term' = 'Net Volume (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure (PSI - Pounds per Square Inch)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `sediment_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sediment Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'Pipeline|Vessel|Truck|Rail|Storage Transfer');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (PPM - Parts Per Million)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `tan_value` SET TAGS ('dbx_business_glossary_term' = 'TAN (Total Acid Number) Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `unit_cost_per_boe` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost per BOE (Barrel of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `unit_cost_per_boe` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `volume_received_boe` SET TAGS ('dbx_business_glossary_term' = 'Volume Received (BOE - Barrel of Oil Equivalent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `volume_received_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Volume Received (MMCFD - Million Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ALTER COLUMN `water_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Water Content (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` SET TAGS ('dbx_subdomain' = 'feedstock_management');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Allocation ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `crude_assay_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Assay Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `crude_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Crude Grade Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `drilling_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Material ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Receipt Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Optimization Run ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `pipeline_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Batch Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `production_well_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Well Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Acceptance Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|conditionally_accepted|rejected|pending_qc');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `actual_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Feedstock Volume Consumed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Allocation Basis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'optimization_model|manual|contractual|proportional|operator_override');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Allocation Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Allocation Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Allocation Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|planned|approved|active|completed|cancelled');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approval Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (User ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `assay_gravity_api` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Assay Gravity (API Degrees)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `assay_h2s_ppm` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Assay Hydrogen Sulfide (H2S) Concentration (PPM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `assay_heating_value` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Assay Gross Heating Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `assay_sulfur_pct` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Assay Sulfur Content Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_value_regex' = 'NGL|LPG|naphtha|ethane|propane|condensate');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Unit Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `feedstock_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `ghg_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission Factor');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `operating_period_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Period End Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `operating_period_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Period Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `period_close_flag` SET TAGS ('dbx_business_glossary_term' = 'Operating Period Close Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `planned_volume` SET TAGS ('dbx_business_glossary_term' = 'Planned Feedstock Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Receipt Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `received_volume` SET TAGS ('dbx_business_glossary_term' = 'Received Feedstock Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Allocation Remarks');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Source Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Source Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'pipeline|vessel|storage_tank|rail|truck');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `total_feedstock_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Feedstock Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `total_feedstock_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Volume Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ALTER COLUMN `volume_variance` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Volume Variance');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `unit_run_record_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Record ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `feedstock_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `avg_operating_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Average Operating Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `avg_operating_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Average Operating Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `btx_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'BTX (Benzene, Toluene, Xylene) Yield (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `catalyst_activity_pct` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Activity Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `catalyst_addition_kg` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Addition (Kilograms)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `conversion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `cooling_water_consumption_m3` SET TAGS ('dbx_business_glossary_term' = 'Cooling Water Consumption (Cubic Metres)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `downtime_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `energy_intensity_boe` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity (Barrel of Oil Equivalent per Barrel Feed)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `ethylene_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Ethylene Yield (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `feed_rate_bopd` SET TAGS ('dbx_business_glossary_term' = 'Feed Rate (Barrels of Oil Per Day)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `feed_rate_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Feed Rate (Million Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `feedstock_quality_api` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Quality API Gravity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `flare_volume_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Flare Volume (Million Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `fuel_gas_consumption_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Consumption (Million Cubic Feet per Day)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `ghg_emissions_co2e_mt` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions CO2 Equivalent (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `hysys_simulation_case` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Simulation Case Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `lpg_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Petroleum Gas (LPG) Yield (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `mass_balance_closure_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `ngl_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Yield (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `npt_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `on_stream_hours` SET TAGS ('dbx_business_glossary_term' = 'On-Stream Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `pi_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI System Tag Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `power_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (Megawatt Hours)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `propylene_yield_bbl` SET TAGS ('dbx_business_glossary_term' = 'Propylene Yield (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `record_period_type` SET TAGS ('dbx_business_glossary_term' = 'Record Period Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `record_period_type` SET TAGS ('dbx_value_regex' = 'daily|shift|hourly|weekly');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Run Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_record_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Record Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_record_number` SET TAGS ('dbx_value_regex' = '^URR-[A-Z0-9]{3,10}-[0-9]{8}-[0-9]{3,6}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Record Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D|DAY|NIGHT');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `steam_consumption_mt` SET TAGS ('dbx_business_glossary_term' = 'Steam Consumption (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `unaccounted_loss_bbl` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted Loss (Barrels)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `petrochemical_yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Engineer ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `feedstock_id` SET TAGS ('dbx_business_glossary_term' = 'Feedstock ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `run_period_id` SET TAGS ('dbx_business_glossary_term' = 'Run Period ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Simulation Run ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `unit_run_record_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Run Record Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `actual_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `benzene_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Benzene Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `butadiene_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Butadiene Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `catalyst_age_days` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Age (Days)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `catalyst_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `energy_consumption_gj` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (Gigajoules)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `ethylene_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Ethylene Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `feedstock_volume_mt` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Volume (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `fuel_oil_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Fuel Oil Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `ghg_emissions_co2e_mt` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions CO2 Equivalent (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `gor_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Gas-Oil Ratio (GOR) Equivalent');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `lab_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `lpg_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Petroleum Gas (LPG) Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `mass_balance_closure_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `naphtha_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Naphtha Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `npt_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `on_stream_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Stream Factor Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `operating_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Operating Temperature (Degrees Celsius)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `opex_allocated_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Allocated (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `opex_allocated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `planned_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `propylene_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Propylene Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'prime|off_spec|downgraded|rejected');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `record_number` SET TAGS ('dbx_value_regex' = '^YR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|validated|approved|rejected|closed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Remarks');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `run_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (Hours)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `specialty_chemical_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Specialty Chemical Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `toluene_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Toluene Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `xylene_yield_mt` SET TAGS ('dbx_business_glossary_term' = 'Xylene Yield (Metric Tonnes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ALTER COLUMN `yield_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `api_gravity` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Gravity (°API)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `astm_standard` SET TAGS ('dbx_business_glossary_term' = 'ASTM International Test Standard');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `boiling_point_c` SET TAGS ('dbx_business_glossary_term' = 'Boiling Point (°C)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d{1}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `chemical_formula` SET TAGS ('dbx_business_glossary_term' = 'Chemical Molecular Formula');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code (ISO 4217)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `density_kg_per_m3` SET TAGS ('dbx_business_glossary_term' = 'Product Density (kg/m³)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Product Discontinuation Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Product Catalog Effective Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `feedstock_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Feedstock Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `flash_point_c` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (°C)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `ghg_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emission Factor (tCO2e/unit)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^d{6,10}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `is_controlled_substance` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Indicator');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `iso_quality_standard` SET TAGS ('dbx_business_glossary_term' = 'ISO Quality Standard');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `iupac_name` SET TAGS ('dbx_business_glossary_term' = 'International Union of Pure and Applied Chemistry (IUPAC) Chemical Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight (g/mol)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `norm_classification` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `norm_classification` SET TAGS ('dbx_value_regex' = 'NORM_present|NORM_absent|not_assessed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Category');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_status` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Lifecycle Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|under_review|development|blocked');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Product Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'finished_product|intermediate|feedstock|by_product|co_product');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `production_process` SET TAGS ('dbx_business_glossary_term' = 'Production Process Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `purity_min_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purity Specification (%)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'EU REACH Registration Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^d{2}-d{10}-d{2}-d{4}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'TSCA_listed|REACH_registered|controlled_substance|VOC|HAP|non_regulated');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `sds_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `specification_sheet_ref` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Sheet Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost per Unit');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (°C)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (°C)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `sulfur_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (parts per million, ppm)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `tsca_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'EPA Toxic Substances Control Act (TSCA) Inventory Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `tsca_inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|exempt|not_listed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Dangerous Goods Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UNd{4}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `uom_alternate` SET TAGS ('dbx_business_glossary_term' = 'Alternate Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `uom_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ALTER COLUMN `voc_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Volatile Organic Compound (VOC) Content (%)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `quality_assay_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assay ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `custody_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `lab_instrument_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Instrument ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `lab_instrument_equipment_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `original_assay_quality_assay_id` SET TAGS ('dbx_business_glossary_term' = 'Original Quality Assay ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Analyst ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'SAP Production Order ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Specification ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `product_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Refinery Product Quality Test Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Point ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `storage_tank_equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `storage_tank_equipment_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'QC Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `assay_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Assay Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `assay_number` SET TAGS ('dbx_value_regex' = '^QA-[A-Z0-9]{4,10}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `assay_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assay Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `assay_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|approved|rejected|voided');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Due Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{4,15}-[0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Specification Deviation Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `lab_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Ambient Temperature (°C)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'feedstock|intermediate|finished_product|utility|waste_stream');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Property Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Conformance Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|retest_required|inconclusive');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `property_name` SET TAGS ('dbx_business_glossary_term' = 'Measured Property Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Assay Remarks');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `replicate_count` SET TAGS ('dbx_business_glossary_term' = 'Replicate Test Count');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Physical Condition');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_condition` SET TAGS ('dbx_value_regex' = 'normal|degraded|contaminated|phase_separated|off_spec_appearance');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_point_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (mL)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `spec_max_value` SET TAGS ('dbx_business_glossary_term' = 'Specification Maximum Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `spec_min_value` SET TAGS ('dbx_business_glossary_term' = 'Specification Minimum Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `spec_target_value` SET TAGS ('dbx_business_glossary_term' = 'Specification Target Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `test_method_code` SET TAGS ('dbx_business_glossary_term' = 'Test Method Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `test_method_code` SET TAGS ('dbx_value_regex' = '^(ASTM|ISO|IP|UOP|GPA|EN)[A-Z0-9 /-]{1,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Object ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `catalyst_record_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Charge ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Production Planner ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Target Product ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `actual_feedstock_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Feedstock Quantity Consumed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `actual_output_qty` SET TAGS ('dbx_business_glossary_term' = 'Actual Output Quantity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Production Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[A-Z0-9]{4,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `bill_of_materials_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `energy_consumption_gj` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (GJ)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `feedstock_material_code` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Material Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `feedstock_qty_uom` SET TAGS ('dbx_business_glossary_term' = 'Feedstock Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `ghg_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions (MT CO2e)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `is_capex_linked` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Linked Indicator');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'created|released|confirmed|technically_closed|closed|cancelled');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'PP01|PP02|PP03|PP04');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `output_qty_uom` SET TAGS ('dbx_business_glossary_term' = 'Output Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `output_qty_uom` SET TAGS ('dbx_value_regex' = 'MT|BBL|KG|TON|M3|MSCF');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `planned_feedstock_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Feedstock Quantity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `planned_output_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Output Quantity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `planned_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Planned Total Production Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `planned_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Production Order Priority');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `process_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Process Operating Pressure (kPa)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `process_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Process Operating Temperature (°C)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `ptw_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Settlement Rule');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'MAT|CTR|ORD|PRJ|FXA');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ALTER COLUMN `yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Product Yield Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `plant_opex_record_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Operating Expenditure (OPEX) Record Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `intercompany_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `primary_plant_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `primary_plant_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `primary_plant_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `tertiary_plant_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `tertiary_plant_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `tertiary_plant_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Document Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `actual_opex_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Operating Expenditure (OPEX) Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `benchmark_loe_usd_per_mt` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Lease Operating Expense (LOE) in United States Dollars (USD) Per Metric Ton (MT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `catalyst_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `chemical_consumables_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Chemical Consumables Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `contract_services_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Contract Services Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Cost Category');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `cost_object_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Cost Object Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `cost_object_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `energy_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Energy Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `environmental_compliance_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `loe_per_unit_usd_per_mt` SET TAGS ('dbx_business_glossary_term' = 'Lease Operating Expense (LOE) Per Unit in United States Dollars (USD) Per Metric Ton (MT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `maintenance_labor_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Labor Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `planned_opex_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Operating Expenditure (OPEX) Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `production_volume_mt` SET TAGS ('dbx_business_glossary_term' = 'Production Volume in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|posted|rejected|cancelled');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `variance_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `waste_disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `compliance_corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Coordinator ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `tertiary_turnaround_updated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By Employee ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `tertiary_turnaround_updated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `tertiary_turnaround_updated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `actual_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `actual_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `actual_opex_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Operating Expenditure (OPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `actual_opex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Certification Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `cost_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `cost_variance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `environmental_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Count');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `estimated_capex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `estimated_opex_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Operating Expenditure (OPEX) in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `estimated_opex_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `lessons_learned_summary` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `maximo_work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Work Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `npt_hours` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `performance_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Turnaround Performance Certification Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `performance_certification_status` SET TAGS ('dbx_value_regex' = 'pending|certified|failed|waived');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `production_deferral_boe` SET TAGS ('dbx_business_glossary_term' = 'Production Deferral in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `ptw_status` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `ptw_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|active|closed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `sap_maintenance_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Maintenance Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance in Days');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `scope_of_work_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `total_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `turnaround_number` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `turnaround_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `turnaround_type` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ALTER COLUMN `turnaround_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|regulatory|opportunistic');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Process Simulation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `calibration_run_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `tertiary_process_model_owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `calibration_basis` SET TAGS ('dbx_business_glossary_term' = 'Calibration Basis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `component_library_version` SET TAGS ('dbx_business_glossary_term' = 'Component Library Version');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `design_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (Kilopascals)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `design_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature (Celsius)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `design_throughput_mt_per_day` SET TAGS ('dbx_business_glossary_term' = 'Design Throughput (Metric Tons per Day)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `epa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `feed_composition_basis` SET TAGS ('dbx_business_glossary_term' = 'Feed Composition Basis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `ghg_emissions_modeled_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Modeled (Metric Tons Carbon Dioxide Equivalent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `hysys_version` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Version');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `iso_quality_standard_compliance` SET TAGS ('dbx_business_glossary_term' = 'ISO Quality Standard Compliance');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Model Accuracy (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Model Approval Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_file_path` SET TAGS ('dbx_business_glossary_term' = 'Model File Path');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Model File Size (Megabytes)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_purpose` SET TAGS ('dbx_business_glossary_term' = 'Model Purpose');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_benzene_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Modeled Benzene Yield (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_butadiene_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Modeled Butadiene Yield (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_catalyst_consumption_kg_per_mt` SET TAGS ('dbx_business_glossary_term' = 'Modeled Catalyst Consumption (Kilograms per Metric Ton)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_energy_consumption_gj_per_mt` SET TAGS ('dbx_business_glossary_term' = 'Modeled Energy Consumption (Gigajoules per Metric Ton)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_ethylene_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Modeled Ethylene Yield (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_propylene_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Modeled Propylene Yield (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `modeled_total_yield_pct` SET TAGS ('dbx_business_glossary_term' = 'Modeled Total Yield (Percent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `sap_production_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Production Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `simulation_model_name` SET TAGS ('dbx_business_glossary_term' = 'Simulation Model Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `simulation_status` SET TAGS ('dbx_business_glossary_term' = 'Simulation Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `simulation_status` SET TAGS ('dbx_value_regex' = 'active|calibrated|under_review|deprecated|archived');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `simulation_type` SET TAGS ('dbx_business_glossary_term' = 'Simulation Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `simulation_type` SET TAGS ('dbx_value_regex' = 'steady-state|dynamic|batch|continuous');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ALTER COLUMN `thermodynamic_package` SET TAGS ('dbx_business_glossary_term' = 'Thermodynamic Package');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `ngl_fractionation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Fractionation Run Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Operator Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `fractionation_train_id` SET TAGS ('dbx_business_glossary_term' = 'Fractionation Train Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `ngl_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Ngl Stream Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Plant Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Simulation Run Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Source Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Source Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `avg_operating_pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Average Operating Pressure in Kilopascals (kPa)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `avg_operating_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Average Operating Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `butane_product_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Butane Product Volume in Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `butane_recovery_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Butane Recovery Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `energy_consumption_gj` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption in Gigajoules (GJ)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `ethane_product_purity_pct` SET TAGS ('dbx_business_glossary_term' = 'Ethane Product Purity Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `ethane_product_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Ethane Product Volume in Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `ethane_recovery_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Ethane Recovery Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `flare_volume_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Flare Volume in Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `fuel_gas_consumption_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Consumption in Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `ghg_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions in Metric Tons Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `inlet_butane_composition_pct` SET TAGS ('dbx_business_glossary_term' = 'Inlet Butane Composition Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `inlet_ethane_composition_pct` SET TAGS ('dbx_business_glossary_term' = 'Inlet Ethane Composition Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `inlet_ngl_throughput_mmcfd` SET TAGS ('dbx_business_glossary_term' = 'Inlet Natural Gas Liquids (NGL) Throughput in Million Cubic Feet per Day (MMCFD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `inlet_ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Inlet Natural Gas Liquids (NGL) Volume in Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `inlet_pentane_plus_composition_pct` SET TAGS ('dbx_business_glossary_term' = 'Inlet Pentane Plus (C5+) Composition Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `inlet_propane_composition_pct` SET TAGS ('dbx_business_glossary_term' = 'Inlet Propane Composition Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `lpg_product_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Petroleum Gas (LPG) Product Volume in Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `mass_balance_closure_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `natural_gasoline_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Natural Gasoline Volume in Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `overall_recovery_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Overall Recovery Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `pi_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI System Tag Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `power_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electrical Power Consumption in Megawatt Hours (MWh)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `propane_product_purity_pct` SET TAGS ('dbx_business_glossary_term' = 'Propane Product Purity Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `propane_product_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Propane Product Volume in Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `propane_recovery_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Propane Recovery Efficiency Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `run_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Duration in Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Fractionation Run Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|aborted|suspended|failed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Shift Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `steam_consumption_mt` SET TAGS ('dbx_business_glossary_term' = 'Steam Consumption in Metric Tons (MT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `product_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Product Inventory Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `storage_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Inventory Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Tank Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `available_volume` SET TAGS ('dbx_business_glossary_term' = 'Available Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `blocked_volume` SET TAGS ('dbx_business_glossary_term' = 'Blocked Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `current_volume` SET TAGS ('dbx_business_glossary_term' = 'Current Inventory Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `custody_status` SET TAGS ('dbx_business_glossary_term' = 'Custody Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `custody_status` SET TAGS ('dbx_value_regex' = 'owned|consignment|joint_venture|third_party|tolling');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `density_api` SET TAGS ('dbx_business_glossary_term' = 'Density in American Petroleum Institute (API) Gravity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `inventory_number` SET TAGS ('dbx_business_glossary_term' = 'Inventory Record Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `last_quality_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Test Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `lifting_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Lifting Eligibility Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `maximum_operating_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Level');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'manual_gauge|automatic_tank_gauge|flow_meter|scada|pi_system|physical_count');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Measurement Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `minimum_operating_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Level');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `pi_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Plant Information (PI) Tag Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `pressure_kpa` SET TAGS ('dbx_business_glossary_term' = 'Storage Pressure in Kilopascals (kPa)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `product_age_days` SET TAGS ('dbx_business_glossary_term' = 'Product Age in Days');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `reserved_volume` SET TAGS ('dbx_business_glossary_term' = 'Reserved Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `sap_material_document` SET TAGS ('dbx_business_glossary_term' = 'SAP Material Document Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature in Celsius');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `product_lifting_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lifting Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `commercial_term_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Term Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `offtake_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `actual_lifting_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifting Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `actual_volume_lifted` SET TAGS ('dbx_business_glossary_term' = 'Actual Volume Lifted');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `boe_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `custody_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Custody Transfer Point');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `invoice_trigger_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Trigger Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `invoice_trigger_status` SET TAGS ('dbx_value_regex' = 'pending|triggered|invoiced|paid');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `lifting_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lifting End Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `lifting_number` SET TAGS ('dbx_business_glossary_term' = 'Lifting Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `lifting_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lifting Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `lifting_status` SET TAGS ('dbx_business_glossary_term' = 'Lifting Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `scheduled_lifting_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Lifting Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `scheduled_volume` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'BBL|MT|KG|M3|GAL|LB');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `volume_variance` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ALTER COLUMN `volume_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Volume Variance Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `offtake_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `allocation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `commercial_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmed By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `ferc_tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Ferc Tariff Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Nominating Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `original_nomination_offtake_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Original Nomination Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `pipeline_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Contact Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `buyer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Buyer Reference Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `confirmed_volume` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `nominated_volume` SET TAGS ('dbx_business_glossary_term' = 'Nominated Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `nomination_number` SET TAGS ('dbx_business_glossary_term' = 'Nomination Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_business_glossary_term' = 'Nomination Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `nomination_status` SET TAGS ('dbx_value_regex' = 'submitted|confirmed|revised|rejected|cancelled|expired');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `nomination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Nomination Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `priority_basis` SET TAGS ('dbx_business_glossary_term' = 'Priority Basis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `priority_basis` SET TAGS ('dbx_value_regex' = 'first_come_first_served|contract_entitlement|strategic_customer|force_majeure|operational_constraint');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Priority');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'edi|email|portal|phone|fax');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `variance_volume` SET TAGS ('dbx_business_glossary_term' = 'Variance Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_disposal_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Contractor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Manifest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Certification Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Certification Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|waiver_approved');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_facility_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Disposal Facility Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_facility_epa_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Manifest Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_manifest_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|recycling|treatment|deep_well_injection|solidification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_status` SET TAGS ('dbx_business_glossary_term' = 'Disposal Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_transit|received|disposed|certified|rejected');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `disposal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposal Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Waste Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `epa_waste_code` SET TAGS ('dbx_value_regex' = '^[DFKPU][0-9]{3}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `generator_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Generator Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `generator_epa_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `ghg_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions in Metric Tons (MT) Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `norm_activity_level_bq` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Activity Level in Becquerels (Bq)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `ptw_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `ptw_number` SET TAGS ('dbx_value_regex' = '^PTW[0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|mt|bbl|gal|m3|lbs');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Disposal Remarks');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `transporter_epa_code` SET TAGS ('dbx_business_glossary_term' = 'Transporter Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `transporter_epa_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Hazard Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|universal|mixed|rcra_listed|rcra_characteristic');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_description` SET TAGS ('dbx_business_glossary_term' = 'Waste Material Description');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity Disposed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `waste_type` SET TAGS ('dbx_value_regex' = 'spent_catalyst|norm|chemical_waste|wastewater|sludge|contaminated_soil');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plant_capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Capacity Plan Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `jv_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Simulation Run Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `actual_opex_total_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Operating Expenditure (OPEX) Total United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `actual_opex_total_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `actual_throughput_volume` SET TAGS ('dbx_business_glossary_term' = 'Actual Throughput Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `capacity_constraint_description` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Description');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `nameplate_capacity` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `opex_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Variance Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `opex_variance_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `opex_variance_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Variance United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `opex_variance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `period_close_flag` SET TAGS ('dbx_business_glossary_term' = 'Period Close Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|revised|superseded|closed');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|tactical|strategic');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_catalyst_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Catalyst Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_catalyst_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_chemicals_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Chemicals Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_chemicals_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_contract_services_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Contract Services Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_contract_services_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_energy_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Energy Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_energy_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_environmental_compliance_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Environmental Compliance Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_environmental_compliance_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_maintenance_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Maintenance Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_maintenance_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_opex_total_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Operating Expenditure (OPEX) Total United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_opex_total_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_product_slate` SET TAGS ('dbx_business_glossary_term' = 'Planned Product Slate');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_throughput_volume` SET TAGS ('dbx_business_glossary_term' = 'Planned Throughput Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_utilization_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Planned Utilization Rate Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_waste_disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Planned Waste Disposal Cost United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planned_waste_disposal_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planning_period_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `planning_period_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `sap_production_plan_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Production Plan Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `scheduled_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Downtime Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `throughput_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Throughput Variance Percentage (PCT)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `turnaround_flag` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `mass_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Plant Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Process Engineer Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `simulation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Aspen HYSYS Simulation Run Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Balance Period End Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_period_start` SET TAGS ('dbx_business_glossary_term' = 'Balance Period Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Record Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_record_number` SET TAGS ('dbx_value_regex' = '^MB-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed|under_review');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `balance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Calculation Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `benzene_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Benzene Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `butadiene_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Butadiene Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `butane_input_mt` SET TAGS ('dbx_business_glossary_term' = 'Butane Feedstock Input (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `closure_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Closure Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `cooling_water_consumption_m3` SET TAGS ('dbx_business_glossary_term' = 'Cooling Water Consumption (Cubic Meters)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `ethane_input_mt` SET TAGS ('dbx_business_glossary_term' = 'Ethane Feedstock Input (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `ethylene_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Ethylene Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `flare_volume_mt` SET TAGS ('dbx_business_glossary_term' = 'Flare Volume (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `fuel_gas_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Fuel Gas Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `fuel_oil_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Fuel Oil Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `gas_oil_input_mt` SET TAGS ('dbx_business_glossary_term' = 'Gas Oil Feedstock Input (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `ghg_emissions_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions (Metric Tons Carbon Dioxide Equivalent)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `lpg_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Liquefied Petroleum Gas (LPG) Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `naphtha_input_mt` SET TAGS ('dbx_business_glossary_term' = 'Naphtha Feedstock Input (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `power_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electrical Power Consumption (Megawatt Hours)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `propane_input_mt` SET TAGS ('dbx_business_glossary_term' = 'Propane Feedstock Input (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `propylene_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Propylene Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `pyrolysis_gasoline_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Pyrolysis Gasoline Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `steam_consumption_mt` SET TAGS ('dbx_business_glossary_term' = 'Steam Utility Consumption (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `toluene_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Toluene Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `total_feedstock_input_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Feedstock Input (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `total_product_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Total Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `unaccounted_loss_mt` SET TAGS ('dbx_business_glossary_term' = 'Unaccounted Loss (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `variance_mt` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Variance (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Mass Balance Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `variance_root_cause` SET TAGS ('dbx_business_glossary_term' = 'Variance Root Cause Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ALTER COLUMN `xylene_output_mt` SET TAGS ('dbx_business_glossary_term' = 'Xylene Product Output (Metric Tons)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `catalyst_record_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Record Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `catalyst_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Master Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Contractor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Petrochemical Plant Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Event Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Supplier Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `previous_catalyst_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `activity_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Activity Level Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Batch Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `catalyst_grade` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `catalyst_type` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Type');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `current_age_days` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Current Age in Days');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `deactivation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Deactivation Mechanism');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `deactivation_mechanism` SET TAGS ('dbx_value_regex' = 'coking|poisoning|sintering|fouling|attrition|thermal_degradation');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `deactivation_rate_pct_per_day` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Deactivation Rate Percentage (Pct) Per Day');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Disposal Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Disposal Method');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|reclamation|recycling|hazardous_waste_disposal');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `expected_life_months` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Expected Life in Months');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `last_regeneration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Catalyst Regeneration Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `loaded_quantity` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Loaded Quantity');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `loading_date` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Loading Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `loading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Loading Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `metal_content_ppm` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Metal Content in Parts Per Million (PPM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `next_regeneration_date` SET TAGS ('dbx_business_glossary_term' = 'Next Planned Catalyst Regeneration Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `norm_activity_level_bq` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Activity Level in Becquerels (Bq)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `norm_classification` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Classification');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `norm_classification` SET TAGS ('dbx_value_regex' = 'non_norm|norm_low|norm_medium|norm_high');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Quantity Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|mt|lb|ton');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Record Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Record Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|loaded|regenerating|deactivated|disposed|retired');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `regeneration_count` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Regeneration Count');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Record Remarks');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `selectivity_pct` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Selectivity Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `surface_area_m2_per_g` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Surface Area in Square Meters Per Gram (m²/g)');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Total Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Unit Cost');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Work Order Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` SET TAGS ('dbx_association_edges' = 'petrochemical.turnaround_event,asset.work_order');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `turnaround_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Work Order Assignment ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Work Order - Petrochemical Turnaround Event Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Work Order - Work Order Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `cost_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `planned_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ALTER COLUMN `work_scope_category` SET TAGS ('dbx_business_glossary_term' = 'Work Scope Category');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` SET TAGS ('dbx_association_edges' = 'petrochemical.plant,venture.partner');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `plant_ownership_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Ownership Interest ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Ownership Interest - Petchem Plant Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Ownership Interest - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `cost_center_allocation` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Allocation');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `interest_status` SET TAGS ('dbx_business_glossary_term' = 'Interest Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `participation_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Participation Agreement Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` SET TAGS ('dbx_association_edges' = 'petrochemical.product_catalog,venture.partner');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `product_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Product Entitlement Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Entitlement - Petchem Product Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Product Entitlement - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `delivery_point_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Preference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Effective Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `entitlement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Percentage');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Expiry Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `maximum_offtake_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Offtake Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `minimum_offtake_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Offtake Volume');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `nomination_priority` SET TAGS ('dbx_business_glossary_term' = 'Nomination Priority');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `offtake_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Offtake Rights Indicator');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `quality_specification_ref` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` SET TAGS ('dbx_association_edges' = 'petrochemical.product_catalog,customer.customer_counterparty');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `petrochemical_product_approval_id` SET TAGS ('dbx_business_glossary_term' = 'petrochemical_product_approval Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `customer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Product Approval - Customer Counterparty Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `product_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Product Approval Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `product_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Product Approval - Petchem Product Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `approved_grade` SET TAGS ('dbx_business_glossary_term' = 'Approved Product Grade');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `approved_volume_bopd` SET TAGS ('dbx_business_glossary_term' = 'Approved Volume Barrels Per Day');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `regulatory_approval_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ALTER COLUMN `technical_qualification_ref` SET TAGS ('dbx_business_glossary_term' = 'Technical Qualification Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` SET TAGS ('dbx_association_edges' = 'petrochemical.conversion_unit,asset.integrity_program');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `unit_integrity_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Integrity Enrollment Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `conversion_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Unit Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `integrity_program_id` SET TAGS ('dbx_business_glossary_term' = 'Integrity Program Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `inspection_interval_override_months` SET TAGS ('dbx_business_glossary_term' = 'Inspection Interval Override');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `modified_date` SET TAGS ('dbx_business_glossary_term' = 'Modified Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `program_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ALTER COLUMN `risk_category_override` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Override');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` SET TAGS ('dbx_association_edges' = 'petrochemical.plant,logistics.carrier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `plant_carrier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Carrier Contract ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Carrier Contract - Carrier Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Carrier Contract - Petchem Plant Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `approved_product_types_for_plant` SET TAGS ('dbx_business_glossary_term' = 'Approved Product Types for Plant');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `contract_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `preferred_carrier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier Flag');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ALTER COLUMN `volume_commitment_bbl` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Barrels');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` SET TAGS ('dbx_association_edges' = 'petrochemical.turnaround_event,workforce.contractor');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `turnaround_contractor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Contractor Engagement ID');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Contractor Engagement - Contractor Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `turnaround_event_id` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Contractor Engagement - Petrochemical Turnaround Event Id');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Engagement Contract Value');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `contractor_role` SET TAGS ('dbx_business_glossary_term' = 'Contractor Role');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `demobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Demobilization Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `labor_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Contractor Labor Hours');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `mobilization_date` SET TAGS ('dbx_business_glossary_term' = 'Contractor Mobilization Date');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Contractor Performance Rating');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `safety_incidents` SET TAGS ('dbx_business_glossary_term' = 'Contractor Safety Incidents');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Contractor Scope of Work');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Contractor Work Order Reference');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ALTER COLUMN `catalyst_id` SET TAGS ('dbx_business_glossary_term' = 'Catalyst Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ALTER COLUMN `parent_catalyst_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`optimization_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`optimization_run` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`optimization_run` ALTER COLUMN `optimization_run_id` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`optimization_run` ALTER COLUMN `parent_optimization_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`fractionation_train` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`fractionation_train` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`fractionation_train` ALTER COLUMN `fractionation_train_id` SET TAGS ('dbx_business_glossary_term' = 'Fractionation Train Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`fractionation_train` ALTER COLUMN `parent_fractionation_train_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`allocation_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`allocation_run` SET TAGS ('dbx_subdomain' = 'feedstock_management');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`allocation_run` ALTER COLUMN `allocation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`allocation_run` ALTER COLUMN `parent_allocation_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`calibration_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`calibration_run` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`calibration_run` ALTER COLUMN `calibration_run_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Run Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`calibration_run` ALTER COLUMN `parent_calibration_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_line` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_line` ALTER COLUMN `product_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Line Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_line` ALTER COLUMN `parent_product_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `parent_storage_location_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`storage_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`sample_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`sample_point` SET TAGS ('dbx_subdomain' = 'product_logistics');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`sample_point` ALTER COLUMN `sample_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`sample_point` ALTER COLUMN `parent_sample_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`run_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`run_period` SET TAGS ('dbx_subdomain' = 'process_engineering');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`run_period` ALTER COLUMN `run_period_id` SET TAGS ('dbx_business_glossary_term' = 'Run Period Identifier');
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`run_period` ALTER COLUMN `parent_run_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
